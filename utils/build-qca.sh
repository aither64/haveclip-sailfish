#!/bin/bash
#
# Usage: build-qca.sh arm | i486
#
# Build QCA in Mer SDK virtual machine for given platform, install it
# and copy libraries to lib/.
#
# Editable variables
SDK_DIR=~/SailfishOS
QCA_PLUGINS="ossl"

SDK_PORT=2222
SDK_IDENTITY="$SDK_DIR/vmshare/ssh/private_keys/engine/mersdk"

QCA_PKG_URL="https://github.com/nemomobile-packages/qca.git"
# ------------------

function usage {
	echo "Usage: build-qca.sh arm | i486"
	echo "Run it from haveclip-mobile top-level directory."
	echo
	echo "This script requires:"
	echo "  1) Linux or OS X"
	echo "  2) Running MerSDK virtual machine"
	echo "  3) Internet connection"
}

function title {
	echo "** $*"
}

function msg {
	echo "  > $*"
}

function ssh_sdk {
	ssh -t -p $SDK_PORT -i "$SDK_IDENTITY" mersdk@localhost $*
}

function scp_to_sdk {
	scp -P $SDK_PORT -i "$SDK_IDENTITY" $1 mersdk@localhost:$2
}

function scp_from_sdk {
	scp -P $SDK_PORT -i "$SDK_IDENTITY" mersdk@localhost:$1 $2
}

case "$1" in
	arm)
		PLATFORM="SailfishOS-armv7hl"
		;;
	i486)
		PLATFORM="SailfishOS-i486"
		;;
	*)
		echo "Invalid platform '$1'"
		usage
		exit 1
esac

title "Building QCA for $PLATFORM"

SCRIPT_PATH=$(mktemp)

cat > $SCRIPT_PATH <<EOF
#!/bin/bash

function msg {
	echo "  > \$*"
}

BUILD_DIR="tmp_$PLATFORM"

if [ -d "\$BUILD_DIR" ] ; then
	msg "Build directory already exists"
	read -p "Rebuild? y/n [n]: " rebuild
	
	if [ "\$rebuild" == "y" ] ; then
		rm -rf "\$BUILD_DIR"
	
	else
		exit 1
	fi
fi

mkdir \$BUILD_DIR
cd \$BUILD_DIR

msg "Fetching QCA"
git clone "$QCA_PKG_URL"
cd qca
git submodule init
git submodule update

msg "Building QCA"
mb2 -t $PLATFORM -s rpm/qca-qt5.spec build

msg "Installing QCA"
sb2 -t $PLATFORM -m sdk-install -R zypper --non-interactive install RPMS/*.rpm
EOF

TARGET_SCRIPT="/home/mersdk/build_$PLATFORM.sh"

scp_to_sdk $SCRIPT_PATH $TARGET_SCRIPT
rm $SCRIPT_PATH

ssh_sdk chmod +x $TARGET_SCRIPT
ssh_sdk $TARGET_SCRIPT

if [ "$?" == "1" ] ; then
	msg "Abort"
	exit 0
fi

ssh_sdk rm $TARGET_SCRIPT

msg "Copying libraries"
mkdir -p lib/qca-qt5

scp_from_sdk /srv/mer/targets/$PLATFORM/usr/lib/libqca-qt5.so.2 lib/

for plugin in $QCA_PLUGINS ; do
	scp_from_sdk /srv/mer/targets/$PLATFORM/usr/lib/qt5/plugins/qca-qt5/libqca-$plugin.so lib/qca-qt5/
done

title "Done"
