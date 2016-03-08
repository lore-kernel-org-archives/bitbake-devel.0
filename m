Return-Path: <peter.kjellerstedt@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 565916AC4B
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Mar 2016 23:59:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id F12C6180FD
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Mar 2016 00:59:45 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id GKeLLQ+3D3xj for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Mar 2016 00:59:45 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bastet.se.axis.com (Postfix) with ESMTP id EAEEE180A3
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Mar 2016 00:59:44 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id CE32D1413
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Mar 2016 00:59:44 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id C2EC513D2
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Mar 2016 00:59:44 +0100 (CET)
Received: from XBOX01.axis.com (xbox01.axis.com [10.0.5.15])
	by seth.se.axis.com (Postfix) with ESMTP id C105A105A
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Mar 2016 00:59:44 +0100 (CET)
Received: from XBOX02.axis.com (10.0.5.16) by XBOX01.axis.com (10.0.5.15) with
	Microsoft SMTP Server (TLS) id 15.0.1156.6;
	Wed, 9 Mar 2016 00:59:45 +0100
Received: from XBOX02.axis.com ([fe80::50c3:4d2f:4507:7776]) by
	XBOX02.axis.com ([fe80::50c3:4d2f:4507:7776%22]) with mapi id
	15.00.1156.000; Wed, 9 Mar 2016 00:59:44 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Peter Kjellerstedt <pkj@axis.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 0/1] Make the fetcher expand checksums
Thread-Index: AQHReZXcZh6wBZA8+kKnRFow2Xudx59QORBQ
Date: Tue, 8 Mar 2016 23:59:44 +0000
Message-ID: <d04c7e23bae946859930d5ca39c4ac5c@XBOX02.axis.com>
References: <cover.1457481171.git.pkj@axis.com>
In-Reply-To: <cover.1457481171.git.pkj@axis.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.55]
MIME-Version: 1.0
Subject: Re: [PATCH 0/1] Make the fetcher expand checksums
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
X-List-Received-Date: Tue, 08 Mar 2016 23:59:46 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
> devel-bounces@lists.openembedded.org] On Behalf Of Peter Kjellerstedt
> Sent: den 9 mars 2016 00:54
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH 0/1] Make the fetcher expand checksums
>=20
> We needed a way to override the checksums for a recipe from a
> configuration file, e.g., local.conf. I first tried the naive:
>=20
>     SRC_URI_pn-myrecipe[md5sum] =3D "123abc..."
>     SRC_URI_pn-myrecipe[sha256sum] =3D "abcd1234..."
>=20
> which of course did not work.

Btw, is there any way to do what I tried to do above, i.e.,=20
override variable flags from a configuration file? That would=20
have been so much nicer than having to modify the recipe as I=20
do below to be able to override the checksums.

> Then I modified the recipe as:
>=20
>     SRC_URI =3D "http://.../${PN}-${PV}.tar.gz"
>=20
>     MD5SUM =3D "123abc..."
>     SHA256SUM =3D "abcd1234..."
>=20
>     SRC_URI[md5sum] =3D "${MD5SUM}"
>     SRC_URI[sha256sum] =3D "${SHA256SUM}"
>=20
> which I had assumed would work, but it did not. Finally I tried:
>=20
>     MD5SUM =3D "123abc..."
>     SHA256SUM =3D "abcd1234..."
>=20
>     SRC_URI =3D "http://.../${PN}-
> ${PV}.tar.gz;md5sum=3D${MD5SUM};sha256sum=3D${SHA256SUM}"
>=20
> which actually did work.
>=20
> Looking into why the second solution above did not work it turned out
> that the fetcher code called d.getVarFlag("SRC_URI", ..., False),
> i.e., without expanding the checksum values. I cannot see any reason
> not to expand the values, so the following patch does that.
>=20
> //Peter
>=20
> The following changes since commit
> 5ac3dc76a5afc2ed35b1abfc8e330e0c580eadf0:
>=20
>   image.bbclass: fix incomplete .rootfs customization (2016-03-07
> 22:10:54 +0000)
>=20
> are available in the git repository at:
>=20
>   git://git.yoctoproject.org/poky-contrib pkj/expand_checksums
>   http://git.yoctoproject.org/cgit.cgi/poky-
> contrib/log/?h=3Dpkj/expand_checksums
>=20
> Peter Kjellerstedt (1):
>   fetch2: Make SRC_URI[md5sum] and SRC_URI[sha256sum] expand their
>     values
>=20
>  bitbake/lib/bb/fetch2/__init__.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> --
> 2.1.0

//Peter


