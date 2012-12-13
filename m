Received: from mail.cvg.de ([62.153.82.30])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <enrico.scholz@sigma-chemnitz.de>) id 1TjCeh-0007nj-3R
	for bitbake-devel@lists.openembedded.org;
	Thu, 13 Dec 2012 18:33:07 +0100
Received: from ensc-virt.intern.sigma-chemnitz.de
	(ensc-virt.intern.sigma-chemnitz.de [192.168.3.24])
	by mail.cvg.de (8.14.4/8.14.4) with ESMTP id qBDHIRMb015737
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 13 Dec 2012 18:18:29 +0100
Received: from ensc by ensc-virt.intern.sigma-chemnitz.de with local (Exim
	4.76) (envelope-from <ensc@sigma-chemnitz.de>)
	id 1TjCQV-0006UB-M9; Thu, 13 Dec 2012 18:18:27 +0100
From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 13 Dec 2012 18:18:24 +0100
Message-Id: <1355419104-24901-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
X-Mailer: git-send-email 1.7.11.7
Sender: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
X-DSPAM-Result: Innocent
X-DSPAM-Probability: 0
X-DSPAM-Confidence: 0.88
X-Spam-Score: -5.3
X-Spam-Level: -----
X-Spam-Tests: AWL,BAYES_00,RP_MATCHES_RCVD,SPF_NEUTRAL,DSPAM_INNOCENT
X-Scanned-By: MIMEDefang 2.73
Cc: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Subject: [PATCH] event: temporarily disable verbose logs
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
X-List-Received-Date: Thu, 13 Dec 2012 17:33:07 -0000

Because stderr of event handlers is directly printed to the console,
this will pollute output when using e.g. 'buildhistory' which calls a
shell function.

Patch disables 'set -x' temporarily while executing the event handler.

Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
---
 lib/bb/event.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index e41455d..7712822 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -64,7 +64,9 @@ bb.utils._context["Handled"] = Handled
 
 def execute_handler(name, handler, event, d):
     event.data = d
+    old_verbose = bb.msg.loggerVerboseLogs
     try:
+        bb.msg.loggerVerboseLogs = False
         ret = handler(event)
     except bb.parse.SkipPackage:
         raise
@@ -78,6 +80,7 @@ def execute_handler(name, handler, event, d):
             logger.error("Execution of event handler '%s' failed" % name)
         raise
     finally:
+        bb.msg.loggerVerboseLogs = old_verbose
         del event.data
 
     if ret is not None:
-- 
1.7.11.7



