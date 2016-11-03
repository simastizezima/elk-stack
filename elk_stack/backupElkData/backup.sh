TO_FOLDER=/root/elk_stack/backup
FROM=/usr/share/elasticsearch
DATE=`date +%Y-%m-%d_%H-%M`
TO=$TO_FOLDER/$DATE/
echo "rsync from $FROM to $TO"

rsync -a $FROM $TO

$SCRIPTS/es-flush-disable.sh true
$SCRIPTS/es-flush.sh

rsync -a $FROM $TO

$SCRIPTS/es-flush-disable.sh false

rm -rf `find $TO_FOLDER -maxdepth 1 -mtime +7` &> /dev/null
