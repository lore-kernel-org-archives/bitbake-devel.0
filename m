Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 76DEE70101
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Jul 2016 16:00:04 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga104.fm.intel.com with ESMTP; 21 Jul 2016 09:00:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,399,1464678000"; d="scan'208";a="1026439911"
Received: from linux.intel.com ([10.54.29.200])
	by fmsmga002.fm.intel.com with ESMTP; 21 Jul 2016 09:00:05 -0700
Received: from ed.fi.intel.com (ed.fi.intel.com [10.237.72.179])
	by linux.intel.com (Postfix) with ESMTP id 3E4516A4006
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Jul 2016 08:59:55 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 21 Jul 2016 18:58:39 +0300
Message-Id: <8c9a5c38068ce8b1dc8610b9e15368d046ee65ae.1469116389.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <cover.1469116389.git.ed.bartosh@linux.intel.com>
References: <cover.1469116389.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1469116389.git.ed.bartosh@linux.intel.com>
References: <cover.1469116389.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 2/3] toaster: set non-hideable columns for built recipes table
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
X-List-Received-Date: Thu, 21 Jul 2016 16:00:07 -0000

From: Elliot Smith <elliot.smith@intel.com>

None of the columns in the built recipes table are marked
as not hideable, so it is possible to remove all the columns
and make the table disappear.

Set the recipe name and version columns as not hideable.

Also rename the "Name" column to "Recipe", for consistency with
the design and with other recipe tables.

[YOCTO #9833]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/toaster/toastergui/buildtables.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/toaster/toastergui/buildtables.py b/bitbake/lib/toaster/toastergui/buildtables.py
index f845c66..82a8ba5 100644
--- a/bitbake/lib/toaster/toastergui/buildtables.py
+++ b/bitbake/lib/toaster/toastergui/buildtables.py
@@ -295,13 +295,15 @@ class BuiltRecipesTable(BuildTablesMixin):
         {% endif %}{% endwith %}{% endwith %}
         '''
 
-        self.add_column(title="Name",
+        self.add_column(title="Recipe",
                         field_name="name",
                         static_data_name='name',
                         orderable=True,
+                        hideable=False,
                         static_data_template=recipe_name_tmpl)
 
         self.add_column(title="Version",
+                        hideable=False,
                         field_name="version")
 
         self.add_column(title="Dependencies",
-- 
2.6.6


