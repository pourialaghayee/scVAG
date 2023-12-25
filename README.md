# scVAG: Unified Single-Cell Clustering via Variational-Autoencoder Integration with Graph Attention Autoencoder

<p style="text-align: justify;">
scVAG is an innovative framework that integrates Variational Autoencoder (VAE) and Graph Attention Autoencoder (GATE) models for enhanced analysis of single-cell gene expression data. Built upon the scGAC architecture, scVAG replaces linear PCA with nonlinear dimensionality reduction to improve clustering performance. Through comparative evaluation on 14 datasets, scVAG demonstrates greater robustness and clustering precision compared to previous state-of-the-art methods. 
</p>

## Table of Contents
- [Installation](#installation)
- [Dependencies](#dependencies)
- [Datasets](#datasets)
- [Usage](#usage)
- [Features](#features)
- [Contributing](#contributing)
- [License](#license)
- [Acknowledgments](#acknowledgments)

## Installation

To get started with scVAG, you can clone the repository using the following command:

```bash
git clone https://github.com/pourialaghayee/scVAG.git
```
<p style="text-align: justify;">
This will create a local copy of the project on your machine. Make sure you have Git installed before running the command.
</p>

<p style="text-align: justify;">
After cloning, you can navigate to the project directory and follow any additional setup or installation instructions provided in the project's documentation.
</p>

## Dependencies

Make sure you have the following packages installed:

- [Python](https://www.python.org/) - Version 3.6.4
- [Torch](https://pytorch.org/) - Version 1.10.1
- [Tensorflow](https://www.tensorflow.org/) - Version 1.12.0
- [Keras](https://keras.io/) - Version 2.1.0
- [Numpy](https://numpy.org/) - Version 1.19.5
- [Scipy](https://www.scipy.org/) - Version 1.5.4
- [Pandas](https://pandas.pydata.org/) - Version 1.1.5
- [Scikit-learn (Sklearn)](https://scikit-learn.org/) - Version 0.24.2

## Datasets
<p style="text-align: justify;">
The scVAG project utilizes several datasets for experimentation and testing. You can download the original datasets from the following links:
</p>

- **Biase Dataset:**
  - [Download Biase Dataset](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE57249)

- **Klein Dataset:**
  - [Download Klein Dataset](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE65525)

- **Romanov Dataset:**
  - [Download Romanov Dataset](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE74672)

- **Zeisel Dataset:**
  - [Download Zeisel Dataset](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE60361)

- **Chung Dataset:**
  - [Download Chung Dataset](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE75688)

- **PBMC Dataset:**
  - [Download PBMC Dataset](https://support.10xgenomics.com/single-cell-gene-expression/datasets/2.1.0/pbmc4k)

- **Neuron_5k Dataset:**
  - [Download Neuron_5k Dataset](https://cf.10xgenomics.com/samples/cell-exp/6.0.0/SC3_v3_NextGem_DI_Neurons_5K_SC3_v3_NextGem_DI_Neurons_5K/SC3_v3_NextGem_DI_Neurons_5K_SC3_v3_NextGem_DI_Neurons_5K_web_summary.html)

- **Mouse Dataset:**
  - [Download Mouse Dataset](https://figshare.com/s/865e694ad06d5857db4b)

- **Petropoulos Dataset:**
  - [Download Petropoulos Dataset](https://www.ebi.ac.uk/biostudies/arrayexpress/studies/E-MTAB-3929)

- **Mouse_Brain Dataset:**
  - [Download Mouse_Brain Dataset](https://www.10xgenomics.com/resources/datasets/mouse-tissue-microarray-in-3x3-layout-with-2-mm-edge-to-edge-spacing-ffpe-2-standard)

- **Bjorklund Dataset:**
  - [Download Bjorklund Dataset](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE70580)

- **Human_TBNK_Antibody Dataset:**
  - [Download Human_TBNK_Antibody Dataset](https://www.10xgenomics.com/resources/datasets/1-k-human-pbm-cs-with-total-seq-b-human-tbnk-antibody-cocktail-3-lt-v-3-1-3-1-low-6-0-0)

- **Adult_Mouse_Heart_5k Dataset:**
  - [Download Adult_Mouse_Heart_5k Dataset](https://www.10xgenomics.com/resources/datasets/5k-adult-mouse-heart-nuclei-isolated-with-chromium-nuclei-isolation-kit-3-1-standard)

- **Human_PBMCs_500 Dataset:**
  - [Download Human_PBMCs_500 Dataset](https://www.10xgenomics.com/resources/datasets/500-human-pbm-cs-3-lt-v-3-1-chromium-x-3-1-low-6-1-0)

Please refer to the respective dataset links for more details about each dataset and its usage in the scVAG project.

## Usage

### Preprocessing

For preprocess.py to work, you must specify the address of the dataset. for example,

```bash
# Example command or code snippet
python preprocess.py Chung
```
After preprocessing, a file named data.tsv is generated to store the processed data. This file serves as input for both the Variational Autoencoder (VAE) and the graph construction stages in the scVAG pipeline.

### Run VAE

For VAE to work, you must specify the address of the dataset. for example,

```bash
# Example command or code snippet
python VAE.py Chung
```
The /results folder exclusively holds the vae.csv file, capturing the intermediate output from the initial VAE encoding phase. This file stores the latent representation extracted by the Variational Autoencoder, crucial for subsequent stages.

### Run GATE (Finall part)

For GATE section to work, you must specify the address of the dataset and the number of clusters. for example,

```bash
# Example command or code snippet
python run_scVAG.py Chung 5
```
The /results folder contains text files with the predicted clustering outputs for each dataset. The files follow the naming convention pred_<dataset_name>.txt - for example, the predicted clusters for the mouse_brain dataset are in pred_mouse_brain.txt. These files allow examination of the specific cluster assignments predicted by the model across different datasets.


## Features

- **Combines Strengths:**
  - Combines strengths of Variational Autoencoders (VAEs) and graph neural networks to leverage their respective advantages.

- **Robust Latent Space Encoding:**
  - Enables robust latent space encoding specifically tuned for single-cell data, enhancing the representation of complex biological structures.

- **State-of-the-Art Clustering:**
  - Achieves state-of-the-art clustering accuracy across diverse datasets, showcasing the effectiveness of the proposed approach.

- **Generalizable Approach:**
  - Generalizable approach applicable to a variety of single-cell experiments, providing flexibility and utility across different biological contexts.


## Contributing
Explain how others can contribute to your project.

## License

MIT License

Copyright (c) 2023 pouria_laghaee
<p style="text-align: justify;">
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
<p>

**The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.**
<p style="text-align: justify;">
THE SOFTWARE IS PROVIDED "AS IS," WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE, AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES, OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT, OR OTHERWISE, ARISING FROM,
OUT OF, OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
<p>


## Acknowledgments
Give credit to any resources, libraries, or individuals you want to acknowledge.

