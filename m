Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1Rkfny-0005Tt-3s
	for bitbake-devel@lists.openembedded.org;
	Tue, 10 Jan 2012 18:48:14 +0100
Received: by opal (Postfix, from userid 111)
	id DE1A110337; Tue, 10 Jan 2012 17:49:03 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120110174903.DE1A110337@opal>
Date: Tue, 10 Jan 2012 17:49:03 +0000 (UTC)
From: git@git.openembedded.org
Subject: Richard Purdie : bitbake: Add BBHandledException exception class
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
X-List-Received-Date: Tue, 10 Jan 2012 17:48:14 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: eac9249b40ae1e3aa21e016010c862664e59a8d4
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=eac9249b40ae1e3aa21e016010c862664e59a8d4

Author: Richard Purdie <richard.purdie@linuxfoundation.org>
Date:   Mon Jan  9 17:01:51 2012 +0000

bitbake: Add BBHandledException exception class

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

 lib/bb/__init__.py  |   12 ++++++++++++
 lib/bb/command.py   |    7 +++++--
 lib/bb/providers.py |    4 ++--
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index 5dc959c..81f83c8 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -27,6 +27,18 @@ import sys
 if sys.version_info < (2, 6, 0):
     raise RuntimeError("Sorry, python 2.6.0 or later is required for this version of bitbake")
 
+
+class BBHandledException(Exception):
+    """
+    The big dilemma for generic bitbake code is what information to give the user
+    when an exception occurs. Any exception inheriting this base exception class
+    has already provided information to the user via some 'fired' message type such as
+    an explicitly fired event using bb.fire, or a bb.error message. If bitbake 
+    encounters an exception derived from this class, no backtrace or other information 
+    will be given to the user, its assumed the earlier event provided the relevant information.
+    """
+    pass
+
 import os
 import logging
 
diff --git a/lib/bb/command.py b/lib/bb/command.py
index f236dac..2a3a3af 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
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
diff --git a/lib/bb/providers.py b/lib/bb/providers.py
index 4543447..398c8ea 100644
--- a/lib/bb/providers.py
+++ b/lib/bb/providers.py
@@ -28,10 +28,10 @@ import bb
 
 logger = logging.getLogger("BitBake.Provider")
 
-class NoProvider(Exception):
+class NoProvider(bb.BBHandledException):
     """Exception raised when no provider of a build dependency can be found"""
 
-class NoRProvider(Exception):
+class NoRProvider(bb.BBHandledException):
     """Exception raised when no provider of a runtime dependency can be found"""
 
 



