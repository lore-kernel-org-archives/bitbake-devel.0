Return-Path: <kergoth@gmail.com>
Received: from mail-ig0-f174.google.com (mail-ig0-f174.google.com
	[209.85.213.174])
	by mail.openembedded.org (Postfix) with ESMTP id 5800E72A78
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Aug 2015 15:57:36 +0000 (UTC)
Received: by igui7 with SMTP id i7so15455271igu.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Aug 2015 08:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:content-type; bh=r1GMHC1ce/8KT9ccOXbTqU6i/1b9jiEOfukDm39nQec=;
	b=KtTpLS02HY1Pqd0I/0gHhIKSZwKbtYr1Tql9y1XrEf8NeucLHehnwWtnY5vK9CnVnk
	J2QEX/IlcTyfYPaRYD3js7ZZLH8fEWPMnwUgNTY6KZCQ6GYHWomU/aTDCHOEFZNRiYcE
	fJDriZfDoC+1mCqe2HYu8QGPmIb+qo4cLtBJMTptOsXn5PVhMx+OqwL1bVK+GNq7+fMs
	SxIV8FXZi8HutXuHDcyvPaJrQoNCvWmniGzkH6nvJcrr6WgclTzHY+K1CXaUAsl99dpK
	lGb+FooTjmaocJH4N5kqNKcJ/n+tyj45rO31JLrm+Mj+WSGklLJHowHyc19OY2c2j4ft
	CyOg==
X-Received: by 10.50.78.99 with SMTP id a3mr3304036igx.29.1439567856621; Fri,
	14 Aug 2015 08:57:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.100.199 with HTTP; Fri, 14 Aug 2015 08:57:17 -0700 (PDT)
In-Reply-To: <cover.1439509247.git.chris_larson@mentor.com>
References: <cover.1439509247.git.chris_larson@mentor.com>
From: Christopher Larson <kergoth@gmail.com>
Date: Fri, 14 Aug 2015 08:57:17 -0700
Message-ID: <CABcZAN=qS5Hc2KMr2bazenmfoPDdU2fL_3TqAYedGWr=jnH17A@mail.gmail.com>
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
X-List-Received-Date: Fri, 14 Aug 2015 15:57:38 -0000
Content-Type: multipart/alternative; boundary=089e0122f7a8b95d67051d47828c

--089e0122f7a8b95d67051d47828c
Content-Type: text/plain; charset=UTF-8

On Thu, Aug 13, 2015 at 4:46 PM, Christopher Larson <kergoth@gmail.com>
wrote:

> From: Christopher Larson <chris_larson@mentor.com>
>
> Please review the following changes for suitability for inclusion. If you
> have
> any objections or suggestions for improvement, please respond to the
> patches. If
> you agree with the changes, please provide your Acked-by.
>
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

I forgot to mention, this implements [YOCTO #7958](
https://bugzilla.yoctoproject.org/show_bug.cgi?id=7958).
-- 
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--089e0122f7a8b95d67051d47828c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Thu, Aug 13, 2015 at 4:46 PM, Christopher Larson <span dir=3D"ltr">&lt;<=
a href=3D"mailto:kergoth@gmail.com" target=3D"_blank">kergoth@gmail.com</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D":26w" class=
=3D"a3s" style=3D"overflow:hidden">From: Christopher Larson &lt;<a href=3D"=
mailto:chris_larson@mentor.com">chris_larson@mentor.com</a>&gt;<br>
<br>
Please review the following changes for suitability for inclusion. If you h=
ave<br>
any objections or suggestions for improvement, please respond to the patche=
s. If<br>
you agree with the changes, please provide your Acked-by.<br>
<br>
This only implements support for shallow mirror tarballs, not shallow clone=
s.<br>
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
tarball will be emitted.</div></blockquote></div><br>I forgot to mention, t=
his implements [YOCTO #7958](<a href=3D"https://bugzilla.yoctoproject.org/s=
how_bug.cgi?id=3D7958">https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D=
7958</a>).<br>-- <br><div class=3D"gmail_signature"><div dir=3D"ltr">Christ=
opher Larson<br>kergoth at gmail dot com<br>Founder - BitBake, OpenEmbedded=
, OpenZaurus<br>Maintainer - Tslib<br>Senior Software Engineer, Mentor Grap=
hics</div></div>
</div></div>

--089e0122f7a8b95d67051d47828c--
