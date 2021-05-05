FROM ubuntu:20.04

ENV DEBIAN_FRONTEND NONE
ENV MAGIC_TAG 8.3.160

RUN apt-get update
RUN apt-get install -y build-essential git python3 python3-pip

# Setup Magic
RUN apt-get install -y curl tcl-dev tk-dev csh
WORKDIR /tmp/magic
RUN curl -L https://github.com/RTimothyEdwards/magic/archive/refs/tags/${MAGIC_TAG}.tar.gz | tar -xzC /tmp/magic --strip-components=1
RUN ./configure
RUN make -j$(nproc)
RUN make install
WORKDIR /

# Setup Click
RUN python3 -m pip install click

# Copy Others
COPY ./pdk_subset /pdk_subset
COPY ./run_all_drc.py /run_all_drc.py
RUN chmod +x run_all_drc.py
COPY ./run_standard_drc.py /run_standard_drc.py

ENTRYPOINT ["/run_all_drc.py"]