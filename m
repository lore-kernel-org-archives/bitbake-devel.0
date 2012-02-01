Received: from am1ehsobe001.messaging.microsoft.com ([213.199.154.204]
	helo=AM1EHSOBE005.bigfish.com)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <B29882@freescale.com>) id 1Rse1J-0001px-FE
	for bitbake-devel@lists.openembedded.org;
	Wed, 01 Feb 2012 18:31:00 +0100
Received: from mail16-am1-R.bigfish.com (10.3.201.233) by
	AM1EHSOBE005.bigfish.com (10.3.204.25) with Microsoft SMTP Server id
	14.1.225.23; Wed, 1 Feb 2012 17:07:53 +0000
Received: from mail16-am1 (localhost [127.0.0.1])	by mail16-am1-R.bigfish.com
	(Postfix) with ESMTP id 065D34E0256;
	Wed,  1 Feb 2012 17:07:53 +0000 (UTC)
X-SpamScore: -7
X-BigFish: VS-7(zz9371I1432N98dKzz1202hzz8275bhz2dhc1bhc31hc1ah2a8h668h839h8e2h8e3hbe9k)
X-Forefront-Antispam-Report: CIP:70.37.183.190; KIP:(null); UIP:(null); IPV:NLI;
	H:mail.freescale.net; RD:none; EFVD:NLI
Received: from mail16-am1 (localhost.localdomain [127.0.0.1]) by mail16-am1
	(MessageSwitch) id 1328116070731434_762; Wed,  1 Feb 2012 17:07:50 +0000
	(UTC)
Received: from AM1EHSMHS018.bigfish.com (unknown [10.3.201.242])	by
	mail16-am1.bigfish.com (Postfix) with ESMTP id AEA74E0045;
	Wed,  1 Feb 2012 17:07:50 +0000 (UTC)
Received: from mail.freescale.net (70.37.183.190) by AM1EHSMHS018.bigfish.com
	(10.3.206.21) with Microsoft SMTP Server (TLS) id 14.1.225.23;
	Wed, 1 Feb 2012 17:07:50 +0000
Received: from 039-SN1MPN1-002.039d.mgd.msft.net ([169.254.2.86]) by
	039-SN1MMR1-002.039d.mgd.msft.net ([10.84.1.15]) with mapi id
	14.01.0355.003; Wed, 1 Feb 2012 11:07:48 -0600
From: McClintock Matthew-B29882 <B29882@freescale.com>
To: Khem Raj <raj.khem@gmail.com>
Thread-Topic: [bitbake-devel] should we switch off patchwork for oe-core and
	bitbake projects
Thread-Index: AQHM4QQFyKvbXkZugka1DUAXPW/EEA==
Date: Wed, 1 Feb 2012 17:07:47 +0000
Message-ID: <CAEsOVNekW4Zo6YRHyNCTMJ_GsgrzaOE8QvWr70tRNAZQNokcig@mail.gmail.com>
References: <CAMKF1so7zfZSiGq+txWdBkONMtMi8iKRhqV_TOPt3FV3fTTEpQ@mail.gmail.com>
In-Reply-To: <CAMKF1so7zfZSiGq+txWdBkONMtMi8iKRhqV_TOPt3FV3fTTEpQ@mail.gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [99.47.177.27]
MIME-Version: 1.0
X-OriginatorOrg: freescale.com
Cc: Patches and discussions about the oe-core layer
	<openembedded-core@lists.linuxtogo.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: should we switch off patchwork for oe-core and bitbake projects
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
X-List-Received-Date: Wed, 01 Feb 2012 17:31:01 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <0D26956134530446915C95C5458A60CC@freescale.net>
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 1, 2012 at 10:04 AM, Khem Raj <raj.khem@gmail.com> wrote:
> Hi
>
> patchwork instance that we have currently handles patches for
> oe-devel, oe-core and bitbake
> layers which use oe-devel maintain and use the patch queues ok so it
> makes sense to have it
> there. But patch flow for oe-core and bitbake is handled differently
> via pull requests. Would it
> make sense to turn it off for these two projects. Is someone using
> patchwork and/or finds
> it useful to have the patchwork catch those patches please let me know

Patchworks is useful for pulling patches into a git repo and having
discussion on a patch documented. I don't think it should just be
turned off, it can be left there for all the see and use.

-M=



