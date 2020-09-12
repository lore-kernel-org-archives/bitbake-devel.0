Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web10.23722.1599936725486382357
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 12 Sep 2020 11:52:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=W6+MgikU;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id t10so14579513wrv.1
        for <bitbake-devel@lists.openembedded.org>; Sat, 12 Sep 2020 11:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=B+7uDQyxTo8I1m7kWsnsqXJcJiYmve9lUj0hwAnHP9M=;
        b=W6+MgikUdyp6NnRs4asdMqhjL/zM+VjogGUK0O/9bZ40WZnmNfhDIFeftAHiO6uz5j
         +CYBog8qdgLjWk6RxX6r9IdOkB+6y9VY4sQJvd7bwXc0xqSWoZIsEmJm70MXaKE2urfo
         e5ncpHLQUyfdvhTcnljZHfY60HGJcZ1x2EN6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=B+7uDQyxTo8I1m7kWsnsqXJcJiYmve9lUj0hwAnHP9M=;
        b=ZLM0GMxrtErwFbSa9RkxyoGA6t6xOQfYmUGMbHihtZQStnEMrdHGy+Q82SBq9uTS6E
         5j5Sgb6TFyhzASWYVkGd8beLxcWrV9fmC/qU0XhvRNmf6j4/btU+dBmp4PUla7UmeigI
         YNj0kBA6uAw4sEs4ZgUZkrUKC6y0NuxMbu4m/dWkyn42uAGxcBq1OHCFReqh2YOHKvUW
         pefsVvcg6GRrEXXGy/ZAeaGoT80UQh7CrIfHKKPgcON8Cm68PStsizuhSWvRJ67NbgW+
         3u/mdIhC+BDYk3lAfz29ZtOJZZNdufDhpLvIVsE0XHO7Xx4tvFwUW/v2Ttda13XVgNZu
         eJ7g==
X-Gm-Message-State: AOAM533naEUPZCA8BZSQN7q20c5qWlS3nQBQWQt7cCLbhnDsg7f24uEn
	wc5u7F49IKrqS8g3spHBhl+axtUM+2pYNA==
X-Google-Smtp-Source: ABdhPJz3sK9h9kad7hCdakqoBlqkVoiXqBy2pJ5/m67v9Q8zEUZ/DOTlVodgGrYMHeXhhfJ68+eLKw==
X-Received: by 2002:a5d:49d2:: with SMTP id t18mr7351728wrs.99.1599936723216;
        Sat, 12 Sep 2020 11:52:03 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from 8.4.6.b.e.8.e.4.6.7.0.3.a.2.d.2.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (8.4.6.b.e.8.e.4.6.7.0.3.a.2.d.2.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:2d2a:3076:4e8e:b648])
        by smtp.gmail.com with ESMTPSA id y207sm11980913wmc.17.2020.09.12.11.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 11:52:02 -0700 (PDT)
Message-ID: <8039a844dea63600b3a7e90d6250e7195cf57458.camel@linuxfoundation.org>
Subject: SyncThread exit issues
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Cc: Joshua Watt <jpewhacker@gmail.com>
Date: Sat, 12 Sep 2020 19:52:00 +0100
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi All,

Its taken quite a bit of debugging and going around in circles but I'm
now 99% sure the remaining "hung" bitbake issues are related to the
SyncThread. It is exiting correctly but taking far too long to do so.
The bitbake-cookerdaemon log for a recent failure is shown below but
the key section is this:

622524 16:21:48.768140 Exiting
622524 16:23:22.923871 Original lockfile
contents: ['622524\n']

i.e. at exit bitbake went AWOL for 94s. This is longer than the 60s=20
connection timeout so this is why other tests failed. Earlier lines in the =
log clearly show the SyncThread had not finished.

I'm not really sure what to do about this, presumably its due to high=20
IO load on on the autobuilders.

I wanted to mention it to show that we are at least able to clearly=20
identify the cause of the rare test failures and the logs are doing a=20
better job of capturing what is going on.

(https://autobuilder.yoctoproject.org/typhoon/#/builders/86/builds/1352 was=
 the build that failed this corresponds to)

Cheers,

Richard

622524 16:21:41.452474 --- Starting bitbake server pid 622524 at 2020-09-12=
 16:21:41.452387 ---
622524 16:21:41.473890 Started bitbake server pid 622524
622524 16:21:41.474361 Entering server connection loop
622524 16:21:41.474703 Accepting [<socket.socket fd=3D6, family=3DAddressFa=
mily.AF_UNIX, type=3DSocketKind.SOCK_STREAM, proto=3D0, laddr=3Dbitbake.soc=
k>] ([])
622524 16:21:41.474800 Processing Client
622524 16:21:41.474910 Connecting Client
622524 16:21:41.475765 Running command ['setFeatures', [2]]
622524 16:21:41.477016 Command Completed
622524 16:21:41.477274 Running command ['updateConfig', {'abort': True, 'fo=
rce': False, 'invalidate_stamp': None, 'dry_run': False, 'dump_signatures':=
 [], 'extra_assume_provided': [], 'profile': False, 'prefile': [], 'postfil=
e': [], 'server_timeout': None, 'nosetscene': False, 'setsceneonly': False,=
 'skipsetscene': False, 'runall': None, 'runonly': None, 'writeeventlog': N=
one, 'build_verbose_shell': False, 'build_verbose_stdout': False, 'default_=
loglevel': 20, 'debug_domains': {}}, {'SHELL': '/bin/bash', 'BB_LOGCONFIG':=
 '/home/pokybuild/yocto-worker/oe-selftest-fedora/build/build-st-3670103/..=
/bitbake/contrib/autobuilderlog.json', 'PWD': '/home/pokybuild/yocto-worker=
/oe-selftest-fedora/build/build-st-3670103', 'LOGNAME': 'pokybuild', 'ftp_p=
roxy': 'http://proxy.yocto.io:5187/', 'HOME': '/home/pokybuild', 'BBPATH': =
'/home/pokybuild/yocto-worker/oe-selftest-fedora/build/build-st-3670103', '=
BB_ENV_EXTRAWHITE': 'ALL_PROXY BBPATH_EXTRA BB_LOGCONFIG BB_NO_NETWORK BB_N=
UMBER_THREADS BB_SETSCENE_ENFORCE BB_SRCREV_POLICY DISTRO FTPS_PROXY FTP_PR=
OXY GIT_PROXY_COMMAND HTTPS_PROXY HTTP_PROXY MACHINE NO_PROXY PARALLEL_MAKE=
 SCREENDIR SDKMACHINE SOCKS5_PASSWD SOCKS5_USER SSH_AGENT_PID SSH_AUTH_SOCK=
 STAMPS_DIR TCLIBC TCMODE all_proxy ftp_proxy ftps_proxy http_proxy https_p=
roxy no_proxy ', 'USER': 'pokybuild', 'FTP_PROXY': 'http://proxy.yocto.io:5=
187/', 'PATH': '/home/pokybuild/yocto-worker/oe-selftest-fedora/build/scrip=
ts:/home/pokybuild/yocto-worker/oe-selftest-fedora/build/bitbake/bin:/home/=
pokybuild/.local/bin:/home/pokybuild/bin:/usr/lib64/ccache:/usr/local/bin:/=
usr/bin:/usr/local/sbin:/usr/sbin', 'LC_ALL': 'en_US.UTF-8', 'HISTCONTROL':=
 'ignoredups', 'HISTSIZE': '1000', 'HOSTNAME': 'fedora31-ty-1', 'ABHELPER_J=
SON': 'config.json /home/pokybuild/config-local.json', '_': '/home/pokybuil=
d/yocto-worker/oe-selftest-fedora/build/bitbake/bin/bitbake', 'LANG': 'en_U=
S.UTF-8', 'LS_COLORS': 'rs=3D0:di=3D38;5;33:ln=3D38;5;51:mh=3D00:pi=3D40;38=
;5;11:so=3D38;5;13:do=3D38;5;5:bd=3D48;5;232;38;5;11:cd=3D48;5;232;38;5;3:o=
r=3D48;5;232;38;5;9:mi=3D01;37;41:su=3D48;5;196;38;5;15:sg=3D48;5;11;38;5;1=
6:ca=3D48;5;196;38;5;226:tw=3D48;5;10;38;5;16:ow=3D48;5;10;38;5;21:st=3D48;=
5;21;38;5;15:ex=3D38;5;40:*.tar=3D38;5;9:*.tgz=3D38;5;9:*.arc=3D38;5;9:*.ar=
j=3D38;5;9:*.taz=3D38;5;9:*.lha=3D38;5;9:*.lz4=3D38;5;9:*.lzh=3D38;5;9:*.lz=
ma=3D38;5;9:*.tlz=3D38;5;9:*.txz=3D38;5;9:*.tzo=3D38;5;9:*.t7z=3D38;5;9:*.z=
ip=3D38;5;9:*.z=3D38;5;9:*.dz=3D38;5;9:*.gz=3D38;5;9:*.lrz=3D38;5;9:*.lz=3D=
38;5;9:*.lzo=3D38;5;9:*.xz=3D38;5;9:*.zst=3D38;5;9:*.tzst=3D38;5;9:*.bz2=3D=
38;5;9:*.bz=3D38;5;9:*.tbz=3D38;5;9:*.tbz2=3D38;5;9:*.tz=3D38;5;9:*.deb=3D3=
8;5;9:*.rpm=3D38;5;9:*.jar=3D38;5;9:*.war=3D38;5;9:*.ear=3D38;5;9:*.sar=3D3=
8;5;9:*.rar=3D38;5;9:*.alz=3D38;5;9:*.ace=3D38;5;9:*.zoo=3D38;5;9:*.cpio=3D=
38;5;9:*.7z=3D38;5;9:*.rz=3D38;5;9:*.cab=3D38;5;9:*.wim=3D38;5;9:*.swm=3D38=
;5;9:*.dwm=3D38;5;9:*.esd=3D38;5;9:*.jpg=3D38;5;13:*.jpeg=3D38;5;13:*.mjpg=
=3D38;5;13:*.mjpeg=3D38;5;13:*.gif=3D38;5;13:*.bmp=3D38;5;13:*.pbm=3D38;5;1=
3:*.pgm=3D38;5;13:*.ppm=3D38;5;13:*.tga=3D38;5;13:*.xbm=3D38;5;13:*.xpm=3D3=
8;5;13:*.tif=3D38;5;13:*.tiff=3D38;5;13:*.png=3D38;5;13:*.svg=3D38;5;13:*.s=
vgz=3D38;5;13:*.mng=3D38;5;13:*.pcx=3D38;5;13:*.mov=3D38;5;13:*.mpg=3D38;5;=
13:*.mpeg=3D38;5;13:*.m2v=3D38;5;13:*.mkv=3D38;5;13:*.webm=3D38;5;13:*.ogm=
=3D38;5;13:*.mp4=3D38;5;13:*.m4v=3D38;5;13:*.mp4v=3D38;5;13:*.vob=3D38;5;13=
:*.qt=3D38;5;13:*.nuv=3D38;5;13:*.wmv=3D38;5;13:*.asf=3D38;5;13:*.rm=3D38;5=
;13:*.rmvb=3D38;5;13:*.flc=3D38;5;13:*.avi=3D38;5;13:*.fli=3D38;5;13:*.flv=
=3D38;5;13:*.gl=3D38;5;13:*.dl=3D38;5;13:*.xcf=3D38;5;13:*.xwd=3D38;5;13:*.=
yuv=3D38;5;13:*.cgm=3D38;5;13:*.emf=3D38;5;13:*.ogv=3D38;5;13:*.ogx=3D38;5;=
13:*.aac=3D38;5;45:*.au=3D38;5;45:*.flac=3D38;5;45:*.m4a=3D38;5;45:*.mid=3D=
38;5;45:*.midi=3D38;5;45:*.mka=3D38;5;45:*.mp3=3D38;5;45:*.mpc=3D38;5;45:*.=
ogg=3D38;5;45:*.ra=3D38;5;45:*.wav=3D38;5;45:*.oga=3D38;5;45:*.opus=3D38;5;=
45:*.spx=3D38;5;45:*.xspf=3D38;5;45:', 'OEQA_DEBUGGING_SAVED_OUTPUT': '/srv=
/autobuilder/autobuilder.yoctoproject.org/pub/repro-fail/', 'TERM': 'xterm-=
256color', 'SCRIPTSDIR': '/home/pokybuild/yocto-worker/oe-selftest-fedora/y=
octo-autobuilder-helper/scripts', 'LESSOPEN': '||/usr/bin/lesspipe.sh %s', =
'DISPLAY': ':1', 'SHLVL': '2', 'BUILDDIR': '/home/pokybuild/yocto-worker/oe=
-selftest-fedora/build/build-st-3670103', 'MAIL': '/var/spool/mail/pokybuil=
d', 'OLDPWD': '/home/pokybuild/yocto-worker/oe-selftest-fedora/build'}, ['/=
home/pokybuild/yocto-worker/oe-selftest-fedora/build/bitbake/bin/bitbake', =
'-e', 'mtools-native']]
622524 16:21:42.182550 Command Completed
622524 16:21:42.183214 Running command ['getVariable', 'BBINCLUDELOGS']
622524 16:21:42.183776 Command Completed
622524 16:21:42.184081 Running command ['getVariable', 'BBINCLUDELOGS_LINES=
']
622524 16:21:42.184568 Command Completed
622524 16:21:42.184851 Running command ['getSetVariable', 'BB_CONSOLELOG']
622524 16:21:42.185600 Command Completed
622524 16:21:42.185880 Running command ['getSetVariable', 'BB_LOGCONFIG']
622524 16:21:42.189834 Command Completed
622524 16:21:42.190294 Running command ['getUIHandlerNum']
622524 16:21:42.190807 Command Completed
622524 16:21:42.191152 Running command ['setEventMask', 1, 20, {'BitBake.Si=
gGen.HashEquiv': 19, 'BitBake.RunQueue.HashEquiv': 19}, ['bb.runqueue.runQu=
eueExitWait', 'bb.event.LogExecTTY', 'logging.LogRecord', 'bb.build.TaskFai=
led', 'bb.build.TaskBase', 'bb.event.ParseStarted', 'bb.event.ParseProgress=
', 'bb.event.ParseCompleted', 'bb.event.CacheLoadStarted', 'bb.event.CacheL=
oadProgress', 'bb.event.CacheLoadCompleted', 'bb.command.CommandFailed', 'b=
b.command.CommandExit', 'bb.command.CommandCompleted', 'bb.cooker.CookerExi=
t', 'bb.event.MultipleProviders', 'bb.event.NoProvider', 'bb.runqueue.scene=
QueueTaskStarted', 'bb.runqueue.runQueueTaskStarted', 'bb.runqueue.runQueue=
TaskFailed', 'bb.runqueue.sceneQueueTaskFailed', 'bb.event.BuildBase', 'bb.=
build.TaskStarted', 'bb.build.TaskSucceeded', 'bb.build.TaskFailedSilent', =
'bb.build.TaskProgress', 'bb.event.ProcessStarted', 'bb.event.ProcessProgre=
ss', 'bb.event.ProcessFinished']]
622524 16:21:42.191650 Command Completed
622524 16:21:42.191940 Running command ['getVariable', 'BB_DEFAULT_TASK']
622524 16:21:42.192446 Command Completed
622524 16:21:42.192733 Running command ['setConfig', 'cmd', 'build']
622524 16:21:42.193208 Command Completed
622524 16:21:42.193482 Running command ['showEnvironmentTarget', ['mtools-n=
ative']]
622524 16:21:42.193909 Command Completed
622524 16:21:48.666380 Processing Client
622524 16:21:48.666545 Disconnecting Client
622524 16:21:48.667019 No timeout, exiting.
622524 16:21:48.768024 More than one thread left?: [<_MainThread(MainThread=
, started 139792596600512)>, <Thread(SyncThread, started 139792284829440)>]
622524 16:21:48.768140 Exiting
622524 16:23:22.923871 Original lockfile contents: ['622524\n']
622524 16:23:22.924338 Exiting as we could obtain the lock
741306 16:23:26.043623 --- Starting bitbake server pid 741306 at 2020-09-12=
 16:23:26.043566 ---
741306 16:23:26.056743 Started bitbake server pid 741306
741306 16:23:26.057200 Entering server connection loop
741306 16:23:26.058629 Accepting [<socket.socket fd=3D6, family=3DAddressFa=
mily.AF_UNIX, type=3DSocketKind.SOCK_STREAM, proto=3D0, laddr=3Dbitbake.soc=
k>] ([])
741306 16:23:26.059628 Processing Client
741306 16:23:26.059740 Connecting Client
741306 16:23:26.060568 Running command ['setFeatures', [2, 1]]
741306 16:23:26.060944 Command Completed
741306 16:23:26.062100 Running command ['updateConfig', {'abort': True, 'fo=
rce': False, 'invalidate_stamp': None, 'dry_run': False, 'dump_signatures':=
 [], 'extra_assume_provided': [], 'profile': False, 'prefile': [], 'postfil=
e': [], 'server_timeout': None, 'nosetscene': False, 'setsceneonly': False,=
 'skipsetscene': False, 'runall': None, 'runonly': None, 'writeeventlog': N=
one, 'build_verbose_shell': False, 'build_verbose_stdout': False, 'default_=
loglevel': 20, 'debug_domains': {}}, {'SHELL': '/bin/bash', 'BB_LOGCONFIG':=
 '/home/pokybuild/yocto-worker/oe-selftest-fedora/build/build-st-3670103/..=
/bitbake/contrib/autobuilderlog.json', 'PWD': '/home/pokybuild/yocto-worker=
/oe-selftest-fedora/build/build-st-3670103', 'LOGNAME': 'pokybuild', 'ftp_p=
roxy': 'http://proxy.yocto.io:5187/', 'HOME': '/home/pokybuild', 'BBPATH': =
'/home/pokybuild/yocto-worker/oe-selftest-fedora/build/build-st-3670103', '=
BB_ENV_EXTRAWHITE': 'ALL_PROXY BBPATH_EXTRA BB_LOGCONFIG BB_NO_NETWORK BB_N=
UMBER_THREADS BB_SETSCENE_ENFORCE BB_SRCREV_POLICY DISTRO FTPS_PROXY FTP_PR=
OXY GIT_PROXY_COMMAND HTTPS_PROXY HTTP_PROXY MACHINE NO_PROXY PARALLEL_MAKE=
 SCREENDIR SDKMACHINE SOCKS5_PASSWD SOCKS5_USER SSH_AGENT_PID SSH_AUTH_SOCK=
 STAMPS_DIR TCLIBC TCMODE all_proxy ftp_proxy ftps_proxy http_proxy https_p=
roxy no_proxy ', 'USER': 'pokybuild', 'FTP_PROXY': 'http://proxy.yocto.io:5=
187/', 'PATH': '/home/pokybuild/yocto-worker/oe-selftest-fedora/build/scrip=
ts:/home/pokybuild/yocto-worker/oe-selftest-fedora/build/bitbake/bin:/home/=
pokybuild/.local/bin:/home/pokybuild/bin:/usr/lib64/ccache:/usr/local/bin:/=
usr/bin:/usr/local/sbin:/usr/sbin', 'LC_ALL': 'en_US.UTF-8', 'HISTCONTROL':=
 'ignoredups', 'HISTSIZE': '1000', 'HOSTNAME': 'fedora31-ty-1', 'ABHELPER_J=
SON': 'config.json /home/pokybuild/config-local.json', '_': '/home/pokybuil=
d/yocto-worker/oe-selftest-fedora/build/bitbake/bin/bitbake-layers', 'LANG'=
: 'en_US.UTF-8', 'LS_COLORS': 'rs=3D0:di=3D38;5;33:ln=3D38;5;51:mh=3D00:pi=
=3D40;38;5;11:so=3D38;5;13:do=3D38;5;5:bd=3D48;5;232;38;5;11:cd=3D48;5;232;=
38;5;3:or=3D48;5;232;38;5;9:mi=3D01;37;41:su=3D48;5;196;38;5;15:sg=3D48;5;1=
1;38;5;16:ca=3D48;5;196;38;5;226:tw=3D48;5;10;38;5;16:ow=3D48;5;10;38;5;21:=
st=3D48;5;21;38;5;15:ex=3D38;5;40:*.tar=3D38;5;9:*.tgz=3D38;5;9:*.arc=3D38;=
5;9:*.arj=3D38;5;9:*.taz=3D38;5;9:*.lha=3D38;5;9:*.lz4=3D38;5;9:*.lzh=3D38;=
5;9:*.lzma=3D38;5;9:*.tlz=3D38;5;9:*.txz=3D38;5;9:*.tzo=3D38;5;9:*.t7z=3D38=
;5;9:*.zip=3D38;5;9:*.z=3D38;5;9:*.dz=3D38;5;9:*.gz=3D38;5;9:*.lrz=3D38;5;9=
:*.lz=3D38;5;9:*.lzo=3D38;5;9:*.xz=3D38;5;9:*.zst=3D38;5;9:*.tzst=3D38;5;9:=
*.bz2=3D38;5;9:*.bz=3D38;5;9:*.tbz=3D38;5;9:*.tbz2=3D38;5;9:*.tz=3D38;5;9:*=
.deb=3D38;5;9:*.rpm=3D38;5;9:*.jar=3D38;5;9:*.war=3D38;5;9:*.ear=3D38;5;9:*=
.sar=3D38;5;9:*.rar=3D38;5;9:*.alz=3D38;5;9:*.ace=3D38;5;9:*.zoo=3D38;5;9:*=
.cpio=3D38;5;9:*.7z=3D38;5;9:*.rz=3D38;5;9:*.cab=3D38;5;9:*.wim=3D38;5;9:*.=
swm=3D38;5;9:*.dwm=3D38;5;9:*.esd=3D38;5;9:*.jpg=3D38;5;13:*.jpeg=3D38;5;13=
:*.mjpg=3D38;5;13:*.mjpeg=3D38;5;13:*.gif=3D38;5;13:*.bmp=3D38;5;13:*.pbm=
=3D38;5;13:*.pgm=3D38;5;13:*.ppm=3D38;5;13:*.tga=3D38;5;13:*.xbm=3D38;5;13:=
*.xpm=3D38;5;13:*.tif=3D38;5;13:*.tiff=3D38;5;13:*.png=3D38;5;13:*.svg=3D38=
;5;13:*.svgz=3D38;5;13:*.mng=3D38;5;13:*.pcx=3D38;5;13:*.mov=3D38;5;13:*.mp=
g=3D38;5;13:*.mpeg=3D38;5;13:*.m2v=3D38;5;13:*.mkv=3D38;5;13:*.webm=3D38;5;=
13:*.ogm=3D38;5;13:*.mp4=3D38;5;13:*.m4v=3D38;5;13:*.mp4v=3D38;5;13:*.vob=
=3D38;5;13:*.qt=3D38;5;13:*.nuv=3D38;5;13:*.wmv=3D38;5;13:*.asf=3D38;5;13:*=
.rm=3D38;5;13:*.rmvb=3D38;5;13:*.flc=3D38;5;13:*.avi=3D38;5;13:*.fli=3D38;5=
;13:*.flv=3D38;5;13:*.gl=3D38;5;13:*.dl=3D38;5;13:*.xcf=3D38;5;13:*.xwd=3D3=
8;5;13:*.yuv=3D38;5;13:*.cgm=3D38;5;13:*.emf=3D38;5;13:*.ogv=3D38;5;13:*.og=
x=3D38;5;13:*.aac=3D38;5;45:*.au=3D38;5;45:*.flac=3D38;5;45:*.m4a=3D38;5;45=
:*.mid=3D38;5;45:*.midi=3D38;5;45:*.mka=3D38;5;45:*.mp3=3D38;5;45:*.mpc=3D3=
8;5;45:*.ogg=3D38;5;45:*.ra=3D38;5;45:*.wav=3D38;5;45:*.oga=3D38;5;45:*.opu=
s=3D38;5;45:*.spx=3D38;5;45:*.xspf=3D38;5;45:', 'OEQA_DEBUGGING_SAVED_OUTPU=
T': '/srv/autobuilder/autobuilder.yoctoproject.org/pub/repro-fail/', 'TERM'=
: 'xterm-256color', 'SCRIPTSDIR': '/home/pokybuild/yocto-worker/oe-selftest=
-fedora/yocto-autobuilder-helper/scripts', 'LESSOPEN': '||/usr/bin/lesspipe=
.sh %s', 'DISPLAY': ':1', 'SHLVL': '2', 'BUILDDIR': '/home/pokybuild/yocto-=
worker/oe-selftest-fedora/build/build-st-3670103', 'MAIL': '/var/spool/mail=
/pokybuild', 'OLDPWD': '/home/pokybuild/yocto-worker/oe-selftest-fedora/bui=
ld'}, ['/home/pokybuild/yocto-worker/oe-selftest-fedora/build/bitbake/bin/b=
itbake-layers', 'remove-layer', '*/workspace']]
741306 16:23:27.145524 Command Completed
741306 16:23:27.147293 Running command ['parseConfiguration']
741306 16:23:27.150737 Command Completed
741306 16:23:27.151143 Running command ['dataStoreConnectorCmd', 0, 'getVar=
', ('BBMULTICONFIG',), {}]
741306 16:23:27.151752 Command Completed
741306 16:23:27.152027 Running command ['dataStoreConnectorCmd', 0, 'getVar=
', ('BBPATH',), {}]
741306 16:23:27.166126 Command Completed
741306 16:23:27.167288 Running command ['dataStoreConnectorCmd', 0, 'getVar=
', ('BBLAYERS',), {}]
741306 16:23:27.167686 Command Completed
741306 16:23:27.168209 Running command ['dataStoreConnectorVarHistCmd', 0, =
'get_variable_items_files', ('BBFILE_COLLECTIONS',), {}]
741306 16:23:27.168629 Command Completed
741306 16:23:27.174122 Running command ['dataStoreConnectorCmd', 0, 'getVar=
', ('BBLAYERS',), {}]
741306 16:23:27.174681 Command Completed
741306 16:23:27.175209 Running command ['dataStoreConnectorVarHistCmd', 0, =
'get_variable_items_files', ('BBFILE_COLLECTIONS',), {}]
741306 16:23:27.175596 Command Completed
741306 16:23:27.178116 Running command ['dataStoreConnectorCmd', 0, 'getVar=
', ('BBLAYERS',), {}]
741306 16:23:27.178561 Command Completed
741306 16:23:27.179106 Running command ['dataStoreConnectorVarHistCmd', 0, =
'get_variable_items_files', ('BBFILE_COLLECTIONS',), {}]
741306 16:23:27.179478 Command Completed
741306 16:23:27.181009 Running command ['dataStoreConnectorCmd', 0, 'getVar=
', ('BBLAYERS',), {}]
741306 16:23:27.181356 Command Completed
741306 16:23:27.181831 Running command ['dataStoreConnectorVarHistCmd', 0, =
'get_variable_items_files', ('BBFILE_COLLECTIONS',), {}]
741306 16:23:27.182228 Command Completed
741306 16:23:27.185289 Running command ['clientComplete']
741306 16:23:27.185479 Command Completed
741306 16:23:27.186830 Processing Client
741306 16:23:27.186927 Disconnecting Client
741306 16:23:27.187233 No timeout, exiting.

