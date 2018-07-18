Return-Path: <peter.kjellerstedt@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id CE16D78741
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Jul 2018 14:01:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 2E6C418400;
	Wed, 18 Jul 2018 16:01:53 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id hlk20sv9dOUT; Wed, 18 Jul 2018 16:01:52 +0200 (CEST)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
	by bastet.se.axis.com (Postfix) with ESMTPS id 5A4641833E;
	Wed, 18 Jul 2018 16:01:52 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 345DC1A073;
	Wed, 18 Jul 2018 16:01:52 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 282021A06F;
	Wed, 18 Jul 2018 16:01:52 +0200 (CEST)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
	by boulder02.se.axis.com (Postfix) with ESMTP;
	Wed, 18 Jul 2018 16:01:52 +0200 (CEST)
Received: from XBOX03.axis.com (xbox03.axis.com [10.0.5.17])
	by thoth.se.axis.com (Postfix) with ESMTP id 1C11A17D5;
	Wed, 18 Jul 2018 16:01:52 +0200 (CEST)
Received: from xbox12.axis.com (10.0.5.26) by XBOX03.axis.com (10.0.5.17) with
	Microsoft SMTP Server (TLS) id 15.0.1365.1;
	Wed, 18 Jul 2018 16:01:52 +0200
Received: from XBOX02.axis.com (10.0.5.16) by xbox12.axis.com (10.0.5.26) with
	Microsoft SMTP Server (TLS) id 15.0.1365.1;
	Wed, 18 Jul 2018 16:01:51 +0200
Received: from XBOX02.axis.com ([fe80::50c3:4d2f:4507:7776]) by
	XBOX02.axis.com ([fe80::50c3:4d2f:4507:7776%21]) with mapi id
	15.00.1365.000; Wed, 18 Jul 2018 16:01:51 +0200
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Parthiban Nallathambi <pn@denx.de>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH] bitbake: fetch2/npm.py: Allow shrinkwrap
	resolved relative URL which startswith 'http' (e.g http-proxy)
Thread-Index: AQHUHndCYJoCdt4nOk+tzJh6FxdyqaSU/Rag
Date: Wed, 18 Jul 2018 14:01:51 +0000
Message-ID: <eb5d94efdf114065ba04e8aa536256b3@XBOX02.axis.com>
References: <20180718090339.3914-1-pn@denx.de>
In-Reply-To: <20180718090339.3914-1-pn@denx.de>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
X-TM-AS-GCONF: 00
Subject: Re: [PATCH] bitbake: fetch2/npm.py: Allow shrinkwrap	resolved relative URL which startswith 'http' (e.g http-proxy)
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
X-List-Received-Date: Wed, 18 Jul 2018 14:01:53 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
> devel-bounces@lists.openembedded.org] On Behalf Of Parthiban
> Nallathambi
> Sent: den 18 juli 2018 11:04
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH] bitbake: fetch2/npm.py: Allow
> shrinkwrap resolved relative URL which startswith 'http' (e.g http-
> proxy)
>=20
> shrinkwrap resolved relative URL can start with http. For example,
> "resolved: http-proxy/-/http-proxy-${PV}.tgz" is still relative URL
> to npm registry, but starts with http.
>=20
> Current if statement compares the startswith 'resolved' to 'http',
> which makes impossible to use npm download. Condtional comparison
> now strictly checks for "http://" and "https://"
>=20
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> ---
>  bitbake/lib/bb/fetch2/npm.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/bitbake/lib/bb/fetch2/npm.py b/bitbake/lib/bb/fetch2/npm.py
> index ba7fa43a82..5e7fc2f769 100644
> --- a/bitbake/lib/bb/fetch2/npm.py
> +++ b/bitbake/lib/bb/fetch2/npm.py
> @@ -234,7 +234,7 @@ class Npm(FetchMethod):
>                          self._getshrinkeddependencies(obj, data['depende=
ncies'][obj], data['dependencies'][obj]['version'], d, ud, lockdown, manife=
st, False)
>                          return
>          outputurl =3D "invalid"
> -        if ('resolved' not in data) or (not data['resolved'].startswith(=
'http')):
> +        if ('resolved' not in data) or (not data['resolved'].startswith(=
'http://')) or (not data['resolved'].startswith('https://')):

That is wrong (the above will always evaluate to true as long as=20
'resolved' exists in data since both expressions testing the prefix=20
obviously cannot be false at the same time). The correct expression=20
should be:

        if ('resolved' not in data) or (not data['resolved'].startswith('ht=
tp://') and not data['resolved'].startswith('https://')):

>              # will be the case for ${PN}
>              fetchcmd =3D "npm view %s@%s dist.tarball --registry %s" % (=
pkg, version, ud.registry)
>              logger.debug(2, "Found this matching URL: %s" % str(fetchcmd=
))
> --
> 2.14.4

//Peter


