Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C872EC02192
	for <webhook@archiver.kernel.org>; Fri,  7 Feb 2025 08:05:50 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.91])
 by mx.groups.io with SMTP id smtpd.web10.64491.1738915544361562177
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Feb 2025 00:05:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@weidmueller.com header.s=selector2 header.b=URxJcMOT;
 spf=pass (domain: weidmueller.com, ip: 40.107.247.91, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TY4wYxJpTPGHsBFvZpkxZG+t4wTrkOxxPsV+Et8CZhIRtVbuj+UWYcpYtoy70iJdQfff3nEQz5xakxJRp9NpAFZZTB1NH0iZgJE5C8W2qyvV13/pOisTI6iiqL+oUs7VF3a8F0FynL1GHotrnc714tpgUbC0g5vPRxnTv2mCdJqXZxKyTqiypyEPiUQNhR92VIM1R4r1rMN6MzoXlBmIeBeMq3HGU7GZItwL2L75ULf4fITxWHHEatOt9MABOdAnPAUHChaYKi12nlyQ7GMC+PWyCsc1VL/ZxdNs37eNq+tsPzEKMLyi/2EwJ7U15nz0hKsanKqVI8McXWYpCzY1Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bhdo+u/B2bT2oCQuZzgPfpO1KLeA/Y1d7pCVYigzzpg=;
 b=y7m8sJPjdWQq76cm6PslaZBckeZ6Gle5fLmrxLHe4GxToat1sSaiByqAQvtybDZgRka/IptY6OQ6bgvXu6D6R8fDcKKsD4XHhvYrHGghSurSsHcE4kouBpdsZ6tCK1I6+Li/Ozqc2K0MxZ41Or2XJJ3dgjDYsBlC/kwYGmmVOZnivk0F/NyiKdbl6bzI4JbxyoqrB6AuL/iyX6cbDKg8UweeoOFsBcBGXkzWuEQi0vNpFuSjVmUj0lXWtKKS1m30gAhLeD0ZJaCiElAwxWH+xr23Zfkt5+GkoXeJ6CQCCXeUbOKLqUu4vOXsBW69bjzOtEO1ainatjds00sQeOl2IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bhdo+u/B2bT2oCQuZzgPfpO1KLeA/Y1d7pCVYigzzpg=;
 b=URxJcMOTsvEjjWS+9JcfluoXzWqD6R9mElM2WDNkRic89eOKZGi+Jecmpjyv6R13AAmcZlkQAPv77xavndsmfCu/DQwvDdr62QKl6p/3eD44jp+hQb7QD+MLXeZRFdU5MOasZ9dG7a84ReehaQU7lq2BsArncS+MtygeXUvejaLLc5hvRMQQeWQhkUqEF1pvH1REK87/JR8bm3ZtFU0aoSvHrK9KSfOrgihVpx5Evtq47TeV+za6rw4S0J4L0RkMYsXk99A+ZObzgVI+VSJeltbMOW6NTTn9ZOo5qbFj3Qh9IkvCOQAF9f6j6F9qxQebY4zLABNPM01F0Hjgk4vysg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by AS8PR08MB7369.eurprd08.prod.outlook.com (2603:10a6:20b:445::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Fri, 7 Feb
 2025 08:05:40 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8422.011; Fri, 7 Feb 2025
 08:05:40 +0000
Content-Type: multipart/alternative;
 boundary="------------a4Xi80h4j0MsEyT00WNakQAG"
Message-ID: <e839c25a-e4d5-4a93-8c82-915336367400@weidmueller.com>
Date: Fri, 7 Feb 2025 09:05:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [RFC PATCH 08/15] fetch2: use localpath instead
 of localfile
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
Cc: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
References: <20250205071538.2681-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <20250205071538.2681-9-stefan.herbrechtsmeier-oss@weidmueller.com>
 <7314b5c9248b9c1b73de6133dc34cf31bf41d43f.camel@linuxfoundation.org>
 <1821AAFAC9C0AAD1.752@lists.openembedded.org>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <1821AAFAC9C0AAD1.752@lists.openembedded.org>
X-ClientProxiedBy: FR0P281CA0263.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::6) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|AS8PR08MB7369:EE_
X-MS-Office365-Filtering-Correlation-Id: 15654654-8792-4092-c3d6-08dd474e362c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|13003099007|8096899003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WlA0YVFUQWdsS0tjRi8zSXNYanhNV3dyYjNVdWdSMzNCUmwzMGJ6eUJ2QXZV?=
 =?utf-8?B?SllCUTFUMU1US1ROWVR1RjBsc0VNV2dDNEpGWG5VWGRxeTV3RlNHTVNWNlE0?=
 =?utf-8?B?bmV2OC9KQktYZUc4VWd2b0FmcjV1WVdGcUY0TlUvRTZOa2sxbCtIWGhabE4z?=
 =?utf-8?B?SDNiVjR6UnhvazVOUEs5NU8xNFkvMnl6VjV3Qm91d0c1MUlaRWwxdGErRVJ4?=
 =?utf-8?B?SW9vSzZNSGYrNEdVcC95Kys1T1JhalBDMkk4NkV3dzlnaElwejF6U2ZzUFhy?=
 =?utf-8?B?MlhIZGNhYkdaanB5QWFrOGxjTHVhYVcrOERyOFFkMlRYdlFVMDQ1cnBrQU1i?=
 =?utf-8?B?RFV2d1NlKzQ1M3E0UTBvUkd3aFFNZjErcDR6QVdWRWhjb2tEL2NPT290dms4?=
 =?utf-8?B?RHRXZlIvTkVKSWZoZTJKUDVEeUw5aE1xVzdidjhkakp4WXJJcktqTXp6OXBj?=
 =?utf-8?B?S3pHTzF6cVQ0QmV6OVhSem0rN0NTelN0Slh3UGl3RFZpME5YQkpBdko4WnVU?=
 =?utf-8?B?N25KbS9UNVMrOVVLWWNUbGVnZmdJcTZjY0JlWmUvVjJBNWdlWFpFMGpuK0VJ?=
 =?utf-8?B?YmtjclFOUjcyZ2phKzRxczZkQnJYaWhwSkVKVGp3dk5iWDZZS2YyOEdLT1lL?=
 =?utf-8?B?Qm4yTkQyZVcxb3NqbUVBOFdMUzFROGVkRFN0TmFaWEZJMElmckRld3NlSS9t?=
 =?utf-8?B?Q0QxRjBCK2RNTDBkOHZYNWVwQm15ZzZOUy91L1p0SysvK0dpQ2xWNlJyRHRv?=
 =?utf-8?B?SWNuOG9PWklaQjdYRFByQlQ5b1F3MHFBU3FjdFBmQ0V6eFVpczNiYTJTNU9L?=
 =?utf-8?B?NmtYbEZ6WjBNRjdyb3JIRzNicXdqOWpteUZDaWFVdHQvYUhoSjhXUW5oL0tj?=
 =?utf-8?B?T1h3V2Naa3BhK2VlaFR2bnkxU0lOM1JpamhGSXVwU0hLNFRvc0NkSmtwdGMw?=
 =?utf-8?B?d0ZvVFcyTk1aZnhZdjhqbjRsbEdTbXh1RWJyMEN2TG9Qd1VRWkZiNnJmYnJO?=
 =?utf-8?B?M1dCZGNYeWZDT1haWGNZOWF5UUpoZTdmTUs5UFI3OHYwakVqTkhia2RtYTAz?=
 =?utf-8?B?UTJPdW9iS25pdi9jbFpFNVRKdWdvU0dZeklIWXUwazVtNElESCtlc3d1ajdy?=
 =?utf-8?B?WHA2aUpzS2M0bitEN0VlRDY5WmxoNHRqZlNUMENDZE4rNUNkeTA4dGJvSFJm?=
 =?utf-8?B?RFlUbTVLZldzVlRTS01MUHFpTUVnMmVHZzhSRkFtZzBsQnU1RWR3aStMSkNx?=
 =?utf-8?B?aTFrRG16S2haK1RrWUdNUGpodTBoZ2NkbDlFVzhsYXBCZ0VrRDJweis1UUJV?=
 =?utf-8?B?N3lIUHkrbmdHUW82RlN0eUZQWExoU05pc2JOdWJRQ3N2QXJudngwOTFyRFpM?=
 =?utf-8?B?NG9IeVJDVFpSUTlFVlNBdUtObkJZZEdDT3lmQnBvUFBQTlRWa2VqU21TY1d5?=
 =?utf-8?B?YnBieWV4WGo5NWgrb0F6QjAvQzFPNG1nZjVJU0ZqQWZWYVRNbFhFRG1ZUXNl?=
 =?utf-8?B?N05LMTZ1eTU2WGd3VUszWUhsRFNST09FMlVydllhM2pFUm9qRkpBT1padG5X?=
 =?utf-8?B?cVpMV3JLc2Fkd1hkbTBDb01pUEQybzFLM2JKVVd0NjBEMDVZd1I1dHo3c1dU?=
 =?utf-8?B?dThTWVh4ZEt1VERad25kejc1MENUalkrZW14WVk5TTNhVjNmSFQvVmpCWEZN?=
 =?utf-8?B?VHkyR1U4S0lXRUE2aEZEb1daaVdZSXhUeXplb3E2Q1B3cHNxd0dvYzJDdWhF?=
 =?utf-8?B?bWM1Y2p2eUFlSHBnM3Iycy94RnhZankzQjBsNGYxbmh3TXRTNkJuRTU4VmlH?=
 =?utf-8?B?T29rb3FRNlVFd0xpelUrQT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(13003099007)(8096899003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dUpkMHJVMlJBQXNUbjBBcC9JMkpmMkFpdGNxWUpPSnZnd0FqUUdjUGlOb1lv?=
 =?utf-8?B?VER0czhmZFFlUndla0J3Wk1PYVkrMm4zQk1DRzZpeW0wY3lrVWEyTEc2Uk9L?=
 =?utf-8?B?c0k2TVNlb1M2Q2drNXpCOTh1ekpmelJSTmMrK1dNaHN1ODR4bEI1WmQxWXBh?=
 =?utf-8?B?Znl0dG1ZL0ZBUGdzdzlucGpiK3N1RkdDWit6MGg0MmtOWUFNRnZYclYzRjNK?=
 =?utf-8?B?U1pQekljQktjY3VQeHdHdUZUdGFOTll6YmxaT3doSTA1aVhtb1hsNGNaOHc0?=
 =?utf-8?B?WUhlOHBXSXQzM2lISUVxTW5lL2Q0QkRkZ2NIRmdJQlJGc29sQ1FBcVhveS9H?=
 =?utf-8?B?MCtnK3htZWdjV3BBeS9qTnFKQjFHRGlQWUFzTUYvWW1qNFdSQTBqVkJ1dlZ0?=
 =?utf-8?B?MGxoR3JpWmFKUVdQbW10S25zd0FuVWxBMFlHTG1qQVVXajBTZ2lGQUc5T1NW?=
 =?utf-8?B?MjcvMVNIaUYzbld1OVVBSVArL056WTNvN3NlMWRKeDVSU0JOMVVoMjRlVEwy?=
 =?utf-8?B?dFhGaXpFWVZ3ekt2cy90WGM5VkRKKzUvNm5Da0hKRlJsM05RRHczak1tbUlj?=
 =?utf-8?B?ZWMwRmFTSXIweE5MdDIvekJZOFJNZ3RBTlNDazRhcTRGOUx0NUJ6RFdJN2hx?=
 =?utf-8?B?dFNPYkdBbVVpcDNFT00xV0hBNjdNd3o0Wnc5blhPdGpQV05Zb0F5ejQ4dUNi?=
 =?utf-8?B?ODZnbkJUcGhzTXhYSVFkK3NtTVJWMzJaTGoycUgzN0JFYytoMUJLSG5VcUts?=
 =?utf-8?B?aXYwcHpISW9pKzN5cDA3ZCtwSXBmV2VzeEY1R25NUkFqaExTV1V4T0Jpb3pj?=
 =?utf-8?B?dUxnQ2tJcTBWNEhTcTh2V1VXTG91TEtwOGdIMytzVEYzNklrZkdiZ0Jra3dF?=
 =?utf-8?B?ekpNWGEydG5tWC9pOWJnNzNXaE00TENrOEVLUnM1NzNVdlVQQU9NWG1wTFlG?=
 =?utf-8?B?bTZMOG9DS1lYdDdpR1lvQ2w5TDN0UEcvTWRqMkRqc3Y1bUFwYzdNdXVFNk14?=
 =?utf-8?B?WGkxL3JtOTB4SnZneklYRVRqWnUxdllYejRScXhBUUQ2YzJOUHZKSEkvN1pB?=
 =?utf-8?B?QnZVcEpQVE9SeUZYKytUZzA2SzFiQzlmWHN4c0ErWWc4aXN0NnBzMVd3VzFD?=
 =?utf-8?B?QzF6dHFzZGhGVmh4ZjBpQm5oYUw4Qm4yUWR4UE9QQ3BNdSs3cVozRGZqSWFU?=
 =?utf-8?B?M3JVc3lLZ1BSR0puUE5iL1NyOWgxbGNoTUc5SVF4U1FkOTVpYkZxM0hSRnZx?=
 =?utf-8?B?ZjUvQkhET1FBYUhnYkkreHAzaTFmMUxWZk9FRFp3TS9ZY3N1enFVdWF4U0hu?=
 =?utf-8?B?SkVGTlYwYXUyTTBLTUt6SWo4Q2Yrb2xUWjc2bUF4MG5oMkU5Q3U5VUxnOVVx?=
 =?utf-8?B?TStQTlFOZXlSQitlV3doaU0xeDI0cGw4cTdzVHFmUHRobTFzSWZ1UGh6YUtZ?=
 =?utf-8?B?MzRIQ0JBOGFIb0tOVFZnOURjTHh5V05oak1JOXhqTUw5SlhUYlVOaVJqMERE?=
 =?utf-8?B?N3d4THZBV3JsM2haNUE3UzhIVG1ReHMwM3lSWkZ6ME4xTkg5TFk2b2pxZTQ4?=
 =?utf-8?B?VUloRXdRdWtFWWU3cjJGMGgwM08xdk54bzZWeFo0YlhqT2hUMzVDRzlkeXVm?=
 =?utf-8?B?cTdoangxLzRRQS8rWXY1MUx0bHZHM1JqQm1EZ3hmbTBZTUgvaG9jSUF4ek5X?=
 =?utf-8?B?TFU3c0QxMWhXNG82VE8wandLT1VTS2d5ckJ6cEtVWDhJcDhWck04dnJKTXZ3?=
 =?utf-8?B?djlPcGw4RFFSbTdXa1RaWUpkNDVreWswclBZRlc4UTdLTWp6b1lkNFJUSGVF?=
 =?utf-8?B?TWM0bDZKRTloM0h5QllBdFJ4MitLNkwybDkxemJDM0J4azJkdnliVnY0OXY1?=
 =?utf-8?B?VnRyKzFlOWYrcjZyclVhU0ZJRzJOaHNWeUkyYWtKVUJBMmRCdG1oWm4wR2RX?=
 =?utf-8?B?cE9pVTNocFgvNlU1VkR2UFJ1OGNxVEpqaE5WckF2eUYyYVR0MlBOcUxrNHVN?=
 =?utf-8?B?SC9SSEpLNHNiL0xFcU9KSnEzZGxjcHAwS2Q3Qk5pUmNtUnduVERYSmgzZmNV?=
 =?utf-8?B?R1I5R1E3WFYvSjBNc2MxRSttejA0Z2JzYUNzbjAyajRyYU9CWDJWU3VCOSsw?=
 =?utf-8?B?OExtaGYvbjNlNFc0RldRM0M5RVJRNXdsVlVNSi8rSE45N2V4QVJXd1RtN0d1?=
 =?utf-8?B?VFE9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15654654-8792-4092-c3d6-08dd474e362c
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 08:05:40.0665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4oqIvuP4idao+KTwx3bTsG5uXkKz1idYWBDEmZdsxvR4cPFNYHANnpJ1ZBiMpyiqvYLHpUi9G7CNoEIZjyPhgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7369
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Feb 2025 08:05:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17163

--------------a4Xi80h4j0MsEyT00WNakQAG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Am 06.02.2025 um 17:21 schrieb Stefan Herbrechtsmeier via 
lists.openembedded.org:
> Am 06.02.2025 um 16:26 schrieb Richard Purdie:
>> On Wed, 2025-02-05 at 08:15 +0100, Stefan Herbrechtsmeier via 
>> lists.openembedded.org wrote:
>>> From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
>>>
>>> Use localpath variable instead of localfile and DL_DIR variable.
>>>
>>> Signed-off-by: Stefan Herbrechtsmeier 
>>> <stefan.herbrechtsmeier@weidmueller.com>
>>> ---
>>>
>>>   lib/bb/fetch2/az.py   | 3 +--
>>>   lib/bb/fetch2/repo.py | 2 +-
>>>   lib/bb/fetch2/sftp.py | 3 +--
>>>   lib/bb/fetch2/wget.py | 2 +-
>>>   4 files changed, 4 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/lib/bb/fetch2/az.py b/lib/bb/fetch2/az.py
>>> index 346124a8b..1f0f1337a 100644
>>> --- a/lib/bb/fetch2/az.py
>>> +++ b/lib/bb/fetch2/az.py
>>> @@ -49,8 +49,7 @@ class Az(Wget):
>>>           fetchcmd = self.basecmd + ' --retry-connrefused 
>>> --waitretry=5'
>>>             # We need to provide a localpath to avoid wget using the 
>>> SAS
>>> -        # ud.localfile either has the downloadfilename or ud.path
>>> -        localpath = os.path.join(d.getVar("DL_DIR"), ud.localfile)
>>> +        localpath = ud.localpath
>>>           bb.utils.mkdirhier(os.path.dirname(localpath))
>>>           fetchcmd += " -O %s" % shlex.quote(localpath)
>>>   diff --git a/lib/bb/fetch2/repo.py b/lib/bb/fetch2/repo.py
>>> index fa4cb8149..5c0edf1f2 100644
>>> --- a/lib/bb/fetch2/repo.py
>>> +++ b/lib/bb/fetch2/repo.py
>>> @@ -46,7 +46,7 @@ class Repo(FetchMethod):
>>>       def download(self, ud, d):
>>>           """Fetch url"""
>>>   -        if os.access(os.path.join(d.getVar("DL_DIR"), 
>>> ud.localfile), os.R_OK):
>>> +        if os.access(ud.localpath, os.R_OK):
>>>               logger.debug("%s already exists (or was stashed). 
>>> Skipping repo init / sync.", ud.localpath)
>>>               return
>>>   diff --git a/lib/bb/fetch2/sftp.py b/lib/bb/fetch2/sftp.py
>>> index 2a2a70a1b..b88dc5a28 100644
>>> --- a/lib/bb/fetch2/sftp.py
>>> +++ b/lib/bb/fetch2/sftp.py
>>> @@ -82,8 +82,7 @@ class SFTP(FetchMethod):
>>>               port = '-P %d' % urlo.port
>>>               urlo.port = None
>>>   -        dldir = d.getVar('DL_DIR')
>>> -        lpath = os.path.join(dldir, ud.localfile)
>>> +        lpath = ud.localpath
>>>             user = ''
>>>           if urlo.userinfo:
>>> diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
>>> index 161c66bea..1194f0e7a 100644
>>> --- a/lib/bb/fetch2/wget.py
>>> +++ b/lib/bb/fetch2/wget.py
>>> @@ -95,7 +95,7 @@ class Wget(FetchMethod):
>>>           fetchcmd = self.basecmd
>>>             dldir = os.path.realpath(d.getVar("DL_DIR"))
>>> -        localpath = os.path.join(dldir, ud.localfile) + ".tmp"
>>> +        localpath = ud.localpath + ".tmp"
>>>           bb.utils.mkdirhier(os.path.dirname(localpath))
>>>           fetchcmd += " -O %s" % shlex.quote(localpath)
>>>
>>
>> I put the first 8 patches of this series into a test branch and ran it
>> against the autobuilder. It fails to parse, unable to find files :(.
>
> Thanks for the test.
>
>> https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/960/steps/13/logs/stdio 
>>
>> https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/960/steps/13/logs/errors 
>>
>>
>> That suggests there is some breaking change in here unfortunately.
>
> I assume the @ in the filename is interpreter as username separator . 
> I will look into it and add a test to the selftest.

We have two solutions to decode an URI with different behavior:
class URI - urllib.parse.urlparse(uri)
def decodeurl - re.compile(...).match(uri)

Additionally the encode of an URI object and the encodeuri function have 
different behavior. The class use the unquoted and the function the 
quoted path. Is this behavior intended or could we use one implementation?

--------------a4Xi80h4j0MsEyT00WNakQAG
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">Am 06.02.2025 um 17:21 schrieb Stefan
      Herbrechtsmeier via lists.openembedded.org:<br>
    </div>
    <blockquote type="cite" cite="mid:1821AAFAC9C0AAD1.752@lists.openembedded.org">Am
      06.02.2025 um 16:26 schrieb Richard Purdie:
      <br>
      <blockquote type="cite">On Wed, 2025-02-05 at 08:15 +0100, Stefan
        Herbrechtsmeier via lists.openembedded.org wrote:
        <br>
        <blockquote type="cite">From: Stefan Herbrechtsmeier
          <a class="moz-txt-link-rfc2396E" href="mailto:stefan.herbrechtsmeier@weidmueller.com">&lt;stefan.herbrechtsmeier@weidmueller.com&gt;</a>
          <br>
          <br>
          Use localpath variable instead of localfile and DL_DIR
          variable.
          <br>
          <br>
          Signed-off-by: Stefan Herbrechtsmeier
          <a class="moz-txt-link-rfc2396E" href="mailto:stefan.herbrechtsmeier@weidmueller.com">&lt;stefan.herbrechtsmeier@weidmueller.com&gt;</a>
          <br>
          ---
          <br>
          <br>
          &nbsp;&nbsp;lib/bb/fetch2/az.py&nbsp;&nbsp; | 3 +--
          <br>
          &nbsp;&nbsp;lib/bb/fetch2/repo.py | 2 +-
          <br>
          &nbsp;&nbsp;lib/bb/fetch2/sftp.py&nbsp;| 3 +--
          <br>
          &nbsp;&nbsp;lib/bb/fetch2/wget.py | 2 +-
          <br>
          &nbsp;&nbsp;4 files changed, 4 insertions(+), 6 deletions(-)
          <br>
          <br>
          diff --git a/lib/bb/fetch2/az.py b/lib/bb/fetch2/az.py
          <br>
          index 346124a8b..1f0f1337a 100644
          <br>
          --- a/lib/bb/fetch2/az.py
          <br>
          +++ b/lib/bb/fetch2/az.py
          <br>
          @@ -49,8 +49,7 @@ class Az(Wget):
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fetchcmd = self.basecmd + ' --retry-connrefused
          --waitretry=5'
          <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # We need to provide a localpath to avoid wget
          using the SAS
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # ud.localfile either has the downloadfilename or
          ud.path
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; localpath = os.path.join(d.getVar(&quot;DL_DIR&quot;),
          ud.localfile)
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; localpath = ud.localpath
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bb.utils.mkdirhier(os.path.dirname(localpath))
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fetchcmd += &quot; -O %s&quot; % shlex.quote(localpath)
          <br>
          &nbsp; diff --git a/lib/bb/fetch2/repo.py b/lib/bb/fetch2/repo.py
          <br>
          index fa4cb8149..5c0edf1f2 100644
          <br>
          --- a/lib/bb/fetch2/repo.py
          <br>
          +++ b/lib/bb/fetch2/repo.py
          <br>
          @@ -46,7 +46,7 @@ class Repo(FetchMethod):
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; def download(self, ud, d):
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;&quot;&quot;Fetch url&quot;&quot;&quot;
          <br>
          &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if os.access(os.path.join(d.getVar(&quot;DL_DIR&quot;),
          ud.localfile), os.R_OK):
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if os.access(ud.localpath, os.R_OK):
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; logger.debug(&quot;%s already exists (or was
          stashed). Skipping repo init / sync.&quot;, ud.localpath)
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return
          <br>
          &nbsp; diff --git a/lib/bb/fetch2/sftp.py&nbsp;b/lib/bb/fetch2/sftp.py
          <br>
          index 2a2a70a1b..b88dc5a28 100644
          <br>
          --- a/lib/bb/fetch2/sftp.py
          <br>
          +++ b/lib/bb/fetch2/sftp.py
          <br>
          @@ -82,8 +82,7 @@ class SFTP(FetchMethod):
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; port = '-P %d' % urlo.port
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; urlo.port = None
          <br>
          &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dldir = d.getVar('DL_DIR')
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lpath = os.path.join(dldir, ud.localfile)
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lpath = ud.localpath
          <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user = ''
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if urlo.userinfo:
          <br>
          diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
          <br>
          index 161c66bea..1194f0e7a 100644
          <br>
          --- a/lib/bb/fetch2/wget.py
          <br>
          +++ b/lib/bb/fetch2/wget.py
          <br>
          @@ -95,7 +95,7 @@ class Wget(FetchMethod):
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fetchcmd = self.basecmd
          <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dldir = os.path.realpath(d.getVar(&quot;DL_DIR&quot;))
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; localpath = os.path.join(dldir, ud.localfile) +
          &quot;.tmp&quot;
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; localpath = ud.localpath + &quot;.tmp&quot;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bb.utils.mkdirhier(os.path.dirname(localpath))
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fetchcmd += &quot; -O %s&quot; % shlex.quote(localpath)
          <br>
          &nbsp; <br>
        </blockquote>
        <br>
        I put the first 8 patches of this series into a test branch and
        ran it
        <br>
        against the autobuilder. It fails to parse, unable to find files
        :(.
        <br>
      </blockquote>
      <br>
      Thanks for the test.
      <br>
      <br>
      <blockquote type="cite"><a class="moz-txt-link-freetext" href="https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/960/steps/13/logs/stdio">https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/960/steps/13/logs/stdio</a>
        <br>
<a class="moz-txt-link-freetext" href="https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/960/steps/13/logs/errors">https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/960/steps/13/logs/errors</a>
        <br>
        <br>
        That suggests there is some breaking change in here
        unfortunately.
        <br>
      </blockquote>
      <br>
      I assume the @ in the filename is interpreter as username
      separator . I will look into it and add a test to the selftest.</blockquote>
    <p>We have two solutions to decode an URI with different behavior:<br>
      class URI - urllib.parse.urlparse(uri)<br>
      def decodeurl - re.compile(...).match(uri)<br>
      <br>
      Additionally the encode of an URI object and the encodeuri
      function have different behavior. The class use the unquoted and
      the function the quoted path. Is this behavior intended or could
      we use one implementation?<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:1821AAFAC9C0AAD1.752@lists.openembedded.org">
      <span style="white-space: pre-wrap">
</span></blockquote>
  </body>
</html>

--------------a4Xi80h4j0MsEyT00WNakQAG--

