Return-Path: <kweihmann@outlook.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA84FC433F5
	for <webhook@archiver.kernel.org>; Mon,  6 Dec 2021 16:50:35 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.92.89.83])
 by mx.groups.io with SMTP id smtpd.web08.54392.1638809434970297325
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 06 Dec 2021 08:50:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@outlook.com header.s=selector1 header.b=lQA6THlg;
 spf=pass (domain: outlook.com, ip: 40.92.89.83,
 mailfrom: kweihmann@outlook.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfxAlzX5TQj+eHvL7H4wVzzYESa4F0Wpv1ay1SAUuvs4yg4SrpePKijbeD3E+Z3URyB532oxJVmDXA/k6gnz0F3VnJh9qjdrzSzlxQ0yob4njMVm+0V0tJKL2q9vARvLHT/iP41Lm1G9nNfzL5WDmd5jrMLDAvKEVuovU/T/n7kX00M21hHAT0LJYlwfVqnWe9YjQctCukj4zJHvgY5hos5EWi/kBEHQK84F197YpvklABbpAhbwT3PzTOxUzuiOw6zfMHe4c17C4vxUz1cOUC9EX+R5huw6Vmzb7H4KGRWIMza5qXC1UkdQb3KPOO926ygld+MkyhAbywikmrFFUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rk8hhxwpfnUfxYvOJqB2S8jD9owzHxcUrpub1mDRA2Y=;
 b=gg4caGdaenMpAC0mqLT92SrsJe6lzoeO1pfheFSi/Z+Hrx/VDJsiFEagovjxUdXOkC0kMpRR9UMbZvK1wR6p+PYcf0hcoORw3A05nheLdgzeYa3pUOtb/v0U3yKyKCw2wj9KI/YXi3MQfrijJtSllcVyNw+dVNGws+bbszevpTc+F/r6lam2hb6Y8ObnMRGnuSZkSvSl6czuazJnvTyPMmVLWd7mala/DQlfXJxd8QcJFAtu6P9Po7VTmsA7ki9c87DaU4RleMUrqPdOMgUMMyGQ/hJyLxq0zSm3kH3xsZ9JVywy6tiUYlHURJMhoQfJdPXj5l/bamdtd1xRiOwxZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rk8hhxwpfnUfxYvOJqB2S8jD9owzHxcUrpub1mDRA2Y=;
 b=lQA6THlgdJEJGA6Setw7JKnlcYW/TZizy9JsRiLd0lOBFuMblZoSzUEmfIL6LYlMdhPbzSR2vDLaSWxe31ikiKHyqqRxWyHPywrsd1525HghroJSc31Lplgej9KNgeP8ldOu7uGA0MtQRwVu1nwR+VK+eEQjLtH5DRO6qeDVuRYrE0zksx5LWEE1hljrnmAZyeKFu0Bj9cn22GinktZL3bWKY40kkO4oo1DQMHMNOj3s/yczkqStDtfJAeObuhcT4fMzGehv3rdtOnfGb/DGYNymCenQVaBUunC+AsLSg73VDjC7kzGqWR5xr8IaqI7xtokm2jGyDJQyVvaC4OZTOQ==
Received: from AM9PR09MB4642.eurprd09.prod.outlook.com (2603:10a6:20b:284::24)
 by AM9PR09MB4851.eurprd09.prod.outlook.com (2603:10a6:20b:2d4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Mon, 6 Dec
 2021 16:50:33 +0000
Received: from AM9PR09MB4642.eurprd09.prod.outlook.com
 ([fe80::782f:9964:348b:b2fa]) by AM9PR09MB4642.eurprd09.prod.outlook.com
 ([fe80::782f:9964:348b:b2fa%9]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 16:50:33 +0000
Subject: Re: [bitbake-devel] [PATCH] fetch2/wget: do not hardcode tarball
 compressors in version check
To: Alexander Kanavin <alex.kanavin@gmail.com>,
 bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
References: <20211206164119.4076119-1-alex@linutronix.de>
From: Konrad Weihmann <kweihmann@outlook.com>
Message-ID: 
 <AM9PR09MB46420E6720273B75BE7A8E7BA86D9@AM9PR09MB4642.eurprd09.prod.outlook.com>
Date: Mon, 6 Dec 2021 17:50:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211206164119.4076119-1-alex@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TMN: [WLRKFr17m2JFNZNXNw0dNCIEHa+1u+MgrFr55dWhJipGLwWInZODdF9CR6tD8eG+]
X-ClientProxiedBy: FR0P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::11) To AM9PR09MB4642.eurprd09.prod.outlook.com
 (2603:10a6:20b:284::24)
X-Microsoft-Original-Message-ID: 
 <9370b3a2-7fa7-edbd-b826-28530e937cef@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:3103:205c:200:bed3:df7f:f488:16a2]
 (2a02:3103:205c:200:bed3:df7f:f488:16a2) by
 FR0P281CA0089.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1e::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Mon, 6 Dec 2021 16:50:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce75e416-1dac-4125-1e1f-08d9b8d884cd
X-MS-TrafficTypeDiagnostic: AM9PR09MB4851:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Us43NbGmhVz4okeL09IvSqPZG8dTiiaZeDhJ2Yk2By/pLKgpaGvlSVXimWLBww14DwdKFMDGmvNw/D2OCwkHbkd5kyUx30VJhfBlvuiHNkFzAAotKRrZIgJ9YKTFfetrBBjhIGAHKcLVLypb+QMEt4+xdmp4a4wwYMUWSUk8wPaJ2kd8442GEY3x01gYumUnZp5hYYfB4Y4r1q6tQvurimZxgGLHsBV28RTeu35VprKgSNQyihOonIsU56xLRGBmHOA357nUP1C8SzAtfSD9YJWYFnZorpzkdl9hrPPknT6UWggaykfRDRhXm56lHAN1jpmqnGVmYdIiVYgDdlWxMTA85K3fEnqgQLYQzJ4gT/Zmo+hGC8sEnwUfPUWPmeb/xjmXUNxS4xEvtqfEMPHP6Xo5cTzIWRCD/ra2dcpDKyt0CMnERPju8rZUT3XZLTySQnkyQ+/VQptyNfbMa/49YBS9RUR8Hp7uC6lm0mT9cuFgq+gjyDN/GO/4ezXtZoD0podL2NVsuUxZV2NLIAYDtpPqPYu16Tz2StHQyx9BZq6D2RR1cSkjD4dQ9lN6tSxGw/vg106uhxFgLeCEVUXj0mPsN2JMD3jGqEkIw3I/XZ+JRJQ5sqMxts6ij+svynVeDwRDKEFpVKza7x76Lshi4RQTaiLWEoTci0a+mMHfd9k=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ejd3WXhXbGRzMVYvalNjRm5LYVc1b0J4MndacjNoZnZUZXdQMHNYeTQvLzF4?=
 =?utf-8?B?TXBBbmtkWEs1MEFTQzVmVGlFMzBCN3JPamtJYlVwYk95MUJ4THIrZmxsZFhW?=
 =?utf-8?B?UnVUUlFPT1hyaDVmSlQzSktFcjVIR0xsS3BjMThWOGhsa1p0eDAyZFd6RDMv?=
 =?utf-8?B?UkQ5dCtnakljYjhodU5XRXhnbjV0VUlBTTdjWXVGcXFUdDVQb1JENXNqelV6?=
 =?utf-8?B?RzRHN2pOSjhudnQ4czlFbWZnb1EwUHRnNllCWTRjU1FGaU5DTGh5Vk1lS0tU?=
 =?utf-8?B?VVVkQ2h5d1NtK2hsUllNbUU0VzdCNmoyNTBROEpWQkJlaHg3eTNKeHdWeHpv?=
 =?utf-8?B?aUtacHVGRlJQY2ZUdm0xTUVIS3JKOFl4bjIrdVFxeTZoaHJ5QmI0Q0ZJN0JG?=
 =?utf-8?B?UzBVNm4zSjJudDE5WDRqZWEwdjV6QkdIWTNldHZzWVhLajkxZ1RNRzdadHU4?=
 =?utf-8?B?SlJQYnJ6MDJmaWlnL2FtVWQwZk1PSW5QUVI2UEhpbXUvR2F6dWFsNzRPN2JZ?=
 =?utf-8?B?SG9jY0EzN2NDaVZ2Y3N6SzAxQnZ2TlF2d2JBSk80S1hjUmsxNlh3Yk5lZVhL?=
 =?utf-8?B?UGlNRjQ2RmxzU2doVmhYK2RhMWJhTUhjZFRzZmpvdi9oK3BJRGl6SXcxUW9o?=
 =?utf-8?B?ei9SRlZXK0hmNXdQaXpTdFpVeEZjMjB6cEZGZkVmdzIrbGlhR3lBZVNjNHh3?=
 =?utf-8?B?T0hmY0Yxd2NtbzMrdmJEaElZMDFsVkwxZE81VlRFUW1lMGpHWW5TWWNKVW5m?=
 =?utf-8?B?bXpHYzZwaXkzc29EV2h0dnZBUnZsQTZoWWZRaUp0SFVrNlNYWHN5TUtuL0cx?=
 =?utf-8?B?OUtNRSs1ejQxbC9Semhaekd5QnR0dlFBYUUvSFI4YU16T3lTUlhabHlsUEN4?=
 =?utf-8?B?ZnUyVnRaYWJVUzBBcmhnQVB0Yyt3NExNbHl2UUZUeTNSOER3TTZiZUhtQnhn?=
 =?utf-8?B?TThTamxlVEdsbVg1b0J3aGlCODFoeU40ZnpKTTcvdUZVQjhxbHZFMTVXdGNz?=
 =?utf-8?B?d2xURHlYTmVHVFYzT0p4bldERXZ2S0s1SS9nb1NNdmg1bVU0bytnNkJNL0Zl?=
 =?utf-8?B?eXhMZi9UUldjZ3RzS09Na2p6MCsrWWkySzJMd2FhQXpoTWh4Tkx5T2RhVWlG?=
 =?utf-8?B?S1FMWjNXcDBtS05aNVRPVC9rY213Qm9ZdXh5blBXZytXT3Nud1ZMS0JhMzMz?=
 =?utf-8?B?U2ZXY3VrVVhrWjYyYXdoRktibGtQWEs4bTl6UkVvZjhoZURlcEIrcE1wWE5x?=
 =?utf-8?B?US9wV1pLTmxSMTBZWjl3MUVUbGpueGZlNjJvdHVvK24vMDZZZ0pHenB0Qmta?=
 =?utf-8?B?c01GNkNzZUNKa0xtTjV2elZEMzU2V2VSeVF6YW53RnJ3ZEhmcU0yVjJVWFNJ?=
 =?utf-8?B?YlJXRU1JS24yMHc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 ce75e416-1dac-4125-1e1f-08d9b8d884cd
X-MS-Exchange-CrossTenant-AuthSource: AM9PR09MB4642.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 16:50:33.2316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR09MB4851
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 06 Dec 2021 16:50:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13134



On 06.12.21 17:41, Alexander Kanavin wrote:
> Signed-off-by: Alexander Kanavin <alex@linutronix.de>
> ---
>   bitbake/lib/bb/fetch2/wget.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
> index fd9b304961..3021ef359e 100644
> --- a/bitbake/lib/bb/fetch2/wget.py
> +++ b/bitbake/lib/bb/fetch2/wget.py
> @@ -583,7 +583,7 @@ class Wget(FetchMethod):
>   
>           # src.rpm extension was added only for rpm package. Can be removed if the rpm
>           # packaged will always be considered as having to be manually upgraded
> -        psuffix_regex = r"(tar\.gz|tgz|tar\.bz2|zip|xz|tar\.lz|rpm|bz2|orig\.tar\.gz|tar\.xz|src\.tar\.gz|src\.tgz|svnr\d+\.tar\.bz2|stable\.tar\.gz|src\.rpm)"
> +        psuffix_regex = r"(tar\.\w+|tgz|zip|xz|rpm|bz2|orig\.tar\.\w+|src\.tar\.\w+|src\.tgz|svnr\d+\.tar\.\w+|stable\.tar\.\w+|src\.rpm)"

I've seen tar.gz.md5, tar.gz.sig, tar.siz or even tar.sum files on a 
bunch of server - unfortunately those would now be considered as well. 
Not sure if that causes any negative effect on the actual version 
parsing...

>   
>           # match name, version and archive type of a package
>           package_regex_comp = re.compile(r"(?P<name>%s?\.?v?)(?P<pver>%s)(?P<arch>%s)?[\.-](?P<type>%s$)"
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13133): https://lists.openembedded.org/g/bitbake-devel/message/13133
> Mute This Topic: https://lists.openembedded.org/mt/87544042/3647476
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [kweihmann@outlook.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

