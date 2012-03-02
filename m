Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1S3MvE-0000oD-OL
	for bitbake-devel@lists.openembedded.org;
	Fri, 02 Mar 2012 08:29:00 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 01 Mar 2012 23:20:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="124054942"
Received: from pgsmsx509.gar.corp.intel.com ([172.30.13.17])
	by fmsmga001.fm.intel.com with ESMTP; 01 Mar 2012 23:20:28 -0800
Received: from pgsmsx152.gar.corp.intel.com (172.30.236.43) by
	PGSMSX509.gar.corp.intel.com (172.30.13.17) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Fri, 2 Mar 2012 15:19:53 +0800
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
	PGSMSX152.gar.corp.intel.com (172.30.236.43) with Microsoft SMTP Server
	(TLS) id 14.1.355.2; Fri, 2 Mar 2012 15:19:52 +0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.36]) by
	SHSMSX101.ccr.corp.intel.com ([169.254.1.142]) with mapi id
	14.01.0355.002; Fri, 2 Mar 2012 15:19:51 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: Joshua Lock <josh@linux.intel.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 01/32] Hob: make HobViewTable more
	general in hob and make the image selection dialog and the image
	details page reuse it.
Thread-Index: AQHM9ykVzzpQoXvjiEKuIs4nrqT525ZWmWSA
Date: Fri, 2 Mar 2012 07:19:50 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC23ADFD0C@SHSMSX102.ccr.corp.intel.com>
References: <cover.1330523904.git.shane.wang@intel.com>
	<439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
	<4F4E9870.6070900@linux.intel.com>
In-Reply-To: <4F4E9870.6070900@linux.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Subject: Re: [PATCH 01/32] Hob: make HobViewTable more general in hob and make the image selection dialog and the image details page reuse it.
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
X-List-Received-Date: Fri, 02 Mar 2012 07:29:00 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Joshua Lock wrote on=A02012-03-01:
>>           for i in range(len(columns)):
>>               col =3D gtk.TreeViewColumn(columns[i]['col_name'])
>>               col.set_clickable(True)
>>               col.set_resizable(True)
>>               col.set_sort_column_id(columns[i]['col_id'])
>> -            col.set_min_width(columns[i]['col_min'])
>> -            col.set_max_width(columns[i]['col_max'])
>=20
> There are a few calls to columns[i].keys() below, I'd recommend making
> the call once per iteration and assigning it to a variable.

OK, will address that later in a separate patch.

>=20
> Usually in Python we'd just do a boolean test on the object like:
>=20
> 		if widget:
> 			row =3D 1
> 		elif varlist and vallist:
> 			row =3D len(varlist)
>=20
If it is the style, I can change that some time later.
But I have to say, using "if widget:" is not save enough.
I have even used "if var:" to test "if var !=3D None" but unfortunately var=
 !=3D None but =3D 0, since var is an integer in that case.
Python is so free without type checking than C++.


>> hbox =3D gtk.HBox(False, 5)
>=20
> *Beep* 5 for padding? :-)

OK, 6

--
Shane


