Return-Path: <peter.kjellerstedt@axis.com>
X-Greylist: delayed 365 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 09 May 2016 14:23:20 UTC
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 3D5AA6E630
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 May 2016 14:23:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 4F8BB180C3;
	Mon,  9 May 2016 16:17:15 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id 8uN44Ci8MWNm; Mon,  9 May 2016 16:17:14 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bastet.se.axis.com (Postfix) with ESMTP id 7A357180C2;
	Mon,  9 May 2016 16:17:14 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 64497158A;
	Mon,  9 May 2016 16:17:14 +0200 (CEST)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id 59837FB0;
	Mon,  9 May 2016 16:17:14 +0200 (CEST)
Received: from XBOX03.axis.com (xbox03.axis.com [10.0.5.17])
	by thoth.se.axis.com (Postfix) with ESMTP id 5762F706;
	Mon,  9 May 2016 16:17:14 +0200 (CEST)
Received: from XBOX02.axis.com (10.0.5.16) by XBOX03.axis.com (10.0.5.17) with
	Microsoft SMTP Server (TLS) id 15.0.1156.6;
	Mon, 9 May 2016 16:17:14 +0200
Received: from XBOX02.axis.com ([fe80::50c3:4d2f:4507:7776]) by
	XBOX02.axis.com ([fe80::50c3:4d2f:4507:7776%22]) with mapi id
	15.00.1156.000; Mon, 9 May 2016 16:17:14 +0200
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, bitbake-devel
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH] tests: assertEquals -> assertEqual
Thread-Index: AQHRqfM9k93Prpx6NEKkfPyr7M1YZp+wpr7g
Date: Mon, 9 May 2016 14:17:14 +0000
Message-ID: <bb75e00405ba42abbc4cb693f39b6f3e@XBOX02.axis.com>
References: <1462799021.21831.130.camel@linuxfoundation.org>
In-Reply-To: <1462799021.21831.130.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.55]
MIME-Version: 1.0
Subject: Re: [PATCH] tests: assertEquals -> assertEqual
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
X-List-Received-Date: Mon, 09 May 2016 14:23:21 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
> devel-bounces@lists.openembedded.org] On Behalf Of Richard Purdie
> Sent: den 9 maj 2016 15:04
> To: bitbake-devel
> Subject: [bitbake-devel] [PATCH] tests: assertEquals -> assertEqual
>=20
> The preferred form is assertEqaual, assertEquals is deprecated and

Correct "assertEqaual" to " assertEqual".

//Peter


