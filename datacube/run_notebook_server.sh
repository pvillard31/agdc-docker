#!/bin/sh

jupyter notebook --port=8888 --no-browser --ip=0.0.0.0 > /var/log/notebook.log 2>&1 &


