Return-Path: <peter.kjellerstedt@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id E68DF6AC00
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Jun 2018 19:36:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 6C6FA18502;
	Mon, 25 Jun 2018 21:36:50 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id WTNOhMdR6qKc; Mon, 25 Jun 2018 21:36:48 +0200 (CEST)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
	by bastet.se.axis.com (Postfix) with ESMTPS id 40176184FE;
	Mon, 25 Jun 2018 21:36:47 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE2781A06F;
	Mon, 25 Jun 2018 21:36:47 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D247B1A05E;
	Mon, 25 Jun 2018 21:36:47 +0200 (CEST)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
	by boulder02.se.axis.com (Postfix) with ESMTP;
	Mon, 25 Jun 2018 21:36:47 +0200 (CEST)
Received: from XBOX03.axis.com (xbox03.axis.com [10.0.5.17])
	by thoth.se.axis.com (Postfix) with ESMTP id C61622FF4;
	Mon, 25 Jun 2018 21:36:47 +0200 (CEST)
Received: from xbox11.axis.com (10.0.5.25) by XBOX03.axis.com (10.0.5.17) with
	Microsoft SMTP Server (TLS) id 15.0.1365.1;
	Mon, 25 Jun 2018 21:36:47 +0200
Received: from XBOX02.axis.com (10.0.5.16) by xbox11.axis.com (10.0.5.25) with
	Microsoft SMTP Server (TLS) id 15.0.1365.1;
	Mon, 25 Jun 2018 21:36:47 +0200
Received: from XBOX02.axis.com ([fe80::50c3:4d2f:4507:7776]) by
	XBOX02.axis.com ([fe80::50c3:4d2f:4507:7776%21]) with mapi id
	15.00.1365.000; Mon, 25 Jun 2018 21:36:47 +0200
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>, BitBake developer list
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] is there a replacement for "bitbake -c fetchall"?
Thread-Index: AQHUC+qxKzoLL9PLEkieTo0qWJR43qRxX1eA
Date: Mon, 25 Jun 2018 19:36:47 +0000
Message-ID: <d4a5354857cd444eacd0acfff9e5e556@XBOX02.axis.com>
References: <alpine.LFD.2.21.1806241413250.29780@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.21.1806241413250.29780@localhost.localdomain>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
X-TM-AS-GCONF: 00
Subject: Re: is there a replacement for "bitbake -c fetchall"?
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
X-List-Received-Date: Mon, 25 Jun 2018 19:36:51 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
> devel-bounces@lists.openembedded.org] On Behalf Of Robert P. J. Day
> Sent: den 24 juni 2018 20:16
> To: BitBake developer list <bitbake-devel@lists.openembedded.org>
> Subject: [bitbake-devel] is there a replacement for "bitbake -c
> fetchall"?
>=20
>   haven't messed with OE/YP for a few months, just now noticed that
> the "fetchall" task has been removed, is there something equivalent
> since i found that useful for grabbing everything i would need later,
> and updating my local source mirror in the process.
>=20
> rday

It has been replaced with a generic --runall option to bitbake, see:

https://www.yoctoproject.org/docs/latest/ref-manual/ref-manual.html#migrati=
on-2.5-bitbake-changes

//Peter


