Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5218CA1007
	for <webhook@archiver.kernel.org>; Tue,  2 Sep 2025 22:32:14 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.56])
 by mx.groups.io with SMTP id smtpd.web10.90770.1756852324994742256
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Sep 2025 15:32:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=cE1yOHDE;
 spf=pass (domain: axis.com, ip: 52.101.69.56, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v6lWc7T6n13zOv5HGHu4uYgDZD5dvhAjV5rVHvnC71JwTlKdwAKb6B9q6WCJo7GCJ6AM2vt/l4FDKYO/87BS1wrqgusjkhOIM90/apCbT5ixsDBm9wOEeoEe19KMZ/Vr4j49qExeUg0+EZeThuXX+qC8Eli4pck5ii9qFmcuRvJHYcc6ge5qF1fm0z5gSfm+AeQ4hqzBV7rBpCz+uD8y3yr6LAjY2Ux6PhKtNpo6BWkJC5/04AOyd0y5+VO+FXzSbfgT4r1MruuV4VzqIAPvXMPq6flA29129YSm40PyBlLGSWhuCzoRnSa4sCkTXmJpVMbCbvh6flys0lMMIRUUEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LG53kWIMc8/b4SII3Wyn+hZcoxlkBraQ1s56R2yhnJA=;
 b=WxD+h7+tolmSPZxGTPJCeEC7oZRWyDwcFvf5Y++IPg+2bAp1O0rzxAcchrArSv4iqB53xwq2nHJE3YqIdnEVXM8PKDTNhbCM3FKxWGGPE6U/UM5V+g1bZp65F7gYJpcreik0etxEcMpIgzypSbDcNBgrtpqLK62PEoXNkvmwXCMcTBk0PwX5pQbs0fvAmhHog05bGKr9C9Q6bGVrlcjQXvkPr3u1dXFoYjfnUd6wIayKyZfZJnfOGOJm2+GYGObaJrqqKVccJMyKRKkwkB3R3ATOUlcEzjoMo7zg0KqW7r8xrZ+dfUp18Ah9SAd4YDKyJIhsX8KvLoMpSjEJzOWkOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LG53kWIMc8/b4SII3Wyn+hZcoxlkBraQ1s56R2yhnJA=;
 b=cE1yOHDEhuWFjsM8yNY9F6QBx7mM9Nvznr4PF9biWfstmccKlz1ZxU5CnN429ZnruqHjSIELiMBa7BRn4ZL3bM1XhF42hv5n122eZ5QAju4eBycEwMRM3IcyUI3+5DyZoMgbCPocnlX0x4KT2tLooj0ANMYN/j2X8vFT5GWL904=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by GV1PR02MB10930.eurprd02.prod.outlook.com (2603:10a6:150:162::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 22:31:59 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9%3]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 22:31:59 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, Gyorgy Sarvari
	<skandigraun@gmail.com>
Subject: RE: [bitbake-devel] [PATCH 6/6] bitbake-setup: make sure git user is
 always configured
Thread-Topic: [bitbake-devel] [PATCH 6/6] bitbake-setup: make sure git user is
 always configured
Thread-Index: AQHcG0iiS3ohwr5HakWfT7tGdK+1ibR/wuPQgAASEACAAJa40A==
Date: Tue, 2 Sep 2025 22:31:59 +0000
Message-ID: 
 <DB5PR02MB102139E511197B10DA2348737EF06A@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20250901135836.2927686-1-alex.kanavin@gmail.com>
 <20250901135836.2927686-6-alex.kanavin@gmail.com>
 <DB5PR02MB1021363CFCC9D5EDC1217D085EF06A@DB5PR02MB10213.eurprd02.prod.outlook.com>
 <CANNYZj_drPD8qO_7JfYLc7Px77OdOM3Mp1MUhtd+nU7h8mnFBQ@mail.gmail.com>
In-Reply-To: 
 <CANNYZj_drPD8qO_7JfYLc7Px77OdOM3Mp1MUhtd+nU7h8mnFBQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|GV1PR02MB10930:EE_
x-ms-office365-filtering-correlation-id: 316f9d11-9d40-46f9-5209-08ddea7087bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?amMxb2laRysxcVNjWit1VzlYMGNrVjc5RktMMzBjZ0MxUTM4NkF6ZlhJTGxu?=
 =?utf-8?B?MFB0Ti9WTDlvVFRxL2VWMlRnNWpMNFo3dTR3K2pQUGxOZTkzVWxHQXF0cjhY?=
 =?utf-8?B?dEtiNFJvTVpWTTJNTUFiL0ZvblNlcThmVTl6cDcrUWN3dHZtSXNWVVEzTUdE?=
 =?utf-8?B?RVRCYXRXdnVCem1QOTU4c3NGRFJFRjNGN0xZWnducjkxeDJXT0lrWDNDVUVN?=
 =?utf-8?B?U29pYW9CVE5IZmozQ2kxZ3Y5Z3p3cGFhU2NmM3VaWTcvZmNsNzBIaFVjUDhk?=
 =?utf-8?B?ekJEN3FqTW1ldGlZLzlCQWpnTFNRRFNjUXZTSUhJL1BNSGZ2NlhmQlQwaEdX?=
 =?utf-8?B?SW5hdDRmZzFLRHREWlh0b1B3UlF4UE1VTXNpSWRDbUhlSGRkQ2V3UWJsaDls?=
 =?utf-8?B?Z2dvRVk1R2JJMHVGYk9aVno1NFZ3eDkyS1lFYk1ydGM2RFdqUmx4ODlYMk9R?=
 =?utf-8?B?RjhRYnVkR3ZzemQzSE8reFBMQUkvVEN5Y2V3RVNoWFBBNnVlV3U3eGNKMWw3?=
 =?utf-8?B?QVJFLzBUT0IxaEVhS2R1RmNGMHBMK0ZRZXFJelllUEpSZkhaNDJKNVR0dkFQ?=
 =?utf-8?B?WHJ6OWxTTkxiQml2azByV1VXMDlVS21iNStyV0tkci9hb2N5SFJCcFc5dGZt?=
 =?utf-8?B?UW5GQ1B1d09jVnJLSHJ3Q0ZxU0xraUJOMzdIa3A4a0dKWWlxWDBPbi9VOWJB?=
 =?utf-8?B?U2JsOXZmd09IblN4VStLRndZWVUzbjVGWmQ0dUd6ejB6NGpjT00xOHprNlVS?=
 =?utf-8?B?VnFjUTZIR1pqanJGZDRkR3ZyOC9FYzR5eWh5QWZFOXpPUTJZamhnbjVTOUd1?=
 =?utf-8?B?VUdUTHE2L1h6VFRFT3BsMmNacTM5aEZXOC96NFRtNzlYTEZ0NDRVNXc1RVJZ?=
 =?utf-8?B?ZnkxYWVHa0dtQlVNSUw1ODRiby9kTDVaVHhtUk9HR1ZhaFFXMXVaaVMzNFlv?=
 =?utf-8?B?cDdzcE5NQURhL2VpeE05cnNnVlF1Q3N2bDJlMXJGT0U5TjFSSHFiL3QwUkVm?=
 =?utf-8?B?TnZmbjJ1VCtNZ05qVnBBUXZXZ3JZbi9QTjZhOXdpVUMvdmNicmlJMXBCVmZJ?=
 =?utf-8?B?amR3UXgxUW9nR0FhK2NDL1N0aXIvbVJwVDU1ZjlCb1FYcUpCemNCUWxWZXZn?=
 =?utf-8?B?K1JvemIxSXJnd3pob0t2NWJCYmdFNUQzWWJkU0V4Y0xRY2c4czhhSmtwL1Jw?=
 =?utf-8?B?M21yeHZqcEZQbkJuZkU3cDJ3ZXh1WjF5NFJOZDhGeWtzbExBalIxUXVhK2lR?=
 =?utf-8?B?OUdmaE43ejVMenNQMUhrai9RcDhnUnB4Qm5zazBxcmViYXBUOFR3ejFqdkli?=
 =?utf-8?B?UmhCRWQ5RlpuQ3lMa0xxNVNJT1RKVGNRa0JWM3pqVHh2bmQxQ1VNUGM1NHhE?=
 =?utf-8?B?a2d5dmZiMmlsUjB0VTNXS2tMMGh0SDVnRmxLRDF5ekFoZWhpcjdiTFY0azN4?=
 =?utf-8?B?YmdRRmZxM082aStCWHVrVVI0cktuVWRMY3JHZ0V2M0dnVXZWTmhvZGQxbE02?=
 =?utf-8?B?cXY0S0VveFFhYjJXekE0UlpTdGVFVmNGdDNyMkJQeGpaOUtxT2t5TGh5SUcy?=
 =?utf-8?B?c2U2dUdYRVZjOCsxN0VJMmk2Tk4yREh3YmM0bSsycUg2Z3dwM0Nud1JjcHIy?=
 =?utf-8?B?b2t2WnRlYk4wT3BYdTFjdkp2MXV6eEhQUWpZU1k5bHh6WThMRnFFOTZleCt3?=
 =?utf-8?B?RGNkamxxNGlpZXJzY0JraTIrZlBUQUwrS2szSzJtNVQvSmVNRDEwanNqeHhi?=
 =?utf-8?B?Qk8rL3BVSDFYZkVoSEhmeXdQcUt4enhIdnpUT2dBcUtiYXRxRStpTStrS0xu?=
 =?utf-8?B?V1B3NTdHUUZiWU8zMXZ6U0VIcmltZVliMTFpZy94Nlg0R3lrbDZWNGRPb2to?=
 =?utf-8?B?NXpKbVpCL1lZK3NDM0dpK3hBZ0ZZT1l6aHVOM3grSkRjZHJ0Q05RbnkyaTFG?=
 =?utf-8?B?bVZ0ZFh2cmc4VTJacDdzeS9rcEJPS1B0OXc4VXA5RUNjZ21JbzdoMXlhcFY4?=
 =?utf-8?B?NldSTjZjY3hBPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NFEycmhBT0Y4VEI5bTlPQW42Wnozd0FPL0hmZlU4TXIwRmlSeTdDcWErd0xL?=
 =?utf-8?B?S2RrRnNUL0FNSUNXOE9mdVVoamZJMEVHQ1Bsc0FiV0JSL2FZUjZZdCt1VVEz?=
 =?utf-8?B?amJrRnJWU0xWcDNGZmtYa2EvT0YxdDBqTEhuVmh6MUdPeFcrQ0t3Y0tmU1Z4?=
 =?utf-8?B?UjlPUG5WWmxwMkJNaWFPSDNDc2d3V29oQ1VhQWZYWlFwSjVHb2Z2OU0yOTNN?=
 =?utf-8?B?WXlBSzc0bFhXQ0I0ZTVSODNPa2FDRlYxUmN1K1lCbjkzdWgxaFdkekFFaE55?=
 =?utf-8?B?NDh0dHYxdHVZSGY0TGhUNHBEc2Z0UHlkQ05uYmpGNkx0bmFzVzNCNHhzQXFx?=
 =?utf-8?B?ZGR5YmlESkhxa0RvMFdSWDRMK04rNlVuUlN6Y0VvbXVSZmhDSHRlS25sQ1Mv?=
 =?utf-8?B?blFEenRJcVhJckYxRW15bTk2Q1h4L3BPZE13ckFwZGw3UTVaU3NOcGtuMnIy?=
 =?utf-8?B?ZFF5bGVnSzJLaEcyWmFTTFJIbndSRVlmUGdSbjFXc0FyQm1ibk8yUWNuWCtq?=
 =?utf-8?B?ZTF1YjNCYzRidjVIb3JjZTZXemljY3lXMGk1S0pyczV0QXFWUVhKaVdybVZ3?=
 =?utf-8?B?cis3Z09pOGp6Sy9va3JtcE0ySmRYMVVTYjZUZS9ITWxualEreWRKUGRjZFlQ?=
 =?utf-8?B?azZOb21jMmNBY09MOTlXYklxVVlXSnN0WGYvRU1Bc3M4R3JlV2g3cDM1eGdD?=
 =?utf-8?B?L1RYWitrU2xabXluWXoxY0pnZkJ6K21NRDN1YUh0ajdPSGg0VStrTDRzL1Bh?=
 =?utf-8?B?WEZnV2t5OGZnRUovRGx1STVMNGVaYkJxTURxSDJjMTNEZDJGd2FzcExPMXhY?=
 =?utf-8?B?NGxHeXhaeklVcGZxaHppei9Ccjl4dzg5MDlqL0szWElGQ21yU0o3ME5nVXhK?=
 =?utf-8?B?T3BJdlRIYmZWU0xXbmR0K1JRL0ltSktlUWlUaGpXUkh0cVdhK2x4a2VMaUo2?=
 =?utf-8?B?Q1puWjFoOFJGT1l2cy9xUmlUY2F1eXlrSXJuV29PbkpOaTZ0Unc4cXMvcnNP?=
 =?utf-8?B?ckp5RnQ3V0h6VGluNnVqa3VOaS9lOEwvRkJVTWdWalkyM2pSNjZzOTJGb1d4?=
 =?utf-8?B?Y1NLUXJBQjJpS3ZIbFpEVGFOcTJ0eE5WRGxxWHN4Zms1bndaNFJuVTh4c011?=
 =?utf-8?B?NDZ6M2VpQm5McTBjREtrRFRWajhrcnUxbXpXVzBSTzdRa2M3eVRFclIzTE5Q?=
 =?utf-8?B?d0JERUdZeSt5MkVTdklaZzZGZVhycGhvWGxyaWpFV2s2QksrSDRlNFFoV0ln?=
 =?utf-8?B?YmJyRk95RFRmQW9NYzZDREFLQ0VNZE50aDcyemZrS0dpdnAxUUN2bjBrUjhr?=
 =?utf-8?B?bnl3enAyeVoyNm9maU5uNXZtZlowOXMvV0ZiMERrdzhOQ0pvblVIZFZzWEo2?=
 =?utf-8?B?MnkveFcxcXliSk5WbWEwckFWTGNTN0Z2VlJNeElDQUFZd29GemxLdUlTWmpa?=
 =?utf-8?B?dFl4UW9aYkRCVmRVM1FQV0hoV01zWGpqVGF1b0hSbUIvTVJ4RDRJdExwRXZS?=
 =?utf-8?B?MWp4M21GN0FkVnlTODRwUVNMK3FYaTZlc1pEQTZoK3FpNERRclJ0STlnekpk?=
 =?utf-8?B?bTlLZTBUZ1dhcTBsOFAzYTBFazllRTlrWTZPb1g5TGFUMkJWaXFvTFY3QXhM?=
 =?utf-8?B?TnJqUmYvQUpaSEcwazNpVW5POC9ueW5MN3c5TkRod3hKeklxbzRLVEV4Kzg4?=
 =?utf-8?B?c0hyK1FxZ2M4a2lKZjJrVmtLaUdOU2M1Mk1maXphVG55cmtRU1N5dmI2dytP?=
 =?utf-8?B?UmlRK2JISk9SQ080NjFVa204eXdEVlI2MjltZVB2ejArdmlrS3ZvTDZCM2pY?=
 =?utf-8?B?R2p2SnVoZGIrVWk4d0E5Z045K2N5YWZoUzlyT1RsYUpEN0YwNlpXeDRINkZQ?=
 =?utf-8?B?blRHaSsvNzMwbU5jMlVuWUZQZURXSXE3b1FGTWhHcG1pNDhySGpPWkVxSEY5?=
 =?utf-8?B?SG0zcjNnUjVlcTZOWDNtTmFDOTFiTnpqRjVwY2JNa0FISHRzN2U3b0E3Tlky?=
 =?utf-8?B?VHBuNFRKZFNpSVJKOFJDYVhlQmRYUXJUcERWTm9na2VRZWhvazFtaTQwa2h2?=
 =?utf-8?B?QkdpSFdpMXFZVHJON1FvYXZNU1h3ZzZMTzhuZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 316f9d11-9d40-46f9-5209-08ddea7087bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2025 22:31:59.0951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o6S+Y3nmg1pov4fA+hRtYllfePd2UAmw0wHHBsjv5Z2kDLnisFdw8BvqBVliK3V7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB10930
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Sep 2025 22:32:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17946

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4YW5kZXIgS2FuYXZpbiA8
YWxleC5rYW5hdmluQGdtYWlsLmNvbT4NCj4gU2VudDogZGVuIDIgc2VwdGVtYmVyIDIwMjUgMTQ6
MzMNCj4gVG86IFBldGVyIEtqZWxsZXJzdGVkdCA8cGV0ZXIua2plbGxlcnN0ZWR0QGF4aXMuY29t
Pg0KPiBDYzogYml0YmFrZS1kZXZlbEBsaXN0cy5vcGVuZW1iZWRkZWQub3JnOyBHeW9yZ3kgU2Fy
dmFyaSA8c2thbmRpZ3JhdW5AZ21haWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW2JpdGJha2UtZGV2
ZWxdIFtQQVRDSCA2LzZdIGJpdGJha2Utc2V0dXA6IG1ha2Ugc3VyZSBnaXQgdXNlciBpcyBhbHdh
eXMgY29uZmlndXJlZA0KPiANCj4gT24gVHVlLCAyIFNlcHQgMjAyNSBhdCAxMzo0OSwgUGV0ZXIg
S2plbGxlcnN0ZWR0IDxwZXRlci5ramVsbGVyc3RlZHRAYXhpcy5jb20+IHdyb3RlOg0KPiANCj4g
PiA+ICsgICAgYmIucHJvY2Vzcy5ydW4oImdpdCAtQyB7fSBjb25maWcgdXNlci5uYW1lIGJpdGJh
a2Utc2V0dXAiLmZvcm1hdChjb25mZGlyKSkNCj4gPiA+ICsgICAgYmIucHJvY2Vzcy5ydW4oImdp
dCAtQyB7fSBjb25maWcgdXNlci5lbWFpbCBiaXRiYWtlLXNldHVwQG5vdC5zZXQiLmZvcm1hdChj
b25mZGlyKSkNCj4gPiA+ICAgICAgYmIucHJvY2Vzcy5ydW4oImdpdCAtQyB7fSBjb21taXQgLS1h
bGxvdy1lbXB0eSAtbSAnSW5pdGlhbCBjb21taXQnIi5mb3JtYXQoY29uZmRpcikpDQo+ID4NCj4g
PiBQbGVhc2Ugb25seSBzZXQgdGhlIEdpdCBuYW1lIGFuZC9vciBtYWlsIGlmIHRoZXkgYXJlIG5v
dCBhbHJlYWR5IHNldA0KPiA+IChzZWUsIGUuZy4sIG9lLnBhdGNoLmdpdENvbW1hbmRVc2VyT3B0
aW9ucygpLCBhbmQgY2hlY2tfZ2l0X2NvbmZpZygpIGluDQo+ID4gdXRpbHMuYmJjbGFzcykuIFdl
IGhhdmUgYSBnbG9iYWwgR2l0IGhvb2sgdGhhdCB2YWxpZGF0ZXMgdGhlIG5hbWUgYW5kDQo+ID4g
ZW1haWwgb2YgdGhlIGNvbW1pdHRlciBhbmQgdGhlIGFib3ZlIGdpdCBjb21taXQgY29tbWFuZCB3
aWxsIGZhaWwgaW4NCj4gPiBvdXIgZW52aXJvbm1lbnQuDQo+IA0KPiBJJ20gbm90IGZ1bGx5IGNv
bWZvcnRhYmxlIHdpdGggZG9pbmcgdGhhdC4gVGhlIGNvbW1pdHMgaW4gdGhpcyByZXBvDQo+IGFy
ZSBjcmVhdGVkIGJ5IGEgcHJvZ3JhbSwgYW5kIHNvIHRoZSBhdXRob3Igc2hvdWxkIGJlIHRoZSBw
cm9ncmFtLCBub3QNCj4gdGhlIHVzZXIgcnVubmluZyBpdCAod2hvIGRpZCBub3QgZ2l2ZSBjb25z
ZW50IHRvIHVzZSB0aGVpciBuYW1lIGFuZA0KPiBlbWFpbCwgcmVnYXJkbGVzcyBvZiBob3cgaGFy
bWxlc3MgdGhlIGNvbnRlbnQgaXMpLg0KDQpJIG11c3QgYWRtaXQgSSBoYXZlIG5ldmVyIHRob3Vn
aHQgdGhhdCB3YXkuIEluIG15IG9waW5pb24sIEknbSANCmNyZWF0aW5nIHRoZSBjb21taXQgcmVn
YXJkbGVzcyBvZiB0aGF0IGl0IGlzIHNvbWUgdG9vbCBJIGFtIA0KdXNpbmcgdGhhdCBpcyBjcmVh
dGluZyBpdCBmb3IgbWUuIA0KDQo+IENhbiB5b3UgZml4IHRoZSBob29rIHRvIHJ1biBvbiBwdXNo
ZXMsIGFuZCBub3QgY29tbWl0cz8gT3IgYWRkDQo+IGJpdGJha2Utc2V0dXAgdG8gYWxsb3dsaXN0
Pw0KDQpUaGUgd2hvbGUgcG9pbnQgb2YgdGhhdCBob29rIGlzIHRvIGNhdGNoIG1pc2NvbmZpZ3Vy
YXRpb25zIGJlZm9yZSANCnRoZXkgbWFrZSBpdCBpbnRvIGFueSByZXBvc2l0b3J5LCBpLmUuLCBh
dCB0aGUgdGltZSBhIGNvbW1pdCBpcyANCmNyZWF0ZWQvdXBkYXRlZC4NCg0KVGhlcmUgaXMgbm8g
YWxsb3dsaXN0IGFzIHRoZSBpbnRlbnQgaXMgdGhhdCB0aGUgR2l0IGNvbmZpZ3VyYXRpb24gDQpt
dXN0IGJlIHZhbGlkICh3aGljaCB3ZSBkZWZpbmUgYXMgdGhlIGNvbmZpZ3VyZWQgR2l0IG5hbWUg
YW5kIGVtYWlsIA0KbXVzdCBtYXRjaCB3aGF0IGlzIGluIG91ciBMREFQIGRhdGFiYXNlKS4gVXNl
cnMgdHlwaWNhbGx5IHVzZSANCnRoZSAtLW5vLXZlcmlmeSBvcHRpb24gaWYgdGhleSBoYXZlIHRv
IG92ZXJyaWRlIHRoZSBob29rIGZvciBzb21lIA0KcmVhc29uLiBXaGljaCBJIGd1ZXNzIHdvdWxk
IGJlIGFuIGFsdGVybmF0aXZlIGhlcmUgdG9vLi4uDQoNCihZZXMsIG91ciBob29rcyBtYXkgc2Vl
bSBkcmFjb25pYywgYnV0IEkgbGlrZSB0byBiZWxpZXZlIHRoYXQgdGhleSANCmhhdmUga2VwdCBt
eSBtaW5kIGF0IGxlYXN0IHNvbWV3aGF0IHNhbmUgZ2l2ZW4gaG93IG1hbnkgZGV2ZWxvcGVycyAN
CndlIGhhdmUgd2hvIG5lZWQgdG8gdXNlIEdpdCwgYW5kIGhvdyBlYXN5IGl0IGlzIHRvIGdldCBp
dCB3cm9uZyANCndoZW4geW91IGFyZSBuZXcgdG8gR2l0LikNCg0KPiBBbGV4DQoNCi8vUGV0ZXIN
Cg0K

