Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B23FE7719C
	for <webhook@archiver.kernel.org>; Fri, 10 Jan 2025 11:32:59 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.94])
 by mx.groups.io with SMTP id smtpd.web11.16133.1736508773696149973
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Jan 2025 03:32:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@weidmueller.com header.s=selector2 header.b=W/AuX9zv;
 spf=pass (domain: weidmueller.com, ip: 40.107.22.94, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jALgam04ugWeK5K/K+Di+Ik8j99CDkE7nCqWUy2TD4SVYXxjJ13oHv5+8xDWCiBbvOT6py7D/kr6iMAZtOcx0nTcGf2+ebJmho9TrfcmvEe6LN+vQdlgzij5dIYEQNxWWdjNU8Cbm472flnCmrLeGq0uZLXxATEU0+V1n61T8mcSK1hBW9epLm4xP2yK9x9KUxZSedEEO4kZ21mh0mVgdk6EQ8FRmVVastUHHIrozloLRXRy4qvC1f0VqzK17hZl3oa4zk8janANLQqsvvDpnYWYhbWx999MJEPLjrxnQhz3fK+GB09wfJmM2KHPRwbPcxyM+vbmmQuF8PzDWx5O2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZSivQUChU3fqwqckg9L4Ww49K2Yl2G10WQNfe5v0r4=;
 b=zA2ZLMngbzN1Hb3PoGfCf++Fj3L5qYm9iSzZ+FN1n6p+vkb4tBMqPVb5O5x+zFZh08VVvrnYZFkq8C0cR/FvfzMCMtpITS9PfSixiCfZWqsJxHJV4IsUDX8mdxBOcFKZZhjIx4YLbiLfvhV8TNU/0QC1NJsjnfLMoiZE3KWDezRt/lYGpU5uYSsTtn+YGXjBI+kCLwwXyKwbrNJoLz4uhG0hMD15BMRCOTiDK/mCa8o/qqEH8m+lmQXapBy50QHT0tpShRskQuo7ugvJYl4r417bc0WZfQ7I316V1dqXRkBwsZfZQAJyPtX8cVEgtgEKE4QuARme1EIoDgYku8qHuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZSivQUChU3fqwqckg9L4Ww49K2Yl2G10WQNfe5v0r4=;
 b=W/AuX9zvCwa9mjVBLeoxzobMSJsmBm+tYcjtrNog+ZYWv72JqKDKTrcvchbDCeGtHGl09djASDDz4XcXuZAiziJukPusVTvJAAVJSdgcp9SA1eYZ/TO0bmd/jp7lrJaBUlP2w5uNj0v85JTj3Pd8HjL5LWYovqITJkF3X4rVQ4aQSBGyat3jvlgs/f07U8Px3Tyt4RRUo3bY7JV+roV13YFr0+WbrwQZ7jfo7VwV622Jnf372Uh8MgjycBI9mQuiG8z5Mx68jJpxm4l+B7NbsWQCbe41JyyBZD53/mdhuzZ6gGTBoEnGSMbZKqzX4xee9FCPsm1FRaMKd9lSqVdrGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by AM7PR08MB5397.eurprd08.prod.outlook.com (2603:10a6:20b:dd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 11:32:50 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 11:32:49 +0000
Content-Type: multipart/alternative;
 boundary="------------QJbg7St96ToCHYYGG1qvK8UO"
Message-ID: <7121dc06-215a-4481-be8e-7094a45e43ad@weidmueller.com>
Date: Fri, 10 Jan 2025 12:32:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [RFC PATCH 00/21] Concept for tightly coupled
 package manager (Node.js, Go, Rust)
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: richard.purdie@linuxfoundation.org, bitbake-devel@lists.openembedded.org,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
References: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <aeac8b24d43c57b7b426983ae50ec65680dafc24.camel@linuxfoundation.org>
 <CANNYZj9q6+D6AppzUbuV_cdMszt_KA3kfsamOtcRFxoWWFjV+A@mail.gmail.com>
 <513bf8f4-fb14-42dd-89fb-275e4b468924@weidmueller.com>
 <CANNYZj_z49bpc7fnvKO737La2YHy7zCPsgzwhS-G+=OQfi6uUQ@mail.gmail.com>
 <c164bf03-b00c-421e-a41c-441fe911eac5@weidmueller.com>
 <CANNYZj_-+uq0HmLYWAU1kEBPdkiCfyjkAu8cdSjxt6PsCB=-9A@mail.gmail.com>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <CANNYZj_-+uq0HmLYWAU1kEBPdkiCfyjkAu8cdSjxt6PsCB=-9A@mail.gmail.com>
X-ClientProxiedBy: FR4P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::12) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|AM7PR08MB5397:EE_
X-MS-Office365-Filtering-Correlation-Id: 1396b145-9438-4ead-039d-08dd316a835b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bnNwdmFpYTVlbzBmSkZvaHhncE1qeklicnFGQXRQbDJPUktBb0JObG9GdDlu?=
 =?utf-8?B?a0VKT0NUK0p5K3RWOUd6MGFEUWFBOUpxYUN4ejR1REdmZ3FneG9CcUhVRWFk?=
 =?utf-8?B?bVZRQUJvL2ZQWHJhY2hEL0NtWi95ZDRIV0FENExnY3JOWmVZRVEzYld5eHhi?=
 =?utf-8?B?ekszSVZ1YTNDMU5obXd1eE5yNlRGSkR6SE5LYkJkTzE2M3FodnJNeHJOd0NY?=
 =?utf-8?B?UXUrUHc4YUJhMEc5TFRnbGpRVmxmd2VRaWlXRjFjV3cyL0p5NWhNVmcwMndz?=
 =?utf-8?B?RDBQZElIYXBXbUxvUytvOUpGM3hVY2FnT1R0TkVtRlNhVUNOTEtlWEpCQzdj?=
 =?utf-8?B?dGNMOHZhSUVYNlpqQUh0Y2l2MnFabUFraUZjT3lMekFRQ3VyMkpySEl2QkR2?=
 =?utf-8?B?K3B3Q2kzS2ZBREtRZFhONUkyM0ZnLzJGSm1PNmw5Tnl4Yko1a0xMWlJUZHdY?=
 =?utf-8?B?OVdTSnhkcVM2OHBxeGFydEtvT2lUSXpiTzB5N3l0NkZNTlNyOVBnRU5wNUV1?=
 =?utf-8?B?cTAxZWltMm9QclBYT09aT1hqRVBRZVFST2ticWF2QmZQOFBCcVFyak5ZZzIr?=
 =?utf-8?B?cThhcGxPcFhZZ0lnSkpGVVluYlc1aGNKOFRJRVJHNDBUN3N5UU8rSTlXRHJK?=
 =?utf-8?B?czhmYkFnNW1xbEN1YXhlM3JuYU5lZHNrSUdGaEFPQUtMZ1Joanpsd2RzbC91?=
 =?utf-8?B?L3FjakNxZHoyYS9Vb1VKT25MSWxPUjJ2YWY4azY1b3MvWGhrSTNVSjlqU2dx?=
 =?utf-8?B?Y0xiNXc3Q0R5ZzlSVWt0cEt3WFpPU2J0RndGV3d3UFhLVlVRWGVCS1p0U0Zp?=
 =?utf-8?B?REE0cW9EQ0ViWlhzdFhoYy9IaTdsNmdGdDBUMVBNMmlIdXZHbGRRL1FNWStP?=
 =?utf-8?B?UWpYNktPNkFEbEc0ekRDbEx1bS95WUt4MlZpd3h3WUtiYy9UTEZ0dlA3N3F2?=
 =?utf-8?B?cHh4MTJuQXRob29IY2lyK2VNS2Q5ZVB3Njk2bVo1ZDF3VkxBNkpXWk82ZDEr?=
 =?utf-8?B?MnM4disvb29DajhDaGs2REZzREFqVGFoZDdJS3d1NjlMR1A4bUd1aGhTcVR0?=
 =?utf-8?B?U0lqYk4zUm83ZCs5aDFYOFpldWZKZFlKdFFVNytvQWNNSVFobnpkdWtuOEVI?=
 =?utf-8?B?ZStjMUNkVVlzVy9admtyaW9Md3hRMGREOGVrTkk2NTI0eVpLMGMvWFdvVjhQ?=
 =?utf-8?B?dnlhT21kbytRTk43TkRTbG1PWXllK281QVNiVFpBWk1Hb2FiNUtkbHdPaitH?=
 =?utf-8?B?N1MyQjhmS3FETnpTc0l0MHNvc0FZQmNQYUpsU3B4ckhZM0dLWmdmK3BXQUh2?=
 =?utf-8?B?Tyt0WWwrQUQ5UE00NnVHUmV1UGh6bHB0YVZTQ2ZXeTFtVmhTSmFIWE1FVWg3?=
 =?utf-8?B?UXBDTWw3cFpDR08vSDFLdlFiczl4d3JrRi9xb0ZpUDdmQnV0SHR6N0k5SUpz?=
 =?utf-8?B?emVtaW9yOGNDaENGUjdEcnlnTEpYWmVvSTFVaDhaUWF3em8wMzBndS9nUVl1?=
 =?utf-8?B?UVc3R0VCNlRmbFR4QjNmTDMxZmtnejBzSlRndWFVVEFld3FZUExKTm0yRERS?=
 =?utf-8?B?YTJuRE5kYndMSlhMSmpScnVvTG04ditCTTNUbm9rUHppb2JNNlNpb3kvdVRL?=
 =?utf-8?B?ajByUlV5cDBMVkdYTXVrMisvU2E3Z3lSQnl4VFQzUUZLditEOCs0cUwzYU4z?=
 =?utf-8?B?Wlpha280dTZrcHZ1Sk9sVTR0NnpIVDQxeDlEamdhd0FCTGsyeTB2Z3YrSWNh?=
 =?utf-8?B?cnN1Y3ZuN3c1cXBjVEdXdmpVWVVHYk54aU9QSWRaN08ybDRFa0l1MG4xYTJO?=
 =?utf-8?B?YllNZjF2aVBZSWhRU2l3S0dQTXJwLzlGaFh2RkhhdUZvYmpqVnZ2WHdJa3hO?=
 =?utf-8?Q?CdS4PluM31iRP?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(8096899003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TVZ5Q2t3K25iMEJ3MmZpMmI5M2JnQ3BrclBHbWE0bFJLby9ZMTJyV3E1aCtZ?=
 =?utf-8?B?OVhHb0xIQjhHa2lJUEJMamRhMmpsRFZSN1I2QitaMElqNXMyTno2VjdydURS?=
 =?utf-8?B?MEl4M3ZvZDR0UTlYbngrZi9HN2RodDR2UWRzMTNiNEs0U2Rxb3ZQUXVzUjBU?=
 =?utf-8?B?Mis3RlRVbVp1bVVDQk9BejJOTWs5VE0zMzJlVlB6R2N3eEIyL0RtMnpDbm1I?=
 =?utf-8?B?eXh2SzROZXdDc1FRT0lLZnJCdU9JZU0wNlBKVFc4djE1YWJmT0FNaTBrRlNC?=
 =?utf-8?B?cGh3RWsxMjBKc3R3eTZZKzZMbXF2TUhlMm5waUFZZXBuL2JlamYwNE9EN2ZT?=
 =?utf-8?B?UWcrNGo2M3kwNEF4RlMwSDFBUFdhM0Z2bEpiTnM5V1FaZnhWbmg0b0tRcGFn?=
 =?utf-8?B?YUFEckVWQVFmZnJtcm1hR0tSZzMvVDdZdnBld0tHLys2dEVJazRkWWhMMzZo?=
 =?utf-8?B?NE5ZaGRrdmNrU2NZRW9vMy9ZNVdFd1c2WDR5V21vR1h3elBNUWhYN2tvcitq?=
 =?utf-8?B?WWJZaUlra25wS2RPaXFFcWhRbUNQN1dseXZDZXlGL1lJUlcwVDBPbDNnVEdV?=
 =?utf-8?B?dGtPZit0cUNpSHZpODk5RjN2Y3ovQmVseDNPMlB2RlpKYjhzQWJhV25XSVdz?=
 =?utf-8?B?a3JNbEVYMlVKS3czMVU4SVhXL05OQmVQOFkrZXovUVcxUDBXa1U0d2VaVmRO?=
 =?utf-8?B?aHphVnpBdWdUNG5tNHN0cTBibk9oVG8zdk5qREJQNUZMbnBlZHY5dTV2YWF3?=
 =?utf-8?B?MzRUcUtHWEV0SFRiUEV2Z09rL0pteGVabGlhVTlaK0hIZ1RhRFVaRXV2OHZF?=
 =?utf-8?B?bVdIUDJVSTRFeGlOemNIL3RTU01DbUNnN0daUGFyQ0hBTTZnRWRzMS8xdHhF?=
 =?utf-8?B?U3NoaUdCckhZRlpCdUlKaGtuYTlKZndHT2xRM002cVkvdkdRcVJhYjBXMTcz?=
 =?utf-8?B?elY1Sk9OQW5MdE1MaE5KZzdlZmlOclJUNmRKOW1MMm00Ry9aYlZjZE1WZFZF?=
 =?utf-8?B?RzJrdzFZNmt5a0ZuODdvMXV0WEIrTng4bEVuSjQ0QlBSZUNqdnloRGJxNWtz?=
 =?utf-8?B?Mk10L2tlNmJobVdBRmtza2VXUzZBS0xaMEJzRzFTSnozTjJtZXp1dnpLL2tz?=
 =?utf-8?B?SjBZOVFmaWJxdE4zUXlGSjFjSS9MMDE0em9ZZEI0TUxoYi9TQTg1OTdtSFZR?=
 =?utf-8?B?cTVOdGx5Mnp6NHVNek1NL2IyR1IzcWROblhYQjhmai95OFY1R2RpbGwyY2lq?=
 =?utf-8?B?UFJVUVdqb0VvL2RjUmRTb1NUd0szaXZDRzBlVXVyS3g4eE9LdzJlRWlPcG5a?=
 =?utf-8?B?QTZnU1I2a1MrYkVwUml0dW9oQXA3UGRjOERJSk8yaC9CZG1zaXFaRjkrWmpK?=
 =?utf-8?B?a0xxNUJxcS9WTFdhSWxJZ3VrUUlRUjFTV2ptcjZCTEtJTndhUUFDYWFSUlVl?=
 =?utf-8?B?dGlOMnVabk1FN2h5MStoYzEvcFVxSmt5M2RjMVdibG9GUFBGWGF2SkFCQ2xF?=
 =?utf-8?B?bFF1QldXTmhabXJ0eWVTY1EySitZSmhJQThaNXFxckJvRy9temJ3RlpKT0hr?=
 =?utf-8?B?RlhhMHZmbXVzSzhlMlJvOUgyZkRFcnNMTUxFd2w1a0tOUjdwZXUvOXpUL1Ja?=
 =?utf-8?B?dHRSSDM5RVJUOTNjbmhXNEp3YVEwWnBoQXVyUU9ybDNjbUFyRjByT09icGxu?=
 =?utf-8?B?dXBIeE9TaTdvSGhzM1hKQWxoSFVqRlEvdXZwSkVtMWlMSHhrN1FReER6T3FX?=
 =?utf-8?B?bGxySXJsVnFYSUplUXlrRW5kM3pmZ2V5U09JLzJxcFhiSytOMW5jQlhyYnha?=
 =?utf-8?B?Y1BzYnVwQ0gyNTJmMy91KzlKczlidnFUaGx0VXVDV1NidGtHcWd0TGthOStI?=
 =?utf-8?B?WWFOWG9ySVY5OENCN3hQSk02amRuazJKNUNlVjdkSUJCTHdLYUpMSG1aR3Rw?=
 =?utf-8?B?THU2MEpaclpTWVZnMXlaU0N2bkgwWllpNjh6QWZVa0l2REVSZFhWUHJsREg5?=
 =?utf-8?B?S0tpdFlxWUZwZEhHY3l1c3NveGFzcVZObm5vQzdHSXBVOS9yeE9wS3hvMUJY?=
 =?utf-8?B?R0k5dmdqRWJGMGJIZUdhejN5c1VBMHpWckFwa3NaQS9MRUYzSlZHL2tSelI3?=
 =?utf-8?B?UTJ6cmFISVJ4dFNqV2FrTVJwd0RxcHVWQ0lQYTlIdG82TkpicTNSbGpHditO?=
 =?utf-8?B?QlE9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1396b145-9438-4ead-039d-08dd316a835b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 11:32:49.8198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /J2CpCBPoYXgkM3NpFieDBQdanabzrYYZ5VpgS8bEma/4pWyc+n6rozbQ/NdAiqKwe1ZezIP2KrRMgbWRliQag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5397
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Jan 2025 11:32:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17004

--------------QJbg7St96ToCHYYGG1qvK8UO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 09.01.2025 um 20:40 schrieb Alexander Kanavin:
> On Thu, 9 Jan 2025 at 15:00, Stefan Herbrechtsmeier
> <stefan.herbrechtsmeier-oss@weidmueller.com> wrote:
>> I missed the appropriate function in the dependency mixin in this
>> series. The list is created on demand (see archiver or spdx patch).
>> Every derivation need to be handled in a package manager lock file.
>> Therefore you could place a lock file beside the recipe. You could use
>> an editor or the language specific tools to manipulate the lock file.
> I'm not sure, is there code I can try that does this (and if so,
> how?), or is this code still to be written?

You have to inherit create-spdx-2.2. If you use poky as distro you have 
to replace the 3.0 in create-spdx with 2.2 because it is impossible to 
override the inherit in poky.conf. Afterwards you can create a SBOM with 
the following command:

bitbake -c create_spdx librsvg

The same feature will be added to create-spdx-3.0 but therefore I need 
some recommendations from the spdx experts. After we have an agreement 
how to provide the needed information I will work on the create-spdx-3.0 
support.

>> What is the motivation for that requirement ("just by looking at the layer content")?
>> Why can't we use a SBOM for the vulnerability check? Do be really safe you have
>> to scan the code because of embedded packages (vendoring) or git submodules.
> That's right. I don't disagree with this.
>
> I do however have another concern I want to express: I can't convince
> myself that the 'integrated fetcher' is an overall significant,
> obvious, major improvement over the 'generate the SRC_URI lists in
> .inc files via task in a bbclass' approach.
>
> Just a couple reasons:
>
> - the 'integrated fetcher' is not trivial, and notably increases the
> complexity of bitbake fetcher codebase. We already struggle to
> maintain bitbake, RP is overloaded, and very few other people have
> time and knowledge to look at bitbake patches, and understand what is
> going on. You've already seen this with your patchset where getting it
> properly reviewed by anyone else than RP is an ongoing challenge. On
> the other hand, the .inc updaters are fully contained in oe-core
> classes, they implement a task in well-understood 'recipe python'
> dialect and thus benefit from a lot more people being able to take
> care of them. They're also safer in the sense that any bugs in them
> are only triggered when someone needs to update a recipe. Fetchers, on
> the other hand, are fairly critical pieces of code and they must work
> regardless of host environment, python versions, unforeseen corner
> cases in source trees and so on.

You mixed two different points. We have to distinguish between bitbake 
fetcher and the on-the-fly resolve of SRC_URIs.

Regarding the bitbake fetcher the same reason are true for the language 
specific fetchers. The fetchers are based on the wget or git fetcher. 
They only add a preprocessing of the source uri and a post-processing of 
the download. There is no requirement to do this inside the fetcher.

The on-the-fly resolve is also possible in oe-core. I think it isn't 
really practicable to manipulate the resoled source uris because of 
dependencies between dependencies and the relationship to other package 
manager configuration files. Why shouldn't we use the package manager 
specific tools to update the configuration and dependency specification. 
I understand that a patch is more straightforward than a new dependency 
specification file.

The inc file is an oe specific format of a dependency specification / 
lock file without available tools to update entries with respect to the 
relationship between entries. Furthermore it is impossible to use the 
changes outside of oe for tests or debugging.

What is your opinion regarding gitsm. Should we remove the bitbake 
fetcher and use a update task to generate a inc file with the source 
uris and source revisions?

Do you really review the changes of the inc file?

I understand the points but I have the feeling that they are more 
theoretically for package manager dependencies or could be solved in an 
other way (ex. caching)

> - we might be able to remove those long SRC_URI lists by migrating
> recipes to the integrated fetcher, but we won't be able to do this
> with the licensing information (pointers+checksums to licenses,
> license strings) for items that are being fetched. For that, you still
> need some way to write it into a recipe with a tool. We don't do this
> yet, but we really should.

The license topic is independent of the fetcher because the dependency 
specification doesn't contain license information. The recipetool shows 
that the license topic is really complicated. It is possible to fetch a 
license string from the package manager repository but this information 
is useless without a pointer to the license file and a checksum. The 
automatic determine of the license from a file need a very good tooling 
because we need to trust the process and it must minimize the manual 
correction. Furthermore you need a central database otherwise you have 
to fix the same problem twice because the recipes could use the same 
dependency.

Even if we put all license information inside the inc file. Who should 
review the changes ? What tooling is used to review the change (license 
content)? If we blindly trust the inc file generator, the inc file is 
useless and we can generate the information on-the-fly.

I understand the motivation for the update task / inc file but I don't 
think it adds any practical benefit.

Nevertheless I will move my implementation to oe-core and add a task to 
generate an inc file as starting point.

--------------QJbg7St96ToCHYYGG1qvK8UO
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Am 09.01.2025 um 20:40 schrieb
      Alexander Kanavin:<br>
    </div>
    <blockquote type="cite" cite="mid:CANNYZj_-+uq0HmLYWAU1kEBPdkiCfyjkAu8cdSjxt6PsCB=-9A@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">On Thu, 9 Jan 2025 at 15:00, Stefan Herbrechtsmeier
<a class="moz-txt-link-rfc2396E" href="mailto:stefan.herbrechtsmeier-oss@weidmueller.com">&lt;stefan.herbrechtsmeier-oss@weidmueller.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">I missed the appropriate function in the dependency mixin in this
series. The list is created on demand (see archiver or spdx patch).
Every derivation need to be handled in a package manager lock file.
Therefore you could place a lock file beside the recipe. You could use
an editor or the language specific tools to manipulate the lock file.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I'm not sure, is there code I can try that does this (and if so,
how?), or is this code still to be written?</pre>
    </blockquote>
    <p>You have to inherit create-spdx-2.2. If you use poky as distro
      you have to replace the 3.0 in create-spdx with 2.2 because it is
      impossible to override the inherit in poky.conf. Afterwards you
      can create a SBOM with the following command:<br>
      <br>
      bitbake -c create_spdx librsvg<br>
      <br>
      The same feature will be added to create-spdx-3.0 but therefore I
      need some recommendations from the spdx experts. After we have an
      agreement how to provide the needed information I will work on the
      create-spdx-3.0 support.<br>
      <span style="white-space: pre-wrap">

</span></p>
    <blockquote type="cite" cite="mid:CANNYZj_-+uq0HmLYWAU1kEBPdkiCfyjkAu8cdSjxt6PsCB=-9A@mail.gmail.com">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">What is the motivation for that requirement (&quot;just by looking at the layer content&quot;)?
Why can't we use a SBOM for the vulnerability check? Do be really safe you have
to scan the code because of embedded packages (vendoring) or git submodules.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
That's right. I don't disagree with this.

I do however have another concern I want to express: I can't convince
myself that the 'integrated fetcher' is an overall significant,
obvious, major improvement over the 'generate the SRC_URI lists in
.inc files via task in a bbclass' approach.

Just a couple reasons:

- the 'integrated fetcher' is not trivial, and notably increases the
complexity of bitbake fetcher codebase. We already struggle to
maintain bitbake, RP is overloaded, and very few other people have
time and knowledge to look at bitbake patches, and understand what is
going on. You've already seen this with your patchset where getting it
properly reviewed by anyone else than RP is an ongoing challenge. On
the other hand, the .inc updaters are fully contained in oe-core
classes, they implement a task in well-understood 'recipe python'
dialect and thus benefit from a lot more people being able to take
care of them. They're also safer in the sense that any bugs in them
are only triggered when someone needs to update a recipe. Fetchers, on
the other hand, are fairly critical pieces of code and they must work
regardless of host environment, python versions, unforeseen corner
cases in source trees and so on.</pre>
    </blockquote>
    <p>You mixed two different points. We have to distinguish between
      bitbake fetcher and the on-the-fly resolve of SRC_URIs.<br>
    </p>
    <p>Regarding the bitbake fetcher the same reason are true for the
      language specific fetchers. The fetchers are based on the wget or
      git fetcher. They only add a preprocessing of the source uri and a
      post-processing of the download. There is no requirement to do
      this inside the fetcher.<br>
      <br>
      The on-the-fly resolve is also possible in oe-core. I think it
      isn't really practicable to manipulate the resoled source uris
      because of dependencies between dependencies and the relationship
      to other package manager configuration files. Why shouldn't we use
      the package manager specific tools to update the configuration and
      dependency specification. I understand that a patch is more
      straightforward than a new dependency specification file.</p>
    <p>The inc file is an oe specific format of a dependency
      specification / lock file without available tools to update
      entries with respect to the relationship between entries.
      Furthermore it is impossible to use the changes outside of oe for
      tests or debugging.<br>
    </p>
    <p>What is your opinion regarding gitsm. Should we remove the
      bitbake fetcher and use a update task to generate a inc file with
      the source uris and source revisions?<br>
      <br>
      Do you really review the changes of the inc file?<br>
      <br>
      I understand the points but I have the feeling that they are more
      theoretically for package manager dependencies or could be solved
      in an other way (ex. caching)<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:CANNYZj_-+uq0HmLYWAU1kEBPdkiCfyjkAu8cdSjxt6PsCB=-9A@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">- we might be able to remove those long SRC_URI lists by migrating
recipes to the integrated fetcher, but we won't be able to do this
with the licensing information (pointers+checksums to licenses,
license strings) for items that are being fetched. For that, you still
need some way to write it into a recipe with a tool. We don't do this
yet, but we really should.</pre>
    </blockquote>
    <p>The license topic is independent of the fetcher because the
      dependency specification doesn't contain license information. The
      recipetool shows that the license topic is really complicated. It
      is possible to fetch a license string from the package manager
      repository but this information is useless without a pointer to
      the license file and a checksum. The automatic determine of the
      license from a file need a very good tooling because we need to
      trust the process and it must minimize the manual correction.
      Furthermore you need a central database otherwise you have to fix
      the same problem twice because the recipes could use the same
      dependency.<br>
      <br>
      Even if we put all license information inside the inc file. Who
      should review the changes ? What tooling is used to review the
      change (license content)? If we blindly trust the inc file
      generator, the inc file is useless and we can generate the
      information on-the-fly.<br>
    </p>
    <p>I understand the motivation for the update task / inc file but I
      don't think it adds any practical benefit.<br>
    </p>
    <p>Nevertheless I will move my implementation to oe-core and add a
      task to generate an inc file as starting point.</p>
    <p><span style="white-space: pre-wrap">
</span></p>
  </body>
</html>

--------------QJbg7St96ToCHYYGG1qvK8UO--

