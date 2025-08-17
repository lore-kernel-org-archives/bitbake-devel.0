Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BABCA0EE4
	for <webhook@archiver.kernel.org>; Sun, 17 Aug 2025 20:34:22 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.39])
 by mx.groups.io with SMTP id smtpd.web11.60289.1755462853053422323
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 17 Aug 2025 13:34:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=pOXngEcN;
 spf=pass (domain: axis.com, ip: 40.107.130.39, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ei7H1ABuP2aut4A4qL7zTPnrc3AV23bCRJdp2AkZmohd/7ENCIaz96viit20sYfj5bYY+PC9W6i/ZvJIuAqA0Gq5OVOe0zUn20rzO5fPHG6XyN/plC60VgYowPi6r0jy46LSsXMCJXnn6SW3HcbTvO7J58FijygcLJ/t9pMRF6iX0e646TTDqiOcdntHBfKl8lHchotYzA6+c5DhYygfu6J11Atk2MqeMaBZKZ71/h2KTI7Z0ZO1POTpggcJTLPybkMQfU4uVUpCijv8H4i+KR82zL2HZWlb33cEjFG1yLs+AzRfXvsYXbeFH1KXW6RnaXkP+YTVeQhk0tbdH9lCuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6ZYAnkxH4YT7QncBQU88eiI8wuYXsHEuN5fk2JdgTM=;
 b=Y7NFNUgj0UfFxKDIsq3vkCQkZcMvIwXXY/YqSA0uKIC9853cFIGCTigfebW3KCKKvQlOIGc5UcC8DUYjOIqLyGcPs1+5iCO/nlrlOyj2TAia24LJ9h93yXZZtisvGvW9Hjtiri58yfQ4f0NFDRORAwcrmk8hUMpcRfy4zmlFlkpopHrKfYzz+hmGagjCVa2pyykZE8Z3MfvUxmJ10sUGmoFq3oHbQeX6VNN7S1u8967etwaGGWDElssOjAZ/8IykHBSZTtX6Gik+As8rTFWY339FkslUHLBAF+sA8y4LozwJ67mcTG3fm0G9MmFS6wQveCrb6jUs9qUUbIRQq8YqLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6ZYAnkxH4YT7QncBQU88eiI8wuYXsHEuN5fk2JdgTM=;
 b=pOXngEcNtqaai3P1GONU1JtPV18AUOJFbgT8Vy9xNd2iE10/SBv3ly056FVjzYrZON4pNGpHc3WWxJKxamPoosG/M0AoWiWAGaHUfy+q0ENlzQbDpnSM/n/PkGrWcEVgXMKVwbj48VlXcZD3+FoV4keOgiLcLkTaYnsQNI1mMtE=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by DB9PR02MB9778.eurprd02.prod.outlook.com (2603:10a6:10:452::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.23; Sun, 17 Aug
 2025 20:34:08 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9%3]) with mapi id 15.20.9031.021; Sun, 17 Aug 2025
 20:34:08 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "alex.kanavin@gmail.com" <alex.kanavin@gmail.com>
CC: Joshua Watt <jpewhacker@gmail.com>, Chuck Wolber <chuck@wolber.net>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel][PATCH] cooker: Add layer-specific ignore for
 dangling appends
Thread-Topic: [bitbake-devel][PATCH] cooker: Add layer-specific ignore for
 dangling appends
Thread-Index: 
 AQHcAJf6McLmYgFcDUW1atIVrTi8NLRJMQmAgAAAf4CAEZ2agIABNReAgAGpiICABfuIVYADv4ZA
Date: Sun, 17 Aug 2025 20:34:08 +0000
Message-ID: 
 <DB5PR02MB10213C6E625CE246FA2896891EF36A@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20250729144906.1665908-1-JPEWhacker@gmail.com>
 <CANNYZj-TMk4ktaPqC2EbS-k636cJfr3hyeZXp5rrEESi-ovZjw@mail.gmail.com>
 <CAJdd5GaNH=gP+ypmV31MLwYgF-xdT+e-E9rfW1JCgQis2PJtyA@mail.gmail.com>
 <DBY5WKIGG9UG.3DFOCYWME1YVA@wolber.net>
 <CANNYZj_7MebKw3iKvgRdKkpQvBW4a+4kdP8QZX_yWoY3DxN6TA@mail.gmail.com>
 <CAJdd5GZXsmby-n5XRX+U1-Hg66xricNt_oyAz0CG9mY89U+3Xg@mail.gmail.com>
 <185BEA3DB770D62D.30607@lists.openembedded.org>
 <CANNYZj8e=9C0sCgFd9kTOR+yPmV0kB72yvb_s_7=koqWgkhhbQ@mail.gmail.com>
In-Reply-To: 
 <CANNYZj8e=9C0sCgFd9kTOR+yPmV0kB72yvb_s_7=koqWgkhhbQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|DB9PR02MB9778:EE_
x-ms-office365-filtering-correlation-id: 27fbe6cb-9618-4f7e-2ff2-08ddddcd6ab4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?Zk4wVU1SaFZMWGEwdlA3WTJnV1ZBYjZ3OHlpZW5WdFZQWGxPNHkxMm9yMUpv?=
 =?utf-8?B?TGpENlV3dVVWOUJTR3UvWnpONzZGaUJMcytVKy9kRXh6b3BRd05NUlJ6SVht?=
 =?utf-8?B?UFdNMWtTQ0cxT1ZTQ3Fab2o5eTlJYjlHTTFIcXNPcWN0UmJEYUFzcUsvbUdI?=
 =?utf-8?B?RUVsbkdBUkI5ZkFCRlRjd0lIZXl4SzZEZnBMS3lSRHc3S01rZWpTYXR5d2lN?=
 =?utf-8?B?Z3hQeXVsTVhGVkZGckRBSnNaR3Frc2I0ZlRZcklqUWRoV1F1aTdiaHVDRmhK?=
 =?utf-8?B?bHAwT3VkVFhCTkJTRHpKK2ROTVR3K0NGRExtSFkreGJFenN2bjlLMmRPYlNN?=
 =?utf-8?B?R1N3d1V3NVdBWWV6dHdyMGp4a0ZDQUltOWJYWFFTRVNKazREbHRDYXg0dnF6?=
 =?utf-8?B?NytyTmlVLzlzdHdrRlJ0MTVYc0lzdXFOeE8zNEw1RkZCbDJURytRYXRTdUl5?=
 =?utf-8?B?NkVYUFZ0dEdUQStobkZaTzFlallid3V3UXRBQmI2RFFlQ2ZIbERMaTFDZ1M1?=
 =?utf-8?B?d1k3Nys1eCtRRTNXMjBMOSsraTV4K01Bc0hLMG1NK3NzL1lid1AwZERHUjlj?=
 =?utf-8?B?Z1FadktsMkRsY1paUVR0ZjFDQjNQcWo5S0dQeHRJNmlPRmZ1OEtyeGpDWm05?=
 =?utf-8?B?K2JINzNSTEtqckN4Z3Q1M2ZwcmpwY1N5MlVraUJHVUpWWGZMRTVpQlRoak8x?=
 =?utf-8?B?UjJ2dTl5dDZxWDg1Vk5sL1RSSVI4NEN5MXJLNHMrL2dTbElJdGZYMU5IUGZY?=
 =?utf-8?B?UHdrdFFMOUVzUGZjbzM0cWJ0d01JZ2dmSUk0OGxlOWM3SitMcUpQWG1BMHJ2?=
 =?utf-8?B?ODRteU5mSzRxczJ6cXk5U3A2ZDJzUVloTnNUenhNa3FNUFJuWEpQV2NwVG5E?=
 =?utf-8?B?bmo5MVRQYlV6QnpPL1JXOXRQa3o3a1RxNVM4bGJkOVJQQ3RVNXRxckZoL0Fi?=
 =?utf-8?B?eitUcm9ya2lFWWlPNEExRmJxM3BBVFdrd3FXTEZ4d3AyakY1a2RDRG1aMm5x?=
 =?utf-8?B?TmQ1MklvaStWUEdOSGRtdnpFbkkxdEhRbmJnZ3ZPeGVKMlRKeU9ybjE0SDlS?=
 =?utf-8?B?cmVSbVpscXdGY1h3My9jL0lONVBKQmZJV3UxK1VqVS8ycURodnJkSGRCYUJw?=
 =?utf-8?B?QU9zanJocmpENnBlaXFKSkpZRXZTVFNNL2xOQ0VyemNXeUV5MzVYdng1OWtK?=
 =?utf-8?B?UFJDTVNDcFRQaDg2NUdwM1BVMzNEUUhuWmtZdW5CTWEwQndIMXg1VFUrOTJW?=
 =?utf-8?B?eUFTbTB3eUMvd1N6Mkd1cVAzNHUyeDhWc0VmN3FTSk96YkVSRnR5SzZMOG9S?=
 =?utf-8?B?STZXWVI4Y2JKbHBXSGp6L1ZQT2J2R25VaTJWbEMzdDN4Um5GTkNsRHRqZW5U?=
 =?utf-8?B?MGJMYTJXTlNYOWdYSW9Db1ZLZDNBNDk0V1lZczhUcnZSbXVZd2RpVlN2RFU4?=
 =?utf-8?B?WVRaU1cwY0lsRTIwenM0V2Z0ckhZa1VLOGxiS2VvblVrdGRGUXBOdzdOUjV3?=
 =?utf-8?B?bVdNNnRib28zMEk1ZDVrSXhUQ3Rna3VXaWFTWUdVMlVUMmRuT0lHUFNqdElx?=
 =?utf-8?B?aXZnUkN4amYydWtQbzRHQS95MUxubk1pZlhZZVlCS3EzMkVtUExHQlBQSVdG?=
 =?utf-8?B?WDZMQ3BrdWI1ZWtzNmZXNThPRXVoZmJXQTAwaTBQVERmWnFnYlFOU3ZMaVU0?=
 =?utf-8?B?bzl0M3M0dTRUU00rOEhDSXQ3cG0vanQ0am9TOWZLRHRkSXJhd25PUEFCRDFD?=
 =?utf-8?B?OVZaVTF0VWJiYllNMVZUMGFrNnhpOEhNd0VRVERIdmpRdWVrdVgrVVI0WHoy?=
 =?utf-8?B?N0dtME5KVkU5K0FhYWxoVXdCaThId0pCaU5jS2Y3NU12WUJFbFBkdmZ1d0do?=
 =?utf-8?B?bW1aOC9JSHBUN1JIUGRNbzBiQW1LcW9lN25mYXVEOWVmVWpGOWFIRFhmWjhW?=
 =?utf-8?B?TDY1UDdMSkhKWmkzcEZGU1FuZFdIemlaZUF3eC8zSkNtMVd2WHRJM3JnNEl0?=
 =?utf-8?B?SU4xWFB5L0JRPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ME13NFV4VytRSjhveGNjSnBzemp6dExFN1hDTW5xMEVXc3k4SElkVzNlTTBQ?=
 =?utf-8?B?MmduK2FodHlpZlhYa0JJQWxzU0lwVHhUeFVQalNhLzUrOFlsWnNxd25BOVVy?=
 =?utf-8?B?U1FmOVk5UHFkYnVXSlhGUjFWZjlZR1J6TXBZeVhxNFFEa3BkV3RaazVGWFd3?=
 =?utf-8?B?UWY3QWRLaGVneDlib2RwKzVsOXdzb2xteTEzczV3V3pKK2k5NVU2QzVFTERP?=
 =?utf-8?B?OUxsRERPM1psMnFKUFp2T29DRFlzUXlYb1lsaGFKbG9kbDFGUGxIRnk3d3Yz?=
 =?utf-8?B?eDBqeEg1Zkw0eFlJZS9teGc4L2Fvam5VRWVIVm1oSTBjcTBGbE5QcmEyZVhL?=
 =?utf-8?B?RWlnMm9iMW9lWWJtbUZZMWt0bGtsWEQrK3h1OVpvcGhWNUM2SnZLek02bnMy?=
 =?utf-8?B?MmlLditvYjRIbFZkSk1TZnI3TERISkJhd2dWaUYwalFxSzhKMHpwOGduME5Q?=
 =?utf-8?B?WVBIQVRvTmJzMlpxZENXdlJhS0FkQVpPN1dTK3o2cTBiNktYQXF4ZWFBQ1k0?=
 =?utf-8?B?WnVJUEpQTmJlQVFFNXdPVGxuY3owWU9OZEVOWGgzL2l0ZDNhM1lkRkFtTnhy?=
 =?utf-8?B?UTk1REdBM3BJVjBneER4V0kralpTOUdyOUl6TEd0YXBPakYxRjg0NEhYaTc1?=
 =?utf-8?B?RiswbW9CcFFmeCtjcFFST0V3aCtWSVFqSFlZRmtCdWEwbG5QSkFyazZEZ3Qz?=
 =?utf-8?B?amwzZlNQeFk0QUl5WW95RFhQWWNIRjlqM0c5S1R5WngxdTYxYTM4a3RGNVhv?=
 =?utf-8?B?Zy9wcys1bHVQalNFMlQzTW03TVpQY3FpYnRPNDhYY0Y2anUvQy90dEd1cmxM?=
 =?utf-8?B?RWluSHRjdlhUbWlTclZZa25WOU9lTlVpZ1VhS0ZlT2xYRE5odE1SZSswSThN?=
 =?utf-8?B?NEpMT3NYSXZObnArbDVxOTJhaUtrYmVyTEpkL3ZxMFVMUjRKaFQ4SFlLTlEr?=
 =?utf-8?B?YXdxU05LOThjdFFKMVIxR1F0bFVQbzMzRGE5QkhlMHBkYjNWL1ZnVEtZVHZW?=
 =?utf-8?B?K2JrVmNEKzRyOURxblhhaUMyQW40TEU3dEFycWhwcFBGZEJuVUtVRWRzZllB?=
 =?utf-8?B?ZmFwZ3puWVFHUm5oRU44ek9JOFJlMElBeFV3bVFDa1picVdpaEVKcmg1TE14?=
 =?utf-8?B?aXdpVjZ2WmdWK09JNWhHYmQ3dFZmWUNTN2RHQi9tWFJPRStlcmxXVlhkVVFP?=
 =?utf-8?B?eXdjaitCUnE4d09qa0E5SCtzaWtlT2IrNUVhTlNBMFZNK2Ryb1pKSU42b1NQ?=
 =?utf-8?B?aStFeW5pUDhmZ0hzbTdOZ0dZbnZnb2RRbS9OS25WSTB4ZEhjR293YWZmR0hn?=
 =?utf-8?B?TDVtbmFzTlkxQUNpTFFmOUZ2WkpDZWRXNStDajNtSVFnL0RnamN6Q1RQQzAx?=
 =?utf-8?B?Zm5HaHAwK2krd0xZNG1rNlRrTEVrUEkrbnIxTnIwK0ZDZWp3TE1aMkE2Q21u?=
 =?utf-8?B?bUdDN3NVR1VjR1hVTmtuQ20xcEtxNUJYTng0N0g0eXNsN0poS2QrbEpKd1F6?=
 =?utf-8?B?V0VVdk9XaENmYmdZeUdQYTJCNVdHQUJIcVR2bDQ3VE9tdDYvRk1IL1BTU2ZF?=
 =?utf-8?B?cXVtZWgrSU1VY0Fia09zM1JpaXd0blAxYWRSRnF0S3ExMklsZjFkdncxVmNi?=
 =?utf-8?B?bTB6c3hWSy9hbUVraTRPNHZlWmNXaW16Z3l1VDRnbHJMRHNYT0ZOQ3RCbVFX?=
 =?utf-8?B?R0lsdis1cWwyOXBtcTVmYXY2dDBIQkVuZkt4N05BbitwZnh0c2JSa0M5VnVx?=
 =?utf-8?B?R28rS2tZdjZwSFRpeGtIUXVYNWZnWEdKQW1jaDZXaWJpa0pLaEdFam5pdXNL?=
 =?utf-8?B?VHBhWXp0MExKL1V5czMvSU9SMmtYZ1BMK2ZoZk5oK2d1V2pGWWFaZ0treG4r?=
 =?utf-8?B?Y09XK0Y1ZHh2V09Fa1NWa3BVVFBCZ3BmeFdLNWdBS1BXMHN5Q2NmOC85NS9u?=
 =?utf-8?B?L0NoS05iYTAzbTJZczB6eFdYS3I2K2R6RGN3UzlwQ1pucDM0NWJzMk05UmRC?=
 =?utf-8?B?cUZjUHpNaExMK0FsRGl4MEorL0hOYytzVnVNUkEwWHNVRVFXc052NjgzdURY?=
 =?utf-8?B?akE5VGxnM3V0dE5sTy9HemtzeVM5Tit3L0RCUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27fbe6cb-9618-4f7e-2ff2-08ddddcd6ab4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2025 20:34:08.4176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NiU4Cz5O8tFxAVSqqRP++Dwq5/XSa5l/P70jDn3omiCLXC/2769bj9nAahRLn+k5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB9778
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 17 Aug 2025 20:34:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17878

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBiaXRiYWtlLWRldmVsQGxpc3Rz
Lm9wZW5lbWJlZGRlZC5vcmcgPGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZz4g
T24gQmVoYWxmIE9mIEFsZXhhbmRlciBLYW5hdmluIHZpYSBsaXN0cy5vcGVuZW1iZWRkZWQub3Jn
DQo+IFNlbnQ6IGRlbiAxNSBhdWd1c3RpIDIwMjUgMTM6MTANCj4gVG86IGFsZXgua2FuYXZpbkBn
bWFpbC5jb20NCj4gQ2M6IEpvc2h1YSBXYXR0IDxqcGV3aGFja2VyQGdtYWlsLmNvbT47IENodWNr
IFdvbGJlciA8Y2h1Y2tAd29sYmVyLm5ldD47IGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVk
ZGVkLm9yZw0KPiBTdWJqZWN0OiBSZTogW2JpdGJha2UtZGV2ZWxdW1BBVENIXSBjb29rZXI6IEFk
ZCBsYXllci1zcGVjaWZpYyBpZ25vcmUgZm9yIGRhbmdsaW5nIGFwcGVuZHMNCj4gDQo+IE9uIEZy
aSwgMTUgQXVnIDIwMjUgYXQgMTI6MzMsIEFsZXhhbmRlciBLYW5hdmluIHZpYSBsaXN0cy5vcGVu
ZW1iZWRkZWQub3JnIDxhbGV4LmthbmF2aW49Z21haWwuY29tQGxpc3RzLm9wZW5lbWJlZGRlZC5v
cmc+IHdyb3RlOg0KPiA+ID4gSG9wZWZ1bGx5IHRoYXQgYWNjdXJhdGVseSBvdXRsaW5lcyBvdXIg
c3RydWdnbGUgaGVyZSBhbmQgd2h5IHdlIHdvdWxkIGxpa2UgdGhpcyBmZWF0dXJlLg0KPiA+DQo+
ID4gVGhhbmtzIGZvciB0aGUgZGV0YWlsZWQgd3JpdGUtdXAgSm9zaHVhLiBHaXZlbiB3aGF0IFJQ
IHNhaWQgaW4gdGhpcw0KPiA+IHRocmVhZCBhZnRlciB0aGlzIGVtYWlsIGFwcGVhcmVkLCBJJ2Qg
bGlrZSB0byBhYnN0YWluIGZyb20gZnVydGhlcg0KPiA+IGNvbW1lbnRpbmcuDQo+IA0KPiBGYW1v
dXMgbGFzdCB3b3JkcyA6KQ0KPiANCj4gQWZ0ZXIgSSBzZW50IGl0IGFuIGlkZWEgcG9wcGVkIGlu
dG8gbXkgaGVhZDoNCj4gDQo+IHdoeSBub3QgaGF2ZSB0d28gbGF5ZXJzOg0KPiANCj4gLSBvbmUg
bGF5ZXIgdGhhdCBleGlzdHMgZm9yIHRoZSBzb2xlIHB1cnBvc2Ugb2YgaG9zdGluZyBiYmFwcGVu
ZHMsIGFuZA0KPiB5ZXMgaXQgd291bGQgaGF2ZSBicmFuY2hlcyBmb3IgZWFjaCBvZiB0aGUgcmVz
cGVjdGl2ZSB5b2N0byByZWxlYXNlLg0KPiBZb3UnZCBoYXZlIHRvIGRldmlzZSBhIHByb2Nlc3Mg
Zm9yIHBhdGNoIGZsb3cgdGhhdCBlbnN1cmVzIGJiYXBwZW5kDQo+IHR3ZWFrcyBnZXQgYXBwbGll
ZCBvbiBldmVyeSBhZmZlY3RlZCBicmFuY2guIFRoZXJlJ3MgYWxzbyBhIGJlbmVmaXQgaW4NCj4g
aGF2aW5nIGxlc3MgZmlsZSBjbHV0dGVyLCBhcyBhbnkgYnJhbmNoIHdvdWxkIGNvbnRhaW4gb25s
eSBmaWxlcyB0aGF0DQo+IGFyZSBkaXJlY3RseSByZWxldmFudCBhbmQgdXNlZCwgYW5kIG9uZSB3
b3VsZG4ndCBoYXZlIHRvIGZpZ3VyZSBvdXQNCj4gd2hpY2ggYmJhcHBlbmQgZ29lcyBpbnRvIHdo
aWNoIHByb2R1Y3QuDQo+IA0KPiAtIGFub3RoZXIgbGF5ZXIgdGhhdCBjb250YWlucyBldmVyeXRo
aW5nIGVsc2UsIGluY2x1ZGluZyBkaXN0cm8NCj4gZGVmaW5pdGlvbnMsIGFuZCBwcm9kdWN0LXJl
bGF0ZWQgcmVjaXBlcywgYW5kIGhhcyBvbmx5IGEgc2luZ2xlIHRydW5rDQo+IGJyYW5jaCBsaWtl
IG5vdy4NCj4gDQo+IFdvdWxkIHRoYXQgYmUgc3RpbGwgdW53b3JrYWJsZSBhbmQgY2F1c2UgdG9v
IG11Y2ggb3ZlcmhlYWQ/IEkgY2FuJ3QNCj4gaW1hZ2luZSB0aGF0IGJiYXBwZW5kcyBnZXQgYSBs
b3Qgb2YgY2h1cm4gYW5kIGFyZSBjaGFuZ2VkIG9mdGVuLg0KPiANCj4gQWxleA0KDQpUaGF0IGlz
IGJhc2ljYWxseSB3aGF0IHdlIGRvLiBXZSBoYXZlIG91ciBub3JtYWwgZGlzdHJvL2FwcGxpY2F0
aW9uIGxheWVycy4gDQpUaGVpciBtYXN0ZXIgYnJhbmNoZXMgd29yayB3aXRoIHRoZSBsYXRlc3Qg
UG9reSByZWxlYXNlIChjdXJyZW50bHkgV2FsbmFzY2FyIA0KNS4yLjEsIGJ1dCBzb29uIDUuMi4y
KS4gVGhlbiB0byBidWlsZCB3aXRoIHNvbWUgb3RoZXIgdmVyc2lvbiBvZiBQb2t5IChpbiANCm91
ciBjYXNlIG9ubHkgd2l0aCBtYXN0ZXIgb2YgUG9reSksIHdlIGhhdmUgYSBzZXBhcmF0ZSBsYXll
ciB3aGVyZSB3ZSBkbyANCmFsbCBhZGFwdGF0aW9ucy4gVGhpcyBsYXllciB0eXBpY2FsbHkgaGFz
IGEgbG9uZyBsaXN0IG9mIEJCTUFTS3MgdG8gZHJvcCANCnRoZSB2ZXJzaW9uZWQgYmJhcHBlbmRz
IHRoYXQgYXJlIGluIG91ciBhcHBsaWNhdGlvbiBsYXllcnMsIGVpdGhlciBiZWNhdXNlIA0KdGhl
eSBhcmUgbm8gbG9uZ2VyIG5lZWRlZCwgb3IgdXBkYXRlZCB2ZXJzaW9ucyBvZiB0aGUgYmJhcHBl
bmRzIGFyZSBpbiB0aGUgDQphZGFwdGF0aW9uIGxheWVyLiBXaGVuIGl0IGlzIHRpbWUgdG8gdXBn
cmFkZSB0byBhIG5ldyB2ZXJzaW9uIG9mIFBva3ksIGFsbCANCnRoZSBjaGFuZ2VzIGluIHRoZSBh
ZGFwdGF0aW9uIGxheWVyIGFyZSBhcHBsaWVkIHRvIHRoZSByZWFsIGxheWVycywgYW5kIA0KdGhl
IGFkYXB0YXRpb24gbGF5ZXIgaXMgY2xlYW5lZCBvdXQsIHN0YXJ0aW5nIGEgbmV3IGN5Y2xlLiAN
Cg0KLy9QZXRlcg0KDQo=

