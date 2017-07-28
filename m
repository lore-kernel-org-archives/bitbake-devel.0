Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id F3574784C4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Jul 2017 14:55:32 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v6SEtUOC005839
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Fri, 28 Jul 2017 15:55:31 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1db6fq-0005c1-SS; Fri, 28 Jul 2017 15:55:30 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 28 Jul 2017 15:55:26 +0100
Message-Id: <1501253729-21511-4-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1501253729-21511-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1501253729-21511-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Fri, 28 Jul 2017 15:55:32 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH 4/7] process: Move socket keep alive into BitBakeProcessServerConnection
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

This cleans up the socket keep alive into better class structured code
and adds cleanup of the open file descriptors upon shutdown.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 3d9077f..fb96804 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -336,12 +336,16 @@ class ServerCommunicator():
         return
 
 class BitBakeProcessServerConnection(object):
-    def __init__(self, ui_channel, recv, eq):
+    def __init__(self, ui_channel, recv, eq, sock):
         self.connection = ServerCommunicator(ui_channel, recv)
         self.events = eq
+        # Save sock so it doesn't get gc'd for the life of our connection
+        self.socket_connection = sock
 
     def terminate(self):
         self.socket_connection.close()
+        self.connection.connection.close()
+        self.connection.recv.close()
         return
 
 class BitBakeServer(object):
@@ -413,12 +417,10 @@ def connectProcessServer(sockname, featureset):
 
         sendfds(sock, [writefd, readfd1, writefd2])
 
-        server_connection = BitBakeProcessServerConnection(command_chan, command_chan_recv, eq)
+        server_connection = BitBakeProcessServerConnection(command_chan, command_chan_recv, eq, sock)
 
         server_connection.connection.updateFeatureSet(featureset)
 
-        # Save sock so it doesn't get gc'd for the life of our connection
-        server_connection.socket_connection = sock
     except:
         sock.close()
         raise
-- 
2.7.4


