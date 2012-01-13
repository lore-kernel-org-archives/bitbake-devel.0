Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1RlkeE-0006Wx-UY
	for bitbake-devel@lists.openembedded.org;
	Fri, 13 Jan 2012 18:10:39 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 13 Jan 2012 09:02:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="98177353"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.110])
	by orsmga002.jf.intel.com with ESMTP; 13 Jan 2012 09:02:00 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 Jan 2012 17:01:51 +0000
Message-Id: <bb1b204449e2539bb92cb19c45197da785fb3417.1326473488.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1326473488.git.paul.eggleton@linux.intel.com>
References: <cover.1326473488.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1326473488.git.paul.eggleton@linux.intel.com>
References: <cover.1326473488.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 7/8] bitbake/cooker: avoid printing stack trace for -b match error
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
X-List-Received-Date: Fri, 13 Jan 2012 17:10:39 -0000

Improves error output for matching problems when the -b / --buildfile
command line option is used.

Rename MultipleMatches exception to NoSpecificMatch (as it is also
raised when there are no matching recipes) and make it inherit from
BBHandledException so that it doesn't print a stack trace (we always log
an ERROR prior to raising it.)

In addition, improve the formatting of the error message - only call the
log function once rather than once for every match, and use a more
appropriate message if there are no matches.

Fixes [YOCTO #1141]

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/cooker.py |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 194046e..6041410 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -44,9 +44,9 @@ buildlog    = logging.getLogger("BitBake.Build")
 parselog    = logging.getLogger("BitBake.Parsing")
 providerlog = logging.getLogger("BitBake.Provider")
 
-class MultipleMatches(Exception):
+class NoSpecificMatch(bb.BBHandledException):
     """
-    Exception raised when multiple file matches are found
+    Exception raised when no or multiple file matches are found
     """
 
 class NothingToBuild(Exception):
@@ -979,10 +979,15 @@ class BBCooker:
         """
         matches = self.matchFiles(buildfile)
         if len(matches) != 1:
-            parselog.error("Unable to match %s (%s matches found):" % (buildfile, len(matches)))
-            for f in matches:
-                parselog.error("    %s" % f)
-            raise MultipleMatches
+            if matches:
+                msg = "Unable to match '%s' to a specific recipe file - %s matches found:" % (buildfile, len(matches))
+                if matches:
+                    for f in matches:
+                        msg += "\n    %s" % f
+                parselog.error(msg)
+            else:
+                parselog.error("Unable to find any recipe file matching '%s'" % buildfile)
+            raise NoSpecificMatch
         return matches[0]
 
     def buildFile(self, buildfile, task):
-- 
1.7.5.4



