Return-Path: <naveen.kumar.saini@intel.com>
X-Greylist: delayed 563 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 26 Apr 2019 08:43:19 UTC
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by mail.openembedded.org (Postfix) with ESMTP id 304B67D4F9
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Apr 2019 08:43:19 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	26 Apr 2019 01:33:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,396,1549958400"; d="scan'208";a="152533724"
Received: from optimus-prime.png.intel.com ([172.30.199.130])
	by FMSMGA003.fm.intel.com with ESMTP; 26 Apr 2019 01:33:56 -0700
From: Naveen Saini <naveen.kumar.saini@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 26 Apr 2019 16:34:38 +0800
Message-Id: <20190426083438.30259-1-naveen.kumar.saini@intel.com>
X-Mailer: git-send-email 2.17.0
Subject: [PATCH v4] bitbake: fetch2/git: git-lfs check
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
X-List-Received-Date: Fri, 26 Apr 2019 08:43:19 -0000

Build will fail if repository has lfs contents in absense of git-lfs tool on host.
Build will pass if repository may or may not contains lfs content if host has git-lfs installed.

[YOCTO #13198]

Signed-off-by: Naveen Saini <naveen.kumar.saini@intel.com>
---
 bitbake/lib/bb/fetch2/git.py | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 8185bf4..c69d25c 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -503,6 +503,17 @@ class Git(FetchMethod):
 
         repourl = self._get_repo_url(ud)
         runfetchcmd("%s remote set-url origin %s" % (ud.basecmd, repourl), d, workdir=destdir)
+
+        if self._contains_lfs(ud, d, destdir):
+            path = d.getVar('PATH')
+            if path:
+                gitlfstool = bb.utils.which(path, "git-lfs", executable=True)
+                if not gitlfstool:
+                    raise bb.fetch2.FetchError("Repository %s has lfs content, install git-lfs plugin on host to download" % (repourl))
+            else:
+                bb.note("Could not find 'PATH'")
+
+
         if not ud.nocheckout:
             if subdir != "":
                 runfetchcmd("%s read-tree %s%s" % (ud.basecmd, ud.revisions[ud.names[0]], readpathspec), d,
@@ -553,6 +564,20 @@ class Git(FetchMethod):
             raise bb.fetch2.FetchError("The command '%s' gave output with more then 1 line unexpectedly, output: '%s'" % (cmd, output))
         return output.split()[0] != "0"
 
+    def _contains_lfs(self, ud, d, wd):
+        """
+        Check if the repository has 'lfs' (large file) content
+        """
+        cmd = "%s grep lfs HEAD:.gitattributes | wc -l" % (
+                ud.basecmd)
+        try:
+            output = runfetchcmd(cmd, d, quiet=True, workdir=wd)
+            if int(output) > 0:
+                return True
+        except (bb.fetch2.FetchError,ValueError):
+            pass
+        return False
+
     def _get_repo_url(self, ud):
         """
         Return the repository URL
-- 
2.7.4


