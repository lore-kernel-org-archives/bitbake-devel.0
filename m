Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D96C021A0
	for <webhook@archiver.kernel.org>; Thu, 13 Feb 2025 08:37:00 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.94])
 by mx.groups.io with SMTP id smtpd.web11.6668.1739435812349070861
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Feb 2025 00:36:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@weidmueller.com header.s=selector2 header.b=1fv7NDXS;
 spf=pass (domain: weidmueller.com, ip: 40.107.22.94, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eqCcN7Tta3QrcBxTEIPzIDqokGDNMDpOrxk7hmqyFWHzey1XayHsoTX3Fw4SkYXvzgO9whzyJ0pYxfilrOuzWNzD9744SDselPDOTT8Rvoc07/acO+MCE7a9kwMC2Bq8tvo+NGTlK4UzxVRt0xp85ICNoWcGzwgpDNeAmwK5D4gTHZehNE4j4USFmWQncd9S1gUy9X0dCoX/An0ROS0nS6P6ZlM6dZa/CXn0c2Pj5U7T5oFZTUpSjJcAQfObulZvcHm4/jbHw1jNEXLBmkvwibTGtESgivP2ZUCGWJJVsJgf7Muwhae0J/OkZfozChMAs5O4W1veNgMMQ5y/zjIsvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vK2/3KuAUxiM6saLZ9tdhYIkF8+JYz6Y48r5cGupmIY=;
 b=fH5lO46usDcPaDpHNXuH9Qhg0y05aUlR8K35dgsw+S8rTc8SAcCCixI2tQFMZQ2v2cH1+cN1ktHiEjTG5u8Qn662Fl4MickiwQOvqFeH5KpCMN/2ls6QqkmxbecWj+dXRDuXWz0ST2HlNr7pyfGbqMGOBwE4sjmKh2hJBJSZrC/V9GjlwNP/4Je9EPCWvVX1OnCatudepHEZ0iR2gDIjAOZ5vanXX4acG1V2qbQACXM+EpW5Uk3yQL3ZxEq5vh+kHbbhEtAwevlRnYEZg5e0kQvQvmh5HVl5dR+iL2QuuCleTgCNKzD+Xbb8izvGfDKkkFX2kocTJewXBYA8GNwMFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vK2/3KuAUxiM6saLZ9tdhYIkF8+JYz6Y48r5cGupmIY=;
 b=1fv7NDXS9eYLuseWnPWbjyHIzZ/8qBVVtzfLa3hTcJAQoa7Wq85IycrpX9JKvYJWG9IhHqj3MAr7trqjWPHMyppZuguX5nff+TjF7JHpPFJZD/sY3wbUZPtF3CxuPWvoqdnPh0wbSkfXqHLPOfPKeJfPIWKu4iIGrpuUrJYljr5FpncBSf5Acb+Djp/ooi0vmOHVyba2ZsGdc1YZdZdrQmRCceqUWw9ALvQ89OSJwX6uUNFnJ4UmB3dmh0AIZmK72i3UNZFZMBDmIIMx/ftpN/h6G/8fb0A2tVnOyfXSHwOBTnKUSwXkFfpauhhBHUTv+pewOuU5vc6nRbORo+UIrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by VI0PR08MB10798.eurprd08.prod.outlook.com (2603:10a6:800:211::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Thu, 13 Feb
 2025 08:36:48 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 08:36:47 +0000
Content-Type: multipart/alternative;
 boundary="------------xuFmCGBi8fqgvsrF770AzCmY"
Message-ID: <dc6263e6-e359-49b8-82be-9ca48627c37a@weidmueller.com>
Date: Thu, 13 Feb 2025 09:36:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [RFC PATCH 00/30] Add vendor support for go, npm
 and rust
To: Bruce Ashfield <bruce.ashfield@gmail.com>
Cc: openembedded-core@lists.openembedded.org,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 bitbake-devel@lists.openembedded.org
References: <20250211150034.18696-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <Z6vZ8m8zZLgQKyVg@gmail.com>
 <40f8d1d9-5bd3-4ac6-a107-32482d06d17b@weidmueller.com>
 <CADkTA4OA8VkQk=FVD=hMDaH+TU2567zLduVfYHSqkR_C4fpjOw@mail.gmail.com>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <CADkTA4OA8VkQk=FVD=hMDaH+TU2567zLduVfYHSqkR_C4fpjOw@mail.gmail.com>
X-ClientProxiedBy: FR0P281CA0213.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::7) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|VI0PR08MB10798:EE_
X-MS-Office365-Filtering-Correlation-Id: 51872518-e6c6-44cd-f908-08dd4c098dda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|13003099007|8096899003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OXBROXNaeGtQR3lyZ0xBbTdESmswNllub2lxS2tZcjZBNllkRnVJdm9Sc2tH?=
 =?utf-8?B?YTl0Q1lxQThLZk9WQmxKcHozbklsaW15clVWOWRqY1JRYm82d0FBMGRpRW42?=
 =?utf-8?B?U2pBU3dTQU40MStGcjBacnM2UDZPWm9qdHZIUy95RVRONHBBU2s2ZnN4VXJx?=
 =?utf-8?B?ejYxY2pkb2tTZU0ydUFTMk0xOGZ0S2QwaDFmcCtxSkZocmNFQ3lrSnhtMFFQ?=
 =?utf-8?B?SFJadm9mWUltaUowVFZQYnVtNE5sV2k2bWxCdmRSYXBCYTdTRlZ1RDE0NFVp?=
 =?utf-8?B?cVd1WVRUZEZmZk1IcytJbFQ0NUdkV25hVFVpQWdWOENFVmpiS2t1UWFKRXhI?=
 =?utf-8?B?MTJzYnJLWXQ0VnZWUldYdS95YnFUaERTWWc3UStFWjd6TU4xN1cydGRaYXJp?=
 =?utf-8?B?NlJJUGVlVnJjYWFaYUJxMjRROWY0TDRkL0Rid2dTNHo4MnptRDViVXl6aisw?=
 =?utf-8?B?NkNQcnBObnVTL3pBdUJWVHJjSXFtYm54Tjl1emxqazdBOU91M0tlR3VNMGtY?=
 =?utf-8?B?Q1A5c2gvUEhhRnJIWG5sZzRMMFV0TzhvMFg0ekFaaTk1T2tkUVNvNFIyb0E2?=
 =?utf-8?B?bC9mODU2dU5LU2N5TjVocXpNVXFaSFdPSmxBbS8vVXRXQmFPaEpMWjdDMHBP?=
 =?utf-8?B?eENrdWR6OFNrQ2Y4KzJEQzh5QkZXZVh2S1RQc2RpVDRLdFpnZktBUERxRDVx?=
 =?utf-8?B?cnR1RnRBbWVzbTFSSm9HTHRQTmFVcXkzSDFsQXVqV0JOK0pXanZMbkpxMCtK?=
 =?utf-8?B?RE5JbFFNMEQrVjBBd3ZsbGExVitqaExEVVFnVi90cUFJb1FSQ1dNYi9wRnd3?=
 =?utf-8?B?V3owbDFBT0JiQ09SWEp5MHBQTURGMzRWS3NLT2JRc1N3MjhaQUloQ2FuNXRu?=
 =?utf-8?B?bG9aVnA0TXd2Wi9UMWZnTVVKTXBUczB2cnFDTEpGSFdFQWxBMXdRK1hmbXJh?=
 =?utf-8?B?THFORzJ3a3M3Y2oxeU9NZGpXZ280M0pKWDRnZXYvQUpwOG1yYnhPMTlrRUll?=
 =?utf-8?B?dldZa2FaZWRFNUJkNXhDczNQSU9BOGpzOWRXZzI0MmtqNGoxc2hIVzlOOEZv?=
 =?utf-8?B?Z0RhUFE5ZHQvMldzRVNVYTlaK2F6RGdONzhjQzNKbC90aUVGN3lYN1QxRlIv?=
 =?utf-8?B?aXdiVGR0bHhFMStMWVlTVmxIVXRuQ2IzSHpDQ0I1MDdNZU9iMElJTFdRTXh5?=
 =?utf-8?B?YVJ1aTB3Y2kzOFBKRlNIWHhXQzlZM1J3TjFvL2tFanI4MjBEU0JiTHN3ck00?=
 =?utf-8?B?dXNBT0hxL1JOYmluQTE3YWorWVJwWkQ5MGhGRjJYbzkwS3NzcERHVzcwSXpy?=
 =?utf-8?B?Z0FTbytnT05NOG52ZUZCYWI5TVhVZ1FOcU9MUzJKUzRYelhycFMzQU9RQmlC?=
 =?utf-8?B?THcvdVNWZXdsdFd5aUFXZnFoTlNpZjVKWTlYWkRrWU5VdUliTWNHMkhlbVZk?=
 =?utf-8?B?TVRkY3JqMDhPSFA1aXFJT3dqby9iVnlrT0lQWnVNWTFrd2Q4U1pRcnlsdHhs?=
 =?utf-8?B?bytEenBsQkw0VU1MYzh1a05acUkxY1RXUmhlSjdINnAxS1AwYU5ycFdWQ1cv?=
 =?utf-8?B?TGNkM0NVZHAvYUs2cHgyY2lpN1ZVL09CaENLKzNIaEhBYWthdEFwbHRNaFNT?=
 =?utf-8?B?ODl1Z3RFL21DekZrVzFJNlpwSU5NVXptVGlkNmI2bm5aU0xzUHFKcUJwZlh4?=
 =?utf-8?B?N2lIUjhJMjBTRDdRcmdiZlhCbk1Sd3RTUFNJcnpjbEQwYjhDS1FvSjc1aUhL?=
 =?utf-8?Q?9m0Gp91pqKnS8Z8FOBVeJ4whCX5Egeey79svfwG?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(13003099007)(8096899003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?a0NNWXVDV1I2SWdkUHYyL0VyL3V1UTNpak52enh5djQ3cnhGeURWblIybjVr?=
 =?utf-8?B?cm5OVG1OMHlUMVpXN2x2NC9JaGgvdTJjUjZNWFUyOTlLQnFuOVZHVjkyb3Bm?=
 =?utf-8?B?cTY3SmFkSnZXTXNqSm16ZVlpcWhjRXVBL0N1YVo5MnRLT2ZKcTgxelI2WkVz?=
 =?utf-8?B?S2daYkx6anRqYnlVa25YVFJpL0FaWWxtMEZpa3pNd1p1Qlg1ZEM5dFlmbnZy?=
 =?utf-8?B?WEVyRUl5SmVqNnNjMmVRMWhRQWQ1WDlSWFAyNWpMYW45bGl1bHNmZVlZV0Iv?=
 =?utf-8?B?VkRFNWV2VmZsbk9vVDdISWlhYUt4V0N5Y2R4eWxKM25wNGpHeUtHNFdYMnh6?=
 =?utf-8?B?S2ZqT0dDTmU1WVhXamR6OTFQU0lSUnczbjNaRVVZV2VOYVhpNDQzV3gxZEVm?=
 =?utf-8?B?MThYNUQzSE15V2p0b1FSeDY3QnVkbTZkTDY4bVljNjgyUGUyN1JpOEVFUU40?=
 =?utf-8?B?RHcxRWlCTTY3QTFjWDYwMThXcGpIajhmM1RVWTJ2cmNiVlFDUXFvd0d4NTJi?=
 =?utf-8?B?QmQzN1p0VFlPa1dlMktRVDYybEFuUE0wZXBuUUlhQm05cTJtSjdtamY3a3c0?=
 =?utf-8?B?RmpxcVBxQ1ora2FLd0prM0Q3NCtLTjBwekNxZVVLYkRMaU4zNHNudER3aHJV?=
 =?utf-8?B?WWxkSlFvRk00OXVMNHJ0Z1JoaWNpYVQ3aGpiWVhOQWd2eUFxYlNVcEFnVEVj?=
 =?utf-8?B?NE1YckV2YlJBS1VQQmtZVVU0U2FjV3FVUFI5aGZWemdrSUZJaXBqV0ZOZisw?=
 =?utf-8?B?UE1FbW9nM0YxRXZOQVI3SEgyc3FVeXJIT1ZDWnRoc2kvbFFVUlJOaFROK3pR?=
 =?utf-8?B?UndjSVpHRjdpOHQrd09qYWhQSDd1SGRxZEZPUXFkT3BWdUR4NU1Yd1ZnSEd0?=
 =?utf-8?B?RTJWdko2YXpoWHdta0ZtOEpOSndrbml1cGNLdEFtS1hybDBQTm5FbzdXWG9v?=
 =?utf-8?B?V3dGYzZVQ1prRUZpOGs1dE1tODJBaVpBZWQ4cFhFUmNBalVETnR0RmtTbVU3?=
 =?utf-8?B?TUJ4QmxRQ0JUbVcwV2k4dEVPaEI2LytLSStCdGdDcGxnemNCVDVqNm10SThT?=
 =?utf-8?B?WEhVZXFJY1lrTHlwMUVWSnFTckNZczJsR3hic1BXTkhnR055Zk83dUc1elpC?=
 =?utf-8?B?SE5kaXdnL0RYSGIvanAvM1VQVXVna3lVQWlFbGt4WGRvSzl6UUNhWDAya1lM?=
 =?utf-8?B?NGQ2QThVVCtFeFJvUWo5alNNbkpuR1dlS2VkL2V3SWpSU2NsQ1lidkZRMjFZ?=
 =?utf-8?B?QnBWWFlyMFhTUTVybG05MlpjakRTRFo2b2tzQXpMZkJoZjVzZndYRThjWDdR?=
 =?utf-8?B?eG5URVFSdWtzV1dIV3krOHl6WHIvVG51a1hUSkhxSzlBN01PUHBQU2tFc215?=
 =?utf-8?B?ODFUZmJzVm5WUEovVEhGektCTGQ4YzNScFdvTDJuMTIySmZEYXpZN0R1YmJW?=
 =?utf-8?B?RVk2dGx3ZGNiRkZGMVhyazlXVUtlT1o3alJzMENDbnVYNFByRUxRUWhPcklz?=
 =?utf-8?B?elVISkVoVUh5bytNSk5SQ1pZcFBPTVA3S21hdnBhTXppbVFwNFRrTmxvMFBi?=
 =?utf-8?B?ZzcwSTAzcm1wUnp4Y2xhZDJGOEdIcmlBdEVMSWpua0FybWJUSDA0b3d2WmpZ?=
 =?utf-8?B?c1gwbDlRRU1ZdCtMR3h4RTdVUC84NDQxRUF3eUw3NXZwNUQ3NE1ubDFtbXpv?=
 =?utf-8?B?S2Q5Wk9pL3IxWEtGNTlDZXdQZXhMRTV0ME02aEVxNklxRHVRVXk2ZUoyMExS?=
 =?utf-8?B?YXIwb1dXczI1MnBDMkcyWFdBRUZ4Szk2bU1YczVtYi9FMzRnaGxQbUlyTTcx?=
 =?utf-8?B?L1U5UURnRml6dzZKaHprNk96RGl5ZjQyanhNZEo5VGdXSDArbk9NWEZVQUpw?=
 =?utf-8?B?VmxtL3JjVVhKS0FaNFl2T3pYb29YcFBHWjBVU0ZmNXdQRTN0czJRRFJDTkZk?=
 =?utf-8?B?d3B2d3dkRUVuSm9WS0NMb0ZpTVllcGJya3hkYVhhSWVUNWI2MmZYd1UxRFlT?=
 =?utf-8?B?OGdTV2FVRzZ1TE1zVXY0US9Nb0tVZElEQ3VadHB3bTFVRithaGo3a2U2OHE4?=
 =?utf-8?B?YnlOanpGVHNyN0FzU2orY29wOEUrZy9hblBqVlNGc2g0ZWc2T25mejZJRFpy?=
 =?utf-8?B?Y0ZSd2ZKQng1REFLS0lQekRNRkl4bHlzNzFLNFVEVmd4d3Qycm4xMEdHbFRN?=
 =?utf-8?B?d2c9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51872518-e6c6-44cd-f908-08dd4c098dda
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 08:36:47.7858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 40kb0RePEWBY/uBggbb+yTqobXqdDew0rajLQ/163NCHLiMChtmlmp1xOqGDWBfQeKN7yXFkdW3W1dOolNQvxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10798
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Feb 2025 08:37:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17211

--------------xuFmCGBi8fqgvsrF770AzCmY
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 12.02.2025 um 15:11 schrieb Bruce Ashfield:
>
>
> On Wed, Feb 12, 2025 at 3:41 AM Stefan Herbrechtsmeier 
> <stefan.herbrechtsmeier-oss@weidmueller.com> wrote:
>
>     Am 12.02.2025 um 00:14 schrieb Bruce Ashfield via
>     lists.openembedded.org <http://lists.openembedded.org>:
>>     In message: [bitbake-devel] [RFC PATCH 00/30] Add vendor support for go, npm and rust
>>     on 11/02/2025 Stefan Herbrechtsmeier vialists.openembedded.org <http://lists.openembedded.org> wrote:
>>
>>>     From: Stefan Herbrechtsmeier<stefan.herbrechtsmeier@weidmueller.com> <mailto:stefan.herbrechtsmeier@weidmueller.com>
>>>
>>>     The series adds on-the-fly support for package manager specific
>>>     dependencies and vendor directories. It contains the following changes:
>>>     1. Adds an early fetch, unpack and patch task to unpack and patch source
>>>         code with an embedded lock file for dependencies.
>>>     2. Parse the go.sum, Cargo.lock and package-lock.json lock files and
>>>         resolve the dependencies to SRC_URIs.
>>>     3. Save the SRC_URIs in a file and adapt all SRC_URIs users to handle
>>>         the SRC_URI files beside the SRC_URIs in the recipe.
>>     I made a few comments, and will have another / better look at the
>>     series tomorrow. There's a lot here, and it is hard to wrap my head
>>     around everything that is changing.
>>
>>     I have one specific question below (from the point of view of go).
>>
>>     I've been looking through the series, and can't pick out where #3 is
>>     done.
>
>     The files are created in the package manager specific vendor
>     classes (17 - 19) in the do_vendor_resolve task. The parsing is
>     implemented in the package manager specific modules in the vendor
>     package (6-8).
>
>
> aha. I'll have a closer look in a bit!
>
>>       I see patch 14 using SRC_URI_FILES, but where are those files
>>     written ? Is that in patch 18 (vendor_go_do_vendor_resolve ?)  What is
>>     written to those files ?
>
>     The file is written into the vendor directory below WORKDIR. The
>     approach is similar to other classes which need to share data
>     between tasks.
>
>     The files contain individual SRC_URIs per line.
>
> I may have missed that in the patches, but if that isn't described in 
> the commit logs, then
> that description would be a nice addition. Along with a high level 
> description for each
> supported language package manager about what is in the files and what 
> uses it to
> resolve the dependencies.

I will extend the commit messages.

>
>>     The concept that I'm not understanding (and that's just me not being
>>     familiar with things, I'll continue reading the series) is that when
>>     we suggested we'd like to have a mode where the dependencies could
>>     clearly be listed in the SRC_URI, at least I was just thinking about a
>>     way run the fetch/module elements that you were adding, write them to
>>     a file and then have the recipe include it.
>
>     The additional SRC_URIs are dynamically added to the recipe
>     without the indirection over an include file. The generated
>     SRC_URIs could be inspected via the SRC_URI_FILES and manipulated
>     via patches for the lock files or an separated lock file.
>
> The issue with patching those dynamic files .. is just that, they are 
> dynamic and
> they could be regenerated (but hopefully without a SRCREV change they 
> are identically
> generated each time, so maybe it isn't a big deal) and patching could 
> fail. Much like we
> don't patch generated automake files, we patch the .am and .in files 
> that generate the
> outputs.

You can't compare lock files with automake files. The lock files is 
generated but it contains additional information. The only difference is 
that a program and not a human write the file. If an update creates too 
much noise in the file we should discuss with upstream how to minimize 
it.  The lock file is designed to be under revision control and 
shouldn't change without reason. Dependabot automatically creates 
updates and pull requests for dependency updates. This will not work if 
the lock file isn't deterministic.

>
>>     I can't tell if in the series those files are written each time, and
>>     that there would be no way to edit those SRC_URI_FILES .. but I'll
>>     look again tomorrow.
>
>     The files are written if the do_vendor_resolve task need to be
>     rerun. It isn't possible to edit the generated SRC_URIs. Instead
>     the lock file could be patched.
>
>
> ok. So they are really just a way to dump what is being built to disk 
> and out of "memory",
> it really isn't what I was looking for, but at least I understand what 
> you were trying to
> do with the writing and later use of the files now.
>
> I was hoping for something that I could include "statically" (for lack 
> of a better term) in my
> recipes, and then have the handlers for the protocols do the fetching 
> .. again, much like
> the crate:// fetches in the .inc files.

I don't use the fetcher because of its drawbacks and limitations. I use 
the same wget URL without the indirection over the package manager 
specific fetchers. I can follow the pypi approach to generate SRC_URIs 
which call a python function:

${@crate_src_uri(d, 'xyz', '1.2.3')}

But why you need this? In any case the manipulation of a dependency 
could lead to interdependence between dependencies.

> To be clear, I'm not suggesting that mode would be the only mode, just 
> that the way the
> generation of the fetches -> actual fetching was constructed such that 
> I could avoid
> "short circuit" the handling of the lock file and simply list the 
> dependencies for fetching
> (much like how I can go get all of the SRCREVS for a gitsm:// fetch, 
> and put them into
> my recipes as pure git:// fetches if I'm having issues with the git 
> submodles).
Add a function to create this file isn't a problem, but I can't ensure 
that this will work in any case and doesn't create problems because of 
the discrepancy between the manifest / lock file and the available sources.

>>     That file would manipulate the standard SRC_URI. In other words still
>>     support a mode that is like the .inc files with crate://. So someone
>>     could either have the lockfile parsed and fetched, or have a way to
>>     run the parsing and fetching via a task, write a file and include the
>>     file in their recipe to short circuit the processing of the lockfile.
>>     (meaning the expanded and end fetches that are done once you've
>>     processed the file are simply listed as a series of fetches that are
>>     carried out without extra processing .. and "unrolled" dependency
>>     file pointing at the "sources" git, crate, mod, whatever)
>
>     What is the motivation "to short circuit the processing of the
>     lockfile"? Like any task the processing and its output are cached
>     via the sstate cache.
>
>
> See above. It isn't about re-running it a later time and re-using the 
> artifacts, it is about
> having a way to make sure nothing is dynamically resolved when bitbake 
> <foo> is called,
> just fetch and the rest of the standard tasks.

The resolve always create the same URL like the crate fetcher. It only 
changes if you change the resolve function or the crate fetcher. Every 
needed information is defined inside the lock file.

>
>     It is possible to use the vendor package to create a include file
>     but we should have good reasons to support two solutions for the
>     same problem.
>
>>     If that just doesn't make sense, then if there was a way to copy
>>     the lockfile out of the recipe and have it overlayed onto the fetched
>>     one .. maybe breaking out the individual fetch lines isn't required,
>>     since they could be individually manipulated in that lockfile.
>
>     I haven't test it but this should be possible. You can place a
>     lock file beside the recipe, add it to the SRC_URI and change the
>     XXX_LOCK_PATH.
>
>
> Something like that is a big step towards having that finer grained 
> control in a recipe that
> I'm looking for. I'd still like some sort of line by line "dumped 
> dependency list" if there's a
> lower level protocol at play (but the lock file really also is just 
> that line by line list for many
> of the languages).

Why you need this finer grained control in the recipe? You have the 
finer grained control in the lock file and additional tools to manage 
the file and all its interdependence. The resolve is deterministic and 
the .inc is only another representation. Manipulation of the 
representation could lead to problems and complicate the process. It's 
like you translate the .am and .in files into a .inc file to influence 
the generated automake files.

Would it help if we have a devtool shell so that you can run "cargo 
update" inside the folder created by "devtool modify" to update 
dependencies via the common tools and create a patch?

--------------xuFmCGBi8fqgvsrF770AzCmY
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Am 12.02.2025 um 15:11 schrieb Bruce
      Ashfield:<br>
    </div>
    <blockquote type="cite" cite="mid:CADkTA4OA8VkQk=FVD=hMDaH+TU2567zLduVfYHSqkR_C4fpjOw@mail.gmail.com">
      
      <div dir="ltr">
        <div dir="ltr">
          <div class="gmail_default" style="font-size:small"><br>
          </div>
        </div>
        <br>
        <div class="gmail_quote gmail_quote_container">
          <div dir="ltr" class="gmail_attr">On Wed, Feb 12, 2025 at
            3:41 AM Stefan Herbrechtsmeier &lt;<a href="mailto:stefan.herbrechtsmeier-oss@weidmueller.com" moz-do-not-send="true" class="moz-txt-link-freetext">stefan.herbrechtsmeier-oss@weidmueller.com</a>&gt;
            wrote:<br>
          </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <div>
              <div>Am 12.02.2025 um 00:14 schrieb Bruce Ashfield via <a href="http://lists.openembedded.org" target="_blank" moz-do-not-send="true">lists.openembedded.org</a>:<br>
              </div>
              <blockquote type="cite">
                <pre>In message: [bitbake-devel] [RFC PATCH 00/30] Add vendor support for go, npm and rust
on 11/02/2025 Stefan Herbrechtsmeier via <a href="http://lists.openembedded.org" target="_blank" moz-do-not-send="true">lists.openembedded.org</a> wrote:

</pre>
                <blockquote type="cite">
                  <pre>From: Stefan Herbrechtsmeier <a href="mailto:stefan.herbrechtsmeier@weidmueller.com" target="_blank" moz-do-not-send="true">&lt;stefan.herbrechtsmeier@weidmueller.com&gt;</a>

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
                <pre>I made a few comments, and will have another / better look at the
series tomorrow. There's a lot here, and it is hard to wrap my head
around everything that is changing.

I have one specific question below (from the point of view of go).

I've been looking through the series, and can't pick out where #3 is
done.</pre>
              </blockquote>
              <p>The files are created in the package manager specific
                vendor classes (17 - 19) in the do_vendor_resolve task.
                The parsing is implemented in the package manager
                specific modules in the vendor package (6-8).<br>
                <br>
              </p>
            </div>
          </blockquote>
          <div><br>
          </div>
          <div>
            <div class="gmail_default" style="font-size:small">aha. I'll
              have a closer look in a bit!</div>
            <br>
          </div>
          <div>&nbsp;</div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <p> </p>
            <blockquote type="cite">
              <pre> I see patch 14 using SRC_URI_FILES, but where are those files
written ? Is that in patch 18 (vendor_go_do_vendor_resolve ?)  What is
written to those files ?</pre>
            </blockquote>
            <p>The file is written into the vendor directory below
              WORKDIR. The approach is similar to other classes which
              need to share data between tasks.<br>
              <br>
              The files contain individual SRC_URIs per line.<br>
            </p>
          </blockquote>
          <div>
            <div class="gmail_default" style="font-size:small">I may
              have missed that in the patches, but if that isn't
              described in the commit logs, then</div>
            <div class="gmail_default" style="font-size:small">that
              description would be a nice addition. Along with a high
              level description for each</div>
            <div class="gmail_default" style="font-size:small">supported
              language package manager about what is in the files and
              what uses it to</div>
            <div class="gmail_default" style="font-size:small">resolve
              the dependencies.</div>
          </div>
        </div>
      </div>
    </blockquote>
    <p>I will extend the commit messages.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:CADkTA4OA8VkQk=FVD=hMDaH+TU2567zLduVfYHSqkR_C4fpjOw@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote gmail_quote_container">
          <blockquote class="gmail_quote" style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <div>
              <p> <br>
              </p>
              <blockquote type="cite">
                <pre>The concept that I'm not understanding (and that's just me not being
familiar with things, I'll continue reading the series) is that when
we suggested we'd like to have a mode where the dependencies could
clearly be listed in the SRC_URI, at least I was just thinking about a
way run the fetch/module elements that you were adding, write them to
a file and then have the recipe include it.</pre>
              </blockquote>
              <p>The additional SRC_URIs are dynamically added to the
                recipe without the indirection over an include file. The
                generated SRC_URIs could be inspected via the
                SRC_URI_FILES and manipulated via patches for the lock
                files or an separated lock file.&nbsp;</p>
            </div>
          </blockquote>
          <div><span class="gmail_default" style="font-size:small">The
              issue with patching those dynamic files .. is just that,
              they are dynamic and</span></div>
          <div class="gmail_default" style="font-size:small">they could
            be regenerated (but hopefully without a SRCREV change they
            are identically</div>
          <div class="gmail_default" style="font-size:small">generated
            each time, so maybe it isn't a big deal) and patching could
            fail. Much like we</div>
          <div class="gmail_default" style="font-size:small">don't patch
            generated automake files, we patch the .am and .in files
            that generate the</div>
          <div class="gmail_default" style="font-size:small">outputs.<br>
          </div>
        </div>
      </div>
    </blockquote>
    <p>You can't compare lock files with automake files. The lock files
      is generated but it contains additional information. The only
      difference is that a program and not a human write the file. If an
      update creates too much noise in the file we should discuss with
      upstream how to minimize it.&nbsp; The lock file is designed to be
      under revision control and shouldn't change without reason.
      Dependabot automatically creates updates and pull requests for
      dependency updates. This will not work if the lock file isn't
      deterministic.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:CADkTA4OA8VkQk=FVD=hMDaH+TU2567zLduVfYHSqkR_C4fpjOw@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote gmail_quote_container">
          <blockquote class="gmail_quote" style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <div>
              <p> <br>
                <span style="white-space:pre-wrap">
</span></p>
              <blockquote type="cite">
                <pre>I can't tell if in the series those files are written each time, and
that there would be no way to edit those SRC_URI_FILES .. but I'll
look again tomorrow.</pre>
              </blockquote>
              <p>The files are written if the do_vendor_resolve task
                need to be rerun. It isn't possible to edit the
                generated SRC_URIs. Instead the lock file could be
                patched.<br>
                <span style="white-space:pre-wrap"></span></p>
            </div>
          </blockquote>
          <div><br>
          </div>
          <div>
            <div class="gmail_default" style="font-size:small">ok. So
              they are really just a way to dump what is being built to
              disk and out of &quot;memory&quot;,</div>
            <div class="gmail_default" style="font-size:small">it really
              isn't what I was looking for, but at least I understand
              what you were trying to</div>
            <div class="gmail_default" style="font-size:small">do with
              the writing and later use of the files now.</div>
          </div>
          <div><br>
          </div>
          <div>
            <div class="gmail_default" style="font-size:small">I was
              hoping for something that I could include &quot;statically&quot;
              (for lack of a better term) in my</div>
            <div class="gmail_default" style="font-size:small">recipes,
              and then have the handlers for the protocols do the
              fetching .. again, much like</div>
            <div class="gmail_default" style="font-size:small">the
              crate:// fetches in the .inc files.</div>
          </div>
        </div>
      </div>
    </blockquote>
    <p>I don't use the fetcher because of its drawbacks and limitations.
      I use the same wget URL without the indirection over the package
      manager specific fetchers. I can follow the pypi approach to
      generate SRC_URIs which call a python function:</p>
    <p>${@crate_src_uri(d, 'xyz', '1.2.3')}<br>
      <br>
      But why you need this? In any case the manipulation of a
      dependency could lead to interdependence between dependencies.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:CADkTA4OA8VkQk=FVD=hMDaH+TU2567zLduVfYHSqkR_C4fpjOw@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote gmail_quote_container">
          <div>
            <div class="gmail_default" style="font-size:small">To be
              clear, I'm not suggesting that mode would be the only
              mode, just that the way the</div>
            <div class="gmail_default" style="font-size:small">generation
              of the fetches -&gt; actual fetching was constructed such
              that I could avoid</div>
            <div class="gmail_default" style="font-size:small">&quot;short
              circuit&quot; the handling of the lock file and simply list the
              dependencies for fetching</div>
            <div class="gmail_default" style="font-size:small">(much
              like how I can go get all of the SRCREVS for a gitsm://
              fetch, and put them into</div>
            <div class="gmail_default" style="font-size:small">my
              recipes as pure git:// fetches if I'm having issues with
              the git submodles).<br>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    Add a function to create this file isn't a problem, but I can't
    ensure that this will work in any case and doesn't create problems
    because of the discrepancy between the manifest / lock file and the
    available sources.<br>
    <br>
    <blockquote type="cite" cite="mid:CADkTA4OA8VkQk=FVD=hMDaH+TU2567zLduVfYHSqkR_C4fpjOw@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote gmail_quote_container">
          <blockquote class="gmail_quote" style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <div>
              <p><span style="white-space:pre-wrap">

</span></p>
              <blockquote type="cite">
                <pre>That file would manipulate the standard SRC_URI. In other words still
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
              <p>What is the motivation &quot;to short circuit the processing
                of the lockfile&quot;? Like any task the processing and its
                output are cached via the sstate cache.<br>
              </p>
            </div>
          </blockquote>
          <div><br>
          </div>
          <div class="gmail_default" style="font-size:small">See above.
            It isn't about re-running it a later time and re-using the
            artifacts, it is about</div>
          <div class="gmail_default" style="font-size:small">having a
            way to make sure nothing is dynamically&nbsp;resolved when
            bitbake &lt;foo&gt; is called,</div>
          <div class="gmail_default" style="font-size:small">just fetch
            and the rest of the standard tasks.<br>
          </div>
        </div>
      </div>
    </blockquote>
    <p>The resolve always create the same URL like the crate fetcher. It
      only changes if you change the resolve function or the crate
      fetcher. Every needed information is defined inside the lock file.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:CADkTA4OA8VkQk=FVD=hMDaH+TU2567zLduVfYHSqkR_C4fpjOw@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote gmail_quote_container">
          <blockquote class="gmail_quote" style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <div>
              <p> <br>
                It is possible to use the vendor package to create a
                include file but we should have good reasons to support
                two solutions for the same problem.<br>
                <br>
              </p>
              <blockquote type="cite">
                <pre>If that just doesn't make sense, then if there was a way to copy
the lockfile out of the recipe and have it overlayed onto the fetched
one .. maybe breaking out the individual fetch lines isn't required,
since they could be individually manipulated in that lockfile.</pre>
              </blockquote>
              <p>I haven't test it but this should be possible. You can
                place a lock file beside the recipe, add it to the
                SRC_URI and change the XXX_LOCK_PATH.<br>
              </p>
            </div>
          </blockquote>
          <div><br>
          </div>
          <div class="gmail_default" style="font-size:small">Something
            like that is a big step towards having that finer grained
            control in a recipe that</div>
          <div class="gmail_default" style="font-size:small">I'm looking
            for. I'd still like some sort of line by line &quot;dumped
            dependency list&quot; if there's a</div>
          <div class="gmail_default" style="font-size:small">lower level
            protocol at play (but the lock file really also is just that
            line by line list for many</div>
          <div class="gmail_default" style="font-size:small">of the
            languages).<br>
          </div>
        </div>
      </div>
    </blockquote>
    <p>Why you need this finer grained control in the recipe? You have
      the finer grained control in the lock file and additional tools to
      manage the file and all its interdependence. The resolve is
      deterministic and the .inc is only another representation.
      Manipulation of the representation could lead to problems and
      complicate the process. It's like you translate the .am and .in
      files into a .inc file to influence the generated automake files.<br>
      <br>
      Would it help if we have a devtool shell so that you can run
      &quot;cargo update&quot; inside the folder created by &quot;devtool modify&quot; to
      update dependencies via the common tools and create a patch?<br>
      <br>
    </p>
  </body>
</html>

--------------xuFmCGBi8fqgvsrF770AzCmY--

