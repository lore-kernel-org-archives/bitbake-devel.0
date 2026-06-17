Return-Path: <jaipaul.cheernam@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55282CD98E2
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 10:30:45 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.21])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12385.1781692236046357573
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 17 Jun 2026 03:30:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@est.tech header.s=selector1 header.b=XmNpeCdh;
 spf=pass (domain: est.tech, ip: 40.107.130.21, mailfrom: jaipaul.cheernam@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g8TsI7ZfvNAGB4o2D6h2YxT02eFU/PWyGzf4TdijwMf0VTv18EtlnOeQuATE98KXDCez+y59S4/pnpjMkiL3HWJYFJjUPUaKj5E5s817gBTlgf8+jvVs5i1gixfLI2Yf8CdJSuMBvMZDY5HlOMqoK78JH2XZCw9XlNe+30LYuRe+V/dOfYBW3LM7eteO85zFUkV9TJaZIY2IWHPjYk7sKvZfgQ3u6tJgA5XjDoYkvGyBPcDPQx8HkvDOxXhfz3VKf2LUxYUurTJWvbbhb/HoLgJTdbJQ9XwWF0Xc2BEmJrnFDobu1sfOdJB7Fabrb6mTJHpTvKwWeAfUppnmK27MIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXfYCnUusF0QhCXAZF8ZW64aaNcviFSh0rmZOVqCm+s=;
 b=LSzbgSJ+4nUOqqrg8c6tAcEscj3lmtx6oFmoflwjomT4X/17l7glXoOK5WXkkK5YTBqWDM2IpDYetyiJreRMbhh1RGZyqfA1r/YEc0aueLgZVhIs1vuQhh2FG1WQF96g3u4GyhiGXiSNknpBA0qgHZGLt5VAK608qCnkc19I37J5wKnEhOPWg7ssnHFpXUeP5NEgNHdERYRAcugV3nlfKX31G6SANBGmTx9OBDUCiaKfoVvIWzplrghMajhSsBjgCjoZ92aaohpLfKnmcGTPzzBDZXThdMbk+ZKptspkLx+V5iK2/adwsfOZvRk7WhlA3fOblfIQRY4Fx3XXMNNM1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXfYCnUusF0QhCXAZF8ZW64aaNcviFSh0rmZOVqCm+s=;
 b=XmNpeCdhf2TJXcwWvLn9rpjijh4aEot+4G+WQjepZvUsrCMJ8Z2hOplLpVQXKSxfgVyhKCb45zKvLGWx8tdk7dw8Z4FJj4H7KImoqqS/93+zVgwqci/TE/MyyrYcaU95r5UioVA/zBoV5zdV3vJPcke3j9zn6WmX7oNqJHpFqGCt7wKq2IwKJ8IKBzhgN00kxNSINfzt3D8+4ZcBd/0M9xsJhmajbmRUnGE4Xb06iiBSEcDkKYGixZmPqhUpxJjH8j/aXn5V9nMWypFdPNY8tB5Js511oxoVYAAwl1rrv0LFy22sDIg1IYI9aHnaJ74Y1u3ZagleTDasXMzUI/4HOQ==
Received: from GV1P189MB2954.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:263::18)
 by AMBP189MB3363.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:6ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 10:30:31 +0000
Received: from GV1P189MB2954.EURP189.PROD.OUTLOOK.COM
 ([fe80::a7e4:7d5b:ab4a:4b96]) by GV1P189MB2954.EURP189.PROD.OUTLOOK.COM
 ([fe80::a7e4:7d5b:ab4a:4b96%3]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 10:30:31 +0000
From: Jaipaul Cheernam <jaipaul.cheernam@est.tech>
To: Alexander Kanavin <alex.kanavin@gmail.com>
CC: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: pass install-buildtools
 options from config and CLI
Thread-Topic: [bitbake-devel] [PATCH] bitbake-setup: pass install-buildtools
 options from config and CLI
Thread-Index: AQHc/MEmemh0KfEkr0iryPC9iD+ZPrZA9jiAgABA4kWAAAehgIABUCom
Date: Wed, 17 Jun 2026 10:30:31 +0000
Message-ID: 
 <GV1P189MB2954EA1ACC412797B25F889DF3E42@GV1P189MB2954.EURP189.PROD.OUTLOOK.COM>
References: <20260615121856.96250-1-jaipaul.cheernam@est.tech>
 <4beac8227f89f57e5ae0984a5163685132577583.camel@linuxfoundation.org>
 <DU7PPF66507B2D7CFA2CD308AAA2C04622AF3E52@DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM>
 <CANNYZj_j7irKNRdeGDpF6mfKit_78ML5=XQJ3CeZckcM3924ZA@mail.gmail.com>
In-Reply-To: 
 <CANNYZj_j7irKNRdeGDpF6mfKit_78ML5=XQJ3CeZckcM3924ZA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB2954:EE_|AMBP189MB3363:EE_
x-ms-office365-filtering-correlation-id: 230e015e-c6a1-45f3-758c-08decc5b753b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|8096899003|3023799007|11063799006|4143699003|56012099006|6133799003|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: 
 T+oGfTwPFEYYifWuxDNwZiVgd8kiNvbjhd7J8YB9EZm51CUJ51iaCTSifUeYfALy/5LT0nX679UYq6831xsPi5l6W+poqItgjSshGAbeoWUoLP92Qg3r9doKZyweSVNI7W8jaokcJLXMeAk3/LSPyao9gPWWrPuU7s6bfIgx74xhv3F/zepiugGP2i8PGXPo7l35Nty9/QO7li9LMcUUebOakcTSYM44kWzU5EawpySwb8v78ZexuzcBFlJO0PX3Vuk1j7igqcyEMoH6xht7mbSVSCugE4txS+WBYRQ4Eeh3PJYH0yths/rVW9r/bntjQtdKIt6mVDG1MlT8ma3XKD1r3hyTrHt9etp1Z+YyEeXVnPjjgAfQiXh4/kwL0ahvykScUUQbdD/zshy6vmAVTmhP8E4akMUZep/qpELlXI4NV0KEc23eah9AwMnj0crMZQbbwkEfXm/BTfoqYnAQmG7jFcDuG1u9LIfLM827ek1g8uGmg07IKzsIHlQcc2pJGY0cPgTFp/ZMUtbT2ltDZbFEGKEV0E9rlsaJEtNdGDpvWjhZWpsVEPoahiD+CRTr1vYx2b+OWPojeru9SQpcSH2lf0f1lhzW1b94y6NSqHFRGbbswT+Yzeb2+vGVVhqt2/mVgcAkXAjpDE2ZI9d0XP1FJYtXGatG5NAphWS0iLb1mNKAvw2WDJUyHOjRNM6TNYBHpJy0RNb42gC8TfAZeQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB2954.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(8096899003)(3023799007)(11063799006)(4143699003)(56012099006)(6133799003)(38070700021)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?big5?B?RldrT250dEQ5S0xiQzRIeVp6SlpGa3FMZnpHcytiemRBREx4bEd0eDhBbXJYQXly?=
 =?big5?B?dUNQaXFUMUllbU5xM0l3UGp3bFpvRWlFS3V6YW0wVWNPNkxqdFpidC8va3VnMkNn?=
 =?big5?B?bTNHalp1SG1rZVVTc0Zub3M1cFY4YTZ4ZXBkanA0ZVJpb3dWMDA5OFh0d1o2SUxO?=
 =?big5?B?SGhKWkJhWWRFK25aVzNmOWhTUzhWYVV6VlRVQ2NzYzF2N2ZPdTVNek50U2FTNFhB?=
 =?big5?B?eGxXNzhiS3FHSDM4RkdoaFdCVGJ3bU9haGlmOU9BbURjQnltMmhFVEZVYXp3UFRv?=
 =?big5?B?VXRDSDlsbktlOUgzTk9BN0FMYzFzSlhHakdRdmpTblRvYkxSYnQ4QlUwTnkvUnht?=
 =?big5?B?TGxKRXpwbkpjM3I2S2dFS2ZJMHJmQ1JzdFYzMnRBWkNpQytmWVdUTCtyUmFNZkE2?=
 =?big5?B?dGZtTDF3RmtkcG4ySHlaZjYvanZQU01jbmxGTElLTFBpcUFkZWNGb2JVWnZUUDU2?=
 =?big5?B?NEg1TjRYMk5TaitlelFTT3YzMDZNYVpBY29rS1d1Y1FTdmdqeS8xMDdKTHMwRlVR?=
 =?big5?B?RzE3NkdPSnZqNGpPbGF2bUIrQVBjMElLaE9SSU9IWnBqcE8vdXZDU21kNStIa3dK?=
 =?big5?B?SWZCbmdMN2k3R0plQlZJc0tyQ1BZYTJSZXlPS0R2aXhhbmVIbStGZFRYa0paa3A3?=
 =?big5?B?VXoyVHFWN3ZscTBaWXc1REI1eWNTaWlUSHNXNEROS0p6UlR0Q0ZuR200bTZwWWE0?=
 =?big5?B?ZlJVdU9IQ2ozVFFaWDR1TmJTUi92Qi9iQVJnWFM5aTdGKzFFK2FWNEhlV05JSkFW?=
 =?big5?B?UjJTdlZSTEt1UGMwTXY4bnNpMCtnYnUzZndPRmNwZG4vOWoyWTFsdEh0d2R4Ty8y?=
 =?big5?B?cEZOOWxnNnJiNDRrbGhzcmhBbFljUGg3VXV2MytSbHpnc0dWbEpIMVd1TUNPKzVQ?=
 =?big5?B?Vm5yN3ZKYUtrWVRmdWFMajdWdzNISjdqZnRKdEZvSE82bkM3eVJyeXVOMjZqQXkw?=
 =?big5?B?MlJqSm80Vm9pMTRRSDYyWnE1YzlvRndGRkhEbGo5TzVISS9QTnNxTjgwRHhDTXd6?=
 =?big5?B?S1A3NGpKQ2pzV3hNYkFvYXRVcHhWUVJpcVdheUh2L1g4d0tKTFQ5UFBaWTh6NVR4?=
 =?big5?B?WktYcTNrRzRmYytjcDkzOHhzTWlpWGNKbnJCT3AxeVdwbnRPbFZaMmNBWXNERFZX?=
 =?big5?B?K3ByNFk2bndIbzluMjdmdEFlUnB0Nzd6V1p2ZkV2MXVPZjFUMzdIS0srOUluNHJ6?=
 =?big5?B?MUhBck9CZ2Eyd1RnbEpsOHZjcXlUZ3hIZ09jdnNsZk5PakFyeWZ0U28yQlBJajRj?=
 =?big5?B?U0RyalZDU1FoS0N4a2ZybWZHcDYrY1U4TG9lekhhVlVFeVRnSlBaOW9EMmxXb1VU?=
 =?big5?B?NzdBYW92eHV5TFlrNURweGMrbG0wQ2piNVBFemV4Q2dxamRoRzVoSHJua1VQQzdu?=
 =?big5?B?UVNKNm5peEpPZjR0RHpueG9aRnQ2ZW1Cc1VQekJMQXVqOTZURS9lZ2FOUC82bGdr?=
 =?big5?B?dXY3aTROSzY3NnBXUGJ4b0hrdjE5OVlGSkdDckJOb2VMUUJSVFRGWk9wZEw4cWNv?=
 =?big5?B?YjNYMWpDblNPbXJ6dW1ubTNaSXoxNkl3WE5vVFlSb2U0TUZSbVNGbVdBUDJBUE82?=
 =?big5?B?Qk1ZY1VKNnA2M29ub0dJNHRTQS90aFNkTjU1QmhsT095Q0IyWmhMVXY4aWFTdXYz?=
 =?big5?B?YjRHQUxpd1g5SkdSeHkyc05JNXkvK2QwaFJlblAwU1hXTGJuenBndUtzNVRHWlha?=
 =?big5?B?Yi81TXc2MnR5SHYvUm9UQUhPb2Y4VXpUV0xISVFtTHZHUE1xT042eXJJeTBFcVNr?=
 =?big5?B?bVdpWUpRZ21tRkRmV1I0STE1bE9OSE1wU2ZlVG0rYjJhRElKM1JZUm1MZE4wMXpa?=
 =?big5?B?TXBFYXpQZXhMd0Y0YU1HQXBXaFJuM1cxTXArVlZCTTYwRDdtVEx6eW82VEhoZjFm?=
 =?big5?B?MTRDcGNqTU1icVprcW5McWtZamVWZW94RDMwanJ1d0hFQmFxQnFobnYrOGlod251?=
 =?big5?B?b2pad1hxMHJuSyt1THg0TFlLdFptclpEK3hDV0Zram11UGpkaDh1OGZMZ1dVVW5y?=
 =?big5?B?elh2SjNXT25NMHRsOVh5dnFCVEFoSXQ2OGpnZnJXWTYwam5PdzZtWWFGMUxsQytB?=
 =?big5?B?WDRDdGxPejhJWUxueFZYc2k2YmtTMG9qSkhocE1lcXNUUFRNYUNkblNNdlI2ZnBX?=
 =?big5?B?clVKcUJaNG5kK1F3amdZTTlrc1BQL1laNWFuM3ltaHhFQlE0YW1ycnA5WDVGaDlw?=
 =?big5?Q?mDYomNdUyeZStsfpsrzamXGO7kNo0FcrQv9f+Cwkr3g=3D?=
Content-Type: multipart/alternative;
	boundary="_000_GV1P189MB2954EA1ACC412797B25F889DF3E42GV1P189MB2954EURP_"
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB2954.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 230e015e-c6a1-45f3-758c-08decc5b753b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2026 10:30:31.3972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cBxb3oH3NFMwpH4VxsT6AUDVQFkWdS4zlxhVl+TQO2S1xOS+qBE8chZIq2Ay7vIPEPCVwv/JjaKms5N3YUrBtDrG70jKnFQYloJYjnjdg6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBP189MB3363
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 17 Jun 2026 10:30:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19724

--_000_GV1P189MB2954EA1ACC412797B25F889DF3E42GV1P189MB2954EURP_
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64

SGkgQWxleCBhbmQgUmljaGFyZCwNCg0KICBJIGFtIGluIGZhdm91ciBvZiB0aGlzIGFwcHJvYWNo
LiBIZXJlJ3Mgd2hhdCBJJ20gdGhpbmtpbmcgZm9yIHRoZSBpbXBsZW1lbnRhdGlvbjoNCg0KICAx
LiBiaXRiYWtlLXNldHVwIGRvd25sb2FkcyB0aGUgYnVpbGR0b29scyBpbnN0YWxsZXIgdXNpbmcg
YmIuZmV0Y2gsIHdpdGggc2hhMjU2c3VtIHNwZWNpZmllZCBpbiB0aGUgYml0YmFrZS1zZXR1cCBj
b25maWcgKHNhbWUgbWVjaGFuaXNtIGFzIGxheWVycykuIFRoaXMNCiAgZ2l2ZXMgdXMgZG93bmxv
YWQgY2FjaGluZyBpbiBETF9ESVIgYW5kIGNoZWNrc3VtIGVuZm9yY2VtZW50IGZvciBmcmVlLg0K
ICAyLiBiaXRiYWtlLXNldHVwIHRoZW4gY2FsbHMgaW5zdGFsbC1idWlsZHRvb2xzIC0tdXJsIGZp
bGU6Ly88RExfRElSPiAtLWZpbGVuYW1lIDxuYW1lPiAtLW5vLWNoZWNrIKFYIHRoZSAtLW5vLWNo
ZWNrIGlzIHNhZmUgYmVjYXVzZSBiYi5mZXRjaCBhbHJlYWR5DQogIHZhbGlkYXRlZCB0aGUgc2hh
MjU2LiAoQnkgd3JpdGluZyBzaGEyNTZzdW0gZnJvbSBjb25maWcgIGludG8gRExfRElSICwgd2Ug
Y2FuIGF2b2lkIC0tbm8tY2hlY2sgYXMgd2VsbCBidXQgYml0IGEgaGFja3kgKQ0KDQogICAgIFR3
byBvcHRpb25zIGZvciBpbnN0YWxsLWJ1aWxkdG9vbHMgaGVyZToNCg0KICAgICAoYSkgVXBkYXRl
IGluc3RhbGwtYnVpbGR0b29scyB0byBoYW5kbGUgZmlsZTovLyBVUkxzIG5hdGl2ZWx5IKFYIHVz
ZXMgdGhlIGZpbGUgaW4tcGxhY2UsIGF2b2lkcyBhIHJlZHVuZGFudCBjb3B5IG9mIGEgcG90ZW50
aWFsbHkgbGFyZ2UgKH41MDBNQikNCiAgaW5zdGFsbGVyIHRvIGEgdGVtcCBkaXJlY3RvcnkuDQoN
CiAgICAgKGIpIExlYXZlIGluc3RhbGwtYnVpbGR0b29scyB1bmNoYW5nZWQgoVggd2dldCBhbHJl
YWR5IHN1cHBvcnRzIGZpbGU6Ly8gYW5kIHdpbGwgY29weSB0aGUgZmlsZSB0byB0ZW1wLiB0IHJl
cXVpcmVzIHplcm8gY2hhbmdlcyB0bw0KICBpbnN0YWxsLWJ1aWxkdG9vbHMsIG1ha2luZyB0aGlz
IGEgYml0YmFrZS1vbmx5IHBhdGNoLg0KDQogICAgIEknbSBmaW5lIHdpdGggZWl0aGVyLiBXaGF0
J3MgeW91ciBwcmVmZXJlbmNlPw0KDQogIFByb3M6DQoNCiAgLSBCdWlsZHRvb2xzIGluc3RhbGxl
ciBpcyBjYWNoZWQgaW4gRExfRElSIGFsb25nc2lkZSBsYXllcnMgYW5kIHNvdXJjZSB0YXJiYWxs
cyChWCBzdXJ2aXZlcyB1cHN0cmVhbSBkaXNhcHBlYXJpbmcNCiAgLSBDaGVja3N1bSBpcyBpbiBh
IHRydXN0ZWQgY29uZmlnIGZpbGUsIG5vdCBmZXRjaGVkIGZyb20gdGhlIHNhbWUgc2VydmVyIGFz
IHRoZSBpbnN0YWxsZXIgoVggcHJvdGVjdHMgYWdhaW5zdCBzdXBwbHkgY2hhaW4gYXR0YWNrcw0K
ICAtIENvbnNpc3RlbnQgd2l0aCBob3cgZXZlcnl0aGluZyBlbHNlIGlzIGZldGNoZWQgaW4gYml0
YmFrZS1zZXR1cA0KICAtIC0tbm8tY2hlY2sgcmVtYWlucyBpbiBpbnN0YWxsLWJ1aWxkdG9vbHMg
YnV0IGlzIGp1c3RpZmllZCChWCB0aGUgY2FsbGVyIChiaXRiYWtlLXNldHVwKSBoYXMgYWxyZWFk
eSBkb25lIHZhbGlkYXRpb24gdmlhIGJiLmZldGNoDQoNCiAgQ29uY2VybnM6DQoNCiAgLSBJZiBz
aGEyNTZzdW0gaXMgb21pdHRlZCBmcm9tIGNvbmZpZywgYmIuZmV0Y2ggc3RpbGwgZG93bmxvYWRz
IGJ1dCBwcmludHMgYSB3YXJuaW5nIGFib3V0IG1pc3NpbmcgY2hlY2tzdW0gKHJlc3BlY3RzIEJC
X1NUUklDVF9DSEVDS1NVTSBpZiBzZXQpDQoNCiAgRmxvdyB3aGVuIHVzZXIgcnVucyBiaXRiYWtl
LXNldHVwIGluc3RhbGwtYnVpbGR0b29scyAtLXNldHVwLWRpciAuL215LXNldHVwOg0KDQogIDEu
IGJpdGJha2Utc2V0dXAgcmVhZHMgY29uZmlnIKH3IGdldHMgdXJsLCBmaWxlbmFtZSwgc2hhMjU2
c3VtDQogIDIuIENvbnN0cnVjdHMgU1JDX1VSSTogImh0dHBzOi8vZG93bmxvYWRzLi4uL3g4Nl82
NC1idWlsZHRvb2xzLS4uLjUuMy4yLnNoO3NoYTI1NnN1bT1hMWIyYzMuLi4iDQogIDMuIGJiLmZl
dGNoLkZldGNoIGRvd25sb2FkcyB0byBETF9ESVIsIHZhbGlkYXRlcyBzaGEyNTYgKGhhcmQgZmFp
bCBpZiBtaXNtYXRjaCkNCiAgNC4gQ2FsbHM6IGluc3RhbGwtYnVpbGR0b29scyAtLXVybCBmaWxl
Oi8vPERMX0RJUj4gLS1maWxlbmFtZSA8bmFtZT4gLS1uby1jaGVjayAtZCAuL215LXNldHVwL2J1
aWxkdG9vbHMNCiAgNS4gaW5zdGFsbC1idWlsZHRvb2xzIHVzZXMgZmlsZSwgbWFrZXMgZXhlY3V0
YWJsZSwgcnVucyBpdCwgc2V0cyB1cCBlbnYNCg0KICBDb25maWcgZm9ybWF0Og0KDQogICJpbnN0
YWxsLWJ1aWxkdG9vbHMiOiB7DQogICAgICAidXJsIjogImh0dHBzOi8vZG93bmxvYWRzLnlvY3Rv
cHJvamVjdC5vcmcvcmVsZWFzZXMveW9jdG8veW9jdG8tNS4zLjIvYnVpbGR0b29scyIsDQogICAg
ICAiZmlsZW5hbWUiOiAieDg2XzY0LWJ1aWxkdG9vbHMtZXh0ZW5kZWQtbmF0aXZlc2RrLXN0YW5k
YWxvbmUtNS4zLjIuc2giLA0KICAgICAgInNoYTI1NnN1bSI6ICJhMWIyYzNkNC4uLiINCiAgfQ0K
DQogIElmIHNoYTI1NnN1bSBpcyBvbWl0dGVkIKFYIGJiLmZldGNoIGRvd25sb2FkcyB3aXRoIGEg
d2FybmluZyAodXNlcidzIGNob2ljZSkuDQogIElmIHNoYTI1NnN1bSBkb2Vzbid0IG1hdGNoIKFY
IGJiLmZldGNoIHJhaXNlcyBGZXRjaEVycm9yIGJlZm9yZSBpbnN0YWxsLWJ1aWxkdG9vbHMgaXMg
ZXZlciBjYWxsZWQuDQoNCiAgU3RhbmRhbG9uZSB1c2FnZSBvZiBpbnN0YWxsLWJ1aWxkdG9vbHMg
cmVtYWlucyB1bmNoYW5nZWQuDQoNCiAgRG9lcyB0aGlzIG1hdGNoIHdoYXQgeW91IGhhZCBpbiBt
aW5kPw0KDQoNClJlZ2FyZHMsDQpKYWlwYXVsIENoZWVybmFtDQoNCg0KRnJvbTogQWxleGFuZGVy
IEthbmF2aW4gPGFsZXgua2FuYXZpbkBnbWFpbC5jb20+DQpEYXRlOiBUdWVzZGF5LCAxNiBKdW5l
IDIwMjYgYXQgMTY6MjYNClRvOiBKYWlwYXVsIENoZWVybmFtIDxqYWlwYXVsLmNoZWVybmFtQGVz
dC50ZWNoPg0KQ2M6IFJpY2hhcmQgUHVyZGllIDxyaWNoYXJkLnB1cmRpZUBsaW51eGZvdW5kYXRp
b24ub3JnPjsgYml0YmFrZS1kZXZlbEBsaXN0cy5vcGVuZW1iZWRkZWQub3JnIDxiaXRiYWtlLWRl
dmVsQGxpc3RzLm9wZW5lbWJlZGRlZC5vcmc+DQpTdWJqZWN0OiBSZTogW2JpdGJha2UtZGV2ZWxd
IFtQQVRDSF0gYml0YmFrZS1zZXR1cDogcGFzcyBpbnN0YWxsLWJ1aWxkdG9vbHMgb3B0aW9ucyBm
cm9tIGNvbmZpZyBhbmQgQ0xJDQoNCk9uIFR1ZSwgMTYgSnVuIDIwMjYgYXQgMTY6MTgsIEphaXBh
dWwgQ2hlZXJuYW0gdmlhDQpsaXN0cy5vcGVuZW1iZWRkZWQub3JnDQo8amFpcGF1bC5jaGVlcm5h
bT1lc3QudGVjaEBsaXN0cy5vcGVuZW1iZWRkZWQub3JnPiB3cm90ZToNCj4gQWdyZWVkIG9uIHJl
bW92aW5nIC0tc2RrLW5hbWUgIGFuZCBJIGhhdmUgc2VudCBQYXRjaCB2MiBmb3IgcmV2aWV3IGlu
IG9lLWNvcmUuDQo+DQo+IEZvciAtLW5vLWNoZWNrIKFYIEknbSBmaW5lIHJlbW92aW5nIGl0IGFu
ZCBoYXZpbmcgdGhlIGluc3RhbGwtYnVpbGR0b29scyBhdXRvLWRldGVjdCwgYnV0IHdlIG5lZWQg
dG8gZGVjaWRlIG9uIHRoZSBmYWlsdXJlIG1vZGU6IGlmIHRoZSBjaGVja3N1bSBmaWxlIGNhbid0
IGJlIGZldGNoZWQNCj4gKDQwNCBvciBuZXR3b3JrIGVycm9yKSwgc2hvdWxkIHdlOg0KPg0KPiAo
YSkgd2FybiBhbmQgY29udGludWUgdGhlIGluc3RhbGwgd2l0aG91dCB2ZXJpZmljYXRpb24sIG9y
DQo+IChiKSBoYXJkIGZhaWwgYW5kIHJlZnVzZSB0byBpbnN0YWxsPw0KPg0KPiBJZiAoYSksIHdl
J3JlIGVmZmVjdGl2ZWx5IGF1dG8tLS1uby1jaGVjayBvbiBmYWlsdXJlLCB3aGljaCBtYXkgc2ls
ZW50bHkgc2tpcCB2YWxpZGF0aW9uIG9uIHRyYW5zaWVudCBuZXR3b3JrIGlzc3Vlcy4gSWYgKGIp
LCB1c2VycyB3aXRoIGN1c3RvbS9sb2NhbA0KPiBVUkxzIHRoYXQgZG9uJ3QgaG9zdCBjaGVja3N1
bSBmaWxlcyB3b3VsZCBoYXZlIG5vIHdheSB0byBpbnN0YWxsIHdpdGhvdXQgdXMgcmUtYWRkaW5n
IGFuIG92ZXJyaWRlIGZsYWcgb3IgaGF2aW5nIHRoZW0gdG8gYWRkIGNoZWNrc3VtIGZpbGUuDQo+
DQo+IEkgY2hlY2tlZCB0aGUgaGlzdG9yeSB3aHkgIi0tbm8tY2hlY2uhqCB3YXMgYWRkZWQgYW5k
IGl0IHdhcyBwYXJ0IG9mIGJmOTAyYTgxMGY5OGY1NWRkOWU4Y2I5ZTZjNmIwOTAzZjk5MDIxNTcN
Cj4NCj4gV2hhdCdzIHlvdXIgcHJlZmVyZW5jZT8NCg0KUGxlYXNlIG5vdGUgbXkgY29tbWVudCBp
biB0aGlzIHRocmVhZC4gSWYgd2UgdXNlIGJpdGJha2UgZmV0Y2hlciB3aXRoDQpjaGVja3N1bSBp
biBhIGJpdGJha2Utc2V0dXAgY29uZmlnIGZpbGUsIHRoZW4gdGhlIGNoZWNrc3VtIHdvdWxkIGJl
DQplbmZvcmNlZCBpbiBhIHdheSB0aGF0IGlzIHNlY3VyZSBhZ2FpbnN0IHRhbXBlcmluZyBvciBh
Y2NpZGVudGFsDQpyZXBsYWNlbWVudC4NCg0KQWxleA0K

--_000_GV1P189MB2954EA1ACC412797B25F889DF3E42GV1P189MB2954EURP_
Content-Type: text/html; charset="big5"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dbig5">
</head>
<body>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
Hi Alex and Richard,</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; I am in favour of this approach. Here's what I'm thinking for the im=
plementation:</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; 1. bitbake-setup downloads the buildtools installer using bb.fetch, =
with sha256sum specified in the bitbake-setup config (same mechanism as lay=
ers). This</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; gives us download caching in DL_DIR and checksum enforcement for fre=
e.</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; 2. bitbake-setup then calls install-buildtools --url file://&lt;DL_D=
IR&gt; --filename &lt;name&gt; --no-check =A1X the --no-check is safe becau=
se bb.fetch already</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; validated the sha256. (By writing sha256sum from config &nbsp;into D=
L_DIR , we can avoid --no-check as well but bit a hacky )</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;Two options for install-buildtools here:</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;(a) Update install-buildtools to handle file:// URLs na=
tively =A1X uses the file in-place, avoids a redundant copy of a potentiall=
y large (~500MB)</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; installer to a temp directory.</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;(b) Leave install-buildtools unchanged =A1X wget alread=
y supports file:// and will copy the file to temp. t requires zero changes =
to</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; install-buildtools, making this a bitbake-only patch.</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;I'm fine with either. What's your preference?</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; Pros:</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; - Buildtools installer is cached in DL_DIR alongside layers and sour=
ce tarballs =A1X survives upstream disappearing</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; - Checksum is in a trusted config file, not fetched from the same se=
rver as the installer =A1X protects against supply chain attacks</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; - Consistent with how everything else is fetched in bitbake-setup</d=
iv>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; - --no-check remains in install-buildtools but is justified =A1X the=
 caller (bitbake-setup) has already done validation via bb.fetch</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; Concerns:</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; - If sha256sum is omitted from config, bb.fetch still downloads but =
prints a warning about missing checksum (respects BB_STRICT_CHECKSUM&nbsp;i=
f set)</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; Flow when user runs bitbake-setup install-buildtools --setup-dir ./m=
y-setup:</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; 1. bitbake-setup reads config =A1=F7 gets url, filename, sha256sum</=
div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; 2. Constructs SRC_URI: &quot;https://downloads.../x86_64-buildtools-=
...5.3.2.sh;sha256sum=3Da1b2c3...&quot;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; 3. bb.fetch.Fetch downloads to DL_DIR, validates sha256 (hard fail i=
f mismatch)</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; 4. Calls: install-buildtools --url file://&lt;DL_DIR&gt; --filename =
&lt;name&gt; --no-check -d ./my-setup/buildtools</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; 5. install-buildtools uses file, makes executable, runs it, sets up =
env</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; Config format:</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &quot;install-buildtools&quot;: {</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &quot;url&quot;: &quot;https://downloads.yoctoproject.=
org/releases/yocto/yocto-5.3.2/buildtools&quot;,</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &quot;filename&quot;: &quot;x86_64-buildtools-extended=
-nativesdk-standalone-5.3.2.sh&quot;,</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;&nbsp; &nbsp; &quot;sha256sum&quot;: &quot;a1b2c3d4...&quot;</d=
iv>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; }</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; If sha256sum is omitted =A1X bb.fetch downloads with a warning (user=
's choice).</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; If sha256sum doesn't match =A1X bb.fetch raises FetchError before in=
stall-buildtools is ever called.</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; Standalone usage of install-buildtools remains unchanged.</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; Does this match what you had in mind?</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"ms-outlook-mobile-signature">
<div>Regards,</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
Jaipaul Cheernam</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
</div>
<div id=3D"mail-editor-reference-message-container">
<div class=3D"ms-outlook-mobile-reference-message skipProofing">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
</div>
<div style=3D"padding: 3pt 0in 0in; border-width: 1pt medium medium; border=
-style: solid none none; border-color: rgb(181, 196, 223) currentcolor curr=
entcolor;">
<div class=3D"ms-outlook-mobile-reference-message skipProofing" style=3D"te=
xt-align: left; font-family: Aptos; font-size: 12pt; color: black;">
<b>From: </b>Alexander Kanavin &lt;alex.kanavin@gmail.com&gt;<br>
<b>Date: </b>Tuesday, 16 June 2026 at 16:26<br>
<b>To: </b>Jaipaul Cheernam &lt;jaipaul.cheernam@est.tech&gt;<br>
<b>Cc: </b>Richard Purdie &lt;richard.purdie@linuxfoundation.org&gt;; bitba=
ke-devel@lists.openembedded.org &lt;bitbake-devel@lists.openembedded.org&gt=
;<br>
<b>Subject: </b>Re: [bitbake-devel] [PATCH] bitbake-setup: pass install-bui=
ldtools options from config and CLI<br>
<br>
</div>
</div>
<div class=3D"PlainText" style=3D"font-size: 11pt;">On Tue, 16 Jun 2026 at =
16:18, Jaipaul Cheernam via<br>
lists.openembedded.org<br>
&lt;jaipaul.cheernam=3Dest.tech@lists.openembedded.org&gt; wrote:<br>
&gt; Agreed on removing --sdk-name&nbsp; and I have sent Patch v2 for revie=
w in oe-core.<br>
&gt;<br>
&gt; For --no-check =A1X I'm fine removing it and having the install-buildt=
ools auto-detect, but we need to decide on the failure mode: if the checksu=
m file can't be fetched<br>
&gt; (404 or network error), should we:<br>
&gt;<br>
&gt; (a) warn and continue the install without verification, or<br>
&gt; (b) hard fail and refuse to install?<br>
&gt;<br>
&gt; If (a), we're effectively auto---no-check on failure, which may silent=
ly skip validation on transient network issues. If (b), users with custom/l=
ocal<br>
&gt; URLs that don't host checksum files would have no way to install witho=
ut us re-adding an override flag or having them to add checksum file.<br>
&gt;<br>
&gt; I checked the history why &quot;--no-check=A1=A8 was added and it was =
part of bf902a810f98f55dd9e8cb9e6c6b0903f9902157<br>
&gt;<br>
&gt; What's your preference?<br>
<br>
Please note my comment in this thread. If we use bitbake fetcher with<br>
checksum in a bitbake-setup config file, then the checksum would be<br>
enforced in a way that is secure against tampering or accidental<br>
replacement.<br>
<br>
Alex<br>
</div>
</div>
</body>
</html>

--_000_GV1P189MB2954EA1ACC412797B25F889DF3E42GV1P189MB2954EURP_--

