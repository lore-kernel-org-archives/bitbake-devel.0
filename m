Return-Path: <jean-marie.lemetayer@savoirfairelinux.com>
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
	[208.88.110.44])
	by mail.openembedded.org (Postfix) with ESMTP id 2D5FB7DF0B
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 May 2019 15:19:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 459809C032B
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 May 2019 11:14:19 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id QkdbMybq6TRX for <bitbake-devel@lists.openembedded.org>; 
	Fri, 17 May 2019 11:14:18 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id AA5BB9C0321
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 May 2019 11:14:18 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id AbR-SEPqZlYe for <bitbake-devel@lists.openembedded.org>; 
	Fri, 17 May 2019 11:14:18 -0400 (EDT)
Received: from sulaco.jml.bzh (91-167-182-132.subs.proxad.net [91.167.182.132])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 4B24E9C02EE
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 May 2019 11:14:18 -0400 (EDT)
From: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 17 May 2019 17:14:09 +0200
Message-Id: <20190517151410.8487-4-jean-marie.lemetayer@savoirfairelinux.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517151410.8487-1-jean-marie.lemetayer@savoirfairelinux.com>
References: <20190517151410.8487-1-jean-marie.lemetayer@savoirfairelinux.com>
MIME-Version: 1.0
Subject: [PATCH 3/4] npm: fix node and npm default directory conflict
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
X-List-Received-Date: Fri, 17 May 2019 15:19:56 -0000
Content-Transfer-Encoding: quoted-printable

Fixes [YOCTO #13349]

When dealing with node modules which have declared "bin" files [1], npm
will create a link in '/usr/bin' with a relative link to
'../lib/node_modules/<module bin file>'.

The commits e9270af4296ce2af292059617a717e42fc17425c and
2713d9bcc39c712ef34003ce8424416441be558e explicitely use
'/usr/lib/node/' as install directory, but does not care about the "bin"
symbolic linked files.

In order to keep valid links, and to keep it as simple as possible, the
path '/usr/lib/node_modules/' is used as install directory for npm. And
a symbolic link is created to have a valid '/usr/lib/node/' path, needed
for node.

[1]: https://docs.npmjs.com/files/package.json#bin

Signed-off-by: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinu=
x.com>
---
 meta/classes/npm.bbclass | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/meta/classes/npm.bbclass b/meta/classes/npm.bbclass
index 3dd2d13804..9703f4c1ec 100644
--- a/meta/classes/npm.bbclass
+++ b/meta/classes/npm.bbclass
@@ -10,7 +10,7 @@ def node_pkgname(d):
=20
 NPMPN ?=3D "${@node_pkgname(d)}"
=20
-NPM_INSTALLDIR =3D "${libdir}/node/${NPMPN}"
+NPM_INSTALLDIR =3D "${libdir}/node_modules/${NPMPN}"
=20
 # function maps arch names to npm arch names
 def npm_oe_arch_map(target_arch, d):
@@ -55,7 +55,7 @@ npm_do_install() {
 	mkdir -p ${D}${libdir}/node_modules
 	local NPM_PACKFILE=3D$(npm pack .)
 	npm install --prefix ${D}${prefix} -g --arch=3D${NPM_ARCH} --target_arc=
h=3D${NPM_ARCH} --production --no-registry ${NPM_PACKFILE}
-	mv ${D}${libdir}/node_modules ${D}${libdir}/node
+	ln -fs node_modules ${D}${libdir}/node
 	if [ -d ${D}${prefix}/etc ] ; then
 		# This will be empty
 		rmdir ${D}${prefix}/etc
@@ -85,6 +85,8 @@ python populate_packages_prepend () {
 }
=20
 FILES_${PN} +=3D " \
+    ${bindir} \
+    ${libdir}/node \
     ${NPM_INSTALLDIR} \
 "
=20
--=20
2.20.1


