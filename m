Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
	[209.85.221.45])
	by mail.openembedded.org (Postfix) with ESMTP id B33E779EFC
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  6 Nov 2018 14:41:55 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id z16-v6so13810861wrv.2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 06 Nov 2018 06:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id;
	bh=9tIiV3h6zr14tsev2UOwyFgd114u+MsNJi9z8X6rWL0=;
	b=WiZS7IrgypMUl4LAGQUUyVAVR8dhUtkpK/nZL6yaA2OB3+tZKvDnM16hPjvwSJIMpz
	Z3busBBoE1s9+RevZ4tWntjQyTo7CP2LKDhvUYQXN50JHedA1srAXVQSO7UytHbwpR2/
	TQuwsy/rjq3E18vHEdZ6xQWwAJ9MtvKlW7KE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=9tIiV3h6zr14tsev2UOwyFgd114u+MsNJi9z8X6rWL0=;
	b=TCVSzfq8NhNnhHJV/I1p4S7fwoQ49+0d6geTNU+O4LYZabUiQeA6T4IObf6ctA2K+j
	L4uoOAnXmElf0SL6igKzwsPat40v62d78AJ1QBQtO9VntLvoDTlHEpk2hy/MCulkrYkl
	mtgADTQ9wFOy9VCVbOVV/b3mVCCr2l7b7B9GwOGWhvZ0VHDhB2Q7hicwb6EKfSdu/+Vk
	EcnUc9IRyx/Zkcd7IJO2eOqQQlmfCHG6JEyCso8ynSRcIvL9DxYXQ8nWwyUaelDPJkyj
	NQqHqFHFNbdwuvXIPK6GQSpHgtdcpv0eLsRojiE5+cDmCIAEE1Msky4EYwcXuKl9Se5M
	+qEg==
X-Gm-Message-State: AGRZ1gJ9zYarLx423C8qhbfrB82jS7mkSZiq24WN1Hia8HoMavNNg+wL
	L7mf8d0kAT0x3uKfeIRt+Tkf/9uAgPc=
X-Google-Smtp-Source: AJdET5fLom2HWWrRhNSXG5yCCglMgOUo/xDp7PUH+N0uJk1vgXMspLpjIpDO5uj2pHb+gQ0y40WuDQ==
X-Received: by 2002:adf:d090:: with SMTP id
	y16-v6mr14270317wrh.314.1541515315665; 
	Tue, 06 Nov 2018 06:41:55 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	x18-v6sm2235970wme.42.2018.11.06.06.41.54
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 06 Nov 2018 06:41:55 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  6 Nov 2018 14:41:53 +0000
Message-Id: <20181106144153.20480-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
Subject: [PATCH] server/process: Fix unclosed socket warnings upon server connection refused
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
X-List-Received-Date: Tue, 06 Nov 2018 14:41:56 -0000

Extend the server error handling to avoid:

Reconnecting to bitbake server...
NOTE: Retrying server connection... (Traceback (most recent call last):
  File "/home/pokybuild/yocto-worker/nightly-oe-selftest/build/bitbake/lib/bb/main.py", line 464, in setup_bitbake
    server_connection = bb.server.process.connectProcessServer(sockname, featureset)
  File "/home/pokybuild/yocto-worker/nightly-oe-selftest/build/bitbake/lib/bb/server/process.py", line 457, in connectProcessServer
    sock.connect(os.path.basename(sockname))
ConnectionRefusedError: [Errno 111] Connection refused
)
WARNING: /home/pokybuild/yocto-worker/nightly-oe-selftest/build/bitbake/lib/bb/main.py:481: ResourceWarning: unclosed <socket.socket fd=20, family=AddressFamily.AF_UNIX, type=SocketKind.SOCK_STREAM, proto=0>
  logger.info("Retrying server connection... (%s)" % traceback.format_exc())

NOTE: Starting bitbake server...

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 38b923fe2d..ed930c61f4 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -453,15 +453,14 @@ def connectProcessServer(sockname, featureset):
     cwd = os.getcwd()
 
     try:
-        os.chdir(os.path.dirname(sockname))
-        sock.connect(os.path.basename(sockname))
-    finally:
-        os.chdir(cwd)
-
-    readfd = writefd = readfd1 = writefd1 = readfd2 = writefd2 = None
-    eq = command_chan_recv = command_chan = None
+        try:
+            os.chdir(os.path.dirname(sockname))
+            sock.connect(os.path.basename(sockname))
+        finally:
+            os.chdir(cwd)
 
-    try:
+        readfd = writefd = readfd1 = writefd1 = readfd2 = writefd2 = None
+        eq = command_chan_recv = command_chan = None
 
         # Send an fd for the remote to write events to
         readfd, writefd = os.pipe()
-- 
2.17.1


