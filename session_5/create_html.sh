#!/bin/bash
file="html/files/index.html"
mkdir -p html/files/
touch $file
echo "<html>
<head>
<title>Dummy page</title>
</head>
<body>" >> $file
cat text.txt >> $file
echo "</body>
</html>" >> $file
ln $file html/index.html
ln -s "$(pwd)/"$file "$(pwd)/"index.lnk
chmod 661 $file
