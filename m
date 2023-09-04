Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287D2C83F33
	for <webhook@archiver.kernel.org>; Mon,  4 Sep 2023 07:54:02 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.68])
 by mx.groups.io with SMTP id smtpd.web11.43719.1693814034066387022
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 04 Sep 2023 00:53:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@theobroma-systems.com header.s=selector1 header.b=AF7ESWRM;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.105.68, mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFS+hV8B6n+VcgbYoms7DwR+jAk30mXn2H1JhHHP7G78gs9KqoTcgjQ8w6vb311FP8Acd+vgdNiecrZVHp+yarpptpM7UU2Zuab/eHqa0F3aKo5JHnqF+yYsmizgptLBIzBp5EjPA0HodzXvztYWd2q1/MKb+/ugnMlJwlvB7oMjyMO7a22KySbY2QPB6mCVC3r1XO4wo2973KKCBZ41rfUwX1GzB0LJvKCz34Dk2i7vf12adOjAZNtk3fgbzh1dkACHJj/QcjTG2eJ4WlWO8MJZ1oBmwSFY3oo3jrSeAtW4JUPmalAK5FoCqv6YqntmZhZUXhOzVw24fRKmP5VFig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/ISnBipMC6xZpZ6gx688qWbszGnj4hsJNxQz1Q/Qo0=;
 b=gaeJvNt/qzZYZ0Pf80hOu2DeB1fe+LwJICK15fB0EqRlLb2wENmoiqm5MUqxErZwWGjzJE86aWl8ZFoocIC+/54hNoZn1DpQpaywhO1FT9akVxBnD40C/kmnOuckJuKN33maREDOV+a4S08//AUz2exDOu62lhVxpZ/6REEZ674APlRF/CugUjgxt4QUaJBq0vQ2rRSMuDN34jMXaobmUdV5J8vzTqjqty6LJQnKfQ8ZQDb2GBWIVjQ/mzrLmrCHhQeNKuaV6MRHCMoA2EffNbMfvu+Ar2eSLPNd5rL4qf4vNX036TIkXrHJaswIlknIXAiivlju4bZTmG5OlVkAPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/ISnBipMC6xZpZ6gx688qWbszGnj4hsJNxQz1Q/Qo0=;
 b=AF7ESWRM775s4ZXK3u6+p4wTKbaU27WTeZ8WvcWTSHZDHFo69swk/s6Zw8ngH5/7TvR+FeoU3XIq+FiEYPoFTWhFVDB+j+6HduTG53dHf30unvIH+P3NrnNdY4gkmzai8yfaFhcpuaZev0omH904MCOd/r4I5zyHnXtn5afLipdVT/+2vhFBQogXjXhgsPDmuQ5esdIsb1eRCHzLPzX/NoSNYGO/7BZg3eACHM9BamIvCEYOTym+0sYTpii02Ejq3Hpn/ITxsPx12lA5yEDaCba/fhtiY7E/lehFcafHQIN+6EnC5nus1Kd2o+RiJ+8bqZWfezZtAlrM9R8E6KQ3lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by PAXPR04MB9421.eurprd04.prod.outlook.com (2603:10a6:102:2b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Mon, 4 Sep
 2023 07:53:50 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::5c00:6152:6ce:72b6]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::5c00:6152:6ce:72b6%6]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 07:53:50 +0000
Message-ID: <d7610f60-84c2-c507-87c2-3757b78fc7e4@theobroma-systems.com>
Date: Mon, 4 Sep 2023 09:53:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [bitbake-devel] [PATCH] doc: Document challenges of tags with git
 fetcher
Content-Language: en-US
To: richard.purdie@linuxfoundation.org, bitbake-devel@lists.openembedded.org
References: <20230902105508.2444252-1-richard.purdie@linuxfoundation.org>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20230902105508.2444252-1-richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0031.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::9) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|PAXPR04MB9421:EE_
X-MS-Office365-Filtering-Correlation-Id: ffb6d995-83c8-453e-f857-08dbad1c1357
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	QebfUfdyuTuEgsbNUN/10gSIHc/0gjuhVkN7PfTMYiBO2l/WocUiBHH0jX3DCKuHVhUD4bKv4p+IQl8p2UqSOzNkscuTb5Rw2rTm/urDvvRqr+U4i/JZny5nMAZxIrxDckmGY0li28mhtlY+MmCLFZFP4l19k39sCHsCom3VxFO7d07XT4Q++d3mAiJC2WiP5UjYw+oaA9q87rXgqb+XrQYkLiYk9nirDfG4GLtIEDBB6AcYAcZ7dcVgclG4kX7njBpECHo+iRbChhxN+t2FhkXxNdDN+js98eO8jdX0ziKRTIzdzk8QGMApq7qifkUaD79oR/jKnovUVKdWVGr8hvUyq8hTuOJL3Xf3wqYmOH2LTHc6kFY4w0JQEnbyd9SsCOIne1DmRqBGvcvEl0Oh9CiSaOTNL9hYaACmphK/77Flp68MiiWA+Yswq0iqHxoykgUXNZ5pd92SOLIS20oi10EAAZuG+1xUDwkiC4ME/NqgV9vD0xhsOFy85Al+GYSzbvquHiWBP4vAOjZPSwaPksiq2AzgG/40vkECSEHFY0m0knJ7qP2jDspmigMxpDX3ibrj5D8v3yT71sSrCQoHtgylcQMcG/4craBxhYud44a6OHSp7TYlFEr4Ke/wFm4Zlg6ReTck8GTZR3WS5uPInA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39850400004)(136003)(396003)(366004)(346002)(451199024)(186009)(1800799009)(31686004)(66476007)(66556008)(2906002)(36756003)(66946007)(86362001)(31696002)(316002)(5660300002)(44832011)(8936002)(8676002)(41300700001)(6512007)(2616005)(83380400001)(26005)(38100700002)(478600001)(6506007)(6486002)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MUo0STdoK0poUXhna2hzejl1UzMwMzlCZlE3dE0wYk9jUzF3Uk9zdVBLMW5l?=
 =?utf-8?B?M0xQOHRqRkdZWHkvVXVEak9FRkx6eUw4L2pFUHlXOHdZMzNVcXhhOVp1amVS?=
 =?utf-8?B?V3MvaDFZcGJkMTFOVk9weWZzNEFVQUZsTS9INjB2YWJldHF5N2hNbUxmNHU1?=
 =?utf-8?B?dWpXYXBuVDRldkFKNVBURllSeHNpNVBWNW9ZUkdTSDAvYUpZQzBlUHg1dHMy?=
 =?utf-8?B?bUNTbGtqYTQvWFQ1RGZLZFpFSjl5MGR3VW1aN2V5UFNGSmNWTVFkUWJMcFFQ?=
 =?utf-8?B?ZUJqL1orUHYxaENuaC9jK0I4QXVHbmFmVWJxYUs3MWt4TlQ1ZW0xSnRhblF4?=
 =?utf-8?B?enFGc3dFZmV4OXFaRzFFQlpIaVRoVlRoblh2N3hVWUc3Nlc4V3VsUG1YVjgv?=
 =?utf-8?B?emgrRXFNYnV6STBob1Arc1hUMEN6TXM1RHF1QTFDWUZzeFVIdEZSMkx2Vkhi?=
 =?utf-8?B?TDZNNWxmMFlOMUU0L09vYWZXWnhkcjdBTllkNWNQRzB1ejZVRVNob2lTd2VJ?=
 =?utf-8?B?QXpyT2JiK3EyRnNPdHpBRUo0UFoyWmltM01sQmNWc0VYWmxBMVZJekViLzhM?=
 =?utf-8?B?Q2JtMDFIbGkrUzhCdndsQ3ZYSHR0WXFIcHBlSEl6QWRtelRTb1FxbDBMUVFP?=
 =?utf-8?B?MEp4YkR1UG5zaW1mMTVnQ2ZVZFBNdTArdG8rSmxPdnpsbTVOcFQ2S1JCK3Fl?=
 =?utf-8?B?UWVqQkJrWUo1RDlMMFdpMnB5ZDV1aWI1MHEzUlhuVGpQM3JwNnQxL0NaWVQ0?=
 =?utf-8?B?SmpSWVNlZDRjUUV1emRLa1hzN3FBY1JaWWZLU2JxejhJNUJ6T3M4WFcyVGVX?=
 =?utf-8?B?T2QrenZkRTYraFBJRWJUY3E5SHdlT1poWDExcldxKzhTQU1GU3BDVUY3WkYx?=
 =?utf-8?B?c3djYmR0RG03K1VJc3BLQVZPdVl1ZW0yd29yMmNhYTVYZG9hdVI4eGlFbWU3?=
 =?utf-8?B?dlBWMDBBVXlPZzFHMXJCRWszb0M0ZXpSSXArVkNLbldqUlJHcExoczRVNnZL?=
 =?utf-8?B?WHJhbDQ4OUZHRHhBRHdlMXJTNnQ3bXI3TVQ0N1Q1ZUgyNUs3clR0R0dseTl3?=
 =?utf-8?B?STRuZEVjdnJBVG92anpmR0wrWVB1WGdrUHFkMDBKcEM3Q3ZRanVPMGlEL2wy?=
 =?utf-8?B?di9abUlKUEtwNlJ5OUE1K1JXU1NyeTJRYUx0Y25TSjNldlNhd2k3NG1zUEMx?=
 =?utf-8?B?VnJ6NFdPeEFaY2NhUlNGQ1UwTWtjcGQ0YnZ4Y0lYSFJyQ1FJVVdsdWE2RFFk?=
 =?utf-8?B?TWVEQW9Qa2pUMFdoVzZ0VnBHKzUzNjk5ZmtDd0QvZVpWTldNMnBJNmJlZlVO?=
 =?utf-8?B?V0dQVzlwUVRzeG93dkNGb1QzOHZ5S1ZpQjBqaWxEaEQ2d1BPTzRvZGFzYkl0?=
 =?utf-8?B?ajQ1ZWNnTy9VbkFWWEhBUVBGMzVUYWplWHZ2NjFNMXV5NE9mV3dpWkJ1QXNH?=
 =?utf-8?B?MGd2eEtMR1FNU1F5RlFjcUxwSTl5amE0ZU4wSHFXRlVqLzVxeXlpVGFoRzc3?=
 =?utf-8?B?bEZ2ZUZlV3FxYlNMSHlPN0tzRFcrOXFPMnFCcnRjVkFheE9oU3c5eXExN0ZC?=
 =?utf-8?B?RFFpQjNreVE0T1RrTXhLN29nY1hGM0tERW8wN2tDL21POERxYS9tbURZT09B?=
 =?utf-8?B?MS9tNlJPYzF1b1RvT0JveVVPT1J5WkNHU1lLMXdJSVRyYVNUTFNqMFZldUlZ?=
 =?utf-8?B?bXN4KzVhWmhzcUlhMlhmWGpjQ2tWc1V6VU40aHJXeXNBV0dtWlU0Y1cwK3J3?=
 =?utf-8?B?T1A1Yk9HdjU5ZWNmemVWMmJDeUFXSW0zWW5Ud0VQeEd4c3hmMjgwK3VaMjR6?=
 =?utf-8?B?UDF1a0xwK1hjWjUrMmE2a3R1bEFkSFBtY21kTWFzb2dsQWUyT2Y2V0srK1Rj?=
 =?utf-8?B?Z3BSQ2M1TXZDNXpSOUR5THhYVVhPMUJOWVBnQ1hIRUt3dzY3Y3FKTUt4dm5O?=
 =?utf-8?B?YWpiM3I3RW81WURaSWZVVEIxNnY1aS82L2NCM0RwZzBKNDlPSVFDTTZwNkFv?=
 =?utf-8?B?NVNkK25jSjlDT2ZsdHRvRVpiSXRWUnoxZTQyMm9oNGdtckk3Z3pid2pZVGlZ?=
 =?utf-8?B?VkljMjZ3anRJbEN0NUdiKzlFbmlwck5tL2UzWGw4L21LMjVDYS9icjBIV0wz?=
 =?utf-8?B?aU9UWWhmZERrNEtpZEh3cDVkUVJ0YVVjcThYOWp1MTNaZS9lN3ZxZU5RMU1I?=
 =?utf-8?Q?LZJQLimT3YmhJdiwNYw3fRo=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb6d995-83c8-453e-f857-08dbad1c1357
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 07:53:50.1637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ViUoX2Cx3PTb6/0VXXZDDnj5Jxk7ooOFVnyjUIY9q6KzOy1FkSqR+WNqLg8e78ZL2VfpKCADV4MWJOOepB3Oe87Rzw4A+0zomGooxLgIaH6HuVkTy9kD2lMbXYd8GjCu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9421
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 04 Sep 2023 07:54:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15008

Hi Richard,

On 9/2/23 12:55, Richard Purdie via lists.openembedded.org wrote:
> Using tags with the git fetcher may cause surprising behaviour. There
> are reasons for this, document them.
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>   doc/bitbake-user-manual/bitbake-user-manual-fetching.rst | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> index f5723d6767..91538f4059 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> @@ -476,6 +476,13 @@ Here are some example URLs::
>      easy to share metadata without removing passwords. SSH keys, ``~/.netrc``
>      and ``~/.ssh/config`` files can be used as alternatives.
>   
> +Using tags with the git fetcher may cause surprising behaviour. Bitbake needs to
> +resolve the tag to a specific revision and to do that, it has to connect to and use
> +the upstream repository. This is because the revision tags point at can change and
> +we've cases of this happening in well known public repositories. This can mean many

Intuitively, I think "seen" or "had" is missing in "we've cases".

Otherwise, same question as Paulo, so will look for follow-up on that 
other mail :)

Cheers,
Quentin

