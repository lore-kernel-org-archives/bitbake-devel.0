Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4824FF8868
	for <webhook@archiver.kernel.org>; Mon, 27 Apr 2026 20:27:00 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.39])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5349.1777321611028098927
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Apr 2026 13:26:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=YPxaJvK1;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=YPxaJvK1;
 spf=pass (domain: arm.com, ip: 52.101.83.39, mailfrom: ross.burton@arm.com)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=d4lpum9/sQDnaOY1T97cpkT/bEIOEeBn2uTbNq2FzUYZrVeNVod2EowXzpxoAdOtM8h7uNAigZr+63mZBjhtNQwX+9AoPIWty8UQk33audNg+wEhei/8a7FrGV2uLlHipW91wQQHcyPOiSAvEZwyd9cGURpqyk49UCwY2xkk2QbUJwdwU3pT1C+5+2tkZJNfeHpNYR+BdTM3fpxwEhLwLsCaUNBmO7ZN6fAGDlxBxzTf8E8ppnGzIUASDJLnf+GyMkTcHQ/8W3ahovZObIIKEbfCKpi2dWVq6F20NSbKWys6HoLrNfn9jDiXLVxDmcwkOM653sk/naXoHSHy6Vyr+Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBKWsshrY92MGReOK6RRAYbHMkGHZ69DpsgmvJc+1LY=;
 b=vP+IF5h9TAwJ+DmBjCZBEOWXchU4TZe/tkgTDDzStwZotgUVWLqSzqpUmsOrzRIU7Ls5+7DceqX8NDFMH8NPgDW8oXu2irkVeMobMrR5Fxu1gFD0YO4YE+AR/ejSOhH6UkpyD4NVqSzWC9nscraG1aQt1mKUfpS6drcdyUYLAX8xm4U9zSgGMh9+p4x/721iJg3ztKfmcuKcjiwDp1YSTGbuJ7kDurkipByOfRgU3yacXr9OIIwMaWylgme8kt5mnFRQG+3R9BnlAaVCiHvOin1an6BCJp3fs1rQnnSaA6jdBOEANWSwyhYa4pXG5nrM6yBp351E8NZSmbEXP8pGvQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=cherry.de smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBKWsshrY92MGReOK6RRAYbHMkGHZ69DpsgmvJc+1LY=;
 b=YPxaJvK1rg5il+ZqGFnsp22X01cFp+y1w9HIxNS5EE+NnjJ1i+uvq6XINCNHFuCmtURObvdSxAtcHH4UADfw9veUarFVvprRY8L+/HcUxTXnHmkJ1HXiTkmF6a4w1jsN6m/9vf6yrJHhWgQOulg7jewh4IhxNu4b+CosJuyCcp0=
Received: from DUZPR01CA0052.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::8) by PAWPR08MB9544.eurprd08.prod.outlook.com
 (2603:10a6:102:2f2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 20:26:46 +0000
Received: from DB1PEPF000509FA.eurprd03.prod.outlook.com
 (2603:10a6:10:469:cafe::16) by DUZPR01CA0052.outlook.office365.com
 (2603:10a6:10:469::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 20:26:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509FA.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Mon, 27 Apr 2026 20:26:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P9PHis4LZ408tDcX4OFXPSY0B0b7ZgE//FpnDfHCY8+y71oZW1YEx1Z85IxPoyOX1tKg74DCtkpsshmVaQ1kvHhcRLTT7jMvww60UP0kOp1LwuGvKCbIyDMbxMMTYN9HKZnzVPHNB+SSBzBYTwUTbk19tvILUODwGZo1nDaSjn/B0q1QlWAY4lvhRkO3CKY5L2v7yJwWZR8wEQB/wOjbABHdR/q86yP9g14oERpARv7CQw9jfdI1zc1mk1w6b/c/zai5ekawcLlZOasa7OsThykWVFZSvPckEIrqBa1Gcu5OrB5SWT7Gq6TZw4R9Npk0HgMhBeVl20T5e5mpgefDxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBKWsshrY92MGReOK6RRAYbHMkGHZ69DpsgmvJc+1LY=;
 b=cEnwVCriZr05sqEByqj0Wl2187Kqu2Wvh3FZ8J211GvSTtw7vn6W7x+fokHdixUgOQ6F3t4WCKFjuJLvYw1CoC8lk6dtvWrhIrgneA6XD4wK+8C1MVsAMD+GW7Yz1UB/CqLokqkj/VT7vXrtozfMTm8Kpn5u2DWc7kZNkr/ezdT5HwOnRq6kjsNb2cfrxhoOShfYymXJEqkrjTRxygkRURfsCKxZk4WlRhqIzUiy6Mc070hPcIOHvhN0gCiP33aFgUZGwnQX2TApvzHysaK6ASImpMeYUl9trP4tNaXGwT4Rr/q1u4Htfc63zso+9vNaJ9lo2Vi6piqT6ruIDDHdZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBKWsshrY92MGReOK6RRAYbHMkGHZ69DpsgmvJc+1LY=;
 b=YPxaJvK1rg5il+ZqGFnsp22X01cFp+y1w9HIxNS5EE+NnjJ1i+uvq6XINCNHFuCmtURObvdSxAtcHH4UADfw9veUarFVvprRY8L+/HcUxTXnHmkJ1HXiTkmF6a4w1jsN6m/9vf6yrJHhWgQOulg7jewh4IhxNu4b+CosJuyCcp0=
Received: from AM9PR08MB6258.eurprd08.prod.outlook.com (2603:10a6:20b:287::19)
 by PAWPR08MB10922.eurprd08.prod.outlook.com (2603:10a6:102:46b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 20:25:41 +0000
Received: from AM9PR08MB6258.eurprd08.prod.outlook.com
 ([fe80::171d:1f8b:720d:7a1b]) by AM9PR08MB6258.eurprd08.prod.outlook.com
 ([fe80::171d:1f8b:720d:7a1b%6]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 20:25:41 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: "quentin.schulz@cherry.de" <quentin.schulz@cherry.de>
CC: "johan.anderholm@axis.com" <johan.anderholm@axis.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH 0/1] crates.io data access policy
Thread-Topic: [bitbake-devel] [PATCH 0/1] crates.io data access policy
Thread-Index: AQHc1kz+R+z6SrN+S0aMGeDp1+dCCrXzK8uAgAAvlgA=
Date: Mon, 27 Apr 2026 20:25:41 +0000
Message-ID: <0839CEDA-841B-4A8F-91E9-E229A20C434D@arm.com>
References: <20260427135122.1504143-1-johanam@axis.com>
 <9abe98c8-4f08-4d34-9e16-52e21e874066@cherry.de>
In-Reply-To: <9abe98c8-4f08-4d34-9e16-52e21e874066@cherry.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3826.700.81.1.6)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	AM9PR08MB6258:EE_|PAWPR08MB10922:EE_|DB1PEPF000509FA:EE_|PAWPR08MB9544:EE_
X-MS-Office365-Filtering-Correlation-Id: 02581281-72fe-429c-d90d-08dea49b4d50
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info-Original: 
 myeWVKwi2xvmCiTa3LeWvTDKmF5g7nHTKrI4gQzP778krWa6aOjAwdwCWbZwHZgFNfxr+OSbObBzvs19WtgBrLuYUNr52jz75uw+R6JqjFEzZTc8K+IdtG8jip9iCPcsa+CgyEfRORcgtI/Cea0a2+NDr4I16s0rcEXQ+Pt26uEx/wLfyk953+Z5BH32w6WT8r9Xd5b9xO3PrYe7WWXOE7m5hHQVkISRPdQCvYZNr+uVUwzO+iavpnQ/6RYSw8GufeEz/jzZIwkxOdC3B1ckJEvSkDDuIfxH9DIqeU/tFbwCo4zSWbKtr71h3thproCm6wGIxsl74KL0QwMmZYZXdhv52N8lqJ/5djiSs7n+CBa/rESYFjRuD1+0g0x12tnQfNCYPsE8aghqdK/Evm4xArrxhhEf1doN3mvYX1fiY/DNOPVVUlWDbVVzCIieSHvQesZxxgJA3NhUi2Dgdym6TClSS6YobjaR2JYQSqZIGQ1dGAMyXc2DukFxq6x2UdrcCg4pSnw6lDdFIguOUf5bfBqdsZ7VQTJJnerDURbKHbgGSHkg7Ok23BS0FoayVfwVZKqdbfTJ72Kn4IKz0OIwI8v9uK4IPyJE5qBJYmxFystLBB6SgvYx7wyjsvpsodlKJCwm1OGpb0tKlfbX+grrUaC4kpULtkYKFEhoL7fQbzlHk2CZ7omSmq/3hBDcHi1oHq0NFVpFUkBQb82VsSgx5WI7uLOVOIf0h0nZiPMolvImfbYNXiToU9ARhFWApaLuY3QcsqTyNOvTpUi4QtJgP7uQ0DOLUC9/WmjausiMq84=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6258.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <25524DE7AC5A03448533EB7B118F378F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
 M7Nli26jeZszSbiEVQED9u9dkuiy6fccZ2Dnke69XlC6tuyrt2Wd45tcTEJABmdzbhycbVpz6gpUx7MTBGJlZf8kviaMWL3Vl4FtL8MPJe31jBnCnoJipFka21PO5HmaDOJlWac5H3mlnD6vscMhCAvB2/1LPD1ZcJr7SxS+IUhRkdhJD/DcWOuxLuh67tXdOWtedl59mcWF4H00SlffIwVKK5wRuaDvwbhQcWyulj8VXlEVoU5ibgKFDrPmH4y5sn0yrUrde7dNaXVTiLcWQt9Rr5oW4QVP7LQVBZWbplCMPU1tHKsowvnw4cR5RiQf0wRoPBsVeOberYf93RBCdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10922
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 DB1PEPF000509FA.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	0c644e00-cc0e-4087-40c7-08dea49b26f7
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|14060799003|35042699022|82310400026|1800799024|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	vGeJWI1XztcoavM1lclbnVpOrsR7KuVUl67zpYTc2Oi0v/Z/LFXA5d4pP/S9W2L6SWfCxnnXphTZZn8ww//LBXqFnFEB+emi/5MIBSga2JQO6OgrG/fM49bWMnWRuwDfqwBACBGzE6XH+UPvf47B85LzhVoDJSJBSNuh2wDIjUt5eE4Awe5jzKcw2uhUrNDPYiaxM+0vmjQaGZNu9ZVNy59e7MoEnGi/T+aYY2xRtm+iSUTjRDBwBQVRdAWSsAvGek+wawx0qQxaAb7KSI42rJllHQxcA7jeEHl/NjMpu9jMx91+O8PM86t+cRc430yw8+5OQv2Bwt+zpN6+jz7fI2uhqMbxz6GkYHTuRH1i8AdSwmxB4wuXiO7VTyoWJxbvpORl0r8knXa8DYQSW6B0xWA3NwUm7ol02d9EOIYz3Gyr4CrUvpJy6KKZOqWEb06cl0V6AXMDWLtW76+5RSqAqmlHAJytvcZNqRap9oEapXqParVnCGVVhUf7SX+AkGHn/KdqjhWczyUk1yUUFFa+T7UuV0edaiQyjmyXy1m10T9WIykL8I/CHs5Fh9a8c5SSPrtOTL1r9/KweA/wKNg6IDv6GtcwLCNGownW/hrJHrSy70TmFN88w1Lnl1qhhTd5GxsUNivJbpmzn0Sc1BudrpMesdbH/UAyEoDywSZeJ3+WawA+Jn3Th+5gVlq9ZNX1BAQhU2VFRFrdjoRP+i63YC4gQSRYAWwmkIBn+1JicaXRUpwTmqWjBLlo9T2WAMrHA1cjkcoODgILi/bPrcsV2Q==
X-Forefront-Antispam-Report: 
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(14060799003)(35042699022)(82310400026)(1800799024)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	DXmxAR0tDiwjM5hUw/czC0ndPrKIfyE+2gG9wc6ZmcpCOg58YPKZ21+iox9LAxPPJlHs6ZW4tNsz4S1PNC7/8EasVdKr77mu9qmdfDsY2hIaMwJIx8Ieciyw6HxWSiw0v1fzLnLXwe3wFhB+3GcdA2Q4r96lCSMkHcPhU0MNQDJTgeF8dump5u0ehMR75bukv7rZ06/rT4m/XyioSQq4t06jVwhMIfQNeFcLAt6kHUXxcW8DxicJrLh6fjIjhUc8kcDJ7lQFo8GjUz+SdiiXR1G1roOonztPSESVyqEgAD8arXy5dYBKyYK/MhWeZh3OGyLtm3dK4/HJM+atX28vdFOe/hl0hTy12KPYIWi0FVLTgL0PTE9nr4RisnYqUMYhGJfWjqtqOnN8dboM2Nec6ifZ94NNg1Ba3ku7yDKpoEo9JH606+w30MWCon08UYLV
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 20:26:45.6049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02581281-72fe-429c-d90d-08dea49b4d50
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB1PEPF000509FA.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9544
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 Apr 2026 20:27:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19399

T24gMjcgQXByIDIwMjYsIGF0IDE4OjM1LCBRdWVudGluIFNjaHVseiB2aWEgbGlzdHMub3BlbmVt
YmVkZGVkLm9yZyA8cXVlbnRpbi5zY2h1bHo9Y2hlcnJ5LmRlQGxpc3RzLm9wZW5lbWJlZGRlZC5v
cmc+IHdyb3RlOg0KPiANCj4gVGhlIGNyYXRlIGZldGNoZXIgaXMgZGVyaXZlZCBmcm9tIHRoZSB3
Z2V0IGZldGNoIG1ldGhvZCB3aGljaCBkb2VzIHNlZW0gdG8gaW1wbGVtZW50IGEgVUEgcmVwb3J0
aW5nIGJpdGJha2UgYW5kIGl0cyB2ZXJzaW9uLCBzZWUgMjM0ZjllODEwNDk0ICgiZmV0Y2gyL3dn
ZXQ6IHNldCBVc2VyLUFnZW50IHRvICdiaXRiYWtlL3ZlcnNpb24nIGluIGNoZWNrc3RhdHVzKCki
KS4gVGhlIGJlc3QgdGhpbmcgd291bGQgYmUgdG8gdHJ5IHlvdXJzZWxmIChJJ20gYXNzdW1pbmcg
aGF2aW5nIGEgd2Vic2VydmVyIHlvdSBjb250cm9sIGFuZCBjaGFuZ2UgdGhlIGZldGNoZXIgdG8g
dXNlIHlvdXIgbG9jYWwgd2Vic2VydmVyIChvciBwb3NzaWJseSBldmVuIHNldHRpbmcgdXAgYSBQ
UkVNSVJST1JTIGZvciBjcmF0ZXMpKS4NCg0KVGhhdOKAmXMgY2hlY2tzdGF0dXMsIG5vdCB0aGUg
YWN0dWFsIGZldGNoLg0KDQpQdXQgdGhpcyBvbiB0aGUgbGlzdCBvZiByZWFzb25zIHdoeSBJIGRp
c2xpa2UgdGhlIHdnZXQgZmV0Y2hlcjogdHdvIGVudGlyZWx5IGRpc3RpbmN0IGNvZGVwYXRocy4N
Cg0KUm9zcw==

