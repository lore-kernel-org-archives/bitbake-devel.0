Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7451C54FB3
	for <webhook@archiver.kernel.org>; Mon,  2 Jun 2025 09:06:54 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.9])
 by mx.groups.io with SMTP id smtpd.web10.45202.1748855205639807769
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 02 Jun 2025 02:06:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=k1Wjw+1B;
 spf=pass (domain: cherry.de, ip: 52.101.84.9, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TL9ErIfGOt7xZlSuXxlgDUTHEzcBzwSYUiVj7c3NUpHsMZaexrIOwgIf+RHdL3+4WdwnkuZkbisWtN/RaqfTuNPUUP/SHn96WioGF7ezHgs1/6wIUakMNJzzlYooB9//RxrMB8JeFsWsNgfQE6l5PhTABwujhdGO4geqr/GAMe1rii8iZgewVQBFwnKK+XNd3EQ+yXsDHcWxR+miO1x9nMtuW3iUXGkBWurdVLXxuCz79ZOaBus2LJlj1xyOBf+PJ23TfsEYXYj5PuWIS5okqXL2DnkOAGy2IHw+6Y7i592vz1MNG9l1U0I5jd3HcLTgwvIHAxoeg3/x+D5qhvUBPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVkKdMlZXt5zeqS2Se2+EyJVTRzKKV2mYw2rjDXEefQ=;
 b=HGTaj4H2RAlahRCFB2Y7LoZ/TSjcXBYqV9TFgibbfoceu/zWsm9b7eKQ4szsOTeFjJ9bar6rnhz5m7g1S8R2lYqI4wkTLaD7cu845yHKLq6QQ9Ghvs9kCs5ErJW96gwSK91X43g8Jjrt82A7WBxbJ3YC1jbvyJLWoJ2cJ3CbYuTh1vMnCyAsG8i1DdReoERxGZTQ78zyRpZNnKDG/96v3AzB//+tiJvN+6AlG0tQkLGf0x/v4zdr9mEW58x2k5VBKKUbiQvSvUfaEfC9A/LhrUgK4DUudO3kHwYBFAc1abdK1jFGrAAKkSKn+sYostuFl09D9JIu/GHNp4HPhSg9iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVkKdMlZXt5zeqS2Se2+EyJVTRzKKV2mYw2rjDXEefQ=;
 b=k1Wjw+1Bssg3eb3rtZoyjUJxYILqepR/jvgI/nuYULDlnSRAa04FBI3J+nVxBRIe097nLy5y4U69JyTp9R04w1jge9N8SdVNeXj0K3pUWQhSmbzQrQRq/2u6HefMpgKVTIeXWNvwojIhKU+BOpii6Pq1/ASi8x45hRDw2mLWlXA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA1PR04MB10208.eurprd04.prod.outlook.com (2603:10a6:102:454::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Mon, 2 Jun
 2025 09:06:41 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8769.037; Mon, 2 Jun 2025
 09:06:41 +0000
Message-ID: <1951797c-49e0-418b-9907-fa94647f9b6d@cherry.de>
Date: Mon, 2 Jun 2025 11:06:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] doc: update releases.rst
To: antonin.godard@bootlin.com, bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 docs@lists.yoctoproject.org
References: <20250528-walnascar-update-v1-1-9c6750e87e65@bootlin.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250528-walnascar-update-v1-1-9c6750e87e65@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AU2P273CA0101.AREP273.PROD.OUTLOOK.COM
 (2603:1086:200:6c::6) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA1PR04MB10208:EE_
X-MS-Office365-Filtering-Correlation-Id: fef2a734-9928-41a3-6d92-08dda1b4ca10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RzFzK2pUdkFucVFIcFhYSmVoUXdxcll3YXpKVDlSRkxUNkZhSkk0RGRUODNZ?=
 =?utf-8?B?VjlGY3Y4dFRZSGdnRUFzcHJDb1QxZmFVYjNpOE14MzdIWU1VVnJNclNPbnR3?=
 =?utf-8?B?ZWtCQ2RhNE9SSHZDKy9iZDN3MEdLeTg2cG9NOTQ2dGRNQ0l0MmlPOFE2b2Nn?=
 =?utf-8?B?VmtBR2pMQ2t1bVdXOFB1blRYb0F1aVNvbG9ZeTdNRnkwemRaaXZQTlc2cHRm?=
 =?utf-8?B?RDNqaU1IOUZ0SkdGWjNGTnV1aTNCSUdKTXQ0RmNuQjVUVy82MkNLeVcwWHNk?=
 =?utf-8?B?ZElQdUtrTzQ1RVNWQVpldk5ORld6N281SlBxN2c2NGtNdzZlRHRudi9CWlpZ?=
 =?utf-8?B?ZEFOYXVzY3NDSUo1SEVrNUo5MXNaRFZzVm9hNzJpSmVPNnpBSHhnU0hBbzF2?=
 =?utf-8?B?Zk5VV2k3cWRwVUJsOURyakhTbkRDMXpHVjhDMXh2enI1NktIZitobUliTjVP?=
 =?utf-8?B?S21aY1d3bWVEZVVUSnMvMjhHNXl0ejRRaHlCRzliNlVQYnZkOFZ6UzdYN29u?=
 =?utf-8?B?QjhkSkYxOWV4alpjZnYvb0NneG1GS2JBUmo1akFIMTNHQVZHMHRnUGE2ekVO?=
 =?utf-8?B?aDIydmFiaitxTTNIZ3BYdEhUemt4VTdrVzFyaktpSFhIcm95SFh3Z2RzaG1p?=
 =?utf-8?B?UTJhMG9lOUxhQXgwVVZRTlk3RDRtdFZtTytERnpQYStMMjFVYVNrQjcvekhw?=
 =?utf-8?B?bGRyZEZPYm4rUEhZOGZObmJNams5RkhRQ0xrMXZrRkN1aVlxSG13WTVoaDJ3?=
 =?utf-8?B?cmlWdC9ZWjFrNXFqNWMyR0tYTFFHbDZXd2ZUclJwalFxV3RSOXdGSjVHVU9H?=
 =?utf-8?B?TS9UZis0L21LQTJtZDJvSjJyRS9rNlN2UndzNjdkenB2aWkzNXZzRnFrMGJD?=
 =?utf-8?B?bDRJR1grS0V2N0FLQm10aW1YRTJaQUJ5dFgvZ0NjcFRpajNHcXcrcVdpbjFS?=
 =?utf-8?B?dFBNQXEvRDRwUllkQlM0aENYOGZOOWZPTjl5bWpPZ0d4cERycTZBZjYxamJX?=
 =?utf-8?B?SUJDenlJRURXdFNPNFVNNEQ2ZlVaeFBsenRzSnNaMy9MM0N6THgya01xd2xE?=
 =?utf-8?B?VlIrZkVaVWxDSG80amtQR2JydDVSK3MwRis5Ky8xeU16MFAzY0IzVWg2VUIr?=
 =?utf-8?B?QXp1T3B2TnJ5TmxKRFd1akNLY3FmYzgzWjBaZU9FT2NaejI1YVlnMzlZR2Zl?=
 =?utf-8?B?ajdpTXp0eE5jMG1IVnJOSDFVMzB6MFVFd215UGFza2NldGNKaWtMSy9vT1NQ?=
 =?utf-8?B?WU0rS3RMckVnVEhsZ2Fnek85RFVXaHhEcGRkdlJuaHJ1bGRTQVVvc3N4U3Fj?=
 =?utf-8?B?TUF0VTlDbGlTelRiaTN3V0hLVllyZGYyMHdDWHVpRk1Ob2ZlMUs0eCtiWFkw?=
 =?utf-8?B?akxxblpjV3kwNEp3dWNxRFMwUDMwTjh1ZGdTRVBFUjBuNFB6Lzcyd2xZTnRR?=
 =?utf-8?B?c1VrS05zNzdTNUtZV0ZjMCtZK3pnNzFRaDNrKzF1OWUxMUZWMkZBQmNjQTJh?=
 =?utf-8?B?bkdxM1VabmMvSitXeU9Mc2hrRm14UWlnWHVLMVduMnMxRnQyZHVQenYrUno5?=
 =?utf-8?B?NllsQVRhSk9uNHJEdmhncXNpV2VuVUcvNUVDcHVEUkpoWm0xaVQ5Nmowd2tn?=
 =?utf-8?B?ZkdqM2RNWTg2UWR6VXRKVEZPTUNTMFBId2grbjZtNHF3YXJUTVRUL3MxdDJG?=
 =?utf-8?B?YWFrVDJFdFRBVnc5MC9vU2NWTDIrMGw1OFZXaXNrMzNidkdMbTAvWTE4MTdK?=
 =?utf-8?B?M09JRjB6SS9kQmFGODQwcWUyVWdmaXlZOE5HU0ZRc0NjNStDK3JFMWJ4eE9k?=
 =?utf-8?B?K1V5YTZTNFMzZlBtNUFYZGVRSHVYaEtIMXZ5TUI3Zk0yWTVuYklmbW5wTndi?=
 =?utf-8?B?OXdHdFRzKytBZURLT25hVkdZQUQzNWFuNzhGMDVZN3ZZeVpPdHdXamZRTzh0?=
 =?utf-8?Q?PVUl7+lsjhY=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OGNXTFptL2twNEZwWVN5QnpqejdxVVd6Q3NxK2I2OVBvSUduMlczUTd4SWZZ?=
 =?utf-8?B?cWdKTG4yak1acHNhSWpqanBXWWZGTGU0VzRuMzBYdi9aR0xjQkVtb1B0MWFJ?=
 =?utf-8?B?clBHZXpXVmo4WlFjWVNuRFJJRzR3aVc4cnFWQ0hKSy8vUHdrQnJKQU80Mjgz?=
 =?utf-8?B?RWpuS2VnajNSRzh0UVFxWE1PZWY5a1F4Qjd6ekxNT1NjY2xXajFrQ083ZW5n?=
 =?utf-8?B?L0NNa0tCSHM0ay95YTF4RTBBd1ZiaEdFTklDTlNNTTR4azlCNkZ1OXBCOTNv?=
 =?utf-8?B?WDFBZFl6Y1RPYkJOcXpvZ0VzNythSFM2eFdvaGEyYWpaZFVJM1E5UDFuRDJW?=
 =?utf-8?B?YzlNdzd3QWNTSzZTeXRCMFV6M25wUlErRnVMVXQ5RFBhSkpBVGVtTlR5VzVO?=
 =?utf-8?B?V0tMb2g4TElVZmV2M251QmJleldac2kvMzBiMzJrWVVSdGlCWExLcHNiVkcw?=
 =?utf-8?B?SEF6cUs3eEY4UE9FR1IzbWVjWU1COEU0SFFVeXRla0llR2Q1UFVPUGJvY0JM?=
 =?utf-8?B?M0FxbkppdWl2a1A1TUI4SXhxMjNHM2EzMDNLWHhKOWQ0bElvb0cxYnpYekow?=
 =?utf-8?B?MWVka0psM2IvTmkvY2t2cDB2bGQvVFdJTDFmbUJQL0RpbTQ4SE9yaExkZkhI?=
 =?utf-8?B?RTJQcFgxRjlzbTJCK0RnY0Y4dzNNcWQrRU1FdmxnbVo3UlJGLzJUb1A5QWxt?=
 =?utf-8?B?bDcrMWlSZThlMnk4TUY0UXREa3Y2Yi9hRno0RXpHWmJtRU84WVlGZWtINFh5?=
 =?utf-8?B?UysxTEdVNVY0OXpUZ1lZdUVpMUlWVzIwVWdNdWd1d2tFMUFPRnhtdXRJdzZx?=
 =?utf-8?B?d3pRWm5IOTJMdDk2K3U0Sk9KVGlZVnEyZTFHaVhoNHgrcnBTRnYySmhQSnZv?=
 =?utf-8?B?dVpGVmwycHd5L1FvQjVPb0JJN2d3bGg5Z2FqU0xyamZQRFhjQlFEczE4TVRJ?=
 =?utf-8?B?TVk4N2tqRjJpNGZyN0pxdDRuZGlDeVlFYTJWQlFMa3dsbVZQTEEvOC83c2l5?=
 =?utf-8?B?VXZxaVpNbkxGK1ZiU3lXZXRyUmFidGhEUkpnUXJGWU1LakFJSFcra2dxbzNp?=
 =?utf-8?B?c1N4UFFJZCt6KzFuKzdpWHRhNzhzeHJZQVBFZ2dZaVA5dFZaZldPNTZGVkhn?=
 =?utf-8?B?bUpjZmlPYzJWUHYvZHU0UHZ5Si9GSlRvQlhseWRDdS9RdE9qTXNSdnZ3azB5?=
 =?utf-8?B?c21ydUtISlBQYkY5SWk1MUU2V0xncndiNmgyQ0tOd3J0eXYvQ2Q2d1RwS3h3?=
 =?utf-8?B?UEhJNE13UGw4b3FvZXVXMlkxaWM3ZThRSG42VkZMOU1MVXpXY0hsNFJJN2dW?=
 =?utf-8?B?OHlIdWFYOHVUK0NBcTFZeE9SaEIvcDNTU3NlYnJyVnkvbnBaYjRGN25vSzBR?=
 =?utf-8?B?aFRDclVRQ05tSE9OMHpiN1QydHFRdGcwQ2JCZ2kxaTM4Q3VrNlRJcTF6eGJs?=
 =?utf-8?B?ek1ZUHA2VlJFaDBVcTZXNjdNeGhaWFpXV21maFVUTkJmNVpkUEJxYnZzMW94?=
 =?utf-8?B?UW54YlRuUm5GREEyajZWNDhkb1NNcGtiQ2lYQS9TK0lUOXVITUFIZmRGMThY?=
 =?utf-8?B?ZGkvcVVQRitScDN6TGFBY1dtY0tuTFYycDdPU3gzWnRjclBpK2RGNGxVT1l6?=
 =?utf-8?B?aFhDTlV1cDJmTzJDSUREcHcyNUdvY0JvRC9CTWtZcGI3ZlVMeG8wNjErbUo1?=
 =?utf-8?B?T1JlM0F5MzBDK2I5Q3k4MlUrSlZwb0duZjU0NzNFckczdzgweUVjOWZvOUVu?=
 =?utf-8?B?a0hxVkxhbVhSaWlkbHFibGt0N3FTRVBHaUNZRFhKMlJaREtRZ2pzcFpoOUNH?=
 =?utf-8?B?ZUk5WWdldDZjVVNLUzRhR3A5cm1JZHRXdVU0b2JGdkg5Rm1xTjRRaGhQcmhJ?=
 =?utf-8?B?MDVMTHdudS95cUpOMER6ZDFOaVZUYzhlRndaQ3R1NXN0SU9NbmRBVFU3eE5z?=
 =?utf-8?B?bkhlR0R1WDFjUlhTZWw4OGZkd3VHdUVKYUNzK0RqVFhHQ0NBRk9TYSs4Si9Z?=
 =?utf-8?B?MVFyOXhNT3MxamtrMXpaU1MwNmNZZml0NE5NK3B4WjlWY3VSRnJvZFExajN4?=
 =?utf-8?B?aEgzUGo0U2tsbitWSkZLRFpBdXNSZUM5cG1XSWVkdGwxZjFybURjYU9ianFR?=
 =?utf-8?B?Ky9kN1ZxdVBhdjFxTHBSWm1BU2ZXNUhsRkFZaFJhUm96VzMrU3dybDBhdUs2?=
 =?utf-8?B?aHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: fef2a734-9928-41a3-6d92-08dda1b4ca10
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 09:06:41.5998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fIOIGe/s84Y3ao9mW0x7+35ztGv66sLJm0Zno07CIOvOgYOIMFIaoKkfN4fbI5UIRLtyil49ysuRmis3nA86GWfwEfatKcb/aVWWCza5dR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10208
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 02 Jun 2025 09:06:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17667

Hi Antonin,

On 5/28/25 7:45 PM, Antonin Godard via lists.openembedded.org wrote:
> Add Walnascar as a supported release manual, and move Styhead to the
> outdated release manuals.
> 
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
>   doc/releases.rst | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/doc/releases.rst b/doc/releases.rst
> index 3e8014074..676db66ec 100644
> --- a/doc/releases.rst
> +++ b/doc/releases.rst
> @@ -4,11 +4,11 @@
>   BitBake Supported Release Manuals
>   =================================
>   
> -****************************
> -Release Series 5.1 (styhead)
> -****************************
> +******************************
> +Release Series 5.2 (walnascar)
> +******************************
>   
> -- :yocto_docs:`BitBake 2.10 User Manual </bitbake/2.10/>`
> +- :yocto_docs:`BitBake 2.12 User Manual </bitbake/2.12/>`
>   
>   *******************************
>   Release Series 5.0 (scarthgap)
> @@ -26,6 +26,12 @@ Release Series 4.0 (kirkstone)
>   BitBake Outdated Release Manuals
>   ================================
>   
> +****************************
> +Release Series 5.1 (styhead)
> +****************************
> +
> +- :yocto_docs:`BitBake 2.10 User Manual </bitbake/2.10/>`
> +
>   *******************************
>   Release Series 4.3 (nanbield)
>   *******************************
> 

I believe this is handled by the set_versions.py script in yocto-docs? 
Should we have something similar in bitbake docs as well?

This seems like a decent idea considering that it also handles updating 
switchers.js and that last time we updated it was almost 5 years ago :)

Cheers,
Quentin

