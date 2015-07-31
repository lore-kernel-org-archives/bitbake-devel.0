Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 44F51765EB
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 12:09:47 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga102.fm.intel.com with ESMTP; 31 Jul 2015 05:09:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,584,1432623600"; d="scan'208";a="533657613"
Received: from linux.intel.com ([10.23.219.25])
	by FMSMGA003.fm.intel.com with ESMTP; 31 Jul 2015 05:09:47 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id 67E4C6A4083
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 05:09:02 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 31 Jul 2015 15:09:15 +0300
Message-Id: <dda7307fe9ba06dbdd03ad3ced1069b222314acc.1438343854.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1438343854.git.ed.bartosh@linux.intel.com>
References: <cover.1438343854.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1438343854.git.ed.bartosh@linux.intel.com>
References: <cover.1438343854.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 14/22] bitbake: toastergui: libtoaster: Add guard against missing name property
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
X-List-Received-Date: Fri, 31 Jul 2015 12:09:47 -0000

From: Michael Wood <michael.g.wood@intel.com>

Add a debug warning if a JSON payload isn't compatible. i.e. without a
name field.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/static/js/libtoaster.js | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/static/js/libtoaster.js b/lib/toaster/toastergui/static/js/libtoaster.js
index 115df80..22377f0 100644
--- a/lib/toaster/toastergui/static/js/libtoaster.js
+++ b/lib/toaster/toastergui/static/js/libtoaster.js
@@ -34,7 +34,14 @@ var libtoaster = (function (){
           selectedCB(itemObj);
           return item;
         },
-        matcher: function(item) {  return ~item.name.toLowerCase().indexOf(this.query.toLowerCase()); },
+        matcher: function(item) {
+          if (!item.hasOwnProperty('name')) {
+            console.log("Name property missing in data");
+            return 0;
+          }
+
+          return ~item.name.toLowerCase().indexOf(this.query.toLowerCase());
+        },
         highlighter: function (item) {
           if (item.hasOwnProperty('detail'))
             /* Use jquery to escape the value as text into a span */
-- 
2.1.4


