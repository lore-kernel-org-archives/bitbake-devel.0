Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98CCC83F1B
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 14:15:12 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.69])
 by mx.groups.io with SMTP id smtpd.web11.79079.1752502503117511801
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 14 Jul 2025 07:15:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=jxM8TdAT;
 spf=pass (domain: cherry.de, ip: 52.101.84.69, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rioxF+hxFZ+kmQ6VByjZuPBc0yyfvH1suWY2petEdVct4FiIljPmZXYUa99yV0L5GpE/NW58KV9G6GHAEYDkPgu0d/kf909WKhI2ODrwz2HP2jJDNx2dmml9/51Be7/oR4fFRLuHRFkGULTDykoEcckAOqZT92eqm+mjwVOitRe3zlblAxIEqfhmb4kNa2UMeL+YtSjbOnEVArOY92ekJ3N8H6WBjk6P44nSg0pX/JWGh4Bg6/ratCTpSFPG3sHWnsCVkTxfqXsbBDMFbMyFPMILl86aD6n7ilD8RwNuEY02tf4MqDLE+QObOOPDC3MLVvkEyNFzTXVSnaqcaTs6MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hIoOae+e2ZcMjiYWGLuu9IWdNMn970hUdjPo8Rcc/aQ=;
 b=MOklmB7PA3S6cOIkABbHhscvG9PcAmZrkXGNHATWC5VZLKM55cIHx2hGOEiK+HWgW3kQeVro9g0c4S+7Qj+7vQNbsUmP9O8xmcdIeTMmHziZ559kCYC/ef+tHPP5Vt6XYTDm88hApel16uYw3byhi8OFrQX+TtAwVZ+r/2y6m3AqiG5R9fR2bpcruV1xnCzObGHvGaKaPJYIb5TRb/O9JF95cDtla8bEbQu9p5B28yuiZXBDTvqmr0NtlVz+zKWWFDaqg3LsQv0PQo21N9x1bA8boeZIJeg5xCqOvdcxqImTqFazyHSUEZWWPeJYsx8MZk3dcxZ86f7rGAb761hQsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIoOae+e2ZcMjiYWGLuu9IWdNMn970hUdjPo8Rcc/aQ=;
 b=jxM8TdATrvM8RWbaUlPAwyGt5Qe9C+5EJqXa1GUZI+xx70UW43jCkFP/nQvJsGw07Br6NO/D43QyurZmJR6jys8lJf5oUPf3NTZel4hTaCFmOsMiYD1u04s+zZMZVxX33hXH9tsV/UfoeRgaaiOu9x/qd2NpwYiHuKMZg499AsE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 14:14:58 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 14:14:58 +0000
Message-ID: <3b459a3e-68f0-483c-942d-c5debf464414@cherry.de>
Date: Mon, 14 Jul 2025 16:14:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [docs] [PATCH v2] Mention existence of three supported "classes"
 directories
To: rpjday@crashcourse.ca, YP docs mailing list <docs@lists.yoctoproject.org>
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
References: <c5f80e07-16fe-d9fa-b3e5-a8a6b1506278@crashcourse.ca>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <c5f80e07-16fe-d9fa-b3e5-a8a6b1506278@crashcourse.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0068.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::45) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB9186:EE_
X-MS-Office365-Filtering-Correlation-Id: 10a3599c-682b-4bda-8a96-08ddc2e0d07d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?S3FCbzRrMUFrWFgvdW5ucG9mYkExbmUxdTIwU3loVGFZUlJhT1FLbnAxNW5w?=
 =?utf-8?B?OGdVaFhneEswL2hPeDUvSXRXYzFmV1dyaGJHenV2YWpjYklEOU1kTlZZMVVr?=
 =?utf-8?B?L29iOSs1c2N0UFRjcXU2c2grUU5ubjdxNkhnTVUzVy9ZMEg1TWVuTTRiSGpM?=
 =?utf-8?B?bGo3bHFtb25rNXhLQWFMWkd2S0d0My96SHNNak5NVDY3UkIwbi83cGZ5dW1X?=
 =?utf-8?B?VXZyWTBJWnpxaTRmVWRJbVBPdVR4UFVwYTBqVXNZVnVwbXdNYXhyR2tPNUFN?=
 =?utf-8?B?OEZ3YW45MVdCMDRiMDN1UTdmTmhvVDFyaGxtbjgzRzA4MjdUVEdJdldRemVu?=
 =?utf-8?B?cUFRQjZTRFVoMnlFZXM1dWcyNElEcDJBQ214NnU4V28wWitHazZ6MlUwOExD?=
 =?utf-8?B?WHlJcmlJWHlRSm9vMStsUVo0Tit6OGRMZ3JUQllBT1hHSlFYeWloakZoQVY4?=
 =?utf-8?B?clM1ZDdLODgwUUE0M0t3SmFUb1YxMS9xRmxTanRxaXp0VGFUR1BldHA2K3hG?=
 =?utf-8?B?TUhoMGpUQ2JJaHVEdW5RNTdoS1pna2lIQjAyR3F2UkV6Nm0wZDRxSVNVMXdY?=
 =?utf-8?B?eFJCOWVtM0RuVGJVTENMVjVWVW1zelRZSndLYjhpWUtVaHJibDZoMldYN0lQ?=
 =?utf-8?B?VC9JZEF3YzREZ00zUlRZbERGallpLzdzeStlZnFKTTNCWVpnQUhKbUhIdGti?=
 =?utf-8?B?T2VFMXRYQkdwU2ZiWEQxRkI5UkNYcmR4S2RvMlJSUVNIbkIyVktDYTY1aldh?=
 =?utf-8?B?eVA1cFJEYWFBeE1vc0dvMzFSejA2Qld1ZnVROUFyTTZDL1QzMGE5eHpDS3Aw?=
 =?utf-8?B?WjBhYVQ2ZFVRQzFCTGFsMGZvOFpjS24rQ3h2VHVKUW80ZVo2ci9MVnB0dFVt?=
 =?utf-8?B?RmJObFdKcXJMTHFSbDYwREFiU1VjbU5rUnZGV2dROTM2Z0NVYXNVQzhrTW9p?=
 =?utf-8?B?aG50aUI4N3FVRkpQZk9sK0VHWlNFYVpvSkxKTXZPeTdSTnlzaGFnbTU1VndI?=
 =?utf-8?B?emJPam13VEhWbjJ2T0xsNTZrWmd2RG0rQW1SZFVnZXI2akMwaCtpenozVVJD?=
 =?utf-8?B?WElqZWNyaHgyN1lHV0orQ1ZUalpHR0VGaWFRU3RCRlMwMlhiV3I2TnUvRHow?=
 =?utf-8?B?ZDVURHptdmhjSnNzZXRoaUVjVHl1SnB6RDA4VUVYcjd5dktsa3ZnWk5CWUx2?=
 =?utf-8?B?dmZZSERTQ1E0Nk1kL2F6OTR6Zk5ab1diUWMxbEkrbFhKZm9YUkIvdG5RcHJ0?=
 =?utf-8?B?NnRjc1RqYXV2d1htUnAzYXhxNWFXS0xNdTc3enVGTzQ4TExjdlZVeFNIaDNv?=
 =?utf-8?B?NzVNa0lydGV4ZllHWE1XOVFFRmhpbmtwY1lmMzJBb3BJQ2xoMnliK2dwZUpL?=
 =?utf-8?B?cm96c3ZxWDV2S0JGQVdQZC9icFFNRGZTbitWRFV4emZKUWt1K081QVJLQ0Zz?=
 =?utf-8?B?TDRsaWw4N1pzT292T3BaNzVlbHBJMWFqOHBjcFUvQUZacWRpVTNoTHd4elYz?=
 =?utf-8?B?MjlsNS9zdzBtZDhqRE5LVWFKYktWc0ltb2NnUjVIRGw3NUpVWWRZZkQxdDAv?=
 =?utf-8?B?SVFuNjVvNGE2aW5kN0NrV1YxKzJuQzNiNzNFWXdzM2o3anlkMkdVSWt1YnR2?=
 =?utf-8?B?UzhueGJ3Uy9IOUhMeDZiYVVVVVJJN2FKQmxrM0QyWDVFL3Z1enFFcjQ0T3Vj?=
 =?utf-8?B?cCt1RFFtejJ4bGpZN2pHVkJBdHBURlI2ODZNdFNlN1UyNlFQNTM1ZFRXWjM5?=
 =?utf-8?B?ZVp3Z3NVWWxGTUNXdk1vb1JHOUJJWUpXRHhOTkNSdTFiZVBJM1plU2t4R1Vz?=
 =?utf-8?B?Z1NscUN6R200eWgzZ1BxYVFPZmpsTGRIOGFJYU14UDJvcURaVHliUTJQVkdP?=
 =?utf-8?B?dzU0Q00vVERqbEgrMlFuWDVLYW9uN0hSYnlMSHZnTTIxZWc9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YnkwZ1JRaXNDeWx2N2g5ZWFSV1dtNGJvdHRGVk52aTZBRGNOU0plSGV2bFhJ?=
 =?utf-8?B?YW1LOGNzNldRUG9TTTlMWUEwM2RENkNkbUZvNERRWEFPdG1UVFQya3RBT050?=
 =?utf-8?B?bldkMGZOanFUNjBFOTdRVWg4M1hDeHN5YkJLeEg3QkE2NXpiejZzZkhjSmRv?=
 =?utf-8?B?NTJ4MXV0RGhjVURPSTVUQXJVOUdRWE5zcVJWVHUzRjVacEM3OFpGUEFjdWp1?=
 =?utf-8?B?bXBrQzVNeXRSMXg5L3pZS2ZkWS9PdmltVjFpOUtjRzNjd2h1VzZxQjRNdFJM?=
 =?utf-8?B?Y3JobFg0OEFBZUJMWjlaYXkrM2VaVnpvNDNGb0FsaFlEc1BCd2N0RXdWN1FT?=
 =?utf-8?B?LzlsTGhOT29PbThnRWdhVmFhUitNVnRIVUQ1cDNpZHArTHJpTkhHUTVyQ1F0?=
 =?utf-8?B?dHBDdVFBdS9BNDk2Q2JQaXRoamZPRUkrYnBOZFdvRGRHVExVSnpoZ05tTml3?=
 =?utf-8?B?Y2pwL2VVOXgwNUdLdVdnbUxybE1jL2MwenQvMmRDN1RpNkp5QXJmcXEzVEt6?=
 =?utf-8?B?Wit6eHJ6UGd2WitYaSt4OWp3YVc0enV2SWtNZlgzOGp1bEluMzdlTkhrT1Y1?=
 =?utf-8?B?WVNvaXJtK1BvdG5HOTRoaUxQb0lQZGcrM3AycEtyc1dVSUFCeFc3aDVobmhW?=
 =?utf-8?B?WlpYM1pMV1dtSlhETEx5aG5aU0VBZWhvWHFRdFlnZ2hNWjR1YlJncWk3ZSts?=
 =?utf-8?B?WE5ybWlHU2E1N3pVbFVVdnUwWVVKeXExbGZxZHp2c1VFYlN4TnJxd0lWRlMz?=
 =?utf-8?B?ZmNWVThraUZ6OUVVR0oyekNRbHJtRTJFM0tnY0VoU1pIdjdMemRYWnZuNVZC?=
 =?utf-8?B?NEdvZHJhejNoL20yM3NSeEY0dlJJRk1wMGxuUlViR2czckwyWTI5WGtwMmNY?=
 =?utf-8?B?c2hqL3B4WGxqSnNFenlYK0FwS3BSNE5FYTAvNU1PcHZWS2tYMU1RS1hrMFRt?=
 =?utf-8?B?czhnUGhyNXlqaDR1MTJJZk16dzB5T2Y3QXVJWmk2VS9OOHVnaHpxakJDcGtk?=
 =?utf-8?B?YVQ3eUNzdFRMblVZRjc0ZlZaV0pWQkUyVktDMVNXM0gxSzhTQjd5RDk0WlR0?=
 =?utf-8?B?bmM3M3RtNEoyYVhjbThsOGVyUUFIM292T3ZwWDZtUG1uZk5CbDNZNFhXR0g2?=
 =?utf-8?B?WG4zbXFaNUowWUtSQ0o3aThMZTlzS3JNK21JUFBVdHlmU00ydkR2eFFWZmtX?=
 =?utf-8?B?OWRNWXMwZ1RFQ3VwbThkUDQ1S1FZUjdMOFpzUVBrR0sweFcraU8wZGFwVlov?=
 =?utf-8?B?VmhhaURXNU1EMVVETG1VaHJUaTJrSGF5NWZ4Ny9MMHBoaTVVdFJ4bitNbkVx?=
 =?utf-8?B?eGc3dUVpVFQyVE1xQzkwU3k0RkV6V0FiWE1YWUg1VHRmQjY1eG1pSDh0RnZu?=
 =?utf-8?B?Y3RrZ09sbG5kTjdWTWV6eEoxMnhZOWJFSVdCMVNId2MwTGoxRUNidG9KNG1t?=
 =?utf-8?B?YXN2eWF6L2hzZEpDelluaUE0WUl3VGFJUlNpSGJNOTFNYmZLMGk4NXFpdGtL?=
 =?utf-8?B?cG5WbEhYdmxaUjJQZHYvRCtJVWo3U1FwdnBKcmRacXZWUXBYc1RJbnNJdW1E?=
 =?utf-8?B?SzRvTzNwYzBhTGdVazVzUEVXaTZCclFpM013UG1yT2xSd0xKZ3hveHIzc3B6?=
 =?utf-8?B?dm02QzZWcGRTanE4T2wxSUlZSjZVU3JBVSsrUnFEZkhkTlRYY21mZ0NuOVI2?=
 =?utf-8?B?bjBMcjRFYlBRK0hRNjk3R2VjZlplaGRWazlrYW1mQkpIS0hiR2Rwa1hXOTRQ?=
 =?utf-8?B?ellJRGJETS9rV1lkVWtFRVd5elZ1VDlxamhGUk05b1czRTNjQU81S2phcmt6?=
 =?utf-8?B?QUdzQTNHZzlYb2Urb0xDQ0pzTElhK1g1RmRKR3Z0NnE3QWJJREMwTzF1UXBT?=
 =?utf-8?B?MnNQVEJ4LzRZb0wweDZtK1huUFFEdXlxczhUMC8xaS8ydU9LZ0M1enVDYnJ3?=
 =?utf-8?B?QTRmVkEvOVFWMnZTMXQxWHFHd1NsQ3d4Tk5UdXZyYUROZmJ0SnVsVFZqbHo0?=
 =?utf-8?B?R0ZRb0c5V1lzS0k0SW1ycFdmMi9kbHJRR1VNb2tFRSs1SDJ6ZGxJVGRuNVQ5?=
 =?utf-8?B?Z3B2QnZ1a0ZUQUtpZ1BvSDVYODNVWEFKQzBIVVVzK053bUZ4WHBjU0JWVUNY?=
 =?utf-8?B?Q2NrOUZIeWsyK2tWbVd6akdNdnExdmMxMUNNRTV3VW1qdXpqSVJkZm5DUWFX?=
 =?utf-8?B?ZVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a3599c-682b-4bda-8a96-08ddc2e0d07d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 14:14:58.4016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IWl17vmNBlOUCIXaWOxCu/TX2gpsOVUpv2MM5OiV2O273fpeypbOoeuuiTwnZ2fih6Y4MoFh5UjTBxSO96RHPIVw/U8LB4YTvF7+mFcuXDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9186
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 14 Jul 2025 14:15:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17773

Hi Robert,

On 7/8/25 1:33 PM, Robert P. J. Day via lists.yoctoproject.org wrote:
> 
> Early in Section 1, mention that BitBake supports three related
> classes directories.
> 
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
> 
> ---
> 
>    fix typo in first submission
> 
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
> index 539bb62d8..d25f07ff9 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
> @@ -206,6 +206,18 @@ installing (empty by default) and packaging (empty by default). These
>   tasks are often overridden or extended by other classes added during the
>   project development process.
> 
> +.. note::
> +
> +   While BitBake comes with just the one ``base.bbclass`` file in the
> +   ``classes`` directory, it supports class files also being installed
> +   in related directories ``classes-global`` and ``classes-recipe`` and
> +   will automatically search all three directories for a selected class
> +   file.
> +
> +   This means that, in this documentation, when you see a reference to
> +   class files being in the ``classes`` directory, you can interpret that
> +   as meaning in any one of the above three directories.
> +

Maybe we can say a few words on when one is supposed to put a class in 
classes-recipe, classes-global or classes directory? Using the wording 
from YP docs, documentation/ref-manual/classes.rst probably is good enough?

Cheers,
Quentin

