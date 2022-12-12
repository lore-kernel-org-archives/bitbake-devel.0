Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E464C4332F
	for <webhook@archiver.kernel.org>; Mon, 12 Dec 2022 09:44:09 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.48])
 by mx.groups.io with SMTP id smtpd.web11.39184.1670838242535689964
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Dec 2022 01:44:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@theobroma-systems.com header.s=selector1 header.b=PbT+Xdnb;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.14.48, mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KojlU1yAf8QGHIlRZh96cw6eRE0yZ38cbDFesrGOQNkn5bRwNOgfu3yX323yCFBw27ewQa3BNTZlZIClFTQgA4DTJ3pA6CF8E0RpHdmQLA104KV08/veLd6tLy02SzteQ0gO73WufaTsB3lj5bKN85HaqAa0AfXWzInnuAS0qw4Gx/lOs93pglZIzS9tLUwANTF0SkmT2/AJU5XipgkORIYXd6cnbXQr/BbTTsEW4dANcTrmXlTa+zCRTfUvMD/EFJwkyiJOXAX126Wbto/IR4MVcJRghyiOdu7ovDC/o58SyGk/GCkLrF4obYQOzkwEXFvwYo11VMmIkFwsn+nRMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fy60VZlqw1YTDTWT+JpFg80OFhPdyYc8QLscHcWGufg=;
 b=ljjd5o9RNb24zuAp+DgDiREXVb5VwKToxmKZ9f0Cx9h6qgwG3tdaSK0pZfYWthN65q8DbLTxU9gPQ2l3B+CIjmOmsOLMEjHFWrJbRVT8LtMf9gI83I/NjDU0WZIn15zPnrfw5io60iTwSsKx2oG1zuoc1y3+js6cojizCyazVaCflbV5/ota/1nQ/YwC8soCy9GrELwK4BCNljJpYYFTQwKmQhsLVACk//PIx9mGuQS74Vb1a8Fw6FoP8CJRJqHh9R70ioAf5HKhjLdOwggrHhBimlGtl0TryMbCUdULr2kE2L+pBfQJj/oNaJGqqM6R+nJX2UmHNpgGI0aT3PTRSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fy60VZlqw1YTDTWT+JpFg80OFhPdyYc8QLscHcWGufg=;
 b=PbT+Xdnby1tO3/BOJFhZFJfp+MamL+6L6v0bJnTX+Cmv1Zd9H5gffXGN78LbF8F/rl4w55JUTOir7927zV3W4hcQU9JVSjzbDq281TXZx0fEOFYDnpghcXMKdC41dHFJ2IfWDjxLxxlt+7unm/WDYVIx97/cbXEnDLuneNIjYhUvL/vpJQcAX9fMBEanHZOyKIhcz6CZ9Op7zyaMbrJNCVGAfPPrTqRHVMB9zyM0Ry8agORcYcCAaUK1uGDEtXyLO5AXupijqgJxARdsvE7OCFgYeipq3WGBEgxbiZ/BQsJvz5KrMV8y/nmpmvR/2w9DVjG7OgbeTW8keppzPHx/BQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by DU2PR04MB8773.eurprd04.prod.outlook.com (2603:10a6:10:2e0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 12 Dec
 2022 09:43:58 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::9ebd:cd48:9396:76f6]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::9ebd:cd48:9396:76f6%7]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 09:43:58 +0000
Message-ID: <bdca9634-55e6-1fa9-bcb7-2c5f836e71c0@theobroma-systems.com>
Date: Mon, 12 Dec 2022 10:43:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [bitbake-devel] [PATCH] bitbake: Bump minimum version requirement
 to 3.8mi320021
Content-Language: en-US
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
 Richard Purdie <richard.purdie@linuxfoundation.org>,
 "bitbake-devel@lists.openembedded.org"
 <bitbake-devel@lists.openembedded.org>,
 Michael Opdenacker <michael.opdenacker@bootlin.com>
References: <20221211173345.22120-1-richard.purdie@linuxfoundation.org>
 <e064a3a6420349819788be767f1bdffb@axis.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <e064a3a6420349819788be767f1bdffb@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0902CA0051.eurprd09.prod.outlook.com
 (2603:10a6:802:1::40) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|DU2PR04MB8773:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f2d1185-a5fb-429b-90e6-08dadc256435
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	TAwsVmjxo1d/hcS7KksxmSalSr9rgjdtc2jdMTH1++/mDWW71Rnqkrz8ljgQ4w9lZCfSly2MB9SfbK1UkXO5qgvuCU5DNsixIv1IeT1ImkV7a2FkRYhhJDGnVO9NuzmuasTv/smCcvSfrMF2AjadOfTntoseiVjGAh49bffQI2h4U0Kl2f3nrRFMcr/m3qzUWYP31W43z3ce/ULxmpCbsslsLpxvKzHHrVtHB1huX9BYNrf4YLmlwmg4Rr088bJ256tHs/kNa3a7OEapA49X+ncKpQ4dS5/l2VY+Fe/6pZa2I2fRbb76RFD8ZiXIZdCL6uDK0NVDeRstZmblBqdNBZ/fQcQBZuvaEt3VitThEWYq1+RFxDK8jItvgbEp+8Ji+5nsBqHG7Snot1Lp9JzYK4Yum+LE9D4CqOz9VckcRqexCDtVnx4HrlfT3pzCfYLLnO2OGbyJgFM/FEExLzv9y5aozkVM3noHNMQl1ycj7PSdbOBXxP53oNcKoSMFlgHDhB7pG7IQq/cAbMsxL/AIAkOTT8oBZmIbV3AePtnEWVetSX3rkiMhXJR9qKOHJhSKsMqaOufhw56sPcJfvgavxoniRMdFVsSmsly9NtCQDtfuWQdOZ5dQOphMQ73UkS5luuz1eh9n4ruPMM2ijxr2ILfKf9/VNF0CYAx4nvejOSmY5dGB9YOeKsAe0M7CfB6IhLq8k8nDAZhhV3wUP/Ap7mpN93zq5FhY+M6HH3JPUUv2yeExNOrs//Lrs+TFL/UM
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39850400004)(366004)(396003)(376002)(451199015)(31686004)(66899015)(36756003)(6486002)(86362001)(31696002)(966005)(478600001)(316002)(110136005)(38100700002)(186003)(8936002)(6512007)(53546011)(6506007)(2616005)(41300700001)(44832011)(66556008)(66476007)(2906002)(5660300002)(66946007)(8676002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?b1FZdXZrTUlldmNvbEFKT0JmdHBJcFE3UEUwYnMrejZDT1lFNUpaVGxqekRE?=
 =?utf-8?B?QzcySmpDLzVqbHBPQnVxNUU0TFhMSnBXeklBZFNUYTF1dWtBVW02YnRvN2VM?=
 =?utf-8?B?a0I4MVY4NUxHVVZTc1VFYThseHRHVWJOdGFUanViSlgxa0FxZ2gwTlE4elRG?=
 =?utf-8?B?VkgxMUJkWi9sd2wvb0NDR1dmdmFEblRobnB0UjZDM01yd3dFSVBuY1VKeTUz?=
 =?utf-8?B?UlRJT1R4ZjRaWG1HYkh0S3paSXNrMEpHVHQ3aTFnV3NwR1dyZXBBRTNaTFZj?=
 =?utf-8?B?Vlh4V2hCY1l3czVZWmRJcXhhbEJxMG9NSVBjMENZeHVMcU5Bd0V6bzZBRGlN?=
 =?utf-8?B?d3JGcnRaOS9VZlVNMlFXZnFjSTZjYlVGb1hWaWVFaVovVUVCRllpTDBvbVg2?=
 =?utf-8?B?YWVLTTE2a2ZMUldiK3NPeXEvOGxpQk8yQkdGUnRTTE1ZcUVEbENUN1U3RlJK?=
 =?utf-8?B?QTJ5dHVZQ0N6amFmWnBJeTU1THF5YWxoUE5hYkc2czIvWThmTkRmV1ljVUpm?=
 =?utf-8?B?SHdzTm5xT0tLQTd3alJuTjNXT0RqYktSYVdGSnJ0eFdGUDBURDNvV1lML2xy?=
 =?utf-8?B?YjA0VTJuVStIV0JNOVR3c2xqNUNIN2QxWEk4TmpvQVk2ZkhHN0w0dGVVWFJU?=
 =?utf-8?B?UkVFODBudExlNnVvQTI1TkZpQjUwMis4N3pvYU9mSWNkbjlOdUhaL2ZIWU9V?=
 =?utf-8?B?ZC9PaXcrbnlreWRKQ2R2NU1kb28wbGpzRUEvcVhJMDlNN1lmVUZnWWw2S3Zs?=
 =?utf-8?B?UElGRURqdktGMGMvbDhxRyttdXNBbzVQQkcwN1NIMDZEK2xtNytYaENoK2hL?=
 =?utf-8?B?ZjNGUzhmS0l0NVNCOFM2a2dlUFo3TjJoNkRaRmdiUFEwS3pKUGhEQUlXK2h5?=
 =?utf-8?B?NG12b1RIOVZteTNMQ1dPc2tUamZwYklhbWN4Z2dDalZsT2JVckthZHQ3cXBv?=
 =?utf-8?B?dHdYVHdnV3dXdTN4SnpOWnpkdi96WnRmZEtKclN0V0taOE9nOTFPM1BHSkFY?=
 =?utf-8?B?OWExRmZDdmRtWHpNZm1BcDZQbENuUEh3TTJyNlJJZWJrSmlOcUNBL0ZweXhY?=
 =?utf-8?B?dVBoUFNyV1dJenplN1Z0N2xJQ2dsbXFXL0tTVThUYWxyOWFJakMySmlEZFJI?=
 =?utf-8?B?UFVVRC9Oa0FwekxCNE1DSXlSb3dsbjdMRmJzQTVpOHRXaklOU016SmFYMGtw?=
 =?utf-8?B?aXQvb3N3RFp5L1RWV0pwNktPMkJmci9rN1VFT0RLK25sZTJnYWhRTHJtNVkw?=
 =?utf-8?B?NnBjNW02SDUxcVhRWFUxeTZtVXY1SmU2dWh4c2FsZC9RclFlYy9mdUQwNzBJ?=
 =?utf-8?B?bFcwVU5GRXA2aEZYNHArRFhRQ0UwWDd1UVdkaEpETjFxZXk5RWRXRDZtdUVE?=
 =?utf-8?B?QkVVWjVuQ0htK2VOU3ZwSTRidTgvRm1Xa1JkYkVFSnFVZEpocERTTmpKelcx?=
 =?utf-8?B?UHZxUktMbmVnM3ZBZFcxd2xGcit0K3F5blFmRUV1bUc4TkZjQkhybTVVRWxC?=
 =?utf-8?B?Unl3L3ZDeUI4QVJIeVVQUEZCdEc2SVFBVnVuQnhIVHdGSHF1SWZuT3ltQms1?=
 =?utf-8?B?L1I2WEpJa0FOVnZDREZsQU02Z29IeVRqSDROMEh4VmxVYm90L0VYcFNMb0RT?=
 =?utf-8?B?a003eEJNR1VsN21jTFpUWkdXL3ErcTdVOHVzSVJ0aFhuR0YxNm9FamR2QmZ2?=
 =?utf-8?B?VWN6T3JSbFYrUGE4bmo1dkhQWSthdDcwZEg3ajhrbkZmbVQ0cS9HR0tsSWly?=
 =?utf-8?B?MmVBQjRYa2MzeTlyanJQZ3RVeWlOUmhwY1I4YzBLd0VMWVFTM3Y2eHM2TlRr?=
 =?utf-8?B?bEM4ZTRrejU0TEY0MzVZMDZLZnFieExpK0hibVZncnJSRk5RMkwwQTl4QXBO?=
 =?utf-8?B?MmNoejFmTUUrOXlkZThCbzVwTk5YV3hVeTc4TWlFczdXeWRMVEJTb3Y4OFRI?=
 =?utf-8?B?bXBNZWgzWWFhYWJmZGpqVlpRcVhGSllYOXpZT3gxdEhCOHRBZFBKd0NnOHF6?=
 =?utf-8?B?NFg4WVZzZElmM3hKb284ZEpMbUhvNEUxQTdFVCt6c1c4UEtEeTg3WEcwd25H?=
 =?utf-8?B?ZXp0aUl1TWI5Q2xDeTBCQzhJaTFQN1ljcWc1UXhld05zdC9WTnV2YjFBYjFh?=
 =?utf-8?B?d2FDb2hQZ2xVZisxVUlkdmg1aHBzMzBFdVZrVTM2VE1UV0hQVzU2TkxYdysr?=
 =?utf-8?B?RG9sWUNtcUUvVitORlkrMkppK0xQeFlONk8zOXdPZ1A4ZUhkaENESW9WSTZU?=
 =?utf-8?B?U0EybkhONlR6ZkZIYVVUVHhaOUZRPT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f2d1185-a5fb-429b-90e6-08dadc256435
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 09:43:58.1822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gnnVMj9r5pIN/2gC0ugrwjUb+OCd7g2Jd0beC0RQ1Njhn86MYVqdOEs0FgYkgStTwWi0sZ6qL3+x/XVbV6K8AoH1pt064SrTWu5Ya9foYtqvvPk81iN+FyJIyNCBDKpI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8773
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 12 Dec 2022 09:44:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14177

Hi Richard,

Cc'ing Michael on this since we'll need a doc update 
(yocto-docs/documentation/poky.yaml.in) once this gets merged.

Cheers,
Quentin

On 12/12/22 09:03, Peter Kjellerstedt wrote:
>> -----Original Message-----
>> From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembedded.org> On Behalf Of Richard Purdie
>> Sent: den 11 december 2022 18:34
>> To: bitbake-devel@lists.openembedded.org
>> Subject: [bitbake-devel] [PATCH] bitbake: Bump minimum version requirement to 3.8
> 
> Change "version" to "Python version".
> 
> //Peter
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14176): https://urldefense.com/v3/__https://lists.openembedded.org/g/bitbake-devel/message/14176__;!!OOPJP91ZZw!hMYvyGt6WMGQXlkYLe3EHIgvHzuuiuzQOCISmXP8VB_dAzvg3ewL0sK9vYnoCk04q7JPacI855Y7ERTm_KbQO2ELLtq-8fBxnVOJBbIh$
> Mute This Topic: https://urldefense.com/v3/__https://lists.openembedded.org/mt/95603808/6293953__;!!OOPJP91ZZw!hMYvyGt6WMGQXlkYLe3EHIgvHzuuiuzQOCISmXP8VB_dAzvg3ewL0sK9vYnoCk04q7JPacI855Y7ERTm_KbQO2ELLtq-8fBxnai1SxZF$
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://urldefense.com/v3/__https://lists.openembedded.org/g/bitbake-devel/unsub__;!!OOPJP91ZZw!hMYvyGt6WMGQXlkYLe3EHIgvHzuuiuzQOCISmXP8VB_dAzvg3ewL0sK9vYnoCk04q7JPacI855Y7ERTm_KbQO2ELLtq-8fBxnU7p1QLI$  [quentin.schulz@theobroma-systems.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

