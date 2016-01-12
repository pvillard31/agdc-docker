#/bin/bash


if [ "$#" -ne 1 ]; then
    echo "Usage: ./handleForecastPicture.sh <prevision_file>"
else
    FILE=$(basename "$1")

    java -jar /data/agdc/grib-converter.jar $FILE $FILE".nc"

    gdal_translate -a_ullr -17321655.5434 7332251.36559 17321655.5434 -7332251.36559 NETCDF:\"$FILE\".nc:Total_precipitation $FILE"_total_precipitation.tif.temp"
    gdalwarp -s_srs EPSG:3975 -t_srs EPSG:4326 $FILE"_total_precipitation.tif.temp" $FILE"_total_precipitation.tif"

    DEL="${FILE}*.xml"	
    DEL2="${FILE}*.temp"
    DEL3="${FILE}*.gbx8"
    DEL4="${FILE}.nc"
    rm -f $DEL $DEL2 $DEL3 $DEL4
fi
