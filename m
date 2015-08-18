Return-Path: <kergoth@gmail.com>
Received: from mail-ig0-f173.google.com (mail-ig0-f173.google.com
	[209.85.213.173])
	by mail.openembedded.org (Postfix) with ESMTP id 4A67460043
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 18:35:23 +0000 (UTC)
Received: by igui7 with SMTP id i7so89857815igu.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 11:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type;
	bh=7ljF7e2nQ1O1KquhG01havBn+3rgT6D3TS2Suaey4Ps=;
	b=KHQol5dWJ/kGHR/uuPs+fXmE7ZQ5OgimebakK0rhfUnv8O66l0YCsk/gHuy6WBKFN9
	C+4vCNhRBXLf97ntSz0GwckOjRvdCAw7k47EWxSQvYoCwHftG7L/J0f/HA8sX1Dx0gRk
	zz+CYIuz+K1cjWRC9ISLjRxJtvh3si02rTQzQiddqV6RDE/8IBcuJ5d/Aidi3+UmEEwV
	FICL7wXUlfJwvXxiyk4nMdZ4J1CXnxlwWCk9Bb/7L9rpq/rjfwyBFLJGPDSN3kcY/XSC
	hPp1fl9HR2TsybfkjQqL02GOyAFIvgHKAVQoes3w6FIXiuIXyCuoNwEBEdAYVyqCoVz9
	oQ8w==
X-Received: by 10.50.138.76 with SMTP id qo12mr25096451igb.38.1439922923176;
	Tue, 18 Aug 2015 11:35:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.118.150 with HTTP; Tue, 18 Aug 2015 11:35:03 -0700 (PDT)
In-Reply-To: <CABcZANmP1md-Rn1pA_cAWdO4sKANROPgz8fapb04UL4cfc-U5g@mail.gmail.com>
References: <cover.1439509247.git.chris_larson@mentor.com>
	<CABcZAN=qS5Hc2KMr2bazenmfoPDdU2fL_3TqAYedGWr=jnH17A@mail.gmail.com>
	<20150818084520.GF2458@jama>
	<CABcZANmP1md-Rn1pA_cAWdO4sKANROPgz8fapb04UL4cfc-U5g@mail.gmail.com>
From: Christopher Larson <kergoth@gmail.com>
Date: Tue, 18 Aug 2015 11:35:03 -0700
Message-ID: <CABcZANmRM78-5NFg+deE90nAbp4ByjW8Kz40YVhr91ihfaO-uQ@mail.gmail.com>
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
X-List-Received-Date: Tue, 18 Aug 2015 18:35:31 -0000
Content-Type: multipart/alternative; boundary=001a1134b9645708da051d9a2efb

--001a1134b9645708da051d9a2efb
Content-Type: text/plain; charset=UTF-8

On Tue, Aug 18, 2015 at 7:28 AM, Christopher Larson <kergoth@gmail.com>
wrote:

>
> On Tue, Aug 18, 2015 at 1:45 AM, Martin Jansa <martin.jansa@gmail.com>
> wrote:
>
>> On Fri, Aug 14, 2015 at 08:57:17AM -0700, Christopher Larson wrote:
>> > On Thu, Aug 13, 2015 at 4:46 PM, Christopher Larson <kergoth@gmail.com>
>> > wrote:
>> >
>> > > From: Christopher Larson <chris_larson@mentor.com>
>> > >
>> > > Please review the following changes for suitability for inclusion. If
>> you
>> > > have
>> > > any objections or suggestions for improvement, please respond to the
>> > > patches. If
>> > > you agree with the changes, please provide your Acked-by.
>> > >
>> > > This only implements support for shallow mirror tarballs, not shallow
>> > > clones.
>> > >
>> > > The mirror tarball filename includes branch, revision, and depth. To
>> > > enable,
>> > > use the `BB_GIT_SHALLOW` variable, or `BB_GIT_SHALLOW_<name>` for
>> specific
>> > > URLs. This variable can hold either a clone depth (e.g. `1` to just
>> get
>> > > SRCREV), or a ref or commit, in which case we keep history up to that
>> > > commit.
>> > >
>> > > The shallow support will not, at this time, function correctly for
>> > > linux-yocto, due to its branching scheme & validation.
>> > >
>> > > Example:
>> > >
>> > >     BB_GIT_SHALLOW ?= "1"
>> > >     BB_GIT_SHALLOW_pn-linux-yocto = ""
>> > >     BB_GIT_SHALLOW_pn-linux-mel_mx6 = "v3.14"
>> > >     BB_GIT_SHALLOW_pn-testrepo = "testbranch"
>> > >
>> > > This implementation will attempt to fetch a full mirror tarball if it
>> was
>> > > unable to fetch a shallow tarball. If `BB_GIT_SHALLOW` and
>> > > `BB_GENERATE_MIRROR_TARBALLS` are enabled for a given recipe, a
>> shallow
>> > > tarball will be emitted.
>>
>> It would be nice to describe what this implementation does when there is
>> some local git clone already (will it first try to update it with "git
>> fetch"
>> or download shallow tarball?)
>
>
> In that case, I believe it will update the clone and use that, unless we
> have a current tarball already downloaded, but I'll double check the logic
> and get back to you.


I was correct about the behavioral inconsistency of the current
implementation -- if both existed, localpath was returning the mirror
tarball, needs_update was returning false regardless of the state of the
clone, and then unpack would unpack the out of date clone instead of the
tarball :) Not ideal, obviously -- either we prefer a shallow tarball to a
clone or vice versa, not somewhere in-between. I'm fixing that now.

I think that since the clone is essentially a superset (or should be) of
the clone tarball, it should probably be preferred when both are around,
but I'm open to opinions on that.
-- 
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a1134b9645708da051d9a2efb
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Aug 18, 2015 at 7:28 AM, Christopher Larson <span dir=3D"ltr">&lt;<=
a href=3D"mailto:kergoth@gmail.com" target=3D"_blank">kergoth@gmail.com</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"adM"><di=
v class=3D"h5"><br><div class=3D"gmail_quote">On Tue, Aug 18, 2015 at 1:45 =
AM, Martin Jansa <span dir=3D"ltr">&lt;<a href=3D"mailto:martin.jansa@gmail=
.com" target=3D"_blank">martin.jansa@gmail.com</a>&gt;</span> wrote:<br><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex"><div><div>On Fri, Aug 14, 2015 at 08:57:17AM -0=
700, Christopher Larson wrote:<br>
&gt; On Thu, Aug 13, 2015 at 4:46 PM, Christopher Larson &lt;<a href=3D"mai=
lto:kergoth@gmail.com" target=3D"_blank">kergoth@gmail.com</a>&gt;<br>
&gt; wrote:<br>
&gt;<br>
&gt; &gt; From: Christopher Larson &lt;<a href=3D"mailto:chris_larson@mento=
r.com" target=3D"_blank">chris_larson@mentor.com</a>&gt;<br>
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
or download shallow tarball?)</blockquote></div><br></div></div>In that cas=
e, I believe it will update the clone and use that, unless we have a curren=
t tarball already downloaded, but I&#39;ll double check the logic and get b=
ack to you.</blockquote></div><br>I was correct about the behavioral incons=
istency of the current implementation -- if both existed, localpath was ret=
urning the mirror tarball, needs_update was returning false regardless of t=
he state of the clone, and then unpack would unpack the out of date clone i=
nstead of the tarball :) Not ideal, obviously -- either we prefer a shallow=
 tarball to a clone or vice versa, not somewhere in-between. I&#39;m fixing=
 that now.</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_ex=
tra">I think that since the clone is essentially a superset (or should be) =
of the clone tarball, it should probably be preferred when both are around,=
 but I&#39;m open to opinions on that.</div><div class=3D"gmail_extra">-- <=
br><div class=3D"gmail_signature"><div dir=3D"ltr">Christopher Larson<br>ke=
rgoth at gmail dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Ma=
intainer - Tslib<br>Senior Software Engineer, Mentor Graphics</div></div>
</div></div>

--001a1134b9645708da051d9a2efb--
