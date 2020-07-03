set -e

# Set the defaults
DEFAULT_RES="1280x1024x24"
DEFAULT_DISPLAY=":99"
RES=${RES:-$DEFAULT_RES}
DISPLAY=${DISPLAY:-$DEFAULT_DISPLAY}

# Start Xvfb
echo -e "Starting Xvfb on display ${DISPLAY} with res ${RES}"
Xvfb ${DISPLAY} -ac -screen 0 ${RES} -nolisten tcp&
export DISPLAY=${DISPLAY}

robot --variable BROWSER:headlesschrome --outputdir results tests

# Stop Xvfb
kill -9 $(pgrep Xvfb)
