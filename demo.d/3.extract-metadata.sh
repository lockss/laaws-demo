while IFS=$'\t' read -r auid filename ; do
  json="{\"auid\":\"$auid\",\"updateType\":\"full_extraction\"}"
  curl -X POST -H "Content-Type:application/json" -d $json http://localhost:8083/mdupdates
done < "../warcs/auidmap.txt"
