Return-Path: <peter.kjellerstedt@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id D514D78191
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Jun 2017 14:52:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 733DA184D8;
	Wed,  7 Jun 2017 16:52:32 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id 1a9rftlfvw3d; Wed,  7 Jun 2017 16:52:30 +0200 (CEST)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
	by bastet.se.axis.com (Postfix) with ESMTPS id 35D8F184CA;
	Wed,  7 Jun 2017 16:52:30 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 239161E0DE;
	Wed,  7 Jun 2017 16:52:30 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18A591E0CE;
	Wed,  7 Jun 2017 16:52:30 +0200 (CEST)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
	by boulder03.se.axis.com (Postfix) with ESMTP;
	Wed,  7 Jun 2017 16:52:30 +0200 (CEST)
Received: from XBOX01.axis.com (xbox01.axis.com [10.0.5.15])
	by thoth.se.axis.com (Postfix) with ESMTP id 0C8E22A79;
	Wed,  7 Jun 2017 16:52:30 +0200 (CEST)
Received: from xbox12.axis.com (10.0.5.26) by XBOX01.axis.com (10.0.5.15) with
	Microsoft SMTP Server (TLS) id 15.0.1210.3;
	Wed, 7 Jun 2017 16:52:30 +0200
Received: from XBOX02.axis.com (10.0.5.16) by xbox12.axis.com (10.0.5.26) with
	Microsoft SMTP Server (TLS) id 15.0.1210.3;
	Wed, 7 Jun 2017 16:52:29 +0200
Received: from XBOX02.axis.com ([fe80::d00f:cb52:1b56:20d]) by XBOX02.axis.com
	([fe80::d00f:cb52:1b56:20d%21]) with mapi id 15.00.1210.000;
	Wed, 7 Jun 2017 16:52:29 +0200
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Patrick Ohly <patrick.ohly@intel.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 2/2] ConfHandler.py: allow inherit or
	include with multiple parameters
Thread-Index: AQHS35XoaF6nRP3Rw0S7Nc/Q4/fRe6IZevyw
Date: Wed, 7 Jun 2017 14:52:29 +0000
Message-ID: <18c07ada4cc24614acbd1c6c72b2540d@XBOX02.axis.com>
References: <cover.36a6c17ae3fab020393e82b397fb5a16681be9d7.1496843701.git-series.patrick.ohly@intel.com>
	<bde65477ce3b1070afeb82ee70eee2e8b006614d.1496843701.git-series.patrick.ohly@intel.com>
In-Reply-To: <bde65477ce3b1070afeb82ee70eee2e8b006614d.1496843701.git-series.patrick.ohly@intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
X-TM-AS-GCONF: 00
Subject: Re: [PATCH 2/2] ConfHandler.py: allow inherit or	include with multiple parameters
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
X-List-Received-Date: Wed, 07 Jun 2017 14:52:32 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
> devel-bounces@lists.openembedded.org] On Behalf Of Patrick Ohly
> Sent: den 7 juni 2017 15:56
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH 2/2] ConfHandler.py: allow inherit or
> include with multiple parameters

Change "inherit or include" to "include or require".

> "inherit" already allows inheriting more than one class in a single
> statement. The same also makes sense for "include" and "require",
> because then one can generate a list of files to be included
> dynamically also for the case that more than one file needs to be
> included.
>=20
> For example, with a new utility method, include files could be
> included depending on the current distro features like this:
>=20
>    require ${@ oe.utils.optional_includes(d, \
>                "foo,bar:foo-or-bar.inc xyz:x.inc,y.inc,z.inc", \
>                "DISTRO_FEATURES")}
>=20
> Signed-off-by: Patrick Ohly <patrick.ohly@intel.com>
> ---
>  lib/bb/parse/parse_py/ConfHandler.py | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>=20
> diff --git a/lib/bb/parse/parse_py/ConfHandler.py
> b/lib/bb/parse/parse_py/ConfHandler.py
> index b006d06..97aa130 100644
> --- a/lib/bb/parse/parse_py/ConfHandler.py
> +++ b/lib/bb/parse/parse_py/ConfHandler.py
> @@ -69,21 +69,25 @@ def init(data):
>  def supports(fn, d):
>      return fn[-5:] =3D=3D ".conf"
>=20
> -def include(parentfn, fn, lineno, data, error_out):
> +def include(parentfn, fns, lineno, data, error_out):
>      """
>      error_out: A string indicating the verb (e.g. "include", "inherit") =
to be
>      used in a ParseError that will be raised if the file to be included =
could
>      not be included. Specify False to avoid raising an error in this cas=
e.
>      """
> -    if parentfn =3D=3D fn: # prevent infinite recursion
> -        return None
> -
> -    fn =3D data.expand(fn)
> +    fns =3D data.expand(fns)
>      parentfn =3D data.expand(parentfn)
>=20
> -    if not fn:
> -        # "include" or "require" without parameter is fine, just return.
> -        return
> +    # "include" or "require" accept zero to n space-separated file names=
 to include.
> +    for fn in fns.split():
> +        include_single_file(parentfn, fn, lineno, data, error_out)
> +
> +def include_single_file(parentfn, fn, lineno, data, error_out):
> +    """
> +    Helper function for include() which does not expand or split its par=
ameters.
> +    """
> +    if parentfn =3D=3D fn: # prevent infinite recursion
> +        return None
>=20
>      if not os.path.isabs(fn):
>          dname =3D os.path.dirname(parentfn)
> --
> git-series 0.9.1

//Peter


