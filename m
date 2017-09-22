Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id B261D783FF
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Sep 2017 16:22:09 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v8MGM8O7023445
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Fri, 22 Sep 2017 17:22:09 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1dvQiO-0001B9-5x; Fri, 22 Sep 2017 17:22:08 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 22 Sep 2017 17:22:06 +0100
Message-Id: <1506097326-4493-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH] server/process: Increase runCommand timeout
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
X-List-Received-Date: Fri, 22 Sep 2017 16:22:10 -0000

We were seeing cases where we could hit the 5s timeout on large/fast machines
running many different tasks at once. Increase this to 30s since the main
connection timeout path should no longer hit this slow path.

[YOCTO #12116]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 29f87cd..3d31355 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -324,7 +324,7 @@ class ServerCommunicator():
 
     def runCommand(self, command):
         self.connection.send(command)
-        if not self.recv.poll(5):
+        if not self.recv.poll(30):
             raise ProcessTimeout("Timeout while waiting for a reply from the bitbake server")
         return self.recv.get()
 
-- 
2.7.4


