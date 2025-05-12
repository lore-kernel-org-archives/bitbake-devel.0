Return-Path: <niqingliang2003@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A7BC3ABBC
	for <webhook@archiver.kernel.org>; Mon, 12 May 2025 09:26:14 +0000 (UTC)
Subject: Re: [PATCH 0/1] fetch2/git: Use basename for gitsrcname when ud.proto is file
To: bitbake-devel@lists.openembedded.org
From: "Yi Qingliang" <niqingliang2003@gmail.com>
X-Originating-Location: CN (180.111.240.152)
X-Originating-Platform: Linux Chrome 135
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Mon, 12 May 2025 02:26:09 -0700
References: <b6ef29f5-277c-4df6-8f1f-a48274600cd7@windriver.com>
In-Reply-To: <b6ef29f5-277c-4df6-8f1f-a48274600cd7@windriver.com>
Message-ID: <29977.1747041969023320088@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="nkyipWHdXa07JrNwx43f"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 12 May 2025 09:26:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17600

--nkyipWHdXa07JrNwx43f
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I submitted a bug: https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D1585=
6

the bitbake on my env generated a git shallow tar for glibc, but with local=
 mirror path in filename.
and linked to it as a symbollink located in git2.

when unpacking, the bitbake can't find the shallow with official shallow (w=
hich file name should contail sourceware.xxx), can can't find bare repo (wh=
ich linked to the shallow file).

I think the latest patch for git shallow result it:
fetch2/git: Add support for fast initial shallow fetch
457288b2fda86fd00cdcaefac616129b0029e1f9

the patch author said that the bitbake don't want to generate shallow for l=
ocal mirror, but why I got it? If so, maybe we should set shallow_skip_fast=
 as True if protocol is "file":

- =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ud.shallow_skip_fast =3D False
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ud.shallow_skip_fast =3D (ud.pr=
oto =3D=3D "file")

--nkyipWHdXa07JrNwx43f
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>I submitted a bug: <a href=3D"https://bugzilla.yoctoproject.org/show_b=
ug.cgi?id=3D15856" target=3D"_blank" rel=3D"noopener">https://bugzilla.yoct=
oproject.org/show_bug.cgi?id=3D15856</a><br /><br />the bitbake on my env g=
enerated a git shallow tar for glibc, but with local mirror path in filenam=
e.<br />and linked to it as a symbollink located in git2.<br /><br />when u=
npacking, the bitbake can't find the shallow with official shallow (which f=
ile name should contail sourceware.xxx), can can't find bare repo (which li=
nked to the shallow file).<br /><br />I think the latest patch for git shal=
low result it:<br />fetch2/git: Add support for fast initial shallow fetch<=
br />457288b2fda86fd00cdcaefac616129b0029e1f9</div>
<div>&nbsp;</div>
<div>the patch author said that the bitbake don't want to generate shallow =
for local mirror, but why I got it? If so, maybe we should set <span style=
=3D"font-family: monospace;"><span style=3D"color: #b21818; background-colo=
r: #ffffff;">shallow_skip_fast as True if protocol is "file":<br /><br /></=
span></span></div>
<div><span style=3D"font-family: monospace;"><span style=3D"color: #b21818;=
 background-color: #ffffff;">- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ud=
.shallow_skip_fast =3D False</span><span style=3D"color: #000000; backgroun=
d-color: #ffffff;"> </span><br /><span style=3D"color: #18b218; background-=
color: #ffffff;">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ud.shallow_ski=
p_fast =3D (ud.proto =3D=3D "file")</span><br /></span></div>

--nkyipWHdXa07JrNwx43f--

