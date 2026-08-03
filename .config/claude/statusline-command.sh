#!/usr/bin/env bash
set -u

readarray -t parts < <(jq -r '
    # Percentage warning for genuinely fixed windows (rate limits).
    def fmt(name; threshold):
      if . == null then empty
      else round as $n |
        if $n >= threshold
        then "\u001b[38;5;167m\(name):\($n)%\u001b[0m"
        else "\(name):\($n)%"
        end
      end;

    # Context warning on ABSOLUTE input tokens, window-independent.
    # Context rot tracks token count, not % of the window, so a % tripwire
    # on a 1M window fires ~10x too late. Single threshold, tunable; rot
    # onset is roughly 50K-130K and is model-dependent (cf. RULER).
    def ctx:
      if . == null then empty
      else (.total_input_tokens // 0) as $t
      | (($t / 1000) | round) as $k
      | if $t >= 120000
        then "\u001b[38;5;167mctx:\($k)K\u001b[0m"
        else "ctx:\($k)K"
        end
      end;

    (.workspace.current_dir // .cwd // ""),
    (.context_window | ctx),
    (.rate_limits.five_hour.used_percentage | fmt("5h";  75)),
    (.rate_limits.seven_day.used_percentage | fmt("7d";  75)),
    (.output_style.name | if . != null and . != "" and . != "default" then . else empty end)
' 2>/dev/null)

dir=${parts[0]-}
parts=("${parts[@]:1}")

if [[ -n $dir ]]; then
  toplevel=$(git -C "$dir" rev-parse --show-toplevel 2>/dev/null)
  seg=${toplevel:-$dir}
  seg=${seg##*/}
  branch=$(git -C "$dir" symbolic-ref --quiet --short HEAD 2>/dev/null) ||
    branch=$(git -C "$dir" rev-parse --short HEAD 2>/dev/null)
  case ${branch:-} in
    '' | main | master) ;;
    *) seg+=" ($branch)" ;;
  esac
  parts+=("$seg")
fi

(( ${#parts[@]} )) || exit 0

printf -v out '%s | ' "${parts[@]}"
printf '%s\n' "${out% | }"
