Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF3CD358EE
	for <webhook@archiver.kernel.org>; Thu, 29 Jan 2026 10:07:26 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.65])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11972.1769681243683644431
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 29 Jan 2026 02:07:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=WPpyJbd6;
 spf=pass (domain: cherry.de, ip: 40.107.130.65, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mR+MOJhti83+hQaQiStCkvJQfFqGeonbb3e9TwX4+ccIGZQm+iHDvYDsbQuJcekJt+umyzB0PFyaEOVqfQ9xJAxDcqNLqMyN7hGlrGzPyJt9j3yNOIyyXnc7d2YK7ywV4y7q5znr1zWRu+oz8/xJyPK1/pkTcKOxsU8vYRdHBIsIAKhjU9njb9XHr+xUXPnsGRaVlSDgdrj/tQakmOzJ7TPUiaOsHf0OgGVK1M7fu44dZu5/6nSoqPRiMPtgsgW9yiNsAzalxCFeJwd4y+GEA61adUrR2lYJIINOpYuveRszmXTSo0p5Ljnu0+1lZt7+a99jgNF0FXkN2504TldC1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYgyDPXybiwe4hIgOvJIatbUptkDU86gI+PUUXOb7pg=;
 b=fxqQxBagZ3F5R29XQ5yCnSn36uCHQHZ8zYG8GQeiGu/d7d9EymRf2P8WU7sdVwm0cqBO1uRB2oWzr3zqAjQ3bXlJ3ZB2Q1FfycJsRAKlhA4UYI5QYgjm/jfLtyYR8k6HgDKXwiC5A/IGgG4ZvBMJCHLuL4ZsbSCKxXZ5DvPuNB7z2XotPjMheS2jh2gwkyg3jLHDoe5B3uy1dTIJ08kSpFR7ekVdSUZRMr8yG1BSQScwQ5s1noXhLlM4umehH5qAT7rDiLTNrAxEHy8aAwQ9NzDx8LPELsW0btlHfNU5raIg8r/NZYBUc/83Cl4DR+3w3QB2yGhp+M7cZpzfq/JhXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYgyDPXybiwe4hIgOvJIatbUptkDU86gI+PUUXOb7pg=;
 b=WPpyJbd6xnxdtXKiSXLLeepymYC3oUmpM16x2zwq34MTH/pbjW1B1TR2F5IqpG6hJ84k5AaLXV5X5cINIaTgQseWT3RsZlPGCypM9Ek9B5w1YNGbSqUiCSZUrVD0PWwycG3EZG6Ktwmv0658Os14gT3a+/NA9Zht7pjrjFYyKl8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by GV1PR04MB10846.eurprd04.prod.outlook.com (2603:10a6:150:210::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Thu, 29 Jan
 2026 10:07:18 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 10:07:17 +0000
Message-ID: <32a2684b-f122-44fc-be17-fb69543e7e7f@cherry.de>
Date: Thu, 29 Jan 2026 11:06:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [docs] [PATCH] doc: bitbake-user-manual-intro: improve bbappend
 file matching doc
To: "Robert P. J. Day" <rpjday@crashcourse.ca>,
 Quentin Schulz <foss@0leil.net>
Cc: bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org
References: <20260128-bbappend-matching-v1-1-29fef2d63489@cherry.de>
 <5d9a1e87-f8d4-19f6-4367-74f361d5d3f7@crashcourse.ca>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <5d9a1e87-f8d4-19f6-4367-74f361d5d3f7@crashcourse.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0335.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::15) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|GV1PR04MB10846:EE_
X-MS-Office365-Filtering-Correlation-Id: b79ed19f-e906-4a7c-bf4e-08de5f1e2f07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bFBhY0ZlRFBvVUZGcXdER1Q0TjVyV3Y3TWJuaXhxSDJZS25lc09yN0N5S2Zz?=
 =?utf-8?B?UVl2bnA5cW5QMzRQWEVmOFNZdUFQZTNlRDBsZi9ySHE4Wks3ZlN1c0RKcjhC?=
 =?utf-8?B?NjdRTG03VlJXdXRVN3BmTUZ2WWZOSFlhM0s5SDFaUHlqSkhaR0RiUFlWWGdN?=
 =?utf-8?B?Qno5b0trS1lWd1VGcW5rU3ZuK253RjI4ZlEyQUFxSUZEOVByeVcrRWFHb0hB?=
 =?utf-8?B?Yk5lVUtlQm5HN2tGaXJXZU1GVWJmMlIrc1REb0cvc215bUNBV3Vob2ljeklr?=
 =?utf-8?B?MTh4R2drN0NZN3lBbTNyRURlQm9vWnhQRXRIQk9FV0ZaZWpZaGNsaGhMS1FU?=
 =?utf-8?B?Smc4TnRSQ2YyUXk2MnNjMHNlNWZaZVptdUVzY1NsMncvK2hkdXVyNWw0MzdZ?=
 =?utf-8?B?dFV4QWFuRUdET0tNRUp4RVd4Q05YaXB0dlRLTU5VL0tDeFZnSm0yUDIxcWwz?=
 =?utf-8?B?bGFFSDJSRERKSWJzM2ZqRmxoY0JzSmF0SGYreTdUc0pIdFRnRDNqTlN4dGdn?=
 =?utf-8?B?WHRCMWFRK3VKb3RrQkEyT28vRytnN2Nrci84QUV5YnVCb2FOU0xjQ2tUZUxL?=
 =?utf-8?B?RHBYYjRRYzVWZzRySUFDUnZCTDVoVXdjZjJjK1pjU093WlpGT0JIQnRRUG9k?=
 =?utf-8?B?V2ZqM3Ivenl6TDVoZDNkT29qMG9rbTFxYmVrVUVMbXVPOElBaEhvTzJSM1N1?=
 =?utf-8?B?NnJ5b0FkampReFFjN1pvZFE2d2RVVTFLMzZPaXlTVHBhcWdpUDlUcnYvNUlW?=
 =?utf-8?B?Mm1nK041VVNuNVBqRkRxVVBnWnFST2xucGhESVF4MUpvaU9iSTR4Y2Z2SU0r?=
 =?utf-8?B?TzY2SWFRcmVac1Nwc1FMZ3dxaDlIYTl4SmdaYloyczdYRThNdVBKMVhhZGxF?=
 =?utf-8?B?Y1FvMThaclR4alRuMkdYUnF5VGVtbHRJdm1ZZlNsTkkvVG93S1J5V254a3ow?=
 =?utf-8?B?dVg2RWYzUzRTT1hMOWxxSXhOYWZCTU1MQ3FFbHR1N2JGWlozU0NXalpMeklk?=
 =?utf-8?B?UERpTHJYVVhGUlRIcDZMMTBWSlVjbXJUSjJIQ0taU1NsWjBPNXh0MVJpdGw0?=
 =?utf-8?B?d2pwc2hVVDdKYXVpd1p4MTBQa2JieFoySG1SUUJZUGptVVJwMndqMFYycERr?=
 =?utf-8?B?em9VWVN5Q0VGeFN2TUdDUm1Ock5paEh0NGV1ckk2MnlLOGEzamxzZG1LenZI?=
 =?utf-8?B?MGVobEMvdndxK0Z6SFJCcm1NTW9id2ROai9yWi9nOStMYkV1eDZNKzNxVmdC?=
 =?utf-8?B?cnp5UEc3N3hjbUI5UnZ1b3RlU2o1OGxjbW1QSk45ZmJWY1VhVlhJV3dlMXR3?=
 =?utf-8?B?R3RuVWVkNmhReWZ5WUpNNG4yUzU0Z2E0Tnp2eThxK2RHVXplY2w5VDY1VG1w?=
 =?utf-8?B?NFl3Q1VDMmJ0WjdoWVNJWjRxbHZXSHhYbWl6cmdyejZSenEydUpTaUdvQmxR?=
 =?utf-8?B?bS9na1lLc1Rpek5wRHM5VnpNb3YwV21rQnFCT0tpeUpuWEpEbFdjV3NVdzNE?=
 =?utf-8?B?L3RSQjN0T1lrdjJyK0c1ZlVsUDloNDk1dlE0cFpCTkRvZ2ZJUFFDRUJSQ2hL?=
 =?utf-8?B?QkF2OXViMUtSSURJS0RhQTgrN29Na2xQN2UrV2h6NWVJK2VYUHFYSEVIOTVw?=
 =?utf-8?B?M245aTVNbHY1OERUSTN4RWZ2TVVvWm52cFRCU24wbFM1VE9wTEZrQUErYStw?=
 =?utf-8?B?ZGcxdW1sdkZVYlZwNkdrTktMNjkxcStIRGRuNCtleUZvZ0docTRoWjhnZHh5?=
 =?utf-8?B?RW1TOVptS2k5L3c3RldLYVpvdlJCWlBUS0QrZzFBS1A3c2ZlcjF0WWMybFBK?=
 =?utf-8?B?emRVdmFRbWw2Q08ydEcyVVVKNUpTME8za2prMFpMOXdJRmYzcVNXMytzVkdh?=
 =?utf-8?B?R0NIbVBSUTNZRTlpdTg3TGtEajZOb0NVV2ZKK05WQThBL3JsaEpKUU51LzZw?=
 =?utf-8?B?NGgvZkxGcFVhbG1HMVk0VERoWDNrTUYwL2svamYzdFIzK2ZndFlMVmszQkI5?=
 =?utf-8?B?emVqNDZ5VkNJTVNXOTd4QXhMTTR2eUNkalBHZjVUVGdhV002ZXhDbFc4eVlV?=
 =?utf-8?B?VUtsdmtJU0RJMTQzUVZUWTlWMUVnWFp3dTJENVlRQmRpM0VWaWVzRXFLTjVv?=
 =?utf-8?Q?hMWA=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Ti9Nbmc1MUtPV0c5TXBTYkRzQUNBNG53SmtiUC9RNFI3R1hIcGRtS2poRmZC?=
 =?utf-8?B?ekt3QVIyZDNpVjQ1c2FUNUxoRUNuWEFRNjd3TXdxei9BS1hPckE5U1dHcWdr?=
 =?utf-8?B?dlVjMlNRWDBZeW5kRGhLOTFMSUwvRjQ4YTdBTFpXbGkwWjJORnB0TGdpZzUy?=
 =?utf-8?B?b2RMM3FKZThDRXV0VTA5SnRCcktVZE52MGQ4cXdsTEZzbjJaZGwyNHlEcmE5?=
 =?utf-8?B?OU5YaE5sbFl1MlFKT0RzY1d0NGZ4L2oyNVRGUDBndHJiTjZUZDB0NDUySFc4?=
 =?utf-8?B?OXd4ZUdDUnZibG9SN2h3Vy9Yd0dNTk1iTWRDUm9BbWNYb2JTRkhRL092Njh3?=
 =?utf-8?B?dU1MZG9ncm5IZzgyZEtjN3diUEhNd3NocUpkd2cwMEl0ckwzZ2VGT1dpd2xr?=
 =?utf-8?B?VURMWlFvelZiYXRUT21OVmU1OGoxcHhFZ3ZQZUQrYS9uZy9mdStDanVuVFhq?=
 =?utf-8?B?RTViUUtVT0ljV1NOTHdSUFRVMksxVytSbjA4NU9CT3NqQnRFdHFPTFl1ejZo?=
 =?utf-8?B?TVZQanFqeXJydHI5M2V0TU96SFJSMzJaZ2lsZGJqSEJGN01mL21zYWprcDB1?=
 =?utf-8?B?YUQwUGZFakIxQWVHRkFIbkdqWnFuY25nMUkyYlFLQmhKRWFHTU4ybGxDMlR1?=
 =?utf-8?B?Z09zRnhIQTE3azNXdm1jUHpHQStjMWZaUVpaTktzY1dkNnBqTm5kSS9NdExH?=
 =?utf-8?B?YjNTNWdhYWdUdjFEMzYzdWFLM0pDMTlQMkp3TFRaK3FuS0FEdkZ5c0lRYUF3?=
 =?utf-8?B?S0h1Yk4rUlhzaDBJdlFGdUlLa0dTUkVyWDFzZk5VSmd4YVlsYVl6ME5DMVRp?=
 =?utf-8?B?UUZuZktZNXB5R04xN2ZQR09iTVRhYkVZclAxUUxyenBOdlAydHhOTXVsN0Fz?=
 =?utf-8?B?cW4raEpGTzlFSzN4dThwVGg5UnNmUkl2TUp4MlI2T2hUMUFCQWxudWl3YXlF?=
 =?utf-8?B?eWxTNElneVYwaUZ4dElBSzFEcmQ0OG0xSG5DOWlKMkpiQURoaERBZlV1RFBl?=
 =?utf-8?B?aG92SmQxVDNSbXpHUlFoWjU0TWdOK2ZkT3J2NC9CQjNma1c5akFIZDNlRGdY?=
 =?utf-8?B?cnBxTFgzNG5PNjFrdjM4SGVzQ0dqQTNnL2VaeW02b3JSZ0xsbWtYdkV2czRF?=
 =?utf-8?B?SHlwcjFPWmVXeTdWMDFtSXF4SEt5RDNxcTdDSi9ncDNPdDIwS21vTXBHcWJP?=
 =?utf-8?B?RlVKM2RqV3FFWFVGUk5XQitCQUY4QzM2NkR1cjdVR2VRNjM0QnlLb0FVYWxm?=
 =?utf-8?B?c1o3bzhwbXNOMDMyTHJCUFNqbi81dis5UFpLbXgxbzRJU2VKY2szcDF1NXFN?=
 =?utf-8?B?OHlSa2dNMXNtQTJaaXprU1FmNW5ucSsyZE92YWNDMjd3bUZhNWZZc0tKUVNm?=
 =?utf-8?B?bTVnOHRzbDBmVy9NRlBobnU0aG5RSlFYcDc5VmJRZmgyV3I5UnpYKzBhanpU?=
 =?utf-8?B?ZTRPK1ZBcFhlOWYwSUpYWUdPRThZT1FnRFFQbXM5Z3FoNUVqL0lDTVBLUEdC?=
 =?utf-8?B?V3VZeDE3SCtQdldMSHRhYjVhL2J5UkV4YnRaYXdYZFN0VnRVS0pBSmZnTUls?=
 =?utf-8?B?dEF4VXlPY1Y3eW9GamdZa0NuMUdDejlSMEVYb1l0V042NkhzazJxa2VFbWMz?=
 =?utf-8?B?SHpYd0toNWFCOWYxOVpGUEp1dmoyYVJQdHVFTktKVXhsendZbkZrWFBia3R2?=
 =?utf-8?B?bDZsM3JpTVNTYUxWSlFUTjk2WE85WlhWU2ZDc2JmdlV2dmR6SG4zWFVYOU1U?=
 =?utf-8?B?dC9DWUFBNXlzQlRMbWpsb0loUHBrWDh6U0ZrLzJnbkJpVTF0cjZUaE1aU0dw?=
 =?utf-8?B?QXF0WnhEc2tUcXV2di92NnZDa1VqNDJqVmNoaVRWZTd5eWNJUyttZTg4bDNB?=
 =?utf-8?B?cThFR1dGQXJGTUx5TmtoWTVhM1lnbkFCQ3BtQllYbStlNXhRMFU4WDl2Wlor?=
 =?utf-8?B?L3Q4R3RvaklJcHBrSlMvcnVoeHB6Z0JpZ01nU2RmZXVhUVRyZStKOG9aM1dy?=
 =?utf-8?B?ckx0WXNBRzZFSEVlajNYNUhEcHk5NE51clJCdHZFSlpER09OWkFCUVFOSTVo?=
 =?utf-8?B?QWppR29vOGcvblJaQkNqRWQ0UUNFV1dEVDhqNkJTVWNjZWp5Znpya1E5QWYr?=
 =?utf-8?B?K1IrdFd1eTRXbkJHVUlOOW1QaC9MVTdwS1FtWkV6N2szWGVPdFRFR0prLzFB?=
 =?utf-8?B?MWpKNE5wQWNXMkJuWnIzWjYxd3gyRWw5a0VIdEtyRkxrOFQ0MVRwWkFjVVdZ?=
 =?utf-8?B?M2R5Mkg2dzZNWVZPMURVZGZRaXkrNVduS3VMTnZZVnAvWHNERzVKdUVjMTAx?=
 =?utf-8?B?VUVkTW9CZ1RwaWxhNUYzVnkwTCtsTzhrY3JMSFNCNFJWRUNtUStlQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b79ed19f-e906-4a7c-bf4e-08de5f1e2f07
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 10:07:17.7369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WkEOJb77qNSS+ItAqGCWd5rnGVqgga0ZVMoZqBdZaf00BJzzhO9Sv5acSo9DBeM4uCwiGi/dDOE8u+VNVxNajZ+0Yatol0BZzzBEczFEM/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10846
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 29 Jan 2026 10:07:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18929

Hi Robert,

On 1/28/26 10:57 PM, Robert P. J. Day wrote:
> On Wed, 28 Jan 2026, Quentin Schulz wrote:
> 
>> From: Quentin Schulz <quentin.schulz@cherry.de>
[...]
>> +The "``%``" character is a marker for BitBake, and everything after that marker
>> +will not be used for matching recipe names. That is, an append file named::
>> +
>> +   busybox_1.%.11.bb
> 
>    that's not an append file.
> 

Ugh. That's what's happening when you hurry to send a patch before 
leaving for the day.

Sending a v2, thanks.

Cheers,
Quentin

