Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 536C27422C
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 12:58:25 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga103.jf.intel.com with ESMTP; 15 Jan 2016 04:58:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,299,1449561600"; d="scan'208";a="29894723"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga004.fm.intel.com with ESMTP; 15 Jan 2016 04:58:26 -0800
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id D94886A4004
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 05:46:22 -0800 (PST)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 15 Jan 2016 13:00:57 +0200
Message-Id: <79982a4b8f8a1c5cacc09522d7e0f1aeff01dce7.1452855461.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1452855461.git.ed.bartosh@linux.intel.com>
References: <cover.1452855461.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1452855461.git.ed.bartosh@linux.intel.com>
References: <cover.1452855461.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 14/23] toaster: toastergui: ensure filter_value updates
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
X-List-Received-Date: Fri, 15 Jan 2016 12:58:26 -0000

From: Elliot Smith <elliot.smith@intel.com>

Clicking on the radio button for a date range filter action
populates the from and to fields for that action if they are empty.

However, because this doesn't fire "change" events, clicking on
the radio button doesn't update the filter_value hidden field. This
means that the date range action's filter_value parameter isn't
set correctly when the filter popup is submitted.

Manually call the changeHandler() to set the filter_value whenever
the radio for a date range filter is clicked.

[YOCTO #8738]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/static/js/table.js | 32 +++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/table.js b/lib/toaster/toastergui/static/js/table.js
index c154844..a253917 100644
--- a/lib/toaster/toastergui/static/js/table.js
+++ b/lib/toaster/toastergui/static/js/table.js
@@ -488,20 +488,6 @@ function tableInit(ctx){
       action.find('[data-date-to-for]').datepicker(options);
     inputTo.val(selectedTo);
 
-    // if the radio button is checked and one or both of the datepickers are
-    // empty, populate them with today's date
-    radio.change(function () {
-      var now = new Date();
-
-      if (inputFrom.val() === '') {
-        inputFrom.datepicker('setDate', now);
-      }
-
-      if (inputTo.val() === '') {
-        inputTo.datepicker('setDate', now);
-      }
-    });
-
     // set filter_value based on date pickers when
     // one of their values changes
     var changeHandler = function () {
@@ -529,6 +515,24 @@ function tableInit(ctx){
       inputFrom.datepicker('option', 'maxDate', inputTo.val());
     });
 
+    // if the radio button is checked and one or both of the datepickers are
+    // empty, populate them with today's date
+    radio.change(function () {
+      var now = new Date();
+
+      if (inputFrom.val() === '') {
+        inputFrom.datepicker('setDate', now);
+      }
+
+      if (inputTo.val() === '') {
+        inputTo.datepicker('setDate', now);
+      }
+
+      // setting the date like this doesn't fire the changeHandler to
+      // update the filter_value, so do that manually instead
+      changeHandler()
+    });
+
     return action;
   }
 
-- 
2.1.4


