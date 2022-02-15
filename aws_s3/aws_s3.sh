## Average file size in S3 folder
BUCKET_NAME=
BUCKET_FOLDER_PATH=
S3_TEXT_OUTPUT=$(aws s3 ls s3://$BUCKET_NAME/$BUCKET_FOLDER_PATH/ --recursive --human-readable  --summarize)
S3_TOTAL_OBJECTS=$(echo $S3_TEXT_OUTPUT | grep "Total Objects:" | cut -d ":" -f2 | tr -d " ")
S3_TOTAL_SIZE_NUMBER=$(echo $S3_TEXT_OUTPUT | grep "Total Size:" | cut -d ":" -f2 | cut -d " " -f2 | tr -d " ")
S3_TOTAL_SIZE_MESSUREMENT=$(echo $S3_TEXT_OUTPUT | grep "Total Size:" | cut -d ":" -f2 | cut -d " " -f3 | tr -d " ")
AVERAGE_OBJECT_SIZE=$(echo $((S3_TOTAL_SIZE_NUMBER / S3_TOTAL_OBJECTS)) $S3_TOTAL_SIZE_MESSUREMENT)