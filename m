Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05714C3DA4A
	for <webhook@archiver.kernel.org>; Tue, 20 Aug 2024 14:19:32 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (NAM11-DM6-obe.outbound.protection.outlook.com [40.107.223.40])
 by mx.groups.io with SMTP id smtpd.web11.20612.1724163564775770735
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Aug 2024 07:19:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=I2U/z8yc;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.223.40, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HuSzAP0y9w6XqpZJ6DZLa0Pdv6Wgv91ZP6mTDElx46qvfSdhI+uM48SkYZv+JIU1KP19LJ8cgqrFNc7PvGMVmOwBfqs3V8pcKI9bfQrIqqgQbrmvPb56sg50qYzzKZtMdM4zMxElEKsWiJVzJ8m2yD8QZgrPSpQPvLnufOrfblPwjK4bkEaoyoJuRnNrtuaRQMN393hp9kkBTVs1Y4kVkn7LAvnz9cbTM/p3AQuy2djtZ+RZgBI+ViY/99oj6u3h9+YT2onBpVXCg6DP6cve9KC0KlePRV4+RPuAZ+99AhDIp1zN0hz+vqck+t/KNGJgOlc6sADFUxCmmmF2VCYHtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxULUeL94QrrO866YHe+rbNsq8i9DRqJn4uoPjzKbog=;
 b=pKy0lSF2+rt4TiqDIlalQs287adYnR0nrjPrk0sTfjRpNYzhaO0FQWDLRoZsxYPtOvF3wHqzQ03oUsHJBNcJw280H6kF4UjilEKslFHK3AcC04WGoexbNeqk62jEwwFynOZtHG6zBniPS4ohO8lJ4SOoA1871eq9njfgRHGU4vpB2OPQgYIX/IUovgX4zO6NYHDii9QASvvz7oALK5kO9tLwsjMd/GE9fZ/yB9o1YHVTlaQnT5A+mkx02nY/Ivy6CXxI5znmigcWyCT3C2RIbtpmyfhtm4KJ7Da/RZsnT3z+kmA0fdvWz5NaOPBUQrq+KcIYZDuGxk2ZMw/MU1E7VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxULUeL94QrrO866YHe+rbNsq8i9DRqJn4uoPjzKbog=;
 b=I2U/z8ycoJd2HEyeObMlwQci2XfZgzLFsmnjP4MwnQd3taA2J7tcdlWemSO4HKhcXnNBbiln1HC9OZsJ2YiRR3dsBO04o+R1xqbEkZN+PNS1meNwlmv9Ti+Mpm7Y4FwaJoVggrl2aZ2BMPyZEB+UguDycuydEHFFQPaG9bbGjBqBnoYd+zCeiynfzRjBFW1HfAGB0izitKm321D/Y7p3cVBrypAGwIYrTPdM36y3xO8dC7JYPg8EuNn88wP/yx0Pi6JE/d8MrO3mvlSzNF76FzRTJehC47C9SeGHkzazABXK0cCXgYJDCJTJGstBEWmFvciTNpll3ecUus0Bf76gyA==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 SJ0PR12MB6925.namprd12.prod.outlook.com (2603:10b6:a03:483::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 14:19:21 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 14:19:21 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: Pickle vs. sqlite3 for cache?
Thread-Topic: Pickle vs. sqlite3 for cache?
Thread-Index: AdrzB+H7xOUdiODQRjiIf+vFoJhVuQAAuOKAAAA4DDA=
Date: Tue, 20 Aug 2024 14:19:21 +0000
Message-ID: 
 <DM8PR12MB54308A148D0E17754E7BD0308B8D2@DM8PR12MB5430.namprd12.prod.outlook.com>
References: 
 <DM8PR12MB5430C4D4EA06B2AD975C00928B8D2@DM8PR12MB5430.namprd12.prod.outlook.com>
 <3c11c796ba2c91178e0b67d7bc3ce508618c2ffe.camel@linuxfoundation.org>
In-Reply-To: 
 <3c11c796ba2c91178e0b67d7bc3ce508618c2ffe.camel@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=69b07a25-580b-4551-95b0-361af2bd1410;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2024-08-20T14:17:11Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|SJ0PR12MB6925:EE_
x-ms-office365-filtering-correlation-id: f2587cd5-d17c-4011-16a0-08dcc12315d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?WktrNHR0UmFidGtHbTYxdFdUa1VxRmdua3Rva05GT0VXeUM1eUhWcE9RempF?=
 =?utf-8?B?a2NSZW5SY1c0NVZvR0lFblN1bkZlblhGTTZPMDZKUjFVVnFkdWoycTM1MmJJ?=
 =?utf-8?B?SzdUSnlaajFLbkFPSW9iMkMxU0ZndXBndDUvREhGVHJ3empMeW1nUTZNNjZl?=
 =?utf-8?B?Qy94ZGowNTcxdU5nTkxGSXU4djhmZDI0elAvbHlqNnlYakpMLzRkMHZFc0E0?=
 =?utf-8?B?NjBwQ2N2UXlCTmpJWTk5bEJCc2ptSjhubU5YZlpZR0xRMDJ6aERmU3dldEdP?=
 =?utf-8?B?cGorcXJhL0pKR1AvbkllUjRqbkppTG9nd2wwQmRNbzRYdmRSVFBqZ1FHemtY?=
 =?utf-8?B?ZnRaUno5TzlTSFNuYTRHdDVGNmxLRms0TDNPR0pmdEMralZETjZnSnpLSlBr?=
 =?utf-8?B?aGp1dUlCcjhNSDBMNHFicC9rWk1YZzM4dUR5Ni9NZUFvaW9GcHVxaGp0Z1gr?=
 =?utf-8?B?OERZSjdERjFIaVo5NGZ1MEtOTzkxa2R2Y3l0V3pVNHduSENDcDhLTmQ2dE5C?=
 =?utf-8?B?ZXJkK2FPRmE0ZjgyUG1iUVArUkpkVmo4MmJvVEI0SU9FakVvcGp3UldJeG8y?=
 =?utf-8?B?b0x1L2JLN0E5V1VhU2JyZmcrakxXNXdDTEk0b2p1ejNoVWdYNXdmQkM5TVJ5?=
 =?utf-8?B?bmVBK29DYUdEUm5VVkRtditLV1RxeE11ZVlwSmh6UVFLdXMyM0xOZ2lERU9u?=
 =?utf-8?B?WEpqS2MwdVdxT1U1QzlBZmpRZWNpSzZWd1hwbzFhUng4ejlvTEEvZDA3VWRS?=
 =?utf-8?B?MFVMeUJjb1Frd25ObURrS3U5MmZ2N01YYmhWVkloM2NjMlRrNDIwclVoN2c5?=
 =?utf-8?B?M1JpcVQydzRLRmNzbUZvTHZueDBab21KVjAxcXBtWG16TDRqRm1NNlBBd2xT?=
 =?utf-8?B?SUY0NnRQV3llMlBpVDRrQ0lQNmJyWExOUmlZRFBER2RxSE1OM0pKaUQrTHJ1?=
 =?utf-8?B?cGdHaTJMR1A1NEpEdFN0d0Q4NnNQM0xXQ1kxc2hRcTFVVkNwVnQzazI2QWxr?=
 =?utf-8?B?emI2S2l1bUY5K2wxQnE0MG1JM3cxRjRmTjlDNUk3aEEvYm50a09WVzgvQlA2?=
 =?utf-8?B?bDIxalFUQmNEU3hhRHNINzYzOVdWMzN5N1djbFlXeWozQWlNdVExK2VQV2lx?=
 =?utf-8?B?bGRCNmc0Nk9jOFZIZU5ZYm9JRXhUNUVjTmxqZjZ2TDNUQlVLMFZqM3dwWm16?=
 =?utf-8?B?Y3NITjlYMXlDNUlBZ0p2M1NISlJHbVZaUjhUbkRjdTFGZEt5SUw3TVNwV09i?=
 =?utf-8?B?d3V6RFM5Mk83Y01rNkRvNDIxRnlNTW4rYnkzYzVjRXphUUUrRGpzUWY2VUZP?=
 =?utf-8?B?cDdIMk5CYnhqcytKaUlvcXRid08vZWVjbmJ2SkdXTGI2UzlLNVR1YXZQU0tT?=
 =?utf-8?B?QU5CUGZLbEg2K3lSSVRTeWJ0YmdFdlB0YkRhNmhLYWxyd1ZkWGJRaDQwcHJF?=
 =?utf-8?B?QkJ1R3RqVk9JWTZwcVBZenZHb25hbnY0aGtybVF3TzJXcGd3VXY1N1ZMd09R?=
 =?utf-8?B?aXF3MHVLR1pqV3ExQ2N5WU1zS0QwWkdWdm4zRDVFelBYYWFmLzlpbEJSRkRR?=
 =?utf-8?B?dGZmRWZtMTZxajg5bGRYZUg4VTVQZExHeGVaalc0bFMvaFoyWk1Ya1pQM3Q5?=
 =?utf-8?B?ckJpU2lVMUZUcVFsK2tLNEpRbm0wUkZXSHFhdVZWRGtOd1YrL2VKRVp5MHNI?=
 =?utf-8?B?OFRGaWduaGRiWW1BS0NrR2tTcTNYNkNVWCtxREpBSEZyNXkrYU4waFlKdVRC?=
 =?utf-8?B?eGZIaHFuWTM5eWprTDBJUm9KY0J1K1dnTVhzMmVwVlJnWERpemZOUnpRdjNS?=
 =?utf-8?Q?S0iVGbH83KY31cAvoz8ShF4xPomO9e05oe5fg=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RW5BNlJqVFY4bngrSjVpWk5zb3FPNUs5ZUZGYXVtV1J1cmp1OFFod0tXRkpF?=
 =?utf-8?B?emNaSkZFYnIrK3VleTdqMW9nd1BCQWpGRWF2d0dRUnUvUTNHbVBBcEdPYlRK?=
 =?utf-8?B?WUtFbEx5VU9QY1lzMjRJUEpZRXlLQkJHcVRxeDhrVE44SEh3SGZEVW5NWnBC?=
 =?utf-8?B?NWRFMnpkdFRtMG1pLzAxTzRVOHZ6Qjk1dzA1SWhIeEZYdktwcWY4ZHZYanNB?=
 =?utf-8?B?THJyWlVDMlcxRlNoalpBVzJ0Z0pVQUNxN2xvRUYrSHNIVUdUdjNFTWJVV3pt?=
 =?utf-8?B?YUViVnFzU1dMR25TNWpFd0hKZUgwUTlxZlByNGlZdThLUTN5SDJaQWxwTTh4?=
 =?utf-8?B?QWF6NDNWZ2ZROXR5Z0ZPaWxkT0lETlZ6dHBSYzhMSkd4R3poNzZsUWxEd0xy?=
 =?utf-8?B?WDRadGxPeE9ENGJoaXlGcnBJOHBoSHlKbEJVY3hCR2pSRzZDeUhJajR3djVF?=
 =?utf-8?B?UVgzYnJMa1o1MmF6Q3hNQ25RNlNURjZ5UndPTjU3aDJUSGgzZ3ZXTWwxdWpN?=
 =?utf-8?B?VlpadVRiNjVxdkFCUjZwUk5YUWZXMzg1R01RV3hTOGc4VkVHSXRvVCtGK2hn?=
 =?utf-8?B?R1ZFd21lVkx6ZUlUU295SXBpczczMEYvSDByTEVJanh4S24vcmJYUWE1bDFD?=
 =?utf-8?B?ajVQMnQvTStLc0toemdzTlJ1Tk0vVEZ3bVRqUklnclB5alh5ek1YVmVnYkRl?=
 =?utf-8?B?UDJJTU9VMlVKTjZxTTBiNG9hRG12SjVpY1dqSDVYL0pqQVJEU0ZHTzRaZUJZ?=
 =?utf-8?B?ZUhJWXkzZEMyUUpmYjl4dnMyNmlYbjR1dDlWUEM1Z21XVHFJSGJTVDFUSlBw?=
 =?utf-8?B?dmcvbTBvYUlRZWNFNnBScm1wdGFCOHlrU0ErU0RYcVJWcDlLUnhCa3NOb0J6?=
 =?utf-8?B?ajNQNWJKSSszUW5YWVZHUGJKbjJPMXpvRnNkeTVrWFJLS0Rzbml6dWFWU3Nq?=
 =?utf-8?B?WnBZQjBRME92OTF1RUU0M3Y5SC92QllEQ2FaZHl3bDNTMlBmemNyWThacTJC?=
 =?utf-8?B?VEgvWUpYNzNLNnNxSklOeVo0RzgzRmdJeWhCSlF4VDBIQnVrWG0rSi9QakVG?=
 =?utf-8?B?dUhtTXoyUkQybkYreVBmZVdUUVFTQXY4Tm5BZjQ5WHhGS1Y0cGxiVGk3SE9K?=
 =?utf-8?B?Yjh0QnV2OXE5WWJrb2Q1b3pnNnE3VkhGNFlGTitrSFcxK0NRUGVLdyt5czAy?=
 =?utf-8?B?QnNVZldGdVREVk5jMXpEL0NyWHJ5Q0laMjFla0FZRXliNW9FeUdGYWFDYWZI?=
 =?utf-8?B?Q3V5ZDBndmJvR0ZTSDN1WWNkK0hCWjYyVXRWVnV0K2d5Zk5xNzAwNkRra3FI?=
 =?utf-8?B?YmxlL0VEUm5zQVBvdXRYT05FU3cwemdXSzNDRjA1R3ZQYjlNSGQrZWhxSGxO?=
 =?utf-8?B?dVRDU0pXLzNWUHBZMVBLUXU2djBLcHIxdzJGYUFodCtqYjNicTA3RElMU0hy?=
 =?utf-8?B?czhOOGptQkgxV05DMEkySVRySmhvd3RRcGU1S2xxWTNtQ3ZEZGIxTEhjMEZK?=
 =?utf-8?B?VXVnYS9DTHd0eHVRaHErWGh3T25MT1B4OG5BQnZVUVdvMTI1Z2oxa0VPY0Fh?=
 =?utf-8?B?ZmozeGZDY2c0cTJzSVROckFqRnN1aTBxT3ZYT0dMajF3bmRmZ1VYellLR1lO?=
 =?utf-8?B?Y3dIZVNSL3RhaC9vUWtGeCtnSHc2aG5welhtVlV5S1QxWXJ5VmpNSm9TVTRz?=
 =?utf-8?B?R1JVdE9SaU9LSkt3TEt1YWNQbHVpcVhhaCthM1dFSHJUR0tPaHB3VFJ4dnNN?=
 =?utf-8?B?ZWlYRlAzRTR6MjlqMG1makhja3dpRFVlOEx4bzU1bnptWmpua3RUSklCZE5z?=
 =?utf-8?B?REhGUnM2c1VaNENwOEx2WndzdWJERGRuSlRsczM4WC83byszRnZCTkM4N2ND?=
 =?utf-8?B?Zys2VkN4U1ZuVVRhdEVnV3IrSEd0S0tqSXZudmk3Wmo3UnhUajVpcHBUaTJO?=
 =?utf-8?B?L0YvNUtpVmM3VjRYc251K0tGZ3hpVVk5OXJqbkE2ZWUzdk82OW5LbjBJeWJ5?=
 =?utf-8?B?NTNFTXJQMGlDYXdTdnZuRjVSMi85Wmc1OGdZNVF2MEFrVUpmK3BYQWUybEY2?=
 =?utf-8?B?UGxMK0t5aEdoT3NqOUFrblJjcVQ5NFZlamw5RFgwMkhGR29pdFRxdUhmZ2Q3?=
 =?utf-8?Q?p7yPv8jsGvQvpoyaskrWFdWdU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2587cd5-d17c-4011-16a0-08dcc12315d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 14:19:21.3669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N/MmrcaNinnZAkHG4igyA40iUUA9Jd0LMlDSrElw1MWAsnhOXOpcMzOLJH4aJ48M1ahJy4pmoHXwmat1cCBKl4N8VKAMYPsfRUSDoib42Eo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6925
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 20 Aug 2024 14:19:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16502

PiBPbiBUdWUsIDIwMjQtMDgtMjAgYXQgMTM6NTYgKzAwMDAsIGNocmlzLmxhcGxhbnRlQGFnaWxl
bnQuY29tIHdyb3RlOg0KPiA+IEFwb2xvZ2llcyBpZiB0aGlzIGRpc2N1c3Npb24gaGFzIGFscmVh
ZHkgaGFwcGVuZWQgKEkgc2VhcmNoZWQgdGhlDQo+ID4gYXJjaGl2ZXMgYnV0IGNvdWxkbuKAmXQg
ZmluZCBhbnl0aGluZyksIGJ1dCBJIGhhZCBhIHRob3VnaHQgdGhlIG90aGVyDQo+ID4gZGF5LiBJ
IHdvbmRlciBpZiB0aGUgZGVjaXNpb24gdG8gdXNlIOKAmHBpY2tsZeKAmSBmb3IgYmJfY2FjaGUu
ZGF0IHN0aWxsDQo+ID4gbWFrZXMgc2Vuc2U/IEJpdEJha2UgcGVyZm9ybWFuY2UgaGFzIGNlcnRh
aW5seSBiZWVuIGdldHRpbmcgYmV0dGVyDQo+ID4gb3ZlciB0aGUgeWVhcnMgSeKAmXZlIHVzZWQg
aXQsIGhvd2V2ZXIgaXQgc3RpbGwgc2VlbXMgdG8gc3BlbmQgYW4NCj4gPiBpbm9yZGluYXRlIGFt
b3VudCBvZiB0aW1lIGxvYWRpbmcgZ2lnYW50aWMgcGlja2xlZCBkYXRhIGludG8gbWVtb3J5Lg0K
PiA+IEkgd29uZGVyIGlmIGl0IGlzIHRpbWUgdG8gZHVtcCBwaWNrbGUgYW5kIGNvbnNpZGVyIHNx
bGl0ZTMgaW5zdGVhZD8NCj4gPg0KPiA+IEp1c3Qgd2FudGVkIHRvIGdldCB0aGUgZGlzY3Vzc2lv
biBzdGFydGVkLCBzaW5jZSB0aGVyZeKAmXMgYSBjaGFuY2UNCj4gPiB0aGVyZSBpcyBzb21lIGRl
dGFpbChzKSBJIG1pc3NlZCB0aGF0IHdpbGwgc3RvcCB0aGlzIGlkZWEgY29sZCA6KC4NCj4gDQo+
IEknZCBub3QgYmUgaW4gZmF2b3VyIG9mIHVzaW5nIHNxbGl0ZSBoZXJlLCBpdCBpcyBub3QgYSBn
b29kIGZpdCBmb3Igd2hhdCB3ZSBuZWVkLg0KPiBXZSd2ZSB1c2VkIGl0IGluIG90aGVyIGFyZWFz
IGluIGJpdGJha2UgaW4gdGhlIHBhc3QgYW5kIGl0IG5ldmVyIHNlZW1lZCB0byB3b3JrDQo+IHRv
byB3ZWxsLiBXZSdyZSBlZmZlY3RpdmVseSBzdG9yaW5nIHB5dGhvbiBkYXRhIHN0cnVjdHVyZXMg
aW4gdGhlIGNhY2hlIGFuZA0KPiBoYXZpbmcgbWFwcGluZ3MgaW4vb3V0IG9mIHNxbGl0ZSBpcyBu
b3QgZ29pbmcgdG8gaGVscCBwZXJmb3JtYW5jZS4NCj4gDQo+IFdlIHNob3VsZCBwcm9iYWJseSBo
YXZlIGEgbG9vayBhdCB3aGF0IGV4YWN0bHkgaXMgYmVpbmcgc3RvcmVkIGluIHRoZSBjYWNoZQ0K
PiBhbmQgdXNpbmcgdGhlIG1vc3Qgc3BhY2UgYXMgSSBzdHJvbmdseSBzdXNwZWN0IHRoZXJlIGFy
ZSB3YXlzIHRvIG9wdG1pc2UgdGhhdC4NCj4gSW50ZXJuaW5nIHN0cmluZ3Mgd2FzIHZlcnkgZWZm
ZWN0aXZlIGluIHRoZSBwYXN0IGZvciBleGFtcGxlIGFzIHlvdSB0aGVuIG9ubHkNCj4gaGF2ZSBv
bmUgY29weSBvZiB0aGUgc3RyaW5nIGFuZCBldmVyeXRoaW5nIGVsc2UgaXMgYSByZWZlcmVuY2Ug
dG8gaXQuDQoNClVuZGVyc3Rvb2QsIHRoYW5rcyBmb3IgdGhlIGJhY2tncm91bmQuIE9uZSBvcHRp
bWl6YXRpb24gdGhpbmcgdGhhdCBjYW1lIHVwIHdoaWxlIEkgd2FzIHJlc2VhcmNoaW5nIHRoaXMg
aXMgdGhlICdwaWNrbGV0b29scycgbW9kdWxlLCBzcGVjaWZpY2FsbHkgdGhlICdvcHRpbWl6ZScg
bWV0aG9kOiBodHRwczovL2RvY3MucHl0aG9uLm9yZy8zL2xpYnJhcnkvcGlja2xldG9vbHMuaHRt
bCNwaWNrbGV0b29scy5vcHRpbWl6ZS4gSSB3b25kZXIgaWYgdGhlcmUgaXMgYSBwbGFjZSBpbiBC
aXRCYWtlIHRvIHJ1biB0aGF0IG9jY2FzaW9uYWxseSAoYXNzdW1pbmcsIG9mIGNvdXJzZSwgaXQg
aGFzIHRoZSBkZXNpcmVkIGVmZmVjdCBkdXJpbmcgdGVzdGluZykuDQoNCj4gQWxzbywgdGhlIGhv
cGUgd2FzIGFsc28gdGhhdCBCQl9TRVJWRVJfVElNRU9VVCAoaS5lLiBtZW1vcnkgcmVzaWRlbnQN
Cj4gYml0YmFrZSkgd291bGQgYXZvaWQgdGhpcyBwaWNrbGUgdGltZSBpbiBwYXJ0aWN1bGFyLiBJ
IGRvbid0IGtub3cgaG93IGVmZmVjdGl2ZWx5DQo+IHRoYXQgaXMgaGFwcGVuaW5nLg0KPg0KPiBS
aWdodCBub3csIEkgdGhpbmsgdGhlIHByaW9yaXR5IG5lZWRzIHRvIGJlIHRvIHNvcnQgb3V0IHRo
ZSAicnVuY29tbWFuZCINCj4gYXN5bmMgdnMgYSBzeW5jIGNvbW1hbmQgaXNzdWVzIGFuZCBjbGVh
biB1cCB0aGF0IGFyZWEgb2YgdGhlIEFQSSwgdGhlbiB3ZQ0KPiBjYW4gdGhpbmsgbW9yZSBhYm91
dCBwZXJmb3JtYW5jZS4NCg0KQ2VydGFpbmx5LiBJIGRpZCBub3QgbWVhbiB0byB0cnkgdG8gYXNz
ZXJ0IHRoaXMgYXMgYW55IGtpbmQgb2YgcHJpb3JpdHkgd2hhdHNvZXZlciA6KS4gV2FzIGp1c3Qg
Y3VyaW91cy4NCg0KVGhhbmtzLA0KQ2hyaXMNCg==

