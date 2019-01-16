set -o errexit \
  -o noclobber \
  -o nounset \
  -o pipefail

readonly EXEC_PATH=$(realpath "$0")
readonly SCRIPT_NAME=$(basename "$EXEC_PATH")
readonly SCRIPT_DIR=$(dirname "$EXEC_PATH")
readonly REPO_ROOT=$(realpath "$SCRIPT_DIR/..")
readonly BIN_DIR="$REPO_ROOT/bin"
readonly LIB_DIR="$REPO_ROOT/lib"
readonly PROFILE_DIR="$REPO_ROOT/profile"
