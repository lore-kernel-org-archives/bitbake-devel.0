Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Tb6if-0005Ig-27 for bitbake-devel@lists.openembedded.org;
	Wed, 21 Nov 2012 10:35:45 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qAL9Levj013575
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Nov 2012 09:21:40 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 12315-06 for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Nov 2012 09:21:36 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qAL9LVVY013569
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Nov 2012 09:21:33 GMT
Message-ID: <1353489690.10459.0.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 21 Nov 2012 09:21:30 +0000
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] server/process.py: Change timeout error handling
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
X-List-Received-Date: Wed, 21 Nov 2012 09:35:45 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

In normal usage, we never hit the timeout issue. If we do, it becomes obvious
that the current error handling is not good enough. The request may have made it
to the server and the answer will get queued. This means the next command may get
the return value from the previous command with suitably puzzling results.

Without rewriting large sections of code, its not possible to avoid this problem.
It is better to increase the timeout to several seconds giving the server a chance
to respond and if it does timeout, hard exit since recovery is not possible with the
code base today.

I'd be happy to see the structure of this code improved but this quick fix at least
stops corrupted builds from happening which has to be a good thing.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/server/process.py b/bitbake/lib/bb/server/process.py
index f1e8450..8ebf771 100644
--- a/bitbake/lib/bb/server/process.py
+++ b/bitbake/lib/bb/server/process.py
@@ -45,10 +45,10 @@ class ServerCommunicator():
         while True:
             # don't let the user ctrl-c while we're waiting for a response
             try:
-                if self.connection.poll(.5):
+                if self.connection.poll(20):
                     return self.connection.recv()
                 else:
-                    return None, "Timeout while attempting to communicate with bitbake server"
+                    bb.fatal("Timeout while attempting to communicate with bitbake server")
             except KeyboardInterrupt:
                 pass
 




