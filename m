Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45ABEE77199
	for <webhook@archiver.kernel.org>; Wed,  8 Jan 2025 11:36:41 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.43])
 by mx.groups.io with SMTP id smtpd.web11.17511.1736336192544273302
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Jan 2025 03:36:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=IL19gVLl;
 spf=pass (domain: arm.com, ip: 40.107.249.43, mailfrom: ross.burton@arm.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MFFDz1UkI36ZRa8OCqyouH9G0WsVVhY+rMxWM1u29MYNQRKxxT2howFtFIS266/G1Bkv7lyNiLfhJxKfIQ6S1zJaIejRqCjEnvV4leOlbimNF4GRIaRIiOlcPPAqzCUc95PyZPi5Qz+gLjrTPvCp81MaC4ZP4ksDW10+jMa4pfilPa2LpP6uToLTte5t+NyAbuwEJ4VEa6mRvOozHoF6w3JQs+UgkP4e2fcdhI2qOPkGJG8BBd42oZR4Io5Yh1up+0rKzUnwPD7hHhnt9hW+AqNU/5DPX6pJSl5ckOSpo+MHG8vGnTMfHTIlZIZjLzCo2bAmYpHLrTqMIDY8llPrZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJA3XqezPEa1hMZwBuY+aPudkt54Ndw/K10rLTEhMMI=;
 b=Z77f7nYCiCHJPGhcI19i+j3eW21y4jTG15IGQrbn/wMgq2Zw4QBDsMs+UoQnw6Af4ZV8aG8S9w+xgh41bTikRH7ZUzQPyPhQMRGg8QDV4NDNrAgo/F0SQmEXHK8I5iaBtXn1RJh9AVGJvwYn0SNhIZLfChDv72fNRThC9fFRUGzgsn789aqt4ZC6s5VeocRV90jDwrNPCJOlh2xPNTU9KX8JOc9SKddG41ZeHvUhfyJsTkiopa5B9sATFaURDn8GQADR04KbVteweaYhNqMG8hoNsHXkNiKc1S480yP9GQ0xXuwEGCQjFFZUndtuFJqeGtq19WMa0GQwgLgu4ZEbFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJA3XqezPEa1hMZwBuY+aPudkt54Ndw/K10rLTEhMMI=;
 b=IL19gVLla63kw2mkZLCvpbq0C68ESoycVSRJ4S4r8luh7xaDimFoExaACI9cuHAf5/ylREPgGVIsS5WhhhGEgKIpUnKA3j0q18bi+qk5ioFZ0OK3m/0mAIg5eCHPxY76iLwilgupgB5od84/6MVjKAD4zlMgEG6CHhd0+BinnHY=
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com (2603:10a6:102:2a3::12)
 by AS2PR08MB8671.eurprd08.prod.outlook.com (2603:10a6:20b:55e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Wed, 8 Jan
 2025 11:36:28 +0000
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::9206:40ba:ef7e:729e]) by PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::9206:40ba:ef7e:729e%6]) with mapi id 15.20.8314.015; Wed, 8 Jan 2025
 11:36:28 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: "philip.lorenz@bmw.de" <philip.lorenz@bmw.de>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] asyncrpc: Handle websockets exceptions
Thread-Topic: [bitbake-devel] [PATCH] asyncrpc: Handle websockets exceptions
Thread-Index: AQHbWrgJ5DQKg+raN0enaQ8whAtxH7MMzZ+A
Date: Wed, 8 Jan 2025 11:36:28 +0000
Message-ID: <589E07F9-08E5-4997-B1FF-D11DEADDA500@arm.com>
References: <20241230123547.2593913-1-philip.lorenz@bmw.de>
In-Reply-To: <20241230123547.2593913-1-philip.lorenz@bmw.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3826.200.121)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR08MB7411:EE_|AS2PR08MB8671:EE_
x-ms-office365-filtering-correlation-id: 6f82e1a5-7c44-4a39-c8a8-08dd2fd8b0b9
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?WrcR+LzhRUEMKp6KEbycotVFGB5TlGs7FUSm61PMcBjjNa1LETWWLYWRX92G?=
 =?us-ascii?Q?bifPver3Zndmt7E1G8vnTvHNekI3V77dN0AHyiDvHCE4HrCPakP129cpNu6H?=
 =?us-ascii?Q?9ThMjhx3DYzO4gvvzCaJRB/dsahdBQJsqG3h3Ekcq3MvtTCR/6B0/Zz6kd6I?=
 =?us-ascii?Q?7u/L+ODnUtOj7YZZDNvXE8mDDwJ21Ba2jOyjnR2zMnfeC0VYLNhJMip73JCQ?=
 =?us-ascii?Q?JCCnFkc87YfeyRCvHfJmapmrCya2kYrVNUuZbhMpzxyK55cd6FONkxj78IqX?=
 =?us-ascii?Q?plVb1lyZNpWvjs3+p3DBT1+gmreGnRR3Di60UTlyGUVz+t6vZ/C0AmiGlfsc?=
 =?us-ascii?Q?k18rVvclT1/GWyox40iBE+mcnKrDSKYOaE8F9GONI5TFQeHw0DqdWPdcCese?=
 =?us-ascii?Q?tVk0QouOpXEDZ0JAAvKFhC086vTmzPs15eD0jnFRYVNq/r7kNM4NIefFcQxU?=
 =?us-ascii?Q?N4AuRBLegfPXC3I0b9QdvnE0Aowhpi0yI+0cgw18COjMWDg8s0J9J55Fm3hj?=
 =?us-ascii?Q?apFEac9FPDxUp7UCDr+csQUHo8/rZO5P3k8/hcEQx7UYt+mvc4k8LgmPkKGj?=
 =?us-ascii?Q?vM8cuu4gW6j3fABaPThArugXy2GYCAP23TxHPGnWkovle2C+jy6tDfUwpKSK?=
 =?us-ascii?Q?NJOFYvnkAZJxK7MKmL3hfTbXWROMO0gZ7RdB+TjVNhVLMCPTVSTRpWxBZtXL?=
 =?us-ascii?Q?6Dbf7hg2eqj09oVc52xNFAEbnbW5F5Yo8UtkC6o1b6jYB1eJXotmEEG8kp+g?=
 =?us-ascii?Q?1WxQPTDPpcsIYUcz2epYlw1ixUntWtMtwo80gPYJT2wlf+tXHJcKVxvkq3mw?=
 =?us-ascii?Q?ip68pbwBNKhfs9baLg4s89cmMl8UCLE7n/l8BIaZtC6ii+h3owix3J2FcLDp?=
 =?us-ascii?Q?zynzdFTP7KMOWEzbSeCmdLy9khXDymtZuqe1dzer171QqbVxTRmts/ZymtJX?=
 =?us-ascii?Q?eeajhzVDBQS2MffOa4xllUXcMiOFJw1wvAaQ9WIxbKUkZ/FqEYb6ZixdQQnC?=
 =?us-ascii?Q?Yby75ax2nsaa/seBU6AJlspUF7f3nCHiwcOTT4vvHfBXJkiW66VuIfVgXi+A?=
 =?us-ascii?Q?Gq+xgoGqYXKBrXHd335VpGbbDaVDJPJIq1gtkFj3P1Fb1pOtQ4JrNAiG0H8m?=
 =?us-ascii?Q?wE5Ncr6FEQykL79rN79+YG8ABrH5RXOkl08XPyZdxWvwXOmeK5292OudeZcX?=
 =?us-ascii?Q?WgB3DLvpRUkS7W6nPY7CJfBz8txyu9YIeVFpfM5meTiEhs280wWDiRBu0Rm5?=
 =?us-ascii?Q?n8icKY2bPC+U+wNLTs3S1MxQawT9vLU0Yh2oU7BBP4XYYk2Aqs1Gj1hc6rTp?=
 =?us-ascii?Q?gWjOADOpfRTfF6K9e1eDvPlsJ6iK9KsFbi7hgRktn+Sas2V9xIoLLFFuI5U4?=
 =?us-ascii?Q?+UAOEIVaC1clTn/crfDf9fMGecoyyLlaUAzL3dpUKZM44OlEWpFHUodYPps/?=
 =?us-ascii?Q?448XGP8PDA2jAVoiDKR3kINY64c+A9lB?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR08MB7411.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?ut2M3+zxXew24FVXL1eUY4Mxc4vBsKUEo4kGEvFmBZ0NW/TPT3nlncQqcDcP?=
 =?us-ascii?Q?tY8CMKKNno67JV7VdMrJMUpNy6p64Dm3ApInl8gNMAR/TV8CnkDP6gpUH9rG?=
 =?us-ascii?Q?xWKW6zwjOBVWWP/otzIfL/pEyxcAkb/cPU5oMhpt5al7m+9IcqTZvU8AlQKZ?=
 =?us-ascii?Q?sUsUKTjAY2G7H94sAEJo+V9cTYAlne9bxih4xbjFkUwTRKnkBsFqE5bS5l6B?=
 =?us-ascii?Q?UpbjnPj0pLWxm4pzWGXtJj+emzZZ5iy02tAMyzobu/7MdyXtw3ZoUAnuSZdp?=
 =?us-ascii?Q?YiTyMYwMTWcuayHll/HEp0vGt6NdVbf5eNSSDsXJd8al7Zk4ewbgsdPdHhVt?=
 =?us-ascii?Q?v5p1ELdIv1iv/LRMnLFEXc79JUXGk5oDSX3fDIy4RyNE/CfH8xjsl9cNC5uz?=
 =?us-ascii?Q?IV7C1peQSDaXQCd/SMDD9tQ9RKmoJ8XSsft3LuNKzXCwTnJcHuKQLJAsEytP?=
 =?us-ascii?Q?Iu6s4Ipz6nbciYETC/zf/cX9Cx+e9lpzKiY1CWZdwwNWwhrydtklVHG5kt0Q?=
 =?us-ascii?Q?nYs4cx1MlpxLoH9a9wky2wqF53Yhzmsd6x2D75pk+WWfmRyDNyrzxxUvyvBp?=
 =?us-ascii?Q?1c5uTBS2Xc7D/9VJ54kCccFyOCJP7+fD8hyF4x3ktCz6Gg2Bjx7+6Wc47P+6?=
 =?us-ascii?Q?oPXqy6ZrmbvugntlGLo9E/HCcNLYI09rQrhp2wFEaUfW301zC7+cL8t5tuNT?=
 =?us-ascii?Q?Rf3VvnDfq2Im/xlASDHL86ZWPos37WrzPZMCuJRowulZsQ0n4IRemkWnNKqA?=
 =?us-ascii?Q?14GIEkFxd4Z7mzfLD7AxKC8+yw8GuqdpdmCUvG801DuUQlQaDAnBNOHaCTKu?=
 =?us-ascii?Q?5OZ6sPXg6pRv496sBVM+4NZ4kpwjnWv3IicDGGocxYi8NVgKIBKZ7GOP0BxJ?=
 =?us-ascii?Q?TV04ix1hTy+V0nI7LgfljKL0kHSBJINq4W/0S0w9ReF+I0n4pC6RZ7LPEdtD?=
 =?us-ascii?Q?Pch2zPpu3pTSbFkYlZy3ULqbdbovy0lkrln/fNFrHb4h4ENIIFRAljm0Tiku?=
 =?us-ascii?Q?VBVjX/ofOxRF7h0mOZ7i+sONvRkkPRnooGl+DmCJ6h2hJprYJ8CUjgO28Yt/?=
 =?us-ascii?Q?rZhGPPi2LufvewgbrhuX/40oxE6cHu3T4SaJ3DSy/aOEtk2+O+RF7Pl1OMVT?=
 =?us-ascii?Q?G6Ucs8WJvVXU+ayhNy8AxXIySO4ZEzBe1/CCi+OfqDXs1cXskXBOe+15twHS?=
 =?us-ascii?Q?T5fZxA46c/X9UiwYHeg4hpR9eFJK87zP8rkqP0FiBy34t4BDFStoBVG2WPQT?=
 =?us-ascii?Q?VrR2i7xo1qz6oG2xV0V/AZNGuEgPw19KV0hiyEHyNODWMAVg2wurVOyElpNY?=
 =?us-ascii?Q?EQTHFC4hqIXy3INH9h+M9X7ziwnpaRW5Vmv/qCW6FK/ap2R73Ch5Tdv+pHGS?=
 =?us-ascii?Q?RofrudcgZ0E9jxAmsSTHtaOVVXDb35UaPcfff1Eu8A2So6Om+fQejDdatvrw?=
 =?us-ascii?Q?DMhtaAJyUDZ4W15GEQ4hLH2teAyxocPWLj1mhBcKBrh0pSS9xKoCHsyjLytY?=
 =?us-ascii?Q?Nvaie6h7gqtxkjOrENf5Nj6ZUdRZrzpuZTw0Z03lpdBqMVlfiHdw7FJWH/z5?=
 =?us-ascii?Q?b2t3b/Okh0MysSHY8Sj3CQd+eduOUcj/gUN+ax56?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9656158AEFA4BF4186FB9771E2F5ACC6@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR08MB7411.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f82e1a5-7c44-4a39-c8a8-08dd2fd8b0b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2025 11:36:28.0405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: je72pMTLmpsl1K3t0q6WQZa8lKsj6UlcCEUKU+UbzYd3EpPuCSKdheplC0hSmMGdxTNUlPbWt9JQMvkQ6gQfIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8671
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 08 Jan 2025 11:36:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16987

On 30 Dec 2024, at 12:35, Philip Lorenz via lists.openembedded.org <philip.=
lorenz=3Dbmw.de@lists.openembedded.org> wrote:
> +            except asyncio.exceptions.TimeoutError:
> +                raise ConnectionError("Timeout while connecting to webso=
cket")
> +            except (OSError, websockets.InvalidHandshake, websockets.Inv=
alidURI) as exc:
> +                raise ConnectionError(f"Could not connect to websocket: =
{exc}") from exc

Is there a reason to not use the original exception in the TimeoutError cas=
e, but use it in the OSError case?

Ross


