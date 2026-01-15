Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BB6D4117A
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 12:03:23 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.34121.1768478594420275213
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Jan 2026 04:03:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=dE6V3eZv;
 spf=pass (domain: cherry.de, ip: 52.101.65.53, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1aTWyWO4sfPxTasNspgeVHyzY7IHCjRs4pOczxIlaGIWMNOzLnKWJNMy1J4wBDfwJnOCd/FOowkXbqwTq/FOenAseq8M2ifMGIlc/5OhfbBRfpDjvxLP+4m7u+iFZMy89zOTz/63yp3dk1Y8nw2CUmbVSMGdmM1lNI3oqqf8o+7b35ciemQK7eW+3vN20DrtATl5gCtmdQNoHri1xFsPMCUmJ3I+11XWN7SGj76c3NAjRUWJQGuTOjtl2LGAlyWWMIcHWXg76SeLGrSNksAAmEbxQ83zkV4iVWsOEsdgwnkkli7Av9NwFqzDre9tIMQ4lv+XBfUKQ3bAHX22wxegQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4085rlZY+S8clrUnZ4SUlfPq1kUT4v3tjADLv4QpGIk=;
 b=iwHclU6INRMBQ8vXoyuP4DoJEZc47G/aq8EZQfMG+hTtL4SggcNMlLv1quCN8oNCbbUviVa+zF7uvD/Ng7NBdU3rwEz2WxQhwU8V7oKIkpPcEY2LASG86TA31NoAb/eqRUOLJeJx8RoONsD0B5VCYAHVV/ciEdZ7g+gFnCNh6Gjb2MLzrWrnS+HVgFyMXBBoOyLTTtmO2e5pwVHYRz/JrkqEFFyvl4VC9Yal5yfpPEUpoTvAI4KW9QWxTJaQnTPZwYFFYvS3ZtMy9h1elYrtm/WPojqnWIGabSNlAXMjBc5wdFR9211KwxQLjuSDT8Uggm0WZYsZTrncOpmX5hlkBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4085rlZY+S8clrUnZ4SUlfPq1kUT4v3tjADLv4QpGIk=;
 b=dE6V3eZvKJjvM2+Q82Zp5+CtmHrNjl+P7uDriJnRBgP+EhIdt3X04e5VWeXCkqwMdytB3MVaKt28JQxh0eWEamaAlfTyro8YLARj6T+Uw2TTC+c50iRrcmGopYfngvzOF41ihbOxOqM1BFTA+sV8YHbt2TQPkhbnhBTEa5uORtQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AM9PR04MB8682.eurprd04.prod.outlook.com (2603:10a6:20b:43d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Thu, 15 Jan
 2026 12:03:10 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 12:03:10 +0000
Message-ID: <61242019-6995-4c52-b36d-4c427082ef6d@cherry.de>
Date: Thu, 15 Jan 2026 13:03:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH 2/5] bitbake-setup: ensure paths with
 timestamps in them are unique
To: alex.kanavin@gmail.com, bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
References: <20260109132000.2372791-1-alex.kanavin@gmail.com>
 <20260109132000.2372791-2-alex.kanavin@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260109132000.2372791-2-alex.kanavin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::7) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AM9PR04MB8682:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bc7267f-794b-433a-ca19-08de542e0d3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NnE5SFIwU1V3cTBSRWVpN0N4ekNSUklydC9ISEtCUVVOZTd3djI2TjZJVVg1?=
 =?utf-8?B?akZINFQ0dXVzRm55aEJYbGFyNzRqUE5tbU1RREdkUnlJb2xxbyszdGROYjE0?=
 =?utf-8?B?bDd4ZkZ0N1dybzJQbE5MamFSanh5UTh3SGJOVngrVUJRWXRZelU2QmR0SEsv?=
 =?utf-8?B?SXhIdDNwQnprSzFhbitTRW92Y05XbVhJNDJVQ0JTZWhyVnV0OEtEUG51ZVg5?=
 =?utf-8?B?U0VNNFNoc2xtMTNObDJZbmVDdGsvRVltZHI4UHkydUd1Mms2WWlLT2N0cWV4?=
 =?utf-8?B?ZjNuNU9STHhuY2JmcTJXaVh4Q3c5cTBGNUVzOXVEMTJNT0hHUnJHTks5YlBZ?=
 =?utf-8?B?eXdBT1MyQ2Y4MW05bGtoYVJCNU1aZmJhOU0zazJ4Yk9pYlBQTjJNWmVOdHNB?=
 =?utf-8?B?bTZ5Q1h0czdHMW1pcGFEUENXdEVjV3dVREJzSkU1SUxkc2pzNnJrVXNZVFo4?=
 =?utf-8?B?RjFwS2tFNkt5U3A4M1ArSHJ5aHgzdW1XamFPSUxSOG1IZy9qNEVXQjk3MTV5?=
 =?utf-8?B?emJSbS9WK1lhVmlnMytZcXNUMW5EaGpRT1c5MFhGemFlMUNwOTlVZVBPOFBv?=
 =?utf-8?B?VGR1NUN1VmhTaTdTaTVvcUY5UmlvQmNuT0hNSFVGMEczTVAxeGpPVDhIZXhK?=
 =?utf-8?B?ODYyYXMyWklPWFB6Tmk1RWFCYjZ0RklFck9pUWNOMWFBZVBCZkRaaU1CZzRa?=
 =?utf-8?B?b01lZWp1SWdNUFlJZVVDMks1REdmZzlDMDB0WEJsSHRQbGEvUWFhdnJjb0lr?=
 =?utf-8?B?cEs0c1NlSkVrZUN0STJPWEJKRVZIeFBSWkRLcTY0a0R6Yk52cjRJSjFSNTk4?=
 =?utf-8?B?ME1RZjQ2d1FLWUFTVitieHRFbGRBWko3aDdOVFh3S2tkYTdqSnkwSmtjclIy?=
 =?utf-8?B?T3NtQ1NrVzU3VUtBZ3ZxSzlDTklVMVpFVi9NYW5xVUFxT1lzZkhpenZ3Nnk5?=
 =?utf-8?B?WTRWU2hRU2VoMUZmNHY5emRUZzNyTzNNNDhFbEVkakk2T0hWYm03VDBjenhx?=
 =?utf-8?B?RnB3N2w1Qm9ibFdTcXM0WENZWklRWExFK2VST0dRVlhGd2FpeG1NUHlxcklS?=
 =?utf-8?B?ZUxKTkUwQTYrUVVBcktIU09JcFVnV1EwUXpDd3AzZlhlczQ1b1hwRDZBRDdD?=
 =?utf-8?B?Q2tqWm1HQjFEUUlWTXJORDR1L1FaSy9YTHdXRmNpUHI4OTIrazVNZkFFWkxY?=
 =?utf-8?B?TGU5dXpPN09oR3k3djVaU3c0Q3hlb0xvQkZSVU01b1lWL0VwVkZrcTc3UUEw?=
 =?utf-8?B?M1FQRmJnWlFweExHbWEvZGY1aGdnRmRNY1NWOTFYQ1ZYblliY2xuSndzSFEr?=
 =?utf-8?B?WDJrcEd4V2NwVmpQRFdwNi8xWDM2SGF3OWVBYk1VZlV5cDdkVU1XMVhJYlZP?=
 =?utf-8?B?dm13QnF1VitNUGk3Smp1MkU1NG5CMEIyTXFEY3ppcFFHTHJ1MGpHWVhObWsy?=
 =?utf-8?B?d1BoeGNtQkMzN3hqemVyVXpGTzA2RG96bkNOMUdZT2FmbDBYUFNoZk9yVXJo?=
 =?utf-8?B?Y1VnZEQ5dFY0VDRCZ0N6QkZVRHFWOEk3a082NVNwYnNBQXhwcnEzS0IwN1hl?=
 =?utf-8?B?ZktMK09xQ2Ewd21CdFRKY3IyZFJYQ28xVjlSRk9taUJveVRUYnpVYjFiZ1dZ?=
 =?utf-8?B?LzZmQUVyMlB4RW4xQVZDNDNKK2RYTzdRbHcwWHMvTUpxeGY4QUZWZmdGRUxz?=
 =?utf-8?B?MUNDWjViRmRhTjBsY20rT0ZXcVNKdldOUGlhamJ3N2JIcHYzdDQ3clhxc1FY?=
 =?utf-8?B?R2svM2FhcGxLYmhqdmZMRnB0QXlOSS8xa1hnRGpDbHdDNHNKRmpWQXkyUHcz?=
 =?utf-8?B?eXhUeW1qS0dWa0tOWEVsSlVlcFJ2dVBrYjc3NFUyTUxIZ1VXRFdLVE82MVVD?=
 =?utf-8?B?TDZNOVRLZGVCRVBxVFcyRk9ndGdQbVpRM0g3QXJCUUE1RUxnbSs4cmJiaklD?=
 =?utf-8?B?RC9HNVBPMzNvN2tHTXVFOVc0cmVjTzU2aGtFRUFQRGt2TGdRM2ptR3dVTC85?=
 =?utf-8?B?bXRVZW8rTGZNZW42aDNLS0trWkpvU0dmNGR6NHpldUtUUDAvOE9hTWVlNVN4?=
 =?utf-8?B?dGJZc1RPMnBsY2hranEzd1F2M25aclZtUEhFb2E1S1VDcVZYUmNsS3EzN0NL?=
 =?utf-8?Q?5d50=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RlJ3TUc0bGJzMjlNc2RYazRzOXcwLzcvNFBtVElxY0hmdGEvSUt1YnMvN0R1?=
 =?utf-8?B?RENQb1dySE1MQXRPYzNHSW5teG9NSTBmTVNFR2tsOFRWQmZQc1FkRkV5Y1Bt?=
 =?utf-8?B?VjFpNHdTdDlJTDFKR0lpcU1xY1U3Y05rY083WGdQdjBkRHpVaVhDeG54MURy?=
 =?utf-8?B?ZEp0R1NaOWZEZWk0dWFQbksxUXdyS0FuRDFOaHdwZDU1cVZzZnNUemhySzZk?=
 =?utf-8?B?UmVJZGNmemxENFQwZCtoS0NYODFKeG0yVnQydXA1YUxmOFlGcERvMGw5eGlU?=
 =?utf-8?B?RGJUbThMWjhoanUrOTNvTUh0VXFYbUgrZ3phMzkwdVZHbUFrRDVNcVc5My81?=
 =?utf-8?B?R0pNWTZIUTIvUlZNblJUYlpYeDdPOHdmUnZrRFVNTFNHcGtzQ0lEWWlKUjNB?=
 =?utf-8?B?VVQzc05qdEVCWTl1cG90ZTJreVdueU1iQTE4RGN1Mk1QV0s2MFVsaDNaUzQv?=
 =?utf-8?B?bE9sUi9ud1pIMWV6TmZUTzhFQkFPd0NHMk03R1UyckgwQ05WUU1td3BIbnRQ?=
 =?utf-8?B?SFpjQ2hLbktrZDJnMjEwbHpIdUpqdDl6NTI2ZDg3eHJiTHZ6VFh1eW0vL3hB?=
 =?utf-8?B?NlZiNDJDMkpxVHdQdk1jbnI1QzVIa2V1YzhWb3VPMVkyYU9TbVFzMEVaV21r?=
 =?utf-8?B?VFZzazNNdHlPZzZoZ0NvdWVuTTlXclZBVzAxNVFnOHozWktMcmMwL25sa2Rj?=
 =?utf-8?B?Rmo0QmxsS3U0WERjTjdWMWFla0tMVVlsRS8yQ0pDWTd2enVsOE50R0lXMUJz?=
 =?utf-8?B?Z0I1dkxwVjNVdm9FQkQ1NmptSFhtYy9XWk9LaENFQyswUUVDVHFrKzZteE5H?=
 =?utf-8?B?MVlsLzBpL1VvK2diQVZPNjdXU2ZDYjZSdWxRcUZtMWtXempLRnRsNGtmKzk5?=
 =?utf-8?B?b2ZqcmJTb3prWkxGUlRuVnlianFvd05iU050clhrRkNKcWZhYndTR0hMbDd1?=
 =?utf-8?B?Y0RqN2c3eW5yaWVtdUFuVkR1VTN5SFNESk5kUU02cE5TOFpjNTZod3F3ajJC?=
 =?utf-8?B?dEVQUGkzcTJYZzV6TjhyUmpKREEvWmxFZ3M2cmM1ZW9qODBYakJlYUhJYjhO?=
 =?utf-8?B?eEJueGJQcDZNZHlGUVhFQ1B6WllxQjRIU2JMRnpLRDgyY1JnVHpoOEFqT21y?=
 =?utf-8?B?YWxsRVAwTE1xK0RndjZEK1IzbzJGYlVabVNVUCtsT1ZLTDlRRFd2QzVpZFRo?=
 =?utf-8?B?K3lid1VPK2M0d0ZPWEpncnpacFhpLzVpbW90Wm4rbTFPOFVlV051RUFPWU9j?=
 =?utf-8?B?Vzd0TlZJZEhWQU56b2JrMkxRUXRyY2FPRkxlYWczN0R4V2haa3B5N3dVV3I0?=
 =?utf-8?B?TXRuSnpuY3hyMENza2tUQVZEU3Z4MC9BYklvbWlqS05YWWp3cW5kdGw2UVZ0?=
 =?utf-8?B?Wks4ZjBFL2dxUkE0Z0M1MEx3a3dmMmo5Sm8rZGJ6ai9mSG1zQURJREVLVmRs?=
 =?utf-8?B?VlJCQnhVS0lCZDM1SVFOMnJWSE5JWWl4Qm0zc3dFREF3VlZTMk1NQ1hrZ20v?=
 =?utf-8?B?UUNYZk05UGpkVmF1ZWJ0eGllaWhRM0xPNUFoTUcyNUFVclNqK1QvdmRWTVF3?=
 =?utf-8?B?V2lYRDF5TlE1UldVQXVZZSs0cWZDdVpTbWxTckVqQXlPcUZlVEpDRElVMXlM?=
 =?utf-8?B?Ly81ditKb2htbXRkc3gyTXV3UkxiT0pIcXAwaGZKdTlHT0RHOVhNOXZNRnJX?=
 =?utf-8?B?dXZwR2RxY1ZEY25yZDhtckxkQkRpR1M3WEVYRWVRajhUQVBhbUNTSHFBNnlq?=
 =?utf-8?B?Z1Q4ZHNGK0tMWXJTTzlsRDVjdmtRallmNjc3K29DUy94T3Fqc2RLVE9zK3NB?=
 =?utf-8?B?dzVZRlpRWURRYnRwWndzajdFT0grSStseUhGcWhOOHdwSlRpWWRGYk5RRVcv?=
 =?utf-8?B?clJkRmJNdzVGc3F4dmpHbytHNERhcFlScmRaZWYwZmYzREFVZm9mcVB4QjhO?=
 =?utf-8?B?MWlFaGR1RzJ0UmM0N1hyNGFFVnI4LzJvOXdvc24rWVNBaVR0L0dVVmg3NE9Y?=
 =?utf-8?B?cHA2UFZzTVVOUWtnZEV2NGk3dUtqNk9wckJ3aGhUbGROejBRWWlPa20yVFhD?=
 =?utf-8?B?MkNrTUh1ckdhWW1POE9VSmhqb2ZWSkZic0ozOEtWR3BkWkZ0UUxUcmVSbGk3?=
 =?utf-8?B?N09TdkIzUFR5bnU1dWlPdlZHMXFYT0tNa2t6TlRmS3EyS0Q4KzN3QkRFejFv?=
 =?utf-8?B?ckxkYng5NkY2R3FTN1JmclRXa0xkTTNadkhDNVk2UzVHU2U0dWhlbDFpNjc2?=
 =?utf-8?B?SDZ5NnlHeTNER0tRNHZGazRsRGF2eENHQUVzRVRLdzRoNXFUcThMNDM2Sncx?=
 =?utf-8?B?anRVNGlLRG1KYXhYQkVId0ZmMVlPaGdJVnlzTVFEYVNLbktYNmd2QT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc7267f-794b-433a-ca19-08de542e0d3b
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 12:03:10.1157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 84769XsS87qpU7eOL7TGFPDY2mIABOAEuWGRO8BXcwHGq+TgomRSd5aT+iSYJV3Af04gzOIczPH6snnimowX0hbVBYvShQbH+cNax7ZS8mg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8682
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 12:03:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18775

Hi Alex,

On 1/9/26 2:19 PM, Alexander Kanavin via lists.openembedded.org wrote:
> From: Alexander Kanavin <alex@linutronix.de>
> 
> There have been instances where directories with timestamps
> in them are created within the same second, and their paths
> clash as the timestamp in them is the same for both, as the
> timestamp is accurate to 1 second.
> 
> This adds a check for the directory existence and then adds
> an ever-increasing counter until there's a path that isn't yet
> created.
> 

That's just making the race window smaller but it still exists.

> [YOCTO #16121]
> 
> Signed-off-by: Alexander Kanavin <alex@linutronix.de>
> ---
>   bin/bitbake-setup | 18 ++++++++++++++----
>   1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/bin/bitbake-setup b/bin/bitbake-setup
> index 06255b112..4ccf47e87 100755
> --- a/bin/bitbake-setup
> +++ b/bin/bitbake-setup
> @@ -93,6 +93,17 @@ def _write_layer_list(dest, repodirs):
>       with open(layers_f, 'w') as f:
>           json.dump({"version":"1.0","layers":layers}, f, sort_keys=True, indent=4)
>   
> +def add_unique_timestamp_to_path(path):
> +    timestamp = time.strftime("%Y%m%d%H%M%S")
> +    path_unique = "{}.{}".format(path, timestamp)
> +    if os.path.exists(path_unique):
> +        import itertools
> +        for i in itertools.count(start=1):
> +            path_unique = "{}.{}.{}".format(path, timestamp, i)
> +            if not os.path.exists(path_unique):
> +                break
> +    return path_unique
> +

Let's say you have two instances of bitbake-setup running at the same 
time and entering this function.

They may both very well exit with the same path_unique as you only check 
for the presence of the directory and not create it, so they both will 
find .10 doesn't exist yet and decide to have this suffix.

The logic should be something like (untested) instead:

now = time.strftime("%Y%m%d%H%M%S")
for i in itertools.count(start=0):
     suffix = '' if i == 0 else f'.{i}'
     newpath = f'{path}.{now}{suffix}'
     try:
         os.mkdir(f'{newpath}')
     except FileExistsError:
         continue
     else:
         return newpath

Cheers,
Quentin

