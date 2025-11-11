Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93952CCFA1A
	for <webhook@archiver.kernel.org>; Tue, 11 Nov 2025 15:43:29 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.58])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.20670.1762875792318869792
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Nov 2025 07:43:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=AoKyXgY1;
 spf=pass (domain: cherry.de, ip: 40.107.159.58, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vhLpAJsPUy9zZMyav+HIT9vuRX1zR84Y1kNi6rg55KY7vPnijCbJnTVg5Y3x468VipeKyQDg/Yby4BkXhyqsTeysdm3Tfd0ipAO3ZtR4TYVvnyTql1QppYJf0oOC/GpG95E4yFbdWysRIQBdxxQmxvp7bZEY7kATYZvt4TQiLJyzjAEKz1SNbTxkmrcOUdUL6hbVQxtuDO8Xc3myR3ZH0b5azeOx4EVX/7kgGU7zRO8irJTGnntDfHVoTHIg6YYnOaZvw/bQtlLAjbXMCFK+3hIz2NdvW0AV7CFaaGl9uBeZGp5m6wrn0tZ9m9cyMRz68BDDpFYolzeSQEJdl6iZYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMLEtdWof+I0+d1pKvZ7hHvtJc08Y6cbsirTjJxYG1c=;
 b=V+q0x+NqOd2r8Tis6qStwClZfMe5DQSTAKhvWqszF9tiTqBxXabg7B5Sb9dDkcW5IbUNVFxPTlqd7HpBRsHPfVrmiw2SjZ0keeEfTZ42owvfDzFwM4aBmR6lYqCU7xTuB0AiXzEstsnN0zLRz9QZGt3/73RWL4Plqe7mStCNcngN75RsHFkegFTnxbNuAgZHeCUQgaeDAryKPppZUQbh9oSeMczoaLOm9AFwoFHhWr02EqsNH23g6pagclNwwl88aLWuFQrFS6Iqay2aSI+CmsfpULAxlmUEzUJpIxCNwoMN5VCq+yXg1PnQlQ9RqKkv6KloVnnfMAkobnD5Tf4V1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMLEtdWof+I0+d1pKvZ7hHvtJc08Y6cbsirTjJxYG1c=;
 b=AoKyXgY1M89Pf3CoyKtxv5OMr1OYnmOHuWkZlL9a7CAwlAvHqhS3TTUANtj0a14rclONT5s+IIprbZBRg2pxAllh/1BH+FiC1MOAZCoyM3gEtWeEpDW3OImfE5/uSaS+jU9SkRod3riM1x6wRkn95Fi1TJn+b4xHrEB44vIxIgU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB9PR04MB9674.eurprd04.prod.outlook.com (2603:10a6:10:306::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 15:43:06 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9298.012; Tue, 11 Nov 2025
 15:43:05 +0000
Message-ID: <2d17465a-8419-4e0f-801d-36da261edba8@cherry.de>
Date: Tue, 11 Nov 2025 16:43:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] doc: bitbake-user-manual-ref-variables:
 document BB_GIT_SHALLOW_EXTRA_REFS
To: m.schwan@phytec.de, bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org
References: <20251105080516.647480-1-m.schwan@phytec.de>
 <20251105080516.647480-2-m.schwan@phytec.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251105080516.647480-2-m.schwan@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0044.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::20) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB9PR04MB9674:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a570315-90fb-4b37-9e15-08de21390180
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Q3YyM2tYTUMyck5jZjc1SFZWamJoMFpRRmMwb1FuTkVWSTVHZThsM3hNbm5R?=
 =?utf-8?B?MHpMb0w5QVJ4MzZ6d0lGenl6MGpvU1hzMW95anVHTWttTEZOMk9NRkJTb28r?=
 =?utf-8?B?anZIVzZZY0NMNUZjeXhPVnJoZ20wc1NBM1hvRFdUTEJ5RUtuVy9va3BhTHZT?=
 =?utf-8?B?TkttMkQrQ25CT0ZjVlhac0d4UHNWQXJ1N2VMb3RsbHRpREEwRDVWNGs4dnBI?=
 =?utf-8?B?cE9pUkpmMnNQQlFhMGVURHNyUUZ0bDFJd09HWHgvYTN0NE56bk1pYzFFeVdq?=
 =?utf-8?B?YUdxNG1XaEJmdUxxUExCVnRmVVVmejg4MkducHZPdFRsZ1FqOXhtZHFoWUIr?=
 =?utf-8?B?K25weVF5Zytnck4vVTNwMlVNeTFHNERUdGhvN2ZMUE1rYWk5M1FRNWNZQU94?=
 =?utf-8?B?TmY1dWhNM08wOUFOM3FoZ1l4MU9TZTNPWDRIRERkdlBQRDlzWFlOSDNKNzUw?=
 =?utf-8?B?SndZWm9Cb2QyUkpzbGljTS9DN1JXckI5c3gwVEVlSENsZ29yN0loZ2hYRE9X?=
 =?utf-8?B?YS9GdWpiZXF4bG1DU0lUYmhRdWlVZWY3VWxibG94bitCMXh1TnJwK1d3cXdN?=
 =?utf-8?B?U1FhcEhCdHBUejNKZUJMQjZjVm9hVnFNS1N4TnV2OTdra3IyUFdnWEZnaUIv?=
 =?utf-8?B?aFg1aVByU2xjT1EvcGo2ZEg2dlg2N0hpeU43aW4zUWF6cGd3dlI2RVFPWVZH?=
 =?utf-8?B?Qjl6SHhJb1JiMUdzdFQ4cmNidzFoQksxblowVHp4cC8xbXBLdGhCWjJCdXFj?=
 =?utf-8?B?U1l5RmcybGw3cmdTWUpIOE1OR0xNUGhzNzlURnh0Q1AzU2hGbkZJUVhZQmtY?=
 =?utf-8?B?L281a3Q4RkxBbzlBWmZ4ZHVRRlZqLzJrSXU4RDAvQlpkYWdVUXZjUmQ0RnFL?=
 =?utf-8?B?eElEUjNzMzNrZi9zMDdNVVhuQU1YRVJvdjhzWFFGRlEzb2VPRExITU95SDJt?=
 =?utf-8?B?eTFvMHRaR0NsVUVrM2VuZ2ZpS2R0QUg0NzhzQWxuaEltdzh6T3BMTjVSUDg4?=
 =?utf-8?B?aUI1dmwyd3U5Y3ljTUYrZWV3WUt0ME85L3B3WFE5SFEyakZodDltK0RBTzFV?=
 =?utf-8?B?dFd6NCtGRGx4V1FZKzVFMWxhOHlGVVlZT3doV20yRC9aZmtteUdNTnQ5Y0xN?=
 =?utf-8?B?M3QxMSs5ZEcxQXZvWVNEeWFWYVFxMnpRamtDU21FRHZmUDN5aDJXblJYZUVw?=
 =?utf-8?B?NWFqMjgyWG1OTW93SEdqNDA5aXBzY2dVSmprZlJaR3lESURhbGIxNUt3Q1U3?=
 =?utf-8?B?TzVxVDhwWUV3bWhtUXZFUjhzYno5NnB4K3FlT0QrQXI2NE1sNG9uMlJoWXd1?=
 =?utf-8?B?OUU4RjNRRitKUjJmOXVndDJPOEVkVzh3cURkV25adUhhaUJRN1ExRkVwb1pI?=
 =?utf-8?B?eXVuRVcyTDZxNW9FRUJWN0xpMFNoN3lFT0FrZ1oraHNyQ2txMlNiQnpJbGIy?=
 =?utf-8?B?ZEVIQXNDOXozVzFjOHFQb2Y2TWVvRWdDbUN1N1g2TDJsWHVnekx3THd5ZERs?=
 =?utf-8?B?MitnNnhVcndtV1psb2h0ZDVUU2R3WkFLY2FqektiRy9rLzBjZnhLNndGOS9t?=
 =?utf-8?B?U1hNWWhrR0RVaW9ZdEx5VEpvWit1M1dYMVZYTHJFNGgwQUozdExBeS8xQnNI?=
 =?utf-8?B?REYrdG5VbkJqZTBPVkN3dElWaU5Bc1JXc1NWRTF3MHhHY3ppcmlJQWpkaGJn?=
 =?utf-8?B?WHZ1RjBzQmR2Nm5EVW5EcHRXbjBWNU5MK0VYbDA2NW9DbFpwdmsvVkw5M0lJ?=
 =?utf-8?B?WmVRWE1ST21Nck5TV1FMd3hNSDkycWZkZVpHam9QUlIwQWtWdWdXY1FtdTV0?=
 =?utf-8?B?NXc1TW5qc1ZXZTdIQXpabk9ITUgyODc0clg3aVU3ZGFTY1RadEZPMk0rcGFq?=
 =?utf-8?B?R2lpSXRDb1ZFN09ZOUFMNUFNZTAwaHNLS1Vha0Ivc2VYRWRPeWpuUVJLTVlt?=
 =?utf-8?Q?KiGOJjMWJVyc8H1O3/4bFbYlFoSi1gal?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZGlXTGF1MkRGVWRkTC9Qc3N5RTV5azZoTFZrbkJLR0RuVUh6Nm5PZDQwamVx?=
 =?utf-8?B?MkN5Nkl5cUpoU0xwdFZybUdnMDhCcThoNjVBdGJZbk1CYjF1N1hwYy9lR0xC?=
 =?utf-8?B?SllkUW1xV0ZoL3RtLy9Bc2UyWTlHbXBQd2RIZmt6NmRZSkxPMDQ4S0JleGx6?=
 =?utf-8?B?ZkNqazVnRlFzaGxuZjRqN3hPQ1h1VXl0bkxNVDBXMUFKWFRvWjdZVCtTMElo?=
 =?utf-8?B?RlpoaFA4SDZXd3J3YTNaNnJGaVZmNTc4QTZxZWJ4QW1aTHlsWEN6SGNwZ0Rx?=
 =?utf-8?B?UGJaVndLVXh4NDdMUlF3dWowMWR2TXpSRmlqcURrREZHa3pFeFV3RDFLb1k4?=
 =?utf-8?B?UFk4ejhXanVrY1kyM1NTOERESjBDUWp4MFZROFFMQWlocEIzNExtMG9tazhF?=
 =?utf-8?B?a3R1WTFHenU2V1VYa1BDSkd4MzdwZW9wb0pGVkl2VmdVZEx5MUJXV0RxdHhl?=
 =?utf-8?B?U2hSOG5sMWMrRUkzODZVREFLZ1Jha3ArZHJZTWNTOU4ycVNnOWpCSEZLTFR1?=
 =?utf-8?B?MGlJOHpOMTNBb2VsVHQ1OUNGbFNkZ0FCZUxmb0Z0NUpnNEhtK1phcUFkWnlN?=
 =?utf-8?B?aGlsSWFEQXlmRGdmU0NFTU5hQk5YOXlGbDNiVkpaL0FIZ3h3WDNuTkxpUkEy?=
 =?utf-8?B?cUd0dmpydVVPUk80R0tycWoyRUtPaEx0YjJxYlo2eXZhVjF2MHRSMGhQTEg5?=
 =?utf-8?B?TU9ZYmxNNjEzZytCOCtNaXBuckxwSElJWU4xdGVQYUhCL3lwWTlOaVFhaVdY?=
 =?utf-8?B?TUVTTEF5WVBQZFVrVkJXcHFwa096TkJJblFYS2ZGeWNCbXpUblpjTkp3Q2Yy?=
 =?utf-8?B?bStqd2t5MkhoVlY2NGRoTnpBVGc5aDdkV3FQVElqTDRDbUE3WVljbldQWDMz?=
 =?utf-8?B?OXlqdzdSZzc3cEhScTJQWVFEdjNnVkxXNFQ5UnBzRjZqUTVZcisrUFo5YVRw?=
 =?utf-8?B?K3RoZTFvaUFLQ2g3TWZuMkpXOEpCakZsQzZYeEZNZmR5Mk1LeW9WZm1TNHVZ?=
 =?utf-8?B?ZS8zNkp3eUxmb1hnVWh4bkRPaDFpQUdoa1JkSWNocHFqNnppNUR1cnlRYkkr?=
 =?utf-8?B?K1Rpd0F5S1FDNXp6bXAyeUNaeTBOUFZmcGJpNzVNdlBsQUdGck5nK0Rhak1H?=
 =?utf-8?B?MXdmWkFiSTA1d01kR0xIQ0M2RHhCT2x5MHNPTXRDUUFUUlcyRFdyeTJnb2lC?=
 =?utf-8?B?MFhaMGRNSksyYkVLQ3prK3pPejM4Q2ZvOTFiYlh0WElNaklmeENKMy9vUFg5?=
 =?utf-8?B?QTdQZXlMejd2bWlxM2lnZkxJOTZlemdsbFA2cVVyM2w5MzdyMk1NN1BKVnpU?=
 =?utf-8?B?bGFlRHB0bHVsN3JCMU1nUWd2VzNoM0pHWktyYWxwY3AzeExxZzM3a2JBWlVj?=
 =?utf-8?B?U0tRRkxIYytxazZna05DbzFOMFBuRW10QXlsSTVEQ1l0MXVpNGlrNGRYRHlj?=
 =?utf-8?B?SkU0Q1ZnK0NCOXZZdmt4TVREM1BKb3NNcUhESzFGQys1Mjl4WjRkZVdjZGla?=
 =?utf-8?B?NFhqOFBCN3FGRDYwcFkwb3ZTeHRVTUJ3UW8xZUZaRXM3cU5vaE9iT3RSRDZM?=
 =?utf-8?B?eEgrc2RlN2d0dkVaeC93b01FZnlQbDR1cUJkQm5ZdVNjS1BDbVJRK0cwV1Ns?=
 =?utf-8?B?bWdwbHhPVkhrdDh4T3NsMTM5a1p3ZnY2NDdsRThPNUMxYVZUaitmUGpWb3dj?=
 =?utf-8?B?aWcrazRhaEFteVRVdGRCT2tRL0FYSjlNZHp3SDN0ZmVyZEVHRENoNG1aODFU?=
 =?utf-8?B?NGZNL2IwK0FYUXR6ZE1vOVE4bFFaQUZGUHV3RStTdG9EMzZGaWx0V3RtblUr?=
 =?utf-8?B?QW95NFJEYmNvQzQ5eVltYTAxdllER0lYWndyODREUU9SOEwyNWxVT2tXVE9o?=
 =?utf-8?B?WWZITjdTM0JVM1ZlZVNDR1hjaXE2djVBQjhwaldPVUpJWWFmK1JlbmhyQUpV?=
 =?utf-8?B?U2E4ajNodndWbUd4a1ZnUlRtOS9ObkN6eUtGWjJUWGRMYTFmN1lvZS9rb2pJ?=
 =?utf-8?B?QjBLTDRXZVNVdGhyTTlHNVgrZThDNzgxeWRuUExWN3FWVDRyTkpxbkgvUVdo?=
 =?utf-8?B?WDNHNzFNcnRXY1FMZlRUUTM2b2xneHZWeElzc1I0WWVzc2lGcVI2SitlTEdx?=
 =?utf-8?B?WTVKYTJBRFZ1cVEzQ1hpcFYxTEU5RlVyWGJrZnZleUhNOHBKWENQRFk0K2Rs?=
 =?utf-8?B?MEE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a570315-90fb-4b37-9e15-08de21390180
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 15:43:05.6914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SSnVikEaMVCJ5r8Zsfc3Xso5faZjv/SOHjzpGygk9haDE5PJ1HYQlPDXegZt6ALnH/E5mhBayQ8hmoPaWvOPnOM5sdkniqko6dOAn1lffHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9674
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Nov 2025 15:43:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18325

Hi Martin,

On 11/5/25 9:05 AM, Martin Schwan via lists.openembedded.org wrote:
> [You don't often get email from m.schwan=phytec.de@lists.openembedded.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Describe BB_GIT_SHALLOW_EXTRA_REFS which allows keeping additional refs
> for shallow clones.
> 

Available since sumo (bitbake 1.36.0), commit 1771934cd9f8 ("fetch/git: 
add support for keeping extra refs for shallow").

It'd be nice to provide this kind of info in the future, helps deciding 
if and for which branches to backport this.

> Signed-off-by: Martin Schwan <m.schwan@phytec.de>
> ---
>   .../bitbake-user-manual-ref-variables.rst       | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index 734c7858a..309477071 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -399,6 +399,23 @@ overview of their function and contents.
> 
>         For example usage, see :term:`BB_GIT_SHALLOW`.
> 
> +   :term:`BB_GIT_SHALLOW_EXTRA_REFS`
> +      With :term:`BB_GIT_SHALLOW` enabled, by default, all unused refs (branches
> +      and tags) are removed from the repository, as shallow processing scales
> +      with the number of refs it has to process.
> +
> +      :term:`BB_GIT_SHALLOW_EXTRA_REFS` allows to explicitly specify additional
> +      refs to keep. This is particularly useful for recipes with custom checkout
> +      processes, or whose Git-based versioning requires a tag be available (i.e.

Gut feeling says it should be "with a custom checkout process". I'm not 
a native speaker so eh.

> +      for ``git describe --tags``). The :term:`BB_GIT_SHALLOW_EXTRA_REFS`
> +      variable is a space-separated list of refs, fully specified, and supports
> +      wildcards.
> +
> +      Example usage::
> +
> +         BB_GIT_SHALLOW_EXTRA_REFS = "refs/tags/v1.0"
> +         BB_GIT_SHALLOW_EXTRA_REFS += "refs/heads/*"
> +

I've read the code and it seems that if one specifies ;tag=X in SRC_URI 
for a source fetched by the git fetcher, that will make it make it to 
the list of refs that are kept (though not via the variable!). Something 
similar is applicable to the gitannex fetcher with git-annex and 
synced/* refs. I'm wondering if this is something we should document or 
not? @Antonin?

Looks good to me in any case, so:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

