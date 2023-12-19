#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Apr  5 13:28:27 2021
draw results
@author: jun
"""
import argparse
import os
import torch

from attrdict import AttrDict
from statistics import variance
from sgan.data.loader import data_loader
from sgan.models import TrajectoryGenerator, TrajectoryDiscriminator
from sgan.losses import displacement_error, final_displacement_error
from sgan.utils import relative_to_abs, get_dset_path

import matplotlib.pyplot as plt
import random
import numpy as np


parser = argparse.ArgumentParser()
parser.add_argument('--model_path', default = 'models/real', type=str)
parser.add_argument('--dataset_name', default='real', type=str)
parser.add_argument('--delim', default='tab')
parser.add_argument('--loader_num_workers', default=0, type=int)
parser.add_argument('--obs_len', default=10, type=int)
parser.add_argument('--pred_len', default=10, type=int)
parser.add_argument('--skip', default=1, type=int)
# Optimization
parser.add_argument('--batch_size', default=1, type=int)

def get_generator(checkpoint):
    args = AttrDict(checkpoint['args'])
    generator = TrajectoryGenerator(
        obs_len=args.obs_len,
        pred_len=args.pred_len,
        embedding_dim=args.embedding_dim,
        encoder_h_dim=args.encoder_h_dim_g,
        decoder_h_dim=args.decoder_h_dim_g,
        mlp_dim=args.mlp_dim,
        num_layers=args.num_layers,
        noise_dim=args.noise_dim,
        noise_type=args.noise_type,
        noise_mix_type=args.noise_mix_type,
        pooling_type=args.pooling_type,
        pool_every_timestep=args.pool_every_timestep,
        dropout=args.dropout,
        bottleneck_dim=args.bottleneck_dim,
        neighborhood_size=args.neighborhood_size,
        grid_size=args.grid_size,
        batch_norm=args.batch_norm)
    #generator.load_state_dict(checkpoint['g_state'])
    generator.cuda()
    generator.train()
    return generator

def get_discriminator(checkpoint):
    args = AttrDict(checkpoint['args'])
    discriminator = TrajectoryDiscriminator(
        obs_len=args.obs_len,
        pred_len=args.pred_len,
        embedding_dim=args.embedding_dim,
        h_dim=args.encoder_h_dim_d,
        mlp_dim=args.mlp_dim,
        num_layers=args.num_layers,
        dropout=args.dropout,
        batch_norm=args.batch_norm,
        d_type=args.d_type)
    discriminator.load_state_dict(checkpoint['d_state'])
    discriminator.cuda()
    discriminator.train()
    return discriminator

def generateFake(args, loader, generator):
    total_traj = 0
    with torch.no_grad():
        p = []
        dx = []
        dy = []
        dz = []
        for batch in loader:
            batch = [tensor.cuda() for tensor in batch]
            (obs_traj, pred_traj_gt, obs_traj_rel, pred_traj_gt_rel,
             non_linear_ped, loss_mask, seq_start_end) = batch
            #print(obs_traj.shape)
            
            pred_traj_fake_rel = generator(
                    obs_traj, obs_traj_rel, seq_start_end
                )
            pred_traj_fake = relative_to_abs(
                    pred_traj_fake_rel, obs_traj[-1]
                )
            #p.cpu()
            pred_traj_fake = pred_traj_fake.cpu().numpy().reshape( 10,3)
            #pred_traj_fake = np.transpose(pred_traj_fake)
            obs_trajp = obs_traj.cpu().numpy().reshape(10,3)
            pred_traj_gtp = pred_traj_gt.cpu().numpy().reshape(10,3)
            print(pred_traj_gtp)
            fig = plt.figure(figsize=(8, 6))
            ax = fig.add_subplot(projection='3d')
            ax.set_title('GANs predict linear landing')
            ax.set_xlabel('x')
            ax.set_ylabel('y')
            ax.set_zlabel('z')
            #for i in range(10):
            x = obs_trajp.T[0]
            y = obs_trajp.T[1]
            z = obs_trajp.T[2] 
            ax.scatter(x,y, z, s = 10, label= "observed trajectory", c = 'red')
            ax.scatter(pred_traj_gtp.T[0],pred_traj_gtp.T[1], pred_traj_gtp.T[2], s = 10, label= "real trajectory", c = 'orange')
            ax.scatter(pred_traj_fake.T[0],pred_traj_fake.T[1], pred_traj_fake.T[2], s = 10, label= "predict trajectory", c = 'blue')
            ax.plot(x,y, z, c = 'red')
            ax.plot(pred_traj_gtp.T[0],pred_traj_gtp.T[1], pred_traj_gtp.T[2],  c = 'orange')
            ax.plot(pred_traj_fake.T[0],pred_traj_fake.T[1], pred_traj_fake.T[2],  c = 'blue')
            #print(pred_traj_fake)
            ax.legend()
            #calculate the l2 diff
            ade = []
            diff = pred_traj_fake - pred_traj_gtp
            for i in range(10):
                dx.append(diff[i][0])
                dy.append(diff[i][1])
                dz.append(diff[i][2])
                s = diff[i][0]**2 + diff[i][1]**2 + diff[i][2]**2
                ade.append(s**0.5)
            p.append(ade)
        for i in range(10):
            l = []
            for k in range(100):
                l.append(p[k][i])
            print(str(round(np.mean(l),2)) + '$\pm$' + str(round(variance(l)**0.5,2)))
        np.save('dx.txt', dx)
        np.save('dy.txt', dy)
        np.save('dz.txt', dz)
        return pred_traj_fake, p, ade

# def generateFake(args, loader, generator, discriminator):
#     with torch.no_grad():
#         real = []
#         fake = []
#         for batch in loader:
#             batch = [tensor.cuda() for tensor in batch]
#             (obs_traj, pred_traj_gt, obs_traj_rel, pred_traj_gt_rel,
#              non_linear_ped, loss_mask, seq_start_end) = batch
#             pred_traj_fake_rel = generator(
#                     obs_traj, obs_traj_rel, seq_start_end
#                 )
#             pred_traj_fake = relative_to_abs(
#                     pred_traj_fake_rel, obs_traj[-1]
#                 )
            
#             scores_fake = discriminator(pred_traj_fake, pred_traj_fake_rel, seq_start_end)
#             scores_real = discriminator(pred_traj_gt, pred_traj_gt_rel, seq_start_end)
#             real.append(scores_real.cpu().numpy()[0])
#             fake.append(scores_fake.cpu().numpy()[0])
#             #print('fake scores ', scores_fake.cpu().numpy())
#             #print('real scores ', scores_real.cpu().numpy())
#         print(real)
#         np.mean(real)
#         print(fake)
#         print(str(round(np.mean(real),2)) + '$\pm$' + str(round(np.var(real)**0.5,2)))
#         print(str(round(np.mean(fake),2)) + '$\pm$' + str(round(np.var(fake)**0.5,2)))

#         return scores_real


def main(args):
    
    #load generator

    if os.path.isdir(args.model_path):
            filenames = os.listdir(args.model_path)
            filenames.sort()
            paths = [
                os.path.join(args.model_path, file_) for file_ in filenames
            ]
    else:
            paths = [args.model_path]
    for path in paths:
        checkpoint = torch.load(path)
        generator = get_generator(checkpoint)
        discriminator = get_discriminator(checkpoint)
        
        

       
    vis_path = get_dset_path(args.dataset_name, 'vis')

    _, vis_loader = data_loader(args, vis_path)
    
    #generateFake(args, vis_loader, generator, discriminator)
    
    pred_traj_fake, p, ade = generateFake(args, vis_loader, generator)
    print(p)
    pred_traj_fake = pred_traj_fake.cpu().numpy().reshape(8,3)
    pred_traj_fake = np.transpose(pred_traj_fake)
    print(pred_traj_fake)
    
    
    #plt.savefig('books_read%i.png' %i)
    
if __name__ == '__main__':
    args = parser.parse_args()
    main(args)
    