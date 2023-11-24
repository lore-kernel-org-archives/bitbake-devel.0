Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E084BC61DF4
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 22:05:55 +0000 (UTC)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
 by mx.groups.io with SMTP id smtpd.web11.8083.1700863553143994930
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Nov 2023 14:05:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=BzJv45P8;
 spf=pass (domain: gmail.com, ip: 209.85.222.179, mailfrom: quaresma.jose@gmail.com)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-77d6f853ba0so180688885a.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 Nov 2023 14:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700863552; x=1701468352; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mQGCE5/29ssxRuM6SPbnH6lBCf9OPT2G+cRauTmKs/c=;
        b=BzJv45P8tcIWKkLJ+Pw/vMQiciKqvtvshY0wleu3fsp2rIc567ARSERqxBvD8/rw36
         dYbBz0grWzmMzZkZItApkcJjbrNVy7naQOsJZd2dfkjDShMSCg2BLPrKOSOztzW2+KFH
         qzluM0+D+P+L8Pes5XF1ANR0k/8TRSLQHRdO+1ADMX8olTyy0fbQRKhOLm1JtSLHPYqz
         puNSR+jrj2TMZo/KHO7zvAWKQIuVS+n9AVd6EPYpXgIthhl7U4wZ/o0Um21iIYRgVbVn
         meXadZrWBmognIs9lzTYksxi2I0mOSxUOVM5S20cniicXD4XXhEpZ6aSzcKyx1VD0zjS
         0Ezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700863552; x=1701468352;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mQGCE5/29ssxRuM6SPbnH6lBCf9OPT2G+cRauTmKs/c=;
        b=lJuiptkzwLAJYd1kZm4xBu5FMurOgqY/AT2eaeRo9q7UCH+jktQMLuNX7hgP+QpFAq
         FdBcoNrrRSxjzAb725+M7jWUxweTKyxMcJKyvUYIKeQ7A/BbGl9OT+4nVK6edaodNodq
         lbqQGRy0cnv6OoVIFh7wwxguZVZ9WoIrmNZEeGm4cz+wZUt9HydSrzSi1vyberSedhbt
         XvjSacj66SvWKFN+ciJdhasx6TpMb9Tk4XlIWHzX2OVWvL5JX4KqJAsfnZwSqhxSWP4A
         gGOvvrtq40+OtTYjEJH2dulLqdG/j21mGKWSYxTZ51eV7j7p1Zb/PzEjcwxJj/1NHjTb
         fLXw==
X-Gm-Message-State: AOJu0YxezUc6A+eeqN4jkI7ITMpOSGHvrI9sSvqWpzFHVbKpncPNA9Uv
	AfLBByQwEmt9smGyclMszzdrLWH7pKbyJK0mz3I=
X-Google-Smtp-Source: AGHT+IEA2yvcvIpMH5vADdKk9SRKGtdLoUrEpv4bc3uMeU5KkHpFGag9z/SMbaqURtfBGlP4ljQobvLzLDVPzsuFvJ4=
X-Received: by 2002:a05:620a:c4b:b0:77d:6802:7bf5 with SMTP id
 u11-20020a05620a0c4b00b0077d68027bf5mr11129609qki.9.1700863552038; Fri, 24
 Nov 2023 14:05:52 -0800 (PST)
MIME-Version: 1.0
References: <20231116165233.2862786-1-richard.purdie@linuxfoundation.org>
 <CANPvuR=Nkf1MV6mMf6Z0XWpensaKo4KB6MQvDxUr0ER5=mHKWQ@mail.gmail.com> <63e078f1b4dd53095f00ec3c54c4c420ead9f7ac.camel@linuxfoundation.org>
In-Reply-To: <63e078f1b4dd53095f00ec3c54c4c420ead9f7ac.camel@linuxfoundation.org>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Fri, 24 Nov 2023 22:05:41 +0000
Message-ID: <CANPvuR=GS8JGV8M=BY73tdyQjSvN6geHk7jzicsk+aQ1t9AuAQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] cooker: Add support for BB_DEFAULT_EVENTLOG
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org, 
	Ricardo Salveti <ricardo@foundries.io>
Content-Type: multipart/alternative; boundary="000000000000d4aa8d060aed27d6"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 Nov 2023 22:05:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15570

--000000000000d4aa8d060aed27d6
Content-Type: text/plain; charset="UTF-8"

A sexta, 24/11/2023, 20:19, Richard Purdie <
richard.purdie@linuxfoundation.org> escreveu:

> On Fri, 2023-11-24 at 17:27 +0000, Jose Quaresma wrote:
> > Hi Richard,
> >
> > I believe I found a regression in this patch.
> > When we build with a custom BB_LOGCONFIG configuration, bitbake hangs
> > at start-up
> > in the ping command. Here is my build log:
> >
> > Loading cache...done.
> > Loaded 6050 entries from dependency cache.
> > (2023-11-24 16:06:39,801) INFO: Resolving any missing task queue
> > dependencies
> > (2023-11-24 16:06:46,455) Level 21:
> > Build Configuration:
> > BB_VERSION           = "2.6.0"
> > BUILD_SYS            = "x86_64-linux"
> > NATIVELSBSTRING      = "universal"
> > TARGET_SYS           = "x86_64-lmp-linux"
> > MACHINE              = "intel-corei7-64"
> > DISTRO               = "lmp"
> > DISTRO_VERSION       = "4.0.14-78-91"
> > TUNE_FEATURES        = "m64 corei7"
> > TARGET_FPU           = ""
> > DISTRO_FEATURES      = "acl argp bluetooth ext2 ipv4 ipv6 largefile
> > usbgadget usbhost wifi xattr zeroconf pci vfat modsign efi security
> > tpm integrity seccomp pam usrmerge virtualization alsa sota systemd
> > usrmerge"
> > meta-lmp-base        =
> > "HEAD:3a18fbcdb5629b1056c14af2ec72f21bb829893f"
> > meta-oe
> > meta-networking
> > meta-filesystems
> > meta-perl
> > meta-python          =
> > "HEAD:991e6852a53e0fcd40af8f0386d7f46bb318015e"
> > meta-virtualization  =
> > "HEAD:a215d8320edee0a317a6511e7e2efa5bba867486"
> > meta-clang           =
> > "HEAD:8aaed8f345683c2fb03a4d90f615f1e93f545a55"
> > meta-updater         =
> > "HEAD:defecf4523fe70d38ef0e264b46a38019d6d3088"
> > meta-security
> > meta-tpm
> > meta-parsec
> > meta-integrity       =
> > "HEAD:070a1e82cc59424d230a23c0b2a104b01fbaa2ad"
> > meta-arm
> > meta-arm-toolchain
> > meta-arm-bsp         =
> > "HEAD:5f8b6a2d269c59c21273fee5417f2f0d90a086a1"
> > meta-freescale       =
> > "HEAD:d48d230b34292f8c61e5ead75e067fff404fb20c"
> > meta-freescale-3rdparty =
> > "HEAD:a9bba0f7fc3765431433886a3e78632dcfa7ad26"
> > meta-raspberrypi     =
> > "HEAD:8231f97534812cb0c6ab8d500eff44d3880fdac5"
> > meta-intel           =
> > "HEAD:52ce86a7f5f1ed751d80bc5e1d6b76db1c5b84c8"
> > meta-yocto-bsp       =
> > "HEAD:5d86975934b46a64b36f60c097bce7a577c1b8b0"
> > meta-xilinx-core
> > meta-xilinx-bsp
> > meta-xilinx-standalone =
> > "HEAD:0872170289d08996d821db4d8988647a13063269"
> > meta-xilinx-tools    =
> > "HEAD:65799115a9d3dd53053b08f6f1416ecf879f4898"
> > meta-tegra           =
> > "HEAD:fb4c603c504b6df9631f15a4734cbb8c42b1005a"
> > meta-ti-bsp
> > meta-ti-extras       =
> > "HEAD:d3bcad2cbe63d4e1cd2b4e4418d0b3b9c1f864ed"
> > meta-lmp-bsp         =
> > "HEAD:3a18fbcdb5629b1056c14af2ec72f21bb829893f"
> > meta                 =
> > "HEAD:795e85f62f3c88c08f24d986548ffe422f459cd0"
> >
> > [Errno 32] Broken pipeTraceback (most recent call last):
> >   File "/srv/oe/bitbake/lib/bb/ui/knotty.py", line 647, in main
> >     ret, error = server.runCommand(["ping"])
> >   File "/srv/oe/bitbake/lib/bb/server/process.py", line 503, in
> > runCommand
> >     self.connection.send(command)
> >   File "/srv/oe/bitbake/lib/bb/server/process.py", line 868, in send
> >     self._send(obj)
> >   File "/srv/oe/bitbake/lib/bb/server/process.py", line 847, in _send
> >     self.writer.send_bytes(obj)
> >   File "/usr/lib/python3.8/multiprocessing/connection.py", line 200,
> > in send_bytes
> >     self._send_bytes(m[offset:offset + size])
> >   File "/usr/lib/python3.8/multiprocessing/connection.py", line 411,
> > in _send_bytes
> >     self._send(header + buf)
> >   File "/usr/lib/python3.8/multiprocessing/connection.py", line 368,
> > in _send
> >     n = write(self._handle, buf)
> > BrokenPipeError: [Errno 32] Broken pipe
> > During handling of the above exception, another exception occurred:
> > Traceback (most recent call last):
> >   File "/srv/oe/bitbake/bin/bitbake", line 36, in <module>
> >     sys.exit(bitbake_main(BitBakeConfigParameters(sys.argv),
> >   File "/srv/oe/bitbake/lib/bb/main.py", line 404, in bitbake_main
> >     return ui_module.main(server_connection.connection,
> > server_connection.events,
> >   File "/srv/oe/bitbake/lib/bb/ui/knotty.py", line 864, in main
> >     _, error = server.runCommand(["stateForceShutdown"])
> >   File "/srv/oe/bitbake/lib/bb/server/process.py", line 503, in
> > runCommand
> >     self.connection.send(command)
> >   File "/srv/oe/bitbake/lib/bb/server/process.py", line 868, in send
> >     self._send(obj)
> >   File "/srv/oe/bitbake/lib/bb/server/process.py", line 847, in _send
> >     self.writer.send_bytes(obj)
> >   File "/usr/lib/python3.8/multiprocessing/connection.py", line 200,
> > in send_bytes
> >     self._send_bytes(m[offset:offset + size])
> >   File "/usr/lib/python3.8/multiprocessing/connection.py", line 411,
> > in _send_bytes
> >     self._send(header + buf)
> >   File "/usr/lib/python3.8/multiprocessing/connection.py", line 368,
> > in _send
> >     n = write(self._handle, buf)
> > BrokenPipeError: [Errno 32] Broken pipe
>
> Those tracebacks are the connection failing. Is there something
> more/different in the bitbake-cookerdaemon.log file?
>

Reverting this patch or disabling the custom logger solves the issue. Next
week I will share the cookerdaemon.log file.

Jose


> Cheers,
>
> Richard
>
>
>

--000000000000d4aa8d060aed27d6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">A sexta, 24/11/2023, 20:19, Richard Purdie &lt;<a href=
=3D"mailto:richard.purdie@linuxfoundation.org">richard.purdie@linuxfoundati=
on.org</a>&gt; escreveu:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Fri, =
2023-11-24 at 17:27 +0000, Jose Quaresma wrote:<br>
&gt; Hi Richard,<br>
&gt; <br>
&gt; I believe=C2=A0I found a regression in this patch.<br>
&gt; When we build with a custom BB_LOGCONFIG configuration, bitbake hangs<=
br>
&gt; at start-up<br>
&gt; in the ping command. Here is my build log:<br>
&gt; <br>
&gt; Loading cache...done.<br>
&gt; Loaded 6050 entries from dependency cache.<br>
&gt; (2023-11-24 16:06:39,801) INFO: Resolving any missing task queue<br>
&gt; dependencies<br>
&gt; (2023-11-24 16:06:46,455) Level 21: <br>
&gt; Build Configuration:<br>
&gt; BB_VERSION =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &quot;2.6.0&quot;<br=
>
&gt; BUILD_SYS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &quot;x86_64-li=
nux&quot;<br>
&gt; NATIVELSBSTRING =C2=A0 =C2=A0 =C2=A0=3D &quot;universal&quot;<br>
&gt; TARGET_SYS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &quot;x86_64-lmp-lin=
ux&quot;<br>
&gt; MACHINE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &quot;inte=
l-corei7-64&quot;<br>
&gt; DISTRO =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &quot;lmp&=
quot;<br>
&gt; DISTRO_VERSION =C2=A0 =C2=A0 =C2=A0 =3D &quot;4.0.14-78-91&quot;<br>
&gt; TUNE_FEATURES =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &quot;m64 corei7&quot;<br=
>
&gt; TARGET_FPU =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &quot;&quot;<br>
&gt; DISTRO_FEATURES =C2=A0 =C2=A0 =C2=A0=3D &quot;acl argp bluetooth ext2 =
ipv4 ipv6 largefile<br>
&gt; usbgadget usbhost wifi xattr zeroconf pci vfat modsign efi security<br=
>
&gt; tpm integrity seccomp pam usrmerge virtualization alsa sota systemd<br=
>
&gt; usrmerge&quot;<br>
&gt; meta-lmp-base =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D<br>
&gt; &quot;HEAD:3a18fbcdb5629b1056c14af2ec72f21bb829893f&quot;<br>
&gt; meta-oe =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; meta-networking =C2=A0 =C2=A0 =C2=A0<br>
&gt; meta-filesystems =C2=A0 =C2=A0 <br>
&gt; meta-perl =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; meta-python =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D<br>
&gt; &quot;HEAD:991e6852a53e0fcd40af8f0386d7f46bb318015e&quot;<br>
&gt; meta-virtualization =C2=A0=3D<br>
&gt; &quot;HEAD:a215d8320edee0a317a6511e7e2efa5bba867486&quot;<br>
&gt; meta-clang =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D<br>
&gt; &quot;HEAD:8aaed8f345683c2fb03a4d90f615f1e93f545a55&quot;<br>
&gt; meta-updater =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D<br>
&gt; &quot;HEAD:defecf4523fe70d38ef0e264b46a38019d6d3088&quot;<br>
&gt; meta-security =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; meta-tpm =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>
&gt; meta-parsec =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; meta-integrity =C2=A0 =C2=A0 =C2=A0 =3D<br>
&gt; &quot;HEAD:070a1e82cc59424d230a23c0b2a104b01fbaa2ad&quot;<br>
&gt; meta-arm =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>
&gt; meta-arm-toolchain =C2=A0 <br>
&gt; meta-arm-bsp =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D<br>
&gt; &quot;HEAD:5f8b6a2d269c59c21273fee5417f2f0d90a086a1&quot;<br>
&gt; meta-freescale =C2=A0 =C2=A0 =C2=A0 =3D<br>
&gt; &quot;HEAD:d48d230b34292f8c61e5ead75e067fff404fb20c&quot;<br>
&gt; meta-freescale-3rdparty =3D<br>
&gt; &quot;HEAD:a9bba0f7fc3765431433886a3e78632dcfa7ad26&quot;<br>
&gt; meta-raspberrypi =C2=A0 =C2=A0 =3D<br>
&gt; &quot;HEAD:8231f97534812cb0c6ab8d500eff44d3880fdac5&quot;<br>
&gt; meta-intel =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D<br>
&gt; &quot;HEAD:52ce86a7f5f1ed751d80bc5e1d6b76db1c5b84c8&quot;<br>
&gt; meta-yocto-bsp =C2=A0 =C2=A0 =C2=A0 =3D<br>
&gt; &quot;HEAD:5d86975934b46a64b36f60c097bce7a577c1b8b0&quot;<br>
&gt; meta-xilinx-core =C2=A0 =C2=A0 <br>
&gt; meta-xilinx-bsp =C2=A0 =C2=A0 =C2=A0<br>
&gt; meta-xilinx-standalone =3D<br>
&gt; &quot;HEAD:0872170289d08996d821db4d8988647a13063269&quot;<br>
&gt; meta-xilinx-tools =C2=A0 =C2=A0=3D<br>
&gt; &quot;HEAD:65799115a9d3dd53053b08f6f1416ecf879f4898&quot;<br>
&gt; meta-tegra =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D<br>
&gt; &quot;HEAD:fb4c603c504b6df9631f15a4734cbb8c42b1005a&quot;<br>
&gt; meta-ti-bsp =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; meta-ti-extras =C2=A0 =C2=A0 =C2=A0 =3D<br>
&gt; &quot;HEAD:d3bcad2cbe63d4e1cd2b4e4418d0b3b9c1f864ed&quot;<br>
&gt; meta-lmp-bsp =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D<br>
&gt; &quot;HEAD:3a18fbcdb5629b1056c14af2ec72f21bb829893f&quot;<br>
&gt; meta =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D<br>
&gt; &quot;HEAD:795e85f62f3c88c08f24d986548ffe422f459cd0&quot;<br>
&gt; <br>
&gt; [Errno 32] Broken pipeTraceback (most recent call last):<br>
&gt; =C2=A0 File &quot;/srv/oe/bitbake/lib/bb/ui/knotty.py&quot;, line 647,=
 in main<br>
&gt; =C2=A0 =C2=A0 ret, error =3D server.runCommand([&quot;ping&quot;])<br>
&gt; =C2=A0 File &quot;/srv/oe/bitbake/lib/bb/server/process.py&quot;, line=
 503, in<br>
&gt; runCommand<br>
&gt; =C2=A0 =C2=A0 self.connection.send(command)<br>
&gt; =C2=A0 File &quot;/srv/oe/bitbake/lib/bb/server/process.py&quot;, line=
 868, in send<br>
&gt; =C2=A0 =C2=A0 self._send(obj)<br>
&gt; =C2=A0 File &quot;/srv/oe/bitbake/lib/bb/server/process.py&quot;, line=
 847, in _send<br>
&gt; =C2=A0 =C2=A0 self.writer.send_bytes(obj)<br>
&gt; =C2=A0 File &quot;/usr/lib/python3.8/multiprocessing/connection.py&quo=
t;, line 200,<br>
&gt; in send_bytes<br>
&gt; =C2=A0 =C2=A0 self._send_bytes(m[offset:offset + size])<br>
&gt; =C2=A0 File &quot;/usr/lib/python3.8/multiprocessing/connection.py&quo=
t;, line 411,<br>
&gt; in _send_bytes<br>
&gt; =C2=A0 =C2=A0 self._send(header + buf)<br>
&gt; =C2=A0 File &quot;/usr/lib/python3.8/multiprocessing/connection.py&quo=
t;, line 368,<br>
&gt; in _send<br>
&gt; =C2=A0 =C2=A0 n =3D write(self._handle, buf)<br>
&gt; BrokenPipeError: [Errno 32] Broken pipe<br>
&gt; During handling of the above exception, another exception occurred:<br=
>
&gt; Traceback (most recent call last):<br>
&gt; =C2=A0 File &quot;/srv/oe/bitbake/bin/bitbake&quot;, line 36, in &lt;m=
odule&gt;<br>
&gt; =C2=A0 =C2=A0 sys.exit(bitbake_main(BitBakeConfigParameters(sys.argv),=
<br>
&gt; =C2=A0 File &quot;/srv/oe/bitbake/lib/bb/main.py&quot;, line 404, in b=
itbake_main<br>
&gt; =C2=A0 =C2=A0 return ui_module.main(server_connection.connection,<br>
&gt; server_connection.events,<br>
&gt; =C2=A0 File &quot;/srv/oe/bitbake/lib/bb/ui/knotty.py&quot;, line 864,=
 in main<br>
&gt; =C2=A0 =C2=A0 _, error =3D server.runCommand([&quot;stateForceShutdown=
&quot;])<br>
&gt; =C2=A0 File &quot;/srv/oe/bitbake/lib/bb/server/process.py&quot;, line=
 503, in<br>
&gt; runCommand<br>
&gt; =C2=A0 =C2=A0 self.connection.send(command)<br>
&gt; =C2=A0 File &quot;/srv/oe/bitbake/lib/bb/server/process.py&quot;, line=
 868, in send<br>
&gt; =C2=A0 =C2=A0 self._send(obj)<br>
&gt; =C2=A0 File &quot;/srv/oe/bitbake/lib/bb/server/process.py&quot;, line=
 847, in _send<br>
&gt; =C2=A0 =C2=A0 self.writer.send_bytes(obj)<br>
&gt; =C2=A0 File &quot;/usr/lib/python3.8/multiprocessing/connection.py&quo=
t;, line 200,<br>
&gt; in send_bytes<br>
&gt; =C2=A0 =C2=A0 self._send_bytes(m[offset:offset + size])<br>
&gt; =C2=A0 File &quot;/usr/lib/python3.8/multiprocessing/connection.py&quo=
t;, line 411,<br>
&gt; in _send_bytes<br>
&gt; =C2=A0 =C2=A0 self._send(header + buf)<br>
&gt; =C2=A0 File &quot;/usr/lib/python3.8/multiprocessing/connection.py&quo=
t;, line 368,<br>
&gt; in _send<br>
&gt; =C2=A0 =C2=A0 n =3D write(self._handle, buf)<br>
&gt; BrokenPipeError: [Errno 32] Broken pipe<br>
<br>
Those tracebacks are the connection failing. Is there something<br>
more/different in the bitbake-cookerdaemon.log file?<br></blockquote></div>=
</div><div dir=3D"auto">=C2=A0</div><div dir=3D"auto">Reverting this patch =
or disabling the custom logger solves the issue. Next week I will share the=
 cookerdaemon.log file.</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
Jose</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail=
_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex"><br>
Cheers,<br>
<br>
Richard<br>
<br>
<br>
</blockquote></div></div></div>

--000000000000d4aa8d060aed27d6--

