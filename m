Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B93E77171
	for <webhook@archiver.kernel.org>; Wed,  4 Dec 2024 09:42:53 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.40])
 by mx.groups.io with SMTP id smtpd.web11.10240.1733305371394878912
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Dec 2024 01:42:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=ade3snXl;
 spf=pass (domain: cherry.de, ip: 40.107.20.40, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xv2YIZDQ42s3wGKWrw9zMdkP6zx6fG3rlipyfWceybv3KywmKeLfw3ZwojY/U07TW4MkjaXHQFeCi5/00iO+r/CjP+YOhbum86hLEiL1JKE8Fo37ZzFaCrcCnkg+G382iBJQq5Arzz2EqKAPpHK0OzXMnbmg2St5zZUBr8H5WWsw4pNdl1Qo2ETQOsfO0dkIdr1umblpUSumVj0Hu03WUBusAv47JkCBU8W2qERUui69rTtSbFO6lY/9yl9gpXIIFJk2tJOb5qH1cETX4PAbgJZW7Mug59vCZ0zFftyQpCJ/RtioOZhlBo8x/IdXYnHXeApwhAluNYH0IkSaBeukRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dISRSyPCP8v40m3XpNIoTlR7IkVQw2dxN8wUPGy7ri4=;
 b=EydnQHhLTmHgcVMKLwuLStbBmZWm4aZcRWVFkaTc3WUfRuWW6hpI/oA/sZV4oZJs5thRcjWeF1dOIo5Op36Ox9VdVpekSAOTjqMIrlqDRw/zUWnGOm632dF5lowi/VxPdWknBDvAqqggFIAUsxTA1Cpom8eevTnQlGylJPECpP7m2FSS8JM6vDdKaGVvBtzAQYkouijGcw2qx8sS8WvXnZvE8YRUyuHosVGHHm6VpdMpzNnnF+jhvhmBmiknb2CF1B0F9gG8t3IySfsKD+WxtU/MYqhOiDz9zZCp6dXaRUYXPUlGzIsnTzq0zh81bYmMho7Rl7QHd123HtmdOX3WnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dISRSyPCP8v40m3XpNIoTlR7IkVQw2dxN8wUPGy7ri4=;
 b=ade3snXls0qnrv4cVYcbfuSrbPlRdM1SBQk/IHfI9v/E+tJnYsWFDHsH/gS7o4C7YyAqeCyFGx3/h91eRUaPFm2bpP5ZPvA90inz1CrINaO89fgDcg7UfSS2mlQcxRrxpU2sQpDLFCesc6GnyMBQanzNQoVvc5+SG0e3vk1miXo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB8593.eurprd04.prod.outlook.com (2603:10a6:20b:424::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 09:42:48 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8230.010; Wed, 4 Dec 2024
 09:42:48 +0000
Message-ID: <c5a3c2d0-06e3-4bae-a34f-8dd02de9faf4@cherry.de>
Date: Wed, 4 Dec 2024 10:42:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [docs] [PATCH 1/1] bitbake: doc: suffix for
 BBFILE_PRIORITY
To: simon.eu@gmail.com, bitbake-devel@lists.openembedded.org,
 docs <docs@lists.yoctoproject.org>
References: <5eb7e737-37e9-4d6b-811e-4fc121dd6567@cherry.de>
 <10227.1733234974032646746@lists.openembedded.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <10227.1733234974032646746@lists.openembedded.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0114.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::6) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB8593:EE_
X-MS-Office365-Filtering-Correlation-Id: 5041437c-7e00-4f60-7554-08dd1448030f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|4022899009|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YnZJNTI1OUxxNHRNNVJGUDdCZ0YzVzd2OTNUMktwbHB5VEhRTGhKTkVqaXZN?=
 =?utf-8?B?aDk0d0w4c2l5d0hNYVNHNzVOeTc5WUZSZDZ1WEM0OE9QOWJNd0N6aU5KNWlo?=
 =?utf-8?B?Y2VBQXhMbnpEM1NQUnh2amdVOUkvT09temY2YWJKNkxKbTZQMVpHTjhzcy8r?=
 =?utf-8?B?dmVjaGlZT2ZnaEV4SzNPSkdWeEx4SGxYc2EzSGcrd0w5cmx2YW4rSW9XT0c3?=
 =?utf-8?B?UXh5c21qKzV0STg4UEpCY3h3bnNiRDdiNG1ZdlJwbC81dkY0VHFtUmxxbGRF?=
 =?utf-8?B?SUVIYkVyMFhMY1IwZWtwV25zaGFJblhMekY3V0p0WTRCRnpVWGVLdlJnM0ZH?=
 =?utf-8?B?V3I5cVA3ZThZY1JhRFFCOGgvR1FYdmZVTjZSdXVQNHBQc2RmNEIyL0Yrb012?=
 =?utf-8?B?QTJnOWlUb3FQak1QU2YrdlJETExkWjJUVVJRZHNPaVpvNGFNTnJlZ2NNbzRY?=
 =?utf-8?B?R0I1MnM1d2h1b2orMkc3Z25qamNzc1hmcHJjRnAwQ1BqNXpwQXhwcGRQN3RH?=
 =?utf-8?B?UHk2RjdSellPVmEvbG8relh2MTFGTFQxSS9MeFFDSWIvWHhwdUJxaXcrSlJv?=
 =?utf-8?B?NDRKQmZNUDdseE8yOU43V29JdkF6ZWFzQ3hLaWVzeVRLdElXb3NoSWdoWEt3?=
 =?utf-8?B?V0NrN0cwRmFrdlN4blpSTERYZHFtVEcyRjhRNjJxa1VtamlZczZGcWdySnJ6?=
 =?utf-8?B?ZzcwVmhUR0VqOFYxZFlMcCtyUEV0anZJbWxaY1ZYUmJ0Z1NFUkVDSDhtMkVG?=
 =?utf-8?B?VjVMMEttRjBKK1VXNXVnS0lWRTBNbUdRQVlidkxDVDlUdlJETEUxVTZxNDho?=
 =?utf-8?B?TVdld1lWSG1vYnVYejJEcTlIN1FzbkZOS01uK3BMTStuZTlhb2RtODVBekdw?=
 =?utf-8?B?am16cDZ3czF2L1FDZkZVWUpXU0RLOXJRRlhWdlp1L1hqODMzUldnZkVOWDRO?=
 =?utf-8?B?ZnpIRURBclJnRW1VWWRmc0EvQnJqYVlEK3hIQ3RrdXhpM3h0cFR3Wll1SjNE?=
 =?utf-8?B?OHJxWCtRZTZsZ0ROSlpadWtSZlRiejU3cDltdERSU0U3bDJMZCs0TWo3R0Fk?=
 =?utf-8?B?bmhVbVNHaEI5QzhFSXJaakVTWWpJU3lnQi9zR3pBVlZiZ0tLQVJ4RnJVU3lL?=
 =?utf-8?B?Uit0MGVlYkM4VE43d3k2MGtrc0xLYUZSWEN0YWlSOTRxOFgydUdUNnJHdTk4?=
 =?utf-8?B?d1NWWllBUEtLZ1I2ektSSmhQNUpiQXQraU9EdUhsOWUvRmd6Sm1oQUpNY20w?=
 =?utf-8?B?dVhzWGhQWkZHVGhyZnZmeGVhMm1LY0RTbUhVTzE0R3hUeHhYU3N1UE5VVHhE?=
 =?utf-8?B?L2pHK2dXZUxzbjZ2N3VwSjZ3Zm00dkFCNzRCUXpKQ01qV25GZFRJUXVxMEVB?=
 =?utf-8?B?elhNcmp3aFdiR3h6VzFNdHh2U0xvSFBBOUgzL1RvbXI2dnJsOGlheEI4OFF6?=
 =?utf-8?B?SGtXQWVoTkx1bmpRWUpqVW5NWk9ZNWhhUTlOaW0xVFgvd3BVMDdXTGRpaWU3?=
 =?utf-8?B?eWF0Nk10UXRhUnFuNFVFUDQ4Z0tKN3hYRjdSNnlGL0c0WWFHbkhubWZCUTZT?=
 =?utf-8?B?N2F4UEt1QVhUb29HNnU0ZjNoYmRJclY1R241T0diaGtsNlFudE9aalRQSlVB?=
 =?utf-8?B?YlM1aXNsNzZmWWQrM1BvNW9MMk01RnJWWktFeDFkQmZ1OVF5WDFXR3Q4a1c3?=
 =?utf-8?B?T2ltRWN3aVVlZmF5djBkVE5YNWJ4d3VqSWxibWJpeU5pUjRRR0RUaHlER09Q?=
 =?utf-8?Q?wytFdy3NloTU5nLSBY=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(4022899009)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?b0VtRURaQytpZUZMbDJXQzUydDQ3RFh1TndlVjZOMjZrcWtLUCtvMlpRaE1Y?=
 =?utf-8?B?c1NjMWFWV1dZSzA2Um9zRWNrcVVrbmljNkh0OUp6NVJwRHUwaFBKVVhTczhh?=
 =?utf-8?B?UkNUOC9ndURSK29Za09uenpURGtjZ25YMG4wdmFkb1dLbUlNQktNZy9oVGgw?=
 =?utf-8?B?VkU5TE1MQ3ZBNkE1eTN1TUt5L1A4em9SQ2pNOHZhZFRFVDZnOVVLeGtlWFdm?=
 =?utf-8?B?d2Qrc0h1MjdSRVJ2MVpQOUhGUmVLM3JxUGdvbUxaaDB6cXN4MjRHT1RzQ2tL?=
 =?utf-8?B?YjV3bEZGdnE3SXV0YWtrTU54aWE1NHJ2S1BvRFEwdVZDa0htQldKYmthYjVK?=
 =?utf-8?B?YVdUTWI5U0RXTGp4c0lCTms5UE1RbHVEakRSaks3eWdaQnBLdVZQYlMyUWlj?=
 =?utf-8?B?UW9XMU1ncmU4aFdCakdTSHh3ZVE3WThzZnczMlRLbUhVUDlpK0pMbFFwTUJo?=
 =?utf-8?B?RG1PZU0xTjltK0p2MWtKbENZd2FKM3NhdGdFVFkrQTE3eXdMVG91YWs1ZVlk?=
 =?utf-8?B?Q0xEZ3haeXk0MzkyUFlpM2ljT3J3VGVxVWpxSllYUEJlTk9IMFBlcExmbEFu?=
 =?utf-8?B?VUtNZnV5bWEwOVpDdXFHSkxXWkMwc2F2K1V3NVZOZGJFSGNXTHBzcHBYdmVm?=
 =?utf-8?B?ZW1KM29oMjlWaVNjUDZBU2cvUkV6VWZubng0UlRydWpEQlBaVXpVM3hncWo2?=
 =?utf-8?B?M1ljUFMrMTVLRlloMEhVVUJ5S1ZqZWFaWkExRFRqSjF2WXlYVHlVV2hoV1BK?=
 =?utf-8?B?eEc3ek83RE5PM204SEI3eDJVd2xNZ3ZxOXhJU25CdC9SaXJoQ0ZkcWJLcExr?=
 =?utf-8?B?T2pnRW9vdGRWUU81QnlOWHNOUCt1cHk4NDVMRXljckxiZ2svMndaZGtwRHVI?=
 =?utf-8?B?aFVXOElpTkFXV3ZoWVlDaWN6QTR0LzRqaWxhbGxQZWpTaWtsZGNaT05pUy9j?=
 =?utf-8?B?SmsrNkNQQkR3S1B3ckc2R0VHZ1ZYWDFTa2FyLzRKQTJENlZWdGFheDhrckpD?=
 =?utf-8?B?eE9UdTVOcHZxb3o3emw3dnBaSEFvZ3RBdVMwaXRKdHIxc1lUMVI2L2pZMlha?=
 =?utf-8?B?aW9jSEUvOENJaWw2d2pZbklDZGt1bDBSSDlsZktuZ3p1NS9Pc3BrdHdlR2JV?=
 =?utf-8?B?aHhGN2tIdWdSQnFsS3dwcld4VXl2S0s0RTczRUY5MXEyV0NLeXdkbTJvWnND?=
 =?utf-8?B?enFzSjVGck1LdHY4NW1zYnpzbGlnbXZ3TDJ5a2NrNDN0UFcrVVFReitHNDZ3?=
 =?utf-8?B?NngxVTZlcEc4TDVvbktVVDB0Yy93ZERvU0tZMGhXTkloSEdQMy90MnUrVkNH?=
 =?utf-8?B?alUyVTVad3ZRYTk5QVpUZ0k0dEJoVXREYTlDSlV6RzdwWklBRTEwMEgrT2Zl?=
 =?utf-8?B?S0Mrdkk1VFErUy8wb3NyMk10TXd4d25JaEdkSUxGUXhqdmRVQzJzbmhKdEgv?=
 =?utf-8?B?c1YvZ1d5eVFMa0RFK3gzVXNZaFVrQkdjL3JSTXlmam9JY2Nhb2ZWVFBPaW9W?=
 =?utf-8?B?cmpvVGJXanhsbnFqa1NIdVAvTVRRUTNTZGxpQ3FJRkp0STRtdjdzQUFvSnJx?=
 =?utf-8?B?ckgva1ZqMllQd2tDa1dsaitVVXZCUkhmcTNMYlVBaGV3UlpvemxWQWk2VkZZ?=
 =?utf-8?B?ZWErUlhSSDBQT2MweEJyMnRoVVhFS1djOHBIaFRValNQL2Z6ZXlnTXpESW5z?=
 =?utf-8?B?RjQzVTZnU3NzN2lmWnM5c1lpUnBpejNGNEloanpxZ3RhQTRIRmJRUVdCOUVR?=
 =?utf-8?B?N1VGakQyVFNxdHNMemxESDR5VzRRdUg2SjNuT2NzRGR1bUNJMnphWmhwT2l2?=
 =?utf-8?B?c3Q2WFFEcThiM1kyWjdGZTRGaUs0c2VTRFRIemM2bTQ0Y0szaHhKbU5WUldq?=
 =?utf-8?B?UTRDQmF4STU3QjdhOEhNUXNVL24zMGpKYkNlNjJGQlU4bEtZb25naVZJaFli?=
 =?utf-8?B?NzZzWnVXNnhOcEhiR044d1F6ZVJPSERxdWV1ZEFqUmhxemV4NithVFlyazR5?=
 =?utf-8?B?cFdWRUVBZXFCL1VCYUZYS29WTlpoYmVQUEd1a1dYRmlydjFDMjZQbW4zRzhq?=
 =?utf-8?B?VnMyRjNlV2hnbk9nL01hUWtDaUZwVytMZkg3b0VZNWpRdmtLdnNBV29sWUx3?=
 =?utf-8?B?aTUySnRoUTNuajZaamhvSTNmTzkzRDBjdFZGazR4MC9vS1AvQ3hMYmtuOEN2?=
 =?utf-8?B?Rnc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5041437c-7e00-4f60-7554-08dd1448030f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 09:42:48.0687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ap5eLmw/TVq2/GJhA2glcW95lDgUWwsGuBlFByK7Bzri8Lffl1pVLFCRji1+7roL1upJ7dYasZfi9TZuWjdBDxVkJm+K19EWASwaTgpzDKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8593
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 04 Dec 2024 09:42:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16863

Re-adding the docs mailing list.

On 12/3/24 3:09 PM, Simon A. Eugster via lists.openembedded.org wrote:
> You don't often get email from simon.eu=gmail.com@lists.openembedded.org. Learn why this is important<https://aka.ms/LearnAboutSenderIdentification>
> PS: Is this patch going to be merged?
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16857): https://lists.openembedded.org/g/bitbake-devel/message/16857
> Mute This Topic: https://lists.openembedded.org/mt/108604612/6293953
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [quentin.schulz@cherry.de]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


