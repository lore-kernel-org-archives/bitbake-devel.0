Return-Path: <danismostlikely@gmail.com>
Received: from mail-ig0-f177.google.com (mail-ig0-f177.google.com
	[209.85.213.177])
	by mail.openembedded.org (Postfix) with ESMTP id 5EF2773EFD
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 May 2015 01:49:50 +0000 (UTC)
Received: by iget9 with SMTP id t9so84448732ige.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 May 2015 18:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:subject:date:message-id;
	bh=2gD1wsC3E/VtFG4m+ixk+zZfoG8lEzi5WjV/HFKWQPw=;
	b=UlFHMFrSGylmPssAOPkEc0hkbL6TjMWb5VoYKn8q6V0oT/dGKCefLyPS81O07iYubW
	7wyhKMfzPJrKSHkBSD9TYbMt93GluLvDJAOjZocZeZG8gmqpC/32t67B7uzAtoCVanLc
	K26vkk0Is/GaEfhoTaEuJWS+SILhzhRQ8+wZ7cueUEz+JzRND9Clb1+INGW+GRGqQVay
	5EfYd/g2DPz+qnTdn8KlI8WOQqv5be7hx0KcksuuEUFZv33zCT0PEvdb0E/1P3SYaCF+
	jTPyHvyk+iLW0kt6H1SHZDq+tQobjyB2gA9J5j4xuohggKtb++2Uh4s7R6RDtlNZnAHw
	eIUw==
X-Received: by 10.107.9.141 with SMTP id 13mr16848919ioj.71.1431395391355;
	Mon, 11 May 2015 18:49:51 -0700 (PDT)
Received: from mediabox.local (71-17-233-74.sktn.hsdb.sasknet.sk.ca.
	[71.17.233.74]) by mx.google.com with ESMTPSA id
	k74sm10982720iok.30.2015.05.11.18.49.50
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 11 May 2015 18:49:50 -0700 (PDT)
From: Dan McGregor <danismostlikely@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 11 May 2015 19:49:47 -0600
Message-Id: <1431395387-4529-1-git-send-email-danismostlikely@gmail.com>
X-Mailer: git-send-email 2.4.0
Subject: [PATCH v3] fetch/hg: support submodules
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
X-List-Received-Date: Tue, 12 May 2015 01:49:52 -0000

From: Daniel McGregor <daniel.mcgregor@vecima.com>

Use hg clone and hg pull to copy the source into the build
directory rather than taring up the cloned repository and
untarring in the destination.

This allows submodules to be cloned. While here, make the default
behaviour keep the hg scm data to match the behaviour of the git
fetcher.

Signed-off-by: Daniel McGregor <daniel.mcgregor@vecima.com>
---
 lib/bb/fetch2/hg.py | 56 +++++++++++++++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 19 deletions(-)

diff --git a/lib/bb/fetch2/hg.py b/lib/bb/fetch2/hg.py
index 81592f6..5bc36c0 100644
--- a/lib/bb/fetch2/hg.py
+++ b/lib/bb/fetch2/hg.py
@@ -64,7 +64,9 @@ class Hg(FetchMethod):
         elif not ud.revision:
             ud.revision = self.latest_revision(ud, d)
 
-        ud.localfile = data.expand('%s_%s_%s_%s.tar.gz' % (ud.module.replace('/', '.'), ud.host, ud.path.replace('/', '.'), ud.revision), d)
+        ud.localfile = ud.moddir
+
+        ud.basecmd = data.getVar("FETCHCMD_hg", d, True) or "/usr/bin/env hg"
 
     def need_update(self, ud, d):
         revTag = ud.parm.get('rev', 'tip')
@@ -80,8 +82,6 @@ class Hg(FetchMethod):
         command is "fetch", "update", "info"
         """
 
-        basecmd = data.expand('${FETCHCMD_hg}', d)
-
         proto = ud.parm.get('protocol', 'http')
 
         host = ud.host
@@ -98,7 +98,7 @@ class Hg(FetchMethod):
                 hgroot = ud.user + "@" + host + ud.path
 
         if command == "info":
-            return "%s identify -i %s://%s/%s" % (basecmd, proto, hgroot, ud.module)
+            return "%s identify -i %s://%s/%s" % (ud.basecmd, proto, hgroot, ud.module)
 
         options = [];
 
@@ -111,22 +111,22 @@ class Hg(FetchMethod):
 
         if command == "fetch":
             if ud.user and ud.pswd:
-                cmd = "%s --config auth.default.prefix=* --config auth.default.username=%s --config auth.default.password=%s --config \"auth.default.schemes=%s\" clone %s %s://%s/%s %s" % (basecmd, ud.user, ud.pswd, proto, " ".join(options), proto, hgroot, ud.module, ud.module)
+                cmd = "%s --config auth.default.prefix=* --config auth.default.username=%s --config auth.default.password=%s --config \"auth.default.schemes=%s\" clone %s %s://%s/%s %s" % (ud.basecmd, ud.user, ud.pswd, proto, " ".join(options), proto, hgroot, ud.module, ud.module)
             else:
-                cmd = "%s clone %s %s://%s/%s %s" % (basecmd, " ".join(options), proto, hgroot, ud.module, ud.module)	      
+                cmd = "%s clone %s %s://%s/%s %s" % (ud.basecmd, " ".join(options), proto, hgroot, ud.module, ud.module)
         elif command == "pull":
             # do not pass options list; limiting pull to rev causes the local
             # repo not to contain it and immediately following "update" command
             # will crash
             if ud.user and ud.pswd:
-                cmd = "%s --config auth.default.prefix=* --config auth.default.username=%s --config auth.default.password=%s --config \"auth.default.schemes=%s\" pull" % (basecmd, ud.user, ud.pswd, proto)
+                cmd = "%s --config auth.default.prefix=* --config auth.default.username=%s --config auth.default.password=%s --config \"auth.default.schemes=%s\" pull" % (ud.basecmd, ud.user, ud.pswd, proto)
             else:
-                cmd = "%s pull" % (basecmd)
+                cmd = "%s pull" % (ud.basecmd)
         elif command == "update":
             if ud.user and ud.pswd:
-                cmd = "%s --config auth.default.prefix=* --config auth.default.username=%s --config auth.default.password=%s --config \"auth.default.schemes=%s\" update -C %s" % (basecmd, ud.user, ud.pswd, proto, " ".join(options))
+                cmd = "%s --config auth.default.prefix=* --config auth.default.username=%s --config auth.default.password=%s --config \"auth.default.schemes=%s\" update -C %s" % (ud.basecmd, ud.user, ud.pswd, proto, " ".join(options))
             else:
-                cmd = "%s update -C %s" % (basecmd, " ".join(options))
+                cmd = "%s update -C %s" % (ud.basecmd, " ".join(options))
         else:
             raise FetchError("Invalid hg command %s" % command, ud.url)
 
@@ -163,15 +163,6 @@ class Hg(FetchMethod):
         logger.debug(1, "Running %s", updatecmd)
         runfetchcmd(updatecmd, d)
 
-        scmdata = ud.parm.get("scmdata", "")
-        if scmdata == "keep":
-            tar_flags = ""
-        else:
-            tar_flags = "--exclude '.hg' --exclude '.hgrags'"
-
-        os.chdir(ud.pkgdir)
-        runfetchcmd("tar %s -czf %s %s" % (tar_flags, ud.localpath, ud.module), d, cleanup = [ud.localpath])
-
     def supports_srcrev(self):
         return True
 
@@ -191,3 +182,30 @@ class Hg(FetchMethod):
         Return a unique key for the url
         """
         return "hg:" + ud.moddir
+
+    def localpath(self, ud, d):
+        return ud.moddir
+
+    def unpack(self, ud, destdir, d):
+        """
+        Make a local clone or export for the url
+        """
+
+        revflag = "-r %s" % ud.revision
+        subdir = ud.parm.get("destsuffix", ud.module)
+        codir = "%s/%s" % (destdir, subdir)
+
+        scmdata = ud.parm.get("scmdata", "")
+        if scmdata != "nokeep":
+            if os.access(os.path.join(codir, '.hg'), os.R_OK):
+                logger.debug(2, "Unpack: updating source in '" + codir + "'")
+                os.chdir(codir)
+                runfetchcmd("%s pull %s" % (ud.basecmd, ud.moddir), d)
+                runfetchcmd("%s up -c -C %s" % revflag, d)
+            else:
+                logger.debug(2, "Unpack: cloning source to '" + codir + "'")
+                runfetchcmd("%s clone %s -u %s %s/ %s" % (ud.basecmd, revflag, ud.revision, ud.moddir, codir), d)
+        else:
+            logger.debug(2, "Unpack: extracting source to '" + codir + "'")
+            os.chdir(ud.moddir)
+            runfetchcmd("%s archive -t files %s %s" % (ud.basecmd, revflag, codir), d)
-- 
2.4.0


