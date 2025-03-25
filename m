Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2D4C36008
	for <webhook@archiver.kernel.org>; Tue, 25 Mar 2025 10:05:11 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.86])
 by mx.groups.io with SMTP id smtpd.web10.62248.1742897099096109667
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Mar 2025 03:04:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=OTKA5ZB0;
 spf=pass (domain: cherry.de, ip: 40.107.20.86, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hIv+Mi1g1Mec6kJ8/WgaIweDP8jM/95GJ4Z0+6teEexvagdv1nYkBNkfe8fITl8bQELP5fJqr4rzFsKD3iEmo/VEc0z746AK1sTmufUrl2258rCB4u3IElYE/aO63CU0sumAZuhaRYNhUiKfmWt8KJblUDigrYtiUVF3Vr3n35GTO+EpMc0yfR4Uxq75WKk+mtlhYDSQ2Xhv8P1dQI0VpxjA/+DAR3VAhrJpiVZpkuhPkcCJ7pIINCwLOg8mqm/pKS9cvBtylrQ/pYeiUD5qczsgmDk9dgisNyEb/cSf6iVziCYLQNhwRqc9gt3flNaWnNDCPadp88yCEI6SxGs0oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzDx9PcEqoebCrftOWlJvK6xUTtPOV8wAOdg3dhNRhI=;
 b=sP5Ya3EkR1RVweH59zTeIL4GmX6DZ6gW8Y2bvrmC67/jBpheNdG5jkQYC1mJ37SR9ZiQhv64PLTG8NV8DjBwNLPli/ImP1a59VMglXS5S9z9dFglhS46pDLz6zDLRr8pGvbt734DKq3Kb4T/rwpK6O5tPA0d6eqmB7sYFggoFayi8eRWAO7/HAkTAuuarg6ovng6Bhm0xt7W433Y9d/lndDu+bIE8ZgmLErm9fS3D8WgRVnSu3arpHK1+rzLUxPLb6QXg+7mAgKSlq+UuxQp93SxITn671VBOu7p8TYogSzkPFsZ6ikcoYGS2LFe+LhOqY4nr+oVPfw+2s3S5q3Nug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzDx9PcEqoebCrftOWlJvK6xUTtPOV8wAOdg3dhNRhI=;
 b=OTKA5ZB0fYG8XbpA4HGbcGvNKyCTv1OG6L2eXePQH/0U9HSqAjp0lGNUiGMus8kQxaKDqDwKyIgdIXhlg//vvt6CeqOAQGcOCIPcsAW4GQzoVxD9tRGigaVCWmHXlFWnniTxv39d5apwnaFrc+ICfq34gSV59mGsmOhAiG1UnSo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM8PR04MB7795.eurprd04.prod.outlook.com (2603:10a6:20b:24f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 10:04:55 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 10:04:55 +0000
Message-ID: <0531cca3-683c-4ec3-853c-59da9492c8b6@cherry.de>
Date: Tue, 25 Mar 2025 11:04:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] doc: Mention `if [[ somecondition ]]` is
 not supported
To: javier.tia@linaro.org, bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, Mikko Rapeli <mikko.rapeli@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20250320003358.977774-1-javier.tia@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250320003358.977774-1-javier.tia@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0208.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::18) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM8PR04MB7795:EE_
X-MS-Office365-Filtering-Correlation-Id: 82143460-631d-401f-c63e-08dd6b847e33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UWFzLzJ5cFBYQktLdGl1N0s5dW5YdWxYWWdTSXpNNERrK2JOYlZnQkM5Tk5N?=
 =?utf-8?B?dnFHU3E0Syt2Q1pSYlZ0TmtKbmNFVFhSMlJMSDJJMS9VSFdTU3FLaFZLem5F?=
 =?utf-8?B?eDdUUzNnL3FsWG01NnM3OWE5MzZUeGlYa2EwWjJPVVdYcTJyajA3SmxNQ2dY?=
 =?utf-8?B?VEdOMlZNZVNVaHV2VlZTSWptRXBTZnI2UWpvbm5uekIxUW9qKzJsWXhQK2VG?=
 =?utf-8?B?ejh6Vmp5b0h1ZUZDblZDTkNHcGhxMGZSZnFYNkFKZTRLZUpQeEV0bmdYS01P?=
 =?utf-8?B?MHdiU3FvTXFnaWtlVDZXWDloQjJJQTBKQW11RHpYSVM4cXNHTTIyTDFyZGtW?=
 =?utf-8?B?ZGphbjhyaVlYYmw5UmlsRkNmbFpsblY2dnlYQ2VmL1ZGaWJCMDRkREYxN1VH?=
 =?utf-8?B?bkFTMmR5dnRITW1ZQnBsSjRBdS8xcXQ0WUt5QlcySytFaFRqVnp5alZpZUNs?=
 =?utf-8?B?MFYzUkNGbzRvQnBJdlFObUs3THFpb1R0UDhHOWd4cmV6dnlyNTFXNzYxRmdB?=
 =?utf-8?B?Rmx5c1did05aTzV1WVBMZFdrUWs0RkVWUXIxLzRFVFdhUGtFeWJ6QXBVNzll?=
 =?utf-8?B?TG8xeWl4ZEgyclEyNkI4Y2Vabm1XQ0NWRy9UVjIrNUQrdGFLeVkxeVFpN2tL?=
 =?utf-8?B?RTJnSTZ1Y0dTNVIzMVRXSFZ6bGorMTQ5OTlMZWg3SHNmNVF3YVVvNHEwOW0w?=
 =?utf-8?B?TlU0MFVjalFkbTVQTkpld3Q3am1UMWVDeER6TTduTjRYc0drVUZkakYzc0pz?=
 =?utf-8?B?RURRR3NLU1E3VG5XYWIrOWJmaE41c0pjQlBsNEt5NWcybkFuYWFTdGlhVDJP?=
 =?utf-8?B?Nlh0VzJ4VUVuMEdrUndxcVdtbUFlRERhT1JGZWRPL2hpdm1oaEFnMDVQK2xE?=
 =?utf-8?B?WGhEaVZzUHI1MWVVcUJVL09SK2d1Uk9VRHJRR0FZenZva2lpdi91RWMrbWFF?=
 =?utf-8?B?QkxQUkVMMUw4b3lEWUR3U2pCdmp4amNrRXpPUE8waXh5ZEVSMjZDRnJYWklK?=
 =?utf-8?B?SSs5eTFoU1A2WlpGUXVOSnFNQmllbWloYzlpRVlvWldVb1MzSGR1WXJ5VWp4?=
 =?utf-8?B?ODBSVXNQQlFiazdST1hxM1dYdno5b3Q5L25pQW5USDAwTCtIV0dYTEs0K1cx?=
 =?utf-8?B?UnZZWU44dm5EVjR2eVV4S01QSGN3U0NwSXoxdUNBeTlPN0xtcEhKSWdSMVlO?=
 =?utf-8?B?K0VucCs1cDhjbEFXQVhjSURwc3c0Z1VYVmxwSS9ISlExQXQ1OFEzcys5Sm5w?=
 =?utf-8?B?NW9QWEN3NFRmZzJQcGJYWXBzcTJkT3RXNGJVQkU2RFFKaDJLbSs5b2NGd1dj?=
 =?utf-8?B?cFlMazhJeC9zU2FUc2tFdWpnK0J1a3lUaEVVa1kyTkVpSE9vZUY1V3hZK0ZM?=
 =?utf-8?B?N0tBbzU3OGVUK2lyQjZGQnZWUGkzdUxwNVV5Y2RzejV0REFEZks1ci9VY2RT?=
 =?utf-8?B?Q2tHVi9pemo2Y3BCMFJrT21pa2RDZjJoSlhaeGQwVnpBWm9lWFJYRWxDcXJS?=
 =?utf-8?B?NTFOTUdXb3l1VkpkN2VaS1YxTU5aUEVJOFN1VU1wc2dNaXd0YXFqbEMxbVgv?=
 =?utf-8?B?aW9HZnF5aDBQVUpBNzhWckljcUdORTAwbmJ6VVZ5WVZpbW1KbFRHVjVpcm1q?=
 =?utf-8?B?azI3TDJzTkZaM1NRMVJtemk2Y0JBUHFJK2l1L0NqK1U4VXhtWmQxWXNZS3Mr?=
 =?utf-8?B?cHNvTjVWTzNmMmhQamtQUlAwbDM0NGR3bjc4YVFDYmRyMzcyMER4L3h5WkYy?=
 =?utf-8?Q?bD2rdNPxR74Aw91d0aSvKPaHDo1AHrIXBbIVQxO?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aHhkWSsxQ1cramxPc09Ib3ZRZEViTjFlc2JSTitGOHJzTjJkM0VvR3V6UUNI?=
 =?utf-8?B?UzhBOU9XaWJrdWpocGdua3ZWZ1RXODkzRU92aDloMkZVV0dkUlNUTGlSeVJq?=
 =?utf-8?B?Q0dBYjA2K1g4WEcreU5UVldlQXpjcmVPRDltNjZNNUUra1V5NXB1eExHVDZZ?=
 =?utf-8?B?V2E4WW9ZRUVTQ1B1WklaQTRpeEhCUVZVa2QzN0pzNzFWQmsza1c3M1dpdkdS?=
 =?utf-8?B?SUFDaEtCakxpc3h5MWVvd0xXUE4vZmt5amMyQmNPZ3BkNE4reVhzaEZpM3B4?=
 =?utf-8?B?NVpDODlOMFF3cWxwQkluZDVLWXBzOHRSUlUyZ1hJY3QvRVhXbVpUQzZ5TVhD?=
 =?utf-8?B?ZEZISytwMzdFVk8xZ1NqVERrZjB2YlNQVmwzNE0zL1NMd3BhcjBCWTkxVnc1?=
 =?utf-8?B?R0hpZFY5WHdHUUwzQmJ3bzV4QmQxYklYYXh1SlRNUDJKb3JRQ2hNWUUyWjAz?=
 =?utf-8?B?aVdBTVR1NUlsMTRVODFtYkl2Vk5HVlM3RzNWTnNwUHltaDdCTGE3NUpqcG9P?=
 =?utf-8?B?ZHRFend5RUR1d3VWV3FCUDZFS09XN1lmbzU4NHRsbGtSNWNKK1lodUViNG9w?=
 =?utf-8?B?aHY3NnU3R0kvTTFqWkFSa05CRStXWkVkOVRtRzFmQUJmZzBET3ZhNmc1RnZI?=
 =?utf-8?B?azBNa2dxUEdpK1dHM2RxODA5TXlrZVJ4Rll3VzNDcUJNRWM1NFpTSjBhbnU2?=
 =?utf-8?B?NEtwdTRVMG8yTThTeXNNazNrU0dUbnNrMHZFK2ZZMXpZd3B6RFVvQjV6dkd3?=
 =?utf-8?B?NlRKMjZIQU9JMEEvZlJTRmdMZGx0MlRUNXRoZ1cvOStlTUcvSWUwVUpob1p6?=
 =?utf-8?B?Y0dxbHMrS3dicWp2eWRoNWEvckdCTVA0cituaG9lNW1tOHpGMmUvWWdqUGZN?=
 =?utf-8?B?c2U1ckU1QW9UaHV4VUwxV2s1bGpMV3dIMG0yZGtiUTdycGVrYmxuS29VYXdY?=
 =?utf-8?B?T25Sa2YrRlFGSUllSCtoZGdLWGYyNTAxVjZuMVYrQm5wd3QwM1ZoaW5xY2ZB?=
 =?utf-8?B?RHRyNFl5UXlkRE1uMWszVzR3aExUd1NOdGxkbFZNYTlPMjJkRldmZjhWUmZD?=
 =?utf-8?B?dW1kZUhXcWgxbFFSR1VXRDRSNFNxcCs0dXNuWWdpWXUrS2dnVVBhaGt4RU45?=
 =?utf-8?B?U0FiUnJvczZEMENVQzdPM3RNT29IaE53QzFKWHg2U0NxcjlSd0hrUnVWZjJ1?=
 =?utf-8?B?bkhRaWxRclRWMFJOT3lmY0JFRXJ2bkY2emdsVzRyUGd3d1hBU3Z3Tm5lK3ZF?=
 =?utf-8?B?UG1UQjNmZ3pTRHR1Qy9PZXZISkpIMllWQy9mME5zWlZiNnV1empaZXphdUFt?=
 =?utf-8?B?NHlWdkkvTkpyeHFTTnFOZHJvL2wxbjZ5Z3BuRGNFL0c2am45L2kvTldkMzlo?=
 =?utf-8?B?NjVCUnpQZndkNTIyRXZSZHRCY0ZZdys4YjU1M2NpeXZ5U3p3WHVFclU1WlNj?=
 =?utf-8?B?ems0Q0g1Y0RnSWx3bnRKeGNJSUIyY1BxWVpqVHE0ZWQzQkF6dnRweTdGbU9w?=
 =?utf-8?B?cy90SjhQOTdCTktzZWpmQkVSYlpmMmtwcjRPWXFaVnJ2aWdJc25pUzRyTzho?=
 =?utf-8?B?cEtpLzEvRmJzRmdQemxUcklXOWl3b2VGVU95YmE4TktxZ0laTDQzM3d5bFM4?=
 =?utf-8?B?ZytCaHZiOS8zbWQyRTIxc3EyVEw5bVVNaEZva0Z6c3lVOUtMOVRXZ1pLd3g0?=
 =?utf-8?B?aGZwcmZsOXdydklDN21ORFUwVGN3S3JwdjgxYkpuNTZvRDkzdFhVYnVkRGNW?=
 =?utf-8?B?MXFDSGlNTm9sZEFPSitQbG1QRVBOQ1BlaFBCWUtUUEVLTXMvVnpIcFU3a21D?=
 =?utf-8?B?N3AxcFNsQWRKNmRPVUt0K3VUUUYvaGVGcXcrM05rN1l0WURqdWtVemJ0eWY3?=
 =?utf-8?B?dVgrd3QvcU43WDdzRFJ6am9vSkxROUpTbkRlQmxIZTFBUmpJM0hFN1hXV05z?=
 =?utf-8?B?bUcyS3FUZW5tZEJINFpLNFYrM3FjdnlxWWZlMGdBb3VZU3NoM3lDKzNiUTNY?=
 =?utf-8?B?Kys2Tk5VR2RaYnJPc2k2aHpoaWs2cjgyMUFOZEtSWVkxSmdQUWZDblNxd1VJ?=
 =?utf-8?B?R293UFhnUzJsZ2hzYVZRRXJtUHI0bE5wQnVZYnd2STZHb3BQSVJPcjgyUGlF?=
 =?utf-8?B?d3puTjJURS9uRUZhSkM1RElsSmIxd25UeWhxT0huaEVXblZ3UXNkSnlGbnpi?=
 =?utf-8?B?cWc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 82143460-631d-401f-c63e-08dd6b847e33
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 10:04:55.4902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YF9HGkjm5Vb31JuC52wLGHQ8FrBYPS8KJA0ZbOHZUHFDXgFqK5weCbrCec7BjUWYYdEUc45CqjW4nvOPPAOqy0dvHF8vH/Y4BUdCXiRgNoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7795
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Mar 2025 10:05:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17484



On 3/20/25 1:33 AM, Javier Tia via lists.openembedded.org wrote:
> I keep forgetting using `if [[ somecondition ]]` is not supported.
> 
> Signed-off-by: Javier Tia <javier.tia@linaro.org>
> ---
>   doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> index 415fbf6d6..5474e154f 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> @@ -1381,6 +1381,10 @@ To make use of this technique, you need the following things in place:
>      To call your modified version of the function as defined in your recipe,
>      call it as ``do_foo``.
>   
> +   .. note::
> +
> +      Conditional expression using ``[[ somecondition ]]`` is not supported.
> +

Do you know what the reason is for that limitation?

The example above this git context is not really implying `[[ 
somecondition ]]` would be valid though.

If I remember correctly, the shell functions are run by /bin/sh 
interpreter, so it depends on which shell you have configured by default 
in your system. Is it possible this is due to you being used to develop 
with bash where this is possible and having your Yocto build run with a 
different shell (e.g. dash, which doesn't seem to support that? c.f. 
https://manned.org/dash.1)?

I think we should recommend people write POSIX-compliant shell functions 
and tasks rather no?

Cheers,
Quentin

