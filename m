Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95645C352A1
	for <webhook@archiver.kernel.org>; Tue,  6 Dec 2022 10:29:21 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.83])
 by mx.groups.io with SMTP id smtpd.web10.44628.1670322554803950014
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 Dec 2022 02:29:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@theobroma-systems.com header.s=selector1 header.b=Zda2beY9;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.103.83, mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9QEojF64939kcpBr5kswRPEqUlBj0AfM/Qyz30X1m10GO+pVaZv0zyc961OhxBe+OqeDmIOacOIP5LTNpTZpoo0b7S0BkEHzSB8IcRIm8jpLocENMBQ3imWEy7RZADXHru8n/hBMBSjHmuHltcUKuDwPueEIgmgT/+AE9hI+6j7ORbdOJSp6nrqTVeb/gfOEhejrgFSve8pWDfRnfxPv8jPOpfl6rdlL1HqAySuv+zOyrv0ldhA5A7w4IHivuQGvILQKi4vY2Ff/VY0eF8CqRD+FcGhIZJV9U/nOQwnhYHDZkH/2nD1F8gpdvcxdFXI5i3CfXbvnkuu2KLYCJoLeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yvsqrV8o+Ei2RdObKu48YhJb7ikTcbguL4Pgb2+4bgY=;
 b=jzdwv/cGzkKaQf+BZc0mXZK037+AMbWJVDXOBf2uBzgsNdSKkxFbFEtiHvKgd76YdYPzFkhZPo5AwsUf8aXGgV7Btds8dqJ0GTHOAYoFhE5L+FUHy85cEDmDNpUK50Lul0hIm5tDPdwm/Q3yhOrd1fA03CH7KY+t9VGkX37blvoXdkNzH/gRERhJKVmB01VrpqTZ2Yq+CAPt+Mx0q8PYjjK8vr49sDoldGM1bcCa0T6pWOwvljDdzHgMYKCPPgtf2nLC0tdAZiJikdS/oNxlaLWfJREeqZdwxoX0ygYBnSVVybeBSgz8PGG00H+AqeEgAN7vO1g2ja3UuzI9Kseayw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvsqrV8o+Ei2RdObKu48YhJb7ikTcbguL4Pgb2+4bgY=;
 b=Zda2beY94XrxKm6qKUibMUdophw3qO5WxvHHDAyMp56LDjlS4/82VnibwzxCjKwqlJrC01BDvJyG5YMTPLlDEzHJrzBe49u5+sBLnPydzRlMXNu/MWQRCeXasANnhr1scrsY20ceN7yxA8OhIT8sdFvfu7fE3dtXJx2mqjw6ptzdtOBjBQORw5uetf00ixyckWjoXy0suU06XbDtYKBpPLhK43OUhiSXXCtVvlF5pnhxYDB0ZmN/iAaHQknrD9uqRpW6+jwpiyAOzoXCnb8SdlWL9KyWYdYg2aW2ZCUHP7Urhtin+/4BOw/LNU82Q1nECF3kfyYk4fk4eU/VMo6xFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by DU2PR04MB9084.eurprd04.prod.outlook.com (2603:10a6:10:2f3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 6 Dec
 2022 10:29:11 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::9ebd:cd48:9396:76f6]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::9ebd:cd48:9396:76f6%6]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 10:29:11 +0000
Message-ID: <338c18ae-d3f5-ba03-3ee6-59be314377e1@theobroma-systems.com>
Date: Tue, 6 Dec 2022 11:29:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [bitbake-devel] [PATCH] fetch2/git: Prevent git fetcher from
 fetching gitlab repository metadata
To: Marek Vasut <marex@denx.de>, bitbake-devel@lists.openembedded.org
Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
 Martin Jansa <Martin.Jansa@gmail.com>, Mikko.Rapeli@bmw.de,
 Quentin Schulz <foss+yocto@0leil.net>,
 Richard Purdie <richard.purdie@linuxfoundation.org>
References: <20221205220019.19650-1-marex@denx.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20221205220019.19650-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::19) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|DU2PR04MB9084:EE_
X-MS-Office365-Filtering-Correlation-Id: ba269495-74b1-495f-faa6-08dad774b6c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	tmdHyrn7VZfcbgzVYCq5HAgi67/CNFatVIYzWkflleqeO2M0ZlvthKVcLqAAXNjtWXBg6nqoxsVm0yzTcTujjquM38LitcKqqRLZfpsBF8sahxQnZb5rcx1rc6S+iTSHEeRqbNpe9sMWL7yWnu7ml07Vnu1H94hc/ABkNjfU4pDGlizCu67J+OO/9JirkWfKt5zlfmfqnTSFWKUiV2Xx2V1QIWsopSZ+luw+b500pUgZtHtTjql2IuqaMIZLrvRQdSjws1+/Y60KQXQoFl8wGuCNC6UKLf22VXJs8uHo9FmbdzsxZbI3HRKBGXrJPeyuPiAYBvADVIJnTedvaSaNgPD/iyPzbPTxHF8Txp3fZAd+qEzby0GWc1llT7abOawb1/5Q4D5SEpyCqA7yDSHfiG0p13feXGVDslqJe+0XsUmFIlqAeduzIPA9uwfytxqtCiSgujV/W5xDvBZeUjKTq3vlMivmjFBe28ssuxu81wbgvYiouqE0W/5e1WSJZGGgekhPtkDd8neG3Pf6DNGxkvUUy3QznfktBTO5C5Axvjv/BNQkMX3gwlVKZ3DHRfXwmHRx2BJrGshapRRfD1feM7pjttZz0HFjlIpvzfi831Qy1MoXQ6FmuDpK8q4tGEPwjq/tLampVT53ArGnJe9bXaay8qVjSYRxGKOZGPPDTltocAZNNXL4F430ND6SUcz9okk0cP7w2Esn5qvXStiqycsOltFhMO7nhdAGAPmsqT8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39850400004)(396003)(366004)(376002)(451199015)(44832011)(8936002)(31696002)(2906002)(31686004)(38100700002)(36756003)(41300700001)(86362001)(6486002)(2616005)(186003)(478600001)(5660300002)(54906003)(66476007)(83380400001)(316002)(8676002)(66946007)(53546011)(26005)(66556008)(6512007)(6506007)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TjJja1oxWElwSW1GYnhKMWRYN3RETE5NR3FObFppaTJocWpsaVQ3K2xkK1R5?=
 =?utf-8?B?Zm41aXhEMjUyUHBsUTh5NGNCcXFXeXB2ckJiZHMvZ1BTdUp3TG1wT3JPN0s2?=
 =?utf-8?B?bmR4YmVjWTNzQ0hCdE8ycEFJQTUzbXRFNjVoc0U4SDdwbzh0eVFETndkNjRq?=
 =?utf-8?B?VmpuWU55Tm9NZUhoa2RVZTY0WWNJbjFBNnQreWtuV1d6L3J2SWFvd2Uvdzhq?=
 =?utf-8?B?QThkVWRoTSttYXpJMGdJRVc3YnJ2RDcwRXM1aERTWW5tV2Y4UnZJL1Nuczdo?=
 =?utf-8?B?UnJhb1VwcTM0WkxtdENuQjZKYmlEbVpvSERkWGlMV0lJOS9FaFlJY0E0THFK?=
 =?utf-8?B?enluaEpHdnVCUU1PeUI2dmlYa0lraEU2MzBEM2Q3VlNHc3JMb0FaVkwrQ3Zs?=
 =?utf-8?B?dkZGT0ZBajNWdzFsWmcyRTRwWjdJVThDR1RWQStwM2ZBa0Z6ZmJPYk4vUmNI?=
 =?utf-8?B?Zmt3am5vUThQWng4bEJEMFBrRCtzaG43d05Kc1Z5OGVmMXhhWGF4TjdSTkVm?=
 =?utf-8?B?cEJjMlltaTNpNVVVOUZwc2ZNYlU1MTh4YVdzOFhuNDJKaUs2cGlWTURyUktQ?=
 =?utf-8?B?TXMyeGtIdHFWVmRVcjJzRTdQaXdtYUUxdmNOZXJBdnAzQU0xU0IvRko3WmVu?=
 =?utf-8?B?cDgway9lYmFCSWlFSmxEamRWZXpDQVpVeFR4VEVVRHhPeVNUdVlTaUxENkZs?=
 =?utf-8?B?ZGpKbHprVGpzSjd6NUdzdHFsdTJtYnVSRDU0VEM1WDVkakVSQkNET2hVcW5U?=
 =?utf-8?B?aGFTNWNzS0xKQVpYOFBhamI5dGhqaTR3VVhVSWpJeitGZW1hZDRKM09kQXBk?=
 =?utf-8?B?RzlSRlFZS1RwSmJ6QmpIWXVzUXEvYXVielpZRGxjL1dpSnpLNUM2SEROY2Zx?=
 =?utf-8?B?cHZQZ2o1dkM2YW9jNGFOSlZQTzZqTHVTV3FPTG9SNUZoeUpXc1g0Z3JWTmVk?=
 =?utf-8?B?dEQ1dEZWV3dFU1NRbG1pSkNOZXlTNTlVakMwR1ZZRllBcFZ0bFkrNWxXR3RR?=
 =?utf-8?B?RGhyYkkvUkRUdzhsRDRzQnVTSm01T1RxeHdkbEFUQ2ZEbkVKZWdtYUY5VTYr?=
 =?utf-8?B?NC9DUTZTUUsvcDgwbzdPdVNHVHNTejZrU3NmSkFZL2ptcXVRUkN3OGFBSDRo?=
 =?utf-8?B?M1pQWmFhRHgvaGNxc0t6NzRXcDNNTXRYWk5rMlhlMU5sb3NhVWt4NTV2Ykh4?=
 =?utf-8?B?MGJSWWpUTDZnWEpydGwzanN0bStxMXVDUDVXenZLcHIzZ3dPanZ3dDVhS1lG?=
 =?utf-8?B?SUdFSmp4ZktyVWVPa3RNUHAzUnZqOFNjcFNuSXVqdndLMThtU0Z1QStBMjdq?=
 =?utf-8?B?TjBqZDFxekJybVo5dU5PNFpPRkxibjBRQlRRS2R1M1I4aU1CeGpweGg5RnJ5?=
 =?utf-8?B?QnA4cEd2WDVoOTlLcHVYYjVtdlFySW0yclovSGlOM2FxL3k5TTA1R1diNmhV?=
 =?utf-8?B?NzlyS1BLaXg1alNwMzUwa1laT1JYUkJpUGM3emo0THRqRS9LdkZPbjFBRjhL?=
 =?utf-8?B?cVJZMlJKRGxlVnBKSnFISVpPeEFzVGkwa08vK2JuN1dOMUQwanpXQ0ZSandu?=
 =?utf-8?B?WjFNL3kreEx3NVQ0VUpaelBzTHhmVEFOa1FiYlBXNjl2OXhYb01UaC8wTHZM?=
 =?utf-8?B?YzFvOUhraGN6UFZWUmM5OWhzNE1ic2JQY0dmbGZmTW9GQTcvbnVzOWtXUjdE?=
 =?utf-8?B?aWxxT3N5RFVtR0xxaU9pL3haUEoxSU1iblZVdzUyb05zNzJCTWk3aXQwc2ZJ?=
 =?utf-8?B?clh5aGJ5Q2N2MEQxV0FPMXNidXVnYUN5MlU4M0ZnSDVTZnAyTUtiR1RYVEcy?=
 =?utf-8?B?ai8vSWMxR3Z6a0E1ZEYzdXZZN0RDYis1ZTJzbmp4LzJEVktVTncyVU5FNHRT?=
 =?utf-8?B?Vnl4QXNFQytVWmtRQnlJQTJzZFR4QklVdFJjT2RXbWNGN3NzSXhUVXVsdFNR?=
 =?utf-8?B?ZDhvVHBXYzlKTUxnQkljVWRYMFk0b1NPbkFBdlVhWHNFUGIxQW5GZTBZN0Yw?=
 =?utf-8?B?aGdiYkN3a05TRkViQTZhMG9HK0ZBWjY1aUVuUUt1L3lTVDM5QUc0Nk1jSEF3?=
 =?utf-8?B?QzExOXpvTHN3YzRBMm95RHUrTWoxY1pNQlhlMXVSakN4ZXZCWWYzRG1OS0Ey?=
 =?utf-8?B?VnNYbEZ1YkhoTGI0cXBnaXFNaGJMaVNRQ1NtU2JRVmozdTRGY3FIZFJKYXcw?=
 =?utf-8?Q?PuDtOnTRFLmf4xTwK7yGnV8=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba269495-74b1-495f-faa6-08dad774b6c1
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 10:29:11.0409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oob11XGozjqnyrMRt/w2DIQou96qU+Ddtt1prn4+fEK4njp1ODDwgl01Imwk9pRZzdgmLufYZexRqDhAImQtDxPxDWRUiW5IQzNnDVGRKhJi24lcq2+1CJuKoACqm8Ay
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9084
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 06 Dec 2022 10:29:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14138

Hi Marek,

On 12/5/22 23:00, Marek Vasut wrote:
> The bitbake git fetcher currently fetches 'refs/*:refs/*', i.e. every
> single object in the remote repository. This works poorly with gitlab
> and github, which use the remote git repository to track its metadata
> like merge requests, CI pipelines and such.
> 
> Specifically, gitlab generates refs/merge-requests/*, refs/pipelines/*
> and refs/keep-around/* and they all contain massive amount of data that
> are useless for the bitbake build purposes. The amount of useless data
> can in fact be so massive (e.g. with FDO mesa.git repository) that some
> proxies may outright terminate the 'git fetch' connection, and make it
> appear as if bitbake got stuck on 'git fetch' with no output.
> 
> To avoid fetching all these useless metadata, tweak the git fetcher such
> that it only fetches refs/heads/* and refs/tags/* . Avoid using negative
> refspecs as those are only available in new git versions.
> 
> Per feedback on the ML, Gerrit may push commits outsides of branches or
> tags during CI runs, which currently works with the 'nobranch=1' fetcher
> parameter. To retain this functionality, keep fetching everything in case
> the 'nobranch=1' is present. This still avoids fetching massive amount of
> data in the common case, since 'nobranch=1' is rare. Update 'nobranch'
> documentation.
> 
> Reviewed-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Martin Jansa <Martin.Jansa@gmail.com>
> Cc: Mikko.Rapeli@bmw.de
> Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> Cc: Quentin Schulz <foss+yocto@0leil.net>
> Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
> V1: - Add RB from Peter
>      - Keep fetching everything in case of nobranch=1
>      - Update nobranch documentation
> ---
>   doc/bitbake-user-manual/bitbake-user-manual-fetching.rst | 4 ++--
>   lib/bb/fetch2/git.py                                     | 8 ++++++--
>   2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> index 9c269ca8..e86a4d86 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> @@ -424,8 +424,8 @@ This fetcher supports the following parameters:
>   
>   -  *"nobranch":* Tells the fetcher to not check the SHA validation for
>      the branch when set to "1". The default is "0". Set this option for
> -   the recipe that refers to the commit that is valid for a tag instead
> -   of the branch.
> +   the recipe that refers to the commit that is valid for a any namespace
> +   instead of the branch.

I don't have much knowledge in git terms but "namespace" does not help 
me much understanding when I should set this parameter. Could we 
rephrase this to make it more explicit exactly in which scenario we 
should use this?

also, s/a any/any/

>   
>   -  *"bareclone":* Tells the fetcher to clone a bare clone into the
>      destination directory without checking out a working tree. Only the
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 578edc59..c80e8e5c 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -44,7 +44,7 @@ Supported SRC_URI options are:
>   
>   - nobranch
>      Don't check the SHA validation for branch. set this option for the recipe
> -   referring to commit which is valid in tag instead of branch.
> +   referring to commit which is valid in any namespace instead of branch.

Ditto.

I'd personally make two different commits. I'm afraid this could make 
reverting specific commits difficult because of the docs.

Cheers,
Quentin

