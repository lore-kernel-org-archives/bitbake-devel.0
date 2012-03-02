Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1S3SjH-0003ch-8g
	for bitbake-devel@lists.openembedded.org;
	Fri, 02 Mar 2012 14:41:03 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 02 Mar 2012 05:32:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="113828726"
Received: from pgsmsx101.gar.corp.intel.com ([10.221.44.78])
	by orsmga001.jf.intel.com with ESMTP; 02 Mar 2012 05:31:30 -0800
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
	PGSMSX101.gar.corp.intel.com (10.221.44.78) with Microsoft SMTP Server
	(TLS) id 14.1.355.2; Fri, 2 Mar 2012 21:31:29 +0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.36]) by
	SHSMSX101.ccr.corp.intel.com ([169.254.1.142]) with mapi id
	14.01.0355.002; Fri, 2 Mar 2012 21:31:28 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: Joshua Lock <josh@linux.intel.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 24/32] Hob(crumbs/hoblistmodel.py): Add
	mapping for rprovides and pkg
Thread-Index: AQHM9ylg21IDBOAIok+/oOv3YE0knZZXAwgw
Date: Fri, 2 Mar 2012 13:31:28 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC23AE016E@SHSMSX102.ccr.corp.intel.com>
References: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
	<5a158f5e8818f75e2938dd6dc3038414ca918212.1330523904.git.shane.wang@intel.com>
	<4F4E98DC.1000007@linux.intel.com>
In-Reply-To: <4F4E98DC.1000007@linux.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Subject: Re: [PATCH 24/32] Hob(crumbs/hoblistmodel.py): Add mapping for rprovides and pkg
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
X-List-Received-Date: Fri, 02 Mar 2012 13:41:03 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Joshua Lock wrote on=A02012-03-01:

>=20
>=20
> On 29/02/12 06:15, Shane Wang wrote:
>> From: Dongxiao Xu<dongxiao.xu@intel.com>
>>=20
>> When checking the package's RDEPENDS information, we will see some case
>> like A RDEPENDS virtual-b, and B RPROVIDES virtual-b, we need to
>> reflect this relationship in packaging selection.
>>=20
>> Signed-off-by: Dongxiao Xu<dongxiao.xu@intel.com>
>> ---
>>   bitbake/lib/bb/ui/crumbs/hoblistmodel.py |   18 +++++++++++++++---
>>   1 files changed, 15 insertions(+), 3 deletions(-)
>> diff --git a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
>> b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py index e440979..e910944
>> 100644 --- a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py +++
>> b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py @@ -51,6 +51,7 @@ class
>> PackageListModel(gtk.TreeStore):
>>           self.pkgs_size =3D 0
>>           self.pn_path =3D {}
>>           self.pkg_path =3D {}
>> +        self.rprov_pkg =3D {}
>>=20
>>           gtk.TreeStore.__init__ (self,
>>                                   gobject.TYPE_STRING,
>> @@ -71,10 +72,18 @@ class PackageListModel(gtk.TreeStore):
>>       Returns the path in the model or None
>>       """
>>       def find_path_for_item(self, item_name):
>> +        pkg =3D item_name +        if item_name =3D=3D
>> "virtual-locale-en-gb": +            print("xdx: item name in
>> pkg_path.keys: %s" % (item_name in self.pkg_path.keys())) +          =20
>> print("xdx: item name in rprov_pkg.keys: %s" %
> (item_name in self.rprov_pkg.keys()))
>=20
> Was this left in on purpose?
>=20

Dongxiao, I guess you forgot to remove debug information;-)

--
Shane


