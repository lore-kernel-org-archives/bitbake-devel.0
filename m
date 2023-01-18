Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D28C32793
	for <webhook@archiver.kernel.org>; Wed, 18 Jan 2023 09:59:12 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.59])
 by mx.groups.io with SMTP id smtpd.web11.11865.1674035943861175633
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Jan 2023 01:59:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@theobroma-systems.com header.s=selector1 header.b=HmrTNFIr;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.22.59, mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQKCbs+wOY5ZJfgca1JEXSAwDV9+iiUbK1ew4yRd3W6O3XF+ZurO8iIhr6D5M0I1gd0kpBJCo1YyGPg60ytqWklWA/XANhhmyUJ8OU3XU0IcvQGpHuGMl4eql9xsgjA5YmWWfku0CN/3cQtSIS7vLVy5MlD40TWJ6o7Rv4fhT/Jxkd9TqNgZYMCwMm4+pKxKEFy8XWJjSGPE4jtHT0wbEZOx2rV+azz8d1YKyKnNYMhUHn0qM94YUraJV2zqTHMLO0Fg11iOhVV+MGvlPVncJfx2wbl7jm4YvJpcjEVUGymaS0U0N9XFANyiN5q2JEUGqFadrlTHV8ombBLaAlhQ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPiWjOqAvd1cTQ130zA1YzC5zA2KbnDWEqpx9KugfYQ=;
 b=aDlrRNclt4CPoB7ERQq5Km1r5BT7WE6IUA8Fy+qZP+BClkzhHukLs64gsL1gWu4Na85E8IaYmjAFki9ZEU69YDHeHr+GSgCze7lGuV3LFcWaoeSEULFcXNusGSu3L0cxSL94UzOedBwMcoDWL5BhgAAwUTMQY3YpH9Hw6MJZZLy2wQbHR/bxV2gqXJPMYymnbz/sYTsQ3ilzCED6q6g1P2o5QC1+CEvWLmdD2r8eSQUATn7D1xknZ2AdzX7ebjz/oF5Af4N5NjBbvXXw1UpCfT6K3mg4j/yPtLye3O0aKs+fUf/2uDOo/+72HcnctDsGNNRymX2q0/a9ZVLex9acMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPiWjOqAvd1cTQ130zA1YzC5zA2KbnDWEqpx9KugfYQ=;
 b=HmrTNFIr5XwJMDQ+G6S/Bodfz+sp+0lBZ1Z8vGEYiAzkLvc5SK2K/8Ibe5nenYEJzMoeY0yGc2PQXLkL7pngM+Np+NYk7j1JUTv+7Ls68NPCdzPOqgZRArZ7f/xCcTVXe/s/v3zvkkKSF5ymVyltAl2qW4kjM4c3SthzIIqaMvs2UlYLMWsh10bIBVXSw9aOEglKWNteJxt81otBx0uazwMHh6keQhxV4i8uM6c2go7Ly4Rso8vYeQnsl8wRwVJ1BwU30PkYWkwe0oAZyvwF7eSGMruNCMjuUArzNmHXn1bclT/gR3eyhuthJ0J1cbNOj23yk4oks+qLsG0fRLVKgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by VI1PR04MB7039.eurprd04.prod.outlook.com (2603:10a6:800:12b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 09:59:00 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::24d3:14a5:eeda:6cdd]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::24d3:14a5:eeda:6cdd%4]) with mapi id 15.20.5986.023; Wed, 18 Jan 2023
 09:59:00 +0000
Message-ID: <9d9e3eaa-92fe-2365-ab8c-352dee0af03c@theobroma-systems.com>
Date: Wed, 18 Jan 2023 10:58:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [bitbake-devel] [PATCH] fetch2/tests: Add parameter to recipe_uri
Content-Language: en-US
To: Pavel Zhukov <pavel@zhukoff.net>, bitbake-devel@lists.openembedded.org
References: <20230118072808.5895-1-pavel@zhukoff.net>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20230118072808.5895-1-pavel@zhukoff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::15) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|VI1PR04MB7039:EE_
X-MS-Office365-Filtering-Correlation-Id: 0808e780-da70-42ec-c9b9-08daf93a9f4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	v/jwzBvwbwzTKAA5xwku3urUsyBKJe3UCn0Wowy0Kmaiy3JKXmcn6rq8Cff4KeOQBKE+TuKPs3oRxFKMMfozlwpHw1pAxQC1sh9pmCE3HHzuwTHsEfOvhYwx43FIZRyV13/P0AIS819dUsJchEAgP/8fui7YeOfzeKTtMuBwmonxGAgnw42BW97lz0a87Ymz/14JiGzTMH/++ugzHNkPdRta+xtSR64mhS2azl9T9KL+b4HvS35wemQANt65rKbwNQ8o2CB6k6NJ/+PqsF2ykAl1rdFMY5omjv7CQAl32VB1rIWacSl3npJ4QI4YpqbQe6iyxU3XizUoRJPJZSf5VUpCbWL+17fEsj+WNKKtYNsaAgr19sBAsb/LKFuLJMEtXdUeInjHrMMxTnq8d7SDtnTb8y00GYyaXTbLH5XvyU1NM4TziD14VKYrihNDal3hgBzkmjnQ1EfI3qMObN7bibrVBTKlLw0UjEvGl64YyYB22A4blCLVBEUL6vxdNJgC9yjO/Qx53NsgbNWerfRv2kZwjPKQUiKbe+ZpwPJKIvbtMQsJgJn5JhgGfV1paIV6NOGkRzNesY4CvPa8Pj4glCVadE3Aq+8kmGceCe1pBjtoZ1rIww8H2+h/0PlVXKc0/wRLKBj01KwXZL5UKVmy2Wopw1YStcfcUNofm3o5YdLBVycffMRWGGA83tvjdfPsN6t2QBVKkpz1OWFbqQ06HAZ8lpjji9Cxa2s+3L4P/ZwKLdNqgsOgcWY1pFwe2fLB
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(376002)(39840400004)(136003)(396003)(451199015)(83380400001)(38100700002)(5660300002)(2906002)(86362001)(4744005)(66946007)(66476007)(66556008)(44832011)(8676002)(8936002)(31696002)(478600001)(2616005)(53546011)(186003)(26005)(6506007)(6512007)(316002)(6486002)(966005)(41300700001)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VDlXWjRWUVVNazRmKzZDUW5DRzkvSjZZbmxJWk5Wa3J0Yjgxd3hFdzJCb3lQ?=
 =?utf-8?B?V2VtSFE4RWxTT3VJcUwzT2lrTEUvMURWRkIxcmNVVTVGdmcvMFIyYVdVaUhh?=
 =?utf-8?B?ZWxrZ2hvTUxYR1h4ek5RcE4yTGNjUGpxMkR1Ry95SUxibVdyazM5VHppMVd2?=
 =?utf-8?B?c0pjNjBmTENURncxb3BmMHQ0THFZdDJWMFpKdXJXS3lMU1M1TW5Wdy9Xazdi?=
 =?utf-8?B?RlA3UGU4eHh1ZE5aME9iaE1uSUZGNmYyOWhEbkZZOWlzMDhLQWp6dFk2YVpR?=
 =?utf-8?B?dTdZWFB3WnVnVmdYWGM3Tnc3YlNqVys2WUNQMUtXTGxtTEJNaWYrRWplNTBr?=
 =?utf-8?B?MXllOVFYcjZnOXpqbTZKK044MEU2RTB1d1pyWCtnS0JYUURQV1diNHcvSnlL?=
 =?utf-8?B?cCt2cHkwYk5kZUR3Njd6bXJZbjM3N21RTzN2MWY2aHF0WDl6ZFBXQWIzZDBk?=
 =?utf-8?B?eVYzbS9FYTVXVTBlSi90MUViV2R3d2R4V0ticC9MZ2xlUmhkTXJHUjFVb0NH?=
 =?utf-8?B?THRCSjR5WFFqbVdNeVdoL3hwSmcydkRmRTRDOStGMlJWUG9tUUFNVEJSN0ZF?=
 =?utf-8?B?d3JnQ095UTY0emFiWUh0eGh4dm5oUG1IYmZoLzVMa2tpeERKMHhxdy9zd0ph?=
 =?utf-8?B?MGFWZGhCZ2ZkTWREZEsvUm5LYUQ5cko3S1lwU3l1QWJOam9Fcmh0Z1BpelhU?=
 =?utf-8?B?N3VEOXdnMGI5dnUxakFpcitoZGJQNlhKSmRWNVR0NmtzdXUvL05laVJRZVAx?=
 =?utf-8?B?clJJdElIQTdud1FacTdxQ2NCVDNjYXkyOGJMcHJnWFM1L1MyclR6QUpqRVdJ?=
 =?utf-8?B?Umx4WE40RkNEZUVMekNsQ1ZZUWYrVU4vd1NVK3pUTHBrVFUyOUpFdWFiRkxS?=
 =?utf-8?B?TFk1RVhKc2laamtZZ1VXZW9oZHpodmU2ZGx3RnZsQlF2OFJRMG92Q0huNEds?=
 =?utf-8?B?M1B2eitMKzRsM2gvV3JabEt4dS81SEVnZnJPUkVVV1REOTRuZGJsTFU3TTBk?=
 =?utf-8?B?bk4xOUR6T1FwZlg1ZXNETVJLUDlBNHZWdllBY3AzSHo3K21HbnBtWGg2cmw0?=
 =?utf-8?B?UDFZb0ZUa3lqOHVKWWcxOW1LOWFpbXVOaXN3Vi9qbUZKS2RTUzJoNlhDckY4?=
 =?utf-8?B?clc4eEVrUlFYblBaRjJpcStjZTFuUjYrRFRFNEJRVWZBb0VISHZva0ZSaVJX?=
 =?utf-8?B?d2NaR1ZiSmM5RzdkbWJ2a29CT29kanpta25EQ3VmdjRIVWcxK0lrbUhSeDNV?=
 =?utf-8?B?Z2tjYTM0eGdGaHBNdm1pOVZ0TU1jU3ZKYVh0ZE84NUtpS0tYWGt0WUlPOGYv?=
 =?utf-8?B?dW01TXgzN2IxZDBFbHpEZm10SktKWWMwd0RGYUY5dFUyOFo2YSswQlVEendP?=
 =?utf-8?B?eFBLZW9uWDJOdG5YRGxFazZ1dldWb0lGQ21md2t0a1A3RzdPWHc4NGduNXZ6?=
 =?utf-8?B?NTNKVVlMNktacStxclRoUXhzdEZpUjF6cmFPcXNQaG9KcDZGSVlwVEJQSUE4?=
 =?utf-8?B?NXJZdUluZXh1ak9GUkNRKzNIc0V5bXF1TStXejJmTmRZUitENndPTkpjZEdy?=
 =?utf-8?B?ZGpKNGlhS2tJSU9CSFdKeW5iOHR1TmxiZG9ua0l6SkxERllrTm9FWStIR2xR?=
 =?utf-8?B?UEI5WHVzUUhkelp5b1phUjY0dmcxN3VDRE1BK3F1NndZRng4RnJHTHlvbEti?=
 =?utf-8?B?bkhFc2liblJlV1pBcmhlT3dOUnFuY2YwMHpLaUozVEJrQklNYzFaYmN3alk4?=
 =?utf-8?B?TXNwbEdoOU85UUp1anV1YWRBZjB5ZHRHQkpUalJheFArNitIcXhOU3dzTnR2?=
 =?utf-8?B?cytNd295MG1Ka1plMVhUSm9qYkcwYTJwNngyVnU5UXdOLzl1dDRBOGkzRzBn?=
 =?utf-8?B?WFd5NlpuNFQrbkg5Tm0veGlLaE90MDIzM3NhTG4yUk1aTmh0bmI3UTVBKzlr?=
 =?utf-8?B?Zmk4eUlYVUZFVExJWllWaG4wWXlzY1BuTnA1NEFxQWx1bS9KdXM3OXNhZit2?=
 =?utf-8?B?U25wU2ZoUmZKRkJRbHRjaE1ockRIc2dZdmVGbmpFNzBrVUFQczlLaXJWbTA2?=
 =?utf-8?B?TTVaL3FuQllWTU13aWhxT0VDOXpORTMzalk0OVp0NHlSbjExdEhMVWd4SmFB?=
 =?utf-8?B?eVBUOXBVTE96dkxUbFlaVWw1TlRoUUwrYTdFMHhsc2RCOEhPMUZKR3pMMUlv?=
 =?utf-8?Q?BNjRt0o1zJC5zafnfpHUJsQ=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0808e780-da70-42ec-c9b9-08daf93a9f4b
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 09:59:00.4028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VbkQJb+T9qsojt9dXM5+0/s6mcjFNbZ+FAkkiyPHbbVV0Sx2TwDTKTxzbt0IKQayKgUu6YRGelnb0rdfRA1+hI7jLK/GUI5imeV4oNCHngBFxfBcZSjj2UJ7qhORUwvs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7039
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 18 Jan 2023 09:59:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14323

Hi Pavel,

On 1/18/23 08:28, Pavel Zhukov wrote:
> While the parameter is not required it allows testing of possible

I was convinced it was required for a year already but no :)

I see Richard added a warning in Bitbake when the branch parameter is 
missing and nobranch is not set to 1, c.f. 
https://git.openembedded.org/bitbake/commit/?id=86a9c26828479be55865bcce72bcc7e12b93caa7

Maybe it's time we make this a fail?

Cheers,
Quentin

