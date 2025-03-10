Return-Path: <c137.marques@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5284C282DE
	for <webhook@archiver.kernel.org>; Mon, 10 Mar 2025 14:19:47 +0000 (UTC)
Subject: Re: [PATCH 0/1] hashserv: Add `gc-mark-stream` command for batch hash marking
To: bitbake-devel@lists.openembedded.org
From: "Alexandre Marques" <c137.marques@gmail.com>
X-Originating-Location: Vila Nova de Foz Coa, Guarda, PT (213.205.68.220)
X-Originating-Platform: Linux Firefox 135
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Mon, 10 Mar 2025 07:19:42 -0700
References: <20250310140118.2649050-1-alexandre.marques@ctw.bmwgroup.com>
In-Reply-To: <20250310140118.2649050-1-alexandre.marques@ctw.bmwgroup.com>
Message-ID: <9243.1741616382313321003@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="HIecwJVXXvBavzRud725"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 10 Mar 2025 14:19:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17421

--HIecwJVXXvBavzRud725
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 07:02 AM, Alexandre Marques wrote:

>=20
> This comes in the sequence of [1]. And it proposes a new garbage
> collection
> command to improve the efficiency of marking several hash equivalence
> database
> entries.
>=20
> A new poky/script using this command will also be added, so that
> developers can use it and to server as a reference on how this new

developers can use it and to serve as a reference on how this new

>=20
> command is meant to be used.
>=20
> Since the hash equivalence server API is also changed, and as of now ther=
e
>=20
> isn't a convenient way to check the API version or which commands are
> available.
>=20
> The new client command assumes a connection error to the server means
> the server does not support "bulk" marking in stream mode, and falls back
> to sequentially marking each input its given.
>=20
> 1 - https://lists.openembedded.org/g/bitbake-devel/topic/clarification_on=
_cleaning_up/111382632a
>=20

1 - https://lists.openembedded.org/g/bitbake-devel/topic/clarification_on_c=
leaning_up/111382632

>=20
> Alexandre Marques (1):
> hashserv: Add `gc-mark-stream` command for batch hash marking
>=20
> bin/bitbake-hashclient | 30 ++++++++++++++++++++++++++++++
> lib/hashserv/client.py | 22 ++++++++++++++++++++++
> lib/hashserv/server.py | 29 +++++++++++++++++++++++++++++
> lib/hashserv/tests.py | 42 ++++++++++++++++++++++++++++++++++++++++++
> 4 files changed, 123 insertions(+)
>=20
> --
> 2.25.1

--HIecwJVXXvBavzRud725
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>On Mon, Mar 10, 2025 at 07:02 AM, Alexandre Marques wrote:</div>
<div>
<blockquote>This comes in the sequence of [1]. And it proposes a new garbag=
e collection<br />command to improve the efficiency of marking several hash=
 equivalence database<br />entries.<br /><br />A new poky/script using this=
 command will also be added, so that<br />developers can use it and to serv=
er as a reference on how this new</blockquote>
developers can use it and to serve as a reference on how this new<br />
<blockquote>command is meant to be used.<br /><br />Since the hash equivale=
nce server API is also changed, and as of now there<br />isn't a convenient=
 way to check the API version or which commands are<br />available.<br /><b=
r />The new client command assumes a connection error to the server means<b=
r />the server does not support "bulk" marking in stream mode, and falls ba=
ck<br />to sequentially marking each input its given.<br /><br />1 - <a hre=
f=3D"https://lists.openembedded.org/g/bitbake-devel/topic/clarification_on_=
cleaning_up/111382632a" target=3D"_blank" rel=3D"noopener">https://lists.op=
enembedded.org/g/bitbake-devel/topic/clarification_on_cleaning_up/111382632=
a</a></blockquote>
1 - <a href=3D"https://lists.openembedded.org/g/bitbake-devel/topic/clarifi=
cation_on_cleaning_up/111382632" target=3D"_blank" rel=3D"noopener">https:/=
/lists.openembedded.org/g/bitbake-devel/topic/clarification_on_cleaning_up/=
111382632</a> <br />
<blockquote>Alexandre Marques (1):<br />hashserv: Add `gc-mark-stream` comm=
and for batch hash marking<br /><br />bin/bitbake-hashclient | 30 +++++++++=
+++++++++++++++++++++<br />lib/hashserv/client.py | 22 ++++++++++++++++++++=
++<br />lib/hashserv/server.py | 29 +++++++++++++++++++++++++++++<br />lib/=
hashserv/tests.py | 42 ++++++++++++++++++++++++++++++++++++++++++<br />4 fi=
les changed, 123 insertions(+)<br /><br />-- <br />2.25.1</blockquote>
</div>

--HIecwJVXXvBavzRud725--

