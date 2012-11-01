Received: from va3ehsobe002.messaging.microsoft.com ([216.32.180.12]
	helo=va3outboundpool.messaging.microsoft.com)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <B29882@freescale.com>) id 1TU3rc-00065b-QB
	for bitbake-devel@lists.openembedded.org;
	Fri, 02 Nov 2012 00:07:53 +0100
Received: from mail269-va3-R.bigfish.com (10.7.14.250) by
	VA3EHSOBE007.bigfish.com (10.7.40.11) with Microsoft SMTP Server id
	14.1.225.23; Thu, 1 Nov 2012 22:09:00 +0000
Received: from mail269-va3 (localhost [127.0.0.1])	by
	mail269-va3-R.bigfish.com (Postfix) with ESMTP id 59FEA160026C;
	Thu,  1 Nov 2012 22:09:00 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:70.37.183.190; KIP:(null); UIP:(null); IPV:NLI;
	H:mail.freescale.net; RD:none; EFVD:NLI
X-SpamScore: -5
X-BigFish: VS-5(zz98dI9371I1431J1454I1432Izz1de0h1202h1d1ah1d2ahzz8275dhz2dh2a8h668h839h8e2h8e3hd25hf0ah10d2h1288h12a5h12a9h12bdh137ah13b6h1441h1537h153bhbe9i1155h)
Received: from mail269-va3 (localhost.localdomain [127.0.0.1]) by mail269-va3
	(MessageSwitch) id 135180773969231_8124;
	Thu,  1 Nov 2012 22:08:59 +0000 (UTC)
Received: from VA3EHSMHS032.bigfish.com (unknown [10.7.14.244])	by
	mail269-va3.bigfish.com (Postfix) with ESMTP id 0DE6424003F;
	Thu,  1 Nov 2012 22:08:59 +0000 (UTC)
Received: from mail.freescale.net (70.37.183.190) by VA3EHSMHS032.bigfish.com
	(10.7.99.42) with Microsoft SMTP Server (TLS) id 14.1.225.23;
	Thu, 1 Nov 2012 22:08:58 +0000
Received: from 039-SN1MPN1-001.039d.mgd.msft.net ([169.254.1.103]) by
	039-SN1MMR1-004.039d.mgd.msft.net ([::1]) with mapi id 14.02.0318.003;
	Thu, 1 Nov 2012 22:08:58 +0000
From: McClintock Matthew-B29882 <B29882@freescale.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Thread-Topic: [bitbake-devel] 1.16 stable series
Thread-Index: AQHNuH1956Jd8IFiI0CtG4dpSVt3TA==
Date: Thu, 1 Nov 2012 22:08:57 +0000
Message-ID: <70CC66F5C30A414DADDA6973E4CA391A74834D@039-SN1MPN1-001.039d.mgd.msft.net>
References: <1351750475.6502.11.camel@ted>
In-Reply-To: <1351750475.6502.11.camel@ted>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.112.201.132]
MIME-Version: 1.0
X-OriginatorOrg: freescale.com
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Scott Garman <scott.a.garman@intel.com>
Subject: Re: 1.16 stable series
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
X-List-Received-Date: Thu, 01 Nov 2012 23:07:53 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <A4B87C65882F9C47A12E4364639E0032@mgd.freescale.com>
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 1, 2012 at 1:14 AM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> One of the issues with previous OE-Core and Poky releases has been
> deciding which bitbake should be used used with them. There is a copy of
> bitbake in poky denzil which is a now becoming a bit of a Frankenstein,
> not corresponding to any particular bitbake release with various random
> patches from master. This isn't necessarily a bad thing and users of
> poky find it useful but I think we can do better.
>
> This time around, for the danny series I made sure we had a bitbake
> stable branch available to correspond with it (1.16). I'm planning to
> use the 1.16 branch as a stable bitbake branch and directly include that
> in poky-danny verbatim. So far I don't think there have been any
> invasive changes on master so I might just push current master into the
> 1.16 branch. As development moves forward, we'd move to a model of
> picking specific commits that make sense for the branch.
>
> I really just wanted to let people know what I was intending here, I
> doubt its too controversial and if people have specific things they want
> to see in the stable branch, feel free to point them out!

For denzil then should we apply straight to poky? Or should we try to
create something for denzil as well? Does one of the branches already
serve this purpose?

-M=



