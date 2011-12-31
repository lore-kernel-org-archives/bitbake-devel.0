Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <lianhao.lu@intel.com>) id 1Rgv2p-0005sw-OV
	for bitbake-devel@lists.openembedded.org;
	Sat, 31 Dec 2011 10:16:03 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 31 Dec 2011 01:08:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="91700167"
Received: from pgsmsx601.gar.corp.intel.com ([10.221.43.69])
	by orsmga001.jf.intel.com with ESMTP; 31 Dec 2011 01:08:45 -0800
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
	pgsmsx601.gar.corp.intel.com (10.221.43.69) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Sat, 31 Dec 2011 17:08:44 +0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.199]) by
	SHSMSX101.ccr.corp.intel.com ([169.254.1.38]) with mapi id
	14.01.0355.002; Sat, 31 Dec 2011 17:08:42 +0800
From: "Lu, Lianhao" <lianhao.lu@intel.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: RFC - avoid "database is locked" exception in persistent_data.py
Thread-Index: AczHm8kk5KcqRGNOT4q+4Zwoy9th9Q==
Date: Sat, 31 Dec 2011 09:08:42 +0000
Message-ID: <857BE142E5399E46B20FD45B9DB8A7BC010F19@SHSMSX102.ccr.corp.intel.com>
Accept-Language: zh-CN, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "Lock, Joshua" <joshua.lock@intel.com>
Subject: RFC - avoid "database is locked" exception in persistent_data.py
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
X-List-Received-Date: Sat, 31 Dec 2011 09:16:04 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi guys,

We sometimes met "OperationalError: database is locked" exceptions in persi=
st_data.py=20
during the bitbake parsing the recipes. It seems this is caused by a burst =
of reads/writes to the=20
database during the recipe parsing time. http://bugzilla.pokylinux.org/show=
_bug.cgi?id=3D1761=20

It seems to me that the only way to avoid this kind of exception completely=
 in bitbake is to
serialize the access to the database by using some kind of multiprocess loc=
k in SQLTable._execute()=20
to make sure only one process is executing the SQL statement. Though this h=
as performance penalty,
but in bitbake case, it only increase the parsing time less than 0.3 second=
s out of a total 21 seconds.

Another way is to increase the current retry count from 500 to a very large=
 number or to infinite. But I'm
not sure whether there are other situations might raise the same exception =
in which case we do need to
throw it out instead of to continuously retry.

Any comment?

Best Regards,
-Lianhao Lu


