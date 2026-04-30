Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16094CCFA13
	for <webhook@archiver.kernel.org>; Thu, 30 Apr 2026 10:10:51 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16870.1777543846818016415
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Apr 2026 03:10:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=SM046X8L;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=SM046X8L;
 spf=pass (domain: arm.com, ip: 52.101.66.47, mailfrom: ross.burton@arm.com)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Os1bUEPUXu0/5CbVPg4O0ohKfvOyOYD4l+N/oqrTazLMcK4yVJEI5azSo+fcfTNa6/AGcR4RkrngsC0A9H7hv+aivl9Qr+wcgiaeVqNCPK5KJHkOtMgp4klud4kHgkRXwB12MfiBzrzXMo9QJzRzZDnTtcIal/hn2teAKncDviZSsSBs77UgTqsUHcH0XMiJYI5lJ1WkPB7K13Rosl8MPGSAJlc2fBDQXi4XgKskyIWu8fU1S+4oNTfTLOKbb2FaWTUecl2l4xxHt1bpVfsUkEa2zpRUWODVT2oCz0iqbzHi8m5G4nyBLBtepE7aS5zGIIE3XUPNfuzj3KI6T276OQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSoTgjt1qpRYQgK6DvmZkbsR4oAYes7aQ8z/PhY8AN4=;
 b=HaD89HJKOHNZ23Tp3x6hPnMvKg/tNaGJ8IdL5Y3qx6wSXmDqxd2lWjsDuP74gTl5Ncl9iMYoiZjAtIqkwde2tggJ4ns56w0u3xQppcDKaRu/ZMXHe4XDBRY2PdM5U9NtX7ehEWgVeKXAq6a2vIWCYti00CqZ6P7fc2LR36Y+0tFeauFxp4iyiTANkdbo+UjTJrgrxMXUb1eQkTqxyqTZs+tujToZret6YJU4EpTZbwQPrEcrFEALwRit8RnCwfrolcjhaZINfrE1e6/sLYTwtVTXmBPX3MOr2TD+fXhFLmkWfJ7cXl73R8/i/YqGZQOwBQwke5B+rTIItX/RgtcK7w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=windriver.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSoTgjt1qpRYQgK6DvmZkbsR4oAYes7aQ8z/PhY8AN4=;
 b=SM046X8L5lnN8pE9jQ0Y1pen+0L/IHX3O+bw8M/XmZpvS1tHst0e8sAnL2Dwl/sNC30eZaqK9/DG0RiEg4TTXP0ZrRw+nLj21gxMExQ7OP6YdpuOz4+ndfOYG33e2gwWhXJRqE2VeKZ5FwCx4JXOIMF+CE1SNmlLHMYdgbsziPI=
Received: from CWLP265CA0291.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5d::15)
 by AM0PR08MB5459.eurprd08.prod.outlook.com (2603:10a6:208:186::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 10:10:39 +0000
Received: from AM1PEPF000252DA.eurprd07.prod.outlook.com
 (2603:10a6:401:5d:cafe::e2) by CWLP265CA0291.outlook.office365.com
 (2603:10a6:401:5d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 10:10:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM1PEPF000252DA.mail.protection.outlook.com (10.167.16.52) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Thu, 30 Apr 2026 10:10:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WCAwAf84431NZSmI48yUiVEuVZbf1fx2HhqmlIobXmxp8AfqqIEHNXmvrVwOjunthDqkrym5TVFuslWqLFY9H8zQD3r4E3sBazUS4uezQLneDrIe3ytXnn2exwYqItYqRwmdndQcxNWyqhl2/IMXeNyvaIHA+rMiy6UFlt4kEycHXgKFj/suGCK/gq7HVbtQGSsKfatFzI3YmQBqQgqKfAJvBMcV/+KaKaiCC/a80UGLhYi+N4fTTke6C7VfGx3UG4SI7U7qEKOMJrZCSInZWSDGj4/NCI9OvsRwpOe3Axcn2+p/uZRgaWDPUQta7YoIP0F7TfKwY+sTOLXURaztWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSoTgjt1qpRYQgK6DvmZkbsR4oAYes7aQ8z/PhY8AN4=;
 b=W7RzD+2W7RC1O3y6rPmLjcCCVQB1qzMw3qyugxXLhuRTLb77gsQCbXt1jQlmU4uICjlVwIDLnuPOGiwvbjs6qETCrrqtDg0cMUbBomayCThiVxvrNALmPEwwN08vArWZODMsnmt3Ik1x1dWQO5FPBmF3fAi85SBfSjLMDbqJrvyAOSNHduqLEnc0bPB+iED26efLzgDd2IZlVEgZFFrCAeij9WpTaBdUbm5qcat6yAYtge6APfWdx5LfOa0fDclLdxVxaKXgHGnWOvZfoalPX93afT359u1wg9kLHl6MUT98a0FAyXsEoHAEMgq6G+jNaPejRlHy5EWjl+x5Dt+FLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSoTgjt1qpRYQgK6DvmZkbsR4oAYes7aQ8z/PhY8AN4=;
 b=SM046X8L5lnN8pE9jQ0Y1pen+0L/IHX3O+bw8M/XmZpvS1tHst0e8sAnL2Dwl/sNC30eZaqK9/DG0RiEg4TTXP0ZrRw+nLj21gxMExQ7OP6YdpuOz4+ndfOYG33e2gwWhXJRqE2VeKZ5FwCx4JXOIMF+CE1SNmlLHMYdgbsziPI=
Received: from AM9PR08MB6258.eurprd08.prod.outlook.com (2603:10a6:20b:287::19)
 by AS8PR08MB7912.eurprd08.prod.outlook.com (2603:10a6:20b:52b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 10:09:35 +0000
Received: from AM9PR08MB6258.eurprd08.prod.outlook.com
 ([fe80::171d:1f8b:720d:7a1b]) by AM9PR08MB6258.eurprd08.prod.outlook.com
 ([fe80::171d:1f8b:720d:7a1b%6]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 10:09:34 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: "rob.woolley@windriver.com" <rob.woolley@windriver.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH 5/6] lib: Vendorize bundled third-party
 libraries under bb._vendor
Thread-Topic: [bitbake-devel] [PATCH 5/6] lib: Vendorize bundled third-party
 libraries under bb._vendor
Thread-Index: AQHcwR4sou+Z+KpJqkyOnP9kqYXKnbX3kJoA
Date: Thu, 30 Apr 2026 10:09:34 +0000
Message-ID: <5A75C01A-3B75-4531-AEEE-63A308978CF7@arm.com>
References: <20260331145319.3125456-1-rob.woolley@windriver.com>
 <20260331145319.3125456-6-rob.woolley@windriver.com>
In-Reply-To: <20260331145319.3125456-6-rob.woolley@windriver.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3826.700.81.1.6)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	AM9PR08MB6258:EE_|AS8PR08MB7912:EE_|AM1PEPF000252DA:EE_|AM0PR08MB5459:EE_
X-MS-Office365-Filtering-Correlation-Id: 7781484c-a25d-4e79-34ff-08dea6a0ba48
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003|38070700021;
X-Microsoft-Antispam-Message-Info-Original: 
 v6ZJQUkAXC/5e3xIDzC3toXqyY6Q/bubsYPgbLGViIglArwUTrQoMbC4gzzAotw+lxSU2WMNeCXRD+N7yaLs1HLbAUUAR/6Jq5lort0zZ+zQjeRuiGNm8+BbVYtB+K0UPY0vSWgdRjc7ckXOLy2y00C4bqQ01+KgAJNdihwvh2oOPvWubc0mDKrpbPHSbbNbD3koXPPACzatMPnVaY30Ovu7dGTFKUKLk+iUsrSbsvC7lm1CvgpnPvU5wmx9Hvb7xoFGfV4lzYo2jPE5m0pwcrqCt7lYdvlMrV7fN+MB+wO6+KOhhqcILLAimeZElnysoaer9MOpT9qeRg/XJ+Hu9PBurXX0wqoldXy7xMNH105dOrE+69h2j3iuXt39hLZU2Diu3gXkRNTOOu4u7jaemH2wQQTekna/MsTBr719MlOk423bQTOJM1W3aTs/j7DaMUk1IIjSqn1H92+7pj3E/TNdc3WLuPk88l0N1k6TYj2drO2nIu9mx3Muy3WMe0C1XqSLaoAXQO0qom8R3SmhcDu2g7ZKoxlxrNXl4tvGB0ADL6rpxIR0rfz9yvFZQMgbW5p63LkLcgl1EL7KBofCrCU1XTvwb9wM/ibzmztxIuUBK2avySvAsFA8YgcPx6AEltlePP9dbjvNYWrhDFlSud8NLVJOabmjKf1YPvrEFNbedbO+lThoCUSBrt8/+GtqgASZGAbhJnL0L3qJ/Ig2rhtf2m2BLI7kF9WUdLZWjyz/SsfVvYYsuP8x9wcxTEcz
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6258.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <B31EA15237FC7F48AAD2257109666F73@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
 ptEuRQLiMuvYKni0hdhOesFPATKWi3N/BNTU2s9MaYOAKE6d9G5zXE3lU8Af7lrXtM1q7B3JJf1CEbKtUwhlgJB4pCbRMIUizup2+p8aIeihygG4ShAiTXmaKpZmaEFZfdceSdKvZelWOtpbMK07Q+l+8fqjPm8TiBVfhuEIl3olo2v0HFjQSWTu3YQNVulHmv5EjILNRMEO78yHAJudkQYqOGanAjWGNfeBjVu9xKInRYkGua/isph12rA4KCK4HxYc6yTGeMrjzzPMJcP3ZLc517uEy/YJ4WR0bYNmMOb+W4/iXALB4GmkEh1mzrUT7G2MoXRQTXHQ0fFfHmHJRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7912
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 AM1PEPF000252DA.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	17b11f80-7a64-44e6-c8d3-08dea6a09448
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|14060799003|1800799024|35042699022|82310400026|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	RCZjvYQRlAex2X7H1BFDMp93JxPIYyXgNtqPLFWjTUc9x+y1XfSb+qzKC19rZJUWE+jUUa06Glmvz+DgVT/mx6wG280t6uDXQ5w6fqq82aC0rB4ZU7rQ65jkubMS4OqwhcHXu2lzFibJskIcO0DGNpTJ3DgUfV5D61XaL9ejuIwp9YeQ8w5jGigIlKAKXcRWvr2snYdBVjgXn/6ENoiKWdKM/X0gCWG9abCWRsHbffgPv+KmwThunSVqI0iIN7Qc2sqsnD7N4IDRyKwARAGJ5S3UW0hBZSJXT8FWjC82k9iVjPtBLBIw47XcAV14AliFDIcN53HYKA76/mVnFlFIKV4DnCp9rBE38ezr86+iB8hZ1unJlVcP1WikvbC2wNog78orckmxaHKYwHzGdTbikRZsqB2Ju77twfkdo7O7bp2YsjIsg5AyssuBFglAbcLdl9HHucZP4UUf0RbX77YCI1WeAC4nYvBo0oMgR90V5Ii9iY28gV6AYLkh2XiA1aNiSBImwahagcqEeM5Jmg1lM2ka7wR7N0HT+dLC6unnsmc5oQYvBh5cjZ4zsrxhrEbSQ502AMaIeN/vE4qn1ll1dSQ/MjSbZ7Pvv6pT3mErXnyCSaZmKVDogVyOHcYreqqeMaAXyQdWdYal+36Pa0cY7sezgILUpGHvYumZDMLTKs0/1aUY03DVbEIjzdZ/cX8QCnJ6AYf6afYT4yN1jkClev/1Ilfhck5MXEgyGP2H/vs=
X-Forefront-Antispam-Report: 
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(14060799003)(1800799024)(35042699022)(82310400026)(36860700016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	CnCp09cw9ryiOv0lm9CUXO1bGld9iLFgYX/q2r2eKRKe4DRcVEC8dvHQsHDdoo3onOsbTHtGc5rBTi2UygCGQZrBJ59HkETqI1N8DQ1GBGDRWKG35P+xAUYWnYpxKTW+JchbjTtIlIBZOr6+yaOt/oNy57NU/DxFYipyDoYuQxCDqywO18pAr/sSa0ymv2PTb7+BRgFXGxExLUmYygP7i8ThvcIKJszq+UpoT9QolOvn51ERYoEoqR1fv9tZBmHeQBOxpj7xTQe1l5iDuowKXvMMgy3oWcDeC6mheJNecdLCXIj1rtAzFqKPyhLUNWv9yyj7GCf6cU6mtYkhvAKduAtynwkjT9hYWdOdmr7zbwofY4Tv1ViqALh6GLEGUgPlzjlC8EzSFK0sKpXAn5gGHp8mxJv8z5M5LsZcFkMyFoCf3cG8K0G+7ERuLvSPPkOL
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 10:10:38.3070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7781484c-a25d-4e79-34ff-08dea6a0ba48
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM1PEPF000252DA.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5459
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 30 Apr 2026 10:10:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19419

T24gMzEgTWFyIDIwMjYsIGF0IDE1OjUzLCBSb2IgV29vbGxleSB2aWEgbGlzdHMub3BlbmVtYmVk
ZGVkLm9yZyA8cm9iLndvb2xsZXk9d2luZHJpdmVyLmNvbUBsaXN0cy5vcGVuZW1iZWRkZWQub3Jn
PiB3cm90ZToNCj4gDQo+IE1vdmUgcGx5LCBwcm9ncmVzc2Jhciwgc2ltcGxlZGlmZiwgYW5kIGJz
NCBmcm9tIGxpYi8gaW50bw0KPiBsaWIvYmIvX3ZlbmRvci8gdG8gYXZvaWQgY29uZmxpY3RzIHdp
dGggc3lzdGVtLWluc3RhbGxlZCB2ZXJzaW9ucw0KPiBhbmQgdG8gc3VwcG9ydCBwcm9wZXIgcGFj
a2FnaW5nLiBUaGVzZSBsaWJyYXJpZXMgY29udGFpbiBsb2NhbA0KPiBtb2RpZmljYXRpb25zIGZy
b20gdGhlaXIgdXBzdHJlYW0gdmVyc2lvbnMuDQoNCknigJlkIGxpa2UgdG8gc2VlIHRoZSB2ZW5k
b3JpbmcgZG9uZSB3aXRoIGEgdG9vbCB0aGF0IGxldHMgdXMgdXBkYXRlIHRoZSBidW5kbGVkIGxp
YnJhcmllcyBlYXNpbHkgaW4gdGhlIGZ1dHVyZSwgdG8gYmUgaG9uZXN0Lg0KDQpXaGVuIEkgd3Jv
dGUgcGljb2J1aWxkIChub3cgcmVkdW5kYW50IGFzIHB5cGEvYnVpbGQgY2FuIGJvb3RzdHJhcCBp
dHNlbGYpIEkgdXNlZCB0aGUgc2FtZSB0b29sIHRoYXQgcGlwIHVzZXMgdG8gdmVuZG9yIGl0cyBk
ZXBlbmRlbmNpZXM6IGh0dHBzOi8vZ2l0aHViLmNvbS9wcmFkeXVuc2cvdmVuZG9yaW5nLiAgU28g
aHR0cHM6Ly9naXRsYWIuY29tL3Jvc3NidXJ0b24vcGljb2J1aWxkIGlzIGEgbWluaW1hbCBleGFt
cGxlIG9mIHVzaW5nIHZlbmRvcmluZzogYSBmZXcgbGluZXMgb2YgY29uZmlndXJhdGlvbiBpbiBw
eXByb2plY3QudG9tbCBhbmQgYSBzZXBhcmF0ZSByZXF1aXJlbWVudHMgZmlsZS4NCg0KT2J2aW91
c2x5IGlmIHdlIHN5bmMgZnJvbSB1cHN0cmVhbSB3ZeKAmWxsIGRyb3Agb3VyIGxvY2FsIGNoYW5n
ZXMsIHNvIHRoZSBxdWVzdGlvbiB0aGVuIGlzIHdoeSBkbyB3ZSBoYXZlIGZvcmtzPyAgTm90ZSB0
aGF0IHZlbmRvcmluZyBjYW4gYXBwbHkgcGF0Y2hlcyB3aGVuIGl0IHVwZGF0ZXMsIHNvIGlmIHRo
ZXJl4oCZcyBhIHNpbXBsZSBidXQgbm90LXVwc3RyZWFtYWJsZSBjaGFuZ2Ugd2UgY2FuIGNhcnJ5
IHRoZSBwYXRjaCBpbi10cmVlLg0KDQpSb3Nz

