Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RmN5x-00085D-Uo
	for bitbake-devel@lists.openembedded.org;
	Sun, 15 Jan 2012 11:13:50 +0100
Received: by opal (Postfix, from userid 111)
	id 446711033C; Sun, 15 Jan 2012 10:15:11 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120115101511.446711033C@opal>
Date: Sun, 15 Jan 2012 10:15:11 +0000 (UTC)
From: git@git.openembedded.org
Subject: Paul Eggleton : bitbake/cooker: avoid printing stack trace for -b match error
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
X-List-Received-Date: Sun, 15 Jan 2012 10:13:50 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 803550a5098ec878164245e71344c3d687310b72
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=803550a5098ec878164245e71344c3d687310b72

Author: Paul Eggleton <paul.eggleton@linux.intel.com>
Date:   Fri Jan 13 17:01:51 2012 +0000

bitbake/cooker: avoid printing stack trace for -b match error

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
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/cooker.py |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 194046e..6041410 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
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



