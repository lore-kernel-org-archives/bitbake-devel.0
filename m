Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1T9ydv-0006rR-0U
	for bitbake-devel@lists.openembedded.org;
	Fri, 07 Sep 2012 15:30:43 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 07 Sep 2012 06:18:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,385,1344236400"; d="scan'208";a="198913076"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.175])
	by orsmga002.jf.intel.com with ESMTP; 07 Sep 2012 06:18:15 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  7 Sep 2012 14:18:11 +0100
Message-Id: <1347023891-9237-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] fetch2: fix fetcher looping due to self-referential entries
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
X-List-Received-Date: Fri, 07 Sep 2012 13:30:43 -0000

Ensure that if all a MIRRORS entry does is add a slash, this does not
result in a circular loop.

Fixes [YOCTO #3073].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/fetch2/__init__.py |    1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 12ebce2..a90249f 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -178,6 +178,7 @@ def encodeurl(decoded):
         url += "@"
     if host and type != "file":
         url += "%s" % host
+    path = path.replace("//", "/")
     url += "%s" % urllib.quote(path)
     if p:
         for parm in p:
-- 
1.7.9.5



