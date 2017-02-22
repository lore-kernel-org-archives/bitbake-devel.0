Return-Path: <jair.de.jesus.gonzalez.plascencia@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 215B172F37
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Feb 2017 00:00:46 +0000 (UTC)
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	21 Feb 2017 16:00:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.35,191,1484035200"; d="scan'208";a="68032543"
Received: from jairdeje-mobl1.zpn.intel.com ([10.219.4.48])
	by fmsmga005.fm.intel.com with ESMTP; 21 Feb 2017 16:00:47 -0800
From: Jair Gonzalez <jair.de.jesus.gonzalez.plascencia@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 21 Feb 2017 18:00:09 -0600
Message-Id: <1487721630-3712-3-git-send-email-jair.de.jesus.gonzalez.plascencia@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Subject: [selftest][PATCH V3 3/3] bitbake: event: remove mapping for deleted event handlers
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
X-List-Received-Date: Wed, 22 Feb 2017 00:00:46 -0000

The current remove method for class event handlers does not update the
event mapping after an event handler is deleted from the main dictionary.

This change enhances the remove method by also updating the event mapping
accordingly.

This was detected after creating the bb.tests.event module.

[YOCTO #10368]

Signed-off-by: Jair Gonzalez <jair.de.jesus.gonzalez.plascencia@linux.intel.com>
---
 lib/bb/event.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index 6d8493b..e5b7447 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -264,6 +264,11 @@ def register(name, handler, mask=None, filename=None, lineno=None):
 def remove(name, handler):
     """Remove an Event handler"""
     _handlers.pop(name)
+    if name in _catchall_handlers:
+        _catchall_handlers.pop(name)
+    for event in _event_handler_map.keys():
+        if name in _event_handler_map[event]:
+            _event_handler_map[event].pop(name)
 
 def get_handlers():
     return _handlers
@@ -783,4 +788,3 @@ class NetworkTestFailed(Event):
     """
     Event to indicate network test has failed
     """
-
-- 
2.7.4


