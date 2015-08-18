Return-Path: <kergoth@gmail.com>
Received: from mail-ig0-f169.google.com (mail-ig0-f169.google.com
	[209.85.213.169])
	by mail.openembedded.org (Postfix) with ESMTP id ECB4176A0A
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 22:44:34 +0000 (UTC)
Received: by igui7 with SMTP id i7so91606604igu.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 15:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type;
	bh=FJ5G40uIbxHFwIO+55nTQkPOi1WBPTIwN3UnwfyZb4E=;
	b=p2AsV5nt20muy+znhCmyGYGhU56NVMV+/aOCz8r0h3YO18tGeCG9G+uiCHBq7AoVdE
	V0RlLOpypaeEZAremxGva4O6zKSKmo3b7gyRfJitN43nHHPYzwtvQqQxgmOvfhAkAV03
	WZli3itwiJl9Zo5hv9Rv2UA1+geFFP8yF3Jp/wDPeNHkhjdmZ5NK1qXF0OrpYCHWRDCC
	syVMGz29BKCulpqjKdDwYK+QDJao2MzB31lgGI/beb5/yCHNruNEP+FIPvQOpeKR6N/6
	DxRVYo4CED6poWHarRWbqqrfOELT0EhN0J4qe1GbYIRJy426UwEbOXQ0qGswzSSKGhSm
	wTEQ==
X-Received: by 10.50.103.71 with SMTP id fu7mr26207029igb.38.1439937874427;
	Tue, 18 Aug 2015 15:44:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.118.150 with HTTP; Tue, 18 Aug 2015 15:44:15 -0700 (PDT)
In-Reply-To: <20150818185124.GA10246@jama>
References: <cover.1439509247.git.chris_larson@mentor.com>
	<CABcZAN=qS5Hc2KMr2bazenmfoPDdU2fL_3TqAYedGWr=jnH17A@mail.gmail.com>
	<20150818084520.GF2458@jama>
	<CABcZANmP1md-Rn1pA_cAWdO4sKANROPgz8fapb04UL4cfc-U5g@mail.gmail.com>
	<CABcZANmRM78-5NFg+deE90nAbp4ByjW8Kz40YVhr91ihfaO-uQ@mail.gmail.com>
	<20150818185124.GA10246@jama>
From: Christopher Larson <kergoth@gmail.com>
Date: Tue, 18 Aug 2015 15:44:15 -0700
Message-ID: <CABcZANm1Bwq1TrZM2zatkxt33DDUR7kvhngkEG1Kc8QTevHKmQ@mail.gmail.com>
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
X-List-Received-Date: Tue, 18 Aug 2015 22:44:35 -0000
Content-Type: multipart/alternative; boundary=047d7b2e11e7811c6f051d9da90e

--047d7b2e11e7811c6f051d9da90e
Content-Type: text/plain; charset=UTF-8

On Tue, Aug 18, 2015 at 11:51 AM, Martin Jansa <martin.jansa@gmail.com>
wrote:

> On Tue, Aug 18, 2015 at 11:35:03AM -0700, Christopher Larson wrote:
> > On Tue, Aug 18, 2015 at 7:28 AM, Christopher Larson <kergoth@gmail.com>
> > wrote:
> >
> > >
> > > On Tue, Aug 18, 2015 at 1:45 AM, Martin Jansa <martin.jansa@gmail.com>
> > > wrote:
> > >
> > >> On Fri, Aug 14, 2015 at 08:57:17AM -0700, Christopher Larson wrote:
> > >> > On Thu, Aug 13, 2015 at 4:46 PM, Christopher Larson <
> kergoth@gmail.com>
> > >> > wrote:
> > >> >
> > >> > > From: Christopher Larson <chris_larson@mentor.com>
> > >> > >
> > >> > > Please review the following changes for suitability for
> inclusion. If
> > >> you
> > >> > > have
> > >> > > any objections or suggestions for improvement, please respond to
> the
> > >> > > patches. If
> > >> > > you agree with the changes, please provide your Acked-by.
> > >> > >
> > >> > > This only implements support for shallow mirror tarballs, not
> shallow
> > >> > > clones.
> > >> > >
> > >> > > The mirror tarball filename includes branch, revision, and depth.
> To
> > >> > > enable,
> > >> > > use the `BB_GIT_SHALLOW` variable, or `BB_GIT_SHALLOW_<name>` for
> > >> specific
> > >> > > URLs. This variable can hold either a clone depth (e.g. `1` to
> just
> > >> get
> > >> > > SRCREV), or a ref or commit, in which case we keep history up to
> that
> > >> > > commit.
> > >> > >
> > >> > > The shallow support will not, at this time, function correctly for
> > >> > > linux-yocto, due to its branching scheme & validation.
> > >> > >
> > >> > > Example:
> > >> > >
> > >> > >     BB_GIT_SHALLOW ?= "1"
> > >> > >     BB_GIT_SHALLOW_pn-linux-yocto = ""
> > >> > >     BB_GIT_SHALLOW_pn-linux-mel_mx6 = "v3.14"
> > >> > >     BB_GIT_SHALLOW_pn-testrepo = "testbranch"
> > >> > >
> > >> > > This implementation will attempt to fetch a full mirror tarball
> if it
> > >> was
> > >> > > unable to fetch a shallow tarball. If `BB_GIT_SHALLOW` and
> > >> > > `BB_GENERATE_MIRROR_TARBALLS` are enabled for a given recipe, a
> > >> shallow
> > >> > > tarball will be emitted.
> > >>
> > >> It would be nice to describe what this implementation does when there
> is
> > >> some local git clone already (will it first try to update it with "git
> > >> fetch"
> > >> or download shallow tarball?)
> > >
> > >
> > > In that case, I believe it will update the clone and use that, unless
> we
> > > have a current tarball already downloaded, but I'll double check the
> logic
> > > and get back to you.
> >
> >
> > I was correct about the behavioral inconsistency of the current
> > implementation -- if both existed, localpath was returning the mirror
> > tarball, needs_update was returning false regardless of the state of the
> > clone, and then unpack would unpack the out of date clone instead of the
> > tarball :) Not ideal, obviously -- either we prefer a shallow tarball to
> a
> > clone or vice versa, not somewhere in-between. I'm fixing that now.
> >
> > I think that since the clone is essentially a superset (or should be) of
> > the clone tarball, it should probably be preferred when both are around,
> > but I'm open to opinions on that.
>
> I agree that existing clone should be preferred over shallow tarball
> (doing incremental update should be faster in most repositories and
> updating local clone will be useful next time SRCREV is upgraded again).
>

The one concern I have is, what if we have a perfectly useful shallow
tarball, and an out of date clone, and upstream is down, so the fetch to
update it fails. Ideally, the MIRRORS (not PREMIRRORS) would then be
fetched, and it'd realize that the shallow tarball already exists and use
that, but I suspect unpack() would end up using the out of date clone in
that case, since we prefer the clone. I'll have to test that case out and
see if I need to manually check needs_update() in unpack to decide which to
use.

When fetching from premirror shallow tarball should be preferred over
> full clone (maybe make it configureable for cases where shallow clone is
> still big compared with full clone and when developer expects many
> SRCREV bumps - e.g. for AUTOREV - better to fetch full 10GB clone once
> per builder machine and do git fetch every 2 days, than downloading 1GB
> shallow clone tarball every 2 days - we have this case with huge
> *webkit* or chromium repos already).


Yeah, that should be doable with this implementation, either enable it
globally and then disable on a per-recipe basis, or use inline python to
change the value based on AUTOREV usage, or keep it off globally and opt-in
on a per-recipe basis.
-- 
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--047d7b2e11e7811c6f051d9da90e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Aug 18, 2015 at 11:51 AM, Martin Jansa <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:martin.jansa@gmail.com" target=3D"_blank">martin.jansa@gmail.co=
m</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"HOE=
nZb adM"><div class=3D"h5">On Tue, Aug 18, 2015 at 11:35:03AM -0700, Christ=
opher Larson wrote:<br>
&gt; On Tue, Aug 18, 2015 at 7:28 AM, Christopher Larson &lt;<a href=3D"mai=
lto:kergoth@gmail.com">kergoth@gmail.com</a>&gt;<br>
&gt; wrote:<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; On Tue, Aug 18, 2015 at 1:45 AM, Martin Jansa &lt;<a href=3D"mail=
to:martin.jansa@gmail.com">martin.jansa@gmail.com</a>&gt;<br>
&gt; &gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt;&gt; On Fri, Aug 14, 2015 at 08:57:17AM -0700, Christopher Larson =
wrote:<br>
&gt; &gt;&gt; &gt; On Thu, Aug 13, 2015 at 4:46 PM, Christopher Larson &lt;=
<a href=3D"mailto:kergoth@gmail.com">kergoth@gmail.com</a>&gt;<br>
&gt; &gt;&gt; &gt; wrote:<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; From: Christopher Larson &lt;<a href=3D"mailto:chri=
s_larson@mentor.com">chris_larson@mentor.com</a>&gt;<br>
&gt; &gt;&gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; Please review the following changes for suitability=
 for inclusion. If<br>
&gt; &gt;&gt; you<br>
&gt; &gt;&gt; &gt; &gt; have<br>
&gt; &gt;&gt; &gt; &gt; any objections or suggestions for improvement, plea=
se respond to the<br>
&gt; &gt;&gt; &gt; &gt; patches. If<br>
&gt; &gt;&gt; &gt; &gt; you agree with the changes, please provide your Ack=
ed-by.<br>
&gt; &gt;&gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; This only implements support for shallow mirror tar=
balls, not shallow<br>
&gt; &gt;&gt; &gt; &gt; clones.<br>
&gt; &gt;&gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; The mirror tarball filename includes branch, revisi=
on, and depth. To<br>
&gt; &gt;&gt; &gt; &gt; enable,<br>
&gt; &gt;&gt; &gt; &gt; use the `BB_GIT_SHALLOW` variable, or `BB_GIT_SHALL=
OW_&lt;name&gt;` for<br>
&gt; &gt;&gt; specific<br>
&gt; &gt;&gt; &gt; &gt; URLs. This variable can hold either a clone depth (=
e.g. `1` to just<br>
&gt; &gt;&gt; get<br>
&gt; &gt;&gt; &gt; &gt; SRCREV), or a ref or commit, in which case we keep =
history up to that<br>
&gt; &gt;&gt; &gt; &gt; commit.<br>
&gt; &gt;&gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; The shallow support will not, at this time, functio=
n correctly for<br>
&gt; &gt;&gt; &gt; &gt; linux-yocto, due to its branching scheme &amp; vali=
dation.<br>
&gt; &gt;&gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; Example:<br>
&gt; &gt;&gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0BB_GIT_SHALLOW ?=3D &quot;1&quot=
;<br>
&gt; &gt;&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0BB_GIT_SHALLOW_pn-linux-yocto =
=3D &quot;&quot;<br>
&gt; &gt;&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0BB_GIT_SHALLOW_pn-linux-mel_mx6 =
=3D &quot;v3.14&quot;<br>
&gt; &gt;&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0BB_GIT_SHALLOW_pn-testrepo =3D &=
quot;testbranch&quot;<br>
&gt; &gt;&gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; This implementation will attempt to fetch a full mi=
rror tarball if it<br>
&gt; &gt;&gt; was<br>
&gt; &gt;&gt; &gt; &gt; unable to fetch a shallow tarball. If `BB_GIT_SHALL=
OW` and<br>
&gt; &gt;&gt; &gt; &gt; `BB_GENERATE_MIRROR_TARBALLS` are enabled for a giv=
en recipe, a<br>
&gt; &gt;&gt; shallow<br>
&gt; &gt;&gt; &gt; &gt; tarball will be emitted.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; It would be nice to describe what this implementation does wh=
en there is<br>
&gt; &gt;&gt; some local git clone already (will it first try to update it =
with &quot;git<br>
&gt; &gt;&gt; fetch&quot;<br>
&gt; &gt;&gt; or download shallow tarball?)<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; In that case, I believe it will update the clone and use that, un=
less we<br>
&gt; &gt; have a current tarball already downloaded, but I&#39;ll double ch=
eck the logic<br>
&gt; &gt; and get back to you.<br>
&gt;<br>
&gt;<br>
&gt; I was correct about the behavioral inconsistency of the current<br>
&gt; implementation -- if both existed, localpath was returning the mirror<=
br>
&gt; tarball, needs_update was returning false regardless of the state of t=
he<br>
&gt; clone, and then unpack would unpack the out of date clone instead of t=
he<br>
&gt; tarball :) Not ideal, obviously -- either we prefer a shallow tarball =
to a<br>
&gt; clone or vice versa, not somewhere in-between. I&#39;m fixing that now=
.<br>
&gt;<br>
&gt; I think that since the clone is essentially a superset (or should be) =
of<br>
&gt; the clone tarball, it should probably be preferred when both are aroun=
d,<br>
&gt; but I&#39;m open to opinions on that.<br>
<br>
</div></div>I agree that existing clone should be preferred over shallow ta=
rball<br>
(doing incremental update should be faster in most repositories and<br>
updating local clone will be useful next time SRCREV is upgraded again).<br=
></blockquote><div><br></div><div>The one concern I have is, what if we hav=
e a perfectly useful shallow tarball, and an out of date clone, and upstrea=
m is down, so the fetch to update it fails. Ideally, the MIRRORS (not PREMI=
RRORS) would then be fetched, and it&#39;d realize that the shallow tarball=
 already exists and use that, but I suspect unpack() would end up using the=
 out of date clone in that case, since we prefer the clone. I&#39;ll have t=
o test that case out and see if I need to manually check needs_update() in =
unpack to decide which to use.</div><div><br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex">
When fetching from premirror shallow tarball should be preferred over<br>
full clone (maybe make it configureable for cases where shallow clone is<br=
>
still big compared with full clone and when developer expects many<br>
SRCREV bumps - e.g. for AUTOREV - better to fetch full 10GB clone once<br>
per builder machine and do git fetch every 2 days, than downloading 1GB<br>
shallow clone tarball every 2 days - we have this case with huge<br>
*webkit* or chromium repos already).</blockquote></div><br><div>Yeah, that =
should be doable with this implementation, either enable it globally and th=
en disable on a per-recipe basis, or use inline python to change the value =
based on AUTOREV usage, or keep it off globally and opt-in on a per-recipe =
basis.</div>-- <br><div class=3D"gmail_signature"><div dir=3D"ltr">Christop=
her Larson<br>kergoth at gmail dot com<br>Founder - BitBake, OpenEmbedded, =
OpenZaurus<br>Maintainer - Tslib<br>Senior Software Engineer, Mentor Graphi=
cs</div></div>
</div></div>

--047d7b2e11e7811c6f051d9da90e--
