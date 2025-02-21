Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942CFC021B3
	for <webhook@archiver.kernel.org>; Fri, 21 Feb 2025 16:36:05 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.89])
 by mx.groups.io with SMTP id smtpd.web11.27519.1740155758196705089
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Feb 2025 08:35:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=e4+qNUr6;
 spf=pass (domain: siemens.com, ip: 40.107.21.89, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NIcNRMgM287ELsg7xkBaQMzPQ+sBAnRLUhZ3xG1TjXJ61oYxYVISwirtqOnnw5PJs6kdKs0hcsBlMgeKQVWtIiPccHNO3nx0ZIH1bVOD0w2RPhBB+3z+WtUYvj3PO5txygLEJXPXGOVN+eVILYgtqeagX4Z2qtqCd0k53air3tJBJj0WPa/rWVC2i8CM6hkhCnDPxyFa1h7h4oV9VPqkl2WRZrg1wObsNsNLzm8neERaFaFzjzrWgwqG8iU5a3OcksLaHpLLz9eXGNUGhJ0+l6em+jDKVTEykd98TvUkGjUbGn4N0EDy+IMP+/bXJaMZg+Knsjlh6n0P4UC+en0yOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J97tpY3Dypg9xTdbskkakEMdjs11zBsoP8PnLvJjALI=;
 b=DSDnXVfYJ5KaOYnzqvM6KMZnHxSWrVEIgOHndCOCWNDPtZa1R2C1/bTUoDxjvCsX8Ycodl46uChbwqem47zqXQT45rnzQSbMJda+V4YL1KHOt3teD3E/KRox89ae8mr2jetp9LyuYFbPum/eYqDElxivBxz6mnL97H40CJYHkOeMLLl5CJXCCXu5MI4WibAfBmO6Wf+5vHXH8qqu+e06J4Yb+4xj5GvwSbvXI3WudFImN38Zv3qE8/BmO5ObjnlZqLhdrDvVkBAFhE+J3VN+DU6kEBrWYgQAni9WJ22Rrhz8jaCE0QCy3Ep0ZfkS/Sijcqka/ZFZvprDnIeZ/iOR2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J97tpY3Dypg9xTdbskkakEMdjs11zBsoP8PnLvJjALI=;
 b=e4+qNUr60As9lW/M7JAKHIhwuq/c05DCECSpL/vBcMXABslm/A/30i/zIIaRFzBfBCIoLSGK5QbKkRu+Exj90IKJn8HV2dRNhVGmLPAMvAZwQVLTaqUPKAXr8NLFVsr1+ig85foZN4fa8e/mnbTZTXm3n4VlB0Czqq5q5pylnKheA7mLLfSb0G0UogxAYrHl+p+Cw1tfiTuI76JK888SG39FSqBLVs6Bkn8U2+Th0vjiFJA/Sk/2XSuSWj26wxwkpOT5Foz5/wc+UYoGcaA6bp+OOATDpcsbc50pO57sQt+HIyDRyvBHAx7swfXN/qm3RX3XoMrWIDm57IJXchClkA==
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by DB8PR10MB3831.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:16b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 16:35:53 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%6]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 16:35:53 +0000
From: "Koch, Stefan" <stefan-koch@siemens.com>
To: "quentin.schulz@cherry.de" <quentin.schulz@cherry.de>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: "Sudler, Simon" <simon.sudler@siemens.com>,
	"richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
	"Kiszka, Jan" <jan.kiszka@siemens.com>, "alex.kanavin@gmail.com"
	<alex.kanavin@gmail.com>, "docs@lists.yoctoproject.org"
	<docs@lists.yoctoproject.org>
Subject: Re: [bitbake-devel] [PATCH v3 2/4] bitbake-user-manual: Update
 documentation for fast `BB_GIT_SHALLOW`
Thread-Topic: [bitbake-devel] [PATCH v3 2/4] bitbake-user-manual: Update
 documentation for fast `BB_GIT_SHALLOW`
Thread-Index: AQHbg7ywPChv22NuEkWFt4cwA9C7E7NRlekAgABcXACAAAJvAIAAASoA
Date: Fri, 21 Feb 2025 16:35:53 +0000
Message-ID: <03abd458035cc7a1e4affda62ceccae3b4746ccf.camel@siemens.com>
References: <20250220172706.3850722-1-stefan-koch@siemens.com>
	 <20250220172706.3850722-2-stefan-koch@siemens.com>
	 <46ecb25e-9034-4da0-9c20-606dca371ba9@cherry.de>
	 <7cc484189ee7db4f27523351993ab454424d0794.camel@siemens.com>
	 <22a6cd68-6dd1-49af-878c-fcd7b40e275c@cherry.de>
In-Reply-To: <22a6cd68-6dd1-49af-878c-fcd7b40e275c@cherry.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR10MB4959:EE_|DB8PR10MB3831:EE_
x-ms-office365-filtering-correlation-id: d746518b-f9e4-40a5-ddd2-08dd5295cf49
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?dERpTm91M0IzR3NRS0RhM2FDSW1aL2lPWHpNc3pMQTlLZG5za25zOExldHBk?=
 =?utf-8?B?RjRraXJGTyt1NnFSTDNuUm45dGxhY2xQT1UrODFzZTJJY0hnU2ZxYXF3Tytz?=
 =?utf-8?B?RllBK2l4WE43cVNiTi9LMmREWjRBSWsxdTZJbzV0a1QrRE9YWi9PbHNBL3pB?=
 =?utf-8?B?bGZQbjJlZzE3S0UrT2VvREhQeUQyaUI5b0t5QjZLOXNyMDJ5MExoSVhqc1Ux?=
 =?utf-8?B?M0RzTVBkWlVpankydWlONjlOS0lJbXUrcmxhS21tcFhYSEZhUmVIK1RDMCto?=
 =?utf-8?B?alh2T0YrT25RM1B6UHFaVFdtanh0RTc4NEgxNWgxWUhnODk5L3Q2M0ZGbEx2?=
 =?utf-8?B?YUQ5cGpJb3pDMjZHWE5jbjNiRkdjMEdCVmJNZ2VwWWNIcGpWTTMrYVdoazU4?=
 =?utf-8?B?WVR1TXNXYU80RjVsNHVGNmg3Ym55eC9QSDZSS3RoZ3JjbmU2ajgzc2h2Q09H?=
 =?utf-8?B?aVJkbCtQOUtSMWc1VlBFNlFrY0d4TjlWaXh5U0hGcmFmSHhwRS9ISlJ5ZE1j?=
 =?utf-8?B?R0VIeFFKL3BVQ0ptUW5SZTRtOWlCSG1CSjJRbk5oUzZ3ZExXblg1L0V6cUhi?=
 =?utf-8?B?d2hkOTU3bVFmaFllR2FLazhLN2JqUVRWY3BNa2V3MXRGVEdzTXhZdEVaQk1z?=
 =?utf-8?B?cTEwY0pJM2k3eXRRUFpGSjR2RE9zaTUySC8xb2pTalpFTmpBUVBiZTRQOHR5?=
 =?utf-8?B?R0R1d3JzT29mb215bjd1L2VPc29IdnBlVXNrc0wzR1hnZHozclBYaWxxdzZw?=
 =?utf-8?B?VEFlWEk2ajlHVUxQYzBJUjNhV0tHRmdRREhYOVgwV2Z0Zk1oRDJabkhDRmlz?=
 =?utf-8?B?YmFVZFdUZmZhUU5WcE5TNVl2ZGMvSjBsbXVpcE83VndZTXkyTlRDMjhKOEps?=
 =?utf-8?B?bXhjcStkckNHOFNzK09TWlZwaWhlN1ZkQkl1ekJFc2pMeWZyYmZMeVFKQnc1?=
 =?utf-8?B?cTZnSGh2ZFI0OS9XaGNIZ1JSWEJmaTBRQktyYWRJQXMxbUhWclBTVGZRdFky?=
 =?utf-8?B?N1k2UEF2YXJBYmRhYTd4QVBYQjRmWlFuYjQrcU1HUHRzaitMandUWndxcXNi?=
 =?utf-8?B?NnhnWjRFMjhQV01jTDFsZXdMSzdiWHJNdm1LTXArMlloYytlWm1EbkV3b3Qw?=
 =?utf-8?B?K0dmOUxEaUFrMFdFTUMvRUlHanhwZDRXSmJmREt5U3VDMklLM0x0ZElqU3gr?=
 =?utf-8?B?S0lIbEhQMHducS9CK04rdXo4QmdMaFJZNDFDL1hYL1JJSnFISUE3bWliUWhX?=
 =?utf-8?B?RGRsOEdHUldXdjlNNnlYRVlaQXRMaWRHVFdMcGZ5UmNFTjB6R1ZnY3N1VXY2?=
 =?utf-8?B?V21kWnZiZ0E2MFdCYkxIR0hPRzRqdk9IQzdmRjJnRG9NVTVTZnlvYk1HeDRw?=
 =?utf-8?B?dW50QjRiWHo4QXQyWXF0bG1GTHMzS3orbmgwcVduTG9tRkNwZFVkdTlPamxQ?=
 =?utf-8?B?YXN4amNKend2ajVmSE9BRmxOVndzT01TWXJ1SkhnYXZyZldWS1RvOWRIYlFq?=
 =?utf-8?B?Z1NPVkliN0hLOFhyZDNmMllPajRPdCtZQ1JyNzZubEFUeDZTUjVubmZJK295?=
 =?utf-8?B?Qmh4MSsvbVV4aExKVWRwNWc0K3JtZGZZNDUwTzUwSlBuSzc2YkNJZXZKVjJN?=
 =?utf-8?B?WmV2MlBoT2xaeExqeTRBV1c3WTQyK1lwRkdjZmhNMHAzdTU3N21QdXh3NHNp?=
 =?utf-8?Q?dYh6NzYsbdvRs+vtcVQX?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?S2JjOWR1ZFVZSFk3cEVhSFFVSzlKSlhnNlVqRm9EUlpJZG5PNStjUC9vQ2Uw?=
 =?utf-8?B?bGdlTDJMdWtoTFhwcXBUTWFhSGFZcjdkTHJaR2E5SDdSQVlHMkVMSkljdXpO?=
 =?utf-8?B?N1dzZExUL1dSczlRMDRPMm9PMmJ1NCtPeDc2TWpoYUdST2xpQlpSSVVDMk1M?=
 =?utf-8?B?bEFKQzVnbm5XMkt2WWZuRWVIcWo1bGdzZ2tPdmZXVFJ0cEd2NGhWRVRqN1NT?=
 =?utf-8?B?c0lGOEJic3l3b0NYRzhKN3A4QUQ5Wjlod3BRZzU0WDhNbUUvKzFQZFlKZ2pG?=
 =?utf-8?B?U3dlWEhjdy8vcUlHNnNnSmFSTlkvTWdaZTdzTG1IYVdMMFBQVjVZNjNXbCsw?=
 =?utf-8?B?bnVyRTlPbWZXQ21vV0piVmxlSkxubER6YlRwdmR0dVkxb01nK0U4eTdIcTM5?=
 =?utf-8?B?VDZYaE5OOG5jUHpPU2dHdXFGSFdzVEpJcGY2Q3k4dUQwbDR5dXVXaE5SSGg0?=
 =?utf-8?B?akFGemZSUTNENkdsbnM3amFvdlhhc1JJQnRLVnNMRDY0WEZBMnZRZkZLc1pJ?=
 =?utf-8?B?UVpjODYzc21iaEQ4Q09yaXlPRnBkaG5JNHpoMnlLUFljMnBZWTlTQjFabjVZ?=
 =?utf-8?B?WE1jdTcxZnFRWFh3MTVDcnhKRGhNbGdPZ0hoMXlBWEVIWS9XUWJnV0lDVmJK?=
 =?utf-8?B?T2ZXOFNSV3Q4TTBGdC9vNmhpVk5iSTZCbndmRzV0T2VURVk2Q0ZUeEcxNGU4?=
 =?utf-8?B?Sk1XRFRHWTZZS1l2TmU3c3RxZEtoV0lSU1BmUkt4LzZwVkJjWGJIQ0ZCRVd1?=
 =?utf-8?B?MlBrTSttM2hYMkQ1WVlBS1VlUHZSWDV3NFphcXpHRDhUM0JxUkxWTXVUMDNZ?=
 =?utf-8?B?Y1BSSkNBaWRpYjJBTTBHYStDL0QvOFBxREsva0dlUlFNYzJhdG5zSEc4NUd6?=
 =?utf-8?B?RDBGVlBmSHJsL2xyWUhaVWdVWDBpNkdQNC9aMFVlNTJnNmVRdFpsRjEyOHcr?=
 =?utf-8?B?RDBoRm94Yi9IRS95SFJ0QjUyS2EyeWdYcUF6bjZXTkZBSXFYeld5eXRLWTQv?=
 =?utf-8?B?UDRwQjVDdUVoZlo3QmFOc3ozbXpFdnBJLy9KdXFsdVVGWENXMHd6QjNPYVdN?=
 =?utf-8?B?RlNWTnFnY3FMZWNkYXgzZHhUcnVUdFlXSEs2RXMrRXNvUll0TitkNWd2eEUw?=
 =?utf-8?B?alJnL3FFb2tBa3ErSUN0UkdmOUhKMENvQmZpVlIzWERyN1Nid2JBR3B5V09F?=
 =?utf-8?B?Q2pNOXlHSko0NGdBODFuQzd2N2VScStxNXBHSEthb3RJdjVmTEJtYjRvL2Vt?=
 =?utf-8?B?OTJicWpMWkVsM0FiZFRYRTZJL1FzdVF5dVB2QktTZzZzRUx2ZTRiWjZQZHpC?=
 =?utf-8?B?ME5rTnRtZHU1dXg2eWl6WFlDZENkWDdBeVhheFFYcGlhUXVJd3EwKzYxYnhh?=
 =?utf-8?B?SUltczIzSVVkSG9Eb1hQa2RuQ0g2L2lYU1Q3OFFVWUswdU5DYmQweCtTNjl5?=
 =?utf-8?B?a2UyK1NleEhVZHA2a1NYM3FxcnE4dnVyaWNRU01JODh4M2U0OGhlZXdCMExa?=
 =?utf-8?B?UXhRNlpBVXpLTmVnNFA3aG1DY3huYXEyMjNncmgrQ0VGd0xvdkpqVkQxbEdy?=
 =?utf-8?B?RVhMcnZVQ2plcE05NWZYOHJWbXF5S1dqVWFPMmN5ZlJNaVdoUHFMUjAyOUx1?=
 =?utf-8?B?dTlsalBjUzQvNG8yUGlwanV6SkRwN291MHgwcWs0SGpkRGFlcFZuSGt2MUdx?=
 =?utf-8?B?TGh4RDUvaGpvNnJPeFhJL0RJNnB0a3EwNzJQWmhrV0lGTktmMXlJWlRPUERw?=
 =?utf-8?B?bXJ0R0poZXo4VDVBTVkxY3l2OFZxN3MzVSs5ZmM4SGlqUFBDUHFTZHM1Z3cr?=
 =?utf-8?B?eUdtMlMwQ3pFb0M4YzVaTU9CbjQxMGdhdTRKYVZsWnFjbjgzTEtMVm1sd3FC?=
 =?utf-8?B?aGo4eHppSUwzVGR5bHBaY3FUcXFaWDRSdUpNV3dINWVMdFk5TnZsQTlhMzE2?=
 =?utf-8?B?U1lnbXlNYVRSUEs4UjJrWHE1Zjh6V2lzZktvNkg1Q2dQdE0yZEZkSFYvamsx?=
 =?utf-8?B?YS8zbG9LTms0MmxmOGVaekhJVkh6ZjJXdEI4dWJOK0hPRzNLdVZad3NzT0tH?=
 =?utf-8?B?bHllZ3hpYWZrZnA1MmVZcmVyTkZXNUJ5elhmNmRWdGZyYlBlNGE0QjlxeDh5?=
 =?utf-8?B?bThVRFhZNVdXWjJrbTdkRFR2WUp4cjR1R3BrQjRpT2o4ekFtZHBaS0xWaUUw?=
 =?utf-8?B?SlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <525B8D6677E0C049B757E25F52FEC9CB@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d746518b-f9e4-40a5-ddd2-08dd5295cf49
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 16:35:53.7460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Zz/WwIf4hIRcBYgdMm7SYTGZNKo43z/qMHDUF/KKNKz2Sghqnjt2NS81GCw2rt6YeSiRUWOAdN/1paXBs9aoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3831
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Feb 2025 16:36:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17280

T24gRnJpLCAyMDI1LTAyLTIxIGF0IDE3OjMxICswMTAwLCBRdWVudGluIFNjaHVseiB3cm90ZToN
Cj4gSGkgU3RlZmFuLA0KPiANCj4gT24gMi8yMS8yNSA1OjIzIFBNLCBLb2NoLCBTdGVmYW4gd3Jv
dGU6DQo+ID4gT24gRnJpLCAyMDI1LTAyLTIxIGF0IDExOjUyICswMTAwLCBRdWVudGluIFNjaHVs
eiB3cm90ZToNCj4gPiA+IEhpIFN0ZWZhbiwNCj4gPiA+IA0KPiA+ID4gUGxlYXNlIENjIHRoZSBk
b2NzIG1haWxpbmcgbGlzdCBhcyB3ZWxsDQo+ID4gPiANCj4gPiA+ICtDYyBkb2NzDQo+ID4gVGhh
bmtzLiBJJ2xsIHNlbmQgdXBkYXRlZCBkb2NzIGluIHY0IHBhdGNoIHNlcmllcy4NCj4gPiA+IA0K
PiA+ID4gT24gMi8yMC8yNSA2OjI3IFBNLCBLb2NoLCBTdGVmYW4gdmlhIGxpc3RzLm9wZW5lbWJl
ZGRlZC5vcmcNCj4gPiA+IHdyb3RlOg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gS29j
aCA8c3RlZmFuLWtvY2hAc2llbWVucy5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiDCoMKgIC4u
Li9iaXRiYWtlLXVzZXItbWFudWFsLXJlZi12YXJpYWJsZXMucnN0wqDCoMKgwqDCoMKgwqAgfCAx
Ng0KPiA+ID4gPiArKysrKysrKysrKy0tLS0tDQo+ID4gPiA+IMKgwqAgMSBmaWxlIGNoYW5nZWQs
IDExIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+ID4gPiA+IA0KPiA+ID4gPiBkaWZm
IC0tZ2l0IGEvZG9jL2JpdGJha2UtdXNlci1tYW51YWwvYml0YmFrZS11c2VyLW1hbnVhbC1yZWYt
DQo+ID4gPiA+IHZhcmlhYmxlcy5yc3QgYi9kb2MvYml0YmFrZS11c2VyLW1hbnVhbC9iaXRiYWtl
LXVzZXItbWFudWFsLQ0KPiA+ID4gPiByZWYtDQo+ID4gPiA+IHZhcmlhYmxlcy5yc3QNCj4gPiA+
ID4gaW5kZXggYWQyMTliNTMxLi5mNzgxYzAwNGUgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RvYy9i
aXRiYWtlLXVzZXItbWFudWFsL2JpdGJha2UtdXNlci1tYW51YWwtcmVmLQ0KPiA+ID4gPiB2YXJp
YWJsZXMucnN0DQo+ID4gPiA+ICsrKyBiL2RvYy9iaXRiYWtlLXVzZXItbWFudWFsL2JpdGJha2Ut
dXNlci1tYW51YWwtcmVmLQ0KPiA+ID4gPiB2YXJpYWJsZXMucnN0DQo+ID4gPiA+IEBAIC0zMTUs
MTEgKzMxNSwxNyBAQCBvdmVydmlldyBvZiB0aGVpciBmdW5jdGlvbiBhbmQgY29udGVudHMuDQo+
ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqAgbWlycm9yIHRhcmJhbGwuIElmIHRoZSBzaGFsbG93IG1p
cnJvciB0YXJiYWxsIGNhbm5vdA0KPiA+ID4gPiBiZQ0KPiA+ID4gPiBmZXRjaGVkLCBpdCB3aWxs
DQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqAgdHJ5IHRvIGZldGNoIHRoZSBmdWxsIG1pcnJvciB0
YXJiYWxsIGFuZCB1c2UgdGhhdC4NCj4gPiA+ID4gwqDCoCANCj4gPiA+ID4gLcKgwqDCoMKgwqAg
V2hlbiBhIG1pcnJvciB0YXJiYWxsIGlzIG5vdCBhdmFpbGFibGUsIGEgZnVsbCBnaXQgY2xvbmUN
Cj4gPiA+ID4gd2lsbCBiZSBwZXJmb3JtZWQNCj4gPiA+ID4gLcKgwqDCoMKgwqAgcmVnYXJkbGVz
cyBvZiB3aGV0aGVyIHRoaXMgdmFyaWFibGUgaXMgc2V0IG9yIG5vdC4NCj4gPiA+ID4gU3VwcG9y
dA0KPiA+ID4gPiBmb3Igc2hhbGxvdw0KPiA+ID4gPiAtwqDCoMKgwqDCoCBjbG9uZXMgaXMgbm90
IGN1cnJlbnRseSBpbXBsZW1lbnRlZCBhcyBnaXQgZG9lcyBub3QNCj4gPiA+ID4gZGlyZWN0bHkN
Cj4gPiA+ID4gc3VwcG9ydA0KPiA+ID4gPiAtwqDCoMKgwqDCoCBzaGFsbG93IGNsb25pbmcgYSBw
YXJ0aWN1bGFyIGdpdCBjb21taXQgaGFzaCAoaXQgb25seQ0KPiA+ID4gPiBzdXBwb3J0cyBjbG9u
aW5nDQo+ID4gPiA+IC3CoMKgwqDCoMKgIGZyb20gYSB0YWcgb3IgYnJhbmNoIHJlZmVyZW5jZSku
DQo+ID4gPiA+ICvCoMKgwqDCoMKgIFRoaXMgc2V0dGluZyBjYXVzZXMgYW4gaW5pdGlhbCBzaGFs
bG93IGNsb25lIGluc3RlYWQgb2YNCj4gPiA+ID4gYW4NCj4gPiA+ID4gaW5pdGlhbCBmdWxsIGJh
cmUgY2xvbmUuDQo+ID4gPiA+ICvCoMKgwqDCoMKgIFRoZSBhbW91bnQgb2YgZGF0YSB0cmFuc2Zl
cnJlZCBkdXJpbmcgdGhlIGluaXRpYWwgY2xvbmUNCj4gPiA+ID4gd2lsbA0KPiA+ID4gPiBiZSBz
aWduaWZpY2FudGx5IHJlZHVjZWQuDQo+ID4gPiA+ICsNCj4gPiA+ID4gK8KgwqDCoMKgwqAgRm9y
IHVwZGF0ZXMsIHdoZW4ga2VlcGluZyB0aGUgY2FjaGUgd2l0aGluIHRoZSBkb3dubG9hZA0KPiA+
ID4gPiBkaXJlY3RvcnksDQo+ID4gPiANCj4gPiA+IEkgZ3Vlc3MgYnkgInVwZGF0ZXMiIHlvdSBt
ZWFuIHBvaW50aW5nIHRvIGEgZGlmZmVyZW50IGNvbW1pdCBoYXNoDQo+ID4gPiB0bw0KPiA+ID4g
ZmV0Y2ggZnJvbSB0aGUgcmVtb3RlPw0KPiA+IEV2ZXJ5IHRpbWUgd2hlbiB0aGUgU1JDUkVWIGNo
YW5nZXMNCj4gDQo+IEkgY2FuIHRoZW4gc3VnZ2VzdDoNCj4gDQo+IFdoZW4ga2VlcGluZyB0aGUg
Y2FjaGUgd2l0aGluIHRoZSBkb3dubG9hZCBkaXJlY3RvcnksIGEgY2hhbmdlIHRvIA0KPiA6dGVy
bTpgU1JDUkVWYCBtYXkgaW5kdWNlIGEgc2lnbmlmaWNhbnRseSBoaWdoZXIgZGF0YSB0cmFuc2Zl
cg0KPiBiZWNhdXNlIA0KPiBlbnRpcmVseSBuZXcgc2hhbGxvdyBjbG9uZXMgYXJlIHJlcXVpcmVk
Lg0KPiANCj4gPiA+IA0KPiA+ID4gSXMgdGhlcmUgYSBwb3NzaWJsZSBzZXR1cCB3aGVyZSB0aGUg
Y2FjaGUgaXMgbm90IHdpdGhpbiB0aGUNCj4gPiA+IGRvd25sb2FkDQo+ID4gPiBkaXJlY3Rvcnk/
IE5vdCBzdXJlIHRvIHVuZGVyc3RhbmQgdGhlIGltcGxpY2F0aW9ucyBoZXJlPw0KPiA+IFJlZ2Fy
ZGxlc3Mgb2YgY2xlYW5pbmcgdGhlIGNhY2hlIHRoZSBlZmZlY3QgaXMgdGhlIHNhbWUuDQo+ID4g
V2hlbiBub3QgdXNpbmcgc2hhbGxvdyBhbmQgaGF2ZSBhIGNhY2hlLCB0aGUgZGVsdGEgZG93bmxv
YWRzIGZvcg0KPiA+IFNSQ1JFVg0KPiA+IGNoYW5nZSBhcmUgc21hbGxlci4NCj4gDQo+IE9LLCBJ
IHRoaW5rIEkgc2VlIHdoYXQgeW91IG1lYW4gaGVyZS4gRG9lcyAiY2FjaGUiIGZvciB5b3UgbWVh
biB0aGUNCj4gZ2l0IA0KPiByZXBvIGZvciB0aGUgcmVjaXBlIGluIERMX0RJUj8NCj4gDQo+IEkg
dGhpbmsgdGhlIHBvaW50IHlvdSdyZSB0cnlpbmcgdG8gbWFrZSBpczoNCj4gDQo+IElmIERMX0RJ
UiBpcyBwZXJzaXN0ZW50IGJldHdlZW4gYnVpbGRzLCB1c2luZyBzaGFsbG93IGNsb25lcyBtYXkN
Cj4gaW5kdWNlIA0KPiBzaWduaWZpY2FudGx5IGhpZ2hlciBkYXRhIHRyYW5zZmVyIHRoYW4gd2hl
biB1c2luZyBiYXJlIGNsb25lcywNCj4gYmVjYXVzZSANCj4gZW50aXJlbHkgbmV3IHNoYWxsb3cg
Y2xvbmVzIGFyZSByZXF1aXJlZCB3aGVyZWFzIGJhcmUgY2xvbmVzIG1heQ0KPiBzaW1wbHkgDQo+
IGJlIHVwZGF0ZWQuDQo+IA0KPiBEaWQgSSBnZXQgdGhhdCByaWdodD8gSSdtIGJlaW5nIGNhcmVm
dWwgYWJvdXQgdGhlIHVzZSBvZiAiY2FjaGUiIGhlcmUNCj4gYmVjYXVzZSB3ZSBhbHJlYWR5IGhh
dmUgc3N0YXRlLWNhY2hlLCBoYXNoc2VydiB0aGF0IGRvZXMgb3BlcmF0ZSBsaWtlDQo+IHNvbWUg
a2luZCBvZiBjYWNoaW5nLCBiaXRiYWtlIHBhcnNpbmcgY2FjaGUsIGV0Yy4uLg0KDQpUaGF0IHdh
cyB3aGF0IEkgaGF2ZSBwcmVwYXJlZCBmb3Igbm93Og0KDQpUaGlzIHNldHRpbmcgY2F1c2VzIGFu
IGluaXRpYWwgc2hhbGxvdyBjbG9uZSBpbnN0ZWFkIG9mIGFuIGluaXRpYWwgZnVsbA0KYmFyZSBj
bG9uZS4NClRoZSBhbW91bnQgb2YgZGF0YSB0cmFuc2ZlcnJlZCBkdXJpbmcgdGhlIGluaXRpYWwg
Y2xvbmUgd2lsbCBiZQ0Kc2lnbmlmaWNhbnRseSByZWR1Y2VkLg0KDQpIb3dldmVyLCBldmVyeSB0
aW1lIHRoZSBzb3VyY2UgcmV2aXNpb24gY2hhbmdlcywgcmVnYXJkbGVzcyBvZg0Kd2hldGhlciB0
aGUgY2FjaGUgd2l0aGluIHRoZSBkb3dubG9hZCBkaXJlY3RvcnkgaXMgY2xlYW5lZCB1cCBvciBu
b3QsDQp0aGUgZGF0YSB0cmFuc2ZlciBtYXkgYmUgc2lnbmlmaWNhbnRseSBoaWdoZXIgYmVjYXVz
ZSBlbnRpcmVseSBuZXcNCnNoYWxsb3cgY2xvbmVzIGFyZSByZXF1aXJlZCBmb3IgZWFjaCBzb3Vy
Y2UgcmV2aXNpb24gY2hhbmdlLg0KT3ZlciB0aW1lLCBudW1lcm91cyBzaGFsbG93IGNsb25lcyBt
YXkgY3VtdWxhdGl2ZWx5IHRyYW5zZmVyDQp0aGUgc2FtZSBhbW91bnQgb2YgZGF0YSBhcyBhbiBp
bml0aWFsIGZ1bGwgYmFyZSBjbG9uZS4NClRoaXMgaXMgZXNwZWNpYWxseSB0aGUgY2FzZSB3aXRo
IHZlcnkgbGFyZ2UgcmVwb3NpdG9yaWVzLg0KDQpFeGlzdGluZyBpbml0aWFsIGZ1bGwgYmFyZSBj
bG9uZXMsIGNyZWF0ZWQgd2l0aG91dCB0aGlzIHNldHRpbmcsDQp3aWxsIHN0aWxsIGJlIHV0aWxp
emVkLg0KDQpUaGFua3MgZm9yIHRoZSBleGFtcGxlcy4gSSdsbCBsb29rIGhvdyB0byBpbnRlZ3Jh
dGUgaXQuDQoNCldpdGhpbiB0aGUgRExfRElSLCB0aGVyZSBpcyBhIHN1YmRpciAiZ2l0IiB0aGF0
IGNvbnRhaW5zIHRoZSBiYXJlDQptaXJyb3IgY2xvbmVzLiBUaGUgc2hhbGxvdyB0YXJiYWxscyBh
cmUgZGlyZWN0bHkgd2l0aGluIERMX0RJUg0KPiANCj4gQ2hlZXJzLA0KPiBRdWVudGluDQoNCi0t
IA0KU3RlZmFuIEtvY2gNClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K

