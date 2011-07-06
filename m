Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QeWb9-0008UO-M9 for bitbake-devel@lists.openembedded.org;
	Wed, 06 Jul 2011 20:13:23 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p66I9FnG017887
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 6 Jul 2011 19:09:15 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 17594-05 for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Jul 2011 19:09:11 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p66I96L8017881
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 6 Jul 2011 19:09:06 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 06 Jul 2011 19:08:33 +0100
Message-ID: <1309975713.20015.797.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] bitbake/process.py: Ensure queued UI events are queued right before we add our own handler
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
X-List-Received-Date: Wed, 06 Jul 2011 18:13:23 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit


Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/server/process.py
b/bitbake/lib/bb/server/process.py
index 3a0706c..ba91336 100644
--- a/bitbake/lib/bb/server/process.py
+++ b/bitbake/lib/bb/server/process.py
@@ -83,15 +83,14 @@ class ProcessServer(Process):
         self.keep_running = Event()
         self.keep_running.set()
 
-        for event in bb.event.ui_queue:
-            self.event_queue.put(event)
-
     def register_idle_function(self, function, data):
         """Register a function to be called while the server is idle"""
         assert hasattr(function, '__call__')
         self._idlefunctions[function] = data
 
     def run(self):
+        for event in bb.event.ui_queue:
+            self.event_queue.put(event)
         self.event_handle = bb.event.register_UIHhandler(self)
         bb.cooker.server_main(self.cooker, self.main)
 



