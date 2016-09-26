Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id A3D9C60807
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Sep 2016 11:00:24 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga103.fm.intel.com with ESMTP; 26 Sep 2016 04:00:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,399,1470726000"; d="scan'208";a="1036563399"
Received: from linux.intel.com ([10.54.29.200])
	by orsmga001.jf.intel.com with ESMTP; 26 Sep 2016 04:00:25 -0700
Received: from ed.fi.intel.com (ed.fi.intel.com [10.237.72.179])
	by linux.intel.com (Postfix) with ESMTP id 3B5476A4006
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Sep 2016 03:59:59 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 26 Sep 2016 13:59:30 +0300
Message-Id: <c533faeea2820b91630b2657449604d600bc2b5f.1474887106.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <cover.1474887106.git.ed.bartosh@linux.intel.com>
References: <cover.1474887106.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1474887106.git.ed.bartosh@linux.intel.com>
References: <cover.1474887106.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 03/10] toaster: libtoaster Add a global notification set/show mechanism
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
X-List-Received-Date: Mon, 26 Sep 2016 11:00:24 -0000

From: Michael Wood <michael.g.wood@intel.com>

We now have a number of places where we show change notifications based
on an event in a previous page (imported a layer, deleted a build,
deleted a project etc) and we show these notifications on various pages
so we add a simple notification utility to libtoaster.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/static/js/libtoaster.js | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/lib/toaster/toastergui/static/js/libtoaster.js b/lib/toaster/toastergui/static/js/libtoaster.js
index b2099a6..8e2221d 100644
--- a/lib/toaster/toastergui/static/js/libtoaster.js
+++ b/lib/toaster/toastergui/static/js/libtoaster.js
@@ -449,6 +449,16 @@ var libtoaster = (function () {
     ajaxLoadingTimerEnabled = false;
   }
 
+  /* Utility function to set a notification for the next page load */
+  function _setNotification(name, message){
+    var data = {
+      name: name,
+      message: message
+    };
+
+    $.cookie('toaster-notification', JSON.stringify(data), { path: '/'});
+  }
+
   return {
     enableAjaxLoadingTimer: _enableAjaxLoadingTimer,
     disableAjaxLoadingTimer: _disableAjaxLoadingTimer,
@@ -468,6 +478,7 @@ var libtoaster = (function () {
     showChangeNotification : _showChangeNotification,
     createCustomRecipe: _createCustomRecipe,
     makeProjectNameValidation: _makeProjectNameValidation,
+    setNotification: _setNotification,
   };
 })();
 
@@ -502,6 +513,21 @@ function reload_params(params) {
 /* Things that happen for all pages */
 $(document).ready(function() {
 
+  (function showNotificationRequest(){
+    var cookie = $.cookie('toaster-notification');
+
+    if (!cookie)
+      return;
+
+    var notificationData = JSON.parse(cookie);
+
+    libtoaster.showChangeNotification(notificationData.message);
+
+    $.removeCookie('toaster-notification', { path: "/"});
+  })();
+
+
+
   var ajaxLoadingTimer;
 
   /* If we don't have a console object which might be the case in some
-- 
2.6.6


