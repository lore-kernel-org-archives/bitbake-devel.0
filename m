Return-Path: <christian.lindeberg@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0446BCA0ED3
	for <webhook@archiver.kernel.org>; Mon,  2 Sep 2024 12:36:29 +0000 (UTC)
Subject: Re: [PATCH 1/2] fetch2: Add gomod fetcher
To: bitbake-devel@lists.openembedded.org
From: "Christian Lindeberg" <christian.lindeberg@axis.com>
X-Originating-Location: =?UTF-8?B?THVuZCwgU2vDpW5lIENvdW50eSwgU0U=?= (195.60.68.152)
X-Originating-Platform: Linux Chrome 127
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Mon, 02 Sep 2024 05:36:20 -0700
References: <d5b067dffb623ef16fc9bfd410297cc0a92de47d.camel@linuxfoundation.org>
In-Reply-To: <d5b067dffb623ef16fc9bfd410297cc0a92de47d.camel@linuxfoundation.org>
Message-ID: <7993.1725280580423503052@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="gwCcUzJNABeVDjzSjWwG"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 02 Sep 2024 12:36:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16536

--gwCcUzJNABeVDjzSjWwG
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 12:18 PM, Richard Purdie wrote:

>=20
> On Mon, 2024-09-02 at 11:13 +0200, Christian Lindeberg via
> lists.openembedded.org wrote:
>=20
>> From: Christian Lindeberg <christian.lindeberg@axis.com>
>>=20
>> Add a go module fetcher for downloading module dependencies to the
>> module cache from a module proxy. The fetcher can be used with the
>> go-mod class in OE-Core.
>>=20
>> A module dependency can be specified with:
>>=20
>> SRC_URI +=3D "gomod://golang.org/x/net;version=3Dv0.9.0;sha256sum=3D..."
>>=20
>> Signed-off-by: Christian Lindeberg <christian.lindeberg@axis.com>
>> ---
>> lib/bb/fetch2/__init__.py |=C2=A0=C2=A0 4 +-
>> lib/bb/fetch2/gomod.py=C2=A0=C2=A0=C2=A0 | 116 +++++++++++++++++++++++++=
+++++++++++++
>> lib/bb/tests/fetch.py=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 73 +++++++++++++++=
+++++++++
>> 3 files changed, 192 insertions(+), 1 deletion(-)
>> create mode 100644 lib/bb/fetch2/gomod.py
>=20
> These changes look interesting and I'd be interested to hear review
> from other people more used to dealing with go.
>=20
> I see the code using GOMODCACHE in unpack(). In general the fetcher
> tries to work off url parameters and we try not to have environment
> variables unless they are truly global config. This looks to be a per
> recipe local setting.
>=20
> I guess this is something which any code using go is going to have to
> have set into the environment anyway so perhaps it is ok but I'm not
> sure I like the precedent.

I was trying to avoid having to define the location both in fetcher and
in go-mod.bbclass/recipe. But would using a directory relative rootdir
in unpack() and adapting go/mod.bbclass/recipe accordingly be preferred?

>=20
> I also noticed that there are two fetchers in the code, one which
> subclasses git and one which subclasses wget, the difference between
> them is a direct=3Dgit parameter in the url. I did wonder if these should
> just be two url types (gomod:// and gomodvcs://)?

I started with a separate gomodgit:// scheme. Maybe that was clearer
after all, avoiding the extra parameter?

>=20
> It may also be helpful to document in the code exactly what changes to
> the underlying base fetcher are being made. I'm a bit worried about how
> changes to the git or wget fetcher might break this code, particularly
> as it isn't going to be heavily used/tested as far as I can tell.

I was hoping the tests would help avoiding that the unpacking breaks.
Maybe verification of the resulting git or wget parameters would make
the assumptions more clear?

>=20
> Cheers,
>=20
> Richard

Thanks,

Christian

--gwCcUzJNABeVDjzSjWwG
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>On Mon, Sep 2, 2024 at 12:18 PM, Richard Purdie wrote:</div>
<div>
<blockquote>On Mon, 2024-09-02 at 11:13 +0200, Christian Lindeberg via list=
s.openembedded.org wrote:<br />
<blockquote>From: Christian Lindeberg &lt;christian.lindeberg@axis.com&gt;<=
br /><br />Add a go module fetcher for downloading module dependencies to t=
he<br />module cache from a module proxy. The fetcher can be used with the<=
br />go-mod class in OE-Core.<br /><br />A module dependency can be specifi=
ed with:<br /><br />&nbsp; SRC_URI +=3D "gomod://golang.org/x/net;version=
=3Dv0.9.0;sha256sum=3D..."<br /><br />Signed-off-by: Christian Lindeberg &l=
t;christian.lindeberg@axis.com&gt;<br />---<br />&nbsp;lib/bb/fetch2/__init=
__.py |&nbsp;&nbsp; 4 +-<br />&nbsp;lib/bb/fetch2/gomod.py&nbsp;&nbsp;&nbsp=
; | 116 ++++++++++++++++++++++++++++++++++++++<br />&nbsp;lib/bb/tests/fetc=
h.py&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 73 ++++++++++++++++++++++++<br />&nbsp=
;3 files changed, 192 insertions(+), 1 deletion(-)<br />&nbsp;create mode 1=
00644 lib/bb/fetch2/gomod.py</blockquote>
These changes look interesting and I'd be interested to hear review<br />fr=
om other people more used to dealing with go.<br /><br />I see the code usi=
ng GOMODCACHE in unpack(). In general the fetcher<br />tries to work off ur=
l parameters and we try not to have environment<br />variables unless they =
are truly global config. This looks to be a per<br />recipe local setting.<=
br /><br />I guess this is something which any code using go is going to ha=
ve to<br />have set into the environment anyway so perhaps it is ok but I'm=
 not<br />sure I like the precedent.</blockquote>
I was trying to avoid having to define the location both in fetcher and</di=
v>
<div>in go-mod.bbclass/recipe. But would using a directory relative rootdir=
</div>
<div>in unpack() and adapting go/mod.bbclass/recipe accordingly be preferre=
d?</div>
<div><br />
<blockquote>I also noticed that there are two fetchers in the code, one whi=
ch<br />subclasses git and one which subclasses wget, the difference betwee=
n<br />them is a direct=3Dgit parameter in the url. I did wonder if these s=
hould<br />just be two url types (gomod:// and gomodvcs://)?</blockquote>
I started with a separate gomodgit:// scheme. Maybe that was clearer</div>
<div>after all, avoiding the extra parameter?</div>
<div><br />
<blockquote>It may also be helpful to document in the code exactly what cha=
nges to<br />the underlying base fetcher are being made. I'm a bit worried =
about how<br />changes to the git or wget fetcher might break this code, pa=
rticularly<br />as it isn't going to be heavily used/tested as far as I can=
 tell.</blockquote>
I was hoping the tests would help avoiding that the unpacking breaks.</div>
<div>Maybe verification of the resulting git or wget parameters would make<=
/div>
<div>the assumptions more clear?</div>
<div><br />
<blockquote>Cheers,<br /><br />Richard</blockquote>
Thanks,</div>
<div>&nbsp;</div>
<div>Christian</div>

--gwCcUzJNABeVDjzSjWwG--

