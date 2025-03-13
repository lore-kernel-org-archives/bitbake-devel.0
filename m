Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E59FC28B2E
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 09:15:59 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.65.42])
 by mx.groups.io with SMTP id smtpd.web10.10513.1741857352375646723
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Mar 2025 02:15:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=lrlFrM5g;
 spf=pass (domain: cherry.de, ip: 52.101.65.42, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MWWTEdkottSgmdPS8SHCejZNrMEdPTk++k+/dLFNUOg6kPT3eK9wLYzSoQ13bkJ3fJ6kFQLV/+oo5KC+UQK6eKvFMN7LW7dv6iehOuAQZtjtQfcXqfU3JJWwSWtZiufmK7k4326+xpSmFXAf5qS07dgddG+ZZf/rV1m9RqKh0EvYpvqM/NMi4hmNoZfqhStvcFJMmiSldNB8s/XT9u62uHho6mAn9Qj6KamnVTBq5S3DUP8qDGvHgeNqDPM/9x15vtxNGdYBElUugSBLyubbgt49GK6gL1nG5rtSgPP/bP6X7XmswLucYUKE47OEfDo3KTmXFI/CgebnoCbc+aOaNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bKVFCVwqvJev8Gxlb2OneRIzT2ZYZrPh0BRvIC+xMCU=;
 b=PfbhOIk/TN8BYt2dZ7RDuXnKL2IkJ1amEuQjwDsGu5qG+DDuNCfDAT4HB5R4tfLIV2g4L4a3tIUbkCeDrGtjzVlND9czWILzMov+XeY560fgafsyPWuO+HxPxL3n2wUKHCWCsj1xT+FAVdKdBC/GXezgsNNj+14E4hBaxOz5HCiLxVrV8ZDq9NgMjaURA70yPxHeKxuti1Wsd0eWFmCXJ8hBJOUQV92HfL9ZMMhVzcmU96Fl+xvq32BoFLJen0dS4oNxty01fDlbXleaFjUXLNOxVfFy2xY4AEx1fnFrHynavUUAJ+yC6BgbK1mbobIK6zr+BLNaOSmf6Q07kZ9fKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKVFCVwqvJev8Gxlb2OneRIzT2ZYZrPh0BRvIC+xMCU=;
 b=lrlFrM5gMyQs0IKYfcOu8ih3AHIhJQNLea1cjU9qR0ChjOtKJzFUCCCM+3OcMbd5QjL5kr3peUscSFxyA3LKGFL/ONFO9DAQ8ijoX9qeglLr7AHC/UIyt7WzKLMm9dEL2Nk06No2EPOEs+5aZXgptB18fwnSf3T3cOnaBNveu+4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by PR3PR04MB7387.eurprd04.prod.outlook.com (2603:10a6:102:91::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.27; Thu, 13 Mar
 2025 09:15:49 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%3]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 09:15:49 +0000
Message-ID: <1a961a35-5caf-4484-bfa0-a7e691e47cf2@cherry.de>
Date: Thu, 13 Mar 2025 10:15:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [docs] [PATCH] doc: bitbake-user-manual-metadata: document the
 include_all directive
To: antonin.godard@bootlin.com, bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 docs@lists.yoctoproject.org
References: <20250310-include-all-v1-1-76843785384d@bootlin.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250310-include-all-v1-1-76843785384d@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::8) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|PR3PR04MB7387:EE_
X-MS-Office365-Filtering-Correlation-Id: a8e41faf-3abf-40ba-e28c-08dd620fa514
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dHcxMk04MUp2Q29rLzQ5cStLNWpPMWpDcnJsQTd6N0FzOXpBbjRpdjdjMVlG?=
 =?utf-8?B?Vy9jRXU5RXlhYkRkdmdDeFcyQmlLclZGWjgyS2p2TUprNmJaVU4zT0JyUHRT?=
 =?utf-8?B?K1p4bm80QzdEemxML0wyYkhQOTV6cXZIUERZWDQxTitXc1NKZFcxR1V6eDBK?=
 =?utf-8?B?OU5yalpZSWg3RnpxSnVBeFlXbVNDWS9PbXQ5aG0vQm5hRXFpUzRWYVJaSy80?=
 =?utf-8?B?RGtFVmZBLzROOVEvN3ppQkZqalFkckpvNHB6ZlA5VXlYem54OUIxd0owNkty?=
 =?utf-8?B?UlpTMCtvUmoyKzdtZ1ZMSzN4YzU4M1RFKytXQ1E4RmRNWVR1a0VWMm1lR1Nj?=
 =?utf-8?B?VlR0M0UvMC9mTHBkaUdPV1BHNUQycW5PYnFlZll6Ni92cmJBajRBZmxqRmpP?=
 =?utf-8?B?NlJkOTBvR1VSYUpPdXU0OUYrRlpFakpVQlhjczFza3hSbTVoRlMvMFpuQzIy?=
 =?utf-8?B?dXZ2eVZtWDk5aGNad1RwZlRraU1yTklaanZPSTNOK0lLK0lXcnFGRXdDSEEr?=
 =?utf-8?B?Zm1aMEp0MXB5M2o1SkIxTXJpNjVVdERKcVdVNHovTmdTNTBydUpqZGRvZjly?=
 =?utf-8?B?Y0ZRK3dzZXIxWjArNmJHbnlPVVVlRDU4YmpsR3lsU1djamdpMVlzOHhDNkRS?=
 =?utf-8?B?SWdmTkh5dmhBT21QSEl3dG1CbnJkd3IzbHN6WU5QL1Nqb1NQVnNHb0J1eXJO?=
 =?utf-8?B?VEkra2Q4WWZnUXNMRlVLbzNueG1WemdRNnhMUFRwRElkWkRyaGcvQUxGcmhv?=
 =?utf-8?B?Qm8yZUg5ditsQ25MTVhtWjN2UzFvenY0QkZWaGw0aTNNZTJnVDB6YVIwa2F2?=
 =?utf-8?B?TjUybHNUVmNLdU1ZOEtNdG1LR0E4K2ZBQjlsTTNJeGhydGN3cGFoYTJDQzla?=
 =?utf-8?B?ckRMNTUvZ3dMK1plbnVzend1eEVrRlQzZDNRS0QxTndXb1hJSlFIZXRoYkVH?=
 =?utf-8?B?NXhwWXc2dTFiUlgxNmhidGlZZ3pGRGlVT0RkRmJCS0FqejBoalloTndRU2RS?=
 =?utf-8?B?dFZOTURxYXdHSmlsSTVidGVTdnM2dTN5ZUNBTUpick85cHVBam9CL0JXbTNt?=
 =?utf-8?B?TWpXZGhzbzhZdVVqNHU5NWpOREVlV1RKYjI5cEtDT1Z5MGMzaEtrdFI5VGlv?=
 =?utf-8?B?T3BhMU5HYm5KU0swQmxwbFhZbGVqYklkTUgzMUZFSWZWQXZlelFpNTROZTZG?=
 =?utf-8?B?R2VaaXoxclA0M0t0R3lMRVkzTnpFSmZpckVrWmJhU2t1WjZXOVdKZEVvU2hF?=
 =?utf-8?B?YWgycGd2N3pNNXJ4aG1iUDdDRnBmdkVCbU9yZ1BiQnRWaS83czFMUExtaFJV?=
 =?utf-8?B?TVlzTmYrODFaN2tRM25tMjZ2QzBKZXZrWGZjMGFIeFNGVGtjZGt3VXRZMHBi?=
 =?utf-8?B?dzJpVHJOVU5BaDNURkRObDQyY0U1bWRhNXB3dGhFdWdiSjFaNUdWeENGckQx?=
 =?utf-8?B?eFphUkFGc290V2g3cTNNNEtSamE4eFNrV0tJUzB5V1JCNWVUV0o0V3BGWGg4?=
 =?utf-8?B?UkZkOHh0V3crNzd3bVBVejVTK2NaRUhxN3hxUU5abmQxSHR1QzZobEpIOGtk?=
 =?utf-8?B?ajNCNElXYStXUEJGZDRXV3RrVXl1L0ZYTDJHR0tnOXNtc1hYNmpOSEcrWFpE?=
 =?utf-8?B?UXdNbWl5OFRjNXQxMzhTUEN1NzVIcTBwb2ZYZTlpbUVKeFlYaXlEMjRnN2Vo?=
 =?utf-8?B?Tk53RUhZbnNDcUE4KzFCQWh4emZFUVdwU2ZtU1oyeHByK2pvVUZWa0RQRDRS?=
 =?utf-8?B?UllpMkY2cFlUWW8waXc3SjE5MElBdnBwbXVvVzVFWTZud2NhWVJ1NGF0Zmxa?=
 =?utf-8?B?VnNvN3pCdXdVV1dDU3BVRjlLM2pZaSt3WkFvbHUwdTJpOVcvQ3VMUnlkdVF3?=
 =?utf-8?Q?HPcru2M8B3INz?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8906.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bHJtaGw3MFRMYUt6UDFScHZnM3QwWlM4WnB2UzhuNUQwakY3V21kOTdXVmlO?=
 =?utf-8?B?dnFQdUJ0aEMwRnh6Zis0ZXA1d21pWStGeGtEVnNtRWdnNFJyOFpmUlQ2UkRx?=
 =?utf-8?B?dzY1dTA2UWFoYXpJdTY5a010RHpEU1F6bjBDQXJIQ1B0RkdBUEh0dzNVR2Z3?=
 =?utf-8?B?WWJya09hT1JmRWYwVk1QWHBkaXpPVmdBb1NYNmM1MFE4MXNiVlp4NzZkMExD?=
 =?utf-8?B?eUxuRURESkFpNlNZbmdWNkFlbHRza2tvN2tTckhsV3prdHVqN3lVVWlWN29z?=
 =?utf-8?B?eE9uZHRrWFJoWnVuRDhXQlA3cllxTjZZa3FEelpTZ0NZVUZJaFRuRTVhaXFl?=
 =?utf-8?B?RGFHbEtQeFk5dkNiK0dYa1RPcDhORG9VSjRXek5NcmRHUStYOWlVTHpEeUpu?=
 =?utf-8?B?ZVZxS0pGbmVJZWg1MXEwYk54ZmJMNjJ5M2NXd0N2MHgwRVZ6VVVKQ0ZGazIy?=
 =?utf-8?B?QXk0R3VwNXFMRS9aS1dQNlFNb0hTR0d3a2Y2NHh1SFQrVEwxZFVCWFE0eFlz?=
 =?utf-8?B?d3RLWmY1VzlhL1RKMTZ1ZlVKbGNHMlFaZDlaWVFWRmpCOFNXMDZxTldsbmlu?=
 =?utf-8?B?WEYvK0FXNGF4RTcwdjlsclRsWm4wZzRlQWo1SmFjSS8yQXl6VURCVUk1SDgy?=
 =?utf-8?B?UU5FUXFrc25DTHJvK3htV0YzcklkQ2VtbFp0UGsveWVzTzdRbXZqeU5CeXhG?=
 =?utf-8?B?MTdTYnBOUEhOdnR6YXBhVFp6Wkg2TXpsZkk5R21XWXY5a2RERStqNXJYbCtQ?=
 =?utf-8?B?d0t5eUxjOWdKbzV2V0FVWHBZemdOVlNRR2ZZbkxSZVYwNWUwTFJqMjZ5Z1pk?=
 =?utf-8?B?WDhPOXNNdFl6akJaZnBCOFc4amdPcVVMSmE3dEF2OFBMOEZqWjVRa3ZNd1hS?=
 =?utf-8?B?aHFGQUx5bGUxekpPakxKbjFtOGI4N3Fldm82MGlXdmxxa0wrbWxWeDJpUlNT?=
 =?utf-8?B?RXhSajF2NkNhQWZwSkRPZFN3MkVtYUJZbzM0WmtxOVB5MzBsQm05dVhGMlBP?=
 =?utf-8?B?NFhobE83UGhtL29RYVcyUWFMaUF6MjdRbG9oNlNrZjRpS1M3V0dPblhQTzIv?=
 =?utf-8?B?cndPRFVDeFR2RUJZR2J2cWFNTlV5VUZMak9yNlErUXdEbHlvMitpdDBSQVhX?=
 =?utf-8?B?aFllcEZGdVIwWWltVzFVeEk5V0dFMjU4MlRFbUcyQjdsNHFtbGpXdDN5cVBJ?=
 =?utf-8?B?NHYxb2Rxb01UUUxLYlFMaWs2TmpxcWd3VnQvaTBMckFjYWEvMEJLTUh3M2JO?=
 =?utf-8?B?Y01aSWRveTd2ZU5sK054VmNabnFIemdCd1JId2N4YnNVb1V3eGw0UERNMHFP?=
 =?utf-8?B?OGZ4cFZJRVJtbFdkU3lVbm83ZTkzcEZqZWsvMURTd0RkWW9xT1VOSVBZZ3NC?=
 =?utf-8?B?VWI3U2IzdlcrSnJhc0h0TDYrcjB2U3NZaFc2K09DNWgzOUNpSi9lMlF2NmNy?=
 =?utf-8?B?bEdVODNBNDdEc3ZJUlZKb0NZdVpuWEVTVXptWnV5Z3c5UzNTLysxQnFlRVBo?=
 =?utf-8?B?djI3MDY3TWdBSks3VUJOTzdvaE1NN04yVE53dzVHZWlSOEUwaVBHZW5YWlVo?=
 =?utf-8?B?SzRDQjh6ejd2cnduUjVVbHdxdlZSUStWRkw1clIzenYxMVhEYXpJS0kvKzlW?=
 =?utf-8?B?MnY4dk5aYkdWWDNmY3N4eHNlL3psTTdsM1M4clkvaG9YOXoydnRubHVFM2I0?=
 =?utf-8?B?TmR6UWlhdG0vR00yUlBNdzNTMHowRUlwZzJhQ1VUWVB2NjVWTmpQM3YxRGpN?=
 =?utf-8?B?UDY0dFhCVmw1RTdyWDJyNld0c21TV3lGNUhBR0NhWll2U1FoM25YQXVQYzZH?=
 =?utf-8?B?K0MxQjFNeU9OMzRETG5VU280VjlUMHpmZWhmbGNSQmdhWmJwNjhQVHMwRU5R?=
 =?utf-8?B?Z2tBbytlOG1WQ01EZ25UQU0wSGg3THNVOVV0ajYxbm1aK2pxVE9oRndCdXpa?=
 =?utf-8?B?OUtVbWYxQU1nSXZTSW10dmRhbURUY0ZKbFQwU1M0b3JDKzJ1eEQwOHpLazJl?=
 =?utf-8?B?UHRzM1NsTlZqd3J2dzRTYVZCUXJRL3QrTlFyZEtIcjRuVjE2OG5LYTBkNTY4?=
 =?utf-8?B?aUpjT1ZSY3RQNGNXMW41UHJMYjh6Y1drY1FtU0I4QlM2SEpLUE5XYlR1NjQx?=
 =?utf-8?B?b0xGdzRsaG4zYlVJaVVQWTAxcWhjQ3F5VVh0YVRjSnhkbUhWekpxSkhieHFO?=
 =?utf-8?B?OEE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e41faf-3abf-40ba-e28c-08dd620fa514
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 09:15:49.1582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S16DnpyFLBjq+TXOJzlmJTbWcnqQBFuy1arpfKjoEvXvTsb/tnfeV5S6Phl0URw5FsD3gV6t8DsOcoXU8sEw3D+O+6y+fbtmO+jOo2D+z+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7387
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Mar 2025 09:15:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17439

Hi Antonin,

On 3/10/25 12:21 PM, Antonin Godard via lists.yoctoproject.org wrote:
> From: Antonin Godard <antonin.godard@bootlin.com>
> 
> Document the include_all directive, which can be used to include
> multiple files present in the same location in different layers.
> 
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
>   .../bitbake-user-manual-metadata.rst          | 27 +++++++++++++++++++
>   1 file changed, 27 insertions(+)
> 
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> index 2680c6ac2..415fbf6d6 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> @@ -900,6 +900,33 @@ definitions::
>      of include . Doing so makes sure that an error is produced if the file cannot
>      be found.
>   
> +``include_all`` Directive
> +-------------------------
> +
> +The ``include_all`` directive works like the :ref:`include
> +<bitbake-user-manual/bitbake-user-manual-metadata:\`\`include\`\` directive>`
> +directive but will include all of the files that match the specified path in
> +the enabled layers (layers part of :term:`BBLAYERS`).
> +

s/part of/listed in/ ?

> +For example, let's say a ``maintainers.inc`` file is present in different layers
> +and is conventionally placed in the ``conf/distro/include`` directory of each
> +layer. In that case the ``include_all`` directive can be used to include
> +the ``maintainers.inc`` file for all of these layers::

s/for/from/

> +
> +   include_all conf/distro/include/maintainers.inc
> +
> +In other words, the ``maintainers.inc`` file for each layer is included through

s/for/from/

or

s/for/found in/

> +the :ref:`include <bitbake-user-manual/bitbake-user-manual-metadata:\`\`include\`\` directive>`
> +directive.
> +
> +BitBake will iterate through the colon-separated :term:`BBPATH` list to look for
> +matching files to include, from left to right. As a consequence, matching files
> +are included in that order.
> +

Does this mean if you have multiple files in the same layer in different 
locations in BBPATH they'll be all included?

I think you also wanted to mean that the order in BBPATH/BBLAYERS 
actually can change the outcome since the files are included in order?

Cheers,
Quentin

