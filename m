Return-Path: <peter.kjellerstedt@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id 49D2770034
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 May 2016 09:57:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id B1FE72E1F4;
	Wed, 25 May 2016 11:57:03 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id 9acGnazPXMR5; Wed, 25 May 2016 11:57:02 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bes.se.axis.com (Postfix) with ESMTP id D9E492E1EE;
	Wed, 25 May 2016 11:57:02 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id C3BC419F7;
	Wed, 25 May 2016 11:57:02 +0200 (CEST)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id B8E931AF5;
	Wed, 25 May 2016 11:57:02 +0200 (CEST)
Received: from XBOX01.axis.com (xbox01.axis.com [10.0.5.15])
	by seth.se.axis.com (Postfix) with ESMTP id B6D8EFA1;
	Wed, 25 May 2016 11:57:02 +0200 (CEST)
Received: from XBOX02.axis.com (10.0.5.16) by XBOX01.axis.com (10.0.5.15) with
	Microsoft SMTP Server (TLS) id 15.0.1156.6;
	Wed, 25 May 2016 11:57:02 +0200
Received: from XBOX02.axis.com ([fe80::d00f:cb52:1b56:20d]) by XBOX02.axis.com
	([fe80::d00f:cb52:1b56:20d%21]) with mapi id 15.00.1156.000;
	Wed, 25 May 2016 11:57:02 +0200
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Markus Lehtonen <markus.lehtonen@linux.intel.com>
Thread-Topic: [bitbake-devel] [PATCH] cookerdata: print an error if layer dir
	does not exist
Thread-Index: AQHRtY19zyP32fLj+kKfQ8j/2DTjgJ/Ja+5g
Date: Wed, 25 May 2016 09:57:02 +0000
Message-ID: <36332ede5fc34548b940ea5914723139@XBOX02.axis.com>
References: <1464074730-23187-1-git-send-email-markus.lehtonen@linux.intel.com>
In-Reply-To: <1464074730-23187-1-git-send-email-markus.lehtonen@linux.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.55]
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] cookerdata: print an error if layer dir	does not exist
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
X-List-Received-Date: Wed, 25 May 2016 09:57:06 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
> devel-bounces@lists.openembedded.org] On Behalf Of Markus Lehtonen
> Sent: den 24 maj 2016 09:26
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH] cookerdata: print an error if layer
> dir does not exist
>=20
> Makes it easier for user to identify problems, e.g. typos, in BBLAYERS.
>=20
> [YOCTO #9507]
>=20
> Signed-off-by: Markus Lehtonen <markus.lehtonen@linux.intel.com>
> ---
>  lib/bb/cookerdata.py | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
> index 1615db5..7dfe7b5 100644
> --- a/lib/bb/cookerdata.py
> +++ b/lib/bb/cookerdata.py
> @@ -292,6 +292,10 @@ class CookerDataBuilder(object):
>              data =3D bb.data.createCopy(data)
>              approved =3D bb.utils.approved_variables()
>              for layer in layers:
> +                if not os.path.isdir(layer):
> +                    parselog.critical("Layer directory '%s' does not to =
exist! "
                                                                        ^^
Change "not to exist" to "not exist".

> +                                      "Please check BBLAYERS in %s" % (l=
ayer, layerconf))
> +                    sys.exit(1)
>                  parselog.debug(2, "Adding layer %s", layer)
>                  if 'HOME' in approved and '~' in layer:
>                      layer =3D os.path.expanduser(layer)
> --
> 2.6.6

//Peter


