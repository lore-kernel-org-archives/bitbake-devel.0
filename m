Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA66C25B75
	for <webhook@archiver.kernel.org>; Wed, 15 May 2024 10:15:41 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.102])
 by mx.groups.io with SMTP id smtpd.web10.11274.1715768129074947991
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 May 2024 03:15:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=EuIBCqfF;
 spf=pass (domain: cherry.de, ip: 40.107.8.102, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WV0vCgYE3eSY2Mh9O87Cc35mS1PUQntR9qOfA6iaP9qzwB6czSoUQD1rwWzo9cD+RJpy72rYojeT7ib7MXdXMT47RKx3AGIw531DAjMrLcHO4bIrsFVenFe0//fizzJKEX+Wv/RUk/uzJ/g0BW9FhgupUeB6XDDhTYM6Gf2DZ2VBW3XIConWrclcUmKJl1KAQkmaMIjGOCvDDeO2/RcumOmmnjxM+5cwNgI7jTJHrkhMMwELcINu3cjColLnWzard+lgA08BQ0OnR+WlEkTeOLaqrSB4PYgB5goHqVrGCwm4LTXcIuPCA1AWm3r2a0mo8Eykea8SJZPrnNDP1bX+hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFYIBx+uD7arjfOR0OT51OYXWX9AwlIRRbQzwTEXdGg=;
 b=eSyN9B3NxDW3o6GB1GCfKz3Wh0WFf6ihWPrfJ9e5OFAeEuvFHPc4KblGZ0019JBqTg9AXDbfdnDd4EKgNmXRrB6FVq6bEgE7uhp25zqIYjtZxNV1Zasm6VJmow4c7uQ4pWk/rVD4xxAU5XZ6EE6de7NJ8v827WB613Yd3LQ2hKD0Fj/p2PNZXvWQ6cs0zSRhKiDlVJNwGW6vjglpIeSUahwT1QofG6LXfsU3qXn9iJZMziQx13z+Udq8vQSCTzRJyFfdUajWejDIAqCHe2pv8Q+cgmSBkVmM9ktN8pJAtbtqxrU6ggRVMX7/d7yozDVFiQdSpm8dtHv8JWW8aANQPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFYIBx+uD7arjfOR0OT51OYXWX9AwlIRRbQzwTEXdGg=;
 b=EuIBCqfFQophu7hJ+AxmSRbZGii9/1qAF0lXH6oO19BPCSnUlbUYHnREUBrlDu1pu5Rkdpo0tb6qQM4UO+gEYS+XiRl9YP1GOEOufW+eaPgnNg6avsv/Jj+1YQ6WUD1RSToGj/NN9wsb/xo1tL4UKn9RDkW+M6lI/UP9NuJGEQY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com (2603:10a6:803:128::25)
 by AS4PR04MB9622.eurprd04.prod.outlook.com (2603:10a6:20b:4cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 10:15:24 +0000
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31]) by VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31%6]) with mapi id 15.20.7544.052; Wed, 15 May 2024
 10:15:24 +0000
Message-ID: <811a8c5a-747f-4331-8d8d-ccf6324961e9@cherry.de>
Date: Wed, 15 May 2024 12:15:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH 1/1] fetch2/git.py: Try without '.git'
 suffix firstly
To: liezhi.yang@windriver.com, bitbake-devel@lists.openembedded.org
References: <cover.1715765153.git.liezhi.yang@windriver.com>
 <4a7647c4169ffc0c70858a4a1f1b2eb18ffcfb70.1715765153.git.liezhi.yang@windriver.com>
 <367b25fc-4d5a-4a1f-a259-55e2325e1a34@cherry.de>
 <b1399680-6f22-4477-ada4-8a718f807237@windriver.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <b1399680-6f22-4477-ada4-8a718f807237@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0043.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::28) To VE1PR04MB6589.eurprd04.prod.outlook.com
 (2603:10a6:803:128::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6589:EE_|AS4PR04MB9622:EE_
X-MS-Office365-Filtering-Correlation-Id: abd7757d-6253-43f7-7d13-08dc74c7ef18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?blJQWXkwZDJtRldaOWF6RG1zVWsvc2tYOE4rMTdZMDNXNTI5VGgwaWMyaEJa?=
 =?utf-8?B?bElkSXByUytTM1EwSmhsUDJNR2ZTck1SUm85M0QyVXo5S0VyM2xIS2JQMkQx?=
 =?utf-8?B?MmhRS2g3RWtVNG04NFNlUFBjVEl5N3pkeFlEaWNKeWJzYUpyRUVjRmpFQjR2?=
 =?utf-8?B?dGx0bXJyZ0FQYUNRVGJ0VEVDZGt0dklKdDZmTmlmMi9LLzZhL1MwTVRMMmFX?=
 =?utf-8?B?cXhxUnVRanZ5NjFhUVNJRVZXeExDUWZWeXRFTnkrMTNIU25remZmL2NKcHA1?=
 =?utf-8?B?K0lqUXVLbnNwVGdWNXlDdyt4VXhEblpUWUsvYTBodzY2b3BmK3JiTmt5THVI?=
 =?utf-8?B?SU9kWXQ4L2lVdStuTXlUbWU5NlZmSWtSLzBzWUZnT0ViTHgyVDczVVQyVjJu?=
 =?utf-8?B?WGdFKzZ0U0xjUTgxUHd6U0t0VUc5ZUdnT0puaFdVaVJ6UElDR25xZTFCY3FW?=
 =?utf-8?B?WFZtQnBaZnBhQms4aWFMVFpKQW94RnpDUWdVZlFMcDNURWgxRC83eGE1V05l?=
 =?utf-8?B?Kyt3WUE4cVVNUndRVit5Z1A1THVSRzBMazdkMmdIUm5HRmQ2dkV1dk1zQ09w?=
 =?utf-8?B?SE52Y3dOYS91R2ZJN2lYZWJuY2ZlNHhyZjhkSWRsb3EzZm9lM2pzSWlVQlJF?=
 =?utf-8?B?WXlKVHhjZnVtQzlvckNLNlVpNnVqWkxlZ1gvNDNmaWFqeFhGNVcxbE9QTmdm?=
 =?utf-8?B?VWdkWnFJUzBpWWFOTFZncWtNVll2bmNWbnZOT3VuR2p4RWJFZHUrWm9CUWpj?=
 =?utf-8?B?ZVRGY25kOWR5SUUzdytacjg5NXp4dTlHSkx2OTNHbnhqZTJXS1Nrbkt4ZmJG?=
 =?utf-8?B?b1plY1U4b01OQ2NGNEtoUlhPQ2MrcEpwQ3daSVdjbW5rcFhwVmJScm94WjZs?=
 =?utf-8?B?eWliTW9PVVZBNmw4bUgzMVFmZkxJMVllMDBHRStrNG5NQlNoNVFLRU5hcGxK?=
 =?utf-8?B?MW9JNFkzemp1NUFxcFpJdEFlYzZzcVYzSXNONmEzKzlTVk1QMmZnS3lLZ3Ay?=
 =?utf-8?B?ZnRsbkNxNW9BWEg1MHd3b3BwYkxwc1FQR1U1b2RkdmNRY2hXejZyUFVPejg3?=
 =?utf-8?B?aVRBUFpaTWRoeGphU0crSTJ6NDRvRUJxY0NOQnd0eVo1SmREQmozdGJHM2ww?=
 =?utf-8?B?dWcvdjltMkVzQVNEak1Edlh4SE04WHlnWkxiZnEyK1RQQlFTR2NOdS9COXNV?=
 =?utf-8?B?RWR4bjJMMjhKekMxSi9xa01GZTZMbXNOYlNBQWhRWVplR1hLTEI1cVdUSnB3?=
 =?utf-8?B?WlhPS2dNZnY4VXhLZEQ0MGNUdmZITnFqNCtZLy9JU21TblpwU3BGM2hmeWlX?=
 =?utf-8?B?NnhMVlRkQUtaaS9US3pzM213aU1QL1NGK3hFbVpycUVjMTcyRTJXUUd0K3E2?=
 =?utf-8?B?S0J3WU91cGlYcnpobDBUTmtKMHdheVczMWhLNGZWU1JDVHpOMmowYzN5eEc1?=
 =?utf-8?B?STVGdmpIZHgzbmxBdFBjdTk0Y3FUTzZWMDRPdFBaYk1qaFdQd3F0Zm9BeTB0?=
 =?utf-8?B?d2UxbVpId0xCV2ZXZEdhQzNMTzZaeE9tNEFza0ZmVDVVVjgxSktsMEVBMjJB?=
 =?utf-8?B?aXJ6Q0JDOXdsS3p0RkM0aStkclY3YzdPOXBTbGZITEVyTms2VEdZNVpSdDE5?=
 =?utf-8?Q?jn7MFwkpGgomGewPd4YhPk8bL3Dh+rpvZlnzScXHTA+0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6589.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YlpoTytERXRaeUFzS1U3cDNaNHE0dW54dU4xZVk2NXNOUTB0OEc2bDBwVEh3?=
 =?utf-8?B?YVpkU0pscmZBQi9BZzA1aU9GOFg2QXlMRkNBMEpCS1ZBYU5OaXlaa0NqSENS?=
 =?utf-8?B?d3F3cVVzdUloVWRNOVJVbGlaWkFZYmZBL1ZXbS9mZkRZNlkwTFZJamFTRVNJ?=
 =?utf-8?B?b1czNm84b21pVjRFVXgrRHJzZ2RBN1JGNTEwWTRtWlZGQzBmSUdscEdxYjlr?=
 =?utf-8?B?L0pOOERnd1lUMFFHOVlYT1YvRjhhUXd1NlBDYTBFV2F3d1hxL2E1dXU3dGpp?=
 =?utf-8?B?VE1zNjhreGRsMFprTDhuTHJiK0VwQWw4cXdENXBYOWJ5RkJUWGhVTVdNUEEw?=
 =?utf-8?B?R2lLd3FCc2hoMTB0T2ZsZjdUUmFSWkZDUkg1bWNjeVZwL3FzM3BlbnU0d2dK?=
 =?utf-8?B?bUNndkRHeGFMdm9yZ1lXcTBTT2gyYlpJZUtxSU9CMUxPQU04YlU1a2I0MFor?=
 =?utf-8?B?QThaT1RJcE0xQVNRbTR0T0lVaDQ5RWZ1dU1HNTU4amVLQjNxQWlMQTlGeGpN?=
 =?utf-8?B?N1BnN0MrcFJHVzQ0UWQyUCs5MFVRY3Q0T295Y0ZDNTZGWjl4VXdDVk1BZGRv?=
 =?utf-8?B?TzhYQjdPdzlJdlVwWlpla29nTmw0OWpGZllPZWhtVGJTYUdzZGQvNGczVDgz?=
 =?utf-8?B?eUZENlE1MmZpSkhXU2xsaE5NM3BJWDQ5L1JhNWs1ZitOL0tCc0QxcDBxYS83?=
 =?utf-8?B?U29nMFp6T3JFa2JRTVNIdFJFT0szZWg4QklwNHpTQlhTV2RENm1VT2lhRDRX?=
 =?utf-8?B?SitidGxRQ3huc2UxZTJCT05rRjUyVTVWQlJxZjJ4aE9WUEpyc05iYUxsTHFi?=
 =?utf-8?B?WWpqK0Npd3dXZjJEQTg1WmUzd01JRlAzbTZ2NE1VRXdmWGU4VUh6RFJaWFVS?=
 =?utf-8?B?RmF6NklkcjAzdE00VUhCMVd0ZUJybWxIdldLS25BN3dxNkdQMnVycVZLb1hl?=
 =?utf-8?B?QnQ2eURWUTFvZVE5UmxhK1JSdS9PLzlEN0Y3K3ZzSlhoSE1ESHBlNlo5Zkpj?=
 =?utf-8?B?Q2IzNkQ0Y0pYNkpPODd4eXpmN3VMVjhhQTVSZ3A0ZUR4d1U0dnlrZnlPNkpy?=
 =?utf-8?B?elFiZEpmcjhRSFYvQ2wyU3A4SFVOSFdBb0UwV3J3Q0FpN3Q5UENybC83VkdG?=
 =?utf-8?B?MitqOHVBRGNIbGZrQ1VjKzAyWWNvVXNwRFZaeE1mdk83VDlPZTArckVsZFFB?=
 =?utf-8?B?NmpPbWtwU2ZjVnN2SXhyNDRnSkVZNW5mYWozZ2xyQVdrZDNuZHkwR1g5Tzcz?=
 =?utf-8?B?TmpyR2RzVkhua1k4R0xEaDBVSE03dTVHL2pYaldoak9ubHQxWmR3L3NTVFNF?=
 =?utf-8?B?TUNKY0FWMmNZTmZsTXVRRXVGOWt5ZTJZNGdaSlZUbkMrbXF0VEZSK2VwNWs0?=
 =?utf-8?B?Tm9MSUZrMmhscXY0ZjY5L3RNczFxTHVBOW1WanB0cDVubzU4RzE4ZVN4MnBk?=
 =?utf-8?B?Q3hoS3BsZThBOW5BQzJPMGtJczJkbDdsem9FZGUyV3J4TlE3MWRaQVNoRDZK?=
 =?utf-8?B?MThhQWFOWGxyMU1IQUpBbWVCcWRYVTRJNFo0ajFGRXg5MHRkZjc4eXFFa1hu?=
 =?utf-8?B?bndZcFd3em96RHBoRmljMmtlckpBMm5ySVliK0RtZWhzSlRhd0YvV2oySEhU?=
 =?utf-8?B?aTlDYjRhK0F1alJ5c0VVUy9kYnoxSW1QcXFPSDVnV2RtUnBLMEF2azR6TFY2?=
 =?utf-8?B?ZUxQM0hJQzRNWGlnMm5tK1RtdHpZdEh5TWdMcmo3dlpycDhKRFdIa3BseWs4?=
 =?utf-8?B?Mk1JM2xrRjkxbEE2SmtwRnZiK25EdlgrZGkwMDI5Zk0rbkl0clI0d2Rvamdq?=
 =?utf-8?B?QWxXK0Q0UE9wUk1uc09wYzJPYTQxckt6OENVT0s3by96VGxOQ0dRYmZVTjV0?=
 =?utf-8?B?QllTUkhFNFowTUFzTmM3NC8yc1Niem8xOFNTWEhEdW5ZUjIxMVQzazlTS3Jq?=
 =?utf-8?B?L3U4dWMxNXlmZEdJSkM4dlhJYXNDTnhzNVlWaTBMMU5GY0lHaG95YVdUNElL?=
 =?utf-8?B?Rm1lNTZKNlpOSUNISnBkbjRCdWhGR2NoOU9YQ1huaU1sWVRyb21PMTBUbSto?=
 =?utf-8?B?ekJFM296VUt2RFNUZVlLQWJYaG5wL1pZR3RKUVQzN0pURzg0N2RVUktsSGhi?=
 =?utf-8?B?a0NKRFIySU16LzdUakZ5K21xcHFDNS9uUjc5bkJuVjFOeWRLVFRUSnFrS2VB?=
 =?utf-8?Q?rZc5moCUFCdyzr6SBZaPX1M=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: abd7757d-6253-43f7-7d13-08dc74c7ef18
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6589.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 10:15:23.9536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I7yrIjlCMW6ZKnyMRbRoZTfZ3f9lDncjbsCNB4TPQ+3WNNBBuHlMNomjO9Q/5FGj1cGn2Nb91XoYTW9xzZKrD+3bq/g+Ka2byYeiMLaP+EU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9622
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 May 2024 10:15:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16223

Hi Robert,

On 5/15/24 11:57 AM, Robert Yang via lists.openembedded.org wrote:
> Hi Quentin,
> 
> On 5/15/24 17:35, Quentin Schulz wrote:
>> Hi Robert,
>>
>> On 5/15/24 11:26 AM, Robert Yang via lists.openembedded.org wrote:
>>> From: Robert Yang <liezhi.yang@windriver.com>
>>>
>>> If the repo on server is foo.git, both of the following commands
>>> will work:
>>> 1) $ git clone <url>/foo.git
>>> 2) $ git clone <url>/foo
>>> But only the second command works if the repo server is foo
>>> (without .git suffix), so try without '.git' suffix firstly.
>>>
>>
>> Shouldn't the SRC_URI in the recipe be fixed instead of the git 
>> fetcher? Which use case do we need to support here? Something to do 
>> with mirroring maybe
> The usage is related to repo command + http/https mirror:
> 
> * The foo.git on http/https MIRROR works with do_fetch
> * But 'repo' command always add a '.git' suffix to the reponame, the 
> foo.git
> will be saved as foo.git.git on local disk, and do_fetch would not work 
> with
> the local mirror.
> 
> Our solution is rename foo.git to foo on http/https mirror, and apply 
> this patch
> to make both http(s) and local mirror work with repo command.
> 
> It's a little special to our Wind River Linux, and we need send the 
> patch to
> mailing list for Yocto compliance.
> 

I'm not sure this is something we should fix in BitBake since it's 
related to the use of some external setup tool? I'll let more 
knowledgeable people discuss this :)

In any case, I would suggest to really provide more info (the one as 
above for example) at the very least in the commit log, and even better 
in-code comment so that we don't remove it the day we want to de-clutter 
code. The issue is that this looks very much like code we don't need, 
without proper explanation of the use case (which you now provided).

Cheers,
Quentin

> // Robert
> 
>>
>> Cheers,
>> Quentin
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16222): https://lists.openembedded.org/g/bitbake-devel/message/16222
> Mute This Topic: https://lists.openembedded.org/mt/106110992/6293953
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [quentin.schulz@cherry.de]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

