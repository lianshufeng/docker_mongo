#!/bin/bash


bash $ScriptPath/default_config.sh 
bash $ScriptPath/default_keyFile.sh
bash $ScriptPath/default_replSetInitiate.sh
bash $ScriptPath/default_initRootUser.sh


echo "" > $0
