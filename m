Return-Path: <elliot.smith@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 660917704D
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  5 Oct 2015 09:43:28 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga102.fm.intel.com with ESMTP; 05 Oct 2015 02:43:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,637,1437462000"; d="scan'208";a="784630476"
Received: from blynch-mobl1.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.3.31])
	by orsmga001.jf.intel.com with ESMTP; 05 Oct 2015 02:43:28 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  5 Oct 2015 10:43:15 +0100
Message-Id: <21a0ef19b88a55684da4d18c14f3f358cea21ca8.1444038048.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <04c22e69056969f61173107062a4eec82a4bc3ed.1444038048.git.elliot.smith@intel.com>
References: <04c22e69056969f61173107062a4eec82a4bc3ed.1444038048.git.elliot.smith@intel.com>
In-Reply-To: <cover.1444038048.git.elliot.smith@intel.com>
References: <cover.1444038048.git.elliot.smith@intel.com>
Subject: [PATCH 3/6] toaster: add task to the target_information
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
X-List-Received-Date: Mon, 05 Oct 2015 09:43:28 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Added task information from BuildStarted event to the
target_information structure. Made sure 'build' task
is not set in Target objects as it shouldn't be shown
in Toaster UI.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 9fdde29..34a8694 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -925,6 +925,12 @@ class BuildInfoHelper(object):
         target_information = {}
         target_information['targets'] = event._pkgs
         target_information['build'] = build_obj
+        task = getattr(event, 'task', '')
+        if task.startswith('do_'):
+            task = task[3:]
+        if task == 'build':
+            task = ''
+        target_information['task'] = task
 
         self.internal_state['targets'] = self.orm_wrapper.create_target_objects(target_information)
 
-- 
1.9.3

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


