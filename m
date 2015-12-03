Return-Path: <peter.kjellerstedt@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id 062696FF56
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  3 Dec 2015 13:49:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id 9A5F02E155;
	Thu,  3 Dec 2015 14:49:44 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id 0vYQRDxaPPXu; Thu,  3 Dec 2015 14:49:44 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bes.se.axis.com (Postfix) with ESMTP id E946C2E0C6;
	Thu,  3 Dec 2015 14:49:43 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id D285C136;
	Thu,  3 Dec 2015 14:49:43 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id C5EA4111;
	Thu,  3 Dec 2015 14:49:43 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by thoth.se.axis.com (Postfix) with ESMTP id C3BAC34143;
	Thu,  3 Dec 2015 14:49:43 +0100 (CET)
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail2.se.axis.com
	([10.0.5.74]) with mapi; Thu, 3 Dec 2015 14:49:43 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: brian avery <avery.brian@gmail.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Date: Thu, 3 Dec 2015 14:49:42 +0100
Thread-Topic: [bitbake-devel] [PATCH 05/30] toaster: remove unused variable
Thread-Index: AdEtK4DVnj6D3JMXQtKt+H9IpfN4eAApc+mA
Message-ID: <A612847CFE53224C91B23E3A5B48BAC7C6F09F4B24@xmail3.se.axis.com>
References: <cover.1449078919.git.avery.brian@gmail.com>
	<43de04cb1abe40187d42e2bc0f20ba9ee200f3b3.1449078919.git.avery.brian@gmail.com>
In-Reply-To: <43de04cb1abe40187d42e2bc0f20ba9ee200f3b3.1449078919.git.avery.brian@gmail.com>
Accept-Language: en-US, sv-SE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, sv-SE
MIME-Version: 1.0
Subject: Re: [PATCH 05/30] toaster: remove unused variable
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
X-List-Received-Date: Thu, 03 Dec 2015 13:49:46 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
> devel-bounces@lists.openembedded.org] On Behalf Of brian avery
> Sent: den 2 december 2015 19:03
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH 05/30] toaster: remove unused variable
>=20
> From: Ed Bartosh <ed.bartosh@linux.intel.com>
>=20
> Removed variable RUNNING as it's not used anymore
> in the toaster script.
>=20
> Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
> Signed-off-by: brian avery <avery.brian@gmail.com>
> ---
>  bin/toaster | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/bin/toaster b/bin/toaster
> index abc8737..1ce4af7 100755
> --- a/bin/toaster
> +++ b/bin/toaster
> @@ -176,9 +176,7 @@ fi
>=20
>  BBBASEDIR=3D`dirname $TOASTER`/..
>  OEROOT=3D`dirname $TOASTER`/../..
> -
>  RUNNING=3D0

The commit message says that it removes the RUNNING variable, but=20
the commit only seems to remove some whitespace and not the actual=20
variable...

> -
>  NOTOASTERUI=3D0
>  WEBSERVER=3D1
>  TOASTER_BRBE=3D""
> --
> 1.9.1
>=20
> --

//Peter


