Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50ED3C02198
	for <webhook@archiver.kernel.org>; Tue, 18 Feb 2025 13:21:11 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.68])
 by mx.groups.io with SMTP id smtpd.web10.19219.1739884863909502591
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 Feb 2025 05:21:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=RgHDpQVK;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=RgHDpQVK;
 spf=pass (domain: arm.com, ip: 40.107.21.68, mailfrom: ross.burton@arm.com)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Zcz1kh3PmCTZHmbM5AYutwrjj7zcO28XEmtL+fmptDpkeVZjGAiaowdmRJGsNSDtDdMdBrjng/8+RSOMkpee19fk7MSP+8o9eeLALReD5rGNpiQh6cg6r6g3mjBdHuBsKxZq1SzLO5kJmMX/DdEz4Lv+FmfX3hatoopotRMUckTJJvDB8eYrB2/GfioZl97c0VNwQYWnEV+CaNUfFtk1BdnVdGotT/xW/o6SMsEIsEZJ6WwH652ZBix2ZoYMAuonO/51NZxK/ll9JJ2d8xDaHFfL7IDM4T2MQb7lPdIlds9VTz4uZ48kNF8HZrsV6aP9JY6oE6W60lqZVO8r/IJ+mw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTioMOxExz/uzIcIPYX9lVXIKUs53/ToE3NpM5dtFxA=;
 b=jmRNLcT2ezPELLzPG23GHUsGsahmxfLSx1wkFcO80RJhALZW9JUAv8iBpDnWnzVV6JrT2kwm8DQujvuj83TLfCF1f2CX7FxJk4K8oRYZs5KNnriGuE30pNhfG1eazqIS+h/OV3Fi2eb7UHNbZpkSVpOFonWFewnc5/pxM0F4i+gaJ6HV1vwVNPQYnCMjMNDziIqlWzPzAA+Z6wZY5n8JxTKwoDkUlHNSugL77/SlXhnapmEcbhxfkARmpAQsakrNWqyrqkHMt5PiiSUw5EKDtvrS57b+tmMl9kGXxxvjy/8rQKkJ29WZ6ypFjmTLcaDSIj+AomII7iD5gP3HbAJGmw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.openembedded.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTioMOxExz/uzIcIPYX9lVXIKUs53/ToE3NpM5dtFxA=;
 b=RgHDpQVKN4QaJUKAo5XkEdwbasBraTwMbJhk80c+pg1JIGyHKv7VFfRX+P0E2QXnEAMdDmrS0gCZ+T/Oopx4CC8eiw9bMvRV6AAz+oibAujs5p4a5HtoNovmJdNBsawdNGC+cOrgAxKu9MrwOK9ARKTJ9cgqRJjl+WRw0gGfejs=
Received: from DU2PR04CA0195.eurprd04.prod.outlook.com (2603:10a6:10:28d::20)
 by AM0PR08MB5364.eurprd08.prod.outlook.com (2603:10a6:208:186::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Tue, 18 Feb
 2025 13:21:00 +0000
Received: from DU6PEPF0000A7DF.eurprd02.prod.outlook.com
 (2603:10a6:10:28d:cafe::e3) by DU2PR04CA0195.outlook.office365.com
 (2603:10a6:10:28d::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.18 via Frontend Transport; Tue,
 18 Feb 2025 13:21:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU6PEPF0000A7DF.mail.protection.outlook.com (10.167.8.36) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.11 via
 Frontend Transport; Tue, 18 Feb 2025 13:20:59 +0000
Received: ("Tessian outbound c79bb2535b53:v567"); Tue, 18 Feb 2025 13:20:58 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 83280410ed6b0c4f
X-TessianGatewayMetadata: nlGYP3m13I3dxDCWv+qop2t92lGiTSUgYG13Je3u9t0HGZD+G3B0Y1qKnijDLOyBXtz8KvzrbMT0TS0ITPhpQd/9Qu5VaS+S7e4sSwzMgNcEWpFOjD2P9txeVlvVaig0IokbuKysyikdvJa4oqw4BdFRFGDSKA/w0Z1r7C9eDok=
X-CR-MTA-TID: 64aa7808
Received: from Leb3b5f73f21b.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 7851E24F-34C0-4DDB-8191-06D65C6BCF83.1;
	Tue, 18 Feb 2025 13:20:51 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Leb3b5f73f21b.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Tue, 18 Feb 2025 13:20:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vmVdZWmNkKW08nxPdr8wmn0wYtgiwHExd9oWLbEPjMQXtgVHHquTWg+cNvaTuL0xgMc6AN2y6gqiia9GfjO9JEmRItVFE4Niiryxxtj60oQ4EARkU4eC6OwyDwzzCRbHQD2zTIdWl1NC0kBDxIBisGofLmdzHNcR7xtacsV1GQRQKUMsWoVcVovVc8NUiCzeoS3obgsZt5j+i1gP4EoFDqP/N+qKgKB+bW4YpxGEWbQs7k5faD47FM7gS3qriVVux63HjJB5DuS+QCbEngAbpEpEfEhxeCqtYfdzez3aUmHHmjDkkomGaOo9jpct6oJ3LYp/xfafD29sosJc1uuZ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTioMOxExz/uzIcIPYX9lVXIKUs53/ToE3NpM5dtFxA=;
 b=nORJstX4w8dLYJKjcetD4XaGLehdVj24fTWbvt04/HeaMtXVT1YbMIyZS7Z5D7g+8rMMBC8ICyCWEZ7A3wF82yl8pFJ/AGwZm0fKIZLfE6kIb4b7V1w5ptd4fZhu7Iedr7tkKg2mR8T5UUyY9+cZEpzUYZxK8n12llnfrJtst4bfTthBfDiKmFxPE7a+CZsRER6oZ4BppUh/5Ay0IXaQvoSOrj76d0juVeqGgunX0li+zaW0GYHVrBw7pgZHL2v8yC7HZvjYsBmt0isb3yQP+frOwExBcl5RIn85NpWc9DdhJ3ppn1Tn+BUFbjHqFPSzJ7Adhfiz2v5GpnJcVUFtvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTioMOxExz/uzIcIPYX9lVXIKUs53/ToE3NpM5dtFxA=;
 b=RgHDpQVKN4QaJUKAo5XkEdwbasBraTwMbJhk80c+pg1JIGyHKv7VFfRX+P0E2QXnEAMdDmrS0gCZ+T/Oopx4CC8eiw9bMvRV6AAz+oibAujs5p4a5HtoNovmJdNBsawdNGC+cOrgAxKu9MrwOK9ARKTJ9cgqRJjl+WRw0gGfejs=
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com (2603:10a6:102:2a3::12)
 by DB5PR08MB10115.eurprd08.prod.outlook.com (2603:10a6:10:4a2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 13:20:49 +0000
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::9206:40ba:ef7e:729e]) by PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::9206:40ba:ef7e:729e%4]) with mapi id 15.20.8445.015; Tue, 18 Feb 2025
 13:20:49 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH 2/2] knotty: report cache validity
 checking progress
Thread-Topic: [bitbake-devel] [PATCH 2/2] knotty: report cache validity
 checking progress
Thread-Index: AQHbfyVr4Jg8p/0HdEKr7JMBxK8x57NNEYOA
Date: Tue, 18 Feb 2025 13:20:49 +0000
Message-ID: <8E5BC146-29FF-418E-9B84-DD82B3076D4C@arm.com>
References: <20250214211403.493573-1-chris.laplante@agilent.com>
 <20250214211403.493573-2-chris.laplante@agilent.com>
In-Reply-To: <20250214211403.493573-2-chris.laplante@agilent.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3826.300.87.4.3)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	PA4PR08MB7411:EE_|DB5PR08MB10115:EE_|DU6PEPF0000A7DF:EE_|AM0PR08MB5364:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b0a1856-c3d0-4223-f1e8-08dd501f157d
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
X-Microsoft-Antispam-Message-Info-Original: 
 =?utf-8?B?UnpkbHI5VlB0b2lYdndnSDJKQnJmMWVpcE9OdGhWbTVaeExPdTVPV3NNUGIy?=
 =?utf-8?B?a0VZNk9jbmZNU0x5MmdYempBTEF5OHp4cDhxUVUvK09udDNhUVhYK0ltUURr?=
 =?utf-8?B?TGM4dGdoNEdjMnI5RlY5K1djMmp3c2VIRFM3VTcwUXFmcTZldEhCeG9yb2ky?=
 =?utf-8?B?M29qdGRkU1ZlNkVkRUlYbjhUTVFab0tVU1NjTjlEMk9mc3dKemFHVU5zSkMz?=
 =?utf-8?B?dmY2SjdGZlMzSUVqanhseTVJU0orR0JoTVpwdU51SDBCaWFMWXRvWkJ5d3lY?=
 =?utf-8?B?M2lZVlRMWnJFa3BiNFBvalpDeUhBZnJvb3FPM2t4bEloakNRaTdYNnFOZUNZ?=
 =?utf-8?B?ZmwrWTBVNnZwdGV5amFvQWxQN0o5cUpIZHRkMlVjYzF5dW94dmVLdkRpcVMy?=
 =?utf-8?B?VWtXK0dncTg2WHU5Q1huQnNKQTFlZk9YRHBnSWFVK0hGL1Jza0JKMnJSN01z?=
 =?utf-8?B?K0VBM3AyRlN2cU8zOWRydHFJNWRrVnVMZzJSSGo2L0tRams4WWxkYktuUGdG?=
 =?utf-8?B?OW9PSWV1eHF5b1RNVTEyZ01nRkRmVkxibGpBNUhPNVJiMTQ0Tm5UdCtyZWNv?=
 =?utf-8?B?aXhDVWxtS3dYdW9PUU9KRVM5SzBTNmd1QWF5YUxyMTl3UmVrZmxUVGNVdjg2?=
 =?utf-8?B?Q2VSWm54VTNWZzl6YmFTakhtYVExOGordk9MenZZejJSZ3FzQUlwb3gvWnNa?=
 =?utf-8?B?a2ZIblVDbWp2OC85NDNZcThiZEdyN05IejdnTjlhaFo4WGM3cUdvd3dFKzV6?=
 =?utf-8?B?UzNSa0d0bGRncGhtYWwrU1ZDcnY2QzNMRTcwWUtaai9xekVmajhNVW1zaDA4?=
 =?utf-8?B?N1QxMHZsNDhLUGdXQkxDMmJQZENSQ0ROTlV5REtjTmc3dnBDQWJaUkNWNjlI?=
 =?utf-8?B?a2xpNFhRcmVUMUJMdXBzLytad1o3SDZDNk9rdXl5YTFVNXNYbVY2R0pJUlhT?=
 =?utf-8?B?NnpLN2VoWmhIZ2VsWnMvaFFaTkZoM2dSdGpVajJoOXFjYXZjWnhsNmFaMmRH?=
 =?utf-8?B?My9UVlpiNGkwSDBmZ0VQVkVQc0ZFQkNqd29FVVF6NEpZdXlGeVJVQWtYQ3Bj?=
 =?utf-8?B?eVoyaW05Z0txa0EwbloxWDNMT3YxT3J1VEpPU2pFY2VENml5UEFJcDVLeU9W?=
 =?utf-8?B?NHdxNGJPZXBVWE5UWTZSQTAxdnp0eGV5emtCQ1N0T3lwSDZFMEttV0pPem50?=
 =?utf-8?B?UHo1RjRYK3BUY24zeFhTbWtkRGFpUUpUMC9ZemtNR25ZODR5dlRQNVg0QlZz?=
 =?utf-8?B?SndqeFhadWxqbHBGUERyVE82L01RSzk5Z1J5djFIbVVKZ0l2TjNLM2E5YlE3?=
 =?utf-8?B?dDBFL1lMNGNCbDNYaXU5STBZR2dabFdVQ1I2TWNnWk8xSmx6em9WbHd5Yjc2?=
 =?utf-8?B?cHo0TllTcWdCOFl2WTZtUVdnUEZnRGtEQnJyYm5PdzVBYWk0ZUhHTFdKRnBP?=
 =?utf-8?B?MGkzTW0zUWc4VzJ5QktUR1dmdzk2NHRDWC9LMDloc1lkUVFVRnZMYnpwa2Yy?=
 =?utf-8?B?QXh6b3JRVXlHNWdOYU5KMDFpQWdpT1IrYXd2OWt1OTIyYXFwdjFCV3pOWE9E?=
 =?utf-8?B?bjRxSFZ5RGR5eGpTbGdZNGZhQm9RNjV6dndaTEpsR3BXKzJUYW1aVmhDWGNi?=
 =?utf-8?B?RnhCK0czUE1vS2ZJZ2g3NmN6Y0s2ZnNwSnZKT25zMHF4S3ozblVUdnJuZzRz?=
 =?utf-8?B?c3NDSm1pamh6MC9FN1FrQUIxOG8wWkpJT1ZHaEx4TWpqR0I4RXVLVWNNRWdL?=
 =?utf-8?B?Ykk3bC9sZ1I4SEVoc1lJMkphdzBMZVFJb3kydWFxN21xeTlFMllQSktvNFI4?=
 =?utf-8?B?Y3dZVkc1RlIzbDVFcERUdDhEU0UxTWFsWGJ6NHRLZzJxck40WGs4d0tnRTdC?=
 =?utf-8?B?eTJsRFVPUzl6dmFyMUs3ZEI5ZExJK3ZCRlVhbjBqdi9mbjRvZ0xJWmwwMWR3?=
 =?utf-8?Q?WwMc3z49+IYI36+Q9ujRHi6D1a3s0EyR?=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR08MB7411.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <934E7B451198AF40A1DFB0D9B8A4F50B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR08MB10115
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: 
 ip=[2603:10a6:102:2a3::12];domain=PA4PR08MB7411.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 DU6PEPF0000A7DF.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	c51c3870-781e-4fb3-a6b6-08dd501f0faa
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|14060799003|376014|36860700013|35042699022|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?M3g4Q1h5TkFSc0xlSm1oUkgyYy9VSjFmd0NFQytmck1RbmU4UzRCUjNCTlh4?=
 =?utf-8?B?K2p2bk5YL0htWUZVamRydndpbGhwbC95YjEvSy9rcXNBNGFzaGd5NHpTajhP?=
 =?utf-8?B?cm9TYm1yYXJTUGJNanlJRHJpUHZDZWwzMlJzUmFRMWRZd3Qwei8waHp2VU5r?=
 =?utf-8?B?Sm9mdVlySmxGOTdGTGMrc2lNeUFvYWl2KzBXZCtSSU1YTERSdC9Tb1ViV0xY?=
 =?utf-8?B?SEh0SFdrL25TcktMTDVZdklEQlhLcHRseEZva2RRcXAvZVFwYksrS3E4RGpG?=
 =?utf-8?B?eGI4SDl2NFVZSitaTzVqMWs4aHAyODVjbHZBMUwvMnVXTTJaV0s1SUsxTUhS?=
 =?utf-8?B?dU1UVlRpZGoyTCtDenQ3aEc5RmxORTZuK3FXWG5ySzRsV0lKdjJhUXdYSDNL?=
 =?utf-8?B?K09ZazdOa0F3WWs3b21GRlpYUVZzVFhydENQaXB0ZUlUVnpodGhiMzgwUXkv?=
 =?utf-8?B?ZlBjbktUbXo2YnpFNERSMHNqb1dONHEvNWRDMXIvNDI0a1dkYlQ3L3A3VmJZ?=
 =?utf-8?B?RGNBRWI5VW5veTJxRitXYW50TE9JaEVSekRNdk5KYXVzbitiTzNtam9BZGMv?=
 =?utf-8?B?K1VIbEJvRzNEUWJnaFQ3OE8ydUhwejdjV0oyMjVoemJKUzdRamVtWXJ3ZS9n?=
 =?utf-8?B?YnlUd2wwZEtjN1ZwUnJYWUFjNnhEM25yZndwKzYxbHVUZ3VCR0VDRkFYR0dy?=
 =?utf-8?B?bjBKRXVPdnNnVDhOYnV3eWl2bWlDa05ONXA2UittMDN4dUhyUi9Oa2oxTFVu?=
 =?utf-8?B?VnJYcWYrZEZwK2pQeU5hSjkwd3pyTnhSdEpNV2tGaWJHN1NlMkJHd0xHczJ2?=
 =?utf-8?B?WmJxS2crZEV3QW40RTNMNDFoMjYyaUh6RWxQQ1N2L2p4bGRGL3NSbnpLSFc3?=
 =?utf-8?B?TnZFS2FUTVI1QjRMRTVGZWlub2VnOVl0YmpYbjFjMElQVkZCQkZKa0RTd3Vl?=
 =?utf-8?B?aHFpT0ptcDJSTlhxZ1NNTE5GaXNhZ2hTUHNxRUdkOURPQ0NYMDhLWE9Obkt6?=
 =?utf-8?B?Zzl4MnpDKzdLb1dzOUVyTGRwWFlRK0l0WEpBYU9SY2poc2sxNjFTV2FWOWU1?=
 =?utf-8?B?OENRVzFwRkNiVzRMZHBjWUUwbkVHTk4rSFJ5MkZKZXE3TWVsaWxFVGwxQW5y?=
 =?utf-8?B?a0lEQzRLdGlmOFBIZXE3aWdZV2sxdXdOd2RzaXFHSHFlaVZFYjE0cFNOdWNS?=
 =?utf-8?B?OGRHQ2JsZUNzUngwZC92MnJ0VTMwenFHNG40VkREQVNZRGZaSUxYdjJyUEhI?=
 =?utf-8?B?ZTJGdzlnS0doVjFrTG1CRE9xREZnK096ckJyU21FQm9ETndKWml6MCs0YzlX?=
 =?utf-8?B?Q3ArU09aNDN2ZnNyRVBrbStsRVR6a3RKL1V4QUtMQnRlREdRRVNNSWI0U2I1?=
 =?utf-8?B?b2Y4aUNxTEpoSVN3cFFqSkRVRXVJWGk3dko2eVRsamNkZU1MTnNVQmY5TlFt?=
 =?utf-8?B?bnoyM2lPMUlSODVIQVVsMGhWQUxrdnBEMml3ZklSTVZISkJKZGdWY3VEVGln?=
 =?utf-8?B?dXdVV0hnS09EVkErZmM0QWY2S0NiZi9zelk0UUxBeEJvRlJ3THNCOXFMbzdW?=
 =?utf-8?B?ZzlqdXhPUExiL3VuVEZydmE2YVBSWUgyY1VkOVFMWlZuYnpST3JEWW9JTmhJ?=
 =?utf-8?B?VHVuU1pUYUFjVjNEclhHZ0hTZHY0TXRleUNjYXVzUGFDOUk4eWNieE5NRkx6?=
 =?utf-8?B?SUJxK2V3ZHJBenJob3dKelUzRGJpRVBQb2dUREFLdG40eElNblo2SWVkNWhk?=
 =?utf-8?B?VUhjbGFTRnFxL2dBS3dMWnhLWFdsL3dMZTBTY09WendDM09sbk8xMGZCS3N6?=
 =?utf-8?B?WkZPS2NkVXl0SW81ck16b1lXditFeVF3S3BBMEl4OVBXRndSWDRpNnNhUE1M?=
 =?utf-8?B?ZmZLVFNXRHZCek40cE5Zc3ZuTzhLTkJOV3B6V3czR0hzcDgwMGNlRm5IdXVR?=
 =?utf-8?B?bW9ua0RhREoyVU9yVDl6TnBVempiT3hRNkc2OFFiSU5TMCtLNkJqWXlNMWNH?=
 =?utf-8?Q?U3CxQN5rlH+jdaiYjfWD2XpD+VhYkY=3D?=
X-Forefront-Antispam-Report: 
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(14060799003)(376014)(36860700013)(35042699022)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 13:20:59.1262
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b0a1856-c3d0-4223-f1e8-08dd501f157d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DU6PEPF0000A7DF.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5364
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 18 Feb 2025 13:21:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17239

T24gMTQgRmViIDIwMjUsIGF0IDIxOjE0LCBDaHJpcyBMYXBsYW50ZSB2aWEgbGlzdHMub3BlbmVt
YmVkZGVkLm9yZyA8Y2hyaXMubGFwbGFudGU9YWdpbGVudC5jb21AbGlzdHMub3BlbmVtYmVkZGVk
Lm9yZz4gd3JvdGU6DQo+ICsgICAgICAgICAgICBpZiBpc2luc3RhbmNlKGV2ZW50LCBiYi5ldmVu
dC5DaGVja0NhY2hlVmFsaWRpdHlTdGFydGVkKToNCj4gKyAgICAgICAgICAgICAgICBpZiBwYXJh
bXMub3B0aW9ucy5xdWlldCA+IDE6DQo+ICsgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlDQo+
ICsgICAgICAgICAgICAgICAgY2FjaGVwcm9ncmVzcyA9IG5ld19wcm9ncmVzcygiQ2hlY2tpbmcg
Y2FjaGUgdmFsaWRpdHkiLCBldmVudC50b3RhbCkuc3RhcnQoKQ0KPiArICAgICAgICAgICAgICAg
IGNvbnRpbnVlDQo+ICsNCj4gKyAgICAgICAgICAgIGlmIGlzaW5zdGFuY2UoZXZlbnQsIGJiLmV2
ZW50LkNoZWNrQ2FjaGVWYWxpZGl0eVByb2dyZXNzKToNCj4gKyAgICAgICAgICAgICAgICBpZiBw
YXJhbXMub3B0aW9ucy5xdWlldCA+IDE6DQo+ICsgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVl
DQo+ICsgICAgICAgICAgICAgICAgY2FjaGVwcm9ncmVzcy51cGRhdGUoZXZlbnQuY3VycmVudCkN
Cj4gKyAgICAgICAgICAgICAgICBjb250aW51ZQ0KPiArDQo+ICsgICAgICAgICAgICBpZiBpc2lu
c3RhbmNlKGV2ZW50LCBiYi5ldmVudC5DaGVja0NhY2hlVmFsaWRpdHlDb21wbGV0ZWQpOg0KPiAr
ICAgICAgICAgICAgICAgIGlmIHBhcmFtcy5vcHRpb25zLnF1aWV0ID4gMToNCj4gKyAgICAgICAg
ICAgICAgICAgICAgY29udGludWUNCj4gKyAgICAgICAgICAgICAgICBjYWNoZXByb2dyZXNzLmZp
bmlzaCgpDQo+ICsgICAgICAgICAgICAgICAgaWYgcGFyYW1zLm9wdGlvbnMucXVpZXQgPT0gMDoN
Cj4gKyAgICAgICAgICAgICAgICAgICAgcHJpbnQoZiJDaGVja2VkIHtldmVudC50b3RhbDpkfSBj
YWNoZSBlbnRyaWVzIGZvciB2YWxpZGl0eS4iKQ0KPiArICAgICAgICAgICAgICAgIGNvbnRpbnVl
DQo+ICsNCg0KTXVsdGlwbGUgcHJvZ3Jlc3MgYmFycyBhcmUgcXVpdGUgYSBzdHJvbmcgZGFyayBw
YXR0ZXJuOiBpZiB5b3UgZG9u4oCZdCBrbm93IGhvdyBtYW55IHByb2dyZXNzIGJhcnMgdGhlcmUg
YXJlIHRoZW4gdGhlcmXigJlzIG5vdGhpbmcgdG8gYmUgZ2FpbmVkIGJ5IHNlZWluZyBwcm9ncmVz
cyBiYXIgYWZ0ZXIgcHJvZ3Jlc3MgYmFyLg0KDQpQZXJzb25hbGx5IEnigJlkIHByZWZlciBpdCBp
ZiB0aGVzZSB3ZXJlIGNvbGxhcHNlZCBpbnRvIGEgc2luZ2xlIGJhciB0aGF0IGhhZCBoaWRkZW4g
aW50ZXJuYWwgZGl2aXNpb25zLiAgWWVzLCBpdCB3b3VsZCBiZSBidXJzdHksIGJ1dCBhdCBsZWFz
dCBpdCB3b3VsZCBzdGFydCBhdCAwJSBhbmQgZW5kIGF0IDEwMCUuDQoNClJvc3M=

