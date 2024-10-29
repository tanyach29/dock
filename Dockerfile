FROM continuumio/miniconda3
#directory to application, where all files should be copied

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get -y install git gcc g++ && \
    rm -rf /var/lib/apt/lists/*

# copy gcc to g++ as a terrible hack
# RUN cp $(which gcc) $(dirname $(which gcc))/g++ && \
#     echo $(which g++)

#creating conda env
# make sure cmcc-reactions/enviornment.yml in same folder
COPY environment.yml .
RUN conda env create -f environment.yml
RUN conda run -n cmcc-rxn pip install git+https://github.com/isayevlab/AIMNet2

#installing default package version
RUN cd /home && \
    git clone https://github.com/Center-for-Mechanical-Control-of-Chem/cmcc-reactions
ENV PYTHONPATH=/home/cmcc-reactions

#configuring AIMNET to work in the default mode
RUN conda run -n cmcc-rxn python -c "import aimnet2calc; calc = aimnet2calc.AIMNet2ASE()"

#running conda env
# make sure environment.yml replaced with env name
#RUN conda init
# RUN conda activate cmcc-rxn

# we shouldn't need the rest of this?
#install package
# RUN conda pip install rdkit ase chytorch-rxnmap

#not necessary right now
#copy application code to a new directory//create new directory
#COPY ./app .

#set working directory
#WORKDIR /app

#running application
ENTRYPOINT ["conda", "run", "--no-capture-output", "-n", "cmcc-rxn"]
