#!/bin/bash
jupyter notebook --port 4200 --allow-root --no-browser --NotebookApp.token='' --NotebookApp.password='' --ip=0.0.0.0 2>&1 &

bash $@