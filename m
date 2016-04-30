Return-Path: <kergoth@gmail.com>
Received: from mail-io0-f193.google.com (mail-io0-f193.google.com
	[209.85.223.193])
	by mail.openembedded.org (Postfix) with ESMTP id 90DC4731D8
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 Apr 2016 23:06:29 +0000 (UTC)
Received: by mail-io0-f193.google.com with SMTP id k129so19692854iof.3
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 Apr 2016 16:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=TY1bZaLXolnuQbdyU9BYi/b4HBlzLIXgM9qiX3Tx6F4=;
	b=LiIqiXP0KNp1RXujB8zexf+pkelDCS+/yzrAhE5xI8+JdV8wyXjzlw/IVWE54OHjWb
	bKCJ+dNLUVx3sbZB9AsJUiePtExnrlqCJmKFg/03pld+upGpd5WXweMktL7Vp8Lm7+/n
	r0Oza8PiWqF43EaoTwbHHWTae5ZHeV+gZMORLwjWTC82ToP/hqviXcoYe1WxXeEpk3kD
	611O/2VMV1u5G7Cel7xgbkOcuqScc9kCYGTzTtr/DjCuDxoMSNCFe+2KCm6a6vHsHwEv
	BRxigTyl0U0iwLjp5yr3pkEm6BfDUDSOqHCRIo7ECw0N6h3bPG/bXtcGeQ4F2OLa2V9V
	lrJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mentor-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=TY1bZaLXolnuQbdyU9BYi/b4HBlzLIXgM9qiX3Tx6F4=;
	b=zElREiPldUlAS5+OE8JigBTrWIc5uqy8ijHAOkkh2YliWNcyUw7bR+2onwP7Bo7aoG
	usqQxikeuqbYtfjO7gMad0R/awAF2wI4uCL/xAu1YmfvCjw34UH/kDUPZJNA1qDB1mHI
	2qLpI555NSS8xO18Diqd0Uyxt5TypXWFN6vAsQTsbqYKHl4gm4ZHI2AHKciJ8r9EH1/S
	nwb6B6wM4DlbX+6VBlZ6EEDUq6u73tvBGbGgaDfKdc4IK+eF19mOjhx8tn1tr5UfCxaK
	HKDw8j/WKd9flR3IdRmsaB2GzQ5+9ouwpThfj7gAwzX6LiIndqZ+LnPJl34B1ULqdv1k
	60fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=TY1bZaLXolnuQbdyU9BYi/b4HBlzLIXgM9qiX3Tx6F4=;
	b=WZnEtHyJWR/t+DxPo65h/e8HolXDGVueTYvxDQP8YmVnYZ9ruzDXbSfNHmEODJRRfJ
	tGoSJk0Moef8vqDACOFHAQ25IFjYtjXtiM7TXCgzBGX07HxD7R5Vw/jy1EwYYmxXAXQN
	bZM1Thc0efihWZ8SJfi3a9mN81PJGknOXM6Y8JghHLkYOfVd0FLy3gRBQ5eE0znIQXTV
	ZVRL+BopKKe6xkvreqC3OJCsX05kHn8aJ0xsh1uYYtfU80shSJxE/GsYpxg/Zzr5nD2p
	hwNc/rYtRg3p7T0Fx0Zox4GUy97qYeWS4QkL8Dd3caK/NGIasTWhLRBafma+SwOaEt5D
	N/qQ==
X-Gm-Message-State: AOPr4FUtCHhZ4+82wTAugZhp/yF53w3bp9dOKHxqZ/sBj1JQmqwNdph1iqTWVjmrbm16Y8uowBVKiR2uS2BDUQ==
X-Received: by 10.107.2.70 with SMTP id 67mr33576730ioc.70.1462057589057; Sat,
	30 Apr 2016 16:06:29 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.134.70 with HTTP; Sat, 30 Apr 2016 16:06:09 -0700 (PDT)
In-Reply-To: <1462045891-13511-1-git-send-email-kergoth@gmail.com>
References: <16137e65f85faac1bf54fc42f50010dab3bb03c9.1462042322.git.chris_larson@mentor.com>
	<1462045891-13511-1-git-send-email-kergoth@gmail.com>
From: Christopher Larson <chris_larson@mentor.com>
Date: Sat, 30 Apr 2016 16:06:09 -0700
X-Google-Sender-Auth: yb-SnqidNZQwU_slxx0sH-0fmZ0
Message-ID: <CABcZANmwmmHua4K5EskA7+n+goXjSbqYR6Vx-Ur0xA3P7vA-fQ@mail.gmail.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: Re: [master][PATCHv2 3/3] bb.fetch.git: add support for shallow mirror tarballs
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
X-List-Received-Date: Sat, 30 Apr 2016 23:06:32 -0000
Content-Type: multipart/alternative; boundary=001a113968143cc31a0531bbcf70

--001a113968143cc31a0531bbcf70
Content-Type: text/plain; charset=UTF-8

On Sat, Apr 30, 2016 at 12:51 PM, Christopher Larson <kergoth@gmail.com>
wrote:

> From: Christopher Larson <chris_larson@mentor.com>
>
> This adds support to the git fetcher for fetching and generating mirror
> tarballs of shallow git repositories, with the specified revisions /
> depths.
>
> This implements support for shallow mirror tarballs, not shallow clones.
> Supporting shallow clones directly would be rather more problematic, as
> we'd
> need to hardcode the depth between branch HEAD and the SRCREV, and that
> depth
> would change as the branch is updated. Sadly, git's remote protocol is
> extremely limited.
>
> When BB_GIT_SHALLOW is enabled, we will always attempt to fetch a shallow
> mirror tarball. If the shallow mirror tarball cannot be fetched, it will
> try
> to fetch the full mirror tarball and use that.
>
> Multiple variables exist to exert control over what revisions and refs are
> kept at what are not.
>
> BB_GIT_SHALLOW: enable/disable shallow support as a whole, boolean
> BB_GIT_SHALLOW_DEPTH: specify commit depth for the included refs. defaults
> to 1 (the top commit alone). This can be set to 0 or the empty string.
> BB_GIT_SHALLOW_DEPTH_<name>: specify commit depth for a specific named
> url/branch
> BB_GIT_SHALLOW_REVS: specific revisions whose history should be removed,
> beyond that specified by refs+depth
> BB_GIT_SHALLOW_TRIM_REFS: by default, unused refs/branches are removed.
> set this to 0 or the empty string to keep all refs around. this is required
> for linux-yocto kernel repositories, otherwise the branch checking done by
> the kernel scripts will fail
> BB_GIT_SHALLOW_EXTRA_REFS: additional refs to keep beyond those referenced
> in SRC_URI, when TRIM_REFS is enabled
> BB_GENERATE_SHALLOW_TARBALLS: explicitly control creation of shallow
> mirror tarballs. this defaults to enabled when BB_GENERATE_MIRROR_TARBALLS
> is enabled
>
> Example usage:
>
>     BB_GIT_SHALLOW ?= "1"
>     BB_GIT_SHALLOW_DEPTH ?= "1"
>
>     # Usage in a recipe with multiple named uris or multiple named branches
>     BB_GIT_SHALLOW_DEPTH_doc = ""
>
>     # Remove the upstream history from our kernel repo, keeping our own
>     BB_GIT_SHALLOW_REVS_pn-linux-mel_mx6 = "v3.14"
>     BB_GIT_SHALLOW_DEPTH_pn-linux-mel_mx6 = ""
>
>     # Keep the branches in linux-yocto repositories
>     BB_GIT_SHALLOW_TRIM_REFS_pn-linux-yocto = "0"
>
> Signed-off-by: Christopher Larson <chris_larson@mentor.com>
>

v3 forthcoming (sigh)
-- 
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a113968143cc31a0531bbcf70
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Sat, Apr 30, 2016 at 12:51 PM, Christopher Larson <span dir=3D"ltr">=
&lt;<a href=3D"mailto:kergoth@gmail.com" target=3D"_blank">kergoth@gmail.co=
m</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"HOE=
nZb"><div class=3D"h5">From: Christopher Larson &lt;<a href=3D"mailto:chris=
_larson@mentor.com">chris_larson@mentor.com</a>&gt;<br>
<br>
This adds support to the git fetcher for fetching and generating mirror<br>
tarballs of shallow git repositories, with the specified revisions / depths=
.<br>
<br>
This implements support for shallow mirror tarballs, not shallow clones.<br=
>
Supporting shallow clones directly would be rather more problematic, as we&=
#39;d<br>
need to hardcode the depth between branch HEAD and the SRCREV, and that dep=
th<br>
would change as the branch is updated. Sadly, git&#39;s remote protocol is<=
br>
extremely limited.<br>
<br>
When BB_GIT_SHALLOW is enabled, we will always attempt to fetch a shallow<b=
r>
mirror tarball. If the shallow mirror tarball cannot be fetched, it will tr=
y<br>
to fetch the full mirror tarball and use that.<br>
<br>
Multiple variables exist to exert control over what revisions and refs are<=
br>
kept at what are not.<br>
<br>
BB_GIT_SHALLOW: enable/disable shallow support as a whole, boolean<br>
BB_GIT_SHALLOW_DEPTH: specify commit depth for the included refs. defaults =
to 1 (the top commit alone). This can be set to 0 or the empty string.<br>
BB_GIT_SHALLOW_DEPTH_&lt;name&gt;: specify commit depth for a specific name=
d url/branch<br>
BB_GIT_SHALLOW_REVS: specific revisions whose history should be removed, be=
yond that specified by refs+depth<br>
BB_GIT_SHALLOW_TRIM_REFS: by default, unused refs/branches are removed. set=
 this to 0 or the empty string to keep all refs around. this is required fo=
r linux-yocto kernel repositories, otherwise the branch checking done by th=
e kernel scripts will fail<br>
BB_GIT_SHALLOW_EXTRA_REFS: additional refs to keep beyond those referenced =
in SRC_URI, when TRIM_REFS is enabled<br>
BB_GENERATE_SHALLOW_TARBALLS: explicitly control creation of shallow mirror=
 tarballs. this defaults to enabled when BB_GENERATE_MIRROR_TARBALLS is ena=
bled<br>
<br>
Example usage:<br>
<br>
=C2=A0 =C2=A0 BB_GIT_SHALLOW ?=3D &quot;1&quot;<br>
=C2=A0 =C2=A0 BB_GIT_SHALLOW_DEPTH ?=3D &quot;1&quot;<br>
<br>
=C2=A0 =C2=A0 # Usage in a recipe with multiple named uris or multiple name=
d branches<br>
=C2=A0 =C2=A0 BB_GIT_SHALLOW_DEPTH_doc =3D &quot;&quot;<br>
<br>
=C2=A0 =C2=A0 # Remove the upstream history from our kernel repo, keeping o=
ur own<br>
=C2=A0 =C2=A0 BB_GIT_SHALLOW_REVS_pn-linux-mel_mx6 =3D &quot;v3.14&quot;<br=
>
=C2=A0 =C2=A0 BB_GIT_SHALLOW_DEPTH_pn-linux-mel_mx6 =3D &quot;&quot;<br>
<br>
=C2=A0 =C2=A0 # Keep the branches in linux-yocto repositories<br>
=C2=A0 =C2=A0 BB_GIT_SHALLOW_TRIM_REFS_pn-linux-yocto =3D &quot;0&quot;<br>
<br>
Signed-off-by: Christopher Larson &lt;<a href=3D"mailto:chris_larson@mentor=
.com">chris_larson@mentor.com</a>&gt;</div></div></blockquote><div><br></di=
v><div>v3 forthcoming (sigh)=C2=A0</div></div>-- <br><div class=3D"gmail_si=
gnature"><div dir=3D"ltr">Christopher Larson<br>kergoth at gmail dot com<br=
>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senio=
r Software Engineer, Mentor Graphics</div></div>
</div></div>

--001a113968143cc31a0531bbcf70--
