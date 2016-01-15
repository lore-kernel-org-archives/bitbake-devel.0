Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 3770576486
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 12:58:30 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP; 15 Jan 2016 04:58:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,299,1449561600"; 
	d="scan'208,217";a="881987227"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga001.fm.intel.com with ESMTP; 15 Jan 2016 04:58:31 -0800
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 746FB6A4004
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 05:46:27 -0800 (PST)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 15 Jan 2016 13:01:01 +0200
Message-Id: <f656d2546119ef895a40419d3aea16be8c1f427b.1452855461.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1452855461.git.ed.bartosh@linux.intel.com>
References: <cover.1452855461.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1452855461.git.ed.bartosh@linux.intel.com>
References: <cover.1452855461.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 18/23] toaster: toastergui: mute label for filter actions with no records
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
X-List-Received-Date: Fri, 15 Jan 2016 12:58:30 -0000

From: Elliot Smith <elliot.smith@intel.com>

The radio button for a filter action is disabled if that filter
action has no associated records. However, the label retains
the normal font styling, so it's unclear that the action is
not available.

Add the "muted" class to the label for a filter action (and still
disable its radio button) if it has no records associated with it.

[YOCTO #8738]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/static/js/table.js | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/table.js b/lib/toaster/toastergui/static/js/table.js
index a253917..9384386 100644
--- a/lib/toaster/toastergui/static/js/table.js
+++ b/lib/toaster/toastergui/static/js/table.js
@@ -399,18 +399,21 @@ function tableInit(ctx){
    * show when selected
    */
   function createActionRadio(filterName, filterActionData) {
+    var hasNoRecords = (Number(filterActionData.count) == 0);
+
     var actionStr = '<div class="radio">' +
                     '<input type="radio" name="filter"' +
                     '       value="' + filterName + '"';
 
-    if (Number(filterActionData.count) == 0) {
+    if (hasNoRecords) {
       actionStr += ' disabled="disabled"';
     }
 
     actionStr += ' id="' + filterName + '">' +
                  '<input type="hidden" name="filter_value" value="on"' +
                  '       data-value-for="' + filterName + '">' +
-                 '<label class="filter-title"' +
+                 '<label class="filter-title' +
+                 (hasNoRecords ? ' muted' : '') + '"' +
                  '       for="' + filterName + '">' +
                  filterActionData.title +
                  ' (' + filterActionData.count + ')' +
-- 
2.1.4


