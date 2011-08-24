Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QwJgK-0007t8-Ia
	for bitbake-devel@lists.openembedded.org;
	Wed, 24 Aug 2011 22:04:12 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 24 Aug 2011 12:59:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="41532548"
Received: from vorpal.jf.intel.com ([10.7.199.155])
	by orsmga002.jf.intel.com with ESMTP; 24 Aug 2011 12:59:24 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 24 Aug 2011 13:04:23 -0700
Message-Id: <e76e1c04b606616d34997c6cc44899832ff200ec.1314216131.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1314216131.git.josh@linux.intel.com>
References: <cover.1314216131.git.josh@linux.intel.com>
In-Reply-To: <cover.1314216131.git.josh@linux.intel.com>
References: <cover.1314216131.git.josh@linux.intel.com>
Subject: [PATCH 1/1] bb/fetch2/git: add checkstatus command
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
X-List-Received-Date: Wed, 24 Aug 2011 20:04:12 -0000

Use git ls-remote to implement checkstatus command for the git fetcher.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/fetch2/git.py |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 25c2c51..97bf086 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -298,3 +298,11 @@ class Git(FetchMethod):
         buildindex = "%s" % output.split()[0]
         logger.debug(1, "GIT repository for %s in %s is returning %s revisions in rev-list before %s", url, ud.clonedir, buildindex, rev)
         return buildindex
+
+    def checkstatus(self, uri, ud, d):
+        fetchcmd = "%s ls-remote %s" % (ud.basecmd, uri)
+        try:
+            runfetchcmd(fetchcmd, d, quiet=True)
+            return True
+        except FetchError:
+            return False
-- 
1.7.6



