Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A713C021B1
	for <webhook@archiver.kernel.org>; Thu, 20 Feb 2025 16:02:03 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.138])
 by mx.groups.io with SMTP id smtpd.web11.53383.1740067316667338662
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Feb 2025 08:01:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@weidmueller.com header.s=selector2 header.b=SLCLmR7N;
 spf=pass (domain: weidmueller.com, ip: 40.107.103.138, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AO8k69Nfn9T/p+nMoj3Mf/XVUycErT2yH5l8T7bDuE0wundfgf5uSw3ekmBc04Kge5mwgJKLXtW+DBPd0/O8PxedQu8eRPj5btPDwydRyLal4+EkEeiBmN5+3L/MpdEnXSif+KQnkDqkPAdv5SJNXB1NBWeNZPjg4dFK+O4bkIE0q/qzXbjTKNGaSi3LIqO5yIOkV09iax9Ez1dlAB5jTWMorRrOPNZ5jegqgxVu1bLW2lnhEHYmvlTWivUmcZ4fTeTq6mlcwGshipI+7pdt9FmqLQdN2GPH0fy/xCww8DttEGKZM8axCNXBID8e7QxIC/S8/6F3JIxaqJQ3KFwJqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGUk4QNBYM3VkSJHXTEysYHdXgPgNlMBwi8BtCqd/vU=;
 b=ZAcRMBDpfGpNesiQ8x5mGb20GBEGQQfjhpXBQOtJ/A+ryDcy9H9BwhgqUh4GlkhIWwrBZ1ktAWu6oytUsMxzSEqxDjvvWxnOS0bhNC64Br19k4QRFRB+es8g23fPPW4bEJCJEUVf+axaDR0162nqhnzsucZphqQCk+IaQc4PNQTPQJSY/3uS5/WmocbzKETLjEdOWCC4co0BVYCu1/8AShdkA/WBwQH4P/BN/m8Hir9gTHCvsGcVeSca9t5LpXvrGElDoc/5Bb1wIpRlhiKW7g/6YKDpsT2+YQHgLNa/AiCj81aS9yvc0v8erekuWjA5aK9dstnXbMCxRFBUKxT0KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGUk4QNBYM3VkSJHXTEysYHdXgPgNlMBwi8BtCqd/vU=;
 b=SLCLmR7N3EjXWolMvrbjzZd0FfZGVWhms2K3hVoyV7uOIosy2ISp8xZZvMphZd5TLjPDq7XIXRB7CKaOxeh78iwEieTCq7IqHXZki4kz2BrjvupHUz2Zw57Twaqpaidgcqq+0pydflnM518yqf2xthI/TYvc653JJf48XoS5OKcBm0AOECPzAq0atVCzDD7q+bDyYt+sbObJqEPe+bnh4h0QRx988eZjxZZm+08YYfvrNa4QUNzaTz7/G3GjTEA2cQ9NcJQyNtzMkJc4wnA15Rl5TxoewkYwkUz3xMwx0mdWQfcg4k6MUfx6ZMCBlr0kcD/3zxW5GGMRFWLYZV1Aew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by GV1PR08MB7363.eurprd08.prod.outlook.com (2603:10a6:150:22::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Thu, 20 Feb
 2025 16:01:52 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 16:01:51 +0000
Content-Type: multipart/alternative;
 boundary="------------9w0v1704AMPEipzTogGuZ7Id"
Message-ID: <860b3a63-5510-438e-b99b-a33cbd909005@weidmueller.com>
Date: Thu, 20 Feb 2025 17:01:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] 'vendor' fetching discussion cont.
To: richard.purdie@linuxfoundation.org,
 openembedded-core@lists.openembedded.org,
 Bruce Ashfield <bruce.ashfield@gmail.com>,
 bitbake-devel <bitbake-devel@lists.openembedded.org>
References: <4cea4488ef3181471373f3dca26ac390203a90cb.camel@linuxfoundation.org>
 <55925709-d3e9-49c8-a6fc-f97c611146cc@weidmueller.com>
 <d30c619392f62f2d40320b01da5ca95369f3e7c2.camel@linuxfoundation.org>
 <9668ba9a-4029-4600-abd1-0f32215aaedd@weidmueller.com>
 <7537c9d9305dd3c7d05cbf36bccfe47c1858f822.camel@linuxfoundation.org>
 <c2f481ae-327e-43c5-92f5-9753bd5c0138@weidmueller.com>
 <e145b324f19953f80163dbfe8c403607e297bad0.camel@linuxfoundation.org>
 <0e604b52-e25b-4dd1-98b0-554af2c743e7@weidmueller.com>
 <2e219db8aa4ecc884396dbdbf73834ef8317638f.camel@linuxfoundation.org>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <2e219db8aa4ecc884396dbdbf73834ef8317638f.camel@linuxfoundation.org>
X-ClientProxiedBy: FR4P281CA0412.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::20) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|GV1PR08MB7363:EE_
X-MS-Office365-Filtering-Correlation-Id: 31fad7b9-eb22-4480-a818-08dd51c7e389
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?a2FuRitPUHZNZmU1cEhBV1VHMG8rMk9jeG9sdUpCVE1kUVliYzZNdWljcUtk?=
 =?utf-8?B?QmVrM2Q1QjB2RDN1dHlGaDNYS2djTnZlRmVIeHhUUnFWdEo3TjdlZFk5N2pN?=
 =?utf-8?B?TlNhYUJ5WmhFR2hweE1jSHlpdWk3WTNCMEd4Vkx6WlNRalp1S1FHVTA5T3pj?=
 =?utf-8?B?emsxY0xENU9rd0NvUm9SdWc4YytWd3k2bmNLWVk0eERVM01pTHoyMHo5WWpW?=
 =?utf-8?B?enp3bVphNmJWSm5kMlAzakpRVDIvOUpjZWIraEE0U2RTUStJNG1iKzcyRWcw?=
 =?utf-8?B?OFR5K0RhdjB4VE9wWUZ1ckpyc2VMMGt1ZkJSTFNSMzdEblZaWXVaVGw1QTNO?=
 =?utf-8?B?Mndid0x2dDJRSVdobGExSjVnZnpDVGFyT0xldXEyL3RTTW9sSW5hUkxWRnI5?=
 =?utf-8?B?TVd4Vk5CM2t4NmRVTFNuZkdQclMwVVpMMjhqVjdFVGhRMkgxUVJKbmRoTzlt?=
 =?utf-8?B?K05rdUw1cCtwZnBTbnhHOStKV2RPdmVYUUZSaVppUVVRVVBDOTNpV2tNZkhI?=
 =?utf-8?B?Qi9DU1ViNmZ4amd4TnlUazkybTRsY3EvaFpHcVAvbzA3UUx1MG13cllLY2x1?=
 =?utf-8?B?Y0hKNnRXTmxnb3hDU0ZkY0RTMDFTT2Z0UGJHdURmUUplL2JOZm5tQjJKcVFx?=
 =?utf-8?B?QStKSXhETnMwUEJNeWs1Tk5HL2ppaFE4dExldUVISGk5UDRwL00zNDErbUJV?=
 =?utf-8?B?b1FucHh5VTNBNHVWWk5XT2Z5dXFuUUU4SnZ6dE1TTkZKUWFUTUI3M1JrWWk2?=
 =?utf-8?B?WWtvN1BzYzRmV2lXN3ZMelQ1ZThxSGQzTUloMG53T3JIMkRrdTd1K3BQRFlL?=
 =?utf-8?B?NWNkMDlpc3YvNHVnRE9HTjlJaTg5MUJxbHRHdlVMakVzUTdRR0VUV3ExeG5K?=
 =?utf-8?B?VzRTanlkaDVncnlrRE1kdWxHUGdLbHZQZmhRSllXblJsUXBxTEt4aEI3R2R3?=
 =?utf-8?B?SE5GdGJOTE5UVWpmcW5YSTlhMEl2RWxPVmZST0RwNnplRWIwY2dmOUwrZENk?=
 =?utf-8?B?WU8wUld5TVNmSFNVMEhKcnpzRmFTVDM4TDhQTER4ck1EdFh1WnQ1eDgxQmpi?=
 =?utf-8?B?UFJwNGhqaGpGcTJ4bEZ2WHBSQ0MrMjUvN1RIQ2lXTC9aRngwU0hlOW5QdVZt?=
 =?utf-8?B?MCszdVdJaGJNRFFvOURUMWUrelE2enlSakdnZDlwWVd6cmpsUTZiakh4TWFR?=
 =?utf-8?B?TXc4QWxQMUtRdzRraWlGbzFic1pmdG5DY2NKSlFyT3cyM0x3djVXSmljWHVV?=
 =?utf-8?B?Z2lua0JBZlNMcWNidWI0NWoydUUrR0U1M0ZrdWIrMFE0eWV0ZHo5Qy8vbzRD?=
 =?utf-8?B?N1hDRUljR3lKMitxdzZtZTY1SW1nT2ZlMitCUklOV0pGRFBmMk4yS2N3NkxF?=
 =?utf-8?B?ZytJQ0hXRFE4R29MZHJreDBTZzdLL3daNktXUTU5ZU1idHQrRWpWWnVTOThP?=
 =?utf-8?B?OXpUcWpjelB2Y1ArV3BJM0Zpa2pTdHlnYkFVS1JiMGszMGw1cTRURDBUcHA3?=
 =?utf-8?B?Vm1LVFNnUGQ4aW11cjF0WjRDSmFtVTFNUFpYcWtGN3JYSVN2SHYwN3MwZlBW?=
 =?utf-8?B?K1JMU2cyTm1xK3NmUnd5NG1yQWVYejQ5Z21NdGtqdEU2Z3p4Y3hpQVV6YVZq?=
 =?utf-8?B?ZHhvRW1IU2hPbzRYR1RWeWxPdzFyRDdPMTJvelJsL05UOUd4eThOMmxrNitw?=
 =?utf-8?B?YmhqdFQrS3grZ3Q1WTRFRm94OWIraGluc2pvSGdYUlFzempNL01OSU1jQWc2?=
 =?utf-8?B?b2o2MjRCaFB4L3VJR3lCNDZsS0VDTm1BYnZMaU1xNUFZQzh2dDBZTnpTNnBu?=
 =?utf-8?B?c0puL2QwcGFrVTRMSTQ5REdpMHF2S2UwT0tKK2VhY3BjWk9Pa2pKUkZ5RVZy?=
 =?utf-8?Q?iRrNB9iHqKepa?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(8096899003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?d0JJVFZuZEE2bkFUODB5ZW1vbEJOajVIeEI1anJZZG1QUzh4WFYvQ3d4NGJy?=
 =?utf-8?B?ZWZCNFpVL3hNQXdma2FoWVg4VGZMOGZoeEo4NVIrTEpvYzZ0UHp6WVRpbmtj?=
 =?utf-8?B?ZUcvUkFaemdjeHBnNjF2Y0FEcUhhTmRtWGUzYjIvNlBvbW5uVWJ3NzJncGZM?=
 =?utf-8?B?K0NiS3hXYWQ3SEZ3eExLM1p5bURlS2M2VlNMWFB1N1JMVVZxanlwajY3Wjdl?=
 =?utf-8?B?Y2ZwZWZsVFprKzQwNEtJQTQ5ZGl4Q1YwQndSd2lYRit5ODRnU1B6U1VXRytG?=
 =?utf-8?B?TytBb0h0U0hoUHNFbUNnQjU5WTBvWVp6N1ZmeDBub1NRZ0hLbS9NWWZsbWRu?=
 =?utf-8?B?aEx0Q0lVWi9CdDZpazRUeG9rQ3BkYWxiTXI1REFOYVRWNnd2VjZvZTdUMmpx?=
 =?utf-8?B?bUFjSzA0Q0dLdUI2eHJHWTcrelF5ZVpoNHdJdkhVUFVmOXg5L0pGMXlXLzlo?=
 =?utf-8?B?Mm1wVFdtYXNkL1RwMnVIVXo0alFaOVFnNkJGcklGREEwWFJ2WVZ2cmJ3R0J3?=
 =?utf-8?B?UHVxOWx6OWpSMkNwZlhvTzl0VCtqMmpocy9YNWZ6UG44eVVFcnYrZkE1R3Aw?=
 =?utf-8?B?RVhnMTFuc3A4NmRCTi9uTG1odWtickZDblAxZHFxSitpaDZ6Q0xhdUtGVmdO?=
 =?utf-8?B?UW0vZjB4Q1ZEbE85c1QvNndrVm4wOWZOMUNVM3ZnUitYYXJGckFuT1VUcGdG?=
 =?utf-8?B?RVFidldqS3Z4dGRWZVZXR1FCOXNmU1d0cG1rbmZ3dlZ6SXpLbTNpZXN5Qnph?=
 =?utf-8?B?WDFZUVNlK1lmM0RtdmxRRjYvMzBYUGtCWWJkOHVYei9UdGNldFp6WmF6aXhD?=
 =?utf-8?B?WjRVM0RTRk8zRk9Kdnhrams1Nm5IdlFOcStXWkx4RTJmWWRrOEZRSXJhcURq?=
 =?utf-8?B?RFRaN0twbjVvbWlsTnpTSFJua3JYQXd2ZHRNNk02VkdnREo4VEpodWxTZWcw?=
 =?utf-8?B?d2V1ejNhaVc4MzdWbkZFb0dHVDl4TWdvR3B0Yll1cHJZSmZVdTFhMkFQL0hq?=
 =?utf-8?B?MWg5akRPV1FQRWFlVXpqWEl0cjV6OHR0UWJ1Yk1PdytFNWw4VEZPdUxyWXN2?=
 =?utf-8?B?b0FKVXMweHhtLzJSSDMvZGd3a2NNNTIrak93cGxzYlJpa09EMkYvNmZJYjl5?=
 =?utf-8?B?TTlhWitmVDV6cEtDM1ZEaHJCTWh3V0tJdHZydnEyRXpkdjl4NzduWUF5NEtk?=
 =?utf-8?B?NWZoYzNNZnNrTFJucFVDTC85U0MrU2Fud0kxUE1HYk5ORkxWdnNvTVcyRm9x?=
 =?utf-8?B?UXp3MjIwV3lOS3VEUk5wd1QxcGUzMmlPdEIySGRyUEl0bEkzSWQ5ZUxtVTlD?=
 =?utf-8?B?NDhFWUhwdDg4czQ0Y3cwNmxmUzlkQlBSUkxZcVlFY3hqUEJvZzBzZXlxa0Rj?=
 =?utf-8?B?c2V3cWVVV2hacE0wcUpvRGNES1Zvdm56cDZibVl2N0pCQlVBVXlKaGpLVW8x?=
 =?utf-8?B?N3NWMjYxOEdwQVIxcHgwMVJYOTFMTUFhSUwrTi8xR1NOUDREWEFTUGVtWjlX?=
 =?utf-8?B?V0FDbXdBbzQ3Tmx4YlJPakFWV0dNK1NkZ0IrMUNDa1NCK041U0c5WjdFMnJa?=
 =?utf-8?B?UktxM2dWY3V6Y2hUSUVvYlRHa2R0bnR6NUtDSHdzeVNjZkFxbHYrQ3k2elNt?=
 =?utf-8?B?NHI5eHZWMEQxK0xCc2RVelNiREU2K3JFd3BmWUlRd0ZRdDRWbVQ1Tjg1QzlO?=
 =?utf-8?B?Z1Y4Q1pqUFBOb1JCTHZHN01DcEd6K0RZdUZDZ0wxYjgrNGhHaTl6dVFjek5G?=
 =?utf-8?B?NTdsSUJSSmp5NWUrUm1ZcWxaSE9meUR1TzIyOElEZHhNYU1JMlR3MHZDTjZv?=
 =?utf-8?B?VTZaQmpkendCZzdEMTJCN2hyREMxQWhmZWg2K2RPQVJOREJKSVJDT085SkY0?=
 =?utf-8?B?ZGR4M0tYb1NhTzJRWUN2VmxGU1I1cit4ai9rSDlPZDNMZHNuZG5LeFZ0UHhs?=
 =?utf-8?B?SG5pWEUvWTdaK0FPVTBUUlBBeDN4eE5La0kvQzNqRzZiTTdkWEMvL0hGOW5i?=
 =?utf-8?B?R1lMb2dqOHVmNFE3NElnVm9VUWUvK2M1WVpheUJLU0hsT25lTXdSL2tLRXls?=
 =?utf-8?B?bjhTV3pwRTVvRnU2MXNEK3NZL1VOWVpBOVQ2UWh5YVNEY3AyTTlVRDlDc0w2?=
 =?utf-8?B?K2YrWFJxbVdsNWVHRExUemhxdVdhUVFlK3RqUVdhM0cxVUE4N0d6KzdwRUVQ?=
 =?utf-8?B?V0E9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31fad7b9-eb22-4480-a818-08dd51c7e389
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 16:01:51.6206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6G49wOBdTFA3ft+xDQJVCrpGTwRn8vU0DVXDL2v0lAcIuj+f+PZmEQliP+zghni/izcpW9yqZXLuAsvxl3N5zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7363
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Feb 2025 16:02:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17259

--------------9w0v1704AMPEipzTogGuZ7Id
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 20.02.2025 um 11:00 schrieb Richard Purdie via lists.openembedded.org:
> On Thu, 2025-02-20 at 10:48 +0100, Stefan Herbrechtsmeier wrote:
>> Am 19.02.2025 um 18:33 schrieb Richard Purdie:
>>> On Wed, 2025-02-19 at 17:48 +0100, Stefan Herbrechtsmeier wrote:
>>>> I don't change the exception. The exceptions are the reason for the 
>>>> state of the series.
>>>>
>>>>
>>>> The missing point is that the expectation is related to the end of 
>>>> a dependency chain and not to a task itself. In any case the real 
>>>> expectation isn't clear. What happens if the configuration need a 
>>>> compiled source and it isn't feasible to create a native package. 
>>>> My series satisfy the following expectations:
>>>>
>>>> * All sources are downloaded after the do_fetch
>>>> * All sources are unpacked after the do_unpack
>>>> * All sources are patched after the do_patch
>>>>
>>> I could try and reply to all your points but this one jumps out as a 
>>> really fundamental thing we disagree on. All our existing code 
>>> assumes that:
>>>
>>> "All sources are downloaded during do_fetch"
>>>
>>>
>>> which means once do_fetch runs, we have all the sources. That is 
>>> quite different to what you say above. I fully appreciate it imposes 
>>> quite some constraints but it doesn't change the fact that this is 
>>> the situation.
>>
>> I don't get the point. Do you say that only the do_fetch is allow to 
>> download anything? So my assumption that I can download something 
>> outside the do_fetch task as long as the download happens if 
>> something depend on the fetch task (like bitbake -c fetch ...) is wrong?
>>
>> I don't understand that requirement but I can fulfill it. The only 
>> consequence is a complex do_fetch task.
>>
>
> The fetch task is the only task allowed to access the network and is 
> the only place where the sources should be being downloaded. Once the 
> do_fetch task completes, we have everything we need from the network 
> and no further network access is allowed.
I don't understand why the network need to be restricted to the do_fetch 
task only but okay.


> So yes, your assumption is therefore wrong. I'm focusing on this as if 
> we don't have that common understanding, nothing built upon those 
> different understandings is going to work.
>
>>>>> I have tried to seek help from the people who effectively oversee me as
>>>>> a maintainer (i.e. the TSC) with limited success. I'm not sure what to
>>>>> do from here.
>>>>
>>>> I really like to upstream my work because I think it would simplify 
>>>> the package manager support, but there doesn't seem to be much 
>>>> interest in the community for it.
>>>>
>>> People are too focused in their own problems to be able to spend 
>>> enough time on these architectural type pieces. We do badly need 
>>> this kind of work which is why I'm trying to help this move forward 
>>> but equally we have to do it in a way which doesn't destablise our 
>>> existing userbase, in other words we may have to make some 
>>> compromises. I'd like to hope we pick the right ones. I'm worried as 
>>> we have tried solutions for this space before and the fact we're 
>>> discussing them again shows we haven't got it right yet.
>>
>> I always try my best to not break existing users. Therefore I keep 
>> the old behavior of the existing tasks or function calls. But we need 
>> to sharpen the concepts and unify the code base. We have different 
>> solutions (like go-vendor.bbclass and gomod.py) for the same problem 
>> and partial integration of features (like expanded_urldata).
>>
>> I think we have to much theoretical discussion and to less code. I 
>> would like to integrate a Fetcher OE library to remove the redundant 
>> code, unify the codebase and use the extended URIs where appropriate. 
>> This would fix some existing problems and could help in the next step 
>> independence of the solution. Would that be okay with you?
>>
>
> It would not be okay at all, no.

I want to fix existing gitsm problems which are independent of the 
solution. We have duplicated code inside oe-core and need to fix them 
for both solutions. Otherwise the sources from the lock file aren't 
handle by the classes.

We have the archiver.bbclass, cargo_common.bbclass, 
create-spdx-2.2.bbclass and spdx30_tasks.py files with use slightly 
different code to receive the URIs and only one use the expanded list of 
gitsm. How should I fix them?

> I appreciate theoretical discussion is hard work but we've tried 
> taking patches in the past and we've ended up making things worse. I 
> can tell the direction you've been going isn't correct and is going to 
> lead to patches which are unable to be merged.
>
> I've made it very very clear that the fetch module stays in bitbake 
> and that we need to find a way to support this in the fetch module, 
> not OE. Yes, that complicates things unfortunately but I have good 
> reasons for doing it, whether you understand or agree with them or 
> not. I'm not changing my mind on this.
Sorry, but I don't know how do go on. I don't understand the reasons nor 
goals. I propose to change the code to remove code duplication and you 
refuse it. I ask for the desired concept (pypi / go-vendor vs gomod) and 
don't get a clear answer. I have a lot of improvements, harmonization 
and fixes in the last series and doesn't know if they are desired.


> I will say your original patch series against bitbake was probably a 
> lot closer to what I think we probably need. I didn't like the "magic" 
> going on to extend the data so perhaps if that piece were reworked and 
> made a more default/simpler/clearer part of the fetcher rather than 
> hidden, we'd probably reach some code we could agree on.

Which "magic" do you mean and what isn't clean enough?

--------------9w0v1704AMPEipzTogGuZ7Id
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Am 20.02.2025 um 11:00 schrieb Richard
      Purdie via lists.openembedded.org:<br>
    </div>
    <blockquote type="cite" cite="mid:2e219db8aa4ecc884396dbdbf73834ef8317638f.camel@linuxfoundation.org">
      
      <style>pre,code,address {
  margin: 0px;
}h1,h2,h3,h4,h5,h6 {
  margin-top: 0.2em;
  margin-bottom: 0.2em;
}ol,ul {
  margin-top: 0em;
  margin-bottom: 0em;
}blockquote {
  margin-top: 0em;
  margin-bottom: 0em;
}</style>
      <div>On Thu, 2025-02-20 at 10:48 +0100, Stefan Herbrechtsmeier
        wrote:</div>
      <blockquote type="cite" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
        <div> </div>
        <div class="moz-cite-prefix">Am 19.02.2025 um 18:33 schrieb
          Richard Purdie:</div>
        <blockquote type="cite" cite="mid:e145b324f19953f80163dbfe8c403607e297bad0.camel@linuxfoundation.org" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
          <div>
            <style>pre,code,address { margin: 0px; }h1,h2,h3,h4,h5,h6 { margin-top: 0.2em; margin-bottom: 0.2em; }ol,ul { margin-top: 0em; margin-bottom: 0em; }blockquote { margin-top: 0em; margin-bottom: 0em; }</style>
          </div>
          <div>On Wed, 2025-02-19 at 17:48 +0100, Stefan Herbrechtsmeier
            wrote:</div>
          <blockquote type="cite" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
            <div> </div>
            <div> </div>
            <div> </div>
            <div class="moz-cite-prefix">I don't change the exception.
              The exceptions are the reason for the state of the series.</div>
            <div> </div>
            <p> <br>
              The missing point is that the expectation is related to
              the end of a dependency chain and not to a task itself. In
              any case the real expectation isn't clear. What happens if
              the configuration need a compiled source and it isn't
              feasible to create a native package. My series satisfy the
              following expectations:<br>
              <br>
              * All sources are downloaded after the do_fetch<br>
              * All sources are unpacked after the do_unpack<br>
              * All sources are patched after the do_patch</p>
            <div> </div>
          </blockquote>
          <div> </div>
          <div>I could try and reply to all your points but this one
            jumps out as a really fundamental thing we disagree on. All
            our existing code assumes that:</div>
          <div> </div>
          <div><br>
          </div>
          <div> </div>
          <div>&quot;All sources are downloaded during do_fetch&quot;<br>
            <br>
          </div>
          <div> </div>
          <div><br>
          </div>
          <div> </div>
          <div>which means once do_fetch runs, we have all the sources.
            That is quite different to what you say above. I fully
            appreciate it imposes quite some constraints but it doesn't
            change the fact that this is the situation.<br>
          </div>
          <div> </div>
        </blockquote>
        <div> </div>
        <p>I don't get the point. Do you say that only the do_fetch is
          allow to download anything? So my assumption that I can
          download something outside the do_fetch task as long as the
          download happens if something depend on the fetch task (like
          bitbake -c fetch ...) is wrong?<br>
          <br>
          I don't understand that requirement but I can fulfill it. The
          only consequence is a complex do_fetch task.</p>
      </blockquote>
      <div><br>
      </div>
      <div>The fetch task is the only task allowed to access the network
        and is the only place where the sources should be being
        downloaded. Once the do_fetch task completes, we have everything
        we need from the network and no further network access is
        allowed.<br>
      </div>
    </blockquote>
    I don't understand why the network need to be restricted to the
    do_fetch task only but okay.<br>
    <br>
    <br>
    <blockquote type="cite" cite="mid:2e219db8aa4ecc884396dbdbf73834ef8317638f.camel@linuxfoundation.org">
      <div>So yes, your assumption is therefore wrong. I'm focusing on
        this as if we don't have that common understanding, nothing
        built upon those different understandings is going to work.</div>
      <div><br>
      </div>
      <blockquote type="cite" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
        <blockquote type="cite" cite="mid:e145b324f19953f80163dbfe8c403607e297bad0.camel@linuxfoundation.org" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
          <blockquote type="cite" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
            <blockquote type="cite" cite="mid:7537c9d9305dd3c7d05cbf36bccfe47c1858f822.camel@linuxfoundation.org" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
              <div> </div>
              <pre>I have tried to seek help from the people who effectively oversee me as</pre>
              <div> </div>
              <pre>a maintainer (i.e. the TSC) with limited success. I'm not sure what to</pre>
              <div> </div>
              <pre>do from here.</pre>
              <div> </div>
              <div> </div>
              <div> </div>
            </blockquote>
            <div> </div>
            <div> </div>
            <div> </div>
            <p>I really like to upstream my work because I think it
              would simplify the package manager support, but there
              doesn't seem to be much interest in the community for it.</p>
            <div> </div>
            <div> </div>
            <div> </div>
          </blockquote>
          <div> </div>
          <div>People are too focused in their own problems to be able
            to spend enough time on these architectural type pieces. We
            do badly need this kind of work which is why I'm trying to
            help this move forward but equally we have to do it in a way
            which doesn't destablise our existing userbase, in other
            words we may have to make some compromises. I'd like to hope
            we pick the right ones. I'm worried as we have tried
            solutions for this space before and the fact we're
            discussing them again shows we haven't got it right yet.<br>
          </div>
          <div> </div>
        </blockquote>
        <div> </div>
        <p>I always try my best to not break existing users. Therefore I
          keep the old behavior of the existing tasks or function calls.
          But we need to sharpen the concepts and unify the code base.
          We have different solutions (like go-vendor.bbclass and
          gomod.py) for the same problem and partial integration of
          features (like expanded_urldata).<br>
          <br>
          I think we have to much theoretical discussion and to less
          code. I would like to integrate a Fetcher OE library to remove
          the redundant code, unify the codebase and use the extended
          URIs where appropriate. This would fix some existing problems
          and could help in the next step independence of the solution.
          Would that be okay with you?<br>
        </p>
      </blockquote>
      <div><br>
      </div>
      <div>It would not be okay at all, no.<br>
      </div>
    </blockquote>
    <p>I want to fix existing gitsm problems which are independent of
      the solution. We have duplicated code inside oe-core and need to
      fix them for both solutions. Otherwise the sources from the lock
      file aren't handle by the classes.<br>
      <br>
      We have the archiver.bbclass, cargo_common.bbclass,
      create-spdx-2.2.bbclass and spdx30_tasks.py files with use
      slightly different code to receive the URIs and only one use the
      expanded list of gitsm. How should I fix them?<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:2e219db8aa4ecc884396dbdbf73834ef8317638f.camel@linuxfoundation.org">
      <div>I appreciate theoretical discussion is hard work but we've
        tried taking patches in the past and we've ended up making
        things worse. I can tell the direction you've been going isn't
        correct and is going to lead to patches which are unable to be
        merged.<br>
      </div>
      <div><br>
      </div>
      <div>I've made it very very clear that the fetch module stays in
        bitbake and that we need to find a way to support this in the
        fetch module, not OE. Yes, that complicates things unfortunately
        but I have good reasons for doing it, whether you understand or
        agree with them or not. I'm not changing my mind on this.<br>
      </div>
    </blockquote>
    Sorry, but I don't know how do go on. I don't understand the reasons
    nor goals. I propose to change the code to remove code duplication
    and you refuse it. I ask for the desired concept (pypi / go-vendor
    vs gomod) and don't get a clear answer. I have a lot of
    improvements, harmonization and fixes in the last series and doesn't
    know if they are desired.<br>
    <br>
    <br>
    <blockquote type="cite" cite="mid:2e219db8aa4ecc884396dbdbf73834ef8317638f.camel@linuxfoundation.org">
      <div>I will say your original patch series against bitbake was
        probably a lot closer to what I think we probably need. I didn't
        like the &quot;magic&quot; going on to extend the data so perhaps if that
        piece were reworked and made a more default/simpler/clearer part
        of the fetcher rather than hidden, we'd probably reach some code
        we could agree on.<br>
      </div>
    </blockquote>
    <p>Which &quot;magic&quot; do you mean and what isn't clean enough?<br>
      <br>
    </p>
  </body>
</html>

--------------9w0v1704AMPEipzTogGuZ7Id--

