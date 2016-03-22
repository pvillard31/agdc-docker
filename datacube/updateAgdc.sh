cd /root/datacube/agdc/ && rm -rf ./build &&  python setup.py build && python setup.py install
cd /root/datacube/agdc/api/ && rm -rf ./build && python setup.py build && rm -rf /usr/lib/python2.7/site-packages/agdc_api* && python setup.py install

