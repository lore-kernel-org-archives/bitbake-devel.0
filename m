Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDBDC25B4E
	for <webhook@archiver.kernel.org>; Fri, 20 Jan 2023 08:36:37 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.78])
 by mx.groups.io with SMTP id smtpd.web11.69763.1674202689364941396
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Jan 2023 00:18:09 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: andasis.com, ip: 40.107.8.78, mailfrom: ahmet.fenerci@andasis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJpTcZq0E/Jtu02lsg1Swb63id1uG2Ka79T6RTQYecgPUTaSR8XzhwgKb/6UQyr57v5GDRre8GWHIed9ZunuQYVIDAHs8qP6VqovzfXrqD0S0mCSNljbLA8IG7KZNyYBVWa2uY1tw/NUS4ywClH+G5Hzm7iM/28Jp++44tquwu7Ir0ez9/0zs0ibmdFFSJQ6I4GvvlevNUrANPtGp60/9FU0q6FRENIjXwHjqjcMw7UqncU2DtGyUrIKV3234s6rMyyXWGVbGCjCcjEsYiw6W+WN1d8tkjooG8AIVc6Og0yWGk2Hymx3tQUPJ1GKnRjl2D+pemqidueZ/EvP1SUYzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xc159y2a+HLkZo9wx2eVvrVIvzBKNVeXno0pBwbk1YE=;
 b=aH5o79x1CiJh635vJoUiQRjmpyKYCt/3Fknbcq6715QsWGswJYaPjW6xe0wJQN+lIIq23+Yz/2w8rpoPYzwnNtLlQmPb8J/LiM2elXROVJyRZtZ1LqvN3f2Q+TNmIXisxfntlysHqOKly3XmQ4V4lSxbByjEgWaDuzj32xVG3HKMrj60e4Ma37bw/SJgq62GxPr09Qmg48NL7SdIxEy1sZZ/hJCTCdJ58BHXkj+ldfmS1lSqnZRFxxzAk527xwk1zyps7UPJVTgCH4hDJ8UWdohZ+TnMxL+o6xTBuogobsIwl4lvB2Ji6aVLOVAeGgW6UeofS3tyjGFa9k1I8kbrBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=andasis.com; dmarc=pass action=none header.from=andasis.com;
 dkim=pass header.d=andasis.com; arc=none
Received: from DB5P192MB2183.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:488::10)
 by AS2P192MB2046.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.10; Fri, 20 Jan
 2023 08:18:05 +0000
Received: from DB5P192MB2183.EURP192.PROD.OUTLOOK.COM
 ([fe80::d9b2:8587:3a2b:e08f]) by DB5P192MB2183.EURP192.PROD.OUTLOOK.COM
 ([fe80::d9b2:8587:3a2b:e08f%6]) with mapi id 15.20.6002.013; Fri, 20 Jan 2023
 08:18:05 +0000
From: ahmet.fenerci@andasis.com
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Bitbake inaccessible file
Thread-Topic: Bitbake inaccessible file
Thread-Index: AQHZLJ/kxHCzD2afjE2QA6kwqLVRzA==
Date: Fri, 20 Jan 2023 08:18:05 +0000
Message-ID: 
 <DB5P192MB21839A67B248EF872B524589FDC59@DB5P192MB2183.EURP192.PROD.OUTLOOK.COM>
Accept-Language: tr-TR, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=andasis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5P192MB2183:EE_|AS2P192MB2046:EE_
x-ms-office365-filtering-correlation-id: 1ba979e6-af5a-4529-0b05-08dafabedb5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 XYA6JtaAsypdBN3RJZTtYvpfE4aNjg13jkkF9RJcgX2+tYjwtOIUsxxyAOeQmKvh72IX2uKkifq3RLw+rD4vqrlnzzhT1xsSmqzgTfwUN5gDdUs4qHlOGDuRQ28SKY2MDj682PS14M5ROt1dylT9vICp39E5JYTArY7B1biYnZh9CJSx02CEHOm/De5Mv40WPFLzvAwXUaTWMy+3pLJjorbr6edzKWPfGyt0VE2O4dkErWaOpo3rvFJb0BSx5vQ+Wkq0ynyHTbm/tjQG5SXJ8trZL8WuXiwEp1G8cNCcVExS7/8r4pjtMoZkZwB8fOEeCM7xO2QEeDLTU32eGuIQjSgAiJnvZEWs/s1RN2e5ZdmZyWhmrH+Uhy4mUPe5N4nw/EQO7fuM7BILUMvs9qtB88Mibba1JdK4dVFVBHWFKu1GRXa6Gn5tlsufNeTXzVW0vUjfP2iwUBGxOMUVuDb7rg2sjGaWxR0CvAM415v9lYsrK4VcupjGGPJmbIIU3SpBrSIdXCuQ8bOIMlxlwL21+zqTvCD5PUiloOW1McZ8Y5Q9pnasUEEP2H4xH2bAMxtWm8ggOY1eYx9z9pOSf3J+nXTOac8kyp9fd3vysZQilMke/o0+hnl9uYHoAfin6MwQW+C0MFhto76vWDtk3snY7D262mUe1kcCltwGVuZwo3SU7VGnRF5sBIeW3dOJrrR4fR6xko2igAygGsa0IQFwAw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5P192MB2183.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(346002)(136003)(39830400003)(376002)(451199015)(19627405001)(86362001)(33656002)(3480700007)(66476007)(76116006)(44832011)(52536014)(21615005)(55016003)(91956017)(2906002)(8936002)(66556008)(166002)(66946007)(38100700002)(5660300002)(122000001)(55236004)(8676002)(478600001)(316002)(7696005)(71200400001)(6506007)(966005)(38070700005)(26005)(66446008)(41300700001)(6916009)(7116003)(64756008)(83380400001)(186003)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-9?Q?oqKhkhgg4Pj19lZ862s16/js1KI3lE+fsKDyySSE2JF0Edl3Y7qBffKtB+?=
 =?iso-8859-9?Q?fXP0hR0JngIlGEnvTpu36h0s3dXw84w3r3qrb9vOWu+MUqhNBDEyx3RiKZ?=
 =?iso-8859-9?Q?mb+TXKqhWrJmUnzLDUD8JfhUWRVFV8VO9RPENh6ZoHGpW9wmnUMOr0tM9W?=
 =?iso-8859-9?Q?DNt1gfeiYbEsRp3xVNjZxMtV3iuPZuuclr4YM3dA2sNX9TKWOyZgzVKmaq?=
 =?iso-8859-9?Q?EVYK12v4tbeBWGx/V/JTIIGE+Nb6ltXVgaH1FKXyPEU/njZBNDdcLvfLPZ?=
 =?iso-8859-9?Q?XohT+5gYkbADa37LM7HGRLXh6N6LSzHbFUShWeqy9DRnlUlguslrt3dPFc?=
 =?iso-8859-9?Q?3YW7llM5q8qdqq+1UtE/sUammqREQtwKLKa/QRQHjK+5z1DzT7ElA2OHvU?=
 =?iso-8859-9?Q?BCGghW8pu5TI2ac6zgd9INghraNmf8U3bRFBlmUzIWy2ninkJyLt+2pBnb?=
 =?iso-8859-9?Q?v7q954kw9yG5FoKd20XHfJ4hJY9o2dl9JDhdWFdlG7sVmxaPqtT3G2idSL?=
 =?iso-8859-9?Q?8u5lPx2IZWYx9Y9eCQp8Xxh4pyzhA6dHPYp+wpdonN9wTg46h/02rNXZVD?=
 =?iso-8859-9?Q?WBw6FX+BZZGyIt4AnyoILgsWizni0Km1FHfH9O03YvpEaUZCCS5O7tKcXc?=
 =?iso-8859-9?Q?QCBsVcDojerKXCK686WlVdW/rZcUK7vPADzbFA9Qj9ycrP/C5qlAq6fDyL?=
 =?iso-8859-9?Q?pLRM5X5menAOHpqIxGbfe3tyLF6Yjww7dzOGaFElR7LH6aaTDdctLqtEwI?=
 =?iso-8859-9?Q?zm5I6wZkfmWO6JM/pEJzdAmYXjHZ84wCh0WMaWfLMK6/DcSOwtq+a1Pf5l?=
 =?iso-8859-9?Q?zvaPYOV5ROjQxWHBU4k1ABr32A4ca4Fn7smY73bwMMbivt/bSIVpM+EoZs?=
 =?iso-8859-9?Q?7Jz83zgQ1TSKOwnDlhwoXp5vlIbFhlHY638QaUuk9FKmDF6DzhrZmMca2R?=
 =?iso-8859-9?Q?xEhsXaoGAOIoeFFj8lpZDG6Ya5nh27iKlRm7V5uuKoRT+TOGgZxwlj2ssk?=
 =?iso-8859-9?Q?BIlkRBvTtT8h+03hFBKwzNPNO4PzDSiBTVib3OnEG0/RLPiLl4u/WWVORA?=
 =?iso-8859-9?Q?XaJGTsqczREhrv9mND/tZ+rhFq/KHYO9ZnV4hD6Yy5QUn0MjwQCqZIAsuf?=
 =?iso-8859-9?Q?KRnoWwPT+4LuplCFQekLEIqSF21rFUp4oYGSmeKolskwyyLrfa54sPvncu?=
 =?iso-8859-9?Q?VUGk5+eHB6zncbnMERY6ZmEF6vT6Pg4PegnXWOG9A+vB6b6h0sD2SFME1I?=
 =?iso-8859-9?Q?V0I9YpMbZp8nrZ5xMLdRLrwOOnTnUrwxwbIyGXGsVFmO9PhKXgM9DEDmNc?=
 =?iso-8859-9?Q?u+ly0FWJKBYVBuRwQtngoion5nTDOb7BFlfyrUxEE8QsWFMgzA/w7H0ksA?=
 =?iso-8859-9?Q?pNf8B++sEQXImy1AV/dcQMirfcrR3IDMDeEs7v9Ldss8+ZqfULlGjV/qrW?=
 =?iso-8859-9?Q?HngaXsnl9A+tpKRzQlvZzpLJnj+9lVHB3xM98KvBzNmHJwMXHTtpbZrhPn?=
 =?iso-8859-9?Q?GbJ6GABzS9/Ua86avZL80hXH+mXFdjKopWtia//kRdcfZ4UaiqB8hDSWy5?=
 =?iso-8859-9?Q?3nGHT482H28v2V7oQNtqDal6t7GedT2jFq+htFYEwQA8H9bjm2Vz3f8Xrr?=
 =?iso-8859-9?Q?eJm4lMcc6dkq9Bz4yLZ1u/y9tVCpjbM/aR?=
MIME-Version: 1.0
X-OriginatorOrg: andasis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5P192MB2183.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba979e6-af5a-4529-0b05-08dafabedb5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2023 08:18:05.7360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb78fb6a-1c86-49dc-ad03-faf7dff294ba
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dw44uiv4jrDvGnNM4g0tBIVmz0uE4oLKvapWE6dTOjonbYXdPg4hUoTLEG5WIi0DCX1ihgwqUdiG3c0GmbfR96S0Q981tRCwsP58s5VJAPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P192MB2046
Content-Language: tr-TR
Content-Type: multipart/alternative;
	boundary="_000_DB5P192MB21839A67B248EF872B524589FDC59DB5P192MB2183EURP_"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Jan 2023 08:36:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14327

--_000_DB5P192MB21839A67B248EF872B524589FDC59DB5P192MB2183EURP_
Content-Type: text/plain; charset="iso-8859-9"
Content-Transfer-Encoding: quoted-printable

Hi,


I want to run Yocto on Intel Atom Processor C3758. My board support Sumo br=
anch-harcuvar platform, so I used the instructions stated on the site : htt=
ps://www.yoctoproject.org/software-overview/layers/bsps/sumo-25-harcuvar/ .


After successfully downloading poky, meta-intel, meta-dpdk, meta-intel-qat =
(according to sumo branch) and adding settings to config file, I built imag=
e-sato with using bitbake command. The build process took about 6-7 hours w=
ith an error. The error is related with the file : "qat1.7.l.4.1.0-00022.ta=
r.gz" . ( Intel QuickAssist Technology ). Bitbake could not fetch URL becau=
se no access to file on site. (01.org<https://01.org/> : Intel Open Source)=
.

( https://01.org/sites/default/files/downloads/intelr-quickassist-technolog=
y/qat1.7.l.4.1.0-00022.tar.gz )


Q1- Is there any other way to find this file?(qat1.7.l.4.1.0-00022.tar.gz) =
?

Q2- In Intel website ( https://www.intel.com/content/www/us/en/download/197=
34/intel-quickassist-technology-driver-for-linux-hw-version-1-7.html ), the=
re are some QuickAssist Technology drivers (the earliest version 4.12.0-000=
111) , can I use one of these drives in yocto project? If it's possible, ho=
w can I set to fetch URL in bitbake?

Q3- Is it possible to run an updated branch version of yoctoproject (Dunfel=
l, Kirkstone etc.) for my board?


--_000_DB5P192MB21839A67B248EF872B524589FDC59DB5P192MB2183EURP_
Content-Type: text/html; charset="iso-8859-9"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
9">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof"><span style=3D"font-family: Calibri, Arial, H=
elvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); background-colo=
r: rgb(255, 255, 255);">
<p style=3D"box-sizing:border-box;margin:0px;line-height:1.25;color:rgb(128=
, 128, 128);font-family:intel-clear, tahoma, Helvetica, helvetica, Arial, s=
ans-serif;background-color:rgb(247, 247, 247)">
Hi,</p>
<p style=3D"box-sizing:border-box;margin:0px;line-height:1.25;color:rgb(128=
, 128, 128);font-family:intel-clear, tahoma, Helvetica, helvetica, Arial, s=
ans-serif;background-color:rgb(247, 247, 247)">
<br style=3D"box-sizing:border-box">
</p>
<p style=3D"box-sizing:border-box;margin:0px;line-height:1.25;color:rgb(128=
, 128, 128);font-family:intel-clear, tahoma, Helvetica, helvetica, Arial, s=
ans-serif;background-color:rgb(247, 247, 247)">
I want to run Yocto on Intel Atom Processor C3758. My board support Sumo br=
anch-harcuvar platform, so I used the instructions stated on the site :<spa=
n>&nbsp;</span><a rel=3D"noopener" target=3D"_blank" href=3D"https://www.yo=
ctoproject.org/software-overview/layers/bsps/sumo-25-harcuvar/" style=3D"bo=
x-sizing:border-box;transition:color 0.1s linear 0s;cursor:pointer;border-b=
ottom:1px solid transparent;display:inline">https://www.yoctoproject.org/so=
ftware-overview/layers/bsps/sumo-25-harcuvar/</a><span>&nbsp;</span>.</p>
<p style=3D"box-sizing:border-box;margin:0px;line-height:1.25;color:rgb(128=
, 128, 128);font-family:intel-clear, tahoma, Helvetica, helvetica, Arial, s=
ans-serif;background-color:rgb(247, 247, 247)">
<br style=3D"box-sizing:border-box">
</p>
<p style=3D"box-sizing:border-box;margin:0px;line-height:1.25;color:rgb(128=
, 128, 128);font-family:intel-clear, tahoma, Helvetica, helvetica, Arial, s=
ans-serif;background-color:rgb(247, 247, 247)" class=3D"ContentPasted1">
After successfully downloading poky, meta-intel, meta-dpdk,<span>&nbsp;</sp=
an><span style=3D"box-sizing:border-box;font-family:Lato, sans-serif">meta-=
intel-qat (according to sumo branch) and adding settings to config file, I =
built image-sato with using bitbake command.
 The build process took about 6-7 hours with an error. Th</span>e error is =
related with the file : &quot;qat1.7.l.4.1.0-00022.tar.gz&quot; . ( Intel Q=
uickAssist Technology ). Bitbake could not fetch URL because no access to f=
ile on site. (<a rel=3D"noopener" target=3D"_blank" href=3D"https://01.org/=
" style=3D"box-sizing:border-box;transition:color 0.1s linear 0s;cursor:poi=
nter;border-bottom:1px solid transparent;display:inline">01.org</a><span>&n=
bsp;</span>:
 Intel Open Source).&nbsp;</p>
<p style=3D"box-sizing:border-box;margin:0px;line-height:1.25;color:rgb(128=
, 128, 128);font-family:intel-clear, tahoma, Helvetica, helvetica, Arial, s=
ans-serif;background-color:rgb(247, 247, 247)" class=3D"ContentPasted1">
(&nbsp;https://01.org/sites/default/files/downloads/intelr-quickassist-tech=
nology/qat1.7.l.4.1.0-00022.tar.gz )<br class=3D"ContentPasted1">
</p>
<p style=3D"box-sizing:border-box;margin:0px;line-height:1.25;color:rgb(128=
, 128, 128);font-family:intel-clear, tahoma, Helvetica, helvetica, Arial, s=
ans-serif;background-color:rgb(247, 247, 247)">
<br style=3D"box-sizing:border-box">
</p>
<p style=3D"box-sizing:border-box;margin:0px;line-height:1.25;color:rgb(128=
, 128, 128);font-family:intel-clear, tahoma, Helvetica, helvetica, Arial, s=
ans-serif;background-color:rgb(247, 247, 247)" class=3D"ContentPasted2">
Q1- Is there any other way to find this file?(<span style=3D"box-sizing:bor=
der-box">qat1.7.l.4.1.0-00022.tar.gz) ?&nbsp;</span></p>
<p style=3D"box-sizing:border-box;margin:0px;line-height:1.25;color:rgb(128=
, 128, 128);font-family:intel-clear, tahoma, Helvetica, helvetica, Arial, s=
ans-serif;background-color:rgb(247, 247, 247)">
Q2- In Intel website (<span>&nbsp;</span><a rel=3D"noopener" target=3D"_bla=
nk" href=3D"https://www.intel.com/content/www/us/en/download/19734/intel-qu=
ickassist-technology-driver-for-linux-hw-version-1-7.html" style=3D"box-siz=
ing:border-box;transition:color 0.1s linear 0s;cursor:pointer;border-bottom=
:1px solid transparent;display:inline">https://www.intel.com/content/www/us=
/en/download/19734/intel-quickassist-technology-driver-for-linux-hw-version=
-1-7.html</a><span>&nbsp;</span>),
 there are some QuickAssist Technology drivers (the earliest version 4.12.0=
-000111) , can I use one of these drives in yocto project? If it's possible=
, how can I set to fetch URL in bitbake?</p>
<p style=3D"box-sizing:border-box;margin:0px;line-height:1.25;color:rgb(128=
, 128, 128);font-family:intel-clear, tahoma, Helvetica, helvetica, Arial, s=
ans-serif;background-color:rgb(247, 247, 247)">
Q3- Is it possible to run an updated branch version of yoctoproject (Dunfel=
l, Kirkstone etc.) for my board?</p>
<br>
</span></div>
</body>
</html>

--_000_DB5P192MB21839A67B248EF872B524589FDC59DB5P192MB2183EURP_--

