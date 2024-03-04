Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0ABC5478C
	for <webhook@archiver.kernel.org>; Mon,  4 Mar 2024 19:27:29 +0000 (UTC)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
 by mx.groups.io with SMTP id smtpd.web11.745.1709580446025794464
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 04 Mar 2024 11:27:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=LO09lg2d;
 spf=pass (domain: gmail.com, ip: 209.85.208.182, mailfrom: jpewhacker@gmail.com)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d24a727f78so59705671fa.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 04 Mar 2024 11:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709580444; x=1710185244; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5Z1grkNny9YZ9NPwV4Q4mtB7+rcfOfmJsxqCgzgZPI=;
        b=LO09lg2dgnqX/YQPcWPEP6xehBaMpl7MdXm5tCLUi9VZGD/CjxQdW8ccPvVtfmDDxo
         Mj+oq+hu3Jnti5RedF4wmtAF5Ro+22G1UM3OOoUjCj+Azt8c/D+7yIIutB6m13Ln3ZxA
         7Hf2gJ2MzunC6qHdsVVmEwi1CZUqkxXY3wKIYObt5tPlw/idhKnlqilhW0nU0UaP4/LA
         X3ncrs0umlHWdq0IHz0SZ7itsdibjJxRjCISO7iYqbyrT0iG5N3R/1m3fQxBzJpSJZms
         FCB6KpaKol5eCcduFQfj2eW8OvIihpsEKYxrEqC0z02GlQk4iLah3GJ4qf+Xt05T8x9b
         jKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709580444; x=1710185244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A5Z1grkNny9YZ9NPwV4Q4mtB7+rcfOfmJsxqCgzgZPI=;
        b=LA2VtrIFb2HZ5fbRhuBW4IW0Wv0CT0Vv1dL2wtQp6H7t8GRE/hDLxaGCfp0CrYFMLu
         ajXGL3IFHgqiHYWycz/EQJ3BksdgGKqOL+U4gRqzQyPiQZJ4cdwZ7DTT5f4qaEeEuH3V
         Sc37lbRx9YDHBfEg8VuhoFvDVUzE3N6xlEc+WpbvRECppU9kKYlfl4FNfthq+pXGIEh2
         f4LdPr1R0cqQHgVcZHteffMImf0LxfUwBZnC6NbfUhDqyVtilTMl235S4x/bxm4aT7T3
         cXG+qUDU14sngtnmskzn9mm3321mExPOtWVb4dGJD0uVPJLKdTkghF9hbfIymB4mWED9
         ZVqA==
X-Gm-Message-State: AOJu0Yy1BOdVD8r4claXsVDan4iPh9e1f86K5gTBXSBNQP4IQMo56Bf8
	p2EKpDchgqMT3uCWrC0iyPWuvCz3L/AgiC3Wk59DchyrSj31fBDNJPbJ4nQxgkC30m9C7H5lhx1
	d1SSOlbspvSl4K7OgojjkeqmwEAE=
X-Google-Smtp-Source: AGHT+IFFAyYXTRk5FLufh/agIiLmsC62E5BRe7G9XJ6zUMa6n/+8WVksYhQmNfyp+JXQRrrsIAc+F7bUwigbhtfwWaA=
X-Received: by 2002:a2e:b057:0:b0:2d3:3305:c37d with SMTP id
 d23-20020a2eb057000000b002d33305c37dmr7267045ljl.2.1709580443726; Mon, 04 Mar
 2024 11:27:23 -0800 (PST)
MIME-Version: 1.0
References: <f1ddb6b8-fd5f-435f-8b20-ef60f62066db@bootlin.com>
In-Reply-To: <f1ddb6b8-fd5f-435f-8b20-ef60f62066db@bootlin.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Mon, 4 Mar 2024 12:27:11 -0700
Message-ID: <CAJdd5GZgPcC2Oy+V=+eEq0YAB8R-Z1+31SSySgG8kmOJP2uc8g@mail.gmail.com>
Subject: Re: bitbake: how to create a client to an asyncrpc server from
 another server?
To: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 04 Mar 2024 19:27:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15986

Michael,

Create an async client instead of a blocking client:

  conn =3D client.PRAsyncClient()

You'll want to do this anyway because you want to make async calls to
the "upstream" server. If you use a blocking client it will block the
entire server process during the call which means the server won't be
able to process any other clients while waiting for a response.

On Mon, Mar 4, 2024 at 10:53=E2=80=AFAM Michael Opdenacker
<michael.opdenacker@bootlin.com> wrote:
>
> Joshua, all,
>
> I'm trying to connect as a client to another PR server from within a PR
> server instance...
>
> My actual code is more complicated, but I have an issue that results
> from just adding this code to the start() function of the PRServer class
> in bitbake/lib/prserv/serv.py:
>
> diff --git a/bitbake/lib/prserv/serv.py b/bitbake/lib/prserv/serv.py
> index 62d3b5a01c..66aebacb2e 100644
> --- a/bitbake/lib/prserv/serv.py
> +++ b/bitbake/lib/prserv/serv.py
> @@ -108,6 +108,8 @@ class PRServer(bb.asyncrpc.AsyncServer):
>           logger.info("Started PRServer with DBfile: %s, Address: %s,
> PID: %s" %
>                        (self.dbfile, self.address, str(os.getpid())))
>
> +        from . import client
> +        conn =3D client.PRClient()
>           return tasks
>
>       async def stop(self):
> --
> 2.34.1
>
> That's what the ping() function in bitbake/lib/prserv/serv.py does by
> the way.
>
> This breaks BitBake "big time", as shown in the bitbake-cookerdaemon.log
> output:
>
> 168775 18:34:06.430012 Base config valid
> Process Process-1:
> Traceback (most recent call last):
>    File "/usr/lib/python3.10/multiprocessing/process.py", line 314, in
> _bootstrap
>      self.run()
>    File "/usr/lib/python3.10/multiprocessing/process.py", line 108, in ru=
n
>      self._target(*self._args, **self._kwargs)
>    File "/home/mike/work/yocto/poky/bitbake/lib/bb/asyncrpc/serv.py",
> line 369, in run
>      self._serve_forever(tasks)
>    File "/home/mike/work/yocto/poky/bitbake/lib/bb/asyncrpc/serv.py",
> line 314, in _serve_forever
>      self.loop.run_until_complete(asyncio.gather(*tasks))
>    File "/usr/lib/python3.10/asyncio/base_events.py", line 628, in
> run_until_complete
>      future =3D tasks.ensure_future(future, loop=3Dself)
>    File "/usr/lib/python3.10/asyncio/tasks.py", line 615, in ensure_futur=
e
>      return _ensure_future(coro_or_future, loop=3Dloop)
>    File "/usr/lib/python3.10/asyncio/tasks.py", line 621, in _ensure_futu=
re
>      raise ValueError('The future belongs to a different loop than '
> ValueError: The future belongs to a different loop than the one
> specified as the loop argument
> 168775 18:34:06.439408 Sending reply (None,
> 'bb.BBHandledException()\nTraceback (most recent call last):\n File
> "/home/mike/work/yocto/poky/bitbake/lib/prserv/serv.py", line 333, in
> auto_start\n    ping(host, port)\n  File
> "/home/mike/work/yocto/poky/bitbake/lib/prserv/serv.py", line 352, in
> ping\n    return conn.ping()\n  File
> "/home/mike/work/yocto/poky/bitbake/lib/bb/asyncrpc/client.py", line
> 178, in wrapper\n    return self.loop.run_until_complete(downcall(*args,
> **kwargs))\n  File "/usr/lib/python3.10/asyncio/base_events.py", line
> 649, in run_until_complete\n    return future.result()\n  File
> "/home/mike/work/yocto/poky/bitbake/lib/bb/asyncrpc/client.py", line
> 146, in ping\n    return await self.invoke({"ping": {}})\n File
> "/home/mike/work/yocto/poky/bitbake/lib/bb/asyncrpc/client.py", line
> 141, in invoke\n    result =3D await self._send_wrapper(proc)\n  File
> "/home/mike/work/yocto/poky/bitbake/lib/bb/asyncrpc/client.py", line
> 128, in _send_wrapper\n    raise e\n  File
> "/home/mike/work/yocto/poky/bitbake/lib/bb/asyncrpc/client.py", line
> 115, in _send_wrapper\n    await self.connect()\n  File
> "/home/mike/work/yocto/poky/bitbake/lib/bb/asyncrpc/client.py", line
> 100, in connect\n    self.socket =3D await self._connect_sock()\n  File
> "/home/mike/work/yocto/poky/bitbake/lib/bb/asyncrpc/client.py", line 41,
> in connect_sock\n    reader, writer =3D await
> asyncio.open_connection(address, port)\n  File
> "/usr/lib/python3.10/asyncio/streams.py", line 48, in
> open_connection\n    transport, _ =3D await loop.create_connection(\n
> File "/usr/lib/python3.10/asyncio/base_events.py", line 1076, in
> create_connection\n    raise exceptions[0]\n  File
> "/usr/lib/python3.10/asyncio/base_events.py", line 1060, in
> create_connection\n    sock =3D await self._connect_sock(\n  File
> "/usr/lib/python3.10/asyncio/base_events.py", line 969, in
> _connect_sock\n    await self.sock_connect(sock, address)\n  File
> "/usr/lib/python3.10/asyncio/selector_events.py", line 501, in
> sock_connect\n    return await fut\n  File
> "/usr/lib/python3.10/asyncio/selector_events.py", line 541, in
> _sock_connect_cb\n    raise OSError(err, f\'Connect call failed
> {address}\')\nConnectionRefusedError: [Errno 111] Connect call failed
> (\'127.0.0.1\', 37321)\n\nDuring handling of the above exception,
> another exception occurred:\n\nTraceback (most recent call last):\n
> File "/home/mike/work/yocto/poky/bitbake/lib/bb/cooker.py", line 308, in
> handlePRServ\n    self.prhost =3D prserv.serv.auto_start(self.data)\n
> File "/home/mike/work/yocto/poky/bitbake/lib/prserv/serv.py", line 338,
> in auto_start\n    raise
> PRServiceConfigError\nprserv.serv.PRServiceConfigError\n\nDuring
> handling of the above exception, another exception
> occurred:\n\nTraceback (most recent call last):\n  File
> "/home/mike/work/yocto/poky/bitbake/lib/bb/command.py", line 90, in
> runCommand\n    result =3D command_method(self, commandline)\n File
> "/home/mike/work/yocto/poky/bitbake/lib/bb/command.py", line 290, in
> updateConfig\n    command.cooker.updateConfigOpts(options, environment,
> cmdline)\n  File "/home/mike/work/yocto/poky/bitbake/lib/bb/cooker.py",
> line 462, in updateConfigOpts\n    self.reset()\n  File
> "/home/mike/work/yocto/poky/bitbake/lib/bb/cooker.py", line 1737, in
> reset\n    self.handlePRServ()\n  File
> "/home/mike/work/yocto/poky/bitbake/lib/bb/cooker.py", line 310, in
> handlePRServ\n    bb.fatal("Unable to start PR Server, exiting, check
> the bitbake-cookerdaemon.log")\n  File
> "/home/mike/work/yocto/poky/bitbake/lib/bb/__init__.py", line 189, in
> fatal\n    raise BBHandledException()\nbb.BBHandledException\n')
> 168775 18:34:06.439442 Command Completed (socket: True)
> 168775 18:34:06.689943 Processing Client
> 168775 18:34:06.690247 Disconnecting Client (socket: True)
> 168775 18:34:06.691510 No timeout, exiting.
> 168775 18:34:06.792083 Exiting (socket: True)
> 168775 18:34:06.795611 Exiting as we could obtain the lock
> sys:1: ResourceWarning: unclosed file <_io.TextIOWrapper
> name=3D'/home/mike/work/yocto/poky/build/bitbake-cookerdaemon.log'
> mode=3D'a+' encoding=3D'UTF-8'>
>
> I guess the new event loop created in the
> bitbake/lib/bb/asyncrpc/client.py causes the kind of issue reported on
> https://git.yoctoproject.org/poky/tree/bitbake/lib/bb/asyncrpc/client.py#=
n160.
>
> So, would you have some guidance on how to implement a connection to
> another server from inside a server?
> Thanks in advance
> Cheers
> Michael.
>
> --
> Michael Opdenacker, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>

