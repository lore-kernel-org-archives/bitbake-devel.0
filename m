Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id BFD7172486
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Dec 2014 10:50:33 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 08 Dec 2014 02:50:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.07,537,1413270000"; d="scan'208";a="644158896"
Received: from apwitke-mobl2.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.30.33])
	by fmsmga002.fm.intel.com with ESMTP; 08 Dec 2014 02:50:32 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  8 Dec 2014 10:50:24 +0000
Message-Id: <3f9be0f4b65bdad620dbb5a370e8dce49b30c75b.1418034514.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1418034514.git.paul.eggleton@linux.intel.com>
References: <cover.1418034514.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1418034514.git.paul.eggleton@linux.intel.com>
References: <cover.1418034514.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 3/4] event: add a means of filtering events internally
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
X-List-Received-Date: Mon, 08 Dec 2014 10:50:34 -0000

When using external tinfoil-based utilities, it is useful to be able to
turn off most of the event handlers; for example sstate_eventhandler
doesn't like being sent events for any recipe which has been skipped.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/event.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index 32df779..9645476 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -67,6 +67,7 @@ _ui_logfilters = {}
 _ui_handler_seq = 0
 _event_handler_map = {}
 _catchall_handlers = {}
+_eventfilter = None
 
 def execute_handler(name, handler, event, d):
     event.data = d
@@ -94,6 +95,9 @@ def fire_class_handlers(event, d):
     evt_hmap = _event_handler_map.get(eid, {})
     for name, handler in _handlers.iteritems():
         if name in _catchall_handlers or name in evt_hmap:
+            if _eventfilter:
+                if not _eventfilter(name, handler, event, d):
+                    continue
             execute_handler(name, handler, event, d)
 
 ui_queue = []
@@ -204,6 +208,10 @@ def remove(name, handler):
     """Remove an Event handler"""
     _handlers.pop(name)
 
+def set_eventfilter(func):
+    global _eventfilter
+    _eventfilter = func
+
 def register_UIHhandler(handler):
     bb.event._ui_handler_seq = bb.event._ui_handler_seq + 1
     _ui_handlers[_ui_handler_seq] = handler
-- 
1.9.3


