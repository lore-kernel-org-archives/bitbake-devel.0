Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643ABC4345F
	for <webhook@archiver.kernel.org>; Thu,  2 May 2024 16:58:00 +0000 (UTC)
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
 by mx.groups.io with SMTP id smtpd.web11.3.1714669072587938148
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 02 May 2024 09:57:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=UpiJVlMk;
 spf=pass (domain: gmail.com, ip: 209.85.160.49, mailfrom: raj.khem@gmail.com)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-23d39e4c0d9so1138448fac.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 02 May 2024 09:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714669072; x=1715273872; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQ48l8qaBiWQ62FIo8ZyaRX5JDRYxwwpyFezelrZCEM=;
        b=UpiJVlMkTKRcDlAaRJ6pUCpHmB7jVgEu+rfZYpSWw05FwPYhHLJrK3k6Mzi9PHrTwp
         2qvchhYiX7kJkOM9kwnJh/tH/2fU/7b0ukyAaPM32zJKuamJ0sGFo+C0jMXVV/OYqX71
         dSmkMh7Euk1ic8oLLErMPZJDXecIRw2nUYnytFJkSSGD2xeckJy6J4A3KInMThhvsxZs
         lKLslhbOxQPZlbw8iJtLgu3cGnmOaskqnYETShINWQUuCMcDDpUMMVaoIw6l5i4pzpKu
         USqtNY9wbXFPfBZbVOmGFy2L8FoIfHCW3MYp2dPdzpG6cJVxzKossYP5NinzNkc7EYsT
         kE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714669072; x=1715273872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sQ48l8qaBiWQ62FIo8ZyaRX5JDRYxwwpyFezelrZCEM=;
        b=CiKdG/YHFbWqtgRw+87DinvbSElDvk/GcTSupgoIFNp8DNL9nLGyxx9Q4sNMnnuMOr
         kcoIT5zI51nizuA9FQ17gCsACjs5U+JEsx2q1B6SsGOzMMo1sHWWwDPskI7vxMFNPBgU
         PMQU8sA5ggCr6EezJ5LGyYzessHYFT0udVdau1rG4S99sM8vG74jKYzgZJtHZlpW1S2/
         m/IIAtU9hnRtcfOzRmhgcZD+hR51oDenCv9razV63i45pw72mBaVNrLxz4pgsxMK4TpA
         QUViBy432mCJ4FdpBJHm+OliDBU8hAY8uLzgZG7/d6P9+lP0WXdbuTRXjykSD8Dg2QyF
         72Vw==
X-Gm-Message-State: AOJu0YwmL1zlrhapkPf/YRTQHHMXvKfvviLH/qwQnhkp206+z7AnSZ/y
	agQbAfJc3Sc8oP1rD6RTjTE/b+fR+cZS4oDfp5uNMdvaWGeLt1YDXTBnbf3GiYnEUnQx3QEwtE3
	dtvQ9S+luZE6zryYen5NZUP9FKWk=
X-Google-Smtp-Source: AGHT+IHBQjfJmjI5SchmRtx0oorHwRfVw6D2TMSBuH3IRCIJ/VVXw/x4nmOPm/jhubpugbg/VJqObhPHJJ5C0TTjz4I=
X-Received: by 2002:a05:6870:b49e:b0:22d:f619:94c5 with SMTP id
 y30-20020a056870b49e00b0022df61994c5mr526734oap.10.1714669071877; Thu, 02 May
 2024 09:57:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240429201418.657042-1-michael.opdenacker@bootlin.com> <20240429201418.657042-3-michael.opdenacker@bootlin.com>
In-Reply-To: <20240429201418.657042-3-michael.opdenacker@bootlin.com>
From: Khem Raj <raj.khem@gmail.com>
Date: Thu, 2 May 2024 09:57:25 -0700
Message-ID: <CAMKF1soyTt3He84XOgAv01ZdwGPZ2gxVwZaRxsL2Dufj3W_=rg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v5 2/5] prserv: move code from __init__ to bitbake-prserv
To: michael.opdenacker@bootlin.com
Cc: bitbake-devel@lists.openembedded.org, Joshua Watt <JPEWhacker@gmail.com>, 
	Tim Orling <ticotimo@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 02 May 2024 16:58:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16182

Hi Michael

I am seeing a problem with this series, specifically following
patchset is causing a regression

* ea1d7b8a36e bitbake: prserv: add bitbake selftests
* 5c66d345300 bitbake: prserv: import simplification
* c23f2c1680f bitbake: prserv: store_value() improvements
* 395b321af29 bitbake: prserv: avoid possible race condition in database co=
de
* 8022dc1029d bitbake: prserv: enable database sharing
* b81bfdfbed8 bitbake: prserv: add "upstream" server support
* 9539ce3b14a bitbake: prserv: move code from __init__ to bitbake-prserv
* 4ec1553710b bitbake: prserv: declare "max_package_pr" client hook


error seen during packagedata task of base-files

WARNING: base-files-3.0.14-r0 do_packagedata: Error talking to server:
Connection closed
ERROR: Error from client ('127.0.0.1', 59846): 'PRTable' object has no
attribute 'sync'
Traceback (most recent call last):
  File "/mnt/b/yoe/master/sources/poky/bitbake/lib/bb/asyncrpc/serv.py",
line 278, in PRServer._client_handler(socket=3D<bb.asyncrpc.connection.Stre=
amConnection
object at 0x794b1e009110>):
                 client =3D self.accept_client(socket)
    >            await client.process_requests()
             except Exception as e:
  File "/mnt/b/yoe/master/sources/poky/bitbake/lib/prserv/serv.py",
line 171, in PRServerClient.process_requests():
             try:
    >            await super().process_requests()
             finally:
  File "/mnt/b/yoe/master/sources/poky/bitbake/lib/bb/asyncrpc/serv.py",
line 92, in PRServerClient.process_requests():
                     try:
    >                    response =3D await self.dispatch_message(d)
                     except InvokeError as e:
  File "/mnt/b/yoe/master/sources/poky/bitbake/lib/prserv/serv.py",
line 45, in PRServerClient.dispatch_message(msg=3D{'get-pr': {'version':
'base-files-3.0.14-r0', 'pkgarch': 'imx8qm_var_som', 'checksum':
'0d287eea3da9a2573dfd3fbc709ef8697f2553563ff1211efc733f215d510663',
'history': False}}):
             except:
    >            self.server.table.sync()
                 raise
AttributeError: 'PRTable' object has no attribute 'sync'


To reproduce this you will need to add a bbappend for base-files from

https://github.com/varigit/meta-variscite-bsp-imx/blob/hardknott/recipes-co=
re/base-files/base-files_%25.bbappend

You can make the overrides match the machine you might be building if
not one of variscite machine.


Thanks
-Khem

On Mon, Apr 29, 2024 at 1:14=E2=80=AFPM Michael Opdenacker via
lists.openembedded.org
<michael.opdenacker=3Dbootlin.com@lists.openembedded.org> wrote:
>
> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
>
> This script was the only user of this code.
>
> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
> Cc: Joshua Watt <JPEWhacker@gmail.com>
> Cc: Tim Orling <ticotimo@gmail.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> ---
>  bin/bitbake-prserv     |  9 ++++++++-
>  lib/prserv/__init__.py | 13 -------------
>  2 files changed, 8 insertions(+), 14 deletions(-)
>
> diff --git a/bin/bitbake-prserv b/bin/bitbake-prserv
> index ad0a069401..920663a1d8 100755
> --- a/bin/bitbake-prserv
> +++ b/bin/bitbake-prserv
> @@ -21,6 +21,13 @@ VERSION =3D "1.1.0"
>  PRHOST_DEFAULT=3D"0.0.0.0"
>  PRPORT_DEFAULT=3D8585
>
> +def init_logger(logfile, loglevel):
> +    numeric_level =3D getattr(logging, loglevel.upper(), None)
> +    if not isinstance(numeric_level, int):
> +        raise ValueError("Invalid log level: %s" % loglevel)
> +    FORMAT =3D "%(asctime)-15s %(message)s"
> +    logging.basicConfig(level=3Dnumeric_level, filename=3Dlogfile, forma=
t=3DFORMAT)
> +
>  def main():
>      parser =3D argparse.ArgumentParser(
>          description=3D"BitBake PR Server. Version=3D%s" % VERSION,
> @@ -72,7 +79,7 @@ def main():
>      )
>
>      args =3D parser.parse_args()
> -    prserv.init_logger(os.path.abspath(args.log), args.loglevel)
> +    init_logger(os.path.abspath(args.log), args.loglevel)
>
>      if args.start:
>          ret=3Dprserv.serv.start_daemon(args.file, args.host, args.port, =
os.path.abspath(args.log), args.read_only)
> diff --git a/lib/prserv/__init__.py b/lib/prserv/__init__.py
> index 0e0aa34d0e..94658b815d 100644
> --- a/lib/prserv/__init__.py
> +++ b/lib/prserv/__init__.py
> @@ -5,16 +5,3 @@
>  #
>
>  __version__ =3D "1.0.0"
> -
> -import os, time
> -import sys, logging
> -
> -def init_logger(logfile, loglevel):
> -    numeric_level =3D getattr(logging, loglevel.upper(), None)
> -    if not isinstance(numeric_level, int):
> -        raise ValueError("Invalid log level: %s" % loglevel)
> -    FORMAT =3D "%(asctime)-15s %(message)s"
> -    logging.basicConfig(level=3Dnumeric_level, filename=3Dlogfile, forma=
t=3DFORMAT)
> -
> -class NotFoundError(Exception):
> -    pass
> --
> 2.34.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16151): https://lists.openembedded.org/g/bitbake-deve=
l/message/16151
> Mute This Topic: https://lists.openembedded.org/mt/105808694/1997914
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [raj.kh=
em@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

