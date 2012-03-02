Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1S3My0-0000qm-Mf
	for bitbake-devel@lists.openembedded.org;
	Fri, 02 Mar 2012 08:31:52 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 01 Mar 2012 23:23:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="113697967"
Received: from pgsmsx102.gar.corp.intel.com ([10.221.44.80])
	by azsmga001.ch.intel.com with ESMTP; 01 Mar 2012 23:23:20 -0800
Received: from pgsmsx151.gar.corp.intel.com (172.30.236.41) by
	PGSMSX102.gar.corp.intel.com (10.221.44.80) with Microsoft SMTP Server
	(TLS) id 14.1.355.2; Fri, 2 Mar 2012 15:22:34 +0800
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
	PGSMSX151.gar.corp.intel.com (172.30.236.41) with Microsoft SMTP Server
	(TLS) id 14.1.355.2; Fri, 2 Mar 2012 15:22:34 +0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.36]) by
	SHSMSX151.ccr.corp.intel.com ([169.254.3.91]) with mapi id
	14.01.0355.002; Fri, 2 Mar 2012 15:22:33 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: Joshua Lock <josh@linux.intel.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 04/32] Hob: fixed the issue in the
	brought-in-by dialog.
Thread-Index: AQHM9yklhx3rtclQTU2100wWd8K2PpZWm8zg
Date: Fri, 2 Mar 2012 07:22:32 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC23ADFD13@SHSMSX102.ccr.corp.intel.com>
References: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
	<660576fe6e84608bbf4d7237f5804cfd244029cd.1330523904.git.shane.wang@intel.com>
	<4F4E9885.6090705@linux.intel.com>
In-Reply-To: <4F4E9885.6090705@linux.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Subject: Re: [PATCH 04/32] Hob: fixed the issue in the brought-in-by dialog.
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
X-List-Received-Date: Fri, 02 Mar 2012 07:31:52 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Joshua Lock wrote on=A02012-03-01:

>=20
>=20
> On 29/02/12 06:15, Shane Wang wrote:
>> When typing any thing in the search entry, the brough-in-by dialog will =
be
> shown. That is because we call back "selection-changed" signal to pop up =
the
> dialog, which is not correct.
>> This patch is to fix the problem by using "row-activated" signal.
>>=20
>> Signed-off-by: Liming An<limingx.l.an@intel.com>
>> Signed-off-by: Shane Wang<shane.wang@intel.com>
>=20
> I point out some incorrect padding below but other than that:
> Signed-off-by: Joshua Lock <josh@linux.intel.com>

OK, Got it. May I know why padding=3D6 only conforms to hig?

--
Shane


