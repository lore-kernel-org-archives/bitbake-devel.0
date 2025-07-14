Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D71C83F1B
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 15:58:53 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.38])
 by mx.groups.io with SMTP id smtpd.web11.81683.1752508723585556327
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 14 Jul 2025 08:58:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=SQkK6KTH;
 spf=pass (domain: cherry.de, ip: 52.101.66.38, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qvRVR76HqgBNNng6nb5u0Mp3ygp/Tf0c7fFiLP1A4XazwDN6JINsGDoEqAfAYaAGrvfJ1IQjGRimW0WqHF0VEhcvnjJvlfjE/ExwZ5m1uYwK8TTEDfF7AYMpsN9qUGK6pbjfE3AUd9G0+GmDHfzV3DB1wMviEvXk4x+deAkwCM2MYmOvIKi8B8VfNtl5Phc1/cut78ZKZIc++URaeYcuR/Kn988x7Yx3qQkbAO/iuhbfqGeHK9+MhnzQDrCEpGpsaAf7TEDqSEctoQpAFv38UfEE7wmiWsrE3N65Ns8UoCvtOeiNvP7mcAehpkaBo4K3gXMdZwYo3nMEC7yJjcWUqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06igNnMjY5F8qtlT26+NFn8FKc8cWSJkaqyVQATA4Vc=;
 b=WOYvQTRSxEtnuThucfxYeekrP16hpLaZF5q+BSoLMVsr7TQzrjYOLttXzZYedRDchjLC8C2ef5hJrWnTr4HV113eXK0LuDrpRH8+NSuvFl60vSTflxFY5wcut6ASDbRo8XQsyadLCiTy2d8kiMZ4vxZw0iWdOSUb/dFxwVQmKFHTQLJi/tn6VmK6uFrr4Ddp5daK1F0CCYSGqRrB5KGTLsgzdgkb9h93NOyU19MmxKSg/S2K9S45y5vs2RDkLwSKdeL1OsUHJi+gIZ6N0QnEJzA3SbHtJMuLaH1306X81M6m2sLkADnBXUSnPS55O1OW2qaDUQz1xdh8YZ8JhJ1dKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06igNnMjY5F8qtlT26+NFn8FKc8cWSJkaqyVQATA4Vc=;
 b=SQkK6KTHcVP3Lgz9fydTlgh9jNRcsfijhRX2SEwrt3EI1xJaV14vGmaMqnom3SVIGj4czghJumB0Nz2SkvN0SQs+26pLkdygdXc+y6U0Y0Twi2yZCyV98YRvtPGO3HbiP/5yTG46QFbsOz8XnRLVMk3d1oxnhmbK2bLL1DJSklc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB8457.eurprd04.prod.outlook.com (2603:10a6:102:1d8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 15:58:39 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 15:58:39 +0000
Message-ID: <1c917262-95d7-455c-85d2-595376ee2d14@cherry.de>
Date: Mon, 14 Jul 2025 17:58:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [docs] [PATCH] bitbake: clarify significance of "include_all"
 directive
To: rpjday@crashcourse.ca, YP docs mailing list <docs@lists.yoctoproject.org>
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
References: <f7199bf7-9b0c-9218-1a8d-15f8a83bc869@crashcourse.ca>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <f7199bf7-9b0c-9218-1a8d-15f8a83bc869@crashcourse.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0066.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::19) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB8457:EE_
X-MS-Office365-Filtering-Correlation-Id: 32ee8842-466f-4b8d-0524-08ddc2ef4c8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bmtKaGF3UEJRWGJHRWtFY3lZZDdwSHFVQTlSUU0wMkFXWCtNM0hOS1lHZEI3?=
 =?utf-8?B?RUpDU01ydUlWYmVhUFI3QTBiMElWbk94c0F3cEE2dkpsUDlVaUlGbjBWeDhl?=
 =?utf-8?B?WnVrUjdOenBCNlYvb3d0L0dJcHNMd1EyNFRlcUlRWEFBcUhhQVZTODZtY1Zy?=
 =?utf-8?B?Q3hEQjlNdTQ4dkd4dUVqbnVJaHFwYXFJblMzU0NtTGxodmRSS3N4MGV6SDdU?=
 =?utf-8?B?RWlWNEMzdHYxblNHY0NIMExGenBaREY4WkZSOGVwSmdVTGQ5cFpMMzUzMnBV?=
 =?utf-8?B?QUFYL1FpOTVjbzZoN0tleU5vQlBHTjJ0RDlzOWt1WC9hWm9KdE1DU0FySnFI?=
 =?utf-8?B?SzE3bGsvUVp4YVBJUXJwb2djWWROR1EyU1lmeUtoVjc4YVNxTDVJRE45cG5X?=
 =?utf-8?B?Q0YzRzRxMDZ5VjVNUkZiMnVvaENpOWtxTDlEQmVrb3g4YVhxZkh6VU1Hbkdm?=
 =?utf-8?B?U1ZQSlAzOTZYek1oT2wyUHZXU3lsayttTXNleWhGTG80ckVuSXU5WjJTZTAw?=
 =?utf-8?B?MjJRbDEyZFN4QUg4a1RxNFVOR3o5dG9lUUc4c05TQ0FReXRHRCs0OEcwUEVX?=
 =?utf-8?B?ZTc1MDhUV0YyeWdWVjJXTlNBZzRIOG5McWhBWmtBTjhlcFFiRk1vQk15VjQr?=
 =?utf-8?B?aXJBd1c0RzNmNE9YdUdmWHVXTmgwZGJORTNwVWp3UHEyVXFuSmd1Z0pXVnQv?=
 =?utf-8?B?ekZUNGYwOW1qY2V2VjlJdGsxSzlwRk9UYVZHd3lvOUFwVjhLMTNndmNKS0xi?=
 =?utf-8?B?ZVpxSEVKOWtSMmVkWllsbEhJZFNUNnlGRTlta2lKVnF3L1pWQUpqditYb0Vu?=
 =?utf-8?B?Ly9uVEJGYjRDa1AycHBuMS9XaHZiRHpZdEp0VllYOTRhS3dWZ2RyaEZScXlr?=
 =?utf-8?B?cmxHZnVYSnhjOXUrTEdlVHlRRDhRelFiTHM5ZFF2bmhEZEVXVHBMSGViSjh4?=
 =?utf-8?B?N3FPQ2RCTGdzRzluWmVPN1ZCbzJ2Z0FMVHhOclN0RHBaREhrekh6UzY2VTc2?=
 =?utf-8?B?c0xpWGpRcDVzd1RxeVlDbHd3YnMvdUVWY25JWXhORW11ZU9tK0lMSk1aaHNO?=
 =?utf-8?B?cHQxOXRRZzVTMCtXYkRrNmRYSklTK2h6VTJNTkdBa3ppYTlOTTFJSlJSbmhy?=
 =?utf-8?B?M09iZ3ZPb05XUlplZXU2aWU0MkY3Mlk5bTdOVnpVdHNjTHpjT1VEN3crRzl3?=
 =?utf-8?B?SWg4SkxQbFMrTnRPVVVLU0JENXdjRjRwUmtHcFR2SlZSUmFaYU1PN2w4bmcw?=
 =?utf-8?B?SHl4bVJnSWd6Vi9FZ3p5QkViaEhPb2wwcnF3Y0RzRXhRZzFBYlR6NFl4ZU9j?=
 =?utf-8?B?U1VIVGIzVmJpeld4UmtqTVlvUEdxTWZTYUNObTl1TzltNE84blNUN29EZ3Bn?=
 =?utf-8?B?QXZySVVvMHlmZllSRVgwQzN4bmlWdzVUVlluQWFVaHdLNGtXcGliTEswWGI0?=
 =?utf-8?B?ZGNrMXNBRS9tWUhyMkdXK1F3WStvRnNJL2lqNGttOUJTcXJCSXUvN1lOSTQw?=
 =?utf-8?B?Z25QZXhKUVRPQkpIWGFMcG8wYTBmUmt6ZXhhMEVScnlBTkFnOFZDcWZtWlhw?=
 =?utf-8?B?Y0ZJMzJEVU1JS0x5OVd6blhORDNpZFlscW52UWRaUWNjY3ZUOVorUkhwY0VM?=
 =?utf-8?B?M0tkbU1jRDU2VUVkNHlWMkRTY0hyY1ZYQ1NGdkJIMW1TZkVRQVJPK3NVaEpQ?=
 =?utf-8?B?QmFab3hEam5lRmgxdFVzYTFYdXZ3ZElnd3VDY0JMVE5KTkFtSzQ1dGREMlRz?=
 =?utf-8?B?dDdaTEpEWFdLZm0yVmkvSEVnQ051NVpxOVVEbDhBZnB0WmdQU3kyZlhPN1Av?=
 =?utf-8?B?QnlaKzdHbjIwdGlKTzA5MThhZVhJK2xkREFtUU9lMGFCVEw0MEtGVzNSR3VP?=
 =?utf-8?B?MldUZlZCUDEvR2NYZzJUb043NExlVGhGNWxIYlQveTU3dkF1K294SmV6Rytl?=
 =?utf-8?Q?zl3TYi9FqDE=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V0JCTit4ZXNMWTVrMHB4bXJXbjcwZW1qbGQyOWFnV1pzVnVaU2tYN2tDanVJ?=
 =?utf-8?B?cUN3a1A1UHRFSUdGRVBMeGtMUFlycW0zVXNIdVNFcmlrcXhqbmZZSXA3YTFB?=
 =?utf-8?B?dXRHeXE3dWxJNDU3T1FVbFlyeU82TUN2VHNNK1NlMXd3VXNkU2JQMGtIVHFX?=
 =?utf-8?B?WWdQWi9ncHFsRGxkK1A5b2wvb0I0cVpUWW5pcVZKRVV0d1JVcHB2dUFTUURB?=
 =?utf-8?B?SDRlNFh0MFR0WXRjOVV1YlI5T2JCVEt4K0ZGWmlFbHdLT1VpYXNMa1l4S1B6?=
 =?utf-8?B?Ym9sSmE5Zjl5eUNIZmtjSWZHbmlmL0o1dEw0aE5NY0psOU1UUnd3dkI0enFp?=
 =?utf-8?B?QWprMkFXcW9RZkVkOGFFTm1PSTVFUHhIZWFjZ0pON1liTDh5ZHdMa0NkSHht?=
 =?utf-8?B?OGFqWDM1UzZ3bUpUbTJWUFBWUVVadnVFRmduZ3FDSWpsdmlmRHliWnFmTmU5?=
 =?utf-8?B?SWpjZ1ZGMFpWSDFZNC80djQvWE9Danc2bzdiZGM2V2U5ZXAzTFNuL0xIcms0?=
 =?utf-8?B?NEY0NkJiOGRzRm1PaE1wMjloVXg2UWJYeldtYmx6MzQ5WllkWXpBNlF2cUpE?=
 =?utf-8?B?MVgxTVNPL1pTYXZRY2pISGtCQ1NzUThJbnpnYjM1WjdXTVVUc01vYXRtYldT?=
 =?utf-8?B?Q3ZiUWNCV0IyeGhjRm1VcllVd0EzNG9jMFdMNnhpLzd4L0gvNVhoZnQ0clho?=
 =?utf-8?B?UEFCQ1VUV0ZnMkpFY2s2eGQ2aUJUdFhiVUNPU1JlYkxuQ3p3VWZIUDFHYyt0?=
 =?utf-8?B?RDVpTzRSQkhmczBRakZsaS9vNjFiTlh1R0VDMnhjRjczYTFPZ3BYMjkzbVFV?=
 =?utf-8?B?cGNuYVJwdXNwSnFuSVJ6dFlzdWJQcFFlR2trck9TM2dUa2MxWnZxbmlSS3U3?=
 =?utf-8?B?T3lNcndORVo0V28xYWExT2kvRUxHRkR1UUEwM3NuWGpVa055NUhrMk95ZlFO?=
 =?utf-8?B?RjZGeU1nRE1jbEZZUVpRc3NEN3ltMEZWT2ZpRmpjK0Z4UUt2YXNWajExRGF2?=
 =?utf-8?B?Y3pOdjI1OWhjbG9Rc0lzQ3BEdm4vNGExcXNkelkxWlJiaTdBOXlLaGhQMU1V?=
 =?utf-8?B?dTEvWFpSdmkyMGNQejVjVU9qQW5Kck4vRzJ0Z2s3aUU1M0ExQ3M0Q2ZSeHNr?=
 =?utf-8?B?SG5tbzN0V3lpd0V0U3ZFRXpWQWF1U2lKQU9WYVk2Z1QybnhBcTF4bTdDOVEw?=
 =?utf-8?B?aEJ2Z3R2VFFVK1ZkRTVoaEEvYUNweWRZUHJrSjR2L2h6a2VrOXhyWnlkcHF0?=
 =?utf-8?B?VHJJZlp6TUhHVTY2dDhwT3E5dHVJMHVoQU1BUEtNZUV1SXJOV05SMVFkU3JQ?=
 =?utf-8?B?UHVjbWF6dnJ1R2dvQVBEZ1VjNjlpdzMxMWJnT0dXSm9LcEEvcURHT1NLUHFR?=
 =?utf-8?B?SWl4NXpScDd3OXdLMXhGVVlFRWE3Qzlrb29OK2krejduTEQzNExNeFdUWWF1?=
 =?utf-8?B?L3NzdjdIZnpaNEY0UFFRaTRNVXJPKzVGQnAxaEVQUUhiNjZqNTFjT0N6bGwr?=
 =?utf-8?B?YlRjd2lQcjU5NUNrKzF0cDBEallPL0ZCSlFGN1d6aklMT2NQRTg4czZLb3dT?=
 =?utf-8?B?ZUt0cW9ua0RSQUs1SjZzSmJLT3ZIV01BWGM3aEw4c3ZuN3RQWjU1ZmdzTVBz?=
 =?utf-8?B?cmhjZ1pOVXo1SGRrMWY1eGluRHFLRmJaUHJsVC9IaUtGdHJiZS9BeWYrcTlC?=
 =?utf-8?B?UGxpRnZBNWluZUxvS2YvMmMyRm1JM1lMWER5U2JJeE05SXhQZTRac3ZCTXFP?=
 =?utf-8?B?cUZNTEp6c1pseFVnNHNiZWUxTUdHTXhpYm02dEFqUnRzNXlRbURIMFNTdndx?=
 =?utf-8?B?NFBESXNGOHJ5aFU2aG5vZkNmUWV2TUxncUJxbG1lallJUFlRNTJXa1NpTnow?=
 =?utf-8?B?SFV0ejdjMjZMMnVhU1JNNWhKd1pJVnlwdzBaV1FVbnc3clNrN1EyTnhHenhq?=
 =?utf-8?B?VnZSaVh1b2R6WHZlWEIrcTkyaGFlTWpJcEVhRjcrZ3NBb0xjdUNMbVJxT0ht?=
 =?utf-8?B?L2NDRitEVUtoTUtNMUdvSFJCcDcxZ05PYjQ0MUIzMXZmN0hsb0syRUQ1MzFq?=
 =?utf-8?B?ZWJwa1lUL3h6elc0clFoQkN3Sk9XU1ZRN0NZK3FUUDFVdDVKWkptUm1iRXRR?=
 =?utf-8?B?R01ReGVTRWVGaThnV2RzMFh0NXZndU1lNmN4bVNpQk1TeUdHeGE1bTcrdnRr?=
 =?utf-8?B?REE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 32ee8842-466f-4b8d-0524-08ddc2ef4c8d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 15:58:39.5118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mghEO+/ofsBCA2FWuWIVJ0kRPCFfDmFbqJhDGWKS1YxfMh8/gOKE/o3vLgYlJJqvMgipxDT9FKcFJc/598Bj9vVFIATwc2bFHNQbz2FH92g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8457
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 14 Jul 2025 15:58:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17774

Hi Robert,

On 7/9/25 8:16 PM, Robert P. J. Day via lists.yoctoproject.org wrote:
> 
> Rewrite the include and include_all sections to drive home the fact
> that the include_all directive is relevant in only very specific
> cases, and not something developers should expect to use in normal
> operation.
> 
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
> 
> ---
> 
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> index f60a9d831..1042c65d8 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> @@ -874,58 +874,67 @@ becomes a no-op.
>   ``include`` Directive
>   ---------------------
> 
> -BitBake understands the ``include`` directive. This directive causes
> -BitBake to parse whatever file you specify, and to insert that file at
> -that location. The directive is much like its equivalent in Make except
> -that if the path specified on the include line is a relative path,
> -BitBake locates the first file it can find within :term:`BBPATH`.
> -
> -The include directive is a more generic method of including
> +The ``include`` directive causes BitBake to parse a given file,

While at it, always replace ``include`` with the appropriate :ref: 
cross-reference link.

Ditto for ``include_all`` and ``inherit``.

> +and to include that file's contents at the location of the
> +``include`` statement. This directive is similar to its equivalent
> +in Make, except that if the path specified on the BitBake ``include``
> +line is a relative path, BitBake will search for it on the path designated
> +by :term:`BBPATH` and will include *only the first matching file*.
> +
> +The ``include`` directive is a more generic method of including
>   functionality as compared to the :ref:`inherit <bitbake-user-manual/bitbake-user-manual-metadata:\`\`inherit\`\` directive>`
>   directive, which is restricted to class (i.e. ``.bbclass``) files. The
> -include directive is applicable for any other kind of shared or
> +``include`` directive is applicable for any other kind of shared or
>   encapsulated functionality or configuration that does not suit a
>   ``.bbclass`` file.
> 
> -As an example, suppose you needed a recipe to include some self-test
> -definitions::
> +For example, if you needed a recipe to include some self-test definitions,
> +you might write::
> 
>      include test_defs.inc
> 
> +The ``include`` directive does not produce an error if the specified file
> +cannot be found. If the included file *must* exist, then you should use
> +use :ref:`require <require-inclusion>` instead, which will generate an error
> +if the file cannot be found.
> +
>   .. note::
> 
> -   The include directive does not produce an error when the file cannot be
> -   found.  Consequently, it is recommended that if the file you are including is
> -   expected to exist, you should use :ref:`require <require-inclusion>` instead
> -   of include . Doing so makes sure that an error is produced if the file cannot
> -   be found.
> +   Note well that the ``include`` directive will include the first matching
> +   file and nothing further (which is almost always the behaviour you want).
> +   If you need to include all matching files, you need to use the
> +   ``include_all`` directive, explained below.
> 
>   ``include_all`` Directive
>   -------------------------
> 
>   The ``include_all`` directive works like the :ref:`include
>   <bitbake-user-manual/bitbake-user-manual-metadata:\`\`include\`\` directive>`
> -directive but will include all of the files that match the specified path in
> +directive but will include *all* of the files that match the specified path in
>   the enabled layers (layers part of :term:`BBLAYERS`).
> 
> -For example, let's say a ``maintainers.inc`` file is present in different layers
> -and is conventionally placed in the ``conf/distro/include`` directory of each
> -layer. In that case the ``include_all`` directive can be used to include
> -the ``maintainers.inc`` file for all of these layers::
> +.. note::
> 
> -   include_all conf/distro/include/maintainers.inc
> +   This behaviour is rarely what you want in normal operation, and should
> +   be reserved for only those situations when you explicitly want to parse
> +   and include all matching files found across all layers, as the following
> +   example shows.
> 
> -In other words, the ``maintainers.inc`` file for each layer is included through
> -the :ref:`include <bitbake-user-manual/bitbake-user-manual-metadata:\`\`include\`\` directive>`
> -directive.
> +As a realistic example of this directive, imagine that all of your active
> +layers contain a file ``conf/distro/include/maintainers.inc``, containing
> +maintainer information for the recipes in that layer, and you wanted to
> +collect all of the content from all of those files across all of those layers.
> +You could use the statement::
> +

This may be understood as all active layers must contain a 
conf/distro/include/maintainers.inc file in order for include_all to 
work, but that's not the case. I would reword from "all of your active 
layers" to "some or all of your active layers" or simply "some of your 
active layers".

Maybe avoid "contain" redundancy with

"""
contain a file X with the maintainer information for the recipes in that 
layer
"""

Maybe make the sentence a bit shorter with

"""
you wanted to collect the content of this file from all those layers.
"""

> +   include_all conf/distro/include/maintainers.inc
> 
> -BitBake will iterate through the colon-separated :term:`BBPATH` list to look for
> -matching files to include, from left to right. As a consequence, matching files
> -are included in that order.
> +In this case, BitBake will iterate through all of the directories in
> +the colon-separated :term:`BBPATH` (from left to right) and collect the
> +contents of all matching files, so you end up with the maintainer
> +information of all of your active layers, not just the first one.
> 
> -As the ``include_all`` directive uses the :ref:`include
> -<bitbake-user-manual/bitbake-user-manual-metadata:\`\`include\`\` directive>`
> -directive in the background, no error is produced if no files are matched.
> +As the ``include_all`` directive uses the ``include`` directive in the

No need to remove the cross-reference link here.

I don't find the maintainers.inc example particularly useful but I also 
cannot come up with another usecase of this directive so it'll do for now :)

Cheers,
Quentin

