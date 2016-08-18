Return-Path: <markus.lehtonen@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 9D13276FF2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Aug 2016 16:56:00 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga103.jf.intel.com with ESMTP; 18 Aug 2016 09:56:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,540,1464678000"; d="scan'208";a="1016782747"
Received: from marquiz.fi.intel.com ([10.237.72.155])
	by orsmga001.jf.intel.com with ESMTP; 18 Aug 2016 09:55:59 -0700
From: Markus Lehtonen <markus.lehtonen@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 18 Aug 2016 19:55:54 +0300
Message-Id: <1471539354-32382-5-git-send-email-markus.lehtonen@linux.intel.com>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1471539354-32382-1-git-send-email-markus.lehtonen@linux.intel.com>
References: <1471539354-32382-1-git-send-email-markus.lehtonen@linux.intel.com>
Subject: [PATCH 4/4] bitbake-selftest: enable bitbake logging to stdout
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
X-List-Received-Date: Thu, 18 Aug 2016 16:56:00 -0000

Now you get the bb logger output for failed tests. This helps debugging
problems. Also, all stdout/stderr data for successful tests is silenced
which makes for less cluttered console output.

Signed-off-by: Markus Lehtonen <markus.lehtonen@linux.intel.com>
---
 bin/bitbake-selftest | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-selftest b/bin/bitbake-selftest
index 1e00e33..380e003 100755
--- a/bin/bitbake-selftest
+++ b/bin/bitbake-selftest
@@ -37,6 +37,24 @@ for t in tests:
     __import__(t)
 
 
+# Set-up logging
+class StdoutStreamHandler(logging.StreamHandler):
+    """Special handler so that unittest is able to capture stdout"""
+    def __init__(self):
+        # Override __init__() because we don't want to set self.stream here
+        logging.Handler.__init__(self)
+
+    @property
+    def stream(self):
+        # We want to dynamically write wherever sys.stdout is pointing to
+        return sys.stdout
+
+
+handler = StdoutStreamHandler()
+bb.logger.addHandler(handler)
+bb.logger.setLevel(logging.DEBUG)
+
+
 ENV_HELP = """\
 Environment variables:
   BB_SKIP_NETTESTS      set to 'yes' in order to skip tests using network
@@ -51,4 +69,4 @@ class main(unittest.main):
 
 
 if __name__ == '__main__':
-        main(defaultTest=tests)
+        main(defaultTest=tests, buffer=True)
-- 
2.6.6


