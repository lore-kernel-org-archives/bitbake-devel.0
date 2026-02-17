Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069B5E6816B
	for <webhook@archiver.kernel.org>; Tue, 17 Feb 2026 11:52:56 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10360.1771329169672940535
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Feb 2026 03:52:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=XiUCC7On;
 spf=pass (domain: cherry.de, ip: 40.107.162.47, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ums2A3vXdSjYKEnCq7bjrbVM5Bazrlaqv1HnLLOO99CrE4L46xsgeJrgCbYnhY+Snh0bACfI63dWlaL3nZoZFKMsLRafHycVNORDzU1HHkA3td3CHPCvwMt0X0lQcIhadWLOJQB86X9pSbU6EMAwbmhqbMlpYIenlEyJ95BU7gG+7IUGCGlWdmcEF3sEa7diaYYHZr2jDOGIob5K8/9o/jOsnNlPE0h7q9l+GuTDe2Da9vlB835OMotPThq9RhRahc3O9BeATF6HGp8QyoXhPcbnAOoxKP1r+Jp6UgrHjcJgibjYz2XutatMUN4XftyNURLY+Sh8lKwqlhpGE3bxGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0eF91zEMxfmmU0rQkB7S21NUHPp4HpZQweIFES0cxA=;
 b=PxNoEFi835NTC7y9nkhv7ehXhrkKVMCMecQTzx/rcr/yAQL7Rxu7DZWPgXaFJQdOfE/hVAb+j5mJoDJD3yUvnNu2AH2swU36mw7unTPOuyCN/E2boPKO3oSFwMYQZ0cnwK8ShDjDME5kQvyZF4wC9RRnEO5gZvYk45ySYS6lfwQVcuA3g1/9ymsXXZuhDI87mD/4r02oZr5fU7WkRdt+2ORn2kv42OjdxSOnN1GQx7Xb1WdlINK3RLGZqvmPlexA9wxkv+NGFlABlQ7HxgEdOjkmHQQ+Kn60vZZ2ga2xxSnhMUk7X2egE4PD4K5kQSQtoqkZWddTOtVnL9uicUIVEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0eF91zEMxfmmU0rQkB7S21NUHPp4HpZQweIFES0cxA=;
 b=XiUCC7OnQBKgg8csMPN0WBU4MPg/8lVOPmywxDeGW4C+ogdMwOz5ZDHLqaFCU/o1RIYzp4oA8VJs1dpUXbOe27/4gRpbIHJbAE1JT0G+rchBtMNw8kM04lhFCK1qXAc4KGXmkL3F15SfUgwXbXkb82Vjt+/POtjLghRTC0zhAN0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DU4PR04MB11007.eurprd04.prod.outlook.com (2603:10a6:10:582::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 11:52:45 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 11:52:45 +0000
Message-ID: <8c7d0a2e-e7cd-46d8-8747-899703a31071@cherry.de>
Date: Tue, 17 Feb 2026 12:52:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [docs] [PATCH v2 3/5] doc: bitbake-user-manual-ref-variables:
 expand and reorganize BBMASK explanations
To: Antonin Godard <antonin.godard@bootlin.com>, foss@0leil.net,
 bitbake-devel@lists.openembedded.org
Cc: "Robert P. J. Day" <rpjday@crashcourse.ca>, docs@lists.yoctoproject.org
References: <20260216-bbmask-slashes-v2-0-b9bb52f5fd3d@cherry.de>
 <20260216-bbmask-slashes-v2-3-b9bb52f5fd3d@cherry.de>
 <DGH5S8O1WAJV.1GBNF55N3LGY2@bootlin.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <DGH5S8O1WAJV.1GBNF55N3LGY2@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::18) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DU4PR04MB11007:EE_
X-MS-Office365-Filtering-Correlation-Id: 78bfe23f-88be-493d-14b8-08de6e1b103d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TDhEbGpoMTJvN0dOSkZSbnE2VnN2dTNYdStESC80STFHekVzZFJBWnBhWWtm?=
 =?utf-8?B?cW5sVDJCQTYrMVJWYlpDOU9lRUNzRHhaUW5UVWNuZ1J5cHJTM001cEJLTkhM?=
 =?utf-8?B?NGFkaFJpaXpXd0hsT3B1U1M1Z2FaS0xhc1VFbndGVDhwSmppUml6SXpmakdw?=
 =?utf-8?B?M0dsSmpzSDBqckpoYndpMHF5cGIrcjErMFJRRnB4d3FkS0RNZTRSb21XaXM0?=
 =?utf-8?B?b0hDR21DZXA5S3RMOUxuTC9OdUh2eDBUdzIxQ1ZvS2dPVWNoRkhCVExNS1px?=
 =?utf-8?B?ZEhXR1VwVmZ1Q2RsckFkVUx6UXBPMVdqTmg3Uno4a2FXdnZwb3JMSGtLRytW?=
 =?utf-8?B?M2FIckRtL2lkSWw3OHNQc3ZiYVRYczZqQjNYblhBMzVvVUo2SkVjSnk4T2Fw?=
 =?utf-8?B?Z2FsMmJ6VTJNTUtySmJLYkZ4dU83WG55MG9USnJXNjl0YXJUZm02VFVCcnBz?=
 =?utf-8?B?NUl1UDFna2ZQczE4N2lFbXdnb25uVjhGQmFIN2ZjVFl4N3JuSmdWelo3eitG?=
 =?utf-8?B?eU1tcXFmTWoralcvNTdadHdtQmt3VXlSRktHK3piM1NXS0ZkQXlDYjV0M29r?=
 =?utf-8?B?ZDVmZ3VvcGJYajBmV1RVUDduekJzQkhaaG9uUkl0eGt1MUg3a0dEUk8xdEpY?=
 =?utf-8?B?OURrM2ZJYk4xcWhXeHNvbTQ0bkJSbkZQY1hKZnZDZGg1TFpucDVBSC94UCth?=
 =?utf-8?B?VTd4WitMY3dLUVE5N2hRQjFZSHZGcXkyRGcwK21Yc25MY05QWE90ejRkTEJY?=
 =?utf-8?B?emUvS3UvWmpHakNJcFFHc1lnNndTUVFXVjQ5dnAxbjBuUUk2ajlMSDFMZUtv?=
 =?utf-8?B?ViswWU5TUWw5STR2aVo2QitYWWhqK2VSWnpVQ21BWUhEUWJrajBjdDNRQkxa?=
 =?utf-8?B?TjlUZGlvWElKbWh6YnhpQ1kxL1ZHOVQ5eGFkWmgvU2VYUytIbFFUVThsbmVI?=
 =?utf-8?B?a09QNUZHOElYQkd4QUJGR1k3WnhMWEVWZURGNERsMzFqVHYxdnhSZkQ2UVdj?=
 =?utf-8?B?cTcydlNTNHZBamluVDBEa282SmxEZ2xaWW9jWlVvZkJkVnRpWWxLSDUvVDA0?=
 =?utf-8?B?czNrTHFMMWp2MnVaNzhsK1BPbExpY2RPM1Y1dW5uY1hKY09Ha2oyL0hDVFB2?=
 =?utf-8?B?N2NZNXlDN2ZjdnRZWC9KQjFRZ0pndjF4NTAvSU8yTEE5dWwxSHFBWWNaeU5u?=
 =?utf-8?B?U0JPeUFuckZtUmM4OUV3SmFRUGFaMUtULzExSS9kU0pYbEVheGlwTUtXRytB?=
 =?utf-8?B?TkU1T1ZVa0FJd2pkR0c1Ty9yUVhIdmpyZzhpRHpiQ3dXM044SE1tNXA1bXZT?=
 =?utf-8?B?dSs0VERJRGtaN0M1TktudUFmKzhHajhQMk9IcEFMWkNydUZCUTFBQ2syT0ZW?=
 =?utf-8?B?RWptOS9MZUYyR1RSdWMwZENxQk1NRXVKL2EzWE5jZ25oWk4rMjJyK1huQ1cx?=
 =?utf-8?B?djNYM1dYS2RFSG5IQkJJMk9KeHJiR1FhUSttd2d0dklGKzZrS3YwOWpGN1NP?=
 =?utf-8?B?Z002RlNpWEU3b3ZVeWxjZWZUQ0ZiR2Q5RWk4eG1VeVE1YzZ6RWsyUTAzazBM?=
 =?utf-8?B?WlFqejdUVlNoenFWTVl4ajZKMEhyYmNBQUlNZGthQnVHeXc4bFo2by9la0Z0?=
 =?utf-8?B?anY2TjJXUzRMUzZNRENJUCtXTWQrQnBGcjhhSmM3ZFZsRGhZdE5KSXBSN1ds?=
 =?utf-8?B?RndRWTVlc3l2c3lQMG8yaWx6K1ZrU0VCUGsrdEk1OGRTbkFRdWF3VWtMRTBv?=
 =?utf-8?B?eUdQdDU4MUtjR0hPbGFrM2NKS0hDQncvbm5ZR05mS1FLM2dhL1BseXYxblFO?=
 =?utf-8?B?M3Yzb1pBUmE2R20vY0lTcXQzbk5Mdm5mSHJFYnBjWGdSSlV6UFNSMzNjNzk3?=
 =?utf-8?B?OE9SNzJDODNHZUhwY3EvWlloNFdxYnZaeU1QK3llSUtOVXBEUDFza0lGL1ow?=
 =?utf-8?B?VGJZUllSY09DcWY3NWk2UDQvcGxmclg5RlhRNGUyVlB5c0toQnhSd3JUQmNj?=
 =?utf-8?B?UXZuOHVsbnQ4VGVSVmdCZEVaVFlEK3g5U2xqbmtuazdVcGVOL3JWaU5ZRTcy?=
 =?utf-8?B?VWNuSUh0RmRseUNpKytManZoZHIzQ3pxNmdJejQ1K1NkRmF2SzNET0hJdXd6?=
 =?utf-8?Q?bxSw=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WW5BYVJjbUZhSEpMTS8vYlBYMTZobG1KRG5KZnp5RGRSTmRub1Fkek1uZjNW?=
 =?utf-8?B?N2xPL25mR2tqUUFjQzY1SlF1RHB0ZklrM1lNZElTMkhMQ0ZxSldkZmVzeVJN?=
 =?utf-8?B?OXpHaUVsb0d1VjM4VVk0Mnp0OVJaV3pQc0tOMmhFMFM1Vm1NUzJNR3hEcDRU?=
 =?utf-8?B?ZEJoTkNrSFBZcERRQ01PQ3k0QVBxaDJiMEpoOVRmakRrOE12aktDZTcwdjFC?=
 =?utf-8?B?OTVyRE92V1VrV3JTZFVOSS9vUWplNTBNWE14S0x5NEZOWndTUms0Nnl4WDh6?=
 =?utf-8?B?TWtUb1FzeGUvRDdoaWVZVUdtSXhHVFJ5VnphQnRWZmhyd2xERVk5TW01bjVG?=
 =?utf-8?B?U2R4TE4zeEg4UnZ4ZnpOcUxoUUJBUXlzVDlsTjFJNm1UMVAxcDA1NFpwWGoy?=
 =?utf-8?B?UHMyUDZ6L20yUnprcWh6NHhaU0tRNlhidWlwczRDUSt4ZkJYeWIvNEtGaUlu?=
 =?utf-8?B?UWxsRUVPYThOeTJDSVhUaHovcEhDU0dBaWc0ekdZREs0QVF4YkJtSXEvRkk1?=
 =?utf-8?B?Zlk3aGhKZS84QXVMWGg2VGd5MyttdDVFb09qTUd2N2lPVFhsRnIyd1FtZHRy?=
 =?utf-8?B?UjNEQ2JHTWNVUHBkM2liOExlb0FCN3lkeC9JbWRXYzBqSndTN3BlK1dKTlpQ?=
 =?utf-8?B?WmFVSVo1dGJHWVphdi9oUXIrTkVWOVk1Q1hVNGtkcUZEbUhRS3hkYS84czNi?=
 =?utf-8?B?dEZMWTZJaW9DWk9lU1Jxd3crdkFGTGsrd1lnNWJuMy9uYkp1RWFVaTBHN25Z?=
 =?utf-8?B?NTJ5TmxYaldxWWlpVmNxYlhZNTRsMEpQeU9FYkFlKzRRMTVoRFovWU4yZjhR?=
 =?utf-8?B?UVhMdzQwNmlWeGNsZWxlSEh1T0FJQThUazdwVHozeVNZKzNlVWZId0dSUUd6?=
 =?utf-8?B?TXFodzJzS0FvREdhUjRqbzI5Y2FuUTR4WUUyblRqT1pvd3VMRnk1L0JiUktm?=
 =?utf-8?B?Y1A4YUJ6dUhBUzNrbmd6ek1zV2lyWmExdXR5WFR4UWJQbkw1cXVVQ1RNNHVU?=
 =?utf-8?B?S244SXBYcGFCT1FydFRQcmRuUzZGR3c1OGw2WlkvY3JiSEJXdXNYNExEaCtP?=
 =?utf-8?B?TllQek5mVW5ZUk9wWG4xWG1LY3k5STFpczByMUg5UnF1SGpmNGVla2NNWDFu?=
 =?utf-8?B?NVV4LytScnF0ZW1iSTllRlVRMmpuaVR5YkFRYjNQenJaQUk0Ny9ZWnYrOTlG?=
 =?utf-8?B?alFDN0tac0x2TVl3NVJKc0MrbWZoWkFwaSs2Uk1PYUtvR2U1YUNaVjRkd3VJ?=
 =?utf-8?B?OCtlSk5YWDdQdmlvSWZzdGNoaUpHWkF5aE0rSVEva0pPblV5eGNoQVhOMG1w?=
 =?utf-8?B?aTM0YUVWQ0RWdktvV2VybTJYT3NMODgwM1VLSjR2bVpJT2M5UDBnVkh3VlRs?=
 =?utf-8?B?NjB3VU9KVjQxSWhBUUJrUml1QURxVUsrK2ZoZzZkbVRpZU4zT1BuWmU0Mncz?=
 =?utf-8?B?a0ZtVkFmdDdDRnNhOXIrelN2TXpTVlpxSFk3UFRxQlZ0aEdYejhIUUcrMHpa?=
 =?utf-8?B?aDhVcGNCa3MwQ2htckRiNHMxUW92Lzc5cFdPbWljMjRCMnZPVHY3VDJqQkZC?=
 =?utf-8?B?SnBxSjF3NE00WXdyR1g4RTdxR211ZjR1TEU5NWRUeVRpQll0N1dKcDdpK1M2?=
 =?utf-8?B?VHJEeW5RU1ZFeGVjb01tSGRVbDN4ekoxS0l5WlpWSHpGa29pek5oVmdsakhK?=
 =?utf-8?B?WXNMS1JDK3pLWXNkSTN0SUNuaUN1MHRHTW1IOUtyUDkwUjdRTUYrc2VxVDlj?=
 =?utf-8?B?WHBESTFWR0xXS2Z3b0FNYmR3OFlkMG91L0lkMUNaUGo1Qk1kR2hSVk10bFVU?=
 =?utf-8?B?S2ZqbU1Yc3hiNTlzc3BEbzFtbXlNcW9mcXBHL2ZpMFVoUmVnV1pzcEhLa0Vy?=
 =?utf-8?B?K1FtYUFha2RRRUZQUEtvdVJmS0JORjFwWHJ2UyszT281Z0s3Vk1JM3BjNE9p?=
 =?utf-8?B?Q3dRRlJmVitvL3VONEV5aVpHcHVSb2VrUFFtTGZmTUY5YjdKc1QyT0treThj?=
 =?utf-8?B?Y2ROU2xkeEh3QlFtblVmYS9MVU56Z2p4elVFdU9OY1MyTmlCVG5taTFia0Nt?=
 =?utf-8?B?amxQeldBVTNvQW5vNFpweml0bFBTcDdYbldDTUl6bi83bkN6UXNxTEw2RzZa?=
 =?utf-8?B?YVBMYzRRSTdwTkc0a0NPZ0paSmMzSHJXaElXaERON2Q0a3VoWlc2MUdYUjNB?=
 =?utf-8?B?cVVweEt3a0lJV29Eai9TVHZ0ZWtJRXppL2gvdmhlbThGd2p2TjBCLy8xQkxP?=
 =?utf-8?B?MThaRTY2MzE5Ti8rcElZN0Zxeko0bVM1azQySUREbkZHaTFFQ1ArVzllL1R4?=
 =?utf-8?B?Q0RSLzVoRGt1YWJGWDdXM0JTd0lOYUpFY2xaTnRwZWhrZXhvUm9FQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 78bfe23f-88be-493d-14b8-08de6e1b103d
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 11:52:44.9866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y+CRuH/2a+JZNvWfv8S3TVkcmICEni+l1N25DvbFFRFc6XitXgNVcNvWCF+vIugeSzpQ0vOdMMez9Q5rSd42Ljgde8Di8I1o4e9+XWpvnNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11007
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 17 Feb 2026 11:52:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19048

Hi Antonin,

On 2/17/26 11:18 AM, Antonin Godard wrote:
> Hi,
> 
> On Mon Feb 16, 2026 at 11:36 AM CET, Quentin Schulz via lists.yoctoproject.org wrote:
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> The documentation doesn't explain the side-effect of putting a leading
>> slash, only the trailing slash.
>>
>> The leading slash is not for making the regular expression match an
>> absolute path, but to force the match on the directory or file that
>> exactly starts (and ends if there is a trailing slash) with the
>> specified string. So let's explain that.
>>
>> This also explains that this doesn't prevent more than the intended path
>> to be caught, specifically because it is NOT a regular expression
>> matching an absolute path.
>>
>> Because any pattern not starting with a ^ character can match multiple
>> directories from multiple directories, let's make the usage of
>> BBFILE_PATTERN_my-layer the recommended one. Keep the rest as hints at
>> what can happen when not using but reiterate what users should be using.
>>
>> Reported-by: Robert P. J. Day <rpjday@crashcourse.ca>
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>>   .../bitbake-user-manual-ref-variables.rst          | 87 +++++++++++++++++++---
>>   1 file changed, 78 insertions(+), 9 deletions(-)
>>
>> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
>> index f20a9012c..06e1112b5 100644
>> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
>> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
>> @@ -1052,24 +1052,93 @@ overview of their function and contents.
>>   
>>         The following example uses a complete regular expression to tell
>>         BitBake to ignore all recipe and recipe append files in
>> -      ``meta-ti/recipes-misc/`` directories (and their subdirectories)::
>> +      ``recipes-bsp`` directory (recursively) of ``meta-ti``::
>>   
>> -         BBMASK = "/meta-ti/recipes-misc/"
>> +         BBMASK = "${BBFILE_PATTERN_meta-ti}/recipes-bsp/"
>>   
>>         If you want to mask out multiple directories or recipes, you can
>>         specify multiple regular expression fragments. This next example
>>         masks out multiple directories and individual recipes::
>>   
>> -         BBMASK += "/meta-ti/recipes-ti/packagegroup/"
>> -         BBMASK += "/meta-oe/recipes-support/"
>> -         BBMASK += "/meta-foo/.*/openldap"
>> -         BBMASK += "opencv.*\.bbappend"
>> -         BBMASK += "lzma"
>> +         BBMASK += "${BBFILE_PATTERN_meta-ti}/recipes-graphics/libgal/"
>> +         BBMASK += "${BBFILE_PATTERN_openembedded-layer}/recipes-support/"
>> +         BBMASK += "${BBFILE_PATTERN_openembedded-layer}/.*/openldap"
>> +         BBMASK += "${BBFILE_PATTERN_meta-ti}/.*/optee.*\.bbappend"
>> +
>> +      This masks the ``recipes-graphics/libgal/`` from ``meta-ti``, everything
>> +      under ``recipes-support`` in ``meta-oe``, every directory or file whose
>> +      name starts with ``openldap`` in ``meta-oe`` at any directory depth > 1
>> +      (e.g. in ``meta-oe``, ``recipes-foo/openldap-stuff/`` or
>> +      ``recipes-bar/baz/openldap_0.1.bb`` but not ``openldap/``), every append
>> +      file in ``meta-ti`` at any directory depth > 1 (e.g.
> 
> s/every append file/every append file starting with ``optee``/ ?
> 

I'm going for:

every append file whose name starts with ``optee`` in

does that work for you?

>> +      ``optee/optee-examples_%.bbappend`` and
>> +      ``recipes-security/optee/optee-client_%.bbappend``).
>>   
>>         .. note::
>>   
>> -         When specifying a directory name, use the trailing slash character
>> -         to ensure you match just that directory name.
>> +         Because these are complete regular expressions, if you want to match a
>> +         directory and not a file, you must end the expression with a trailing
>> +         slash. That is::
>> +
>> +            BBMASK += "${BBFILE_PATTERN_meta-ti}/recipes-graphics/libgal/"
>> +
>> +         Will match anything under ``recipes-graphics/ligbal/`` directory of
>> +         ``meta-ti``. And::
>> +
>> +            BBMASK += "${BBFILE_PATTERN_meta-ti}/recipes-graphics/libgal"
>> +
>> +         Will match in ``meta-ti`` any file prefixed with ``libgal`` in
>> +         ``recipes-graphics/`` and any directory (recursively; and its
>> +         recipes and recipe append files regardless how they are named) prefixed
>> +         with ``libgal`` in ``recipes-graphics/``. That is, provided your layers
>> +         are available at ``/build/layers/``, it'll match::
> 
> s/build/builds/
> 

Mmmm.. Now to come to think of it, should I use

/bitbake-builds/poky-master-poky-distro_poky-machine_qemux86-64/layers/

instead? It would match the instructions in 
doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst (but 
it'll make for very long lines :/).

Cheers,
Quentin

