# LSTM-Gan for drone trajectory predicting

In this repository we release models from the papers

- [Landing Trajectory Prediction for UAS Based on Generative Adversarial Network](https://arc.aiaa.org/doi/abs/10.2514/6.2023-0127)


## Introduction
![Alt text](https://github.com/Xiaoshan-jun/sganATG/blob/main/paper/figure/training%20process.png)
we introduce a novel approach to landing trajectory prediction for Unmanned Aircraft Systems (UAS) utilizing Generative Adversarial Networks (GANs). In our study, we employ Long Short-Term Memory (LSTM) neural network layers as the core architecture for both the generator and discriminator in our model.
On our drone landing dataset, which comprising over 2600 manually controlled drone trajectories, this method can proficiently predict future trajectories spanning an 10 second duration based on data from the preceding 10 seconds.

![Alt text](https://github.com/Xiaoshan-jun/sganATG/blob/main/paper/figure/GANreal.png)



## Usage
train
```
python train.py
```
test predict, you need to change the args.model_path into the path you saved the model(end with .pt) first
```
python visualization.py 
```
formal evaluation, you need to change the arg.model_path into the path you saved the model(end with .pt) first
```
python evaluate_model.py
```




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




