Return-Path: <raj.khem@gmail.com>
Received: from mail-pf0-f180.google.com (mail-pf0-f180.google.com
	[209.85.192.180])
	by mail.openembedded.org (Postfix) with ESMTP id F0AA56FFA6
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Dec 2015 23:32:50 +0000 (UTC)
Received: by pfu207 with SMTP id 207so37471119pfu.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Dec 2015 15:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=subject:mime-version:content-type:from:in-reply-to:date:cc
	:message-id:references:to;
	bh=rLkqQrEQYwnYkrxWU27YKO9YRD35QQyc1hld+jHLSWQ=;
	b=bJ6Plitd0AwxsGljkLXNpKYwwxKG7BsGSCIJV7+PCySE5CaeqeCsNrcALKmv0FfxX+
	WiEBDlOVuKu9Ke0D66L59O70K1a9diZDX2K2/i2mDqA+roLwaLcX2BIW/1cM7W/W62Wy
	Qiw//u73jI0tfS/noiRXGAEhlKJgnfg5eU49DAwy/cC9kEivI6SVqpcH1Ke7A/QWPBgE
	zCNx1ev0mix01cG8N7yGeN90CKkR/UMZ0mwB3+o95Duih+h3eNAbffGfoh9E3Ub3SD8S
	xtiyFAAcsAwbzgFrme9uhFvWlh7MEfhzp8b59V6cY3PoLc9qRqV57xUqLEvhemn8JFkf
	66HA==
X-Received: by 10.98.19.12 with SMTP id b12mr2308748pfj.78.1449703970568;
	Wed, 09 Dec 2015 15:32:50 -0800 (PST)
Received: from ?IPv6:2601:646:8802:5d5c:24a3:d421:cfe2:88b3?
	([2601:646:8802:5d5c:24a3:d421:cfe2:88b3])
	by smtp.gmail.com with ESMTPSA id 1sm14014256pfc.3.2015.12.09.15.32.48
	(version=TLSv1/SSLv3 cipher=OTHER);
	Wed, 09 Dec 2015 15:32:49 -0800 (PST)
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
X-Pgp-Agent: GPGMail 2.6b2
From: Khem Raj <raj.khem@gmail.com>
In-Reply-To: <CAP71WjwVKYvTqChH++LygHnRkshDWbTUpnRpuptcoRxBpFw9HQ@mail.gmail.com>
Date: Wed, 9 Dec 2015 15:32:44 -0800
Message-Id: <39C63A78-9861-4FFE-A6F7-0A7183312908@gmail.com>
References: <CAJ86T=U_qRVDbJZbCOT5XCwRP=Scs0g1+EYeg+HhjLZ-J7zwhw@mail.gmail.com>
	<CAP71WjwVKYvTqChH++LygHnRkshDWbTUpnRpuptcoRxBpFw9HQ@mail.gmail.com>
To: Nicolas Dechesne <nicolas.dechesne@linaro.org>
X-Mailer: Apple Mail (2.3112)
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: PREFERRED_VERSION with % wildcard picking unexpected version
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
X-List-Received-Date: Wed, 09 Dec 2015 23:32:53 -0000
X-Groupsio-MsgNum: 6724
Content-Type: multipart/signed;
	boundary="Apple-Mail=_5A747A4F-F57E-4B46-965A-076159B0AAB5";
	protocol="application/pgp-signature"; micalg=pgp-sha1

--Apple-Mail=_5A747A4F-F57E-4B46-965A-076159B0AAB5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On Dec 9, 2015, at 3:27 PM, Nicolas Dechesne =
<nicolas.dechesne@linaro.org> wrote:
>=20
> On Tue, Dec 1, 2015 at 6:13 AM, Andre McCurdy <armccurdy@gmail.com> =
wrote:
>> I have two recipes within a single layer:
>>=20
>>  stblinux_3.14-1.7.bb
>>  stblinux_3.14-1.8.bb
>>=20
>> If PREFERRED_VERSION_stblinux is set to "3.14%", then I would expect
>> the version 3.14-1.8 recipe to be selected, however 3.14-1.7 gets
>> selected instead.
>>=20
>> Reversing the order of files stored in pkg_pn[pn] seems to help. Is =
it
>> a reasonable solution?
>=20
>=20
> I have a somewhat similar issue..
>=20
> in oe-core we have GCCVERSION set to 5.%, if I add meta-linaro layer
> which has gcc_5.1.bb (while OE has gcc_5.2.bb), I am seeing this:
>=20
> $ bitbake -e gcc | grep ^PV
> PV=3D"5.1.0"
>=20
> While I would expect 5.2.0 to be picked up.
>=20
> This patch does not fix this issue, btw.
>=20
> If I remove gcc_5.1.bb from my layers, then I can see:
>=20
> $ bitbake -e gcc | grep ^PV
> PV=3D=E2=80=9C5.2.0"

whats the order of your layer in bitbake search path. Secondly whats the =
LAYER_PRIORITY
if they are higher than oe-core then it will always choose the provider =
from the higher order layer
versions don=E2=80=99t matter.

> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel


--Apple-Mail=_5A747A4F-F57E-4B46-965A-076159B0AAB5
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iEYEARECAAYFAlZouiAACgkQuwUzVZGdMxSjLQCgkzCuHbt77mMzNBPUnWzevGXp
hgMAnRnBeSt8kS/gddLD5mOLqxSmoEem
=yKkJ
-----END PGP SIGNATURE-----

--Apple-Mail=_5A747A4F-F57E-4B46-965A-076159B0AAB5--
