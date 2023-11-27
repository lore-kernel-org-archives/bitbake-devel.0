Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF7CC07CB1
	for <webhook@archiver.kernel.org>; Mon, 27 Nov 2023 14:19:19 +0000 (UTC)
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
 by mx.groups.io with SMTP id smtpd.web11.95580.1701094756189717547
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Nov 2023 06:19:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=AzrvaH3v;
 spf=pass (domain: gmail.com, ip: 209.85.161.45, mailfrom: quaresma.jose@gmail.com)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-58d521f12ebso1270999eaf.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 27 Nov 2023 06:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701094755; x=1701699555; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n/stno69W9hK6uJPnMg4I4BMdJK5XStz0mbwxuWu/9Y=;
        b=AzrvaH3vcWun4iNE8we7I4ux5EBXWWyxb+jVXh4nqu28Il7+Y8VcI0qJ39IhUqkf5Z
         ofNUYr0AtyScGM+KOixSn44Y4oKYQriX/ldPs2A04zMSDcB/iL8NrzsdeoLt100G0nWW
         +kJqZc32kQJaWmrwl4F7w8Qc6DThZzeYHmdOgeMOeVG69Z0pyi/enoJvhMHfqNhiadez
         ju2ZOkfO1v8MqzU4HdPb2E1nruyYNzYjnbkPwHG+koHRdoo4laOWGEfR/wsN5xD+rrEu
         Kwd77dCDBqJk1wQPFLFONuvX99mZF6X8dxQ3tLiMESRN4NSjKwhNZHmlxem2jD0NPfsY
         EsOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701094755; x=1701699555;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n/stno69W9hK6uJPnMg4I4BMdJK5XStz0mbwxuWu/9Y=;
        b=WcS8hsDXdM1Y8zIgoaXYgkAjbR74be9hLrvTXQlx++I/GlgO+1rIybwB9qxdfwiteM
         tCa/koh8lOMxsFndhm1oEwLnf9wClm1yzq9g733wjt7PCwk1t1a9N2dZlNy2kJDuWk8W
         ec8viHIuA8oUV9IyDVMQdQxXA/BoyhtLWKYz1GE9tib/mRq8swymV8U38oyCtAAIE9z7
         jDf4Uu0TxjyiOCLJPIrbD9qftqD2xM2C3bteWLUxzvMv7Kn6jKWvWa4QqLoc00DKE5il
         10CnCXmvSkgj7Drmqh+MnUHv0PgKSYpjJMVFLXPzo43DQ9qAEDiSTxDcgOAgvlrO+dEe
         uO7w==
X-Gm-Message-State: AOJu0Yye4GNc3vm8k4vjMevhwTgWyZEu2n9Gdjmym4kScObGDonFuxfY
	qeRlsbfMQtLHOoCDAX5MgSfcxStJumll2lYLbAw=
X-Google-Smtp-Source: AGHT+IEl17xC3SeinTBzv11IuH83AWgJXRUaYLee4msPz63zliqScdWC7aOLjnkKLZ8rb7ZVC88/2eggCOkzfz75vZ4=
X-Received: by 2002:a05:6358:4298:b0:16e:4c23:a523 with SMTP id
 s24-20020a056358429800b0016e4c23a523mr1144641rwc.27.1701094755235; Mon, 27
 Nov 2023 06:19:15 -0800 (PST)
MIME-Version: 1.0
References: <20231116165233.2862786-1-richard.purdie@linuxfoundation.org>
 <CANPvuR=Nkf1MV6mMf6Z0XWpensaKo4KB6MQvDxUr0ER5=mHKWQ@mail.gmail.com>
 <63e078f1b4dd53095f00ec3c54c4c420ead9f7ac.camel@linuxfoundation.org>
 <179AAE63E62AFEF6.23801@lists.openembedded.org> <CANPvuRmFtEtmykoGnJKGB4e-CdzNoL7Q0necKrNpd0dhqnmduw@mail.gmail.com>
 <2fe3962b4ea14e96a33b41184d33c5b17f093c5b.camel@linuxfoundation.org>
In-Reply-To: <2fe3962b4ea14e96a33b41184d33c5b17f093c5b.camel@linuxfoundation.org>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Mon, 27 Nov 2023 14:19:04 +0000
Message-ID: <CANPvuR=h5mbeo_O+j_WSKJK6YysNXo9NSaHsmJQimG+CAxojwg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] cooker: Add support for BB_DEFAULT_EVENTLOG
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org, 
	Ricardo Salveti <ricardo@foundries.io>
Content-Type: multipart/alternative; boundary="0000000000009d8742060b22fccc"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 Nov 2023 14:19:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15575

--0000000000009d8742060b22fccc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Richard Purdie <richard.purdie@linuxfoundation.org> escreveu no dia
segunda, 27/11/2023 =C3=A0(s) 13:43:

> On Mon, 2023-11-27 at 12:16 +0000, Jose Quaresma wrote:
> >
> >
> > Jose Quaresma via lists.openembedded.org
> > <quaresma.jose=3Dgmail.com@lists.openembedded.org> escreveu no dia
> > sexta, 24/11/2023 =C3=A0(s) 22:05:
> > >
> > >
> > > A sexta, 24/11/2023, 20:19, Richard Purdie
> > > <richard.purdie@linuxfoundation.org> escreveu:
> > > > On Fri, 2023-11-24 at 17:27 +0000, Jose Quaresma wrote:
> > > > > Hi Richard,
> > > > >
> > > > > I believe I found a regression in this patch.
> > > > > When we build with a custom BB_LOGCONFIG configuration, bitbake
> > > > > hangs
> > > > > at start-up
> > > > > in the ping command. Here is my build log:
> > > > >
> > > > > Loading cache...done.
> > > > > Loaded 6050 entries from dependency cache.
> > > > > (2023-11-24 16:06:39,801) INFO: Resolving any missing task
> > > > > queue
> > > > > dependencies
> > > > > (2023-11-24 16:06:46,455) Level 21:
> > > > > Build Configuration:
> > > > > BB_VERSION           =3D "2.6.0"
> > > > > BUILD_SYS            =3D "x86_64-linux"
> > > > > NATIVELSBSTRING      =3D "universal"
> > > > > TARGET_SYS           =3D "x86_64-lmp-linux"
> > > > > MACHINE              =3D "intel-corei7-64"
> > > > > DISTRO               =3D "lmp"
> > > > > DISTRO_VERSION       =3D "4.0.14-78-91"
> > > > > TUNE_FEATURES        =3D "m64 corei7"
> > > > > TARGET_FPU           =3D ""
> > > > > DISTRO_FEATURES      =3D "acl argp bluetooth ext2 ipv4 ipv6
> > > > > largefile
> > > > > usbgadget usbhost wifi xattr zeroconf pci vfat modsign efi
> > > > > security
> > > > > tpm integrity seccomp pam usrmerge virtualization alsa sota
> > > > > systemd
> > > > > usrmerge"
> > > > > meta-lmp-base        =3D
> > > > > "HEAD:3a18fbcdb5629b1056c14af2ec72f21bb829893f"
> > > > > meta-oe
> > > > > meta-networking
> > > > > meta-filesystems
> > > > > meta-perl
> > > > > meta-python          =3D
> > > > > "HEAD:991e6852a53e0fcd40af8f0386d7f46bb318015e"
> > > > > meta-virtualization  =3D
> > > > > "HEAD:a215d8320edee0a317a6511e7e2efa5bba867486"
> > > > > meta-clang           =3D
> > > > > "HEAD:8aaed8f345683c2fb03a4d90f615f1e93f545a55"
> > > > > meta-updater         =3D
> > > > > "HEAD:defecf4523fe70d38efCompleted (socket: True)
> > > > > > 365401 12:05:44.152781 Running 0e264b46a38019d6d3088"
> > > > > meta-security
> > > > > meta-tpm
> > > > > meta-parsec
> > > > > meta-integrity       =3D
> > > > > "HEAD:070a1e82cc59424d230a23c0b2a104b01fbaa2ad"
> > > > > meta-arm
> > > > > meta-arm-toolchain
> > > > > meta-arm-bsp         =3D
> > > > > "HEAD:5f8b6a2d269c59c21273fee5417f2f0d90a086a1"
> > > > > meta-freescale       =3D
> > > > > "HEAD:d48d230b34292f8c61e5ead75e067fff404fb20c"
> > > > > meta-freescale-3rdparty =3D
> > > > > "HEAD:a9bba0f7fc3765431433886a3e78632dcfa7ad26"
> > > > > meta-raspberrypi     =3D
> > > > > "HEAD:8231f97534812cb0c6ab8d500eff44d3880fdac5"
> > > > > meta-intel           =3D
> > > > > "HEAD:52ce86a7f5f1ed751d80bc5e1d6b76db1c5b84c8"
> > > > > meta-yocto-bsp       =3D
> > > > > "HEAD:5d86975934b46a64b36f60c097bce7a577c1b8b0"
> > > > > meta-xilinx-core
> > > > > meta-xilinx-bsp
> > > > > meta-xilinx-standalone =3D
> > > > > "HEAD:0872170289d08996d821db4d8988647a13063269"
> > > > > meta-xilinx-tools    =3D
> > > > > "HEAD:65799115a9d3dd53053b08f6f1416ecf879f4898"
> > > > > meta-tegra           =3D
> > > > > "HEAD:fb4c603c504b6df9631f15a4734cbb8c42b1005a"
> > > > > meta-ti-bsp
> > > > > meta-ti-extras       =3D
> > > > > "HEAD:d3bcad2cbe63d4e1cd2b4e4418d0b3b9c1f864ed"
> > > > > meta-lmp-bsp         =3D
> > > > > "HEAD:3a18fbcdb5629b1056c14af2ec72f21bb829893f"
> > > > > meta                 =3D
> > > > > "HEAD:795e85f62f3c88c08f24d986548ffe422f459cd0"
> > > > >
> > > > > [Errno 32] Broken pipeTraceback (most recent call last):
> > > > >   File "/srv/oe/bitbake/lib/bb/ui/knotty.py", line 647, in main
> > > > >     ret, error =3D server.runCommand(["ping"])
> > > > >   File "/srv/oe/bitbake/lib/bb/server/process.py", line 503, in
> > > > > runCommand
> > > > >     self.connection.send(command)
> > > > >   File "/srv/oe/bitbake/lib/bb/server/process.py", line 868, in
> > > > > send
> > > > >     self._send(obj)
> > > > >   File "/srv/oe/bitbake/lib/bb/server/process.py", line 847, in
> > > > > _send
> > > > >     self.writer.send_bytes(obj)
> > > > >   File "/usr/lib/python3.8/multiprocessing/connection.py", line
> > > > > 200,
> > > > > in send_bytes
> > > > >     self._send_bytes(m[offset:offset + size])
> > > > >   File "/usr/lib/python3.8/multiprocessing/connection.py", line
> > > > > 411,
> > > > > in _send_bytes
> > > > >     self._send(header + buf)
> > > > >   File "/usr/lib/python3.8/multiprocessing/connection.py", line
> > > > > 368,
> > > > > in _send
> > > > >     n =3D write(self._handle, buf)
> > > > > BrokenPipeError: [Errno 32] Broken pipe
> > > > > During handling of the above exception, another exception
> > > > > occurred:
> > > > > Traceback (most recent call last):
> > > > >   File "/srv/oe/bitbake/bin/bitbake", line 36, in <module>
> > > > >     sys.exit(bitbake_main(BitBakeConfigParameters(sys.argv),
> > > > >   File "/srv/oe/bitbake/lib/bb/main.py", line 404, in
> > > > > bitbake_main
> > > > >     return ui_module.main(server_connection.connection,
> > > > > server_connection.events,
> > > > >   File "/srv/oe/bitbake/lib/bb/ui/knotty.py", line 864, in main
> > > > >     _, error =3D server.runCommand(["stateForceShutdown"])
> > > > >   File "/srv/oe/bitbake/lib/bb/server/process.py", line 503, in
> > > > > runCommand
> > > > >     self.connection.send(command)
> > > > >   File "/srv/oe/bitbake/lib/bb/server/process.py", line 868, in
> > > > > send
> > > > >     self._send(obj)
> > > > >   File "/srv/oe/bitbake/lib/bb/server/process.py", line 847, in
> > > > > _send
> > > > >     self.writer.send_bytes(obj)
> > > > >   File "/usr/lib/python3.8/multiprocessing/connection.py", line
> > > > > 200,
> > > > > in send_bytes
> > > > >     self._send_bytes(m[offset:offset + size])
> > > > >   File "/usr/lib/python3.8/multiprocessing/connection.py", line
> > > > > 411,
> > > > > in _send_bytes
> > > > >     self._send(header + buf)
> > > > >   File "/usr/lib/python3.8/multiprocessing/connection.py", line
> > > > > 368,
> > > > > in _send
> > > > >     n =3D write(self._handle, buf)
> > > > > BrokenPipeError: [Errno 32] Broken pipe
> > > >
> > > > Those tracebacks are the connection failing. Is there something
> > > > more/different in the bitbake-cookerdaemon.log file?
> > >
> > > Reverting this patch or disabling the custom logger solves the
> > > issue. Next week I will share the cookerdaemon.log file.
> > >
> >
> >
> > I can replicate the issue in a more easy way just running bitbake in
> > debug mode (with one -D) and
> > without any custom BB_LOGCONFIG. The result is the same as before,
> > with this patch reverted all good.
>
> I was able to find a reproducer for what is likely the same issue and
> there is a patch on the bitbake list (and in master-next) to try and
> address this. Can you see if that helps please?
>

Yup, a quick test with -D and the bellow patch solves the issue.

* 49cdfc99 cooker: Avoid variable listing lockups

Thanks for your help.

Jose


>
> Cheers,
>
> Richard
>


--=20
Best regards,

Jos=C3=A9 Quaresma

--0000000000009d8742060b22fccc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Richard Purdie &lt;<a href=3D"mailto:=
richard.purdie@linuxfoundation.org">richard.purdie@linuxfoundation.org</a>&=
gt; escreveu no dia segunda, 27/11/2023 =C3=A0(s) 13:43:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">On Mon, 2023-11-27 at 12:16 +0000,=
 Jose Quaresma wrote:<br>
&gt; <br>
&gt; <br>
&gt; Jose Quaresma via <a href=3D"http://lists.openembedded.org" rel=3D"nor=
eferrer" target=3D"_blank">lists.openembedded.org</a><br>
&gt; &lt;quaresma.jose=3D<a href=3D"mailto:gmail.com@lists.openembedded.org=
" target=3D"_blank">gmail.com@lists.openembedded.org</a>&gt; escreveu no di=
a<br>
&gt; sexta, 24/11/2023 =C3=A0(s) 22:05:<br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; A sexta, 24/11/2023, 20:19, Richard Purdie<br>
&gt; &gt; &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org" target=
=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt; escreveu:<br>
&gt; &gt; &gt; On Fri, 2023-11-24 at 17:27 +0000, Jose Quaresma wrote:<br>
&gt; &gt; &gt; &gt; Hi Richard,<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; I believe=C2=A0I found a regression in this patch.<br>
&gt; &gt; &gt; &gt; When we build with a custom BB_LOGCONFIG configuration,=
 bitbake<br>
&gt; &gt; &gt; &gt; hangs<br>
&gt; &gt; &gt; &gt; at start-up<br>
&gt; &gt; &gt; &gt; in the ping command. Here is my build log:<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; Loading cache...done.<br>
&gt; &gt; &gt; &gt; Loaded 6050 entries from dependency cache.<br>
&gt; &gt; &gt; &gt; (2023-11-24 16:06:39,801) INFO: Resolving any missing t=
ask<br>
&gt; &gt; &gt; &gt; queue<br>
&gt; &gt; &gt; &gt; dependencies<br>
&gt; &gt; &gt; &gt; (2023-11-24 16:06:46,455) Level 21: <br>
&gt; &gt; &gt; &gt; Build Configuration:<br>
&gt; &gt; &gt; &gt; BB_VERSION =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &quot=
;2.6.0&quot;<br>
&gt; &gt; &gt; &gt; BUILD_SYS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D =
&quot;x86_64-linux&quot;<br>
&gt; &gt; &gt; &gt; NATIVELSBSTRING =C2=A0 =C2=A0 =C2=A0=3D &quot;universal=
&quot;<br>
&gt; &gt; &gt; &gt; TARGET_SYS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &quot=
;x86_64-lmp-linux&quot;<br>
&gt; &gt; &gt; &gt; MACHINE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=3D &quot;intel-corei7-64&quot;<br>
&gt; &gt; &gt; &gt; DISTRO =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =3D &quot;lmp&quot;<br>
&gt; &gt; &gt; &gt; DISTRO_VERSION =C2=A0 =C2=A0 =C2=A0 =3D &quot;4.0.14-78=
-91&quot;<br>
&gt; &gt; &gt; &gt; TUNE_FEATURES =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &quot;m64 =
corei7&quot;<br>
&gt; &gt; &gt; &gt; TARGET_FPU =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &quot=
;&quot;<br>
&gt; &gt; &gt; &gt; DISTRO_FEATURES =C2=A0 =C2=A0 =C2=A0=3D &quot;acl argp =
bluetooth ext2 ipv4 ipv6<br>
&gt; &gt; &gt; &gt; largefile<br>
&gt; &gt; &gt; &gt; usbgadget usbhost wifi xattr zeroconf pci vfat modsign =
efi<br>
&gt; &gt; &gt; &gt; security<br>
&gt; &gt; &gt; &gt; tpm integrity seccomp pam usrmerge virtualization alsa =
sota<br>
&gt; &gt; &gt; &gt; systemd<br>
&gt; &gt; &gt; &gt; usrmerge&quot;<br>
&gt; &gt; &gt; &gt; meta-lmp-base =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D<br>
&gt; &gt; &gt; &gt; &quot;HEAD:3a18fbcdb5629b1056c14af2ec72f21bb829893f&quo=
t;<br>
&gt; &gt; &gt; &gt; meta-oe =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0<br>
&gt; &gt; &gt; &gt; meta-networking =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; &gt; meta-filesystems =C2=A0 =C2=A0 <br>
&gt; &gt; &gt; &gt; meta-perl =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; &gt; meta-python =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D<br>
&gt; &gt; &gt; &gt; &quot;HEAD:991e6852a53e0fcd40af8f0386d7f46bb318015e&quo=
t;<br>
&gt; &gt; &gt; &gt; meta-virtualization =C2=A0=3D<br>
&gt; &gt; &gt; &gt; &quot;HEAD:a215d8320edee0a317a6511e7e2efa5bba867486&quo=
t;<br>
&gt; &gt; &gt; &gt; meta-clang =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D<br>
&gt; &gt; &gt; &gt; &quot;HEAD:8aaed8f345683c2fb03a4d90f615f1e93f545a55&quo=
t;<br>
&gt; &gt; &gt; &gt; meta-updater =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D<br>
&gt; &gt; &gt; &gt; &quot;HEAD:defecf4523fe70d38efCompleted (socket: True)<=
br>
&gt; &gt; &gt; &gt; &gt; 365401 12:05:44.152781 Running 0e264b46a38019d6d30=
88&quot;<br>
&gt; &gt; &gt; &gt; meta-security =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; &gt; meta-tpm =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>
&gt; &gt; &gt; &gt; meta-parsec =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; &gt; meta-integrity =C2=A0 =C2=A0 =C2=A0 =3D<br>
&gt; &gt; &gt; &gt; &quot;HEAD:070a1e82cc59424d230a23c0b2a104b01fbaa2ad&quo=
t;<br>
&gt; &gt; &gt; &gt; meta-arm =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>
&gt; &gt; &gt; &gt; meta-arm-toolchain =C2=A0 <br>
&gt; &gt; &gt; &gt; meta-arm-bsp =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D<br>
&gt; &gt; &gt; &gt; &quot;HEAD:5f8b6a2d269c59c21273fee5417f2f0d90a086a1&quo=
t;<br>
&gt; &gt; &gt; &gt; meta-freescale =C2=A0 =C2=A0 =C2=A0 =3D<br>
&gt; &gt; &gt; &gt; &quot;HEAD:d48d230b34292f8c61e5ead75e067fff404fb20c&quo=
t;<br>
&gt; &gt; &gt; &gt; meta-freescale-3rdparty =3D<br>
&gt; &gt; &gt; &gt; &quot;HEAD:a9bba0f7fc3765431433886a3e78632dcfa7ad26&quo=
t;<br>
&gt; &gt; &gt; &gt; meta-raspberrypi =C2=A0 =C2=A0 =3D<br>
&gt; &gt; &gt; &gt; &quot;HEAD:8231f97534812cb0c6ab8d500eff44d3880fdac5&quo=
t;<br>
&gt; &gt; &gt; &gt; meta-intel =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D<br>
&gt; &gt; &gt; &gt; &quot;HEAD:52ce86a7f5f1ed751d80bc5e1d6b76db1c5b84c8&quo=
t;<br>
&gt; &gt; &gt; &gt; meta-yocto-bsp =C2=A0 =C2=A0 =C2=A0 =3D<br>
&gt; &gt; &gt; &gt; &quot;HEAD:5d86975934b46a64b36f60c097bce7a577c1b8b0&quo=
t;<br>
&gt; &gt; &gt; &gt; meta-xilinx-core =C2=A0 =C2=A0 <br>
&gt; &gt; &gt; &gt; meta-xilinx-bsp =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; &gt; meta-xilinx-standalone =3D<br>
&gt; &gt; &gt; &gt; &quot;HEAD:0872170289d08996d821db4d8988647a13063269&quo=
t;<br>
&gt; &gt; &gt; &gt; meta-xilinx-tools =C2=A0 =C2=A0=3D<br>
&gt; &gt; &gt; &gt; &quot;HEAD:65799115a9d3dd53053b08f6f1416ecf879f4898&quo=
t;<br>
&gt; &gt; &gt; &gt; meta-tegra =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D<br>
&gt; &gt; &gt; &gt; &quot;HEAD:fb4c603c504b6df9631f15a4734cbb8c42b1005a&quo=
t;<br>
&gt; &gt; &gt; &gt; meta-ti-bsp =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; &gt; meta-ti-extras =C2=A0 =C2=A0 =C2=A0 =3D<br>
&gt; &gt; &gt; &gt; &quot;HEAD:d3bcad2cbe63d4e1cd2b4e4418d0b3b9c1f864ed&quo=
t;<br>
&gt; &gt; &gt; &gt; meta-lmp-bsp =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D<br>
&gt; &gt; &gt; &gt; &quot;HEAD:3a18fbcdb5629b1056c14af2ec72f21bb829893f&quo=
t;<br>
&gt; &gt; &gt; &gt; meta =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =3D<br>
&gt; &gt; &gt; &gt; &quot;HEAD:795e85f62f3c88c08f24d986548ffe422f459cd0&quo=
t;<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; [Errno 32] Broken pipeTraceback (most recent call last)=
:<br>
&gt; &gt; &gt; &gt; =C2=A0 File &quot;/srv/oe/bitbake/lib/bb/ui/knotty.py&q=
uot;, line 647, in main<br>
&gt; &gt; &gt; &gt; =C2=A0 =C2=A0 ret, error =3D server.runCommand([&quot;p=
ing&quot;])<br>
&gt; &gt; &gt; &gt; =C2=A0 File &quot;/srv/oe/bitbake/lib/bb/server/process=
.py&quot;, line 503, in<br>
&gt; &gt; &gt; &gt; runCommand<br>
&gt; &gt; &gt; &gt; =C2=A0 =C2=A0 self.connection.send(command)<br>
&gt; &gt; &gt; &gt; =C2=A0 File &quot;/srv/oe/bitbake/lib/bb/server/process=
.py&quot;, line 868, in<br>
&gt; &gt; &gt; &gt; send<br>
&gt; &gt; &gt; &gt; =C2=A0 =C2=A0 self._send(obj)<br>
&gt; &gt; &gt; &gt; =C2=A0 File &quot;/srv/oe/bitbake/lib/bb/server/process=
.py&quot;, line 847, in<br>
&gt; &gt; &gt; &gt; _send<br>
&gt; &gt; &gt; &gt; =C2=A0 =C2=A0 self.writer.send_bytes(obj)<br>
&gt; &gt; &gt; &gt; =C2=A0 File &quot;/usr/lib/python3.8/multiprocessing/co=
nnection.py&quot;, line<br>
&gt; &gt; &gt; &gt; 200,<br>
&gt; &gt; &gt; &gt; in send_bytes<br>
&gt; &gt; &gt; &gt; =C2=A0 =C2=A0 self._send_bytes(m[offset:offset + size])=
<br>
&gt; &gt; &gt; &gt; =C2=A0 File &quot;/usr/lib/python3.8/multiprocessing/co=
nnection.py&quot;, line<br>
&gt; &gt; &gt; &gt; 411,<br>
&gt; &gt; &gt; &gt; in _send_bytes<br>
&gt; &gt; &gt; &gt; =C2=A0 =C2=A0 self._send(header + buf)<br>
&gt; &gt; &gt; &gt; =C2=A0 File &quot;/usr/lib/python3.8/multiprocessing/co=
nnection.py&quot;, line<br>
&gt; &gt; &gt; &gt; 368,<br>
&gt; &gt; &gt; &gt; in _send<br>
&gt; &gt; &gt; &gt; =C2=A0 =C2=A0 n =3D write(self._handle, buf)<br>
&gt; &gt; &gt; &gt; BrokenPipeError: [Errno 32] Broken pipe<br>
&gt; &gt; &gt; &gt; During handling of the above exception, another excepti=
on<br>
&gt; &gt; &gt; &gt; occurred:<br>
&gt; &gt; &gt; &gt; Traceback (most recent call last):<br>
&gt; &gt; &gt; &gt; =C2=A0 File &quot;/srv/oe/bitbake/bin/bitbake&quot;, li=
ne 36, in &lt;module&gt;<br>
&gt; &gt; &gt; &gt; =C2=A0 =C2=A0 sys.exit(bitbake_main(BitBakeConfigParame=
ters(sys.argv),<br>
&gt; &gt; &gt; &gt; =C2=A0 File &quot;/srv/oe/bitbake/lib/bb/main.py&quot;,=
 line 404, in<br>
&gt; &gt; &gt; &gt; bitbake_main<br>
&gt; &gt; &gt; &gt; =C2=A0 =C2=A0 return ui_module.main(server_connection.c=
onnection,<br>
&gt; &gt; &gt; &gt; server_connection.events,<br>
&gt; &gt; &gt; &gt; =C2=A0 File &quot;/srv/oe/bitbake/lib/bb/ui/knotty.py&q=
uot;, line 864, in main<br>
&gt; &gt; &gt; &gt; =C2=A0 =C2=A0 _, error =3D server.runCommand([&quot;sta=
teForceShutdown&quot;])<br>
&gt; &gt; &gt; &gt; =C2=A0 File &quot;/srv/oe/bitbake/lib/bb/server/process=
.py&quot;, line 503, in<br>
&gt; &gt; &gt; &gt; runCommand<br>
&gt; &gt; &gt; &gt; =C2=A0 =C2=A0 self.connection.send(command)<br>
&gt; &gt; &gt; &gt; =C2=A0 File &quot;/srv/oe/bitbake/lib/bb/server/process=
.py&quot;, line 868, in<br>
&gt; &gt; &gt; &gt; send<br>
&gt; &gt; &gt; &gt; =C2=A0 =C2=A0 self._send(obj)<br>
&gt; &gt; &gt; &gt; =C2=A0 File &quot;/srv/oe/bitbake/lib/bb/server/process=
.py&quot;, line 847, in<br>
&gt; &gt; &gt; &gt; _send<br>
&gt; &gt; &gt; &gt; =C2=A0 =C2=A0 self.writer.send_bytes(obj)<br>
&gt; &gt; &gt; &gt; =C2=A0 File &quot;/usr/lib/python3.8/multiprocessing/co=
nnection.py&quot;, line<br>
&gt; &gt; &gt; &gt; 200,<br>
&gt; &gt; &gt; &gt; in send_bytes<br>
&gt; &gt; &gt; &gt; =C2=A0 =C2=A0 self._send_bytes(m[offset:offset + size])=
<br>
&gt; &gt; &gt; &gt; =C2=A0 File &quot;/usr/lib/python3.8/multiprocessing/co=
nnection.py&quot;, line<br>
&gt; &gt; &gt; &gt; 411,<br>
&gt; &gt; &gt; &gt; in _send_bytes<br>
&gt; &gt; &gt; &gt; =C2=A0 =C2=A0 self._send(header + buf)<br>
&gt; &gt; &gt; &gt; =C2=A0 File &quot;/usr/lib/python3.8/multiprocessing/co=
nnection.py&quot;, line<br>
&gt; &gt; &gt; &gt; 368,<br>
&gt; &gt; &gt; &gt; in _send<br>
&gt; &gt; &gt; &gt; =C2=A0 =C2=A0 n =3D write(self._handle, buf)<br>
&gt; &gt; &gt; &gt; BrokenPipeError: [Errno 32] Broken pipe<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Those tracebacks are the connection failing. Is there someth=
ing<br>
&gt; &gt; &gt; more/different in the bitbake-cookerdaemon.log file?<br>
&gt; &gt; =C2=A0<br>
&gt; &gt; Reverting this patch or disabling the custom logger solves the<br=
>
&gt; &gt; issue. Next week I will share the cookerdaemon.log file.<br>
&gt; &gt; <br>
&gt; <br>
&gt; <br>
&gt; I can replicate the issue in a more easy way just running bitbake in<b=
r>
&gt; debug mode (with one -D) and<br>
&gt; without=C2=A0any custom BB_LOGCONFIG. The result is the same as before=
,<br>
&gt; with this patch reverted all good.<br>
<br>
I was able to find a reproducer for what is likely the same issue and<br>
there is a patch on the bitbake list (and in master-next) to try and<br>
address this. Can you see if that helps please?<br></blockquote><div><br>Yu=
p, a quick=C2=A0test with -D and the bellow patch solves the issue.<br><br>=
* 49cdfc99 cooker: Avoid variable listing lockups<br><br>Thanks for your he=
lp.<br><br>Jose<br>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
<br>
Cheers,<br>
<br>
Richard<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr">Best regards,<div><br>Jos=C3=A9 Quaresma</div></div></div></=
div>

--0000000000009d8742060b22fccc--

