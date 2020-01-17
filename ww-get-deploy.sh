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

