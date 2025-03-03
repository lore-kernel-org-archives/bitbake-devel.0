Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDDDC282CD
	for <webhook@archiver.kernel.org>; Mon,  3 Mar 2025 13:24:35 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.5])
 by mx.groups.io with SMTP id smtpd.web10.52992.1741008266591708643
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 03 Mar 2025 05:24:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Q3BbSAjJ;
 spf=pass (domain: siemens.com, ip: 52.101.70.5, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FYuYGZfG4266hb2MtUJhzADinqy9S4X8edY5z5IsBy2shyDkORiJlD6MnhasSCOLDgng3aFLIGbNWRfgP7507FCipROlZ26I2tOZYhTXOpt1gHfyfVd4q1j6rf/0W5raUUb0E0LPnXl3LLAsgl9bDHBL2IJL0pAlMkNhMG4xpAZcn1rpa41n9tJjwReo0WRYS0UHFnClAXO+niLmDLu2B86JxfjTV5PKl2fiWuNsJ4fZOqOouO/pHXO1BtxJlHNelCZ38/vwCN5SThawP1I/iWK9Nq/Gq4ClDqZbG8klL1qqFQe8QCuE2KieTo2pHLm6hmpzbdi4rrMkGPHN4kEPIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efQUAlMvId+8PwxWBMQfr+7lvTOP8zQHpR32hJx27pg=;
 b=kkwTp2+5F31fqZDsVtav0Fii1Z/ccIwc0FrcVzA6cg43iA5LJVs1xtvgdW3doBPZGxzty7QgKuYtJTKYzI/FlBf5laWEuRr4s1jB25cb62AVtbyBYmXjJS87lwYyG7CKRBSQZJ/Hp9puovco0tJnyKpOQt6MYjVFOEf+eTUitaXUmz/yrJ6sJPH6TeeQvDRAWij+JbzBzRiNPVnnjERowtCR75vyJLfasg0EyYWl1E7NtqD1frQwBvHQIxjG2KoTpKkNfvFyfH9KYDdjO6hOCQJHU+L99QzepIbl6b/cgCMO/re7b1i3oKFPrcdQZvCrSIjcOeiWbStcSvH0TJnsPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efQUAlMvId+8PwxWBMQfr+7lvTOP8zQHpR32hJx27pg=;
 b=Q3BbSAjJwSAbhYx7ec8KhoxsQRBHl9mXOsq9KQoOgL03VRv6GlBoDV/IUQA2Gs3Rx+btQf3T0MDEvp/2anu4QXwNYth+q4QbAc6eJGTPFtOyMDrf2KmmVmWqlvCpPxURDzqIeKDnS4yMSaUK1Bxzldndm99bG3ArZBZFwhlXSTBDkcj6HeYiignLGbm0NjKVHAV21W56HlUY6sLwwtx6HeFip6woDijwqTuuvk11YMVQGX4EQhVIdrrpeTUF9nK3DNHRKFHt0vnefZLnqG8Figgwsj7TaCn0FpK7iOsf5ZMQJFPi9GxTb24Pe7Q/K5Q+qpaawEPJ583uvJvRMQw06Q==
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by PAWPR10MB6757.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:331::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 13:24:22 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%6]) with mapi id 15.20.8489.028; Mon, 3 Mar 2025
 13:24:22 +0000
From: "Koch, Stefan" <stefan-koch@siemens.com>
To: "Ross.Burton@arm.com" <Ross.Burton@arm.com>
CC: "Sudler, Simon" <simon.sudler@siemens.com>,
	"richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, "docs@lists.yoctoproject.org"
	<docs@lists.yoctoproject.org>, "Kiszka, Jan" <jan.kiszka@siemens.com>,
	"alex.kanavin@gmail.com" <alex.kanavin@gmail.com>, "quentin.schulz@cherry.de"
	<quentin.schulz@cherry.de>
Subject: Re: [bitbake-devel] [PATCH v4 1/4] fetch2/git: Add support for fast
 initial shallow fetch
Thread-Topic: [bitbake-devel] [PATCH v4 1/4] fetch2/git: Add support for fast
 initial shallow fetch
Thread-Index: AQHbhIWvlao+sS0CyUqpt4LlOwIpqbNbplmAgAXPwYA=
Date: Mon, 3 Mar 2025 13:24:22 +0000
Message-ID: <af06c73f8f4b8b03cf84af9bd2c401b561a6a9db.camel@siemens.com>
References: <20250221172602.527924-1-stefan-koch@siemens.com>
	 <80041E02-3798-4BAD-86C3-D27381F6179C@arm.com>
In-Reply-To: <80041E02-3798-4BAD-86C3-D27381F6179C@arm.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR10MB4959:EE_|PAWPR10MB6757:EE_
x-ms-office365-filtering-correlation-id: eed7a7d9-94d9-406d-bf9c-08dd5a56b60c
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?cXlqTnpoeGlXQTk3cXFCbXZxdlZSVndkRFV2NVBOazZ3SG9GSkVLVno1ZFFV?=
 =?utf-8?B?NU5qNit2dk1GcFdaTUd1bVdNWUlKdDVFZ1VrMVlVeXhrOTVsOC93VEdCU0FI?=
 =?utf-8?B?Mk43V2U2czZXakpRVENmQmVKbHY1MVdkOGRqREZ3WWtSSHpsRnpWUURwNXJL?=
 =?utf-8?B?VHNxTmtTNkVoa2JEeXUxbkpJU0NIbXphVER6UzJ1Q0NZMGRvV2RkRGRtZElw?=
 =?utf-8?B?RG54NEJML3NDS0ZSYk9HR3RmckFkRkRSUGg2UE1MVTJLS21Qc0U4Wk9RcEJ0?=
 =?utf-8?B?b1YvVW1ZcHp6MHU1elB1US84VWpTbmRCT3FpbU1CL0Vlbmg2QUhIYlRiQTJZ?=
 =?utf-8?B?SGlWbitmS2hPejVnTjhOTmFUcm9lVXlLbkZQUXVwV05IOG5JUnJCWHk1UDRR?=
 =?utf-8?B?dmx3R3BLdUJUR3VTM3FjUlRvTVBVcVFZa1F0dm1rTHh2TU5adi93cnBtUlZI?=
 =?utf-8?B?Zkl0eTF2ejlJMlo2bkVZRnJ6Vlo3YUl6QS9tYVVMZnp6NFJ3SDlMSUd2VFRp?=
 =?utf-8?B?S3djOTZ6Y29PQ0Z1U2RGbnFGWFlraGVvMXR5M3BOdURxaFp5WThiaFlzSGRh?=
 =?utf-8?B?bE1GN2M5T0RwVUFtZURFTXZ1Uk4wTmgyVVNwOTR1TXIwRnVJcHVBVkxuTW5N?=
 =?utf-8?B?bEdtSThCQzZvZ1ZDZ1Q1TjFZV0c5NHNlSVgzZ21sOXNVVGk2bkFZLzlCejlz?=
 =?utf-8?B?ald2NmpWekdkU2l6TjhIb2ZRMVZKUWxQSjZTK3pqdTdtRWNzaTdxN3cySmJl?=
 =?utf-8?B?RWFHbTBDd240VzV3WUNpVGN4Uk1zTll4Ty9IVXR5UGJEUkpIU2UzbGZoOTQ0?=
 =?utf-8?B?a0hzRzBJWnlIRTYvUXY0YzkwU2tuWmUwSU9lajIwblZHc3B6dE41cHo2OHhi?=
 =?utf-8?B?Qkw4OVljRC9iQlRsQVZZZnd6c3Z2bzdBVVVya1RQUVlBK3lrWEpOTUtkNkNx?=
 =?utf-8?B?ekMvSExSRGlRVkV3WXM0QU8yN3lkWXRtNTZhazJMSWMrOTZCLytPQk5jT1I5?=
 =?utf-8?B?QnlpUkhLUlBBUEo1WUpXZ3BjSzRrYmlHZW9Ba05HS0dSVFdmemdua08zMmJr?=
 =?utf-8?B?LzRKR0l1ZGNBNEFuSzg5REp4R29sK3ZyN01vRm5LMmhpc04xUkFHR3RHUUNU?=
 =?utf-8?B?U2luekROanJiRjZqWVdlczRmeWdIMCtQNmt0RFEvbUR3OSt0RGVlcmUrTkZu?=
 =?utf-8?B?b1NiNEN2bUZGUDIwekJXTkxZdUJmRTlybzdoUmcxU0ZyR0k4dlBJOXV2S1FZ?=
 =?utf-8?B?a0pxOXpPSHJnMmlmbGkzZ3JSRkt0bVcrNVFoemdwZTE0azhPTGJ2QTcweTht?=
 =?utf-8?B?dnRyZy9qdlc0S0RYb2gvNWoxbjZBVklidzlsTHJrVFBNRUpmMjdPRTFvcTdD?=
 =?utf-8?B?bUVORFR2UjZMNGVjWitrNFFSK0EwWnFYek4zUUZmdVd0S0E5UUJZcGxyRHJI?=
 =?utf-8?B?cXp0MXFLejdoTHp2YlJHT2dwaGRleXpuTjJFakx4VGtybEhDdlBjaW9GYk5y?=
 =?utf-8?B?SHBSSTl6Q0RZQWxlQ2ZKMVNWY1N4UTl5WUVkL1hqeFpPaElYeS9vSlIwREFp?=
 =?utf-8?B?RmJzVUtobUNxWm9Qa3E1bWV3ckZVclNJc2hDenZDK0NMWWhONVVYMk1mY2Mz?=
 =?utf-8?B?NWtSVkhZSi9kUUlLaC9LcERIamhzUWQyY21raXhRdkQ3cUR6Wk1EV2dPQSts?=
 =?utf-8?B?bFVlODcvSllId3dxazhPWHJBNzl3eWJJaDk2Q1pRY1MxNUkwb2VhWjhyMWF1?=
 =?utf-8?B?ZWhsclJLUGlpcjl6VHhFSGx3amZvQyt6SGlrZGNRb1ZhUWhsSHRwaC9TVkxO?=
 =?utf-8?B?YmNVamFyd1lQUExTdEh1VXRIQU9pNmNGWlRwWVExbmtyQjJ1SmJJR3hTRmVz?=
 =?utf-8?Q?3zfpZNcwu3w+3?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dEhCdVBVaVo5dmNZc0gwMDNvckUydzhyN1dKRjdkSnNXdFNkLzNHc1JpODV3?=
 =?utf-8?B?MWZJWU5YaDZXNVNVV1NrTytxL2xFcHlPVklYYk9MYVNTZFlKTGdsOFJlRkRo?=
 =?utf-8?B?d21sZE8wYXk5ZENjMHN0Qkx2YzNFdzZkeEw4eG00T2NEejNWaG94ZmhkSVd1?=
 =?utf-8?B?VUZaV3kvSm9Cd2t1dCtuYzFQZnBGWmd4OFFZMVhsZktsNEY4NnBXWGRGS2dR?=
 =?utf-8?B?YUNaZXZBV3I5MjJzZnh1eXczc0s2UUU0YkVVSlAyWDIwdmFONEYxQ0RJRTF4?=
 =?utf-8?B?OWJLRUo1QlJpSEhLL3d1NnRIQ1dLNXhabDdWK1RzandhM1R3N0laMVpmMGM5?=
 =?utf-8?B?N0pMTk5qM1NDVmJCSGtSdGF2bE80c1hBL011RzU2K0ZjRFRNWitnYTdvZXNN?=
 =?utf-8?B?QTFOWXo2NUo1dWtqbzRFbktCcHpwaTFJanc3MVBTMTZjNHpoRkJBb2JHVGta?=
 =?utf-8?B?eWQ3cGtRMCtnRS8vYXhSSFdqb0RsemlVRGplVktMQTBtTnByV1MycmdUQTJ2?=
 =?utf-8?B?R3JxT29oZVJ1SDh2YmJpSUwyZHNnRWxIc1dDNTFVY3p2YzRTaFRCR1pMRE9S?=
 =?utf-8?B?RkJVQzFodkdKQm5XajRmdVZWRHpIWXM2TzBxU25oRHlhc0F4U3I2WG9aVDkr?=
 =?utf-8?B?enFaTStCamtucjZLL2dzMktPdzZrZ3lxODFXT1hvUHRZeGtERGltSVg4Njh4?=
 =?utf-8?B?dTNjTjVBcjNWZUhsWHZQRURyREVKVU52YW94N0V1UlEvVVhIRFBaNWRVU0lm?=
 =?utf-8?B?UnJVcmgyY2ZyYjNHU21rMDdMZXlKZkNSNFpkak9xak5sQUFvb1VWQXNDWVAy?=
 =?utf-8?B?Y2NMUzdwdCs3OVNVSmVyeGVkRWw0cWhZVTdXZXA3QWd3b0Z2WXJtYW90NjBt?=
 =?utf-8?B?UFpMT1dxakc4Y0JsUGk5TEtiRFFCYi91UWlYdGhrbDgzaTQyb1JFSW9ObDc0?=
 =?utf-8?B?SHJORU1NNWs5eGNSclhGeDhMUjV3dEYwSnpuckRTelh3ejNNK1JhbWlWNGla?=
 =?utf-8?B?NTU2YkNuRmNFai8wYzNiWHI5RHNzK3ZQd2lIL2w2eDM0YkNCaDdYRkNOSEtM?=
 =?utf-8?B?RmRhTHF0emdmM29yQUpLOGRhVHQrdFdlUlVGNlZ6azlUSmMza0tvbTY1TmY1?=
 =?utf-8?B?bzRNcTdudjZPS2hUSFBtSTlORG13YytXTHYwUEEwTk5FeUxNVG9sQVZvMUpH?=
 =?utf-8?B?QzNiTlUwL1BMSk1uZWJQMFA4VWJ4ZWM3Q2VEa3hrNTlOUm9RN0p3UWtNc3d3?=
 =?utf-8?B?emNBQ3ZNMCs0VzBpMmRRelZNZEwyOEQ4d3BRSTNtRUxqWWg2Uk4zWVhockxS?=
 =?utf-8?B?cHI1THoyd1ZzSjJnSkRnSlplWUNlWjNHZTc3UVlIMXZ0cHlzSG5UdUMxNUov?=
 =?utf-8?B?Q0pHWHpaTXlkOWdoTWdPUFl5UkNMQkhwRStza0tnc3JxSFRGRFhlaFk2TkxG?=
 =?utf-8?B?KzNSM081bUNwVjk5dUxtS3VXeDdtWDlNejAvcitYQVY1RkFpTmE3Q1h4U2N0?=
 =?utf-8?B?S3N0dFkxZ29MRGF5ZEJ0MG9TS2ExVDNhYkkxTVlnZkRuSkppUkVjdkJaVVFX?=
 =?utf-8?B?eWdsWjNzNm1sUXNWcVY2b2xCQmhidm43NDNiV1pDbzRlT3ZiL1Q1djZEQ3dQ?=
 =?utf-8?B?Wlg5cy9KK204S1BoK2J0TkVFMnJZcEd2TmJvaG5DODFaV2UyTlAyS2ErRWZL?=
 =?utf-8?B?KzF3MVRVcXJBMWY1QWhncTg3cW1ISmFyUlIyM1Y2bFVSOXpDQS90NnNXMm1W?=
 =?utf-8?B?Z1l1Q0QwTTk4dHAvb1M5aE8wTFB0TWJDYzl5SzdpdmtIejgwSFRROGdhQ00x?=
 =?utf-8?B?dWREeGI2WFZ3MWZKdHIyWk54NkZ1aCtqUUNUK01tKy9HdWRhQmI3ejZZTmJU?=
 =?utf-8?B?S3IrWFRIaWc2d3JTakRTQWdVemRlQ3ZjYzdRWms4VXM0bTBMSm1tRzgyYllW?=
 =?utf-8?B?b0FGc25GSFBTLzZNTEZ1YWpXT0d3VklhYzZ4SjhnS0VyQlE0TzVseWN4VkVK?=
 =?utf-8?B?a2NISFF6RGh4NGdWMmo5SDhicGVpVVdiTTRHRGtkKytvRUhVbFVRNGNUbDVm?=
 =?utf-8?B?WklGRnpBMVRXV3pRMUdHWWRqUkFTbFFEdDlFU21XQTZqUDdEQmptbi9xS2V3?=
 =?utf-8?B?OEVSK1UyZzlmWFlydE53Zi9wUENMRmQwWE9LZmNhRnpmTVFKVzRZeGwyeHVQ?=
 =?utf-8?B?S3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CCB0D8201184E14FBD53E7C88A90FDAB@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: eed7a7d9-94d9-406d-bf9c-08dd5a56b60c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 13:24:22.4235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ffzqDMGYN3js6kjp2Y8iHdOsch3Hze3GiI9zopc18m/j6gHzaQZh1t08BSqkf+aSXLOvFbYSRBu2iXIBRtITw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6757
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 03 Mar 2025 13:24:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17373

T24gVGh1LCAyMDI1LTAyLTI3IGF0IDIwOjM5ICswMDAwLCBSb3NzIEJ1cnRvbiB3cm90ZToNCj4g
T24gMjEgRmViIDIwMjUsIGF0IDE3OjI1LCBLb2NoLCBTdGVmYW4gdmlhIGxpc3RzLm9wZW5lbWJl
ZGRlZC5vcmcNCj4gPHN0ZWZhbi1rb2NoPXNpZW1lbnMuY29tQGxpc3RzLm9wZW5lbWJlZGRlZC5v
cmc+IHdyb3RlOg0KPiA+ICvCoMKgwqDCoMKgwqDCoCB1ZC5zaGFsbG93X3NraXBfZmFzdCA9DQo+
ID4gZC5nZXRWYXIoIkJCX0dJVF9TSEFMTE9XX1NLSVBfRkFTVCIpID09ICIxIg0KPiANCj4gV2h5
IHdvdWxkIHdlIG5lZWQgYSB3YXkgX2Zyb20gYSByZWNpcGVfIHRvIHNheSDigJxldmVuIHRob3Vn
aCBJIGFza2VkDQo+IGZvciBhIHNoYWxsb3cgY2xvbmUsIGRvbuKAmXQgYWN0dWFsbHkgZG8gYSBz
aGFsbG93IGNsb25l4oCdP8KgIElmIGEgcmVjaXBlDQo+IGRvZXNu4oCZdCB3YW50IHRvIGRvIGEg
c2hhbGxvdyBjbG9uZSwgaXQgY2FuIG5vdCBzZXQgQkJfR0lUX1NIQUxMT1c9MS4NCnY1IHBhdGNo
IHNldCB3aWxsIG5vdCBoYXZlIGBCQl9HSVRfU0hBTExPV19TS0lQX0ZBU1RgIGFueW1vcmUsIGJ1
dA0Kc3RpbGwgaGF2ZSBza2lwIGZhc3QgZnVuY3Rpb25hbGl0eSwgc2VlIG1haWwgZnJvbSAyMDI1
LTAyLTI2IGF0IDA4OjU4DQorMDAwMCAgc2VudCBieSBSaWNoYXJkLg0KPiANCj4gPiArwqDCoMKg
IEBjb250ZXh0bWFuYWdlcg0KPiA+ICvCoMKgwqAgZGVmIGNyZWF0ZV9hdG9taWMoc2VsZiwgZmls
ZW5hbWUpOg0KPiA+ICvCoMKgwqDCoMKgwqDCoCAiIiJDcmVhdGUgYXMgYSB0ZW1wIGZpbGUgYW5k
IG1vdmUgYXRvbWljYWxseSBpbnRvIHBvc2l0aW9uDQo+ID4gdG8gYXZvaWQgcmFjZXMiIiINCj4g
PiArwqDCoMKgwqDCoMKgwqAgZmQsIHRmaWxlID0NCj4gPiB0ZW1wZmlsZS5ta3N0ZW1wKGRpcj1v
cy5wYXRoLmRpcm5hbWUoZmlsZW5hbWUpKQ0KPiA+ICvCoMKgwqDCoMKgwqDCoCB0cnk6DQo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgeWllbGQgdGZpbGUNCj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB1bWFzayA9IG9zLnVtYXNrKDBvNjY2KQ0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIG9zLnVtYXNrKHVtYXNrKQ0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG9zLmNobW9k
KHRmaWxlLCAoMG82NjYgJiB+dW1hc2spKQ0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG9z
LnJlbmFtZSh0ZmlsZSwgZmlsZW5hbWUpDQo+ID4gK8KgwqDCoMKgwqDCoMKgIGZpbmFsbHk6DQo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgb3MuY2xvc2UoZmQpDQo+IA0KPiBJIHJlYWxpc2Ug
eW914oCZcmUganVzdCBtb3ZpbmcgY29kZSwgYnV0IGF0b21pY2FsbHkgY3JlYXRpbmcgYW4gZW1w
dHkNCj4gZmlsZSBzZWVtcyBwcmV0dHkgcG9pbnRsZXNzLg0KVGhpcyBpcyB0aGUgYnVnIHJlcG9y
dCBmb3IgdGhhdCBjb2RlIHNuaXBwZXQ6DQpodHRwczovL2J1Z3ppbGxhLnlvY3RvcHJvamVjdC5v
cmcvc2hvd19idWcuY2dpP2lkPTE0NDQxDQoNClRoaXMgd2FzIGludHJvZHVjZWQgYnkgY29tbWl0
IDMyNTBiYzk1MGM1NmJkN2RkMjExNGRmMjZlNWE4ZTEzYjA0Y2VhYzg6DQpmZXRjaDIvZ2l0OiBB
dm9pZCByYWNlcyBvdmVyIG1pcnJvciB0YXJiYWxsIGNyZWF0aW9uDQoNCk1heWJlLCBSaWNoYXJk
IGNhbiBleHBsYWluIHdoeSB0aGlzIGlzIG5lZWRlZC4uLg0KPiANCj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAjIFdoZW4gc2tpcHBpbmcgZmFzdCBpbml0aWFsIHNoYWxsb3cgb3IgdGhlIGZh
c3QNCj4gPiBpbml0YWwgc2hhbGxvdyBjbG9uZSBmYWlsZWQ6DQo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgIyBUcnkgYWdhaW4gd2l0aCBhbiBpbml0aWFsIHJlZ3VsYXIgY2xvbmUNCj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiBub3Qgc2hhbGxvd19mYXN0X3N0YXRlOg0KPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWQuc2hhbGxvd19za2lwX2Zhc3QgPSBUcnVl
DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBydW5mZXRjaGNtZChjbG9uZV9j
bWQsIGQsIGxvZz1wcm9ncmVzc2hhbmRsZXIpDQo+IA0KPiBBdCB0aGlzIHBvaW50IHdoeSBjYW7i
gJl0IHlvdSBqdXN0IHNldCB1ZC5zaGFsbG93PUZhbHNlIGluc3RlYWQgb2YNCj4gbmVlZGluZyBh
IHNlcGFyYXRlIHNraXAgdmFyaWFibGU/DQpUaGFua3MsIHY1IHBhdGNoc2V0IHdpbGwgbm90IG5l
ZWQgdGhhdCBza2lwIHZhcmlhYmxlDQo+IA0KPiBSb3NzDQoNCi0tIA0KU3RlZmFuIEtvY2gNClNp
ZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K

