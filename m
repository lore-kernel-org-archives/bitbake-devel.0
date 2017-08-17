Return-Path: <jair.de.jesus.gonzalez.plascencia@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 0D5BC78581
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Aug 2017 20:41:23 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	17 Aug 2017 13:41:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.41,389,1498546800"; d="scan'208";a="891183044"
Received: from jairdeje-mobl1.zpn.intel.com ([10.219.4.45])
	by FMSMGA003.fm.intel.com with ESMTP; 17 Aug 2017 13:41:24 -0700
From: Jair Gonzalez <jair.de.jesus.gonzalez.plascencia@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 17 Aug 2017 15:40:52 -0500
Message-Id: <ef1f9733bf8d635f32632ad89d7037b3664513a6.1503000752.git.jair.de.jesus.gonzalez.plascencia@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1503000752.git.jair.de.jesus.gonzalez.plascencia@linux.intel.com>
References: <cover.1503000752.git.jair.de.jesus.gonzalez.plascencia@linux.intel.com>
Subject: [selftest][PATCH V1 3/5] bitbake: tests: Remove empty assignments from event tests
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
X-List-Received-Date: Thu, 17 Aug 2017 20:41:23 -0000

Remove assignments from non-returning calls.

Signed-off-by: Jair Gonzalez <jair.de.jesus.gonzalez.plascencia@linux.intel.com>
---
 lib/bb/tests/event.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/bb/tests/event.py b/lib/bb/tests/event.py
index f11fda5..036fd7e 100644
--- a/lib/bb/tests/event.py
+++ b/lib/bb/tests/event.py
@@ -240,8 +240,8 @@ class EventHandlingTest(unittest.TestCase):
                          expected)
 
         # unregister handler and register it only for OperationStarted
-        result = bb.event.remove("event_handler1",
-                                 self._test_process.event_handler1)
+        bb.event.remove("event_handler1",
+                        self._test_process.event_handler1)
         mask = ["bb.event.OperationStarted"]
         result = bb.event.register("event_handler1",
                                    self._test_process.event_handler1,
@@ -254,8 +254,8 @@ class EventHandlingTest(unittest.TestCase):
                          expected)
 
         # unregister handler and register it only for OperationCompleted
-        result = bb.event.remove("event_handler1",
-                                 self._test_process.event_handler1)
+        bb.event.remove("event_handler1",
+                        self._test_process.event_handler1)
         mask = ["bb.event.OperationCompleted"]
         result = bb.event.register("event_handler1",
                                    self._test_process.event_handler1,
-- 
2.7.4


