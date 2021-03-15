Received: from mx0b-00010702.pphosted.com (mx0b-00010702.pphosted.com [148.163.156.75])
 by mx.groups.io with SMTP id smtpd.web11.16.1615827915329301036
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Mar 2021 10:05:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ni.com header.s=pps11062020 header.b=Ha2vOmQr;
 spf=pass (domain: ni.com, ip: 148.163.156.75, mailfrom: prvs=87086c5a21=chaitanya.vadrevu@ni.com)
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
	by mx0a-00010702.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12FH3nfi029786;
	Mon, 15 Mar 2021 12:05:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=from : to : date :
 message-id : references : in-reply-to : content-type : mime-version :
 subject; s=PPS11062020; bh=2FIMHScA03GkgpiNUIaJn+caqSIm7cIMFyJqxbxtW10=;
 b=Ha2vOmQrsKw9yYA+TXOTqlILPomU3GSDh7LuOCvJeBgkvX15dJw/J0JDR+/kN6q7JMcv
 9izTw+7Ra1hy97NyJ4cpkYCYkmKgwXT0TzhcxoNJ3rgGt5jPEzOeizGBcUMUCcLf9uXN
 kfuIFLnGQ5JrL/X+yRBlksQaDsbLyOThIWvGWfXKz2A8q7AtkXNac6f/xn0tW/rNzrdv
 9S6o+Qa6zyCNPtGxCU4KQGhFnXEVabN40M7VvR/FaD9IvWxGvRoinaM9u7r6A2kv1Z8G
 9Bhv4cd9sEtYJTWc78osnW1DjbxFeLslJWEwN60BVHcouBECbCJWJExRU9eKI3LeBt+v bw== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by mx0a-00010702.pphosted.com with ESMTP id 378usyk252-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Mar 2021 12:05:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDUanJry9byCboBvVYysg5xKtNLbo+4nef1RN3qK//tRAOX46jrFBMc90ayt4UII2vFbpK1D6BKzwp/agQdamOkC6PtxoGQ3cxBFbFYzAqqHEJFtv6A9LIP+VuaOh3XMJFFR8tMj5l1kFu/5kU9hW4lZcjYB0D974zpijTbmZz1Kdw0em676xAQeXCOQzdKjB+m69sSqDrr4gkGcI90dqXfvyxXdWSDbMa42fJS81Di+43l8rkNFGAAIWHyl75kDtHtw5e5dtVG9vB0J07Lo7XAOyy6DLd1DwmoOezGktuV9cjicrkDbVD5g6oR2Lzp1o9VJKQOL8OLQWNPaL86feA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FIMHScA03GkgpiNUIaJn+caqSIm7cIMFyJqxbxtW10=;
 b=CNLsvUo+AZuV8fBlBIHGY86FLnUdnxdJQd2JPurWaSJTnU9SEDH7sWFEe6RP5tEc5x6IdW0VyfRGbYOD95w+4YDj4yAewwyiprxsrRf4si+6k8TylEB1XKnof0vhR8WNirxg5uYccfDj9sut8jyy45ldfVFA+7oFB2f7uH6iDfnqA867yfcnY72j+qO559q1rDlvkzjvWYVbixCs6tuXSn5+J0EkeE4M+x1ebGNPphXPSm2LGYE1rtfeWDaY8UJ/H2Ch9nq+uSbVILq36wBYYAlH8RhfWrF7MWzImZT8J1N1jRErD4HKrok3Bs6w0XJhP3g8IU54M86mg4H5OHLRKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FIMHScA03GkgpiNUIaJn+caqSIm7cIMFyJqxbxtW10=;
 b=rqCdm6vfv7uJLXwT6AgnV+8JdwthZry3AtcyYXadgKvkx0DIHRlYdFcmL1Fc2fDfffBCeD3dAdg1ddF9madr1H3kcj4o/6ZzQxtLOlhb2qEUejE2cvrraPR0ds+1nuQgGGIuD8q5gjIo5XokErk5GVWLqtSIjvHoT0EYGCPfxWM=
Received: from DM6PR04MB6249.namprd04.prod.outlook.com (2603:10b6:5:127::17)
 by DM6PR04MB7129.namprd04.prod.outlook.com (2603:10b6:5:24b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 17:05:12 +0000
Received: from DM6PR04MB6249.namprd04.prod.outlook.com
 ([fe80::19d5:229c:624f:8bea]) by DM6PR04MB6249.namprd04.prod.outlook.com
 ([fe80::19d5:229c:624f:8bea%2]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 17:05:12 +0000
From: "Chaitanya Vadrevu" <chaitanya.vadrevu@ni.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Thread-Topic: [EXTERNAL] Re: [bitbake-devel] [PATCH] process.py: Increase
 bitbake timeout and add logs
Thread-Index: AQHXD65ONs472gM0DkyHkrtSq+705apxS9IAgAAANNyAFA5r2g==
Date: Mon, 15 Mar 2021 17:05:12 +0000
Message-ID: 
 <DM6PR04MB6249507747B9D973A06721819B6C9@DM6PR04MB6249.namprd04.prod.outlook.com>
References: 
 <20210302215134.11881-1-chaitanya.vadrevu@ni.com>,<9865e3f23d13ec4e47cdf7299a0c550a1f4e74ca.camel@linuxfoundation.org>,<1668AA16CDA346BC.30035@lists.openembedded.org>
In-Reply-To: <1668AA16CDA346BC.30035@lists.openembedded.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none header.from=ni.com;
x-originating-ip: [69.219.174.116]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75730e09-aaf2-4b86-5ceb-08d8e7d47eec
x-ms-traffictypediagnostic: DM6PR04MB7129:
x-microsoft-antispam-prvs: 
 <DM6PR04MB712976C8E49F3246DE02B5509B6C9@DM6PR04MB7129.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 5LwaEG5DI/5vWMMhNVH5DlE0An6JTgtMs0DyW92SSkXnzES6eZIms2JJxlK7wgANlEKj0jTyB8D2l9sHlo2ZXow3ay57MM9Zfo47WaneUrLnHGFofljDMrT8mFJz6lils5ZIUwv3IoweQaU24RfZP7FykX0GMazpr3e+OgDQA+SyKRc5yXSgm81L9JyJStpLxoXpdCbuRI4QTdbNDEGFZtGw1TKGu97ujrDV/yasU3ScIbR4a20XZ9F98DC5It2ReVNDzZkDJkvxq/IKrtiDiC5p+IfoHluY1glrcHJVZjzVKq7gBFfEz9+JUivNWJ9EYNq5S/Hwx+grsh9EDgzypOstuxUVv92fnvWNB+u+SfLyP4ExhGhBMuafdK5ETZ743hULMDSSpmSHJETg9lvRUmHbmqe/zXOaNoN0JNSjwjQmIAh04mLh7fzw0NxkJXLyG3+HoggrcbvUCVSjnFgbUZiEQvRrmjUyPvlYk5dHrx2F5G0+eIOipinystS+5sPCA12ujEZQN2Z+CujgbF0xYl56nqdKoESd5r5sMgejJcUv4pR6HQbYZzekNwJkK8mL
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6249.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(366004)(136003)(39860400002)(71200400001)(83380400001)(6506007)(5660300002)(53546011)(2906002)(33656002)(86362001)(44832011)(7696005)(66446008)(64756008)(66946007)(478600001)(66556008)(66476007)(316002)(52536014)(76116006)(110136005)(8676002)(8936002)(26005)(9686003)(55016002)(91956017)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 
 =?Windows-1252?Q?u3AqaPZ6NZftaSovHJbfqeQ2OrXmz1w0e51UvNSA5RSjLiqy6pYN9rJo?=
 =?Windows-1252?Q?6U4pRMmjJKWibKewFilZ4nc4pLNOtcVgYPFkihW6kVW55Cx8Ca78kec2?=
 =?Windows-1252?Q?rnIZv6Jo8hxXN+h3uZX3xiS93/UTraYStAv7JcA5DqCqm0R2GLeYPwga?=
 =?Windows-1252?Q?4jESzJkwCwVogJwTvRMaeyTcHhmk/z7NlJGt3EllQnZXiX+cG66U9yx8?=
 =?Windows-1252?Q?VL6Jh3MsoWH5MLcC2ooMOALMosIyttD1Vdnj9swEfGoLg+KkAttnjmlX?=
 =?Windows-1252?Q?qPsxQDAig3YVlzDAOUb5aMMLMXoAl0qKqRc8zrSwmKPZg1V5vg4Dwvwa?=
 =?Windows-1252?Q?32P/xayj554vutLvkmmKngbp/lvS61kdxEBS7fQVBFN+9IsZr2KNHLG8?=
 =?Windows-1252?Q?bikq9HigRZWbi27L+szeEmtZ/lFcOlbK1xo9DlKKN4Bx4g0uB8/C5Z4H?=
 =?Windows-1252?Q?Pm4S7eeG/TELkxGHM5PYn5CkgK96sURL0BvtvumQfZb55cfvcu9R2xxW?=
 =?Windows-1252?Q?F+MzntuVuatuf3dbWO84Xlb4kvwgD+X01N6Qav7So+9RdvmE2JA9RN48?=
 =?Windows-1252?Q?Ydy1DrskdXxhTPnWxDZchDxnXaVos3pmMrpn/ltFuk+B0iFpzboJ9RZT?=
 =?Windows-1252?Q?DY8zUyiCdknyM9AueDKmDnXwFN6Rpq/B8HtRX31ghr9ZF5/neMxpgykd?=
 =?Windows-1252?Q?CC0SSjLI/fUPJwwIOr3C39PiBLX1U4kE4wK/wfTd4C1tFslpUQSDh+nC?=
 =?Windows-1252?Q?JythLH1urVlov28vszaFwtWIbAXPO4ZvDy67aPC2nY0ED/sYpJJXzMIk?=
 =?Windows-1252?Q?6QsBwlU3n+qan+JDLCpV61u1HFiorJ5ciCA5PgC9oik6qvM6A6t07gzy?=
 =?Windows-1252?Q?JCUgiHTa29Td44x7/j/StOc1eGEURFbablVTjnQnC0/1/ggAWnDVvRzz?=
 =?Windows-1252?Q?H+FHkpw5CKB6wKZxbRwiIUkInFh1txN62ppRgRApPpZzYliOnKLA9lWO?=
 =?Windows-1252?Q?qDvKwPydWhFnJgBPRlOOeyYTPcZ+q7M5kRJpzYpfYS/dG35b+lSylNgy?=
 =?Windows-1252?Q?7hs5Cgb1M/hbbWDCjivh9ymGcJUikD+nHrezOtvmILzA7KpWuT0j0Vsw?=
 =?Windows-1252?Q?ZBXfrARPiYEI6NlWFDW/EWbSjCh7Ze4A3LPKmEuJyK2KmFRxkr+IHI3e?=
 =?Windows-1252?Q?tKEqV9YoybT1nyZ2E+kzkIionmfDi3hp75eLPPtaVncFDYL+z9EfzYZR?=
 =?Windows-1252?Q?Az0dc8eQTEN/A8Ig6Au1/IW+SowXfkDbXV7NQONRXU7ij+oKvzArP0Ux?=
 =?Windows-1252?Q?AblniCd/PHGpYo3IgOZhoPNktZ4BMigNVb0JbZ5SmGe+xene7HDX4Wxr?=
 =?Windows-1252?Q?bhJd+w0dBfu6VO/Gwk7Q5hCwW2KJ5xDneMwxa4UmbZikWYP3paQlap9i?=
 =?Windows-1252?Q?J+T4Lf6RzjROlUk/t4WyMg=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6249.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75730e09-aaf2-4b86-5ceb-08d8e7d47eec
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 17:05:12.0578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dkzmsmh93Ztfsn5fxcZO6GuWeUaGmmfF22G2nvamh8KMIQUZEn16OuHwZ3cwPIhdd4crFW6gKo67mRUS+DQN/8BI2nQq0ndWMdAbNC+rseg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7129
Subject: Re: [bitbake-devel] [PATCH] process.py: Increase bitbake timeout and add logs
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-15_08:2021-03-15,2021-03-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30
 mlxlogscore=999 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 classifier=spam adjust=30
 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103150115
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR04MB6249507747B9D973A06721819B6C9DM6PR04MB6249namp_"

--_000_DM6PR04MB6249507747B9D973A06721819B6C9DM6PR04MB6249namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Is there any interest in taking this patch? Can I make any changes to it to=
 get it accepted?

Thanks,
Chaitanya

From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembedde=
d.org> on behalf of Chaitanya Vadrevu <chaitanya.vadrevu@ni.com>
Date: Tuesday, March 2, 2021 at 5:24 PM
To: Richard Purdie <richard.purdie@linuxfoundation.org>, bitbake-devel@list=
s.openembedded.org <bitbake-devel@lists.openembedded.org>
Subject: [EXTERNAL] Re: [bitbake-devel] [PATCH] process.py: Increase bitbak=
e timeout and add logs
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

--_000_DM6PR04MB6249507747B9D973A06721819B6C9DM6PR04MB6249namp_
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
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
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
<p class=3D"MsoNormal">Is there any interest in taking this patch? Can I ma=
ke any changes to it to get it accepted?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<br>
Chaitanya<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;color:black">From:
</span></b><span style=3D"font-size:12.0pt;color:black">bitbake-devel@lists=
.openembedded.org &lt;bitbake-devel@lists.openembedded.org&gt; on behalf of=
 Chaitanya Vadrevu &lt;chaitanya.vadrevu@ni.com&gt;<br>
<b>Date: </b>Tuesday, March 2, 2021 at 5:24 PM<br>
<b>To: </b>Richard Purdie &lt;richard.purdie@linuxfoundation.org&gt;, bitba=
ke-devel@lists.openembedded.org &lt;bitbake-devel@lists.openembedded.org&gt=
;<br>
<b>Subject: </b>[EXTERNAL] Re: [bitbake-devel] [PATCH] process.py: Increase=
 bitbake timeout and add logs<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal">Hi Richard,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">We=92re pretty sure its load related.<o:p></o:p></p>
<p class=3D"MsoNormal">We started seeing these errors when our build machin=
es were swamped up<o:p></o:p></p>
<p class=3D"MsoNormal">with a bunch of jobs after we turned them back on af=
ter the<o:p></o:p></p>
<p class=3D"MsoNormal">Texas power outage. <o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">The only info I could glean from logs was that it al=
ways seemed to happen<o:p></o:p></p>
<p class=3D"MsoNormal">after starting the do_rootfs task of our image.<o:p>=
</o:p></p>
<p class=3D"MsoNormal">We unfortunately don=92t have any more insight into =
build farm state<o:p></o:p></p>
<p class=3D"MsoNormal">when it happened.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">Increasing to 300s worked and we stopped seeing the =
issue right away.<o:p></o:p></p>
<p class=3D"MsoNormal">Unfortunately I haven=92t been able to find a lower =
timeout value since the<o:p></o:p></p>
<p class=3D"MsoNormal">load on build farm eased up this week and now I=92m =
only seeing at max 20s wait.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">For interactive users, are there any cases other tha=
n load related where they<o:p></o:p></p>
<p class=3D"MsoNormal">usually see this issue?<o:p></o:p></p>
<p class=3D"MsoNormal">The periodic logs every 10s should help keep them in=
formed and they always have<o:p></o:p></p>
<p class=3D"MsoNormal">the opportunity to kill the build.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Chaitanya<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
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
 bitbake timeout and add logs</span><o:p></o:p></p>
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

--_000_DM6PR04MB6249507747B9D973A06721819B6C9DM6PR04MB6249namp_--
