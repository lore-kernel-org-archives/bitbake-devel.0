Return-Path: <kergoth@gmail.com>
Received: from mail-io0-f178.google.com (mail-io0-f178.google.com
	[209.85.223.178])
	by mail.openembedded.org (Postfix) with ESMTP id F179C734B8
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Aug 2015 23:15:49 +0000 (UTC)
Received: by iodv127 with SMTP id v127so37936056iod.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Aug 2015 16:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=hS4pvxU3ToEYTIN3LfWYugO/mxI5kqe1FKhc/J6QiSI=;
	b=1J7ERTFCtcy2OOYJT6Lu+XfpiissZ7xQ7mtyFY7LRDvb3CHndwUTFlS1mi32CO0CCJ
	jvSUp8+PXCBwSYoXYD1/FlJfdeZJrVw6PgzDjF4PTLanahGfw/xmDgZMkh/VKMq4BFBs
	GhD8g2ZqZRYJQ/RZo3/j7nLSW2ZfgO4p8ikdaFfqtL11+cJSqjQvFl2rlN+msFASnLBh
	O8VSMGuIYX1pPIyCXpMmKZ7iIaV/7sn8d4kr2HXVs+fRxD4t1hw1Dw4tUuBLqJHYZC+S
	IPnaiGHmhJmGSmRw4aZngq8JSdsVPccHq/ZDR49s81NQVcC2pX4xtblWdGNrrCMkuEeH
	JUJw==
X-Received: by 10.107.40.200 with SMTP id o191mr6971020ioo.83.1440630949583;
	Wed, 26 Aug 2015 16:15:49 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.100.71 with HTTP; Wed, 26 Aug 2015 16:15:30 -0700 (PDT)
In-Reply-To: <1440607088-14563-1-git-send-email-kergoth@gmail.com>
References: <1440607088-14563-1-git-send-email-kergoth@gmail.com>
From: Christopher Larson <chris_larson@mentor.com>
Date: Wed, 26 Aug 2015 16:15:30 -0700
X-Google-Sender-Auth: gWG3LoKgmzm77s4KuKn_FySoVmQ
Message-ID: <CABcZAN=kRiGhuVt4rHNzVDB-WH1QnN64zz9gz=6o9xv2PAU6YA@mail.gmail.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: Re: [PATCH 0/4] Implement git shallow mirror tarball support
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
X-List-Received-Date: Wed, 26 Aug 2015 23:15:50 -0000
Content-Type: multipart/alternative; boundary=001a1141cf8c00a1c7051e3f0804

--001a1141cf8c00a1c7051e3f0804
Content-Type: text/plain; charset=UTF-8

On Wed, Aug 26, 2015 at 9:38 AM, Christopher Larson <kergoth@gmail.com>
wrote:

> From: Christopher Larson <chris_larson@mentor.com>
>
> Supercedes `[RFC PATCH 0/5] Implement git shallow mirror tarball support`.
>
> The shallow mirror tarball filename includes branch, revision, and depth.
> To
> enable, use the BB_GIT_SHALLOW variable, or BB_GIT_SHALLOW_<name> for
> specific
> URLs. This variable can hold either a clone depth (e.g. 1 to just get
> SRCREV),
> or a ref or commit, in which case we keep history up to that commit.
>
> Example:
>
>     BB_GIT_SHALLOW ?= "1"
>     BB_GIT_SHALLOW_pn-linux-yocto = ""
>     BB_GIT_SHALLOW_pn-linux-mel_mx6 = "v3.14"
>     BB_GIT_SHALLOW_pn-testrepo = "testbranch"
>
> Example in a recipe with multiple named uris, or multiple named branches
> in a
> single git URI:
>
>     BB_GIT_SHALLOW_main = "1"
>     BB_GIT_SHALLOW_doc = ""
>
> BB_GIT_SHALLOW affects both the tarballs being fetched and the mirror
> tarball
> which is created when BB_GENERATE_MIRROR_TARBALLS is enabled. If the
> shallow
> mirror tarball cannot be fetched, it will try to fetch the full mirror
> tarball
> and use that.
>
> Limitations:
>
> The shallow support will not, at this time, function correctly for
> linux-yocto, due to its branching scheme & validation.
>
> This implements support for shallow mirror tarballs, not shallow clones.
> Supporting shallow clones directly would be rather more problematic, as
> we'd
> need to hardcode the depth between branch HEAD and the SRCREV, and that
> depth
> would change as the branch is updated.
>

One point of clarification, as it was asked with the RFC version of this
series. This is in a comment, but I forgot to add it in the commit message:

A current clone is preferred to either tarball, a shallow tarball is preferred
to an out of date clone, and a missing clone will use either tarball.
-- 
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a1141cf8c00a1c7051e3f0804
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, Aug 26, 2015 at 9:38 AM, Christopher Larson <span dir=3D"ltr">&lt;<=
a href=3D"mailto:kergoth@gmail.com" target=3D"_blank">kergoth@gmail.com</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);bor=
der-left-style:solid;padding-left:1ex"><div id=3D":1l1" class=3D"" style=3D=
"overflow:hidden">From: Christopher Larson &lt;<a href=3D"mailto:chris_lars=
on@mentor.com">chris_larson@mentor.com</a>&gt;<br>
<br>
Supercedes `[RFC PATCH 0/5] Implement git shallow mirror tarball support`.<=
br>
<br>
The shallow mirror tarball filename includes branch, revision, and depth. T=
o<br>
enable, use the BB_GIT_SHALLOW variable, or BB_GIT_SHALLOW_&lt;name&gt; for=
 specific<br>
URLs. This variable can hold either a clone depth (e.g. 1 to just get SRCRE=
V),<br>
or a ref or commit, in which case we keep history up to that commit.<br>
<br>
Example:<br>
<br>
=C2=A0 =C2=A0 BB_GIT_SHALLOW ?=3D &quot;1&quot;<br>
=C2=A0 =C2=A0 BB_GIT_SHALLOW_pn-linux-yocto =3D &quot;&quot;<br>
=C2=A0 =C2=A0 BB_GIT_SHALLOW_pn-linux-mel_mx6 =3D &quot;v3.14&quot;<br>
=C2=A0 =C2=A0 BB_GIT_SHALLOW_pn-testrepo =3D &quot;testbranch&quot;<br>
<br>
Example in a recipe with multiple named uris, or multiple named branches in=
 a<br>
single git URI:<br>
<br>
=C2=A0 =C2=A0 BB_GIT_SHALLOW_main =3D &quot;1&quot;<br>
=C2=A0 =C2=A0 BB_GIT_SHALLOW_doc =3D &quot;&quot;<br>
<br>
BB_GIT_SHALLOW affects both the tarballs being fetched and the mirror tarba=
ll<br>
which is created when BB_GENERATE_MIRROR_TARBALLS is enabled. If the shallo=
w<br>
mirror tarball cannot be fetched, it will try to fetch the full mirror tarb=
all<br>
and use that.<br>
<br>
Limitations:<br>
<br>
The shallow support will not, at this time, function correctly for<br>
linux-yocto, due to its branching scheme &amp; validation.<br>
<br>
This implements support for shallow mirror tarballs, not shallow clones.<br=
>
Supporting shallow clones directly would be rather more problematic, as we&=
#39;d<br>
need to hardcode the depth between branch HEAD and the SRCREV, and that dep=
th<br>
would change as the branch is updated.</div></blockquote></div><br>One poin=
t of clarification, as it was asked with the RFC version of this series. Th=
is is in a comment, but I forgot to add it in the commit message:</div><div=
 class=3D"gmail_extra"><br></div><div class=3D"gmail_extra"><span style=3D"=
font-size:13px">A current clone is preferred to either tarball, a shallow t=
arball is=C2=A0</span><span style=3D"font-size:13px">preferred to an out of=
 date clone, and a missing clone will use=C2=A0</span><span style=3D"font-s=
ize:13px">either tarball.<br></span>-- <br><div class=3D"gmail_signature"><=
div dir=3D"ltr">Christopher Larson<br>kergoth at gmail dot com<br>Founder -=
 BitBake, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior Software=
 Engineer, Mentor Graphics</div></div>
</div></div>

--001a1141cf8c00a1c7051e3f0804--
