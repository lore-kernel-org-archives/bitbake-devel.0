Return-Path: <shibi.cbe@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119FDCCF9F8
	for <webhook@archiver.kernel.org>; Thu, 30 Oct 2025 17:13:49 +0000 (UTC)
Subject: race condition between kernel source Vs kernel module fixdep: Permission denied   #bitbake #scarthgap
To: bitbake-devel@lists.openembedded.org
From: shibi.cbe@gmail.com
X-Originating-Location: Mumbai, Maharashtra, IN (52.95.75.0)
X-Originating-Platform: Mac Chrome 141
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Thu, 30 Oct 2025 10:13:44 -0700
Message-ID: <ANZn.1761844424544765402.cM7n@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="R7hSSrBmWVfJNCpgwzd8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 30 Oct 2025 17:13:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18229

--R7hSSrBmWVfJNCpgwzd8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello Everyone
while building a kernel module we are facing the race condition between ker=
nel source Vs kernel module so facing scripts/basic/fixdep: Permission deni=
ed
We are confirming its race condition because when we retry(1 or 2)=C2=A0 th=
e issue is getting resolved

*Error:*
/bin/sh: line 1: scripts/basic/fixdep: Permission denied | make[4]: *** [/b=
uild/tmp/work-shared/gf/kernel-source/scripts/Makefile.build:229: //build/t=
mp/work/gf-poky-linux/kernel-module-vpu-gf/1.0/git/vsi-v4l2daemon.o] Error =
126

To overcome this we have created a class file add this class file as inheri=
t for all kernel module. Below is content of *kernel-fixdep.bbclass*

# Common fix for kernel module compilation fixdep permission issues
# This class should be inherited by all kernel module recipes
# TODO workaround to remove dependency issue with azma mainline image.
DEPENDS +=3D "virtual/kernel"
do_configure[depends] +=3D "virtual/kernel:do_compile"
do_configure[depends] +=3D "virtual/kernel:do_compile_kernelmodules"
do_configure[depends] +=3D "virtual/kernel:do_shared_workdir"
do_configure[depends] +=3D "virtual/kernel:do_prepare_recipe_sysroot"
do_configure[depends] +=3D "virtual/kernel:do_populate_sysroot"
do_configure[depends] +=3D "virtual/kernel:do_install"

Even after adding this we are getting issue. Any lead on this issue

Thank you!!!

--R7hSSrBmWVfJNCpgwzd8
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>Hello Everyone<br />while building a kernel module we are facing the r=
ace condition between kernel source Vs kernel module so facing&nbsp;<span s=
tyle=3D"color: #1d1c1d; font-family: Monaco, Menlo, Consolas, 'Courier New'=
, monospace; font-size: 12px; font-style: normal; font-variant-ligatures: n=
one; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; o=
rphans: 2; text-align: left; text-indent: 0px; text-transform: none; widows=
: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-wr=
ap; background-color: rgba(29, 28, 29, 0.04); text-decoration-thickness: in=
itial; text-decoration-style: initial; text-decoration-color: initial; disp=
lay: inline !important; float: none;"> scripts/basic/fixdep: Permission den=
ied <br /></span>We are confirming its race condition because when we retry=
(1 or 2)&nbsp; the issue is getting resolved<br /><br /><strong>Error:</str=
ong><br /><span style=3D"color: #1d1c1d; font-family: Monaco, Menlo, Consol=
as, 'Courier New', monospace; font-size: 12px; font-style: normal; font-var=
iant-ligatures: none; font-variant-caps: normal; font-weight: 400; letter-s=
pacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transf=
orm: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; wh=
ite-space: pre-wrap; background-color: rgba(29, 28, 29, 0.04); text-decorat=
ion-thickness: initial; text-decoration-style: initial; text-decoration-col=
or: initial; display: inline !important; float: none;">/bin/sh: line 1: scr=
ipts/basic/fixdep: Permission denied | make[4]: *** [/build/tmp/work-shared=
/gf/kernel-source/scripts/Makefile.build:229: //build/tmp/work/gf-poky-linu=
x/kernel-module-vpu-gf/1.0/git/vsi-v4l2daemon.o] Error 126<br /><br /></spa=
n>To overcome this we have created a class file add this class file as inhe=
rit for all kernel module. Below is content of <strong>kernel-fixdep.bbclas=
s</strong><br /><br /># Common fix for kernel module compilation fixdep per=
mission issues<br /># This class should be inherited by all kernel module r=
ecipes</div>
<div># TODO workaround to remove dependency issue with azma mainline image.=
<br />DEPENDS +=3D "virtual/kernel"<br />do_configure[depends] +=3D "virtua=
l/kernel:do_compile"<br />do_configure[depends] +=3D "virtual/kernel:do_com=
pile_kernelmodules"<br />do_configure[depends] +=3D "virtual/kernel:do_shar=
ed_workdir"<br />do_configure[depends] +=3D "virtual/kernel:do_prepare_reci=
pe_sysroot"<br />do_configure[depends] +=3D "virtual/kernel:do_populate_sys=
root"<br />do_configure[depends] +=3D "virtual/kernel:do_install"<br /><br =
/><br />Even after adding this we are getting issue. Any lead on this issue=
&nbsp;<br /><br />Thank you!!!<br /><br /></div>

--R7hSSrBmWVfJNCpgwzd8--

