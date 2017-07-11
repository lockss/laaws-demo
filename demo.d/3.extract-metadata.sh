echo '{"auid":"org|lockss|plugin|pensoft|oai|PensoftOaiPlugin&au_oai_date~2014&au_oai_set~biorisk&base_url~http%3A%2F%2Fbiorisk%2Epensoft%2Enet%2F","updateType":"full_extraction"}' > biorisk2014-mdus.json
curl -X POST -H "Content-Type:application/json" -d @biorisk2014-mdus.json http://localhost:8083/mdupdates

echo '{"auid":"org|lockss|plugin|hindawi|HindawiPublishingCorporationPlugin&base_url~http%3A%2F%2Fwww%2Ehindawi%2Ecom%2F&download_url~http%3A%2F%2Fdownloads%2Ehindawi%2Ecom%2F&journal_id~ijpg&volume_name~2014","updateType":"full_extraction"}' > ijpg2014-mdus.json
curl -X POST -H "Content-Type:application/json" -d @ijpg2014-mdus.json http://localhost:8083/mdupdates

echo '{"auid":"org|lockss|plugin|atypon|bloomsburyqatar|BloomsburyQatarPlugin&base_url~http%3A%2F%2Fwww%2Eqscience%2Ecom%2F&journal_id~nmejre&volume_name~2014","updateType":"full_extraction"}' > nmejre2014-mdus.json
curl -X POST -H "Content-Type:application/json" -d @nmejre2014-mdus.json http://localhost:8083/mdupdates
