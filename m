Return-Path: <anibal.limon@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id DFCD271AC3
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Jan 2017 16:20:06 +0000 (UTC)
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by fmsmga103.fm.intel.com with ESMTP; 09 Jan 2017 08:20:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,340,1477983600"; d="scan'208";a="51188391"
Received: from alimonb-mobl1.zpn.intel.com ([10.219.5.143])
	by fmsmga005.fm.intel.com with ESMTP; 09 Jan 2017 08:20:02 -0800
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Jan 2017 10:22:50 -0600
Message-Id: <1483978971-15880-1-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Subject: [PATCH 1/2] bb/server/process.py: ProcessEventQueue add close of _writer pipe
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
X-List-Received-Date: Mon, 09 Jan 2017 16:20:07 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Call explicity close in _writer to avoid fd leakage because isn't
called on Queue.close()

[YOCTO #10873]

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 lib/bb/server/process.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index c9dfb4f..c3c1450 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -233,6 +233,9 @@ class BitBakeProcessServerConnection(BitBakeBaseServerConnection):
         self.ui_channel.close()
         self.event_queue.close()
         self.event_queue.setexit()
+        # XXX: Call explicity close in _writer to avoid
+        # fd leakage because isn't called on Queue.close()
+        self.event_queue._writer.close()
 
 # Wrap Queue to provide API which isn't server implementation specific
 class ProcessEventQueue(multiprocessing.queues.Queue):
@@ -264,7 +267,6 @@ class ProcessEventQueue(multiprocessing.queues.Queue):
                 sys.exit(1)
             return None
 
-
 class BitBakeServer(BitBakeBaseServer):
     def initServer(self, single_use=True):
         # establish communication channels.  We use bidirectional pipes for
-- 
2.1.4


