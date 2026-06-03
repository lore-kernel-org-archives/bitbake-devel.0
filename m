Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A36CD6E4A
	for <webhook@archiver.kernel.org>; Wed,  3 Jun 2026 11:32:09 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.9])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17967.1780486323761743321
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Jun 2026 04:32:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=KVSTHesh;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=KVSTHesh;
 spf=pass (domain: arm.com, ip: 52.101.84.9, mailfrom: ross.burton@arm.com)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=kVRh5FunbznrV7JhbCL//KWVTd5z2sz0eTfcni+5xvmJJqXxn8oextYQ4RjpsGPx70t7IwI4Aofvrnqj6bU7o3LdiYBK3UV+i3gcC6T4JFTKWp3WqJY32O4CyRlZKhjbTsJZfYap9ylRKUYkAJH8XU9br2FHQYjPsqrF2PNkbh7c2uyMStFocUnXAfrF74w/3yZ6zl4wSPiq8ElPyOp6ERr1vblaZkq0c5p1Ud3gA37Wd19qNOVlus4NkrY+pp8Hy6/gC8nUASs+/5WomzgWw9yp45BYgPjUTMPQTUvCdienLfuUTcWcW62PL5+RATRGHP7cdOFh6UtA+Kv2PDfX/A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRxUyx8+HL5UZVHwyoXc++uBoDWFbc2wHMMcgvyNW+c=;
 b=kdMs29TUdY0CMVsFgAp/s0LEx3CxsRGsrEvWSfgl8jrEfaxxUiUxEkm4W+KsixAzajIzyzHlHE8XSxNORZak6/ht151VCbWiZC+no17rKzH7FrZJRP1RKuqJQNyPLGYuXVf43P4kKbtRYkB/Uv08hQmbxkCSzMRnsxRDuefzHvYpxl+78Jgl0uA6gFgqfHEl/BI4Xwd6wZNf/0rL5aUElujBw1rW3ORfD4bEzDh6FjmSAISDQJfKdroyRkGMwEtBs6k2nOyTNymShrXAjJHAkZqG6EK5swBjo+u9TCqWPdFxKv66UInpLrtkVaL7AFCGLH8jl6BxUHIKEujIjxLOBA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRxUyx8+HL5UZVHwyoXc++uBoDWFbc2wHMMcgvyNW+c=;
 b=KVSTHeshlWG8+oIaRI6ofaGIJyNrWSaTmzOQmhf16ZFnPZN+aCFEWP8//0j7mB9ZmEfhKMEmw0OoyE3IKyoNodCDv1B3IZAifJIL8S42m6DPS6GNWiL/NkKX/q1ddz7SB69pkVPZrKmbIUNr9dK3kyjvErmGcmpcUIeC8b6T018=
Received: from DBBPR09CA0030.eurprd09.prod.outlook.com (2603:10a6:10:d4::18)
 by DBBPR08MB10652.eurprd08.prod.outlook.com (2603:10a6:10:531::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 11:31:54 +0000
Received: from DB1PEPF00050A00.eurprd03.prod.outlook.com
 (2603:10a6:10:d4:cafe::6d) by DBBPR09CA0030.outlook.office365.com
 (2603:10a6:10:d4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 11:31:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF00050A00.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Wed, 3 Jun 2026 11:31:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZpAYelUcjqeSqS9Q9d+CwMavUaPBKra+frDaxPD1FnboW5+x8JUu3AWL4fCjBHCLz22jJ0lkbLIaK7OWGuFhYnou0PIFheyBEZtOx7likaAAB8zpu/xUVjCaKz68VogtcRgDtYFSEL40eXgyeU/q/5Pg0HhhLR96usd1mvoM0H3CLRDtoI4HGgBZqamK3g9pPhC++b4ugoVVf8embf0kk179RXG+k1RSRr94juLVsGR1Y8mcoicyqJ/SKgarBBGS/wHadBTmIIgrLqAPY/3cSzufTS3LJFIly3Fh0TPv6J6KcqWNTMD3aWivl14kXQ8Hv/JDHWdD5b94Yw3aWZBsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRxUyx8+HL5UZVHwyoXc++uBoDWFbc2wHMMcgvyNW+c=;
 b=Z80IfD2eJx3dN6Y1xgaBunC+xhwzCb01NUOX925sQbqlROowGWsb6YiYmGgrhc6PITbgZvteCt12cd41TcwIQUaZfzFo9bhfcMkzfqOJww9Kn5tkcXviO8UNtW+O6cCVh/VuXBh0MNNYav7yH1Egt9/x63t8BHHAqsRccFpt/5RxRTKaiDxb9cMpF6M6EuEGpzfHOwCW5q9BOsqJ8uEnrR6GdjCrSR5P+EOv/2HcGaLoJifo8aAZRhU3YkIIS1kmewyIW0O6a+S7qzOKrg+bsH/37SyCmMLQH58CoIYaxdQfz1/9aPSpHTpJV9945EB/QOEfDRAN0zFjJtv7oFFpbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRxUyx8+HL5UZVHwyoXc++uBoDWFbc2wHMMcgvyNW+c=;
 b=KVSTHeshlWG8+oIaRI6ofaGIJyNrWSaTmzOQmhf16ZFnPZN+aCFEWP8//0j7mB9ZmEfhKMEmw0OoyE3IKyoNodCDv1B3IZAifJIL8S42m6DPS6GNWiL/NkKX/q1ddz7SB69pkVPZrKmbIUNr9dK3kyjvErmGcmpcUIeC8b6T018=
Received: from AM9PR08MB6258.eurprd08.prod.outlook.com (2603:10a6:20b:287::19)
 by DBBPR08MB6124.eurprd08.prod.outlook.com (2603:10a6:10:202::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 11:30:50 +0000
Received: from AM9PR08MB6258.eurprd08.prod.outlook.com
 ([fe80::171d:1f8b:720d:7a1b]) by AM9PR08MB6258.eurprd08.prod.outlook.com
 ([fe80::171d:1f8b:720d:7a1b%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 11:30:50 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: "ms98.cho@gmail.com" <ms98.cho@gmail.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v3] fetch2/crate: support configurable
 registry and index URLs
Thread-Topic: [bitbake-devel] [PATCH v3] fetch2/crate: support configurable
 registry and index URLs
Thread-Index: AQHc6T+6BsgV26xyGkaglNXmyEhbqLYsxk+A
Date: Wed, 3 Jun 2026 11:30:49 +0000
Message-ID: <406442B9-5A67-4CF0-94A1-51A4E9577F65@arm.com>
References: <20260514200526.98596-1-ms98.cho@gmail.com>
 <20260521163033.40871-1-ms98.cho@gmail.com>
In-Reply-To: <20260521163033.40871-1-ms98.cho@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3826.700.81.1.8)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	AM9PR08MB6258:EE_|DBBPR08MB6124:EE_|DB1PEPF00050A00:EE_|DBBPR08MB10652:EE_
X-MS-Office365-Filtering-Correlation-Id: 815509ef-e134-4608-7f95-08dec163b6e2
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|13003099007|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info-Original: 
 9020K+kqbX78YobP82BgnOm0FpHNP8ngFv09tJ48poDWODZYc0d/KRP689XuyNw+Cg1RRKVCIVqUyUpJIvaAChQ+Gt6hLvcxN6zfbSMAbGD3g/lcFbGn59G9bVW99FbzNifKq2wzkkpJ6Z9kDfzuYNTG8hsd+RO6T61nh7DDhXRR3jHnXs4iZNjN0l49WrBacyHy8jLzNgsE6qi0KnWYnYKyceGpUf4mUkdgmoFhlUh/mHcdplg58McdrfeOuUGd/PI/4mo2qwV2D5kYABO6f3cVe9D5bAi1+jAa9IPPtaU5FqM5NKUTdxZIVsENAzwEnYR4pPrXlIfosL/CwUcqkzIC00htnYDAi9R+hg92nNkEjHXdHi6vJggKfhgBayNYA60cdCxocpthMTUHdpMpxGiYUJgsASwElJh563lOqFu50bUC5RuWwXdGdj+/9RdWsirp8jOCIziYtB3gtCpt0OKSSPA3Iut0tLXeiRMCipn4EnS8SnMwPvlTV0bYFKkP5jlFDgxZG8/8fqUL70315gMZYpaSsOL2N2hyzClWV1SY+hkw9XPjiL+E02Y3bzyDT2M0cH+FJz0sWjyHMHJsK3e9RHzp69mLL9nWxoCxjG7hhxOvkXAt/yCw0lVbs0vn0rCJ6n3DMnZeSx01yYfBZSezLvOyZR51c5X8q6kIVxNsMqiDSk5ULel1E5F8TFCu
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6258.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(13003099007)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1A1751452C9874397067502EC6B70F4@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
 ijHm8OTbQXqZxU9XD43fF8sGn9V3yZhQbM2WxF4g1np9/G1jFVO1s5c/Y+PTwQsCfVVHq5qfeaefdJWeofPt4gq2MRfk3kj5VzB59zf7lVzj8RE+OvD41z3iylwzcmnaiQphg1X+tXcuIT/McR5I2OC0kYB7P7VWWh8XrQpXl+He/XFfiGTsBBpwWTss5LRxP1p5gceVtjNHS8ifHBiWoWmpGkVNYw9sNEtJXBzp/ouJCqbA8UDL/6LXYoTJ4abI2ghAj9whK30SzPVOXnwMNznizbTfZ0RhpFSr2bj28dxy0eeJ8t3nDhbmJPHiqh+TbmF+h/ku6vZZMdX+iYQYEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6124
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 DB1PEPF00050A00.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	5666e228-8c48-4a70-4f97-08dec163904b
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|14060799003|376014|35042699022|13003099007|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	aePPIoVJ0C3R+vkh+u0ho8VbKBqE0BLDVXg3qp+ZObzPhGs+MAxpUNlXZ0jlaUlgTMILOxzZvB0TGXPH7FOFRo9qxDha4PFjY5mOBIclkQSAiOtIXMQyFeDR+/4llZCBrhACS6KtfAQ4ISR8PeGiCMBQHRJYvIR/IhBEeF9n0PDOFRJFPkjat9r3TWTuva1IUyYAdVfguwSrB/PeRdY9kvu71/0pqxkL2BQTeK73OEbhZycZk0Zgc72wk051DZMiDpSRHrHmYYEWPbUJfmSpfOFVM7XZpE0MYyPznT8efFMxgslj/MpKGkLCIENIX6IWNFQT8v275xogOaEENiJabJFhkNNAhbJer8EaV0lnaKRfOBmTyBlg8pbgJiY8nD4mBxRj+y/cD2oAvUnVss0MozrpZnpYjNpSjJ3T0Q1z7Bdo9Sr6A5E4on09EiEpa2ooVn8CXAuGMleKr7nzR7BLVrQg8rq+OP/b0chEPnxd1TcKa/WEL1ExeskNuy/L/40gDa4mGyu4X1YVQXl98dukbB9TWnSHC7ahu7JuaM+nqQExk8d7tcJwn25mm0eu1z0VCfux0z6Twh4TgWqAsT9NwC19TFEwiTPgqHnvVrCsz/YAsAC4H9lv4q/wpl+HHR1Mcv6qNlf74nr++yMjE9EclJoyH0QUu9Xa3wGgNAf4iJXsujPgohNpH5yQPd3JA1w3
X-Forefront-Antispam-Report: 
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(14060799003)(376014)(35042699022)(13003099007)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	jyWDARZWV4/mFm4Jcl+z+N8/C0xNMaXnh/Mzsjc6wrZC3PosQN4uLKo8o3hh9mbFXGr7rE4MyD8kPz4Hivs08mj9CbASJ5XWNLiqjNyY1WDozDV2nuAILD1dTV/PdD17Jc3zbfJtQQsrMSiX0NqUP7oYMSbgrF1AkOWgPjMvGXJp7e42g9bMygmAr0woH91g7QHVjdndaZfyFPg/z4cx971dh4f/wiiYpjI7O17Unx9tIwx2JgrzfeXB8t3EkVHKJgnzJujz0FSoO7VK0p+d4RlzlOrNUG5mw/5wgqegazLUAnUgWjXgz3THhXR9E2pX25zVRPpsOGs8I/RLdExHJTs5qE5sZ9V6s9Zt85ovR23xEw+7iD+52EmZbTQUN6yV1ucVgaXcAqs7IdeKSL4WsNpH0lnRtSAjPl7OPQraGCjeMfIjW6iAMEClWMrXDbmD
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 11:31:54.6831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 815509ef-e134-4608-7f95-08dec163b6e2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB1PEPF00050A00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10652
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 03 Jun 2026 11:32:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19602

SGksDQoNCk9uIDIxIE1heSAyMDI2LCBhdCAxNzozMCwgbWluc3VuZy5jaG8gdmlhIGxpc3RzLm9w
ZW5lbWJlZGRlZC5vcmcgPG1zOTguY2hvPWdtYWlsLmNvbUBsaXN0cy5vcGVuZW1iZWRkZWQub3Jn
PiB3cm90ZToNCj4gKyAgICAgICAgaWYgZGxfdXJsOg0KPiArICAgICAgICAgICAgdWQudXJsID0g
ZGxfdXJsLnJlcGxhY2UoJ3tjcmF0ZX0nLCBuYW1lKS5yZXBsYWNlKCd7dmVyc2lvbn0nLCB2ZXJz
aW9uKQ0KPiAgICAgICAgIGVsc2U6DQo+ICAgICAgICAgICAgIHVkLnVybCA9ICJodHRwczovLyVz
LyVzLyVzL2Rvd25sb2FkIiAlIChob3N0LCBuYW1lLCB2ZXJzaW9uKQ0KDQpJbnN0ZWFkIG9mIHVz
aW5nIHJlcGxhY2UoKSBjYWxscywgd2UgY2FuIHRyZWF0IHRoZSBzdHJpbmcgdGhhdCBsb29rcyBl
eGFjdGx5IGxpa2UgYSBmLXN0cmluZyBhcyBhbiBmLXN0cmluZywgYW5kIHVzZSBmb3JtYXQoKS4g
ZWc6DQoNCnVkLnVybCA9IGRsX3VybC5mb3JtYXQodmVyc2lvbj12ZXJzaW9uLCBjcmF0ZT1uYW1l
KQ0KDQo+ICsgICAgICAgICAgICBlbGlmIGhvc3QgPT0gJ2NyYXRlcy5pbycgb3IgaW5kZXhfdXJs
LnN0YXJ0c3dpdGgoJ2h0dHBzOi8vaW5kZXguY3JhdGVzLmlvLycpOg0KPiArICAgICAgICAgICAg
ICAgIGlmIG5vdCBpbmRleF91cmwuZW5kc3dpdGgoJy8nKToNCj4gKyAgICAgICAgICAgICAgICAg
ICAgaW5kZXhfdXJsICs9ICcvJw0KPiArICAgICAgICAgICAgICAgIHVkLnZlcnNpb25zdXJsID0g
aW5kZXhfdXJsICsgaW5kZXhfcGF0aA0KPiArICAgICAgICAgICAgICAgIHVkLmNyYXRlX2luZGV4
X2Zvcm1hdCA9ICdzcGFyc2UnDQoNCkl0IGxvb2tzIGxpa2Ugc2V0dGluZyBpbmRleF91cmwgdG8g
aW5jbHVkZSB7aW5kZXhfcGF0aH0gaW4gdGhlIGNyYXRlcy5pbyA8aHR0cDovL2NyYXRlcy5pby8+
IHNwZWNpYWwtY2FzaW5nIHdvdWxkIG1lYW4gdGhpcyBlbnRpcmUgYmxvY2sgY2FuIGJlIGRlbGV0
ZWQsIGFzIHRoZSBibG9jayBhYm92ZSB3b3VsZCBoYW5kbGUgaXQ/DQoNCj4gKyAgICAgICAgICAg
IHVkLnZlcnNpb25zdXJsID0gdWQudmVyc2lvbnN1cmwucmVwbGFjZSgne2NyYXRlfScsIG5hbWUp
LnJlcGxhY2UoJ3t2ZXJzaW9ufScsIHZlcnNpb24pDQoNCkFnYWluLCB1c2UgZm9ybWF0KCkuDQoN
Cj4gLSAgICAgICAgaWYgdWQudmVyc2lvbnN1cmwuc3RhcnRzd2l0aCgnaHR0cHM6Ly9pbmRleC5j
cmF0ZXMuaW8vJyk6DQo+ICsgICAgICAgIGlmIGdldGF0dHIodWQsICdjcmF0ZV9pbmRleF9mb3Jt
YXQnLCBOb25lKSA9PSAnc3BhcnNlJzoNCg0KV2hlbiBpcyBjcmF0ZV9pbmRleF9mb3JtYXQgbm90
IHNldD8gIElmIGl04oCZcyBub3QgYmVlbiBzZXQgaW4gdGhlIGNvZGVwYXRocyBhYm92ZSwgdGhl
IG90aGVyIHZhcmlhYmxlcyBoYXZlbuKAmXQgYmVlbiBzZXQgZWl0aGVyLiAgSSB0aGluayB0aGlz
IGNhbiBiZSBhIG5vcm1hbCBhdHRyaWJ1dGUgbG9va3VwLg0KDQo+IC0gICAgICAgICAgICBiYi5w
cm9jZXNzLnJ1bignY2htb2QgdStydyAtUiAlcycgJSBzZWxmLnRlbXBkaXIpDQo+ICsgICAgICAg
ICAgICBiYi5wcm9jZXNzLnJ1bignY2htb2QgLVIgdStydyAlcycgJSBzZWxmLnRlbXBkaXIpDQoN
ClNlcGFyYXRlIGNvbW1pdCBwbGVhc2UsIGFzIHRoaXMgaXMgdW5yZWxhdGVkIHRvIGNyYXRlIHJl
Z2lzdHJ5IGZldGNoaW5nLiAgQWxzbywgYXMgeW914oCZcmUgY2hhbmdpbmcgdGhpcyBjb21tYW5k
IHBsZWFzZSBzd2l0Y2ggaXQgdG8gdXNlIGEgbGlzdCBpbnN0ZWFkIG9mIGEgc3RyaW5nLCB0aGF0
IGlzIFvigJhjaG1vZOKAmSwg4oCYLVLigJksIOKAmHUrcnfigJksIHNlbGYudGVtcGRpcl0uDQoN
Ck1hbnkgdGhhbmtzIGZvciB3cml0aW5nIGFuIGFjdHVhbCB0ZXN0IGNhc2UhDQoNClRoYW5rcywN
ClJvc3M=

