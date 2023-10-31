import numpy as np
import matplotlib.pyplot as plt
import pandas as pd


plt.rcParams['font.family'] = 'Times New Roman'

params = {
    "H": {
        "λ": 0.99,
        "τ": 0.000001,
        "α": 0.7,
        "γ": 0.3,
        "δ": 0.2,
        "ε": 0.2
    },
    "M": {
        "λ": 0.95,
        "τ": -0.000001,
        "α": 0.6,
        "γ": 0.2,
        "δ": 0.1,
        "ε": 0.15
    },
    "L": {
        "λ": 0.88,
        "τ": -0.00001,
        "α": 0.35,
        "γ": 0.15,
        "δ": 0.1,
        "ε": 0.1
    }
}


ranges = {
    "H": [8, 11],
    "M": [4, 8],
    "L": [0, 4]
}


transaction_count = 10000

init_levels = ["H", "M", "L"]
init_RPs = [10, 5, 1]
markers = ['o', 's', '*']

plt.figure(figsize=(12,8))

for level_0, RP_0, marker in zip(init_levels, init_RPs, markers):
    RP_values = [RP_0]
    level_values = [level_0]

    for transaction in range(1, transaction_count + 1):
        previous_level = level_values[-1]
        previous_RP = RP_values[-1]
        
        params_for_level = params[previous_level]

       
        λ = params_for_level["λ"]
        τ = params_for_level["τ"]
        α = params_for_level["α"]
        γ = params_for_level["γ"]
        δ = params_for_level["δ"]
        ε = params_for_level["ε"]
        '''
        DQ = np.random.randint(0, 4)
        OT = np.random.randint(0, 4)
        DS = np.random.randint(0, 4)
        DI = np.random.randint(0, 4)
        '''
        DQ = np.random.randint(4, 8)
        OT = np.random.randint(4, 8)
        DS = np.random.randint(4, 8)
        DI = np.random.randint(4, 8)
        
        '''
        DQ = np.random.randint(8, 11)
        OT = np.random.randint(8, 11)
        DS = np.random.randint(8, 11)
        DI = np.random.randint(8, 11)
        '''

        RP = λ * previous_RP * np.exp(τ * transaction) + (1 - λ) * (
                α * DQ + γ * OT + δ * DS + ε * DI)

        if RP > 10:
            RP = 10

    
        current_level = None
        for level, range_values in ranges.items():
            if range_values[0] <= RP < range_values[1]:
                current_level = level
                break

       
        RP_values.append(RP)
        level_values.append(current_level)

    window_size = 15
    mean_series = pd.Series(RP_values).rolling(window=window_size).mean()

  
    plt.plot(
        range(transaction_count + 1),
        RP_values,
        label=f"{level_0}",
        linewidth=2,
        markevery=0.3,
        markersize=15,
        marker=marker,  
    )
    plt.plot(
        range(transaction_count + 1),
        mean_series,
        linestyle='--',
        label=f"{level_0}-Average Credit",
        linewidth=2,
        markevery=0.2,
        markersize=15,
        marker=marker, 
    )

plt.xticks(fontsize=23)
plt.yticks(fontsize=23)
plt.xlabel("Transaction Count", fontsize=23)  
plt.ylabel("Credit Value", fontsize=23)  
plt.xlim(left=0)
plt.ylim(0, 10)
plt.axhline(0, color='black', linewidth=0.5)
plt.axvline(0, color='black', linewidth=0.5)
plt.legend(loc='upper right', fontsize=17)
plt.grid()
plt.show()
