Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0148BC0219B
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 11:46:50 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.46])
 by mx.groups.io with SMTP id smtpd.web11.10436.1739274407265189803
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Feb 2025 03:46:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=vjet7x+p;
 spf=pass (domain: siemens.com, ip: 40.107.22.46, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mimSvd6NxGcfAEyCcJMZAGNJ9YqRH9c2SA4SoQlMyihXoA6eVyEQTRAZHrNJWb7RMxCNz/NLXskH6UYWPDcITQC4FpjVCsRTPHJFkDRYa4QJ/YVXWjEqt/jUggwg6jDvmwlVnrvb3v0tKzl41o61LRDMWcQIqgTVLyj0g1EMwoU1GOX6HD+eAQF2eOoJzqPzFUYOhUzRtv69NatcbOkquT1CiEeQASOsPncJ1V0hr+i9dPslC4OQfmEGzXeIx42133tk4wHYove13oZU2ujx87tr/sBRpwPISYvvb0xSOAgDUUJ9K3Mqf2UF5IxgJJHXYYxfIt0QhSHYOPeQNlTVaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8bbBFjGJp7klKtisnKg7d42KWYs1Ao7ImkWW1MkCUc=;
 b=dOpxBi44LKbalglIfgcPaxGzm7IRQo7J8gsaUhPyCgiPN7BF6/3YCyqYdr3hIjcVeNZ4p/6R1fvQ5/deHKQkO0tLZhLoO+JBI20Id6CmxT2nAnNJpBMMvHmiCUVGOeLpGnPFGNK2uoGuxbJpcMP7pBBGdKTa3raZHe+aWJSxxi4+eR/v3ydd6X3BnaztquwYvGDV3Cji9gxPchCOBqqjc5Xxvb9qC9SA12NQh98KhZ1kfm781WANN9LqQPHbomo4Ii36Cm9XL4IZg5rfP2Oi1MpaP0U4s5OYM13BFQFQTEeWrnxi71FW0SDFGJshJuGXs1PS3SLRSgKL2UZLqf+IpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8bbBFjGJp7klKtisnKg7d42KWYs1Ao7ImkWW1MkCUc=;
 b=vjet7x+pjrFKAVlkcXZEx6xh7BiQIbhwyPBV4H5l9wg60kKOypYR0m/UcxDCrDmR1xyjzMuSQ9bb4g+bGinrk59KesSZUuX2poeTljaiHE8Gn5Mqp9oGz7ookLsrKSFZdfWsktSNGgakplsxBHSgm0km6l90OK0K+jR7YSzN6M9rG87zfenzbCJrtEITvzGtVkVPGekApwORP2wLPSILCQ1R4r4OGso3yTDVhTrxxs1vLjw4jqrA+/A+FuCYVpP/9gHzu1MaWl6slFTHIY02SscmG1HXrvh09eU8P+eG8VhndTDq/ET+O70hrCQ4go8IPAmn/a2P/RBwYSCiU+Y5gg==
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by PAVPR10MB7356.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.10; Tue, 11 Feb
 2025 11:46:40 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%6]) with mapi id 15.20.8445.008; Tue, 11 Feb 2025
 11:46:40 +0000
From: "Koch, Stefan" <stefan-koch@siemens.com>
To: "alex.kanavin@gmail.com" <alex.kanavin@gmail.com>
CC: "Sudler, Simon" <simon.sudler@siemens.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
Subject: Re: [bitbake-devel] [PATCH 2/3] fetch2/git: Add offline build support
 for tags
Thread-Topic: [bitbake-devel] [PATCH 2/3] fetch2/git: Add offline build
 support for tags
Thread-Index: 
 AQHbckBcVUO+dTVsdky5SYefwCaJwLMtvIUAgAyJKoCAAYncPoAABwYAgAAFNoCAAEihAIAAIQ2AgAXLQQA=
Date: Tue, 11 Feb 2025 11:46:40 +0000
Message-ID: <8ee6be87016c7cb41ff12bc7ff43a98e30529d85.camel@siemens.com>
References: <20250129112406.1660522-1-stefan-koch@siemens.com>
	 <20250129112406.1660522-3-stefan-koch@siemens.com>
	 <CANNYZj_sd3O_=dYGPuC1NKQDzbMSsjHPPLGi+qb2=3L174rUMg@mail.gmail.com>
	 <87f5216654f92c2b0a9790cf336023ec1b788eb1.camel@siemens.com>
	 <1821E627D6FBF186.752@lists.openembedded.org>
	 <1821E75CA5CDE51A.18160@lists.openembedded.org>
	 <1821E95A02BB5E12.752@lists.openembedded.org>
	 <CANNYZj8QH7QfxpDMdi_oEfiZp4qT6pNSRR9QO2MbvEUJaFg7iQ@mail.gmail.com>
	 <07ed332ad4733a7a4d5160b390124eb3053266e6.camel@siemens.com>
	 <CANNYZj-aKm-A14gv3eAjbPUj0UpbqBecvb+o_xmFhW3DfoCtdQ@mail.gmail.com>
	 <3583b11ba1dd99203c4c9651a546d337a131d19b.camel@siemens.com>
	 <CANNYZj-PoHKcmrh=6YYPLU+YHfX4TL7ZfruQy6br2wZUjS35wQ@mail.gmail.com>
In-Reply-To: 
 <CANNYZj-PoHKcmrh=6YYPLU+YHfX4TL7ZfruQy6br2wZUjS35wQ@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR10MB4959:EE_|PAVPR10MB7356:EE_
x-ms-office365-filtering-correlation-id: 70ca562a-5cdc-4f0d-e5a2-08dd4a91bff9
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|13003099007|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?S3JhUkZpQXJMS21pc0wvaWI3dGtWL1ppMC93T2llRWNhOC91WHZ5UENwQW5W?=
 =?utf-8?B?d2ZOSWhLVC9RVWI0dnNIZ2V0QnFYdkp0NlVnMDdRRktwa3FFTUhma20zYTA3?=
 =?utf-8?B?b0NxUXVabGVQUG9aMG5sMkJBQ2E3RTVQaTZBS0VqV2RYNUpaNm5TVGxmMG1N?=
 =?utf-8?B?V3BUdUhnb2tQakFQcWgrTXRGekErdEo5aGd6N2VXVHZBTCsvcTM0QzZnWDlG?=
 =?utf-8?B?UjB5VSs2eFRtV2htV1pwYkJCMEVuZ0luMDVlKys5Zy94elNURDBMdzRVcU0y?=
 =?utf-8?B?aUdSL1pKMnhtejFxMW1KNEI3d2thbEFzL2ZXQ1FXL3dTR2lqV3pnMzQ1T3ZW?=
 =?utf-8?B?bVVSMTNiTWN5S0M4bkd3NWI3NG9uRjUvYnA1RVJtRlB4bjhibkwvSTRUYURJ?=
 =?utf-8?B?ak5WOFpZZHBUeUpnUE5QVC9uTEZTWDZoczhBMHBZZHZaRWl2V0xqdFFuTEZm?=
 =?utf-8?B?Q3pIZkJNYmNsK1NHZFB4KzlIK0gzQ2hCbnZMaXE3TUlLV2ZWMHBVRVRBQWQ1?=
 =?utf-8?B?TC9TR1JySGZDcXU4R0Q1c3p1RWVvTklqb2ZKWi9MREJOVjdLV2tTa0FQcGpq?=
 =?utf-8?B?eFlFWGc0RE1NS1VHc1orOGdrd284c1dhYkN5WDFhM1lFQlA2N3ozdVprajda?=
 =?utf-8?B?VUJHRThUeEllN01nY3IzVExRMFZEUE5oYjIxNTdtUTdRQnJzMkdxN0NnWlF4?=
 =?utf-8?B?TS9KQmE3R1lKMzNKeS9IYis3OCtkM1plQWVJclhnUElOVUpMQk5OZ2NEZ1RZ?=
 =?utf-8?B?cS9mMlBTb3Qza3RVbjk5QnFMcUVmby8rMlg5T1poYUhrdG40cFBESWx2R28w?=
 =?utf-8?B?ZEZVL09EUGFGQ00zcE9HYnhZMDR1WWpTV2RYbS9GSVRXa3N5emRkd0F3Ky81?=
 =?utf-8?B?aGIxeE5WZUFES1liajA1SHlEeEZvYWlTOW1hOTFuT1pKc1U1ZDIwcGc1YjBs?=
 =?utf-8?B?VVZjR28rRmoweDBSSXg2S0VEcklXRjFlblBGb3hpMVJDcDJsVXE3aTVIY2Vm?=
 =?utf-8?B?MmIrZ3lVOC9oREd4L1Q2Uml2SVk5ckgxcTA2Wk0xU0YwWktkMDRwS003Z3Nz?=
 =?utf-8?B?SEM1eCtFUngvczFWZnVwbHBzK1pXOEUxaHFMcVBrZEV2Z0NOelR1VDlIUUVW?=
 =?utf-8?B?bk9jMU5GNjhKZFZwcXlnWWNKU09WWUZPV2twWkdIa1ZiM1Y0clk1c1VrYUdF?=
 =?utf-8?B?SXlsSmlGNXJ1a0VReWo2TTF1WldKTFBYc29yMndGRXFjUU9OalYrUDNURGd3?=
 =?utf-8?B?bzcxMk5jK0NoSVJpTEZ6MjBHbnhDTWZ0WEp4blpxYjNGT0dMV2tCRGRTdlcr?=
 =?utf-8?B?blJZdm5KMVdHRTRhR1greURqQkRGUFg3bXo3Nk9zS0llMVJiSHYzejMvNDF0?=
 =?utf-8?B?eDIwQ1ViNmtuQm9YYkZqb0dOQ29tNWtXaDh3WkFzZ3c0UTZMRmRXZW1OTDVW?=
 =?utf-8?B?cHkvdDVjV1B3YU1pbmQ4R3k0b3B4NzBZNUIreW5LdUxNUlVJb2pJeG9yTU1S?=
 =?utf-8?B?N0ZEclNoTEZ2Yis4MHFZQ1VqczZ6a2JPVHNibDRmd1AycWxGVDg5VWJ6KzQ2?=
 =?utf-8?B?UlZLZ0RhUUcrL2ZPNEdSZWR0M2grd2hXM0d5elFxdm4yMzFNSk40TE5ZS2Vl?=
 =?utf-8?B?cFF4czhTWnVkcWVIOWVLY3dHanhMVkJBUFordTJMQldIYjRDK3hvaWpnTmla?=
 =?utf-8?B?K1JqUE9CQmNYMlNHNVZRWWZ4UEcwOHU0VWNsY3VRVFZxNkMrTWtsYUpzZG9H?=
 =?utf-8?B?aG4rekxWUmxVa3JreW1WY1RvWER3M2VkMWxmakdjMlFwamthUU9tQnhIeUdv?=
 =?utf-8?B?Z1VETzhjTmRsUTduL2J6UjRBRlNHVHJkL1ZYQ1IrM284M1RKejIzRVZSTWhV?=
 =?utf-8?Q?6n5JlHF+g6+Q7?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(13003099007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SHpMUlNyRFB5VU5WZ1VyRTArRVJ1NjJWZUZmbkQ2MVR5UTk3WGNTVVhEUzU4?=
 =?utf-8?B?WFJnSWNlUWNsTW5JLzJGOFJSQlBZSWJSKzlvUVkxWUJDWXhUcW9hYWo3UDV0?=
 =?utf-8?B?MGN4ZGhsNWh4U0ZxcFp3bHNFaGM1QVVOTWl1RmVxNU81dThwZWgvdWl0K1Zp?=
 =?utf-8?B?OFNUN2hJZFRia1pFYU45VUNJU3VhaXpzcUFoSnZ2TWJZRmsrYk1kYklWNTE3?=
 =?utf-8?B?WE81NE0rQ0RhdmlQVkxhdzB0TVdVL0NRNHRlUzhIOFQyeUp3SnlOSklWamdx?=
 =?utf-8?B?N2dkV2dYR3BLcFFKWWlmQWFmOEhSc1hLLzVoYXZ1UTZwR1QrOWF0a0dFaTdx?=
 =?utf-8?B?THZWUkZOb0VUdjJRWmsza1o4SzdQR3N4WGo4N2FobWNTU1JySVVsTFNVc1RF?=
 =?utf-8?B?dnJRWEYwU09pWmlkTThaV1VVNE1raTJUYnhUOG9MK05IU1ZKeVpuOFVKck5i?=
 =?utf-8?B?b0RJS3hTcjM1ZW9lM0ZVTFBGeXJWQ0czNnN0ekhnZmFwRUwzdGtLK00ya1I3?=
 =?utf-8?B?Y1F3MlNMVno4ZHlOT1l1QXU0bFkxSmpqbUZ6bzBmcnJlR081SVhDMHBIN3RY?=
 =?utf-8?B?WWNGOGhPOEtBbDdyTGtpTmRBVzFoVkZDTXRYV2ZPR3ExK3pvbFZISDJoTHNo?=
 =?utf-8?B?RUkwUVRaNjA5K3NYNndnTUwrL1kwQm1qVFF3bHpmdHZzMEMwOTRQdUtlRVdr?=
 =?utf-8?B?cmJkWWNOcnFFRG5TTEpTc3lzM1ZFSHAzOTJhZGFTRFdWUmNtc2pMK3FSby9R?=
 =?utf-8?B?RzlpTHpEcmVZbUtudEFnYmJNaHhxejl3MWUyQ1dyT01HblNTTWpPaHdUK1pq?=
 =?utf-8?B?K0U3M05ueDE5eld3TmlhYmpKeEtpdjdKQ2kyVTRJZmZDOE1acEFCYmxzcTg0?=
 =?utf-8?B?ZWFmMUt1TmNIUkpYUmxDZU9lNlRPQ05xdjVvRUhmMUM4UC80c000aUpucUsy?=
 =?utf-8?B?NWJla3JDdFhId0lHVU8zYStIamdaWG1VeUlSclROclNyK3FyVUFiYi9WVDc3?=
 =?utf-8?B?TkRQTFhNMnRNZGdGdW1PWThOSDRwNG00N0x5ZlNCMFVtRTI5THRKYjFZY2Vt?=
 =?utf-8?B?Z0dWRG5ieXpmYjF2dlNoVXB1Z0tkMWxiYU9Sd1Y3bUxyYVBWSmJpbjZpWmFK?=
 =?utf-8?B?TU92NTFIQ0FIYTVMYVorWEVCS0xlTzQ1UmlhTHc1ZkFnQmIyUGhITVNYTnc4?=
 =?utf-8?B?SG1qZGhYY01ZQm5LNmJPQ21KYmoxdU5yeEc1ZFM0a29mUXRkcWFsWTg2MlpQ?=
 =?utf-8?B?eUppSnI2OXZKb0dXU29mcllZazhsZGxueWdJU21pOWdrdTJ0dnF5RmRkU2du?=
 =?utf-8?B?TkRjSDErdU1qdnc1NWVleUNpTXh3SU0rKzU2WDhVNlYvdkdPcFEydGlwRGVP?=
 =?utf-8?B?eEhSMjZSdmx1dGNxd1QzUkNORFZTWVo5UHI1R3Qvbnd6S3o3cTZUcTB1S01Y?=
 =?utf-8?B?UkE0TFNOMzFFQm0zSHlHcjBjV3BObmRPckJzV0RXb0NpdUl5Q0JuRGZiY1BV?=
 =?utf-8?B?U095b2VEVERiZDZmanYzWmEvUzlhamlXS1dpRzVvelk2SXE4RTRyY1ZEQVFn?=
 =?utf-8?B?ckRVUTg0cEs4MHVMdFkyOXlKNFlvZUhjU1d6QXE1elNHb3V4SE5CWWZwVVli?=
 =?utf-8?B?TzBUaHNvbHk5NGJOYm04eGQ5ZklCdHFabWZYMVY5SWNUand6QndQdlVwS3Nr?=
 =?utf-8?B?S1pHT3dLN004SEYweTBqMFNxRVVyN0Z1RGNKeSthYXR5cmI0TVJub2tSR0tN?=
 =?utf-8?B?NWFYcWR3TjdoTHY2Z2FGY2hXR3dFcld4N0JiRlplYkxGRFY0UTF3NU5kZkV6?=
 =?utf-8?B?THE4QXh2L01qcXFyeWxiWVdJd3kycXlENENWRXNTQ3Y4bFc3bmhNWW81bHEy?=
 =?utf-8?B?RHdiT1FRMHVjd0lxZlFXYjBSNmJ2VmZ3TGZxdUxDNHgzcjJLUFUvTEhXMVlP?=
 =?utf-8?B?eFRqVkRpc0NHaTVIa2NkN0N1c0ZyQWJlRlYvMVFseitoSSszWWxOWHRBb28v?=
 =?utf-8?B?N2FIUFdrb0VFZ0UrWXNLamdtM2xLd3dWTkVhZlNPdjU0N3RsTC85K0xESmk2?=
 =?utf-8?B?VkUwOU5JUzlRY3RqR3VJdFBWbGVoSWlCSHNhcjBaOUxlckFrblp2akJ3YU1O?=
 =?utf-8?B?MENNaUNEZ2RHa0JqOUNNV3NUMkxraU1ZY2VWTXZlWVhTTDBUTStGQ3JnYVdL?=
 =?utf-8?B?Snc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4ECD7BBB3E5D0F4AA8584BEA4F48837D@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ca562a-5cdc-4f0d-e5a2-08dd4a91bff9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2025 11:46:40.7473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g0vH+1qDC2MOsxiRb+MxXfyHM5hwxnGyTAqjlQkZrfVcXFyxphuPdvvZGsS5zB6GL02rPq4LxLjEZKxE8BZviA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7356
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Feb 2025 11:46:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17190

T24gRnJpLCAyMDI1LTAyLTA3IGF0IDIwOjE3ICswMTAwLCBBbGV4YW5kZXIgS2FuYXZpbiB3cm90
ZToNCj4gT24gRnJpLCA3IEZlYiAyMDI1IGF0IDE4OjE5LCBLb2NoLCBTdGVmYW4gPHN0ZWZhbi1r
b2NoQHNpZW1lbnMuY29tPg0KPiB3cm90ZToNCj4gPiBnaXQ6Z2l0LnNlcnZlci9ldmVudG1hbmFn
ZXJ2MS4wLjEwLQ0KPiA+IHRlc3TCoMKgwqAgZjU2ZTY2M2VjMDk4MmU4YjMwMGMwM2IxNGE5NWNi
NjdhYjJmZWFkNQ0KPiA+IA0KPiA+ICNTUkNSRVYgPSAiZjU2ZTY2M2VjMDk4MmU4YjMwMGMwM2Ix
NGE5NWNiNjdhYjJmZWFkNSINCj4gPiBTUkNSRVYgPSAidjEuMC4xMC10ZXN0Ig0KPiA+IFNSQ1BW
ID0gInYxLjAuMTAtdGVzdCINCj4gPiANCj4gPiBTbyBvbmx5IHRoZSBTUkNSRVYgYXMgaGFzaC4g
QnV0IG5vIHRhZy4NCj4gDQo+IFdoYXQgbWFrZXMgeW91IHNheSB0aGF0PyBJIHNlZSB0aGUgdGFn
IHJpZ2h0IHRoZXJlOg0KPiANCj4gZ2l0OmdpdC5zZXJ2ZXIvZXZlbnRtYW5hZ2VydjEuMC4xMC0g
dGVzdA0KPiBmNTZlNjYzZWMwOTgyZThiMzAwYzAzYjE0YTk1Y2I2N2FiMmZlYWQ1DQo+IA0KPiA+
IE9uZSBjdXJpb3VzIHRoaW5nOg0KPiA+IC0gV2l0aG91dCB0aGlzIFBBVENIIDIvMyBidWlsZCB3
aXRob3V0IEJCX05PX05FVFdPUksgPSAiMSIgd29ya3MNCj4gPiAtIEl0IGZhaWxzIGFmdGVyIGJp
dGJha2UgLWMgY2xlYW4sIHdpdGggdXNlZCBCQl9OT19ORVRXT1JLID0gIjEiDQo+ID4gLSBCdXQg
d2hlbiBhcHBseWluZyB0aGlzIFBBVENIIDIvMyBhZ2FpbiwgYW5kIGxldCBCQl9OT19ORVRXT1JL
ID0NCj4gPiAiMSIsDQo+ID4gaXQgd29ya3MNCj4gDQo+IFBsZWFzZSBmb3JnZXQgdGhlIHBhdGNo
IChmb3Igbm93LCBhdCBsZWFzdCkuIEkgZG9uJ3QgdW5kZXJzdGFuZCBpdCwNCj4gYW5kIGl0IHNo
b3VsZCBub3QgYmUgbmVlZGVkIHRvIGJlZ2luIHdpdGguIFlvdSBzaG91bGQgZmlndXJlIG91dCB3
aHkNCj4gdGhlIGNhY2hlIGRhdGFiYXNlIGxvb2t1cCBkb2Vzbid0IHdvcmsgYW5kIHRoZSBmZXRj
aGVyIGhhcyB0byBpc3N1ZQ0KPiAnZ2l0IGxzLXJlbW90ZScuIEkndmUgYWxyZWFkeSBhc2tlZCB5
b3UgdG8gbG9vayBpbnRvIGl0IGluIGEgcHJldmlvdXMNCj4gbWVzc2FnZSwgc2hvd2luZyB0aGUg
cGxhY2UgaW4gY29kZSB3aGVyZSB0aGUgaW5jb3JyZWN0IGJyYW5jaCBpcw0KPiB0YWtlbi4NCg0K
Rm91bmQgdGhlIGlzc3VlOg0KQkJfU1JDUkVWX1BPTElDWSA9ICJjYWNoZSINCm11c3QgYmUgc2V0
IGdsb2JhbC4NCg0KSWYgc2V0IG9ubHkgZm9yIHNpbmdsZSByZWNpcGVzLCBmZXRjaGVyX2luaXQN
CihsaWIvYmIvZmV0Y2gyL19faW5pdF9fLnB5KSBzZXRzIHNyY3Jldl9wb2xpY3kgdG8gY2xlYXIg
YnkgZGVmYXVsdC4NCj4gDQo+IEFsZXgNCg0KLS0gDQpTdGVmYW4gS29jaA0KU2llbWVucyBBRw0K
d3d3LnNpZW1lbnMuY29tDQo=

