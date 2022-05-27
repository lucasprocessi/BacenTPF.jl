# BacenTPF.jl
A Julia package to get Brazilian Central Bank's (BACEN) government bonds (TPF) trade data.

## Usage

It is pretty straightforward!
You can either download the monthly zip file...

```julia
ym = YearMonths.YearMonth(2022,4) # year month
extragroup_only = true            # if true, only extragroup trades are considered
dest = "tpf.zip"                  # destination file
BacenTPF.download_tpf_zip_file(ym, extragroup_only, dest)
```

... or have it parsed into a `DataFrame`:

```julia
ym = YearMonths.YearMonth(2022,4)
extragroup_only = true
df = BacenTPF.read_trades_tpf(ym, extragroup_only)

df
# 827×19 DataFrame
#  Row │ DATA MOV    SIGLA    CODIGO  CODIGO ISIN   EMISSAO     VENCIMENTO  NUM DE OPER  QUANT NEGOCIADA  VALOR NEGOCIADO  PU MIN     PU MED     PU MAX     PU LASTRO  VALOR PAR  TAXA MIN      TAXA MED      TAXA  ⋯
#      │ Date        String7  Int64   String15      Date        Date        Int64        Int64            Missing          Float64?   Float64?   Float64?   Float64    Float64    Float64?      Float64?      Float ⋯
# ─────┼─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
#    1 │ 2022-04-01  LFT      210100  BRSTNCLF1R74  2016-07-08  2022-09-01           42           178385          missing  11509.0    11509.8    11510.2    11506.1     11510.2         0.0           0.0076        ⋯
#    2 │ 2022-04-01  LFT      210100  BRSTNCLF1R82  2017-01-13  2023-03-01           24            25391          missing  11435.2    11509.3    11510.2    11501.8     11510.2         0.0           0.0079
#    3 │ 2022-04-01  LFT      210100  BRSTNCLF1R90  2017-07-14  2023-09-01           51            94099          missing  11502.2    11504.0    11504.9    11491.5     11510.2         0.0321        0.0377
#    4 │ 2022-04-01  LFT      210100  BRSTNCLF1RA8  2018-01-05  2024-03-01           27            39844          missing  11489.2    11501.6    11516.1    11485.6     11510.2        -0.0268        0.0392
#    5 │ 2022-04-01  LFT      210100  BRSTNCLF0008  2018-07-06  2024-09-01           36           122135          missing  11476.7    11499.0    11512.4    11478.6     11510.2        -0.0078        0.0403        ⋯
#    6 │ 2022-04-01  LFT      210100  BRSTNCLF1RC4  2018-10-26  2025-03-01           25            34263          missing  11464.4    11491.2    11492.7    11466.3     11510.2         0.052         0.0567
#    7 │ 2022-04-01  LFT      210100  BRSTNCLF1RD2  2019-03-08  2025-09-01           20            18833          missing  11452.4    11479.1    11480.2    11449.0     11510.2         0.0766        0.0793
#    8 │ 2022-04-01  LFT      210100  BRSTNCLF1RE0  2019-09-06  2026-03-01           20            55016          missing  11460.9    11463.7    11465.3    11429.4     11510.2         0.1           0.1037
#    9 │ 2022-04-01  LFT      210100  BRSTNCLF1RF7  2020-03-13  2026-09-01            7             1337          missing  11454.5    11455.3    11456.0    11417.2     11510.2         0.107         0.1085        ⋯
#   10 │ 2022-04-01  LFT      210100  BRSTNCLF1RG5  2020-07-03  2027-03-01           15            21652          missing  11404.9    11418.7    11420.7    11371.6     11510.2         0.1596        0.1632
#   11 │ 2022-04-01  LFT      210100  BRSTNCLF1RH3  2021-07-02  2027-09-01           26            72927          missing  11395.8    11401.5    11405.0    11352.9     11510.2         0.17          0.1757
#   12 │ 2022-04-01  LFT      210100  BRSTNCLF1RI1  2022-01-05  2028-03-01           16            22208          missing  11388.7    11394.1    11398.8    11341.9     11510.2         0.165         0.172
#   13 │ 2022-04-01  LTN      100000  BRSTNCLTN7O0  2018-06-21  2022-07-01           13          1143336          missing    971.787    971.84     971.927    970.568    1000.0        12.27         12.3106        ⋯
#   14 │ 2022-04-01  LTN      100000  BRSTNCLTN7V5  2020-07-03  2022-10-01           17          1546440          missing    941.588    941.767    942.031    939.214    1000.0        12.58         12.6427
#   15 │ 2022-04-01  LTN      100000  BRSTNCLTN7D3  2016-01-20  2023-01-01           34          2202680          missing    913.595    913.822    914.136    910.38     1000.0        12.716        12.7677
#   16 │ 2022-04-01  LTN      100000  BRSTNCLTN7X1  2022-01-07  2023-04-01           11          1052000          missing    886.603    886.796    886.957    882.364    1000.0        12.745        12.7654
#   17 │ 2022-04-01  LTN      100000  BRSTNCLTN7Q5  2019-04-05  2023-07-01           13           404062          missing    861.8      862.162    863.236    857.111    1000.0        12.57         12.6828        ⋯
#   18 │ 2022-04-01  LTN      100000  BRSTNCLTN7S1  2020-01-03  2024-01-01           26           488801          missing    818.224    818.902    820.688    812.326    1000.0        12.041        12.1815
#   19 │ 2022-04-01  LTN      100000  BRSTNCLTN7Y9  2022-01-07  2024-04-01          215         14190500          missing    797.895    798.056    798.988    791.437    1000.0        12.0          12.066
#   20 │ 2022-04-01  LTN      100000  BRSTNCLTN7W3  2021-01-08  2024-07-01            5           130656          missing    778.373    780.004    782.813    771.454    1000.0        11.605        11.785
#   ⋮  │     ⋮          ⋮       ⋮          ⋮            ⋮           ⋮            ⋮              ⋮                ⋮             ⋮          ⋮          ⋮          ⋮          ⋮           ⋮             ⋮              ⋱
#  808 │ 2022-04-29  NTN-B    760199  BRSTNCNTB4O9  2014-01-15  2023-05-15          295          1034031          missing   4061.71    4063.7     4067.93    4049.66     3911.71  missing       missing       missi ⋯
#  809 │ 2022-04-29  NTN-B    760199  BRSTNCNTB096  2003-10-15  2024-08-15          202           578866          missing   4003.8     4013.79    4018.48    3987.31     3911.71  missing       missing       missi
#  810 │ 2022-04-29  NTN-B    760199  BRSTNCNTB633  2020-01-08  2025-05-15          199           881374          missing   4082.82    4088.1     4092.35    4050.86     3911.71  missing       missing       missi
#  811 │ 2022-04-29  NTN-B    760199  BRSTNCNTB4U6  2016-01-06  2026-08-15          109           229744          missing   4052.73    4061.61    4067.06    4010.26     3911.71  missing       missing       missi
#  812 │ 2022-04-29  NTN-B    760199  BRSTNCNTB682  2022-01-12  2027-05-15          161          1514938          missing   4110.78    4118.86    4143.75    4059.67     3911.71  missing       missing       missi ⋯
#  813 │ 2022-04-29  NTN-B    760199  BRSTNCNTB4X0  2018-01-10  2028-08-15           97           124035          missing   4062.32    4075.64    4087.66    4006.22     3911.71  missing       missing       missi
#  814 │ 2022-04-29  NTN-B    760199  BRSTNCNTB3B8  2010-02-10  2030-08-15           72           125582          missing   4084.54    4099.31    4108.39    4003.59     3911.71  missing       missing       missi
#  815 │ 2022-04-29  NTN-B    760199  BRSTNCNTB674  2022-01-05  2032-08-15           13            31172          missing   4099.44    4105.52    4105.8     3992.29     3911.71  missing       missing       missi
#  816 │ 2022-04-29  NTN-B    760199  BRSTNCNTB0O7  2006-03-07  2035-05-15           85           219378          missing   4136.71    4167.32    4183.51    4039.16     3911.71  missing       missing       missi ⋯
#  817 │ 2022-04-29  NTN-B    760199  BRSTNCNTB3C6  2010-02-10  2040-08-15           33            87608          missing   4110.7     4119.6     4128.92    3959.57     3911.71  missing       missing       missi
#  818 │ 2022-04-29  NTN-B    760199  BRSTNCNTB0A6  2004-08-15  2045-05-15           40            84845          missing   4114.9     4138.17    4145.1     3970.62     3911.71  missing       missing       missi
#  819 │ 2022-04-29  NTN-B    760199  BRSTNCNTB3D4  2010-02-10  2050-08-15          128           219257          missing   4073.41    4079.23    4106.02    3880.74     3911.71  missing       missing       missi
#  820 │ 2022-04-29  NTN-B    760199  BRSTNCNTB4Q4  2015-01-14  2055-05-15           49            38638          missing   4127.05    4147.55    4156.33    3934.75     3911.71  missing       missing       missi ⋯
#  821 │ 2022-04-29  NTN-B    760199  BRSTNCNTB690  2022-01-12  2060-08-15           22            71775          missing   4077.83    4085.94    4108.62    3871.19     3911.71  missing       missing       missi
#  822 │ 2022-04-29  NTN-F    950199  BRSTNCNTF147  2012-03-09  2023-01-01           28           489573          missing   1012.56    1013.14    1013.42    1009.29     1000.0   missing       missing       missi
#  823 │ 2022-04-29  NTN-F    950199  BRSTNCNTF170  2014-01-10  2025-01-01           41          1364561          missing    979.765    983.338    985.198    973.277    1000.0   missing       missing       missi
#  824 │ 2022-04-29  NTN-F    950199  BRSTNCNTF1P8  2016-01-15  2027-01-01           18            84900          missing    955.145    960.544    961.943    945.369    1000.0   missing       missing       missi ⋯
#  825 │ 2022-04-29  NTN-F    950199  BRSTNCNTF1Q6  2018-01-05  2029-01-01           28           320432          missing    931.255    937.075    942.018    916.441    1000.0   missing       missing       missi
#  826 │ 2022-04-29  NTN-F    950199  BRSTNCNTF204  2020-01-10  2031-01-01           14            70615          missing    913.992    919.526    921.379    890.971    1000.0   missing       missing       missi
#  827 │ 2022-04-29  NTN-F    950199  BRSTNCNTF212  2022-01-07  2033-01-01           10            92422          missing    902.059    903.326    906.813    871.302    1000.0   missing       missing       missi
#                                                                                                                                                                                      3 columns and 787 rows omitted
```