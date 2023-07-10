Return-Path: <randy.macleod@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99301EB64D9
	for <webhook@archiver.kernel.org>; Mon, 10 Jul 2023 23:33:39 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.316.1689032017671504523
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 10 Jul 2023 16:33:37 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@windriver.com header.s=pps06212021 header.b=DqoR5kAW;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=6555d5b285=randy.macleod@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36AMHO9l030330;
	Mon, 10 Jul 2023 16:33:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-type:message-id:date:subject:from:to:cc:references
	:in-reply-to:mime-version; s=PPS06212021; bh=bZEPJ9f5ztaQ2gT6Lj+
	f1h1r68zLS8BqgQ7Fi9mKy1E=; b=DqoR5kAWl5U9WdHs+uVWj0/G6DMVWFxDop4
	gm22NlbFQYrB96saZ/KkObY3qmPfLJv8u7OVgkYHJ03gYDoSypId1bV4pD5VBoPy
	YqBFocETrDbch332b+cB9qlqm3mGTXfeJ1qZGB49T9xPxaK3hd5m5m9Jl5FFhrTC
	ic04Ho+OAFX33JJlWmN33i33s7hONodgnd2fQMcenzwazcEhD7BpQc6E6ZqsCQgt
	Pn01Fu792dlIIBRb29LvvInPCDMinh5S8Msk88vON/xOURwk50cnNzB0YR1brcU+
	x/xK9tyTAIMlBFAljZl2RTS3XgzePDXXIcsClftT33T7ogRaGvA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3rq7af9sqa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jul 2023 16:33:36 -0700 (PDT)
Received: from m0250809.ppops.net (m0250809.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.22/8.17.1.22) with ESMTP id 36ANXaCZ001285;
	Mon, 10 Jul 2023 16:33:36 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3rq7af9sq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jul 2023 16:33:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IxpNHmy0N2n9XaPZTYPXqtt9RzmEnwFC5RVO3AuxaQlxdIgY/DCfnX/73ZTsnHpAZOdX6GxIsxsBe0R6V93PMhJNkL5NX3JWak9gQu0E2m9ANBxVM/zBqCW8WwY9NQc3yY/XAhjuM8fZicZPQhPRWr2UCeJxwLN7FM19xijZiPqiTMnrZPX9QigczexvEaD8hXnsVzjGaXSkq8i9ZbUxIWunGjfZHhO+ISzSyBYFCun3GMBEbZdhrYs7Aic5yH+XCXrY12KthTDE7kghNUS3whj7kGCYpjltfHIu6BE+y7I94FJFlwiIiHIissHyBX+VaYi001myWbPxxJAdct0ORw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bZEPJ9f5ztaQ2gT6Lj+f1h1r68zLS8BqgQ7Fi9mKy1E=;
 b=K8r9EaOf3GcSmUVJuOviiaSsJ1Q686ruYNmjE7cSmZFu2Ml5jWYe+wno8vBEcPu8/WNOuygy42wobBWVvykLbrJDZcBXfJfXQGAj/nn1xPY60tQjJojHPB8hrLPfklVUwBzbDUmfz+nYJiFH4qSFu0kA4heoQJTi36k4i9P4BeECTM99NmyrozFH59o7TAwWXMuI1fUvZ4K3634UZ7745SM0HTFncYzLqM/JNmQiDmvGiIaeMy5ufDK2j+M//XxAsJsKE6ZxhcX0k6TlRvjI/a3lLToeL8katwHR9FTGxWFB+q5NL+HYMP6/6g71Rz7ocDy/bNzai7Wm4zN9d45F/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM6PR11MB3994.namprd11.prod.outlook.com (2603:10b6:5:193::19)
 by IA1PR11MB7248.namprd11.prod.outlook.com (2603:10b6:208:42c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 23:33:32 +0000
Received: from DM6PR11MB3994.namprd11.prod.outlook.com
 ([fe80::20ff:3f23:8d9c:a181]) by DM6PR11MB3994.namprd11.prod.outlook.com
 ([fe80::20ff:3f23:8d9c:a181%6]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 23:33:32 +0000
Content-Type: multipart/alternative;
 boundary="------------A4eji8znzk3ly6JWg3cd71vt"
Message-ID: <7494762d-72ba-fcd8-4839-213d08e2f6bf@windriver.com>
Date: Mon, 10 Jul 2023 19:33:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [bitbake-devel][PATCH V2] runqueue.py: fix PSI check logic
Content-Language: en-CA
From: Randy MacLeod <randy.macleod@windriver.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, Qi.Chen@windriver.com
Cc: "Randy MacLeod via lists.openembedded.org"
 <randy.macleod=windriver.com@lists.openembedded.org>,
        bitbake-devel@lists.openembedded.org,
        Ola x Nilsson <ola.x.nilsson@axis.com>
References: <20230523020905.2911543-1-Qi.Chen@windriver.com>
 <a963a98b-0420-5785-b393-306ebbf6f230@windriver.com>
 <jwqilcg4ydl.fsf@axis.com> <1766B1E87F43AC01.3462@lists.openembedded.org>
 <ace2ae20-d99c-b73c-d63a-890cae5d5a25@windriver.com>
In-Reply-To: <ace2ae20-d99c-b73c-d63a-890cae5d5a25@windriver.com>
X-ClientProxiedBy: BYAPR07CA0036.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::49) To DM6PR11MB3994.namprd11.prod.outlook.com
 (2603:10b6:5:193::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3994:EE_|IA1PR11MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: e067b8ae-ad8e-4ac3-7749-08db819e12c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	wobIBa27V2c0FSHCB5lR/Pa65u4EWB7aZLTC+HGyMUZLDf/4el96MmVV/OJTKV7gjW6HtWBTxLLjj9xhSJGBb7AkNeVNwdwSqotKcFgZ0pBf5zdR3cvoR3rWbvcQVZ+DjNbj3/tYv3i2VRnvAhvadpQThScxQg/mSOcDiasljWDC7/P1YBdWsmBLN/4JhTsLDd80P9qbe+NdPf1KRoqLG16OQsLa1mlDoqaxk2Ua7e0UYZbEENLnikGScCsHDvkPIsN0RaGLN+C6SvWJ+Bet976rUSXWr82ji16R9CiRkWpiXLRDNj9GISdZxaNhuD0ZkR4gG3S+v79aqnOHzTtMSY8wQH89Jin3iUCrNbdXTQb9ZXvqYZz1CeTJdzhHuzwrDkK6H8nBgU1xuoZYBG3OIgdXh7HYxMdlnQTVQl0SX6EO34jCANtdRkgQxDXxHY0OdAMEALHHlGUpEZ4pShrNqy6RQ6Qf/lhaYkbkEiecjEUEZs6/ED8kCB784wo5JGUGuqnDyORVj9p8skn9qTZDx6tZx4ZhgBJ84UcxO063agAlOH4wRiO59b+0gQRdGi02D5IolhSdX96NHLt5Qg+CfEBslO0vhVxLoPdIeC/Mw0ctO5AX+V7GPjUk+aSWBHfF9ilGslFifbc5BctErNPmEw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3994.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(39850400004)(366004)(376002)(451199021)(6666004)(6486002)(478600001)(33964004)(83380400001)(26005)(2616005)(6506007)(186003)(53546011)(36756003)(966005)(6512007)(316002)(2906002)(41300700001)(30864003)(38100700002)(66476007)(66946007)(66556008)(6636002)(4326008)(86362001)(31696002)(31686004)(8936002)(8676002)(5660300002)(54906003)(66899021)(166002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Vyt6VlFveW1oektmL3hWUS9Ea0ZNMC9WTlJBRXVIN0tFMVZWUlN0cG8zbnly?=
 =?utf-8?B?a1VRRDNBS29qNTQzek5kckZwcWs3SlV3dk4xWHBza1JpUXJrSE5ISDhVT1Ey?=
 =?utf-8?B?YVpFaFVaT1Fka05pTXBEaDVSenR5eXZySDBiWDFtZHdxUVVhaiswSW5UTmU5?=
 =?utf-8?B?M3k3YkdFSmVOM1dSTVA1ck0zS0pUU0lyN3ZKeFRqNlNESW5ZdkFtaXhwbURI?=
 =?utf-8?B?ZVM0Z1J3S1AvY21ON0puY2Z0bHZtZTlSYVVZcFBqdWEzZitXRnZrSXF1MU8x?=
 =?utf-8?B?VlczNDc2aTc0aEVodURPWGVjM1o1QXdIOGlHOEhoU3JWeDFYWEJiaCt3aTk0?=
 =?utf-8?B?dXZOd3E3eHdaWmVsU2xXSFB6OWlmdEZ3TVJLSW9uNlU4SG83Vlo4WmZTQnBZ?=
 =?utf-8?B?ZDF0ZjY2TWpXT1pMVmlOdjFyYUpqY3dvNHBrczM4R1dieHJLR0VxQ1JHdWxi?=
 =?utf-8?B?WE9rdkNWM3RKR1hFdWt2QWlaS1g5dnE0amI5RTBCKzAxZGJrWU8rWHo1S0ln?=
 =?utf-8?B?allqTjRVV3V6UitWMFBXc2YvUFFzUGdOdkN5aXdLV2dyRkYzL2FFdEc4RGNn?=
 =?utf-8?B?cnNBZWJUNXRHbVJtVzhlWmlXdzVSWFU5ZWF3MzlsTTZMUWQzak1tcEUyMThZ?=
 =?utf-8?B?cUpISDNqME1DTUlKeDFqZ0g2RUNpNVAyYW5KL0ludkUvSnRVOTl4Nk9jNlpz?=
 =?utf-8?B?SVRrVEVPclBqRWN3dExyZ3lXSGx0ZzB0RjNxTngzd05hbEU4bk5nQ3ZXMW1u?=
 =?utf-8?B?NFFJSmszWGs2Qm54REJtZTVkeGNhVXQzSWZMRUpyQWpsV2hwSzEyYzdoNkM0?=
 =?utf-8?B?WGtWTVRPaHB0NXg1RG9zYi9oUFZFbnhLNjI4V1BVbEg2VlFOaldnRHM1Tmoy?=
 =?utf-8?B?LzBsOXhUWm13QnRYU09UMFpNSVc5cTNjU0tpUDBMcjlQckZPTWNXR25QOE51?=
 =?utf-8?B?cDcvMXprUGZMOUlUWmxyN1Ric2FYUjdVNXZIaklsa01MdnpzMDkxdjZBSGZC?=
 =?utf-8?B?cWY0WSs0N092MmJYZmgrM1VXaHpkQ1Q5OGl0YjNaSzBEZnQ4NGJuWDRxdDZL?=
 =?utf-8?B?R1RwWlJJZ1hzYmVqbXVrVHZUU09qZkUyV3NidjJ4eXN1WTdvaTBiWVpjVFpW?=
 =?utf-8?B?YlEraEZISFI0RSt5aEhsNVNFVUQxWDhTOXMwT01haGhYVVljZ1B4RTcwQXhV?=
 =?utf-8?B?VDN2bjdtTEJxUVFhTURoNVJnSDB6aVV2UE5pSnAyVCtWa2JiRTdpVVJkYk1z?=
 =?utf-8?B?RndJaU1oSXIra3REVzBjN1JFajl5bDRtNytuQURtdERzc2t5andpTmhsaHdD?=
 =?utf-8?B?VC9heE5kNm1xd2s5QlBTSnllSkRWVWlNTmpSbmRUbHY4dGFGRW10b2h3MUNl?=
 =?utf-8?B?RmQ0K0hwV1Y4Zldzc2QwL09GWmtJQkxpQVJTeU53b1cySW1OcVV1dEdzL3NT?=
 =?utf-8?B?NkFFQ0thUENnUjAyU3ZLblFWcmxoWC9PWEp2cm1nTFNUaUZOb0VCd1VtV1FV?=
 =?utf-8?B?NExRWUFZcTFFSXB5bUxVcjNSTWlSOVRPaEpUYU9ueGp5ZHVVSTBBS2hDR000?=
 =?utf-8?B?Vm0zOCs1VkZEb29RTC9vNGNFMStLRDZVQVNvYXZhVmF4UzlEVGNUU2ZiWFNk?=
 =?utf-8?B?REZHM1QvZ3V1cCs2NU9DREFSSlMwc0xmOGpHUzZUOW8zcGxXamd0ZUR5aUZk?=
 =?utf-8?B?NFh2TFRSQWduMUdTU0ZCU0VwbTRYV3EwdnNHYzdIeG9oOGdUcTFvNUZsNzVn?=
 =?utf-8?B?ekxZQTV6WlM5QlJidjdtbEpYNTFaU2FiUEFQZkJpUHB1N0kyTlhpVFYwZm9K?=
 =?utf-8?B?ZEV4b0RibWo5a1M1eUdWOUI1MUhSakRiMWdKOTF0ZU9Ndkh6cjZVWC9odUxu?=
 =?utf-8?B?a1cyby90QkhDNjBhbEdFQzhlVkFKUnFURkpsaXZlS21CY0J4cjM4eXdpWjJ2?=
 =?utf-8?B?b1pkVzRidzdqdStiRnJ5MWFMUjBya2YwRXdpYUdUMWsrNHBMU0QycjBWQXho?=
 =?utf-8?B?M1c5aUJ2bUxTME5nR0l4dVNOVSt3aUMwVzVUc2tNVk1ucnVIbHlJRTM0MUhE?=
 =?utf-8?B?ai9kQndWaDFUSTd1VVNkb0NPdG1XUE1wbWpFbktvVnhWUHpyeEtQa3E0dUdQ?=
 =?utf-8?B?akNGbEtueGxyU1ZQenlJNEZZZmo5MzJ1NmxJWjNreDZIRURGdE5kMU01YTJl?=
 =?utf-8?B?RlE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e067b8ae-ad8e-4ac3-7749-08db819e12c2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3994.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 23:33:32.4258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aYeDqt1P9zshYfROWhLAIDH/eag99MS3QJ7wgYI4Ua9Hdb/kY/gnNCx0OWMPi7NJLNt1sLkGQEp7YEX1FuYZFVZuAezh34CCrAjWmlGA4LA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7248
X-Proofpoint-ORIG-GUID: 2LKirmJSAyAt7Yx3Ny7GM-3reoyCEj3m
X-Proofpoint-GUID: th25FKGwOYLlIiVIvf6m8E5HfH0KIVcU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_17,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 clxscore=1015 spamscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2305260000 definitions=main-2307100214
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 10 Jul 2023 23:33:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14879

--------------A4eji8znzk3ly6JWg3cd71vt
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 36AMHO9l030330

On 2023-07-10 19:22, Randy MacLeod wrote:
> On 2023-06-08 09:25, Randy MacLeod via lists.openembedded.org wrote:
>> On 2023-05-25 04:17, Ola x Nilsson wrote:
>>> On Tue, May 23 2023, Randy MacLeod via lists.openembedded.org wrote:
>>>
>>>> On 2023-05-22 22:09,Qi.Chen@windriver.com  wrote:
>>>>> From: Chen Qi<Qi.Chen@windriver.com>
>>>>>
>>>>> The current logic is not correct because if the time interval
>>>>> between the current check and the last check is very small, the PSI
>>>>> checker is not likely to block things even if the system is heavy
>>>>> loaded.
>>>>>
>>>>> It's not good to calculate the value too often. So we change to a 1=
s
>>>>> check. As a build will usually take at least minutes, using the 1s =
value
>>>>> seems reasonable.
>>>> I don't have time to check today but I'm not convinced that this is =
true.
>>>>
>>>> I suspect that in the typical case, it would be okay but there will =
be
>>>> workloads (perhaps rare workloads) where you want to check more ofte=
n.
>>>>
>>>> The 1 second intervals where we no longer launch new work may
>>>> result in a significantly longer build. IIRC, our benchmark was buil=
ding
>>>> core-image-minimal on a 24 core system without PSI regulation and th=
en
>>>> with it set to 300. I'd look at the elapsed time and the
>>>> buildchart/bootchart:
>>>>  =C2=A0=C2=A0 scripts/pybootchartgui/README.pybootchart
>>>>
>>>> Ola, have you been able to test this and if not, can you?
>>>>
>>> This patch is identical to the V1 except for the commit message, so I
>>> consider it
>>>
>>> Tested-By: Ola Nilsson<ola.x.nilsson@axis.com>
>>>
>>> /Ola
>>
>> Richard and Alex were waiting to merge this but I think we need
>> some indicating that this produces a better outcome than before the=20
>> patch.
>>
>> I've pencilled in some time on next Tuesday to do that but
>> we're working on a release so higher priority work may interfere.
>>
>> Qi and I will get to this eventually and reply here or with a new patc=
h.
>>
>> ../Randy
>>
>
> This change was merged back in April, despite my comments above.
>
> We're still working towards a product milestone later this month so my=20
> time to
> look into this type of problem is still limited - sigh.
>
>
> Recently some people have noticed slow builds when pressure regulation=20
> is enabled
> but I'm not sure if this change is the root cause. I'll be doing some=20
> builds
> to test that idea out. Has anyone else noticed very long build times=20
> that are say
> > 2x the expected time? I saw some unexpectedly slow builds on a new=20
> laptop
> 2 weeks ago but then went on vacation and I haven't gotten back to=20
> review the situation.
>
>
> If you look at the build stats from a recent low YP autobuilder:
>
> https://autobuilder.yoctoproject.org/typhoon/#/builders/100/builds/4707
>
> https://autobuilder.yocto.io/pub/failed-builds-data/slow-buildstats.tgz
>
> =C2=A0=C2=A0 $.../poky.git/scripts/pybootchartgui/pybootchartgui.py 202=
30710094248/
>
> you can see a staircase effect of a group of tasks being started and=20
> then the system waiting for a while (1).
> While that's not unexpected, I don't recall the effect being so=20
> significant.
>
> Furthermore, in the middle ~1/3 the build (2), there are very few=20
> tasks are started and
> yet the=C2=A0 CPU usage and contention seem to remain high. This effect=
=20
> could be due to a kirkstone build running
> and the current algorithm being nicer than what is in the older branche=
s.
>

This middle part of the build is only running do_package_qa tasks.

The individual QA runs don't seem to take long to complete but the CPU=20
usage and contention
do seem to be high so perhaps the pressure regulation is limiting the=20
launch of new tasks
even if the system could do more work. Logging will help so I'll work on=20
that tomorrow if
I can find the time.

../Randy


> Also, we're going to add some logging around pressure regulation but=20
> it'll have to
> be written to ensure that the logs aren't flooded.
>
> ../Randy
>
>
>
> 1) build staircase effect:
>
>
>
>
>
> 2) 50000 m view, with not much happening in the middle of the build:
>
>
>
>>
>>
>>>> All for today.
>>>>
>>>> ../Randy
>>>>
>>>>
>>>>> Signed-off-by: Chen Qi<Qi.Chen@windriver.com>
>>>>> ---
>>>>>    bitbake/lib/bb/runqueue.py | 29 ++++++++++++++---------------
>>>>>    1 file changed, 14 insertions(+), 15 deletions(-)
>>>>>
>>>>> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.p=
y
>>>>> index 02f1474540..4d49d25153 100644
>>>>> --- a/bitbake/lib/bb/runqueue.py
>>>>> +++ b/bitbake/lib/bb/runqueue.py
>>>>> @@ -179,6 +179,7 @@ class RunQueueScheduler(object):
>>>>>                        self.prev_memory_pressure =3D memory_pressur=
e_fds.readline().split()[4].split("=3D")[1]
>>>>>                        self.prev_pressure_time =3D time.time()
>>>>>                    self.check_pressure =3D True
>>>>> +                self.psi_exceeded =3D False
>>>>>                except:
>>>>> bb.note("The /proc/pressure files can't be read. Continuing build
>>>> without monitoring pressure")
>>>>>                    self.check_pressure =3D False
>>>>> @@ -191,6 +192,10 @@ class RunQueueScheduler(object):
>>>>>            BB_PRESSURE_MAX_{CPU|IO|MEMORY} are set, return True if =
above threshold.
>>>>>            """
>>>>>            if self.check_pressure:
>>>>> +            now =3D time.time()
>>>>> +            tdiff =3D now - self.prev_pressure_time
>>>>> +            if tdiff < 1.0:
>>>>> +                return self.psi_exceeded
>>>>>                with open("/proc/pressure/cpu") as cpu_pressure_fds,=
 \
>>>>>                    open("/proc/pressure/io") as io_pressure_fds, \
>>>>>                    open("/proc/pressure/memory") as memory_pressure=
_fds:
>>>>> @@ -198,21 +203,15 @@ class RunQueueScheduler(object):
>>>>>                    curr_cpu_pressure =3D cpu_pressure_fds.readline(=
).split()[4].split("=3D")[1]
>>>>>                    curr_io_pressure =3D io_pressure_fds.readline().=
split()[4].split("=3D")[1]
>>>>>                    curr_memory_pressure =3D memory_pressure_fds.rea=
dline().split()[4].split("=3D")[1]
>>>>> -                now =3D time.time()
>>>>> -                tdiff =3D now - self.prev_pressure_time
>>>>> -                if tdiff > 1.0:
>>>>> - exceeds_cpu_pressure =3D self.rq.max_cpu_pressure and
>>>> (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) / tdiff >
>>>> self.rq.max_cpu_pressure
>>>>> - exceeds_io_pressure =3D self.rq.max_io_pressure and
>>>> (float(curr_io_pressure) - float(self.prev_io_pressure)) / tdiff >
>>>> self.rq.max_io_pressure
>>>>> - exceeds_memory_pressure =3D self.rq.max_memory_pressure and
>>>> (float(curr_memory_pressure) - float(self.prev_memory_pressure)) /
>>>> tdiff > self.rq.max_memory_pressure
>>>>> -                    self.prev_cpu_pressure =3D curr_cpu_pressure
>>>>> -                    self.prev_io_pressure =3D curr_io_pressure
>>>>> -                    self.prev_memory_pressure =3D curr_memory_pres=
sure
>>>>> -                    self.prev_pressure_time =3D now
>>>>> -                else:
>>>>> - exceeds_cpu_pressure =3D self.rq.max_cpu_pressure and
>>>> (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) >
>>>> self.rq.max_cpu_pressure
>>>>> - exceeds_io_pressure =3D self.rq.max_io_pressure and
>>>> (float(curr_io_pressure) - float(self.prev_io_pressure)) >
>>>> self.rq.max_io_pressure
>>>>> - exceeds_memory_pressure =3D self.rq.max_memory_pressure and
>>>> (float(curr_memory_pressure) - float(self.prev_memory_pressure)) >
>>>> self.rq.max_memory_pressure
>>>>> -            return (exceeds_cpu_pressure or exceeds_io_pressure or=
 exceeds_memory_pressure)
>>>>> + exceeds_cpu_pressure =3D self.rq.max_cpu_pressure and
>>>> (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) / tdiff >
>>>> self.rq.max_cpu_pressure
>>>>> + exceeds_io_pressure =3D self.rq.max_io_pressure and
>>>> (float(curr_io_pressure) - float(self.prev_io_pressure)) / tdiff >
>>>> self.rq.max_io_pressure
>>>>> + exceeds_memory_pressure =3D self.rq.max_memory_pressure and
>>>> (float(curr_memory_pressure) - float(self.prev_memory_pressure)) /
>>>> tdiff > self.rq.max_memory_pressure
>>>>> +                self.prev_cpu_pressure =3D curr_cpu_pressure
>>>>> +                self.prev_io_pressure =3D curr_io_pressure
>>>>> +                self.prev_memory_pressure =3D curr_memory_pressure
>>>>> +                self.prev_pressure_time =3D now
>>>>> +                self.psi_exceeded =3D exceeds_cpu_pressure or exce=
eds_io_pressure or exceeds_memory_pressure
>>>>> +            return self.psi_exceeded
>>>>>            return False
>>>>>          def next_buildable_task(self):
>>
>>
>> --=20
>> # Randy MacLeod
>> # Wind River Linux
>>
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#14835):https://lists.openembedded.org/g/bitbake-de=
vel/message/14835
>> Mute This Topic:https://lists.openembedded.org/mt/99079426/3616765
>> Group Owner:bitbake-devel+owner@lists.openembedded.org
>> Unsubscribe:https://lists.openembedded.org/g/bitbake-devel/unsub  [ran=
dy.macleod@windriver.com]
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>
>
> --=20
> # Randy MacLeod
> # Wind River Linux


--=20
# Randy MacLeod
# Wind River Linux

--------------A4eji8znzk3ly6JWg3cd71vt
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2023-07-10 19:22, Randy MacLeod
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:ace2ae20-d99c-b73c-d63a-890cae5d5a25@windriver.com">
      
      <div class="moz-cite-prefix">On 2023-06-08 09:25, Randy MacLeod
        via lists.openembedded.org wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:1766B1E87F43AC01.3462@lists.openembedded.org">
        
        <div class="moz-cite-prefix">On 2023-05-25 04:17, Ola x Nilsson
          wrote:<br>
        </div>
        <blockquote type="cite" cite="mid:jwqilcg4ydl.fsf@axis.com">
          <pre class="moz-quote-pre" wrap="">On Tue, May 23 2023, Randy MacLeod via lists.openembedded.org wrote:

</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">On 2023-05-22 22:09, <a class="moz-txt-link-abbreviated" href="mailto:Qi.Chen@windriver.com">Qi.Chen@windriver.com</a> wrote:
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">From: Chen Qi<a class="moz-txt-link-rfc2396E" href="mailto:Qi.Chen@windriver.com">&lt;Qi.Chen@windriver.com&gt;</a>

The current logic is not correct because if the time interval
between the current check and the last check is very small, the PSI
checker is not likely to block things even if the system is heavy
loaded.

It's not good to calculate the value too often. So we change to a 1s
check. As a build will usually take at least minutes, using the 1s value
seems reasonable.
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">I don't have time to check today but I'm not convinced that this is true.

I suspect that in the typical case, it would be okay but there will be
workloads (perhaps rare workloads) where you want to check more often.

The 1 second intervals where we no longer launch new work may
result in a significantly longer build. IIRC, our benchmark was building
core-image-minimal on a 24 core system without PSI regulation and then
with it set to 300. I'd look at the elapsed time and the
buildchart/bootchart:
&nbsp;&nbsp; scripts/pybootchartgui/README.pybootchart

Ola, have you been able to test this and if not, can you?

</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">This patch is identical to the V1 except for the commit message, so I
consider it

Tested-By: Ola Nilsson <a class="moz-txt-link-rfc2396E" href="mailto:ola.x.nilsson@axis.com">&lt;ola.x.nilsson@axis.com&gt;</a>

/Ola</pre>
        </blockquote>
        <p>Richard and Alex were waiting to merge this but I think we
          need <br>
          some indicating that this produces a better outcome than
          before the patch.<br>
        </p>
        <p>I've pencilled in some time on next Tuesday to do that but<br>
          we're working on a release so higher priority work may
          interfere.</p>
        <p>Qi and I will get to this eventually and reply here or with a
          new patch.</p>
        <p>../Randy</p>
      </blockquote>
      <p><br>
      </p>
      <p>This change was merged back in April, despite my comments
        above.</p>
      <p>We're still working towards a product milestone later this
        month so my time to<br>
        look into this type of problem is still limited - sigh.<br>
      </p>
      <p><br>
      </p>
      <p>Recently some people have noticed slow builds when pressure
        regulation is enabled<br>
        but I'm not sure if this change is the root cause. I'll be doing
        some builds<br>
        to test that idea out. Has anyone else noticed very long build
        times that are say<br>
        &gt; 2x the expected time? I saw some unexpectedly slow builds
        on a new laptop <br>
        2 weeks ago but then went on vacation and I haven't gotten back
        to review the situation.<br>
        <br>
      </p>
      <p><br>
      </p>
      <p>If you look at the build stats from a recent low YP
        autobuilder:</p>
      <p>&nbsp; <a class="moz-txt-link-freetext" href="https://autobuilder.yoctoproject.org/typhoon/#/builders/100/builds/4707" moz-do-not-send="true">https://autobuilder.yoctoproject.org/typhoon/#/builders/100/builds/4707</a><br>
      </p>
      <p>&nbsp; <a class="moz-txt-link-freetext" href="https://autobuilder.yocto.io/pub/failed-builds-data/slow-buildstats.tgz" moz-do-not-send="true">https://autobuilder.yocto.io/pub/failed-builds-data/slow-buildstats.tgz</a></p>
      <p>&nbsp;&nbsp; $.../poky.git/scripts/pybootchartgui/pybootchartgui.py
        20230710094248/<br>
        <br>
      </p>
      <p>you can see a staircase effect of a group of tasks being
        started and then the system waiting for a while (1).<br>
        While that's not unexpected, I don't recall the effect being so
        significant.</p>
      <p>Furthermore, in the middle ~1/3 the build (2), there are very
        few tasks are started and <br>
        yet the&nbsp; CPU usage and contention seem to remain high. This
        effect could be due to a kirkstone build running <br>
        and the current algorithm being nicer than what is in the older
        branches.<br>
      </p>
    </blockquote>
    <p><br>
    </p>
    <p>This middle part of the build is only running do_package_qa
      tasks. <br>
    </p>
    <p>The individual QA runs don't seem to take long to complete but
      the CPU usage and contention<br>
      do seem to be high so perhaps the pressure regulation is limiting
      the launch of new tasks<br>
      even if the system could do more work. Logging will help so I'll
      work on that tomorrow if<br>
      I can find the time.<br>
    </p>
    <p>../Randy</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:ace2ae20-d99c-b73c-d63a-890cae5d5a25@windriver.com">
      <p> </p>
      <p>Also, we're going to add some logging around pressure
        regulation but it'll have to<br>
        be written to ensure that the logs aren't flooded.</p>
      <p>../Randy</p>
      <p><br>
      </p>
      <p><br>
      </p>
      <p>1) build staircase effect:<br>
      </p>
      <p><br>
      </p>
      <p><br>
      </p>
      <p><br>
      </p>
      <p><br>
      </p>
      <p>2) 50000 m view, with not much happening in the middle of the
        build:</p>
      <p><br>
      </p>
      <p><br>
      </p>
      <blockquote type="cite" cite="mid:1766B1E87F43AC01.3462@lists.openembedded.org">
        <p><br>
        </p>
        <p><br>
        </p>
        <blockquote type="cite" cite="mid:jwqilcg4ydl.fsf@axis.com">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">All for today.

../Randy


</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">Signed-off-by: Chen Qi<a class="moz-txt-link-rfc2396E" href="mailto:Qi.Chen@windriver.com">&lt;Qi.Chen@windriver.com&gt;</a>
---
  bitbake/lib/bb/runqueue.py | 29 ++++++++++++++---------------
  1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 02f1474540..4d49d25153 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -179,6 +179,7 @@ class RunQueueScheduler(object):
                      self.prev_memory_pressure = memory_pressure_fds.readline().split()[4].split(&quot;=&quot;)[1]
                      self.prev_pressure_time = time.time()
                  self.check_pressure = True
+                self.psi_exceeded = False
              except:
bb.note(&quot;The /proc/pressure files can't be read. Continuing build
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">without monitoring pressure&quot;)
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">                  self.check_pressure = False
@@ -191,6 +192,10 @@ class RunQueueScheduler(object):
          BB_PRESSURE_MAX_{CPU|IO|MEMORY} are set, return True if above threshold.
          &quot;&quot;&quot;
          if self.check_pressure:
+            now = time.time()
+            tdiff = now - self.prev_pressure_time
+            if tdiff &lt; 1.0:
+                return self.psi_exceeded
              with open(&quot;/proc/pressure/cpu&quot;) as cpu_pressure_fds, \
                  open(&quot;/proc/pressure/io&quot;) as io_pressure_fds, \
                  open(&quot;/proc/pressure/memory&quot;) as memory_pressure_fds:
@@ -198,21 +203,15 @@ class RunQueueScheduler(object):
                  curr_cpu_pressure = cpu_pressure_fds.readline().split()[4].split(&quot;=&quot;)[1]
                  curr_io_pressure = io_pressure_fds.readline().split()[4].split(&quot;=&quot;)[1]
                  curr_memory_pressure = memory_pressure_fds.readline().split()[4].split(&quot;=&quot;)[1]
-                now = time.time()
-                tdiff = now - self.prev_pressure_time
-                if tdiff &gt; 1.0:
- exceeds_cpu_pressure = self.rq.max_cpu_pressure and
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">(float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) / tdiff &gt;
self.rq.max_cpu_pressure
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">- exceeds_io_pressure = self.rq.max_io_pressure and
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">(float(curr_io_pressure) - float(self.prev_io_pressure)) / tdiff &gt;
self.rq.max_io_pressure
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">- exceeds_memory_pressure = self.rq.max_memory_pressure and
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">(float(curr_memory_pressure) - float(self.prev_memory_pressure)) /
tdiff &gt; self.rq.max_memory_pressure
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">-                    self.prev_cpu_pressure = curr_cpu_pressure
-                    self.prev_io_pressure = curr_io_pressure
-                    self.prev_memory_pressure = curr_memory_pressure
-                    self.prev_pressure_time = now
-                else:
- exceeds_cpu_pressure = self.rq.max_cpu_pressure and
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">(float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) &gt;
self.rq.max_cpu_pressure
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">- exceeds_io_pressure = self.rq.max_io_pressure and
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">(float(curr_io_pressure) - float(self.prev_io_pressure)) &gt;
self.rq.max_io_pressure
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">- exceeds_memory_pressure = self.rq.max_memory_pressure and
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">(float(curr_memory_pressure) - float(self.prev_memory_pressure)) &gt;
self.rq.max_memory_pressure
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">-            return (exceeds_cpu_pressure or exceeds_io_pressure or exceeds_memory_pressure)
+ exceeds_cpu_pressure = self.rq.max_cpu_pressure and
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">(float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) / tdiff &gt;
self.rq.max_cpu_pressure
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">+ exceeds_io_pressure = self.rq.max_io_pressure and
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">(float(curr_io_pressure) - float(self.prev_io_pressure)) / tdiff &gt;
self.rq.max_io_pressure
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">+ exceeds_memory_pressure = self.rq.max_memory_pressure and
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">(float(curr_memory_pressure) - float(self.prev_memory_pressure)) /
tdiff &gt; self.rq.max_memory_pressure
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">+                self.prev_cpu_pressure = curr_cpu_pressure
+                self.prev_io_pressure = curr_io_pressure
+                self.prev_memory_pressure = curr_memory_pressure
+                self.prev_pressure_time = now
+                self.psi_exceeded = exceeds_cpu_pressure or exceeds_io_pressure or exceeds_memory_pressure
+            return self.psi_exceeded
          return False
        def next_buildable_task(self):
</pre>
            </blockquote>
          </blockquote>
        </blockquote>
        <p><br>
        </p>
        <pre class="moz-signature" cols="72">-- 
# Randy MacLeod
# Wind River Linux</pre>
        <br>
        <fieldset class="moz-mime-attachment-header"></fieldset>
        <pre class="moz-quote-pre" wrap="">-=-=-=-=-=-=-=-=-=-=-=-
Links: You receive all messages sent to this group.
View/Reply Online (#14835): <a class="moz-txt-link-freetext" href="https://lists.openembedded.org/g/bitbake-devel/message/14835">https://lists.openembedded.org/g/bitbake-devel/message/14835</a>
Mute This Topic: <a class="moz-txt-link-freetext" href="https://lists.openembedded.org/mt/99079426/3616765">https://lists.openembedded.org/mt/99079426/3616765</a>
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
    </blockquote>
    <p><br>
    </p>
    <pre class="moz-signature" cols="72">-- 
# Randy MacLeod
# Wind River Linux</pre>
  </body>
</html>

--------------A4eji8znzk3ly6JWg3cd71vt--

