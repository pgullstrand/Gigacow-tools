import torch
from torch.utils.data import Dataset

class dataset(Dataset):
  def __init__(self,x,y):
    self.x = torch.tensor(x,dtype=torch.float32)
    self.y = torch.tensor(y,dtype=torch.float32)
    self.length = self.x.shape[0]
 
  def __getitem__(self,idx):
    return self.x[idx],self.y[idx]

  def __len__(self):
    return self.length

def binary_acc(y_pred, y_test):
    y_pred_label = torch.round(torch.sigmoid(y_pred))
    correct_pred = (y_pred_label == y_test).sum().float()
    acc = correct_pred/y_test.shape[0]
    return acc