Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69190C54FB3
	for <webhook@archiver.kernel.org>; Mon,  2 Jun 2025 09:49:45 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.49])
 by mx.groups.io with SMTP id smtpd.web10.45938.1748857775915169153
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 02 Jun 2025 02:49:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=k9T50kbJ;
 spf=pass (domain: cherry.de, ip: 40.107.130.49, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nXZ25z6TuyFOc6qiZznON3aSEzd8Ox+z3uvMeHrusPa8itDwvv0660uPyDO1KaBiwazyzijd6+96+Ezj3VElUf52qCn0rjXzyggnpte6KgZGxuLh82CCqHydjFEjfMdQnmSgTQIYQ6hZgbD1A+KZERhiz0H9+MxuJZq0IO0S9V6wHfP1lviHhVeHOLqihBrkd0PjmQibGnQCOiBTO6v+DWf5RWSvG48vLyv/YF8akJiudDEHsC4UjJEBYgZzGAjy9YLcwJyyV4hwdzKjVt8CmqBZ81bzpu07qaLESmZ4LVhR5ZbfKw8dLP8hGc0vPQvJNBWABuKAlOSaDAzKX/r8oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S52MDr65OeCdTKvDXVZ5nAxB9oiC+tloXrGOg2yLzes=;
 b=R6Tz2BFhaq48RKCuANPE331hoRWV5iQ2tggN5e4pf0UuheFjWDkRMjNOFxlNF7Mfmbb05NfOVK9JhUo5c9xrcAfnxDiKrwb+caJhFCkMVO0mblYtp+pi9v9yNgvMQIvkUlXduxfuLGDmvwlWMYBT+kOuVQNDXn2Yhz7D46YXJVyz36DDI4+C68gZLyAdv9sKXnA3buFpmEOBXd+RKaRy+GD4dLbYhN+yGf26pVkDacJ05wjy0NknG2FQExoClNvuFsae7NdprKC8WRe4/jSQTuyKwt2G/pN24qytE23KdD0YFe7PBuq/r7BOzzIvpvRNcIfs7qKijI+8YdKuPIgccQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S52MDr65OeCdTKvDXVZ5nAxB9oiC+tloXrGOg2yLzes=;
 b=k9T50kbJLxwAgSlHD5AZH495Cz/wJrGLxDdqSngcD5y3tS7hzgfReHZ5WpZHMBdUzN2aNfDCg4N9Pk5lLTnSd0PDJGW4UEjIbLcrsMXHZfODoWpE0WSOkppjGOemWvTWHoSV1h6W4ND9I1F1fLTek3bGpOxjL7Kxr+9snYynvYE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI0PR04MB10096.eurprd04.prod.outlook.com (2603:10a6:800:24c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Mon, 2 Jun
 2025 09:49:17 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8769.037; Mon, 2 Jun 2025
 09:49:17 +0000
Message-ID: <23d79ce3-efe8-4976-a874-801fa9df8f0b@cherry.de>
Date: Mon, 2 Jun 2025 11:49:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH v3] Update documentation and add extra
 check for az fetcher. AZ_SAS token should be prefixed with a question mark.
To: robbinvandamme@gmail.com, bitbake-devel@lists.openembedded.org
References: <20250601201505.177262-1-robbin.vandamme@renson.be>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250601201505.177262-1-robbin.vandamme@renson.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0176.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::21) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI0PR04MB10096:EE_
X-MS-Office365-Filtering-Correlation-Id: 1547670d-0ca6-4a57-d8d1-08dda1babd4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?S1cyb3VhNWJYY0tEVUhiNkFzS0pWai9tNFlXakxBZU4wVitkUFMvY0FTV1Fv?=
 =?utf-8?B?V2FkQzk4WHRRcWxnSmd1MTYrY2VOdG5MdEZtUlovVkNRYjdDcGdiM2JrREx4?=
 =?utf-8?B?TnRkRHpHSjRTZjJaR005RTh6enRLbjRvQjB4M09RQnQ4RXVEc3VhTDdpMW1k?=
 =?utf-8?B?N2M3TFhDclE3ekFXSmxEVzRXVUpNWDlueHJrTHZlNGdWOFNsd21BN3U3R013?=
 =?utf-8?B?RmtMbjBZYkpLTnJIS3FJSVkydzlKZklyS2Y5ZXVneW1UYWEvU0tsaXlBOTlB?=
 =?utf-8?B?elA2dnRMbi9iNzFKVFVDWVArRDNza2JXVXR4N0l0ZENYb0tzYVdHd2kxemFq?=
 =?utf-8?B?SWtnQXRTczBHcFUyMWxGbEYvWFpHWFNoeGRQZVhwd0dtcHRPb1Y0NEMvTjhR?=
 =?utf-8?B?SDhlc3h6TjhVMTh6R2Zad09mZXVMSFhFVTFNdmdGS0JhWWsxVnNXZEMveXp1?=
 =?utf-8?B?TDUzQjh1KzFGRDhJbjdna3BtV1lYT2Y4UGVkNFV1dXZ2RXZ5ejZBZDRza3BR?=
 =?utf-8?B?eXErNlA0ZU5yWlBXaWF3UmhvRDJyMWdyckIyNDBQVHNxanNpTjRPTmxKTHpz?=
 =?utf-8?B?a0xoU3QyU3dKQVRRdWZLbHBmbW5PdDFVVVJtUXhzRStHZUU4LzdwM0tESXRx?=
 =?utf-8?B?UGx3QjFIdXhaV3krU0ZFQW1xSXVoai9ycnNmSm02aW01emZGZXFJTjNUVUda?=
 =?utf-8?B?MEcxUkRzc1ZRSGhkQWg0T0F6NDFTRVIwVTJ4YnNiUkRwakxxZldJR2VvRHB6?=
 =?utf-8?B?VGIwYVdiTmE0NDQyYlR3Qnl0QTNSdGM1Z1J3ZG01djBsY3Z6RnE3TWIxbUgr?=
 =?utf-8?B?UGJUK2lCejExUjZ3aUdoeUF1bmRScHFyS3VzMjRyVTZ1bEVQY1VvWk5EcU5Y?=
 =?utf-8?B?eWhZSCsxTHhBcVcxbEE2ZHpiSnVsUm5YVGxhWWVXVFpOS255ejdXWkZBRUIy?=
 =?utf-8?B?KzJva3BiMWFEdG03eHdGWVU2bGRWUFgzSkl6NkgxVXFoQXVwQnRHbGJsNWNj?=
 =?utf-8?B?SDYxNnZuZURqZGI3NGxuTkdCOHp1a2JqcFFmWmNTamVneHl2REo5QkdCL1pL?=
 =?utf-8?B?UjF4T2I0T0V5MEFTaExhc1hyWm9zVWZXblZhdmpWT3RMT2YwaEdndXp3RHl0?=
 =?utf-8?B?OFlSQmRZeGl1N3JGaHhENWhRaXpiZ2NHaTkxTkw0RFRQZ3N4RE5GMHI3eHlQ?=
 =?utf-8?B?MHp3RWFhREVPUFdTMk1TQ29lRVA5b3FSOWx5OWRRR1pXQ1dvZFpxbnB0bjBO?=
 =?utf-8?B?MnRpQ2RHeWhESUpyQ1BSN2JKWXUwSmdLT00wUHB4RmRZMXhXVlBnaUhtQkt1?=
 =?utf-8?B?c0g1RnZsZ3NHeldObFJJczBwd0gvMFNFakZKZE5HSytucjR4YU5RMUw1WUcz?=
 =?utf-8?B?NEtTTnlQcE5LNFV1VVBGdE9tc2VucTQ3QnlFMFZPVEQyUUJTckhVMWQxMnIv?=
 =?utf-8?B?UWV2TzJ6eGhxOWpoRVNJMml5VG5LUmx2QUpUVHdyNDVja1FsSXQ1RkJ6VXZS?=
 =?utf-8?B?elVkdHJDUDdwOUM1aEFPYTRMZTgySXlZOXJZQWlvbDlxaUZyN0RVeDRYSU5s?=
 =?utf-8?B?bjgwemFtdDR5a2lZcnNEQktFdVVKaGJMNGQrSEpaSlNDelFxZEpKaElxNlZ3?=
 =?utf-8?B?VDJFMVJmQ1g3M1l4cFdTcmRMWFNvOGROWEhqQlZsdUgxYjFOdU1SeE5aS3c1?=
 =?utf-8?B?dnFYTnoxdzM4ZzNTM0c4M3JxaWNBZmp3b2JZc3JBaFVuY0JzMzBMb1VQMzlY?=
 =?utf-8?B?dE9OcFVnOXVNKzNZVTBEcnowTDRWWmt2eVdyVkoxWFd5SkcxcHhXTEpKWkV0?=
 =?utf-8?Q?Opn5dShgcThQFgGqx15LkihmdG/d+Bw4gEcmc=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WUtxU25Ya1lSeVkyYVdQWVpEVEpjeHJiS0o2a1FMYTA2eWRmdWJraXgxd1dj?=
 =?utf-8?B?Q3lFVGNDYnNSemdyNnFZLzRGSWV6VE56Q3NKcVVvY3A2Nk1jcXVDZjgwOXN1?=
 =?utf-8?B?ay9MTXQ2NXEvVUpoWUpvc0RVcktyUmprSnlYR1NEbGd0cVdHS1Y0RXJGZ0Zy?=
 =?utf-8?B?bWN4MFd6YkNoMnFDME95SGkvc09HZmd1QWJBN2N0RHV3d0htUXJCRmx0WEpM?=
 =?utf-8?B?Q0luL1lQN3F5ZVNBWnRwbmlPL0ZCV1pMVzBXMU5xbjBPd0YvSUJ5TFJNcUY5?=
 =?utf-8?B?YVpNUTZqU2M1azlpdGJIcUtMcmExbDBYNmlKdFZuZE9XNEppdFBvcHRzK2xs?=
 =?utf-8?B?ZzB6bHdqYTVWM2F5UzYvOEMrb2pxTXBQNmlwMVlPK3NvQW5xQ3E4OGtDRHJY?=
 =?utf-8?B?TXdUeFlzYjl2WVRqY1cwWkZ5SytqWmwzbmQ2OWtvS1RSanJFYVAzcDdsaDNR?=
 =?utf-8?B?YWtzVnRwZkRabjgrQnpCelFDTUc4aWxCQk0zL2dTenhnM2R0MlpSUnJYcE00?=
 =?utf-8?B?L1Q4ZmxRaGh2UnVGd3dsWUpOZFZ0TWR4SjlNQThZUTg3aWZBN1R1cHpmYlha?=
 =?utf-8?B?c09ENng4aGVOeVArSjJUd1puU3dHZkF0TkdaeXdDelV4bTB0c3MwckxZZkx0?=
 =?utf-8?B?S2lEOWljNUlNVXlZSXV0VHZadTZwYnRCSVVyWkZ4Qnl0ZDg5SkljL2RHK0NC?=
 =?utf-8?B?RFowSVJwVjAzZy80blVZUlFHcTBsWnFxNWoraEcyWjFTL0IzSUFHVy9pNm1W?=
 =?utf-8?B?TGVFeWxBRUQ2cTVydFVkRGJ5R1cvZWk2Zzh3ZXZuU3V0R0JVaXJSbkQ2Rm9M?=
 =?utf-8?B?ak8xWkZxVDJXTU1xQVhReDdUMDRneFV5QWNiZjA0NjVhRkNpY0JyN1I1Qmtn?=
 =?utf-8?B?b25tWmJYNWxoeGo1VlJnSUp0K1N4aUdBWmJoZXBaQ09aQVB6eEhHdzd3bTZ3?=
 =?utf-8?B?bXFOMkd6dFZtMkVqSHNjVWJJdGUwQjJic0oyT3M0QmZQZkliNENHSVcwTFdm?=
 =?utf-8?B?ZkUzVEZQWW5DZ3JlNWJpUTdJSGdDSEFma1ZDODFlOVpBc2IzMytRaXQ1dWll?=
 =?utf-8?B?d0JCcG4zM2VkT2hHbnhuU2NtL2dqbkxMOUl6QXA0QkVpVTBQaXdnOTBReERx?=
 =?utf-8?B?cFBUV1VCVlliZGp1alpmUmQreGk0T3QvRlhjNngvNWV2TFRrUjRScURFc1dF?=
 =?utf-8?B?bjZyZGQrWnpxSjZmbDJYdGkvMkpBdGlydlYweHFxNE9aN0N6RHRsVUNSRUNz?=
 =?utf-8?B?dERPeEZOaE9CNnZnRC92NFB5T1QydzFkYi9ObG1rVG5xckJxZHdCdzEvUzlk?=
 =?utf-8?B?QWZMSTlSSW4wOGJzV3R4d05lK2ZzV2l6VHNJYTlSL2U5T2thWWZ5akVKYjZi?=
 =?utf-8?B?UXFud3huVG4rSm1ZTG56V2ZEZU1HdGhuZUQ0ejVrdWlndG1QK3QxQlFWVWk0?=
 =?utf-8?B?VlBQTjBBK1pPWU9RWnBGNVkvc0ZNeVUrMHdaOWhZZHlGUnc5SWlvbVRZL2Jw?=
 =?utf-8?B?bThJdUdySFlraUdlYW1QdEQ5SU9qQlZ6eWVjcnVGRnc0bEQwa2ROUVRNNnpF?=
 =?utf-8?B?bFB0eTBaU05VRGJoUDQzSGVGNnZsZGY2U1dqZjdpMkJWREo3WkJjWmJiNS95?=
 =?utf-8?B?QWFFVm1RSlNFQUsycVpvVjlWendCMjM5OS9ydE1jb1dYaHk2b1NNK0kydkdT?=
 =?utf-8?B?d3FNQXpsN0J4cTdRV21hMW1BaVFpYnRJNEd1WGh1YVVDM2NDV2htQ3pBcXBZ?=
 =?utf-8?B?eHQrTVVpcVZVR1k2a0dSb2hybTVTMUFQZE4rcDFBTkZVbFkvcnY2NElnY1or?=
 =?utf-8?B?QmcyZzBFaFNwcUdqbXQ4ZGxVc0dMaU9hKzl6S3dsczlXUTNSNTVhcHZkSUlo?=
 =?utf-8?B?by8vOUU5K3duYzBWYkhFOTZNUmRoN045bzFBN2JHN2VSVVVjays5VURUOTlq?=
 =?utf-8?B?bVc5bWxEZEp1bUhETlY4U3BVMEVHd01qOEZTbTMzTDZlT0RXRnlBU01KTGMz?=
 =?utf-8?B?NDNkaEZUL2ZXYm9va0h4VFUwVW94ajFhMWNiT2NmNjFQVDdCNnl2QXdMZ01D?=
 =?utf-8?B?Ry9YNzF0bkNxU2NrcTQ1bXB2eGx1aURsRmVLSUFNbWZzQkczZlRaSkhEbUQ3?=
 =?utf-8?B?UjZJT3d5ekM4VjlJa05KVDgzK2hOTGQxNXBOMDZpRG13VEZkWmdreHZKM3BP?=
 =?utf-8?B?K0E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1547670d-0ca6-4a57-d8d1-08dda1babd4e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 09:49:16.9832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5pagP8CiKv5/JSBPVsvarHQrQkJdA3wWepg5ipAAFhT2Ub6aRmXAJgHz/ZtDkVUmxnWJ37BtTmJklIGu3b2L7VAXH2+vdkzfvPKDi7Djx2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10096
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 02 Jun 2025 09:49:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17668

Hi Robbin,

On 6/1/25 10:15 PM, robbin van damme via lists.openembedded.org wrote:
> From: Robbin Van Damme <robbinvandamme@gmail.com>
> 

We typically do not accept commits with empty logs, so please provide 
some backstory for this patch.

> Signed-off-by: Robbin Van Damme <robbinvandamme@gmail.com>
> ---
>   doc/bitbake-user-manual/bitbake-user-manual-fetching.rst | 4 ++--
>   lib/bb/fetch2/az.py                                      | 4 ++++

I would highly recommend to split this into two commits, one for the 
documentation and one for the added FetchError, those are typically 
reviewed by different people.

Also, patches to the doc (yes, even the BitBake docs) should be Cc'ed to 
the yocto-docs mailing list, c.f. 
https://git.openembedded.org/bitbake/tree/README#n32

I see that Richard has already merged that patch, so just think about it 
for the next one(s) to come :)

Thanks!
Quentin

