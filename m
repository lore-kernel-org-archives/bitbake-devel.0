Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3147C02194
	for <webhook@archiver.kernel.org>; Wed,  5 Feb 2025 12:12:17 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.98])
 by mx.groups.io with SMTP id smtpd.web10.10498.1738757530626694652
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Feb 2025 04:12:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@weidmueller.com header.s=selector2 header.b=yMAtaQW7;
 spf=pass (domain: weidmueller.com, ip: 40.107.162.98, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hvxo+E5aWwgqnvSI+6dy58ByeyQFc00k3WHhDtvaUyqnCql2Fv/hZfIy5ATXbtQqEeFciEEfs+PGC/iKR2+WwLojVvggr+BvzE7h0AxfVmUbeGuYDbweRsvGoH8rZI96eZPALu1nv7hsD7HBW3qSXuYbmG0Eiaf9Ah9eSbsAHUMS+HhhuCCchh7YNhkjtsuWq7lNV31IpEVwkYREskL6pvUK7NilPpXySqM8wwpl6hgPNiuTYDP669WO9dwt1ZA2wWTrt3aITduVrGUb/yecnyIqdrdl/V4Axk00Nxjt3x3h0qb0XdhLr9Yn5KFUmRV+pO1uwZnq2mwDw1q0/gjFSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCOpYwyDV0Tgw8iJ40hEj/97nDHgT/SgaJbCXdt5f3o=;
 b=w+iAhscI/rYkaLzkdv/RY/HLDlT3hlO9KDOG7W/ItnGVK2RjHGjTJqabiuZGDTkead+ddvtv2j3f7iQ601H046rSPt8iwzuTqkAkff4QIReDnieiLfghk1O/5MasaNuSp9pww+utNf0s74PY3HnK3/VoBmQt7d+7LS8JhLe1Bb17UNAuJJrhSKB1U07AtnFyn2I8q47TojYgldCsfFq0nTPr5CosbROw5QNIOUc1nU+lB4I6aE1eRkZoXS053Y3KDYhuhR/eLdL81YkHd00/6i5wazlFYCDIU42ZjIZtcG1z00qRBWLdQn/G0tpFvuWzPE47ZnA7+PML0UmEBsPuaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCOpYwyDV0Tgw8iJ40hEj/97nDHgT/SgaJbCXdt5f3o=;
 b=yMAtaQW7ivCYsba/HZWY1q+SU97eY2iC2qR6d4SFMNoZibZlB8svUgap86yrxWifar7rVi0V+g9HHOYJDbU3GcL7ULO1t3XK4gDEJSdlWiuEsGc8xe/HJ0cWMUay8AApNkxHTIM0iOcLGPZsuS/L4CZqNOpJBGG/f01klVG6qf/Tt+3owH00ADMV8cHRRLoY09IEEZo5eQ6kDFXn8vf1vf9mqeViVh5urshDWkcqKanRQFkex0zKzngfexaOra/Khbymuaz+XXoZ2yvRbnpRdU1bsB/4t5z4gj2lJ53n0LvGCFq3g/3BKOl7IdSgA5cCUGk6EmIW7N4cO615xTTLBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by GV2PR08MB8122.eurprd08.prod.outlook.com (2603:10a6:150:a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 12:12:05 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8422.011; Wed, 5 Feb 2025
 12:12:05 +0000
Content-Type: multipart/alternative;
 boundary="------------iQQgwNC5pBObZ0aSYaJI4A8x"
Message-ID: <027ed1ac-02ae-420b-a65f-d4e48bc86136@weidmueller.com>
Date: Wed, 5 Feb 2025 13:12:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [RFC PATCH 00/15] Make mirror replacement syntax
 explicit
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
Cc: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
References: <20250205071538.2681-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <f4533bb6d41d4011219cae737907015018a08ca9.camel@linuxfoundation.org>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <f4533bb6d41d4011219cae737907015018a08ca9.camel@linuxfoundation.org>
X-ClientProxiedBy: FR0P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::20) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|GV2PR08MB8122:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b864b5d-efeb-4f95-e93d-08dd45de4de9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|13003099007|8096899003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?R283bFF2QWVOQlBNaDZzYlZsK05CWGZGUWdXTWdhOW9mRDRVcVNjTm1ZUUg2?=
 =?utf-8?B?WVUxakJVMm1pUGdXanJJVDVmU0ZiUnpvamExR3diQVRqNnJmbEZIMEJtV3JQ?=
 =?utf-8?B?Nk5UMytxRi9yOWRuWmxMQWJkbTM2ZjJZWDJGcGFZd25hK09FZ2c1OWJWMDhz?=
 =?utf-8?B?QUVMblE0NFZLWXVsakJoL1hkU0RUZEhTeWJUaTMrcGxxa0o0RnpwMjNqdXlz?=
 =?utf-8?B?ekdBZkVzemdVRzFXOG8wRW11RVJJU1ZOdDgwUEVYY3hoSEdrTWdKajZnNzZK?=
 =?utf-8?B?WktqVEtoZGlzQ0thM05XOUFzdjIxeHVVZjJWSWhHVjRQbkFqWEtwdWNFNitD?=
 =?utf-8?B?WHlyL2s5elN0ZkI2bEJjRnhsdzFqNXZyWllPTzRuTDFYcG5xU2ZEWmk5SC8x?=
 =?utf-8?B?Y0MvTVRLNTNmY015QnR1YTJ1VklxU280YlNIN3p3bVhYOUZhRTFrcDBNQ2FU?=
 =?utf-8?B?aGV4aDNJUmthWEFrc0QwUkNuVEtMbE1PZE8wWjlSR3RTaWl6TFJDM2dLY2x2?=
 =?utf-8?B?VmZERjlBaGwvOXR4dml6NXJOSTlpSXkwWDJJakliV3REN3NwSXBrZXJ6L0Mx?=
 =?utf-8?B?WEk0MjZycmRzNlhyajdhS2haWGd0WUo2aVNuVXZ5MzdZUFR5RFFkSG1CZDRv?=
 =?utf-8?B?azdXanBnaFUvZlhrZDVIZzdyM25xdUtVWHQrUThVaUJJWkZwTHoyMzVCVTNT?=
 =?utf-8?B?UGlpME5Mbmo1RFhBbnloMnJ2Q0F6QjZBMS9PME10V3BOb0pERHZuSTNIaGl6?=
 =?utf-8?B?MXZvb3JkczlhU2xQZ1o4RnBpRmVHU0JqajdNMWZGTFFXV2RCRzBPd1BhNFNN?=
 =?utf-8?B?VHBqVHBvOHI4a1owbjk4QVJjUTk3ci9tc2QyQnlUb2dzQW5xVE1rUW9UdzZM?=
 =?utf-8?B?eDUzNkJhZDhzY2JCeUd5N29sN0tZcVlxdmhnZ0FFSXg5QjhSdlRmMFA0a1JY?=
 =?utf-8?B?Z0s0TnV0cnFNaVNZVEVGZ3hOdVIxeUZqdXlIWEkwVURCRUpPM21hZVRRaHox?=
 =?utf-8?B?OGVQSmxqSk9oUzVQSHhINGF6NDRuSURSS3FWTVZ4YjJMUk9kMElwc1dXTUNS?=
 =?utf-8?B?NnBhSk9LUjBPeitUWnJVcTIwanByeVBRdVkzOEZ3aFpQQUJ2clhlRDB6RytK?=
 =?utf-8?B?OGhIQk41YjZBcDIvN1F0WDFpNklUeUt1RVRaQ0ZTK0x0TGY1dTVaV3I0b0J5?=
 =?utf-8?B?NHdDSThSWnIzb25FUjVVQ1ZGbW5INmNLMHRrRGJ6dlZCQXlKb0NzNkYxZGpk?=
 =?utf-8?B?WkN3QURmTG5ZMEIrTTk0TnRXQVNrNFUvSEx6Z25HSmNPTHRQUk5VVmFkdFJG?=
 =?utf-8?B?ckF0UkJCVi9rQkk5dWVQYnB4d1lQTG1wVGxjdTFuZno1UW9JalhnQ2plQk51?=
 =?utf-8?B?cXJHbm9Qd0ZYUzNWV1VhbkZMRUxCd3Q1c1FWTjYrSEpkNWU5dXNaQi8rbHA5?=
 =?utf-8?B?WENhWUR6WVFuWDhjYzhMT3dVMzRmVG1mMHFUdE1YZGtDOHJvUTNOc0owaFRE?=
 =?utf-8?B?MUtHQVc2akFlY3pPb2J4dE9xT3EyQjk0Z2xhbDd3Q1ZkdnZhWExXMjRkM21D?=
 =?utf-8?B?ZjRCRXMzOEFiMndpMXVpUGV4dG4vcHF6QWg5c2lVNzBNM0JXNzlYWG9vT2V2?=
 =?utf-8?B?SE8rbURBUEZ4NEl4UGZlR0tOaFFZMDdVaXVVZWk4aHVmTEFnRTcwWkVpRGE2?=
 =?utf-8?B?VHNzbDhpUHJxd2JVVlVCdklqbnc2ZUxzN3ZiaTZGVmdCYWMyTzVzbThaeGhZ?=
 =?utf-8?Q?4xOJsfBtZ8wLRX840eNUUKmM7lglgvPbkYPrYN8?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(13003099007)(8096899003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NXBiMGpRQmNPMXcyRGxQYlJ1c3E5MUdUOHllVnA2MU5GcGtGUEJ5RzduWWty?=
 =?utf-8?B?NUVDc1dTSGNFeDRzMTBmbXphZlB0WXRKT2k2WFZkRFg2Kzg3bjdNeDYrbW4z?=
 =?utf-8?B?TEw1WllUQnprTnVOTUt2OVZTVmtFQWlTU29qWG9KejRBWWNFeGpMdHg2U0tI?=
 =?utf-8?B?cGdtL0Z0TVNuRmU1M1VIdW1KMU9iTkdZN1NQQWZHMllEN0xRZEhVVE91OWNh?=
 =?utf-8?B?WnFzb3pKQ3QxaWUrQmpCeFMzYzk4OGtRQzdiclpyb05mdkI2TlVkUU45ZmNJ?=
 =?utf-8?B?U1pDdGRZZ3RrYVBCcTJSUlNrc2JoRmgxeTc4KzN0TFozc0JMS3hraW42K01B?=
 =?utf-8?B?ZGxCMFpaaktPNE5SVXpKLzJBWE5tTjI0L2x3SEEvajJLc2dEc1FScHlWOHRP?=
 =?utf-8?B?TC8rWEVoWU5OVTh4SmxiWW9GT3N1SXAyVUo2czc4WDV3RFZ2YTQ5dGNmZ2lV?=
 =?utf-8?B?L1BHUXVyeStMT3FpNnk2ZnJFdVR5SzluV0M2N0ZlOTNTMWRaNWRmTTNHTVJD?=
 =?utf-8?B?R21qdVVwWXhFb1c0QjcxdmFXVS9LUkFFaUM5Y0N4WFhFN3crUGVRM0dOVUIw?=
 =?utf-8?B?WkNDTmpQVHNMQXJtNFNWL0wvSmxiUnlnL2dCTld6cFlFNG1IZXlUN2xGU2Uv?=
 =?utf-8?B?N3RZNU5GMEZheDBqTGFqdVo1TDdWcUhuUkFFVkVTY3U0ZVoxTzFaM0RWQTVU?=
 =?utf-8?B?OVJaOTM4L3RTUXpwSEVSM0YwQm8ya3RKU0cvb1NHVkJ0M2NrTWJrWmhDRnlH?=
 =?utf-8?B?N2hPTHZYNEdSYnBpNUlMdThIWWptOFlMU3g5NEtmelBUMHpxdW1nQ2NUNHk3?=
 =?utf-8?B?OER2UXBYZGNOd0l5NWlqU2tyM0JZSHROQWdaK1dBYlNES1E0SlVFeEYzYU00?=
 =?utf-8?B?K1JCYStJYWxPbGxVNE9ZOGk4TnJCdHNhOXkzcS9mMGtDak1TRFlrYjJoMHFs?=
 =?utf-8?B?WjVXYkVhTWNsdFJxWmpBaytqSUs1VWJqVDh0ZnZnTlNiUXcxUUE4bVFoUkZ1?=
 =?utf-8?B?NHNuQS8wQSt4aFEzZmRmOU4zZDFqMWgva3cyb25UWG9BQkw0TG9xeG5hM2Zz?=
 =?utf-8?B?WXdrcG1RNE9naEU2YXZVNHJETnR6RHVMSmRSczJTRDNYRjB0bmVEL2hLK3VI?=
 =?utf-8?B?d2NzUTdSREg2emsxeUJvOVdrQVdiQWh0RkRMWFIvQmU2bWNQa3ljdVNkenpq?=
 =?utf-8?B?aTJTSzhGbEJHVG5mM09LbDJHWGFWWm1kazFCcGxCMFNrUlk0RzdiSVBWbTJX?=
 =?utf-8?B?T1hpZVFiT1E1c3JzdG5xRXNHTXNLNm8reWFReE9WWHVLKzltemtzZTB6ZTlD?=
 =?utf-8?B?NmxONnAvOWhqV0RnaUw4SWtFNldKREhSN1cyU1dsVW0ybFJ3YVlNRFRqbGRk?=
 =?utf-8?B?dDRoSUdBb3RuMEFrU1ZOem1sbzl1WDVNaUZrMUpYQ1hzbEZFbTVQZVpQZVgx?=
 =?utf-8?B?OUwxVjNsNXR2U21xdHlVWk1BbzhMcjhmTXJ0Qjk3TUMxOVAyUkNEalkyeWdv?=
 =?utf-8?B?dDN1QVUzaTFySXBkSlBpSjZmSFFCL2dnV2JxUlkyL3VDRDFjZ0kySUhld05B?=
 =?utf-8?B?bVlJaVE2QVcrSCtGM1locHVSKzZEM1NIbkxEUVdwS1ZObXpFa0txY28wQ0VZ?=
 =?utf-8?B?QUpweFBtNU9NK1JpVFpwdElEUTVIOGFRKzkyZ1ptZXFjVG9WdHpaYUhab21F?=
 =?utf-8?B?UTExeGdOemVMMGJ3M2tIRGc4SFlsL2ZYeHJSM3ZYRi8rdVRLNzFlSHpKNFFE?=
 =?utf-8?B?cjBwUTNUVXowQktXelBNRmErcGlJQmVFN1hzZG10d0hjSU5COCtGNUo5d2FB?=
 =?utf-8?B?ekQ5bHBuOTFldFlBOTdza2ZoRFkyVFVWTmNEb3dBMVpTWW1IWkxiamJ1L3dr?=
 =?utf-8?B?cFVvd3NkSmZkWmgyRmdXaXlFZk5XMlVHWFowRENRQnZkeHhpY0QwditEWTVP?=
 =?utf-8?B?VEk4QVpDKzJaVm9oM1BPMjd1eEV0c0M1MnFoUEhrM3N1c3ArY2FPTTYwVi96?=
 =?utf-8?B?S2dFMDk2V25DVXRHeS9vK3F6aDlYVVcrVEd1dDc5dzlNRmh6ZUZTa3poK2ND?=
 =?utf-8?B?MWdnSlZvOUxZc3RIUW5KanpnZDNLZ0R2YzFLb2xpQmV5ZklQQmNVUUJ2SXpF?=
 =?utf-8?B?d3lCZWxmR0hSQkVyK2MzY2Z2T2EzNGxEYlNuR25ra3F6aGFjMEcxWDN0c2E2?=
 =?utf-8?B?Z0E9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b864b5d-efeb-4f95-e93d-08dd45de4de9
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 12:12:05.0495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fvm/ROsQS/m1kgFTWOSc6SY5h3ddBw5+z5x7MUECk+dWFtWYkf6eG7ADJxNX2BQOJT3yN0Bkvb5UA2iGRwg6qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8122
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Feb 2025 12:12:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17151

--------------iQQgwNC5pBObZ0aSYaJI4A8x
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 05.02.2025 um 11:34 schrieb Richard Purdie:
> On Wed, 2025-02-05 at 08:15 +0100, Stefan Herbrechtsmeier via lists.openembedded.org wrote:
>> The mirror replacement syntax contains many implicit transformations.
>> The path of the URI always contains the base name of the downloaded
>> filename. This makes it impossible to rename or remove the base name of
>> the original path. It prevents upstream mirror for SRC_URIS with a
>> downloadfilename parameter. The base name of the downloaded filename
>> makes it impossible to use the download mirror for SRC_URIs with
>> subfolders in the downloadfilename parameter. Altogether the implicit
>> transformation complicates the understanding of the replacements.
>>
>> This series adds an additional replacement named DOWNLOADFILENAME. This
>> replacement contains the relative filename of the downloaded file or
>> mirror archive for git and hg. This allows the user to explicitly define
>> the behavior. The usage is equivalent to the PATH replacement for the
>> sstate mirror from file to https scheme.
>>
>> git://.*/.*http://downloads.yoctoproject.org/mirror/sources/DOWNLOADFILENAME
>> https?://.*/.*http://downloads.yoctoproject.org/mirror/sources/DOWNLOADFILENAME
>> file://.*  https://sstate.yoctoproject.org/all/PATH;downloadfilename=PATH
>>
>> Without a replacement variable the mirror will use the same base name as
>> the origin SRC_URI. This allows the usage of private package manager
>> registry together with a downloadfilename parameter or the rename of the
>> base name.
>>
>> https://registry.npmjs.org/  https://example.com/npm/registry/
>> https://example.com/example/1.0.0.tgz  https://example.com/example/example-1.0.0.tgz
>>
>> The series adds heuristics to keep a backward compatibility to common
>> styles. Because of the ambiguity of the old style, it is advisable to
>> remove this compatibility sooner or later to avoid unexpected behavior.
> Thanks for the patches, these look interesting with some good
> improvements in there. A lot of the series looks like cleanups and
> those look like good fixes to have. It may make sense to split this
> series into two, the cleanups/fixes and the behaviour changes.
>
> I'm not entirely "sold" on the naming of DOWNLOADFILENAME. You have to
> think about this from the perspective of someone writing a MIRROR or
> PREMIRROR entry - would they understand what that means vs some of the
> other names?

I’m open for suggestions. Even ARCHIVE or TARBALL are hard to understand 
because it is only a relative path on the download mirror. Alternative 
we can mark the lines as upstream or download mirror and give the 
replacement different meanings. The path could be the original PATH for 
an upstream mirror or the relative path of the downloaded file for the 
download mirror.

> I'm also a bit nervous about breaking compatibility with the older
> syntaxes. It is unclear to me how or when  we'd detect/deprecate older
> formats. I do agree we probably do need to remove some support for some
> syntax and move to something new though as what we have is turning into
> some kind of nightmare. FWIW this is really old code that in many ways
> predates my involvement so probably 20+ years old.

The only possibility is to mark the new format because it is impossible 
to know if a replacement want to keep the base name of the path.

As example the following replacement is used in the test:

file:///some1where/.* file://some2where/

The plain regular expressions replaces the complete path with a new path 
but the old code appends only the base name of the path. What was the 
desired behavior?

file:///some1where/ file://some2where/
file:///some1where/.* file://some2where/BASENAME_OF_DOWNLOADFILENAME

The main problem is that we have to keep the bugs if we keep the old 
behavior.

> I'll continue to give this some thought. If you could confirm which
> patches are "cleanup" that would help though, we can see if we can get
> those in a bit faster.

The first 8 patches are cleanups.

--------------iQQgwNC5pBObZ0aSYaJI4A8x
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Am 05.02.2025 um 11:34 schrieb Richard
      Purdie:<br>
    </div>
    <blockquote type="cite" cite="mid:f4533bb6d41d4011219cae737907015018a08ca9.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">On Wed, 2025-02-05 at 08:15 +0100, Stefan Herbrechtsmeier via lists.openembedded.org wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">The mirror replacement syntax contains many implicit transformations.
The path of the URI always contains the base name of the downloaded
filename. This makes it impossible to rename or remove the base name of
the original path. It prevents upstream mirror for SRC_URIS with a
downloadfilename parameter. The base name of the downloaded filename
makes it impossible to use the download mirror for SRC_URIs with
subfolders in the downloadfilename parameter. Altogether the implicit
transformation complicates the understanding of the replacements.

This series adds an additional replacement named DOWNLOADFILENAME. This
replacement contains the relative filename of the downloaded file or
mirror archive for git and hg. This allows the user to explicitly define
the behavior. The usage is equivalent to the PATH replacement for the
sstate mirror from file to https scheme.

git://.*/.*&nbsp; <a class="moz-txt-link-freetext" href="http://downloads.yoctoproject.org/mirror/sources/DOWNLOADFILENAME">http://downloads.yoctoproject.org/mirror/sources/DOWNLOADFILENAME</a>
https?://.*/.*&nbsp; <a class="moz-txt-link-freetext" href="http://downloads.yoctoproject.org/mirror/sources/DOWNLOADFILENAME">http://downloads.yoctoproject.org/mirror/sources/DOWNLOADFILENAME</a>
<a class="moz-txt-link-freetext" href="file://.*">file://.*</a>&nbsp; <a class="moz-txt-link-freetext" href="https://sstate.yoctoproject.org/all/PATH;downloadfilename=PATH">https://sstate.yoctoproject.org/all/PATH;downloadfilename=PATH</a>

Without a replacement variable the mirror will use the same base name as
the origin SRC_URI. This allows the usage of private package manager
registry together with a downloadfilename parameter or the rename of the
base name.

<a class="moz-txt-link-freetext" href="https://registry.npmjs.org/">https://registry.npmjs.org/</a>&nbsp; <a class="moz-txt-link-freetext" href="https://example.com/npm/registry/">https://example.com/npm/registry/</a>
<a class="moz-txt-link-freetext" href="https://example.com/example/1.0.0.tgz">https://example.com/example/1.0.0.tgz</a>&nbsp; <a class="moz-txt-link-freetext" href="https://example.com/example/example-1.0.0.tgz">https://example.com/example/example-1.0.0.tgz</a>

The series adds heuristics to keep a backward compatibility to common
styles. Because of the ambiguity of the old style, it is advisable to
remove this compatibility sooner or later to avoid unexpected behavior.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Thanks for the patches, these look interesting with some good
improvements in there. A lot of the series looks like cleanups and
those look like good fixes to have. It may make sense to split this
series into two, the cleanups/fixes and the behaviour changes.

I'm not entirely &quot;sold&quot; on the naming of DOWNLOADFILENAME. You have to
think about this from the perspective of someone writing a MIRROR or
PREMIRROR entry - would they understand what that means vs some of the
other names?</pre>
    </blockquote>
    <p>I’m open for suggestions. Even ARCHIVE or TARBALL are hard to
      understand because it is only a relative path on the download
      mirror. Alternative we can mark the lines as upstream or download
      mirror and give the replacement different meanings. The path could
      be the original PATH for an upstream mirror or the relative path
      of the downloaded file for the download mirror.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:f4533bb6d41d4011219cae737907015018a08ca9.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">I'm also a bit nervous about breaking compatibility with the older
syntaxes. It is unclear to me how or when  we'd detect/deprecate older
formats. I do agree we probably do need to remove some support for some
syntax and move to something new though as what we have is turning into
some kind of nightmare. FWIW this is really old code that in many ways
predates my involvement so probably 20+ years old.</pre>
    </blockquote>
    <p>The only possibility is to mark the new format because it is
      impossible to know if a replacement want to keep the base name of
      the path.<br>
      <br>
      As example the following replacement is used in the test:<br>
    </p>
    <p><a class="moz-txt-link-freetext" href="file:///some1where/.*">file:///some1where/.*</a> <a class="moz-txt-link-freetext" href="file://some2where/">file://some2where/</a><br>
      <br>
      The plain regular expressions replaces the complete path with a
      new path but the old code appends only the base name of the path.
      What was the desired behavior?<br>
      <br>
      <a class="moz-txt-link-freetext" href="file:///some1where/">file:///some1where/</a> <a class="moz-txt-link-freetext" href="file://some2where/">file://some2where/</a><br>
      <a class="moz-txt-link-freetext" href="file:///some1where/.*">file:///some1where/.*</a>
      <a class="moz-txt-link-freetext" href="file://some2where/BASENAME_OF_DOWNLOADFILENAME">file://some2where/BASENAME_OF_DOWNLOADFILENAME</a><br>
      <br>
      The main problem is that we have to keep the bugs if we keep the
      old behavior.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:f4533bb6d41d4011219cae737907015018a08ca9.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">I'll continue to give this some thought. If you could confirm which
patches are &quot;cleanup&quot; that would help though, we can see if we can get
those in a bit faster.</pre>
    </blockquote>
    <p>The first 8 patches are cleanups.<br>
      <br>
      <span style="white-space: pre-wrap">
</span></p>
  </body>
</html>

--------------iQQgwNC5pBObZ0aSYaJI4A8x--

