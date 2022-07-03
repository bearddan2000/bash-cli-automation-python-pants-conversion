#! /bin/bash

d=$1
e=$d/bin

if [[ -e $e ]]; then
  #crewte application folder inside project foldre
  mkdir $d/cli

  #copy bin to application folder
  mv $e/* $d/cli

  #copy over pants requirements to
  #application requirements file
  cat .src/requirements.txt >> $d/cli/requirements.txt

  #pants also requires constraints file
  #constraints.txt is a simple copy of requirements.txt
  cp $d/cli/requirements.txt $d/cli/constraints.txt

  #copy over all pants files to project bin
  #there are folders so use -R
  cp -R .src/build/* $e

  #move application folder
  #to project bin folder
  mv $d/cli $e

fi
