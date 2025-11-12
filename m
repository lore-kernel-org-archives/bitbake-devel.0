Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E1BCCF9F8
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 08:05:44 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.36])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8335.1762934743143225518
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Nov 2025 00:05:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=UISPpncg;
 spf=pass (domain: siemens.com, ip: 52.101.72.36, mailfrom: adrian.freihofer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OWdrzlBecYTwnsGxfTZrVo4JURKdCuB+dpu1h0+4XAlT6uo+Nk3qES5sSTES5kB/GSUZ0Tnd9ZYf0Xe3KmKsoAHXenbbSJgCe0jpt5Ps1prhVRJIyaeWpKsM0y0dtmFUpsnqmEdGpLVITw8RmM5ZG1nREOtAws8t7ipDWUuP9Ez4UEU6lRQsgxkuXsGZkcHLnu8Cw+pde0wETgS+7K/vYikTOVqJTPvnFfnAuEqJ1P1qiPuvLJPxY82H6y45+cfCth33YIcdQzLcpyDD0bb1/skGT9D2/rIZxzatN+8p6Z3nTYjJf/5fTKsLkhY2q4NIBLoMdADl9E4dl4LfcyAjUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/78l9oYMqEbbTtJtBq123IjXNB5idO6BlLkU/kM4sI=;
 b=exeL3VXcdD7NFTwFJU79dlzCsPVP8fXFA3lfgu/yDl2Jdoe46q2KUmaWs9+pDwoOU2adHRuTnB4/7cAudKkUwkrUoLYtZNeYLL0KEO2m0mm9+5M5sBdjmv3TPQThmCO8HjzhDbq4JD5trwmnWl6kNX0+fJP58AVd/7sdAKDgZhCZ/hLF2oG1cdBm9WRT0snoGSVJ8bSZFnb/l7FH8G1H3a+FcSigZa+SMHVGVnKNLdtyZ5CVRlCkVO6VIHK3+4wOSrKJJCEQ2w9Y414N8FXCTbl1jHlEVaMMry87ly1zVUhL8VguKAdwEO4URZnW+v1vLkH3C/xzsOGHUEIsuNg34A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/78l9oYMqEbbTtJtBq123IjXNB5idO6BlLkU/kM4sI=;
 b=UISPpncgMEUXyQ5/btCLWkfE4wLSVy6TZbCWPcP/YOAWlLohyLNg4f35fwOZ1XSN7FtRAEzyDxVnnby0fdZ6rGg3sAEr1sM4OTjuV1pESlT2U2bhXu52HD/VPsxMJUBOxIAtv5ib30gAUNRhYBdopaKeMFAUqPgpQNy3QvyLCtmcJSnm4pxTg7VOWjxlxdq6dPoOxvEQ4M0z7Os365ebvUeWRQTQ16wUnbsXO5PpL4KdZeEwQVeUlOcyK6+UxsuDLqoW6XkcuzqaRjNDGaXgrdXwhc2MZ9hzra8UZiuJ8pSu8bZF5qq68UzYFNLUTCoc0qLt1d0n83F+6jTVe6jFTA==
Received: from AS1PR10MB5724.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47f::8)
 by DB8PR10MB3895.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:148::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 08:05:39 +0000
Received: from AS1PR10MB5724.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::50:b275:11f4:adef]) by AS1PR10MB5724.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::50:b275:11f4:adef%4]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 08:05:39 +0000
From: "Freihofer, Adrian" <adrian.freihofer@siemens.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH 3/3] bitbake-setup: default top-dir to
 empty string
Thread-Topic: [bitbake-devel] [PATCH 3/3] bitbake-setup: default top-dir to
 empty string
Thread-Index: AQHcU1tPlR5zr1o1vECA5TCPPO2dorTui5CAgAAe6i8=
Date: Wed, 12 Nov 2025 08:05:39 +0000
Message-ID: 
 <AS1PR10MB5724943BCBB7E6AF8B5923D88ECCA@AS1PR10MB5724.EURPRD10.PROD.OUTLOOK.COM>
References: <20251111223325.2034322-1-adrian.freihofer@siemens.com>
 <20251111223325.2034322-3-adrian.freihofer@siemens.com>
 <CANNYZj-msfr_qFD_3UNTB2BCm_Vqr25cuOfPn9=0yNo0jzYjEg@mail.gmail.com>
In-Reply-To: 
 <CANNYZj-msfr_qFD_3UNTB2BCm_Vqr25cuOfPn9=0yNo0jzYjEg@mail.gmail.com>
Accept-Language: en-US, de-CH
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=True;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-11-12T08:05:39.214Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=C1
 -
 Restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=1;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR10MB5724:EE_|DB8PR10MB3895:EE_
x-ms-office365-filtering-correlation-id: d78b5cb0-ba54-412a-4c67-08de21c24509
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|39142699007|1800799024|31052699007|376014|38070700021|8096899003;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?11uGTUxfAU9E22JBHU7WZBGXaHS5QQHZamXUmUMUNWwQKgDnaryELpU26G?=
 =?iso-8859-1?Q?XliGK+pSZubZeIZl8q2YFHRyNAkU3bxuoPlm8n4EHh9jzZXy35nBJzhfdU?=
 =?iso-8859-1?Q?q7B0l27NApaPK5O19Xg1xeGBJj2hLsLDHhdLDro1QcPsaT5T7zA99BZRIi?=
 =?iso-8859-1?Q?jk19Aj5FYuQBwrGsWUosazild4/p3Hq7P5ENeyytr8bmncA+4zltyG7BaE?=
 =?iso-8859-1?Q?+7NeZdyyrXkq7MdLBqkskPGRyIAZSsTdKLkeFeMoiwXumoNU4k0ViPPfyo?=
 =?iso-8859-1?Q?13bC4pYZE8axUPwRsvJc/QW8EngMqQjTBPT7J87PhGMJ3CPO2Gu/quMLIQ?=
 =?iso-8859-1?Q?Jdk+KD5xjBR+GgptjlU2BM6jHiyyGDs+uIcSSbKNDwjPuZf4aOEPZuSjkH?=
 =?iso-8859-1?Q?AuRMTjq4flWiyd/YuZzPxSNqWynrc2GYJm3yriWwY0YGfLkyAiunG+nPhB?=
 =?iso-8859-1?Q?ukbKnOt24B6WRe1ozmp3g4XqZ4eYM9BCviBdXo6RpIZj0HFGQmv8sKXWut?=
 =?iso-8859-1?Q?t83r1JncSz2u9tvveqHfG4baU8NqS4QT2c3bVx1Oq+qGiKDLsgIJ0wypSY?=
 =?iso-8859-1?Q?v1HqD1teHAweUZDhwGTAuy6M+IsPbaZ7f7vjq2UP3QofdoKIk1jzOeR7wZ?=
 =?iso-8859-1?Q?QdT+Bpis7agEgQtkEZRkNFRc9dMpOLptGRC1HHSNX3xSx1Z5vXVq+IFFzC?=
 =?iso-8859-1?Q?57cVHiUDTCfWW4dB12oeSUs0/r391bPkQg/bH3o2F1hLkMKiZRpFas7Rfp?=
 =?iso-8859-1?Q?ecftdmxHNur+bMDod2kjBzeKIYeISP89DpO/owi1Rx0Rv2PLVmE+kIcF1F?=
 =?iso-8859-1?Q?2/DplLcUBzap1VIGNzw6mT7JD/PguUR2U3a2+ULvB4VdhO/8imShvuA+ec?=
 =?iso-8859-1?Q?RY2lqKSIIQmtz1YuT2XRDOwHY8KELRPJWTH37vonqD1NNEE4M0QUvD7B/p?=
 =?iso-8859-1?Q?4tB/3EFF+acOJ6iGO3qu2HpC/ghEByR6DKVJThUyyJ9jnOPRbhKOCNtuT5?=
 =?iso-8859-1?Q?lX8Psp3eYuuAIV8EVXFbSd4UF01xOuIkggey+Mo4zxIhdFfMx2snXk4wyM?=
 =?iso-8859-1?Q?Aih3JzEQX3t2dWygzuNY3F/7SyJEePgpcYI1J533YJOb4NS24vu1c9NvK/?=
 =?iso-8859-1?Q?ifMto+2rXAahkLymXmIhag8PDF1vZtCGarQiuslirO7SHXFf+Zjd45rZCg?=
 =?iso-8859-1?Q?gyBSjEw8Sku352R5fmB3ajmD1lptx0hjcST6/QP55v5ngD3VJUh/6i8hel?=
 =?iso-8859-1?Q?/UFNONhOVQSYcwCby0A4eriP41Rm3CWAe5BHkJt49WE8d+lzrQ5NJ1XRv3?=
 =?iso-8859-1?Q?PuN95nZaepNXM6L5belk+e/sBx3/+Ic26AfYz1a0/HXTYhiz2JvN8zyyTl?=
 =?iso-8859-1?Q?2p+JfM+5wjqgtu0XG8hBUiMkWW3jqsKjYCop1uGziCp5npNhYDDnBKNjv9?=
 =?iso-8859-1?Q?xZ8G5O77s8paLOHq/tVcmDCaUJi5K4jHGtnGb6X1ZDKzL1020DBD5a1SmN?=
 =?iso-8859-1?Q?jyV06ZBdcv17MaDDV3/SQ9DGwaWaZiBzpaNy/w8B243KqZRg9JkGdgOivJ?=
 =?iso-8859-1?Q?Nhx2E3JmvpFQVHDdELapZ20I/NmR?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR10MB5724.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(39142699007)(1800799024)(31052699007)(376014)(38070700021)(8096899003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?m3Xph7MpRqyCuzt+Rea8hrvdzFAraI+eBQXHTQrrDrnbFgSBdvpJUKlLqa?=
 =?iso-8859-1?Q?q/A8+GbQzVF4RIBc+/CQ+iTb9fuGGHEYCiGmdqBolsjaVkgK706aH7oHFe?=
 =?iso-8859-1?Q?lxwtEmuNDltkBqp1ByI3te+xU1kASK5WrOxGJurkYBxONwR54hla3LT9hc?=
 =?iso-8859-1?Q?QTuFxTzypv4PDMUjDChqgenfr9YG5TGqKUd+L89+D7yYFH5qNVFMYdKGK9?=
 =?iso-8859-1?Q?wfmjHBeGwjqremLjj6Xc3q5lYuK8S1UI5dlNS38hU6N4ufLx2dQAtuWbil?=
 =?iso-8859-1?Q?30Na0kJ2Itjye+3NsjHHf3A6SfftYUU5x/EcVk0nUXDkojOM46TfAoOf7B?=
 =?iso-8859-1?Q?hXajJ3QlVGFSfm9yFwbiR16/FiEJqQ90mIaN2uAgTHlzztaoxMoqQQPY2o?=
 =?iso-8859-1?Q?y1v16FRZ4U5PFg7Ym3Ij32hFu2TkVvc9kNbPgu6HV4by8jfKr4O+tcZzyX?=
 =?iso-8859-1?Q?3MFEGogDIJkjntyllUOUg1OqGzx6+fEvTIm6YpbCSmzGJ/iSNFfnD3E4GV?=
 =?iso-8859-1?Q?UXn2a1OSCXJhZzjHpxMXwG2sPD69pqyQC+Rdu9VsbU/iigh1RSRVXwJgTc?=
 =?iso-8859-1?Q?lv3aIIU1MWwEwc9x8CC2Lg6KHDRVvN57TTckO/HkWehtAIKKarbnH1FxZz?=
 =?iso-8859-1?Q?ZlnwsE6EDyvpFJI2m4JeWv2Fd8xiMbkR0s5sQe4oU6Hbx1EAt5suvFuq3+?=
 =?iso-8859-1?Q?tlAKhFlfW8z9A8ZnKRu6onXSPDLWDfUu/O9EnExcIhZFiunyzWoczS6PYO?=
 =?iso-8859-1?Q?874CZvunqxnNW3F3weSNCThKqFuZsbKmzw7xTgrSTSrBJBxybysbE95+bF?=
 =?iso-8859-1?Q?6ID/S8HfUGfrS2PVZI6Kgw27csPlC8zLeJglh21oVa6ERQbXZDJVNBtL+W?=
 =?iso-8859-1?Q?u1R2O4O3PaojzB+lajewsMjUhEahOuAYqBf/P5c9/rZuGGlS7h3cZh1ft8?=
 =?iso-8859-1?Q?4SHBKNAvEtt1IYyV5nNZ62PsBDSkgoN9HMabAm2/TP6tMAj2RhIyQO8OAF?=
 =?iso-8859-1?Q?wIMES8WuF7bJNJSGsEMUa2d6QqstyadQIeQckBf1S7Jt4I4ldyK+c/pHWq?=
 =?iso-8859-1?Q?w3L3gqHMEoZnODdbaKdckbYlKFKob4fKG6twVrgbbJ8vBMVInFz25ml2eo?=
 =?iso-8859-1?Q?gxvskwp8I/y3u2S8S5PRXpHZaLR0GYUWERWAAsR030irVHfdIQdKsPjyU2?=
 =?iso-8859-1?Q?Q02p2a1azr3QkhSsoPi4tYrXgFLtK9nhD4m77J+nhrvanLMSzHDAal09e5?=
 =?iso-8859-1?Q?FJKCchHJcQVwYAKY3mM6+lQyvKOnWIF3nn/VqJ7efAouXTIyut8s8rg2v6?=
 =?iso-8859-1?Q?S8soXW3b0BzUX12HO1li66EbQ1ACSLbN0hqUI2y1w9OQ95pJd/6aZ/7OOM?=
 =?iso-8859-1?Q?lsWE17OTQJwgVBbMOk3W6uU+DjEATAXkfQ4YiWlo7ssbX9dZzLgy1D3mDE?=
 =?iso-8859-1?Q?S7K7+od18eEUee6kUB/l+EWq48EBTVX2KdNUGqkH+Ohsfi5ScZy0q+Hi8o?=
 =?iso-8859-1?Q?jeTXUHOxsRy3yOnJWfJ3f3WxaeQJNU3Wjt5MCIdynEHULt4LjbZNN6YSuX?=
 =?iso-8859-1?Q?VltTyNK8nLjxJKgP0OG23PopGF6X4sIcMhPNzwvJ6UnBKF8SKMoniR9+iH?=
 =?iso-8859-1?Q?1V/qiU9WCJdZWvkZK6zyL48wCvzKcyKuOSE3u060Jpj8WRCiR3urfuew?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: multipart/alternative;
	boundary="_000_AS1PR10MB5724943BCBB7E6AF8B5923D88ECCAAS1PR10MB5724EURP_"
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR10MB5724.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d78b5cb0-ba54-412a-4c67-08de21c24509
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 08:05:39.8232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xGMZY6wr7lCeBgghAS7lKPZ6RZQK6+DnjypwFZFIw/o8x9uiXPyRvEjfBpvI9QKhHAqlFtjbTEz4D90+BG2F7XzFcKkxjwhWBRIgfMGCoUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3895
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Nov 2025 08:05:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18346

--_000_AS1PR10MB5724943BCBB7E6AF8B5923D88ECCAAS1PR10MB5724EURP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Alex

The workflow looks like this:

  mkdir top-dir
  cd top-dir
  bitbake-setup init

If top-dir is created by bitbake-setup, we get one useless level of directo=
ries.

We could argue that it must be used like that:

  mkdir top-dir
  bitbake-setup --top-dir=3Dtop-dir

But that's not what I would expect or prefer to type.


Maybe the logic should be:
  top-dir-prefix=3D""
  top-dir=3D.
?

Regards,
Adrian

--_000_AS1PR10MB5724943BCBB7E6AF8B5923D88ECCAAS1PR10MB5724EURP_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: &quot;Arial&quot;, &quot;Helvetica&quot;, sans-s=
erif; font-size: 10pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Hi Alex</div>
<div style=3D"font-family: &quot;Arial&quot;, &quot;Helvetica&quot;, sans-s=
erif; font-size: 10pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Arial&quot;, &quot;Helvetica&quot;, sans-s=
erif; font-size: 10pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
The workflow looks like this:</div>
<div style=3D"font-family: &quot;Arial&quot;, &quot;Helvetica&quot;, sans-s=
erif; font-size: 10pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Arial&quot;, &quot;Helvetica&quot;, sans-s=
erif; font-size: 10pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; mkdir top-dir</div>
<div style=3D"font-family: &quot;Arial&quot;, &quot;Helvetica&quot;, sans-s=
erif; font-size: 10pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; cd top-dir</div>
<div style=3D"font-family: &quot;Arial&quot;, &quot;Helvetica&quot;, sans-s=
erif; font-size: 10pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; bitbake-setup init</div>
<div style=3D"font-family: &quot;Arial&quot;, &quot;Helvetica&quot;, sans-s=
erif; font-size: 10pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Arial&quot;, &quot;Helvetica&quot;, sans-s=
erif; font-size: 10pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
If top-dir is created by bitbake-setup, we get one useless level of directo=
ries.</div>
<div style=3D"font-family: &quot;Arial&quot;, &quot;Helvetica&quot;, sans-s=
erif; font-size: 10pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Arial&quot;, &quot;Helvetica&quot;, sans-s=
erif; font-size: 10pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
We could argue that it must be used like that:</div>
<div style=3D"font-family: &quot;Arial&quot;, &quot;Helvetica&quot;, sans-s=
erif; font-size: 10pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Arial&quot;, &quot;Helvetica&quot;, sans-s=
erif; font-size: 10pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; mkdir top-dir</div>
<div style=3D"font-family: &quot;Arial&quot;, &quot;Helvetica&quot;, sans-s=
erif; font-size: 10pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; bitbake-setup --top-dir=3Dtop-dir</div>
<div style=3D"font-family: &quot;Arial&quot;, &quot;Helvetica&quot;, sans-s=
erif; font-size: 10pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Arial&quot;, &quot;Helvetica&quot;, sans-s=
erif; font-size: 10pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
But that's not what I would expect or prefer to type.</div>
<div style=3D"font-family: &quot;Arial&quot;, &quot;Helvetica&quot;, sans-s=
erif; font-size: 10pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Arial&quot;, &quot;Helvetica&quot;, sans-s=
erif; font-size: 10pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Arial&quot;, &quot;Helvetica&quot;, sans-s=
erif; font-size: 10pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Maybe the logic should be:</div>
<div style=3D"font-family: &quot;Arial&quot;, &quot;Helvetica&quot;, sans-s=
erif; font-size: 10pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; top-dir-prefix=3D&quot;&quot;</div>
<div style=3D"font-family: &quot;Arial&quot;, &quot;Helvetica&quot;, sans-s=
erif; font-size: 10pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; top-dir=3D.</div>
<div style=3D"font-family: &quot;Arial&quot;, &quot;Helvetica&quot;, sans-s=
erif; font-size: 10pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
?</div>
<div style=3D"font-family: &quot;Arial&quot;, &quot;Helvetica&quot;, sans-s=
erif; font-size: 10pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Arial&quot;, &quot;Helvetica&quot;, sans-s=
erif; font-size: 10pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Regards,</div>
<div style=3D"font-family: &quot;Arial&quot;, &quot;Helvetica&quot;, sans-s=
erif; font-size: 10pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Adrian</div>
</body>
</html>

--_000_AS1PR10MB5724943BCBB7E6AF8B5923D88ECCAAS1PR10MB5724EURP_--

