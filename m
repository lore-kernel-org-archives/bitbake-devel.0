Return-Path: <jair.de.jesus.gonzalez.plascencia@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id DEB9478570
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Aug 2017 20:41:21 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	17 Aug 2017 13:41:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.41,389,1498546800"; d="scan'208";a="891183042"
Received: from jairdeje-mobl1.zpn.intel.com ([10.219.4.45])
	by FMSMGA003.fm.intel.com with ESMTP; 17 Aug 2017 13:41:23 -0700
From: Jair Gonzalez <jair.de.jesus.gonzalez.plascencia@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 17 Aug 2017 15:40:51 -0500
Message-Id: <fdcd7dae966456340e840ac51e1c2cf4473334c3.1503000752.git.jair.de.jesus.gonzalez.plascencia@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1503000752.git.jair.de.jesus.gonzalez.plascencia@linux.intel.com>
References: <cover.1503000752.git.jair.de.jesus.gonzalez.plascencia@linux.intel.com>
Subject: [selftest][PATCH V1 2/5] bitbake: tests: Add test for bb.event.worker_fire
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
X-List-Received-Date: Thu, 17 Aug 2017 20:41:22 -0000

Test the triggering of bb.event.worker_fire callback.

Signed-off-by: Jair Gonzalez <jair.de.jesus.gonzalez.plascencia@linux.intel.com>
---
 lib/bb/tests/event.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/bb/tests/event.py b/lib/bb/tests/event.py
index 1ddcb41..f11fda5 100644
--- a/lib/bb/tests/event.py
+++ b/lib/bb/tests/event.py
@@ -388,6 +388,14 @@ class EventHandlingTest(unittest.TestCase):
         self.assertEqual(self._test_ui1.event.send.call_args_list,
                          expected)
 
+    def test_worker_fire(self):
+        """ Test the triggering of bb.event.worker_fire callback """
+        bb.event.worker_fire = Mock()
+        event = bb.event.Event()
+        bb.event.fire(event, None)
+        expected = [call(event, None)]
+        self.assertEqual(bb.event.worker_fire.call_args_list, expected)
+
     def test_print_ui_queue(self):
         """ Test print_ui_queue method """
         event1 = bb.event.OperationStarted()
-- 
2.7.4


