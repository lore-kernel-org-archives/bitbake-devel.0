Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 0106E784CB
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Jul 2017 14:55:32 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v6SEtUiU005842
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Fri, 28 Jul 2017 15:55:31 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1db6fq-0005cG-U9; Fri, 28 Jul 2017 15:55:30 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 28 Jul 2017 15:55:29 +0100
Message-Id: <1501253729-21511-7-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1501253729-21511-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1501253729-21511-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Fri, 28 Jul 2017 15:55:32 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH 7/7] process: Clean up server communication timeout errors
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
X-List-Received-Date: Fri, 28 Jul 2017 14:55:33 -0000

This timeout path was commonly hit due to errors starting the server. Now we
have a better way to handle that, the retry logic can be improved and cleaned
up. This patch:

* Makes the timeout 5s rather than intervals of 1s with a message. Paul
  noted some commands can take around 1s to run on a server which has just
  been started on a loaded system.
* Allows a broke connection to exit immediately rather than retrying something
  which will never work.
* Drops the Ctrl+C masking, we shouldn't need that anymore and any issues
  would be better handled in other ways.

This should make things clearer and less confusing for users and is much cleaner
code too.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index e2db480..60ef190 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -303,19 +303,10 @@ class ServerCommunicator():
         self.recv = recv
 
     def runCommand(self, command):
-
         self.connection.send(command)
-        while True:
-            # don't let the user ctrl-c while we're waiting for a response
-            try:
-                for idx in range(0,4): # 0, 1, 2, 3
-                    if self.recv.poll(1):
-                        return self.recv.get()
-                    else:
-                        bb.note("Timeout while attempting to communicate with bitbake server, retrying...")
-                raise ProcessTimeout("Gave up; Too many tries: timeout while attempting to communicate with bitbake server")
-            except KeyboardInterrupt:
-                pass
+        if not self.recv.poll(5):
+            raise ProcessTimeout("Timeout while waiting for a reply from the bitbake server")
+        return self.recv.get()
 
     def updateFeatureSet(self, featureset):
         _, error = self.runCommand(["setFeatures", featureset])
-- 
2.7.4


