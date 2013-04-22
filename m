Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]
	helo=va3outboundpool.messaging.microsoft.com)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <B43198@freescale.com>) id 1UUIrQ-0005L3-Vn
	for bitbake-devel@lists.openembedded.org;
	Mon, 22 Apr 2013 17:40:57 +0200
Received: from mail65-va3-R.bigfish.com (10.7.14.231) by
	VA3EHSOBE001.bigfish.com (10.7.40.21) with Microsoft SMTP Server id
	14.1.225.23; Mon, 22 Apr 2013 14:22:53 +0000
Received: from mail65-va3 (localhost [127.0.0.1])	by mail65-va3-R.bigfish.com
	(Postfix) with ESMTP id EA2064C0310;
	Mon, 22 Apr 2013 14:22:52 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:70.37.183.190; KIP:(null); UIP:(null); IPV:NLI;
	H:mail.freescale.net; RD:none; EFVD:NLI
X-SpamScore: -3
X-BigFish: VS-3(zzbb2dI98dI9371I1432Izz1f42h1fc6h1ee6h1de0h1fdah1202h1e76h1d1ah1d2ahzzz2dh2a8h668h839h8e2h8e3h947hd25hf0ah1288h12a5h12a9h12bdh137ah13b6h1441h1504h1537h153bh15d0h162dh1631h1758h18e1h1946h19b5h1ad9h1b0ahbe9i1155h)
Received: from mail65-va3 (localhost.localdomain [127.0.0.1]) by mail65-va3
	(MessageSwitch) id 1366640571756692_19664;
	Mon, 22 Apr 2013 14:22:51 +0000 (UTC)
Received: from VA3EHSMHS023.bigfish.com (unknown [10.7.14.249])	by
	mail65-va3.bigfish.com (Postfix) with ESMTP id A29B4180086;
	Mon, 22 Apr 2013 14:22:51 +0000 (UTC)
Received: from mail.freescale.net (70.37.183.190) by VA3EHSMHS023.bigfish.com
	(10.7.99.33) with Microsoft SMTP Server (TLS) id 14.1.225.23;
	Mon, 22 Apr 2013 14:22:46 +0000
Received: from 039-SN2MPN1-023.039d.mgd.msft.net ([169.254.3.123]) by
	039-SN1MMR1-004.039d.mgd.msft.net ([::1]) with mapi id 14.02.0328.011;
	Mon, 22 Apr 2013 14:22:46 +0000
From: Purcareata Bogdan-B43198 <B43198@freescale.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Thread-Topic: [bitbake-devel] bitbake clean / cleanall / cleansstate not
	working
Thread-Index: Ac47T+pIaPJdHV4DTyGjcsswekyYHwCSlcCAAGjAqmAAAwN/AAAG4jYA
Date: Mon, 22 Apr 2013 14:22:45 +0000
Message-ID: <E7E317BD5B5D764682EEAC13B01676E2676093@039-SN2MPN1-023.039d.mgd.msft.net>
References: <E7E317BD5B5D764682EEAC13B01676E2650BB2@039-SN2MPN1-021.039d.mgd.msft.net>
	<1366443597.10502.140.camel@ted>
	<E7E317BD5B5D764682EEAC13B01676E26731F2@039-SN2MPN1-023.039d.mgd.msft.net>
	<3109661.1Vn9mzWreB@helios>
In-Reply-To: <3109661.1Vn9mzWreB@helios>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.171.74.6]
MIME-Version: 1.0
X-OriginatorOrg: freescale.com
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: bitbake clean / cleanall / cleansstate not working
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 22 Apr 2013 15:40:57 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <E323FD11B62E6C4BB0B70D26F2453823@mgd.freescale.com>
Content-Transfer-Encoding: quoted-printable

On 4/22/2013 2:05 PM, Paul Eggleton wrote:
> On Monday 22 April 2013 09:42:07 Purcareata Bogdan-B43198 wrote:
>> Richard Purdie wrote:
>>> What exactly are you trying to clean? The above messages say it ran 1, =
2
>>> or 3 tasks and they all succeeded.
>> In my example, "gcc" can be replaced with any package provided by the Yo=
cto
>> recipes. The problem is that nothing is being run - "0 didn't need to be
>> rerun " - so the built package is never cleaned. This issue is present w=
hen
>> running all clean commands - clean, cleanall, cleansstate.
> "0 didn't need to be rerun" does not mean nothing was done - it means the
> opposite. The number reported here is the number of tasks that were able =
to be
> restored from shared state - none (0) in this case because this is not
> applicable to the clean* tasks.
>
> Other than the message above, how are you determining that these tasks ar=
e not
> doing anything?

Thank you for the fast reply!

I've run some more tests and found some new stuff.

I'm running this:
     bitbake <package>
     bitbake -c cleanall <package>
     bitbake <package>

My expected result was that, at the second run of bitbake <package>, the=20
whole package will be built again starting from fetch. While this is=20
true for packages such as gcc or busybox, it's not true for the lxc=20
package - this one starts from do_populate_sysroot (or somewhere near, I=20
can't seem to tell since it's running very fast). I discovered this=20
while developing some patches for the lxc recipe. I was hoping to see=20
the functionality applied after clean and build, but it was not there.

When I saw "0 didn't need to be rerun " after bitbake cleanall, I=20
thought it didn't run anything - now I understand what it means. I=20
noticed this behavior for other packages as well, so I didn't bother to=20
build the packages after clean, since I thought cleaning was the problem.

Do you think this behavior is recipe dependent?

>
>>> Keep in mind there are several "gcc" components such as gcc-cross,
>>> gcc-cross-initial and so on. "gcc" is the one used on target.
>> Do you think that a certain package can't be cleaned because of its
>> dependencies?
> No, that's very unlikely to be the case.
>
> Cheers,
> Paul
>



