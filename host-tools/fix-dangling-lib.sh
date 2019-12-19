#!/bin/sh

DANGLE_LINKS=`find $INSTALL_PATH -type l ! -exec test -e {} \; -print`
#find $INSTALL_PATH -xtype l

if [ -z "$DANGLE_LINKS" ]; then
    echo "No dangling library was found."
    exit 0
fi

echo "Below are the dangling library links:"
echo "$DANGLE_LINKS"

echo "Trying to fix them..."

echo "$DANGLE_LINKS" |
while read -r filename
do
    dst_lib_name=$(basename $(readlink $filename))
    dst_path=$(find $INSTALL_PATH -name $dst_lib_name -exec dirname {} \;)
    echo "Create link: $dst_path/$(basename $filename) -> $dst_path/$dst_lib_name"
    ln -nfs $dst_path/$dst_lib_name $dst_path/$(basename $filename)
    rm $filename
done
