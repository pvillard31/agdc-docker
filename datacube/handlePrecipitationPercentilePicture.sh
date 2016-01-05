#/bin/bash


if [ "$#" -ne 1 ]; then
    echo "Usage: ./handlePrecipitationPercentilePicture.sh <NC File>"
else
    filename=$(basename "$1")
    extension="${filename##*.}"
    FILE="${filename%.*}"
    gdal_translate -a_ullr -17321655.5434 7332251.36559 17321655.5434 -7332251.36559 NETCDF:\"$FILE\".nc:perc_prcp $FILE"_precipitation_percentile_85.tif.temp" -b 1
    gdal_translate -a_ullr -17321655.5434 7332251.36559 17321655.5434 -7332251.36559 NETCDF:\"$FILE\".nc:perc_prcp $FILE"_precipitation_percentile_95.tif.temp" -b 2
    gdal_translate -a_ullr -17321655.5434 7332251.36559 17321655.5434 -7332251.36559 NETCDF:\"$FILE\".nc:perc_prcp $FILE"_precipitation_percentile_99.tif.temp" -b 3
    gdalwarp -s_srs EPSG:3975 -t_srs EPSG:4326 $FILE"_precipitation_percentile_85.tif.temp" $FILE"_precipitation_percentile_85.tif"
    gdalwarp -s_srs EPSG:3975 -t_srs EPSG:4326 $FILE"_precipitation_percentile_95.tif.temp" $FILE"_precipitation_percentile_95.tif"
    gdalwarp -s_srs EPSG:3975 -t_srs EPSG:4326 $FILE"_precipitation_percentile_99.tif.temp" $FILE"_precipitation_percentile_99.tif"

    DEL="${FILE}*.xml"	
    DEL2="${FILE}*.temp"
    rm -f $DEL $DEL2
fi
