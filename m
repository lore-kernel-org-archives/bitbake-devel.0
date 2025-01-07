Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25519E77197
	for <webhook@archiver.kernel.org>; Tue,  7 Jan 2025 09:47:37 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.98])
 by mx.groups.io with SMTP id smtpd.web10.16953.1736243246797803923
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Jan 2025 01:47:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@weidmueller.com header.s=selector2 header.b=IyJVkDlF;
 spf=pass (domain: weidmueller.com, ip: 40.107.105.98, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Woh3I8WeeilxUKYLTH0swkc+dG7n6WfHH/BhVTi6Phja44enN9i7CFx1yfheKUUvo3FOFTyPas/faso8wWa34AiNa5c4Kpg6tmt4lvCnzsAjBQ77OIKlIKw8VijsgsiUhOkYA6RxggznmExXUpGkPgM5rdwnGQaq9pQso94OJmFWELGRKx8B6JskVL2zdyUPZjzIi4JDnajjdyyJoOnhHdmDoXjIq12TrVrrDsyc36wdFIGNGUVEVdxDlLU70W+LgK0X3EO3gaTHRbqWaeVxiq4loMEEdQiZ940I22ovIpiO/vWg0AfBZfBJDDL1KyONKNs7RRZqb4QnTZ4UMlL40Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=neSdCRYd4mmB6DbBI5Jk7uj8Tdyut+iYtlXBryoCF4Q=;
 b=smFAFUj/+XpAp+cbNKf64GlAKPI7jI92Uxp+9FN3ee6nmBQWgKE4RYJG45tldqzEj7jDc07EXALAOZrni9rzsoZ4skbVFtfFkP5NWCVp/XRUeZwIEjh11hy89qH4If4IWmP0SaQt2kBQA10EnHOt/h4LY4jCFHZdWqRNoDhnbcXEtSynQBBsBF4R0I0jIoG1Z2uNqrG+qrj2zlUa7S9tPuuJrLA85x5wPA27zzehSfS7IEQPgZAUwOd+y77oqJU3a33dOHJzNgWcGjqH5DnHMomQU6pgg+ul8gzT+KyWKN+TkkVFsRJafYPhapRrYU/Zr0zqUWAdFRiJmUQ1lMrioQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neSdCRYd4mmB6DbBI5Jk7uj8Tdyut+iYtlXBryoCF4Q=;
 b=IyJVkDlFhczE37vbkT7Hqhe/7kqOCAsAPaoQYiXJCEsyEO13d1FGEKPz22dJUq9noVh/tcP2sTCacLV1+2ExS8MyJqGnUUy3o+zlUc0MS4I2juw14c40VC3WqOY8nima1n4eJGmKnCSI+DKwelQotyHwgjy4a15oQCej+nnCR/CkvgKcKt/xy36Lz5CJTJYBQahAQ5QBEHmH1Fn++o/Nkiwq4yy3g5jPgUQSNZl0mxfQJ3qDTfonGVsuIVM+VKEBy3CqIikZC/fK12zHh/DhFzo2MfejoquLyW/6Ochn0UQygLGvLK+2iE+Z6BHdiW/YGFJh6A7Hf7zi5nO+/U2Sdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by DB8PR08MB5419.eurprd08.prod.outlook.com (2603:10a6:10:118::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 09:47:22 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 09:47:22 +0000
Content-Type: multipart/alternative;
 boundary="------------iOsm0RuHtrj8STXr7PcZg1a3"
Message-ID: <2a8d0393-800c-40b3-86fb-a5ab5e6f52f9@weidmueller.com>
Date: Tue, 7 Jan 2025 10:47:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [RFC PATCH 00/21] Concept for tightly coupled
 package manager (Node.js, Go, Rust)
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
Cc: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
References: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <00e379e761414e8cf07b83544d5202211bf4623c.camel@linuxfoundation.org>
 <578ed107-1a04-48db-ac2e-1dc9cdab60d0@weidmueller.com>
 <84c9eee86cd0a378dcfbcbcac297d3a24f2424ad.camel@linuxfoundation.org>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <84c9eee86cd0a378dcfbcbcac297d3a24f2424ad.camel@linuxfoundation.org>
X-ClientProxiedBy: FR5P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::15) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|DB8PR08MB5419:EE_
X-MS-Office365-Filtering-Correlation-Id: eab128e9-52dd-4b03-6a44-08dd2f004892
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|8096899003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?U3orajlvT0NLYWl3dFgrVHJtaHhWSXNzdHNRTW9ialY4SlVCMkwzNk4rMWdm?=
 =?utf-8?B?dGxEYUVYVkQ1WmVFM09RSnMxZFEzZjd0Nk1tR2g2TVdwVkxBZUNtTFdLTm9a?=
 =?utf-8?B?TS9SVExZclgwNmV2bnBBT3RQVXZkcHQ1dlBJVUVLSzJRdTl0THpnTDgyYU5u?=
 =?utf-8?B?M3VtekQyWnkzVkhNeDFtd01UdzFic1UxY2ozYVFzYVNodGRKdHhGc1ZwcHBj?=
 =?utf-8?B?VkhPNWpvaEozVXhoZDR2VHNNbWNwOGkrbGdwQ1hVQ3lJV2c5UmRyc2Z0MFdP?=
 =?utf-8?B?VklUdit6VVE0a1ZITWh0c2NNb0FvOGVYdVlrcWFOdU4xL3ZOcVprdFMyL3M4?=
 =?utf-8?B?WTRLM0tlUzhSMjVsSjlJRUhxeTlDeW5jMUFSYURXVUUrQnU5aHdkdXE4VjFF?=
 =?utf-8?B?QTNac2pKZEF3ZFk0TVliR0lIbHQ2UFhGYVNYMCtNeWFKNzBmOU44Skt3bmox?=
 =?utf-8?B?ZDRDV0ZDbzRMQXZPMTBJSzV5ZU41R0t6QjFMMGdLRXc5TzliUTZ2R0N3bU1r?=
 =?utf-8?B?dlRmMDVkVkFCTkxQZnBMY0dOd1JpdnlCWklySlhNaTlOTk93aWwyOHR0TG54?=
 =?utf-8?B?dS9ZY2M3aXBhTG9iU0JaYnVBTGUzMFNqWU1BZzE2Smp5QTZZdGc4QmhMcHJU?=
 =?utf-8?B?RWNXTDlKQTFrRlV4QThVanRPY2ZFc2x0WGR6VGtHNUtNS0U4R0RZNVBiY2o5?=
 =?utf-8?B?TzVzWS9wT0lCU3U3WDB2NWpBWnVSZkpEVGVRQ3BGOWdBK1grNjM0a1lKSG1Y?=
 =?utf-8?B?T3V0Zm1VRlBZOUFneFBvL2FTWW9yd1NjU1pkUWhBa2RpRXlSVVBhVks3dUN0?=
 =?utf-8?B?dytzUmp3UzlyV2pmSDFGY0NtcHB6bGIrNkNPb1QyN3JqdmNNNDVMVGorNUgv?=
 =?utf-8?B?bG94di9uNWNIT3BOc3hZcXErTVdvTDVUMWxabDRtYk5NUXlabWJZeUUvKzJU?=
 =?utf-8?B?a0FJcCsydFUvcDhJNVVxWUkyem5hOUhTR1ZSZHNvT0xyMnM0OFMyb1pzV2dm?=
 =?utf-8?B?S3NZTWZ6WW9iOE9UaXdGcVN1SWZHQjBXQ0IvT0l5LyswbEJ6aGxUMDdER0FZ?=
 =?utf-8?B?K2gycGYrcjNuR3BWeDFLVWpKQXROTXhCaXoyeThQdVRrbWMrUGs3VW9HS09D?=
 =?utf-8?B?b0FhT256SWUrU3BvZTloajhUbGdOZThJMTFGVmlZMktEYzFNMDFVRGhRZnlJ?=
 =?utf-8?B?dDNmOFFnRE5EWGVVYmt2OTZiOTFEdGNjYmVDL3d0S2dia214Z0VscTVtOTB1?=
 =?utf-8?B?TkNXd01IVy9jZThwc3lya3dBdGY0dDVGcE9XUlJLZGJYY0lUQlpMUmFXU1Qw?=
 =?utf-8?B?clRhOEhsV3MwTlAyYlMvQ3RUK1duTmRyQ0ZRK25uMlFGcHFCVVN5eFJxdFZD?=
 =?utf-8?B?blhic1Nvc3BKN0lDa2VaWFJzZDlNdEkvYlBFQzJlK0hEeTRMcW93M1BLVHE0?=
 =?utf-8?B?TjlNK0pzU01SdENzb2JvanRkS0pSNGQ4c1g4WGZXNjB4TzBvN0hLbVpuQjlE?=
 =?utf-8?B?QXAzWkViNTdabHBSekdQRGNlaVQ0S2pqVUlDeWNjd3ErOTdSYTRUZXJqKzc5?=
 =?utf-8?B?V1l2UVlUSHdoYkxYTWtOQk9iSzRXT01UTk9yWTd3RElUSVd5d0FCZzdVWkZF?=
 =?utf-8?B?MHRFanIwbnpqV1JvR2QvRlVTQjE5emNBZXp5K0MrZDBkb09uSk9pNFQ3Sk9L?=
 =?utf-8?B?SUVGNVNBWTVIZVZlRlAwbVVzeWQ3cDJhSytDZHVtMDgrMUJMVnV2NjJTRndH?=
 =?utf-8?B?Mjk3V1Rpd0dScS8wTzFNRGhrbGU3RkhvWWhoOUVuOE9XNloybVVMaVk5WDdV?=
 =?utf-8?B?UmhmOTBaR2RkK1YrVU1Kdz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(8096899003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WTVqajQyeVQ3WXR1QzRaRDRVcEFBUjRCbTgybVJsdXpyblFFQVVhRmtha0Jz?=
 =?utf-8?B?MG9FTlozcHVEck45cllmcVQ1M2NGNUVrOGhUaWFXRFFmNmR5UjR5QnE4NFBM?=
 =?utf-8?B?aGZvYnZLOWc0VzlBRlNiVWg4bHVqc1l0R2Flb25lRm5aVDVOVG1xQWd6T090?=
 =?utf-8?B?Y2E4a1YwVkpkQWJDNWhnZkFZWnVsR29vYjA0Q29nMXEzYzJLM1VsL2U4OXEr?=
 =?utf-8?B?dSt2N2VLejV2N3FqTG5xSnBtVWovUXRKWXlKWGxDaDdKZkJPdk1ranZtbGUw?=
 =?utf-8?B?NHlrb201NlJkdkl6MXUrQWJDQU9LbFAzU1lHSnQrUE0zcnl2dDIrWnc5aWdH?=
 =?utf-8?B?anRna2ZlbXlXTXZHMlE3TDE5OEYrT2xVVGM0OHpvcWlicWN4bU9ERkIydjdn?=
 =?utf-8?B?WkdOanJkdUlVWXJiV2pjazVOeUdEVWMzOHVtRG5nUzZONGFDUlg0aFp2Sk9C?=
 =?utf-8?B?UUorMUVNR3U5MWJKZEhnTjdiZFo0MkpwZUVjdmEwVTgvSE5WSUFYZHk0MVBv?=
 =?utf-8?B?SVplU1RCSmdqZ0RNUC9nQStJSmoycUNza2I4d1E5YlFSVVkxYzd2NUtHVkxZ?=
 =?utf-8?B?Q2E5K29RWUlxMGkzVXJheFhscmxDVTVuTlZkV3UrbmJRaWYzbzdBdURzU3dF?=
 =?utf-8?B?aHAyR0R5RmEyTmJVVUMweHlMUnlyVEF4aG1hRDNTVWt0N0lCK3Bhclo3RFh6?=
 =?utf-8?B?bVhsUXRmS2tIVXlUOCtUUXJmR2F2NWgrZ1Q1Y1NFUGUxbUNEcTBHZ3p3Nkli?=
 =?utf-8?B?WFBYWloxWGh3UlowQ01TclBWWG1LTDk4cWRLWFMrd1RNMXlUSXVScmMwaTBz?=
 =?utf-8?B?K1UzS3BYV1A3RmNEVW5WU2J0VFdUSkNBc0U2bnNqRTJUL01RanpNSU0yK0pH?=
 =?utf-8?B?OHcydGoxN2MzSEYvZzIwM1hja2F0cmFFWWRMYUdSaEZRaEtrMFVLdExDZWJO?=
 =?utf-8?B?OXhwZ2lrajdFVkt3VFBXcEhtSGVlUld2TWNUNUhwMWpvUTdvSXFxclc3eEYv?=
 =?utf-8?B?bjRnNzl5VGhZVWkyc2k5cFhzQUxGUUpQT0RNQytUanJubHptQ2NjL3NlR1FK?=
 =?utf-8?B?SW11S2xxZXp4SERwKzRla0pDZ0RpM3FRUllOTGtNbmh4UmFVNVBFem5OdnBS?=
 =?utf-8?B?K3FUZHpabElQcHpxcmRiclowL1BlVEJnWU9ndmJVRFcrKzkvdEhEZHg5N0FC?=
 =?utf-8?B?dzVJL3UyUi95OXBZQ0ZDTjlPdnZjTWhpNlViT0xPVk4yU0ZXdTJaTjFhK2Yr?=
 =?utf-8?B?allwc0h2cVRCWVV2VnkxcHA0aEtLS0JNNHR1NGdET0xVczFZa0VhVkU4M0Rp?=
 =?utf-8?B?cGVGd2U4ME1WbUZHemxJQWNrRkZES3JPakFvZVBRYm1RY2NkQUp5QkIxVjNm?=
 =?utf-8?B?djdZWk5EaTIwWUNCUXBkM3FjSW9CZnBPdUlWSTc4TFp0Y0ZkQ211YkNlVzBj?=
 =?utf-8?B?TkZrQXdmbFVZd3o4YTB6Y29TcFFldTRzcUI4TElBUmIvU2pPUFNVOTZOMUE5?=
 =?utf-8?B?YjRMODAzc2h5dUdoU2FtOWtvOXRGVUEwUmRIMldFUnJMS3l4V2Z0QnFKbWlR?=
 =?utf-8?B?d3N1ZFFmcmt6blVPTGoweXJaRjhEYXBRd1ZRa0FObVpITDA0clg4YTQrb3ZV?=
 =?utf-8?B?U3pxcTBBUHoxVGFXaTJGMGd6dElzS1J4bFpEcEdhV3c5bW4vK0NIVFhtL3po?=
 =?utf-8?B?Ym1BeFEyb3QwWURVaUdHdmJnOHlGYkpJQVFsa2g0d0xGTTJrdEZsOUV3dDlG?=
 =?utf-8?B?QmllR3Q1YkVJQ3BMZUdiRWFETVdoQThCdnBTbkVqVEdOMXRUZnhjRFhFcVVF?=
 =?utf-8?B?RFY4dU1lVHgzZytQNVFkU2NrSVNOZWJXOU9wME03aEgxUXJQUHh6c3BIR1BG?=
 =?utf-8?B?czEzYnlwMVk3N3BhSG11UWl2M1RZOVpJVi95NjFGeVhBbmhwSi9NdEtkUHNL?=
 =?utf-8?B?bitlUEQ0YWZoZmVXL29NSzJNemUvTGZUMWVZdHkxQTRPUkN1K3BHOFZGeG10?=
 =?utf-8?B?Z01oaXl0R0grQ3gveTd5Y2owTllNS3pvRHMrbitMUGY3UFpSLytMOTZwb3cr?=
 =?utf-8?B?ZWdWa0ZMVkRYbEJpaW1KbDBVeFU4KzgxMkxNbDc0Z0NueU1DMUEvUFhwS3Q4?=
 =?utf-8?B?eEJKQ0xXZDlHbGxTdGxFbGttQ2NmeFZCSk1iVTJwdVBKd2tGdEVBTm8xVHlw?=
 =?utf-8?B?ekE9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eab128e9-52dd-4b03-6a44-08dd2f004892
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 09:47:22.1701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pUDizwmtMYo8yCoR2quKsWrCBegjSH0litnQmcsSKoRjTimUthaU9xw/UJah1rpQdmyUYvnSme9xn1U/qKXm/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5419
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Jan 2025 09:47:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16976

--------------iOsm0RuHtrj8STXr7PcZg1a3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 06.01.2025 um 16:30 schrieb Richard Purdie:
> On Mon, 2025-01-06 at 15:35 +0100, Stefan Herbrechtsmeier wrote:
>> Am 06.01.2025 um 12:04 schrieb Richard Purdie:
>>
>>> My comments (on various elements):
>>>
>>> With a npm-shrinkwrap.json/package-lock.json/go.sum file, are
>>> dependencies always recorded as specific entities with checksums?
>>>    
>> Yes, every dependency contains a fixed version and a checksum. The
>> purpose of the file is integrity and reproducibility.
> Thanks for confirming, that hasn't always been the case for some of
> these package management systems!
>
>>>   I'm a
>>> little bit worried about how easily you could sneak a "floating"
>>> version into this and make the fetcher non-deterministic. Does (or
>>> could?) the code detect and error on that?
>> We could raise an error if a checksum is missing in the dependency
>> specification file or make the checksum mandatory for the dependency
>> fetcher.  Furthermore we could inspect the dependency URLs to detect
>> a misuse of the file like a latest string for the version.
>
> I think adding such an error would be a requirement for merging this.

Should the dependency fetcher (ex. npmsw) or the language specific 
fetcher (ex. npm) fail if the version points to a latest version?

>>> Put another way, could one of these SRC_URIs map to multiple
>>> different
>>> combinations of underlying component versions?
>> If you mean the extracted SRC_URI for a single dependency from the
>> dependency specification file (ex. npm-shrinkwrap.json) it could use
>> special URLs to map to the latest version. But this is a missus of
>> the dependency specification file and could be detected. The tools
>> generate files with fixed versions always because a floating version
>> with a fixed checksum make no senses.
> Even if it shouldn't happen, we need to detect and error for this case
> as it would become very problematic for us.

Okay. Should we disallow a dynamic version for package manager downloads 
generally or do you see a reasonable use case?

>>> Our existing method effectively hardcodes/expands the lock file
>>> into
>>> extended SRC_URI entries which makes the specific versions and
>>> components really clear. This change abstracts that away into the
>>> fetcher and makes it opaque to the user, and much harder for code
>>> like
>>> the archiver/license/spdx code to fine/handle.
>> Really? Let's use the crate fetcher as an example. At the moment the
>> cargo-update-recipe-crates class extract the URI and checksum from
>> the Cargo.lock. The class ignores the licenses and they leads to
>> missing licenses in the recipe. The spdx files contains bitbake
>> specific fetcher URLs only which are unknown outside of bitbake.
> I guess what I'm trying to say is that people generally easily
> understand the explicit expanded urls. Whilst that class does ignore
> license handling, the hope was that it would get added, it is certainly
> possible to fix that.

I will check how complicated it is to extract the license information 
from the package registries.

>>   I also thought it would make sense to generate recipes from the
>> dependency specification files and therefore worked on the recipetool
>> previous. But it looks like the tool isn't really used and I'm afraid
>> nobody will use the recipe to fix dependencies. In most cases it is
>> easy to update a dependency in the native tooling and only provide an
>> updated dependency specification file.
> I think people have wanted a single simple command to translate the
> specification file into our recipe format to update the recipe. For
> various reasons people didn't seem to find the recipetool approach was
> working and created the task workflow based one. There are pros and
> cons to both and I don't have a strong preference. I would like to see
> something which makes it clear to users what is going on though and is
> simple to use.
>
> People do intuitively understand a .inc file with a list of urls in it.
> There are challenges in updating it.
>
> This other approach is not as intuitive as everything is abstracted out
> of sight.
>
> One thing for example which worries me is how are the license fields in
> the recipe going to be updated?
>
> Currently, if we teach the class, it can set LICENSE variables
> appropriately. With the new approach, you don't know the licenses until
> after unpack has run. Yes it can write it into the SPDX, but it won't
> work for something like the layer index or forms of analysis which
> don't build things.
>
> This does also extend to vulnerability analysis since we can't know
> what is in a given recipe without actually unpacking it. For example we
> could know crate XXX at version YYY has a CVE but we can't tell if a
> recipe uses that crate until after do_unpack, or at least not without
> expandurl.

The main question is if the meta data should contain all information. If 
yes, we shouldn't allow any fetcher which requires an external source. 
This should include the gitsm fetcher and we should replace the single 
SRC_URI with multiple git SRC_URIs.

We can go even further and forbid specific package manager fetchers and 
use plain https or git SRC_URIs. The python and go-vendor fetcher use 
this approach.

Alternative we allow dependency fetchers and require that the meta data 
be always used via bitbake. In this case we could extend the meta data 
via the fetcher.

In both cases it is possible to produce the same meta data. It doesn't 
matter if we use recipetool, devtool, bbclasses or fetcher. In any case 
we could resolve the SRC_URIs, checksums or srcrev from a file. The 
license information could be fetched from the package repositories 
without integrity checks or could be extracted from the individual 
package description file inside the downloaded sources (ex. npm). We 
should skip the license detection from license files for now because 
they generate manual work and could be discuses later.

The recipe approach has the advantage that it uses fixed licenses and 
that license changes could be (theoretical) reviewed during recipe 
update. In contrast the fetcher approach reduces the update procedure to 
a simple file rename or SRCREV update (ex. gitsm). Furthermore, the user 
could simply place a file beside the recipe to update the dependencies. 
Could we realize the same via devtool integration and a patch?

We have different solutions between the languages (ex. npmsw vs crate vs 
pypi) and even inside the languages (ex. go-vendor vs gomod). I would 
like to unify the dependency support. It doesn't matter if we decide to 
use the bitbake fetcher or a bitbake / devtool command for the 
dependency and license resolution.

>>   I have a WIP to integrate the the dependencies into the spdx . This
>> uses the expanded_urldata / implicit_urldata function to add the
>> dependencies to the process list of archiver and spdx.
>>   
>> https://github.com/weidmueller/poky/tree/feature/dependency-fetcher
>>
>> Regarding the license we could migrate the functionality from
>> recipetool into a class and detect the licenses at build time.
>> Theoretically the fetcher could fetch the license from the package
>> manager repository but we have to trust the repository because we
>> have no checksum to detect changes. Maybe we could integrate tools
>> like Syft or ScanCode to detect the licenses at build time. At the
>> moment the best solution is to make sure that the SBOM contains the
>> name and version of the dependencies and let other tools handle the
>> license via SBOM for now. Therefore I propose a common scheme to
>> define the dependency name (dn) and version (dv) in the SRC_URI.
> We could compare what licenses the package manager is showing us with
> what is in the recipe and error if different. There would then need to
> be a command to update the licenses in the recipe (in much the way urls
> currently get updated).

Either we request the licenses from the package manager during package 
update or during fetch. I wouldn't do both. Instead I would analyze the 
the license file during build and compare the detected license with the 
recipe or fetcher generated licenses. But the license detection from 
files is an other topic and I would like to postpone it for now.

>>>   
>>> I noticed that any fetcher operation has to first expand the lock
>>> file
>>> using a temporary directory.
>>>   
>>   I follow gitsm and open for suggestions. The expand happens only
>> once per fetcher object. The sub fechter object is saved in the proxy
>> variable.
> That fetcher object has to be recreated in every task or task context
> using the fetcher.

Okay. In this case it makes sense to cache the resolved URIs.

>>> You're using DL_DIR for that which I
>>> suspect isn't a great idea for tmp files.
>>>   
>>   Take over from gitsm.
> Probably not the best fetcher and I'd say gitsm should be fixed.

I don't see a reason why the gitsm fetcher shouldn't handled like the 
other dependency fetcher. We could update the handler after we have a 
decision for the dependency fetchers.

>>>   In many cases that will work
>>> fine but it is a bit of a performance overhead.
>>>
>>> I did start wondering if we should cache the lock files in a subdir
>>> of
>>> DL_DIR to help performance and also give some extra assurance about
>>> changing content.
>>>   
>>   This would be possible. I assume the best would be another sub
>> SRC_URI to avoid code duplication for the locking and change
>> detection.
> Probably, I did wonder if the mixin could cover that
> abstraction/caching.

That should be possible.

>>> The url scheme is clever but also has a potential risk in that you
>>> can't really pass parameters to both the top level fetcher and the
>>> underlying one. I'm worried that is going to bite us further down
>>> the
>>> line.
>>>   
>>   
>> At the moment I don't see a real problem but maybe you are right. The
>> existing language specific fetcher use fixed paths for there
>> downloads.
>>   
>>   What do you propose? Should the fetcher skip the unpack of the
>> source or should we introduce a sub fetcher which uses the download
>> from an other SRC_URI entry. The two entries could be linked via the
>> name parameter. This approach could be combined with your suggestion
>> above. The new fetcher will unpack a lock file from an other
>> (default) download.
>>   
> I'm not really sure what is best right now. I'm trying to spell out the
> pros/cons of what is going on here in the hope it encourages others to
> give feedback as well. I agree there isn't a problem right now but I
> worry there soon will be by mixing two things together like this. The
> way we handle git protocol does cause us friction with other urls
> schemes already.

The dependency fetcher could simple skip the unpack. In this case the 
user needs to use a variable to pass the same URL to the git and 
dependency fetcher or we could provide a python function to generate two 
SRC_URI with the same base URL.

>>>> = Open questions
>>>>
>>>> * Where should we download dependencies?
>>>> ** Should we use a folder per fetcher (ex. git and npm)?
>>>> ** Should we use the main folder (ex. crate)?
>>>> ** Should we translate the name into folder (ex. gomod)?
>>>> ** Should we integrate the name into the filename (ex. git)?
>>>>   
>>>   
>>> DL_DIR is meant to be a complete cache of the source so it would
>>> need
>>> to be downloaded there. Given it maps to the other fetchers, the
>>> existing cache mechanisms likely work for these just fine, the open
>>> question is on whether the lock/spec files should be cached after
>>> extraction.
>>>   
>>   
>> You misunderstand the question. Its about the downloadfilename
>> parameter. At the moment some fetcher use sub folder inside DL_DIR
>> and others use the main folder. It looks like every fetcher has its
>> own concept to handle file collision between different fetchers. The
>> git and npm fetcher use there own folder, the crate fetcher use its
>> own .crate file prefix, the gomod fetcher translate the URL into
>> multiple folders and the git fetcher translate the URL into a single
>> folder name.
> That makes more sense. The layout is partially legacy. The wget and
> local fetchers were first and hence go directly into DL_DIR. git/svn
> were separated out into their own directories with a plan to have a
> directory per fetcher. That didn't always work out with each newer
> fetcher. Each fetcher does have to handle a unique naming of its urls
> as only the specific fetcher can know all the urls parameters and which
> ones affect the output vs which ones don't.
This doesn't explain why the npm but not the gomod and crate fetcher use 
a sub folder. All fetchers are based on the wget fetcher.

>>>> * Where should we unpack the dependencies?
>>>> ** Should we use a folder inside the parent folder (ex.
>>>> node_modules)?
>>>> ** Should we use a fixed folder inside unpackdir
>>>>     (ex. go/pkg/mod/cache/download and cargo_home/bitbake)?
>>>>   
>>>   
>>> This likely depends on the fetcher as the different mechanisms will
>>> have different expectations about how they should be extracted (as
>>> npm/etc. would).
>>>   
>>   
>> It depends on the fetcher but the fetcher could use the same
>> approach. At the moment every fetcher use a different approach. The
>> crate fetcher use a fixed value. The gomod fetcher uses a variable
>> (GO_MOD_CACHE_DIR) and the npm fetcher uses a parameter (destsuffix).
>> Furthermore the gomod fetcher override the common subdir parameter.
> I think we really need to standardise that if we can. Each new fetcher
> has claimed a certain approach is effectively required by the package
> manager.

What would be your desired solution? Is the variable okay or do you 
prefer a self contain SRC_URI?

>>>> * How should we treat archives for package manager caches?
>>>> ** Should we unpack the archives to support patching (ex. npm)?
>>>> ** Should we copy the packed archive to avoid unpacking and
>>>> packaging
>>>>     (ex. gomod)?
>>>>   
>>>   
>>> If there are archives left after do_unpack, which task is going to
>>> unpack those? Are we expecting the build process in
>>> configure/compile
>>> to decompress them? Would those management tools accept things if
>>> they
>>> were extracted earlier? "unpack" would be the correct time to do it
>>> but
>>> I can see this getting into conflict with the package manager :/.
>>>   
>>   
>> Most package manager expect archives. In the npm case the archive is
>> unpack by the fetcher and packed by thenpm.bbclass to support
>> patching. The gomod fetcher doesn't unpack the downloaded archive and
>> the gomodgit fetcher create archives from git folders during unpack.
>> It would be possible to always keep the archives or always extract
>> the archives and recreate archives during build. It is a decision
>> between performance and patchability.
>>   
>>   At the moment it is complicated to work with the different fetcher
>> because every fetcher use a different concept and it is unclear what
>> is the desired approach.
> This is a challenge. Can we handle the unpacking with the package
> manager as a specific step or does it have to be combined with other
> steps like configure/compile?

It looks like this is possible:
cargo fetch
go mod vendor
npm install

I suspect you're thinking about using the package manager in do_unpack 
to unpack the archives and patch the unpacked archives afterwards?

>>> I did wonder if patches 1-5 of this series could
>>> be merged separately too as they look reasonable regardless of the
>>> rest
>>> of the series?
>>>   
>>   
>> Sure. Should I resend the patches as separate series?
> Yes please, that would then let us remove the bits we can easily
> review/sort and focus on this other part.

Done.

I will also resend the go h1 checksum commit separate because it could 
be useful for the gomod fetcher.

Should I also move the dn / dv parameter patches to a separate series 
because it could be useful without the dependency fetcher. I could add 
the parameters to the fetchers in a backward compatible way.

Regards
   Stefan

--------------iOsm0RuHtrj8STXr7PcZg1a3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Am 06.01.2025 um 16:30 schrieb Richard
      Purdie:<br>
    </div>
    <blockquote type="cite" cite="mid:84c9eee86cd0a378dcfbcbcac297d3a24f2424ad.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">On Mon, 2025-01-06 at 15:35 +0100, Stefan Herbrechtsmeier wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Am 06.01.2025 um 12:04 schrieb Richard Purdie:

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">
My comments (on various elements):

With a npm-shrinkwrap.json/package-lock.json/go.sum file, are
dependencies always recorded as specific entities with checksums?
&nbsp;&nbsp;
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">Yes, every dependency contains a fixed version and a checksum. The
purpose of the file is integrity and reproducibility.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Thanks for confirming, that hasn't always been the case for some of
these package management systems!

</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">&nbsp;I'm a
little bit worried about how easily you could sneak a &quot;floating&quot;
version into this and make the fetcher non-deterministic. Does (or
could?) the code detect and error on that?&nbsp;
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
We could raise an error if a checksum is missing in the dependency
specification file or make the checksum mandatory for the dependency
fetcher.&nbsp; Furthermore we could inspect the dependency URLs to detect
a misuse of the file like a latest string for the version.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">

I think adding such an error would be a requirement for merging this.</pre>
    </blockquote>
    <p>Should the dependency fetcher (ex. npmsw) or the language
      specific fetcher (ex. npm) fail if the version points to a latest
      version?<br>
    </p>
    <p><span style="white-space: pre-wrap">
</span></p>
    <blockquote type="cite" cite="mid:84c9eee86cd0a378dcfbcbcac297d3a24f2424ad.camel@linuxfoundation.org">
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">Put another way, could one of these SRC_URIs map to multiple
different
combinations of underlying component versions?
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
If you mean the extracted SRC_URI for a single dependency from the
dependency specification file (ex. npm-shrinkwrap.json) it could use
special URLs to map to the latest version. But this is a missus of
the dependency specification file and could be detected. The tools
generate files with fixed versions always because a floating version
with a fixed checksum make no senses.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Even if it shouldn't happen, we need to detect and error for this case
as it would become very problematic for us.</pre>
    </blockquote>
    <p>Okay. Should we disallow a dynamic version for package manager
      downloads generally or do you see a reasonable use case?<br>
    </p>
    <p><span style="white-space: pre-wrap">
</span></p>
    <blockquote type="cite" cite="mid:84c9eee86cd0a378dcfbcbcac297d3a24f2424ad.camel@linuxfoundation.org">
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">Our existing method effectively hardcodes/expands the lock file
into
extended SRC_URI entries which makes the specific versions and
components really clear. This change abstracts that away into the
fetcher and makes it opaque to the user, and much harder for code
like
the archiver/license/spdx code to fine/handle.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
Really? Let's use the crate fetcher as an example. At the moment the
cargo-update-recipe-crates class extract the URI and checksum from
the Cargo.lock. The class ignores the licenses and they leads to
missing licenses in the recipe. The spdx files contains bitbake
specific fetcher URLs only which are unknown outside of bitbake.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I guess what I'm trying to say is that people generally easily
understand the explicit expanded urls. Whilst that class does ignore
license handling, the hope was that it would get added, it is certainly
possible to fix that.</pre>
    </blockquote>
    <p>I will check how complicated it is to extract the license
      information from the package registries.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:84c9eee86cd0a378dcfbcbcac297d3a24f2424ad.camel@linuxfoundation.org">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">&nbsp;I also thought it would make sense to generate recipes from the
dependency specification files and therefore worked on the recipetool
previous. But it looks like the tool isn't really used and I'm afraid
nobody will use the recipe to fix dependencies. In most cases it is
easy to update a dependency in the native tooling and only provide an
updated dependency specification file.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I think people have wanted a single simple command to translate the
specification file into our recipe format to update the recipe. For
various reasons people didn't seem to find the recipetool approach was
working and created the task workflow based one. There are pros and
cons to both and I don't have a strong preference. I would like to see
something which makes it clear to users what is going on though and is
simple to use.

People do intuitively understand a .inc file with a list of urls in it.
There are challenges in updating it.

This other approach is not as intuitive as everything is abstracted out
of sight.

One thing for example which worries me is how are the license fields in
the recipe going to be updated?

Currently, if we teach the class, it can set LICENSE variables
appropriately. With the new approach, you don't know the licenses until
after unpack has run. Yes it can write it into the SPDX, but it won't
work for something like the layer index or forms of analysis which
don't build things.

This does also extend to vulnerability analysis since we can't know
what is in a given recipe without actually unpacking it. For example we
could know crate XXX at version YYY has a CVE but we can't tell if a
recipe uses that crate until after do_unpack, or at least not without
expandurl.</pre>
    </blockquote>
    <p>The main question is if the meta data should contain all
      information. If yes, we shouldn't allow any fetcher which requires
      an external source. This should include the gitsm fetcher and we
      should replace the single SRC_URI with multiple git SRC_URIs.<br>
      <br>
      We can go even further and forbid specific package manager
      fetchers and use plain https or git SRC_URIs. The python and
      go-vendor fetcher use this approach.<br>
      <br>
      Alternative we allow dependency fetchers and require that the meta
      data be always used via bitbake. In this case we could extend the
      meta data via the fetcher.<br>
      <br>
      In both cases it is possible to produce the same meta data. It
      doesn't matter if we use recipetool, devtool, bbclasses or
      fetcher. In any case we could resolve the SRC_URIs, checksums or
      srcrev from a file. The license information could be fetched from
      the package repositories without integrity checks or could be
      extracted from the individual package description file inside the
      downloaded sources (ex. npm). We should skip the license detection
      from license files for now because they generate manual work and
      could be discuses later.<br>
      <br>
      The recipe approach has the advantage that it uses fixed licenses
      and that license changes could be (theoretical) reviewed during
      recipe update. In contrast the fetcher approach reduces the update
      procedure to a simple file rename or SRCREV update (ex. gitsm).
      Furthermore, the user could simply place a file beside the recipe
      to update the dependencies. Could we realize the same via devtool
      integration and a patch?<br>
      <br>
      We have different solutions between the languages (ex. npmsw vs
      crate vs pypi) and even inside the languages (ex. go-vendor vs
      gomod). I would like to unify the dependency support. It doesn't
      matter if we decide to use the bitbake fetcher or a bitbake /
      devtool command for the dependency and license resolution.<br>
      <span style="white-space: pre-wrap">
</span></p>
    <blockquote type="cite" cite="mid:84c9eee86cd0a378dcfbcbcac297d3a24f2424ad.camel@linuxfoundation.org">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">&nbsp;I have a WIP to integrate the the dependencies into the spdx . This
uses the expanded_urldata / implicit_urldata function to add the
dependencies to the process list of archiver and spdx.
&nbsp;
<a class="moz-txt-link-freetext" href="https://github.com/weidmueller/poky/tree/feature/dependency-fetcher">https://github.com/weidmueller/poky/tree/feature/dependency-fetcher</a>

Regarding the license we could migrate the functionality from
recipetool into a class and detect the licenses at build time.
Theoretically the fetcher could fetch the license from the package
manager repository but we have to trust the repository because we
have no checksum to detect changes. Maybe we could integrate tools
like Syft or ScanCode to detect the licenses at build time. At the
moment the best solution is to make sure that the SBOM contains the
name and version of the dependencies and let other tools handle the
license via SBOM for now. Therefore I propose a common scheme to
define the dependency name (dn) and version (dv) in the SRC_URI.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
We could compare what licenses the package manager is showing us with
what is in the recipe and error if different. There would then need to
be a command to update the licenses in the recipe (in much the way urls
currently get updated).
</pre>
    </blockquote>
    <p>Either we request the licenses from the package manager during
      package update or during fetch. I wouldn't do both. Instead I
      would analyze the the license file during build and compare the
      detected license with the recipe or fetcher generated licenses.
      But the license detection from files is an other topic and I would
      like to postpone it for now.<br>
      <span style="white-space: pre-wrap">

</span></p>
    <blockquote type="cite" cite="mid:84c9eee86cd0a378dcfbcbcac297d3a24f2424ad.camel@linuxfoundation.org">
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">&nbsp;
I noticed that any fetcher operation has to first expand the lock
file
using a temporary directory.
&nbsp;
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">&nbsp;I follow gitsm and open for suggestions. The expand happens only
once per fetcher object. The sub fechter object is saved in the proxy
variable.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
That fetcher object has to be recreated in every task or task context
using the fetcher.</pre>
    </blockquote>
    <p>Okay. In this case it makes sense to cache the resolved URIs.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:84c9eee86cd0a378dcfbcbcac297d3a24f2424ad.camel@linuxfoundation.org">
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">You're using DL_DIR for that which I
suspect isn't a great idea for tmp files.
&nbsp;
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">&nbsp;Take over from gitsm.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Probably not the best fetcher and I'd say gitsm should be fixed.</pre>
    </blockquote>
    <p>I don't see a reason why the gitsm fetcher shouldn't handled like
      the other dependency fetcher. We could update the handler after we
      have a decision for the dependency fetchers.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:84c9eee86cd0a378dcfbcbcac297d3a24f2424ad.camel@linuxfoundation.org">
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">&nbsp;In many cases that will work
fine but it is a bit of a performance overhead.

I did start wondering if we should cache the lock files in a subdir
of
DL_DIR to help performance and also give some extra assurance about
changing content.
&nbsp;
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">&nbsp;This would be possible. I assume the best would be another sub
SRC_URI to avoid code duplication for the locking and change
detection.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Probably, I did wonder if the mixin could cover that
abstraction/caching.</pre>
    </blockquote>
    <p>That should be possible.<br>
      <span style="white-space: pre-wrap">

</span></p>
    <blockquote type="cite" cite="mid:84c9eee86cd0a378dcfbcbcac297d3a24f2424ad.camel@linuxfoundation.org">
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">The url scheme is clever but also has a potential risk in that you
can't really pass parameters to both the top level fetcher and the
underlying one. I'm worried that is going to bite us further down
the
line.
&nbsp;
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">&nbsp;
At the moment I don't see a real problem but maybe you are right. The
existing language specific fetcher use fixed paths for there
downloads.
&nbsp;
&nbsp;What do you propose? Should the fetcher skip the unpack of the
source or should we introduce a sub fetcher which uses the download
from an other SRC_URI entry. The two entries could be linked via the
name parameter. This approach could be combined with your suggestion
above. The new fetcher will unpack a lock file from an other
(default) download.
&nbsp;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">I'm not really sure what is best right now. I'm trying to spell out the
pros/cons of what is going on here in the hope it encourages others to
give feedback as well. I agree there isn't a problem right now but I
worry there soon will be by mixing two things together like this. The
way we handle git protocol does cause us friction with other urls
schemes already.</pre>
    </blockquote>
    <p>The dependency fetcher could simple skip the unpack. In this case
      the user needs to use a variable to pass the same URL to the git
      and dependency fetcher or we could provide a python function to
      generate two SRC_URI with the same base URL.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:84c9eee86cd0a378dcfbcbcac297d3a24f2424ad.camel@linuxfoundation.org">
      <blockquote type="cite">
        <blockquote type="cite">
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">= Open questions

* Where should we download dependencies?
** Should we use a folder per fetcher (ex. git and npm)?
** Should we use the main folder (ex. crate)?
** Should we translate the name into folder (ex. gomod)?
** Should we integrate the name into the filename (ex. git)?
&nbsp;
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">&nbsp;
DL_DIR is meant to be a complete cache of the source so it would
need
to be downloaded there. Given it maps to the other fetchers, the
existing cache mechanisms likely work for these just fine, the open
question is on whether the lock/spec files should be cached after
extraction.
&nbsp;
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">&nbsp;
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
      <pre wrap="" class="moz-quote-pre">
That makes more sense. The layout is partially legacy. The wget and
local fetchers were first and hence go directly into DL_DIR. git/svn
were separated out into their own directories with a plan to have a
directory per fetcher. That didn't always work out with each newer
fetcher. Each fetcher does have to handle a unique naming of its urls
as only the specific fetcher can know all the urls parameters and which
ones affect the output vs which ones don't.</pre>
    </blockquote>
    This doesn't explain why the npm but not the gomod and crate fetcher
    use a sub folder. All fetchers are based on the wget fetcher.<br>
    <br>
    <blockquote type="cite" cite="mid:84c9eee86cd0a378dcfbcbcac297d3a24f2424ad.camel@linuxfoundation.org">
      <blockquote type="cite">
        <blockquote type="cite">
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">* Where should we unpack the dependencies?
** Should we use a folder inside the parent folder (ex.
node_modules)?
** Should we use a fixed folder inside unpackdir
&nbsp;&nbsp; (ex. go/pkg/mod/cache/download and cargo_home/bitbake)?
&nbsp;
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">&nbsp;
This likely depends on the fetcher as the different mechanisms will
have different expectations about how they should be extracted (as
npm/etc. would).
&nbsp;
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">&nbsp;
It depends on the fetcher but the fetcher could use the same
approach. At the moment every fetcher use a different approach. The
crate fetcher use a fixed value. The gomod fetcher uses a variable
(GO_MOD_CACHE_DIR) and the npm fetcher uses a parameter (destsuffix).
Furthermore the gomod fetcher override the common subdir parameter.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I think we really need to standardise that if we can. Each new fetcher
has claimed a certain approach is effectively required by the package
manager.</pre>
    </blockquote>
    <p>What would be your desired solution? Is the variable okay or do
      you prefer a self contain SRC_URI?<br>
      <span style="white-space: pre-wrap">

</span></p>
    <blockquote type="cite" cite="mid:84c9eee86cd0a378dcfbcbcac297d3a24f2424ad.camel@linuxfoundation.org">
      <blockquote type="cite">
        <blockquote type="cite">
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">* How should we treat archives for package manager caches?
** Should we unpack the archives to support patching (ex. npm)?
** Should we copy the packed archive to avoid unpacking and
packaging
&nbsp;&nbsp; (ex. gomod)?
&nbsp;
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">&nbsp;
If there are archives left after do_unpack, which task is going to
unpack those? Are we expecting the build process in
configure/compile
to decompress them? Would those management tools accept things if
they
were extracted earlier? &quot;unpack&quot; would be the correct time to do it
but
I can see this getting into conflict with the package manager :/.
&nbsp;
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">&nbsp;
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
      <pre wrap="" class="moz-quote-pre">
This is a challenge. Can we handle the unpacking with the package
manager as a specific step or does it have to be combined with other
steps like configure/compile?
</pre>
    </blockquote>
    <p>It looks like this is possible:<br>
      cargo fetch<br>
      go mod vendor<br>
      npm install<br>
      <br>
      I suspect you're thinking about using the package manager in
      do_unpack to unpack the archives and patch the unpacked archives
      afterwards?<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:84c9eee86cd0a378dcfbcbcac297d3a24f2424ad.camel@linuxfoundation.org">
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">I did wonder if patches 1-5 of this series could
be merged separately too as they look reasonable regardless of the
rest
of the series?
&nbsp;
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">&nbsp;
Sure. Should I resend the patches as separate series?
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Yes please, that would then let us remove the bits we can easily
review/sort and focus on this other part.</pre>
    </blockquote>
    <p>Done.<br>
      <br>
      I will also resend the go h1 checksum commit separate because it
      could be useful for the gomod fetcher.<br>
      <br>
      Should I also move the dn / dv parameter patches to a separate
      series because it could be useful without the dependency fetcher.
      I could add the parameters to the fetchers in a backward
      compatible way.<br>
      <br>
      Regards<br>
      &nbsp; Stefan<br>
      <br>
    </p>
  </body>
</html>

--------------iOsm0RuHtrj8STXr7PcZg1a3--

