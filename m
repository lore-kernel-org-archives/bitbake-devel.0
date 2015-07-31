Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 63748765B6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 12:09:39 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga103.jf.intel.com with ESMTP; 31 Jul 2015 05:09:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,584,1432623600"; d="scan'208";a="774000053"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga002.fm.intel.com with ESMTP; 31 Jul 2015 05:09:39 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id 5BF8C6A4083
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 05:08:54 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 31 Jul 2015 15:09:08 +0300
Message-Id: <93415a223aaa94a126d3d0d1b5f5e41928513d8d.1438343854.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1438343854.git.ed.bartosh@linux.intel.com>
References: <cover.1438343854.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1438343854.git.ed.bartosh@linux.intel.com>
References: <cover.1438343854.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 07/22] bitbake: toastergui: libtoaster Add show change notification function
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

Now that we have a change notification that is global move this
functionality to libtoaster for shared use.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/static/js/libtoaster.js | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/toaster/toastergui/static/js/libtoaster.js b/lib/toaster/toastergui/static/js/libtoaster.js
index 0000c57..afd665c 100644
--- a/lib/toaster/toastergui/static/js/libtoaster.js
+++ b/lib/toaster/toastergui/static/js/libtoaster.js
@@ -292,6 +292,13 @@ var libtoaster = (function (){
     return alertMsg.html();
   }
 
+  function _showChangeNotification(message){
+    var alertMsg = $("#change-notification-msg");
+
+    alertMsg.html(message);
+    $("#change-notification, #change-notification *").fadeIn();
+  }
+
 
   return {
     reload_params : reload_params,
@@ -306,6 +313,7 @@ var libtoaster = (function (){
     dumpsUrlParams : _dumpsUrlParams,
     addRmLayer : _addRmLayer,
     makeLayerAddRmAlertMsg : _makeLayerAddRmAlertMsg,
+    showChangeNotification : _showChangeNotification,
   };
 })();
 
-- 
2.1.4


