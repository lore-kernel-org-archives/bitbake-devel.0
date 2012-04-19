Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]
	helo=tx2outboundpool.messaging.microsoft.com)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <B29882@freescale.com>) id 1SL1iq-0000PK-64
	for bitbake-devel@lists.openembedded.org;
	Fri, 20 Apr 2012 02:29:12 +0200
Received: from mail78-tx2-R.bigfish.com (10.9.14.241) by
	TX2EHSOBE004.bigfish.com (10.9.40.24) with Microsoft SMTP Server id
	14.1.225.23; Thu, 19 Apr 2012 23:34:29 +0000
Received: from mail78-tx2 (localhost [127.0.0.1])	by mail78-tx2-R.bigfish.com
	(Postfix) with ESMTP id 61AE680156;
	Thu, 19 Apr 2012 23:34:29 +0000 (UTC)
X-SpamScore: -17
X-BigFish: VS-17(zz9371I936eK1432N98dK1447Mzz1202hzz8275dhz2dh2a8h668h839h8e2h8e3h946hbe9i)
X-Forefront-Antispam-Report: CIP:70.37.183.190; KIP:(null); UIP:(null); IPV:NLI;
	H:mail.freescale.net; RD:none; EFVD:NLI
Received: from mail78-tx2 (localhost.localdomain [127.0.0.1]) by mail78-tx2
	(MessageSwitch) id 1334878468313955_18293;
	Thu, 19 Apr 2012 23:34:28 +0000 (UTC)
Received: from TX2EHSMHS032.bigfish.com (unknown [10.9.14.236])	by
	mail78-tx2.bigfish.com (Postfix) with ESMTP id 3D009E011C;
	Thu, 19 Apr 2012 23:34:28 +0000 (UTC)
Received: from mail.freescale.net (70.37.183.190) by TX2EHSMHS032.bigfish.com
	(10.9.99.132) with Microsoft SMTP Server (TLS) id 14.1.225.23;
	Thu, 19 Apr 2012 23:34:28 +0000
Received: from 039-SN1MPN1-001.039d.mgd.msft.net ([169.254.1.132]) by
	039-SN1MMR1-001.039d.mgd.msft.net ([10.84.1.13]) with mapi id
	14.01.0355.003; Thu, 19 Apr 2012 18:34:27 -0500
From: McClintock Matthew-B29882 <B29882@freescale.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Thread-Topic: [bitbake-devel] python function used in variable expansion
	called multiple times per recipe
Thread-Index: AQHNHoT12kjYhmgafU2Tgra1Bs/nBw==
Date: Thu, 19 Apr 2012 23:34:27 +0000
Message-ID: <CAEsOVNfg6Y60MXMfev4Pn+KUc7=YTocjHO_w7PMpgC_7FKN0uQ@mail.gmail.com>
References: <E7A9054A5ACABE48B0E540E46E862B0F0427C336@NAEMMAIL01.na.leapfrog.com>
	<671D7BD596E04EE1961D6EA1C734C816@gmail.com>
	<E7A9054A5ACABE48B0E540E46E862B0F0427C5FA@NAEMMAIL01.na.leapfrog.com>
	<CABcZANn_xWLbxJRPK68Eu9iLjp6jjxkefPhe61UAcxzu91ZHwA@mail.gmail.com>
	<E7A9054A5ACABE48B0E540E46E862B0F0427CB32@NAEMMAIL01.na.leapfrog.com>
	<1334874480.3028.18.camel@ted>
In-Reply-To: <1334874480.3028.18.camel@ted>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [99.47.177.27]
MIME-Version: 1.0
X-OriginatorOrg: freescale.com
Cc: Daniel Lazzari <dlazzari@leapfrog.com>,
	"'bitbake-devel@lists.openembedded.org'
	\(bitbake-devel@lists.openembedded.org\)"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: python function used in variable expansion called multiple times per recipe
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
X-List-Received-Date: Fri, 20 Apr 2012 00:29:12 -0000
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <E176DB63E027154E984B3AACB74F3F75@mgd.freescale.com>
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19, 2012 at 5:28 PM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> On Thu, 2012-04-19 at 21:24 +0000, Daniel Lazzari wrote:
>> >> I think immediate expansion is what I=92ll need to use, thanks for th=
e tip.
>> >> That at least brings the invocation down to once per run. Unfortunate=
ly, the
>> >> variable doesn=92t seem to get filled in when I change to immediate
>> >expansion.
>> >>
>> >> def testFunc(bb, d):
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 print( bb.data.getVar("PN", d, True) =
)
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return "e1"
>> >>
>> >> EXTERNPV :=3D "${@testFunc(bb, d)}"
>> >>
>> >> Now only prints the package name once, but using =96e, I don=92t see =
the
>> >> variable EXTERNPV at all.
>> >
>> >Don't know what to tell you. It does work, so it's something wrong on
>> >your end. Either it's returning an empty string, which will result in
>> >-e only showing the commented out definition, or it's raising an
>> >exception, or something else in your setup. Aside: you don't need to
>> >pass 'bb' in. That namespace is always accessible, even from def'd
>> >python functions.
>> >--
>> >Christopher Larson
>>
>> Just thought I'd provide an update real quick on this. I discovered,
>> to my dismay, that even doing an immediate expansion still ran the
>> code before every task for that recipe. I switched to using an event
>> handler, but the RecipeParsed event occurs before every task for that
>> recipe. Eventually I discovered that the variable BB_WORKERCONTEXT is
>> set for RecipeParsed events when they are occurring before a task, but
>> not for the initial parse. Also, I discovered that setting a variable
>> in the event handler would not necessarily keep it set through
>> building the recipe. Thus I devised the below code to run the time
>> intensive code during initial parse and cache the value in a file so
>> it can be picked up again in later events. I'm leaving this here in
>> case it helps someone else.
>
> Just as a note, we have the persist_data code in bitbake which was
> written for this kind of reason in relation to SRCREV and AUTOINC which
> uses a sqlite backend as the storage. There isn't anything wrong with
> what you're doing, I just thought I'd mention it.

Richard,

I'm curious if something like an eventhandler is more suitable for me
trying to modify the PV/PR? Seems like eventhandler + BB_WORKERCONTEXT
could be what I'm looking for?

-M=



