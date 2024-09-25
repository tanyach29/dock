FROM continuumio/miniconda3
#directory to application, where all files should be copied

#creating conda env
COPY environment.yml .
RUN conda env create -f environment.yml

#running conda env
RUN conda activate environment.yml

#install package
RUN conda pip install rdkit ase chytorch-rxnmap #more

#copy application code to a new directory//create new directory
COPY ./app .

#set working directory
WORKDIR /app

#running application
CMD ["python", "app.py"]