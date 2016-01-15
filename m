Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 7363875C60
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 12:58:19 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga102.jf.intel.com with ESMTP; 15 Jan 2016 04:58:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,299,1449561600"; d="scan'208";a="633907041"
Received: from linux.intel.com ([10.23.219.25])
	by FMSMGA003.fm.intel.com with ESMTP; 15 Jan 2016 04:58:20 -0800
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id ECCF06A4004
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 05:46:15 -0800 (PST)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 15 Jan 2016 13:00:51 +0200
Message-Id: <063eb7390e8e6b8792e224d011881bc5c32d07f7.1452855461.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1452855461.git.ed.bartosh@linux.intel.com>
References: <cover.1452855461.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1452855461.git.ed.bartosh@linux.intel.com>
References: <cover.1452855461.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 08/23] toaster: toastergui: switch off filter highlights when inactive
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
X-List-Received-Date: Fri, 15 Jan 2016 12:58:19 -0000

From: Elliot Smith <elliot.smith@intel.com>

In ToasterTables with multiple columns which allow filtering
(e.g. all builds), selecting one filter, then a second filter
(e.g. selecting "failed builds" then "outcome" for all builds),
would result in both filters being highlighted at the same time.

Fix this by removing the "active" highlight on all column filter
buttons when a new filter value is submitted (via the filter modal).

NB to enable this, added a data-filter-on attribute to all
column filter buttons to make them easy to select.

[YOCTO #8738]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/static/js/table.js | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/static/js/table.js b/lib/toaster/toastergui/static/js/table.js
index fa01ddf..63f8a1f 100644
--- a/lib/toaster/toastergui/static/js/table.js
+++ b/lib/toaster/toastergui/static/js/table.js
@@ -248,7 +248,7 @@ function tableInit(ctx){
 
       /* Setup the filter button */
       if (col.filter_name){
-        var filterBtn = $('<a href="#" role="button" class="pull-right btn btn-mini" data-toggle="modal"><i class="icon-filter filtered"></i></a>');
+        var filterBtn = $('<a href="#" role="button" data-filter-on="' + col.filter_name + '" class="pull-right btn btn-mini" data-toggle="modal"><i class="icon-filter filtered"></i></a>');
 
         filterBtn.data('filter-name', col.filter_name);
         filterBtn.prop('id', col.filter_name);
@@ -565,6 +565,12 @@ function tableInit(ctx){
   $("#filter-modal-form-"+ctx.tableName).submit(function(e){
     e.preventDefault();
 
+    /* remove active status from all filter buttons so that only one filter
+       can be active at a time */
+    $('[data-filter-on]').each(function (index, filterBtn) {
+      filterBtnActive($(filterBtn), false);
+    });
+
     tableParams.filter = $(this).find("input[type='radio']:checked").val();
 
     var filterBtn = $("#" + tableParams.filter.split(":")[0]);
-- 
2.1.4


