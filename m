Received: from mx0b-00010702.pphosted.com (mx0b-00010702.pphosted.com [148.163.158.57])
 by mx.groups.io with SMTP id smtpd.web11.2705.1614727480969385554
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Mar 2021 15:24:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ni.com header.s=pps11062020 header.b=K9jE390t;
 spf=pass (domain: ni.com, ip: 148.163.158.57, mailfrom: prvs=869528ad88=chaitanya.vadrevu@ni.com)
Received: from pps.filterd (m0098778.ppops.net [127.0.0.1])
	by mx0b-00010702.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 122NO8YS016456;
	Tue, 2 Mar 2021 17:24:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=from : to : date :
 message-id : references : in-reply-to : content-type : mime-version :
 subject; s=PPS11062020; bh=9M+OpsbMA6rPOpDOVLyXktxKX3jc0SD92HftT3XJSAs=;
 b=K9jE390tQk9iD215dXTnYHtHIzPQm44o895baprQsKf+oT0DMllDbCjZOmyEzeERJejQ
 EqSMLATAJ0JcAQYYJdVSkS5Xg7H8j+4cSqiH4Ob0e6NqEkhOQrjDVWIWPTuVvWIl61IG
 ironMvdLGZ6CL0ByMOEkX09PbOUVIp72o4FfQhdxGPTSkhh7tgNt3uzPHM46c6w5K1pD
 hbzJ3lYDVarLBEeTw67SropJSz+SCyZ0BukcNz+tWhgdAGTcfvOtGkDuJ9lrnuQlqNhm
 t0TVPgpHlzmwWGeXtVKZqV8UIH7FCohrQYZldd4B5d64q2aUMT5ilohcnTN6o2TXy1J5 HA== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by mx0b-00010702.pphosted.com with ESMTP id 36ykx4wygf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Mar 2021 17:24:39 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UpqFyvtS6VfTgauhRQ0/8HvkCwaP37JxLNC3HM1l8s/zybGZLHINJ49vajeWXt0DHCa6eE6EBq5JyeM5ku/eLGQe7v82XM5hTCEtsHiUh1SbjspV7hTiIpYEkosLkiGUQgtNXyaGNUP2pQHXGQvv6qchrwMV/PMJRzUT84CL/5DwC9xuzOXHLUydN8AC7GWculxRFWA5armP/66PXqiDYBy4SrjKlt/d5FPXTTPxSdg8eE3TlCnYxbu9MRXHQuNEa8Mx8FMnhnwg35t+CH/LgS3rmmuY3gtJjysTIY3vE9BsNL993ugxJeVmtW8xd3gZBvhA6k1sw+Z42XPHl1Udmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9M+OpsbMA6rPOpDOVLyXktxKX3jc0SD92HftT3XJSAs=;
 b=S50Bq/vjBlpc2vgLuJxWUVue6ff89E9GF7DygBBYh1A5vGscrWpL7oDBX3qvn6wXGiwg5x9GFLUr3sEr5BRSqQVVsX+3B9vpCcfFuvxbUjeHQK0shiLzQIlM2FSUA8Nfnaxopt83NUf4S+Flqvi13s36zGQodkTg7wH4AinxS9gzfulwuRKWev/ue1CFmPt1/AttEDY2WqCecKHOyKxCd9PgUnreyBrNM8Edoy06s3FROl8O5iQ5lWqjZp5h4dQO6gwuzWylf1FtjXcJ2tqXT3qw8o+OUmof+0LSyenbEOglH1aYkwKE/q7dv4fg2zz6HZ6btJVw2/vHcWHOBv1XOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9M+OpsbMA6rPOpDOVLyXktxKX3jc0SD92HftT3XJSAs=;
 b=YGiZGVCP3KdlhW4lSV8vX0ZaqffMzb1MQbOgGepfLhDIWFRsOdGe9qq9u7Wdx80vMVDQdv3T12Lkjsd0xJozgYrOikuoy4Ok40L34bja78IUWy6bWAjwmkFLHJQbJhFKslWc4l+omzdS9SlKgKTBT/BIHXgja90NFH9LJZ7DMfE=
Received: from DM6PR04MB6249.namprd04.prod.outlook.com (2603:10b6:5:127::17)
 by DM6PR04MB6636.namprd04.prod.outlook.com (2603:10b6:5:24e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Tue, 2 Mar
 2021 23:24:37 +0000
Received: from DM6PR04MB6249.namprd04.prod.outlook.com
 ([fe80::757e:e37e:a4ff:7892]) by DM6PR04MB6249.namprd04.prod.outlook.com
 ([fe80::757e:e37e:a4ff:7892%7]) with mapi id 15.20.3890.029; Tue, 2 Mar 2021
 23:24:32 +0000
From: "Chaitanya Vadrevu" <chaitanya.vadrevu@ni.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Thread-Topic: [EXTERNAL] Re: [bitbake-devel] [PATCH] process.py: Increase
 bitbake timeout and add logs
Thread-Index: AQHXD65ONs472gM0DkyHkrtSq+705apxS9IAgAAANNw=
Date: Tue, 2 Mar 2021 23:24:32 +0000
Message-ID: 
 <DM6PR04MB62495002823275E595C66EAE9B999@DM6PR04MB6249.namprd04.prod.outlook.com>
References: 
 <20210302215134.11881-1-chaitanya.vadrevu@ni.com>,<9865e3f23d13ec4e47cdf7299a0c550a1f4e74ca.camel@linuxfoundation.org>
In-Reply-To: 
 <9865e3f23d13ec4e47cdf7299a0c550a1f4e74ca.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none header.from=ni.com;
x-originating-ip: [69.219.174.116]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69c98d76-23b8-4928-59df-08d8ddd2558d
x-ms-traffictypediagnostic: DM6PR04MB6636:
x-microsoft-antispam-prvs: 
 <DM6PR04MB6636E0F28E42564B522DE3299B999@DM6PR04MB6636.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 sZqMP6lHRsP1WbjqtxQ29CTjsiyBgPuk40Qp3GrTqHH1f6C45uap5Q1i1276BIG8eCcFIrXjBQclky+yxJDsZempL7uEGAcV5yBV2tieg5kMN+plZvjdlMXISpKJQ85naFIPZ71X/9WqpYLYvvjaglw4i2iOvIpiBNTE+AT+i4oPwVxrUUbvPtwbZcBh+z+OxqHF4wNZOkUsJmxPWgX6V+FUTS8KJD/vRLISMDOP7Ybf5Cz72lbzQkSNUqnhxPogovyLYSK2DAnqK7aTv6DuJ6KRj2/NPEggJbOXD8lrtqBQ/YCz5HheSzUdTy1dLa3sE03QCTEeAMxViM5ZSQ7DMW5W4Eefry7Mwb2yYW9TpFaVpIlxf3/RrkIEAwvt1LTKZBFugWG+dfySAGMM3dqZ5vDsbcDcxjvZgrxIySfeZK9/5S4MGNpe8mJVyxd0yZpQOn+w4dLTLwKshbEKHG41djViYLXz10Um95vV7FQmV6UD2SL9AL3B9tXeFESfxIufjjuZTq2Ns4xiPZpImI6YWA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6249.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39860400002)(376002)(396003)(366004)(478600001)(6506007)(5660300002)(76116006)(86362001)(52536014)(9686003)(186003)(26005)(83380400001)(64756008)(33656002)(53546011)(9326002)(71200400001)(66556008)(66946007)(8936002)(316002)(110136005)(8676002)(7696005)(66476007)(55016002)(44832011)(91956017)(66446008)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 
 =?Windows-1252?Q?s3ELHi6I+v5Fpy2nHxW8MynSxCk/ot4n7QB0GhxYsxaFBdEMX23TXmIS?=
 =?Windows-1252?Q?oxSjGZpBLKJ3aytNDrk7VyC2l4ZqBKgO4CdgVzXXk9FaPYRM942Ijfpr?=
 =?Windows-1252?Q?gKPSpuMnzvfdG9YSOND8uXLST2DIZ0nEjWv6x2s0H8fsjBY5MdCmrxxk?=
 =?Windows-1252?Q?ALXOVT0cGjBJ7qm6zb7CngOCZOK5KT5FO486JopWkiQjp5IF0/YWFvp+?=
 =?Windows-1252?Q?NSDM1wYqWn7g+n74hhCgH8fTwctN80slwYpGVppY9G04TfOQBofvc8ZO?=
 =?Windows-1252?Q?RAlUW7pSsy41qNvyAFgfGV0RGgkT03Wf1mbDS2jIDE6TYHEn7Tf/SlWk?=
 =?Windows-1252?Q?a2wGktLWEm5rhEgXp71yc6PcnOTQ5hRQe0t8yQehv/Jw6Ws/ljknCKbx?=
 =?Windows-1252?Q?szZkuoFXiYkt7x4Wvt3SpwM14ZPknpyv13owUcl0ffXX3PuytPVz0Tpo?=
 =?Windows-1252?Q?OfzYe9Q7+jZ/6U7b6MmeQttBCqrm6xMpu5C+r8cBPWFDPuLgFgEnwD1e?=
 =?Windows-1252?Q?PHHJ/P+di13VT9aYKn7wsESitu+4+1TmZUTd11/4DUJsBnPrFzzHgr8q?=
 =?Windows-1252?Q?nPeb+uERYrRw04fJpyn7tummbXXvQLpubYuOGAb704U8kvxQgMxdIhR/?=
 =?Windows-1252?Q?qjEgPT1SS3Y1jjHg0gJNXNa47TCv6opXxDj8k7jN9YHfA/hvsLN1uSEa?=
 =?Windows-1252?Q?7hyx7Z9xao5mOi/sOJ4BD2LDpAvpcONJslUEGUlcWqykf8Ua1nU4EHy6?=
 =?Windows-1252?Q?YMmH7j4TW38rXAzqBCYIF07ArxCkGSF9djNMziT3C4lTU+YSZMqZQ9D7?=
 =?Windows-1252?Q?03UDHlVP8O/3bDLo5mlOYyf6DUFODZKmysXir08rkIUczxEI0Ky5D2U+?=
 =?Windows-1252?Q?lAYoDfO7CHquRGKZG02l0hR29vwTeLv40kIauKB1cPRqRN1FoWeYuWCb?=
 =?Windows-1252?Q?Oy73gfzBJiLkyw2yT70MFObOJdbE5CAknG+ng3vPCXSeU2RSO9aGuJZV?=
 =?Windows-1252?Q?mFPQptDrYMT2JdMGtJ5LxphV+OHiAEUNg/+sWCtiebjhbF4EFDhDOBlI?=
 =?Windows-1252?Q?JX3aVEft/BKP9Tdrltl5C/tY6asmCtNz7w6zln+xeEv80ujTtL5cTiJ4?=
 =?Windows-1252?Q?0d/dO2XN+iVSZFQrL3wAsfhZksGbNj26z/HCYxExLFl3Rz8PQ1EkKhR0?=
 =?Windows-1252?Q?b+Q6CMfTG4KD2g0qsIidAL2lwWn+L12Gw5+gALnDW2hZhBpNQZ3t94c5?=
 =?Windows-1252?Q?Cayyod5OMfZYvp8wi8Gx8FGtcLXIeOYINHf7aN6tCNVFmtBRMp36Y6h4?=
 =?Windows-1252?Q?89pb9bA5jnboFeGvyoYT4hRQAFyRzPzCeUpaCwnvu4rv1WImfCoXyxWe?=
 =?Windows-1252?Q?OblI+nddeXnmP+BAatX6zt3Z1wDPJWJSvH5tnvqQxI8exHp9OEWW0UFT?=
 =?Windows-1252?Q?nG3y8n4YrF83DB7ixKkPhg=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6249.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c98d76-23b8-4928-59df-08d8ddd2558d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2021 23:24:32.0143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eFczPgkpsg/I72cGDgvnIBGQUirono91rdNIVkoVsGAgb926aFcs/+lBeTqqTbRMMxzDeFYU7iRVG7rAT7G8YCTtPRTpZjW4gg9ZnvreE6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6636
Subject: Re: [bitbake-devel] [PATCH] process.py: Increase bitbake timeout and add logs
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-02_08:2021-03-01,2021-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30 phishscore=0
 clxscore=1011 suspectscore=0 adultscore=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103020173
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR04MB62495002823275E595C66EAE9B999DM6PR04MB6249namp_"

--_000_DM6PR04MB62495002823275E595C66EAE9B999DM6PR04MB6249namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi Richard,

We=92re pretty sure its load related.
We started seeing these errors when our build machines were swamped up
with a bunch of jobs after we turned them back on after the
Texas power outage.

The only info I could glean from logs was that it always seemed to happen
after starting the do_rootfs task of our image.
We unfortunately don=92t have any more insight into build farm state
when it happened.

Increasing to 300s worked and we stopped seeing the issue right away.
Unfortunately I haven=92t been able to find a lower timeout value since the
load on build farm eased up this week and now I=92m only seeing at max 20s =
wait.

For interactive users, are there any cases other than load related where th=
ey
usually see this issue?
The periodic logs every 10s should help keep them informed and they always =
have
the opportunity to kill the build.

Thanks,
Chaitanya

From: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Tuesday, March 2, 2021 at 4:44 PM
To: Chaitanya Vadrevu <chaitanya.vadrevu@ni.com>, bitbake-devel@lists.opene=
mbedded.org <bitbake-devel@lists.openembedded.org>
Subject: [EXTERNAL] Re: [bitbake-devel] [PATCH] process.py: Increase bitbak=
e timeout and add logs
On Tue, 2021-03-02 at 15:51 -0600, Chaitanya Vadrevu wrote:
> We have started seeing "Unable to connect to bitbake server ..." errors o=
n
> our build farm consistently with 60s timeout. Increasing the timeout to
> 300s and logging every 10s.
>
> Signed-off-by: Chaitanya Vadrevu <chaitanya.vadrevu@ni.com>
> ---
>  lib/bb/server/process.py | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)

Taking a step back, is it reasonable for bitbake to "disappear"
for more than a minute? I've not wanted to increase this value
too much as for an interactive user its a pretty poor situation to
stall for delays this long.

We're also seeing these on the project autobuilder occasionally,
they seem load related. Have you any monitoring which says what your
build farm is doing when these timeouts happen? Did increasing it to
300s work?

I have a suspicion its IO load related and probably around syncing
files at bitbake exit that there is the issue.

Cheers,

Richard

--_000_DM6PR04MB62495002823275E595C66EAE9B999DM6PR04MB6249namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
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
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi Richard,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">We=92re pretty sure its load related.<o:p></o:p></p>
<p class=3D"MsoNormal">We started seeing these errors when our build machin=
es were swamped up<o:p></o:p></p>
<p class=3D"MsoNormal">with a bunch of jobs after we turned them back on af=
ter the<o:p></o:p></p>
<p class=3D"MsoNormal">Texas power outage. <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">The only info I could glean from logs was that it al=
ways seemed to happen<o:p></o:p></p>
<p class=3D"MsoNormal">after starting the do_rootfs task of our image.<o:p>=
</o:p></p>
<p class=3D"MsoNormal">We unfortunately don=92t have any more insight into =
build farm state<o:p></o:p></p>
<p class=3D"MsoNormal">when it happened.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Increasing to 300s worked and we stopped seeing the =
issue right away.<o:p></o:p></p>
<p class=3D"MsoNormal">Unfortunately I haven=92t been able to find a lower =
timeout value since the<o:p></o:p></p>
<p class=3D"MsoNormal">load on build farm eased up this week and now I=92m =
only seeing at max 20s wait.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">For interactive users, are there any cases other tha=
n load related where they<o:p></o:p></p>
<p class=3D"MsoNormal">usually see this issue?<o:p></o:p></p>
<p class=3D"MsoNormal">The periodic logs every 10s should help keep them in=
formed and they always have<o:p></o:p></p>
<p class=3D"MsoNormal">the opportunity to kill the build.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Chaitanya<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;color:black">From:
</span></b><span style=3D"font-size:12.0pt;color:black">Richard Purdie &lt;=
richard.purdie@linuxfoundation.org&gt;<br>
<b>Date: </b>Tuesday, March 2, 2021 at 4:44 PM<br>
<b>To: </b>Chaitanya Vadrevu &lt;chaitanya.vadrevu@ni.com&gt;, bitbake-deve=
l@lists.openembedded.org &lt;bitbake-devel@lists.openembedded.org&gt;<br>
<b>Subject: </b>[EXTERNAL] Re: [bitbake-devel] [PATCH] process.py: Increase=
 bitbake timeout and add logs<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">On Tue, 2021-03-02 at=
 15:51 -0600, Chaitanya Vadrevu wrote:<br>
&gt; We have started seeing &quot;Unable to connect to bitbake server ...&q=
uot; errors on<br>
&gt; our build farm consistently with 60s timeout. Increasing the timeout t=
o<br>
&gt; 300s and logging every 10s.<br>
&gt; <br>
&gt; Signed-off-by: Chaitanya Vadrevu &lt;chaitanya.vadrevu@ni.com&gt;<br>
&gt; ---<br>
&gt; &nbsp;lib/bb/server/process.py | 15 +++++++++++----<br>
&gt; &nbsp;1 file changed, 11 insertions(+), 4 deletions(-)<br>
<br>
Taking a step back, is it reasonable for bitbake to &quot;disappear&quot;&n=
bsp;<br>
for more than a minute? I've not wanted to increase this value<br>
too much as for an interactive user its a pretty poor situation to<br>
stall for delays this long.<br>
<br>
We're also seeing these on the project autobuilder occasionally,<br>
they seem load related. Have you any monitoring which says what your<br>
build farm is doing when these timeouts happen? Did increasing it to<br>
300s work?<br>
<br>
I have a suspicion its IO load related and probably around syncing<br>
files at bitbake exit that there is the issue.<br>
<br>
Cheers,<br>
<br>
Richard<o:p></o:p></p>
</div>
</div>
</body>
</html>

--_000_DM6PR04MB62495002823275E595C66EAE9B999DM6PR04MB6249namp_--
