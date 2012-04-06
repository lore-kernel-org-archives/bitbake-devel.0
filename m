Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <lianhao.lu@intel.com>) id 1SFzYz-0006zA-IM
	for bitbake-devel@lists.openembedded.org;
	Fri, 06 Apr 2012 05:10:13 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 05 Apr 2012 20:00:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="85931915"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
	by AZSMGA002.ch.intel.com with ESMTP; 05 Apr 2012 20:00:45 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
	azsmsx601.amr.corp.intel.com (10.2.121.193) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Thu, 5 Apr 2012 20:00:45 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.125]) by
	SHSMSX101.ccr.corp.intel.com ([169.254.1.142]) with mapi id
	14.01.0355.002; Fri, 6 Apr 2012 11:00:43 +0800
From: "Lu, Lianhao" <lianhao.lu@intel.com>
To: "'bitbake-devel@lists.openembedded.org'"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] bb.utils.vercmp() not consistent with debian
	rules
Thread-Index: Ac0S9GhCT6tSU6xnTdu2BdFPrMkC3P//e9WA//93ZrCAAOogAIAAC5qA//9ttVD//f16EA==
Date: Fri, 6 Apr 2012 03:00:43 +0000
Message-ID: <857BE142E5399E46B20FD45B9DB8A7BC0FD2EEE6@SHSMSX102.ccr.corp.intel.com>
References: <857BE142E5399E46B20FD45B9DB8A7BC0FD2D040@SHSMSX102.ccr.corp.intel.com>
	<20120405062857.GK4181@jama.jama.net>
	<857BE142E5399E46B20FD45B9DB8A7BC0FD2D07B@SHSMSX102.ccr.corp.intel.com>
	<1333628280.6300.6.camel@ted> <1333630771.6300.12.camel@ted>
	<857BE142E5399E46B20FD45B9DB8A7BC0FD2D363@SHSMSX102.ccr.corp.intel.com>
In-Reply-To: <857BE142E5399E46B20FD45B9DB8A7BC0FD2D363@SHSMSX102.ccr.corp.intel.com>
Accept-Language: zh-CN, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
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
X-List-Received-Date: Fri, 06 Apr 2012 03:10:13 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Lu, Lianhao wrote on 2012-04-05:
>=20
> Richard Purdie wrote on 2012-04-05:
>> On Thu, 2012-04-05 at 13:18 +0100, Richard Purdie wrote:
>>=20
>> So just to be clear, we have various version sorting algorithms:
>>=20
>> * opkg
>> * opkg-compare-versions (which has a C version and a shell version!)
>> * bb.utils.vercmp()
>> * bb.utils.vercmp_string()
>>=20
>> and all these functions *need* to be consistent. Consistent is defined
>> in this case as following the Debian version policy. This is ignoring
>> the other package backends. dpkg should "just work", rpm can be
>> programmed to use any algorithm and is probably not consistent with this
>> at this point but we should probably ignore that in the equation at this
>> point.
>>=20
>> So the question is, which of the above are consistent or inconsistent
>> with each other (and dpkg), and how they are inconsistent. We can then
>> consider what to do about it.
>>=20
>=20
> The difference between those is how to treat "separators" in version comp=
are.
> Take 2 examples, v1=3D"3.2-r2-oe0", v1'=3D"3.2-r2"; v2=3D"4.4-r8-oe0", v2=
'=3D"4.4-r8a"
>=20
> The Debian version policy says, "...so that all the letters sort earlier =
than all
> the non-letters and so that a tilde sorts before anything, even the end o=
f a part."
> So v1>v1', v2>v2'.
>=20
> The opkg follows the Debian rules, and reports v1>v1', v2>v2'. dpkg repor=
ts the same.
>=20
> The C version of opkg-compare-versions reports v1>v1', v2<v2'. (The shell=
 version do
> NOT have the function of comparison).
It turns out the opkg-compare-version is still using the source code from a=
 very opkg
implementation. The opkg upstream has changed that in svn revision r40,=20
http://code.google.com/p/opkg/source/detail?r=3D40&path=3D/trunk/libopkg/pk=
g.c.=20

>=20
> The bb.utils.vercmp() reports v1<v1', v2<v2'. It treats all separators(i.=
e. "." and "-") as tilde
> in Debian rules. The bb.utils.vercmp is used both by bitbake internally a=
nd bbclass.
>=20
> The bb.utils.vercmp_string() does NOT accept version string containing se=
gments starting with
> non-digital character. bb.utils.vercmp_string seems never being actually =
called.
>=20
> Seems we have nothing consistent here. :-(
>=20
> - Lianhao
>=20
>=20



