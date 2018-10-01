Return-Path: <jensr@external.miltenyibiotec.de>
X-Greylist: delayed 591 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 01 Oct 2018 09:02:13 UTC
Received: from esa2.miltenyibiotec.c3s2.iphmx.com
	(esa2.miltenyibiotec.c3s2.iphmx.com [68.232.139.204])
	by mail.openembedded.org (Postfix) with ESMTP id F104E74765
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  1 Oct 2018 09:02:13 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.54,327,1534813200"; 
   d="scan'208";a="4507890"
Received: from citrix.miltenyibiotec.de (HELO MgeExCasht2.miltenyibiotec.de)
	([193.99.246.29])
	by ob1.miltenyibiotec.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
	01 Oct 2018 07:52:22 -0100
From: Jens Rehsack | External Miltenyi Biotec
	<jensr@external.miltenyibiotec.de>
To: Mark Hatle <mark.hatle@windriver.com>
Thread-Topic: gitsm Fetcher update
Thread-Index: AdRZWFEVSGRG6CArQzGrr78f/k2GHw==
Date: Mon, 1 Oct 2018 08:52:21 +0000
Message-ID: <E7ABEDBFC1D25948BA30B74A3925A78C6093F6A6@MgeExchMbx1.miltenyibiotec.de>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.199.108.17]
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 01 Oct 2018 22:18:24 +0000
Cc: Volker Mink <VolkerMi@miltenyibiotec.de>, Burghard Bode | External Miltenyi
	Biotec <burghardb@external.miltenyibiotec.de>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	"rehsack@gmail.com" <rehsack@gmail.com>
Subject: gitsm Fetcher update
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 01 Oct 2018 09:02:14 -0000
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

after your last update to gitsm fetcher, it seems it cannot handle submodul=
es not using the master branch correctly:

--- BEGIN INITIAL ERROR
WARNING: automacs-ui-git-r0 do_fetch: Failed to fetch URL gitsm://mgegit.mi=
ltenyibiotec.de:7999/umsa/automacs-ui.git;protocol=3Dssh;branch=3Ddevelop;r=
ev=3Dfddb26a33d3f949d0863cffc5306146ab8e5a9a8, attempting MIRRORS if availa=
ble
ERROR: automacs-ui-git-r0 do_fetch: Fetcher failure for URL: 'gitsm://git@m=
gegit.miltenyibiotec.de:7999/cpsm/cmake-modules.git;protocol=3Dssh;name=3Dc=
make/modules;qbareclone=3D1;nocheckout=3D1'. Unable to fetch URL from any s=
ource.
ERROR: automacs-ui-git-r0 do_fetch: Fetcher failure for URL: 'gitsm://mgegi=
t.miltenyibiotec.de:7999/umsa/automacs-ui.git;protocol=3Dssh;branch=3Ddevel=
op;rev=3Dfddb26a33d3f949d0863cffc5306146ab8e5a9a8'. Unable to fetch URL fro=
m any source.
ERROR: automacs-ui-git-r0 do_fetch: Function failed: base_do_fetch
ERROR: Logfile of failure stored in: /home/sno/gpw-community-bsp/mops-yocto=
-platform/tmp/work/core2-64-poky-linux/automacs-ui/git-r0/temp/log.do_fetch=
.5452
ERROR: Task (/home/sno/gpw-community-bsp/sources/meta-miltenyi/recipes-ui/a=
utomacs-ui/automacs-ui_git.bb:do_fetch) failed with exit code '1'

DEBUG: Running export PSEUDO_DISABLED=3D1; export GIT_PROXY_COMMAND=3D"oe-g=
it-proxy"; export NO_PROXY=3D"*.miltenyibiotec.de,*.miltenyibiotec.com"; ex=
port https_proxy=3D"http://proxy2:8080/"; export http_proxy=3D"http://proxy=
2:8080/"; export PATH=3D"/home/sno/gpw-community-bsp/mops-yocto-platform/tm=
p/sysroots-uninative/x86_64-linux/usr/bin:/home/sno/gpw-community-bsp/sourc=
es/poky/scripts:/home/sno/gpw-community-bsp/mops-yocto-platform/tmp/work/co=
re2-64-poky-linux/automacs-ui/git-r0/recipe-sysroot-native/usr/bin/x86_64-p=
oky-linux:/home/sno/gpw-community-bsp/mops-yocto-platform/tmp/work/core2-64=
-poky-linux/automacs-ui/git-r0/recipe-sysroot/opt/miltenyi/bin/crossscripts=
:/home/sno/gpw-community-bsp/mops-yocto-platform/tmp/work/core2-64-poky-lin=
ux/automacs-ui/git-r0/recipe-sysroot-native/usr/sbin:/home/sno/gpw-communit=
y-bsp/mops-yocto-platform/tmp/work/core2-64-poky-linux/automacs-ui/git-r0/r=
ecipe-sysroot-native/usr/bin:/home/sno/gpw-community-bsp/mops-yocto-platfor=
m/tmp/work/core2-64-poky-linux/automacs-ui/git-r0/recipe-sysroot-native/sbi=
n:/home/sno/gpw-community-bsp/mops-yocto-platform/tmp/work/core2-64-poky-li=
nux/automacs-ui/git-r0/recipe-sysroot-native/bin:/home/sno/gpw-community-bs=
p/sources/poky/bitbake/bin:/home/sno/gpw-community-bsp/mops-yocto-platform/=
tmp/hosttools"; export HOME=3D"/home/sno"; git -c core.fsyncobjectfiles=3D0=
 branch --contains c6c052603e2e3ea334c5a71e3584855c5535995f --list master 2=
> /dev/null | wc -l
--- END INITIAL ERROR

I cloned the appropriate project locally to see what's going on:

sno@yoctopoc:~/prj/automacs-ui/cmake/modules$ git -c core.fsyncobjectfiles=
=3D0 branch --contains c6c052603e2e3ea334c5a71e3584855c5535995f --list
* (HEAD detached at c6c0526)
  develop
sno@yoctopoc:~/prj/automacs-ui/cmake/modules$ git -c core.fsyncobjectfiles=
=3D0 branch --contains c6c052603e2e3ea334c5a71e3584855c5535995f --list mast=
er
sno@yoctopoc:~/prj/automacs-ui/cmake/modules$

The I tried to reverse engineer the gitsm fetcher and added:

poky$ git diff
diff --git a/bitbake/lib/bb/fetch2/gitsm.py b/bitbake/lib/bb/fetch2/gitsm.p=
y
index 51f8d0e68c..221af934c3 100644
--- a/bitbake/lib/bb/fetch2/gitsm.py
+++ b/bitbake/lib/bb/fetch2/gitsm.py
@@ -79,6 +79,7 @@ class GitSM(Git):
             url +=3D ';protocol=3D%s' % proto
             url +=3D ";name=3D%s" % module
             url +=3D ";qbareclone=3D1;nocheckout=3D1"
+            url +=3D ";nobranch=3D1"

             ld =3D d.createCopy()
             # Not necessary to set SRC_URI, since we're passing the URI to

which results into=20

--- BEGIN FOLLOW UP ERROR
ERROR: automacs-ui-git-r0 do_unpack: Fetcher failure: Submodule cmake/modul=
es does not exist in /home/sno/gpw-community-bsp/mops-yocto-platform/downlo=
ads/git2/mgegit.miltenyibiotec.de.7999.umsa.automacs-ui.git/modules/cmake/m=
odules or /home/sno/gpw-community-bsp/mops-yocto-platform/tmp/work/core2-64=
-poky-linux/automacs-ui/git-r0/git/.git/modules/cmake/modules.
ERROR: automacs-ui-git-r0 do_unpack: Function failed: base_do_unpack
ERROR: Logfile of failure stored in: /home/sno/gpw-community-bsp/mops-yocto=
-platform/tmp/work/core2-64-poky-linux/automacs-ui/git-r0/temp/log.do_unpac=
k.6551
ERROR: Task (/home/sno/gpw-community-bsp/sources/meta-miltenyi/recipes-ui/a=
utomacs-ui/automacs-ui_git.bb:do_unpack) failed with exit code '1'
--- END FOLLOW UP ERROR

because it uses the submodule names as archive name:

$ tar xzf downloads/git2_mgegit.miltenyibiotec.de.7999.<TAB>
git2_mgegit.miltenyibiotec.de.7999.cpsm.cmake-modules.git.tar.gz
git2_mgegit.miltenyibiotec.de.7999.cpsm.mcs-lib.git.tar.gz
git2_mgegit.miltenyibiotec.de.7999.umsa.corert.git.tar.gz
git2_mgegit.miltenyibiotec.de.7999.umsa.protos.git.tar.gz

Cheers,
Jens


