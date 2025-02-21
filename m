Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5C5C021B5
	for <webhook@archiver.kernel.org>; Fri, 21 Feb 2025 16:40:45 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.76])
 by mx.groups.io with SMTP id smtpd.web10.27686.1740156040850414831
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Feb 2025 08:40:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=V4uSQg4C;
 spf=pass (domain: siemens.com, ip: 40.107.21.76, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DNcE7iE2GXx9Sqrqg8xaIVdpLe/VnXfeN7YP79rAHAhyTCdEK84dVdBJnoWAkoUPMpLM4ItaSfDEr8jM4NqgC93/961NNMRORrXz//XJ+KSfTf7rd04h1HCun95sHSnpMbVZLFTnr07HKnKu3xQCagHdgIC+SZKdwZZ05jfRqN0qTlx4K6aZptjEY82rKi6+exIZfGhLK8eCJfmRagOuEJ2QKXbsRNdCG+DCgjjzJhVIWM+Ovza/WrDY2JpovulAnKbXgJdqT9dEEWgbUaFVXm7SDn2JVVTsRc3nHEsKZUkiAfHDJAqzzIWdu9dynIMQsICtldOrO3/jQsMm9t8gWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iv468Za0DK9P6XF527ooac7r0jPhYt4SARPx4q7SqZE=;
 b=ec+EX8/hYzmQmK/BRsWkyjtj2WaF0km7ktFnsf+Vfz8SpVRee4facmzTLOQ3icSXuIP1tpdrFhi+uUnLEp2T2tq7qQ/M8Ivh6sxDpMpH2LAOsbVk1ATzz+12R9adgiBtBNrV0NHmYXu6OObyvRpITOLUQ5qpvXL9PZStqqZubfSO67dY4j82rhOi4o4FiMd/u9Qls+e7xBEmb8mC4FT5f6zLDTt8pv7qPL7g6YhjqDbd+oEf6fG+M1ya8Zb+9ydPKzdqbZAORSL3gTA8DN5nNUtDi39ldrzfUsqgqtgB6XrvayMzKbvACGb7YLi37M7+o9TqGSRXmVypaS78/WPUAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iv468Za0DK9P6XF527ooac7r0jPhYt4SARPx4q7SqZE=;
 b=V4uSQg4Cvgtapee/vwZXBcQyFfIPUh1TFx15rIEyKaeAnazqbwbElOJ4uXaoooZT6T/lwmo/AtbUSvPMsJQlsABOtERg6V+D+VHKKV6elE2dkJzvrz8dpC7dqsdYDDWqRem/QlgS/XyFJo/NySmgz3QGArfBJM2+KhmgiFCBbX0SmbRdm2DkQkm71MCsUARJtYTBOccWNXbhIGYGRW3+74L4o/Hpbqf1QDoOc9UrILkzbDvvYguY+07P13UjvabXvNYMKp2WnealxlNcRXgsn7WHrNbOcd0BGJhfGH3buTnoLgxzb9FKv6CF8cp2b84XDRW53WMY2DXZ0ckPzsWRyw==
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by DB8PR10MB3831.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:16b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 16:40:36 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%6]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 16:40:36 +0000
From: "Koch, Stefan" <stefan-koch@siemens.com>
To: "richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: "Sudler, Simon" <simon.sudler@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "alex.kanavin@gmail.com" <alex.kanavin@gmail.com>
Subject: Re: [PATCH v3 1/4] fetch2/git: Add support for fast initial shallow
 fetch
Thread-Topic: [PATCH v3 1/4] fetch2/git: Add support for fast initial shallow
 fetch
Thread-Index: AQHbg7ywZJqt9JvQhESFPikUXBi+bLNRaFSAgACO24A=
Date: Fri, 21 Feb 2025 16:40:36 +0000
Message-ID: <bad4317dc354af35db542247fd5c75071f20da85.camel@siemens.com>
References: <20250220172706.3850722-1-stefan-koch@siemens.com>
	 <4b9fe64e0fd32de42dfa605be5e3e76b8dd01a58.camel@linuxfoundation.org>
In-Reply-To: 
 <4b9fe64e0fd32de42dfa605be5e3e76b8dd01a58.camel@linuxfoundation.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR10MB4959:EE_|DB8PR10MB3831:EE_
x-ms-office365-filtering-correlation-id: a7a344ba-62f7-4db8-7442-08dd529677e3
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?QjRaaVZHSmIwRDV4Snk1ZXN1YkE4YlhzSTl0NkdCOGVObU1MSGVCMHllclBU?=
 =?utf-8?B?ZGVTOXMxRHNLeVU3K3U5VmN3MFplTzdxNDlGblpTeVk3TFlUK09RQlA4SFRT?=
 =?utf-8?B?SVo4dGJiUUsyUXVWbC8yYTNtbEYxdE0vMm1WOG8yNTNhYXNlb3JVcmlrdDM4?=
 =?utf-8?B?RU5pRTBKQ3B3dG1xb2svcDFvRmxtL2luUjZSdjh2UzZ1a3h5RkJQbjZNQUti?=
 =?utf-8?B?RnpYKzZ6MzJlNHJtN3VBZGY0NjN1MDlWd3N3T3dDZTdXa2NxcENhK1QwNEx6?=
 =?utf-8?B?Y1F3NFd6MDZRS04yUzVhQUE4c0xBSmZuMSt5MzdLak5OSktPcFRmbXZnNDJX?=
 =?utf-8?B?QnN1UkVicTF5aitSTzBSZ3lySk0wNVVzTE44UlgyMU9HVzZhK2tXOXFkbTdD?=
 =?utf-8?B?ODBlazBHNzh1Qks1SE1aZGZWTkRrWlJxa3ZkZjI5N2RDeEpNWGlYdUUyanNJ?=
 =?utf-8?B?L1U0ZDBScjA2ekNTTUVVTEhDMi8yM1NMc2Qvak9zaGRxdWJNcmZ6UWpMb05W?=
 =?utf-8?B?WG5ZRnpKbTN5ZVBhTHBzbkxrbXA1SWNQaEg1bkQ3RDJNK1N0RUx2aUJjck9U?=
 =?utf-8?B?d2FLL05wckRyd052aWtCYStXcDRienNSSS9acE1hV2xVZTBTYTZ6WWNRZTBD?=
 =?utf-8?B?QUVsZnkvUWtPTHZTa295MDhkWWo2cStBaFlBdkt5TTdEMnJWTjNZRkNUem8y?=
 =?utf-8?B?MktmRVdOWFlNbnl6U1Bha0REWDZSai9nNG0xeDN5SnZwMEpEN256RTFIVTlj?=
 =?utf-8?B?aUY5c3p0YWt5dGZHWGVybVVvWDBZd0VZUmJZbTQzOXNhR29XdVFQOXlaWlA4?=
 =?utf-8?B?YW1qbnB3K0FvM2dXY2hDZE5CNTZJWWRJNGtZR2RSbzlobzdhaE5qSnE5V1By?=
 =?utf-8?B?ZldKTkhDLzB2VVIza0ZqZW5tRURBZzlRc2g0bU95RFVmZ1Y0QkpwRUE2OG1j?=
 =?utf-8?B?TmtGcHpIamhBcHBoWHl0ajRIeHFWQ1hDVlFEMGNEQ01kS0pWc3A4dmVDVUNj?=
 =?utf-8?B?TlM4Yzdaa05CVkJ0SCtnTUhlSElia2svZnZ2U2RpQk93cDVIU1JLWWxPWkxm?=
 =?utf-8?B?VXBxbDhJSFZvcVY4REZpZDE1K1k5dkpWRnVOdHQ1Z2Vsd1ZlbU1xYjl6Q1lh?=
 =?utf-8?B?M3VDV3hTZ0dXZWVEZkF2SmJXY2ZBY3ZQZm1vWitjMjNpcUlmU3VNMUZxblNF?=
 =?utf-8?B?MmMrd0dVOUh3Sk5XcWlFM0lneUZIemdlWGl2VnF4YVRldVhCTlRZUFJCSVBE?=
 =?utf-8?B?NXhyUkljOVhkMkNoa01FN0dzVEhHWmJzWXV6QmFDOURRaHpMWktnT1lDait1?=
 =?utf-8?B?RTlwdjBKTjVsdVQ1bEdJcFZCY255NjVESlErbHNWUkltalhuYkprN0ZETFd4?=
 =?utf-8?B?bHI0T2JNV0xHK21NaVZZUVFRUUpZc3Jyb3VWMkN3VWRwTXByNWFhdkhmbDEv?=
 =?utf-8?B?SGFpU283SXZiKzNhVG50cVVXQUpCT3o3RWV6UDR6RkpSdGZmdHlmWFZxMnNC?=
 =?utf-8?B?aCtsdHYxZ1IyYjFLRmlmOWE3L2ZVVlFqUEtpK0NZM1RISnNkdnFjZ0lLWlFM?=
 =?utf-8?B?UmlmVzYydlFaWEtvV005SlVuME1aRWQ1akE4Yk0zWEhiVWNwSlRBMVBZb1Fh?=
 =?utf-8?B?bUtHb21tVVJmRkxuZ1BLZlp4VVFqY1Q3VEptbCtlSEx2NXZHYWs3eEg2ZldB?=
 =?utf-8?B?R2srck12TXFzeXBhSTVxYW1tTFpqNjFwcTM1cHhYMFRKdTVwYnovZWswZjBU?=
 =?utf-8?B?N1RaNkdFTHpBNDViZDlGTC9sWlFvVWtnWlVHVWV5eXNIVkN0TXZSSy8xU0hD?=
 =?utf-8?B?NmFtUW5ENUduMnN2Z29JQytuQ29hMEc1b1pQaXcwQTZGbjhIZGNYYk5idklx?=
 =?utf-8?Q?yZakhmnJn65xy?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ai8yaGY4Z3dCZXcvYVZ4czVJUEZQSFpjd1dTYnN5bFV6djdXdzF3Z205YnpW?=
 =?utf-8?B?MnlJNzc5UnRkZVduZktzZHhBOTFBT2g4Rjd4OTdvYUswaHlxMTZwNG56bVE5?=
 =?utf-8?B?VzVNSUxUWHlNRS9YbHRVaVFxNDMzYnk2dHI3TjRXV3BCdlBQdzI0UUdHampR?=
 =?utf-8?B?VGJ5bkJEYVNpL1lwdXZqNjlPNTNWWVlXdEdaQzJabFJaK1JNeGxQZUxvWjVT?=
 =?utf-8?B?UkFHaGg5SEYrNXFnYWZnN1RJczNJdHFDYnM1ZXZONkNVTWJJamp6WGVZNDl1?=
 =?utf-8?B?TzBLdEVnTmxhU0huQThvOVBrcER3c2RsY0NKa3Y4V05qaUJpK2NXMklZNHh0?=
 =?utf-8?B?T0YyTlBwSElzbTNHVm4wS2laMXR0dTBmeHJPbEdCYlA5TUJmQ1Uza3lsNnFq?=
 =?utf-8?B?S1E5Z0RIeGovSm11eHZBMGh4NG5LRTRsQWVObTdRVDBXUFVTcHVkOGJ6SHZz?=
 =?utf-8?B?VzhJZWRXaEVNTThwWWVQT0tvT3RURWp5OUZtTEFicWlSQlAzNHN6VVcyaWhV?=
 =?utf-8?B?blQ4bmh3VEhJck1OQXBpVUtkM3V4eWpSbWpkcS9oSkpKMkNwWkF0NzNSaEVJ?=
 =?utf-8?B?MWd4SmhsbU9sRmJQS1hYbWhVVVlXcXNKaThleVgxdUw4bUt5TFQ3cTRYUjc5?=
 =?utf-8?B?bkpBQ0tMYldzZS91Z2RibmhHZ21VV01tSFRoL3hwdUtNQU9taGtaMndnaklw?=
 =?utf-8?B?V3lDdDJuZTZTdmU3WGpTWm5mb2Q3M1BUQnNlR0M2UVZJZUliYWozY3o1VjBi?=
 =?utf-8?B?Umk5cjN0YWNuUlgxeVJybTZGdEJZNFpvVDIxNmRHTWdHbi9HYUJ6V0dsQkk3?=
 =?utf-8?B?Y050QW9iQjFnV1Z3Q0xlcERDTWNLK0VyS2pqTW5peGdHQVNxY3ZQb3VTK3VH?=
 =?utf-8?B?OHFDWExtUlhsM3d0Q0NHeExLTEh2dnZ3a0N6Mml2SUJGdXliRy9EdFB3ZGtO?=
 =?utf-8?B?MnFKdSsrdE5Od1FWZGgrTWhKVzBvN2xUcVJjaGM5WE1RYktXMnMwL29sRGZp?=
 =?utf-8?B?L0hDZmlqOUppNkVJY0l3UHQ5S2I1MTNMQWdTU1JKcmt2MklBRE1nZ2ZFV0V2?=
 =?utf-8?B?MlhDcVB3a0g1eXFaUmNQejdqejV1b3dnMkpOaHpVZ2xLSW9nS3NwODhOUkZK?=
 =?utf-8?B?V29xVGd2YU96cEk5QmpOblhmUVQ4UE84RnRIdVAyVGpkaGVpYnlJTXdMaWJE?=
 =?utf-8?B?Q1BCOWtGRnFFb1kyZHhLa2Uva2lvV0RiVnllUDU4L0Z1bjN1cFZaR2pkVUpk?=
 =?utf-8?B?ZHIvUVpyR2pYaFBpSS9MRWp1bk5RcXBZbG5UNmVWeWc3amJ0ZUp0V0dtd0hM?=
 =?utf-8?B?WktnVERpV3JMZW82dVQ1UkY4djZUS2Q2MUs0UDlLSjVDTDlBbnpWR1RvWGZi?=
 =?utf-8?B?WUVZL1IxdFNOeXk1bTRMbHhldDVxbk02ZFM5ajRyMC9Ob0R1Z3ZTU25IeG41?=
 =?utf-8?B?NEwweXNtaTVLTUpPZHJwNzI0dkp4Yml6MkJuTnNQbnZyL1I0N05FR1dwcUM2?=
 =?utf-8?B?UE4wTm9oNkNjaWpZbGppZUV3eTh4Ni9VRHhMYVorbzYybFlpRHV2ZkEyc09y?=
 =?utf-8?B?cU5WRHlTQ1ByaVJscWtFdEVaNG10VU05L3R2anBBYTUwU2d3NXZNZUd0VDB3?=
 =?utf-8?B?ZmZ3R29UY3FGVzNMSytMNWdlaWpOTWE1ZnBRMXduVU13UkwyVjBUeW1hZkQw?=
 =?utf-8?B?Ty96YldRNUloQ2lZeWJSNkhTMzBQczdDY1paVnB1aU1hNE5uTFpBNzI0bU5i?=
 =?utf-8?B?K1pRbTJLejUxUGRaVWVtVytwakJlVHBraDJIYlVPN2VFTCttdG1manhyK1dG?=
 =?utf-8?B?aW5sS1FHVGpnN1YySzVQZm5YdzdITzcxaXFXRWVpT282TTZKU0RINkNic2Fr?=
 =?utf-8?B?MWJuMUdjUmczblBudW5xOVJMcTFtdktSSHVQLzF2OGJVY201bUptcERuNC93?=
 =?utf-8?B?eVpWQi9JK01jTThPeDlSV2RLa0hQWTJmNGNiRTN0T3lGdHVjV2VIVWxkNysv?=
 =?utf-8?B?K3dYQUdhMy9Zd1hmVXJnblhTMUlqNGs1NkROL0w4VlVXSGRHWS9hc2E0d2lF?=
 =?utf-8?B?K2lnMDhZZUZRT095OWdlbTkwUGl3UnNrMGV4K29LTk04d0cyWWkwOVlmd3dM?=
 =?utf-8?B?YTFNS25uY3dET3NCNGxJeFpHdGlHenpMMGdBanVwMW5XaFFnMlAvbG5FSEJw?=
 =?utf-8?B?SWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED7D9C556D065E42954E39A82B1A83AF@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a344ba-62f7-4db8-7442-08dd529677e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 16:40:36.6056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /OQ8vs86TOJutBS5wE0szFdp6suSdivnQxN5n4hSJ1LZxbkfDzad7NOa42dWUQ6Iio1VITnQTsjQOXiwEayvsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3831
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Feb 2025 16:40:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17281

T24gRnJpLCAyMDI1LTAyLTIxIGF0IDA4OjA5ICswMDAwLCBSaWNoYXJkIFB1cmRpZSB3cm90ZToN
Cj4gT24gVGh1LCAyMDI1LTAyLTIwIGF0IDE4OjI3ICswMTAwLCBTdGVmYW4gS29jaCB3cm90ZToN
Cj4gPiBXaGVuIGB1ZC5zaGFsbG93ID09IDFgOg0KPiA+IC0gUHJlZmVyIGFuIGluaXRpYWwgc2hh
bGxvdyBjbG9uZSBvdmVyIGFuIGluaXRpYWwgZnVsbCBiYXJlIGNsb25lLA0KPiA+ICAgd2hpbGUg
c3RpbGwgdXRpbGl6aW5nIGFueSBhbHJlYWR5IGV4aXN0aW5nIGZ1bGwgYmFyZSBjbG9uZXMuDQo+
ID4NCj4gPiBUaGlzIGltcHJvdmVzOg0KPiA+IC0gUmVzb2x2ZSB0aW1lb3V0IGlzc3VlcyBkdXJp
bmcgaW5pdGlhbCBjbG9uZXMgb24gc2xvdyBpbnRlcm5ldA0KPiA+IGNvbm5lY3Rpb25zDQo+ID4g
ICBieSByZWR1Y2luZyB0aGUgYW1vdW50IG9mIGRhdGEgdHJhbnNmZXJyZWQuDQo+ID4gLSBFbGlt
aW5hdGUgdGhlIG5lZWQgdG8gdXNlIGFuIEhUVFBTIHRhcmJhbGwgYFNSQ19VUklgDQo+ID4gICB0
byByZWR1Y2UgZGF0YSB0cmFuc2Zlci4NCj4gPiAtIEFsbG93IFNTSC1iYXNlZCBhdXRoZW50aWNh
dGlvbiAoZS5nLiBjZXJ0IGFuZCBhZ2VudC1iYXNlZCkgd2hlbg0KPiA+ICAgdXNpbmcgbm9uLXB1
YmxpYyByZXBvcywgc28gYWRkaXRpb25hbCBIVFRQUyB0b2tlbnMgbWF5IG5vdCBiZQ0KPiA+IHJl
cXVpcmVkLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogU3RlZmFuIEtvY2ggPHN0ZWZhbi1rb2No
QHNpZW1lbnMuY29tPg0KPiA+IC0tLQ0KPiA+ICBsaWIvYmIvZmV0Y2gyL2dpdC5weSB8IDEwMCAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0NCj4gPiAtLS0tDQo+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCA3NCBpbnNlcnRpb25zKCspLCAyNiBkZWxldGlvbnMoLSkNCj4NCj4gSW4g
dGVzdGluZyBpdCBsb29rcyBsaWtlIHRoaXMgc2VyaWVzIGhhcyBzb21lIGlzc3VlIG9uIFVidW50
dSAyMC4wNA0KPiBzeXN0ZW1zIChib3RoIHg4Nl82NCBhbmQgYXJtKToNCj4NCj4gaHR0cHM6Ly9h
dXRvYnVpbGRlci55b2N0b3Byb2plY3Qub3JnL3ZhbGt5cmllLyMvYnVpbGRlcnMvMjMvYnVpbGRz
LzEwOTcNCj4gaHR0cHM6Ly9hdXRvYnVpbGRlci55b2N0b3Byb2plY3Qub3JnL3ZhbGt5cmllLyMv
YnVpbGRlcnMvNTQvYnVpbGRzLzEwMTYNCj4NCj4gVGhpcyBpcyBwcm9iYWJseSBkdWUgdG8gdGhl
IHZlcnNpb24gb2YgZ2l0IHRoZXJlLi4uDQoNClRoaXMgaXNzdWUgY291bGQgb2NjdXIgaW4gdHdv
IGNhc2VzOg0KYSkgb2xkIEdpdCBjbGllbnQgdmVyc2lvbg0KdGhpcyBjb3VsZCBiZSByZWxldmFu
dDoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2dpdC8xNjMwNDk2NDY3ODgxLjIwMzA0MzkwNDku
NDI0NzI1MzU1MUB2aXZhbGRpLmNvbS9ULw0KDQpiKSBHaXQgc2VydmVyIHZlcnNpb24sIHRoYXQg
aGFzIGRpc2FibGVkIGFubm91bmNlbWVudHMNCnNlZToNCmh0dHBzOi8vc3VwZXJ1c2VyLmNvbS9x
dWVzdGlvbnMvMTM0MjU0Ny91bmFibGUtdG8tZmV0Y2gtcGFydGljdWxhci1jb21taXQtaGFzaC1m
cm9tLWdlcml0LWVycm9yLXNlcnZlci1kb2VzLW5vdC1hbGxvdy1yDQoNClNvLCBJIGhhdmUgcmVp
bnRyb2R1Y2VkIHRoZSBzd2l0Y2ggZnJvbSB2MiBwYXRjaCB3aXRoIGludmVyc2UgbG9naWMuDQox
LiBlbmFibGVkIGJ5IGRlZmF1bHQNCjIuIG9sZCBiZWhhdmlvdXIgY2FuIGJlIGZvcmNlZCBieSB2
YXJpYWJsZQ0KMy4gb2xkIGJlaGF2aW91ciBpcyB0cmlnZ2VyZWQgYXV0b21hdGljYWxseSBpbiBt
ZW50aW9uZWQgZmFpbHVyZSBjYXNlDQooc2VlIGFib3ZlKQ0KDQpJJ2xsIHNlbmQgdXBkYXRlZCB2
NCBwYXRjaCBzZXJpZXMuDQo+DQo+IENoZWVycywNCj4NCj4gUmljaGFyZA0KDQpUaGFua3MsDQpT
dGVmYW4gS29jaA0KU2llbWVucyBBRw0KaHR0cDovL3d3dy5zaWVtZW5zLmNvbS8NCg==

