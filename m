Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 881E66086B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 May 2013 09:48:40 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r4N9qLwU017384 for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 May 2013 10:52:21 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id i4J2_jECi7h0 for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 May 2013 10:52:21 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r4N9qHmN017377
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 May 2013 10:52:19 +0100
Message-ID: <1369302506.14887.27.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 23 May 2013 10:48:26 +0100
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] cooker.py: Remove global scope class event handlers
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
X-List-Received-Date: Thu, 23 May 2013 09:48:41 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Its confusing when an event handler in for example a bbclass receives
events for a recipe which doesn't use the class. This is due to the
class event handlers having confusing scope. Worse, the issue is not
deterministic and the events a handler will see depends on the parse
order.

To avoid these issues, remove the class event handler global scope
and only have class handlers recieve events for recipes using the
class.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index eed489f..41f70ab 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1455,6 +1455,7 @@ class Parser(multiprocessing.Process):
         self.init = init
         multiprocessing.Process.__init__(self)
         self.context = bb.utils._context.copy()
+        self.handlers = bb.event._handlers.copy()
 
     def run(self):
         if self.init:
@@ -1490,6 +1491,7 @@ class Parser(multiprocessing.Process):
     def parse(self, filename, appends, caches_array):
         try:
             bb.utils._context = self.context.copy()
+            bb.event._handlers = self.handlers.copy()
             return True, bb.cache.Cache.parse(filename, appends, self.cfg, caches_array)
         except Exception as exc:
             tb = sys.exc_info()[2]



