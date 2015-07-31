Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 74EDC765B6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 12:09:40 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP; 31 Jul 2015 05:09:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,584,1432623600"; d="scan'208";a="759163397"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga001.fm.intel.com with ESMTP; 31 Jul 2015 05:09:40 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id 811C56A4083
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 05:08:55 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 31 Jul 2015 15:09:09 +0300
Message-Id: <caa2c2603b263db520d19920b366ad7c54b93819.1438343854.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1438343854.git.ed.bartosh@linux.intel.com>
References: <cover.1438343854.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1438343854.git.ed.bartosh@linux.intel.com>
References: <cover.1438343854.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 08/22] bitbake: toastergui: tables Add name field to layers table
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
X-List-Received-Date: Fri, 31 Jul 2015 12:09:40 -0000

From: Michael Wood <michael.g.wood@intel.com>

This field is required by the typeahead in the new project page to do
the name matching on.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/tables.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/toaster/toastergui/tables.py b/lib/toaster/toastergui/tables.py
index 782ae80..8d5166be 100644
--- a/lib/toaster/toastergui/tables.py
+++ b/lib/toaster/toastergui/tables.py
@@ -196,6 +196,11 @@ class LayersTable(ToasterTable):
                         field_name="layerdetailurl",
                         computation = lambda x: reverse('layerdetails', args=(project.id, x.id)))
 
+        self.add_column(title="name",
+                        displayable = False,
+                        field_name="name",
+                        computation = lambda x: x.layer.name)
+
 
 
 
-- 
2.1.4


