Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id C85747837C
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Aug 2017 23:31:30 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	30 Aug 2017 16:31:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.41,450,1498546800"; d="scan'208";a="1189995062"
Received: from ekooi-mobl5.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.141.249])
	by fmsmga001.fm.intel.com with ESMTP; 30 Aug 2017 16:31:29 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 31 Aug 2017 11:30:45 +1200
Message-Id: <2c1ea0d7e87f7ffb4dc5b2d44203ca6f3533370f.1504135776.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1504135776.git.paul.eggleton@linux.intel.com>
References: <cover.1504135776.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 3/5] tinfoil: ensure variable history tracking works when parsing a recipe
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
X-List-Received-Date: Wed, 30 Aug 2017 23:31:30 -0000

If you set tracking=True when creating the tinfoil object, that ensures
history is collected for the main datastore, but at the end of parsing
the configuration, history tracking gets turned off to save time with
the result that we don't collect history for any recipes we parse.
Enable tracking when we parse a recipe (and disable it afterwards if we
enabled it) in order to fix this.

This fixes functionality in OE's devtool that relies upon variable
history (such as devtool upgrade updating PV when it's set within a
recipe).

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/tinfoil.py | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index b50ed05..fb2ee4a 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -635,17 +635,24 @@ class Tinfoil:
                          specify config_data then you cannot use a virtual
                          specification for fn.
         """
-        if appends and appendlist == []:
-            appends = False
-        if config_data:
-            dctr = bb.remotedata.RemoteDatastores.transmit_datastore(config_data)
-            dscon = self.run_command('parseRecipeFile', fn, appends, appendlist, dctr)
-        else:
-            dscon = self.run_command('parseRecipeFile', fn, appends, appendlist)
-        if dscon:
-            return self._reconvert_type(dscon, 'DataStoreConnectionHandle')
-        else:
-            return None
+        if self.tracking:
+            # Enable history tracking just for the parse operation
+            self.run_command('enableDataTracking')
+        try:
+            if appends and appendlist == []:
+                appends = False
+            if config_data:
+                dctr = bb.remotedata.RemoteDatastores.transmit_datastore(config_data)
+                dscon = self.run_command('parseRecipeFile', fn, appends, appendlist, dctr)
+            else:
+                dscon = self.run_command('parseRecipeFile', fn, appends, appendlist)
+            if dscon:
+                return self._reconvert_type(dscon, 'DataStoreConnectionHandle')
+            else:
+                return None
+        finally:
+            if self.tracking:
+                self.run_command('disableDataTracking')
 
     def build_file(self, buildfile, task, internal=True):
         """
-- 
2.9.5


