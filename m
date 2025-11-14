Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BDDCDE01B
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 07:17:27 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12645.1763104647158164136
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Nov 2025 23:17:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=V3/RRXLY;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=3413a291a4=qi.chen@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AE5KmoV1972404
	for <bitbake-devel@lists.openembedded.org>; Thu, 13 Nov 2025 23:17:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=QSK/elt7AXWuQsdqtgjn6yO/ftC2cPN8DGAGQFskPlw=; b=
	V3/RRXLYt5C1iUEnPy5V87Igq0Oan51YspVhTCq6A/w7TOqScgAnijGQHmD4Kmzx
	b5UU9gqAsApbsZGBESlRgER9DTeLLJfb1/VcegDc2RpSrJ0HQ+aw3Vycsnu5uIi6
	97SdXMtqMSygy1hNGzL5z+8IvvAlXQtKaG4LDIThG2ie5Q/sa/K3Z3UXNbNoVRyQ
	Xd5jfkmiqMBrq4U7wLOp0blw1rqQ5JULZ93LmSRGediXUEiGL7HJ6YTOgMErlRvP
	sChV0OzfYxaYZ5B86hTVZFRu3iIAm0X+Z4ywFdeCWfzKgDJ2XHGkbyyZVuHOb+6m
	wH5BG7FEEX3QbZXQMJhqFA==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012022.outbound.protection.outlook.com [40.107.209.22])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4adtk6r7xk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 23:17:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpB2voMuJrm3aMxBiXhLb4byMbsTcXI+lqQDazA894Wh/VakT5VPb+H3VZ+gGbt0PhjTQxjbJA6thCnsM4xT4RnEON1We1exmjQAeaJHo0IzaXhc6Wg3i/sAjZpSv1oZ3jojOHuBHjwVuT2kjy+GPuuEEWAGBDG4ljkuXffFfLlQIBhDaGYX/UnzMPF+ylYgDYPNy2cJ6/pO0s1Sth9b17xxkqKXYCAiiRyReF+703ZIuskPCYmfXN+rIrDoSL7E2pbqKU8OAFCVHEI4JCBrehLz26CR5eMRA+qEsdO3Uq0r8glfo9E/SVkLYg5MXkYzFhD388855YkZdQPbqW9KHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSK/elt7AXWuQsdqtgjn6yO/ftC2cPN8DGAGQFskPlw=;
 b=hj6kSLDHvTTiHwgyjTdd9KkFR0qHmSYsc2aLAIu2HLxUGuxWr9OUNkri0haa5AGVRLdl2sHUVqgFhb3Bg6ZJfX3N9KhMZjlJbO5rhy7GNB9YUGkX2PT4q2cLIw4RWCnANXvwxnlG8r3kuAEMiUZPa4Reckkgh7Pxg8bmO0VLah0KTEz+pyrpFaeK1sRQu03/CYEXVx3nRpUccs3zD3+Re56soUP2YlDgzWCO7WIjqhiERVr6+/9R4AshelRezFQqt2BO6toC3jM2hcuq/Clr08Bf3thsyLC31JwRZbyD7/KbunCNlhx6++CSxDAgIdV+lJuv9tySL69wUyn6x16zjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by PH3PPF307806035.namprd11.prod.outlook.com (2603:10b6:518:1::d13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 07:17:23 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 07:17:23 +0000
Message-ID: <afddd5c5-ab6b-4e9a-a667-93408a2d070c@windriver.com>
Date: Fri, 14 Nov 2025 15:17:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel][PATCH V2] lib/bb/parse/ast.py: error out for
 internal fragment in case of a previous value
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, richard.purdie@linuxfoundation.org
References: <20251114060211.1742728-1-Qi.Chen@windriver.com>
 <CANNYZj_J6oJOpdYsX7Rnz8ViL4==q4ktLhfx5MZHQNe1s9SF-g@mail.gmail.com>
 <a0e64b88-cb5b-4dcc-8b6f-147765f373e0@windriver.com>
 <CANNYZj8tDk8izGO2f_8ADHsaN9VudG_hsQrcw2N2O8NnXtdCCQ@mail.gmail.com>
 <5fffd119-5b6c-462d-9f1e-5b2b30f81715@windriver.com>
 <CANNYZj8eqw8QF8eWCoLki7XXWZ197pVZHckLtQ5aQx29aU+o4A@mail.gmail.com>
 <451e3958-7661-4070-bff9-b3bce661c21d@windriver.com>
Content-Language: en-US
From: ChenQi <Qi.Chen@windriver.com>
In-Reply-To: <451e3958-7661-4070-bff9-b3bce661c21d@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY4PR01CA0025.jpnprd01.prod.outlook.com
 (2603:1096:405:2bf::13) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|PH3PPF307806035:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e6befd9-12c5-46e1-f255-08de234ddb62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|4022899009|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QUpUeTQydnVwVGFvMXcyaVUrNkNTb3ROcGNDdkRHQ2ZiUm9qU1lZNzU5aFla?=
 =?utf-8?B?N0tSVzF4NjgrNnM5TWJMcEJ3UXl6Rkt4Y2hJYWU0R211M2lPOWtGSlBHamZK?=
 =?utf-8?B?YTNveHM4UVVvWWNKVVJxeWlxeFVqbzMrRmJGOHZiV1VMN01zMmhBdDRyYk9R?=
 =?utf-8?B?OEhGeUcyWWsydzcyZk1RU3R2eE9NU3hIaWJ6YmFJbUZUOTUrWUY3a3dlUUxZ?=
 =?utf-8?B?YWVUNjVFU1RZUDg0MFFQZFFTT1NOVVpCZ1pKNjFnRCtXOExoQWVhdzdmeHlL?=
 =?utf-8?B?bEtzMkNxYmwwTndUcjNSZ3J0N3NiM0FVWU9nK3BKYmZnL1FJWjJGVHlmRVAy?=
 =?utf-8?B?ZXU5N2x5UmZ4R3haSnFMNFlVYmJ2bG5iNmVxd0RhVGRvRkZUclhPT0NOYjlm?=
 =?utf-8?B?MUh0TFlYLzBSc0UrdWxQQ2NxYzdqM3huZ2NmMzRXY0l5bDN2TkV6V2hMWlpx?=
 =?utf-8?B?ajlhRmlXbHk4NVl6ejlnS2pBWHAwL0UwUldobnZTa1p4K3FZZHFIY3AzTjZv?=
 =?utf-8?B?QkhiUFpSclU3aTNHdFVaa1Q3bXg2ZXZJU2p1YjU5WG94L0duVVNHQjVKeU5x?=
 =?utf-8?B?Wk81WjFRdWlxSjFiaXZwRDdwNnFKaEJkTVUxQzk1UW1SMjRlcmFGV0dLQjUx?=
 =?utf-8?B?VnJBME1mOTFZRHU4UlZ3VFk1Ky9IOHRLWGkzWXM1bDNsQW9HOTNUSlJqT2Jv?=
 =?utf-8?B?R3FheXo4WllsY1J3bHdISGNYa2xtVktUSVppT1ZHdkdVRG1HNHozWjE0WWV6?=
 =?utf-8?B?WEdSYWt1M2hIMkpPSVR1bFpwWUZyQnR2amVHZnozcXJUdXNvbUNKSUhHWUdp?=
 =?utf-8?B?UmdYeGI1SThyMFRsdmFDMnJ3Vk5WVGRvYjM0WnJ5VzBTeHFiL21GY0o4ZXEz?=
 =?utf-8?B?TVNHV2JNdnBnTytuRWZYaVlvbHF6WXN1SFpHUnVGaTBaZElicklJbjlvZ2RS?=
 =?utf-8?B?T1I0ekNpdVNhVmhuZ0J6bkZHMjdzd3JmS1BEUThXNnhYSHNpMW9nWVBKK1ZM?=
 =?utf-8?B?SUdENlBJOXN6SmV3eHR4VHRZblpqUkE2cnhRMGtEcTdVUEpDTjNyOHVodVM4?=
 =?utf-8?B?MTB3b3BaSkYrU3Y5U0gzVm5LYjgxTWIyaFZhNEh3L1BZUEh5NnQrdlFiOGdx?=
 =?utf-8?B?b2M3MXB0OExKWmc4a3lPRVpTSjZZV2UvYXZZLzhUS3RGaUxrZ1VKZmFMem0v?=
 =?utf-8?B?MXBuRmxLQjJaakpJRUtOVExhWituR0ZwdlR4UzZuOGVJVklXUVBEN25oWS9i?=
 =?utf-8?B?R3hzbHRERU9SMHVCLzB6Z3NrVW9aZXprNXNobzFrMlpBeFhFbmdtd1Q4cW11?=
 =?utf-8?B?OVFlTzNFWllBSWxhcHc4Q3Rkbi9zbFFQZVpsNjQ0UWhLeFR4NHVFcTcyS3Vx?=
 =?utf-8?B?eUUvdHZESFBHU2Nnd1RlVHMvaTZibVRBYnBoNUJFOFZUUVVMWUk2eXdDcmFB?=
 =?utf-8?B?L2VycjVuOUNKZmluc2JnenFDWFMzbEpWaXdhc2diWVBDaUZGd0d0VDAwYXE4?=
 =?utf-8?B?bFpmSGxhbktTbU1kd2thSVdidzMyQlk1bENpSjgyQnBkd1hLWkIzVXhCc2ZD?=
 =?utf-8?B?NWw4WjB2NVBjNlFpL2tTaXBncUdLZ3NUamFuTEJ6ZS92ZmlreWEwSmg2Vm10?=
 =?utf-8?B?VXB4OU4wY2FtM1M1RHNweVNoTjlDdWxkYlJ6VWkwMzZENFc4UDRFVWhlbUR4?=
 =?utf-8?B?RlMrWGtpRzA2K2xCVWtBWUp4Uy9KQmJXb1VkNVpnRS9hbGxwSFR4N01nbzBE?=
 =?utf-8?B?V00zeDBjaDVwM3pKK1EyYm8zZTVlUVRBVzRqQ0pqZkdZYTJhN29EYnVlYkNq?=
 =?utf-8?B?SXY5SmpjSTF1RUdTNStPakYvLzc1bVpQeVlzS1R1VU1ydzRzdTEwMzR1UWlW?=
 =?utf-8?B?MFc4aGZKcWtVL2F6eG5FRmkyVnR2aFVpcVdrMjRDMnNaMGk2UENWYnp2L2hL?=
 =?utf-8?Q?JNIdAyNbfKY=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(4022899009)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QnU2Z3llNHRCSUdPYmRXQzk0aEY2VURXM2huY2dZY1JlTDFET3NlcUxiOE1M?=
 =?utf-8?B?SCtSZUplR00rN2hYYkRUNThFVWVuZ0FkSC9raEtWL1FBSGtUU09WYkpEaThr?=
 =?utf-8?B?K2E5MTl3ekwzT0pYYUJIQWoyM1hhN1M5V2U0WXR1ZzE2L0tOMWx0Qk56YXc4?=
 =?utf-8?B?M1dxTW5pVW5xQkdRTU1SdWJaTVVoUXhPMjRVVkhYaDNHelBGMU1BM0tvTGR4?=
 =?utf-8?B?a2tZejFzT3lXYng5Vkt0NkkxYVA0YmxwMlpKeDh5cHYrSUkzYzRReWl1dmhN?=
 =?utf-8?B?aUtzR1RwV0MveWhlbGdNUUY5bzhXdXBIb2tzM3hPUTJzVzV4Vit4cFloTHpw?=
 =?utf-8?B?TUk1Nld4MFg3WXY2Y0Y5TmM0MVJ4MHhrbHZ1VDRWL2UyQUtmeWRvWjN3cVBY?=
 =?utf-8?B?UlYrRXgvK2JtRGpaRit0QmhzbHVtbHJCeWRxNnJyRnp3bEpjcHJxYXJYV3l4?=
 =?utf-8?B?WFZVcVBvQjRhVXNOeEgwQUtUc2xyZkpraWQrRnpaWXEzaG0zdTRZYkh0U1FH?=
 =?utf-8?B?c3NnT3o5cDBwdStGZmhKWjFLdkdyM0x3NmhQRUlPOElrdmVSaDljL2RER1JU?=
 =?utf-8?B?emJ6OVI1QmpIL0dvMU5mOUNGZ3o3ZkJnZlYzcWY5NVM1ZlF3ak92NnQzV0pC?=
 =?utf-8?B?cUJLNmJzVU5wUXZzRW81dEJoUnVuV3ovUEUrak5jYXF2VEk5TVlDcjY5Vml6?=
 =?utf-8?B?dk0zcWJOV0NVWUtCNzVUZjI1dHVKRjNmc0dHTlQ1eGpqRDhGL3JWaGdLUzNh?=
 =?utf-8?B?RmZuS0t4TERHN3FpbVMvSkt0K1JaSTlmSkx2bXBGUk1VZ2w4RFJKWjFaTGxY?=
 =?utf-8?B?SWd6MnVEMGxuU1VjcDBTR1BvdDBvdDBodEVoYks1RlA0OHJLTGZ2bTJkbWVR?=
 =?utf-8?B?MzlXT2xRY0gxVWJrNmNqQ0JDcDY1L05uS1FiUDJUUnRpSGVwVEVYRzNlWk9x?=
 =?utf-8?B?d2dueVJGcVFJWEZ2citmVUFNMlVya1krQlpZaXErMTJKNEQ1dTRiZWp0aFk2?=
 =?utf-8?B?NzRFZVlnUjFMd2NHaklnait5dGFlM0ZLYnVDcUwrTmpuQjFIbjNCN3QzZjRm?=
 =?utf-8?B?UmZMSmZlc3ZWYjRyZlAyQUgvMFdoQVN5UGU3TjdYUVhPY2NUbWU2cU9rRm1H?=
 =?utf-8?B?ZG1TcTN5eFQ0a01lSWpRTmdwMUNZTCtjSlZhQ25zOXpic2xEZjZub0JOMGdI?=
 =?utf-8?B?Q2I5cWdEYjJxWk4wcmFteWsydTlIY1RoQ2tZNDFwZk5Oa0pOUDFxR1V3bjEw?=
 =?utf-8?B?T2kvellPL2hrNmY3czZUNXduYUJSWXl3TDhqdmVPMzlFblpkYzBaSXNDWW9Z?=
 =?utf-8?B?Ni9zT2FHQ2VzQTBwZnEycDdNQVZrMG1VZ3p3bytQc2Z1aUU4V1Z2QjVFYTgr?=
 =?utf-8?B?OUE0TFlLQnNINEMyR1ZXUHU5aWkvUnRUR3VGNTk5dFg2TVdvRHBtM0laeUFR?=
 =?utf-8?B?KzFpUUNSQWliS3FsWnBNcy9hUXo5WUtjV0p5bHU3bFdaUDQ2ajcrcXFEUVp2?=
 =?utf-8?B?K0NWTlJUbkx6N3MyRWNSaDYxU0MzaDdJVCs5cHBTOFZTYTd0cmpRT2trQlAx?=
 =?utf-8?B?RnZES0t1elk5V2JZb0U1Y0tiWGh0aXdYditCS0E4Z3pJTTlZbUxaZTIrbFpG?=
 =?utf-8?B?bWd4bWZMY2tBV0VGelZHUStmbDBqbkNZd01jR1hWMVA5VkFDRngrTStvRzky?=
 =?utf-8?B?Z1Vrb3Nma2tyL0lsUHR0dGVjajVoenZHYmZFbHBtaTR6TzJBWkszQyt1K2xq?=
 =?utf-8?B?MHZIWnFzcGNpQ3VsOEJEZGFEVkdQTHBnSHV0K1NLYVBqTGkySTBoQnVMUTVG?=
 =?utf-8?B?ZDZlK3hQTVVGd2FzYnRvUEQwZkdtd0tOTXVSME5xM0pOb2xXMHp5NkRoTkRz?=
 =?utf-8?B?eHUzanBOaGZFM1ZtMWhBUDN2UWRJRzgvL0hDUm5BYXZ2OTlTWklERVphUmN6?=
 =?utf-8?B?NzRXb2hwZnUzODk0dyt3c2xvQjNIeHFnVml0TGpCTTJlcklRM0JDN2k4K0cr?=
 =?utf-8?B?NFR5eHNXTjZES25lWHp1SExCYTdxUUJJWGJVUFFTKzMvWnVmQnpOZWlFWjJ0?=
 =?utf-8?B?T0RLNHZLaUEvL0RVOVE3MmJCb3ZRNXRjZ2VoOUFpY0xCcmNKZGhTdjc5MTM3?=
 =?utf-8?Q?BEsvo5YPlq94HPFAGO9NSesMa?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6befd9-12c5-46e1-f255-08de234ddb62
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 07:17:23.5473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +CD/WmTU/NT2oJR1bOe9qYn+9LuDy/mjnRgHYtVhwHYAxxNJPM8vNBtaHvbKgGcMONO10Eq/UYD5inmEc/hkJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF307806035
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDA1NiBTYWx0ZWRfXzTraJhUdl80x
 ehYeRZ+Fe839JZ46SUNArmxQI19OPQsFlBq4qC7bjCLFkZS9gXCgKqQipOZkJzDwij8mKO32FN0
 6cD1voD9hrbiBkwfO2FCq4U8OwFxpX/+p2K1FGEoRTb0d7+1UA4nTOQWsH5ftjVE3gjcLI19TnG
 umxHtE8J/jFYvAZGokfMrsU0KusA5hc3mv/osTV7a4B7fSc3P3sJvhgtBSyTFvkJ8bbLi3hM9aD
 z3Gvh5L1r0yf3vZbIW7MT6a6tDOgfDL2rYovfP5vzJoc/B1HmNmsx83Y8q+Pd/nxMU1O69xJS73
 nxncrN1N6RCZ/zkp7yGClxVdXkuaVheWpOSLMXex5Ad0SxEm9StyrrQVzfoSb7F+wjj3p1K96tk
 GIXasz1EgSx3KTLjSt9RHvTyDDZLmg==
X-Proofpoint-GUID: YxXCUEFg-Zhz2zVgbGIA-GnDeshy9aIu
X-Proofpoint-ORIG-GUID: zxcq5fUJ4S_8GIrYCPXEUBVCDmS-Zz8C
X-Authority-Analysis: v=2.4 cv=YsQChoYX c=1 sm=1 tr=0 ts=6916d786 cx=c_pps
 a=LdSsacNKwWtvIYfRw5AjOg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=HvlrrJGs30CXpD3u:21 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Q4-j1AaZAAAA:8 a=t7CeM3EgAAAA:8
 a=Xn8t9kIPMQLonIh8Lx4A:9 a=QEXdDO2ut3YA:10 a=9H3Qd4_ONW2Ztcrla5EB:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_01,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511140056
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 07:17:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18388

On 11/14/25 15:12, Chen Qi via lists.openembedded.org wrote:
> On 11/14/25 14:49, Alexander Kanavin wrote:
>> On Fri, 14 Nov 2025 at 07:37, ChenQi <Qi.Chen@windriver.com> wrote:
>>> When machine/qemux86-64 fragment is enabled and users use 'MACHINE=xxx
>>> bitbake <pkg>', the expected behavior is to error out and recommend 
>>> user
>>> to use 'bitbake-config-build disable-fragment'.
>>>
>>> Here comes the problem. bitbake-config-build makes use of tinfoil and
>>> when setting up tinfoil, the above error will appear again. We can't
>>> recommend users to use 'bitbake-config-build disable-fragment' while 
>>> the
>>> recommended method still errors out. This is the reason for the special
>>> exception.
>> But why would users be running 'MACHINE=xxx bitbake-config-build
>> disable-fragment ...' ? That prefix is intended only for bitbake
>> invocations.
>>
>> Alex
>
Hi Alex,

Ignore the reply below. Sorry, I just realized what's going on here.

I was using 'MACHINE ="qemuarm64"' in local.conf to test things.

So the error will appear again and again even with a simple 
'bitbake-config-build --help' if there's no such special exception.

Regards,
Qi

> I mean that users run something like 'MACHINE=qemuarm64 bitbake 
> base-files', and they get error like below:
>
> ERROR: A builtin fragment 'machine/qemux86-64' is used while MACHINE 
> has already got an assignment.
> Please either disable the fragment or remove the value assignment.
> To disable the fragment, use 'bitbake-config-build disable-fragment 
> machine/qemux86-64'.
>
> Now they run 'bitbake-config-build disable-fragment 
> machine/qemux86-64' as recommended. If there's no such special 
> exception, they will get the same error again. Even if they run a 
> simple 'bitbake-config-build --help', they'll get the same error again.
>
> That's the reason for this special exception.
>
> Regards,
> Qi
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18387): https://lists.openembedded.org/g/bitbake-devel/message/18387
> Mute This Topic: https://lists.openembedded.org/mt/116288219/7304865
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [Qi.Chen@eng.windriver.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>


