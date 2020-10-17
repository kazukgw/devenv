#!/bin/bash
ZONE=
INSTANCE=devenv
PROJECT=
gcloud beta compute ssh --zone $ZONE $INSTANCE --tunnel-through-iap --project $PROJECT -- 'bash run_devenv.bash'
