Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952DFC021B2
	for <webhook@archiver.kernel.org>; Tue, 25 Feb 2025 17:05:13 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.59])
 by mx.groups.io with SMTP id smtpd.web11.13979.1740503103534957259
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Feb 2025 09:05:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ukfj++EC;
 spf=pass (domain: siemens.com, ip: 40.107.241.59, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHPbx1XTOiaLBnlbleJk5cLlSQRAVvJUnB8+WhAyW3dx2ypNXWpTwVFsLpbooH8Hu2XovSdzBpsxyYXv5rRrSyNROUquucMzqEkkDhoSAjpZ6A3JrQLpU1eHNn4xn6ZU6/GUJPLQovYuMkSXVPUOksTmn28eBU/9NG2Ar4oKXfZDWrGojTHYe8eKIi4tN7PCFT/m7gfK1n20LqbhuBtign1KKGR0/dfnLn0rK7kdGemv+coio4p6QVrDvpFQWfue+AhY3e+QwwrMofAhTXpGKzkGkpgp0YdiBlnArcfIPqzknddRfhbDaiKY6jUzgdHsyVk1R8O0AkKGkMp5vGvwhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxVBbJPkmkhwa1pheVJ55o7NI0z464QcqJh+ybIuV3o=;
 b=nqvma2oUWAZC9N1QWLjys/iZ9MAT07H273OMmQlnQE9vvqzofbAtcQYGydtktpsNfH0JlTfB4NQtqYzA9K/GXXC23Gt+taNj/boBOVqLeZ4Ca//ODhasyUuZIVw9jvFT/8Xn+XtDhmzxIY7rJUOdOdnoEaYcWU/H5iTlWe0M7KsRYVtb5elRtrEr/rvMff9wEPWxzmkPYFLnBQXeTT+AHX0W9FmPeQQjuZmWUheWEmiBHa4APNiKzmNT4qfLtMNIuE30wj10CgggcpES+YKFvYESVjNWpGZ+9VDrXCKPVB4FVbrpg+9LdHnNWxgnGQRMKd6UUUM7abpYWALZeBQvEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxVBbJPkmkhwa1pheVJ55o7NI0z464QcqJh+ybIuV3o=;
 b=ukfj++ECqyyJzg2LSOTY/m6jX+uY+rVMvSfw6N+4xDsnYU4qxbmKySM7P+j7buD+SJ4YJkgeJuqjKqann/UwogqnWejfwzsZq+i9E9w+ACUG+PBKLQ29R8yanS4Ic0LMeyC6CfC9IQNZ9bjVQKbr45BlCxtflUuojV/+NQWmovqEGMlXSm3wnbO6Cmn7WkIqecFEeyWf1dEpg0Id62XaE3cuQc0XT5OGLjL7x8BDNlxx9KP+psg8oIGV458p1Z6SleafH8mIzgln7Q4FyCWCX+M83w4eRYKmGShp+UIFjSdUj+FPakXg9bx4Ez+Vowhw0DqOVT0xuYzeeBMP/+zpgw==
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by AM0PR10MB3220.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:182::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 17:05:00 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%6]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 17:04:59 +0000
From: "Koch, Stefan" <stefan-koch@siemens.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, "mathieu.dubois-briand@bootlin.com"
	<mathieu.dubois-briand@bootlin.com>
CC: "Sudler, Simon" <simon.sudler@siemens.com>,
	"richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
	"Kiszka, Jan" <jan.kiszka@siemens.com>, "alex.kanavin@gmail.com"
	<alex.kanavin@gmail.com>
Subject: Re: [bitbake-devel] [PATCH v3 1/4] fetch2/git: Add support for fast
 initial shallow fetch
Thread-Topic: [bitbake-devel] [PATCH v3 1/4] fetch2/git: Add support for fast
 initial shallow fetch
Thread-Index: AQHbg7ywZJqt9JvQhESFPikUXBi+bLNWX0eAgAAQGoCAAARbAIAAQsQAgAGQ0gA=
Date: Tue, 25 Feb 2025 17:04:59 +0000
Message-ID: <06ab9baa1ee1d5e22403f63b6074789412f7d501.camel@siemens.com>
References: <20250220172706.3850722-1-stefan-koch@siemens.com>
	 <D80NPDG5BAOJ.21VFGTXZZIRP5@bootlin.com>
	 <e041fd346c069847c11899777503721d0dfaf952.camel@siemens.com>
	 <4961407c133c3579acf66ca5deefa6f680c4f391.camel@siemens.com>
	 <D80UCEFULALJ.1FXZODPDU20BJ@bootlin.com>
In-Reply-To: <D80UCEFULALJ.1FXZODPDU20BJ@bootlin.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR10MB4959:EE_|AM0PR10MB3220:EE_
x-ms-office365-filtering-correlation-id: b41b91d7-4943-4948-7cf8-08dd55be897a
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?U1VGUlRrMnlTY002K3NCdXRjMGM0eW9tazE3aWNGZENIdTNiNDh2VExsWHZ6?=
 =?utf-8?B?M1YzZWp2OWRZeXl2V2R0bVFkREcwZkhNMGtVcDhUWWxtTWVoYmZTUUE1UTk1?=
 =?utf-8?B?N2FzRE0zbWp5UlVTdEMzcHZSRk1jeWhTbXVjU3dtWEh2S3RuNU1ub09GU2Rh?=
 =?utf-8?B?OFpmODMxU2ZhRW1xL2NUcjhNVzZkMzN3K3JVN0xHNU9SdGVKK3QwZzNqNllG?=
 =?utf-8?B?djZHd3oyTlU4ZTJUQnVkN0ZNcUpUT0ZGZFFuaGhLVWpGajU3alRzYmdEOFIv?=
 =?utf-8?B?aEFMemI4NmYyMVgzdERGSzU3b2krK1I2bFhoYWNxYkpXek5LTzlmTWZTbStU?=
 =?utf-8?B?Zis3dmFzN3FUdVJTS0ZRY1FSR3JhRWhEWU1kUGhmK3hnUkhWb2p1b1VzTG1j?=
 =?utf-8?B?cEpMOU54dlF2VTBEdGYwdDBDQzMzQ0Q2UWVRNG44aGRjbUVUMWtveUhzYjRD?=
 =?utf-8?B?NElKUDVZZG5BV3plbEVDNGROVmVLTzRkMGRMZE1tVit0cjIzY2ZFeSs3UHB2?=
 =?utf-8?B?dmt4cEdYQ29FajNEMkJUbEY2bUJ0b2V3ZThFQjg2WXFyVDIyQ3djL3hOdTA0?=
 =?utf-8?B?SVNtT0hjbHhqdkVBczZZa2U5a2hEbVowakZkOWVMZm1zaEpaMTBxRXl0NWta?=
 =?utf-8?B?azVrTURHYlFkQ1NGYnFreWNSeTZOeS9JVWU1bUR3YVVhUlluNkJRQXB2RXVV?=
 =?utf-8?B?TGFTSFRIWmRpUVFjY2UxRzhuN3djTU50ZmxJY25UaGhtNFhHVXNLczB1SGpR?=
 =?utf-8?B?ckdGM0taME9Rc20vQnlzUTF1alVNZkp6M0FYOEtzcytKenl3bUJJQnZRU3Nl?=
 =?utf-8?B?QVhZTjJxVDFJN1crelk4QUgwZlBaYW5QeTVwL0hsWmdzR1UwNXV3T3l6K2RY?=
 =?utf-8?B?aVlYYXlsc2JqT2FPaGNNdEd5MmUxRGttVGVtTFYwNnVRb2N6MVhOb3pGQkZK?=
 =?utf-8?B?NWtMVUdwWXg5OFhuZmZtRm5Lc1JHYXhSN0ovaGFxNW02ZHdLT0ZTYklGR3ds?=
 =?utf-8?B?RllCRERnQ0daV2lvNUxMaHBpNm03TnVZaUZWYlBzMUpxYisyU3A0TDU1eDZs?=
 =?utf-8?B?UDREZ2ZPMHB6TGcxVURXeDZJMy9vMHkwdmJONFcrc0hZWVZJZm1lcTdoTVdU?=
 =?utf-8?B?cFNkdjN0T29ma05LVFhDM2ZVQXd2ZnlxZldsWC9SYVNKNkRmL0RTeGJ1T1lw?=
 =?utf-8?B?RGx4K2JPbHZ1TlFxQlQwUUpHajd1UVpjUnowZ1BNNU5QUG1OWERzTUF2NnZw?=
 =?utf-8?B?anJHYWU4VC9BNlhQbGVtcXBOdE5MQXpSb3JVSXRGVmhkMnpYRDdrS0ZkbWxj?=
 =?utf-8?B?Z3QvbGhnNWh5ZmFCeHMzaTVITjgrenAwbmhkQnB1cC9RT3pQQS9VcjlTbWh6?=
 =?utf-8?B?eTh6SmtwZ1JMOGgrMTgxaDN2RS81NEdmZ0tpaUNvT3FlZGlqeHBVenpRQlNE?=
 =?utf-8?B?ZEh1dk5INDN5NGtZR2M3SldHWnJEazA2akVCdnZzMkNvdFNkdFN6MGNVQUNL?=
 =?utf-8?B?Q3lBV3QzdTI0NHRDOUlPRXFOWHFTOXZFb2MwRmVyQzRZTzdaUTN6d1pXN0Iy?=
 =?utf-8?B?Z1BjSklJYkV1OWtmQmFXVE9qckNTTVhHcTFQWVMyTytvSDVTakpHRERpR2R5?=
 =?utf-8?B?T0htWEdQcDYvcjIwWmFOTDZqZmFDOS9PRVVWVE44K1NleXFneElEK0pidjdR?=
 =?utf-8?B?Vzd1V0JiaVdxbzM4VE90K0Q3WDRVUkIraDhQYjVVTWFJZGhkUnhBMjVYeEhv?=
 =?utf-8?B?ejhaOG1VTnovdGxRSGh4cGhRYTh2Q1Yva0Frallad0g2YnZ0SnZiS0JNNDBn?=
 =?utf-8?B?RUxUaUN3VGVGOW9IQjhHZFJLYmNpV25FLzNVTlF6VktMcGZZamxpTFVCMDNu?=
 =?utf-8?Q?B1EssC8n2tWbz?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MGtOS3R2SjBaUTRxNEFCRnhvdlpwV0ZaT0tDdUdjODdTR3BIMEZUdHZ5V21v?=
 =?utf-8?B?UjZjWjhrN1RoTjdpVmcwdXJRUjByYWNrZlRXUFRhc3hza0lvZVVjNGV6bTNY?=
 =?utf-8?B?eG0rOU5sbTA5L0NyZ05NdmxiYVpqV3BrSWFueElOVEVpekYxaks1eVZ0dnRi?=
 =?utf-8?B?Vmd1TjlvQy9pWFRvUTdHTi9jNFhhRnhtMis1WkpaVHZJcFZCVnRDMXpMcVZE?=
 =?utf-8?B?b2w2YlRpRndNZVRsdHg2L3liYXZjNVJHSW1Jc2pKSmFvSE91T3d5dHVjdG5L?=
 =?utf-8?B?N3lVQ25BdzE2Ym1pM201NTk2aWVBTVJxcGNya0hQeGxSTVhaSU4wbkU5NTE1?=
 =?utf-8?B?MUNCSVRzRHZxMDlUK1JPSkwvU0hSdnAvMkNuakNpTmE4RWttcVNjaEpiLy96?=
 =?utf-8?B?YlhGeEtaNW1ZQzE0QmE2eWFHTDdkUmc0OTFtYWhicDNnSE1Sa0FBdG1ubjlh?=
 =?utf-8?B?UWRPNUNnT2dQaElnNmFxNkdtWUl5OXZydXNJcGI1TEluNWc1Q0M5NVYzdVlo?=
 =?utf-8?B?cjlxemk3M3Q0ZFI0bU9MZ3pSMVhpQi96WXA1RGVoUTNPWldPN3dzSDhPdjl0?=
 =?utf-8?B?MGpObFJRS1BKYVdobjVCMllCeUxKeDdWOFdJd2x6WGdMNVc5SGU2Tld5RUQv?=
 =?utf-8?B?cEVUUkx6aVg0K2tvSWRaYldsejJtL0xkc0hBR2tmSk0rbWJ6T2w3OGlWcGJ1?=
 =?utf-8?B?SzgrcGNpQVROREJGN3dHSGNZampDRERBN2xjcmlHcXhoQ3lLSEdkckE0ejlO?=
 =?utf-8?B?TUN1TWVUdWVxUlJHb3c3KzMwSFF3bzU2OE94Ym5oOG13UlRNV1J1b1BsMFNo?=
 =?utf-8?B?amNKNkEwdmNWTTh4eDlkNm9QbFl3RzBqRUwvdmhwZlFJTk9uQUFBeWdHT29j?=
 =?utf-8?B?ZEwzdmJUTVlJUUY1YllhVEZqMWttbk1rV1RaMTMxbnJqRGwwdlZ6VzFCZHlD?=
 =?utf-8?B?dDBtY0RIN21nNk9JS0QzWDBrT0VLUHFSeHpqQVVNcGRvWUJYTk8zSWRNcEhW?=
 =?utf-8?B?bEJHeUJGcnhiTkUzS1MxMzhOOUlkVzVqeDNhWDUrRCttOWdxOXVEZG1qMy9Z?=
 =?utf-8?B?SGROQzJSdnpIOUVsd29GKzUyZ2QyQ2E4MkNEbVRUNTk2R0s5ZUhBR3dmSVpa?=
 =?utf-8?B?SCszdmNWS1JKMHJPcFJ4QVhLUFlqbGxtQktTUzROTS8zNEkzNHNVQXArVHAr?=
 =?utf-8?B?bXFoUlFsaHlmWGdVSGFSenRiV3ZFQjRPOGxlcmxYRS9NYWJxbi9MR29jSnV3?=
 =?utf-8?B?K3ZmY3dENm5jMFB6VzVnejhNMll0QXhQWjNmQlZGYlpKdzVBSnoyMVVBWTNC?=
 =?utf-8?B?cEIxN3V5c1JSZGRmMTBOWDNNUStLTmxQeEZaczVBTktXb1V4dThUNWlpRjhK?=
 =?utf-8?B?bjFXRUFwS3VadWhIdU1rWW1tWXJOWmpPdjZMNWlkTHdiNGR3WCs4ekRxNm5q?=
 =?utf-8?B?a2xzV2pwQ0ZnUi9qQTI3SjBHL0FnT1pNVVVKeWF1bXZ4eEJVZXBsc005VFUy?=
 =?utf-8?B?UjZncjYrZXNQMWMxUFZyNnd3aVErZXk3SkdYbUxVYmh3YVNsMldpRTFIMWh0?=
 =?utf-8?B?RWVIc09zTXlENFl5S2NXcjVza3p6d0d0enFEV2FVQ2drck1JSGZtR2dVNFM3?=
 =?utf-8?B?M0xXQm5lcUNtVjhQMnQ2ZjhIdlkzQ2FQQ3IwT3BobXdpbUFoT1FaTjRBUlNl?=
 =?utf-8?B?MkxGOTZOVjY1R1kvZ05XT1o3cGc0MlJVK0gzZXp3UDQ3MENjSjhkQ25BZ29W?=
 =?utf-8?B?QUNRL3pkanZPaE9vdW85aGI1d2FaRG5weVR4UThJb2h3RytSTE9uRTRsRGRI?=
 =?utf-8?B?bE51aUNUaTVoNEtLMnpORXBPbUw2VUN4NmZDaEpjdGUrU3Z0UzR5c0pWVmU3?=
 =?utf-8?B?ckxWbE5pcW16MlFwVDVvZ0hwNHRwdDhEYXVkVkJ4anI2d2ZrUm5vaTRVbUdz?=
 =?utf-8?B?Tit0RWJ5czkyZmw0V00rUEJiNTNEMTJ1cG8rZjloQmR1R1FCL0t6S3RETW9u?=
 =?utf-8?B?V1FqNnFpQ1REZklrUjl6VGI2cWxaUjVJWFBBb0xUdjZWTGs0K3AzL2o1blhz?=
 =?utf-8?B?ZkdLTnNMWDlabEZrK2MxNFR1RkZ1TFNKMWw4bGlXV1h1VGZObFk5SWMyUmZq?=
 =?utf-8?B?dmpoMDNSMmN6QmNiM3NkdVRoaVA1Z0ppc0JCQXZucit4RE0xdDg2eXpTT2Jt?=
 =?utf-8?B?VkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3FEBC85BB327D54FA7CD869D5901C10A@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b41b91d7-4943-4948-7cf8-08dd55be897a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 17:04:59.4836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hv9NDbuJ+kCYQ2QDWG+8pUllYHsHgVKqhtAjmsHsRweowoVlelGg/3iqcI9V+mLnWrBdnXvXjpRtjTKou2ZyZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3220
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Feb 2025 17:05:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17319

T24gTW9uLCAyMDI1LTAyLTI0IGF0IDE4OjEwICswMTAwLCBNYXRoaWV1IER1Ym9pcy1CcmlhbmQg
d3JvdGU6DQo+IE9uIE1vbiBGZWIgMjQsIDIwMjUgYXQgMjoxMSBQTSBDRVQsIFN0ZWZhbiBLb2No
IHdyb3RlOg0KPiA+IE9uIE1vbiwgMjAyNS0wMi0yNCBhdCAxMzo1NSArMDEwMCwgU3RlZmFuIEtv
Y2ggd3JvdGU6DQo+ID4gPiBPbiBNb24sIDIwMjUtMDItMjQgYXQgMTI6NTggKzAxMDAsIE1hdGhp
ZXUgRHVib2lzLUJyaWFuZCB3cm90ZToNCj4gPiA+ID4gT24gVGh1IEZlYiAyMCwgMjAyNSBhdCA2
OjI3IFBNIENFVCwgU3RlZmFuIHZpYQ0KPiA+ID4gPiBsaXN0cy5vcGVuZW1iZWRkZWQub3JnDQo+
ID4gPiA+IEtvY2ggd3JvdGU6DQo+ID4gPiA+ID4gV2hlbiBgdWQuc2hhbGxvdyA9PSAxYDoNCj4g
PiA+ID4gPiAtIFByZWZlciBhbiBpbml0aWFsIHNoYWxsb3cgY2xvbmUgb3ZlciBhbiBpbml0aWFs
IGZ1bGwgYmFyZQ0KPiA+ID4gPiA+IGNsb25lLA0KPiA+ID4gPiA+ICAgd2hpbGUgc3RpbGwgdXRp
bGl6aW5nIGFueSBhbHJlYWR5IGV4aXN0aW5nIGZ1bGwgYmFyZQ0KPiA+ID4gPiA+IGNsb25lcy4N
Cj4gPiA+ID4gPg0KPiA+ID4gPiA+IFRoaXMgaW1wcm92ZXM6DQo+ID4gPiA+ID4gLSBSZXNvbHZl
IHRpbWVvdXQgaXNzdWVzIGR1cmluZyBpbml0aWFsIGNsb25lcyBvbiBzbG93DQo+ID4gPiA+ID4g
aW50ZXJuZXQNCj4gPiA+ID4gPiBjb25uZWN0aW9ucw0KPiA+ID4gPiA+ICAgYnkgcmVkdWNpbmcg
dGhlIGFtb3VudCBvZiBkYXRhIHRyYW5zZmVycmVkLg0KPiA+ID4gPiA+IC0gRWxpbWluYXRlIHRo
ZSBuZWVkIHRvIHVzZSBhbiBIVFRQUyB0YXJiYWxsIGBTUkNfVVJJYA0KPiA+ID4gPiA+ICAgdG8g
cmVkdWNlIGRhdGEgdHJhbnNmZXIuDQo+ID4gPiA+ID4gLSBBbGxvdyBTU0gtYmFzZWQgYXV0aGVu
dGljYXRpb24gKGUuZy4gY2VydCBhbmQgYWdlbnQtYmFzZWQpDQo+ID4gPiA+ID4gd2hlbg0KPiA+
ID4gPiA+ICAgdXNpbmcgbm9uLXB1YmxpYyByZXBvcywgc28gYWRkaXRpb25hbCBIVFRQUyB0b2tl
bnMgbWF5IG5vdA0KPiA+ID4gPiA+IGJlDQo+ID4gPiA+ID4gcmVxdWlyZWQuDQo+ID4gPiA+ID4N
Cj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gS29jaCA8c3RlZmFuLWtvY2hAc2llbWVu
cy5jb20+DQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+DQo+ID4gPiA+IEhpIFN0ZWZhbiwNCj4gPiA+
ID4NCj4gPiA+ID4gVGhhbmtzIGZvciB5b3VyIHBhdGNoLg0KPiA+ID4gPg0KPiA+ID4gPiBXZSBn
b3QgYSBuZXcgZmFpbHVyZSBvbiB0aGUgYXV0b2J1aWxkZXIsIHNwZWNpZmljYWxseSB3aXRoIHRo
ZQ0KPiA+ID4gPiBvZS1zZWxmdGVzdC11YnVudHUgYnVpbGQuIEknbSBub3QgZW50aXJlbHkgc3Vy
ZSB0aGlzIGNvbWVzIGZyb20NCj4gPiA+ID4gdGhpcw0KPiA+ID4gPiBzZXJpZXMsIHNvIEkgd2ls
bCB0cnkgYSBidWlsZCB3aXRob3V0IGl0IHRvIGNvbmZpcm0uDQo+ID4gPiA+DQo+ID4gPiA+IEhl
cmUgaXMgdGhlIGVycm9yOg0KPiA+ID4gPg0KPiA+ID4gPiBOT1RFOiBSdW5uaW5nIHRhc2sgMiBv
ZiA0ICgvc3J2L3Bva3lidWlsZC95b2N0by13b3JrZXIvb2UtDQo+ID4gPiA+IHNlbGZ0ZXN0LQ0K
PiA+ID4gPiB1YnVudHUvYnVpbGQvYnVpbGQtc3QtMzUwMjk0My9tZXRhLXNlbGZ0ZXN0L3JlY2lw
ZXMtdGVzdC9naXQtDQo+ID4gPiA+IHN1Ym1vZHVsZS10ZXN0L2dpdC1zdWJtb2R1bGUtdGVzdC5i
Yjpkb19mZXRjaCkNCj4gPiA+ID4gTk9URTogcmVjaXBlIGdpdC1zdWJtb2R1bGUtdGVzdC0xLjAt
cjA6IHRhc2sgZG9fZmV0Y2g6IFN0YXJ0ZWQNCj4gPiA+ID4gV0FSTklORzogZ2l0LXN1Ym1vZHVs
ZS10ZXN0LTEuMC1yMCBkb19mZXRjaDogQ3JlYXRpbmcgZmFzdA0KPiA+ID4gPiBpbml0aWFsDQo+
ID4gPiA+IHNoYWxsb3cgY2xvbmUgZmFpbGVkLCB0cnkgaW5pdGlhbCByZWd1bGFyIGNsb25lIG5v
dy4NCj4gPiA+ID4gV0FSTklORzogZ2l0LXN1Ym1vZHVsZS10ZXN0LTEuMC1yMCBkb19mZXRjaDog
RmFpbGVkIHRvIGZldGNoDQo+ID4gPiA+IFVSTA0KPiA+ID4gPiBnaXRzbTovL2dpdC5vcGVuZW1i
ZWRkZWQub3JnL2JpdGJha2U7cHJvdG9jb2w9Z2l0O25hbWU9Yml0YmFrZTsNCj4gPiA+ID4gc3Vi
cA0KPiA+ID4gPiBhdA0KPiA+ID4gPiBoPWJpdGJha2U7bm9icmFuY2g9MTtsZnM9RmFsc2U7YmFy
ZWNsb25lPTE7bm9icmFuY2g9MSwNCj4gPiA+ID4gYXR0ZW1wdGluZw0KPiA+ID4gPiBNSVJST1JT
IGlmIGF2YWlsYWJsZQ0KPiA+ID4gPiBFUlJPUjogZ2l0LXN1Ym1vZHVsZS10ZXN0LTEuMC1yMCBk
b19mZXRjaDogRmV0Y2hlciBmYWlsdXJlOg0KPiA+ID4gPiBGZXRjaA0KPiA+ID4gPiBjb21tYW5k
IGV4cG9ydCBQU0VVRE9fRElTQUJMRUQ9MTsgZXhwb3J0DQo+ID4gPiA+IFBBVEg9Ii9zcnYvcG9r
eWJ1aWxkL3lvY3RvLQ0KPiA+ID4gPiB3b3JrZXIvb2Utc2VsZnRlc3QtdWJ1bnR1L2J1aWxkL2J1
aWxkLXN0LTM1MDI5NDMvdG1wL3N5c3Jvb3RzLQ0KPiA+ID4gPiB1bmluYXRpdmUveDg2XzY0LWxp
bnV4L3Vzci9iaW46L3Nydi9wb2t5YnVpbGQveW9jdG8td29ya2VyL29lLQ0KPiA+ID4gPiBzZWxm
dGVzdC11YnVudHUvYnVpbGQvc2NyaXB0czovc3J2L3Bva3lidWlsZC95b2N0by13b3JrZXIvb2Ut
DQo+ID4gPiA+IHNlbGZ0ZXN0LXVidW50dS9idWlsZC9idWlsZC1zdC0zNTAyOTQzL3RtcC93b3Jr
L2NvcmUyLTY0LXBva3ktDQo+ID4gPiA+IGxpbnV4L2dpdC1zdWJtb2R1bGUtdGVzdC8xLjAvcmVj
aXBlLXN5c3Jvb3QtDQo+ID4gPiA+IG5hdGl2ZS91c3IvYmluL3g4Nl82NC0NCj4gPiA+ID4gcG9r
eS1saW51eDovc3J2L3Bva3lidWlsZC95b2N0by13b3JrZXIvb2Utc2VsZnRlc3QtDQo+ID4gPiA+
IHVidW50dS9idWlsZC9idWlsZC1zdC0zNTAyOTQzL3RtcC93b3JrL2NvcmUyLTY0LXBva3ktbGlu
dXgvZ2l0LQ0KPiA+ID4gPiBzdWJtb2R1bGUtdGVzdC8xLjAvcmVjaXBlLQ0KPiA+ID4gPiBzeXNy
b290L3Vzci9iaW4vY3Jvc3NzY3JpcHRzOi9zcnYvcG9reWJ1aWxkL3lvY3RvLXdvcmtlci9vZS0N
Cj4gPiA+ID4gc2VsZnRlc3QtDQo+ID4gPiA+IHVidW50dS9idWlsZC9idWlsZC1zdC0zNTAyOTQz
L3RtcC93b3JrL2NvcmUyLTY0LXBva3ktbGludXgvZ2l0LQ0KPiA+ID4gPiBzdWJtb2R1bGUtdGVz
dC8xLjAvcmVjaXBlLXN5c3Jvb3QtDQo+ID4gPiA+IG5hdGl2ZS91c3Ivc2Jpbjovc3J2L3Bva3li
dWlsZC95b2N0by13b3JrZXIvb2Utc2VsZnRlc3QtDQo+ID4gPiA+IHVidW50dS9idWlsZC9idWls
ZC1zdC0zNTAyOTQzL3RtcC93b3JrL2NvcmUyLTY0LXBva3ktbGludXgvZ2l0LQ0KPiA+ID4gPiBz
dWJtb2R1bGUtdGVzdC8xLjAvcmVjaXBlLXN5c3Jvb3QtDQo+ID4gPiA+IG5hdGl2ZS91c3IvYmlu
Oi9zcnYvcG9reWJ1aWxkL3lvY3RvLXdvcmtlci9vZS1zZWxmdGVzdC0NCj4gPiA+ID4gdWJ1bnR1
L2J1aWxkL2J1aWxkLXN0LTM1MDI5NDMvdG1wL3dvcmsvY29yZTItNjQtcG9reS1saW51eC9naXQt
DQo+ID4gPiA+IHN1Ym1vZHVsZS10ZXN0LzEuMC9yZWNpcGUtc3lzcm9vdC0NCj4gPiA+ID4gbmF0
aXZlL3NiaW46L3Nydi9wb2t5YnVpbGQveW9jdG8tDQo+ID4gPiA+IHdvcmtlci9vZS1zZWxmdGVz
dC11YnVudHUvYnVpbGQvYnVpbGQtc3QtDQo+ID4gPiA+IDM1MDI5NDMvdG1wL3dvcmsvY29yZTIt
NjQtDQo+ID4gPiA+IHBva3ktbGludXgvZ2l0LXN1Ym1vZHVsZS10ZXN0LzEuMC9yZWNpcGUtc3lz
cm9vdC0NCj4gPiA+ID4gbmF0aXZlL2Jpbjovc3J2L3Bva3lidWlsZC95b2N0by13b3JrZXIvb2Ut
c2VsZnRlc3QtDQo+ID4gPiA+IHVidW50dS9idWlsZC9iaXRiYWtlL2Jpbjovc3J2L3Bva3lidWls
ZC95b2N0by13b3JrZXIvb2UtDQo+ID4gPiA+IHNlbGZ0ZXN0LQ0KPiA+ID4gPiB1YnVudHUvYnVp
bGQvYnVpbGQtc3QtMzUwMjk0My90bXAvaG9zdHRvb2xzIjsgZXhwb3J0DQo+ID4gPiA+IEhPTUU9
Ii9zcnYvcG9reWJ1aWxkIjsgZ2l0IC1jIGdjLmF1dG9EZXRhY2g9ZmFsc2UgLWMNCj4gPiA+ID4g
Y29yZS5wYWdlcj1jYXQNCj4gPiA+ID4gLQ0KPiA+ID4gPiBjIHNhZmUuYmFyZVJlcG9zaXRvcnk9
YWxsIC1jIGNsb25lLmRlZmF1bHRSZW1vdGVOYW1lPW9yaWdpbg0KPiA+ID4gPiBmZXRjaA0KPiA+
ID4gPiBvcmlnaW4gNTJhMTQ0YTdkYWE5NGIyYmQyMzlkNTgyY2I3MWQxZjAzMTE5OTE4ZiAtLWRl
cHRoIDENCj4gPiA+ID4gZmFpbGVkDQo+ID4gPiA+IHdpdGgNCj4gPiA+ID4gZXhpdCBjb2RlIDEs
IG91dHB1dDoNCj4gPiA+ID4gZXJyb3I6IFNlcnZlciBkb2VzIG5vdCBhbGxvdyByZXF1ZXN0IGZv
ciB1bmFkdmVydGlzZWQgb2JqZWN0DQo+ID4gPiA+IDUyYTE0NGE3ZGFhOTRiMmJkMjM5ZDU4MmNi
NzFkMWYwMzExOTkxOGYNCj4gPiA+ID4NCj4gPiA+ID4gaHR0cHM6Ly9hdXRvYnVpbGRlci55b2N0
b3Byb2plY3Qub3JnL3ZhbGt5cmllLyMvYnVpbGRlcnMvNTQvYnVpbGRzLzEwMzEvc3RlcHMvMTQv
bG9ncy9zdGRpbw0KPiA+ID4gPg0KPiA+ID4gPiBDYW4geW91IGhhdmUgYSBsb29rIGF0IHRoaXMg
aXNzdWUgcGxlYXNlPw0KPiA+ID4gRG8geW91IHVzaW5nIDE3MTZhZDY3YmJlOWY0Y2VjZjFlM2Jj
ZmMyMDA3YjE1MGJhNzc3NDEgZnJvbQ0KPiA+ID4gYml0YmFrZXMNCj4gPiA+IG1hc3Rlci1uZXh0
IGJyYW5jaD8gQmVjYXVzZSB0aGF0IGlzIFBBVENIIHYyIHdpdGggdGhhdCBpc3N1ZQ0KPiA+ID4g
c3BlY2lhbGx5DQo+ID4gPiBvbiB1YnVudHUgMjAuMDQuLi4NCj4gPiBTb3JyeSwgdjMgaXMgbWVh
bnQuDQo+ID4gdjQgUEFUQ0ggZnJvbSBGcmlkYXkgc2hvdWxkIGZpeCB0aGlzLg0KPiA+ID4gPg0K
PiA+ID4NCj4NCj4gU29ycnksIEkgc2VudCB0aGlzIGluIHRoZSB3cm9uZyBtYWlsIHRocmVhZCwg
YnV0IEkgY29uZmlybSBJIHdhcw0KPiBpbmRlZWQNCj4gdXNpbmcgdGhlIHY0Lg0KU28gZmFyLCBJ
IGNhbid0IHJlcHJvZHVjZSB0aGUgaXNzdWUgdXNpbmcgYSB1YnVudHUgMjAuMDQgY29udGFpbmVy
Lg0KZ2l0IGNsb25lIGdpdDovL2dpdC55b2N0b3Byb2plY3Qub3JnL3Bva3kNClBhdGNoaW5nIHN1
YmRpciBiaXRiYWtlLw0Kb2Utc2VsZnRlc3QgLXIgZGV2dG9vbC5EZXZ0b29sVXBkYXRlVGVzdHMu
dGVzdF9kZXZ0b29sX2dpdF9zdWJtb2R1bGVzDQpiaXRiYWtlIGdpdC1zdWJtb2R1bGUtdGVzdA0K
DQpUaGUgY3VycmVudCBtYXN0ZXItbmV4dCBicmFuY2ggZnJvbSBiaXRiYWtlIGNvbnRhaW5zIHRo
ZSB2NCBwYXRjaGVzLA0Kbm93LiBEbyB5b3Ugc3RpbGwgaGF2ZSB0aGUgaXNzdWU/DQo+DQoNCi0t
DQpTdGVmYW4gS29jaA0KU2llbWVucyBBRw0KaHR0cDovL3d3dy5zaWVtZW5zLmNvbS8NCg==

