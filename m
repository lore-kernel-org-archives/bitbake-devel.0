Return-Path: <peter.kjellerstedt@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id C9C8A780F3
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Jun 2017 14:47:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id 3B41B2E5FC;
	Wed,  7 Jun 2017 16:47:34 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id I62o5JLR3Qyy; Wed,  7 Jun 2017 16:47:33 +0200 (CEST)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
	by bes.se.axis.com (Postfix) with ESMTPS id 5E0382E5D2;
	Wed,  7 Jun 2017 16:47:33 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44A341A099;
	Wed,  7 Jun 2017 16:47:33 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39A7B1A08C;
	Wed,  7 Jun 2017 16:47:33 +0200 (CEST)
Received: from seth.se.axis.com (unknown [10.0.2.172])
	by boulder02.se.axis.com (Postfix) with ESMTP;
	Wed,  7 Jun 2017 16:47:33 +0200 (CEST)
Received: from XBOX03.axis.com (xbox03.axis.com [10.0.5.17])
	by seth.se.axis.com (Postfix) with ESMTP id 2D5832A9C;
	Wed,  7 Jun 2017 16:47:33 +0200 (CEST)
Received: from xbox12.axis.com (10.0.5.26) by XBOX03.axis.com (10.0.5.17) with
	Microsoft SMTP Server (TLS) id 15.0.1210.3;
	Wed, 7 Jun 2017 16:47:33 +0200
Received: from XBOX02.axis.com (10.0.5.16) by xbox12.axis.com (10.0.5.26) with
	Microsoft SMTP Server (TLS) id 15.0.1210.3;
	Wed, 7 Jun 2017 16:47:32 +0200
Received: from XBOX02.axis.com ([fe80::d00f:cb52:1b56:20d]) by XBOX02.axis.com
	([fe80::d00f:cb52:1b56:20d%21]) with mapi id 15.00.1210.000;
	Wed, 7 Jun 2017 16:47:32 +0200
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Patrick Ohly <patrick.ohly@intel.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 1/2] ConfHandler.py: allow inherit or
	include without parameter
Thread-Index: AQHS35Xnk4S3toSMDUKjpClAljf9naIZeddg
Date: Wed, 7 Jun 2017 14:47:32 +0000
Message-ID: <4c164d2f9d254f8cbb09e54fe6d9424e@XBOX02.axis.com>
References: <cover.36a6c17ae3fab020393e82b397fb5a16681be9d7.1496843701.git-series.patrick.ohly@intel.com>
	<c05bcbe8dd83f969f56e7ef93a2ea545fab4cf2c.1496843701.git-series.patrick.ohly@intel.com>
In-Reply-To: <c05bcbe8dd83f969f56e7ef93a2ea545fab4cf2c.1496843701.git-series.patrick.ohly@intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
X-TM-AS-GCONF: 00
Subject: Re: [PATCH 1/2] ConfHandler.py: allow inherit or	include without parameter
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
X-List-Received-Date: Wed, 07 Jun 2017 14:47:36 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
> devel-bounces@lists.openembedded.org] On Behalf Of Patrick Ohly
> Sent: den 7 juni 2017 15:56
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH 1/2] ConfHandler.py: allow inherit or
> include without parameter

Change "inherit or include" to "include or require".

> Writing .bbappends that only have an effect when some configuration
> variable like DISTRO_FEATURES is changed becomes easier when allowing
> "inherit" or "require" without a parameter. The same was already

Change "inherit" to "include".

> allowed for "inherit".
>=20
> Then one can write in a .bbappend:
>=20
>   require ${@bb.utils.contains('DISTRO_FEATURES', 'foo', 'bar.inc', '', d=
)}
>=20
> Signed-off-by: Patrick Ohly <patrick.ohly@intel.com>
> ---
>  lib/bb/parse/parse_py/ConfHandler.py | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py=
/ConfHandler.py
> index bf7e985..b006d06 100644
> --- a/lib/bb/parse/parse_py/ConfHandler.py
> +++ b/lib/bb/parse/parse_py/ConfHandler.py
> @@ -81,6 +81,10 @@ def include(parentfn, fn, lineno, data, error_out):
>      fn =3D data.expand(fn)
>      parentfn =3D data.expand(parentfn)
>=20
> +    if not fn:
> +        # "include" or "require" without parameter is fine, just return.
> +        return
> +
>      if not os.path.isabs(fn):
>          dname =3D os.path.dirname(parentfn)
>          bbpath =3D "%s:%s" % (dname, data.getVar("BBPATH"))
> --
> git-series 0.9.1

//Peter


