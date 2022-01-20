Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9766AC433EF
	for <webhook@archiver.kernel.org>; Thu, 20 Jan 2022 16:14:48 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.79])
 by mx.groups.io with SMTP id smtpd.web11.14125.1642695287332319971
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Jan 2022 08:14:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherrycloud.onmicrosoft.com
 header.s=selector2-cherrycloud-onmicrosoft-com header.b=kiNb8OZp;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.7.79,
 mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mqt1V4TYknX346Ugde+ccvitpI3v12GGnEkOamj2P7io/TYrd79yrr6NowDKhC5y6Cd0kVlvK/fDueZjjF4OIdDodJRLoKGmYSrhYzBP73WNZkMxFKDmhI1QgFyuGCSDDwTubschA/HjykydmNDo5gOvdDQxfchVsEX+gwYb2irxJe5zqxLIEmps4uJKcXf0sWNpd9Ci86vWYTBJSADh0n6SzFt74V+bPPQTO5AeBt39ztpDOLWyeKJl+HHpLb0wy0aCY/xbC/SMXKnCxJKKxQGefy0UpFRjtub5DsBdHHUB+YICufNP2WzgvRe/WKKAMAhISCJ+YBpZ+5FxVRF5Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=otZIqYsYkuILJ5suex4P3ceXfwxtI8A6i0uhzWrqIpw=;
 b=kefutFoyWj8ZYgTtIhCtQIqvnT63xxXyVKTuz1c/lYFg9LbLA8TvHUcWCa0Vd3O+MwbCAp1J7wYsgBb4tYnZFPcOFuEY/pP/uJ7zs/kUESiUZNrGMknBSFmF/CU6o5MyZnRx5u9Gu54FvDRZNkrbQ7TBzRIIwzJfiHjkKn2g+it427EmubgOEepHZuS2xTLCChB/RHIkG+9oie3kjIVuyUm55DZafdPiq7O27yK4cgfWl5q/SUcAEAQOr9JT3gPd+TWwlJCOq/aLin0jWoxmTOSGwH9Y14zBhm0kcujPr5dsKv+bsz3vd9Ex2Ehc+aTYExCOGbrFZ/Xre3BO7wjVDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otZIqYsYkuILJ5suex4P3ceXfwxtI8A6i0uhzWrqIpw=;
 b=kiNb8OZp22ugXzzeJAB8ZJ8444ZV2tKCIpFIJE6DcER2dSr8l4Fl/4lB/b2apYjlkmlbYbuoJVRmpDMzT+U8prv1ogQVFUBqvsPi0HsR3GGnoSF8IHmdwGY5VUFzCfcJ2XkV9OH6yrtSg3E9IwTpbpfQgL/e3RR53244+VnO1XM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7)
 by PAXPR04MB8159.eurprd04.prod.outlook.com (2603:10a6:102:1c1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Thu, 20 Jan
 2022 16:14:44 +0000
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::a8e8:87d3:e868:cc93]) by PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::a8e8:87d3:e868:cc93%8]) with mapi id 15.20.4909.008; Thu, 20 Jan 2022
 16:14:44 +0000
Message-ID: <4e8ab9cd-b7d4-ba52-5f3a-40ec43ecf978@theobroma-systems.com>
Date: Thu, 20 Jan 2022 17:13:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [docs] [PATCH v3] bitbake-user-manual: add "crate" fetcher
Content-Language: en-US
To: Michael Opdenacker <michael.opdenacker@bootlin.com>,
 bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org
References: <16CC062B871C5B48.10162@lists.yoctoproject.org>
 <20220120161033.1914574-1-michael.opdenacker@bootlin.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20220120161033.1914574-1-michael.opdenacker@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0030.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::19) To PA4PR04MB9367.eurprd04.prod.outlook.com
 (2603:10a6:102:2aa::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45c33baa-d3a9-4531-8bd0-08d9dc2ff876
X-MS-TrafficTypeDiagnostic: PAXPR04MB8159:EE_
X-Microsoft-Antispam-PRVS: 
	<PAXPR04MB81597BD28D25A2DD0A31E24BC25A9@PAXPR04MB8159.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:404;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5xCX6hYytC4ztvaJHSIPjUpS+iZkycnjVpiXHCa8v+Xr7p4s/1zA27bLRLz8Iar6TxRKkVVbrW9kFS5gLv96V/NCgb0lEW/yb4r/AO8ssE5dqKapEYRg6nvd3M3v8g5R+IDCiFQ2cQgnV0X2zF8Z9KIYiE0zA6xBo3L2GEbVR9K2NMB0E2cDtum3WYfE4XMrGA9G0upHADS9rG8c9abaw9qTmKti9ibD1VDTkjrwEoc3/b3cm3oBhEEp0H9vUiZEFmjA3vswGXGXdfmNN8L0uX0z36pU/d75zxfWxFtCQb8Oh9vVZZOGLK0rjVx4tf5vP1mT4xXIJnd0fb7fV06PKWY0dXP4ZG0ne++NwCHNgW9TNe1GeOtzfNu1xgrxw7zrd4v0FtuL3Juntj5DPrh2NeTcSZ4sbUqad1oRrDmlrFif53gbutR2M6PpMTQbFk8L6+JpSY9X+/jxO8CnDOVIvU2ut9ws8olfuWY7qX6fVAJK7Q1STuHdC3BRu0acY+TKjGZFBKirD5NkkPum6ugCJNgK5EE61q1inrINDXIXQPu88/HeFbrWerIZGxiSgMx4NW6QVHS/K29KCdlJkAPf2i2lDQEz1Zd1rV0lBloHBQfPTpyFWYzqKE6xLF2AcRqKV35Gd9ZDWIFCrSeRthn7Gt4aReH+/eETchwcBcF0TUaCjWUyiRQcXZXa3lWlbtw+mnhWUCzJzrCqjT5pfcllcgCHW+fsymfi93g4rhYmSqw82lFFx9kFN3Cd7NnZ1uDzUDCj+HcmwaZHe6NFS/qedCse0fd0q+R+qa18lQqPK/0m/2nS410zV58nv5tJnGoNihwqckYaU49CPjhb+MKxXkr4GisrG7r9e3f26RY+V/A=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9367.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(38100700002)(316002)(186003)(6506007)(53546011)(86362001)(31696002)(2906002)(6512007)(44832011)(31686004)(5660300002)(4326008)(966005)(66556008)(83380400001)(508600001)(8676002)(8936002)(2616005)(6666004)(66946007)(66476007)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?R0tyY1FIN2tBNDlmTkZmYVhvZUx4QnczaFBwL2YyYlNUNWRWVjFvWGhFanBs?=
 =?utf-8?B?K0JsWUZFYVdyTk1mU2VaVDcrYkYxOFNoc09qdk5iTDk0Ulk3RzR5S29qY0xi?=
 =?utf-8?B?OVc3Z0tFYnRua0R2cVhrRkhQVDBsOEZydERjaDFpTnBRalZ4Q2ZSU2hsQTZ1?=
 =?utf-8?B?VXo0ODlDRXo4RGtMeEc4Wk9ybUNsWkhKQXNORlF4S25sUXphOTRTRURtejJ6?=
 =?utf-8?B?dkR4Qm84UXVMR3NWd0l5S3BoSFlERVpwTUw2NkZNSHkzL3EwTGYwZk9TWk9V?=
 =?utf-8?B?VWRuQXRjYnBrVWU1OGNSREc5K0IvY2hSMW1pZjhYVWJ0akdiLytEVmRqMXhl?=
 =?utf-8?B?amlVbVZKZzlsQ1ZMSDZhSTM1QjZPRmlWQW9DejViSzdKRVZkQTE5RHJUT1M2?=
 =?utf-8?B?VFJnb0RYTldiTUJ2dWg4eWlsU0N1Q1NFTVhZRHpHb1V5L29UOVUramxuSnRV?=
 =?utf-8?B?T0o3WU1DN3IyZ1EwVDJmZi8rcTZlZ1lDZGhIVEFjYjQwN1VXdm90b0JuV3Bq?=
 =?utf-8?B?TmJkejVOdDAyOXFiZWZDQnVhczh0NytNbWFOcnFSUFRuNW1pNmY4bHVhWXlY?=
 =?utf-8?B?KzFmaUpDWEVhczU0WlhCN3BLYVo1SUNhN09QaXJtWkF4aG5mOWd6WW9vdEVr?=
 =?utf-8?B?eVdPMTBodHlDMCtjMFIreGlYM3F5a084SGltY1p6K3J2R3pmZ1pvcHl6b2hH?=
 =?utf-8?B?K2djNS9MamZteTBkNG5CME1LTTUySDdrRmI2UUxacFBVRHJRRWpzMmN2b2xl?=
 =?utf-8?B?b0NZMldZdnNuZTNKSHF6MGdFeEI4SFdXa2VKQU5rRVM3T0NEUjhoOUFEdzZr?=
 =?utf-8?B?VDlORCtCbU1aWDdSQmlKZHZxaFNyMjRRL0QxNHZmZzF4MDlFRU8rQ1dRdjBk?=
 =?utf-8?B?RVNmL3VqOXB0b2Z5MklVdllmS0I5eGV1TkhKNmdUaEk1UzdrODg2V1k2elVs?=
 =?utf-8?B?WHk4UkdNaWM2V0lONTZFMU5qWHpucVhLbDJWMUpTTUtkTVlobFI2dE5SZW1U?=
 =?utf-8?B?QkpiYjhQbW83YmZ0MHVEQkJyd2Ixc3lZRVVJVHM0bFJ2Q012K0RLK1hMRGxT?=
 =?utf-8?B?eVdTMjE2dlpmaktpSkdNejJmcEc2TWErRDRGc3BPdS9mZ3JTbStnaHdjSDZH?=
 =?utf-8?B?bnB6WDI2NHo4c2hiOFE1Ri9NdGFLVkhoeVpCVjdQM2k0VTY0Y3dxWXNhU1Ey?=
 =?utf-8?B?RmY3dDBjQVRqa2xXU2pXY2xPMUg2Y21DUCtUc2VRMWJxM0h2d2o2TlMxQzZs?=
 =?utf-8?B?TjFxTWV5UmRDUGZuZC9WR2RuOWEvdTNvamxJRG1ZVGlPRnFaRSs5Qm83Z2cr?=
 =?utf-8?B?VlVxTmVoZUoxeGNJdUY4QnE1c2hvWFFjb1Y4bDhpSWw1cDFJYUNIdXoySkY3?=
 =?utf-8?B?eHYzR0hoQklNUTl4enI1T0huYmNXc0VYU3p2UytDSzE1QXc2ZU84bytabTJj?=
 =?utf-8?B?SllYbmxOQmJQTWdTc0pyeUFrOElMRWt4MHFXVzZyN1kwNThQL0N3clRKb1dy?=
 =?utf-8?B?TGt2ZUVVRHhGMTFxS3BCZDkwWGxiQk9tZkJmanlDNzZHY1d0N0ZCazEyeTJG?=
 =?utf-8?B?T1FVeVJqWmtjeFBKMVZTekQ1QWZaSVV0ekQ5TUhUZC93cXpDWEV6VHg1SHFF?=
 =?utf-8?B?M2cxd1JDTmthV0ZJOXFHRlFFN29uSFhrWDhUWi9CaFF2SmRVMThMTlliVUZG?=
 =?utf-8?B?WURXTFBydXFGbVlEUzhTVFJTWHlmNEw5OWpscTZBU1RIL2tTNVVNWDBCTWhy?=
 =?utf-8?B?S1lDcWs3czk4cERCRnpkOVFrRjRZeTFVS2xJL0dQQytLVzhMUEcrTDAxbVJx?=
 =?utf-8?B?U2pLRzFkaDA5bCtaOHd2dTNSWjNjbzJBc3hWT1ZvU0pBdUpIR2NucGRWSytw?=
 =?utf-8?B?RFpKRExNTDFTblFMU0xMM21la0lpYkluZkdvZ2pWMGlPYXlBSlBrTFdkQWVj?=
 =?utf-8?B?dTkxczAxc1J0NG0vbE1Hd2duWUxqQnd1MTY0c3lEaFY4SFlDUXRMQ1NHUzVN?=
 =?utf-8?B?L2tkczd5WmVZWEFKdlF5QzY4MzZMU1M1Tm1OcTlGZUFUTE9mcEhBZnNKMlM0?=
 =?utf-8?B?UWNkTmxHM1p0OElHNlhYdnZ6SDFiWjQ1STZKS3VTSG4rZWdET0trNWlIYmM1?=
 =?utf-8?B?WVFMTGlCdE0zQU1WcHFQWkZNZ2ExU3QrTEhialVYdmppVzViVTBJRjJJVk5F?=
 =?utf-8?B?WmhPbmlZRFEyVTZIMVhFQUFUbU9oMjZUc2l1aE1CT0x2TVVCSVZ5cDV0VFAw?=
 =?utf-8?B?MFE3Y2hZMTdjd0FabVRpcTIwSDhISlBQQVptQWYwckhKem1jWUN6N1lLQ0hw?=
 =?utf-8?B?WVJRMVRSQmNsRW1xeDZZMHppU29QdTg4aEpSM2Z2Mm5HRkM3T2xJMHF2NUR6?=
 =?utf-8?Q?nHcj8lpnmILXoNHE=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 45c33baa-d3a9-4531-8bd0-08d9dc2ff876
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9367.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 16:14:44.0821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 Y6R7+cWwz38aoTt26QsKqzNCC4RdjVQBDBIm88YuaYnKMaCmAe2x/KpPLX4tlYpD7L0QLzIKY/rQ5Frhv4K/2TNfRKvZAZFz592gJLLiLhuLYI6G4qC51NjJWEoRIutg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8159
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Jan 2022 16:14:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13262

Hi Michael,

On 1/20/22 17:10, Michael Opdenacker wrote:
> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>

Reviewed-by: Quentin Schulz <foss+yocto@0leil.net>

Thanks!
Quentin

> ---
>   .../bitbake-user-manual-fetching.rst             | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> index 77384cfd..9ff4e161 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> @@ -688,6 +688,22 @@ Here is an example URL::
>   
>   It can also be used when setting mirrors definitions using the :term:`PREMIRRORS` variable.
>   
> +Crate Fetcher (``crate://``)
> +----------------------------
> +
> +This submodule fetches code for
> +`Rust language "crates" <https://urldefense.proofpoint.com/v2/url?u=https-3A__doc.rust-2Dlang.org_reference_glossary.html-3Fhighlight-3Dcrate-23crate&d=DwIDAg&c=_sEr5x9kUWhuk4_nFwjJtA&r=LYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=smwavBxvdIfpATPOOnqwchEtwaUwIkByMRfarPgCp9T1MRadhPIpS-_QVHRdsQAv&s=2FzJNuq0EnCIkEtiO0eoUC8Whyl2gyGfhEbPBZ_B-so&e= >`__
> +corresponding to Rust libraries and programs to compile. Such crates are typically shared
> +on https://urldefense.proofpoint.com/v2/url?u=https-3A__crates.io_&d=DwIDAg&c=_sEr5x9kUWhuk4_nFwjJtA&r=LYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=smwavBxvdIfpATPOOnqwchEtwaUwIkByMRfarPgCp9T1MRadhPIpS-_QVHRdsQAv&s=aloVVPM36_ArFdokY62cSOG5Nl8AYRIv5eQ8lt4_GZ4&e=  but this fetcher supports other crate registries too.
> +
> +The format for the :term:`SRC_URI` setting must be::
> +
> +   SRC_URI = "crate://REGISTRY/NAME/VERSION"
> +
> +Here is an example URL::
> +
> +   SRC_URI = "crate://crates.io/glob/0.2.11"
> +
>   Other Fetchers
>   --------------
>   
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#2439): https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.yoctoproject.org_g_docs_message_2439&d=DwIFaQ&c=_sEr5x9kUWhuk4_nFwjJtA&r=LYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=smwavBxvdIfpATPOOnqwchEtwaUwIkByMRfarPgCp9T1MRadhPIpS-_QVHRdsQAv&s=gSn-BFr9fUQ9vJ-6e2Cf0vd_U-DgQarHt_8_iDAb2gs&e=
> Mute This Topic: https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.yoctoproject.org_mt_88562115_6293953&d=DwIFaQ&c=_sEr5x9kUWhuk4_nFwjJtA&r=LYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=smwavBxvdIfpATPOOnqwchEtwaUwIkByMRfarPgCp9T1MRadhPIpS-_QVHRdsQAv&s=JrJkbbt8IIm7sOYN6JE7t5k_FeOGh66dbNSmU5HzZtk&e=
> Group Owner: docs+owner@lists.yoctoproject.org
> Unsubscribe: https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.yoctoproject.org_g_docs_unsub&d=DwIFaQ&c=_sEr5x9kUWhuk4_nFwjJtA&r=LYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=smwavBxvdIfpATPOOnqwchEtwaUwIkByMRfarPgCp9T1MRadhPIpS-_QVHRdsQAv&s=YL4S3fH_BGwCXFtPJbnoGo675TdOAhhFibvm2TMtb1E&e=  [quentin.schulz@theobroma-systems.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

