Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 428A560053
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 30 Jul 2015 16:25:36 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga101.fm.intel.com with ESMTP; 30 Jul 2015 09:25:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,577,1432623600"; d="scan'208";a="616141181"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga003.jf.intel.com with ESMTP; 30 Jul 2015 09:25:36 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id 76E6A6A4005;
	Thu, 30 Jul 2015 09:24:50 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 30 Jul 2015 19:25:13 +0300
Message-Id: <71dbd67003ab3d968170ecf25241907627f943e0.1438271912.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <89ab50af017d1c1d78b263b16ee50be955db2cb2.1438271912.git.ed.bartosh@linux.intel.com>
References: <89ab50af017d1c1d78b263b16ee50be955db2cb2.1438271912.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1438271912.git.ed.bartosh@linux.intel.com>
References: <cover.1438271912.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 05/11] toaster: tts: improve logging in urlcheck.py
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
X-List-Received-Date: Thu, 30 Jul 2015 16:25:38 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch improves logging in the urlcheck.py.
It allows properly running just HTML5 tests outside the
test suite.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/contrib/tts/urlcheck.py | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/contrib/tts/urlcheck.py b/lib/toaster/contrib/tts/urlcheck.py
index 8514de8..0820f82 100644
--- a/lib/toaster/contrib/tts/urlcheck.py
+++ b/lib/toaster/contrib/tts/urlcheck.py
@@ -2,11 +2,12 @@ from __future__ import print_function
 import sys
 
 import httplib2
-
 import config
 import urllist
 
 
+config.logger.info("Testing %s with %s", config.TOASTER_BASEURL, config.W3C_VALIDATOR)
+
 def validate_html5(url):
     http_client = httplib2.Http(None)
     status = "Failed"
@@ -23,6 +24,12 @@ def validate_html5(url):
             status = resp['x-w3c-validator-status']
             errors = int(resp['x-w3c-validator-errors'])
             warnings = int(resp['x-w3c-validator-warnings'])
+
+            if status == 'Invalid':
+                config.logger.warn("Failed %s is %s\terrors %s warnings %s (check at %s)", url, status, errors, warnings, urlrequest)
+            else:
+                config.logger.debug("OK! %s", url)
+
     except Exception as exc:
         config.logger.warn("Failed validation call: %s", exc)
     return (status, errors, warnings)
-- 
2.1.4


