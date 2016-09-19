Return-Path: <brian.avery@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 68F25731CF
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 Sep 2016 02:31:53 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga101.fm.intel.com with ESMTP; 18 Sep 2016 19:31:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,360,1470726000"; 
	d="scan'208,217";a="1032847458"
Received: from bavery-ws-desk.jf.intel.com ([10.7.201.28])
	by orsmga001.jf.intel.com with ESMTP; 18 Sep 2016 19:31:53 -0700
From: bavery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 18 Sep 2016 19:33:14 -0700
Message-Id: <5025e88db9e7cd7fd6a5dbca3395b56606549114.1474252113.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <b5b92903847dc0eb537848585ee338a1a8bcb15f.1474252113.git.brian.avery@intel.com>
References: <b5b92903847dc0eb537848585ee338a1a8bcb15f.1474252113.git.brian.avery@intel.com>
In-Reply-To: <cover.1474252113.git.brian.avery@intel.com>
References: <cover.1474252113.git.brian.avery@intel.com>
Cc: bavery <brian.avery@intel.com>,
	Belen Barros Pena <belen.barros.pena@linux.intel.com>
Subject: [PATCH 2/3] toaster: Indicate active navigation element
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
X-List-Received-Date: Mon, 19 Sep 2016 02:31:53 -0000

From: Belen Barros Pena <belen.barros.pena@linux.intel.com>

The left navigation in the build history pages is not showing the active
item when you navigate directly to the errors or warnings information in
the build summary. Add a special case to make sure the "build summary"
item is highlighted.

[YOCTO #9864]

Signed-off-by: Belen Barros Pena <belen.barros.pena@linux.intel.com>
Signed-off-by: bavery <brian.avery@intel.com>
---
 lib/toaster/toastergui/templates/basebuildpage.html | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/templates/basebuildpage.html b/lib/toaster/toastergui/templates/basebuildpage.html
index 50658e0..01d3117 100644
--- a/lib/toaster/toastergui/templates/basebuildpage.html
+++ b/lib/toaster/toastergui/templates/basebuildpage.html
@@ -38,10 +38,13 @@
             $(this).parent().addClass("active");
           } else {
             /* Special case the configvar as this is part of configuration
-             * page but is a separate url
+             * page but is a separate url, and the direct links to errors
+             * and warnings, which are part of the build dashboard
              */
             if (window.location.pathname === configVarUrl){
               $("#menu-configuration").addClass("active");
+            } else if (currentUrl.indexOf('error') > 1 || currentUrl.indexOf('warning') > 1){
+              $("#menu-dashboard").addClass("active");
             } else {
               $(this).parent().removeClass("active");
             }
@@ -57,7 +60,7 @@
     <div class="row">
       <div id="nav" class="col-md-2">
         <ul class="nav nav-pills nav-stacked" id="build-menu">
-          <li
+          <li id="menu-dashboard"
             {% if request.resolver_match.url_name == 'builddashboard'  %}
               class="active"
             {% endif %} >
-- 
1.9.1


