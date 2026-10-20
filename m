Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.6])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6283.1792499645194377014
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Oct 2026 05:34:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=r7iZ6QwL;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=r7iZ6QwL;
 spf=pass (domain: arm.com, ip: 40.107.130.6, mailfrom: ross.burton@arm.com)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ClKJ8B91G3FzZw7oyWrPaKHIxYuwh1dKZMXRp161fS0QPGytOlEKfKkxXFqBSZqVMnK2vQ4ypL+pukP4pCTINxccTFZ5g0cNl9am8b2KYnaARAw1QB9fgwxUXJbVrORVoUnrdNW/iPVFeDxfmpA4eIhq117jc2E+uUiUNZMrK6faCjm+Wgh6mSVrDdMiu1dc7aWnCCqg4A2Xyc/ImcRnRz8RXGx47wzW9YbihpSOHhCQiFxAWcQkxksulF5jQx6S/d+MbM80OYgyG6tRpegTKJuiUbU+rcC5F8O9ozs49lIS7aFQ6nqdzZ0MWrV8ZfNpc69uGBMvIUFb5Vica0OStg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAIVaNpHhEtcbMVWSbrcJLYm0msSiZr9T+XFFen7u38=;
 b=aU363jl2x2KpI1d/3j2zLfqGjKrpMp12YI5BB2txUmhihuzFRWDXMfXbhDdmqnwmomMNLtnJN1K7T+gG2I0bYEX7V5lRVmQgZF34ckQ8nnjoQ6pru3q5mqP1rZIw0kDqCKLIbTOgBangzA4NNrguCbqrDZKvRoj56nvQYwe5Pi3AecsiirkImdVfWVTtZUpoyngSHji+qW3SYTPXTzA4BEBKKCSkdaHwkXCpAnDl7Q3dWdXmT6+6AthQceS/mDiTRq+gHXQFJSep1JbAQuWQbWUxWE+T+Jof9qY8vEp1hbevqAOkbLnQ4j+Y9K1XoiLgyPrmp5kW4KnXnAIZaXy2qw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAIVaNpHhEtcbMVWSbrcJLYm0msSiZr9T+XFFen7u38=;
 b=r7iZ6QwL00/eNqu0jGWt9GI40+joxvwHMIA07XeR4mhWefHnynVCGPZr14byoZ22/xLVroPVxT/FRdsK7o8renh38w1Ue9eUetzMcb2Uc3JsM3WCKs2J19a9VE/bssapgM8DH2eeAchOIsT/RrflQB/Y7w7QNUG06WOvEoga4KM=
Received: from AS9PR06CA0660.eurprd06.prod.outlook.com (2603:10a6:20b:46f::28)
 by GVXPR08MB11471.eurprd08.prod.outlook.com (2603:10a6:150:2e3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 12:33:56 +0000
Received: from AM1PEPF000C1AD9.eurprd02.prod.outlook.com
 (2603:10a6:20b:46f:cafe::10) by AS9PR06CA0660.outlook.office365.com
 (2603:10a6:20b:46f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Tue,
 20 Oct 2026 12:33:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM1PEPF000C1AD9.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Tue, 20 Oct 2026 12:33:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j9oyFRCx3JEn9MIIM4/XRmM37kwlb2otJCroL/Q+BnCnMHeNrJ9UHdQTly+ysawTG7shanGOpxv/F51nlGbqfuI8Nk7yH1twLlREZ3J/8WJB82G6sHwbDx+1kiR4WTkMZeCXPVnySViGe+USFdk0IQq27HujNRuFcmW9gQ5Bh11sSp9MsDb612C3ARak1GRzxV22JrEM3ZH5ps8wLilYz8rwyIVDu9Hnr4TtiJOOtQn77QDJ0EQ3hboaZxYJm5nQ6LAAWBN+gq8nLPeZQtelq2t3LMp1+HIvdVM6jg38ZRGfCwD446a7ff035jOjqa6J2rbUtGIZKZB/XUmxzX/+Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAIVaNpHhEtcbMVWSbrcJLYm0msSiZr9T+XFFen7u38=;
 b=MNvuGVLuG4vKIEG3F9NMrG2zypD/8wfY4uuzprRdsxbuUcigcod3XNZcxUHCsKsIcE3mWFhSsZxEx2Daz86nUbiOiS9Uz9I7Lww5uOJFVuqts4oxCqZKKvhRwURslXN84hVosfA19qPkLRgzyA2a9gbcM9Ej+/+fjx5SV6OQOBzxzbFxWITm3CQHng4blA5lexnTzUEMIp3Cm+VsFwrIo9fUNACwXJXQGMh3xJsaAAECMYHOGYIUlD2bWf9PTw3tKa/oFzd3lbSGf/CZaFGSjnUf6wyXSzgOhlBZaxFndoFuapp5gHsVC4hZxef2n9LLwe5zx3mKknFtqcGsuJGlGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAIVaNpHhEtcbMVWSbrcJLYm0msSiZr9T+XFFen7u38=;
 b=r7iZ6QwL00/eNqu0jGWt9GI40+joxvwHMIA07XeR4mhWefHnynVCGPZr14byoZ22/xLVroPVxT/FRdsK7o8renh38w1Ue9eUetzMcb2Uc3JsM3WCKs2J19a9VE/bssapgM8DH2eeAchOIsT/RrflQB/Y7w7QNUG06WOvEoga4KM=
Received: from AS8PR08MB9410.eurprd08.prod.outlook.com (2603:10a6:20b:5a9::13)
 by MIWPR08MB092276.eurprd08.prod.outlook.com (2603:10a6:290:d9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Tue, 20 Oct
 2026 12:33:23 +0000
Received: from AS8PR08MB9410.eurprd08.prod.outlook.com
 ([fe80::1f2c:bae7:a4d3:fefb]) by AS8PR08MB9410.eurprd08.prod.outlook.com
 ([fe80::1f2c:bae7:a4d3:fefb%5]) with mapi id 15.21.0546.006; Tue, 20 Oct 2026
 12:33:23 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
CC: "ticotimo@gmail.com" <ticotimo@gmail.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] parse: only search each BBPATH directory
 once in include_all
Thread-Topic: [bitbake-devel] [PATCH] parse: only search each BBPATH directory
 once in include_all
Thread-Index: AQHdX24vqmcm7AfrIEygRM8L5/ES5rcFCk2AgAFUgYCAAACsAA==
Date: Tue, 20 Oct 2026 12:33:22 +0000
Message-ID: <96915A49-AFB6-4CAD-8EEE-4A87612340E3@arm.com>
References: <20261019020422.14365-1-tim.orling@konsulko.com>
 <6C7FAEF1-2BE9-4E2C-B2DF-A037491D00D0@arm.com>
 <7f00a969c9ef34a77342ca8909def148aceeb652.camel@linuxfoundation.org>
In-Reply-To: <7f00a969c9ef34a77342ca8909def148aceeb652.camel@linuxfoundation.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3864.700.51.1.3)
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: AS8PR08MB9410:EE_|MIWPR08MB092276:EE_|AM1PEPF000C1AD9:EE_|GVXPR08MB11471:EE_
X-MS-Office365-Filtering-Correlation-Id: 388768b6-a0fc-4540-56fe-08df2ea6682b
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|10067099003|4143699003|11063799006|56012099006|38070700021;
X-Microsoft-Antispam-Message-Info-Original: srBqVatrM+6i4kKsg882t8Td3tPoiAUAdhGNSiD7N1FKmoS19lHT9oM3UJLFmX51VqfP8gd5PkkO2zzPmkBKzv0NXgmucV5npyqbmo2pYdiDXv7pimmHLwbQBLid1Pr0ghLFxrtX5COS77HPj1fRwTgvwPkdWQ5/HVJVOUG0SF2uA1Y6c4sLT/DixZF253wJBQXMmT1UJfRQ2ndZoQKKTOptBqxlx5aTrjnRd/I6a/cvfi7EWTsNj40DaMpJuDU5+aWjA5Kh07HLtRpjRhqQuujX+kf1nfY+Nez9o0gGVgKactToQ720/ldTJSjMLrlMo7aEyOEuADic6EmbouM/fCukwvCHiC/BPVP9C1vqQXjutzHw2l45BdIkysuX1pys2ZLOeFKCiU14yWxTHVrsg9QyXUXxQDBaEPOgV0YYnKR1MeAk7c+O8FNbJ0hIkdp8DW0rqrq0dPPMvo7KSqvK3FGex8SSUcJSlVefNgcwrKzqSRZDu4zszY+Whi1I65YgQluMPkHym5VjwWS1mVYRhHmgpJHFWpdKxetfdPK9/Ux92a3czt7gC6252npoTEpQtRRCROCkef7ysMVQRk1kJXk/DlIET0elgNCD9bCQctcT69wMFW9JJL79mW13hX5AnGxvbKX9l+PQgizfJsqvJCpx1g3fsuxWeB1YT5PYkHzOZQa0kyk4PWdOqU8bOq/jZ3Me49tbof/nPHvqDkUKXSvhrKI8dALr1IolVHnYn10=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB9410.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(56012099006)(38070700021);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <3306E045E7E3BB46A7A5ED1DEFE94A35@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: yWzDPovltkQfTOTFAV+TftorDL3KBHYRNpoMLcQyl1jo9/K4NDLP7RFKmqT8N2OYMTdSvE8C5kY3iT0uZRlG68cedaRz/hNCjwgjWhYBq+aHypahyTaV9E3Xsskj3WP952oNCJOleliFkAvGpzI6GksJxEiHwaPBrj4P2+/qpBGqvO7wUoFSBsMhrqZtpdqLKRgrdRR7oxDj+tpQIaELMXV+VZqxrXFUhNTWxx+n/xzay1x3oqwvH2FooFmh+DYNCF+UHheB9QUosCzJy4bp5ZZQVS/qoS9EoZv0SF/lvIIleUHZZ7+MJWG7dMue6xbhpF50ypRD44ZDJM0Wk+mCeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR08MB092276
Return-Path: Ross.Burton@arm.com
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM1PEPF000C1AD9.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 054f1052-7e49-46e9-dbb5-08df2ea654ae
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|82310400026|14060799003|36860700016|1800799024|35042699022|376014|18002099003|22082099003|10067099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: HbNV3cknBNSM66ISndlNEmFuVM7Ogk6z7+NQxEOC5hIkDjI9cF0nfICrHgdZ5QMz8JpYGoqfDEpz8ZqxvXV37PRoBO3YHFf5T8rKk0WpqmjGbMUZd4cnzRGNM6MOsWWmXkJFVQEpJdTscLZqTKVRZyHurcX/4r7RAFh9N3JfV8lx4M0P+dZ7u8C8R+OGFMoGwP9Y5AB3Y936+RiQkXlr40QuUTXWC7J2KzzUtQYi4Sd/tm88Ey1gQT3eQswaEGkhHKxeXyLo4I2TWynkqYHo3KgKW4kwJJVLQSMpIbExVFnlZdehU4BmrhJPWY2NbtHcmDOZI96+DXMiAlK/D8p8IZ11C46M7dy9rFNm21xyYnMGOtuqpKocRxggE5XSjl3y6R9scDgKHDrIqfS01Soic2W2rWfzc68A1LdeK53IbtzY1zUquYCIpWXYUDJY4HxDnGNmLaodSg4NPYUIt5/1U1xEHQ1cMT2KJEN19t0h7juBn4YQgRtUuCPU/LSSfwlT3Omprp4tgLi2C4K7YLxKBsZm34yqUQxyookyIDICI0x8jhTxTYC4gBNDLMRxnvabsET4HGVCTLoihykQ/JOTW0Capd+KLxB8feAz0p9e24G4hK3+Mucn72nr2HxDn5LdoXtHqoSFQDSCTS5Ccu5s9RCKvI2cw/EQoZz3X16FJq9C6Fs90f+nt5uMyYvIlnEzST6BJ8ElHdKAWMaPf1ZwEg==
X-Forefront-Antispam-Report: CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(14060799003)(36860700016)(1800799024)(35042699022)(376014)(18002099003)(22082099003)(10067099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CBE/ZeuC3ws9SMlKs8gTkCpWYHZUZxTt5qisVBqCLQGiHtvr8pNVkxqop118gp9JFSW7rnGG/h0AHbNk9nu8KHS6oil+4P6WtsOZp75fi7lih4GIg00FBKKD1ym39oxRB2oHxTFJuMhvk+Pnn0pTnJmnl+49ZKUc1TAiyti0i8SmvvkI4HK2m7a/RkmYt/duJuoqNpxLpayrCTTAvjUmd8RdAx8TH9M2orBsLd0Z/ec3EDF2+41OcJU75sT1s+GOFPBGXw+KoMzItZdO/eI5OsGFD+lm29ukU3S+dN9+OELeLTG5RfLJAldGZ23uXZL3MVxqqzosDY7q3z7DdgnUeKHLHlWezW16foDPquC2omDi+xZM2yQMgh2WjkjEcIn5DyeYlvPBv8YQzL0lN3WLuAQTOvmXqdyhGxfXnJjGyxxBHBGd+VLtIrbYoeOQ5AAw
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 12:33:55.6116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 388768b6-a0fc-4540-56fe-08df2ea6682b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM1PEPF000C1AD9.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11471
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Tue, 20 Oct 2026 12:34:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20364

T24gMjAgT2N0IDIwMjYsIGF0IDEzOjMwLCBSaWNoYXJkIFB1cmRpZSA8cmljaGFyZC5wdXJkaWVA
bGludXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6DQo+IA0KPj4gRmVlbHMgbGlrZSB1c2luZyBhIHNl
dCgpIGluc3RlYWQgb2YgZGljdC5mcm9ta2V5cygpIHdvdWxkIGJlIG5lYXRlci4NCj4gDQo+IE9y
ZGVyaW5nIG1hdHRlcnMgaGVyZeKApg0KDQpIbSBJIHRob3VnaHQgc2V0cyBoYXZlIHRoZSBzYW1l
IG9yZGVyaW5nIGJlaGF2aW91ciBhcyBkaWN0aW9uYXJ5IGtleXMsIGJ1dCB3aGlsc3QgdGhleSBk
byBpbiBwcmFjdGlzZSBhdCB0aGUgbW9tZW50LCB0aGlzIGlzIG5vdCBkb2N1bWVudGVkIGFzIGJl
aGF2aW91ci4NCg0KUm9zcw==
