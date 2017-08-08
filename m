Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 33FF060125
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Aug 2017 09:12:14 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id v789CF4k005199
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 8 Aug 2017 02:12:15 -0700
Received: from ala-blade48.wrs.com (147.11.105.68) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.361.1;
	Tue, 8 Aug 2017 02:12:14 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 8 Aug 2017 02:12:07 -0700
Message-ID: <1e3176a9eecc8452c2a632e9ea90f4673aee90d5.1502183410.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1502183410.git.liezhi.yang@windriver.com>
References: <cover.1502183410.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [WIP][RFC PATCH 3/5] bitbake: process: fix disconnect when BB_SERVER_TIMEOUT
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
X-List-Received-Date: Tue, 08 Aug 2017 09:12:14 -0000
Content-Type: text/plain

Fixed:
$ export BB_SERVER_TIMEOUT=10000
$ bitbake --server-only
$ bitbake --status-only
[snip]
  File "/buildarea/lyang1/poky/bitbake/lib/bb/server/process.py", line 472, in recvfds
    msg, ancdata, flags, addr = sock.recvmsg(1, socket.CMSG_LEN(bytes_size))
OSError: [Errno 9] Bad file descriptor

And:
$ export BB_SERVER_TIMEOUT=10000
$ bitbake --server-only -B localhost:-1
$ bitbake --status-only # Everything is fine in first run
$ bitbake --status-only
[snip]
  File "/buildarea/lyang1/poky/bitbake/lib/bb/server/process.py", line 472, in recvfds
    msg, ancdata, flags, addr = sock.recvmsg(1, socket.CMSG_LEN(bytes_size))
OSError: [Errno 9] Bad file descriptor

This was because self.controllersock was not set to False, so it still ran
sock.recvmsg() when sock was closed.

And also need set command_channel to Flase, otherwise the
self.command_channel.get() will always run when EOF, and cause infinite loop.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/server/process.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/bitbake/lib/bb/server/process.py b/bitbake/lib/bb/server/process.py
index bfd6404b738..5b8a549f94e 100644
--- a/bitbake/lib/bb/server/process.py
+++ b/bitbake/lib/bb/server/process.py
@@ -173,6 +173,7 @@ class ProcessServer(multiprocessing.Process):
                     self.event_writer.writer.close()
                     del self.event_writer
                     self.controllersock.close()
+                    self.controllersock = False
                     self.haveui = False
                     self.lastui = time.time()
                     self.cooker.clientComplete()
@@ -188,6 +189,7 @@ class ProcessServer(multiprocessing.Process):
                     command = self.command_channel.get()
                 except EOFError:
                     # Client connection shutting down
+                    self.command_channel = False
                     continue
                 if command[0] == "terminateServer":
                     self.quit = True
-- 
2.11.0


