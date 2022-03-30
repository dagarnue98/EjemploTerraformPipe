# ---------------------------------------------------------------------------------------------------------------------
# RUN TERRAGRUNT APPLY-ALL, OUTPUT THE PLAN TO THE TERMINAL AND TO A LOG FILE
# ---------------------------------------------------------------------------------------------------------------------

#!/usr/bin/env bash
set -euo pipefail



# Run apply all and display output both to terminal and the log file temp.log
terragrunt run-all destroy --terragrunt-non-interactive


