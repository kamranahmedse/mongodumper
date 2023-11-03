#!/usr/bin/env bash

set -u
set -e
set -o pipefail

echo "Here"

trap "{ printf 'ERROR: caught non-zero exit code\n'; exit 1; }" ERR

TODAY="$(date +%Y%m%d%H%M)"
FILE_NAME="mongodb-backup-${TODAY}.tar.gz"
S3_DEST="s3://${S3BUCKET_PATH}/${FILE_NAME}"

mongodump \
  --archive \
  --gzip \
  --uri="${MONGO_URI}" \
  | aws s3 cp - "${S3_DEST}"

printf "INFO: All done, exiting with code 0\n"
exit 0