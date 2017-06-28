Return-Path: <ismo.puustinen@intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id F2655605BF
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 Jun 2017 10:19:58 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	28 Jun 2017 03:19:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.40,274,1496127600"; d="scan'208";a="1145604502"
Received: from ipuustin-desk.fi.intel.com ([10.237.72.72])
	by orsmga001.jf.intel.com with ESMTP; 28 Jun 2017 03:19:51 -0700
From: Ismo Puustinen <ismo.puustinen@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 28 Jun 2017 13:19:31 +0300
Message-Id: <20170628101931.36628-1-ismo.puustinen@intel.com>
X-Mailer: git-send-email 2.9.4
Subject: [PATCH] npm fetcher: fix unknown variable name.
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
X-List-Received-Date: Wed, 28 Jun 2017 10:19:59 -0000

'mirrortarball' is supposed to be a local variable to the function.

Signed-off-by: Ismo Puustinen <ismo.puustinen@intel.com>
---
 lib/bb/fetch2/npm.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index 5f79972..f2e7983 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -92,7 +92,7 @@ class Npm(FetchMethod):
 
         ud.write_tarballs = ((d.getVar("BB_GENERATE_MIRROR_TARBALLS") or "0") != "0")
         mirrortarball = 'npm_%s-%s.tar.xz' % (ud.pkgname, ud.version)
-        mirrortarball = ud.mirrortarball.replace('/', '-')
+        mirrortarball = mirrortarball.replace('/', '-')
         ud.fullmirror = os.path.join(d.getVar("DL_DIR"), mirrortarball)
         ud.mirrortarballs = [mirrortarball]
 
-- 
2.9.4


