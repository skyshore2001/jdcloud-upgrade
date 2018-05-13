#!/bin/sh

export P_METAFILE=META.md
export P_DB=localhost/jdcloud
export P_DBCRED=demo:demo123

php upgrade.php $@
