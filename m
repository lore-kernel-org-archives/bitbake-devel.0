Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF5AC433FE
	for <webhook@archiver.kernel.org>; Wed, 12 Oct 2022 12:53:09 +0000 (UTC)
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (EUR02-AM5-obe.outbound.protection.outlook.com [40.107.0.55])
 by mx.groups.io with SMTP id smtpd.web10.19729.1665579185804865857
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Oct 2022 05:53:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@theobroma-systems.com header.s=selector1 header.b=e04ZM6cw;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.0.55, mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mm6KFHDUZQp2mZ3+py+zfaAJwxtHqjBJkWe7nrgHb6NrYMg3GSNN+DGEZ8Ov9/U1xdnqi6kNAUz4nKKUJsze5RfXSmqLQWZimCSVPcTE6cfGhBftyzjUfFlfPHhN2lo1owXYdjepJ0GXEsSXMKJwQM10ICzslwYQcGmbxlZ6r13J70i7xqM1EJuABbhofIUH6BVbsNP0scKQd8tUypqNfoO38kG73LmayeZTcEqK5OacNkdMaH4rcGfAbBhUPKCDRIpIwZfgglsTPt9cK8TywXmodkbd7sa8FNjPGHtX5ORLMQ8Mg0QyIT0ckysxS7e9BUxsU628YJWTO1XQ5hDkHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQcMPOcfajX4Arzl7lJWXiWnG82Psp8aC2rdJv6Hd6I=;
 b=CNV/hp2VxZdmJfJsHvtY3PiiHqw6cMNCXtPJM0kKZpYPY56vFqsHdojVsPq4DkaEjXHN50mu4DZgp4F+DgSeMdVv28QyEWxRCkHGXumOF+rZs9HC9910qATRk5NxEuCesLQCYvzqoeVqduEQd1O++f8VcUKTnb17mh3OsYLHyGd2DPwTM5C4npz7GRaM/9CI2ZCCKFHRrGAnWEEv4tavXBqu4mSJon8XsqBGfBgMEdxiZWvCYm9sFSpqTH88sZoHL57B7V6dsry1AH11TfPFtwgBf96qy73+RUiY4+ifmXieW/5mD5xJ+WHozz8PDXB3YsMSjc6VZTUzbY/V2jhzMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQcMPOcfajX4Arzl7lJWXiWnG82Psp8aC2rdJv6Hd6I=;
 b=e04ZM6cwCDyP6xRYpQIwH5mzHwhqJoW3X9zJjv0TWLY0CEjhIOIHPU4vgBin4Apjv480MmlfWDjsLWesJ1yg/OMpS2JY7A91vot49eVB2B34L/sugV3/F5m2wmHKCnoRhVR235YbpwhqOJWkn4A2wEp0o9h4zYKO9HEFVM+wbhPdGc9KTebn+YmoR017/96kz1T+mdfRHY/hvfhtUb5fvWp2J/5L5E28uhYlDQWKquoQ4Tc60vw3jGVfsmzxoc33yBcNWcghJOiEYS5ecmqLp8AH7EYVMA6HhlR+kqH4vZchPoqAnwQbaoaAYg+EC1z/T1S701Hz6mO9519HUEJlzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by DB9PR04MB8331.eurprd04.prod.outlook.com (2603:10a6:10:244::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 12:53:00 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::5e5e:1989:e5ec:c833]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::5e5e:1989:e5ec:c833%3]) with mapi id 15.20.5709.015; Wed, 12 Oct 2022
 12:53:00 +0000
Message-ID: <91b7e8e3-a6b9-d426-527a-368e5676d4ea@theobroma-systems.com>
Date: Wed, 12 Oct 2022 14:52:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [docs] [PATCH] doc: bitbake-user-manual: expand description of
 BB_PRESSURE_MAX variables
Content-Language: en-US
To: michael.opdenacker@bootlin.com, bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, Paul Eggleton <paul.eggleton@microsoft.com>
References: <20221012124304.2926858-1-michael.opdenacker@bootlin.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20221012124304.2926858-1-michael.opdenacker@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0617.eurprd06.prod.outlook.com
 (2603:10a6:20b:46e::28) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|DB9PR04MB8331:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fc53fc5-0f07-40f4-c27a-08daac50b187
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	hK3R6WX+aW19Bh2V+T1XqU5XtO88eaQmfgBvNeaTCeQO9buvkIjNrWmPua+uRiKhZsynA5JVObtIaGbd6+UvmgX+jvJAePRUD8FNx+DLKHSYDVusmDcNpeyu71JIKUwId09FJtBBkfDF/gB8Qdi706GsHcRCGnyYWPMzfCzcP1xdMxBxhfyZuIZhaBvHfzXq005C0e9k7cxSlFAztPnnLyuAP88nzlxhfx38Yz2f5GEm16RmEIDvW1eLgEJwmOpB1Re7MdhxFgbNKoOujTXQKtcM0HGq/bussvvHZqdnbPPbJ+rHE6zmKHdv0eUw3ukAbjzGDCQw3Jk+c73FTCoRgXrBzgEh1y7YEtDw6id+zAdFHSQSdYoZcx3uzOmORDjijYpj+5eQ6fSB/zZgE/ERqgn2cVdFGSRA1a3TZpmC9Ot1apD8TYMFReuLT0mcNwWEfSZclCA0GTGwvMkyhskOLe3QbdHt34zIE1YRzZHYVC6YBkQuIlFkIP56lHWo4I5CtT10V19upo+JoA8z11HhA8TIwscgEXWX1NJ/A4+fyToKgZ18YR96bv6iIoqpEhjhHhU+kBu6U+uKnOlZDNAYp1VxTCWUPD2stQCFa+W/fI9TfFYrpxtT6PVYG2fXWEuBZb5N8BbY2U+E1vM+aZ2JMdXp5wwnQ8y4H42lmcRwG0I21KEKyfQps5PaSNXg6TaC+kYw2C0NQ6A15qGfJ87rXaF45E26dzHMrWggVuYoVJWLdHHuOPHTn37QzNn5jgMVggMwCYySvMfi5K/TYRgEXcLdR02M8B194DAuf5H+mUw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(346002)(136003)(39850400004)(366004)(451199015)(36756003)(31686004)(86362001)(31696002)(38100700002)(83380400001)(316002)(26005)(6486002)(186003)(6506007)(6512007)(53546011)(478600001)(45080400002)(44832011)(8936002)(2616005)(5660300002)(66476007)(41300700001)(2906002)(4326008)(66556008)(66946007)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OHp0bmhQU2JRN1FJbmdqUlBGWDlBMGxieHpsM2ZqS2RnU0wrMTV4U1c2RitL?=
 =?utf-8?B?U0dkMTR3VlpPTDJyU2JKMnBYb2dRVm1XYVFpdVNnMWkwajZsa2Z6UEFMa0J2?=
 =?utf-8?B?QUVrWThmK2F0NlBnZmt1aWpvSCtLS3krNm1CSlNWZ0hZemxoUkZJMWRhWHk0?=
 =?utf-8?B?UG9ualZjRUFPQmxpTjVEcmJ0dExBUTRheUlrUHNNOWdyeVFxQUJwSGliaUM5?=
 =?utf-8?B?N3AvSEJ5MFZvaVBwSG9YOFNNbThiYVkvU0dSbEN4OVExNnBiNTdMeloxc0pl?=
 =?utf-8?B?VHdpVDN5bHdZZ3BPT1dCZzhPUjdDR0JrbXRpNXpPckJwL3BrNks5UFRHVm9G?=
 =?utf-8?B?T29RZVQrZ2c3WnhBbi9WUDJMWWVXc0hQZGwveUZDdVdMNnNOcThRUmcvVm9s?=
 =?utf-8?B?ZzVON2czcDZScTF3Z0NVT21TVVZHbVRicnRpZEVNaWhxbCtiSEczeEFkOVIz?=
 =?utf-8?B?VC9tTENWNm5pMUh6dndGVzJCQ3U2KzM3ZFQwNmtoM3hiMXY0Q0YxSGJKeGxo?=
 =?utf-8?B?WWs0TlFvbStaN3lHekVuYmVwSlhNa2FxRFQxOXBFS2ltUENZTjIvKzIvckhk?=
 =?utf-8?B?NG9UbnphNFNVYVNqKy8rUFEweGozYVo5WkZCWWIrcW03QWd4M2N6Q3IwMTJ0?=
 =?utf-8?B?NG5pVDNYMVpXMXp6eVFhVmpueGQ1SkxSVHJxS3JVTTNyNGhQRmhDeURZYVo1?=
 =?utf-8?B?RFVjTlRnRjg1MUU1N1Vua0xiMWlRKzFhbXhpQ0N1TDhWR2NVcmc2dUJobm5P?=
 =?utf-8?B?aXd5RkFRZldBSytITDNPU2FyckxpVWRUY2Fwbng5MXFiMEVZaTN3dE1jcnky?=
 =?utf-8?B?K2hVOVJZTiswRk5DVTdrRDltbDk5R0NFZTF1SHU5T045UVUvS0RPaG1KSXFo?=
 =?utf-8?B?MERybUlUK0JvNTBJV0pKTlhUeUJCUldqeFFnVkc4cEFmbk41UDN4RFQ0cDBT?=
 =?utf-8?B?NElVcTNDUFlTR3grWGZWZHlpL1A0Sm5BTlc4bCtQb1B5eWRhSWNLMWVNMU9s?=
 =?utf-8?B?dFpLMlJad0xDWlVrQTVVQnBPRTY2SXNZTlZWdjJuQmFtNFZ6b1lvRHhEczVF?=
 =?utf-8?B?VHVXc3dDLzJBemRjdHE5eEp2U0YyMmVsLzBheUVUUUlMQ0xmaUQ4UGgrUzV3?=
 =?utf-8?B?Qys0b2M3dHlZbE5Wb1pEUjNROWRuTk1Na3kzQ2hjQXl0MzMwck0vNjh5d09z?=
 =?utf-8?B?VjZFMXNVeDlERmJIQkVUQXdWZmNJRlh2MHR2emM0WU03OWF3M3F6aXlSTmh4?=
 =?utf-8?B?TnYxbm92OGIyM1ZwQ1o0bHNhaGo0bThXZ2lHOE1EUkIxZGMvVGdaR0NUOTdl?=
 =?utf-8?B?QU5pL0VKRUxDSHRSZ1dPNER6THhuM3BGcXNWVkRrWUxpYW1oSVQ0RWFTMWRq?=
 =?utf-8?B?Qklvb2ZwT1JUZXlQY0p4VTFmY0Z0ZTFBMUJkK0xsUDUzQnJWeGdhY0lmMjdI?=
 =?utf-8?B?a2ROSnhEYWFhTEQySGliM0RVRGRkSWtvMUNDSlpjK1dqSUJDaFlrenRMK0tp?=
 =?utf-8?B?WEhwSE5pOTV3Wk1JLzV1VllvOTFLWXdiWndqZjFXa3N2VU1UWitpMUpkbW11?=
 =?utf-8?B?bkF1d0grMG5vUm5ubGcwbTRPaEJjMlJyaklKYjIwNjlNM2VQTzFVNW1KUzZu?=
 =?utf-8?B?cGpSalhqalFQZGZjLzk0cVd2MHppSGppMEMzYWNjK2dhMmQ3RHBhTFR5UFVR?=
 =?utf-8?B?NmFySEhRdzdldFhRUW9ZNlp6bDFHUDVWUGt3d3d3TWxjKzF0WFl6MzhHZ1pi?=
 =?utf-8?B?V3ZXVWxVVFdRUm1RRm5KaDRlRXNRcGFDTjFJUHZQd0VzTDBVVVBMRFl0eUNv?=
 =?utf-8?B?T2twYUhrKy84TGsvRXdoZG9uNHBtN0NCOVZ6eEJpOU53NU9CMjh4aVZlMVlq?=
 =?utf-8?B?VFNBZE4yQ0Q4N2VLYnAzWENoVWFxZmVmMGNaNkY2ZWRRTGlhQUdacy9HM3dJ?=
 =?utf-8?B?eEh3cFVxOEFhdG1ObGMyeHhzby9hVnNJQ2lTZFhKeUoyMEFvbTJ0U0RKMm9P?=
 =?utf-8?B?N1lnYWVIRHFqNjNwQ0ZSN0VFRjBnN1dyckJ4dmNIeTliYzdRRE84RGluZnNC?=
 =?utf-8?B?U2F5OHY0Z1Z2VGZsVnFCM2hCaFd2MmhMKytoUzVTQThEbXQySUJiTHpTc1lt?=
 =?utf-8?B?aVd4MjB6Y0xJd0VmVXhKZEUvQ25XcUFrRFR5QjMvMVFYc0wxNzUvUHNLQTE4?=
 =?utf-8?Q?A5/TYwLhX5KSonOldC5iS+Y=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc53fc5-0f07-40f4-c27a-08daac50b187
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 12:53:00.3734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yalmMvrCFbc9GMsav/FYurWOrDjO3S6XF6bJq582DjVHWGjd+5pTGK8CAhqDDryq4cibyYyBUOTk7ABF3yEHIN/HbB2qsCcgRwMhFMrOS/Had+aOHwzavELOBrU25P0Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8331
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Oct 2022 12:53:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14034

Hi Michael, Paul,

On 10/12/22 14:43, Michael Opdenacker via lists.yoctoproject.org wrote:
> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
> 
> Signed-off-by: Paul Eggleton <paul.eggleton@microsoft.com>
> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
> ---
>   .../bitbake-user-manual-ref-variables.rst     | 60 +++++++++++++------
>   1 file changed, 43 insertions(+), 17 deletions(-)
> 
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index 725e6c2c..b9c1b75d 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -484,29 +484,55 @@ overview of their function and contents.
>            for it to work.
>   
>      :term:`BB_PRESSURE_MAX_CPU`
> -      The threshold for maximum CPU pressure before BitBake prevents the
> -      scheduling of new tasks. Once the :term:`BB_PRESSURE_MAX_CPU` threshold
> -      is exceeded, new tasks are not started until the pressure subsides to
> -      below the threshold. If :term:`BB_PRESSURE_MAX_CPU` is not set, CPU
> -      pressure is not monitored. A threshold can be set in ``conf/local.conf``
> -      as::
> +      Specifies a maximum CPU pressure threshold, above which BitBake's
> +      scheduler will not start new tasks (providing there is at least
> +      one active task). If no value is set, CPU pressure is not
> +      monitored when starting tasks.
> +
> +      The pressure data is calculated based upon what (recent) Linux

"recent" does not mean much. Can we remove this or get a minimal version 
number?

Cheers,
Quentin

