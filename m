Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550B5C61DA4
	for <webhook@archiver.kernel.org>; Mon, 13 Mar 2023 04:57:22 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.12729.1678683440284587053
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 12 Mar 2023 21:57:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=jp1rtCsF;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=24369dce88=qi.chen@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32D4rLuf004081
	for <bitbake-devel@lists.openembedded.org>; Sun, 12 Mar 2023 21:57:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=message-id : date
 : subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=LvUOAMYFh7YIDwSSB5zIj6u1YGWUhoMvVMhYRjoUxeI=;
 b=jp1rtCsFaju181FAqoC58LOrSFEBdVGNdbPiDuYqCJ4l7oCNHWmVxXpaZC3ms48Yj2b7
 P/Ca5z+RDgWAwitglRRGHrVh8lAMZpgvRbQhLcMehjxhyQqSqPFbUBFBf5hWEkHuIVSy
 LPlGg5QvDILm3TfHW2hT+75x7gO8B6cARzCY4IaaiLGgH0rKM3eVASyTcAJ1w0uzGv5O
 0yHQM+7RWZQOSnXS7NJ/rvVdmrLnQBvfTu4dAtd2aWGAyQC04aLy6bWaZqFsZ826m0BO
 3UNuigWrcF1W4rZ2IzGy7X5IUCL65G1wU0hgSwakq/bntpY0z0kmosx/1cHPvmvkKlZr BQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3p8t1r14ex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Sun, 12 Mar 2023 21:57:19 -0700
Received: from m0250809.ppops.net (m0250809.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32D4vJ9X010437
	for <bitbake-devel@lists.openembedded.org>; Sun, 12 Mar 2023 21:57:19 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3p8t1r14ev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Mar 2023 21:57:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yzv20/JuYbNIMGGHPFwqS3SRGBjViRyPj5f12wPO0vENdA45AU2KhaEgtuF6lJe7mH2NMd67QYpcM2RjLGz+4Rwe9NTGnrq8md8gYTBYG+Fn+PSV8fhD9fjZA+jpyet9TLV3qCgaY7FxSwPY9kTQXygC9FBul2j7T4u6rVsxIQ6pit/sphTvRWYqK1caEXsAMH+jHeD16qZVBQ4Hs9HWnOPUeHfGdsJ7pf6YwZD0I08NXHuS/zbnxnojlvuZWpdFUGpKkIje3ts3+U8bCZADMoyRn4BILVMcTXfXhQzJ6asYAcgPGTOtwN9qH5A5rgY8BzOI6NWwGOo4TP1WwmkZFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LvUOAMYFh7YIDwSSB5zIj6u1YGWUhoMvVMhYRjoUxeI=;
 b=HKfUl8HfRVO81g09gnP/7aq98qnHDe8AbqW/0tNZPg541ofGRmRpAjz/DLIwAVcltXGqwoRzFQHP0LOkxCqK0Z+1Hl5ZvicqxHob9ZJEqleCRYlH/q4Fpj0g8NJIUCZ+GtinCDLG/a/Wiht9n+eKwv6VUdX3kzjGGJEljWXRiR9Mpz3rZOZ2sLgseTypzzpcOqiUzsdLfsWwKM16Yrp4rU4hGzshGqb9kR93wYiza1CqFvk1EhFHky9reHca2xrSkFD1VYez2Sk2jhOCEfeZCZri3bVUNGQ/OpOS1ww6WEzjBT8f6jawCgN06VM8eveUVPTaYw6XapcE4CMV1kNc5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by PH0PR11MB7659.namprd11.prod.outlook.com (2603:10b6:510:28e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 04:57:14 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::ab37:4985:7b95:2b95]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::ab37:4985:7b95:2b95%5]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 04:57:14 +0000
Message-ID: <c983986c-7848-c3fa-7912-cf4083e36a3d@windriver.com>
Date: Mon, 13 Mar 2023 12:57:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [bitbake-devel] [PATCH 1/2] utils: Add disable_network function
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        bitbake-devel@lists.openembedded.org
References: <20211222231907.1036709-1-richard.purdie@linuxfoundation.org>
Content-Language: en-US
From: ChenQi <Qi.Chen@windriver.com>
In-Reply-To: <20211222231907.1036709-1-richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0230.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::26) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|PH0PR11MB7659:EE_
X-MS-Office365-Filtering-Correlation-Id: 33a8ba4d-1414-49bd-5fb5-08db237f6988
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	brtFzxNYA2pfLMNyrRwhtex81FEJLaR5GGgCkAg7m3tyHEVKI1pam+NPu94sgnAxZJp/hqEnVtQjAy/7bSFK2DvWTBWH2fRXJ4wrbMP4zxgHpIkYxOMLQs28j5lrr35tbWTKFJO53C11UEwsXrKl+xOLfGdQe3yIX2bcEJVXN36cL2yWsmQIdvz52uo8v+83dlgnW8fzCZOJOp5Jwpwbw2SxaNvfJhN75hpP2rHv3m+20/MntdhiCShgIvzCUXVJZACHizuCQc99HJmakNVDLjNBCyh8gNymk2fhB1sXZST8YKO/QSLJSUaaX8tmJa4fGgcFjJ7Fii1i0/gX11vXADZXauNfjRb5ZtDXIaRvw557y1mG67bGp+zl1i2UyE1BA9Fux4EakjtlWVXFSJ2VhvWQCV38ayIsy3PdHwjZpiPqHZqMmMUXKMjbSINopFBEnqZzHjN98d3u2IyaL0GiLAeMP4UnsMgL37gSxsyRVPv4K/c0K2fJ/AApIr6Fa2R4g6QuCRxitaiAcrilAn3Mh+X6MvyRS4n/iZN2bkCfJ2kJdlbHpIJJaNxGvroAYRiqFCv0py6KSkoyS+NgJi2SvVMThpMe0+q3ZEJuAr16zvswjv6VqWD7fi5isIuezRPx48AeBN9KM18iTm3YpgBm7zL+syHoKSMKxBql0MQmQi5+7KRDo7HanoaLAY4yMUZgVxVcay7RdM1w4aGB8xdHZeLK1fphaRUxtSi7olK2WinLoLw1+Y9yUtCBCUs5URjfbeL2+eLOj3vCHd3bZet7pA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39840400004)(376002)(366004)(346002)(396003)(451199018)(66899018)(2906002)(31686004)(83380400001)(36756003)(5660300002)(66476007)(41300700001)(8936002)(8676002)(66946007)(66556008)(38100700002)(316002)(86362001)(31696002)(478600001)(53546011)(2616005)(186003)(26005)(966005)(6666004)(6506007)(6512007)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RjRjWUo2TzcyZnZVeWxBenJyOW1FdGZtdjVBMmlvbTM5dzZiMzQwN0FMZmRx?=
 =?utf-8?B?UEpkZS8zbFBnQS9scnJRdzZRNFFQSUxoUlZOd2NGZWNsK24zcExuWEdUSFN3?=
 =?utf-8?B?WTRtVTlkTGJibFliTXdEeG05LzRvdHNxWDYza1FwY09rbDJxbkFKMGVxdjdF?=
 =?utf-8?B?aURlZHZ4eFNhemFUVk1FRlo4RGdnQzVUUnptRHo4R2Z4TUQ3Um0wNmkwSWZR?=
 =?utf-8?B?NHlFYTRLMExYWEROWFZtY0FqZWRvNHRQMWZ2eXF4bjdhMG8rTko1SmtHVlNm?=
 =?utf-8?B?ZW1VaTJ0THByWE5kcDVPWmNjUHZ2RHZVVWg1NDhDTVhKSW5ncXQ2dnRPcDBT?=
 =?utf-8?B?d1BzMlpWaE1qamVGYmRKRExVbktPSDB3TU8wMjdNNnYvOFNZeDRrWHBDWU9Y?=
 =?utf-8?B?OG1aSWdTVWZCcm5lVU00QzdqTGZnR0lna2h5RTV2bmx4TkE4NFM2MEFZdS9E?=
 =?utf-8?B?UktFZVJSQ3p2aG5RQzRRbGJCOGozU0ZGRksyL1FzWEU4S2NwRW9wdEd5WUJl?=
 =?utf-8?B?NDNieWtzTDlISXFFRnBiS3ZHc0FZMmpVNlpqelBETVd5dFBGdTZ0ellOdjdz?=
 =?utf-8?B?WGdyYVE1TXZ4YzFyRnp1TXRqS3FlVWE1UEVYL1NGN0ZCbnBWNnFHOXZNZWVx?=
 =?utf-8?B?YkhSYjNveHZSSzhya2ZVUEYyYVJxV2hzWnUyQWhublR5VDZhRGYyd1RsMDZs?=
 =?utf-8?B?TVo0U2pLWjZDWlFqOGJrY2pGVU8raHVsZTE5UHVBc0IzeVJBTVJHT3JDOWk5?=
 =?utf-8?B?OWFFb0VvZFVoQUl4T2FYaDZkKzhjOXNVZlQzaHArWTdLcm4vL0U1Tjc5Rkor?=
 =?utf-8?B?NTlOTlFVaWY3TTBmVnIwY043QUYvR1hCcWNwMncxczZLUzlVVzVyQmtaVSs2?=
 =?utf-8?B?WHk2cmpyV0wwWnE2alpGUE9KdFVLZk12bUowSERkbHdMcWQrSFRJUXYrSEJk?=
 =?utf-8?B?N21ISlRaWHJFRGIzSm9qZVVjZzFOeEhlRWpiT1UvMnY3bHBjVXp2dTJjTC8z?=
 =?utf-8?B?dVBtcnhHSmVlbWRyeFJSdlJzNitsdEFDSElMTW1BSGYwVGVueEpaZHJGTEtI?=
 =?utf-8?B?ZzJUNmRJSTFNVlJmZWw3N09INmtKcmF5eDdOR012Um03UVFrQlRHaUxjWG0v?=
 =?utf-8?B?QlYzSXp1QUl2MU9oK2RqT3Y4SVFUTWxyUTlvZlhFMVJNSGV4TVo5dmRtMUcv?=
 =?utf-8?B?bkxsSGhqSkE3a2NJUThXSXZCRnF1eTVJUDZkemlYV0RrenBzVmduRCt6Uk1Y?=
 =?utf-8?B?T0VHWTBDMmE5NXEzOEptM1YzL21wYVRORTl6K1FVNVhVL3ZvNGQvck9SM2I0?=
 =?utf-8?B?Q1A1L0NjQ0tKZTBUM1lTbjhMVUFNRStOYWJyNWFkbm9PeXFZYjdlbkxPYm5h?=
 =?utf-8?B?amdtU0xlZmk3K0ZRVS9VZU9jNlRBRHU4ZUV0NTV4MWExeWlOSktuRTNpcmVy?=
 =?utf-8?B?RkpOTGxCazBVb3NKVkNHMldkbWQ3QmtYeW54OXYxa04rMVB4Yitvcmp1c3Ir?=
 =?utf-8?B?TnVTK05pVUlONnEyZ29yMXJDc3BQNkpvaXRIU2tteDZHUzVUOHhBbFBKaHBs?=
 =?utf-8?B?amVHRGJRcUFueUlUeFFYWWUvQmF6R2taSHBaOWI5OHd1M3h5OENEeXZ4U05N?=
 =?utf-8?B?SVdkZzB0V3o2R2UxUVY0TEhOZ01tTGVwVEkzeXlrMUdONExxU3RzTENFZ0Jt?=
 =?utf-8?B?b1dTKzJ4eTMvU1dEdzFHemd6eVJHYjQzR0ZXZlFyVVpkOG1zVDZ0QjBoamgy?=
 =?utf-8?B?SlNmUDdXTm5ZdUl5MXBzNHByMHAvZkZkd2d5a3U3ZUhUV25QZ1ordjlrOFFP?=
 =?utf-8?B?VFJWbDgvMTJYRDBXUjVva1NvbFU4QmNyMUhINFFvbk4yR3FJaWRZNWdHcjAv?=
 =?utf-8?B?T0pjWjJ5U2psc2lGS0hwMG12dHJFYXhxMnppdTkzSWIwQVNkMW52NXRYeHAw?=
 =?utf-8?B?azNnUGZ6OEx3YXFRRzdLZVFiemgrVHJFTHlKa2RoTU9SQmRFRVV4V2doMW95?=
 =?utf-8?B?dGwzdithSUxaMCtWTy9qSExueTRjdVdSNnVjczc3QXROdDhXODJaY2Fna3k3?=
 =?utf-8?B?cWF3bFZpOWFMNmFYOWY3U3hYVnpkelJua0tlcmFCcGYxd3puK3lsdSt2K0Nt?=
 =?utf-8?Q?vMmcZ05ScKanGVAEmU9KihgDs?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a8ba4d-1414-49bd-5fb5-08db237f6988
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 04:57:14.4084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: giMT79rF8XzCEayVp9isb+e36ENNIFzV3Tjh9WtpxLp0nTpNIRufP7f/7SWtZENk1J3JKKx4bQ5/oKcIA+0q8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7659
X-Proofpoint-ORIG-GUID: CZnzLJQbxiV0wW44ks0-OzGUtV2DFH9k
X-Proofpoint-GUID: fTATSlGpsDWloJVYHwxO39UmjFogLB88
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-12_10,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 priorityscore=1501 clxscore=1011
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303130040
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 13 Mar 2023 04:57:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14550

Hi Richard,

This might be a dummy question, but I'm wondering which kernels/distros 
could support it.
I tried the codes on poky target with linux-yocto 6.1.14, and it failed 
for a non-root user.

This manual, https://man7.org/linux/man-pages/man2/unshare.2.html, tells 
me that CLONE_NEWNET requires CAP_SYS_ADMIN. And looking at the 
netns_install function in net/core/net_namespace.c, it does seem to be 
checking CAP_SYS_ADMIN.

Regards,
Qi

On 12/23/21 07:19, Richard Purdie wrote:
> Add a function which uses the unshare glibc call to disable networking
> in the current process. This doesn't work on older distros/kernels
> but will on more recent ones so for now we simply ignore the cases we
> can't execute on. uid/gid can be passed in externally so this can
> work with pseudo/fakeroot contexts.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>   lib/bb/utils.py | 31 +++++++++++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
>
> diff --git a/lib/bb/utils.py b/lib/bb/utils.py
> index d890ea832e..8006f7bd2d 100644
> --- a/lib/bb/utils.py
> +++ b/lib/bb/utils.py
> @@ -26,6 +26,7 @@ import errno
>   import signal
>   import collections
>   import copy
> +import ctypes
>   from subprocess import getstatusoutput
>   from contextlib import contextmanager
>   from ctypes import cdll
> @@ -1594,6 +1595,36 @@ def set_process_name(name):
>       except:
>           pass
>   
> +def disable_network(uid=None, gid=None):
> +    """
> +    Disable networking in the current process if the kernel supports it, else
> +    just return after logging to debug. To do this we need to create a new user
> +    namespace, then map back to the original uid/gid.
> +    """
> +    libc = ctypes.CDLL('libc.so.6')
> +
> +    # From sched.h
> +    # New user namespace
> +    CLONE_NEWUSER = 0x10000000
> +    # New network namespace
> +    CLONE_NEWNET = 0x40000000
> +
> +    if uid is None:
> +        uid = os.getuid()
> +    if gid is None:
> +        gid = os.getgid()
> +
> +    ret = libc.unshare(CLONE_NEWNET | CLONE_NEWUSER)
> +    if ret != 0:
> +        logger.debug("System doesn't suport disabling network without admin privs")
> +        return
> +    with open("/proc/self/uid_map", "w") as f:
> +        f.write("%s %s 1" % (uid, uid))
> +    with open("/proc/self/setgroups", "w") as f:
> +        f.write("deny")
> +    with open("/proc/self/gid_map", "w") as f:
> +        f.write("%s %s 1" % (gid, gid))
> +
>   def export_proxies(d):
>       """ export common proxies variables from datastore to environment """
>       import os
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13199): https://lists.openembedded.org/g/bitbake-devel/message/13199
> Mute This Topic: https://lists.openembedded.org/mt/87909296/3618072
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [Qi.Chen@windriver.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>


