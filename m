Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F716C61DF4
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 20:20:05 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web10.5342.1700857199428011673
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Nov 2023 12:19:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=g7Cfoy6U;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4083f613275so16846205e9.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 Nov 2023 12:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1700857198; x=1701461998; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UdmfmcQfPhf5rhmGRH7Hk49sTVylcxu9/0UqgsXHNaQ=;
        b=g7Cfoy6Umhv5rsYUps51bTpaPxHLA8El6nYupEnkSc6EG+vRYH+zNezwvjDEtUCw5P
         UPMtVcZsYBQq0HQLWngoYc0TA7vbuWUhlleyRReRP1nnD0Tuof4UlQ/LJYqRuAT4ntw7
         piqim0i9c2ZwSg6WbQXgwIWg3ytipve3k3G8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700857198; x=1701461998;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UdmfmcQfPhf5rhmGRH7Hk49sTVylcxu9/0UqgsXHNaQ=;
        b=Re2VbHcu5A3cySTeNQK/DY9HNtE+YryOjftbbX86+yjQP0TVe0y1vZANrMG3YiUTWA
         cI+jSkO0lXjA87MJYIjuYmuFbA8DQ4Z5VvYxMXXvau0pRj2YRcMi0iBtIu0k1qXZ/GuX
         lK8pWArEQO+CoHQFbvixncQs/bGVuvRFKujnmMHn3XweAUg39DAdgAMyTJibsqjrorrM
         HV0Qjku/vzaYNRqwedMAfJ5zYhsdQPDbzQi3v1g/aNTp4fOx2Qp+bsYGi5etBCOkmDO3
         /H8WM9ICIlnVXdrmWbKxhm8TuorpdW4FI3JKoeQdHs6opihVmHWNp6j6e5T0LbqbYyPM
         Okhw==
X-Gm-Message-State: AOJu0Yz8P5T23CoCQO4ZPQ2/LbNgPD0+1y/ycN857CCgHBn93+ezi2M9
	a55gF3iVD0PGrMzILZQ0O7V9Aw==
X-Google-Smtp-Source: AGHT+IHWR2Vgm2nqne1VJw891byv4Y+xNUQen2X0z+xSxJ+XFcYk6rIL4M2CbUorwEGK/0eTww4s4g==
X-Received: by 2002:a05:600c:46cf:b0:40a:44c0:fd43 with SMTP id q15-20020a05600c46cf00b0040a44c0fd43mr3067157wmo.17.1700857197750;
        Fri, 24 Nov 2023 12:19:57 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:2b4d:5aea:2d30:c0d3? ([2001:8b0:aba:5f3c:2b4d:5aea:2d30:c0d3])
        by smtp.gmail.com with ESMTPSA id n6-20020a05600c3b8600b0040b2ab2b352sm5842357wms.1.2023.11.24.12.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 12:19:57 -0800 (PST)
Message-ID: <63e078f1b4dd53095f00ec3c54c4c420ead9f7ac.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] cooker: Add support for
 BB_DEFAULT_EVENTLOG
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Jose Quaresma <quaresma.jose@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, Ricardo Salveti
 <ricardo@foundries.io>
Date: Fri, 24 Nov 2023 20:19:56 +0000
In-Reply-To: <CANPvuR=Nkf1MV6mMf6Z0XWpensaKo4KB6MQvDxUr0ER5=mHKWQ@mail.gmail.com>
References: <20231116165233.2862786-1-richard.purdie@linuxfoundation.org>
	 <CANPvuR=Nkf1MV6mMf6Z0XWpensaKo4KB6MQvDxUr0ER5=mHKWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 Nov 2023 20:20:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15569

On Fri, 2023-11-24 at 17:27 +0000, Jose Quaresma wrote:
> Hi Richard,
>=20
> I believe=C2=A0I found a regression in this patch.
> When we build with a custom BB_LOGCONFIG configuration, bitbake hangs
> at start-up
> in the ping command. Here is my build log:
>=20
> Loading cache...done.
> Loaded 6050 entries from dependency cache.
> (2023-11-24 16:06:39,801) INFO: Resolving any missing task queue
> dependencies
> (2023-11-24 16:06:46,455) Level 21:=20
> Build Configuration:
> BB_VERSION =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D "2.6.0"
> BUILD_SYS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D "x86_64-linux"
> NATIVELSBSTRING =C2=A0 =C2=A0 =C2=A0=3D "universal"
> TARGET_SYS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D "x86_64-lmp-linux"
> MACHINE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D "intel-corei7=
-64"
> DISTRO =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D "lmp"
> DISTRO_VERSION =C2=A0 =C2=A0 =C2=A0 =3D "4.0.14-78-91"
> TUNE_FEATURES =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D "m64 corei7"
> TARGET_FPU =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D ""
> DISTRO_FEATURES =C2=A0 =C2=A0 =C2=A0=3D "acl argp bluetooth ext2 ipv4 ipv=
6 largefile
> usbgadget usbhost wifi xattr zeroconf pci vfat modsign efi security
> tpm integrity seccomp pam usrmerge virtualization alsa sota systemd
> usrmerge"
> meta-lmp-base =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D
> "HEAD:3a18fbcdb5629b1056c14af2ec72f21bb829893f"
> meta-oe =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
> meta-networking =C2=A0 =C2=A0 =C2=A0
> meta-filesystems =C2=A0 =C2=A0=20
> meta-perl =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
> meta-python =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D
> "HEAD:991e6852a53e0fcd40af8f0386d7f46bb318015e"
> meta-virtualization =C2=A0=3D
> "HEAD:a215d8320edee0a317a6511e7e2efa5bba867486"
> meta-clang =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D
> "HEAD:8aaed8f345683c2fb03a4d90f615f1e93f545a55"
> meta-updater =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D
> "HEAD:defecf4523fe70d38ef0e264b46a38019d6d3088"
> meta-security =C2=A0 =C2=A0 =C2=A0 =C2=A0
> meta-tpm =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=20
> meta-parsec =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
> meta-integrity =C2=A0 =C2=A0 =C2=A0 =3D
> "HEAD:070a1e82cc59424d230a23c0b2a104b01fbaa2ad"
> meta-arm =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=20
> meta-arm-toolchain =C2=A0=20
> meta-arm-bsp =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D
> "HEAD:5f8b6a2d269c59c21273fee5417f2f0d90a086a1"
> meta-freescale =C2=A0 =C2=A0 =C2=A0 =3D
> "HEAD:d48d230b34292f8c61e5ead75e067fff404fb20c"
> meta-freescale-3rdparty =3D
> "HEAD:a9bba0f7fc3765431433886a3e78632dcfa7ad26"
> meta-raspberrypi =C2=A0 =C2=A0 =3D
> "HEAD:8231f97534812cb0c6ab8d500eff44d3880fdac5"
> meta-intel =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D
> "HEAD:52ce86a7f5f1ed751d80bc5e1d6b76db1c5b84c8"
> meta-yocto-bsp =C2=A0 =C2=A0 =C2=A0 =3D
> "HEAD:5d86975934b46a64b36f60c097bce7a577c1b8b0"
> meta-xilinx-core =C2=A0 =C2=A0=20
> meta-xilinx-bsp =C2=A0 =C2=A0 =C2=A0
> meta-xilinx-standalone =3D
> "HEAD:0872170289d08996d821db4d8988647a13063269"
> meta-xilinx-tools =C2=A0 =C2=A0=3D
> "HEAD:65799115a9d3dd53053b08f6f1416ecf879f4898"
> meta-tegra =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D
> "HEAD:fb4c603c504b6df9631f15a4734cbb8c42b1005a"
> meta-ti-bsp =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
> meta-ti-extras =C2=A0 =C2=A0 =C2=A0 =3D
> "HEAD:d3bcad2cbe63d4e1cd2b4e4418d0b3b9c1f864ed"
> meta-lmp-bsp =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D
> "HEAD:3a18fbcdb5629b1056c14af2ec72f21bb829893f"
> meta =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D
> "HEAD:795e85f62f3c88c08f24d986548ffe422f459cd0"
>=20
> [Errno 32] Broken pipeTraceback (most recent call last):
> =C2=A0 File "/srv/oe/bitbake/lib/bb/ui/knotty.py", line 647, in main
> =C2=A0 =C2=A0 ret, error =3D server.runCommand(["ping"])
> =C2=A0 File "/srv/oe/bitbake/lib/bb/server/process.py", line 503, in
> runCommand
> =C2=A0 =C2=A0 self.connection.send(command)
> =C2=A0 File "/srv/oe/bitbake/lib/bb/server/process.py", line 868, in send
> =C2=A0 =C2=A0 self._send(obj)
> =C2=A0 File "/srv/oe/bitbake/lib/bb/server/process.py", line 847, in _sen=
d
> =C2=A0 =C2=A0 self.writer.send_bytes(obj)
> =C2=A0 File "/usr/lib/python3.8/multiprocessing/connection.py", line 200,
> in send_bytes
> =C2=A0 =C2=A0 self._send_bytes(m[offset:offset + size])
> =C2=A0 File "/usr/lib/python3.8/multiprocessing/connection.py", line 411,
> in _send_bytes
> =C2=A0 =C2=A0 self._send(header + buf)
> =C2=A0 File "/usr/lib/python3.8/multiprocessing/connection.py", line 368,
> in _send
> =C2=A0 =C2=A0 n =3D write(self._handle, buf)
> BrokenPipeError: [Errno 32] Broken pipe
> During handling of the above exception, another exception occurred:
> Traceback (most recent call last):
> =C2=A0 File "/srv/oe/bitbake/bin/bitbake", line 36, in <module>
> =C2=A0 =C2=A0 sys.exit(bitbake_main(BitBakeConfigParameters(sys.argv),
> =C2=A0 File "/srv/oe/bitbake/lib/bb/main.py", line 404, in bitbake_main
> =C2=A0 =C2=A0 return ui_module.main(server_connection.connection,
> server_connection.events,
> =C2=A0 File "/srv/oe/bitbake/lib/bb/ui/knotty.py", line 864, in main
> =C2=A0 =C2=A0 _, error =3D server.runCommand(["stateForceShutdown"])
> =C2=A0 File "/srv/oe/bitbake/lib/bb/server/process.py", line 503, in
> runCommand
> =C2=A0 =C2=A0 self.connection.send(command)
> =C2=A0 File "/srv/oe/bitbake/lib/bb/server/process.py", line 868, in send
> =C2=A0 =C2=A0 self._send(obj)
> =C2=A0 File "/srv/oe/bitbake/lib/bb/server/process.py", line 847, in _sen=
d
> =C2=A0 =C2=A0 self.writer.send_bytes(obj)
> =C2=A0 File "/usr/lib/python3.8/multiprocessing/connection.py", line 200,
> in send_bytes
> =C2=A0 =C2=A0 self._send_bytes(m[offset:offset + size])
> =C2=A0 File "/usr/lib/python3.8/multiprocessing/connection.py", line 411,
> in _send_bytes
> =C2=A0 =C2=A0 self._send(header + buf)
> =C2=A0 File "/usr/lib/python3.8/multiprocessing/connection.py", line 368,
> in _send
> =C2=A0 =C2=A0 n =3D write(self._handle, buf)
> BrokenPipeError: [Errno 32] Broken pipe

Those tracebacks are the connection failing. Is there something
more/different in the bitbake-cookerdaemon.log file?

Cheers,

Richard



