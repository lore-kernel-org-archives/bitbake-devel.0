Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA358C83F09
	for <webhook@archiver.kernel.org>; Tue,  8 Jul 2025 15:31:44 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.37])
 by mx.groups.io with SMTP id smtpd.web10.21746.1751988702226760959
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 08 Jul 2025 08:31:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=DAr4Ul66;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=DAr4Ul66;
 spf=pass (domain: arm.com, ip: 52.101.69.37, mailfrom: ross.burton@arm.com)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=PV2zCnnBEl/Vv+HQfb2N/5RJZR1KjK6QTkQGctY9FflXSnKpkvDLA5vXkDHJZh7/zYsJkDJRpK6bGR9uVw5amC/LQ9nnIS2Kuw78rSzk7ISiLS0mlqo0kYiSWp2uCI8SgFnRwRXo8BVetGi8P7lKV1EhWdu0Lcn5xAQ9zVYSakX0TDZ+GgRFdET9uvWiiIYyCEMrnfoWnxnhp34QJkivgYJUhluqLO3+l2pnUm3jvrSZxdSn6r9yrCtZg/nioMPTVOsjM32bhFHDAzufbsE5nOlWOk93SFYhikuHLjwYQE4MXGIr5b2vufdDpWMFW9m2ga8LWKIZZVy8lH7Nw0dsOA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QB1wZ4smpwb5DB4IXO3JyZwxugyWT4HZiuKfzEGbHdI=;
 b=ULL4AVMjitU2WoAFJ4wKxokJOpiIfL/sbiLhcoUy8Q36nde6PXF1NmYEYmZpQAJwGaNkvA66BW4Xf9tqfrz6QHrIfe1RQrv5xhZ4795dkfLpAHX/00RLsOWLvgWiybysVmO40vnmH6I7ojjusiS6N8tXO7jhyO4PBi2qDcTNRrg5gNI0JSgj/2sg22a/PhWT0BBsijVbBdb9doiOEh16WkZaGYYX3QHXjN6lIkzGb8bZambAmaIHzaCbq7upPcN+iLM/DO0odIkLic+rdVvtLqvhefTHEEl4LBTSE0/2gQ4dBkjgIYPrdqCj+moUPjwuKi9PZAk03I9038vcT5iD/Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QB1wZ4smpwb5DB4IXO3JyZwxugyWT4HZiuKfzEGbHdI=;
 b=DAr4Ul66mavHTTP9grDkMZZO37ez9YIJy5m2IaCklcFPBFDkuw0NDhB6rm9Nk6COLNFWV3OSMIeEYQao5pEjpJC1ylwRWALp5KKwkF7+MK85UjusbGmjlB+BfMNqVyoUBlDKSlYpToclOtEJ9S/CMy//9f/NaeX7ZkpsOz4o0e4=
Received: from DB7PR02CA0008.eurprd02.prod.outlook.com (2603:10a6:10:52::21)
 by DB9PR08MB6458.eurprd08.prod.outlook.com (2603:10a6:10:258::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 15:31:37 +0000
Received: from DU2PEPF0001E9C4.eurprd03.prod.outlook.com
 (2603:10a6:10:52:cafe::9a) by DB7PR02CA0008.outlook.office365.com
 (2603:10a6:10:52::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Tue,
 8 Jul 2025 15:31:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF0001E9C4.mail.protection.outlook.com (10.167.8.73) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15 via
 Frontend Transport; Tue, 8 Jul 2025 15:31:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n7H6vI5F51N+YUyQoOcfLq7naQK6/LuiZwpGEmNYvXQ2ReFrE4BsbGvLz3oYy5TBgy748e0QxbV/sijFFCt7TBzPerunHuZW5uy0iGnMH13eRVXJugOojMjXlkntrgUHOFsLiay0Mil7Ur3W39cm/W+V/ixn4e3JEh8AWoXwXs7anAsQClu9uhWFPrzQxNl8DfNRmfAoJF9I5jmdoZ8J9MQmS5oLnv6ni/OK63KmhiFjlxzNT9cmyGAt0bScM4BNyRrdVSD6evPXzz/VVDraLFDJpA/xudGyNTkp18TszSIfVkBs/Vhe3Ov5IezVpwzhOVdfWqfTb9kA2q2QxQlz8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QB1wZ4smpwb5DB4IXO3JyZwxugyWT4HZiuKfzEGbHdI=;
 b=WG0a+rF3FUkUIYsKEg/BPaGAwAUTXOtYma+1nE3rYx5bZgPbfWvAAVllZim17FWLS2V4r9NEA05xLSVZw7ukZ1MnqxAAgk0ceLOQvpaKfya5Tnwrxf3sNU5BK2oi+h5gouhYPaR/i7mAo7MVPjPgepNdFxtizo4cqlcKn15NquIDaKlcw1wzBvDhGAuFAgPmqeCzgEZFbrYWAbAhptP80yO8SGocQ7BdMyVJkgIrFweVwy8Hm/OPfvpf4xKWSd4bAy7WUxI3pmP2hRaBw73o46Rcsu46He6GJcatz8S+vr5/RZORWcpXOq0N7IB89giy0+Lr/g2xHCJ62huclxNZCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QB1wZ4smpwb5DB4IXO3JyZwxugyWT4HZiuKfzEGbHdI=;
 b=DAr4Ul66mavHTTP9grDkMZZO37ez9YIJy5m2IaCklcFPBFDkuw0NDhB6rm9Nk6COLNFWV3OSMIeEYQao5pEjpJC1ylwRWALp5KKwkF7+MK85UjusbGmjlB+BfMNqVyoUBlDKSlYpToclOtEJ9S/CMy//9f/NaeX7ZkpsOz4o0e4=
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com (2603:10a6:102:2a3::12)
 by GV1PR08MB10750.eurprd08.prod.outlook.com (2603:10a6:150:165::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Tue, 8 Jul
 2025 15:31:01 +0000
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::9206:40ba:ef7e:729e]) by PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::9206:40ba:ef7e:729e%5]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 15:31:01 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: "sider123456789101112131415@gmail.com"
	<sider123456789101112131415@gmail.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, "gavrilov.andrew1999@yandex.ru"
	<gavrilov.andrew1999@yandex.ru>, "tinyakovx@gmail.com" <tinyakovx@gmail.com>,
	"denisova.olga.k@yandex.ru" <denisova.olga.k@yandex.ru>
Subject: Re: [bitbake-devel] [PATCH] Speeding up Checking sstate mirror object
 availability : Add async filtering SSTATE_MIRRORS
Thread-Topic: [bitbake-devel] [PATCH] Speeding up Checking sstate mirror
 object availability : Add async filtering SSTATE_MIRRORS
Thread-Index: AQHbvolQ7duD9XSNPk6lKZ3VrGD2H7Py+KnZgDXE1QA=
Date: Tue, 8 Jul 2025 15:31:01 +0000
Message-ID: <7CA9FAED-58BA-4995-B022-1E537779FF2A@arm.com>
References: <20250506131751.93175-1-sider123456789101112131415@gmail.com>
 <183CF2ED7AD8242A.22941@lists.openembedded.org>
 <CAGCYn1QOFvB=KOUHv9TrxeSRo3LCr-Li7O5LoGOv=_oc9_3S+w@mail.gmail.com>
In-Reply-To: 
 <CAGCYn1QOFvB=KOUHv9TrxeSRo3LCr-Li7O5LoGOv=_oc9_3S+w@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3826.600.51.1.1)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	PA4PR08MB7411:EE_|GV1PR08MB10750:EE_|DU2PEPF0001E9C4:EE_|DB9PR08MB6458:EE_
X-MS-Office365-Filtering-Correlation-Id: 213193ab-cc3f-48de-4d40-08ddbe3486f1
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
X-Microsoft-Antispam-Message-Info-Original: 
 =?utf-8?B?UkFRZnNUZTZHVjFTdmVFMVNXTXUybnluMFNxTFZsM05tMDJCU1VQc0s5T0Qy?=
 =?utf-8?B?WjBNcDh2NlBSa2d4OVoxU2p4RHhHVkFrd1pScGYza3A2TC8yUVhLWEpRSDNq?=
 =?utf-8?B?SEJ1bEtEREdVS2V5cUZGOWJIVDQzWlNyTTYxQjM4dm80R0JEdHY4NDFqSmdM?=
 =?utf-8?B?eVNvMW03V0FhaTBKUHk0SVJ1VnNOSVJ4MVhpRmhmNmZnRUhRQ1pNbVJSREJa?=
 =?utf-8?B?WktpQW5qbVBLQVcwVWlpM3hEZStZS0lOWmcydUxjcFJieS9KbGc1dlB6Skdu?=
 =?utf-8?B?SkRCS1pRSlI3ZHJidGlYVGNyaEVPV3g2M2h3MGNzNGtxUVlkUWVPR1FnU3dW?=
 =?utf-8?B?cStEVXZiYU1Jb3NBZXNSWmcwNkxRWWFEdlgrYXk3eFZXZ3FQTTBoeXQ5WFJX?=
 =?utf-8?B?aUdCbjhMU1B5aXVjM2VIZk8yWXVKUjV5S0pDREpmdVdUZEMwaWlEVkVvbEpQ?=
 =?utf-8?B?K2hMZDhyL2tpZHlzTUlvOE5YNGlMbzAwTG5jY1VTYUowSnNvc0RZTmhzL1lB?=
 =?utf-8?B?VVZIQWVHYTlMUENxcVVvTlA3SVFqalYyZjNKZnp5VGhoWUVCRHA2dU5yck9k?=
 =?utf-8?B?VDlONXcvSEZFUnVLbXAyR1p1WC9Qbll2S0tVR3ptb29Ya3VwNHhtZXRpZFdE?=
 =?utf-8?B?MEhaWjBlb1BocEhpS0g0SHQzZEhkU2ZKZEV6NEJvZG9CbFZZTDdtS1JwSWhB?=
 =?utf-8?B?L05YRWgyTmxiNG1Qcy8wclFSUklnaDhNcURiWDVPY2NZK0VZZm14MEhZUjQy?=
 =?utf-8?B?VktQOW0zdEFpRmJnaU5Va0hMQk1RaDU2SmxoUnFTVDZmUnFrZW8zOW1oZGdN?=
 =?utf-8?B?SG8wbFVsZ1BoeW5qSHIrWkdiK3BpYngzN2M1Rk91NjdGemNDV0lRejlSckRw?=
 =?utf-8?B?bnMvbmJVenQ3ZWJEclVUb1ZHeDdQM0lTdHhtWFdzbTlQSzQ4SERvRVN1M1V2?=
 =?utf-8?B?ekZvQjVpQWxWd1BET1EvdnhTWGF0Q0tFbGdiNlU0VUVmS3Y1dldGYjRkbGI4?=
 =?utf-8?B?RmpzTDNzTE00VkJaRFhqZjRhTnVCVEJ3Ump6VHordG1NckVZWjR4UFZ1cHdw?=
 =?utf-8?B?SGVIRmwvY1RLRE9vUkQrdy9nVUViU1UvZ0VBb3lhc3ROeldOc0tubGt2Q1c2?=
 =?utf-8?B?V3l1dDVoVHpXMFZ0QXoxT1hvWmRySWM0dm00MnFsQ3FaeUlHeW8zT0JrZm8w?=
 =?utf-8?B?SHdETVlPN2xxb3NFcDdxZDJHQ21SWUI2bUVMbFJBaHBnOXNMN0o4eUFqSHlW?=
 =?utf-8?B?a3VqZXhhbUpuQmk5aVpDcmxGNzN2NUpybjBWa2VKZTNJQkN4SlBJOWFjSGIw?=
 =?utf-8?B?SU1XdlNHdkEzMzVkdHdjdjNFT3U1MGp3bmpDK0hGcnJ2YlhlWjlQTVBvY25m?=
 =?utf-8?B?YjdxU29DS3lNM1hSOFhJeWZWTmt1alZjaXZRUVdBYnh0OGFzU055c1hPVFhP?=
 =?utf-8?B?U3VjTW5MRGhZSzFEM1o5RHkyUGpBVmpzVUFqQWlSYVpheER3VVJDNmxhZEpT?=
 =?utf-8?B?MVV2V2xjNlZXMkZDQVdkRXoxZWtGdmV1YnpRWGRRMWQ3M0lJSUR0YkxBQ3Jx?=
 =?utf-8?B?S01MTzNDVWdVTFlkOUxUT20rSGgxNHJnNmlaTlhxUzg5WDVGeGxTNFlaRDBj?=
 =?utf-8?B?Y3J3ODhxbHBXN1Y3eUVJdnpSSmF1M0xoQ3oyenMzRmZmSjF2d3k5S25IdFQ0?=
 =?utf-8?B?S3FaSHNlOURnbi9DZWc2cHVhTWYwOWx4bzRsN2dEUWE2Z2JNVk5vMThnSHFY?=
 =?utf-8?B?Y3QrTDhvV2pWOU5MWmRla2xIM2NEZGZheHEvOEQ2MXg0R201M2lERWpnWkEr?=
 =?utf-8?B?akJaNGJRTEpkRjJpSkJJREZIa3gzWHdqdElZR3ZqTEszVldyR2VVTVFlYjJl?=
 =?utf-8?B?V3pBRGFNaWVHUU80b0RGcjN3Z2tRNVdtd0pGd0dsOTRwWkFGaHVtTjV6RS9S?=
 =?utf-8?B?Z1RrSXVWY3ZYL0FCcmg3dlJkNW1PckNjNjVROE1SejFxeHJHSE1jK1pyeEJv?=
 =?utf-8?B?Qkd0TDMyOHZBPT0=?=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR08MB7411.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA991C84B53CFA489862AD45561CA1FA@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10750
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 DU2PEPF0001E9C4.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	f016db87-779d-44d5-16f4-08ddbe3471b1
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700013|14060799003|376014|35042699022|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NnVSUXBKc0ZzbCtQNGJxclZOd1RmVUdvSXNBdzNrWGtSaXdBUkdqY2I4T05M?=
 =?utf-8?B?ZmtjdmJpUUlKZEJ4bzdhcjhjWm1JLy82Y2dyNERiSk81eXpvb1hscDhSSkRy?=
 =?utf-8?B?YzhUbUxPLzBWZU1WQzlQWU9mSGcwaDVJVUhOQVpSL2xhbWIxNjczdEt1RFBq?=
 =?utf-8?B?aFZVcnh5VXMxRDdZaDNoT1RkUWVqQ0tQUTFJTXptUHBVN2hIOXQxSS9xMjhq?=
 =?utf-8?B?blB6SEhOUnp2ZVRBQ2Y2Tmgrb1AzVFJRcUlpaElFb2t5aElEeEF3Sk1CS05v?=
 =?utf-8?B?TnM5eENMUGVTUGJMR01DVGJBeWVXWGlaVTlya1BzUXRQYjhxNmN6N3VjWFFX?=
 =?utf-8?B?TC9nM3YxazBXQURPckJ3aU5PamQzUWZWT1Q0WklIWnFIb24rZ2VUNWgyMHkw?=
 =?utf-8?B?eWNvSEhQalFBUVBYU29FZFU3OUJZZDlQdlFDOVh2SWtSYXM0N2NUYmR5MkV0?=
 =?utf-8?B?RS9qZ2VZZUZYc25mRFMwTER6NUo3ZEFVNTR0MEZVc2JEZ0lIeXBveHVUNTJW?=
 =?utf-8?B?OGY1cWRsZGxSd3BISWRWUFcvVzErNXpOSXdiYmJxb3JjTFdyTWdsOWNubHht?=
 =?utf-8?B?VFpKYkNGb1RLUzBTUktOSjJVRVdabkpGSVE5aEdhWWprdmVtZS9MRjV1Y0NV?=
 =?utf-8?B?eVppNTA0L3lhbElFMW5xRjRlR21YWlpSTjBvdnRPNURqU2Z6eitiamlQUjdI?=
 =?utf-8?B?b3FUZkZHSndmQ2hWNGJGeTltTWNRT1hZU0E1VkFBTTVFamh3cU9mUFJWcEMr?=
 =?utf-8?B?a2pZS3o0bHNTQzdvc1ppdzRkUmprQUJKUElBN0VkMW9SeVFrOSt2cXoxS0tJ?=
 =?utf-8?B?dGRZei90bU9IbUhSV0lpS05WcnVHQ3NFZHd3M1p2UXhEOFhVa3FIblpraGRS?=
 =?utf-8?B?QnV5SmVGV3BKcDBOeDBFNnZ2MS9DVmV2dHRzUVUrNDNlQzdvcWZLWlI3c2Fk?=
 =?utf-8?B?a1o5bnVMUkFySE5rMVptSmZ6MDVGK3JWeHB3dGtBWDRpMVljS0Rna0cvYTBS?=
 =?utf-8?B?WGNyYjNQckxFM3V2MzlMbTlGUTQ4MnZJRUM1dEJDeVFzRWlFa1Y1M0dzeEtU?=
 =?utf-8?B?VXlZNk10WFkyWjJ2NEFZakQ2VHNoVVZ5ZG5TanRwYko2OUp0Tm5GcEc1VGYr?=
 =?utf-8?B?SXdiV3ZsbnJPclJ3di8wa013NUlUQ3hHcjRIYlY4R2RpWmRiN2hzVkRyNUV4?=
 =?utf-8?B?VVB3b2JxMktyUEVFeUtqMmw4TStuUGdCV2ZCN3dWVkpZL1M2djFZUTNBMm51?=
 =?utf-8?B?a2xTcU1aazRXaDVvV0M5U1NPODNaQkh6ODRaY0Rva2VEYXB3YWJEQVFiTzNG?=
 =?utf-8?B?MGI0YlVPakZSUDJDRTcxNjg0Tk11UXFNcVN4dXg5SDh5cDFQSUZiMnhNcmh2?=
 =?utf-8?B?bFFtT3gvZVhoaUtpUW9KbEcwWWVHeFNxNDcxd1lnTnNrWlZGTkZ4b1NTa1pr?=
 =?utf-8?B?eUs4WmlEd0VrMXlMZTJTSEVPNko3aHJWMHd1TS9xRm9UZHVwSWF2VXAzV2FJ?=
 =?utf-8?B?MFlYdmpDNjh4cGdDQXNXNHBybmJJWngvblJsbDhReWNmTnhTSkdZa3hFZlgv?=
 =?utf-8?B?ZHF3RUYvSDdBZ3ptbkltZDZ4dE5MbHBMc0FockFpdkVRMis3a3RYV2ExSHgr?=
 =?utf-8?B?YmFnMlhFenUvWVhyT1RpTUtaQlNwdzNtSUpvQWtwUzdMUzFNOGxLN1ZKYXZS?=
 =?utf-8?B?MTVzREJNalBGOUVwN1dSWUxPekZXRFdMbThtTkNTdjVVZzVjak91YmNXci9J?=
 =?utf-8?B?SUZWdldVY25oTWtLL0dDbDFQS2hJVzBEOUxZUExuTGU3MVlNd1h2VWhCTW4w?=
 =?utf-8?B?SEk3Q2Y0VU1BY0owQ2xMemQ1amo1MmMzb2RIVnBYZHFhMnJ1TTc2L2VlMnp2?=
 =?utf-8?B?dmVwaDFNV1JxdTRHTHZmMTR2S1l3MGYvQ3FjcGt0Z1JDNkZHbUpZb0x0MVNZ?=
 =?utf-8?B?R1lCTDRUTWZnMmtHa1d0U0IrZUoxUjRLL24xK1dNWkNOV3JvWlk3eDByRi9B?=
 =?utf-8?B?Mmk5bHFmdmVWNXpsMkxETlM2bi9vWFFvNUVVRTRvQ3VEc3VYSG5GLzJiZUZ3?=
 =?utf-8?Q?EXYy/l?=
X-Forefront-Antispam-Report: 
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(14060799003)(376014)(35042699022)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 15:31:36.7032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 213193ab-cc3f-48de-4d40-08ddbe3486f1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DU2PEPF0001E9C4.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6458
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 08 Jul 2025 15:31:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17762

T24gNCBKdW4gMjAyNSwgYXQgMTE6MjQsINCa0L7QvdGB0YLQsNC90YLQuNC9IHZpYSBsaXN0cy5v
cGVuZW1iZWRkZWQub3JnIDxzaWRlcjEyMzQ1Njc4OTEwMTExMjEzMTQxNT1nbWFpbC5jb21AbGlz
dHMub3BlbmVtYmVkZGVkLm9yZz4gd3JvdGU6DQo+IA0KPiBHb29kIGFmdGVybm9vbiEgDQo+IFJh
aXNpbmcgdGhlIGRpc2N1c3Npb24gYWJvdmUgYmVjYXVzZSBJIGRpZG4ndCBnZXQgYSByZXNwb25z
ZSB0byBhIHByZXZpb3VzIGVtYWlsLiBMZXQgbWUga25vdyBpZiB5b3UgYXJlIHN0aWxsIGNvbnNp
ZGVyaW5nIHRoZSBwYXRjaCBvciBuZWVkIHRvIGNoYW5nZSBhbnl0aGluZyBhYm91dCBpdC4NCg0K
SeKAmW0gbm90IHRoZSBiaXRiYWtlIG1haW50YWluZXIsIGJ1dCB0aGlzIGZlZWxzIGxpa2UgYSBs
b3Qgb2YgZXh0cmEgY29tcGxleGl0eSB0byB3b3JrIGFyb3VuZCB5b3VyIG9kZCBuZXR3b3JraW5n
IGVudmlyb25tZW50Lg0KDQpJ4oCZZCBzYXkgZG9u4oCZdCBwdXQgdW5yZWFjaGFibGUgSVBzIGlu
IHlvdXIgc3N0YXRlIG1pcnJvciBsaXN0Lg0KDQpSb3Nz

