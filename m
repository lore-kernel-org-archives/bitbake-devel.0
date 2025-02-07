Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6115FC02194
	for <webhook@archiver.kernel.org>; Fri,  7 Feb 2025 12:41:12 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.65.70])
 by mx.groups.io with SMTP id smtpd.web10.68344.1738932063083156593
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Feb 2025 04:41:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=OkQZdI52;
 spf=pass (domain: siemens.com, ip: 52.101.65.70, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zGkwrPUbE3iMF/gB3HH1BeDQbgfSA1OZlPhZrG4rxxuDcu+aLJmyxOBxhc2KaZ5+DyChNg3RH7BYAR9F23qSDtIOFTyiNUdgrgGzDP8aYCJPcrCb+C2MvmtpAU1ScMa4Dp5ULGKdCLCdC8x3ds7dA+/szC2rO/Z8XGH0I3JJDX1S/1sm35Yd2S4NiEtQSNwtQNLdbQMyNedjMLOQdgKI5c8gBjeFbZxd1w4CMURzrqPSMrKYb3+SCCf4Zd178XJTjaP1slymPrN8+rfLdoQfntKV0l8WX8j2E/6YnBUfGDgJSf1JyT0CWsy0pbP/zEJoOPSQbhoAO2N1t9bQoYWNZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmhJeF/GQdnd/baO2AH1tW/l4VI6bcFEaauFo98pClg=;
 b=GzuIXEqIFSe+0h042Gh3MjpmcX/yXszrlSLOoyLg46taJ/jKRk/6+pwVLBqWaczqfsIr97s9uGK2JrJEIDplFqwexR9MF1Ll5lbg/ZEB50ZG3dhWueIjRGsYB3HZXyTKlAMXbnUZma/GnkIF8aWV/6sg/MKlAgutEPFTHhVOCp/QC+ql0ap7nb1c8CAYugwEM0cAPY4L+mFT57KHvligjyKG0hsY9l/Vh8V+YQGiQ0nhiGkLBGAiLkfq8aiz1hcpzE2opxgA6EB42RZZaV9bSzLxrgFKosEMQkIU+ffW7T2p3sg18la2iZTSB3uHmfOgEbY83low+1nBhUNi6RHMyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmhJeF/GQdnd/baO2AH1tW/l4VI6bcFEaauFo98pClg=;
 b=OkQZdI52fuHgJsTHB7bWcNB/kICxy/0ykdxUMsy6FkDzl6LBNH+5KHgYO0XfbMygs+mDVi9WmeqcCQoGmaEOAYdpn0dob6eBVTYQoG8N571EdbXhMg1tLagv6Cvhq3/liL2sFXqA/Iywe4kkaotaRbrSiL6ypl5LuBLmKVlfGC9H/K3kzaZ4rxTsg8RDkY7ALEOfVfIIAf68tHzYZw8cjdnZbSajeIGHlIKmmIlDiIgc+ixLoadFqOw8Jq6Oa7sjkNG54kM0lGfPNnMEBCmCwbKnXOMTHPggskPkj0/Op8gFTu6bvG1LBdQSsvueChd+hxhEJ5x2XWFyWAt+EqbCtA==
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by AS2PR10MB6998.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:59a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.8; Fri, 7 Feb
 2025 12:40:59 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%6]) with mapi id 15.20.8445.005; Fri, 7 Feb 2025
 12:40:59 +0000
From: "Koch, Stefan" <stefan-koch@siemens.com>
To: "alex.kanavin@gmail.com" <alex.kanavin@gmail.com>
CC: "Sudler, Simon" <simon.sudler@siemens.com>,
	"richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
Subject: Re: [bitbake-devel] [PATCH 2/3] fetch2/git: Add offline build support
 for tags
Thread-Topic: [bitbake-devel] [PATCH 2/3] fetch2/git: Add offline build
 support for tags
Thread-Index: AQHbckBcVUO+dTVsdky5SYefwCaJwLMtvIUAgAyJKoCAAYncPoAABwYA
Date: Fri, 7 Feb 2025 12:40:59 +0000
Message-ID: <07ed332ad4733a7a4d5160b390124eb3053266e6.camel@siemens.com>
References: <20250129112406.1660522-1-stefan-koch@siemens.com>
	 <20250129112406.1660522-3-stefan-koch@siemens.com>
	 <CANNYZj_sd3O_=dYGPuC1NKQDzbMSsjHPPLGi+qb2=3L174rUMg@mail.gmail.com>
	 <87f5216654f92c2b0a9790cf336023ec1b788eb1.camel@siemens.com>
	 <1821E627D6FBF186.752@lists.openembedded.org>
	 <1821E75CA5CDE51A.18160@lists.openembedded.org>
	 <1821E95A02BB5E12.752@lists.openembedded.org>
	 <CANNYZj8QH7QfxpDMdi_oEfiZp4qT6pNSRR9QO2MbvEUJaFg7iQ@mail.gmail.com>
In-Reply-To: 
 <CANNYZj8QH7QfxpDMdi_oEfiZp4qT6pNSRR9QO2MbvEUJaFg7iQ@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR10MB4959:EE_|AS2PR10MB6998:EE_
x-ms-office365-filtering-correlation-id: 2cdfbe2b-d351-4d6a-9f7e-08dd4774ac8e
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?Y09NK2RIQlowVXhRdUQ2Tm9mcWh2bGJaMW13eU1tR1hOUXhZS1JrVHJPeWls?=
 =?utf-8?B?VG5JUXltQVBaZEs3bnR3bnBHZFU3RnV3Sk51REdBZUlZcE80ODlCNFNpU05Z?=
 =?utf-8?B?Q3hPZEttSEUvb0ZRekdHbktyTEd1d3JNbDYvM2tQaFRKM0JrLzk3Mkk2dTZk?=
 =?utf-8?B?TGNqN1RGbDh2c3M1SittS0JYR3F6OXE3dS8xK3p1S1p1TzZOYTdtcks2UlpV?=
 =?utf-8?B?cmZFd0ZXY1M2YXBNcyt0N1hjL3dPQ2FQSmRCMHJ1anpiVTEyeE9kQ2ZtOXoz?=
 =?utf-8?B?WXl5WTNPNmlWdWRRT25lMjE2RFkyUjcwQldQQ1F6ZDluSlZKTjZwK2EzcDhz?=
 =?utf-8?B?L0p4Y05NUno1R2I2a3BnelhxT3pVamwvMFlKcnNoSVR0RUZQY1hEQXZ4a1E1?=
 =?utf-8?B?R2FqV21rUU0wWXVWY0NWTWtEeXNKNlhhRGQrMlhOdXZsKzU2aEJMMnhSNFdw?=
 =?utf-8?B?VzJ0ZGlBakpOaWVmY0ExZVIweG93dGtuOGozQ0pNZWNVRHNndEEvZjZrdTcx?=
 =?utf-8?B?cjJKNnhWNzhhN0MvMmVzclM0citNSzhtWElGMXhHaUJ3c0puVnZIZ2RVVHJQ?=
 =?utf-8?B?c0ozRVdZY0kwZXViWXhWbk9Fcmx4b1hxUzIzMGZXeExsYUUybzVUeUdvS1BU?=
 =?utf-8?B?NnNxV1Izd3h5SzZrU2ZLKzhwOGR2eERrdi9uSTh6STRJUUxHbFQ4T251d2V6?=
 =?utf-8?B?YzA4ZjVvKzlLTWZYUm5LWGRNelYvUjlleFpEZUxjcXRzS1VlQjJ4Z1c0L01v?=
 =?utf-8?B?d0tSbmFUQjNCdzIyU2dhclhyYWFuVHNyZXpJSUxwR1FWaDJEN2ZGWndtMVNP?=
 =?utf-8?B?bW1YV3hyZkZ3MEZ4Y0xlY1lVNWtvdEZlRzM1QXlTaERQcnlFTmxhckNaWW1i?=
 =?utf-8?B?aTk1YjJGUHlWVFJOWXRGQmc1U1lHeWx5dFRtblIyOVhsQ1N1a055b3BIWnZI?=
 =?utf-8?B?QU10REphNXZEcGJla1hRdk1aWVV5SDRtVVJWYklSODVpZ2pRc1VpVk9SL1cx?=
 =?utf-8?B?S1R5dkp2M1EzcElJTms5MTcxQ2FVSzRnWllIWFNiYVo2OFBCWnRHYjcxTEQv?=
 =?utf-8?B?VWNrMUk4bmhkTnRCMHVxVTZ4U3B0VnBqQmJRWGk2RE53QkVXMHJjV1EvYllL?=
 =?utf-8?B?NVhobk54d1dkUzBSQXJPSlIvKy9CZEJ4NnZ6RUdpblNWS2hqUWFwbEpNNWNG?=
 =?utf-8?B?djZqWG5QM3k3VzlXeVpnTStsT1l1ZXpBRFpHa09kREw0eUlQMWNTbDlRRklM?=
 =?utf-8?B?Umg0T0ZPek9TbHZUc0JEdUdORmdSUWJMVGkrQWl3a0tYOHY4YXp2ZDNXZGFt?=
 =?utf-8?B?MkV6cjl1NWt6bGZrN3NVSUNnV1NWTVVQc1lPd1FZVVZTUy9HSTBqSVdjSWJl?=
 =?utf-8?B?YW5zemhlaXNuOGVrTWIwTGVXUDYvNUhqT1ZBZ0tMWGxHUUJqNldIT1Nwb0dM?=
 =?utf-8?B?NE8zZTVORFFHa3dSRjZCZ1oram9icEJoRmJlY3FuOXRtTzBVOVpmNlpHbmdC?=
 =?utf-8?B?RUJ0VHVDZ3c1c0lNNlVXa255OUhUS3ZVRHpxNXhBQmgxQzQ4QTh0K0dIemtr?=
 =?utf-8?B?OGRJcHBUeTE4NmxhMUxEeEJ1M051UUdPMHpoc3c4QnpPSnNYaERUQTdEdkMw?=
 =?utf-8?B?N09EZnZNdTY1bFphekh2VjFHSlBwTnIrcm1LVHVxNFJSM2poSmdiWGp2ZUky?=
 =?utf-8?B?emlwUkZ0VWJaRkgwNDdaVEtNZVk0c0trTCtPZzBlMGc4OTBHOEk2UXdJVEZK?=
 =?utf-8?B?dkVmdmlQRkZ3MHdHVXgvWTNhZEtqUkRwRFJxNVhvNWVmQjVwU2ZxZTMyeTg4?=
 =?utf-8?B?b0I5ZVZsVDFwMlhRdU1WRWpmMnpOaGc3QzBIUVJneVhBc2JsNHFhYnplUXdO?=
 =?utf-8?Q?c5CEcxTg9dI6E?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eFlXaG9DcDllU1JBdExJdm13ZS9JRVlSeFVFUHRFN1NxOGZWSlIwQi9HQk1C?=
 =?utf-8?B?bDBPU1BxcVkrNll0NzBOczA5amtKSEtSOTM5T2ZLUkV0MXBLY2d4RDJIbXJi?=
 =?utf-8?B?U2c1ckt2aG1SUkIxNVhKa0hhZ3JKUk13VDBON0FmUTE5YnpOL2xJcFhmM3Zp?=
 =?utf-8?B?VjFiTUFaZ2Yza3B0N2w3bmFlZHBIaEt2YVB1ekJJSEQvZE5HalNVOFRQbnFw?=
 =?utf-8?B?dHRJV3Fwek16cVlSem1GVWZBdm1zejhmZlFHbGR6a0NhQ2gySDF3NXM1R0Uz?=
 =?utf-8?B?dU5CQmlvamVuNTV1ai83Q25Hc1FoWnBPZDBTMTV0aW9ORmZySWZsWEluZm9I?=
 =?utf-8?B?Nk52WGh1eStlSXMrNVNGYUhodnpKMmtsTDNkRUxFS3hqNVphK1pBWER1SElh?=
 =?utf-8?B?eGVGVUhPVW82Qi9HSE4xSFpBeW9NeEVMZGRENGRmUkNZZGR0clArdFg5QVlr?=
 =?utf-8?B?VDRRSUFoU1AvVHpTMWZESnJLQVFvQy9pZHNMOG9QTGQ4NXFTTDBSZ3ZDKzRq?=
 =?utf-8?B?SlZiZm04ZkptdXJsdWhqeEcwcmZYczZlMGFGQ1ZOM25FVXZraHJpTC9ML2hC?=
 =?utf-8?B?OGcxLzUxYWljRkdDMTNWRW4zeVJtYmVTUkc1UmJoUDBVTEp2cmo5cEJySCta?=
 =?utf-8?B?Tys5dlZXckVRRkJwVGQxTk5OTXlnNlpiWEpLLzYzM0JSS2RQbzlsLzFZdFV1?=
 =?utf-8?B?TEIxTkhNVkxWMkdzdjRjcXpCc3BaMXRpdXA5dk5laHBBMVh3N1kvNlZ3TUV4?=
 =?utf-8?B?dHNudnZ5TkErb0FQdEhuOThya0RCY21DeTRPSjRYc3c3Q0RCbkd6TzJJWkNQ?=
 =?utf-8?B?Y1ExWTQxeFE0VFFSTkQrdnN0Wk9zOVdGbGNKZzdsZnVvUCtDV2x2TDhzblI3?=
 =?utf-8?B?RDRkdkpkRGg1ZkxNeUdEajZmMFl3ODE2RHJHS0V3Y0l3MGQ3eFJsSGFrcUFS?=
 =?utf-8?B?SHZzNXhWOURqenNhSEFFRzY2Y2ZySFFaRzRwaUNaQkt4VGpkdzF1bFR4VXJW?=
 =?utf-8?B?STd3cEZKZXdDVkpwMG50SjhxamV6MStZUUNqZnBvdk0xUHdXZXFPcStqYTRJ?=
 =?utf-8?B?NDVJWUVaaTIzZ2tBZzNuRW5WbTRDSjV0ZkxuaDhIUDlSRC9oSy92c3oxNzdo?=
 =?utf-8?B?RmRHRmxJYnpLbUFVMDNuUG9vTUptZWpuVzlRUnNKV0plM09ubGVqSWdkcEQz?=
 =?utf-8?B?dHlOdE9nRUxuampKWUNTVm1sWDZ3Mzhpemg4OWFUaWl6ZVJBU1psY0JvbWRr?=
 =?utf-8?B?NExYMWJKNjl0dzRPQU1lenA3bWpXWktuRGtJVnBudGJPTlFFQUJsKzY1ZXJM?=
 =?utf-8?B?ZG9yL3FBVitOOGhVMVNKakdYQUZlTEpsVGoxTVREME5OcGhyYXlFam1CSEVa?=
 =?utf-8?B?WlU5R1BHblh4a1ovNllDTFYvTUtRSWhsTEJHazdkODhjQ1o2bW1FK1J0a3Ji?=
 =?utf-8?B?SjFLV2NuRjV3REtQWFdyY0NMR0o5bThTUUZzRi9nc0FJaEYrMzdaeHYrS241?=
 =?utf-8?B?cFl6bGx0N2FLek8wUzU0cVNuOVVKeDhVNHF3WVZmNTdUdDZxanFESk5MNUMy?=
 =?utf-8?B?TFhvc3UvelR3ZnpjRDFrUW5qVG0zK1FlbVNiQ3BIUDM4K0p4eVBCTHZXZ0t5?=
 =?utf-8?B?ZDZTRUxnRjhFSFNRWkRoS0xlWFA1aFppSktYMWVETmVUd2hqTUJpeW1rb0c2?=
 =?utf-8?B?WTZCZ2IxaDNGM01ad0pya0N5c1kwd2NSdzJSSmxpM1VIL2hEaEhFdW1tNFNC?=
 =?utf-8?B?YjV5eEZyb2dMcVhSaXV1Y2tES1hsZXoxUDdPY3Z1cXNtZEVhWEdzc2JGWWhx?=
 =?utf-8?B?MnlRNHJteFlHVmhZVnRoMVlxRVBzZi9zaEVnZ0FlWDlHclBNL0V3TFhIcnJq?=
 =?utf-8?B?NWpPbkJtWnh5WTdOd0NHSEFtamRQc3NyUzZJU2hlSFhjcmh6V3lyOUFkVkw4?=
 =?utf-8?B?Q2xtbFhQbTZ0emVNR2wxUUV0eCtjY0w1SW9RVmxiWmxyR2ZvNm80VGIzVUFT?=
 =?utf-8?B?ODh0RDg0eFJua0lnTXJQdVFmd04xWFVLVEpTN2Vqa0tPOVkxWGZYT3ZYVzc5?=
 =?utf-8?B?N1h2SkJzV0RHeUFRdXBHR1krNFFkTDB0VUxBbmJ4cFRBMUY0aU5DeXB6UDNR?=
 =?utf-8?B?Sm94eStmZHM2RnpnNXB0WFpQdWhjZFZIUHlQbkRnTytRRWE2ZE1BMHdKczl4?=
 =?utf-8?B?VUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0601AF7D207F1E418DAC992BEEB6CC93@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cdfbe2b-d351-4d6a-9f7e-08dd4774ac8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 12:40:59.2830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hVORtn2dQ8xAM2TALDrmjP+pSYtoBUmULlQy9dIIY2eftQYikvTVdlaH2XIuPPlRFlQfqsOV1USHa/S51hJRuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6998
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Feb 2025 12:41:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17169

SSBoYXZlIG1hZGUgdGhlIHRlc3Qgd2l0aCBCaXRCYWtlIDIuOC4NCg0KU28gdGhlIGNvbW1pdA0K
ZmRjNTViYjY0OWNiNzc0NTZkMGFjNDhhOTYwMGVmMjg5YTUyYWYxODogY2hlY2tzdW0vZmV0Y2gy
OiBTd2l0Y2ggZnJvbQ0KcGVyc2lzdF9kYXRhIHRvIGEgc3RhbmRhcmQgY2FjaGUgZmlsZQ0KDQpp
cyBub3QgcHJlc2VudCwgdGhlcmUuLi4NCg0KU3RlZmFuDQoNCk9uIEZyaSwgMjAyNS0wMi0wNyBh
dCAxMzoxNSArMDEwMCwgQWxleGFuZGVyIEthbmF2aW4gd3JvdGU6DQo+IE9uIEZyaSwgNyBGZWIg
MjAyNSBhdCAxMjoyNSwgQWxleGFuZGVyIEthbmF2aW4gdmlhDQo+IGxpc3RzLm9wZW5lbWJlZGRl
ZC5vcmcNCj4gPGFsZXgua2FuYXZpbj1nbWFpbC5jb21AbGlzdHMub3BlbmVtYmVkZGVkLm9yZz4N
Cj4gd3JvdGU6DQo+DQo+ID4gT2theSwgSSB0aGluayB0aGlzIG1heSBoYXZlIGNhdXNlZCBhIHJl
Z3Jlc3Npb246DQo+ID4gaHR0cHM6Ly9naXQub3BlbmVtYmVkZGVkLm9yZy9iaXRiYWtlL2NvbW1p
dC8/aWQ9ZmRjNTViYjY0OWNiNzc0NTZkMGFjNDhhOTYwMGVmMjg5YTUyYWYxOA0KPiA+DQo+ID4g
V2l0aCB0aGUgcmVmYWN0b3IsIHRoZSBmaWxlIG5lZWRzIHRvIGJlIGV4cGxpY2l0bHkgd3JpdHRl
biBvdXQgdmlhDQo+ID4gZnVuY3Rpb24gY2FsbHMsIGFuZCBpdCBkb2Vzbid0IHNlZW0gdG8gYmUg
aGFwcGVuaW5nIGFzIEkgY2FuJ3QgZmluZA0KPiA+IGxvY2FsX3NyY3JldmlzaW9ucy5kYXQgaW4g
JHtUT1BESVJ9L2NhY2hlLw0KPiA+IDotLw0KPiA+DQo+ID4gV2UgZG9uJ3QgaGF2ZSBhbnkgdGVz
dHMgZm9yIGl0LCB1bmZvcnR1bmF0ZWx5Lg0KPg0KPiBUaWNrZXQ6DQo+IGh0dHBzOi8vYnVnemls
bGEueW9jdG9wcm9qZWN0Lm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MTU3MzkNCj4NCj4gQWxleA0KDQot
LQ0KU3RlZmFuIEtvY2gNClNpZW1lbnMgQUcNCmh0dHA6Ly93d3cuc2llbWVucy5jb20vDQo=

