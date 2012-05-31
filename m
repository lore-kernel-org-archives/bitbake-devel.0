Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]
	helo=tx2outboundpool.messaging.microsoft.com)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <B29882@freescale.com>) id 1SaBiB-0007hV-8K
	for bitbake-devel@lists.openembedded.org;
	Thu, 31 May 2012 22:11:11 +0200
Received: from mail74-tx2-R.bigfish.com (10.9.14.247) by
	TX2EHSOBE010.bigfish.com (10.9.40.30) with Microsoft SMTP Server id
	14.1.225.23; Thu, 31 May 2012 19:45:17 +0000
Received: from mail74-tx2 (localhost [127.0.0.1])	by mail74-tx2-R.bigfish.com
	(Postfix) with ESMTP id C4CD33602E6;
	Thu, 31 May 2012 19:45:16 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:70.37.183.190; KIP:(null); UIP:(null); IPV:NLI;
	H:mail.freescale.net; RD:none; EFVD:NLI
X-SpamScore: -10
X-BigFish: VS-10(zzbb2dI9371I1432N98dKzz1202hzz8275bhz2dh2a8h668h839h8e2h8e3hf0ahbe9i)
Received: from mail74-tx2 (localhost.localdomain [127.0.0.1]) by mail74-tx2
	(MessageSwitch) id 1338493511212325_16842;
	Thu, 31 May 2012 19:45:11 +0000 (UTC)
Received: from TX2EHSMHS020.bigfish.com (unknown [10.9.14.237])	by
	mail74-tx2.bigfish.com (Postfix) with ESMTP id 1D8B32A00B8;
	Thu, 31 May 2012 19:45:11 +0000 (UTC)
Received: from mail.freescale.net (70.37.183.190) by TX2EHSMHS020.bigfish.com
	(10.9.99.120) with Microsoft SMTP Server (TLS) id 14.1.225.23;
	Thu, 31 May 2012 19:45:09 +0000
Received: from 039-SN1MPN1-001.039d.mgd.msft.net ([169.254.1.135]) by
	039-SN1MMR1-001.039d.mgd.msft.net ([10.84.1.13]) with mapi id
	14.02.0298.005; Thu, 31 May 2012 14:45:37 -0500
From: McClintock Matthew-B29882 <B29882@freescale.com>
To: Joshua Lock <josh@linux.intel.com>
Thread-Topic: [bitbake-devel] [PATCH 1/1] bitbake/persist_data: Reconnect
	when DB is locked
Thread-Index: AQHNPsT4hbuVg22/eUC94wQYHGCpi5bkgwgAgAAfCgA=
Date: Thu, 31 May 2012 19:45:37 +0000
Message-ID: <CAEsOVNcFanutPRPNEp7RewgQUxEKE_db8Ep8MOKp2GUpfUJThA@mail.gmail.com>
References: <cover.1326686612.git.lianhao.lu@intel.com>
	<554ae4c9ee0ac70254c6ca6a5ba44db844cf86b3.1326686612.git.lianhao.lu@intel.com>
	<CAEsOVNeBNFH6KbbCUHqEhEjx0dGwzeZ2qCiRc6UirbE_X=1yfQ@mail.gmail.com>
	<4FC7B040.4050106@linux.intel.com>
In-Reply-To: <4FC7B040.4050106@linux.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.112.201.132]
MIME-Version: 1.0
X-OriginatorOrg: freescale.com
Cc: McClintock Matthew-B29882 <B29882@freescale.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 1/1] bitbake/persist_data: Reconnect when DB is locked
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
X-List-Received-Date: Thu, 31 May 2012 20:11:11 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <DCFFE24476036A44ADB0BD90DAC34C09@mgd.freescale.com>
Content-Transfer-Encoding: quoted-printable

On Thu, May 31, 2012 at 12:54 PM, Joshua Lock <josh@linux.intel.com> wrote:
> On 30/05/12 17:33, McClintock Matthew-B29882 wrote:
>>
>> This needs to be in edison-next. It cherry-pick's cleanly as an added
>> plus (doing more testing now). Seems like it's already in denzil-next
>
>
> cherry-picked to my josh/edison branch on poky-contrib - I will try and
> ensure it makes it into the edison branch of the main repository promptly=
.

This has resolved my issue and I've seen no new issues after quite a
bit of building.

-M=



