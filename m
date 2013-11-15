Return-Path: <cristiana.voicu@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 8990E6D746
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Nov 2013 11:48:52 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 15 Nov 2013 03:48:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,535,1378882800"; d="scan'208";a="409313144"
Received: from irsmsx101.ger.corp.intel.com ([163.33.3.153])
	by orsmga001.jf.intel.com with ESMTP; 15 Nov 2013 03:48:53 -0800
Received: from irsmsx151.ger.corp.intel.com (163.33.192.59) by
	IRSMSX101.ger.corp.intel.com (163.33.3.153) with Microsoft SMTP Server
	(TLS) id 14.3.123.3; Fri, 15 Nov 2013 11:47:05 +0000
Received: from irsmsx105.ger.corp.intel.com ([169.254.7.215]) by
	IRSMSX151.ger.corp.intel.com ([169.254.4.126]) with mapi id
	14.03.0123.003; Fri, 15 Nov 2013 11:47:05 +0000
From: "Voicu, Cristiana" <cristiana.voicu@intel.com>
To: "Voicu, Cristiana" <cristiana.voicu@intel.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [PATCH] toaster: convert build_package size to bytes to keep
	consistence
Thread-Index: AQHO37XK6FkDNNJ1VE+7Bf2f03fMPZomMRVg
Date: Fri, 15 Nov 2013 11:47:04 +0000
Message-ID: <BE68E9C8E0850C43B0F0B0B7D57FA5AE2E8B0B60@IRSMSX105.ger.corp.intel.com>
References: <1384267824-19862-1-git-send-email-cristiana.voicu@intel.com>
In-Reply-To: <1384267824-19862-1-git-send-email-cristiana.voicu@intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [163.33.239.181]
MIME-Version: 1.0
Subject: Re: [PATCH] toaster: convert build_package size to bytes to keep consistence
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 15 Nov 2013 11:48:53 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Richard,

This was merged to master, and it should be merged to dora-toaster branch t=
oo.
Can you please merge it?
Thanks,
Cristiana


-----Original Message-----
From: Voicu, Cristiana=20
Sent: Tuesday, November 12, 2013 4:50 PM
To: bitbake-devel@lists.openembedded.org
Cc: Voicu, Cristiana
Subject: [PATCH] toaster: convert build_package size to bytes to keep consi=
stence

[YOCTO #5503]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py               |    2 +-
 .../lib/toaster/bldviewer/templates/bpackage.html  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/build=
infohelper.py
index c3809ef..6dcf459 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -186,7 +186,7 @@ class ORMWrapper(object):
                                        revision =3D package_info['PKGR'],
                                        summary =3D package_info['SUMMARY']=
,
                                        description =3D package_info['DESCR=
IPTION'],
-                                       size =3D package_info['PKGSIZE'],
+                                       size =3D=20
+ int(package_info['PKGSIZE']) * 1024,
                                        section =3D package_info['SECTION']=
,
                                        license =3D package_info['LICENSE']=
,
                                        ) diff --git a/bitbake/lib/toaster/=
bldviewer/templates/bpackage.html b/bitbake/lib/toaster/bldviewer/templates=
/bpackage.html
index 2e254db..4e6d9c6 100644
--- a/bitbake/lib/toaster/bldviewer/templates/bpackage.html
+++ b/bitbake/lib/toaster/bldviewer/templates/bpackage.html
@@ -13,7 +13,7 @@
             <th>Summary</th>
             <th>Section</th>
             <th>Description</th>
-            <th>Size on host disk (KBytes)</th>
+            <th>Size on host disk (Bytes)</th>
             <th>License</th>
             <th>Dependencies List (all)</th>
             </tr>
--
1.7.9.5


