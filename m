Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCD6CCF9F8
	for <webhook@archiver.kernel.org>; Fri,  7 Nov 2025 14:36:21 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.7])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12944.1762526175065838867
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Nov 2025 06:36:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=oHvQg8GS;
 spf=pass (domain: axis.com, ip: 52.101.70.7, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5roKypIWL/rAKxj5BKDuHRMRW95vw8Cscj0h/i9x7gu920AY3qPsS01v/DYDNyXDR2FdQNbIXOjmJ+7Sn2sbxCHQKk9dDU2i+AfRE+ac5LjAYFNyrW5BLr4r3p/qpuhqUG1UGTxKI3Cv4LRWBdgQ+AEe+L4gz/fboUNVsAwgAN3aQGpdUBUtWGmQDtdZpyECXxt6j7/bVPAr3TeM7nY5lbrS4I3ewErtvuvqg9Z9bJboGWXZuZMR3k124Z+c68ZcFyLegdD/YDFuRAF9ToPcmZXV/RUp/STKjOwmPusyu7qW0CM+Wzoi5qgLCdTM+VBBZWN2165HcJyxhLD8cyDXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGdYNsrm7IRk5FgYlwoFMqk7eMLN2pzBZrGfZsXjeAo=;
 b=x9+T7xZDR7mCJ4X1C6By6VnipXER4AALXWTC7gfF8TrQNWd84Gk+Six0WbkE9qZEGpd0d3qtQsFVcezElCI0eeKanBjUeHMX5ocX8ZEyAzGZP69IgN+8WmvOPRhtHGduhAZ9ABcLX2dlrd5qA9+XWG19o1cVQgTbPHDyrLFNDvpz1xPwwEATl5xy6EFP018cbnYn14ydj+hEAUbMdA0+m5nK8OwIy0ozJ6ICGlc1QIhCf4Y5X9/A79zt5OwS886ceHip2X7J0zhGNQcioGvZJwdXV43IpZG3EbLOEHcHRt4E8uiCtfaArnNSsdjdcIRM7B+aPT/koATXwGixVmxOSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGdYNsrm7IRk5FgYlwoFMqk7eMLN2pzBZrGfZsXjeAo=;
 b=oHvQg8GSQBaMjZoEkwHZldH7BbkqfrQ37OVdskmFq8XcSm4vlnTvDlQRivIjnMJRN0QzEnDXvM7f994t/mP8vpP5hVYUeTNLGDL/2/rB3jN7062WcyktC9elh7IT/8oqmPopMYGoxcmAd73SXKdMIhfIuwTP4CaL0nq5xvzzFug=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by AS8PR02MB6885.eurprd02.prod.outlook.com (2603:10a6:20b:250::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 14:36:11 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9%7]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 14:36:11 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"alex.kanavin@gmail.com" <alex.kanavin@gmail.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: Alexander Kanavin <alex@linutronix.de>
Subject: RE: [bitbake-devel] [PATCH 2/2] bitbake-setup: unpack sources (e.g.
 layers and bitbake) into 'sources' rather than 'layers'
Thread-Topic: [bitbake-devel] [PATCH 2/2] bitbake-setup: unpack sources (e.g.
 layers and bitbake) into 'sources' rather than 'layers'
Thread-Index: AQHcT7yjDDWPxs4HsUiJLUVfqKaf1bTm+AuAgAAM7VCAABNEAIAAJ11g
Date: Fri, 7 Nov 2025 14:36:11 +0000
Message-ID: 
 <DB5PR02MB1021378D8FFB243D45302CF4FEFC3A@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20251107080026.2599821-1-alex.kanavin@gmail.com>
		 <20251107080026.2599821-2-alex.kanavin@gmail.com>
	 <13179deb9c814179d00e7bcd125c3999399c5819.camel@linuxfoundation.org>
	 <DB5PR02MB1021360A5C5B050606199CD02EFC3A@DB5PR02MB10213.eurprd02.prod.outlook.com>
 <e12005baac32b9cc5ca13b79a66b54584060bb84.camel@linuxfoundation.org>
In-Reply-To: 
 <e12005baac32b9cc5ca13b79a66b54584060bb84.camel@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|AS8PR02MB6885:EE_
x-ms-office365-filtering-correlation-id: 557280be-b018-45a8-1c35-08de1e0aff0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?WldJMzNrcFFoQ0loNEJUQytRVWJiYUJkQ1FPYU5DamIrQkc5TXYxTGZmVHk3?=
 =?utf-8?B?T3VsTzgxMkNuZjVsdm1XVlNWVXVabzVPdGY0L1ZCRVVTTUJCZGQvVTJBMEg5?=
 =?utf-8?B?NlJZVytZUHpDQzBqd25uQVU3Q1VKWWljRDEyenRlb1k0Wk91dURoNVJYMzBQ?=
 =?utf-8?B?amFkN2pzdTlpMnZqVDhMemMvQlNDNXEwZHN6OEJnTnRiVzc1UG1rdHZlUHF6?=
 =?utf-8?B?QXR0MlNNNUp5ZXVQa2puZ0FNeTMxR2RNbVVPb2t1ODZrYVFxK21pY2cvelJG?=
 =?utf-8?B?U2dvbHEyRy9zTGJRa3RzVjVnWk5heGtraXZoMnUwejBLdEFnVzhJQzBZbHFB?=
 =?utf-8?B?MzFvTC9vZk1aS2ptUFo5aTB4VFFGTFhqMkprd05hRDlFam5WUTVOemN2Wm1w?=
 =?utf-8?B?VGgyQjJZVlNNeWpRaEo0bjRhbWhMYWFCT0RXVlRreUt3S0prYUY4WW94Y1NJ?=
 =?utf-8?B?NzdaaWxIOEsxUStoU0hNQStpdW1TN2JsQU14NWRpMGVzQzI1YTIva0hxaFNo?=
 =?utf-8?B?dzFuRGVSWDlBdzhrdXRGOGtjTDZWVHF4dmpORTVVR3U1aE8xUE5kR2REZ1F2?=
 =?utf-8?B?V0ZJM1lzdlB3d0dFV05JOFhPclY3ai9lTXl4TUNUVTBzSWZrUFFLRWZOWXRM?=
 =?utf-8?B?Q2c0MVBydXcyc1hWUzNqakhVV0p6S1RvN1YwMVpHVWwwUmIxNWJEb1owQXRX?=
 =?utf-8?B?UXJZY1F5OVhVaXN3Rkl5MFliemNDZlRhUFJmOStQaUM5OEU1UlAxeUdVcEFE?=
 =?utf-8?B?ZGo2TjlxWlI2ZGIwUUE3L2hHelg2akxTUzRNMmViL2xxOUwybEVXNHovbEI5?=
 =?utf-8?B?dU9IUXJLalVGY0dOSGZ0R1hCM1pjTHpiWmxkTDVrRnRRRldYV2duVmZWV0Nt?=
 =?utf-8?B?b0l2eXhFUm5BZnFnZXVUYnhyWHErU3U5RlBkNzRQait1VTUxY3p4SXJQcmhU?=
 =?utf-8?B?VnVBUG1ZcFN2WFgybHlCMDBzWU02OW5CMG5UalFFc25PWkhtWDFRUVFDNC9Y?=
 =?utf-8?B?dUFJdklTcmlvZGUzMUF6MjE5dEUwS1E3YVNQVytVNFlTZkhyb0xTaERjODhE?=
 =?utf-8?B?TGk0eHZ0bXVBTWlCeGZQemc2RHptQ1ZnMEFyT3B1enBxd3RsZDJhek16NWxK?=
 =?utf-8?B?bWRDRVpaMGIwcFlwUDZ2eFNwdUZQdlFlak9qTWNOQjlEZDdzMGNkbmZTQnV0?=
 =?utf-8?B?akJVQjVLdVI2bG5NcmdkYm5WNkhmRklUUnZBU3ArVE1GWldZVnpjV3YreFlT?=
 =?utf-8?B?SnNRa2EyRVFyVW45bDBVRDB6c1FyUGNXSE5ETWY2czJaRnk1OVovb3hCWTl5?=
 =?utf-8?B?K3V6a3FLR2ZMWkRFeEJURjdOam81b3hjUGw5cTJhNDh1ejBaYXpvcUNpSVBQ?=
 =?utf-8?B?VGFMbzlvcnJHZ1NwbGk1Q3ZRZWx0SFFwell4TS9pWWE0SzV4Qnd3emFiclJm?=
 =?utf-8?B?MzNuMlA0MDE2MmYxTjZGa2oycXZSeElWYW1lMkxtU3ZpRXgvSGgwY1N4N240?=
 =?utf-8?B?UndTZklydVV6WU1pMUZ5K2dycXJ4cmtqQnNYNDd3eC9oSmVNTDJJaG9MZXdh?=
 =?utf-8?B?bWhkcU9YQmRpa3k4ZEU4MTA2djNhc05CYzNBOFZUQXhJMjQvS0RibW90R3U5?=
 =?utf-8?B?RU9scjdxY2d2eWRjYnN6RUtzU3NoNHhiQU5hK2tTb0V5MVVCYVRuZXhXTWc5?=
 =?utf-8?B?L1h2ZjlDQ25JVU83RnVqMkxKdFdSdEt5SThLdU9QWElSOCttMnRwOXY3QXJE?=
 =?utf-8?B?RFdkTFRPYTJ4ZFExMWlSWHdNdkRNN21kcVhQKzAyZmtDVlk1WlhzZEp2M3E2?=
 =?utf-8?B?Q08vV0FrUVg3MXJzNDN5VU8rZkdDQ1hSVndBS1kycmgwV0k4TmozWEp0NlMx?=
 =?utf-8?B?TnBCWmYzLy9xdE8yODAyS3BCeVFnV29DZUZYc1lNdklOZStuNDNXN0dRTmNE?=
 =?utf-8?B?SDg5RzczM2NaMVVTTWNhQjFSWGJQM2ZCa2pQSDBKdnRpZ1NJWkZqMERSYUlp?=
 =?utf-8?B?R29ydHlrRlVzSFArbVhnRW4wRUsyVzFPNFZ2NjREUTVwR2lqTGZVU3lkMTdI?=
 =?utf-8?Q?gZbYt3?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NDNIemlBZVNNMjE1c0t4a0d5V2ZIZUE4ZmVWYVZ2V1JpQmQyQ1hwVVFmMnVX?=
 =?utf-8?B?ZTI4bWttQ3UySXRLUWNWNXVWbnlZVU5Jdk0yK0dza09MQ05oZk1wVDVNTzI5?=
 =?utf-8?B?RnMxWk9QUlBDbnZ2RG16QWwvN0JwVWRCdDdmbmxDNkZ3S0xPWlFMTldHd2xr?=
 =?utf-8?B?RXN0TkNPZTQ1VVVUL1pWYk5TZTNabGlEVHhvUExPcFFLVnJJMXR6STRWaVRk?=
 =?utf-8?B?WlZBbWg2cDhyN1ZVTWhMTDFxRmFoNlpmYjVZOG5GbkJGQlV4WEpsYWF5cjY5?=
 =?utf-8?B?WmRXNmVHNXQ2bXltSDUybHlGUTF5eEpPbWhpODRQQ1JrdUNiNUFwcjFhY2JG?=
 =?utf-8?B?TFpmQ0VNUjI2VDN5MnppSWZlMWNpbXhabHBBVzlQUnV3UmZUN3JmMU1uZHVw?=
 =?utf-8?B?RWpSUjNaMUE4ZVVTV0hNVlR4ZDl0eUwxZnFEaWt5QVFVUHFxQkpCcm5yMXc2?=
 =?utf-8?B?dmpVaGloREFsNWFxMVd3cVJYQ3dkV1FXd0dMOXBDMnlxektkQlhjaUF3cjh3?=
 =?utf-8?B?WEl5c0JOL2lUc3A4WlcyTGNRVlZSdEVYbFYwbnhRQkxLcHRMNitYMkpTN1lt?=
 =?utf-8?B?cTJ0TWJmWTFmbUNlQ0xaOVBCcXgxVnJxekV5R3VIWlF1ak1zQklJQ3FmS2lB?=
 =?utf-8?B?VkxDSVR2ZjNsQUhhKzVDUmNpb0xTZEc4YWgrSm9WRXlqU1dpc2JEb0dDM0VB?=
 =?utf-8?B?MWhwNXBrRUxidmYxMjQ2K0I1VDBGRThFNU5rU1VXdFZ5eFNVV3NZdDhxbFFR?=
 =?utf-8?B?MHZUMFpEbDFReG4xVDVlb0Mza3p6MEZZSW9CcHE2U2ZTRzVRakEwcjZmWmNE?=
 =?utf-8?B?Vm1YRVEvUFVuenVBV3UrKzFqSGtqaXNOU0p6azJpL0N5UjViditqRXdlUy85?=
 =?utf-8?B?VnFQZWlpcWl4SWpHeHN2bm4raVdFRjRpSTJhWlhRb01pSHBvejM2bjhyOE9D?=
 =?utf-8?B?Uno3b2N4YXpmZnZnVXppMUZtbmtqK0tFZDJlVUlMZTVLVGJvU3JzRkZ5bSsw?=
 =?utf-8?B?VFRpV0V1T25palFHWTN2ZUFrK2JJdGZuZmFwdkp4RkhXc293eFRWbVZpN2xp?=
 =?utf-8?B?cEp3cVBrc2w0cUZTaTdlNk5sYTlRK0F4MUJDK1VrdGhJTEJsMjRldkE1T2Vy?=
 =?utf-8?B?MmkvV1J3VUJrWXlpaUFoQnI1MTJCVDl5ckJ0V3BBZU1yWEV0ZVozNkhUa0Rx?=
 =?utf-8?B?QnZFSFZtRy9oRXlacmdPYUpTeXFiejJKNE1FM2E5ckxZK0VHRVZtS1RyZGVB?=
 =?utf-8?B?R0VVK3ZpWGhhb1YrS0txam1zN0FHR1pXclV3ZVZhcGNndk42RFNrQ0tPbXAw?=
 =?utf-8?B?SUVhejBXWjMxWEgzU3ZHSnAycEY5R2NZNFhLRHdFa0dId0hWTWt2RGkrRjNt?=
 =?utf-8?B?dFRFN3hXajdjMWpibkxncU44LzZvbFk2aytDOU5MZEVJTVdWR25JTlkxZThl?=
 =?utf-8?B?TncvQ0JvUlRoMFdqWlJ3S1R1aHZ1NEd1WXZVRm1SK1ExQ1lpN0ZjMTZQc2R0?=
 =?utf-8?B?WFRlLzN0ME13WWFQendVaVNtQjdqK3ZOWThiWTlOSnZFci9pUFU1S3NpYW9W?=
 =?utf-8?B?Zk5yRjkvdjZITGUxQ3ZXRVRoRXdBencvZ09TVVhDSWNFaXprK0FVZiswTjFq?=
 =?utf-8?B?RE5CYjZPS0d2VnExU2hBcGE2Ym5HWEhXNW54andoUmhEUlpmakZXYVRGVjIx?=
 =?utf-8?B?anZ4NUw4cFpMdEtrSDN5Tk05ZTcrZGtnQkRqTVJQRkt2dTlVcnozazJVdHhs?=
 =?utf-8?B?WmZPaFp2VW5xemtUdE9HSTJkV1d3K3l2ajNSQ3FJNEZjWDQxQW4zZ29sZU0r?=
 =?utf-8?B?NkU5ZHpLaFBjNzk4SU1GWVF2Z24veEhLSTg1dWdxcXkwM2gyK0RXL2hwRmE5?=
 =?utf-8?B?SlUrYWFkWmhaN2N1SkZRQmVROU5DOVpQNzkzbURhVGoyaDlieG5lc0xKRmRl?=
 =?utf-8?B?c1I1WjZFZTM1Q1NPWmpRSHE5N0c1ZXo1ZFNiRFh6cnBCbVZOQ08zc3o1RDNl?=
 =?utf-8?B?ei8yd20zRDZXb3hpaDhZeDd4M2d4WFkzY2JRbnRHYXBpckxSWnlzOHlXUkZP?=
 =?utf-8?B?MU9nZDBhYm5qbmh5WURObENCdnVxalFzY1pHQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 557280be-b018-45a8-1c35-08de1e0aff0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2025 14:36:11.0531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XrtzYa9C80QZV2umfg25oH6fVORgYWLwPeTT3B6IrbrNKno2AUPmIvbXj1bnM/HW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB6885
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Nov 2025 14:36:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18313

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSaWNoYXJkIFB1cmRpZSA8cmlj
aGFyZC5wdXJkaWVAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gU2VudDogZGVuIDcgbm92ZW1iZXIg
MjAyNSAxMjo0NA0KPiBUbzogUGV0ZXIgS2plbGxlcnN0ZWR0IDxwZXRlci5ramVsbGVyc3RlZHRA
YXhpcy5jb20+OyBhbGV4LmthbmF2aW5AZ21haWwuY29tOyBiaXRiYWtlLWRldmVsQGxpc3RzLm9w
ZW5lbWJlZGRlZC5vcmcNCj4gQ2M6IEFsZXhhbmRlciBLYW5hdmluIDxhbGV4QGxpbnV0cm9uaXgu
ZGU+DQo+IFN1YmplY3Q6IFJlOiBbYml0YmFrZS1kZXZlbF0gW1BBVENIIDIvMl0gYml0YmFrZS1z
ZXR1cDogdW5wYWNrIHNvdXJjZXMgKGUuZy4gbGF5ZXJzIGFuZCBiaXRiYWtlKSBpbnRvICdzb3Vy
Y2VzJyByYXRoZXIgdGhhbiAnbGF5ZXJzJw0KPiANCj4gT24gRnJpLCAyMDI1LTExLTA3IGF0IDEx
OjA3ICswMDAwLCBQZXRlciBLamVsbGVyc3RlZHQgd3JvdGU6DQo+ID4gPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogYml0YmFrZS1kZXZlbEBsaXN0cy5vcGVuZW1iZWRk
ZWQub3JnwqA8Yml0YmFrZS1kZXZlbEBsaXN0cy5vcGVuZW1iZWRkZWQub3JnPiBPbiBCZWhhbGYg
T2YgUmljaGFyZCBQdXJkaWUgdmlhIGxpc3RzLm9wZW5lbWJlZGRlZC5vcmcNCj4gPiA+IFNlbnQ6
IGRlbiA3IG5vdmVtYmVyIDIwMjUgMTA6NDkNCj4gPiA+IFRvOiBhbGV4LmthbmF2aW5AZ21haWwu
Y29tOyBiaXRiYWtlLWRldmVsQGxpc3RzLm9wZW5lbWJlZGRlZC5vcmcNCj4gPiA+IENjOiBBbGV4
YW5kZXIgS2FuYXZpbiA8YWxleEBsaW51dHJvbml4LmRlPg0KPiA+ID4gU3ViamVjdDogUmU6IFti
aXRiYWtlLWRldmVsXSBbUEFUQ0ggMi8yXSBiaXRiYWtlLXNldHVwOiB1bnBhY2sgc291cmNlcyAo
ZS5nLiBsYXllcnMgYW5kIGJpdGJha2UpIGludG8gJ3NvdXJjZXMnIHJhdGhlciB0aGFuICdsYXll
cnMnDQo+ID4gPg0KPiA+ID4gT24gRnJpLCAyMDI1LTExLTA3IGF0IDA5OjAwICswMTAwLCBBbGV4
YW5kZXIgS2FuYXZpbiB2aWEgbGlzdHMub3BlbmVtYmVkZGVkLm9yZyB3cm90ZToNCj4gPiA+ID4g
RnJvbTogQWxleGFuZGVyIEthbmF2aW4gPGFsZXhAbGludXRyb25peC5kZT4NCj4gPiA+ID4NCj4g
PiA+ID4gJ2xheWVycycgaXMgbm90IGEgZ29vZCBkaXJlY3RvcnkgbmFtZSwgYXMgaXQgY29udGFp
bnMgYml0YmFrZSwgb3IgcmVwb3NpdG9yaWVzDQo+ID4gPiA+IHRoYXQgY2FuIGNvbnRhaW4gbXVs
dGlwbGUgbGF5ZXJzIG9yIG5vIGxheWVycyBhdCBhbGwgKGUuZy4geW9jdG8tZG9jcykuDQo+ID4g
PiA+DQo+ID4gPiA+IFdoaWxlIHRoZXJlJ3MgYSBjaGFuY2UsIGxldCdzIG5hbWUgaXQgcmlnaHQ6
ICdzb3VyY2VzJy4gVGhpcyBhbGlnbnMgbmljZWx5DQo+ID4gPiA+IHdpdGggYm90aCB0aGUgJ3Nv
dXJjZXMnIHByb3BlcnR5IGluIHRoZSBqc29uIGNvbmZpZ3MsIGFuZCBvZS1jb3JlJ3MgdW5wYWNr
IGRpcg0KPiA+ID4gPiB3aGljaCBhbHNvICdzb3VyY2VzJy4NCj4gPiA+DQo+ID4gPiBJJ20gYWZy
YWlkIEkgc3Ryb25nbHkgZGlzYWdyZWUgd2l0aCB0aGlzIGNoYW5nZS4gV2hpbHN0ICJsYXllcnMi
IGlzbid0DQo+ID4gPiBpZGVhbCwgdG8gbWUgInNvdXJjZXMiIGlzIHdvcnNlIHNpbmNlIGl0IGlt
cGxpZXMgc291cmNlIGNvZGUgYW5kIHRoZQ0KPiA+ID4gZ2VuZXJhbCBkb3dubG9hZHMuIEl0IGlz
IGFsbCB0b28gZWFzeSB0byB0aGluayB0aGlzIGlzIGdvaW5nIHRvIGJlIGENCj4gPiA+IGRvd25s
b2FkcyBjYWNoZSBkaXJlY3Rvcnkgb2Ygc29tZSBraW5kLCBvciB3aGVyZSBTIG1pZ2h0IGdldCB1
bnBhY2tlZCwNCj4gPiA+IGFuZCBzbyBvbi4NCj4gPiA+DQo+ID4gPiBGcm9tIHRoYXQgc3RhbmRw
b2ludCAicmVwb3NpdG9yaWVzIiB3b3VsZCBiZSBhIG1vcmUgZml0dGluZyBkZXNjcmlwdGlvbg0K
PiA+DQo+ID4gSW4gb3VyIHNldHVwLCBJIGhhdmUgY2FsbGVkIHRoZSBjb3JyZXNwb25kaW5nIGRp
cmVjdG9yeSAncmVwb3MnLg0KPiA+DQo+ID4gPiBidXQgSSB0aGluayAibGF5ZXJzIiBpcyByZWFz
b25hYmxlLg0KPiA+DQo+ID4gUGxlYXNlIGRvbid0IGNhbGwgaXQgJ2xheWVycycuDQo+IA0KPiBJ
dCBpcyBhbHJlYWR5IGNhbGxlZCBsYXllcnMgYW5kIGhhcyBiZWVuIGluIHRoZSBwYXRjaGVzIGZv
ciBtb250aHMuDQo+IA0KPiANCj4gPiAgVG8gbWUsIGEgZGlyZWN0b3J5IGNhbGxlZCAnbGF5ZXJz
JyBzaG91bGQNCj4gPiBiZSB1c2VkIGZvciBpbmRpdmlkdWFsIGxheWVycywgZS5nLiwgbWV0YSwg
bWV0YS1vZSwgbWV0YS12aXJ0dWFsaXphdGlvbiwNCj4gPiBldGMsIHdoZXJlYXMgdGhpcyBkaXJl
Y3RvcnkgY29udGFpbnMgZnVsbCByZXBvc2l0b3JpZXMsIHdoaWNoIG1heSBlYWNoIGJlDQo+ID4g
YSBzaW5nbGUgbGF5ZXIsIGEgY29sbGVjdGlvbiBvZiBsYXllcnMsIG9yIG1heSBjb250YWluIHNv
bWV0aGluZyBub3QNCj4gPiBsYXllci1yZWxhdGVkIGF0IGFsbCwgZS5nLiwgZG9jdW1lbnRhdGlv
bi4gSSBoYXZlIHNvbWUgaWRlYXMgZm9yIHRoZQ0KPiA+IGZ1dHVyZSwgYW5kIGNhbiBzZWUgYSB1
c2UgY2FzZSBmb3IgYSAnbGF5ZXJzJyBkaXJlY3RvcnksIHdoaWNoIHdvdWxkIHRoZW4NCj4gPiB0
eXBpY2FsbHkgY29udGFpbiBzeW1ib2xpYyBsaW5rcyB0byB0aGUgaW5kaXZpZHVhbCBsYXllciBk
aXJlY3Rvcmllcw0KPiA+IHNvbWV3aGVyZSB3aXRoaW4gdGhlICdyZXBvcycgZGlyZWN0b3J5Lg0K
PiANCj4gQXQgdGhpcyBwb2ludCB0aGF0IHNoaXAgaGFzIHNhaWxlZC4NCj4gDQo+ID4gPiA+IFRo
ZW4gdGhlIHNldHVwIGRpcmVjdG9yeSBjb250YWluczoNCj4gPiA+ID4NCj4gPiA+ID4gLSBidWls
ZCAoYml0YmFrZSdzIGJ1aWxkIGRpcmVjdG9yeSkNCj4gPiA+ID4gLSBjb25maWcgKGJpdGJha2Ut
c2V0dXAncyBjb25maWd1cmF0aW9uIGRhdGEgdW5kZXIgdmVyc2lvbiBjb250cm9sKQ0KPiA+ID4g
PiAtIHNvdXJjZXMgKGV2ZXJ5dGhpbmcgdGhhdCB3YXMgZmV0Y2hlZCBhbmQgdW5wYWNrZWQpDQo+
ID4gPg0KPiA+ID4gc28gdGhlIGxpbnV4IGtlcm5lbD8NCj4gPiA+DQo+ID4gPiBJIHNheSB0aGF0
IHRvbmd1ZSBpbiBjaGVlayBidXQgaXQgaWxsdXN0cmF0ZXMgbXkgcG9pbnQsIG5ldyB1c2VycyB3
aWxsDQo+ID4gPiBub3QgdW5kZXJzdGFuZCB0aGF0Lg0KPiA+DQo+ID4gQW5kIEkgdGhpbmsgdGhl
eSB3aWxsIGV2ZW4gbGVzcyB1bmRlcnN0YW5kIHdoeSBhIGRpcmVjdG9yeSBjYWxsZWQgJ2xheWVy
cycNCj4gPiBjb250YWlucyBiaXRiYWtlIGFuZCB0aGUgZG9jdW1lbnRhdGlvbi4gSSBiZWxpZXZl
ICdyZXBvcycgKG9yIHRoZSBsb25nZXINCj4gPiAncmVwb3NpdG9yaWVzJykgd291bGQgYmUgdGhl
IGJlc3Qgb3B0aW9uLg0KPiANCj4gSSBkaXNhZ3JlZSwgcXVpdGUgc3Ryb25nbHkgYW5kIEkgZG9u
J3QgcmVhbGx5IHdhbnQgdG8gb3BlbiB0aGlzIGZvcg0KPiBkaXNjdXNzaW9uLiBUaGF0IHNob3Vs
ZCBoYXZlIGhhcHBlbmVkIG1vbnRocyBhZ28uDQo+IA0KPiBDaGVlcnMsDQo+IA0KPiBSaWNoYXJk
DQoNClRiaCwgSSB3YXMgbm90IHN1cnByaXNlZCBieSB5b3VyIHJlc3BvbnNlLiBNeSByZXBseSB3
YXMgcHJpbWFyaWx5IGluIA0KdGhlIGNvbnRleHQgb2YgX2lmXyB3ZSB3ZXJlIGdvaW5nIHRvIHJl
bmFtZSB0aGUgJ2xheWVycycgZGlyZWN0b3J5IG5vdywgDQphcyBzdWdnZXN0ZWQgYnkgQWxleCwg
dGhlbiBJIHdvdWxkIG11Y2ggcmF0aGVyIHNlZSBpdCBuYW1lZCAncmVwb3MnIChvciANCidyZXBv
c2l0b3JpZXMnKSB0aGFuICdzb3VyY2VzJy4NCg0KVGhhdCBzYWlkLCB1bmxlc3MgSSBhbSBtaXN0
YWtlbiwgdGhlICdsYXllcnMnIGRpcmVjdG9yeSBpcyBub3QgcGFydCANCm9mIGFueSBBUEkuIEl0
IGlzIGNyZWF0ZWQgYW5kIG1haW50YWluZWQgYnkgYml0YmFrZS1zZXR1cCwgYW5kIGlmIGl0IA0K
aXMgcmVuYW1lZCwgdGhlbiB0aGF0IHNob3VsZCBvbmx5IGFmZmVjdCBiaXRiYWtlLXNldHVwLiBJ
dCBpcyBub3QgDQpyZWFsbHkgYW55IGRpZmZlcmVudCB0aGFuIHJlbmFtaW5nIHNvdXJjZXMtdW5w
YWNrIHRvIHNvdXJjZXMuIE9rLCANCnRoYXQgbWF5IGJlIGEgc2xpZ2h0IGV4YWdnZXJhdGlvbiBh
cyBpdCBpcyBtb3JlIHZpc2libGUgdG8gdGhlIHVzZXIsIA0KYnV0IGF0IGxlYXN0IEkgZG9uJ3Qg
dGhpbmsgdGhlIGN1cnJlbnQgbmFtZSBpcyBzb21ldGhpbmcgdGhhdCBzaG91bGQgDQpiZSBzZWVu
IGFzIHNldCBpbiBzdG9uZS4NCg0KQW5kIHdoaWxlIHlvdXIgYXJlIHF1aXRlIHJpZ2h0IHRoYXQg
aXQgd291bGQgaGF2ZSBiZWVuIGJldHRlciBpZiB0aGlzIA0KZGlzY3Vzc2lvbiBoYWQgaGFwcGVu
ZWQgbW9udGhzIGFnbywgdGhlcmUgaXMgc3RpbGwgcm9vbSBmb3IgaW1wcm92aW5nIA0KdGhpbmdz
LCBhZnRlciB0aGUgV2hpbmxhdHRlciByZWxlYXNlLg0KDQovL1BldGVyDQoNCg==

