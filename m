Received: from am1ehsobe001.messaging.microsoft.com ([213.199.154.204]
	helo=AM1EHSOBE001.bigfish.com)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <B29882@freescale.com>) id 1RljxB-0000E8-0S
	for bitbake-devel@lists.openembedded.org;
	Fri, 13 Jan 2012 17:26:09 +0100
Received: from mail44-am1-R.bigfish.com (10.3.201.242) by
	AM1EHSOBE001.bigfish.com (10.3.204.21) with Microsoft SMTP Server id
	14.1.225.23; Fri, 13 Jan 2012 16:03:27 +0000
Received: from mail44-am1 (localhost [127.0.0.1])	by mail44-am1-R.bigfish.com
	(Postfix) with ESMTP id 1E4E75A0514;
	Fri, 13 Jan 2012 16:03:27 +0000 (UTC)
X-SpamScore: -7
X-BigFish: VS-7(zz9371I1432N98dKzz1202hzz8275bh8275dhz2dhc1ahc1bh2a8h668h839h8e2h8e3hbe9k)
X-Forefront-Antispam-Report: CIP:70.37.183.190; KIP:(null); UIP:(null); IPV:NLI;
	H:mail.freescale.net; RD:none; EFVD:NLI
X-FB-SS: 13,
Received: from mail44-am1 (localhost.localdomain [127.0.0.1]) by mail44-am1
	(MessageSwitch) id 132647060717570_15982;
	Fri, 13 Jan 2012 16:03:27 +0000 (UTC)
Received: from AM1EHSMHS009.bigfish.com (unknown [10.3.201.252])	by
	mail44-am1.bigfish.com (Postfix) with ESMTP id F072A6C004A;
	Fri, 13 Jan 2012 16:03:26 +0000 (UTC)
Received: from mail.freescale.net (70.37.183.190) by AM1EHSMHS009.bigfish.com
	(10.3.207.109) with Microsoft SMTP Server (TLS) id 14.1.225.23;
	Fri, 13 Jan 2012 16:03:25 +0000
Received: from 039-SN1MPN1-002.039d.mgd.msft.net ([169.254.2.86]) by
	039-SN1MMR1-002.039d.mgd.msft.net ([10.84.1.15]) with mapi id
	14.01.0355.003; Fri, 13 Jan 2012 10:03:24 -0600
From: McClintock Matthew-B29882 <B29882@freescale.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Thread-Topic: [bitbake-devel] [PATCH] bitbake/fetch2: add support for
	wrapper command
Thread-Index: AQHM0c+eMqAYB8S+20OSO2Wm19jd+pYKxK4AgAAI+ACAAAEQAIAAC+QA
Date: Fri, 13 Jan 2012 16:03:23 +0000
Message-ID: <CAEsOVNeSLHFxjB9X5QfOxoM1yKzL_h7P-SBQJ40tvYf_6n3g5Q@mail.gmail.com>
References: <1326409741-17390-1-git-send-email-msm@freescale.com>
	<1326444277.11214.25.camel@ted>
	<CAEsOVNde_RCuzm3ehgmK+-iraRTpVrpW6N2EGyxRUW52yTdyoQ@mail.gmail.com>
	<1326467798.15389.41.camel@ted>
	<CAEsOVNfBB1BQD63Dzy+yz-GDdegy8c7Ba16-9Gvs2UPipWa4HA@mail.gmail.com>
In-Reply-To: <CAEsOVNfBB1BQD63Dzy+yz-GDdegy8c7Ba16-9Gvs2UPipWa4HA@mail.gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [99.47.177.27]
MIME-Version: 1.0
X-OriginatorOrg: freescale.com
Cc: McClintock Matthew-B29882 <B29882@freescale.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] bitbake/fetch2: add support for wrapper command
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
X-List-Received-Date: Fri, 13 Jan 2012 16:26:09 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <551E807D59248A428DEE8E07F1CD642F@freescale.net>
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2012 at 9:20 AM, Matthew McClintock <msm@freescale.com> wro=
te:
>>> I wrote a small blurb about why it was needed on the patch to oe-core,
>>> we are trying to do CVS or a SOCKS5 proxy that has authentication (the
>>> proxy) - I didn't see another way around this...
>>
>> Can't this be done via the environment or the FETCHCMD statements in
>> bitbake.conf?
>>
>> What really worries me here is that people keep adding 101 ways to use
>> different proxy setups. I'd really like one good way than 101 ways which
>> half work. All these different approaches and variables make the
>> codebase a nightmare to maintain and make it hard to explain to someone
>> how to setup things for their proxy.
>
> Actually, this way might make more sense... I'll test it out.

Something like:

FETCHCOMMAND_cvs_prepend =3D "socksify "

Seems to work quite well. How should we document this? I see:

https://wiki.yoctoproject.org/wiki/Working_Behind_a_Network_Proxy

Or should we just add an example blurb to local.conf.sample? Or add it
to the I don't see much in the user manual. I think it might be
worthwhile to add section to the Poky Reference Manual.

-M=



