Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id B6F6377A19
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  5 Apr 2017 09:07:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTP id v3597347010915; 
	Wed, 5 Apr 2017 10:07:04 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 5U7OnIBqvO-f; Wed,  5 Apr 2017 10:07:03 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v358d36a007588
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Wed, 5 Apr 2017 09:39:04 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1cvgT1-0003wk-Bs; Wed, 05 Apr 2017 09:39:03 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  5 Apr 2017 09:39:02 +0100
Message-Id: <1491381542-15132-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH] fetch/local: Drop FILESDIR
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
X-List-Received-Date: Wed, 05 Apr 2017 09:07:05 -0000

This has long since been deprecated and is no longer used anywhere, FILESPATH
is the commonly used varaible which offers much more flexibility. Remove
the FILESDIR code and references from bitbake.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 conf/bitbake.conf                                      |  1 -
 .../bitbake-user-manual-fetching.xml                   |  9 ---------
 .../bitbake-user-manual-ref-variables.xml              | 18 ------------------
 lib/bb/fetch2/local.py                                 |  9 ---------
 4 files changed, 37 deletions(-)

diff --git a/conf/bitbake.conf b/conf/bitbake.conf
index deb36aa..a460df4 100644
--- a/conf/bitbake.conf
+++ b/conf/bitbake.conf
@@ -24,7 +24,6 @@ DEPENDS = ""
 DEPLOY_DIR = "${TMPDIR}/deploy"
 DEPLOY_DIR_IMAGE = "${DEPLOY_DIR}/images"
 DL_DIR = "${TMPDIR}/downloads"
-FILESDIR = "${@bb.utils.which(d.getVar('FILESPATH', True), '.')}"
 FILESPATH = "${FILE_DIRNAME}/${PF}:${FILE_DIRNAME}/${P}:${FILE_DIRNAME}/${PN}:${FILE_DIRNAME}/files:${FILE_DIRNAME}"
 FILE_DIRNAME = "${@os.path.dirname(d.getVar('FILE', False))}"
 GITDIR = "${DL_DIR}/git"
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml b/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml
index 3f1d8eb..d1ce43e 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml
@@ -268,15 +268,6 @@
                 <link linkend='var-FILESPATH'><filename>FILESPATH</filename></link>
                 variable is used in the same way
                 <filename>PATH</filename> is used to find executables.
-                Failing that,
-                <link linkend='var-FILESDIR'><filename>FILESDIR</filename></link>
-                is used to find the appropriate relative file.
-                <note>
-                    <filename>FILESDIR</filename> is deprecated and can
-                    be replaced with <filename>FILESPATH</filename>.
-                    Because <filename>FILESDIR</filename> is likely to be
-                    removed, you should not use this variable in any new code.
-                </note>
                 If the file cannot be found, it is assumed that it is available in
                 <link linkend='var-DL_DIR'><filename>DL_DIR</filename></link>
                 by the time the <filename>download()</filename> method is called.
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml
index 66d8f84..0e89bf2 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml
@@ -1539,24 +1539,6 @@
             </glossdef>
         </glossentry>
 
-        <glossentry id='var-FILESDIR'><glossterm>FILESDIR</glossterm>
-            <glossdef>
-                <para>
-                    Specifies directories BitBake uses when searching for
-                    patches and files.
-                    The "local" fetcher module uses these directories when
-                    handling <filename>file://</filename> URLs if the file
-                    was not found using
-                    <link linkend='var-FILESPATH'><filename>FILESPATH</filename></link>.
-                    <note>
-                        The <filename>FILESDIR</filename> variable is
-                        deprecated and you should use
-                        <filename>FILESPATH</filename> in all new code.
-                    </note>
-                </para>
-            </glossdef>
-        </glossentry>
-
         <glossentry id='var-FILESPATH'><glossterm>FILESPATH</glossterm>
             <glossdef>
                 <para>
diff --git a/lib/bb/fetch2/local.py b/lib/bb/fetch2/local.py
index 2ff7723..a114ac1 100644
--- a/lib/bb/fetch2/local.py
+++ b/lib/bb/fetch2/local.py
@@ -67,12 +67,6 @@ class Local(FetchMethod):
             logger.debug(2, "Searching for %s in paths:\n    %s" % (path, "\n    ".join(filespath.split(":"))))
             newpath, hist = bb.utils.which(filespath, path, history=True)
             searched.extend(hist)
-        if not newpath:
-            filesdir = d.getVar('FILESDIR')
-            if filesdir:
-                logger.debug(2, "Searching for %s in path: %s" % (path, filesdir))
-                newpath = os.path.join(filesdir, path)
-                searched.append(newpath)
         if (not newpath or not os.path.exists(newpath)) and path.find("*") != -1:
             # For expressions using '*', best we can do is take the first directory in FILESPATH that exists
             newpath, hist = bb.utils.which(filespath, ".", history=True)
@@ -102,9 +96,6 @@ class Local(FetchMethod):
             filespath = d.getVar('FILESPATH')
             if filespath:
                 locations = filespath.split(":")
-            filesdir = d.getVar('FILESDIR')
-            if filesdir:
-                locations.append(filesdir)
             locations.append(d.getVar("DL_DIR"))
 
             msg = "Unable to find file " + urldata.url + " anywhere. The paths that were searched were:\n    " + "\n    ".join(locations)
-- 
2.7.4


