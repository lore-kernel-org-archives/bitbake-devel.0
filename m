Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB1BC433FE
	for <webhook@archiver.kernel.org>; Thu, 10 Mar 2022 10:54:09 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.88])
 by mx.groups.io with SMTP id smtpd.web10.8133.1646909647476025216
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 10 Mar 2022 02:54:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherrycloud.onmicrosoft.com
 header.s=selector2-cherrycloud-onmicrosoft-com header.b=U0tdjv4f;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.13.88,
 mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ess/CFzV7cvUbl9f9wpnbQBVy6wUrC558GtDGwG3FJnNQipn0xFC+0HQKPlCX+W/CIidh2ta3xzjcij9uiESlqC0yrNBTpzjE+gFKQqaSa0za36yPjcTb7PE8etJzKyRvhS5hcMhqVgXmUcsl+mp0queNtt+ndaFrEktWeQgQc8tHHxNCAXT1/2LAfi6kfpnXpLqnbH5GilULVAnz3pxu+J7SLbAGo7wfm2XcUuhgmBjrTQQ1kwkTfw4WENn6y7e83zZYnB0yX8yPQV6T3dcarQpFYIZ9p/vGDjowYSP3MSBJe0xyg+ofgY7ABliGD8OCjQakeyBSoBjdqU60tZLhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ab+NYDo1n6WbyW9YP9XN/RC2m5JkAPtN98rbfkGW/aY=;
 b=W95YSYYyFmUk7uGaRhEaqMTDNxdk6YTBgMZxkrh1g8Z/5Q1Q3jfjdZYBHgWTXMflMpP6zneRiVJQWegd9O0Ye4LY9mykkK0D085JDqIj8485aidu4rGHU/3OLmtWxH9g1aFqaDOzdhvmFlb3H0HObJIb79hmZXEUx8aMG1Fnm7kq9S0xjHDwgLqc2yLhvL+ZqCkzzqgCfkXjfDLaCNyfnTyYXPPpACIeuSXgkGAzfVQpzG3ZM3xN867BXzzrzFXSVHQ/J8oF9zKKkV3hSxN27DENeoAPW4JViLJw3kG4GnBxszig/s75rHOFI7jqYhr4R/P6nis3P3rr3hKS2qFQBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ab+NYDo1n6WbyW9YP9XN/RC2m5JkAPtN98rbfkGW/aY=;
 b=U0tdjv4fE306uR6QH4yGtVpDApJrkJRGbCHUYzUWnR6g4iQgEeA1JTjOymQGJ4zQQNCrvxZc7RzIi99umQ5U8gFvy+vpqWmwY7YYP+PmU7R3scwj5+23iJma9vxj5N0yTQRX94tchex1z8dPz01tvmbNzj1XTobQtQKrauJWuhs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7)
 by AS1PR04MB9261.eurprd04.prod.outlook.com (2603:10a6:20b:4c7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Thu, 10 Mar
 2022 10:54:03 +0000
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::ecac:a35b:6947:e7f3]) by PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::ecac:a35b:6947:e7f3%9]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 10:54:03 +0000
Message-ID: <b1392865-9754-dd70-8278-42a067277380@theobroma-systems.com>
Date: Thu, 10 Mar 2022 11:54:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [docs] [PATCH] bitbake-user-manual: add note about the old syntax
 for OVERRIDES
Content-Language: en-US
To: michael.opdenacker@bootlin.com, bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
 Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
 Richard Purdie <richard.purdie@linuxfoundation.org>
References: 
 <6035008ce96fb9055547cf0cc2ffa51d2262c9ea.camel@linuxfoundation.org>
 <20220307183803.534661-1-michael.opdenacker@bootlin.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20220307183803.534661-1-michael.opdenacker@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P195CA0025.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:81::38) To PA4PR04MB9367.eurprd04.prod.outlook.com
 (2603:10a6:102:2aa::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e0e82c6-c73d-41a3-baff-08da02844a99
X-MS-TrafficTypeDiagnostic: AS1PR04MB9261:EE_
X-Microsoft-Antispam-PRVS: 
	<AS1PR04MB9261EC15A2376D3B224D61DCC20B9@AS1PR04MB9261.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	OC72UriM8g+gzlsdDRVP6c+gx4++YOazjIV7uuiyynMYwAPEcQyUhsE76prFAz/DS998GmOw3uFf3/4QhGkeazV8nOQAenRnsWgbCKhJkNR6yIFwuBduMwlaAyfhxk8TpPL5DWW7gXKncIUnt/nqsUdYxwCp6lH1AXx59VNue1t1u9OT8cBTmTveT1OhyPDc1g0HGEd7Kd3d4ODp47dd4MmbhLiXsmAHtmN3lV35J2xm2WT/NidQWPvMp+MT3lNwTr/Z2RPWkPGKiyb9rZJzROLlwC0/dU/bSyYvpbntu1R+SRAkq8prjjd43wCbT4FxtJMDlFzcWRklqA4bfO3Kj21itU05AFYYs5iJ01gT2tzSJK2HkgVKYCLpAkYIkxkNZUlCaH8ZvJ6VMrxnAZbrk4k8xk4KzMFAXdFz6PbAqNWUTgNwZB79cG4TbXo59//P8zhSKsy2C5Y8oU//Obmp31ftsdpGZoNwMvTU1xLJO1wzlYeh/ZhmKeOtaZ6YoRs43gxas0fGjBMmIVwuyfeEniqymVy2QzZafDUHhalr+JC0XyJoUZmEilqzTK70adabuq7aYshxTuGv4XM/zFK9XLb7dUDCaKJ/DFxHgH3xF7wCaDEaytw9pudxCS+oTQ57ApCWsb9g4wMKjdLJTEbAJMbOxTr55ktaOjYGz/tuInoI5WMYj1DNPN+WUWMJU1u2gZNRQHJ6TRYVnqQ337I2nQrm5SiKB10+2SrQ92TUbxA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9367.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(31686004)(53546011)(316002)(44832011)(508600001)(5660300002)(38100700002)(6486002)(6512007)(36756003)(186003)(26005)(2616005)(6506007)(2906002)(8676002)(54906003)(86362001)(31696002)(4326008)(66946007)(66476007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UlJtTXFYYW5mRVh4T05DQmV4L0lsWmFSbEZncDRTZ2FCRmtKY1VnRFQ2RFY5?=
 =?utf-8?B?N3RpQU54TzQzQWo1NGgwa09GTFUzWGlJbHhsK3lkbHdGdm5PcmFUaXpaRFdX?=
 =?utf-8?B?bWtodGZvZnd2VzFieUd2ZXBDY0FFSkhsUGpmRTZIQ3JWa00weGZ3eFhFQ2d5?=
 =?utf-8?B?VXRzSWNRYzNlRFJKTnJsSUJweXdTY3QxREZ0TjUvK3pIWXZpRzJjR2ZTekJB?=
 =?utf-8?B?SHI5NTl0cGk2UTlIK0NmOUJJMGhLQ3NCQlY2NWtwTzVhNnZmV1NHeXhnc1Z1?=
 =?utf-8?B?RzdYVzZjZTRnZmVBc0VDdnlWY3kzaThHb2l0WDk4TlJnQUNiaU84OTcwMGNR?=
 =?utf-8?B?Vy9PZlZYOEQxQ1YvVm1nNkpVL3l2TnhxN3ptV282YkR6OXhzYnJobVJCWERl?=
 =?utf-8?B?TVdTN2lIVy9sZ2o3TUlXYUxtQXBKWGsra3VWYkVDbmJ4TGdTUEFHYTZiMnkw?=
 =?utf-8?B?VzhwcURpUUo1alhQNXpvZ0s0RHh3RDI3YTJRL0V6MEY1NEI0NVhIc2NTUG0w?=
 =?utf-8?B?NER4WUlLb2svQUJNNFFtbUY2RSt0RHk3bjY0Snh3NXhpWkc5ajhTZ0k1Y0Nu?=
 =?utf-8?B?RkREVFZsVnljV1NlbnVZRS96WHY1TWY5S0VMOGRkZUkzYS9FQmdXK1R5MlhP?=
 =?utf-8?B?ck5vUW1mOXBRYXRHRnRidEFpT3dmYzQ1dHNhbW1rNXRaSUVJZWhHRDcrdVZr?=
 =?utf-8?B?K2U2ZWRlaGFHeDMwaHJwTWFSdG1rc0tMQkpvL3Q1U3hYY3Y1RG5oSkRzaG1j?=
 =?utf-8?B?aWIzanVEZVNJTVZJQ1I0eG9Oajh0b1ErT2xLamdRYVpSa2UvTCtSMFNZZnZr?=
 =?utf-8?B?RDBDU1lGY0xPSFlmc1FZU254R2J0Z3lXOUhGNU9tQmEyVGtVdGNKN3VFZWs5?=
 =?utf-8?B?TGE4VEdHaU1wZDVOZFNnRlVrZUNpYy8wcHJ3V0tvU2JqMkJZWWx4NE00OHVx?=
 =?utf-8?B?V0lwZUhFalE0c2U4TXRxZlh6Sk5Wd3lkOEpHMStMVXIxUURtYzhTNXlBblBv?=
 =?utf-8?B?SVpoUmFZZU9oNTNOV2FxNjFWSXVkMi9BbHpVVlJXNE9OWTkvR29yQ2h4emV3?=
 =?utf-8?B?c2Y1Ym90VTN5dlVxd1d4LzBpbGlXWnpOazROUDZmL3VMM3U0am9hVGVXMW1O?=
 =?utf-8?B?SVRkNmp1S010b1NFcWt3V0FLeTJRNGJ2QW42dGNubm1uL090T0ZKbU5PQzFQ?=
 =?utf-8?B?aHdVNThQZHpkRG5pSkg1UTNMdTlKTnVOTkQ2dWNrTHNwd0tGSlRzWjh6NUxj?=
 =?utf-8?B?VWhPc2dObjQ4SmhPS2dVazM0UEdIaFpHc1lGNVE4ZjQ0UjAyQStvYSt3NUxp?=
 =?utf-8?B?RWhMVS91eG1wMGE1U0RxUTlOdVJoOXNUYW9WMlhtS0xtdGpIWVUvaFk0aEhI?=
 =?utf-8?B?UWl2QkY1L0JqVDdmNXQ0NTFrelUxRjk5SUxFUGt4SXFUQ2U3dnE4dkN1Z1Mr?=
 =?utf-8?B?bS9vTnBtRzNjaGNTL0w1cTR5Zm01SVVNSXZYcjlObVFpSmZPRldEM2dkQktR?=
 =?utf-8?B?STd5S2I3SExDUnNhSGpzUHNNTUQ5L21PNnZvZFdJRE9CcCtiTGZPaFRNVi9k?=
 =?utf-8?B?YkxjUmUyRFhXeW1XR3JDWGMxRHRPNytmVklCd1JHMi9uSDFtTER2Nnl1MEFV?=
 =?utf-8?B?a3RjMkQ5NDliZFQ0SmZINTNBb3BOS292NjZlNnJDdEV2K2w1bUFoU01COG0w?=
 =?utf-8?B?eHczT1NnNU9uckd3MHFyeWVxcTlNd2ZJOG56bTdqVEVjbW9xS3dvNlJOZzZN?=
 =?utf-8?B?RDhrZUxNZGs4S0xHSHNPWHJ1YTlUenlwalFrT0Z4NlBNbDJWeEg4WTBlQ0Nl?=
 =?utf-8?B?SnNsZ2pLUkx4MkMwT29iVzAvK2Y3Zm50b2FIZU1QTXg5TEtuM1NHTzZuQ1lt?=
 =?utf-8?B?OTdCcktOVzFPcXluUHFWMVphTGhCbENpNkVjTXNmTS9UT25rd1ZacGtWNHdQ?=
 =?utf-8?B?NHdaQVBjV1RBeU90THNCKzNWSllBMTVuQnRkWXdQQnJEUW0zQ1YrUVlmVnNp?=
 =?utf-8?B?cnozblUwbHRlalZqUjY0Y0U0MGppc1BQUGZuRG9IdlFvNFVNN0puWlN0WWZE?=
 =?utf-8?B?c1RVdlRsUm1UeVBzakJRWUpOZVRyL0Ixc2FTM0ptZlVLbW5xeWIrY0FJUENO?=
 =?utf-8?B?anRaMVNBQjVaRDhxWXdvM1RNK3Jtb2dGakdzYlVGTUpVOEk4N1FLZjVPUGxB?=
 =?utf-8?B?R2s0SXZyR1JzY29uQkdSZHpZdXRBcTBQSmJLY1hSMkRKenNCU2Vvd251RmxU?=
 =?utf-8?B?VWM4WENxcGpUNmN1L1Frb2d0dEZPc1NHTXR2a3g2Z1Bhb3lqVnNuMDFMRUM2?=
 =?utf-8?B?SVpTSnZNZkJLMGVOLzZIa0sxT0NXQkpINk1DdHJXaHhWOFE2TSs3Zz09?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 2e0e82c6-c73d-41a3-baff-08da02844a99
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9367.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 10:54:03.8123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 1WWNOntoYYJoTd69jH/f30dQIFSa9gk+VQrjqogogF1euRja8V6K33alvfrJm35QZNWx0aLGUz6/37uyeobI8e3XOnxz4jDVbteln9iyU6EemVgm7a57eopRDxYQoapp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9261
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 10 Mar 2022 10:54:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13461

Hi Michael,

On 3/7/22 19:38, Michael Opdenacker via lists.yoctoproject.org wrote:
> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
> Reported-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> Reported-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>   .../bitbake-user-manual-metadata.rst                   | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> index b90e5cf0..97114ed6 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> @@ -585,6 +585,16 @@ variable.
>   
>         EXTRA_OEMAKE:prepend:task-compile = "${PARALLEL_MAKE} "
>   
> +.. note::
> +
> +   Before BitBake 1.52 (Honister 3.4), the syntax for :term:`OVERRIDES`
> +   used ``_`` instead of ``:``, so you will still find a lot of documentation

We should mention that we're talking about external/third party 
documentation/tutorials and not ours :)

Cheers,
Quentin

