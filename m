Received: from am1ehsobe006.messaging.microsoft.com ([213.199.154.209]
	helo=am1outboundpool.messaging.microsoft.com)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <B29882@freescale.com>) id 1S5PxV-0000q8-7U
	for bitbake-devel@lists.openembedded.org;
	Thu, 08 Mar 2012 00:07:49 +0100
Received: from mail45-am1-R.bigfish.com (10.3.201.235) by
	AM1EHSOBE003.bigfish.com (10.3.204.23) with Microsoft SMTP Server id
	14.1.225.23; Wed, 7 Mar 2012 22:14:03 +0000
Received: from mail45-am1 (localhost [127.0.0.1])	by mail45-am1-R.bigfish.com
	(Postfix) with ESMTP id DC315E0484;
	Wed,  7 Mar 2012 22:14:03 +0000 (UTC)
X-SpamScore: -7
X-BigFish: VS-7(zz9371I1432N98dKzz1202hzz8275dhz2dh2a8h668h839h8e2h8e3hbe9k)
X-Forefront-Antispam-Report: CIP:70.37.183.190; KIP:(null); UIP:(null); IPV:NLI;
	H:mail.freescale.net; RD:none; EFVD:NLI
Received: from mail45-am1 (localhost.localdomain [127.0.0.1]) by mail45-am1
	(MessageSwitch) id 1331158442352880_32415;
	Wed,  7 Mar 2012 22:14:02 +0000 (UTC)
Received: from AM1EHSMHS006.bigfish.com (unknown [10.3.201.234])	by
	mail45-am1.bigfish.com (Postfix) with ESMTP id 484A88009C;
	Wed,  7 Mar 2012 22:14:02 +0000 (UTC)
Received: from mail.freescale.net (70.37.183.190) by AM1EHSMHS006.bigfish.com
	(10.3.207.106) with Microsoft SMTP Server (TLS) id 14.1.225.23;
	Wed, 7 Mar 2012 22:14:01 +0000
Received: from 039-SN1MPN1-001.039d.mgd.msft.net ([169.254.1.244]) by
	039-SN1MMR1-003.039d.mgd.msft.net ([10.84.1.16]) with mapi id
	14.01.0355.003; Wed, 7 Mar 2012 16:14:00 -0600
From: McClintock Matthew-B29882 <B29882@freescale.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Thread-Topic: [bitbake-devel] [PATCH] parse/ast: Expand inherit statements
	before splitting them
Thread-Index: AQHM/K+YPJc8FOYhHE64hYsnlHL1UA==
Date: Wed, 7 Mar 2012 22:13:58 +0000
Message-ID: <CAEsOVNfV1iy1Npks-3fuT0g+sLXenNMc8+n_mAV-t9RX6AtcSQ@mail.gmail.com>
References: <1330834637.3949.8.camel@ted>
In-Reply-To: <1330834637.3949.8.camel@ted>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [99.47.177.27]
MIME-Version: 1.0
X-OriginatorOrg: freescale.com
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] parse/ast: Expand inherit statements before splitting them
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
Reply-To: McClintock Matthew-B29882 <B29882@freescale.com>
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 07 Mar 2012 23:07:49 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <4884DFFF129B4E4FACD5657790A9ECB2@mgd.freescale.com>
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 3, 2012 at 10:17 PM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> This means that statements that expand to more then one entry
> such as:
>
> CLASSES =3D "a b"
> inherit ${CLASSES}
>
> work correctly instead of trying to inherit a class called "a b".

Does this effect:

CLASSES =3D ""

inherit a ${CLASSES}

?

-M=



