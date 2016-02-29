Return-Path: <brendan.le.foll@intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id CECDF605BA
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Feb 2016 14:26:57 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga104.fm.intel.com with ESMTP; 29 Feb 2016 06:26:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,520,1449561600"; d="scan'208";a="897474657"
Received: from jupiter.iwi.intel.com ([172.28.33.51])
	by orsmga001.jf.intel.com with ESMTP; 29 Feb 2016 06:26:57 -0800
From: brendan.le.foll@intel.com
To: bitbake-devel@lists.openembedded.org
Date: Mon, 29 Feb 2016 14:27:43 +0000
Message-Id: <1456756063-29303-1-git-send-email-brendan.le.foll@intel.com>
X-Mailer: git-send-email 2.7.1
Subject: [PATCH] npm: in cases where shrinkwrap resolved a git URL, ignore it and grab dist.tarball
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
X-List-Received-Date: Mon, 29 Feb 2016 14:27:01 -0000

From: Brendan Le Foll <brendan.le.foll@intel.com>

npm-shrinkwrap will sometimes resolve a git URL which instead of a http url, in
this case go and grab the dist.tarball via npm instead of using the resolved
URL.

Signed-off-by: Brendan Le Foll <brendan.le.foll@intel.com>
---
 lib/bb/fetch2/npm.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index 212d167..44c181b 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -175,7 +175,7 @@ class Npm(FetchMethod):
     def _getshrinkeddependencies(self, pkg, data, version, d, ud, lockdown, manifest):
         logger.debug(2, "NPM shrinkwrap file is %s" % data)
         outputurl = "invalid"
-        if ('resolved' not in data):
+        if ('resolved' not in data) or (not data['resolved'].startswith('http')):
             # will be the case for ${PN}
             fetchcmd = "npm view %s@%s dist.tarball --registry %s" % (pkg, version, ud.registry)
             logger.debug(2, "Found this matching URL: %s" % str(fetchcmd))
-- 
2.7.1


