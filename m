Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFD2C021AE
	for <webhook@archiver.kernel.org>; Mon, 17 Feb 2025 16:38:51 +0000 (UTC)
Received: from AS8PR03CU001.outbound.protection.outlook.com (AS8PR03CU001.outbound.protection.outlook.com [52.101.71.115])
 by mx.groups.io with SMTP id smtpd.web10.56668.1739810325145623716
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Feb 2025 08:38:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@weidmueller.com header.s=selector2 header.b=JfrTdZsd;
 spf=pass (domain: weidmueller.com, ip: 52.101.71.115, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fIFhS5LTJabR0VHYkNEMWbNI/zX5ZIEvpYq+9sRkR50uKiciZj9GQ8k/GCnltCESJ5jgOXVul1o37ha5lD49PmGpm0X3OgqLyNv9vWb4E7N4gHvmDb+os4Aq9zJOAiQ0uku98ncVkuhG5stmYpl3ngZlfyL04U6RaFeBlkzsh7mbfQ7Cy3P1MqJf+KwN7efjXvF2g+ti9JC5bJMVdj60Q5icXnqr0xaaqkP6dOJ9RJyHbBOoza8yOuZ4hY+H6Moc7Bmf53Cw0DO9ELgk1lcDAHFlQBhRHUJqhxcGFpzHWiFddesjuFVs61WEQsczPPC8WwO0vNLFMS0z7r0qSWM18g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9V5TAcon+AhulhRAnGWz6vydDc3eLSpWZDwZY4Zk7M=;
 b=UdJjChCdrf2Xbl+V9vSiZcj5lM2KGSV6J8ED5pKEPwlz7Ip3+XvEUsczABdbFi9XOeAFrNyh3x8Mv5X6RmspJpqCCaXIMFJQ5CxRtNcwUByw5/1uQQf67YBB+dP4+OKE7R0WhnxQaHMWql4hJ4m2LP/FxoezQBD0rKE8UIouWOE0gjSpEP0UZ/5QuL7x+XGIp6TZ/lNmD8ilR3/l/uty40X5t2Iismcy7Eod9cyB6mvgVWuGjk0FNVI3loRxSLKvWlf2xBkY7fXYRTdjnvUzDnjusXiWPF+kmJ7qiI65OD1lRqJ5lhOghWqae+eBoGdhd49S15x6TKUq76hB/8ydqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9V5TAcon+AhulhRAnGWz6vydDc3eLSpWZDwZY4Zk7M=;
 b=JfrTdZsduRdiPMPqtQvjyvjaceY/5LBUsGUpdkT/ixf96DCpRsu2wmpx6ND93W1tZQAxsTcW2ZskZFb96lt5vlVV44l1AYxTeWgKdHBcxCP2Y9kp5yIRhzgmkUNhBhjUotmvG4NLS/sM+6Mot7eZTho5EHr0DFTsCkw7txOvWMd44gBUX6WmsCJRJDVOj9Kt9rQHkaFJgSBV7QpfAhOzmHXpOPs4OLqqhnpx1xr7tCOPeWssiUk0fgXMIWKbABpfvqjrdx4DXAd4rsqYZaCYIbVPeApbKr1LafugkiGhNoG5PJcdgLS7il7Dd2B26l6/b9n1x55/+gj/xUhxFi/eRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by DB3PR08MB8961.eurprd08.prod.outlook.com (2603:10a6:10:428::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 16:38:40 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 16:38:40 +0000
Content-Type: multipart/alternative;
 boundary="------------wn0qpzhJ0la3WLVupH5psMWY"
Message-ID: <9668ba9a-4029-4600-abd1-0f32215aaedd@weidmueller.com>
Date: Mon, 17 Feb 2025 17:38:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] 'vendor' fetching discussion cont.
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 openembedded-core@lists.openembedded.org,
 Bruce Ashfield <bruce.ashfield@gmail.com>,
 bitbake-devel <bitbake-devel@lists.openembedded.org>
References: <4cea4488ef3181471373f3dca26ac390203a90cb.camel@linuxfoundation.org>
 <55925709-d3e9-49c8-a6fc-f97c611146cc@weidmueller.com>
 <d30c619392f62f2d40320b01da5ca95369f3e7c2.camel@linuxfoundation.org>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <d30c619392f62f2d40320b01da5ca95369f3e7c2.camel@linuxfoundation.org>
X-ClientProxiedBy: FR4P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::17) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|DB3PR08MB8961:EE_
X-MS-Office365-Filtering-Correlation-Id: e00d8ad5-93c5-4fd5-27db-08dd4f7188bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?clZiemRSOVJkT0RPVzBRTUV6VUhXSWQ3eWcremtDUWpPQzUyTUtNYWJkdGZj?=
 =?utf-8?B?WHY5dDhRcUFVRHUyQmxUUjkvK1hVLytZTDdIa25ieWZYa0U3and5R2h3Qlhy?=
 =?utf-8?B?TGwyUUtsODdNTWtXVFZVMHZweHdBYmpOMlFXdU1qRUZlRkhISW14enJURGs1?=
 =?utf-8?B?VDZrbm5YWU9FMTVmbHBHbUlTM25qMHUrbDVzVXM1ZllOT1QwNHJwa3hrTzc2?=
 =?utf-8?B?MGlKVXlORG94eHJ0RHRYWi9WYUlzWVUzeDNOYitUQWt4d213TkRZa0ZGTUp0?=
 =?utf-8?B?bGVNTkNZSlNvRlBjaHg2MGZPUDZ5WkhNVmlwRUgycENIWjdsaTZzMnFIUDhH?=
 =?utf-8?B?ODlORm54TTM5QkNTYVVRQUN4U21jR0ZRN3ltSW1yZThCUENJbkE4cnJuQ21X?=
 =?utf-8?B?anVpSGxjRjdHaGRhNW90U2QwUXk2MXZ1R2VIZEhJWDRyS29IbWU0R1Z3VFRL?=
 =?utf-8?B?bGF1bUF1aFhDZXc3bFpjOEZoZk1RWFZrQlRWdGZkb1FNVkl5eTFaYXl1TjBN?=
 =?utf-8?B?dW52dDlURjVDL1ExWXg1MTRVdzArU1oyb21hcXQrZXMwZDYxN3B1QjdkQUpt?=
 =?utf-8?B?bXNYaDZQalp1NHF2bjY5R0pUSHRwbHlVbUFQRVVxNHRQMElhMEszMkZFdC9I?=
 =?utf-8?B?bUpyd0RnaVptM3dxc08rMU1OUytQUkNLYjBCdGdGb08vQzllR1RYanRCZWFq?=
 =?utf-8?B?K2tHMnp2cHl2WkF4SmV5OWNZdGlCcmNFTmJHTjh3c01sdlByUlZ3SlhaVDRM?=
 =?utf-8?B?anRiTE1LTy9HTFJ5eHpYdCt3SHVrcTNzbENQcStrL01UVjJMSE5TYWpEb1FK?=
 =?utf-8?B?eVA0R0NacWE3cWpodzMzN1U0Q2ozYjF3dGI4M0ZaOVkvckM2bGtMSGNnZHZx?=
 =?utf-8?B?ejlTVHhEclI0bEk2ektvalY0QnQ5RTJ5aGVkMURLVTUyK2JYOVZtUHVCUlRu?=
 =?utf-8?B?b21DdnMvYXdzK1MzVmFlWnpqTWpiRjdWUFAwRVFyaVFEMm4va3J3SUtwTi83?=
 =?utf-8?B?RVlLY0ZDTlliakhKVXVsUzlONXBReTdwdm5QQ2Y4dmVtdkhmU20zWDFVcm10?=
 =?utf-8?B?SmcvQ2hZTkI3M3p6SUh3R0FlTms3b3hxN05tL1B3UEIzMUFyV0xhZzQyQnJa?=
 =?utf-8?B?cTgrSTVpa256SVBWZ2x1QlRQY0g2VkRWWDVUZnU1TmZBSFhYVWxUQnYrd0ZO?=
 =?utf-8?B?UFovbjZhcHlBWU5IMVp0N0VGTWo3OW4wNSswNWtGM2FWTm1DcE93Q0h2R2pr?=
 =?utf-8?B?c1pvbWZQTmtIbEJDaHZWUkhlV01tS3dJOUZ6dUtGYjBleUZZWkRkY1JSQzNp?=
 =?utf-8?B?ZHVUdXBYZ21GQTJoU1pFSHJscDh4cmVpSWsvTXhDS1dOY25vY1ZYT3VBV1N4?=
 =?utf-8?B?UlpUZUlUa1RneWJYQ3EzOXg5Ny9jZjhDaTBPWmtkWnM1Q1J2c0hvYWxENUI3?=
 =?utf-8?B?Rmw5ZkNVNDQ5R1R6NyswOHZnbU9qTHFqYWJEb0V1WXUzODdXejY3YklqMFZo?=
 =?utf-8?B?WCtmOUQwa1dURkRVN1FYKzFLSkxCbHFpRmRFTGs3TkVpMS9reW8xKzFraTNE?=
 =?utf-8?B?YTAvU1dTbk9RMlVyRVgvM0N5QWdkRHlUZUxvQk9IMVVMWnFSVGt5c1JiVEFF?=
 =?utf-8?B?bWVmUWNxMVRwSEtZWno3clJKUFJLUDY0WHorSmhRUXlMOE9rRENiT0lPbmtJ?=
 =?utf-8?B?cmhBU2VqU0cyU3drY1Z0ajBHLzA2c3NrbkxDT0szNXlwTEJ6aHU2Q0hiSDEw?=
 =?utf-8?B?WjVJaitQYTdIQnE5UGwxUytQRE9rbWRoTzlLTkllVVhDZUlkTkdTdDFJWXZi?=
 =?utf-8?B?VGpxS1VpejB5VnFpeUZFN0tjL2t0aUpucFlZZzFUMFJzVnNsTXczaG83RnlW?=
 =?utf-8?Q?A9MsCFyHJ0Sl3?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(8096899003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dzFwNytLYXRmOHFxV1lwT2pjVHdEeS9la0tJZ0ZRMGVzTW50b3JuYzZOUXc5?=
 =?utf-8?B?RVQ1ZnhGcXYzdEdQUUhoY2JkWnREYzREQ3F0d3BOZnZZc1pDNTQwR1RBYk1s?=
 =?utf-8?B?N3dqT0prZFRXcHdiOVNldytWc3ZtYkFCbmJ2d2JSWG9rUlVFNTNOOWpjYk5U?=
 =?utf-8?B?d2piU3Bra3ZMb1Z6dENnTHpRbEdGS3lBbWdxa0ljQ3drMWhuL2k1RzA3MnRU?=
 =?utf-8?B?dG5xZ0NRMmk0QjI2bzVtN01IL1hwK2QwbExhY2J5OVBEekVJNndtUmx4SElx?=
 =?utf-8?B?L1ZhUHN3eGlWTHpSTUhuVk9rbFNFdGZ5THNsaXR5bkNid04zUnRBRDhKYmNT?=
 =?utf-8?B?b1lKWC9PcnRaVVRxSzQzOFpnamxQSS9tYzdGSVpJc0IyRjdPRGFHR2RmM3hr?=
 =?utf-8?B?VTdlSWFETjN4UHlrTUlwczBNQ1orSlhlM2Z0eGZGSTJDaG8xYXErK1pma1d1?=
 =?utf-8?B?NEYyTWRaNjlHZU1yK01WaUhTYlAyNWs1NjhrMG43WC9YWXlBRnQxbDNUNWVy?=
 =?utf-8?B?S28yYzYzU25RaXY2aTI1K1RZYVUrREtndVVrYXRhVmUrNFUrb2hTb1dtSnhh?=
 =?utf-8?B?MFNTdWt0MW1PLys0LzltVm96cTdMTmdLbXlQS3lkRnIyaGUxc1BlMjF1eTdi?=
 =?utf-8?B?c2g5OHB0VGJrYzVleTlhVDF3cW5ZZTJsL0lpNDR3bWdQMmIxeFZBR3puNk91?=
 =?utf-8?B?dmRHSi9KUG1IQW1EaDlnVWhGaUhKMkpHN0s1UkN5MDhHK3JTcnNVOGRVeHlZ?=
 =?utf-8?B?QzY0NWdLRE1QTDNTOGNFMmRmTTYxMTFpZ01TcW1iM1JMTUJxV05QSWlyZ0Zo?=
 =?utf-8?B?RXZYSjliOWpmR2dpbDZaRXhBZUc3Z1FXa0lhQWZHU1pIYjladWM3dVB5U2J1?=
 =?utf-8?B?RU8yMy9FdXNpL25nbWxMSlpnNGFobGpyZ1dKOENUMGg3TjArQkw3OFczOHlt?=
 =?utf-8?B?QWw3SXRyQXBjUFJVRFEzTnJHa01QeWNsdnFCbEY5ZFVXb29KVEZPbnpQd0ds?=
 =?utf-8?B?T0NhN09WaXpmRTRqaEkxRTNISlFxSVFYODFiSWpab1RpaXlQanM2d0ZhbldS?=
 =?utf-8?B?dFpsY0ZPcm1LaDlkSmJpaElTOG9WQURXRzZzNUk3YjcrZ3hOcTFDQTlNb01Q?=
 =?utf-8?B?dzVCVFVVVXptT2dEOEl3YUdtUmZSd3ZzQ1MydkJCeGZVOEJHdm14OVRFV1p5?=
 =?utf-8?B?K1BhNVJWS0szTk9VbHdrS2YyUWxvU1A0Q3pSMHlEN2VZd1NmTkNXelBIQ3dQ?=
 =?utf-8?B?dmZDK3hEbVFsdi80VkNuRkRtM3NIaHlZTHA0SEtjMFJVYklibmVoR1F1RHVJ?=
 =?utf-8?B?bHpObFZHeG8yM1Q5TXVGdEhUNzVCR3p5WURTbFE2UkpBZ3p4a2pLL0xuY0hw?=
 =?utf-8?B?d1lTM1lkTXF6dGNibHRHMjQzcU1nZVZKMi9IQUdGK3FDMzB6eHRnUGlkOVBh?=
 =?utf-8?B?N2RUeURJUVd3WVF6eWhzYWU2L2prTzd3SkZ4Ry9RZW96NDhoMzVxUnJJYzI4?=
 =?utf-8?B?Um1YcmlUeDI0cklBZmNlQ1BOMUNST21TQWZhS0JWR3I3SWdhbVd3YSttQlpy?=
 =?utf-8?B?dGhwdWJXME1RdFpKSHdVRkpkSmZzYzlmNnBzNXB0c0taNXU0Q0RuWmJDYlRl?=
 =?utf-8?B?RG9OTDBJSmh3WFAwQ0x5OTBObVppVlV5WkJpM1E4SUxPWWJQMWdVeWtITjg4?=
 =?utf-8?B?RGZNYmVNaENwK1BhOUVSdFphcjBoRHJXU0xVdkVabnNmUjZsYTM0aGNpWDdm?=
 =?utf-8?B?bkhtQmNtTEl1VFRRaVlQQjFYZVVkVm9DU0RaKzNGbHpxQnVpYXZRaUE0b0FH?=
 =?utf-8?B?UWwvcmpiejhoT2UzTUp4MVlFSmwvMkdLZWcwbHZEd1EwNVVWR3k2enFXenhr?=
 =?utf-8?B?bHgzbjJSMEpGQkh5VlNCblV6d0dYK2xNTmRIeDEwSURBWGtCNEpMVlJneG54?=
 =?utf-8?B?Y08xN0dFRXUvREFkUnVnek9pZ25rMHBVYVF6b3VLSThxbmhMU0FTQjJRRWpF?=
 =?utf-8?B?cTA1Nk92ZHFlNW8zUnNUTVJlUWtEdEs0R3lMUk9vUXdaZHJPMmR6VFZHbisx?=
 =?utf-8?B?UW5HR2VQSmxVSllrQTRqaFBvQTI5aUJVUDdya1NIQnIrZEZ0b0lldmVaZmRQ?=
 =?utf-8?B?eWY0WDYxRW5HSktBUHhOeHBUSXZLYzRBTXJpZUo2b1liQzQ1MTVVUWMvZTRL?=
 =?utf-8?B?WVE9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e00d8ad5-93c5-4fd5-27db-08dd4f7188bf
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 16:38:40.3392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2p0HVdsYQlebbsZ4yBm0c4Qs5t0h6pzxbBvIU4vpvSG8k7QnsaXOULUbmUnoj0AzyrqbXxcdkS1e1KVZfHaeWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB8961
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Feb 2025 16:38:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17235

--------------wn0qpzhJ0la3WLVupH5psMWY
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.02.2025 um 13:43 schrieb Richard Purdie:
> On Mon, 2025-02-17 at 12:00 +0100, Stefan Herbrechtsmeier wrote:
>>   Am 13.02.2025 um 11:43 schrieb Richard Purdie via lists.openembedded.org:
>>   
>>> e) add the ability to add custom hooks in the fetch process to
>>> handle
>>> the cases of needing to alter the flow for patching the components
>>> list
>>>   
>> I fear this isn't easy possible and we have a design problem. Bitbake
>> and oe-core assume that a patch doesn't influence the fetch and that
>> the SRC_URI contains all fetched sources. Many code use the Fetch
>> class or the SRC_URI direct and doesn't expect recursive implicit
>> URIs of gitsm. In reality the SRC_URI describe the given URIs only
>> and doesn't contain the additional implicit URIs. The task flow
>> applies patches after the unpack and prevent patches to the gitsm. In
>> reality a patch could influence the implicit URIs and isn't
>> independent.
>>
>> I would recommend to keep the patching outside of bitbake and instead
>> handle the implicit URIs inside oe-core. We could write the implicit
>> URIs into files in the work directory and migrate the scattered
>> direct users of the SRC_URI / Fetch class to a common oe-core
>> function. This functions returns the given URIs and optional any
>> additional implicit URIs. This allows the usage of the task
>> dependencies to ensure that the implicit URIs are resolved before
>> use.
>>
>> The package manager lock file needs a single unpack and patch step
>> whereas the gitsm needs a recursive unpack and patch of every
>> successive gitsm. This makes it impossible to use additional tasks.
>> We could add the resolve of the implicit URIs to the fetch task to
>> support recursive resolve (gitsm).
>>   
>> 1. download SRC_URIs
>> 2. exit if no URI is marked as unresolved
>> 3. unpack unresolved URIs
>> 4. apply associated patches
>> 5. resolve URIs
>> 6. goto 2
>>   
>> This will eliminate the need for the partial implicit URI and gitsm
>> support in bitbake and makes the fetcher code simpler. The patching
>> could remain in oe-core and patches could be applied to gitsm and
>> package manager lock files. Additionally we remove code duplication
>> and simplify future changes to the SRC_URI determination.
>>
>> It will add an indirection for the SRC_URI but the current code
>> already shows that this makes problems. Only the archiver class uses
>> the expanded_urldata function and all other classes including the
>> spdx class ignore the implicit SRC_URIs.
> I'm a bit worried we're getting caught up by the terminology. We don't
> necessarily have to "patch" the component list so much as allow
> something like a function to hook and adjust things. That then removes
> the need for it to be a specific task.
We can use a common patch without a do_patch task. We could even call 
the patch code from the do_patch without an extra task. I propose to 
call the code from the do_patch task in the do_fetch task. It doesn't 
matter if we use a hook or task. We should minimize the work for the 
user. The common solution to manipulate a package manager lock file is a 
patch file and we have the code to handle patch files.

> I'm also not sure that drawing gitsm into this is a great idea when it
> is effectively already working  quite well.

To my knowledge it isn't possible to patch a sub module revision. Is it 
intended that the SBOM doesn't contain the recursive implicit git 
repositories?

>   I appreciate the desire to
> have neat abstractions applying accross everything equally but I'm not
> sure we can achieve that with the level of usability we need and I'd
> rather improve usability at the cost of the inclusion of gitsm, which
> is the most functional fetcher we currently have in this group.

I include gitsm because it is similar to the package manager and have 
some drawbacks which I solve with my approach. It is the only fetcher 
that parse a file to determine additional URIs. Its integration into 
oe-core is sub-optimal.

> I will repeat again that I do strongly feel that a strong API in
> bitbake is going to lead to an overall better design that something
> bolted onto the fetcher in OE-Core.

What is a fetcher? We have fetchers for protocols (wget, git), wrapper 
around other fetchers (crate, gomod and gomodgit) and wrapper around 
other fetchers which embedded file parser (gitsm, npmsw). Thereby the 
gitsm fetcher fetch a source and parse the embedded file. The npmsw 
fetcher parse a file from the meta layer. The gitsm fetcher recursive 
combines the download and unpack function call in mostly every class 
function.

The wrappers has the disadvantage that they use uncommon URIs which are 
useless for the SBOM. We support PyPI without the need for an extra fetcher.

Is PyPI or crate the desired way to go?

Instead of expand the fetcher I would focus the fetcher on the download 
of provides URIs and keep the file parsing and post unpack processing 
outside of it.

The package manager lock file is a simple file which references to 
package sources. Thereby a main source could contain multiple package 
manager lock files. At the moment we have no fetcher which reference an 
other source as base or combines multiple fetchers.

Based on my two proposed solutions and the work the last month, I have 
the following feasible requirements:
* Support patches for the package manager lock file to simply updates, 
back ports and upsteaming
* Support multiple package manager lock files per main source
* Include the real https or git URI in the SBOM
* Include the dependency name and version in the SBOM
* No manual bitbake command call after a SRC_URI, PV or SRCREV change

The following code is mostly used in oe-core and ignore the implicit URIs:

     src_uri = (d.getVar('SRC_URI') or "").split()
     fetcher = bb.fetch2.Fetch(src_uri, d)
     for url in fetcher.urls:

The following code is used in the archiver class only and includes the 
implicit URIs:

     src_uri = get_src_uris(d)
     fetcher = bb.fetch2.Fetch(src_uri, d)
     for ud in fetcher.expanded_urldata():

My last series enable oe-core to generate implicit URIs and therefore 
replace the usage of the plain SRC_URI with a function:

     fetcher = bb.fetch.Fetch(get_src_uris(d), d)
     for url in fetcher.urls:

The SRC_URI contains the given URIs and the get_src_uri function 
contains the given and implicit URIs. The concept is taken from other 
classes like the spdx classes which use files to exchange data between 
tasks.

I have no idea how this "strong API" should look like.

--------------wn0qpzhJ0la3WLVupH5psMWY
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Am 17.02.2025 um 13:43 schrieb Richard
      Purdie:<br>
    </div>
    <blockquote type="cite" cite="mid:d30c619392f62f2d40320b01da5ca95369f3e7c2.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">On Mon, 2025-02-17 at 12:00 +0100, Stefan Herbrechtsmeier wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">&nbsp;Am 13.02.2025 um 11:43 schrieb Richard Purdie via lists.openembedded.org:
&nbsp;
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">e) add the ability to add custom hooks in the fetch process to
handle
the cases of needing to alter the flow for patching the components
list
&nbsp;
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">I fear this isn't easy possible and we have a design problem. Bitbake
and oe-core assume that a patch doesn't influence the fetch and that
the SRC_URI contains all fetched sources. Many code use the Fetch
class or the SRC_URI direct and doesn't expect recursive implicit
URIs of gitsm. In reality the SRC_URI describe the given URIs only
and doesn't contain the additional implicit URIs. The task flow
applies patches after the unpack and prevent patches to the gitsm. In
reality a patch could influence the implicit URIs and isn't
independent.

I would recommend to keep the patching outside of bitbake and instead
handle the implicit URIs inside oe-core. We could write the implicit
URIs into files in the work directory and migrate the scattered
direct users of the SRC_URI / Fetch class to a common oe-core
function. This functions returns the given URIs and optional any
additional implicit URIs. This allows the usage of the task
dependencies to ensure that the implicit URIs are resolved before
use.

The package manager lock file needs a single unpack and patch step
whereas the gitsm needs a recursive unpack and patch of every
successive gitsm. This makes it impossible to use additional tasks.
We could add the resolve of the implicit URIs to the fetch task to
support recursive resolve (gitsm).
&nbsp;
1. download SRC_URIs
2. exit if no URI is marked as unresolved
3. unpack unresolved URIs
4. apply associated patches
5. resolve URIs
6. goto 2 
&nbsp;
This will eliminate the need for the partial implicit URI and gitsm
support in bitbake and makes the fetcher code simpler. The patching
could remain in oe-core and patches could be applied to gitsm and
package manager lock files. Additionally we remove code duplication
and simplify future changes to the SRC_URI determination.

It will add an indirection for the SRC_URI but the current code
already shows that this makes problems. Only the archiver class uses
the expanded_urldata function and all other classes including the
spdx class ignore the implicit SRC_URIs.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I'm a bit worried we're getting caught up by the terminology. We don't
necessarily have to &quot;patch&quot; the component list so much as allow
something like a function to hook and adjust things. That then removes
the need for it to be a specific task.
</pre>
    </blockquote>
    We can use a common patch without a do_patch task. We could even
    call the patch code from the do_patch without an extra task. I
    propose to call the code from the do_patch task in the do_fetch
    task. It doesn't matter if we use a hook or task. We should minimize
    the work for the user. The common solution to manipulate a package
    manager lock file is a patch file and we have the code to handle
    patch files.<br>
    <br>
    <blockquote type="cite" cite="mid:d30c619392f62f2d40320b01da5ca95369f3e7c2.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">I'm also not sure that drawing gitsm into this is a great idea when it
is effectively already working  quite well.
</pre>
    </blockquote>
    <p>To my knowledge it isn't possible to patch a sub module revision.
      Is it intended that the SBOM doesn't contain the recursive
      implicit git repositories?<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:d30c619392f62f2d40320b01da5ca95369f3e7c2.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre"> I appreciate the desire to
have neat abstractions applying accross everything equally but I'm not
sure we can achieve that with the level of usability we need and I'd
rather improve usability at the cost of the inclusion of gitsm, which
is the most functional fetcher we currently have in this group.
</pre>
    </blockquote>
    <p>I include gitsm because it is similar to the package manager and
      have some drawbacks which I solve with my approach. It is the only
      fetcher that parse a file to determine additional URIs. Its
      integration into oe-core is sub-optimal.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:d30c619392f62f2d40320b01da5ca95369f3e7c2.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">I will repeat again that I do strongly feel that a strong API in
bitbake is going to lead to an overall better design that something
bolted onto the fetcher in OE-Core.
</pre>
    </blockquote>
    <p>What is a fetcher? We have fetchers for protocols (wget, git),
      wrapper around other fetchers (crate, gomod and gomodgit) and
      wrapper around other fetchers which embedded file parser (gitsm,
      npmsw). Thereby the gitsm fetcher fetch a source and parse the
      embedded file. The npmsw fetcher parse a file from the meta layer.
      The gitsm fetcher recursive combines the download and unpack
      function call in mostly every class function.<br>
      <br>
      The wrappers has the disadvantage that they use uncommon URIs
      which are useless for the SBOM. We support PyPI without the need
      for an extra fetcher.<br>
      <br>
      Is PyPI or crate the desired way to go?<br>
      <br>
      Instead of expand the fetcher I would focus the fetcher on the
      download of provides URIs and keep the file parsing and post
      unpack processing outside of it.<br>
      <br>
      The package manager lock file is a simple file which references to
      package sources. Thereby a main source could contain multiple
      package manager lock files. At the moment we have no fetcher which
      reference an other source as base or combines multiple fetchers.<br>
      <br>
      Based on my two proposed solutions and the work the last month, I
      have the following feasible requirements:<br>
      * Support patches for the package manager lock file to simply
      updates, back ports and upsteaming<br>
      * Support multiple package manager lock files per main source<br>
      * Include the real https or git URI in the SBOM<br>
      * Include the dependency name and version in the SBOM<br>
      * No manual bitbake command call after a SRC_URI, PV or SRCREV
      change<br>
      <br>
      The following code is mostly used in oe-core and ignore the
      implicit URIs:<br>
      <br>
      &nbsp;&nbsp;&nbsp; src_uri = (d.getVar('SRC_URI') or &quot;&quot;).split()<br>
      &nbsp;&nbsp;&nbsp; fetcher = bb.fetch2.Fetch(src_uri, d)<br>
      &nbsp;&nbsp;&nbsp; for url in fetcher.urls:<br>
    </p>
    <p>The following code is used in the archiver class only and
      includes the implicit URIs:<br>
      <br>
      &nbsp;&nbsp;&nbsp; src_uri = get_src_uris(d)<br>
      &nbsp;&nbsp;&nbsp; fetcher = bb.fetch2.Fetch(src_uri, d)<br>
      &nbsp;&nbsp;&nbsp; for ud in fetcher.expanded_urldata():<br>
      <br>
    </p>
    <p>My last series enable oe-core to generate implicit URIs and
      therefore replace the usage of the plain SRC_URI with a function:<br>
      <br>
      &nbsp;&nbsp;&nbsp; fetcher = bb.fetch.Fetch(get_src_uris(d), d)<br>
      &nbsp;&nbsp;&nbsp; for url in fetcher.urls:<br>
      <br>
      The SRC_URI contains the given URIs and the get_src_uri function
      contains the given and implicit URIs. The concept is taken from
      other classes like the spdx classes which use files to exchange
      data between tasks.<br>
    </p>
    <p>I have no idea how this &quot;strong API&quot; should look like.<br>
      <br>
    </p>
    <p><span style="white-space: pre-wrap">
</span></p>
  </body>
</html>

--------------wn0qpzhJ0la3WLVupH5psMWY--

