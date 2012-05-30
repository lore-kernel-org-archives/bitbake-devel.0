Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1SZlkM-00054z-UT
	for bitbake-devel@lists.openembedded.org;
	Wed, 30 May 2012 18:27:43 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 30 May 2012 09:17:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="105914735"
Received: from unknown (HELO helios.amr.corp.intel.com) ([10.255.12.128])
	by AZSMGA002.ch.intel.com with ESMTP; 30 May 2012 09:17:22 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 30 May 2012 17:17:15 +0100
Message-Id: <655fd33cfb85ab8da287081f457ecf9ebcc226be.1338394341.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1338394341.git.paul.eggleton@linux.intel.com>
References: <cover.1338394341.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1338394341.git.paul.eggleton@linux.intel.com>
References: <cover.1338394341.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/5] cooker: fix UnboundLocalError when exception occurs during parsing
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
X-List-Received-Date: Wed, 30 May 2012 16:27:43 -0000

Fix a recent regression where we see the following additional error
after an error occurs during parsing:

ERROR: Command execution failed: Traceback (most recent call last):
  File "/home/paul/poky/poky/bitbake/lib/bb/command.py", line 84, in runAsyncCommand
    self.cooker.updateCache()
  File "/home/paul/poky/poky/bitbake/lib/bb/cooker.py", line 1202, in updateCache
    if not self.parser.parse_next():
  File "/home/paul/poky/poky/bitbake/lib/bb/cooker.py", line 1672, in parse_next
    self.virtuals += len(result)
UnboundLocalError: local variable 'result' referenced before assignment

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/cooker.py |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index d1de757..b30945c 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1646,6 +1646,8 @@ class CookerParser(object):
                     yield result
 
     def parse_next(self):
+        result = []
+        parsed = None
         try:
             parsed, result = self.results.next()
         except StopIteration:
-- 
1.7.9.5



