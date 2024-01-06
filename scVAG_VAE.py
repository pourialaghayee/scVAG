import torch
import pandas as pd
import torch.nn as nn
import torch.optim as optim
from torch.nn.utils import clip_grad_norm_
from torch.nn.functional import mse_loss
import numpy as np
from torch.utils.data import DataLoader, TensorDataset

import argparse
parser = argparse.ArgumentParser()
parser.add_argument('dataset_str', type=str, help='name of dataset')
args = parser.parse_args()
dataset_str = args.dataset_str
data_path = 'data/'+dataset_str+'/data.tsv'

data = pd.read_csv(data_path, sep='\t', index_col=0).T
dim1= data.shape[1]
data = torch.tensor(data.values)
data = data.to(torch.float32)
print("Start shape (cells, genes):", data.shape)

# Normalize the data
data_normalized = (data - data.mean()) / data.std()

# Convert the normalized data to a PyTorch dataset
dataset = TensorDataset(data_normalized)

# Define the VAE model
latent_dim = 2048

class VAE(nn.Module):
    def __init__(self):
        super(VAE, self).__init__()

        self.encoder = nn.Sequential(
            nn.Linear(dim1, 8000),
            nn.ReLU(),
            nn.Dropout(0.4),
            nn.Linear(8000, 6000),
            nn.ReLU(),
            nn.Dropout(0.4),
            nn.Linear(6000, 4096),
            nn.ReLU(),
            nn.Dropout(0.4),
            nn.Linear(4096, latent_dim * 2),
            nn.ReLU(),

        )

        self.decoder = nn.Sequential(
            nn.Linear(latent_dim, 4096),
            nn.ReLU(),
            nn.Dropout(0.4),
            nn.Linear(4096, 6000),
            nn.ReLU(),
            nn.Dropout(0.4),
            nn.Linear(6000, 8000),
            nn.ReLU(),
            nn.Dropout(0.4),
            nn.Linear(8000, dim1),
            nn.ReLU()
        )

    def reparameterize(self, mu, logvar):
        std = logvar.mul(0.5).exp_()
        eps = torch.randn_like(std)
        z = eps.mul(std).add_(mu)
        return z

    def forward(self, x):
        x = self.encoder(x)
        mu, logvar = torch.chunk(x, 2, dim=1)
        z = self.reparameterize(mu, logvar)
        x_recon = self.decoder(z)
        return x_recon, mu, logvar

# Create an instance of the VAE model
vae = VAE()

# Set the device to GPU if available
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
vae.to(device)

# Define the reconstruction loss
reconstruction_loss = mse_loss

# Define the optimizer
optimizer = optim.Adam(vae.parameters(), lr=1e-4, weight_decay=1e-5)
# Define gradient clipping threshold
grad_clip_threshold = 1.0

# Define the training loop
num_epochs = 200
batch_size = 64

dataloader = DataLoader(dataset, batch_size=batch_size, shuffle=True)

for epoch in range(num_epochs):
    for batch in dataloader:
        batch = batch[0].to(device)
        optimizer.zero_grad()
        recon_batch, mu, logvar = vae(batch)
        loss = reconstruction_loss(recon_batch, batch)
        loss.backward()
        clip_grad_norm_(vae.parameters(), grad_clip_threshold)  # Apply gradient clipping
        optimizer.step()
    print(f"Epoch [{epoch+1}/{num_epochs}], Loss: {loss.item():.4f}")
    
    
# Evaluate the trained VAE on the data
vae.eval()
with torch.no_grad():
    encoded_data, reduced_data, _ = vae(data_normalized.to(device))
data_np = reduced_data.cpu().numpy()
df = pd.DataFrame(data_np)
df.to_csv('data/'+dataset_str+'/vae.csv', index=False)
print("End shape (cells, features):", df.shape)
print("result stored as vae.csv at dataset folder")