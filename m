Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id D85CE78303
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Aug 2017 10:19:57 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v7OAJuTY003979
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Thu, 24 Aug 2017 11:19:57 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1dkpEy-00068z-I0; Thu, 24 Aug 2017 11:19:56 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 24 Aug 2017 11:19:54 +0100
Message-Id: <1503569995-23575-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Thu, 24 Aug 2017 11:19:57 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH 1/2] process: Clean up connection retry logic
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
X-List-Received-Date: Thu, 24 Aug 2017 10:19:58 -0000

Its possible for a connection to connect to the server as its shutting down
but before its removed the socket file. This patch:

a) Removes the socket file earlier to avoid connections.
b) Handles EOFError in initial connections gracefully. These occur if the
   socket is closed during the server shutdown.
c) Ensure duplicate events aren't shown on the console. This makes debugging
   these issues very very confusing.

With these changes the backtrace that was concerning users is hidden and the
server works as expected with a reconnect when it catches it in a bad state.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/main.py           | 13 ++++++++++---
 lib/bb/server/process.py |  8 ++++----
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/lib/bb/main.py b/lib/bb/main.py
index 0418d52..07972f6 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -438,9 +438,10 @@ def setup_bitbake(configParams, configuration, extrafeatures=None):
                         return None, None
                     # we start a server with a given configuration
                     logger.info("Starting bitbake server...")
-                    server = bb.server.process.BitBakeServer(lock, sockname, configuration, featureset)
-                    # The server will handle any events already in the queue
+                    # Clear the event queue since we already displayed messages
                     bb.event.ui_queue = []
+                    server = bb.server.process.BitBakeServer(lock, sockname, configuration, featureset)
+
                 else:
                     logger.info("Reconnecting to bitbake server...")
                     if not os.path.exists(sockname):
@@ -448,7 +449,13 @@ def setup_bitbake(configParams, configuration, extrafeatures=None):
                         time.sleep(5)
                         raise bb.server.process.ProcessTimeout("Bitbake still shutting down as socket exists but no lock?")
                 if not configParams.server_only:
-                    server_connection = bb.server.process.connectProcessServer(sockname, featureset)
+                    try:
+                        server_connection = bb.server.process.connectProcessServer(sockname, featureset)
+                    except EOFError:
+                        # The server may have been shutting down but not closed the socket yet. If that happened,
+                        # ignore it.
+                        pass
+
                 if server_connection or configParams.server_only:
                     break
             except (Exception, bb.server.process.ProcessTimeout) as e:
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 3ab793c..fad8aac 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -215,6 +215,10 @@ class ProcessServer(multiprocessing.Process):
             ready = self.idle_commands(.1, fds)
 
         print("Exiting")
+        # Remove the socket file so we don't get any more connections to avoid races
+        os.unlink(self.sockname)
+        self.sock.close()
+
         try: 
             self.cooker.shutdown(True)
         except:
@@ -222,10 +226,6 @@ class ProcessServer(multiprocessing.Process):
 
         self.cooker.post_serve()
 
-        # Remove the socket file so we don't get any more connections to avoid races
-        os.unlink(self.sockname)
-        self.sock.close()
-
         # Finally release the lockfile but warn about other processes holding it open
         lock = self.bitbake_lock
         lockfile = lock.name
-- 
2.7.4


