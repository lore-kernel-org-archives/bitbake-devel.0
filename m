Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AA4CFD359
	for <webhook@archiver.kernel.org>; Mon, 24 Nov 2025 20:50:13 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.8])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1811.1764017410396677506
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Nov 2025 12:50:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=X+Wggc7e;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=X+Wggc7e;
 spf=pass (domain: arm.com, ip: 52.101.65.8, mailfrom: ross.burton@arm.com)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=tFWvfhcUiY+L3gbqLqUHvBN3/mVV4LPNAOMsalzSzocwtAiIEBXRDq1rLBGoLcgVTp1CdedfR6Ka7FrOVgFvxgCeDhFK3LRajWvQEH9KNPFbX4awbBP2oyngyFZU3WAcwcnEW8UkGlQg1VGYb1pDPZCw+jaTONjYW6fgd6K3i4ISPw+OF7nnrX3OZ5d013Yj8F8Psmpu8A50YdmIBB3YkvLAlHCu1otr+zZSPdao+86iz9rLXJBP3BO/4V3CVJe+CYrtLpA8xvYEcl2Do5btmbSbSodmlJrARz/a7Xip2s6de93aY/Ftp1B6MazEzHtmoxEkqA1ZUrZOBMPanwhFdg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Woufo9W3Yerbpa3YaiLQFBLdrv7s2e9RzmDDnJbxNlM=;
 b=Rq3G/wpwtoQjDduHwdazOvWi58nBuRXsfm9jf9WWl0R7rWpDkfKC8YCk/bwkwrInwNhj1Adqnbr+PDjNFARJR3kirN++Qm7OMJG+e7VzFM49exmsvkO5mmhMhRanhJmg87zREBUUP6p/+7Ty59wMWBB7mbWBgr1Wdnz6ymohaG9IxYBNKMZvGKdXsUsC3DtyZ9pHwB3wSO6ojCgjhv+BLhsazmXApsvbRby6zysbQQlnAlvoJ2WI7Fp5vmHoCOjelh4Ec9ODtqOdQ3EEVJKtjxO32UW5OvNbBiToWoFcalY/WMAhToA3NqkHKV2WpElCXtg890vh7ql+gaOcLJCRew==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.yoctoproject.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Woufo9W3Yerbpa3YaiLQFBLdrv7s2e9RzmDDnJbxNlM=;
 b=X+Wggc7eGxd2tTTzyYvunWh6jcH+LCeNTB6NK9u7fWmQwT/NttohTjKEFx2P5T/rgrBoXoQgOoTPwSmG3gk7PlnMn9wlhySsdkhHqJIQ3RLSqzBTWPPycQGkV/TWWL4HBzLwHBQaAkHhDotHN8AfjjkAl4kjqHlAiBvWSPMJv/M=
Received: from DU2PR04CA0241.eurprd04.prod.outlook.com (2603:10a6:10:28e::6)
 by DB9PR08MB9466.eurprd08.prod.outlook.com (2603:10a6:10:458::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Mon, 24 Nov
 2025 20:50:04 +0000
Received: from DB5PEPF00014B94.eurprd02.prod.outlook.com
 (2603:10a6:10:28e:cafe::79) by DU2PR04CA0241.outlook.office365.com
 (2603:10a6:10:28e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Mon,
 24 Nov 2025 20:50:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B94.mail.protection.outlook.com (10.167.8.232) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.7
 via Frontend Transport; Mon, 24 Nov 2025 20:50:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vTjPZMBGbQb4wqF0M4PBAF4Sz+hrBOXQUM4msZqahbMXJsJuut/fMKynW8nu6sPJXcIsPfRhf07TIoGc6HXdRgCLyLg6N1QoxDGPeOwoadqRlSyNcpOKSJGYOKuNvCBY5akTqh556vXgK+RrCxiTSg8hihIiqRw2JMs03oJfFhisb9T8pgjj+W7FZ0tFDh8D191amcrMhGk3fGypYq0mjyrZzrCdRAoMOrXkEsKrJq5Nsf/WFwD7T2D7tCRO9Cl1rK6O97k0Cg+VUybrSr7I/YbJBkflcjNxsxlZ469XQk0hEw8X+3dqLV60q2Kl9YI2VWP2mGZoxnLukYYhgs6JCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Woufo9W3Yerbpa3YaiLQFBLdrv7s2e9RzmDDnJbxNlM=;
 b=rGlk84oWYlXwmsOWAP65GiXh14Uy5hvyLUBQ6v+PBJymvJjxVepgd2nnlmwFAPwrCH/8I9sPjKfz2oexpMeu4Ccr4pLhiDAk6gBuxEeSMTvXFDWof5hle8HLN4+Zcjjf7lUXFJI9/LJfCS7DdWZPgT8zE4NSr6wINO3fW0FgBVbMHA1u12MyODVpszzdlg607uZ1kDWxV3Gh38xQ+QjHqYbovXuBVccrB2oB4/f86iOV3o7Ob2Rgig2SBNykZ8qIhk/vgN8p09nqBX8TeJGuFaB2uLYC6kOLRDF9RQJjyz43byy7W2WTxrYzD5VMlQ6S022MztplC81fNwwnkVVq7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Woufo9W3Yerbpa3YaiLQFBLdrv7s2e9RzmDDnJbxNlM=;
 b=X+Wggc7eGxd2tTTzyYvunWh6jcH+LCeNTB6NK9u7fWmQwT/NttohTjKEFx2P5T/rgrBoXoQgOoTPwSmG3gk7PlnMn9wlhySsdkhHqJIQ3RLSqzBTWPPycQGkV/TWWL4HBzLwHBQaAkHhDotHN8AfjjkAl4kjqHlAiBvWSPMJv/M=
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com (2603:10a6:102:2a3::12)
 by VI0PR08MB10709.eurprd08.prod.outlook.com (2603:10a6:800:206::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 20:49:31 +0000
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::7f73:806a:3493:7d50]) by PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::7f73:806a:3493:7d50%4]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 20:49:31 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: "yocto@lists.yoctoproject.org" <yocto@lists.yoctoproject.org>,
	"osama.abdelkader@gmail.com" <osama.abdelkader@gmail.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [yocto] [RFC] Proposal: New tool to display recipe dependency
 trees
Thread-Topic: [yocto] [RFC] Proposal: New tool to display recipe dependency
 trees
Thread-Index: AQHcXWcqn0ckOEkxrkesaZF2yrntlbUCTM4A
Date: Mon, 24 Nov 2025 20:49:31 +0000
Message-ID: <74C05E37-CEB7-49C9-AA53-CCA988FC7E7B@arm.com>
References: <aSSUtHYFQlychNQk@osama>
In-Reply-To: <aSSUtHYFQlychNQk@osama>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3826.700.81.1.3)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	PA4PR08MB7411:EE_|VI0PR08MB10709:EE_|DB5PEPF00014B94:EE_|DB9PR08MB9466:EE_
X-MS-Office365-Filtering-Correlation-Id: 6309df96-0072-4947-8240-08de2b9b0b1d
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230040|1800799024|366016|376014|3613699012|38070700021;
X-Microsoft-Antispam-Message-Info-Original: 
 =?utf-8?B?WS91QXcyRm9wejkvOVBhQ3UyU2tlaVJSK1JMYlUzOEFQd2F0WHU5bnRtVVcr?=
 =?utf-8?B?eTNCMm4rdG5zTi92MHhSdTJpa1NLVUQ4Y3didi9jMUtibGh2dXg2OUh2QUpr?=
 =?utf-8?B?MnBIdzNPb1gyanJzV2VrTUNHMnJCU2o1T29jMGhkQ2xJdGVybmtZTmszeis0?=
 =?utf-8?B?eVV1blZicysvckJMOVovZzc3WjJldE40ZU5EbVluc01pdndBSzRiTStvNk93?=
 =?utf-8?B?akJGcmRpM0VEa3NOUDdldW84ZFp2Tm1ldGlUeHFjQUNRMzlwZFdFWTY2dlFW?=
 =?utf-8?B?UnBybUlVdUxmVVlhRWpsaTh3cjFVZmRycHFlTFcwVWFxVGxCUDdJYjg2eFRO?=
 =?utf-8?B?RkRoYXEzbVhVMUhTM2pPeVVBS2E5VjlVbG56ZllSSlpTM3I1V1pwMUdXQlYy?=
 =?utf-8?B?SHJucjB2RklOK3JHdGVCSldhMWZ6QndpeDR2YzF6YmcwK21qek0xTFFVTzFa?=
 =?utf-8?B?dUV0Nm5Oa1B0QzJXU2NhV0pGZEhEa0h5bnpxaW9TM3hTb2JsR2RxS0VGRHI2?=
 =?utf-8?B?eWh1QWU0S3U5ZUpXR0pRbkY1WmlGVUZ4SW5OMDNDQzhpRUR0bmw0ZEwzYXhn?=
 =?utf-8?B?VEt2RE5vUGkrM0JUeXlOeXltcy83cWJxdVNVUUlFbitpeHorWVVZYTJ1cXND?=
 =?utf-8?B?S3pYWjIzQ21RZzFZM3AxOXJnblVVS3dNc0pwNmpVWUN1U1YyMzdlMU1zTVBU?=
 =?utf-8?B?SHFHRlBjM1MwZDNYeHJYUDZ4MFZGeVNLeTBFRkhGaFVNV1kwd042cFdFOGRo?=
 =?utf-8?B?VkVtSmVGQmdpMmtqQUliMXVtbWJyeW9JRVo4T2ZPOFN3Vjk5TS9UOWVqNUZn?=
 =?utf-8?B?enVHRDVzVGpJbEg2cXdOb0FTeWdQZ3pxdjVjRFVqRHhuYld2d2VXR3JrVTBi?=
 =?utf-8?B?Zk1PRUVpRjd1VE15UlFhZ0h0YTBpcnAxemF3MjZFQ3FaN0oyaFNUK0o2Q0Vp?=
 =?utf-8?B?aDRhMmxXTXVyM29ERFEwQ0FhZGtzU3p5bFdLbVRuTmhPeGhRNjNwdjVTSW1z?=
 =?utf-8?B?N3B6S0oyeWlwaTZWdVFVSmlXM29rRmNkK3Y4b0hzanFpeHRkVHJLR1JlQXlP?=
 =?utf-8?B?YzBNeGh1WEhVNWpWbXp2bFAyT0lvajE0WU1SRENoNzF2MXpIcG1TYVIyWEZG?=
 =?utf-8?B?MjMrYWFtd29qMWhobHNEUjk2anpnT0FBS2JjcGU3UDE3d2lPamUwRWpUa3B0?=
 =?utf-8?B?NHlrVnlHNGRJZUtOVHhNKzE5cXNGRXpOaXBob3Y1ZUNRV3ZQTzdlNm51cDhQ?=
 =?utf-8?B?em5remJONVFZWTE4eElFRHFYcmRFV2FkZ1Z5SDZoVmQ1Vmt2M05TSEdNazZj?=
 =?utf-8?B?MEdMYTFjOXZ1MDBkVXZQWmxlNnM1SkJvY3FvLzJQWUcvWXhKbUdjcmR0UVZR?=
 =?utf-8?B?cHJTUmdhUDdycW9CaXdGUXBpN3hXTnhqRGJIV1RqdXo1eUEyaEVwMVAzTW5S?=
 =?utf-8?B?eGdkdmdEZ1djcW9sSDdBdnlmZTd0Vk94Y1lqOXUzaFFoSFp6Mno5NEdReGhC?=
 =?utf-8?B?ckdzanhlMnpkbHB0Q2o5UWJJMkcwSVZ0SnphcEt5N3JYRU9pVFkxY0syRHNj?=
 =?utf-8?B?VUFYQ0M0TGR2Qng3MW1mcjJMam03VWpPcVRLa1d2NE55Q2I2dGY0NTd0N0xi?=
 =?utf-8?B?RUhpb0JwSkgyelpxUDlpa2M5eDJWWEdxRzNsRTFNbjFITE1WMmw1WDU2Ri9F?=
 =?utf-8?B?QThsbEZRNDFQVXJ0NDVrMlRqUkFOcmwvS1BLVmlnR1U0T3JmMlJ4aW40cmpp?=
 =?utf-8?B?WFRHa0hTRGdSY3FxUXhJaWRyRUhGWks3YlhEdURSMjBMdXJNdGFtalhSMlho?=
 =?utf-8?B?WU1DWGdRejZYYTRoOGpBT0dlblNib1hvaEQ4UGNkUzdGcEhyNVRDRE4vR205?=
 =?utf-8?B?VjJnUGtwL0xkSlFiemZRTGRRQ1pUSmNTSGFwdHZNd3crMkZXMVRyWXk4aTli?=
 =?utf-8?B?WUVIMUdGTWEySEdZZEdwOFk3TUNRQXpKSnVkNHhCQitaZTV5eTVUWjY1OGhN?=
 =?utf-8?B?dFFNL3RWdW1Cc0FrZkpxalpraU5YVSs2Zks1VVpaVFY5OFRSRzFNUmJ0MXRL?=
 =?utf-8?B?WFVJaElxbWk0RzRhUW5wZGh6V1NrZDBsSzhOdDNLbDRkeDhGRlFLQ3FGcEo5?=
 =?utf-8?Q?fmXs=3D?=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR08MB7411.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(3613699012)(38070700021);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <32288B0B3A91CB4FAE31AE4242FBA74F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10709
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 DB5PEPF00014B94.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	7f1ace8b-d876-4a7c-0a7d-08de2b9af7bf
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|82310400026|36860700013|14060799003|1800799024|35042699022|3613699012|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YUhacnAwblRkb29LYjlycmJ6eCs1OE4xSFRjZm1zbEpzVFQzd0VtbWdjYlhF?=
 =?utf-8?B?TGQ5VEZxL29qU05vN1kvcHREWmJpNzNpbEs3QUpWdXgvY3NSVkgybVpSSnlr?=
 =?utf-8?B?SlRUeDlkemtCaERudFhtZkFGQlFKZVhEQlhDVjNabDJhMExCeUlEWEdDd3Yw?=
 =?utf-8?B?L05FaWVXY1IxdnpXb1JEVEtNaXVkV0xJMStMYktyZXFGMHk1d1RuL1R2VXpy?=
 =?utf-8?B?ZHl6MGJYVHBBOWhHem9RSENRK2hTZGpWTlZDTEdNRDk0ZGorb1NWMkZOYnBw?=
 =?utf-8?B?ckZmWE5YZldDbkY0Z0haYVpqT0tKeG5mRFJSNUdubTJHTEtLNG9UWjQ2TGRz?=
 =?utf-8?B?b0l1T1FaT2ptRHlGZWxqbTRiTllTOXVNaUxNY1lxd2YxaVNnWkJSODhlYzZa?=
 =?utf-8?B?V2t0WHV1L0dxVU5PZGMvamlKRUlZcWo5OXRFR0xmemtUbWVFVGZ5dmg2VHlE?=
 =?utf-8?B?WU9waU1zN29aY2FZaXhnRnNza3o3allCK0JZVVdPZmtSV29mQjVGZHQ0Z0JM?=
 =?utf-8?B?bkFwWkQ4VGptemtEMXc3SlhER1U4RSs3ZUEvakJBQ21kQk9FWkQvT3NYenBw?=
 =?utf-8?B?TldtN2RpM2JSNFhDWUR0SDZKZnBvSG9BemZhMXRqUFhFR29iVG9ET2RZY2Jw?=
 =?utf-8?B?THN1d1A4dVFndGVNMmFqU1d0RWdmTFJEaVd1U1dBRy9FUjQ2LzFzL2FXeU9p?=
 =?utf-8?B?Y2R4V3VXUTJOZk8zYUpqMmhObHVuSlFZcVNWVjVoS3JGMHR1L3Z6Y2paZFBq?=
 =?utf-8?B?YUxtdjBKT1JqaW5nbUhNYzRYc21saDk3a3ZtT3BMTE9nbmNZU1BmL3d5bjJE?=
 =?utf-8?B?UnJ2TE1SZzVWMGhINmJhVUIzV1c1QkNQZENyMkZMdWtUc1BzTDRIdTZ6OE0x?=
 =?utf-8?B?MzBMWldETkdOcEk3MzVEakNaTnBGRGp1M0ZBajlNR2dIUnhXMk5LcUUxZmFJ?=
 =?utf-8?B?Y3FyOXE2cER2WWZSWmpXenAwaFUvYWNTTlB5Q0hOSnYzL3hhVHJiTXZGZTc5?=
 =?utf-8?B?VzZGN3FmdkRnQ081eVBKaFJiWDNhRmF1dEFySXBqOGxiZXcrRDRlVXo2b3JN?=
 =?utf-8?B?OU1zRkFBc3BoRGk1WFBxRllmNjVFR0VHK3NINGVjL3A5YXE2aUJJczB3b2kw?=
 =?utf-8?B?QjJFaHdUQVJ1K2Q0Qnp5RUpkenBtMWJPMkFOSmFnYUY0TnptSWVpMTFheWp0?=
 =?utf-8?B?SFc3ZkltSS9tNVFxbXRXSGh6c0UycEhMOGJIckRxRDdweHQ5bU5MZDlSRUVE?=
 =?utf-8?B?bEJ2RHNXa3NmQTNNd0pmY2pZajIxMkR3Q2FVTWZ6SVppRjQxRU40M3BoWFRW?=
 =?utf-8?B?dXFQd3Z4eXV6WWRZMFJFMmdZNXhzME1HTmxTbWgzbTNRNFVXSS9KU1krQlRG?=
 =?utf-8?B?OUE4M2haWVZLUlU1VDdEMWJRSDVWOEJYb3hhM2NWS0JQTTZ6cUlzMUgrdGd0?=
 =?utf-8?B?bjNZN2pYeEowcDBPTVp6RTVyZEhNL0hVUWJ0ck5jdUpVQndEUmZCRVplMUlm?=
 =?utf-8?B?bm0yWFMxNWpTT3lHTC9kaWtxL2VqZjcyeDUvbUZwZlFBWXBOd3hpaG9wbDdT?=
 =?utf-8?B?VG00RjU1NkRCcGZUenVJZ0NTSkN4NzRGeU00U3RuRnloSmRzM2ZtOWVjdlI2?=
 =?utf-8?B?N0NjNFpKOGNkOW9KZDBvUDdNbDFDaGN0Nit0ZFFHQUYreHlzV2ZZNFNpd3lu?=
 =?utf-8?B?NWo3Z3ZNRmxUMjdxSXZrbUswS3FWV3Uwc1Q5eVhpcTRRTjEvTm0vRzFxdm1a?=
 =?utf-8?B?SUIrSmhGL3BqeWUzOHFjK0VEelZNV1d4ME4xYWNPUXZ0djhxRXk5dEEydmRR?=
 =?utf-8?B?MHN6cnd4cisxbC9icmZVcUFsSnRsdHdkM2tGWnVQSDl0SWEzOWlOYWlQSlk5?=
 =?utf-8?B?M1VheUpXcE5LeVVrNlRrMjVob25vQ05BVm5uZE1jSktVWUJROWJsL2lZb2VL?=
 =?utf-8?B?aUJISUFManF5NDY3azdCMjNCMG50ak96QlRUSjdhbGNGRWR2RVFiSFVzSWdq?=
 =?utf-8?B?akk0NStsM2RWZHYxUHJPS2NXNW4rckNLb0d4TGtIYWo2dCt3Yk5wSytsTzR2?=
 =?utf-8?B?WkozZjVuT0xkb1YreGxsQS9zOUg2RG9aMTB0b2VOaVVob2JHc0hraXQ5M3hn?=
 =?utf-8?B?b0pwSmh0MDVob1JuUk5qaU1RVS9zVGxOY1BKVmo1TVVQamZGTXVGSUpLdW43?=
 =?utf-8?B?aHc9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(14060799003)(1800799024)(35042699022)(3613699012)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 20:50:03.8580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6309df96-0072-4947-8240-08de2b9b0b1d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5PEPF00014B94.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9466
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 24 Nov 2025 20:50:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18486

T24gMjQgTm92IDIwMjUsIGF0IDE3OjI0LCBPc2FtYSBBYmRlbGthZGVyIHZpYSBsaXN0cy55b2N0
b3Byb2plY3Qub3JnIDxvc2FtYS5hYmRlbGthZGVyPWdtYWlsLmNvbUBsaXN0cy55b2N0b3Byb2pl
Y3Qub3JnPiB3cm90ZToNCj4gDQo+IEhpIEFsbCwNCj4gDQo+IEkgd291bGQgbGlrZSB0byBwcm9w
b3NlIGFkZGluZyBhIG5ldyBjb21tYW5kLWxpbmUgdG9vbCAob3IgQml0QmFrZSBzdWJjb21tYW5k
KSB0aGF0IGdlbmVyYXRlcw0KPiBkZXBlbmRlbmN5IHRyZWVzLCBpbmNsdWRpbmc6DQo+IA0KPiBE
RVBFTkRTIChidWlsZC10aW1lKQ0KPiBSREVQRU5EUyAocnVudGltZSkNCj4gT3B0aW9uYWwgZ3Jh
cGggb3V0cHV0ICh0ZXh0LCBKU09OKQ0KPiANCj4gTW90aXZhdGlvbg0KPiANCj4gQ3VycmVudGx5
LCBCaXRCYWtlIHByb3ZpZGVzOg0KPiANCj4gYml0YmFrZSAtZyBwcm9kdWNlcyB0YXNrLWRlcGVu
ZHMuZG90ICh0YXNrLWxldmVsLCBub3QgcmVjaXBlLWxldmVsLCBtdXN0IHVzZSBncmFwaHZpeikN
Cj4gb2UtcGtnZGF0YS11dGlsIHJ1bnRpbWUgZGVwZW5kZW5jeSBvbmx5DQo+IGJpdGJha2UgLWUg
PHJlY2lwZT4gdmlldyB2YXJpYWJsZXMsIGJ1dCBtYW51YWxseQ0KPiBFcnJvcnMgZnJvbSB0aGUg
ZGVwZW5kZW5jeSByZXNvbHZlciAoaWYgYSByZWNpcGUgaXMgbWlzc2luZykNCj4gDQo+IEJ1dCB0
aGVyZSBpcyBubyBidWlsdC1pbiBDTEkgdG9vbCB0byBkaXNwbGF5IGEgcmVjaXBlIGRlcGVuZGVu
Y3kgdHJlZSwgZS5nLjoNCj4gDQo+IGJpdGJha2UtZGVwdHJlZSBkbmYNCj4gDQo+IGRuZg0KPiDi
lJzilIDilIAgbGliZG5mDQo+IOKUgiAgICDilJzilIDilIAgbGlic29sdg0KPiDilIIgICAg4pSU
4pSA4pSAIGpzb24tYw0KPiDilJTilIDilIAgc3FsaXRlMw0KPiANCk5vdGUgdGhhdCB0aGUgYnVp
bGQtdGltZSBhbmQgcnVuLXRpbWUgZGVwZW5kZW5jeSB0cmVlcyB3aWxsIGJlIGEgX2xvdF8gZGVl
cGVyIHRoYW4gdGhhdC4NCg0KVGhlIGFiaWxpdHkgdG8gbWFyayBzb21lIGRlcGVuZGVuY2llcyBh
cyDigJxzb2Z0IHJvb3Rz4oCdIChlZyBnY2MtY3Jvc3MsIGdsaWJjKSBhbmQgb3B0aW9uYWxseSBz
dG9wIGF0IHRoZW0gd291bGQgYmUgdXNlZnVsLg0KDQo+IElzIHRoaXMgZnVuY3Rpb25hbGl0eSB2
YWx1YWJsZSB1cHN0cmVhbT8gV291bGQgQml0QmFrZSBiZW5lZml0IGZyb20gc3VjaCBhIHRvb2w/
DQoNClllcw0KDQo+IFdoZXJlIHNob3VsZCBpdCBsaXZlPw0KPiBPcHRpb25zIEkgc2VlOg0KPiAN
Cj4gbmV3IEJpdEJha2Ugc3ViY29tbWFuZCAoZS5nLiBiaXRiYWtlLWRlcHRyZWUpDQo+IGV4dGVu
c2lvbiB0byBvZS1wa2dkYXRhLXV0aWwNCj4gc3RhbmRhbG9uZSBQeXRob24gdG9vbCB1bmRlciBz
Y3JpcHRzLw0KPiBwYXJ0IG9mIGRldnRvb2w/DQoNCknigJlkIHNheSB0aGlzIGlzIGEgcXVlc3Rp
b24gZm9yIGxhdGVyLCB0aGUgcXVlc3Rpb24gZm9yIG5vdyBpcyDigJxtYWtlIGl0IHdvcmvigJ0u
DQoNCj4gUHJlZmVycmVkIG91dHB1dCBmb3JtYXQocyk/DQo+IFBsYWluIEFTQ0lJIHRyZWUgKGRl
ZmF1bHQpDQo+IEpTT04NCg0KQW5kIEhUTUwvU1ZHIGdyYXBocy4NCg0KPiBTaG91bGQgdGhlIHRv
b2w6DQo+IA0KPiBjb3ZlciBvbmx5IERFUEVORFMgKGJ1aWxkLXRpbWUpPw0KPiBpbmNsdWRlIFJE
RVBFTkRTIHdpdGggcGtnZGF0YT8NCj4gcmVzb2x2ZSB2aXJ0dWFsLyBwcm92aWRlcnM/DQoNClll
cyB0byBhbGwuDQoNCj4gQW55IHByaW9yIHdvcmsgSSBtYXkgaGF2ZSBtaXNzZWQ/DQoNCmJpdGJh
a2XigJlzIG93biB0YXNrZXhwIChiaXRiYWtlIC1nIHRhc2tleHApIGlzIGJhc2ljYWxseSB0aGlz
IHdpdGggbW9yZSBncmFudWxhcml0eSAoYmVjYXVzZSBpdOKAmXMgdGFzayBkZXBlbmRlbmNpZXMs
IG5vdCByZWNpcGUpIGFuZCB3aXRob3V0IHRoZSBkcmF3aW5nIG9mIGFuIGFjdHVhbCB0cmVlIChw
YXJ0bHkgYmVjYXVzZSBJIGp1c3QgaW1wbGVtZW50ZWQgaXQgYXMgYSB0aHJlZSBwYW5lIHdpbmRv
dyBmb3IgY29udmVuaWVuY2UuDQoNCm9lLXBrZ2RhdGEtYnJvd3NlciAob2UtY29yZS9zY3JpcHRz
KSBhbmQgcGtnZXhwIChodHRwczovL2dpdGxhYi5jb20vcm9zc2J1cnRvbi9wa2dleHApIGxldCB5
b3UgZGlnIGFyb3VuZCB0aGUgcGtnZGF0YSBpbnRlcmFjdGl2ZWx5Lg0KDQpiaXRiYWtlLXdoYXRk
ZXBlbmRzIGRvZXMgYmFzaWMgcHJvY2Vzc2luZyBvbiB0aGUgZG90IGZpbGUgb3V0cHV0IGZyb20g
Yml0YmFrZSB0byBsZXQgeW91IHNlZSBfd2h5XyByZWNpcGUgQSBkZXBlbmRzIG9uIHJlY2lwZSBC
Lg0KDQpNYW55IHBlb3BsZSBhc2sgZm9yIHRoaXMgdG9vbCwgc28gSSBob3BlIHlvdSBtYW5hZ2Ug
dG8gaW1wbGVtZW50IHNvbWV0aGluZyB0aGF0IHdvcmtzIHdlbGwuICBJ4oCZdmUgc3RhcnRlZCBh
IGZldyB0aW1lcywgYnV0IG5ldmVyIGZpbmlzaGVk4oCmDQoNClJvc3M=

