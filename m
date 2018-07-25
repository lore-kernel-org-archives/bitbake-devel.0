Return-Path: <harini@bruviti.com>
X-Greylist: delayed 16323 seconds by postgrey-1.34 at layers.openembedded.org;
	Wed, 25 Jul 2018 14:38:25 UTC
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
	(mail-bl2nam02on0124.outbound.protection.outlook.com [104.47.38.124])
	by mail.openembedded.org (Postfix) with ESMTP id DF00460110
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Jul 2018 14:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=NETORG158912.onmicrosoft.com; s=selector1-bruviti-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=GDWOimIi8GDOFo0p4Vb3qB6uC/MyXC/R1BL76eIFg68=;
	b=VvZtG2HjGCwPzA45zo1sNx543IgIEEunY8jKLJoOyaO9kskuVKhRsAJOu+SDwoJPXqB3jNeLgLm1mezCNKikEcuIYOAeOnYrEBnqQIV2S3bKjCuNvusnYHwWlqyCHldF4dHdv7TUPCoplzk4yGEW7Alnp+mHFEt2pTrs5fJMJ6M=
Received: from CY1PR04MB2170.namprd04.prod.outlook.com (10.167.8.24) by
	CY1PR04MB2170.namprd04.prod.outlook.com (10.167.8.24) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.973.21; Wed, 25 Jul 2018 10:06:20 +0000
Received: from CY1PR04MB2170.namprd04.prod.outlook.com
	([fe80::5094:36c6:d1ea:cff3]) by
	CY1PR04MB2170.namprd04.prod.outlook.com
	([fe80::5094:36c6:d1ea:cff3%11]) with mapi id 15.20.0973.022;
	Wed, 25 Jul 2018 10:06:20 +0000
From: Harini Srowa <harini@bruviti.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: Building scipy with yocto 2.2
Thread-Index: AQHUI/nucv/7Ydaow02UxzFnJ+eHBQ==
Date: Wed, 25 Jul 2018 10:06:20 +0000
Message-ID: <CY1PR04MB2170674BB2E79C39F14DB4EAC7540@CY1PR04MB2170.namprd04.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=harini@bruviti.com; 
x-originating-ip: [120.138.126.55]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; CY1PR04MB2170;
	6:WmJk9ujtTz+wn3h1qghNSOx6Ar8d6T9qpvpy7T1ObgPCfAXgHjp4KKTOVeH3R6RU0Tp7Z2t+NzouZjour6ZgK70qe1DmnmFc6HWdpHos2ClRq4QgUlUXFr8CnBy+MknPlhBOYVn1NpHhlXb67Qjpj66aiFY/CUwrASGO1Cz2dsQhJjgD/YVUHc0qZrX//LKavAZgSj9PQC32AD6naUODqe5CuxP+TxbjoBxP5QCQor3hTkEpkLdIl3iDZoXjAeAtemmuOR3rDYnfPTWcuBWFamT/SYFYxnNIAIm0cSYH462hW0I1MhBirmOWgU9sZ1vo+FrQVDY/vD7mSuR8uWk/fsVeHwiJnX/v3W2iOo+oAfNElSQjZ/Oyqs2vUmVs1Om43UO0dSTsoE86481HFHaiZ2QL2fbvcxcEqKjkXw/MukgYlI+lzU7X7z5StvWlgPGg19jzA22wWV2GfxPIdYmzGw==;
	5:6viOgP/Ato34RDfQp5fmhSes4O+wEqZAG50XkbktvaoOvn+k/VV56OgdfCRJpueVLdqiJG0uFa7Cmxa/zmfJFWCK6FtZp0r3xVOV3nfLL1kHHmqDMV3HusQ5o8rhFs6Ib8LxIz0iNJRFZPhL3SYeRlG9F3my9SsqtMCxe1+wlIo=;
	7:If6c+rW1Nxaep9zyC2zrsmxwL2UGwLv4Vtnpz6zNQx9oUxi+6nD90mfBgzBt/GyauQWAjfQvCHplzXeNL2g38OOVjLwvYe/QDcwZbfjxI2Ro//IOmaFWZDgt3U/L/jeedWU55YevDqHqN9w6VJfZBoacKB+gI13ZJA9aK4sE9mrY/M31Xx3RtHt6ZS33qh8IzLvQRDne/IoSQe7H0BuyaRQLMw3bGHjf+7R1SRw5fudZRPOUZu5BiAkqmTX6m2XK
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: eac77fea-6de8-47cd-fa12-08d5f21644e9
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600073)(711020)(2017052603328)(7153060)(7193020);
	SRVR:CY1PR04MB2170; 
x-ms-traffictypediagnostic: CY1PR04MB2170:
x-microsoft-antispam-prvs: <CY1PR04MB21704DA5F5597821EA6FF594C7540@CY1PR04MB2170.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(48706222282353)(251646265452963);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(2016111802025)(6072148)(6043046)(201708071742011)(7699016);
	SRVR:CY1PR04MB2170; BCL:0; PCL:0; RULEID:; SRVR:CY1PR04MB2170; 
x-forefront-prvs: 0744CFB5E8
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(396003)(346002)(376002)(39830400003)(366004)(136003)(199004)(189003)(478600001)(256004)(97736004)(86362001)(575784001)(2906002)(102836004)(106356001)(6506007)(105586002)(8936002)(66066001)(14454004)(2900100001)(81156014)(486006)(81166006)(26005)(19627405001)(8676002)(53336002)(33656002)(186003)(6916009)(53936002)(68736007)(7696005)(25786009)(5660300001)(2351001)(5250100002)(2501003)(6606003)(476003)(6116002)(3846002)(55016002)(6306002)(74316002)(54896002)(9686003)(6436002)(5640700003)(7736002)(316002)(99286004);
	DIR:OUT; SFP:1102; SCL:1; SRVR:CY1PR04MB2170;
	H:CY1PR04MB2170.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bruviti.com does not designate
	permitted sender hosts)
x-microsoft-antispam-message-info: Ovc9CmhyGWR/z+nXzln//TdWES6d2gldX9W673iJylVjxj0fVmx7ob9QR9i+kJk5HvB2Py/YZZo5vA8JYwy0PkzmHSp2qkuIHEauDvMyQ9yj93y/Rize2FvcZzt8c08v5aC/GeCc5Dv1q3M/Kt8q/0CtUIcMhWsyYcSNiHj3tLgaLxcGdLIp1wsORMlI+Ll+bPd0oiHfwhUEKwg7Au3j/dpYfZgR1HIZ3eSneqcSRMW5P917NBp4Sf0Dc9+I17ztWWP9tJH9Myx6l1r9AXJ5AeHeRhffzOF03E9Acv5aBPrB1/4cZnuMB1KaJjhvicX8mQX5fEvmeCanIWgG1193HCBgWCEt02ExcSSG16ldJIs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: bruviti.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eac77fea-6de8-47cd-fa12-08d5f21644e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2018 10:06:20.0448 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4996efc-c84c-4fc0-bfac-cc63cda7da45
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2170
X-Mailman-Approved-At: Thu, 26 Jul 2018 12:51:55 +0000
Subject: Building scipy with yocto 2.2
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
X-List-Received-Date: Wed, 25 Jul 2018 14:38:26 -0000
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY1PR04MB2170674BB2E79C39F14DB4EAC7540CY1PR04MB2170namp_"

--_000_CY1PR04MB2170674BB2E79C39F14DB4EAC7540CY1PR04MB2170namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,


Has anyone tried building python-scipy with yocto 2.2. Our bitbake file loo=
ks like this:

SUMMARY =3D "Scientific Library for Python"
SECTION =3D "devel/python"
HOMEPAGE =3D "https://pypi.python.org/pypi/scipy"

LICENSE =3D "BSD-3-Clause"
LIC_FILES_CHKSUM =3D "file://LICENSE.txt;md5=3Dd0db8f4148a3d5534cfb93be78f9=
287c"

PYPI_PACKAGE=3D"scipy"

SRC_URI[md5sum] =3D "53fa34bd3733a9a4216842b6000f7316"
SRC_URI[sha256sum] =3D "87ea1f11a0e9ec08c264dc64551d501fa307289460705f6fccd=
84cbfc7926d10"

inherit pypi setuptools distutils

RDEPENDS_${PN} +=3D "python-core python-numpy-native python-distutils"
DEPENDS +=3D "python-numpy-native"

RDEPENDS_${PN}_class-native +=3D ""
BBCLASSEXTEND =3D "native nativesdk"

do_compile_prepend_class-target() {
    ${STAGING_BINDIR_NATIVE}/python-native/python setup.py build
}

Bitbake compiles the python-scipy half way and then it is not able locate l=
apack/blas resources.
My build machine is x86_64 and I am building it for arm architecture 64 bit=
.

Let me know if anyone has come across such situation.

Thanks and regards,
Harini


--_000_CY1PR04MB2170674BB2E79C39F14DB4EAC7540CY1PR04MB2170namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-size: 10pt;">=
Hi,</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-size: 10pt;">=
<br>
</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-size: 10pt;">=
Has anyone tried building python-scipy with yocto 2.2. Our bitbake file loo=
ks like this:</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-size: 10pt;">=
</p>
<div><br>
</div>
<div>SUMMARY =3D &quot;Scientific Library for Python&quot;<br>
SECTION =3D &quot;devel/python&quot;<br>
HOMEPAGE =3D &quot;https://pypi.python.org/pypi/scipy&quot;<br>
<br>
LICENSE =3D &quot;BSD-3-Clause&quot;<br>
LIC_FILES_CHKSUM =3D &quot;file://LICENSE.txt;md5=3Dd0db8f4148a3d5534cfb93b=
e78f9287c&quot;<br>
<br>
PYPI_PACKAGE=3D&quot;scipy&quot;<br>
<br>
SRC_URI[md5sum] =3D &quot;53fa34bd3733a9a4216842b6000f7316&quot;<br>
SRC_URI[sha256sum] =3D &quot;87ea1f11a0e9ec08c264dc64551d501fa307289460705f=
6fccd84cbfc7926d10&quot;<br>
<br>
inherit pypi setuptools distutils<br>
<br>
RDEPENDS_${PN} &#43;=3D &quot;python-core python-numpy-native python-distut=
ils&quot;<br>
DEPENDS &#43;=3D &quot;python-numpy-native&quot;<br>
<br>
RDEPENDS_${PN}_class-native &#43;=3D &quot;&quot;<br>
BBCLASSEXTEND =3D &quot;native nativesdk&quot;<br>
<br>
do_compile_prepend_class-target() {<br>
&nbsp;&nbsp;&nbsp; ${STAGING_BINDIR_NATIVE}/python-native/python setup.py b=
uild<br>
}<br>
</div>
<div><br>
</div>
<div>Bitbake compiles the python-scipy half way and then it is not able loc=
ate lapack/blas resources.<br>
My build machine is x86_64 and I am building it for arm architecture 64 bit=
.</div>
<div><br>
</div>
<div>Let me know if anyone has come across such situation.</div>
<div><br>
</div>
<div>Thanks and regards,</div>
<div>Harini<br>
</div>
</span><br>
<p></p>
</div>
</body>
</html>

--_000_CY1PR04MB2170674BB2E79C39F14DB4EAC7540CY1PR04MB2170namp_--
