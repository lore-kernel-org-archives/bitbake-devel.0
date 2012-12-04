Received: from heron.softorchestra.com ([63.192.205.162])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <aland@SoftOrchestra.com>) id 1TfhiQ-00014g-22
	for bitbake-devel@lists.openembedded.org;
	Tue, 04 Dec 2012 02:54:30 +0100
Received: from heron.softorchestra.com (heron.softorchestra.com [192.168.1.50])
	by heron.softorchestra.com (MTX) with ESMTP id 4FC322C15AE
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  3 Dec 2012 17:40:06 -0800 (PST)
Date: Mon, 3 Dec 2012 17:40:06 -0800 (PST)
From: Alan DuBoff <aland@SoftOrchestra.com>
To: bitbake-devel@lists.openembedded.org
Message-ID: <alpine.DEB.2.02.1212031731330.5149@heron.softorchestra.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Subject: autotools project won't install
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 04 Dec 2012 01:54:30 -0000
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII

I created a recipe for an autotools project I'm working on.

Seems that it is able to fetch the sources, configure, and compile, but it 
fails to install.

The package normally installs to /usr/local/bin

In order to create the recipe I tried several things, but all seem to fail 
during the do_install.

Seems I should be able to just have the SRC_URI in the recipe along with 
"inherit autotools" and all the functionality of autotools will be taken 
care of. However, that isn't the case.

Would this mean my autotools files are somehow incorrect?

This program compiles fine for both native and arm7 (using a BeagleBone 
for development).

For native x86:

configure
make
make install

for arm:

configure --host=arm-angstrom-linux-gnueabi
make
make install

However, my recipe breaks. My recipe is below. Most everything is 
commented out, which should work with an autotools program.

Any hints on why this doesn't work?

--

Regards,
Alan

DESCRIPTION = "Fiber Locator Server for Vivax-Metrotech"
LICENSE = "GPLv3+"
SECTION = "console/network"
LIC_FILES_CHKSUM = 
"file:///home/aland/src/vxmt/FLS/COPYING;md5=d32239bcb673463ab874e80d47fae504"
PR = "r2"
SRC_URI = "file:///home/aland/src/vxmt/FLS/"
# DEPENDS = ""

S = "${WORKDIR}"

#       do_configure () {
#         ./configure 
--prefix=/home/aland/src/angstrom/build/tmp-angstrom_v2012_05-eglibc/sysroots/beaglebone 
--host=arm-angstrom-linux-gnueabi
#       }
#
#       do_compile () {
#       # 
DESTDIR=/home/aland/src/angstrom/build/tmp-angstrom_v2012_05-eglibc/work/armv7a-angstrom-linux-gnueabi/metrotech-fls-1.0-r2/FLS/
#         make -C 
/home/aland/src/angstrom/build/tmp-angstrom_v2012_05-eglibc/work/armv7a-angstrom-linux-gnueabi/metrotech-fls-1.0-r2/FLS/
#       #  oe_runmake
#       }
#
#       do_install () {
# 
#DESTDIR=/home/aland/src/angstrom/build/tmp-angstrom_v2012_05-eglibc/work/armv7a-angstrom-linux-gnueabi/metrotech-fls-1.0-r2/FLS/ 
oe_runmake install
#       # make install
#           install -d ${D}/usr/local/bin
#           install -m 0755 OrcaTX.out ${D}/usr/local/bin
#       # install -m 0644  ${WORKDIR}
#       # oe_runmake 'DESTDIR=${D}' install
#       # oe_runmake install DESTDIR=${D}
#       }

FILES_${PN} = "/usr/local/bin/OrcaTX.out"

inherit autotools



