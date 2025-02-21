Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D42C021B5
	for <webhook@archiver.kernel.org>; Fri, 21 Feb 2025 17:19:05 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.86])
 by mx.groups.io with SMTP id smtpd.web11.28859.1740158340717972104
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Feb 2025 09:19:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=dlPqO8dV;
 spf=pass (domain: siemens.com, ip: 40.107.249.86, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hC3L++ziD7DU95MCsT9D6ws/BYc0puTQHZVVo5iiDXh7NNYtyg536huIeBOgIje1/+zYY4cAxF1IGXIOSxMxt3v4TvK4M4/n9Ksur4oVqpbkgvwzZGSy6qx4MIsZg6UEsO6VLMr04PKrpC37eXIkdceuwePkNk/Ft8U5Rj5Pnn3vLHpLX+QhUibGvfroKWd441BxIYnqrnHRs1lINxM4dCqNr81enL5KSPhxBynBYcugJYp/JUmgCpwb7dFB6ZNhuZTRkwVPiugmGFIfe3sFoGXxq6NCtL+eVrfUJQE4+8D+hParFBOyCFOs+Lc068aK/dw9NBRwBbI184JwvZZopA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYXszJUdTnVBlC6OZDQjmjqCOiahtg8oeYD/MjlnjZ4=;
 b=zFUZgEPj5iCl3uDQLVrfLnz9iLIgP6vjhZS1EkbXvvuAC+1E/ZzpHm9g6kAL8+giMEGVA8G7uh4Hg17OiP12V+LSIOs00BlcsM2TyAfJdoLSzhpcoj/k6/IkLbf/lbGGJeEuQBKar6NHkrelVqA0hBq9jMpvAtR6GT++6LBBHxlU1vVEEEzf9qk0LKk0Dl9IHl60zVn/HVb3cJ7Ye1NomL9RRH+bVdTcs5fbB0z4M0HkAYq0ASAFPQ8qDJ/VplVt8YjwHad969fioDOu7e1Au6OKYJixQhU3tyVe43bWnia7FAY7cqYxZGt9W3MMxRXcA8QN2T1MfBMb0pJp+61oOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYXszJUdTnVBlC6OZDQjmjqCOiahtg8oeYD/MjlnjZ4=;
 b=dlPqO8dVNDmzl5Jzxagsp59e4i5xWKW0Yb8qKOTxkD0hBkGyI1q6USLrci90q2J5OU3YIYsOeXu8vZRCej+zosKRNRYHuEIJuO/I3ZmF1ghlkrtW0PUiBYw0KS9fVMIF+UmNq/JStNHmS4COjMdqhQJFOj7AjcbeFNgBxNnL4L0qozn7TRgxwo7MZKEFvOjlnX0nRuy8F8P9rBzD0L27v1Z1mDTOL+syGksH7v3dW57MfXAPxqb/6V+gRQnkoXQCojxU8slsmSmAgYBtNujUBXmZ4JhTH3llMjV6sBwRlJ62LWSothLjF9I5fIpqmMW8pNWJTB3eJ0anmc0plWVVRw==
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by GV2PR10MB6549.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:bc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.12; Fri, 21 Feb
 2025 17:18:57 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%6]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 17:18:57 +0000
From: "Koch, Stefan" <stefan-koch@siemens.com>
To: "richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: "Sudler, Simon" <simon.sudler@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "alex.kanavin@gmail.com" <alex.kanavin@gmail.com>
Subject: Re: [PATCH v3 1/4] fetch2/git: Add support for fast initial shallow
 fetch
Thread-Topic: [PATCH v3 1/4] fetch2/git: Add support for fast initial shallow
 fetch
Thread-Index: AQHbg7ywZJqt9JvQhESFPikUXBi+bLNRaFSAgACO24CAAAifAIAAAhgA
Date: Fri, 21 Feb 2025 17:18:57 +0000
Message-ID: <63564006bb0c2045fb19d727e6c6c922f382d9e3.camel@siemens.com>
References: <20250220172706.3850722-1-stefan-koch@siemens.com>
	 <4b9fe64e0fd32de42dfa605be5e3e76b8dd01a58.camel@linuxfoundation.org>
	 <bad4317dc354af35db542247fd5c75071f20da85.camel@siemens.com>
	 <a7dd432e5603a8623a4d06628cc7c36a8eb0a40c.camel@linuxfoundation.org>
In-Reply-To: 
 <a7dd432e5603a8623a4d06628cc7c36a8eb0a40c.camel@linuxfoundation.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR10MB4959:EE_|GV2PR10MB6549:EE_
x-ms-office365-filtering-correlation-id: 78989e2e-74c6-4a03-1e40-08dd529bd338
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?R1c5Q1J4d3h2ZGpsemFGZ0Z5cEo1aUMwQmVrbFRKZjc3a25JZHhZaEpHK2p1?=
 =?utf-8?B?Skx5K2dtcFZoSlUzWUNLOTFkdURWRC9Gc2J5dDM1VVhMM3VSbjZrZW0xKyto?=
 =?utf-8?B?V3creW54UWYyYlI4ekw3TDJ1UFA3OS93RGZwSXlSV3N0eHJpSG1MaUxOV0hZ?=
 =?utf-8?B?ZnBlRFJCTFo1bnFnR2RqbmFIWi9nZlRxalBWOTkzUElscXFmVFQxNDdWcFZX?=
 =?utf-8?B?c3Y4WVJ0S1ZDWUpmSDczTjhJejBTV0V6d000SFN1R1BwblcrQytmZXB0MG5x?=
 =?utf-8?B?eTFYazljU1pEK3drcU56ZHpRWFZ3U2xzRlNTMloyQzBlWThhOG1aQ2R0VlBx?=
 =?utf-8?B?Q20vNzN4MUE3RW9vRk1lbFI5eXg0bkN3dXdwbkYwYVFjazVOMUowQnc1bERZ?=
 =?utf-8?B?QlF5ZnRnZW5wYXp2SWQ0RVdrRUViTkhIWkd5UklDeDhQTVRjaWZ1SWdBTUpT?=
 =?utf-8?B?WEkvN3k0bzhCTnRoRi9RbUhqbnE2RE9aSmlwRXUrMFhVajFMUzcvelcrWEEz?=
 =?utf-8?B?bXZhb0pObVpscW85MGlRZXhhNWdpQS84K21VNmdEVSs3bWM0S0JQdTJGaWNu?=
 =?utf-8?B?MDV5cWdEWlFOUFVHeURRZCtUZjBlOVpJbUxuMjZpemcrTnpyQTE3MmQ1cVJw?=
 =?utf-8?B?d0EvZTBJMFVlbTJBYXFSWVZhU2tXbC96bUVDSU1idTVlRGd0Z2wrYnpnWkxh?=
 =?utf-8?B?bXdSUGhLekZEOVBuYnRQdnZDVytUTllOSngzRTl4WTFRZHdoTGF1dnN3VUxr?=
 =?utf-8?B?Y1dDeFZVZ2E0S0xDMS9Gb0RFK0l3SUU0M1U2QXBtZjFFODBNZVZLRzU4cVZx?=
 =?utf-8?B?QmVVTldxMEJIaWNGOTMzendJZXU3QnlmWk9LWVV1eE4rZ1hOcTdYWjhxamt3?=
 =?utf-8?B?c0lPd2lRZzFqTVV2Nkpid21WNU1TeTZEOFFPRGxGUXNsd1VldWQrZXJWMTAy?=
 =?utf-8?B?bFc5Y05xUWZINFBVVHNQTG5Vcm1vN0E1V09WNCtDOXpMaUcvU0pGM0ZFbU9X?=
 =?utf-8?B?WklDcitLM3BiRGNtUlVmaldoOXdJaDVXcVAzanN1REpSVXNBejV1VW0zajFH?=
 =?utf-8?B?WmJnenlwQzlPK2hGRzY3dGhOd3JsWVNweUsvbytIWTljd2pwNkUydnQ5eU1G?=
 =?utf-8?B?clRMRTFPUDI5ZElOOTJsTlNSYnBNNG5LTHNsSnR5WmhVelNFeXNNcXBMNDVk?=
 =?utf-8?B?LzczVVhEcGFjRTZockVuaW4za2tpZEJ1bXVwSDV0NEwvM2NXN1Q5YmN1Nkpx?=
 =?utf-8?B?aDJBcEZoY1A0eEU4bTJpVklUSVVTaFRweTVWQXNkMG9FSlBkMzYxcVo4NXh4?=
 =?utf-8?B?WWtWTCtQb21jYVdId1MrSW1tWXdlUHVTRllmbWFTemZNbUVzVU5iUmM2Nm9C?=
 =?utf-8?B?c05TaHNtdXh2WFp1SHp6a1ZOVjg3N0NTaTBnWUhWZHRPSUNxRGJubk9wUnJo?=
 =?utf-8?B?eW5tUlJkWlZTMW00Y3ZKb2MvNncycDJTNENTNUQ5Z21DWWZiV3pOMm80Q0Q0?=
 =?utf-8?B?TWc0elBvUEg1K1k3eVdoL1hMd2VnTFlDeExYdjVCSXk1eDl2NFpCSEg4dlVU?=
 =?utf-8?B?dXErRVAwWVFFSjlta0duTTlmTXpzR0VSRkhIWUhaTXdxQ3ovR3dHTUYzdC8v?=
 =?utf-8?B?TU5TbHNSWVdvd0tPWS9QR2xaRmVtTytVWjZ1N0ZrcmF4RUU0M1VmTk1ON0or?=
 =?utf-8?B?amZoQkQzSUl0T081ZVhZSUM3Rkd2YzQzWXR1OGxBOUtBWVJsWWtDNmdwcHRa?=
 =?utf-8?B?ME5UYlN6NklxME91QzlCNE05QWh5dnpFSE1MYXBMSExBcjZEVTF4L05TV0gv?=
 =?utf-8?B?NjN4M2lCQUp4U3FPOG04NVJXVSt6akQ5dFMzRzNZamlhMnd4Y3FUZjE0UVM2?=
 =?utf-8?Q?S4fLqR1hQgK0q?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VmtJKzMvS1VIbEpDa3pkNHlaSFZGanRaRys3eER0VmpwbjlNWE5MUzBLdjhM?=
 =?utf-8?B?RSt2Q3BsZVFvMTJZL2ZjdVowSitFMzF3d1crRkx0ZmhIbTdFdlVBM1l1SG5F?=
 =?utf-8?B?akdxcXhEdm0zQVhtR1ozcnlKWGxZdzBCRVMrMi9XdkNsWm1sdDdhWTVOTTlw?=
 =?utf-8?B?SHBXSm8vREJEVEtBeExpakJ5T1ZuSTNnNzNlOFZET050TFZ5OTgvMmRZWE12?=
 =?utf-8?B?TVlWdXZWQjA3NTNlRHlLM2FHdzVXM1RJQjd5RUJzcXJucUxjbktJcUlIZVhn?=
 =?utf-8?B?NHp0SFpQUnY2UGFUTTJBNU0zOTZpZVpVenJIVzJKRDN4Q3FhZHNRYjVsYkw0?=
 =?utf-8?B?VlFxbFVjWjZzK3dLR0pqOVFveFhhRDZaWS8raGdVUFRtdFlZaktrL1g1ZkNW?=
 =?utf-8?B?dm0zbGI2dy9QOUZUZHF5VC9Wc0paUTlJSTQ4UmoycDI4Yzg5dlU4eUs2d0hy?=
 =?utf-8?B?NnNRa0xTMmNnanpXZko5MXJhWW9lMzdRaEhMSVBRQVFGZU1OSzNxRHBRNDJZ?=
 =?utf-8?B?Zm1rQXhqeThmdUhWYWprdVN3cElEMjNMbWVRY1BHQy9mclRUT202YWZheGZD?=
 =?utf-8?B?R3F0dnNlVlVZcnJENGRaVXIxUFhlZ1BPU3dET0ppTThOUVJBZFVPZ1oxSk14?=
 =?utf-8?B?NXJtT2hjYWRITXJHU01lU1VOOWpxVnhPRWcyMG5ZbWswR1NuTU9GT2wxY0N1?=
 =?utf-8?B?alN6Rk5UeFFmK0h0Ry9hcVVsbkQ3dkFzRjRWYWIxZFoyZE50YWpXUzJpbTJz?=
 =?utf-8?B?Z3YxNUI0QlFrWUpQK0lmVXp3OWZNWWJNS2NZc2dSNGljdTZnV2JWTkxyUnJa?=
 =?utf-8?B?UjRYK1BUV01WL1VocHRvT2VIVnVyaVp0b25Kc1FENUQ0eUgrVjhsUmpsV25m?=
 =?utf-8?B?dWNQZHlLMUpPdm1NYVY5eWF3UnpUQlFmTmJYK2JqQ25UaFI4WEkvbGpyWllY?=
 =?utf-8?B?Z1dPbytzMWNmUWp5bG5tM3J3aVpWd01qVkRHUitCcllncE1rQXV3TGhCQzRk?=
 =?utf-8?B?MERkZ1ZnckMwOFJjYk9TWUhDa1JjSko3WUFvb2xDVVdQN0NBanNmbmtsQ1Zv?=
 =?utf-8?B?ZzJ2SGRSZVFrME1LTmZWRHowSDJrZnBKaDhXc2NSbjhLVHd3MG4zWStRYjRE?=
 =?utf-8?B?WE83ZWtjdHlWYUxLUkhmVTU2a21UdlB6RitOelkzdG5SK3NFMTdCUUJDT3dy?=
 =?utf-8?B?d2poUjk5OGtTcnJOMGNCZStCRjhlV2FKY2loL1lPS080MGllRFBnSmpEd0M0?=
 =?utf-8?B?OTBSV0x3YlNtSDg5a1pnZXdOWEFNVGFWeUNCY3k4b2lZMktLbi9lenlCSnRU?=
 =?utf-8?B?U1dUTzUvZjQ4K1MrQXA1cTBpU1FLdkpYY3dTYXFPeldJR3VGNGI3MmIyYUJh?=
 =?utf-8?B?b3ZtSWFyKzNKWWxHK2JzSjVJa3Y2S0RBbjRQQlVKZFgzODRCK09tRUFkZWp0?=
 =?utf-8?B?SG5GNEV5WDJTRUpoaCtBa2FHMmlHTUZxTi9zeVNSSjVMVmxielBMVGgvTEky?=
 =?utf-8?B?ZHQ0ZldvOWRVeWR5UklmdC82MDFHRVFkb2RESnJiWUw2M1FpbFRrV0lxL2xs?=
 =?utf-8?B?ZmZNVk1aa3QvUDdOSWh6alFzbllSMmg5TTFMMXJ5Rno4K3FSUzZqR08zeTkr?=
 =?utf-8?B?NXZ3VnkwaWtPWGJzRXEzcCtUZUdXS2tQMjZDMGtNUW5rM2tsVGdBSDhySFFW?=
 =?utf-8?B?SHdrMDJFNVhlWVJLMVVxYVZyVjFUb21CUlo0elkxcEVoMVNpOVhKQ2pUS1BG?=
 =?utf-8?B?YU1lRHNXR1diQlQyMGp0aGkzVUIzMG9ha05veEhtTnlML1NjQkREVFUrRU9S?=
 =?utf-8?B?VDJVZng4d3pFMmVJWUtKS2NBMzIrQU9xU3M2dUg5b1EyNVE2Zjg5SUJRQnpV?=
 =?utf-8?B?bGpMQmJCOFFwdjhXWnA1U2JBRjVFMkxOUmdEcTVOdVllam8yR2xPM0FwU0xx?=
 =?utf-8?B?cFphVXhSY2V3cjIwejg0K2MwNUloTW5ZcG5rMnpoNnBYNFNRSG5GNk0vYnV3?=
 =?utf-8?B?ODRyaHJWQm82Mjg0Y1NaL0hRT1BoenJjSVVIRzBUekZpaW04VmpBVGJzdXU3?=
 =?utf-8?B?TnNtOXZTWWEyRVJqNjcrZm5CdHgrcFFySlkvOStkSGs3b1F1Q3NyNDBGUG5h?=
 =?utf-8?B?SEZkWEdibGEyaVg5enJmVWtjTC9NV09KRFhpbzdvcDB0a01Yb2p2cUhsQmcx?=
 =?utf-8?B?OHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <55AFFC8974C4D14A90E570D56CA9A939@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 78989e2e-74c6-4a03-1e40-08dd529bd338
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 17:18:57.3322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ZbBk1RveWhqJGEMzoHb+crXEzdJI3DKYuCENc2QIRfe6ZulaGfGElbqXuisqqS2iv7fqkqJIB5HGMBAEw/BvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6549
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Feb 2025 17:19:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17284

T24gRnJpLCAyMDI1LTAyLTIxIGF0IDE3OjExICswMDAwLCBSaWNoYXJkIFB1cmRpZSB3cm90ZToN
Cj4gT24gRnJpLCAyMDI1LTAyLTIxIGF0IDE2OjQwICswMDAwLCBLb2NoLCBTdGVmYW4gd3JvdGU6
DQo+ID4gT24gRnJpLCAyMDI1LTAyLTIxIGF0IDA4OjA5ICswMDAwLCBSaWNoYXJkIFB1cmRpZSB3
cm90ZToNCj4gPiA+IE9uIFRodSwgMjAyNS0wMi0yMCBhdCAxODoyNyArMDEwMCwgU3RlZmFuIEtv
Y2ggd3JvdGU6DQo+ID4gPiA+IFdoZW4gYHVkLnNoYWxsb3cgPT0gMWA6DQo+ID4gPiA+IC0gUHJl
ZmVyIGFuIGluaXRpYWwgc2hhbGxvdyBjbG9uZSBvdmVyIGFuIGluaXRpYWwgZnVsbCBiYXJlDQo+
ID4gPiA+IGNsb25lLA0KPiA+ID4gPiAgIHdoaWxlIHN0aWxsIHV0aWxpemluZyBhbnkgYWxyZWFk
eSBleGlzdGluZyBmdWxsIGJhcmUgY2xvbmVzLg0KPiA+ID4gPg0KPiA+ID4gPiBUaGlzIGltcHJv
dmVzOg0KPiA+ID4gPiAtIFJlc29sdmUgdGltZW91dCBpc3N1ZXMgZHVyaW5nIGluaXRpYWwgY2xv
bmVzIG9uIHNsb3cgaW50ZXJuZXQNCj4gPiA+ID4gY29ubmVjdGlvbnMNCj4gPiA+ID4gICBieSBy
ZWR1Y2luZyB0aGUgYW1vdW50IG9mIGRhdGEgdHJhbnNmZXJyZWQuDQo+ID4gPiA+IC0gRWxpbWlu
YXRlIHRoZSBuZWVkIHRvIHVzZSBhbiBIVFRQUyB0YXJiYWxsIGBTUkNfVVJJYA0KPiA+ID4gPiAg
IHRvIHJlZHVjZSBkYXRhIHRyYW5zZmVyLg0KPiA+ID4gPiAtIEFsbG93IFNTSC1iYXNlZCBhdXRo
ZW50aWNhdGlvbiAoZS5nLiBjZXJ0IGFuZCBhZ2VudC1iYXNlZCkNCj4gPiA+ID4gd2hlbg0KPiA+
ID4gPiAgIHVzaW5nIG5vbi1wdWJsaWMgcmVwb3MsIHNvIGFkZGl0aW9uYWwgSFRUUFMgdG9rZW5z
IG1heSBub3QgYmUNCj4gPiA+ID4gcmVxdWlyZWQuDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1v
ZmYtYnk6IFN0ZWZhbiBLb2NoIDxzdGVmYW4ta29jaEBzaWVtZW5zLmNvbT4NCj4gPiA+ID4gLS0t
DQo+ID4gPiA+ICBsaWIvYmIvZmV0Y2gyL2dpdC5weSB8IDEwMCArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0tLQ0KPiA+ID4gPiAtLQ0KPiA+ID4gPiAtLQ0KPiA+ID4gPiAtLS0tDQo+
ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNzQgaW5zZXJ0aW9ucygrKSwgMjYgZGVsZXRpb25zKC0p
DQo+ID4gPg0KPiA+ID4gSW4gdGVzdGluZyBpdCBsb29rcyBsaWtlIHRoaXMgc2VyaWVzIGhhcyBz
b21lIGlzc3VlIG9uIFVidW50dQ0KPiA+ID4gMjAuMDQNCj4gPiA+IHN5c3RlbXMgKGJvdGggeDg2
XzY0IGFuZCBhcm0pOg0KPiA+ID4NCj4gPiA+IGh0dHBzOi8vYXV0b2J1aWxkZXIueW9jdG9wcm9q
ZWN0Lm9yZy92YWxreXJpZS8jL2J1aWxkZXJzLzIzL2J1aWxkcy8xMDk3DQo+ID4gPiBodHRwczov
L2F1dG9idWlsZGVyLnlvY3RvcHJvamVjdC5vcmcvdmFsa3lyaWUvIy9idWlsZGVycy81NC9idWls
ZHMvMTAxNg0KPiA+ID4NCj4gPiA+IFRoaXMgaXMgcHJvYmFibHkgZHVlIHRvIHRoZSB2ZXJzaW9u
IG9mIGdpdCB0aGVyZS4uLg0KPiA+DQo+ID4gVGhpcyBpc3N1ZSBjb3VsZCBvY2N1ciBpbiB0d28g
Y2FzZXM6DQo+ID4gYSkgb2xkIEdpdCBjbGllbnQgdmVyc2lvbg0KPiA+IHRoaXMgY291bGQgYmUg
cmVsZXZhbnQ6DQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvZ2l0LzE2MzA0OTY0Njc4ODEu
MjAzMDQzOTA0OS40MjQ3MjUzNTUxQHZpdmFsZGkuY29tL1QvDQo+DQo+IEkgc3VzcGVjdCB0aGUg
Z2l0IHZlcnNpb24gaXMgdGhlIGNhdXNlIG9mIHRoZSBpc3N1ZS4NCj4NCj4gPiBiKSBHaXQgc2Vy
dmVyIHZlcnNpb24sIHRoYXQgaGFzIGRpc2FibGVkIGFubm91bmNlbWVudHMNCj4gPiBzZWU6DQo+
ID4gaHR0cHM6Ly9zdXBlcnVzZXIuY29tL3F1ZXN0aW9ucy8xMzQyNTQ3L3VuYWJsZS10by1mZXRj
aC1wYXJ0aWN1bGFyLWNvbW1pdC1oYXNoLWZyb20tZ2VyaXQtZXJyb3Itc2VydmVyLWRvZXMtbm90
LWFsbG93LXINCj4NCj4gV2UncmUgdGVzdGluZyBhZ2FpbnN0IHRoZSBzYW1lIHNlcnZlciBhbmQg
d2Ugc2VlIHNvbWUgcGFzc2VzIGFuZCBvbmx5DQo+IGZhaWx1cmVzIG9uIFVidW50dSAyMC4wNCBz
byBpdCBpcyB1bmxpa2VseSB0byBiZSB0aGlzLg0KPg0KPiA+IFNvLCBJIGhhdmUgcmVpbnRyb2R1
Y2VkIHRoZSBzd2l0Y2ggZnJvbSB2MiBwYXRjaCB3aXRoIGludmVyc2UNCj4gPiBsb2dpYy4NCj4g
PiAxLiBlbmFibGVkIGJ5IGRlZmF1bHQNCj4gPiAyLiBvbGQgYmVoYXZpb3VyIGNhbiBiZSBmb3Jj
ZWQgYnkgdmFyaWFibGUNCj4NCj4gU28gaW4gQ0kgb24gdGhlIGF1dG9idWlsZGVyLCB3ZSBuZWVk
IHRvIGZvcmNlIHRoZSB2YXJpYWJsZSB0byBhbGxvdw0KPiB0aGUNCj4gc2VsZnRlc3RzIHRvIHBh
c3Mgb24gMjAuMDQgaG9zdHM/IFdlIGFsc28gbmVlZCB0byBlcnJvciBpZiBhbnlvbmUNCj4gZW5h
YmxlcyB0aGF0IGZvcm0gb2YgZmV0Y2hpbmcgb24gMjAuMDQgaG9zdHMgdG9vPw0KDQpNeSBjdXJy
ZW50IHY0IGltcGxlbWVudGF0aW9uIGRvZXMgaXQgYXV0b21hdGljYWxseSBpbiBmYWlsdXJlIGNh
c2UuDQpCZWNhdXNlIHRoZSBkaXNhYmxlZCBzZXJ2ZXIgc2lkZSBpc3N1ZSBpcyBwb3NzaWJsZSBh
dCBlbmQgdXNlcnMgYnV0IG5vdA0KQkIgQ0kvQ0QgKHRoZXJlIG9ubHkgMjAuMDQpDQo+DQo+ID4g
My4gb2xkIGJlaGF2aW91ciBpcyB0cmlnZ2VyZWQgYXV0b21hdGljYWxseSBpbiBtZW50aW9uZWQg
ZmFpbHVyZQ0KPiA+IGNhc2UNCj4gPiAoc2VlIGFib3ZlKQ0KPiA+DQo+ID4gSSdsbCBzZW5kIHVw
ZGF0ZWQgdjQgcGF0Y2ggc2VyaWVzLg0KVGhpcyBwYXRjaCBzaG91bGQgd29yayB3aXRoIDIwLjA0
LCB0b28uDQo+ID4NCj4NCj4gSSdtIGFmcmFpZCB0aGlzIHNvbHV0aW9uIHdvbid0IHdvcmsgZm9y
IHVzLiBXZSBlaXRoZXIgbmVlZCB0byBmaW5kIGENCj4gd29yayBhcm91bmQsIGZhbGwgYmFjayB0
byBhIGRpZmZlcmVudCB3YXkgb2YgZmV0Y2hpbmcgb3IgSSBndWVzcyB3ZQ0KPiBoYXZlIHRvIGRy
b3Agc3VwcG9ydCBmb3IgVWJ1bnR1IDIwLjA0IHdpdGhvdXQgdXNpbmcgYnVpbHRvb2xzIHRhcmJh
bGwNCj4gYW5kIGJ1bXAgb3VyIG1pbmltdW0gZ2l0IHZlcnNpb24gcmVxdWlyZW1lbnRzLg0KRHJv
cCAyMC4wNCBtaWdodCBiZSBwb3NzaWJsZSB0by4gVGhlIEVPTCBvZiAyMC4wNCBjb21lcyBpbiBh
IGZldw0KbW9udGhzLi4uDQoNCkkgd291bGQgcHJlZmVyIHRoZSBhdXRvbWF0aWMgZXJyb3IgaGFu
ZGxpbmcsIHRvIHN1cHBvcnQgb2xkIGdpdCBzZXJ2ZXINCnZlcnNpb25zIGF0IGVuZCB1c2Vycywg
dG9vLg0KDQo+DQo+IENoZWVycywNCj4NCj4gUmljaGFyZA0KPg0KPg0KDQotLQ0KU3RlZmFuIEtv
Y2gNClNpZW1lbnMgQUcNCmh0dHA6Ly93d3cuc2llbWVucy5jb20vDQo=

