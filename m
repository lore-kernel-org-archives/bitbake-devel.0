Return-Path: <peter.kjellerstedt@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id 61AE673189
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 16 Aug 2016 21:16:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id 739CC2E270;
	Tue, 16 Aug 2016 23:16:19 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id PWKllFgNldbC; Tue, 16 Aug 2016 23:16:18 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bes.se.axis.com (Postfix) with ESMTP id 8002B2E0D2;
	Tue, 16 Aug 2016 23:16:18 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 15B9F19E5;
	Tue, 16 Aug 2016 23:16:18 +0200 (CEST)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id 0AC8E17E0;
	Tue, 16 Aug 2016 23:16:18 +0200 (CEST)
Received: from XBOX02.axis.com (xbox02.axis.com [10.0.5.16])
	by thoth.se.axis.com (Postfix) with ESMTP id 091F72CE;
	Tue, 16 Aug 2016 23:16:18 +0200 (CEST)
Received: from XBOX02.axis.com (10.0.5.16) by XBOX02.axis.com (10.0.5.16) with
	Microsoft SMTP Server (TLS) id 15.0.1156.6;
	Tue, 16 Aug 2016 23:16:17 +0200
Received: from XBOX02.axis.com ([fe80::d00f:cb52:1b56:20d]) by XBOX02.axis.com
	([fe80::d00f:cb52:1b56:20d%21]) with mapi id 15.00.1156.000;
	Tue, 16 Aug 2016 23:16:17 +0200
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 4/4] siggen: properly close files rather
	than opening them inline
Thread-Index: AQHR84HZkXN3I+iLFk2cqIrpthigYKBMHzHQ
Date: Tue, 16 Aug 2016 21:16:17 +0000
Message-ID: <9d8bf4573bf44f78975f7bc8241f13ba@XBOX02.axis.com>
References: <cover.1470886482.git.paul.eggleton@linux.intel.com>
	<3c460ccdf61654f7d74713e10c305476c5db1aee.1470886482.git.paul.eggleton@linux.intel.com>
In-Reply-To: <3c460ccdf61654f7d74713e10c305476c5db1aee.1470886482.git.paul.eggleton@linux.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
Subject: Re: [PATCH 4/4] siggen: properly close files rather	than opening them inline
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
X-List-Received-Date: Tue, 16 Aug 2016 21:16:20 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
> devel-bounces@lists.openembedded.org] On Behalf Of Paul Eggleton
> Sent: den 11 augusti 2016 05:37
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH 4/4] siggen: properly close files
> rather than opening them inline
>=20
> If you don't do this, with Python 3 you get a warning on exit under some
> circumstances.
>=20
> Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
> ---
>  lib/bb/siggen.py | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>=20
> diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
> index 5d8a253..9b2f658 100644
> --- a/lib/bb/siggen.py
> +++ b/lib/bb/siggen.py
> @@ -363,10 +363,12 @@ def clean_basepaths_list(a):
>  def compare_sigfiles(a, b, recursecb =3D None):
>      output =3D []
>=20
> -    p1 =3D pickle.Unpickler(open(a, "rb"))
> -    a_data =3D p1.load()
> -    p2 =3D pickle.Unpickler(open(b, "rb"))
> -    b_data =3D p2.load()
> +    with open(a, 'rb') as f:
> +        p1 =3D pickle.Unpickler(ff)
                                 ^^
Shouldn't that be:

        p1 =3D pickle.Unpickler(f)

> +        a_data =3D p1.load()
> +    with open(b, 'rb') as f:
> +        p2 =3D pickle.Unpickler(f)
> +        b_data =3D p2.load()
>=20
>      def dict_diff(a, b, whitelist=3Dset()):
>          sa =3D set(a.keys())
> @@ -563,8 +565,9 @@ def calc_taskhash(sigdata):
>  def dump_sigfile(a):
>      output =3D []
>=20
> -    p1 =3D pickle.Unpickler(open(a, "rb"))
> -    a_data =3D p1.load()
> +    with open(a, 'rb') as f:
> +        p1 =3D pickle.Unpickler(f)
> +        a_data =3D p1.load()
>=20
>      output.append("basewhitelist: %s" % (a_data['basewhitelist']))
>=20
> --
> 2.5.5

//Peter


