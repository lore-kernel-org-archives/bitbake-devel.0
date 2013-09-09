Return-Path: <ddalex@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id 406BB6BFBE
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Sep 2013 16:41:09 +0000 (UTC)
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 09 Sep 2013 09:41:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,872,1371106800"; d="scan'208";a="292651243"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by AZSMGA002.ch.intel.com with ESMTP; 09 Sep 2013 09:41:09 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 85282560E2C; Mon,  9 Sep 2013 17:41:08 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org
Date: Mon,  9 Sep 2013 17:41:00 +0100
Message-Id: <57e230f40897c8ce63ccd4056f56747d64235788.1378743829.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <ea491a92f917fa72be06c5e897dc3a55045e776e.1378743829.git.alexandru.damian@intel.com>
References: <ea491a92f917fa72be06c5e897dc3a55045e776e.1378743829.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1378743829.git.alexandru.damian@intel.com>
References: <cover.1378743829.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 09/13] bitbake: event: do not abort on UI handlers error
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
X-List-Received-Date: Mon, 09 Sep 2013 16:41:09 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Ignore runtime errors if UI handlers do something
funny, as exiting while the loop is running.

This allows the builder to continue even if something
happens to the UI handlers, useful for remote bitbake
server.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/event.py | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
index 67cfcea..1258471 100644
--- a/bitbake/lib/bb/event.py
+++ b/bitbake/lib/bb/event.py
@@ -133,20 +133,24 @@ def fire_ui_handlers(event, d):
         return
 
     errors = []
-    for h in _ui_handlers:
-        #print "Sending event %s" % event
-        try:
-             if not _ui_logfilters[h].filter(event):
-                 continue
-             # We use pickle here since it better handles object instances
-             # which xmlrpc's marshaller does not. Events *must* be serializable
-             # by pickle.
-             if hasattr(_ui_handlers[h].event, "sendpickle"):
-                _ui_handlers[h].event.sendpickle((pickle.dumps(event)))
-             else:
-                _ui_handlers[h].event.send(event)
-        except:
-            errors.append(h)
+    try:
+        for h in _ui_handlers:
+            #print "Sending event %s" % event
+            try:
+                if not _ui_logfilters[h].filter(event):
+                    continue
+                # We use pickle here since it better handles object instances
+                # which xmlrpc's marshaller does not. Events *must* be serializable
+                # by pickle.
+                if hasattr(_ui_handlers[h].event, "sendpickle"):
+                    _ui_handlers[h].event.sendpickle((pickle.dumps(event)))
+                else:
+                    _ui_handlers[h].event.send(event)
+            except:
+                errors.append(h)
+    except RuntimeError:     # may happen that the ui handler simple disappears :D
+        errors.append(h)
+
     for h in errors:
         del _ui_handlers[h]
 
-- 
1.8.1.2


