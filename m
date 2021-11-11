Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE27BC433EF
	for <webhook@archiver.kernel.org>; Thu, 11 Nov 2021 07:51:25 +0000 (UTC)
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (EUR02-VE1-obe.outbound.protection.outlook.com [40.107.2.62])
 by mx.groups.io with SMTP id smtpd.web09.7733.1636617083135719230
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Nov 2021 23:51:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@weidmueller.onmicrosoft.com
 header.s=selector1-weidmueller-onmicrosoft-com header.b=dWfC2mlX;
 spf=pass (domain: weidmueller.com, ip: 40.107.2.62,
 mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GT8aMPXkJq3gypPknldXVgTWfYtuPo4qP4rT3eOiWJYnLeJDG8GBnQ7h3Rn1awk2gTcAmB9OEE/3QjzDvmJX7yy31IofHMEqwC+1NLQGDFC6cTTQngUpinizPFt26s2exTaww7QZuyhtMHAKCtJZ6nBPKjbTE8IkKQ2jqqK2SbXnbVMBnGQks8o00uE2ZEnDvQOyZ0mhFW8FutKWOpUOKqjXyzoyLtxDPRwq/oIeJmxOqiCdOMhYXumg6p/g6RQ5w3fCBukIKQ4lIL1U5c/aTpa3RFIfXFE/46xb3JOleFawEY/1EsPxXvUCyIyIFE4RnqTlzoUkd8rR2RCtldUihA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lic+TW1JHo1m7IUrq2UTeAWSUcjTjMiumms70eBGgfs=;
 b=iswjE9sgsS/PTxu+1j7jiAe6biZNgIpzDVLD9CETDt3HVuAKRMamLIpxzsSTSUbMZGHjeo1XI2W2u2/TLQwLe9E9dHKpTjFYhFznJ57Ep+GkA84k9p+nDRb5I+NjbT/X7PxaLVwzVcTmHGoarYX8UC/MCHFyTIVWzfhSZoYxGPovwsDiFeHUBLm/PIYBGmOpgGedLg5pbN6nJjd16cyiD5cRze1E1+tatxj+kVYlQI2GzjKDvj4tArcyk6hJRs9vQZJHjIvQGa6QI2XmIKehcQ8KHs2epP1BsTvH+tOFbG66hjdYrH+tniTGV11iuLivX1HiTpRkGCWvBFYW42EQpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lic+TW1JHo1m7IUrq2UTeAWSUcjTjMiumms70eBGgfs=;
 b=dWfC2mlXMZm2BSJTJDqiVfoETe73O+vNQ0EQXnBbxqfcypbHfHv26Ak9BKn6salvTYQBB2JqrwZXoqk+ML/1umk5ALu2prL53bDEYFmuTXsnVWwCxBGcNpydR892okspN9cRNt7jRQbGIO4JgLwlbaQiDPuR4F8h9cDw6HUJjDE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by PAXPR08MB6557.eurprd08.prod.outlook.com (2603:10a6:102:de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Thu, 11 Nov
 2021 07:51:20 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::45dd:11b5:8f4:981c]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::45dd:11b5:8f4:981c%8]) with mapi id 15.20.4690.016; Thu, 11 Nov 2021
 07:51:20 +0000
Message-ID: <4e15b525-7df0-123e-a1d8-5edb4995a023@weidmueller.com>
Date: Thu, 11 Nov 2021 08:51:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [bitbake-devel] Improving npm(sw) fetcher & integration within
 Bitbake
Content-Language: en-US
To: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>,
 "alex.kanavin@gmail.com" <alex.kanavin@gmail.com>,
 "mac@mcrowe.com" <mac@mcrowe.com>,
 "richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
 "bitbake-devel@lists.openembedded.org"
 <bitbake-devel@lists.openembedded.org>, "martin@mko.dev" <martin@mko.dev>,
 Daniel Baumgart <Daniel.Baumgart@iris-sensing.com>,
 "cal@brightsign.biz" <cal@brightsign.biz>
References: <1c7d6bb2479af789132b3e94c44a54f1d1b5c304.camel@iris-sensing.com>
 <CANNYZj_0U_Yk4TPVxS4hQ5zdeSvZ1LZkFQ+8fv8-x9ieZ4AH7g@mail.gmail.com>
 <YYa0NeCHOjBXYsxA@mcrowe.com>
 <b9029131-1a0e-99e5-01fb-183930a36c87@weidmueller.com>
 <5b0e441cbb16215ed77df38b7734a2d38c4dc266.camel@iris-sensing.com>
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <5b0e441cbb16215ed77df38b7734a2d38c4dc266.camel@iris-sensing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR1001CA0060.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:15::37) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
Received: from [192.168.178.36] (89.247.126.30) by
 AM5PR1001CA0060.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:15::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.17 via Frontend
 Transport; Thu, 11 Nov 2021 07:51:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b09bf93c-3d4b-4a2d-d82c-08d9a4e80c6b
X-MS-TrafficTypeDiagnostic: PAXPR08MB6557:
X-Microsoft-Antispam-PRVS: 
	<PAXPR08MB655718DA2A807EF53078B6E5D7949@PAXPR08MB6557.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	DZpGpHLMIVN86hAGHjHC9vn/W4mD76IwzBdj4H2XvhmHn+mmTsevSHIFo4rVV9uQp6ImuH2SxtwsRwkVnxOrTgZZ3dQcXS7XY7nbeAKJ2kbm4tCxNjG/166KD+UNEseO009g8cQxhv91/03yuGYcII/HycMZ4lz2Ph936kl6gWRxDnHC/UyBEKyFOUeDyPMhNEvqkQ0edm8/iHARq7CJPd2PfbLciJVBoLWnEtD9MezWbE/P84dZ3CaQdWTsDOj3r4GZs49ifPEErj2sgXuZH1/6H1WAQdjMg9320cPA12rNmDza4A72TZz7EmBbhutmrEfOEWH1Cr4ZbvWp8SlGmiOj3kekc0djGC8Yt+3O9f/O1apgIuS5ml/Ro82ejI4L5tS4Qig+5FYgsRbjdrnhmv+Zd8j96ZUbYaTOFNWxltQpHeebY2dc2o1inVcPGIf8IGVT/T1HoFoE2/yoA/BIsdM0FWLb7JNuA9axuOZrEpzX4Cf3hyxGf97GjEumzxCERrJhiz6OHIB1XgZoDXIHsZXCJQxzmfd6oMQiYlWdLA26VYzK39XfGxZIeVe5K4HyWryV3VT45K5ssYYkur2WX3zeaXzWVHyKpoMmaCdFGYM8AA8HtTCV8ocIp0RVzCNCL1tgAggNd/AQGZMOBQlfzzxNnynDkgRsnrKrVKQx2gLkZAUKPFVCnftMb682N6JRXjhvIIfmyKAaaz6Ii2ZuBV9fY6Z2M7EBzyya3r6AS6TNuPdsRMCpP/wg9wWmCspXM2/LbfKXMBlfelt8274+ng==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(4744005)(36756003)(316002)(956004)(5660300002)(2616005)(66476007)(66556008)(66946007)(38350700002)(38100700002)(52116002)(16576012)(8936002)(31686004)(31696002)(2906002)(8676002)(110136005)(26005)(86362001)(186003)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OVJDWWI3eDIyM2ZZczQreFA3OVlCK0JqekpHTWlPNk5SQU5OQkMwbFI5Y2Rr?=
 =?utf-8?B?cWVvVjY0bllaaDA5NkJTU3diSWlRS2JPbjVHeWVONWFPOVdiTDV6Y0wwQWZR?=
 =?utf-8?B?RTJaKytha2VJc0pwS2VabFhUSzYwZEY1bU9ORWxiYVM1YVIzZjZKaStxdXRG?=
 =?utf-8?B?b1ZzMTNMNXRXbFFKNlFaMWpFVk5lK1NmdU5aUS9uQWhxTkp5VGhJS0JTNTIr?=
 =?utf-8?B?SWNwLytHSW5oRWtROEF2NVYrM0tuUVJZdXZGVGRqMHJHRmJlNUhadTZmcFN2?=
 =?utf-8?B?d3AzcE05S2Zza2RsU1U4SkxNRkU0Z2pNZnZ1b0ZtWi83ZytLQVVoTHRKSFBG?=
 =?utf-8?B?TklCZFd2Rmd4Z3Q0RmZBV2pUS3JUbi9vYlRseHNRWmNlOEJpYUNKcnlMblkv?=
 =?utf-8?B?SlUrWTBNMk8xWDIyYklxSk9Kdzg0MWRZTHhvVS82T1RGYXJ3cExZK1R1aUxI?=
 =?utf-8?B?azVPR0phSk9TRGdjN09KcTNSUVlBemYxMk1WU09acGdBWCsrUnQvKzlYc1Q2?=
 =?utf-8?B?d2lVZ05POTlQUkI2eG02VGVoUUc2YTFEaURPKytxN3IrZVZPUERkeE9zLzlx?=
 =?utf-8?B?OUx3Mk83emVEa2g0bmJESGI2THBNTklabDJyNVk3eXphWU5BbXd5Q1Z0UEZW?=
 =?utf-8?B?SlNkbXByZ1ozR25qZjAxdmRydyt3UnJCS0ZwSWw2RSs0ZTcxZk50Wncva05C?=
 =?utf-8?B?T1lIaFlUTURCbVJQRVZjZmVGblNIRjY1UFg3TVJDa0NXNDZjdkRaVXJZS3pL?=
 =?utf-8?B?SjFrRTNmSE9KWGxXNFN6VUgrcjRTWmJsM0JXZmFKSXFHVVpPcDlQbGdhdWl2?=
 =?utf-8?B?Vml4cFErRHJHZkFXTTE4MVl1U2tOSElQTGRXb2pUcTlpVjQzbXZTQ1YvTkdB?=
 =?utf-8?B?NGNFY0FUMjRtei9PVjNZYkdRaVJqd0NJdnU0ckl0MWpRMzB2eUxWWEFvZVlV?=
 =?utf-8?B?aDRYalVXT29zSVNuU2hkQVFZUU04bHFGd2RPVEFNMFY4RUhzQlFSV3dPa045?=
 =?utf-8?B?SDlSV0tPNkZma3ppMm0vWEpLTy95L0hqSVhyTjg3a2lVWGVzRm5IMXNZa0lv?=
 =?utf-8?B?SkJyQjhXZ25aTGpBcHhSUW5NTGtvZG5DR08yZ1c5Nmd4cllpTkg2aFU1cnZY?=
 =?utf-8?B?a2JZYVZ0SEtWSTByampXTzlSbk5sdHlVNkVHREZHMS81QjBoekFsMjNFWllQ?=
 =?utf-8?B?bXc1Mm9rWEFxTFlUdzAzWTNBM3JGRGxpVGdzZU03Zm5rV05IMzNTM09lR09y?=
 =?utf-8?B?c3JaTUg2ME5QSlFmMGJEQUlKckVQYjlwR3kvZTFHeDd2aWhCUC96NzR3QVZq?=
 =?utf-8?B?b3pvVHlyU2JGZ2Ywd0lOaDJQakFrV2NqRWpTWEdYaU9BZzZQSnNSTUIzK2Ja?=
 =?utf-8?B?OWw2R1BBV3BacUU2aG9ONncyMGhYY2d2ZGUvR2VQWjVRT3I1RXJpVCs1UmlG?=
 =?utf-8?B?NEV1WEV6VmdvaXREMFhLbjJFMlN3S0Vickg4YjljdFY3bzM5bFdod2RlaFhQ?=
 =?utf-8?B?Skd1MmZVMHJWWUx2cTh2YWlacVExa3JsRjJoUUdkTG5kSk5VUUFqVzRJeWJm?=
 =?utf-8?B?M0Q0YllGTG96NWdYaWxRU3pJVzgxMEUyc1E5S3Bqa3c5aTRmSllDSWszZlph?=
 =?utf-8?B?WEV4QlY1RzZuRGtTM29GaXVmSTlIRWJ0QS9ubklsUUovYm03N1BBU2FtYXJM?=
 =?utf-8?B?Y1ova09EZWNXTVArR1NJUDBBc1hYUVZjZ0FiU1VFNmtaWDVld1lES09lbGhr?=
 =?utf-8?B?T0R3NEVYNEp6MHA1aDdqNmI2ZFhZZGdFcEhWUXdySjRQWkpFZnh1Sk5sZ0ky?=
 =?utf-8?B?Z2FtODJtOXFNVUgxUDBWWENTRUNxZUxmbGQwbmVtL3NpdFNVZUlKUzlmNHpr?=
 =?utf-8?B?VXhOMlM0VVpuOGRxbURoMU5RQXRXbmw1dU9TM1hudUhmU0tUUm9BRzYvM3Jv?=
 =?utf-8?B?bklxQVl2S1JheGNReWFsRHUvU091ZkR6ZTNQV3BDbnVhUEpzd1gyRlJrdUhl?=
 =?utf-8?B?UVpWWXFjTGdKRm53WThTV1Z2TDQ4TER0N3BsUXVTOTZCdFJGczFzaDNhY2pu?=
 =?utf-8?B?OXgzSnZscDJySGZ5WUxPbE9hS01KTXBKc2RKcitoOGVzdTdXYzJuc29mY0p3?=
 =?utf-8?B?UUU2bHlOKzc1clYwR2F6L2krd093Ni9sd1JZYWk5bVIvVEhabHZRTXlIa0RZ?=
 =?utf-8?Q?n7ED8+DJhN9nI7Jh1VPFLmo=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 b09bf93c-3d4b-4a2d-d82c-08d9a4e80c6b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2021 07:51:20.0175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 ltthWjFB+iN6DppHbkWsYZ0W9KJVkY7YKpPvsNmaLDKAzc8vVi9lkRwRJd4w9U7ENIABVxjU/aPv67kFMHCgZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6557
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Nov 2021 07:51:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13000

Hi Jasper,

Am 08.11.2021 um 13:44 schrieb Jasper Orschulko:
> would you (and any other interested party) be interested in a
> conference call with Martin and I? We are greatly interested in your
> current prototypes, how they perform for the various usecases and
> if/how we can help you with the implementation.

I will contact you both direct to schedule a call.

Regards
   Stefan

