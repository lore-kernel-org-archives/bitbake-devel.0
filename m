Subject: Re: [PATCH] cooker: Only warn on potentially incompatible layer
To: bitbake-devel@lists.openembedded.org
From: "Damian Wrobel" <dwrobel@ertelnet.rybnik.pl>
X-Originating-Location: PL (91.230.58.69)
X-Originating-Platform: Linux Firefox 91
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Tue, 07 Sep 2021 01:54:30 -0700
References: <209f7a813b8003ad75e5edb9600f729a91abee7b.camel@linuxfoundation.org>
In-Reply-To: <209f7a813b8003ad75e5edb9600f729a91abee7b.camel@linuxfoundation.org>
Message-ID: <3199.1631004870582679813@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="30BKjP050J2FGgcBdKxO"

--30BKjP050J2FGgcBdKxO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 4, 2021 at 09:54 AM, Richard Purdie wrote:

>=20
> Adding a single keyword every six months to show the layer is active and
> meant
> to work with a new release is not in my view a huge maintenance burden
> compared
> to showing that the layer is actively maintained and clearly showing whic=
h
>=20
> combinations are meant to work.

It's not feasible because if the layer required some extra bbclasses cherry=
-picked to be support it in the older yocto,
then no one can simply add this keyword to mark it's supported with older y=
octo. This in practise means that despite
the layer itself didn't require any changes to be supported in older yocto =
it will be unconditionally rejected by bitbake.

So, in reality it mean that such a layer has to be forked and modified to b=
e accepted by bitbake.

I hope this clearly shows why this kind of checking in bitbake is inappropr=
iate.

--
Regards,
Damian

--30BKjP050J2FGgcBdKxO
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 4, 2021 at 09:54 AM, Richard Purdie wrote:<br />
<blockquote>Adding a single keyword every six months to show the layer is a=
ctive and meant<br />to work with a new release is not in my view a huge ma=
intenance burden compared<br />to showing that the layer is actively mainta=
ined and clearly showing which<br />combinations are meant to work.</blockq=
uote>
It's not feasible because if the layer required some extra bbclasses cherry=
-picked to be support it in the older yocto,<br />then no one can simply ad=
d this keyword to mark it's supported with older yocto. This in practise me=
ans that despite<br />the layer itself didn't require any changes to be sup=
ported in older yocto it will be unconditionally rejected by bitbake.<br />=
<br />So, in reality it mean that such a layer has to be forked and modifie=
d to be accepted by bitbake.<br /><br />I hope this clearly shows why this =
kind of checking in bitbake is inappropriate.<br /><br />--<br />Regards,<b=
r />Damian

--30BKjP050J2FGgcBdKxO--
