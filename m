Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F251AC3600C
	for <webhook@archiver.kernel.org>; Thu,  3 Apr 2025 19:05:14 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.88])
 by mx.groups.io with SMTP id smtpd.web10.3696.1743707107157351367
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 03 Apr 2025 12:05:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=rbrLbvQs;
 spf=pass (domain: axis.com, ip: 40.107.21.88, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mnc+KGB3egu60wLfQODTfNuwB3BZg6H49Ga4ZfDtxrHgnUggxD1wYQ74hvujH0cPUkYZ9k0cgeGqe3KYqpPDh5b31Jt7Kj6hUalX0am6HlOomG1lUQ8lYudC+Nu9CjMi+YP1qXINa/cvSxtX0NnxCduBX4Q5suHUxgTakK8tr1jc/Wx4gP0Qtj8obuCjbbqEFXxOZUUpYTPoD09bFTuQefLFnebpsz2qe6K6CqKwcXOoe1Cg5HGrLnYTre1OmgzvX9EpCMKuXWWEkKb5jYVAY2yYs8cbBNNRxzmq/iL7EM62FuSDQDm55H8c48V7KKvjYDCJJAxwoNyvr7RLynSlBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RpNRg/rshkRfaPr2Xtga957ENhH3lxwHsz+jF9hdRDE=;
 b=nQlZtl3ToA3gLlKFdMqer0TDQ5D7mjk05kMSTc/vn1vyXG5n9cXbXF7stOycAIoSZgAcrTIFpD4Z8mQobGWSocH4jiBbVwJTVwVr5zN/cQmh8sTMrDMxuFQlCDej6prpXG/r/91pA6TzFzMWKNLC0TGvDgD10SX+b6q739w0Mv/B0BiL0iRLJLWqVueYmoHLULcQWbf0hHf5V4Ocbx+3U0wjADNw2S8HJ/Cw/O8G9pbSfBT+Qrgr7zsXEyUHuVZuIN0KwScRW9NfxfcpmjHR2iv4qnBfAlR2/NRfMjlovBHZ9ia0xka5PyLnhUPnTtwMcFofk4q4OFHgNQTFJ2tp3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpNRg/rshkRfaPr2Xtga957ENhH3lxwHsz+jF9hdRDE=;
 b=rbrLbvQsCFGdF2ZhFHs/XfsZuq0zOcBOaXEJ576XWWNwXDOj1iisEdH46wU5gZ1YWy0x/0768eSjHG9cNjaekq2E3ub2toxLpWJizgevL7MKUqJW29i35EX/HR9GJJULba3KBNn526wBFdPQy47XJeJ1qAzECipvqwYn8QCJceo=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by AS8PR02MB6600.eurprd02.prod.outlook.com (2603:10a6:20b:23a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.41; Thu, 3 Apr
 2025 19:05:03 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9%5]) with mapi id 15.20.8534.052; Thu, 3 Apr 2025
 19:05:03 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH] fetch2/git: Handle srcrevs for annotated
 tags in tag check
Thread-Topic: [bitbake-devel] [PATCH] fetch2/git: Handle srcrevs for annotated
 tags in tag check
Thread-Index: AQHbo9e3FaMRgNuVfUa3T5y3bmCijrOQa1AAgAACnwCAAeDWgA==
Date: Thu, 3 Apr 2025 19:05:03 +0000
Message-ID: 
 <DB5PR02MB10213C4B58E8EB479B710786FEFAE2@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20250402140100.2407773-1-richard.purdie@linuxfoundation.org>
	 <DB5PR02MB102130FD9FE35B95EFA1805CFEFAF2@DB5PR02MB10213.eurprd02.prod.outlook.com>
 <e1c6f06bffa75b930e829677b13964edbdfb5f11.camel@linuxfoundation.org>
In-Reply-To: 
 <e1c6f06bffa75b930e829677b13964edbdfb5f11.camel@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|AS8PR02MB6600:EE_
x-ms-office365-filtering-correlation-id: 637fef46-1bb8-43be-cc6f-08dd72e27093
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?WGxET21jRjNWSUl5ZHZicnJYb1hqcUxjRUZieFVuVGsxeEtRbWlxQ2hGdU4x?=
 =?utf-8?B?cWZHc0VHcjdYd0g2R3FOSTNSSDVCT3IvMEdrcjg1dGVmVVgzT3NFRXA4U2VV?=
 =?utf-8?B?Uk0wZUF3Z2dRK01nYldrb0w2SHpiZElrYUVkclFwWXlKZklCeVArWkF5RXpm?=
 =?utf-8?B?dmF4dG04TmhOeU9zai9YbXB6Q2JYakNnL1ZSYmk2UTBzd016NnV5dlpHYXJo?=
 =?utf-8?B?R3h2ZS96NDBVVjVlbjE0cHg4VUZZU0VRRDA1TStxTWtVUmNSNlFkWTA3SFYr?=
 =?utf-8?B?SjNuQUE1Q0NNSXB2VlhEbVExWjJHZ1pKZkc0Z3FpMmZQU2dhYi84dVJHSGtQ?=
 =?utf-8?B?NFhTUnpkTnV6cFVrVmdVcXNrZkRsckJGU3FxR2xUSXZMV2JmVlJSWElJWVlu?=
 =?utf-8?B?OUc2VHhKbHU5QXNYcFdBYkJJR0doblhPTE0yOFAxV25pb0FULzVGUGRXc2Ja?=
 =?utf-8?B?b0ZmOENmUlBibXBFYktXUWpzYTlDM01XOUk3dzdMNk1GRGpuZTBpTGhoVWd5?=
 =?utf-8?B?Sm1LZVVQVlJkS09SZDcwYkJOeUQvYUVuZ1JWS2ZFNHpEWlJ3RlMvZVFJM1Qw?=
 =?utf-8?B?WXpMcHVzbXVSMEp3ejlJekFESm14N1g2V3lQcmwxZTB3YkNlajYyaUJ4TWpI?=
 =?utf-8?B?bzZmT2s4SlNwQmZ1czJDeTgxUHdnRkRBcUp2NkRiZHFVY29wSjRYZzMrTmN2?=
 =?utf-8?B?ekw3Q2hHbjJ5ekpydkthQTB5Y013K3pSTkI5OFVOdXpMblVsUitPeDVpQ3A5?=
 =?utf-8?B?ZWNZOW5FZmlaSytMNVBvenVlQ2NBa2VKdTcrL3BjWVg5TDlQeFdVREJONU9Z?=
 =?utf-8?B?Rnl5MU1kU2YxS2M2VThtSGhZdkk3VVVDaSs2aGUxYXRoWVFQejI0SjVQZk45?=
 =?utf-8?B?SnVkbStMZW5EbVdiWWFkN2lLNnlpNFlBeFpBaTdINnQ5MWxGbnJzM0RqcXAw?=
 =?utf-8?B?dlArTmwxaGxweDhBSEdETXBpZGx5UmJVUVNPNDVSVmEwaExwd0cyaVRNVVJu?=
 =?utf-8?B?T0ZOYi9YYTk4ekpob25HVmc5a2xWWk1ndGJjeXpBM0VLVkFFdDJaN21iMWYw?=
 =?utf-8?B?TFlWdk9DNllyOVlCcS9kZm9mRmdvQzdBZFdNVzR0MU85WHpmY0lKNWRBWUlS?=
 =?utf-8?B?QTh2VE1MNkp2THJpUVdGRXovYlVPbDd5Z1kxV3NvczUyeVRLTHM2U2RCNGhw?=
 =?utf-8?B?a2VDd1hhd1pTbVRZRVNscFRsMTVQNXpkcndkTFB3SGxjQkRQZE51OWYxdEc1?=
 =?utf-8?B?VlVsSnI1cFpWWFVhQlpCMFo2NEpDN1dSVjJPRHpncUNDQWoyUlJWMDkrVTkx?=
 =?utf-8?B?ZEVaY0FJOHZpbVpoeGsxdVdTVnYwc0czdDNNVXlmK2toNllUaGZDWVJOOS9X?=
 =?utf-8?B?VjBQVktNcDA4SzFQS3FDL2VtYUkvYzd6TVBMdys0Z2dVV1RrTXF0cnpuektk?=
 =?utf-8?B?azZjSWhBZExoRStnWnRVWldjelJWK055N3B4TVVIMTRxRThpNkEyT2NXK0xQ?=
 =?utf-8?B?YkxydlYzblMrZms2NklBTXZqcnFhYThjTlZaaFZtOGI0QjhzMCtuNnpwdXdn?=
 =?utf-8?B?eGgrMG5FYnByWlZiWis4cHVwY09tMTFUMThkdm40WXNOL0ZkQU10RVhYem1I?=
 =?utf-8?B?YXoxZ0J1R1p0alVyd0J0TnE5dVRaV1dleHc1QzVKKzNTTU5oRndzOXJDTGdy?=
 =?utf-8?B?UlFWUXl2dFkvYWdtL1BIT3Y0SnQvRGFBNVMzUWFJTklRSmZpQWJKYmZ6QUs2?=
 =?utf-8?B?Z1p1cTRZN01xNEV6ek5EYzY1WnlFaW1HdWx3a1NQd0dxeVMxSkhkTUQ1WU00?=
 =?utf-8?B?eXZxY3YyeHRHTDd6SnFUU3pTYnJuVnNqRHZlQXFPb2MzSjZWY1ZsK1Q5VDEv?=
 =?utf-8?B?dkZBVVYyeHk0WXpnSWVGendwY3FmclQvZklCMm1aMndFZGQ5YWdRWHNSZzN3?=
 =?utf-8?Q?bRkxG40uHzq37OPEd3pcEZT3mUZL+Meo?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?T2FzcmthQ2hCd0trUjlYa2RTYmcvNllTeUR5RVNWMGE2aXNRRWxWaUdpMVEr?=
 =?utf-8?B?bHlsQU9HYkpXQkJJSVlVaTQ3Z2hYdFZWM2UzM2M3QTZpU2k3TEd6TTJUMlpk?=
 =?utf-8?B?R01rS2dsTHpBUXBTSUY1KzBiV2x0WHN2bmhISWg0TVVtbi8xQ3ZBY0Y3RWhQ?=
 =?utf-8?B?d0tQWDhMNDJ1UFlaTXdKRW94cWxEYm9SYTMyWm51V2lmeCtGWEUzS3EzNU56?=
 =?utf-8?B?N0RwM2NlZHNVSVVGdTlGZHNpOEdTK0xoWUdHbmFVU25tNEx2bk4vVktYNzdi?=
 =?utf-8?B?OFluMXF5aGxSNC9tMkJkRDFJMWxuTG5lVlA0ZXNiZmRQQ2NZaTg5TUNGelpR?=
 =?utf-8?B?bG4zY0JMaVJwUytmWVV4QmZZdWNOZFczL0NVUytacThKWXNZZmx0U2VZWUpY?=
 =?utf-8?B?RXJ2bmJDenlpZW5SZEZqMm03UjRreXY3bEVzTjR3NktMcjk4bHYzQnRzS1VE?=
 =?utf-8?B?WEJMV2tTNWVMNFFWcHMyeDNQNzhyTlBIdEJGYzAyRGloVUEvb3hWQXJxaXBo?=
 =?utf-8?B?cjNGWEdUWUc2N0hPdWVScE5FcnRvSTJIblNjd3Z1NGtkRXFpLzM4YU5LdWNY?=
 =?utf-8?B?eDY1Y0JDME83M2R1bkI2djdUTXR0ZExyRlM0MU1abkJmRE1SSlVtbEVzQ2VX?=
 =?utf-8?B?S2xoTzdySjNzVmRCTjFKZ1hMTldYdWRuUDBycEtGQXhRZGVSRjd0T1IzZHFF?=
 =?utf-8?B?cWdFdzJ3Tk9vbUhRdFJvWXdhWGNPVGcvaXR1OWRKdGg5NzZQUmR5ZG8wdXpo?=
 =?utf-8?B?cEQvTlJMRU5rcURaeHhhblBweEs5ODRyeWRmb3lXQnZwZU5YWlozTTREQnFk?=
 =?utf-8?B?TVNjUzRVK0pRbW15Y3dpZGFlWWt1bGZRZURPVDcxRk81elVSYVZkb2l5bHVE?=
 =?utf-8?B?dGFqWTMwMjB4cEVtSHJPRHZBcHI5SjZUZVlFTUxzQmM3R0pVMjJITUxqcFVa?=
 =?utf-8?B?V1Q4TDgvMTI3S1I5OHduVlFqTnk0SVZMcysrSTJIcG5EU1lmaGNOOExkejdD?=
 =?utf-8?B?Ty8yeldYVnJGV3lLaEhsTUpYNHYyK0pWNmtidVlWNUp2b05zR0hOd1FSK01T?=
 =?utf-8?B?ZWlNTWlUcmJnSjFwWnBHbjkySXZvNURHbjFHUE9kaDl2bTM2VTNqUkMzaUNn?=
 =?utf-8?B?aXNNNkZpb2N6UEFLbHZTMVJpbExjQ0JGc3pndDBuRExSTVBrb0N4ck9zUmZL?=
 =?utf-8?B?VWkxVjFhVEdycWhMdWNRZkVQYnl3Vis1R25Xa1ZpdFdxZzdRTHdpdG5QTWw0?=
 =?utf-8?B?Rnd6UUdBSzdWSmM3MlVFTzcrVk5vQUdick43NllKVXNPUkhobWdqK0RsM0Vn?=
 =?utf-8?B?clJZRm91ZWdBOWg0Qy80MXdHVkJ1ZjFJVkxsLzNuZFJJcXVmK2J0QXlYY1Ir?=
 =?utf-8?B?SUlicHBpQXlUL3FCeU1xZ1VNYnpndk9pdXBkVnlWWXVWcUoydTQ1dVlpQ3E3?=
 =?utf-8?B?cStaNjJVRFJHT1hqSTdlSlhVSG1lUlZCZWNGZG1TdkZXOUgwUUNGMmtEdmJq?=
 =?utf-8?B?aG52SlNzRVVnNVpRbzhwRldkMlk1cHZISFUyMkY1ekFWVUJ0NEtMZkFQaHdJ?=
 =?utf-8?B?LzJFdnNTZWJodnRNQU1BcnZpcm9nN044TVIzZnBSYTNqNjc3V0N6N0p4ZTcz?=
 =?utf-8?B?VlpILzFpWEx6anNYMjZBbHJyc0tJQlpXUzBiRlhnQjRkS3JVQno1UHM4Y1Rj?=
 =?utf-8?B?SjZNZFYwK091QmpVQTRHOE95bDZGdmlrb1RaMFp6enhCa1JxKzNMdmRGeUZO?=
 =?utf-8?B?eWNncEVTVkticnRFcWJqY0ZxaXhvMzFmMUQxRFJ0S1dvZlJmZlRqWndVckFi?=
 =?utf-8?B?bzUyNmY5eGpsSnZ3WkplRFRBZFdNN2VKZnlqVmJ5SldJQlpmZ25MbndQK2NL?=
 =?utf-8?B?VDZMMFcvN1lTQ3RhTk9LQThNOHh2TzdxaG1iaGQxUEd3a0FGQWRLWlVyNitF?=
 =?utf-8?B?d082WmR6MU5ob2JjM3BKUXFyM2lYUFBsTjVkV280THFJdGI1U1R4WS9hekY3?=
 =?utf-8?B?ZEpBZDZsbHVoYU5mYmppZjVGQXlBRk5SRFdqUVU1QVV2b2lzbDRwdUl3WHBl?=
 =?utf-8?B?TVBwQ0JBS2RXUGo3RS9lRjJROERJU3BYa2ZqWUtlOUFBRUR1ZnFhVzljbEZS?=
 =?utf-8?Q?60HI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 637fef46-1bb8-43be-cc6f-08dd72e27093
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2025 19:05:03.3276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6C2wA8e2lJmyjOqUKjITwW0/lqt83Cou3Op12kui2URxuxcDT1fi5Zr1jj0cxIMV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB6600
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 03 Apr 2025 19:05:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17513

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSaWNoYXJkIFB1cmRpZSA8cmlj
aGFyZC5wdXJkaWVAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gU2VudDogZGVuIDIgYXByaWwgMjAy
NSAxNjoyNA0KPiBUbzogUGV0ZXIgS2plbGxlcnN0ZWR0IDxwZXRlci5ramVsbGVyc3RlZHRAYXhp
cy5jb20+OyBiaXRiYWtlLQ0KPiBkZXZlbEBsaXN0cy5vcGVuZW1iZWRkZWQub3JnDQo+IFN1Ympl
Y3Q6IFJlOiBbYml0YmFrZS1kZXZlbF0gW1BBVENIXSBmZXRjaDIvZ2l0OiBIYW5kbGUgc3JjcmV2
cyBmb3INCj4gYW5ub3RhdGVkIHRhZ3MgaW4gdGFnIGNoZWNrDQo+IA0KPiBPbiBXZWQsIDIwMjUt
MDQtMDIgYXQgMTQ6MTggKzAwMDAsIFBldGVyIEtqZWxsZXJzdGVkdCB3cm90ZToNCj4gPiA+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBiaXRiYWtlLWRldmVsQGxpc3Rz
Lm9wZW5lbWJlZGRlZC5vcmfCoDxiaXRiYWtlLQ0KPiBkZXZlbEBsaXN0cy5vcGVuZW1iZWRkZWQu
b3JnPiBPbiBCZWhhbGYgT2YgUmljaGFyZCBQdXJkaWUgdmlhDQo+IGxpc3RzLm9wZW5lbWJlZGRl
ZC5vcmcNCj4gPiA+IFNlbnQ6IGRlbiAyIGFwcmlsIDIwMjUgMTY6MDENCj4gPiA+IFRvOiBiaXRi
YWtlLWRldmVsQGxpc3RzLm9wZW5lbWJlZGRlZC5vcmcNCj4gPiA+IFN1YmplY3Q6IFtiaXRiYWtl
LWRldmVsXSBbUEFUQ0hdIGZldGNoMi9naXQ6IEhhbmRsZSBzcmNyZXZzIGZvcg0KPiBhbm5vdGF0
ZWQgdGFncyBpbiB0YWcgY2hlY2sNCj4gPiA+DQo+ID4gPiBJZiBTUkNSRVYgcG9pbnRzIGF0IGFu
IGFubm90YXRlZCB0YWcsIHRoZSBjb21wYXJpc2lvbiBjb2RlIGNhbiBmYWlsDQo+ID4gPiBhcyB0
aGUgcmVzb2x2ZWQgdGFnIG1pZ2h0IG5vdCBiZSB0aGUgc2FtZSBzaGEuDQo+ID4gPg0KPiA+ID4g
SGFuZGxlIHRoaXMgYnkgYWxzbyByZXNvbHZpbmcgdGhlIFNSQ1JFVi4gV2Ugb25seSBuZWVkIHRv
IGRvIHRoaXMgaWYNCj4gPiA+IHRoZXkgZG9uJ3QgbWF0Y2ggaW4gdGhlIGZpcnN0IHBsYWNlIGZv
ciBhIG1pbm9yIHBlcmZvcm1hbmNlIHdpbi4NCj4gPiA+DQo+ID4gPiBBbHNvIGFkZCBhIHRlc3Qg
Zm9yIHRoaXMuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBQdXJkaWUgPHJp
Y2hhcmQucHVyZGllQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+ID4gPiAtLS0NCj4gPiA+IMKgbGli
L2JiL2ZldGNoMi9naXQucHnCoCB8IDcgKysrKysrLQ0KPiA+ID4gwqBsaWIvYmIvdGVzdHMvZmV0
Y2gucHkgfCA3ICsrKysrKysNCj4gPiA+IMKgMiBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2xpYi9iYi9mZXRj
aDIvZ2l0LnB5IGIvbGliL2JiL2ZldGNoMi9naXQucHkNCj4gPiA+IGluZGV4IDNhNGFlNmRmNDUu
LjVmNGVjNjEyOGMgMTAwNjQ0DQo+ID4gPiAtLS0gYS9saWIvYmIvZmV0Y2gyL2dpdC5weQ0KPiA+
ID4gKysrIGIvbGliL2JiL2ZldGNoMi9naXQucHkNCj4gPiA+IEBAIC03MzAsNyArNzMwLDEyIEBA
IGNsYXNzIEdpdChGZXRjaE1ldGhvZCk6DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
b3V0cHV0ID0gcnVuZmV0Y2hjbWQoIiVzIHJldi1saXN0IC1uIDEgJXMiICUgKHVkLmJhc2VjbWQs
IHVkLnBhcm1bJ3RhZyddKSwgZCwgd29ya2Rpcj1kZXN0ZGlyKQ0KPiA+DQo+ID4gSSByZWNvbW1l
bmQgdXNpbmcgR2l0J3Mgc3ludGF4IGZvciBnZXR0aW5nIHRoZSBTSEEtMSBmb3IgdGhlIGNvbW1p
dA0KPiA+IGRpcmVjdGx5IGZyb20gdGhlIHRhZyBpbnN0ZWFkLCAidGFnXnt9Ii4gVGhhdCBzaG91
bGQgd29yayBpbiBib3RoIGNhc2VzOg0KPiA+DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBv
dXRwdXQgPSBydW5mZXRjaGNtZCgiJXMgcmV2LWxpc3QgLW4gMSAlc157fSIgJSAodWQuYmFzZWNt
ZCwgdWQucGFybVsndGFnJ10pLCBkLCB3b3JrZGlyPWRlc3RkaXIpDQo+IA0KPiBXZSBjYW4ndCBr
bm93IGlmIHRoZSBzcmNyZXYgdXNlZCBpbiB0aGUgcmVjaXBlIGlzIHRoZSBhbm5vdGF0ZWQgdGFn
IG9yDQo+IHRoZSBjb21taXQgc2hhIHNvIHlvdSBoYXZlIHRvIHBvdGVudGlhbGx5IHJlc29sdmUg
Ym90aCBhbmQgSSdtIG5vdCBzdXJlDQo+IGhvdyB0aGlzIGhlbHBzPw0KPiANCj4gQ2hlZXJzLA0K
PiANCj4gUmljaGFyZA0KDQpTb3JyeSwgbXkgYmFkLiBJIG1pc2ludGVycHJldGVkIHdoYXQgdGhl
IGNvZGUgd2FzIGRvaW5nLg0KDQovL1BldGVyDQoNCg==

