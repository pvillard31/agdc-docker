#/bin/bash


if [ "$#" -ne 1 ]; then
    echo "Usage: ./handleSmosPicture.sh <NC File>"
else
    filename=$(basename "$1")
    extension="${filename##*.}"
    FILE="${filename%.*}"
    tar -xvzf $1
    java -jar /data/agdc/grib-converter.jar $FILE".DBL" $FILE".nc"
    gdal_translate -a_ullr -17321655.5434 7332251.36559 17321655.5434 -7332251.36559 NETCDF:\"$FILE\".nc:Soil_Moisture $FILE"_Soil_Moisture.tif.temp"
    gdal_translate -a_ullr -17321655.5434 7332251.36559 17321655.5434 -7332251.36559 NETCDF:\"$FILE\".nc:Soil_Moisture_Dqx $FILE"_Soil_Moisture_Dqx.tif.temp"
    gdalwarp -s_srs EPSG:3975 -t_srs EPSG:4326 $FILE"_Soil_Moisture.tif.temp" $FILE"_Soil_Moisture.tif"
    gdalwarp -s_srs EPSG:3975 -t_srs EPSG:4326 $FILE"_Soil_Moisture_Dqx.tif.temp" $FILE"_Soil_Moisture_Dqx.tif"
    rm -f $FILE"_Soil_Moisture.tif.temp" $FILE"_Soil_Moisture_Dqx.tif.temp" $FILE".nc" $FILE".DBL"
fi
