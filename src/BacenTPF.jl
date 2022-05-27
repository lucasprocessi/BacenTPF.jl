module BacenTPF

using YearMonths
using Dates
using Downloads
using ZipFile
using CSV
using DataFrames

function read_trades_tpf(ym::YearMonths.YearMonth, extragroup_only::Bool)::DataFrame
    
    local_file = "$(tempname()).zip"
    download_tpf_zip_file(ym, extragroup_only, local_file)

    zip = ZipFile.Reader(local_file)
    for f in zip.files

        ret = CSV.File(f, delim=';', decimal=',', dateformat="dd/mm/yyyy")
        close(zip)
        rm(local_file)
        return DataFrame(ret)

    end

end

function download_tpf_zip_file(ym::YearMonths.YearMonth, extragroup_only::Bool, dest::String)
    url = _get_file_url(ym, extragroup_only)
    Downloads.download(url, dest)
    @assert isfile(dest)
end

function _get_file_url(ym::YearMonths.YearMonth, extragroup_only::Bool)::String
    ym_str = string(YearMonths.year(ym), lpad(YearMonths.month(ym), 2, "0"))
    group_str = extragroup_only ? "E" : "T"
    return "https://www4.bcb.gov.br/pom/demab/negociacoes/download/Neg$group_str$ym_str.ZIP"
end

end # module
