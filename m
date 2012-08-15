Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1T1gBH-0002dQ-M4 for bitbake-devel@lists.openembedded.org;
	Wed, 15 Aug 2012 18:10:52 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7FFwsZc002917
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Aug 2012 16:58:54 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 02230-05 for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Aug 2012 16:58:49 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7FFwlul002909
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Aug 2012 16:58:48 +0100
Message-ID: <1345046326.14667.8.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 15 Aug 2012 16:58:46 +0100
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] knotty: Chain the WINCH signal handler in progressbar so any other handler is preserved and called
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
X-List-Received-Date: Wed, 15 Aug 2012 16:10:52 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 9f51823..34b5969 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -25,6 +25,7 @@ import sys
 import xmlrpclib
 import logging
 import progressbar
+import signal
 import bb.msg
 from bb.ui import uihelper
 
@@ -37,8 +38,21 @@ class BBProgress(progressbar.ProgressBar):
         widgets = [progressbar.Percentage(), ' ', progressbar.Bar(), ' ',
            progressbar.ETA()]
 
+        try:
+            self._resize_default = signal.getsignal(signal.SIGWINCH)
+        except:
+            self._resize_default = None
         progressbar.ProgressBar.__init__(self, maxval, [self.msg + ": "] + widgets)
 
+    def _handle_resize(self, signum, frame):
+        progressbar.ProgressBar._handle_resize(self, signum, frame)
+        if self._resize_default:
+            self._resize_default(signum, frame)
+    def finish(self):
+        progressbar.ProgressBar.finish(self)
+        if self._resize_default:
+            signal.signal(signal.SIGWINCH, self._resize_default)
+
 class NonInteractiveProgress(object):
     fobj = sys.stdout
 




