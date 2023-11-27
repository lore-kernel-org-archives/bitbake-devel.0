Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED0EC0755A
	for <webhook@archiver.kernel.org>; Mon, 27 Nov 2023 12:16:28 +0000 (UTC)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
 by mx.groups.io with SMTP id smtpd.web11.93222.1701087386219606854
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Nov 2023 04:16:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=mM4zY/wb;
 spf=pass (domain: gmail.com, ip: 209.85.210.46, mailfrom: quaresma.jose@gmail.com)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6d7e67c169cso2704149a34.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 27 Nov 2023 04:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701087385; x=1701692185; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RV2M+MJmeaCUjq3ccoEPvwSyVdNt5Voncb/pEPrIkYY=;
        b=mM4zY/wb9f86dm2/XPdnQkyR7MZ1rv0FssV5QfSuXMoKoO0pO1GPJToUjKAu4PMud8
         JecQp1DNWK1sREIwSa+IrxSacAQBFjCDrydSvecRWuKbW3ptsNzrp6dKDn9/IPCBVXQd
         JIivSq+25QgH+NHyS1lUOa+2ZFnKTX+NyK/y3b/zbDC83ctkqu7R1KGZ3hS8S09a0lAd
         tIgwNLSGSLx8RTbZhXKefjhgMwscVx6BDDkpzbFQbg8QtGuhbsmtPvuxEP6c8oWLpFAp
         CyqK1EZINnz1zoOjJbAZqzzF/bx+tZlBFWxR2LqheorTPp+RNIS6a4jbCUkdiu849MzG
         xFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701087385; x=1701692185;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RV2M+MJmeaCUjq3ccoEPvwSyVdNt5Voncb/pEPrIkYY=;
        b=WGqkWiBhKk0JrFCPDyhsP+cpqZ9+6Y+AA8KvuMnq4sPAzXWc4+6+eFJ5SDxMLGGp1F
         Kp9vzfPuCVXTXSkMDRlHwz9SBXQzqvjG5dIXk4drcwCKMP+/J3FPLg4rQvIAMXCWQNNX
         00ZJoNAMJbNjXDYPCiqgb9uuFdNR4oKD+j2vhMd5Z+WiO6REJ6uJ3+yntM39hjGoF3bY
         Vy4hn4Nv4oK7YZV0IP8M2z+zSHkcVm3lWF61XqvGk24+uHhwmjdE2pAX2uP2Y2QUynvh
         VY8PfWayA7ek9d+vbhX/60X1UWwu+99oRLSZRQWE95VhdXv/tsIfg62UkwsyqniePZok
         Aq0Q==
X-Gm-Message-State: AOJu0YyfLIW7nfaWVhi2yxIpsY7Vn9lP33IHr5JhHwvBLw25cyjnBd9O
	PCLHPxNwfJkzAuc2odBsEEGK5cMEcpqqVxQ2R7c=
X-Google-Smtp-Source: AGHT+IESCm6uT2pE8u1AnyjRZG7D4NIFtaqmtLyDY3/JAs8hv2C4+T1K809E5V/NBzT0tN8lpB7Ws8OF9njpPaU5zJQ=
X-Received: by 2002:a05:6359:2eaa:b0:16d:e742:a282 with SMTP id
 rp42-20020a0563592eaa00b0016de742a282mr8655670rwb.17.1701087385234; Mon, 27
 Nov 2023 04:16:25 -0800 (PST)
MIME-Version: 1.0
References: <20231116165233.2862786-1-richard.purdie@linuxfoundation.org>
 <CANPvuR=Nkf1MV6mMf6Z0XWpensaKo4KB6MQvDxUr0ER5=mHKWQ@mail.gmail.com>
 <63e078f1b4dd53095f00ec3c54c4c420ead9f7ac.camel@linuxfoundation.org> <179AAE63E62AFEF6.23801@lists.openembedded.org>
In-Reply-To: <179AAE63E62AFEF6.23801@lists.openembedded.org>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Mon, 27 Nov 2023 12:16:14 +0000
Message-ID: <CANPvuRmFtEtmykoGnJKGB4e-CdzNoL7Q0necKrNpd0dhqnmduw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] cooker: Add support for BB_DEFAULT_EVENTLOG
To: quaresma.jose@gmail.com
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel@lists.openembedded.org, Ricardo Salveti <ricardo@foundries.io>
Content-Type: multipart/alternative; boundary="000000000000543054060b2145b0"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 Nov 2023 12:16:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15571

--000000000000543054060b2145b0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jose Quaresma via lists.openembedded.org <quaresma.jose=3D
gmail.com@lists.openembedded.org> escreveu no dia sexta, 24/11/2023 =C3=A0(=
s)
22:05:

>
>
> A sexta, 24/11/2023, 20:19, Richard Purdie <
> richard.purdie@linuxfoundation.org> escreveu:
>
>> On Fri, 2023-11-24 at 17:27 +0000, Jose Quaresma wrote:
>> > Hi Richard,
>> >
>> > I believe I found a regression in this patch.
>> > When we build with a custom BB_LOGCONFIG configuration, bitbake hangs
>> > at start-up
>> > in the ping command. Here is my build log:
>> >
>> > Loading cache...done.
>> > Loaded 6050 entries from dependency cache.
>> > (2023-11-24 16:06:39,801) INFO: Resolving any missing task queue
>> > dependencies
>> > (2023-11-24 16:06:46,455) Level 21:
>> > Build Configuration:
>> > BB_VERSION           =3D "2.6.0"
>> > BUILD_SYS            =3D "x86_64-linux"
>> > NATIVELSBSTRING      =3D "universal"
>> > TARGET_SYS           =3D "x86_64-lmp-linux"
>> > MACHINE              =3D "intel-corei7-64"
>> > DISTRO               =3D "lmp"
>> > DISTRO_VERSION       =3D "4.0.14-78-91"
>> > TUNE_FEATURES        =3D "m64 corei7"
>> > TARGET_FPU           =3D ""
>> > DISTRO_FEATURES      =3D "acl argp bluetooth ext2 ipv4 ipv6 largefile
>> > usbgadget usbhost wifi xattr zeroconf pci vfat modsign efi security
>> > tpm integrity seccomp pam usrmerge virtualization alsa sota systemd
>> > usrmerge"
>> > meta-lmp-base        =3D
>> > "HEAD:3a18fbcdb5629b1056c14af2ec72f21bb829893f"
>> > meta-oe
>> > meta-networking
>> > meta-filesystems
>> > meta-perl
>> > meta-python          =3D
>> > "HEAD:991e6852a53e0fcd40af8f0386d7f46bb318015e"
>> > meta-virtualization  =3D
>> > "HEAD:a215d8320edee0a317a6511e7e2efa5bba867486"
>> > meta-clang           =3D
>> > "HEAD:8aaed8f345683c2fb03a4d90f615f1e93f545a55"
>> > meta-updater         =3D
>> > "HEAD:defecf4523fe70d38ef0e264b46a38019d6d3088"
>> > meta-security
>> > meta-tpm
>> > meta-parsec
>> > meta-integrity       =3D
>> > "HEAD:070a1e82cc59424d230a23c0b2a104b01fbaa2ad"
>> > meta-arm
>> > meta-arm-toolchain
>> > meta-arm-bsp         =3D
>> > "HEAD:5f8b6a2d269c59c21273fee5417f2f0d90a086a1"
>> > meta-freescale       =3D
>> > "HEAD:d48d230b34292f8c61e5ead75e067fff404fb20c"
>> > meta-freescale-3rdparty =3D
>> > "HEAD:a9bba0f7fc3765431433886a3e78632dcfa7ad26"
>> > meta-raspberrypi     =3D
>> > "HEAD:8231f97534812cb0c6ab8d500eff44d3880fdac5"
>> > meta-intel           =3D
>> > "HEAD:52ce86a7f5f1ed751d80bc5e1d6b76db1c5b84c8"
>> > meta-yocto-bsp       =3D
>> > "HEAD:5d86975934b46a64b36f60c097bce7a577c1b8b0"
>> > meta-xilinx-core
>> > meta-xilinx-bsp
>> > meta-xilinx-standalone =3D
>> > "HEAD:0872170289d08996d821db4d8988647a13063269"
>> > meta-xilinx-tools    =3D
>> > "HEAD:65799115a9d3dd53053b08f6f1416ecf879f4898"
>> > meta-tegra           =3D
>> > "HEAD:fb4c603c504b6df9631f15a4734cbb8c42b1005a"
>> > meta-ti-bsp
>> > meta-ti-extras       =3D
>> > "HEAD:d3bcad2cbe63d4e1cd2b4e4418d0b3b9c1f864ed"
>> > meta-lmp-bsp         =3D
>> > "HEAD:3a18fbcdb5629b1056c14af2ec72f21bb829893f"
>> > meta                 =3D
>> > "HEAD:795e85f62f3c88c08f24d986548ffe422f459cd0"
>> >
>> > [Errno 32] Broken pipeTraceback (most recent call last):
>> >   File "/srv/oe/bitbake/lib/bb/ui/knotty.py", line 647, in main
>> >     ret, error =3D server.runCommand(["ping"])
>> >   File "/srv/oe/bitbake/lib/bb/server/process.py", line 503, in
>> > runCommand
>> >     self.connection.send(command)
>> >   File "/srv/oe/bitbake/lib/bb/server/process.py", line 868, in send
>> >     self._send(obj)
>> >   File "/srv/oe/bitbake/lib/bb/server/process.py", line 847, in _send
>> >     self.writer.send_bytes(obj)
>> >   File "/usr/lib/python3.8/multiprocessing/connection.py", line 200,
>> > in send_bytes
>> >     self._send_bytes(m[offset:offset + size])
>> >   File "/usr/lib/python3.8/multiprocessing/connection.py", line 411,
>> > in _send_bytes
>> >     self._send(header + buf)
>> >   File "/usr/lib/python3.8/multiprocessing/connection.py", line 368,
>> > in _send
>> >     n =3D write(self._handle, buf)
>> > BrokenPipeError: [Errno 32] Broken pipe
>> > During handling of the above exception, another exception occurred:
>> > Traceback (most recent call last):
>> >   File "/srv/oe/bitbake/bin/bitbake", line 36, in <module>
>> >     sys.exit(bitbake_main(BitBakeConfigParameters(sys.argv),
>> >   File "/srv/oe/bitbake/lib/bb/main.py", line 404, in bitbake_main
>> >     return ui_module.main(server_connection.connection,
>> > server_connection.events,
>> >   File "/srv/oe/bitbake/lib/bb/ui/knotty.py", line 864, in main
>> >     _, error =3D server.runCommand(["stateForceShutdown"])
>> >   File "/srv/oe/bitbake/lib/bb/server/process.py", line 503, in
>> > runCommand
>> >     self.connection.send(command)
>> >   File "/srv/oe/bitbake/lib/bb/server/process.py", line 868, in send
>> >     self._send(obj)
>> >   File "/srv/oe/bitbake/lib/bb/server/process.py", line 847, in _send
>> >     self.writer.send_bytes(obj)
>> >   File "/usr/lib/python3.8/multiprocessing/connection.py", line 200,
>> > in send_bytes
>> >     self._send_bytes(m[offset:offset + size])
>> >   File "/usr/lib/python3.8/multiprocessing/connection.py", line 411,
>> > in _send_bytes
>> >     self._send(header + buf)
>> >   File "/usr/lib/python3.8/multiprocessing/connection.py", line 368,
>> > in _send
>> >     n =3D write(self._handle, buf)
>> > BrokenPipeError: [Errno 32] Broken pipe
>>
>> Those tracebacks are the connection failing. Is there something
>> more/different in the bitbake-cookerdaemon.log file?
>>
>
> Reverting this patch or disabling the custom logger solves the issue. Nex=
t
> week I will share the cookerdaemon.log file.
>

I can replicate the issue in a more easy way just running bitbake in debug
mode (with one -D) and
without any custom BB_LOGCONFIG. The result is the same as before, with
this patch reverted all good.

The bitbake-cookerdaemon.log don't gives much informations:

$ cat bitbake-cookerdaemon.log
365401 12:05:42.235324 --- Starting bitbake server pid 365401 at 2023-11-27
12:05:42.235314 ---
365401 12:05:42.235772 Started bitbake server pid 365401
365401 12:05:42.235869 Entering server connection loop
365401 12:05:42.235884 Lockfile is:
/lmp/build-lmp-intel-corei7-64-main-next-container/bitbake.lock
Socket is /lmp/build-lmp-intel-corei7-64-main-next-container/bitbake.sock
(True)
365401 12:05:42.236261 Accepting [<socket.socket fd=3D6,
family=3DAddressFamily.AF_UNIX, type=3DSocketKind.SOCK_STREAM, proto=3D0,
laddr=3Dbitbake.sock>] ([])
365401 12:05:42.236848 Processing Client
365401 12:05:42.236864 Connecting Client
365401 12:05:42.237049 Running command ['setFeatures', [2, 1]]
365401 12:05:42.237068 Sending reply (None, None)
365401 12:05:42.237098 Command Completed (socket: True)
365401 12:05:42.237355 Running command ['updateConfig', {'halt': True,
'force': False, 'invalidate_stamp': None, 'dry_run': False,
'dump_signatures': [], 'extra_assume_provided': [], 'profile': False,
'prefile': [], 'postfile': [], 'server_timeout': None, 'nosetscene': False,
'setsceneonly': False, 'skipsetscene': False, 'runall': [], 'runonly':
None, 'writeeventlog': None, 'build_verbose_shell': False,
'build_verbose_stdout': False, 'default_loglevel': 10, 'debug_domains':
{}}, {'BB_ENV_PASSTHROUGH_ADDITIONS': 'MACHINE DISTRO TCLIBC TCMODE
GIT_PROXY_COMMAND         http_proxy ftp_proxy https_proxy all_proxy
ALL_PROXY no_proxy         SSH_AGENT_PID SSH_AUTH_SOCK BB_SRCREV_POLICY
SDKMACHINE         BB_NUMBER_THREADS BB_LOGCONFIG BB_CONSOLELOG', 'DISTRO':
'lmp', 'PWD': '/lmp/build-lmp-intel-corei7-64-main-next-container', 'HOME':
'/home/builder', 'MACHINE': 'intel-corei7-64', 'LC_ALL': 'en_US.UTF-8',
'PATH':
'/lmp/layers/openembedded-core/scripts:/lmp/bitbake/bin:/lmp/.repo/repo:/us=
r/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
'HOSTNAME': '35de7abf13b3', 'LANGUAGE': 'en_US:en', 'FIO_CHECK_CMD':
'/usr/bin/fiocheck', 'LANG': 'en_US.UTF-8', 'LS_COLORS':
'rs=3D0:di=3D01;34:ln=3D01;36:mh=3D00:pi=3D40;33:so=3D01;35:do=3D01;35:bd=
=3D40;33;01:cd=3D40;33;01:or=3D40;31;01:mi=3D00:su=3D37;41:sg=3D30;43:ca=3D=
30;41:tw=3D30;42:ow=3D34;42:st=3D37;44:ex=3D01;32:*.tar=3D01;31:*.tgz=3D01;=
31:*.arc=3D01;31:*.arj=3D01;31:*.taz=3D01;31:*.lha=3D01;31:*.lz4=3D01;31:*.=
lzh=3D01;31:*.lzma=3D01;31:*.tlz=3D01;31:*.txz=3D01;31:*.tzo=3D01;31:*.t7z=
=3D01;31:*.zip=3D01;31:*.z=3D01;31:*.dz=3D01;31:*.gz=3D01;31:*.lrz=3D01;31:=
*.lz=3D01;31:*.lzo=3D01;31:*.xz=3D01;31:*.zst=3D01;31:*.tzst=3D01;31:*.bz2=
=3D01;31:*.bz=3D01;31:*.tbz=3D01;31:*.tbz2=3D01;31:*.tz=3D01;31:*.deb=3D01;=
31:*.rpm=3D01;31:*.jar=3D01;31:*.war=3D01;31:*.ear=3D01;31:*.sar=3D01;31:*.=
rar=3D01;31:*.alz=3D01;31:*.ace=3D01;31:*.zoo=3D01;31:*.cpio=3D01;31:*.7z=
=3D01;31:*.rz=3D01;31:*.cab=3D01;31:*.wim=3D01;31:*.swm=3D01;31:*.dwm=3D01;=
31:*.esd=3D01;31:*.jpg=3D01;35:*.jpeg=3D01;35:*.mjpg=3D01;35:*.mjpeg=3D01;3=
5:*.gif=3D01;35:*.bmp=3D01;35:*.pbm=3D01;35:*.pgm=3D01;35:*.ppm=3D01;35:*.t=
ga=3D01;35:*.xbm=3D01;35:*.xpm=3D01;35:*.tif=3D01;35:*.tiff=3D01;35:*.png=
=3D01;35:*.svg=3D01;35:*.svgz=3D01;35:*.mng=3D01;35:*.pcx=3D01;35:*.mov=3D0=
1;35:*.mpg=3D01;35:*.mpeg=3D01;35:*.m2v=3D01;35:*.mkv=3D01;35:*.webm=3D01;3=
5:*.ogm=3D01;35:*.mp4=3D01;35:*.m4v=3D01;35:*.mp4v=3D01;35:*.vob=3D01;35:*.=
qt=3D01;35:*.nuv=3D01;35:*.wmv=3D01;35:*.asf=3D01;35:*.rm=3D01;35:*.rmvb=3D=
01;35:*.flc=3D01;35:*.avi=3D01;35:*.fli=3D01;35:*.flv=3D01;35:*.gl=3D01;35:=
*.dl=3D01;35:*.xcf=3D01;35:*.xwd=3D01;35:*.yuv=3D01;35:*.cgm=3D01;35:*.emf=
=3D01;35:*.ogv=3D01;35:*.ogx=3D01;35:*.aac=3D00;36:*.au=3D00;36:*.flac=3D00=
;36:*.m4a=3D00;36:*.mid=3D00;36:*.midi=3D00;36:*.mka=3D00;36:*.mp3=3D00;36:=
*.mpc=3D00;36:*.ogg=3D00;36:*.ra=3D00;36:*.wav=3D00;36:*.oga=3D00;36:*.opus=
=3D00;36:*.spx=3D00;36:*.xspf=3D00;36:',
'LESSCLOSE': '/usr/bin/lesspipe %s %s', 'TERM': 'xterm', 'BRANCH':
'main-next-container', 'LESSOPEN': '| /usr/bin/lesspipe %s', 'GID': '1000',
'SHLVL': '1', 'LMP_VERSION_CACHE_DEV': '', 'BUILDDIR':
'/lmp/build-lmp-intel-corei7-64-main-next-container', 'UID': '1000',
'FIO_PUSH_CMD': '/usr/bin/fiopush', 'OLDPWD': '/lmp', '_':
'/lmp/bitbake/bin/bitbake'}, ['/lmp/bitbake/bin/bitbake', '-D',
'lmp-base-console-image']]
365401 12:05:44.150807 Base config valid
365401 12:05:44.152325 Sending reply (None, None)
365401 12:05:44.152371 Command Completed (socket: True)
365401 12:05:44.152499 Running command ['getVariable', 'BBINCLUDELOGS']
365401 12:05:44.152524 Sending reply ('yes', None)
365401 12:05:44.152551 Command Completed (socket: True)
365401 12:05:44.152597 Running command ['getVariable',
'BBINCLUDELOGS_LINES']
365401 12:05:44.152609 Sending reply (None, None)
365401 12:05:44.152633 Command Completed (socket: True)
365401 12:05:44.152670 Running command ['getSetVariable', 'BB_CONSOLELOG']
365401 12:05:44.152722 Sending reply
('/lmp/build-lmp-intel-corei7-64-main-next-container/tmp-lmp/log/cooker/int=
el-corei7-64/20231127120542.log',
None)
365401 12:05:44.152746 Command Completed (socket: True)
365401 12:05:44.152781 Running command ['getSetVariable', 'BB_LOGCONFIG']
365401 12:05:44.152801 Sending reply (None, None)
365401 12:05:44.152833 Command Completed (socket: True)
365401 12:05:44.154006 Running command ['getUIHandlerNum']
365401 12:05:44.154015 Sending reply (1, None)
365401 12:05:44.154038 Command Completed (socket: True)
365401 12:05:44.154089 Running command ['setEventMask', 1, 10,
{'BitBake.RunQueue.HashEquiv': 19, 'BitBake.SigGen.HashEquiv': 19},
['bb.runqueue.runQueueExitWait', 'bb.event.LogExecTTY',
'logging.LogRecord', 'bb.build.TaskFailed', 'bb.build.TaskBase',
'bb.event.ParseStarted', 'bb.event.ParseProgress',
'bb.event.ParseCompleted', 'bb.event.CacheLoadStarted',
'bb.event.CacheLoadProgress', 'bb.event.CacheLoadCompleted',
'bb.command.CommandFailed', 'bb.command.CommandExit',
'bb.command.CommandCompleted', 'bb.cooker.CookerExit',
'bb.event.MultipleProviders', 'bb.event.NoProvider',
'bb.runqueue.sceneQueueTaskStarted', 'bb.runqueue.runQueueTaskStarted',
'bb.runqueue.runQueueTaskFailed', 'bb.runqueue.sceneQueueTaskFailed',
'bb.event.BuildBase', 'bb.build.TaskStarted', 'bb.build.TaskSucceeded',
'bb.build.TaskFailedSilent', 'bb.build.TaskProgress',
'bb.event.ProcessStarted', 'bb.event.ProcessProgress',
'bb.event.ProcessFinished']]
365401 12:05:44.154104 Sending reply (True, None)
365401 12:05:44.154128 Command Completed (socket: True)
365401 12:05:44.154168 Running command ['getVariable', 'BB_DEFAULT_TASK']
365401 12:05:44.154184 Sending reply ('build', None)
365401 12:05:44.154206 Command Completed (socket: True)
365401 12:05:44.154244 Running command ['setConfig', 'cmd', 'build']
365401 12:05:44.154254 Sending reply (None, None)
365401 12:05:44.154276 Command Completed (socket: True)
365401 12:05:44.154312 Running command ['buildTargets',
['lmp-base-console-image'], 'build']
365401 12:05:44.154336 Registering idle function <bound method
Command.runAsyncCommand of <bb.command.Command object at 0x7f95d7d54550>>
365401 12:05:44.154341 Sending reply (True, None)
365401 12:05:44.154363 Command Completed (socket: True)
365401 12:05:44.187394 Parsing started
365401 12:05:52.095762 Parse cache valid


Jose


>
> Jose
>
>
>> Cheers,
>>
>> Richard
>>
>>
>>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15570):
> https://lists.openembedded.org/g/bitbake-devel/message/15570
> Mute This Topic: https://lists.openembedded.org/mt/102630301/5052612
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> quaresma.jose@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--=20
Best regards,

Jos=C3=A9 Quaresma

--000000000000543054060b2145b0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Jose Quaresma via <a href=3D"http://l=
ists.openembedded.org">lists.openembedded.org</a> &lt;quaresma.jose=3D<a hr=
ef=3D"mailto:gmail.com@lists.openembedded.org">gmail.com@lists.openembedded=
.org</a>&gt; escreveu no dia sexta, 24/11/2023 =C3=A0(s) 22:05:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"auto"><div><br>=
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">A sext=
a, 24/11/2023, 20:19, Richard Purdie &lt;<a href=3D"mailto:richard.purdie@l=
inuxfoundation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a=
>&gt; escreveu:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
On Fri, 2023-11-24 at 17:27 +0000, Jose Quaresma wrote:<br>
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
 cookerdaemon.log file.</div></div></blockquote><div><br>I can replicate th=
e issue in a more easy way just running bitbake in debug mode (with one -D)=
 and<br>without=C2=A0any custom BB_LOGCONFIG. The result is the same as bef=
ore, with this patch reverted all good.<br><br>The bitbake-cookerdaemon.log=
 don&#39;t gives much informations:<br><br>$ cat bitbake-cookerdaemon.log<b=
r>365401 12:05:42.235324 --- Starting bitbake server pid 365401 at 2023-11-=
27 12:05:42.235314 ---<br>365401 12:05:42.235772 Started bitbake server pid=
 365401<br>365401 12:05:42.235869 Entering server connection loop<br>365401=
 12:05:42.235884 Lockfile is: /lmp/build-lmp-intel-corei7-64-main-next-cont=
ainer/bitbake.lock<br>Socket is /lmp/build-lmp-intel-corei7-64-main-next-co=
ntainer/bitbake.sock (True)<br>365401 12:05:42.236261 Accepting [&lt;socket=
.socket fd=3D6, family=3DAddressFamily.AF_UNIX, type=3DSocketKind.SOCK_STRE=
AM, proto=3D0, laddr=3Dbitbake.sock&gt;] ([])<br>365401 12:05:42.236848 Pro=
cessing Client<br>365401 12:05:42.236864 Connecting Client<br>365401 12:05:=
42.237049 Running command [&#39;setFeatures&#39;, [2, 1]]<br>365401 12:05:4=
2.237068 Sending reply (None, None)<br>365401 12:05:42.237098 Command Compl=
eted (socket: True)<br>365401 12:05:42.237355 Running command [&#39;updateC=
onfig&#39;, {&#39;halt&#39;: True, &#39;force&#39;: False, &#39;invalidate_=
stamp&#39;: None, &#39;dry_run&#39;: False, &#39;dump_signatures&#39;: [], =
&#39;extra_assume_provided&#39;: [], &#39;profile&#39;: False, &#39;prefile=
&#39;: [], &#39;postfile&#39;: [], &#39;server_timeout&#39;: None, &#39;nos=
etscene&#39;: False, &#39;setsceneonly&#39;: False, &#39;skipsetscene&#39;:=
 False, &#39;runall&#39;: [], &#39;runonly&#39;: None, &#39;writeeventlog&#=
39;: None, &#39;build_verbose_shell&#39;: False, &#39;build_verbose_stdout&=
#39;: False, &#39;default_loglevel&#39;: 10, &#39;debug_domains&#39;: {}}, =
{&#39;BB_ENV_PASSTHROUGH_ADDITIONS&#39;: &#39;MACHINE DISTRO TCLIBC TCMODE =
GIT_PROXY_COMMAND =C2=A0 =C2=A0 =C2=A0 =C2=A0 http_proxy ftp_proxy https_pr=
oxy all_proxy ALL_PROXY no_proxy =C2=A0 =C2=A0 =C2=A0 =C2=A0 SSH_AGENT_PID =
SSH_AUTH_SOCK BB_SRCREV_POLICY SDKMACHINE =C2=A0 =C2=A0 =C2=A0 =C2=A0 BB_NU=
MBER_THREADS BB_LOGCONFIG BB_CONSOLELOG&#39;, &#39;DISTRO&#39;: &#39;lmp&#3=
9;, &#39;PWD&#39;: &#39;/lmp/build-lmp-intel-corei7-64-main-next-container&=
#39;, &#39;HOME&#39;: &#39;/home/builder&#39;, &#39;MACHINE&#39;: &#39;inte=
l-corei7-64&#39;, &#39;LC_ALL&#39;: &#39;en_US.UTF-8&#39;, &#39;PATH&#39;: =
&#39;/lmp/layers/openembedded-core/scripts:/lmp/bitbake/bin:/lmp/.repo/repo=
:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin&#39;, &#39;HO=
STNAME&#39;: &#39;35de7abf13b3&#39;, &#39;LANGUAGE&#39;: &#39;en_US:en&#39;=
, &#39;FIO_CHECK_CMD&#39;: &#39;/usr/bin/fiocheck&#39;, &#39;LANG&#39;: &#3=
9;en_US.UTF-8&#39;, &#39;LS_COLORS&#39;: &#39;rs=3D0:di=3D01;34:ln=3D01;36:=
mh=3D00:pi=3D40;33:so=3D01;35:do=3D01;35:bd=3D40;33;01:cd=3D40;33;01:or=3D4=
0;31;01:mi=3D00:su=3D37;41:sg=3D30;43:ca=3D30;41:tw=3D30;42:ow=3D34;42:st=
=3D37;44:ex=3D01;32:*.tar=3D01;31:*.tgz=3D01;31:*.arc=3D01;31:*.arj=3D01;31=
:*.taz=3D01;31:*.lha=3D01;31:*.lz4=3D01;31:*.lzh=3D01;31:*.lzma=3D01;31:*.t=
lz=3D01;31:*.txz=3D01;31:*.tzo=3D01;31:*.t7z=3D01;31:*.zip=3D01;31:*.z=3D01=
;31:*.dz=3D01;31:*.gz=3D01;31:*.lrz=3D01;31:*.lz=3D01;31:*.lzo=3D01;31:*.xz=
=3D01;31:*.zst=3D01;31:*.tzst=3D01;31:*.bz2=3D01;31:*.bz=3D01;31:*.tbz=3D01=
;31:*.tbz2=3D01;31:*.tz=3D01;31:*.deb=3D01;31:*.rpm=3D01;31:*.jar=3D01;31:*=
.war=3D01;31:*.ear=3D01;31:*.sar=3D01;31:*.rar=3D01;31:*.alz=3D01;31:*.ace=
=3D01;31:*.zoo=3D01;31:*.cpio=3D01;31:*.7z=3D01;31:*.rz=3D01;31:*.cab=3D01;=
31:*.wim=3D01;31:*.swm=3D01;31:*.dwm=3D01;31:*.esd=3D01;31:*.jpg=3D01;35:*.=
jpeg=3D01;35:*.mjpg=3D01;35:*.mjpeg=3D01;35:*.gif=3D01;35:*.bmp=3D01;35:*.p=
bm=3D01;35:*.pgm=3D01;35:*.ppm=3D01;35:*.tga=3D01;35:*.xbm=3D01;35:*.xpm=3D=
01;35:*.tif=3D01;35:*.tiff=3D01;35:*.png=3D01;35:*.svg=3D01;35:*.svgz=3D01;=
35:*.mng=3D01;35:*.pcx=3D01;35:*.mov=3D01;35:*.mpg=3D01;35:*.mpeg=3D01;35:*=
.m2v=3D01;35:*.mkv=3D01;35:*.webm=3D01;35:*.ogm=3D01;35:*.mp4=3D01;35:*.m4v=
=3D01;35:*.mp4v=3D01;35:*.vob=3D01;35:*.qt=3D01;35:*.nuv=3D01;35:*.wmv=3D01=
;35:*.asf=3D01;35:*.rm=3D01;35:*.rmvb=3D01;35:*.flc=3D01;35:*.avi=3D01;35:*=
.fli=3D01;35:*.flv=3D01;35:*.gl=3D01;35:*.dl=3D01;35:*.xcf=3D01;35:*.xwd=3D=
01;35:*.yuv=3D01;35:*.cgm=3D01;35:*.emf=3D01;35:*.ogv=3D01;35:*.ogx=3D01;35=
:*.aac=3D00;36:*.au=3D00;36:*.flac=3D00;36:*.m4a=3D00;36:*.mid=3D00;36:*.mi=
di=3D00;36:*.mka=3D00;36:*.mp3=3D00;36:*.mpc=3D00;36:*.ogg=3D00;36:*.ra=3D0=
0;36:*.wav=3D00;36:*.oga=3D00;36:*.opus=3D00;36:*.spx=3D00;36:*.xspf=3D00;3=
6:&#39;, &#39;LESSCLOSE&#39;: &#39;/usr/bin/lesspipe %s %s&#39;, &#39;TERM&=
#39;: &#39;xterm&#39;, &#39;BRANCH&#39;: &#39;main-next-container&#39;, &#3=
9;LESSOPEN&#39;: &#39;| /usr/bin/lesspipe %s&#39;, &#39;GID&#39;: &#39;1000=
&#39;, &#39;SHLVL&#39;: &#39;1&#39;, &#39;LMP_VERSION_CACHE_DEV&#39;: &#39;=
&#39;, &#39;BUILDDIR&#39;: &#39;/lmp/build-lmp-intel-corei7-64-main-next-co=
ntainer&#39;, &#39;UID&#39;: &#39;1000&#39;, &#39;FIO_PUSH_CMD&#39;: &#39;/=
usr/bin/fiopush&#39;, &#39;OLDPWD&#39;: &#39;/lmp&#39;, &#39;_&#39;: &#39;/=
lmp/bitbake/bin/bitbake&#39;}, [&#39;/lmp/bitbake/bin/bitbake&#39;, &#39;-D=
&#39;, &#39;lmp-base-console-image&#39;]]<br>365401 12:05:44.150807 Base co=
nfig valid<br>365401 12:05:44.152325 Sending reply (None, None)<br>365401 1=
2:05:44.152371 Command Completed (socket: True)<br>365401 12:05:44.152499 R=
unning command [&#39;getVariable&#39;, &#39;BBINCLUDELOGS&#39;]<br>365401 1=
2:05:44.152524 Sending reply (&#39;yes&#39;, None)<br>365401 12:05:44.15255=
1 Command Completed (socket: True)<br>365401 12:05:44.152597 Running comman=
d [&#39;getVariable&#39;, &#39;BBINCLUDELOGS_LINES&#39;]<br>365401 12:05:44=
.152609 Sending reply (None, None)<br>365401 12:05:44.152633 Command Comple=
ted (socket: True)<br>365401 12:05:44.152670 Running command [&#39;getSetVa=
riable&#39;, &#39;BB_CONSOLELOG&#39;]<br>365401 12:05:44.152722 Sending rep=
ly (&#39;/lmp/build-lmp-intel-corei7-64-main-next-container/tmp-lmp/log/coo=
ker/intel-corei7-64/20231127120542.log&#39;, None)<br>365401 12:05:44.15274=
6 Command Completed (socket: True)<br>365401 12:05:44.152781 Running comman=
d [&#39;getSetVariable&#39;, &#39;BB_LOGCONFIG&#39;]<br>365401 12:05:44.152=
801 Sending reply (None, None)<br>365401 12:05:44.152833 Command Completed =
(socket: True)<br>365401 12:05:44.154006 Running command [&#39;getUIHandler=
Num&#39;]<br>365401 12:05:44.154015 Sending reply (1, None)<br>365401 12:05=
:44.154038 Command Completed (socket: True)<br>365401 12:05:44.154089 Runni=
ng command [&#39;setEventMask&#39;, 1, 10, {&#39;BitBake.RunQueue.HashEquiv=
&#39;: 19, &#39;BitBake.SigGen.HashEquiv&#39;: 19}, [&#39;bb.runqueue.runQu=
eueExitWait&#39;, &#39;bb.event.LogExecTTY&#39;, &#39;logging.LogRecord&#39=
;, &#39;bb.build.TaskFailed&#39;, &#39;bb.build.TaskBase&#39;, &#39;bb.even=
t.ParseStarted&#39;, &#39;bb.event.ParseProgress&#39;, &#39;bb.event.ParseC=
ompleted&#39;, &#39;bb.event.CacheLoadStarted&#39;, &#39;bb.event.CacheLoad=
Progress&#39;, &#39;bb.event.CacheLoadCompleted&#39;, &#39;bb.command.Comma=
ndFailed&#39;, &#39;bb.command.CommandExit&#39;, &#39;bb.command.CommandCom=
pleted&#39;, &#39;bb.cooker.CookerExit&#39;, &#39;bb.event.MultipleProvider=
s&#39;, &#39;bb.event.NoProvider&#39;, &#39;bb.runqueue.sceneQueueTaskStart=
ed&#39;, &#39;bb.runqueue.runQueueTaskStarted&#39;, &#39;bb.runqueue.runQue=
ueTaskFailed&#39;, &#39;bb.runqueue.sceneQueueTaskFailed&#39;, &#39;bb.even=
t.BuildBase&#39;, &#39;bb.build.TaskStarted&#39;, &#39;bb.build.TaskSucceed=
ed&#39;, &#39;bb.build.TaskFailedSilent&#39;, &#39;bb.build.TaskProgress&#3=
9;, &#39;bb.event.ProcessStarted&#39;, &#39;bb.event.ProcessProgress&#39;, =
&#39;bb.event.ProcessFinished&#39;]]<br>365401 12:05:44.154104 Sending repl=
y (True, None)<br>365401 12:05:44.154128 Command Completed (socket: True)<b=
r>365401 12:05:44.154168 Running command [&#39;getVariable&#39;, &#39;BB_DE=
FAULT_TASK&#39;]<br>365401 12:05:44.154184 Sending reply (&#39;build&#39;, =
None)<br>365401 12:05:44.154206 Command Completed (socket: True)<br>365401 =
12:05:44.154244 Running command [&#39;setConfig&#39;, &#39;cmd&#39;, &#39;b=
uild&#39;]<br>365401 12:05:44.154254 Sending reply (None, None)<br>365401 1=
2:05:44.154276 Command Completed (socket: True)<br>365401 12:05:44.154312 R=
unning command [&#39;buildTargets&#39;, [&#39;lmp-base-console-image&#39;],=
 &#39;build&#39;]<br>365401 12:05:44.154336 Registering idle function &lt;b=
ound method Command.runAsyncCommand of &lt;bb.command.Command object at 0x7=
f95d7d54550&gt;&gt;<br>365401 12:05:44.154341 Sending reply (True, None)<br=
>365401 12:05:44.154363 Command Completed (socket: True)<br>365401 12:05:44=
.187394 Parsing started<br>365401 12:05:52.095762 Parse cache valid<br><br>=
<br>Jose<br>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><=
div dir=3D"auto"><div dir=3D"auto"><br></div><div dir=3D"auto">Jose</div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex"><br>
Cheers,<br>
<br>
Richard<br>
<br>
<br>
</blockquote></div></div></div>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#15570): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/15570" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/15570</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/102630301/505=
2612" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/102630301/5052612</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:quaresma.jose@gmail.com" target=3D=
"_blank">quaresma.jose@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr">Best regards,<div><br>Jos=C3=A9 Quaresma</div></div></div></=
div>

--000000000000543054060b2145b0--

