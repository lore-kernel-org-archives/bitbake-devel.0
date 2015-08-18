Return-Path: <kergoth@gmail.com>
Received: from mail-io0-f172.google.com (mail-io0-f172.google.com
	[209.85.223.172])
	by mail.openembedded.org (Postfix) with ESMTP id 389DA60043
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 14:28:36 +0000 (UTC)
Received: by iodb91 with SMTP id b91so190361084iod.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 07:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type;
	bh=wpxtQCSYoabOnB9nGoSWpqmPnJH4Gd5HgIxnwIgMMtQ=;
	b=CkfLX/rthl0uz5YLaRGhCzV3kvFeb9U0E5UbBoNdneNsS0MdWH9GnoQYisLG1iUzHO
	XvFpVrABfHDm1QXW24M+U4ltghAZ/5/SsEcmP3jX68F97FT40Sv+TzlNkmbfzc1rlhSB
	nSiDo7nbNpvLF9iaL5J/eq6S1busqC3jlZQbrYHoldIc/TQDn6FjQMAdM1zeGWCCTdKc
	B0K30EP5FMy+oy8dzw9IXxC9VBbq6sS6Ri0R4eMDeJ9C/LIadZSCzitKYZ6djQOtNaMe
	Bwzzx1ZCjfUGLRMO9CIcncgmn2NArX2EDDCnMKzTKi3IJUCrG+FVouha0D89xTbKfRNu
	D+9g==
X-Received: by 10.107.38.10 with SMTP id m10mr6893043iom.98.1439908116342;
	Tue, 18 Aug 2015 07:28:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.118.150 with HTTP; Tue, 18 Aug 2015 07:28:16 -0700 (PDT)
In-Reply-To: <20150818084520.GF2458@jama>
References: <cover.1439509247.git.chris_larson@mentor.com>
	<CABcZAN=qS5Hc2KMr2bazenmfoPDdU2fL_3TqAYedGWr=jnH17A@mail.gmail.com>
	<20150818084520.GF2458@jama>
From: Christopher Larson <kergoth@gmail.com>
Date: Tue, 18 Aug 2015 07:28:16 -0700
Message-ID: <CABcZANmP1md-Rn1pA_cAWdO4sKANROPgz8fapb04UL4cfc-U5g@mail.gmail.com>
To: Martin Jansa <martin.jansa@gmail.com>
Cc: "bitbake-devel@lists.openembedded.org"
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
X-List-Received-Date: Tue, 18 Aug 2015 14:28:39 -0000
Content-Type: multipart/alternative; boundary=001a1140e7b8c8ada6051d96bb3a

--001a1140e7b8c8ada6051d96bb3a
Content-Type: text/plain; charset=UTF-8

On Tue, Aug 18, 2015 at 1:45 AM, Martin Jansa <martin.jansa@gmail.com>
wrote:

> On Fri, Aug 14, 2015 at 08:57:17AM -0700, Christopher Larson wrote:
> > On Thu, Aug 13, 2015 at 4:46 PM, Christopher Larson <kergoth@gmail.com>
> > wrote:
> >
> > > From: Christopher Larson <chris_larson@mentor.com>
> > >
> > > Please review the following changes for suitability for inclusion. If
> you
> > > have
> > > any objections or suggestions for improvement, please respond to the
> > > patches. If
> > > you agree with the changes, please provide your Acked-by.
> > >
> > > This only implements support for shallow mirror tarballs, not shallow
> > > clones.
> > >
> > > The mirror tarball filename includes branch, revision, and depth. To
> > > enable,
> > > use the `BB_GIT_SHALLOW` variable, or `BB_GIT_SHALLOW_<name>` for
> specific
> > > URLs. This variable can hold either a clone depth (e.g. `1` to just get
> > > SRCREV), or a ref or commit, in which case we keep history up to that
> > > commit.
> > >
> > > The shallow support will not, at this time, function correctly for
> > > linux-yocto, due to its branching scheme & validation.
> > >
> > > Example:
> > >
> > >     BB_GIT_SHALLOW ?= "1"
> > >     BB_GIT_SHALLOW_pn-linux-yocto = ""
> > >     BB_GIT_SHALLOW_pn-linux-mel_mx6 = "v3.14"
> > >     BB_GIT_SHALLOW_pn-testrepo = "testbranch"
> > >
> > > This implementation will attempt to fetch a full mirror tarball if it
> was
> > > unable to fetch a shallow tarball. If `BB_GIT_SHALLOW` and
> > > `BB_GENERATE_MIRROR_TARBALLS` are enabled for a given recipe, a shallow
> > > tarball will be emitted.
>
> It would be nice to describe what this implementation does when there is
> some local git clone already (will it first try to update it with "git
> fetch"
> or download shallow tarball?)


In that case, I believe it will update the clone and use that, unless we
have a current tarball already downloaded, but I'll double check the logic
and get back to you.
-- 
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a1140e7b8c8ada6051d96bb3a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Aug 18, 2015 at 1:45 AM, Martin Jansa <span dir=3D"ltr">&lt;<a href=
=3D"mailto:martin.jansa@gmail.com" target=3D"_blank">martin.jansa@gmail.com=
</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"HOEn=
Zb adM"><div class=3D"">On Fri, Aug 14, 2015 at 08:57:17AM -0700, Christoph=
er Larson wrote:<br>
&gt; On Thu, Aug 13, 2015 at 4:46 PM, Christopher Larson &lt;<a href=3D"mai=
lto:kergoth@gmail.com">kergoth@gmail.com</a>&gt;<br>
&gt; wrote:<br>
&gt;<br>
&gt; &gt; From: Christopher Larson &lt;<a href=3D"mailto:chris_larson@mento=
r.com">chris_larson@mentor.com</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; Please review the following changes for suitability for inclusion=
. If you<br>
&gt; &gt; have<br>
&gt; &gt; any objections or suggestions for improvement, please respond to =
the<br>
&gt; &gt; patches. If<br>
&gt; &gt; you agree with the changes, please provide your Acked-by.<br>
&gt; &gt;<br>
&gt; &gt; This only implements support for shallow mirror tarballs, not sha=
llow<br>
&gt; &gt; clones.<br>
&gt; &gt;<br>
&gt; &gt; The mirror tarball filename includes branch, revision, and depth.=
 To<br>
&gt; &gt; enable,<br>
&gt; &gt; use the `BB_GIT_SHALLOW` variable, or `BB_GIT_SHALLOW_&lt;name&gt=
;` for specific<br>
&gt; &gt; URLs. This variable can hold either a clone depth (e.g. `1` to ju=
st get<br>
&gt; &gt; SRCREV), or a ref or commit, in which case we keep history up to =
that<br>
&gt; &gt; commit.<br>
&gt; &gt;<br>
&gt; &gt; The shallow support will not, at this time, function correctly fo=
r<br>
&gt; &gt; linux-yocto, due to its branching scheme &amp; validation.<br>
&gt; &gt;<br>
&gt; &gt; Example:<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0BB_GIT_SHALLOW ?=3D &quot;1&quot;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0BB_GIT_SHALLOW_pn-linux-yocto =3D &quot;&quot;=
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0BB_GIT_SHALLOW_pn-linux-mel_mx6 =3D &quot;v3.1=
4&quot;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0BB_GIT_SHALLOW_pn-testrepo =3D &quot;testbranc=
h&quot;<br>
&gt; &gt;<br>
&gt; &gt; This implementation will attempt to fetch a full mirror tarball i=
f it was<br>
&gt; &gt; unable to fetch a shallow tarball. If `BB_GIT_SHALLOW` and<br>
&gt; &gt; `BB_GENERATE_MIRROR_TARBALLS` are enabled for a given recipe, a s=
hallow<br>
&gt; &gt; tarball will be emitted.<br>
<br>
</div></div>It would be nice to describe what this implementation does when=
 there is<br>
some local git clone already (will it first try to update it with &quot;git=
 fetch&quot;<br>
or download shallow tarball?)</blockquote></div><br>In that case, I believe=
 it will update the clone and use that, unless we have a current tarball al=
ready downloaded, but I&#39;ll double check the logic and get back to you.<=
br>-- <br><div class=3D"gmail_signature"><div dir=3D"ltr">Christopher Larso=
n<br>kergoth at gmail dot com<br>Founder - BitBake, OpenEmbedded, OpenZauru=
s<br>Maintainer - Tslib<br>Senior Software Engineer, Mentor Graphics</div><=
/div>
</div></div>

--001a1140e7b8c8ada6051d96bb3a--
