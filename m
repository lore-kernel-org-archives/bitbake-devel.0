Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 8E20473A6D
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Mar 2015 14:28:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t2AES1ab015149 for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Mar 2015 14:28:01 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id xX6dE4UECVJY for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Mar 2015 14:28:01 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t2AERmcO015140
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Mar 2015 14:28:00 GMT
Message-ID: <1425997668.9114.24.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 10 Mar 2015 14:27:48 +0000
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Subject: [PATCH] event: Improve exception handling
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
X-List-Received-Date: Tue, 10 Mar 2015 14:28:01 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Currently, if an exception occurs during an event handler execution, 
things can get messy and in many cases the system will loop
indefinitely, particularly if its being triggered through idle handler
code.

This patch changes things so that unhandled exceptions print an error
onto the console/logs, then continue, rather than raising an exception
into "higher" level code which simply can't handle it.

In particular this is more in keeping with the meaning of "Handled"
exceptions. Real world error cases triggering these code paths were much
more stable after these changes than before (which just looped
infinitely printing exceptions).

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
index fec6a05..62a8f4f 100644
--- a/bitbake/lib/bb/event.py
+++ b/bitbake/lib/bb/event.py
@@ -74,17 +74,17 @@ def execute_handler(name, handler, event, d):
     event.data = d
     try:
         ret = handler(event)
-    except (bb.parse.SkipRecipe, bb.BBHandledException):
+    except bb.parse.SkipRecipe:
         raise
+    except bb.BBHandledException:
+        pass
     except Exception:
         etype, value, tb = sys.exc_info()
         logger.error("Execution of event handler '%s' failed" % name,
                         exc_info=(etype, value, tb.tb_next))
-        raise
     except SystemExit as exc:
         if exc.code != 0:
-            logger.error("Execution of event handler '%s' failed" % name)
-        raise
+            logger.error("Execution of event handler '%s' failed (exit code %s)" % (name, exc.code))
     finally:
         del event.data
 



