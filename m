Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DBFE7719A
	for <webhook@archiver.kernel.org>; Sat, 11 Jan 2025 11:06:56 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.53])
 by mx.groups.io with SMTP id smtpd.web11.13352.1736593612920376170
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 11 Jan 2025 03:06:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=RBdJkeZQ;
 spf=pass (domain: axis.com, ip: 40.107.103.53, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RucReQfRi1Nne3vw7y6iXrz3GHjlgWZjwiWaC/pv1Fv8ujujKafz9QZMgouG5h44BQjE553TWJBXKrj78dHYB1lQzRrh0luI7rwvVKvcE8l5iokd8HStuAyp8JzM3nvVeooskXvSq8YIQMJXJQ1/hZYpI9JEmV+O0GOCLbFQXKNKEPwygXyn5o8Z2mUbiPtWZ+O7OdG/Kb2DbmqjGK7gvZ7tVHeupwHEUdCgYnrAdHNEl+QjWye1ftEIyB9v2+wPpNgzi2f9QlleDb4I0rLWiHy3TTwa30DKUV4tGvbPj30ERvT1c4OrFWIQgfxLKNWo4wun1ZnbClxMhwTjE+L3hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbZ/TNsASUt7UWbv4o/hp8EGBH1krJ5EUy9RsBXtfd0=;
 b=BrtMPfiNdBtpYm9Yv8IHkf1zQwy4TVYaI6hSWIBfU10XMxXrBIzX34G2AVkU8L1uLiLzoIk5PBxuWkWNZatmrS2rVca+qUz5URDOY3muQIYe9tr0AC5JRHLyNhY4VLQurajQfweNv83TFwOLl2cJEKLIShf0hjGGks0yXtViauvGFCMROkN5BNHtHSZGVuDtMyQFC+fIcQNU7tPjcwi8qtuEcZHQpZeYWZ7JiH3u0ERSLddBCCa9nXeoKHu0m5VvgCneOi22Ctg3zbpqVYV7BYPSK2D1+pIwBcguv4rl6EmUb6rRve+S6qfRAVQ19uJ41MfTihCc1SvOnkWoXUxI7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbZ/TNsASUt7UWbv4o/hp8EGBH1krJ5EUy9RsBXtfd0=;
 b=RBdJkeZQEElfu6B7flmelcpekBYdA1i3L8DZb7FsahYXxO8yBFoe15lfY0Kt6h/tdQssByZLSz4QSNrXIDLg4NDIVRucxTTABT9YSzqvvIWCdFbruAdMZT/ohSY3ga/uaGJm/jth+UM6DWjpEaycvf0tJcK/rvM0fDK2a9OkXGs=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by AS4PR02MB8310.eurprd02.prod.outlook.com (2603:10a6:20b:511::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Sat, 11 Jan
 2025 11:06:48 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9%4]) with mapi id 15.20.8335.012; Sat, 11 Jan 2025
 11:06:48 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "yoann.congal@smile.fr" <yoann.congal@smile.fr>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: =?utf-8?B?R2hpc2xhaW4gTWFuZ8Op?= <ghislain.mange@smile.fr>
Subject: RE: [bitbake-devel] [PATCH v2 1/2] tests/parse: add test for ?= and
 ??= operators for variable flags
Thread-Topic: [bitbake-devel] [PATCH v2 1/2] tests/parse: add test for ?= and
 ??= operators for variable flags
Thread-Index: AQHbY7L978tijvlNTEq/K3sgwAPdD7MRaLlQ
Date: Sat, 11 Jan 2025 11:06:48 +0000
Message-ID: 
 <DB5PR02MB10213447117C48CCE33E10BD5EF1D2@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20250110225652.3892828-1-yoann.congal@smile.fr>
In-Reply-To: <20250110225652.3892828-1-yoann.congal@smile.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|AS4PR02MB8310:EE_
x-ms-office365-filtering-correlation-id: 765ece1a-d7a4-45b4-9e0c-08dd32300b4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?OCtEaUtReXZudlhMRFpkR2k4Q0I4YUpodmdrZFNsMEovbDcyZ21ZUmtubmpj?=
 =?utf-8?B?dDJGV0twME1nVWovNzBJdWprck5hSzV6M2sraFNUUENDV1JxZnYwUENhNDN5?=
 =?utf-8?B?WWE1TXVmSzBXV3I5eXhnZ1RvQnJWZkN0NzMrTW5wNDd5R2lDWjZWUGRFWDFL?=
 =?utf-8?B?TlI5WlF2TUZ0SDV2QWQ0RHBPSVJRRkFsWEo3ZHlFdGJPcUxTQ0J0UUlITVRK?=
 =?utf-8?B?aTV4NXppWkZGQkYrZGcyd1lXYzcvWXhiK2pNOWZNSWZOVHYrbVBQbVREdUY2?=
 =?utf-8?B?cjVCaUNrWmRRbmlMRjJtSGthUzRBSk9rUzZ6WHUxMmF1MUg1QkVwZW51U3Nj?=
 =?utf-8?B?eFUyMXpNS2VOT2pKYU1jVHNnYWxMWHkzUk5rc1MweU4wY0pqNDErZGhJSXpZ?=
 =?utf-8?B?U2hHekdWczgvd2RoNnErWmN2QzNVV2o1OExQYlN1OHNxa2F6bjczRGQ3WlZD?=
 =?utf-8?B?WERGcXZwV09Yalo4MnhGR1NpSG1yOTBlVGpaTGM0OEgwWWg0RzZOK3RnRnlE?=
 =?utf-8?B?V3hhNDc2R3BrUkVRRGl4RXQrUXdDUkd0Uno1WGlNS0JYcnRRcUZPVmxYbHkv?=
 =?utf-8?B?UEM3OWVTVC9CVVNSMGJRRGxTcnU0MnhURkZrTjQ1amFZL1UwTkhtVm5KMDRm?=
 =?utf-8?B?VW80Nkp3SEwyRkViNGVLZXJ4bTlNQ1QzNXN4L25LYkhNVTJIVVBzUHVIeHZ2?=
 =?utf-8?B?NUZTc2IvQUpXVjlPcU9RZTFGMjJsWDkyZHpuOG11Q29QbG9aOEhPOGY2dXFR?=
 =?utf-8?B?ZFIyQlN3dlErV09WVGRYZGVYREtMN2RVczlsdkZuZnRxUHdHZTc4aUtDd1Bi?=
 =?utf-8?B?Y3ZtTkxoZWhOVEE3R2dXVHpRVjZUdTc0dk1MdEtvNy9WTG1Hc1RVcUhZWWU2?=
 =?utf-8?B?Wkk4UDIvVmdMYzFGbzJpMVVKWGpyS0c1V2xZSjdqWW05N3VkT1JML3RvdG80?=
 =?utf-8?B?a3VjN1Y0UmM2Tk0xQURUT0JTcVBEZGxXMTBvUkxySk5NYWZBT2tSTTJGQTNR?=
 =?utf-8?B?RHJxMHhjVi9XUDBCZTA5Y1hNOWRFN2E5WVZXQXN3MVBqVzJnRzUwak8wSm4z?=
 =?utf-8?B?aHprMjF0YlA1NTE4bEpFcCtwV3BWa1N2czhMcHZ2d3R6WEgxenJ5dDRvYzZO?=
 =?utf-8?B?MU5RYVFZclN6NXBrWUE1UUMzZ1o2WGFBYjhFSzgzSFRFRXlOOHVvaU01c1Nw?=
 =?utf-8?B?SXJWb00yK25DbEJ0UFVBQUNzY3cxSFNabEJ3NWJIY0liZUdhZjI4U2o4bTRC?=
 =?utf-8?B?SlgyVDByOXNTNmFhOVF3aTNJN3JBZFRIQ08yTEkyenl6aXhKSWs1b0ZZOE9q?=
 =?utf-8?B?Y1JPQnF2cVI2TDRJUEhLRm9ueUIxamhPZVNGOEhHeDJWcTh3VkNXSGFnLzhD?=
 =?utf-8?B?dm9WV1pwdk9tNUcyZDJSWGFCdnRDUHpoY1p3cDBGbzhLNHNIbjhvU2dobWVj?=
 =?utf-8?B?V1lTQUl6L1JTZVMxazJZcTdyVkpqbWVRbGE3WjVvNzduYkJhSUNFaEU4Q3Np?=
 =?utf-8?B?b21CZFpSS1VFSXZ6WnhMMDhQWU9YUGJSYUlQUjk1VzJ5bVdiYzZBemNmQlJr?=
 =?utf-8?B?SHA0akJvMDliMWxQMXh3YzdsaGladVB4aUV3Y3ZYRmRzaVpKbVlQdzU0Nk9o?=
 =?utf-8?B?Smc5SWZ0YXB4UlZOUStYdHVZWUNWWi9ZMTl4WEs2QkkzdmZlWTBHRUtWc1Q3?=
 =?utf-8?B?elBWVWtTM2NnZGRmVjBFcEVlODRpUjl4SFlkN1Y3NmpMTVg2eEpsMUk5MWkv?=
 =?utf-8?B?bHNDWU9LbElnZ0hPdHJUMURySjRCTTVPc3Q2czNFcWJ2dnoyWVgxMjlQSUhq?=
 =?utf-8?B?bFpRay9wbDRYSXpsT3JiY1FWS2dzY2NiZEx5QVJLTzZFODhmVTBYUkhkR1lV?=
 =?utf-8?B?RC92VXlKcnJqQUNLVDhNY0UvbGJYNTJTY042NTlNMFJUK0NGS0ZXNnNiY21n?=
 =?utf-8?Q?jajztixOScwXeF4cX4X7sWhmurPnPXkt?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?emZoOHZMOWhEckR3dmVOTVdZU2Q0T1lOR0huQzNtbFU1K2RHbkdLSzBFZ0F6?=
 =?utf-8?B?R2ZaOWNPNW5vbVdtZThKcFVUWEJzUmYycllwcGdxaVp2NUlTNWVtbzVzcTBl?=
 =?utf-8?B?STdDT2s1QkNJSmNaRUxQR0xwT3VhbFZyalMya3YycXY0ck5DejZqMUJMTnlU?=
 =?utf-8?B?a2J0UjBnNlhUeVJIZGMrVXRvTlN6aVRKVXlCdm1QSEhxbkNQVmpiVkFDTWZr?=
 =?utf-8?B?WGVra0p5dEN5dXRJNGRSTGRQc1JqQjEvY3VQVkowM1FYemFYcFNtOVBqTEJL?=
 =?utf-8?B?dm05UyszUmdjSkMzYTFCbkp1Yk9JR0lUUzRzMy9rdUlNZE1wYUIvWXg3VWlB?=
 =?utf-8?B?NEhWQlozekFkd0xuYjV4YWhNVllmWUgvcFMxRS9OT1pCaGFTRFoya0dSdERh?=
 =?utf-8?B?V2FBRU9PNlNaMHFJb0FoVzlQd2lIOWt5bnJRMGRWQllTZ1h2Y25KWGREbE1p?=
 =?utf-8?B?OTZhNHB1VHZwRlJKZE9ETWRJQ25JVmF0bnBQblFHLzJYcjZCUW5qdlhKa1Fw?=
 =?utf-8?B?ZWE4eUp1b1VqWTRjS0w2REVyK2o4OUNoTXVpZWp4a1JycXpvdTRUT2lybSt4?=
 =?utf-8?B?bzdrZk42VzltRkRUazNxOFFVS0dLWk5nRXVpUGEwejVCOEFremtxaTJzRTFL?=
 =?utf-8?B?RFVncmJ4dEFkTFhOTSs1ODR0K2lCc25Fc1J0Ym5jd1dJUTJBV0VHKzVpcDR0?=
 =?utf-8?B?Y1dsRnJGTlJIczZsdVpMbjg5OTc0YjFrNitsVUNLUVFNL2VvcGJNVzFGcW5r?=
 =?utf-8?B?NTNvNEROZUZmV25iYytCY0MxNXRUd2ZFeWxBNnczS0lyamxmWTBqajJGZ1Bp?=
 =?utf-8?B?UXpTUFgzRXVMNFEzN1hGTUo0Y1dhZlhCUlVxclNNbEJoODdzNVg0VXdTQ09x?=
 =?utf-8?B?ZDZ6QlJLZEdqMUhLVnkyb3cyTDE3aHVwMEMvckExK0FzcEs0dWVNMHRsa2ht?=
 =?utf-8?B?RzYxRHF6Q09kWjA4NlM1eGNORUYzcjVxUVRnVUdORVRlTml3RzgvZFFuOGxH?=
 =?utf-8?B?OUtYK0xNcGt0QnBhS2FWZXdLeG1CT0gwZkI5eklYR2ZNa2I2bFlRbTNJaWVu?=
 =?utf-8?B?KzQ5YU45YlJNS0l5MzE3bXpCQnYydkJFZDFOYS9KTGJ5ajc2V09hZWtNaGsz?=
 =?utf-8?B?UzJsY2lBZ3RMS2ZEcHhxM2RzWFNpZndOdHZ1UHh6bWE1UTBuUjNiK25pYUpX?=
 =?utf-8?B?VUlGNWRRRjlwVDZxc1VBUko0VTh4RDMxeXdaRVlNREpmeVNzU2l3aG04UHJl?=
 =?utf-8?B?aUk0VGJQTmlnQ1VYQkxrcEdLcmNhWE1YN2p5bFN0dTA5QUZKcVJ2MTBLTko3?=
 =?utf-8?B?VVlCbUFMeVNjeU00eVlyTmgwaFVGWHVOaTZFWUNRd1ltTFFwODU4blh3SjRW?=
 =?utf-8?B?ZFJOb2ZJaVZGZzl1cm54VmxXR014MXAwUjhMUXZlWHhYZ0EyMlQzRmRCalhs?=
 =?utf-8?B?UTBoSmhZbkxSUkx1a1Q0emVyYWF3YkF1c2luTU1zaVpyVFQwRExPS1ptZ3pB?=
 =?utf-8?B?ditmcW9WVW9tVldnSHYzVWJFaUdEK0d6dlRhWU5iWWhVWU5LVnVEYUlIeWhj?=
 =?utf-8?B?amNoR0sxY3RGMkRzMmFpRGh0M2t2bkdZblVRUDFXSzMxdktJVGhlcmtwTmVj?=
 =?utf-8?B?OWh6dzFudVRRakI4aUViNnA5QXE5WTJYSFI5TldHcG5XRDU1Q2tzOXRjTldh?=
 =?utf-8?B?ODdJaXFiRmhLNGR6QjlZdFdjV3M0K1UyVUFIWDJqZnlUQWhrb0s5YVRDTTNw?=
 =?utf-8?B?eHRnaDJMMWc5M1c2UVN6elNHZkdzV1lMbmZZTGJvbUpaSnNhTFYwbXVkR0JO?=
 =?utf-8?B?Z2JTRTNuOGlnWEMzeDROWVk5eU85WG9tbEZWRkxWdjFaMjYyUEhyVlE5ditE?=
 =?utf-8?B?dWZMUkx0RW1HSTNxbkxQb0FDZExTZ1Z3OEpnQ3FUUDFHeFVMdDFpWEdhY0hj?=
 =?utf-8?B?S3dnT1VKb2pLTWc0ZjdOcUVOaEJtdWY0dzBSV3o3OXU5U0JFMW1WYWZvblBY?=
 =?utf-8?B?eVNCaGlQN2gybzNWL09nSE4wZEJqTU9oaTk5bU43ZXJPbXF4ay83ZDhqSHVn?=
 =?utf-8?B?KzFkTWtBVjhITUt2bXcwZ2U1NzJuUWlyaHI3RDRiUUY5OVpvNndZeWs3U2d3?=
 =?utf-8?Q?vttc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 765ece1a-d7a4-45b4-9e0c-08dd32300b4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2025 11:06:48.5485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XmicJx8VWY+P/H373hyA6x6XIYehXI8KAz3KhZr/ie6/Dw6r+rCwteSRk0NdogEa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR02MB8310
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 11 Jan 2025 11:06:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17013

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBiaXRiYWtlLWRldmVsQGxpc3Rz
Lm9wZW5lbWJlZGRlZC5vcmcgPGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZz4g
T24gQmVoYWxmIE9mIFlvYW5uIENvbmdhbCB2aWEgbGlzdHMub3BlbmVtYmVkZGVkLm9yZw0KPiBT
ZW50OiBkZW4gMTAgamFudWFyaSAyMDI1IDIzOjU3DQo+IFRvOiBiaXRiYWtlLWRldmVsQGxpc3Rz
Lm9wZW5lbWJlZGRlZC5vcmcNCj4gQ2M6IFlvYW5uIENvbmdhbCA8eW9hbm4uY29uZ2FsQHNtaWxl
LmZyPjsgR2hpc2xhaW4gTWFuZ8OpIDxnaGlzbGFpbi5tYW5nZUBzbWlsZS5mcj4NCj4gU3ViamVj
dDogW2JpdGJha2UtZGV2ZWxdIFtQQVRDSCB2MiAxLzJdIHRlc3RzL3BhcnNlOiBhZGQgdGVzdCBm
b3IgPz0gYW5kID8/PSBvcGVyYXRvcnMgZm9yIHZhcmlhYmxlIGZsYWdzDQo+IA0KPiBGcm9tOiBZ
b2FubiBDb25nYWwgPHlvYW5uLmNvbmdhbEBzbWlsZS5mcj4NCj4gDQo+IFJ1biB0aGUgdGVzdCB3
aXRoOg0KPiAgJCBiaXRiYWtlLXNlbGZ0ZXN0IGJiLnRlc3RzLnBhcnNlLlBhcnNlVGVzdC50ZXN0
X3BhcnNlX2RlZmF1bHR0ZXN0IC4NCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiBSYW4gMSB0ZXN0IGluIDAu
MDAxcw0KPiANCj4gT0sNCj4gDQo+IFRoaXMgaXMgYSB0ZXN0IGNhc2UgZm9yIFtZT0NUTyAjMTU2
ODVdDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBZb2FubiBDb25nYWwgPHlvYW5uLmNvbmdhbEBzbWls
ZS5mcj4NCj4gUmV2aWV3ZWQtYnk6IEdoaXNsYWluIE1hbmfDqSA8Z2hpc2xhaW4ubWFuZ2VAc21p
bGUuZnI+DQo+IC0tLQ0KPiB2MS0+djI6DQo+ICogTW9yZSBjb21wcmVoZW5zaXZlIHRlc3QgY2Fz
ZXMgd2l0aCA9LCA/PSBhbmQgPz89IGNvbWJpbmF0aW9ucw0KPiAtLS0NCj4gIGxpYi9iYi90ZXN0
cy9wYXJzZS5weSB8IDQxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
DQo+ICAxIGZpbGUgY2hhbmdlZCwgNDEgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2xpYi9iYi90ZXN0cy9wYXJzZS5weSBiL2xpYi9iYi90ZXN0cy9wYXJzZS5weQ0KPiBpbmRleCA1
NmViNjZiZTkuLjM4YzNlMzI1MyAxMDA2NDQNCj4gLS0tIGEvbGliL2JiL3Rlc3RzL3BhcnNlLnB5
DQo+ICsrKyBiL2xpYi9iYi90ZXN0cy9wYXJzZS5weQ0KPiBAQCAtNzUsNiArNzUsNDcgQEAgdW5z
ZXQgQltmbGFnXQ0KPiAgICAgICAgICBzZWxmLmFzc2VydEVxdWFsKGQuZ2V0VmFyRmxhZygiQSIs
ImZsYWciKSwgTm9uZSkNCj4gICAgICAgICAgc2VsZi5hc3NlcnRFcXVhbChkLmdldFZhcigiQiIp
LCAiMiIpDQo+IA0KPiArICAgIGRlZmF1bHR0ZXN0ID0gIiIiDQo+ICtBID0gInNldCB2YWx1ZSIN
Cj4gK0EgPz89ICJkZWZhdWx0IHZhbHVlIg0KPiArDQo+ICtBW2ZsYWdfc2V0X3ZzX3F1ZXN0aW9u
XSA9ICJzZXQgZmxhZyINCj4gK0FbZmxhZ19zZXRfdnNfcXVlc3Rpb25dID89ICJxdWVzdGlvbiBm
bGFnIg0KPiArDQo+ICtBW2ZsYWdfc2V0X3ZzX2RlZmF1bHRdID0gInNldCBmbGFnIg0KPiArQVtm
bGFnX3NldF92c19kZWZhdWx0XSA/Pz0gImRlZmF1bHQgZmxhZyINCj4gKw0KPiArQVtmbGFnX3F1
ZXN0aW9uXSA/PSAicXVlc3Rpb24gZmxhZyINCj4gKw0KPiArQVtmbGFnX2RlZmF1bHRdID8/PSAi
ZGVmYXVsdCBmbGFnIg0KPiArDQo+ICtBW2ZsYWdfcXVlc3Rpb25fdnNfZGVmYXVsdF0gPz0gInF1
ZXN0aW9uIGZsYWciDQo+ICtBW2ZsYWdfcXVlc3Rpb25fdnNfZGVmYXVsdF0gPz89ICJkZWZhdWx0
IGZsYWciDQo+ICsNCj4gK0FbZmxhZ19kZWZhdWx0X3ZzX3F1ZXN0aW9uXSA/Pz0gImRlZmF1bHQg
ZmxhZyINCj4gK0FbZmxhZ19kZWZhdWx0X3ZzX3F1ZXN0aW9uXSA/PSAicXVlc3Rpb24gZmxhZyIN
Cj4gKw0KPiArQVtmbGFnX3NldF9xdWVzdGlvbl9kZWZhdWx0XSA9ICJzZXQgZmxhZyINCj4gK0Fb
ZmxhZ19zZXRfcXVlc3Rpb25fZGVmYXVsdF0gPz0gInF1ZXN0aW9uIGZsYWciDQo+ICtBW2ZsYWdf
c2V0X3F1ZXN0aW9uX2RlZmF1bHRdID8/PSAiZGVmYXVsdCBmbGFnIg0KPiArDQo+ICtBW2ZsYWdf
c2V0X2RlZmF1bHRfcXVlc3Rpb25dID0gInNldCBmbGFnIg0KPiArQVtmbGFnX3NldF9kZWZhdWx0
X3F1ZXN0aW9uXSA/Pz0gImRlZmF1bHQgZmxhZyINCj4gK0FbZmxhZ19zZXRfZGVmYXVsdF9xdWVz
dGlvbl0gPz0gInF1ZXN0aW9uIGZsYWciDQoNCkkgd291bGQgbGlrZSB0byBzdWdnZXN0IHRoYXQg
eW91IGFkZCB0ZXN0cyB0aGF0IHZlcmlmaWVzIHRoZSBiZWhhdmlvciB3aGVuIA0KdGhlIHNhbWUg
b3BlcmF0b3IgaXMgdXNlZCB0d2ljZSwgZS5nLjoNCg0KQVtmbGFnX3NldF90d2ljZV0gPSAic2V0
IGZsYWcgZmlyc3QiDQpBW2ZsYWdfc2V0X3R3aWNlXSA9ICJzZXQgZmxhZyBzZWNvbmQiDQoNCkFb
ZmxhZ19xdWVzdGlvbl90d2ljZV0gPz0gInF1ZXN0aW9uIGZsYWcgZmlyc3QiDQpBW2ZsYWdfcXVl
c3Rpb25fdHdpY2VdID89ICJxdWVzdGlvbiBmbGFnIHNlY29uZCINCg0KQVtmbGFnX2RlZmF1bHRf
dHdpY2VdID8/PSAiZGVmYXVsdCBmbGFnIGZpcnN0Ig0KQVtmbGFnX2RlZmF1bHRfdHdpY2VdID8/
PSAiZGVmYXVsdCBmbGFnIHNlY29uZCINCg0KLy9QZXRlcg0KDQo+ICsiIiINCj4gKyAgICBkZWYg
dGVzdF9wYXJzZV9kZWZhdWx0dGVzdChzZWxmKToNCj4gKyAgICAgICAgZiA9IHNlbGYucGFyc2Vo
ZWxwZXIoc2VsZi5kZWZhdWx0dGVzdCkNCj4gKyAgICAgICAgZCA9IGJiLnBhcnNlLmhhbmRsZShm
Lm5hbWUsIHNlbGYuZClbJyddDQo+ICsgICAgICAgIHNlbGYuYXNzZXJ0RXF1YWwoZC5nZXRWYXIo
IkEiKSwgInNldCB2YWx1ZSIpDQo+ICsgICAgICAgIHNlbGYuYXNzZXJ0RXF1YWwoZC5nZXRWYXJG
bGFnKCJBIiwiZmxhZ19zZXRfdnNfcXVlc3Rpb24iKSwgInNldCBmbGFnIikNCj4gKyAgICAgICAg
c2VsZi5hc3NlcnRFcXVhbChkLmdldFZhckZsYWcoIkEiLCJmbGFnX3NldF92c19kZWZhdWx0Iiks
ICJzZXQgZmxhZyIpDQo+ICsgICAgICAgIHNlbGYuYXNzZXJ0RXF1YWwoZC5nZXRWYXJGbGFnKCJB
IiwiZmxhZ19xdWVzdGlvbiIpLCAicXVlc3Rpb24gZmxhZyIpDQo+ICsgICAgICAgIHNlbGYuYXNz
ZXJ0RXF1YWwoZC5nZXRWYXJGbGFnKCJBIiwiZmxhZ19kZWZhdWx0IiksICJkZWZhdWx0IGZsYWci
KQ0KPiArICAgICAgICBzZWxmLmFzc2VydEVxdWFsKGQuZ2V0VmFyRmxhZygiQSIsImZsYWdfcXVl
c3Rpb25fdnNfZGVmYXVsdCIpLCAicXVlc3Rpb24gZmxhZyIpDQo+ICsgICAgICAgIHNlbGYuYXNz
ZXJ0RXF1YWwoZC5nZXRWYXJGbGFnKCJBIiwiZmxhZ19kZWZhdWx0X3ZzX3F1ZXN0aW9uIiksICJx
dWVzdGlvbiBmbGFnIikNCj4gKyAgICAgICAgc2VsZi5hc3NlcnRFcXVhbChkLmdldFZhckZsYWco
IkEiLCJmbGFnX3NldF9xdWVzdGlvbl9kZWZhdWx0IiksICJzZXQgZmxhZyIpDQo+ICsgICAgICAg
IHNlbGYuYXNzZXJ0RXF1YWwoZC5nZXRWYXJGbGFnKCJBIiwiZmxhZ19zZXRfZGVmYXVsdF9xdWVz
dGlvbiIpLCAic2V0IGZsYWciKQ0KPiArDQo+ICAgICAgZXhwb3J0dGVzdCA9ICIiIg0KPiAgQSA9
ICJhIg0KPiAgZXhwb3J0IEIgPSAiYiINCg==

