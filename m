Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647C2C44502
	for <webhook@archiver.kernel.org>; Wed, 21 Jan 2026 10:02:10 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.22])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8469.1768989727988090971
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 21 Jan 2026 02:02:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=FPpwWTp8;
 spf=pass (domain: cherry.de, ip: 40.107.159.22, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VqQu8CGRFCA6m/LMtWYhLYnPo/E5avb5bQteq3vD8vousowrtJTHpoGrQE2wvePxWf+ocOOXyRdAA63PkhruXn5j9zUFBVMRP9dSCxGSQA/edconMrMAc47gwFoZrcGy3xoQB3/aWx4QoGp9TkbxzdKf7cydimRdWNOaGv+AYiOBI3/vgeIJFoSRGElFilap4b1DrVoO2bBLrxiVwqG/pZwmxBbQj2i6SzcsWCc6ANGz8aYhENa1eFNwRtMV4NMZmc/qC6UhSYoc0XkScn9GzPNQj1sZwZyMnbEPfkf+8FBd/RtjHrWqLXuMk+gdsF7W570OvHwRyuRBLy3AKTf39g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41HU3n6nkFKvwotYGQaji6+cQnmBVl1tfg/LRjGXJtE=;
 b=eGWPKn5NHnXZXcRJaXLBI86riss8TPvNMp7zsMcBH2xzaT01R3/ArsQlBX8rOens/ZrfwVcC6lFVG0sQJ3vyc8mgRYqBUeOPVd9o4zFhergCmAXnT6W3Z26xZoSEr8OcvrgcXBaMoWo+Cd0qVw/ftYINLrFJ2CYDmLc5pKGMWbkyEqo/p5idCmT0lPuYMeQPg0pJWNwS67HTvUpqc3uCSGuvlrFURH/fRdOJDz4qYXU9iBp5FFjI0q2xHZvCy/lU1RgAN0w3/4rOK3uPdcFNzxBSyAJaNiWsjr2tKz+PBbuhX24uVhvGn5qK2sDkIQiFRw9KvEASgLUaMM5+q1c5lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41HU3n6nkFKvwotYGQaji6+cQnmBVl1tfg/LRjGXJtE=;
 b=FPpwWTp8tNYYmJh6PvdRXoIllPgnyiLxCN90XR2La+7Th19odg31LoWD9fuKOA03STo3atBdveMSwZt/oy8W0jIXK48b0f0ahwEAew7qdbow2V0d33b9jgBL14E5ZWqsRaypRMBxsRzwJunCPYEb5a01YmRWVlUGfOlXL8oXa5U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PA2PR04MB10508.eurprd04.prod.outlook.com (2603:10a6:102:41c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 10:02:03 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.011; Wed, 21 Jan 2026
 10:02:03 +0000
Message-ID: <4e1605c1-7f20-45d1-8291-399001921ad8@cherry.de>
Date: Wed, 21 Jan 2026 11:01:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH 4/5] Add Python packaging files
To: alex.kanavin@gmail.com, rob.woolley@windriver.com
Cc: bitbake-devel@lists.openembedded.org,
 Alexander Kanavin <alex@linutronix.de>,
 Richard Purdie <richard.purdie@linuxfoundation.org>
References: <20260121024723.2634264-1-rob.woolley@windriver.com>
 <20260121024723.2634264-5-rob.woolley@windriver.com>
 <CANNYZj_DjeLtLYLFNdwc=_RjagYAkdPuZznP5+QRLpc8bdE3hQ@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CANNYZj_DjeLtLYLFNdwc=_RjagYAkdPuZznP5+QRLpc8bdE3hQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR4P281CA0302.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::8) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PA2PR04MB10508:EE_
X-MS-Office365-Filtering-Correlation-Id: 8adc78d6-7949-48df-90fd-08de58d42073
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|10070799003|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dGlPZDBweWNTWHdaTUlOYUV1Y2p4V1JhaFJLS1IyUHozencvclpkVjZhUHFQ?=
 =?utf-8?B?ZkxHSU9UbHlsMDJxMEh2d0pNaDMyOHZnVTdGRWJJS0JOZ0V5amdnN0d6TVhh?=
 =?utf-8?B?T09Fd2k5SkJqVVVoMytyZGxvMWQzS1NJOUJUUVowcmxkWTUyOTBNeFNDTzFR?=
 =?utf-8?B?dzR0RTFBcms5eHI4UDJNYWdoczMweDhGVGx5VVFwclRJcGJjNCtJNzV4N2cw?=
 =?utf-8?B?eTdYM2R5TTFLb0g5UnZVSUVjazVvY2IyREdOYjQ4NG1oejZYdEhUd2hTYmxP?=
 =?utf-8?B?MEJEWEJmckhjQjNFQnl4dmQ3VGpUZDB3bXI4VFhyY0dvaVR1OTN1eGoyUlpa?=
 =?utf-8?B?V3N2TndnUXNjOHo5SkxETlIrcldxUEdYbXZqM3doUW5CSUxuZHNRRHJjaWpz?=
 =?utf-8?B?Mk96a1JhcDhCUHg2L2cxbVVYWUFnOC9ubElGUDhvK01PRkhDR2VZcUIxQUpj?=
 =?utf-8?B?ZzczSkNYOG1SRkVYUWFPcCtVRDcrZ2hjdUZ5YXNhN1pGOTBlVEpscHNOaDVU?=
 =?utf-8?B?YkRLVWF5NktzZEJWK040MWxWcU40Z1BYTDgzMWxlUTl0cTd0YnorSUljRG9i?=
 =?utf-8?B?SHluMi8vNFdrQnZrUllzbUd2eDhYdW5zdFoyTnE1OTRLLzdzNHFVNHJoelN1?=
 =?utf-8?B?V2ltUWZWeGVOY0VPU2JVcm5tWVJCYWJCNC9GU0pva3dRMjZDWXpyNVFOZ0J0?=
 =?utf-8?B?RElBUHJnOFdzTitXVEZzWUhRSmlVMG80bi9HN09uZDQzdDdudERQYVZMRmhK?=
 =?utf-8?B?cEJna0Iwd2JJK0FuS1pHOHhuY1FJTVJqbWNDUlV2TVBybVhsc21yS1I1WGp6?=
 =?utf-8?B?K28yUkFORzJ6MjFpYVVDS0pzZGROUkkyL20zazdqL3Vma1BkbGhGM3ordEsr?=
 =?utf-8?B?enF4TkprYmk4OFFzRVI1UkthRk5ncDhuTjlCUGFwMm1xZmhwdm9wRVBzMlpm?=
 =?utf-8?B?dGV6MllVM282RGNXMmY0cXJLdmFCNVRHWkx3ZHNJdUwrTnNRa2tRWEFDSEpD?=
 =?utf-8?B?NWxVWnQ5SzZBS2hGMzI4R3M5dDZWUjZ5Qmprczh1alBQQUhyNDIzTkg2L3l4?=
 =?utf-8?B?VkJtcVB6UCsxMnVWRlJNazFnU3BKREtRT2RwMlp1aWVBSnVYS1ZleVpGSlkr?=
 =?utf-8?B?WHhKTmVWKzVwUDhicDIvWFVCWDV5L0tyL0JOTzRIejYyKzRqT1h0ZVFseW5W?=
 =?utf-8?B?ZUxRc2dRMFFyenduc2tjUVc2ZWZ0Wnh4c0VISHUwUG5ZWU5ObkMwMVMwTFp1?=
 =?utf-8?B?SXlGUXMvRnBvdlZ2OFdmTlkwTDJQNXpXL3N1VytNak1rVERGQTVZMlBGR0dY?=
 =?utf-8?B?Z0xiUnNRZENWemRHL3NMdUZ0RXAzNFZmRWNSV2FGaDJ5M2ZFaUx3clZpb0VQ?=
 =?utf-8?B?TDZtaDgyQndvRk1Zb0ZIOUZnaFRTRFpZdFJFSUhYNlczaStpWnd2eUo2enNR?=
 =?utf-8?B?Yjc5SjlPR3BUUCtua0ZWSXYrOUJuYXRIRzZVVFhIdXZTTktCQ2lqWXk5SlNr?=
 =?utf-8?B?N2lhSEl0bEY5RDM3NjBaWXVmdElteVZib0NUR0UxRkZsU3hETk5KUW5uV3pE?=
 =?utf-8?B?RGwrUWJRcWJzNUhuQnRQblJuN1JtdlhPTDdmQlBwT3ZoWHFhRUE0OTgzelQy?=
 =?utf-8?B?QW1TbUZ1L05PVHBCd0VxOC9EMGkyWUtWVDFja0wyaHk3dUIvYTRRemRnWVRl?=
 =?utf-8?B?VjJwMXJHRjUxMXFScTFJdzBMay94WjdSWnpVZXIrcUhXVkRrQ3h6UGxNN01G?=
 =?utf-8?B?U0EwY2JhSSszVXY3WkhHT0tVT0NPYjlveTBMdUQ1NWwyOU9XUXRLakZCUm5m?=
 =?utf-8?B?MEZvdUtzY3dBVnZGTzdlTVFCbmR4VVlER0FldkxWdXJYUzNrbm9MZFMxbHM1?=
 =?utf-8?B?WWJMa3Vsc1RGQXNmQUhOdFFhYjJDeTNHOW5GQmZOOUphS01GTUp2ZWgzcm1Y?=
 =?utf-8?B?cjFWTzlIcnB5YVF1UWk4NTZJRzlwcGFDUU9VK2RQMmJJMTlySFNRR2NwVVhM?=
 =?utf-8?B?WUkvYmJxT0p2UndPQTFWbkZuczduNHJzcEgwdVVMSUI2bzdFY05qaGt4Y0tx?=
 =?utf-8?Q?jccLBU?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cHphMGNsdjNydGl5SXd5MTMvcEhCbGRBK2RBUEIxTERUMWZ2aHRVMkJYVHBm?=
 =?utf-8?B?SFpBKzBMeDZHQ1RHK0ZBdWlQZ1F2OHF1bmh4S0xJVkZXQ3hPdjJnNngyVWRW?=
 =?utf-8?B?c2JpalByQWM2dGwvWC9xeElDVnMyV090NUxxNXBrUHVrME5RV2FtMUhxTllW?=
 =?utf-8?B?aWR0MGdTUWVaUmRvdy9vdUJHQ21PUFZKM0FzSnRzOVF1TUdlY01qSEc3L2p5?=
 =?utf-8?B?b0JSc29BOGt4VWJ2elY2dk5GMi9pMWV3bDBzQ2lOZktneU9xajQ4b0R5a0ZW?=
 =?utf-8?B?ZHZzSmp5RXpTZGxRemJKVTZvUDlYK01WNVRKVEZsdTFzaytvanRoRzB1L0Vq?=
 =?utf-8?B?dFQ0bHJFSGUxVFhTU1F1cUJiVnQ1eUxLaFI2WTJQZGVqTGJQU0M4Y2J6WVJS?=
 =?utf-8?B?YUVsaFZrQnRXTWFmUGhyS09leG11aER5aWdhcUNBbW40SnJZOUY3cG9ycnpQ?=
 =?utf-8?B?cTFzSndjT0hkOVYwREFiQU5UWjdGSVo3QWs0NGFLQzJoWEhMN1FNbWlEVVN4?=
 =?utf-8?B?alE1c25HaHk3V05LVFM4c1c3YjJCL1YybFVNKzJBdXQ4elV6UUJHanBYL0x1?=
 =?utf-8?B?S3dzTFlWdHV3N3hwc3VlUHl6MnBNMEdYWTV1ZC9XSkZEblVESjZYM29mNm5n?=
 =?utf-8?B?YTBWSDkvNE15SXB2dm5lbm9FdDZBMjIrUlBBTG1mOTMvMjlmT28vcHFDUmxF?=
 =?utf-8?B?RFRzRVdpMks5NU1PeFpVVm5UWitJeVE5TE9FOVdSVnVmc2tDVnpvMWdja2FN?=
 =?utf-8?B?b09ma0NHYXNQN0p5eFJaUFhRcmJCTDlCb3dQcjhZbkJERlBaT1BHT1YyZENH?=
 =?utf-8?B?QVUzVEZVOGR2RlR1cHEvTjNqSU5hVjhWN0lKNnBDQk95NnBkUU9KTEk1MWZp?=
 =?utf-8?B?dmRlVy9Rd012cmxLWk1UanpJTGY2Yzk4bXhBV1VUWGtwM1kycmJ2YllYWWxv?=
 =?utf-8?B?R0xMOVdYVGhXZndSR1cvVThMZjJQMVhxYmZUQ3JCb2czOVlxYmxRbjdRNlNy?=
 =?utf-8?B?cWtSaE8yZVR6ZzAvaXZaRkRHR0FnYVBHS2FKdDNHMEs1eXpPZ3BQYitib1NB?=
 =?utf-8?B?VXNLUTNGdkF2eXZTTFBZbE83RktZbU5DUXc4aVlJMy9SMnFBT0E0L2Z1QWM5?=
 =?utf-8?B?Z3lUOHNnQ1FnaldUOTVZZHV6dmY0YUNBVDY4RDVyQ1ZPbjZsb1VENHBqMkZN?=
 =?utf-8?B?OXk3L3BZTkdQZmZrQU5uOFU0Ui92S0ozTGhlL2NpV1RYNXhGVC82VXczQ3RB?=
 =?utf-8?B?em1FeWFjU1ZHcmk4cTVNdEQ4c3A1YXRNbjgzVlRZdk0vL1JncDZhR1phYmZ6?=
 =?utf-8?B?Z2FBNmZxM2gvVjU2UndOL2VoNExJcWdhWHVoUkt6YzZ1MzFCZTR5dEROVmdz?=
 =?utf-8?B?QWFINlUrb29oUVhQVUxKWitQUkNIMFJRdXVpb1hGR09ZWUVtaTdLQWZVQkFJ?=
 =?utf-8?B?ZFJCQi9mV3RZYkxCYk5sa0sza2NvZCs1djlPc2o4Mm5iYU1HcHdidHArWDF0?=
 =?utf-8?B?MG1FejU4NzlDYzU3U05rbGN1VkxtMjZ1NktTQWp4WVl4SEFWdVBld2FxTGsw?=
 =?utf-8?B?K21ibDdXblNTN3VQQzI5Z2lrcEIrODVhMk1INzFXZVJHdURpRkk0eTBQczlj?=
 =?utf-8?B?ODM5VHZpVTM3ZW8xK3BGNWErNTZrQlNGS0lvOUh2NVJvZTJCQi9DNnMvTks0?=
 =?utf-8?B?OHNjVjBrMWplSHVucmpnV3gyaVFIMWpjckZlMUJzbGVxU1JSTVF5OFo4MEhu?=
 =?utf-8?B?OVFSM2ZLNlJNVW5oU2JSaUYwTElIZ1FBVGtLWFE0b0hpU3J0TlRvYmZXdEVk?=
 =?utf-8?B?S2JMQUdLUGk0aGV3eGk2OG1NUzdQdXpnS29MS1FQYUZwTXpHZXJQRDFRM1cx?=
 =?utf-8?B?R2tQd0k4Q2lMcGxnU1Z2YkY3M01nTXlaQkFEOVduVzU4bklwNU83T1lTTGkz?=
 =?utf-8?B?ZWhCZ1lSMXVNWXlMd1lzRW10VnQ4eWNIeVpuMjBOMTQwUDh4c2hyWXFTVkJ5?=
 =?utf-8?B?MTlmb2s5dkluVFQ4V2lCcGx6Wno4SHQrNnZTRW5wQVA2U0JTdzZGWS9LdThM?=
 =?utf-8?B?STQyWHJDVWVDaTBZMjRDNmFVT1l2T29tWkt2WmxDK05tVUtHZ3ZrVjJ5by9L?=
 =?utf-8?B?SnpUYk5IOWovcnhLR3draEpDYXo2REswN0srK0RIQzM0dnV3MDFyM1RhSXQ0?=
 =?utf-8?B?YmxpRUhpZU1neEJsMzA0UVJHdHBBKzBvME5WdUowaUovMFgzbDhEczQvZGhP?=
 =?utf-8?B?YjBlOTRGRXlpYVJpQnNVZ2hkUW1tU2JFRmc3QnNKLzdhd3BTajRlR1FqU3ln?=
 =?utf-8?B?UjJmSVVlWlNzVTN1bHVuTkh5RUVaYkNXd2d6RUpJVUxjRm5iL0FqdTJTME96?=
 =?utf-8?Q?h5jm1E4l+4QdmlAREN+3dQgvzpiZnD++gY1gu?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8adc78d6-7949-48df-90fd-08de58d42073
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 10:02:03.5244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vXns0U9CJT/DjwbX2ztmu0X8q+5dlAAD8h1LRSwnUcVFozJRdmNsRlDxdhpnId88GOi+WlXH6Wj2BpxZbN8i5LyVM+thcNAKdl94ZYt+XkM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10508
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 Jan 2026 10:02:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18836

Hi Alex, Rob,

On 1/21/26 10:41 AM, Alexander Kanavin via lists.openembedded.org wrote:
> On Wed, 21 Jan 2026 at 03:47, Rob Woolley via lists.openembedded.org
> <rob.woolley=windriver.com@lists.openembedded.org> wrote:
>> +version = 2.16.0a1
> 
> There are other issues in setup.cfg, and the commit title should be:
> 'bitbake-setup: add pypi packaging', but before that I think we need
> to consider the release strategy and version scheme for it, and get
> RP's blessing :)
> 
> Here's what there is in terms of tags and branches, and from what I've
> heard it is not easy to change:
> https://git.openembedded.org/bitbake/
> 
> I guess, bitbake-setup would only be released from the master branch,
> at least once when a new yocto release happens, at the point where
> stable and master branches diverge. Those releases should match the
> stable version, e.g. whinlatter release would have been 2.16.
> 
> Then the question I can't quite answer is, how to version something
> from the master trunk? E.g. if we want to release from master right
> now, what version would it have? Note that ideally it needs to contain
> the short commit id, for traceability.
> 

setuptools_scm should be able to handle that, see 
https://setuptools-scm.readthedocs.io/en/stable/usage/#default-versioning-scheme. 
I've yet to play with it (will try with 
https://github.com/yoctoproject/bmaptool/ in the next few weeks).

Note that as far as I could tell this means all versioned files in the 
repo are part of the sdist by default (but you can exclude them via 
MANIFEST.in).

The next question is whether we're planning to upload bitbake itself to 
PyPI in the future? If so, we need to be careful about the layout. 
Building two packages from the same git repo isn't that straightforward 
if I remember correctly so if we're moving things around, better 
anticipate this possibility so we don't have to move everything around 
again once we want to publish bitbake itself.

Cheers,
Quentin

