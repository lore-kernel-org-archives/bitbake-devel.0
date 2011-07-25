Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1QlLgb-0001bS-7h
	for bitbake-devel@lists.openembedded.org;
	Mon, 25 Jul 2011 15:59:09 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 25 Jul 2011 06:54:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,261,1309762800"; d="scan'208";a="34207822"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.255.17.240])
	by fmsmga001.fm.intel.com with ESMTP; 25 Jul 2011 06:54:54 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 25 Jul 2011 14:54:43 +0100
Message-Id: <fca91f25b09d34d5c5d2ac6d848e2d5ce8bbd09e.1311601628.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1311601628.git.paul.eggleton@linux.intel.com>
References: <cover.1311601628.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1311601628.git.paul.eggleton@linux.intel.com>
References: <cover.1311601628.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 3/3] bitbake/providers: list PREFERRED_VERSION candidates when unavailable
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 25 Jul 2011 13:59:09 -0000

If the specified PREFERRED_VERSION is not available then list the
available versions in the output. (PR is omitted.)

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/providers.py |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/bitbake/lib/bb/providers.py b/bitbake/lib/bb/providers.py
index edd54d0..22104f1 100644
--- a/bitbake/lib/bb/providers.py
+++ b/bitbake/lib/bb/providers.py
@@ -124,6 +124,18 @@ def findPreferredProvider(pn, cfgData, dataCache, pkg_pn = None, item = None):
             itemstr = " (for item %s)" % item
         if preferred_file is None:
             logger.info("preferred version %s of %s not available%s", pv_str, pn, itemstr)
+            available_vers = []
+            for file_set in pkg_pn:
+                for f in file_set:
+                    pe, pv, pr = dataCache.pkg_pepvpr[f]
+                    ver_str = pv
+                    if pe:
+                        ver_str = "%s:%s" % (pe, ver_str)
+                    if not ver_str in available_vers:
+                        available_vers.append(ver_str)
+            if available_vers:
+                available_vers.sort()
+                logger.info("versions of %s available: %s", pn, ' '.join(available_vers))
         else:
             logger.debug(1, "selecting %s as PREFERRED_VERSION %s of package %s%s", preferred_file, pv_str, pn, itemstr)
 
-- 
1.7.4.1



