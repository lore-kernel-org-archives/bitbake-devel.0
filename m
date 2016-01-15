Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 4A02273232
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 12:58:15 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 15 Jan 2016 04:58:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,299,1449561600"; d="scan'208";a="881987107"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga001.fm.intel.com with ESMTP; 15 Jan 2016 04:58:16 -0800
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 8B45A6A4004
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 05:46:12 -0800 (PST)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 15 Jan 2016 13:00:48 +0200
Message-Id: <0d8f83a2d13a8c1dccb9b16eaaeee2a6c8acfd69.1452855461.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1452855461.git.ed.bartosh@linux.intel.com>
References: <cover.1452855461.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1452855461.git.ed.bartosh@linux.intel.com>
References: <cover.1452855461.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 05/23] toaster: toastergui: use event delegates for hover help elements
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
X-List-Received-Date: Fri, 15 Jan 2016 12:58:15 -0000

From: Elliot Smith <elliot.smith@intel.com>

libtoaster.js binds to hover help elements via their hover() and
mouseout() methods. However, any elements added to the DOM after
libtoaster has initialised will not have these bindings added.
This causes a problem for ToasterTables which have hover-help
elements (e.g. the builds/ table).

Use the on() method instead. This uses event delegation to bind
a handler to any th or td elements already in the DOM, or
which will be added to the DOM in future. ToasterTables can
now reconstruct the table DOM and still have the correct handlers
attached once the table is done.

[YOCTO #8738]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/static/js/libtoaster.js | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/libtoaster.js b/lib/toaster/toastergui/static/js/libtoaster.js
index c04f7ab..1012034 100644
--- a/lib/toaster/toastergui/static/js/libtoaster.js
+++ b/lib/toaster/toastergui/static/js/libtoaster.js
@@ -448,10 +448,12 @@ $(document).ready(function() {
 
     // show help bubble only on hover inside tables
     $(".hover-help").css("visibility","hidden");
-    $("th, td").hover(function () {
+
+    $("table").on("mouseover", "th, td", function () {
         $(this).find(".hover-help").css("visibility","visible");
     });
-    $("th, td").mouseleave(function () {
+
+    $("table").on("mouseleave", "th, td", function () {
         $(this).find(".hover-help").css("visibility","hidden");
     });
 
-- 
2.1.4


