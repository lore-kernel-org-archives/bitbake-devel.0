Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F369BC83F26
	for <webhook@archiver.kernel.org>; Tue, 29 Jul 2025 15:18:42 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.56])
 by mx.groups.io with SMTP id smtpd.web11.10397.1753802312621656857
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Jul 2025 08:18:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=e2nappdn;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=e2nappdn;
 spf=pass (domain: arm.com, ip: 52.101.69.56, mailfrom: ross.burton@arm.com)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=r46AP1Wb3+Z03AjBEjUUoQBtEoBBZMC9Yq7u76+WkaQ1xTmfrSKGl0fuVF/zoYJ7UR98VLYY81WiRjraCyNNrsJmWeexdz1k7siwwubg++FQ282jnOzYXCfuQrcADblqxBObyZoVI0uZP+VBvubKrFSX8DEYJEgSPfaRaHL0U/3BbCOvOPNGTtqTldePlXzIT0pR+25J7USxNthRhMuw/hnOGsdWv+60cVlgjqt84xoTdy5NvG5Rp9AeVbkMA27Hg0pTqkhBoBMNj7ccVWGpGzwxy6h31ISqXWOA9Dwgq15aC5wqocgUfOvK0bdtVkAAvAhjrlpJgf7XACqRkmmr7Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHFJBmLo9pun1FR6+syUVQaCcXQOaI882dg9Vzsrb9Y=;
 b=ApqBVCTulx8/g4uKny7AVE+0kwx0+6HWTekYl8I1LVy9Tg30pFP5wvnx9uYxnjPPpTtQXVCmB/eR3HL4l4oMa0vab+lcV4YJ5AOQXXmCCmkQD5p2rGF+CRuojonjfCD824u97ybTqcnp0/8Eb4j8dWktqojkuDJhvhbQtkt1sxAhzbnHYQ2HwPqtLqLkjbyHxyCNArQ6xR2NFGR69yiOCAtFyh18WClSy3+B4laDwsxQjdERyClnSw7ZPGPkQBrX1qNBSsdkPyuR7LjnDSKlCEXuPTkz52h+RG2fRV1kFnwQl30nkVLqCMEogEa37uN8+z8AYUtQUik4L9xteuXiNA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=agilent.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHFJBmLo9pun1FR6+syUVQaCcXQOaI882dg9Vzsrb9Y=;
 b=e2nappdnnbC9CYbRczwjrvaRMIX8aFoY1qT4GcupKZMXwzwLnWrIQKL5kr5PlmfV8LtARphmP+SwSwabXfuVemUutFAWVGXePq9iML2E0rNVODwMbyA389cbnhoXYeSrMuXbNxZlMZXN4oSdl5Pdh+jPQf+JxFDRTW7tObEE3IM=
Received: from AM0PR04CA0053.eurprd04.prod.outlook.com (2603:10a6:208:1::30)
 by DU0PR08MB9004.eurprd08.prod.outlook.com (2603:10a6:10:47a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 15:18:25 +0000
Received: from AM3PEPF0000A78F.eurprd04.prod.outlook.com
 (2603:10a6:208:1:cafe::ab) by AM0PR04CA0053.outlook.office365.com
 (2603:10a6:208:1::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Tue,
 29 Jul 2025 15:18:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF0000A78F.mail.protection.outlook.com (10.167.16.118) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.10
 via Frontend Transport; Tue, 29 Jul 2025 15:18:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gawH6THkh0ElUQAJddgNPAgZ71HsoAb00+jWPu09lc0Uupy6ZsIYXpYQ7LeBDaR10XCivRMDUPvJjL6Gzh0qciBpWGrs6CjabMZxVSJ3waTAsMBSYhaomTvkpsn8y0kqtzQ/wa3toZ3GzIWWbEVirp2KcETN5rtVL06F9qd5KGGbZYVooW+sVdRZsJnfHK9XlOeQpe53+D9ih54t+PDAwMFCMCvWAa3YKmonC0K7QahD8H3Ruie5y0kB4irSOVDaVJ+3kJ9DRo7sj++iQ+q8mFLFQ8ei85KYE2udtvgF88Z/BWJfwz9xpJjRqZj3vussi9sG63p/E4o+l4R1sm/WTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHFJBmLo9pun1FR6+syUVQaCcXQOaI882dg9Vzsrb9Y=;
 b=lkZVTl0Zy1xfssgkKKzilM3rSW4+meceP0yFhY4IrtdOux6xTVKh56p2ebVWnVMlfFdZbWIm6WwzsfiszNlm/D0ujdPKHwcdxnpqt159rWUMD5/XElsd2kDjw8SvthnEKH3oNNcHa0YRKS+Zu8fE8WMiKBrshpVm4ZYIY7nkIUcYvHr4sQzqsTLUX8TLBGPPlNpN8yJBokVqRC5Z8fcYaDzMuLNL7gUe3s/W1FabKS+kJMkmRCRoJKP++6Z9odD8ji8lXHm5hLEPTQaE23HRajU6HZ5z0CQaygHi9z6pP+w1gzS01JFoBxVAebAhcxZ7KqaLVhOCJs289tmOlgg1gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHFJBmLo9pun1FR6+syUVQaCcXQOaI882dg9Vzsrb9Y=;
 b=e2nappdnnbC9CYbRczwjrvaRMIX8aFoY1qT4GcupKZMXwzwLnWrIQKL5kr5PlmfV8LtARphmP+SwSwabXfuVemUutFAWVGXePq9iML2E0rNVODwMbyA389cbnhoXYeSrMuXbNxZlMZXN4oSdl5Pdh+jPQf+JxFDRTW7tObEE3IM=
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com (2603:10a6:102:2a3::12)
 by AS8PR08MB7909.eurprd08.prod.outlook.com (2603:10a6:20b:52a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Tue, 29 Jul
 2025 15:17:53 +0000
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::9206:40ba:ef7e:729e]) by PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::9206:40ba:ef7e:729e%5]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 15:17:53 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH 1/2] utils: Optimise signal/sigmask
 performance
Thread-Topic: [bitbake-devel] [PATCH 1/2] utils: Optimise signal/sigmask
 performance
Thread-Index: AQHb9+uElrH2TMZqp0qTgpM25VTMU7RHyggAgAEv/gCAACkQAIAAJO4A
Date: Tue, 29 Jul 2025 15:17:52 +0000
Message-ID: <0E1F39B1-9889-4965-8825-DC21020716F8@arm.com>
References: <20250718135437.247096-1-richard.purdie@linuxfoundation.org>
 <DM8PR12MB543065BB1FD2642696C540D88B5AA@DM8PR12MB5430.namprd12.prod.outlook.com>
 <ACE5DB76-ABC9-4C30-A44D-E60D0C672013@arm.com>
 <DM8PR12MB5430F71427C0117F87CA20358B25A@DM8PR12MB5430.namprd12.prod.outlook.com>
In-Reply-To: 
 <DM8PR12MB5430F71427C0117F87CA20358B25A@DM8PR12MB5430.namprd12.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3826.600.51.1.1)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	PA4PR08MB7411:EE_|AS8PR08MB7909:EE_|AM3PEPF0000A78F:EE_|DU0PR08MB9004:EE_
X-MS-Office365-Filtering-Correlation-Id: adf72d70-d365-4b55-5df8-08ddceb329e9
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
X-Microsoft-Antispam-Message-Info-Original: 
 =?utf-8?B?dnRIbWxqekgxYlJGaytqTStuUXIrS0ZycitEbXU4ZW40bWtOT05mbFRSTEdz?=
 =?utf-8?B?dWJCVjVNU0RtM0tORnNDZVIvQjloZ2x6TUpGSzBjQmtBRjFQNEh6NVMrRWph?=
 =?utf-8?B?QjRHSDhPM1RsSXZIcnBVNnIxSFMxZXFDWitwMVFmVi9vVVFWZFdxMXJUZEhY?=
 =?utf-8?B?S0ZGZnJZS1A1eUpXVVNnbkk5bVh6UXJPOGRFOU5OdG9xelpYanNMNEZ4Rjdz?=
 =?utf-8?B?SDRyVzYwa05Pd0xOeDE0OXBZbnJCNm9EYklldE9JZU82cEg4d3Q2SkN0TlUw?=
 =?utf-8?B?YkxINTFzejVZMEZIa25CcDBHZ3hNVmdQc3ZOV0h4MDd3eDFPOWw0WGFJSFJR?=
 =?utf-8?B?M25iYkIzS0xBUGFXcisxOEVWbEhnQk96KzFDOEN0eXp3c2orbVlzZ2dBaUpr?=
 =?utf-8?B?VU5HT0tRQU0zZzlJYmtVVDRtNVNydVNwK1hpWFVFVC8rMzZueUVKMG05ejhm?=
 =?utf-8?B?QThSaDNISi9qL0d5U1JZdklxRXFvNmt1ODVGOW15aldqOEpMUEhwbTQ1aXNz?=
 =?utf-8?B?Tm1yMHArWUd6cWZYT3hRUkNtY0dwWFhQR0hiNTdoTE52OVIyOWREOWJtalpi?=
 =?utf-8?B?L3kzU25ENms5OUcrVlRwbmpmalhJQkkvZXlZeml1c3oyRkRvWXZRSGhSbEtB?=
 =?utf-8?B?VEJlRVZJMUxvRGE0Zmc2UGNldWVoclZXKzJUaTg1NkpSV2JwaUNIR2JNVDFn?=
 =?utf-8?B?T05OMGY4MTB4QVNHWWluRkcxTStwcVk2QjVpRTIvTHFSaTZRa09xQTVTd095?=
 =?utf-8?B?bFZpaTl1NURMeEtlYVFHWHJLTk9jYUhqNFEvSGJCTzdBczYrL0c2aHVCYVoz?=
 =?utf-8?B?bE5PbkVHZ09rZWUxOENxY0RMN3JvcVF0bkJHTEZUc1RJZkRsSzhoaStiNFVv?=
 =?utf-8?B?S05iZFJ3aTJJb01OMWFjK3dzUmRnSFVzR3NFaXVCdFdORlBKdDhvc0tOTks0?=
 =?utf-8?B?ZXdSSC96QmlwbDVCUzJYWG41akFoYi9zOTFmc25rcUxpdDFHcFg2SHpHSTM5?=
 =?utf-8?B?RjJYZStaSEZtbXdhVm5HOXFTN1VJNkFDbkdEZFZoTU14emorTHRBTWNsR1o3?=
 =?utf-8?B?L3VVVHE1dktaQkxMUGV3SmkxSExOM1ZJTDBseXlWUUlPMER3aUxQTDZPQWZi?=
 =?utf-8?B?RUZndGRwbm9YcHBlVlNWd3lIcmRLbENlTXp6UzMyclp5Y0pFWGszZ2hrK3dK?=
 =?utf-8?B?MnpTQmUvWTVVQWF0M2EyVE1jZ1JLcUhBSmpycXJuMHdoK3JlTEoxQkd1QVNH?=
 =?utf-8?B?UUhsdGt5eUozVWF3OVIvRi9QZlBIQUE0RkR4MFJ0ZWRaaXZvZE1vaG9Wb3dm?=
 =?utf-8?B?L0kwaVlubmNtNE9Ba01MT0tNNnBwNFNUNjJ5UE9Ea0Z1NzVWSUpIKzV5N1Rs?=
 =?utf-8?B?L0NRVlVaek5oZUpLQjNYaGorQ1BPbWxWYlpsdXhYdXEyK1VsaFFPa01GZm83?=
 =?utf-8?B?WGlmc1V2T2YrTlMreTMxbytpc1JQNWFZN1ExQzRYSWtxUDk1cjFBYjJoVnIx?=
 =?utf-8?B?QkpOL0FKeWxEMk9ncnFCU2k0SjR3dVlqc3MxNkFMdCtvdWlrSEx2ZEJlOEl0?=
 =?utf-8?B?a2E2WUVYSWVZbW1zZzNBQVRVb0srRVpuZmp2R3N6ZnV0K0oxSFkvTHIrR2FK?=
 =?utf-8?B?bU8rcFZRaUlBZ2krRHJZaklnZWVpb2EyVmxpNVNtckpZMWlkQXBBVTdvdVRX?=
 =?utf-8?B?V1RHNCtRVjZkVCtDMXkyVnZmRk5adUhOUkw3R3J4Und6WDNadUJPc2tRelNy?=
 =?utf-8?B?RlQzV2QvWW83UFBCQVBMVEMrMmZsbGxsZFRjdXdBcnArVHhLcVBMQ3VDZTkr?=
 =?utf-8?B?LzJLRk9JSW1sdk1WVXR0Y0lCNkh5R1FXa0pwZXpqOFY2U05Rajh3M1RXQ0tT?=
 =?utf-8?B?VEVUQ29OU3VMdTdpMVdGWTZTRHh2QVdMbTd1eHZwM09kOXNuVmxHVUE5ZitY?=
 =?utf-8?B?T3dxQ21NaVJ3dFQ0K1grYXl6QTZTa0tmc1d1MW52U3BtRUd6OW1OaVVUREJE?=
 =?utf-8?B?NVc0R0FRUFRnPT0=?=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR08MB7411.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD86516013FD38439BFD2414909FE349@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7909
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 AM3PEPF0000A78F.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	5cafe61b-597c-42d0-5e72-08ddceb31697
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700013|14060799003|376014|35042699022|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RVJ0V0p2TXVta2tMM0ZLaW9Tb3cxYWFiYmNvMUtZQ2FtNjJMRUNOTmNXbGEw?=
 =?utf-8?B?QUNvQ25KL3Y2YnFNamxnbVZWelh5MUswVU9ycVBwelZ5ZkZaK2RrNmNGY3o0?=
 =?utf-8?B?TjBaRmlyWWdCMCt4SWxtcDhEajBoMklJNG5oK0U2K3p3QU9rV1lVMzlvY01n?=
 =?utf-8?B?UytGb256Um9IQldYb3NTZVlKeXlvNmcySi9Wc240WFhVa1dmTVJUOWRtQm9F?=
 =?utf-8?B?eWxSSjVpMU5tWkhEWGc1bjNYeGZjYTFKMW1wTSttU3h3dk4wM3ZUeDEwaVBT?=
 =?utf-8?B?WEZVVExTT2pTTDh6MUZHSUxJRGNGa2JQeWQvT2dYaTBSVTFITEFIblVJNUhC?=
 =?utf-8?B?VmpaVXY0MFh4dkswcDR0TFY1TDZ3OHVsaHM4UlZXb0U2Z2xCNVdlbDk2aWhs?=
 =?utf-8?B?aXlIaU1pWjMxNzNVUmlydTBSNmFDZzg2ZE1CWEE1Z2t2amJVNERuK1E0SEQ3?=
 =?utf-8?B?UW1GWEtLQVdwZjVLUTMwakpKVUVoQWNsbkVQbXNFUHM3N3lCcWJINE9zd3k5?=
 =?utf-8?B?RC9XNldzZnQrQUI3dzRDSzlSeXhNdWJhTVlSK1o0cTJwck5FNS9hVWd4YXk4?=
 =?utf-8?B?SHlTcWd6d1ppT1dFQ0l4c0VjOTNVQnFhNDVkck90cGRpRm9EWjVKdzRXVzFp?=
 =?utf-8?B?MDR0SndtamZEL3NuM0d4NFRKL1JsdG92VVBZd0kyR05lUDF1NWJEdGJqS3Ri?=
 =?utf-8?B?UXltWlBsWlE0SzJtWlZBbkhoRnZkZ1ZxT01CYTNGeFRZSms2S3ljNVo5M1R4?=
 =?utf-8?B?ZXE2dno5UmJVV0JKS2I2R1hoWS9sZ21lNlhsV1E3QmZNakNmdnRGZUR0QzlW?=
 =?utf-8?B?OUJQNlk4TEdpQWdiaGNPZHJHdFd2cFFqSVdXRytxZms0bFhEQnhUTDZMR1pG?=
 =?utf-8?B?Ym9EVEhBZ1Rsc213T3lXV0JjT0YxVlY1WVJJeFBKTFBPQXUydWtobERtSXNX?=
 =?utf-8?B?UU9sNHBCM3FldW5yNzVZRU84eTJCa1loQzJxUTYvVDNQdDZtQkpqYmcvcFl4?=
 =?utf-8?B?YUZLQ2RVVXZrTUgxY0ZWK0EvRHRqZVNHdmY5SnZvMjBFN0grMG4zREF6cHFk?=
 =?utf-8?B?RGVzTGdLbDFUSDBoZ1p4TmZyZnR2bUtwWXQvSGpXUkhDaXVaYUszVEpsaGo4?=
 =?utf-8?B?bDZReTRkNEx3UERBam95Y1o3RFJTMUdYdGQ5WUdqREwrd0xCYVhmSjZaNFBN?=
 =?utf-8?B?eE04em9yTmhWKytpb0F2cTlXVDFZOHVZaEI0T2tBNkF2NzRPdmpzbHN3Zi9S?=
 =?utf-8?B?MTlkVlI1RUQzNG5DV1pwdDF3MGpmdlNDUHJScVo5VjFvWkhpSU45c0ppanh5?=
 =?utf-8?B?U3BFUHNZZFgvNi91MnNoQk9WR1lCbFRwbVNHWnJoS0tIK1N4SDJocDNKaGtB?=
 =?utf-8?B?cnFEWFo1VXlPV1hwTy95emJZVHg1c3hkWGpyRnMyUkxNT0tvQXQzWE9DK29z?=
 =?utf-8?B?Q3BJZXVaRVdJN2xVdG9TbzVPeThzZ1JyaUxzWFV0QzJ4dUlTTHBSLzkzc0F3?=
 =?utf-8?B?V0QzcjcyaENBNmtMM2R4dzBoc3VaOFZxTGFJdHBmaUllRWw5akM4S2hyVDRj?=
 =?utf-8?B?b1VEWmdBY1l6amNMWWhOUXBxZENLV1E4Z2kyNjk0aDdQRk1GTGtHZDl6YUl3?=
 =?utf-8?B?N21aRldzelBPQy9FS0wxT3FldEZoelNmWWZqN0Z5a2hYWm5lYjRocXA4Ky90?=
 =?utf-8?B?Ny9IQTkwQWZnTUt3YUxjQ0laOGRJSUZXMkpzRGpORisrbWNBamZ5OTZic2Nn?=
 =?utf-8?B?ZWtEL0pLWmNiMVkxL2QzTkxqTk8vengzUS9aSkthNnB4NEtMK2JuT0NhV0Yy?=
 =?utf-8?B?cXkvK1JENjRjVC9ZRGd5c0JyNkl1c2poWXVreHhZRjVXQkZvdWlhZTFEQmhr?=
 =?utf-8?B?UnBydm5hQzIzWnI4WnF3ZW5iSml0Ym9pOUlFVDJTTzF5b3RFNTRlQVc4OWc0?=
 =?utf-8?B?eUtXbVdqRmR5NmVPc2ZzajhJUWk2dGF0TmR2Q282U2FSQUF0Tm91anR1cjdw?=
 =?utf-8?B?QU55UmpTRHY1bm4yN3Q4cXFIVTI0NXJnenMzOS9XYWg1MHFIQUVRdlVERlhi?=
 =?utf-8?Q?f8Ro0g?=
X-Forefront-Antispam-Report: 
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(14060799003)(376014)(35042699022)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 15:18:25.3637
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adf72d70-d365-4b55-5df8-08ddceb329e9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM3PEPF0000A78F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9004
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 29 Jul 2025 15:18:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17822

T24gMjkgSnVsIDIwMjUsIGF0IDE0OjA1LCBDaHJpcyBMYXBsYW50ZSB2aWEgbGlzdHMub3BlbmVt
YmVkZGVkLm9yZyA8Y2hyaXMubGFwbGFudGU9YWdpbGVudC5jb21AbGlzdHMub3BlbmVtYmVkZGVk
Lm9yZz4gd3JvdGU6DQo+IEkgaGF2ZSBuZXZlciBnb3R0ZW4gdGhlIGNvbW1hbmQtbGluZSAndml6
dHJhY2VyJyB0byB3b3JrIHdlbGwgZm9yIGJpdGJha2UuIEFzIEknbSBndWVzc2luZyB5b3UgYWxz
byBmb3VuZCwgaXQganVzdCBjYW4ndCBmb2xsb3cgd2hhdCBCaXRCYWtlIGlzIGRvaW5nIGRlc3Bp
dGUgYWxsIHRoZSBkb2N1bWVudGVkIHN1cHBvcnQgZm9yIGNvbmN1cnJlbmN5LiBIb3dldmVyLCB5
b3UgY2FuIHNvcnQtb2YgZ2V0IGl0IHRvICJzZWUgZXZlcnl0aGluZyIgYnkgbWFudWFsbHkgd3Jh
cHBpbmcgdGhlIGluZGl2aWR1YWwgcGFydHMgd2l0aCB1bmlxdWUgZmlsZSBuYW1lcywgdGhlbiBw
b3N0LXByb2Nlc3NpbmcgdG8gY29tYmluZSB0aGUgcmVzdWx0cyBpbnRvIGEgc2luZ2xlIGZpbGUu
DQoNCkkgYWRkZWQgdGhlIGNvZGUgdG8gcGFzcyB0aGUgc3RhdGUgdG8gdGhlIGJpdGFrZS13b3Jr
ZXJzIChzZWUgcG9reS1jb250cmliOnJvc3Mvdml6dHJhY2VyLCBhYnNvbHV0ZWx5IG5vdCBtZXJn
ZWFibGUhKSBidXQgaXQgd29u4oCZdCBmb2xsb3cgaW50byB0aGUgcGFyc2VyIHBvb2wsIEnigJlk
IG5vdCBmaWd1cmVkIG91dCB3aHkgaXQgd2FzbuKAmXQgZG9pbmcgdGhhdCB5ZXQuDQoNClJvc3M=

