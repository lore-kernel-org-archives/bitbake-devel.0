Return-Path: <brendan.le.foll@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id C1A49601B8
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 Mar 2016 10:32:04 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga101.jf.intel.com with ESMTP; 11 Mar 2016 02:32:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,320,1455004800"; d="scan'208";a="921670069"
Received: from jupiter.iwi.intel.com ([172.28.33.51])
	by fmsmga001.fm.intel.com with ESMTP; 11 Mar 2016 02:32:03 -0800
From: brendan.le.foll@intel.com
To: bitbake-devel@lists.openembedded.org
Date: Fri, 11 Mar 2016 10:32:58 +0000
Message-Id: <1457692378-8048-1-git-send-email-brendan.le.foll@intel.com>
X-Mailer: git-send-email 2.7.2
Subject: [PATCH] fetch2/npm: fix ud.registry so that alternative registries can be handled
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
X-List-Received-Date: Fri, 11 Mar 2016 10:32:06 -0000

From: Brendan Le Foll <brendan.le.foll@intel.com>

Fixes [YOCTO #9231]

npm when given an invalid registry URL with --registry actually goes and
fetches from the default registry, but this commit makes sure it goes to the
specified one.

Signed-off-by: Brendan Le Foll <brendan.le.foll@intel.com>
---
 lib/bb/fetch2/npm.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index d44454c..e8d9b11 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -80,7 +80,7 @@ class Npm(FetchMethod):
         if not ud.version:
             raise ParameterError("NPM fetcher requires a version parameter", ud.url)
         ud.bbnpmmanifest = "%s-%s.deps.json" % (ud.pkgname, ud.version)
-        ud.registry = "http://%s" % ud.basename
+        ud.registry = "http://%s" % (ud.url.replace('npm://', '', 1).split(';'))[0]
         prefixdir = "npm/%s" % ud.pkgname
         ud.pkgdatadir = d.expand("${DL_DIR}/%s" % prefixdir)
         if not os.path.exists(ud.pkgdatadir):
-- 
2.7.2


