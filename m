Return-Path: <anibal.limon@linux.intel.com>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by mail.openembedded.org (Postfix) with ESMTP id 41E5777BE4
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Jul 2017 21:36:49 +0000 (UTC)
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by orsmga105.jf.intel.com with ESMTP; 17 Jul 2017 14:36:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.40,375,1496127600"; d="scan'208";a="109044897"
Received: from unknown (HELO alimonb-mobl1.zpn.intel.com) ([10.219.128.142])
	by orsmga004.jf.intel.com with ESMTP; 17 Jul 2017 14:36:50 -0700
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 17 Jul 2017 16:37:23 -0500
Message-Id: <20170717213724.25808-1-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Cc: paul.eggleton@linux.intel.com
Subject: [PATCH 1/2] bb/server/process: Handle EINTR on idle_commands select
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
X-List-Received-Date: Mon, 17 Jul 2017 21:36:50 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If a signal is sent like SIGWINCH the select could be interrupted
so ignore the InterruptError like in XMLRPC server [1].

[1]
http://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/bitbake/lib/bb/server/xmlrpc.py#n307

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 lib/bb/server/process.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index f8d67678..a8ba4681 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -186,7 +186,12 @@ class ProcessServer(Process, BaseImplServer):
             nextsleep = self.next_heartbeat - now
 
         if nextsleep is not None:
-            select.select(fds,[],[],nextsleep)
+            try:
+                select.select(fds,[],[],nextsleep)
+            except InterruptedError:
+                # ignore EINTR error, nextsleep only used for wait
+                # certain time
+                pass
 
     def runCommand(self, command):
         """
-- 
2.11.0


