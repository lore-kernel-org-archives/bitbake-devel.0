Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8500BD44C73
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 16:06:54 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.7])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.39458.1768493205985135533
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Jan 2026 08:06:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=HL3UGJYD;
 spf=pass (domain: cherry.de, ip: 52.101.69.7, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ghv4pmsz3A5svCVitcdNZKCoIZ/mGqM88ga7bnBfGZM+YGOqa5btG9RBMLk21m01CmfRdFcnN99o65WMMdwJwtZ4Z/g4oYGFe8eVloYTOx3gOzFGH8qKM+ykVRB5w8s2By2O1iqG1FOOtgL7Mq1HiLEbNBgWXYdyD8GzPT3OgEBqoFVQA2AJK0saDBbt++QhWRMwI4vT8OdA0HiUEbdopxA5l4rn8FagdBqVS9BY1wKmrHc5svfcMlEWuUlbAxadkURPsg9A1H0MKx3wg/f4g5fdD7aHf3dHqi3Dhd9k1XKzuxCSIjLLBdXTkM1wfYDYuX7TODzHbqGsPXiraJ/ugA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUM2vQolT8eTs3US0hB0esij7b/Sg4K94V5hQJSaCJU=;
 b=PH3SyK0/w+LnwrAXjc9GeXZlJgq4Vfw0Lh7AQSaZQiPC3DMKEeX5S1dx9RPP7ikhdo2NP9XdynfZVN107wXoU98QoU/0pdAEPuIzYZaZro2aRcEalHG+XqU12kDKXftknFZwvdDAZRT9riMngZxzSKCjfh4HidbY2jXk9A6e1j+DYLLNEWARrCmVfiriQn3fJwoeT0zzSrP3G2YQuF6FHReYDlRhP5zT1KxhTYO5SKaWToLk5QQbIO9Xpl1Myb0PEr4DvEuPuIQTaqc70/DAAejI3Rwmts+dhHCh0fQzBmTdh5/FC1CIWBrw7V0grKxxCRZ7EXkiQKji/VBl23R8Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUM2vQolT8eTs3US0hB0esij7b/Sg4K94V5hQJSaCJU=;
 b=HL3UGJYDhxmGmjrvkHdzihGv3N+FMSIwAssxKPCZ/b+sQ35a5KhG6aNJ9sr7cjweeQceazwouPicz6y2D3NUQKg+Pz4wn/Sm1xLGDIl3NAVeMZedQWTRdDaK9yj4qhBBZUZAiI+zZneoyeukbzi+myQW8TM9J7OUlpcjNFse/uo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DB8PR04MB7052.eurprd04.prod.outlook.com (2603:10a6:10:12d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Thu, 15 Jan
 2026 16:06:42 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 16:06:42 +0000
Message-ID: <dc2c4513-7b80-40d0-b966-9c94edc9e4ce@cherry.de>
Date: Thu, 15 Jan 2026 17:05:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] sphinx ref error in bitbake manual
To: rpjday@crashcourse.ca, YP docs mailing list <docs@lists.yoctoproject.org>
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
References: <ea1596c4-7935-f7b3-bac9-5ea56bcd28c9@crashcourse.ca>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <ea1596c4-7935-f7b3-bac9-5ea56bcd28c9@crashcourse.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0026.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::11) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DB8PR04MB7052:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d8110d9-3784-44e4-ce8b-08de5450129d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SHR0VjBJbGdaNjM4K3VqbktHYllZeWZzeXFpQ0tQK3ZtSFdiUE5QVFhNQmlR?=
 =?utf-8?B?OE1FTUVhRW5NUmRVVEhGdEdoMCthRmg5L013enZzMkN0d3hzYk9EamNlT0tV?=
 =?utf-8?B?MXR2WWZsUlFCM2JyMmJwZ2FDTGdIY2ZicjZkOU5VK0l6Nnc1OGZuSWpIUE0x?=
 =?utf-8?B?bmlEc000bjZFZUovRGVlcXRMVWhwazhUTTBEdk5RSVU4N25uWTYvZXYwcS80?=
 =?utf-8?B?TTI4Y0JlSVFwa21sNDBNaGM3MSt6YytIMjlJQm9oSEdkd0hDam1zQWd1Rm9D?=
 =?utf-8?B?YXhBNU42Ym51cEVERlhTN004MDVmNFZMNllFQWVGOEZhbXd1KytndnpRWDNq?=
 =?utf-8?B?c3g1RXp3WHdvVjc1bGZrSG0yK0FoVjNLRzBUeG9QMitPMzhIdnNxU0o5cWpT?=
 =?utf-8?B?cTNUQzRqSmJwblM1Q2dLcmplZzZ4RERwOGMxQXZrRVdDb0d4c1F4YlZ0b21W?=
 =?utf-8?B?b0VUbTFJcVZraWtHdHJWeVJUK0U3MUpKcUdwazUwNXB4WmkzQzZHY2pXTk9o?=
 =?utf-8?B?QlZVeGhvWkYyRkoyUE51QUNSbFdmWlBrS09hT3o2dG1rdVd4eDFlSUFKdEw4?=
 =?utf-8?B?VVN6c25BcEJyYldxNWowdzRrYllaNENQRFVONmZESTV0SlM3WFFmbHNMZDRy?=
 =?utf-8?B?ZnpuL2pueDlIRWpwZlE3VkxaQk1uV0pZVUxEbTdqOU9zNk4xdWpYTjh3Q2VU?=
 =?utf-8?B?azhIUHdXS1RGTml4RlIzSk5oTXNkdlhnUTcxUWZmbWR1OHhhVzc4T3hLMzVG?=
 =?utf-8?B?eEgzOHJvN1c2S0gwNTM1SWp5ekErdy9sSE1wbUI4MlZQQjJpNSt1R0JxSHlv?=
 =?utf-8?B?YmJhNkw5V1hwQWZhZmNzNjFvWTdNU2J0VlZoODhkbjdKNVp0WWkwaXpMcmdy?=
 =?utf-8?B?cFdGZVB2a0JTakEzKy9Nb25MUlNwd0Y2bmlsNEhVNU03WTZtam5YM0Z2Zm1o?=
 =?utf-8?B?czYvRHRkTk5paDNjL213ZlloNVdLRXhCSW9KRTJWTDNGT25sVkhiSGJzZnpt?=
 =?utf-8?B?UHQya1IvLzdqN1BXRW9RWk5pT3AvelJUcGF5N3VkQkc4TjFGbkpOcmppYmdO?=
 =?utf-8?B?UW1TM1VnMXBGVFpPNjVONGp2cmlXMmwzTmNBamtRQU9FMVRieFJZcnZpTzRM?=
 =?utf-8?B?SUwvdWtnRXJkNkhnYndJVTVLNkRUMGV4MEtCZW93VVgwZ2c3SkZJWUIvOTBl?=
 =?utf-8?B?NnhsN3hnUkgzMUNPaHM0dHRWSjE4ZEp5RUVnbjByVFI5MVZqbHhaemhZVDJW?=
 =?utf-8?B?Z3hTcENsdThITTkzMTc1TU5MajgxQS9TNGJvR0pqRjIrYXBnTjk2UEV3cnNr?=
 =?utf-8?B?d0loei9uYTBKMktsL1BEem5WbVZDMlB1REoxZnBxUHVEZkU2ZXZNcEJFbnEr?=
 =?utf-8?B?MHA0N3N6QTh3Z1Vab3F5WU1ERytIdmIrOWJMRkNOUUVyNkUxWllyMTJHMi9R?=
 =?utf-8?B?amJMZ3pmL2lWNEFuRGEwaUMxdEJDNUpTdEhKOTVweDF6L3ErYXpnSkFRSy95?=
 =?utf-8?B?OW45elJkY21oSGg3MmszQVp1czZyQ1J2QU1CRVdKK0tvZ0QvVEtneTBOQWcz?=
 =?utf-8?B?UXVhSzA1MHpQTEp2TTRDdDZnYkpOMHZVUlB0VS9XTzkrS3BpVWM2SkdpVWVt?=
 =?utf-8?B?YTRrSytFdEhUbDFhU0JlYjNSUXpVeWtBeXpLT2xmd3R3U3pEejVRb0haL0FM?=
 =?utf-8?B?bEprYUhTN3FYSDZtdFo0WkM2aUdyNmlyWjJpdGZRT0NsRURzZVhnS1lWc2ZM?=
 =?utf-8?B?SVFmbEZXbURmYXNNWmE2Z0tWMk5uZkFtbnZ4bEMxODBIQnl4c2lLa1BLUFpC?=
 =?utf-8?B?UU9XSUhKK055L01zOTVQamphdEo0WmhDUVh5YW5xTnVERXE0a2NpTkdaU2hy?=
 =?utf-8?B?WWN5VXhkL3IrNnFDS0JLdzZJcG53Tkl0eGJsNlNyUEtnWVRta0ZDbFpQTU5T?=
 =?utf-8?B?Sll1bWdQazBFcWZoVzBFUHNaaFU0amdaYXV5THIybnBuNkVGZGl4Q05FdGwz?=
 =?utf-8?B?dHcwOEF0VVRDVlZkdDkzNlBWelg4M3k2dkZ2eFhyMFF4aXBaekxBaFR3amhH?=
 =?utf-8?B?dUN0NnNGVzl1aThxT3pEQVVUTUtDNlVqcFlTM3NlT2RHcnFGckpnZG5qL3dx?=
 =?utf-8?Q?hDZs=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NktVT1ZzRGNFUEJ4RjRQdnhXQVdsd1NlTTBDTjlVS3FMNE9GNUhEdVBGd0VE?=
 =?utf-8?B?N0ZMK3dHeUNqVW1hVkJ4VHEvYmp6NGYycHNRUXNkd3NzdzVYMkVZTWhBRWNS?=
 =?utf-8?B?ZlZsZjRnZy9sYk9IUHdOb2dqU3ZlTFl4YmYrdDVSR3I3NVFXeGdHS1ZTQU15?=
 =?utf-8?B?K3FNdXJMb0JGblNJcThRZFgxY2h0UzQrMzNxTTd0MHFZc25ncFZlamtiMXh0?=
 =?utf-8?B?TXNtR2FWOWdHdFAxMUhTWUYzb1BGYTJjT0ZIaENmS2JFVkQzclBBUVBaUGFR?=
 =?utf-8?B?UUZIQ1VvOTRRZUE0eFpiVHJqZEhQRTkrS3U1QU1ZV2RsdDBkNCtqenl2cE4z?=
 =?utf-8?B?REQwbWwxaEkyLzZXQ3RvdWlFZFV6NmZtekxQUUxXZ01FZ2pmSEZncGZCQ1FR?=
 =?utf-8?B?UklDcWhHaHg2cmhIWHV1TmRKRlNYcWRmT0xJWGVRd1AwZmVHUFRhTU5LTGRD?=
 =?utf-8?B?MDQ0dWVBdnBSaFdWUEpuVVBWVW1VNGFDMG1Rekd3TENZT2dsc25HQysyMWdC?=
 =?utf-8?B?dlBsdzJxTE1jTkIrRGhDVTZVbTNON2NoKysxazJXZXVqSW9VcG9UZ05KRTRt?=
 =?utf-8?B?TlZGQ3J0bUIwSTRCN3hUejhKVHY0aXpxQUFxczVUcU14RGtianZKWm43azk1?=
 =?utf-8?B?N3hJSWdGa1puTXN2Vzk0Qkw3TVQyanlUSENRbWlMNUNTRW80RVVZRGI0SDNY?=
 =?utf-8?B?ejcrNldUbzJNSmVoTjd5c3orQ0x1dTVrVFg3bms3QjdaOWFYYzNUelVqc3dp?=
 =?utf-8?B?NXp1S29qWDkrTHliWFFTdDI4em5BZTZzOUhCbzhyc2YwZTJSRmtXSnhWd0Qr?=
 =?utf-8?B?WmdLSWNVVWtkSjJ1NjZvMHdMN1FBMUl3TkYrSHI5WlRZNmpXZzZDSHpwZjVQ?=
 =?utf-8?B?MGg1ZWFEc3NzcFRGckRublZGaE1wY2tyNDl0WWthWGFXNkFQK3gzUThxelVr?=
 =?utf-8?B?c2lTK0lvaUx5ckVFQ3NOYjA3Rlp6MTBhMEQwMS8wdmhsaWZkRFMwVzNZdHhM?=
 =?utf-8?B?YTBTUm5ydXV2aklQeGNZQTFHeHFDWTk3M3dlclhQNFoxT05hWXJaTWFrMDVB?=
 =?utf-8?B?T00xRktGOXZFemhXejI2WUJMYWYwRFF3bVpYSm1haGFaZ0ZyaEVMMEdzZ0Ix?=
 =?utf-8?B?SVd3OFpqaTQrUk9YWXpxcUJKVWd2TTg4WnFPOEFiOW95VGhjVTVvU0syakhH?=
 =?utf-8?B?YTFydkdCNE9kbXdCSWlUNXJiZ3FRMzRSU3hDTU1VUUdnbGd6SG1FdlhiZEhn?=
 =?utf-8?B?ODBialR5SFErTTVPUTd6VlFnR2NKMVFjOVFrWldTNndFSkx0WC9yYklHZ3BQ?=
 =?utf-8?B?RGhkL1hmNFBUSmtBQ0RrRmVwcUF2d3pUOHlwaExXZ3FGWDNVOGt2VHZ5ajVD?=
 =?utf-8?B?bWpNUUhQMmtXL2dsSEZ4M1ppWGE1UnNNM0poY3dqenZsckQ5azNyREJSOFlQ?=
 =?utf-8?B?VisxUFd3bC9oSEZXejVuY08yUHdSRjJXQmRrTklSVnZPckJLbFpxMDF1M0pl?=
 =?utf-8?B?RnIvS3hsYWlOQ2V2M2NJU2Zqc0tCUjdiU01DSlFQSHdFbG8zOGt5WXdMYStk?=
 =?utf-8?B?QkhpZ2tJQ2w4L2VpQ3FNakpXRTVJM3FIRktsTDhML1lWNjYxSk9iMCtleSta?=
 =?utf-8?B?anM5RUNYSEJMZHJxeThlNjZIYlMvQXJleXlLVXVkOENIUmxUcit4K1JHWUNa?=
 =?utf-8?B?amUxZ1F6K0hYRWM4VitVV1hPejdpT1gydWdsRGJxZmNNSHVQK0FJNDZMS3g3?=
 =?utf-8?B?ZjJxSjFzVWcwMk5hR1lBOGVVWmdZNXNlVnFpZXh6Ry9BbzBVWkJpRnBWMUVl?=
 =?utf-8?B?YzRJRmlYVmpyRWNsTWoxSmUvem5YRXJ6bWlKbUY1VFl6a0NLMzUvZDhxT2RY?=
 =?utf-8?B?QWt5SnNLTFlmV0tiQi9lRkRxRW9nWlBRWGR4OEZPLzRlUzkzWm92SU1WUS9T?=
 =?utf-8?B?TTNBZEFGUEFEakVSb3Z3aEVRc05xbGthdnFLcWR3QWpyOFZ0UDB5RmdWTkxw?=
 =?utf-8?B?VXhSTjV0YVVWa0x3ZXRmanZQWDY3d0lmQ0xkT3R2M3hZOXN0MFBkaE8rUnN6?=
 =?utf-8?B?NjV3Vk42cXdnZm9MNVFrdFNSU2I3STloV2xsL0hPR1I4d2VrVXFXVTgzYlpt?=
 =?utf-8?B?UEoxMHFuL0dCenp3QmFzbXVleFR3SmdnRkx2ZXJOaG9zV2lUakZ6cHAzZThN?=
 =?utf-8?B?cHBWWGRkRlR3eWtBeTRhTHNybFBOR0daQWE4eXBjS3Zic2NkNXNBamVWSUkv?=
 =?utf-8?B?c1hHWnluY0RIZGR1bHhHL24rNmZFd1AyamJTc3JaTC9UQVJvazhBSForeUZK?=
 =?utf-8?B?dnZOYkdKc1JYZ0pIbGRId2NBUGs1OU0rbnVEUmEya3NHSEZlMVlRdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d8110d9-3784-44e4-ce8b-08de5450129d
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 16:06:42.0952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vZPHh4xy5KtX3JiNLYJUQ9WcZcMFlE2wZJOwPWnLZ6/a5f5ugBM9/mRZIEZzZQ+X9a6P+bAbHFFYb7G7pmJIIE0Bj7D4UhflQ3pxabukreM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7052
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 16:06:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18785

Hi Robert,

On 1/15/26 4:52 PM, Robert P. J. Day via lists.openembedded.org wrote:
> 
> /home/rpjday/oe/layers/bitbake/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst:947:
> WARNING: undefined label: '_ref-bbsetup-source-overrides' [ref.ref]
> 

Remove the leading underscore at the specified line.

Can you send a patch please?

Thanks!
Quentin

