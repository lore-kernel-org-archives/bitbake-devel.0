Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 9EB207F473
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Aug 2019 09:25:58 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x779PMPD010335
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 7 Aug 2019 02:25:49 -0700
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.468.0; Wed, 7 Aug 2019 02:25:44 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 7 Aug 2019 17:50:49 +0800
Message-ID: <f5ad4c15290790c4d8e1a3f278235c546cdd3f9a.1565171270.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1565171270.git.liezhi.yang@windriver.com>
References: <cover.1565171270.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 2/2] knotty: Fix for the Second Keyboard Interrupt
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
X-List-Received-Date: Wed, 07 Aug 2019 09:25:58 -0000
Content-Type: text/plain

Fixed:
$ rm -fr tmp-glibc/cache/default-glibc/qemux86/x86_64/bb_cache.dat* ; bitbake -p
Press the first Ctrl-C when the parsing process is at about 50%:

Keyboard Interrupt, closing down...

Then presss the second Ctrl-C:

  File "/path/to/bitbake/bitbake/lib/bb/ui/knotty.py", line 619, in main
    event = eventHandler.waitEvent(0.25)
  File "/path/to/bitbake/lib/bb/server/process.py", line 591, in waitEvent
    self.eventQueueNotify.wait(delay)
  File "/usr/lib/python3.5/threading.py", line 549, in wait
    signaled = self._cond.wait(timeout)
  File "/usr/lib/python3.5/threading.py", line 297, in wait
    gotit = waiter.acquire(True, timeout)
KeyboardInterrupt

Capture the second KeyboardInterrupt during stateShutdown is running can fix
the problem. There may be still tracebacks for the third KeyboardInterrupt, but
I'm leaning to not fix it since we aimed for supporting 2 KeyboardInterrupts
only.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/ui/knotty.py | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 1c72aa2..35736ad 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -689,17 +689,27 @@ def main(server, eventHandler, params, tf = TerminalFilter):
             if params.observe_only:
                 print("\nKeyboard Interrupt, exiting observer...")
                 main.shutdown = 2
-            if not params.observe_only and main.shutdown == 1:
+
+            def state_force_shutdown():
                 print("\nSecond Keyboard Interrupt, stopping...\n")
                 _, error = server.runCommand(["stateForceShutdown"])
                 if error:
                     logger.error("Unable to cleanly stop: %s" % error)
+
+            if not params.observe_only and main.shutdown == 1:
+                state_force_shutdown()
+
             if not params.observe_only and main.shutdown == 0:
                 print("\nKeyboard Interrupt, closing down...\n")
                 interrupted = True
-                _, error = server.runCommand(["stateShutdown"])
-                if error:
-                    logger.error("Unable to cleanly shutdown: %s" % error)
+                # Capture the second KeyboardInterrupt during stateShutdown is running
+                try:
+                    _, error = server.runCommand(["stateShutdown"])
+                    if error:
+                        logger.error("Unable to cleanly shutdown: %s" % error)
+                except KeyboardInterrupt:
+                    state_force_shutdown()
+
             main.shutdown = main.shutdown + 1
             pass
         except Exception as e:
-- 
2.7.4


