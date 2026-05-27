= 簡易インストール

とりあえず

 1990  git clone git@github.com:etoyoda/wxsymbols.git
 1992  cd wxsymbols/
 2000  sudo install -d -o www-data -g www-data /var/www/html/wxsymbols
 2001  sudo install -m 0644 -o www-data img/*.png /var/www/html/wxsymbols
 2004  sudo install -m 0644 -o www-data img/*.html /var/www/html/wxsymbols

 2024  git clone https://github.com/OGCMetOceanDWG/WorldWeatherSymbols
 2025  bash -x ww-get-deploy.sh
