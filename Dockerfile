##
# Dockerfile for MNAP
# MNAP code created by: Anticevic Lab, Yale University and Mind and Brain Lab, University of Ljubljana
# Maintainer of Dockerfile: Zailyn Tamayo, Yale University
##

##
# Tag: ztamayo/mnap_deps1:latest
# Dockerfile 1 for dependencies needed to run MNAP suite
# Installs dependencies Python (+pkgs), R (+pkgs), Octave (+pkgs), and workbench
##

FROM ztamayo/mnap_deps0:latest 



RUN apt-get update && \
    apt-get install -yq --no-install-recommends pkg-config \
                                                tree \
                                                vim \
                                                zip

# Install Python 2.7
RUN apt-get install --no-install-recommends -y python2.7-dev && \
    apt-get install --no-install-recommends -y python-pip build-essential && \
    pip install --upgrade virtualenv && \
    pip install --upgrade setuptools

# Install Python packages
RUN pip install numpy pydicom scipy nibabel

# Install Octave and R
RUN apt-get install -yq --no-install-recommends --allow-unauthenticated r-base \
                                                                        octave 

# Install R package
RUN echo "r <- getOption('repos'); r['CRAN'] <- 'http://cran.us.r-project.org'; options(repos = r);" > ~/.Rprofile
RUN Rscript -e "install.packages('ggplot2')"


# Install Octave packages
RUN apt-get install -yq --no-install-recommends octave-general \
                                                octave-control \
                                                octave-image \
                                                octave-nan \
                                                octave-signal \
                                                octave-io \
                                                octave-statistics \
                                                octave-miscellaneous \
                                                octave-struct \
                                                octave-optim 

# Install workbench
RUN apt-get install -yq --no-install-recommends --allow-unauthenticated connectome-workbench

# Clear apt cache and other empty folders
USER root
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /boot /media /mnt /srv && \
    rm -rf ~/.cache/pip

CMD ["bash"]