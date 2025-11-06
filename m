Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23584CCFA03
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 13:18:48 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.21])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15261.1762435123952547415
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Nov 2025 05:18:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=TbDEYolr;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=TbDEYolr;
 spf=pass (domain: arm.com, ip: 40.107.130.21, mailfrom: ross.burton@arm.com)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=OCBWX+g62h4t5dJK4Ew3XUqwevxjB+UQkSeXzG3ciwPH7y7qpYeF4uF1bMlkl1sztKRb8R36tpFZRgTARrcwiM7K5E13C7tDcL5zb0uyq9eJV6eY8ZyY3Hv/FZWtcqImVgq93/I+zoiv9UcaSC5aY/LtpwRQKnGHQI0GCm+6J1/ywSXzlciZaFWbH/Qiu2zXOWCDceW2750FZgR4iClT95w4ie07G6Ths4MKu/AGhHkzlxhRCXIQQfQDRIz5wSmqhmRvIolcy5gPxZ+P0Jy0R/docdDkXGYpUVS25MxEdJgY4EuiB5FqNJlQ5PxmgYyJok3ILDnfBB+Yg0OpEdoKOw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oo+3AG9UXmlYhPOGMasluAbTqni+cTDKaHtQiUodEvQ=;
 b=KmKN9nNV6VY34o9JViQhkHyG6ftc1WXcVGojzVy07o6+oHl/ZM1J2HH1uLuDtnvUKj7ZJrL3ImrNmL3UB/WfD0lW+YCiXkjmMHRwYaSle4T6h32kv6lmiuwkmXEl0Eq0V6zhpkX+j1Py5VB0d/e/LSrjOKcHJRaaZygG78wxBULUqKS1DbcivcBdzt/2G0gK1gp1hy9pJVKU22KZWhBkeIbitsFZ5ojhLnChGg/WuIL5udBCDoZWVTP0mksTRPvwxhnraUwPenwL0XEVADvcbDdV309Eipf4G1LhtHfzQjjjI7wfnR/AXXdMpkEEmoV1IETvjDiLE4QVw+3rhics+g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oo+3AG9UXmlYhPOGMasluAbTqni+cTDKaHtQiUodEvQ=;
 b=TbDEYolrhfza7LTrjDVggBci7AZFBTJEZowpREbsn0f5FtKVqHWz2lgHUGvtRd/2akdESdq4w8MK+yBAFY2yG0/Ap2lB7RmY51YWJMZY39db0YFsfhExwwom658eQGo4mVqaWTQTAUyDL5m9Qk+KyqwlOF5QJDTc+tdg1LwW/0c=
Received: from AS4P190CA0049.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:656::20)
 by GV2PR08MB11348.eurprd08.prod.outlook.com (2603:10a6:150:2a6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Thu, 6 Nov
 2025 13:18:40 +0000
Received: from AM2PEPF0001C716.eurprd05.prod.outlook.com
 (2603:10a6:20b:656:cafe::5c) by AS4P190CA0049.outlook.office365.com
 (2603:10a6:20b:656::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Thu,
 6 Nov 2025 13:18:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM2PEPF0001C716.mail.protection.outlook.com (10.167.16.186) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.6
 via Frontend Transport; Thu, 6 Nov 2025 13:18:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=faBYg3yYLVqlcMOp0I7vkeogeunYjnBmP8XTj45jNKqi5uwPwH+jzJGi1MFNcTx6daNZisLhO/CEPj65avlagopZjhc/G/JJakMRNgSUgqul366gEq5XmiKqnLM6vr0XPqgsCvzNCktrl8JIlhK11Wldp/DTqzol7+2w64Iit1dQsOVL70X/BSYil2GC3jZnWzT8Ba4M/CWNH01mvxwOHVPL06JXG6zWvUk9VSFcKpfzrPcLZOPAcWqZRNqrs5+RneTqREZNJCok8aCVu3DJOIQzoFc34XnFrlVNQlEnOSj/rwj/AmBdzzg2AvXgTie7cFmrM1sOBEb800RQavkXmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oo+3AG9UXmlYhPOGMasluAbTqni+cTDKaHtQiUodEvQ=;
 b=IXqoM82P6+CGZbcLDj1OQ2Dub4N1dkcbABzXNKNRnYlL5LQnj/OehJCjmeWCtxmnUgVt1j8klvkCC12PA615tnXTB7qUt6xTyjbN/qbrOnJrGlt37/Cvv+uVnNmq+vrlSq5hwAk3GRNc1ozwA9xlHDWF4h5AzLM/l13IE3JV69eQci7EhUOGJAeqx2jTRZKl1UmPHJkQsHXYTGpSBssFy91kVsyusJ0V3UfkB26hJoKqjYMqYZow5YRJ7Ci8aixwHk+Nb87VHFM3GWruJ2Wn2RvZOofL/EXnm/r/Gp5+j3S3ocA6XWTYsqtcjbgeMBxWCFeBiTuvYsipsb8aIAx9uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oo+3AG9UXmlYhPOGMasluAbTqni+cTDKaHtQiUodEvQ=;
 b=TbDEYolrhfza7LTrjDVggBci7AZFBTJEZowpREbsn0f5FtKVqHWz2lgHUGvtRd/2akdESdq4w8MK+yBAFY2yG0/Ap2lB7RmY51YWJMZY39db0YFsfhExwwom658eQGo4mVqaWTQTAUyDL5m9Qk+KyqwlOF5QJDTc+tdg1LwW/0c=
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com (2603:10a6:102:2a3::12)
 by DU0PR08MB8346.eurprd08.prod.outlook.com (2603:10a6:10:40a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Thu, 6 Nov
 2025 13:18:04 +0000
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::7f73:806a:3493:7d50]) by PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::7f73:806a:3493:7d50%4]) with mapi id 15.20.9275.015; Thu, 6 Nov 2025
 13:18:02 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: "bhstalel@gmail.com" <bhstalel@gmail.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel][PATCH] lib/bb/data_smart: add removeFromVar
 method
Thread-Topic: [bitbake-devel][PATCH] lib/bb/data_smart: add removeFromVar
 method
Thread-Index: AQHcOUWbakdkpMo8TkilkAsEDh1UN7TlzPcA
Date: Thu, 6 Nov 2025 13:18:02 +0000
Message-ID: <BC551E3C-97AA-4962-A325-50630AF76ABD@arm.com>
References: <20251009175300.7480-1-bhstalel@gmail.com>
In-Reply-To: <20251009175300.7480-1-bhstalel@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3826.700.81)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	PA4PR08MB7411:EE_|DU0PR08MB8346:EE_|AM2PEPF0001C716:EE_|GV2PR08MB11348:EE_
X-MS-Office365-Filtering-Correlation-Id: de4269b8-1d79-4622-1a37-08de1d36ff48
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
X-Microsoft-Antispam-Message-Info-Original: 
 =?utf-8?B?Tk9YK2tUN2xIUER5TGFtMU4wTWtqQzNvb1NlUTVQZk5rM3pFOWZQKytxaU1z?=
 =?utf-8?B?WnVDbjBrc0d0dVFxZjlKMmFXaWdFRGNJVERYYVhKQlNwcjBsaXpnMjNXVDhX?=
 =?utf-8?B?a3Bya0NFWEkvaVdzV1RZTkVVcThJd0ltNzIwZExqQmYzQmRFTmJoOXhKQjdF?=
 =?utf-8?B?akIvai9jOVF0ZHlnRmRhSXlrMzV0S2VSN0I3VHh3TkNvaTFsdW8rYkN0eC9s?=
 =?utf-8?B?SWlCVmVvWmVueGFUUC9ub0Rmd0ZzSDBqSlBNZ2hyMHhZL2JYWm1KbW84dU0v?=
 =?utf-8?B?T0FRN2hzVitxWUtGODhxTnEvb3RKRU51dEk4ZVAyc29rRStzZy9QdU9naWVw?=
 =?utf-8?B?ZG80c0pXQkpJUG9RSGE4YUdIRWpWZXhzbW5LUE51TzUwbndRanY4eWdrM1M0?=
 =?utf-8?B?ODBFTGEremhEeDk1b3p6T0VWVFVBMEt6WWR6MUMrT2MwcTZrZmZCMkEzMU5u?=
 =?utf-8?B?WWI5OGZiSFBFWU9Ka3BHalJFeVhpUTkxeWcrOHV1UHpTbWw2OTVORE0vQWtk?=
 =?utf-8?B?K3lNckdsR0JuWVRESXBRcW1xUmFIK05ITnFYQWtlckh1SnU1VlJCYWFITXF2?=
 =?utf-8?B?d1NmQlE0Q2w3WU5rMkxHOWNpM2tQVC82czJvU1NNakNIOTM4MWRxdjh6eHJ1?=
 =?utf-8?B?bUNxd2Zqd0JWY2hGNmJOemI3Tit1ZS9ZemoxblVzKzVtWElxOWdIQ0FONk5Q?=
 =?utf-8?B?WHBtaGpVVVpPR0l6QmdiaS9JUUlkbXFDVndTRlF6Y0R2TzNTQ3BMeUlIZ0gy?=
 =?utf-8?B?Tld0SW16NWIxM1NGeVQvZzhXSng3NmpobGdWdG9VUjJ6TGZ2dkEydVJYYkpT?=
 =?utf-8?B?aExCKzZmbG9oNGtBTDd3bjJ6bmQ0SDBIbWRheHhYdmNnTFhHMjFFRmpJdEhn?=
 =?utf-8?B?NmtqLzEyUTFsRDIrYUdyaXJBUTRXTmdoWDBLYWM4ZzVuMFZYeldPdzFZdE4y?=
 =?utf-8?B?Y2UweVhYZU5aR3dYUnpGRDZJd1pyV29yY0o3RmtXZllmR2E2eFMzaGVRWDFL?=
 =?utf-8?B?QytpRkViNkRTSkhxRG82UzFrdmo5NG5yTDlkZHN4eXBzdXFJdHdMdmRiakhr?=
 =?utf-8?B?UEd5OExQZFdzT2xrUGUzbEZPalVrdzlDT1JGYytDWVQ1K1BUQW1mWDBHK3JC?=
 =?utf-8?B?cTZteE9ZKzQ3cFo4VVEyb0Q4KzA2U3lwTklReVZvd211cm5WRGUyYzhnK1Iz?=
 =?utf-8?B?RlhXTVpldVRSNVhkUUZwWXZxVFd3OG5DRkNWWUwram9QWGN1b3hzQjdQY2xp?=
 =?utf-8?B?Z1AxZkNDMXVRRlVPZjJMeENwd3lNenJFNlpaWGVBNUFES2c2aDVJMUNzSTky?=
 =?utf-8?B?UlE5NE56UTFIb0lRNmxzVnRIY2tLSmlwdEdUYjhybFRyT3Z0RzJrcmF0N3Y0?=
 =?utf-8?B?NkFEMWZLZWppeXN6b3A5eDkxU0dTeUpVaG1iSkFKb0NMajk5QlVKM2sxSjho?=
 =?utf-8?B?VmpoWFBsVkwwK0FyVHdLdXF0b1haamxxdmZYalVnNVptZlRwQ2R3MUhndVpO?=
 =?utf-8?B?T2ttUHZEN2E3SUNLK29VVnZlZXBwOUJzTUNUTTVpZ2c4dGg1RDVZb0tSaUVk?=
 =?utf-8?B?dVFSUGt4VG4xYlB0Q29yZHhBSytGNWdoVGRkNUhVaFMzbVg2Z25xUzN5eXhs?=
 =?utf-8?B?ZG0zS1I2UU1OMnZYVEVFeFl2S1ArT2dLeWk0VGN0RzFkN2c0MzRSalZkZWVv?=
 =?utf-8?B?WVlFaVdMLzRzais4MG5pbUZSTmlPckxDOXZrT3RqUFVvajVPeGlYeGtNenRw?=
 =?utf-8?B?cExkZ1J1MXFOekIzckcvdGdmZUhNU1NQRWRVSGczd2RiTEpCejA3MTBDU0pB?=
 =?utf-8?B?RVFuU0diVTAzT1ZRaTU3ZzZubDdRQ1VJcFY5cDZ3dW5sallSRW9rY3pWdnNS?=
 =?utf-8?B?NmN4SEw1TVBsZm5BZk9FNGV1alJTZGNVajJ5OTZLME4rcFhtdEZXcmJ3Z0Yr?=
 =?utf-8?B?QkhkakVPRDVHclZybCt2dndUaCs5d3Z2N0lRUXZ1UzZVSkhnUHAxZmRpTlhh?=
 =?utf-8?B?ZnhKOGJHWStLMldHZU9BOE1wSHZMSXlObitObnpUZmJ4UGd4UWxOaEVaL3Uz?=
 =?utf-8?Q?vMRpao?=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR08MB7411.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <757E561CA5FB9C4F9CE386621B820B26@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8346
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 AM2PEPF0001C716.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	b3d718a9-eb00-4219-e8cb-08de1d36ea41
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|35042699022|82310400026|36860700013|14060799003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cXpTRTNBbVp1dDAzcDJ5MU4vVDdqbmNKMXNFTmMxUGd3Yk9aQmJEU3ZHUzAr?=
 =?utf-8?B?YzBMbU9GRWt2Z1NIalJ1SGVjS0FIYWtJYVZKZkRNbWNXUExFcmRCZHFQenM1?=
 =?utf-8?B?UExxVDVTQ1FFT2R5ZFNxdnZYUDVvZnl0S2JuSTFLNHl6SlBybmNSUXZKOWpU?=
 =?utf-8?B?TTZndm9NRVZMT3dJV0dFK1dmWk0zeUdyb1cxSFJDVkJHd0ZjZzRKb3U3Zy9B?=
 =?utf-8?B?Nk5yd2V2SWU4bG5tZDVRUTJOZEwwZ0F4ZmoxWXpDTnBoOGdlczhFV3JvRnFK?=
 =?utf-8?B?cDhCWFRMeWdBUkN0ZFVaVjl2bzBmK0hkNW12TmNlS3JMdnlEL1ZUeDNRMU9S?=
 =?utf-8?B?QWVOVUhTVzhXaWJoL3N2WTBCRGRaZVE1V2R4OEtaWDFnRU03am5GWjNPcmx4?=
 =?utf-8?B?Vnh2S2VLZ21FWkF5VVhDeHRaZnl1NytLSXd5NTl0NVdVOXoxOGtNZzErZ1Vl?=
 =?utf-8?B?UjR6aHVGd05VWHF1Q3RTenowUkg2TURRd0VvVTNuQkxPbGc4YUdPODhGUm0x?=
 =?utf-8?B?SmVOcjlaZmhMbGxpcW0rTzh2bG95a0lZMmNtcjY0TVMwc2taVUVjYWJ1Tzlp?=
 =?utf-8?B?WkdQTlJSVTN0TnM4YXNpTlNONkhweEcyTk55MnBqb3BFYURMWmVLYnJiKys3?=
 =?utf-8?B?MDlzUHpyQ2tlRXM1U1NaaitPZmp1aGpCcWlNWklRQWtwTEd3MFBJWXNOeTMr?=
 =?utf-8?B?VkJnSnJCdTk5Z1Fpd0FveFNHSklRd1ZRMGFRSWxDYlBFbzZWVjRBdnAzb0Vn?=
 =?utf-8?B?TlVlak5mVG9LeHcwdythMVExWkl1NUlFNFlZOGwwTjRnMGlKQ3krREkrQUQ1?=
 =?utf-8?B?NHVIZ0psZUdEaXlMZEpnUTRNUUMxajRPTmN0UVcreVpiMUdhTEVZTG1xWFlF?=
 =?utf-8?B?RVpnTFE3cHEyU0JuMkprM3JyTFliQnZGSENuZjkreWx3OGFyUHVoMWpVYWQx?=
 =?utf-8?B?TFBad3lRNzJqaXZHR05PMTBFVVppbzBMK1BsUFRYdEJ6TS85YVJuTCtSdnND?=
 =?utf-8?B?anhsRWx6R0xXa0lWZ1AyZHJlcjQ1cFlUdC8rMWhsVlBlU1FmSjZ1L3pRU0dL?=
 =?utf-8?B?ZFF6RGZTOWFVOG5MbHNzejV5Y3ZJRUhlWUFxUnpZYUx1aHFrYXpFKzNtZFFj?=
 =?utf-8?B?SDBwM3R6L3labjNiYTErVjZTUmZOMmhLWUFrNEZhMU1oMGFyOHVkUTQrdzVy?=
 =?utf-8?B?dittU0JidVVMRlB6UGJxdEV0REFtVkwzUmQ4bm02QVVJK05sMXF3cldIUUpK?=
 =?utf-8?B?VjlRMnVKelJGUGdrQm1RL0VTWUVTOEc3c2Jsb3d0UHB0dm1pd2NMSG5uMzNu?=
 =?utf-8?B?WUtaWUVwU2VqQlprYytSL2Zjdkg5WXoyaFU0ejU0Ukd4UW9KYmZ3a1RJakwr?=
 =?utf-8?B?Z1ZIOHpyYVVkdk5QNWh6VGMxaEZqWVV5QWFUMFZIVEw5b1NMUU5hOXczNlU3?=
 =?utf-8?B?U3lhNHlIUktlL1dFOVNKUDhaRjJaQm0rdFVuNnl0UmJsWnlUOFBDWnJmN0NM?=
 =?utf-8?B?WkxOWU9JeTFrbmdmV1JSZFZoNklIZHJlZm1jWHc0NllPVStXVldwYXZZVlVT?=
 =?utf-8?B?S2U1QXMxck5rY2d4SW9aZGdjVTJBQzJsZW5mb3U0aUZEdVhMK0JxeDRQMkY3?=
 =?utf-8?B?Ym8wYjRuN1A0SlVYSGg3ZDZqTDFSbkFLNFJtR1BobE56YS9RLzZuczQ4b0hs?=
 =?utf-8?B?ZS9rcVpYZmQzWjZ4MTkydjZCbjNqNmVydTdGT3YzeCtqek83bm43TkMxSWRO?=
 =?utf-8?B?N0dLdnVnUFBhWmVaVEthMzhOaURLM05mdm9PcDRDckRralVINTBTaGxUMkd0?=
 =?utf-8?B?SmtIQ3FhQmZEMnN5T290enUwU1ErNDAxWlJ5TWpBb2dCNTJKcmhiSEZiajNN?=
 =?utf-8?B?NTJwcUdUam0weWxvTldxU20yUjJHa0JNaUViSHRNaGMvcW5UNEMvNE1pVi9q?=
 =?utf-8?B?Ym9jVDdoYnJXZlV3Zk1kcUw5dkR0TUxkZGp0aW0yNFcyQitCaGZoRlQ0TnN1?=
 =?utf-8?B?TGRCbTY5NUR0Wk0wNnVwRFc4WU9mdG1lQ1FvT2FIYUJFd2FnQVl3T0tZK0Zr?=
 =?utf-8?B?TkhkTVVxU3Rac05JSTM0Vld6ZU9GRDNucENSZVMySmZSejdML2hnNytUOFE4?=
 =?utf-8?Q?VA+Y=3D?=
X-Forefront-Antispam-Report: 
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(35042699022)(82310400026)(36860700013)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 13:18:38.1208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de4269b8-1d79-4622-1a37-08de1d36ff48
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM2PEPF0001C716.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11348
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Nov 2025 13:18:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18289

T24gOSBPY3QgMjAyNSwgYXQgMTg6NTMsIEJFTEhBREogU0FMRU0gVGFsZWwgdmlhIGxpc3RzLm9w
ZW5lbWJlZGRlZC5vcmcgPGJoc3RhbGVsPWdtYWlsLmNvbUBsaXN0cy5vcGVuZW1iZWRkZWQub3Jn
PiB3cm90ZToNCj4gDQo+IFRlc3RlZCB3aXRoOg0KPiANCj4gTVlfVkFSSUFCTEUgPSAiZm9vIGhl
bGxvIGZvbyB3b3JsZCINCj4gcHl0aG9uICgpIHsNCj4gICAgZC5yZW1vdmVGcm9tVmFyKCdNWV9W
QVJJQUJMRScsICdmb28nKQ0KPiB9DQo+IA0KPiAkIGJpdGJha2UtZ2V0dmFyIC1yIGV4YW1wbGUg
LS12YWx1ZSBNWV9WQVJJQUJMRQ0KPiBoZWxsbyAgd29ybGQNCg0KSeKAmW0gY3VyaW91cyB3aGF0
IHRoZSB1c2UgY2FzZSBmb3IgdGhpczogaWYgeW914oCZcmUgcHJvZ3JhbW1hdGljYWxseSBtYW5p
cHVsYXRpbmcgdGhlIGRhdGEgc3RvcmUgY2FuIHlvdSBub3QganVzdCBtYWtlIHRoZSBkZXNpcmVk
IGNoYW5nZXMgZGlyZWN0bHksIGluc3RlYWQgb2YgYWRkaW5nIGFub3RoZXIgb3BlcmF0b3Igd2hp
Y2ggaGFzIHRvIGJlIGV2YWx1YXRlZCBhbmQgaGFzIGEgcGVyZm9ybWFuY2UgaGl0Pw0KDQpSb3Nz

