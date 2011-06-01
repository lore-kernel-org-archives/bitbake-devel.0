Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1QRiyn-0000ZP-El
	for bitbake-devel@lists.openembedded.org;
	Wed, 01 Jun 2011 12:48:49 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 01 Jun 2011 03:09:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,302,1304319600"; 
   d="scan'208";a="5112947"
Received: from unknown (HELO helios.amr.corp.intel.com) ([10.255.13.133])
	by azsmga001.ch.intel.com with ESMTP; 01 Jun 2011 03:09:36 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  1 Jun 2011 11:09:34 +0100
Message-Id: <623c5a6122ea3e772792eb3ba39c282a0747993e.1306922503.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1306922503.git.paul.eggleton@linux.intel.com>
References: <cover.1306922503.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1306922503.git.paul.eggleton@linux.intel.com>
References: <cover.1306922503.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/1] bitbake: use layer priority when applying bbappends
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
X-List-Received-Date: Wed, 01 Jun 2011 10:48:49 -0000

If the priority of a layer has been specified with BBFILE_PRIORITY_ then
use that to sort the list of BBFILES entries, which will affect the order
in which .bbappend files are applied.

Fixes [YOCTO #1125]

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/cooker.py |   24 ++++++++++++++----------
 1 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 3973529..0b52f18 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -405,6 +405,15 @@ class BBCooker:
         print("}", file=tdepends_file)
         logger.info("Task dependencies saved to 'task-depends.dot'")
 
+    def calc_bbfile_priority( self, filename, matched = None ):
+        for _, _, regex, pri in self.status.bbfile_config_priorities:
+            if regex.match(filename):
+                if matched != None:
+                    if not regex in matched:
+                        matched.add(regex)
+                return pri
+        return 0
+
     def buildDepgraph( self ):
         all_depends = self.status.all_depends
         pn_provides = self.status.pn_provides
@@ -413,15 +422,6 @@ class BBCooker:
         bb.data.update_data(localdata)
         bb.data.expandKeys(localdata)
 
-        matched = set()
-        def calc_bbfile_priority(filename):
-            for _, _, regex, pri in self.status.bbfile_config_priorities:
-                if regex.match(filename):
-                    if not regex in matched:
-                        matched.add(regex)
-                    return pri
-            return 0
-
         # Handle PREFERRED_PROVIDERS
         for p in (bb.data.getVar('PREFERRED_PROVIDERS', localdata, 1) or "").split():
             try:
@@ -434,8 +434,9 @@ class BBCooker:
             self.status.preferred[providee] = provider
 
         # Calculate priorities for each file
+        matched = set()
         for p in self.status.pkg_fn:
-            self.status.bbfile_priority[p] = calc_bbfile_priority(p)
+            self.status.bbfile_priority[p] = self.calc_bbfile_priority(p, matched)
  
         # Don't show the warning if the BBFILE_PATTERN did match .bbappend files
         unmatched = set()
@@ -950,6 +951,9 @@ class BBCooker:
         files = (data.getVar( "BBFILES", self.configuration.data, 1 ) or "").split()
         data.setVar("BBFILES", " ".join(files), self.configuration.data)
 
+        # Sort files by priority
+        files.sort( key=lambda fileitem: self.calc_bbfile_priority(fileitem) )
+
         if not len(files):
             files = self.get_bbfiles()
 
-- 
1.7.4.1



