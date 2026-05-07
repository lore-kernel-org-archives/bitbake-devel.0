Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFD0CD3439
	for <webhook@archiver.kernel.org>; Thu,  7 May 2026 13:56:42 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.29])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12539.1778162200197137298
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 May 2026 06:56:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=gpzUi2Bg;
 spf=pass (domain: cherry.de, ip: 40.107.130.29, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ESl5M06WSfkN33FDgm588U6n/GyQva6me8Ht996BgxzB8akYl+8xyvCHQELiRLvJry0oL1I7CBO16Ii4qjW1OpvzJ0fvsdykyTnz1pTV09U//ouLK/hQ6CSqdH0Mye3qSvLYKeFKJNzd00xzzMiLSH/eXgg0yeiOrHBWvI6bVxbmZQPCQMoXwue6ERrvjHINMsLk+4C6z7HwrmWiKXEvhu6kmVfItqeFvVj3wIJ4DrbHReVo/e8SqnNBjcd9Rogv1IAI9GCTlJmXxItw8hEyj0RXQW/21lxLzYJ02ko0HWJ59NOz00v4WTlSM1hZn7+722mJS5WdfJzpBhlquzTtIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCZHBqiY6uT35v6riwzMfIxl/xp1o34kc2iUmQJHdcs=;
 b=bm3h0z61RsojWu468YR+XG/ldL3OQz4S0xYFLei8KM4C3uTXk9YX31pfBN5KvmL5j9kaQO/YbgTjjMdfitdEnDfV8i55IkepmsB+i8xCMS2ORBrM4T8MWEaz+pw3jRRDk2LWYR54iyQqEpoFDeRRZ38F0qM4fvCKknRJJNKchlUmfS/vjLUsrSxJnK13sMNkc2t8/C25R+x9K4pxoK5ytmVjFK+7MxydAj6MPb/l9GsfAMyWBBP6lFDWEmwz9fSJY0BcRXDTvv/SU5nv3R82inX1w7GC0Z5g1TzBOLbo37chtPb9AglxIyEaF8nHdCSztFoxpDQ71mb4tvwUilldow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCZHBqiY6uT35v6riwzMfIxl/xp1o34kc2iUmQJHdcs=;
 b=gpzUi2BgCAcpflgeLUmMfJfBF8EwHGP4nR58mlrYPiOVVoAnZ02sRezc88/mz6thSNHlDloPoBTO/YvcH0/HWOO3oOVzF83XHvPEIJWGOJxyZKQWngkH6XPgAu2HqbQRuGxxk3vM0TqGaM/TfXHNoLOyMF1qrlxpupGp05TVClY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by GV1PR04MB9119.eurprd04.prod.outlook.com (2603:10a6:150:26::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 13:56:34 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 13:56:33 +0000
Message-ID: <a3a8a5c5-81c3-4764-aba6-32c84ce55a7e@cherry.de>
Date: Thu, 7 May 2026 15:56:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] doc: bitbake-user-manual-metadata: explain
 inherit_defer example
To: Dawid Bijak <bijak.dawid@gmail.com>, bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, richard.purdie@linuxfoundation.org
References: <20260501091418.76994-1-bijak.dawid@gmail.com>
 <20260501091418.76994-4-bijak.dawid@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260501091418.76994-4-bijak.dawid@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0399.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::8) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|GV1PR04MB9119:EE_
X-MS-Office365-Filtering-Correlation-Id: 0977b50d-a2b1-4c70-e455-08deac4072d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info: 
	FrZszcPWvABrQMHPu7oYtIvq1Jpqx0ZeIhYzkJEW+PIX+vuhgasUKgsfP8Tl2P3AqKu+ySUCm4INa7TzYvprQIu9XUde1TMt3igcw2cRlFRTOqmcffLLZ/jggVoYdURN1XA/PkMVF8lWnUF2TPklwNZdORIZpI8KTW7rgYW2mjfGcFzsYIV6P5qIbliFeA1GGfCkyoZtNlAdELEYao6ii5mhAsNKutIUwDjmdyMGz2Wu5Uj7MPQv9YEIKIFeu9DtuHFqxHN33h6yUhFLutamH2BdleOQxqCIZ8sQsbyy0Ccy44US0IlhqE81XS0V7I+GmfYFk+ZFpPsVKExk7ZkB2/QLJnog9uWFBV6EFLutd5Yya5qLoYXBsZP5rZHzf6z7pSy3Ol4VHB9yvsURQoBIxd12hbQxh9iRhI1khHI91JfphPCCVyn2MbTEHuPfocCxkRXBZukZvtruXTazNOaXu0qnKk3HhRI5+z0+7+hCOEhMRClRnNlJdabNhgeBnKUDedtZg5vCfMGFOdpJwOjwNJRLZCKKMIxkT9A/KkQJPsxCSTuL4X6pvkbdhxyGRpYgkmroqzdkqnLpvB9oGQziTpqwV7dYFMDSrR0/b+gDTfhasPCg+RuQSsupdQqppLU0YAccAkgNbKK6CgN7euPXvdjkUOi5ZOfVNY/wGIIKKvKmgFOnjjA+/nO6MIgb5p5Y
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7737.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?b1c5Z1VrRjJ0K1loejJnMkU2Mm5IQU10RlovNW9XZnkxMUwxZWZsd0ZHMnk1?=
 =?utf-8?B?Wld4Y1ZmVXI1S3FEUGIyak81K2k3ZkNnQWRYdWlaOTc1VnV3b1lEd1A3bVJ5?=
 =?utf-8?B?UkVmR21acUVQQlNMMDZySGRiNnN1aWpkeGlLbkdWaFJCQkY0eVN5S2tZNUFy?=
 =?utf-8?B?L3UxNkh5N1NGR0E3SFlSZ0EyMlkzTkZnZE55Z3lhaDdoc2FGVlhYN3V2TWRp?=
 =?utf-8?B?VDB0YkRuZGg3ZUdUUStiOEpIcngrNUJscEJQd3F1eDZHdlgzY2w5UkVTUjc3?=
 =?utf-8?B?enNMSkdiMzlXRkZud3FkREpQdWpNaWFnUkt5dWljemN2Snc1bUQxblNrNlN6?=
 =?utf-8?B?L3ZuNjJ1RFdkRnluQkFVQkk1R1g1Zkp5K1VkMi9UbUs3ZW9FNWNxVWtRNTNz?=
 =?utf-8?B?cnU2alhXS09jUWdZbFVjMFhWanoxbE96ZjAzakZZWk5Ra1pHM0JJTG9NcHJv?=
 =?utf-8?B?RHlvMW1xTnB4bnNMV3hKdDU1aUs1djdnMmdGYmhYam5vOVQzQzZSdUdaS29k?=
 =?utf-8?B?R2tab0xiMWw5d2RLLzRpeEI2eVdwQzhtdkNjNzBBVU5WVzNMaTBsQzdGYVZv?=
 =?utf-8?B?bFZQNkRNRVZKQ1VOUFJ2U2RyTWovU01aTjBweStnY1NKa1RXOUhTcWttWlNH?=
 =?utf-8?B?UjhDZU5WbDU2ZmFib2VMYkp6Sjhad09OQ2JTc2hCWDNaRzNIQUhwUlByTDNU?=
 =?utf-8?B?MnB4aldEQUVQUkZheWhQRWRDSEVQa3RyMjdvSU40eFlaZHZTUnB6dFVVYzV5?=
 =?utf-8?B?NFdqMnl5Q0VQdGlhb004SEtMc0lFcVJsc3BPRTdJTDRXeXVIQWNoeXZvcFhL?=
 =?utf-8?B?TFdLb0NaT0cyS01iRUx5aE8wSVp4dWNiVGxqeUN2bmtOMXljbEsreUtTWERF?=
 =?utf-8?B?MFZDRzhIdE1idExrV1dLRXZYYWRkN3BUM1Jtbyt5YXR5SjhlSHh0dDJWdktY?=
 =?utf-8?B?RFJmZytNTTMvTnlMdjBpQ2IxY2hLR2E3MWx2cFV4Y2tyekd6c0lTNVpYQzBv?=
 =?utf-8?B?SEJmeGdpVzdhMTlZSUtTaHM2YXBGNk55UTM5K202aEU3VVE5YytsL3hVK09R?=
 =?utf-8?B?U3FkUFBacmVrUjF4R1JQMWE0WndRYkM3bnNoRkVYRjRPTUNWbWEybFNPRFV5?=
 =?utf-8?B?N0tieFBIUll6NGs2dzlPbm8xRVd5amE4amVmK2xka0NIOEhFM09sRitZaUto?=
 =?utf-8?B?WTB6RURqNVpOSGhFazU0emNMR2Z4dUtGekhmVFJmUktxYUJES1hHNlVnREgz?=
 =?utf-8?B?ejdhYzhhSGlpVVlEZEg2dzFSMDhvWW8vbkdDRFByUlcvTHJGSVRqZGFhbmYv?=
 =?utf-8?B?Vjg0bUFPTUdGNjMxNFJGNFhFZ2xYNnNya3dVeDI1c0g4VmR2cWZGeEFKVDIr?=
 =?utf-8?B?dHo1OUF1VFdVYitETk83N1ErUVp0ZGZFaWFDUFNtajF1V3h0QzNHT2c4cUtq?=
 =?utf-8?B?SGVoMVB1MmRVMklnSVpRWXh2akpDNVdBRFFHZ0xaZHpEQ1BUSTFnRzdLYnhK?=
 =?utf-8?B?aEhocjFjUGt0TWdNWDNLWFNHQS8rMTRxMzVXWVdaSWFWS0hDK3QzT2ZFbHFZ?=
 =?utf-8?B?UXBWRDhOc1UyT3RaTFdsQTFjRDFlbjhONjRkUVF2TUREcFNqdkJtS0JJZnZy?=
 =?utf-8?B?SHE0a0puc1UzQUdPUFVIUzJVd3hrbWtiWGVoRFN4MTdkSmxPeXQ0R3FzcW1w?=
 =?utf-8?B?MllINTRyWjdwOG1Zb041WEN1SVpUVEdiSy92OFNpalZZQzNjcjdscVJxVHM0?=
 =?utf-8?B?WUEzajZMV2tCZTAyaXFLZ3dQUGt3bHh1RWY3WkZBMWt5OGFyKzVUODdIQm9V?=
 =?utf-8?B?UUxmSCsxZFYzZFpwTnVsVURIUVZSMXMzZ1p3QkQrSzJsQ2pjWkIwYU9YdWVl?=
 =?utf-8?B?VUozRHZUR0JJcVZiMGVpYjJWS0twMElkL2pmemFPdDE4ZFVLT2UvUEJFakZF?=
 =?utf-8?B?cFJVMWRNLzVQajQ4dFRFbkhPMXRKRC83Wmg4dlBaTTFxQXk1UGRMNDhuNXV1?=
 =?utf-8?B?bUt1YU5JV3IwNVAvNzBRSFc0OFFoMHAvTEZaSFBpaW9DOTRpWWpMS0VoS20z?=
 =?utf-8?B?ZUQ0Z3dEWGpBclFpVFlzWXBiSlE1ejJ6U1NJMVpyMlNFTVlXN3daeDUzanR6?=
 =?utf-8?B?QnJPbzB5dGdwMmpHSXluVmN1SDZHTmF6N0w0dDBtRWYrMkh3NlBzMHZUYUdu?=
 =?utf-8?B?QkVsRXBoaE5WRWFnYW12WVZ2U2tFNHBrWlU1SVpMd0xoRFpRRkpLemlqa2Jx?=
 =?utf-8?B?VGUwTG9xNXAvaFJXekJDUFNIRVprL0xNZkdIUVBhNk14YWZDSnJva1NTaHFY?=
 =?utf-8?B?TnNJa2s4bHVJOWVwd212c2svci9KeDBqWHZrZEhJNHBBZFNIQ01MQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0977b50d-a2b1-4c70-e455-08deac4072d8
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 13:56:33.9496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7k6PQnGjfHfGJrfD9GPftGEh+VJDZgYwRK3Tlfhd2NwZLSWjiTnkXdvjk1stRtcqAcptDoba9tPVvwhj931O7is51Z68UFV/as5ee2AUFKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9119
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 May 2026 13:56:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19465

Hi Dawid,

On 5/1/26 11:14 AM, Dawid Bijak wrote:
> Add a short paragraph describing how the inherit_defer makes use of override
> syntax to achieve conditional inheritance, and rename VARIABLE to
> VARNAME so the example uses the same identifier as the preceding
> code block.
> 

Can you please instead rename VARNAME in inherit_defer to VARIABLE to 
match the rest of the file?

Otherwise, looks good.

Cheers,
Quentin

