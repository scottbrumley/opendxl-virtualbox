FROM python:2.7-alpine

# Install OpenDXL Required Packages
RUN pip install requests && pip install dxlclient



