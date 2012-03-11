Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1S6jzX-00086w-6R for bitbake-devel@lists.openembedded.org;
	Sun, 11 Mar 2012 15:43:23 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2BEYfqv003335
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 11 Mar 2012 14:34:41 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 02411-08 for <bitbake-devel@lists.openembedded.org>;
	Sun, 11 Mar 2012 14:34:37 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2BEYXYZ003327
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 11 Mar 2012 14:34:34 GMT
Message-ID: <1331476472.15192.0.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 11 Mar 2012 14:34:32 +0000
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] cooker.py: Allow parsing shutdown to be called more than once
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
X-List-Received-Date: Sun, 11 Mar 2012 14:43:24 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The parsing shutdown call can occur more than once. Currently
if this happens the code will hang. Add some code to prevent this.

[YOCTO #2039 partial]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 451f1e9..78d8754 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1556,6 +1556,7 @@ class CookerParser(object):
         self.progress_chunk = max(self.toparse / 100, 1)
 
         self.start()
+        self.haveshutdown = False
 
     def start(self):
         self.results = self.load_cached()
@@ -1582,6 +1583,9 @@ class CookerParser(object):
     def shutdown(self, clean=True, force=False):
         if not self.toparse:
             return
+        if self.haveshutdown:
+            return
+        self.haveshutdown = True
 
         if clean:
             event = bb.event.ParseCompleted(self.cached, self.parsed,




