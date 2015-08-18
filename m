Return-Path: <kergoth@gmail.com>
Received: from mail-ig0-f177.google.com (mail-ig0-f177.google.com
	[209.85.213.177])
	by mail.openembedded.org (Postfix) with ESMTP id 2CE4573D17
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 23:51:31 +0000 (UTC)
Received: by igxp17 with SMTP id p17so93509778igx.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 16:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type;
	bh=yArmOKE6IrBIQb/elCVS9DwljvGTyjrsdBCM3uhFOB8=;
	b=ibCkMolY0I2xgz/pFlw858ADiCzL0BiRC9LmE9DdkdGMPRb+lyv0XcB6bXTyzy/jsV
	vc6hjBhbqcEAoIX3ZZX0Yng5uoQmpYcAJVsWWPQxwbOjRQKyewd60XecJKBl2U91Eckw
	u0Bgssol35X5H2hnimWqTHLU0T2MGNw9oIEy+WQv6xFkjr7/S3tOqO4QoHLVPm3zQo54
	I8cXtkVIVxLLYNizSeo66nbSAlSqapZoG9kQlJv3eqT4Sapqxkr1Qr4xQNZbkmHnfNzy
	7TXPzNLbvBQVn4Z78VMzrMV75AHQHJDXSyNaThV0fUuMbqVpHkqhSqPHhi2p3HMQK1hZ
	qKiA==
X-Received: by 10.50.108.37 with SMTP id hh5mr27079275igb.10.1439941891010;
	Tue, 18 Aug 2015 16:51:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.118.150 with HTTP; Tue, 18 Aug 2015 16:51:11 -0700 (PDT)
In-Reply-To: <CABcZANm1Bwq1TrZM2zatkxt33DDUR7kvhngkEG1Kc8QTevHKmQ@mail.gmail.com>
References: <cover.1439509247.git.chris_larson@mentor.com>
	<CABcZAN=qS5Hc2KMr2bazenmfoPDdU2fL_3TqAYedGWr=jnH17A@mail.gmail.com>
	<20150818084520.GF2458@jama>
	<CABcZANmP1md-Rn1pA_cAWdO4sKANROPgz8fapb04UL4cfc-U5g@mail.gmail.com>
	<CABcZANmRM78-5NFg+deE90nAbp4ByjW8Kz40YVhr91ihfaO-uQ@mail.gmail.com>
	<20150818185124.GA10246@jama>
	<CABcZANm1Bwq1TrZM2zatkxt33DDUR7kvhngkEG1Kc8QTevHKmQ@mail.gmail.com>
From: Christopher Larson <kergoth@gmail.com>
Date: Tue, 18 Aug 2015 16:51:11 -0700
Message-ID: <CABcZANkR8h19+z+=4zCorMm2J9quB6qPMsqjvpAA7nGZ_ODPow@mail.gmail.com>
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
X-List-Received-Date: Tue, 18 Aug 2015 23:51:33 -0000
Content-Type: multipart/alternative; boundary=089e01493b5ae93b15051d9e98c7

--089e01493b5ae93b15051d9e98c7
Content-Type: text/plain; charset=UTF-8

On Tue, Aug 18, 2015 at 3:44 PM, Christopher Larson <kergoth@gmail.com>
wrote:

>
> On Tue, Aug 18, 2015 at 11:51 AM, Martin Jansa <martin.jansa@gmail.com>
> wrote:
>
>> On Tue, Aug 18, 2015 at 11:35:03AM -0700, Christopher Larson wrote:
>> > On Tue, Aug 18, 2015 at 7:28 AM, Christopher Larson <kergoth@gmail.com>
>> > wrote:
>> >
>> > >
>> > > On Tue, Aug 18, 2015 at 1:45 AM, Martin Jansa <martin.jansa@gmail.com
>> >
>> > > wrote:
>> > >
>> > >> On Fri, Aug 14, 2015 at 08:57:17AM -0700, Christopher Larson wrote:
>> > >> > On Thu, Aug 13, 2015 at 4:46 PM, Christopher Larson <
>> kergoth@gmail.com>
>> > >> > wrote:
>> > >> >
>> > >> > > From: Christopher Larson <chris_larson@mentor.com>
>> > >> > >
>> > >> > > Please review the following changes for suitability for
>> inclusion. If
>> > >> you
>> > >> > > have
>> > >> > > any objections or suggestions for improvement, please respond to
>> the
>> > >> > > patches. If
>> > >> > > you agree with the changes, please provide your Acked-by.
>> > >> > >
>> > >> > > This only implements support for shallow mirror tarballs, not
>> shallow
>> > >> > > clones.
>> > >> > >
>> > >> > > The mirror tarball filename includes branch, revision, and
>> depth. To
>> > >> > > enable,
>> > >> > > use the `BB_GIT_SHALLOW` variable, or `BB_GIT_SHALLOW_<name>` for
>> > >> specific
>> > >> > > URLs. This variable can hold either a clone depth (e.g. `1` to
>> just
>> > >> get
>> > >> > > SRCREV), or a ref or commit, in which case we keep history up to
>> that
>> > >> > > commit.
>> > >> > >
>> > >> > > The shallow support will not, at this time, function correctly
>> for
>> > >> > > linux-yocto, due to its branching scheme & validation.
>> > >> > >
>> > >> > > Example:
>> > >> > >
>> > >> > >     BB_GIT_SHALLOW ?= "1"
>> > >> > >     BB_GIT_SHALLOW_pn-linux-yocto = ""
>> > >> > >     BB_GIT_SHALLOW_pn-linux-mel_mx6 = "v3.14"
>> > >> > >     BB_GIT_SHALLOW_pn-testrepo = "testbranch"
>> > >> > >
>> > >> > > This implementation will attempt to fetch a full mirror tarball
>> if it
>> > >> was
>> > >> > > unable to fetch a shallow tarball. If `BB_GIT_SHALLOW` and
>> > >> > > `BB_GENERATE_MIRROR_TARBALLS` are enabled for a given recipe, a
>> > >> shallow
>> > >> > > tarball will be emitted.
>> > >>
>> > >> It would be nice to describe what this implementation does when
>> there is
>> > >> some local git clone already (will it first try to update it with
>> "git
>> > >> fetch"
>> > >> or download shallow tarball?)
>> > >
>> > >
>> > > In that case, I believe it will update the clone and use that, unless
>> we
>> > > have a current tarball already downloaded, but I'll double check the
>> logic
>> > > and get back to you.
>> >
>> >
>> > I was correct about the behavioral inconsistency of the current
>> > implementation -- if both existed, localpath was returning the mirror
>> > tarball, needs_update was returning false regardless of the state of the
>> > clone, and then unpack would unpack the out of date clone instead of the
>> > tarball :) Not ideal, obviously -- either we prefer a shallow tarball
>> to a
>> > clone or vice versa, not somewhere in-between. I'm fixing that now.
>> >
>> > I think that since the clone is essentially a superset (or should be) of
>> > the clone tarball, it should probably be preferred when both are around,
>> > but I'm open to opinions on that.
>>
>> I agree that existing clone should be preferred over shallow tarball
>> (doing incremental update should be faster in most repositories and
>> updating local clone will be useful next time SRCREV is upgraded again).
>>
>
> The one concern I have is, what if we have a perfectly useful shallow
> tarball, and an out of date clone, and upstream is down, so the fetch to
> update it fails. Ideally, the MIRRORS (not PREMIRRORS) would then be
> fetched, and it'd realize that the shallow tarball already exists and use
> that, but I suspect unpack() would end up using the out of date clone in
> that case, since we prefer the clone. I'll have to test that case out and
> see if I need to manually check needs_update() in unpack to decide which to
> use.
>

FYI, I confirmed that this is handled, though in a slightly surprising way.
If you have an existing out of date clone, and the attempt to update it
fails, the fetcher *removes* the entire local clone and you start fresh.
Not ideal, obviously, and I have a fix for it locally, but in that case the
fallback to mirrors works painlessly, as the out of date clonedir is
removed by the time the mirror fetching and unpack happens. I'll prep
another RFC commit to change that behavior.
-- 
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--089e01493b5ae93b15051d9e98c7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Aug 18, 2015 at 3:44 PM, Christopher Larson <span dir=3D"ltr">&lt;<=
a href=3D"mailto:kergoth@gmail.com" target=3D"_blank">kergoth@gmail.com</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"adM"><br=
></div><div class=3D"gmail_quote"><div class=3D"adM"><div class=3D"h5">On T=
ue, Aug 18, 2015 at 11:51 AM, Martin Jansa <span dir=3D"ltr">&lt;<a href=3D=
"mailto:martin.jansa@gmail.com" target=3D"_blank">martin.jansa@gmail.com</a=
>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div><div>On Tue, Aug=
 18, 2015 at 11:35:03AM -0700, Christopher Larson wrote:<br>
&gt; On Tue, Aug 18, 2015 at 7:28 AM, Christopher Larson &lt;<a href=3D"mai=
lto:kergoth@gmail.com" target=3D"_blank">kergoth@gmail.com</a>&gt;<br>
&gt; wrote:<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; On Tue, Aug 18, 2015 at 1:45 AM, Martin Jansa &lt;<a href=3D"mail=
to:martin.jansa@gmail.com" target=3D"_blank">martin.jansa@gmail.com</a>&gt;=
<br>
&gt; &gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt;&gt; On Fri, Aug 14, 2015 at 08:57:17AM -0700, Christopher Larson =
wrote:<br>
&gt; &gt;&gt; &gt; On Thu, Aug 13, 2015 at 4:46 PM, Christopher Larson &lt;=
<a href=3D"mailto:kergoth@gmail.com" target=3D"_blank">kergoth@gmail.com</a=
>&gt;<br>
&gt; &gt;&gt; &gt; wrote:<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; From: Christopher Larson &lt;<a href=3D"mailto:chri=
s_larson@mentor.com" target=3D"_blank">chris_larson@mentor.com</a>&gt;<br>
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
></blockquote><div><br></div></div></div><div>The one concern I have is, wh=
at if we have a perfectly useful shallow tarball, and an out of date clone,=
 and upstream is down, so the fetch to update it fails. Ideally, the MIRROR=
S (not PREMIRRORS) would then be fetched, and it&#39;d realize that the sha=
llow tarball already exists and use that, but I suspect unpack() would end =
up using the out of date clone in that case, since we prefer the clone. I&#=
39;ll have to test that case out and see if I need to manually check needs_=
update() in unpack to decide which to use.</div><span class=3D""><div></div=
></span></div></blockquote></div><br>FYI, I confirmed that this is handled,=
 though in a slightly surprising way. If you have an existing out of date c=
lone, and the attempt to update it fails, the fetcher *removes* the entire =
local clone and you start fresh. Not ideal, obviously, and I have a fix for=
 it locally, but in that case the fallback to mirrors works painlessly, as =
the out of date clonedir is removed by the time the mirror fetching and unp=
ack happens. I&#39;ll prep another RFC commit to change that behavior.<br>-=
- <br><div class=3D"gmail_signature"><div dir=3D"ltr">Christopher Larson<br=
>kergoth at gmail dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br=
>Maintainer - Tslib<br>Senior Software Engineer, Mentor Graphics</div></div=
>
</div></div>

--089e01493b5ae93b15051d9e98c7--
