Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB258C4167B
	for <webhook@archiver.kernel.org>; Fri,  1 Dec 2023 10:00:25 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.47])
 by mx.groups.io with SMTP id smtpd.web10.19490.1701424816282508669
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 01 Dec 2023 02:00:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=x/Wo2Xb9;
 spf=pass (domain: siemens.com, ip: 40.107.247.47, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddPGDwNHydzNR4mrOm34a2h7B9JgYj4sfcY+B23+SfxCwK+Yl1nSTOQpbKmGbwYOLy2nt1P+HGwA/b49n2cgvjhRaBWr7/hllT0pDw4zc7UZr9NyL8i+5Yluwk6+O+V/dhpMcxhejGyi/0KTWrUZ2+gVOHrZI7DxZoMafA8rGnLRA7kydDFgpJ7K8MNyjg2yTUDW5wuAnRonXhpSqIdY25CRpYDOmwNzk8qWLsK+220nWKHacxyLjGVhVKESpP30gIbnbVCojI57Xrcm36P+tLqcYMRnsNPYS84A5UIVG6Wrxipm6QpwvEBIeCbtKby8V7wNMuf4+P4kB90/+aU8kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xvpCG6tQyGrfvcwDqIg47on5Ql0vJFDyATf5umobWxA=;
 b=WIiLj5k/68SkDWXUVN9ihfyhiNizQdFN1V8SgRfWKkAHWeUNfQl5QblyUHYrmu8Fo9prY9PdgpY+2ZD+3j2BChMByWyQ5Mq+8wtm+/pdi5dgVFfPaAM+qvRf3Tc5phkKUHIbS83EuIamURd7PDCMCGFw1O0HZzuzCaG6ZfnHSmJi5Lu2oYRJ0qg2MpXaQoJI65eGEp3cv78oVdo/mkTaOCCIe62PBPZA0d4kkZQfd6NMVkyxSzobYO4YTO0JlkfHyn9RvdVYxoIbGKPN8QrEI99Lx3mFxHMCM4AZHFKU4HP80twcfgSfm/TnRbSdL3LJ/a2sVBuUOMP65xEIwug8IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvpCG6tQyGrfvcwDqIg47on5Ql0vJFDyATf5umobWxA=;
 b=x/Wo2Xb9seqLfKFdFfda+0jJxA6y4lmIV3vgSop91WwjW4U67iHCtptPA/IOVacTNhi92PjJ/jfDQaq6YIz5PXVnxzVPhWU5L7id+VEDIdbgZkXcNUUDng3j2ayRGp7FYurPWdb5XUGTIyljz6C74HPhSDzee1iibtMBq+PZPVaFHGWOWyzXq/J2KJXM1Mu/7cYIa05S+JMDn3WYf+NC3IygbQAWgt3fjpcnkG/qX63u4taeZQbHr1Kz9Zg8VLCLhokpaj5VZn0ZiumCCFQ84ZRG2Qfvu1yHTWVk7yNA/lANkW12PGo5jC4pRTH1CYTpXcf+cm+k9sJDLDd+S2DXfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB5998.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:52a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 10:00:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7046.024; Fri, 1 Dec 2023
 10:00:12 +0000
Message-ID: <9a26d9a5-980f-402a-8b7d-bdf5644f3f50@siemens.com>
Date: Fri, 1 Dec 2023 17:57:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: AUTOREV, PREMIRRORS and unavailable upstream
Content-Language: en-US
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org, enrico.scholz@sigma-chemnitz.de
References: <5628c725-4b70-4db0-8db6-254d344b1e70@siemens.com>
 <d93bf7e3412237f73025b0749391d8aa55e9bac8.camel@linuxfoundation.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <d93bf7e3412237f73025b0749391d8aa55e9bac8.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB5998:EE_
X-MS-Office365-Filtering-Correlation-Id: 8308c6c9-2ddf-41a9-c6ce-08dbf2544f33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	TI/wh9U8HfIPxPrHKA7E4Y+SXIgoaJVLH24EhUIUMWU3XqRUsidbjgfQm/HWTG2MoPsuYbw1TtMOSeb7Q4T7mUrn//Cf2+JbyrckBwGpsL4XxJS4JEgtUxfWz4N9WGZ6lEBO13JE4dVXpSW1OsuEGXFkL0ZdWLLYycuZMRvT0FzSUsXBqFKnAbmYJeZFZGmusxGIfuWsJymSdCEwHl8C12rVRoNG3Lt6reKsnUIAl1g77IYOmPaNzufV1nPefotOt9f/AOM3qTKD0cmwxRmSJAYCG052munjNgROUL0eQSdkb0UucKOI7kTXaH74KZiei3vFrr7fFmBHC1LIniD+WA6XQc7TsL2K0l9dAQj66O9eos3Zz6y9Zmzq2mrfeEc24WQcuIA2VFPbRYI8eyjQtj+8w3BABcxG/W3AduqZ7GzpbsNMFSmlcrt5yYf7Fa3ryGxJz6lE/YOZZOtYFYr6Vjq/Ek/Nss7+fDvFGtont7SHA6kyPiimc2IwpRPENPw0iRgdPpSZv0A32FVhKgOvv/eTBW406qZ+pytMJZoH/eBv3njJcS4PIWGBjBx6cT32hH6pmGYiXRINmRuukSUNwr1m5CoVJM7di2hWON7ugThiC5jSpA2pluwB11ewx6pr2/3fUJ5Il/tl222BUIr5sg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(396003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(82960400001)(86362001)(31696002)(38100700002)(36756003)(478600001)(6666004)(6486002)(966005)(41300700001)(316002)(66476007)(66946007)(66556008)(26005)(6512007)(2616005)(6506007)(53546011)(5660300002)(44832011)(2906002)(8936002)(8676002)(31686004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZWtBeFFDSUpRVzVYVWxSR0tEOTZrYUNkVnZuNVpYR0s5dkk5Y0Z3VWVkaEw0?=
 =?utf-8?B?T0VaU24rL0xrM0krL1NpZVRvTnBqclU3VllJTkZQMVNLTTlmVTUvYmtSTmxT?=
 =?utf-8?B?ZXVRdlpCWEVKZnpvdjk3YzdkcytpbTlqdkwrVlNMUVlTdkdEMnIvT2lpWHpw?=
 =?utf-8?B?NE1STEc2Vm9JSWV0L2lyYzhDZTBOUHZGVENDNkp6RUxrZUJSa0JZTmFheDJI?=
 =?utf-8?B?Y3drZU4zNWpicGxPa2c3TjRMU3B0RWhTdzFjYzVoOXRpSVNSbXo2OVYyWmRn?=
 =?utf-8?B?UlVVNUJ6SEZNZ3k4TEl0Z2ZlRnN0cjV5NEY3VitWczJXWkdWSXRTSVdkdzBt?=
 =?utf-8?B?NS9CcTF2cFprZ21TUDdqb3RmZlN1T3hPWm1EWjBkNFBvMTh1ZVJoK1VhQU81?=
 =?utf-8?B?MjYvN3FISXZWSUl2Q2ErSVNRemlLamxRU2l4SjBSZTBBVWlEbVJVUWlzUlFq?=
 =?utf-8?B?cGN1eWpOREhLUXp2T3V5U1VOcXlFNW1lYVNqM0djVEQ3MXptK3hrOWdad08y?=
 =?utf-8?B?dDdkLzNhZ0Fwc0MvNEpackZ4R1NzTEpMUFkzN0R1Wkxmcm9vNitjY2FZMTNm?=
 =?utf-8?B?cnB5aWxWa29DSFh6YW1TWGRHTGk3N3ZJWjVPdGxyY09pYnh2b3RSWWkyWTZF?=
 =?utf-8?B?elphWFV1RjlDNEhXbUdvNS9ONnQrd2d1MDM5VWJiS2czaHNhRVZJUElwTnFO?=
 =?utf-8?B?cDRhYytic2xZSjhnQkNONk5TN00wakpVVk9ucXdGQTRwWTZyQ2NtaDJGbjRS?=
 =?utf-8?B?cVZtZnI5czY4cnVibExvdEFMSHJqNWxuVlpyZU1Ja2pMMTdUcnpGcmVlN0p3?=
 =?utf-8?B?S01iMCtPcTRuSXc1Z0FOVEVoNXdwaExTcTNwUkhGa0Z1M3Y3QTJYR0xLcC9O?=
 =?utf-8?B?SGpKSzdhVGtaTHFqZ1hTa3poZTVITUJmKzBiUGRDTVFPN200V2NoTlVwUjNC?=
 =?utf-8?B?MWlOc3Y0RGowdmVZWWduNGs0cE1QNUJhT3hocWhvNG56VFhXNC8zU1hhd3Fl?=
 =?utf-8?B?dXFISFl5dURaMFA5RFlRY0lKV1J0ZE1CZ09wNnFBWG1KOXpwK1BBbWVnMUhM?=
 =?utf-8?B?K01zQTBVUlRmNms0UmIrTWdGcU5HNjd2ZzU5S051clRGMWdoNlVaU2hnTUFE?=
 =?utf-8?B?dTBwNVBXR3liU3ppZFVBbzBENFRrUVhBZnpHaVRFY0Z5OVNrdGt1OEZ1U0po?=
 =?utf-8?B?alkrenVEeldaQ1JONTg5c0x2YlprUHlkYzRVK1VHeEJncWgrQUFCSzkxakxL?=
 =?utf-8?B?UUVqZkVrcVJoaVNxUWVBeDVtMUZTL0Rzc1R0b05jam5Celg5alZ4TTArZDE0?=
 =?utf-8?B?Vmt3alFGOHQ3WEt5bzNaYTFvK2Ewa0pMcGtMNzhUOXE0bWp0TVFtTm8wZkVH?=
 =?utf-8?B?ZUJWV2VidFJFRWwvM0tzK080RlU5SEVRaTV3RW1tZnVjSENpZUNRYVVQMXFX?=
 =?utf-8?B?dlhKTk5ubCszU09uRk1EMUl4SjUwdUFXUVJDeGQ4TkFKMCtNSStNSVZZQ2hk?=
 =?utf-8?B?YUlNYWlnZHBZRnljUUFuSithVU9nQkpIYlhLM3pTcGhZK0F5RStua291a2h3?=
 =?utf-8?B?SUdkejNuckNKVU5WcXowSHRObjJaWjBmTVA0a0w3R2V1TzQwdDRydUJyaTRG?=
 =?utf-8?B?K0FmNnp2ZUYxL0h2d2N6djhwK2NQUDlhUkF3TVUrM0xzM0FHTHhVaTJadkRD?=
 =?utf-8?B?Um5LcDBvRWc2elpMakFiN1BkVHF3L1ZyTUpMVGNDSnJnRFJEYzk4Z2pvNXRQ?=
 =?utf-8?B?OU9zQWhQVW1kMjB1Rlo3Tkt3eUpiSk8vblJueUN4S1FxWU9sVkF1YXRyeHVB?=
 =?utf-8?B?MEVrd0x6WS9TWngzTCtkNVgxRHV0SGhER203YjBYemwvVmZHNkVURXRmUklP?=
 =?utf-8?B?Qnp4dnFxb043UHBUeDg3dm5QdlFDR0JKT0FwZ0VHRFFqdFBFSmh1VndYUTA5?=
 =?utf-8?B?R3BrSDZzNHU1VHJZOVd1MHVqanZ0SmpSMXJ0NUdRSWFCbXZ6Rlp5QWZjZXZB?=
 =?utf-8?B?ZXJ1dW84a1JQY3E0b1pjK1M1bWRmTmU4TmFvN0cwenFmQWMyWVlnVEhFbnpP?=
 =?utf-8?B?MWh6aXBkSGd1NkhjcjRudGpJVU9uV3RnelU4dkphRVFyVjdRRTFtR3N2ZElH?=
 =?utf-8?Q?dzoPjPAzsQmhJofzUsUhBZQuN?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8308c6c9-2ddf-41a9-c6ce-08dbf2544f33
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 10:00:12.5770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bVHoD8cODobVUTQez8+dJ0jWf36lNXcoVRSpnSRO4hJV2EHeXhapsKwTnCvi+0yO69GdlAwGYxU6/kVSM3vTwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5998
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 01 Dec 2023 10:00:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15597

On 01.12.23 16:27, Richard Purdie wrote:
> On Fri, 2023-12-01 at 12:16 +0800, Jan Kiszka wrote:
>> Hi all,
>>
>> this topic has been discussed already long time ago [1], but I don't
>> find a conclusion that helps when the original server is unavailable
>> (like github.com for me right now while staying in China). What is the
>> right answer to this?
>>
>> Jan
>>
>> [1] https://lists.openembedded.org/g/bitbake-devel/topic/72112230
> 
> 
> AUTOREV is defined as "get the latest upstream from the SRC_URI". Using
> mirrors would make it inconsistent. If you want to make it work with a
> mirror, you need to point it specifically at the mirror. There is no
> guarantee that any given mirror has the "latest" revision. YP's own
> mirrors will only update to pull in new changes when something
> references them.
> 
> The current code does work correctly by our definitions even if it
> doesn't do what you want/need right now.
> 

So, PREMIRRORS is left behind unusable for redirecting from unavailable
to available repos, and we need to fiddle with the SRC_URIs directly.
Not so nice. I'm starting to understand more of the reasons for Chinese
OSS projects to fork upstreams.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


