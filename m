Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web12.116352.1597948388340881221
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Aug 2020 11:33:09 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@axis.com header.s=axis-central1 header.b=aXt5/n5k;
 spf=pass (domain: axis.com, ip: 195.60.68.17, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=4459; q=dns/txt; s=axis-central1;
  t=1597948388; x=1629484388;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dDmovmvi8+HOxSa1nUYJ309BpVspOef9QhAVpnzAHk0=;
  b=aXt5/n5khrzVG0kvMQG6o8mcAB4uEvH9khrg+dRAyDpJNk8S2Nkd0pcn
   ES+wdQeBjPdib+aayJWyQYg1Ii3GuooNy/7U4f3sQfVX422UXtak3TMxO
   gkyAf3ddkFQoPBkaU73VA8itQgd9Ojd7fepNl9IyUIbABTAkXqPdhY3lO
   ZDU/qQFIPi5lUqRzlP4kaAuJ1SBJPUmBBAjIvdIASV1hr+ayd9ZyNIWrQ
   IFf0EWzF1LKG8Un9E5rFD0SkRoTHJS3cLYlioZ4SOdQ8Rt9mv19IL921R
   nxFO+irE4JD8MiLB0Gd1B4OUXLC4fK1pjOpf3FKEvqSW1/bvbkKEbSvNu
   Q==;
IronPort-SDR: XaAijUV8dE+wag2eeD4nNson594CnulskONF5LKGiaEYRzwog4dhX3F+vvn0xr1ZgOqVLSuW3p
 MqIOBDgclNepFtnMz2icAlss4izeeoZnR9bpOj9GoO6n80lw60ClD/AdCLk+yeLc0EuVf1lRgw
 4BIoOoMHEgiDNcXQtpWngStNqTlrYK8Xlg9AGNyzt6Q6TH4h7WJxqTtYqyOwGHX23Edtzc507Z
 PnU+f6Tq601SKkFkB72xqWE58n8cf1mkJVmCuhxDuu424rlk16aQJ2sqaN6Zmd4/76lW/rsm+n
 btk=
X-IronPort-AV: E=Sophos;i="5.76,334,1592863200"; 
   d="scan'208";a="12040742"
From: "Peter Kjellerstedt" <peter.kjellerstedt@axis.com>
To: Chris Laplante <chris.laplante@agilent.com>
CC: "BitBake Development (bitbake-devel@lists.openembedded.org)"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: Problem with shell func backtracing and BB_VERBOSE_LOGS
Thread-Topic: Problem with shell func backtracing and BB_VERBOSE_LOGS
Thread-Index: AdZ3H5kzgzO3bGd5QKaII5Jeb0tgLwAAJtXw
Date: Thu, 20 Aug 2020 18:33:05 +0000
Message-ID: <1646d05d5e7740a79978cfcbda7966a6@XBOX03.axis.com>
References: <162D0D4E94A43CAA.19371@lists.openembedded.org>
In-Reply-To: <162D0D4E94A43CAA.19371@lists.openembedded.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
Return-Path: peter.kjellerstedt@axis.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Bah, just ignore this. I just noticed that you have already sent=20
a patch to fix this. :)

//Peter

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-
> devel@lists.openembedded.org> On Behalf Of Peter Kjellerstedt
> Sent: den 20 augusti 2020 20:28
> To: Chris Laplante <chris.laplante@agilent.com>; BitBake Development
> (bitbake-devel@lists.openembedded.org) <bitbake-
> devel@lists.openembedded.org>
> Subject: [bitbake-devel] Problem with shell func backtracing and
> BB_VERBOSE_LOGS
>=20
> The recent changes to improve the logging for failing shell functions
> Does not seem to work correctly when BB_VERBOSE_LOGS is enabled.
>=20
> The following is an example of a build failure with BB_VERBOSE_LOGS
> enabled:
>=20
> | ninja: build stopped: subcommand failed.
> | ++ bb_bash_debug_handler
> | ++ local line=3D1
> | ++ '[' 1 -eq 1 ']'
> | ++ return
> | + bb_bash_exit_handler 'ninja -v -j 16'
> | ++ bb_bash_debug_handler
> | ++ local line=3D14
> | ++ '[' 14 -eq 1 ']'
> | ++ '[' bb_bash_exit_handler '!=3D' bb_bash_exit_handler ']'
> | ++ bb_bash_debug_handler
> | ++ local line=3D15
> | ++ '[' 15 -eq 1 ']'
> | ++ '[' bb_bash_exit_handler '!=3D' bb_bash_exit_handler ']'
> | + ret=3D1
> | ++ bb_bash_debug_handler
> | ++ local line=3D16
> | ++ '[' 16 -eq 1 ']'
> | ++ '[' bb_bash_exit_handler '!=3D' bb_bash_exit_handler ']'
> | + trap '' DEBUG
> | + '[' 1 '!=3D' 0 ']'
> | + echo 'WARNING: <builddir>/tmp/work/cortexa9hf-neon-poky-linux-
> gnueabi/<recipe>/1.1.24-r0/temp/run.do_compile.5204:157 exit 1 from
> '\''ninja -v -j 16'\'''
> | WARNING: <builddir>/tmp/work/cortexa9hf-neon-poky-linux-
> gnueabi/<recipe>/1.1.24-r0/temp/run.do_compile.5204:157 exit 1 from
> 'ninja -v -j 16'
> | + echo 'WARNING: Backtrace (BB generated script): '
> | WARNING: Backtrace (BB generated script):
> | ++ seq 1 3
> | + for i in $(seq 1 $((${#FUNCNAME[@]} - 1)))
> | + '[' 1 -eq 1 ']'
> | + echo -e '   #1: meson_do_compile, <builddir>/tmp/work/cortexa9hf-
> neon-poky-linux-gnueabi/<recipe>/1.1.24-r0/temp/run.do_compile.5204, line
> 157'
> |       #1: meson_do_compile, <builddir>/tmp/work/cortexa9hf-neon-poky-
> linux-gnueabi/<recipe>/1.1.24-r0/temp/run.do_compile.5204, line 157
> | + for i in $(seq 1 $((${#FUNCNAME[@]} - 1)))
> | + '[' 2 -eq 1 ']'
> | + echo -e '   #2: do_compile, <builddir>/tmp/work/cortexa9hf-neon-poky-
> linux-gnueabi/<recipe>/1.1.24-r0/temp/run.do_compile.5204, line 152'
> |       #2: do_compile, <builddir>/tmp/work/cortexa9hf-neon-poky-linux-
> gnueabi/<recipe>/1.1.24-r0/temp/run.do_compile.5204, line 152
> | + for i in $(seq 1 $((${#FUNCNAME[@]} - 1)))
> | + '[' 3 -eq 1 ']'
> | + echo -e '   #3: main, <builddir>/tmp/work/cortexa9hf-neon-poky-linux-
> gnueabi/<recipe>/1.1.24-r0/temp/run.do_compile.5204, line 162'
> |       #3: main, <builddir>/tmp/work/cortexa9hf-neon-poky-linux-
> gnueabi/<recipe>/1.1.24-r0/temp/run.do_compile.5204, line 162
> | + exit 1
> |
> | Backtrace (metadata-relative locations):
> |       #1: meson_do_compile, <workdir>/meta/classes/meson.bbclass, line
> 180
> |       #1: meson_do_compile, <workdir>/meta/classes/meson.bbclass, line
> 180
> |       #2: do_compile, autogenerated, line 2
> |       #2: do_compile, autogenerated, line 2
> |       #3: main, <workdir>/meta/classes/meson.bbclass, line 185
>=20
> And the following is the same build failure, but without BB_VERBOSE_LOGS:
>=20
> | ninja: build stopped: subcommand failed.
> | WARNING: <builddir>/tmp/work/cortexa9hf-neon-poky-linux-
> gnueabi/<recipe>/1.1.24-r0/temp/run.do_compile.6232:157 exit 1 from
> 'ninja -v -j 16'
> | WARNING: Backtrace (BB generated script):
> |       #1: meson_do_compile, <builddir>/tmp/work/cortexa9hf-neon-poky-
> linux-gnueabi/<recipe>/1.1.24-r0/temp/run.do_compile.6232, line 157
> |       #2: do_compile, <builddir>/tmp/work/cortexa9hf-neon-poky-linux-
> gnueabi/<recipe>/1.1.24-r0/temp/run.do_compile.6232, line 152
> |       #3: main, <builddir>/tmp/work/cortexa9hf-neon-poky-linux-
> gnueabi/<recipe>/1.1.24-r0/temp/run.do_compile.6232, line 161
> |
> | Backtrace (metadata-relative locations):
> |       #1: meson_do_compile, <workdir>/meta/classes/meson.bbclass, line
> 180
> |       #2: do_compile, autogenerated, line 2
>=20
> As can be seen, the frames are reported twice when BB_VERBOSE_LOGS is
> enabled. Also interesting is that the third frame is reported when
> BB_VERBOSE_LOGS is enabled (though only once).
>=20
> //Peter
>=20

