Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D49C48BF6
	for <webhook@archiver.kernel.org>; Mon,  4 Mar 2024 17:53:35 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web10.1379.1709574807606270334
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 04 Mar 2024 09:53:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=lCj6HBgg;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5858E40005;
	Mon,  4 Mar 2024 17:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709574805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=im+6++uE/7wONVhtXcc87BNWnvdKBDk7K0l9yoqttPo=;
	b=lCj6HBgg32QvHcuRtIo48+b6uwJN6ozUW+eXORW3pjrAovmjbSCHS5+Gt0u0higkNjL1Sm
	YC+nGHUN+cIEkqNyXUWNacHtpGCG7B6PFvOCQuo5pqAXgUsqCA1pjlBQYzs7zdNMLvEuZL
	9xI3f81MFGWkV5sbPtIvp7p3vACfMmNlbTmKKaLOClhv1xaJB+TKuUMwBO2z6knkhBFpvx
	d41MNLwXpUnxjz9bxvew0yZ4AZNU08Cc3wi1r3oCQvk1jCNm9jZ/fmR6BhGSTqYrryo3SI
	6SUBhv7BT3Ikeus2bFWwq0JecuVJ2TI4pnxH+7Qy1k9UvLYJRoJrrjRrJUe+PQ==
Message-ID: <f1ddb6b8-fd5f-435f-8b20-ef60f62066db@bootlin.com>
Date: Mon, 4 Mar 2024 18:53:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Content-Language: en-US
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
To: Joshua Watt <JPEWhacker@gmail.com>
Subject: bitbake: how to create a client to an asyncrpc server from another
 server?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 04 Mar 2024 17:53:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15985

Joshua, all,

I'm trying to connect as a client to another PR server from within a PR 
server instance...

My actual code is more complicated, but I have an issue that results 
from just adding this code to the start() function of the PRServer class 
in bitbake/lib/prserv/serv.py:

diff --git a/bitbake/lib/prserv/serv.py b/bitbake/lib/prserv/serv.py
index 62d3b5a01c..66aebacb2e 100644
--- a/bitbake/lib/prserv/serv.py
+++ b/bitbake/lib/prserv/serv.py
@@ -108,6 +108,8 @@ class PRServer(bb.asyncrpc.AsyncServer):
          logger.info("Started PRServer with DBfile: %s, Address: %s, 
PID: %s" %
                       (self.dbfile, self.address, str(os.getpid())))

+        from . import client
+        conn = client.PRClient()
          return tasks

      async def stop(self):
-- 
2.34.1

That's what the ping() function in bitbake/lib/prserv/serv.py does by 
the way.

This breaks BitBake "big time", as shown in the bitbake-cookerdaemon.log 
output:

168775 18:34:06.430012 Base config valid
Process Process-1:
Traceback (most recent call last):
   File "/usr/lib/python3.10/multiprocessing/process.py", line 314, in 
_bootstrap
     self.run()
   File "/usr/lib/python3.10/multiprocessing/process.py", line 108, in run
     self._target(*self._args, **self._kwargs)
   File "/home/mike/work/yocto/poky/bitbake/lib/bb/asyncrpc/serv.py", 
line 369, in run
     self._serve_forever(tasks)
   File "/home/mike/work/yocto/poky/bitbake/lib/bb/asyncrpc/serv.py", 
line 314, in _serve_forever
     self.loop.run_until_complete(asyncio.gather(*tasks))
   File "/usr/lib/python3.10/asyncio/base_events.py", line 628, in 
run_until_complete
     future = tasks.ensure_future(future, loop=self)
   File "/usr/lib/python3.10/asyncio/tasks.py", line 615, in ensure_future
     return _ensure_future(coro_or_future, loop=loop)
   File "/usr/lib/python3.10/asyncio/tasks.py", line 621, in _ensure_future
     raise ValueError('The future belongs to a different loop than '
ValueError: The future belongs to a different loop than the one 
specified as the loop argument
168775 18:34:06.439408 Sending reply (None, 
'bb.BBHandledException()\nTraceback (most recent call last):\n File 
"/home/mike/work/yocto/poky/bitbake/lib/prserv/serv.py", line 333, in 
auto_start\n    ping(host, port)\n  File 
"/home/mike/work/yocto/poky/bitbake/lib/prserv/serv.py", line 352, in 
ping\n    return conn.ping()\n  File 
"/home/mike/work/yocto/poky/bitbake/lib/bb/asyncrpc/client.py", line 
178, in wrapper\n    return self.loop.run_until_complete(downcall(*args, 
**kwargs))\n  File "/usr/lib/python3.10/asyncio/base_events.py", line 
649, in run_until_complete\n    return future.result()\n  File 
"/home/mike/work/yocto/poky/bitbake/lib/bb/asyncrpc/client.py", line 
146, in ping\n    return await self.invoke({"ping": {}})\n File 
"/home/mike/work/yocto/poky/bitbake/lib/bb/asyncrpc/client.py", line 
141, in invoke\n    result = await self._send_wrapper(proc)\n  File 
"/home/mike/work/yocto/poky/bitbake/lib/bb/asyncrpc/client.py", line 
128, in _send_wrapper\n    raise e\n  File 
"/home/mike/work/yocto/poky/bitbake/lib/bb/asyncrpc/client.py", line 
115, in _send_wrapper\n    await self.connect()\n  File 
"/home/mike/work/yocto/poky/bitbake/lib/bb/asyncrpc/client.py", line 
100, in connect\n    self.socket = await self._connect_sock()\n  File 
"/home/mike/work/yocto/poky/bitbake/lib/bb/asyncrpc/client.py", line 41, 
in connect_sock\n    reader, writer = await 
asyncio.open_connection(address, port)\n  File 
"/usr/lib/python3.10/asyncio/streams.py", line 48, in 
open_connection\n    transport, _ = await loop.create_connection(\n  
File "/usr/lib/python3.10/asyncio/base_events.py", line 1076, in 
create_connection\n    raise exceptions[0]\n  File 
"/usr/lib/python3.10/asyncio/base_events.py", line 1060, in 
create_connection\n    sock = await self._connect_sock(\n  File 
"/usr/lib/python3.10/asyncio/base_events.py", line 969, in 
_connect_sock\n    await self.sock_connect(sock, address)\n  File 
"/usr/lib/python3.10/asyncio/selector_events.py", line 501, in 
sock_connect\n    return await fut\n  File 
"/usr/lib/python3.10/asyncio/selector_events.py", line 541, in 
_sock_connect_cb\n    raise OSError(err, f\'Connect call failed 
{address}\')\nConnectionRefusedError: [Errno 111] Connect call failed 
(\'127.0.0.1\', 37321)\n\nDuring handling of the above exception, 
another exception occurred:\n\nTraceback (most recent call last):\n  
File "/home/mike/work/yocto/poky/bitbake/lib/bb/cooker.py", line 308, in 
handlePRServ\n    self.prhost = prserv.serv.auto_start(self.data)\n  
File "/home/mike/work/yocto/poky/bitbake/lib/prserv/serv.py", line 338, 
in auto_start\n    raise 
PRServiceConfigError\nprserv.serv.PRServiceConfigError\n\nDuring 
handling of the above exception, another exception 
occurred:\n\nTraceback (most recent call last):\n  File 
"/home/mike/work/yocto/poky/bitbake/lib/bb/command.py", line 90, in 
runCommand\n    result = command_method(self, commandline)\n File 
"/home/mike/work/yocto/poky/bitbake/lib/bb/command.py", line 290, in 
updateConfig\n    command.cooker.updateConfigOpts(options, environment, 
cmdline)\n  File "/home/mike/work/yocto/poky/bitbake/lib/bb/cooker.py", 
line 462, in updateConfigOpts\n    self.reset()\n  File 
"/home/mike/work/yocto/poky/bitbake/lib/bb/cooker.py", line 1737, in 
reset\n    self.handlePRServ()\n  File 
"/home/mike/work/yocto/poky/bitbake/lib/bb/cooker.py", line 310, in 
handlePRServ\n    bb.fatal("Unable to start PR Server, exiting, check 
the bitbake-cookerdaemon.log")\n  File 
"/home/mike/work/yocto/poky/bitbake/lib/bb/__init__.py", line 189, in 
fatal\n    raise BBHandledException()\nbb.BBHandledException\n')
168775 18:34:06.439442 Command Completed (socket: True)
168775 18:34:06.689943 Processing Client
168775 18:34:06.690247 Disconnecting Client (socket: True)
168775 18:34:06.691510 No timeout, exiting.
168775 18:34:06.792083 Exiting (socket: True)
168775 18:34:06.795611 Exiting as we could obtain the lock
sys:1: ResourceWarning: unclosed file <_io.TextIOWrapper 
name='/home/mike/work/yocto/poky/build/bitbake-cookerdaemon.log' 
mode='a+' encoding='UTF-8'>

I guess the new event loop created in the 
bitbake/lib/bb/asyncrpc/client.py causes the kind of issue reported on 
https://git.yoctoproject.org/poky/tree/bitbake/lib/bb/asyncrpc/client.py#n160.

So, would you have some guidance on how to implement a connection to 
another server from inside a server?
Thanks in advance
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


