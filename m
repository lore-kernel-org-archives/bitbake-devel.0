Return-Path: <rasmus.villemoes@prevas.dk>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438C0C19F28
	for <webhook@archiver.kernel.org>; Wed,  3 Aug 2022 11:40:23 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.117])
 by mx.groups.io with SMTP id smtpd.web11.7344.1659526812214810017
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Aug 2022 04:40:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@prevas.dk header.s=selector1 header.b=Asyg7COf;
 spf=pass (domain: prevas.dk, ip: 40.107.6.117,
 mailfrom: rasmus.villemoes@prevas.dk)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOirgUYT2wxlHIh6KsTglORha1vwhDcHKDVL+41uHygLAQwUdS0ayDAUHeTWFv0ICZNeNnHE9zTLpvGH41HuEjy0rdAfisibkSbq2HkMn3BL2F0LzW7gsqWYlfqdube+wIPpgy50TVlh7nNkf7umSzJLBSchZBDhtxsnmcYS94Qy72rvQnUrx/5VXqMeiX5pYjI1K7jcwWwejksM2FK/sHvJ3r1zqc/3F59uZKKGnqkj+WEv0GdTQZuc8yUAa/JxPGdrqC43pQemrsVxk8a4YP4O6vBY5S1VNpx1IceEC4f9cZJQVlo2lvcXxMNLb2YmFt+lRnItyDcPH5bzED/Tzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrzCWGIuBbqyAAtONi2gg1QdsNxS8qussLirfpsjho0=;
 b=JZMDokNqw0fQcGAO0Yzs9OpruQo/YStupbi1HAWcSW9uS1DjJGFrZ/tJxfRblrKoBSUf/K4kmJ/b0oya1IywsKKBgPakeMGCA9SZNAZxeWT+7hqfboQsWqVGUm+9fUebv5jMi8OirtjuNo8iriSwH4N1dmoGmrEYEuHsmPD8aj0SJw+2jX/1I5kgIjnfPcHQWicNfuhcuCGlkW00VH/0C+hnkq1imGSY7KrDZRe1DHRfkEeXDLvUo6clK1Fvlw1USjIBoe0uVPJ8632ws0ZCigUCbg0Bm6mRnZ6jk4w6GjCXQZglyBZkvw5dBMKOy7WBL8gqlAU8C6j+FHGnlGO7nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrzCWGIuBbqyAAtONi2gg1QdsNxS8qussLirfpsjho0=;
 b=Asyg7COf+8wSHWI0iJQTUCd3X8AK9t0DaLm6tET6jEkjnk1H1ZpaHXNQaeUC4VzLuV5aAZpIvQVanXb7raflQB91cYaxJtR2f9cN72REseur+G9/jUKu4Yd674xBunv4JkWtDmjGgLVrUbGRRCYEo50kM1ArZ1VFOhAaGuJ6zWE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34a::22)
 by PAXPR10MB5160.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:288::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Wed, 3 Aug
 2022 11:40:08 +0000
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::84cd:fa2:ffc0:456e]) by DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::84cd:fa2:ffc0:456e%7]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 11:40:08 +0000
Message-ID: <29b6f80a-74e8-896c-d02a-cd584d50cfb3@prevas.dk>
Date: Wed, 3 Aug 2022 13:40:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [bitbake-devel][PATCH v2] siggen: Fix sigtask data not being
 renamed atomically
Content-Language: en-US
To: bitbake-devel@lists.openembedded.org
References: <20220801203418.57677-1-JPEWhacker@gmail.com>
 <20220802131405.318201-1-JPEWhacker@gmail.com>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Joshua Watt <jpewhacker@gmail.com>
In-Reply-To: <20220802131405.318201-1-JPEWhacker@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0088.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::19) To DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:34a::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5171c23c-7108-4c7d-e30b-08da7544ea87
X-MS-TrafficTypeDiagnostic: PAXPR10MB5160:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	uKNC2SKWU6h/BTKeaO0egqqPVT41OdMhYCPG1EeYUjStxR9WDM30DsPnbXA2psI7MGH7VHtipnDAyQUC2qVquJJ9KHfTABqNtK7CZvvjnK1x6gbwEGhyQ8dHsSQUwtsc/DeG2SM25URbNB4K1lOfX/7/aRpzD+koOb8WCCVuQ7pAnUVe324SfR62FUKoj/C6UCqgDhdy7N04IyOVc3xdE/z+ZNteOvF3+BMR3cVG4gPha/H6mICexqtjoLccMiVxPJ4DwbLRcDKEMPYlZNI5WEWqtfxvt4Ic6jJ0j9X8YP94uw3tV5YICEOCXGi0+aOJpU9dARLt6fC49zRWvKgAaxVit4qYm0IejAOGjIJVlRayrOMK/G6BbYGCQPDA5rx8BHecgAL19YOzkTc0MHDrC5wOpw4YZqbTGlW+WTVUrR/sBP0V3TNVx9i7VvSXyeY6C7V64u1N1c2jHZMjCcGoUltfJzCXUpXYYLGpqQFmc/DdLSk2KnlkDoTjUZNJ2Vkf3IsWROw4DsCrPwoJ3sOQot9mdJM6RuFajre479TBw5xwk047PXz5wDnCdPukobqqlNk/I8Ddee1tsLnXMY4COGJZncHLb6BwpUInYLsjnhFhV70nEbm+3/hmh34llu4IjNsFPQD33hHJZlXhUQITl9RvIpspOGFPKlSr4jjqhs6NaxAdUGTQ6X8DEqarrrhDtORhVkoIu725AA0igsKMR8KkAWDjpzLFAMjBDpCEOdWulIv2fA7KDulddM7o1gXT9eOKmKArdRjGBrkwSlI7GrAvCyzZSXyZ5S0KyDS1cfGYyoAej20T1DMLfv8N5j/7nxUdbSZNCHjbEo3nKIdsnCA32bJ6YBy0uOXSAGJ95ps=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(39850400004)(136003)(366004)(346002)(31696002)(316002)(31686004)(36756003)(86362001)(6916009)(38350700002)(6506007)(52116002)(2906002)(38100700002)(5660300002)(66946007)(8676002)(66476007)(8976002)(4326008)(83380400001)(8936002)(6512007)(478600001)(41300700001)(6486002)(2616005)(26005)(44832011)(186003)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UGxhc2oyRFUyZ2xXVk5pZDhDK2NlMkRSZEY5akVtNEtzYUJobEdaWVEvWGs5?=
 =?utf-8?B?eDZMQWgvb1Q3S1UzT3F6RjNGK1E1dFYvcmpMaFFCUmplSDhwMnBDTjVod1lj?=
 =?utf-8?B?clBtbkZZWGdDQ2xRbjVhT1QwMFZNSUh0RHN4L1hzVy9BaU9uUU1YZHhGZ2NF?=
 =?utf-8?B?SE1oYXZ0UU9NbG5xdW53SU1SbUVablJqaWxreXBBakJVT2o0dHNMbEdxa0JR?=
 =?utf-8?B?S3BIYWdtQU5UT0RyUkpIWmt6eEVxZXhrTmU3Mnp2MlNqQnpIU3o0U3p2cnkz?=
 =?utf-8?B?NWYreVgzZnZuN3o5ZnMyT1dXQ0hOQmNyaEZ2NjBFUEdhNmF6aCs0Sjl4dFpX?=
 =?utf-8?B?SGluU056TUFlVjFRL010ZXhtTkNUVURjNGdkdFE2ODZLTE5NYUhldEltV3pl?=
 =?utf-8?B?L1dMR1hPMlUySno3N2U0TlZWNTdlYzlUOVpKNUY5VlpLSlNMWFdGdTRsaDF4?=
 =?utf-8?B?SDYxMWRHZW0xTkdGY3Z4NXQwempRNFg5eWRrWTdNYlJzZ1duM3pRR0FvRy9K?=
 =?utf-8?B?UUZUZDgwcStFcTZvdU5RWFBxS0huV1YvYW81WFVHUHMvR0RzN2MyU3BIQVBz?=
 =?utf-8?B?TnJFb1Z6NFl2ZUswTElIaUtMMUo4VHdNU3NDNkhaSlVNZUs1QzZoOWwrMzgy?=
 =?utf-8?B?aFp0VmF0WVdwc3NCREhqckVVRDJURjZxdXVsN3QzeEVoekJGYVg1TEFwWEZu?=
 =?utf-8?B?THlSVkFKMzAxdFVwaW5Kc2Uyd05COHo3QVZjNmlWcU15NVFRWHlDVnFicURJ?=
 =?utf-8?B?ZzVOVXpTOEplcjlJYTFxQjJZK0hrRmdhdkY2Q2NNUk1OdGg3SkFlaFRyNDNs?=
 =?utf-8?B?NHJUVmk1ZTl3UlM0b2prR2ZyMVd1c3JSdlNxa2NDY1hBTC94VDBqcExyc1FX?=
 =?utf-8?B?bTk1aUxyZGloTFdSRFpUYVEvTUtKelZGSSs3ejhWU2ZKL3lKQm1kMmFYS3dT?=
 =?utf-8?B?Mmc0ZVNxb1Fzd3djWFkzcE1mWWNxdzVwRzIzWGJWS0FUM2JiZExNc3NQeDZY?=
 =?utf-8?B?cURyMHRrYVhkMVdDRjdXNmp4S25wTVFUVkFTbkg5Vmozd00xT1hTRDcwUUha?=
 =?utf-8?B?ZnJkdWRxczh2cUNoZWNLQlNQODNNMUNEVnBmZ240ajd0b0ZEenRVSVZ6VmZm?=
 =?utf-8?B?UE1KN2hERXJlYzFoNnN5VFNKMk4xdC9UQlowTWJqUnY0ZzUzT0t2YmlGSmpD?=
 =?utf-8?B?c2NVaXp6WTdodFNEYU9pVmozZFRnZ0h4Vm55TlQ4WUIyekdDMUFSK2NkdnVa?=
 =?utf-8?B?VlhldGdENVlKU29NTUFKdnR1eUlrbmw4Nkw5bFlOem9QMkdDdk5WaWxSSnJo?=
 =?utf-8?B?MlZvNi9RS21GczMydDl0eS91bTBkR1BCYTdoK1Y0Z2dTRkZIUHIyaTgzU3lm?=
 =?utf-8?B?Y0JCSjhMK3hNZkRkUnc3WFY0cElyZ3BqOXdhSEVNT3J3ZERqWU8wT21qbGJp?=
 =?utf-8?B?elBLWW5COFpUcXZmOTZOcCtuMXNvdDE0cFB4ZzZFZ2x4Z1czZ01JL3pxWmF0?=
 =?utf-8?B?eVplNGo2UDNYdXlrc2k0Q3RUdTdURXR4bkxhZWh0U0VMem1jOGY0cjRPbXQz?=
 =?utf-8?B?enR2eFF5ZitZZk9HM21MRlZPNUtYTEJqeDZaNjQwVVBYNzBLVXdPdTJiUGVJ?=
 =?utf-8?B?VWowbGNvRXpwRnFmdlFNWUhrSWFESzBudmlPRkFjT1hDL1RDS2tVa1FNUksx?=
 =?utf-8?B?SHIzaG5BVXhlTkJUakZxbnVzWkw5VXhsL3hrRnFwdXU4VlZWQmV5TkNtb1k0?=
 =?utf-8?B?cFJJTmJYNTlJTFM2SHpidGUvUStXMHZ2KzVtcERtWXpldHA4cnc5emZUaWFv?=
 =?utf-8?B?K1hySjUyeHBzVlZqUjQ1WjJUd0paS3lwMHhtR0tCdzRZRmN4WTlybkNiWlJj?=
 =?utf-8?B?ZjZkN1QxQ1Q5QjBReERvRWNEWmFmUElxMWNnd2VXeW51bmNrYlF2V2dmKzJ5?=
 =?utf-8?B?VHVaYXd3YllDc2lWRzlsbHUxR1Q5ZWdsZmNmQjRpNzZxQ3dZTUVuZm9WZnEr?=
 =?utf-8?B?bzdGSDB1VnZTRTh1dnZOdHNVYWtvNGhBVlFuRWwxWE9VYlhHWXRwWkRCUmVr?=
 =?utf-8?B?V3hBcmlxSjJ2QjZkZ1pkSWNzb201dFdLKzhZQk42M3k3YXJIeDA3dmtBVUlM?=
 =?utf-8?B?a3lhazI4NHpIek8ybk80Y2YxQncwMW1MSmU0MW9XRjc3SmY1Vi8vK2NhOGRW?=
 =?utf-8?B?aVE9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 5171c23c-7108-4c7d-e30b-08da7544ea87
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 11:40:08.1220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 EKNVmVySaDtAwUg3JA1AqFHhgpIUkrnIaWFNHx2BDJdAJQycktQnIniIWvD+2h2lYDPmzJkLn144kghZmuda96JbJVLNC/iJOHx31XUgEoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5160
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 03 Aug 2022 11:40:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13865

On 02/08/2022 15.14, Joshua Watt via lists.openembedded.org wrote:
> Signature generation uses mkstemp() to get a file descriptor to a unique
> file and then write the signature into it, however it closed the file
> before doing the chmod() and rename() operations. Closing the file means
> that other mkstemp() could potentially open the same file and race with
> the chmod() and rename(), causing a error. While it may not sound like
> this would be very likely, glibc (at least) generates the filename for
> mkstemp() using the system clock, meaning that it is much more likely
> for highly parallel builds sharing sstate over NFS to encounter the race
> condition.
> 
> To fix the problem, perform the chmod() and rename() while the file is
> still open, since this prevents other mkstemp() calls from being able to
> open the file (due to the O_EXCL flag).

Eh, O_CREAT|O_EXCL should prevent opening an already existing file,
whether somebody has it open or not, so I don't see how another
mkstemp() could end up opening "our" file. Unless O_EXCL semantics are
broken on NFS and only work by accident when the local client does have
the file open - but what would then prevent other clients with,
presumably, the exact same system time from clobbering our file, whether
or not the chmod+rename is done with the fd still held?

The patch is probably fine (as in, shouldn't make anything worse), but I
think it would be nice to understand just what the problem actually is,
and if this fixes it, how.

Rasmus

