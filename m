Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 1CF8870101
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Jul 2016 15:59:55 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga102.jf.intel.com with ESMTP; 21 Jul 2016 08:59:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,399,1464678000"; d="scan'208";a="850702052"
Received: from linux.intel.com ([10.54.29.200])
	by orsmga003.jf.intel.com with ESMTP; 21 Jul 2016 08:59:34 -0700
Received: from ed.fi.intel.com (ed.fi.intel.com [10.237.72.179])
	by linux.intel.com (Postfix) with ESMTP id 5C4FB6A4006
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Jul 2016 08:59:24 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 21 Jul 2016 18:58:38 +0300
Message-Id: <bb35c9e706c358a1bbf623abfef4e58522b05722.1469116389.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <cover.1469116389.git.ed.bartosh@linux.intel.com>
References: <cover.1469116389.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1469116389.git.ed.bartosh@linux.intel.com>
References: <cover.1469116389.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 1/3] toaster: set non-hideable columns for build tasks table
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
X-List-Received-Date: Thu, 21 Jul 2016 15:59:57 -0000

From: Elliot Smith <elliot.smith@intel.com>

The task, recipe and order columns in the build tasks table
should not be hideable. If they are, it's possible for the
table to have all of its columns hidden so that it no longer
displays.

Set the hideable property to prevent these columns from being
hidden.

[YOCTO #9833]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/toaster/toastergui/buildtables.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/bitbake/lib/toaster/toastergui/buildtables.py b/bitbake/lib/toaster/toastergui/buildtables.py
index f3d7236..f845c66 100644
--- a/bitbake/lib/toaster/toastergui/buildtables.py
+++ b/bitbake/lib/toaster/toastergui/buildtables.py
@@ -431,17 +431,20 @@ class BuildTasksTable(BuildTablesMixin):
         self.add_column(title="Order",
                         static_data_name="order",
                         static_data_template='{{data.order}}',
+                        hideable=False,
                         orderable=True)
 
         self.add_column(title="Task",
                         static_data_name="task_name",
                         static_data_template=task_link_tmpl(
                             "{{data.task_name}}"),
+                        hideable=False,
                         orderable=True)
 
         self.add_column(title="Recipe",
                         static_data_name='recipe__name',
                         static_data_template=recipe_name_tmpl,
+                        hideable=False,
                         orderable=True)
 
         self.add_column(title="Recipe version",
-- 
2.6.6


