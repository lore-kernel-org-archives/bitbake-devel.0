Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35BCFEFB5C
	for <webhook@archiver.kernel.org>; Fri, 27 Feb 2026 15:05:22 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.22])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.97881.1772204716344258497
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 27 Feb 2026 07:05:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=QGrkEaQm;
 spf=pass (domain: cherry.de, ip: 52.101.66.22, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nnOMVPsfjZtDiuLOvAoLAoLzTXOBYxDqf0YK7FEj0tfF+QVjXtTNzR7Bg/pg75iQa1iZx3FQFUfRj/+L45BT33bO4MrYGXKUDs0YjLPTL3ZBVUhhdMjrMSDTldUKnsQqqLS4DuGKy1czm477n6DkXvyCKdK7w8QvqybeJ9NlmoW205B2pTagv3lgHnCA02ngDHHKlDj9msLsTdxpvR0xrf5S+g27fPQ7wqNDc+Wuc08Y6wqU78kAZm93RMMFNQ/wjPuTgaR8b8y6leK+kVYbqFuHG/C2r6Qgg+uNSO6BYV8+iyPiH3B6gEZpHpWY/qeGj+8lpSf0Qz/jcwbg2440eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MY1MQFLYDx6ZDQpEBCj+YL21FEKW9dz4DXoy1FGgz8Q=;
 b=ykuWgMUbw5UihWx1D0RQ7WZPi0XkpR4O6xFBbPWYMmh2vMQLriHDSXGiFHK5QbBzLlv4X6gWNoAozy2Q52N3Nx/hmu+eItS89OdPm9JM9hTLt8bPugIizNa4vbdazO/Jhb4llnqBhvm+qABoTlMgMUMLtwry+bBXT9ODuKicU+HrTQh5Z3Krm6KGKPSGv2WJ8fXhl+AisPZdy5FEpn9e0QfZ8dRCeLzxbzSMuhjoWbS1wZzaGnwc+FngX5FEkVuIYQc1v2Kc0AQKPa+n5SRe73jADHWEa9hTAJ+JsDcX3rr/ZOuBaPhOwGTaNSbkMaHO/qxFotlWp6BmLlv+MtOGrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MY1MQFLYDx6ZDQpEBCj+YL21FEKW9dz4DXoy1FGgz8Q=;
 b=QGrkEaQmPgVYLAxuyn9H2uNVEx/cw5oWXYZ/M6GSOPenF7xRStFnm2325AX2bF3j8GRl+5p3uo9bhOLGQbbVFvWUJB/b/nbvC4F91+A/PB4/ZYkYRuwo7WWONOsEy808e+d2U2lVFDisLGurMsW/BH72GDzkuNSUvwsyefNKXZI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AM7PR04MB6856.eurprd04.prod.outlook.com (2603:10a6:20b:108::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Fri, 27 Feb
 2026 15:05:11 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%5]) with mapi id 15.20.9654.013; Fri, 27 Feb 2026
 15:05:11 +0000
Message-ID: <21748143-bb17-43b2-98ce-e296f126e00e@cherry.de>
Date: Fri, 27 Feb 2026 16:05:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] correct small number of "Bitbake" to
 "BitBake"
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
References: <10c820e1-5872-f256-d5ad-13316afa6d19@crashcourse.ca>
 <f250f160-a76e-486a-934c-52f0496fee3a@cherry.de>
 <0b1db344-464f-94f7-6345-cae207c29402@crashcourse.ca>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <0b1db344-464f-94f7-6345-cae207c29402@crashcourse.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR4P281CA0371.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::7) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AM7PR04MB6856:EE_
X-MS-Office365-Filtering-Correlation-Id: e56020a2-dbb0-472a-5eea-08de76119a4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	FnBY6uJwoQGfquf+gFEzaHO4GPkIWFL/cBbZWlMV3Oa5lcPMUIrEPqHmyh7P51T/yvpkxx6F+yv35ewQz3TJJyglc0vQzabaO24UTAopxSzVfbLtV2tcQD6hE+3z6dW/lfIXAXoJO54R09qsIbMPIE959rYQdm479i7VKR8oesJMvrvckR2TPnx4QNQXNPMBcGRS1iM2FFoJFumKgg9FJmCBRUW9s5l1Mx4PM6nWevHd/wsY/XkfXjUp6IU+zWmJUOAkZyjhy9wKcghLGA1i8ugWs86NaxfPY4np5bxThAcrIBZUXgMJ7VObV4DGh51Sa1YOSeu/h2joEFLV6AYNaihDTG1/s7+rSs5DXlQjUT/0BjvV4+XzEaHZ0TE74Y3XmF5+9o/o1725mR0PlPj9YtuyAI4EKkyBj+nT8C2nhRjGdNmvgEk5Llj01jSSIwlODrH3OPEnfWQQSatAw3hSxA9foHMFERmM5qCvvlbXh4BINiexb1SYo5AAhO4WuRByu/1P1//Pe1N6HBewolYfOlCsyemzGH1gus1VtV/qpMXoHJgG+wKqZgZV21tNiSumzOdg0ZJiUF/g6Y9CoKLlhTNBj2U7sszYxd1whR1funVV32Hs+KEvsXS59DzilTNtiyMpKmnzNyRsV44+fMhLsWobIeo5xTKgJ90MAmjQx1UPn5XIVruxdlkkDzQYZdTM
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MkFKTGRPT1VkUDdNMzBCRU1iVjFIWjBJRHl0K3k2aEV5Z1VFcnFETkYySnd2?=
 =?utf-8?B?TEpWdU5Nbkk3VmJsSzYwaGZYeW83WEZON1lGSjRFdm1JZGttNEo3Wm1HclNL?=
 =?utf-8?B?UXprVjdacEZOZW1jRmNhMWZRQkE4aHBxb0xjRW1HbCtWSUpta3lieU14TjJm?=
 =?utf-8?B?UkxrcmJOdGJ1QzNwV2o2MUI3QW5ZM21jSWRSS3NwdkgrZWQ4UkY0OVpkaGta?=
 =?utf-8?B?bWF4SnVOWG9RUGtibzFtMU5oNFBDMndaZVJjNWJnaDBsV2xlU1ZERExEakNk?=
 =?utf-8?B?enZoN0NzR2c5bUdDZE5Jc2llUzRId3k4QkdIbUpDYnZqUGRPOEtqdnhSYXlB?=
 =?utf-8?B?Y29lc2dzajdFSjMvQWZFTE9HU0VCOGRDNUVpaSt6dU9oQnByM3ZMcm1DYVVU?=
 =?utf-8?B?QnU1cGRYeFVJK3ZWMXBuWXhKZi9SRG45SnNmNG9rbU1WUC9pY21EV0tuYktQ?=
 =?utf-8?B?blFEQWs0bjBpT3lFeDB0ZDZnZURzUmtCem1zSlZ2RVRWSkdZOW1aWVJ4UENC?=
 =?utf-8?B?TWhGR1VlQW1qd2RoSnREa3lTaThYanpIajF6TkRxSFdrZWZBY2txb0JMRGlY?=
 =?utf-8?B?RGtMZjRLQklpT2F2UG9CWVExeGNkQVFQYndCSGkwVVRPeGJuUGhrTS94M2RD?=
 =?utf-8?B?bWpHMHpWeTlYc1lYUklQTCtQSUVWV2pheE13cmIwcmRwVWgrYytQRW9GZEVU?=
 =?utf-8?B?MkU1OFltUVlvajVoK2pleGZpTVVxcy9QOVlxdTdjRVd6SW95d0hrS2JMeC9J?=
 =?utf-8?B?NVNvOHlYbGVCSXNnVTRTdnkyenc0Zmc5TTFlUGI1OWQ1MUEyZ1RydnhjbzRj?=
 =?utf-8?B?dHF1ODNmVkIwYUladkZDeDljOXF0VVRzUEE4ZWx1b3A4VStQNUZjUVE5WmFY?=
 =?utf-8?B?N21KR3dwSzdkZjBCQzlXZWllSGxodGk4VGJjVU9MNU8va2MwNFRsYXlFT3kx?=
 =?utf-8?B?aUY1RSs2ZFB1L1ppZWNpaXhoaUdUZzhieFZYSFpMOWZ0S0hjMW9DTVg0cWNZ?=
 =?utf-8?B?MlN5UGhFM1dTRTdCSWlvekdrakxHT2Z2RFNScGdNcmlrRzM3cnVCUXJVZjY4?=
 =?utf-8?B?U3dsVkdYaE5mc1ZlSCtyeFZiREdEekh6N2N3dkVyaldXVlY5eTFsaklVcUhj?=
 =?utf-8?B?cFpmVzJKczRwMk53dkx1WStHZW53cnhWWjd5ZjBVMHc3cnRSMXR0ajNRajVk?=
 =?utf-8?B?UUdQYmZSZ2FKM1kxa3JGd0tSbjN6NFhSVjlHYXc3OUZ4MmpDMkl0YnhUVGFM?=
 =?utf-8?B?anQrL1BEeWxIRERVNHA1SWx4Zm4zR2J3Tm9MK1psOVJqcTJmZFVKbnUwanlo?=
 =?utf-8?B?MUt1VlRyLzJFRk9EbjAvSEhGRk9uWHV4THhRQzYvbnNYZlRabnlqUjI2cjZP?=
 =?utf-8?B?WTBWYXFibnRzeUFRODFoNkpJeVlRQmRMMWFUTTFVaEFobm5uUXhpMzBoc015?=
 =?utf-8?B?UGYzbmZCL2JyT1Ztb3FOdklkWnpmZ01mS2FtL1lCMmI3SWhlZXh3ZHUyL3lk?=
 =?utf-8?B?ZmpyTFBRc2tYNnZ4WldFOGtyWHJPRlNVWFpUbUpkbmJLb2c5UWRmcUtwMjcx?=
 =?utf-8?B?VHlzWmlyVHNSaTJlTDVsUVowK1I4NDkxUDROdFlSOW9TZVNTTFRQc0l4Mlhk?=
 =?utf-8?B?WWVqOW1KMEF2MGpXVTJTT3dzdEdLMndLMm5zTTdIam1vY3JwcEg1UDRDdUs0?=
 =?utf-8?B?Ymw3UEE4b2hKVUlNRXZXTTc0R2krTWEwcUE0Rlp1WUxxVXpzTW1vcEVXVDlm?=
 =?utf-8?B?VldMV1Z6WitUSU5nVUgrVGVudzJKQzFtd0IrWGtaZlV1clJ6cXF1VEJlUUdZ?=
 =?utf-8?B?L1NmRkNYNmZuc2d1aGlyWldFd0ZERjU3S3REdlN4WURBekx4Uk9GdU9aUWVk?=
 =?utf-8?B?UlhBSzRlL3g1MmJWQUwrdFRUdGZpWGFrcjVKWHkzdXhTUTBxdFgzc3NGY0s2?=
 =?utf-8?B?QTB4bFB0Q0FobEFxTGE0WHIrMUtmSFVKVFdBRjA2OFgxaXp1MFI1bmlaRlJ5?=
 =?utf-8?B?dWVaVDJTNTVPcjBRbndTVDFEQ2JXNng2NFpnZjdmcnRoRktUTW0wakxiWTNm?=
 =?utf-8?B?TFdEcm1PT0NBTGlpWlNJVHJTNlA5d1NjYVYzQ1U2NXV6eCtMbVZMOGJrSUZY?=
 =?utf-8?B?Slg4d2xpdkVoaEQ3bGhWVUcxMVc0RkJFUHY5aUVCZEZlN1hxNnhNaVRFZ2RJ?=
 =?utf-8?B?QVZPN0sycEtkQUpEUkdrMkhzemxRVDFGNEpWM2s3T1ZWdHM1Q2Nsb2VacG4w?=
 =?utf-8?B?NFBHb2dmMXRQQWx5UUpJeWVseE4yaE9KSjVYOVVoQ2luNEUvb2VPSWpGTWhl?=
 =?utf-8?B?M2pha2pROEw0ZmlRRXBKL2Q3Qy9rWTdLdjVOU0hSMUU0c2NYdGQ2QT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e56020a2-dbb0-472a-5eea-08de76119a4f
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 15:05:10.9702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Guvr0IXQbq1LWLaGCC4PLkIF7klmucjiK3haNBDh1DeSyOlmcAWrfkyuDksW3UnR6QR6GM8+l7/Fo+Nq3mm1R26/AwrsLfKttZ/pUIEHMyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6856
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 27 Feb 2026 15:05:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19093

On 2/27/26 1:20 PM, Robert P. J. Day wrote:
> On Fri, 27 Feb 2026, Quentin Schulz wrote:
> 
>> Hi Robert,
>>
>> On 2/24/26 6:20 PM, Robert P. J. Day via lists.openembedded.org wrote:
>>>
>>> Use correct spelling of "BitBake" in a few places.
>>>
>>
>> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> FWIW, we could "enforce" that by using a substitution, c.f.
>> https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#substitutions
>>
>> .. |bitbake| replace:: BitBake
>>
>> (e.g. in rst_prolog variable in conf.py, c.f.
>> https://www.sphinx-doc.org/en/master/usage/configuration.html#confval-rst_prolog)
>>
>> And then throughout the docs, use |bitbake| instead of BitBake.
> 
>    except we don't want that substitution if using "bitbake" as the
> command name. it's like referring to the SCM "Git" as opposed to the
> command name "git".
> 

Sure, but then we know for sure what's the name of the command (use 
``bitbake``) or the name of the project (|bitbake|) for example.

Only an idea anyway.

Cheers,
Quentin

