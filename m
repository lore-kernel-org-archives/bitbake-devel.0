Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id D5541764AC
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Aug 2015 16:23:58 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga103.jf.intel.com with ESMTP; 06 Aug 2015 09:23:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,623,1432623600"; d="scan'208";a="763376642"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga001.fm.intel.com with ESMTP; 06 Aug 2015 09:23:58 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id D98516A4083;
	Thu,  6 Aug 2015 09:23:11 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  6 Aug 2015 19:23:47 +0300
Message-Id: <b68afdf8cba88ae1798c6deff77687bab94336b9.1438877744.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <5d76198acb4ff2606733eecf82debb8b3221adba.1438877744.git.ed.bartosh@linux.intel.com>
References: <5d76198acb4ff2606733eecf82debb8b3221adba.1438877744.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1438877744.git.ed.bartosh@linux.intel.com>
References: <cover.1438877744.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 2/4] bitbake: toastergui: Move click disabled check after table ready event
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
X-List-Received-Date: Thu, 06 Aug 2015 16:23:59 -0000

From: Michael Wood <michael.g.wood@intel.com>

We were attaching this handler before the elements were fully ready in
the dom. Which allowed these links although disabled to take users to
the change machine page.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/toaster/toastergui/static/js/layerdetails.js | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/toaster/toastergui/static/js/layerdetails.js b/bitbake/lib/toaster/toastergui/static/js/layerdetails.js
index be6bbcd..d12d3ae 100644
--- a/bitbake/lib/toaster/toastergui/static/js/layerdetails.js
+++ b/bitbake/lib/toaster/toastergui/static/js/layerdetails.js
@@ -202,6 +202,12 @@ function layerDetailsPageInit (ctx) {
       /* re run the machinesTabShow to update the text */
       machinesTabShow();
     }
+
+    $(".select-machine-btn").click(function(e){
+      if ($(this).attr("disabled") === "disabled")
+        e.preventDefault();
+    });
+
   });
 
   $("#targets-tab").on('show', targetsTabShow);
@@ -385,10 +391,6 @@ function layerDetailsPageInit (ctx) {
     $(this).parents("form").submit();
   });
 
-  $(".select-machine-btn").click(function(e){
-    if ($(this).attr("disabled") === "disabled")
-      e.preventDefault();
-  });
 
   layerDepsList.find(".icon-trash").click(layerDepRemoveClick);
   layerDepsList.find("a").tooltip();
-- 
2.1.4


