Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]
	helo=VA3EHSOBE005.bigfish.com)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <B29882@freescale.com>)
	id 1RsgB5-0002gO-1j; Wed, 01 Feb 2012 20:49:11 +0100
Received: from mail141-va3-R.bigfish.com (10.7.14.239) by
	VA3EHSOBE005.bigfish.com (10.7.40.25) with Microsoft SMTP Server id
	14.1.225.23; Wed, 1 Feb 2012 18:56:06 +0000
Received: from mail141-va3 (localhost [127.0.0.1])	by
	mail141-va3-R.bigfish.com (Postfix) with ESMTP id A469C4400D0;
	Wed,  1 Feb 2012 18:56:06 +0000 (UTC)
X-SpamScore: -7
X-BigFish: VS-7(zz9371I1432N98dKzz1202hzz8275bhz2dhc1bhc31hc1ah2a8h668h839h8e2h8e3hbe9k)
X-Forefront-Antispam-Report: CIP:70.37.183.190; KIP:(null); UIP:(null); IPV:NLI;
	H:mail.freescale.net; RD:none; EFVD:NLI
Received: from mail141-va3 (localhost.localdomain [127.0.0.1]) by mail141-va3
	(MessageSwitch) id 1328122564373019_12325;
	Wed,  1 Feb 2012 18:56:04 +0000 (UTC)
Received: from VA3EHSMHS026.bigfish.com (unknown [10.7.14.238])	by
	mail141-va3.bigfish.com (Postfix) with ESMTP id 540E04C004A;
	Wed,  1 Feb 2012 18:56:04 +0000 (UTC)
Received: from mail.freescale.net (70.37.183.190) by VA3EHSMHS026.bigfish.com
	(10.7.99.36) with Microsoft SMTP Server (TLS) id 14.1.225.23;
	Wed, 1 Feb 2012 18:56:01 +0000
Received: from 039-SN1MPN1-002.039d.mgd.msft.net ([169.254.2.86]) by
	039-SN1MMR1-002.039d.mgd.msft.net ([10.84.1.15]) with mapi id
	14.01.0355.003; Wed, 1 Feb 2012 12:56:01 -0600
From: McClintock Matthew-B29882 <B29882@freescale.com>
To: Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
Thread-Topic: [OE-core] [bitbake-devel] should we switch off patchwork for
	oe-core and bitbake projects
Thread-Index: AQHM4RMj4qOaZopYkEGQdyKNDYqIJw==
Date: Wed, 1 Feb 2012 18:56:00 +0000
Message-ID: <CAEsOVNeetp2xXW=5PCbNNyANBWSG10kf3yCuV=3+4wck2Jum0w@mail.gmail.com>
References: <CAMKF1so7zfZSiGq+txWdBkONMtMi8iKRhqV_TOPt3FV3fTTEpQ@mail.gmail.com>
	<CAEsOVNekW4Zo6YRHyNCTMJ_GsgrzaOE8QvWr70tRNAZQNokcig@mail.gmail.com>
	<CAP9ODKo5EQEWr2CU9uQdz6mXKPJfN6zhbSkTcC01k8rU2D4kQg@mail.gmail.com>
	<CAEsOVNeh8GTOcU+jF1jxs1FJTi84vq0_AVX9osvU1R83gzq2nA@mail.gmail.com>
	<CAMKF1sqkdApUR9YPamhtxtUHoanHZ5Sxp8ggUnp8PS0v_qPPgg@mail.gmail.com>
	<20120201181909.GC6969@jama.jama.net>
In-Reply-To: <20120201181909.GC6969@jama.jama.net>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [99.47.177.27]
MIME-Version: 1.0
X-OriginatorOrg: freescale.com
Cc: McClintock Matthew-B29882 <B29882@freescale.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [OE-core] should we switch off patchwork for oe-core and bitbake projects
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
X-List-Received-Date: Wed, 01 Feb 2012 19:49:11 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <7D0D89A724BD114180943320DADF3E0B@freescale.net>
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 1, 2012 at 12:19 PM, Martin Jansa <martin.jansa@gmail.com> wrot=
e:
> On Wed, Feb 01, 2012 at 10:07:14AM -0800, Khem Raj wrote:
>> On Wed, Feb 1, 2012 at 9:51 AM, McClintock Matthew-B29882
>> <B29882@freescale.com> wrote:
>> > I'm saying leave it there even if its not maintained. I can still go s=
earch
>> > for patches sent by me or other specific people.
>>
>> thats what mailing list archives are for.
>
> is there something like
> oe/contrib/patchwork/pw-am.sh
> for some mailing list archive?
>
> When I see some interesting patch in ML, easiest way for me to get it to
> development branch is to open patchwork web (from any computer) and then
> call pw-am.sh NUMBER in screen session on my development workstation.
>
> Even when reading mail in mutt on the same machine it's easier for me to
> use pw-am.sh to get that patch to my chroot for OE builds.
>
> And that git hook marking them as applied works very well.. so usually I
> just have to mark cover letters as applied.

My usage would be the same.

-M=



