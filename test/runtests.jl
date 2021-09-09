using GriddingMachine.Collections
using Test


# test query_collection function
@testset "GriddingMachine : Collections" begin
    # test query_collection function
    query_collection(pft_collection()); @test true;
    query_collection(sla_collection()); @test true;

    # clean up artifacts
    clean_collections!("old"); @test true;
    clean_collections!(pft_collection()); @test true;

    # only for high memory and storage cases, e.g., server
    if Sys.islinux() && (Sys.total_memory() / 2^30) > 30
        query_collection(canopy_height_collection(), "20X_1Y_V1"); @test true;
        query_collection(canopy_height_collection(), "2X_1Y_V2" ); @test true;

        query_collection(elevation_collection(), "4X_1Y_V1" ); @test true;

        query_collection(clumping_index_collection(), "240X_1Y_V1"); @test true;
        query_collection(clumping_index_collection(), "2X_1Y_V1"  ); @test true;
        query_collection(clumping_index_collection(), "2X_1Y_V2"  ); @test true;

        for year in 2001:2019
            query_collection(gpp_collection(), "MPI_RS_2X_1M_$(year)_V1"); @test true;
            query_collection(gpp_collection(), "MPI_RS_2X_8D_$(year)_V1"); @test true;
        end;
        for year in 2000:2019
            query_collection(gpp_collection(), "VPM_5X_8D_$(year)_V2" ); @test true;
            query_collection(gpp_collection(), "VPM_12X_8D_$(year)_V2"); @test true;
        end;

        for year in 2000:2020
            query_collection(lai_collection(), "MODIS_2X_1M_$(year)_V1" ); @test true;
            query_collection(lai_collection(), "MODIS_2X_8D_$(year)_V1" ); @test true;
            query_collection(lai_collection(), "MODIS_10X_1M_$(year)_V1"); @test true;
            query_collection(lai_collection(), "MODIS_10X_8D_$(year)_V1"); @test true;
            query_collection(lai_collection(), "MODIS_20X_1M_$(year)_V1"); @test true;
            query_collection(lai_collection(), "MODIS_20X_8D_$(year)_V1"); @test true;
        end;

        query_collection(land_mask_collection(), "4X_1Y_V1"); @test true;

        # expect warning here
        query_collection(leaf_chlorophyll_collection(), "2X_7D_V1"); @test true;

        query_collection(leaf_nitrogen_collection(), "2X_1Y_V1"); @test true;
        query_collection(leaf_nitrogen_collection(), "2X_1Y_V2"); @test true;

        query_collection(leaf_phosphorus_collection(), "2X_1Y_V1"); @test true;

        query_collection(pft_collection(), "2X_1Y_V1"); @test true;

        for year in 2018:2019
            query_collection(sif_collection(), "TROPOMI_740_1X_1M_$(year)_V1"   ); @test true;
            query_collection(sif_collection(), "TROPOMI_740_12X_8D_$(year)_V1"  ); @test true;
            query_collection(sif_collection(), "TROPOMI_740DC_1X_1M_$(year)_V1" ); @test true;
            query_collection(sif_collection(), "TROPOMI_740DC_12X_8D_$(year)_V1"); @test true;
        end;

        query_collection(sla_collection(), "2X_1Y_V1"); @test true;
        query_collection(sla_collection(), "2X_1Y_V2"); @test true;

        query_collection(soil_color_collection(), "2X_1Y_V1"); @test true;

        query_collection(soil_hydraulics_collection(), "SWCR_120X_1Y_V1"); @test true;
        query_collection(soil_hydraulics_collection(), "SWCR_12X_1Y_V1" ); @test true;
        query_collection(soil_hydraulics_collection(), "SWCS_120X_1Y_V1"); @test true;
        query_collection(soil_hydraulics_collection(), "SWCS_12X_1Y_V1" ); @test true;
        query_collection(soil_hydraulics_collection(), "VGA_120X_1Y_V1" ); @test true;
        query_collection(soil_hydraulics_collection(), "VGA_12X_1Y_V1"  ); @test true;
        query_collection(soil_hydraulics_collection(), "VGN_120X_1Y_V1" ); @test true;
        query_collection(soil_hydraulics_collection(), "VGN_12X_1Y_V1"  ); @test true;

        query_collection(surface_area_collection(), "2X_1Y_V1"); @test true;
        query_collection(surface_area_collection(), "1X_1Y_V1"); @test true;

        query_collection(tree_density_collection(), "120X_1Y_V1"); @test true;
        query_collection(tree_density_collection(), "2X_1Y_V1"  ); @test true;

        query_collection(vcmax_collection(), "2X_1Y_V1"); @test true;
        query_collection(vcmax_collection(), "2X_1Y_V2"); @test true;

        query_collection(wood_density_collection(), "2X_1Y_V1"); @test true;
    end
end
