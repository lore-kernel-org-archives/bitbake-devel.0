Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AECC61DF4
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 17:27:49 +0000 (UTC)
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
 by mx.groups.io with SMTP id smtpd.web10.144757.1700846861153172715
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Nov 2023 09:27:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=LHKxiOGr;
 spf=pass (domain: gmail.com, ip: 209.85.161.47, mailfrom: quaresma.jose@gmail.com)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-58ceabd7cdeso1111261eaf.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 Nov 2023 09:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700846860; x=1701451660; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b50bcX5rBfs/b/t2KOFI6y98OqExjidQav82Y9MMXIM=;
        b=LHKxiOGrPV4mqZGjcAmYEWoCUNoCgqsWoUzpVSOKIViESGnPj1z189kx11h4zXmO0B
         6kpM48peXJ9hm7LPlDohs1eCQdVGT9CpLSMuxAExM420vOmi8QZokpd7FD6bSGYQqzuc
         fj5Kt+UlQY3RZuUvNqYs85Dbj+l04PAnrhBGDcUl6AQOxOIVPfDVJir/E029ULTolP1W
         SHHkTCMa2Ss6YJBY6F4gYszaa33AeR1QMOrIL05s+cVgomlbJiZNnbYTG9y1h+Y4/7yQ
         Kc7hrAMnzvh4xD4ptHb+X1wAOGFYWCuvuVxjjlwn+ObG+rzDKX/kz3EHiFuciq7bPOg5
         0lGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700846860; x=1701451660;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b50bcX5rBfs/b/t2KOFI6y98OqExjidQav82Y9MMXIM=;
        b=AZjiotaGqw0302LV65Ho4KnfbSBqJ4k0Q9byRCA0vzXzl/s2cukPO5pSgDyTHliKkK
         /ZTFPH+p+ZgebQdtWSWM3BfMEnQuSANZXDEwoQCV7Pz29a6cDCXxgCYov7Ke5jhzBKoF
         p2QgCuHvsgVLpay2xOWmwYshCW7dROaXzWk+eLjfBwSG5sgl/fzehgpMidlfg9fgoJle
         +tYKNLO+WL2/OoiH/23FnuzKM4ACXfGTXDqzyfG8JXtqWqfUaemTWKZtwEDVnNIfU4XF
         pIMezOiigxKp5JPs/5XuQr6hff4+oE2zxXxXY0TtZPNbs+DAUGvuJLM8i12m5VQlotVm
         UJbQ==
X-Gm-Message-State: AOJu0YzV5SmpSgqFMKm8MiE1INBs88IrXplFc5LNz8XlJ23RFfKqyaUD
	d8SIwD7IlPdibU2gxunoEbUCgjefqV6UwQr/CaFqVl4B
X-Google-Smtp-Source: AGHT+IHwWmA0AOAmJrybO3Am9QcTlr0y2rCNBTaNMTSjJumkUTGRwq1mpuCcxzHIQdZJ1kal+i2wEZYo1Km5KuQRoZg=
X-Received: by 2002:a05:6358:3102:b0:16d:fb6c:e65e with SMTP id
 c2-20020a056358310200b0016dfb6ce65emr3439489rwe.7.1700846860174; Fri, 24 Nov
 2023 09:27:40 -0800 (PST)
MIME-Version: 1.0
References: <20231116165233.2862786-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20231116165233.2862786-1-richard.purdie@linuxfoundation.org>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Fri, 24 Nov 2023 17:27:29 +0000
Message-ID: <CANPvuR=Nkf1MV6mMf6Z0XWpensaKo4KB6MQvDxUr0ER5=mHKWQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] cooker: Add support for BB_DEFAULT_EVENTLOG
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org, 
	Ricardo Salveti <ricardo@foundries.io>
Content-Type: multipart/alternative; boundary="000000000000eb0b26060ae944df"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 Nov 2023 17:27:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15568

--000000000000eb0b26060ae944df
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Richard,

I believe I found a regression in this patch.
When we build with a custom BB_LOGCONFIG configuration, bitbake hangs at
start-up
in the ping command. Here is my build log:

Loading cache...done.
Loaded 6050 entries from dependency cache.
(2023-11-24 16:06:39,801) INFO: Resolving any missing task queue
dependencies
(2023-11-24 16:06:46,455) Level 21:
Build Configuration:
BB_VERSION           =3D "2.6.0"
BUILD_SYS            =3D "x86_64-linux"
NATIVELSBSTRING      =3D "universal"
TARGET_SYS           =3D "x86_64-lmp-linux"
MACHINE              =3D "intel-corei7-64"
DISTRO               =3D "lmp"
DISTRO_VERSION       =3D "4.0.14-78-91"
TUNE_FEATURES        =3D "m64 corei7"
TARGET_FPU           =3D ""
DISTRO_FEATURES      =3D "acl argp bluetooth ext2 ipv4 ipv6 largefile
usbgadget usbhost wifi xattr zeroconf pci vfat modsign efi security tpm
integrity seccomp pam usrmerge virtualization alsa sota systemd usrmerge"
meta-lmp-base        =3D "HEAD:3a18fbcdb5629b1056c14af2ec72f21bb829893f"
meta-oe
meta-networking
meta-filesystems
meta-perl
meta-python          =3D "HEAD:991e6852a53e0fcd40af8f0386d7f46bb318015e"
meta-virtualization  =3D "HEAD:a215d8320edee0a317a6511e7e2efa5bba867486"
meta-clang           =3D "HEAD:8aaed8f345683c2fb03a4d90f615f1e93f545a55"
meta-updater         =3D "HEAD:defecf4523fe70d38ef0e264b46a38019d6d3088"
meta-security
meta-tpm
meta-parsec
meta-integrity       =3D "HEAD:070a1e82cc59424d230a23c0b2a104b01fbaa2ad"
meta-arm
meta-arm-toolchain
meta-arm-bsp         =3D "HEAD:5f8b6a2d269c59c21273fee5417f2f0d90a086a1"
meta-freescale       =3D "HEAD:d48d230b34292f8c61e5ead75e067fff404fb20c"
meta-freescale-3rdparty =3D "HEAD:a9bba0f7fc3765431433886a3e78632dcfa7ad26"
meta-raspberrypi     =3D "HEAD:8231f97534812cb0c6ab8d500eff44d3880fdac5"
meta-intel           =3D "HEAD:52ce86a7f5f1ed751d80bc5e1d6b76db1c5b84c8"
meta-yocto-bsp       =3D "HEAD:5d86975934b46a64b36f60c097bce7a577c1b8b0"
meta-xilinx-core
meta-xilinx-bsp
meta-xilinx-standalone =3D "HEAD:0872170289d08996d821db4d8988647a13063269"
meta-xilinx-tools    =3D "HEAD:65799115a9d3dd53053b08f6f1416ecf879f4898"
meta-tegra           =3D "HEAD:fb4c603c504b6df9631f15a4734cbb8c42b1005a"
meta-ti-bsp
meta-ti-extras       =3D "HEAD:d3bcad2cbe63d4e1cd2b4e4418d0b3b9c1f864ed"
meta-lmp-bsp         =3D "HEAD:3a18fbcdb5629b1056c14af2ec72f21bb829893f"
meta                 =3D "HEAD:795e85f62f3c88c08f24d986548ffe422f459cd0"

[Errno 32] Broken pipeTraceback (most recent call last):
  File "/srv/oe/bitbake/lib/bb/ui/knotty.py", line 647, in main
    ret, error =3D server.runCommand(["ping"])
  File "/srv/oe/bitbake/lib/bb/server/process.py", line 503, in runCommand
    self.connection.send(command)
  File "/srv/oe/bitbake/lib/bb/server/process.py", line 868, in send
    self._send(obj)
  File "/srv/oe/bitbake/lib/bb/server/process.py", line 847, in _send
    self.writer.send_bytes(obj)
  File "/usr/lib/python3.8/multiprocessing/connection.py", line 200, in
send_bytes
    self._send_bytes(m[offset:offset + size])
  File "/usr/lib/python3.8/multiprocessing/connection.py", line 411, in
_send_bytes
    self._send(header + buf)
  File "/usr/lib/python3.8/multiprocessing/connection.py", line 368, in
_send
    n =3D write(self._handle, buf)
BrokenPipeError: [Errno 32] Broken pipe
During handling of the above exception, another exception occurred:
Traceback (most recent call last):
  File "/srv/oe/bitbake/bin/bitbake", line 36, in <module>
    sys.exit(bitbake_main(BitBakeConfigParameters(sys.argv),
  File "/srv/oe/bitbake/lib/bb/main.py", line 404, in bitbake_main
    return ui_module.main(server_connection.connection,
server_connection.events,
  File "/srv/oe/bitbake/lib/bb/ui/knotty.py", line 864, in main
    _, error =3D server.runCommand(["stateForceShutdown"])
  File "/srv/oe/bitbake/lib/bb/server/process.py", line 503, in runCommand
    self.connection.send(command)
  File "/srv/oe/bitbake/lib/bb/server/process.py", line 868, in send
    self._send(obj)
  File "/srv/oe/bitbake/lib/bb/server/process.py", line 847, in _send
    self.writer.send_bytes(obj)
  File "/usr/lib/python3.8/multiprocessing/connection.py", line 200, in
send_bytes
    self._send_bytes(m[offset:offset + size])
  File "/usr/lib/python3.8/multiprocessing/connection.py", line 411, in
_send_bytes
    self._send(header + buf)
  File "/usr/lib/python3.8/multiprocessing/connection.py", line 368, in
_send
    n =3D write(self._handle, buf)
BrokenPipeError: [Errno 32] Broken pipe

Cheers,

Jose

Richard Purdie <richard.purdie@linuxfoundation.org> escreveu no dia quinta,
16/11/2023 =C3=A0(s) 16:52:

> Currently it is only possible to specify an eventlog on the bitbake
> commandline. Add a variable that can be used in bitbake.conf so that
> we can log data by default more easily.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/cooker.py | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> index 4bf1809bc0..9f84030962 100644
> --- a/lib/bb/cooker.py
> +++ b/lib/bb/cooker.py
> @@ -303,6 +303,10 @@ class BBCooker:
>          self.data_hash =3D self.databuilder.data_hash
>          self.extraconfigdata =3D {}
>
> +        eventlog =3D self.data.getVar("BB_DEFAULT_EVENTLOG")
> +        if not self.configuration.writeeventlog and eventlog:
> +            self.setupEventLog(eventlog)
> +
>          if consolelog:
>              self.data.setVar("BB_CONSOLELOG", consolelog)
>
> @@ -409,6 +413,18 @@ class BBCooker:
>
>          self._parsecache_set(False)
>
> +    def setupEventLog(self, eventlog):
> +        if self.eventlog and self.eventlog[0] !=3D eventlog:
> +            bb.event.unregister_UIHhandler(self.eventlog[1])
> +        if not self.eventlog or self.eventlog[0] !=3D eventlog:
> +            # we log all events to a file if so directed
> +            # register the log file writer as UI Handler
> +            if not os.path.exists(os.path.dirname(eventlog)):
> +                bb.utils.mkdirhier(os.path.dirname(eventlog))
> +            writer =3D EventWriter(self, eventlog)
> +            EventLogWriteHandler =3D namedtuple('EventLogWriteHandler',
> ['event'])
> +            self.eventlog =3D (eventlog,
> bb.event.register_UIHhandler(EventLogWriteHandler(writer)))
> +
>      def updateConfigOpts(self, options, environment, cmdline):
>          self.ui_cmdline =3D cmdline
>          clean =3D True
> @@ -428,14 +444,7 @@ class BBCooker:
>                  setattr(self.configuration, o, options[o])
>
>          if self.configuration.writeeventlog:
> -            if self.eventlog and self.eventlog[0] !=3D
> self.configuration.writeeventlog:
> -                bb.event.unregister_UIHhandler(self.eventlog[1])
> -            if not self.eventlog or self.eventlog[0] !=3D
> self.configuration.writeeventlog:
> -                # we log all events to a file if so directed
> -                # register the log file writer as UI Handler
> -                writer =3D EventWriter(self,
> self.configuration.writeeventlog)
> -                EventLogWriteHandler =3D namedtuple('EventLogWriteHandle=
r',
> ['event'])
> -                self.eventlog =3D (self.configuration.writeeventlog,
> bb.event.register_UIHhandler(EventLogWriteHandler(writer)))
> +            self.setupEventLog(self.configuration.writeeventlog)
>
>          bb.msg.loggerDefaultLogLevel =3D self.configuration.default_logl=
evel
>          bb.msg.loggerDefaultDomains =3D self.configuration.debug_domains
> --
> 2.39.2
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15531):
> https://lists.openembedded.org/g/bitbake-devel/message/15531
> Mute This Topic: https://lists.openembedded.org/mt/102630301/5052612
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe:
> https://lists.openembedded.org/g/bitbake-devel/leave/10441984/5052612/190=
1433512/xyzzy
> [quaresma.jose@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--=20
Best regards,

Jos=C3=A9 Quaresma

--000000000000eb0b26060ae944df
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Richard,<br><br>I believe=C2=A0I found a regressio=
n in this patch.<br>When we build with a custom BB_LOGCONFIG configuration,=
 bitbake hangs at start-up</div><div>in the ping command. Here is my build =
log:<br><br>Loading cache...done.<br>Loaded 6050 entries from dependency ca=
che.<br>(2023-11-24 16:06:39,801) INFO: Resolving any missing task queue de=
pendencies<br>(2023-11-24 16:06:46,455) Level 21: <br>Build Configuration:<=
br>BB_VERSION =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &quot;2.6.0&quot;<br>B=
UILD_SYS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &quot;x86_64-linux&qu=
ot;<br>NATIVELSBSTRING =C2=A0 =C2=A0 =C2=A0=3D &quot;universal&quot;<br>TAR=
GET_SYS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &quot;x86_64-lmp-linux&quot;=
<br>MACHINE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &quot;intel=
-corei7-64&quot;<br>DISTRO =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =3D &quot;lmp&quot;<br>DISTRO_VERSION =C2=A0 =C2=A0 =C2=A0 =3D &quot;4.0.1=
4-78-91&quot;<br>TUNE_FEATURES =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &quot;m64 cor=
ei7&quot;<br>TARGET_FPU =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &quot;&quot;=
<br>DISTRO_FEATURES =C2=A0 =C2=A0 =C2=A0=3D &quot;acl argp bluetooth ext2 i=
pv4 ipv6 largefile usbgadget usbhost wifi xattr zeroconf pci vfat modsign e=
fi security tpm integrity seccomp pam usrmerge virtualization alsa sota sys=
temd usrmerge&quot;<br>meta-lmp-base =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &quot;H=
EAD:3a18fbcdb5629b1056c14af2ec72f21bb829893f&quot;<br>meta-oe =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>meta-networking =C2=A0 =C2=A0 =C2=A0=
<br>meta-filesystems =C2=A0 =C2=A0 <br>meta-perl =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0<br>meta-python =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &quo=
t;HEAD:991e6852a53e0fcd40af8f0386d7f46bb318015e&quot;<br>meta-virtualizatio=
n =C2=A0=3D &quot;HEAD:a215d8320edee0a317a6511e7e2efa5bba867486&quot;<br>me=
ta-clang =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &quot;HEAD:8aaed8f345683c2f=
b03a4d90f615f1e93f545a55&quot;<br>meta-updater =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=3D &quot;HEAD:defecf4523fe70d38ef0e264b46a38019d6d3088&quot;<br>meta-secur=
ity =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>meta-tpm =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 <br>meta-parsec =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>meta-integ=
rity =C2=A0 =C2=A0 =C2=A0 =3D &quot;HEAD:070a1e82cc59424d230a23c0b2a104b01f=
baa2ad&quot;<br>meta-arm =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>meta=
-arm-toolchain =C2=A0 <br>meta-arm-bsp =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &quo=
t;HEAD:5f8b6a2d269c59c21273fee5417f2f0d90a086a1&quot;<br>meta-freescale =C2=
=A0 =C2=A0 =C2=A0 =3D &quot;HEAD:d48d230b34292f8c61e5ead75e067fff404fb20c&q=
uot;<br>meta-freescale-3rdparty =3D &quot;HEAD:a9bba0f7fc3765431433886a3e78=
632dcfa7ad26&quot;<br>meta-raspberrypi =C2=A0 =C2=A0 =3D &quot;HEAD:8231f97=
534812cb0c6ab8d500eff44d3880fdac5&quot;<br>meta-intel =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =3D &quot;HEAD:52ce86a7f5f1ed751d80bc5e1d6b76db1c5b84c8&quot;=
<br>meta-yocto-bsp =C2=A0 =C2=A0 =C2=A0 =3D &quot;HEAD:5d86975934b46a64b36f=
60c097bce7a577c1b8b0&quot;<br>meta-xilinx-core =C2=A0 =C2=A0 <br>meta-xilin=
x-bsp =C2=A0 =C2=A0 =C2=A0<br>meta-xilinx-standalone =3D &quot;HEAD:0872170=
289d08996d821db4d8988647a13063269&quot;<br>meta-xilinx-tools =C2=A0 =C2=A0=
=3D &quot;HEAD:65799115a9d3dd53053b08f6f1416ecf879f4898&quot;<br>meta-tegra=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &quot;HEAD:fb4c603c504b6df9631f15a4=
734cbb8c42b1005a&quot;<br>meta-ti-bsp =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br=
>meta-ti-extras =C2=A0 =C2=A0 =C2=A0 =3D &quot;HEAD:d3bcad2cbe63d4e1cd2b4e4=
418d0b3b9c1f864ed&quot;<br>meta-lmp-bsp =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &qu=
ot;HEAD:3a18fbcdb5629b1056c14af2ec72f21bb829893f&quot;<br>meta =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &quot;HEAD:795e85f62f3c88=
c08f24d986548ffe422f459cd0&quot;<br><br></div><div>[Errno 32] Broken pipeTr=
aceback (most recent call last):<br>=C2=A0 File &quot;/srv/oe/bitbake/lib/b=
b/ui/knotty.py&quot;, line 647, in main<br>=C2=A0 =C2=A0 ret, error =3D ser=
ver.runCommand([&quot;ping&quot;])<br>=C2=A0 File &quot;/srv/oe/bitbake/lib=
/bb/server/process.py&quot;, line 503, in runCommand<br>=C2=A0 =C2=A0 self.=
connection.send(command)<br>=C2=A0 File &quot;/srv/oe/bitbake/lib/bb/server=
/process.py&quot;, line 868, in send<br>=C2=A0 =C2=A0 self._send(obj)<br>=
=C2=A0 File &quot;/srv/oe/bitbake/lib/bb/server/process.py&quot;, line 847,=
 in _send<br>=C2=A0 =C2=A0 self.writer.send_bytes(obj)<br>=C2=A0 File &quot=
;/usr/lib/python3.8/multiprocessing/connection.py&quot;, line 200, in send_=
bytes<br>=C2=A0 =C2=A0 self._send_bytes(m[offset:offset + size])<br>=C2=A0 =
File &quot;/usr/lib/python3.8/multiprocessing/connection.py&quot;, line 411=
, in _send_bytes<br>=C2=A0 =C2=A0 self._send(header + buf)<br>=C2=A0 File &=
quot;/usr/lib/python3.8/multiprocessing/connection.py&quot;, line 368, in _=
send<br>=C2=A0 =C2=A0 n =3D write(self._handle, buf)<br>BrokenPipeError: [E=
rrno 32] Broken pipe<br>During handling of the above exception, another exc=
eption occurred:<br>Traceback (most recent call last):<br>=C2=A0 File &quot=
;/srv/oe/bitbake/bin/bitbake&quot;, line 36, in &lt;module&gt;<br>=C2=A0 =
=C2=A0 sys.exit(bitbake_main(BitBakeConfigParameters(sys.argv),<br>=C2=A0 F=
ile &quot;/srv/oe/bitbake/lib/bb/main.py&quot;, line 404, in bitbake_main<b=
r>=C2=A0 =C2=A0 return ui_module.main(server_connection.connection, server_=
connection.events,<br>=C2=A0 File &quot;/srv/oe/bitbake/lib/bb/ui/knotty.py=
&quot;, line 864, in main<br>=C2=A0 =C2=A0 _, error =3D server.runCommand([=
&quot;stateForceShutdown&quot;])<br>=C2=A0 File &quot;/srv/oe/bitbake/lib/b=
b/server/process.py&quot;, line 503, in runCommand<br>=C2=A0 =C2=A0 self.co=
nnection.send(command)<br>=C2=A0 File &quot;/srv/oe/bitbake/lib/bb/server/p=
rocess.py&quot;, line 868, in send<br>=C2=A0 =C2=A0 self._send(obj)<br>=C2=
=A0 File &quot;/srv/oe/bitbake/lib/bb/server/process.py&quot;, line 847, in=
 _send<br>=C2=A0 =C2=A0 self.writer.send_bytes(obj)<br>=C2=A0 File &quot;/u=
sr/lib/python3.8/multiprocessing/connection.py&quot;, line 200, in send_byt=
es<br>=C2=A0 =C2=A0 self._send_bytes(m[offset:offset + size])<br>=C2=A0 Fil=
e &quot;/usr/lib/python3.8/multiprocessing/connection.py&quot;, line 411, i=
n _send_bytes<br>=C2=A0 =C2=A0 self._send(header + buf)<br>=C2=A0 File &quo=
t;/usr/lib/python3.8/multiprocessing/connection.py&quot;, line 368, in _sen=
d<br>=C2=A0 =C2=A0 n =3D write(self._handle, buf)<br>BrokenPipeError: [Errn=
o 32] Broken pipe<br><br>Cheers,<br><br>Jose<br><br></div><div class=3D"gma=
il_quote"><div dir=3D"ltr" class=3D"gmail_attr">Richard Purdie &lt;<a href=
=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.pu=
rdie@linuxfoundation.org</a>&gt; escreveu no dia quinta, 16/11/2023 =C3=A0(=
s) 16:52:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Curren=
tly it is only possible to specify an eventlog on the bitbake<br>
commandline. Add a variable that can be used in bitbake.conf so that<br>
we can log data by default more easily.<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;<b=
r>
---<br>
=C2=A0lib/bb/cooker.py | 25 +++++++++++++++++--------<br>
=C2=A01 file changed, 17 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py<br>
index 4bf1809bc0..9f84030962 100644<br>
--- a/lib/bb/cooker.py<br>
+++ b/lib/bb/cooker.py<br>
@@ -303,6 +303,10 @@ class BBCooker:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.data_hash =3D self.databuilder.data_=
hash<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.extraconfigdata =3D {}<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 eventlog =3D self.data.getVar(&quot;BB_DEFAULT=
_EVENTLOG&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not self.configuration.writeeventlog and ev=
entlog:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.setupEventLog(eventlog)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if consolelog:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.data.setVar(&quot;BB_C=
ONSOLELOG&quot;, consolelog)<br>
<br>
@@ -409,6 +413,18 @@ class BBCooker:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._parsecache_set(False)<br>
<br>
+=C2=A0 =C2=A0 def setupEventLog(self, eventlog):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.eventlog and self.eventlog[0] !=3D eve=
ntlog:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.event.unregister_UIHhandler(s=
elf.eventlog[1])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not self.eventlog or self.eventlog[0] !=3D =
eventlog:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # we log all events to a file if=
 so directed<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # register the log file writer a=
s UI Handler<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not os.path.exists(os.path.di=
rname(eventlog)):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.utils.mkdirhier=
(os.path.dirname(eventlog))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 writer =3D EventWriter(self, eve=
ntlog)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 EventLogWriteHandler =3D namedtu=
ple(&#39;EventLogWriteHandler&#39;, [&#39;event&#39;])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.eventlog =3D (eventlog, bb.=
event.register_UIHhandler(EventLogWriteHandler(writer)))<br>
+<br>
=C2=A0 =C2=A0 =C2=A0def updateConfigOpts(self, options, environment, cmdlin=
e):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.ui_cmdline =3D cmdline<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clean =3D True<br>
@@ -428,14 +444,7 @@ class BBCooker:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0setattr(self.=
configuration, o, options[o])<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.configuration.writeeventlog:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.eventlog and self.eventl=
og[0] !=3D self.configuration.writeeventlog:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.event.unregiste=
r_UIHhandler(self.eventlog[1])<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not self.eventlog or self.eve=
ntlog[0] !=3D self.configuration.writeeventlog:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # we log all event=
s to a file if so directed<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # register the log=
 file writer as UI Handler<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 writer =3D EventWr=
iter(self, self.configuration.writeeventlog)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 EventLogWriteHandl=
er =3D namedtuple(&#39;EventLogWriteHandler&#39;, [&#39;event&#39;])<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.eventlog =3D =
(self.configuration.writeeventlog, bb.event.register_UIHhandler(EventLogWri=
teHandler(writer)))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.setupEventLog(self.configur=
ation.writeeventlog)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.msg.loggerDefaultLogLevel =3D self.con=
figuration.default_loglevel<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.msg.loggerDefaultDomains =3D self.conf=
iguration.debug_domains<br>
-- <br>
2.39.2<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#15531): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/15531" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/15531</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/102630301/505=
2612" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/102630301/5052612</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/leav=
e/10441984/5052612/1901433512/xyzzy" rel=3D"noreferrer" target=3D"_blank">h=
ttps://lists.openembedded.org/g/bitbake-devel/leave/10441984/5052612/190143=
3512/xyzzy</a> [<a href=3D"mailto:quaresma.jose@gmail.com" target=3D"_blank=
">quaresma.jose@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr">Best regards,<div><br>Jos=C3=A9 Quaresma</div></div></div></=
div>

--000000000000eb0b26060ae944df--

