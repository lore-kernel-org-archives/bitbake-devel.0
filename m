Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by mail.openembedded.org (Postfix) with ESMTP id 9CA516C344
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Nov 2018 13:57:43 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id u5-v6so8141021wrn.9
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Nov 2018 05:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id;
	bh=DSB4yGq3AA+sG7gsULE3xvswLWa4Yj9J3qbRJZbgfAs=;
	b=KPQi+JFKILdBA1sPzhHc52V5EGSSjWZYmhQkbN/TdPi2NW9xpQm8rlAhBKg1aHJPC3
	gLAeUg1/jgCK8c7cNDhysfGt7F7Z1gnLl78cKurtYYYk1NWy8yxPkoWiiV8jBC+4ktNC
	zZ1eupuKS2Fu4z395vyHjMy2qsrzKs2N/qV78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=DSB4yGq3AA+sG7gsULE3xvswLWa4Yj9J3qbRJZbgfAs=;
	b=Yg7zmkMYtUqPKy2/cYrXcAbF0Rd0+zmb4WdjBpU5XyNLEJv3ZpBh32L9vc23zdHPvr
	PEaPswBv77x7cg0THGRno2ghM9CcZZmq89WOTsmmM1ZbBu6WqdguZMR8PLjKqS542kmG
	4ISztt+m08lBy1e0K9oA8PKzeNlQDwYOenl7CX2MsDSJtVSDYQ01OAR9Dvej3g81lUXu
	KsZiQBu1PFejx/abZp8etsB24XjhSajpNUs59BrjSMzYPDlmThObPcQhcvYpg7JUo3Gq
	e+RQnmr/tuC/HbbroDWgtz55WogUNSIQ3ZdIG29VB8tk13Jl1uPwX7DS+ksDsSYKmpKh
	GmaA==
X-Gm-Message-State: AGRZ1gKU4VVsCkBLKe0EN1Cu71yaEi6mViIt5qt2cp5EQDjpsdPxlVJ1
	1OfTKdpXYw4L5/an19q1HgnO+VVqg5k=
X-Google-Smtp-Source: AJdET5e+P4b33iSGPDM6oyvu60S0YFOlXJZ/tnu/LIdYUNS5Wo63VnM5lcyLptHEyJ0wO6v2lzxiYw==
X-Received: by 2002:a05:6000:1cb:: with SMTP id
	t11mr5413862wrx.146.1542117463710; 
	Tue, 13 Nov 2018 05:57:43 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	e66-v6sm28886097wmf.40.2018.11.13.05.57.42
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 13 Nov 2018 05:57:43 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 13 Nov 2018 13:57:39 +0000
Message-Id: <20181113135739.32196-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
Subject: [PATCH] lib/bb/server: Avoid UnboundLocalError traceback
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
X-List-Received-Date: Tue, 13 Nov 2018 13:57:43 -0000

Traceback (most recent call last):
  File "/home/pokybuild/yocto-worker/nightly-oe-selftest/build/bitbake/lib/bb/main.py", line 464, in setup_bitbake
    server_connection = bb.server.process.connectProcessServer(sockname, featureset)
  File "/home/pokybuild/yocto-worker/nightly-oe-selftest/build/bitbake/lib/bb/server/process.py", line 490, in connectProcessServer
    if command_chan_recv:
UnboundLocalError: local variable 'command_chan_recv' referenced before assignment

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index ed930c61f4..0cae41cf86 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -452,6 +452,9 @@ def connectProcessServer(sockname, featureset):
     # AF_UNIX has path length issues so chdir here to workaround
     cwd = os.getcwd()
 
+    readfd = writefd = readfd1 = writefd1 = readfd2 = writefd2 = None
+    eq = command_chan_recv = command_chan = None
+
     try:
         try:
             os.chdir(os.path.dirname(sockname))
@@ -459,9 +462,6 @@ def connectProcessServer(sockname, featureset):
         finally:
             os.chdir(cwd)
 
-        readfd = writefd = readfd1 = writefd1 = readfd2 = writefd2 = None
-        eq = command_chan_recv = command_chan = None
-
         # Send an fd for the remote to write events to
         readfd, writefd = os.pipe()
         eq = BBUIEventQueue(readfd)
-- 
2.17.1


