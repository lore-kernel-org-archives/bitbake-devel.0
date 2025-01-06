Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE14E77199
	for <webhook@archiver.kernel.org>; Mon,  6 Jan 2025 14:35:52 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.110])
 by mx.groups.io with SMTP id smtpd.web10.60761.1736174150516569062
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 06 Jan 2025 06:35:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@weidmueller.com header.s=selector2 header.b=DD2JIyZO;
 spf=pass (domain: weidmueller.com, ip: 40.107.21.110, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mlBxsERQ1v4UGOA213fpdwfzuuBJuqKgGUgpEse3j6ymXa85nSDdLFxN7iDRzD99Ll9ydOM6F38u3f+D258vGaLuTjz/Mex3Y5y+JI3jSGAXE+9OL0MkKX/5Weh9885DiSmt0dAFKT6P6PrBDL12Sw7on/eHzqN8B7D+oTBz13LOA2sDWrAmUpPZzQmanRmDcDaBpd0n5meriipsYEai7gXwtgYn2/KR/TH/jDmyTgAtaOy8BcFYGmvL+wlZAykumesEfOJefH+FPBPMiu65L+1mbzOc1pLCotvRh1xDBpQauqLdshA08qUHmU/w99eUs3sX00MM+cfWgDbpJW01jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TgY40OE2wY/L3gO/vdRWlM01p6fmVifBOUKTPzp8lg=;
 b=UgO1kz/UBeVG0ohkZSVQtiwnF1RIMb6ts45tRc6N1EJfB2BAuuukjEKFQU8hPl/1rjOC7tdAmQPE+h1R1mzC55H3aJIUw8HHuJGGhU0XXvIBMw3+pmhw8Rz0v4iEGD1ivIUhEmAL/49P8KS8iygwsf3p0Ku+VAKpltJ5SYsG6QC5DyCxmiGRT7adU4tjAz8w+hjYLGGbITZGGLAYURtH0ZtHTv52/8XuItWSG5cF9MbkXJPtvxTVDOvVefcdEnTBIlSOywukebvxhXa9O7DSGZf2xJ5J7gZ+DxxjTdXCcaLPD51zAO61oRE650yHLd4+LFV8tTVvhbiTXa1UQT3/MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TgY40OE2wY/L3gO/vdRWlM01p6fmVifBOUKTPzp8lg=;
 b=DD2JIyZO+uUhowloNnOAhD38nZEWHndIL6zAPzfvKVgDXXVpiL7nxUugs4BLMpu3gwKSpokXnauv57sgu26nZK28+w2+cFdB1KWsSIMjFvhPG7x8/7cXaT+tWBEkuY68aWWvWRqY6y9pr3reAEbbRN8VxSH7FEVL8WKYCLBkq59iYvgQ8nkpwIv8FyPJ6GduP1lN7QRyncX4phbiW3EfD41Zmu6cYIyghE4nYwyZ8v3FmGK5OUTQ0Xo8nBeWdh37PHEzEweyMuwvw0hyIaJrKTU7WyBMKQYk2Mah0gJXvFYeP11s9qfH2VMBSk84N8ZgjeUkuuUE478dHi7ns1jpDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by AS2PR08MB8717.eurprd08.prod.outlook.com (2603:10a6:20b:55d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 14:35:42 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 14:35:42 +0000
Content-Type: multipart/alternative;
 boundary="------------FhXmQV5p3uH9tDukK8P0kpvv"
Message-ID: <578ed107-1a04-48db-ac2e-1dc9cdab60d0@weidmueller.com>
Date: Mon, 6 Jan 2025 15:35:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [RFC PATCH 00/21] Concept for tightly coupled
 package manager (Node.js, Go, Rust)
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
Cc: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
References: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <00e379e761414e8cf07b83544d5202211bf4623c.camel@linuxfoundation.org>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <00e379e761414e8cf07b83544d5202211bf4623c.camel@linuxfoundation.org>
X-ClientProxiedBy: FR0P281CA0140.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::6) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|AS2PR08MB8717:EE_
X-MS-Office365-Filtering-Correlation-Id: 14706c2d-c232-47da-d0a9-08dd2e5f65ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?S3NMNXFHZ2hjTGdMbmRaTWhsMkZuWWlKQXkwZkZncTcxM01HVTNTVUVVeXpG?=
 =?utf-8?B?L1d0aklld0RHa2Y3YUZ2SW0vaWUwWndMM3ZpMlVNOUhUOXZKZXdQelZPS3pD?=
 =?utf-8?B?dTBBRmI0bFRKSEZSV01vQ3VqUndCNUVvTzlyampMVEhlUkJ0TnM5SWZoeU50?=
 =?utf-8?B?aEFkYnlrNUMzbjRha2d2OEtnZTBSR3hwU1BzU2tnVnBlcjB3KzUxWi9MbGkz?=
 =?utf-8?B?cWdtNkc0RUhRRVFYYTZacm5qQUVxZVBvUjVYNmp6VFVFTkllUFpTMk50S2h1?=
 =?utf-8?B?UmN2cWplT1VLazBGVmNVVG55bmNLaXdmTklYV2ZrRVNtMjIxUENLQ0pYSFJz?=
 =?utf-8?B?NG55a2pSQVA5VGE0aVp0TmphODVJMHh4RjlrelptQVZMVDgxeFR1Ym9pR1lx?=
 =?utf-8?B?S0hJWmU0UnNUTTZiV2JsWk9BdmJpcUhPS3lVVkx4SnJNdjhtU2Y5djJIQ3hY?=
 =?utf-8?B?Tit4K1ZqZUZ2TUF4ZlVIR3lQaythNzZmUU5BTmc5Si9uRHR6T0lqL1RjOTdx?=
 =?utf-8?B?Y1NqQzFBeXZzeUdaNmdwa2hEckw3WmZSR2N2UWJFUkk4OFRHQXEzM2lLMWh2?=
 =?utf-8?B?UkVJWjVaNU9JdDdNNWtBTGlDQ1dUcDNXV2Zkd1FVUzJYeno5N3c0SGUzVStO?=
 =?utf-8?B?YTEzYXRhT0xXZHREZ1V4dC9USlBZNEMyQXdQa1NCb3diNi85dkhDNnBibkFY?=
 =?utf-8?B?b1h4NkJJL1ZLZjhmdS8vYkJoRXRCRmdpd2kreDRud3RFTWcxWnkzYTZxYjZN?=
 =?utf-8?B?RGwxenUyUzNabmp2ZWZQWHBja3Bka2hHS29UWkdMNEVoNzdoM3VORWNkekF5?=
 =?utf-8?B?cmhMWFRqTEJ6MDFxYTFCOWVnTzEyT3dJSDBackFKK3h5YklLTGJKWk96UEcr?=
 =?utf-8?B?cGJsQXlkYTl1NkNWWlF0QUE1SFI3TnBYcmkyWEo5eldDNUZ4UVhCSUpuVWgw?=
 =?utf-8?B?ZjhKendFQmJ1cEw4c3k3ZStZTzZmcis0V2NNK213RmhGbENYV1Q0dElNQjlU?=
 =?utf-8?B?UzViM0lHWHQ3dEFHT1FIWmtlZ21laUFmZmF1VUpwT3VRaTdCamlheldFVjhl?=
 =?utf-8?B?bnN3aXkzRXRVU3BMY1NPSW5zT0hKR1dwckM3ck5saHFCTnlQbThQQjdZdUZC?=
 =?utf-8?B?TWlyTzFacHJxR0RKcnFKV3c0UTZxbXAyd0xhN0Q0eGtrdlhiUjV3TVZaa3RF?=
 =?utf-8?B?MmxyRXNOb25xSTZteW1JaHp6SUdqU29RcUh3amQ3WEZGTnh3SlROVGZnQm1n?=
 =?utf-8?B?RHZ1amJYamtKQUZTdUYyajFweWgxUWQvUzQ4WW5rS243c25aN1RxdXVSeGtQ?=
 =?utf-8?B?TEZzOUpFQkNlWUtCSnQ2b3NsdkMySWhuUGpUZ0Q2cjFCWUxDNDdzNHhnakVY?=
 =?utf-8?B?cVVvTHdNNlZYZ2xON2traG9Rc0k0cE5vNUJDM1BqNGdKRmQ4cTFMeDJtVk1O?=
 =?utf-8?B?OVR3Wmd6VmVMakpVVXBJaDlnWUQ5cm9zUHRTR0I5TG5MRXRvQTlrYTQ5cHlR?=
 =?utf-8?B?QmhQYkwrc1NSQUMwcE4xdFlweTFyUE4zUDgvdFQwekFqZnNUUmtWWmRVUGh5?=
 =?utf-8?B?eU1CWkFtMGVGWjVZeUlqMzIxNy9zWEFmR2o5MGIyWjhQK1AwWndEQW43YTZ1?=
 =?utf-8?B?U1VYL1FUT2FIRExjdDZZekl6bjM0MmFrb2l3bFpsNE5yWGdIajE1RGhGdExo?=
 =?utf-8?B?SjhtTTdOeFJUTWRxZ1JVeVhIWDN6dEFPbEE5S0VtanIrMGNDQUJKelVLazFs?=
 =?utf-8?B?R3VRRG43SFA2OTZPTyt1TjBSY1hrMlZYWjJCaWk0dHdrZm5kaFZ3V1Z1R1JI?=
 =?utf-8?B?cVN6VWpjb21xQ1NzSjEyUT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(8096899003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NXJJbFZlcERTdWMxNDhIRmtsSk1EMWY3ZmhrSWN1TmJ2dmQ2KzhBUEUyRTJJ?=
 =?utf-8?B?R3M5SHhRWWVkQnU3TEtmemlFZ1JNa1Eva1VGc3hta2xlRE10NnJsRmJjWlZs?=
 =?utf-8?B?ZGdHWVltZGphci9kT0NYdlBlTVk3Y21zMllNSHFFNDhGYnFaL0hrVkRQeksx?=
 =?utf-8?B?MnhnRXZmd1FNS1R2cXk3cWtRcFVzWmJIZ3AvaTZxZStkcXBOdmRBZnRVMFdx?=
 =?utf-8?B?U1dDTlYrRGVneFJLU2doNzJuaXp0bG1yZStKRlozL05OM2FiM2RUcm5WK1ZN?=
 =?utf-8?B?YkxFci9NQ1cyQStKSnY2eGROWDdXOGprOHMvWFpRUWJzREFpemZxRlhoTkJZ?=
 =?utf-8?B?ZHZGWlJuNkNXR0pvL2tQdHpNeGV1eVhzMXBaek9kb2xZR2c3S3hGMHRkK1Uv?=
 =?utf-8?B?YzNoODByTHFsdGd0Tkx1UHJ0bGcrdjl2YUlxNy9TbUJwOW40c0xuWmFiSXdR?=
 =?utf-8?B?UUk5MkpVSERldnpsRzI3WklQd2VZNngrU1dVL1NFSWpjd0llWlFXbUFqV053?=
 =?utf-8?B?MXl4ZUQ3WlVndTA0dm5tT1FMQ0t2TWI5R3J0aUF5Um4xZDByN1A1WFdHRHpD?=
 =?utf-8?B?cnJkZ3NRQUJzbkxldGxQRUxsNHpYUGtia3RWNDJZWHRxbWxLdTdSMXZBck10?=
 =?utf-8?B?NlpKMzhxaVEwTVVQV2U5RUZnaThtRGROaklYVnB5T0FRanczaGM3aElhR1Bm?=
 =?utf-8?B?M05NUXdkWnhXRGp4K2ZiQy8yNnpxWkR0bzcxbWlQZVFPeGpqT1hjUnlrYkto?=
 =?utf-8?B?dUtlN2NUQmprdUpTelk1L1VDZVdKdVI4ZkJCQURNZmo1Ky9NM2FpZFhyVW91?=
 =?utf-8?B?SzM1ZmNRc3F5UFB6bzJ3RGk2c2ZrdVJadEJRWWJuTVk4UTZEMWhvRnFVVjZT?=
 =?utf-8?B?OGQ4a1NlNVZ0VVYxZG1EbXl6cytCc1NGKzdvckVHKzBwYklxQStWbGxUcEZI?=
 =?utf-8?B?aUR5dC82SUJuWDVCbUVnN1kweXBob0NxK1diQlBLaURHNCtkRmFHeGhtN3oz?=
 =?utf-8?B?ZzBPTTJRcUhjczJqMlBkRFR3UzkzNXJmSlZ1VUVFNVdDMyt5T0xTdFd2OFBu?=
 =?utf-8?B?SnVrcTJYdHB5RW5sQnhxNTdFRGdmc0tzbHArRXh3MVVYcnU5WDZoWWV6anFI?=
 =?utf-8?B?N0ozdWpvRExqMFBsT0w1Rk9VRmlOTTFRcXliZGpZTzFNSXVpeWQycnpwWWth?=
 =?utf-8?B?cEJ6WFhRVG03em02a2pGU2hzS0FBQ1BVMUcrV2xkTjVlVDJBdzkzdk5KVWNN?=
 =?utf-8?B?MFpnOWU3SER0YWVRN0JnNVdlTm50Q0tjaTlTZmtFdWNiVFhtWm5VYmpXMFlj?=
 =?utf-8?B?SHJiTFZXTC9MbjJSbzMydmk5QjZkY21TMGc3ODRLWEJhUDdBN05rZjBoaXJJ?=
 =?utf-8?B?T05RU21qL1dhclVkL3p5NTRxNytjRlllK1VVbEVGanVmV2MwQkVHQXE5dDho?=
 =?utf-8?B?WHp4T2FMRUIxcC9vOEMxZVNhR3owU3ByOFZxaXN2NXNTeWFVaG10Y01QWGpP?=
 =?utf-8?B?VU9RNGZmYWlYK3NCR3dsSWNKNmk4Y2ZGVUsyRUROL0d6YXZKY3o3K3JDTnpT?=
 =?utf-8?B?Y0Rqb0dOUzFDR2wwWkRrR0JZblNWOUJvdjBZMkpUeVhRQ0RhUHVjbzNaQWEw?=
 =?utf-8?B?alc0ak1iZjBOV3VQbDliemV4bXRtYnRJY3IySEdVSjZLUmtBTUlHZ0JYRGda?=
 =?utf-8?B?UnhzRVZ0Vi80NzhTQ3p3Uy9WR3lFU3lMNkwyRjZlOHdacFFqbnY5RUFzcktt?=
 =?utf-8?B?aW5TV1N6QTY1K21SMHRqeUkvUFF1VjQ1WWYzclRSWHJYWHhzdGpzaGtpWWs5?=
 =?utf-8?B?cnNoTUFLZWk5TGdMY0pubzAvdDEzM2t2S0ZQNFkzbFVyRi9scE5uUWg1N25y?=
 =?utf-8?B?TU9NNzZjcjUrUXFFNGNCYW9IZFJORDE5eTd4dnJKWDhFNTMyTlhMa0lwdm5a?=
 =?utf-8?B?aWNYUXhYdXBtdkpEUktNcWpHSTRCdVIybnRiRG5URUR5b05wc0ZNVWxCRktQ?=
 =?utf-8?B?LzM4a2thT0xmYzNOT0R0TXY4YVRUaUxqam5LaUp3RFJEWU4yRkd3MVZubTVk?=
 =?utf-8?B?bzhLNnNjZUlHTmgrSHZWbU5qdDJWL2owa3U1M3EzWWFKZ0tOVmVaKzFOQ05Y?=
 =?utf-8?B?NDJNZ1UybExFdGpQaERSeERWREZmT2xLZDRFQ1BoalFuOUdBOTRXMXg1NEVS?=
 =?utf-8?B?dVE9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14706c2d-c232-47da-d0a9-08dd2e5f65ee
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 14:35:42.5779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M/FWn6fndwJLPvH5qqlUODLMapG9oKfU0i0utYRMlMs9U3uNqxBlEqrPr0DCjd7kpkx9NZIhilRuU7TnpGc6/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8717
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 06 Jan 2025 14:35:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16967

--------------FhXmQV5p3uH9tDukK8P0kpvv
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 06.01.2025 um 12:04 schrieb Richard Purdie:
> On Fri, 2024-12-20 at 12:25 +0100, Stefan Herbrechtsmeier via lists.openembedded.org wrote:
>> From: Stefan Herbrechtsmeier<stefan.herbrechtsmeier@weidmueller.com>
>>
>> The patch series improves the fetcher support for tightly coupled
>> package manager (npm, go and cargo). It adds support for embedded
>> dependency fetcher via a common dependency mixin. The patch series
>> reworks the npm-shrinkwrap.json (package-lock.json) support and adds a
>> fetcher for go.sum and cargo.lock files. The dependency mixin contains
>> two stages. The first stage locates a local specification file or
>> fetches an archive or git repository with a specification file. The
>> second stage resolves the dependency URLs from the specification file
>> and fetches the dependencies.
>>
>> SRC_URI = "<type>://npm-shrinkwrap.json"
>> SRC_URI = "<type>+http://example.com/ npm-shrinkwrap.json"
>> SRC_URI = "<type>+http://example.com/${BP}.tar.gz;striplevel=1;subdir=${BP}"
>> SRC_URI = "<type>+git://example.com/${BPN}.git;protocol=https"
>>
>> Additionally, the patch series reworks the npm fetcher to work without a
>> npm binary and external package repository. It adds support for a common
>> dependency name and version schema to integrate the dependencies into
>> the SBOM.
>>
>> = Background
>> Bitbake has diverse concepts and drawbacks for different tightly coupled
>> package manager. The Python support uses a recipe per dependency and
>> generates common fetcher URLs via a python function. The other languages
>> embed the dependencies inside the recipe. The Node.js support offers a
>> npmsw fetcher which uses a lock file beside the recipe to generates
>> multiple common fetcher URLs on the fly and thereby hides the real
>> download sources. This leads to a single source in the SBOM for example.
>> The Go support contains two parallel implementations. A vendor-based
>> solution with a common fetcher and a go-mod-based solution with a gomod
>> fetcher. The vendor-based solution includes the individual dependencies
>> into the SRC_URI of the recipe and uses a python function to generate
>> common fetcher URLs which additional information for the vendor task.The
>> gomod fetcher uses a proprietary gomod URL. It translates the URL into a
>> common URL and prepares meta data during unpack. The Rust support
>> includes the individual dependencies in the SRC_URI of the recipe and
>> uses proprietary crate URLs. The crate fetcher translates a proprietary
>> URL into a common fetcher URL and prepares meta data during unpack. The
>> recipetool does not support the crate and the gomod fetcher. This leads
>> to missing licenses of the dependencies in the recipe for example
>> librsvg.
>>
>> The steps needed to fetch dependencies for Node.js, Go and Rust are
>> similar:
>> 1. Extract the dependencies from a specification file (name, version,
>>     checksum and URL)
>> 2. Generate proprietary fetcher URIs
>>    a. npm://registry.npmjs.org/;package=glob;version= 10.3.15
>>    b. gomod://golang.org/x/net;version=v0.9.0
>>       gomodgit://golang.org/x/net;version=v0.9.0;repo=go.googlesource.com/net
>>    c. crate://crates.io/glob/0.3.1
>> 3. Generate wget or git fetcher URIs
>>    a.https://registry.npmjs.org/glob/-/glob-10.3.15.tgz;downloadfilename=…
>>    b.https://proxy.golang.org/golang.org/x/net/@v/v0.9.0.zip;downloadfilename=…
>>       git://go.googlesource.com/net;protocol=https; subdir=…
>>    c.https://crates.io/api/v1/crates/glob/0.3.1/download;downloadfilename=…
>> 4. Unpack
>> 5. Create meta files
>>    a. Update lockfile and create tar.gz archives
>>    b. Create go.mod file
>>       Create info, go.mod file and zip archives
>>    c. Create .cargo-checksum.json files
>>
>> It looks like the recipetool is not widely used and therefore this patch
>> series integrates the dependency resolving into the fetcher. After an
>> agreement on a concept the fetcher could be extended. The fetcher could
>> download the license information per package and a new build task could
>> run the license cruncher from the recipetool.
> I've spent a bit more time thinking about this and looking at the code
> and I've mixed feelings on it.I can certainly see why you've
> implemented it this way and it does have a lot of potential but there
> are also potential risks.

Thank you very much for your feedback.

> My comments (on various elements):
>
> With a npm-shrinkwrap.json/package-lock.json/go.sum file, are
> dependencies always recorded as specific entities with checksums?

Yes, every dependency contains a fixed version and a checksum. The 
purpose of the file is integrity and reproducibility.

>   I'm a
> little bit worried about how easily you could sneak a "floating"
> version into this and make the fetcher non-deterministic. Does (or
> could?) the code detect and error on that?

We could raise an error if a checksum is missing in the dependency 
specification file or make the checksum mandatory for the dependency 
fetcher.  Furthermore we could inspect the dependency URLs to detect a 
misuse of the file like a latest string for the version.

> Put another way, could one of these SRC_URIs map to multiple different
> combinations of underlying component versions?

If you mean the extracted SRC_URI for a single dependency from the 
dependency specification file (ex. npm-shrinkwrap.json) it could use 
special URLs to map to the latest version. But this is a missus of the 
dependency specification file and could be detected. The tools generate 
files with fixed versions always because a floating version with a fixed 
checksum make no senses.

> Our existing method effectively hardcodes/expands the lock file into
> extended SRC_URI entries which makes the specific versions and
> components really clear. This change abstracts that away into the
> fetcher and makes it opaque to the user, and much harder for code like
> the archiver/license/spdx code to fine/handle.

Really? Let's use the crate fetcher as an example. At the moment the 
cargo-update-recipe-crates class extract the URI and checksum from the 
Cargo.lock. The class ignores the licenses and they leads to missing 
licenses in the recipe. The spdx files contains bitbake specific fetcher 
URLs only which are unknown outside of bitbake.

I also thought it would make sense to generate recipes from the 
dependency specification files and therefore worked on the recipetool 
previous. But it looks like the tool isn't really used and I'm afraid 
nobody will use the recipe to fix dependencies. In most cases it is easy 
to update a dependency in the native tooling and only provide an updated 
dependency specification file.

I have a WIP to integrate the the dependencies into the spdx . This uses 
the expanded_urldata / implicit_urldata function to add the dependencies 
to the process list of archiver and spdx.

https://github.com/weidmueller/poky/tree/feature/dependency-fetcher

Regarding the license we could migrate the functionality from recipetool 
into a class and detect the licenses at build time. Theoretically the 
fetcher could fetch the license from the package manager repository but 
we have to trust the repository because we have no checksum to detect 
changes. Maybe we could integrate tools like Syft or ScanCode to detect 
the licenses at build time. At the moment the best solution is to make 
sure that the SBOM contains the name and version of the dependencies and 
let other tools handle the license via SBOM for now. Therefore I propose 
a common scheme to define the dependency name (dn) and version (dv) in 
the SRC_URI.

> I noticed that any fetcher operation has to first expand the lock file
> using a temporary directory.
I follow gitsm and open for suggestions. The expand happens only once 
per fetcher object. The sub fechter object is saved in the proxy variable.

> You're using DL_DIR for that which I
> suspect isn't a great idea for tmp files.
Take over from gitsm.

>   In many cases that will work
> fine but it is a bit of a performance overhead.
>
> I did start wondering if we should cache the lock files in a subdir of
> DL_DIR to help performance and also give some extra assurance about
> changing content.
This would be possible. I assume the best would be another sub SRC_URI 
to avoid code duplication for the locking and change detection.

> The url scheme is clever but also has a potential risk in that you
> can't really pass parameters to both the top level fetcher and the
> underlying one. I'm worried that is going to bite us further down the
> line.

At the moment I don't see a real problem but maybe you are right. The 
existing language specific fetcher use fixed paths for there downloads.

What do you propose? Should the fetcher skip the unpack of the source or 
should we introduce a sub fetcher which uses the download from an other 
SRC_URI entry. The two entries could be linked via the name parameter. 
This approach could be combined with your suggestion above. The new 
fetcher will unpack a lock file from an other (default) download.

>> = Open questions
>>
>> * Where should we download dependencies?
>> ** Should we use a folder per fetcher (ex. git and npm)?
>> ** Should we use the main folder (ex. crate)?
>> ** Should we translate the name into folder (ex. gomod)?
>> ** Should we integrate the name into the filename (ex. git)?
> DL_DIR is meant to be a complete cache of the source so it would need
> to be downloaded there. Given it maps to the other fetchers, the
> existing cache mechanisms likely work for these just fine, the open
> question is on whether the lock/spec files should be cached after
> extraction.

You misunderstand the question. Its about the downloadfilename 
parameter. At the moment some fetcher use sub folder inside DL_DIR and 
others use the main folder. It looks like every fetcher has its own 
concept to handle file collision between different fetchers. The git and 
npm fetcher use there own folder, the crate fetcher use its own .crate 
file prefix, the gomod fetcher translate the URL into multiple folders 
and the git fetcher translate the URL into a single folder name.

>> * Where should we unpack the dependencies?
>> ** Should we use a folder inside the parent folder (ex. node_modules)?
>> ** Should we use a fixed folder inside unpackdir
>>     (ex. go/pkg/mod/cache/download and cargo_home/bitbake)?
> This likely depends on the fetcher as the different mechanisms will
> have different expectations about how they should be extracted (as
> npm/etc. would).

It depends on the fetcher but the fetcher could use the same approach. 
At the moment every fetcher use a different approach. The crate fetcher 
use a fixed value. The gomod fetcher uses a variable (GO_MOD_CACHE_DIR) 
and the npm fetcher uses a parameter (destsuffix). Furthermore the gomod 
fetcher override the common subdir parameter.

>> * How should we treat archives for package manager caches?
>> ** Should we unpack the archives to support patching (ex. npm)?
>> ** Should we copy the packed archive to avoid unpacking and packaging
>>     (ex. gomod)?
> If there are archives left after do_unpack, which task is going to
> unpack those? Are we expecting the build process in configure/compile
> to decompress them? Would those management tools accept things if they
> were extracted earlier? "unpack" would be the correct time to do it but
> I can see this getting into conflict with the package manager :/.

Most package manager expect archives. In the npm case the archive is 
unpack by the fetcher and packed by thenpm.bbclass to support patching. 
The gomod fetcher doesn't unpack the downloaded archive and the gomodgit 
fetcher create archives from git folders during unpack. It would be 
possible to always keep the archives or always extract the archives and 
recreate archives during build. It is a decision between performance and 
patchability.

At the moment it is complicated to work with the different fetcher 
because every fetcher use a different concept and it is unclear what is 
the desired approach.

>> This patch series depends on patch series
>> 20241209103158.20833-1-stefan.herbrechtsmeier-oss@weidmueller.com
>> ("[1/4] tests: fetch: adapt npmsw tests to fixed unpack behavior").
> Those merged thanks.

Thanks.

> I did wonder if patches 1-5 of this series could
> be merged separately too as they look reasonable regardless of the rest
> of the series?

Sure. Should I resend the patches as separate series?

Regards
   Stefan

--------------FhXmQV5p3uH9tDukK8P0kpvv
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Am 06.01.2025 um 12:04 schrieb Richard
      Purdie:<br>
    </div>
    <blockquote type="cite" cite="mid:00e379e761414e8cf07b83544d5202211bf4623c.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">On Fri, 2024-12-20 at 12:25 +0100, Stefan Herbrechtsmeier via lists.openembedded.org wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">From: Stefan Herbrechtsmeier <a class="moz-txt-link-rfc2396E" href="mailto:stefan.herbrechtsmeier@weidmueller.com">&lt;stefan.herbrechtsmeier@weidmueller.com&gt;</a>

The patch series improves the fetcher support for tightly coupled
package manager (npm, go and cargo). It adds support for embedded
dependency fetcher via a common dependency mixin. The patch series
reworks the npm-shrinkwrap.json (package-lock.json) support and adds a
fetcher for go.sum and cargo.lock files. The dependency mixin contains
two stages. The first stage locates a local specification file or
fetches an archive or git repository with a specification file. The
second stage resolves the dependency URLs from the specification file
and fetches the dependencies.

SRC_URI = &quot;&lt;type&gt;://npm-shrinkwrap.json&quot;
SRC_URI = &quot;&lt;type&gt;+http://example.com/&nbsp;npm-shrinkwrap.json&quot;
SRC_URI = &quot;&lt;type&gt;+http://example.com/${BP}.tar.gz;striplevel=1;subdir=${BP}&quot;
SRC_URI = &quot;&lt;type&gt;+git://example.com/${BPN}.git;protocol=https&quot;

Additionally, the patch series reworks the npm fetcher to work without a
npm binary and external package repository. It adds support for a common
dependency name and version schema to integrate the dependencies into
the SBOM.

= Background
Bitbake has diverse concepts and drawbacks for different tightly coupled
package manager. The Python support uses a recipe per dependency and
generates common fetcher URLs via a python function. The other languages
embed the dependencies inside the recipe. The Node.js support offers a
npmsw fetcher which uses a lock file beside the recipe to generates
multiple common fetcher URLs on the fly and thereby hides the real
download sources. This leads to a single source in the SBOM for example.
The Go support contains two parallel implementations. A vendor-based
solution with a common fetcher and a go-mod-based solution with a gomod
fetcher. The vendor-based solution includes the individual dependencies
into the SRC_URI of the recipe and uses a python function to generate
common fetcher URLs which additional information for the vendor task.The
gomod fetcher uses a proprietary gomod URL. It translates the URL into a
common URL and prepares meta data during unpack. The Rust support
includes the individual dependencies in the SRC_URI of the recipe and
uses proprietary crate URLs. The crate fetcher translates a proprietary
URL into a common fetcher URL and prepares meta data during unpack. The
recipetool does not support the crate and the gomod fetcher. This leads
to missing licenses of the dependencies in the recipe for example
librsvg.

The steps needed to fetch dependencies for Node.js, Go and Rust are
similar:
1. Extract the dependencies from a specification file (name, version,
&nbsp;&nbsp; checksum and URL)
2. Generate proprietary fetcher URIs
&nbsp; a. npm://registry.npmjs.org/;package=glob;version= 10.3.15
&nbsp; b. gomod://golang.org/x/net;version=v0.9.0
&nbsp;&nbsp;&nbsp;&nbsp; gomodgit://golang.org/x/net;version=v0.9.0;repo=go.googlesource.com/net
&nbsp; c. crate://crates.io/glob/0.3.1
3. Generate wget or git fetcher URIs
&nbsp; a. <a class="moz-txt-link-freetext" href="https://registry.npmjs.org/glob/-/glob-10.3.15.tgz;downloadfilename=…">https://registry.npmjs.org/glob/-/glob-10.3.15.tgz;downloadfilename=…</a>
&nbsp; b. <a class="moz-txt-link-freetext" href="https://proxy.golang.org/golang.org/x/net/@v/v0.9.0.zip;downloadfilename=…">https://proxy.golang.org/golang.org/x/net/@v/v0.9.0.zip;downloadfilename=…</a>
&nbsp;&nbsp;&nbsp;&nbsp; git://go.googlesource.com/net;protocol=https; subdir=…
&nbsp; c. <a class="moz-txt-link-freetext" href="https://crates.io/api/v1/crates/glob/0.3.1/download;downloadfilename=…">https://crates.io/api/v1/crates/glob/0.3.1/download;downloadfilename=…</a>
4. Unpack
5. Create meta files
&nbsp; a. Update lockfile and create tar.gz archives
&nbsp; b. Create go.mod file
&nbsp;&nbsp;&nbsp;&nbsp; Create info, go.mod file and zip archives
&nbsp; c. Create .cargo-checksum.json files

It looks like the recipetool is not widely used and therefore this patch
series integrates the dependency resolving into the fetcher. After an
agreement on a concept the fetcher could be extended. The fetcher could
download the license information per package and a new build task could
run the license cruncher from the recipetool.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I've spent a bit more time thinking about this and looking at the code
and I've mixed feelings on it.I can certainly see why you've
implemented it this way and it does have a lot of potential but there
are also potential risks. </pre>
    </blockquote>
    <p>Thank you very much for your feedback.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:00e379e761414e8cf07b83544d5202211bf4623c.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">My comments (on various elements):

With a npm-shrinkwrap.json/package-lock.json/go.sum file, are
dependencies always recorded as specific entities with checksums?</pre>
    </blockquote>
    <p>Yes, every dependency contains a fixed version and a checksum.
      The purpose of the file is integrity and reproducibility.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:00e379e761414e8cf07b83544d5202211bf4623c.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre"> I'm a
little bit worried about how easily you could sneak a &quot;floating&quot;
version into this and make the fetcher non-deterministic. Does (or
could?) the code detect and error on that?</pre>
    </blockquote>
    <p>We could raise an error if a checksum is missing in the
      dependency specification file or make the checksum mandatory for
      the dependency fetcher.&nbsp; Furthermore we could inspect the
      dependency URLs to detect a misuse of the file like a latest
      string for the version.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:00e379e761414e8cf07b83544d5202211bf4623c.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">Put another way, could one of these SRC_URIs map to multiple different
combinations of underlying component versions?
</pre>
    </blockquote>
    <p>If you mean the extracted SRC_URI for a single dependency from
      the dependency specification file (ex. npm-shrinkwrap.json) it
      could use special URLs to map to the latest version. But this is a
      missus of the dependency specification file and could be detected.
      The tools generate files with fixed versions always because a
      floating version with a fixed checksum make no senses.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:00e379e761414e8cf07b83544d5202211bf4623c.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">Our existing method effectively hardcodes/expands the lock file into
extended SRC_URI entries which makes the specific versions and
components really clear. This change abstracts that away into the
fetcher and makes it opaque to the user, and much harder for code like
the archiver/license/spdx code to fine/handle.</pre>
    </blockquote>
    <p>Really? Let's use the crate fetcher as an example. At the moment
      the cargo-update-recipe-crates class extract the URI and checksum
      from the Cargo.lock. The class ignores the licenses and they leads
      to missing licenses in the recipe. The spdx files contains bitbake
      specific fetcher URLs only which are unknown outside of bitbake.<br>
      <br>
      I also thought it would make sense to generate recipes from the
      dependency specification files and therefore worked on the
      recipetool previous. But it looks like the tool isn't really used
      and I'm afraid nobody will use the recipe to fix dependencies. In
      most cases it is easy to update a dependency in the native tooling
      and only provide an updated dependency specification file.<br>
      <br>
      I have a WIP to integrate the the dependencies into the spdx .
      This uses the expanded_urldata / implicit_urldata function to add
      the dependencies to the process list of archiver and spdx.<br>
    </p>
    <p><a class="moz-txt-link-freetext" href="https://github.com/weidmueller/poky/tree/feature/dependency-fetcher">https://github.com/weidmueller/poky/tree/feature/dependency-fetcher</a><br>
      <br>
      Regarding the license we could migrate the functionality from
      recipetool into a class and detect the licenses at build time.
      Theoretically the fetcher could fetch the license from the package
      manager repository but we have to trust the repository because we
      have no checksum to detect changes. Maybe we could integrate tools
      like Syft or ScanCode to detect the licenses at build time. At the
      moment the best solution is to make sure that the SBOM contains
      the name and version of the dependencies and let other tools
      handle the license via SBOM for now. Therefore I propose a common
      scheme to define the dependency name (dn) and version (dv) in the
      SRC_URI.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:00e379e761414e8cf07b83544d5202211bf4623c.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">I noticed that any fetcher operation has to first expand the lock file
using a temporary directory.
</pre>
    </blockquote>
    I follow gitsm and open for suggestions. The expand happens only
    once per fetcher object. The sub fechter object is saved in the
    proxy variable.<br>
    <br>
    <blockquote type="cite" cite="mid:00e379e761414e8cf07b83544d5202211bf4623c.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">
You're using DL_DIR for that which I
suspect isn't a great idea for tmp files.</pre>
    </blockquote>
    Take over from gitsm.<br>
    <br>
    <blockquote type="cite" cite="mid:00e379e761414e8cf07b83544d5202211bf4623c.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre"> In many cases that will work
fine but it is a bit of a performance overhead.

I did start wondering if we should cache the lock files in a subdir of
DL_DIR to help performance and also give some extra assurance about
changing content.</pre>
    </blockquote>
    This would be possible. I assume the best would be another sub
    SRC_URI to avoid code duplication for the locking and change
    detection.<br>
    <br>
    <blockquote type="cite" cite="mid:00e379e761414e8cf07b83544d5202211bf4623c.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">The url scheme is clever but also has a potential risk in that you
can't really pass parameters to both the top level fetcher and the
underlying one. I'm worried that is going to bite us further down the
line.
</pre>
    </blockquote>
    <p>At the moment I don't see a real problem but maybe you are right.
      The existing language specific fetcher use fixed paths for there
      downloads.<br>
      <br>
      What do you propose? Should the fetcher skip the unpack of the
      source or should we introduce a sub fetcher which uses the
      download from an other SRC_URI entry. The two entries could be
      linked via the name parameter. This approach could be combined
      with your suggestion above. The new fetcher will unpack a lock
      file from an other (default) download.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:00e379e761414e8cf07b83544d5202211bf4623c.camel@linuxfoundation.org">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">= Open questions

* Where should we download dependencies?
** Should we use a folder per fetcher (ex. git and npm)?
** Should we use the main folder (ex. crate)?
** Should we translate the name into folder (ex. gomod)?
** Should we integrate the name into the filename (ex. git)?
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
DL_DIR is meant to be a complete cache of the source so it would need
to be downloaded there. Given it maps to the other fetchers, the
existing cache mechanisms likely work for these just fine, the open
question is on whether the lock/spec files should be cached after
extraction.</pre>
    </blockquote>
    <p>You misunderstand the question. Its about the downloadfilename
      parameter. At the moment some fetcher use sub folder inside DL_DIR
      and others use the main folder. It looks like every fetcher has
      its own concept to handle file collision between different
      fetchers. The git and npm fetcher use there own folder, the crate
      fetcher use its own .crate file prefix, the gomod fetcher
      translate the URL into multiple folders and the git fetcher
      translate the URL into a single folder name.<br>
      <span style="white-space: pre-wrap">

</span></p>
    <blockquote type="cite" cite="mid:00e379e761414e8cf07b83544d5202211bf4623c.camel@linuxfoundation.org">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">* Where should we unpack the dependencies?
** Should we use a folder inside the parent folder (ex. node_modules)?
** Should we use a fixed folder inside unpackdir
&nbsp;&nbsp; (ex. go/pkg/mod/cache/download and cargo_home/bitbake)?
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
This likely depends on the fetcher as the different mechanisms will
have different expectations about how they should be extracted (as
npm/etc. would).</pre>
    </blockquote>
    <p>It depends on the fetcher but the fetcher could use the same
      approach. At the moment every fetcher use a different approach.
      The crate fetcher use a fixed value. The gomod fetcher uses a
      variable (GO_MOD_CACHE_DIR) and the npm fetcher uses a parameter
      (destsuffix). Furthermore the gomod fetcher override the common
      subdir parameter.</p>
    <p><span style="white-space: pre-wrap">
</span></p>
    <blockquote type="cite" cite="mid:00e379e761414e8cf07b83544d5202211bf4623c.camel@linuxfoundation.org">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">* How should we treat archives for package manager caches?
** Should we unpack the archives to support patching (ex. npm)?
** Should we copy the packed archive to avoid unpacking and packaging
&nbsp;&nbsp; (ex. gomod)?
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
If there are archives left after do_unpack, which task is going to
unpack those? Are we expecting the build process in configure/compile
to decompress them? Would those management tools accept things if they
were extracted earlier? &quot;unpack&quot; would be the correct time to do it but
I can see this getting into conflict with the package manager :/.</pre>
    </blockquote>
    <p>Most package manager expect archives. In the npm case the archive
      is unpack by the fetcher and packed by thenpm.bbclass to support
      patching. The gomod fetcher doesn't unpack the downloaded archive
      and the gomodgit fetcher create archives from git folders during
      unpack. It would be possible to always keep the archives or always
      extract the archives and recreate archives during build. It is a
      decision between performance and patchability.<br>
      <br>
      At the moment it is complicated to work with the different fetcher
      because every fetcher use a different concept and it is unclear
      what is the desired approach.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:00e379e761414e8cf07b83544d5202211bf4623c.camel@linuxfoundation.org">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">This patch series depends on patch series
<a class="moz-txt-link-abbreviated" href="mailto:20241209103158.20833-1-stefan.herbrechtsmeier-oss@weidmueller.com">20241209103158.20833-1-stefan.herbrechtsmeier-oss@weidmueller.com</a>
(&quot;[1/4] tests: fetch: adapt npmsw tests to fixed unpack behavior&quot;).
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Those merged thanks.
</pre>
    </blockquote>
    <p>Thanks.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:00e379e761414e8cf07b83544d5202211bf4623c.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">I did wonder if patches 1-5 of this series could
be merged separately too as they look reasonable regardless of the rest
of the series?</pre>
    </blockquote>
    <p>Sure. Should I resend the patches as separate series?<br>
      <br>
      Regards<br>
      &nbsp; Stefan<br>
      <br>
    </p>
  </body>
</html>

--------------FhXmQV5p3uH9tDukK8P0kpvv--

