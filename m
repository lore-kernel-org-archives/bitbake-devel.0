Received: from NAM04-SN1-obe.outbound.protection.outlook.com (NAM04-SN1-obe.outbound.protection.outlook.com [40.107.70.43])
 by mx.groups.io with SMTP id smtpd.web11.5893.1602738860362542361
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 14 Oct 2020 22:14:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriversystems.onmicrosoft.com header.s=selector2-windriversystems-onmicrosoft-com header.b=UK+zcNo5;
 spf=pass (domain: windriver.com, ip: 40.107.70.43, mailfrom: david.reyna@windriver.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhIHOCoe4J/mF/zqHf+fXELQ3HtPncOKtX0UsYGaKeG7/+fBPDoVqg4svwKfNrBYelzq9eZiTFz+x4+ckU718CNocDU73yzbYZtQUOJBHxqAyjDu85amsUI2GUIXTip8tAtrzG/MUO8w1t+dYX3RTkYRLURWHh01p+KnXWD3ScwFO9vsaLvJBlF67dfq78S8do1XJsN6LD8zGMPD9y9YRDazfK+fw8O6X2FyMn7f+kS7z/zkHhQjCsEdlPT/4zde7sojATz98BLCCSJ4cMt1I8WRVxvJVq839il04ikQl9Jb+P/70O9vNWDsBlHNXYXKbwM3In81Y2bxMmdHDMpmXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtHr3m7rTDgJKnxo6YQfZF6D4dMlGYvNmlnmfmhsL/w=;
 b=jhn54ndZnwGSWAchxdUVHMuzLrcr169FWFsS28i15POV+u+9HXHR8wXgIfRn787R98rnMg4gXRH+tpsMmzrj2cRoelyJLeh2KQbAhdgVxbk0pGZ1NN6TJrUk1yz+UfxpxJN/F71y8KkJy9rp+xrc4/5Qvfd4nJaDZVB00Ehe5SJ8mvsQoif2W2APSi0w7gYiJkefOan/EDo/oMJcJjWvHd51kbtrkXIOjcXtWIKywP0032wgV5s2Xzi8Zw3TpY13yvabeED2pTtWstAcuxkOHicvGU58YGq/Lqrqm7id9XFYtdWlTojdppV8gqoCurxpnqqCWc1cZCTcClUd02LRVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtHr3m7rTDgJKnxo6YQfZF6D4dMlGYvNmlnmfmhsL/w=;
 b=UK+zcNo5fQlLqFqSEabCYkRSFG5bgTe3dQCc98f8aWlZbmpSCStdlJ9aomSBlACDpDMCp6I7Za6inN1tjPpHvkXZTpKPWQ3BDXdTLFi7bhAGkcA7TW1S3QFcBKXo2L1/EImSchE6Mhru731+vcYIfB3tpEjoG1QKh5gjpprR0Nc=
Received: from BY5PR11MB4167.namprd11.prod.outlook.com (2603:10b6:a03:185::28)
 by BYAPR11MB3654.namprd11.prod.outlook.com (2603:10b6:a03:b2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Thu, 15 Oct
 2020 05:14:19 +0000
Received: from BY5PR11MB4167.namprd11.prod.outlook.com
 ([fe80::a567:83cb:6eae:d661]) by BY5PR11MB4167.namprd11.prod.outlook.com
 ([fe80::a567:83cb:6eae:d661%6]) with mapi id 15.20.3477.021; Thu, 15 Oct 2020
 05:14:18 +0000
From: "Reyna, David" <david.reyna@windriver.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
CC: Tim Orling <timothy.t.orling@linux.intel.com>
Subject: [bitbake-devel] [PATCH] ] toaster: Enable Gatesgarth branch in place of Zeus
Thread-Topic: [bitbake-devel] [PATCH] ] toaster: Enable Gatesgarth branch in
 place of Zeus
Thread-Index: Adaisd2ub4qZBqVDSfG6X2CY4Tg8Jg==
Date: Thu, 15 Oct 2020 05:14:18 +0000
Message-ID: 
 <BY5PR11MB4167CB748681B853DA026C90EA020@BY5PR11MB4167.namprd11.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.openembedded.org; dkim=none (message not signed)
 header.d=none;lists.openembedded.org; dmarc=none action=none
 header.from=windriver.com;
x-originating-ip: [71.202.37.249]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d1cf653-b72c-4b79-2b85-08d870c92b45
x-ms-traffictypediagnostic: BYAPR11MB3654:
x-microsoft-antispam-prvs: 
 <BYAPR11MB36548F24EBE1C8D9A8F744DEEA020@BYAPR11MB3654.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 K+n7LVxY3cEpFT3DerMRLado0/csm1o5aMe8pjtJA7Jn0v6IP1SiAmWoX3KsYRFaZiU0hafZTpLCPc2Yzqxtsc6BA2dkwXh6LzCo8mfP8xw6tV8xe1zgNjhEjSAS/BalKmnrBjB0dKwZTgYxsKPpt2KQqC9xM1tNXXhHw5mO/fTnhdI364a0PQSVj5hoCCwlnP/HDLWkAXBGOcVe6ewGFSvfMVD/FCz5m8eKWgw27nOgs6FBUFpSL5rpaBaqcw2maJOqYsbtqKPjz0xv27jOx9o8tz299GYqkXmi8GZ4I/3RSGlB8niS84E2QjKyA0iGADHhruxmY631N2dBxyqcy3z089fwVl6nCo2aHXSs2Lrrl2x5fatxN3psoQeo/QECo5rsyY9N21ktAHPODiidgg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4167.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(376002)(366004)(136003)(346002)(5660300002)(66556008)(2906002)(6916009)(66446008)(83080400001)(66946007)(8936002)(66476007)(64756008)(71200400001)(83380400001)(76116006)(316002)(186003)(6506007)(478600001)(55016002)(8676002)(4326008)(7696005)(52536014)(26005)(33656002)(9686003)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 m/Sd+tW4+dIp08jS4dV/oTXwEU0HAUhn+WZunsSedtmZ34OPWj74oPwrDSLPS5tSjI0DYs9pBHnXrn7SxsTpKAdIh+r+WBukkuldLSBC0+NdKYd0lJiSou12mogI82DDuvJE17boOXvK/bKRMuyvKVQYpjmDWS08FH/+B6Ea5ctv+KYUlf2RV8BSSSJoXIUcVzd2r+CphB2wVniRnigQRMFCz4vFpGohu4r5C2ipSh6H8z9x3LYUl7tI72LL5IzXCWd0Jxnn1fE4/HmzSSP/mHbyIz0UcfqEZa5M8dF0zDsZJhRW4tMEqtpq2iZ35zCdiIwHdcChjPWsUnECjVh+zLvjuQpqiCiOjtUz+3qUUoroYN2HGmoTXMLSQ1+i11Cm7lUrbysEGmjXjnoPZD1ig0X5JPB5BAfLF2DvnuphrYPqtdRRjiTn7p51r20cfw44YAf1DhxmQ9TQ7/O0tgEuogbKzpxeEX/LLeRLuxg5xVNdaD6xPj6eLdOPhHwEOgxF81Ic8uAc/L7Cdu6tHgNKH89kyeilnI4qOY8gio+3PZSD4hOMp/ByhhrzBtoG/I5/F7dAIpcfEPYpIKIey6mGls2thcAxrGDZ/Xm3f5dXMJqKMuDC35tSpDW8xoPDc1AYz3LjinnQNCaCo0N2knI5fg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4167.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1cf653-b72c-4b79-2b85-08d870c92b45
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2020 05:14:18.7887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ISnTmwZTn7xJYx3I228MRneq8zr4K4OXxdeVkPmwCiFl3LxZCQ1+hoDWSuqg1E4PHx259v36HGkW5Kl2GsZEg2gR5AegFT07TSpfzobb/WM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3654
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

From: David Reyna <David.Reyna@windriver.com>

Toaster directly supports the last two stable branches
of Yocto Project. With "Gatesgarth " being released, it
is time to replace "Zeus".

[YOCTO #14086]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/orm/fixtures/oe-core.xml | 12 ++++++------
 lib/toaster/orm/fixtures/poky.xml    | 18 +++++++++---------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/lib/toaster/orm/fixtures/oe-core.xml b/lib/toaster/orm/fixture=
s/oe-core.xml
index fd93f4d87b..026d94869a 100644
--- a/lib/toaster/orm/fixtures/oe-core.xml
+++ b/lib/toaster/orm/fixtures/oe-core.xml
@@ -23,9 +23,9 @@
     <field type=3D"CharField" name=3D"branch">master</field>
   </object>
   <object model=3D"orm.bitbakeversion" pk=3D"4">
-    <field type=3D"CharField" name=3D"name">zeus</field>
+    <field type=3D"CharField" name=3D"name">gatesgarth</field>
     <field type=3D"CharField" name=3D"giturl">git://git.openembedded.org/b=
itbake</field>
-    <field type=3D"CharField" name=3D"branch">1.44</field>
+    <field type=3D"CharField" name=3D"branch">1.48</field>
   </object>
=20
   <!-- Releases available -->
@@ -51,11 +51,11 @@
     <field type=3D"TextField" name=3D"helptext">Toaster will run your buil=
ds using the tip of the &lt;a href=3D\"http://cgit.openembedded.org/openemb=
edded-core/log/\"&gt;OpenEmbedded master&lt;/a&gt; branch.</field>
   </object>
   <object model=3D"orm.release" pk=3D"4">
-    <field type=3D"CharField" name=3D"name">zeus</field>
-    <field type=3D"CharField" name=3D"description">Openembedded Zeus</fiel=
d>
+    <field type=3D"CharField" name=3D"name">gatesgarth</field>
+    <field type=3D"CharField" name=3D"description">Openembedded Gatesgarth=
</field>
     <field rel=3D"ManyToOneRel" to=3D"orm.bitbakeversion" name=3D"bitbake_=
version">4</field>
-    <field type=3D"CharField" name=3D"branch_name">zeus</field>
-    <field type=3D"TextField" name=3D"helptext">Toaster will run your buil=
ds using the tip of the &lt;a href=3D\"http://cgit.openembedded.org/openemb=
edded-core/log/?h=3Dzeus\"&gt;OpenEmbedded Zeus&lt;/a&gt; branch.</field>
+    <field type=3D"CharField" name=3D"branch_name">gatesgarth</field>
+    <field type=3D"TextField" name=3D"helptext">Toaster will run your buil=
ds using the tip of the &lt;a href=3D\"http://cgit.openembedded.org/openemb=
edded-core/log/?h=3Dgatesgarth\"&gt;OpenEmbedded Gatesgarth&lt;/a&gt; branc=
h.</field>
   </object>
=20
   <!-- Default layers for each release -->
diff --git a/lib/toaster/orm/fixtures/poky.xml b/lib/toaster/orm/fixtures/p=
oky.xml
index 902bc88a50..a468a54c49 100644
--- a/lib/toaster/orm/fixtures/poky.xml
+++ b/lib/toaster/orm/fixtures/poky.xml
@@ -26,9 +26,9 @@
     <field type=3D"CharField" name=3D"dirpath">bitbake</field>
   </object>
   <object model=3D"orm.bitbakeversion" pk=3D"4">
-    <field type=3D"CharField" name=3D"name">zeus</field>
+    <field type=3D"CharField" name=3D"name">gatesgarth</field>
     <field type=3D"CharField" name=3D"giturl">git://git.yoctoproject.org/p=
oky</field>
-    <field type=3D"CharField" name=3D"branch">zeus</field>
+    <field type=3D"CharField" name=3D"branch">gatesgarth</field>
     <field type=3D"CharField" name=3D"dirpath">bitbake</field>
   </object>
=20
@@ -56,11 +56,11 @@
     <field type=3D"TextField" name=3D"helptext">Toaster will run your buil=
ds using the tip of the &lt;a href=3D"http://git.yoctoproject.org/cgit/cgit=
.cgi/poky/log/"&gt;Yocto Project Master branch&lt;/a&gt;.</field>
   </object>
   <object model=3D"orm.release" pk=3D"4">
-    <field type=3D"CharField" name=3D"name">zeus</field>
-    <field type=3D"CharField" name=3D"description">Yocto Project 3.0 "Zeus=
"</field>
+    <field type=3D"CharField" name=3D"name">gatesgarth</field>
+    <field type=3D"CharField" name=3D"description">Yocto Project 3.2 "Gate=
sgarth"</field>
     <field rel=3D"ManyToOneRel" to=3D"orm.bitbakeversion" name=3D"bitbake_=
version">4</field>
-    <field type=3D"CharField" name=3D"branch_name">zeus</field>
-    <field type=3D"TextField" name=3D"helptext">Toaster will run your buil=
ds using the tip of the &lt;a href=3D"http://git.yoctoproject.org/cgit/cgit=
.cgi/poky/log/?h=3Dzeus"&gt;Yocto Project Zeus branch&lt;/a&gt;.</field>
+    <field type=3D"CharField" name=3D"branch_name">gatesgarth</field>
+    <field type=3D"TextField" name=3D"helptext">Toaster will run your buil=
ds using the tip of the &lt;a href=3D"http://git.yoctoproject.org/cgit/cgit=
.cgi/poky/log/?h=3Dgatesgarth"&gt;Yocto Project Gatesgarth branch&lt;/a&gt;=
.</field>
   </object>
=20
   <!-- Default project layers for each release -->
@@ -152,7 +152,7 @@
     <field rel=3D"ManyToOneRel" to=3D"orm.layer" name=3D"layer">1</field>
     <field type=3D"IntegerField" name=3D"layer_source">0</field>
     <field rel=3D"ManyToOneRel" to=3D"orm.release" name=3D"release">4</fie=
ld>
-    <field type=3D"CharField" name=3D"branch">zeus</field>
+    <field type=3D"CharField" name=3D"branch">gatesgarth</field>
     <field type=3D"CharField" name=3D"dirpath">meta</field>
   </object>
=20
@@ -190,7 +190,7 @@
     <field rel=3D"ManyToOneRel" to=3D"orm.layer" name=3D"layer">2</field>
     <field type=3D"IntegerField" name=3D"layer_source">0</field>
     <field rel=3D"ManyToOneRel" to=3D"orm.release" name=3D"release">4</fie=
ld>
-    <field type=3D"CharField" name=3D"branch">zeus</field>
+    <field type=3D"CharField" name=3D"branch">gatesgarth</field>
     <field type=3D"CharField" name=3D"dirpath">meta-poky</field>
   </object>
=20
@@ -228,7 +228,7 @@
     <field rel=3D"ManyToOneRel" to=3D"orm.layer" name=3D"layer">3</field>
     <field type=3D"IntegerField" name=3D"layer_source">0</field>
     <field rel=3D"ManyToOneRel" to=3D"orm.release" name=3D"release">4</fie=
ld>
-    <field type=3D"CharField" name=3D"branch">zeus</field>
+    <field type=3D"CharField" name=3D"branch">gatesgarth</field>
     <field type=3D"CharField" name=3D"dirpath">meta-yocto-bsp</field>
   </object>
 </django-objects>
--=20
2.17.1

