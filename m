Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 6DF4C73C63
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jun 2015 21:52:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t5PLpiYA021725; Thu, 25 Jun 2015 22:52:31 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Fj-ZYC4DX3bu; Thu, 25 Jun 2015 22:52:31 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t5PLqHCX021734
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 25 Jun 2015 22:52:28 +0100
Message-ID: <1435269137.10583.19.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 25 Jun 2015 22:52:17 +0100
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Subject: [PATCH] event: Handle recursive events and the data store better
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
X-List-Received-Date: Thu, 25 Jun 2015 21:52:37 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Events can call each other recursively, e.g. an event handler can call
bb.note which in turn generates another event. If these loop, it
can lead to multiple deletions of 'd' from __builtins__ which
can fail since __builtins__ is global scope.

Add handling to only remove 'd' when we added it and it wasn't already
present.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
index 80e3796..6951e21 100644
--- a/bitbake/lib/bb/event.py
+++ b/bitbake/lib/bb/event.py
@@ -72,7 +72,10 @@ _eventfilter = None
 
 def execute_handler(name, handler, event, d):
     event.data = d
-    __builtins__['d'] = d
+    addedd = False
+    if 'd' not in __builtins__:
+        __builtins__['d'] = d
+        addedd = True
     try:
         ret = handler(event)
     except bb.parse.SkipRecipe:
@@ -88,7 +91,8 @@ def execute_handler(name, handler, event, d):
             logger.error("Execution of event handler '%s' failed (exit code %s)" % (name, exc.code))
     finally:
         del event.data
-        del __builtins__['d']
+        if addedd:
+            del __builtins__['d']
 
 def fire_class_handlers(event, d):
     if isinstance(event, logging.LogRecord):



