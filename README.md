# LSTM-Gan for drone trajectory predicting

In this repository we release models from the papers

- [Landing Trajectory Prediction for UAS Based on Generative Adversarial Network](https://arc.aiaa.org/doi/abs/10.2514/6.2023-0127)


## Introduction
![Alt text](https://github.com/Xiaoshan-jun/sganATG/blob/main/training%20process.drawio.png)


## Installation

Make sure you have `Python>=3.6` installed on your machine.

Install JAX and python dependencies by running:



## Vision Transformer

by Alexey Dosovitskiy\*†, Lucas Beyer\*, Alexander Kolesnikov\*, Dirk
Weissenborn\*, Xiaohua Zhai\*, Thomas Unterthiner, Mostafa Dehghani, Matthias
Minderer, Georg Heigold, Sylvain Gelly, Jakob Uszkoreit and Neil Houlsby\*†.

(\*) equal technical contribution, (†) equal advising.

![Figure 1 from paper](vit_figure.png)

Overview of the model: we split an image into fixed-size patches, linearly embed
each of them, add position embeddings, and feed the resulting sequence of
vectors to a standard Transformer encoder. In order to perform classification,
we use the standard approach of adding an extra learnable "classification token"
to the sequence.

### Results







## Bibtex

```
@inproceedings{xiang2023landing,
  title={Landing Trajectory Prediction for UAS Based on Generative Adversarial Network},
  author={Xiang, Jun and Xie, Junfei and Chen, Jun},
  booktitle={AIAA SCITECH 2023 Forum},
  pages={0127},
  year={2023}
}

```




