Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DA5C0219E
	for <webhook@archiver.kernel.org>; Wed, 12 Feb 2025 08:41:55 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.120])
 by mx.groups.io with SMTP id smtpd.web11.10552.1739349705817126536
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Feb 2025 00:41:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@weidmueller.com header.s=selector2 header.b=YhNztrKD;
 spf=pass (domain: weidmueller.com, ip: 40.107.22.120, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bYCCVJVR7pjS46GuRWtYLki4jEqFONcX+lwkyMI34LBwJVUdJm7UiCdpqkQclEooVxhD7BaA0mzXk/PblEyCt6t9t7XiQJlqTZ+vPwXcds3HkpJv6Cg+/FD8VvUyBSaYdh1F3T8DYAFsSvcCh7Z+Cx+vBTE35au+0BfNekCP/6VM1oVs0CDNvF+Z1pSoWhm8m4IsH8HZ6vCUfN5w3sl66FJ8PsrT1LXS7yJFwbs+lNX+U5fTseGvTQ6uAdQ1fBwcjZwkOxX7hHbQb6bJ5jpvB8JIghkDlZgYcNvDfzUTTIt4CSMyOWZezD0egMGndBdZbNOZSSHl8UZebWndMwiu6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gaS24//2W8j3l68CVV+510bOedS6CQDT7z+ydJbe9Ec=;
 b=IOrSOK61ev+V2TnjeJ4AnNT8oCvhrnwkBrkLd9RzCpJ0703W9S9hyIP2Owyqo5Sb8WG1bb3jp4J3vRrD7nNilcCWatXQGTYgPPF8ffTPZbsIW+Oo2aDUKdK6fOXctNAuz7gK4JYVQCvFOHTPfd+C4nnuVDMzBTBoDTymRWzuyLJ8I6x/QmWkN6T644kHolEvTqVPs9I4Iy3xUHZesyTPhOMCUfB+eUFM36YmmweMEDKYutGOoPaSe9uj9C6Jul0RkPm2UNMF8L+58451meT4WmANS1gvtejKMFt/f0qANQ4BlBok5RGqoVb+KIv9tZNVQjYHnN0iYVrrYDCFHneHxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gaS24//2W8j3l68CVV+510bOedS6CQDT7z+ydJbe9Ec=;
 b=YhNztrKDNU2+b+8UgQNN+GHoxHKJV8PeUEawFqUPPrMt2mLh9MTiKvPz8hL7Y40abK07zaZ0uNsXZqcYWqCSQ3hpKWT3u2S4SKzrEJslDnq5i8HtSH1g/6sAOr0MW0UrwMDe8FAbfc6lcYDvigqqimK7+TCNNJHCpPAx1zsCXR0ruI0dGWBUJEhC/IeNbSU3y8lrQgBJEzDYPst+7dPBlRcbX0saGmmi+hOeGL/wkREhu9//VM+CZNfUDoSgI8HxZ1/R026YAj+s4t5CXnK4mjAgpSOhoyNCFWuzG2LMx5vwuuGjP6qutQMFQtfm2XCDLR3MsplBsbdn0i+YhdfwUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by AS8PR08MB8996.eurprd08.prod.outlook.com (2603:10a6:20b:5b1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 08:41:40 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 08:41:39 +0000
Content-Type: multipart/alternative;
 boundary="------------EK08eaO6la56BKlqqFA1jRKm"
Message-ID: <40f8d1d9-5bd3-4ac6-a107-32482d06d17b@weidmueller.com>
Date: Wed, 12 Feb 2025 09:41:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [RFC PATCH 00/30] Add vendor support for go, npm
 and rust
To: bruce.ashfield@gmail.com
Cc: openembedded-core@lists.openembedded.org,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 bitbake-devel@lists.openembedded.org
References: <20250211150034.18696-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <Z6vZ8m8zZLgQKyVg@gmail.com>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <Z6vZ8m8zZLgQKyVg@gmail.com>
X-ClientProxiedBy: FR0P281CA0121.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::19) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|AS8PR08MB8996:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f34186a-f117-4456-bddf-08dd4b411194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WTN3K3ZvTjNrYlRudTJpWk5HNHNhaytRUFRrcjV5dHkyVUZLMDlPOCttaTh5?=
 =?utf-8?B?TnJCUU9sRjkreDhzc3F4dFd6d2NsZFBFenRvTTdwTklIVXljcHB4bDJlRmdK?=
 =?utf-8?B?MXZoRTJrNWo5a0xDQkVNem9Xa0RnYWdVaUQ5ckhUREJOaHc3Q0NONGwrdUtn?=
 =?utf-8?B?UE5sU2g4ajZ2dWVDMjRUOS9PcWxPRDJVK05kWWM4NExIVk9teEx5WFI5Rms4?=
 =?utf-8?B?WjNsbVh0RW1BQWM3RUdoSmpDbnpRcFV1TStwclpMelU1SmhmNCtZSFlBZ1d2?=
 =?utf-8?B?cHJiUzFha2ZpWnlKaGIzZ0hwSmN6TVlDVk0vS1BkQzZWdHBHeXZJUldMamF0?=
 =?utf-8?B?UzVDdFlGT0RuZC8rR0lVaFRmMGtxeWo5OHVXM0JQZWZsUWtIR1lHeEhudW1U?=
 =?utf-8?B?NjZMbytrR2dITCt0R1NpYVZTbVM2czlETEJFV1paZHE4VXVzdURXM3pacGhh?=
 =?utf-8?B?UFR5WEphU05jTTI5MUZRdGNzNndEYVZySTVGQThFNVEwS1dsV1pGc1Q1aUxG?=
 =?utf-8?B?S1hSKzF3Wk8rbU1sK3ZiYzg3ckp5TDd4d0lpbTVyMHNieWVpckcxTGV4Ujk0?=
 =?utf-8?B?R1QycVVWUDFsa3c0RUhkTllFeUNGcGx3d2NPZWQ2alAvMkRwZXBGK2Vrcm5p?=
 =?utf-8?B?bEpYWWgxS1dqMG44N05KOVUzZUs3ZCtjRWhlMklRSjdYb2l2OVZwQmVPaFpa?=
 =?utf-8?B?L0ZublBDR3FQTXdNNTU2VDZ6bEZNNUZieFRnaFJ3WGtQbTlrcEpRcjRMSjB3?=
 =?utf-8?B?OVBzRmMyK1paVzBLOHJSL0RmMEUxVVZ6MlpXbDFNeHJTK3B0bWZRQ2dIbnpZ?=
 =?utf-8?B?dkRKQUdjSDRyU21ITVl4MjNyb3kyMzJMbng0V0FHL0lIMmhVVXphQUdsOUtM?=
 =?utf-8?B?Z2E0NDRLV2wvZWJKZVIyUmVnZUJaeEVMVTd5dVFaOXJpeXMrMlBFcVlxbk12?=
 =?utf-8?B?M1V3ZzlpQ2YvK01tZG9CbTUyZ1ZyVmdTZkp0djErb3dTc2xTYyszVkZHeFZZ?=
 =?utf-8?B?NVpOcklTeHUram9nY2JkbmVvZm42d1ZtbmgyY0JvRXJFeEtQaDVpdHM5dzNQ?=
 =?utf-8?B?aGdyMXdnZnVPL1gvSm5NNE5LcnkxUHNWQmNMQWFkTjJlbC83Y295UlZYYmdV?=
 =?utf-8?B?VmQ1cVozak5QTkx4eU9naDY2UmxWVXAweFh5Y3YxblpjTmg3ZExCRGlIM1Er?=
 =?utf-8?B?WjhnMksyZnZLOWNPakJPb1UyKzdWYTBCM0s3RUpEVHN1NENxV3ZUQzIrMzlD?=
 =?utf-8?B?eHFIN2JoaXFCRHJuV044ZVpMc3ZROW9zK25udGdvTTBPN3JhaStTeGsxS2Vm?=
 =?utf-8?B?L291ZDViNzhaU3hMTitsa3pHcU00TTVlb201NGJydEZWL0ZIeW5sZ2cvUG9K?=
 =?utf-8?B?NWhhT3Vkc29lSnhnSEJSWmZVR3VHNURQN0pNZHFGUG9qelVNcEQzRHJ5WTJz?=
 =?utf-8?B?dlJQUXlzZURnbG9tUVRCS1E2YWVQc1ByeldMbGpBeWM5czBRNDE5RDc1dk1F?=
 =?utf-8?B?cnVjNCs3dHF5Ky9ybThjMWkzYkJJYWxkNXJ4blg0UmM0RDBBemJXd0ErWG9X?=
 =?utf-8?B?K21WdThtenJZT0ZTOWpMaXNnNERWZU4rUS8vSnR2d3JRZjh5RURJVWI2WUYv?=
 =?utf-8?B?NXVrTUxVd0duUFRFZm5TRTNFRXhNa0hzb01LNEJMTUZXT0ZXSDMwdnFCK3p4?=
 =?utf-8?B?clZGbnV2ZS9uMXZRRU51RkJPMXFYREw2MXBZR09iNjFCUVJhOEVCTG94ckkz?=
 =?utf-8?B?bVpZZWl4MjZzYmpOdEJsWWlKeW50MmRsZnZQaFkvVzZhYWJIUVJ4VjRteCs1?=
 =?utf-8?B?MzFqMy9WZjJCS2kvN2c0ZWl5R2p5bTFmSjhNSkRIWGZtMUZ2TXZPNjFXSDhN?=
 =?utf-8?Q?vyAW/5E4g65Ru?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(8096899003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RFBOQUYxVWl2MUFtZ1hGc2lxRmJ4eldQZ1E1Nlh1YTZaYkNEcjBGNHFLNitN?=
 =?utf-8?B?ZWxGWmJxaFZBZ0h4R29oYklzeFNBTnc3WmtUSElXZkNqREhoMGxwV3phd29n?=
 =?utf-8?B?ZER4aHVVYVJZMlBiZWpiTDcvcHlwZXUxelg1YTBaVWhkR0Z2Q21JdFhjTGxE?=
 =?utf-8?B?MHF5RFJ6WEh6dm1mbUtNQ3lCTzFHbGg3SCtrQkZWREZoTktTOUhGaGwyV1NK?=
 =?utf-8?B?MFpaV09XNU51T2NxVU52SnhuUUdEeTFnS3RaSkVnandNNlBqUTNtTDlQM2ZC?=
 =?utf-8?B?UjZWMmtndCtuaW5UQy9vcUZnMVB3SjZPUXZ4T2NQa3pmZDBxbmk0NlRrU29R?=
 =?utf-8?B?QmF2cnBua3NDUFRHTndFdEF6cXd1U1Z4VWxlYXVkSnVRNldqNndNVnRVRys3?=
 =?utf-8?B?YUVPUDh1UlU0QnBMbit5MnA4R0wya3F4eVRtUGtPTnUvNDQ0cVJSQzZUQytP?=
 =?utf-8?B?NGo5RUphQld1T0RDbGx0VitsaGlvdzNpM0c1ckxtY0xUelJhRVFzRG5pMUdy?=
 =?utf-8?B?ck1FcHVGcDQ1enFBTnZtUFFTTnU3ZDBweGZqektWZERTREd2ZW9wVUZaNlM2?=
 =?utf-8?B?WHV5bEhwV3FMR3RhekFMYjdYb0lHeHpvVjJHM1hDN2EyaTNSSXJGWWQwZXdE?=
 =?utf-8?B?MFdkN01mQVZkMnhyU1lyaGNtUC9BTTlCb1h4V3R0VXBJa2ZRQWtPcmcrZUti?=
 =?utf-8?B?aGxZWVpMQzNocWcrS3NuWjVhR0pPR29LbWYzclJhdUFyOStNeFlXeGhQc29P?=
 =?utf-8?B?Mm12ZXBmZ2haVHdaZDFyZmhYVFVyQWlqbzI4Uk56SW1BZHErMzBpajZMYWF4?=
 =?utf-8?B?b2ZYNTJpY1ZXVkJOTGV2L2ZYWGQydHVCNHVKajQvRXMva216bUFPYnd1Vm85?=
 =?utf-8?B?bEJiSzRVNEVNbEVsanFia0pVVFZ2aWdubXpudDYrOXFlcHRoZWFiZ2lwV0ow?=
 =?utf-8?B?Q0pZRDU4eEswTE1xTFh5cWhBUWhoMTJBVGRmakhYbncrYXpYZk1ESmdYMHB3?=
 =?utf-8?B?cnJyYmZsUEE5TEJMSW5MMTVOVEVxYTRtTWR4ejd3ZUwwbUR0UVhBd00xN2lh?=
 =?utf-8?B?VHJkQTZpcHh5dXh1NVFuTm8vM1NoODNuL1JvRkJ5VlBqT2QvVGdndXQ4ZzdT?=
 =?utf-8?B?T1VaTUNIOFZiYVNlZUZMNWdjOFBXZmdRSTNHQS9ZS2FsTnlIbXRZclY0UnFm?=
 =?utf-8?B?OHJ4d1Radm5zcGovR1I0allTWTZVTzZFOE9NVGo5QVorVWNnYWFkandnc3pP?=
 =?utf-8?B?UXlvWEp1VkpJdCtzei85Rk5IMTN3Y2NhVWovUmJKVU5WLzFaUjFYei82RU5M?=
 =?utf-8?B?V082ZWFKcU5jYmllSHpTbW94R1lEekVLb25POGFJWnZieVRtOGF3c1ZRT2Vv?=
 =?utf-8?B?bGJOYjZWM1FaUytWN05RSmNlN0ZMd0VjVkFXbjBtK3N2OTVkQ1ZDcWk5SFdO?=
 =?utf-8?B?L0tiNmhabENrYjlqQzhzSkp4M0hrUHM0NHVrVHhDUTdmRWFnSmFTZThlVXNC?=
 =?utf-8?B?Q3dLNFdLK0U0MEZRYnlVdmpNckQyNHBPcTJGWTBDZTQrM0xxdlRvd0YrNm1E?=
 =?utf-8?B?cmZtaXRGYVBGU2E2cG4xOVRWR3BKZjM3cndPaVBtVWlkV1M4dkVtUlY4aVZZ?=
 =?utf-8?B?ZWhYcEloTldPVmh3UHRoelY2d2xyUEF1T3FGWmFodmZlOVpINUF5ZlVjSWRp?=
 =?utf-8?B?ZXhuSGFIRWZuQTNCeXQ2cHVja1kyV0JPaXJPZUhJeVR3MTVaZWNpSFhDRER3?=
 =?utf-8?B?bW9rR01WS1kyTkhkNzBtaWxrNUZ0QVNsNndFZHMwQ2Z5U1czdTAxMDBnclhr?=
 =?utf-8?B?cThwNzl5YmhOaXhiVDVkODg3TTF4MTRFN0hpNEt6V3VaTG1TV3J2ekYyWFVE?=
 =?utf-8?B?WFJ6eGJOVjlTQSswR1VMMUlraktLN1RZZy9kUTI0cm5vbzNRV3pKUVk4d1Ew?=
 =?utf-8?B?K3JpZTcrVTcrYkhrTjdrbjIxbVFvaGNkNGVKc0Q3a0tBV0FsWldhVU5NK0VL?=
 =?utf-8?B?b0l6ZkZRY25VMm4zMVZIL0FIbld0RUQrd0V1OThtN3MxUFVPYUUvWHprME1I?=
 =?utf-8?B?ejBoRVREK3FDYWQzcFN3VnVqZFgvSk5uZEI1eDdLY1RoTHRnOFRCRGQ0dlB1?=
 =?utf-8?B?QjB4VTA5bFJxQlRrTm51QndDWmxYK051K0M2a3RVWG84Q2VuTXc5ZFFBRzVH?=
 =?utf-8?B?NlE9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f34186a-f117-4456-bddf-08dd4b411194
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 08:41:39.8048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YstgulmG+e9TVsV88NyPicwVG5X4e2woajpKBbj6O71Zh97l0N2wYD/pQikr8M02YAAuuRMlJdr7pIvownuAMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8996
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Feb 2025 08:41:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17198

--------------EK08eaO6la56BKlqqFA1jRKm
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 12.02.2025 um 00:14 schrieb Bruce Ashfield via lists.openembedded.org:
> In message: [bitbake-devel] [RFC PATCH 00/30] Add vendor support for go, npm and rust
> on 11/02/2025 Stefan Herbrechtsmeier via lists.openembedded.org wrote:
>
>> From: Stefan Herbrechtsmeier<stefan.herbrechtsmeier@weidmueller.com>
>>
>> The series adds on-the-fly support for package manager specific
>> dependencies and vendor directories. It contains the following changes:
>> 1. Adds an early fetch, unpack and patch task to unpack and patch source
>>     code with an embedded lock file for dependencies.
>> 2. Parse the go.sum, Cargo.lock and package-lock.json lock files and
>>     resolve the dependencies to SRC_URIs.
>> 3. Save the SRC_URIs in a file and adapt all SRC_URIs users to handle
>>     the SRC_URI files beside the SRC_URIs in the recipe.
> I made a few comments, and will have another / better look at the
> series tomorrow. There's a lot here, and it is hard to wrap my head
> around everything that is changing.
>
> I have one specific question below (from the point of view of go).
>
> I've been looking through the series, and can't pick out where #3 is
> done.

The files are created in the package manager specific vendor classes (17 
- 19) in the do_vendor_resolve task. The parsing is implemented in the 
package manager specific modules in the vendor package (6-8).

>   I see patch 14 using SRC_URI_FILES, but where are those files
> written ? Is that in patch 18 (vendor_go_do_vendor_resolve ?)  What is
> written to those files ?

The file is written into the vendor directory below WORKDIR. The 
approach is similar to other classes which need to share data between tasks.

The files contain individual SRC_URIs per line.

> The concept that I'm not understanding (and that's just me not being
> familiar with things, I'll continue reading the series) is that when
> we suggested we'd like to have a mode where the dependencies could
> clearly be listed in the SRC_URI, at least I was just thinking about a
> way run the fetch/module elements that you were adding, write them to
> a file and then have the recipe include it.

The additional SRC_URIs are dynamically added to the recipe without the 
indirection over an include file. The generated SRC_URIs could be 
inspected via the SRC_URI_FILES and manipulated via patches for the lock 
files or an separated lock file.

> I can't tell if in the series those files are written each time, and
> that there would be no way to edit those SRC_URI_FILES .. but I'll
> look again tomorrow.

The files are written if the do_vendor_resolve task need to be rerun. It 
isn't possible to edit the generated SRC_URIs. Instead the lock file 
could be patched.

> That file would manipulate the standard SRC_URI. In other words still
> support a mode that is like the .inc files with crate://. So someone
> could either have the lockfile parsed and fetched, or have a way to
> run the parsing and fetching via a task, write a file and include the
> file in their recipe to short circuit the processing of the lockfile.
> (meaning the expanded and end fetches that are done once you've
> processed the file are simply listed as a series of fetches that are
> carried out without extra processing .. and "unrolled" dependency
> file pointing at the "sources" git, crate, mod, whatever)

What is the motivation "to short circuit the processing of the 
lockfile"? Like any task the processing and its output are cached via 
the sstate cache.

It is possible to use the vendor package to create a include file but we 
should have good reasons to support two solutions for the same problem.

> If that just doesn't make sense, then if there was a way to copy
> the lockfile out of the recipe and have it overlayed onto the fetched
> one .. maybe breaking out the individual fetch lines isn't required,
> since they could be individually manipulated in that lockfile.

I haven't test it but this should be possible. You can place a lock file 
beside the recipe, add it to the SRC_URI and change the XXX_LOCK_PATH.
Regards Stefan

--------------EK08eaO6la56BKlqqFA1jRKm
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Am 12.02.2025 um 00:14 schrieb Bruce
      Ashfield via lists.openembedded.org:<br>
    </div>
    <blockquote type="cite" cite="mid:Z6vZ8m8zZLgQKyVg@gmail.com">
      <pre wrap="" class="moz-quote-pre">In message: [bitbake-devel] [RFC PATCH 00/30] Add vendor support for go, npm and rust
on 11/02/2025 Stefan Herbrechtsmeier via lists.openembedded.org wrote:

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">From: Stefan Herbrechtsmeier <a class="moz-txt-link-rfc2396E" href="mailto:stefan.herbrechtsmeier@weidmueller.com">&lt;stefan.herbrechtsmeier@weidmueller.com&gt;</a>

The series adds on-the-fly support for package manager specific
dependencies and vendor directories. It contains the following changes:
1. Adds an early fetch, unpack and patch task to unpack and patch source
   code with an embedded lock file for dependencies.
2. Parse the go.sum, Cargo.lock and package-lock.json lock files and
   resolve the dependencies to SRC_URIs.
3. Save the SRC_URIs in a file and adapt all SRC_URIs users to handle
   the SRC_URI files beside the SRC_URIs in the recipe.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I made a few comments, and will have another / better look at the
series tomorrow. There's a lot here, and it is hard to wrap my head
around everything that is changing.

I have one specific question below (from the point of view of go).

I've been looking through the series, and can't pick out where #3 is
done.</pre>
    </blockquote>
    <p>The files are created in the package manager specific vendor
      classes (17 - 19) in the do_vendor_resolve task. The parsing is
      implemented in the package manager specific modules in the vendor
      package (6-8).<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:Z6vZ8m8zZLgQKyVg@gmail.com">
      <pre wrap="" class="moz-quote-pre"> I see patch 14 using SRC_URI_FILES, but where are those files
written ? Is that in patch 18 (vendor_go_do_vendor_resolve ?)  What is
written to those files ?</pre>
    </blockquote>
    <p>The file is written into the vendor directory below WORKDIR. The
      approach is similar to other classes which need to share data
      between tasks.<br>
      <br>
      The files contain individual SRC_URIs per line.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:Z6vZ8m8zZLgQKyVg@gmail.com">
      <pre wrap="" class="moz-quote-pre">The concept that I'm not understanding (and that's just me not being
familiar with things, I'll continue reading the series) is that when
we suggested we'd like to have a mode where the dependencies could
clearly be listed in the SRC_URI, at least I was just thinking about a
way run the fetch/module elements that you were adding, write them to
a file and then have the recipe include it.</pre>
    </blockquote>
    <p>The additional SRC_URIs are dynamically added to the recipe
      without the indirection over an include file. The generated
      SRC_URIs could be inspected via the SRC_URI_FILES and manipulated
      via patches for the lock files or an separated lock file.<br>
      <br>
      <span style="white-space: pre-wrap">
</span></p>
    <blockquote type="cite" cite="mid:Z6vZ8m8zZLgQKyVg@gmail.com">
      <pre wrap="" class="moz-quote-pre">I can't tell if in the series those files are written each time, and
that there would be no way to edit those SRC_URI_FILES .. but I'll
look again tomorrow.</pre>
    </blockquote>
    <p>The files are written if the do_vendor_resolve task need to be
      rerun. It isn't possible to edit the generated SRC_URIs. Instead
      the lock file could be patched.<br>
      <span style="white-space: pre-wrap">

</span></p>
    <blockquote type="cite" cite="mid:Z6vZ8m8zZLgQKyVg@gmail.com">
      <pre wrap="" class="moz-quote-pre">That file would manipulate the standard SRC_URI. In other words still
support a mode that is like the .inc files with crate://. So someone
could either have the lockfile parsed and fetched, or have a way to
run the parsing and fetching via a task, write a file and include the
file in their recipe to short circuit the processing of the lockfile.
(meaning the expanded and end fetches that are done once you've
processed the file are simply listed as a series of fetches that are
carried out without extra processing .. and &quot;unrolled&quot; dependency
file pointing at the &quot;sources&quot; git, crate, mod, whatever)
</pre>
    </blockquote>
    <p>What is the motivation &quot;to short circuit the processing of the
      lockfile&quot;? Like any task the processing and its output are cached
      via the sstate cache.<br>
      <br>
      It is possible to use the vendor package to create a include file
      but we should have good reasons to support two solutions for the
      same problem.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:Z6vZ8m8zZLgQKyVg@gmail.com">
      <pre wrap="" class="moz-quote-pre">If that just doesn't make sense, then if there was a way to copy
the lockfile out of the recipe and have it overlayed onto the fetched
one .. maybe breaking out the individual fetch lines isn't required,
since they could be individually manipulated in that lockfile.</pre>
    </blockquote>
    <p>I haven't test it but this should be possible. You can place a
      lock file beside the recipe, add it to the SRC_URI and change the
      XXX_LOCK_PATH.<br>
      <span style="white-space: pre-wrap">
Regards
  Stefan


</span></p>
  </body>
</html>

--------------EK08eaO6la56BKlqqFA1jRKm--

