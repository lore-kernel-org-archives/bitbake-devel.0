Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <lianhao.lu@intel.com>) id 1SFgF2-00007O-IJ
	for bitbake-devel@lists.openembedded.org;
	Thu, 05 Apr 2012 08:32:20 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 04 Apr 2012 23:22:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="127331170"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
	by azsmga001.ch.intel.com with ESMTP; 04 Apr 2012 23:22:03 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
	azsmsx601.amr.corp.intel.com (10.2.121.193) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Wed, 4 Apr 2012 23:22:02 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.125]) by
	SHSMSX151.ccr.corp.intel.com ([169.254.3.91]) with mapi id
	14.01.0355.002; Thu, 5 Apr 2012 14:22:01 +0800
From: "Lu, Lianhao" <lianhao.lu@intel.com>
To: "'bitbake-devel@lists.openembedded.org'"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: bb.utils.vercmp() not consistent with debian rules
Thread-Index: Ac0S9GhCT6tSU6xnTdu2BdFPrMkC3A==
Date: Thu, 5 Apr 2012 06:22:00 +0000
Message-ID: <857BE142E5399E46B20FD45B9DB8A7BC0FD2D040@SHSMSX102.ccr.corp.intel.com>
Accept-Language: zh-CN, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Subject: bb.utils.vercmp() not consistent with debian rules
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
X-List-Received-Date: Thu, 05 Apr 2012 06:32:20 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi guys,

When I'm looking at the Yocto bug#2233, I find that the function bb.utils.v=
ercmp() is not consistent with the debian packaging rules(http://www.debian=
.org/doc/debian-policy/ch-controlfields.html#s-f-Version).=20

According to debian rules, "r0" is earlier than "r0-dream", but the bb.util=
s.vercmp() thinks "r0" is later than "r0-dream".

A pervious patch http://cgit.openembedded.org/bitbake/commit/?id=3D727ce6ff=
e33a119cb17f7d91b173f11a055eea3c seems causing the bb.utils.vercmp to speci=
ally handle the separators of "." and "-".=20

Is it desired to behave differently from debian rules?

Best Regards,
-Lianhao


