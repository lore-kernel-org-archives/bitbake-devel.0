Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1TA0ai-0001en-5h
	for bitbake-devel@lists.openembedded.org;
	Fri, 07 Sep 2012 17:35:32 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 07 Sep 2012 08:23:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,387,1344236400"; d="scan'208";a="142631258"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.175])
	by AZSMGA002.ch.intel.com with ESMTP; 07 Sep 2012 08:23:01 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  7 Sep 2012 16:22:54 +0100
Message-Id: <cbaf6524c2ad9909acad0acad79f363a60632b5f.1347031196.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1347031196.git.paul.eggleton@linux.intel.com>
References: <cover.1347031196.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1347031196.git.paul.eggleton@linux.intel.com>
References: <cover.1347031196.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/2] cooker: fix handling of exceptions during exception handling
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
X-List-Received-Date: Fri, 07 Sep 2012 15:35:32 -0000

If an exception occurs during handling another exception we were
getting a useless traceback such as the following, after which
BitBake froze:

ERROR: Command execution failed: Traceback (most recent call last):
  File "/home/user/poky/poky/bitbake/lib/bb/command.py", line 84, in runAsyncCommand
    self.cooker.updateCache()
  File "/home/user/poky/poky/bitbake/lib/bb/cooker.py", line 1207, in updateCache
    if not self.parser.parse_next():
  File "/home/user/poky/poky/bitbake/lib/bb/cooker.py", line 1694, in parse_next
    logger.error('Unable to parse %s', value.recipe,
AttributeError: 'exceptions.TypeError' object has no attribute 'recipe'

Fix this to print an actual traceback of the exception and exit
gracefully (well, as gracefully as possible under the circumstances).

The general fix for [YOCTO #2977].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/cooker.py |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 1b3bb84..19173ae 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1691,8 +1691,13 @@ class CookerParser(object):
         except Exception as exc:
             self.error += 1
             etype, value, tb = sys.exc_info()
-            logger.error('Unable to parse %s', value.recipe,
-                         exc_info=(etype, value, exc.traceback))
+            if hasattr(value, "recipe"):
+                logger.error('Unable to parse %s', value.recipe,
+                            exc_info=(etype, value, exc.traceback))
+            else:
+                # Most likely, an exception occurred during raising an exception
+                import traceback
+                logger.error('Exception during parse: %s' % traceback.format_exc())
             self.shutdown(clean=False)
             return False
 
-- 
1.7.9.5



