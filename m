Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5AFC87FD2
	for <webhook@archiver.kernel.org>; Fri,  1 Aug 2025 10:49:37 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.44])
 by mx.groups.io with SMTP id smtpd.web10.84806.1754045375196379389
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 01 Aug 2025 03:49:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=C8W1zuum;
 spf=pass (domain: cherry.de, ip: 40.107.162.44, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RqWNPH8yNjXiSdP3UPKKXWDMiuv7hA2UChL+ynFOzta3wrjV3PidoeOuOpmRxZ05pzMwtWhoVxhcn7Zm9aPSxXRYWE/RF0TGqD3iIp/UN4dkXg9kalzuW/Tz7DT+LjoWEa1reEohbNwNeO9hH6PJp3EH4yMXuv8XYmivsObsqx9CeEYMg9HPJ3cJ3JthUajQOTZY6bTTNlk4lP4IZbWQbUfWh04DO0wu8+K+VcS/xG/hnw3ICwAYccKL/qnBFb8SF+5lAqzj8yseuWJIJm4pfumYn2b9MevHds/DkWOGwH6xX8gmlXaBQUwiRDSl8FsUld9x+EbC0IGMgH0frnYvKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3dykm42jkOdhlQgB903g61V05n70xxCxwLonIpQT1I=;
 b=gUnmmGjkr3pxgQb7E0kjDPdri8cB0YCPsBFwlawVVIFr6eYIvy3pKWJ9dfyKz3j3Ay6OsIkWqdJR9NdFKBs3Uj7A8OTfaVPscnCPbrxqTDajRiiYHIJVpGOyqPhNVZyLg+SOPHX3P4oKNa22WinZKbBIH2WklGAPNB0s0KkX8CyKAVs8mdSCikpQXNVQAmFiNyWSrD9D4a3Fm3qf3pA1ltVGSX7PM0RVRcCgjT1bYXjXfbXJY+ECiMaK2GLj/J5/JcuOrQGVoAk2v9cov6T9M2hrU/6irk6/FRHQojhixzUTdC0Rn9k9ZM8YThIZkZarGvTj0P8D5QolUvBByRu/Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3dykm42jkOdhlQgB903g61V05n70xxCxwLonIpQT1I=;
 b=C8W1zuumJn2sjB53g/R5hOHs+ryVIZH1unZQUE/mMgDXCWZXrpj6CkDu0B1Xc69XMKfa9XGYHWr+TsORmr1CmsAbfwk8rs/hcCubC6y3ENGVQNVwkm33frZIdRIBOkwUAzzj+ryq2E3I0tm4Ief26n84kPuP9mO3Ku5cEyeD5eE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU0PR04MB9495.eurprd04.prod.outlook.com (2603:10a6:10:32f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Fri, 1 Aug
 2025 10:49:33 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8989.015; Fri, 1 Aug 2025
 10:49:33 +0000
Message-ID: <14df4315-b01d-4b8f-9cf4-c112f7097cd8@cherry.de>
Date: Fri, 1 Aug 2025 12:49:30 +0200
User-Agent: Mozilla Thunderbird
From: Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [docs] [PATCH] doc/bitbake-user-manual-ref-variables: document
 BB_DEFER_BBCLASSES
To: antonin.godard@bootlin.com, bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 docs@lists.yoctoproject.org
References: <20250724-bb-defer-bbclasses-v1-1-70f1826d4b83@bootlin.com>
Content-Language: en-US
In-Reply-To: <20250724-bb-defer-bbclasses-v1-1-70f1826d4b83@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0113.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34c::19) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU0PR04MB9495:EE_
X-MS-Office365-Filtering-Correlation-Id: 6091b2b6-55ba-404d-2021-08ddd0e91960
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RHN2Z2FSN1gveUt0ZzdjT0sxZElPZ3lhbHhwNi9RYlYvandkMURsK2R1WmMz?=
 =?utf-8?B?SVpaM0pCRy9BTURmODZZNHRuQ1BHME5sYXQ1TUQxWThmS0hYWGZwTXJMenpv?=
 =?utf-8?B?MnFZcnFRaHJNRDlBZnNEajNEdnBadnkwVjE5SHJxdk42a1l5NEpEeXhkNlo0?=
 =?utf-8?B?ZlgwZHhpWEhBMTdPSHlqNkxlWW9wT3BlblNTMWt1eTB4WDFuVUlJYjJ0V3dK?=
 =?utf-8?B?c1lzYjgwR2Fpa1BOaG1ZV3RMb3dOVFBldzBZUTlBampIbVl4ZGgxV0ZPbXQ5?=
 =?utf-8?B?eXpSbzRjejBmbDJaMndyUXRtM2llZTc4eURIdzljTlhmaG9GRFUvd0x2V1Vo?=
 =?utf-8?B?MVBqSTZ6M0dOWWhZSXlLVjRoZ1hUS2E1UHFacXVnekZaTlhZZ0ZhcDZRK2cx?=
 =?utf-8?B?OHp6b2xCTFE4RWlXOWovaUIyVEw4NFpoOUwzQmdubHQ4MW50a2wzYnVIMVFn?=
 =?utf-8?B?Tktwd0hiUXhIU000dlVVSXBnQlpVQjFYR0NDcmFPUG1raDA3eGVFSEVtdnVT?=
 =?utf-8?B?bXFmREJJUWFSdnM3cHFISUlrV1dtOXlWZ0tRRTlXeTc5TEl6d0RpY1RpTjZS?=
 =?utf-8?B?WXNSK2JFNnN4L1EvZUhvTWI4K2pTdldhZC9sSEJuZzlLTTl0eHhGaWtUVkkx?=
 =?utf-8?B?b2dNaXVWamFTdHY3WDVidFFzakF1dHBWT3U2WDViV01ZaEYxOUNZdGpjV1g4?=
 =?utf-8?B?K2lUckE5TGFqWGRxT2hING1WYVhUakF1dU1NWXdvNnhrRklESkw1RXdITFBZ?=
 =?utf-8?B?eUtMVVN5SVJKVEF3Z0c2YkNTYitXbWNrVGtML2FEMnRuaTFoRUlnUWkxby94?=
 =?utf-8?B?MThDcEpFTGdnMHJCTTdyOFUyUzFnZDByYkJyYmt1d2htWGVpTTdnYXBDN2p5?=
 =?utf-8?B?bmJNaTFjOEdvOC80TWJLS1lDN01NbnovUWh1VDQzeHdqNE95dUg5dEFLb2JY?=
 =?utf-8?B?YzY5VEdsUndjbTVYL3V4VUNqSFRHR1VPclFIREJLNEl3MzFCZ1YwRnpoZkYv?=
 =?utf-8?B?MU5uUjMrSkhaQ2xmMmV4bmx4eTNvUEp2YTB2cVBNQUl3emNvbnRORnZ0bTFy?=
 =?utf-8?B?VWVmUGkybEJIYTg1Sys2V3dsUG1aYUNUUGwzOTZhRFJNczBjNU9BTVBrNW1F?=
 =?utf-8?B?Z2JMU3ZQbS95eExXelJra3NpbkNOdkZMOFpWZHhOYkdTVnoycXlSODFSWXdR?=
 =?utf-8?B?U0dvY1RpOExrOGRiZFh6NHU4NXAvTUZuWUYzcDd6ZmtSVitTNzQybW1OYTEr?=
 =?utf-8?B?ZjF6Q2lLeHpna1JRYTJoZlduaWpmYlIxYzRIQ2lvQ2VpNjNEbHM0VG9zZHZX?=
 =?utf-8?B?bS9WdGZ3dlNUdU45WUxWamtpK3pzMkYyRExpbnU3TENhZEZFQ3JMMm9mVXlF?=
 =?utf-8?B?M3pGRFliS1FhS0IrUWtmZVZIOE5KVm9xVml5c0dQenNPeU9xMGlQZ2lXWVV3?=
 =?utf-8?B?aWFsQ3dVSnhiMmdnMUg5UzBJNU1JUmRDWDMzR29LNGdBTXpwanZWZzhLSzgy?=
 =?utf-8?B?WE0zZUJ5OHE1eTJEdVhibU5kMlB0NkxGb0NiZ1hzd29NaHpVdStWRS90K3ZL?=
 =?utf-8?B?RncrTDlSVXBwZy8zenJUMDNYMm55QUlBZDMvSUNtaEU3cFhQV2ozUThKWlNh?=
 =?utf-8?B?aUJpZ1hSTTQyang5bUtKbkkra29TRis5cUU1dGJ6dmR6NE51ckhOZVVEcFJS?=
 =?utf-8?B?UDJvdjhrUi9GNjdLOFFtQitsRWw5b29ISUlVTHR3TkhXelk2ZGtaZVdkVFU0?=
 =?utf-8?B?cXNCVnIxYW1temJUdlIveVdFVDNhdyszcVZrNUJPUFAxTndhYVBvSVcrZThO?=
 =?utf-8?B?UDNPU1pOcnlCOWNCaklDZ1I5RFkrVTV2YmQ5OWQwSjJHRzhpcVo5alpUQmoy?=
 =?utf-8?B?b3hILzR1OHFSSnk2enJRQzJHRTRXMkkvQ0xoOUQzOHcyR3JkQjBqTHl1NDRm?=
 =?utf-8?Q?fu0/JtWveg8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NE9EYWdWckg2VktlYkJQdnZFcGdQa2grQXI4U2xFbFN0dG9oLzYvRWFITVJE?=
 =?utf-8?B?Sks4TWoyd1ZGcU9Bc1k1akM0WGNadHpWZTVTeDc0NGVjcktqQXdiWVV2SWdh?=
 =?utf-8?B?NkhNNVBiMVUybUFkVEIrSWRUUE5Damc0WHppbUo4SlhQbDBRVkJ0VDVzamFz?=
 =?utf-8?B?Mml1YlN6ZDZFZ1BHZWpVcHdNbFBRb1ZxcWV0R0l0cU5sYWllL3pKTnRmN3po?=
 =?utf-8?B?TVRGc1V6Q0dXdWFXcjZWRjYxQkdCU0orV1I1VThBT1dJS3pPWm9EajB5MWpE?=
 =?utf-8?B?Q3hKTzJQbm1hQzdVOWxVdEtCRk5KYlhndEhzYVhpMWFvbG5nUnRkTWNNNWR3?=
 =?utf-8?B?NTR4Tm8rYTBmcWN0SE50OHZFY29PL1RWYWVyUExXRzAyYWVuQUJMTXJGZHVP?=
 =?utf-8?B?M3RSSit5bHZPWkxLMko4TGxjQ1JXT29yQ1hzNDRKd0U5TExaNnBRQjBvMVVq?=
 =?utf-8?B?UE5wQmNzY2RaeEhVMEJFTElUREY5VUF5SVRrUWlWdG81cHVEWGtWak8rS0dx?=
 =?utf-8?B?bTBObGFKMm1UdzhQNVMxY3N3WStNMWVqemRHaUdyZ0Ntd0l6YkxScGZBME9q?=
 =?utf-8?B?RCtEZ1d3MEpoTFdLR0d6ZldtQ3cxZUlEM3V1eHRLQnUzWGhPZ2VFaHZXZXJN?=
 =?utf-8?B?dUZWS3ZvWXVNMFNnYkk0dDNnRmZSN1pualFOTGN4bWVHRTVrdGxZeEsvbCts?=
 =?utf-8?B?cERueXVEOGVUUFNrdXRmeUo3TUlMWElzcy9PQzNtQnFYN0Q2RG1lbVViM0ts?=
 =?utf-8?B?RnVueXZzWHhvM21BNWNIOHY3aTlSWG1OV0JNY1JQRFNqbE1Edmk5eERBampp?=
 =?utf-8?B?d2xwSjViVjNSMnF6aXUzbXo0YkhjUEJ5MkpIckUwVnBnWTZlT1dNZmxwejU3?=
 =?utf-8?B?ancvZHB4K3FKS1FXYW1aT3JpakhFWUU0U0FHUkltZ254ZmtFc2VvSFYyRnJS?=
 =?utf-8?B?WVM5T05CeUtibVhpRjJrVHFxZ05ZWHlEV1FJTWtDbkdXM2t5YXFLNm5wOTJw?=
 =?utf-8?B?ZHl0RDQ0UzNDdkw5SDhydzVKbkJzekFIQjhndGV3MklDWXgwVDVYL2VrSm1a?=
 =?utf-8?B?a2N2bTZVcVBuUStSUFlESm9XdGg3Smc5UUdGVk5MaHBteWpQY21ad2g1R0xN?=
 =?utf-8?B?Y3dMZzYrTHA5ZDQySDVnTS93R2V6S3Y0YkxicVNDQksvS2ZJemFtNTVKS1ow?=
 =?utf-8?B?QVQyRkdUNHhsdTd6VWdwaDFhZkJESzFZUytKRDVjNXhKbHBxQU53S0I2TUdV?=
 =?utf-8?B?dTdndHBIc0hRcXJrK0dUOG1BUWNTQlBrVW5vUGtMbXVLQ09tdGdhSGU5dnBF?=
 =?utf-8?B?MUtScGhjUkFFS21pdk5TTnpkUnBkMDVjMytPTFpkWXB3Ty9PSVJIR2FMa2lJ?=
 =?utf-8?B?ZDlIOEJSaElCR29ISDNhT3ZzamhQTnBEREtEK0pTb1RGT2ZFNUl0UGxZamVO?=
 =?utf-8?B?emppM2VlK1FkU3pPVkZPRnhjVHBQMnJhemtVOTFnOVQxdm1qSExYSmZ2bmF1?=
 =?utf-8?B?aURSeWkwK0E4VmczT25oenl2YzBxd0xNWnBqN2k2Y1M1cS9LdmNxNVpzQTI3?=
 =?utf-8?B?dzFLNmdWTTlvejk2MnUrazFTTjA0WTE4eW45dmJhc1R2QlI1dVVmby9mWHFp?=
 =?utf-8?B?QXZoclM1TUJUb1dOekxxM0ExTWZYZjhnbmlhRXFjUmtPYkxVVitwM1RvZzBS?=
 =?utf-8?B?ZXEyMUlUdmF2cWZHN01HRUhCMFhoaEZnYndlMExYVDlqZDkyM1AzY2lYSTNw?=
 =?utf-8?B?cWV3cXF0bld0TkQ3S1dBUUc4UmtVNGFIM0h1L1NWbnV5RXBlS2ZiRFRmdlpw?=
 =?utf-8?B?VjZKcWNTM2c3Z3RBS1N2emEyNzdSLytReUpzbVhoRkZYRWJPb0JBM3Y2aWZS?=
 =?utf-8?B?NVNGeDN3anQzVTFZTHBPQ0tqbGZ2QmYwYnBWWk9NYVFpQ1NZY0lpVzd1Q0Vu?=
 =?utf-8?B?bGVHUlhKc1VMQ2VNalJ0R2tLQmZBeDYySjVhclI0K0NDc25Sb2duUkFuQ0Vy?=
 =?utf-8?B?VDRQdWxiRDRPMlNJRzBmNkJGZWpBL0wvWDJacU9kS3JqY1IwcHpiRUVXbVE1?=
 =?utf-8?B?RFpReXRsdVNONElMdkF1T0d5UXo3eXhBWlRBYUlhRlpuck92UVVyUlB4N2s1?=
 =?utf-8?B?NW1lNERITHZBVVY1aEpCVVlJMFc2ZklIRVVGdmxtMFJzSlBQV2RHNUVWazls?=
 =?utf-8?B?eUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6091b2b6-55ba-404d-2021-08ddd0e91960
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 10:49:32.9105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JvqRHb+o7AOxnVlcINyaFry+91JH8bjLuaoVRF0nFkRxotJsCXsvcN5LamMC/893FzQ+i6sW5DMJRfUW488QXisEy1JhjvbWzYj5iei1lFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9495
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 01 Aug 2025 10:49:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17832

Hi Antonin,

On 7/24/25 12:15 PM, Antonin Godard via lists.yoctoproject.org wrote:
> Document the BB_DEFER_BBCLASSES variable added in 8e741b2e885a
> ("ast/BBHandler: Add support for BB_DEFER_BBCLASSES").
> 
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
>   .../bitbake-user-manual-metadata.rst                  |  3 +++
>   .../bitbake-user-manual-ref-variables.rst             | 19 +++++++++++++++++++
>   2 files changed, 22 insertions(+)
> 
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> index f60a9d8312..8df81e9b66 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> @@ -871,6 +871,9 @@ In all cases, if the expression evaluates to an
>   empty string, the statement does not trigger a syntax error because it
>   becomes a no-op.
>   
> +See also :term:`BB_DEFER_BBCLASSES` for automatically promoting classes
> +``inherit`` calls to ``inherit_defer``.
> +
>   ``include`` Directive
>   ---------------------
>   
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index 6be8dbbf63..cc1f74825f 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -141,6 +141,25 @@ overview of their function and contents.
>         The default umask to apply to tasks if specified and no task specific
>         umask flag is set.
>   
> +   :term:`BB_DEFER_BBCLASSES`
> +      The classes listed in this variable have their :ref:`inherit
> +      <ref-bitbake-user-manual-metadata-inherit>` calls automatically promoted
> +      to deferred inherits. See :ref:`inherit_defer
> +      <ref-bitbake-user-manual-metadata-inherit-defer>` for more information on
> +      deferred inherits.
> +
> +      This means that if :term:`BB_DEFER_BBCLASSES` is set as follows::
> +
> +         BB_DEFER_BBCLASSES = "foo"
> +
> +      The following statement::
> +
> +         inherit foo
> +
> +      Will automatically be equal to calling::
> +
> +         inherit_defer foo
> +

Reading this I was wondering whether BB_DEFER_BBCLASSES needed to be set 
before the inherit statement for it to apply, but quickly looking at the 
code, it doesn't seem like this limitation exists?

Additionally, is there a typical use-case users would encounter that 
would require this? I can see that in poky we use it for native inherit 
which I believe we ask people to always inherit last in a recipe?

Maybe this is something we could document in YP docs also? That is 
defaults to "native nativesdk cross crosssdk" and that you typically 
want to add to this variable and not override it (I'm guessing?).

Cheers,
Quentin

