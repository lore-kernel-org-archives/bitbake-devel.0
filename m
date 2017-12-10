Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id AD7C37016E
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 10 Dec 2017 22:35:52 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	vBAMZpgk021203
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Sun, 10 Dec 2017 22:35:52 GMT
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1eOACN-0005OV-1Y; Sun, 10 Dec 2017 22:35:51 +0000
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 10 Dec 2017 22:35:47 +0000
Message-Id: <1512945347-20697-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH] providers: Fix determinism issue
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
X-List-Received-Date: Sun, 10 Dec 2017 22:35:53 -0000

We saw builds where runtime providers were sometimes changing order and the
build result was therefore non-deterministic. For example it could show:

DEBUG: providers for lib32-initd-functions are: ['lib32-lsbinitscripts', 'lib32-initscripts']
or
DEBUG: providers for lib32-initd-functions are: ['lib32-initscripts', 'lib32-lsbinitscripts']

which could cause a test to pass or fail.

This change ensures we don't rely on the random order of dictonaries in
memory and act deterministically.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/providers.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/providers.py b/lib/bb/providers.py
index 443187e..c2aa98c 100644
--- a/lib/bb/providers.py
+++ b/lib/bb/providers.py
@@ -244,17 +244,17 @@ def _filterProviders(providers, item, cfgData, dataCache):
             pkg_pn[pn] = []
         pkg_pn[pn].append(p)
 
-    logger.debug(1, "providers for %s are: %s", item, list(pkg_pn.keys()))
+    logger.debug(1, "providers for %s are: %s", item, list(sorted(pkg_pn.keys())))
 
     # First add PREFERRED_VERSIONS
-    for pn in pkg_pn:
+    for pn in sorted(pkg_pn):
         sortpkg_pn[pn] = sortPriorities(pn, dataCache, pkg_pn)
         preferred_versions[pn] = findPreferredProvider(pn, cfgData, dataCache, sortpkg_pn[pn], item)
         if preferred_versions[pn][1]:
             eligible.append(preferred_versions[pn][1])
 
     # Now add latest versions
-    for pn in sortpkg_pn:
+    for pn in sorted(sortpkg_pn):
         if pn in preferred_versions and preferred_versions[pn][1]:
             continue
         preferred_versions[pn] = findLatestProvider(pn, cfgData, dataCache, sortpkg_pn[pn][0])
-- 
2.7.4


