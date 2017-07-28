Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id EF954784B0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Jul 2017 14:55:32 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v6SEtUlp005841
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Fri, 28 Jul 2017 15:55:31 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1db6fq-0005cB-TU; Fri, 28 Jul 2017 15:55:30 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 28 Jul 2017 15:55:28 +0100
Message-Id: <1501253729-21511-6-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1501253729-21511-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1501253729-21511-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Fri, 28 Jul 2017 15:55:32 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH 6/7] process: Don't leak open pipes upon reconnection
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

If we reconnect to the server, stop leaking pipes and clean up
after ourselves.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index b9bde46..e2db480 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -420,7 +420,11 @@ def connectProcessServer(sockname, featureset):
     finally:
         os.chdir(cwd)
 
+    readfd = writefd = readfd1 = writefd1 = readfd2 = writefd2 = None
+    eq = command_chan_recv = command_chan = None
+
     try:
+
         # Send an fd for the remote to write events to
         readfd, writefd = os.pipe()
         eq = BBUIEventQueue(readfd)
@@ -435,9 +439,22 @@ def connectProcessServer(sockname, featureset):
 
         server_connection = BitBakeProcessServerConnection(command_chan, command_chan_recv, eq, sock)
 
+        # Close the ends of the pipes we won't use
+        for i in [writefd, readfd1, writefd2]:
+            os.close(i)
+
         server_connection.connection.updateFeatureSet(featureset)
 
-    except:
+    except (Exception, SystemExit) as e:
+        if command_chan_recv:
+            command_chan_recv.close()
+        if command_chan:
+            command_chan.close()
+        for i in [writefd, readfd1, writefd2]:
+            try:
+                os.close(i)
+            except OSError:
+                pass
         sock.close()
         raise
 
-- 
2.7.4


