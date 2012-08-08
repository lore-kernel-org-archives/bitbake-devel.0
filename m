Received: from am1ehsobe006.messaging.microsoft.com ([213.199.154.209]
	helo=am1outboundpool.messaging.microsoft.com)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <B29882@freescale.com>) id 1SzCyz-0005eW-98
	for bitbake-devel@lists.openembedded.org;
	Wed, 08 Aug 2012 22:35:57 +0200
Received: from mail103-am1-R.bigfish.com (10.3.201.245) by
	AM1EHSOBE002.bigfish.com (10.3.204.22) with Microsoft SMTP Server id
	14.1.225.23; Wed, 8 Aug 2012 19:23:51 +0000
Received: from mail103-am1 (localhost [127.0.0.1])	by
	mail103-am1-R.bigfish.com (Postfix) with ESMTP id 06E434602EC;
	Wed,  8 Aug 2012 19:23:51 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:70.37.183.190; KIP:(null); UIP:(null); IPV:NLI;
	H:mail.freescale.net; RD:none; EFVD:NLI
X-SpamScore: -2
X-BigFish: VS-2(zz98dI9371I1432Izz1202hzz8275bhz2dh2a8h668h839h8e2h8e3hf0ah107ah10d2hbe9i)
Received: from mail103-am1 (localhost.localdomain [127.0.0.1]) by mail103-am1
	(MessageSwitch) id 134445382965085_9025;
	Wed,  8 Aug 2012 19:23:49 +0000 (UTC)
Received: from AM1EHSMHS016.bigfish.com (unknown [10.3.201.251])	by
	mail103-am1.bigfish.com (Postfix) with ESMTP id 0C573C0048;
	Wed,  8 Aug 2012 19:23:49 +0000 (UTC)
Received: from mail.freescale.net (70.37.183.190) by AM1EHSMHS016.bigfish.com
	(10.3.207.154) with Microsoft SMTP Server (TLS) id 14.1.225.23;
	Wed, 8 Aug 2012 19:23:47 +0000
Received: from 039-SN1MPN1-001.039d.mgd.msft.net ([169.254.1.41]) by
	039-SN1MMR1-001.039d.mgd.msft.net ([10.84.1.13]) with mapi id
	14.02.0298.005; Wed, 8 Aug 2012 14:23:45 -0500
From: McClintock Matthew-B29882 <B29882@freescale.com>
To: Daniel Lazzari <dlazzari@leapfrog.com>
Thread-Topic: [bitbake-devel] Making a noexec task executable again
Thread-Index: AQHNdZtT6eV9pAqRWkausPC1vk+Jsg==
Date: Wed, 8 Aug 2012 19:23:44 +0000
Message-ID: <CAEsOVNc6KjAdgpgnUgJ_UiR=vD6kE2OYo1BX4JfKLGUStPhVRQ@mail.gmail.com>
References: <E7A9054A5ACABE48B0E540E46E862B0FB5B1F2A8@NAEMMAIL02.na.leapfrog.com>
In-Reply-To: <E7A9054A5ACABE48B0E540E46E862B0FB5B1F2A8@NAEMMAIL02.na.leapfrog.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.112.201.132]
MIME-Version: 1.0
X-OriginatorOrg: freescale.com
Cc: "'bitbake-devel@lists.openembedded.org'
	\(bitbake-devel@lists.openembedded.org\)"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: Making a noexec task executable again
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
X-List-Received-Date: Wed, 08 Aug 2012 20:35:57 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <817260E3673C8C479497AB6E314ABFC1@mgd.freescale.com>
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 7, 2012 at 7:44 PM, Daniel Lazzari <dlazzari@leapfrog.com> wrot=
e:
> I ran across an interesting challenge today. One of our old image recipes=
 is being ported into denzil and needs to fetch a file to do some whitelist=
 processing. Unfortunately, in denzil, the image class has
>
> do_fetch[noexec] =3D "1"
>
> which stops the fetch task from running. How can I get it to run again? I=
 tried
>
> do_fetch[noexec] =3D "0"
>
> and
>
> do_fetch[noexec] =3D ""
>
> to no avail.

One option is to add a new task that calls base_do_fetch?

-M=



