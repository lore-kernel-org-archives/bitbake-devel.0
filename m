Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 508AA766F5
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Aug 2015 19:47:14 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga103.jf.intel.com with ESMTP; 04 Aug 2015 12:47:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,611,1432623600"; d="scan'208";a="776778969"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga002.fm.intel.com with ESMTP; 04 Aug 2015 12:47:00 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id 41F276A4083;
	Tue,  4 Aug 2015 12:46:14 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  4 Aug 2015 22:46:39 +0300
Message-Id: <a9fcb2e468b186153bbb2f17c5f21470d05048fc.1438717072.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <691696f2b87d41540b14b10ef08762f8529b4909.1438717072.git.ed.bartosh@linux.intel.com>
References: <691696f2b87d41540b14b10ef08762f8529b4909.1438717072.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1438717072.git.ed.bartosh@linux.intel.com>
References: <cover.1438717072.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 11/12] bitbake: toastergui: libtoaster: typeahead resiliency for slow server
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
X-List-Received-Date: Tue, 04 Aug 2015 19:47:14 -0000

From: Michael Wood <michael.g.wood@intel.com>

When we have a slow request we don't want to see the typeahead results
changing in the middle of typing the item. To do this we make sure that
requests to the typeahead can only happen sequentially and that if
results have been retrieved but the input is now empty we don't bother
showing the results.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/static/js/libtoaster.js | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/static/js/libtoaster.js b/lib/toaster/toastergui/static/js/libtoaster.js
index 96e28b0..f6979f6 100644
--- a/lib/toaster/toastergui/static/js/libtoaster.js
+++ b/lib/toaster/toastergui/static/js/libtoaster.js
@@ -18,15 +18,24 @@ var libtoaster = (function (){
     if (!xhrUrl || xhrUrl.length === 0)
       throw("No url to typeahead supplied");
 
+    var xhrReq;
+
     jQElement.typeahead({
         source: function(query, process){
           xhrParams.search = query;
-          $.getJSON(xhrUrl, this.options.xhrParams, function(data){
+
+          /* If we have a request in progress don't fire off another one*/
+          if (xhrReq)
+            xhrReq.abort();
+
+          xhrReq = $.getJSON(xhrUrl, this.options.xhrParams, function(data){
             if (data.error !== "ok") {
               console.log("Error getting data from server "+data.error);
               return;
             }
 
+            xhrReq = null;
+
             return process(data.results);
           });
         },
@@ -41,6 +50,9 @@ var libtoaster = (function (){
             return 0;
           }
 
+          if (this.$element.val().length === 0)
+            return 0;
+
           return 1;
         },
         highlighter: function (item) {
@@ -52,6 +64,7 @@ var libtoaster = (function (){
         sorter: function (items) { return items; },
         xhrUrl: xhrUrl,
         xhrParams: xhrParams,
+        xhrReq: xhrReq,
     });
 
 
@@ -530,6 +543,9 @@ $(document).ready(function() {
     });
 
     $(document).ajaxError(function(event, jqxhr, settings, errMsg){
+      if (errMsg === 'abort')
+        return;
+
       console.warn("Problem with xhr call");
       console.warn(errMsg);
       console.warn(jqxhr.responseText);
-- 
2.1.4


