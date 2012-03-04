Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1S42ix-0004ob-I6 for bitbake-devel@lists.openembedded.org;
	Sun, 04 Mar 2012 05:07:07 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q243wZd4020047
	for <bitbake-devel@lists.openembedded.org>; Sun, 4 Mar 2012 03:58:35 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 19635-08 for <bitbake-devel@lists.openembedded.org>;
	Sun,  4 Mar 2012 03:58:31 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q243wP1T019992
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>; Sun, 4 Mar 2012 03:58:28 GMT
Message-ID: <1330833508.3949.0.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sat, 03 Mar 2012 19:58:28 -0800
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] conf/classes: Catch up with bb.data -> direct object access conversion
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
X-List-Received-Date: Sun, 04 Mar 2012 04:07:07 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 classes/base.bbclass |    6 +++---
 conf/bitbake.conf    |   10 +++++-----
 lib/bb/cooker.py     |    2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/classes/base.bbclass b/classes/base.bbclass
index c6693ce..444b830 100644
--- a/classes/base.bbclass
+++ b/classes/base.bbclass
@@ -43,8 +43,8 @@ python do_showdata() {
 	bb.data.emit_env(sys.__stdout__, d, True)
 	# emit the metadata which isnt valid shell
 	for e in bb.data.keys(d):
-		if bb.data.getVarFlag(e, 'python', d):
-			sys.__stdout__.write("\npython %s () {\n%s}\n" % (e, bb.data.getVar(e, d, 1)))
+		if d.getVarFlag(e, 'python'):
+			sys.__stdout__.write("\npython %s () {\n%s}\n" % (e, d.getVar(e, 1)))
 }
 
 addtask listtasks
@@ -52,7 +52,7 @@ do_listtasks[nostamp] = "1"
 python do_listtasks() {
 	import sys
 	for e in bb.data.keys(d):
-		if bb.data.getVarFlag(e, 'task', d):
+		if d.getVarFlag(e, 'task'):
 			sys.__stdout__.write("%s\n" % e)
 }
 
diff --git a/conf/bitbake.conf b/conf/bitbake.conf
index b0c06a8..1ee4dc5 100644
--- a/conf/bitbake.conf
+++ b/conf/bitbake.conf
@@ -28,9 +28,9 @@ FETCHCOMMAND = ""
 FETCHCOMMAND_cvs = "/usr/bin/env cvs -d${CVSROOT} co ${CVSCOOPTS} ${CVSMODULE}"
 FETCHCOMMAND_svn = "/usr/bin/env svn co ${SVNCOOPTS} ${SVNROOT} ${SVNMODULE}"
 FETCHCOMMAND_wget = "/usr/bin/env wget -t 5 --passive-ftp -P ${DL_DIR} ${URI}"
-FILESDIR = "${@bb.utils.which(bb.data.getVar('FILESPATH', d, 1), '.')}"
+FILESDIR = "${@bb.utils.which(d.getVar('FILESPATH', 1), '.')}"
 FILESPATH = "${FILE_DIRNAME}/${PF}:${FILE_DIRNAME}/${P}:${FILE_DIRNAME}/${PN}:${FILE_DIRNAME}/files:${FILE_DIRNAME}"
-FILE_DIRNAME = "${@os.path.dirname(bb.data.getVar('FILE', d))}"
+FILE_DIRNAME = "${@os.path.dirname(d.getVar('FILE'))}"
 GITDIR = "${DL_DIR}/git"
 IMAGE_CMD = "_NO_DEFINED_IMAGE_TYPES_"
 IMAGE_ROOTFS = "${TMPDIR}/rootfs"
@@ -40,10 +40,10 @@ OVERRIDES = "local:${MACHINE}:${TARGET_OS}:${TARGET_ARCH}"
 P = "${PN}-${PV}"
 PERSISTENT_DIR = "${TMPDIR}/cache"
 PF = "${PN}-${PV}-${PR}"
-PN = "${@bb.parse.BBHandler.vars_from_file(bb.data.getVar('FILE',d),d)[0] or 'defaultpkgname'}"
-PR = "${@bb.parse.BBHandler.vars_from_file(bb.data.getVar('FILE',d),d)[2] or 'r0'}"
+PN = "${@bb.parse.BBHandler.vars_from_file(d.getVar('FILE'),d)[0] or 'defaultpkgname'}"
+PR = "${@bb.parse.BBHandler.vars_from_file(d.getVar('FILE'),d)[2] or 'r0'}"
 PROVIDES = ""
-PV = "${@bb.parse.BBHandler.vars_from_file(bb.data.getVar('FILE',d),d)[1] or '1.0'}"
+PV = "${@bb.parse.BBHandler.vars_from_file(d.getVar('FILE'),d)[1] or '1.0'}"
 RESUMECOMMAND = ""
 RESUMECOMMAND_wget = "/usr/bin/env wget -c -t 5 --passive-ftp -P ${DL_DIR} ${URI}"
 S = "${WORKDIR}/${P}"
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 558eadd..bf8389a 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -178,7 +178,7 @@ class BBCooker:
         self.configuration.data = bb.data.init()
 
         if not self.server_registration_cb:
-            bb.data.setVar("BB_WORKERCONTEXT", "1", self.configuration.data)
+            self.configuration.data.setVar("BB_WORKERCONTEXT", "1")
 
         filtered_keys = bb.utils.approved_variables()
         bb.data.inheritFromOS(self.configuration.data, self.savedenv, filtered_keys)




