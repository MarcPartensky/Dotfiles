#!/usr/bin/env bash

export C21_DUMP_PATH="$HOME/Downloads/pickup/dump"
[[ -d $C21_DUMP_PATH ]] || mkdir -p $C21_DUMP_PATH

alias dmongodump="docker run --network host -v $C21_DUMP_PATH:/srv --rm --entrypoint mongodump mongo"
alias dmongorestore="docker run --network host -v $C21_DUMP_PATH:/srv --rm --entrypoint mongorestore mongo"
c21_mongo_params=(--host srvlh-mdb-b1.paris.pickup.local:45000 --db colis21_events --gzip -u hprod_RO -p Iv8E2k4Ptu7icBlRaq5A --authenticationDatabase admin)
octopus_mongo_params=(--host srvlh-mdb-b2.paris.pickup.local:45014 --db kraken --gzip -u hprod_RO -p Iv8E2k4Ptu7icBlRaq5A --authenticationDatabase admin)
tia21_mongo_params=(--host srvlh-mdb-b1.paris.pickup.local:45004 --db kraken --gzip -u hprod_RO -p Iv8E2k4Ptu7icBlRaq5A --authenticationDatabase admin)

dumpc21() {
	dmongodump $c21_mongo_params[@] --archive=/srv/colis21_events_dump_$TIMESTAMP.bzip
}
dumptia21() {
	dmongodump $tia21_mongo_params[@] --archive=/srv/kraken_dump_$TIMESTAMP.bzip
}
dumpoctopus() {
	dmongodump $octopus_mongo_params[@] --archive=/srv/octopus_dump_$TIMESTAMP.bzip
}
dumpc21local() {
	dmongodump --db colis21_events --gzip --archive=/srv/colis21_events_dump_backup_$TIMESTAMP.bzip
}
dumptia21local() {
	dmongodump --db kraken --gzip --archive=/srv/kraken_dump_backup_$TIMESTAMP.bzip
}
restorec21() {
    dmongorestore --gzip --archive=/srv/colis21_events_dump_$TIMESTAMP.bzip
}
restoretia21() {
    dmongorestore --gzip --archive=/srv/kraken_dump_$TIMESTAMP.bzip
}
restoreoctopus() {
    dmongorestore --gzip --archive=/srv/octopus_dump_$TIMESTAMP.bzip
}
restore() {
    dmongorestore --gzip --archive=/srv/$1 --drop
}

updatec21tia21() {
	TIMESTAMP=$(timestamp)
	echo Backing up local mongo
	echo Dumping local colis21 test-v for backup
	dumpc21local
	echo Dumping local kraken test-v for backup
	dumptia21local
	echo Dumping remote kraken test-v
	dumptia21
	echo Dumping remote colis21 test-v
	dumpc21
	read -rsp $'Press any key to continue...\n' -n1 key
	echo Restoring local tia21
	restoretia21
	echo Restoring local colis21
	restorec21
}

updatec21octopus() {
	TIMESTAMP=$(timestamp)
	echo Backing up local mongo
	echo Dumping local colis21 test-v for backup
	dumpc21local
	echo Dumping local kraken test-v for backup
	dumpoctopuslocal
	echo Dumping remote kraken test-v
	dumpoctopus
	echo Dumping remote colis21 test-v
	dumpc21
	read -rsp $'Press any key to continue...\n' -n1 key
	echo Restoring local tia21
	restoreoctopus
	echo Restoring local colis21
	restorec21
}


updatec21() {
	echo Backing up local mongo
	TIMESTAMP=$(timestamp)
	echo Dumping local c21 for backup
	dumpc21local
	echo Dumping remote c21 test-v
	dumpc21
	echo Restoring local c21
	restorec21
}
updatetia21() {
	echo Backing up local mongo
	TIMESTAMP=$(timestamp)
	echo Dumping local kraken test-v for backup
	dumptia21local
	echo Dumping remote kraken test-v
	dumptia21
	echo Restoring local tia21
	restoretia21
}
updateoctopus() {
	echo Backing up local mongo
	TIMESTAMP=$(timestamp)
	echo Dumping local kraken test-v for backup
	dumptia21local
	echo Dumping remote kraken test-v
	dumpoctopus
	echo Restoring local tia21
	restoreoctopus
}

