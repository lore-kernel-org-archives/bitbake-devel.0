Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1RWYQX-0003ox-BE
	for bitbake-devel@lists.openembedded.org;
	Fri, 02 Dec 2011 20:05:41 +0100
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 02 Dec 2011 10:58:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,285,1320652800"; d="scan'208";a="43374408"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.12.18])
	by AZSMGA002.ch.intel.com with ESMTP; 02 Dec 2011 10:58:56 -0800
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  2 Dec 2011 10:58:35 -0800
Message-Id: <1322852315-7036-1-git-send-email-josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.3
Subject: [PATCH] fetch2: fix Exception parameters when BB_STRICT_CHECKSUM enabled
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
X-List-Received-Date: Fri, 02 Dec 2011 19:05:41 -0000

BB_STRICT_CHECKSUM caused a backtrace as the FetchError parameters are
incorrectly specified such that FetchError is being passed 8 params
when it's expecting 3. This fixes the parameters so we're passing a
formatted string and the url.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/fetch2/__init__.py |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 19a79fd..3af56e5 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -274,9 +274,9 @@ def verify_checksum(u, ud, d):
     strict = d.getVar("BB_STRICT_CHECKSUM", True) or None
     if (strict and ud.md5_expected == None and ud.sha256_expected == None):
         raise FetchError('No checksum specified for %s, please add at least one to the recipe:\n'
-                         'SRC_URI[%s] = "%s"\nSRC_URI[%s] = "%s"', u,
-                         ud.localpath, ud.md5_name, md5data,
-                         ud.sha256_name, sha256data)
+                         'SRC_URI[%s] = "%s"\nSRC_URI[%s] = "%s"' %
+                         (ud.localpath, ud.md5_name, md5data,
+                         ud.sha256_name, sha256data), u)
 
     # Log missing sums so user can more easily add them
     if ud.md5_expected == None:
-- 
1.7.7.3



