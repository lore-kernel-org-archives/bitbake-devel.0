Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]
	helo=TX2EHSOBE001.bigfish.com)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <B29882@freescale.com>) id 1RljI7-00070u-NP
	for bitbake-devel@lists.openembedded.org;
	Fri, 13 Jan 2012 16:43:44 +0100
Received: from mail190-tx2-R.bigfish.com (10.9.14.240) by
	TX2EHSOBE001.bigfish.com (10.9.40.21) with Microsoft SMTP Server id
	14.1.225.23; Fri, 13 Jan 2012 15:20:58 +0000
Received: from mail190-tx2 (localhost [127.0.0.1])	by
	mail190-tx2-R.bigfish.com (Postfix) with ESMTP id 336EE6C03C8;
	Fri, 13 Jan 2012 15:20:58 +0000 (UTC)
X-SpamScore: -7
X-BigFish: VS-7(zz9371I1432N98dKzz1202hzz8275dhz2dhc1ahc1bh2a8h668h839h8e2h8e3hbe9k61h)
X-Spam-TCS-SCL: 0:0
X-Forefront-Antispam-Report: CIP:70.37.183.190; KIP:(null); UIP:(null); IPV:NLI;
	H:mail.freescale.net; RD:none; EFVD:NLI
X-FB-SS: 0,
Received: from mail190-tx2 (localhost.localdomain [127.0.0.1]) by mail190-tx2
	(MessageSwitch) id 1326468056810332_5854;
	Fri, 13 Jan 2012 15:20:56 +0000 (UTC)
Received: from TX2EHSMHS047.bigfish.com (unknown [10.9.14.241])	by
	mail190-tx2.bigfish.com (Postfix) with ESMTP id ADA3130004C;
	Fri, 13 Jan 2012 15:20:56 +0000 (UTC)
Received: from mail.freescale.net (70.37.183.190) by TX2EHSMHS047.bigfish.com
	(10.9.99.147) with Microsoft SMTP Server (TLS) id 14.1.225.23;
	Fri, 13 Jan 2012 15:20:55 +0000
Received: from 039-SN1MPN1-002.039d.mgd.msft.net ([169.254.2.86]) by
	039-SN1MMR1-001.039d.mgd.msft.net ([10.84.1.13]) with mapi id
	14.01.0355.003; Fri, 13 Jan 2012 09:20:49 -0600
From: McClintock Matthew-B29882 <B29882@freescale.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Thread-Topic: [bitbake-devel] [PATCH] bitbake/fetch2: add support for
	wrapper command
Thread-Index: AQHM0c+eMqAYB8S+20OSO2Wm19jd+pYKxK4AgAAI+ACAAAEQAA==
Date: Fri, 13 Jan 2012 15:20:49 +0000
Message-ID: <CAEsOVNfBB1BQD63Dzy+yz-GDdegy8c7Ba16-9Gvs2UPipWa4HA@mail.gmail.com>
References: <1326409741-17390-1-git-send-email-msm@freescale.com>
	<1326444277.11214.25.camel@ted>
	<CAEsOVNde_RCuzm3ehgmK+-iraRTpVrpW6N2EGyxRUW52yTdyoQ@mail.gmail.com>
	<1326467798.15389.41.camel@ted>
In-Reply-To: <1326467798.15389.41.camel@ted>
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
X-List-Received-Date: Fri, 13 Jan 2012 15:43:44 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <FDEB226C65DFA849BC454FBDFF7DC5CC@freescale.net>
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2012 at 9:16 AM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> wrapper =3D d.getVar("BB_FETCH_WRAPPER", True)
> if wrapper:
> =A0 =A0cmd =3D wrapper + " " + cmd
>
> (please use d.getVar, not bb.data.getVar)

Ok.

>
>> I wrote a small blurb about why it was needed on the patch to oe-core,
>> we are trying to do CVS or a SOCKS5 proxy that has authentication (the
>> proxy) - I didn't see another way around this...
>
> Can't this be done via the environment or the FETCHCMD statements in
> bitbake.conf?
>
> What really worries me here is that people keep adding 101 ways to use
> different proxy setups. I'd really like one good way than 101 ways which
> half work. All these different approaches and variables make the
> codebase a nightmare to maintain and make it hard to explain to someone
> how to setup things for their proxy.

Actually, this way might make more sense... I'll test it out.

-M=



