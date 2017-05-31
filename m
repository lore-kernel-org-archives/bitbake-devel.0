Return-Path: <jair.de.jesus.gonzalez.plascencia@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id EE1DD77E33
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 May 2017 21:26:43 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	31 May 2017 14:26:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.39,276,1493708400"; d="scan'208";a="94079804"
Received: from jairdeje-mobl1.zpn.intel.com ([10.219.4.146])
	by orsmga002.jf.intel.com with ESMTP; 31 May 2017 14:26:45 -0700
From: Jair Gonzalez <jair.de.jesus.gonzalez.plascencia@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 31 May 2017 16:26:03 -0500
Message-Id: <60249cd4aa4af4d6537e1942796dd32131dad23b.1496259855.git.jair.de.jesus.gonzalez.plascencia@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1496259855.git.jair.de.jesus.gonzalez.plascencia@linux.intel.com>
References: <cover.1496259855.git.jair.de.jesus.gonzalez.plascencia@linux.intel.com>
Subject: [selftest][PATCH V4 3/3] bitbake: event: remove mapping for deleted event handlers
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
X-List-Received-Date: Wed, 31 May 2017 21:26:44 -0000

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


