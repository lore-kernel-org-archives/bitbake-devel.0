Return-Path: <peter.kjellerstedt@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 1AB0B785AD
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Dec 2017 14:49:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 05D44180FF
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Dec 2017 15:49:16 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id M_z4MZi_mHYk for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Dec 2017 15:49:15 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
	by bastet.se.axis.com (Postfix) with ESMTPS id 0AE0C1844C
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Dec 2017 15:49:15 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB4E31E095
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Dec 2017 15:49:14 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CFF351E089
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Dec 2017 15:49:14 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
	by boulder03.se.axis.com (Postfix) with ESMTP
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Dec 2017 15:49:14 +0100 (CET)
Received: from XBOX01.axis.com (xbox01.axis.com [10.0.5.15])
	by thoth.se.axis.com (Postfix) with ESMTP id C41632A65
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Dec 2017 15:49:14 +0100 (CET)
Received: from XBOX02.axis.com (10.0.5.16) by XBOX01.axis.com (10.0.5.15) with
	Microsoft SMTP Server (TLS) id 15.0.1263.5;
	Thu, 7 Dec 2017 15:49:14 +0100
Received: from XBOX02.axis.com ([fe80::50c3:4d2f:4507:7776]) by
	XBOX02.axis.com ([fe80::50c3:4d2f:4507:7776%21]) with mapi id
	15.00.1263.000; Thu, 7 Dec 2017 15:49:14 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 1/2] gstreamer1.0.inc: Define a
	PACKAGECONFIG for examples
Thread-Index: AQHTb2nZgl9C5cSKCkmGtw/70biG2aM39RNA
Date: Thu, 7 Dec 2017 14:49:14 +0000
Message-ID: <bbf9bb3cfc3345c6b0b60de389f78791@XBOX02.axis.com>
References: <20171207143832.20865-1-pkj@axis.com>
In-Reply-To: <20171207143832.20865-1-pkj@axis.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
X-TM-AS-GCONF: 00
Subject: Re: [PATCH 1/2] gstreamer1.0.inc: Define a	PACKAGECONFIG for examples
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
X-List-Received-Date: Thu, 07 Dec 2017 14:49:15 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Please disregard this patch and the other GStreamer patch in this=20
series. They were apparently around when I used 0* to gather the=20
patch I intended to send.

//Peter

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
> devel-bounces@lists.openembedded.org] On Behalf Of Peter Kjellerstedt
> Sent: den 7 december 2017 15:39
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH 1/2] gstreamer1.0.inc: Define a
> PACKAGECONFIG for examples
>=20
> This makes it consistent with, e.g., debug, that can be
> enabled/disabled using a PACKAGECONFIG.
>=20
> Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> ---
>  meta/recipes-multimedia/gstreamer/gstreamer1.0.inc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/meta/recipes-multimedia/gstreamer/gstreamer1.0.inc
> b/meta/recipes-multimedia/gstreamer/gstreamer1.0.inc
> index 329193486d..a3a8207229 100644
> --- a/meta/recipes-multimedia/gstreamer/gstreamer1.0.inc
> +++ b/meta/recipes-multimedia/gstreamer/gstreamer1.0.inc
> @@ -21,6 +21,7 @@ SRC_URI_append =3D " \
>  PACKAGECONFIG ??=3D ""
>=20
>  PACKAGECONFIG[debug] =3D "--enable-debug,--disable-debug"
> +PACKAGECONFIG[examples] =3D "--enable-examples,--disable-examples"
>  PACKAGECONFIG[tests] =3D "--enable-tests,--disable-tests"
>  PACKAGECONFIG[valgrind] =3D "--enable-valgrind,--disable-
> valgrind,valgrind,"
>  PACKAGECONFIG[gst-tracer-hooks] =3D "--enable-gst-tracer-hooks,--
> disable-gst-tracer-hooks,"
> @@ -29,7 +30,6 @@ PACKAGECONFIG[dw] =3D "--with-dw,--without-dw,elfutils"
>=20
>  EXTRA_OECONF =3D " \
>      --disable-dependency-tracking \
> -    --disable-examples \
>  "
>=20
>  CACHED_CONFIGUREVARS +=3D "ac_cv_header_valgrind_valgrind_h=3Dno"
> --
> 2.12.0
>=20
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

