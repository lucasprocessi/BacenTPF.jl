
using Test
using Dates
using YearMonths
using BacenTPF
using DataFrames

ym = YearMonths.YearMonth(2021,4)
df = BacenTPF.read_trades_tpf(ym, true)

# @show df
@test nrow(df) == 801
@test eltype(df[:,"DATA MOV"]) == Date
@test eltype(df[:,"EMISSAO"]) == Date
@test eltype(df[:,"VENCIMENTO"]) == Date
