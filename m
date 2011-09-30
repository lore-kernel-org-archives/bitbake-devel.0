Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]
	helo=ch1outboundpool.messaging.microsoft.com)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <B29882@freescale.com>) id 1R9hWl-0000Hy-AJ
	for bitbake-devel@lists.openembedded.org;
	Fri, 30 Sep 2011 20:09:39 +0200
Received: from mail97-ch1-R.bigfish.com (216.32.181.171) by
	CH1EHSOBE014.bigfish.com (10.43.70.64) with Microsoft SMTP Server id
	14.1.225.22; Fri, 30 Sep 2011 17:33:54 +0000
Received: from mail97-ch1 (localhost.localdomain [127.0.0.1])	by
	mail97-ch1-R.bigfish.com (Postfix) with ESMTP id 11EB6F6035B;
	Fri, 30 Sep 2011 17:33:54 +0000 (UTC)
X-SpamScore: -12
X-BigFish: VS-12(zz9371K1432N98dKzz1202hzz8275bhz2dh2a8h668h839h8e2h8e3h61h)
X-Spam-TCS-SCL: 0:0
X-Forefront-Antispam-Report: CIP:70.37.183.190; KIP:(null); UIP:(null);
	IPVD:NLI; H:mail.freescale.net; RD:none; EFVD:NLI
X-FB-SS: 0,
Received: from mail97-ch1 (localhost.localdomain [127.0.0.1]) by mail97-ch1
	(MessageSwitch) id 1317403973472648_9411;
	Fri, 30 Sep 2011 17:32:53 +0000 (UTC)
Received: from CH1EHSMHS027.bigfish.com (snatpool1.int.messaging.microsoft.com
	[10.43.68.251])	by mail97-ch1.bigfish.com (Postfix) with ESMTP id
	4AC27A40144;	Fri, 30 Sep 2011 17:32:10 +0000 (UTC)
Received: from mail.freescale.net (70.37.183.190) by CH1EHSMHS027.bigfish.com
	(10.43.70.27) with Microsoft SMTP Server (TLS) id 14.1.225.22;
	Fri, 30 Sep 2011 17:32:06 +0000
Received: from 039-SN1MPN1-003.039d.mgd.msft.net ([169.254.3.230]) by
	039-SN1MMR1-001.039d.mgd.msft.net ([10.84.1.13]) with mapi id
	14.01.0323.007; Fri, 30 Sep 2011 12:32:06 -0500
From: McClintock Matthew-B29882 <B29882@freescale.com>
To: Joshua Lock <joshua.lock@intel.com>
Thread-Topic: [bitbake-devel] Feedback on HOB (new image creator GUI)
Thread-Index: AQHMf4ziodQj6EIfBk2AFipaRDmOxpVmgC4AgAACLAA=
Date: Fri, 30 Sep 2011 17:32:05 +0000
Message-ID: <CAEsOVNfA6+=0sOvJeExCfvCOe2S_kD-Va6cUbRr4qhO_VrLi_A@mail.gmail.com>
References: <4E85D3E0.7070807@intel.com>
	<CAEsOVNdwudRO7V2DQhpESC=xCqDtJqxJ72+e_hYDLq7bE=z+cg@mail.gmail.com>
	<1317403442.11645.17.camel@scimitar>
In-Reply-To: <1317403442.11645.17.camel@scimitar>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [99.47.177.27]
MIME-Version: 1.0
X-OriginatorOrg: freescale.com
Cc: McClintock Matthew-B29882 <B29882@freescale.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	openembedded-core <openembedded-core@lists.openembedded.org>
Subject: Re: Feedback on HOB (new image creator GUI)
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
X-List-Received-Date: Fri, 30 Sep 2011 18:09:39 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <9B698B2BB7FC234C9BEDD02C77D02F1E@freescale.net>
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 30, 2011 at 12:23 PM, Joshua Lock <joshua.lock@intel.com> wrote=
:
> No such discussion has occurred. These are good feature suggestions,
> though I'm not sure about a plugin mechanism - are you suggesting that
> to enable the features mentioned or in addition to?
> At least for enabling runtime services there's likely an issue of the
> GUI having enough knowledge of the init system to do so.

I'd just like to be able to make these extensions/add-ons while not
being familiar with bitbake internals. Maybe by INHERIT'ing bbclasses?
It just seems like adding some configuration pane for configuring ip
addresses should be as easy and possible.

> I can certainly see at least the three features proposed here being
> desirable and I'll probably file those as feature enhancements in the
> bugzilla, unless you'd like to?
>
> Any further thoughts on customisations to enable via the GUI?

I can file some enhancement bugs. We are actually brainstorming this
as I type this so I'm sure some more things will come up ;)

-M=



