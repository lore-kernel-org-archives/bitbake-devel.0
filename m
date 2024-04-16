Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EA7C4345F
	for <webhook@archiver.kernel.org>; Tue, 16 Apr 2024 17:20:05 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
 by mx.groups.io with SMTP id smtpd.web10.27153.1713287995918415520
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Apr 2024 10:19:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=gHIR/Evx;
 spf=pass (domain: bootlin.com, ip: 217.70.183.200, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DD3C020003;
	Tue, 16 Apr 2024 17:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713287994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EbDQsTpC6jgq4qUOaQ3YDYJktC/rdTcG7YMz7CDum+Y=;
	b=gHIR/EvxzAapBYjgsLDCxYqsfjGOSoLOtREEBqjQND9K0buTWprdEHcgc9d72GPcxl3I0x
	dD9+ZzJkk2uMXgF9nfQ6nndo5O98FP86drTn9r8RSBLrjTQ42aKXY0njwSDAHmYvWGzyiZ
	4dg/MSj2uY/38vfc7+E9rfRDHsIWict4tR0IHHXs6ulcRImKYsCFPQBFjCTcGJf9g+EjSk
	clcoLXKSaP7G1741qpR2zr0Vce8UfkWuJhBS3eUGsP1c+qv+McL4yagpMta5963WZ82JWN
	siYOGjVl8UMyDpkcYvNpHmgyxuXovvclROEHsFoi6MY/MBcr+SBMMU4Oa/DtSw==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [RFC][PATCH 0/3] Call for help for prserv selftests
Date: Tue, 16 Apr 2024 19:19:42 +0200
Message-Id: <20240416171945.3799445-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Spam-Score: 300
X-GND-Status: SPAM
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Apr 2024 17:20:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16098

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

Hi Joshua and BitBake contributors,

I'm trying to implement the first BitBake selftests for the PR server.
I tried to replicate what is done by the hashserv selftests, but I
still can't seem to connect to the server I started.

I'm attaching my code (especially the 3rd patch) as a patch series.

I won't give up, but if you have clues about what could be wrong, they
would be much appreciated!

Here's the output I'm getting:

mike@xps:~/work/yocto/poky/build$ bitbake-selftest prserv.tests.PRCommonTests
E
Stdout:
SERVER STARTED WITH ADDRESS: 127.0.0.1:33399
CLIENT CONNECTED TO: 127.0.0.1:33399
Error talking to server: [Errno 104] Connection reset by peer
Error talking to server: [Errno 111] Connect call failed ('127.0.0.1', 33399)
Error talking to server: [Errno 111] Connect call failed ('127.0.0.1', 33399)
Error talking to server: [Errno 111] Connect call failed ('127.0.0.1', 33399)

======================================================================
ERROR: test_create_pr (prserv.tests.PRCommonTests)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/home/mike/work/yocto/poky/bitbake/lib/prserv/tests.py", line 81, in test_create_pr
    result = self.client.test_pr("dummy-1.0-r0", "core2-64", "51bf8189dbe9ea81fa6dd89608bf19380c437a9cf12f6c6239887801ba4ab4a5")
  File "/home/mike/work/yocto/poky/bitbake/lib/bb/asyncrpc/client.py", line 201, in wrapper
    return self.loop.run_until_complete(downcall(*args, **kwargs))
  File "/usr/lib/python3.10/asyncio/base_events.py", line 649, in run_until_complete
    return future.result()
  File "/home/mike/work/yocto/poky/bitbake/lib/prserv/client.py", line 25, in test_pr
    response = await self.invoke(
  File "/home/mike/work/yocto/poky/bitbake/lib/bb/asyncrpc/client.py", line 164, in invoke
    result = await self._send_wrapper(proc)
  File "/home/mike/work/yocto/poky/bitbake/lib/bb/asyncrpc/client.py", line 151, in _send_wrapper
    raise e
  File "/home/mike/work/yocto/poky/bitbake/lib/bb/asyncrpc/client.py", line 138, in _send_wrapper
    await self.connect()
  File "/home/mike/work/yocto/poky/bitbake/lib/bb/asyncrpc/client.py", line 123, in connect
    self.socket = await self._connect_sock()
  File "/home/mike/work/yocto/poky/bitbake/lib/bb/asyncrpc/client.py", line 64, in connect_sock
    reader, writer = await asyncio.open_connection(address, port)
  File "/usr/lib/python3.10/asyncio/streams.py", line 48, in open_connection
    transport, _ = await loop.create_connection(
  File "/usr/lib/python3.10/asyncio/base_events.py", line 1076, in create_connection
    raise exceptions[0]
  File "/usr/lib/python3.10/asyncio/base_events.py", line 1060, in create_connection
    sock = await self._connect_sock(
  File "/usr/lib/python3.10/asyncio/base_events.py", line 969, in _connect_sock
    await self.sock_connect(sock, address)
  File "/usr/lib/python3.10/asyncio/selector_events.py", line 501, in sock_connect
    return await fut
  File "/usr/lib/python3.10/asyncio/selector_events.py", line 541, in _sock_connect_cb
    raise OSError(err, f'Connect call failed {address}')
ConnectionRefusedError: [Errno 111] Connect call failed ('127.0.0.1', 33399)

Stdout:
SERVER STARTED WITH ADDRESS: 127.0.0.1:33399
CLIENT CONNECTED TO: 127.0.0.1:33399
Error talking to server: [Errno 104] Connection reset by peer
Error talking to server: [Errno 111] Connect call failed ('127.0.0.1', 33399)
Error talking to server: [Errno 111] Connect call failed ('127.0.0.1', 33399)
Error talking to server: [Errno 111] Connect call failed ('127.0.0.1', 33399)

----------------------------------------------------------------------
Ran 1 test in 0.015s

FAILED (errors=1)

---

Thanks in advance
Michael.

Michael Opdenacker (3):
  prserv: add "upstream" server support
  prserv: add "history" argument to "get-pr" request
  prserv: start bitbake selftests

 bin/bitbake-prserv     |  15 ++++-
 bin/bitbake-selftest   |   2 +
 lib/prserv/__init__.py |  39 +++++++++++++
 lib/prserv/client.py   |   5 +-
 lib/prserv/db.py       | 127 ++++++++++++++++++++---------------------
 lib/prserv/serv.py     |  98 ++++++++++++++++++++++++++-----
 lib/prserv/tests.py    |  84 +++++++++++++++++++++++++++
 7 files changed, 289 insertions(+), 81 deletions(-)
 create mode 100644 bitbake/lib/prserv/tests.py

-- 
2.34.1


