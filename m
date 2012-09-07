Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1T9yuv-0007Hu-9c
	for bitbake-devel@lists.openembedded.org;
	Fri, 07 Sep 2012 15:48:17 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 07 Sep 2012 06:34:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,385,1344236400"; d="scan'208";a="190044766"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.175])
	by azsmga001.ch.intel.com with ESMTP; 07 Sep 2012 06:34:44 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  7 Sep 2012 14:34:35 +0100
Message-Id: <1347024875-9427-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH v2] fetch2: replace double slashes in paths in encodeurl()
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
X-List-Received-Date: Fri, 07 Sep 2012 13:48:17 -0000

This ensures that if all a MIRRORS entry does is add a slash, this does
not result in a circular loop.

Fixes [YOCTO #3073].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/fetch2/__init__.py |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 12ebce2..b232d3e 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -178,6 +178,9 @@ def encodeurl(decoded):
         url += "@"
     if host and type != "file":
         url += "%s" % host
+    # Standardise path to ensure comparisons work
+    while '//' in path:
+        path = path.replace("//", "/")
     url += "%s" % urllib.quote(path)
     if p:
         for parm in p:
-- 
1.7.9.5



