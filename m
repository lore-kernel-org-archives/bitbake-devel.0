Return-Path: <Fritz.Cardoz@harman.com>
X-Greylist: delayed 387 seconds by postgrey-1.34 at layers.openembedded.org;
	Wed, 21 Jun 2017 15:28:57 UTC
Received: from mail1.bemta12.messagelabs.com (mail1.bemta12.messagelabs.com
	[216.82.251.16])
	by mail.openembedded.org (Postfix) with ESMTP id 2A0BE719E2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jun 2017 15:28:57 +0000 (UTC)
Received: from [216.82.251.35] by server-16.bemta-12.messagelabs.com id
	41/13-02746-63F8A495; Wed, 21 Jun 2017 15:22:30 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRWlGSWpSXmKPExsVySpdNU9e03yv
	S4PBUM4vrR0Mtpv9bw+7A5HFu4wpGj/YTfWwBTFGsmXlJ+RUJrBmb905gLJimXPF03zfmBsZf
	8l2MnBxCAlsZJT711ncxcgHZWxglvk34zgbhHGSUWH/0ASNIFZuAvsSz07tYuxg5OIQF1CTWb
	0kGMUUEtCW+PmUHqRAR0JO4f/krE4jNIqAqMWX9drA4r4C7xNmpjWBxRgExie+n1oDZzALiEr
	eezAezJQQEJJbsOc8MYYtKvHz8jxXCNpDYunQfC4StILGyu4ENwraW2D9vKSvEnByJ2a0b2CB
	2CUqcnPmEBeIeGYkZE+azQfyoIrFu1wbWCYwis5CsnoWkfRaSdoi4jsSC3Z/YIGxtiWULXzPD
	2GcOPGZCFl/AyL6KUaM4tagstUjXyEwvqSgzPaMkNzEzR9fQ0EgvN7W4ODE9NScxqVgvOT93E
	yMw3uoZGBh3MK5q9DrEKMnBpCTKW+7tFSnEl5SfUpmRWJwRX1Sak1p8iFGDg0Ogd83qC4xSLH
	n5ealKErzGfUB1gkWp6akVaZk5wIQAUyrBwaMkwpvXA5TmLS5IzC3OTIdInWJUlBLnLQPpEwB
	JZJTmwbXBktAlRlkpYV5GBgYGIZ6C1KLczBJU+VeM4hyMSsK8eb1AU3gy80rgpr8CWswEtPjF
	EQ+QxSWJCCmpBsYduevK2tff3Jh+2PrOyaV1jtZplSdmXyp0Ewi/2+9+95HE4STx0muzb0kG8
	edpb676wjP3QF+HHsvc3MuMrCJ5qy+uz+Fj3GN33VQpdOoklbMThb9/Dy74NjHZ1jKU3zXrTc
	7yqTPNvkfc0ak0aFtSm/Nkspuy5kXbjVm3t3FZf5fp5BRlU1JiKc5INNRiLipOBADbe5XcPQM
	AAA==
X-Env-Sender: Fritz.Cardoz@harman.com
X-Msg-Ref: server-14.tower-151.messagelabs.com!1498058547!101101234!1
X-Originating-IP: [202.45.6.41]
X-StarScan-Received: 
X-StarScan-Version: 9.4.19; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 105324 invoked from network); 21 Jun 2017 15:22:29 -0000
Received: from unknown (HELO HIBDWSMB10.ad.harman.com) (202.45.6.41)
	by server-14.tower-151.messagelabs.com with DHE-RSA-AES256-GCM-SHA384
	encrypted SMTP; 21 Jun 2017 15:22:29 -0000
Received: from HIBDWSMB07.ad.harman.com (10.99.236.97) by
	HIBDWSMB10.ad.harman.com (10.99.236.101) with Microsoft SMTP Server
	(TLS) id 15.0.1263.5; Wed, 21 Jun 2017 20:52:13 +0530
Received: from HIBDWSMB08.ad.harman.com (10.99.236.98) by
	HIBDWSMB07.ad.harman.com (10.99.236.97) with Microsoft SMTP Server
	(TLS) id 15.0.1263.5; Wed, 21 Jun 2017 20:52:13 +0530
Received: from HIBDWSMB08.ad.harman.com ([fe80::70a8:29e6:4c9f:2734]) by
	HIBDWSMB08.ad.harman.com ([fe80::70a8:29e6:4c9f:2734%12]) with mapi id
	15.00.1263.000; Wed, 21 Jun 2017 20:52:13 +0530
From: "Cardoz, Fritz" <Fritz.Cardoz@harman.com>
Thread-Topic: Conditionally adding bblayers
Thread-Index: AdLqoKj6c7FDv06VSdiLbCRTtRZufA==
Message-ID: <d9a0e4d22d9c4d19909ee6dde0258bd1@HIBDWSMB08.ad.harman.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.99.236.43]
x-exclaimer-md-config: 4a26c407-9f7b-4db1-94e4-bcbc87a799a8
MIME-Version: 1.0
To: Undisclosed recipients:;
X-Mailman-Approved-At: Mon, 24 Jul 2017 13:48:57 +0000
Subject: Conditionally adding bblayers
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
Date: Wed, 21 Jun 2017 15:28:57 -0000
X-Original-Date: Wed, 21 Jun 2017 15:22:13 +0000
X-List-Received-Date: Wed, 21 Jun 2017 15:28:57 -0000
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_d9a0e4d22d9c4d19909ee6dde0258bd1HIBDWSMB08adharmancom_"

--_000_d9a0e4d22d9c4d19909ee6dde0258bd1HIBDWSMB08adharmancom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,.

Is there a possibility to add a layer into BBLAYERS variable conditionally =
in conf/bblayers.conf
My use case is I have a feature "foo" being enabled as part of DISTRO_FEATU=
RES in the conf/local.conf and also add the same into OVERRIDES.

However, the override does not apply when bitbake parses the configuration.

Conf/local.conf:
.
.
DISTRO_FEATURES_append :=3D " foo"
OVERRIDES .=3D "${@bb.utils.contains('DISTRO_FEATURES', 'foo', ':foo', '', =
d)}"

Conf/bblayers.conf:
.
.
BBLAYERS_append_foo +=3D " \
  ${BSPDIR}/meta-bar \
"

Strangely, bitbake -e shows that the BBLAYERS contains this "meta-bar" laye=
r when dumping the environment.

Any suggestions? I am currently on poky-jethro.

Thanks,
Fritz

--_000_d9a0e4d22d9c4d19909ee6dde0258bd1HIBDWSMB08adharmancom_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi all,.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Is there a possibility to add a layer into BBLAYERS =
variable conditionally in conf/bblayers.conf<o:p></o:p></p>
<p class=3D"MsoNormal">My use case is I have a feature &#8220;foo&#8221; be=
ing enabled as part of DISTRO_FEATURES in the conf/local.conf and also add =
the same into OVERRIDES.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">However, the override does not apply when bitbake pa=
rses the configuration.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Conf/local.conf:<o:p></o:p></p>
<p class=3D"MsoNormal">.<o:p></o:p></p>
<p class=3D"MsoNormal">.<o:p></o:p></p>
<p class=3D"MsoNormal">DISTRO_FEATURES_append :=3D &quot; foo&quot;<o:p></o=
:p></p>
<p class=3D"MsoNormal">OVERRIDES .=3D &#8220;${@bb.utils.contains('DISTRO_F=
EATURES', 'foo', ':foo', '', d)}&#8221;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Conf/bblayers.conf:<o:p></o:p></p>
<p class=3D"MsoNormal">.<o:p></o:p></p>
<p class=3D"MsoNormal">.<o:p></o:p></p>
<p class=3D"MsoNormal">BBLAYERS_append_foo &#43;=3D &quot; \<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; ${BSPDIR}/meta-bar \<o:p></o:p></p>
<p class=3D"MsoNormal">&quot;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Strangely, bitbake &#8211;e shows that the BBLAYERS =
contains this &#8221;meta-bar&#8221; layer when dumping the environment.<o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Any suggestions? I am currently on poky-jethro.<o:p>=
</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Fritz<o:p></o:p></p>
</div>
</body>
</html>

--_000_d9a0e4d22d9c4d19909ee6dde0258bd1HIBDWSMB08adharmancom_--
