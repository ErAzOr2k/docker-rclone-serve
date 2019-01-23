#!/bin/sh

function term_handler {
  kill -SIGTERM ${!}
  echo "sending SIGTERM to child pid"
  echo "exiting now"
  exit $?
}

if [ -z "${REMOTE}" ]; then
  echo "No remote specified!"
fi

trap term_handler SIGINT SIGTERM

while true
do
  rclone --config /config/rclone.conf serve $PROTOCOL "$REMOTE" $OPTIONS & wait ${!}
  echo "rclone crashed at: $(date +%Y.%m.%d-%T)"
done

exit 144
