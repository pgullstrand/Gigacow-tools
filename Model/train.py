from pathlib import Path
from statistics import mode
import pandas as pd
from sklearn.model_selection import train_test_split
import numpy as np


import torch
from torch import nn
from torch.nn import functional as F
from torch.utils.data import DataLoader

from model import CowNet
from utils import dataset, binary_acc

dataDir = Path.cwd().parent.parent/'Data/processed'
cow_dataset = pd.read_csv(dataDir/'cow_dataset.csv')
data_x = cow_dataset.iloc[:, :12]
data_y = cow_dataset.iloc[:, 12]

# set up hyper-parameters
learning_rate = 0.003
epoch = 200
device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")
torch.autograd.set_detect_anomaly(True) 

# split the dataset into train and test data
X_train, X_test, y_train, y_test = train_test_split(data_x, data_y, test_size=0.2, random_state=50)
X_train = X_train.to_numpy()
X_test = X_test.to_numpy()
y_train = y_train.to_numpy()
y_test = y_test.to_numpy()
train_data = dataset(X_train, y_train)
test_data = dataset(X_test, y_test)
train_loader = DataLoader(train_data, batch_size=64, shuffle=True)
test_loader = DataLoader(test_data, batch_size=64, shuffle=True)

# initiate model for training
model = CowNet(input_size=X_train.shape[1])
model.to(device)
optimizer = torch.optim.Adam(model.parameters(), lr=learning_rate)
loss_fn = nn.BCEWithLogitsLoss()

model.train()
for e in range(1, epoch+1):
    epoch_loss = 0
    epoch_acc = 0
    for X_batch, y_batch in train_loader:
        X_batch, y_batch = X_batch.to(device), y_batch.to(device)
        optimizer.zero_grad()
        X_batch.float()
        y_batch.float()
        y_pred = model(X_batch)

        loss = loss_fn(y_pred, y_batch.reshape(-1, 1))
        acc = binary_acc(y_pred, y_batch.reshape(-1, 1))

        loss.backward()
        optimizer.step()
        epoch_loss += loss.item()
        epoch_acc += acc.item()
    
        
    print(f'Epoch {e+0:03}: | Loss: {epoch_loss/len(train_loader):.5f} | Acc: {epoch_acc/len(train_loader):.3f}')

