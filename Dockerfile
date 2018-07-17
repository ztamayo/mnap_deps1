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
    apt-get install -yq --no-install-recommends pkg-config && \
    apt-get clean && \
# Install Python 2.7
    apt-get install --no-install-recommends -y python2.7-dev && \
    apt-get install --no-install-recommends -y python-pip build-essential && \
    apt-get clean && \
    pip install --upgrade virtualenv && \
    pip install --upgrade setuptools && \
# Install Python packages
    pip install numpy pydicom scipy nibabel && \
# Install Octave and R
    apt-get install -yq --no-install-recommends --allow-unauthenticated r-base \
                                                                        octave && \
# Install R package
    echo "r <- getOption('repos'); r['CRAN'] <- 'http://cran.us.r-project.org'; options(repos = r);" > ~/.Rprofile && \
    Rscript -e "install.packages('ggplot2')" && \
    apt-get clean && \
# Install Octave packages
    apt-get install -yq --no-install-recommends octave-general \
                                                octave-control \
                                                octave-image \
                                                octave-nan \
                                                octave-signal \
                                                octave-io \
                                                octave-statistics \
                                                octave-miscellaneous \
                                                octave-struct \
                                                octave-optim && \
# Install workbench
    apt-get install -yq --no-install-recommends --allow-unauthenticated connectome-workbench && \
    apt-get clean && \
# Clear apt cache and other empty folders
#USER root
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /boot /media /mnt /srv && \
    rm -rf ~/.cache/pip

CMD ["bash"]