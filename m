Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DF6C433FE
	for <webhook@archiver.kernel.org>; Tue, 29 Mar 2022 09:23:08 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.50])
 by mx.groups.io with SMTP id smtpd.web10.4651.1648545786086398827
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Mar 2022 02:23:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherrycloud.onmicrosoft.com
 header.s=selector2-cherrycloud-onmicrosoft-com header.b=b0mW9DWc;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.20.50,
 mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOabbC3JDH0YsfetNPjP8nV18qHGhVWJLvrOyfVogse1A2QWTZVINAgpxzEj7RcrIjDTPhdbQd6Z4s31d0ck0cAX1jTwq8RIKVTDcKj3f9ndol8V6VjA6T8Hj+Gl/+sC6A4lWUukGKxpMjtnWoq5273zm8iBEIXdQD2jN+GRzxOOA3ODyB8vsLtyrQGTz6rJUVAOtn5Svw31G/GlyL3p1Gn3dRswmgMxzzlQHNLzR/mkCh3x0+AM/9Dwpzzp5qFjpVPj6Nfizq+GiTNNTJWajj9pKLJDPNXC/Ia0oaWFpkuN9lMpznMAGjspzb99U+gMypqSLGQkCNmavRvAw+NLLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HfYZrLThdPZmAIbG1JtpnbfDxWP9fRuNpB5gMuNui3A=;
 b=OipfTqPOSxH9tKs01vLnRgmO+XHrN80i29zJEkBMvn1MzkZlmdEdyz21WI9mcVhF3FPxZi5Momk/vVVQcrQwyCKkPrpn1ZkLmy8eV3B0NSBG/+/d6ULo7T4uMhPWdfpzOhru7kJwC23GGON2DIUF9NLy0wbDxsuGGBliou1ob/QiYY48h+UYmP4eOqCkAHmjUydC31NlNeGJ14/5dCiquurpuU7nUvLdJNspFsWsNEkYZ9csxN7pHdygTFO7wwZtyqsMPAPHOeNCVBPQUhM/JS4r9ysh2dojCq0+U9wPAxSRlnbuP2qH77PKFm+4/NyIrSMkcrtWEES3F31oJ4IzeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfYZrLThdPZmAIbG1JtpnbfDxWP9fRuNpB5gMuNui3A=;
 b=b0mW9DWcM+zwi8QszYf4pH/f0wCcEsyD6c9TuK6KzFcXiHg9JEBkKtjLNsAMjLLdikMzuA+h2XijfBKAyDwLxOK7sAsUOWvTJNT6n4IUJspjL+IjQAC3DJI/oz+yLY/2O2YqL8e4BXrEU3JlHGjg1Oe9cFFm+96wQ0sO/3G09mI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7)
 by DB7PR04MB4009.eurprd04.prod.outlook.com (2603:10a6:5:17::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Tue, 29 Mar
 2022 09:23:02 +0000
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::8ca9:a2e2:60c8:95e]) by PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::8ca9:a2e2:60c8:95e%6]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 09:23:02 +0000
Message-ID: <3a9feada-42f3-bafa-d07f-135777a2f243@theobroma-systems.com>
Date: Tue, 29 Mar 2022 10:23:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [bitbake-devel] [PATCH] bitbake-user-manual: fix broken links to
 manual releases
Content-Language: en-US
To: michael.opdenacker@bootlin.com, bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org
References: <20220329091721.350606-1-michael.opdenacker@bootlin.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20220329091721.350606-1-michael.opdenacker@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P193CA0047.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:8e::24) To PA4PR04MB9367.eurprd04.prod.outlook.com
 (2603:10a6:102:2aa::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64fb1506-3005-41b8-5245-08da1165b952
X-MS-TrafficTypeDiagnostic: DB7PR04MB4009:EE_
X-Microsoft-Antispam-PRVS: 
	<DB7PR04MB4009F9421CEB9BA1DBF0FBFFC21E9@DB7PR04MB4009.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Uj1yj3myDPxeVHwm9TQ8SPtmTzfbrLG7SienFbMG+HoFdOs/fpgB8pQu0PcAY+Sh+y9amoWHw5D32SdeItJ8G1g+oYia5jvLRQQP/g6xCeWKgsJcMZe/xbVcFWuo0A/X6XoMd6/AV9QDxQbSKD0d07YZvscjwOMlZjO+DDyK3yi+iaIDgcXxugfq1W2aLxKiL2/IswUuYaeA0FV2VccaLJC7KheRXs7cFzxiTwTxff32F+oHnOYw7TP6Nws6Q3/iMDIc/r71uzgY69Lfaiz8qmjBremNQnkgFSv043TC1dGSEJ4GphDPBdpoRUkTH28oRUlYxfxECcnfePh9LpSLh6m4BKdL+Vha5fROI48EOEs1gjLIsVHotAfWzX+Xs0cwkT7lCDePefNtByx9g/KP7CbAbF7QFdQ6slois59HwvLnv3rDUVtslAoTUPS4L43I4ZOmodjzqExq6VoA+hohrgEZmBAOv2oSqlvvoH9j3CtAB8TGXYwrvaIfDRKAw7wFGCIySaW8wRMPJwYl5BmNATRet/lGgmsEoCIu7pYdXBUZkWmDTlOwEIawSfYWFnNSbKLEZLAX9EdBAFEk6F/m/L3xN/83Mxyztq2/6e7j4PS6p3y66QMuXNI2DuqL8VLNTRCv3uKKHiFfUFC6CMu0/xp5pfLOm+DvUhrJjQ6GAoQmvTFYvRXcbpUYvAs5CSIV8PoiObO6HykfuCOI5/+B6ep4tQ/s1rPxQYlszIwhqxs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9367.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(38100700002)(86362001)(8676002)(316002)(6512007)(36756003)(508600001)(31686004)(2616005)(31696002)(66556008)(186003)(5660300002)(66476007)(6506007)(4744005)(8936002)(44832011)(83380400001)(2906002)(26005)(53546011)(66946007)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WldZcGJ4bHRjc2k1a25PSnhySHcyZ29HZmtHU0s0cittU0FmMXFsU3Z4K08z?=
 =?utf-8?B?bURONTh5dS8yc081YnNLSDVPRDROMEVWaTVzcncvRXlFV0EyOWRxalBGcWRG?=
 =?utf-8?B?c01NTEl0SXcrQVZhdHF4Sy95VXUvR0gxNDRnb3p6cFZ0VFZyemtSVndJaXN2?=
 =?utf-8?B?MGZLWnpOZEJYQlZXa2VtRU5heXlqdEVhNUdaWVJxa3l2aU1WTFNpNEVEeWUz?=
 =?utf-8?B?RUMyekhMQVhsRXVLbXFhamhwTmlqUTRpQTFBMER2QStjQlZ2dTRRU21WaG82?=
 =?utf-8?B?UStLUG9rUENHNCtERlVyTkZCREZRS3YxS0FKQ3NpRHcycllyMGhuc2dqZEps?=
 =?utf-8?B?RDVMVmxPTGRQZy9Uem43eS9ua2FhTGhZajdHSHAwZnIzZGxBbUtRbktIN2JM?=
 =?utf-8?B?SWh5M1F6R2ZuUTBLTHBYRHBaYTA3WXRvRERnTzBsQU9wVU5FN1ZSakFhV0N3?=
 =?utf-8?B?S3BWbytyRE1NRDhrWXl2N2hTUzJCNk54MHVlWFhacFU5QVJ0VEZJZkdKQ2s4?=
 =?utf-8?B?eWRpdjVOQXNpcXo2WHJJd29sUWtWUWVwY2haeXpDd2F2b085eWo1ditlQmYz?=
 =?utf-8?B?Y0NlT3h3M2pISTdyQ3lkSm83eUludmpRZm1qNmcxT3NuclY3REg5MXJSTG9D?=
 =?utf-8?B?dHBxZzBWem1GQWVWNGVvUlBMdHFNaThjcW5PZzlpNkVFVytQdVlBZG1iV3FC?=
 =?utf-8?B?TmhPYjFrTVVTSlQvME13QndVQWxLSGd6VUQvcysyWXRoL0wzMlBLYUErc1Ew?=
 =?utf-8?B?Q2NWbGdmRnFoeFczU25yRng0SmZRb1piSE9VY2o1djVoeTBpL09tc29nb0E2?=
 =?utf-8?B?ZHRvTHlSQStReGU4cnVTbXpDN05BdXpjbCtKdW9mQzZPNjBLSGpqdFRYME9q?=
 =?utf-8?B?dlJWbHl5UDBTMWhFa2xkdWFkS01QTkxiVFoyYy9BQ3B6RVNZSnI5dHNJaUFL?=
 =?utf-8?B?MCtFWWsvWTNHVkFmTEpUcjgzaGI4Y0ovUW56bjQyQlMwdVBHZ1NtRllmcm5G?=
 =?utf-8?B?WWc0OGVYUnJIWjRLN1M0eTlKZnJmcVQ5d2h2N213YkFMLzNuWG1raHp6MnBj?=
 =?utf-8?B?Qndsb0tKMzRqTWk0UlQyVjBQSVRmZXdEWTFsRFBWWnVxRGVpSVF3Tktpa1Ar?=
 =?utf-8?B?MlZJSlh4ek13RHFXU2RYRmpVOHAwRWRoa292cWNCSWhnSG5JUzRJWVdPNS9W?=
 =?utf-8?B?dEdKeE9pTk00eUxNZ0ZJWlJNc0tqb1BnQlZUOC8vRUtDWFNGTXRxeGJadE5R?=
 =?utf-8?B?bVJwanlQQUlFK2pVWHlNUGtBbnV5cHJJaG9UbDBaaGpDWDkvbU94QUNvUUFZ?=
 =?utf-8?B?b24yQjdjTElEc1VGSzRlT2hBcGRaT2Jma0xheTVYczdDaTNNdXRpTUsxNTgr?=
 =?utf-8?B?WWN5c3dWVHA2REhwMWNjbXBzM3hNd2MvUnIxaGN6ZGp1UHBLRklrQlVReDdI?=
 =?utf-8?B?ZmNtcTdEem5sZXFqdVQ5OUpKSlUwaFpHMXZDTENGblBHWGVKY0pTb1F6MUd1?=
 =?utf-8?B?SE9HaS94OHdmWWFKdk1DTk9YaENveW0zOEpDWDF5T1hjS1BVYlJQMTE3eW9O?=
 =?utf-8?B?TUtCbk9PakplekpNbUNsZVFGMGdXRjMyd3M3eUU3bjkrZlI5SjZFYUNydEU0?=
 =?utf-8?B?aDJ0MWd6UnVFZi92aVJsdEhwK1RPWWJwUGhPSVFZSzc5aDAyNDRiZkE3N1M5?=
 =?utf-8?B?VXQ2dzAwd2hIOGd6bis3WDJaNUZlNVNZdWRsVmVXMWJKTWg3TTVZTnZqaC9W?=
 =?utf-8?B?eTNNUGdsL0trbXNOcWN0Vis3TXlES1prT1lrSENlSStUVC9td29xOHJUTWxp?=
 =?utf-8?B?Y0dqazZHaWVSaW1xUkxMSlNMakhhd2NGQ2FBODNJNkVETHJHQ2RWaVhNb3lB?=
 =?utf-8?B?b2tqb2NKVmcwNS9IZG1QbkpLZXk3c05KV3RJTlBWR29KSHNSZVJtM3J3aDFT?=
 =?utf-8?B?Z0hhTVdSeVNvVWE1Q0hFUFc4dTJaMCtUemlqazUvSVlwekxGTGFDb3VrS2dR?=
 =?utf-8?B?OTBTRk9vK2V4Wnh0dHBtcEViMG5ONEhXT3plbWxFMGYydXdqc1FobjVYQUlY?=
 =?utf-8?B?MGMvVEZLQXVnSHk3UnBVM3RVbXIybHByUVpHK08xcEFGU0FWT3lZQnk4L2FK?=
 =?utf-8?B?R3habnoydlB6bVVIdTBzVExLY2E5VXVmemEvaVVOdlNDTThudHlQVFJVcnYr?=
 =?utf-8?B?aEtEZDAzTXZ6NGdmUExsOGZMa3VRZW5mTGxRdzRHdFlUVEQxL1JlWFVwa2Yv?=
 =?utf-8?B?MnJsNzl3NHRvNDBsNFBuOXlJQXpzblVhWlhtWU1PTjlXS1hlM0ZmK0tuaUJZ?=
 =?utf-8?B?elE2UmpnMTVjSmdObjgrQVhYN1Y4MnQxNnpmSWY2bEQyUVphVXB1bzhRSncx?=
 =?utf-8?Q?SsJDMHRYhs5Oqq8E+OB4LVHJpd1ElxUqWrgRz?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 64fb1506-3005-41b8-5245-08da1165b952
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9367.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 09:23:02.6457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 I2xjQJGayiCgJC0f4qCFqJUHR8C63CnCQVQH5usbZqi3AieL9wAXH+a/v0C/I6dtq1nciG2w3Nd7H65JM8STHFSUU1Pcp18lW/FtfLlxnS01fmV0jdRG8ks2IomvieKE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4009
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 29 Mar 2022 09:23:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13530

Hi Michael,

On 3/29/22 10:17, Michael Opdenacker via lists.openembedded.org wrote:
> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
> 
> Due to the fact that Sphinx documentation is only built
> for BitBake branches (1.48, 1.50...)
> 
> Available pre-Sphinx documentation is kept.
> 
> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
> ---
>   doc/releases.rst | 29 ++++-------------------------
>   1 file changed, 4 insertions(+), 25 deletions(-)
> 
> diff --git a/doc/releases.rst b/doc/releases.rst
> index 6635032c..216dbe10 100644
> --- a/doc/releases.rst
> +++ b/doc/releases.rst
> @@ -8,40 +8,23 @@
>   Release Series 3.4 (honister)
>   ******************************
>   

Wondering if we shouldn't rather have "Release branch 1.52" here instead 
of using Yocto release numbering since Yocto is a user of Bitbake and 
not the other way around?

The rest looks fine.

Cheers,
Quentin

