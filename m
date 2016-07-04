Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 7698F601D4
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  4 Jul 2016 22:04:01 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 04 Jul 2016 15:04:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,576,1459839600"; d="scan'208";a="989103684"
Received: from linux.intel.com ([10.54.29.200])
	by orsmga001.jf.intel.com with ESMTP; 04 Jul 2016 15:04:02 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.68])
	by linux.intel.com (Postfix) with ESMTP id E472A6A4080;
	Mon,  4 Jul 2016 15:03:56 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  5 Jul 2016 00:53:59 +0300
Message-Id: <1467669239-16680-1-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH] bitbake-worker: don't reassign sys.stdout
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
X-List-Received-Date: Mon, 04 Jul 2016 22:04:02 -0000

Worker needs input stream in binary mode as it reads binary content
from it. Current code does it by detaching a buffer from sys.stdin
and assigning it back to sys.stdin.

Detached buffer is io.BufferedReader in binary mode. This operation
is implicit as its purpose is not easily understandable from the code.
Replacing it with fdopen(sys.stdin.fileno(), 'rb') should make the
code more understandable.

Assigning the buffer to sys.stdin is not needed as worker doesn't
use sys.stdin. Moreover, it leads to difficult to debug issues down
the stack. For example, devpyshell doesn't work without reopening
sys.stdin in text mode. This is not needed anymore after this fix as
sys.stdin is not changed in worker code and remains in text mode.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/bin/bitbake-worker | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
index 5d062a2..963b4cd 100755
--- a/bitbake/bin/bitbake-worker
+++ b/bitbake/bin/bitbake-worker
@@ -436,8 +436,7 @@ class BitbakeWorker(object):
             self.build_pipes[pipe].read()
 
 try:
-    sys.stdin = sys.stdin.detach()
-    worker = BitbakeWorker(sys.stdin)
+    worker = BitbakeWorker(os.fdopen(sys.stdin.fileno(), 'rb'))
     if not profiling:
         worker.serve()
     else:
-- 
2.1.4


