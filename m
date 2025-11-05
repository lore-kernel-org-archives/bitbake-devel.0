Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8714BCCF9F8
	for <webhook@archiver.kernel.org>; Wed,  5 Nov 2025 10:27:25 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.1])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6320.1762338437989434017
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Nov 2025 02:27:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=qPiGGTh2;
 spf=pass (domain: axis.com, ip: 40.107.162.1, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yHYtfRjouQSjkQpaUFI3Gc1ePgsOeoMLA3mu0aNnfCZKPSUtMHnZdOC9qWcdRdQsLxNNJ+ucSRcvVhjs8X5MMaQSDszgfgtqCbz0TVnyur+aDNpt/IgFiNuvY8aEfZJsuVqmmPRkgWfnlc8IJcnxlJA87dlzhz7EvyblzhP/35eHGdDSFDTZOcxs1dhQzFoGYuyxOADpbGeZjUjlUdIL6POxK6lfkE+pLMhTcQY8B+9hvCrIsyWsICM+EM83SJGxOqM2h/1JFCzKPD2z6om3fA0NIRMvZhxYZb89tLktoZgFgboAZu7LZED66Ngqzdwv/zb5h9r5/ivI+i/MEtAmOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WcHVyt7aI+OOD6ruCvlepPHmWzHPuUKOCx/KpwHZug=;
 b=UUxGtJNcfeIWLodJd9hDT/jDjU7Ixv61wMxKjCUKl85ETFf6AVd06U3DE3lldkTSrFNJy4GVRv6DWQ68v8dUnRJCSGBr1Uevoz70XBAWAS4fiOE1qL/JSBLuK+m9McRbO91kXTMQzBSXDbdAXOM0wwg02hblh8P970GoxpQjD10vPwkIpiIWnO6OUkKIPkT4KJoOx2PSphr6Pr2kPg5Y0uzRsERJhcyn6lmAw2VKFA195gia+9mlonaasiQ8lO8AE5p2AC6h2yqD2RmmQj/A8OPpwEz1pFiAzz050dy04twSNx8W8qG/iL/EPMuCF9pibBUMUe4pocgxbINJ7OF/Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WcHVyt7aI+OOD6ruCvlepPHmWzHPuUKOCx/KpwHZug=;
 b=qPiGGTh28z95ILEUVs8HAWJA/Q+az1NpCimgEdd8Lz52Po0bgTu19mgRKXocxrXgHt7xbdKVZHt6oYcLMctWtcU/xmIYPuKL8UnESGZh40Viztqk9vf86KxRiUAk2qkp3NiYQJNIJE8EbqRnMB32s/aj1Z8Lum2Rke6Tvr8o8kA=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by DU0PR02MB8189.eurprd02.prod.outlook.com (2603:10a6:10:311::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Wed, 5 Nov
 2025 10:27:14 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9%7]) with mapi id 15.20.9298.007; Wed, 5 Nov 2025
 10:27:14 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "zboszor@gmail.com" <zboszor@gmail.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH] knotty: Cast two variables to int in
 integer expressions
Thread-Topic: [bitbake-devel] [PATCH] knotty: Cast two variables to int in
 integer expressions
Thread-Index: AQHcTiPMC1ev6Bt+vUuLKcVbS7XrA7Tj3R8w
Date: Wed, 5 Nov 2025 10:27:14 +0000
Message-ID: 
 <DB5PR02MB1021323DCBF5650EA0A733B53EFC5A@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20251105071405.636900-1-zboszor@gmail.com>
In-Reply-To: <20251105071405.636900-1-zboszor@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|DU0PR02MB8189:EE_
x-ms-office365-filtering-correlation-id: a722a6ba-8b6f-45d9-12cc-08de1c55e32c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?QmJsemFqcVcyWnhWSCs2NnMwNjBlR2tEZldsbFlKRVpaTHBpcmtMemxiYWdi?=
 =?utf-8?B?NkY0UUJveFRPb0U4elVOSU0vMk9CVjk1NnhCMytnNTV2eVludkl2YkF2V2lT?=
 =?utf-8?B?eHFQQktueXBYZ1o5TERQdnhvcEFEUUJOc3FjcEg0TVd0ZXp2MUgvTVg5ckta?=
 =?utf-8?B?Ynl0ckkzRkg3MnBzWkt5TkVwbDlwVFFmdUNqb3pWVUxMekFPQmJjZm5zNjRO?=
 =?utf-8?B?eHFkckVwN1hPN1BYNDdwTitUNElhcmttVVJzMU9ZcFV6US92YjdTZ1N2Y2hN?=
 =?utf-8?B?c2k2L0ZMK05ReEVxNHJPV3BKU2RsM29YUWdDUjQ0eXB2TEkrdVFBc2E3dlBK?=
 =?utf-8?B?b0FSRWlSS2tLYVFHVWdVOTZVbGwrd25PSTJuOFZsUVg3Y0JSWXlPQUFCNnJO?=
 =?utf-8?B?a2JYUFJhT2RRTkFWTGpWaEVmT2dLWjdaSzNDa2RGK2VNOFBpcmYrVm5CWnRo?=
 =?utf-8?B?UmlwMitIN09CbWJYMGpXRXF1dFUrZENTcmh1dFFEeGtsTmhucUlSd1BOK0Vr?=
 =?utf-8?B?MkJqZzUrZ0hqMnV3RHRYeUVRRkdodjlQalQ3WWlDdHl0QXN1b25iM09pUlpC?=
 =?utf-8?B?NldPN1FzYUxYSjNBK213TkFYWlRQMm5PV3lYTnZRUkNkY2dwcCtYRHRsbndX?=
 =?utf-8?B?RndhM3JUMC9DNnVVSmlvSkhkeGNtY2RUamlOZEtySnowOVdBQ2VpcHNoOEJM?=
 =?utf-8?B?ZzQzVDN0ZnZUNEhKcm8yVXoxK3VBR05jOFFKYmJZcG1rY0toYTNlaVRaVmpu?=
 =?utf-8?B?MTRQSmYwVTJaN09BT3BUam1wQ1MrUUZqR2xjWTVvR2IvRjVkR1hZdkRYVUhJ?=
 =?utf-8?B?NlJUc3cxYlRMbWl5MlRUTXQwOVdOTWVVTnR0Tmh0ZEFrbG1HQ1ozdDcyeFdB?=
 =?utf-8?B?NENGemtFT0s1RVpCVG01QlFpZFY4SHdwOTZIRHlDaU9ITFdFV1llMjdwb3NO?=
 =?utf-8?B?WU1KQ1hzSUpDRlZqTElSckVXc1JJTGYwMXJCVVpCRVZxQklaSEx5bFRjVlhJ?=
 =?utf-8?B?VXptV0NLTWNrWDdmK1AwQmpkZWFCZ3RoMTg0c0ZQbFZOQ0h6Rms2QitYS0VG?=
 =?utf-8?B?RnRCK2pVSG9uOXVlU3lqdUk5Zk1OcTR4bERPMGFHNGZwQ2Fob2NIaktYZHRo?=
 =?utf-8?B?T3hKZ3dlVmhhNkl3UlJpR3kzSHpNZmwzSGxCRFNqUDRjN0poeVFRU2tYTm5Z?=
 =?utf-8?B?Q1NWQWtFbWlzbU1sMzZuVnluV2tMbnZaWFJUUHRkd1VWVkJ4c09BR05SQ2Fw?=
 =?utf-8?B?TG9IcFRXRVJKYkVxbXVpK3pzZGc5eE5ab25qMTBMMzNnQ3lNVDBleUVKdlJ1?=
 =?utf-8?B?dklONkRrcGNpbGlpOGZCaVFkYk0rdzM1U3Foa09GeVpoUUtmWFp3TXhpZnFp?=
 =?utf-8?B?NkQvMGMyb3pBOHdaTkJLR0kzaER3amhmcHNKUmIvOGxqQThCUUdNRW5PVXAv?=
 =?utf-8?B?SE9SYmVwbWkzUHh4Nm9mRkdaL2hWcnJBOGg2TDFkZGJ3MVVxcDVhbG1tTlFW?=
 =?utf-8?B?RzNTZE8vdHg1SG5GOGkxbGt0cndYUExDMk1SODRPVWpwMmRxdnozb0NzcS9h?=
 =?utf-8?B?QXN0ZkxLUjArbVk2RHZRQzdWb0U3UEw1ejNjYVFDR3ZLcVJaRUFEbzFFVjZo?=
 =?utf-8?B?NG9PODQ2dStRcmt2bjN1bEhyT1Qwd0UyWE9VTUxWMU5welhTdXlhZXYraVo1?=
 =?utf-8?B?T1FaWGJ5KzNsTmZsNHZRUVIrMjNHNUxwZk94L0pNQW02a0Y0cFBCQjVkOXJI?=
 =?utf-8?B?TTFxK3IyRzE4dXdOWkRxcEVzUG5NRlYzOGNUV0Y5SndLRFFxODV5YkFpNlNz?=
 =?utf-8?B?eVFiNjlxYmxxUE5xN3hqZ2JwYm1iVElNNHBpYnlmSUpxcXE2a0ttMVFNRkpO?=
 =?utf-8?B?Q0c5bVRyUE5DaEtBcHBoam5TcGxDdVRySjlsVlBjb1lyUXdHcWZkdkhiZDNx?=
 =?utf-8?B?NFd4YWhjM3pTcDhVaDEycGh0SHpBTUovcnB1c1VMeWZTMzRNU3RybGQ3QVZJ?=
 =?utf-8?B?ZTU4OTFRTEZEMnU3eHBRakp6NFBQMXg1dlB4MU1zRkhtQi9teW1SU0lUbkFm?=
 =?utf-8?Q?aOnFbw?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?QlFaQmFBRlA3NGRrZlh3TGJXUWJhN2RadGNUNnBUdVpjMzJGR0F5SjBybmR6?=
 =?utf-8?B?YnBKSHlHbi9hOHFPdC9zSGhOSXdQNmN6SnluRlZwcUU1VWRDbnVQQXdjWm02?=
 =?utf-8?B?UEJNZ2ZEVk5PNW9SOVBlenF3Nmg1a2hReStTQk5pVkNUVkpmTWYxMTdCVkN4?=
 =?utf-8?B?dnRpQmI1cFpEZ3hKcXRoZDVNQU5DMHdlTVBvRHhoZ3lXY3dXV2g5L1A3eVNJ?=
 =?utf-8?B?Y3JseXhwdUF3YVpEckt1eFUyRVVRanByYWFYWDRtTncycW9PRzFNNVJHRmlM?=
 =?utf-8?B?V253UkVNcTJsdTk2SWpucVZGOWc2UDNSTWtnOU9aMk1NdkVkRDNCYktvdDhC?=
 =?utf-8?B?L0czNXdPa0dVQlF3MWVkdnJFS2haTmhLV0MxcWdnRjB2QWpudzQwVjBxNHRR?=
 =?utf-8?B?K3RVN2VMQlY3NUFaWDVqSUx3Smo0ODRqdWxjSGdaR1llbkpzWHZpRDVpeUgw?=
 =?utf-8?B?TDVPMUxDdkNOZkN0OFBWVXZPVVR2NUxMOTNoRitQbERCd3p5Q2tZMk14d0s4?=
 =?utf-8?B?K2ROZkFWd1QzbG0xdzdvTDdCYXBjQ3pQakFiN2l3RldYN0p5RVlpYll6TTVV?=
 =?utf-8?B?V0tkRHFkM2Y3VTMvOEVBOFN5cVFPOUkwWUFaSGRmQ2VrMGdoMDczRjN6ektX?=
 =?utf-8?B?cEJ6UjJRamVyMjIzaS9DY1ovMm5DNkRUdzBsdnNsb3pIUXAwblIzS1AzYlpF?=
 =?utf-8?B?Q052Nkt5Sy9yMFNEcDI0QXkyQmlTR0tNTkpPeU1xZFJLRzYvdTBSSmtreXJ2?=
 =?utf-8?B?M1drOS93YURudDd1WERpMnJyTS9zb0tIUmt0eE5EWDZSS3VkQktrTWZ0azdr?=
 =?utf-8?B?eEJBMnBoTmZGQ0lVNFVLYzhlbkFVS0IrUkxVVmhJQ3pFTCswZmoxcFh4VXFC?=
 =?utf-8?B?LzRMZHFtaE9JL1BjSkhqNnBYaTdBQkFDeU5zajFSaVVzTTZaQTlvTmZNeEVK?=
 =?utf-8?B?ZnQ2MFB4d1g4RGJsanY1R3FqNE1tYVJ1blNSbWdzYXU5cTVuMHNCSFAxaUNi?=
 =?utf-8?B?dFJuTjA1d2s0THFtOEREcWt4UjJ0UzIxRGNzYVVVcFMvL3hnYVlHYnFyZzcy?=
 =?utf-8?B?eDVjZ3pUL3EycUp3K1ZVdG82Q1VqMFMrOGlTQXVjSUJncXgrY3hGdGpzT1JB?=
 =?utf-8?B?VE1kaGw1enlMOEF5MlFKWU94WmlJVWh4VmtHK0JSOXVDbndGYllvN2NBaEFk?=
 =?utf-8?B?SEFNRFJBWTBFVnkrMGY0RmFNWU01MWNtSXcrUkN2T0p3RkxkN2JPa1UvVkdS?=
 =?utf-8?B?NDZrRmozZTR3R1c5YXJiQzQ5RHlSQm5KZDVURDV6ckIvdU5RTWloN2VQQkNI?=
 =?utf-8?B?SGRDNENvdlpJRldkVVlPNHhaVHhVVHdVaDRFSThsWVQ1S2JEL2oxd3dPNmUw?=
 =?utf-8?B?ejlhcVZ5U3FBVFgyMS9QQWFtZk92MFgxZ1JxbnVuR2xsd2tkTVdibnpuRXdO?=
 =?utf-8?B?RG5VeG1zaGNEa21hbzY3YmgyN0s1KytHdkwwSTlJTGpxeE04YmtNa0FOU0sz?=
 =?utf-8?B?eGlpY1poeXVNY3BZeGFUcTM3VG9KQWhXeDRsYnBZMXp3MjVUR0RoZmxrLzcz?=
 =?utf-8?B?YzVzU2JvMWF4OWRYaHR2VjhHWHlUVjFrYTNraUM4L04rTWhJcURkdmRWQi9J?=
 =?utf-8?B?OFJoMGZwK2tqZm9UYyt3blNCSWtSa0dHdm4wbXFtK2ZyRkdSUmx5SmRpRHNY?=
 =?utf-8?B?UGRMU0Y5QSs5QU15Ynlpamg4MDVNVHZOZk9za05oRXliZGdEb3J2bmMxKzhu?=
 =?utf-8?B?VWFCMGlIc09iU1ZjRmhVbnlNcFRMWHowdUtkWDcwTVNRVjRrNnE1WmczT0ZT?=
 =?utf-8?B?SHFxMkhiaWlOVjM0R09jbmV0eG9GY3V1VGtjRnZJT0RSZXNycGZTUTkzM2pE?=
 =?utf-8?B?V1oxYmlnN09lRGNLSU5kbFM1Y1BQeFFVcjRzNDhCZmRvV25ZbUZrOHA3RHJs?=
 =?utf-8?B?SGF6UWgrWWYxWStkODhudXBFdzVXSkIrY2ZqK01QYU5UN1h3RUNrZ2JjbDVw?=
 =?utf-8?B?MENUQWlUeC95QUNrR2R1RlJBNmhKVnNURzVnd3A2UFM4Y2F6TDVsbFIxUEVs?=
 =?utf-8?B?bFIvWVJsWWh6cjI0SE9pRHVqZkhPRlpNQ0ZIUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a722a6ba-8b6f-45d9-12cc-08de1c55e32c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 10:27:14.2246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cfz8tY7OsUcW8fMrEBWSMOyPapUJtFu+urogVUeCoqu80IjQS3til/ItsbOnSJLL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB8189
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Nov 2025 10:27:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18258

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBiaXRiYWtlLWRldmVsQGxpc3Rz
Lm9wZW5lbWJlZGRlZC5vcmcgPGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZz4g
T24gQmVoYWxmIE9mIFpvbHRhbiBCb3N6b3JtZW55aSB2aWEgbGlzdHMub3BlbmVtYmVkZGVkLm9y
Zw0KPiBTZW50OiBkZW4gNSBub3ZlbWJlciAyMDI1IDA4OjE0DQo+IFRvOiBiaXRiYWtlLWRldmVs
QGxpc3RzLm9wZW5lbWJlZGRlZC5vcmcNCj4gQ2M6IFpvbHTDoW4gQsO2c3rDtnJtw6lueWkgPHpi
b3N6b3JAZ21haWwuY29tPg0KPiBTdWJqZWN0OiBbYml0YmFrZS1kZXZlbF0gW1BBVENIXSBrbm90
dHk6IENhc3QgdHdvIHZhcmlhYmxlcyB0byBpbnQgaW4gaW50ZWdlciBleHByZXNzaW9ucw0KPiAN
Cj4gUHl0aG9uIDMuMTQgY29tcGxhaW4gYWJvdXQgdGhlc2U6DQo+IA0KPiBUcmFjZWJhY2sgKG1v
c3QgcmVjZW50IGNhbGwgbGFzdCk6DQo+ICAgRmlsZSAiL21udDIvem96by95b2N0by01LjMvYml0
YmFrZS9saWIvYmIvdWkva25vdHR5LnB5IiwgbGluZSA3MjIsIGluIG1haW4NCj4gICAgIHRlcm1m
aWx0ZXIudXBkYXRlRm9vdGVyKCkNCj4gICAgIH5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+Xl4NCj4g
ICBGaWxlICIvbW50Mi96b3pvL3lvY3RvLTUuMy9iaXRiYWtlL2xpYi9iYi91aS9rbm90dHkucHki
LCBsaW5lIDMzOSwgaW4gdXBkYXRlRm9vdGVyDQo+ICAgICBsaW5lcyA9IHNlbGYuZ2V0bGluZXMo
Y29udGVudCkNCj4gICBGaWxlICIvbW50Mi96b3pvL3lvY3RvLTUuMy9iaXRiYWtlL2xpYi9iYi91
aS9rbm90dHkucHkiLCBsaW5lIDM3MCwgaW4gZ2V0bGluZXMNCj4gICAgIGxpbmVzID0gbGluZXMg
KyAxICsgaW50KGxlbihsaW5lKSAvIChzZWxmLmNvbHVtbnMgKyAxKSkNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB+fn5+fn5+fn5+fn5+Xn5+DQo+IFR5cGVFcnJv
cjogY2FuIG9ubHkgY29uY2F0ZW5hdGUgc3RyIChub3QgImludCIpIHRvIHN0cg0KPiANCj4gYW5k
DQo+IA0KPiBUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6DQo+ICAgRmlsZSAiL21u
dDIvem96by95b2N0by01LjMvYml0YmFrZS9saWIvYmIvdWkva25vdHR5LnB5IiwgbGluZSA3MjIs
IGluIG1haW4NCj4gICAgIHRlcm1maWx0ZXIudXBkYXRlRm9vdGVyKCkNCj4gICAgIH5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+Xl4NCj4gICBGaWxlICIvbW50Mi96b3pvL3lvY3RvLTUuMy9iaXRiYWtl
L2xpYi9iYi91aS9rbm90dHkucHkiLCBsaW5lIDM0MSwgaW4gdXBkYXRlRm9vdGVyDQo+ICAgICBm
b3IgdGFza251bSwgdGFzayBpbiBlbnVtZXJhdGUodGFza3NbOihzZWxmLnJvd3MgLSAxIC0gbGlu
ZXMpXSk6DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB+fn5+
fn5+fn5+Xn5+DQo+IFR5cGVFcnJvcjogdW5zdXBwb3J0ZWQgb3BlcmFuZCB0eXBlKHMpIGZvciAt
OiAnc3RyJyBhbmQgJ2ludCcNCj4gDQo+IENhc3Qgc2VsZi5yb3dzIGFuZCBzZWxmLmNvbHVtbnMg
dG8gaW50Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWm9sdMOhbiBCw7ZzesO2cm3DqW55aSA8emJv
c3pvckBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgbGliL2JiL3VpL2tub3R0eS5weSB8IDQgKystLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9saWIvYmIvdWkva25vdHR5LnB5IGIvbGliL2JiL3VpL2tub3R0eS5weQ0K
PiBpbmRleCAwMDI1OGM4MGYuLmYwNDYwN2RmOCAxMDA2NDQNCj4gLS0tIGEvbGliL2JiL3VpL2tu
b3R0eS5weQ0KPiArKysgYi9saWIvYmIvdWkva25vdHR5LnB5DQo+IEBAIC0zMzgsNyArMzM4LDcg
QEAgY2xhc3MgVGVybWluYWxGaWx0ZXIob2JqZWN0KToNCj4gICAgICAgICAgICAgIHByaW50KCcn
LCBmaWxlPXNlbGYuX2Zvb3Rlcl9idWYpDQo+ICAgICAgICAgIGxpbmVzID0gc2VsZi5nZXRsaW5l
cyhjb250ZW50KQ0KPiAgICAgICAgICBpZiBub3Qgc2VsZi5xdWlldDoNCj4gLSAgICAgICAgICAg
IGZvciB0YXNrbnVtLCB0YXNrIGluIGVudW1lcmF0ZSh0YXNrc1s6KHNlbGYucm93cyAtIDEgLSBs
aW5lcyldKToNCj4gKyAgICAgICAgICAgIGZvciB0YXNrbnVtLCB0YXNrIGluIGVudW1lcmF0ZSh0
YXNrc1s6KGludChzZWxmLnJvd3MpIC0gMSAtIGxpbmVzKV0pOg0KPiAgICAgICAgICAgICAgICAg
IGlmIGlzaW5zdGFuY2UodGFzaywgdHVwbGUpOg0KPiAgICAgICAgICAgICAgICAgICAgICBwYmFy
LCBtc2csIHByb2dyZXNzLCByYXRlLCBzdGFydF90aW1lID0gdGFzaw0KPiAgICAgICAgICAgICAg
ICAgICAgICBpZiBub3QgcGJhci5zdGFydF90aW1lOg0KPiBAQCAtMzY3LDcgKzM2Nyw3IEBAIGNs
YXNzIFRlcm1pbmFsRmlsdGVyKG9iamVjdCk6DQo+ICAgICAgZGVmIGdldGxpbmVzKHNlbGYsIGNv
bnRlbnQpOg0KPiAgICAgICAgICBsaW5lcyA9IDANCj4gICAgICAgICAgZm9yIGxpbmUgaW4gY29u
dGVudC5zcGxpdCgiXG4iKToNCj4gLSAgICAgICAgICAgIGxpbmVzID0gbGluZXMgKyAxICsgaW50
KGxlbihsaW5lKSAvIChzZWxmLmNvbHVtbnMgKyAxKSkNCj4gKyAgICAgICAgICAgIGxpbmVzID0g
bGluZXMgKyAxICsgaW50KGxlbihsaW5lKSAvIChpbnQoc2VsZi5jb2x1bW5zKSArIDEpKQ0KPiAg
ICAgICAgICByZXR1cm4gbGluZXMNCj4gDQo+ICAgICAgZGVmIGZpbmlzaChzZWxmKToNCj4gLS0N
Cj4gMi41MS4xDQoNCldvdWxkbid0IGl0IG1ha2UgbW9yZSBzZW5zZSB0byBtYWtlIGdldFRlcm1p
bmFsQ29sdW1ucygpIHJldHVybiB0d28gaW50ZWdlcnM/DQpJZiBJIHVuZGVyc3RhbmQgdGhlIGNv
ZGUgY29ycmVjdGx5LCB0aGlzIHNob3VsZCBvbmx5IGJlIGEgcHJvYmxlbSB3aGVuIA0KcmVhZGlu
ZyB0aGUgc2l6ZXMgZnJvbSB0aGUgZW52aXJvbm1lbnQsIHNvIGNoYW5naW5nIHRoaXM6DQoNCiAg
ICAgICAgICAgICAgICBjciA9IChvcy5lbnZpcm9uWydMSU5FUyddLCBvcy5lbnZpcm9uWydDT0xV
TU5TJ10pDQoNCnRvIHRoaXM6DQoNCiAgICAgICAgICAgICAgICBjciA9IChpbnQob3MuZW52aXJv
blsnTElORVMnXSksIGludChvcy5lbnZpcm9uWydDT0xVTU5TJ10pKQ0KDQpzaG91bGQgc29sdmUg
dGhlIHByb2JsZW0uDQoNCi8vUGV0ZXINCg0K

