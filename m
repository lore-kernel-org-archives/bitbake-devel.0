Return-Path: <pascal.eberhard@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AECF01812
	for <webhook@archiver.kernel.org>; Fri,  6 Mar 2026 08:40:11 +0000 (UTC)
Received: from de-smtp-delivery-123.mimecast.com (de-smtp-delivery-123.mimecast.com [194.104.109.123])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.65553.1772786408433268776
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 06 Mar 2026 00:40:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@se.com header.s=mimecast20240503 header.b=BZdmfG0k;
 spf=pass (domain: se.com, ip: 194.104.109.123, mailfrom: pascal.eberhard@se.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=se.com; s=mimecast20240503;
	t=1772786406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n1a9syBgqtjZAzAjnLiZ7wJvxv5AM9L6Vi5lW/osBPA=;
	b=BZdmfG0kqgXYgehB/L7kSaHqYDrkDSjYMcXMk6h8IYaPUQEbuSeJbeqi/5dl91QYT8+B4b
	5YkHXQy6+tkemSaw6bHZ1OQYP8y7bt5Gm05ETfykgUphrm8+WL5mVj8cYpKqpZpACIAVzO
	K5/gimjOi07g9nexmP+VrzrcF8HWQcwt3zbxx3SJ8zZpv08p/CMY3aIdsjI3FQceX0CJ41
	DvuPHx1Te1iPxXb+qGMAKpzpeL+tV76bF3jxvkCp72nHK1KF4b4rgaKB7zXVLnYzpheZEL
	XBD2aHxxm58O9P3pLs95ewmafimDXHfQtG+noen5LnYIVOFMo7okWZtJA+cZqg==
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013029.outbound.protection.outlook.com
 [52.101.72.29]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 de-mta-93-oIKjhoVHOLeJpv9IzCdVQw-1; Fri, 06 Mar 2026 09:40:05 +0100
X-MC-Unique: oIKjhoVHOLeJpv9IzCdVQw-1
X-Mimecast-MFC-AGG-ID: oIKjhoVHOLeJpv9IzCdVQw_1772786404
Received: from DU0PR04MB9657.eurprd04.prod.outlook.com (2603:10a6:10:31c::22)
 by AM0PR04MB7187.eurprd04.prod.outlook.com (2603:10a6:208:196::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 08:40:03 +0000
Received: from DU0PR04MB9657.eurprd04.prod.outlook.com
 ([fe80::fba9:66b3:49ad:de2c]) by DU0PR04MB9657.eurprd04.prod.outlook.com
 ([fe80::fba9:66b3:49ad:de2c%6]) with mapi id 15.20.9678.016; Fri, 6 Mar 2026
 08:40:03 +0000
From: Pascal EBERHARD <pascal.eberhard@se.com>
To: Paul Barker <paul@pbarker.dev>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH 0/4] fetch2: add alternative fetch method
 based on curl
Thread-Topic: [bitbake-devel] [PATCH 0/4] fetch2: add alternative fetch method
 based on curl
Thread-Index: AQHcrLVFwChq/+SM5Uy6Id72hiZdRLWgPPUAgADqJ9Y=
Date: Fri, 6 Mar 2026 08:40:03 +0000
Message-ID: <DU0PR04MB96571582DCECCB5CD7B9D2048E7AA@DU0PR04MB9657.eurprd04.prod.outlook.com>
References: <20260305-add_alt_fetch_method_curl-v1-0-0d0220e5fa59@se.com>
 <908075bc2ccd5263264d7e7602bb8af3f129e4a4.camel@pbarker.dev>
In-Reply-To: <908075bc2ccd5263264d7e7602bb8af3f129e4a4.camel@pbarker.dev>
Accept-Language: fr-FR, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_57443d00-af18-408c-9335-47b5de3ec9b9_Enabled=True;MSIP_Label_57443d00-af18-408c-9335-47b5de3ec9b9_SiteId=6e51e1ad-c54b-4b39-b598-0ffe9ae68fef;MSIP_Label_57443d00-af18-408c-9335-47b5de3ec9b9_SetDate=2026-03-06T08:40:02.849Z;MSIP_Label_57443d00-af18-408c-9335-47b5de3ec9b9_Name=General;MSIP_Label_57443d00-af18-408c-9335-47b5de3ec9b9_ContentBits=1;MSIP_Label_57443d00-af18-408c-9335-47b5de3ec9b9_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9657:EE_|AM0PR04MB7187:EE_
x-ms-office365-filtering-correlation-id: a299aa82-52cb-4c34-0c2f-08de7b5bf619
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021
x-microsoft-antispam-message-info: SNXqAGfYo71YuvMeHNoce1BB91cX1dNKcue/y9JBK2d12XTQLU2jFEcYTf9mSAKIH1/8taOkbz8wS0/m0VkEFwzUhj20Sq3+HtELxTXR10/+QdE8jpUQINiQLf3csYjvdzMlJUKLkyeYGtrNKtwjyVYUTgV5h8naoreeYzThHDANCwKs7pPDYOb7or4OzV3K5KFIgfRDRLO8hCoO85JJ4HsIg5gQb6XfCoAg7nBFY09XuOhrWGwbqyCaUQ9D4jF9a6GdoURyXWYU+qBzcfipKQohM7NfSUVJHfbG5WbaXoTW2kDP9JKSos2TVl60QybwG6tQXVZ1+dV8gJ23Dk13EdDrYpiTEIQpyVJe9v02wuIvxJfVIO0c8CxH3NUG13Xf2oo+8ZfIJbpwmuGB3XTBD20eDsdYaOEvZXITnf/x7jP0QkLrf5SVruXQ/vMhO5wmayR2lPiuZ5rlUTg/g9QUMQt4ff5VWbUd2nJHeeC2zEABdQiMEUx2f8oduZt+UEfZRPku5OxsomXD14GlrEU9fD80NBPKrqF1J76Zy9ATAd7arGM2/PWvogHbrw5Jq5pjS7P48t9kEvGh6G8Y2Kht988NSOs8/YjnwSYt9DJQXoXkw2HIOzO6+J7Ix1imXz3ZtcWWLo6JPitLfVxuNcJv7yy/6YE/l51BEtVP0MLUsQPA4US/Nihce/SZhII7dLuaW0YbQzimsZKUWULI6d9pfGmYHqmrujeiTcv8e4t989Ax0zHlbl8GiXFjnItaCSM6SGflpRzLqHoX8nplhoBKUv74W2Y1y1u48ahTXE2CidQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9657.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmFDM1pmMnFIYmJLblhrV0dxME16SDVPYVU2RHVudWlETE5ubjN3Vzc0VlQx?=
 =?utf-8?B?UDVZQlJvSDFZUzNzZzR0ZW9MNGVmRm51L1FXWVRRNG92ZW9EYy8wUm5taTFK?=
 =?utf-8?B?VDF3QjMxcWoyUS9kN1pGTFlPMTBidi9RcFZObjhLLzhrSEVzR0NBbGMrdU0y?=
 =?utf-8?B?Z3VuVE9rcXlSUlBlVVFDK01pTmdldGRtb3VJUGVjMDM1anRxdlF0amRmTGdn?=
 =?utf-8?B?WHZ6bnozZkNkZmRsV0JsOGUxalNsbzVKZWJOcjRWYlN3Z3dVOHhDL3JOVVBa?=
 =?utf-8?B?NXNGUUFVNXRMWlJXNHdZUEtwY2tNajU1UFJLTjF6TlZnR05mSWtiSnMwSVJH?=
 =?utf-8?B?Z2J2S3NKK0NWMG4vRlY2ZEdYVXNnUzFYNWZjSGJ4WHQ5L05paFdRRWhYcThN?=
 =?utf-8?B?eTVSeHpaMngzelk0V1VpQUVrTHFvOHRTa2VJVVF5SzVtVTBCSzhhc1lvQU5D?=
 =?utf-8?B?bnYraWZkblZDTXg5NkQwRWR5RVE1S1U4MnJCaGtBdjdlSGhZdGtLaEhmQVAy?=
 =?utf-8?B?dXdBY3BUczRkSDJlWGdOc1lhM2NITjNER3VjRUdPejNQdG9XaTZoeXdpa2dV?=
 =?utf-8?B?V0VOYUxuaDRjTlBZSEo0aC9NUno5T25IZlRzYkUwcGJCSlFxVU5NMzVBc203?=
 =?utf-8?B?NkNRZHdQN1VJR3RHd2NObW5zaDRHMHdMWGJvWUQwR3ZBS3M5c3NNRWhKb3Rz?=
 =?utf-8?B?RUc1WGUyS3gwMmhoUytaVFpXSWxhbmhyN3FNZTlBVzVURGpwaTJtRkFzdzZY?=
 =?utf-8?B?WTJKb0pDQk92YmRhcEJ4RUNEVWg4Sm1FTVFBOVVVNEhQZ1hBSDZod3AySnEx?=
 =?utf-8?B?K25vUVRWZG9nUDJhTHFUdFNqZjlaZkNNOEdiYmZzY3FPM0lhRHVSY0NKQnUx?=
 =?utf-8?B?UGtDNXQvMWIyWitDTGdCY2RPb0hINUJ6Z09uMUJFVVZacWtuc3JZRVVSRENV?=
 =?utf-8?B?RVVOS24yaTlpbzNMcVN3R2h0UStsUVRnK0lValBEanl2N1dIOVdEM2RicDVr?=
 =?utf-8?B?RWJxZGVnZUJCL3hwUWxrZnExdUc3VTR0T2dCY2JPN1pPWWZnc2hkUXp4bWVv?=
 =?utf-8?B?OTdndzY5REJPUTdxM0R0aUd1SkpLakswL3RqN2V2WHJQYzlOVFk5V0hNbG5I?=
 =?utf-8?B?MlRRQSs1THdoaXJ0ajJuZ2RuL0hDZytVQXphbzl6b1Mzdmc4eWVsKytVYTFW?=
 =?utf-8?B?T3JkTzlnelpPUkJGWHpGQTAwYW0yOGZLaC9JeFdwcCtzQXpDS1dNcmVuTnRQ?=
 =?utf-8?B?Sm9NZ0swMjRzNDdhcWtFeVQ1Tzlwa1NmWkorcTFVcjMrQWluMkdYR1piMGg4?=
 =?utf-8?B?aEh3TWJnaG91VWFVaGNIN2dxcXc5cjFoazBjdk04M0Y0OWt0bjM1QjNJcVhv?=
 =?utf-8?B?YlAxc3o2ZzRYRG5Pc0ErZlhCNzNjc0EyYlQ5S241Kzc0RXpYdFphMkVUZHN4?=
 =?utf-8?B?ay82QytuOVU0OVpJR0o0bkgzcEZtR3JLeFJVRFFDdlRwNndIeWgyVFZMT2Nt?=
 =?utf-8?B?NXpvWjVBdk1BYmZaQ3ZOMzUvakNxU2N0MTVXYzNYWlhSZ2dralErZnZ1blo2?=
 =?utf-8?B?dUZaUU5hZDdhbVFVdmNPN01ZY3lEeGZ2RkdZajJRdkZMaDZFMmV5WE5Hbjhz?=
 =?utf-8?B?TkFERStGdXk1clVzTUp4Rk5YbTl1WTdFckUrUjJrT0h6c1E5NkdYcXIvRzF2?=
 =?utf-8?B?WUo1SFBhWUhwWWdLM2lBR0dzWmxGcDhBeXFPRmdWQ0xBaDZYeFN3TnFuZGtC?=
 =?utf-8?B?cTcwc0xrVjRxRjRBa1NHVkx6K2lYUVZ4bWxROTh6NVUyNTA5S3plc01PbWs5?=
 =?utf-8?B?aUJDQTYyd1ZqaHpiSGg2N1czdzNRVytyTTR0cFg3eERmS2IxZ3BDSlBxeEFZ?=
 =?utf-8?B?WCtsTFZUclNDT2RzRk1HVVRSRUp2ekZNNVpJRExEK3QwYW4vQkd5Znl3Nldk?=
 =?utf-8?B?anBCd3ZWNHJzQWh5V2k3UlBOUzVoZlhvbUxlelVFNEphTk42MGlpSmJNaUxH?=
 =?utf-8?B?ckVjRXVxM2R1ZVFrTzJVVVV2TG0wOW94bkRYVXlNMmpsb0VBbXRwdG92bFVx?=
 =?utf-8?B?aXdoK0Rub2VybFc1V21KRXZKRytwSnVFellkbGZaTmQ5RmpNNFlOa1M2Q0Fj?=
 =?utf-8?B?eVVIKzNCTW5hdVVsL0lVdHVySGpmM2hqa3FCM1BwRFZIdmk1WW95TzIray9F?=
 =?utf-8?B?ekJ1U3ZZOWkxMVc1S2lZVmMrMTV3a2I1RWp5SWNVNFVuR2hmNklCOWVKZ1lC?=
 =?utf-8?B?UTZJbjkvcVVQcWJlZ2JpUk9lalZaS2RYK1BsdWtMeFJCVlBuV2pWTnlPWGxP?=
 =?utf-8?Q?JO51Rk/LLlqNjtGpzr?=
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: M+paXzCqS+vYhj67ULGHYSJ++YRfYwzE2TK5ioAZTfwt+ZeMMYNxTCBecKgyAyV6R0SArt3THGer9cwgIQjUiCp4gP9C7s31lOYNWc2YHzB+z7mxkc/K+++gUZFiLd0yJAMLulr2ru7YtuXWMIRY8wxe6qmyifLdryoByAccBXBERhX0zR1k8g20yHCXX4KXSBg0cDftLLg1eVUpwkGysBdy/twoPG/Q3jkkIzOSk45CKqkgoS6WpVCBlqTe4spkHu8LDxjV78yV3gqYr3lQgHcMJ/aY46kxIU6g8ouIB/wxRQbR+/UMdKR3p1bny/j7o5Bq7ScJbY7kg+De8oa1Vw==
X-OriginatorOrg: se.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9657.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a299aa82-52cb-4c34-0c2f-08de7b5bf619
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2026 08:40:03.3803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6e51e1ad-c54b-4b39-b598-0ffe9ae68fef
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ecKQj3NWPYEDOfGEDEBbWPlO9h7lH4CBYLn4tmZLk81NSJQjPcKXDj2QbYlaxbYJYF2+XhvRmnBMLBSipI3g6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7187
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -sjbt-xcXtgwk5Vv03GcFif0JZeeKi1bD5qLegFhHMI_1772786404
X-Mimecast-Originator: se.com
Content-Language: fr-FR
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 06 Mar 2026 08:40:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19119

T24gVGh1IE1hciAwNSwgMjAyNiBhdCAxOTowOSzCoFBhdWwgQmFya2VyIHdyb3RlOgo+IE9uIFRo
dSwgMjAyNi0wMy0wNSBhdCAxNjozMiArMDEwMCwgUGFzY2FsIEViZXJoYXJkIHZpYSBCNCBSZWxh
eSB2aWEKPiBsaXN0cy5vcGVuZW1iZWRkZWQub3JnIHdyb3RlOgo+IAo+ID4gd2dldCBmZXRjaCBt
ZXRob2QgaXMgdXNlZCBmb3Igd2ViIGRvd25sb2FkcyB3aXRoIGh0dHAsIGh0dHBzLCBmdHAsIGZ0
cHMKPiA+IHByb3RvY29scy4gd2dldCBjbWRsaW5lIHRvb2wgaXMgbWlzc2luZyBzb21lIGZlYXR1
cmVzIHN1Y2ggYXMgaG9zdG5hbWUKPiA+IHJlc29sdXRpb24gYnkgdGhlIHByb3h5IHdoZW4gdXNp
bmcgU09DS1M1IHByb3h5LiBTU0ggdHVubmVsIHByb3ZpZGVzCj4gPiB0aGlzIGZlYXR1cmUgZm9y
IGV4YW1wbGUuCj4gPgo+ID4gVGhpcyBjdXJsIGZldGNoIG1ldGhvZCBpcyBiYXNlZCBvbiBjdXJs
IGNtZGxpbmUgdG9vbCBhbmQgcHJvdmlkZXMgdGhlCj4gPiBzYW1lIHByb3RvY29scyBhcyB3Z2V0
IGFuZCBzdXBwb3J0cyBTT0NLUzUgaG9zdG5hbWUgcmVzb2x1dGlvbi4KPiA+IFRoaXMgY2xhc3Mg
aW5oZXJpdHMgd2dldCBtZXRob2QgaW4gb3JkZXIgdG8gYXZvaWQgY29kZSBkdXBsaWNhdGlvbiBh
cwo+ID4gbXVjaCBhcyBwb3NzaWJsZS4KPiA+Cj4gPiB3Z2V0IHJlbWFpbnMgdGhlIGRlZmF1bHQg
ZG93bmxvYWQgbWV0aG9kLiBjdXJsIGZldGNoIG1ldGhvZCBjYW4gYmUKPiA+IGVuYWJsZWQgYnkg
c2V0dGluZyBhIG5ldyBiaXRiYWtlIHZhcmlhYmxlOgo+ID7CoMKgIEJCX0ZFVENIX01FVEhPRF9I
VFRQID0gImN1cmwiCj4gPgo+ID4gVGhlIGhvc3RuYW1lIHJlc29sdXRpb24gYnkgU09DS1M1IHBy
b3h5IGlzIGFjdGl2YXRlZCBieSBzZXR0aW5nCj4gPiBlbnZpcm9ubWVudCB2YXJpYWJsZToKPiA+
wqDCoCBhbGxfcHJveHk9InNvY2tzNWg6Ly8uLi4iIgo+ID4KPiA+IGEgcGF0Y2ggb24gY2UtY29y
ZSB3aWxsIGJlIHNlbnQgaWYgdGhpcyBwcm9wb3NhbCBpcyBhY2NlcHRlZCB0bwo+ID4gY29uZGl0
aW9ubmFseSBhZGQgY3VybCB0byBIT1NUVE9PTFMgdmFyaWFibGUgaW4gbWV0YS9jb25mL2JpdGJh
a2UuY29uZjoKPiA+IEhPU1RUT09MUyArPSAiJHtAYmIudXRpbHMuY29udGFpbnMoJ0JCX0ZFVENI
X01FVEhPRF9IVFRQJywgJ2N1cmwnLCAnY3VybCcsJycsIGQpfSIKPiA+Cj4gPiBTaWduZWQtb2Zm
LWJ5OiBQYXNjYWwgRWJlcmhhcmQgPHBhc2NhbC5lYmVyaGFyZEBzZS5jb20+Cj4gCj4gCj4gSGkg
UGFzY2FsLAoKSGkgUGF1bCwKCj4gQWRkaW5nIGEgc2Vjb25kIEhUVFAgZmV0Y2hlciB0byBiaXRi
YWtlIGluY3JlYXNlcyBjb21wbGV4aXR5IGFuZAo+IG1haW50ZW5hbmNlIGNvc3QuIFRoZSBiZWhh
dmlvdXIgb2Ygd2dldCBhbmQgY3VybCBpcyB1bmxpa2VseSB0byBtYXRjaAo+IGV4YWN0bHkgYW5k
IHNvIGlzc3VlcyB3aWxsIGJlIGNhdXNlZCB3aGVuIHBlb3BsZSBzd2l0Y2ggZnJvbSBvbmUgdG8g
dGhlCj4gb3RoZXIgKGZvciB3aGF0ZXZlciByZWFzb24pLgogCkluZGVlZCwgSSB1bmRlcnN0YW5k
IGhhdmluZyB0byBwb25kZXIgdGhlIHZhbHVlIGdpdmVuIHRoZSBpbmNyZWFzZSBpbgp0aGUgbWFp
bnRlbmFuY2UgYnVyZGVuLgoKPiBJcyBpdCBqdXN0IHNvY2tzNWg6Ly8gc3VwcG9ydCB0aGF0IHlv
dSBuZWVkPyBEbyB5b3Uga25vdyBpZiB0aGVyZSBpcyBhCj4gYnVnL2ZlYXR1cmUgcmVxdWVzdCBv
cGVuIHdpdGggd2dldCB1cHN0cmVhbSByZWdhcmRpbmcgc29ja3M1aCBzdXBwb3J0PwoKQWN0dWFs
bHks4oCvd2dldCBoYXMgbm8gc3VwcG9ydCBhdCBhbGwgZm9yIFNPQ0tTIHByb3h54oCvOiguIEEg
d29ya2Fyb3VuZAp3aXRo4oCvdHNvY2tzIHdvcmtzIGZvciBTT0NLUzQgYW5kIFNPQ0tTNSwgYnV0
IGhvc3RuYW1lIHJlc29sdXRpb24gaXNu4oCZdApwb3NzaWJsZSB0aGF0IHdheS4gU28gaW1wbGVt
ZW50aW5n4oCvc29ja3M1aOKAr2lu4oCvd2dldOKAr3dvdWxkIHJlcXVpcmUKaW1wbGVtZW50aW5n
IFNPQ0tTIHByb3h5IHN1cHBvcnQgZnJvbSBzY3JhdGNoLCB3aGljaCBleHBsYWluIHRoZSBjaG9p
Y2UKb2YgY3VybC4KCj4gQWxzbywgZG8geW91IGtub3cgdGhlIG1pbmltdW0gY3VybCB2ZXJzaW9u
IHJlcXVpcmVkIHRvIHN1cHBvcnQgc29ja3M1aD8KPiBUaGlzIG1heSBiZSBpbXBvcnRhbnQgYXMg
d2Ugc3VwcG9ydCBtdWx0aXBsZSBkaXN0cm9zIHdoaWNoIG1heSBoYXZlCj4gZGlmZmVyZW50IGN1
cmwgdmVyc2lvbnMuCgpUaGUgJ3NvY2tzNWgnIHNjaGVtZSBoYXMgYmVlbiBzdXBwb3J0ZWQgc2lu
Y2UgMjAxMS4gVGhlIG1vdGl2YXRpb24gZm9yCnRoaXMgcHJvcG9zYWwgd2FzIFNPQ0tTIHByb3h5
IHN1cHBvcnQsIGJ1dCBjdXJsIG1heSBoYXZlIG90aGVyIGJlbmVmaXRzCnRoYW4gSSBhbSBub3Qg
YXdhcmUgb2YuCgoKQmVzdCByZWdhcmRzLApQYXNjYWwKDQo=


