Return-Path: <o.mandel@menlosystems.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by mail.openembedded.org (Postfix) with ESMTP id 1074A71976
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Oct 2016 16:47:56 +0000 (UTC)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3t4Xg64fy6z3hjHM
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Oct 2016 18:40:02 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3t4Xg646vxzvlDX
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Oct 2016 18:40:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new,
	port 10024)
	with ESMTP id AMzSeDwhsx1t for <bitbake-devel@lists.openembedded.org>; 
	Thu, 27 Oct 2016 18:40:01 +0200 (CEST)
X-Auth-Info: V5HibCIUyS5Bkq5sHAPrn8bEFv6Dql7ZxaJofEhAXUkSn03VMME1zDLvd8L3Lrel
Received: from [10.0.0.72] (host-141-40-253-38.customer.izb-online.de
	[141.40.253.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Oct 2016 18:40:01 +0200 (CEST)
To: bitbake-devel@lists.openembedded.org
References: <1477586079-29340-1-git-send-email-o.mandel@menlosystems.com>
From: Olaf Mandel <o.mandel@menlosystems.com>
Organization: Menlo Systems
Message-ID: <69506fef-76f1-d985-6a2d-5beab03a2dac@menlosystems.com>
Date: Thu, 27 Oct 2016 18:39:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
	Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1477586079-29340-1-git-send-email-o.mandel@menlosystems.com>
Subject: Re: [PATCH] toaster: fix if USER_CLASSES is missing buildstats
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
X-List-Received-Date: Thu, 27 Oct 2016 16:47:57 -0000
X-Groupsio-MsgNum: 8145
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MaF9KhSqm9kwm5shIbdQFqmg6sXAiBFBH"

--MaF9KhSqm9kwm5shIbdQFqmg6sXAiBFBH
Content-Type: multipart/mixed; boundary="qWE9rneaSwvBgN1KpxHJHobT56i7QbadD";
 protected-headers="v1"
From: Olaf Mandel <o.mandel@menlosystems.com>
To: bitbake-devel@lists.openembedded.org
Message-ID: <69506fef-76f1-d985-6a2d-5beab03a2dac@menlosystems.com>
Subject: Re: [PATCH] toaster: fix if USER_CLASSES is missing buildstats
References: <1477586079-29340-1-git-send-email-o.mandel@menlosystems.com>
In-Reply-To: <1477586079-29340-1-git-send-email-o.mandel@menlosystems.com>

--qWE9rneaSwvBgN1KpxHJHobT56i7QbadD
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

Sorry about the original email: I accidentally sent it to the wrong
mailing list... Please ignore it here.


--qWE9rneaSwvBgN1KpxHJHobT56i7QbadD--

--MaF9KhSqm9kwm5shIbdQFqmg6sXAiBFBH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYEi3VAAoJEFS9nbRiUh3/p8oIAJxmj+sU0ntXFSZ7Hs9ypd5L
BCRYXzMctKr+nKW9+Db/LzWHq8ZUGaMm93+v8zTBIR9/YQ86v5nDroePW6NQZHpf
9aBUrYUyLrJUjDzglZZX1bG81AUDTk8UnAteo0iKIcXHNxN4bJTUvIHMo0RcTKKa
3k23hpKuwOy95YyxRAfdUPHPRG12X/AJnFOBvRmTnLHbecI6SRKqiq7t78ZIWO02
koKKDej1UgE6QvfqX+SgmmzRB8qx48kXczoUUjEF6uY5o8hyqoJebL+KmM57ZlAS
RhmaaRGKWrtw5oC0tx7biQ3CYctHkgdni32boyGBZgBgM5vNYA6OZ6I2pTGvH4k=
=cxEq
-----END PGP SIGNATURE-----

--MaF9KhSqm9kwm5shIbdQFqmg6sXAiBFBH--
