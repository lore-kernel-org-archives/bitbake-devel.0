Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F361CC021AA
	for <webhook@archiver.kernel.org>; Wed, 19 Feb 2025 16:30:04 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.42])
 by mx.groups.io with SMTP id smtpd.web11.26748.1739982598581094889
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Feb 2025 08:29:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=E7aGbxZu;
 spf=pass (domain: siemens.com, ip: 40.107.105.42, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X1581lEnm6m4onvm0+4oGVw1stj/z/5hRkjkj0ccP0+9R+wgBsovOiwhA++AO11Wbn7Ub5N3OQE7IehJMpMTbxD3D50k50SzJlEYM1ixzeEoiHqjfIGWp4Z160p9ewpiCe3wTnR8BjQqwojFc09S22GhsslifgcejIrPSTHr+fAdghXWjwm6isUHEDJVavgIevWBXQoZKD9HQ3UVIlEoArzoofSTeJCcUvW63AYhp8CEmcvtMl7tXc+piHoik/8BPKP62o52oPInLSRkXMVIhW8mcXE7WcDJXBozrhLDcwfrF4rnomm6ijI02vyzRMF54+3/5AyWqrypgELmBxhfYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKgDjbqN1t8d4bXGh6I9mBQbVQMEQo2Wg5/NHgTSGDw=;
 b=e4P/CkhyInQA0NTDyW1b3QmFH3Bcxs0LrM8tuw5SMaHpu9WyCkY+c7cpbDgyLQAWB5qoP/b6jsy+CuBSwLc0Kj0mfAq1rZd2jn9CoPSpgK7E51oT7dLEVNA7x5+3VBpDB1Shfwhy4/QxkW5FvlpG+vEOGRD6vm+DYAQ+3gQqH9m+SKcjplv9/o6pJscAiX6zPRzMGkP7syHKqfqP9m74sWez/zkpuUvZ18JLrarlJ/htacgHRJTt7V4/BcoHNUsM2fdbhiOogFMYRgUuP1ImMyh9T/ONBBl6Fa0klUm6O8IY/FDUpByt9mMAHBrPhfxGb2wMU41aHNRd9VMf54zNYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKgDjbqN1t8d4bXGh6I9mBQbVQMEQo2Wg5/NHgTSGDw=;
 b=E7aGbxZu77slA0jvt38rOKI5rwZg/U+qTCFS01ARsPXYs9HUXnBpf9JRr/H2tYpjxDH5nzvqCAyEbU1tPQGCgdB6Qm9hVFz/MkWH9WY4zJvdKyXumvAmClOts0Y7mBbmQwWmJF0EEdnIwIX7sl0cfOy8GWVydd1TnpH1EuY4BBiGm91Odkl7S9M9ZRgksHxCTUb6fLJGIMBv0N/DEaGcvs/hq/jnn2QbuBhB2NwXMdysGVGcg8LSp6t2hKmLqr5hW16fqITEzRMFh8LpSETTdxX+ppC15tZ0hhmJdTE8crqYs07Zo6iyIBRuRT4CbhuY7lRytRgMyJUUhsDMvZF+YQ==
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by AS4PR10MB5821.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:510::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 16:29:55 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%6]) with mapi id 15.20.8466.015; Wed, 19 Feb 2025
 16:29:55 +0000
From: "Koch, Stefan" <stefan-koch@siemens.com>
To: "richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: "Sudler, Simon" <simon.sudler@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "alex.kanavin@gmail.com" <alex.kanavin@gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2 1/4] fetch2/git: Add support for fast
 initial shallow fetch
Thread-Topic: [bitbake-devel] [PATCH v2 1/4] fetch2/git: Add support for fast
 initial shallow fetch
Thread-Index: AQHbfvg+GqieoLmXVU6/5BvGwJi2prNMFpWAgALCfIA=
Date: Wed, 19 Feb 2025 16:29:55 +0000
Message-ID: <90466bad36e05749baff32be9cbccd523d056649.camel@siemens.com>
References: <20250214155057.1748020-1-stefan-koch@siemens.com>
	 <9ea525464fe8b072e33e681d35dd20b230469541.camel@linuxfoundation.org>
In-Reply-To: 
 <9ea525464fe8b072e33e681d35dd20b230469541.camel@linuxfoundation.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR10MB4959:EE_|AS4PR10MB5821:EE_
x-ms-office365-filtering-correlation-id: b5166a6e-41f0-4a77-f3e6-08dd5102a4db
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?ckFIcWFhYlNMUWRNcU96NGYvZE9YSENYenU0djYyRjd1cFMxNy9oY3BHOCtT?=
 =?utf-8?B?TVNYT0Uvb3ZaSlpBQmtUQzIzTFlaWmJseEN0QU5YMU5idTY0UUV2RldqWlhx?=
 =?utf-8?B?dVZLMzRwOFUwUE5YU1hEcHdiRDgzZHpnSmtWd1oyVHd5ejJxbjZlTWpEZVQ0?=
 =?utf-8?B?WDN2ZmlBSStpMWE0dFRoN2ZReVlEUjJ5eXJzQ3dzYnRGeFpYU2dabWZvaFhW?=
 =?utf-8?B?U3FIWXUzUmhrVGF3NFgzNlNIaGlpWEpheDFqc1kzV1RuRG5LSUhhVEkyS1Uv?=
 =?utf-8?B?ZlBsbUM5c3REUmN5UG5aVlk2TlhwOE5zTk5NbUFuVm0wc1lHNVBvS2dKTFll?=
 =?utf-8?B?QjIyKzdLSHZpUU5oRng3M1NpMWFiOURoTlhLSUpmZFc0S0NzdGUwWVpvN0JE?=
 =?utf-8?B?ZnpDVlQvbW9qbTVybkhzT21XSzhTQVVJRWZvd0Z1ZE1RWEw3OG9hbUpaSHl4?=
 =?utf-8?B?K21pRXpvL0xyU00yY2NKSGhiYnRiNHpVQlBIRytmN2UxWmlVMmo4eUNJTFB1?=
 =?utf-8?B?WnFldXJrTEwvb2JVdSsyWTBaSm5CY3JsZndsOHltM3hBUlpsUy9hVE1Nbm1O?=
 =?utf-8?B?eG1IdG5Ra0NjR0N3bXNNZHNkUFBVbWRYTjBTNnVDNlUzOHI0SWdiWmpHM1Jz?=
 =?utf-8?B?YUpTRjBiL0l0SzlqUjJ3UVJ5UGhUbmJ3cjZ0ZUNyYmJldUpZWDVpVVpmdVZP?=
 =?utf-8?B?SFVrWVAxN1h5MkNUaWdnTE1pNzlyMmFnb2ZvSWZERlEwRjVhZVh4a3ZiKytY?=
 =?utf-8?B?L052aWdQUjNPY3czZ1VWMm1ZTWRhL3I0bVhNWkNCSTVldnFQT3pGaHY1azFi?=
 =?utf-8?B?WHpNNXFzUkZoVDJKV0F1alZDc3BYdW92V3h6cGRzNDIvK3RsVDFudlVyMWdn?=
 =?utf-8?B?VkZSai83VXBVUWJqa3M0SnJBakFIMWxSRi9HTVlwcWRINU1FcHJSbUhkTWZ2?=
 =?utf-8?B?akJQV1g4TUMrdmlnMU5aSG9TRy9Td0pGVXhWUzUwR3BQYTRLNWNXWmszVFVh?=
 =?utf-8?B?R2t0S3MyR05Xa0lOMHBFSXIzY0dxNzdKZTlMaFdwZCs2ZmN5T1VLMVhBbVRS?=
 =?utf-8?B?RTNRdHdQTzRVeVBRVWtERGllMHRhTHZTaFV1OUU1T1JkUkZYYzhJVEtiN0dC?=
 =?utf-8?B?VGdMM0E2QXNSZk5kRmNFSHBqcG8zWStxSk04THNDOERMQ0wxNXc1SEh5WmFy?=
 =?utf-8?B?RmlUZ0QxckMyc0tCWEthOVJrc0l1OXJvK0tNVG02NjZzc2ltYitwQ1d3ODM1?=
 =?utf-8?B?OEc5MWxoRWVVYm9ocHYzVytPd0NINkxhd0g5K3pWY3oxc3BLLzY5RWlMeEFy?=
 =?utf-8?B?K212bmM0MzlSdkFZUCtNcm81emFwMTEyYitDUzBaT3dIM0hiNzZ5eTQ1dmNi?=
 =?utf-8?B?cHhWV3djOVd6cjYvOW0wMUU2ZTNnb0hYMlRBeWVyUk1mOC9idXMxUFk4REVR?=
 =?utf-8?B?Y3VHRVZ2QlRIUGVLWFo4OUtKblVoa1Rwbzh6MjlxSUJEV2JsTm9SNFNrQkxZ?=
 =?utf-8?B?MU5HOFpGN3Jsd2ljYUNTK0dCMC9QWTJNQkFiQnJsQ3hIN2VsY2hsL3ZHUzZY?=
 =?utf-8?B?NnhMSkVpczhQeHRGQzBJWGxjTmtaa3I0VzVEUGRHV1NNR0J5ZjNvbzJvOFpu?=
 =?utf-8?B?ME01QWNXZmwxQS82TkRXMUt6ZkMvQW9HUGdoZFZ6cU9pUkdVaGRhZnZZa0pv?=
 =?utf-8?B?TkQ2b1p4MGk3WXZQcXVaOVUwUmZzcFR5a0E3NkE1RUg2Y2wrVXFadDhOYUs3?=
 =?utf-8?B?VUQxWXF6T0Nidm5tTzJVK2NacytEaEg0Qkh4QXlVWjRZYmFGZk91cUxOZXlS?=
 =?utf-8?B?T2dDNU1kRzlQS0tSOXJaUzZhZUxITXpYanBwQ1Z5TGJXR2FLSWV0eEFOczRa?=
 =?utf-8?B?WVhCYjEvNDhIclhpajJRb3NsNzhDQ0dML04zaFpmR2gxY3B5blJJamcrYjdv?=
 =?utf-8?Q?85j5kb/JvZC1A1g4vAOWivb0wd48uaGa?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZWNiaUZFWEltSWNnaHZKUEpuc2w2VTN3TTJxM0s0TmNHemlXWHdDV2tjNEhS?=
 =?utf-8?B?cnMzVjFocWxQYWV0TmhUMFlLK05rMWNoZ1NPZnIxVmZzTWkwZDFGYXdjNGk1?=
 =?utf-8?B?M2E5WFdMWks4b2xHWHlGcWlCYVdXVUVHTGRqRHJKTy9ycXdsM3lLQmNnYkZp?=
 =?utf-8?B?aXZFNUlWdmJxREl0QW5ER3FTSk0yQTdQb0pIRHdUbkVRbmxVbkNaYzEyYVNS?=
 =?utf-8?B?dGFvSzN1Tk9jb090TXJpRjgwUU5wNmExZ3d1L3dRV1VZNk83OXRPL2hzdGk4?=
 =?utf-8?B?NHI2cXkyRHVsRWhxaFpPNmR6cURzNHpTS0RBZ2kyVS9CdjNVb2JIYVhJSXRr?=
 =?utf-8?B?UUR6WlVNZE91bS9CajhQNk5XNlFBTS9pajhQb29ONjRlK0pDSjdmc1RFTWw3?=
 =?utf-8?B?TU9LNDNJdm5kdGxvWWpKTXVhMWpNb2xiUWFRMDBMK1lWN1RaUEVEdkhXRUY0?=
 =?utf-8?B?QS9aVnI5ZTdGbUhGQjA0cHh6TmVCVnYzS0c5YzNDVjFnR24rVTB5anpCWXdG?=
 =?utf-8?B?QW93WWowWnpHSmUrQWkvS3l5Rjk5YUlZOFFwWTZFejQ1ZzRQNWhOT1V6bU11?=
 =?utf-8?B?bUpDclVYbEMyblZwcEFMRTZaSnN4Nk5wYWgvSjlUYjljZkg5aDRjd3NMelBK?=
 =?utf-8?B?YWJDMjY1MHJYQzltc2Q4MUtiMERuMTVuTUdMVGtEQ1MwYUxZZzZpVHZ2cHZ1?=
 =?utf-8?B?VUlEaStjaGhlMlM2QTRSK24weGpkZnZyU3U1MHJjUHB4YnFCcWFROStsdkhD?=
 =?utf-8?B?dEttWGROc1BwN0p0RGoyRzJaYzQ5VEs3TitvLzAvMUk0TzRPOTFMdUQzVVJG?=
 =?utf-8?B?bGQyRHROd1hCdFJNS1V4MkRob0dod051bnd6cG9xMzBla0JBUVExVHEvVjha?=
 =?utf-8?B?U2krTm53emowNi9icmNmSk1KbkIxZG5ONzE3QlMrZ2JySnR3Mm93SThlaWJm?=
 =?utf-8?B?SWxCdnhRWCtvN0hkWnZSWCtMQjQ5ZmhTU3BiTWFhVWpmL3EyVjFyODBRRE9a?=
 =?utf-8?B?b3BQQjg4MmlvY2FZc3BwaVl0ZEZ3S2hqeFdWR0oxN29FWUs3RCtnM1Q0eUl0?=
 =?utf-8?B?bGV3VXppcy9ZWSs1V0c0RVQxamRLN0hlL24wL3lQTExVcHo3QURKZTBqa1da?=
 =?utf-8?B?TE84V3BNaytnQTZla1BMdVJxRjFpbkVzNGVkTUcrVFNLSlJnK3dFTGRveXdH?=
 =?utf-8?B?UHVpbmRuSk9UT2lGZmxELy93VE9jWW8wOXZGaS9DM1V1NTVTcnNDVHhJa1VL?=
 =?utf-8?B?cnNqRVlkbzI5K1g1TllHS2gvTXpVZjZyMkRnME1GaVlkN3d5VU13bGxxZHV3?=
 =?utf-8?B?NldQQTFJQWpwQjBqMkVibys3V2hnZW8xMWlIbE5kT2xzNndzbC9iamMrK0JN?=
 =?utf-8?B?KzVuK05jOHY3YlZuZnJhZURuSWlZdThvSFRPZ2xLN1hrWmZacUw1dUNtZ0ln?=
 =?utf-8?B?b0htTWF5NXEycWZRZGFybnVhM211Z2c2N2RLem1aWERLd1ZSWGtVOWpTOTdF?=
 =?utf-8?B?SFdRcnA3RTBmckg5TzhwRytvZVdSamJKbjBnbkxld2N4SHlPRWduTnJQMDNv?=
 =?utf-8?B?ODZBbk5kRnJKTWZHTVNGa1FnTTdIMDIvTWlxbkJCY3BmRncrYU9meCs3WEsv?=
 =?utf-8?B?a2hmWWUwYTJYSjQ0b3cwd2J5Z1F2SVlLbEhWT05jZG5nOE5YMmlVMnZRQUJX?=
 =?utf-8?B?WldyQUYza0JGdFZjemRSZnQ1Wkh3aW9LZHFmQ08xeS9yT1JQZTFqd1UzczQ3?=
 =?utf-8?B?aUx3enFPSWhEV3dCQWgyczBKUHpuUUVUREoxTG51R2hvck9YcnZxdUpERFRB?=
 =?utf-8?B?U2hGN2RsZ0U3THVJWlVaamRMYitlbldHVDdoai9UUzJBcWE5SERsb2FqWEhH?=
 =?utf-8?B?aDhFeXVvN3NzOHN5VzJpNFNCMm0zQ0toVTQrdDFrT1JGZ0lLOVpHemEvcXd2?=
 =?utf-8?B?RzdKVk40YzdUdkl5NFNuSXhwck5tVWtMWVRHM3FYaE1PSU9qZUg2andoR2Mv?=
 =?utf-8?B?YXByY1Z2WTd1dUg3dkJLN0VINUEzZE1ZdTQ0ZzBSa1U5QnYxQVhsa2ZBNGgy?=
 =?utf-8?B?SHpDVUhBSkJuL0w1eitxYU1va1dWZ3NoSWlLZ1pIZC91a0gxVWl5S2NPYklh?=
 =?utf-8?B?bnZReXVlcXNqQWtnVlNYcDVXd3JqdERmS0hZZktUdjM5TUlQenF3N1gwVEJq?=
 =?utf-8?B?RHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A9BD9B5B4D29FE45BF9FAB4C94CC2E51@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b5166a6e-41f0-4a77-f3e6-08dd5102a4db
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 16:29:55.3580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X6SccerScYhINM/4sX8woXqitxkCh/sR7wvQtMG8lGsaYEnO7Y9Gl+SQEZYmX5ZU00CDw7qJ9Modu3JP2hsL2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5821
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Feb 2025 16:30:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17247

T24gTW9uLCAyMDI1LTAyLTE3IGF0IDIyOjIxICswMDAwLCBSaWNoYXJkIFB1cmRpZSB3cm90ZToN
Cj4gT24gRnJpLCAyMDI1LTAyLTE0IGF0IDE2OjUwICswMTAwLCBLb2NoLCBTdGVmYW4gdmlhDQo+
IGxpc3RzLm9wZW5lbWJlZGRlZC5vcmcgd3JvdGU6DQo+ID4gV2hlbiBgdWQuc2hhbGxvd19mYXN0
ID09IDFgOg0KPiA+IC0gUHJlZmVyIGFuIGluaXRpYWwgc2hhbGxvdyBjbG9uZSBvdmVyIGFuIGlu
aXRpYWwgZnVsbCBiYXJlIGNsb25lLA0KPiA+IMKgIHdoaWxlIHN0aWxsIHV0aWxpemluZyBhbnkg
YWxyZWFkeSBleGlzdGluZyBmdWxsIGJhcmUgY2xvbmVzLg0KPiA+IC0gYHVkLnNoYWxsb3dgIHdp
bGwgYmUgYXV0b21hdGljYWxseSBzZXQgdG8gIjEiLg0KPiA+IA0KPiA+IFRoaXMgaW1wcm92ZXM6
DQo+ID4gLSBSZXNvbHZlcyB0aW1lb3V0IGlzc3VlcyBkdXJpbmcgaW5pdGlhbCBjbG9uZXMgb24g
c2xvdyBpbnRlcm5ldA0KPiA+IGNvbm5lY3Rpb25zDQo+ID4gwqAgYnkgcmVkdWNpbmcgdGhlIGFt
b3VudCBvZiBkYXRhIHRyYW5zZmVycmVkLg0KPiA+IC0gRWxpbWluYXRlcyB0aGUgbmVlZCB0byB1
c2UgYW4gSFRUUFMgdGFyYmFsbCBgU1JDX1VSSWANCj4gPiDCoCB0byByZWR1Y2UgZGF0YSB0cmFu
c2Zlci4NCj4gPiAtIEFsbG93cyBTU0gtYmFzZWQgYXV0aGVudGljYXRpb24gKGUuZy4gY2VydCBh
bmQgYWdlbnQtYmFzZWQpIHdoZW4NCj4gPiDCoCB1c2luZyBub24tcHVibGljIHJlcG9zLCBzbyBh
ZGRpdGlvbmFsIEhUVFBTIHRva2VucyBtYXkgbm90IGJlDQo+ID4gcmVxdWlyZWQuDQo+ID4gDQo+
ID4gU2lnbmVkLW9mZi1ieTogU3RlZmFuIEtvY2ggPHN0ZWZhbi1rb2NoQHNpZW1lbnMuY29tPg0K
PiA+IC0tLQ0KPiA+IMKgbGliL2JiL2ZldGNoMi9naXQucHkgfCA5NiArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrLS0tLS0tDQo+ID4gLS0tLQ0KPiA+IMKgMSBmaWxlIGNoYW5nZWQs
IDc1IGluc2VydGlvbnMoKyksIDIxIGRlbGV0aW9ucygtKQ0KPiANCj4gSSdtIGxlZnQgd29uZGVy
aW5nIGlmIHdlIHNob3VsZCBzaW1wbHkgYWRvcHQgdGhpcyBiZWhhdmlvdXIgYnkNCj4gZGVmYXVs
dD8NCj4gRG8gd2UgcmVhbGx5IG5lZWQgdG8gaGF2ZSB1c2VycyBzZWxlY3QgdGhlIGZhc3Qgb3B0
aW9uPyBXaGF0IHdvdWxkIGJlDQo+IHRoZSByZWFzb24gc29tZW9uZSB3b3VsZCBkbyB0aGF0Pw0K
WWVzLCB0aGF0IG1ha2VzIHNlbnNlLg0KSWYgb25lIHdhbnRzIHRvIHVzZSBhIGNhY2hlZCBiYXJl
IGNsb25lIGFuZCB1cGRhdGluZyBvbmx5IHNtYWxsIGJsb2JzDQppdCdzIGVub3VnaCB0byBqdXN0
IHVuc2V0IEJCX0dJVF9TSEFMTE9XIGF0IGFsbC4NCg0KSSdsbCBzZW5kIHVwZGF0ZWQgdjMgcGF0
Y2gsIHNvb24uDQo+IA0KPiBJIGNvbnRpbnVlIHRvIGJlIHF1aXRlIHdvcnJpZWQgYWJvdXQgcGls
aW5nIGxvdHMgb2YgZGlmZmVyZW50IGNvZGUNCj4gcGF0aHMgaW50byB0aGUgZ2l0IGZldGNoZXIg
YW5kIHR1cm5pbmcgc29tZXRoaW5nIHRoYXQgc2hvdWxkIGJlDQo+IHJlbGF0aXZlbHkgc2ltcGxl
IGludG8gc29tZXRoaW5nIHNvIGNvbXBsZXggbm9ib2R5IHVuZGVyc3RhbmQgYWxsIHRoZQ0KPiBk
aWZmZXJlbnQgY29kZXBhdGggY29tYmluYXRpb25zLg0KPiANCj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgaW5pdF9jbWQgKz0gIiAtLWJhcmUiDQo+ID4gwqDCoMKgwqDCoMKgwqDCoCBydW5m
ZXRjaGNtZChpbml0X2NtZCwgZCwgd29ya2Rpcj1kZXN0KQ0KPiA+IC3CoMKgwqDCoMKgwqDCoCBy
dW5mZXRjaGNtZCgiJXMgcmVtb3RlIGFkZCBvcmlnaW4gJXMiICUgKHVkLmJhc2VjbWQsDQo+ID4g
dWQuY2xvbmVkaXIpLCBkLCB3b3JrZGlyPWRlc3QpDQo+ID4gK8KgwqDCoMKgwqDCoMKgICMgVXNl
IHJlcG91cmwgd2hlbiBjcmVhdGluZyBhIGZhc3QgaW5pdGlhbCBzaGFsbG93IGNsb25lDQo+ID4g
K8KgwqDCoMKgwqDCoMKgIHJ1bmZldGNoY21kKCIlcyByZW1vdGUgYWRkIG9yaWdpbiAlcyIgJSAo
dWQuYmFzZWNtZCwNCj4gPiBzaGxleC5xdW90ZShyZXBvdXJsKSBpZiB1ZC5zaGFsbG93X2Zhc3Qg
YW5kIG5vdA0KPiA+IG9zLnBhdGguZXhpc3RzKHVkLmNsb25lZGlyKSBlbHNlIHVkLmNsb25lZGly
KSwgZCwgd29ya2Rpcj1kZXN0KQ0KPiA+IMKgDQo+IA0KPiBJJ2QgY29tbWVudCB0aGF0IHRoZSBs
b2dpYyBoaWRkZW4gaGVyZSBpcyBqdXN0IGFib3V0IHVucmVhZGFibGUgYW5kDQo+IHNob3VsZCBi
ZSBzcGxpdCBpbnRvIHR3byBmZXRjaGNtZHMgZXZlbiBpZiBpdCBkb2VzIGR1cGxpY2F0ZSBzb21l
DQo+IGNvZGUuDQpJJ2xsIHNlbmQgdjMgcGF0Y2gsIHRoYXQgdXNlcyByZWd1bGFyIGlmIGVsc2Ug
d2l0aCBzZXR0aW5nIGEgcmVwb3VybA0KdmFyaWFibGUuDQo+IA0KPiBDaGVlcnMsDQo+IA0KPiBS
aWNoYXJkDQoNClJlZ2FyZHMNCg0KU3RlZmFuDQo=

