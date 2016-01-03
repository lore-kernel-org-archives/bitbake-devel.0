Return-Path: <c1moore@ufl.edu>
X-Greylist: delayed 2609 seconds by postgrey-1.34 at layers.openembedded.org;
	Sun, 03 Jan 2016 20:43:52 UTC
Received: from smtp.ufl.edu (smtp-prod02.osg.ufl.edu [128.227.74.218])
	by mail.openembedded.org (Postfix) with ESMTP id 68B926011A
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  3 Jan 2016 20:43:52 +0000 (UTC)
X-UFL-GatorLink-Authenticated: authenticated as  (<>) with  from 10.36.133.35
Received: from exmbxprd04.ad.ufl.edu ([10.36.133.35])
	by smtp.ufl.edu (8.14.4/8.14.4/3.0.0) with ESMTP id u03JxpO9049592
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT);
	Sun, 3 Jan 2016 14:59:51 -0500
Received: from exmbxprd04.ad.ufl.edu (10.36.133.35) by exmbxprd04.ad.ufl.edu
	(10.36.133.35) with Microsoft SMTP Server (TLS) id 15.0.1076.9;
	Sun, 3 Jan 2016 15:00:21 -0500
Received: from UFEXCH-CASHT08.ad.ufl.edu (128.227.145.165) by
	exmbxprd04.ad.ufl.edu (10.36.133.35) with Microsoft SMTP Server (TLS)
	id 15.0.1076.9 via Frontend Transport; Sun, 3 Jan 2016 15:00:21 -0500
Received: from na01-bn1-obe.outbound.protection.outlook.com (207.46.163.141)
	by mail.ufl.edu (128.227.145.165) with Microsoft SMTP Server (TLS) id
	14.3.181.6; Sun, 3 Jan 2016 15:00:21 -0500
Received: from SN2PR0801MB0798.namprd08.prod.outlook.com (10.160.59.142) by
	SN2PR0801MB0813.namprd08.prod.outlook.com (10.160.59.145) with
	Microsoft SMTP
	Server (TLS) id 15.1.361.13; Sun, 3 Jan 2016 20:00:20 +0000
Received: from SN2PR0801MB0798.namprd08.prod.outlook.com (10.160.59.142) by
	SN2PR0801MB0798.namprd08.prod.outlook.com (10.160.59.142) with
	Microsoft SMTP
	Server (TLS) id 15.1.361.13; Sun, 3 Jan 2016 20:00:19 +0000
Received: from SN2PR0801MB0798.namprd08.prod.outlook.com ([10.160.59.142]) by
	SN2PR0801MB0798.namprd08.prod.outlook.com ([10.160.59.142]) with
	mapi id 15.01.0361.006; Sun, 3 Jan 2016 20:00:19 +0000
From: "Moore, Calvin" <c1moore@ufl.edu>
To: "meta-freescale@yoctoproject.org" <meta-freescale@yoctoproject.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: FlexCAN on Freescale iMX6Q SoC
Thread-Index: AQHRRl+xjUW9rlQd2UylFHfUrVPPfg==
Date: Sun, 3 Jan 2016 20:00:18 +0000
Message-ID: <SN2PR0801MB0798E0C4AD2169C6A9FADE8DF7F10@SN2PR0801MB0798.namprd08.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=c1moore@ufl.edu; 
x-originating-ip: [10.141.39.132]
x-microsoft-exchange-diagnostics: 1; SN2PR0801MB0798;
	5:Q0onPypo9E11Fda5zPaiqx48Ejgt+x7tzzFPkeM4SvDpF1aHn5BggQmka76rdNGOgdisLQNUuYqoIz5OCjAmXoz0FRxuTR0d1dzK3xbahHsh9WjRpXl2Jw5FfQ1rjusMnnKLUtN7h6FaRybVAra3Uw==;
	24:tYmifuTsMMuxz7/4DHALZmm2Hjcnkkh/E1D2moMAS/se6JDAahkw1Oss1WCma6phNx124UqtTTFgcoIg9Wm2oRkgsqdMDjSavamF093cqTo=
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:SN2PR0801MB0798;
x-microsoft-antispam-prvs: <SN2PR0801MB0798A30190AAAB414D0D6D20F7F10@SN2PR0801MB0798.namprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(101931422205132);
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(601004)(2401047)(8121501046)(520078)(5005006)(10201501046)(3002001);
	SRVR:SN2PR0801MB0798; BCL:0; PCL:0; RULEID:;
	SRVR:SN2PR0801MB0798; 
x-forefront-prvs: 0810818DA0
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(189002)(164054003)(199003)(92566002)(5002640100001)(106356001)(90282001)(5008740100001)(19617315012)(102836003)(105586002)(19580395003)(1096002)(75432002)(189998001)(74316001)(2501003)(10400500002)(586003)(99286002)(5003600100002)(86362001)(40100003)(3846002)(1220700001)(16236675004)(106116001)(11100500001)(76576001)(2900100001)(54356999)(81156007)(6116002)(87936001)(229853001)(5001960100002)(88552001)(19627405001)(89122001)(15975445007)(50986999)(107886002)(33656002)(101416001)(5001770100001)(19625215002)(122556002)(5004730100002)(97736004)(77096005)(32563001)(340984004);
	DIR:OUT; SFP:1101; SCL:1; SRVR:SN2PR0801MB0798;
	H:SN2PR0801MB0798.namprd08.prod.outlook.com; FPR:; SPF:None;
	PTR:InfoNoRecords; MX:1; A:1; LANG:en; 
received-spf: None (protection.outlook.com: ufl.edu does not designate
	permitted sender hosts)
spamdiagnosticoutput: 1:23
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2016 20:00:18.9909 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4da0f8-4a31-4d76-ace6-0a62331e1b84
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR0801MB0798
X-Microsoft-Exchange-Diagnostics: 1; SN2PR0801MB0813;
	2:+kbN/JMiO6k1Pg/8qBlSSD9NdGP6TJQrtng5S1FXaRu3my4DVmsI1+zw1lZp5BR8obvp99ncNPdq+j00q5M9zTbpLaMD9J12HizKJHPIAhv1N+DMfu3lZjUUTD6TToNkIZeFHoD56bpuutPS6qHWyA==;
	23:XWody+xRBISl/Mc7H6XnHDRjNCl2uPq3vGObA2BKDvxk1yndDK66clQZLP5FIeSB8dSi5aN0X3vzaAwxxj/OW1Zam94bUMylrTwbESulUarLoj3X3oECYydCIvEfB3q+1zyI7u5XFuh/OemQUDo2rwRLBEP/jKQXRy1Szw2lKrnsPRGiNYZdC68m1Z8qGnkZ
X-OriginatorOrg: ufl.edu
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:, ,
	definitions=2016-01-03_14:, , signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
	suspectscore=0
	malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 classifier=spam
	adjust=0 reason=mlx scancount=1 engine=8.0.1-1507310008
	definitions=main-1601030380
X-Spam-Level: *
X-UFL-Spam-Level: *
Subject: FlexCAN on Freescale iMX6Q SoC
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
X-List-Received-Date: Sun, 03 Jan 2016 20:43:54 -0000
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SN2PR0801MB0798E0C4AD2169C6A9FADE8DF7F10SN2PR0801MB0798_"

--_000_SN2PR0801MB0798E0C4AD2169C6A9FADE8DF7F10SN2PR0801MB0798_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,


I am trying to install the FlexCAN driver on a Freescale iMX6Q SoC using th=
e Yocto project (version 1.5) provided on the VIA Technologies website at h=
ttp://www.viatech.com/en/systems/industrial-fanless-pcs/amos-820/.  I have =
contacted Freescale, but they have been unable to assist me actually instal=
l the driver.  They did tell me that I would have to build a completely new=
 image for the system, though (https://community.freescale.com/message/6005=
61?et=3Dwatches.email.thread#600561).  I assume this would require editing =
the BitBake recipe, but I am unsure how to properly install a driver with B=
itBake.  Can anybody give me some guidance to install FlexCAN properly?


Thanks,

Calvin

--_000_SN2PR0801MB0798E0C4AD2169C6A9FADE8DF7F10SN2PR0801MB0798_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;back=
ground-color:#FFFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
<p>Hello,</p>
<p><br>
</p>
<p>I am trying to install the FlexCAN driver on a Freescale iMX6Q SoC using=
 the Yocto project (version 1.5) provided on the VIA Technologies website a=
t&nbsp;<a href=3D"http://www.viatech.com/en/systems/industrial-fanless-pcs/=
amos-820/" id=3D"LPlnk819028">http://www.viatech.com/en/systems/industrial-=
fanless-pcs/amos-820/</a>.
 &nbsp;I have contacted Freescale, but they have been unable to assist me a=
ctually install the driver. &nbsp;They did tell me that I would have to bui=
ld a completely new image for the system, though (<a href=3D"https://commun=
ity.freescale.com/message/600561?et=3Dwatches.email.thread#600561" id=3D"LP=
lnk557547" title=3D"https://community.freescale.com/message/600561?et=3Dwat=
ches.email.thread#600561=0A=
Ctrl&#43;Click or tap to follow the link">https://community.freescale.com/m=
essage/600561?et=3Dwatches.email.thread#600561</a>).
 &nbsp;I assume this would require editing the BitBake recipe, but I am uns=
ure how to properly install a driver with BitBake. &nbsp;Can anybody give m=
e some guidance to install FlexCAN properly?</p>
<p><br>
</p>
<p>Thanks,</p>
<p>Calvin</p>
</div>
</body>
</html>

--_000_SN2PR0801MB0798E0C4AD2169C6A9FADE8DF7F10SN2PR0801MB0798_--
