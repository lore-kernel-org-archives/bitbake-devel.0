Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RkIiq-0006cm-A1 for bitbake-devel@lists.openembedded.org;
	Mon, 09 Jan 2012 18:09:25 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q09H1uqw030938
	for <bitbake-devel@lists.openembedded.org>; Mon, 9 Jan 2012 17:01:56 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 30055-06 for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Jan 2012 17:01:52 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q09H1mZ9030932
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>; Mon, 9 Jan 2012 17:01:49 GMT
Message-ID: <1326128511.9278.24.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 09 Jan 2012 17:01:51 +0000
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] bitbake: Add BBHandledException exception class
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
X-List-Received-Date: Mon, 09 Jan 2012 17:09:25 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

We have a problem knowing when to show the user debug information and
when not to since the code has already shown the user suitable information
about why a failure is occurring.

This patch adds a bb.BBHandledException exception class which can be used
to identify those exceptions which don't need further explanation to
the user.

This patch uses this class for the bb.providers exceptions and ensures the
command handling code correctly filters the exceptions meaning that

"bitbake invalid"

now shows an simple error message and not a python traceback.

[YOCTO #1141 partial]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/__init__.py b/bitbake/lib/bb/__init__.py
index 5dc959c..e410eea 100644
--- a/bitbake/lib/bb/__init__.py
+++ b/bitbake/lib/bb/__init__.py
@@ -27,6 +27,18 @@ import sys
 if sys.version_info < (2, 6, 0):
     raise RuntimeError("Sorry, python 2.6.0 or later is required for this version of bitbake")
 
+
+class BBHandledException(Exception):
+    """
+    The big dillema for generic bitbake code is what information to give the user
+    when an exception occurs. Any exception inheriting this base exception class
+    has already provided information to the user via some 'fired' message type such as
+    an explicitly fired event using bb.fire, or a bb.error message. If bitbake 
+    encounters an expception derived from this class, no backtrace or other information 
+    will be given to the user, its assumed the earlier event provided the relavent information.
+    """
+    pass
+
 import os
 import logging
 
diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index f236dac..2a3a3af 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -98,9 +98,12 @@ class Command:
             else:
                 self.finishAsyncCommand("Exited with %s" % arg)
             return False
-        except Exception:
+        except Exception as exc:
             import traceback
-            self.finishAsyncCommand(traceback.format_exc())
+            if isinstance(exc, bb.BBHandledException):
+                self.finishAsyncCommand("")
+            else:
+                self.finishAsyncCommand(traceback.format_exc())
             return False
 
     def finishAsyncCommand(self, msg=None, code=None):
diff --git a/bitbake/lib/bb/providers.py b/bitbake/lib/bb/providers.py
index 4543447..398c8ea 100644
--- a/bitbake/lib/bb/providers.py
+++ b/bitbake/lib/bb/providers.py
@@ -28,10 +28,10 @@ import bb
 
 logger = logging.getLogger("BitBake.Provider")
 
-class NoProvider(Exception):
+class NoProvider(bb.BBHandledException):
     """Exception raised when no provider of a build dependency can be found"""
 
-class NoRProvider(Exception):
+class NoRProvider(bb.BBHandledException):
     """Exception raised when no provider of a runtime dependency can be found"""
 
 




