Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1T4Cql-00053U-BA
	for bitbake-devel@lists.openembedded.org;
	Wed, 22 Aug 2012 17:28:07 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by orsmga102.jf.intel.com with ESMTP; 22 Aug 2012 08:15:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.77,808,1336374000"; d="scan'208";a="136834138"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.122])
	by AZSMGA002.ch.intel.com with ESMTP; 22 Aug 2012 08:15:01 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 22 Aug 2012 16:14:38 +0100
Message-Id: <1345648478-2678-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] cooker: fix traceback when using -b with skipped recipe
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
X-List-Received-Date: Wed, 22 Aug 2012 15:28:07 -0000

If a recipe is skipped during parsing for whatever reason, check and
report this as an error rather than trying to use the data that is sent
back and failing.

Fixes [YOCTO #2976].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/cooker.py |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 1737e54..a6b848e 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1060,6 +1060,10 @@ class BBCooker:
             info_array = infos[fn]
         except KeyError:
             bb.fatal("%s does not exist" % fn)
+
+        if info_array[0].skipped:
+            bb.fatal("%s was skipped: %s" % (fn, info_array[0].skipreason))
+
         self.status.add_from_recipeinfo(fn, info_array)
 
         # Tweak some variables
-- 
1.7.9.5



