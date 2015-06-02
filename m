Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 2BADF755CC
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  2 Jun 2015 09:04:52 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.1/8.15.1) with ESMTPS id t5294reT004708
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 2 Jun 2015 02:04:53 -0700 (PDT)
Received: from ala-blade47.wrs.com (147.11.105.67) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.224.2;
	Tue, 2 Jun 2015 02:04:53 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 2 Jun 2015 02:04:52 -0700
Message-ID: <9d25d04fa525b37dff0b51c0ea66365f52e5a596.1433235612.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1433235612.git.liezhi.yang@windriver.com>
References: <cover.1433235612.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] bitbake: fetch2/hg.py: fix unpack error and mirror tarball
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
X-List-Received-Date: Tue, 02 Jun 2015 09:04:53 -0000
Content-Type: text/plain

Fixed:
* do_unpack error:
  abort: repository DL_DIR/hg/vim.googlecode.com/hg/vim not found!

* The mirror tarball doesn't work
  - Add the build_mirror_data to create the tarball
  - Unpack the mirror tarball when needed

* The hg files will put in the dir like git: DL_DIR/hg, it was
  DL_DIR/hg/path/to/src/uri/path in the past.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/fetch2/hg.py |   70 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 57 insertions(+), 13 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/hg.py b/bitbake/lib/bb/fetch2/hg.py
index cdef4aa..2c8c25d 100644
--- a/bitbake/lib/bb/fetch2/hg.py
+++ b/bitbake/lib/bb/fetch2/hg.py
@@ -59,10 +59,12 @@ class Hg(FetchMethod):
 
         ud.module = ud.parm["module"]
 
-        # Create paths to mercurial checkouts
-        relpath = self._strip_leading_slashes(ud.path)
-        ud.pkgdir = os.path.join(data.expand('${HGDIR}', d), ud.host, relpath)
-        ud.moddir = os.path.join(ud.pkgdir, ud.module)
+        if 'protocol' in ud.parm:
+            ud.proto = ud.parm['protocol']
+        elif not ud.host:
+            ud.proto = 'file'
+        else:
+            ud.proto = "hg"
 
         ud.setup_revisons(d)
 
@@ -71,10 +73,20 @@ class Hg(FetchMethod):
         elif not ud.revision:
             ud.revision = self.latest_revision(ud, d)
 
-        ud.localfile = ud.moddir
+        # Create paths to mercurial checkouts
+        hgsrcname = '%s_%s_%s' % (ud.module.replace('/', '.'), \
+                            ud.host, ud.path.replace('/', '.'))
+        ud.mirrortarball = 'hg_%s.tar.gz' % hgsrcname
+        ud.fullmirror = os.path.join(d.getVar("DL_DIR", True), ud.mirrortarball)
 
+        hgdir = d.getVar("HGDIR", True) or (d.getVar("DL_DIR", True) + "/hg/")
+        ud.pkgdir = os.path.join(hgdir, hgsrcname)
+        ud.moddir = os.path.join(ud.pkgdir, ud.module)
+        ud.localfile = ud.moddir
         ud.basecmd = data.getVar("FETCHCMD_hg", d, True) or "/usr/bin/env hg"
 
+        ud.write_tarballs = d.getVar("BB_GENERATE_MIRROR_TARBALLS", True)
+
     def need_update(self, ud, d):
         revTag = ud.parm.get('rev', 'tip')
         if revTag == "tip":
@@ -142,18 +154,36 @@ class Hg(FetchMethod):
     def download(self, ud, d):
         """Fetch url"""
 
+        ud.repochanged = not os.path.exists(ud.fullmirror)
+
         logger.debug(2, "Fetch: checking for module directory '" + ud.moddir + "'")
 
+        # If the checkout doesn't exist and the mirror tarball does, extract it
+        if not os.path.exists(ud.pkgdir) and os.path.exists(ud.fullmirror):
+            bb.utils.mkdirhier(ud.pkgdir)
+            os.chdir(ud.pkgdir)
+            runfetchcmd("tar -xzf %s" % (ud.fullmirror), d)
+
         if os.access(os.path.join(ud.moddir, '.hg'), os.R_OK):
-            updatecmd = self._buildhgcommand(ud, d, "pull")
-            logger.info("Update " + ud.url)
-            # update sources there
+            # Found the source, check whether need pull
+            updatecmd = self._buildhgcommand(ud, d, "update")
             os.chdir(ud.moddir)
             logger.debug(1, "Running %s", updatecmd)
-            bb.fetch2.check_network_access(d, updatecmd, ud.url)
-            runfetchcmd(updatecmd, d)
-
-        else:
+            try:
+                runfetchcmd(updatecmd, d)
+            except bb.fetch2.FetchError:
+                # Runnning pull in the repo
+                pullcmd = self._buildhgcommand(ud, d, "pull")
+                logger.info("Pulling " + ud.url)
+                # update sources there
+                os.chdir(ud.moddir)
+                logger.debug(1, "Running %s", pullcmd)
+                bb.fetch2.check_network_access(d, pullcmd, ud.url)
+                runfetchcmd(pullcmd, d)
+                ud.repochanged = True
+
+        # No source found, clone it.
+        if not os.path.exists(ud.moddir):
             fetchcmd = self._buildhgcommand(ud, d, "fetch")
             logger.info("Fetch " + ud.url)
             # check out sources there
@@ -174,6 +204,8 @@ class Hg(FetchMethod):
         """ Clean the hg dir """
 
         bb.utils.remove(ud.localpath, True)
+        bb.utils.remove(ud.fullmirror)
+        bb.utils.remove(ud.fullmirror + ".done")
 
     def supports_srcrev(self):
         return True
@@ -195,8 +227,20 @@ class Hg(FetchMethod):
         """
         return "hg:" + ud.moddir
 
+    def build_mirror_data(self, ud, d):
+        # Generate a mirror tarball if needed
+        if ud.write_tarballs == "1" and (ud.repochanged or not os.path.exists(ud.fullmirror)):
+            # it's possible that this symlink points to read-only filesystem with PREMIRROR
+            if os.path.islink(ud.fullmirror):
+                os.unlink(ud.fullmirror)
+
+            os.chdir(ud.pkgdir)
+            logger.info("Creating tarball of hg repository")
+            runfetchcmd("tar -czf %s %s" % (ud.fullmirror, ud.module), d)
+            runfetchcmd("touch %s.done" % (ud.fullmirror), d)
+
     def localpath(self, ud, d):
-        return ud.moddir
+        return ud.pkgdir
 
     def unpack(self, ud, destdir, d):
         """
-- 
1.7.9.5


