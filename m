Return-Path: <peter.kjellerstedt@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 5757679F18
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Nov 2018 08:49:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 8C37F182EE;
	Fri,  2 Nov 2018 09:49:57 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id Kv8CvuE-b0dW; Fri,  2 Nov 2018 09:49:53 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
	by bastet.se.axis.com (Postfix) with ESMTPS id C36421816A;
	Fri,  2 Nov 2018 09:49:53 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0CCD1E078;
	Fri,  2 Nov 2018 09:49:53 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A54AF1E066;
	Fri,  2 Nov 2018 09:49:53 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
	by boulder03.se.axis.com (Postfix) with ESMTP;
	Fri,  2 Nov 2018 09:49:53 +0100 (CET)
Received: from XBOX04.axis.com (xbox04.axis.com [10.0.5.18])
	by seth.se.axis.com (Postfix) with ESMTP id 9973E262F;
	Fri,  2 Nov 2018 09:49:53 +0100 (CET)
Received: from XBOX04.axis.com (10.0.5.18) by XBOX04.axis.com (10.0.5.18) with
	Microsoft SMTP Server (TLS) id 15.0.1365.1;
	Fri, 2 Nov 2018 09:49:53 +0100
Received: from XBOX04.axis.com ([fe80::210a:724b:68cb:a917]) by
	XBOX04.axis.com ([fe80::210a:724b:68cb:a917%22]) with mapi id
	15.00.1365.000; Fri, 2 Nov 2018 09:49:53 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "Reyna, David" <david.reyna@windriver.com>, Awais Belal
	<awais_belal@mentor.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH] bitbake: toaster: allow OE_ROOT to be
	provided through environment
Thread-Index: AdRyiQRAV4P8b/mCQHmmEQT5iO1v9w==
Date: Fri, 2 Nov 2018 08:49:53 +0000
Message-ID: <88e85748d4854dcbbb70fefd71657791@XBOX04.axis.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
X-TM-AS-GCONF: 00
Subject: Re: [PATCH] bitbake: toaster: allow OE_ROOT to be provided through environment
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
X-List-Received-Date: Fri, 02 Nov 2018 08:49:57 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Actually, the originally suggested parameter expansion "${foo:-bar}" is=20
_not_ a bashism. It is standard POSIX, see:=20

http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#ta=
g_18_06_02

I would recommend the following, as it also avoids doing an unnecessary=20
fork to dirname, which has already been done two lines above when=20
setting BBBASEDIR:

OE_ROOT=3D${OE_ROOT:-$BBBASEDIR/..}

An alternative, but maybe a bit less obvious variant, is:

: ${OE_ROOT:=3D$BBBASEDIR/..}

making use of the fact that the parameter expansion and conditional=20
variable setting will happen before the : command (aka nop) is executed.

//Peter

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org <bitbake-devel-
> bounces@lists.openembedded.org> On Behalf Of Reyna, David
> Sent: den 1 november 2018 19:08
> To: Awais Belal <awais_belal@mentor.com>; bitbake-
> devel@lists.openembedded.org
> Subject: Re: [bitbake-devel] [PATCH] bitbake: toaster: allow OE_ROOT to
> be provided through environment
>=20
> Hi Awais,
>=20
> I agree to the idea. My only concern is that you are using a bashism to
> expand the variable, and that will fail on systems that for example are
> based on "dash". Since the "toaster" script is sourced, it cannot
> override the shell executor to "bash".
>=20
> While not as compact, I would prefer a shell-safe expansion such as:
>=20
> vvvv
>=20
> if [ -z "$OE_ROOT" ] ; then
>     OE_ROOT=3D`dirname $TOASTER`/../..
> endif
>=20
> ^^^^
>=20
> - David
>=20
> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
> devel-bounces@lists.openembedded.org] On Behalf Of Awais Belal
> Sent: Thursday, November 01, 2018 6:35 AM
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH] bitbake: toaster: allow OE_ROOT to be
> provided through environment
>=20
> Updates for YOCTO #12891 allowed a user to have a directory
> structure different to that of yocto (bitbake isn't inside
> oe-core) whereas the definition of OE_ROOT in the main toaster
> binary still assumes the same while checking for .templateconf
> and hence we see an error on the cmdline in such cases:
> bash: <repo-path>/bitbake/bin/../../.templateconf: No such file or
> directory
> The change here now allows the user to provide OE_ROOT through
> the environment in such cases and otherwise defaults to the older
> mechanism to fix this issue.
>=20
> Signed-off-by: Awais Belal <awais_belal@mentor.com>
> ---
>  bin/toaster | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/bin/toaster b/bin/toaster
> index 9fffbc6..4e227cc 100755
> --- a/bin/toaster
> +++ b/bin/toaster
> @@ -161,7 +161,7 @@ fi
>=20
>  export BBBASEDIR=3D`dirname $TOASTER`/..
>  MANAGE=3D"python3 $BBBASEDIR/lib/toaster/manage.py"
> -OE_ROOT=3D`dirname $TOASTER`/../..
> +OE_ROOT=3D${OE_ROOT:-`dirname $TOASTER`/../..}
>=20
>  # this is the configuraton file we are using for toaster
>  # we are using the same logic that oe-setup-builddir uses
> --
> 2.7.4
>=20
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

