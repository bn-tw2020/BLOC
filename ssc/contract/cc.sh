#!/bin/bash

if [ $# -ne 2 ]; then
	echo "Arguments are missing. ex) ./cc.sh instantiate 1.0.0"
	exit 1
fi

instruction=$1
version=$2

set -ev

#chaincode install
docker exec cli peer chaincode install -n ssc -v $version -p github.com/ssc
#chaincode instatiate
docker exec cli peer chaincode $instruction -n ssc -v $version -C mychannel -c '{"Args":[]}' -P 'OR("Org1MSP.member", "Org2MSP.member")'
sleep 3
#chaincode invoke user1
docker exec cli peer chaincode invoke -n ssc -C mychannel -c '{"Args":["initLedger"]}'
sleep 3
#chaincode query user1
docker exec cli peer chaincode invoke -n ssc -C mychannel -c '{"Args":["setCard", "did:sov:77777Qa2TiPmNkDKhNVc9n", "10","0","2020-11-28 13:13:13"]}' 
sleep 3
#chaincode invoke add rating
docker exec cli peer chaincode query -n ssc -C mychannel -c '{"Args":["getCard","did:sov:77777Qa2TiPmNkDKhNVc9n"]}'
sleep 3
docker exec cli peer chaincode invoke -n ssc -C mychannel -c '{"Args":["updateCard","did:sov:77777Qa2TiPmNkDKhNVc9n","2020-11-30 33:33:33"]}'
echo '-------------------------------------END-------------------------------------'