Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id A21CA6086B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 May 2013 09:49:20 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r4N9r1UZ017473 for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 May 2013 10:53:02 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id nLUJrzfbEFtz for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 May 2013 10:53:01 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r4N9qvxm017446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 May 2013 10:52:59 +0100
Message-ID: <1369302546.14887.28.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 23 May 2013 10:49:06 +0100
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] event: Drop Handled/NotHandled status return values
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 23 May 2013 09:49:21 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

These have long since been deprecated, lets remove them.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
index e41455d..11c063f 100644
--- a/bitbake/lib/bb/event.py
+++ b/bitbake/lib/bb/event.py
@@ -47,9 +47,6 @@ class Event(object):
     def __init__(self):
         self.pid = worker_pid
 
-NotHandled = 0
-Handled    = 1
-
 Registered        = 10
 AlreadyRegistered = 14
 
@@ -58,10 +55,6 @@ _handlers = bb.compat.OrderedDict()
 _ui_handlers = {}
 _ui_handler_seq = 0
 
-# For compatibility
-bb.utils._context["NotHandled"] = NotHandled
-bb.utils._context["Handled"] = Handled
-
 def execute_handler(name, handler, event, d):
     event.data = d
     try:
@@ -80,10 +73,6 @@ def execute_handler(name, handler, event, d):
     finally:
         del event.data
 
-    if ret is not None:
-        warnings.warn("Using Handled/NotHandled in event handlers is deprecated",
-                        DeprecationWarning, stacklevel = 2)
-
 def fire_class_handlers(event, d):
     if isinstance(event, logging.LogRecord):
         return



