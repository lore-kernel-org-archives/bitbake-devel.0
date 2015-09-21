Return-Path: <markus.lehtonen@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 5AE9260053
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Sep 2015 13:07:58 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 21 Sep 2015 06:07:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,567,1437462000"; d="scan'208";a="794152676"
Received: from marquiz.fi.intel.com ([10.237.72.155])
	by fmsmga001.fm.intel.com with ESMTP; 21 Sep 2015 06:07:58 -0700
From: Markus Lehtonen <markus.lehtonen@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 21 Sep 2015 16:07:57 +0300
Message-Id: <1442840877-32475-1-git-send-email-markus.lehtonen@linux.intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH] tinfoil: remove logging handler at shutdown
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
X-List-Received-Date: Mon, 21 Sep 2015 13:07:59 -0000

Otherwise the logger gets multiple handers (and the user get duplicate
logging output) if another tinfoil instance is initialized after one is
shut down().

Signed-off-by: Markus Lehtonen <markus.lehtonen@linux.intel.com>
---
 lib/bb/tinfoil.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index 1ea46d8..7aa653f 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -36,13 +36,13 @@ class Tinfoil:
 
         # Set up logging
         self.logger = logging.getLogger('BitBake')
-        console = logging.StreamHandler(output)
-        bb.msg.addDefaultlogFilter(console)
+        self._log_hdlr = logging.StreamHandler(output)
+        bb.msg.addDefaultlogFilter(self._log_hdlr)
         format = bb.msg.BBLogFormatter("%(levelname)s: %(message)s")
         if output.isatty():
             format.enable_color()
-        console.setFormatter(format)
-        self.logger.addHandler(console)
+        self._log_hdlr.setFormatter(format)
+        self.logger.addHandler(self._log_hdlr)
 
         self.config = CookerConfiguration()
         configparams = TinfoilConfigParameters(parse_only=True)
@@ -88,6 +88,7 @@ class Tinfoil:
         self.cooker.shutdown(force=True)
         self.cooker.post_serve()
         self.cooker.unlockBitbake()
+        self.logger.removeHandler(self._log_hdlr)
 
 class TinfoilConfigParameters(ConfigParameters):
 
-- 
2.1.4


