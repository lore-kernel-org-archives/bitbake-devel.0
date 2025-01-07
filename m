Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC6BE77198
	for <webhook@archiver.kernel.org>; Tue,  7 Jan 2025 17:46:20 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.115])
 by mx.groups.io with SMTP id smtpd.web11.27005.1736271970994636304
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Jan 2025 09:46:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@weidmueller.com header.s=selector2 header.b=COunA2no;
 spf=pass (domain: weidmueller.com, ip: 40.107.241.115, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dsooT+dMONuA9QQ1s6vgKZ1Lc9RkeDdf/G86JCPT8VLIKDmh3XrKQQK0aUxiZQFJLVbErjYQldVd6niwDOdnGFN7bkZuPMcTrJyIGGoxjmTlE8Unvz4wMjzqZj0nysz1pqepqFCKkekdaFF6f8c6MW2Jw3VMuTU/zfdNfAdBwOoxzv0+5Vs76lxuecoboYdjYFwKIFta4uysqGuQMTenz3ZAtHmV5Q3XKxV69RzW+fGef46ZwnzFXZlSzXHaA6vI3HWLM551EqJlWQHENLA0sx5nzhsEeMhpwUFMmrLiaaMbBjk5SymqjDggz6tfSU/ZyYpFnFj9g2WRWMtBgRTudQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cpH5gAWVBHqdWXBAahchbMC9rjnG2gxn/1yYoynRYg=;
 b=pTxy08D8J0b28364hPb6KmStz73xALB44ra5j4WdEdkSPj833GEQa4iHELZAV+c1MFcxtW/HqAO7j27Iddass48XzJy1A4iOom/OQk+c0X+jv9iGsfU1UK0cXHU8g0IlF/QW8JF1FCCultu2wf/RM+lt+PGjxFHiugKKgVqEhbrB4izyzH7ayLDr5nz7oWIhwJgMNKNchG63BH0D5ltT7tuuI9CRCtewE7PWyNSE6uFFjhcUvOl32wayUY6IdkEEPfJZpex47+g/DYuRN+87AzUk7TG9x81+pSo9gTpSBENC9Zb5dvdBmWZJQfrc17jxpLEVk8ZZQLTa7D13am5HWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cpH5gAWVBHqdWXBAahchbMC9rjnG2gxn/1yYoynRYg=;
 b=COunA2noFlo2dwJzsf87EcWasdBol6ieIPKjN3dSw+xELXoYJD/NSw0EYEo30HMJjjfTx84p7jPBQt4wdEyrxEbvmH0aDbaFpDnQNm+ahTkzr116OndlC8L+IH4B600v7Zo8YC+LJhdIdi3m3yy5QKg2fDiA4zNSssZbYmbipL7ZuV6yyE9bLsK6QwaqEozfGNg/ziIQ1sz8yxohJp5pNU+bT3ulTokaaXGgoTkRLowb7Tvp5TiCjeJD7AinrMHFz7CWlxL58kuvk9GGkORqtQQy0HkWTDPXOETK69xXE0lgPLRV5wZ0HAxKR4n14Lvz6AosynAqZRtdglXeCm2qiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by AS1PR08MB7402.eurprd08.prod.outlook.com (2603:10a6:20b:4c6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 17:46:05 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 17:46:05 +0000
Content-Type: multipart/alternative;
 boundary="------------wodhpeHAXX8YU20xH0bPJdVT"
Message-ID: <1262cb51-e7fd-4f3b-b55a-16675d3d172c@weidmueller.com>
Date: Tue, 7 Jan 2025 18:46:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [RFC PATCH 00/21] Concept for tightly coupled
 package manager (Node.js, Go, Rust)
To: Bruce Ashfield <bruce.ashfield@gmail.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
References: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <00e379e761414e8cf07b83544d5202211bf4623c.camel@linuxfoundation.org>
 <578ed107-1a04-48db-ac2e-1dc9cdab60d0@weidmueller.com>
 <84c9eee86cd0a378dcfbcbcac297d3a24f2424ad.camel@linuxfoundation.org>
 <2a8d0393-800c-40b3-86fb-a5ab5e6f52f9@weidmueller.com>
 <bcd35f1d1c60c1d96f9dac36b0284186e57b598c.camel@linuxfoundation.org>
 <bb35634c-b725-4f6f-a0bb-9b10d43f2c6e@weidmueller.com>
 <CADkTA4OqeMu9sv2VohLHj3VJ_b96147K6NiGp4gicSb0SrBi1A@mail.gmail.com>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <CADkTA4OqeMu9sv2VohLHj3VJ_b96147K6NiGp4gicSb0SrBi1A@mail.gmail.com>
X-ClientProxiedBy: FR4P281CA0249.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::19) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|AS1PR08MB7402:EE_
X-MS-Office365-Filtering-Correlation-Id: ee78dd79-5ecf-48bd-45c7-08dd2f4328ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|4022899009|376014|1800799024|366016|8096899003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MGw4clBIb21pS3JTOGtkQU1yalEyVDZVay9mUDVVbXRadE9JVTNCMVRFQ0tX?=
 =?utf-8?B?K242VjkxTVZYcGVnU0dPYUUwNGJ6YjZ3clN1eXV2VnJzUUhEQjNSZU5TeVFt?=
 =?utf-8?B?WDV3SkFQYm9QekxFajFiekxXc3prSEg5blJsWXlNQUVMWEE4Kzd3Wm8vSXFz?=
 =?utf-8?B?YVFhZ01VY3V0SjJRREhBcXZiY2RqSHYwQWlhZWMxUlQ3RTlVNXNHcGxNdnM0?=
 =?utf-8?B?WlFPeUVvMk9MR1hEZ0RONDVFS1phODVHQjIyK1pXVHRGcHVOZmtWTGErc2I2?=
 =?utf-8?B?c2xzd2Nwc25KZFN3SzZESG1paWtSZCtjTlZ5RnByTXNjMU93SlZ3SjlTTzBr?=
 =?utf-8?B?NjkxdXZuOHFTUTQ5ZnZ0alVBWmpaYTBqTWhvMHJacUJnK1dOTkU2WHFtZE5l?=
 =?utf-8?B?QTRqY3ZvZFUwNFJiVERvbXV1a3F2VjJOMDBuUkxUcVJFK0VOSiszUkIvSXgw?=
 =?utf-8?B?SkpHc1BZNndtMUZoOXdPWWMwam5NTmZyWmNFMlYxYWYrNVpLOEVSaU96NXpv?=
 =?utf-8?B?UEZSVE1FWVUrNUxrbkNrYWhlN29YV09WaVUxbHZHZ1ozc01lbm5hMUl1SExY?=
 =?utf-8?B?OGJ3Z2xSOXY4SFRSVWdZTHRDUTdvZDVZd2xGcUV1TExrWjFjVUJQWi9USnRZ?=
 =?utf-8?B?YlcxQnpDenJEUmhCV1AwNGhLb2IvS2dLVUZPY01SRkZ5NjlWNWVWY3ZwZFNU?=
 =?utf-8?B?OXVjY3NrNnc2TDhpOHViTkg2UzdPSXdyVXRSN082QzgxQTN4amIwMlN6M3BE?=
 =?utf-8?B?alJ5VFV3SFZPQWMvamVyY2R5Zy9wNjdqS1JjU0c0TW5WejBjR0VKbk5pa3Z3?=
 =?utf-8?B?VXhIcmhVczhDTTl0eUpiMUhRNjZ6b2IwYVNiTTZFL1I3YUNmcGM3WFBRZE1M?=
 =?utf-8?B?RlhkUmlZbnhnM0lZNUFBL2dlbW5RY3pvSWFHVmZDWUFHYm05WGVCb3JkR3d4?=
 =?utf-8?B?M1BkZjlGVXI0N1FJU1hOMklHbjlTNTVlLzdnTHRkd29GeVpVaGpBYmpsc1Q1?=
 =?utf-8?B?Myt3bzU3UmdWc0dDRmhzSmo0S3dpajFiZnVmS1IrTTdDUllxSUppcUNxK2F4?=
 =?utf-8?B?N2pKQlJsbEN4ampZQlVSUld4U3hjOTJWdkVVQ05GTjBqS3ZobnBtR1k5Qk0x?=
 =?utf-8?B?R3N4cktvV1p0Ym1QaC9kb3p1dGc2WVRKVS9nSEtPcTQvb3IweFZQUHdDUi8r?=
 =?utf-8?B?eTJ6OU1SVU5CS0xYdFdCR2ZRVFRVeXF0bXp1K0lnVmliT3FENTk5ZUM0VUE1?=
 =?utf-8?B?L0JWL0FmM0xFK0lBdjVjU3d6djhlRVdDZjhYbU4yVU1UZGMwNXFyMldiQUZV?=
 =?utf-8?B?RWREQ21WdjJNWnhnSm93cnhZcnhlR1RMT1ZNTzBnMU9HSVQrUUZUUmZzWC9G?=
 =?utf-8?B?bkk5QzV3bmpjeUEwV2hyTFdXWStzdkE3NHJOc1BYVENVRFFXakxFWnExS1RE?=
 =?utf-8?B?c3FZNytlQjVBY2xEcUQ3NVRETEkwMFB1NnlCRHpZUE5xS0NjdkFsTnhqN2FL?=
 =?utf-8?B?VzlEZjFoRDRlMkpXa3Z6SGxaZUdQMjFuQ0w5RTBsZEFYMHZtU1RTQVVGeFdj?=
 =?utf-8?B?WjY0ZmVyc2pIWjhmQTZwMW1PdGc1OUNBUVFWdkJDVXRvSTBmcWpKcWFOQy80?=
 =?utf-8?B?WHF1cWF2UGVXazFFWGFPM29JNmJTMkFvc0loZ0hlZGcreCtIUm1UdW1sQTZk?=
 =?utf-8?B?ZnZmdzYrU21OVWd3RGZKbGpFcUZ0ZEJ1L3h6SnNiUU4wc3ZKaWdwejMyemh0?=
 =?utf-8?B?R3hYS0NjRDBRN0xySk5QeGR4Mnc1akdMUU5GUUV3Nm84ZkxCZU5Lb1NyekZu?=
 =?utf-8?B?cWh3NDhjV2U5SXpSTXVIUT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(376014)(1800799024)(366016)(8096899003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VkxFVlhMeXBJWHV3aGlzQnlldEN1RkJ5aXh4QW1XM1NSMHJmK0JIb2hDK0hW?=
 =?utf-8?B?UlRrNGFOZVdCcm56WlM5MlVwWWpJVmFnNjFOTEZHaGg1czVEZFVmakRlTnQw?=
 =?utf-8?B?dWpmek9ndGs2UVRoOXo2Q2lERFo0bGFtcnliazMyMzV5SHdlUFRzVkczL3o1?=
 =?utf-8?B?MWNsVzRXTUFUSWIwUFJuWkdIVlJXM0pocnROcHIzMnZnblZ6a2ZmNDBwR0I1?=
 =?utf-8?B?ZTRWRnV0S2tOc2x1aVhEbWJzQS9kcFFZTzV2d1Brd0JkMm1VbWxkUkpLd25C?=
 =?utf-8?B?TFhKSFBBR0J2WlBWYUhCWFpnYnQ0NDRScmFyWW1VUUtHSVM4c3h2cTVvQ2RT?=
 =?utf-8?B?VzlkS0gxY0w0TkJjSXpPWFNnRXlKNEJEb0hyY21DUGp4VjIzQmFlZ1ZkZ3dR?=
 =?utf-8?B?RnBoTDE5R2MxbUxLRkJHMEZTUE81akZkMEtTakJwNnlzbkNjLy9uRDV0M1Rx?=
 =?utf-8?B?eGxVWFZYa2lTME5GbzVZSDBtaDVQUStMa1RWVGxuMUFJVVNHT2hRVVZIOGhC?=
 =?utf-8?B?TVRnRk1oMVFGMzhRN25uOG1aclBWTnZKU0I4WGlYKzF5TElmOE50ZmxUcmF4?=
 =?utf-8?B?TDFIeTkraUIvc3ZRT2lSNE5Cdy9aVmYzd0xHNXM4eTRFNVpWNmZsbVk0UUc0?=
 =?utf-8?B?K2JNZVpFdDJ3RnpvY1lYb3UvZVI2MjZsemQ4V05lMGVVcVh1OG96NTgzOFVJ?=
 =?utf-8?B?aUc3L1Jvck04aUt6RlFwbThDTTA3OStkZUtoVWRnUjZqUFR6RGRFeTV4OGJs?=
 =?utf-8?B?Z1Zxbys5ajBYZ2hmcDZTakJIOGRtWHIwalBhM2ZyRkZjOVA0WnUwbENqcENu?=
 =?utf-8?B?RUQrSU5kZy9acXhnVXNOYTlHSHBBUnppbnNXSGUrRjF2RVpWT1NIcDlBS3Mz?=
 =?utf-8?B?Zll5RnRnWmFsWHMvK3FnVTBYeFA4YVdTM2ZZNFZBR2NtbVhCRUNxOWJMMmRG?=
 =?utf-8?B?T3p3Wm92eStFSjYrVjlzdlgxdHZCS3VRWXY3Q0lqN1lraWRvanNGSENZVHd6?=
 =?utf-8?B?ZmdLYlUrK3k4YXJ2MzN0cjQ1TWw3RmlIWlhjdDZ6eFRqb3h2MXlabzVqWThi?=
 =?utf-8?B?RXp1TnZtV1FjZVJmNzZGdkt2MTBOT3J1OG93UUtvSmMvN3FkZ3BmeXd5WlAv?=
 =?utf-8?B?aURKcWJzTkZWT09yR2NQMXRIN2tiYXZGT1RHQlF4ZUN1bnZFeTVoMVJpSm5X?=
 =?utf-8?B?R25QeWFDUkcrbkVzUlRQdGRWYUc1dHFPOTRURHNSV2xrTUVTNU5heHNaZWJs?=
 =?utf-8?B?dTVoaENtZzY4cnlPUEU2Z1Urc0VDRVlmNVBRb0I5Zm1jVVhxczRtbCt0YlVs?=
 =?utf-8?B?NmJlOTl0NitXam1KZnpsbWpCT1ZuRlRJaG9LeFBydkNHUnFMRHJRTUN1d2d1?=
 =?utf-8?B?L2EyRTRMREpMQWJSMytBejJadzBqVUc5VmZRdDFLUmF2QWtoUkNsaTlQalYz?=
 =?utf-8?B?UytCTkxnNFB1RGx4VFdXSlB0dXlrdDVuY29nK0tFZ0ZJNkNiRmxyV0lnK2Vr?=
 =?utf-8?B?WEdvMEdmNTN1dDVCa1oxcSthQzJQYkNUVlZMRjZocngxZWVJYUUwMi9NalFy?=
 =?utf-8?B?SE9JL1RFUWViaW02U0tHTjVxblRxWjY2NzBMMHY5emMzZDNrZjdET1NpSzdB?=
 =?utf-8?B?Wk9iRjFuUjkwVXp5OE5scjlPTVVCKzIyQlFBRFhVQVlVUnFGa0FjWU16aWpt?=
 =?utf-8?B?RnlDV1IrVjNybk9FSFFNQXRCYzF1YllSYmJPaHNRcXl1b0FodVFTRksyL29E?=
 =?utf-8?B?aDhtWkJ5U2tIZk50S2pMTXJoSUVnTzZwSFJtQ0F5RkU4QVRCK3gwQVJNQmE5?=
 =?utf-8?B?YWZ3Q1JVdEJ4TW1IZDBXMVlmRzNTUVpMQ09JYitaK2o1OGc2SWRWZDV0d0FC?=
 =?utf-8?B?S3AxZSt4TktLRE1LeVdOMi9lNkt1YlJFWnkxMUM1ancxMDRaZ0YrWXo5ZWo1?=
 =?utf-8?B?UFN4N1VqaE5UaUpVbUtpT2tROSt2bTJ5c1JLanJLS3dMUUNiMnc0S1YrTFRJ?=
 =?utf-8?B?cjRBZFRoWUxUbVJpbWl6cHdXZ1JzWnpxL3BJOXNncXYzTFRWZzJ2RjFFVzJr?=
 =?utf-8?B?ZW50dkxUK3VXakJxMm50NE5VcGtvTUFvalIzS01zZEMxRWFqMEdKS0phTFpP?=
 =?utf-8?B?cXpMRkViM29qOHRFVHlGVUJNbkhNY2lpZStlN1lhT29Fd1U0NFhvb1d3VFY1?=
 =?utf-8?B?V0E9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee78dd79-5ecf-48bd-45c7-08dd2f4328ec
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 17:46:05.4089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lh0wo1jJ+uxkJdRw7bNEpECcK2SkjepY04z11D0AE/mVj8wtRNEKrePP9Pq9kEjY9X7cnwFC3DZIRw7CFp5RoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7402
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Jan 2025 17:46:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16983

--------------wodhpeHAXX8YU20xH0bPJdVT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 07.01.2025 um 17:58 schrieb Bruce Ashfield:
> Hi all,
>
> I'm going to reply at this point in the thread to at least let 
> everyone know that I've been reading along, but honestly can't say if 
> a few questions that I have have been asked (and answered).
>
> The biggest use case that I have for the layers and recipes that I 
> maintain is about being able to both "easily" patch or update 
> vendor/dependencies of the main application build.
>
> It was unclear to me how I'd do that with these changes.
>
> For the copied/extracted dependencies, I can see that you'd just be 
> able to figure out where they were extracted (and I see the 
> discussions on where to extract/store some of the files) and then 
> write a patch as you would with any recipe. But would there be a way 
> to patch the dependency "lock file" ? I definitely don't see a way 
> that I'd be able to tweak a source hash and have an updated dependency 
> pulled in .. but I could have easily missed that.

You have to provide your own "lock file" and place it beside the recipe. 
The "lock file" is fetched via the file fetcher and is used to fetch the 
dependencies.

> Those are the primary reasons why I'll stay with explicitly listed / 
> visible dependencies, unless something similar is available in a 
> re-worked / unified fetcher.

It is impossible to patch the sources inside bitbake. Therefore the 
dependency resolution must be moved inside a dependency fetch task and 
an additional dependency patch task need to be added.

> I prefer the translation to git, so I have debug source for vendor 
> dependencies as well as a well travelled path to mirror and archive 
> the source

Do you reference to the go-vendor implementation? Do you mean the vendor 
directory? The gomod fetcher should support mirror and archive the 
sources. It should be possible to create a vendor folder from the gomod 
archives.

> , but something like the update task of rust is at least explicit and 
> visible to me, so I can also use it without too many issues.

Do you mean `bitbake -c update_crates recipe-name`?

Regards
   Stefan

> On Tue, Jan 7, 2025 at 11:13 AM Stefan Herbrechtsmeier via 
> lists.openembedded.org <http://lists.openembedded.org> 
> <stefan.herbrechtsmeier-oss=weidmueller.com@lists.openembedded.org> wrote:
>
>     Am 07.01.2025 um 12:01 schrieb Richard Purdie:
>>     On Tue, 2025-01-07 at 10:47 +0100, Stefan Herbrechtsmeier wrote:
>>>     Am 06.01.2025 um 16:30 schrieb Richard Purdie:
>>>>     On Mon, 2025-01-06 at 15:35 +0100, Stefan Herbrechtsmeier wrote:
>>>>>>       I'm a little bit worried about how easily you could sneak a
>>>>>>     "floating" version into this and make the fetcher non-
>>>>>>     deterministic. Does (or could?) the code detect and error on
>>>>>>     that?
>>>>>>        
>>>>>     We could raise an error if a checksum is missing in the
>>>>>     dependency specification file or make the checksum mandatory for
>>>>>     the dependency fetcher.  Furthermore we could inspect the
>>>>>     dependency URLs to detect a misuse of the file like a latest
>>>>>     string for the version.
>>>>>       
>>>>     I think adding such an error would be a requirement for merging
>>>>     this.
>>>>        
>>>     Should the dependency fetcher (ex. npmsw) or the language specific
>>>     fetcher (ex. npm) fail if the version points to a latest version?
>>     I think right now it has to error to try and reduce complexity. It is
>>     possible to support such things but you have to pass that version
>>     information back up the stack so that PV represents the different
>>     versions and that is a new level of complexity.
>>
>>     I guess we should consider how you could theoretically support it as
>>     that might influence the design. With multiple git repos in SRC_URI for
>>     example, we end up adding multiple shortened shas to construct a PV so
>>     that if any change, PV changes. We also have to add an incrementing
>>     integer so that on opkg/dpkg/rpm operations work and versions sort.
>
>     Okay. In this case we should add the checks to the dependency
>     resolution. Thereby we prohibit dynamic versions for the
>     dependencies and allows users to add support for it to the fetcher
>     of the package manager.
>
>>>>>>     Put another way, could one of these SRC_URIs map to multiple
>>>>>>     different combinations of underlying component versions?
>>>>>     If you mean the extracted SRC_URI for a single dependency from
>>>>>     the dependency specification file (ex. npm-shrinkwrap.json) it
>>>>>     could use special URLs to map to the latest version. But this is
>>>>>     a missus of the dependency specification file and could be
>>>>>     detected. The tools generate files with fixed versions always
>>>>>     because a floating version with a fixed checksum make no senses.
>>>>     Even if it shouldn't happen, we need to detect and error for this
>>>>     case as it would become very problematic for us.
>>>>
>>>     Okay. Should we disallow a dynamic version for package manager
>>>     downloads generally or do you see a reasonable use case?
>>     See above.
>>
>>>>>       I also thought it would make sense to generate recipes from the
>>>>>     dependency specification files and therefore worked on the
>>>>>     recipetool
>>>>>     previous. But it looks like the tool isn't really used and I'm
>>>>>     afraid
>>>>>     nobody will use the recipe to fix dependencies. In most cases it
>>>>>     is
>>>>>     easy to update a dependency in the native tooling and only
>>>>>     provide an
>>>>>     updated dependency specification file.
>>>>>       
>>>>       
>>>>     I think people have wanted a single simple command to translate the
>>>>     specification file into our recipe format to update the recipe. For
>>>>     various reasons people didn't seem to find the recipetool approach
>>>>     was working and created the task workflow based one. There are pros
>>>>     and cons to both and I don't have a strong preference. I would like
>>>>     to see something which makes it clear to users what is going on
>>>>     though and is simple to use.
>>>>
>>>>     People do intuitively understand a .inc file with a list of urls in
>>>>     it. There are challenges in updating it.
>>>>
>>>>     This other approach is not as intuitive as everything is abstracted
>>>>     out of sight.
>>>>
>>>>     One thing for example which worries me is how are the license
>>>>     fields in the recipe going to be updated?
>>>>
>>>>     Currently, if we teach the class, it can set LICENSE variables
>>>>     appropriately. With the new approach, you don't know the licenses
>>>>     until
>>>>     after unpack has run. Yes it can write it into the SPDX, but it
>>>>     won't
>>>>     work for something like the layer index or forms of analysis which
>>>>     don't build things.
>>>>
>>>>     This does also extend to vulnerability analysis since we can't know
>>>>     what is in a given recipe without actually unpacking it. For
>>>>     example we
>>>>     could know crate XXX at version YYY has a CVE but we can't tell if
>>>>     a
>>>>     recipe uses that crate until after do_unpack, or at least not
>>>>     without
>>>>     expandurl.
>>>>       
>>>       
>>>     The main question is if the meta data should contain all information.
>>>     If yes, we shouldn't allow any fetcher which requires an external
>>>     source. This should include the gitsm fetcher and we should replace
>>>     the single SRC_URI with multiple git SRC_URIs.
>>     If we had tooling that supported that well we could certainly consider
>>     it. It isn't straight forward as you can have a git repo containing
>>     submodules which then themselves contain submodules which can then
>>     contain more levels of submodules. There are therefore multiple levels
>>     of expansion possible.
>
>     Okay. That makes the git submodule special in compare to the other
>     dependency fetcher.
>
>>>     We can go even further and forbid specific package manager fetchers
>>>     and use plain https or git SRC_URIs. The python and go-vendor fetcher
>>>     use this approach.
>>>       
>>>       Alternative we allow dependency fetchers and require that the meta
>>>     data be always used via bitbake. In this case we could extend the
>>>     meta data via the fetcher.
>>>       
>>>       In both cases it is possible to produce the same meta data. It
>>>     doesn't matter if we use recipetool, devtool, bbclasses or fetcher.
>>>     In any case we could resolve the SRC_URIs, checksums or srcrev from a
>>>     file. The license information could be fetched from the package
>>>     repositories without integrity checks or could be extracted from the
>>>     individual package description file inside the downloaded sources
>>>     (ex. npm). We should skip the license detection from license files
>>>     for now because they generate manual work and could be discuses
>>>     later.
>>     That was the reason the current task based approach doesn't use them,
>>     yet! I mention it just to highlight that it can be solved either way,
>>     the approach doesn't really change what we need to do. The bigger
>>     concern is having information available in the metadata which I think
>>     we need do to some level regardless of which approach we choose.
>>
>>>     The recipe approach has the advantage that it uses fixed licenses and
>>>     that license changes could be (theoretical) reviewed during recipe
>>>     update.
>>     FWIW that is an important use case and one of our general strengths. We
>>     can only do that as the license information is written in recipes and
>>     can be compared at update time.
>
>     Does this apply to the license of the every individual dependency
>     or only to the combined license?
>
>>>     In contrast the fetcher approach reduces the update procedure to a
>>>     simple file rename or SRCREV update (ex. gitsm). Furthermore, the
>>>     user could simply place a file beside the recipe to update the
>>>     dependencies. Could we realize the same via devtool integration and a
>>>     patch?
>>     This is effectively what the task based approach is aiming for
>>     currently. I think the idea was that we could have devtool/recipetool
>>     integration around that update task, a task was just a convenient way
>>     to capture the code to do it and get things working without needing the
>>     tool to be finished.
>     What is the task based approach? `bitbake -c update xyz`?
>
>>>       We have different solutions between the languages (ex. npmsw vs
>>>     crate vs pypi) and even inside the languages (ex. go-vendor vs
>>>     gomod). I would like to unify the dependency support. It doesn't
>>>     matter if we decide to use the bitbake fetcher or a bitbake / devtool
>>>     command for the dependency and license resolution.
>>     I do very much prefer having one good way of doing things rather than
>>     multiple ways of doing things, each with a potential drawback. I'm
>>     therefore broadly in favour of doing that as long as we don't upset too
>>     much existing mindshare along the way.
>
>     Okay
>
>>>>>       
>>>>>       I have a WIP to integrate the the dependencies into the spdx .
>>>>>     This
>>>>>     uses the expanded_urldata / implicit_urldata function to add the
>>>>>     dependencies to the process list of archiver and spdx.
>>>>>       
>>>>>     https://github.com/weidmueller/poky/tree/feature/dependency-
>>>>>     fetcher
>>>>>
>>>>>     Regarding the license we could migrate the functionality from
>>>>>     recipetool into a class and detect the licenses at build time.
>>>>>     Theoretically the fetcher could fetch the license from the
>>>>>     package
>>>>>     manager repository but we have to trust the repository because we
>>>>>     have no checksum to detect changes. Maybe we could integrate
>>>>>     tools
>>>>>     like Syft or ScanCode to detect the licenses at build time. At
>>>>>     the
>>>>>     moment the best solution is to make sure that the SBOM contains
>>>>>     the
>>>>>     name and version of the dependencies and let other tools handle
>>>>>     the
>>>>>     license via SBOM for now. Therefore I propose a common scheme to
>>>>>     define the dependency name (dn) and version (dv) in the SRC_URI.
>>>>>       
>>>>       
>>>>     We could compare what licenses the package manager is showing us
>>>>     with
>>>>     what is in the recipe and error if different. There would then need
>>>>     to
>>>>     be a command to update the licenses in the recipe (in much the way
>>>>     urls
>>>>     currently get updated).
>>>>       
>>>       
>>>     Either we request the licenses from the package manager during
>>>     package update or during fetch. I wouldn't do both. Instead I would
>>>     analyze the the license file during build and compare the detected
>>>     license with the recipe or fetcher generated licenses. But the
>>>     license detection from files is an other topic and I would like to
>>>     postpone it for now.
>>     Agreed, I mention it just to highlight that supporting them does have
>>     impact on the design so any solution needs to ultimately be able to
>>     support it.
>>
>>>>>>     You're using DL_DIR for that which I
>>>>>>     suspect isn't a great idea for tmp files.
>>>>>       Take over from gitsm.
>>>>     Probably not the best fetcher and I'd say gitsm should be fixed.
>>>     I don't see a reason why the gitsm fetcher shouldn't handled like the
>>>     other dependency fetcher. We could update the handler after we have a
>>>     decision for the dependency fetchers.
>>     In principle perhaps but as mentioned above, gitsm has its own challenges.
>
>     Based on your feedback I have the feeling that a dependency
>     fetcher isn't the correct solution. The fetcher makes it
>     impossible to review changes during recipe update. Additionally it
>     needs caching for the resolved fetch and license data.
>
>     The alternative is to create an inc file with SRC_URIs, checksums,
>     SRCREVs and LICENSE. Any recommendation how to integrate the
>     dependency resolution and inc creation into oe-core?
>
>>>>>>     The url scheme is clever but also has a potential risk in that you
>>>>>>     can't really pass parameters to both the top level fetcher and the
>>>>>>     underlying one. I'm worried that is going to bite us further down
>>>>>>     the
>>>>>>     line.
>>>>>     At the moment I don't see a real problem but maybe you are right. The
>>>>>     existing language specific fetcher use fixed paths for there
>>>>>     downloads.
>>>>>       
>>>>>       What do you propose? Should the fetcher skip the unpack of the
>>>>>     source or should we introduce a sub fetcher which uses the download
>>>>>     from an other SRC_URI entry. The two entries could be linked via the
>>>>>     name parameter. This approach could be combined with your suggestion
>>>>>     above. The new fetcher will unpack a lock file from an other
>>>>>     (default) download.
>>>>       
>>>>     I'm not really sure what is best right now. I'm trying to spell out the
>>>>     pros/cons of what is going on here in the hope it encourages others to
>>>>     give feedback as well. I agree there isn't a problem right now but I
>>>>     worry there soon will be by mixing two things together like this. The
>>>>     way we handle git protocol does cause us friction with other urls
>>>>     schemes already.
>>>     The dependency fetcher could simple skip the unpack. In this case the
>>>     user needs to use a variable to pass the same URL to the git and
>>>     dependency fetcher or we could provide a python function to generate
>>>     two SRC_URI with the same base URL.
>>>
>>     I'm starting to wonder about a slightly different approach, basically
>>     an optional generated file alongside a recipe which contains "expanded"
>>     information which is effectively expensive to generate (in computation
>>     or resource like network access/process terms). We could teach bitbake
>>     a new phase of parsing where it generated them if missing. There are
>>     some other pieces of information which we know during the build process
>>     which it would be helpful to know earlier (e.g. which packages a recipe
>>     generates). I've wondered about this for a long time and the fetcher
>>     issues remind me of it again. It would be a big change with advantages
>>     and drawbacks. I think it would put more pressure on a layer maintainer
>>     as they'd have to computationally keep this up to date and it would
>>     complicate the patch workflow (who should send/regen the files?). I'm
>>     putting the idea there, I'm not saying I think we should do it, I'm
>>     just considering options.
>
>     Do you mean like a cache or like the inc files? Is the file
>     totally auto generated or is manual editing acceptable?
>
>>>       = Open questions
>>>>>>>     * Where should we download dependencies?
>>>>>>>     ** Should we use a folder per fetcher (ex. git and npm)?
>>>>>>>     ** Should we use the main folder (ex. crate)?
>>>>>>>     ** Should we translate the name into folder (ex. gomod)?
>>>>>>>     ** Should we integrate the name into the filename (ex. git)?
>>>>>>>       
>>>>>>>       
>>>>>>       
>>>>>>       
>>>>>>     DL_DIR is meant to be a complete cache of the source so it would
>>>>>>     need
>>>>>>     to be downloaded there. Given it maps to the other fetchers, the
>>>>>>     existing cache mechanisms likely work for these just fine, the open
>>>>>>     question is on whether the lock/spec files should be cached after
>>>>>>     extraction.
>>>>>       
>>>>>     You misunderstand the question. Its about the downloadfilename
>>>>>     parameter. At the moment some fetcher use sub folder inside DL_DIR
>>>>>     and others use the main folder. It looks like every fetcher has its
>>>>>     own concept to handle file collision between different fetchers. The
>>>>>     git and npm fetcher use there own folder, the crate fetcher use its
>>>>>     own .crate file prefix, the gomod fetcher translate the URL into
>>>>>     multiple folders and the git fetcher translate the URL into a single
>>>>>     folder name.
>>>>     That makes more sense. The layout is partially legacy. The wget and
>>>>     local fetchers were first and hence go directly into DL_DIR. git/svn
>>>>     were separated out into their own directories with a plan to have a
>>>>     directory per fetcher. That didn't always work out with each newer
>>>>     fetcher. Each fetcher does have to handle a unique naming of its urls
>>>>     as only the specific fetcher can know all the urls parameters and which
>>>>     ones affect the output vs which ones don't.
>>>>       
>>>       This doesn't explain why the npm but not the gomod and crate fetcher
>>>     use a sub folder. All fetchers are based on the wget fetcher.
>>     That is probably "my fault". Put yourself in my position. You get a ton
>>     of different patches, all touching very varied aspects of the system.
>>     When reviewing them you have to try and remember the original design
>>     decisions, the future directions, the ways things broke in the past, a
>>     desire to try and have clean consistent APIs and so on. I have tried
>>     very hard to move things in a direction where things incrementally
>>     improve, without unnecessarily blocking new features. It means that
>>     things that merge often aren't perfect. We've tried a few different
>>     approaches with the newer programming languages and each approach has
>>     had pros and cons. The inconsistency is probably as I missed something
>>     in review. Sorry :(.
>
>     Sorry, I don't want to criticism you. I see that you have a lot of
>     work. I want to understand the reasons for the actual design and
>     how it should look like.
>
>>     I only have finite time. There are few people who seem to want to dive
>>     in and help with review of patches like these. I did ask some people
>>     yesterday, one told me they simply couldn't understand these patches.
>
>     What can I do to improve the review?
>
>>     I'm doing my best to ask the right questions, try and help others
>>     understand them, ensure my own concerns I can identify are resolved and
>>     I don't want to de-motivate you on this work either, I think the idea
>>     of improving this is great and I'd love to see it. Equally, I'm also
>>     the first person everyone will complain to if we change something and
>>     it causes problems for people.
>>
>>     So the explanation is probably I just missed something in review at
>>     some point. The intent was to separate out the fetcher output going
>>     forward (unless it makes sense to be shared).
>>
>>     FWIW there are multiple things which bother me about the existing
>>     fetcher storage layout but that is a different discussion.
>
>     Okay.
>
>>>>>>>     * Where should we unpack the dependencies?
>>>>>>>     ** Should we use a folder inside the parent folder (ex.
>>>>>>>     node_modules)?
>>>>>>>     ** Should we use a fixed folder inside unpackdir
>>>>>>>         (ex. go/pkg/mod/cache/download and cargo_home/bitbake)?
>>>>>>       
>>>>>>     This likely depends on the fetcher as the different mechanisms will
>>>>>>     have different expectations about how they should be extracted (as
>>>>>>     npm/etc. would).
>>>>>       
>>>>>     It depends on the fetcher but the fetcher could use the same
>>>>>     approach. At the moment every fetcher use a different approach. The
>>>>>     crate fetcher use a fixed value. The gomod fetcher uses a variable
>>>>>     (GO_MOD_CACHE_DIR) and the npm fetcher uses a parameter (destsuffix).
>>>>>     Furthermore the gomod fetcher override the common subdir parameter.
>>>>     I think we really need to standardise that if we can. Each new fetcher
>>>>     has claimed a certain approach is effectively required by the package
>>>>     manager.
>>>>       What would be your desired solution? Is the variable okay or do you prefer a self contain SRC_URI?
>>     I suspect we need a default via a variable and then the option to
>>     change the default via parameters. The default value should be a
>>     bitbake fetcher namespaced control variable.
>>
>>     I'm wary of making a definitive statement saying X if that isn't going
>>     to make sense for some backend though. I simply don't have enough
>>     knowledge of them all, which is why you see me being reluctant to make
>>     definitive statements about design.
>
>     Okay.
>
>>>>>>>     * How should we treat archives for package manager caches?
>>>>>>>     ** Should we unpack the archives to support patching (ex. npm)?
>>>>>>>     ** Should we copy the packed archive to avoid unpacking and
>>>>>>>     packaging
>>>>>>>         (ex. gomod)?
>>>>>>>       
>>>>>>     If there are archives left after do_unpack, which task is going
>>>>>>     to unpack those? Are we expecting the build process in
>>>>>>     configure/compile to decompress them? Would those management
>>>>>>     tools accept things if they were extracted earlier? "unpack"
>>>>>>     would be the correct time to do it but I can see this getting
>>>>>>     into conflict with the package manager :/.
>>>>>       
>>>>>     Most package manager expect archives. In the npm case the archive is
>>>>>     unpack by the fetcher and packed by thenpm.bbclass to support
>>>>>     patching. The gomod fetcher doesn't unpack the downloaded archive and
>>>>>     the gomodgit fetcher create archives from git folders during unpack.
>>>>>     It would be possible to always keep the archives or always extract
>>>>>     the archives and recreate archives during build. It is a decision
>>>>>     between performance and patchability.
>>>>>       
>>>>>       At the moment it is complicated to work with the different fetcher
>>>>>     because every fetcher use a different concept and it is unclear what
>>>>>     is the desired approach.
>>>>       
>>>>     This is a challenge. Can we handle the unpacking with the package
>>>>     manager as a specific step or does it have to be combined with other
>>>>     steps like configure/compile?
>>>>        
>>>     It looks like this is possible:
>>>       cargo fetch
>>>       go mod vendor
>>>       npm install
>>>       
>>>       I suspect you're thinking about using the package manager in
>>>     do_unpack to unpack the archives and patch the unpacked archives
>>>     afterwards?
>>     I'm wondering about it, yes. I know we've had challenges with patching
>>     rust modules for example so this isn't a theoretical problem :/.
>
>     It is an interesting idea because most package manager check the
>     integrity before unpack. Additionally it should simplify and speed
>     up the npm build because it removes the repack of the packages.
>     The problem is that we need an additional task to patch the
>     dependency specification file and to unpack the file.
>
>>>>>>     I did wonder if patches 1-5 of this series could be merged
>>>>>>     separately too as they look reasonable regardless of the rest
>>>>>>     of the series?
>>>>>       
>>>>>     Sure. Should I resend the patches as separate series?
>>>>     Yes please, that would then let us remove the bits we can easily
>>>>     review/sort and focus on this other part.
>>>>        
>>>     Done.
>>     Thanks.
>>
>>>     I will also resend the go h1 checksum commit separate because it
>>>     could be useful for the gomod fetcher.
>>     Yes, I was waiting for a new version of that one with the naming tweaked.
>
>     Done.
>
>>>     Should I also move the dn / dv parameter patches to a separate series
>>>     because it could be useful without the dependency fetcher. I could
>>>     add the parameters to the fetchers in a backward compatible way.
>>     I need to think more about that one...
>
>     The motivation is to include the dependencies with name, version,
>     license and cpe into the SBOM.
>
>     Regards
>       Stefan
>
>
>     -=-=-=-=-=-=-=-=-=-=-=-
>     Links: You receive all messages sent to this group.
>     View/Reply Online (#16981):
>     https://lists.openembedded.org/g/bitbake-devel/message/16981
>     Mute This Topic: https://lists.openembedded.org/mt/110212697/1050810
>     Group Owner: bitbake-devel+owner@lists.openembedded.org
>     <mailto:bitbake-devel%2Bowner@lists.openembedded.org>
>     Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub
>     [bruce.ashfield@gmail.com]
>     -=-=-=-=-=-=-=-=-=-=-=-
>
>
>
> -- 
> - Thou shalt not follow the NULL pointer, for chaos and madness await 
> thee at its end
> - "Use the force Harry" - Gandalf, Star Trek II
>
--------------wodhpeHAXX8YU20xH0bPJdVT
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Am 07.01.2025 um 17:58 schrieb Bruce
      Ashfield:<br>
    </div>
    <blockquote type="cite" cite="mid:CADkTA4OqeMu9sv2VohLHj3VJ_b96147K6NiGp4gicSb0SrBi1A@mail.gmail.com">
      
      <div dir="ltr">
        <div dir="ltr">
          <div class="gmail_default" style="font-size:small">Hi all,</div>
          <div class="gmail_default" style="font-size:small"><br>
          </div>
          <div class="gmail_default" style="font-size:small">I'm going
            to reply at this point in the thread to at least let
            everyone know that I've been reading along, but honestly
            can't say if a few questions that I have have been asked
            (and answered).</div>
          <div class="gmail_default" style="font-size:small"><br>
          </div>
          <div class="gmail_default" style="font-size:small">The biggest
            use case that I have for the layers and recipes that I
            maintain is about being able to both &quot;easily&quot; patch or
            update vendor/dependencies of the main application build.</div>
          <div class="gmail_default" style="font-size:small"><br>
          </div>
          <div class="gmail_default" style="font-size:small">It was
            unclear to me how I'd do that with these changes.&nbsp;</div>
          <div class="gmail_default" style="font-size:small"><br>
          </div>
          <div class="gmail_default" style="font-size:small">For the
            copied/extracted dependencies, I can see that you'd just be
            able to figure&nbsp;out where they were extracted (and I see the
            discussions on where to extract/store some of the files) and
            then write a patch as you would with any recipe. But would
            there be a way to patch the dependency &quot;lock file&quot; ? I
            definitely don't see a way that I'd be able to tweak a
            source hash and have an updated dependency pulled in .. but
            I could have easily missed that.</div>
        </div>
      </div>
    </blockquote>
    <p>You have to provide your own &quot;lock file&quot; and place it beside the
      recipe. The &quot;lock file&quot; is fetched via the file fetcher and is
      used to fetch the dependencies.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:CADkTA4OqeMu9sv2VohLHj3VJ_b96147K6NiGp4gicSb0SrBi1A@mail.gmail.com">
      <div dir="ltr">
        <div dir="ltr">
          <div class="gmail_default" style="font-size:small">Those are
            the primary reasons why I'll stay with explicitly listed /
            visible dependencies, unless something similar is available
            in a re-worked / unified fetcher.</div>
        </div>
      </div>
    </blockquote>
    <p>It is impossible to patch the sources inside bitbake. Therefore
      the dependency resolution must be moved inside a dependency fetch
      task and an additional dependency patch task need to be added.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:CADkTA4OqeMu9sv2VohLHj3VJ_b96147K6NiGp4gicSb0SrBi1A@mail.gmail.com">
      <div dir="ltr">
        <div dir="ltr">
          <div class="gmail_default" style="font-size:small">I prefer
            the translation to git, so I have&nbsp;debug source for vendor
            dependencies as well as a well travelled path to mirror and
            archive the source</div>
        </div>
      </div>
    </blockquote>
    <p>Do you reference to the go-vendor implementation? Do you mean the
      vendor directory? The gomod fetcher should support mirror and
      archive the sources. It should be possible to create a vendor
      folder from the gomod archives.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:CADkTA4OqeMu9sv2VohLHj3VJ_b96147K6NiGp4gicSb0SrBi1A@mail.gmail.com">
      <div dir="ltr">
        <div dir="ltr">
          <div class="gmail_default" style="font-size:small">, but
            something like the update task of rust is at least explicit
            and visible to me, so I can also use it without too many
            issues.</div>
        </div>
      </div>
    </blockquote>
    <p>Do you mean `bitbake -c update_crates recipe-name`?<br>
      <br>
      Regards<br>
      &nbsp; Stefan<br>
    </p>
    <blockquote type="cite" cite="mid:CADkTA4OqeMu9sv2VohLHj3VJ_b96147K6NiGp4gicSb0SrBi1A@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote gmail_quote_container">
          <div dir="ltr" class="gmail_attr">On Tue, Jan 7, 2025 at
            11:13 AM Stefan Herbrechtsmeier via <a href="http://lists.openembedded.org" moz-do-not-send="true">lists.openembedded.org</a>
            &lt;stefan.herbrechtsmeier-oss=<a href="mailto:weidmueller.com@lists.openembedded.org" moz-do-not-send="true" class="moz-txt-link-freetext">weidmueller.com@lists.openembedded.org</a>&gt;
            wrote:<br>
          </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <div>
              <div>Am 07.01.2025 um 12:01 schrieb Richard Purdie:<br>
              </div>
              <blockquote type="cite">
                <pre>On Tue, 2025-01-07 at 10:47 +0100, Stefan Herbrechtsmeier wrote:
</pre>
                <blockquote type="cite">
                  <pre>Am 06.01.2025 um 16:30 schrieb Richard Purdie:
</pre>
                  <blockquote type="cite">
                    <pre>On Mon, 2025-01-06 at 15:35 +0100, Stefan Herbrechtsmeier wrote:
</pre>
                    <blockquote type="cite">
                      <blockquote type="cite">
                        <pre>&nbsp;I'm a little bit worried about how easily you could sneak a
&quot;floating&quot; version into this and make the fetcher non-
deterministic. Does (or could?) the code detect and error on
that?&nbsp;
&nbsp;&nbsp;
</pre>
                      </blockquote>
                      <pre>We could raise an error if a checksum is missing in the
dependency specification file or make the checksum mandatory for
the dependency fetcher.&nbsp; Furthermore we could inspect the
dependency URLs to detect a misuse of the file like a latest
string for the version.
&nbsp;
</pre>
                    </blockquote>
                    <pre>I think adding such an error would be a requirement for merging
this.
&nbsp;&nbsp;
</pre>
                  </blockquote>
                  <pre>Should the dependency fetcher (ex. npmsw) or the language specific
fetcher (ex. npm) fail if the version points to a latest version?
</pre>
                </blockquote>
                <pre>I think right now it has to error to try and reduce complexity. It is
possible to support such things but you have to pass that version
information back up the stack so that PV represents the different
versions and that is a new level of complexity.

I guess we should consider how you could theoretically support it as
that might influence the design. With multiple git repos in SRC_URI for
example, we end up adding multiple shortened shas to construct a PV so
that if any change, PV changes. We also have to add an incrementing
integer so that on opkg/dpkg/rpm operations work and versions sort.</pre>
              </blockquote>
              <p>Okay. In this case we should add the checks to the
                dependency resolution. Thereby we prohibit dynamic
                versions for the dependencies and allows users to add
                support for it to the fetcher of the package manager.<br>
                <br>
              </p>
              <blockquote type="cite">
                <blockquote type="cite">
                  <blockquote type="cite">
                    <blockquote type="cite">
                      <blockquote type="cite">
                        <pre>Put another way, could one of these SRC_URIs map to multiple
different combinations of underlying component versions?
</pre>
                      </blockquote>
                      <pre>If you mean the extracted SRC_URI for a single dependency from
the dependency specification file (ex. npm-shrinkwrap.json) it
could use special URLs to map to the latest version. But this is
a missus of the dependency specification file and could be
detected. The tools generate files with fixed versions always
because a floating version with a fixed checksum make no senses.&nbsp;
</pre>
                    </blockquote>
                    <pre>Even if it shouldn't happen, we need to detect and error for this
case as it would become very problematic for us.

</pre>
                  </blockquote>
                  <pre>Okay. Should we disallow a dynamic version for package manager
downloads generally or do you see a reasonable use case?
</pre>
                </blockquote>
                <pre>See above.

</pre>
                <blockquote type="cite">
                  <blockquote type="cite">
                    <blockquote type="cite">
                      <pre>&nbsp;I also thought it would make sense to generate recipes from the
dependency specification files and therefore worked on the
recipetool
previous. But it looks like the tool isn't really used and I'm
afraid
nobody will use the recipe to fix dependencies. In most cases it
is
easy to update a dependency in the native tooling and only
provide an
updated dependency specification file.
&nbsp;
</pre>
                    </blockquote>
                    <pre>&nbsp;
I think people have wanted a single simple command to translate the
specification file into our recipe format to update the recipe. For
various reasons people didn't seem to find the recipetool approach
was working and created the task workflow based one. There are pros
and cons to both and I don't have a strong preference. I would like
to see something which makes it clear to users what is going on
though and is simple to use.

People do intuitively understand a .inc file with a list of urls in
it. There are challenges in updating it.

This other approach is not as intuitive as everything is abstracted
out of sight.

One thing for example which worries me is how are the license
fields in the recipe going to be updated?

Currently, if we teach the class, it can set LICENSE variables
appropriately. With the new approach, you don't know the licenses
until
after unpack has run. Yes it can write it into the SPDX, but it
won't
work for something like the layer index or forms of analysis which
don't build things.

This does also extend to vulnerability analysis since we can't know
what is in a given recipe without actually unpacking it. For
example we
could know crate XXX at version YYY has a CVE but we can't tell if
a
recipe uses that crate until after do_unpack, or at least not
without
expandurl.
&nbsp;
</pre>
                  </blockquote>
                  <pre>&nbsp;
The main question is if the meta data should contain all information.
If yes, we shouldn't allow any fetcher which requires an external
source. This should include the gitsm fetcher and we should replace
the single SRC_URI with multiple git SRC_URIs.
</pre>
                </blockquote>
                <pre>If we had tooling that supported that well we could certainly consider
it. It isn't straight forward as you can have a git repo containing
submodules which then themselves contain submodules which can then
contain more levels of submodules. There are therefore multiple levels
of expansion possible.</pre>
              </blockquote>
              <p>Okay. That makes the git submodule special in compare
                to the other dependency fetcher.<br>
                <br>
              </p>
              <blockquote type="cite">
                <blockquote type="cite">
                  <pre>We can go even further and forbid specific package manager fetchers
and use plain https or git SRC_URIs. The python and go-vendor fetcher
use this approach.
&nbsp;
&nbsp;Alternative we allow dependency fetchers and require that the meta
data be always used via bitbake. In this case we could extend the
meta data via the fetcher.
&nbsp;
&nbsp;In both cases it is possible to produce the same meta data. It
doesn't matter if we use recipetool, devtool, bbclasses or fetcher.
In any case we could resolve the SRC_URIs, checksums or srcrev from a
file. The license information could be fetched from the package
repositories without integrity checks or could be extracted from the
individual package description file inside the downloaded sources
(ex. npm). We should skip the license detection from license files
for now because they generate manual work and could be discuses
later.
</pre>
                </blockquote>
                <pre>That was the reason the current task based approach doesn't use them,
yet! I mention it just to highlight that it can be solved either way,
the approach doesn't really change what we need to do. The bigger
concern is having information available in the metadata which I think
we need do to some level regardless of which approach we choose.

</pre>
                <blockquote type="cite">
                  <pre>The recipe approach has the advantage that it uses fixed licenses and
that license changes could be (theoretical) reviewed during recipe
update.&nbsp;
</pre>
                </blockquote>
                <pre>FWIW that is an important use case and one of our general strengths. We
can only do that as the license information is written in recipes and
can be compared at update time.</pre>
              </blockquote>
              <p>Does this apply to the license of the every individual
                dependency or only to the combined license?<br>
                <br>
                <span style="white-space:pre-wrap">
</span><span style="white-space:pre-wrap">
</span></p>
              <blockquote type="cite">
                <blockquote type="cite">
                  <pre>In contrast the fetcher approach reduces the update procedure to a
simple file rename or SRCREV update (ex. gitsm). Furthermore, the
user could simply place a file beside the recipe to update the
dependencies. Could we realize the same via devtool integration and a
patch?
</pre>
                </blockquote>
                <pre>This is effectively what the task based approach is aiming for
currently. I think the idea was that we could have devtool/recipetool
integration around that update task, a task was just a convenient way
to capture the code to do it and get things working without needing the
tool to be finished.</pre>
              </blockquote>
              What is the task based approach? `bitbake -c update xyz`?<br>
              <br>
              <span style="white-space:pre-wrap">
</span>
              <blockquote type="cite">
                <blockquote type="cite">
                  <pre>&nbsp;We have different solutions between the languages (ex. npmsw vs
crate vs pypi) and even inside the languages (ex. go-vendor vs
gomod). I would like to unify the dependency support. It doesn't
matter if we decide to use the bitbake fetcher or a bitbake / devtool
command for the dependency and license resolution.
</pre>
                </blockquote>
                <pre>I do very much prefer having one good way of doing things rather than
multiple ways of doing things, each with a potential drawback. I'm
therefore broadly in favour of doing that as long as we don't upset too
much existing mindshare along the way.</pre>
              </blockquote>
              <p>Okay<br>
                <br>
                <span style="white-space:pre-wrap">
</span></p>
              <blockquote type="cite">
                <blockquote type="cite">
                  <blockquote type="cite">
                    <blockquote type="cite">
                      <pre>&nbsp;
&nbsp;I have a WIP to integrate the the dependencies into the spdx .
This
uses the expanded_urldata / implicit_urldata function to add the
dependencies to the process list of archiver and spdx.
&nbsp;
<a href="https://github.com/weidmueller/poky/tree/feature/dependency" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">https://github.com/weidmueller/poky/tree/feature/dependency</a>-
fetcher

Regarding the license we could migrate the functionality from
recipetool into a class and detect the licenses at build time.
Theoretically the fetcher could fetch the license from the
package
manager repository but we have to trust the repository because we
have no checksum to detect changes. Maybe we could integrate
tools
like Syft or ScanCode to detect the licenses at build time. At
the
moment the best solution is to make sure that the SBOM contains
the
name and version of the dependencies and let other tools handle
the
license via SBOM for now. Therefore I propose a common scheme to
define the dependency name (dn) and version (dv) in the SRC_URI.
&nbsp;
</pre>
                    </blockquote>
                    <pre>&nbsp;
We could compare what licenses the package manager is showing us
with
what is in the recipe and error if different. There would then need
to
be a command to update the licenses in the recipe (in much the way
urls
currently get updated).
&nbsp;
</pre>
                  </blockquote>
                  <pre>&nbsp;
Either we request the licenses from the package manager during
package update or during fetch. I wouldn't do both. Instead I would
analyze the the license file during build and compare the detected
license with the recipe or fetcher generated licenses. But the
license detection from files is an other topic and I would like to
postpone it for now.
</pre>
                </blockquote>
                <pre>Agreed, I mention it just to highlight that supporting them does have
impact on the design so any solution needs to ultimately be able to
support it.

</pre>
                <blockquote type="cite">
                  <blockquote type="cite">
                    <blockquote type="cite">
                      <blockquote type="cite">
                        <pre>You're using DL_DIR for that which I
suspect isn't a great idea for tmp files.
</pre>
                      </blockquote>
                      <pre>&nbsp;Take over from gitsm.
</pre>
                    </blockquote>
                    <pre>Probably not the best fetcher and I'd say gitsm should be fixed.
</pre>
                  </blockquote>
                  <pre>I don't see a reason why the gitsm fetcher shouldn't handled like the
other dependency fetcher. We could update the handler after we have a
decision for the dependency fetchers.
</pre>
                </blockquote>
                <pre>In principle perhaps but as mentioned above, gitsm has its own challenges.</pre>
              </blockquote>
              <p>Based on your feedback I have the feeling that a
                dependency fetcher isn't the correct solution. The
                fetcher makes it impossible to review changes during
                recipe update.&nbsp;Additionally it needs caching for the
                resolved fetch and license data.<br>
                <br>
                The alternative is to create an inc file with SRC_URIs,
                checksums, SRCREVs and LICENSE. Any recommendation how
                to integrate the dependency resolution and inc creation
                into oe-core?<br>
                <br>
              </p>
              <blockquote type="cite">
                <blockquote type="cite">
                  <blockquote type="cite">
                    <blockquote type="cite">
                      <blockquote type="cite">
                        <pre>The url scheme is clever but also has a potential risk in that you
can't really pass parameters to both the top level fetcher and the
underlying one. I'm worried that is going to bite us further down
the
line.
</pre>
                      </blockquote>
                      <pre>At the moment I don't see a real problem but maybe you are right. The
existing language specific fetcher use fixed paths for there
downloads.
&nbsp;
&nbsp;What do you propose? Should the fetcher skip the unpack of the
source or should we introduce a sub fetcher which uses the download
from an other SRC_URI entry. The two entries could be linked via the
name parameter. This approach could be combined with your suggestion
above. The new fetcher will unpack a lock file from an other
(default) download.
</pre>
                    </blockquote>
                    <pre>&nbsp;
I'm not really sure what is best right now. I'm trying to spell out the
pros/cons of what is going on here in the hope it encourages others to
give feedback as well. I agree there isn't a problem right now but I
worry there soon will be by mixing two things together like this. The
way we handle git protocol does cause us friction with other urls
schemes already.
</pre>
                  </blockquote>
                  <pre>The dependency fetcher could simple skip the unpack. In this case the
user needs to use a variable to pass the same URL to the git and
dependency fetcher or we could provide a python function to generate
two SRC_URI with the same base URL.

</pre>
                </blockquote>
                <pre>I'm starting to wonder about a slightly different approach, basically
an optional generated file alongside a recipe which contains &quot;expanded&quot;
information which is effectively expensive to generate (in computation
or resource like network access/process terms). We could teach bitbake
a new phase of parsing where it generated them if missing. There are
some other pieces of information which we know during the build process
which it would be helpful to know earlier (e.g. which packages a recipe
generates). I've wondered about this for a long time and the fetcher
issues remind me of it again. It would be a big change with advantages
and drawbacks. I think it would put more pressure on a layer maintainer
as they'd have to computationally keep this up to date and it would
complicate the patch workflow (who should send/regen the files?). I'm
putting the idea there, I'm not saying I think we should do it, I'm
just considering options.
</pre>
              </blockquote>
              <p>Do you mean like a cache or like the inc files? Is the
                file totally auto generated or is manual editing
                acceptable?<br>
                <br>
              </p>
              <blockquote type="cite">
                <blockquote type="cite">
                  <pre>&nbsp;= Open questions
</pre>
                  <blockquote type="cite">
                    <blockquote type="cite">
                      <blockquote type="cite">
                        <blockquote type="cite">
                          <pre>* Where should we download dependencies?
** Should we use a folder per fetcher (ex. git and npm)?
** Should we use the main folder (ex. crate)?
** Should we translate the name into folder (ex. gomod)?
** Should we integrate the name into the filename (ex. git)?
&nbsp;
&nbsp;
</pre>
                        </blockquote>
                        <pre>&nbsp;
&nbsp;
DL_DIR is meant to be a complete cache of the source so it would
need
to be downloaded there. Given it maps to the other fetchers, the
existing cache mechanisms likely work for these just fine, the open
question is on whether the lock/spec files should be cached after
extraction.
</pre>
                      </blockquote>
                      <pre>&nbsp;
You misunderstand the question. Its about the downloadfilename
parameter. At the moment some fetcher use sub folder inside DL_DIR
and others use the main folder. It looks like every fetcher has its
own concept to handle file collision between different fetchers. The
git and npm fetcher use there own folder, the crate fetcher use its
own .crate file prefix, the gomod fetcher translate the URL into
multiple folders and the git fetcher translate the URL into a single
folder name.
</pre>
                    </blockquote>
                    <pre>That makes more sense. The layout is partially legacy. The wget and
local fetchers were first and hence go directly into DL_DIR. git/svn
were separated out into their own directories with a plan to have a
directory per fetcher. That didn't always work out with each newer
fetcher. Each fetcher does have to handle a unique naming of its urls
as only the specific fetcher can know all the urls parameters and which
ones affect the output vs which ones don't.
&nbsp;
</pre>
                  </blockquote>
                  <pre>&nbsp;This doesn't explain why the npm but not the gomod and crate fetcher
use a sub folder. All fetchers are based on the wget fetcher.
</pre>
                </blockquote>
                <pre>That is probably &quot;my fault&quot;. Put yourself in my position. You get a ton
of different patches, all touching very varied aspects of the system.
When reviewing them you have to try and remember the original design
decisions, the future directions, the ways things broke in the past, a
desire to try and have clean consistent APIs and so on. I have tried
very hard to move things in a direction where things incrementally
improve, without unnecessarily blocking new features. It means that
things that merge often aren't perfect. We've tried a few different
approaches with the newer programming languages and each approach has
had pros and cons. The inconsistency is probably as I missed something
in review. Sorry :(.</pre>
              </blockquote>
              <p>Sorry, I don't want to criticism you. I see that you
                have a lot of work. I want to understand the reasons for
                the actual design and how it should look like.<br>
                <br>
              </p>
              <blockquote type="cite">
                <pre>I only have finite time. There are few people who seem to want to dive
in and help with review of patches like these. I did ask some people
yesterday, one told me they simply couldn't understand these patches.</pre>
              </blockquote>
              <p>What can I do to improve the review?<br>
                <br>
              </p>
              <blockquote type="cite">
                <pre>I'm doing my best to ask the right questions, try and help others
understand them, ensure my own concerns I can identify are resolved and
I don't want to de-motivate you on this work either, I think the idea
of improving this is great and I'd love to see it. Equally, I'm also
the first person everyone will complain to if we change something and
it causes problems for people.&nbsp;

So the explanation is probably I just missed something in review at
some point. The intent was to separate out the fetcher output going
forward (unless it makes sense to be shared).

FWIW there are multiple things which bother me about the existing
fetcher storage layout but that is a different discussion.</pre>
              </blockquote>
              <p>Okay.<br>
              </p>
              <blockquote type="cite">
                <blockquote type="cite">
                  <blockquote type="cite">
                    <blockquote type="cite">
                      <blockquote type="cite">
                        <blockquote type="cite">
                          <pre>* Where should we unpack the dependencies?
** Should we use a folder inside the parent folder (ex.
node_modules)?
** Should we use a fixed folder inside unpackdir
&nbsp;&nbsp; (ex. go/pkg/mod/cache/download and cargo_home/bitbake)?
</pre>
                        </blockquote>
                        <pre>&nbsp;
This likely depends on the fetcher as the different mechanisms will
have different expectations about how they should be extracted (as
npm/etc. would).
</pre>
                      </blockquote>
                      <pre>&nbsp;
It depends on the fetcher but the fetcher could use the same
approach. At the moment every fetcher use a different approach. The
crate fetcher use a fixed value. The gomod fetcher uses a variable
(GO_MOD_CACHE_DIR) and the npm fetcher uses a parameter (destsuffix).
Furthermore the gomod fetcher override the common subdir parameter.
</pre>
                    </blockquote>
                    <pre>I think we really need to standardise that if we can. Each new fetcher
has claimed a certain approach is effectively required by the package
manager.
</pre>
                  </blockquote>
                </blockquote>
                <blockquote type="cite">
                  <blockquote type="cite">
                    <pre>&nbsp;What would be your desired solution? Is the variable okay or do you prefer a self contain SRC_URI?
</pre>
                  </blockquote>
                </blockquote>
                <pre>I suspect we need a default via a variable and then the option to
change the default via parameters. The default value should be a
bitbake fetcher namespaced control variable.

I'm wary of making a definitive statement saying X if that isn't going
to make sense for some backend though. I simply don't have enough
knowledge of them all, which is why you see me being reluctant to make
definitive statements about design.
</pre>
              </blockquote>
              <p>Okay.<br>
                <br>
              </p>
              <blockquote type="cite">
                <blockquote type="cite">
                  <blockquote type="cite">
                    <blockquote type="cite">
                      <blockquote type="cite">
                        <blockquote type="cite">
                          <pre>* How should we treat archives for package manager caches?
** Should we unpack the archives to support patching (ex. npm)?
** Should we copy the packed archive to avoid unpacking and
packaging
&nbsp;&nbsp; (ex. gomod)?
&nbsp;
</pre>
                        </blockquote>
                        <pre>If there are archives left after do_unpack, which task is going
to unpack those? Are we expecting the build process in
configure/compile to decompress them? Would those management
tools accept things if they were extracted earlier? &quot;unpack&quot;
would be the correct time to do it but I can see this getting
into conflict with the package manager :/.
</pre>
                      </blockquote>
                      <pre>&nbsp;
Most package manager expect archives. In the npm case the archive is
unpack by the fetcher and packed by thenpm.bbclass to support
patching. The gomod fetcher doesn't unpack the downloaded archive and
the gomodgit fetcher create archives from git folders during unpack.
It would be possible to always keep the archives or always extract
the archives and recreate archives during build. It is a decision
between performance and patchability.
&nbsp;
&nbsp;At the moment it is complicated to work with the different fetcher
because every fetcher use a different concept and it is unclear what
is the desired approach.
</pre>
                    </blockquote>
                    <pre>&nbsp;
This is a challenge. Can we handle the unpacking with the package
manager as a specific step or does it have to be combined with other
steps like configure/compile?
&nbsp;&nbsp;
</pre>
                  </blockquote>
                  <pre>It looks like this is possible:
&nbsp;cargo fetch
&nbsp;go mod vendor
&nbsp;npm install
&nbsp;
&nbsp;I suspect you're thinking about using the package manager in
do_unpack to unpack the archives and patch the unpacked archives
afterwards?
</pre>
                </blockquote>
                <pre>I'm wondering about it, yes. I know we've had challenges with patching
rust modules for example so this isn't a theoretical problem :/.</pre>
              </blockquote>
              <p>It is an interesting idea because most package manager
                check the integrity before unpack. Additionally it
                should simplify and speed up the npm build because it
                removes the repack of the packages. The problem is that
                we need an additional task to patch the dependency
                specification file and to unpack the file.<br>
                <br>
              </p>
              <blockquote type="cite">
                <blockquote type="cite">
                  <blockquote type="cite">
                    <blockquote type="cite">
                      <blockquote type="cite">
                        <pre>I did wonder if patches 1-5 of this series could be merged
separately too as they look reasonable regardless of the rest
of the series?&nbsp;
</pre>
                      </blockquote>
                      <pre>&nbsp;
Sure. Should I resend the patches as separate series?
</pre>
                    </blockquote>
                    <pre>Yes please, that would then let us remove the bits we can easily
review/sort and focus on this other part.
&nbsp;&nbsp;
</pre>
                  </blockquote>
                  <pre>Done.
</pre>
                </blockquote>
                <pre>Thanks.

</pre>
                <blockquote type="cite">
                  <pre>I will also resend the go h1 checksum commit separate because it
could be useful for the gomod fetcher.
</pre>
                </blockquote>
                <pre>Yes, I was waiting for a new version of that one with the naming tweaked.</pre>
              </blockquote>
              <p>Done.<br>
                <br>
              </p>
              <blockquote type="cite">
                <blockquote type="cite">
                  <pre>Should I also move the dn / dv parameter patches to a separate series
because it could be useful without the dependency fetcher. I could
add the parameters to the fetchers in a backward compatible way.
</pre>
                </blockquote>
                <pre>I need to think more about that one...
</pre>
              </blockquote>
              <p>The motivation is to include the dependencies with
                name, version, license and cpe into the SBOM.<br>
              </p>
              <p>Regards<br>
                &nbsp; Stefan<br>
                <br>
              </p>
              <p><span style="white-space:pre-wrap">
</span></p>
            </div>
            <br>
            -=-=-=-=-=-=-=-=-=-=-=-<br>
            Links: You receive all messages sent to this group.<br>
            View/Reply Online (#16981): <a href="https://lists.openembedded.org/g/bitbake-devel/message/16981" rel="noreferrer" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">https://lists.openembedded.org/g/bitbake-devel/message/16981</a><br>
            Mute This Topic: <a href="https://lists.openembedded.org/mt/110212697/1050810" rel="noreferrer" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">https://lists.openembedded.org/mt/110212697/1050810</a><br>
            Group Owner: <a href="mailto:bitbake-devel%2Bowner@lists.openembedded.org" target="_blank" moz-do-not-send="true">bitbake-devel+owner@lists.openembedded.org</a><br>
            Unsubscribe: <a href="https://lists.openembedded.org/g/bitbake-devel/unsub" rel="noreferrer" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">https://lists.openembedded.org/g/bitbake-devel/unsub</a>
            [<a href="mailto:bruce.ashfield@gmail.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">bruce.ashfield@gmail.com</a>]<br>
            -=-=-=-=-=-=-=-=-=-=-=-<br>
            <br>
          </blockquote>
        </div>
        <div><br clear="all">
        </div>
        <div><br>
        </div>
        <span class="gmail_signature_prefix">-- </span><br>
        <div dir="ltr" class="gmail_signature">- Thou shalt not follow
          the NULL pointer, for chaos and madness await thee at its end<br>
          - &quot;Use the force Harry&quot; - Gandalf, Star Trek II<br>
          <br>
        </div>
      </div>
    </blockquote>
  </body>
</html>

--------------wodhpeHAXX8YU20xH0bPJdVT--

