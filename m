Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D9FE6BF1A
	for <webhook@archiver.kernel.org>; Fri, 30 Jan 2026 14:56:00 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.12])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12213.1769784954531218582
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 30 Jan 2026 06:55:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=T1IfBHUc;
 spf=pass (domain: cherry.de, ip: 52.101.70.12, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDL89HuzpHgl0Ibt/KVuhKnh0ZWYgciLU+pMcBjbaafZGqu7jpo9bNOUjmGb6ljJm3AjChBYc3MMCYGXpuXmh322bycd2/gO2zqYKrhYnTGR0aE2kGc1InpVm302HdWEAFxQK/A/V2QcB402et5/cZnDtVXXrn/p5AYHfF6iLFXQHqSLAFC7ZgI7jxwuUYTrjfbTb43NOPuTxZzaLw7BfUl0a5DjjZhBULRLy/dXFP0ptBKNN/bn0Bs6VisXLCOXlxeXRfzOY+pFC4gM6DHgippLykKAoMmhRWtDhYJ1Z2Ko/qFvfLkdHkFdDudkDLO3TXC7qBcjzjRfcxCrGTe2mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dl3wFwTG/QPShQwemqcXrbnYUYVN9MwW1ycBSnQ1OF0=;
 b=hsIlivwyxOuT6a1bKjuMgd8G30H9UBaL1w7E6F/lwa8IlmmWNMdIsPJvNyoaSZAmQDI7JtTkVRmViwyxJyyjTfPPMd58NOEuWkF9DhLHwEjNTHdb16DNjlcu44sVGxfuoTCulm9XLID4Tz0UbXMjg4ZipXJdnSzhe7CPl502cAiVEfF2pwKgPwhanW3J32cmiY+lrz7//w3t1SWz3vHtAHQiA8QcerBfsHDzyX8ZtVcxlJCgWBosI+uWEV5zZ9zmlVDLzANsTc8AdtfaTb4AcDYVmBRK3m9RVQBcqIZaIFma6IpbcfDH0lDkirygJBUtQXNmEPCWvMOjcuLF8BkGiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dl3wFwTG/QPShQwemqcXrbnYUYVN9MwW1ycBSnQ1OF0=;
 b=T1IfBHUc9boa1QEdB67LcXgm+94Oo5Lf8Omg7A+AeHTo+ouD8ygwMiyw8KoGeQ0RcLjO9WHbA+/+VpcKNOt9uPEm9NWzbTULPVPmSIuZ7Ng66ZIqUyOPoS/ks0zGicCIhSTU2Iw+idJWwk/2voc4RVVRW8NXm+ZMcTsGuUmAaHY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AM8PR04MB7730.eurprd04.prod.outlook.com (2603:10a6:20b:242::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 14:55:50 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 14:55:50 +0000
Message-ID: <6e5ce5e9-d2b3-45df-bc0e-834b4035efac@cherry.de>
Date: Fri, 30 Jan 2026 15:54:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [docs] [PATCH v2] doc: bitbake-user-manual-intro: improve
 bbappend file matching doc
To: Antonin Godard <antonin.godard@bootlin.com>,
 Quentin Schulz <foss@0leil.net>, bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, "Robert P. J. Day" <rpjday@crashcourse.ca>
References: <20260129-bbappend-matching-v2-1-4041afca3c82@cherry.de>
 <DG1ZCGR9A4OJ.3918WSIWBKUDI@bootlin.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <DG1ZCGR9A4OJ.3918WSIWBKUDI@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR0P281CA0258.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::10) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AM8PR04MB7730:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c542e9c-d8b3-4e6f-7b4b-08de600fa857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SWw5Sjl0eXRWT2svRVhtTFdoQlRvTXVZL3hwS1lhaVZicGV4eWVEYTJnUzJq?=
 =?utf-8?B?Nk1xQXo1Ym5sV216T0RaYkZMM0J5TFJuWjdud1hHYlFCc0dHVVAwUzEvak55?=
 =?utf-8?B?bTIrSExrMVE0TXBhMVBBbWQ0cDRWODMyU3ZwNDNkNkwzUmpONmNvNi9FbEpI?=
 =?utf-8?B?YUNBcis3ZC9MWnZEQ0VFNlN2RGlpT0lkQUcxTG9IVjVSRVpIcEwrZGZHMVcw?=
 =?utf-8?B?UWRXUjh4UTIyRVdONlRpZXR2aGhLQlpiWGpJM0U5dnF0c2tyNzlYZU9LUzYv?=
 =?utf-8?B?U1lHd1ZRa2JxSkdjeFc5UWgxdWZuUmJKZHZCa3BuYnl3VUo4Zzc1bUptblY3?=
 =?utf-8?B?UzUxRWVqbFppUE4zUGN0aUkvZ2xRTEJMeTlkaVRBejZnNzFWaTFLU3UzMDA0?=
 =?utf-8?B?N1IwN1QrNkNMMEZsMHlCNDkxTkJmcUt3am1HaU9lODVKK2hsZE5tMFVIdlJP?=
 =?utf-8?B?eEpGT3B6b0owM2F5RVZHT0lLTUpGZ2Y4Q2ZWQmNrenpRWXlDUzNkUDFEamtw?=
 =?utf-8?B?V0VLaS9HRW9EcENpbFlLNGhIdDVDUzIvU0Mwb2RTdFVTZXhGNENGWDB1QXZu?=
 =?utf-8?B?SUxHU3pZR3BRRDRtQys3Z05QQ2x6cnJYRVYzd2xFRHJoTUhaTms3TG96WGN6?=
 =?utf-8?B?RTFKWW50R0lwbU1ONXh0SDB1cU1pZUg5UFNjMkZtK3c5L2puQStkMGVka1pD?=
 =?utf-8?B?Nkdtb3lLcnhvZDhZVGNsUTk3M01UdXJzUWlPQmxhckRRWU9WZjB0U2RUL21U?=
 =?utf-8?B?b2RoNmRIdDlFQ1IrNkNRd0FUT0ZlcEVsTktsNDM4eFM5c2hOSFlNY2RKQko3?=
 =?utf-8?B?MDhZZVVUVlBYWXYrRTNXUUt2ZGljVmJRdjVOYWI4Q08rTEw5UitmSWJoQXdS?=
 =?utf-8?B?Z3VGSy84di93WHRGU3FOYVJtR2NsbFFwM01PL3dYaFVSUmdNMXhXS0daSkNL?=
 =?utf-8?B?WXlEYUd4S3pxOGpJN2x2UkxTTzA4T2oyUzBCRUNkdmdFZVNVSUNINkhGd1Vj?=
 =?utf-8?B?RVY0aXY2YlgxdVhLV1FnakhtUFFnNjFEY083NGZnd0VlSTAxUVUvNVJldVlT?=
 =?utf-8?B?bnJuT3pSZ041UDFBWWV5azhmNkl2NWR2N3RESzlvVGF6SXZmOGdWNkVFRHZZ?=
 =?utf-8?B?K1hlK0hxVjJzTWljdkFSZHhTVERTRzByek9Wc1FVWGdOMGwvZnRKWHQwNkQ1?=
 =?utf-8?B?NnVSdFNlQnU2QTVCeGo4aWYvUVZMTUR1ZTlQdGgwSkJYVnhSRThZL05OMGht?=
 =?utf-8?B?NzVxYVNYYmJRdElzNDI1T3F6L0dMTzNDaVZnTmFRTWxBbk4yZTB5OUpqLzJ0?=
 =?utf-8?B?U095UzZRM0cwK09ndWN0YnJRQlVUMm40bVhhKzEyNmEwWU1JTWhZa3M4ZkIr?=
 =?utf-8?B?U3dmTkFPLzEvSTkwQk9vaVBDOE9Ucmh0M28vaElSQ1NpWGFNTGVCVDJzd0tm?=
 =?utf-8?B?eWUzZVdBZEpSdEo4Y1VIQmp6S3JuTDVXVDQwZnJWYm9TMXBaTDBWNWhLSzBN?=
 =?utf-8?B?TDRCaFZEMm1EOUhCZUh3WnRUY1dBVlVDVlRpVEtkM3N5c3FsVHBIcXdYZ3BB?=
 =?utf-8?B?ZWNDMzZvclNjcFdqbWFlV3FzM1lWVXBBejBZR2hadHhVY3lEblFFVlpFdTJn?=
 =?utf-8?B?Y282dUZheWtjeUZzU0hKTyt5QW1xRlVmc3NxNHZFcUJSQXc5SlVlSUY2THND?=
 =?utf-8?B?TitDRXBqQ2RxSWVSajFuYVhuaE9JUEppN243NkVTR3hFdXF2TDZOZjVRbnpU?=
 =?utf-8?B?NVM3NXVvYTgzRUZnL0tUU1VHaHE2MUNvakprUmZGWEF6dkdOeDBLYS83Ym5v?=
 =?utf-8?B?WDhFM0pJNFRYZjVCVUxvbFJvTkxyaktnM0pmSE5iQ29RbzlFZjJkWHVCNG5H?=
 =?utf-8?B?S0VXMWg5ejdiVWtxbElYd2NuYmt2WFRabEYzdXhaU3ludUxqTlhaOEJBVHp2?=
 =?utf-8?B?Tks3b1JGdjRZTnhEVktBOW9OdHZnZnRXc3d0a0ZtczBHNXZ0K1ZKVlQzVVFp?=
 =?utf-8?B?MnRhNlNPMmdPSEQ3MTJVTFZSZU9qYWZleUZ6ZHVLTEZXR0p3ZnBnS0FEMkRC?=
 =?utf-8?Q?+ksILk?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UzZnOEt3bzZXeGl4bWtucC9OcTJGc00xZVBqVVpXMlAxbGZHMkZzSVpwR1hx?=
 =?utf-8?B?ZFhLMU4vMzVJempsKzJ4azNrU284WGkrK281N21KazFOelJFRE9FczVGZlVF?=
 =?utf-8?B?d0xqYklBd3ZwUjRwalFoNk1rN3dWZDB0UmtDT2pmQ2ZwSXQ5UkQ4QkNlcVNj?=
 =?utf-8?B?enZxakdLckJWWXBaVU55RmszejZ5bUx5NTk5QWM4TXFHckdtUnFLd3FkSXp1?=
 =?utf-8?B?Rzd1U0VNNnZDSFdBTDlPeTVlUFoxVjAydVdFTEtsL1hIaWNVMWJHZk5OYTht?=
 =?utf-8?B?Yi9ZNWhtbTVuS25QY2paVGpXWmp3TnBOd1oyR0RHNnNlV0hHbkpwZTk4bEZl?=
 =?utf-8?B?cXI2OXhrdGdvWERGRHhoTVBiOW96V0RxL0trcjkrUjR0YkVNeHBwSkpuMTdv?=
 =?utf-8?B?d3U5NS9oTVJCQ1FKb1FnVkxCQkhGNWJJK214MmY1T0k4V3RLT2hzQTRkYTJX?=
 =?utf-8?B?VlBNSUZjV3hGVisvR0ZUVUUwWXZxQ0trUWhaSHFLZE5Id1pXaFZxc09HYXJZ?=
 =?utf-8?B?RG1WMy9meVZFV2Z5RDVvbjdiU2RPVWl1N2lreWpyTmVHYWY4N2VrYkc5cFIr?=
 =?utf-8?B?Y2NUT1NPN0d0VnUzMzBsdmx6VlV4QnNtUkRXbUE2TDREOFU4RVRpcDd1ellS?=
 =?utf-8?B?elJuUjRSWjduMW5QV0F2MlVJRzdyb2M3YlFXbWtYaS9nWk13MVA2RGZKeit2?=
 =?utf-8?B?UWptWG9TYkNQNWtCZW1ob1owZEZ5NFcwRFRPc0dPWis3Tit5ejhLTFBuV2xz?=
 =?utf-8?B?Y2FXK2lhS3RBTjNDNlNEdmY3SFJPamVESnBZNmNDMHJpd2NnUjhGdURXemZD?=
 =?utf-8?B?SHhlc2ZiaStnU3Q5dFVxT0RoVmlGT1paakpZL0tZWHQzeWhTcjRRVWdXMStx?=
 =?utf-8?B?OEt6RkQ0dzFvdHNZKzhCWStRQmhmRzhsS1A5ZmVRM2gyd2RBbWhxbXkzTjll?=
 =?utf-8?B?L3VnY3pocmRIcWNhZmtNVXJtRW5Ja2t3dHRaMGt4SFI1d1U5T0pqZ1NUQlJC?=
 =?utf-8?B?NUNQb1dYa1A3UEJQajJTYzFiL2lUTHltbmVkKzA5YlhGaURIYk4vZ2xXWndw?=
 =?utf-8?B?cDhVNW9oNExCdks2eU81TWVCTDhOVWJkMTloV2dEM0ZyRDNUV2t6dkEzVTU2?=
 =?utf-8?B?bGRIRHdRQ0VkalErUDhTK1N5aTJzVHU1OWc5NUk4V2xSZ1ZLQXF5SkdrU0t6?=
 =?utf-8?B?MllWbFhTQ2JabkJ5WWxsbytmclNncDNMZHMvMDV4bXVhK3BHaHN6QVBVN3A4?=
 =?utf-8?B?dUFlM3dwRFN3eWhtbVVnWnBESjkxU0d5ck9ueERnOVhjbzA3MzdRaC9ZTFdB?=
 =?utf-8?B?VjhWMzRNazkvcUZvZitoaFRNcUFKbHVHS2VaTlo2cktmdHpzeXNBazd3Umhw?=
 =?utf-8?B?OXNTbGw0Zm1RbW9SbjN3SmZWYXdpRldpM3FKYmR0eHpseG5JSWhSU2RDVURp?=
 =?utf-8?B?NnpnUVJnblMxM1NuVVc3UlJBcS9KeWpBQzVEdEZ2SUYrRWJVTG8ySHZyUE1I?=
 =?utf-8?B?Tk1QTlRhNDRzZWt6dFczalZ3ZEl4Y1REaE1NbisvOVFWUDNwSll1dU5VbkpP?=
 =?utf-8?B?ZkZnTXd2S29DK29zdmN6VjFpZW9YSVVLVHUvWXFBRnZFQm1FTnduTEZ0RFdw?=
 =?utf-8?B?SWlOaENFZGk1UHJKNTliQnJMQmY1MUNxb0FYdUliSHhhd0lsYTJzb29CUm4v?=
 =?utf-8?B?dTZ5QlFVZXBCR1BNZW1hamJlU3Bqb2M2bzM2WDZraWVGZ3RqWmRmTGU1OTNV?=
 =?utf-8?B?UkxPOGw3SVovbXg3bWpkZnpIVTliQ3FFWXRISFA5WlBLelErVjhEY2R6R1c1?=
 =?utf-8?B?UmxxMTZYRllsSHc1Z0FWeVI3WHZLdUFtK3poMlY1TXI4Zk9SK0Z1c2xSbFNn?=
 =?utf-8?B?SmdDT21XZU9hVFJseTlmQko5eTg0M2RIa0JlR1poV1Y0S2d3b0thL2xsWEpi?=
 =?utf-8?B?bXpvQjd5NWVsYWxVcHJ6dW9ZR050UnZJVlZraTNnL2dTQUNGL0RyL0ZTcy9U?=
 =?utf-8?B?eGJ5QWF1RCtWVWl4bVh6aHZLWTY0aE10R2RpbE8xY3I3dkMvTTNGOE4vcVcx?=
 =?utf-8?B?Rkx3ZmZDTkd0dk14ZS9yMWhCVDVvdjEzeWFTeTdvbVNUZUtuZ1dCSXNXSXZx?=
 =?utf-8?B?bFp6R2I3eHR3S1grNkpRdm1STndTTGE1dXpiWVlSSkpnM3pXWWN2NDVzcUY0?=
 =?utf-8?B?ajJEb3J2NFgyc2dCTUlnRDNqVC96TVU1dU9IclF1c25DVEhnb3RablhnWmZN?=
 =?utf-8?B?TktqaUJNL2FtY1kwWkoxb3lRemdTS2ZUVVlKNEp2SndQb0R0WGpyL2ZnYjJr?=
 =?utf-8?B?Q2t5RTBOK1N4K0hGMWQvUXVZSkQvSWpKSmVPZEZ0RHFldktzZktvQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c542e9c-d8b3-4e6f-7b4b-08de600fa857
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 14:55:49.9517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rkcHpGCeKedFO+61taq4UDIdGpc/fTY3QpK8QXcY6JPOqpzD7BjdGIY/nFZKyXQYpi9iSyc+BEPFW/scfFxvlZTXySk8ckFKvLIKwEame38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7730
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 30 Jan 2026 14:56:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18939

Hi Antonin,

On 1/30/26 3:06 PM, Antonin Godard wrote:
> Hi,
> 
> On Thu Jan 29, 2026 at 11:07 AM CET, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> The recipe name matching wasn't fully explained and were missing a few
>> important corner cases such as recipes without a version, or using the %
>> character outside of the version part of the filename for example.
>>
>> This adds the last missing bits to cover every append naming scenario
>> that exist today.
> 
> Thanks, this was indeed missing!
> 
>> This was derived from lib/bb/cooker.py:get_file_appends().
>>
>> Reported-by: Robert P. J. Day <rpjday@crashcourse.ca>
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>> Changes in v2:
>> - fixed typo for bbappend named bb,
>> - added "a" before "``mesa.bb`` recipe",
>> - Link to v1: https://patch.msgid.link/20260128-bbappend-matching-v1-1-29fef2d63489@cherry.de
>> ---
>>   .../bitbake-user-manual-intro.rst                  | 51 +++++++++++++++++-----
>>   1 file changed, 40 insertions(+), 11 deletions(-)
>>
>> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
>> index baad71304..69ad6037b 100644
>> --- a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
>> +++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
>> @@ -271,12 +271,9 @@ same root filename. The filenames can differ only in the file type
>>   suffix used (e.g. ``formfactor_0.0.bb`` and
>>   ``formfactor_0.0.bbappend``).
>>   
>> -Information in append files extends or overrides the information in the
>> -underlying, similarly-named recipe files.
>> -
>>   When you name an append file, you can use the "``%``" wildcard character
>> -to allow for matching recipe names. For example, suppose you have an
>> -append file named as follows::
>> +to allow for a less strict recipe name matching. For example, suppose you have
>> +an append file named as follows::
>>   
>>     busybox_1.21.%.bbappend
>>   
>> @@ -290,12 +287,6 @@ the append file would match the following recipe names::
>>     busybox_1.21.10.bb
>>     busybox_1.21.11.bb
>>   
>> -.. note::
>> -
>> -   The use of the " % " character is limited in that it only works directly in
>> -   front of the .bbappend portion of the append file's name. You cannot use the
>> -   wildcard character in any other location of the name.
>> -
>>   If the ``busybox`` recipe was updated to ``busybox_1.3.0.bb``, the
>>   append name would not match. However, if you named the append file
>>   ``busybox_1.%.bbappend``, then you would have a match.
>> @@ -303,6 +294,44 @@ append name would not match. However, if you named the append file
>>   In the most general case, you could name the append file something as
>>   simple as ``busybox_%.bbappend`` to be entirely version independent.
>>   
> 
> I would wrap from here...
> 
>> +The "``%``" character is a marker for BitBake, and everything after that marker
>> +will not be used for matching recipe names. That is, an append file named::
>> +
>> +   busybox_1.%.11.bbappend
>> +
>> +will match recipes named::
>> +
>> +   busybox_1.0.11.bb
>> +   busybox_1.2.bb
>> +   busybox_1.3.48.bb
>> +
>> +Note that the "``%``" character is not specific to the version part of the
>> +recipe name. That is, an append file named::
>> +
>> +   linux-yocto%.bbappend
>> +
>> +will match recipes named::
>> +
>> +   linux-yocto.bb
>> +   linux-yocto_6.18.bb
>> +   linux-yocto-tiny_6.12.bb
>> +   linux-yocto-rt_6.16.bb
>> +
>> +While it can be useful to append to similar recipes with slightly different
>> +names, it is highly discouraged to do so as recipes from other layers may be
>> +named similarly enough that the append file would unwittingly match them.
> 
> ...to there under a .. note:: block. First because it will make it separate from
> the first part of this section, and second because it will highlight that this
> is an in-depth explanation of this percent sign, not really a standard use.
> 

Do you want two separate notes for busybox_1.%.11 and linux-yocto% 
examples? They both are related to % being a marker so I guess they can 
be added in the same note, but while the former example is definitely 
wrong, the latter may sometimes be found (but is mostly wrong as well, 
but in more insidious ways).

Cheers,
Quentin

