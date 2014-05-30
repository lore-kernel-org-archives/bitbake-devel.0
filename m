Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id A06136FC3E
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 30 May 2014 14:53:18 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s4UErEUn012029 for <bitbake-devel@lists.openembedded.org>;
	Fri, 30 May 2014 15:53:14 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id LhCQnTPO8Hqt for <bitbake-devel@lists.openembedded.org>;
	Fri, 30 May 2014 15:53:14 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s4UEr7CA012009
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 30 May 2014 15:53:09 +0100
Message-ID: <1401461579.31309.48.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 30 May 2014 15:52:59 +0100
In-Reply-To: <1401457307.31309.36.camel@ted>
References: <1401453143.31309.28.camel@ted> <1401457307.31309.36.camel@ted>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH v2] event: Fix event handlers to raise SkipPackage
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
X-List-Received-Date: Fri, 30 May 2014 14:53:22 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If an event handler triggers a SkipPackage event, we really want that
event to be received and processed by the higher code levels. Currently
it was getting caught and ignored which was leading to recipes
being present when they clearly shouldn't have been.

In general this exception catching looks to be doing the wrong thing. It
was introduced in
http://git.yoctoproject.org/cgit/cgit.cgi/poky/commit/bitbake/lib/bb/event.py?id=37cb4cc02b2e2b6c338c5943747e0a1ef15176b3
but we likely want exceptions to pass through to the higher layers.

This patch therefore removes that code.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
index e205043..04d775c 100644
--- a/bitbake/lib/bb/event.py
+++ b/bitbake/lib/bb/event.py
@@ -94,10 +94,7 @@ def fire_class_handlers(event, d):
     evt_hmap = _event_handler_map.get(eid, {})
     for name, handler in _handlers.iteritems():
         if name in _catchall_handlers or name in evt_hmap:
-            try:
-                execute_handler(name, handler, event, d)
-            except Exception:
-                continue
+            execute_handler(name, handler, event, d)
 
 ui_queue = []
 @atexit.register



