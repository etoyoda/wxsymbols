#!/bin/sh
set -Ceuo pipefail

: ${webdir:=/var/www/html/wxsymbols}
: ${repos:=https://github.com/OGCMetOceanDWG/WorldWeatherSymbols}

cd WorldWeatherSymbols
test -d $webdir
sudoflags=$(ruby -e "s=File.stat('${webdir}'); printf '-u #%s -g #%s', s.uid, s.gid")

hyaku=$(ruby -e 'for ww in 0..99; printf("%02u\n", ww); end')

sdir=symbols/ww_PresentWeather
test -d $sdir
for ww in $hyaku 07a 07b
do
  w=$(expr $ww + 0 || :)
  test ! -f ${webdir}/w${w}.svg || continue
  sudo $sudoflags install -m 0644 \
    $sdir/WeatherSymbol_WMO_PresentWeather_ww_${ww}.svg \
    ${webdir}/w${w}.svg
done

sdir=symbols/wawa_PresentWeatherAutomaticStation
test -d $sdir
for ww in $hyaku
do
  w=$(expr $ww + 100 || :)
  test ! -f ${webdir}/w${w}.svg || continue
  test -f \
    $sdir/WeatherSymbol_WMO_PresentWeatherAutomaticStation_wawa_${ww}.svg \
    || continue
  sudo $sudoflags install -m 0644 \
    $sdir/WeatherSymbol_WMO_PresentWeatherAutomaticStation_wawa_${ww}.svg \
    ${webdir}/w${w}.svg
done

sdir=symbols/CH_CloudHigh
test -d $sdir
for ch in 1 2 3 4 5 6 7 8 9
do
  test ! -f ${webdir}/ch${ch}.svg || continue
  test -f \
    $sdir/WeatherSymbol_WMO_CloudHigh_CH_${ch}.svg || continue
  sudo $sudoflags install -m 0644 \
    $sdir/WeatherSymbol_WMO_CloudHigh_CH_${ch}.svg ${webdir}/ch${ch}.svg
done

sdir=symbols/CM_CloudMedium
test -d $sdir
for cm in 1 2 3 4 5 6 7 8 9
do
  test ! -f ${webdir}/cm${cm}.svg || continue
  test -f \
    $sdir/WeatherSymbol_WMO_CloudMedium_CM_${cm}.svg || continue
  sudo $sudoflags install -m 0644 \
    $sdir/WeatherSymbol_WMO_CloudMedium_CM_${cm}.svg ${webdir}/cm${cm}.svg
done

sdir=symbols/CL_CloudLow
test -d $sdir
for cl in 1 2 3 4 5 6 7 8 9
do
  test ! -f ${webdir}/cl${cl}.svg || continue
  test -f \
    $sdir/WeatherSymbol_WMO_CloudLow_CL_${cl}.svg || continue
  sudo $sudoflags install -m 0644 \
    $sdir/WeatherSymbol_WMO_CloudLow_CL_${cl}.svg ${webdir}/cl${cl}.svg
done


