#!/bin/bash


bash $ScriptPath/default_config.sh 
bash $ScriptPath/default_keyFile.sh
#初始化DB
bash $ScriptPath/db_init.sh

echo "" > $0
