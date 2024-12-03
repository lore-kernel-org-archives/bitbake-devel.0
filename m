Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22FEE74AD0
	for <webhook@archiver.kernel.org>; Tue,  3 Dec 2024 20:05:16 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.76])
 by mx.groups.io with SMTP id smtpd.web11.29823.1733256307637939272
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 03 Dec 2024 12:05:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=q2YEfVpp;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=q2YEfVpp;
 spf=pass (domain: arm.com, ip: 40.107.249.76, mailfrom: ross.burton@arm.com)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=aXhN8WciZVd/5pdcDhhZqeAXT31VhLhQ8DTlLwRvEam9Q6Ouh2VSPG2RgIZn6fgFwVOoPv1uz3TMYKUGdgOtMeAkME0EclXG8HC205xPqeiyutZGEVMRr7efgGUBYLqfoc5FJj/oUW61yD6s2oLlelud0pYSlF2k1XCzCZwWrBiJUdGxbNTHsdAEsZTAtIe7Gj4AFgwkknuOowf0a7lquUJrKLJ5WY/fA5ssqHyi2KwTw0uzpd7xKLT07RQpxF7XtoHaamv4giPJq1ECwXqo9lHhbfmM1PYY8pu8IxtkEShpCs+n4noIrmvmhMW+pkbt6ty6CGTgmJ39HKhouarBCA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJFVOXPmv7Wr0uu46eu9qCbTCBM2VgsNgWB9SvnYbQI=;
 b=Td8TTwkWLvBCIL7tnBwvStqiF11sW1YD8yyPmHxPggeZtsexlcxeOuAoeqk7b4F20sm/cdpS11QUPss5zSH7HJLl4sh8kWzKzynAJdHmWwqdNcOcQncdKBUZpOTagw5I/5GsnqV942eDOAZgHYz+tj5Ih5m9Ux2j0G3rMMMCrrJDnND5cghJtRwH1iVcvbQOupjZLLYGEGgOyvE/uh396ZPCkg8RdJuce0Z2dHmWRuiunFjDe0qCqlLVEFwSGiJGgyEIA/XitNlyXBqdx0cKdw4MhL+0XiYz0DeGaFaUC3F/I7KuMmFaBeQOoNeh5uGUJjJKxcVgSWydDMPXaHYAJg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.openembedded.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJFVOXPmv7Wr0uu46eu9qCbTCBM2VgsNgWB9SvnYbQI=;
 b=q2YEfVppX92zla0vZQTDuXL47SkDbTJfAMAcuqkfFOpx/lO2Aasae5g0hz/p7gvLC++O5z8sKiHyWW2VMbZx+9uDn2t8RU1ggNDGkF2XWcORVHs8b3Xz+bBqtR0MJ4iEfNw8X39aXa4qOcLJAJOz7+LDmrNrWKOr4glPmEdIiac=
Received: from AM8P251CA0027.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:21b::32)
 by PAWPR08MB11016.eurprd08.prod.outlook.com (2603:10a6:102:46d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 20:05:03 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:20b:21b:cafe::9d) by AM8P251CA0027.outlook.office365.com
 (2603:10a6:20b:21b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Tue,
 3 Dec 2024 20:05:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.7
 via Frontend Transport; Tue, 3 Dec 2024 20:05:03 +0000
Received: ("Tessian outbound 3b1f0cd68b0e:v514"); Tue, 03 Dec 2024 20:05:02 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 225c9acee02caf15
X-TessianGatewayMetadata: N/RUS2V1GM+I0XbF/6ghW7WuY80A3l4mWPsbJAh8rnNDT4K/4tob3JdsXO16/r7nGq4ssvMynwZlubY3+6tAuYEf3bsF746Rkdsez184UzfwwVrbx56/Wb4pgVqwzVehCDU5C/rWA9aArjRbsJ82TBjwKjXQIzHpzWeHcfgcp/Y=
X-CR-MTA-TID: 64aa7808
Received: from L297f2886232a.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 896EF566-3F21-4834-AB28-A191659B1285.1;
	Tue, 03 Dec 2024 20:04:56 +0000
Received: from AM0PR83CU005.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L297f2886232a.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Tue, 03 Dec 2024 20:04:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LocQlVYTq8aXtEpE5MxKus9euHP5+/GzlyJS0a7AJPwFTBvqVmWF9oKlPVctdGctzV2RWyldRte4whqxY3ZSXo+/3KFTfePsXf4CPVGC290Qr2YttI3Qot3RhLZ2qXI/nhP/vs6bZB1SYnOWMPKqiPEkqURVDf6iggLNTbrp0/3CnVJnD8e19JNS2wX2592+ZcItM1gHNIIUNqIg9n0AGo1/QQR6Yjmj5tRm4CgyF8LtjSadnDG22+Pxz7jWKR1+/1NR2FUgunvUDG1XG5SYqFatxku6jQDwaFOWrDqJOQoxH3Ybx8jkg3hPWd39Nm0xRFUooyc9AdeYKlfEk1wv4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJFVOXPmv7Wr0uu46eu9qCbTCBM2VgsNgWB9SvnYbQI=;
 b=bjC8IensGtogGYUuE+U+cLaUU80mK5OdDzHBaCmGZnTw8GwlW62Z6GYmRpVHwvYIX4fH8QH/2jV1tF67pSLuy2oYLDAvN28EAqSQTgbXB9md4BFxlu5u5nDGhTqIzlciAODq468ljY33Bcp0wVRoxqyxtNKnQ1P046hJJpZ4qCcanlpUROcAybzw0kSpou5DnzXOpmcbEHNv8magOv76fBH0EPe46EoYNsNE5pF4nn+Vt5eYMRJNsbyThkFIASKZVlw0KYIzzr9Fd33Qf0iHZPnwlhF39i65apo3cst0n9qutxN5Fi8nDlnDkdeXM83wd+1yPT+WrXaqNaITG9p9Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJFVOXPmv7Wr0uu46eu9qCbTCBM2VgsNgWB9SvnYbQI=;
 b=q2YEfVppX92zla0vZQTDuXL47SkDbTJfAMAcuqkfFOpx/lO2Aasae5g0hz/p7gvLC++O5z8sKiHyWW2VMbZx+9uDn2t8RU1ggNDGkF2XWcORVHs8b3Xz+bBqtR0MJ4iEfNw8X39aXa4qOcLJAJOz7+LDmrNrWKOr4glPmEdIiac=
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com (2603:10a6:102:2a3::12)
 by PA6PR08MB10737.eurprd08.prod.outlook.com (2603:10a6:102:3d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.10; Tue, 3 Dec
 2024 20:04:53 +0000
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::9206:40ba:ef7e:729e]) by PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::9206:40ba:ef7e:729e%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 20:04:53 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH 2/2] fetch2/wget: URL-escape the path when
 constructing a URL for checkstatus
Thread-Topic: [bitbake-devel] [PATCH 2/2] fetch2/wget: URL-escape the path
 when constructing a URL for checkstatus
Thread-Index: AQHbRb5Z8daGss6pwUqBLwS/L51a3bLU8bKA
Date: Tue, 3 Dec 2024 20:04:53 +0000
Message-ID: <59A02537-6F80-45BA-81C5-76DBB838377D@arm.com>
References: <20241203200242.2955858-1-ross.burton@arm.com>
 <20241203200242.2955858-2-ross.burton@arm.com>
In-Reply-To: <20241203200242.2955858-2-ross.burton@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3826.200.121)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	PA4PR08MB7411:EE_|PA6PR08MB10737:EE_|AM4PEPF00027A69:EE_|PAWPR08MB11016:EE_
X-MS-Office365-Filtering-Correlation-Id: cb7a6344-eabd-416d-5bd5-08dd13d5c63e
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230040|4022899009|376014|1800799024|366016|38070700018;
X-Microsoft-Antispam-Message-Info-Original: 
 =?utf-8?B?V3luNCt4bEo1R29pdktEMWpZY3QvYTBWSG5qbENmYWQzM1Z3Um0xeFdpa0cx?=
 =?utf-8?B?ajMyT0NKSjdxL0lsSGZuaGhtaG5Qc01tWXl3WHhiTlRCS2x4WTNONFRXM1kv?=
 =?utf-8?B?UjFOd3BGT0dhY3FOR0poVmhWYzBaNHpVaFRPQTVUUkh3Ylg3emJpa1ZHdWNL?=
 =?utf-8?B?RkNZM2JlWXl6OHUzQnYySm81bkgxQnZOZ2pYUjhVUE9NYW8wbjhXNExFdmJq?=
 =?utf-8?B?WndjUXRJcitnaUI4UmErQnErd2dhZWE1MlJWNkdteHdrdTIyOFJsRzVBOUU4?=
 =?utf-8?B?UGJoWG9xdmhhbVlZeDJGMmtibTZTdUN5RmlsTXJDMXNxUi9XRDRYNk5IeTB3?=
 =?utf-8?B?VVhHcDBsOFk2YmZkaThnZVR1ZXlwM0VzaHIzc21rTmhSN0kvRVU0VXlVNkJx?=
 =?utf-8?B?bFhWakZrRkdRclllTWtoM2Zmd0d3alU4N3AyQlpZaDNMS1RUalNaY2YxaEtB?=
 =?utf-8?B?a0ZIOFNTdHovOUJpL3BPVUdZVi9JcThWSzcyS2djMk5EcUEwY0FjNlhMS0px?=
 =?utf-8?B?UHZuSitjTHBDTWlkREZoMnRoem9uQzVvS2wycnNLSXZ5U2tBbVpUYXpwOG0z?=
 =?utf-8?B?NytBeVZvZXZaeElHUzRZek5zUm5UVzdkMERoZUZmOXZUVjA5V3BURG52azlS?=
 =?utf-8?B?ai90eDM1b2ErdjhuMmZvZzNqL2xqMFYrWXFVSEMrTWdTcHZabnZBZk9HcW43?=
 =?utf-8?B?L0daSUl4S3NYYVkvOFNScktjYTZYaXZDT1FwWjNFVFM3WTJWV1hwazZqdUNy?=
 =?utf-8?B?VWVQWS92MmczZk50MmpoSldUc3BXa2NDVDJZeUUxejh2bnRISXdqZTlURDcw?=
 =?utf-8?B?QTdBVkw4VUYxcWNrRzhsVENLanBWWTRZWFQxNDhZV3dzUFA5aUZ6dW0rZWc4?=
 =?utf-8?B?N3NURElvQmN5dy9SVDEwekNjUEZYbGtWbFpKRUFLODAyQlNGZ2NqTGlXbTRr?=
 =?utf-8?B?NEZsdi9hWm1pc1FaY2FYQm9hMDBqaE51SjNUbzYydkxPdEkxZmtWMEZzUnJT?=
 =?utf-8?B?VGFMbUx2dXZHTkpKNDRPTlVld2tIcjNTeGszVDNoSnFTcGV5RHd5UnRhb2Vj?=
 =?utf-8?B?NGhDYWwwZHppL3N0VXpZVVBsaDBXdnpCTkJ3aGg1N0QxUC93RjRvRFlXTDFq?=
 =?utf-8?B?enhkLzJGNHU1Q1k5dHNvcEpFb0RPWTcrREc2ZHZoemxuOWthWU5vcXRJSFBO?=
 =?utf-8?B?MlREdTNQdG15dEJpS1FHSnZnb0dWRHdvWDJYR3BVTFhIV0EzdHhRMDVxK0Vp?=
 =?utf-8?B?Sk5rRFdKVmJOblZyeWtTYkhhR3dQdkh4UktwYkE1YVVLUVdaU2ZsdHlWOGty?=
 =?utf-8?B?emtaNkxxNmJjUG9DbklLMjliQmJISXNNMjB2WkVWYzZKbEVRemRNSjRXcUZP?=
 =?utf-8?B?eVpBN3dUZUNVeTFyUWxGNnlZZDZBeEN1RUJFUFBULzRyYk5vWUFJcllsanpl?=
 =?utf-8?B?QmFpcWk4S21VOEo2eUlLNXFadjFGaXR2ZGZlZWpMeTlvTmRrU0JFVEhPUGFI?=
 =?utf-8?B?VVhVRGRXZ3Q5MnpkRHVEQ0k2bnFJU3RPUWIyd2ZXdm54dVY3QkEvTzg2U3Jz?=
 =?utf-8?B?MXVrOU9PMmJOdjc1ekRGT2IrRUhadTVBekZYNHVyVzlsektzbi84VXAxNEVW?=
 =?utf-8?B?SlJYZlQvSDJabDk4b3MyR05hQnVkVXFIVndPTXBLZzI5MHVxdkg5WTNuc2Fv?=
 =?utf-8?B?SmZ0WTlXcE1USHlzU2d6Vmc4UGprYUZqT2RtZ29LcXZINW5jYXlXWHNNOVZK?=
 =?utf-8?B?blpJSFc1ajMzdzNBMk9FWXk0VTJSdTR3L2ZNNDEvWXdLQjJGTVp5ZjMxVDFu?=
 =?utf-8?B?SXRhY0tZNGxXNEdiaVpLVFZmVHdIdkhzSmxqaXM1cTMvUmxhbmRCSVZhUlVv?=
 =?utf-8?B?d21KRjYybUQ2TVl4aFJIMy9rZGdDOExlbDVBaWRKSmg2V1E9PQ==?=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR08MB7411.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <2BC75074DF24C54AAF7B31C9A3D039BD@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10737
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: 
 ip=[2603:10a6:102:2a3::12];domain=PA4PR08MB7411.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	463ced68-8c27-4ed5-2891-08dd13d5c0ac
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|14060799003|4022899009|376014|1800799024|36860700013|82310400026|35042699022;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TzBpQ3ZmVnUwNWx0cUE2UEZjUHo2a2hhUnN6STZGa1hVcnVySFR1aEprQ0sz?=
 =?utf-8?B?bThoK1ZaSldxY2xnZkxqdklkUG9DOHN4ZExYQ3NENXZDZVlzRWdUcXFYQ3hU?=
 =?utf-8?B?NDQ3clEyL28wbElJMEg2Z04wSFJwa0dtVERwZE0vamlqR1FvZlJZdXRqTDhr?=
 =?utf-8?B?dUtxT3MxQkU5VVBtNWpzcHBTS1F2NEZNYUNMakd5Y2o4Z3dOYStIZERId1hE?=
 =?utf-8?B?THpJVnFnNUdUQWt5dW5lQkxaRE0xZWoyNGFIZEYxaGFZUTNQbEJuTzZDMUMz?=
 =?utf-8?B?blhFYWdtK0dXMEk3bDBEemcxWERid3hseU05QklrMGhYa1ZtZFN1YTZZN2J1?=
 =?utf-8?B?KzJvdEh0eEFBT1ZjT0s2MGJPUXMyQklmbklRYVlHRTRTTmx2TkxnWDhYQzQ0?=
 =?utf-8?B?aVhobHkvbzhuS0xHTGw1ZEIxaTNPcGU2Tjl2a3ljTWZodHFkdEFFWjIvbDJC?=
 =?utf-8?B?ZzRLMW14YVRYR3g4NE5QcHRLRFhncnR1SHYxUjRmbFV5bnUxd00xb2VoVDZ3?=
 =?utf-8?B?TysrRmZlVlVVaVlHbEx5T2swUFVBUndSSUhadzdIdGdXaDNYb09RaEtKZmpY?=
 =?utf-8?B?c3lmR0NjY0VsSzdqbFNROE16bHMyaVphQUdXbUNFUndVWDBlRnZJNFlaU2xP?=
 =?utf-8?B?bTlEZzdnRlFia2tIWUVxelAxZUxDVjZSVHJSbDFuS015dnVmR1QxTVl3ME1E?=
 =?utf-8?B?aDlRSWoyZi9Ca2dmWUIvTnAvczBnblRIbUlYUURxcG9wdXdzZXdjQ0RWTlA0?=
 =?utf-8?B?dTlnNTVEekNMYm9wN3NsNVNEOW10d1hUN1dkOXdycWZSL1dTYll6aGFXajhZ?=
 =?utf-8?B?dUI0aU9HKzdmd28wcXBEMjR2bGdNakIva0NlWWlXWUFXd24vSk5qQXVuM2VP?=
 =?utf-8?B?OWdTbWJScFdDaVF4RFhuNUw3UnNHUnJZcWVLSjdFZnVSNDBUaXJDRGZHOHU4?=
 =?utf-8?B?TDZoY004a2gvVFVXOG4rN0F6WE1ORFlHejV1RHJ3RGtCbEQwS0JIaFEzTmI0?=
 =?utf-8?B?M0xSclFOU2RySEg5VDd6bmpuQTlMbVBmTllvSVRlK2FMY2N0Q2crTWRaWW1W?=
 =?utf-8?B?MkR5SWpKM0N3ejIySTV4QityWlJXSk9NS1REVms3NCs0RXpKYkIyQ2w3L20y?=
 =?utf-8?B?czhKbWhKdi9yNXI3SlNzTVkyVTdiTVp0aXRCVU5kTk5PNVBjck4yQzkxMFo2?=
 =?utf-8?B?UEgzeTZ6MWtpUDZVeXg0TnBhaFdISkcxbkJCSmEzK01WbVdpWVZRZEVTSXJM?=
 =?utf-8?B?K0N1Ymozdy9Xc1UxbDUxRGMwUnFOWGF3WGo4RnBmTSt1cW5wd3E0M1pUOVJP?=
 =?utf-8?B?QWZEZmkvdS9USDdZd0FaVFZKL0RVNTRGaGwva3dhNE9nc2szaVpmSnhmZDNW?=
 =?utf-8?B?eTJPUG1sa3ZIR0pXUWZybXp3amNaazgxZkR1eVhKVkpBNXRWSUprUmZoRlRt?=
 =?utf-8?B?bEZYTXk1ekgxTVI3bGFOY28yUmFkbU9aMEl2a1dxUFBZSjBvL2l6SHdUTmlU?=
 =?utf-8?B?RlZ3b1N3QmxBMFVuejN1Q2dFN0FmUlRwQytJMEhJVHFTZzJnK1RkOTh3eDhF?=
 =?utf-8?B?akxmcjQ1WWZ0N2NaRUlkY3NUbVVqbHFMdmV5dkpEMDIwNml2Vm9rUCtUNXFM?=
 =?utf-8?B?TS85bjZ4QmNhUW4zY2hiczJRN3JYa3JRaHJJOFVyeHNLQXdEdG1oWkVmVjla?=
 =?utf-8?B?Z2JRUEFVRlYrUVZFeDI3d0hScHVTcW16emg1RVNQMEdwaUF3aE9YWDRORlhL?=
 =?utf-8?B?eDREL1JLdVJ5QjBGN29NNVBVOGxkTGgram1mbjE0ZnJ4ZGdFWklHeWsxbnNl?=
 =?utf-8?B?WFRBMFlBM1JVcFlmQS9BMTlDV3pPMDNSdXhoM0ZqQURIRVhrNEN1eUFDMFhY?=
 =?utf-8?B?Q0trTlNRVThhalF2ZHFrTnczcXZlaUhIZkc0N0hTVWNjbXd3c3o5WVFhT2Nk?=
 =?utf-8?Q?9vo3BQYR4K0f+9CALFYhOHqyuONtkj1R?=
X-Forefront-Antispam-Report: 
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(14060799003)(4022899009)(376014)(1800799024)(36860700013)(82310400026)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 20:05:03.0634
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb7a6344-eabd-416d-5bd5-08dd13d5c63e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11016
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 03 Dec 2024 20:05:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16860

Tm90ZSB0aGF0IEnigJlkIGxpa2Ugc29tZW9uZSB3aXRoIG1vcmUgdGhhbiBwYXNzaW5nIGtub3ds
ZWRnZSBpbiB0aGUgZmV0Y2hlciB0byBkb3VibGUgY2hlY2sgdGhpcy4NCg0KQWxzbyBJIGp1c3Qg
bm90aWNlZCB0aGUgY29tbWl0IHNob3J0bG9nIGlzIGVudGlyZWx5IHdyb25nIChmcm9tIGFuIGVh
cmx5IHZlcnNpb24pLg0KDQpSb3NzDQoNCj4gT24gMyBEZWMgMjAyNCwgYXQgMjA6MDIsIFJvc3Mg
QnVydG9uIHZpYSBsaXN0cy5vcGVuZW1iZWRkZWQub3JnIDxyb3NzLmJ1cnRvbj1hcm0uY29tQGxp
c3RzLm9wZW5lbWJlZGRlZC5vcmc+IHdyb3RlOg0KPiANCj4gdWQucGF0aCBoYXMgYmVlbiB1bmVz
Y2FwZWQgKGVnICUyMCBpcyBzcGFjZSkgYnV0IGFzIHdlJ3JlIHJlY29uc3RydWN0aW5nDQo+IGEg
VVJMIHdlIHNob3VsZCByZS1lc2NhcGUgaXQuIEZvciBleGFtcGxlLCB1bnppcCBoYXMgYSBTUkNf
VVJJDQo+IGNvbnRhaW5pbmcgIlVuWmlwJTIwNi54JTIwJTI4bGF0ZXN0JTI5L1VuWmlwJTIwNi4w
L3VuemlwNjAudGFyLmd6IiB3aGljaA0KPiB0aGVuIHRocm93cyBleGNlcHRpb25zIGlmIHRoZSB1
bmVzY2FwZWQgc3RyaW5nICIgKGxhdGVzdCkiIGlzIHVzZWQuDQo+IA0KPiBBbHNvLCB0aGlzIGNv
ZGUgdXNlcyB0aGUgZXh0cmFjdGVkIHVkLmhvc3QgYW5kIHVkLnBhdGggdmFyaWFibGVzLiBUaGVz
ZQ0KPiBhcmUgdW5lc2NhcGVkIGJ1dCBwb3RlbnRpYWxseSBzdGFsZSBhcyBlZyB0aGUgY2FyZ28g
ZmV0Y2hlciBzdWJjbGFzc2VzDQo+IFdnZXQoKSBhbmQgcmVhc3NpZ25zIHVkLnVybCBvbiBjb25z
dHJ1Y3Rpb24uDQo+IA0KPiBTaW1wbGlmeSB0aGUgY29kZSBieSByZWNvbnN0cnVjdGluZyBhIFVS
TCBmcm9tIHVkLnVybCBkaXJlY3RseSBpbnN0ZWFkDQo+IG9mIGJvdW5jaW5nIHRocm91Z2ggaW50
ZXJtZWRpYXRlIHZhcmlhYmxlcyB0aGF0IG1heSBiZSB3cm9uZyBvcg0KPiB1bmVzY2FwZWQuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBSb3NzIEJ1cnRvbiA8cm9zcy5idXJ0b25AYXJtLmNvbT4NCj4g
LS0tDQo+IGJpdGJha2UvbGliL2JiL2ZldGNoMi93Z2V0LnB5IHwgNCArKy0tDQo+IDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvYml0YmFrZS9saWIvYmIvZmV0Y2gyL3dnZXQucHkgYi9iaXRiYWtlL2xpYi9iYi9mZXRjaDIv
d2dldC5weQ0KPiBpbmRleCBmY2I3MTI0NmQ5YS4uMTk4NDI2MDY1YjQgMTAwNjQ0DQo+IC0tLSBh
L2JpdGJha2UvbGliL2JiL2ZldGNoMi93Z2V0LnB5DQo+ICsrKyBiL2JpdGJha2UvbGliL2JiL2Zl
dGNoMi93Z2V0LnB5DQo+IEBAIC0zNzYsOCArMzc2LDggQEAgY2xhc3MgV2dldChGZXRjaE1ldGhv
ZCk6DQo+ICAgICAgICAgICAgIG9wZW5lciA9IHVybGxpYi5yZXF1ZXN0LmJ1aWxkX29wZW5lcigq
aGFuZGxlcnMpDQo+IA0KPiAgICAgICAgICAgICB0cnk6DQo+IC0gICAgICAgICAgICAgICAgdXJp
X2Jhc2UgPSB1ZC51cmwuc3BsaXQoIjsiKVswXQ0KPiAtICAgICAgICAgICAgICAgIHVyaSA9ICJ7
fTovL3t9e30iLmZvcm1hdCh1cmxsaWIucGFyc2UudXJscGFyc2UodXJpX2Jhc2UpLnNjaGVtZSwg
dWQuaG9zdCwgdWQucGF0aCkNCj4gKyAgICAgICAgICAgICAgICBwYXJ0cyA9IHVybGxpYi5wYXJz
ZS51cmxwYXJzZSh1ZC51cmwuc3BsaXQoIjsiKVswXSkNCj4gKyAgICAgICAgICAgICAgICB1cmkg
PSAie306Ly97fXt9Ii5mb3JtYXQocGFydHMuc2NoZW1lLCBwYXJ0cy5uZXRsb2MsIHBhcnRzLnBh
dGgpDQo+ICAgICAgICAgICAgICAgICByID0gdXJsbGliLnJlcXVlc3QuUmVxdWVzdCh1cmkpDQo+
ICAgICAgICAgICAgICAgICByLmdldF9tZXRob2QgPSBsYW1iZGE6ICJIRUFEIg0KPiAgICAgICAg
ICAgICAgICAgIyBTb21lIHNlcnZlcnMgKEZ1c2lvbkZvcmdlLCBhcyB1c2VkIG9uIEFsaW90aCkg
cmVxdWlyZSB0aGF0IHRoZQ0KPiAtLSANCj4gMi4zNC4xDQo+IA0KPiANCj4gLT0tPS09LT0tPS09
LT0tPS09LT0tPS0NCj4gTGlua3M6IFlvdSByZWNlaXZlIGFsbCBtZXNzYWdlcyBzZW50IHRvIHRo
aXMgZ3JvdXAuDQo+IFZpZXcvUmVwbHkgT25saW5lICgjMTY4NTkpOiBodHRwczovL2xpc3RzLm9w
ZW5lbWJlZGRlZC5vcmcvZy9iaXRiYWtlLWRldmVsL21lc3NhZ2UvMTY4NTkNCj4gTXV0ZSBUaGlz
IFRvcGljOiBodHRwczovL2xpc3RzLm9wZW5lbWJlZGRlZC5vcmcvbXQvMTA5OTA3NDAxLzY4NzU4
ODgNCj4gR3JvdXAgT3duZXI6IGJpdGJha2UtZGV2ZWwrb3duZXJAbGlzdHMub3BlbmVtYmVkZGVk
Lm9yZw0KPiBVbnN1YnNjcmliZTogaHR0cHM6Ly9saXN0cy5vcGVuZW1iZWRkZWQub3JnL2cvYml0
YmFrZS1kZXZlbC91bnN1YiBbcm9zcy5idXJ0b25AYXJtLmNvbV0NCj4gLT0tPS09LT0tPS09LT0t
PS09LT0tPS0NCj4gDQoNCg==

