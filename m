Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1853CC021B1
	for <webhook@archiver.kernel.org>; Wed, 19 Feb 2025 16:49:15 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.101])
 by mx.groups.io with SMTP id smtpd.web11.27276.1739983745492085981
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Feb 2025 08:49:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@weidmueller.com header.s=selector2 header.b=FViZDIMy;
 spf=pass (domain: weidmueller.com, ip: 40.107.103.101, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wg6aK0icnc+9P2N8vAJ/M+i5srx+ARtt22GxsJP+fX1njJWDaR4EpCq1UWNTSRUzCOAU/uOQm3qJmbjf4ISKvWrjYFno4gK5625Wy+8nfYjwNCwppttiVPyvuAacnnNtEIrQu+DBr/pBZf/b9UTBiEYJXvj+kINRd1a0DaS8oA4IdGJF+wt8ZSIXSgMjtNGCQlo9Z4vWwlAFQb7ZXIU16gASzQyHKoW5gCVgyr62xLjrtEdmY5FMLoq+6cZNiVlwUrUK7K2JVkjjR7HgnyenDDigGp/PPXNl+FiWw7vxCUg7ClHXix++Lq+laG1r3+VIt/qYdSMklN2+sm0VQqoWSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WoLEVx1ZERL3P2okgzHCwqtekrl5iYs1krsA+Zm6p/M=;
 b=ZcxLjKThs6A1Y2TEqcCWRuk8+o3zuZWo3CGQ8kSVLfj21u0G1tv73s003gJXesrSLV5JXxC4I0RUPotCzTx7qF31avUn20JDSsnJZhdOTaKnQnWVjyGMsoUETPBdqaKRz1ffLMbqXEdZuYahb/uyH4GVV0asm10EayCi7HKO91WYHCGg3++6bZxyWIW1zpjmyrRbD4GRPeACnVLHYbcIdn2dDeZbTEwVBcjNFwCGj2kiCACEKW9ceUvWoT9UkjbhtFYBgrVmxdvkpVqHXJb0BRE0KXuiIkQi0zVpVvUvd1yc6gNtryss8HQfstQe7q3h4KROWSlaTnGi+rYfjeRTkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WoLEVx1ZERL3P2okgzHCwqtekrl5iYs1krsA+Zm6p/M=;
 b=FViZDIMyJO8SHfgbunXuX9ir2HSPxcMB5BuotojKmMlrYYKXNysctIQQxfb+tO4C1Z2OcKmshPXvV+pjk5f3UTXAR0sXWG+HfiaYbIezZXoxmq2ifq+rDqoFOnYD5rA6VnTfJam+GLXygCKvy4ZLn/krpmQTjwola2zrELow9TUJGRnBxMQ7RlBBY+guMdqFGp7oOoKP6rgOgW44cvX5ywD852wCjhALBjKzji7Sw+rgbkqihcq9mRgqNsoUWm3Z8wXocqzKFqD3sxODu51Co2c3XQ75gmScJNUM78p5pOt1kBFwqM7Bz1WvqbTktoHElczfCCFpmJpJQ6T0ONld4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by PA4PR08MB6207.eurprd08.prod.outlook.com (2603:10a6:102:f2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 16:49:01 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 16:49:01 +0000
Content-Type: multipart/alternative;
 boundary="------------afxK89gajdWg3U21nmmUuEIG"
Message-ID: <c2f481ae-327e-43c5-92f5-9753bd5c0138@weidmueller.com>
Date: Wed, 19 Feb 2025 17:48:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] 'vendor' fetching discussion cont.
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 openembedded-core@lists.openembedded.org,
 Bruce Ashfield <bruce.ashfield@gmail.com>,
 bitbake-devel <bitbake-devel@lists.openembedded.org>
References: <4cea4488ef3181471373f3dca26ac390203a90cb.camel@linuxfoundation.org>
 <55925709-d3e9-49c8-a6fc-f97c611146cc@weidmueller.com>
 <d30c619392f62f2d40320b01da5ca95369f3e7c2.camel@linuxfoundation.org>
 <9668ba9a-4029-4600-abd1-0f32215aaedd@weidmueller.com>
 <7537c9d9305dd3c7d05cbf36bccfe47c1858f822.camel@linuxfoundation.org>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <7537c9d9305dd3c7d05cbf36bccfe47c1858f822.camel@linuxfoundation.org>
X-ClientProxiedBy: FR2P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::8) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|PA4PR08MB6207:EE_
X-MS-Office365-Filtering-Correlation-Id: 24991991-e217-421c-70ab-08dd51054f9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|13003099007|8096899003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bWMwQ3RjK0hnVGNQQjJkNm9teGtybWpOUnhrVis1Q01La211VDU1Y3JlYis1?=
 =?utf-8?B?VHZ0WVpKTFUwTzROeE9hZGdUOFV5NWRVSFpaUEc2K0lybmsrRTNUS2ZTNTYx?=
 =?utf-8?B?dnJiQUkyenFSS3dCU0hIdkVSaStjUENPM3Mwb21IbndoZVQ3NGU4MFV5M1lX?=
 =?utf-8?B?WUF4STRnTndDd09zbi9HMkJvRy9jbWlaZnQxUkFDcVpiSHVFZVZZRmUrRnd1?=
 =?utf-8?B?NFR1YW13ZVpvdktXaFlUd0RHem9iTERiRHJrczZlTnNVbW1rUlU1QzdzZFpB?=
 =?utf-8?B?dkluR1pYenlUM0xBOWtwbTd6empFemdIREU3WEpycnpkcjJwWXNSTk9SK2ZI?=
 =?utf-8?B?OTl0S3o4bFJQSzVTOHltc0l4Y2xsRklsY3BuNHlhQjIxeFVrb1g0cUVvcXdP?=
 =?utf-8?B?WFkzSWxIM3Vxa2dZbVFrS1RIaWVONjZoY2xCRFpJODg2Sm5pOUhGTlQ5SXlw?=
 =?utf-8?B?OWxKVnBWaE9NRUdmUnU4NnpURkkvZmlobzFsTFhDRFZxd3RkMDIrU0M5bTBI?=
 =?utf-8?B?VG9IS3lla1lsTmpzR3dlZS81WW9uNms2WmI4dEJjcnJFazFrTE5aTjdpQzVE?=
 =?utf-8?B?R041TWMxNldkSWR6NUdPRDFoM2ZIZlZQcnhpS21TMmlBbWN3V2RRRnRoNDE4?=
 =?utf-8?B?RU44ZzkxU3E3azdPOXhtcHNCNWtKZ3NwaWl1Y21TOUxwV3Q4UHNvaGVtUXNm?=
 =?utf-8?B?S2c5UHNyQzBwTzRBbDhBQTRRUTVXTGc0L0VkYzVUWHRKS2xHWWk0bHFWWXd4?=
 =?utf-8?B?ZnUzREp4QUwybm9FMEFNcnludmczQUdGdEEvNkJZdVNUakhHZExNczBpNWtZ?=
 =?utf-8?B?bklNSW51YUpXMjl1Nml5c05QYlhXa0FONEwwTTBSY1lpWXZkQmJyU1llU2RH?=
 =?utf-8?B?K2IyRUl0VFc3empGbDZZQjdubDc5WEszZ09TMmVDeldLbDZ3Wjh5YUYvNjNv?=
 =?utf-8?B?OWk4Mm5hQU1RMTlhTVYvRHZHbkp6S3FpdnZPQXJYK0EydlZibEJLYlZDaFJJ?=
 =?utf-8?B?QnhzeUo4M3NzVitOY2lvWGlKaUUreEQxZ2NpQ1RCQ0ZIem0zK0hKN2lJeFFE?=
 =?utf-8?B?V2l6U0E4TTJYaWxSQ3RiTE1ydkx3VzhVUWM3WHYzSFlPRTVOUVovbkwxQUp5?=
 =?utf-8?B?cUplSkdqb3U0ZVkrVFZFOU0rMkhJR2h4UExoRklYYVZTY0d0Sm1RcTFhSDlD?=
 =?utf-8?B?YXNZMHRlVTY0VjlNNUcyNXNNN0paOGpNWm5MZVRONXBKVkhDSWlyZSt6VjFo?=
 =?utf-8?B?VFBlaTdpUHROZDJjQWNndVlISG93aTRnLzZQUlJVcGJlZlpXVkx1K1FGd2VW?=
 =?utf-8?B?QUd1TXNuaUhjN0RJQnNnOVd6SEYxSnFSRTJtd1djMjZtcW9qVWhIYW1iaXM3?=
 =?utf-8?B?ZVBDSUZzQmF1ZmdaUkUvU3BIakYxOWtNVTNmSzBrbGxBcFhFTDVSQ0M1K0NO?=
 =?utf-8?B?aHVja1N5bUlpWHZpOWxVTlRtc1lsQ3hKS3YrWllZNXY4OWJsVHhPTVZwejlN?=
 =?utf-8?B?M0hST0hyaUtnWHhkR3diZDlRNTFhMzAvVk1ZWndodlczSnhESVV6UzE4cXJx?=
 =?utf-8?B?cTA5SFpCSnJidGRjTSs2MXdONnVMV2dzTUMrWWJpbGdOQXJqYWpSUC94ZUJw?=
 =?utf-8?B?SEszdUM1L1Y3UDExZCs3YWZjK1hvSzZFVk9qRE8xNUxwYWdUV2t2OGs1NFhq?=
 =?utf-8?B?cUJmMmdpNUxzMURZMHNNWkVYSGN0RlE4ekVpbVhyZWpsODR4YUp2a2tpc2Zh?=
 =?utf-8?B?emYxWlh5di8zOWI3VXREMVllN2tvb0pFaUYrdVg2ZTNsQmVoVVBWekp6dUF0?=
 =?utf-8?B?cUcxdEM4elF2RFN0MzNIdz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(13003099007)(8096899003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c1JYTldBbHptNWVoNS9KOXlveTZFd1FBdjlINWUxZEVlV2dCM1prU09vZGFu?=
 =?utf-8?B?T0dYeEVWK1lRNVRKaDBYM2NESXIrSWNreTgrYW5sZ2NFdWZ1N3RKTmlZcUtn?=
 =?utf-8?B?Q09nWGcrOHN5SE5pUUJjMitqU3RBYnd3TDNsUXZGTFRCNmxFQWF3YkFuVmcv?=
 =?utf-8?B?L2toeWxEUXBUMXczR0FVc0p0QUxmYVlBZS9DUlE3djUrL2V4SWl6dWFDS3F0?=
 =?utf-8?B?VVprdVl3Z3AxTEo0YXZBRG1hWVBpVFR6SzY1ZnkwcU05N3M2MmtHL0FOQTNC?=
 =?utf-8?B?UGpmeXhrTHFCdkY1UXkxVS9QSzJXYnRyMFNNQzVBem82N3JTa0RnVXE0czlB?=
 =?utf-8?B?S0ZMY0lhMmEwVE96alB2aS9FUGtwOTkrZDR5WlAyODVMMktHcmpqdExHYXVQ?=
 =?utf-8?B?cWZjd3dmWkYxYzNSb245eU5oOHNUU0RObmxqVEd5M1h4anFOUFRvc2FPT3Ft?=
 =?utf-8?B?bzNYR0hJWldOWlJLeTVaUSticmZCK3lDTjRLK3F6NWdCWlpyRzd2TzhhaDFT?=
 =?utf-8?B?bVhzRURLK3hrMDlFaFMwMGpTU1VoaVAyNUVUR1hXU3RzbnA4SUx0VTI3azRH?=
 =?utf-8?B?NlZ5b014MFZtTklsVW84WkFtUEZJaGR2WXM1bTNDT1VTQ29vSTJnck82M0tu?=
 =?utf-8?B?S0h3SFJqMUpDaDNNeTRrVlloZ0g0QVVTM3oyb3cxcGtEblUvKy9OQ1A3REs3?=
 =?utf-8?B?dWMybGJrS3JucDR2Q0wwSllocmtRYlR4N3cyWmdwQzRWR1N1UzRJTjRTV1dp?=
 =?utf-8?B?TW9SRUZpY3A3RGpMdHFrb1NONmsrNkNEejR5SHJJYnYrcm83Y2h4MEhzeG1C?=
 =?utf-8?B?ZXBYOHJYYmNmd2I2TTJNaFhnZ3NSblRqNncxWHdNZVRXRFJlRXRLWnI1azVT?=
 =?utf-8?B?dVNyVzIzVmpxZjRaSEk5RHcvaVJWL011Q1MxeGs5UlFwcnY1Tm0yTitwY1g5?=
 =?utf-8?B?NCtnNnFoNzNIT2ZuZURZNEpTT3d3bE1zU3RmaEFXR2xlTXZ5WWJPb2xjVDl3?=
 =?utf-8?B?U2JUL2I3dmxSWlN6b0YycFl1K3Rhc29ZOUlERnp2OUxvSDVjWDFHMjdVTDBr?=
 =?utf-8?B?OXFaUGc2aC9RMjcrR1Q3YmFPVFc5SFdDc09CWElPUXRXZ21HQ0diQ292VTlk?=
 =?utf-8?B?VzV2TXc5TjN1K2RoREFscWxpU1orTkRGeHRjTXNDOXNHaThLdERoeFF4azlC?=
 =?utf-8?B?K0VVVXo0eTR5NFJta1U0SEc5cTdFa3NycjNzaWdCSHRlWFp6YkRNUDNUMHdS?=
 =?utf-8?B?cWNHcmRQRnEzOEhnZ3pBaVVUeUwrbmpjZjBwcXR5eEFmaXIzbmZJOE1RY0hH?=
 =?utf-8?B?Y2R2ZndDYmRPOTVPblc2TkduNmpyZi94STBOR1hZOHVzRSt6aUhrNWU5cDVW?=
 =?utf-8?B?RHZOSy9jaDFaUHVsTXFoVSt0N1B0NkxMck42SngxdFZRTCs5bEtUQXVtVXE4?=
 =?utf-8?B?QXRmcTNoc2JBdWlQRlBMVmJ4bmhZeHpGN3Aza0p3VUtYU0k3dmczQ0NMaDdI?=
 =?utf-8?B?U3pVMDNaSmNLLzFoaEFEUEZIVHYwV1NxVi9sbVd0cmNwdkM3YlFrL0FkcmZj?=
 =?utf-8?B?N2dqYXNsYktmTjIyS1ZadXNoUkVqaUZueU0zcUU1N240cDhaZjdLQzkvUENH?=
 =?utf-8?B?M05STTZudFppdHZNdms4azVrckxIVkhXTXNSUFNGZlkxdWFtdkdhQmNONmJ5?=
 =?utf-8?B?TFZnSUg2VkpLRW0zbXZYeGYzREJPSUE4N0pnZ3MxbmxmYUkvSXlhdExMdlhm?=
 =?utf-8?B?V0lqOUtYMytpNnh0c2I0VDNERFBOZEt6a3YzaUVIakVZN0cycE9QeUMrUXM5?=
 =?utf-8?B?ZHFTbzZCTWZ5dVpQdGNlVTZaajkvcE5HTzlvNVBHUnlXRlFzVHpKc0tyMGRq?=
 =?utf-8?B?TnJRZkt3dFdsYVB3eFZDbnA4czZYU1VxTEVtcjY3WnM4ZEhWTnRiYm15Wkxm?=
 =?utf-8?B?WVEwRDJYeFNwdEhpRWw2TlorUkNWVThFSXhCZStSRnM2a2gzdmUyTFpoUGsv?=
 =?utf-8?B?Slo1czFFczhBMTNuUkFadjZLYmtCdjA1NTNEWmF0S29mNFIzbUdvUXV4TXhM?=
 =?utf-8?B?QXppTzJTY2tGT1N6Nk84RDJjT1NwUU5rd2FkeFNTd0hDZytGNTZDSVpTUXI4?=
 =?utf-8?B?S2hUdGd4UDlmWStVSXZ6Uzd1REpxVmJmZjBWZWY0bCtJTjJISEdyK1FzY1p4?=
 =?utf-8?B?VHc9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24991991-e217-421c-70ab-08dd51054f9f
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 16:49:01.1839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3WQ2Q3n1+64gqmUeYECCwCR0Yt/8Ega1Nq3iYPBCmgdSYm9vkC4chrzIOQbKzVgVBJ4BT+g2vw3zX+gCKeX1GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6207
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Feb 2025 16:49:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17248

--------------afxK89gajdWg3U21nmmUuEIG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.02.2025 um 18:29 schrieb Richard Purdie:
> FWIW I did try and discuss this in the OE TSC meeting today but it is a
> US holiday. There were only two people who showed up.

I answer your points below but does it make sense to create a RFC to 
show how an alternative source URI management in oe-core could look 
like. I could demonstrate my approach and you could perhaps illustrate 
your concerns in the code.

> On Mon, 2025-02-17 at 17:38 +0100, Stefan Herbrechtsmeier wrote:
>>   Am 17.02.2025 um 13:43 schrieb Richard Purdie:
>>   On Mon, 2025-02-17 at 12:00 +0100, Stefan Herbrechtsmeier wrote:
>>>>   Am 13.02.2025 um 11:43 schrieb Richard Purdie via lists.openembedded.org:
>>>>> e) add the ability to add custom hooks in the fetch process to
>>>>> handle
>>>>> the cases of needing to alter the flow for patching the components
>>>>> list
>>>>>   
>>>> I fear this isn't easy possible and we have a design problem. Bitbake
>>>> and oe-core assume that a patch doesn't influence the fetch and that
>>>> the SRC_URI contains all fetched sources. Many code use the Fetch
>>>> class or the SRC_URI direct and doesn't expect recursive implicit
>>>> URIs of gitsm. In reality the SRC_URI describe the given URIs only
>>>> and doesn't contain the additional implicit URIs. The task flow
>>>> applies patches after the unpack and prevent patches to the gitsm. In
>>>> reality a patch could influence the implicit URIs and isn't
>>>> independent.
>>>>
>>>> I would recommend to keep the patching outside of bitbake and instead
>>>> handle the implicit URIs inside oe-core. We could write the implicit
>>>> URIs into files in the work directory and migrate the scattered
>>>> direct users of the SRC_URI / Fetch class to a common oe-core
>>>> function. This functions returns the given URIs and optional any
>>>> additional implicit URIs. This allows the usage of the task
>>>> dependencies to ensure that the implicit URIs are resolved before
>>>> use.
>>>>
>>>> The package manager lock file needs a single unpack and patch step
>>>> whereas the gitsm needs a recursive unpack and patch of every
>>>> successive gitsm. This makes it impossible to use additional tasks.
>>>> We could add the resolve of the implicit URIs to the fetch task to
>>>> support recursive resolve (gitsm).
>>>>   
>>>> 1. download SRC_URIs
>>>> 2. exit if no URI is marked as unresolved
>>>> 3. unpack unresolved URIs
>>>> 4. apply associated patches
>>>> 5. resolve URIs
>>>> 6. goto 2
>>>>   
>>>> This will eliminate the need for the partial implicit URI and gitsm
>>>> support in bitbake and makes the fetcher code simpler. The patching
>>>> could remain in oe-core and patches could be applied to gitsm and
>>>> package manager lock files. Additionally we remove code duplication
>>>> and simplify future changes to the SRC_URI determination.
>>>>
>>>> It will add an indirection for the SRC_URI but the current code
>>>> already shows that this makes problems. Only the archiver class uses
>>>> the expanded_urldata function and all other classes including the
>>>> spdx class ignore the implicit SRC_URIs.
>>> I'm a bit worried we're getting caught up by the terminology. We don't
>>> necessarily have to "patch" the component list so much as allow
>>> something like a function to hook and adjust things. That then removes
>>> the need for it to be a specific task.
>>>
>>   We can use a common patch without a do_patch task. We could even
>> call the patch code from the do_patch without an extra task. I
>> propose to call the code from the do_patch task in the do_fetch task.
>> It doesn't matter if we use a hook or task. We should minimize the
>> work for the user. The common solution to manipulate a package
>> manager lock file is a patch file and we have the code to handle
>> patch files.
> One of the challenges is the "patch" code/module lives in OE-Core. That
> means the fetcher can't call into it.

That's the reason I would restrict the fetcher to the plain fetch.

> I appreciate this means you'll argue the fetcher code should move to
> OE, or the vendor code should be in OE, however I am pretty decided
> that is a really bad idea. Whether I can convey why, I don't know but I
> have tried.

I argue that the fetcher should focus on the download and unpack of the 
provides URIs. I don't understand why the parsing of a source file and 
the preparation of a cache or vendor folder belongs to the fetcher. The 
fetcher downloads and unpack the provide URIs. The fetcher doesn't care 
if the provided URIs are static defined inside the recipe or implicit 
generated from a source file.

At the moment a lot of code inside oe-core assume that the SRC_URI 
contains all source URIs. This is already wrong because gitsm expand the 
SRC_URI. Only the archiver bitbake class use the SRC_URI in the expanded 
way. This means we have to fix a lot of users anyway. The gitsm approach 
embed the unpack step into the fetcher and avoid a patch step between 
the unpack and parsing of the source. This works for git because the 
destsuffix is known. In case of an archive we have to provide the 
relative directory inside the archive. This means we have to use 
variables inside the fetcher commands, pass more function arguments or 
extent the SRC_URI parameters. The alternative is to introduce implicit 
URIs. The SRC_URI only contains the static defined URIs from the recipe 
and we introduce a new API to collect the dynamic implicit URIs or all 
URIs together. The URIs are saved inside a fixed folder inside the 
WORKDOR. Its like an .inc file but the file is generated on-the-fly. The 
URIs still use the fetcher for download an unpack but we have a separate 
step for the SRC_URI and the implicit URIs. We have different 
possibilities to combine and distribute the steps onto tasks or 
postfuncs. We could add tasks to resolve, fetch, unpack and patch the 
implicit sources after the do_unpack. We could add tasks to fetch, 
unpack and patch the sources from the SRC_URI or only parts of it before 
the do_fetch or we could integrate the steps into the do_fetch. We could 
reuse the output from an previews task or use a fresh start like a plain 
unpack and patch of all sources. We could reuse the code to provide a 
manual update step to create a inc file. We need to improve the usage of 
the SRC_URI in any case because it is used like any other variable and 
it is unclear that an entry inside the SRC_URI could be expanded to 
multiple URIs.

> I also very strongly want to maintain our separation of do_fetch,
> do_unpack and do_patch.

What does this mean? The do_fetch of embedded dependencies requires an 
unpack. Therefore we have to split the tasks or disallow any dynamic. 
The oe-core solution allows a full separation whereas the bitbake 
solution require duplication inside bitbake.

>>> I'm also not sure that drawing gitsm into this is a great idea when it
>>> is effectively already working  quite well.
>> To my knowledge it isn't possible to patch a sub module revision. Is
>> it intended that the SBOM doesn't contain the recursive implicit git
>> repositories?
> A patch was merged to allow the data about implicit git repos (amongst
> other things) to be available:
>
> https://git.yoctoproject.org/poky/commit/bitbake/?id=ef3e46afd910d4b7727d42c4c18b501525c65695
>
> That tracer code was added after a lot of discussion that took up a ton
> of my time, then people moved on and it hasn't seem much
> development/use :(.
>
> So there were mechanisms added to make the data available.

Why was this needed? We already have a function for the fetchers to 
provide the expand URLs.

>>>   I appreciate the desire to
>>> have neat abstractions applying accross everything equally but I'm not
>>> sure we can achieve that with the level of usability we need and I'd
>>> rather improve usability at the cost of the inclusion of gitsm, which
>>> is the most functional fetcher we currently have in this group.
>> I include gitsm because it is similar to the package manager and have
>> some drawbacks which I solve with my approach. It is the only fetcher
>> that parse a file to determine additional URIs. Its integration into
>> oe-core is sub-optimal.
> I believe there was a way added to solve the drawback you mention. The
> same mechanism could be used for other fetchers too yet we're talking
> about much more radical re-designs.

Do you have a hint for that way so that I can look into it.

>>> I will repeat again that I do strongly feel that a strong API in
>>> bitbake is going to lead to an overall better design that something
>>> bolted onto the fetcher in OE-Core.
> The "fetcher" is an API exposed by Bitbake with the intent of
> standardising the fetching of source code. It's aim is to support
> objectives such as allowing resilience through source mirrors and
> support build reproducibility. There is a document in bitbake which
> tries to at least summarise some of that after it was requested it be
> written down.

What is the fetching of the source code and why doesn't the oe-core 
solution doesn't fit? It uses the fetcher to fetch the sources. The only 
different is that it pass the URIs explicit and doesn't fetch the 
SRC_URI only.

>> What is a fetcher? We have fetchers for protocols (wget, git),
> These were the original fetchers using the original APIs.
>
>> wrapper around other fetchers (crate, gomod and gomodgit)
> These are newer and some work better than others are people have
> attempted to git the newer languages into the older framework.

But this is possible without a fetcher. The crate, gomod and my npm 
fetcher mainly override the urldata_init and unpack function. The same 
functionality can be provided by a python function to define the SRC_URI 
(replace urldata_init function) and a task or postfunc for unpack 
(replace unpack function). The advantage is a plain URL in the SRC_URI 
and the cache or vendor folder handling isn't scattered over a fetcher 
and bbclass. If we use a oe library for the important code we could 
simplify the tests because we could test individual steps. Even the 
debugging could be simpler if we use a separate task to populate the 
cache or vendor folder from the downloaded artifacts. The appropriate 
code is already in my oe-core series.

>>   and wrapper around other fetchers which embedded file parser (gitsm,
>> npmsw).
> Of these, gitsm is now relatively successfully integrated and
> functional.

Doesn't Bruce have problems with it and replace it by plain git URIs?

I think the main part of the successful integration is that you doesn't 
need any manual step to fetch the embedded dependencies. The main 
difference to the package managers is that it is uncommon to use patches 
for gitsm. Every sub module defines the version of its sub module 
whereas a package only defines it compatibility. The package versions 
are defined inside the main source.

>>   Thereby the gitsm fetcher fetch a source and parse the embedded
>> file. The npmsw fetcher parse a file from the meta layer. The gitsm
>> fetcher recursive combines the download and unpack function call in
>> mostly every class function.
> Sadly there did not seem to be any other way to handle that. I'd
> imagine that some of the other fetchers are going to have to work
> similarly, unfortunately.
The problem of the bitbake fetcher is the unclear caching and the 
missing dependency between the steps. This is the advantage of oe-core. 
We can simple arrange everything which need this information after the 
resolve task.

>> The wrappers has the disadvantage that they use uncommon URIs which
>> are useless for the SBOM. We support PyPI without the need for an
>> extra fetcher.
> We support pypi in so much as we have a recipe per dependency. That was
> not deemed possible for npm or crates.
That's no reason for or against a pypi fetcher or a crate_src_uri function.

> I would disagree that uncommon
> URIS are useless for SBOMs. They can be problematic but having the data
> there means it is at least listed.
But it reduce the usability of the SBOM.

>   There are also ways they can be
> extended (e.g. the intercept code I link to above).
>
>> Is PyPI or crate the desired way to go?
> Compared to the complexity in some of the patches proposed, I'd
> actually say yes.
What complexity do you mean? Some of the complexity of my patches comes 
from the limitation and fixed use cases of the existing code.

The gomod fetcher contain a feature to extract the .mod from a .zip 
file. This isn't needed because the go.sum file contains entries for the 
.mod and .zip file. The compatible solution would be do download the 
.mod and .zip file.

The crate fetcher implements its own unpack code. It behavior depends on 
the BP variable. The unpack function writes a meta file which is need to 
use the source inside the vendor folder. This makes it impossible to 
reuse the code for plain URIs. Alternative the URI could be marked as 
crate vendor source and an extra step could create the meta file for all 
marked URIs.

>> nstead of expand the fetcher I would focus the fetcher on the
>> download of provides URIs and keep the file parsing and post unpack
>> processing outside of it.
> The challenge is that once you process it, you need to fetch more
> things. Our ecosystem is built on the idea that fetching happens in
> do_fetch. If we change that most mirroring scripts break for example.
> It is like compiling happening during do_configure or do_install - it
> is not what the user expects and that is problematic. I am against
> changing behaviour in ways users do not expect.

I don't change the exception. The exceptions are the reason for the 
state of the series.

The missing point is that the expectation is related to the end of a 
dependency chain and not to a task itself. In any case the real 
expectation isn't clear. What happens if the configuration need a 
compiled source and it isn't feasible to create a native package. My 
series satisfy the following expectations:

* All sources are downloaded after the do_fetch
* All sources are unpacked after the do_unpack
* All sources are patched after the do_patch

The series contains one possible solutions. There are multiple other 
solutions to reach the same inside oe-core by distributing the following 
steps over task:

run_early_fetch - Download the source with the lock files from SRC_URI
run_early_unpack - Unpack the source with the lock files from SRC_URI 
(after run_early_fetch)
run_early_patch - Apply patch which manipulate the lock files from 
SRC_URI (after run_early_patch)
run_resolve - Parse the lock files to resolve the dependency sources 
(after run_early_patch)
run_vendor_fetch - Download the dependency sources (after run_resolve)
run_vendor_unpack - Unpack the dependency sources (after run_vendor_fetch)
run_vendor_patch - Patch the dependency sources (after run_vendor_unpack)
run_fetch - Download the additional source from SRC_URI
run_unpack - Unpack the additional source from SRC_URI (after run_fetch)
run_patch - Apply the additional source from SRC_URI (after run_unpack)

Some of the steps could be combined, repeat or integrated into other 
task. For example the run_early_fetch and run_fetch are a simple fetch 
of the SRC_URI list whereas the run_early_fetch alone is a fetch of a 
filtered SRC_URI list.

Series:

do_early_fetch : run_early_fetch
do_early_unpack : run_early_unpack
do_early_patch : run_early_patch
do_resolve : run_resolve
do_fetch : run_fetch, run_early_fetch, run_vendor_fetch
do_unpack: run_unpack, run_early_unpack, run_vendor_unpack
do_patch: run_patch, run_early_patch, run_vendor_patch

WIP:

do_fetch : run_fetch, 
run_early_fetch, run_early_unpack, run_early_patch, run_resolve, 
run_vendor_fetch
do_unpack: run_unpack, run_early_unpack, run_vendor_fetch
do_patch: run_patch, run_early_patch, run_vendor_patch

The bitbake approach looks like the WIP but makes the run_early_patch 
complicated or impossible.

I prefer something like the first approach because it is similar to the 
.inc file approach and the separate tasks are easier to debug. The 
do_fetch, do_unpack and do_patch task works like before. The only 
difference is that the implicit URIs are managed outside of the fetcher. 
At the moment this only influence a single user outside of the fetch, 
unpack and patch tasks but we could use the opportunity to fix other 
users as well (ex. SBOM).

>> The package manager lock file is a simple file which references to
>> package sources. Thereby a main source could contain multiple package
>> manager lock files. At the moment we have no fetcher which reference
>> an other source as base or combines multiple fetchers.
> This is the case for good reason. If the lock file references all the
> sources, perhaps we should just include it alongside the recipe and be
> done with it?

This is possible but the user have manual copy the lock file from the 
source to the meta layer, manual apply patches to it and ensure that the 
source and lock file are in sync.

Why is the bitbake fetcher the correct place to parse a lock file?

Why is it a bad idea to generate and manage the URIs outside of bitbake?

>> Based on my two proposed solutions and the work the last month, I
>> have the following feasible requirements:
>>   * Support patches for the package manager lock file to simply
>       updates, back ports and upsteaming
>>   * Support multiple package manager lock files per main source
>>   * Include the real https or git URI in the SBOM
>>   * Include the dependency name and version in the SBOM
>>   * No manual bitbake command call after a SRC_URI, PV or SRCREV
>> change
> I think we may have to relax some of these requirements as we can't do
> everything.
>> The following code is mostly used in oe-core and ignore the implicit
>> URIs:
>>
>>      src_uri = (d.getVar('SRC_URI') or "").split()
>>      fetcher = bb.fetch2.Fetch(src_uri, d)
>>      for url in fetcher.urls:
>>
>> The following code is used in the archiver class only and includes
>> the implicit URIs:
>>
>>      src_uri = get_src_uris(d)
>>      fetcher = bb.fetch2.Fetch(src_uri, d)
>>      for ud in fetcher.expanded_urldata():
>   
> Ironically, I think this an example of the kind of "strong API" I'm
> referring to, where a standard API is exposed by bitbake. In some ways
> this was already attempted with the tracer API above where the
> expand_urldata call would actually be a call into the tracer API to
> obtain the actual urls used.

Sorry but I think the tracer API isn't needed because we have already 
all information and possible functions inside the fetcher.

This "strong API" make it complicated to patch the source. Either the 
API depends on bitbake variables or it depends on the provides hooks. 
This means if somebody miss a hook or a bitbake variable he will get an 
other output.

The primary function of the fetcher is to download and unpack of the 
sources. Why do we use it for management of the source URIs? Why don't 
we manage the source URIs outside of bitbake? We can save the source 
URIs inside the WORKDIR and provide an additional common api to it. At 
the moment every user create a new instance of the Fetch object and in 
many cases manual pass the SRC_URI to it:

     for url in oe.fetcher.get_source_uris(d):

We could add a new task to create the files and allows the user to 
inspect it. I could provide a RFC if it helps the discussion.

>> My last series enable oe-core to generate implicit URIs and therefore
>> replace the usage of the plain SRC_URI with a function:
>>
>>       fetcher = bb.fetch.Fetch(get_src_uris(d), d)
>>      for url in fetcher.urls:
>>
>>   The SRC_URI contains the given URIs and the get_src_uri function
>> contains the given and implicit URIs. The concept is taken from other
>> classes like the spdx classes which use files to exchange data
>> between tasks.
> I believe the get_src_uris() functionality should happen within the
> fetcher module and not outside of it as a bolt on interface.

It isn't bolt on the interface. It provides an interface on top of the 
fetcher. The fetcher download and unpack the source but the sources are 
managed inside oe-core. At the moment the management doesn't really 
exist because the sources are only consists of the SRC_URI variable.

> I do not know where we go from here. You disagree with me on several
> key things

It's not about consent, it's about trying to understand the reasons. 
I've been working on this topic for years and have tried out different 
options. I think I have a solution that is very easy to use. In order to 
improve the solution, I try to understand the reasons for the other 
decisions. I don't understand why it is desired to add code to the 
fetcher which works independent of network access and why it is desired 
to create a fetcher object to receive the list of source URIs.

>   such as whether the code should be in bitbake or OE-Core,
I have the fear that the bitbake solution limit the possibilities 
without an advantage. The complexity depends on the feature not on the 
point of implementation.

> whether gitsm should be changed,

I use gitsm as a benchmark to evaluate concepts and approaches. It is 
better known as a lock file and a complex use case because of the 
recursive sources. It doesn't matter if we change it but the selected 
approach should support a replacement without limitations or clearly 
state why it isn't supported.

>   whether we need to have some kind of
> checksum to verify the "lockfile" is correct as originally intended in
> the recipe and probably more.
I want to prevent us from having the wrong motivation due to a lack of 
understanding of the lock file. Why don't we add a look file across all 
expanded URIs, regardless of the source of the URI, because we could 
have the same problems in the other fetchers.

> I'm in the position of trying to mediate things (i.e. see the different
> viewpoints and bring people together, trying to find common ground) and
> yet at the same time, express views as someone who as spent a lot of
> years trying to maintain and improve this code.
I appreciate your work.

But I sometimes have the feeling that the code is a patchwork quilt and 
every attempt to replace several patches with something common is met 
with rejection.

> I have tried to seek help from the people who effectively oversee me as
> a maintainer (i.e. the TSC) with limited success. I'm not sure what to
> do from here.

I really like to upstream my work because I think it would simplify the 
package manager support, but there doesn't seem to be much interest in 
the community for it.

--------------afxK89gajdWg3U21nmmUuEIG
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Am 17.02.2025 um 18:29 schrieb Richard
      Purdie:<br>
    </div>
    <blockquote type="cite" cite="mid:7537c9d9305dd3c7d05cbf36bccfe47c1858f822.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">FWIW I did try and discuss this in the OE TSC meeting today but it is a
US holiday. There were only two people who showed up.</pre>
    </blockquote>
    <p>I answer your points below but does it make sense to create a RFC
      to show how an alternative source URI management in oe-core could
      look like. I could demonstrate my approach and you could perhaps
      illustrate your concerns in the code.<br>
      <br>
      <span style="white-space: pre-wrap">
</span></p>
    <blockquote type="cite" cite="mid:7537c9d9305dd3c7d05cbf36bccfe47c1858f822.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">On Mon, 2025-02-17 at 17:38 +0100, Stefan Herbrechtsmeier wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">&nbsp;Am 17.02.2025 um 13:43 schrieb Richard Purdie:
&nbsp;On Mon, 2025-02-17 at 12:00 +0100, Stefan Herbrechtsmeier wrote:
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">&nbsp;Am 13.02.2025 um 11:43 schrieb Richard Purdie via lists.openembedded.org:
</pre>
            <blockquote type="cite">
              <pre wrap="" class="moz-quote-pre">
e) add the ability to add custom hooks in the fetch process to
handle
the cases of needing to alter the flow for patching the components
list
&nbsp;
</pre>
            </blockquote>
            <pre wrap="" class="moz-quote-pre">I fear this isn't easy possible and we have a design problem. Bitbake
and oe-core assume that a patch doesn't influence the fetch and that
the SRC_URI contains all fetched sources. Many code use the Fetch
class or the SRC_URI direct and doesn't expect recursive implicit
URIs of gitsm. In reality the SRC_URI describe the given URIs only
and doesn't contain the additional implicit URIs. The task flow
applies patches after the unpack and prevent patches to the gitsm. In
reality a patch could influence the implicit URIs and isn't
independent.

I would recommend to keep the patching outside of bitbake and instead
handle the implicit URIs inside oe-core. We could write the implicit
URIs into files in the work directory and migrate the scattered
direct users of the SRC_URI / Fetch class to a common oe-core
function. This functions returns the given URIs and optional any
additional implicit URIs. This allows the usage of the task
dependencies to ensure that the implicit URIs are resolved before
use.

The package manager lock file needs a single unpack and patch step
whereas the gitsm needs a recursive unpack and patch of every
successive gitsm. This makes it impossible to use additional tasks.
We could add the resolve of the implicit URIs to the fetch task to
support recursive resolve (gitsm).
&nbsp;
1. download SRC_URIs
2. exit if no URI is marked as unresolved
3. unpack unresolved URIs
4. apply associated patches
5. resolve URIs
6. goto 2 
&nbsp;
This will eliminate the need for the partial implicit URI and gitsm
support in bitbake and makes the fetcher code simpler. The patching
could remain in oe-core and patches could be applied to gitsm and
package manager lock files. Additionally we remove code duplication
and simplify future changes to the SRC_URI determination.

It will add an indirection for the SRC_URI but the current code
already shows that this makes problems. Only the archiver class uses
the expanded_urldata function and all other classes including the
spdx class ignore the implicit SRC_URIs.
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">
I'm a bit worried we're getting caught up by the terminology. We don't
necessarily have to &quot;patch&quot; the component list so much as allow
something like a function to hook and adjust things. That then removes
the need for it to be a specific task.

</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
&nbsp;We can use a common patch without a do_patch task. We could even
call the patch code from the do_patch without an extra task. I
propose to call the code from the do_patch task in the do_fetch task.
It doesn't matter if we use a hook or task. We should minimize the
work for the user. The common solution to manipulate a package
manager lock file is a patch file and we have the code to handle
patch files.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
One of the challenges is the &quot;patch&quot; code/module lives in OE-Core. That
means the fetcher can't call into it.</pre>
    </blockquote>
    <p>That's the reason I would restrict the fetcher to the plain
      fetch.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:7537c9d9305dd3c7d05cbf36bccfe47c1858f822.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">I appreciate this means you'll argue the fetcher code should move to
OE, or the vendor code should be in OE, however I am pretty decided
that is a really bad idea. Whether I can convey why, I don't know but I
have tried.
</pre>
    </blockquote>
    <p>I argue that the fetcher should focus on the download and unpack
      of the provides URIs. I don't understand why the parsing of a
      source file and the preparation of a cache or vendor folder
      belongs to the fetcher. The fetcher downloads and unpack the
      provide URIs. The fetcher doesn't care if the provided URIs are
      static defined inside the recipe or implicit generated from a
      source file.<br>
      <br>
      At the moment a lot of code inside oe-core assume that the SRC_URI
      contains all source URIs. This is already wrong because gitsm
      expand the SRC_URI. Only the archiver bitbake class use the
      SRC_URI in the expanded way. This means we have to fix a lot of
      users anyway. The gitsm approach embed the unpack step into the
      fetcher and avoid a patch step between the unpack and parsing of
      the source. This works for git because the destsuffix is known. In
      case of an archive we have to provide the relative directory
      inside the archive. This means we have to use variables inside the
      fetcher commands, pass more function arguments or extent the
      SRC_URI parameters. The alternative is to introduce implicit URIs.
      The SRC_URI only contains the static defined URIs from the recipe
      and we introduce a new API to collect the dynamic implicit URIs or
      all URIs together. The URIs are saved inside a fixed folder inside
      the WORKDOR. Its like an .inc file but the file is generated
      on-the-fly. The URIs still use the fetcher for download an unpack
      but we have a separate step for the SRC_URI and the implicit URIs.
      We have different possibilities to combine and distribute the
      steps onto tasks or postfuncs. We could add tasks to resolve,
      fetch, unpack and patch the implicit sources after the do_unpack.
      We could add tasks to fetch, unpack and patch the sources from the
      SRC_URI or only parts of it before the do_fetch or we could
      integrate the steps into the do_fetch. We could reuse the output
      from an previews task or use a fresh start like a plain unpack and
      patch of all sources. We could reuse the code to provide a manual
      update step to create a inc file. We need to improve the usage of
      the SRC_URI in any case because it is used like any other variable
      and it is unclear that an entry inside the SRC_URI could be
      expanded to multiple URIs.<br>
      <br style="white-space: pre-wrap;"></p>
    <blockquote type="cite" cite="mid:7537c9d9305dd3c7d05cbf36bccfe47c1858f822.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">I also very strongly want to maintain our separation of do_fetch,
do_unpack and do_patch.
</pre>
    </blockquote>
    <p>What does this mean? The do_fetch of embedded dependencies
      requires an unpack. Therefore we have to split the tasks or
      disallow any dynamic. The oe-core solution allows a full
      separation whereas the bitbake solution require duplication inside
      bitbake. <br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:7537c9d9305dd3c7d05cbf36bccfe47c1858f822.camel@linuxfoundation.org">
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">I'm also not sure that drawing gitsm into this is a great idea when it
is effectively already working  quite well.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
To my knowledge it isn't possible to patch a sub module revision. Is
it intended that the SBOM doesn't contain the recursive implicit git
repositories?
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
A patch was merged to allow the data about implicit git repos (amongst
other things) to be available:

<a class="moz-txt-link-freetext" href="https://git.yoctoproject.org/poky/commit/bitbake/?id=ef3e46afd910d4b7727d42c4c18b501525c65695">https://git.yoctoproject.org/poky/commit/bitbake/?id=ef3e46afd910d4b7727d42c4c18b501525c65695</a>

That tracer code was added after a lot of discussion that took up a ton
of my time, then people moved on and it hasn't seem much
development/use :(.

So there were mechanisms added to make the data available.
</pre>
    </blockquote>
    <p>Why was this needed? We already have a function for the fetchers
      to provide the expand URLs. <br>
      <br>
      <span style="white-space: pre-wrap">
</span></p>
    <blockquote type="cite" cite="mid:7537c9d9305dd3c7d05cbf36bccfe47c1858f822.camel@linuxfoundation.org">
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">&nbsp;I appreciate the desire to
have neat abstractions applying accross everything equally but I'm not
sure we can achieve that with the level of usability we need and I'd
rather improve usability at the cost of the inclusion of gitsm, which
is the most functional fetcher we currently have in this group.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
I include gitsm because it is similar to the package manager and have
some drawbacks which I solve with my approach. It is the only fetcher
that parse a file to determine additional URIs. Its integration into
oe-core is sub-optimal.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I believe there was a way added to solve the drawback you mention. The
same mechanism could be used for other fetchers too yet we're talking
about much more radical re-designs.
</pre>
    </blockquote>
    <p>Do you have a hint for that way so that I can look into it.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:7537c9d9305dd3c7d05cbf36bccfe47c1858f822.camel@linuxfoundation.org">
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">I will repeat again that I do strongly feel that a strong API in
bitbake is going to lead to an overall better design that something
bolted onto the fetcher in OE-Core.
</pre>
        </blockquote>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
The &quot;fetcher&quot; is an API exposed by Bitbake with the intent of
standardising the fetching of source code. It's aim is to support
objectives such as allowing resilience through source mirrors and
support build reproducibility. There is a document in bitbake which
tries to at least summarise some of that after it was requested it be
written down.
</pre>
    </blockquote>
    <p>What is the fetching of the source code and why doesn't the
      oe-core solution doesn't fit? It uses the fetcher to fetch the
      sources. The only different is that it pass the URIs explicit and
      doesn't fetch the SRC_URI only.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:7537c9d9305dd3c7d05cbf36bccfe47c1858f822.camel@linuxfoundation.org">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">What is a fetcher? We have fetchers for protocols (wget, git),
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
These were the original fetchers using the original APIs.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">wrapper around other fetchers (crate, gomod and gomodgit)
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
These are newer and some work better than others are people have
attempted to git the newer languages into the older framework.
</pre>
    </blockquote>
    <p>But this is possible without a fetcher. The crate, gomod and my
      npm fetcher mainly override the urldata_init and unpack function.
      The same functionality can be provided by a python function to
      define the SRC_URI (replace urldata_init function) and a task or
      postfunc for unpack (replace unpack function). The advantage is a
      plain URL in the SRC_URI and the cache or vendor folder handling
      isn't scattered over a fetcher and bbclass. If we use a oe library
      for the important code we could simplify the tests because we
      could test individual steps. Even the debugging could be simpler
      if we use a separate task to populate the cache or vendor folder
      from the downloaded artifacts. The appropriate code is already in
      my oe-core series.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:7537c9d9305dd3c7d05cbf36bccfe47c1858f822.camel@linuxfoundation.org">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> and wrapper around other fetchers which embedded file parser (gitsm,
npmsw).
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Of these, gitsm is now relatively successfully integrated and
functional.
</pre>
    </blockquote>
    <p>Doesn't Bruce have problems with it and replace it by plain git
      URIs?<br>
      <br>
      I think the main part of the successful integration is that you
      doesn't need any manual step to fetch the embedded dependencies.
      The main difference to the package managers is that it is uncommon
      to use patches for gitsm. Every sub module defines the version of
      its sub module whereas a package only defines it compatibility.
      The package versions are defined inside the main source.<br>
      <br>
      <span style="white-space: pre-wrap">
</span></p>
    <blockquote type="cite" cite="mid:7537c9d9305dd3c7d05cbf36bccfe47c1858f822.camel@linuxfoundation.org">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> Thereby the gitsm fetcher fetch a source and parse the embedded
file. The npmsw fetcher parse a file from the meta layer. The gitsm
fetcher recursive combines the download and unpack function call in
mostly every class function.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Sadly there did not seem to be any other way to handle that. I'd
imagine that some of the other fetchers are going to have to work
similarly, unfortunately.
</pre>
    </blockquote>
    The problem of the bitbake fetcher is the unclear caching and the
    missing dependency between the steps. This is the advantage of
    oe-core. We can simple arrange everything which need this
    information after the resolve task. <br>
    <br>
    <blockquote type="cite" cite="mid:7537c9d9305dd3c7d05cbf36bccfe47c1858f822.camel@linuxfoundation.org">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">The wrappers has the disadvantage that they use uncommon URIs which
are useless for the SBOM. We support PyPI without the need for an
extra fetcher.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
We support pypi in so much as we have a recipe per dependency. That was
not deemed possible for npm or crates.
</pre>
    </blockquote>
    That's no reason for or against a pypi fetcher or a crate_src_uri
    function. <br>
    <br>
    <blockquote type="cite" cite="mid:7537c9d9305dd3c7d05cbf36bccfe47c1858f822.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">I would disagree that uncommon
URIS are useless for SBOMs. They can be problematic but having the data
there means it is at least listed.
</pre>
    </blockquote>
    But it reduce the usability of the SBOM.<br>
    <br>
    <blockquote type="cite" cite="mid:7537c9d9305dd3c7d05cbf36bccfe47c1858f822.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">
 There are also ways they can be
extended (e.g. the intercept code I link to above).

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Is PyPI or crate the desired way to go?
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Compared to the complexity in some of the patches proposed, I'd
actually say yes.
</pre>
    </blockquote>
    What complexity do you mean? Some of the complexity of my patches
    comes from the limitation and fixed use cases of the existing code.<br>
    <p>The gomod fetcher contain a feature to extract the .mod from a
      .zip file. This isn't needed because the go.sum file contains
      entries for the .mod and .zip file. The compatible solution would
      be do download the .mod and .zip file.<br>
      <br>
      The crate fetcher implements its own unpack code. It behavior
      depends on the BP variable. The unpack function writes a meta file
      which is need to use the source inside the vendor folder. This
      makes it impossible to reuse the code for plain URIs. Alternative
      the URI could be marked as crate vendor source and an extra step
      could create the meta file for all marked URIs.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:7537c9d9305dd3c7d05cbf36bccfe47c1858f822.camel@linuxfoundation.org">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">nstead of expand the fetcher I would focus the fetcher on the
download of provides URIs and keep the file parsing and post unpack
processing outside of it.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
The challenge is that once you process it, you need to fetch more
things. Our ecosystem is built on the idea that fetching happens in
do_fetch. If we change that most mirroring scripts break for example.
It is like compiling happening during do_configure or do_install - it
is not what the user expects and that is problematic. I am against
changing behaviour in ways users do not expect.
</pre>
    </blockquote>
    <p>I don't change the exception. The exceptions are the reason for
      the state of the series.<br>
      <br>
      The missing point is that the expectation is related to the end of
      a dependency chain and not to a task itself. In any case the real
      expectation isn't clear. What happens if the configuration need a
      compiled source and it isn't feasible to create a native package.
      My series satisfy the following expectations:<br>
      <br>
      * All sources are downloaded after the do_fetch<br>
      * All sources are unpacked after the do_unpack<br>
      * All sources are patched after the do_patch<br>
      <br>
      The series contains one possible solutions. There are multiple
      other solutions to reach the same inside oe-core by distributing
      the following steps over task:<br>
    </p>
    <p>run_early_fetch - Download the source with the lock files from
      SRC_URI<br>
      run_early_unpack - Unpack the source with the lock files from
      SRC_URI (after run_early_fetch)<br>
      run_early_patch - Apply patch which manipulate the lock files from
      SRC_URI (after run_early_patch)<br>
      run_resolve - Parse the lock files to resolve the dependency
      sources (after&nbsp;run_early_patch)<br>
      run_vendor_fetch - Download the dependency sources (after
      run_resolve)<br>
      run_vendor_unpack - Unpack the dependency sources (after
      run_vendor_fetch)<br>
      run_vendor_patch - Patch the dependency sources (after
      run_vendor_unpack)<br>
      run_fetch - Download the additional source from SRC_URI<br>
      run_unpack - Unpack the additional source from SRC_URI (after
      run_fetch)<br>
      run_patch - Apply the additional source from SRC_URI (after
      run_unpack)<br>
      <br>
      Some of the steps could be combined, repeat or integrated into
      other task. For example the run_early_fetch and run_fetch are a
      simple fetch of the SRC_URI list whereas the run_early_fetch alone
      is a fetch of a filtered SRC_URI list.<br>
    </p>
    <p>Series:<br>
      <br>
      do_early_fetch : run_early_fetch<br>
      do_early_unpack : run_early_unpack <br>
      do_early_patch : run_early_patch<br>
      do_resolve : run_resolve <br>
      do_fetch : run_fetch, run_early_fetch, run_vendor_fetch<br>
      do_unpack: run_unpack, run_early_unpack, run_vendor_unpack<br>
      do_patch: run_patch, run_early_patch, run_vendor_patch <br>
      <br>
      WIP:<br>
      <br>
      do_fetch : run_fetch,
      run_early_fetch,&nbsp;run_early_unpack,&nbsp;run_early_patch,&nbsp;run_resolve,
      run_vendor_fetch<br>
      do_unpack: run_unpack, run_early_unpack, run_vendor_fetch<br>
      do_patch: run_patch, run_early_patch, run_vendor_patch <br>
      <br>
      The bitbake approach looks like the WIP but makes the
      run_early_patch complicated or impossible.<br>
      <br>
      I prefer something like the first approach because it is similar
      to the .inc file approach and the separate tasks are easier to
      debug. The do_fetch, do_unpack and do_patch task works like
      before. The only difference is that the implicit URIs are managed
      outside of the fetcher. At the moment this only influence a single
      user outside of the fetch, unpack and patch tasks but we could use
      the opportunity to fix other users as well (ex. SBOM).<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:7537c9d9305dd3c7d05cbf36bccfe47c1858f822.camel@linuxfoundation.org">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">The package manager lock file is a simple file which references to
package sources. Thereby a main source could contain multiple package
manager lock files. At the moment we have no fetcher which reference
an other source as base or combines multiple fetchers.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
This is the case for good reason. If the lock file references all the
sources, perhaps we should just include it alongside the recipe and be
done with it?
</pre>
    </blockquote>
    <p>This is possible but the user have manual copy the lock file from
      the source to the meta layer, manual apply patches to it and
      ensure that the source and lock file are in sync.<br>
      <br>
      Why is the bitbake fetcher the correct place to parse a lock file?<br>
      <br>
      Why is it a bad idea to generate and manage the URIs outside of
      bitbake?<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:7537c9d9305dd3c7d05cbf36bccfe47c1858f822.camel@linuxfoundation.org">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Based on my two proposed solutions and the work the last month, I
have the following feasible requirements:
 * Support patches for the package manager lock file to simply
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">     updates, back ports and upsteaming
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> * Support multiple package manager lock files per main source
 * Include the real https or git URI in the SBOM
 * Include the dependency name and version in the SBOM
 * No manual bitbake command call after a SRC_URI, PV or SRCREV
change
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I think we may have to relax some of these requirements as we can't do
everything.
</pre>
    </blockquote>
    <blockquote type="cite" cite="mid:7537c9d9305dd3c7d05cbf36bccfe47c1858f822.camel@linuxfoundation.org">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">The following code is mostly used in oe-core and ignore the implicit
URIs:

    src_uri = (d.getVar('SRC_URI') or &quot;&quot;).split()
    fetcher = bb.fetch2.Fetch(src_uri, d)
    for url in fetcher.urls:

The following code is used in the archiver class only and includes
the implicit URIs:

    src_uri = get_src_uris(d)
    fetcher = bb.fetch2.Fetch(src_uri, d)
    for ud in fetcher.expanded_urldata():
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre"> 
Ironically, I think this an example of the kind of &quot;strong API&quot; I'm
referring to, where a standard API is exposed by bitbake. In some ways
this was already attempted with the tracer API above where the
expand_urldata call would actually be a call into the tracer API to
obtain the actual urls used.
</pre>
    </blockquote>
    <p>Sorry but I think the tracer API isn't needed because we have
      already all information and possible functions inside the fetcher.<br>
      <br>
      This &quot;strong API&quot; make it complicated to patch the source. Either
      the API depends on bitbake variables or it depends on the provides
      hooks. This means if somebody miss a hook or a bitbake variable he
      will get an other output.<br>
      <br>
      The primary function of the fetcher is to download and unpack of
      the sources. Why do we use it for management of the source URIs?
      Why don't we manage the source URIs outside of bitbake? We can
      save the source URIs inside the WORKDIR and provide an additional
      common api to it. At the moment every user create a new instance
      of the Fetch object and in many cases manual pass the SRC_URI to
      it:<br>
      <br>
      &nbsp;&nbsp;&nbsp; for url in oe.fetcher.get_source_uris(d):<br>
      <br>
      We could add a new task to create the files and allows the user to
      inspect it. I could provide a RFC if it helps the discussion.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:7537c9d9305dd3c7d05cbf36bccfe47c1858f822.camel@linuxfoundation.org">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">My last series enable oe-core to generate implicit URIs and therefore
replace the usage of the plain SRC_URI with a function:

     fetcher = bb.fetch.Fetch(get_src_uris(d), d)
    for url in fetcher.urls:

 The SRC_URI contains the given URIs and the get_src_uri function
contains the given and implicit URIs. The concept is taken from other
classes like the spdx classes which use files to exchange data
between tasks.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I believe the get_src_uris() functionality should happen within the
fetcher module and not outside of it as a bolt on interface.
</pre>
    </blockquote>
    <p>It isn't bolt on the interface. It provides an interface on top
      of the fetcher. The fetcher download and unpack the source but the
      sources are managed inside oe-core. At the moment the management
      doesn't really exist because the sources are only consists of the
      SRC_URI variable.<br>
      <span style="white-space: pre-wrap">

</span></p>
    <blockquote type="cite" cite="mid:7537c9d9305dd3c7d05cbf36bccfe47c1858f822.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">I do not know where we go from here. You disagree with me on several
key things
</pre>
    </blockquote>
    <p>It's not about consent, it's about trying to understand the
      reasons. I've been working on this topic for years and have tried
      out different options. I think I have a solution that is very easy
      to use. In order to improve the solution, I try to understand the
      reasons for the other decisions. I don't understand why it is
      desired to add code to the fetcher which works independent of
      network access and why it is desired to create a fetcher object to
      receive the list of source URIs.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:7537c9d9305dd3c7d05cbf36bccfe47c1858f822.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre"> such as whether the code should be in bitbake or OE-Core,
</pre>
    </blockquote>
    I have the fear that the bitbake solution limit the possibilities
    without an advantage. The complexity depends on the feature not on
    the point of implementation.<br>
    <br>
    <blockquote type="cite" cite="mid:7537c9d9305dd3c7d05cbf36bccfe47c1858f822.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">whether gitsm should be changed,
</pre>
    </blockquote>
    <p>I use gitsm as a benchmark to evaluate concepts and approaches.
      It is better known as a lock file and a complex use case because
      of the recursive sources. It doesn't matter if we change it but
      the selected approach should support a replacement without
      limitations or clearly state why it isn't supported. <br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:7537c9d9305dd3c7d05cbf36bccfe47c1858f822.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre"> whether we need to have some kind of
checksum to verify the &quot;lockfile&quot; is correct as originally intended in
the recipe and probably more.
</pre>
    </blockquote>
    I want to prevent us from having the wrong motivation due to a lack
    of understanding of the lock file. Why don't we add a look file
    across all expanded URIs, regardless of the source of the URI,
    because we could have the same problems in the other fetchers.<br>
    <br>
    <blockquote type="cite" cite="mid:7537c9d9305dd3c7d05cbf36bccfe47c1858f822.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">I'm in the position of trying to mediate things (i.e. see the different
viewpoints and bring people together, trying to find common ground) and
yet at the same time, express views as someone who as spent a lot of
years trying to maintain and improve this code.
</pre>
    </blockquote>
    I appreciate your work.<br>
    <br>
    But I sometimes have the feeling that the code is a patchwork quilt
    and every attempt to replace several patches with something common
    is met with rejection.<br>
    <br>
    <blockquote type="cite" cite="mid:7537c9d9305dd3c7d05cbf36bccfe47c1858f822.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">I have tried to seek help from the people who effectively oversee me as
a maintainer (i.e. the TSC) with limited success. I'm not sure what to
do from here.
</pre>
    </blockquote>
    <p>I really like to upstream my work because I think it would
      simplify the package manager support, but there doesn't seem to be
      much interest in the community for it.<br>
    </p>
    <p><span style="white-space: pre-wrap">
</span></p>
  </body>
</html>

--------------afxK89gajdWg3U21nmmUuEIG--

