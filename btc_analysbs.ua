import matplotlib.pyplot as plt
import yfinance as yf

# Download Bitcoin data from Yahoo Finance
btc_data = yf.download('BTC-USD', start='2023-01-01', end='2024-05-30', progress=False)

# Identify Break of Structure (BoS), Higher High, Higher Low, Lower High, Lower Low
btc_data['Higher High'] = (btc_data['High'] > btc_data['High'].shift(1)) & (btc_data['High'].shift(1) > btc_data['High'].shift(2))
btc_data['Higher Low'] = (btc_data['Low'] > btc_data['Low'].shift(1)) & (btc_data['Low'].shift(1) > btc_data['Low'].shift(2))
btc_data['Lower High'] = (btc_data['High'] < btc_data['High'].shift(1)) & (btc_data['High'].shift(1) < btc_data['High'].shift(2))
btc_data['Lower Low'] = (btc_data['Low'] < btc_data['Low'].shift(1)) & (btc_data['Low'].shift(1) < btc_data['Low'].shift(2))

# Plot the data with the identified points
plt.figure(figsize=(14, 7))
plt.plot(btc_data.index, btc_data['Close'], label='BTC-USD Close Price')
plt.scatter(btc_data[btc_data['Higher High']].index, btc_data[btc_data['Higher High']]['Close'], color='green', marker='^', alpha=1, label='Higher High')
plt.scatter(btc_data[btc_data['Higher Low']].index, btc_data[btc_data['Higher Low']]['Close'], color='blue', marker='^', alpha=1, label='Higher Low')
plt.scatter(btc_data[btc_data['Lower High']].index, btc_data[btc_data['Lower High']]['Close'], color='red', marker='v', alpha=1, label='Lower High')
plt.scatter(btc_data[btc_data['Lower Low']].index, btc_data[btc_data['Lower Low']]['Close'], color='purple', marker='v', alpha=1, label='Lower Low')

plt.title('BTC-USD Price with Higher High, Higher Low, Lower High, Lower Low')
plt.xlabel('Date')
plt.ylabel('Price (USD)')
plt.legend()
plt.grid(True)
plt.show()
