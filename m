Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BA1D18135
	for <webhook@archiver.kernel.org>; Mon, 14 Oct 2024 17:19:24 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.47])
 by mx.groups.io with SMTP id smtpd.web10.558.1728926358947170024
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 14 Oct 2024 10:19:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=KkdRT7vq;
 spf=pass (domain: cherry.de, ip: 52.101.69.47, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DE2EGR1zHqHAuA+Tmm7h1AkQuQ1eCFcCX96DMAf9UHBrni1dCj75tBp8UNoLDcY2GrdmbeHUZpeep3IEyndVgprJttTgoe14+R4XHgeedVuRVzvE2BBmRzqpXQrZHK7a2ccNjqedQZmYctBJ5KS0BRzJMpB/Ogz0ywyrisJKdTD9Lnbr15AmSIcOisj/i5xzUgut9x5iZsQDZbkMADb6VXICXY9TneCTIFvjTR3f+N5P7ougT19cu5CtY4WZZja3ojL0O5CgE4mrAZYj9kN1LAZDvviT+TNQkGH/i7e+R2iD4noLfvG1YNVei3HRYquBRERm3Q/hOix/vxps4GbtYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agiomTSQEtodnhF5cb0GxV3pJTryrKmC1E/B67L7NLA=;
 b=Z84GHwjQtT4LH6jl00TOyM+0opOffupkAmG9KqEehGLKx9sv+xDziDs2XeEvN63RXlLKb0CASPNznGyNw9Kg92WaWaFOrJ/+To1I8rK8jIZN7SroOkH4Ql5Zt+xsK7QC9cIwzbZZ759cPe8QB44La34oE7Zm63MtbW2AFF1DftJ8fmPD7zFi2OQjBJ1+RowQkCos3Gg9Dg+9vWxuKjFxcMCjyp5Cs3y7JP7Q43SzOPQv9/JW++D+nSDz0Z4PEagCZXRCPWjCsMEBAGpKOxWUELisfx35mR5foE0hNFYxgAABVl2RosAz3/z0WmkVraR30DWokB+0QqYpjDP1yICohQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agiomTSQEtodnhF5cb0GxV3pJTryrKmC1E/B67L7NLA=;
 b=KkdRT7vqdVAp2U+vs8Mfgd71OP/1gTNjF0RTBkTHO3vd7Xj2eJqxhQxWeOnalTaVW/4q8NhBCAYs8hQacOp2z+qnC0jw7mZk9yJtRyrYyVJl4zrGjeBb8U+HUsiVIZMdCBRitYKAb5/2Wl0NuzYFpOLwtpj8NObnOb4ecTD6x7o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GVXPR04MB10945.eurprd04.prod.outlook.com (2603:10a6:150:21e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 17:19:15 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 17:19:15 +0000
Message-ID: <84fbee60-100b-44c9-b02f-50fd22d9ab36@cherry.de>
Date: Mon, 14 Oct 2024 19:19:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] contrib/hashserv/Dockerfile: Add libgcc
 as dependency
To: riemensjesse@gmail.com, bitbake-devel@lists.openembedded.org
References: <20241014151052.866580-1-j.riemens@alvatechnology.nl>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241014151052.866580-1-j.riemens@alvatechnology.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0035.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::19) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GVXPR04MB10945:EE_
X-MS-Office365-Filtering-Correlation-Id: 6066d166-267b-47ab-77d4-08dcec74540b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dDFFMWFDVmNlVFYxQWF2MjN5cE8zZVRkaTFxUXJjSDRpOERibnRocmVoczdx?=
 =?utf-8?B?bkxYanplWnN0SE5KenVJUFhpQlArVmJBVDJvSzg0TXRDd1gzUzVLOHAxWFR4?=
 =?utf-8?B?Njk5dHZ4YUpERmkvRmYzZFZyMnRwRmQzWEZabzQwNzRCd1Rycm1XOW1wS3hn?=
 =?utf-8?B?c0MzYUhkVnFzbjRnd1VqWGRzb0N0VjNreVhrRVhhUS9ac2JLb25vdTdOYWpw?=
 =?utf-8?B?TWt0bmRGZFNMZnZ5UEFjR3d3ZExUYlgrNW5RMzlXd1lyU005K0ZYM2VyUzlB?=
 =?utf-8?B?SU56cXhCRk5lWmJseUZKazF3Y1RzUzJvbHRVYVA2aitwSjRVR25pb1JKQmow?=
 =?utf-8?B?RFQ4VHd6NCszQmtSUTY5cjRCMWFLd2VxUzIyZktuUVhiWXJtWTh4T0pKbC9a?=
 =?utf-8?B?SkgvRFlBckhpZWlmZld2SXhLSVdBYjI4N3J3eGQzeUd0eXNRMXNBL3JQMitP?=
 =?utf-8?B?YUhYem82Nk80d1R2SG5rRGJmWTJpRTJSMWJvdS9CTFNiVW8rRHdBbms3Ykcw?=
 =?utf-8?B?MEJQZjNmRGk3Tm85RVNuYmhFWFdBV1RCa0FRdFBCeCtWSzZOWEhoQ2lYNml5?=
 =?utf-8?B?V1I4OFVUOXlkU05XeVNhbVEwUTdJNVlwSkd4TVhrQjgvc1JFNFNva2ZrbjJJ?=
 =?utf-8?B?RHVzd3NuOGNVM3JYRTNnN2N1QitDSlZLeDNHb09KNU5MT1lHN0pBTEFWaW9T?=
 =?utf-8?B?RHNjbnU4RW50dnlyQTRocTl4TUp6ZDJWNHN4TjF1a1JLVE51TCtIWFJueWxz?=
 =?utf-8?B?VXlyZEQwTk1ORDFFRU5nUmtPVFBXUWtFRFpLTUxPN3UzTGV3VElqdjhuRmwy?=
 =?utf-8?B?Qi8vZ2xTamFuK21lUlRrMTF2aVBtRlRVQ3RBRnJYVzZnb3JyTmFaeld2SUJn?=
 =?utf-8?B?a1o5NzJFYm15NVMwWWp5OFlPc09kanNJcXRKOWF0VnVxOUF2MmU1Vll0SXVY?=
 =?utf-8?B?aGUxVXNnR3ZGcTNVYUttYWYwS1Rxa3BWMTVFaTNWTDQwVnpLbjhpYiszMS9i?=
 =?utf-8?B?amsvNkhRTmNxcVJGWWZTb3dDMmZOZDRDM2tFRDhRQkU1NVFyN1pndGJJUytO?=
 =?utf-8?B?dnEydUFRcnZGOXJsWW5TV2VQK0pUNllHalJJY1R3R0doOGFMbVdER2kraEpK?=
 =?utf-8?B?TFU2dUdVaE4rY1NVQU1MVHM2b2ZRall1dkFzVUl5c0phNjRTZUNsWjNaZ3dN?=
 =?utf-8?B?R1pRNE5XdElKcFZJWlk5enB2WFVWQmNxd0NzamxOOVlkWHUyU3p0b1U5TU05?=
 =?utf-8?B?U2I2YSsvZFZWYTYza2pkK0dZVUMyVnIyeU03OTExUkJCbFV3UkJsK29OTFN2?=
 =?utf-8?B?em9pRzZTS0U2cGRJN0VzWkZ1R3R0TGt2WVBySmlQRnd2c2tkWGVKdXoybGdx?=
 =?utf-8?B?S1p6TEdsMWg0blQyWHMxclMzR0xESTE3NDBZYlRKb1g4NDV2SnNXZzlDK3d1?=
 =?utf-8?B?NllTWEFoOU81V0szaWxVRU5MY0hma3V4aWJyYy8wS1A5bnNZWTdEVjJUc2pp?=
 =?utf-8?B?RlgzRzRFZTUvSXltVGhQd1VXS0ZRcURjS3hRQy8vWXFQcTduMFhpZWxYODR6?=
 =?utf-8?B?dlhpZUxmQmlIMWRSaW11QUE1REFHNW10MWFWU21kN0o3eVFtbVo1V0lEMGty?=
 =?utf-8?Q?coMd3j6/PHwiU0Cs4Haco8fesZFd/H9ICgx+YVBBuGZw=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SWNNQVhSSDNvdGgwVlRMb2pyeXZVam5vNllLM1dXdFBiejZxTDFVWXVNc09w?=
 =?utf-8?B?aEtmUTNGOENtV3V2d2NVTTJTSHNMTDErZmRyQlphT1RmNnlWMFJGWDNDR2FU?=
 =?utf-8?B?VGMvZDBRVEcvSFhKVDNQMk1ldW1SbDBtQmNtYUhjdlBCNThid0kvNFYzMW5u?=
 =?utf-8?B?L0xFRTFJdmE0V2g1MzRRQ2VkS2xOKy9tdDdMN0NkSVdTSGFBUHU1V1NXNkF5?=
 =?utf-8?B?Wlg2dWE1T3VOSy9NZGVDT016Sk5ERzVjYWxjQ01HNlpXbGl5WUxPQmdUL0xU?=
 =?utf-8?B?UGFjMzdNK2w5ZXFTdG1IY1Y5alNKVzBWSmNLdEZtZ0FEM2lWdUttUldRcUVV?=
 =?utf-8?B?N2xDQnIySHBuLytkeGM4Uk9OdjUvaTkrakI4N1BXMHlpUC9mZ2krYmxvWEc2?=
 =?utf-8?B?WXJXNlhKUVVMNmV3SlZqQy9KOUM2T0c1MDJnL3ZlRzV5Q1hnUC9UM1ZmbGFT?=
 =?utf-8?B?UFhrUDFEczJGb0swc0ZVbHhlYlZJdktRK1NMR2h3NVdpdDlJVXpLTC9DUjAw?=
 =?utf-8?B?aXV1S1cvNGpUOU9iSDVIK2QyM0pqRm5URGhaQWZiclpjdkNPeHN4WWFFRnVx?=
 =?utf-8?B?d25jSk1FbUpLakZZT1hoMnc4OUcxUUhJUlQ4OG5zWTIxUjh5NVZqS1NIaVpt?=
 =?utf-8?B?cDkvN0dEbzJSUzJyeWNhODhTUDVkOStMQnEzMzFiUTdncDJOcWdNc2ZWMFp5?=
 =?utf-8?B?RDVwdUg1enF6NDUyUDIwL2ZHaFk0MFpkK2dsUDBpRHNaMlZ2YlpOSUQ1b2VN?=
 =?utf-8?B?RnRkN2FhWGFzeFByQXZuOTVjVkV5aS93M2JBTkVRRW5yNTZRVnZRMy9nc0hw?=
 =?utf-8?B?UEhYQ2YzcE51ejZuelBCVmNXUDNpNk9JL3dTS09WdlBjbTFnbTM0ZzV6cGxx?=
 =?utf-8?B?bVhPa2hXRG00MXZyL3pnTTZqMGZ6OVl1RUlFOVdha29FdEdRWC9OL2pVSU1J?=
 =?utf-8?B?M0RxU0dJMnRPL0k3ekN4YnJSS0lNVWJwVFRDRElyZ1E0OHFBdVltQXZLTytX?=
 =?utf-8?B?TGdHUjdJRTlUK0tXaWJkd1E1aDVIK0s2WXRkT3lzc2JUWUpaczhocGNQR2N4?=
 =?utf-8?B?MUpvYmlWakZ4YmlDVWo3TDVwU1IrSDRvcnBKNTc3Ymw4ZGdBRHVuK0ttWGNB?=
 =?utf-8?B?N3F3UCtUdFhrV2w5VjFyenpzS0wrU1h4My8ybHJUT0pySXVDR0l1SXBrZWgz?=
 =?utf-8?B?MUlnYnRPYjNRaTd1L202bUdndmFoVTNlWkRNa29rU2kxK2tFRCswK0VqZFBN?=
 =?utf-8?B?KzdkL1QvbE1CRUgvbHptTmQrQStJSHMvb2dhU3V0b2NXbTl0YmxLalkyTFFV?=
 =?utf-8?B?dTBjdkJycGwvTUIzYlJYbVhjWjRURFNXdWMvT0ZsdEcxa1E2Tm5YMDczcngv?=
 =?utf-8?B?N280YUlQOGIzQ3ZTTjAycjNLYnduR3laWXppbjVXajI3YkcxZkxlQitvUEdG?=
 =?utf-8?B?U1lDK3ZLZWFQV3ZEK1hJMnBPTXB0RGRzaFdOSVVqNEhlQmxOK3VGWjRCSWQ5?=
 =?utf-8?B?Mi9ZUXg3a0UwbHU2MkhWZUJaZXB6YnBXWFl6bERqRmhNczRRWGdhelJOMytT?=
 =?utf-8?B?djZSRVcvdEI0ZlVnSEwrOFlVRkVaV3dGYU1oNllUWXY3SkI2ZkwwdThLSkZY?=
 =?utf-8?B?ZklzeWpudFRwKzFSK2NaUTFTb21sRlZZSkxZMXBvV2MxU2pXblFTTCsxV2FG?=
 =?utf-8?B?Q2xoLzBXUEdaNlZ3a0Y0UmVqWXZjZW5tQnRWMFMzWHRiNmlKbndaN3NwOUFK?=
 =?utf-8?B?ZlFzZ3E3d3VsWEQ2b040aS9zczJzWTlsN3c5QlVtckRERG1HTS9TZTRvbkdm?=
 =?utf-8?B?YnFFaUxpYmJzL2U4TTV3eDVPS2JJNnk1Y1NlaEltdVhnYXRCdkZ6WVF3ZGhp?=
 =?utf-8?B?aVBlRCtkb1RWcEU2ZlZuUkZ0V0RiV1lNNFo5MnFyL2hzelVVQ0FDbFN4cXd6?=
 =?utf-8?B?YU9XTSt2cHcxYXdZUmFOWi9RZEw2VWs5RlpVMXMyWGQ1SGhiSWlrd0ZpbU4r?=
 =?utf-8?B?QnVxZ0VZMXF4N3pBK1RQa0g0dEppbnNQSnJhbUd1ZnVWUnMyTjZzK2hIQWtO?=
 =?utf-8?B?aDhnZkJNVVNUOHVwQkZLcjBmelNMNVBVMWtnbzhpRG1WNzNNaEFDWVYzbGRU?=
 =?utf-8?B?bHd5enZJVWxZV0VHNjJWZW9sS0tQbEU3TW1pZ21oQmUzZTBRUTZSWUxIWFZ5?=
 =?utf-8?B?dlE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6066d166-267b-47ab-77d4-08dcec74540b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 17:19:15.2810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BmtDv7py3++frdwqJana31nwlWATjBktNtQ1thFHhIfsAiCxn3QxmcAmpNYb48Heh5uPp+yQlY6RqN1H6Uk8PI9Qgt3to1wJAnrjy58ga6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10945
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 14 Oct 2024 17:19:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16682

Hi Jesse,

On 10/14/24 5:10 PM, Jesse Riemens via lists.openembedded.org wrote:
> [You don't often get email from riemensjesse=gmail.com@lists.openembedded.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> From: Jesse Riemens <riemensjesse@gmail.com>
> 

We're missing two things here:
1) a commit message explaining why this is required,
2) your Signed-off-by because you agree to the Developer's Certificate 
of Origin, c.f. 
https://docs.yoctoproject.org/contributor-guide/submit-changes.html

Cheers,
Quentin

