FROM continuumio/miniconda3
#directory to application, where all files should be copied

#creating conda env
# make sure cmcc-reactions/enviornment.yml in same folder
COPY environment.yml .
RUN conda create -n environment.yml -c conda-forge gcc && conda activate environment.yml
RUN conda env create -f environment.yml

#running conda env
# make sure environment.yml replaced with env name
# RUN conda init
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
