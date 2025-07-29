Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232F5C83F26
	for <webhook@archiver.kernel.org>; Tue, 29 Jul 2025 10:39:31 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.2])
 by mx.groups.io with SMTP id smtpd.web11.4107.1753785561464038352
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Jul 2025 03:39:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=QANQn3Dd;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=QANQn3Dd;
 spf=pass (domain: arm.com, ip: 52.101.83.2, mailfrom: ross.burton@arm.com)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=WtRQZb9GABeOEmzKEq7iqtL2QO2w39enA1d0mYoqkQ/m0B0TBX2YtLzJgDJxk4rEfdOnDGTrhglHwiorsGOKYiZ2X+UN3oIDMAVLZhIQrG7/wk4s8Nvl0i2FqrKm4OrN10iUUGbkuAzLcyEwBpAaYJhLcWKrc0R3DCE0DUDwNpK72asOk1X0yOaCOd+bQ65c1Vpg1wTWPIdFn6FN3uV1HTJc+Ui6a20WRGCsGqn7nUcVX7TQ64pEo3ZqMZzMS/gvUbFth/yORZ3szuIaRSzEk2/v275tAxsWUx1BL0LRiaSZmZnlhyK7t6QnFmPTu1ghEQV8c5zUddFWF/lj/jWtnw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9RXLETjz9LZwB73bviu8Ay75Q5xCVW8Tk0CoRiWchFs=;
 b=pGsADKesDvVy3I43xy9/w007kjDxLVSHCCJiZHbjcQP/T6gwPZacLL8Z/qSLwWR9S49vPMsON/hFWmbUFwSmSPuW9ov5HjNCoOu7HQHPwOwQXM1no12S7/Tx83vxzpndF1P1HO0DtdwVOXmr/mPwCM+xb9p/x0mMj32kPhn9Q09vxQN/JSmDr6I8iNJxx3j3aKvozt0fN2cDkzjaguauSQO7eYK1KKRaEYqChei2LcapRzb7Fo8ay6zGJ//5tusYiSdXwsv3vA8ghwZngG3Z6QDjQB07rBCDC+qsUlWEnfpFFqdAn6KDMzJpu7B0mShlhDuaWA5PrppVejL0wpM1Ug==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=agilent.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RXLETjz9LZwB73bviu8Ay75Q5xCVW8Tk0CoRiWchFs=;
 b=QANQn3Ddkm8+4V0fGP1aFDhO80f/UutEm8TBHpsdzi455srwmMKZz5buoOa63g0joynL3mY32sE3cUtaVOeesvtxRABeSHOwgOe9whdjboLR+/aayHHMKaCVEr/GwceM9Hy6PrxfWlqXI1Ni0ofGRvvZWu7RKU87cd7lIsA52DU=
Received: from CWLP123CA0142.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:87::34)
 by DB9PR08MB9948.eurprd08.prod.outlook.com (2603:10a6:10:3d0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 29 Jul
 2025 10:39:16 +0000
Received: from AM3PEPF00009B9D.eurprd04.prod.outlook.com
 (2603:10a6:401:87:cafe::1f) by CWLP123CA0142.outlook.office365.com
 (2603:10a6:401:87::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.26 via Frontend Transport; Tue,
 29 Jul 2025 10:39:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF00009B9D.mail.protection.outlook.com (10.167.16.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.10
 via Frontend Transport; Tue, 29 Jul 2025 10:39:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nKDrz6mLv+ZQfNXM65hubuqzgsQdSl4ApoUUYUk3C5H6qPWwSSvKVtAxTiQ8cn06ifEKIHsJnE9xAQhWE2A5uL1SolzLQUp/aYHsJys3hOfTbfHSzkWALozYC1Vrc/bnOMHZtvgw74Xt6c0mVkCn/rM5NHRCmtXpkUXojbXkZWdPyGwvlGa6czk+izL/UyOx51sSBquudNTB0J1tZBSYr0ZCqbK6XQhZnVqkGq7Wc1LFpQmjK+sgl8AlfMx+XYPXxeu4vi4ty/NCFlRR4lZTu55qXbBT974qKrYoMB1dnpBW2+kcwBT6mX4PKNBq+hVhamoC8zNgnaIuHmFWsfVi4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9RXLETjz9LZwB73bviu8Ay75Q5xCVW8Tk0CoRiWchFs=;
 b=k5lSWQfM4ZjwgzgdNWf3rupP9qRWOfLLJFpcPAh9YDXCQxk9/wYpGvxpNSj56g2CFDkKawrEOLRcVEN1qpghGhK0/9fqX1v1GAQqXmsoIZtTEnMyIm9uKMyzt6nJZT3idxKShmWC4VF6INTcecTm8mBNlxfTxXl9zuRYvX/NUdyJvHbRgKsC1QFK/HK+1ZHeoqybtAUkBDROlXnm/0+Eio12YyZfRnoFpUeBChlq4GDtnI1eHdmtNakDx0uCRfOXTgkvo3K7Wl5b5amccoK2IqwWJpITyHTfHYhjtAYVBPC4yfWC+IRJ5xJoKoEHMilGELQLL3/P8c3D+r5eLid1TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RXLETjz9LZwB73bviu8Ay75Q5xCVW8Tk0CoRiWchFs=;
 b=QANQn3Ddkm8+4V0fGP1aFDhO80f/UutEm8TBHpsdzi455srwmMKZz5buoOa63g0joynL3mY32sE3cUtaVOeesvtxRABeSHOwgOe9whdjboLR+/aayHHMKaCVEr/GwceM9Hy6PrxfWlqXI1Ni0ofGRvvZWu7RKU87cd7lIsA52DU=
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com (2603:10a6:102:2a3::12)
 by PR3PR08MB5755.eurprd08.prod.outlook.com (2603:10a6:102:86::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Tue, 29 Jul
 2025 10:38:44 +0000
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::9206:40ba:ef7e:729e]) by PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::9206:40ba:ef7e:729e%5]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 10:38:44 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH 1/2] utils: Optimise signal/sigmask
 performance
Thread-Topic: [bitbake-devel] [PATCH 1/2] utils: Optimise signal/sigmask
 performance
Thread-Index: AQHb9+uElrH2TMZqp0qTgpM25VTMU7RHyggAgAEv/gA=
Date: Tue, 29 Jul 2025 10:38:44 +0000
Message-ID: <ACE5DB76-ABC9-4C30-A44D-E60D0C672013@arm.com>
References: <20250718135437.247096-1-richard.purdie@linuxfoundation.org>
 <DM8PR12MB543065BB1FD2642696C540D88B5AA@DM8PR12MB5430.namprd12.prod.outlook.com>
In-Reply-To: 
 <DM8PR12MB543065BB1FD2642696C540D88B5AA@DM8PR12MB5430.namprd12.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3826.600.51.1.1)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	PA4PR08MB7411:EE_|PR3PR08MB5755:EE_|AM3PEPF00009B9D:EE_|DB9PR08MB9948:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e3f4a7d-e7ff-49d1-defd-08ddce8c2abe
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
X-Microsoft-Antispam-Message-Info-Original: 
 =?utf-8?B?c0twR0hzOVJFZHhKVGl6UTN5bWJYWk5ZcG1JRkZiUE52dEsxdEhuMk0vb2s1?=
 =?utf-8?B?QnNPU2JUVlZKU1lvODlOaWx5Ym92dldkaUx4bTRYNDlkYy9BNXVQd2llekRt?=
 =?utf-8?B?OSt4aGRnVWF5WnZPZXg5Z2pNS0FOUlV5NVRXeVowRVlzNjVCd3cyMitSZmhu?=
 =?utf-8?B?V1ZMbzg1RjVYZ1Zja21NT1NqTXZkYU9NbGFnSEJGM3hCeDMxZVl0em5yWjIz?=
 =?utf-8?B?YThWNm5mTlFRZkdFTU90YnlSVS81dzY5TGNmV2dvWDNDZUNraDBaREoxMkk3?=
 =?utf-8?B?N2FPYlJkZEdYZHY3YzhkamZhMGpzRyt2OFlqRDlTTGs5UExFTHVLcHp3bkdn?=
 =?utf-8?B?WVZ4Yng1NGlzUzRBSnlJckx5NEV1NEtuYkYwb0g0bzFDS1M5N0QxMGd5VEM2?=
 =?utf-8?B?Z25tNG1nNlJ1Yi8rN0hwbXkvQzN6UXpuTlU5d0h4T2VUNUwrOENBL2lpM1g1?=
 =?utf-8?B?bXcrOGZNbGFzd21OdUhER3BVZ2NyQ1BPMDRkV3N1TWZtS3ZjUUwwMGpnZmFy?=
 =?utf-8?B?Tkk2c3hpemNGUUpvMzZ1T2s3VUVQZHFUWCtGb3VaZ2J1Q2tSbzgzWHRRVzA5?=
 =?utf-8?B?MTBJR1lJM1hsdFVGaGIzWW5kSUg4ekVmTGZTcitYV0hxSDdXN0R4ajUxWTlN?=
 =?utf-8?B?QWQyZEtDNlZnWitmUnRmWUIrekFFbE84QVlueGxvRVR1WW9iWjhLRjY5MTJU?=
 =?utf-8?B?L0FaN0ZzdlNnbllHZTMrdyttSjlkV2tHY0hSdnArc1dhSkx5UUI1VHpsL1Iy?=
 =?utf-8?B?N0ltZVJFejl1OHlPMWhnNVpSeGkzeUNlTU5oc2Z3dTRNZU56WldMbFVLc05r?=
 =?utf-8?B?VFBUSDFzWEVhUUg0Vk1nZm9hbFpqZVRjYmJINDFFZmoxSEtTNlREaG5yams4?=
 =?utf-8?B?L1dNUVhlQit2Smw1REJyK0x0bXFlTmlxNVI4TWVEaDJaa3JSOXh3Nzg4NVpE?=
 =?utf-8?B?SjVFb1dCb0NMaFhkNk5jWjdkb3AwSUdPS1NXZDBSZVJzVXFOdno5UFdCS2M2?=
 =?utf-8?B?MVB6MEw4YS80NEtpakNObjQrK2xodno2ZWZJS2RDUU53ZUpGc1g4Kzg1dzd1?=
 =?utf-8?B?UDNDUmFPWVhkZVI1QUpNOVRlc1R0dVFMc0hOeUkyb25GcFhBWloyTll1T2pL?=
 =?utf-8?B?M044a1l0WUV6dGd3K0tMZm9TeW9pN1NmSkhVMVBmRnBON3o0b0FqQ25qQzNN?=
 =?utf-8?B?M0ppRnJ5NzJ5UW9sYmtmR3hSNlJxRFBaazNKcHNxS1FnOFpDY3F5bnQ0MzNT?=
 =?utf-8?B?NG8wUllydHdaU2VaaER1NEdzeVBXQ2JyRExUMVR3YjBLd0IvMHB2ZnhTMER3?=
 =?utf-8?B?U2tyM0IwMmZiVUJQS05rUHFOM0ZaanNBU3dDWDA0NUVSbjl4cDlFTG13SW92?=
 =?utf-8?B?TVlHRnUwM3V6UzJZZWcxREY0K2xLT0dmaVNCY0MvTGgyTnN6MXhDemVaSm84?=
 =?utf-8?B?ZS9FOWNEQi96WS9od2hrbWFvdi85NmI5WVgvbTNaOGFTNzIzZm9wOEk0Wno1?=
 =?utf-8?B?d05uMi9jN1FxdVFQcDEzWmJJTEFzeVEwbW9wdHJDaEEzMktORlVVU2UwOVNy?=
 =?utf-8?B?aGFCbTZBSS9JclVtcWpFSDJNSHFscWFKdXF6a0FKNWFsaEpKSUJNMEJLWXlZ?=
 =?utf-8?B?elgrc1NuS29PV0VzUjAyWG5pZWxlU3JtVzNyVmw4ZWdtTXQ5Z25KUWF0dS9T?=
 =?utf-8?B?Qzhud2ZBNiswb3R6YklWYklPaWltS0Qyck1nS1QraWQwbEFjU0NrVklwVldW?=
 =?utf-8?B?ckd6TWxSUFBSdyt5bzZnOWhsejRyeTJ5WHdWY1lrMGxoWTZ2MENEdUhXNzFa?=
 =?utf-8?B?QTd6TDVGWlROS0ViMlZET2NGZ0NwNjRVamtEM0svUDNSaktpR2YrSi83RSt4?=
 =?utf-8?B?a3hXa1RJUFdnSlE0bWQ4VERLRDZMRVNKSm5lM3g0ck9CaStaY1kwSVJPcjNs?=
 =?utf-8?Q?QpTQ4XiaaJA=3D?=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR08MB7411.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE297310CCF75E4A83911B81EBFE0767@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5755
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 AM3PEPF00009B9D.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	b6f0d372-0c33-4122-433e-08ddce8c179a
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|35042699022|376014|14060799003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cXRPS29UYVNVbzAvbkJqbCtIS0p3cHp0QWJZWkZPMGt6YURhb2dSTGI2clBs?=
 =?utf-8?B?R1I2M1Q0OEQ3ZnBMYUV2c2tUdG4wTXY5ZnFPcHFPOXFRWUorQjlTNjVCQXk0?=
 =?utf-8?B?cmxrNDF6WjMrNFpJa1lRK2IrY0t6dnNjc3Fqb3BXODByREFORE9IQ1Z3T09E?=
 =?utf-8?B?SjJRK1JiZCtiOHFpa0hOckRQblZZNDcwUzRnVzAxeFVjeGNNYU1JWHNKK1BY?=
 =?utf-8?B?bnA1ZGZvNTJON2N3K093MWMrcjRiUWJnM0lTazVYcStVRlhHa0hOV1RneWc4?=
 =?utf-8?B?S2tJV1hGMWJ2ZGRUVjdzVWdxN0pKV21Zc1hiQ0NYak9Nais3VmVEZ3A0UTdX?=
 =?utf-8?B?QlJvMWJMaEJLVmp0U3ZJd3NvVzRzRnVnVklSdjVBRUphSTlkbzY5N1ZKR3hC?=
 =?utf-8?B?VlhYNkxVcWdyZnFaNFIzeTJabjY0eHdBbzlTVHNJdkdWdFFDcEZWRlJCQUFh?=
 =?utf-8?B?UnZwbG4zcHZ1U3JTcGlZSE1wYkNjRjJUVm0vUktobnUzSzBwUTZqQmdyaUJx?=
 =?utf-8?B?N3BGdnBpbEJ0aFdZQ21BdU4rSXBTbDZOVzJ3aUJVSmtrOU53bVRyVUM5bkdM?=
 =?utf-8?B?b1JkUVZ5dG5hcEczQWYyU3lwVFdNS3plbVh3UXdhQWxLaDl0T29JdWY5Nm04?=
 =?utf-8?B?RlBWOGdiM2lBTHdKU3ZNczN4QUo0blVxNHZYUXBTUngzSUI5NC8xM2o5cFlV?=
 =?utf-8?B?cHRpQlY5U2NhbFJnVFZXNDJwMkpBU1FlSnhzOEZ2clh4eklUTVRSNXdEZnN5?=
 =?utf-8?B?b1pMK0pmVHdObzdyY1pDdXBnSU1yYVgwWmNWK1k2bUI2Nzh0MzhHMXY0cXdk?=
 =?utf-8?B?RXF1bnNPWkFNajdUU29ha0pPNGJTNVhrYk5CNzVsRCtuK29LZUNlbGliTkRm?=
 =?utf-8?B?L1lCdy9BMjZiUk5aSE5WL2hPV211NXE4YUJtT3ZjNlpJSGhzR2Qxejh0Qlcw?=
 =?utf-8?B?dHU1a2dpRjVvVTdEUlF3ZzJSYUJDZDJDc1ZRQ28vQTJ5TVpiaTk3dDBRSmVD?=
 =?utf-8?B?MHloMFBkN0c2OUFUWmNJQkJrbUM2ZkpmcFN5K2JXYmpSZ1ZRcENDVS9RUjlD?=
 =?utf-8?B?bGt0NnFLcUtoLzFJVzAyK0N3MlFBeUVJTmMrellWMDJ1QUlhN1pZeEFjTm5l?=
 =?utf-8?B?cFhGb0hXdWM5OWMxQnNvZDltNXhrM0hrTElqbkRqbWdWNTF3TU51NUlKSmZw?=
 =?utf-8?B?ak0yT3A0RGY2ck5zdWtoR3ltdVg3ejV6TzlyTFRGWHJzU3U5L1pxMUNnZ1dj?=
 =?utf-8?B?MVFpKzRZNHd2OWZCMlQxclRabUhmSWRPRUcvbzNEM25FYnRUbk12cy9acFds?=
 =?utf-8?B?K3Riaks3ZDIzSEIraXM0dmFtSktTWTZzbTJ5U2N0Uy95VHB3UDBCbFdPQnVW?=
 =?utf-8?B?alNFZ3NnMzJFMnNQaXpGdXl2ZzZZU2pBT0hUQVYxS0VLVHdEem45OUllNUpl?=
 =?utf-8?B?UnM2MzVMSXp4SUdROWM0dkJVS2t6LzlSMS9oSVlKR20rQXRNNlRMN2liS2dM?=
 =?utf-8?B?SjJCY2lYeEhKU1Z0akNacTJLaFhtZzUwOWdJS25RZ2NjcXpGMlVJemZjeGNS?=
 =?utf-8?B?UVpxMzlXY0JDYm1BTDhVaVc0OWNQY3JSc2ZpaVBWQkRQYVhjSDJDdjcrY2Vu?=
 =?utf-8?B?STQyUjFUbEVKMitUb0diNmZpMFVLZ0MvbkRGOFV6NExKWm5YMC8zS0xPTE9q?=
 =?utf-8?B?bll4aTJDbkZhNHVpNldJVjNZVzBSQWM2b01UODFlaHhzSm9sbE5wK0xLVVpD?=
 =?utf-8?B?TG9vV1AwVnBKM0UyVmcyZkRhNm5xbjFoTWNsaEt2aW9Ed1FWVktYYktkOGtH?=
 =?utf-8?B?dXhuVVV0Ky9vZkFHZjlxQlVLenhaQ0gzRGVpMGdDM2poeUoxUC9WVHZyOTBr?=
 =?utf-8?B?NHF5RklHQnFWSDZxdXlqWEhVMnA0djRjQmQ5SVhjMUJHayt5Mkk4U2ZyZ2U1?=
 =?utf-8?B?elhZcmZZZHcrajlUcVl6WVZqNE1KN2xtQUlCVVg0NFI5R3l2MjRDanJvK2Iz?=
 =?utf-8?B?TVEwZHEvU3RnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(35042699022)(376014)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 10:39:16.4022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3f4a7d-e7ff-49d1-defd-08ddce8c2abe
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM3PEPF00009B9D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9948
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 29 Jul 2025 10:39:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17817

T24gMjggSnVsIDIwMjUsIGF0IDE3OjMwLCBDaHJpcyBMYXBsYW50ZSB2aWEgbGlzdHMub3BlbmVt
YmVkZGVkLm9yZyA8Y2hyaXMubGFwbGFudGU9YWdpbGVudC5jb21AbGlzdHMub3BlbmVtYmVkZGVk
Lm9yZz4gd3JvdGU6DQo+IGx5IGJlZW4gcGxheWluZyBhcm91bmQgd2l0aCBWaXpUcmFjZXIgKGh0
dHBzOi8vZ2l0aHViLmNvbS9nYW9nYW90aWFudGlhbi92aXp0cmFjZXIpIGZvciBwcm9maWxpbmcg
Qml0QmFrZS4gSnVzdCB0b2RheSAob24gU2NhcnRoZ2FwKSB3aGlsZSBwcm9maWxpbmcgdGhlIGNh
Y2hlIHBhcnNpbmcsIEkgYWxzbyBvYnNlcnZlZCB0aGUgaXNzdWUgd2l0aCB0aGUgc2lnbWFzay4g
SW4gY2FzZSBhbnlvbmUgaXMgY3VyaW91cywgaGVyZSBpcyB3aGF0IHRoZSByZXN1bHRzIGxvb2sg
bGlrZTogaHR0cHM6Ly9pLmltZ3VyLmNvbS9CR2R6U2U1LnBuZw0KDQpNZSB0b28hDQoNCkRpZCB5
b3UgbWFuYWdlIHRvIGdldCDigJx2aXp0cmFjZXIgYml0YmFrZSDigKbigJ0gdG8gYWN0dWFsbHkg
Zm9sbG93IGFsbCBvZiB0aGUgZm9ya3MgYW5kIGNoaWxkcmVuIGNvcnJlY3RseSwgb3Igd2VyZSB5
b3UganVzdCB3cmFwcGluZyB0aGUgcGFyc2UgaXRzZWxmIHdpdGggdGhlIHRyYWNpbmc/DQoNCkNo
ZWVycywNClJvc3M=

