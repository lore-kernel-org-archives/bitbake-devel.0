Return-Path: <o.mandel@menlosystems.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by mail.openembedded.org (Postfix) with ESMTP id 5EEE978357
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Aug 2017 16:10:10 +0000 (UTC)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3xj9Sy73s5z1qw7C;
	Wed, 30 Aug 2017 18:10:10 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
	by mail.m-online.net (Postfix) with ESMTP id 3xj9Sy6F8Cz3hhTP;
	Wed, 30 Aug 2017 18:10:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new,
	port 10024)
	with ESMTP id QpLEXPAqzO5J; Wed, 30 Aug 2017 18:10:08 +0200 (CEST)
X-Auth-Info: MjxVkuTTmiUOZYhta+V06kZWXi3Tuzuxn+xFZ7MZ+3sXAa3GhVFVL6YCtoKzAc0X
Received: from [10.0.0.72] (host-141-40-253-38.customer.izb-online.de
	[141.40.253.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Wed, 30 Aug 2017 18:10:08 +0200 (CEST)
To: "Reyna, David" <david.reyna@windriver.com>, toaster@yoctoproject.org
References: <adcc19b8-8834-cfe9-cb26-9a463ce42f43@menlosystems.com>
	<5E53D14CE4667A45B9A06760DE5D13D0CF7815B7@ALA-MBC.corp.ad.wrs.com>
From: Olaf Mandel <o.mandel@menlosystems.com>
Message-ID: <9637f775-87c7-7986-51f3-6aa1ab870eb2@menlosystems.com>
Date: Wed, 30 Aug 2017 18:08:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
	Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <5E53D14CE4667A45B9A06760DE5D13D0CF7815B7@ALA-MBC.corp.ad.wrs.com>
X-Mailman-Approved-At: Fri, 01 Sep 2017 15:25:32 +0000
Subject: Re: Question on toaster bringup
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
X-List-Received-Date: Wed, 30 Aug 2017 16:10:11 -0000
X-Groupsio-MsgNum: 8937
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MrGmPdsgsoWcI6J83VK50gKQrJOgNAghG"

--MrGmPdsgsoWcI6J83VK50gKQrJOgNAghG
Content-Type: multipart/mixed; boundary="wknK6j0BOlV6MdqLeqfwLRIWH26G6suxu";
 protected-headers="v1"
From: Olaf Mandel <o.mandel@menlosystems.com>
To: "Reyna, David" <david.reyna@windriver.com>, toaster@yoctoproject.org
Message-ID: <9637f775-87c7-7986-51f3-6aa1ab870eb2@menlosystems.com>
Subject: Re: [bitbake-devel] Question on toaster bringup
References: <adcc19b8-8834-cfe9-cb26-9a463ce42f43@menlosystems.com>
 <5E53D14CE4667A45B9A06760DE5D13D0CF7815B7@ALA-MBC.corp.ad.wrs.com>
In-Reply-To: <5E53D14CE4667A45B9A06760DE5D13D0CF7815B7@ALA-MBC.corp.ad.wrs.com>

--wknK6j0BOlV6MdqLeqfwLRIWH26G6suxu
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hi,

Am 30.08.2017 um 16:51 schrieb Reyna, David:
> [Am 30.08.2017 um 14:38 schrieb Olaf Mandel:]
>> I want to initialize toaster from fixtures alone, if possible. It shou=
ld
>> only provide a "local" release (no network dependency at all). Here I
>> ran into two to three problems:
>>=20
> Thank you for using Toaster! There is a Toaster team [...]

I obviously posted to the wrong forum, sorry: this should be the last
email there.

> [...] and we have a meeting each week, for which I am the lead and the =
Toaster maintainer. I will forward you the link (it is in about 10 minute=
s :-)

Thanks, but I missed it. Probably would not have had much to contribute,
anyway.

>> * the oe-core.xml fixture adds three releases. Is it possible to
>> remove/delete objects in the custom.xml fixture that I do not want?
>> Currently I am working around that by just configuring out the line
>> call_command("loaddata", "oe-core") in checksettings.py.
>>=20
> 1) See 11957 for a resolution for your question. The fixtures are stric=
tly additive, so 11957 provides the way to disable the default fixtures.

Thank you. Just for anyone else who got as confused as me: the commit-id
got rewritten from 254e2debe5705f4fe34307378a8c1457e4327d1c to
ac29d4a9078494544a2627d8b6b021096b49cb34 (at the moment).

One question for that: where does ToasterSetting get an object with
name=3D=3D'CUSTOM_XML_ONLY' from? Does this require editing the settings.=
xml
file?

>> * the custom.xml fixture needs to reside in the
>> bitbake/lib/toaster/orm/fixtures directory to be found. How can I sear=
ch
>> at other places? Setting an environment variable FIXTURE_DIRS didn't
>> seem to help.
>>=20
> 2) Yes, create and enhancement request and we can address that. It is t=
oo late for enhancements for YP-2.4 but we can look at that for 2.5.
>=20
Request number is #12007. Thank you for considering it.

>> * minor point: would it make sense to detect if
>> call_command("lsupdates") is needed? One does not need that for a pure=
ly
>> local release and I have it commented out.
>>=20
> 3) Ideally you would provide your own Layer Index server so that you ca=
n get the full power of the interface. We can certainly look at alternati=
ves for your reduced use case.
>=20
I guess I could. But even without it, I can still build. The only
inconveniences I see are:

* machine is not selectable / detectable
* recipes / images are only known after they were build once
* because of above, need to put the image recipes into the custom.xml
fixture to allow building them
* links to recipe files are dead

I can live with all of the above, so I will probably not set up a local
layer index.

Thank you,
Olaf
--=20
Olaf Mandel
phone: +49-89-189166-185
fax:   +49-89-189166-111
Menlo Systems GmbH
Am Klopferspitz 19a, D-82152 Martinsried
Amtsgericht M=C3=BCnchen HRB 138145
Gesch=C3=A4ftsf=C3=BChrung: Dr Michael Mei, Dr Ronald Holzwarth
USt-IdNr. DE217772017, St.-Nr. 14316170324


--wknK6j0BOlV6MdqLeqfwLRIWH26G6suxu--

--MrGmPdsgsoWcI6J83VK50gKQrJOgNAghG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJZpuMdAAoJEFS9nbRiUh3/aZAIAK+N29UVX//NnNttOdIoNvHk
u22i6yS13Z1OBh0+cXJiyXUrFN2KWNbUwl0ZZhuu05q27ADN+kW9x43pVlemU+Q+
fy//PlSPyOf4RD0BCv9+5E0Hdqmg/FYtz3NIDVXhOHIzvLyPPvYVzw8zqLYWKWZE
T0ZkaVQtrQuJd0OTOdQcLUqQDWQBA7YS9rxoUz8nv5mxqU6d/zRxLkug6G1cq2Su
thVCcYdYCvy5Z0mEcq9J2fGyY47RWnWUQO7jEickjIBZwI1ZGyzsxbizgTuYyhbS
9JxW9ktUU29lGKNZsasqUorrl7kqrkzy2SVQgZMbH16XFpbutt6JwVtYd0XInRY=
=p8oA
-----END PGP SIGNATURE-----

--MrGmPdsgsoWcI6J83VK50gKQrJOgNAghG--
