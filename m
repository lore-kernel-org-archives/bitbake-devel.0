Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <lianhao.lu@intel.com>) id 1QouBI-0002id-0z
	for bitbake-devel@lists.openembedded.org;
	Thu, 04 Aug 2011 11:25:32 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 04 Aug 2011 02:20:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,315,1309762800"; d="scan'208";a="35037411"
Received: from pgsmsx602.gar.corp.intel.com ([10.221.43.81])
	by azsmga001.ch.intel.com with ESMTP; 04 Aug 2011 02:20:02 -0700
Received: from pgsmsx103.gar.corp.intel.com (10.221.44.82) by
	pgsmsx602.gar.corp.intel.com (10.221.43.81) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Thu, 4 Aug 2011 17:19:19 +0800
Received: from shsmsx601.ccr.corp.intel.com (10.239.4.112) by
	PGSMSX103.gar.corp.intel.com (10.221.44.82) with Microsoft SMTP Server
	(TLS) id 14.1.289.1; Thu, 4 Aug 2011 17:19:19 +0800
Received: from shsmsx502.ccr.corp.intel.com ([10.239.4.96]) by
	shsmsx601.ccr.corp.intel.com ([10.239.4.112]) with mapi; Thu, 4 Aug 2011
	17:19:16 +0800
From: "Lu, Lianhao" <lianhao.lu@intel.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Date: Thu, 4 Aug 2011 17:19:13 +0800
Thread-Topic: when does ${XX}  in variable names get expanded?
Thread-Index: AcxSh5Nf7jWXOjwbRlWzF/2wIOKQ7w==
Message-ID: <C10D3FB0CD45994C8A51FEC1227CE22F2CE2E480D0@shsmsx502.ccr.corp.intel.com>
Accept-Language: zh-CN, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-cr-hashedpuzzle: sCA= AUNg Ah+O BQr+ BoGh B9Ee CbzI EtSX EwKz FDJm GsHO
	H6gm IUE0 I6yP JPgZ K0Y9; 1;
	YgBpAHQAYgBhAGsAZQAtAGQAZQB2AGUAbABAAGwAaQBzAHQAcwAuAG8AcABlAG4AZQBtAGIAZQBkAGQAZQBkAC4AbwByAGcA;
	Sosha1_v1; 7; {CBB00368-56E2-4050-97B5-FABEC8D40CD1};
	bABpAGEAbgBoAGEAbwAuAGwAdQBAAGkAbgB0AGUAbAAuAGMAbwBtAA==; Thu,
	04 Aug 2011 09:19:13 GMT;
	dwBoAGUAbgAgAGQAbwBlAHMAIAAkAHsAWABYAH0AIAAgAGkAbgAgAHYAYQByAGkAYQBiAGwAZQAgAG4AYQBtAGUAcwAgAGcAZQB0ACAAZQB4AHAAYQBuAGQAZQBkAD8A
x-cr-puzzleid: {CBB00368-56E2-4050-97B5-FABEC8D40CD1}
acceptlanguage: zh-CN, en-US
MIME-Version: 1.0
Subject: when does ${XX} in variable names get expanded?
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
X-List-Received-Date: Thu, 04 Aug 2011 09:25:32 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi guys,

For the following variable definition in bitbake,

VVV =3D "llu"
A_${VVV} =3D "VVV"
A_llu =3D "llu"

B =3D "${@bb.data.getVar('A_llu', d, True)}"
C :=3D "${@bb.data.getVar('A_llu', d, True)}"

Why B is "VVV" and C is "llu" in final? I'm wondering when is the ${VVV} in=
 the variable name of A_${VVV} expanded.

Best Regards,
-Lianhao Lu


