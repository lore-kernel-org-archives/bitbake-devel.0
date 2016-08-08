Return-Path: <anibal.limon@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 741FA771C7
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Aug 2016 16:50:09 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga101.fm.intel.com with ESMTP; 08 Aug 2016 09:50:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,490,1464678000"; 
	d="asc'?scan'208";a="1031860450"
Received: from alimonb-mobl1.zpn.intel.com (HELO [10.219.5.36]) ([10.219.5.36])
	by orsmga002.jf.intel.com with ESMTP; 08 Aug 2016 09:50:11 -0700
To: Francisco Pedraza <francisco.j.pedraza.gonzalez@intel.com>,
	bitbake-devel@lists.openembedded.org
References: <1470347547-5037-1-git-send-email-francisco.j.pedraza.gonzalez@intel.com>
From: =?UTF-8?B?QW7DrWJhbCBMaW3Ds24=?= <anibal.limon@linux.intel.com>
Message-ID: <57A8B845.5020702@linux.intel.com>
Date: Mon, 8 Aug 2016 11:50:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <1470347547-5037-1-git-send-email-francisco.j.pedraza.gonzalez@intel.com>
Subject: Re: [PATCH] bb/utils.py: export_proxies add GIT_PROXY_COMMAND
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
X-List-Received-Date: Mon, 08 Aug 2016 16:50:09 -0000
X-Groupsio-MsgNum: 7820
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="f84OvRaJoVNRSXA05TTSDxtoxBAun8lUe"

--f84OvRaJoVNRSXA05TTSDxtoxBAun8lUe
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 08/04/2016 04:52 PM, Francisco Pedraza wrote:
> This was added to enable the usage of git through proxies.
>=20
> Signed-off-by: Francisco Pedraza <francisco.j.pedraza.gonzalez@intel.co=
m>
Acked-by: An=EDbal Lim=F3n <anibal.limon@linux.intel.com>
> ---
>  lib/bb/utils.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/bb/utils.py b/lib/bb/utils.py
> index ce52960..a855d58 100644
> --- a/lib/bb/utils.py
> +++ b/lib/bb/utils.py
> @@ -1461,7 +1461,8 @@ def export_proxies(d):
>      import os
> =20
>      variables =3D ['http_proxy', 'HTTP_PROXY', 'https_proxy', 'HTTPS_P=
ROXY',
> -                    'ftp_proxy', 'FTP_PROXY', 'no_proxy', 'NO_PROXY']
> +                    'ftp_proxy', 'FTP_PROXY', 'no_proxy', 'NO_PROXY',
> +                    'GIT_PROXY_COMMAND']
>      exported =3D False
> =20
>      for v in variables:
>=20


--f84OvRaJoVNRSXA05TTSDxtoxBAun8lUe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJXqLhHAAoJEGJqcE9h3glgiGkP/iE0fVlvfpje0tsZH6L2eCY9
35+AnZyraWI2GUoqkkosmqmQcCR9RwUV1GVUqUMqRVUh02cA4ZAmiKtvA9yVa5Qp
my7koHGIZXVwJqrnN9AmjuSAWkKIozN+L7BbjXPDaPaYbfGMN6caOVdV2i5SHVbU
NFRLYt2RRDLCcfARX8HzqCMyQb2bgmX6H6o0UQwRy1d6x5idvfHG6Lyg/Psleal7
LzkPrHOB+PeQtgWCL61IZ3JPElY+RC4uesXzy87Hna5B4yY8HNheD6cudymBzWyA
NTqmPJFzYik4+cs9UiTZzGNop7FCQO2V8hr2jcZqR6khjzhdfB6CIHbeYYPM9Ltr
Aqfc1ZShxiZyWHF9exlTB8r3Ya5Bf6nyZeysiPeV6hPTuLJLrwcEoVFYh2C7QyPf
QwfkAdknk4NyX08e0oRefPvXsL+DCP2sQL28ys9AgQobKTfLBy6Mq+DVtPkFgk2X
UuF0qPE+HULV+tZfEsQmeGSO8VKNg//oI9M7YgcRH72VaPeMZVPbfl4yT/iQCbuq
yWLeQbB+K3xtqibapqojCyzgMMAe8o+mkrt6FW5xVBD//e+PURVrkUFGOfvvyQeH
Its4maPXvDynCZ6cBNrUdREHa+e6JGuuzBQRsB3DiuYvIV6eFrHhjDmpOy5BRjtO
t5l25jyv6UMdgJVenIc5
=n4ot
-----END PGP SIGNATURE-----

--f84OvRaJoVNRSXA05TTSDxtoxBAun8lUe--
