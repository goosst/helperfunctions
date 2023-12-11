# SG 11 Nov 2020
# analyse stock fluctuation around dividend and evaluate if profitable

using Dates
using HTTP
using JSON
using Plots
using DataFrames
using CSV: write
using StatsPlots


tickers = [
    "AGS.BR",
    "BPOST.BR",
    "VAN.BR",
    "BEKB.BR",
    "ABI.BR",
    "VOW.DE",
    "MMM",
    "F",
    "DAN",
    "BMW.DE",
    "IFX.DE",
];
# tickers=["AGS.BR"]#,"VOW.DE","F","DAN","BMW.DE","IFX.DE"];

df = DataFrame(
    stock = string(),
    prediv = Float64[],
    postdiv = Float64[],
    dividend = Float64[],
);

seconds_before = 3600 * 24 * 7;
seconds_after = 3600 * 24 * 7;

date_start = string(convert(UInt32, datetime2unix(DateTime(2018, 01, 01))), base = 10);
# date_end=string(convert(UInt32,datetime2unix(DateTime(2020,11,10))),base=10);
date_end = string(
    convert(UInt32, datetime2unix(DateTime(year(today()), month(today()), day(today())))),
    base = 10,
);


for j = 1:length(tickers)
    ticker = tickers[j]
    url = string(
        "https://query1.finance.yahoo.com/v8/finance/chart/",
        ticker,
        "?period1=",
        date_start,
        "&period2=",
        date_end,
        "&interval=1d&events=div",
    )

    r = HTTP.request("GET", url)
    data = String(r.body)
    data = JSON.parse(data)
    data = data["chart"]["result"][1]

    data_dividends = data["events"]["dividends"]
    indices = findall(data_dividends.slots .== 1)


    for i = 1:length(indices)
        dividend = data_dividends[data_dividends.keys[indices[i]]]

        # plot stock value around dividend date
        idx = findall(
            dividend["date"] - seconds_before .<=
            data["timestamp"] .<=
            dividend["date"] + seconds_after,
        )

        push!(
            df,
            (
                ticker,
                data["indicators"]["quote"][1]["close"][idx][1],
                data["indicators"]["quote"][1]["close"][idx][end],
                dividend["amount"],
            ),
        )

        idx2 = findall(.!(isnothing.(data["indicators"]["quote"][1]["close"][idx])))
        plot_div = plot(
            Dates.unix2datetime.(data["timestamp"][idx][idx2]),
            data["indicators"]["quote"][1]["close"][idx][idx2],
            label = "without dividend",
        )

        # add dividend to stock value
        idx = findall(
            dividend["date"] .<= data["timestamp"] .<= dividend["date"] + seconds_after,
        )

        stockval = data["indicators"]["quote"][1]["close"][idx]
        idx2 = findall(.!(isnothing.(stockval))) #filter isnothing

        stockval = stockval[idx2] .+ convert(Float16, dividend["amount"])

        plot!(
            Dates.unix2datetime.(data["timestamp"][idx][idx2]),
            stockval,
            label = "with dividend",
            legend = :outertopleft,
        )

        # savefig(plot_div,string("dividend",j,i))
        # display(plot_div)

    end

end

df.profit = df.dividend + df.postdiv - df.prediv;
df.profit_perc = 100 * (df.profit ./ df.prediv);


write("dataframe.csv", df)

@df df scatter(
    :dividend,
    :profit_perc,
    group = :stock,
    title = "Dividend profit",
    ylabel = "profit percentage",
    xlabel = "dividend (euro)",
    m = (0.5, [:circle :rect :diamond :cross :hex :star7], 12),
    bg = RGB(0.2, 0.2, 0.2),
    legend = :outertopleft
)

savefig("dividends_profit")
