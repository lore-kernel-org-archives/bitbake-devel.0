Return-Path: <peter.kjellerstedt@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id BBAB97713B
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Feb 2016 10:14:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id B59B42E19A;
	Mon, 29 Feb 2016 11:14:42 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id MpwcYP3b4AJ6; Mon, 29 Feb 2016 11:14:42 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bes.se.axis.com (Postfix) with ESMTP id BEFFD2E16E;
	Mon, 29 Feb 2016 11:14:41 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 7B50012A3;
	Mon, 29 Feb 2016 11:14:41 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id 6FBB24A7;
	Mon, 29 Feb 2016 11:14:41 +0100 (CET)
Received: from XBOX03.axis.com (xbox03.axis.com [10.0.5.17])
	by seth.se.axis.com (Postfix) with ESMTP id 695A53E44E;
	Mon, 29 Feb 2016 11:14:41 +0100 (CET)
Received: from XBOX02.axis.com (10.0.5.16) by XBOX03.axis.com (10.0.5.17) with
	Microsoft SMTP Server (TLS) id 15.0.1156.6;
	Mon, 29 Feb 2016 11:14:41 +0100
Received: from XBOX02.axis.com ([fe80::bcea:88d5:e1ff:8e04]) by
	XBOX02.axis.com ([fe80::bcea:88d5:e1ff:8e04%12]) with mapi id
	15.00.1156.000; Mon, 29 Feb 2016 11:14:41 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "brendan.le.foll@intel.com" <brendan.le.foll@intel.com>, "Richard Purdie
	(richard.purdie@linuxfoundation.org)" <richard.purdie@linuxfoundation.org>
Thread-Topic: [bitbake-devel] [PATCH 1/3] utils.py: Add sha1_file call
Thread-Index: AQHRb94340sDNkdwUkmI/JsyPbmrx59C0qMA
Date: Mon, 29 Feb 2016 10:14:41 +0000
Message-ID: <5892cfc210174afd8fb90a181459873b@XBOX02.axis.com>
References: <1456412828-11343-1-git-send-email-brendan.le.foll@intel.com>
	<1456412828-11343-2-git-send-email-brendan.le.foll@intel.com>
In-Reply-To: <1456412828-11343-2-git-send-email-brendan.le.foll@intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.55]
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 1/3] utils.py: Add sha1_file call
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
X-List-Received-Date: Mon, 29 Feb 2016 10:14:45 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
> devel-bounces@lists.openembedded.org] On Behalf Of
> brendan.le.foll@intel.com
> Sent: den 25 februari 2016 16:07
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH 1/3] utils.py: Add sha1_file call
>=20
> From: Brendan Le Foll <brendan.le.foll@intel.com>
>=20
> This is useful as npm-lockdown uses sha1 because npm releases the sha1 of
> packages and whilst this is undocumented it seems no other algorithm is
> supported
>=20
> Signed-off-by: Brendan Le Foll <brendan.le.foll@intel.com>
> ---
>  lib/bb/utils.py | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/lib/bb/utils.py b/lib/bb/utils.py
> index 82579b8..7ab8927 100644
> --- a/lib/bb/utils.py
> +++ b/lib/bb/utils.py
> @@ -534,6 +534,21 @@ def sha256_file(filename):
>              s.update(line)
>      return s.hexdigest()
>=20
> +def sha1_file(filename):
> +    """
> +    Return the hex string representation of the SHA1 checksum of the fil=
ename

I saw that this was already integrated, but I think the above=20
description is very misleading. I read it as that the function=20
returns the SHA-1 checksum of the file name, but by reading the=20
code it is obvious that it returns the SHA-1 checksum of the=20
file contents...

I would change "the filename" to "a file".

> +    """
> +    try:
> +        import hashlib
> +    except ImportError:
> +        return None
> +
> +    s =3D hashlib.sha1()
> +    with open(filename, "rb") as f:
> +        for line in f:
> +            s.update(line)
> +    return s.hexdigest()
> +
>  def preserved_envvars_exported():
>      """Variables which are taken from the environment and placed in and =
exported
>      from the metadata"""
> --
> 2.7.1

//Peter


