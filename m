Return-Path: <jean-marie.lemetayer@savoirfairelinux.com>
X-Greylist: delayed 338 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 17 May 2019 15:19:55 UTC
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
	[208.88.110.44])
	by mail.openembedded.org (Postfix) with ESMTP id 2E5497DF22
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 May 2019 15:19:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 9B4A79C0321
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 May 2019 11:14:19 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id iKWNA2I5cyOv for <bitbake-devel@lists.openembedded.org>; 
	Fri, 17 May 2019 11:14:19 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 286449C032A
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 May 2019 11:14:19 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id a0ZL7ImRrOJD for <bitbake-devel@lists.openembedded.org>; 
	Fri, 17 May 2019 11:14:19 -0400 (EDT)
Received: from sulaco.jml.bzh (91-167-182-132.subs.proxad.net [91.167.182.132])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id BF20C9C02EE
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 May 2019 11:14:18 -0400 (EDT)
From: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 17 May 2019 17:14:10 +0200
Message-Id: <20190517151410.8487-5-jean-marie.lemetayer@savoirfairelinux.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517151410.8487-1-jean-marie.lemetayer@savoirfairelinux.com>
References: <20190517151410.8487-1-jean-marie.lemetayer@savoirfairelinux.com>
MIME-Version: 1.0
Subject: [PATCH 4/4] npm: remove some temporary build files
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

Fixes [YOCTO #11028]

When dealing with node modules which use "node-gyp" [1] to build native
addons to node. Some temporary build files stay in the image: object
files, static library files, dependency files, ...

This commit does not keep only the required files, but remove the files
which can leads to QA issues (staticdev with static library files).

[1]: https://github.com/nodejs/node-gyp

Signed-off-by: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinu=
x.com>
---
 meta/classes/npm.bbclass | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meta/classes/npm.bbclass b/meta/classes/npm.bbclass
index 9703f4c1ec..4b1f0a39f0 100644
--- a/meta/classes/npm.bbclass
+++ b/meta/classes/npm.bbclass
@@ -56,6 +56,7 @@ npm_do_install() {
 	local NPM_PACKFILE=3D$(npm pack .)
 	npm install --prefix ${D}${prefix} -g --arch=3D${NPM_ARCH} --target_arc=
h=3D${NPM_ARCH} --production --no-registry ${NPM_PACKFILE}
 	ln -fs node_modules ${D}${libdir}/node
+	find ${D}${NPM_INSTALLDIR} -type f \( -name "*.a" -o -name "*.d" -o -na=
me "*.o" \) -delete
 	if [ -d ${D}${prefix}/etc ] ; then
 		# This will be empty
 		rmdir ${D}${prefix}/etc
--=20
2.20.1


