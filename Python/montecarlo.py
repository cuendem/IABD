import numpy as np
import pandas as pd
import time
import math

# Calculate the value of Pi using the Monte Carlo method
def calculate_pi(samples: list) -> pd.DataFrame:
    results = []

    for sample in samples:
        start_time = time.perf_counter()
        inside_circle = 0

        for _ in range(sample):
            x, y = np.random.uniform(0, 1, 2)
            if x**2 + y**2 <= 1:
                inside_circle += 1

        pi_estimate = (inside_circle / sample) * 4
        elapsed_time = time.perf_counter() - start_time
        diff = abs(pi_estimate - math.pi)

        results.append({
            "epochs": sample,
            "pi_estimate": pi_estimate,
            "difference": diff,
            "time_seconds": elapsed_time
        })

    return pd.DataFrame(results)

if __name__ == "__main__":
    samples = [10, 50, 100, 500, 1000, 10000, 100000, 1000000, 10000000, 100000000]
    dataframe = calculate_pi(samples)
    print(dataframe)

#       epochs  pi_estimate  difference  time_seconds
# 0         10     3.200000    0.058407      0.000074
# 1         50     3.280000    0.138407      0.000110
# 2        100     3.160000    0.018407      0.000215
# 3        500     3.200000    0.058407      0.001072
# 4       1000     3.144000    0.002407      0.002144
# 5      10000     3.144800    0.003207      0.024305
# 6     100000     3.142800    0.001207      0.235733
# 7    1000000     3.141720    0.000127      2.283398
# 8   10000000     3.142774    0.001181     22.529483
# 9  100000000     3.141621    0.000029    221.227986