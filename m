Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48306CCFA13
	for <webhook@archiver.kernel.org>; Fri,  7 Nov 2025 01:00:06 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1406.1762477196751700437
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Nov 2025 16:59:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=eDwFd7Vc;
 spf=pass (domain: axis.com, ip: 52.101.69.50, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1WhWYQaQ+ajR5T6HCA2vUCTnZNu/2o9RZMT/mpqFPR3QJQInumrUWfKAfzbi9APZSLZcJqUBiv/n7rHTOAK3/vUL9yXkw/FZqMIoXXfDgkzmMgahol8+FT2rCcpAfHruyQu+mvzVz4G97eiZ4BcdogjNVS3npS5/+3mTctiA6HcDlANWIqcDag0yRkTwyEViG1AqlAW4Ib1kdnWCziFKLS0XBqGOid1llOs1uxNzgS+Q7T5Sx/Xn/hP5gxdLR2hE9mmpIBO30vzbHNSteJcszX3P5eDdiWvRTpWM1rrLOFk6X0w3N6jLHCmhmeKYzCcDe3tswUo2aVuHz9KE5tVZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQrtOYzTf0kA64c59TzjvLpaVCA9WmebMKFmHrS7cIw=;
 b=C2YLOTXqoYyy02gFIPv5JXUUl3iEXPV0a76LngQ9FLtVqUdb3ujNLmbjxMBY8iMLur7jD6RLNpeRy6BrD6Fn/GRI+XgRNQJ5JHliTLwqvwTwKMpTT6AWnsQsoTJXtsiD3HJlIgYAeIfxDO7aQKgX8OsT8mi3OkZucnYVX+qDEt/QRHF/pzMt1jwtmA+lhWLapFThYTwEkkJE2HEk315ofFrsn8BhxCoL32S9Urt1evV6mcrmEp1MMoi+gdK9ALQK1yZabktmesc2IM9+kF73dbOgdlDAfkBq7Ip+HG1dWW97xfQmLAQ3wjAm5AXq2BGSrHvuwc01rFPT3fi9vDyHOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQrtOYzTf0kA64c59TzjvLpaVCA9WmebMKFmHrS7cIw=;
 b=eDwFd7Vc9dtq1R0Ksu/+odkz+BnOCw0Z5MHsyi9+9BLAUZJurfxjTzk5WTWYXmHMDNLATvyuUhVjrwn9Dr/E9476+ryKlw67gM1vbzVWf/pfKT6qFdaVsmFNP3D80/EHu3YLYxY/KuCGw/r91ifZHbCAlA9Z3plh5/kpEWNvZsQ=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by AS4PR02MB8309.eurprd02.prod.outlook.com (2603:10a6:20b:510::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 00:59:52 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9%7]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 00:59:52 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
	"alex.kanavin@gmail.com" <alex.kanavin@gmail.com>, Antonin Godard
	<antonin.godard@bootlin.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, Alexander Kanavin
	<alex@linutronix.de>
Subject: RE: [bitbake-devel] [PATCH] bitbake-setup: replace {THISDIR} token
 with an explicit keyword
Thread-Topic: [bitbake-devel] [PATCH] bitbake-setup: replace {THISDIR} token
 with an explicit keyword
Thread-Index: AQHcTxMhkGrMeM10ykuxQelgjRHL0rTljq6AgAAE6gCAAC6ogIAAoNWg
Date: Fri, 7 Nov 2025 00:59:52 +0000
Message-ID: 
 <DB5PR02MB10213C5C0AD578C01BF7DB065EFC3A@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20251106114714.918370-1-alex.kanavin@gmail.com>
	 <DE1LO4GV39WM.156UBA1PODPOV@bootlin.com>
	 <CANNYZj-pgb6SMxhzB4g-siGY7oWaNjb=jOSk3m-TRKLwHPytFQ@mail.gmail.com>
 <278bb2544a713588af57889f35197e0c6f424c8b.camel@linuxfoundation.org>
In-Reply-To: 
 <278bb2544a713588af57889f35197e0c6f424c8b.camel@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|AS4PR02MB8309:EE_
x-ms-office365-filtering-correlation-id: 8a168eb3-e6d4-4620-30d4-08de1d98f5b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?dWxxeHpLVDZGRXhRUVJmMUp6Rk1tUzV6TlZpYlIrT0RrUHh4Q0FpY2srM3Yz?=
 =?utf-8?B?akMxY0ZjVWdCcXdDMlZ5TmpaQjM0dmE5WUE1am1LN0x2Y05KTWMzL1E4dUJH?=
 =?utf-8?B?ZHRZaE1NYXZ4ck4rNjlRSmlyUzNLaklhYTVlcXBYOXF3bFR6QVBqK1FjUFkw?=
 =?utf-8?B?eDJGRUd3VVE5SmFGa2RTa2tKa3Zac0FkVlpzVWNpdHZpL0JDSmMzU2hlbEpy?=
 =?utf-8?B?MElJWXFzMUpUT1FDbVdXS0ZqN1ZLVEFrNnZQck9YelJUSHZ3VWRxemd4N29V?=
 =?utf-8?B?SHBOdnFJaE1ZRGh1SkVSVnc4SUZzMlZFRzh1ZTNza2ZlWE5TQmhuT2ZPVjNr?=
 =?utf-8?B?Yi8wQXpYK3l3WU0rckRjS1ZJL3lteDE5SGZNU1Z5WmZKRithcGdnSWVyU2pD?=
 =?utf-8?B?TnRiZFZYdldhY3N1MmZtZlV1YUEyRE9lOWtYNlhDNlVEZ1F1Z0tmUFJSeTlx?=
 =?utf-8?B?K2YrVjVtN2R3YXhGL3VQUFJjRU5uYjIwQ1FEdDhPZTdsK0ZXaUJ0QjdPc2lW?=
 =?utf-8?B?aDNkNTZkdjBNOWxGdndhZitqR3lDY2VSejVpdlREbmk1bFA3dE1JdEVuc1Br?=
 =?utf-8?B?WGFkTGlOeURTTkxiLzkyN1lHK3pRbmptRmpWRXliVXFvVnMwcTE5aEd4R2NL?=
 =?utf-8?B?aFpDYnpiYlNjc2dVRlZiWjlEVlZNUzQyOUJROWFBdjBONlJBSkN4ejY2R2hG?=
 =?utf-8?B?bndaWUg0bVZ6RWN2TDlyZjRPdVZCV3VOa1ZUdW82SU9LQjZIUTBGNG0ydFlt?=
 =?utf-8?B?NFZ1RmMwanN6d3dzOHZmRzBVMHA0QnJaeW02R2tWSndMeUorK3A0bFRaNm1o?=
 =?utf-8?B?V3RLN3hDQ3BSSUYyZ1NJRWhyQWlRWDBLVGVkWUJ6Y01TNld4RW00TzhQZ2sv?=
 =?utf-8?B?WnMyc1AvVDVma1RoeGdTZmtrbWFkamFERzVsZjJ3MWhUOVZmTEtxWGhPTW9Q?=
 =?utf-8?B?MmVERk5CcUNPOG0rRXBhVXRFY29WMWJmQ2R1NEdtWUdySnJYZytTem0yMEFM?=
 =?utf-8?B?eVJDanUwZnNPYjEyd3FzQTdEeVNUSmxKdkJoTWU1c0xoL0JDVnFJUGU0cVBT?=
 =?utf-8?B?MkRWWHNXc3hnMkZYa0praTc5NWlNc0M3cXNMN1k2TmYrM2kxcDlCNEVrWjVi?=
 =?utf-8?B?Y3JHaWZXSytsb1FJWEIrYk4rb3pzaWVDVDVZNVpBM09JRGV1M3hGNzBSV3lT?=
 =?utf-8?B?bmk5RlZrbEcvd0I3THZGRHEzMlptQUgwWkNZR1pyY3JiK3hyTElpT3FWR0lW?=
 =?utf-8?B?RSt0NDJ0eU9NZHhGRy9pR3RieDFuQnJKcjIzZk1pM1N1eCs3N2FWb0dFK2dV?=
 =?utf-8?B?TmtLbWExMzViK2QwYXlXS0t0STZ2aEc4TmhWTXVKWGdjZitPZnJpblJ1TlVZ?=
 =?utf-8?B?SFJpTWpJNmxBeHdLTFRWQWI5OHA4Y1hRdkMzQ1ErUlg1K3FUZytUVFZmSmhY?=
 =?utf-8?B?OTZkYXZiTDFQSmJDbmMxNWdWb1lqV2ViS1ZrZElBYS9CdUxhMGw4eTRDSFdX?=
 =?utf-8?B?RXRtVzlTSG1Bc21vU2syT3JLV2RSbVNLMDlaSFc4dmozRHpNMU1SNWRFbEVH?=
 =?utf-8?B?NUpZQUgzR3lpVm4rN1E2bWdnY0ZRVVhCdVJraU83TXlNQXpkL3pIL0NGQTEr?=
 =?utf-8?B?QytXN1pYUTBYeW1MdTgyNjF3NXRDREF6WnI5Uzh0VWdKZVpHb0IzNnFaRXkv?=
 =?utf-8?B?cm91bWdMUDVpalRNbXVwUlR6STNmRERodEpORS9LWUdjSkM4MndEckxxaFdV?=
 =?utf-8?B?NmphbTZPNGZjTkR0VVpFWVJyY1ltekRxeUxJVG03MzBYMFNiNkRsQ0lRNERO?=
 =?utf-8?B?SUo0RmtPR05TK2VxcEZTelY4ZTlMbG9pVWlDWmdSUzc3VzhuMU90a0VPL1ZB?=
 =?utf-8?B?TFRMVG5mdC9BeGV4bWwxR2F0MFFOM2w2c0JVV1ViTmVYY1Bub2pEZGJ5bTNQ?=
 =?utf-8?B?eFhPVVNxRmIzT1VpbElnMkYzVk04T0o2Q0o0OTIyR1VMQVF5akw1bmphYnNn?=
 =?utf-8?B?T2hqeVB6WndRPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Z2RUZjVncXkyMTZXYWEzS2Y3ajMxYWkrZmJVdFo0U2lSOUo4b25xS0JOMk9n?=
 =?utf-8?B?aVhzWWRyZHhnY0hxU2VxaytLeThoZkZBQ3RZM0hJbzlPNGh2THkwWHVrS0g0?=
 =?utf-8?B?YXF5a01QQjZIYlJYbk1DNVpGcmNOU3hQeUg1enllMkRxaU9OdTdoeXExekpj?=
 =?utf-8?B?MmFEdEdIYThISC9YbVNBaldDSmpYMWZDSXgrWmdyN0c5MDBLZHhYZlJscXdq?=
 =?utf-8?B?dFg2aVkrL1lIWWdDczJ5S1hPUWJ5YktwdVhWVHFJamxGbXpMdjdkVnFnV1pJ?=
 =?utf-8?B?NlZnMXJuNi9mSzJYdUpGS2NYWFlENUxiNVFmRFRIVEdMN3hxUTNFWmVUNXBt?=
 =?utf-8?B?Vy9QQmprNytkTm1COVFORkZmOG9KdFlRVzduYm9WNWZ2WGI0VzBmb1V3VklR?=
 =?utf-8?B?aTZzSytnaXRzWnZkcFFreE5ES05PV2srLzFreEZFSGgvYnZKWitncHhKV1NC?=
 =?utf-8?B?VXdOZVkwQVoyQjNoZXpHYUtRSXpMVXVPblhFcDRuaU9WcmtHSzh6MUw5Znhu?=
 =?utf-8?B?UVI4ZkFtc2ppb0FpSytBY3dPU3ZvclhpUEMrUUNNT0JoVXFIYndoMk5zTUpB?=
 =?utf-8?B?QlBmcW5wQ2I5VFFJT3lDcCs1eldVQ05aOUZ3VzBUVyttTS9Pa00wV1ViK1NL?=
 =?utf-8?B?WW9VYU1adms0a0c5TUJsdEMxeXpQYlQyOGh2RldNTWJwMllSYU85Ymd6Rm0v?=
 =?utf-8?B?aVRNV296SldyWVZrRUIwaHI5c0xuVlB4S1lXNjVBSVg4a1BxRzR6TFRjbE56?=
 =?utf-8?B?bmRuQ21ISE5iZ3lSTk9XM0NGU3JiNWxaTFE3L0xTNElNVXdKY0lFdExZdE1n?=
 =?utf-8?B?dnRqK1JNTStNV0t2RjVlQ2VDRUVEbXNKZ3Q2ejFzQlAxenBDMFNNTnNic25N?=
 =?utf-8?B?VnJsNFpMTGEzY1RWbTBuTjl2TzYrZktCakE1QktIeWdOcWUwTkJ6WDFZM1hp?=
 =?utf-8?B?K3dNQThqa0hZTlRDZU9rVi9xRC84UXV5dG1GbmFEZFhDUVF6a3Q0RjJXYm9n?=
 =?utf-8?B?enYzZUVuYWhacFIvNE1oNG1OUXUwTkZySEp6Zk1YTitGYnpxQW5zSE10US8y?=
 =?utf-8?B?bzFBcnRvOXBtWENrZ2xTVm1TZStGNVlJbEFIMDR6SENkNFBzSk5SOEdQa2xX?=
 =?utf-8?B?TFhjbk93YTAxTFQ1OUg0YXk2M09VeUxhZTEyWTlrcXpUTGJFZDZWWTVHRWJp?=
 =?utf-8?B?dmJHRm1lQmVlTWlaL2JWTTdWUHlyQVJ4RUlQVExpSGE3VkwyTVJFQmZPWjM4?=
 =?utf-8?B?WVNSV0xpaEVVMjFiODdBNmVBUE42SzVrakhvb1E2L0tyY2xGZDBQMS9MNWgr?=
 =?utf-8?B?UEVKU1h3cXdSdk9xQ0ttWG56QitYR3FqNE5ObS81Y1hMbnZxUWpJdUZPUFYw?=
 =?utf-8?B?ZHA5WFRvQ2lQVVRPVFBPaFdFNGViNHJWdFVOUFFKWG5hdnRXdXc5Q0xla0ti?=
 =?utf-8?B?azBYN2diU1RQZHE5OVBtMFlocUFmZ3hDV0NWUU1GMVR0MUVBUkxDUEFBNjA5?=
 =?utf-8?B?eThpaVRodmZJRzBrV0lBSTdPaXpGRkJGUjU5dTlueklyc3p6dm1IalMvc2Nk?=
 =?utf-8?B?SEtTZkxOWDlTTnVQeFFEY29DeTR4eGpaUUxoOXNocmJFb09FWWd1RDE1SHd6?=
 =?utf-8?B?N2tjc1FXRkFGOVgvRW03enBmbUNVcG9FSDArQXQ1dUxGeVh5R2lxUGZLcFpU?=
 =?utf-8?B?MVprK1RTelMyaC9LQ0RqaytyN1NjTEptVzlqeXFzbU5JRFFqejFjRFhmcGNF?=
 =?utf-8?B?am1xR3V0THZiSzRuQnVtMkNibEtURVY2dUthSEVHV3MyR1Bzb1lpWklxVk1x?=
 =?utf-8?B?Sks5R0FFZjVxbnVsMlk3dVZPWnFQTG9Hai82T09XWWtJY2ZrTUtKN2JDMmY2?=
 =?utf-8?B?NnNSSHl6UW53MEFDbEp2RWFNQnQzZStMb3BFQzJSbllGbk1yMVZpWVAyTTU1?=
 =?utf-8?B?ZmZUY240ODZJbk01TjJDd2xNaTFSSll3bVBpUTNuTGhSRHhuWmMvMWVrLzlN?=
 =?utf-8?B?Yjd2QWk2NjRKNlJCT0VQK1F5Tk90Tzc2Y002NUk3TVBDM09CeGQ2K1VXQzJG?=
 =?utf-8?B?SWNhWXMrdWYzZ1YvSXBabVhCWEttNS92RXVrQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a168eb3-e6d4-4620-30d4-08de1d98f5b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2025 00:59:52.7446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WJ6AqwZMKwYCV3rl59/s5X916HHY6u+yR9t4eI8koRoVDeZDS+mKc1B7L+rC0UUn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR02MB8309
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Nov 2025 01:00:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18295

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBiaXRiYWtlLWRldmVsQGxpc3Rz
Lm9wZW5lbWJlZGRlZC5vcmcgPGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZz4g
T24gQmVoYWxmIE9mIFJpY2hhcmQgUHVyZGllIHZpYSBsaXN0cy5vcGVuZW1iZWRkZWQub3JnDQo+
IFNlbnQ6IGRlbiA2IG5vdmVtYmVyIDIwMjUgMTY6MTYNCj4gVG86IGFsZXgua2FuYXZpbkBnbWFp
bC5jb207IEFudG9uaW4gR29kYXJkIDxhbnRvbmluLmdvZGFyZEBib290bGluLmNvbT4NCj4gQ2M6
IGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZzsgQWxleGFuZGVyIEthbmF2aW4g
PGFsZXhAbGludXRyb25peC5kZT4NCj4gU3ViamVjdDogUmU6IFtiaXRiYWtlLWRldmVsXSBbUEFU
Q0hdIGJpdGJha2Utc2V0dXA6IHJlcGxhY2Uge1RISVNESVJ9IHRva2VuIHdpdGggYW4gZXhwbGlj
aXQga2V5d29yZA0KPiANCj4gT24gVGh1LCAyMDI1LTExLTA2IGF0IDEzOjI4ICswMTAwLCBBbGV4
YW5kZXIgS2FuYXZpbiB2aWEgbGlzdHMub3BlbmVtYmVkZGVkLm9yZyB3cm90ZToNCj4gPiBPbiBU
aHUgNi4gTm92IDIwMjUgYXQgMTMuMTEsIEFudG9uaW4gR29kYXJkIDxhbnRvbmluLmdvZGFyZEBi
b290bGluLmNvbT4gd3JvdGU6DQo+ID4gPiBIaSwNCj4gPiA+DQo+ID4gPiBPbiBUaHUgTm92IDYs
IDIwMjUgYXQgMTI6NDcgUE0gQ0VULCBBbGV4YW5kZXIgS2FuYXZpbiB2aWEgbGlzdHMub3BlbmVt
YmVkZGVkLm9yZyB3cm90ZToNCj4gPiA+ID4gRnJvbTogQWxleGFuZGVyIEthbmF2aW4gPGFsZXhA
bGludXRyb25peC5kZT4NCj4gPiA+ID4NCj4gPiA+ID4ge1RISVNESVJ9IGlzIGEgc3BlY2lhbCB2
YWx1ZSB0b2tlbiB0aGF0IGNhbiBiZSB1c2VkIGluIHRoZSBsaXN0IG9mIGVuYWJsZWQNCj4gPiA+
ID4gbGF5ZXJzIHRvIHNwZWNpZnkgdGhlIGxheWVyIGxvY2F0aW9uIHJlbGF0aXZlIHRvIHRoZSBj
b25mZ3VyYXRpb24gZmlsZToNCj4gPiA+ID4gaHR0cHM6Ly9naXQub3BlbmVtYmVkZGVkLm9yZy9i
aXRiYWtlL2NvbW1pdC8/aWQ9YjMxNTNiZTI5ZGU4Yjg1NzBiMGMxODQzNjliZDQxZjRjNjQ2Y2Y5
Mg0KPiA+ID4gPg0KPiA+ID4gPiBUaGlzIHJlcGxhY2VzIHRoZSB0b2tlbiB3aXRoIGFuIGV4cGxp
Y2l0IHNlcGFyYXRlIGtleXdvcmQgZm9yIHN1Y2ggbGF5ZXJzOg0KPiA+ID4gPiBzbyB0aGF0IHNw
ZWNpYWwgcHJvY2Vzc2luZyB0byBkZXRlcm1pbmUgdGhlIGZpbmFsIHZhbHVlIGNhbiBiZSBhdm9p
ZGVkLCBhbmQNCj4gPiA+ID4gdGhlIGZlYXR1cmUgY2FuIGJlIGZvcm1hbGl6ZWQgaW4gdGhlIGpz
b24gc2NoZW1hOg0KPiA+ID4gPg0KPiA+ID4gPiBpbnN0ZWFkIG9mDQo+ID4gPiA+IMKgIMKgICJi
Yi1sYXllcnMiOiBbDQo+ID4gPiA+IMKgIMKgIMKgIMKgIMKgIntUSElTRElSfS9tZXRhLW15LXBy
b2plY3QiDQo+ID4gPiA+IMKgIMKgIMKgXQ0KPiA+ID4gPg0KPiA+ID4gPiB0aGlzIGFsbG93cw0K
PiA+ID4gPiDCoCDCoCAiYmItbGF5ZXJzLXJlbGF0aXZlLXRvLXRoaXMtZmlsZSI6IFsNCj4gPiA+
DQo+ID4gPiBDYW4gSSBzdWdnZXN0IG5hbWluZyBpdCAiYmItbGF5ZXJzLWxvY2FsIj8gImJiLWxh
eWVycy1yZWxhdGl2ZS10by10aGlzLWZpbGUiDQo+ID4gPiBmZWVscyBiaXQgb3ZlcndoZWxtaW5n
LCBJIHRoaW5rIHdpdGggYXNzb2NpYXRlZCBkb2N1bWVudGF0aW9uIHVzZXJzIHdpbGwgYmUNCj4g
PiA+IGFibGUgdG8gZmlndXJlIHdoYXQgImxvY2FsIiBzdGFuZHMgZm9yIGluIHRoaXMgY2FzZS4N
Cj4gPg0KPiA+IOKAmExvY2Fs4oCZIGltcGxpZXMgdGhlIHBhdGggY2FuIGJlIGFic29sdXRlLCB3
aGljaCBpcyBub3Qgc3VwcG9ydGVkLCBhbmQgaXQNCj4gPiBkb2VzbuKAmXQgc3VnZ2VzdCB3aGF0
IHRoZSBwYXRoIHNob3VsZCBiZSByZWxhdGl2ZSB0by4gSeKAmWQgcmF0aGVyIG1ha2UgaXQNCj4g
PiBsb25nZXIgYnV0IGNsZWFyZXIuDQo+IA0KPiBiYi1sYXllcnMtcmVsYXRpdmUgbWF5YmU/DQo+
IA0KPiBiYi1sYXllcnMtcmVsYXRpdmUtdG8tdGhpcy1maWxlIGlzIHByZWNpc2UgYnV0IGRvZXMg
ZmVlbCBhIGJpdCB0b28NCj4gdW53aWVsZHkuIEFueSBvdGhlciBvcHRpb25zPw0KPiANCj4gQ2hl
ZXJzLA0KPiANCj4gUmljaGFyZA0KDQpBZnRlciBJIHNhdyBBbGV4JyBwYXRjaCBmb3IgYml0YmFr
ZS1zZXR1cC5zY2hlbWEuanNvbjoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL29wZW5lbWJlZGRl
ZC1jb3JlLzIwMjUxMTA2MTcwODE1LjI0Mzk0MjEtMS1hbGV4LmthbmF2aW5AZ21haWwuY29tL1Qv
I3UNCml0IG1hZGUgbWUgcmVhbGl6ZSB0aGF0IEkgaGFkIG5vdCB0aG91Z2h0IHRoYXQgcGF0aHMg
aW4gYm90aCANCmJiLWxheWVycyBhbmQgYmItbGF5ZXJzLXJlbGF0aXZlIGFyZSBhY3R1YWxseSBy
ZWxhdGl2ZSwganVzdCB0byANCmRpZmZlcmVudCBsb2NhdGlvbnMuIFVuZm9ydHVuYXRlbHksIEkg
dGhpbmsgdGhlIG5ld2x5IHN1Z2dlc3RlZCANCm5hbWUgaXMgdGhlbiBtaXNsZWFkaW5nIGFzIGl0
IGltcGxpZXMgdGhhdCBwYXRocyBpbiBiYi1sYXllcnMgDQphcmUgbm90IHJlbGF0aXZlLiA6KCBJ
IG5vdyBhbHNvIHVuZGVyc3RhbmQgd2h5IHRoZSBsb25nZXIgDQpiYi1sYXllcnMtcmVsYXRpdmUt
dG8tdGhpcy1maWxlIHdhcyBvcmlnaW5hbGx5IHByb3Bvc2VkLg0KDQpJIGRvbid0IGhhdmUgYSBn
b29kIHNvbHV0aW9uIGZvciB0aGlzLiBUaGUgYmVzdCBJIGNhbiBjb21lIHVwIA0Kd2l0aCBpcyB0
byByZW5hbWUgdGhlbSBib3RoIHRvLCBlLmcuLCBiYi1sYXllcnMtZGlyLXJlbGF0aXZlIGFuZCAN
CmJiLWxheWVycy1maWxlLXJlbGF0aXZlLg0KDQovL1BldGVyDQoNCg==

