Return-Path: <peter.kjellerstedt@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 3A93160017
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Dec 2018 21:05:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 600EC1833F;
	Tue, 18 Dec 2018 22:05:04 +0100 (CET)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id 6SmPiexfhlO9; Tue, 18 Dec 2018 22:05:02 +0100 (CET)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
	by bastet.se.axis.com (Postfix) with ESMTPS id 2151F18495;
	Tue, 18 Dec 2018 22:05:02 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F36421A070;
	Tue, 18 Dec 2018 22:05:01 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E84021A06D;
	Tue, 18 Dec 2018 22:05:01 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
	by boulder02.se.axis.com (Postfix) with ESMTP;
	Tue, 18 Dec 2018 22:05:01 +0100 (CET)
Received: from XBOX01.axis.com (xbox01.axis.com [10.0.5.15])
	by thoth.se.axis.com (Postfix) with ESMTP id DC4FF3090;
	Tue, 18 Dec 2018 22:05:01 +0100 (CET)
Received: from xbox11.axis.com (10.0.5.25) by XBOX01.axis.com (10.0.5.15) with
	Microsoft SMTP Server (TLS) id 15.0.1365.1;
	Tue, 18 Dec 2018 22:05:01 +0100
Received: from XBOX04.axis.com (10.0.5.18) by xbox11.axis.com (10.0.5.25) with
	Microsoft SMTP Server (TLS) id 15.0.1365.1;
	Tue, 18 Dec 2018 22:05:01 +0100
Received: from XBOX04.axis.com ([fe80::210a:724b:68cb:a917]) by
	XBOX04.axis.com ([fe80::210a:724b:68cb:a917%22]) with mapi id
	15.00.1365.000; Tue, 18 Dec 2018 22:05:01 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 2/3] data_smart: Allow numeric characters
	in	overrides
Thread-Index: AQHUk7WvxWtdnWml2k+9C69VBfTzvaWE/b0Q
Date: Tue, 18 Dec 2018 21:05:01 +0000
Message-ID: <ca187ac1c83d43b282db6b8d66d416a8@XBOX04.axis.com>
References: <20181214140219.1553-1-richard.purdie@linuxfoundation.org>
	<20181214140219.1553-2-richard.purdie@linuxfoundation.org>
In-Reply-To: <20181214140219.1553-2-richard.purdie@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
X-TM-AS-GCONF: 00
Subject: Re: [PATCH 2/3] data_smart: Allow numeric characters in	overrides
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
X-List-Received-Date: Tue, 18 Dec 2018 21:05:04 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org <bitbake-devel-
> bounces@lists.openembedded.org> On Behalf Of Richard Purdie
> Sent: den 14 december 2018 15:02
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH 2/3] data_smart: Allow numeric
> characters in overrides
>=20
> We're seeing problems due to the way x86-64 is handled (or not handled)
> as an override. Relax the containts on overrides from being lowercase
> to being lowercase or numeric. This fixes problem where MACHINE=3Dqemux86
> would work but MACHINE=3Dqemux86-64 would fail the same tests.
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/data_smart.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
> index 297a2f45b4..c342adaa0a 100644
> --- a/lib/bb/data_smart.py
> +++ b/lib/bb/data_smart.py
> @@ -43,6 +43,7 @@ __setvar_regexp__ =3D
> re.compile(r'(?P<base>.*?)(?P<keyword>_append|_prepend|_remo
>  __expand_var_regexp__ =3D re.compile(r"\${[^{}@\n\t :]+}")
>  __expand_python_regexp__ =3D re.compile(r"\${@.+?}")
>  __whitespace_split__ =3D re.compile(r'(\s)')
> +__override_regexp__ =3D re.compile(r'[a-z0-9]+')
>=20
>  def infer_caller_details(loginfo, parent =3D False, varval =3D True):
>      """Save the caller the trouble of specifying everything."""
> @@ -597,7 +598,7 @@ class DataSmart(MutableMapping):
>          # aka pay the cookie monster
>          override =3D var[var.rfind('_')+1:]
>          shortvar =3D var[:var.rfind('_')]
> -        while override and override.islower():
> +        while override and __override_regexp__.match(override):
>              if shortvar not in self.overridedata:
>                  self.overridedata[shortvar] =3D []
>              if [var, override] not in self.overridedata[shortvar]:
> --
> 2.19.1

I do not understand this commit. The commit explanation and the code change=
=20
don't match up. The motivation in the commit message is that there was=20
problems with overrides such as x86-64 containing digits and that the=20
code should be changed to allow overrides to be lower case and numeric.
However, the modified code changes the test from using islower(), which as=
=20
far as I can tell only validates the alpha-characters in the string and=20
ignores all else, to using a regular expression r'[a-z0-9]+', which will=20
match as long as the first character is a lower case character or a numeric=
=20
character (note that there is no $ at the end of the regular expression).

Here are tests with islower(), which correctly validates "x86" and "x86-64"=
=20
as lower case overrides, but not "fooBar":

>>> "x86".islower()
True
>>> "x86-64".islower()
True
>>> "fooBar".islower()
False

Here are the corresponding tests using the r'[a-z0-9]+' regular expression.
Note that it only matches "x86" from "x86-64" and "foo" from "fooBar", and=
=20
will incorrectly allow "fooBar" as an override:

>>> re.match(r'[a-z0-9]+', "x86")
<_sre.SRE_Match object; span=3D(0, 3), match=3D'x86'>
>>> re.match(r'[a-z0-9]+', "x86-64")
<_sre.SRE_Match object; span=3D(0, 3), match=3D'x86'>
>>> re.match(r'[a-z0-9]+', "fooBar")
<_sre.SRE_Match object; span=3D(0, 3), match=3D'foo'>

So why change from islower(), which as far as I can tell did the right thin=
g=20
from the beginning?

//Peter


