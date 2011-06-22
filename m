Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1QZNYG-0000KN-Po
	for bitbake-devel@lists.openembedded.org;
	Wed, 22 Jun 2011 15:33:05 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 22 Jun 2011 06:28:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,406,1304319600"; d="scan'208";a="16815088"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.255.17.16])
	by azsmga001.ch.intel.com with ESMTP; 22 Jun 2011 06:28:23 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 22 Jun 2011 14:28:16 +0100
Message-Id: <f7f26e0dff68d4c3146caeccc653fb3c020e662a.1308749155.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1308749155.git.paul.eggleton@linux.intel.com>
References: <cover.1308749155.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1308749155.git.paul.eggleton@linux.intel.com>
References: <cover.1308749155.git.paul.eggleton@linux.intel.com>
Subject: [RFC PATCH 1/3] bitbake: track 'overlayed' recipes
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
X-List-Received-Date: Wed, 22 Jun 2011 13:33:06 -0000

Recipes that have been 'overlayed' (where there is a recipe in another
layer where that layer has a higher priority) are now listed within
cooker.overlayedlist for use in bitbake-layers. This is a dict with
keys of the topmost (highest priority) recipe file.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/cooker.py |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index ebf963d..cb264b7 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -33,6 +33,7 @@ import threading
 from cStringIO import StringIO
 from contextlib import closing
 from functools import wraps
+from collections import defaultdict
 import bb, bb.exceptions
 from bb import utils, data, parse, event, cache, providers, taskdata, command, runqueue
 
@@ -1053,6 +1054,18 @@ class BBCooker:
                self.appendlist[base] = []
             self.appendlist[base].append(f)
 
+        # Find overlayed recipes
+        # bbfiles will be in priority order which makes this easy
+        bbfile_seen = dict()
+        self.overlayedlist = defaultdict(list)
+        for f in reversed(bbfiles):
+            base = os.path.basename(f)
+            if base not in bbfile_seen:
+                bbfile_seen[base] = f
+            else:
+                topfile = bbfile_seen[base]
+                self.overlayedlist[topfile].append(f)
+
         return (bbfiles, masked)
 
     def get_file_appends(self, fn):
-- 
1.7.4.1



