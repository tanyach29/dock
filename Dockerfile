FROM continuumio/miniconda3
#directory to application, where all files should be copied

#creating conda env
# make sure cmcc-reactions/enviornment.yml in same folder
#rename even though in same folder?
COPY cmcc_environment.yml .
RUN conda env create -f cmcc_environment.yml

#running conda env
# make sure environment.yml replaced with env name
RUN conda activate environment.yml

# we shouldn't need the rest of this?
#install package
RUN conda pip install rdkit ase chytorch-rxnmap

#not necessary right now
#copy application code to a new directory//create new directory
#COPY ./app .

#set working directory
#WORKDIR /app

#running application
CMD ["python", "app.py"]
