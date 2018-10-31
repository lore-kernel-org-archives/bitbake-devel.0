Return-Path: <farges.thibault@gmail.com>
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
	[209.85.128.46])
	by mail.openembedded.org (Postfix) with ESMTP id 9F84979CCC
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 Oct 2018 15:37:23 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id b203-v6so14976408wme.5
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 Oct 2018 08:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=ZAy8o21QbzCjwZY94uQQDb8e0FOO9HNhZpa186wXzQo=;
	b=UuTU/BTDu0e5JmXColBKzzNeSCdjKgMwGoa8LtatSKnDx4cEuwTtYFya4Sns0XW+Qr
	sJNeKJkxyB807dQP2BjB75yuTuGlEVawZVXzJ+m61+d0JAlr07JVTmsSYxgYBSTjI+H1
	oHIeIYQyccLEbpOiE6Ho1Id3N6ju/ss2Ga8Nfe0nJbLTYD89uLglBVAjxZpKF6fiV8Vo
	aiRI6GTbiihB6+B+4qxJPqTBKfNCxgLPChPckm7K5zZUdWrYkZrZboHA3Ns1/N2570vl
	3vHcPK+Fw9n1pBX4cuR5pZsExYxgmCg6NB0Kgqwk5UYT5goucINdxYpKmSvEHAECmjoX
	5vkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=ZAy8o21QbzCjwZY94uQQDb8e0FOO9HNhZpa186wXzQo=;
	b=UUKKsRjVdyMbqvhV0SLhCVn8vV/AjKBBs/4epaDraIW2Ek6SpuHskXXPZ0ASxiNoDz
	U8nj1AdiabzYyEpblyje0dM1RPErT703Dkqw9LScb7TQPHqMMlmtZwsFPjitxw7mcv64
	0+9ms8PTiNW9uab+QkkbskCrNMqekUAYS4J0KJHrEW2oFa9h3nX7hO4rvWiiZnuk4Deh
	G7uabcGg9FwWf4Ez+PAtd5dIugwaWVuwS0g7f/V3X2ShbJYLb4bLb7mlrbwsA3QPxrlY
	DHUUtMrey05t0ZCwd0R6jVXBRVMECpNf5kTP5Zm4TjN4AJe2KkqIdObFDv5y1wGwOhJw
	xw0Q==
X-Gm-Message-State: AGRZ1gJ6qTIPWi+cL3HR4L9LRNvosJp76msHSjNeGkZx20dBbsWWIBy7
	fQMUlciLBqY364lV5caNLYH0Ip4QZ5XgaCNYIjLUOQ==
X-Google-Smtp-Source: AJdET5faeLcEjaYsD3yjIbNjl4dqrjjSDTsGgwdq/8j4WScOdgYN+h01+NglUNgY/Ojf2aYse5ASHAr4XafBn5gOIYs=
X-Received: by 2002:a1c:ed07:: with SMTP id l7-v6mr2780051wmh.47.1541000243742;
	Wed, 31 Oct 2018 08:37:23 -0700 (PDT)
MIME-Version: 1.0
From: Thibault FARGES <farges.thibault@gmail.com>
Date: Wed, 31 Oct 2018 16:37:09 +0100
Message-ID: <CAN2wb4S17wtEh7zMUa3BpQNvxWu9=b-Kwi3Ktjgy6VQJgBePFw@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
X-Mailman-Approved-At: Thu, 01 Nov 2018 13:54:44 +0000
Subject: Pre-installation of software in tar.gz form with Yocto/BitBake
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 31 Oct 2018 15:37:24 -0000
Content-Type: multipart/alternative; boundary="00000000000020987a0579881446"

--00000000000020987a0579881446
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Good evening,



I contact you because for several weeks I haven't been able to pre-install
a software in my rootfs with Yocto.

This software is provided to me by the manufacturer of a camera as a
tarball. In this tarball there are other tarballs.

In each of these subtarballs there is a tree of files to copy to the rootfs=
.



For example we can find in one tarball this type of tree structure:

.

+-- etc

=C2=A6   +-- init.d

=C2=A6   =C2=A6   +-- cvmgmtd

=C2=A6   =C2=A6   +-- siGevSvc

=C2=A6   =C2=A6   +-- siLogSvc

=C2=A6   +-- ld.so.conf.d

=C2=A6   =C2=A6   +-- libcvb.conf

=C2=A6   +-- profile.d

=C2=A6   =C2=A6   +-- cvb_environment.sh

=C2=A6   +-- sudoers.d

=C2=A6   =C2=A6   +-- keep_cvb_vars

=C2=A6   +-- sysctl.d

=C2=A6   =C2=A6   +-- 10-cvb.conf

=C2=A6   +-- udev

=C2=A6       +-- rules.d

=C2=A6           +-- 59-cvb_u3v.rules

+-- lib

=C2=A6   +-- systemd

=C2=A6       +-- system

=C2=A6           +-- cvmgmtd.service

=C2=A6           +-- siGevSvc.service

=C2=A6           +-- siLogSvc.service

+-- opt

=C2=A6   +-- cvb -> cvb-13.01.003

=C2=A6   +-- cvb-13.01.003

=C2=A6       +-- lib

=C2=A6           +-- libCVBase.so -> libCVBase.so.1

=C2=A6           +-- libCVBase.so.1 -> libCVBase.so.1.214

=C2=A6           +-- libCVBase.so.1.214 -> libCVBase.so.1.214.306

=C2=A6

+-- usr

=C2=A6   +-- bin

=C2=A6       +-- collect-camsuite -> /opt/cvb-13.01.003/bin/collect-camsuit=
e





In order to preinstall this software, I created a Yocto recipe:

.

+-- cvb-software

=C2=A6   +-- cvb-software.bb

=C2=A6   +-- files

=C2=A6   =C2=A6   +-- cvb-software.tar.gz

=C2=A6   +-- README



Inspired by the DynamicDevices meta-example :
https://github.com/DynamicDevices/meta-example/blob/master/recipes-example/=
bbexample/bbexample-lt_1.0.bb
;

I modified the BitBake file so that it will copy all the files from the
tarball into my rootfs:



#----------------------------------------

# This file aims to preinstall the cvb software into the root file system

SUMMARY =3D "Simple cvb-software application"

SECTION =3D "PETALINUX/apps"

LICENSE =3D "MIT"

LIC_FILES_CHKSUM =3D "
file://${COMMON_LICENSE_DIR}/MIT;md5=3D0835ade698e0bcf8506ecda2f7b4f302"

FILESEXTRAPATHS_prepend :=3D =E2=80=9C${THISDIR}/${PN}-${PV}:=E2=80=9D

SRC_URI =3D "file://cvb-software.tar.gz "

S =3D "${WORKDIR}"



inherit autotools

#----------------------------------------



When I build my image/kernel I got the error:



NOTE: Executing SetScene Tasks

NOTE: Executing RunQueue Tasks

ERROR: cvb-software-1.0-r0 do_compile: oe_runmake failed

ERROR: cvb-software-1.0-r0 do_compile: Function failed: do_compile (log
file is located at
/home/tf/PetalinuxProjects/PLNX/build/tmp/work/aarch64-xilinx-linux/cvb-sof=
tware/1.0-r0/temp/log.do_compile.23431)

ERROR: Logfile of failure stored in:
/home/tf/PetalinuxProjects/PLNX/build/tmp/work/aarch64-xilinx-linux/cvb-sof=
tware/1.0-r0/temp/log.do_compile.23431

Log data follows:

| DEBUG: SITE files ['endian-little', 'bit-64', 'arm-common', 'arm-64',
'common-linux', 'common-glibc', 'aarch64-linux', 'common']

| DEBUG: Executing shell function do_compile

| NOTE: make

| ERROR: oe_runmake failed

| make: *** No targets specified and no makefile found.  Stop.

| WARNING:
/home/tf/PetalinuxProjects/PLNX/build/tmp/work/aarch64-xilinx-linux/cvb-sof=
tware/1.0-r0/temp/run.do_compile.23431:1
exit 1 from 'exit 1'

| ERROR: Function failed: do_compile (log file is located at
/home/tf/PetalinuxProjects/PLNX/build/tmp/work/aarch64-xilinx-linux/cvb-sof=
tware/1.0-r0/temp/log.do_compile.23431)

ERROR: Task
(/home/tf/PetalinuxProjects/PLNX/project-spec/meta-user/recipes-apps/cvb-so=
ftware/cvb-software.bb:do_compile)
failed with exit code '1'

NOTE: Tasks Summary: Attempted 551 tasks of which 545 didn't need to be
rerun and 1 failed.



Summary: 1 task failed:


/home/tf/PetalinuxProjects/PLNX/project-spec/meta-user/recipes-apps/cvb-sof=
tware/cvb-software.bb:
do_compile

Summary: There were 2 ERROR messages shown, returning a non-zero exit code.

ERROR: Failed to build cvb-software





Can you help me by telling me what the problem is or what is the best
procedure to follow to pre-install this tarball in my rootfs please?



Have a nice day,

King regards,



Thibault FARGES.



PS: In fact I use Xilinx's Petalinux tool, based on Yocto Project. But
Xilinx support redirected me to you because they can't help me on this
subject.

--00000000000020987a0579881446
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><p style=3D"font-family:sans-serif;font-size:12.8px">Good=
 evening,<u></u><u></u></p><p style=3D"font-family:sans-serif;font-size:12.=
8px"><u></u>=C2=A0<u></u></p><p style=3D"font-family:sans-serif;font-size:1=
2.8px">I contact you because for several weeks I haven&#39;t been able to p=
re-install a software in my rootfs with Yocto.</p><p style=3D"font-family:s=
ans-serif;font-size:12.8px">This software is provided to me by the manufact=
urer of a camera as a tarball. In this tarball there are other tarballs.<u>=
</u><u></u></p><p style=3D"font-family:sans-serif;font-size:12.8px">In each=
 of these subtarballs there is a tree of files to copy to the rootfs.<u></u=
><u></u></p><p style=3D"font-family:sans-serif;font-size:12.8px"><u></u>=C2=
=A0<u></u></p><p style=3D"font-family:sans-serif;font-size:12.8px">For exam=
ple we can find in one tarball this type of tree structure:<u></u><u></u></=
p><p style=3D"font-family:sans-serif;font-size:12.8px"><span style=3D"font-=
size:7pt;font-family:&#39;courier new&#39;">.<u></u><u></u></span></p><p st=
yle=3D"font-family:sans-serif;font-size:12.8px"><span style=3D"font-size:7p=
t;font-family:&#39;courier new&#39;">+-- etc<u></u><u></u></span></p><p sty=
le=3D"font-family:sans-serif;font-size:12.8px"><span style=3D"font-size:7pt=
;font-family:&#39;courier new&#39;">=C2=A6=C2=A0=C2=A0 +-- init.d<u></u><u>=
</u></span></p><p style=3D"font-family:sans-serif;font-size:12.8px"><span s=
tyle=3D"font-size:7pt;font-family:&#39;courier new&#39;">=C2=A6=C2=A0=C2=A0=
 =C2=A6=C2=A0=C2=A0 +-- cvmgmtd<u></u><u></u></span></p><p style=3D"font-fa=
mily:sans-serif;font-size:12.8px"><span style=3D"font-size:7pt;font-family:=
&#39;courier new&#39;">=C2=A6=C2=A0=C2=A0 =C2=A6=C2=A0=C2=A0 +-- siGevSvc<u=
></u><u></u></span></p><p style=3D"font-family:sans-serif;font-size:12.8px"=
><span style=3D"font-size:7pt;font-family:&#39;courier new&#39;">=C2=A6=C2=
=A0=C2=A0 =C2=A6=C2=A0=C2=A0 +-- siLogSvc<u></u><u></u></span></p><p style=
=3D"font-family:sans-serif;font-size:12.8px"><span style=3D"font-size:7pt;f=
ont-family:&#39;courier new&#39;">=C2=A6=C2=A0=C2=A0 +-- ld.so.conf.d<u></u=
><u></u></span></p><p style=3D"font-family:sans-serif;font-size:12.8px"><sp=
an style=3D"font-size:7pt;font-family:&#39;courier new&#39;">=C2=A6=C2=A0=
=C2=A0 =C2=A6=C2=A0=C2=A0 +-- libcvb.conf<u></u><u></u></span></p><p style=
=3D"font-family:sans-serif;font-size:12.8px"><span style=3D"font-size:7pt;f=
ont-family:&#39;courier new&#39;">=C2=A6=C2=A0=C2=A0 +-- profile.d<u></u><u=
></u></span></p><p style=3D"font-family:sans-serif;font-size:12.8px"><span =
style=3D"font-size:7pt;font-family:&#39;courier new&#39;">=C2=A6=C2=A0=C2=
=A0 =C2=A6=C2=A0=C2=A0 +-- cvb_environment.sh<u></u><u></u></span></p><p st=
yle=3D"font-family:sans-serif;font-size:12.8px"><span style=3D"font-size:7p=
t;font-family:&#39;courier new&#39;">=C2=A6=C2=A0=C2=A0 +-- sudoers.d<u></u=
><u></u></span></p><p style=3D"font-family:sans-serif;font-size:12.8px"><sp=
an style=3D"font-size:7pt;font-family:&#39;courier new&#39;">=C2=A6=C2=A0=
=C2=A0 =C2=A6=C2=A0=C2=A0 +-- keep_cvb_vars<u></u><u></u></span></p><p styl=
e=3D"font-family:sans-serif;font-size:12.8px"><span style=3D"font-size:7pt;=
font-family:&#39;courier new&#39;">=C2=A6=C2=A0=C2=A0 +-- sysctl.d<u></u><u=
></u></span></p><p style=3D"font-family:sans-serif;font-size:12.8px"><span =
style=3D"font-size:7pt;font-family:&#39;courier new&#39;">=C2=A6=C2=A0=C2=
=A0 =C2=A6=C2=A0=C2=A0 +-- 10-cvb.conf<u></u><u></u></span></p><p style=3D"=
font-family:sans-serif;font-size:12.8px"><span style=3D"font-size:7pt;font-=
family:&#39;courier new&#39;">=C2=A6=C2=A0=C2=A0 +-- udev<u></u><u></u></sp=
an></p><p style=3D"font-family:sans-serif;font-size:12.8px"><span style=3D"=
font-size:7pt;font-family:&#39;courier new&#39;">=C2=A6=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 +-- rules.d<u></u><u></u></span></p><p style=3D"font-fam=
ily:sans-serif;font-size:12.8px"><span style=3D"font-size:7pt;font-family:&=
#39;courier new&#39;">=C2=A6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 +-- 59-cvb_u3v.rules<u></u><u></u></span></p><p style=3D"fo=
nt-family:sans-serif;font-size:12.8px"><span style=3D"font-size:7pt;font-fa=
mily:&#39;courier new&#39;">+-- lib<u></u><u></u></span></p><p style=3D"fon=
t-family:sans-serif;font-size:12.8px"><span style=3D"font-size:7pt;font-fam=
ily:&#39;courier new&#39;">=C2=A6=C2=A0=C2=A0 +-- systemd<u></u><u></u></sp=
an></p><p style=3D"font-family:sans-serif;font-size:12.8px"><span style=3D"=
font-size:7pt;font-family:&#39;courier new&#39;">=C2=A6=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 +-- system<u></u><u></u></span></p><p style=3D"font-fami=
ly:sans-serif;font-size:12.8px"><span style=3D"font-size:7pt;font-family:&#=
39;courier new&#39;">=C2=A6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 +-- cvmgmtd.service<u></u><u></u></span></p><p style=3D"font-f=
amily:sans-serif;font-size:12.8px"><span style=3D"font-size:7pt;font-family=
:&#39;courier new&#39;">=C2=A6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 +-- siGevSvc.service<u></u><u></u></span></p><p style=3D"fo=
nt-family:sans-serif;font-size:12.8px"><span style=3D"font-size:7pt;font-fa=
mily:&#39;courier new&#39;">=C2=A6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 +-- siLogSvc.service<u></u><u></u></span></p><p style=
=3D"font-family:sans-serif;font-size:12.8px"><span style=3D"font-size:7pt;f=
ont-family:&#39;courier new&#39;">+-- opt<u></u><u></u></span></p><p style=
=3D"font-family:sans-serif;font-size:12.8px"><span style=3D"font-size:7pt;f=
ont-family:&#39;courier new&#39;">=C2=A6=C2=A0=C2=A0 +-- cvb -&gt; cvb-13.0=
1.003<u></u><u></u></span></p><p style=3D"font-family:sans-serif;font-size:=
12.8px"><span style=3D"font-size:7pt;font-family:&#39;courier new&#39;">=C2=
=A6=C2=A0=C2=A0 +-- cvb-13.01.003<u></u><u></u></span></p><p style=3D"font-=
family:sans-serif;font-size:12.8px"><span style=3D"font-size:7pt;font-famil=
y:&#39;courier new&#39;">=C2=A6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-- lib=
<u></u><u></u></span></p><p style=3D"font-family:sans-serif;font-size:12.8p=
x"><span style=3D"font-size:7pt;font-family:&#39;courier new&#39;">=C2=A6=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-- libCVBase.=
so -&gt; libCVBase.so.1<u></u><u></u></span></p><p style=3D"font-family:san=
s-serif;font-size:12.8px"><span style=3D"font-size:7pt;font-family:&#39;cou=
rier new&#39;">=C2=A6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 +-- libCVBase.so.1 -&gt; libCVBase.so.1.214<u></u><u></u></span></p>=
<p style=3D"font-family:sans-serif;font-size:12.8px"><span style=3D"font-si=
ze:7pt;font-family:&#39;courier new&#39;">=C2=A6=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-- libCVBase.so.1.214 -&gt; libCVBase.so=
.1.214.306<u></u><u></u></span></p><p style=3D"font-family:sans-serif;font-=
size:12.8px"><span style=3D"font-size:7pt;font-family:&#39;courier new&#39;=
">=C2=A6=C2=A0<u></u><u></u></span></p><p style=3D"font-family:sans-serif;f=
ont-size:12.8px"><span style=3D"font-size:7pt;font-family:&#39;courier new&=
#39;">+-- usr<u></u><u></u></span></p><p style=3D"font-family:sans-serif;fo=
nt-size:12.8px"><span style=3D"font-size:7pt;font-family:&#39;courier new&#=
39;">=C2=A6=C2=A0=C2=A0 +-- bin<u></u><u></u></span></p><p style=3D"font-fa=
mily:sans-serif;font-size:12.8px"><span style=3D"font-size:7pt;font-family:=
&#39;courier new&#39;">=C2=A6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-- colle=
ct-camsuite -&gt; /opt/cvb-13.01.003/bin/collect-camsuite<u></u><u></u></sp=
an></p><p style=3D"font-family:sans-serif;font-size:12.8px"><span style=3D"=
font-size:7pt;font-family:&#39;courier new&#39;"><u></u>=C2=A0<u></u></span=
></p><p style=3D"font-family:sans-serif;font-size:12.8px"><span style=3D"fo=
nt-size:7pt;font-family:&#39;courier new&#39;"><u></u>=C2=A0<u></u></span><=
/p><p style=3D"font-family:sans-serif;font-size:12.8px">In order to preinst=
all this software, I created a Yocto recipe:<span style=3D"font-size:11pt;f=
ont-family:&#39;calibri&#39;,sans-serif"><u></u><u></u></span></p><p style=
=3D"font-family:sans-serif;font-size:12.8px"><span style=3D"font-size:10pt;=
font-family:&#39;courier new&#39;">.<u></u><u></u></span></p><p style=3D"fo=
nt-family:sans-serif;font-size:12.8px"><span style=3D"font-size:10pt;font-f=
amily:&#39;courier new&#39;">+-- cvb-software<u></u><u></u></span></p><p st=
yle=3D"font-family:sans-serif;font-size:12.8px"><span style=3D"font-size:10=
pt;font-family:&#39;courier new&#39;">=C2=A6=C2=A0=C2=A0 +--=C2=A0<a href=
=3D"http://cvb-software.bb/" style=3D"text-decoration-line:none;color:rgb(6=
6,133,244)">cvb-software.bb</a><u></u><u></u></span></p><p style=3D"font-fa=
mily:sans-serif;font-size:12.8px"><span style=3D"font-size:10pt;font-family=
:&#39;courier new&#39;">=C2=A6=C2=A0=C2=A0 +-- files<u></u><u></u></span></=
p><p style=3D"font-family:sans-serif;font-size:12.8px"><span style=3D"font-=
size:10pt;font-family:&#39;courier new&#39;">=C2=A6=C2=A0=C2=A0 =C2=A6=C2=
=A0=C2=A0 +-- cvb-software.tar.gz<u></u><u></u></span></p><p style=3D"font-=
family:sans-serif;font-size:12.8px"><span style=3D"font-size:10pt;font-fami=
ly:&#39;courier new&#39;">=C2=A6=C2=A0=C2=A0 +-- README<u></u><u></u></span=
></p><p style=3D"font-family:sans-serif;font-size:12.8px"><span style=3D"fo=
nt-size:11pt;font-family:&#39;courier new&#39;"><u></u>=C2=A0<u></u></span>=
</p><p style=3D"font-family:sans-serif;font-size:12.8px">Inspired by the Dy=
namicDevices meta-example :=C2=A0<a href=3D"https://github.com/DynamicDevic=
es/meta-example/blob/master/recipes-example/bbexample/bbexample-lt_1.0.bb" =
style=3D"text-decoration-line:none;color:rgb(66,133,244)">https://github.co=
m/DynamicDevices/meta-example/blob/master/recipes-example/bbexample/bbexamp=
le-lt_1.0.bb</a>;<span style=3D"font-family:&#39;calibri&#39;,sans-serif"><=
u></u><u></u></span></p><p style=3D"font-family:sans-serif;font-size:12.8px=
">I modified the BitBake file so that it will copy all the files from the t=
arball into my rootfs:<u></u><u></u></p><p style=3D"font-family:sans-serif;=
font-size:12.8px"><u></u>=C2=A0<u></u></p><p style=3D"font-family:sans-seri=
f;font-size:12.8px"><span style=3D"font-size:10pt">#-----------------------=
-----------------<u></u><u></u></span></p><p style=3D"font-family:sans-seri=
f;font-size:12.8px"><span style=3D"font-size:9pt"># This file aims to prein=
stall the cvb software into the root file system<u></u><u></u></span></p><p=
 style=3D"font-family:sans-serif;font-size:12.8px"><span style=3D"font-size=
:9pt">SUMMARY =3D &quot;Simple cvb-software application&quot;<u></u><u></u>=
</span></p><p style=3D"font-family:sans-serif;font-size:12.8px"><span style=
=3D"font-size:9pt">SECTION =3D &quot;PETALINUX/apps&quot;<u></u><u></u></sp=
an></p><p style=3D"font-family:sans-serif;font-size:12.8px"><span style=3D"=
font-size:9pt">LICENSE =3D &quot;MIT&quot;<u></u><u></u></span></p><p style=
=3D"font-family:sans-serif;font-size:12.8px"><span style=3D"font-size:9pt">=
LIC_FILES_CHKSUM =3D &quot;<a>file://${COMMON_LICENSE_DIR}/MIT;md5=3D0835ad=
e698e0bcf8506ecda2f7b4f302</a>&quot;<u></u><u></u></span></p><p style=3D"fo=
nt-family:sans-serif;font-size:12.8px"><span style=3D"font-size:9pt">FILESE=
XTRAPATHS_prepend :=3D =E2=80=9C${THISDIR}/${PN}-${PV}:=E2=80=9D<u></u><u><=
/u></span></p><p style=3D"font-family:sans-serif;font-size:12.8px"><span st=
yle=3D"font-size:9pt">SRC_URI =3D &quot;<a>file://cvb-software.tar.gz=C2=A0=
</a>&quot;<u></u><u></u></span></p><p style=3D"font-family:sans-serif;font-=
size:12.8px"><span style=3D"font-size:9pt">S =3D &quot;${WORKDIR}&quot;<u><=
/u><u></u></span></p><p style=3D"font-family:sans-serif;font-size:12.8px"><=
span style=3D"font-size:9pt"><u></u>=C2=A0<u></u></span></p><p style=3D"fon=
t-family:sans-serif;font-size:12.8px"><span style=3D"font-size:9pt">inherit=
 autotools<u></u><u></u></span></p><p style=3D"font-family:sans-serif;font-=
size:12.8px"><span style=3D"font-size:10pt">#------------------------------=
----------<u></u><u></u></span></p><p style=3D"font-family:sans-serif;font-=
size:12.8px"><span style=3D"font-size:10pt"><u></u>=C2=A0<u></u></span></p>=
<p style=3D"font-family:sans-serif;font-size:12.8px"><span style=3D"font-si=
ze:10pt">When I build my image/kernel I got the error:<u></u><u></u></span>=
</p><p style=3D"font-family:sans-serif;font-size:12.8px"><span style=3D"fon=
t-size:9pt;font-family:&#39;courier new&#39;"><u></u>=C2=A0<u></u></span></=
p><p style=3D"font-family:sans-serif;font-size:12.8px"><span style=3D"font-=
size:8pt;font-family:&#39;courier new&#39;">NOTE: Executing SetScene Tasks<=
u></u><u></u></span></p><p style=3D"font-family:sans-serif;font-size:12.8px=
"><span style=3D"font-size:8pt;font-family:&#39;courier new&#39;">NOTE: Exe=
cuting RunQueue Tasks<u></u><u></u></span></p><p style=3D"font-family:sans-=
serif;font-size:12.8px"><span style=3D"font-size:8pt;font-family:&#39;couri=
er new&#39;">ERROR: cvb-software-1.0-r0 do_compile: oe_runmake failed<u></u=
><u></u></span></p><p style=3D"font-family:sans-serif;font-size:12.8px"><sp=
an style=3D"font-size:8pt;font-family:&#39;courier new&#39;">ERROR: cvb-sof=
tware-1.0-r0 do_compile: Function failed: do_compile (log file is located a=
t /home/tf/PetalinuxProjects/PLNX/build/tmp/work/aarch64-xilinx-linux/cvb-s=
oftware/1.0-r0/temp/log.do_compile.23431)<u></u><u></u></span></p><p style=
=3D"font-family:sans-serif;font-size:12.8px"><span style=3D"font-size:8pt;f=
ont-family:&#39;courier new&#39;">ERROR: Logfile of failure stored in: /hom=
e/tf/PetalinuxProjects/PLNX/build/tmp/work/aarch64-xilinx-linux/cvb-softwar=
e/1.0-r0/temp/log.do_compile.23431<u></u><u></u></span></p><p style=3D"font=
-family:sans-serif;font-size:12.8px"><span style=3D"font-size:8pt;font-fami=
ly:&#39;courier new&#39;">Log data follows:<u></u><u></u></span></p><p styl=
e=3D"font-family:sans-serif;font-size:12.8px"><span style=3D"font-size:8pt;=
font-family:&#39;courier new&#39;">| DEBUG: SITE files [&#39;endian-little&=
#39;, &#39;bit-64&#39;, &#39;arm-common&#39;, &#39;arm-64&#39;, &#39;common=
-linux&#39;, &#39;common-glibc&#39;, &#39;aarch64-linux&#39;, &#39;common&#=
39;]<u></u><u></u></span></p><p style=3D"font-family:sans-serif;font-size:1=
2.8px"><span style=3D"font-size:8pt;font-family:&#39;courier new&#39;">| DE=
BUG: Executing shell function do_compile<u></u><u></u></span></p><p style=
=3D"font-family:sans-serif;font-size:12.8px"><span style=3D"font-size:8pt;f=
ont-family:&#39;courier new&#39;">| NOTE: make<u></u><u></u></span></p><p s=
tyle=3D"font-family:sans-serif;font-size:12.8px"><span style=3D"font-size:8=
pt;font-family:&#39;courier new&#39;">| ERROR: oe_runmake failed<u></u><u><=
/u></span></p><p style=3D"font-family:sans-serif;font-size:12.8px"><span st=
yle=3D"font-size:8pt;font-family:&#39;courier new&#39;">| make: *** No targ=
ets specified and no makefile found.=C2=A0 Stop.<u></u><u></u></span></p><p=
 style=3D"font-family:sans-serif;font-size:12.8px"><span style=3D"font-size=
:8pt;font-family:&#39;courier new&#39;">| WARNING: /home/tf/PetalinuxProjec=
ts/PLNX/build/tmp/work/aarch64-xilinx-linux/cvb-software/1.0-r0/temp/run.do=
_compile.23431:1 exit 1 from &#39;exit 1&#39;<u></u><u></u></span></p><p st=
yle=3D"font-family:sans-serif;font-size:12.8px"><span style=3D"font-size:8p=
t;font-family:&#39;courier new&#39;">| ERROR: Function failed: do_compile (=
log file is located at /home/tf/PetalinuxProjects/PLNX/build/tmp/work/aarch=
64-xilinx-linux/cvb-software/1.0-r0/temp/log.do_compile.23431)<u></u><u></u=
></span></p><p style=3D"font-family:sans-serif;font-size:12.8px"><span styl=
e=3D"font-size:8pt;font-family:&#39;courier new&#39;">ERROR: Task (/home/tf=
/PetalinuxProjects/PLNX/project-spec/meta-user/recipes-apps/cvb-software/cv=
b-software.bb:do_compile) failed with exit code &#39;1&#39;<u></u><u></u></=
span></p><p style=3D"font-family:sans-serif;font-size:12.8px"><span style=
=3D"font-size:8pt;font-family:&#39;courier new&#39;">NOTE: Tasks Summary: A=
ttempted 551 tasks of which 545 didn&#39;t need to be rerun and 1 failed.<u=
></u><u></u></span></p><p style=3D"font-family:sans-serif;font-size:12.8px"=
><span style=3D"font-size:8pt;font-family:&#39;courier new&#39;"><u></u>=C2=
=A0<u></u></span></p><p style=3D"font-family:sans-serif;font-size:12.8px"><=
span style=3D"font-size:8pt;font-family:&#39;courier new&#39;">Summary: 1 t=
ask failed:<u></u><u></u></span></p><p style=3D"font-family:sans-serif;font=
-size:12.8px"><span style=3D"font-size:8pt;font-family:&#39;courier new&#39=
;">=C2=A0 /home/tf/PetalinuxProjects/PLNX/project-spec/meta-user/recipes-ap=
ps/cvb-software/cvb-software.bb:do_compile<u></u><u></u></span></p><p style=
=3D"font-family:sans-serif;font-size:12.8px"><span style=3D"font-size:8pt;f=
ont-family:&#39;courier new&#39;">Summary: There were 2 ERROR messages show=
n, returning a non-zero exit code.<u></u><u></u></span></p><p style=3D"font=
-family:sans-serif;font-size:12.8px"><span style=3D"font-size:8pt;font-fami=
ly:&#39;courier new&#39;">ERROR: Failed to build cvb-software</span><span s=
tyle=3D"font-size:7pt;font-family:&#39;calibri&#39;,sans-serif"><u></u><u><=
/u></span></p><p style=3D"font-family:sans-serif;font-size:12.8px"><span st=
yle=3D"font-size:9pt"><u></u>=C2=A0<u></u></span></p><p style=3D"font-famil=
y:sans-serif;font-size:12.8px"><span style=3D"font-size:9pt"><u></u>=C2=A0<=
u></u></span></p><p style=3D"font-family:sans-serif;font-size:12.8px">Can y=
ou help me by telling me what the problem is or what is the best procedure =
to follow to pre-install this tarball in my rootfs please?<span style=3D"fo=
nt-size:11pt"><u></u><u></u></span></p><p style=3D"font-family:sans-serif;f=
ont-size:12.8px"><u></u>=C2=A0<u></u></p><p style=3D"font-family:sans-serif=
;font-size:12.8px">Have a nice day,<u></u><u></u></p><p style=3D"font-famil=
y:sans-serif;font-size:12.8px">King regards,<u></u><u></u></p><p style=3D"f=
ont-family:sans-serif;font-size:12.8px"><u></u>=C2=A0<u></u></p><p style=3D=
"font-family:sans-serif;font-size:12.8px">Thibault FARGES.<u></u><u></u></p=
><p style=3D"font-family:sans-serif;font-size:12.8px"><u></u>=C2=A0<u></u><=
/p><p style=3D"font-family:sans-serif;font-size:12.8px">PS: In fact I use X=
ilinx&#39;s Petalinux tool, based on Yocto Project. But Xilinx support redi=
rected me to you because they can&#39;t help me on this subject.</p></div>

--00000000000020987a0579881446--
