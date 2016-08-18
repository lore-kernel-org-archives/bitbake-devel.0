Return-Path: <markus.lehtonen@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 4666776E70
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Aug 2016 16:55:58 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga103.jf.intel.com with ESMTP; 18 Aug 2016 09:55:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,540,1464678000"; d="scan'208";a="1016782704"
Received: from marquiz.fi.intel.com ([10.237.72.155])
	by orsmga001.jf.intel.com with ESMTP; 18 Aug 2016 09:55:57 -0700
From: Markus Lehtonen <markus.lehtonen@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 18 Aug 2016 19:55:52 +0300
Message-Id: <1471539354-32382-3-git-send-email-markus.lehtonen@linux.intel.com>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1471539354-32382-1-git-send-email-markus.lehtonen@linux.intel.com>
References: <1471539354-32382-1-git-send-email-markus.lehtonen@linux.intel.com>
Subject: [PATCH 2/4] bitbake-selftest: add help text for env variable(s)
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
X-List-Received-Date: Thu, 18 Aug 2016 16:55:59 -0000

Signed-off-by: Markus Lehtonen <markus.lehtonen@linux.intel.com>
---
 bin/bitbake-selftest | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-selftest b/bin/bitbake-selftest
index 1e615cc..25905d7 100755
--- a/bin/bitbake-selftest
+++ b/bin/bitbake-selftest
@@ -37,5 +37,17 @@ for t in tests:
     __import__(t)
 
 
+ENV_HELP = """\
+Environment variables:
+  BB_SKIP_NETTESTS      set to 'yes' in order to skip tests using network
+                        connection
+"""
+
+class main(unittest.main):
+    def _print_help(self, *args, **kwargs):
+        super(main, self)._print_help(*args, **kwargs)
+        print(ENV_HELP)
+
+
 if __name__ == '__main__':
-        unittest.main(defaultTest=tests)
+        main(defaultTest=tests)
-- 
2.6.6


