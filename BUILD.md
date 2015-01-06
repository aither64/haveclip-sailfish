Building HaveClip for SailfishOS
================================

Since QCA is not allowed by Harbour rules and certificate generation
is one of the key features,
it is [shipped alongside with HaveClip](https://harbour.jolla.com/faq#6.3.0).

QCA uses CMake so it cannot be sanely embedded as a subproject. It is therefore
prebuilt on the SDK machine, installed and linked against. QCA library files
are then copied to haveclip-mobile/lib/ and included in its RPM.

Installing QCA
--------------
The procedure below is implemented in helper script `utils/build-qca.sh`.

SSH into the MerSDK virtual machine, as described
in [FAQ](https://sailfishos.org/develop-faq.html) and execute following commands.

	[mersdk@SailfishSDK ~]$ mkdir tmp
	[mersdk@SailfishSDK ~]$ cd tmp
	[mersdk@SailfishSDK tmp]$ git clone https://github.com/nemomobile-packages/qca.git
	[mersdk@SailfishSDK tmp]$ cd qca/
	[mersdk@SailfishSDK qca]$ git submodule init
	[mersdk@SailfishSDK qca]$ git submodule update
	[mersdk@SailfishSDK qca]$ mb2 -t SailfishOS-i486 -s rpm/qca-qt5.spec build
	[mersdk@SailfishSDK qca]$ sb2 -t SailfishOS-i486 -m sdk-install -R zypper install RPMS/*.rpm

HaveClip can now be successfully built using Qt Creator, but to be able to run it
in the emulator, QCA libraries must be copied to the lib/ subdirectory.

Execute these commands from your project directory:

	$ cd haveclip-mobile
	$ mkdir -p lib/qca-qt5
	$ scp -P 2222 -i ~/SailfishOS/vmshare/ssh/private_keys/engine/root \
	  root@localhost:/usr/lib/libqca-qt5.so.2 lib/
	$ scp -P 2222 -i ~/SailfishOS/vmshare/ssh/private_keys/engine/root \
	  root@localhost:/usr/lib/qt5/plugins/qca-qt5/libqca-ossl.so lib/qca-qt5/

HaveClip can now be deployed and run in the emulator. To run HaveClip on the device itself,
repeat the procedure and set platform to `SailfishOS-armv7hl`.
