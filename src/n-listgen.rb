#!/usr/bin/ruby

puts <<HTML
<html>
<head>
<title>list of N cloud circle</title>
</head>
<body>
<table>
HTML

(0..9).each {|n|
  puts "<tr><th>N=#{n}</th><td><img src=\"n#{n}.png\" /></td></tr>"
}

  puts "<tr><th>N=/</th><td><img src=\"nnil.png\" /></td></tr>"
  puts "<tr><th>N=/ AUTO</th><td><img src=\"nauto.png\" /></td></tr>"

puts <<HTML
</table>
</body>
</html>
HTML
