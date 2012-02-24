Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1S108j-00085F-VO
	for bitbake-devel@lists.openembedded.org;
	Fri, 24 Feb 2012 19:45:10 +0100
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 24 Feb 2012 10:36:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="70019969"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.123.71])
	by AZSMGA002.ch.intel.com with ESMTP; 24 Feb 2012 10:36:45 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 24 Feb 2012 18:36:42 +0000
Message-Id: <5cf92eae9327e2f345888f87faea2e10aa1a672e.1330108168.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1330108168.git.paul.eggleton@linux.intel.com>
References: <cover.1330108168.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1330108168.git.paul.eggleton@linux.intel.com>
References: <cover.1330108168.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/1] bitbake/cooker: terminate when errors found in layer configuration
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
X-List-Received-Date: Fri, 24 Feb 2012 18:45:10 -0000

If we find an error in the layer configuration (such as an unsatisfied
item in LAYERDEPENDS) then exit by raising an exception at the end of
handleCollections() (without producing a backtrace).

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/cooker.py |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index d645454..12b526b 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -55,6 +55,11 @@ class NothingToBuild(Exception):
     Exception raised when there is nothing to build
     """
 
+class CollectionError(bb.BBHandledException):
+    """
+    Exception raised when layer configuration is incorrect
+    """
+
 class state:
     initial, parsing, running, shutdown, stop = range(5)
 
@@ -893,6 +898,7 @@ class BBCooker:
 
     def handleCollections( self, collections ):
         """Handle collections"""
+        errors = False
         self.status.bbfile_config_priorities = []
         if collections:
             collection_priorities = {}
@@ -907,6 +913,7 @@ class BBCooker:
                         prio = int(priority)
                     except ValueError:
                         parselog.error("invalid value for BBFILE_PRIORITY_%s: \"%s\"", c, priority)
+                        errors = True
                     if min_prio == 0 or prio < min_prio:
                         min_prio = prio
                     collection_priorities[c] = prio
@@ -925,6 +932,7 @@ class BBCooker:
                                 depver = int(depsplit[1])
                             except ValueError:
                                 parselog.error("invalid version value in LAYERDEPENDS_%s: \"%s\"", c, dep)
+                                errors = True
                                 continue
                         else:
                             depver = None
@@ -939,13 +947,17 @@ class BBCooker:
                                         lver = int(layerver)
                                     except ValueError:
                                         parselog.error("invalid value for LAYERVERSION_%s: \"%s\"", c, layerver)
+                                        errors = True
                                         continue
                                     if lver <> depver:
                                         parselog.error("Layer dependency %s of layer %s is at version %d, expected %d", dep, c, lver, depver)
+                                        errors = True
                                 else:
                                     parselog.error("Layer dependency %s of layer %s has no version, expected %d", dep, c, depver)
+                                    errors = True
                         else:
                             parselog.error("Layer dependency %s of layer %s not found", dep, c)
+                            errors = True
                     collection_depends[c] = depnamelist
                 else:
                     collection_depends[c] = []
@@ -969,13 +981,18 @@ class BBCooker:
                 regex = self.configuration.data.getVar("BBFILE_PATTERN_%s" % c, 1)
                 if regex == None:
                     parselog.error("BBFILE_PATTERN_%s not defined" % c)
+                    errors = True
                     continue
                 try:
                     cre = re.compile(regex)
                 except re.error:
                     parselog.error("BBFILE_PATTERN_%s \"%s\" is not a valid regular expression", c, regex)
+                    errors = True
                     continue
                 self.status.bbfile_config_priorities.append((c, regex, cre, collection_priorities[c]))
+        if errors:
+            # We've already printed the actual error(s)
+            raise CollectionError("Errors during parsing layer configuration")
 
     def buildSetVars(self):
         """
-- 
1.7.5.4



