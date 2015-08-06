Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id C890476497
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Aug 2015 16:23:56 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 06 Aug 2015 09:23:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,623,1432623600"; d="scan'208";a="779152494"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga002.jf.intel.com with ESMTP; 06 Aug 2015 09:23:58 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id 53C456A4083;
	Thu,  6 Aug 2015 09:23:10 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  6 Aug 2015 19:23:46 +0300
Message-Id: <5d76198acb4ff2606733eecf82debb8b3221adba.1438877744.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1438877744.git.ed.bartosh@linux.intel.com>
References: <cover.1438877744.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 1/4] bitbake: toastergui: Machine select button url parameters change
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
X-List-Received-Date: Thu, 06 Aug 2015 16:23:58 -0000

From: Michael Wood <michael.g.wood@intel.com>

Update the url for changing the machine in the project page.

[YOCTO #8113]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/toaster/toastergui/tables.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/toaster/toastergui/tables.py b/bitbake/lib/toaster/toastergui/tables.py
index 8d5166be..1187244 100644
--- a/bitbake/lib/toaster/toastergui/tables.py
+++ b/bitbake/lib/toaster/toastergui/tables.py
@@ -323,7 +323,7 @@ class LayerMachinesTable(MachinesTable):
         self.add_column(title="Description",
                         field_name="description")
 
-        select_btn_template = '<a href="{% url "project" extra.pid %}#/machineselect={{data.name}}" class="btn btn-block select-machine-btn" {% if extra.in_prj == 0%}disabled="disabled"{%endif%}>Select machine</a>'
+        select_btn_template = '<a href="{% url "project" extra.pid %}?setMachine={{data.name}}" class="btn btn-block select-machine-btn" {% if extra.in_prj == 0%}disabled="disabled"{%endif%}>Select machine</a>'
 
         self.add_column(title="Select machine",
                         static_data_name="add-del-layers",
-- 
2.1.4


