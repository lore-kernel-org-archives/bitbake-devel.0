Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D54AC83013
	for <webhook@archiver.kernel.org>; Fri, 27 Jun 2025 15:13:58 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.34])
 by mx.groups.io with SMTP id smtpd.web11.16349.1751037236723759446
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 27 Jun 2025 08:13:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=SBaynkFu;
 spf=pass (domain: cherry.de, ip: 52.101.65.34, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SB0LnbX4c4YgYTyIoiT9R3MdS2kUFxS1bq5oSkfLIAZZsoGDVPqtWMBFJKznunRaDafMS/qWaRmPHZmSiqK79653dSP+U02E0p0atp6LnNu4hQAzfB5K1+PN6n1JKKIl8Xf08zYzI9Usce9gORANY46nbORnV9FCqGqbChjPeEXwJuVmP2jlK5an9yFjXz53nHW6ikvJLh2qGxY4oKByzv+9or9DX59RIH+Judmtz9ny0TClPdu1Tvu+NY+p71Gk8CBY3iiNYAri0Bjy1heTbNsM0jQfz4ARpngLlt1ARaMg+xky5TvsUzEzRw3+awGFHlWjgMKysrwq6YG1EDWaMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWoXAqG/UnlWMgM8UUd0I+AtjTCfSiUOU5dKGit/ORY=;
 b=FFjMjVITTbgyjlkjMT1sjsv/+SfJbM/1aWlkVRlZ5b8wb603X5b3bwSvFR59hH3wsOK38KRNk88IoRcLNBVFqdRcccwbZlsNkFaK42AYIyvYypD6dJMoK2LRYA4QMs3rOPWD9hqtWYFKcsH8MwtAdMK0CwnKYrGrooQSH+frwQeIVOYUeVl/VgRglmqC07n0+0EVwFweB7TESg+4tkX7DqWQlIbeXUL6yTP3zTLJOOuhuBf235khfzOc3UFe0u+ou7dJx6al1Cr8KkomVSGXTVR3+6Dd3fbjuzs2vnMCXGwvUEAQ+CXOaRtJfA4x1s73UpAUng4SFEMnWJ8G3UcBpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWoXAqG/UnlWMgM8UUd0I+AtjTCfSiUOU5dKGit/ORY=;
 b=SBaynkFuA4thG/yb0UV23orKAi0t+EAUQXXP/Ulk8XqLBBlurXPoO/NwHS4iJZ+T+3Ylt/pkRIMezcy2xISD/+D4839B9ZRlkUXpDl8KTGt413NGa+V0zWYL/pTOEPXUhwpQOG/9OMc3pRRUKEmUT6rylkkw0Kw/UA4UdovDgZM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA4PR04MB9341.eurprd04.prod.outlook.com (2603:10a6:102:2a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Fri, 27 Jun
 2025 15:13:53 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8880.021; Fri, 27 Jun 2025
 15:13:53 +0000
Message-ID: <cee995db-4c3d-4bf0-813d-ce3f5f8f92e3@cherry.de>
Date: Fri, 27 Jun 2025 17:13:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] doc: bitbake-user-manual-ref-variables:
 document BB_GIT_DEFAULT_DESTSUFFIX
To: antonin.godard@bootlin.com, bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 docs@lists.yoctoproject.org, Alexander Kanavin <alex@linutronix.de>
References: <20250624-git-default-destsuffix-v1-1-a0cc44734f94@bootlin.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250624-git-default-destsuffix-v1-1-a0cc44734f94@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0098.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::39) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA4PR04MB9341:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c5e18ec-43ad-4d8c-beda-08ddb58d3aae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RVlWNUdaTkJOMXVWZXozOGNtSUVSRFFyVXo0ZGdzdU9wdmNRNlVveVVleGRS?=
 =?utf-8?B?aGxOKzE0VUs4K01iN2ZzYi90eWJwcWh5RWM3Mk9oUkdQMldscmx1MTZ5N3A2?=
 =?utf-8?B?K3AxZWdQbzlWa3RIbzdPN1RLc1BITnZOUHlpeVVKM0ZwZzlZL1NYdVd1N2dz?=
 =?utf-8?B?UU1Rb0NCbDV3b2loODNRNEgrcURKWTBoQU44b3E0UUdVVi9UZjNiby9uYjgx?=
 =?utf-8?B?MmJxejE0d0hVYndMbzJBNWgxRC8wam85WjVBMFhxbU9jVVdrSkNLd1BLb1k0?=
 =?utf-8?B?N3U5TlVVaS9WRDMzV3JINkpXRlJxbUgrSmpqR1g1WjhuUVU1aUdaS1FDSXB2?=
 =?utf-8?B?RmpXNW1GUTJDV0tWeVlWZzlVL0xPckhocDlydDVSZElRMVVhTk9LVyttU2hy?=
 =?utf-8?B?YUlZTTJqZVZ4SExYZ2orQll5clF3WVF3OHp1Zk40L045ZjBXQlVWeWpJeFpQ?=
 =?utf-8?B?M2hzeTg1STBiY2ZtOUZxSmlCOVRRb28rcFBsTUpQZjNxNklCZm1Hemo5S1NE?=
 =?utf-8?B?a09hUm1NR0FBYzIyYlJzTUtHendQMnZQc2V2VEw0NTdiMGZ1SmxGUUJ4NHU5?=
 =?utf-8?B?Q201azE1Mk0zcGJmT2V3anlIaytSdTlIYUhXdysyUTRSRXYvdjZlVE9wcTNE?=
 =?utf-8?B?bnh1bC9peWFPWk1kOXhvd2MvaHpNN2tHTmc3ZWVsNUIvODk1N1JWdW4xYzFj?=
 =?utf-8?B?aXVrdVhzeC9YRk5WWjZKV1hkaW4rVmJJVVhZanVlcG5XTWxDUDNZUnV2K3Qx?=
 =?utf-8?B?b0NPOVFkWXZNNGExU29DUlRDdGpRS2VENTFmaDB2UXdTQ0QvMzNGM2t1MkJ2?=
 =?utf-8?B?RW5HM04ya3AwL2tjTDhvQVczdUdSZ3l6REVQdHBFVVg1Rkhvdkx5amRZakJY?=
 =?utf-8?B?ZnJhMHJPV0NWTk9keW53WnlSNDdnY3hFL2RQUFMwWElYWWhiTTdpK3dCV2Y0?=
 =?utf-8?B?Mzd1WkFGSjF0ZUFuTi9aWFV2V1ArV3J5dDNxS3dteFFpdEtsMjZ0c29uNStj?=
 =?utf-8?B?dTgrT1lIaC92TmpWb2NIbTZUNGRwTFhPOUpyaVJkaytQMTJZd0pNejZlWHlr?=
 =?utf-8?B?U3g5c2ZGMnhWbHJxZjFnMW5vK3pjY3ZEOHJDblljK042cCtJditnMXEyWmR1?=
 =?utf-8?B?KzJTVzg3cllxU2VCb3puK1lyY2txZUtXTExadjhoSExZWVZxV1JaL2JEUG9M?=
 =?utf-8?B?MkJTNFF6aHhCVFluNEd3bXVOZ2NlQkVVanVaYW0za25UMjUrd0ZLRzk1MXdZ?=
 =?utf-8?B?NTM3OHRBV0lWTVNEdGp1UkhEaEJGOWloUWpsUmZRVWpRZFZVb0xHdXVxY2gx?=
 =?utf-8?B?aW13RjQ1bVA3MFFaYjdNOUhWMVRqcEIzaWphVkFQWVhHQlRDQ3NONnptRnlI?=
 =?utf-8?B?VDRuY0IveHVUNHpQa3N4dHAxWFY2cm5QY2svS0xzY3FnS3AxOHNQeGNkVk1v?=
 =?utf-8?B?WG5GcnU3UHAySm9vTkY2c04rem03Z0FmV0ljVGY0aWVOdWhRYUhacnYvcE81?=
 =?utf-8?B?ZHBEZzArSkhEc3dVbXJZWXpKY2N1aUZnZFMyQk11L2NiRjR0b0VidmVKS2tk?=
 =?utf-8?B?TTY3SzBJRWFXSnI5VnlMU05lWFRTTWJVUnorbUVlclJiNUU2WGNFSlBjNHND?=
 =?utf-8?B?N3N6SUo3UHpYNWQ4Vzdkcjd5MUg1SGNuNkZVN3hwbW43UVFZNEVscTU1dStW?=
 =?utf-8?B?NjFsV1oyMmxIRTd1cVM0UkZFcVJpMUc2eEZaU2hrQmxHMnZNQ1pvWlVtTTky?=
 =?utf-8?B?L0I3bWZ2aDlzRWNmUnZEMHZYU3VhMENWRVVtVTlPTFFlSklHVi9lWmx5RzZF?=
 =?utf-8?Q?kA219VJo5bSNkj4t/EI2wu7I62b5bmF+r8XDs=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q2QxS2RTZlhjV3hUOXdjUnlrZ3lJandtMEdLc1B4QVhJZzVHSDNYTG1QOVBO?=
 =?utf-8?B?RWt6S2ZNUG9LcUplRzRNblYyc3Q1MXZUeG0xdDhNY0pmcXN5c2V3bkxBS3BN?=
 =?utf-8?B?RVE5dVI3R3Y2czRBS3B4SXFOOGZwZml5b0xtUDR6ZndOS3F0blBXby9TUEtX?=
 =?utf-8?B?VTQzTlpYV1p1R2hERFArK21EbUJCTkNQNEZhS0FVYzZzZWtPY3NLUWVpMTVj?=
 =?utf-8?B?K1VJbENEd3J4b1ZCWFpkSzJDYW13S3FSdWFlTEN1dzgyR3ZpU25KZEx3OE9M?=
 =?utf-8?B?SDVuTWUrRUEzbXBER2ZUeXdXeVR4UFBGR0tIOGphVFlFam0rSXFZd1dERi9t?=
 =?utf-8?B?U0VHYmg4cFhCM2s1bHFma3F6L3pSekRoUE1QSWJXaVZWS0V1QXdCTzJwcWdZ?=
 =?utf-8?B?SUt0aStNcEZvdnNQMWJIUms2V1VsQWt3aEZHZjUvUkNqa25pb1BlaVV2eU00?=
 =?utf-8?B?ZFJINzcwL3ZmVzQ0b0FDRHJmMmRTejBuMGZrdUlweWRKNXFBQ3ZsS3QvTk93?=
 =?utf-8?B?d1V1UnUwTkJxcW12QWljT0ZOQ0s4TWdsc2J3emYzdytQTFpSM2lVKzZlbWVs?=
 =?utf-8?B?MkVKL3R1Zllaa1ZKS1Y3dGVOMWpPMDdzSlA3em0vTjRKSFhvOGIwWFJSNFF6?=
 =?utf-8?B?WHJBZEdnZXI0cEVmWkhJZ0tZNVk4dmIyRXNqSlJBdFc1SFJsUzdwNXE1aU9F?=
 =?utf-8?B?ZXVWWVhEczRMdHNvampnV2VKd2tteUk1LzJ0MloyY3VIL2M5NXE0S0ZIbVhr?=
 =?utf-8?B?NlVDajdVVnE3NXlwQkFsblUwR0ZyZngrQjgrbERBSExVcWhkVmkwbUdRNnJq?=
 =?utf-8?B?SXRkR2JvTGdIM1grN3M5cnBMWEFLcThiYzlmVmUwOVlYWGJtQWUybFRHZTBB?=
 =?utf-8?B?b1RTWEVaemxLWEluWWIydUx6cHczWWptU1gweVRlRkk5YlppczZPZk9GTllI?=
 =?utf-8?B?VDg3aEJDcitFdlFKSGxaYnQrVWhwSUNQNFRtcHRWay9URnpkS2R5bjFEUnBH?=
 =?utf-8?B?WlFCT1dqRUdEVjg5dXN0cWo2ekhVTk1RQUFmdDBOaUpLYUNaNEh4cXZPTXVE?=
 =?utf-8?B?d1U4QUp5TkFMaUdzWVZ1dUZKVENBaElLSmNjblBUdFJQOGwvbm5HQjF3a25a?=
 =?utf-8?B?QUxLcE9oa2Z4MzAvd2lZZWhtcWZ6eVJQMkRsTVRnclVyS2p1STBEZzE4UjhY?=
 =?utf-8?B?VHZySXRXV3BOWHIrVjE3Z0p0VzFMeFpxUWtQcTBjdENkaExMUjk3QjRZdlQw?=
 =?utf-8?B?U25USGFTRUs3aTU1OFdVVmJqZ29VcERhR2c5WHFXVVA0N2ErRUE3dnhoUVZz?=
 =?utf-8?B?YWt0VU5DM09icW1DSlBhb2lWa0sxUEg2aGxaYUNLbXZIN0xxamwzcWkrUDdV?=
 =?utf-8?B?RVRpc1dvNDVubVhhVGZONThvdTlDMVExbkVTRWpmVExPU1poUEJ1RGRjblVL?=
 =?utf-8?B?bVo4elhQVG05ajM4SUUrVVc5VTFDOWlnZHdkQks3RGV0UWwzYlM1OWdObCtD?=
 =?utf-8?B?M0JXbG5nbVRjTlhCNGQwWFlBam8zTC9iWWZKOFdGcEJMaGh0bngzaFJXYmFz?=
 =?utf-8?B?eVZIUWNuVkZMa09ybTNsRlhZVU1xUCtQZjgreno4cEJsZndaRDR5N2hWeDli?=
 =?utf-8?B?ZnVBZ0p3V0NvUkNRL2V2WnJYQzFWTS8ydnU0bkFDUmVxNUdBdDBjWU0wMk50?=
 =?utf-8?B?dzBLUUgxWVNRZU9EMmc0NlIyaGk5T2JxeHJGSUJUVjFwOWtIUTk5QThiWnhR?=
 =?utf-8?B?bk5jR3Q1Mk9EYmtHRUE3OW9jSEluaURTalBoNmxoTmkvTWpNUVZNY2dvcWFt?=
 =?utf-8?B?d0EzMDNXZWpPbFRjYjdaNUdzRkdxTndOenlCOFIySFlKenNKSGlxeWkweVZT?=
 =?utf-8?B?Yk4xenlNbE5rZ2ROOWZlTXVRdTlqU0ljOU9lYm05SDFxUWk1clhqQ1g3bmJ2?=
 =?utf-8?B?MlZYckFpQUtxV0V2Sk96bzQ2VEZpYkhmc25PYW8rT1JScUQ1alRFSWJYMk9K?=
 =?utf-8?B?RXh2OXhldmhKMExTRm1qeDluSGJUWERuNEtFV3NtVjFIY3BwYUdTbDhRT3V2?=
 =?utf-8?B?Nm5qSXRhWStPNHN6OEU1ZUhidTY2bDgzcklVK1EvK3h5bDc5aUF5RVo0Z0ZK?=
 =?utf-8?B?WHkvcFdrWlowbmp1L0doUlN5OEdYNTVzS1lzSHM1Sjl5aTNCS2dwbUJYc214?=
 =?utf-8?B?SEE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c5e18ec-43ad-4d8c-beda-08ddb58d3aae
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 15:13:53.8298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oxU++sqqVwnuyVSvbcccRzkaww1EAL11xOxGYhbaJrT8C0/18UWanTj9LOWrTkUvXSH9rU4AUz6jgCK6e+td/jxD5e7PPb+16gb4wIoLXAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9341
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 27 Jun 2025 15:13:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17723

Hi Antonin,

On 6/24/25 11:38 AM, Antonin Godard via lists.openembedded.org wrote:
> This variable was recently added with 378db0fdd95f ("fetch2/git: allow
> overriding default unpack directory with a variable").
> 
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>

Minor comment below.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

> ---
>   doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index 477443e228..1069604438 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -310,6 +310,11 @@ overview of their function and contents.
>   
>         For example usage, see :term:`BB_GIT_SHALLOW`.
>   
> +   :term:`BB_GIT_DEFAULT_DESTSUFFIX`
> +      The default destination directory where the Git fetcher unpacks the

We could put a reference there since we have the git fetcher documented 
in BB docs. See 
https://docs.yoctoproject.org/bitbake/bitbake-user-manual/bitbake-user-manual-fetching.html#git-fetcher-git.

Cheers,
Quentin

