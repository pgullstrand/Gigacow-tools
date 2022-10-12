from pathlib import Path
import pandas as pd
import numpy as np
from sklearn.metrics import confusion_matrix, classification_report

import torch
from torch import nn
from torch.nn import functional as F
from torch.utils.data import DataLoader

from model import CowNet
from utils import dataset, binary_acc

device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")

# load test dataset
modelDir = Path.cwd()
dataDir = Path.cwd().parent.parent/'Data/processed'
cow_dataset = pd.read_csv(dataDir/'cow_test_dataset.csv')
data_x = cow_dataset.iloc[:, :12]
data_y = cow_dataset.iloc[:, 12]
X_test = data_x.to_numpy()
y_test = data_y.to_numpy()
test_data = dataset(X_test, y_test)
test_loader = DataLoader(test_data, batch_size=64, shuffle=True)

# load the model from the load dir
model = CowNet(input_size=X_test.shape[1])
model.load_state_dict(torch.load(modelDir/'best_model.pt'))
model.to(device)

y_pred_list = []
model.eval()
test_acc = 0
with torch.no_grad():
    for X_batch, y_batch in test_loader:
        X_batch = X_batch.to(device)
        y_batch = y_batch.to(device)
        y_test_pred = model(X_batch)
        #y_test_pred = torch.sigmoid(y_test_pred)
        #y_pred_label = torch.round(y_test_pred)
        #y_pred_list.append(y_pred_label.cpu().numpy())
        acc = binary_acc(y_test_pred, y_batch.reshape(-1, 1))
        test_acc += acc.item()
    test_acc = test_acc/len(test_loader)
print(f'\nTest Accuracy: {test_acc:.3f}')
#y_pred_list = [a.squeeze().tolist() for a in y_pred_list]
#confusion_matrix(y_test, y_pred_list)
#print(classification_report(y_test, y_pred_list))