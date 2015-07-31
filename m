Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 7575B76615
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 12:09:57 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga101.jf.intel.com with ESMTP; 31 Jul 2015 05:09:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,584,1432623600"; d="scan'208";a="616731330"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga003.jf.intel.com with ESMTP; 31 Jul 2015 05:09:57 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id 53C7A6A4087
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 05:09:12 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 31 Jul 2015 15:09:22 +0300
Message-Id: <01b7063b97f0d4694a7581236546a01a524d8313.1438343854.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1438343854.git.ed.bartosh@linux.intel.com>
References: <cover.1438343854.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1438343854.git.ed.bartosh@linux.intel.com>
References: <cover.1438343854.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 21/22] bitbake: toastergui: layerBtn use libtoaster for change notification
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
X-List-Received-Date: Fri, 31 Jul 2015 12:09:57 -0000

From: Michael Wood <michael.g.wood@intel.com>

Use the common functionality for change notifications.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/static/js/layerBtn.js                    | 4 +---
 lib/toaster/toastergui/templates/generic-toastertable-page.html | 7 +------
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/layerBtn.js b/lib/toaster/toastergui/static/js/layerBtn.js
index 44bf612..4243c2b 100644
--- a/lib/toaster/toastergui/static/js/layerBtn.js
+++ b/lib/toaster/toastergui/static/js/layerBtn.js
@@ -11,8 +11,7 @@ function layerBtnsInit(ctx) {
     var thisBtn = $(this);
 
     libtoaster.addRmLayer(layerObj, add, function (layerDepsList){
-      var alertMsg = $("#alert-msg");
-      alertMsg.html(libtoaster.makeLayerAddRmAlertMsg(layerObj, layerDepsList, add));
+      libtoaster.showChangeNotification(libtoaster.makeLayerAddRmAlertMsg(layerObj, layerDepsList, add));
 
       /* In-cell notification */
       var notification = $('<div id="temp-inline-notify" style="display: none; font-size: 11px; line-height: 1.3;" class="tooltip-inner"></div>');
@@ -53,7 +52,6 @@ function layerBtnsInit(ctx) {
         });
       }
 
-      $("#zone1alerts, #zone1alerts *").fadeIn();
     });
   });
 
diff --git a/lib/toaster/toastergui/templates/generic-toastertable-page.html b/lib/toaster/toastergui/templates/generic-toastertable-page.html
index 654cdf4..33aa8ce 100644
--- a/lib/toaster/toastergui/templates/generic-toastertable-page.html
+++ b/lib/toaster/toastergui/templates/generic-toastertable-page.html
@@ -10,12 +10,7 @@
   <i class="icon-question-sign get-help heading-help" title="This page lists {{title}} compatible with the release selected for this project, which is {{project.release.description}}"></i>
   {% endif %}
 </h2>
-<div id="zone1alerts" style="display:none">
-  <div class="alert alert-info lead">
-    <button type="button" class="close" id="hide-alert">&times;</button>
-    <span id="alert-msg"></span>
-  </div>
-</div>
+
 {% url table_name project.id as xhr_table_url %}
 {% include "toastertable.html" %}
 
-- 
2.1.4


