Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9E9C02182
	for <webhook@archiver.kernel.org>; Tue, 21 Jan 2025 16:08:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (NAM11-BN8-obe.outbound.protection.outlook.com [40.107.236.60])
 by mx.groups.io with SMTP id smtpd.web10.19554.1737475691803667669
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Jan 2025 08:08:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=R2GNZb1g;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.236.60, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ic5G1bRHhV//JHgwInvZ/5dtrMXbVFBHJrqeDbrQ7w1V8LlPBIluxSY4N5JI4MvnKTw18jP26LWOpzJVPMocUhHfoZsawybuLf2xDT1nB9qen3Atg2a6hOEPHcj2KOIE9PieCKN2NoMsqzA2Gsf0UbbpZhfDhOwUG6Lhl1DiRmGZDr/5AcLxK/kWn22xCwLrg4hMRN/+85V+DsAb9Hlfdbc5fccLnHXc1K+HaNUQT7mkf0n3sd2nzRI5xzObpqqtubymG2+O+bpGk3Gfbe9/eazcbuUuvQ9+JQRYrYaZvIExsOvmVNcAHouKkOSJOoliAEDnfD2bsIIsPRb8EqQLAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JsVe31YOFvSgBoFweYKDbCvgKoK3nY9utlXj3XeUHeU=;
 b=gE3jleCoh30M9G5lgpaGGieh+IX0fl9jHz5jqQFuyMptzSU79lYZQGwHG9KX/EXe9ZcYPKGBIHV6mVCjmpBCtyxqSPoMslXJupC03aVBr0wZVt2J+sOdznrqDPeqJU6AewE2ImwQQm3DmyARhQvg97lGdn2ApJtWYIE0yZXcdZ0nV/vwKeiZUwXve/kXJa6MaLVii41vu0af8EiKrMxiBUlnPiRhQ+hUfDCfRx7KgQIZLaDjYiMKei/SAnR1UYmTnfssdWha1dWFyEvbsyaKb23K2kvk+3fh3GOHppEoiZIJr5NQ/W21Vg+P1Swf9zUy3LoZLADXyNAwBSmWfWvpNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsVe31YOFvSgBoFweYKDbCvgKoK3nY9utlXj3XeUHeU=;
 b=R2GNZb1ggMtHNz7JdQxlHc2tSEQj0NlJQrclPeeQEnLKVqv6EBfjak/ryAay97L7OCvc/FfLpikWtp6awm+Es1doTvx5O8ZH4giN6OLy9ujX2+E3AfdoF6E4yrLji+QfaStIxGBhB0xaXFmMXthS8kJwQaoqYTdlYBrFxwCH0bqzhcXanq+JAb4+4W6oJ8kBPNxvka9sstE0hxw+MjgJiW+qGFwsVTK9UN6uwKe/63L9nqjDZLu+SasC3nhEnGrjzYw3uhJiwoI6Nciq1TTBw45sfR+8ON+ROfr7j3qX7Iq3SGwyJvqhZWZPYlPoDEc5PPADnn72smmfb9K/KCE7vA==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 DS0PR12MB7680.namprd12.prod.outlook.com (2603:10b6:8:11c::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.22; Tue, 21 Jan 2025 16:08:08 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7%4]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 16:08:08 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: Steve Sakoman <steve@sakoman.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, Richard Purdie
	<richard.purdie@linuxfoundation.org>
Subject: RE: UNVERIFIED SENDER Re: [bitbake-devel] [scarthgap][2.8][PATCH 1/3]
 ui/knotty: print log paths for failed tasks in summary
Thread-Topic: UNVERIFIED SENDER Re: [bitbake-devel] [scarthgap][2.8][PATCH
 1/3] ui/knotty: print log paths for failed tasks in summary
Thread-Index: AQHbYU8GMSH+Mp82j0Wjh/C0kYSAuLMhd/AggAACWwCAAAAxIA==
Date: Tue, 21 Jan 2025 16:08:07 +0000
Message-ID: 
 <DM8PR12MB5430A0CBAE8BA284C724A95C8BE62@DM8PR12MB5430.namprd12.prod.outlook.com>
References: <181887D232995242.18084@lists.openembedded.org>
 <DM8PR12MB543073B6438DC6E0CA8AAFED8BE62@DM8PR12MB5430.namprd12.prod.outlook.com>
 <CAOSpxdam9u2hz_3kn_nz15PN6T68ZZTGfshCKUw_+mkxn_PRxA@mail.gmail.com>
In-Reply-To: 
 <CAOSpxdam9u2hz_3kn_nz15PN6T68ZZTGfshCKUw_+mkxn_PRxA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=64f00cee-bbd0-41d1-9316-b2bc454abcf3;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2025-01-21T16:07:20Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|DS0PR12MB7680:EE_
x-ms-office365-filtering-correlation-id: 456c2daf-2549-4c57-a9a9-08dd3a35cb9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?TGJvRUdiTEozaUhTZ2F6cEVvaHBvMlBweHRRMVJzenVZNjV2M1A1Q0RVZmdP?=
 =?utf-8?B?SVFvU1kydFdQWFU4Q0ZRZVhqT1ZNOGZMRGl0VytFSm1hZWczeWZvZUhCS2Vm?=
 =?utf-8?B?ZU1wN0Q3UnpWNVhUb3F6cGZEcFpYeTR0aTFRNWc0VWFCT2JYSmVXN1FIWXlj?=
 =?utf-8?B?Ryt6VDJDeFlBUjlDSkR0UnJMUjN4cE8vL24vVzBGOW5HTnVUY3Y5UGRvSHNV?=
 =?utf-8?B?Zk0xQzEzWUxHc2l2aVRlRFJlN2lKa3JXWXdaS0JCc3hwblAyWDlBQUVxYWRj?=
 =?utf-8?B?Qjg4YzE0cC9NNXFWcG13K05oeXZjZXlBMmtSK1J6bThoL015SklOenEzTk1a?=
 =?utf-8?B?VFA1WmpOUTkyQ0FpeVB2eFlRYVkrd2o5anU2b1pWMmQ0VGRxRW1nYllqMDRM?=
 =?utf-8?B?MHkyWlFSUFNURXFZd3RJSVA0WXVlQlN6d2x3UFJOK3c5RW9UQmFjU3RIVUxk?=
 =?utf-8?B?andQc204TVI1cHpLTG40dlVYV0YrL0xidGhFZm1ac1plakw0cCs1RTl4eDMv?=
 =?utf-8?B?KzhWbzMrMldoQ2ZTbDNWdWRHaHhucVAzTlhCSVJ4TVluZkdaWDRIcWtUUGNj?=
 =?utf-8?B?ZHVaTHY2N3RGNTNZdzV2UlF4OW1wekJ6RXFVMjJ0NldlSnJqTHhzeXBEVURr?=
 =?utf-8?B?YTRBQUpGL0lrVktYMktHZURQWGFaYzNKRThHUTZ3cDBKcWhmRmFKK0VDT0xy?=
 =?utf-8?B?VFcxK0VaSnVJdElZVjNaS1lodE8vOXZVYThlT1lRekhsbHRibUplQ3ZoVXEy?=
 =?utf-8?B?K0dXdllJWmJteE9mNStaMHVwWllPc0dJYmxIZ3IrZXZnR0lyWTlHaDdJQUJX?=
 =?utf-8?B?ZDBoSkd4Q0VHMFJrRlJSUTlKOUVNd0ZhVnpGeFNhMFc1UUJoVklFK2EwWGUy?=
 =?utf-8?B?djJkTDJ4SURkSnZCaEZxY3Z5N09lcTcydk1LblZWQnUzM213YXFRMm1TUW1n?=
 =?utf-8?B?MGRCMy9hbXVaRHRnd21hUXpSSVlpSlVRVndEQ3dGeURka1k3S2prb1B4WGZt?=
 =?utf-8?B?T0ErQ2JlNW1RSmJLRTJ0ZjFXOHBWYnZkdmZHb0N0QkxhV0Yvd3QwTFNiNCtX?=
 =?utf-8?B?eUJya0UwTmpGRjZFYTZtT0pVUHFjQVNaaTR4WUxHR0NFdlVWZDRsYzM1MDFY?=
 =?utf-8?B?U1dPanlyUHZFZHdaMlZkZ0ZIWjJJQU9OYmt6dlFpdlI5QjArdU9TdFhOR1F4?=
 =?utf-8?B?Um5BaDZPTTdTRUJkQUNvZDcvcForM1RQR3UzWXp1T1hqc0tyVnd1TkJMTENE?=
 =?utf-8?B?SnJranh1SjhJbjRDTTZIY09nQWFZVjUySlRjelZrT1ZQQmgxMTRGb2YxcktN?=
 =?utf-8?B?ZzBkTEQrT01FclNLL2ZZdkswNjlGNzlNTm5hcUJoZm9XZittMGFYT3p6QnFD?=
 =?utf-8?B?Q0NwZU14Q2RBSk55WGRudGJGUmxDWllkTU93NnRmVE5XQis0N2RXK2xBb25C?=
 =?utf-8?B?dHZQYitUWXdaeU9sbHBhUGRlU2U1N2c4a2IyTDBPOGwzNmRpeG9XeTd3cGFM?=
 =?utf-8?B?S0pPYUNtWkUycURIN1dQRWtzOS9NWko4Q0wwdU54dWs0bEZyWWRxVitwMHJu?=
 =?utf-8?B?bDJSdExHK2taVHlOMXp1TitEQlFpWUZYTjM5Vjg3NTFGY3M4clE1aUsrSklh?=
 =?utf-8?B?eWdESDZPY1J0Z3BaMkxuVmIvL0xOdkJvYXZ1bGJuckJ6bENJYmxPOVlmZzdW?=
 =?utf-8?B?NlMxRzZtU3ZaNlA5ZkxwRHJsNGx3UGwzT1FkMHNQVzVDbzE5dDZxQ1JQSDVk?=
 =?utf-8?B?WFIyMjkrVTVZeW1wQUp1U3BTV0lSSWJDOGRnNVVzczVXdFNCbVdHUCtyZ3h1?=
 =?utf-8?B?SkZUdTVIS1VESEQwSFFqb2NGTUFHb2UxWU85UVdHcXhudE1ERS9yek9VVkxi?=
 =?utf-8?B?RndNVWczWDdWdGRxMFdTQWcwZ1VKU0pCS0p1U1ozTEpDUlVhZ0NPWDZUNWNs?=
 =?utf-8?Q?BaI83T9PbHN0qRT5JAlJ50vx0j08U6Pw?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?R1luU3pNV0sxU0hNNWZwUVN3elYvaExGcjR1LzdEcjdQZUdSUHkyOVM5Umx3?=
 =?utf-8?B?UHhsWFdtMXB5ZVJRRVVuZU9XdUNKbU9DT1hvL1p4WTNhbWYrZi84ajlsRlRC?=
 =?utf-8?B?bWZUdGdMOFhXTmloZC9OS2VHMVRxcVlMZ1NxeHEzQ0dNdUtxcitUSGtmQWVZ?=
 =?utf-8?B?Q002SE8reDEvR3lvL0VZVFRQY1ZHZSt3dGwyS3c1ZGlGcndwZE1LeGdibDNJ?=
 =?utf-8?B?a0tpeFR3d1RjT21sTnlRYVJKdFYxcjVub1ZrRGZ0S1hoRzBnOGY0VnVJRnVj?=
 =?utf-8?B?RzE5QlVvU0hkc1Q1TXhZSVFERzBJcHA3OE5NclE3Tnk3bmNoR09pSGhRK3Va?=
 =?utf-8?B?TGdyem1zd2hDVFBtY3o5a0I5aUZtamhjamZQNlRmQzFvaXNNdmNYM3dITHJw?=
 =?utf-8?B?UzhSbWlXV1Y5N1k2TjJhZ2xKaENNZytrWjFISkg4L2h6UVY4cmdmdysyTVBt?=
 =?utf-8?B?RkRBeGYxa3Y2WEpDYUxYWkNvU2xKWEYyL2hyRi84eE0wTzBXdVRnamFmTG1Y?=
 =?utf-8?B?U1NGL0hYdnJKSG9KeGhTd3czYlljQ0VWK3RsM2hxUmtnb3VUS3B3bE5tbkcr?=
 =?utf-8?B?U203MkQrVUpyekRlUE5xY3BMMnlEUndERDlDRjVsZ3hPWnVvSzRRT2pJZmh5?=
 =?utf-8?B?eEp5MGFPbStlWk9ncS9RdUhhaEFRVlV4UnVYaENCcllYbHhzcEh2b1RkWlVm?=
 =?utf-8?B?Y09ScnJXUG9Lc1ZBMXZscmIvSGlYWVh5dEVWTC9NWlN2TmxWOGhzcGVYL3Za?=
 =?utf-8?B?SkVoU1dxcmVqSEdiL01PRHpxT1NLZFFsZ1k3RWFrZ3FKVTQrWkszaHpWdWlj?=
 =?utf-8?B?ZjB3Q1MwM3lucDBSRE1OMlJ4M25HY0ZINVhRSUVRcUxnTkQybmhrblU1c2ZT?=
 =?utf-8?B?NWxDVk80dllkNVRGWkpkOWo0UmZvS2VZb2ZuMytWY1dRZEFVdERUcENlS0hT?=
 =?utf-8?B?SnRBOUhiYWQ1UGR2NEthSG5mdVhsUUlXZmF6Zng4b045MitNalJ2MXBNV1dS?=
 =?utf-8?B?SC9sYWxhOW9XcXltTVk2UUl6ZHlxdmNiWEo2dGhDa0FzQVVqR29yRVVuQW5w?=
 =?utf-8?B?U1NHeDVOVzBHMlRoUXpYQ2dINWUxZFphcW5Fa1pOR2NNOHNBUnV2N21VODBX?=
 =?utf-8?B?WkM1a3h5bVJUZEt4S2VCRnFFSUJZSDJuQ1B1cEE0RWJ1NjdpNDNtYXhQdDdL?=
 =?utf-8?B?UGRyV0NLT1hBRXA3d3IrVHZwSFlRTmkvUnRZYW9Jd1ZsUGZoUndwdVJtMVR0?=
 =?utf-8?B?T2xXM241T3pDclExMm1KM2JqYThWVndLZ0JzSU04aHA4Z3hlK1NkTEZIM0Fh?=
 =?utf-8?B?Y1hnSmhCSTQyWmcyYjdKRXdqN0V1OGRqWStpbERiL2tmcEdFYVhmWlZZbjF0?=
 =?utf-8?B?RHVZVVIranNZSzhPeWlwWGcvMWh3bHdsVVpVdzRuL0lMQWx2ekdVTlA0YXZB?=
 =?utf-8?B?WnZ6NHV6T2lSWk1WVVhua0VkNzU3TC9aU3Y1VjNQYmpuUmNmQnVTTXEyS1pq?=
 =?utf-8?B?UVZUL1BKR0RHT1dUSnI5TTl2Q0RKNlhnM29GaWxCYnIvL1FtdjFQYnpOd1U5?=
 =?utf-8?B?OXUxaFlaa05FM2d1NU9qT25Yd2sxOWFFQmMyV0t5S3BpRitXVU9qZ0ZqcHN2?=
 =?utf-8?B?RzJmUmVhRDVXZEllMFZLdVU5TEN4MGRDMHRldlZPRU9oOXhpV010Yk0zRXhZ?=
 =?utf-8?B?YTE0OXdBTmRuTzAxK3poY0RqMFlCS0tuN1lMWFdJTTljVmlnbVIxaHY3M0lG?=
 =?utf-8?B?K0haSXhIRkNnWXdZVk9PTjVlSTgvQ2ZPRGZhK1dhaEpSdlI5VmJOQ3A0M2xG?=
 =?utf-8?B?NzhheFBXa1FqLzVPVjNyUkZxMFpuaVlsb0Q5SHRQdTNDTGYrUjBucm50aXpa?=
 =?utf-8?B?dDBuZWZlYlZDcTFCWlZVVHpzMFZkbWovSkpFa0hkRG0wUWhPZnlNQ2pud1R0?=
 =?utf-8?B?Ri9RKzJiQjBvanJheThjVTNndXFEWndPWDlLdXBpVzRWRk1tby9idjNKb3Jk?=
 =?utf-8?B?T01UbUw4ajJjWUg1WENvRm9CUmJFZjkrM3Zhby81YTNIaG1sVlM4ckFGdWNZ?=
 =?utf-8?B?eGJMQzFlbVVPRjRvOVNoM3MwOVduYVl0MUJNVFBuT2MwOTdWMEppdGNjdmh0?=
 =?utf-8?Q?yqr20+Pm0PP2dzrcLM29Azp36?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 456c2daf-2549-4c57-a9a9-08dd3a35cb9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2025 16:08:07.9959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eLpWWs+uE3zcr8mPO2Ehl0wzwE0B6jZzJEkv07l5dYGpDR7IPR3RyafwAq1aOPZ66xjUsHXYgz5zje13dX7FjMpFFaYYhhBKAA+OgfeCCo4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7680
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Jan 2025 16:08:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17042

PiBPbiBUdWUsIEphbiAyMSwgMjAyNSBhdCA3OjU54oCvQU0gY2hyaXMubGFwbGFudGVAYWdpbGVu
dC5jb20NCj4gPGNocmlzLmxhcGxhbnRlQGFnaWxlbnQuY29tPiB3cm90ZToNCj4gPg0KPiA+IEhp
IFN0ZXZlLA0KPiA+DQo+ID4gSnVzdCB3YW50ZWQgdG8gY2hlY2sgdG8gc2VlIGlmIHlvdSBzYXcg
bXkgYmFja3BvcnRzIHRvIFNjYXJ0aGdhcCBmcm9tIGEgZmV3DQo+IHdlZWtzIGFnby4gSXQncyBk
ZWZpbml0ZWx5IHBvc3NpYmxlIEkgZGlkIHRoZW0gaW5jb3JyZWN0bHkuDQo+IA0KPiBTb3JyeSwg
SSBzb21laG93IG1pc3NlZCB0aGVtISAgV2lsbCB3b3JrIG9uIHRob3NlIHRvZGF5Lg0KPiANCj4g
VGhhbmtzIGZvciB0aGUgcmVtaW5kZXIhDQo+IA0KPiBTdGV2ZQ0KDQpObyB3b3JyaWVzLCBJIGFw
cHJlY2lhdGUgaXQhIChBbmQgSSBhcHByZWNpYXRlIHlvdSBtYWludGFpbmluZyBTY2FydGhnYXAh
KSANCg0KVGhhbmtzLA0KQ2hyaXMNCg==

