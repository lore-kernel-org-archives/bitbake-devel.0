Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1S3MR2-0008Ty-Oa
	for bitbake-devel@lists.openembedded.org;
	Fri, 02 Mar 2012 07:57:48 +0100
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 01 Mar 2012 22:49:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="72667338"
Received: from pgsmsx102.gar.corp.intel.com ([10.221.44.80])
	by AZSMGA002.ch.intel.com with ESMTP; 01 Mar 2012 22:49:16 -0800
Received: from pgsmsx103.gar.corp.intel.com (10.221.44.82) by
	PGSMSX102.gar.corp.intel.com (10.221.44.80) with Microsoft SMTP Server
	(TLS) id 14.1.355.2; Fri, 2 Mar 2012 14:48:16 +0800
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
	PGSMSX103.gar.corp.intel.com (10.221.44.82) with Microsoft SMTP Server
	(TLS) id 14.1.355.2; Fri, 2 Mar 2012 14:48:16 +0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.36]) by
	SHSMSX151.ccr.corp.intel.com ([169.254.3.91]) with mapi id
	14.01.0355.002; Fri, 2 Mar 2012 14:48:14 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: Joshua Lock <josh@linux.intel.com>
Thread-Topic: [PATCH 00/32] Hob related fixes
Thread-Index: AQHM9yjraam7TfGo8kGrrffqjCTrtZZWkbCg
Date: Fri, 2 Mar 2012 06:48:14 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC23ADFC53@SHSMSX102.ccr.corp.intel.com>
References: <cover.1330523904.git.shane.wang@intel.com>
	<4F4E9837.7080602@linux.intel.com>
In-Reply-To: <4F4E9837.7080602@linux.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "An, LimingX L" <limingx.l.an@intel.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 00/32] Hob related fixes
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
X-List-Received-Date: Fri, 02 Mar 2012 06:57:49 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Joshua Lock wrote on=A02012-03-01:
> One thing I did notice whilst reviewing this series is that there's a
> lot of this anti-pattern in the hob 2 code:
> 	for i in range(len(mylist)):
> rather than:
> 	for item in list:
>=20
> Can we make an effort to tidy those up?
I will check those later. I went through them quickly.
Some of them are because the code refers to the index i.

Otherwise, we would have the code.
i =3D 0
for item in list:
 XXXXX
 XXX =3D i
 i +=3D 1

which also looks not perfect. But anyway, I will check all of them later an=
d send another patch for improvement.
If there is no reference to the index, I will replace with your style.

--
Shane

>=20
> Cheers,
> Joshua



