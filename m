Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 7C92177D0C
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Aug 2017 09:56:21 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v799uLt7003529
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Wed, 9 Aug 2017 10:56:22 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1dfNiv-00049X-B2; Wed, 09 Aug 2017 10:56:21 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Aug 2017 10:56:17 +0100
Message-Id: <1502272577-15918-2-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1502272577-15918-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1502272577-15918-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Wed, 09 Aug 2017 10:56:22 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH 2/2] server/process: Ensure we don't loop on client EOFError
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
X-List-Received-Date: Wed, 09 Aug 2017 09:56:23 -0000

The server currently crashes if we hit an EOFError due to controllersock
still being in ready and the continue meaning ready isn't re-evaluated.
Setting the value to False can mean the shutdown code doesn't handle the
situation cleanly.

Clear ready to avoid the crash/loop instead and handle any OSError whilst
we're in here.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 338c448..ee8b14e 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -164,7 +164,7 @@ class ProcessServer(multiprocessing.Process):
 
                     self.haveui = True
 
-                except EOFError:
+                except (EOFError, OSError):
                     print("Disconnecting Client")
                     fds.remove(self.controllersock)
                     fds.remove(self.command_channel)
@@ -190,7 +190,7 @@ class ProcessServer(multiprocessing.Process):
                     command = self.command_channel.get()
                 except EOFError:
                     # Client connection shutting down
-                    self.command_channel = False
+                    ready = []
                     continue
                 if command[0] == "terminateServer":
                     self.quit = True
-- 
2.7.4


