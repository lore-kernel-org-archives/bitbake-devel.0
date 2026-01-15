Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B850D41174
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 11:36:33 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.61])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.33752.1768476985042879604
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Jan 2026 03:36:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=UVUfI8+N;
 spf=pass (domain: cherry.de, ip: 40.107.162.61, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KcZzjfC1JoWQElohs9WbSyZghCpLwxz67/7vUlPbaU3g9iZJkfol833R0ZDn2dbsYslf5u2DJCuiNC2QpdOcq+jeWWWmls4oVyabH7HXBHWDkT7ponM52BbydM+S1aN56IIAb1IUgQdaQF1oVZ/hhQoE9TOjV9io73xr85u1JkjZVfBOVMgO4VNeBMX2OLLNj4KoEmdQqAcCtyP5vnVcsvyVHaplwqadbflqiau/cdErs/MS0Ogs/L8huHaoblaRCcFVe8y6L1SIHvtlf/I3U/PVhkbMhRCLHi9nTeh2GokDOkSldhTUe8xHfNC5wz8KpOXtIBF/6H8WfkBe/locZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpdE3w3CZN0MuN/gEyoIIYOQ51aqVg6WalvCWmtw7B8=;
 b=K9/++bN3yOE+sr0m2RjA4jW2JGEBIGmwSIZJfOjdoHd+/PcZFSuTF/7nMSaTttvmppryL7akG/1dUvQgFlDaM0RO5ziHaR5UhPh2B2NbUBY4eZlpVxo+aIPs6dKttUluIbaMJYHfCspAfO6hDFdr2hG2yOTEffaL6eSpkckA54bvQ3GXb+J2GoPVjxzJ8v9PYFlLtDmpk+Np1e2MP5bnrinixI4d1s9mckw8lwI5gYd2pEP15mQYohxIBkYDWD7T90whJXkS2/zC+XIePgOy4kmv2q78/6Y5tCGLjDLZ4FRJVxpenymPfvB5+ORVDitkLrxYzqvtVVtz6i7Q5JBAHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpdE3w3CZN0MuN/gEyoIIYOQ51aqVg6WalvCWmtw7B8=;
 b=UVUfI8+NO6LGXyntWI+Ne45RHCE1uWhWePVHAEQyfIIkPNOu/qHzWxXKMiNvZxHn5KqoOPVYZBLLey+c1xeQ4mGe4j0LCWGB4XU9MfyiyLZGH2CUMwnGXSZaEgy4cVFVj6zKdaE6V2YoWx7jdrZrknv7D3qYWg3glfc2+bc67eY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AM9PR04MB8763.eurprd04.prod.outlook.com (2603:10a6:20b:40a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Thu, 15 Jan
 2026 11:36:20 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 11:36:20 +0000
Message-ID: <9c37cb33-8dbd-4377-9cc8-738a9787d2a7@cherry.de>
Date: Thu, 15 Jan 2026 12:36:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] doc: bitbake ch 2: use example of nginx
 to explain DEFAULT_PREFERENCE
To: rpjday@crashcourse.ca,
 BitBake developer list <bitbake-devel@lists.openembedded.org>
Cc: YP docs mailing list <docs@lists.yoctoproject.org>
References: <5113f81f-1b33-a4ac-f71d-432caf8e709a@crashcourse.ca>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <5113f81f-1b33-a4ac-f71d-432caf8e709a@crashcourse.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0255.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::18) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AM9PR04MB8763:EE_
X-MS-Office365-Filtering-Correlation-Id: 0af16fc9-2f2c-4e0b-4050-08de542a4daf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZkNKMFNvcnEvWWlOWTN0REpFdzFWbTl5VEsrOEZiYVRTQjVoeUxjeDJtNkZP?=
 =?utf-8?B?K1R2VUNUSDg3K3VpcG5YZzR6MzIvN0lTdjd3VTFXQVVHR2Q5aWNReHBYVFg1?=
 =?utf-8?B?MDlLdVAwNlphWmpUeGwxd0o2S0NwcWxqa1lJUnl4aThLQUd0QnBVVlhqT2ZJ?=
 =?utf-8?B?bnpYZ21WSzhiaE9iNE1yR01BOEhHWGdhaS9VMHAxMmwveE9DZEhyQXhPc1pD?=
 =?utf-8?B?OGxyMU5Ubk9GS0V6VmNvcWtGWnlIMExVMzU0MG5lb1Q3M3VxM3B6Qjd3TTM1?=
 =?utf-8?B?M3VsckdveFZXenBmVGhSa3Njbk9ZR1FwZzFNTnk0bjVFM1h1SS9pU2V5VHVk?=
 =?utf-8?B?aUZaYmhmN0hsK0RQNmhjT1JLdmpVV2FVbHdCWXpFcE1IcVFmMXV2NlNhWlJL?=
 =?utf-8?B?Ti8vTWpLQmlsR0NnbTBZOU9GR0pySHkwazVlZm96bHFDYkRmN0RCZFQ4NFla?=
 =?utf-8?B?YWhIS0pic2l5VXFxS3lTckRLSWFrTlUrMWVpSlFQdFJzRWhBUm1RVUVLbVNn?=
 =?utf-8?B?bmQ3SGlNcTIrWWwwRFNGazFSYXZSUG1XSUw2aFhPc2ZrdG1Yd2F3M1p1aDQr?=
 =?utf-8?B?bGZjRnkrUUdUK0N2RlBiSTZHamdQSkQ4ZW4zU3Zsa015cjIrQ08yYXVpRStB?=
 =?utf-8?B?Y0xKTGRKeVFERGtaVUZnUzFjZWVLOVZGUVdhSjR1L2dEcElvV0xReVhmUUNJ?=
 =?utf-8?B?YTFFblVFQ2hFQVRpRjcxSHR0Zy9VTVZIWHpZYnpqQ3owd2VRRi9PYWY3bm9I?=
 =?utf-8?B?dGgvM2hzVlgyWUdRbU9lZjFHNkdWcjdHRG80emRJRnQ2bmlqSytqbW0zMnpu?=
 =?utf-8?B?RUlzQW5KL1djdGhhUmUxQUZHN1BjWVRvRjk2aUM0RnRzT05zcUtTeS9TUlZl?=
 =?utf-8?B?THhLTFZub0s0SUc5M2dGbEVZRjNaYVB2TXQzMGhldlBEeWVIZzlvK3NVLzJ3?=
 =?utf-8?B?WVRCNHptNjE4MnpoL3YyWVpMR1U3djlFU3NZSlE2am1IV01yUDN6Um13S3VH?=
 =?utf-8?B?anI3RzJyczJRazJnR3g0ekJmdS9Bd29LZEJJaUUwT1hBUmpZRGwzcGZ5NUpq?=
 =?utf-8?B?L0p1K2JteTJUU2ZLdlJ1eFM4ajVMTnpseE56akpTQ3NSTXF5cVpzSkxIbnJC?=
 =?utf-8?B?Yy92MFhLWmxtVVJMS2w2SWFwNGd3MzM1OGtHWFZGTE1TK254ZFVDYXg5NUdG?=
 =?utf-8?B?OFJkTTlrbzcxUTNlZUlvU0JWd0dLTDYwTlRYNko3eFZLYTFaMlJYNEpXcjN4?=
 =?utf-8?B?VDFQTDB0azBuQUhoR3dBM3llb1VKUFFYTWpjM2w2QW0wRGx1V1RzVEdQTjA3?=
 =?utf-8?B?YmN0SFNGdnZUdXdvZVRhWmRiRTNraHNJL1ptYkJMNU9VNXluZzdQTnVBNTM0?=
 =?utf-8?B?SzhXNG1MOGJHS2k1ZkxBSmRnNkFMb2FKUHM4SnltNzFwc25Wc1VBZFg5cFRU?=
 =?utf-8?B?SEtMOUpxK3Bna1JQS0VZWjhhR3FxOWVhd1RKdFlEaDZ2dE1WSlJSNVk1VmJR?=
 =?utf-8?B?aEhCK0c4UVJKdjBrWWxVb1locjBlVkw0VGI3dHg1YXhTVDVkZ1JqdERzWnRL?=
 =?utf-8?B?aHk5WFFwM2tuMTBqWWhnV1EzUThxM1Rxc2k0akltc2hDRlM3cnBpTzQyaVA2?=
 =?utf-8?B?aG5IVE94WHJ6QUtuR1p0VkpUNlU0VjdHeEIzbllic1VCMjluWFpibmh3WmtN?=
 =?utf-8?B?MzVhT3hWVnM0Nm02YjQwYW9ZNnRkZlR3a2NKOVYzL3JUQTBkMGJCM1dib2cy?=
 =?utf-8?B?N29aWkFGeXRGSGowcFZ4czBtQjFUNnhWVGJKbnFib29rRlRTQnhDbG42RHgz?=
 =?utf-8?B?UW05aHRveTErdVhIU3VnOU5IRmxoK3VZdHdFT1JhL1pzcElaUjFLNVpzdExD?=
 =?utf-8?B?bC9WV1hHUjg4TXpNejVKU2VONmI3UnlnYng3S04wQ3hPUnd2R1AxWEd4Y1E3?=
 =?utf-8?B?RjM4dTZiVGtkdUFUMzVjMlB0T3FRcDlIa2hBd3RHRWN1ZTIvRkpoNEQraXdT?=
 =?utf-8?B?VTVqRFg4ZnZnM1l5a25UcUcwbmJzdThhUVJpelEwQTlKc1hGZDc0bEZRRC9B?=
 =?utf-8?B?S3lONjQybloxcGNzanEzOWNsK3dNTUh6ZldRemRrVG80NFB4RW1aQjVuMGxt?=
 =?utf-8?Q?Hm2Q=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V0NYMUhnTXVZdWdCWkRadUpKNXNQcE5BNSt3bVlXVUpWWmxmQnZqLy9HWEc0?=
 =?utf-8?B?YzFLRzdxV3pjWDBMQk96dGZUMUk4OHQvN0J3T2RjV0RmVEZCNktGcFMrMXNZ?=
 =?utf-8?B?SlRVWmtKSDRCaG52Sk5GcGtTbXJDMUVWT3NEK09mS1A1NUt0a3RoWDBVN1dN?=
 =?utf-8?B?b08yaEZKSElRYks3dXpWblBIaGtzQTZOaHJJUXluSCswQ3RkdFpQakxITkVh?=
 =?utf-8?B?QjR0VTJ4Q3Q1azhZRU5nYUQ0TGh6cFI2SHIvK2QxOCtKdU5xRE9PUFEzYXNP?=
 =?utf-8?B?ZjF1dWY0MDZ1bW42QTBPbFEraVZTVDFLT1I4T0lwVmtmbnBJNTlLLzFmSXZt?=
 =?utf-8?B?RmNvTzJzN1IwSWpaL1lueGxUeGpJVzMvQVM1cDg1U1FkUTN1eDh4RVh0Lzlu?=
 =?utf-8?B?TURRY0QxUnNsSjA2UzNiYkxpRlJFVmdSZmt2cmE2T0Jwd1FkUDJ0T1ZDTE9s?=
 =?utf-8?B?WmJyYjlMWkhGUnAwM3BKblZQRkpOV25xQ2VENWtSL1B0WS9vQzdVWFVjVGxJ?=
 =?utf-8?B?TExmcVFOZWc4R3NHWW96SFIzOGREUVNpVW9pdzkxdkZoSkE2Z0pCa3VQU2o3?=
 =?utf-8?B?cXdmSGtHNVY4LzBqdlVISTdreFB1N0dmV1M1SzgvREZJSWtXMXZjd0plTWNx?=
 =?utf-8?B?cVcyejI2aEg2UmJRZzhIbi8vQUNRZlo2M3VrQnlDQ2ZLRGNuUS96ckxPTVFN?=
 =?utf-8?B?bUlZTElxS3FGNFF0Qzd1UnBoTm1DZkxsOEJHWE8rdGh3YW9Wc0pyT3lLOTln?=
 =?utf-8?B?dEg4TVBuMmsyMTUzNndKcy9yU1RqZThCRFFBZFNaS0x0bzYxY3Q0ZTRVSG9m?=
 =?utf-8?B?a2RlVHl1TzQ4czV3UHhtSFYwVmFSR0wvbFdLUEpGTmtPKzFNRHNaMERoR2RL?=
 =?utf-8?B?TnFMM1htaUliNWxraUREOEZPVEVzRkRDZklDWUJENE5zVXNVOC9VU1h4bEdx?=
 =?utf-8?B?TXZwWC9vRG5rRnJjbmlGUFRzamlBZ0UzbGNWTzVVZVd0RFdGd04vU3ZMUi9T?=
 =?utf-8?B?VzZZcUd6SEdtRUJDRmM4U1d4dStkR2ZOVWRBM3p1WUk4RTRmTkd1QkF0S2RI?=
 =?utf-8?B?akJHZWdHYzdMNkpha2FWKzUwT0Znck5WUVk3cGlBMDlNZDdUZm5NWS9NYU91?=
 =?utf-8?B?anpCQ1I1RktyT0ZTTi9mK1dCbUtqOWNWTTdjSjZKZ2tYTHJvWC9uUUtHZXlB?=
 =?utf-8?B?YVlaTnZQQlBCYmZBNXVDaDVYZzhyaVhPL0lYNDI3K09yQU9kME4veE9QNnpM?=
 =?utf-8?B?MUo1Uy9yOS9SRmZuYVN5UlVyMEhEOGZzNWNsVjV5amFIbERlcHFqRlArL0Vv?=
 =?utf-8?B?Z2ZCV1RibFZmcnRLTy9SZkQxckJHcmUwRUhndVFLRGtKQm5JVVg1aHhDWjRY?=
 =?utf-8?B?TXFNSDZheHZnczY2K3A1UWNQMFlnd2oyT0M0VG1RZU50Rmdsb3Bmby94TVc1?=
 =?utf-8?B?d3IvZjA1KzhJSlN5dERYdTFuTGpnSE1uTW5GcDYzZHB6UkNrVGt6U3pPbjhP?=
 =?utf-8?B?OG9nV3owY0ZncGc1WnBIK3EyZDVrYnZvMTZDcHVJQWZ1S0locHpjSm9neEdH?=
 =?utf-8?B?VUV3Q3dSVDYxOFdpWDdYeERTVU15Y0EzQ0M3dmcwc2R4MkRyWlJXTFV5Ty9O?=
 =?utf-8?B?NU5HS2hVdUtvejdIeE55SU9xd09QOEVZYXZSMW9tMUdNaWEwbU90UDc5NFQ4?=
 =?utf-8?B?UnZaSnhISVdROFY1K0xBcm8zWms2dlFWakJ1RTQ1ZVNyd1diK1RMTjJSK1Z6?=
 =?utf-8?B?dzBobU9yNWcyTkR4eHVjQnhZNjU5TFFlWGRZZStMWnVTdHZGcVdqdGRvRWhJ?=
 =?utf-8?B?a0tvdHBDT2p4U29rS3p0aHJOSzN2U0NOK2xzZHZzeFNjZHBWSnRhM3NERDQ5?=
 =?utf-8?B?cXo4RjZYTTlldGtJR3h0NGNMUE1XRDM1M0tTdVlhTHZEaXk0WCs2QVlod0Z3?=
 =?utf-8?B?MkFVTlJ5ZXlsYmJhRWtEbjN1R2J2OEQ2dkFlaGJTZXE1TVJ2MDlqV0JvKy9D?=
 =?utf-8?B?dUR6U2w4dU9lamw3Ky80RlNYdUZEQ09laENpMUVvcnlVVENyemo1eDd4Tm5y?=
 =?utf-8?B?ZzcvaWUvbndCWEZINUQxZ1Z1c1FBZy9YMGZIWDFCQlFYcWlZdDRQdVgwL1l4?=
 =?utf-8?B?T2c3dE04MEIrUU92UGxxR2xNOWtkY2hFd2ZTZitseDlEdFdtaDlSMVpiR2Ex?=
 =?utf-8?B?b2dPY3FKcVNDTStuK0MvSmVpblB1R09mdFExTVU4U3k0NzFTY0thOGk0KzNp?=
 =?utf-8?B?WnBJUDJQVTJ6RnhDbmczZmpscW8yWG5jSGU3S1NzSEl4RXVLNWNxbU95aS9y?=
 =?utf-8?B?MmUrWnFzR1oyR0dsQWRIOGxDa21aKzk1ZGVYaTdsZ1FsZUM4QlZxZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af16fc9-2f2c-4e0b-4050-08de542a4daf
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 11:36:20.2761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SfHgDyQGSk/WIbwCg+/msuXuGC04iBBWN1QUzcyL0OJnAJMbMBHqpmDQmvMi2fNcyV7DXJ8Tw7/8jm/XHKlK+fu7Z+z5IajVcFY54gVhJi4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8763
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 11:36:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18772

Hi Robert,

On 1/8/26 11:08 PM, Robert P. J. Day via lists.openembedded.org wrote:
> 
> At the moment, the section on explaining DEFAULT_PREFERENCE uses an
> example of busybox, which does not even use this feature anymore.
> Replace this with an example using "nginx", which does.
> 
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
> 
> ---
> 
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
> index d407f59c0..1638a8f5c 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
> @@ -337,21 +337,22 @@ file that BitBake parses, you can change that preference::
> 
>   .. note::
> 
> -   It is common for a recipe to provide two versions -- a stable,
> -   numbered (and preferred) version, and a version that is automatically
> -   checked out from a source code repository that is considered more
> -   "bleeding edge" but can be selected only explicitly.
> -
> -   For example, in the OpenEmbedded codebase, there is a standard,
> -   versioned recipe file for BusyBox, ``busybox_1.22.1.bb``, but there
> -   is also a Git-based version, ``busybox_git.bb``, which explicitly
> -   contains the line ::
> -
> -     DEFAULT_PREFERENCE = "-1"
> -
> -   to ensure that the
> -   numbered, stable version is always preferred unless the developer
> -   selects otherwise.
> +   It is not uncommon for a given recipe to provide more than one
> +   version -- a stable (and preferred) version that should be selected
> +   by default, and a newer, development or "bleeding edge" version that
> +   will be selected only explicitly by the developer.
> +
> +   For example, at the moment, in the OpenEmbedded codebase, there are

While reading this, I thought you meant oe-core. It is actually 
meta-openembedded, please make this more specific (and maybe consider 
adding a link to the layer?).

> +   two versions of the ``nginx`` webserver: a stable "1.28.0" version
> +   that would be selected by default, and a newer "1.29.1" development
> +   version that a developer would need to choose explicitly.
> +
> +   This can be seen based on this snippet from the ``nginx`` 1.29.1
> +   recipe file::
> +

I would like to start making all code-blocks specify a language (I had 
the thought yesterday so to be taken with a grain of salt :) ). Here it 
is BitBake but there's no lexer, so I was thinking about using "none" 
(instead of "text" which I would prefer to keep for actual quote text or 
command line output without the prompt), so that the day we have a 
BitBake lexer (anyone volunteering :) ?) we can look through the docs 
for none and replace easily the ones that are BitBake code blocks.

.. code-block:: none

As for this section (not modified in this patch), I'm not entirely sure 
"BitBake defaults to selecting the most recent version" is actually 
true. I'm wondering whether the layer's priority plays a role or not 
here? Something to investigate.

Cheers,
Quentin

