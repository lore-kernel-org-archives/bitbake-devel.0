Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by mail.openembedded.org (Postfix) with ESMTP id 2A62371A0C
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  6 Feb 2017 20:09:08 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga105.jf.intel.com with ESMTP; 06 Feb 2017 12:08:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,342,1477983600"; d="scan'208";a="222023483"
Received: from mmurr6x-mobl1.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.252.199.82])
	by fmsmga004.fm.intel.com with ESMTP; 06 Feb 2017 12:08:57 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  7 Feb 2017 09:08:51 +1300
Message-Id: <c87951820de6cf7b1066e222e59cfaee551824ee.1486411669.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1486411669.git.paul.eggleton@linux.intel.com>
References: <cover.1486411669.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 3/3] fetch2/npm: fix handling of os field
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
X-List-Received-Date: Mon, 06 Feb 2017 20:09:08 -0000

When I originally added this check I didn't quite understand how the
values in this field should be expressed - it seems from reading the
documentation if there is an entry starting with '!' then the list is
a blacklist and we shouldn't expect "linux" to be in the list, or we'll
end up skipping important dependencies.

This fixes fetching the "statsd" npm package.

Fixes [YOCTO #10760].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/fetch2/npm.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index 8c32f81..15b281f 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -182,7 +182,12 @@ class Npm(FetchMethod):
             if pkg_os:
                 if not isinstance(pkg_os, list):
                     pkg_os = [pkg_os]
-                if 'linux' not in pkg_os or '!linux' in pkg_os:
+                blacklist = False
+                for item in pkg_os:
+                    if item.startswith('!'):
+                        blacklist = True
+                        break
+                if (not blacklist and 'linux' not in pkg_os) or '!linux' in pkg_os:
                     logger.debug(2, "Skipping %s since it's incompatible with Linux" % pkg)
                     return
         #logger.debug(2, "Output URL is %s - %s - %s" % (ud.basepath, ud.basename, ud.localfile))
-- 
2.9.3


