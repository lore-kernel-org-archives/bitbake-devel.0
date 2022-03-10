Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CC8C4332F
	for <webhook@archiver.kernel.org>; Thu, 10 Mar 2022 10:27:16 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.69])
 by mx.groups.io with SMTP id smtpd.web10.7972.1646908034148745023
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 10 Mar 2022 02:27:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherrycloud.onmicrosoft.com
 header.s=selector2-cherrycloud-onmicrosoft-com header.b=G9N5zZM+;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.6.69,
 mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ouz6IMrB5PERu/QU9vTQeJjyBzx7BOcMK9KuUzvHkifvxSJWNQgKdhsF0jRtY30gYTIpV1oyyWohn2IDTSFjkQ0bpNNZduw7lxvbsAMpm0bTwPLHFQHQVEHxcQK4mETQVf615pfngYTQlN2RTxq9RxlD79igXJvc7hBFvATUVqRdFM4iVvWnTE3m48MWne8Tpe/4ReJlaATC/h58u5D4MsZm7oKEF1jZbHGDJLBXK8It7hwmOGjUu2fNY6YB59+UpRJl5ixUOmir5TuZSyh1CylrGWxv7BnJT8qUQo8rTlvYyAO+N/7sTwE1iX+ichaLItswOM4V23GSIIsAc+0OzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hevc5mQ+IXpCENek4Jc7e91nKupjDmNnqWV5Tn3IrWU=;
 b=QZdOOVqxqimZt7N0etdkhm5WJ2yK7UPh+e9vjilTYk9++W50S05mbGI2EFCTNsG/EUu+NdamQkl7lrwLXy9zj1sbfx4deri0FWFHFkVAtuPG/TJJFwBZUHG7TWGZhXfMIbtUqJSSRfLXN61zHVD37LphIs4aW1bel0HjBkv9VDClub8aABxE12gOzThLaW0TtFlcNP10RY+ex+RFMbSOnH7kmwshiM/gfn4+qI99PG7nXSvun285RKlWQsUJIMyIBpLoguGD5AYOlWXzPjBDTEPfksGte6go1jtwlGpRpraFx/TApntxppYD3t3NpwcMFiIHtlvhDH/jxt0X95aWNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hevc5mQ+IXpCENek4Jc7e91nKupjDmNnqWV5Tn3IrWU=;
 b=G9N5zZM+rAMXICERh4t8YfKP0xUfieE0W/tHQ2s01GEQAuSaE1ALgMs6oyc+T3CTq6JZirJfRQDYeG99ajo3pxOPGz5RnXy1EbnLX160w32nRn6Vq222/aOwck+dsGUsYcRu46ri88M9GfHrIrot3kOHy0wd//A2aRp5GEwF48A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7)
 by AM6PR0402MB3622.eurprd04.prod.outlook.com (2603:10a6:209:7::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.26; Thu, 10 Mar
 2022 10:27:11 +0000
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::ecac:a35b:6947:e7f3]) by PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::ecac:a35b:6947:e7f3%9]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 10:27:11 +0000
Message-ID: <87a8b082-21ac-6e15-e5b5-4bd114e25679@theobroma-systems.com>
Date: Thu, 10 Mar 2022 11:27:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [bitbake-devel] [PATCH] bitbake-user-manual: update allowed
 characters in overrides
Content-Language: en-US
To: michael.opdenacker@bootlin.com, bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org
References: <16DA1113B58DA516.28939@lists.openembedded.org>
 <20220307163354.531374-1-michael.opdenacker@bootlin.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20220307163354.531374-1-michael.opdenacker@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR04CA0094.eurprd04.prod.outlook.com
 (2603:10a6:20b:31e::9) To PA4PR04MB9367.eurprd04.prod.outlook.com
 (2603:10a6:102:2aa::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 795e73b6-f173-4aa5-bb14-08da02808948
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3622:EE_
X-Microsoft-Antispam-PRVS: 
	<AM6PR0402MB3622903D57F51BAB2946B8C9C20B9@AM6PR0402MB3622.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	O8aPFJx+RpbOq13eK3ZHZnGGgcaIyVoow4y/FLLtTgTC4Zz54lIszEamNHgV4IgodI3DuC8acCOlAg8OswcWj4ryJlap3v7gAap+LqW9wDegrBFbCI9onaWSXv8GHcwjjqG4wsF2ioaaTCBpM9F3zoUmADmLCsJKoP1m/oWVvrHzfRs1FNY52TEyo2w+UPi23WriOud0xZ7oQzhSy6v+fAr0phij6zVTraIk48dmIGgZb37DDJiBCdc3LYPnEPX13tRjmUMIrnCBg2l7KfRD05WQPQbPhwhaYjZUygUEXy4z9IEgcVVwazMq9DUb1zFoCIjKEP5XrH5clPxGeY/zJGBUr69AZAgzUqkSUuuQge3zsml4Dw3sXnqMejXcG5w3vjKC5M5+djkz/2mIGBU4/jiHxBrJi6l0I7o27ujxWiypFPmjZjdF9EQt1+b13gVt73IseR9MjTO9wl2FBvXWt92jAqueD5xX3L8AEiordB4bgGY8BXsksLeAjHPqWIDcGpIJ4Lh00vNZbz2DjBd+FFv9KcE6lqzR73ZfTcJ2FvNQ/jngD7xGAma826aLPh6kLcQb32DACTIPYxM0Aposu9HvVJ93zQDzjIkhLtEd1KKtKo0MQB0qquow3xK3ahe93btYz5FfJUUNC0fGw3BQbNii7hxJBLkfrqRXw9M5G5SZ7uf+2Z+ydJoBQNlH5thMX54+qeMhoxt6N2bdDLUgEHYfrcFl7AEx+IlI00JRW2A=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9367.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(36756003)(8676002)(31686004)(44832011)(66556008)(5660300002)(66476007)(4326008)(38100700002)(8936002)(2906002)(316002)(53546011)(6486002)(31696002)(86362001)(508600001)(2616005)(83380400001)(26005)(6512007)(186003)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V21lK295RXoyMUdIOW8yQk43aWpTV3BsbFRnWG1NNDdtRkJqSHVjM3lVMlVv?=
 =?utf-8?B?RFREK1l6SGNZS2pOY2MvbHMzQWVzRThvM3lCdk1jNmFXZ3dVM01jbUN1RzVO?=
 =?utf-8?B?OTYyZzVUWDNWOS9SczhRU3pjTXZjZHNJYW54dXl4emM3S0oyWHJVN2xreHFy?=
 =?utf-8?B?bUxaT3N6SjBGSDJvZnhSZjhPWmNkYUcrZFBGSFlqZzNvRDB1TU1odHZsOC9k?=
 =?utf-8?B?aktWTmZSMXM5WVJ2cU5udEVxbFpPalNNWDlKejhvb1l6S0Z0clVWY2ZOQ0pj?=
 =?utf-8?B?UVErajloblhvc0VJZldqT3FKWnROMEdjQWpZWi9scWRkamR4UERoSVFFNjdD?=
 =?utf-8?B?eGR5OFFZUFg0djU2MldDYmd4UHlORDNiS0RjbXNZOTh5NU9VdGEveGNPdm5F?=
 =?utf-8?B?MXMvR002TUpndmYvaXgwSThVOGQ3TG5xK1Z2N1EydnNiUVVpaFRBZ0UweTMr?=
 =?utf-8?B?MmhTZW9adDFmc0FxbmZuUGk0eHJ5N0wwOUVqOTd3MVRIdHhyS1NJK0JTTUg4?=
 =?utf-8?B?aS9TTUF4Y3BMSEtpVG90WlQ3S0RJYS92VzNIaGdWeFdIZnZjZ1RJR0dicnBu?=
 =?utf-8?B?YnFEQWZzVGY0RFVva1VBZkRYSTI1alZXYnhycjkvRFhPUVlER0p1TTh5NWRS?=
 =?utf-8?B?VXd0ZHgzeXAzaVpENEZuOWRXaXJOUkcrd2hJaHVPVm1qMmwzaU55bFIwTjVV?=
 =?utf-8?B?bzV5MWtGK21HK3hkR0htNnR1eG82VlZJazkvRnltczlZS3AwdGVudFFOQTdX?=
 =?utf-8?B?ZkhFbVY5TVVRL2JGcE1jZlAyMThhcktMREk3YVlPdzBCRWh1bEZrRDFIRG1y?=
 =?utf-8?B?SlhFUGVvYlBseVZaTGlHRVFxWUhGallTYy92K1h1QVBaQ1N1Mjl3VmU5Z2p3?=
 =?utf-8?B?NFZtcGFWMW12OVVHRTAxVitXcExaMThySzkyRUlVUlBlQXdQMi90SEFWc3Y3?=
 =?utf-8?B?MFpPcC9tTHJ0Q25uclpjOFYrTWdlV09mUldPNDByMjRwTUNVMm9pNFpvME9z?=
 =?utf-8?B?T1dvdUZkMkFoMjhlbmVLN01ydTRjZ2JRMngrWmlyaWJZZDgxcCtlQjhPTHFm?=
 =?utf-8?B?RFd2cWVuTUdrdzVRYkMwWGVLMWM3YnlYNXkxNk1YS1VmRk9zUjJQNXZZbGR3?=
 =?utf-8?B?UzRYeXo4MjlySllHMUlHbTBPVnVSaFFrSEd0L3F0dzY2anR0aXNSVjZLcTFk?=
 =?utf-8?B?cmV6clEwbFluTmRLa1B3aUNPWUgzRmFNampkV1dxVFdFT0l6TUhzRWR6a3Fk?=
 =?utf-8?B?Tk5EaWlsclB5Q0s4UFprVHlQUUlKOHNLSHI3Z3RGeWp4TEpGeWlTb2ZFb2lW?=
 =?utf-8?B?SXdXV3ZVUXE5Y1djUnlRczlyWHIxRVkxT3dFR2NpM011aTVNZ0pzd2EvamY2?=
 =?utf-8?B?azNKSGRZWlBVNGpzSm5hY01RdGp4SXJZcm54OWN4NU5QTDhrSXMxbkV4U3ll?=
 =?utf-8?B?aVZCajNsb0ZMMFhKd3U3MDl0RTBkMk9KMDhPVnlZZ0VZOUhodndvcGVGVmhq?=
 =?utf-8?B?N01za2l4dmZHVnlqMm1icmZ6YmcwTVArK2xnYjU1RjVwOTRWS3pyL0JJQ3FP?=
 =?utf-8?B?ZS94c1JpSGpsSW5iWm5CUWlXU0J2WCtFamcrLzhjK3FWRk5uWm1aUEZqL2Mr?=
 =?utf-8?B?T1pjNjFrYjdsdzRWODAxZmpOSWdNWFVyakQxeEZ3bHhqRENRRGpmMFRhakZK?=
 =?utf-8?B?Vy9KWTBVU3BhUjB5ME9PbW1jM0REa0tkRlI3ZGx4MTg0WnE4WXVyeHBXKzla?=
 =?utf-8?B?L29WdGRYOEJKelBRQ2VlbHNpQTQrYXNXN0VCdGVHSjVpRXpGSmpsSWc0a1Zo?=
 =?utf-8?B?bEptMW5oNFUwMGp0WFN2ckExd1NuSjI0YjNmUEhNWktoT1BzOTdvNHBtMGt5?=
 =?utf-8?B?RnplTTBOOHp0RVd6eEZmNi9sSXlSUFVsWW1nUmdmeVg1Z1Y1WERWR3NZRkFq?=
 =?utf-8?B?WXlEK2lpbzMwVE5ML29QRDExbzVhc2dhTi90bTNaOGM3dzJJdnVLUGxVNnB4?=
 =?utf-8?B?MVFlQVZ6alN4UjJodUdrbWE0ZWxuSjFEdjdlTUU3Y0xUS0dnaThUWE1maWVQ?=
 =?utf-8?B?MDRDYVpZSXVpS0RjVjRNWFpReHRLWVFMbUlDdEErVk1CRTVhWmc1em5KRnZy?=
 =?utf-8?B?eXJTVHpaWXFLNWtURFF3Ump0MDJoVnI0OWtVSTVpRTBLYWFJTkhMSWhkSW1B?=
 =?utf-8?B?SFUrRzZFWTJoN3gwc1Y2NjJZdUJkYjAvMFRFT0RHaE56UE5URmszdDdhK05o?=
 =?utf-8?B?SVJBbkRMRlZta1liY1FIdU1HaVgxclpJOVRFS1RwYkR3Y1BCQzRWSURWeERO?=
 =?utf-8?B?eElYN3NCOHBkaE96cUhEdzUwMEg4VXZISE52azVBNHU3NGZuTjluUT09?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 795e73b6-f173-4aa5-bb14-08da02808948
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9367.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 10:27:11.0066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 WNrCRB0EXWGYiB8V0rumw0UTYYmk3ypirBqutxCXxQrFL3btpcm5I06QgI0dlamVcKftnH+pl0l/Bv2+amSTjTscUZGbW9ssip6f7UIgftqxXxkEKqKZkSrgBWqYN9Ef
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3622
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 10 Mar 2022 10:27:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13457

Hi Michael,

On 3/7/22 17:33, Michael Opdenacker via lists.openembedded.org wrote:
> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
> ---
> 
>   An open question is whether digits and/or hashes are

I assume the question is about dashes (same question for underscores BTW).

>   allowed at the begining of an override keyword.
>   Will be happy to send a V2 to explicit this if needed.
> 
>   doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> index b90e5cf0..104dcb6c 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> @@ -510,8 +510,8 @@ variable.
>   
>   .. note::
>   
> -   Overrides can only use lower-case characters. Additionally,
> -   colons are not permitted in override names as they are used to
> +   Overrides can only use lower-case characters, digits and dashes.

and underscores too!

Cheers,
Quentin

