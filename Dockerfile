FROM python:2.7-alpine

# Install OpenDXL Required Packages
RUN pip install requests
RUN pip install dxlclient

ADD scripts/vars.sh scripts/vars.sh
ADD scripts/common.sh scripts/common.sh
ADD scripts/bootstrap.sh scripts/bootstrap.sh

RUN scripts/bootstrap.sh

