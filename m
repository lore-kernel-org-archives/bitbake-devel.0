Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 1C1297327E
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 12:58:25 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga102.jf.intel.com with ESMTP; 15 Jan 2016 04:58:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,299,1449561600"; d="scan'208";a="633907053"
Received: from linux.intel.com ([10.23.219.25])
	by FMSMGA003.fm.intel.com with ESMTP; 15 Jan 2016 04:58:26 -0800
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id B563F6A4004
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 05:46:21 -0800 (PST)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 15 Jan 2016 13:00:56 +0200
Message-Id: <10b9d06b2389b13a95b857239e21509f1b1383a6.1452855461.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1452855461.git.ed.bartosh@linux.intel.com>
References: <cover.1452855461.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1452855461.git.ed.bartosh@linux.intel.com>
References: <cover.1452855461.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 13/23] toaster: toastergui: don't hide all elements with .col class
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
X-List-Received-Date: Fri, 15 Jan 2016 12:58:25 -0000

From: Elliot Smith <elliot.smith@intel.com>

Disabling the "project" column in a ToasterTable for builds
causes the recent builds area to be hidden. This is because
the column hiding code hides all elements with a class matching
".<column>", regardless of where they occur on the page; and
the recent builds area was using the ".project-name" class,
which means it is included in the set of elements which are hidden.

Scope the element search to the table so that only elements
within the table are hidden or shown.

[YOCTO #8792]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/static/js/table.js | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/table.js b/lib/toaster/toastergui/static/js/table.js
index 7ac4ed5..c154844 100644
--- a/lib/toaster/toastergui/static/js/table.js
+++ b/lib/toaster/toastergui/static/js/table.js
@@ -316,7 +316,7 @@ function tableInit(ctx){
       $("#"+ctx.tableName+" th").each(function(){
         for (var i in cols_hidden){
           if ($(this).hasClass(cols_hidden[i])){
-            $("."+cols_hidden[i]).hide();
+            table.find("."+cols_hidden[i]).hide();
             $("#checkbox-"+cols_hidden[i]).removeAttr("checked");
           }
         }
@@ -326,7 +326,7 @@ function tableInit(ctx){
          * user setting.
          */
         for (var i in defaultHiddenCols) {
-          $("."+defaultHiddenCols[i]).hide();
+          table.find("."+defaultHiddenCols[i]).hide();
           $("#checkbox-"+defaultHiddenCols[i]).removeAttr("checked");
         }
     }
@@ -370,9 +370,9 @@ function tableInit(ctx){
     var disabled_cols = [];
 
     if ($(this).prop("checked")) {
-      $("."+col).show();
+      table.find("."+col).show();
     }  else {
-      $("."+col).hide();
+      table.find("."+col).hide();
       /* If we're ordered by the column we're hiding remove the order by */
       if (col === tableParams.orderby ||
           '-' + col === tableParams.orderby){
-- 
2.1.4


