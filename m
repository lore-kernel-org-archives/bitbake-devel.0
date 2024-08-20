Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB55C531DC
	for <webhook@archiver.kernel.org>; Tue, 20 Aug 2024 13:57:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (NAM11-DM6-obe.outbound.protection.outlook.com [40.107.223.57])
 by mx.groups.io with SMTP id smtpd.web10.19962.1724162226793462260
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Aug 2024 06:57:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=xeYWIZQ4;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.223.57, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vtx/KlcAqqTkmE6p28p3H23009e96mYoqDrFc564deY4NIaYltx+mE8xVsWPoipnw5IHdh4HcncT5uoeSFOZV0V4rAhopYHn+KfSMfhBaQGY4R/9VfR/A3JPKaTkTQhbqg63M4jNvH8qNg9dCbTRCsJDfrpobXpUPUpdRrNJ+S8Wm//r7PjC9wTt1ut7jVgSx05eASZdKXKzmmBvNeEf3uwBGMhB4InRmbScsZVdmbye5iy/o9jNgakCvopQ0a/esQbWSBZFZG/G6HkFCjB/wJb4npk9NRjyv6ddsH87zI4iv9Nm0zGDbeizqrFiTLDUyJuyrm8u3ZVcKD78t4FpuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=na7l8ZdQkOqbmeEZJ0ndF+Msbo0hTs4dNOCgSeBdvpc=;
 b=em3UcSwJ98h2epIRml1inyKoVJohXONJr20Q7vu7L7h8UajdN0V6lT65wBcpjfDXUeN8l37+aNhGIuPxx1axYFgo2xQimA18hSWt442019W4Ven9nJWClYBUU3n+ccTh4z2RDBU+8Cr3nj5RpSy8TyHMB2/eNbjmFMzGRgOaIBR8FJkmHZBKxw4VwcSC9Odp9jiWcDGwL4ZtDcWjyPilq5MIVuLN1CUJwmFF4JP1FBd7PSB3dQjuSfpXwykrmXkyvCpnfwJIZeloAgZ/xHbMAMBtrO18xGLGh1TR47c6oKL4a6HzPV1EgsDWkP+hepxeVwpRiH3aq6e5op8ZZESmXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=na7l8ZdQkOqbmeEZJ0ndF+Msbo0hTs4dNOCgSeBdvpc=;
 b=xeYWIZQ4HNwL30IGfcKZeNhgjrh0vrPRETM/ApgKCcN0QSmVDt6+e1Kp10E1Ve/+hgivPxZz99bdg4mY+DQevYNDxnrbTwFHomO0j4bY6n7C4zmlqAbZo93DzhN/TmNip4tqRy2V4gU9ZhuBvfSZTDUQLCxKLJz+aLtEpS5VxChE1m3L94/lKLCGm3nUpua7kc9K6RDb3D8InO+1KS3eqHLlJzmAcPdQLR9Li6ZG4C3OOxmvUJSHpMUhWymlA6Xg0f2rIU4cluC66x5Aq9yJHMX5VmZwqOCcJzejFLReBsQN53cCWAgnlC6FnYbPBFjlO1dUj87z+LBM/tPDrBdmsg==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 IA0PR12MB8373.namprd12.prod.outlook.com (2603:10b6:208:40d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 13:57:02 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 13:57:02 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
CC: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: Pickle vs. sqlite3 for cache?
Thread-Topic: Pickle vs. sqlite3 for cache?
Thread-Index: AdrzB+H7xOUdiODQRjiIf+vFoJhVuQ==
Date: Tue, 20 Aug 2024 13:56:42 +0000
Message-ID: 
 <DM8PR12MB5430C4D4EA06B2AD975C00928B8D2@DM8PR12MB5430.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=c95a084e-8350-42c0-ab32-9305f6ba072f;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2024-08-20T13:50:03Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|IA0PR12MB8373:EE_
x-ms-office365-filtering-correlation-id: 25185b5d-8158-4d73-b00a-08dcc11fec1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?MW0u/oY3ds0gFpx9d9v1Bel6m8psNcQq4o8FFo2SDzeoMLAVB7TzSWzhMDlQ?=
 =?us-ascii?Q?M5d7vdFkJVimkHx+BTAKSwiBUaYmABmqGc7OHGfXZUK3CI8UppV6Ot04vS9f?=
 =?us-ascii?Q?kHOfL30LNSxPXcfQ1j6ylRix7YanofwbOLe+ZbNzo5zJFvcWPHcPt4pO+Q2D?=
 =?us-ascii?Q?7SL6Hqdv1wzXryim1S4AkGvrIXY7XCAttIi+B29OxpA16pRfPwtTMS82WctO?=
 =?us-ascii?Q?W0ygqzhi+CfVLQbqQ4LoZQouShpt9Fqg2nA9flKqEim6UdTxfkYzACArhv8V?=
 =?us-ascii?Q?5iE7q0FzZBpMnAjp7OOnwsIoM//z455ZnsKDckpDDGmO0B6mv8cz8OcxP57g?=
 =?us-ascii?Q?RQ2pp7scs8xIwIx+XdAFB1TR9SR+nqnXLhN/ajXXZbck5otUbsdNvIeS//u+?=
 =?us-ascii?Q?rch+ryl/g/2c7cr7Q+nthJKu5mroWaVC3gYCIxfP+ujtgHmaN16Otdnqof3t?=
 =?us-ascii?Q?FKYUkU7XGnUK/rjgPyDAO20M41cOop7RrjT5JHPi/vGMF7Flrgzor437d7Wf?=
 =?us-ascii?Q?AwTa7As/nazO1b3/ryiyYgu0tCCz3m8AhH0d0nEqot6cHF73pSa9cuctqbk/?=
 =?us-ascii?Q?XTMlRgxBNsvd/N3EFHUW49QgYhU6pOeA/8LX1t5F5RBe8NFL9rHpIvOdyXzK?=
 =?us-ascii?Q?E2HAK8aZxei4wjdQc48WU7PMqaa9YPDoJdv4PHsrd/02MRDlqBudG2iknPe+?=
 =?us-ascii?Q?AGwpEdZPYhe0l/6LFSTiWPLwnNZlKM4lpT8SZg7S9cvffjNjhLVMiiArHx9m?=
 =?us-ascii?Q?1NI2TUVXYlESWyg/5S8g8gMMuR5nHk6BPf8SKUanIf6+hqhlgMJW7ehn3ule?=
 =?us-ascii?Q?/tupUiXVoCQhLyz/w+aWOh/GZ+twqL/1lEbhfpJQ7FAEayNZKE15u/oCVK3b?=
 =?us-ascii?Q?zFo6wBfFUpvwKxoX4TwgZgX9phWYz1hYzYaFzyYmfHAL3n4Os9a6GDKZVKDA?=
 =?us-ascii?Q?gHKRssvm7DqivfWny8HgUl96RkK/N/Viuo43Zl3t7L6VeoSAdQfjTBywJ+HP?=
 =?us-ascii?Q?y4PptjRgHSHmP7KVAhFZULH+tNF0g872Ttez0QVlbEudu3HTRT9kJn8NIFMg?=
 =?us-ascii?Q?ScHkV2Y9K0QEtRwKZKEdQ28oQ8bwJj3y1G6OznrO27CBPAnY8YSU8RaA6abm?=
 =?us-ascii?Q?omBjuzeUpwCV7Jybup9BVX0I+hh05GhER0dN7sSOfpsnqRyH/nlTfAoSbsPC?=
 =?us-ascii?Q?tbB1lD5MQ5mpj12R/QOF+cdu2c4k17cQUj1XJLTrw5S+of1OEqKVJ0u5ydU4?=
 =?us-ascii?Q?8iGyNDWomxeqSAAHNhv/cjtzmOF+bVI3Jtc6UTbVC3ZwY8d1Vh4eW/xy3Onk?=
 =?us-ascii?Q?h1QD3j3XfPpfFeCf60f6gOJ/QQq0/As2Zc/ScqV8VCbugdmXw5Up94n5JSv1?=
 =?us-ascii?Q?93TJmrRXO0/JYgh/a3UPkl1qmYLr2ioY3gyd1ONyhB/U32BsOw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?zYSaBFA6Z1kP+AmB7kx9CBW3BM757og3oMdySGZtDpcl4o/S6dXUst+6ju+3?=
 =?us-ascii?Q?e9ODknCZ8rK8ImuGMBF55ynvnUOP0kpeY0vEtOCNT4fYDrrz32T8rW20Ng7v?=
 =?us-ascii?Q?KiaHd2KsBo2CwiDPrf4KmZZvkvAxllcKaeYcNgyvK2AavxdVLpoIjGi5jP87?=
 =?us-ascii?Q?rzOOApzmm3O+GTOiCb2Gf28gZleBhMbyS+EnsD55hx6RGMzC4KwB/6sWXXuR?=
 =?us-ascii?Q?7fckjBTI3ZibKAeTi/wKKFdfyxu3Q6ALxnKbTr6l4X+oqz6Nu9nY9gk+wwoW?=
 =?us-ascii?Q?UHHZZlW5K+KVkEcUdv9abLuMBZKBO5QOfMv4MDsxwdlxhwnwMnY8xNku5uca?=
 =?us-ascii?Q?CoQEQCi5bE2sOc4roWXrtm+DanIez/gAYiIJPTTWv+KwDDabhNGZganclKlm?=
 =?us-ascii?Q?esgbNYsB5Pe05Lia10tNkGjvQWITckCOKDmpzkS4WmpwUM2OYtcNPe1I816O?=
 =?us-ascii?Q?oZlsU0O2SaAh5JuRqzCAR2EDeXWAKg4n0DomVXt7p/pyUHD0oKx0nYgkgkGM?=
 =?us-ascii?Q?vaY5a0ctFn+iXFAoLOhi5sSrPJ7iG/hNSffKrRUrsQZEZV/oRVo3W4WquE0u?=
 =?us-ascii?Q?zeJiGWborRvSr4qo1yvvYr14NPj7rPg4ufkuAEDnh1xtl+87LcLt96K4hebb?=
 =?us-ascii?Q?xT9L7iRtyfeeZHeUdFyzks6GEQnGvFShmGW0NkQDtXwLIzVY+LW5wN0iKCWW?=
 =?us-ascii?Q?5J2bKfHAxC3MysaEgv3QgXcxIxLCtJ5hHiZz+uAN5hQnMMeZXUhNbJ5Dz8d4?=
 =?us-ascii?Q?aL2EMCAKOfJB33We9BxEsTENW3PG+6bPCpn/ymHCX5MDiA1Aq1+GNWyNlSa2?=
 =?us-ascii?Q?lJE5xofXuzs0B0QramAysR2vBBVW9cAy4ID2Q/DDbPQVvTGPAMQzPlgP4QJV?=
 =?us-ascii?Q?QK/PFPNZ+zyddaVjnT39psrzxiXKeT9+Qm3+qK8jFasd6f3eeCUDJCuIF89S?=
 =?us-ascii?Q?uQ+bks3xThMpPCt8KZdDws3S77OCGL7eEfNhqDuj4+pHZOsmrJLJ610M8Cbi?=
 =?us-ascii?Q?q/BUVTGIyuaMo0N1+hs/cdzL2W/EZakW+aoqh2nrKu3giUKsXkgt9+LjAsmO?=
 =?us-ascii?Q?oboUz/e0sB9HL8Q3iZyLmPYeJicmgnxinHJWA/xHhCZybMJ24BPP45OhsOl8?=
 =?us-ascii?Q?1RZ5MrmucjHIxulOGcYL/ZGqCDfOs9Xd/3++G+V15WcgeDD2nYteMIx5Xb4W?=
 =?us-ascii?Q?MHedzkLVgY2rwIy+rn/Gn2cup8hoWlxXYyR4b/U8hKrst8Q29ldgFb2zxn6z?=
 =?us-ascii?Q?LsSYXXv2fSX/LSComj7sbNZ/46TSvYJNG1SVcM2x9KXTAXSRS+XOteYQo2W1?=
 =?us-ascii?Q?NqU33YARrdAkTsSNB1z+4iDX5MJJ/LFNUg0sy6ihtMtCr19xjkVaBdNLSxFs?=
 =?us-ascii?Q?5C9ZwlbWFwj3YfjGl/xbpc1xhqJiJbEbkw+2BhCLPScu30g5OYQoqXI+10uk?=
 =?us-ascii?Q?MB9f24wjuYOTgXjJcDgWwHgOveRgEzh9gF8oZcxMbdHD29USw/Af7p1ogJ2L?=
 =?us-ascii?Q?4PTCWFAwTN8x4WnHZc1DZ9Ll5Gdae+IsVG/wtFbBSV3ng8AWi5JjoCllKe3C?=
 =?us-ascii?Q?gw4OfUtW1QxTy0AxrBnhemcOlVjDNRyWVKrKrC+h?=
Content-Type: multipart/alternative;
	boundary="_000_DM8PR12MB5430C4D4EA06B2AD975C00928B8D2DM8PR12MB5430namp_"
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25185b5d-8158-4d73-b00a-08dcc11fec1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 13:56:42.9117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oTIBoBfvoN9ZclbYxoG4CFbZL2Ufts+AmTI8DVRhCv5842tu95kQt4AWvHFv6urU9R+1Y5/ZvIJ3xQfyCpQPpTvbKG5hxHLj74Qqubp3ZqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8373
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 20 Aug 2024 13:57:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16499

--_000_DM8PR12MB5430C4D4EA06B2AD975C00928B8D2DM8PR12MB5430namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

Apologies if this discussion has already happened (I searched the archives =
but couldn't find anything), but I had a thought the other day. I wonder if=
 the decision to use 'pickle' for bb_cache.dat still makes sense? BitBake p=
erformance has certainly been getting better over the years I've used it, h=
owever it still seems to spend an inordinate amount of time loading giganti=
c pickled data into memory. I wonder if it is time to dump pickle and consi=
der sqlite3 instead?

Just wanted to get the discussion started, since there's a chance there is =
some detail(s) I missed that will stop this idea cold :(.

Thanks,
Chris

--_000_DM8PR12MB5430C4D4EA06B2AD975C00928B8D2DM8PR12MB5430namp_
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
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
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
<p class=3D"MsoNormal">Hi all,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Apologies if this discussion has already happened (I=
 searched the archives but couldn&#8217;t find anything), but I had a thoug=
ht the other day. I wonder if the decision to use &#8216;pickle&#8217; for =
bb_cache.dat still makes sense? BitBake performance
 has certainly been getting better over the years I&#8217;ve used it, howev=
er it still seems to spend an inordinate amount of time loading gigantic pi=
ckled data into memory. I wonder if it is time to dump pickle and consider =
sqlite3 instead?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Just wanted to get the discussion started, since the=
re&#8217;s a chance there is some detail(s) I missed that will stop this id=
ea cold :(.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Chris <o:p></o:p></p>
</div>
</body>
</html>

--_000_DM8PR12MB5430C4D4EA06B2AD975C00928B8D2DM8PR12MB5430namp_--

