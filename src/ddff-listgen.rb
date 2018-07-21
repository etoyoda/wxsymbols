#!/usr/bin/ruby

puts <<HTML
<html>
<head>
<title>list of wind symbols</title>
</head>
<body>
<table>
HTML

ffs = (1..20).to_a.map{|i| i * 5}
ffs += [110, 120, 130, 150, 200, 250]
puts "<tr><th>/</th>"
ffs.each {|ff| puts "<th>ff=#{ff}</th>" }
puts "</tr>"

dds = (1..36).to_a
dds.each {|dd|
  puts "<tr><th>dd=#{dd}</th>"
  ffs.each {|ff| puts "<td><img src='d#{dd}f#{ff}.png'></td>" }
  puts "</tr>"
}
