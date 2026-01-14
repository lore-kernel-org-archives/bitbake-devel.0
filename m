Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827FBD38FE6
	for <webhook@archiver.kernel.org>; Wed, 14 Jan 2026 16:16:36 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14004.1768407395212127651
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 14 Jan 2026 08:16:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=lcdThZ79;
 spf=pass (domain: cherry.de, ip: 52.101.69.31, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fsrBs5wwIObTunSWOecNB3H75ngf5YLFvzUDtbfmV1S+km1V/GJpcd4sxDKBU3Y9C7wPsWvwPqhvz3O+vhuIape4ZOkVxOL1ZuaCyhVq1IaiyJAdOhBfzKOibxGVaxbcRYcxQXdMdIJlnkkEfHhZkmJat2zKnkZiFqIonepotCOMA2as6ldXsIbRwt6Q4e4d+hV1NVpc/X5GNekRPwr6soW8kv5ejZF2mCdLBz+sebY5GF/W1qz2eizq2REEGQ7P1A7qRYIq79xjrKoBqk7zdp2uMjK6a2KmokIKoHTcYC+4kggZAPL0/lp835ugCsoYcP9loUKe8IQHR21YqDUXgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lP+YP2U6pHuVzN6lrkmOhUMtBx4HZUT4iha0HolFR78=;
 b=oG/XMrCOFGMlC7ePMhVhgf1LtoTB5UmKBxeOfzyK79bfdK0tzGnkXn8eglMSah4IH07xSUUzx4jlo3PAibQH3ih2uudwbY6RujhIcNrmitlTDdtonzXyBIkUlSt55MwIXsKqiupgGeSDGs9sY9goaUQ6Aj6g/p6b7r4SD4+z8aS1+uW2SZaqW0ctgW/AMN2OQyMpVH4SPepEf9k619I81ircRT20R/GWVBYMfF8/DldAo1rzpE5ehAJPYw9MzoUi1R0742W7EJ22gw8/fTnGeixucMC5Wjrj4ZQq5Ve5uu5yHjnrC1XNhERdhdN1ero78xh+S1AqvnQzd7dPVXE4Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lP+YP2U6pHuVzN6lrkmOhUMtBx4HZUT4iha0HolFR78=;
 b=lcdThZ79bQlRnKY+10JyeGkn4oUkRzthcQkLyDzbA5oZ0CoDfBwYnYn0NpxHaG4cUDAlt4nMYx9ifk8WdcBF7M6VLc5mDKMtINo4m/pJLw/UIthOj9V8aGrpkaz7B0XZg8mxHbYlJKRjNQg+W0ZVbgtrudSWhymqknAVhUez/q8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DBBPR04MB7738.eurprd04.prod.outlook.com (2603:10a6:10:1ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Wed, 14 Jan
 2026 16:16:31 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 16:16:31 +0000
Message-ID: <dc69f413-3484-4e09-b209-82df24777315@cherry.de>
Date: Wed, 14 Jan 2026 17:16:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH v2] gitignore: Ignore bitbake-builds
 directory
To: paul@pbarker.dev, bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex.kanavin@gmail.com>
References: <20260108-ignore-bitbake-builds-v2-1-a70cdbbb6d6c@pbarker.dev>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260108-ignore-bitbake-builds-v2-1-a70cdbbb6d6c@pbarker.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0390.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::15) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DBBPR04MB7738:EE_
X-MS-Office365-Filtering-Correlation-Id: b0c4f456-537d-41f3-4c57-08de53884730
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aGIyaWRoT2psazRjY3RlaVJxVWNVKytrSmVMMHlWL0F3MHU4dXVMNHVaWXJX?=
 =?utf-8?B?TnFZSSt6YjU4Z0xTMUR0UWdZdGxFV1FXS2xsTEcyUHdPQm84Yjl0R1ZnallB?=
 =?utf-8?B?OWFmM2ladlkydk1ZbEtma3RjOEF6RUt5Q2Nsd3hyVXZUY1pXUWU0WkxKWjYz?=
 =?utf-8?B?RGNCcUpRcW1ieUFaalYvQ2hEaXZSWlI0TnVKVUtXUlFRNENGSVBqRTA0M1ly?=
 =?utf-8?B?SzI5c2dLRituUkE1SlpkV09BS1RCRlkvWE5iWm56Ym0rWlphQk1ETVZ4MlpW?=
 =?utf-8?B?Rnk0QWJBTXNuQ2MvWXZuSUx3TXRJZFphYU00S0FaRzYxb1Y2OFF0a1ZIV1RM?=
 =?utf-8?B?SzZIUjc0YzZCSHJMREl2cTQ5TFhnZGRrQUNRNDBDM3pEcGVYSVZ6UTkydC9H?=
 =?utf-8?B?TnRERVUxRERTZ0hSSW0zeEF1eE1rSHFGenYrOXRzbGd1SkUrUkpKR082aWh3?=
 =?utf-8?B?VzNMWUdFWTVEZ09HNG1KRUFUa1RxR0xhR0M5N0U5ZTUrUjRkNzBGYk1BbGQr?=
 =?utf-8?B?MnEzOHlTMDFlOWxSRWtIaG5OaXpKSzBsc1h1TXRCM2M5YUpPa1lKNlk4VVJy?=
 =?utf-8?B?S1o4ZmRnQ0hJUWJBdy8vVU4wMUxBOHdxZ0x4QUVkd2JzMnR5WkhRbnBmbXJU?=
 =?utf-8?B?MEl0OVFiK1YyUFRRMHNBamZGNDlXQ3dIaHdqNmN5OHdYTlBNV3NUdmFGUHJL?=
 =?utf-8?B?Z0MyM3VUNWlhTCtWaEpJOXRvdVNoNTAzSVdFbCtJQjB5SWhOakNqbnZNdFJt?=
 =?utf-8?B?Ly8xQ3BIV2dpQStLbmtQdXU0SW9jWDRSQ044Y2dUVytjUnpYUENxc0praTB1?=
 =?utf-8?B?M2IvQ0ZibWxuNHVkYzdnRTNoOFN5MDFXU2dqbEIzY1QxYWczQ0swSE95YUlw?=
 =?utf-8?B?bU9rMkREY1dCaHBRTEZhS0pQb0ZYbndYVE5wYUs2YXFNTGpWTmFucnBkWTh5?=
 =?utf-8?B?NVJ3M0lhK1AxOHM5QW4zTUdnLzBCb3ZFa0w0MUc5TktHQUxJMXdicnVyc2Zu?=
 =?utf-8?B?eXRZY0NXRTU3T2JzQnkvM2dvTUdHQWdaVkNFZHMrcTlTRWg5RHdTRW5mWHZV?=
 =?utf-8?B?TWN0RXJhYVZNSXpRRDd5WmhrM2wxRGxyTUtJQU1pMnpHZFZIRDRLV1ErVGJV?=
 =?utf-8?B?aytxNFJrWnVKWWU5aGJ4S3VpOEJjcmdQOXJaZmsyays5bm5OM0tpeU9rTUZt?=
 =?utf-8?B?b3hPdS9Oc3V1Ri9zeUJnZ2Z0dC95UkgrVFVVUGQ4K1NYU1NsanhReERobGxX?=
 =?utf-8?B?NlFBRUlNQ0xkUTJpRTFCalJQUHhOTHowdi9qMEJEN2JTQ2tic29MQndrUHp4?=
 =?utf-8?B?KzJweG1vYTJ2S1NWZkJGN2hqdnF4TmJOYXUzakYzOEM0Q1VtQmVHbDBsUWVC?=
 =?utf-8?B?ZTRvUmpSazZCa0lKc0x5TURRTWVFeDZnZzBCSmt4ZkM4ZXQxMjFUNGF0QzRq?=
 =?utf-8?B?amVRQXd6TE1PYndXakJJV3gzZVM4VTUyZGlIc2NrTytUS1c1OGFBZkxFelIx?=
 =?utf-8?B?a1FQd282QlJEb3VwWTQrVDVzSXNUbTNzZ1NBRFhuVFNJeXFwbitnT0FpMUM2?=
 =?utf-8?B?QjFnUUZEVUdMTzI1Y0RyaTB2dWpzSmFub0ViaURoaC8raFpMNWk5R3Z5Q0E1?=
 =?utf-8?B?bWVIOG1udmFraXBYN2gwK0R2N2JRZUNtcEtrd3BLbHZvVFRZelVjZ2IvNktF?=
 =?utf-8?B?Q1l6WjZhaUF5QSs1ekxTc1orWDRBSXJTdlp4QklwandVakVPb3NyemNHZjNT?=
 =?utf-8?B?WVMrOXZDMmJkV0ErRllaWDJJSWtwbUI1Zmc3OXlsQTIxa0d2d2ZjTnEwaHU2?=
 =?utf-8?B?aUEyYUR0dGg3SW02R1IrNjNGNCt1ZjVaN2NnQkxnZTc2TXAxWWE2NE53ekFw?=
 =?utf-8?B?dEY5T1p3TlRPUTVNc0dnQ05DUU5oT0RGWCs0akZ2UVpyM1FxTkN0NTU3LzFa?=
 =?utf-8?B?dlJQdmpZOTZycEI4b1Q4ai9Qb2xFbHFyYmREZXpXZHVOTE1sekI3emJUYnJS?=
 =?utf-8?B?UVdxcFRxcnBPSjVGNkpXTEFwRzVLZHRuaEJrMVJUbWlxUW8ycVAzK2FGVE1l?=
 =?utf-8?B?cFhBTmFoYlYxVllpQmVvTVlYMEZIV083b1ptSWFTZmNDZHNJT1RYc05BbHpN?=
 =?utf-8?Q?nzcg=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?R0k1UHJDckp5SzdxdHVJRitIZHhrYVA5WS9vcGt3RmRFV0RhdmJWOTM3RC9z?=
 =?utf-8?B?OFpWSURjM0hjNmdCRndrWUdVNWQ3L0dPSjl3RWNwR2FNd2lqSGFLSFBSV0lI?=
 =?utf-8?B?RWdpaGJUZkZ6b213TER4bTFWUUJRbWtYL1FGMWgyaVRIajRrdElWY21NeUx4?=
 =?utf-8?B?NWpBWmkyN04rdytyMmc5RXZ5bkJ3UkRxV3BxVFh3aXVZMWNmSUxybVlubEJM?=
 =?utf-8?B?ODBmZHRZODhZRTE4K3NmUDdXVnl4YVFmNEZYUVdtak5OUkU3V0hld2lZZHVl?=
 =?utf-8?B?ZFZiSFVsbUpUT203aGRyRUhNSkF2bSsxczNyRTRqWlp1VHNkdWNXL3NkSHhr?=
 =?utf-8?B?VktZTlI4VlZkU0ZvbDVyeHRzc3pTV3NnZWdiRXh3V0tvN2psN0R0K2xlTHFB?=
 =?utf-8?B?RjVjdUNuWlJSOUtNMkxpR0RwenV1VG9POFdsSlZaRDlZcWViQVc4aGQvWlFG?=
 =?utf-8?B?dmx2R0ttUGkrejlVK0htSE5FK0ZoallSQ29qY0xmR0ExOENJaktQK2VKQlZF?=
 =?utf-8?B?bmduMjdYVmFVRE1sQlF1aWcxNGFhTG1zNkJNVXNpWSt1MEdCczEyOWpUdDJy?=
 =?utf-8?B?WUViS3dWblhCOXcxaWVmdnNZcmEyY0hOVllRcTdMSWVLOFpaZnBSQVphcEhl?=
 =?utf-8?B?cGFqNlhqVDhnYlNSc080ZFl0VDJSRWR0QWFVbWliQTdaaFBvWmNzRWRiZ2F4?=
 =?utf-8?B?WEdScHRreGlzeENGZlVrRFRyL2hmVjBvSmV5MzdtZm5HS3o2ang3K0lFSFZI?=
 =?utf-8?B?RlZ3Q1pocjBvL3ZMaEpJWE1pTWhXU1U3RHhLQmg5Y0pEb2JqdHhtVGxrb1Zj?=
 =?utf-8?B?VVQ5TDVqRkhMekpEdUZmdEZBcThOUGsyUkt2ZW80ZEptUGozUG1pbFBwaUNk?=
 =?utf-8?B?Y2FQZnV0RnNXZmpLdGNxLzZuKysxNUxRWnAzcElWWHpNU2hrZTlmd215S1Vx?=
 =?utf-8?B?RXpGeXJudHUwRzF6OUVuZWtxS05QbWs2SXA1dTBCa0lzMm80UlhndG9lK1Rl?=
 =?utf-8?B?MVM3R1JCSDRvTlFvMDUrMmtDeXlJWFVaVW5IN1IwdUlpS3dPT2Q3TVRoS2VQ?=
 =?utf-8?B?TG5VeG5RMkF4d0JWNkladXZWV3EyZWZMVmRRTlIyMnErYS9vQWpFTjJZOWN0?=
 =?utf-8?B?SC91TFhPY2NMLzRUVTAyYlFiaHI2SUl4THcvTDc5ckRHQVp0UFdadThidWhs?=
 =?utf-8?B?YWtpTG1Kb29VUFFMV09JMHhGWGM0S0V6REVGWXl1czg0UXRtWW1qdmtvSWxt?=
 =?utf-8?B?Nnk0ejFOZk91cmJqNnFxN2h0bEZUc3Z0WkdIR1piQXd5TTgveXRoNWMwRjMv?=
 =?utf-8?B?ZmlGa2JlTzlNU1R6Wms5bmJwRkEwN0pGS0lHcmFDc0xqVTNhZTZWZTA0bkw2?=
 =?utf-8?B?d2g5YkZkSjZzTnExbjlsM3hEM0lDQUgzL3Jsam9DclBaakVUWExCZmlRcmhX?=
 =?utf-8?B?YkVLYlBrc3NENkFiM0Z6VmVlZTVGc3dhSEJYM1ZZNnd6ZzFJOW5uWCt4b3ZP?=
 =?utf-8?B?RTRGQitUWDlVd3VaZ1pIb2htc2FQRGQzbS9ZV3c2OS91bEliTTZPbDhDV3U5?=
 =?utf-8?B?UUJra2gxa1lqSktyZEJGRlZXaDFrbXpDM0RqNVVBZHhReWZFRGQ0VUsyaElq?=
 =?utf-8?B?VVllZnpVQzdNVUc3TzdGWDgrUmZVeVA0WkQvUmpaTGpKU3NtdUVHa2RCc2xo?=
 =?utf-8?B?OXE3SVBTWE1DclpkcHNValpSeGpsdVVCa1djR3hCcVdMelJkUmxWR1RUeUJn?=
 =?utf-8?B?VFh0TmJGNEFhcHdpL21uanE2d1FUaTRmbWJseHNKeEh6dmMzajJCRkRIdW5a?=
 =?utf-8?B?L1M1MUU2RW9KeVF2UVQ2Sy9HV1VnTDZTTFhkRlFMWVA2QTNJS2lGWFAzc1pV?=
 =?utf-8?B?SHkwdndaNHpTMjFXWkszWjZUTHFaWkFQMURCU2R6cHdJSTNMTzFUMGM2MnNP?=
 =?utf-8?B?WTVvcWphNWNqdThqYzhiOHRiQXlLeTZlNHBlNEFNbWYwdGZhZEZ0dFJidDE4?=
 =?utf-8?B?bUdzWHBMQVlzSElKdGdrcXkxUGh4ZlVTbUdpUVVGR1VRMjFTVGZ4MFVXa3Z3?=
 =?utf-8?B?YWZ1bUN1aXFTUFYvZ3dmZERCNWRLSVBoc1hsYTlDR3ZGOThtWkhqVEFLMUJB?=
 =?utf-8?B?YnVsNjVKZUljdWtDREZmNHhDeFNUNVFLNk5Tcm1JL0ROVWkxUi9KZ1k5Q1p5?=
 =?utf-8?B?bTFhcytHa29TTXVVOXQ0Z2pMY01qdXJpcHR2d0g0dDdXcWRYT1VKMFV6c1E3?=
 =?utf-8?B?bFFtYXRqK04vTHlObWlhc1JlQ1RUWUhKWjNudkFydm9SaU5hSGVNdjdFaUYr?=
 =?utf-8?B?QVFYSDdiZExrWWJtMGtIQVdvOFpEOHlkRGdMY1gvdWNiQk81NkRCUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c4f456-537d-41f3-4c57-08de53884730
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:16:30.9774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fXAohP860vO1G0gO8GL6HkLzg+ba/CpEJCOSPvJKw+vM9DbfXmz0v8RVJkIfbVRMCXLYm1vEWhVo9WiA93+voiWles0RaLHxr2NXYkGRCW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7738
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 14 Jan 2026 16:16:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18759

Hi Paul,

On 1/8/26 1:48 PM, Paul Barker via lists.openembedded.org wrote:
> Running `./bin/bitbake-setup init ...` in the bitbake directory with the
> default bitbake-setup configuration creates a bitbake-builds directory.
> Add this to .gitignore with a wildcard so that any such directory is not
> tracked.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

