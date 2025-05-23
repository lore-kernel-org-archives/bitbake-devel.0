Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B890C54F2E
	for <webhook@archiver.kernel.org>; Fri, 23 May 2025 13:27:10 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (NAM02-BN1-obe.outbound.protection.outlook.com [40.107.212.57])
 by mx.groups.io with SMTP id smtpd.web10.47978.1748006824070408924
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 May 2025 06:27:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=BEQGMXFq;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.212.57, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fpVBsNXi+BLejdhVShmJHfq8cuNWd1Zd3H+CvQP1tmDllGCb3JNISpcfg4uErOpLx0/DNSgvl4SGWvqA1LmmiFWFmefAHL7z4P7yXc27n5ouOE1QqL/MlUyGE1duCv49WkNpv9iO6boOjL8I/FiLdAi9oa9FQp5WGHKApRpG4O50Ud2+c8v4sjnNJQV237mYcOKYaovaoXsEmmGS3HPfDigXemsQyQgksBkGZF9Tf4JO6e3ptuaIWtmbVsWVK0+Bh+iFE8KCRL8S9CLrjMWvkE5pUSkg0BcpsrAE7IB+elEiM3OJF5N4OjICM44nDk4CcbcdBCYWqivtHmTy+Q+8Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnoTEmUoiL7bcMBEnrs/kI0mgkR/+I7Lnl2DwGBGguI=;
 b=eXSI4CD3sRRpslW7CVbgnYvke4YcN97BPoxUFeHa/WPuRgFazcDi80/fNjbR1f8Y0GUPQjFLvQ5G0598BAxtb3/h8tzSx/UYCToLg2xdmKR9gxNynMDyJff8ZKb8917rjkqL/OCsdXl2WyOymGjcAEycIICNN2S6wBu0efrRknX4SjhfrqirHDodVjltjoCKlNJb6ElWUVPILpuiSlyGtu0RWDZ+FEQqeaYLiv3JMoJx1loKYR9TS+rEO394KnzSnB8ttN3Le5B6sMtl+D0tNcYaBI436oZMcr/eTOZDqWiikyWSR3GSuBtrRyBYfuzFJOzFuUsb9sCBJGzy418uUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnoTEmUoiL7bcMBEnrs/kI0mgkR/+I7Lnl2DwGBGguI=;
 b=BEQGMXFqK20W+E1K2ZZQWeqsxXoQVrSHWnqIHRN6dqqPawLDZI861iVgKXRGk+CximKZ54DhNRxRyGN7EEThDtoN5i7KMn9+u/ZxuIjKzE55mBJafPMxzJiKznenl7sGX2IOpHxazNJUMGUVW9aDVLvugLdBcRbhif++xU9bVhEtZI+3FnEwpNXQqlD8vFBn/wPQCNd+iRPuzFUvk9ypGuF97UGKno+sVwThFG5duhmwySyepJfe9vTFuFOGH94oQgGFhQa9gifVblU8uJN4B5b/J8UAoDL0wF+5Y1h8IJkewdU/47/BRQrxhSpKD71pDXK9lFG1ZLnEXW8hmEBWrg==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 SA1PR12MB6972.namprd12.prod.outlook.com (2603:10b6:806:24f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 23 May
 2025 13:26:59 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7%7]) with mapi id 15.20.8769.021; Fri, 23 May 2025
 13:26:59 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Why doesn't BB_WORKERCONTEXT cause task hash mismatches?
Thread-Topic: Why doesn't BB_WORKERCONTEXT cause task hash mismatches?
Thread-Index: AdvL5Q968bqCFz3UQxqpJVzshsFbIA==
Date: Fri, 23 May 2025 13:26:59 +0000
Message-ID: 
 <DM8PR12MB543079199282BB54BBB054B68B98A@DM8PR12MB5430.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=06af6e2e-2aaf-4d7e-ba1e-26ab3d9e0c8f;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2025-05-23T13:15:55Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|SA1PR12MB6972:EE_
x-ms-office365-filtering-correlation-id: 96bdd07f-c741-42af-155e-08dd99fd7ef0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|8096899003|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?b6Bup1lkmr37vfWyvHK0KUR7NGIs6wi80wbrlhTaYNgnJ/heUKLvsUI1YjAC?=
 =?us-ascii?Q?O/6iHA5go8hl/DDqwfLom+Wa/oPNAzfxHXESXPnw0ATvjdAjYuRNct9Q88+A?=
 =?us-ascii?Q?FpV6rJ8wo4WGXsqrHK9jjbH5KYmcvfKisQPHaJgGKuaafC6UAEL5uVa2ZhBW?=
 =?us-ascii?Q?/N5XoIW6xb4bbc/PxwLtdbWmYaRZDcKIRN3wH3x/kf6XbUpMps+/38x+BJes?=
 =?us-ascii?Q?AGCKhi3OE1/c+Xhitl/G5b2qjUwselkCfRC06m9piI10eXCFWxKkYwTwzVSz?=
 =?us-ascii?Q?Sux6Hsl1aWYIT5zfKN4Eb/JLYcOQ1bS1/B7Mjr4WP03EEuVHsymn56aK4bXz?=
 =?us-ascii?Q?zfrd0FC7VRvw1Ej8sP2szgJD4RpbVN12Eds6+Y0CTqOF6NlKhr5w+HnkTlfX?=
 =?us-ascii?Q?8Hvw3tAS1hx6coBeWP7xgdJz9f8q2thFGiNeLn8toNGGUS4jHTgiRRu2WdqZ?=
 =?us-ascii?Q?IFOI46p1bXHTuDeCtYW5eUbWB1cQsNVLoOCp6sBj8cd9VqwPNloGveKcyNp1?=
 =?us-ascii?Q?SYYWeOkNtfrFU92ITPyX+lS0PCTMgJTi3nMlTIaayr0cGJuK7itYYIv8E5FQ?=
 =?us-ascii?Q?WSc4JxBZzncXU0dI/PS+GvJoqsccXY3uiyicr3T86jDu7LasLKK6XukgPu5p?=
 =?us-ascii?Q?oN61r5A+xZ0101f8leexc/ymQeeS1MD2Hk2pIEB8633ZxzTbcIgGk5udgY0n?=
 =?us-ascii?Q?LltIgjOjnpz8+NU5dV+FApH/K8snpff1VewlCycHZbcQb/ZbVjqH6eID5u3/?=
 =?us-ascii?Q?eBHm+dppYkTeC26HkoomNlk7NKDfQFRK993Y1a6v4fC+8SWWKsAoYQaRubIg?=
 =?us-ascii?Q?PVYNngGYS9129U/DweZZWugJmWd96bW53N6wdCJ5dZtY1czwK5/MpdFxa9xj?=
 =?us-ascii?Q?9d7BDofY/AgIj78EGo90eBusN0ls8TOMLpQhl187GENYOY6Ai1G0j90jIpSI?=
 =?us-ascii?Q?meingv5VrafWYgsaKEy6VwSdGc19dulTyhtWX/6+JzgVlXTS5s3FLbdvQvpM?=
 =?us-ascii?Q?QjJGIs+OgrtybpStw5WIOJEk2QYKFNE0ucJq1toULNmpLXV1kL7PNWLoLK7K?=
 =?us-ascii?Q?KhMxzjndjeO8cZmdjbKizae9jv5Mbul2S9eQ2DOrgP6XdyQofsQ8kCVkTO6F?=
 =?us-ascii?Q?6UTUhf0ol6jozgMuVYXX/egbIwCB3Ye7fJ3kg5m4hoL6i8ttgqanMtrb2N9Q?=
 =?us-ascii?Q?/eNsptccyUDQPxDgxjaoUceJwjdB8MdBKwn9U09Dct6iekC2Lx7NsfVWJYU5?=
 =?us-ascii?Q?YCj1/MgV0KLvuArd2I6mLdfxe15HA8+2KUrikCILwhxw9dOjxnyIFhJ1Z+jP?=
 =?us-ascii?Q?hOmCNQ7D8oWDSHRxAKFmxyiYxUIRVJUFtb5RM5ICPrhA7veaA7xUHFFY8kZm?=
 =?us-ascii?Q?rhdtANFYTG3IBg3P+M5BmqjqNllHYG2HygLJY7owzuciKoN5OkV65hrKXJe2?=
 =?us-ascii?Q?nb90c/dGYU/XbMc6YdWTaRGDiUHgiyUugOlD5aGdqib4yWnQTCVs2g=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(8096899003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?BQtTr2irq23d1eGGEacJS9WMK/094qcLyPYQk7oHA44McWHgjHRb/XJRcely?=
 =?us-ascii?Q?OAmZH5oL2cx+wdS63lqQU45J2+y0wb6HYimqAkoqa5ZwRMqlIGoC2DPTCXdr?=
 =?us-ascii?Q?NSiQR6bG4UuMjM3tijJ/9BEs7fWGxpHjg4B09txijpwo8ldmFebyGUu7Gs4U?=
 =?us-ascii?Q?uQFA/p2yMRJqH/Fxv9f6n/x1jNp2+V1XyQSLDdZRH/2nG1bxYXuxg2dsBERE?=
 =?us-ascii?Q?mz1EOmPmI2O+JzR2dUUCAZcFemHr/MKAB3StDIs/tXKIjYvmyM5xXh9JCk0E?=
 =?us-ascii?Q?rchkaUVYOT1qrBPJ5kNZ4hjjwqYwpmu4HeF3CYhFbl+xBYFMVredlpspdm7j?=
 =?us-ascii?Q?VAYyWKIW1B38ikbRZe/C9Jxw2sJIkbNK5b7EKhAsUurO220SojEIzjmHRBGC?=
 =?us-ascii?Q?iPoeFagocijZPCZNU9ewmP9v4VKHANu8xfuqGrU0uFYPye8gk4+j0Cdy/YLw?=
 =?us-ascii?Q?RhD1GPIrELsr5CJCWkk6BFVK2NaVXMospMwdRMRc8w0QmbJeQBrytKMTcOi4?=
 =?us-ascii?Q?9Xo3W0+va4eDYFR4k0LcvSPD+RzDlNGWpzPK9LKZhDtOeB42kJmlP9GtQsMb?=
 =?us-ascii?Q?lAt2N2JwLqZUmcwTzwZ9AvNCz3ZaD0e+cW9IVwoA2i9tJspS92ZZGFyl6Xjy?=
 =?us-ascii?Q?kNGjZhSc2ePFn51JwUdvWu0AeTMAsMZZCUCbscFbRq6quaGezTi9eHs5vpWX?=
 =?us-ascii?Q?cdORsYtXpq8EDb0CPX1vXeys/GmQFEVFmh3BeOzpLx+bUGa6/ms3brlisKpR?=
 =?us-ascii?Q?69zYJDPkDxv9YWoADJi4EvNQL508AO1fyODwNaIdsyxxes+IQPLbnfcwBm3g?=
 =?us-ascii?Q?DJOxIBXSH6aTq/Bujzk0ufl+TxZZbBY89CZ/0y5hb0Gz4KIdsy8nUVPFvnX+?=
 =?us-ascii?Q?GA6+g12VbNbdxJTcnJqBqs+CDWQyU7Z+EcI7C3JX98oUTSZ3AzJEJp8X0xgw?=
 =?us-ascii?Q?AXRiO1wEkLb+8rZmE/7JE6lDJIOMmt0XkXAzTpNkvgRrWABIqlZ/YaU50yVD?=
 =?us-ascii?Q?vqRbDqW5rBzSWKjDNLHb7WzlERBobhznaDTPInYqUa0o8mYV0ZbIvOvCY5NV?=
 =?us-ascii?Q?p3uNwQSIOS1o/pcsuVwLcpPHcXxSMojY4Hn9HyjqiIY1p6PGw6YF8vhbe58e?=
 =?us-ascii?Q?8M9hehz8YDL+GBh92uS2ys9QoRzylgUsp7qE9tKCYR3sNjc4LIdRF1g7+Bal?=
 =?us-ascii?Q?LzokfClKZqnPbAvyJIpN1dDwiqFexfyQtUgU6noHfDDettbVXnk074RyA6ZT?=
 =?us-ascii?Q?+X0qaFYicWxFVFekHY1D/Ye9vJvUOng0WYWQ4AgzevpAwKOLseXkMW0ZzOER?=
 =?us-ascii?Q?YqFRb7yfrFSLWruiT2wwMXUI1nHSW1HVOsZXwT2GyLZRQ80ThNXrPsE9lkKy?=
 =?us-ascii?Q?zUJMBK1FfrjI220L4v+PnhpbncwNm1snsRYDQX8LSDQboPIoHWVVcjjhLSOR?=
 =?us-ascii?Q?WoNaR9QeV9GuCzq7MjuRNn0G//pSUlsIHPRv+aMmjORbby4MbRayIGdIJ9PM?=
 =?us-ascii?Q?nf00cC6UUcyDKqh6NVvzIL9NHeWrJLhvyb+C0fP0tGZZuFPkOzwWGA1Uvfrt?=
 =?us-ascii?Q?4Uod8dhC8ML27YMZfyyJCju8BbUIYEf3w4QW+Nrk?=
Content-Type: multipart/alternative;
	boundary="_000_DM8PR12MB543079199282BB54BBB054B68B98ADM8PR12MB5430namp_"
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96bdd07f-c741-42af-155e-08dd99fd7ef0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2025 13:26:59.1887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yd1HbPzKoDkklCS21IStNo7Dj+dSxnpKKBwgzFxFL4ehTejTJSHEdcDWAAcRrR0Mv9XzWTfZMma+L5XMWpU4dP/31pES8Yz1KMnPXqDpBws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6972
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 23 May 2025 13:27:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17634

--_000_DM8PR12MB543079199282BB54BBB054B68B98ADM8PR12MB5430namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

I'm trying to wrap my head around how BB_WORKERCONTEXT doesn't cause task h=
ash mismatches. For example:



# Recipe which depends on something that deploys .bin files in DEPLOY_DIR_I=
MAGE

def get_deployed_bin_files(d):
    if d.getVar("BB_WORKERCONTEXT") !=3D "1":
        return ""
    f =3D d.expand("${DEPLOY_DIR_IMAGE}/*.bin")
    return " ".join(f)

BIN_FILES =3D "${@get_deployed_bin_files(d)}"

do_handle_bin_files() {
    # do something with ${BIN_FILES}
   ls ${BIN_FILES}
}


(Yes, this is a contrived example, and in practice I'd just expand the glob=
 in the do_handle_bin_files task.)


Why doesn't BitBake flag this as a hash mismatch? Especially since BB_WORKE=
RCONTEXT is in BB_HASHEXCLUDE_COMMON. To be clear - I'm grateful that it wo=
rks :), I just don't really understand why.

Thanks,
Chris

--_000_DM8PR12MB543079199282BB54BBB054B68B98ADM8PR12MB5430namp_
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
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
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
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Hi all,<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">I&#8217;m trying to=
 wrap my head around how BB_WORKERCONTEXT doesn&#8217;t cause task hash mis=
matches. For example:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"># Recipe which depe=
nds on something that deploys .bin files in DEPLOY_DIR_IMAGE<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">def get_deployed_bi=
n_files(d):<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp; =
if d.getVar(&quot;BB_WORKERCONTEXT&quot;) !=3D &quot;1&quot;:<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return &quot;&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp; =
f =3D d.expand(&quot;${DEPLOY_DIR_IMAGE}/*.bin&quot;)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp; =
return &quot; &quot;.join(f)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">BIN_FILES =3D &quot=
;${@get_deployed_bin_files(d)}&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">do_handle_bin_files=
() {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp; =
# do something with ${BIN_FILES}<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;l=
s ${BIN_FILES}<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">}<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">(Yes, this is a con=
trived example, and in practice I&#8217;d just expand the glob in the do_ha=
ndle_bin_files task.)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Why doesn&#8217;t B=
itBake flag this as a hash mismatch? Especially since BB_WORKERCONTEXT is i=
n BB_HASHEXCLUDE_COMMON. To be clear &#8211; I&#8217;m grateful that it wor=
ks :), I just don&#8217;t really understand why.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Thanks,<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Chris<o:p></o:p></s=
pan></p>
</div>
</body>
</html>

--_000_DM8PR12MB543079199282BB54BBB054B68B98ADM8PR12MB5430namp_--

