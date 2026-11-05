Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.39])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.35090.1793886956160056870
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Nov 2026 05:55:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=d2fSpPto;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=d2fSpPto;
 spf=pass (domain: arm.com, ip: 40.107.159.39, mailfrom: ross.burton@arm.com)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=y6g/GH462wIaNWacOLxLX8dxec6zllpcfNmHmsrHYZhVs13MsHBo5Qp3BwyCfBzYuMFTMsl7uDmChjgY/reId9gyBFDqJ+Rid7kVQf/VnjP5XQSCRC9rQu0NHjjacShpLgEG+TAJlPHvm0dtQDUAVJADmyIa5YJlYlkVlFO+cyRvvIVY1zMhJXzFhY/ccr8eVVwj45RFywiBpyuyf83XudcvxHK+4IT2TQaT61zA9t4H0rNv2knFLDjiiAq9/LtBn8IG/CwopP61gHUcwbu0WSqypIZbox/13i5KaGxSGZqRosFxEhe16fikoS0tKlpwKMKdBaKhfM3lo7hgm3ykGw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewEN4RwhxavhQa9MQs1naWMu/KtaMFKqHQ4biLIt/ms=;
 b=CASx8EWtcN3T+KpZSkMPcqglmxrTVlZaez5SPdw+4FRFxmO7l0BLjua1PZFfsZV1g9CAeOjn3lncY/uNOWfyX11Az9ELYqwtMHEqGnH1TpmfUqZcJNGKjounN5gf6rAM74tbGO6xRsNJEBKND2wrk2L77yK+T4SmPFx5IER4v78XOgARc1sbToGqc0iHe/3hpHnWVPyXQAXBhH+/okIoV0Kx2iAaK+BOTW6f0mN2iCD1alxO6RKdahHLscAZGjUuA3ZB9l8Y6oqFao721obA62bx0VcpqCXGw6jzPddHBHL8X6NKR5JfTn/qwBqsY2tkgxkdkZ3bkaR9btYLch2LeA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lab126.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewEN4RwhxavhQa9MQs1naWMu/KtaMFKqHQ4biLIt/ms=;
 b=d2fSpPtog4wZf4+DT5JghxzacQco5TSZFWRNwpoaTffJsCcBZ0ndScBVD8SVVJf/xc/vN3C8JfaiaIJL2vtiJBsWQslWaeFD/YOiNuGTZqS7gZ0DjkG40VgkAVdXw06cZqxJMUESACo3d97PL/x5iLepieQCyLRqEONFVz+r/cc=
Received: from AS4P191CA0040.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:657::9)
 by DU0PR08MB8256.eurprd08.prod.outlook.com (2603:10a6:10:410::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 13:55:51 +0000
Received: from AMS0EPF0000056C.eurprd02.prod.outlook.com
 (2603:10a6:20b:657:cafe::14) by AS4P191CA0040.outlook.office365.com
 (2603:10a6:20b:657::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 13:55:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF0000056C.mail.protection.outlook.com (10.167.242.122) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Thu, 5 Nov 2026 13:55:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZ5f/J9Ik+hCKqtJ/wJyqOOTnEypEFiNS4cTn9VClIZLPUjaRRvbNsb1jD+AKNkDrDj1hT6kdjpsp3gYSuYJkDxrEur0u1fQpYY0IwK+vYfbIDzX+4am9+7Il+44u3KHdRqMiPJqNeOhk3OazdqLyDHzNLp7IpXcKpVnFxxdzvexyHWrMjfWX8a5BHwIFkUefeHOb4yfYsBKcjieUh6duvMr9VGqlude05w5mct/xkyY7xw/uh0ML2pGsc9fkmY14T+iFemAiuNfuNYbTNLocyI/DhglnjJQiulGNk0o2y7jQVPEUQCZVWVnXp+63c14OQ/TrfSqATLZI1dVc4KD3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewEN4RwhxavhQa9MQs1naWMu/KtaMFKqHQ4biLIt/ms=;
 b=fHS5RQNkmVyCg1kAka6/BzOdatEwxO6kDd9N49KmGwUol17h0VOXxSXz/cbUcSDjeipiBS+7AxvFgOthoTHHshd+On5lyq7++/h8iAOOaqFA6jH29Qcu1e3QHUSl5JXhbkECRZlO+tyECZjpqAG4v4uXJqNY9kX88vnaw+cFPBdFZ7TvOui7NLDxJWM+y/p9QMcR5J7vxjx0kbkDO1CL13gLBWUvWxZi/ne/SWIPcGVYCcL+82BlgB9r+/U9Fn/FjZhoEz3QxJqtmGq1lNE3CgpTH5E5LBlkcYXEOpWvWfr2k3aMCiEmlC6JciFRVNk+4oSgwznsbpPEuLo/WRXn8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewEN4RwhxavhQa9MQs1naWMu/KtaMFKqHQ4biLIt/ms=;
 b=d2fSpPtog4wZf4+DT5JghxzacQco5TSZFWRNwpoaTffJsCcBZ0ndScBVD8SVVJf/xc/vN3C8JfaiaIJL2vtiJBsWQslWaeFD/YOiNuGTZqS7gZ0DjkG40VgkAVdXw06cZqxJMUESACo3d97PL/x5iLepieQCyLRqEONFVz+r/cc=
Received: from AS8PR08MB9410.eurprd08.prod.outlook.com (2603:10a6:20b:5a9::13)
 by GV1PR08MB7330.eurprd08.prod.outlook.com (2603:10a6:150:1d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Thu, 5 Nov
 2026 13:55:17 +0000
Received: from AS8PR08MB9410.eurprd08.prod.outlook.com
 ([fe80::1f2c:bae7:a4d3:fefb]) by AS8PR08MB9410.eurprd08.prod.outlook.com
 ([fe80::1f2c:bae7:a4d3:fefb%5]) with mapi id 15.21.0546.012; Thu, 5 Nov 2026
 13:55:17 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: "kpoduval@lab126.com" <kpoduval@lab126.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, "armccurdy@gmail.com"
	<armccurdy@gmail.com>, "richard.purdie@linuxfoundation.org"
	<richard.purdie@linuxfoundation.org>,
	"stefan.herbrechtsmeier@weidmueller.com"
	<stefan.herbrechtsmeier@weidmueller.com>
Subject: Re: [bitbake-devel] [PATCH 1/1] fetch/s3: fetch via boto3 by default,
 falling back to the AWS CLI
Thread-Topic: [bitbake-devel] [PATCH 1/1] fetch/s3: fetch via boto3 by
 default, falling back to the AWS CLI
Thread-Index: AQHdbMSRzw9yvTf0YEK+sStmVuQ2mLcfgP6A
Date: Thu, 5 Nov 2026 13:55:17 +0000
Message-ID: <A62B91DA-FE71-4D0B-9672-1AFCF0C0A2CA@arm.com>
References: <20261105012522.878275-1-kpoduval@lab126.com>
 <20261105012522.878275-2-kpoduval@lab126.com>
In-Reply-To: <20261105012522.878275-2-kpoduval@lab126.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3864.700.51.1.3)
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: AS8PR08MB9410:EE_|GV1PR08MB7330:EE_|AMS0EPF0000056C:EE_|DU0PR08MB8256:EE_
X-MS-Office365-Filtering-Correlation-Id: d5e28719-f26b-4d17-8f9c-08df3b44805d
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|38070700021|56012099006|261102123227099003|261022075727099003|261026121527099003|261021121427099003|261026140227099003|261028144727099003|261022105027099003|10067099003|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info-Original: lwY3PZm0zKvCkmiF3SYEB1WIayfX7bwx2sPhDLtM0UoBxilWL6VvSoclOO+dSAqE9hE7gDX201Ot8QeIe4C8s9LJYHBUs6UAB01QXGd3i+DFXq5CsQ8iAdAeeFMh/V0wvWNL0l+OcMdA0vlEHF7vaMwu0SeaMppaBknm6tjIu6EVnIk7nNlzyASXhZlU+U3reGPl440PBgmQxmGPMM32WvkVPUNOIEdbG7nQwHIllaEwLjD2n31xC51NfFbs0902h+uSksuVNKwTeH4tg69S+aorzHIJBov8+b9RlF4xumjLtOtMpV7J0MNZLxm4lvriGnz2BV41mBlPgr83RUazwDth+JfP6MZOKolp7RlRjXrMlQuuOIGVsF0aZUvK9FS907eQxPREOkVHgYKNeXHVbYQ3hsULIPuwylwFvrHTGgE/toH+r28i6fnZgveUw0V47UXY4ZWfxd7DXyi5esKIa/H5KvutK7FHNsk0LcxAY4kHnrqwnQrv5HvAP6TeSUMUwsi4aldQ4Cj6+TbrTMspIapZm9ii0mDgED/bqO3/YtUnHokEOH2zsxFWxoS3AohiGf9tbSmqwPW2v/WEMNtEn6g9JFqhzwTfpQ5viyt/DUltecg6Ej/u8Ood7155LY06zFgw9JhmEmy6JmU1N0uKIXDZdyjf7TiMuA7wMSbwDSip1vswreVLQUIi3BkGXL/NwrYZSNQNjgwOJuMp5aaZMacPpX2fInN5xTZo4kMay4w=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB9410.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(38070700021)(56012099006)(261102123227099003)(261022075727099003)(261026121527099003)(261021121427099003)(261026140227099003)(261028144727099003)(261022105027099003)(10067099003)(11063799006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB0D5A259904624283047AF662C91AA6@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Yq1bfzoUA9EM4xEFk98ZPP+NAhvWJFn13mEzv8E1UGyc7AXtgIaCE3yi83O1WrYxQLxUwZCLPs5PP/yzVNBGeqZ/VEXTqeWm/n0eqGPXdKzd05H8AT7/m848EpqjDtzQb+/YtnCbz1+Y0na5SF3XHJ1xpnpjgzeBdvohdDM5X5VSRKL8EzpCVWqXuln0l4WfJxpJeg0fNRH8Av3vO6lDhtMzAow+fc5+0YH2Nu0mkc4Hc2HX9fYCI7LYVvLVa2la+kiyFcnGchePqgMPUcDvyBIj5BaZqSffOE1xoQuL2bQWQG/xAGX5U0Y2lfOnfHe3NBEHvAJ4kl5AOtcY2BYLJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7330
Return-Path: Ross.Burton@arm.com
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF0000056C.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 300a6835-252d-4dfa-b97e-08df3b446c74
X-Microsoft-Antispam: BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|14060799003|35042699022|18002099003|22082099003|6133799003|10067099003|4143699003|56012099006|11063799006|261026121527099003|261026140227099003|261028144727099003|261021121427099003|261102123227099003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: /JP8k/PqJRxkyEXGO/cS1fqgszfjAC5cWseyMat7/4ihJycLa/FiA6qNAEoXg2w/Lcjbi0yi4fmGRxrpQkx1AfqtheKjMLTyAJ7E9pqAPnGA3ObIHPwK2o2DMuHAuZrLPKMj4B2tJ4oVO5Sap3Z+n+0GYlF1jW+ESa7r1gpkQhEQxmeIIPmI2RQyGj/lCLzfO9RMqp6XuIpdEKDGDWDJEDcmnYfjWwTqgs8fODmQrHUQpbLkiGK7ArYzkGF5MPA6vgm4JuHxCHkwLBOtIDu/Ao/iLSHPSgPHHD/Irk1LprP9hqcI5QpyGJSF5+TakxOi2ey4Gz0t5xK4Jho/8jyvcZwpguKMmeYiBdvmiKhTLdlS+uApYX5yHAS//Vhpoi/oAGXROWHhBdr3XKM2PCcyhgQ2O3wsLpm/W3emM/77V20JoPU5VWrHzROUTf/tcKC+ZGoBKgXENsT/CieAIg4FuEg5IiAbgtXVEJ0T5WNp5A+HQEPciPXNfWQU5DECvQ7wJrbCXAaLNb0OGclCSeoBrVs6TeeuaujZCMGAnkknqe27QttRqB9XUBZaJSGlcK/UvvlVdHwgYlY5lw9XiMMDidQqm77BR/a9zICDIjQmPnNrkgmjSxLagfIKS6b78q2ouCFnfbCmEhz/eVKw5FYPzRGYvJiW9PdBBBvplDxi+/7XsceZxDWlKa9CDfflZjL2MJDNp/H13HQWRNrFjXDy3Q==
X-Forefront-Antispam-Report: CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(14060799003)(35042699022)(18002099003)(22082099003)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(261026121527099003)(261026140227099003)(261028144727099003)(261021121427099003)(261102123227099003)(261022105027099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: I7i7wHcHb7p2+sm0zLGcqjRNAFrnUhGMgKkqRbRwq5IkCC78MXz02+kfP5agiRHfOyC6t58CBeQZntJtru3Z2Hdmoph1ICy5TAZEsUwdCjXj5RdGsZI3Pq5Y4X1K78Nm/JllforY3RRLzzkHQWdtT02GuZ209/2flHGglyNC7WD6s0av4Kdfz7TFCzIxGEAmpMiy7Y/wlZlOtK698eQVNzG/bfblIFo2wtqCiGBhI+QZarHb9E4QWbt8v7sUVDQpp0GHdBOfMwEx/pV7mEQLQ2kfeaGJHa0MGWSvCsMQdjvoHel0xhxlL/4LaidGqYgRVFyg7OA3zk5uXQZcUYBwUB3iBH7xylgH/4UYL9pvjhkhueUQQcTWt9tmuBP9nx72YcaTUUocsnS3kamhWRXSO2pAOFjn9Ti77V/Nts8e6U13BoxHx4sh8UT4j8X/121I
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 13:55:50.6210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e28719-f26b-4d17-8f9c-08df3b44805d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000056C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8256
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Thu, 05 Nov 2026 13:55:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20398

SGkgS2FydGhpaywNCg0KSSBoYXZlIG5vIHByb2JsZW0gd2l0aCB0aGUgY2hvaWNlIG9mIHVzaW5n
IGJvdG8gb3ZlciB0aGUgQ0xJLCAgdGhlIHBlcmZvcm1hbmNlIGdhaW5zIHlvdeKAmXJlIHNob3du
IGFyZSBub3QgaW5zaWduaWZpY2FudC4gSG93ZXZlcuKApg0KDQpPbiA1IE5vdiAyMDI2LCBhdCAw
MToyNSwgS2FydGhpayBQb2R1dmFsIHZpYSBiaXRiYWtlLWRldmVsIDxrcG9kdXZhbD1sYWIxMjYu
Y29tQGxpc3RzLm9wZW5lbWJlZGRlZC5vcmc+IHdyb3RlOg0KPiArdHJ5Og0KPiArICAgIGltcG9y
dCBib3RvMw0KPiArICAgIGltcG9ydCBib3RvY29yZQ0KPiArICAgIEhBVkVfQk9UTzMgPSBUcnVl
DQo+ICtleGNlcHQgSW1wb3J0RXJyb3I6DQo+ICsgICAgSEFWRV9CT1RPMyA9IEZhbHNlDQoNCklu
c3RlYWQgb2YgcmVzcGVjdGluZyBIQVZFX0JPVE8zIGluIGVhY2ggb2YgdGhlIGZ1bmN0aW9ucywg
cmVzdWx0aW5nIGluIHF1aXRlIGEgbG90IG9mIGNvbXBsZXggY29kZSwgSSBzdWdnZXN0IGEgc2xp
Z2h0bHkgZGlmZmVyZW50IGFwcHJvYWNoLiAgSW5zdGVhZCBvZiBoYXZpbmcgdGhlIGNvbmRpdGlv
bmFsIGluIHRoZSBtZXRob2RzLCBoYXZlIHR3byBpbXBsZW1lbnRhdGlvbnMgb2YgdGhlIFMzIGZl
dGNoZXIgKHNoYXJpbmcgY29kZSB2aWEgYSBjb21tb24gcGFyZW50LCBpZiBuZWVkZWQpLCBhbmQg
dGhlbiBwaWNrIHdoYXQgb25lIGlzIHVzZWQgb24gdGhlIGZseS4gIFNvbWV0aGluZyBsaWtlIHRo
aXM6DQoNCmNsYXNzIFMzQ29tbW9uKEZldGNoTWV0aG9kKToNCiAgIyBjb21tb24gbWV0aG9kcyBj
YW4gZ28gaW4gdGhpcyBjbGFzcw0KICBkZWYgc3VwcG9ydHMoc2VsZiwgdWQsIGQpOg0KICAgIHJl
dHVybiB1ZC50eXBlIGluIFsnczPigJldDQogICMgZXRjDQoNCmNsYXNzIFMzQ0xJKFMzQ29tbW9u
KToNCiAgIyBjb25jcmV0ZSBpbXBsZW1lbnRhdGlvbiB1c2luZyB0aGUgQ0xJDQogIGRlZiBkb3du
bG9hZChzZWxmLCB1ZCwgZCk6DQogICAgIyBkb3dubG9hZCB1c2luZyB0aGUgY2xpDQoNCmNsYXNz
IFMzQm90byhTM0NvbW1vbik6DQogICMgY29uY3JldGUgaW1wbGVtZW50YXRpb24gdXNpbmcgYm90
bw0KICBkZWYgZG93bmxvYWQoc2VsZiwgdWQsIGQpOg0KICAgICMgZG93bmxvYWQgdXNpbmcgYm90
bw0KDQp0cnk6DQogIGltcG9ydCBib3RvMw0KICBTMyA9IFMzQm90bw0KZXhjZXB0IEltcG9ydEVy
cm9yOg0KICBTMyA9IFMzQ0xJDQoNClRoaXMgc2hvdWxkIHJlc3VsdCBpbiBuZWF0ZXIgY29kZSBh
cyB0aGVyZeKAmXMgYSBjbGVhciBzcGxpdCBiZXR3ZWVuIHRoZSB0d28gYmFja2VuZCBpbXBsZW1l
bnRhdGlvbnMuDQoNCkNoZWVycywNClJvc3M=
