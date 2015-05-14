Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 1E57D73EF8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 May 2015 13:34:00 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga103.fm.intel.com with ESMTP; 14 May 2015 06:34:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.13,427,1427785200"; d="scan'208";a="710148902"
Received: from unknown (HELO peggleto-mobl.ger.corp.intel.com) ([10.252.30.48])
	by fmsmga001.fm.intel.com with ESMTP; 14 May 2015 06:34:00 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 14 May 2015 14:33:49 +0100
Message-Id: <04675eaa336fc1f9cd27617f653fe30f77add1b9.1431610370.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <cover.1431610370.git.paul.eggleton@linux.intel.com>
References: <cover.1431610370.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1431610370.git.paul.eggleton@linux.intel.com>
References: <cover.1431610370.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/2] fetch2/git: ensure the unpacked origin remote points upstream
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
X-List-Received-Date: Thu, 14 May 2015 13:34:00 -0000

If you're interested in using the checked out repository for development
(e.g. in OE with devtool) then you ideally want the origin remote to
point to the repository it was fetched from, so just set that after
cloning.

(As part of this I did a minor refactor so we have one function to
generate the repository URL, which was already in two places.)

Fixes [YOCTO #7756].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/fetch2/git.py | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 0fd9bee..4cc5811 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -178,11 +178,6 @@ class Git(FetchMethod):
     def download(self, ud, d):
         """Fetch url"""
 
-        if ud.user:
-            username = ud.user + '@'
-        else:
-            username = ""
-
         ud.repochanged = not os.path.exists(ud.fullmirror)
 
         # If the checkout doesn't exist and the mirror tarball does, extract it
@@ -191,7 +186,7 @@ class Git(FetchMethod):
             os.chdir(ud.clonedir)
             runfetchcmd("tar -xzf %s" % (ud.fullmirror), d)
 
-        repourl = "%s://%s%s%s" % (ud.proto, username, ud.host, ud.path)
+        repourl = self._get_repo_url(ud)
 
         # If the repo still doesn't exist, fallback to cloning it
         if not os.path.exists(ud.clonedir):
@@ -277,8 +272,10 @@ class Git(FetchMethod):
             clonedir = indirectiondir
 
         runfetchcmd("%s clone %s %s/ %s" % (ud.basecmd, cloneflags, clonedir, destdir), d)
+        os.chdir(destdir)
+        repourl = self._get_repo_url(ud)
+        runfetchcmd("%s remote set-url origin %s" % (ud.basecmd, repourl), d)
         if not ud.nocheckout:
-            os.chdir(destdir)
             if subdir != "":
                 runfetchcmd("%s read-tree %s%s" % (ud.basecmd, ud.revisions[ud.names[0]], readpathspec), d)
                 runfetchcmd("%s checkout-index -q -f -a" % ud.basecmd, d)
@@ -312,6 +309,16 @@ class Git(FetchMethod):
             raise bb.fetch2.FetchError("The command '%s' gave output with more then 1 line unexpectedly, output: '%s'" % (cmd, output))
         return output.split()[0] != "0"
 
+    def _get_repo_url(self, ud):
+        """
+        Return the repository URL
+        """
+        if ud.user:
+            username = ud.user + '@'
+        else:
+            username = ""
+        return "%s://%s%s%s" % (ud.proto, username, ud.host, ud.path)
+
     def _revision_key(self, ud, d, name):
         """
         Return a unique key for the url
@@ -322,13 +329,9 @@ class Git(FetchMethod):
         """
         Run git ls-remote with the specified search string
         """
-        if ud.user:
-            username = ud.user + '@'
-        else:
-            username = ""
-
-        cmd = "%s ls-remote %s://%s%s%s %s" % \
-              (ud.basecmd, ud.proto, username, ud.host, ud.path, search)
+        repourl = self._get_repo_url(ud)
+        cmd = "%s ls-remote %s %s" % \
+              (ud.basecmd, repourl, search)
         if ud.proto.lower() != 'file':
             bb.fetch2.check_network_access(d, cmd)
         output = runfetchcmd(cmd, d, True)
-- 
2.1.0


