Received: from NAM10-DM6-obe.outbound.protection.outlook.com (NAM10-DM6-obe.outbound.protection.outlook.com [40.107.93.48])
 by mx.groups.io with SMTP id smtpd.web09.59447.1629314468000927773
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Aug 2021 12:21:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=JVJqcS+k;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.93.48, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zi4s9ONGP7R6ouWClDTZt3N/mGj8O4qoUV/2ocoF6V+kPpHhrGACcj0mF+JLxuIzmqBrjLgZk1XajkVkY25i4JRAkq/Z88Pd9bHjpyXMTWSP6FGH/98jxJDBVJog9LXKQ9nWxyiHesHOvEkLfgdYUbQOiqA9oJJRRr2HHhPQJVHNfXDXhEb7VtWhk/fenaK4vzw9+77LGQcLF+0ezpS0KBSJJMqftcpOFSdeNnoDTfE7JfJPN+1O/c8zt6l0jSJz87gpRfRIsYUItW5ab9zPuTvqs1byJTDLd4/kE64bJpY9xOKDWMhW8z+FQ4DNnPrKwNkn+/IvFCeLqhzRVPiS5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/5i75zPlwpgxNQBtUwon734rk7v2hWoJfTXxmjRgYM=;
 b=PN4m9Jkg7r5U1DHHIlxMybYHum/j+RI2gNRG+PcGme2TCAzOAcfnqVqHyfPBu3ghbn/HfrxN9gAFzoI8wi3X/MBKjj2wssl+1FV2Lk24HfAPHeSGaPlfoTJXnL0jqv+1KO/XAYUJC+YGQRwnm3lKjiGsxKJ4MfDVX12rFpsoQu75YvjWnW/DSFU90tmYGYQOjp5hIGYS8a548fJ8NLKy7hTyzm1L1DNqk0cBh0Mqs3kdewdGaOJjqp0u2OM995XvF3bEItaHdpZPZ4xfi9EkSq0nZiREI+eVtdVLD0EMa7FSf8G14K0HtxZS2fDvZ6R68blfDKAqlH2Sd3jTStkQSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/5i75zPlwpgxNQBtUwon734rk7v2hWoJfTXxmjRgYM=;
 b=JVJqcS+kj3ULzx1jGMJigxjxbKYeznYpS0IxhfmGINpYTAD5QXUuxpWu0qXKL3DmUZdlIcHn/r3lOZzGGOL8btqiV43v4bmmI8QwRL7dEpxO0XJ+SjFLpAeYEbNa/EFkuo7zlhpmsgnOQBBr1F822+V3S9YYjvEpJnE9cbQynICPnHNrTl1B7w8+6+5OoFCZFlJQykJnjM2AL/w2/s/uA2+6SxaaEinuKVMH9azALe5eEDFdqUu279lrJwggi+5pbM6dIZBIF3TL0TzilNOUrVhuAGJ3Jl6pJqRIlKC74rahKfZetoYrCPCoclJdf7HSceCH3TUjT+N5OCyo44Z7qw==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 DM4PR12MB5166.namprd12.prod.outlook.com (2603:10b6:5:395::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19; Wed, 18 Aug 2021 19:21:05 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::d02f:e1ca:887e:6000]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::d02f:e1ca:887e:6000%9]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 19:21:05 +0000
From: "Chris Laplante" <chris.laplante@agilent.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Trouble capturing layer revision as variable in recipe
Thread-Topic: Trouble capturing layer revision as variable in recipe
Thread-Index: AdeUY4xdzX9x5/pnTMWcL9zDPNkTqw==
Date: Wed, 18 Aug 2021 19:21:05 +0000
Message-ID: 
 <DM8PR12MB5430C5689FA1BE41556758938BFF9@DM8PR12MB5430.namprd12.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.openembedded.org; dkim=none (message not signed)
 header.d=none;lists.openembedded.org; dmarc=none action=none
 header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fcb4ff41-ecef-42ce-9e09-08d9627d5348
x-ms-traffictypediagnostic: DM4PR12MB5166:
x-microsoft-antispam-prvs: 
 <DM4PR12MB5166B4D3ABEEDB36CD4869CB8BFF9@DM4PR12MB5166.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Cc2E70WRKo20avCewylHIIcdmvWJpF344mHKq/7halTQFx0s9VCevTxKDzb0zOaxvM+eFewP3qyAvgAMTL5oqU5kvVDsyIEJ4jaYHyRoUrJYJS72uRNo9hfooKpT8a16NHNEAucgAFnnQZwxUFFpLDC5aTyZsjE3a9YQ9e1EG56sD5lKra8kK/LI68SKadxKdmE5RoZvd/P+8IE8FnWZNAShYq7P5m5VR3AE1V/LmSxtzguItjR0n6BghQcToFZAqcY0aIumUgtgQHG0xVLUDOvzXEfvb3Mw5p5IqWfNQUE8DFZpRNIwjvZKWMoZ6uGkZVDDrR5iAJw1D0b05utPd3dO+qoZP24rUVoEtzFkO5q5wNvyeG3p/CLpqzuutnwPGx3y+EgTNThko1afc8TLTRdwg1Nzt0vFRIkg7cDa0VREnneF+BLNJRnr2Lle6MaM+l02zSv5UaxUFI68iPF1oLP8KyPuXIxQ7LyPFO38LSt2iWjR9Y9/a4Udy5ZiF27FcGuBSFYCnYQxKjjXG4L/Z2xM6t8/75sPKU1BsH3F0LcL22d60wreKnq9aI7Gp1t3LNKbWokkyGObq3DaC3G0bwVXr8CwiiMGY55B0UZRk8tISpyqNL0ARgwqYUEJiYxE9lXIPxpHcBaU1MsaKj8IBUaNZVNhWMy1n3TaB+VnFZSq7VMIaEhRiFQMJ/IYyYbpTw9p5HIrUJ9FB2rFP6jQ9mxW55NlomxhOUT0erQdb1s=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(29502001)(66946007)(5660300002)(6506007)(76116006)(6916009)(186003)(64756008)(122000001)(26005)(66446008)(66556008)(2906002)(66476007)(52536014)(508600001)(7696005)(33656002)(86362001)(8936002)(8676002)(38070700005)(71200400001)(55016002)(316002)(9686003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?7F3NdrCrUU2cUxKUMjTlb/oriq/h8BY8arRznlBWwCBr3Rp/OvctTPjFEt8N?=
 =?us-ascii?Q?k2h3/RtRX0+uGY9Y9zgsMCOHMcKDi+cODFvRFog8WD0d18ghAWzXEyc/HrTW?=
 =?us-ascii?Q?2VM7Xc9Jp4EOZkXWtsJdKxnPyMXyNV9BuuafMv2tDEPKbYWRMc+mZt7ode3v?=
 =?us-ascii?Q?VowXTP1mmvfU+iV/deOORffcXSxd/nxqi1DmhAm02RzeNt6s3pMtjamsZCU2?=
 =?us-ascii?Q?pBqss0awhrvcxiJb+kgtrlAeMQQ3ydUpvSPq4aBJ2JZEOpgHZX8RKIQKWt9j?=
 =?us-ascii?Q?sSs0nG5H5EMn58xW1CVGC1PBhRhyTuRpNh9rI5ugYAQqyg4zNNuYl2w6jCTa?=
 =?us-ascii?Q?H8aaP+WOYwLzr38fzgCCNkptg4br1TM9m0nuNvXsOidvRM7zsoAXN+I7mdt4?=
 =?us-ascii?Q?sScgAhlmPIoJoU8j2lbJpJGtsxp72ouJUdoHq/ruQP9YbEQUqGLfAr/iIrbr?=
 =?us-ascii?Q?KczCSFEYEAj5hSxVyAMdRHeM5+Q2j0OEXL3mzLfahvQZgDuBWhfLkKVT4Jgz?=
 =?us-ascii?Q?GfaCbhiWaSZHvZbwedd/YCdPuuza/OfLbsjOBlSCM3dS1VQ/GlXJRDXteyGa?=
 =?us-ascii?Q?TFafXhYwkrrdY1mHiuy2IJs5tXoxt+Fehc9WR+BseYONJkYkK8Zo5WiRgG1o?=
 =?us-ascii?Q?XXQrkiBHOc1DzmRZtg5M8y/mhsfU/cpv7QmVQcjMajngl0wTsajxgmsIGtMs?=
 =?us-ascii?Q?LmplxZ73tpgUHXmft8wUENVAxaYsrIbK8P1bt9VL/Xbp+ER5LAK9rIQ2zn+a?=
 =?us-ascii?Q?p4O+KZrOPrBPp02sB8Gf9y1lSPq7UaTIu18fyfIrDCL4UemlD/r0SWD8VrPw?=
 =?us-ascii?Q?SxIs0dAHOAUgSav4L8me9DuhWY7guB2Nwr2AQ/SezG32fyavHksynyFzSDMc?=
 =?us-ascii?Q?vE3fdcpN6z6R+xLZZPBayUrPijH02Op2NtANoNSVhtcDGr7HzlgkjOhVh6Bx?=
 =?us-ascii?Q?Bd77gSHp8LClcSexC7ZXdX14/0P9K+/ZePQgcBkEHSwk1N+nWkpEZtjU/qSN?=
 =?us-ascii?Q?OO46huoTynznzJ5wNlxC8oUAaX+IPp2/P0ff9ftY3MfuppWVl2YbVCq4IO31?=
 =?us-ascii?Q?jJpwog24ZnVwi7jJ0FkJFOY6PFfWRsIUmCZ2+U72fzkWhNn4lFyZt3idxHjA?=
 =?us-ascii?Q?noU5z/VBFdxQ4ttneHRmK2UC8AT/gkr3IHXdqOesHgkUR1UJrExL49I8TnnH?=
 =?us-ascii?Q?HbBtwDKc72cGYGr9O7rDGjHVBtUeidD0slLPm+YpNns1MWyQEEym+HyLCeUT?=
 =?us-ascii?Q?IvSLRjh/Rh0IUzOTe13+xZqTW+AX2bt1LZFLfYNsuCRJEQa70Hd+CE7SpHeF?=
 =?us-ascii?Q?hTNkidKuA5K4qwlUDsem2SF7?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb4ff41-ecef-42ce-9e09-08d9627d5348
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2021 19:21:05.6611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wX8CZCOMc/dEAP/f9jLLtqIfoNaiZtsNJle44cfLr8DOk+9e+3nd28oqdzmWCLJVse3kRuPOSsLBKx5Jz9MZ0lHXJN8oqIzf2d1ZVIrztHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5166
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM8PR12MB5430C5689FA1BE41556758938BFF9DM8PR12MB5430namp_"

--_000_DM8PR12MB5430C5689FA1BE41556758938BFF9DM8PR12MB5430namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello all,

We are on Yocto 'zeus'.

Our u-boot recipe generates a versions.txt file containing the git commit o=
f the U-Boot source tree. It was pointed out that since recipes can patch t=
he source, just the source commit ID isn't quite enough. So we wanted to al=
so include the git commit of the layer housing the recipe. Call this layer =
"meta-our-layer".

This is the implementation we tried:

def get_layer_path(d, name):
    layer_list =3D (d.getVar("BBLAYERS") or "").split()
    return [os.path.abspath(l) for l in layer_list if l.endswith(name)][0]

def get_meta_our_layer_commit(d):
    import subprocess
    output =3D subprocess.check_output(["git", "rev-parse", "HEAD"], univer=
sal_newlines=3DTrue, cwd=3Dd.getVar("OUR_LAYER_PATH"))
    return output.strip()

OUR_LAYER_PATH :=3D "${@get_layer_path(d, "meta-our-layer")}"

OUR_LAYER_COMMIT =3D "${@get_meta_our_layer_commit(d)}"
OUR_LAYER_COMMIT[vardepvalue] =3D "${@get_meta_our_layer_commit(d)}"

do_deploy_append() {
    echo "meta-our-layer:${OUR_LAYER_COMMIT}" >> ${DEPLOYDIR}/versions.txt
}


However there are two problems:

  1.  Making an empty commit to meta-our-layer doesn't cause the recipe to =
be re-run. What's weird is that when I use 'bitbake u-boot -e', I can see t=
hat the value of  OUR_LAYER_COMMIT is indeed changing. And with bitbake-dum=
psig I can see that OUR_LAYER_COMMIT is in the task deps for do_deploy.
  2.  If I build 'u-boot', then make an empty commit to meta-our-layer, and=
 then run "bitbake-whatchanged u-boot", I get a "The metadata is not determ=
inistic and this needs to be fixed." error.

Am I misunderstanding the purpose of vardepvalue? I thought it could be use=
d to here to help bitbake 'see' through values that otherwise change unexpe=
ctedly.

Thanks,
Chris

--_000_DM8PR12MB5430C5689FA1BE41556758938BFF9DM8PR12MB5430namp_
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
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:1821922428;
	mso-list-type:hybrid;
	mso-list-template-ids:-563320272 67698705 67698713 67698715 67698703 67698=
713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-text:"%1\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hello all,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">We are on Yocto &#8216;zeus&#8217;.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Our u-boot recipe generates a versions.txt file cont=
aining the git commit of the U-Boot source tree. It was pointed out that si=
nce recipes can patch the source, just the source commit ID isn&#8217;t qui=
te enough. So we wanted to also include
 the git commit of the layer housing the recipe. Call this layer &#8220;met=
a-our-layer&#8221;.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">This is the implementation we tried:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">def get_layer_path(d, name):<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; layer_list =3D (d.getVar(&quot;BB=
LAYERS&quot;) or &quot;&quot;).split()<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; return [os.path.abspath(l) for l =
in layer_list if l.endswith(name)][0]<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">def get_meta_our_layer_commit(d):<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; import subprocess<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; output =3D subprocess.check_outpu=
t([&quot;git&quot;, &quot;rev-parse&quot;, &quot;HEAD&quot;], universal_new=
lines=3DTrue, cwd=3Dd.getVar(&quot;OUR_LAYER_PATH&quot;))<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; return output.strip()<o:p></o:p><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">OUR_LAYER_PATH :=3D &quot;${@get_layer_path(d, &quot=
;meta-our-layer&quot;)}&quot;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">OUR_LAYER_COMMIT =3D &quot;${@get_meta_our_layer_com=
mit(d)}&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">OUR_LAYER_COMMIT[vardepvalue] =3D &quot;${@get_meta_=
our_layer_commit(d)}&quot;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">do_deploy_append() {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; echo &#8220;meta-our-layer:${OUR_=
LAYER_COMMIT}&#8221; &gt;&gt; ${DEPLOYDIR}/versions.txt<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">However there are two problems:<o:p></o:p></p>
<ol style=3D"margin-top:0in" start=3D"1" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level1 =
lfo1">Making an empty commit to meta-our-layer doesn&#8217;t cause the reci=
pe to be re-run. What&#8217;s weird is that when I use &#8216;bitbake u-boo=
t &#8211;e&#8217;, I can see that the value of &nbsp;OUR_LAYER_COMMIT is
 indeed changing. And with bitbake-dumpsig I can see that OUR_LAYER_COMMIT =
is in the task deps for do_deploy.<o:p></o:p></li><li class=3D"MsoListParag=
raph" style=3D"margin-left:0in;mso-list:l0 level1 lfo1">If I build &#8216;u=
-boot&#8217;, then make an empty commit to meta-our-layer, and then run &#8=
220;bitbake-whatchanged u-boot&#8221;, I get a &#8220;The metadata is not d=
eterministic and this needs to be fixed.&#8221;
 error.<o:p></o:p></li></ol>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Am I misunderstanding the purpose of vardepvalue? I =
thought it could be used to here to help bitbake &#8216;see&#8217; through =
values that otherwise change unexpectedly.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Chris<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM8PR12MB5430C5689FA1BE41556758938BFF9DM8PR12MB5430namp_--
