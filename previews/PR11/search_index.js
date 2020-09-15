var documenterSearchIndex = {"docs":
[{"location":"#GriddingMachine","page":"Home","title":"GriddingMachine","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Global canopy datasets","category":"page"},{"location":"#Usage","page":"Home","title":"Usage","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"# not registered for now\nusing Pkg;\nPkg.add(PackageSpec(url=\"https://github.com/CliMA/GriddingMachine.jl.git\"));\n\nusing GriddingMachine\n\nFT = Float32;\nLAI_LUT = LAIMonthlyMean{FT}();\n# read the lai at lat=30, lon=-118, month=Augest\nlai_val = read_LUT(LAI_LUT, FT(30), FT(-100), 8);\n@show lai_val;","category":"page"},{"location":"API/#API","page":"API","title":"API","text":"","category":"section"},{"location":"API/","page":"API","title":"API","text":"CurrentModule = GriddingMachine","category":"page"},{"location":"API/#Datasets-for-Clima-Look-Up-Table","page":"API","title":"Datasets for Clima Look-Up-Table","text":"","category":"section"},{"location":"API/","page":"API","title":"API","text":"AbstractDataset\nLAIMonthlyMean","category":"page"},{"location":"API/#GriddingMachine.AbstractDataset","page":"API","title":"GriddingMachine.AbstractDataset","text":"abstract type AbstractDataset{FT}\n\nHierachy of AbstractDataset\n\nAbstractGPP\nAbstractLAI\n\n\n\n\n\n","category":"type"},{"location":"API/#GriddingMachine.LAIMonthlyMean","page":"API","title":"GriddingMachine.LAIMonthlyMean","text":"struct LAIMonthlyMean{FT}\n\nStruct for monthly mean MODIS LAI\n\n\n\n\n\n","category":"type"},{"location":"API/#Function-to-read-Look-Up-Table","page":"API","title":"Function to read Look-Up-Table","text":"","category":"section"},{"location":"API/","page":"API","title":"API","text":"lat_ind\nlon_ind\nread_LUT","category":"page"},{"location":"API/#GriddingMachine.lat_ind","page":"API","title":"GriddingMachine.lat_ind","text":"lat_ind(lat::FT; res::FT) where {FT<:AbstractFloat}\n\nRound the latitude and return the index in a matrix, Given\n\nlat Latitude\nres Resolution in latitude\n\n\n\n\n\n","category":"function"},{"location":"API/#GriddingMachine.lon_ind","page":"API","title":"GriddingMachine.lon_ind","text":"lon_ind(lon::FT; res::FT=1) where {FT<:AbstractFloat}\n\nRound the longitude and return the index in a matrix, Given\n\nlon Longitude\nres Resolution in longitude\n\n\n\n\n\n","category":"function"},{"location":"API/#GriddingMachine.read_LUT","page":"API","title":"GriddingMachine.read_LUT","text":"read_LUT(data::GriddedDataset{FT}, lat::FT, lon::FT) where {FT<:AbstractFloat}\nread_LUT(data::GriddedDataset{FT}, lat::FT, lon::FT, ind::Int) where {FT<:AbstractFloat}\nread_LUT(data::GriddedDataset{FT}, data_type::AbstractGPP{FT}, lat::FT, lon::FT, ind::Int) where {FT<:AbstractFloat}\nread_LUT(data::GriddedDataset{FT}, data_type::LAIMonthlyMean{FT}, lat::FT, lon::FT, ind::Int) where {FT<:AbstractFloat}\nread_LUT(data::GriddedDataset{FT}, data_type::VcmaxOptimalCiCa{FT}, lat::FT, lon::FT) where {FT<:AbstractFloat}\n\nRead the LAI from given\n\ndata LAIMonthlyMean type struct\ndata_type Dataset type, subtype of AbstractDataset\nlat Latitude\nlon Longitude\nind Index of cycle in the year, e.g., 1-46, or Month number from 1 to 12   for LAIMonthlyMean DataType\n\n\n\n\n\n","category":"function"}]
}
