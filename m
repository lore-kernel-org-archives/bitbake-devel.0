Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1S3ShQ-0003WB-NN
	for bitbake-devel@lists.openembedded.org;
	Fri, 02 Mar 2012 14:39:09 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 02 Mar 2012 05:30:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="113828225"
Received: from pgsmsx101.gar.corp.intel.com ([10.221.44.78])
	by orsmga001.jf.intel.com with ESMTP; 02 Mar 2012 05:29:59 -0800
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
	PGSMSX101.gar.corp.intel.com (10.221.44.78) with Microsoft SMTP Server
	(TLS) id 14.1.355.2; Fri, 2 Mar 2012 21:29:58 +0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.36]) by
	SHSMSX151.ccr.corp.intel.com ([169.254.3.91]) with mapi id
	14.01.0355.002; Fri, 2 Mar 2012 21:29:57 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: Joshua Lock <josh@linux.intel.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 27/32] Hob: add "OK" button to
	"BinbDialog"
Thread-Index: AQHM9ylKzoB1oXYTlE6limZaAWU3T5ZXArlA
Date: Fri, 2 Mar 2012 13:29:56 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC23AE0151@SHSMSX102.ccr.corp.intel.com>
References: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
	<79c20962f88a34c41344c8480aea6368f62c3241.1330523904.git.shane.wang@intel.com>
	<4F4E98CC.8010707@linux.intel.com>
In-Reply-To: <4F4E98CC.8010707@linux.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Subject: Re: [PATCH 27/32] Hob: add "OK" button to	"BinbDialog"
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
X-List-Received-Date: Fri, 02 Mar 2012 13:39:09 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Joshua Lock wrote on=A02012-03-01:

> On 29/02/12 06:15, Shane Wang wrote:
>> From: Dongxiao Xu<dongxiao.xu@intel.com>
>>=20
>> For certain distributions, like FC16, it doesn't have close button in
>> sub-windows or dialogs. Therefore we need to add an "OK" button to
>> "BinbDialog" to close the dialog.
>=20
> If it exists for closing the dialogue it should be a 'Close' button.
>=20
> Cheers,
> Joshua
>

Agree.

--
Shane


