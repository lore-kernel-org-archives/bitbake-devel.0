Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D31C021B3
	for <webhook@archiver.kernel.org>; Fri, 21 Feb 2025 17:31:16 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.70])
 by mx.groups.io with SMTP id smtpd.web10.29122.1740159071328104661
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Feb 2025 09:31:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=qpvLzwd4;
 spf=pass (domain: siemens.com, ip: 40.107.22.70, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r+nVLll6x6JCIsHNJSg/s7SK1bl3QvohvLYqgHXJXs5GUPDM/Po3nLB4TJf6yOkZqUvk983GFV2NVVkIB2OtnJ+qCLAWRCBO2ePT7+MjivPYnkKnZHJ6j8CP6iSmNm8YgMcrDs6fybsyk/MUObwT4NJRvMF6eJjsFCKx1ndtdwdLB00yK9cFz4mhtnzCzTXD6NKCjQKmyoSRBUX2Qn/+Z3h0DF0ZlBm43B7fJ4Api4J4T4ul71hRpSEtEjxkV3xVXpgOpvZQNxF143Cijc/Bg3qBXbbHRI3EmpcLC+UvzHNv88GdIXy4CZ/2fY33SFyF0Lfzc9TvI5JBqqVoUdyv/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Omsdx/PEVIgNwYeC/Fr0RIRtO4xYvzP+0oAB7SXlmxs=;
 b=LMmT6TmUdD62d8TsKaDsoZplkgrhr2Jf81iuPGO2DX6vlPughgy9bQUn4AOaPNS2G5GcIzMFAFcI+cjLhJvVicahdqaacR46kH74gWJd1snvT0tbq9plWBS8aflgD5ISt8Tu+sV6njuTmF+9UkTzrYJD1kepMPu2gZLynpMPgTlW1MOyJea5ctM3ta2tRpZXt+Hu1tNVQmZGt74Mog6YtPB7YEogfXsZYTfjT4nGyntieauKXMX3oPuvARnxzeLpT9OF1l9VowfoPd70k7rWXiJLpXfpF0bqBWdrFlSMfs3LAvFP27vr93SrC7xs9lz/Ege8mkBSIZwEh+G3jwIAfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Omsdx/PEVIgNwYeC/Fr0RIRtO4xYvzP+0oAB7SXlmxs=;
 b=qpvLzwd4iYc/RtGap6aKnlKTdCQIOzbxJaeMTmxg6/SowPFsU1xnGdQoNywHlXyPczDU29FZnSK+4ZZfI3VhMIaa8iOlHnj023SkzCXmLFg5c0pIrsbsxxppb3oiSOllowRi3CaZyc5a91xC5/zKRWRkc6fvha+xsrWTm8bCdkCL44VVjt0k2650jgu/RtzlnvOftBtipDhCyMyZ9o88cJyOCkOnoBf1ieSsD/OZEh1TUEgHLfjo15moHKdnP9yjL9ojWTzBtdnvlaXdUeo00IR9DN9kLH3w4FxCwKuIxJSa4FB9Jq3UeIOe34X5En9w4OKXfLfME7kRJ6gQiw34Xw==
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by DU4PR10MB8514.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:562::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Fri, 21 Feb
 2025 17:31:08 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%6]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 17:31:08 +0000
From: "Koch, Stefan" <stefan-koch@siemens.com>
To: "richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: "Sudler, Simon" <simon.sudler@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "alex.kanavin@gmail.com" <alex.kanavin@gmail.com>
Subject: Re: [PATCH v3 1/4] fetch2/git: Add support for fast initial shallow
 fetch
Thread-Topic: [PATCH v3 1/4] fetch2/git: Add support for fast initial shallow
 fetch
Thread-Index: 
 AQHbg7ywZJqt9JvQhESFPikUXBi+bLNRaFSAgACO24CAAAifAIAAAhgAgAAA/oCAAAJoAA==
Date: Fri, 21 Feb 2025 17:31:08 +0000
Message-ID: <828c48b7b23582c488ea6a995f79899de1c29a5c.camel@siemens.com>
References: <20250220172706.3850722-1-stefan-koch@siemens.com>
	 <4b9fe64e0fd32de42dfa605be5e3e76b8dd01a58.camel@linuxfoundation.org>
	 <bad4317dc354af35db542247fd5c75071f20da85.camel@siemens.com>
	 <a7dd432e5603a8623a4d06628cc7c36a8eb0a40c.camel@linuxfoundation.org>
	 <63564006bb0c2045fb19d727e6c6c922f382d9e3.camel@siemens.com>
	 <9082e1118f69c59eafbdffd0d41fe118799a2edf.camel@linuxfoundation.org>
In-Reply-To: 
 <9082e1118f69c59eafbdffd0d41fe118799a2edf.camel@linuxfoundation.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR10MB4959:EE_|DU4PR10MB8514:EE_
x-ms-office365-filtering-correlation-id: 1e74f51c-9047-4721-1c0a-08dd529d86dc
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?cTZwblgvYmFHMmNLeTdERkhBZy9GMFpFQmxySkJGcnYzaUZuVkNPcTJYRVg5?=
 =?utf-8?B?YjQ0MkExSmYrVCs4eUI3Yk9nU2p2cEJNRHNHbHVuR1RpQU5hdmg2UkJyNXM4?=
 =?utf-8?B?b0xhc2hCTE9EckQyQU9aREFmakpxalgzd1pkeUhWTHBsaUYvbXpacnJId3E1?=
 =?utf-8?B?MVI5bHZmNUdlSWZxNS9OSjBlK010ZHlrNmFoN3N3RWF4Wm9DNkY2Rk9QY1J5?=
 =?utf-8?B?RnlqRHQwUSt6WFdzaUFvcHNDUVNzU2d6aEp5eXlKakdoVE5kVjVlTzViek4v?=
 =?utf-8?B?b2V6dTVDZWNMTFd3eWI3aG5QUnJyLy9nUWsyS3U1NE5IeEdnMm5WUVV0ZG1k?=
 =?utf-8?B?eDZWQzZBeFZ2Y21qSkhLTGFhcmFIYVg0UTM4c0dZem9abWd4WHhzODZic1hZ?=
 =?utf-8?B?c1hXcHUxY2JrT2ZpOUlqSGJpQndDWEFHbGJ4TDZGWlhtM3YydThoemtYUis3?=
 =?utf-8?B?OXRYWE1NOCtiV2FHYm9IWm52SzdGWTZ5eW5WT25EWFpSL0dNbkRRa2M0TGxF?=
 =?utf-8?B?YzhCT0g0QXFrZGdvVUdEck5OM2VsRGN2NFhLUm10Z3FNOXhWazZWd2kxUkNl?=
 =?utf-8?B?OXE5U1ZNditkV0VlQkl3QmdRVFp5Ti8rVDFaWWpJYzA3TFNKdkYrUmRPWjYv?=
 =?utf-8?B?Z1ljVStXMmJvTkJDUTdudGk0TFo2czF2QkVHTG1tbGNpeG5lN0ZrenhsTkNz?=
 =?utf-8?B?cnlCY01jcjFIWk1ubFdtekVYUUtoRXpTVkJteHcxSVh1enpYcGNIMWNDNmha?=
 =?utf-8?B?L0d0YngvdjdCcDllbGUzQThtK1QrVkxScmhCMllBSUtjUklXMzM0TVl5SFNZ?=
 =?utf-8?B?eVdBOUlSemZQVzIxTWdpL2p4T092Zm9QeEUwc1AyVFNtUXFzdW9XcEJjSmQ1?=
 =?utf-8?B?dU5McERGbmtNQlZOTmVneUZESTRFdDhPcUIvVm9KSkd0V0NtN1MzdU1wVHFS?=
 =?utf-8?B?NnF4alR0NGRmU016TWIycjJqOGY2UmtrOUFXYTRHdzFQTndHa29hRWVPWjNJ?=
 =?utf-8?B?NHhvK29MaEtTMTJ4YWpoQ0tGOFdVQXpoZ2tMdzFKSHFkL092S2tnMjdxeTNX?=
 =?utf-8?B?MUhQWmdyZEY1c0JHN2l2VmhuZ2JvWFJ4ZXBzTXNtd2UxZENkZC83SkVCSjVL?=
 =?utf-8?B?RUlhYTFlNjBhc0VUbzZ4R1ZxSk5yOVlzeVlWUW43WmVScERNOGd6OFpMVFMx?=
 =?utf-8?B?ZVR0S0VEcG10elptKzZwS05YQzFFVUxucXg0eWROQjNGREwrU1hLUXliWm9w?=
 =?utf-8?B?c3ZjdWJWemRDazU0TThERkZKb3phQmx6MUE3SVBmNDMzaTdpLzZlTUFIK2dp?=
 =?utf-8?B?cEhLbk9pZzMzTzlCeFdXdHBFL01qNEVmMlh3L3k3Y1FjajMrZzJNL3FHejFT?=
 =?utf-8?B?bjB3MHV1dWNCckIycGNadnhmZHE0ZEovS0doRjZrZnNtTFNUOGFuUDM1YmJz?=
 =?utf-8?B?bWJEWVpxSm5ra3BBTjdyZ1ZiUVJ3TXdTOTJPOVBkZFVYK1pPS3kxbkhZbWpz?=
 =?utf-8?B?OHNlMjNNT0NwTVhkSkxwNkRSRkVsYWdycUlqdTFVVmhRRDFlLzZqQUd6VTFZ?=
 =?utf-8?B?dm5Wc0M1aDhmR2NvblRiK2Jyci92RkVvNFU3dWxVdHNrM2xZdGRHWnMzcUJy?=
 =?utf-8?B?eEE5Y3lhcXpXeWwxbzNZTHZPN1U2TzIzTHFxRzdXVEUzVTFEU0loV1NmSGRp?=
 =?utf-8?B?TEtlenpTckRpa1ZwcWxDbDRXV0NsS3BBdWZuL3VOTlFCbkxPUXQyRkJrNHZT?=
 =?utf-8?B?aU1QUHo3MGhJSi9adk5aUW1SakU5SGI0dzFaNDBMeDNSTlpLTnZRQ3hiYWNo?=
 =?utf-8?B?U0hCaFFQNk5lbFNwZGxnT0J1eW9taTZHQTVMcjhCOXNEZTI5S2tYZUpHT28w?=
 =?utf-8?Q?9Lhc3Cvl2xhby?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?d0FLMmFUR2gyOUgrd2xTR1Z4TFljT0VJWmJ0aitCcDlkdldra0QxeXlLZFZn?=
 =?utf-8?B?WW8vaE91M3hINk4wSFpOL04raVpkOWJla2FXMzdyd3p1ZUtlQ21ycytIajVS?=
 =?utf-8?B?NW5LSW8yUDhKU2ZQdHRHSDNCdFNnRGpvMVE2SldUVHZDbiszTEl5T3pQcHls?=
 =?utf-8?B?NVNNL1dqbFVxSTFvZ25wMTlzWlkxdmJVNk9iZWVnOWFxWWRnRDZGUW16M050?=
 =?utf-8?B?dVNrWmQ0Y1NRZTZ5UEdLbUxpSEpTS1ozWU41akFZZGJicGFsbm5JK2p4dDVw?=
 =?utf-8?B?ZHNreFdyTVVZb1B6bkRlSUpPUmRqTXorSE5CZERXUG1BK2Q0blpRWlphdVho?=
 =?utf-8?B?MDBJUUk3ZExPNlNOaThRaHNaRWRZaEQ2WDBkQXUrVXZ0MElGQzlkSjZEMEpN?=
 =?utf-8?B?MWFRVUhaaSt1WTk0WEF5UFJWUWNRSktZT010N2ZXem42d2VrTndvWnlKTWRV?=
 =?utf-8?B?YzJrV1BmRFpLUVlwcTJ3bWVaNFJjSVh5cDgyTk1YeGRkQStMZXpadWZGYXFG?=
 =?utf-8?B?NE4yU0RjbFk1a2twOWxjVDdqMy9RbUhYbW1WOEUwMVBHUjBRcVVQdnA2TThW?=
 =?utf-8?B?VWw0S0N4M2wzNVFSaXJESEh3WEJuRHRPc2pPbnJOZHpadEJMeklNWTBaN0FT?=
 =?utf-8?B?NCt3ckZNSGVRNGdRZHlCZTVpTzJlK0xIanlqMVlqaXNvL1FjZ0h1Sk5lazNL?=
 =?utf-8?B?VHo2N2Q2cVJRZ29zTHJERHRySkdwUmNmNTlxZ2JTRGQ4QTFqK1JxRmRaUEF3?=
 =?utf-8?B?TTU3S2RCRjEyQUM2NEtZSzRTbk44TnMzVGU5d1JOUks0dVF0TktxR2VPZjhx?=
 =?utf-8?B?cnlWdmc0dnllRWJLY256N0tISXN4SW1kYXRCc2MvRW0yaWdueldYSURCdWtz?=
 =?utf-8?B?ZW9XaFhaelZGWmFZdTlYSVczdk1nUHJEZzdOOUhpMUdaU2ZlQVVQc3pVaHE5?=
 =?utf-8?B?eXZLNnpPUHp6L3pZYWQreDlmQUNSRnllc2FQTGY2M0lvSXQ3eVNXQVlzWkY3?=
 =?utf-8?B?WFRhN2pGQnJKL3FTK2J0Um5SYk41ck9OUFZaMFlkZTRQaUpKZllBZmt0SnhK?=
 =?utf-8?B?SittUXVxL3RGaDhvaXZ2cGFJaUZod1hGS1loVkRCRmo3eGxzRlBNWXhJN2Nl?=
 =?utf-8?B?T3lZSHh1OWpwT2tvbkVHazM2L29Ia1RXcFhhbUUycVJYdHl2QXNhSnZTMDNz?=
 =?utf-8?B?RnVJMFk5QVpyaGNpV0doeGdLcy9xNGg1MDZOaThaRE9JNWd4NlhvMDUzNHJl?=
 =?utf-8?B?YWFleHRlK0dIeHM5L1dZNjRRVDNTZFExRW9JM04zSjQzRHVEeFdkVWlnSzVr?=
 =?utf-8?B?ckpMeUY4ODIyaVNJcUdPZ0NnUVpRNGgvUVh4TzdkazdJRExKbzNGei91RXd0?=
 =?utf-8?B?UVlsb28rRTV4ZzhyVjJuZUhSQm55Sk9pb3J0d0ZONUc4cXc0L0NDSk9Cd3ZT?=
 =?utf-8?B?cEhteFU4NFY3WmlWWUw3Qm8wS0gyaDNKejNWWUJ4dzg2M2FDZXVjRUNLbVJn?=
 =?utf-8?B?ZzVzRk1BVC92Uld3YW42aFdHTVI3YkM1djFEWWIzZjRwMXBGZ2tmQlBDQ0kv?=
 =?utf-8?B?eGJCTW82WncvNS91ZWgrT3dmZDJUakdNZVNOVGRSZGV5YlBoOXFrYnJyRXEr?=
 =?utf-8?B?emxyQkwrWDhOajJEMGFZS1RrN01jd2JwTTZlOGIwOERaQUNKRlJiYXhKS0I1?=
 =?utf-8?B?NU9DOGdPZVhXOGpRZ3YzR2gyWHFDa0djUS9NL0JyYjBFc1RSazVqZHpPM2d2?=
 =?utf-8?B?MnR1VTUyNTVwTVdKSDRaQVZwYTY4ZmdZNlBZMDdRL1JZeGorcWY3cVZpenhx?=
 =?utf-8?B?cVhUelRkRERpamQ0SDZtYnJYTXN3SVR3bXc3TXMrSlpFVWxjWXZkUFdwQmFL?=
 =?utf-8?B?dGM2dUhiUTI4V3R0L0JLWE1NWkRmbmtRbERyNzI2dDNJcTdrZVphamdCMlRm?=
 =?utf-8?B?Vm5jaTVSL2U3RXlyVDNHM2IzQ3RqWUhYRHdzYmhheDRjL3ZUL1drOWZ3RnV5?=
 =?utf-8?B?UGZBam9KOTFYaC9KZHFZbE5mYzloZnJvSXRVTWd5dnZ5SWR0SlF0Y2krWFlJ?=
 =?utf-8?B?Z3U5UGJ5Y2V2c0NZWDE5NHM3QURBSzFPbi93UkMrbEs3VlcvMDBOVzFxWU14?=
 =?utf-8?B?N3FXSUVzZDZpbVpaSVpLZWFBRlJyWE83K3E2bmN5b0p2Ry9uN2t4U0pYS3lC?=
 =?utf-8?B?bFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <842833E09E696642B3D8FCCB2C803E0A@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e74f51c-9047-4721-1c0a-08dd529d86dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 17:31:08.1787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k4JxKweboxG2OnhxJCeOIwHhWtSWvrxweo7XV1GyXh6Mkrt39atqhuhPo0fnMCygofVX67AkFtARKi222bRIdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8514
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Feb 2025 17:31:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17290

T24gRnJpLCAyMDI1LTAyLTIxIGF0IDE3OjIyICswMDAwLCBSaWNoYXJkIFB1cmRpZSB3cm90ZToN
Cj4gT24gRnJpLCAyMDI1LTAyLTIxIGF0IDE3OjE4ICswMDAwLCBLb2NoLCBTdGVmYW4gd3JvdGU6
DQo+ID4gT24gRnJpLCAyMDI1LTAyLTIxIGF0IDE3OjExICswMDAwLCBSaWNoYXJkIFB1cmRpZSB3
cm90ZToNCj4gPiA+IE9uIEZyaSwgMjAyNS0wMi0yMSBhdCAxNjo0MCArMDAwMCwgS29jaCwgU3Rl
ZmFuIHdyb3RlOg0KPiA+ID4gPiBPbiBGcmksIDIwMjUtMDItMjEgYXQgMDg6MDkgKzAwMDAsIFJp
Y2hhcmQgUHVyZGllIHdyb3RlOg0KPiA+ID4gPiA+IE9uIFRodSwgMjAyNS0wMi0yMCBhdCAxODoy
NyArMDEwMCwgU3RlZmFuIEtvY2ggd3JvdGU6DQo+ID4gPiA+ID4gPiBXaGVuIGB1ZC5zaGFsbG93
ID09IDFgOg0KPiA+ID4gPiA+ID4gLSBQcmVmZXIgYW4gaW5pdGlhbCBzaGFsbG93IGNsb25lIG92
ZXIgYW4gaW5pdGlhbCBmdWxsIGJhcmUNCj4gPiA+ID4gPiA+IGNsb25lLA0KPiA+ID4gPiA+ID4g
ICB3aGlsZSBzdGlsbCB1dGlsaXppbmcgYW55IGFscmVhZHkgZXhpc3RpbmcgZnVsbCBiYXJlDQo+
ID4gPiA+ID4gPiBjbG9uZXMuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gVGhpcyBpbXByb3Zl
czoNCj4gPiA+ID4gPiA+IC0gUmVzb2x2ZSB0aW1lb3V0IGlzc3VlcyBkdXJpbmcgaW5pdGlhbCBj
bG9uZXMgb24gc2xvdw0KPiA+ID4gPiA+ID4gaW50ZXJuZXQNCj4gPiA+ID4gPiA+IGNvbm5lY3Rp
b25zDQo+ID4gPiA+ID4gPiAgIGJ5IHJlZHVjaW5nIHRoZSBhbW91bnQgb2YgZGF0YSB0cmFuc2Zl
cnJlZC4NCj4gPiA+ID4gPiA+IC0gRWxpbWluYXRlIHRoZSBuZWVkIHRvIHVzZSBhbiBIVFRQUyB0
YXJiYWxsIGBTUkNfVVJJYA0KPiA+ID4gPiA+ID4gICB0byByZWR1Y2UgZGF0YSB0cmFuc2Zlci4N
Cj4gPiA+ID4gPiA+IC0gQWxsb3cgU1NILWJhc2VkIGF1dGhlbnRpY2F0aW9uIChlLmcuIGNlcnQg
YW5kIGFnZW50LQ0KPiA+ID4gPiA+ID4gYmFzZWQpDQo+ID4gPiA+ID4gPiB3aGVuDQo+ID4gPiA+
ID4gPiAgIHVzaW5nIG5vbi1wdWJsaWMgcmVwb3MsIHNvIGFkZGl0aW9uYWwgSFRUUFMgdG9rZW5z
IG1heQ0KPiA+ID4gPiA+ID4gbm90IGJlDQo+ID4gPiA+ID4gPiByZXF1aXJlZC4NCj4gPiA+ID4g
PiA+DQo+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gS29jaCA8c3RlZmFuLWtvY2hA
c2llbWVucy5jb20+DQo+ID4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiA+ICBsaWIvYmIvZmV0Y2gy
L2dpdC5weSB8IDEwMA0KPiA+ID4gPiA+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KystLS0NCj4gPiA+ID4gPiA+IC0tDQo+ID4gPiA+ID4gPiAtLQ0KPiA+ID4gPiA+ID4gLS0tLQ0K
PiA+ID4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA3NCBpbnNlcnRpb25zKCspLCAyNiBkZWxldGlv
bnMoLSkNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEluIHRlc3RpbmcgaXQgbG9va3MgbGlrZSB0aGlz
IHNlcmllcyBoYXMgc29tZSBpc3N1ZSBvbiBVYnVudHUNCj4gPiA+ID4gPiAyMC4wNA0KPiA+ID4g
PiA+IHN5c3RlbXMgKGJvdGggeDg2XzY0IGFuZCBhcm0pOg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4g
aHR0cHM6Ly9hdXRvYnVpbGRlci55b2N0b3Byb2plY3Qub3JnL3ZhbGt5cmllLyMvYnVpbGRlcnMv
MjMvYnVpbGRzLzEwOTcNCj4gPiA+ID4gPiBodHRwczovL2F1dG9idWlsZGVyLnlvY3RvcHJvamVj
dC5vcmcvdmFsa3lyaWUvIy9idWlsZGVycy81NC9idWlsZHMvMTAxNg0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gVGhpcyBpcyBwcm9iYWJseSBkdWUgdG8gdGhlIHZlcnNpb24gb2YgZ2l0IHRoZXJlLi4u
DQo+ID4gPiA+DQo+ID4gPiA+IFRoaXMgaXNzdWUgY291bGQgb2NjdXIgaW4gdHdvIGNhc2VzOg0K
PiA+ID4gPiBhKSBvbGQgR2l0IGNsaWVudCB2ZXJzaW9uDQo+ID4gPiA+IHRoaXMgY291bGQgYmUg
cmVsZXZhbnQ6DQo+ID4gPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2dpdC8xNjMwNDk2NDY3
ODgxLjIwMzA0MzkwNDkuNDI0NzI1MzU1MUB2aXZhbGRpLmNvbS9ULw0KPiA+ID4NCj4gPiA+IEkg
c3VzcGVjdCB0aGUgZ2l0IHZlcnNpb24gaXMgdGhlIGNhdXNlIG9mIHRoZSBpc3N1ZS4NCj4gPiA+
DQo+ID4gPiA+IGIpIEdpdCBzZXJ2ZXIgdmVyc2lvbiwgdGhhdCBoYXMgZGlzYWJsZWQgYW5ub3Vu
Y2VtZW50cw0KPiA+ID4gPiBzZWU6DQo+ID4gPiA+IGh0dHBzOi8vc3VwZXJ1c2VyLmNvbS9xdWVz
dGlvbnMvMTM0MjU0Ny91bmFibGUtdG8tZmV0Y2gtcGFydGljdWxhci1jb21taXQtaGFzaC1mcm9t
LWdlcml0LWVycm9yLXNlcnZlci1kb2VzLW5vdC1hbGxvdy1yDQo+ID4gPg0KPiA+ID4gV2UncmUg
dGVzdGluZyBhZ2FpbnN0IHRoZSBzYW1lIHNlcnZlciBhbmQgd2Ugc2VlIHNvbWUgcGFzc2VzIGFu
ZA0KPiA+ID4gb25seQ0KPiA+ID4gZmFpbHVyZXMgb24gVWJ1bnR1IDIwLjA0IHNvIGl0IGlzIHVu
bGlrZWx5IHRvIGJlIHRoaXMuDQo+ID4gPg0KPiA+ID4gPiBTbywgSSBoYXZlIHJlaW50cm9kdWNl
ZCB0aGUgc3dpdGNoIGZyb20gdjIgcGF0Y2ggd2l0aCBpbnZlcnNlDQo+ID4gPiA+IGxvZ2ljLg0K
PiA+ID4gPiAxLiBlbmFibGVkIGJ5IGRlZmF1bHQNCj4gPiA+ID4gMi4gb2xkIGJlaGF2aW91ciBj
YW4gYmUgZm9yY2VkIGJ5IHZhcmlhYmxlDQo+ID4gPg0KPiA+ID4gU28gaW4gQ0kgb24gdGhlIGF1
dG9idWlsZGVyLCB3ZSBuZWVkIHRvIGZvcmNlIHRoZSB2YXJpYWJsZSB0bw0KPiA+ID4gYWxsb3cN
Cj4gPiA+IHRoZQ0KPiA+ID4gc2VsZnRlc3RzIHRvIHBhc3Mgb24gMjAuMDQgaG9zdHM/IFdlIGFs
c28gbmVlZCB0byBlcnJvciBpZiBhbnlvbmUNCj4gPiA+IGVuYWJsZXMgdGhhdCBmb3JtIG9mIGZl
dGNoaW5nIG9uIDIwLjA0IGhvc3RzIHRvbz8NCj4gPg0KPiA+IE15IGN1cnJlbnQgdjQgaW1wbGVt
ZW50YXRpb24gZG9lcyBpdCBhdXRvbWF0aWNhbGx5IGluIGZhaWx1cmUgY2FzZS4NCj4gPiBCZWNh
dXNlIHRoZSBkaXNhYmxlZCBzZXJ2ZXIgc2lkZSBpc3N1ZSBpcyBwb3NzaWJsZSBhdCBlbmQgdXNl
cnMgYnV0DQo+ID4gbm90DQo+ID4gQkIgQ0kvQ0QgKHRoZXJlIG9ubHkgMjAuMDQpDQo+DQo+IE9r
LCBhdXRvbWF0aWMgZmFsbGJhY2sgc291bmRzIG9rIGFzIGxvbmcgYXMgaXQgZG9lc24ndCBjb21w
bGljYXRlIHRoZQ0KPiBjb2RlIHRvbyBtdWNoLiBJJ20gbm90IHN1cmUgd2Ugd2FudCB0byBoYXZl
IGEgdmFyaWFibGUgZm9yIGl0IHRob3VnaCwNCj4gSQ0KPiBkb24ndCBsaWtlIHVzZXJzIG5lZWRp
bmcgdG8gY2FyZSBhYm91dCBzZXR0aW5nIHN1Y2ggdGhpbmdzIGZyb20gYQ0KPiB1c2FiaWxpdHkg
c3RhbmRwb2ludC4NCg0KU2VudCBhbHJlYWR5IHY0LCBidXQgaXQgd291bGQgcG9zc2libGUgdG8N
CmEpIG1ha2UgQkJfR0lUX1NIQUxMT1dfU0tJUF9GQVNUIGFuIHVuZG9jdW1lbnRlZCBmZWF0dXJl
DQpiKSBvbmx5IHVzaW5nIHVkLnNoYWxsb3dfc2tpcF9mYXN0IGZvciB0aGF0IGludGVybmFsbHkg
KGJ1dCBpcyBpdA0KcG9zc2libGUgdG8gc3BlY2lmeSBzaGFsbG93X3NraXBfZmFzdD0xIHZpYSBT
UkNfVVJJPykNCmMpIHVzaW5nIG5vdCBgdWRgIGF0IGFsbA0KDQo+DQo+ID4gPiA+IDMuIG9sZCBi
ZWhhdmlvdXIgaXMgdHJpZ2dlcmVkIGF1dG9tYXRpY2FsbHkgaW4gbWVudGlvbmVkDQo+ID4gPiA+
IGZhaWx1cmUNCj4gPiA+ID4gY2FzZQ0KPiA+ID4gPiAoc2VlIGFib3ZlKQ0KPiA+ID4gPg0KPiA+
ID4gPiBJJ2xsIHNlbmQgdXBkYXRlZCB2NCBwYXRjaCBzZXJpZXMuDQo+ID4gVGhpcyBwYXRjaCBz
aG91bGQgd29yayB3aXRoIDIwLjA0LCB0b28uDQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4gSSdtIGFm
cmFpZCB0aGlzIHNvbHV0aW9uIHdvbid0IHdvcmsgZm9yIHVzLiBXZSBlaXRoZXIgbmVlZCB0bw0K
PiA+ID4gZmluZCBhDQo+ID4gPiB3b3JrIGFyb3VuZCwgZmFsbCBiYWNrIHRvIGEgZGlmZmVyZW50
IHdheSBvZiBmZXRjaGluZyBvciBJIGd1ZXNzDQo+ID4gPiB3ZQ0KPiA+ID4gaGF2ZSB0byBkcm9w
IHN1cHBvcnQgZm9yIFVidW50dSAyMC4wNCB3aXRob3V0IHVzaW5nIGJ1aWx0b29scw0KPiA+ID4g
dGFyYmFsbA0KPiA+ID4gYW5kIGJ1bXAgb3VyIG1pbmltdW0gZ2l0IHZlcnNpb24gcmVxdWlyZW1l
bnRzLg0KPiA+IERyb3AgMjAuMDQgbWlnaHQgYmUgcG9zc2libGUgdG8uIFRoZSBFT0wgb2YgMjAu
MDQgY29tZXMgaW4gYSBmZXcNCj4gPiBtb250aHMuLi4NCj4gPg0KPiA+IEkgd291bGQgcHJlZmVy
IHRoZSBhdXRvbWF0aWMgZXJyb3IgaGFuZGxpbmcsIHRvIHN1cHBvcnQgb2xkIGdpdA0KPiA+IHNl
cnZlcg0KPiA+IHZlcnNpb25zIGF0IGVuZCB1c2VycywgdG9vLg0KPg0KPiBUaGVyZSBhcmUgb3Ro
ZXIgcmVhc29ucyB3ZSd2ZSB3b25kZXJlZCBhYm91dCB1c2luZyBidWlsZHRvb2xzIG9uDQo+IDIw
LjA0DQo+IGJ1dCBJIHdvdWxkIHByZWZlciBub3QgdG8gc28gdGhpcyBzZWVtcyByZWFzb25hYmxl
IGFzc3VtaW5nIHRoZSBwYXRjaA0KPiBpc24ndCB0b28gYmFkLi4uDQoNCkFuZCB0aGVyZSBtaWdo
dCBiZSBzb21lIChsZWdhY3kpIEdJVCBzZXJ2ZXJzIG9uIHRoZSBpbnRlcm5ldCB0aGF0DQpkb2Vz
bid0IHByb3ZpZGUgc3VwcG9ydCBmb3IgZmV0Y2hpbmcgYSBjb21taXQgaGFzaCBkaXJlY3RseS4N
Cg0KPg0KPiBDaGVlcnMsDQo+DQo+IFJpY2hhcmQNCg0KLS0NClN0ZWZhbiBLb2NoDQpTaWVtZW5z
IEFHDQpodHRwOi8vd3d3LnNpZW1lbnMuY29tLw0K

