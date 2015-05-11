Return-Path: <danismostlikely@gmail.com>
Received: from mail-ig0-f169.google.com (mail-ig0-f169.google.com
	[209.85.213.169])
	by mail.openembedded.org (Postfix) with ESMTP id 8F8DD73F92
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 May 2015 20:26:14 +0000 (UTC)
Received: by igbyr2 with SMTP id yr2so82146267igb.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 May 2015 13:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=FcLEEO9Q/pX6xtbY01LTDuCZNtJVak0P3NnLsGh1bJs=;
	b=sNI3DQ2+IsPrxLz86yK2uTkHFN/GqaaDym6A0dTKRTGQTWJVufjJQ9SM0nF9hhq2xv
	xje5+QganSwWfT6ElmOGsFzGyKOZaRJBwKzi10K507O63uaoP11cTxL9t+0xEysRc1uP
	ZLqpFhpza2t0E6RT9zmL0U5dbTqYmDjTr+AlFAH/zSwzyXS2xnk6fOOO8Rgxpbpy0qoE
	zyCebQo3r/8dkN7jYvxnIuFJimtem9HNNt97g0oS07CmsSM7ozDESD5CuPM/NMwf+dr3
	p03Gb0Khj464WtnGW4/9SE1iHWjNC/d48n/bzjSZ4HjatzNc/e/r9O31j5On+r6JK+Va
	xdJA==
X-Received: by 10.43.60.76 with SMTP id wr12mr12857436icb.83.1431375975444;
	Mon, 11 May 2015 13:26:15 -0700 (PDT)
Received: from mediabox.local (71-17-233-74.sktn.hsdb.sasknet.sk.ca.
	[71.17.233.74]) by mx.google.com with ESMTPSA id
	p87sm10403659ioi.42.2015.05.11.13.26.14
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 11 May 2015 13:26:14 -0700 (PDT)
From: Dan McGregor <danismostlikely@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 11 May 2015 14:26:13 -0600
Message-Id: <1431375973-16390-1-git-send-email-danismostlikely@gmail.com>
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1431375543-13831-1-git-send-email-danismostlikely@gmail.com>
References: <1431375543-13831-1-git-send-email-danismostlikely@gmail.com>
Subject: [PATCH v2] fetch/hg: support submodules
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
X-List-Received-Date: Mon, 11 May 2015 20:26:15 -0000

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
index 81592f6..ce755b2 100644
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
+                runfetchcmd("%s pull %s" % (ud.basecmd, ud.moddir))
+                runfetchcmd("%s up -c -C %s" % revflag)
+            else:
+                logger.debug(2, "Unpack: cloning source to '" + codir + "'")
+                runfetchcmd("%s clone %s -u %s %s/ %s" % (ud.basecmd, revflag, ud.revision, ud.moddir, codir), d)
+        else:
+            logger.debug(2, "Unpack: extracting source to '" + codir + "'")
+            os.chdir(ud.moddir)
+            runfetchcmd("%s archive -t files %s %s" % (ud.basecmd, revflag, codir), d)
-- 
2.4.0


