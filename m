Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 84E9E6AC1E
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 19 Jun 2015 08:27:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t5J8RTPI007242; Fri, 19 Jun 2015 09:27:29 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 2Lo_6krdNXHB; Fri, 19 Jun 2015 09:27:29 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t5J8REqi007230
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 19 Jun 2015 09:27:25 +0100
Message-ID: <1434702434.14710.106.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 19 Jun 2015 09:27:14 +0100
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Cc: Chris Larson <clarson@kergoth.com>
Subject: [PATCH] event: Inject 'd' into event handlers
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
X-List-Received-Date: Fri, 19 Jun 2015 08:27:32 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

To quote Chris Larson:

"""
e.data.getVar() gets a bit old in a large event handler, and it means a
simple handler has to be modified if switching between an event handler
(e.g. RecipeParsed) and anonymous python. I think it would make sense
to restore the 'd' convention here to align with python elsewhere.
It'd just be a convenience, d==e.data, to avoid the common pattern of
setting it at the top of the event handler.
"""

I couldn't find a way to inject 'd' via locals/globals due to the use
of a function parameter so this left __builtins__ as the only way
I could find to make this work.

[YOCTO #7668]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
index f755eb2..80e3796 100644
--- a/bitbake/lib/bb/event.py
+++ b/bitbake/lib/bb/event.py
@@ -72,6 +72,7 @@ _eventfilter = None
 
 def execute_handler(name, handler, event, d):
     event.data = d
+    __builtins__['d'] = d
     try:
         ret = handler(event)
     except bb.parse.SkipRecipe:
@@ -87,6 +88,7 @@ def execute_handler(name, handler, event, d):
             logger.error("Execution of event handler '%s' failed (exit code %s)" % (name, exc.code))
     finally:
         del event.data
+        del __builtins__['d']
 
 def fire_class_handlers(event, d):
     if isinstance(event, logging.LogRecord):



