Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDDEC021B5
	for <webhook@archiver.kernel.org>; Fri, 21 Feb 2025 16:23:15 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.43])
 by mx.groups.io with SMTP id smtpd.web11.27120.1740154985720301145
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Feb 2025 08:23:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=rnzS4LJL;
 spf=pass (domain: siemens.com, ip: 40.107.162.43, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IlatpNsxUC3/CWz98Cqo9AhaQRcXTgcXFdFfbGeBBXhU9XriI3dgyYto0GYL3nGka1Vq8O0Ds5ILcfdXdJIkj1GCWxgWETA11HhWnuP3AjRptIA6WkC8kKwwqGVW+WSIxRUW+5MeCshiRMlJe+ElMOaBFQFrIxKTDkSo1pYP4i+9aunHMgswOuJy2qjoC/hn1kecVgkY2LfP+HOxkLvauSybDy4VxU3GGw2B044k89oM8RjpKvBCtKxS22EUP8x3BfRdzgO7C2QY+piqDNZ3G2tiAb68CGIPRjSOn5s/2xy8iDmSVCUtGVKykYH+gk5wXrA642lYXzofbgD5pWAlaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CY2w4V/qe7nE6cPfLlQU3mGHisIYOjoY6kCCifFRv8M=;
 b=oOzrCC9ZvQ8G5/mEPMskU58vlHzqVTZASlFkME6hX8faVOAfl71yrm/5D0NDA8hWwQigiR6Wh2yxWw6gp9b7i5D/gL3X4zTSyXRDtuDxRpTCOXWR03RHu3f7+uLqrVKm2wuHYS0WdGZ04xHysQfhxjAR3ajlJi7UFMb0Pz+KtiBJmLbN+ZlSYbr8hTxvbP4+SgOO9mfxVSfOZ8vqUTxXe/5SJck7nu5hjVlL3HS1tpK5MTNE8PqSVwj4YM9YWjSnV1OAmhTFHKJFwm97pY1b8ZKcORGQ6NTI3WSlXGcLaOoemVlOdlvwcUC3ML2+AeqdxHhhv9BDfHTqNsKcrcgxYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CY2w4V/qe7nE6cPfLlQU3mGHisIYOjoY6kCCifFRv8M=;
 b=rnzS4LJLyIqBz+WKBa2HbVBvSUNai7qHdBWAskTsGIwgFYWIW0rDPSef6Jkouv6vvbjC+RKDw5JfVTxVjLZu56JMOIWlogyhm2Ky6b3SqOfcQNoForQDWprNuS9poBWkynImMQ3yBHP3JmivIQJbJ+Mf+erQ7kDd7ljyY5/yZXCoZTIrASj7u6gylfFInlmDR0/iy/MA5sN6Jyh+IvxzgeP833g8rdSiJc/Gxr3bUJrU9+RyNJHZNg6aaVNGJi+8tiGmA/j6MCwIAfvksZqvtTgcRdSuQMnlxjppn6t1PS90H8GY6QkoO8sF9uONhODp6UhRQue7KK5XrXJWyc0QSg==
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by PAWPR10MB7697.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:35f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 16:23:01 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%6]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 16:23:01 +0000
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
Thread-Index: AQHbg7ywPChv22NuEkWFt4cwA9C7E7NRlekAgABcXAA=
Date: Fri, 21 Feb 2025 16:23:01 +0000
Message-ID: <7cc484189ee7db4f27523351993ab454424d0794.camel@siemens.com>
References: <20250220172706.3850722-1-stefan-koch@siemens.com>
	 <20250220172706.3850722-2-stefan-koch@siemens.com>
	 <46ecb25e-9034-4da0-9c20-606dca371ba9@cherry.de>
In-Reply-To: <46ecb25e-9034-4da0-9c20-606dca371ba9@cherry.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR10MB4959:EE_|PAWPR10MB7697:EE_
x-ms-office365-filtering-correlation-id: 23667c5c-6943-4354-e9e7-08dd52940324
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?VVpKOWdkNmtlTDZaQ3lVYU5PcFVsSk5sUlo1S3QyUzZNT3Z3NENGem13OVJt?=
 =?utf-8?B?SCtsNzV5S1ZCTU4rNXRkaWJJWndiSVFVS1lycUwrRmNLeFUrZkEwckpGS2Fk?=
 =?utf-8?B?UnJPNWQrVEJFOU93L0g1ZkVIczl5eFA2Yi9aVzJ3REVSaVIxN1lHSVVQcVFU?=
 =?utf-8?B?Mlp2UFI4Y2lFeGM1ZHVmLzM5QzB1OG9XQzc0V1B4c1piZnQ3ZmpRUlpoMFRH?=
 =?utf-8?B?SWZqWXQwV2lMNGVTWUEvTmthUW1tcW1LdDdLcmd5cURmU3RGZEpvMnJ3VWxW?=
 =?utf-8?B?ekVucnZLakorZ09ldHVBeTc4alljM2ZFdTJNcHZ3V0ZSL1c0YmlINEFUNjZj?=
 =?utf-8?B?Y2pnb3Y2TmlQR0UxOU5hdVNXMVIxNmVQRFRXTHdodmpDMkJ4eTV6ajQ2Qm9v?=
 =?utf-8?B?TmJ3N1FrQ3hIWjlwSm53TDhlN0kydFFFblVmQjFCVTlPUG9JVEtSWTJ4aURI?=
 =?utf-8?B?OW0zK3pzdm54Umd2bmE1V0pXZzJFYjNPSTlLL3NJMzgxZmZuMkZ3VjVrQnFU?=
 =?utf-8?B?UGlBSEFNbFI4RTkzRS9NQy95T1ZvMkpWOGx0dWtqZU9TdFBsMTdFejdCaVZs?=
 =?utf-8?B?MC9ISGxSRlk2NmVzbkU4UXk4UUUzVmlQQzV0UG9SSEFpUkgwcnNTV1hMV2l4?=
 =?utf-8?B?L2c4RkpJMkp1d0FneWlrNGlOU2gyc0FHTEtYZXpURHVQWTZsS3A1cFFPa01K?=
 =?utf-8?B?dkF3ZzBoTzNoMGoyNUlzMVF5UFZncm5rcHhaTkxFTHR6bEpvVW1WN3VlYUdK?=
 =?utf-8?B?NkVSQXhZeFRic2VJWTJsNnJtY3p1NDdNNmpOQVZqWWk0UVlrdkViUlVxa0p1?=
 =?utf-8?B?ZW9DQmRWVzI2WCthNDZTQ29pbDRJVmFtQk1jUFdzbFVTVUZJYjdrN1ZySFdm?=
 =?utf-8?B?S05jZmZhOGE5am90WjFzYUc3N0xEVlVHZ0tSUXJsOVFTd2RtRXR4R3FzL1RK?=
 =?utf-8?B?VUtONEFXSlBOSWp6N3c5amRLcVk1MTQzMnh6L0czMkoyelpLQi9kVmtsMXlP?=
 =?utf-8?B?dDF2U1BjVGZqVXI0M003ZUdMd0xTbFJMc0xmOTVZaTRyMUxGc1gvZk00cldp?=
 =?utf-8?B?U0JwZTVVV0V1RDB4c2dhN3ppS20vQWlsM0FaTHBPTmxmZ2xNQ1V5RjArVG5E?=
 =?utf-8?B?bGNnZWdrd29MZHZRV0JOaTZoUVFJRHpDcURhbVlnWnN0Wi8zZEJqOW5SSm9J?=
 =?utf-8?B?bjF2UGJKRkFpTStRZUwydjBaUjd6RDJTbzJTOHVIVFVTajBjVGxYVHAvakxl?=
 =?utf-8?B?azNEVkJhUlhlSk1vUktNTVBwTVhoTHlFMWFNWXpyNjZQZW9yVENVelpYbUd6?=
 =?utf-8?B?TnBVZlFTYkhlWFlTZWVCVTFCZ3dMT2xLSCtrbDZJSzdTb1dPeGd1WWV2c0Z0?=
 =?utf-8?B?eTF2Q2RJdndRUDZabGdqSGFUT3RqaE1Md01tZmRjZUFRazlNUU8wRHVha0VT?=
 =?utf-8?B?ZDdIUTl1engrTkU0MEtQS2NIQlgwUllxZ0ptVnNpbG1ISk1GWUdObXZ3aUM5?=
 =?utf-8?B?SHh3Zng5ZTZnMFNkU2d0N3k4UDV4RS9ESXgrREZ0K1ZmWkE2bStMNDVaOUN2?=
 =?utf-8?B?Wm0wOVhRL0FnenBnY3MrUUkrWkozSmo1Y0ZDZEVUaE9aRGsyRkgwNW82REpT?=
 =?utf-8?B?QjdwVXRCQkppUnpPNHNOejc2RXMwaStEVVBWb0EzcERQZEtydHBEWTN1cG0y?=
 =?utf-8?B?QWhydlptdG9ybURJVEprdWRCazZuNy9xYnhSUEVSU1FtMFptb1ZCV24rQ0V2?=
 =?utf-8?B?QlkzSFVuTHhJaG8zZ1QrY29rRnduSnpMdWV3ODU3TXRLYzhzNnVGeENnKzND?=
 =?utf-8?B?NkEyMEx6QWtVbC9wTVZHTmFsTjc3UWFKMVdHb3JNRHVUYjNFVisvY2loWTNT?=
 =?utf-8?Q?H8pu2MsI8l+r/?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?OWFjQTNEUWFIZEtnbitGRzkwQ05pYWkwNnJsaEtiT1RjNkN2WnMvTlhLNGlR?=
 =?utf-8?B?YXpyam9GbUlkUnJjNmZ2V21ScmVJSHJHeUI3Ni9hcXRyQkJxTS9xb1l6cUg2?=
 =?utf-8?B?WW1xUUh0UFdkaVpoU0k4RGZBWkh3SnNNUzFuV2dpVUZDNWQzNUF6RVdTOEVW?=
 =?utf-8?B?WllrRWxFQVNrMnVHU1Q5TVMwc05MRTJ4VWRqT2VJcnVzdUE5QUpUcENIai81?=
 =?utf-8?B?bmhjdldia0ZzSU9oRWM1dFV3SGpvNGR3WkFxNXZIQkFESndVNUtCUzZoMXZE?=
 =?utf-8?B?REVTaEsvc2RZYy9uK3ErV1E4NHJPZ3p2Ui9ZNmhPN2RkY0UrQVUvT3VybEFP?=
 =?utf-8?B?dEdSenczRkZIa0wzQ0NMYmhpOG1uVkNxbFVWd2R4TXZiam1SREhxVm9jQzFi?=
 =?utf-8?B?RWd6Z3htU0RmcXpBZXZYNmdLN1YySE9kVlNqRzUzK2hsaFFib0dsZmFDNzgz?=
 =?utf-8?B?SmdBU0F0MWQxdDE3aituSldmUEwvL2dXd0lLdnBRU093MU5KS3dxRVM1YVI5?=
 =?utf-8?B?YnhWeEY1MXVHdXZHeCszSnlBbnZkOGYrcDZoZXVHRVEzdW13TnkwRTBrM3d3?=
 =?utf-8?B?d3poL2cvY2ZRQXFUTXJQUEFQdmNnV1dXTThSWEM0SlNwS3RqODIvUWx1RVo4?=
 =?utf-8?B?eDhVS2pZRmtzeC9FRVRiRENCNWJxdlNRRnh5OC9tYlpSSm54bUQ2Mkt6Vk1P?=
 =?utf-8?B?NkdxL05zQnpodENZcGwvZ3dzRWZ4Vk1ENWIrV0FldHRNVks4SGNEUTVTVHB1?=
 =?utf-8?B?TTlYT0ZmbnJhODRPcXVZWThyUkV5RU9Ta05Cc0FGWmlNZmxZNWpDOWZHMVR4?=
 =?utf-8?B?NjVpWGpFdTRDRzk0VXpXeTN3dUpGS3JUdG1zdE1tRnBDNE8raE9WK1Vhemli?=
 =?utf-8?B?ZHRoc2dFR2haNWlwRUdHVlUvMStXY2JCRFY4MkpUWmUxSDBENXhwd3FjNU5F?=
 =?utf-8?B?aVFQS29jdWdHUWxtaks2alFzNTFRdFEzVGlEVm44b1dxZm9TNmpyaDdKeVpN?=
 =?utf-8?B?dEgvQ2JyM1o1elBXWDZqU3FNU2w4bHZHWjlQbS9iZysxTjVWU01veXVHeDRs?=
 =?utf-8?B?d2xMQ0Npd0hOVkJEVlcwRHpGSzFZZUNPUEFkVzRrbUtwdVdWNllDTk5wTisx?=
 =?utf-8?B?ODJiTWdEWmVMM0YreHBzTFpRR2ZHRW1UaVNENGdrUXdqMU1LTzd1UUJ0RFJV?=
 =?utf-8?B?aTJaZnI4ZGFlVkRhMjBzVi9uMGkvS09FS0pUMUVBbnVzNFBtdk9KbVJ6NS8z?=
 =?utf-8?B?R0l4VWxZUWFad3I1VlNDSlorUmRkZkFBQW55cktlMlRJWTliY1VjSlU5WTRL?=
 =?utf-8?B?YlBDa01tUjU1L1RqaDQrUFZLbEtaUVlkcGdkWkpXUTdWb0NsUlByd2FiQlJi?=
 =?utf-8?B?dURvNmJSZXJiRVE2QkRRaHZKWi8zTDdidVdDa2NMNnhkS3U2UW5IV29uck9N?=
 =?utf-8?B?ZHlxZ2pzRWhEdUdjcnpjbWxxSmplb1M2RlFIdFlUTHZVZDdRbzFzb2sydGl5?=
 =?utf-8?B?MDZjUS9xZEtZMENBR1V3UVFUTUFRMmovTkYzMFYvNjVBUGxYME9aZS9ySkRx?=
 =?utf-8?B?OTZsM3hTS0hiVmtUUzNDc1AxcUUyYWZNYU5nM2dVTEZDcGZSV0ZTUXlsbTNt?=
 =?utf-8?B?YVZVaTFaSy9weG9hWW5TRU1HcWJmamhCRlk5eW5lTWtEZE42amFZZmpBNzYw?=
 =?utf-8?B?N3JTSG01a1FYc0dSbk85ZDFkQjAwNWtxQmZnN2FwREhGajliR1V2YzVOMTY5?=
 =?utf-8?B?cmx6d1hBN2JoS3FkRzM4a1FueUh6ajRucy9saEE1bTJXTldtMnlWVzYzb0lw?=
 =?utf-8?B?bzROY1NINkx1SCs1eXczVUdTWHF3S0VQTFMwZ1N6Y2Z4MGpxdTU5ekdsek5T?=
 =?utf-8?B?THZlZmdCRkhqNkdtTFhCTGdJQXBBQWhWSS9sYnhwNXJVeXZuQStTQ0NnN3Jl?=
 =?utf-8?B?bVMyOFdmTDFqZmpsSXBTNU9aZTQ1YVJrU1NQYldTc1pvdHE1NVpMTndrQ0Jw?=
 =?utf-8?B?Y1pUaUI2a1Jma2tyWC9kaHhicGFTUXRhbWU5V1dVWHVZOVJYdjBWV1Btc25r?=
 =?utf-8?B?Sks2SEZuV1ZIVVBUUDZWZm9iNGlHWXNndUlxMlp4ZzdmN2lEbEhHTDZLVm01?=
 =?utf-8?B?NlZVOFVDMXJRRGNqTWxYZXlPQmlQNmpQamp5N2dPdVJLb0N1TVlvR2JoRHlV?=
 =?utf-8?B?elE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <910B639DCA13004791EC38036FD6CF37@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 23667c5c-6943-4354-e9e7-08dd52940324
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 16:23:01.7696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +bwV0ZORfhzcWkobIkUlbdg3vwK/iDgylKUQIupaEOGzWg0RS6q5EdkbNnpiufoiDxqVh5AmE32OygxXm64jRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7697
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Feb 2025 16:23:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17278

T24gRnJpLCAyMDI1LTAyLTIxIGF0IDExOjUyICswMTAwLCBRdWVudGluIFNjaHVseiB3cm90ZToN
Cj4gSGkgU3RlZmFuLA0KPiANCj4gUGxlYXNlIENjIHRoZSBkb2NzIG1haWxpbmcgbGlzdCBhcyB3
ZWxsDQo+IA0KPiArQ2MgZG9jcw0KVGhhbmtzLiBJJ2xsIHNlbmQgdXBkYXRlZCBkb2NzIGluIHY0
IHBhdGNoIHNlcmllcy4NCj4gDQo+IE9uIDIvMjAvMjUgNjoyNyBQTSwgS29jaCwgU3RlZmFuIHZp
YSBsaXN0cy5vcGVuZW1iZWRkZWQub3JnIHdyb3RlOg0KPiA+IFNpZ25lZC1vZmYtYnk6IFN0ZWZh
biBLb2NoIDxzdGVmYW4ta29jaEBzaWVtZW5zLmNvbT4NCj4gPiAtLS0NCj4gPiDCoCAuLi4vYml0
YmFrZS11c2VyLW1hbnVhbC1yZWYtdmFyaWFibGVzLnJzdMKgwqDCoMKgwqDCoMKgIHwgMTYNCj4g
PiArKysrKysrKysrKy0tLS0tDQo+ID4gwqAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMo
KyksIDUgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RvYy9iaXRiYWtlLXVz
ZXItbWFudWFsL2JpdGJha2UtdXNlci1tYW51YWwtcmVmLQ0KPiA+IHZhcmlhYmxlcy5yc3QgYi9k
b2MvYml0YmFrZS11c2VyLW1hbnVhbC9iaXRiYWtlLXVzZXItbWFudWFsLXJlZi0NCj4gPiB2YXJp
YWJsZXMucnN0DQo+ID4gaW5kZXggYWQyMTliNTMxLi5mNzgxYzAwNGUgMTAwNjQ0DQo+ID4gLS0t
IGEvZG9jL2JpdGJha2UtdXNlci1tYW51YWwvYml0YmFrZS11c2VyLW1hbnVhbC1yZWYtdmFyaWFi
bGVzLnJzdA0KPiA+ICsrKyBiL2RvYy9iaXRiYWtlLXVzZXItbWFudWFsL2JpdGJha2UtdXNlci1t
YW51YWwtcmVmLXZhcmlhYmxlcy5yc3QNCj4gPiBAQCAtMzE1LDExICszMTUsMTcgQEAgb3ZlcnZp
ZXcgb2YgdGhlaXIgZnVuY3Rpb24gYW5kIGNvbnRlbnRzLg0KPiA+IMKgwqDCoMKgwqDCoMKgIG1p
cnJvciB0YXJiYWxsLiBJZiB0aGUgc2hhbGxvdyBtaXJyb3IgdGFyYmFsbCBjYW5ub3QgYmUNCj4g
PiBmZXRjaGVkLCBpdCB3aWxsDQo+ID4gwqDCoMKgwqDCoMKgwqAgdHJ5IHRvIGZldGNoIHRoZSBm
dWxsIG1pcnJvciB0YXJiYWxsIGFuZCB1c2UgdGhhdC4NCj4gPiDCoCANCj4gPiAtwqDCoMKgwqDC
oCBXaGVuIGEgbWlycm9yIHRhcmJhbGwgaXMgbm90IGF2YWlsYWJsZSwgYSBmdWxsIGdpdCBjbG9u
ZQ0KPiA+IHdpbGwgYmUgcGVyZm9ybWVkDQo+ID4gLcKgwqDCoMKgwqAgcmVnYXJkbGVzcyBvZiB3
aGV0aGVyIHRoaXMgdmFyaWFibGUgaXMgc2V0IG9yIG5vdC4gU3VwcG9ydA0KPiA+IGZvciBzaGFs
bG93DQo+ID4gLcKgwqDCoMKgwqAgY2xvbmVzIGlzIG5vdCBjdXJyZW50bHkgaW1wbGVtZW50ZWQg
YXMgZ2l0IGRvZXMgbm90IGRpcmVjdGx5DQo+ID4gc3VwcG9ydA0KPiA+IC3CoMKgwqDCoMKgIHNo
YWxsb3cgY2xvbmluZyBhIHBhcnRpY3VsYXIgZ2l0IGNvbW1pdCBoYXNoIChpdCBvbmx5DQo+ID4g
c3VwcG9ydHMgY2xvbmluZw0KPiA+IC3CoMKgwqDCoMKgIGZyb20gYSB0YWcgb3IgYnJhbmNoIHJl
ZmVyZW5jZSkuDQo+ID4gK8KgwqDCoMKgwqAgVGhpcyBzZXR0aW5nIGNhdXNlcyBhbiBpbml0aWFs
IHNoYWxsb3cgY2xvbmUgaW5zdGVhZCBvZiBhbg0KPiA+IGluaXRpYWwgZnVsbCBiYXJlIGNsb25l
Lg0KPiA+ICvCoMKgwqDCoMKgIFRoZSBhbW91bnQgb2YgZGF0YSB0cmFuc2ZlcnJlZCBkdXJpbmcg
dGhlIGluaXRpYWwgY2xvbmUgd2lsbA0KPiA+IGJlIHNpZ25pZmljYW50bHkgcmVkdWNlZC4NCj4g
PiArDQo+ID4gK8KgwqDCoMKgwqAgRm9yIHVwZGF0ZXMsIHdoZW4ga2VlcGluZyB0aGUgY2FjaGUg
d2l0aGluIHRoZSBkb3dubG9hZA0KPiA+IGRpcmVjdG9yeSwNCj4gDQo+IEkgZ3Vlc3MgYnkgInVw
ZGF0ZXMiIHlvdSBtZWFuIHBvaW50aW5nIHRvIGEgZGlmZmVyZW50IGNvbW1pdCBoYXNoIHRvIA0K
PiBmZXRjaCBmcm9tIHRoZSByZW1vdGU/DQpFdmVyeSB0aW1lIHdoZW4gdGhlIFNSQ1JFViBjaGFu
Z2VzDQo+IA0KPiBJcyB0aGVyZSBhIHBvc3NpYmxlIHNldHVwIHdoZXJlIHRoZSBjYWNoZSBpcyBu
b3Qgd2l0aGluIHRoZSBkb3dubG9hZCANCj4gZGlyZWN0b3J5PyBOb3Qgc3VyZSB0byB1bmRlcnN0
YW5kIHRoZSBpbXBsaWNhdGlvbnMgaGVyZT8NClJlZ2FyZGxlc3Mgb2YgY2xlYW5pbmcgdGhlIGNh
Y2hlIHRoZSBlZmZlY3QgaXMgdGhlIHNhbWUuDQpXaGVuIG5vdCB1c2luZyBzaGFsbG93IGFuZCBo
YXZlIGEgY2FjaGUsIHRoZSBkZWx0YSBkb3dubG9hZHMgZm9yIFNSQ1JFVg0KY2hhbmdlIGFyZSBz
bWFsbGVyLg0KPiANCj4gQ2hlZXJzLA0KPiBRdWVudGluDQoNCi0tIA0KU3RlZmFuIEtvY2gNClNp
ZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K

