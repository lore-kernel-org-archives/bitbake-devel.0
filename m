Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id D09D4763E1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 30 Jul 2015 16:25:53 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga103.fm.intel.com with ESMTP; 30 Jul 2015 09:25:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,577,1432623600"; d="scan'208";a="774609849"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga002.jf.intel.com with ESMTP; 30 Jul 2015 09:25:31 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id BE6026A4005;
	Thu, 30 Jul 2015 09:24:45 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 30 Jul 2015 19:25:10 +0300
Message-Id: <74b002e88eefb6ffe3f4cc99d2e7f101e1e884dc.1438271912.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <89ab50af017d1c1d78b263b16ee50be955db2cb2.1438271912.git.ed.bartosh@linux.intel.com>
References: <89ab50af017d1c1d78b263b16ee50be955db2cb2.1438271912.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1438271912.git.ed.bartosh@linux.intel.com>
References: <cover.1438271912.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 02/11] toaster: tts: clean up HTML5 compatible url list
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
X-List-Received-Date: Thu, 30 Jul 2015 16:25:55 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch cleans up the list of URLs that are tested for
HTML5 compatibility using the w3c-validator. It removes
the URLs that are no longer in use, and the AJAX-only URLs
that return JSON content.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/contrib/tts/urllist.py | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/lib/toaster/contrib/tts/urllist.py b/lib/toaster/contrib/tts/urllist.py
index 3f3a7c2..6db9ffc 100644
--- a/lib/toaster/contrib/tts/urllist.py
+++ b/lib/toaster/contrib/tts/urllist.py
@@ -17,7 +17,6 @@ URLS = [
     'toastergui/build/1/package_included_reverse_dependencies/1/1',
     'toastergui/build/1/target/1',
     'toastergui/build/1/target/1/targetpkg',
-    'toastergui/dentries/build/1/target/1',
     'toastergui/build/1/target/1/dirinfo',
     'toastergui/build/1/target/1/dirinfo_filepath/_/bin/bash',
     'toastergui/build/1/configuration',
@@ -28,19 +27,13 @@ URLS = [
     'toastergui/build/1/target/1/packagefile/1',
     'toastergui/newproject/',
     'toastergui/projects/',
-    'toastergui/project/',
     'toastergui/project/1',
     'toastergui/project/1/configuration',
     'toastergui/project/1/builds/',
     'toastergui/project/1/layers/',
     'toastergui/project/1/layer/1',
-    'toastergui/project/1/layer/',
     'toastergui/project/1/importlayer',
     'toastergui/project/1/targets/',
     'toastergui/project/1/machines/',
-    'toastergui/xhr_configvaredit/1',
-    'toastergui/xhr_importlayer/',
-    'toastergui/xhr_updatelayer/',
-    'toastergui/project/1/buildrequest/1',
     'toastergui/',
 ]
-- 
2.1.4


