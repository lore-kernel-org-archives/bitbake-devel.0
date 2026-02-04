Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAF9E9D3FA
	for <webhook@archiver.kernel.org>; Wed,  4 Feb 2026 15:01:48 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.21])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22351.1770217302673939258
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Feb 2026 07:01:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=Dab7r3uv;
 spf=pass (domain: cherry.de, ip: 40.107.162.21, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qzSdKUWPIRP1lzib+FRHMQz1TfeXtyJHD9+UhTKeibtQBN5OZqm3TfEIH0H07be7Ob2Ex9LRrW2IrEuZ6bBVpDqmzFIO9aQzKa5lSpdGSKD0hG7Rw6WAJ+qiprjZUGFr9Wg72X4v99k0RFddS25g9OjoLTgDiu2XIKYPTniwEotz1XVMrh11gqVP+sZ5+2A8IX5TFI8DvCOLOkxV7JVOJjmPz1ClkL4RbxMSBjNGqd+Ipm9IXyuVBs+OLqW3DzVu22hsj06tNK4i4Rcsg8Z8J6gDCH8aoZvdBR90y8g6myFkqtr1vzh6MKu68alwUrAuOFo5954/ITMEanQeFvblOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7rUhpLy08YXFPr5SBiFqy+0Cd8Q0CqERlzJjn7/G3B4=;
 b=vYoHDRVOLK7KOf6lzWqjN3qgsy4C8NAYi91NSyKP9yWOLlzOTlxGdwbtPq5z68Sn8tqiq1WUMUFDM/ePJhXmXqGyzrZ0d7Z9PSKbY7VkLx/IuxllgsIJvgO0qj7QacZHJKjBabMT71slQwISOQnAmT2UyXQuxwY+k3Q8aFmfqITJA4sLOH1sFidbksk/lffeJEkFRug+jRmpB5AyQgJk1G00GEF8yAQ0oJKuO8pxQl8FUt12Yy6LjQTr3lmoglKlyARt5y7rZmqNeBZ0W1cLjlN3ufeiWZm/tdIOxW/zM87p4gGNsm0aV7Zp9SpkswluZn93jZcapV70fHe14lmj7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rUhpLy08YXFPr5SBiFqy+0Cd8Q0CqERlzJjn7/G3B4=;
 b=Dab7r3uvzFRiBPB4+mXaRRdsvOEyVc2fHdXOQytDcppfKK5FIkgr7LdBVemglV23AfKcxc/6vSUPgHGsUimxY8NyWZRohWy/Ngckp8r92sLY13r7R55rfic9DN3MKdpwety80Z+zPBaSsrSfCGJZRIMqrbko6/h0D8U54edN7Iw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AM8PR04MB8036.eurprd04.prod.outlook.com (2603:10a6:20b:242::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Wed, 4 Feb
 2026 15:01:38 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9564.016; Wed, 4 Feb 2026
 15:01:38 +0000
Message-ID: <f9a1db09-bf8d-4f29-b2a7-567f97ce0532@cherry.de>
Date: Wed, 4 Feb 2026 16:01:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [docs] [PATCH v2] doc: fix the switchers menu
To: antonin.godard@bootlin.com, bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 docs@lists.yoctoproject.org
References: <20260204-fix-switchers-js-v2-1-ea80107eff85@bootlin.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260204-fix-switchers-js-v2-1-ea80107eff85@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR2P281CA0027.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::14) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AM8PR04MB8036:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ede2a5b-e87a-4e3e-ac5d-08de63fe4c24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|7053199007|7142099003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NlE4c0xIL3I1cU8reE84TkZkRVJiaXRXVVdjTWFKeTk2bTFnOGZzK2lOZnli?=
 =?utf-8?B?V1Q1Nk5TaFh5UEpMZmpsdWtMZHBDN1lTVjd6TDNYdjBHZ3VLZ09HSXdOdTc4?=
 =?utf-8?B?U2IzK3h5eGhqYXdvRDJNc29QUzQwZnA1cGdnRjM0d2Urbk1yUEVDd2FKaXRv?=
 =?utf-8?B?Y3p1NUYxdTR2UzRrR2Z5RldoVitXbEFJL0VTKzNaNzgvTzFHald6bGgwK0NW?=
 =?utf-8?B?b0lXMDAxZ016Q09NSmdqWDc5OW5UM1d3bEVUZEFFbmVSZUVPcVRhcFpNUGRk?=
 =?utf-8?B?WDZ4R3B6UHZMODBDa24xeHBxMTRPdkgvTWQxOXlIUjhIOHFQaGY1TjlYRlBi?=
 =?utf-8?B?Y0hVandzQzFZWnhqSmZUSjZxOS9UVy9BUkpKR1cyODF2ZTg0Y3NNZ2F6QnMv?=
 =?utf-8?B?aTRCZjBac0pBdEVJQ0dJOVR6L1kvdEFZQThrTGVNMHYyVGFDZFduT0JLTHNL?=
 =?utf-8?B?NXlmRFNtYVFFT05FVHFqWkw3amNiV3Fxak45dTk5Q09DNUhsSUE4YlF1K0xt?=
 =?utf-8?B?NHovUC8rMlU3eCtSeGRWK0VCRkdwNkZnMWpHQ0JCdXBYbi9sQzk4VjZKM2pJ?=
 =?utf-8?B?SHV6M0dvdlovRGFPcDNsQk41YzlkTllRQkU5QktrVVZqVitCNFhsNWplRjlN?=
 =?utf-8?B?aEQ0Q1VYc005d0s2a3Z4ZVBieThldkxqY3JqcTRuTTZEYUdjTXNscVpIaUsr?=
 =?utf-8?B?alMzTndtVmNVakZOQW1admlqZC9aU2g5OWFHVGtWZmFtWko4S3FTa3JMTGs1?=
 =?utf-8?B?OTFPK1FWT0FEdHRNSTNMREZOUUwvakJ5NHhMMElwMURuR2dMMTYva2EwYkJH?=
 =?utf-8?B?Zm5ONDV0UlFLaFpWSmljaVBtVkQ2TCtMcll4a25kYTZ6Mk1CNlYxYmV0Rjcz?=
 =?utf-8?B?bzVvMFJyQ2NCV2hyNjAybHFUeG9ZOTR2REptUmJLRUJsbUxoaUlJUW5ZdlpS?=
 =?utf-8?B?MlNIKzVjaG9FZ0dDeDdGTDYwWXdVdFVtRjFLcTJrQW1wWkNYczNrMDkzVXVJ?=
 =?utf-8?B?bTUzMjlQVm9GK1NLNW1rU3M2Z3R5QmZaZyswYXZOV2x3MGJHcHc3RHozUXBP?=
 =?utf-8?B?YnI3QUs1T0ZSd0hKTVdzWXIzOTFZZEdyUlI1TVNxY3RkR3ZYV3JlRWdLVzlY?=
 =?utf-8?B?Ync1cVZNTWVSK0lFSSs1NkNLSVIxTjBjeEVrdTVlMkpFK1NNU08wQ3NqTUt2?=
 =?utf-8?B?ZmtWb1lReW5KQ013cWgwYmIraDJTcFFibWwyTkdhc1RUOE5jVmQwaHlzVEpK?=
 =?utf-8?B?NHB4aDFGZk5VbFRpajd5SnpRTFgrT1lQcHVudnpuVzZTaDZXMmsxRlRmbGZF?=
 =?utf-8?B?akhHSTFqbk9Bb0tiSlZvV1FlVmZWRlBmc0ZxcFhTcGZIQ1NTU0x0cVoxaXJn?=
 =?utf-8?B?R2xxc28rZDlkcjNpcFBJUWJLWFRlWThRYTluS0VhZTNWUVcrMXl5Y3BIRk1o?=
 =?utf-8?B?RWxlcjB1OXJWT2FMZHIrd1RFOWlKUGhBZGpLQUpDdDhTQ0RzY2s3L2pqcmtY?=
 =?utf-8?B?enBSL0tmVlNObmNDOC9NVVBYVWtXUTlhQlZCK2h4bWZPenNVWGVaRFM1Q2Fk?=
 =?utf-8?B?R05FYkdHQmx6WVJqQ293RVBtMEFQYkZnbUtRWDVWNUc5dHR2TmpCLytIYTk2?=
 =?utf-8?B?MitOejcwSEdHSVluL0xsWUVQMGtYZXhCNkFNc2tMUEJLUHpUSHhlNkNpUUVK?=
 =?utf-8?B?OHVDOVVGVWhNcGdCYkdPUkI1T1BEWGJicjVGdGVnYjRrc1daSTJwNnd2eXoy?=
 =?utf-8?B?akdvcHhIa1dwYU5HMmtZb3Y2ZWRUckp1WENXTkhOMGZrQldTbDZhMElLM0Vq?=
 =?utf-8?B?SEloZWtOaklpZlY5QmFwa2dpZi8zZlRmMnJZMG5Bd1dSNEx4Z1I0cVg1ZGRq?=
 =?utf-8?B?YkFsUVpFRDBLa2dEMlpxUTdXeG45RXRPbVpyVmEyMEdERFdKa29iMWpsUndO?=
 =?utf-8?B?WEt2WWpLR014YzJDdVNFNlZEREI0c3prMW43NGdkN2tORVJJWUllNloyaUNI?=
 =?utf-8?B?QXhwWTJyMTZvVFk5UlBkNkZNbDJqZ1FNK0kzaDM1dU9nNmlJc2JkZFZ2eGw2?=
 =?utf-8?Q?8zzHDN?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(7053199007)(7142099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?a2lTV3lIaUdNYzYxM3h0akkzVGxSbkxUK3lRc2xmL3B2MEIya1dLR0sxekZs?=
 =?utf-8?B?aFh4MFVncldoRk1iNVY1aWNIVXBRdEJFeUhpbHJnUkdOeDZ5UlFEQ0FrNXlr?=
 =?utf-8?B?U0tWMG8xY0lvSXVaZlo3YkJ1SFdpb0VqU3ExS0h1L2xVbGRQWHgzSmZsb29t?=
 =?utf-8?B?a0tKaXQ1OHhGeDdib2lERDd3R2pEUWFUQ1JpZ3dHYUZlNXhhZzJyL3c3VDha?=
 =?utf-8?B?bkhDU3ZvR0YyRjR6eTFDNHJqN1hsTzFxZWcxeHFpZEhKMmJ5ZHBtdHNYdXpo?=
 =?utf-8?B?MDRQamU1RFR5VnRGazgvWnkyZTFEeVdOUUpVRjNMNW1DcU9SM3RWL2J2MFdR?=
 =?utf-8?B?V1VJSHRQay9GWndvZlU4TTJHNlBOS29wanJYV3Vtemo5SjNFZGpYKzlIM2x3?=
 =?utf-8?B?RWpzYStDRkNJOGE2U3BObjlSV2psSjlPV3lSTU1NSUpPR2pVWW94UUx5ZDNl?=
 =?utf-8?B?LzFyZU44STNvNGFWc3VNWVRNMUk0OE9jNkd4bUZhMU1CWjU1SzhJOTBrbklr?=
 =?utf-8?B?N2R3d1FUaTVpMVdXWG5GZDREY0V3YVdVS3NnekdnWFplWGhpMDdyd20wM2sr?=
 =?utf-8?B?QUE3NitMSzRYbjc1d1lha3pINWlzRm1SZmx6dFZFOGh2NG9iL2lVdTBPZFk3?=
 =?utf-8?B?RXBzTVg2eVQxak85KytuR3VtUTVMZWlvRk01ajFnYkNmL1QrNU5JRS94NVQ0?=
 =?utf-8?B?ZjUwWlRLcDhSOEp4OWVKU25Lc2huRXpaWDlIR3ZuSnFkYzVhWjAxTFI3aXFz?=
 =?utf-8?B?TjBEdmtMMUZGVWFwMjVFeFUrbnVOM01vM1FCejJWcTFIeTB0WGlpMVh4NFc5?=
 =?utf-8?B?NVFMcnNVV1hwUUUyazkyQkQ0MDlTc09NM2wzRWxEbk5TSmsvaUtOZ0pibzRl?=
 =?utf-8?B?UVVRbzVCTGNDczFaZlhSQ3dEZFpkNGZsWisyNm11allod2o5UVE0RGN5QkJS?=
 =?utf-8?B?ZzBxZjBtVlhjYThrN3M2c3MrNTJHSTFRZU5wSUoybWV0OWoyV294c0QwaDFD?=
 =?utf-8?B?Y0tEeThRQnBFSm5KeFdjMnNKNTdtdkJTL0FZMHR0ZG9qRjcvVGxlb2FVNmJl?=
 =?utf-8?B?OEV5bWZ2RUdLYVZLOHI3eCszOFNMTERJeVJWL3hZdnhiRlIzTzhHZ0JlM2hr?=
 =?utf-8?B?YVFtNW5ieFNQUE9OU1pPeDJwenVNeUlxTldFL1Z4R0J5VHIvZFJKemY5cnFN?=
 =?utf-8?B?VG1tdURQeklnUnhTdFpOWUxDWjNpTlZYdFkzZS9PVDlmczU1L3BNbFdEaTBz?=
 =?utf-8?B?VnEvZ1RiYlBoeDVCaE9DSXNrS2MwT0RUMUxMby9FT3MzZmlBWGZ3dVNuV1Vn?=
 =?utf-8?B?Y1djVTFkSFZHdkV1aGtEMnJHbnRPcFVZNHlqcDA2SUxDZytVUmhCUS96UFdu?=
 =?utf-8?B?eCtURTM5cExQUnhkWE5RRCtpbUlLMTRnejBaaXgvaDhPMnhScjhMODFwdDR0?=
 =?utf-8?B?UzNZRWJJZHMzMkROcWM0bG95bnZFd1ZaWWdCdzBnRWpOVnAvZ2IxMzVSZmNN?=
 =?utf-8?B?eWdlVkUwVmZINzFWMVZNejhFK2I3Qmk4WjJJL1ZVQXZwcVBUWkp5bE95ME1q?=
 =?utf-8?B?RFFZZ2RucEJ4VTNPQ3BMdXRGRVpnK0w0NDdMUjI2YWlYNzVTQ1NtcXVyMGdx?=
 =?utf-8?B?L0hOb1J0TSt4ajlYR2NKU2srSUY5b1E0T1B2M3pwWHduMWVlQ2M4UStCaGZp?=
 =?utf-8?B?ajQxUExTQStEaXovblhBMkNyNk9TVDZ5S3VHM0RlYS9BRS9mWjVxZ00raVZx?=
 =?utf-8?B?eXcrTVFYbkllcllYNmdlMTVUb3NNMFNpWGo4WTE0Vk5SamY3KytzaHhLV3JE?=
 =?utf-8?B?TTcyNnFONkRZdUhZbG92d0g2VU5tdHFaaTFjenluRW4xNDNPeGU3WmIxYUZ4?=
 =?utf-8?B?Z1pvNjMzWXJLVFcxNlBVc3R3WDVnUTJYcy90TmdwT2VyVjAvNkVWWXZqWlhQ?=
 =?utf-8?B?bWNLS3RQY29OR0lzRWhNNWw1SUlHVG1HcU94WEZxN0xaWHJwbVgwQk1yUVlE?=
 =?utf-8?B?TWJ5d3VrKzhSNzhKOGM3VE5sYVY2Tm5TbXgwcHhVUWFCZ1pFb1ZNMTlBWlla?=
 =?utf-8?B?NXFteGV1a1dCclRWV0RjVDl0TmtjRmM2WEQyVDZweFV0KzZLaU9JaWoyMjNt?=
 =?utf-8?B?Si9LKzhwV2prQklFWUVPaEJuQmRjRUNPbVkzbEFtcThCSFZ6eis5UE9xajJ1?=
 =?utf-8?B?d2VPUTVLcVQraFJia2pEUUVqL2Z2L3RzbHlsd3RtWU9sUUE3amE4bTN0KzJC?=
 =?utf-8?B?Q0dWVStXK3VZaks4b3NVZ01uclV2ZEZLeC9EOTdpTkJSckUyTHZ5THByNzNZ?=
 =?utf-8?B?OEt1dlJyTlZCZHhDNUNGN2x2bGQyN1oxU01sT2daWWl2dGM3NEk0Z01IaXJk?=
 =?utf-8?Q?CkpbWXJZPympAVDMF591RkhoZoKYi2Ay/zu8r?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ede2a5b-e87a-4e3e-ac5d-08de63fe4c24
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 15:01:38.4507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gp67haQCcgovJBj2UisUTwd8CT7DVeOwKGzU4i9Q6LOWHYS0r4lGDe5TAtsrl3U52BNuXhbAjt1GU9APzcXanLCjS8swcuOCp/Pr1Ff5+E4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8036
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 04 Feb 2026 15:01:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18957

Hi Antonin,

On 2/4/26 11:03 AM, Antonin Godard via lists.yoctoproject.org wrote:
> Fix the switchers.js script of Bitbake to show what are the supported
> versions and be able to switch between them.
> 
> The default landing page is the stable branch and shows the BitBake
> version along with the corresponding Yocto Project codename. This
> hopefully makes it easier to remember the correspondance between the
> BitBake version and the Yocto Project version.
> 
> This works thanks to a set_versions.py script, which is largely inspired
> from yocto-docs. It reads the tags from the repository and tries to
> guess the currently checked out version of BitBake on which we are.
> 
> The "obsolete" warning is now also shown when browsing outdated manuals,
> meaning any version not part of activereleases in set_versions.py.
> 
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
> Note: This will be accompanied by a patch to adapt the Autobuilder to
> generate this file for each release.
> ---
> Changes in v2:
> - Remove environment information grabbing mechanism, making this fully
>    standalone.
> - Link to v1: https://lore.kernel.org/r/20250915-fix-switchers-js-v1-0-523ef53fe802@bootlin.com
> ---
>   doc/.gitignore                    |   2 +
>   doc/Makefile                      |   3 +-
>   doc/bitbake.yaml.in               |   1 +
>   doc/conf.py                       |  10 +-
>   doc/set_versions.py               | 155 ++++++++++++++++++++++++
>   doc/sphinx-static/switchers.js    | 233 -----------------------------------
>   doc/sphinx-static/switchers.js.in | 247 ++++++++++++++++++++++++++++++++++++++
>   7 files changed, 416 insertions(+), 235 deletions(-)
> 
> diff --git a/doc/.gitignore b/doc/.gitignore
> index 69fa449dd96..40ebe76c088 100644
> --- a/doc/.gitignore
> +++ b/doc/.gitignore
> @@ -1 +1,3 @@
>   _build/
> +sphinx-static/switchers.js
> +bitbake.yaml
> diff --git a/doc/Makefile b/doc/Makefile
> index 996f01b7d5c..cdb054d3a52 100644
> --- a/doc/Makefile
> +++ b/doc/Makefile
> @@ -27,9 +27,10 @@ publish: Makefile html singlehtml
>   	sed -i -e 's@index.html#@singleindex.html#@g' $(BUILDDIR)/$(DESTDIR)/singleindex.html
>   
>   clean:
> -	@rm -rf $(BUILDDIR)
> +	@rm -rf $(BUILDDIR) sphinx-static/switchers.js bitbake.yaml
>   
>   # Catch-all target: route all unknown targets to Sphinx using the new
>   # "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
>   %: Makefile
> +	$(SOURCEDIR)/set_versions.py
>   	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
> diff --git a/doc/bitbake.yaml.in b/doc/bitbake.yaml.in
> new file mode 100644
> index 00000000000..4085582df60
> --- /dev/null
> +++ b/doc/bitbake.yaml.in
> @@ -0,0 +1 @@
> +DOCCONF_VERSION : "dev"
> diff --git a/doc/conf.py b/doc/conf.py
> index bce386624e2..5b28808c590 100644
> --- a/doc/conf.py
> +++ b/doc/conf.py
> @@ -14,17 +14,25 @@
>   # import sys
>   # sys.path.insert(0, os.path.abspath('.'))
>   
> +import os

I don't see it being used?

>   import sys
>   import datetime
> +import yaml
>   
>   from pathlib import Path
>   
> -current_version = "dev"
> +current_version = 'dev'

Unnecessary noise.

> +
> +with open("bitbake.yaml") as data:
> +    buff = data.read()
> +    subst_vars = yaml.safe_load(buff)
> +    current_version = subst_vars["DOCCONF_VERSION"]
>   
>   # String used in sidebar
>   version = 'Version: ' + current_version
>   if current_version == 'dev':
>       version = 'Version: Current Development'
> +

Ditto.

>   # Version seen in documentation_options.js and hence in js switchers code
>   release = current_version
>   
> diff --git a/doc/set_versions.py b/doc/set_versions.py
> new file mode 100755
> index 00000000000..63fba2fe948
> --- /dev/null
> +++ b/doc/set_versions.py
> @@ -0,0 +1,155 @@
> +#!/usr/bin/env python3
> +#
> +# This is a minimal version of the set_versions.py from yocto-docs,
> +# use to replace VERSIONS_PLACEHOLDER in switchers.js.in by a list defined below
> +# with BITBAKE_ACTIVE_RELEASES in the environment.
> +#

Where?

> +# When the documentation is built with the autobuilder, the versions are
> +# calculated based on the info found in set_versions.py from yocto-docs.
> +#
> +# Copyright Linux Foundation
> +# Author: Antonin Godard <antonin.godard@bootlin.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +import collections
> +import itertools
> +import re
> +import os
> +import subprocess
> +import sys
> +

Sort alphabetically please.

> +from packaging.version import Version
> +from typing import Tuple
> +
> +devbranch = "2.18"
> +ltsseries = ["2.8", "2.0"]
> +activereleases = ["2.16"] + ltsseries
> +
> +yocto_mapping = {
> +    "2.18": "wrynose",
> +    "2.16": "whinlatter",
> +    "2.12": "walnascar",
> +    "2.10": "styhead",
> +    "2.8": "scarthgap",
> +    "2.6": "nanbield",
> +    "2.4": "mickledore",
> +    "2.2": "langdale",
> +    "2.0": "kirkstone",
> +    "1.52": "honister",
> +    "1.50": "hardknott",
> +    "1.48": "gatesgarth",
> +    "1.46": "dunfell",
> +}
> +
> +bbver_re = re.compile(r"^[0-9]+\.[0-9]+\.[0-9]+$")
> +ourversion = None
> +
> +# Test that we are building from a Git repository
> +try:
> +    subprocess.run(["git", "rev-parse", "--is-inside-work-tree"],
> +                   stdout=subprocess.PIPE, stderr=subprocess.PIPE, check=True)
> +except subprocess.CalledProcessError:
> +    sys.exit("Building bitbake's documentation must be done from its Git repository.\n"
> +             "Clone the repository with the following command:\n"
> +             "git clone https://git.openembedded.org/bitbake ")
> +
> +# Test tags exist and inform the user to fetch if not
> +try:
> +    subprocess.run(["git", "show", f"{ltsseries[0]}.0"],
> +                   stdout=subprocess.PIPE, stderr=subprocess.PIPE, check=True)
> +except subprocess.CalledProcessError:
> +    sys.exit("Please run 'git fetch --tags' before building the documentation")
> +
> +
> +# Try and figure out what we are
> +tags = subprocess.run(["git", "tag", "--points-at", "HEAD"],
> +                      stdout=subprocess.PIPE, stderr=subprocess.PIPE,
> +                      universal_newlines=True).stdout
> +for t in tags.split():
> +    if re.match(bbver_re, t):
> +        ourversion = t

We can break here as we can only match one X.Y.Z tag for a given commit 
hash.

> +
> +if ourversion:
> +    # We're a tagged release
> +    components = ourversion.split(".")
> +    ourseries = f"{components[0]}.{components[1]}"
> +else:
> +    # We're floating on a branch
> +    branch = subprocess.run(["git", "branch", "--show-current"],
> +                            stdout=subprocess.PIPE, stderr=subprocess.PIPE,
> +                            universal_newlines=True).stdout.strip()
> +
> +    if branch == "" or branch not in list(yocto_mapping.keys()) + ["master", "master-next"]:
> +        # We're not on a known release branch so we have to guess. Compare the
> +        # numbers of commits from each release branch and assume the smallest
> +        # number of commits is the one we're based off
> +        possible_branch = None
> +        branch_count = 0
> +        for b in itertools.chain(yocto_mapping.keys(), ["master"]):
> +            result = subprocess.run(["git", "log", "--format=oneline", "HEAD..origin/" + b],
> +                                    stdout=subprocess.PIPE, stderr=subprocess.PIPE,
> +                                    universal_newlines=True)
> +            if result.returncode == 0:
> +                count = result.stdout.count('\n')
> +                if not possible_branch or count < branch_count:
> +                    print("Branch %s has count %s" % (b, count))
> +                    possible_branch = b
> +                    branch_count = count
> +        if possible_branch:
> +            branch = possible_branch
> +        else:
> +            branch = "master"
> +        print("Nearest release branch estimated to be %s" % branch)
> +
> +    if branch == "master":
> +        ourversion = "dev"
> +        ourseries = devbranch
> +    elif branch == "master-next":
> +        ourversion = "next"
> +        ourseries = devbranch
> +    else:
> +        ourversion = branch
> +        head_commit = subprocess.run(["git", "rev-parse", "--short", "HEAD"],
> +                                     stdout=subprocess.PIPE, stderr=subprocess.PIPE,
> +                                     universal_newlines=True).stdout.strip()
> +        branch_commit = subprocess.run(["git", "rev-parse", "--short", branch],
> +                                        stdout=subprocess.PIPE, stderr=subprocess.PIPE,
> +                                        universal_newlines=True).stdout.strip()
> +        if head_commit != branch_commit:
> +            ourversion += f" ({head_commit})"
> +        ourseries = branch
> +
> +print("Version calculated to be %s" % ourversion)
> +print("Series calculated to be %s" % ourseries)
> +
> +replacements = {
> +    "DOCCONF_VERSION": ourversion,
> +}
> +
> +if os.path.exists("bitbake.yaml.in"):
> +    with open("bitbake.yaml.in", "r") as r, open("bitbake.yaml", "w") as w:
> +        lines = r.readlines()
> +        for line in lines:
> +            data = line.split(":")
> +            k = data[0].strip()
> +            if k in replacements:
> +                w.write("%s : \"%s\"\n" % (k, replacements[k]))
> +            else:
> +                w.write(line)
> +
> +    print("bitbake.yaml generated from bitbake.yaml.in")
> +
> +with open("sphinx-static/switchers.js.in", "r") as r, \
> +     open("sphinx-static/switchers.js", "w") as w:
> +    lines = r.readlines()
> +    for line in lines:
> +        if "VERSIONS_PLACEHOLDER" in line:
> +            if ourversion != "dev":
> +                w.write(f"    'dev': 'Unstable (dev)',\n")
> +            for series in activereleases:
> +                w.write(f"    '{series}': '{series} ({yocto_mapping[series]})',\n")

Why is this different from yp-docs? We don't handle showing the current 
series (ourseries)/version (ourversion) if it's outdated anymore?

To answer Richard on the other thread, we use YAML because JSON doesn't 
allow comments. Also, because we used to want multiline variables (see 
https://yaml-multiline.info/) which aren't supported in JSON, but those 
are gone since 8d993022c2ae ("docs: use literalinclude for system 
requirements"). Not sure we can get rid of it for yp-docs as we only 
override *some* variables in this file by set_versions.py so the 
autobuilder won't replace poky.yaml.in, and the YAML is consumed by 
sphinx/yocto-vars.py.

If we don't plan on having comments in this file *ever*, then the YAML 
dependency isn't necessary.

Another option is INI and use configparser, c.f. 
https://docs.python.org/3/library/configparser.html

It seems that INI supports the ':' as key-value delimiter as well as 
multiline strings (but not the way we used it for YAML!), so it could be 
a drop-in replacement. We could even simply write to the file with 
configparser.write() (though that will drop the in-file comments).

Cheers,
Quentin

