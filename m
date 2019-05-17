Return-Path: <jean-marie.lemetayer@savoirfairelinux.com>
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
	[208.88.110.44])
	by mail.openembedded.org (Postfix) with ESMTP id 2F4207DF23
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 May 2019 15:19:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id A2A179C031E
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 May 2019 11:14:18 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id mu5kZENpHfEA for <bitbake-devel@lists.openembedded.org>; 
	Fri, 17 May 2019 11:14:18 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 31CA99C0321
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 May 2019 11:14:18 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id OdFzGwDsGnmN for <bitbake-devel@lists.openembedded.org>; 
	Fri, 17 May 2019 11:14:18 -0400 (EDT)
Received: from sulaco.jml.bzh (91-167-182-132.subs.proxad.net [91.167.182.132])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id CAFA99C02EE
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 May 2019 11:14:17 -0400 (EDT)
From: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 17 May 2019 17:14:08 +0200
Message-Id: <20190517151410.8487-3-jean-marie.lemetayer@savoirfairelinux.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517151410.8487-1-jean-marie.lemetayer@savoirfairelinux.com>
References: <20190517151410.8487-1-jean-marie.lemetayer@savoirfairelinux.com>
MIME-Version: 1.0
Subject: [PATCH 2/4] npm: get npm package name from npm pack
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

Fixes [YOCTO #12534]

When using npm packages with exotic names, like "JSONSelect" (with
uppercase) or "@angular/cli" (with at sign and slash), there are three
different names:
  - the recipe name ("jsonselect" or "angular-cli")
  - the npm module name ("JSONSelect" or "@angular/cli")
  - the npm pack name ("JSONSelect" or "angular-cli")

The commit fa9c077068a2acea04389fa2b44eb2e93548fce2 allow to have
different recipe name and npm module name by setting the NPMPN variable.

This commit allows to have yet another npm pack name. The pack filename
is now dynamically retrieved from the 'npm pack' command.

Signed-off-by: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinu=
x.com>
---
 meta/classes/npm.bbclass | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/meta/classes/npm.bbclass b/meta/classes/npm.bbclass
index 6dbae6bc79..3dd2d13804 100644
--- a/meta/classes/npm.bbclass
+++ b/meta/classes/npm.bbclass
@@ -53,8 +53,8 @@ npm_do_install() {
 	# be created in this directory
 	export HOME=3D${WORKDIR}
 	mkdir -p ${D}${libdir}/node_modules
-	npm pack .
-	npm install --prefix ${D}${prefix} -g --arch=3D${NPM_ARCH} --target_arc=
h=3D${NPM_ARCH} --production --no-registry ${NPMPN}-${PV}.tgz
+	local NPM_PACKFILE=3D$(npm pack .)
+	npm install --prefix ${D}${prefix} -g --arch=3D${NPM_ARCH} --target_arc=
h=3D${NPM_ARCH} --production --no-registry ${NPM_PACKFILE}
 	mv ${D}${libdir}/node_modules ${D}${libdir}/node
 	if [ -d ${D}${prefix}/etc ] ; then
 		# This will be empty
--=20
2.20.1


