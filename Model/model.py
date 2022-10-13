import torch
from torch import nn
from torch.nn import functional as F

class CowNet(nn.Module):
    def __init__(
        self, 
        input_size: int = 12,
        output_size: int = 1,
        hidden_size: int = 64,
        dropout: float = 0.5
    ):
        super(CowNet, self).__init__()
        self.hid_1 = nn.Linear(input_size, hidden_size)
        self.hid_2 = nn.Linear(hidden_size, hidden_size)
        self.layer_out = nn.Linear(hidden_size, output_size)

        self.relu = nn.ReLU()
        self.dropout = nn.Dropout(p=dropout)
        self.batchnorm1 = nn.BatchNorm1d(hidden_size)
        self.batchnorm2 = nn.BatchNorm1d(hidden_size)

    def forward(self, x):
        x = self.relu(self.hid_1(x))
        x = self.batchnorm1(x)
        x = self.relu(self.hid_2(x))
        x = self.batchnorm2(x)
        x = self.dropout(x)
        x = self.layer_out(x)
        #x = torch.sigmoid(self.layer_out(x))
        return x