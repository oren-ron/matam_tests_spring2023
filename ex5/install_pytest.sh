#!/bin/sh

curl -sSL https://bootstrap.pypa.io/pip/3.6/get-pip.py -o get-pip.py
python3 get-pip.py
rm get-pip.py
python3 -m pip install pytest