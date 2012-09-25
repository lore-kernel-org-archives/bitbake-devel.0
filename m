Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1TGXDM-0005wZ-Dy
	for bitbake-devel@lists.openembedded.org;
	Tue, 25 Sep 2012 17:38:24 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 25 Sep 2012 08:25:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,484,1344236400"; d="scan'208";a="212755202"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.7])
	by orsmga002.jf.intel.com with ESMTP; 25 Sep 2012 08:25:32 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 25 Sep 2012 16:25:28 +0100
Message-Id: <1348586728-3148-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] cooker: adjust layer dependency error messages
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
X-List-Received-Date: Tue, 25 Sep 2012 15:38:26 -0000

Make these a little easier to understand.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/cooker.py |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index b281cd0..7ca1ffd 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -939,13 +939,13 @@ class BBCooker:
                                         errors = True
                                         continue
                                     if lver <> depver:
-                                        parselog.error("Layer dependency %s of layer %s is at version %d, expected %d", dep, c, lver, depver)
+                                        parselog.error("Layer '%s' depends on version %d of layer '%s', but version %d is enabled in your configuration", c, depver, dep, lver)
                                         errors = True
                                 else:
-                                    parselog.error("Layer dependency %s of layer %s has no version, expected %d", dep, c, depver)
+                                    parselog.error("Layer '%s' depends on version %d of layer '%s', which exists in your configuration but does not specify a version", c, depver, dep)
                                     errors = True
                         else:
-                            parselog.error("Layer dependency %s of layer %s not found", dep, c)
+                            parselog.error("Layer '%s' depends on layer '%s', but this layer is not enabled in your configuration", c, dep)
                             errors = True
                     collection_depends[c] = depnamelist
                 else:
-- 
1.7.9.5



