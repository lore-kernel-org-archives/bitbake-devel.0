Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8936BCCFA0D
	for <webhook@archiver.kernel.org>; Wed,  5 Nov 2025 10:32:35 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.17])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6349.1762338754565014176
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Nov 2025 02:32:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=gfiVW9wl;
 spf=pass (domain: axis.com, ip: 40.107.159.17, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VqfYB/yhkEf5BgzLRP97Z6DjVpk58EgwsjUs4RKvH4J+BCTq9V5qYSgOpDG2nGrIviN0mnl8CTZnzjxRKleuA5IK+k+S4Ch7ao+CCRAfCWgdHLnjuxDjOCF1IXCiud0Eu8aLSlNm65/aePm8R79GW7/nFn28ymICqhukKmnfaujGncb8cFnOXP231MkB8pJKu1me9cCpPJVCqGfqM1a2W24reVk3aiXV2sfPpBQoYI/f4ps+EBY0Kxw26F8piVDxfj/LCVnPyoQC9/oQrzTIaa41GZnEl0u5R2HRYkzvltQHhi052JjtDd/tVqN0bAhTygSm0ajC93Ri4NbISSCraw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFIF0nuo+Q6LNxi1Xx3nj0ji6CnTqdvX637IgcRB7vk=;
 b=HwYpXNafFa5+I3KKqh0OizGvwUN4KQvLwdh196s/NlaP9uB22f3EBmVESAeZlaZ/FAn1o3oIYBNH2UDQ80cLsZ0ZtqADuWeiyJYfbnct/57tFCBgG0ParKuZwRKfLJoupiWEdmwzjTy0qzKZun4+MhsBnLyfpdzsQ4YBwWP6oWxaKCobooj2dYLyTLCXoR6n+bcK+4TgRLEsD+gIRufGby2VbbePWwY1iv7WylNk8WDb4mDwzhSdtHA/bee7N4mn5f4zNdLoPvCvl2BAd+Y3itsNEg9BzJ1aof076Fc8pjG/5sTdktcyuoaGXR+z6xzZvZMV4ayjsPGUb3vWU9mBgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFIF0nuo+Q6LNxi1Xx3nj0ji6CnTqdvX637IgcRB7vk=;
 b=gfiVW9wlcvHfiYFfq2emVPE59CtZVoa/vZ7UjWv4wjqSeNCHsPnqTqc/MvUwmZ05i6YsN8891GmhVFkqmemRe6KxHzOipA0d3nELkwFWdlG02Ri2sW73omepBQQ941Ky5n/xpmBM9iFv597pw+YeKKqW9yyjPIfFxfvWtcCWTlM=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by DU0PR02MB9396.eurprd02.prod.outlook.com (2603:10a6:10:41b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 10:32:31 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9%7]) with mapi id 15.20.9298.007; Wed, 5 Nov 2025
 10:32:31 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>, "zboszor@gmail.com"
	<zboszor@gmail.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH] knotty: Cast two variables to int in
 integer expressions
Thread-Topic: [bitbake-devel] [PATCH] knotty: Cast two variables to int in
 integer expressions
Thread-Index: AQHcTiPMC1ev6Bt+vUuLKcVbS7XrA7Tj3R8wgAAEnHA=
Date: Wed, 5 Nov 2025 10:32:30 +0000
Message-ID: 
 <DB5PR02MB10213B99F0900A16DD0023B54EFC5A@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20251105071405.636900-1-zboszor@gmail.com>
 <18751578F72EE953.363297@lists.openembedded.org>
In-Reply-To: <18751578F72EE953.363297@lists.openembedded.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|DU0PR02MB9396:EE_
x-ms-office365-filtering-correlation-id: e8a0f836-32af-4130-7216-08de1c569ff6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|7053199007|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?K1FxQnNKK2t3ZHJhd2hsZW4wdVhnTUNqRzNzMHVGdjg3dmYvT3dNREs3R1Av?=
 =?utf-8?B?TU45SDdkYjBWb3pHY2pTaGZlV1BmMnZOTWtqZFNQWVdwY1h4aVBEODlreTZB?=
 =?utf-8?B?ZmVFVS9UeWpjNlorTEtyL3VlSlR0ZjExODBtZ1QrQ1hiekQ2anlaeGFCNWt3?=
 =?utf-8?B?TUFWbFd1SEJmSTlZbnYzcU9JS1U3SEI2WmRtZjAwNkRHOU0rMm8zREx4WHVG?=
 =?utf-8?B?NW0zbEpnMk1jUFhURFBoWk5qMEl2NlEyeEFIWERsUlpKWWJidyt3KzhoVjI1?=
 =?utf-8?B?ZFhRTU9LdzBuWXltaWM3WUNRNGcvc2Z3Y2hndlBuUGhWSjJGTGRnL0NwaHR6?=
 =?utf-8?B?d1FPWmhBMkxLSjJjYkhHa1NFd2FsMWV4NEhac3dPWlZaSXF3dlQ3by9BVnlG?=
 =?utf-8?B?NllCeG9CdlVVY0ZyZ1MyUHJtQkFFb29TdDFjT3B1eDRGaGFxZEtOSmYzUFZw?=
 =?utf-8?B?MHREbG9LMXdYNmRCNE1xN2hBWTZMU0o3aVhCRHNxNmg1TFFWQVFVWVhyR1VM?=
 =?utf-8?B?M1E2bEJqYW5XdFdDbUthYjdjZTF6VElTN1BSdm94bHVJRlhwM01LNlV6WGFx?=
 =?utf-8?B?WUlJZnQ3aVkwVVN2RUxpNGhqMWZKUVk4RzhhU0NWczZ5RVVsYTN2NnJiME5D?=
 =?utf-8?B?SHZwMWtrZWFYeG80elcybGx5Vzl2UXNmam0yL1Z2NEtoTVdYdXc1Kzc1WVcw?=
 =?utf-8?B?YTEvUWt2eUo1OW4vWWtqc3d4dFVSV2hhcjU2OUZIem01dnNrUklBWmFBYlFo?=
 =?utf-8?B?VTNObVV3bHlKVU1TZC9PenpnR0hkT2EwWU1PV1p2ZUU5RFBXUHpIOWhzU2pF?=
 =?utf-8?B?ZmZTVE9JNlRiY0lNSTV5Uk9tM000ekZ3dFlaUDMrdDF3NkR4b1NHQXk3Z2dv?=
 =?utf-8?B?ZGxMaFZLOFdLSkZ6UUFIVDRLdWY0WldWQ3FYdk5JWWJyVmxRQytzbEMyQWhD?=
 =?utf-8?B?Vm5GRGJ6c2pvU1YvQWVSajFSQ1kydHhIdGNPa1dyODZOdVl6a2VmOURpTDZi?=
 =?utf-8?B?Z254YjQ2cDhxR0xCWVZjM0JRbHVhbU5QdC9ZUDJkbXJPQml6WUovWGRrblZO?=
 =?utf-8?B?RmgzNCtGWmkrNy9oai9TZ2NzMTFSYndCMU5FWEUvUXBEWWhiNFR5Z3pYUnI3?=
 =?utf-8?B?NlVsb0FDSVprazNOTUpYeEV5a0lBQ3VRQSt6SXVkOGk5czJHMkkvT0NjZVpq?=
 =?utf-8?B?KzdObDh1dlI1VXRPYmVpTFkzSzFyU1VPV2R4dVdTM3I5UW5PajNnY3pUb2VC?=
 =?utf-8?B?NG9vZWwvdTBXcmh0aUFVN1VXSnE0Sk9uRmNXY2hLSmJTbkx2VVJMeC9TUFdG?=
 =?utf-8?B?K2xwUU5LcC9hU3g3NlRzcHRLVXkwbUxVMnlWREVEamlpZnMxZXBnOTBIWmh4?=
 =?utf-8?B?Rm8vWTFVVzhTN0tabGE0anVJcmtyTEQwUHZFZlBNdXB3aTZ0ZUp0VmxvdmZ0?=
 =?utf-8?B?SlpFcVpMeDV2ZkFIZms1UVEzbk1WMkFrS1ByQVQ3ZTVHQzh4Z1d3V0VkR3p5?=
 =?utf-8?B?ejk0eC9LRFkxMjJJaXRkMGpmaHZaazVNSmJBZEVCUjRCYWpuc1dmZjRmT0tG?=
 =?utf-8?B?anJJK1AxbkZ3Zkt3N2FjRHFUZlFIT3F0emNVT0RmYW9KWmhEK0lwaE5ZMWZH?=
 =?utf-8?B?cGVGeUJ4M3A0T044RHoyZjlxNDVKbXE5Ym5vK3g4MSs4QkRaa0tnTGFpUTd4?=
 =?utf-8?B?M3pYVHQxbUI1TmpnV0NUU3hPVm01YjQ2UTFKMG8xbU5TUnVwOVI1VDhsSDhv?=
 =?utf-8?B?OCtHUFRMSW9Bcy9oS3NiTkpLUkZiUmRCZ0lLbk44Zk0vSTgzcUlaTkJaQjNx?=
 =?utf-8?B?cnlGZ3dXa3VyN1VaVk5zVmFkSHpVYXlBVklBcG5aZloweCtNK0cwRFUxV2Ju?=
 =?utf-8?B?STRTUkRiTWVYemF2SUc5K1NWOHJPUkw1OWphVk51Y0JPQWlCQjdUeHVlWjdm?=
 =?utf-8?B?NXQzQzVsQUs4eTBjaEZ6MS9ucFF1OW15UGJVYVFqZjY5a2NBaFNmQ2R6YjNY?=
 =?utf-8?B?WWZ2SlJnbUdsUzE0TWZzSXJlOTZqNEtpSDhVcTRuT1I1VWFNeXk0TUtNdVlt?=
 =?utf-8?Q?kA+lkW?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?S2J2SkRTSnNOb3NJK3Y3OU5jbDR6MXhIeHUxSkVXOW1ic0cvMnIzOWZta2s5?=
 =?utf-8?B?ZnV5OXJkWUNyWWlPUXczQ1VYdXFKNFExV2NiSHVFK0gvOWR5dUxIR1AzQllV?=
 =?utf-8?B?NWlwaXR2U0p4NUFzSWtTNnAxWXc2dmNJODZPL0Z4cEZ4VURJQW02eUlxZUdK?=
 =?utf-8?B?OHFYSWt5Ri9xU3U2dzUxRjFpMVVSSFdqbTYyWWRJSWhVSjc0Q2ViVDVST09o?=
 =?utf-8?B?N095dzBGUUNrd1Zqelp1ZStPT0RWWVorQ1daTi9vbHJseGgrak1xZU9SdmNs?=
 =?utf-8?B?ZXI0K0FHZ1VrL3VHVkNDVUtTZXFuWHk4cUtPQmx0RlNCRG90MVJaSmRmMGEx?=
 =?utf-8?B?di83V2puVVRVK0dYbnAxZWVqYWNwS2FyKy81aVN6alJKSWltNjkyb2tvaVpO?=
 =?utf-8?B?Ry9lbVZUM041VVZQYlQzTGp0a2FRbXlOMFI3UFRGUGkzQ29XOTNTL2dGSnhC?=
 =?utf-8?B?UkFQMm9JQU9uSXJLWHdUNmYyaXJxVnZhNndlTzhHWFN4SWpJbjZQbWtORDdW?=
 =?utf-8?B?NlY1dDUydzR4cjQzSTh1SVpJbnR1eXAyUGw2cmhtaytqRkw2Y0hpbzhoRG9Y?=
 =?utf-8?B?ejhMRmFIUENIem1YSWhVTjRDZnFLSlhkdzcrWFFseEQrRlhzRHMzbVVyWDZZ?=
 =?utf-8?B?QXIrM0FpcWZyMThQZXQxcXl1Zlk3d2NOTDhEc1hPMVY2Zjc2L2Nta3dFWEtR?=
 =?utf-8?B?V2JwdXNNWG5xUmNXNnRBY3k1SHUxWXpoRzY3YWM1RjJReEN3R0JJQmVUZUtz?=
 =?utf-8?B?UEJqSGpXUFM3SU5tVjdJZ29WbHhQd1VrN3FKNmxMdXB4K2FWUks5ak5ZM2lp?=
 =?utf-8?B?azhWU2Nuek5PM01tcEpySVMyL3E3a3ZyOU5xd1o2WHdFQVJhTGRiL0tFQWRD?=
 =?utf-8?B?bWIxdVcwUnFaVWhyb2NRL3c2cFM2Zk5aT3dLRkcyb3NzZS82bWIrSlJGaXpB?=
 =?utf-8?B?TzlRUGlOWlVQU0xqNlBaL2lyV3hDN3QreXVkYU1GejhiUGErT3czUjBNdWlh?=
 =?utf-8?B?SFgrM0ZWaGVTSVJPaStLZnRJOG9RR0ltU3RyT1k1WXc4STRsQ0hyTFpSck5G?=
 =?utf-8?B?Vzl2RW4zRW9jdFFPc1JaaFBBaFg1d2NDdWE5UC9vZ3hHbFdSYktndUFmU3l5?=
 =?utf-8?B?Z3g2TnhYaHU0Z1o5bjdQckc2Zy9WS2cxRHBOOWV5bWZNMmcyZEhJR2hWT1hO?=
 =?utf-8?B?by93dHlJTllBSjNkU3lRVEJMSXBramEzZzV1TmkzMU9tOFVBNTcwOUpVOVIx?=
 =?utf-8?B?K2RnYkJHdk1ZU0N2R09mNjQwTDZnK29Kd3JoWXpRTEhkMlJ3NkJBY0Q4T1FP?=
 =?utf-8?B?cHlOWUVTOXowNzlpeUluaTdYdWpBRU1NYVR6WkI3NjNvR1FtZVF5TXlJSlVV?=
 =?utf-8?B?dmNJQ09DalVaZm8xTTF2MGErT1ptZjRqNnlxdFkvNU5LTE5xRUh6MTRFaHk5?=
 =?utf-8?B?SXI4dkNRU3Y1T1k4QVFFTHpxVlVMcmE3R2tsRzJxelVkQXM2S0xMY1p1c0VG?=
 =?utf-8?B?cTQwNTZob3VVMXhXYSttajRhWk55L3RZQ3doODA3S25HR2x0dytPTjFwY0s1?=
 =?utf-8?B?QlJzOWxqdlVJTCtIUVRmbEJhL2VTWVZCZFhWdSt6czFBRjUya3FtYjNNNDcx?=
 =?utf-8?B?R1B2U1hnaFdIVkcwMklGYnNrWlpQNWpManN2aDBhUk9jaUVQS1NiNlJtaTAy?=
 =?utf-8?B?UVVCMHFqTVZTdjJCMFh2MWlNczF1UHNpSUpKc2NFc0hXbWxzSlRUdlA5d1k0?=
 =?utf-8?B?aFBWNy90RHpWbTJnNWdxdm1sUVV2dzV4anNIdFpiek1mMEJpbEpmbUYwNU9l?=
 =?utf-8?B?Vk5EbWdPYy9rUUhDdUcydlV1TXplajJzZ0pzOGNuMElkZUxJaytPTTRaRmI2?=
 =?utf-8?B?U0t4OSs1dUZ2TytuRjQ1OUFKNHA1NnJXUm5pT0hhdUdEREVkdXdncUQ3Nzl2?=
 =?utf-8?B?SEJrOWNaSlNmVzA1aCt5QnVyUVBGZXNRWkE1ODF6c25tWWw2RGNuSWc5aDcw?=
 =?utf-8?B?bG1zRkQxZkt3VnhIeDc4OFBuK3dibVl4cWdjOU1Rc0kwNWVZdlpPMkFhYk5z?=
 =?utf-8?B?d0grZTZndm5kNEdySi9vN09VNWR3MkJRSUhGUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a0f836-32af-4130-7216-08de1c569ff6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 10:32:30.9452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RIbMlaBcDXU9yrRUdk16Vy2OuzVMAk1plBtX4g+mR6NZROkiyYxaQih3sX/zYfSR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB9396
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Nov 2025 10:32:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18259

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBiaXRiYWtlLWRldmVsQGxpc3Rz
Lm9wZW5lbWJlZGRlZC5vcmcgPGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZz4g
T24gQmVoYWxmIE9mIFBldGVyIEtqZWxsZXJzdGVkdCB2aWEgbGlzdHMub3BlbmVtYmVkZGVkLm9y
Zw0KPiBTZW50OiBkZW4gNSBub3ZlbWJlciAyMDI1IDExOjI3DQo+IFRvOiB6Ym9zem9yQGdtYWls
LmNvbTsgYml0YmFrZS1kZXZlbEBsaXN0cy5vcGVuZW1iZWRkZWQub3JnDQo+IFN1YmplY3Q6IFJl
OiBbYml0YmFrZS1kZXZlbF0gW1BBVENIXSBrbm90dHk6IENhc3QgdHdvIHZhcmlhYmxlcyB0byBp
bnQgaW4gaW50ZWdlciBleHByZXNzaW9ucw0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiA+IEZyb206IGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZyA8Yml0
YmFrZS1kZXZlbEBsaXN0cy5vcGVuZW1iZWRkZWQub3JnPiBPbiBCZWhhbGYgT2YgWm9sdGFuIEJv
c3pvcm1lbnlpIHZpYSBsaXN0cy5vcGVuZW1iZWRkZWQub3JnDQo+ID4gU2VudDogZGVuIDUgbm92
ZW1iZXIgMjAyNSAwODoxNA0KPiA+IFRvOiBiaXRiYWtlLWRldmVsQGxpc3RzLm9wZW5lbWJlZGRl
ZC5vcmcNCj4gPiBDYzogWm9sdMOhbiBCw7ZzesO2cm3DqW55aSA8emJvc3pvckBnbWFpbC5jb20+
DQo+ID4gU3ViamVjdDogW2JpdGJha2UtZGV2ZWxdIFtQQVRDSF0ga25vdHR5OiBDYXN0IHR3byB2
YXJpYWJsZXMgdG8gaW50IGluIGludGVnZXIgZXhwcmVzc2lvbnMNCj4gPg0KPiA+IFB5dGhvbiAz
LjE0IGNvbXBsYWluIGFib3V0IHRoZXNlOg0KPiA+DQo+ID4gVHJhY2ViYWNrIChtb3N0IHJlY2Vu
dCBjYWxsIGxhc3QpOg0KPiA+ICAgRmlsZSAiL21udDIvem96by95b2N0by01LjMvYml0YmFrZS9s
aWIvYmIvdWkva25vdHR5LnB5IiwgbGluZSA3MjIsIGluIG1haW4NCj4gPiAgICAgdGVybWZpbHRl
ci51cGRhdGVGb290ZXIoKQ0KPiA+ICAgICB+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fl5eDQo+ID4g
ICBGaWxlICIvbW50Mi96b3pvL3lvY3RvLTUuMy9iaXRiYWtlL2xpYi9iYi91aS9rbm90dHkucHki
LCBsaW5lIDMzOSwgaW4gdXBkYXRlRm9vdGVyDQo+ID4gICAgIGxpbmVzID0gc2VsZi5nZXRsaW5l
cyhjb250ZW50KQ0KPiA+ICAgRmlsZSAiL21udDIvem96by95b2N0by01LjMvYml0YmFrZS9saWIv
YmIvdWkva25vdHR5LnB5IiwgbGluZSAzNzAsIGluIGdldGxpbmVzDQo+ID4gICAgIGxpbmVzID0g
bGluZXMgKyAxICsgaW50KGxlbihsaW5lKSAvIChzZWxmLmNvbHVtbnMgKyAxKSkNCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH5+fn5+fn5+fn5+fn5efn4NCj4g
PiBUeXBlRXJyb3I6IGNhbiBvbmx5IGNvbmNhdGVuYXRlIHN0ciAobm90ICJpbnQiKSB0byBzdHIN
Cj4gPg0KPiA+IGFuZA0KPiA+DQo+ID4gVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3Qp
Og0KPiA+ICAgRmlsZSAiL21udDIvem96by95b2N0by01LjMvYml0YmFrZS9saWIvYmIvdWkva25v
dHR5LnB5IiwgbGluZSA3MjIsIGluIG1haW4NCj4gPiAgICAgdGVybWZpbHRlci51cGRhdGVGb290
ZXIoKQ0KPiA+ICAgICB+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fl5eDQo+ID4gICBGaWxlICIvbW50
Mi96b3pvL3lvY3RvLTUuMy9iaXRiYWtlL2xpYi9iYi91aS9rbm90dHkucHkiLCBsaW5lIDM0MSwg
aW4gdXBkYXRlRm9vdGVyDQo+ID4gICAgIGZvciB0YXNrbnVtLCB0YXNrIGluIGVudW1lcmF0ZSh0
YXNrc1s6KHNlbGYucm93cyAtIDEgLSBsaW5lcyldKToNCj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfn5+fn5+fn5+fl5+fg0KPiA+IFR5cGVFcnJvcjogdW5z
dXBwb3J0ZWQgb3BlcmFuZCB0eXBlKHMpIGZvciAtOiAnc3RyJyBhbmQgJ2ludCcNCj4gPg0KPiA+
IENhc3Qgc2VsZi5yb3dzIGFuZCBzZWxmLmNvbHVtbnMgdG8gaW50Lg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogWm9sdMOhbiBCw7ZzesO2cm3DqW55aSA8emJvc3pvckBnbWFpbC5jb20+DQo+ID4g
LS0tDQo+ID4gIGxpYi9iYi91aS9rbm90dHkucHkgfCA0ICsrLS0NCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9saWIvYmIvdWkva25vdHR5LnB5IGIvbGliL2JiL3VpL2tub3R0eS5weQ0KPiA+IGluZGV4IDAw
MjU4YzgwZi4uZjA0NjA3ZGY4IDEwMDY0NA0KPiA+IC0tLSBhL2xpYi9iYi91aS9rbm90dHkucHkN
Cj4gPiArKysgYi9saWIvYmIvdWkva25vdHR5LnB5DQo+ID4gQEAgLTMzOCw3ICszMzgsNyBAQCBj
bGFzcyBUZXJtaW5hbEZpbHRlcihvYmplY3QpOg0KPiA+ICAgICAgICAgICAgICBwcmludCgnJywg
ZmlsZT1zZWxmLl9mb290ZXJfYnVmKQ0KPiA+ICAgICAgICAgIGxpbmVzID0gc2VsZi5nZXRsaW5l
cyhjb250ZW50KQ0KPiA+ICAgICAgICAgIGlmIG5vdCBzZWxmLnF1aWV0Og0KPiA+IC0gICAgICAg
ICAgICBmb3IgdGFza251bSwgdGFzayBpbiBlbnVtZXJhdGUodGFza3NbOihzZWxmLnJvd3MgLSAx
IC0gbGluZXMpXSk6DQo+ID4gKyAgICAgICAgICAgIGZvciB0YXNrbnVtLCB0YXNrIGluIGVudW1l
cmF0ZSh0YXNrc1s6KGludChzZWxmLnJvd3MpIC0gMSAtIGxpbmVzKV0pOg0KPiA+ICAgICAgICAg
ICAgICAgICAgaWYgaXNpbnN0YW5jZSh0YXNrLCB0dXBsZSk6DQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgcGJhciwgbXNnLCBwcm9ncmVzcywgcmF0ZSwgc3RhcnRfdGltZSA9IHRhc2sNCj4gPiAg
ICAgICAgICAgICAgICAgICAgICBpZiBub3QgcGJhci5zdGFydF90aW1lOg0KPiA+IEBAIC0zNjcs
NyArMzY3LDcgQEAgY2xhc3MgVGVybWluYWxGaWx0ZXIob2JqZWN0KToNCj4gPiAgICAgIGRlZiBn
ZXRsaW5lcyhzZWxmLCBjb250ZW50KToNCj4gPiAgICAgICAgICBsaW5lcyA9IDANCj4gPiAgICAg
ICAgICBmb3IgbGluZSBpbiBjb250ZW50LnNwbGl0KCJcbiIpOg0KPiA+IC0gICAgICAgICAgICBs
aW5lcyA9IGxpbmVzICsgMSArIGludChsZW4obGluZSkgLyAoc2VsZi5jb2x1bW5zICsgMSkpDQo+
ID4gKyAgICAgICAgICAgIGxpbmVzID0gbGluZXMgKyAxICsgaW50KGxlbihsaW5lKSAvIChpbnQo
c2VsZi5jb2x1bW5zKSArIDEpKQ0KPiA+ICAgICAgICAgIHJldHVybiBsaW5lcw0KPiA+DQo+ID4g
ICAgICBkZWYgZmluaXNoKHNlbGYpOg0KPiA+IC0tDQo+ID4gMi41MS4xDQo+IA0KPiBXb3VsZG4n
dCBpdCBtYWtlIG1vcmUgc2Vuc2UgdG8gbWFrZSBnZXRUZXJtaW5hbENvbHVtbnMoKSByZXR1cm4g
dHdvIGludGVnZXJzPw0KPiBJZiBJIHVuZGVyc3RhbmQgdGhlIGNvZGUgY29ycmVjdGx5LCB0aGlz
IHNob3VsZCBvbmx5IGJlIGEgcHJvYmxlbSB3aGVuDQo+IHJlYWRpbmcgdGhlIHNpemVzIGZyb20g
dGhlIGVudmlyb25tZW50LCBzbyBjaGFuZ2luZyB0aGlzOg0KPiANCj4gICAgICAgICAgICAgICAg
IGNyID0gKG9zLmVudmlyb25bJ0xJTkVTJ10sIG9zLmVudmlyb25bJ0NPTFVNTlMnXSkNCj4gDQo+
IHRvIHRoaXM6DQo+IA0KPiAgICAgICAgICAgICAgICAgY3IgPSAoaW50KG9zLmVudmlyb25bJ0xJ
TkVTJ10pLCBpbnQob3MuZW52aXJvblsnQ09MVU1OUyddKSkNCj4gDQo+IHNob3VsZCBzb2x2ZSB0
aGUgcHJvYmxlbS4NCj4gDQo+IC8vUGV0ZXINCg0KT2gsIGFuZCBJIHdvdWxkIGFsc28gY2hhbmdl
IHRoZSBzdWJqZWN0IHRvIHNheToNCg0Ka25vdHR5OiBNYWtlIHN1cmUgZ2V0VGVybWluYWxDb2x1
bW5zKCkgcmV0dXJucyB0d28gaW50ZWdlcnMNCg0KLy9QZXRlcg0KDQo=

