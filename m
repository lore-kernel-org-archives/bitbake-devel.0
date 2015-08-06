Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 4AAC67653B
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Aug 2015 16:01:43 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga103.jf.intel.com with ESMTP; 06 Aug 2015 09:01:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,623,1432623600"; d="scan'208";a="537197638"
Received: from linux.intel.com ([10.23.219.25])
	by FMSMGA003.fm.intel.com with ESMTP; 06 Aug 2015 09:01:43 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id AEA9F6A4083;
	Thu,  6 Aug 2015 09:00:55 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  6 Aug 2015 19:01:34 +0300
Message-Id: <d5bbed667ae3585aa515d0b90329c99a62d2a3b7.1438876763.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1438876763.git.ed.bartosh@linux.intel.com>
References: <cover.1438876763.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 1/3] bitbake: toastergui: Fix toastertable table header reference
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
X-List-Received-Date: Thu, 06 Aug 2015 16:01:46 -0000

From: Michael Wood <michael.g.wood@intel.com>

A header id was mistakenly added to the table template which was not
also added to the simple version of the toaster template. We don't need
this id so remove it.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/toaster/toastergui/static/js/table.js          | 2 +-
 bitbake/lib/toaster/toastergui/templates/toastertable.html | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/toaster/toastergui/static/js/table.js b/bitbake/lib/toaster/toastergui/static/js/table.js
index d06a3f5..f18034d 100644
--- a/bitbake/lib/toaster/toastergui/static/js/table.js
+++ b/bitbake/lib/toaster/toastergui/static/js/table.js
@@ -198,7 +198,7 @@ function tableInit(ctx){
     if (tableChromeDone === true)
       return;
 
-    var tableHeadRow = table.find("thead#tableheader");
+    var tableHeadRow = table.find("thead");
     var editColMenu = $("#table-chrome-"+ctx.tableName).find(".editcol");
 
     tableHeadRow.html("");
diff --git a/bitbake/lib/toaster/toastergui/templates/toastertable.html b/bitbake/lib/toaster/toastergui/templates/toastertable.html
index 0473116..9ef4c6f 100644
--- a/bitbake/lib/toaster/toastergui/templates/toastertable.html
+++ b/bitbake/lib/toaster/toastergui/templates/toastertable.html
@@ -78,7 +78,7 @@
 
   <!-- The actual table -->
   <table class="table table-bordered table-hover tablesorter" id="{{table_name}}">
-    <thead id="tableheader">
+    <thead>
       <tr><th></th></tr>
     </thead>
     <tbody></tbody>
-- 
2.1.4


