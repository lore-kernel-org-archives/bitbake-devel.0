Return-Path: <sam@liddicott.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271DBEEB58A
	for <webhook@archiver.kernel.org>; Thu, 12 Sep 2024 10:41:52 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
 by mx.groups.io with SMTP id smtpd.web11.45127.1726137702748321222
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Sep 2024 03:41:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@liddicott-com.20230601.gappssmtp.com header.s=20230601 header.b=itU10g+h;
 spf=none, err=SPF record not found (domain: liddicott.com, ip: 209.85.208.50, mailfrom: sam@liddicott.com)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c4146c7d5dso847908a12.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 12 Sep 2024 03:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=liddicott-com.20230601.gappssmtp.com; s=20230601; t=1726137700; x=1726742500; darn=lists.openembedded.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nbU+dnHXSuguPbijYZSxie+4U3i5coE72akHkAlncZM=;
        b=itU10g+hnCDpmRqBPflEr19agdjw7jjv0Vg9BUfmxvqRMRjGsuG1Y4fJQycGAn54m0
         pM6g2TxpaPNKIiFlxzskcZaj96/W9j3jxddygK2Cve9mhDyIQ5fPCMHOnTmvIR8crkac
         LqVVpnqz2f6QVYFJ4Cqrgjq7uNQf3dJjHs9twTb97zcbkLn3+J0sFsD1uKFJRVddu7Lh
         V56CRjUCWK29osjvl1hCeCec4dJRDwIZVEsLRdkxxyEIRDhxRZgrT/KPTJfjOSGKiM0d
         kosblRVjrP5ez0ZHE88x7gBhPIEfRXkRxEUiU1uY18fXQ5fQewqLA1AlfxVi+JYHn6J/
         r0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726137700; x=1726742500;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nbU+dnHXSuguPbijYZSxie+4U3i5coE72akHkAlncZM=;
        b=bXy+wDRZEoEkEVFCzD/lQ6rogJzJUm1dMSdfqMtF98zloBCcJL8IEpBIvc737E6T5x
         MHaFSM27zkZuaQk9yzMt8p1Mgk2Ph8r07Z4Y8Wo5PaaBUlo0Wb3Ie3mLeyVynfK/fMej
         kWZZCsaSLNqBBt3iai+Fw2B2AcNe+f4qZ1d6M/kYn2p6hbK+AsFTA11b5789hrjoYyoX
         YoGWSzRcVwFclkVZo34OW0puWa4o9RCcy+ROaERFV3s2vQl260RbJFytoQkXQiYfew1H
         s0LFrUoWEFXW/G34o+iF5aBqXIYtjPH3ULmFHNbcBFqdTxo0ni+9Vc5eOn6Z3lmHGDzD
         BX5g==
X-Gm-Message-State: AOJu0Yzpp1h6MC/oUKSzV0GaBkzuFK3y6WQ5nd5Zgx9zdSIbv3CsKgCn
	JLVyzbSZd5n9HBKcacK2x70Kvo+cCBeXV9nI1lV5k47+xMqQ4HDZWPNzzMArdrgVZWI/t8Iogb+
	kgiLEDWQcHPAqCSSWaulxfZnycQ6fpZyTMPSnXx5Xz9HpOhhe1A==
X-Google-Smtp-Source: AGHT+IHe4ZjSpU/Yxv3LE/+zljsqNz0jTaKc3yx+g2OuRkRC0yuvd4eLyi5KQwuy+TEEOcsh34B0gfUX5zNEHUXj1OQ=
X-Received: by 2002:a05:6402:240a:b0:5c2:5cf1:70e2 with SMTP id
 4fb4d7f45d1cf-5c413e27c63mr1927285a12.20.1726137699798; Thu, 12 Sep 2024
 03:41:39 -0700 (PDT)
MIME-Version: 1.0
From: Sam Liddicott <sam@liddicott.com>
Date: Thu, 12 Sep 2024 11:41:03 +0100
Message-ID: <CAOj-5WA1uD=aTC19Osn4ZHf2-+AyYpXOTWtWxGeK_4O=rv2CAg@mail.gmail.com>
Subject: fix kernel menuconfig failure due to shell composition fault in cml1.bbclass
To: bitbake-devel@lists.openembedded.org
Content-Type: multipart/mixed; boundary="0000000000006e4f410621e9c096"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Sep 2024 10:41:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16555

--0000000000006e4f410621e9c096
Content-Type: multipart/alternative; boundary="0000000000006e4f3e0621e9c094"

--0000000000006e4f3e0621e9c094
Content-Type: text/plain; charset="UTF-8"

Function do_menuconfig in cml1.bbclass has a problem with the composition
of the shell command, manifest when KCONFIG_CONFIG_COMMAND contains " which
it often may, e.g.
    KCONFIG_CONFIG_COMMAND="menuconfig CC=\"ccache x86_64-sublime-linux-gcc
  -fuse-ld=bfd\" ..."

Without the fix, this command fails for me on kirkstone:
    bitbake linux-intel -c menuconfig

which generates a hidden error that requires a degree in archeology to
unearth:
    0: linux-intel-5.15.94+... do_menuconfig - 0s (pid 3056478)
    Trying to run: screen -r devshell_3056478
      GEN     Makefile
    ccache: unknown compiler
    scripts/Kconfig.include:44: Sorry, this compiler is not supported.
    make[1]: *** [.../kernel-source/scripts/kconfig/Makefile:48:
menuconfig] Error 1
    make: *** [.../kernel-source/Makefile:620: menuconfig] Error 2
    screen is terminating]

which is because the invoked command was effectively:
    make menuconfig "CC=ccache" x86_64-sublime-linux-gcc ...
and as extra args are ignored, it is the same as:
    make menuconfig "CC=ccache"

kernel menuconfig can succeed in some manner for other kernels and
architectures and open embedded releases, although it is still subject to
ignoring most of KCONFIG_CONFIG_COMMAND, perhaps depending whether or not a
kernel has previously been build (avoiding the need to invoke a broken
compiler for menuconfig)

As mentioned, the problem is that a " can terminate the value of the -c
argument in this line:
    oe_terminal("sh -c \"make %s; ....
causing the rest of KCONFIG_CONFIG_COMMAND to become additional (and
ignored) numeric arguments from $0 onwards.

This also means that the error handler "Command failed.' and 'Press any key
to continue..." doesn't work.

I attach three alternative patches, depending which approach the
maintainers want to take.

Patch 1 uses the shell to dynamically compose the shell command by means of
"$@" which is a great trick I've used for years when the arguments already
exist as a shell-safe list. This means that there is no need to escape the
make arguments.

Patch 2 uses shlex.quote which of course requires python >= 3.3 so one of
the other patches may be needed for some of older open embedded releases

Patch 3 uses .replace() and is likely inadequate but could be a preferred
starting point for maintainers if they don't like patch 1 and want to avoid
shlex in patch 2, but would rather roll their own.

--0000000000006e4f3e0621e9c094
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Function=C2=A0do_menuconfig in=C2=A0cml1.bbclass has =
a problem with the composition of the shell command, manifest when=C2=A0KCO=
NFIG_CONFIG_COMMAND contains &quot; which it often may, e.g.</div><div><fon=
t face=3D"monospace">=C2=A0 =C2=A0 KCONFIG_CONFIG_COMMAND=3D&quot;menuconfi=
g=C2=A0CC=3D\&quot;ccache=C2=A0</font>x86_64<font face=3D"monospace">-subli=
me-linux-gcc =C2=A0 -fuse-ld=3Dbfd\&quot; ...&quot;</font><br></div><div><b=
r></div><div>Without the fix, this command fails for me on kirkstone:<br></=
div><div><div><font face=3D"monospace">=C2=A0 =C2=A0 bitbake linux-intel -c=
 menuconfig</font><br></div><div><br></div><div>which generates a hidden er=
ror that requires a degree in archeology to unearth:</div><div><font face=
=3D"monospace">=C2=A0 =C2=A0=C2=A00: linux-intel-5.15.94+... do_menuconfig =
- 0s (pid 3056478)<br>=C2=A0 =C2=A0=C2=A0Trying to run: screen -r devshell_=
3056478<br>=C2=A0 =C2=A0=C2=A0=C2=A0 GEN =C2=A0 =C2=A0 Makefile<br>=C2=A0 =
=C2=A0=C2=A0ccache: unknown compiler<br>=C2=A0 =C2=A0=C2=A0scripts/Kconfig.=
include:44: Sorry, this compiler is not supported.<br>=C2=A0 =C2=A0=C2=A0ma=
ke[1]: *** [.../kernel-source/scripts/kconfig/Makefile:48: menuconfig] Erro=
r 1<br>=C2=A0 =C2=A0=C2=A0make: *** [.../kernel-source/Makefile:620: menuco=
nfig] Error 2<br>=C2=A0 =C2=A0 screen is terminating]<br></font><br>which i=
s because the invoked command was effectively:</div><div><font face=3D"mono=
space">=C2=A0 =C2=A0 make menuconfig &quot;CC=3Dccache&quot;=C2=A0</font>x8=
6_64<font face=3D"monospace">-sublime-linux-gcc ...</font><br>and as extra =
args are ignored, it is the same as:</div><div><font face=3D"monospace">=C2=
=A0 =C2=A0 make menuconfig &quot;CC=3Dccache&quot;</font><br><br></div></di=
v><div>kernel menuconfig can succeed in some manner for other kernels and a=
rchitectures and open embedded releases, although it is still subject to ig=
noring most of KCONFIG_CONFIG_COMMAND, perhaps depending whether or not a k=
ernel has previously been build (avoiding the need to invoke a broken compi=
ler for menuconfig)</div><div><br></div><div>As mentioned, the problem is t=
hat a &quot; can terminate the value of the -c argument in this line:<br></=
div><div><div><font face=3D"monospace">=C2=A0 =C2=A0=C2=A0oe_terminal(&quot=
;sh -c \&quot;make %s; ....</font></div><div>causing the rest of KCONFIG_CO=
NFIG_COMMAND to become additional (and ignored) numeric arguments from $0 o=
nwards.</div><div><br></div><div>This also means that the error handler &qu=
ot;Command failed.&#39; and &#39;Press any key to continue...&quot; doesn&#=
39;t work.</div><div><br></div></div><div>I attach three alternative patche=
s, depending which approach the maintainers want to take.</div><div><br></d=
iv><div>Patch 1 uses the shell to dynamically compose the shell command by =
means of &quot;$@&quot; which is a great trick I&#39;ve used for years when=
 the arguments already exist as a shell-safe list. This means that there is=
 no need to escape the make arguments.</div><div><br></div><div>Patch 2 use=
s shlex.quote which of course requires python &gt;=3D 3.3 so one of the oth=
er patches may be needed for some of older open embedded releases<br></div>=
<div><br></div><div>Patch 3 uses .replace() and is likely inadequate but co=
uld be a preferred starting point for maintainers if they don&#39;t like pa=
tch 1 and want to avoid shlex in patch 2, but would rather roll their own.<=
/div><div><br></div></div>

--0000000000006e4f3e0621e9c094--

--0000000000006e4f410621e9c096
Content-Type: text/x-patch; charset="US-ASCII"; name="cml1-menuconfig-bash-compose.patch"
Content-Disposition: attachment; 
	filename="cml1-menuconfig-bash-compose.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m0z5f0zt0>
X-Attachment-Id: f_m0z5f0zt0

RnJvbSAxODNmYTlkNWM2MDIwMjkyODdlYjIzMWJiMWM4ZWI0ODU3NjFiODgzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYW0gTGlkZGljb3R0IDxzYW1AbGlkZGljb3R0LmNvbT4KRGF0
ZTogVGh1LCAxMiBTZXAgMjAyNCAxMDowOTozNyArMDEwMApTdWJqZWN0OiBhdm9pZCBzaCBjb21w
b3NpdGlvbiBwcm9ibGVtIGluIEtDT05GSUdfQ09ORklHX0NPTU1BTkQgZm9yIGRvX21lbnVjb25m
aWcKClRoZSBwcm9ibGVtIHdpdGggY29tcG9zaW5nIHNoZWxsIGZyZ2FtZW50cyBpbiBweXRob24g
bGlrZSB0aGlzOgogICAgb2VfdGVybWluYWwoInNoIC1jIFwibWFrZSAlcyAuLi4iICUgYXJncyAu
Li4KaXMgdGhhdCBpZiBhcmdzIGNvbnRhaW5zICIgdGhpcyBjYW4gdGVybWluYXRlIHRoZSBjb21t
YW5kIHRoYXQgaXMKcGFzc2VkIHRvIHNoIC1jLCBhbmQgdGhlIHJlbWFpbmRlciBvZiBhcmdzIHdp
bGwgYmVjb21lIGFkZGl0aW9uYWwKYXJndW1lbnRzIHRvIHRoZSBzaGVsbCBjb21tYW5kLCBhdmFp
bGFibGUgYXMgJDAgb253YXJkcy4KClRoYXQgYWxzbyBoYXMgdGhlIGVmZmVjdCBvZiBicmVha2lu
ZyB0aGUgIkNvbW1hbmQgZmFpbGVkIiBhbmQKdGhlICJQcmVzcyBhbnkga2V5IHRvIGNvbnRpbnVl
Li4uIiBtZXNzYWdlcy4KClRoaXMgcGF0Y2ggZG9lcyBub3QgY29tcG9zZSB0aGUgY29tbWFuZHMg
aW4gcHl0aG9uLCBidXQgaW5zdGVhZCBoYXMKdGhlIHNoZWxsIGNvbW1hbmQgcGVyZm9ybSB0aGUg
Y29tcG9zaXRpb24gdXNpbmcgIiRAIiBhbmQgcGFzc2luZyB0aGUKY29tbWFuZCBhcyBhcmd1bWVu
dHM6CiAgICBvZV90ZXJtaW5hbCgic2ggLWMgXCJtYWtlIFxcXCJcXCRAXFxcIiAuLi4gJXMgIiAl
IGR1bW15IGFyZ3MgLi4uClRoZSBkdW1teSB2YWx1ZSBiZWNvbWVzICQwIGFuZCB0aGUgcmVzdCBv
ZiBhcmdzIGlzIHdvcmQtc3BsaXQgYXMgbm9ybWFsCmJlY29taW5nIGluZGl2aWR1YWwgYXJndW1l
bnRzIGF2YWlsYWJsZSB1bmNoYW5nZWQgYXMgJCJAIiBpbiB0aGUgc2hlbGwKCk9uIGVmZmVjdCBv
ZiB0aGlzIG1ldGhvZCBpcyB0aGF0IGFyZ3MgbXVzdCBiZSBhIHNpbXBsZSBzaW5nbGUKbGlzdCBv
ZiBjb21tYW5kcyB3aXRob3V0IHJlZGlyZWN0aW9ucywgcGlwZWxpbmVzLCAmJiwgfHwsIG9yIDsK
ClRoZSBtYWluIGFkdmFudGFnZSBvZiB0aGlzIG1ldGhvZCBpcyB0aGF0IHRoZSBhcmdzIGFyZSBj
b21wb3NlZCB3aXRob3V0CmVzY2FwaW5nLCBzbyB0aGVyZSBjYW4gYmUgbm8gYnVncyBkdWUgdG8g
ZXJyb3JzIGluIGVzY2FwaW5nLCBob3dldmVyCmdpdmVuIHRoYXQgd2UgYXJlIGp1c3QgcGFzc2lu
ZyBhcmd1bWVudHMgdG8gYSBzaW5nbGUgZXhwbGl0ICJtYWtlIgpjb21tYW5kIEkgdGhpbmsgdGhh
dCBpcyBhY2NlcHRhYmxlCgotLS0KIG1ldGEvY2xhc3Nlcy9jbWwxLmJiY2xhc3MgfCAyICstCiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQg
YS9tZXRhL2NsYXNzZXMvY21sMS5iYmNsYXNzIGIvbWV0YS9jbGFzc2VzL2NtbDEuYmJjbGFzcwpp
bmRleCBkMzE5ZDY2YWIyLi4wZGJhZjI1YjhlIDEwMDY0NAotLS0gYS9tZXRhL2NsYXNzZXMvY21s
MS5iYmNsYXNzCisrKyBiL21ldGEvY2xhc3Nlcy9jbWwxLmJiY2xhc3MKQEAgLTQ4LDcgKzQ4LDcg
QEAgcHl0aG9uIGRvX21lbnVjb25maWcoKSB7CiAgICAgIyBlbnN1cmUgdGhhdCBlbnZpcm9ubWVu
dCB2YXJpYWJsZXMgYXJlIG92ZXJ3cml0dGVuIHdpdGggdGhpcyB0YXNrcyAnZCcgdmFsdWVzCiAg
ICAgZC5hcHBlbmRWYXIoIk9FX1RFUk1JTkFMX0VYUE9SVFMiLCAiIFBLR19DT05GSUdfRElSIFBL
R19DT05GSUdfUEFUSCBQS0dfQ09ORklHX0xJQkRJUiBQS0dfQ09ORklHX1NZU1JPT1RfRElSIikK
IAotICAgIG9lX3Rlcm1pbmFsKCJzaCAtYyBcIm1ha2UgJXM7IGlmIFsgXFwkPyAtbmUgMCBdOyB0
aGVuIGVjaG8gJ0NvbW1hbmQgZmFpbGVkLic7IHByaW50ZiAnUHJlc3MgYW55IGtleSB0byBjb250
aW51ZS4uLiAnOyByZWFkIHI7IGZpXCIiICUgZC5nZXRWYXIoJ0tDT05GSUdfQ09ORklHX0NPTU1B
TkQnKSwKKyAgICBvZV90ZXJtaW5hbCgic2ggLWMgXCJtYWtlIFxcXCJcXCRAXFxcIiA7IGlmIFsg
XFwkPyAtbmUgMCBdOyB0aGVuIGVjaG8gJ0NvbW1hbmQgZmFpbGVkLic7IHByaW50ZiAnUHJlc3Mg
YW55IGtleSB0byBjb250aW51ZS4uLiAnOyByZWFkIHI7IGZpXCIgb2VfdGVybWluYWwtY21kICVz
ICIgJSBkLmdldFZhcignS0NPTkZJR19DT05GSUdfQ09NTUFORCcpLAogICAgICAgICAgICAgICAg
IGQuZ2V0VmFyKCdQTicpICsgJyBDb25maWd1cmF0aW9uJywgZCkKIAogICAgICMgRklYTUUgdGhp
cyBjaGVjayBjYW4gYmUgcmVtb3ZlZCB3aGVuIHRoZSBtaW5pbXVtIGJpdGJha2UgdmVyc2lvbiBo
YXMgYmVlbiBidW1wZWQKLS0gCjIuNDMuMAoK
--0000000000006e4f410621e9c096
Content-Type: text/x-patch; charset="US-ASCII"; name="cml1-menuconfig-shlex-quote.patch"
Content-Disposition: attachment; 
	filename="cml1-menuconfig-shlex-quote.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m0z5f7lh1>
X-Attachment-Id: f_m0z5f7lh1

RnJvbSA2ZmVhMGIyMGQ2MmI3Y2NkODQ0NzU0YWViZWY3NmJkNjc1ZDcyMTY1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYW0gTGlkZGljb3R0IDxzYW1AbGlkZGljb3R0LmNvbT4KRGF0
ZTogVGh1LCAxMiBTZXAgMjAyNCAxMDowOTozNyArMDEwMApTdWJqZWN0OiBlc2NhcGUgIiBpbiBL
Q09ORklHX0NPTkZJR19DT01NQU5EIGZvciBkb19tZW51Y29uZmlnCgpUaGUgcHJvYmxlbSB3aXRo
IGNvbXBvc2luZyBzaGVsbCBmcmdhbWVudHMgaW4gcHl0aG9uIGxpa2UgdGhpczoKICAgIG9lX3Rl
cm1pbmFsKCJzaCAtYyBcIm1ha2UgJXMgLi4uIiAlIGFyZ3MgLi4uCmlzIHRoYXQgaWYgYXJncyBj
b250YWlucyAiIHRoaXMgY2FuIHRlcm1pbmF0ZSB0aGUgY29tbWFuZCB0aGF0IGlzCnBhc3NlZCB0
byBzaCAtYywgYW5kIHRoZSByZW1haW5kZXIgb2YgYXJncyB3aWxsIGJlY29tZSBhZGRpdGlvbmFs
CmFyZ3VtZW50cyB0byB0aGUgc2hlbGwgY29tbWFuZCwgYXZhaWxhYmxlIGFzICQwIG9ud2FyZHMu
CgpUaGF0IGFsc28gaGFzIHRoZSBlZmZlY3Qgb2YgYnJlYWtpbmcgdGhlICJDb21tYW5kIGZhaWxl
ZCIgYW5kCnRoZSAiUHJlc3MgYW55IGtleSB0byBjb250aW51ZS4uLiIgbWVzc2FnZXMuCgpUaGlz
IHBhdGNoIHVzZXMgc2hsZXgucXVvdGUgZm9yIGNvbXBvc2luZyB3aXRoIHB5dGhvbi4KICAgIG9l
X3Rlcm1pbmFsKCJzaCAtYyAnbWFrZSAnJXMgXCIuLi4iICUgc2hsZXgucXVvdGUoYXJncykgLi4u
CmFuZCB0YWtlcyBjYXJlIHRvIGhhdmUgdGhlIHNoZWxsIGNvbmNhdGVuYXRlICdtYWtlICcgd2l0
aCB0aGUKd2l0aCB0aGUgZXNjYXBlZCBhcmdzLCBhbmQgZGVwZW5kcyBvbiB0aGUgZmFjdCB0aGF0
IHNobGV4LnF1b3RlCndpbGwgbm90IGludHJvZHVjZSBleHRyYSBzcGFjZSBzdXJyb3VuZGluZyBp
dHMgb3V0cHV0LgoKLS0tCiBtZXRhL2NsYXNzZXMvY21sMS5iYmNsYXNzIHwgMiArLQogMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvbWV0
YS9jbGFzc2VzL2NtbDEuYmJjbGFzcyBiL21ldGEvY2xhc3Nlcy9jbWwxLmJiY2xhc3MKaW5kZXgg
ZDMxOWQ2NmFiMi4uZjY3MjdjNWMzMyAxMDA2NDQKLS0tIGEvbWV0YS9jbGFzc2VzL2NtbDEuYmJj
bGFzcworKysgYi9tZXRhL2NsYXNzZXMvY21sMS5iYmNsYXNzCkBAIC0zMCw2ICszMCw3IEBAIEtD
T05GSUdfQ09ORklHX0NPTU1BTkQgPz89ICJtZW51Y29uZmlnIgogS0NPTkZJR19DT05GSUdfUk9P
VERJUiA/Pz0gIiR7Qn0iCiBweXRob24gZG9fbWVudWNvbmZpZygpIHsKICAgICBpbXBvcnQgc2h1
dGlsCisgICAgaW1wb3J0IHNobGV4CiAKICAgICBjb25maWcgPSBvcy5wYXRoLmpvaW4oZC5nZXRW
YXIoJ0tDT05GSUdfQ09ORklHX1JPT1RESVInKSwgIi5jb25maWciKQogICAgIGNvbmZpZ29yaWcg
PSBvcy5wYXRoLmpvaW4oZC5nZXRWYXIoJ0tDT05GSUdfQ09ORklHX1JPT1RESVInKSwgIi5jb25m
aWcub3JpZyIpCkBAIC00OCw3ICs0OSw3IEBAIHB5dGhvbiBkb19tZW51Y29uZmlnKCkgewogICAg
ICMgZW5zdXJlIHRoYXQgZW52aXJvbm1lbnQgdmFyaWFibGVzIGFyZSBvdmVyd3JpdHRlbiB3aXRo
IHRoaXMgdGFza3MgJ2QnIHZhbHVlcwogICAgIGQuYXBwZW5kVmFyKCJPRV9URVJNSU5BTF9FWFBP
UlRTIiwgIiBQS0dfQ09ORklHX0RJUiBQS0dfQ09ORklHX1BBVEggUEtHX0NPTkZJR19MSUJESVIg
UEtHX0NPTkZJR19TWVNST09UX0RJUiIpCiAKLSAgICBvZV90ZXJtaW5hbCgic2ggLWMgXCJtYWtl
ICVzOyBpZiBbIFxcJD8gLW5lIDAgXTsgdGhlbiBlY2hvICdDb21tYW5kIGZhaWxlZC4nOyBwcmlu
dGYgJ1ByZXNzIGFueSBrZXkgdG8gY29udGludWUuLi4gJzsgcmVhZCByOyBmaVwiIiAlIGQuZ2V0
VmFyKCdLQ09ORklHX0NPTkZJR19DT01NQU5EJyksCisgICAgb2VfdGVybWluYWwoInNoIC1jICdt
YWtlICclc1wiOyBpZiBbIFxcJD8gLW5lIDAgXTsgdGhlbiBlY2hvICdDb21tYW5kIGZhaWxlZC4n
OyBwcmludGYgJ1ByZXNzIGFueSBrZXkgdG8gY29udGludWUuLi4gJzsgcmVhZCByOyBmaVwiIiAl
IHNobGV4LnF1b3RlKGQuZ2V0VmFyKCdLQ09ORklHX0NPTkZJR19DT01NQU5EJykpLAogICAgICAg
ICAgICAgICAgIGQuZ2V0VmFyKCdQTicpICsgJyBDb25maWd1cmF0aW9uJywgZCkKIAogICAgICMg
RklYTUUgdGhpcyBjaGVjayBjYW4gYmUgcmVtb3ZlZCB3aGVuIHRoZSBtaW5pbXVtIGJpdGJha2Ug
dmVyc2lvbiBoYXMgYmVlbiBidW1wZWQKLS0gCjIuNDMuMAoK
--0000000000006e4f410621e9c096
Content-Type: text/x-patch; charset="US-ASCII"; name="cml1-menuconfig-replace-bad.patch"
Content-Disposition: attachment; 
	filename="cml1-menuconfig-replace-bad.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m0z5ffn62>
X-Attachment-Id: f_m0z5ffn62

RnJvbSA2ZmVhMGIyMGQ2MmI3Y2NkODQ0NzU0YWViZWY3NmJkNjc1ZDcyMTY1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYW0gTGlkZGljb3R0IDxzYW1AbGlkZGljb3R0LmNvbT4KRGF0
ZTogVGh1LCAxMiBTZXAgMjAyNCAxMDowOTozNyArMDEwMApTdWJqZWN0OiBlc2NhcGUgIiBpbiBL
Q09ORklHX0NPTkZJR19DT01NQU5EIGZvciBkb19tZW51Y29uZmlnCgpUaGUgcHJvYmxlbSB3aXRo
IGNvbXBvc2luZyBzaGVsbCBmcmdhbWVudHMgaW4gcHl0aG9uIGxpa2UgdGhpczoKICAgIG9lX3Rl
cm1pbmFsKCJzaCAtYyBcIm1ha2UgJXMgLi4uIiAlIGFyZ3MgLi4uCmlzIHRoYXQgaWYgYXJncyBj
b250YWlucyAiIHRoaXMgY2FuIHRlcm1pbmF0ZSB0aGUgY29tbWFuZCB0aGF0IGlzCnBhc3NlZCB0
byBzaCAtYywgYW5kIHRoZSByZW1haW5kZXIgb2YgYXJncyB3aWxsIGJlY29tZSBhZGRpdGlvbmFs
CmFyZ3VtZW50cyB0byB0aGUgc2hlbGwgY29tbWFuZCwgYXZhaWxhYmxlIGFzICQwIG9ud2FyZHMu
CgpUaGF0IGFsc28gaGFzIHRoZSBlZmZlY3Qgb2YgYnJlYWtpbmcgdGhlICJDb21tYW5kIGZhaWxl
ZCIgYW5kCnRoZSAiUHJlc3MgYW55IGtleSB0byBjb250aW51ZS4uLiIgbWVzc2FnZXMuCgpUaGlz
IHBhdGNoIGVzY2FwZXMgYWxsICIgYW5kIFwgaW4gYXJncyB3aXRoIGEgYmFja3NsYXNoLCBzdWl0
YWJsZQpmb3IgY29tcG9zaW5nIHdpdGggcHl0aG9uLgogICAgb2VfdGVybWluYWwoInNoIC1jIFwi
bWFrZSAlcyAuLi4iICUgYXJncy5yZXBsYWNlKCJcIiIsICJcXFwiIikgLi4uCmFsbCBpbnN0YW5j
ZXMgb2YgIiBiZWNvbWUgXCIgaW4gdGhlIGNvbW1hbmQgaW52b2NhdGlvbi4KCkhvd2V2ZXIgdGhv
c2UgZXNjYXBlcyBtYXkgYmUgYnVnZ3ksIGFuZCBJJ20gbm90IGNvbmZpZGVudCB0aGF0IHRoZXkK
YXJlIHN1ZmZpY2llbnQuCgotLS0KIG1ldGEvY2xhc3Nlcy9jbWwxLmJiY2xhc3MgfCAyICstCiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQg
YS9tZXRhL2NsYXNzZXMvY21sMS5iYmNsYXNzIGIvbWV0YS9jbGFzc2VzL2NtbDEuYmJjbGFzcwpp
bmRleCBkMzE5ZDY2YWIyLi5mNjcyN2M1YzMzIDEwMDY0NAotLS0gYS9tZXRhL2NsYXNzZXMvY21s
MS5iYmNsYXNzCisrKyBiL21ldGEvY2xhc3Nlcy9jbWwxLmJiY2xhc3MKQEAgLTQ4LDcgKzQ4LDcg
QEAgcHl0aG9uIGRvX21lbnVjb25maWcoKSB7CiAgICAgIyBlbnN1cmUgdGhhdCBlbnZpcm9ubWVu
dCB2YXJpYWJsZXMgYXJlIG92ZXJ3cml0dGVuIHdpdGggdGhpcyB0YXNrcyAnZCcgdmFsdWVzCiAg
ICAgZC5hcHBlbmRWYXIoIk9FX1RFUk1JTkFMX0VYUE9SVFMiLCAiIFBLR19DT05GSUdfRElSIFBL
R19DT05GSUdfUEFUSCBQS0dfQ09ORklHX0xJQkRJUiBQS0dfQ09ORklHX1NZU1JPT1RfRElSIikK
IAotICAgIG9lX3Rlcm1pbmFsKCJzaCAtYyBcIm1ha2UgJXM7IGlmIFsgXFwkPyAtbmUgMCBdOyB0
aGVuIGVjaG8gJ0NvbW1hbmQgZmFpbGVkLic7IHByaW50ZiAnUHJlc3MgYW55IGtleSB0byBjb250
aW51ZS4uLiAnOyByZWFkIHI7IGZpXCIiICUgZC5nZXRWYXIoJ0tDT05GSUdfQ09ORklHX0NPTU1B
TkQnKSwKKyAgICBvZV90ZXJtaW5hbCgic2ggLWMgXCJtYWtlICVzOyBpZiBbIFxcJD8gLW5lIDAg
XTsgdGhlbiBlY2hvICdDb21tYW5kIGZhaWxlZC4nOyBwcmludGYgJ1ByZXNzIGFueSBrZXkgdG8g
Y29udGludWUuLi4gJzsgcmVhZCByOyBmaVwiIiAlIGQuZ2V0VmFyKCdLQ09ORklHX0NPTkZJR19D
T01NQU5EJykucmVwbGFjZSgiXFwiLCAiXFxcXCIpLnJlcGxhY2UoIlwiIiwgIlxcXCIiKSwKICAg
ICAgICAgICAgICAgICBkLmdldFZhcignUE4nKSArICcgQ29uZmlndXJhdGlvbicsIGQpCiAKICAg
ICAjIEZJWE1FIHRoaXMgY2hlY2sgY2FuIGJlIHJlbW92ZWQgd2hlbiB0aGUgbWluaW11bSBiaXRi
YWtlIHZlcnNpb24gaGFzIGJlZW4gYnVtcGVkCi0tIAoyLjQzLjAKCg==
--0000000000006e4f410621e9c096--

