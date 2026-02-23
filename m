Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617D6EC1118
	for <webhook@archiver.kernel.org>; Mon, 23 Feb 2026 18:03:53 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.29])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.924.1771869832160007952
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 23 Feb 2026 10:03:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=Ojh/dXM4;
 spf=pass (domain: cherry.de, ip: 40.107.159.29, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=khlg90P4XsrK8fPxqJpTz5dcOiXPL/E7NP270lg9OFOouk0duR5mQP8YEY5vMmiAuYmWKStOifjw0OuZAcoh8UoSazbWsPoiaopp6CV5yraHeAC62zX4UDD3mwaBwBjpeLVCNLbb/B3dKz1GfkQLpdo6pv7b/FynRNc7eHvkkOowa2PAiieWw0fta1j1jJXTv0InuZ1aTpqnXnczhIHhV28HH3od3c2zjQz+xW6wWOSo/pkeCmUryJbc2ZGTk5h3pUgAXINeQZBauml6f1bBKDJ9JQ1pDj3GYYazksuLVvk032sNWX8XROYCptwcrAl/eyLIov6Dv2fJV1qk9Rt31A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Di19MII6ijTaD41IrxNhjct9gkcVx6KUPdcRBSr7i0=;
 b=IF8DPhanfbezIYb2V/y27z6NYmOJ73ZJrXU523Xl3nIGNOrr8Dyv2zTVb1Q6xfcxD+mEVTSjxxDI4Zmju4PntkZ7PsmviYBUIt/fCHRdYH0vIb6Eags18S2zDIxd4sjxXArQ3VIf++vcw4tTOX+nR3Iiwzlo6rQjAUnfGIIU8Qvc4yw451DE4X+yVOG1r27+YdMDnk9nSsk6Vy9pRM6rmqVlhvVOiEQLHCT4+B1LOjw5ARbi4BL0UUYjaoU1PBU+1T63t9984ska2ch486US7lrQhpDJELqF+QttBnWZq4sCJb6GQC0L5B7yVnq6d5Svg8Plh0AV54aI0X7Z2biUcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Di19MII6ijTaD41IrxNhjct9gkcVx6KUPdcRBSr7i0=;
 b=Ojh/dXM45kUBPlSMYfY6ILBWkMOdESUCi+ytvafDADzhSQkDXSHkeNCQQKGmfFGdR2YXzJHsv2azyyjTGJ8EWUwP5dYxK8llJpgWcrrjyIqimSBdazX7rm2Z06fECGlu3h5QBfy7iXp2RHQzxJXisVd7Y1JdGDgnHvqxNdOhhvY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by GV1PR04MB10128.eurprd04.prod.outlook.com (2603:10a6:150:1af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Mon, 23 Feb
 2026 18:03:46 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 18:03:46 +0000
Message-ID: <a0b211c4-320f-46cb-80db-d4dcbd56ef04@cherry.de>
Date: Mon, 23 Feb 2026 19:03:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: bitbake-user-manual-ref-variables:
 BB_ENV_PASSTHROUGH is not in default BB_ENV_PASSTHROUGH_ADDITIONS (anymore)
To: Quentin Schulz <foss+yocto@0leil.net>,
 bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, "Robert P. J. Day" <rpjday@crashcourse.ca>,
 Richard Purdie <richard.purdie@linuxfoundation.org>
References: <20260114-env-passthru-v1-1-fd5ef76eab61@cherry.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260114-env-passthru-v1-1-fd5ef76eab61@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0004.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::15) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|GV1PR04MB10128:EE_
X-MS-Office365-Filtering-Correlation-Id: 769f9f2c-e261-4296-4679-08de7305e3be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NFJqeCtjTzhuNU9Pc2l4Ullub3dlWnI4dXRWbnBVMG80eXhNMDZiOTBZZUxV?=
 =?utf-8?B?ZGF4eTNzRyswTk16OW1lVkhJZUJUZjFiTUtiQUxLWS9Lckp0RzF5YXFPRXYr?=
 =?utf-8?B?YmF5cnB1anptZHVEQ1JkQ2dEVDVvelZVMGJwRlJwbFgvbG9wcVc3TjNMY3Ja?=
 =?utf-8?B?cVRLekVuWkNURFpTZk1WeCt3NGxyNlU3SXllWUJrWlVkaVd4dUtxR2NoTDlB?=
 =?utf-8?B?YnpZODBzTG5MT0dVVnIrUlltakVycXZzZXJwK3dzOFhmMU9lSjJTZ2JHdjlU?=
 =?utf-8?B?WXZMUjZrWERGWTBlazc0MnNwZlhjZVcrTzNUL2hTSFFhR25NY29FYm5zZkdo?=
 =?utf-8?B?TUh3NjRRNFplZDFBZjgzRUxvYURwdlhvTzZ4U2RJaE9RZ3pjVkdMZTZ4MGVB?=
 =?utf-8?B?ZndqSC8xYjBsc1dlSU11V1dEMVdscFA1bVJkUWNNTkdoZVp1aGVUdzFLcURm?=
 =?utf-8?B?bGVOUDNGSm5sbW4rcXpXeERjaU04c0hXc1hPWVhBOWROMUpBKyttNytROGQ4?=
 =?utf-8?B?dFRScEFmQWVEdHVjdU9kaVF5VnFva3VGWVpJK0xjT3FDSkthWlgxcUlSckZo?=
 =?utf-8?B?Um5YRVJ4c3ZOa2h5dlJ0ZE5WSm5ZZTcybktsL0hsbmxiVE9YK2VZY1FqaW5p?=
 =?utf-8?B?WEFyTTJpRzFWVjlLVzd1ZEdlU3UxOENiN29UOUt5dWthTkFSL2tjbFRaWmRp?=
 =?utf-8?B?TnNnR1NFamRGZ01WdEZNVXFzUjgwTWlyTkt2NnRaVlJpaTlJWVM1NjBjZVVH?=
 =?utf-8?B?NHo0QzBFckJaUWpXOWNObXphRTZRYnlPTlhpamt3bzRJVDFtVm1jVSt3b0dz?=
 =?utf-8?B?T3l5Y0VJVzdqeHBpU1J5Z3RUMEtJK1hMaklhK1NuQ1VVakNNQlhody9QNEtP?=
 =?utf-8?B?RThNVmdPb1BUNS91TktTaFJSTzA4b0JTZUk0S2JOQkZXVTQzdXFIT29aY3hn?=
 =?utf-8?B?TlhhUW1DTnBZYXAzUmxsT2ZRRkxLdzQyOHE1M0FqNzFGS2lxQnFnSWVjUHRp?=
 =?utf-8?B?c2ZIcWZGTXlFT3BidDcvdGpZQkhla3huWnVxUjNHOTR6bHBHZmpsS09EYVRQ?=
 =?utf-8?B?R2oxUFkyZTdQempyaHdybzQ4djVEU2tGVHFxeDJkMkZJdkcvRzhMc1hBUSt6?=
 =?utf-8?B?U0dYeTNUZWIrbmpYcWcwcmxvOGxBaWJjRzNiNVlBWlBsTFhTcjV4QjZDV0VM?=
 =?utf-8?B?ZXdWRU1SN0lKQWtuMDhNVDFxTU9qK2pLZk5MdTJlUDZxSGlsUHcvZ2dZSGtN?=
 =?utf-8?B?UkFsSkxVUGZjTVBxZGlDUU1ZbUNZUWxkTjc5ck51b0l6V05nVWFIeXJRVmlT?=
 =?utf-8?B?a05hNzBmbjI5UEV6OG9Xd1IxQ1dhL3ViaitiVXBSOHhCSVlKQysrU2N2SGVq?=
 =?utf-8?B?aEYwVy9XUUo5Z2cxQ0hNNXk3R3E2QktWVTVNaXRkbXpBWFdId0MzS0F0Q2t1?=
 =?utf-8?B?NjlpeXpZbFRwZXhFYmswTDV0ZGFGcGRTdnB1UXp4VzNmZlBuTmRkV3d1dWZy?=
 =?utf-8?B?YmN4WFk1ZUx6NnYrMWtuYXRJSEoweDVxL0swQ1g1U24vaVBnbi92RVlWU041?=
 =?utf-8?B?YTdCbHBwRkxHNnJwa1UySWFFUi9qNFB0alpscitoeC9IMkNrMkF3RVVMVVdI?=
 =?utf-8?B?Q3phNlF0ZmFaY3dMalMrZzZFRldEV3JNci8reDdSZHd3Szd5Z3h4a2dRa3NE?=
 =?utf-8?B?dzQzZkxKN0NYbFo0S3Y1S0MyenF1ZDNVRHZXUThmcTNuTGJHUHZvbmRadzZD?=
 =?utf-8?B?WmgxOXVTQ1dWbjVHZ3JuY3JIVUtlVzJiUUtrMUZiTUR4TkprMUJSWnkydk51?=
 =?utf-8?B?T1Q2c2M2enhOOHdyMW9Oa0lGVVBIaXhMVWZyWEhpUGFJK0RMREk2b1VvMUc3?=
 =?utf-8?B?enNlN05ER1lOTnh0YXI3TUZwOXNVU0F0ZXF6Tm51T1FyMXlvb3VuejJqMnV2?=
 =?utf-8?B?TlROaDh0bE56cHIyOGJkU01sQlcxS2JwOXBhQUd3OFhqcHlodG5vTGg5RFFp?=
 =?utf-8?B?aHo2VitQRTF2WGh4VGtiSWxmVEltQVA2RzFsdUEweXA3VTVPbWFvMDBjQ1JZ?=
 =?utf-8?B?TnFyTUIwWUFHdEQ3Nlh0Q3JPajVObEZLTGV1aHE2S3JVTm0yelNNUnZEK3Bj?=
 =?utf-8?Q?w7U8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QUpmRFJqcExJTktBUmdxc21abkkwZHdseU5WZUdxdWhZejMxWW5jOFFXanlF?=
 =?utf-8?B?T1JER0pWdTE0c1RQMGdyWDlkRFUydHVmbWRJc0pZazkyQ2hPUEZNcUJNbzMy?=
 =?utf-8?B?Y2I2Rmk4MmlLaHZNRElVOWlqajRXV1FYNE1IdzJvdUhZS1pVVVMvWG5EdTNy?=
 =?utf-8?B?eWhZR3pXYkxJN2JINjN2Y1ZKSzdaUXJ3cHU3Zk8reXZacllVUVNERlJCTmhm?=
 =?utf-8?B?VzVnNm5WUXhIVjNCazZLVHpOcWVWdUIzb1Y1ZXBHVTdUOS9RTHRTWWxzK0Zw?=
 =?utf-8?B?SDFyOGNiVk1KQ0JReXI1U1puVWxaOVBaMGI0dkFpL082b0dzUEdaUVQrVytB?=
 =?utf-8?B?bkxSWU5hRGFRQnFNVUhPY3BBdVlTd3QrMzRTYjVWczF5OHNHS3pET2tjWDZV?=
 =?utf-8?B?ZnE2SFpsbXcxdXVkMlBGVG9HbkZEY2tCdDJaQzdyVWUwZ2JiQjlhK0d2RGF3?=
 =?utf-8?B?VFUyNHNQallaOEtiUVZscEkxRFQ2Q25EZUxmZGdhWkhqWDM1aUxqMDhYbDAv?=
 =?utf-8?B?cWNOVTlDcWRldXRlRUdHdVhmM2F0UmcwR0dHakhpcVJDMGFvQ2s0d2VGTFo5?=
 =?utf-8?B?UU9vQm5yczlnRHJ0OVF2MDZIbkljNWtGV1RvZ3d3bWJKb0xxNTdMaURFUDJ1?=
 =?utf-8?B?NmtKNStDMHFwNTVwUFZ1Smh6Vm14Q3ZEMzNFZlN1cDdQSzh6MG1ESU9CcHRG?=
 =?utf-8?B?QktpWDQ4VkpVOXNZQkVjLytkemN4ZXErQjJRa1NyaUllcFFDYVhsUnhSNjM0?=
 =?utf-8?B?VDFTeE5sSE1qOXphcXJkdkNpMHI5eW4yQlZiR01UVzFJVERYOTZ2TS9uNm9k?=
 =?utf-8?B?NXBRVHVSdkxMVWd3WS9nWjNDZnlIbDZYb09pQmVQcVVKT1orVlhVN2sxckhr?=
 =?utf-8?B?MFlYZ0dMYVpUcStwRnJuQXF1NGJOWkRRbG03RWo3dFRvZWQzOWZjdlFOWVF3?=
 =?utf-8?B?c3pDd2RqeFN5TG9wdUN2dHl3c2pmZWNWN1dwSUsvRVhpUUNUZ0E4bW8xNWNu?=
 =?utf-8?B?K3Rlcy9OVDVvQklaWlhoWmo1aU9LZXZmSU4xNGdMRDhpQUJIVURCYTczTmNa?=
 =?utf-8?B?K1pEaE9iMEltditEcmNIcGxMVXhGL1VDdUl6ak1RZkZkN2d1c2M2TDFKeExE?=
 =?utf-8?B?RHdHTHdrS0hQc3VNVjlocTB4TEtjc00xeFdYUlM5MVk5QmZ3d3dEQk5ITW50?=
 =?utf-8?B?MGNRYnM4Rjd1R3VCUHEwN0VPZkREZXJFZk03R1h1MSttSm1kRUlNQ3FPV2Ru?=
 =?utf-8?B?UW1ETnQzeXdvVkxhWHVzQ0ZtbzlDbTlxWVM3QThuV3E1Qkl0ZGJNb3BsMVpq?=
 =?utf-8?B?Z1Q0NndHVCswemNya1cwYkxuQkRJeldzREdLZWdrRFozcWV3TmFmRFRhY0ov?=
 =?utf-8?B?SDRpMXpzSXFtZUZhVzljNFdEczdSeHMyYlhBeFkzdG5QSXBjQjhMcEx3L3gr?=
 =?utf-8?B?RlA0eTJpcmRvZEJYSHorby83SWJQcVRKOFhnSmdQUjRaN3czMml2WnlneU5m?=
 =?utf-8?B?WVRCSUxsOW5sWHR5SEU1T09CR0xsNGFyM0EvSVMvS3YybjE2NHVrUkRLcDA1?=
 =?utf-8?B?clVRSXpXL21URG1pVkFxblUzdlhRZkxwZmlMS1RsMng3TExlZmNKT3RteWY2?=
 =?utf-8?B?WldsekdLeHpqajU3dEs3OWlDQUlPV2FBaHdodCtNUU9FdlZKZHM4UnhhSG50?=
 =?utf-8?B?MlkzTkFlTk9IOW5pODZOR3Z3bUR4VkNoTkUzVnMzZ2hXUFZUbXJKQ1dNbjRN?=
 =?utf-8?B?TjBKeVBwdnF5RjRENGJhT0ZBQUhFNFJUd09rNE5WS0ZIbHoyMC9KOEo5UUg0?=
 =?utf-8?B?M2M0SVpIc0VNZENWRERoV0UwS2pVVEYwL0dpYlhxNWEyVDRUZjNrVmZyRHZx?=
 =?utf-8?B?SnFkd0xsa3B3NzRZVXZLaVA5cldQeEpiTlZmYTM0NUhaWWZFdXVUcWkwVjNL?=
 =?utf-8?B?RlVOMytpSUduSFRjOU1GVGROZFpHT2huRHlhRHFteDQ4cTNGS01ISDMxV1Nq?=
 =?utf-8?B?dlpuTTJHdW1EVEZFSDh4bGJXSzlvTzIyS3RhQzBFQnBUVHoyd1FtcW50WG5F?=
 =?utf-8?B?RGVPK25JNis4aVQ5TG9FSWNMYVh5L1p3ejVRS0JNRUpOeDNwaFNCQmZkeUtm?=
 =?utf-8?B?alExbTB4U01OTmlkdUZlTU1IOUhxWnEreW0xelQwYzhQd04xeUE1bC8wb2hz?=
 =?utf-8?B?Um0zQkhFdG5jQkUwRG9vREowL09kNWlST2Zud013WWhIUnpRT2g4dGJjMG52?=
 =?utf-8?B?MEUxUSs3NXcvN1RXd0dXYjRTenhXeWZRakJKeG81d1UvTmN5M1c3cWpFaTdY?=
 =?utf-8?B?YmhwVlM5TVZ2OUNjVUxnSTJyd0xMMVpTUjRRcTlqc0ZCSHZzNnFHd3V1eDlE?=
 =?utf-8?Q?hWasekH6I5jsJydHEtcBMOS7D+6OoeV5fhOFw?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 769f9f2c-e261-4296-4679-08de7305e3be
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 18:03:46.7772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M8Ch0rUx4asECygBcD+TvCIfVbYjGGnR76v565C+mD7svx9ZOfjKqIn68kqvLpAwCgIXKjzEeKQM4uADZkVYsZ/31gasFblu57EBiTqefMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10128
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 23 Feb 2026 18:03:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19079

Hi all,

I don't see this in master/master-next so gentle ping (feedback of 
course welcome).

Cheers,
Quentin

On 1/14/26 4:41 PM, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> BB_ENV_PASSTHROUGH_ADDITIONS variable doesn't contain BB_ENV_PASSTHROUGH
> anymore since commit 0a33b560233b ("utils: remove BB_ENV_PASSTHROUGH
> from preserved_envvars()") so let's fix this oversight.
> 
> Reported-by: Robert P. J. Day <rpjday@crashcourse.ca>
> Suggested-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>   doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index af911f306..345da647e 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -286,8 +286,8 @@ overview of their function and contents.
>         Specifies the internal list of variables to allow through from
>         the external environment into BitBake's datastore. If the value of
>         this variable is not specified (which is the default), the following
> -      list is used: :term:`BBPATH`, :term:`BB_PRESERVE_ENV`,
> -      :term:`BB_ENV_PASSTHROUGH`, and :term:`BB_ENV_PASSTHROUGH_ADDITIONS`.
> +      list is used: :term:`BBPATH`, :term:`BB_PRESERVE_ENV`, and
> +      :term:`BB_ENV_PASSTHROUGH_ADDITIONS`.
>   
>         .. note::
>   
> 
> ---
> base-commit: f23e186a75e71ba885b9b53a1dfda99af29c67b0
> change-id: 20260114-env-passthru-456899fe5a83
> 
> Best regards,


