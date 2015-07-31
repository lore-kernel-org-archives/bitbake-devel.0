Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 4502A765CC
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 12:09:46 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga102.fm.intel.com with ESMTP; 31 Jul 2015 05:09:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,584,1432623600"; d="scan'208";a="533657606"
Received: from linux.intel.com ([10.23.219.25])
	by FMSMGA003.fm.intel.com with ESMTP; 31 Jul 2015 05:09:46 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id 485296A4087
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 05:09:01 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 31 Jul 2015 15:09:14 +0300
Message-Id: <8bd7e5c90a0afd6ac8d7d8961653cc0203ecff34.1438343854.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1438343854.git.ed.bartosh@linux.intel.com>
References: <cover.1438343854.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1438343854.git.ed.bartosh@linux.intel.com>
References: <cover.1438343854.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 13/22] bitbake: toastergui: libtoaster Make sure we always pass format=json
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
X-List-Received-Date: Fri, 31 Jul 2015 12:09:46 -0000

From: Michael Wood <michael.g.wood@intel.com>

The new API for typeahead requires that we pass this parameter in to make
sure we get a JSON response.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/static/js/libtoaster.js | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/toaster/toastergui/static/js/libtoaster.js b/lib/toaster/toastergui/static/js/libtoaster.js
index 079bbcb..115df80 100644
--- a/lib/toaster/toastergui/static/js/libtoaster.js
+++ b/lib/toaster/toastergui/static/js/libtoaster.js
@@ -19,6 +19,7 @@ var libtoaster = (function (){
     jQElement.typeahead({
         source: function(query, process){
           xhrParams.search = query;
+          xhrParams.format = "json";
           $.getJSON(xhrUrl, this.options.xhrParams, function(data){
             if (data.error !== "ok") {
               console.log("Error getting data from server "+data.error);
-- 
2.1.4


