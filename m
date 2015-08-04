Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 31E92766CB
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Aug 2015 19:47:03 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 04 Aug 2015 12:47:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,611,1432623600"; d="scan'208";a="761913053"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga001.fm.intel.com with ESMTP; 04 Aug 2015 12:47:02 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id CB0556A4083;
	Tue,  4 Aug 2015 12:46:15 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  4 Aug 2015 22:46:40 +0300
Message-Id: <736700b73c08684e3d03d30b9b398f999d28ec6a.1438717072.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <691696f2b87d41540b14b10ef08762f8529b4909.1438717072.git.ed.bartosh@linux.intel.com>
References: <691696f2b87d41540b14b10ef08762f8529b4909.1438717072.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1438717072.git.ed.bartosh@linux.intel.com>
References: <cover.1438717072.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 12/12] bitbake: toastergui: libtoaster typeahead Add in results highlighter
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
X-List-Received-Date: Tue, 04 Aug 2015 19:47:03 -0000

From: Michael Wood <michael.g.wood@intel.com>

Add a highlighter for the results in the typeahead, this highlights the
part of the results which is currently being matched. This is a modified
version of the bootstrap stock function with added escaping and the
addition of the details information.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/static/js/libtoaster.js | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/libtoaster.js b/lib/toaster/toastergui/static/js/libtoaster.js
index f6979f6..6ec0337 100644
--- a/lib/toaster/toastergui/static/js/libtoaster.js
+++ b/lib/toaster/toastergui/static/js/libtoaster.js
@@ -56,10 +56,14 @@ var libtoaster = (function (){
           return 1;
         },
         highlighter: function (item) {
-          if (item.hasOwnProperty('detail'))
-            /* Use jquery to escape the value as text into a span */
-            return $('<span></span>').text(item.name+' '+item.detail).get(0);
-          return $('<span></span>').text(item.name).get(0);
+          /* Use jquery to escape the item name and detail */
+          var current = $("<span></span>").text(item.name + ' '+item.detail);
+          current = current.html();
+
+          var query = this.query.replace(/[\-\[\]{}()*+?.,\\\^$|#\s]/g, '\\$&')
+          return current.replace(new RegExp('(' + query + ')', 'ig'), function ($1, match) {
+            return '<strong>' + match + '</strong>'
+          })
         },
         sorter: function (items) { return items; },
         xhrUrl: xhrUrl,
-- 
2.1.4


