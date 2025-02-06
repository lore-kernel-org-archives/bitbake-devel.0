Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200FFC02199
	for <webhook@archiver.kernel.org>; Thu,  6 Feb 2025 12:46:35 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.34])
 by mx.groups.io with SMTP id smtpd.web11.39945.1738845985725419109
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Feb 2025 04:46:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=zAtbBfzq;
 spf=pass (domain: siemens.com, ip: 40.107.162.34, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u/h2eGvSZosC10ZIguxNyXbSe/BqplRUe8hLuPN7sw8NRmX0852UnkgJ8I9yCdb9h1Z1RkPwSGsFH/q1idIFpnXG7LBcpsxsYS1HNOMOqPSY/KxWuT6WZ8dJgLwn6KeiWNxZbcQosA2azAbvmkpzOdED9hshHv6KLepjkIuzw+cMyzgs3Vy8tQptdKRKR/td93/HxvskTTiyKFuMMKWaQykiSg14iE3RLRQ6fxpYgGB1mpcYkkU1Yagb6XJQi3b+wWObndrQ2C6ZobyrGfLv/hKgHQgW/aYx/hs4HX/6IBAsbnSIa6whldGYLOKuHztgK347TJJwYwkGorKSNhgZ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VoSIUGX6ttIp6syksNV7cNvkllp4a5fb4PRMfQLsUog=;
 b=XF1YRt9dEP7zYhqbPnsL8Ws8heNTa/TYQMNQjYOSGEDWgUDJxnQd4ymFIidfk9Dj+onoadP00YKqbv+1AXux8tad749WuqRPd9YBiiH2ljE76EqPnvg787aIHiX1UBZtEWzMhGjzNwp0DOygYpg36iYP639UwBG3ingdytUdRpxbDbtKKwZNnDDinXiUDARyoLVnKcrynw5E79+W20W+e/mL59qoC0C7s/5ljjrbKfpZZjD8oJb0JJfaSv7HkwCbWQ7Lzp7y0lpvsZdNPJl/n64ow4bDTgdlR0po/Wx+pZzkkhXx3etuwZpXE1dxovM6GLzygxjjqQKrs2HFx+SG0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VoSIUGX6ttIp6syksNV7cNvkllp4a5fb4PRMfQLsUog=;
 b=zAtbBfzqeO+x/1lMBZxjLXKJjtEQdfEzH9+5EsKke5smbpqU0dx2lh8kOgDTyGTX066fcCBMvoEXnHPKRYt8EIgS8mYUQe42l1TNxV8C83bfSqJsoh0YZcNTdSAcAyGx9mivBDLDglICeh4tldAGEK+uTKop5Xp1NuJldFIR1wiXOvtU699f4RStti+i4OQCe7GntM00u1u80rXBGJsi+DqugKigX1x1X8a2wS0gpeaf3jB6g/l9BPnduYY46CQpIE31xs3hI7PY5395N50ad2gkAVwoNbCcJKTIJonk0YCF4+etgfEbPwW1u52bNNPmPD6a+dU17qpJpAg8DCRI4Q==
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by AS8PR10MB7897.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:63e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.8; Thu, 6 Feb
 2025 12:46:22 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%6]) with mapi id 15.20.8445.005; Thu, 6 Feb 2025
 12:46:22 +0000
From: "Koch, Stefan" <stefan-koch@siemens.com>
To: "alex.kanavin@gmail.com" <alex.kanavin@gmail.com>
CC: "Sudler, Simon" <simon.sudler@siemens.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
Subject: Re: [bitbake-devel] [PATCH 3/3] fetch2/git: Add offline build support
 for LFS
Thread-Topic: [bitbake-devel] [PATCH 3/3] fetch2/git: Add offline build
 support for LFS
Thread-Index: AQHbckBcDWBJnBHVdEOmlJresdHoWrMtshqAgAyTpIA=
Date: Thu, 6 Feb 2025 12:46:22 +0000
Message-ID: <02817db7f4020686a3bf5d2d442e6360c1a98e68.camel@siemens.com>
References: <20250129112406.1660522-1-stefan-koch@siemens.com>
	 <20250129112406.1660522-4-stefan-koch@siemens.com>
	 <CANNYZj-gmzhd+=fC1fd0fbcgHGODLqWtK=8tis6jhqpm-RV_wQ@mail.gmail.com>
In-Reply-To: 
 <CANNYZj-gmzhd+=fC1fd0fbcgHGODLqWtK=8tis6jhqpm-RV_wQ@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR10MB4959:EE_|AS8PR10MB7897:EE_
x-ms-office365-filtering-correlation-id: bc560ff2-47cb-4ddd-755b-08dd46ac42b9
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|4022899009|13003099007|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?VFdrUm5vaEg5QUMyNXlxc2JoazIvbWg0N012QzgxMTNlaGFIZFUvWU5oU2h2?=
 =?utf-8?B?ZlEvZGIyZy9LOVNPQXJHNkNmZGRkejVLbkF5VkNyMTNyZ1ZzOW4zczNUOXA2?=
 =?utf-8?B?ZzdDUVZWQy9kK3haWWdvb2dKeHVML3BhL3lLWUtucS8rOVM3NDFPSUd3L1Yv?=
 =?utf-8?B?WTYyaENPa21ZQXp0bUhTZk1HRWJBRUhNSlVIOHpkV25ZSW1Nb2NOcDZlM1Fn?=
 =?utf-8?B?L1UwRGFBazI5WWtkeSs3a3U3bzdhOU9sQzU2b2VYMk1NaTNqMkFxYkltZXJP?=
 =?utf-8?B?bGJOeTIvd3ZiMW1MZ29qdFJLL0Uybmd6UU5mRnNaUG1kZDdVUDNrVVlWQ29I?=
 =?utf-8?B?V2RHRmRDZ2tvMkFVd3pxTnE0ajNreWlMT3lWNTFKVXpFODlSKzNZa3VuYjc5?=
 =?utf-8?B?cUNKdnF2UUg3WUdYUk43WXBlemVOYVpFUFJCYjU2N1haRzhMN1E1Q1ZENlZj?=
 =?utf-8?B?a1BwdlN1cnY0SUlvejJuNDI2UHZrNTFQbGJBNmN5dlM1ZnAyRUNMUEJrNTQ2?=
 =?utf-8?B?ejczL1cwNjNXQWFDU2krVW1ncFhhdUhpQThNbS9NNUtOYm5aOWJQZUt6a3E3?=
 =?utf-8?B?bDVyVUJ0V1JDRGQ0VmUrV0NzcWdMNkRGejJqWmtSTnJIcG85WDZKRUZid3pB?=
 =?utf-8?B?Rzdvd013dXZLUjZsRlhUQmxDTU4zRlBZK2pQR0d1Ulc1SmpYbU5QNnZraVV1?=
 =?utf-8?B?MVdGNGlINk1EamtFRiszK0xCK2JhR1ZsbU5FeXBGTjI3aG1GeHNHRUJQYTZN?=
 =?utf-8?B?dXo1RkRsVFQwRWRiajZOK2RYSG5PaERQYTJ6SFBrenFXR3VDVWxYYitGWUp4?=
 =?utf-8?B?RnVvY0NlQ0JoZTlKRGVCcFBMMThnc0xIVXhUMTMzczUwdndRVUtCbXEzRkdZ?=
 =?utf-8?B?VlNoL3M3UWNabU9idTVGcEtKczRxajhoVzRlSksyZ2hXSHZUU1Zha3AxY3RV?=
 =?utf-8?B?QjJmUzdrTExDRlVVemdvQ3JReWRISERsa0JhMFNjWVlYbHBuWHU5TkJ2OFM2?=
 =?utf-8?B?c2ZtbFFSMTFUV0hEVDU4MDExQWlSRFg3WkFZRENFZVJtYzV5elN6MTRVdG0v?=
 =?utf-8?B?dEZYOU52L3BUc2NmQjd2eWNFQWtjdEtTUXRSWlAvQ1NlcnBoVzliQjdLaWU1?=
 =?utf-8?B?M0tncVFLa2dneUM4aFExNlkvOWI3b2NDbS84UmM0TXdCeFB0S0JHVFg0ZlJW?=
 =?utf-8?B?ZHlQajM4UmhmQzFIbEN0a21uZ1QwK21uNTI5WW5HcVFsT3pSaEdIT08yQlRL?=
 =?utf-8?B?cXdXNkhQM1NkTlhKb1JRYk5sbW5qa1YrSDlQZUw0WEVtMzNQbGpJc096NWNU?=
 =?utf-8?B?NTZiNU9UZS82ZGVGSXQzcnJ3MGVQNzdqZ25mK0liMDVHeUNkVXcyQ29uMmxS?=
 =?utf-8?B?ZXh4QTA5dk0xTHJTdll0MFBWQkFrYVlsQjM3dDJOcnF4Q3A5N3NPQUJ6QkVQ?=
 =?utf-8?B?TW9mT0tSV0tUSWpYanY0VUkrRituMVZFQTFZM3VuZFpTaE5YVDFQVnNZRnRC?=
 =?utf-8?B?YUt1aks3aEM5TXVyLzhINzh5cXBDeFVTS1EySGpJM3EzUXRtVjg2Y0RtMlJu?=
 =?utf-8?B?RnUvYVcyTlUzNWhCWWRTOGVUUm1uZEgyR0h6TldmRWtvYnA5WnFsYUhZSmFR?=
 =?utf-8?B?b1pNMldVQWhrNmk1VnVSb2Njd2xDV1I0dUxiSW1JanA3SThkNW16WHVKWXdB?=
 =?utf-8?B?eWhaMlZ3dFVtT1VrN0VYUWpaMENUQW1pRXljNU9JYUhhRzVncUNWWDJZU0p4?=
 =?utf-8?B?UW9ZUy9TWnNjOENLTktKdy9nRzN2TnlzbFRvQnBVa1BobjNETnRTamllaVVz?=
 =?utf-8?B?L29GNVhPbUw1dW0yQnRBUmZXS0Z0MmkzOW1XcWZCYmN6T0ZaTzMvNnRaWDZF?=
 =?utf-8?Q?nv5lWYQCn3HiB?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(4022899009)(13003099007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dWRHVHpMVUcra1BsKzd4WUszS2dydW1LS0dlM3ZpTUE1djIzQmJRTElqOWk0?=
 =?utf-8?B?SmM2bnkvVlJWcDVJZFA0NmNqUmNMTk1MYzBDMW9Ndlh0cHA4RnRKbFR0eUIr?=
 =?utf-8?B?UlhleURUZllUNm1TVk5HRy9FNE1qTGM0Z3dzMHZJem9oTmgvNTBrbzJraU9o?=
 =?utf-8?B?U3B1VkwyNHc1Unk2ek1TQ3BUNjVzZFJvOEpOb3NTOUhOUUFHTXVwK0ZxaVNG?=
 =?utf-8?B?UWZQakVkK3N2ODl0blBrNCszTmxVQ1ZWTEF1UmdvY3JiNVhEQXZKakxjSjVk?=
 =?utf-8?B?MWhCbWNEQTFIc2hEZTlZUGZjR1VURlViNWgzQlkrZEQvS2UycEtjdml6MDBq?=
 =?utf-8?B?OXhuR3crcEpWbWNRZ1M4YU12UXNxNGVGMlUxcXhUTFRqWFd1L2JRQTEwMHp5?=
 =?utf-8?B?SEVpRHptZWxSeXdteVVPc2lmbW9ZUXA5WWxqVEczSi9lVFpWZjRzeURWOSth?=
 =?utf-8?B?elZCZmxpNUxZRG56TGJOWXoxQ2hDeGtUU3lBWm92Y0lOdXZuam1PbUFscU85?=
 =?utf-8?B?dDNHTUZ2djRYTjFqR1ROSmZNTElpbmZwdEZCT2VEVjBPd0d1T2xQVy91ZnZP?=
 =?utf-8?B?VE5lOVdiVGNFbUVBL2hsN3RnallodGpKQ0VmSkhTNmJJMWRBejNMU0k1NjFj?=
 =?utf-8?B?UEo4WHhiTHFGUXFiaWdkMnZ6RlNvNWlVd2NjZGJFRFh4YWVBWlJSYkdUMS9p?=
 =?utf-8?B?V0xpYW5VZTJvU2REdDc4QklpTUJ0WktBR2dJcmhUNEozR0xZQlJMTWFNaEZO?=
 =?utf-8?B?aFVrRHlrZ0J4TTRQbTdtUG5YT25UQ2x0Q2FqNHpVNkMvT09QU2JpV3dLSXRC?=
 =?utf-8?B?dDQva2lrTk1lZG9lNFYzNTlZY0Y2bkRVV00yakh3Q0I3UXlDd3lqSWlmdXFs?=
 =?utf-8?B?c1JnTW42bkNZcTM4M2xPREtmaXY3di9sWHB6dHJHZTk4ZUNWQ3Uzc3lvRUky?=
 =?utf-8?B?NlZ6N0luVE9uRXNHbCtMOHFDQ3F2ZW1BUXpQZE9vMlZkNVl1REs5eGFXejFR?=
 =?utf-8?B?YkpXRkV6R1Q1NmllRy9aSFM3cU1kOHBxOEMzellEYTV1MTZSbkw2Q3NTUkpp?=
 =?utf-8?B?MU8vOVE3T1hGZExHeXplNUdqVWY5TGEvUXU1bGN0V0pQQjdaUlUvdWxDdHhs?=
 =?utf-8?B?eWRrVFpoN2ZmWk5DSWNKYTZIbHJWRlloYmpDVzVQYjJTL2xtZko1OFE4enJm?=
 =?utf-8?B?ZXFQZ3hMY25BQS9jYkpKaVhKWlpRblFZYWtZK21QL3FaT0s5Rms3K0hFckFx?=
 =?utf-8?B?a2RUby9tWE9CVjI3ZDM0WFpQTlUwcGYzdk1xNHc3WjUzQlhTbUQrWmNwTWU3?=
 =?utf-8?B?K2J3V0R6RVM3RGJvMzRKUGhxeU9oZ1RKZFFiYkpyZk5DdDRZa2JKbDluQWh0?=
 =?utf-8?B?MGd5RTFXL3BWdTZnQ01EVUNJWnFlblhzdlNLcll1RlFvaHRtSUM4S2hsR1hh?=
 =?utf-8?B?eDdZRmtCYkhLYlBVY1doTFZVc3N2YUNtSFQ2REtaVHpkY2RSbi9HTWhjR0l4?=
 =?utf-8?B?M0dtZExDR3UwOEhvdzQxQVlOV3BxSXJHSjBiaWN5SDhVNFF2bjF6RkpobUFu?=
 =?utf-8?B?NUYrc3NzZER3bWYweW9jK3FSUERhenMzek52dGhreXBjVnRSUXRhWXBSZDh5?=
 =?utf-8?B?TXkvRGF4eWdkMURueStzZlZvb3U0V3pIUTBJUjNGa0twa1o0Um1zdXVQc3lH?=
 =?utf-8?B?RTJNcWVvL3gvQmZHejRwSTZQMFJjbnpidWtPQmRWOFArNmRUSDBuN1hWenA2?=
 =?utf-8?B?eERIT2NyeTlpanBLMEdEY2wxWXdrRVdOTGVBa3FxRithd3V3ZXBWVEowYTNH?=
 =?utf-8?B?dWhnRTNDdGFhZS9vWWR6UHNQQVZobk5oNjhmUHlQSE5EWi9nK0FVMFZsVkRM?=
 =?utf-8?B?UlpIYmN0Si8ycXFIK1VDUFd1aSt1UWRBdlRXamkwaU5sUHI2WEYxZ21TN1dT?=
 =?utf-8?B?Zm16Vjh5MUZuZlN4ajkwbmxtTGlGQVlmTExjYm5xdUZvSWlVU1FSVnlNNDhY?=
 =?utf-8?B?Zm1pTlQ0U2JVOW11QkIzRVUyL0NmUStGS2x3SXJjdmVJaWtpVWNIRjZWVU5a?=
 =?utf-8?B?dzdkdXNtNWJDQktPY0EzeUw3cGFjUWJiUVJyOWxaZ0Q3eDlMc29UcWJnVjda?=
 =?utf-8?B?K2V5QzJqTHpCUkJiSHdhSmdsNktZNHc0SjV5UkFlTDhsUVNYOHR5SmVNQm52?=
 =?utf-8?B?UUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C65418C645F29B478864D20C048F9E0C@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bc560ff2-47cb-4ddd-755b-08dd46ac42b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2025 12:46:22.4061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6HMbyx01vBYq7BJJgUnvqm2geXa3uEICR/FCZXSinZTupTXc5jxWlR7GiBHzznmw/PS91C13B91dgfTVqwQEXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7897
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Feb 2025 12:46:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17160

T24gV2VkLCAyMDI1LTAxLTI5IGF0IDEzOjQyICswMTAwLCBBbGV4YW5kZXIgS2FuYXZpbiB3cm90
ZToNCj4gPiBUaGlzIG5lZWRzIGEgc2xpZ2h0bHkgYmV0dGVyIGV4cGxhbmF0aW9uLiBXaGF0IGtp
bmQgb2YgYnJlYWthZ2UgaXMNCj4gPiBoYXBwZW5pbmcgY3VycmVudGx5LCBhbmQgaG93IGRvZXMg
dGhlIGNoYW5nZSBhZGRyZXNzIGl0Pw0KDQpJdCBzZWVtcywgdGhhdCB0aGlzIHNwZWNpZmljIHBh
dGNoIGlzIG5vdCBuZWVkZWQgYW55bW9yZSBmb3IgY3VycmVudA0KQml0QmFrZSB2ZXJzaW9ucy4g
Tm93IHRoaXMgZnVuY3Rpb25hbGl0eSBpcyBvbmx5IG5lZWRlZCBmb3IgdGhlIHNoYWxsb3cNCmNs
b25lIGFwcHJvYWNoIGZyb20gZmlyc3QgcGF0Y2guIFNvIHRoaXMgcGF0Y2ggY291bGQgYmUgc2tp
cHBlZC4NCj4gPg0KPiA+IEFsZXgNCj4gPg0KPiA+IE9uIFdlZCwgMjkgSmFuIDIwMjUgYXQgMTI6
MjQsIEtvY2gsIFN0ZWZhbiB2aWENCj4gPiBsaXN0cy5vcGVuZW1iZWRkZWQub3JnDQo+ID4gPHN0
ZWZhbi1rb2NoPXNpZW1lbnMuY29tQGxpc3RzLm9wZW5lbWJlZGRlZC5vcmc+IHdyb3RlOg0KPiA+
ID4gPg0KPiA+ID4gPiBUaGlzIGFkZHMgc3VwcG9ydCBmb3Igb2ZmbGluZSBidWlsZHMgZm9yIHJl
cG9zIHRoYXQgdXNlIGdpdC0NCj4gPiA+ID4gbGZzLg0KPiA+ID4gPiBPZmZsaW5lIGJ1aWxkaW5n
IGlzIGVuYWJsZWQgd2hlbiBgQkJfTk9fTkVUV09SSyA9ICIxImAgaXMgc2V0Lg0KPiA+ID4gPg0K
PiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gS29jaCA8c3RlZmFuLWtvY2hAc2llbWVucy5j
b20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgbGliL2JiL2ZldGNoMi9naXQucHkgfCAxICsNCj4g
PiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+ID4gPg0KPiA+ID4gPiBk
aWZmIC0tZ2l0IGEvbGliL2JiL2ZldGNoMi9naXQucHkgYi9saWIvYmIvZmV0Y2gyL2dpdC5weQ0K
PiA+ID4gPiBpbmRleCA3YWM2OTBiYmUuLmI3ZDM2YzNmMyAxMDA2NDQNCj4gPiA+ID4gLS0tIGEv
bGliL2JiL2ZldGNoMi9naXQucHkNCj4gPiA+ID4gKysrIGIvbGliL2JiL2ZldGNoMi9naXQucHkN
Cj4gPiA+ID4gQEAgLTUwNyw2ICs1MDcsNyBAQCBjbGFzcyBHaXQoRmV0Y2hNZXRob2QpOg0KPiA+
ID4gPiAgICAgICAgICAgICAgIyBDcmVhdGUgYW4gaW5pdGlhbCByZWd1bGFyIGNsb25lDQo+ID4g
PiA+ICAgICAgICAgICAgICBpZiBub3Qgc2hhbGxvd3N0YXRlOg0KPiA+ID4gPiAgICAgICAgICAg
ICAgICAgIHJ1bmZldGNoY21kKGNsb25lX2NtZCwgZCwgbG9nPXByb2dyZXNzaGFuZGxlcikNCj4g
PiA+ID4gKyAgICAgICAgICAgICAgICBzZWxmLmxmc19mZXRjaCh1ZCwgZCwgdWQuY2xvbmVkaXIs
DQo+ID4gPiA+IHVkLnJldmlzaW9uc1t1ZC5uYW1lc1swXV0sIHByb2dyZXNzaGFuZGxlciwgVHJ1
ZSkNCj4gPiA+ID4NCj4gPiA+ID4gICAgICAgICAgIyBVcGRhdGUgdGhlIGNoZWNrb3V0IGlmIG5l
ZWRlZA0KPiA+ID4gPiAgICAgICAgICBpZiBzZWxmLmNsb25lZGlyX25lZWRfdXBkYXRlKHVkLCBk
KToNCj4gPiA+ID4gLS0NCj4gPiA+ID4gMi4zOS41DQo+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+
IC09LT0tPS09LT0tPS09LT0tPS09LT0tDQo+ID4gPiA+IExpbmtzOiBZb3UgcmVjZWl2ZSBhbGwg
bWVzc2FnZXMgc2VudCB0byB0aGlzIGdyb3VwLg0KPiA+ID4gPiBWaWV3L1JlcGx5IE9ubGluZSAo
IzE3MTExKToNCj4gPiA+ID4gaHR0cHM6Ly9saXN0cy5vcGVuZW1iZWRkZWQub3JnL2cvYml0YmFr
ZS1kZXZlbC9tZXNzYWdlLzE3MTExDQo+ID4gPiA+IE11dGUgVGhpcyBUb3BpYzoNCj4gPiA+ID4g
aHR0cHM6Ly9saXN0cy5vcGVuZW1iZWRkZWQub3JnL210LzExMDg3NjIyMy8xNjg2NDg5DQo+ID4g
PiA+IEdyb3VwIE93bmVyOiBiaXRiYWtlLWRldmVsK293bmVyQGxpc3RzLm9wZW5lbWJlZGRlZC5v
cmcNCj4gPiA+ID4gVW5zdWJzY3JpYmU6DQo+ID4gPiA+IGh0dHBzOi8vbGlzdHMub3BlbmVtYmVk
ZGVkLm9yZy9nL2JpdGJha2UtZGV2ZWwvdW5zdWINCj4gPiA+ID4gIFthbGV4LmthbmF2aW5AZ21h
aWwuY29tXQ0KPiA+ID4gPiAtPS09LT0tPS09LT0tPS09LT0tPS09LQ0KPiA+ID4gPg0KDQotLQ0K
U3RlZmFuIEtvY2gNClNpZW1lbnMgQUcNCmh0dHA6Ly93d3cuc2llbWVucy5jb20vDQoNCi0tDQpT
dGVmYW4gS29jaA0KU2llbWVucyBBRw0KaHR0cDovL3d3dy5zaWVtZW5zLmNvbS8NCg==

