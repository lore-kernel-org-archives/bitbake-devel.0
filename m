Return-Path: <kergoth@gmail.com>
Received: from mail-io0-f177.google.com (mail-io0-f177.google.com
	[209.85.223.177])
	by mail.openembedded.org (Postfix) with ESMTP id 9694672A78
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Aug 2015 16:54:36 +0000 (UTC)
Received: by iodb91 with SMTP id b91so90501431iod.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Aug 2015 09:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:content-type; bh=dPE6IpDF1C9hQFyrZltATAem5juq6IOTNozoEkpfZBg=;
	b=apFjQK7Xx4Zae8g4upO/6KOBvbFR3Ju8AnmYlP/AsOXPY1er96HHlrL4vsKtI9YqoT
	AMfNlJIxT7S5lIDdZ/5UNiIxmKV7gkogDqpYayjQIIRfJzfi0RjUEzHDA2aXQMTOpvDL
	+glBmDKLw/J6LvR42Lx+lWAdy0wMyndfLONfV5bKa3S7jSFm5zyuV1s7m79mjXdEfIT9
	f7OgVLJ7slWu45Ygeb0I1sVy2W20A8R+xWv5DGaq5L4OI/bBGg+S3slO3CsKD5Zc9FfE
	Vys84x+SdRlih6kRtiv7gGUD/L4VXRVc7Jam3mVd+uNbe1QpCvKfXYztO5yS+utM1BsX
	WELQ==
X-Received: by 10.107.132.169 with SMTP id o41mr13459964ioi.155.1439571276618; 
	Fri, 14 Aug 2015 09:54:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.100.199 with HTTP; Fri, 14 Aug 2015 09:54:17 -0700 (PDT)
In-Reply-To: <cover.1439509247.git.chris_larson@mentor.com>
References: <cover.1439509247.git.chris_larson@mentor.com>
From: Christopher Larson <kergoth@gmail.com>
Date: Fri, 14 Aug 2015 09:54:17 -0700
Message-ID: <CABcZANkm8PyM47n7oK+5axPfm_-qv4jmcG0MiJ91x8tcDh=VxA@mail.gmail.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [RFC PATCH 0/5] Implement git shallow mirror tarball support
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
X-List-Received-Date: Fri, 14 Aug 2015 16:54:38 -0000
Content-Type: multipart/alternative; boundary=001a113f3982926a29051d484e26

--001a113f3982926a29051d484e26
Content-Type: text/plain; charset=UTF-8

On Thu, Aug 13, 2015 at 4:46 PM, Christopher Larson <kergoth@gmail.com>
wrote:

> This only implements support for shallow mirror tarballs, not shallow
> clones.
>
> The mirror tarball filename includes branch, revision, and depth. To
> enable,
> use the `BB_GIT_SHALLOW` variable, or `BB_GIT_SHALLOW_<name>` for specific
> URLs. This variable can hold either a clone depth (e.g. `1` to just get
> SRCREV), or a ref or commit, in which case we keep history up to that
> commit.
>
> The shallow support will not, at this time, function correctly for
> linux-yocto, due to its branching scheme & validation.
>
> Example:
>
>     BB_GIT_SHALLOW ?= "1"
>     BB_GIT_SHALLOW_pn-linux-yocto = ""
>     BB_GIT_SHALLOW_pn-linux-mel_mx6 = "v3.14"
>     BB_GIT_SHALLOW_pn-testrepo = "testbranch"
>
> This implementation will attempt to fetch a full mirror tarball if it was
> unable to fetch a shallow tarball. If `BB_GIT_SHALLOW` and
> `BB_GENERATE_MIRROR_TARBALLS` are enabled for a given recipe, a shallow
> tarball will be emitted.
>

The other thing I forgot to mention is that the shallow tarballs aren't
unpacked into ${DL_DIR}/git2/ the way the full ones are, they're unpacked
directly into the destination under ${WORKDIR}, to avoid complexities and
confusion. This is why localpath() now returns the shallow tarball path
when it exists, to avoid issues with checksums, and because we don't
need/want download() to do anything else after it's fetched.

I just realized there's a slight inconsistency in the current behavior.
When shallow and the shallow tarball exists, localpath() returns that path,
but in the case where both ud.clonedir and the shallow tarball exists, the
former will be unpacked, not the latter. I'll have to double check that the
case where we have an existing out of date clonedir doesn't cause a shallow
tarball to be fetched, otherwise it'll bypass updating the clonedir in
download() and then unpack the out of date clonedir into workdir. If that's
an issue, can make unpack() prefer the shallow tarball when shallow and the
tarball exists, even if clonedir exists.
-- 
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a113f3982926a29051d484e26
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Thu, Aug 13, 2015 at 4:46 PM, Christopher Larson <span dir=3D"ltr">&lt;<=
a href=3D"mailto:kergoth@gmail.com" target=3D"_blank">kergoth@gmail.com</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D":2s4" class=
=3D"a3s" style=3D"overflow:hidden">This only implements support for shallow=
 mirror tarballs, not shallow clones.<br>
<br>
The mirror tarball filename includes branch, revision, and depth. To enable=
,<br>
use the `BB_GIT_SHALLOW` variable, or `BB_GIT_SHALLOW_&lt;name&gt;` for spe=
cific<br>
URLs. This variable can hold either a clone depth (e.g. `1` to just get<br>
SRCREV), or a ref or commit, in which case we keep history up to that commi=
t.<br>
<br>
The shallow support will not, at this time, function correctly for<br>
linux-yocto, due to its branching scheme &amp; validation.<br>
<br>
Example:<br>
<br>
=C2=A0 =C2=A0 BB_GIT_SHALLOW ?=3D &quot;1&quot;<br>
=C2=A0 =C2=A0 BB_GIT_SHALLOW_pn-linux-yocto =3D &quot;&quot;<br>
=C2=A0 =C2=A0 BB_GIT_SHALLOW_pn-linux-mel_mx6 =3D &quot;v3.14&quot;<br>
=C2=A0 =C2=A0 BB_GIT_SHALLOW_pn-testrepo =3D &quot;testbranch&quot;<br>
<br>
This implementation will attempt to fetch a full mirror tarball if it was<b=
r>
unable to fetch a shallow tarball. If `BB_GIT_SHALLOW` and<br>
`BB_GENERATE_MIRROR_TARBALLS` are enabled for a given recipe, a shallow<br>
tarball will be emitted.</div></blockquote></div><br>The other thing I forg=
ot to mention is that the shallow tarballs aren&#39;t unpacked into ${DL_DI=
R}/git2/ the way the full ones are, they&#39;re unpacked directly into the =
destination under ${WORKDIR}, to avoid complexities and confusion. This is =
why localpath() now returns the shallow tarball path when it exists, to avo=
id issues with checksums, and because we don&#39;t need/want download() to =
do anything else after it&#39;s fetched.</div><div class=3D"gmail_extra"><b=
r></div><div class=3D"gmail_extra">I just realized there&#39;s a slight inc=
onsistency in the current behavior. When shallow and the shallow tarball ex=
ists, localpath() returns that path, but in the case where both ud.clonedir=
 and the shallow tarball exists, the former will be unpacked, not the latte=
r. I&#39;ll have to double check that the case where we have an existing ou=
t of date clonedir doesn&#39;t cause a shallow tarball to be fetched, other=
wise it&#39;ll bypass updating the clonedir in download() and then unpack t=
he out of date clonedir into workdir. If that&#39;s an issue, can make unpa=
ck() prefer the shallow tarball when shallow and the tarball exists, even i=
f clonedir exists.<br>-- <br><div class=3D"gmail_signature"><div dir=3D"ltr=
">Christopher Larson<br>kergoth at gmail dot com<br>Founder - BitBake, Open=
Embedded, OpenZaurus<br>Maintainer - Tslib<br>Senior Software Engineer, Men=
tor Graphics</div></div>
</div></div>

--001a113f3982926a29051d484e26--
