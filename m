Return-Path: <randy.macleod@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A7EC64EC4
	for <webhook@archiver.kernel.org>; Wed,  8 Mar 2023 21:09:09 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.5214.1678309739589391319
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Mar 2023 13:08:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=dSjk54/L;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=24312a6569=randy.macleod@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328Cr545024015
	for <bitbake-devel@lists.openembedded.org>; Wed, 8 Mar 2023 21:08:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=content-type :
 message-id : date : subject : to : references : from : in-reply-to :
 mime-version; s=PPS06212021;
 bh=dhmu5wdjKWLCfRgBG6sQBEbEaXXX/oap7FWHN1aslaM=;
 b=dSjk54/LKquAydQh3gnNmWC32Wr3N90rKCQysSJLwnCtp75RNR26bw2H5Pn6Js808zIP
 MMjj2/emAzfhCWNRfZr7l/iOC/PJgLCysIKwlcucZi+br39ZpA66m7cUEi4xEgMmYIjm
 bNmu8j7PHPcuIpMXmcpmMbn1kcbsq76Fo1F0s913X70qCfbYZqnauPtBJSMyoOY2LqdE
 9qEN7iA7sRlxE7mT43rMOL2cFbPFTXGKnkTbI9EXzDX9Gw9wb9+XHhzL9S/zVxw5QNei
 rKNVjqR7LLxuwpRyEOOFvsJByva18ZLFQHG1xDehYwv/WfeOPJlNYmAv/gVJZRCu4thJ QQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3p6fg6gy1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 08 Mar 2023 21:08:58 +0000
Received: from m0250812.ppops.net (m0250812.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 328L8w5f020400
	for <bitbake-devel@lists.openembedded.org>; Wed, 8 Mar 2023 21:08:58 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3p6fg6gy1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Mar 2023 21:08:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcaPg9kZ3I06agfY7WUODZMty9Z8wjp8S7tEWnBNh3E5Nk6pZzlDDWJALQj18Szip5nGtbsET4REUWcG1n0LsZFVOJbbxw/sn7hE8pxf2ubYiTsA6xFTXzhvuIR3q6gHceoiNTMnWVhqW3YPaCSYrubkw1ebbD0qYH2kNE13ZD2qpwaZ+QX4s0LNPP3m6sIi4eiUeydlUh1/IyGV0c7Z6ZC03Fi7HCPRqv2KNz544YhKLMVEs3o9FeimKbL9Y6PbEMCMjok6I+XG022NPgxq2Zq7ixddkFcuxBcHM3AeHmyu3eQBe52RPHtEdLMXg7majdR79KfYNJsY53g1ytodTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhmu5wdjKWLCfRgBG6sQBEbEaXXX/oap7FWHN1aslaM=;
 b=AbOJQ6F6RE2J+shEO+PpcQRh2z+gJgKF3NiwNeoMHcAhu5mxc55iULYV+/faJquqH+atVZV4733rqxmRebn55tL6E0a5KfNP/lYFTCZhRX9/jgq5CuzVy3PYPZjHgLBb2B795hJr9UIzLotei7QXh2zgad1uFdjzBcRNRf9TwQEQrX9H2ZMVqXfRLgdGgzj7jkhCn+3422h5Os5D/KVIwlK8yiy4i4LtG838yzV+InsFEmJB+7WWmgtw8WWu3nzCG8AAKCiva/ggq8piwcEHhSolDFZIy40XSZeLdp09JtTRTnC7mgAfDWZzlKDogq6GBfn4+tuAQNM3BtpF8zJ+Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM6PR11MB3994.namprd11.prod.outlook.com (2603:10b6:5:193::19)
 by CO1PR11MB5042.namprd11.prod.outlook.com (2603:10b6:303:99::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.18; Wed, 8 Mar
 2023 21:08:55 +0000
Received: from DM6PR11MB3994.namprd11.prod.outlook.com
 ([fe80::ceb7:f166:2f0f:4f67]) by DM6PR11MB3994.namprd11.prod.outlook.com
 ([fe80::ceb7:f166:2f0f:4f67%5]) with mapi id 15.20.6178.017; Wed, 8 Mar 2023
 21:08:55 +0000
Content-Type: multipart/alternative;
 boundary="------------JTlSyKd1GD6ZuGmQ596loE6H"
Message-ID: <6d2196a8-f618-872d-2f51-93afdc99933a@windriver.com>
Date: Wed, 8 Mar 2023 16:08:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [bitbake-devel] [PATCH] ensure locale en_US.UTF-8 is available on
 the system
Content-Language: en-CA
To: debrabander@gmail.com, bitbake-devel@lists.openembedded.org,
        "steve@sakoman.com" <steve@sakoman.com>,
        Richard Purdie <richard.purdie@linuxfoundation.org>
References: <20221206181805.3022-1-debrabander@gmail.com>
From: Randy MacLeod <randy.macleod@windriver.com>
In-Reply-To: <20221206181805.3022-1-debrabander@gmail.com>
X-ClientProxiedBy: YQBPR01CA0117.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::17) To DM6PR11MB3994.namprd11.prod.outlook.com
 (2603:10b6:5:193::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3994:EE_|CO1PR11MB5042:EE_
X-MS-Office365-Filtering-Correlation-Id: 22adfc96-e2ce-43ea-040f-08db20195379
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Nc+arl4gzcAoeKyLg1hUvUWNJ0vcR64e8xpFJk6VulzJffmYp0AuHqs86LiZqKc8nEVF29nA2KKOo/+KAMsngfbyiZvBhQxPt2y0nCazJ92j6UUM54G5EjdIaIXc4B0zFNh88AM+DWe9tuyf3rxCj3tghwMFVMDpAu7B/LisuNNleJp0zWhS7+v5X7+BphCmU65nV4V4sls274sBuQ1LJn3I1qu0fdDGOwwJQibQgDTha/ue8jzw8MRvSpv/Vf59DgROJerDtU7VKkIrePOUHZfzd57eGe1iVnezTklpDioWYBOeEMO3fbdD3zCGdKOoEd/GSCRzOtoevSFnjP/EOZTjgyvwv7ZY391eJsG1gjO/70GpeVyyyeLOi29YpV02Mh9wBY+Jko/YUlePIpRWUYaOJrAtVHHjAQg4PfyK2sD3fnuKeCJMDUuxn8CPI9EEExser8c4WjncF1KG3CH72gmH/fo2+eXmqcIhH18K820wiRhrJ70048Wo2awbmCncKinzRoafgv6rBOssxXa7Dj6lAKmFzjjAc9Ptmcw6y1TCWxKUUKq0TDIRxXz4gbua9IEIDJjUf9KY3nAKjIOz2osanfHesMb9kM9n/UZa47fhbZhIWjvaOANygf2YYtTvyczU1N8L5FVHEYXvUAbig/2Ye1Gasc6GrTJKkT4+KeFH7LGr5pzm80cKqMhZBE7iSDT+UZ6OxU3iT2CzcOKBjyRwBxmHx5ZsjvNxMyN5ciwduJBukzEq4A1bDbTbV66hQ7ClPWpn/Hjq6pLoY4tSpLGHxBRu8TAnc3E2Qy24KK4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3994.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39850400004)(366004)(346002)(376002)(396003)(136003)(451199018)(66946007)(31686004)(8676002)(966005)(66476007)(66556008)(2906002)(6486002)(41300700001)(2616005)(83380400001)(166002)(186003)(66899018)(316002)(478600001)(31696002)(5660300002)(38100700002)(6512007)(26005)(6506007)(33964004)(110136005)(53546011)(8936002)(36756003)(86362001)(6666004)(131093003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VTFjTE14TGE5QnB4d3VyVnVUb0w1Y3RpaHF6QUFwRWdQeDJUblZ5a0hub3N6?=
 =?utf-8?B?K05RQmdjTmdoR1hzOWZJeHhjVCtxV0NuS3RzSExWQjVlVDdZbjU4NlhjYlMy?=
 =?utf-8?B?ZE4yTFNQT25PYnp1MDY0eEgwSnJWanNjZXNlZ2hLenpKOXpOeHdoOFY5ZWQ1?=
 =?utf-8?B?NU10azN2aVJUN2diTGRVRnk3c08ycTNiVmgzV1JaR1Z6UjNxQ0tkcjFyZXJ2?=
 =?utf-8?B?MDhLZk5YZ2dISTQ0UG5kS253NEFoVThDYk1LL1Q2UjhjdVBGWVJCMnB5MVYv?=
 =?utf-8?B?SCs4bFF1dmg2RHo2NUlDZW9veE5jN21hQ3lldjg0TjlNWnlZcUFNWFJwK1px?=
 =?utf-8?B?MFB2a2l1d3FRdTI1Y1JYVU5FYlk5NGEzZkN2U0xqcUErMlZQclZSb2VyQ1NS?=
 =?utf-8?B?LzNTd09VbjNPQ0tBK2YrOERXQ0hDQ21rZjQ3amo0dldYZzU0dUtBUVh4L0JD?=
 =?utf-8?B?WllFa21zQXJRYW10c3p5Y25BMWlQbEt4dWw2Kyt3REFvbUVIcCt0eVo5ZWhx?=
 =?utf-8?B?NXVQRDBwVGZ4b1VhYVNYTnhMTFptWkNPM3c4cXhXNlpOZHVPRmJRM2FuRVo5?=
 =?utf-8?B?TC9rMDFRZjN5elplNDB3VTFMOFYxb0d6N1gyWkFuQmYrQysyQWluenhXaFRp?=
 =?utf-8?B?cFZnN1p0dElBMVdDUEhVd3FaS1JRRE5adW5hTGx5bHZIWmRpb1hORTlSVGpz?=
 =?utf-8?B?dXdrek5xbG1JczhYdkpHaHk4dFZOaTY0S29sdmNya01Dd2hYMklMUk5BT0I1?=
 =?utf-8?B?aUltb04vaDJVNEVnYXZqQ1ZaTEF0NHVFTGlZaTBGZVBIcWNqQTRvbDJ5US9H?=
 =?utf-8?B?aW9xUloxWFYxbHMrLzVlb2dNZ2g5cEsvZFY5T1JkMkRFK29YSE5PSVVkU3BK?=
 =?utf-8?B?NE5Vc2ZOMlhPSTZxSFJETTlkb3UzZGptZ28rZndlcjdBS0J3Z1Foc2J4STNB?=
 =?utf-8?B?NittenBUZnVZdXVjUHBzS2F3NnRtMXBXOXkwVEJ4bnJLOUR4emxpRjdJdHJO?=
 =?utf-8?B?eXlhTS9xM1UyaE11M1QxSzFzNlpEMnZTZW5MZkRKZldhc2xCQTJFVDY1bStS?=
 =?utf-8?B?WXJlbUMydXN5TDlDVWYwQUJlbFZvNE81cHZKMTdpN3ZWSGlFUVhYMUcrQ3dX?=
 =?utf-8?B?V1lGRWRTa0VpS0pucmJPaFZodkZMamYxY2FzdjJkVGpIS0Z5RWtscUV0Tkp0?=
 =?utf-8?B?U1ozZm5yNDV3Uzd0aUxYNmo3aVFROGlOU2xseFVPcERUWTYyRVMwVHlCS0dv?=
 =?utf-8?B?YmMrbVRpOU8wRnpXMDRhWk9QdnFrblRCUzIvWlpHc3J0bjQ5KzhsNlhXV0pB?=
 =?utf-8?B?bDZwS1NESTFyQzl0bVNMTVk5RHk0VnJ1NWQwbGZhMC9xWmIvMWJLSVFRRzgv?=
 =?utf-8?B?ejRCWVpLMDZZSnZMaUgyU3ZNQUdUY1pGelJEbk1reGhiRitmd1YwRWVPRFhX?=
 =?utf-8?B?OUFBZHBGaVNCR010RG9vNC9yaHpGV3Q1bXZzU2JhRW94ZnFqM242QkhtdGVN?=
 =?utf-8?B?dGJKamM5UHQrUHRCK0hqS1A4c0x3WFRaTXNUMStTajJTaXVoWXI3d1NXd3c3?=
 =?utf-8?B?USs0b3BsY1JwdVN0ZlFKc0tnM2FTYm9FNVhHcVlmbVRHS3lVLy9XTzV5UCtH?=
 =?utf-8?B?R2srVWs4b1JNTXdIZHRndGlvdUR5cGE2OFdac2ROWHpWZkc3R2tNd3VVTTdr?=
 =?utf-8?B?OTV3OUloRHdLMmx3ZWhwaEpMbzd6QTVUQUtvemNkOUNFc3ZJQ1ZVQTZTWjZO?=
 =?utf-8?B?NXhGMTYxQXE1MlpLSGVGK3EvcEJub2h6T0NvVVYzVlM0dGhDRjdST0RLTkcv?=
 =?utf-8?B?dkcyTVhTU3ZsV2RiU1N4T0tlaXBzM2JTYUc5bWhJUEJSQ08ybnJJZTdxbmE4?=
 =?utf-8?B?YjdvTmpPcXpEMENPR0dYTktwOXc4UUdoQ0U0T0UxcXg3MTZUK3FDRG4wc2Rn?=
 =?utf-8?B?YVE4ZUorL0FCRE80SzFncFB2ZEx5NnQ4WG4yMThkVlNtRjlzM3ZUcUVNOGJ0?=
 =?utf-8?B?NmJMaTluUnIwTW1JTWl0d3BhWmN4VkpFSElWeG0rMktpVHVYdkN3aUYzcTVK?=
 =?utf-8?B?UVdyelMyUHRqVnhka1hKMzNiLzJHdFlyOFduckxkamVUTDF5YktoTGlZY3Zk?=
 =?utf-8?B?dm9mR2ovLzY5MS8rMXBZblNJZjc5NC9PZzdxTDR0aXErMkV4M2NsSDVsRnpD?=
 =?utf-8?B?NVE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22adfc96-e2ce-43ea-040f-08db20195379
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3994.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 21:08:55.1018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0C4bmdG5HmRtNJXz+PCFUzUDg3eqiWtyHR5SG1PLuBAMXcvTdAH6P0o4JdNU08py7CTaVwOskZ+lYhpDuehv3d1DFXK2TAPJvZJW0no8UA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5042
X-Proofpoint-ORIG-GUID: 9dtpexBNZW2azi2PDX7_sU-vGIU4v-al
X-Proofpoint-GUID: 23NUf8PWbpuwwucNl3ochb_WRfhD6Ti4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_15,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1011 lowpriorityscore=0 adultscore=0
 impostorscore=0 suspectscore=0 phishscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080178
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 08 Mar 2023 21:09:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14527

--------------JTlSyKd1GD6ZuGmQ596loE6H
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022-12-06 13:18, Frank de Brabander via lists.openembedded.org wrote:
> Get rid of the duplicate code and add extra check that the
> locale en_US.UTF-8 is available on the system. This new helper
> method is now located right above the method filter_environment()
> which sets LC_ALL environment variable to 'en_US.UTF-8'.

Nice:

foo@2b7837225ffb:~/b/test$ bitbake -p coreutils
Please make sure locale 'en_US.UTF-8' is available on your system


Steve,

It would be nice if you cherry-pick this back to langdale and kirkstone, 
it's a clean c-p.

../Randy

>
> [YOCTO #10165]
>
> Signed-off-by: Frank de Brabander<debrabander@gmail.com>
> ---
>   bin/bitbake        |  3 +--
>   bin/bitbake-server |  5 +++--
>   bin/bitbake-worker |  3 +--
>   lib/bb/utils.py    | 16 ++++++++++++++++
>   4 files changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/bin/bitbake b/bin/bitbake
> index 7cbf88f4..f869eb48 100755
> --- a/bin/bitbake
> +++ b/bin/bitbake
> @@ -25,8 +25,7 @@ except RuntimeError as exc:
>   from bb import cookerdata
>   from bb.main import bitbake_main, BitBakeConfigParameters, BBMainException
>   
> -if sys.getfilesystemencoding() != "utf-8":
> -    sys.exit("Please use a locale setting which supports UTF-8 (such as LANG=en_US.UTF-8).\nPython can't change the filesystem locale after loading so we need a UTF-8 when Python starts or things won't work.")
> +bb.utils.check_system_locale()
>   
>   __version__ = "2.2.0"
>   
> diff --git a/bin/bitbake-server b/bin/bitbake-server
> index 825e9d56..454a3919 100755
> --- a/bin/bitbake-server
> +++ b/bin/bitbake-server
> @@ -12,8 +12,9 @@ warnings.simplefilter("default")
>   import logging
>   sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(sys.argv[0])), 'lib'))
>   
> -if sys.getfilesystemencoding() != "utf-8":
> -    sys.exit("Please use a locale setting which supports UTF-8 (such as LANG=en_US.UTF-8).\nPython can't change the filesystem locale after loading so we need a UTF-8 when Python starts or things won't work.")
> +import bb
> +
> +bb.utils.check_system_locale()
>   
>   # Users shouldn't be running this code directly
>   if len(sys.argv) != 11 or not sys.argv[1].startswith("decafbad"): diff --git a/bin/bitbake-worker b/bin/bitbake-worker index 
> 3799b170..3cacdb0c 100755 --- a/bin/bitbake-worker +++ 
> b/bin/bitbake-worker @@ -24,8 +24,7 @@ import subprocess from 
> multiprocessing import Lock from threading import Thread -if 
> sys.getfilesystemencoding() != "utf-8":
> -    sys.exit("Please use a locale setting which supports UTF-8 (such as LANG=en_US.UTF-8).\nPython can't change the filesystem locale after loading so we need a UTF-8 when Python starts or things won't work.")
> +bb.utils.check_system_locale()
>   
>   # Users shouldn't be running this code directly
>   if len(sys.argv) != 2 or not sys.argv[1].startswith("decafbad"): diff --git a/lib/bb/utils.py b/lib/bb/utils.py index 
> f4da3563..0df522b3 100644 --- a/lib/bb/utils.py +++ b/lib/bb/utils.py 
> @@ -13,6 +13,7 @@ import errno import logging import bb import bb.msg 
> +import locale import multiprocessing import fcntl import importlib @@ 
> -608,6 +609,21 @@ def preserved_envvars(): ] return v + 
> preserved_envvars_exported() +def check_system_locale(): + """Make sure the required system locale are available and configured"""
> +    default_locale = locale.getlocale(locale.LC_CTYPE)
> +
> +    try:
> +        locale.setlocale(locale.LC_CTYPE, ("en_US", "UTF-8"))
> +    except:
> +        sys.exit("Please make sure locale 'en_US.UTF-8' is available on your system")
> +    else:
> +        locale.setlocale(locale.LC_CTYPE, default_locale)
> +
> +    if sys.getfilesystemencoding() != "utf-8":
> +        sys.exit("Please use a locale setting which supports UTF-8 (such as LANG=en_US.UTF-8).\n"
> +                 "Python can't change the filesystem locale after loading so we need a UTF-8 when Python starts or things won't work.")
> +
>   def filter_environment(good_vars):
>       """
>       Create a pristine environment for bitbake. This will remove variables that
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14139):https://lists.openembedded.org/g/bitbake-devel/message/14139
> Mute This Topic:https://lists.openembedded.org/mt/95499228/3616765
> Group Owner:bitbake-devel+owner@lists.openembedded.org
> Unsubscribe:https://lists.openembedded.org/g/bitbake-devel/unsub  [randy.macleod@windriver.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

-- 
# Randy MacLeod
# Wind River Linux

--------------JTlSyKd1GD6ZuGmQ596loE6H
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2022-12-06 13:18, Frank de Brabander
      via lists.openembedded.org wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20221206181805.3022-1-debrabander@gmail.com">
      <pre class="moz-quote-pre" wrap="">Get rid of the duplicate code and add extra check that the
locale en_US.UTF-8 is available on the system. This new helper
method is now located right above the method filter_environment()
which sets LC_ALL environment variable to 'en_US.UTF-8'.</pre>
    </blockquote>
    <p>Nice:<br>
    </p>
    <p>foo@2b7837225ffb:~/b/test$ bitbake -p coreutils<br>
      Please make sure locale 'en_US.UTF-8' is available on your system<br>
    </p>
    <p><br>
    </p>
    <p>Steve, <br>
    </p>
    <p>It would be nice if you cherry-pick this back to langdale and
      kirkstone, it's a clean c-p.<br>
    </p>
    <p>../Randy<br>
    </p>
    <blockquote type="cite" cite="mid:20221206181805.3022-1-debrabander@gmail.com">
      <pre class="moz-quote-pre" wrap="">

[YOCTO #10165]

Signed-off-by: Frank de Brabander <a class="moz-txt-link-rfc2396E" href="mailto:debrabander@gmail.com">&lt;debrabander@gmail.com&gt;</a>
---
 bin/bitbake        |  3 +--
 bin/bitbake-server |  5 +++--
 bin/bitbake-worker |  3 +--
 lib/bb/utils.py    | 16 ++++++++++++++++
 4 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/bin/bitbake b/bin/bitbake
index 7cbf88f4..f869eb48 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -25,8 +25,7 @@ except RuntimeError as exc:
 from bb import cookerdata
 from bb.main import bitbake_main, BitBakeConfigParameters, BBMainException
 
-if sys.getfilesystemencoding() != &quot;utf-8&quot;:
-    sys.exit(&quot;Please use a locale setting which supports UTF-8 (such as LANG=en_US.UTF-8).\nPython can't change the filesystem locale after loading so we need a UTF-8 when Python starts or things won't work.&quot;)
+bb.utils.check_system_locale()
 
 __version__ = &quot;2.2.0&quot;
 
diff --git a/bin/bitbake-server b/bin/bitbake-server
index 825e9d56..454a3919 100755
--- a/bin/bitbake-server
+++ b/bin/bitbake-server
@@ -12,8 +12,9 @@ warnings.simplefilter(&quot;default&quot;)
 import logging
 sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(sys.argv[0])), 'lib'))
 
-if sys.getfilesystemencoding() != &quot;utf-8&quot;:
-    sys.exit(&quot;Please use a locale setting which supports UTF-8 (such as LANG=en_US.UTF-8).\nPython can't change the filesystem locale after loading so we need a UTF-8 when Python starts or things won't work.&quot;)
+import bb
+
+bb.utils.check_system_locale()
 
 # Users shouldn't be running this code directly
 if len(sys.argv) != 11 or not sys.argv[1].startswith(&quot;decafbad<a class="moz-txt-link-rfc2396E" href="mailto:):diff--gita/bin/bitbake-workerb/bin/bitbake-workerindex3799b170..3cacdb0c100755---a/bin/bitbake-worker+++b/bin/bitbake-worker@@-24,8+24,7@@importsubprocessfrommultiprocessingimportLockfromthreadingimportThread-ifsys.getfilesystemencoding()!=">&quot;):
diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 3799b170..3cacdb0c 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -24,8 +24,7 @@ import subprocess
 from multiprocessing import Lock
 from threading import Thread
 
-if sys.getfilesystemencoding() != &quot;</a>utf-8&quot;:
-    sys.exit(&quot;Please use a locale setting which supports UTF-8 (such as LANG=en_US.UTF-8).\nPython can't change the filesystem locale after loading so we need a UTF-8 when Python starts or things won't work.&quot;)
+bb.utils.check_system_locale()
 
 # Users shouldn't be running this code directly
 if len(sys.argv) != 2 or not sys.argv[1].startswith(&quot;decafbad<a class="moz-txt-link-rfc2396E" href="mailto:):diff--gita/lib/bb/utils.pyb/lib/bb/utils.pyindexf4da3563..0df522b3100644---a/lib/bb/utils.py+++b/lib/bb/utils.py@@-13,6+13,7@@importerrnoimportloggingimportbbimportbb.msg+importlocaleimportmultiprocessingimportfcntlimportimportlib@@-608,6+609,21@@defpreserved_envvars():]returnv+preserved_envvars_exported()+defcheck_system_locale():+">&quot;):
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index f4da3563..0df522b3 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -13,6 +13,7 @@ import errno
 import logging
 import bb
 import bb.msg
+import locale
 import multiprocessing
 import fcntl
 import importlib
@@ -608,6 +609,21 @@ def preserved_envvars():
     ]
     return v + preserved_envvars_exported()
 
+def check_system_locale():
+    &quot;</a>&quot;&quot;Make sure the required system locale are available and configured&quot;&quot;&quot;
+    default_locale = locale.getlocale(locale.LC_CTYPE)
+
+    try:
+        locale.setlocale(locale.LC_CTYPE, (&quot;en_US&quot;, &quot;UTF-8&quot;))
+    except:
+        sys.exit(&quot;Please make sure locale 'en_US.UTF-8' is available on your system&quot;)
+    else:
+        locale.setlocale(locale.LC_CTYPE, default_locale)
+
+    if sys.getfilesystemencoding() != &quot;utf-8&quot;:
+        sys.exit(&quot;Please use a locale setting which supports UTF-8 (such as LANG=en_US.UTF-8).\n&quot;
+                 &quot;Python can't change the filesystem locale after loading so we need a UTF-8 when Python starts or things won't work.&quot;)
+
 def filter_environment(good_vars):
     &quot;&quot;&quot;
     Create a pristine environment for bitbake. This will remove variables that
</pre>
      <br>
      <fieldset class="moz-mime-attachment-header"></fieldset>
      <pre class="moz-quote-pre" wrap="">-=-=-=-=-=-=-=-=-=-=-=-
Links: You receive all messages sent to this group.
View/Reply Online (#14139): <a class="moz-txt-link-freetext" href="https://lists.openembedded.org/g/bitbake-devel/message/14139">https://lists.openembedded.org/g/bitbake-devel/message/14139</a>
Mute This Topic: <a class="moz-txt-link-freetext" href="https://lists.openembedded.org/mt/95499228/3616765">https://lists.openembedded.org/mt/95499228/3616765</a>
Group Owner: <a class="moz-txt-link-abbreviated" href="mailto:bitbake-devel+owner@lists.openembedded.org">bitbake-devel+owner@lists.openembedded.org</a>
Unsubscribe: <a class="moz-txt-link-freetext" href="https://lists.openembedded.org/g/bitbake-devel/unsub">https://lists.openembedded.org/g/bitbake-devel/unsub</a> [<a class="moz-txt-link-abbreviated" href="mailto:randy.macleod@windriver.com">randy.macleod@windriver.com</a>]
-=-=-=-=-=-=-=-=-=-=-=-

</pre>
    </blockquote>
    <p><br>
    </p>
    <pre class="moz-signature" cols="72">-- 
# Randy MacLeod
# Wind River Linux</pre>
  </body>
</html>

--------------JTlSyKd1GD6ZuGmQ596loE6H--

