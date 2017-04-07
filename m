Return-Path: <peter.kjellerstedt@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id 8622B72F3A
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Apr 2017 12:20:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id 0A47411A03F;
	Fri,  7 Apr 2017 14:20:30 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id 7k8HnG2-af3g; Fri,  7 Apr 2017 14:20:28 +0200 (CEST)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
	by bes.se.axis.com (Postfix) with ESMTPS id 2E08B11A03D;
	Fri,  7 Apr 2017 14:20:28 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEEAC1A08B;
	Fri,  7 Apr 2017 14:20:27 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B36E51A082;
	Fri,  7 Apr 2017 14:20:27 +0200 (CEST)
Received: from seth.se.axis.com (unknown [10.0.2.172])
	by boulder02.se.axis.com (Postfix) with ESMTP;
	Fri,  7 Apr 2017 14:20:27 +0200 (CEST)
Received: from XBOX01.axis.com (xbox01.axis.com [10.0.5.15])
	by seth.se.axis.com (Postfix) with ESMTP id A6EBE2B6C;
	Fri,  7 Apr 2017 14:20:27 +0200 (CEST)
Received: from XBOX02.axis.com (10.0.5.16) by XBOX01.axis.com (10.0.5.15) with
	Microsoft SMTP Server (TLS) id 15.0.1210.3;
	Fri, 7 Apr 2017 14:20:27 +0200
Received: from XBOX02.axis.com ([fe80::50c3:4d2f:4507:7776]) by
	XBOX02.axis.com ([fe80::50c3:4d2f:4507:7776%21]) with mapi id
	15.00.1210.000; Fri, 7 Apr 2017 14:20:27 +0200
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Thread-Topic: [bitbake-devel] [PATCH 00/11] bitbake-diffsigs fixes/improvements
Thread-Index: AQHSryAsElIUQxfYE0iUGzqXVkxuy6G5033Q
Date: Fri, 7 Apr 2017 12:20:27 +0000
Message-ID: <d42b10d6959f4e89b77ac926f260d556@XBOX02.axis.com>
References: <cover.1491514854.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1491514854.git.paul.eggleton@linux.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
X-TM-AS-GCONF: 00
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 00/11] bitbake-diffsigs fixes/improvements
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
X-List-Received-Date: Fri, 07 Apr 2017 12:20:29 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
> devel-bounces@lists.openembedded.org] On Behalf Of Paul Eggleton
> Sent: den 6 april 2017 23:52
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH 00/11] bitbake-diffsigs
> fixes/improvements
>=20
> As part of an effort to add task signature recording and comparison to
> buildhistory in OE, I went digging into bitbake-diffsigs and the code
> that supports it and discovered that unfortunately it had a number of
> bugs - in particular the -t option despite being around for a while and
> having numerous band-aids applied in the past still wasn't really
> working properly. I have to take a big chunk of the responsibility for
> this as I wrote the thing in the first place. This patchset corrects
> most of the issues that I found and also makes a number of improvements
> to the readability of the output.
>=20
> NOTE: there are a few corresponding changes required in OE-Core that I
> am about to send out, these should be applied at the same time.

Will you do the same for bitbake-dumpsig as I believe it has many=20
problems in common with bitbake-diffsigs?

//Peter


