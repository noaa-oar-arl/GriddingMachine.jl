###############################################################################
#
# Compile data to nc files
#
###############################################################################
"""
    compile_RAW!(param::Array)
    compile_RAW!(
                dt::MOD15A2Hv006LAI{FT},
                params::Array{Any,1},
                zooms::Int
    ) where {FT<:AbstractFloat}

Compile RAW data to nc files, given
- `param` Array of parameters that pass into threads
- `dt` [`AbstractUngriddedData`](@ref) type ungridded data type
- `params` Array of parameters from [`query_RAW`](@ref), not that this `param`
    is different from the `param` used in [`compile_RAW!`](@ref)
- `zooms` Geometrical resolution zoom factor, `zooms=x` means `1/x` degree
"""
function compile_RAW!(param::Array)
    # unpack value from param
    layer = param[1];
    files = param[2];
    FT    = param[3];
    dims  = param[4];
    cache = param[5];

    # if file exist, skip it
    if !isfile(cache)
        # create matrices
        res_lat = 180 / dims[2];
        res_lon = 360 / dims[1];
        matv::Array{FT ,2} = zeros(FT , dims);
        matn::Array{Int,2} = zeros(Int, dims);

        # iterate through files
        for _file in files
            if isfile(_file)
                _data = DataFrame!(CSV.File(_file));
                for i in eachindex((_data).lat)
                    _lat = lat_ind(_data.lat[i]; res=res_lat);
                    _lon = lon_ind(_data.lon[i]; res=res_lon);
                    _val = _data.dat[i];
                    matv[_lon,_lat] += _val;
                    matn[_lon,_lat] += 1;
                end
            end
        end

        # save file to nc file
        matv ./= matn;
        save_LUT!(matv, cache);
    end

    return nothing
end




function compile_RAW!(
            dt::MOD15A2Hv006LAI{FT},
            params::Array{Any,1},
            year::Int,
            days::Int,
            zooms::Int
) where {FT<:AbstractFloat}
    # set time information for the gridding process
    date_start = DateTime("$(year)-01-01");
    date_stop  = DateTime("$(year)-12-31");
    date_dday  = Day(days);
    date_list  = date_start:date_dday:date_stop;

    # compile data per layer
    new_params = [];
    for layer in eachindex(date_list)
        _files = [];
        for param in params
            if param[1] == layer
                _path     = param[2];
                _prefix   = param[3];
                _cache    = param[5];
                pos_start = findfirst(_prefix, _path);
                hv_string = _path[pos_start[1]:end];
                outp_file = joinpath(_cache, hv_string * ".csv");
                push!(_files, outp_file);
            end
        end
        _save = params[1][5] * "/" * string(layer)*"_"*string(zooms)*"X.nc";
        push!(new_params, [layer, _files, FT, (360*zooms,180*zooms), _save]);
    end

    # compile the data into cache files multi-threading manner
    @showprogress pmap(compile_RAW!, new_params);

    # compile the cache nc files into 1 file
    _fold = params[1][5][1:end-10] * "reprocessed/";
    _year = params[1][5][end-3:end];
    _file = _fold * "LAI_MODIS_v006_" * _year * "_" *
            string(zooms) * "X_" * string(days) * "D.nc";
    _attr = Dict("longname" => "LAI", "units" => "-");
    @show _file;

    # if file exists, skip it
    if !isfile(_file)
        _data = zeros(FT, (360*zooms,180*zooms,length(date_list)));
        for i in eachindex(date_list)
            view(_data,:,:,i) .= ncread(new_params[i][5], "Var");
        end
        save_LUT!(_data, _file, "LAI", _attr);
    end

    return nothing
end
