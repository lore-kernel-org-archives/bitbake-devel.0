Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 83DEB60762
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 27 Mar 2017 00:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=intel.com; i=@intel.com; q=dns/txt; s=intel;
	t=1490573855; x=1522109855;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=pKGByoqVF9x79/KajWi8WACTYEwb7U4vYePRIqlo0tI=;
	b=v5StG8GJGztGX9hFthUbEJ6sOPnzWcV4DfLN45b/yCN0LoZ6LN6Owduh
	oAI/ZgDmDA5grggE3e/omGUy92SXtA==;
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	26 Mar 2017 17:17:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.36,229,1486454400"; d="scan'208";a="80843984"
Received: from tienhauh-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.171.185])
	by fmsmga005.fm.intel.com with ESMTP; 26 Mar 2017 17:17:33 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 27 Mar 2017 13:17:26 +1300
Message-Id: <caa0f34a2a36b3a19507bea06e3230c9ae7361ed.1490573768.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1490573768.git.paul.eggleton@linux.intel.com>
References: <cover.1490573768.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/3] fetch2/git: prevent recursion on getting latest revision
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
X-List-Received-Date: Mon, 27 Mar 2017 00:17:33 -0000

We call git ls-remote to get the latest revision from a git repository,
however by calling runfetchcmd() we can end up recursively running
git ls-remote a number of times with OE e.g. if ${SRCPV} is in PV, ${PV}
is in WORKDIR, and ${WORKDIR} is in PATH (as a result of recipe-specific
sysroots), our call to runfetchcmd() exports PATH so _lsremote() will
get called again - with the end result that we run git ls-remote 30
times in quick succession (!). Prevent that from happening by using a
guard variable and returning a dummy value if it's called recursively.

Fixes [YOCTO #11185].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/fetch2/git.py | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index a8be859..2550bde 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -379,14 +379,26 @@ class Git(FetchMethod):
         """
         Run git ls-remote with the specified search string
         """
-        repourl = self._get_repo_url(ud)
-        cmd = "%s ls-remote %s %s" % \
-              (ud.basecmd, repourl, search)
-        if ud.proto.lower() != 'file':
-            bb.fetch2.check_network_access(d, cmd, repourl)
-        output = runfetchcmd(cmd, d, True)
-        if not output:
-            raise bb.fetch2.FetchError("The command %s gave empty output unexpectedly" % cmd, ud.url)
+        # Prevent recursion e.g. in OE if SRCPV is in PV, PV is in WORKDIR,
+        # and WORKDIR is in PATH (as a result of RSS), our call to
+        # runfetchcmd() exports PATH so this function will get called again (!)
+        # In this scenario the return call of the function isn't actually
+        # important - WORKDIR isn't needed in PATH to call git ls-remote
+        # anyway.
+        if d.getVar('_BB_GIT_IN_LSREMOTE', False):
+            return ''
+        d.setVar('_BB_GIT_IN_LSREMOTE', '1')
+        try:
+            repourl = self._get_repo_url(ud)
+            cmd = "%s ls-remote %s %s" % \
+                (ud.basecmd, repourl, search)
+            if ud.proto.lower() != 'file':
+                bb.fetch2.check_network_access(d, cmd, repourl)
+            output = runfetchcmd(cmd, d, True)
+            if not output:
+                raise bb.fetch2.FetchError("The command %s gave empty output unexpectedly" % cmd, ud.url)
+        finally:
+            d.delVar('_BB_GIT_IN_LSREMOTE')
         return output
 
     def _latest_revision(self, ud, d, name):
-- 
2.9.3


