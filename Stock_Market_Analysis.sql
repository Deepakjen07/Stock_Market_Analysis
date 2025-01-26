 CREATE TABLE AAPL_historical_data (
    Date DATE NOT NULL,
    Price_Close DECIMAL(15, 2),
    Price_High DECIMAL(15, 2),
    Price_Low DECIMAL(15, 2),
    Price_Open DECIMAL(15, 2),
    Price_Volume BIGINT,
    PRIMARY KEY (Date)
);

CREATE TABLE MSFT_historical_data (
    Date DATE NOT NULL,
    Price_Close DECIMAL(15, 2),
    Price_High DECIMAL(15, 2),
    Price_Low DECIMAL(15, 2),
    Price_Open DECIMAL(15, 2),
    Price_Volume BIGINT,
    PRIMARY KEY (Date)
);

CREATE TABLE TSLA_historical_data (
    Date DATE NOT NULL,
    Price_Close DECIMAL(15, 2),
    Price_High DECIMAL(15, 2),
    Price_Low DECIMAL(15, 2),
    Price_Open DECIMAL(15, 2),
    Price_Volume BIGINT,
    PRIMARY KEY (Date)
);

CREATE TABLE GOOGL_historical_data (
    Date DATE NOT NULL,
    Price_Close DECIMAL(15, 2),
    Price_High DECIMAL(15, 2),
    Price_Low DECIMAL(15, 2),
    Price_Open DECIMAL(15, 2),
    Price_Volume BIGINT,
    PRIMARY KEY (Date)
);

CREATE TABLE AMZN_historical_data (
    Date DATE NOT NULL,
    Price_Close DECIMAL(15, 2),
    Price_High DECIMAL(15, 2),
    Price_Low DECIMAL(15, 2),
    Price_Open DECIMAL(15, 2),
    Price_Volume BIGINT,
    PRIMARY KEY (Date)
);



/*Date: This column stores the date of the stock data and is set as the primary key to ensure uniqueness for each entry.
Price_Close: The closing price of the stock at the end of the trading day.
Price_High: The highest price reached during the trading day.
Price_Low: The lowest price reached during the trading day.
Price_Open: The opening price of the stock at the beginning of the trading day.
Price_Volume: The number of shares traded during the day. This is stored as a BIGINT to accommodate large values.*/



Select * from AAPL_historical_data
Select * from MSFT_historical_data
Select * from TSLA_historical_data
Select * from GOOGL_historical_data
Select * from AMZN_historical_data

COPY AAPL_historical_data(Date, Price_Close, Price_High, Price_Low, Price_Open, Price_Volume)
from 'J:\4-PROJECTS\7-Stock_Analysis\AAPL_historical_data.csv'
delimiter ','
csv header;

COPY MSFT_historical_data(Date, Price_Close, Price_High, Price_Low, Price_Open, Price_Volume)
from 'J:\4-PROJECTS\7-Stock_Analysis\MSFT_historical_data.csv'
delimiter ','
csv header;

COPY TSLA_historical_data(Date, Price_Close, Price_High, Price_Low, Price_Open, Price_Volume)
from 'J:\4-PROJECTS\7-Stock_Analysis\TSLA_historical_data.csv'
delimiter ','
csv header;

COPY GOOGL_historical_data(Date, Price_Close, Price_High, Price_Low, Price_Open, Price_Volume)
from 'J:\4-PROJECTS\7-Stock_Analysis\GOOGL_historical_data.csv'
delimiter ','
csv header;

COPY AMZN_historical_data(Date, Price_Close, Price_High, Price_Low, Price_Open, Price_Volume)
from 'J:\4-PROJECTS\7-Stock_Analysis\AMZN_historical_data.csv'
delimiter ','
csv header;




-- 1. Calculate Daily Returns for Each Stock
-- APPLE
SELECT 
    Date,
    Price_Close,
    LAG(Price_Close) OVER (ORDER BY Date) AS prev_close,
    (Price_Close / LAG(Price_Close) OVER (ORDER BY Date) - 1) AS daily_return
FROM 
    AAPL_historical_data
ORDER BY 
    Date;
-- MICROSOFT
SELECT 
    Date,
    Price_Close,
    LAG(Price_Close) OVER (ORDER BY Date) AS prev_close,
    (Price_Close / LAG(Price_Close) OVER (ORDER BY Date) - 1) AS daily_return
FROM 
    MSFT_historical_data
ORDER BY 
    Date;

-- TESLA
	SELECT 
    Date,
    Price_Close,
    LAG(Price_Close) OVER (ORDER BY Date) AS prev_close,
    (Price_Close / LAG(Price_Close) OVER (ORDER BY Date) - 1) AS daily_return
FROM 
    TSLA_historical_data
ORDER BY 
    Date;

-- GOOGLE
	SELECT 
    Date,
    Price_Close,
    LAG(Price_Close) OVER (ORDER BY Date) AS prev_close,
    (Price_Close / LAG(Price_Close) OVER (ORDER BY Date) - 1) AS daily_return
FROM 
    GOOGL_historical_data
ORDER BY 
    Date;

-- AMAZON
	SELECT 
    Date,
    Price_Close,
    LAG(Price_Close) OVER (ORDER BY Date) AS prev_close,
    (Price_Close / LAG(Price_Close) OVER (ORDER BY Date) - 1) AS daily_return
FROM 
    AMZN_historical_data
ORDER BY 
    Date;


	


-- 2. Calculate Average Daily Return for Each Stock

-- APPLE
For Apple:
sql
Copy
Edit
WITH daily_returns AS (
    SELECT 
        Date,
        Price_Close,
        (Price_Close / LAG(Price_Close) OVER (ORDER BY Date) - 1) AS daily_return
    FROM 
        apple_stock_data
)
SELECT 
    AVG(daily_return) AS avg_daily_return
FROM 
    daily_returns;

-- Same for each Stock only you need to be change the ticker name






-- 3. Calculate Volatility (Standard Deviation of Daily Returns)
-- (Volatility is the standard deviation of daily returns, annualized by multiplying by the square root of 252 (number of trading days in a year).
-- FOR APPLE

For Apple:
sql
Copy
Edit
WITH daily_returns AS (
    SELECT 
        Date,
        Price_Close,
        (Price_Close / LAG(Price_Close) OVER (ORDER BY Date) - 1) AS daily_return
    FROM 
        apple_stock_data
)
SELECT 
    STDDEV(daily_return) * SQRT(252) AS annualized_volatility
FROM 
    daily_returns;
-- SAME FOR EACH STOCK ONLY YOU NEED TO BE CHANGE THE NAME







-- 4. Calculate Highest and Lowest Price for Each Stock in a Given Period
-- FOR APPLE
For Apple:
sql
Copy
Edit
SELECT 
    MIN(Price_Low) AS lowest_price,
    MAX(Price_High) AS highest_price
FROM 
    apple_stock_data
WHERE
    Date BETWEEN '2023-01-01' AND '2023-12-31';
-- SAME FOR EACH STOCK ONLY YOU NEED TO BE CHANGE THE NAME








-- 5. Find the Days with the Highest Trading Volume
-- Identify the days with the maximum trading volume for each stock.

sql
Copy
Edit
SELECT 
    'Apple' AS Company, 
    Date, 
    Price_Volume AS Max_Volume 
FROM apple_stock_data
WHERE Price_Volume = (SELECT MAX(Price_Volume) FROM apple_stock_data)
UNION ALL
SELECT 
    'Microsoft', 
    Date, 
    Price_Volume 
FROM microsoft_stock_data
WHERE Price_Volume = (SELECT MAX(Price_Volume) FROM microsoft_stock_data)
UNION ALL
SELECT 
    'Tesla', 
    Date, 
    Price_Volume 
FROM tesla_stock_data
WHERE Price_Volume = (SELECT MAX(Price_Volume) FROM tesla_stock_data)
UNION ALL
SELECT 
    'Google', 
    Date, 
    Price_Volume 
FROM google_stock_data
WHERE Price_Volume = (SELECT MAX(Price_Volume) FROM google_stock_data)
UNION ALL
SELECT 
    'Amazon', 
    Date, 
    Price_Volume 
FROM amazon_stock_data
WHERE Price_Volume = (SELECT MAX(Price_Volume) FROM amazon_stock_data);








-- 6. Find the Best and Worst Performing Weeks
-- Compare weekly gains and losses by aggregating daily price changes.

sql
Copy
Edit
SELECT 
    WEEK(Date) AS Week_Number, 
    YEAR(Date) AS Year,
    (MAX(Price_Close) - MIN(Price_Close)) AS Weekly_Change
FROM apple_stock_data
GROUP BY YEAR(Date), WEEK(Date)
ORDER BY Weekly_Change DESC
LIMIT 5;









-- 7. Find Stocks with Consistent Growth Over a Month
-- Identify stocks that showed consistent daily price increases for an entire month.

sql
Copy
Edit
SELECT 
    DATE_FORMAT(Date, '%Y-%m') AS Month, 
    COUNT(*) AS Growth_Streak
FROM apple_stock_data
WHERE Price_Close > Price_Open
GROUP BY DATE_FORMAT(Date, '%Y-%m')
HAVING Growth_Streak >= 20; -- Assuming 20 trading days in a month










-- 8. Identify Months with High Volatility
-- Find months with the highest average daily price fluctuations.

sql
Copy
Edit
SELECT 
    DATE_FORMAT(Date, '%Y-%m') AS Month,
    AVG(Price_High - Price_Low) AS Average_Daily_Volatility
FROM apple_stock_data
GROUP BY DATE_FORMAT(Date, '%Y-%m')
ORDER BY Average_Daily_Volatility DESC
LIMIT 5;










-- 9. Calculate the Moving Average (SMA) for Each Stock
-- The Simple Moving Average (SMA) is often used to understand trends in a stock’s price. Let’s calculate a 50-day SMA for Apple.

For Apple:
sql
Copy
Edit
SELECT 
    Date,
    Price_Close,
    AVG(Price_Close) OVER (ORDER BY Date ROWS BETWEEN 49 PRECEDING AND CURRENT ROW) AS moving_average_50
FROM 
    apple_stock_data
ORDER BY 
    Date;







-- 10. Calculate the 14-Day Relative Strength Index (RSI)
-- The RSI is a momentum oscillator that measures the speed and change of price movements. The formula for RSI involves calculating the average gains and losses over a 14-day period.

For Apple:
sql
Copy
Edit
WITH price_changes AS (
    SELECT 
        Date,
        Price_Close,
        LAG(Price_Close) OVER (ORDER BY Date) AS prev_close,
        Price_Close - LAG(Price_Close) OVER (ORDER BY Date) AS price_change
    FROM 
        apple_stock_data
),
gain_loss AS (
    SELECT 
        Date,
        CASE WHEN price_change > 0 THEN price_change ELSE 0 END AS gain,
        CASE WHEN price_change < 0 THEN -price_change ELSE 0 END AS loss
    FROM 
        price_changes
)
, avg_gain_loss AS (
    SELECT 
        Date,
        AVG(gain) OVER (ORDER BY Date ROWS BETWEEN 13 PRECEDING AND CURRENT ROW) AS avg_gain,
        AVG(loss) OVER (ORDER BY Date ROWS BETWEEN 13 PRECEDING AND CURRENT ROW) AS avg_loss
    FROM 
        gain_loss
)
SELECT 
    Date,
    100 - (100 / (1 + (avg_gain / avg_loss))) AS rsi
FROM 
    avg_gain_loss
WHERE 
    avg_loss > 0;
Repeat for the other companies by changing the table name.









-- 11. Calculate the Correlation Between Two Stocks' Daily Returns
-- For example, to calculate the correlation between Apple and Microsoft’s daily returns, you need to join the daily returns of both stocks:

For Apple and Microsoft:
sql
Copy
Edit
WITH apple_returns AS (
    SELECT 
        Date,
        (Price_Close / LAG(Price_Close) OVER (ORDER BY Date) - 1) AS daily_return
    FROM 
        apple_stock_data
),
microsoft_returns AS (
    SELECT 
        Date,
        (Price_Close / LAG(Price_Close) OVER (ORDER BY Date) - 1) AS daily_return
    FROM 
        microsoft_stock_data
)
SELECT 
    CORR(apple_returns.daily_return, microsoft_returns.daily_return) AS correlation
FROM 
    apple_returns
JOIN 
    microsoft_returns 
    ON apple_returns.Date = microsoft_returns.Date;








-- 12. Stock Performance Overview for Each Company
You can get an overview of key metrics (like average return, volatility, and RSI) for each stock using the following query for Apple:

For Apple:
sql
Copy
Edit
WITH daily_returns AS (
    SELECT 
        Date,
        Price_Close,
        (Price_Close / LAG(Price_Close) OVER (ORDER BY Date) - 1) AS daily_return
    FROM 
        apple_stock_data
),
volatility AS (
    SELECT 
        STDDEV(daily_return) * SQRT(252) AS annualized_volatility
    FROM 
        daily_returns
),
avg_returns AS (
    SELECT 
        AVG(daily_return) AS avg_daily_return
    FROM 
        daily_returns
),
price_changes AS (
    SELECT 
        Date,
        Price_Close,
        LAG(Price_Close) OVER (ORDER BY Date) AS prev_close,
        Price_Close - LAG(Price_Close) OVER (ORDER BY Date) AS price_change
    FROM 
        apple_stock_data
),
gain_loss AS (
    SELECT 
        Date,
        CASE WHEN price_change > 0 THEN price_change ELSE 0 END AS gain,
        CASE WHEN price_change < 0 THEN -price_change ELSE 0 END AS loss
    FROM 
        price_changes
),
avg_gain_loss AS (
    SELECT 
        Date,
        AVG(gain) OVER (ORDER BY Date ROWS BETWEEN 13 PRECEDING AND CURRENT ROW) AS avg_gain,
        AVG(loss) OVER (ORDER BY Date ROWS BETWEEN 13 PRECEDING AND CURRENT ROW) AS avg_loss
)
, rsi AS (
    SELECT 
        Date,
        100 - (100 / (1 + (avg_gain / avg_loss))) AS rsi
    FROM 
        avg_gain_loss
    WHERE 
        avg_loss > 0
)
SELECT 
    (SELECT avg_daily_return FROM avg_returns) AS avg_daily_return,
    (SELECT annualized_volatility FROM volatility) AS annualized_volatility,
    (SELECT MAX(rsi) FROM rsi) AS max_rsi,
    (SELECT MIN(rsi) FROM rsi) AS min_rsi
FROM 
    dual;
	








-- 13. Value at Risk (VaR) 
-- (Value at Risk (VaR) is used to estimate the potential loss in value of a portfolio or asset over a defined period for a given confidence interval. The Historical VaR method is based on historical price movements.)
-- (The query calculates the 5th percentile of the historical daily returns, which corresponds to the 95% confidence level for the Value at Risk. This means that, with 95% confidence, the stock will not lose more than this value on any given day.)


For Apple:
sql
Copy
Edit
WITH daily_returns AS (
    SELECT 
        Date,
        Price_Close,
        (Price_Close / LAG(Price_Close) OVER (ORDER BY Date) - 1) AS daily_return
    FROM 
        apple_stock_data
)
SELECT 
    PERCENTILE_CONT(0.05) WITHIN GROUP (ORDER BY daily_return) AS VaR_95
FROM 
    daily_returns;










-- 14. Maximum Drawdown(The maximum drawdown is the largest drop from a peak to a trough in the price series, measuring the largest percentage loss from a peak to a valley.)
-- This query calculates the percentage drawdown for each day by comparing the price on that day with the peak price seen up to that point. The minimum drawdown percentage represents the largest loss from the peak.


For Apple:
sql
Copy
Edit
WITH price_peak AS (
    SELECT 
        Date,
        Price_Close,
        MAX(Price_Close) OVER (ORDER BY Date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS peak_price
    FROM 
        apple_stock_data
),
drawdown AS (
    SELECT 
        Date,
        Price_Close,
        peak_price,
        (Price_Close - peak_price) / peak_price AS drawdown_pct
    FROM 
        price_peak
)
SELECT 
    MIN(drawdown_pct) AS max_drawdown
FROM 
    drawdown;








-- 15. Maximum Loss in a Given Period(This query calculates the maximum loss within a given date range (e.g., from January 1 to January 30). The MIN(price_change) finds the biggest loss during this period.)

For Apple (30-Day Period):
sql
Copy
Edit
WITH price_changes AS (
    SELECT 
        Date,
        Price_Close,
        LAG(Price_Close) OVER (ORDER BY Date) AS prev_close,
        (Price_Close - LAG(Price_Close) OVER (ORDER BY Date)) AS price_change
    FROM 
        apple_stock_data
)
SELECT 
    MIN(price_change) AS max_loss
FROM 
    price_changes
WHERE 
    Date BETWEEN '2023-01-01' AND '2023-01-30';







-- 16. Conditional Value at Risk (CVaR)
-- Conditional VaR (also called Expected Shortfall) is a measure of the risk of extreme losses, calculated as the average loss in the worst α% of cases (e.g., 5%).
-- The query first calculates the 95th percentile VaR (i.e., the loss at the 5th percentile of returns). Then, it calculates the Conditional VaR (CVaR) as the average of all returns that are worse than the VaR threshold.

For Apple:
sql
Copy
Edit
WITH daily_returns AS (
    SELECT 
        Date,
        Price_Close,
        (Price_Close / LAG(Price_Close) OVER (ORDER BY Date) - 1) AS daily_return
    FROM 
        apple_stock_data
),
VaR AS (
    SELECT 
        PERCENTILE_CONT(0.05) WITHIN GROUP (ORDER BY daily_return) AS VaR_95
    FROM 
        daily_returns
)
SELECT 
    AVG(daily_return) AS cvar_95
FROM 
    daily_returns
WHERE 
    daily_return <= (SELECT VaR_95 FROM VaR);








-- 17. Beta Coefficient (Risk Relative to Market)
-- Beta measures the sensitivity of a stock’s returns relative to the returns of a market index (S&P 500). A beta greater than 1 indicates that the stock is more volatile than the market.
-- This query calculates the beta coefficient by computing the correlation between the daily returns of the stock (Apple) and the market index.

For Apple (with market returns in a market_index table):
sql
Copy
Edit
WITH stock_returns AS (
    SELECT 
        Date,
        (Price_Close / LAG(Price_Close) OVER (ORDER BY Date) - 1) AS stock_return
    FROM 
        apple_stock_data
),
market_returns AS (
    SELECT 
        Date,
        (Price_Close / LAG(Price_Close) OVER (ORDER BY Date) - 1) AS market_return
    FROM 
        market_index
)
SELECT 
    CORR(stock_returns.stock_return, market_returns.market_return) AS beta
FROM 
    stock_returns
JOIN 
    market_returns
    ON stock_returns.Date = market_returns.Date;



