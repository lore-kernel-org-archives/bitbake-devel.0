Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EDEE7717F
	for <webhook@archiver.kernel.org>; Mon, 16 Dec 2024 18:29:01 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (NAM11-CO1-obe.outbound.protection.outlook.com [40.107.220.88])
 by mx.groups.io with SMTP id smtpd.web11.63746.1734373739185661448
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 16 Dec 2024 10:28:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=LgLWR9k8;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.220.88, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GP7b/TBl3FgrNAkE2P8yD6/g+Tx/sP8syAdoLnvtoFeujR3jBFIpXeSc634UUTci668K4gaim7xemoDj3dku7tnSzPD5l0a12qp0CW2FL5PVFFZOOmCvAoQ/Tcq+3fIZYdgIIMFe5LZzYLg4U6fJlRdRH7ANMChKcPhiT+SBvHBO4Ag9X3f0WRthpoyLkf4D6j4EZ+mb1LmiOn4U86rzGG+x88r0+RC4V/NZoZ1tSecIkBWKu2OUJD3CofKhrtYWD0yX0FvagYQfIMqqHC2kTixYWadDTWo8hY+kI375j3WAoiDqnrizC1WRf2pes8NlnlKoFFDj+9cdT8pkZw1rMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfniKDXjTBefpkypMWUBvPpbgcJD5/q5d9+IfSPNudk=;
 b=kQTRaZ/yxKSfmwrmmMeq6J8BkDzguutlyHznDcmHMmHET8t/iHIC4lYd2UJ+A35SUyHsrqx6sf2fSbiAdSKp4af4UNZMfHt/yf+ifrYgyos2R2FafYp2O+CfbQdhonXwhMH9Oop7ASdRdy8HhiyySgjltnPQjy2mxl7F5fF+gUGWXKq3z17CIEMviG2yvkutD8sUC7g67gNjduRvjgoeDY6FeBCvJk2A3aZXXF7RW8Qq3Rf1b/eSU5LXt48rOnjZD+M76oSkG9xTGN/27QFIwtmOH8Np8mWsQKZ86J0xAmE9O5/bCrUhoSo9H3j5u1wUCTMjM4UgN76bfsOfthUWKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfniKDXjTBefpkypMWUBvPpbgcJD5/q5d9+IfSPNudk=;
 b=LgLWR9k8SEmsuY0hUOyiB0jomY9f9/oSoFkEoFEjplPgtZnbxiCp1ePQLTijgka8Dxajm9PJ29M4CLS95owpHqcVu5WxvTsr/2GCt6lg3TsfSu/5m9oMt6raQ98GHgtNXYK/1cVo+rTD2sNbw+xpQ7WEbxKg8UL4BVGE6c6CDMNjitOHLIF8Bvv0Y//uWYtdq1AqyQdRMoRXrDryiAkkgj6E1F4jf3kEdizkuZfdLbs5MF4teyCoTZ+GpHWFkrbUT7b45aVixJB0VkJGZxxSIwcRyEEoUT6BOzUD7MIiWW4rFzMy8TUbJodkjXdN7SJaGHsVDQviYAi51OsPqiWNvA==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 CH3PR12MB8584.namprd12.prod.outlook.com (2603:10b6:610:164::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Mon, 16 Dec
 2024 18:28:55 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7%5]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 18:28:55 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, Richard Purdie
	<richard.purdie@linuxfoundation.org>
Subject: Potential compromise on adding type hints? 
Thread-Topic: Potential compromise on adding type hints? 
Thread-Index: AdtP5KtnnMdrNAiwTgmvqLEZTRMWqg==
Date: Mon, 16 Dec 2024 18:28:55 +0000
Message-ID: 
 <DM8PR12MB5430AA0A8523E4086243CEB28B3B2@DM8PR12MB5430.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=5ca6794e-3876-44a5-a905-1599d248725e;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2024-12-16T17:53:57Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|CH3PR12MB8584:EE_
x-ms-office365-filtering-correlation-id: 8723a0db-fe0a-40b6-9f75-08dd1dff7fb4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|8096899003|38070700018;
x-microsoft-antispam-message-info: 
 =?koi8-r?Q?HEKKqzehyswXuQ0gfBVzZ24ABljCQIgGxREKD4bB3HTyEUme8IP1InNSqddVAI?=
 =?koi8-r?Q?tOiHoH6D/Q67sh0WgqsRDQiKnnbHzsXKjsP7+t+8eF8s8FBcSVPCGvZQvQrvkf?=
 =?koi8-r?Q?ohA4mMrNUCzTUsjva487FLBi55gUIwnkYHUp8gx5HGEINmflsJm87Ek/0NVe4I?=
 =?koi8-r?Q?hbkiA+VJ/c0YkOBbVkt2+pF3AbfuKCbeO0EL6z/0X+LZxhaT5gkMfZZoxz/493?=
 =?koi8-r?Q?b1FmFFJ8M2BFGWwGeuZwOoKDcF5DsdtpEW/dpKtzUcU6YSt1PLlAl7Te5B0axg?=
 =?koi8-r?Q?Fwf/S2p8J3a5mJOgOtRCI1rhr/IaBR7q/KhgTpozQk7ZdXdivsV5wjd2uchMS3?=
 =?koi8-r?Q?pSgDB8A9iTTyzrXQGZPSGnlkF8LiRmvBuBy+3OB3dGJIFw40DrfXtjIhE2ydzY?=
 =?koi8-r?Q?mPlh/VoAgouzhA66LO/B6b7ONabxl/hOa4yaJmFtEUlEKwG/QLLMmlPN8rmrgR?=
 =?koi8-r?Q?ZfItpq0NGghPFX7uCtIPebg5ki+lIm15KkOGtDQmJduImOpVuqT1tG1mP9afSI?=
 =?koi8-r?Q?UT1tYXSfQKj1W5KkmHp16G7I0/P4UHGeWgcKQ5GmNzx08CgtDJkmbYG/i3PB/B?=
 =?koi8-r?Q?Rn9v7bfEpCDCgSTMN2F4VvuELpOEwju1v2niOuXiNpdBFQLaFlqDIH+qwWv0cZ?=
 =?koi8-r?Q?fyT8tH7YhDuZL/Ps+x8gqbm+y/Q9tAI4duxh41K5wfr08C1vQQPkDbPQX9ggA9?=
 =?koi8-r?Q?7J1LiLZU1E03CwwggkXNNq7HYpOuzl1IDDvmwcPIbEIWjU+rv5KEU2WXMfU+bH?=
 =?koi8-r?Q?z7wkCwpOiOxLIEJTKH2ItmtqUVtPqmPoXx0lqZ7vmosGEFa6W7nQB1+AUcjG25?=
 =?koi8-r?Q?exNVxLaeyepZKZkUBWA/YpngxIB+glzc8VPW3h+IelXJ4Hfo7jVbAE9sLeV0He?=
 =?koi8-r?Q?w9Ok9W2tFE8p/Bw/5vSZ99658NF69qB+cfHxoB+YYds4DMsIpTkvVq/kZBkuxl?=
 =?koi8-r?Q?8V5aMIrZXnWVfVtMmJBuyrG+uUXJSz9oz8Y4BhqnCPSTAvH0XE756e9CkaOUYx?=
 =?koi8-r?Q?6aDkLDjbbJJ9lNZoNXK9eWikCKRxB5FOSuzkzyfNCB+i2ZvYl6tiTL/o5vfYcj?=
 =?koi8-r?Q?0P+oFxye1JoXGZqhjkLo6hh/x3L221GK31zQdCl+2MHcT1xH+/cw5BwEY7JLxQ?=
 =?koi8-r?Q?MoQcQGy7jBf3tRuKalkBg9G1mDheAs69iUijT6ZrpiAYXvmj2fxLS9OL0bq4Ig?=
 =?koi8-r?Q?HTrzRGd1DE4EUttE8taNRDVMzSQWPDzVa2vXuH/CZLVpCFsFKf7kKsIwviU3kt?=
 =?koi8-r?Q?r8L6q869WaEkEHFucr3btg6NZdJ/q5OfczWe6EKlInB+MTNtIiYW2alsgM+49h?=
 =?koi8-r?Q?0guJ8+iCA3FXylYOS0tjNYV8sAinIGQO3icNjoRimQOC?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(8096899003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?koi8-r?Q?ZBgRgbFCxy6uOnmGS/5KvtDuVdpRY/77XVvDhwuSJATe11YSaoQOhQ9BmXvJUx?=
 =?koi8-r?Q?NoXpZBK8uXW98VFxLJeEjZDhs+WlhpGNvUFFKPZ/XCei8Lo1KKrtuo39smbdBW?=
 =?koi8-r?Q?zRHjhiQ49A1YlAP1GMdN+XhuC90UyM79+tSEs38m2GCFXcKR0L6GxllZzwPdJW?=
 =?koi8-r?Q?XJJYFcWsW6SOToBD8f58XP9Pv0o+5Bi/jGvaFC2R2XOBx+9LYNBQLyKliO/mXn?=
 =?koi8-r?Q?8otgkDurPgvf3gCRDlS92HijYrmt2ugKY64XXHmiYvx2GN9qHJOwvNiAWcxZQJ?=
 =?koi8-r?Q?cXhk4jNwoVvFWOE/lRQYrVW1QpmdmTfUbUfrjeaPO1BckRfDzPokYIWU7Ei7Ws?=
 =?koi8-r?Q?Rf8gIT0o579rKKrhQTVF+I8Meji//yBWNr3X4WeVqIOGvBL88Bl3TMZJY4MkWV?=
 =?koi8-r?Q?aiZz5fu3eWwoVB1rEvxm7Fji0puUbuX5wqk3mKX6Ja17YZdMxpfBal21w51OHA?=
 =?koi8-r?Q?EE1zEzjcsAXzUTEHrzKzafSb4quudnPzhtpu49X+jWZBldVHCtxkAoCjpfMkY3?=
 =?koi8-r?Q?7wqQSpkKp1ty2YMuUkU4kAE95NsHh052jy2AyqDgiMm0wWYMuE8UWkULdEnU0f?=
 =?koi8-r?Q?Pc9ns5g16N4nAmZXkf/4rJzmXjZ1nPni/FSax2310eB28JoqMBF6SQSygleegc?=
 =?koi8-r?Q?TWdC0O6udizFvyEibuNQhZBF82OenSWDH8uzOFnDrBSxvZT+7jQbgWaxigrhUy?=
 =?koi8-r?Q?vOxClHfRuN2Q5kfEncsAdr5+rf4ztNLv4NtlVFPuiwmCeKTsEYR6dEOWxqwyd3?=
 =?koi8-r?Q?vAYnextuOyINQAW685bEDDTKWEebFANlLvKqmZnLdHd/hqpYVp9kgb7gN1RXHq?=
 =?koi8-r?Q?K+XIOmt4SLosCszNZ8OIB0jh1ujYrU8ITTIMqSDur8V0fg6PrPlJ2ts4uD1zLS?=
 =?koi8-r?Q?uS8+bC58dkUm9W3UTT36R+wdjgmBLpJ9jigmSvLCgy+W/maamZOPrZuUda4EaZ?=
 =?koi8-r?Q?uHhFGMsrOQNRwx2qKVJIKdW7k2LKESulImClmTYi0lfNxdOQ+KCPM63+mvjIQK?=
 =?koi8-r?Q?y1ab/wINBxlxJivQ008q1jLP2yz3B6PT/97spoUlDrwie47OF+/8DWqo2Kb7sM?=
 =?koi8-r?Q?jSLjiNtt2SOZ2XRY2fPx3Zpqdz2IxdUMRJXZJD3+hhQwfVKwkomKhXt10mXVJl?=
 =?koi8-r?Q?gIB30wONlJr6r8ou+u+cALa76rbujdP+rsrMdQ5i18jbrAdviHuJFB78DQNJUh?=
 =?koi8-r?Q?P203lqnMIwOO2SVOQ1q693tBtNP1uHOUCO9Pp5slTonHUmFHhyBhEyhJxzsPi4?=
 =?koi8-r?Q?vwFWMLj0xVAjq64epqZ/28Yfh/m3Wip5zIoOoStDEwMekMvOSB0cTC44VZQ0ys?=
 =?koi8-r?Q?EgCEuu4NcwRO9qiEp5M33JS4+7BvK3Odh1uNLSKi0qeh4vUIinCGZAaQr0EI/j?=
 =?koi8-r?Q?w4jdbYAZxqJOjggfp78mxIWHLzPJPlpxC6tVZrXOPQ5nrCmQvPwYt28rAdreke?=
 =?koi8-r?Q?qgjmZaRMe37elbGINljqbfTIXMT1QECkLxvfkRvalQyM5J4Ly+AEEGgUjpRoTa?=
 =?koi8-r?Q?cGBH83KIEqemu6Hw3TrVyAcYlRa42CrpbqYOwDTCKhQWxq6nm+?=
Content-Type: multipart/alternative;
	boundary="_000_DM8PR12MB5430AA0A8523E4086243CEB28B3B2DM8PR12MB5430namp_"
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8723a0db-fe0a-40b6-9f75-08dd1dff7fb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2024 18:28:55.2269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4kLc1q1dmh7Egql/aQklWTEOdRgu6+8+YNuAHFyEkK/SkJCugfVM3oKmp8WPOG8wP235jxrpj6sk5iUS6x4q7dkNLoc8T/99aGehwxb3LUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8584
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 16 Dec 2024 18:29:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16913

--_000_DM8PR12MB5430AA0A8523E4086243CEB28B3B2DM8PR12MB5430namp_
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable

Hi Richard,

I know you've expressed you don't want to add type hints to BitBake, and al=
though I strongly disagree, I respect your decision. However, I have a pote=
ntial compromise I wanted to run by you. Instead of adding inline type hint=
s, what if I created stub files (.pyi) and added them alongside the code in=
 a separate directory?

It could look something like:

:~/repos/poky/bitbake$ tree -L 1 stubs/bb lib/bb
stubs/bb
=86=80=80 acl.pyi
=86=80=80 build.pyi
=86=80=80 cache.pyi
=86=80=80 event.pyi
=86=80=80 fetch2.pyi
=86=80=80 __init__.pyi
=84=80=80 msg.pyi
lib/bb
=86=80=80 acl.py
=86=80=80 asyncrpc
=86=80=80 build.py
=86=80=80 cache_extra.py
=86=80=80 cache.py
=86=80=80 checksum.py
=86=80=80 codeparser.py


(I don't think it actually matters where the stub/ directory goes, relative=
 to lib/. We should be able to configure mypy to make it work: https://mypy=
.readthedocs.io/en/stable/config_file.html#confval-mypy_path)

What do you think?

Thanks,
Chris

--_000_DM8PR12MB5430AA0A8523E4086243CEB28B3B2DM8PR12MB5430namp_
Content-Type: text/html; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dkoi8-r">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi Richard,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I know you&#8217;ve expressed you don&#8217;t want t=
o add type hints to BitBake, and although I strongly disagree, I respect yo=
ur decision. However, I have a potential compromise I wanted to run by you.=
 Instead of adding inline type hints, what if
 I created stub files (.pyi) and added them alongside the code in a separat=
e directory?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">It could look something like:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">:~/repos/poky/bitbake$ tree -L 1 stubs/bb lib/bb<o:p=
></o:p></p>
<p class=3D"MsoNormal">stubs/bb<o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif">=86</span>=80=80 acl.pyi<o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif">=86</span>=80=80 build.pyi<o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif">=86</span>=80=80 cache.pyi<o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif">=86</span>=80=80 event.pyi<o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif">=86</span>=80=80 fetch2.pyi<o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif">=86</span>=80=80 __init__.pyi<o:p></o:p></p>
<p class=3D"MsoNormal">=84=80=80 msg.pyi<o:p></o:p></p>
<p class=3D"MsoNormal">lib/bb<o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif">=86</span>=80=80 acl.py<o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif">=86</span>=80=80 asyncrpc<o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif">=86</span>=80=80 build.py<o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif">=86</span>=80=80 cache_extra.py<o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif">=86</span>=80=80 cache.py<o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif">=86</span>=80=80 checksum.py<o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif">=86</span>=80=80 codeparser.py<o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">(I don&#8217;t think it actually matters where the s=
tub/ directory goes, relative to lib/. We should be able to configure mypy =
to make it work:
<a href=3D"https://mypy.readthedocs.io/en/stable/config_file.html#confval-m=
ypy_path">
https://mypy.readthedocs.io/en/stable/config_file.html#confval-mypy_path</a=
>)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">What do you think?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Chris<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM8PR12MB5430AA0A8523E4086243CEB28B3B2DM8PR12MB5430namp_--

