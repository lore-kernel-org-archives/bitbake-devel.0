Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1S3SlY-0003fo-QA
	for bitbake-devel@lists.openembedded.org;
	Fri, 02 Mar 2012 14:43:24 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 02 Mar 2012 05:34:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="124159146"
Received: from pgsmsx509.gar.corp.intel.com ([172.30.13.17])
	by fmsmga001.fm.intel.com with ESMTP; 02 Mar 2012 05:34:52 -0800
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
	PGSMSX509.gar.corp.intel.com (172.30.13.17) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Fri, 2 Mar 2012 21:34:31 +0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.36]) by
	SHSMSX101.ccr.corp.intel.com ([169.254.1.142]) with mapi id
	14.01.0355.002; Fri, 2 Mar 2012 21:34:30 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: Joshua Lock <josh@linux.intel.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 07/32] Hob: use HobNotebook to enable a
	notebook in build details page
Thread-Index: AQHM9ym6PamKfj+HtUi/gYWrpftJ8JZXA+hA
Date: Fri, 2 Mar 2012 13:34:29 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC23AE018D@SHSMSX102.ccr.corp.intel.com>
References: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
	<1239984c43d315bad4de8834690222e06c951977.1330523904.git.shane.wang@intel.com>
	<4F4E997E.4000403@linux.intel.com>
In-Reply-To: <4F4E997E.4000403@linux.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Subject: Re: [PATCH 07/32] Hob: use HobNotebook to enable a notebook in build details page
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
X-List-Received-Date: Fri, 02 Mar 2012 13:43:25 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Joshua Lock wrote on=A02012-03-01:

>=20
>=20
> On 29/02/12 06:15, Shane Wang wrote:
>> This patch is to use HobNotebook we defined to implement the notebook
>> in the build details page. And more the "build configuration" tab and
>> the "issues" tab use more tree
> views which we implemented in runningbuild.py.
>=20
> This should probably be two patches? I've raised concerns about the
> HobNoteBook in the patch introducing it.
>=20
> Cheers,
> Joshua

We should evaluate it.

--
Shane


