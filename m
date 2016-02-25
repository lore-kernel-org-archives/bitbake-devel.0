Return-Path: <brendan.le.foll@intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 5A9F67732F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Feb 2016 15:07:10 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga104.fm.intel.com with ESMTP; 25 Feb 2016 07:06:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,498,1449561600"; d="scan'208";a="923777784"
Received: from jupiter.iwi.intel.com ([172.28.33.51])
	by fmsmga002.fm.intel.com with ESMTP; 25 Feb 2016 07:06:51 -0800
From: brendan.le.foll@intel.com
To: bitbake-devel@lists.openembedded.org
Date: Thu, 25 Feb 2016 15:07:08 +0000
Message-Id: <1456412828-11343-4-git-send-email-brendan.le.foll@intel.com>
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1456412828-11343-1-git-send-email-brendan.le.foll@intel.com>
References: <1456412828-11343-1-git-send-email-brendan.le.foll@intel.com>
Subject: [PATCH 3/3] npm: Add mirroring support for npm fetcher
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
X-List-Received-Date: Thu, 25 Feb 2016 15:07:10 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/npm.py | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index 6a4f467..17b200f 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -59,6 +59,7 @@ class Npm(FetchMethod):
          logger.debug(2, "Calling cleanup %s" % ud.pkgname)
          bb.utils.remove(ud.localpath, False)
          bb.utils.remove(ud.pkgdatadir, True)
+         bb.utils.remove(ud.fullmirror, False)
 
     def urldata_init(self, ud, d):
         """
@@ -82,12 +83,16 @@ class Npm(FetchMethod):
         prefixdir = "npm/%s" % ud.pkgname
         ud.pkgdatadir = d.expand("${DL_DIR}/%s" % prefixdir)
         if not os.path.exists(ud.pkgdatadir):
-            bb.utils.mkdirhiet(ud.pkgdatadir)
+            bb.utils.mkdirhier(ud.pkgdatadir)
         ud.localpath = d.expand("${DL_DIR}/npm/%s" % ud.bbnpmmanifest)
 
         self.basecmd = d.getVar("FETCHCMD_wget", True) or "/usr/bin/env wget -O -t 2 -T 30 -nv --passive-ftp --no-check-certificate "
         self.basecmd += " --directory-prefix=%s " % prefixdir
 
+        ud.write_tarballs = ((data.getVar("BB_GENERATE_MIRROR_TARBALLS", d, True) or "0") != "0")
+        ud.mirrortarball = 'npm_%s-%s.tar.xz' % (ud.pkgname, ud.version)
+        ud.fullmirror = os.path.join(d.getVar("DL_DIR", True), ud.mirrortarball)
+
     def need_update(self, ud, d):
         if os.path.exists(ud.localpath):
             return False
@@ -202,6 +207,16 @@ class Npm(FetchMethod):
         shrinkobj = {}
         lockdown = {}
 
+        if not os.listdir(ud.pkgdatadir) and os.path.exists(ud.fullmirror):
+            bb.warn("Using mirror tarball")
+            dest = d.getVar("DL_DIR", True)
+            bb.utils.mkdirhier(dest)
+            save_cwd = os.getcwd()
+            os.chdir(dest)
+            runfetchcmd("tar -xJf %s" % (ud.fullmirror), d)
+            os.chdir(save_cwd)
+            return
+
         shwrf = d.getVar('NPM_SHRINKWRAP', True)
         logger.debug(2, "NPM shrinkwrap file is %s" % shwrf)
         try:
@@ -224,3 +239,18 @@ class Npm(FetchMethod):
 
         with open(ud.localpath, 'w') as outfile:
             json.dump(jsondepobj, outfile)
+
+    def build_mirror_data(self, ud, d):
+        # Generate a mirror tarball if needed
+        if ud.write_tarballs and not os.path.exists(ud.fullmirror):
+            # it's possible that this symlink points to read-only filesystem with PREMIRROR
+            if os.path.islink(ud.fullmirror):
+                os.unlink(ud.fullmirror)
+
+            save_cwd = os.getcwd()
+            os.chdir(d.getVar("DL_DIR", True))
+            logger.info("Creating tarball of npm data")
+            runfetchcmd("tar -cJf %s npm/%s npm/%s" % (ud.fullmirror, ud.bbnpmmanifest, ud.pkgname), d)
+            runfetchcmd("touch %s.done" % (ud.fullmirror), d)
+            os.chdir(save_cwd)
+
-- 
2.7.1


