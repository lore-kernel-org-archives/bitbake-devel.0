Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF374D116E2
	for <webhook@archiver.kernel.org>; Thu, 27 Nov 2025 14:52:57 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.30])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20222.1764255171071134847
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Nov 2025 06:52:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=EeapJ1HE;
 spf=pass (domain: cherry.de, ip: 52.101.84.30, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LV6XdPbzuIguKv3ES8y7uBTAwgR261WcYpUGyMDwkPM5U8JY25/bTq/ODBsG349K8NCI/pjLmva+Nqckid2i4f+MUDA022U89U6ydEbfraR8Vtq3zPrZs04Q6fM4SJsncdhoaTuwmKey14erOI/rIusI6JDcetj8ISd9PHIGsLjchzgsUjXZaQcSy06113COcwALJV7Cdf+/QqFH7GdZK/Cy9NDrBnIZnbQWoz3NVf9/ivBmGYCV/cE1WlOpLaqsMRzQZRwPCJn0yaW2AXmCS/SP8W1yatw0tlWAGbUn28ikfHF0p03YpES4AkOidq4str9hVDjwoSCIdZoiL6jaOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CwYsa6qrlzZXs7ceZqmHkwVs682ExgQTCP4S1tQ0u/s=;
 b=Ye1oMhnRY7AuAGtX3zCros1XI8FKlo4vP7mEI8sJZ7TsyOP29firwXF6cn6UTT37olwVdBwKv4kPALfpGBYYO7eKTWkO9ye6MtxAAeFo8UFG5wl4FGgXn1H/9H71zT4ryxEBQiuvgL/jmWYf2hn6wLcmrsPUERTrK64K/HxSniDHU/bfQEQEpn89zx4XO9gadX3DuJM1YoVjXZSsqBBhkJ3v98+yrR3O9q70IN5SkRGULWhMWC99uVYnPKyCY+Sm1i+YO6404cE1xJ49VWHhVSlmvkxjw7C1wlsU6kVJuxho8gGc4Pg87fIMaBFunta4ClROY+0t8ZYGGmPhWJBzvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwYsa6qrlzZXs7ceZqmHkwVs682ExgQTCP4S1tQ0u/s=;
 b=EeapJ1HEegaqE51X9Fq5/JdAC8c3YjfylKozjKjgDCllSnAXM9vhG5VNDXxSPY3zd16mv8indiLHEz2osalcnxOQnfAyp89MoVkUEtqr95ScUwuz2DcvNPDN1fa6QOuUVJrUdiMkCi4LEgKtasj1h0n2B5EoMH8AkW4epdAQiqE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DBBPR04MB7689.eurprd04.prod.outlook.com (2603:10a6:10:206::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Thu, 27 Nov
 2025 14:52:47 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 14:52:46 +0000
Message-ID: <a8474f35-5f75-4910-8dc2-de2ffc06e50f@cherry.de>
Date: Thu, 27 Nov 2025 15:52:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH]
 doc/bitbake-user-manual-ref-variables.rst: update pressure monitoring
 instructions
To: antonin.godard@bootlin.com, bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 docs@lists.yoctoproject.org
References: <20251127-update-bb-pressure-instructions-v1-1-36f69a25d4ef@bootlin.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251127-update-bb-pressure-instructions-v1-1-36f69a25d4ef@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0013.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:1::8)
 To GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DBBPR04MB7689:EE_
X-MS-Office365-Filtering-Correlation-Id: 15d8b80b-ddce-459d-f5bd-08de2dc4a097
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TDN0cWZSNHk3SU9rQ1FQSnFodVp5QnFBL28rVFo1YmlFcGw3SE0wWk1lZ2pN?=
 =?utf-8?B?Q3VVZVZuajdKODVvZlVBSm9pM1NKVE13Y2pLQ0hCQ0s3N2h3K2NRVjhRK2xS?=
 =?utf-8?B?Qkw4NEoyUm5sQ2NnS3JURXV1eHhDMEhqcitGSXYwWDhZOEpHT1J0VzFHTnp4?=
 =?utf-8?B?aWtQdHdTVTJ2S0o1bkF1NmNGYW56cE1ZcytCQWhrY3lNWjZNZXltVGJaalpF?=
 =?utf-8?B?OEVqU2l6ckoybDRZRkdjcmVCNGJhV2M0VEJNZDdhUG9QRForOHdDQkMrd1lU?=
 =?utf-8?B?bm5KV2U0V21lMFp5cnpFZEpnZTZkQnhKSHRDYmR5blNFanRUZUgwUjBrN2Va?=
 =?utf-8?B?OWQ4YlhIKzNFWUJtaEp3QVgyVVEwM1FFcHBXN2g2enN1dm84RmhiR05QS0RC?=
 =?utf-8?B?NlZmWnpIU3pxWCsrZ1FCd1FmOFlua09SRm5ORzlVTnVDZnBoMTlHR0x6dTkw?=
 =?utf-8?B?Q2Nmbm5zNnRhbVdxVGpsaFgxQ1VsWG8yNGZwdmpnUVEvUmRON09Sc0pCV0hz?=
 =?utf-8?B?aHhDMWlUa0lTRWVIWHo5ZE9EZlZUK0FxVE9Od3dPa2pnODNuSEZ0YlZ6N3J6?=
 =?utf-8?B?WmxuTmt2VDZCNmY1VDNkQTY1WmV6dlFsZUFrN1hEUlZ3clh0RVFuclNXMkQ5?=
 =?utf-8?B?S2IwZG9TUkJOOFpoYUI2VDh5M2RRdkI1aGJCcklXbzQzbXFZZHFPQXcvRTZp?=
 =?utf-8?B?aWxXVmY3N1UzVDVTM1JrWG5WRXN4WjVsQitrK2dhcjFSMmZLNnA4a0ZXVzlK?=
 =?utf-8?B?ekEyblRQR0RUbjgxa2htSDBuUnppdVE3MjNEOWNJZTk5Tm5qYWtWa05CZW53?=
 =?utf-8?B?TWl4NWxoZkJubGJ4Rm9PZ2ltbjRzMWErRnZxM09iZGpZVlVzNTMzbVNNMlNq?=
 =?utf-8?B?ZlJrMmp5K2pBQkhsWjZ2UllhdjFMUmsyZWxNV0VYUWtBK083Y1JxZjh1WEEy?=
 =?utf-8?B?ZUtrS3VYb0dYcVp5alVTUm9BVmlMajhUWU9nSVZEbG5KQ09pWURrNmRCUHh4?=
 =?utf-8?B?cnB4NFNESk51cGY2a0VTMWxJSXZkdzJWS3kzQ0NGcmN4NEp0RWVKS1BmNlJO?=
 =?utf-8?B?WlcxK1FBY3pLc2NlUCt1R05EUlQ3eWlGUDNxVEMzZWhnNUk3N0VYWmg2c3pq?=
 =?utf-8?B?WW9vUW5mMGpUcUF1RXFjeXpzWUN4K2tacEcyNVliMU4xMitubXpEODA0TFQ5?=
 =?utf-8?B?UVJ5K1YwRmVON2g5OVV3ait0NU1BYXpSQ0g2eVNDUFM5cmdXOENDeXVwT2hn?=
 =?utf-8?B?dnJ5amhOOTFzMzhzUHhyNEQwbEo4MytMZU1WMDc5RkpIYStIMHRVTUZha09p?=
 =?utf-8?B?RXVZOEZnWEdVWCsxdG9xNlZHRnlQT0tURHU2cUp6a1NrSHBQaWQ1Z2piRGNt?=
 =?utf-8?B?UElpMjF2RU5TYnpSSTRJVDFFanZqR2JLdjg4cGttc0t1amZZN2pnR3BWVnJM?=
 =?utf-8?B?UFk0bG5adXZoTzFpbnJUNTJ6bzJCV1lhSVNGL3RxeUpNSlh3b1BKQ0t5d0oy?=
 =?utf-8?B?WWs5SENTcWZCVmh0LzhyQjVmSVZuc3MrNitCcERWT0V4THA4Mjk0T011SXpv?=
 =?utf-8?B?ZkxuTTlqZ3p5RHpnaDBncWdTR0JYTmFHSmIzZDI3VTkxeHpLbHU2Z2ZSc1pj?=
 =?utf-8?B?dUJCcXE1ODVuYitrVFlRV0lzaWc0cGk3bG55YlB0dFlVbVhXcUlib24zL1VE?=
 =?utf-8?B?MFlFeGFybEFvRnhwd0tmakNPSUcxeGRjSTVRNXVvNTdab05pb0NDSVo3Tkxt?=
 =?utf-8?B?K0N4MFZ4cTBWZ0dWaVNiTStMU0l5OGZxVEpKczJEZTBvZURoNERDV0UrVVRM?=
 =?utf-8?B?U2JDMnMyNG1VMTRYWmJyRWo3Q2d2QThWblRDM1RESDN0eUNmNitBSUZqcDRk?=
 =?utf-8?B?SVBybCsrQzBYOXg4VDNBN1Z3cFlPNHNORHpFVXNwZE9UUWc9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N2tlL0tiTjl3NkZWVW9lNVVUcUJESi9GbmpTZmM3UFptcE1sRHhRa0FYai93?=
 =?utf-8?B?WEMrQytpOFZzZnFNNEU4d3FJd3YwZ3l5SWNBbVF5Ukl1b0dnUDhoQ0l1d3d6?=
 =?utf-8?B?RDgxNGpjQkhWdzVZR0NtaGtOVCtTMWVCdFJPL2o4OVk2d2cxb3Y1K1RZT0V4?=
 =?utf-8?B?S0V5b1RVOFhrME4zc1dZVlpHRjVUZ3BjZHErSVlhS29OQWdnTTNsbTJ0aDJy?=
 =?utf-8?B?SVBQQU5iT2J0THRmTjVsdkZpVWt0M01rWWRhcnNaQTVjYktONmJBUW5qbGNt?=
 =?utf-8?B?cFo5QTFWNjVlTWpqRmNhQm5xS01Vb3hqbmNHR2JONGxRZFlDT2xpVm54bW9M?=
 =?utf-8?B?aGQ2aWdVS29HNEptZEpDYVJENXBLbEg1aW90NGtHWTZmUEErbVFHMjBHay9i?=
 =?utf-8?B?aHZCY3ppMUptZmdNeUFVQk9hUklwQjZmSWdXREVuWHF4cnFwVFFRLzZsZmNm?=
 =?utf-8?B?R3BVbmtwM0puSGRKZDdFU1Y5TG5MQjBuaTEvWHF4ZHBsYTVmV1h2RXBQOTFi?=
 =?utf-8?B?V29Xb2RjbEYxODFmS25tbnMzdXkwWXkzTFkybE9LcXJQc29pdXE3SzR5eXIx?=
 =?utf-8?B?Z1VTOWp0RDhON3lmSy9aRG80ZU1MVDFiUXRhRUFKand1dC9UaXloZVlNWUE5?=
 =?utf-8?B?RlhVVUZxTHZyV2ZLMlVtR0ZhRnhvY2VoWXpSTm5qRWlQYnZ2djJyTmlpTnZh?=
 =?utf-8?B?T0JWRmx5N1dTWXprTXVKSjM5ck05WVV5eVVqV2lROW9aa0w3NlNkeno5MHlt?=
 =?utf-8?B?WmY5emdrSjg2bnVqTlFUbUlUSnFJNGtYT2F2ZmpWUEdCTXk0VDB1dG9YVmhO?=
 =?utf-8?B?SmE1NUxiQWN1cnJEdzRmSS9nZWd6V3lZOGlhZ3p2THAxMUVtQUZ4a3hET2xs?=
 =?utf-8?B?NlZESFNkVkhYMmxYOU5BaG13dmVIdXQ2OE5YNjFUY08yUHBXTUVmbmhYSWtV?=
 =?utf-8?B?cGZrTEpzZjFCSW1RR2FEL1NDUEpFZFpkOU4vZ1hIbDh1L01zL2czTWZObWk3?=
 =?utf-8?B?N1hBU2lCWSt3SkgwVHRneVYray9mRi9QWWdTdWZKRmZoejhQY2FIYVYvaHBY?=
 =?utf-8?B?d3ZteW5CMmZEcDZDc01GWk5DNUlGL0VVOWdocEdZK2JMOXVHeGI0SjVVTXlp?=
 =?utf-8?B?a1dnaDBPa3RZeEwrdzRUUDd3bUErdTAyZTBCRExBYjdMNlViQTRPUmlmcnZ3?=
 =?utf-8?B?NmxUd2lJRVF3ZEJoWVY3YW0yRlhKeE5KR0xVeVZOVjU0cDhyU3IvZ2hqT3JI?=
 =?utf-8?B?Sm9oYTNEZk15Sm53bHNkM2JpcmpjL2xFRmVvdFd2Mi8yTFJvY3FsdDUwUnVQ?=
 =?utf-8?B?dHNEeGxsNHFJMTFMS3oyV0NUa0RrV3Y0cXJTYXZtTkJIWmRkOXZRVnRqQ1ZC?=
 =?utf-8?B?czdBZ01meS94MmlXdzhRWXNoZHkzcThzM1JHdGZheDZ2K212SlNBQTlzVTRP?=
 =?utf-8?B?ZlcrWUozVCszSExCSTBFbUFBS3c1YngxRW5RWGF5TVFXeHBQcEJPd0tvdUZa?=
 =?utf-8?B?M3FNU2JrZDlvcHNtK3N0VUJtZmNERG5uRWx0allKQi9xaEhWbDBjcHlSb1lm?=
 =?utf-8?B?YTgwK1N6MEZQNGlpcjArTlJzV280cUQ2cms2OGxTVDFsT0Q2dEpUYVdINzZq?=
 =?utf-8?B?Rmx0Uk1vYTlxMFhSeHZSNUVLT2d3Vmx2K0t6Z3pXUVpuRDl6aUFoU0w5NVJv?=
 =?utf-8?B?TG5BcE45L0NUeGFoOW9wMHdleWVSUWxlbEZYTGpJZFlNZGtFak5pL20vWmZB?=
 =?utf-8?B?ZmVaV3ltdjBUMjNRakp2cGNaMHhTZFNCZ2VMSmRISk5BT1p0UGZDYWVpcDFV?=
 =?utf-8?B?UEZrQWxnNUE1WVBDSDFIdGMzbE5HSlV1dDRnS05pbXdaMmtFZTlOeGlLd3Nh?=
 =?utf-8?B?czNmN25ZVEhSN1NPS2V4b0gydjMwRzAwZi9US2tRUXZ3d29DZHNSbVhYclN6?=
 =?utf-8?B?N1Y3VllPRW9GM2l4blJzVU1yQndpNHU4RkhVVUlOQmdkVkRVcjk0MnNQdTZx?=
 =?utf-8?B?NGJDSE9OSTZ0S1QxNmFOVkdtZlZJcFlaeUFySmRBTktBSDF0YXFyb0xSRHNJ?=
 =?utf-8?B?WXNGekV2Q0ZjbTJvUmlHaTFGUG8wUnFCVDcvV2JxYmJpWE1EcG9QQ1hRdXEw?=
 =?utf-8?B?cW5DbG1TUWNCTjNpdVRBdHZSWG1RNDhwdTNHNGNOdjRiczJwWklyMkY3WnR5?=
 =?utf-8?B?bnc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 15d8b80b-ddce-459d-f5bd-08de2dc4a097
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 14:52:46.5761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v941GgvdpwW85xMcYyYoFm+duVdgkzGOpKAmprhB1C3OZCE0ss+GGKW2b09wHb+QJcRLSQURGJo3I31NTjnRRpKOlOcrW9fyyL3x7n9xJUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7689
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Nov 2025 14:52:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18503

Hi Antonin,

On 11/27/25 10:42 AM, Antonin Godard via lists.openembedded.org wrote:
> After commit d492bbf0503d ("knotty: Integrate PSI reporting into the
> UI") on BitBake, the pressure information is no longer printed on the
> console by default and has moved to its own log domain.
> 
> Update the BB_PRESSURE_* variable descriptions to show how to follow
> these messages.
> 
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
>   .../bitbake-user-manual-ref-variables.rst          | 48 ++++++++++++++--------
>   1 file changed, 30 insertions(+), 18 deletions(-)
> 
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index 734c7858a2..339143d4ea 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -579,14 +579,18 @@ overview of their function and contents.
>   
>         .. note::
>   
> -         You may see numerous messages printed by BitBake in case the
> -         :term:`BB_PRESSURE_MAX_CPU` is too low::
> +         You can track the pressure information while a build is running with:
>   
> -            Pressure status changed to CPU: True, IO: False, Mem: False (CPU: 1105.9/2.0, IO: 0.0/2.0, Mem: 0.0/2.0) - using 1/64 bitbake threads
> +         .. code-block:: shell

This is not shell. It's a shell command and its output, so I would 
suggest to use a different lexer here: console. c.f. 
https://pygments.org/docs/lexers/#pygments.lexers.shell.BashSessionLexer

Otherwise looks good to me.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

