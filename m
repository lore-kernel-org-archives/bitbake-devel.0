Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0E7CCD185
	for <webhook@archiver.kernel.org>; Sat, 11 Oct 2025 03:09:01 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.3])
 by mx.groups.io with SMTP id smtpd.web10.4372.1760152133209448734
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Oct 2025 20:08:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=p97c9ZV5;
 spf=pass (domain: axis.com, ip: 52.101.83.3, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8Dw34t4MEDHuhCj/PZ+DLN3tFFgsVCW6S28cSgTY/s8fjkEQiTRNMLhL/IhqxkolCSGrd+bYP9LYiHggtgy8lnm32z8V8wbzH5cabuuC1T3sOl7pfxxhd4jFgI4CBAcdY6hZ4IvVo5ZC3VZWBPOxaGPO/ZaTBKnDTASlnHNYrfgAQCKaEkpZ8I4ekrOeXaHiqQgqHuGjKc2ZAnwh4HixuAqJwo8BCxhhDTjytX0YDCR+8iEcevSuBY6VO0SH4n/HCB6c1yeehLPFMnRO27Whn3BFVZQc7ZakV9s0LcQf+PwyIO4f6uXQg8feey8MGf6tYljweQE+PHHq7IULrNFTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rwy/Hzw2tmzu/lVoUk6+BwbUv+/SCvYwPuebQlVMyE=;
 b=dClFkS4YrfLs/qolcSeX8AQNQU6cCX7AysBy7SGIhNvtVVMPRajsWV8qIFuSDP7fqOdd9wLYjX2TM31bQnWvxvlR7G3GNPK3isxWBrKKNDKCHgnYyURGX1J9mkba/sHK9eEJioFG6N9k4sngOeAUISPnwSVDhkLaMAWumENwo5KQgLPcQfqlrl9bu6j17KCI15mBW4KrGzekShBzZ5HZP2/ce5bXYeHEYqdm5QHOhGZdtRZbBzLMTJE/LJVNXMbMIbH15urYD88XtJLob3nfu9TprALNPXpJxE5tLIKWzVo0szAuqQM1S1gKv6FhPq59dKiFl/R9S88TtbKk4/7luQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rwy/Hzw2tmzu/lVoUk6+BwbUv+/SCvYwPuebQlVMyE=;
 b=p97c9ZV5MYhFZg8+UCPUhczMFVzfmx2d5odCK45rlPHHdEFzuCtNQODMNAZw0zO70/0MJj7Uls6O6cxYpFQfnor8ms9uRhaIlFE8dE/zNNOSNDcR+2Mg8ZdcU6RaAnZlLukSMURI1V9882fRo855Ior4F27FSUSwfsvz5ykBv5U=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by AM9PR02MB6835.eurprd02.prod.outlook.com (2603:10a6:20b:2c4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Sat, 11 Oct
 2025 03:08:48 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9%7]) with mapi id 15.20.9203.009; Sat, 11 Oct 2025
 03:08:48 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH] runqueue: Make the "Initialising tasks"
 progress bar finish properly
Thread-Topic: [bitbake-devel] [PATCH] runqueue: Make the "Initialising tasks"
 progress bar finish properly
Thread-Index: AQHcORKlmfKF0lbcL0iI+gEQrkKU4LS8P6fQ
Date: Sat, 11 Oct 2025 03:08:48 +0000
Message-ID: 
 <DB5PR02MB10213A533B1F0AA123EEBB779EFECA@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20250927055339.2472285-1-pkj@axis.com>
 <b31807779ef3667b1e8008cb47f71f6db64c5211.camel@linuxfoundation.org>
In-Reply-To: 
 <b31807779ef3667b1e8008cb47f71f6db64c5211.camel@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|AM9PR02MB6835:EE_
x-ms-office365-filtering-correlation-id: 03b374c6-6bd9-4f6c-0a95-08de08737f66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?ZVJBMythSWJhOEhMVW9KbUZJSWgxSWR0ZUwwb3FmTUJjQXJTSDJlTHJkYkEr?=
 =?utf-8?B?SVdzREUrSTlad01JK3RSZHQ3QVljUVpDUmdhcEI4VXNCNDZrNWpxU3h4M0pr?=
 =?utf-8?B?WGJOVkNqNHFwWldtQ3BvOEJhUStmSmtrWVhlU0d6eUJKck1jSVhUNG9pL2FP?=
 =?utf-8?B?K2kxZjdPL0w1Q3grM2dEWkxwTGw0aG1ObUt4c2lrMnV1SWZqY3NweGY5VlVx?=
 =?utf-8?B?cHFmRm1McXdhYnRmSWNrMmxqdjhLbVM2S1VsV05tZ3Vaclk3bktCdzNsV0JT?=
 =?utf-8?B?K3pXNU1yUkRyTmRPK2M3T3Badk1UU0I4VFFHMG83UDJZVHRBajFmT1h2c1Zq?=
 =?utf-8?B?WDVzdDcyRk5vcWFNVHpQZG1zbHJLQmJEelp4Q2ZFalpta1NpOXJWd3B6RkZM?=
 =?utf-8?B?T1dscXhKRHkvMlNVUVRYWHBFUGNEZTEwUjZrYmxmaExBcGM4d0Y2ODNHTU5S?=
 =?utf-8?B?RWMwV1hRKytPQksyZzFsUSsxd25MRm1TM0RaRURSaDk2ZHU2bXlUWWEzU0tx?=
 =?utf-8?B?VCtkZnpvQkZHRU43aXNxOFFnV2cyN0g0Q25iM1l4NVRNRlFKQUEzQUJoeXEv?=
 =?utf-8?B?dmYvMG43Vmlsak5JekVqdmhjR0dTRUJEN1ZtMjg2ekRvZFpDRFpuait1RXdX?=
 =?utf-8?B?bVc2MDlhMDVKZ29DREJyZ0tjV2Fsck5tUXRZZUdYVzBTd0JnRkFIMzFXbVhU?=
 =?utf-8?B?SlpmRyt5UmljQjE1aFZQRTVzaUhMeTdiNVhvMHVpN0dNb2RUQTFHWXBlcGdM?=
 =?utf-8?B?bzEvNkdGbi9DM0dDK0lCbG8zOWNMTkVtZVBRVWlsRXdxMGh2ZkhjdlB5NWpP?=
 =?utf-8?B?ZWlyZk5nNm5KcHIyYk5weHhPQm4ybXlieCtLQWc5d0E1TTVvTDlsZnhZcThV?=
 =?utf-8?B?eEFnWXFzeDc5WERvWHphNy82OEp3SG9vQWZ6c1NlbG90TVRYamtSeExjSzQv?=
 =?utf-8?B?NG5RTnNDRUNDdFlQeXE1ZER4Ym5KUytYMTBIQ1FWM3EvbGphQmJEd0Fnb0tx?=
 =?utf-8?B?anh4QTl6elBtRmJLUjVtV2JTcHNEajhNTlpnU2c4SWRDSTVWUVZhelo5ZDdw?=
 =?utf-8?B?NUgwa2FSVCs1UGpIOWIyeUUxYUdqdi9rdWxmbkV2K0R0VWFRS0hOZG9iWlFz?=
 =?utf-8?B?bTJOWHlyUG9zZUQxTmFRSCtFUlNWZEpRcG9BZEtMMFM0TUlqY3VnM05XZFlx?=
 =?utf-8?B?aU1qdlZIaEt6c2x2djAvVWZOMjdSd1JDM3IyYXdneWVsaUhBL2VMRHlNb0tx?=
 =?utf-8?B?NEVSeVRCNG1LaGlZSlI1V01OT2gxVGFwWE02aVZTVjRjL1g3Z2NZd0hMbUlk?=
 =?utf-8?B?ZzlmbitMS1F6dW9DUEFZakIwaHlXTFZzdFhXK21CeUV3TUp6TzVDZXIzajBz?=
 =?utf-8?B?NVozcnZURkswV2xsNDZ6bWFOTXN5M2M3UmVsK3owc1dFSHF3b3FTVm9oWU00?=
 =?utf-8?B?ZzhsNXlzc0kwSnBzcjg5UnhFTkw0Yzl4aGpiV2JxaUQwRFQ5WGRlSEp5aDJz?=
 =?utf-8?B?N2hrK0hEL3BzSHlHVEp6aHBaeldjcnlFNTR1cThOb2pJMXJiSEZuNXJoUWpE?=
 =?utf-8?B?N25mTGJpN3ZmcjJPSkE2bjYvK2NldkV1YmpqT0N4OEhUKzIwZWR4L2R4N0Rx?=
 =?utf-8?B?L2VLZ2QyN2hldEk2V29teXY4ZlRWc1hpUktwSVpjNGs0ZDMvd09YUGJqN3BH?=
 =?utf-8?B?aWlNRVpXMzgyYWRXR05JMjgwdnNXTTZwZkw0K21LZG5YUEdPbGFPaW9yMjN6?=
 =?utf-8?B?VWdSWmhaVUtQRTc4MGZYUXVwck1RU29JemFCelBPU1Jtck1hcTZyN2N6SEw5?=
 =?utf-8?B?SzQxbHVQbE85eGhzSUd1eGpBbnBJeVFDQitWWFFlVWt0VXc1ellxY1d2UitI?=
 =?utf-8?B?UGZvR0V1bXVPK1l4Lzh3YS9UenVFSjlzY2d3SndaQkhXdFMzZzNNZDNxTURp?=
 =?utf-8?B?TWxmZzNoNGVHVlZlVVNHSTcyUGJYbWpUUFMrU0wyNmR0QkIweVp1TEc4VE51?=
 =?utf-8?B?bFRDUWwxcEVCaDZiVTNXT3BoTnlIL0tXWHlsRUduVllRbjV1Uk1nUklLMFlP?=
 =?utf-8?Q?YtmDbZ?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?akgrMTlXMzd0eWQ5cmVhQkRnRzJBa1VsTS9CRkpFeVdQTWo2ZndOTUR1VG0v?=
 =?utf-8?B?cHNLQXAwczMyNFpmYzBOd1VWNTVScGxJVlljcnhDVE5Qa3ZkNVdyWGRodC81?=
 =?utf-8?B?akFSK1B4a1ZidmlxQm1XR0FzdWhyc0wvV0xJMjVQTWJSbU5UQjlsRHNZc0VU?=
 =?utf-8?B?aU13TDNOQVJOblMrMUZtckVuN1l2RHFtNGtKM1MxdmJPdE9SWmpNNFNmYzVS?=
 =?utf-8?B?SWtMaHA4L0FxRjNiSHh0YTJOU2hwdTZlSkZXSUU1N05tNHZEOGh2RU5mQXhX?=
 =?utf-8?B?SGJNT0tpTy9hN3hRR3ZMeS90ckZlV1NPa2pqOXc3elllZ3E2MTRMdDY4QXVQ?=
 =?utf-8?B?d0Znc2R6ZVgwUGhHREFFTmtNQ1hMeVNJZ2RocWRnbStvZTk0cGNkeThQWmhE?=
 =?utf-8?B?eG5QV1Q5NEFJQTRyMEpsdkJQUmcvMzYxOTJjOFVlNUowY0ZRczNieEh0Sklh?=
 =?utf-8?B?Qmk5OCtob0lsU0xMWDhRRzh1SXpKNU12UFZUTXMxQ3E0TVhaN2NXVkxPZ21E?=
 =?utf-8?B?VEhvYldobUhqTllGWEFtZCtWL2dRSjhNRC90MXNGaHc2bG0rNUlrTFBuSm1y?=
 =?utf-8?B?eFVyUTBXbGxFZGxmQlAva3FlRitja3dxNm9tMmRVWHdFRHlUWWppOEZFMUg3?=
 =?utf-8?B?Rk9GRnVwWUhLRkZxSWd2U3p0eC9xOC8vZ2VJMjJKMGw4SDBMbFljZ05CTm0v?=
 =?utf-8?B?RjhtenJVUDNDTEFpZ1paTWJYVlRrV3lFTXl3RnlBaEUyY1F6Vm5yT1MwSXc2?=
 =?utf-8?B?c2dPcU04Y0M0K1k1SmFWWTdtTkNldzhtRmlVVG9XOUJKRnZFWGRPM1M1Ti9q?=
 =?utf-8?B?M2RzbkVwUGIrMWRmekFVRVpKbFVBL2tFR3U2QVhTVjl3K2J5SnJSR1B1NG55?=
 =?utf-8?B?T0dGbVFhSE5QWGZDVzNHRHpnREExbnYrb214N0lVRUZ3RnhwQWoyWHRtbCtk?=
 =?utf-8?B?U3hWUXJPWGhmN0FpVk5uNDd4LzBrZ05TdEhEQ0ttYkhRdDliRGhXYkw1TDc0?=
 =?utf-8?B?NVB3eFliaG5oaGJyZXkzUTBtS0tTcUNMVmNLZGVMcUxUY1UvSFR3bkRWTEpp?=
 =?utf-8?B?KzZpTnJVNDdHUzZvTXU0bEUzWG8xUVJKakJqSEtRenREQTVOU1dXYzJ5V3RO?=
 =?utf-8?B?M1VrcjlEaDZsWStVdjZ0T24wcW8xcEpwZmc4bEY2OXFIVzdOUGt1NjRKM2w0?=
 =?utf-8?B?MFIxVkpMdThvUUQxSVRod2loK085cFFWNDVUckVTelRmTkRubjhvakkwRE1R?=
 =?utf-8?B?NlBpUjFiaVVHVTZZcUhMTWxaSlB5STdQdmN6RGxCNTA4aDBZNGVCMW5sTTFk?=
 =?utf-8?B?dkhDL1N1cXVlQ3FIazZ4R1hkSmJqT1hLRW5Wb1llVi9BUkRHTDdSUTNpbm5R?=
 =?utf-8?B?Wk1kR2hDTGhyU1ZDYjV1TDh0Q2lpR3pNRnhXRjZycUhIMlBuSng5ckw2OGIw?=
 =?utf-8?B?RlhFSnJnTUdCKzJKV3N0SUdJb1FpMjl4ZG5yMUJncENOcDE0RGJNOVYrRTZm?=
 =?utf-8?B?R1llclNDdnk5RllCVXFVSmVNWEU5Z1AxRzd0T2RuOXNrOXc4bUt0MFNBbVJo?=
 =?utf-8?B?WU1jNlc5eE85YUx5dTBSWXljc0hQMkJtc1NISDRPRFBOUCs5Mzd4Q2ZyczZI?=
 =?utf-8?B?NTVMMlA1eUZJdjNrcTA1VnhCVEFlUXZKcjBGeXNOamJUTWRxV3VtalZ0c3BW?=
 =?utf-8?B?RHFlR0JjNG92czVob3c4dUJmTWIxakEvSnA5ZG5JQ0J5T3paeFk1WTJZUzRv?=
 =?utf-8?B?a05WbU03TDY3UUp3VThHYnd3VDFnQTNRODJUSzhkajBBRlpadXBwek5hVWsr?=
 =?utf-8?B?Z2RQVE56aTVTWnJ2RlUzOVZFN3ZEcFdGbytqSDdVdFRHem84eUdTL0NlU2ZN?=
 =?utf-8?B?RmVKWWJPUVYxMHhpNVEvOFV5TWdqSUFJalVVcWEyVjRtZ2hMR3Q3UC9RMTVs?=
 =?utf-8?B?NlZmcVZ4RzFkNEtiMDBLVEVidFRyMU1DUXprYU8zdUo0ODQrbEdSZm5HL1VT?=
 =?utf-8?B?UjBqYzFDQm43SlFxYldTcmNJWS9Qekp3b3VWTUdLdVhrVDJXa0dhM0I3di9r?=
 =?utf-8?B?dTVXNmgwcVlySVVXTXczTSs5NTVOT09GS1dOZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b374c6-6bd9-4f6c-0a95-08de08737f66
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2025 03:08:48.4655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ks08YgRFagZihw1A9GCDAFhYhvsx0XggFbln7fVe0r6yrS9mGspOW6KXPpAxG0H2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB6835
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 11 Oct 2025 03:09:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18169

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSaWNoYXJkIFB1cmRpZSA8cmlj
aGFyZC5wdXJkaWVAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gU2VudDogZGVuIDkgb2t0b2JlciAy
MDI1IDEzOjQ4DQo+IFRvOiBQZXRlciBLamVsbGVyc3RlZHQgPHBldGVyLmtqZWxsZXJzdGVkdEBh
eGlzLmNvbT47IGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZw0KPiBTdWJqZWN0
OiBSZTogW2JpdGJha2UtZGV2ZWxdIFtQQVRDSF0gcnVucXVldWU6IE1ha2UgdGhlICJJbml0aWFs
aXNpbmcgdGFza3MiIHByb2dyZXNzIGJhciBmaW5pc2ggcHJvcGVybHkNCj4gDQo+IE9uIFNhdCwg
MjAyNS0wOS0yNyBhdCAwNzo1MyArMDIwMCwgUGV0ZXIgS2plbGxlcnN0ZWR0IHZpYSBsaXN0cy5v
cGVuZW1iZWRkZWQub3JnIHdyb3RlOg0KPiA+IFRoZSAiSW5pdGlhbGlzaW5nIHRhc2tzIiBwcm9n
cmVzcyBiYXIgbmVlZHMgdG8gYmUgZmluaXNoZWQgYmVmb3JlDQo+ID4gdXBkYXRlX3NjZW5lcXVl
dWVfZGF0YSgpIGNyZWF0ZXMgYW5vdGhlciBwcm9ncmVzcyBiYXIuDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBQZXRlciBLamVsbGVyc3RlZHQgPHBldGVyLmtqZWxsZXJzdGVkdEBheGlzLmNvbT4N
Cj4gPiAtLS0NCj4gPiDCoGJpdGJha2UvbGliL2JiL3J1bnF1ZXVlLnB5IHwgNSArKysrLQ0KPiA+
IMKgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL2JpdGJha2UvbGliL2JiL3J1bnF1ZXVlLnB5IGIvYml0YmFrZS9saWIv
YmIvcnVucXVldWUucHkNCj4gPiBpbmRleCA2M2Q0ZWRkODkyLi45NmQ3MDA4MGQzIDEwMDY0NA0K
PiA+IC0tLSBhL2JpdGJha2UvbGliL2JiL3J1bnF1ZXVlLnB5DQo+ID4gKysrIGIvYml0YmFrZS9s
aWIvYmIvcnVucXVldWUucHkNCj4gPiBAQCAtMTYxMCw3ICsxNjEwLDYgQEAgY2xhc3MgUnVuUXVl
dWU6DQo+ID4NCj4gPiDCoMKgwqDCoMKgwqDCoMKgIGlmIHNlbGYuc3RhdGUgPT0gUnVuUXVldWVT
dGF0ZS5TQ0VORV9JTklUOg0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzZWxmLnN0YXJ0
X3dvcmtlcihzZWxmLnJxZXhlKQ0KPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNlbGYucnFk
YXRhLmluaXRfcHJvZ3Jlc3NfcmVwb3J0ZXIuZmluaXNoKCkNCj4gPg0KPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAjIElmIHdlIGRvbid0IGhhdmUgYW55IHNldHNjZW5lIGZ1bmN0aW9ucywg
c2tpcCBleGVjdXRpb24NCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgbm90IHNlbGYu
cnFkYXRhLnJ1bnFfc2V0c2NlbmVfdGlkczoNCj4gPiBAQCAtMTk0OCw2ICsxOTQ3LDEwIEBAIGNs
YXNzIFJ1blF1ZXVlRXhlY3V0ZToNCj4gPiDCoMKgwqDCoMKgwqDCoMKgIHNlbGYuc3FkYXRhID0g
U1FEYXRhKCkNCj4gPiDCoMKgwqDCoMKgwqDCoMKgIGJ1aWxkX3NjZW5lcXVldWVfZGF0YShzZWxm
LnNxZGF0YSwgc2VsZi5ycWRhdGEsIHNlbGYpDQo+ID4NCj4gPiArwqDCoMKgwqDCoMKgwqAgIyBG
aW5pc2ggdGhlICJJbml0aWFsaXNpbmcgdGFza3MiIHByb2dyZXNzIGJhciBiZWZvcmUNCj4gPiAr
wqDCoMKgwqDCoMKgwqAgIyB1cGRhdGVfc2NlbmVxdWV1ZV9kYXRhKCkgY3JlYXRlcyBhbm90aGVy
IG9uZS4NCj4gPiArwqDCoMKgwqDCoMKgwqAgc2VsZi5ycWRhdGEuaW5pdF9wcm9ncmVzc19yZXBv
cnRlci5maW5pc2goKQ0KPiA+ICsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgIHVwZGF0ZV9zY2VuZXF1
ZXVlX2RhdGEoc2VsZi5zcWRhdGEuc3FfcmV2ZGVwcywgc2VsZi5zcWRhdGEsIHNlbGYucnFkYXRh
LCBzZWxmLnJxLCBzZWxmLmNvb2tlciwgc2VsZi5zdGFtcGNhY2hlLCBzZWxmLCBzdW1tYXJ5PVRy
dWUpDQo+ID4NCj4gPiDCoMKgwqDCoMKgwqDCoMKgICMgQ29tcHV0ZSBhIGxpc3Qgb2YgJ3N0YWxl
JyBzc3RhdGUgdGFza3Mgd2hlcmUgdGhlIGN1cnJlbnQgaGFzaCBkb2VzIG5vdCBtYXRjaCB0aGUg
b25lDQo+IA0KPiBIYXZpbmcgdGhpcyBjYWxsIGJ1cmllZCBpbnNpZGUgUnVuUXVldWVFeGVjdXRl
IGlzIG5vdCBnb2luZyB0byBpbXByb3ZlDQo+IGNvZGUgcmVhZGFiaWxpdHkgb3IgbWFpbnRhaW5h
YmlsaXR5Lg0KPiANCj4gQWxzbywgd2hpbHN0IEkgYWdyZWUgdXBkYXRlX3NjZW5lcXVldWVfZGF0
YSgpICptYXkqIHRyaWdnZXIgYSBwcm9ncmVzcw0KPiBiYXIgdXBkYXRlIGJ1dCBpdCBpcyBmYXIg
ZnJvbSBjbGVhciBob3cgaXQgZG9lcyB0aGF0LiBJIHN1c3BlY3QgaXQgZG9lcw0KPiBzbyB2aWEg
Y29kZSB0aGF0IGlzIHNzdGF0ZV9jaGVja2hhc2hlcygpIGluIHNzdGF0ZS5iYmNsYXNzIGluIE9F
LUNvcmUNCj4gYnV0IHRoYXQgaXMgbWV0YWRhdGEgZGVwZW5kZW50LCBtYXkgbm90IGFsd2F5cyBo
YXBwZW4gYW5kIHN1YmplY3QgdG8NCj4gY2hhbmdlIHRvdGFsbHkgb3V0IG9mIHN5bmMgd2l0aCB0
aGUgY29kZSBpbiBiaXRiYWtlLg0KPiANCj4gSSB0aGluayB0aGUgcHJvZ3Jlc3MgYmFyIGhhbmRs
aW5nIGNvZGUgbmVlZHMgdG8gdW5kZXJzdGFuZCBob3cgdG8gcnVuDQo+IG11bHRpcGxlIGJhcnMg
aW4gcGFyYWxsZWwsIG9yIGNsb3NlIGFueSBleGlzdGluZyBiYXJzIGlmIHByZXNlbnQgd2hlbiBh
DQo+IG5ldyBvbmUgaXMgdHJpZ2dlcmVkLg0KPiANCj4gU28gSSBkb24ndCB0aGluayB0aGlzIHBh
dGNoIG1ha2VzIHNlbnNlIGluIHRoaXMgZm9ybSwgc29ycnkuDQoNCkFuZCB5b3Ugd2VyZSBvZiBj
b3Vyc2UgY29ycmVjdCBpbiB0aGF0IGFzc2Vzc21lbnQuIFRoZSBzb2x1dGlvbiANCnByb3Bvc2Vk
IGFib3ZlIHdhcyBkZWZpbml0ZWx5IG5vdCB0aGUgY29ycmVjdCB3YXkgdG8gc29sdmUgdGhpcy4g
DQpJIGhhdmUgbm93IGR1ZyBkZWVwZXIgaW50byB0aGlzLCBhbmQgd2hpbGUgSSB3b3VsZCBoYXZl
IGxvdmVkIHRvIA0KbWFrZSBhIHNvbHV0aW9uIHRoYXQgc3VwcG9ydGVkIG11bHRpcGxlIHByb2dy
ZXNzIGJhcnMsIHRoYXQgd291bGQgDQpvbmx5IHJlYWxseSBoYXZlIGJlZW4gcG9zc2libGUgd2l0
aCB0aGUgaW50ZXJhY3RpdmUgS25vdHR5IFVJLiANClNvIGluIHRoZSBlbmQgSSB3ZW50IHdpdGgg
YSBzb2x1dGlvbiB0aGF0IGZpbmlzaGVzIGFueSBhY3RpdmUgDQpwcm9jZXNzIHByb2dyZXNzIGJh
ciBiZWZvcmUgc3RhcnRpbmcgYSBuZXcuDQoNCkkgd2lsbCBzZW5kIGl0IGFsb25nIHdpdGggYSBj
b3VwbGUgb2YgbWlub3IgaW1wcm92ZW1lbnRzIHRoYXQgSSANCm1hZGUgd2hpbGUgZGlnZ2luZyBp
bnRvIHRoZSBjb2RlLiBUaGVyZSBpcyBhbHNvIGEgc21hbGwgdHdlYWsgDQpuZWVkZWQgZm9yIHNz
dGF0ZS5iYmNsYXNzIHRvIGF2b2lkIHRoZSBzc3RhdGUgc3VtbWFyeSBmcm9tIA0KcG90ZW50aWFs
bHkgb3ZlcndyaXRpbmcgYW4gYWN0aXZlIHByb2dyZXNzIGJhci4NCg0KPiBDaGVlcnMsDQo+IA0K
PiBSaWNoYXJkDQoNCi8vUGV0ZXINCg0K

