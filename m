Return-Path: <anibal.limon@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id B9C8A723C3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Nov 2014 01:12:20 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga102.jf.intel.com with ESMTP; 27 Nov 2014 17:09:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.04,691,1406617200"; d="scan'208";a="491044068"
Received: from alimon-thinkpad-w540.zpn.intel.com ([10.219.4.148])
	by orsmga003.jf.intel.com with ESMTP; 27 Nov 2014 17:09:20 -0800
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 27 Nov 2014 19:12:07 -0600
Message-Id: <83c65baed4b6e2c89cd835d9db32f20904bef41e.1417134564.git.anibal.limon@linux.intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1417134564.git.anibal.limon@linux.intel.com>
References: <cover.1417134564.git.anibal.limon@linux.intel.com>
In-Reply-To: <cover.1417134564.git.anibal.limon@linux.intel.com>
References: <cover.1417134564.git.anibal.limon@linux.intel.com>
MIME-Version: 1.0
Subject: [PATCH 09/12] fetch2/wget: latest_versionstring add support for search in RAW html lines
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
X-List-Received-Date: Fri, 28 Nov 2014 01:12:22 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some upstream sites put the name of the package in the body of href tags,
i.e. <a href="#43">somepackage-v1.4.10.tar.gz </a>.

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 bitbake/lib/bb/fetch2/wget.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index 20e8df1..f5bdfc7 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -256,9 +256,14 @@ class Wget(FetchMethod):
                     bb.debug(3, "Pver = '%s'" % (m.group('pver')))
                     newver = ('', m.group('pver'), '')
                 else:
-                    continue
+                    m = pn_regex.search(str(line))
+                    if m:
+                        bb.debug(3, "Pver = '%s'" % (m.group('pver')))
+                        newver = ('', m.group('pver'), '')
             else:
                 newver = self._parse_path(self.package_custom_regex_comp, line['href'])
+                if not newver:
+                    newver = self._parse_path(self.package_custom_regex_comp, str(line))
 
             if newver:
                 bb.debug(3, "Upstream version found: %s" % newver[1])
-- 
1.9.1


