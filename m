Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <lianhao.lu@intel.com>) id 1SFgY1-0000K0-AR
	for bitbake-devel@lists.openembedded.org;
	Thu, 05 Apr 2012 08:51:57 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 04 Apr 2012 23:42:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="85539357"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
	by AZSMGA002.ch.intel.com with ESMTP; 04 Apr 2012 23:42:44 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
	azsmsx601.amr.corp.intel.com (10.2.121.193) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Wed, 4 Apr 2012 23:42:43 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.125]) by
	SHSMSX151.ccr.corp.intel.com ([169.254.3.91]) with mapi id
	14.01.0355.002; Thu, 5 Apr 2012 14:42:40 +0800
From: "Lu, Lianhao" <lianhao.lu@intel.com>
To: Martin Jansa <martin.jansa@gmail.com>
Thread-Topic: [bitbake-devel] bb.utils.vercmp() not consistent with debian
	rules
Thread-Index: Ac0S9GhCT6tSU6xnTdu2BdFPrMkC3P//e9WA//93ZrA=
Date: Thu, 5 Apr 2012 06:42:40 +0000
Message-ID: <857BE142E5399E46B20FD45B9DB8A7BC0FD2D07B@SHSMSX102.ccr.corp.intel.com>
References: <857BE142E5399E46B20FD45B9DB8A7BC0FD2D040@SHSMSX102.ccr.corp.intel.com>
	<20120405062857.GK4181@jama.jama.net>
In-Reply-To: <20120405062857.GK4181@jama.jama.net>
Accept-Language: zh-CN, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "'bitbake-devel@lists.openembedded.org'"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: bb.utils.vercmp() not consistent with debian rules
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
X-List-Received-Date: Thu, 05 Apr 2012 06:51:57 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Martin Jansa wrote on 2012-04-05:
> On Thu, Apr 05, 2012 at 06:22:00AM +0000, Lu, Lianhao wrote:
>> Hi guys,
>>=20
>> When I'm looking at the Yocto bug#2233, I find that the function
>> bb.utils.vercmp() is not consistent with the debian packaging
>> rules(http://www.debian.org/doc/debian-policy/ch-controlfields.html#s-f-
>> Version).
>>=20
>> According to debian rules, "r0" is earlier than "r0-dream", but the bb.u=
tils.vercmp() thinks "r0" is later than "r0-dream".
>=20
> And what about something like this:
>=20
> Version: 3.2-r10
> is older then
> Version: 3.2-r2-oe0

I think this is exactly what the debian rules wants, "3.2-r10">"3.2-r2-oe0"=
. And opkg follows that rule.

The problem is that bb.utils.vercmp thinks "3.2-r2">"3.2-r2-oe0" while opkg=
 thinks "3.2-r2"<"3.2-r2-oe0".

-Lianhao

> At least that was what target opkg was doing for me and I had to bump PE
> http://git.shr-project.org/git/?p=3Dmeta-smartphone.git;a=3Dcommit;h=3Dcb=
119753
> a77208617936085100595e6343ade650
>=20
> Cheers,
>=20
>>=20
>> A pervious patch
>> http://cgit.openembedded.org/bitbake/commit/?id=3D727ce6ffe33a119cb17f7d=
91
>> b173f11a055eea3c seems causing the bb.utils.vercmp to specially handle
>> the separators of "." and "-".
>>=20
>> Is it desired to behave differently from debian rules?
>>=20
>> Best Regards,
>> -Lianhao
>>=20
>> _______________________________________________
>> bitbake-devel mailing list
>> bitbake-devel@lists.openembedded.org
>> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel
>



