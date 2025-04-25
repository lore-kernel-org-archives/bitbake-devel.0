Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BE8C369D3
	for <webhook@archiver.kernel.org>; Fri, 25 Apr 2025 16:50:21 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.49])
 by mx.groups.io with SMTP id smtpd.web11.11126.1745599814177764661
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 25 Apr 2025 09:50:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=Ga6kKtdL;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=Ga6kKtdL;
 spf=pass (domain: arm.com, ip: 40.107.130.49, mailfrom: ross.burton@arm.com)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=bUOLOqoAmGVcHGBVVAUgyKIJy1n+VzJqFOMAhnqQyUlvQChVKSsiU4mp5bF1ZobMEzYDUn4AbshvlqmLHJauy8GJOYMjcMArpn8XvBTgsZ8NcR6xIoPILvA55oasi+oDvPM47T62RbCxnwX7rDv0WEA+LOWdakzNBEFtSjlSE8i4Sk8eetpNZXJr3s2CC1nJ9fELIo0t1A8oHJdir6K9wD63xmtDHfnDPZ2Vn9pKXiqFT6bfpn5Ubo4xUdLMZG/h0BEjtTt6KpaF5A4Wj2h3fu2lP0TuxqPU3dejX178nbgjQEK5PH+2Zu0AMZ3Vp7TNtHqatNG0NGF1gMFN1yScyA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVYpZPftcn1Sl4dl5X4DfmQD7q+n+A5LsB3hO1DYuJw=;
 b=PDa4oS5Ocl9NrBELEexHss5d97AHnR0I63x/ThO1xyOn7RelIc7vX+Hf8YgOsCRG9+4R/8ebX2QVH6Ml+HB2cCK3khVAkJQYQq/Gns9wtc8sTzXuLoVNPUusxt60mSPOzXrsS696JpJ3ist+wswNW98M1WwMZxi2MdJeuqZ5v7fUGTF7VtI2OSpw41QIFfpsLgE7Y3cReYO9oDeuKT4e+J2oKUv2iu62iGHoTywvi1KB/UyMVo279mNe7ppXDfyYdEtXmrobqSmjjQ6R1ivij/NFnoRwGYO1GXZgudLnFjwXvPQRy4x7aNkrqhss2DGPbuGZgXpyoeZFCUrbv0nxhQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=freemail.hu smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVYpZPftcn1Sl4dl5X4DfmQD7q+n+A5LsB3hO1DYuJw=;
 b=Ga6kKtdL0If6ZIWNPhqq46rdo1WfbOXCt7KSVBoT1klBnQ/lYR3TMB+jVdrAFWx7+6ic0B5mHhLZC1+CDqI9390Ihyydg99SufYKJGToaCu/7LwGqoG0PNT9+y0jsIOEqOuKuR3+suI9XLmjtPfnGUNRm9hECFlnq383pMOBsRU=
Received: from AM6PR05CA0031.eurprd05.prod.outlook.com (2603:10a6:20b:2e::44)
 by DBBPR08MB10385.eurprd08.prod.outlook.com (2603:10a6:10:52a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 16:50:09 +0000
Received: from AM4PEPF00027A5D.eurprd04.prod.outlook.com
 (2603:10a6:20b:2e:cafe::5d) by AM6PR05CA0031.outlook.office365.com
 (2603:10a6:20b:2e::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Fri,
 25 Apr 2025 16:50:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A5D.mail.protection.outlook.com (10.167.16.69) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Fri, 25 Apr 2025 16:50:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W5aE6ZdA3sunsFBBplqeyAm9GIAf7QMBL/iqxF5xZCTr2UjXDGDGhZjj58X0+0DDkq5gc1bWaqxZ4XPUeQlKNaolQjNxRd4OT9+NJe8mK24mk3JXWQDT9NAcoJqSH8Vzs30iEAALJ7e/sMYWC7xtSPSxiv8E3D/j5ZQdpqyjh+zJ6jdx5cYAjI651yIJMUoxPQjn/X7nyKGr8vJ6WeINF58KYzwvUTXD4/lu+TH83A6RAqPbqnGuRw66xgMecz9IYWNt7nFZSOmDzTKrXjttnL4AJzXoaqvBEvGvxd5s4CrQGrSLVjRQfpZzxYUDhYFwbqxLmHcCDSq8w310KyKoDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVYpZPftcn1Sl4dl5X4DfmQD7q+n+A5LsB3hO1DYuJw=;
 b=tnIg/34Ri2S4ZuDsnlBM6VGWnhDX8z05ynQvk8jqtNK2luTHbjDek4mHavJ5e9B6o+rYi7tJrvFICbURTP4M8ihJvknaaMQHdsAzTouPsEiQ0B2q5OymRZhyiFNyzArbXNlACSRb+b5gHTyWTay+xW6vMhr18n6u8U2FLa2QPH7J92pzcZo5cEliVSVP4SLFX6yGZ1WEycb/+20Moe/x5lbBDL77jbCHTKlSLLPAjJ2jWot+Mmr5PgIkaLLiGe7zTuEWlHhHkmFe5hK1PYV5j0McNiON5WGEiX9OE6NizHknZUgy4QdJD1uPcLnlw2JqTxoHEDPT/LmavsHQEVkyuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVYpZPftcn1Sl4dl5X4DfmQD7q+n+A5LsB3hO1DYuJw=;
 b=Ga6kKtdL0If6ZIWNPhqq46rdo1WfbOXCt7KSVBoT1klBnQ/lYR3TMB+jVdrAFWx7+6ic0B5mHhLZC1+CDqI9390Ihyydg99SufYKJGToaCu/7LwGqoG0PNT9+y0jsIOEqOuKuR3+suI9XLmjtPfnGUNRm9hECFlnq383pMOBsRU=
Received: from AS4PR08MB7429.eurprd08.prod.outlook.com (2603:10a6:20b:4e1::9)
 by DBBPR08MB10673.eurprd08.prod.outlook.com (2603:10a6:10:53d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Fri, 25 Apr
 2025 16:49:36 +0000
Received: from AS4PR08MB7429.eurprd08.prod.outlook.com
 ([fe80::8db5:7772:a426:2afe]) by AS4PR08MB7429.eurprd08.prod.outlook.com
 ([fe80::8db5:7772:a426:2afe%5]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 16:49:36 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: "egyszeregy@freemail.hu" <egyszeregy@freemail.hu>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v3 0/4] bitbake: knotty/progressbar:
 Optimize footer update and prints.
Thread-Topic: [bitbake-devel] [PATCH v3 0/4] bitbake: knotty/progressbar:
 Optimize footer update and prints.
Thread-Index: AQHbbyS5thTHsUA4JU22EsRo20VAibO1JbgA
Date: Fri, 25 Apr 2025 16:49:36 +0000
Message-ID: <B874B5A6-7620-4718-9BA4-224CFFBD59E8@arm.com>
References: <20250125122752.649-1-egyszeregy@freemail.hu>
In-Reply-To: <20250125122752.649-1-egyszeregy@freemail.hu>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3826.500.181.1.5)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	AS4PR08MB7429:EE_|DBBPR08MB10673:EE_|AM4PEPF00027A5D:EE_|DBBPR08MB10385:EE_
X-MS-Office365-Filtering-Correlation-Id: c7138618-4e99-4f88-01e1-08dd84193c9f
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
X-Microsoft-Antispam-Message-Info-Original: 
 =?utf-8?B?YXRDcWd6ejQwWkJSNE5vM2RaMFJSVFhmSUNIdTU5S2t1ZWVPbEV5dE9PaTdj?=
 =?utf-8?B?S1VKdlhLYXNjQUVYRlJYc0dwckdodHBTSGlVQ3d4amNRdFlwalIwSm8va2Q3?=
 =?utf-8?B?ZHc1aU9oWjVJcTlVM00vQzkvdzVNQ3dXYVdvSDQ0UWpQcG5xQXdpQ2kzeXVq?=
 =?utf-8?B?YTZSb0NIVHUrYlYxZUIyaGttejc3eWJoZmZjZWwrWVpZby9RTE9HdGRDODg5?=
 =?utf-8?B?MDlEbEJnTDdxelg5eVJLQ1h5NXBUeTBRTWJOQU8zZE0vTW1KODlxL3JINFVn?=
 =?utf-8?B?OE9hYmpTa2dCTzdGTzQzU0twNnB4VHI2MVJtZTdlVWE1bHgwQ0UyemphTS9C?=
 =?utf-8?B?K3NjZ2FmRHVaUmlLWDFleC9PTFJjM1J4Sk9FUXJRMFVnY0V6anpRejVVOXZG?=
 =?utf-8?B?OEpyK0Jxb3hiY21TV1pib0JtMnZOVXZ1ZWQ5aEoycFpibm5Ma3RTd0dsUUFP?=
 =?utf-8?B?c1JjVWpHS0NsRngzQ1RmaVJyUmp4Z0pVeDBMUzR5TTRuU3hmY2k4am12UC84?=
 =?utf-8?B?emQ3aXhDV0hSenB1L0p2VEFJZzJBcC83dnV6V0JKZzBaM0hkTTltZWNYQzJR?=
 =?utf-8?B?MlY1cWVTWGJYb2ZoZEM4ZEdRekQwRUdmVnd0b0NQd2hVK3F6YW4zbGJ5ajdn?=
 =?utf-8?B?QkMrUHNVamV0Y0Y3TGxaUisyL2xBd0I4QTBEbVBsU3E1ZC8wQm9FNDZRb29s?=
 =?utf-8?B?QitacGJVeHMvSWs2eFN5OTBmWGhmTXhPUllHMGswTi9Mbk16ZkNNbDZIaVRx?=
 =?utf-8?B?bG51Mlh4OWgrWXVUVzdHckZEaVh5SVJSQ25SRW9QaTZBTS82dHJUMG44ckRR?=
 =?utf-8?B?enlZcVJIMUhWVzRxZms1VHVoYmREQ0RyWXpkUHhXaEFocTYxMGdYZENhRnAz?=
 =?utf-8?B?WUtYNWhIUVNGMzUvWnloVVJmdlJmQm4xQWg1VUhTUnJmN1ppUkhnY2ZTTHpt?=
 =?utf-8?B?R1VkSFBveWpJUDQ1aXdveUlPQjFENm9tbnJkek02elptUGhSeTFidVUyd0J3?=
 =?utf-8?B?Q0JlWGhSSEtIZzgxZTk2dHd6dmhxNVJDdnJHMzduMVhFT3VVQy8rL2NvQ3lM?=
 =?utf-8?B?bVFyTmsvRWVLSHNkYUtFMndHcmRPUjBzUGR6emdwVXFLSU4rVk9IU090c1o5?=
 =?utf-8?B?b1dPKzZsa05DWjNPYmkyR3dhT0V5bnhieUxsVGRFK0FHcVBJN3Arb1VBM3Ja?=
 =?utf-8?B?OFVMcnZ4MjVVRmpGOVJzV0cvODNDUklUTUIwU1Q1T2RYTzlwZ0ZIWXNOSW1k?=
 =?utf-8?B?b1FQeGJ2aEtwS3R0YXhhVHVRQkFlVkw2TExuZkNtNTJEc0ZuRE8wVW1hZXpY?=
 =?utf-8?B?Vk9ZbldyTFZvRGVJRUk0VTFmQjhlWnpiZDhuUGtaaThXeGtUeXZQNlFrYUtS?=
 =?utf-8?B?dDIzUWswMWhSTkMwbkd0VmxhSkRkTVRQdU5ESTluQ3VmRDhnVnNBbVpYeUNy?=
 =?utf-8?B?cWgyZUVZS005WnRIcEJhUzRRV1RkM213Ukk2L1NnRUFPc2ZiU3c3MWUwUVpV?=
 =?utf-8?B?VnA5UnFqWFdBL1hzcjBFVVdxWGxucnJQR055V2c0dUlYRzdyU0JRbXhzYzBW?=
 =?utf-8?B?ZituNXAyWmlEZ0s1MUROWmh5SmVIZDlkY2NhWUV5aTlJYmt6eVZPQVV3QzhI?=
 =?utf-8?B?TlpRTElIZGJoTzRpY3AyQXo1MmVrN1dIUkRoRWlNTFFBeVkrTlVUdm12YmJi?=
 =?utf-8?B?aFVoeEliRWF4TzlVRGRVSjRkc1JEdjhINEdmUVd5MVdta0p0MVJ3cnpFb20z?=
 =?utf-8?B?NzFrZWI3azE0bHlYZmNKcFhoNFJVajNkMjBmS2hQejJRVy9EenFiTmdNUHZo?=
 =?utf-8?B?dVFjL095bXRzRjJadkFZSlZUdytqTGhxZG5vQ0JWdklzMUVoUTdhZXJ4aU1I?=
 =?utf-8?B?aTBjcVRMbnRUeHFlL09hMVU2UVo5NHNPN2FjeDM5ZWxLKzZCRTFySXo5MkhT?=
 =?utf-8?B?MlZZLzQrNHVUYVF5RzR5YnR0RkJFODZuWW9xNVRYcncrYUtlb09oSGtYTzc3?=
 =?utf-8?Q?3aayFdKelhrbtvSOKePMbW7dW7AavM=3D?=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR08MB7429.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <5CC7D6A0A6AC3149849481A0EA5846AC@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10673
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 AM4PEPF00027A5D.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	e9c65534-78fe-4550-3e24-08dd841929af
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|14060799003|35042699022|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aHhHYXF4UGhCMG9vZ21ONEVsenFkMFdoc1RBUTdxMWdFT0RSemdSaHlzZjRz?=
 =?utf-8?B?azdYV2FmejFCQmZPa2I0eERJUTFaZDZJR3Exbkt6MHVHSUp0OWtMN053ZmNh?=
 =?utf-8?B?TE5qa3lQZmlpMjd3djJBckxKSVVLck03T2tCQUpGUkIrMzlYMHlKUHplZUJI?=
 =?utf-8?B?cTVBZitkZUp2V3ZPSFpmbkh3MmZmRDJCWG9xZ253aTdxc21HL2Q4bHBUMnVJ?=
 =?utf-8?B?MDRQcDVxKzFVUTE3S04rZ1dVV2tsY0JsTVltVUJ6cDEyOTl6K1l2M0x5dTc5?=
 =?utf-8?B?aytwektwTmsxelhUajlWRnM5bkxUREpYZDBPYzIyaXRxTHhrMHpPaHNQbndv?=
 =?utf-8?B?UUFTdkFtMC9oemllRWxxeTIzaWdJSUxSTUp2UHZ3R1gxUFU2Rktod3BYUVJm?=
 =?utf-8?B?UWs5eFdHUytMVHRHOS9lT3ZFNW1ZVnI3Y3VPb1k0bXMyNmYzU1JORU0ya1VQ?=
 =?utf-8?B?Q3BTYzVUTlJkaW1xbHJ6UE9QQ2ZRanZ3N2V0M0JNRk5HQkx3QWhIaDBEeXhj?=
 =?utf-8?B?UnhzZkQ2bUNNa0YwQjhzcC9SN3lIcmVJbFBMOHVKSXpGdENOZU9UdEFtMVRO?=
 =?utf-8?B?dDUwby9jOTlmV0Ixbnl1NXdQc2VTNjd6VGF5RUtFYmNqa0puWngvdENjR01S?=
 =?utf-8?B?eHE1eURwaWtTVnlXS1pMdXZjclVVWEozV0xjQWlhaG9kZWJiMnZpRURzTmM3?=
 =?utf-8?B?WGVpZ29ZZG5SeE9DS0lwSnRlNllOR3ZxeldJNWo4SlkyZFVOTTVya0tYbHpK?=
 =?utf-8?B?L3h3K2RXZ1doaWRaZGp2Ris3T1d2SWkrZ1RPc0M5SDc5bXR1ZmE5a3dxQ3lM?=
 =?utf-8?B?T21nbk9BZUtUN0pPWUpZVXNrK1ZOQkFRQ3J1K3d1RUVYK0ZJcnJjMU5od3p1?=
 =?utf-8?B?ODJMNzFwMm1TL2hrNGxSVk8vbHd4ZENPZXpHWS9xTXE3U0xWNXVBU2RtUlN2?=
 =?utf-8?B?b1dhcWEyc25nVFlUNnZrbW9NTEJIQWlON3phMzQyTlNRU0VvOHVMcTd0a2ZV?=
 =?utf-8?B?WEl6RTJmK3F0QXExVS85bWJrRE1yQnF3SDdzc0czWEl2SnJvVFpiR1ZpRU5a?=
 =?utf-8?B?Y0Uwd3hKMEM3b1Y3aGcwWUpJV3g5RDVHZGtVV2ZBM2RBL0ZOdEVyOEJXblZh?=
 =?utf-8?B?bE11NU4xZDJUcjRpZGsxSlUwK0dlZ0xmTjVWSTNFZUZxektoMk9xbDNZaDhC?=
 =?utf-8?B?NWJVTDkzbWd3UDVNRjF4V3huWXNQeTVXcll1U2UzM29QT2R0TE54akhYa3g4?=
 =?utf-8?B?YjU3Z2VoWWVxYzMwLzJzSXRRbWdtZGNvck8xS25odWwvVi9WcXlPc0FyRU1M?=
 =?utf-8?B?YThpdjNwdnVCcmwwbGdHay8rMTJuM01BU1hOMHBLdi9Yd1pTYWNYNFd2ZXBp?=
 =?utf-8?B?VDVSQ0NlbHpoN0FGak5VZUllUjJPc3pFOU83aEExZkIvNU51eU5TWXcxeFRj?=
 =?utf-8?B?NFU3ZG5jY0ZublQvWmhUYXFNeHFPR24vV0JicVNQam5XNkcwdzc1QUZub3l5?=
 =?utf-8?B?Yk9aUFlEV1BoL21wbFZoaW9XclIyeEFlOWNaVkZHanZ6ZldVT3VKd1lkSjV3?=
 =?utf-8?B?azJ6Rjk5aDF3ZHRPc0xzZXdwMjlOU3VET084TDhVenB4em4wQmkvR3M5VC9Z?=
 =?utf-8?B?dTZIcjF1WXFUVlU1R1VhcUswOVgzdDlwbDAzaEpEZkQvTlpmS1JuWEdaMlpD?=
 =?utf-8?B?WlhPN0R4cmU5a0xKc055cENEUEIzOTNXUUx5UHp3SGFkY2xUandqZURUdURk?=
 =?utf-8?B?MnFBaWZZaE1lYXE0dmF5SnQ5dDMreVRnN2JzeEVBeVBYWXI3VDkzVVVMOEV6?=
 =?utf-8?B?Y3BoRTNtYmkrMmNxbDJYN2dvTFNRcjlrWW9na0VmYTJLVFJTZEdraksrQUNC?=
 =?utf-8?B?L1BKUU5SemtESXAyOFQ5QytGWXZSb1BRTEJnV3ZPemx6TC9XWWRUNTNqQXpa?=
 =?utf-8?B?U1FYc1NOdGxQZzMzc0c4aUU2UmRCUVhud3RSYlFXWnFhSHc2aWtuY0dweXNQ?=
 =?utf-8?B?MUpJM0grQTFQYXp1QzdHWlEvN2E2OUkxUERKd3MwYlVOdm1YQkU2dzVFSWVv?=
 =?utf-8?Q?Xdvlt8?=
X-Forefront-Antispam-Report: 
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(14060799003)(35042699022)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 16:50:08.2268
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7138618-4e99-4f88-01e1-08dd84193c9f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM4PEPF00027A5D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10385
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 25 Apr 2025 16:50:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17578

T24gMjUgSmFuIDIwMjUsIGF0IDEyOjI3LCBMaXZpdXMgdmlhIGxpc3RzLm9wZW5lbWJlZGRlZC5v
cmcgPGVneXN6ZXJlZ3k9ZnJlZW1haWwuaHVAbGlzdHMub3BlbmVtYmVkZGVkLm9yZz4gd3JvdGU6
DQo+IA0KPiBGcm9tOiBCZW5qYW1pbiBTesWRa2UgPGVneXN6ZXJlZ3lAZnJlZW1haWwuaHU+DQo+
IA0KPiAtIEFkZCBzZWxmLl9mZF9jb25zb2xlIHRvIHVzZSBmb3Igc2VsZi5faGFuZGxlX3Jlc2l6
ZSgpIGluIFByb2dyZXNzQmFyKCkgY2xhc3MNCj4gLSBPcHRpbWl6ZSBwcmludGluZyBpbiBmb290
ZXIgdXBkYXRlIHdpdGggdXNlIGEgU3RyaW5nSU8gYnVmZmVyLg0KPiAtIFVzZSA0MCBIeiByZWZy
ZXNoIHJhdGUgKEZQUykgZm9yIGZvb3RlciB1cGRhdGUuDQo+IC0gQ2xlYW5pbmcgYW5kIHJlZmFj
dG9yaW5nIHByaW50cyBpbiBjb2RlLCBwcmludCgpIGZ1bmN0aW9ucyB3ZXJlIGVsaW1pbmF0ZWQg
ZnJvbSBhbGwgbG9vcHMgZm9yIGJldHRlciBwZXJmb3JtYW5jZS4NCg0KVGhlc2Ugc2VlbSBsaWtl
IHNlbnNpYmxlIG9wdGltaXNhdGlvbnMsIGJ1dCBob3cgYXJlIHlvdSB0ZXN0aW5nIHRoZW0gYW5k
IHdoYXQgc29ydCBvZiBpbXByb3ZlbWVudHMgZG8geW91IHNlZT8NCg0KSSBqdXN0IGRpZCBhIG1v
ZGVyYXRlbHkgbGFyZ2UgYnVpbGQsIHdpcGVkIHRtcCwgYW5kIHJlYnVpbHQgaXQ6IHRoaXMgcmVz
dWx0cyBpbiAxMUsgdGFza3MgdGhhdCBhcmUgZW50aXJlbHkgZnJvbSBzc3RhdGUgYW5kIHdpdGgg
bWFzdGVyIHRoaXMgdGFrZXMgbXkgYnVpbGRlciAyOjA4cy4gICBJZiBJIGFwcGx5IHlvdXIgcGF0
Y2hlcywgd2hpY2ggSSB3b3VsZCBleHBlY3QgdG8gaGVscCB0aGUgbmVhci1wYXRob2xvZ2ljYWwg
Y2FzZSBvZiAxMUsgc2hvcnQtbGl2ZWQgdGFza3MsIGl0IHRha2VzIDI6MDdzLg0KDQpSb3Nz

