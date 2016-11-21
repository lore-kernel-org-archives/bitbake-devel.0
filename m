Return-Path: <markus.lehtonen@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 96C7871A60
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Nov 2016 12:31:49 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga103.jf.intel.com with ESMTP; 21 Nov 2016 04:31:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,675,1473145200"; 
   d="scan'208";a="7378518"
Received: from marquiz.fi.intel.com ([10.237.72.155])
	by orsmga002.jf.intel.com with ESMTP; 21 Nov 2016 04:31:43 -0800
From: Markus Lehtonen <markus.lehtonen@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 21 Nov 2016 14:31:43 +0200
Message-Id: <1479731503-12780-1-git-send-email-markus.lehtonen@linux.intel.com>
X-Mailer: git-send-email 2.6.6
Subject: [PATCH] fetch2: obey BB_ALLOWED_NETWORKS when checking network access
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
X-List-Received-Date: Mon, 21 Nov 2016 12:31:49 -0000

[YOCTO #10508]

Signed-off-by: Markus Lehtonen <markus.lehtonen@linux.intel.com>
---
 lib/bb/fetch2/__init__.py | 7 +++++--
 lib/bb/fetch2/git.py      | 4 ++--
 lib/bb/fetch2/hg.py       | 2 +-
 lib/bb/fetch2/npm.py      | 2 +-
 lib/bb/fetch2/perforce.py | 8 ++++----
 lib/bb/fetch2/svn.py      | 2 +-
 lib/bb/fetch2/wget.py     | 2 +-
 7 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index cd7362c..4bb7526 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -856,12 +856,15 @@ def runfetchcmd(cmd, d, quiet=False, cleanup=None, log=None, workdir=None):
 
     return output
 
-def check_network_access(d, info = "", url = None):
+def check_network_access(d, info, url):
     """
-    log remote network access, and error if BB_NO_NETWORK is set
+    log remote network access, and error if BB_NO_NETWORK is set or the given
+    URI is untrusted
     """
     if d.getVar("BB_NO_NETWORK", True) == "1":
         raise NetworkAccess(url, info)
+    elif not trusted_network(d, url):
+        raise UntrustedUrl(url, info)
     else:
         logger.debug(1, "Fetcher accessed the network with the command %s" % info)
 
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 1bec60a..11d0b9c 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -252,7 +252,7 @@ class Git(FetchMethod):
                 repourl = repourl[7:]
             clone_cmd = "LANG=C %s clone --bare --mirror %s %s --progress" % (ud.basecmd, repourl, ud.clonedir)
             if ud.proto.lower() != 'file':
-                bb.fetch2.check_network_access(d, clone_cmd)
+                bb.fetch2.check_network_access(d, clone_cmd, ud.url)
             progresshandler = GitProgressHandler(d)
             runfetchcmd(clone_cmd, d, log=progresshandler)
 
@@ -384,7 +384,7 @@ class Git(FetchMethod):
         cmd = "%s ls-remote %s %s" % \
               (ud.basecmd, repourl, search)
         if ud.proto.lower() != 'file':
-            bb.fetch2.check_network_access(d, cmd)
+            bb.fetch2.check_network_access(d, cmd, repourl)
         output = runfetchcmd(cmd, d, True)
         if not output:
             raise bb.fetch2.FetchError("The command %s gave empty output unexpectedly" % cmd, ud.url)
diff --git a/lib/bb/fetch2/hg.py b/lib/bb/fetch2/hg.py
index 20df801..dc87998 100644
--- a/lib/bb/fetch2/hg.py
+++ b/lib/bb/fetch2/hg.py
@@ -221,7 +221,7 @@ class Hg(FetchMethod):
         """
         Compute tip revision for the url
         """
-        bb.fetch2.check_network_access(d, self._buildhgcommand(ud, d, "info"))
+        bb.fetch2.check_network_access(d, self._buildhgcommand(ud, d, "info"), ud.url)
         output = runfetchcmd(self._buildhgcommand(ud, d, "info"), d)
         return output.strip()
 
diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index 699ae72..29faea1 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -101,7 +101,7 @@ class Npm(FetchMethod):
 
     def _runwget(self, ud, d, command, quiet):
         logger.debug(2, "Fetching %s using command '%s'" % (ud.url, command))
-        bb.fetch2.check_network_access(d, command)
+        bb.fetch2.check_network_access(d, command, ud.url)
         dldir = d.getVar("DL_DIR", True)
         runfetchcmd(command, d, quiet, workdir=dldir)
 
diff --git a/lib/bb/fetch2/perforce.py b/lib/bb/fetch2/perforce.py
index 50cb479..e332e7c 100644
--- a/lib/bb/fetch2/perforce.py
+++ b/lib/bb/fetch2/perforce.py
@@ -71,7 +71,7 @@ class Perforce(FetchMethod):
             logger.debug(1, 'Trying to use P4CONFIG to automatically set P4PORT...')
             ud.usingp4config = True
             p4cmd = '%s info | grep "Server address"' % ud.basecmd
-            bb.fetch2.check_network_access(d, p4cmd)
+            bb.fetch2.check_network_access(d, p4cmd, ud.url)
             ud.host = runfetchcmd(p4cmd, d, True)
             ud.host = ud.host.split(': ')[1].strip()
             logger.debug(1, 'Determined P4PORT to be: %s' % ud.host)
@@ -140,7 +140,7 @@ class Perforce(FetchMethod):
         'p4 files' command, including trailing '#rev' file revision indicator
         """
         p4cmd = self._buildp4command(ud, d, 'files')
-        bb.fetch2.check_network_access(d, p4cmd)
+        bb.fetch2.check_network_access(d, p4cmd, ud.url)
         p4fileslist = runfetchcmd(p4cmd, d, True)
         p4fileslist = [f.rstrip() for f in p4fileslist.splitlines()]
 
@@ -171,7 +171,7 @@ class Perforce(FetchMethod):
 
         for afile in filelist:
             p4fetchcmd = self._buildp4command(ud, d, 'print', afile)
-            bb.fetch2.check_network_access(d, p4fetchcmd)
+            bb.fetch2.check_network_access(d, p4fetchcmd, ud.url)
             runfetchcmd(p4fetchcmd, d, workdir=ud.pkgdir)
 
         runfetchcmd('tar -czf %s p4' % (ud.localpath), d, cleanup=[ud.localpath], workdir=ud.pkgdir)
@@ -191,7 +191,7 @@ class Perforce(FetchMethod):
     def _latest_revision(self, ud, d, name):
         """ Return the latest upstream scm revision number """
         p4cmd = self._buildp4command(ud, d, "changes")
-        bb.fetch2.check_network_access(d, p4cmd)
+        bb.fetch2.check_network_access(d, p4cmd, ud.url)
         tip = runfetchcmd(p4cmd, d, True)
 
         if not tip:
diff --git a/lib/bb/fetch2/svn.py b/lib/bb/fetch2/svn.py
index 6ca79d3..71dee9f 100644
--- a/lib/bb/fetch2/svn.py
+++ b/lib/bb/fetch2/svn.py
@@ -173,7 +173,7 @@ class Svn(FetchMethod):
         """
         Return the latest upstream revision number
         """
-        bb.fetch2.check_network_access(d, self._buildsvncommand(ud, d, "log1"))
+        bb.fetch2.check_network_access(d, self._buildsvncommand(ud, d, "log1"), ud.url)
 
         output = runfetchcmd("LANG=C LC_ALL=C " + self._buildsvncommand(ud, d, "log1"), d, True)
 
diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index ecb946a..1d81c08 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -95,7 +95,7 @@ class Wget(FetchMethod):
         progresshandler = WgetProgressHandler(d)
 
         logger.debug(2, "Fetching %s using command '%s'" % (ud.url, command))
-        bb.fetch2.check_network_access(d, command)
+        bb.fetch2.check_network_access(d, command, ud.url)
         runfetchcmd(command + ' --progress=dot -v', d, quiet, log=progresshandler)
 
     def download(self, ud, d):
-- 
2.6.6


