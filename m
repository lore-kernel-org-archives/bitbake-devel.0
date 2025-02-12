Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A003C02198
	for <webhook@archiver.kernel.org>; Wed, 12 Feb 2025 08:56:35 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.138])
 by mx.groups.io with SMTP id smtpd.web11.10707.1739350549196357810
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Feb 2025 00:55:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@weidmueller.com header.s=selector2 header.b=gw2vv3lz;
 spf=pass (domain: weidmueller.com, ip: 40.107.241.138, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KafJlMo+teHrJVmxuaxtw9rR8x58WgIukJZqZZb+c3HVJGFPgvkUFZvNKUdaN50pLEEAdOHJ+0IyaP3eX35x6dIVJpGEfVIbL4zEbc9MYytPjLBNALrwvvn+ELVL9QvRfINOfkGb9DDELPQNI2ivuw90z9iBLT82gkAxQ2cLRts9VbtyHQhLyvUU+LqL3I4m00w6lXXEzK/bQwthJT1aoDeKHMzZ8Xh3sB3yLds5hETtFHo3r2/s4SB7ys6VdHeKj2sR1LR0t/cwpFFkOt+BlH/IXsBd1OMmpRNLNphKtwwTijl00UC98xYqyrG0ODMRWjVgR1WYhyeis6KG8YPzDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=duKtdFoPydlvxv9kKsa5dVZODVs0DJQCpGwQ+Qsho9c=;
 b=sNuJm3yOXM5dyeqGtApeXP4d/c670VxNRha47xO5d2gf7AIUmJB7/gLC6arl10jrAHutAEVH62ATjQWf/VO3kUXnHuT+QnTIgvnlxvGzHyTChmCARuN/PBvtDVNDiGpveIIkuRZYuy2WgAhuoVxFNI8AUX4Nt7h/NKiDN97qiSvUHk0E5C3vtszj5Aqs++Bimig0SbBD88Q5OBTTc5k8xIu365jPgvH9I5U3cyF+G2kx/M/TIhW35TquANXGMzCzsERBJN+uQ4zcHajnQbzZP/0S9sTSUvs77i5HOOg3ze56lz64g2u7pFCeZAGpAjkRumXuSDFvEAetdr4C+fCD8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duKtdFoPydlvxv9kKsa5dVZODVs0DJQCpGwQ+Qsho9c=;
 b=gw2vv3lzwLCsNitdrCeWREUbBCCAlkUHPhUFhs2dQ6WSV67R+aMSumAmyb1AZDP0YmOjSWmE0OfwtVJoshCRHkioZeH/PcsuWrXfvJ4DHn/7vAGTi5RhTu/huR8HlMgPI97rr4gRfkx97hRlsr2UCWTGRWRQkzPBmAipSxo39XPw6XFPEazcK/HlI8Syrl/nFq6Hnx8FvxjfH5jnOmjAYTRPvXl4u8EV3KuB2TsE6KP6tWpr6YwyQobPFsTNoVbsKeP304cDqr0J8JPQ6aWcNsBS5fzQ+UkgIkxSbVubDT9Q9tIPBSDG6AoObOixB7TFdqHIV3pLVcZEK9mp66ALFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by DB9PR08MB6651.eurprd08.prod.outlook.com (2603:10a6:10:26e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Wed, 12 Feb
 2025 08:55:44 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 08:55:44 +0000
Content-Type: multipart/alternative;
 boundary="------------ZcNi2HFnZDraFwSd4Q6BsCXl"
Message-ID: <81801173-8a60-4278-a8b1-70715fa5accc@weidmueller.com>
Date: Wed, 12 Feb 2025 09:55:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [RFC PATCH 10/30] conf: bitbake: add
 SRC_URI_FILES variable
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
 "openembedded-core@lists.openembedded.org"
 <openembedded-core@lists.openembedded.org>
Cc: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
References: <20250211150034.18696-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <20250211150034.18696-11-stefan.herbrechtsmeier-oss@weidmueller.com>
 <DB5PR02MB10213E77A6A5281EE044BA688EFFD2@DB5PR02MB10213.eurprd02.prod.outlook.com>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <DB5PR02MB10213E77A6A5281EE044BA688EFFD2@DB5PR02MB10213.eurprd02.prod.outlook.com>
X-ClientProxiedBy: FR2P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::20) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|DB9PR08MB6651:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a39ff40-b2b0-481c-a13a-08dd4b4308db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|8096899003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RmRWeHh1VmtUU3ZGRXh6Vkp0cksrdnp3WVpVN0l0RnBjTCtSTk1WRjZxcTQ3?=
 =?utf-8?B?b3VBclI3Ykt3elVsUGQ1YUJVOTQ3eUtzaVhucis1bENYWnRZUnIySjBPZ2p6?=
 =?utf-8?B?bnRUWW1BUHVmbHNMOEZFcU5IcDlURVZGZWV1SnpZbWVWTk9EMUFrcUNKNVBI?=
 =?utf-8?B?Q3NqRWRBTzR4ZlI0Z0xsbFBFY3dwV1dwS3FhVXlPV2NBanpnbHRtS01ESlJM?=
 =?utf-8?B?dFk2OE9LWHQrNFBsLzFpSFlMb2dKRFNQZ21lT05rYUc5OVpUbEl2VTRjeWtl?=
 =?utf-8?B?L1ZIazhVL1U1UFpLcWNIa2tPeUdPOFlTYlM4VW1oRmx2WUhUaStodk9KemVt?=
 =?utf-8?B?WDdVUFlQcEVFdDJyelNSM2dqVzMyZ1JlT0FLM2tWc3hOWERjNFdWc2pNWFMx?=
 =?utf-8?B?UFpySDdpNGhqcTQ0ZWJjZW5laTY2NWxiK1Fka1RSSFRIaWNvc2RQUTdSSFdB?=
 =?utf-8?B?YjJNNkcrN3Z2N3dTdlh2dmI2bnl5QVM5eEhpVzNoVVVJeHNmUERkdysrbHd1?=
 =?utf-8?B?ajZjSmJhUE41L1FONnFqMTdHcVg5MGtoLzhlUVhtNEh5eXdtZTcyWGVyeG9s?=
 =?utf-8?B?WGlxVDB5bEoySUU4ajZBeGdJSTRHMStQRXlZWjRaYjZYSXpHRnVOZHg4RG92?=
 =?utf-8?B?VVRyb21QN1htbmZ6SzRObHdYWVVkd3VEU2hyS2lXVzZVWmlXL1hPOXhFZDJ3?=
 =?utf-8?B?dUx4YWw3QnlUeGZQUUsyYTg2Lzk1WEtJWWZSRHcxRjUyTnI0bDBiVHpDM2xs?=
 =?utf-8?B?bkJaMm5JTmErSGpGSGp0aGFWdnRMdnJraUZwZXVtK1lSeTliUEZ1RkJacXlD?=
 =?utf-8?B?ZDVHbVFaSkFCdzA0NTd4NWhOazY2Q3NZbVRzbCtyUzBGQnRTakljcThRci9M?=
 =?utf-8?B?aldvZjA2MXkrK1kxc0dUMXZjWVc4MStmcCtRWDdkcjFGMFQzQzNITEJGTktZ?=
 =?utf-8?B?cHJWWnd2cTBjYk4rc3VldHFnNkdORklWLzdZdVZtRzVzc2gwK3htRnI2ZU5S?=
 =?utf-8?B?bSt4alpFNEN4dDhhUlI2ZFhtZjRGSThIM2hlSk16WnMzTlhRL2lTSFlHVjhJ?=
 =?utf-8?B?cEl0WkZNQjFobmZmcmQ3eEdkTUF5WDd0SFNoU2xvWGNtVEVDL1dYalZybkJZ?=
 =?utf-8?B?UXpHT3JWUlVTZlJoem52NHBNYWI4cGFFZWZiK0hIRDJSaWJsdTZhS3pyOEtx?=
 =?utf-8?B?S0pOWXF2SmNhNWptZW5tMW9MTUNFUFRJWTM2NVNlQ0dTT2c5NzNJeTNoQWM3?=
 =?utf-8?B?UnB3eEJJcmh6S21MVndrKzY0aEJJNmpUVlV4eE5MK25rdUZhcml4L24vbGpa?=
 =?utf-8?B?K3Vra0VObThqY0VlY0J3c01HZXZudHg2VXRUaDNxZEFKWkZQakgzdGkvQ0Yw?=
 =?utf-8?B?aHV5UlJXSnFxN3F6bmtEcjhSMHN4QnNGdlN6RDA3SEl0RVNPakFyaU4zaWl2?=
 =?utf-8?B?NWdXZkNaMlFNdi9LYThZU1VLdUFFNUtQaHVpdnB0a0dFU2hhbWhvTHBVZWJG?=
 =?utf-8?B?WnJyNDNSSTRwcDRXS2xNREpDYXlWdEROMlcvQlcxUWpiTUdhUkdRVUMwUzRi?=
 =?utf-8?B?YVlqRGxzbm8wTk1PR2xSdWR6Vmd4RzdUSGJkcTZhN1ovRWg1MmN5UkxaeGta?=
 =?utf-8?B?TGZnYUErQm44VXV0UDk4SUZsSjJFNGRQMGFHajhyN01JeXVvbjhLWGxwOTZS?=
 =?utf-8?B?MG5mUDVaOHRWcWVXSnNWeFBQQnRVVlU5SWd1blBZR25uSG9Qdi9GSzJQcmRw?=
 =?utf-8?B?ZUZRc3IxR3RZQUt5d05HdURYV3dZT2lOeXZSbWxGVzdBVmlONEd0UldHbXlR?=
 =?utf-8?B?MnRuVlZaK1EvUDlRK3piL3IxSmFORmhWODVrTi9ISnRrZW5SUitWNGszdDZ3?=
 =?utf-8?Q?etluDMX/hxbuk?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(8096899003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZGIwS3dRUkFUR3pYMWFYb2lVcmNJTDlsOGVHc0VZOXdMRTdJNWE5cXVSV1Nq?=
 =?utf-8?B?eDJlU0MzM0FwUFJaTEJ1SFpZbTFBZGxzM0I1SHVMMVlUZ2tVM0UwakFHcHF2?=
 =?utf-8?B?bHAwRnRrOVovOUo3N0k2MVkxODQ4UHdlbzVGTTVBaDNkYldmQmVEVmpSbENt?=
 =?utf-8?B?bk1uN1dxMXdSZlQ4aWxVeEl6SEpIVVRkMW9selpwOWJaS05OMm5MNXgrSlFt?=
 =?utf-8?B?RlI1ZFhGWHVaTFFoVE5oQ3RUUDdMQmZza1RpK21oUkMvK2l2dmpFeVB4bDho?=
 =?utf-8?B?TGEwQW5nNmFhNDJUTWhNY00wd1RndFowOWY4b0R2Y0hDcjBmNkdwQWtSMS9J?=
 =?utf-8?B?WWVoZXdDbFNYNEFvQ0ovS0FWNXlmb2k5NUVhVVFhL212YUNxSHM0QTlETmtP?=
 =?utf-8?B?TkJJZ1dlb2ZQL1VCTGVIRU9tWmxrelhob2plc3JiOHVDMUU4Z0h0elBVcGov?=
 =?utf-8?B?UnFlM1FDZmJHdjl1R1VMZEJZUlIrdFBsWUFOU2tJM21ROFhlUDVIQVFJQS9U?=
 =?utf-8?B?dElNaXlGTFJKZTVzNFNhUkhlOTJhUjNvL1VFNHB4S3RLY2tmNU45SnFDbXNS?=
 =?utf-8?B?blVGR1o3Y1lqMGw1Qzg1Y0s0MkkrTkNDUEh2ck01RlphcjdEMFBqeG8wUkhY?=
 =?utf-8?B?SUFKZndLUFpmRkJwNnB6YURpbWg4Y3BnaXdaZHAvdUtvUGF6UTZDUE9wcjRI?=
 =?utf-8?B?cnVjWCtDSDBpUU9LY2xSM04vWHU1bjJyRy9jbGFqOHlUWUNOeVZNakdhS1lZ?=
 =?utf-8?B?YjlJcU5vb3RETUlEcXNYK0oxem5iS2lVZm81eDFFWWRVc1hZNVNvUlNqVEE3?=
 =?utf-8?B?UjZYRDk4WnBuN055N1VxL3hpVE91d3ZOTFcyQXlXajF1cm9zK1ZjUjR1RGY4?=
 =?utf-8?B?QUx6UWhyeEw1T1JLbCtFQmVQT21TTlFZRFhia0RFNVFSdVQ1Vll5Tk56VEJk?=
 =?utf-8?B?OFowWWV3bHhhMjJ6NGNBcm42MTVkRmMrNnFpa1lXeThDd0ZtdnIvQ2hOMGFG?=
 =?utf-8?B?ZnBrOUV3NWUxd2tNNldMU2xiOGYvbmpCWm1SWVhUbDNiVGRmeTZWV3A4R1pu?=
 =?utf-8?B?UDdjVFRzUUhnU1FIT0RvRzJjN2NGN0JTdXg3MURlNktFVVp2aEFDOUhVMyt0?=
 =?utf-8?B?MEpQcHcwZzhQdHhrU05NRDNwT1NwdmMrNU11Z0pBR2VZbXpGbHhDbzA2a0hR?=
 =?utf-8?B?d0VDa3JDbEE3UmF0dVE5aE5xL3c3Y0lGUkdteGFaRFNiRVRTV0JBLzJlMDJI?=
 =?utf-8?B?Uzk4Z0NkanRaZDl3elZpdHFrQ3JOVU9GV1RaaG1TeVo1Y0FLUFpLclk3MG9i?=
 =?utf-8?B?cXg0eEZaM2Vxb2JmMmRobjB6UXVsQVRpN3I5eVA2VmNKaVUxVGdBN0Z4WXV3?=
 =?utf-8?B?Mm9KelR3dWY3ZmFiVlE5Tm00WU1KVTJva01rMzF3cnFaWkgvRWY4UjZ2akpP?=
 =?utf-8?B?RndEMzJBcHdFWDYxeDNTRE4wbjR6ekFLREp4NVhzdUlEaFBoOEtlNW15Smo0?=
 =?utf-8?B?MWtyS1d4T2lpZHpkc2YySUxoWmhReUJsdmF5Vmd0b0ZtS3N1N0RXcDVZOHpD?=
 =?utf-8?B?MVdad2pNMlhObnYyNnBydXNzR0pYUkI5a3FmcElsWmxpRm1Xdy9JUVF4Z213?=
 =?utf-8?B?M2ttb2ZOaFd3S1JGRGJScU4zZFpHancvU0cwWCtHbFFkYzdRZmhCTDJheWV5?=
 =?utf-8?B?S3V6YlliQVpUVGxHOVIxOFlIdzdEbXBYWDlrcnA1QUhWMjV5ejFzaTVpMDFm?=
 =?utf-8?B?Vlo2d3NGRndZazNDM0plSnB4bk8za0wrYmRnMGFPTG1BYVZ6VUpoMjZub00y?=
 =?utf-8?B?cERTd0sya0ltQmRtOHVrRkpUMjNqZXhUY0VqZUlsN2pOdllBRThjekx0OFov?=
 =?utf-8?B?T1J3Y2M5UTQxdzlvQzVkMDVRVTdEeHZKWWJiTU0xR1VNVnVrdFBMdlRWaWJ1?=
 =?utf-8?B?MkNvOEJsVDRGeW9nZzkybDB4RzU0Y1NUM1g5c0dFeGJEcERkdVkwdUVqcW5P?=
 =?utf-8?B?YkVrNHRpcDU3Z2VsbytLZDhja3pCMGc3VXZYWFdJQnRUeDh0ZUhUeTkwWTA0?=
 =?utf-8?B?OXM4Y2NzeDZESlR6djBqdzJJdVJyb2xYdWFqT0Q0b0V4VDQvby9VQW10cktR?=
 =?utf-8?B?SEhnNjh2WVhrNWpTK3lzckd5ZHN5UHVpMEF3M0tYOWljNFFZaXpEcGZqMDk1?=
 =?utf-8?B?Mmc9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a39ff40-b2b0-481c-a13a-08dd4b4308db
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 08:55:44.1882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FVg4WclXl7TvgXpbr1lO5JzLx6g8YAGqYTTuKa8QQ3GNXhFVAbaaLCfRo4mhfZILk3k7pgPsaqqsUnBD1l4+cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6651
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Feb 2025 08:56:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17199

--------------ZcNi2HFnZDraFwSd4Q6BsCXl
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 11.02.2025 um 17:22 schrieb Peter Kjellerstedt:
>> -----Original Message-----
>> From:bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembedded.org> On Behalf Of Stefan Herbrechtsmeier via lists.openembedded.org
>> Sent: den 11 februari 2025 16:00
>> To:openembedded-core@lists.openembedded.org
>> Cc: Stefan Herbrechtsmeier<stefan.herbrechtsmeier@weidmueller.com>;bitbake-devel@lists.openembedded.org
>> Subject: [bitbake-devel] [RFC PATCH 10/30] conf: bitbake: add SRC_URI_FILES variable
>>
>> From: Stefan Herbrechtsmeier<stefan.herbrechtsmeier@weidmueller.com>
>>
>> Add the variable SRC_URI_FILES to collect files whichs contains
>> additional SRC_URI lines.
>>
>> Signed-off-by: Stefan Herbrechtsmeier<stefan.herbrechtsmeier@weidmueller.com>
>> ---
>>
>>   meta/conf/bitbake.conf | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/meta/conf/bitbake.conf b/meta/conf/bitbake.conf
>> index 8b607088c6..ed67500ba7 100644
>> --- a/meta/conf/bitbake.conf
>> +++ b/meta/conf/bitbake.conf
>> @@ -745,6 +745,7 @@ AUTOREV ="${@bb.fetch2.get_autorev(d)}"
>>   SRCPV = ""
>>
>>   SRC_URI = ""
>> +SRC_URI_FILES = ""
> Do we really need a new variable for this? Can't you add some parameter
> instead to the URIs that should be handled separately?

The variable holds paths to files which contains dynamic generated 
SRC_URIs. The dynamic SRC_URIs are unknown at parse time and only the 
file paths are fix. The files are filled with generated SRC_URIs via a 
separate task.

> If a parameter is not appropriate, then the name of the variable should
> be reconsidered. Based on the name it is unclear what is expected to go
> in SRC_URI and what should go in SRC_URI_FILES.

Would SRC_URI_MANIFESTS or SRC_URI_MANIFEST_FILES fit better?

--------------ZcNi2HFnZDraFwSd4Q6BsCXl
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Am 11.02.2025 um 17:22 schrieb Peter
      Kjellerstedt:<br>
    </div>
    <blockquote type="cite" cite="mid:DB5PR02MB10213E77A6A5281EE044BA688EFFD2@DB5PR02MB10213.eurprd02.prod.outlook.com">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">-----Original Message-----
From: <a class="moz-txt-link-abbreviated" href="mailto:bitbake-devel@lists.openembedded.org">bitbake-devel@lists.openembedded.org</a> <a class="moz-txt-link-rfc2396E" href="mailto:bitbake-devel@lists.openembedded.org">&lt;bitbake-devel@lists.openembedded.org&gt;</a> On Behalf Of Stefan Herbrechtsmeier via lists.openembedded.org
Sent: den 11 februari 2025 16:00
To: <a class="moz-txt-link-abbreviated" href="mailto:openembedded-core@lists.openembedded.org">openembedded-core@lists.openembedded.org</a>
Cc: Stefan Herbrechtsmeier <a class="moz-txt-link-rfc2396E" href="mailto:stefan.herbrechtsmeier@weidmueller.com">&lt;stefan.herbrechtsmeier@weidmueller.com&gt;</a>; <a class="moz-txt-link-abbreviated" href="mailto:bitbake-devel@lists.openembedded.org">bitbake-devel@lists.openembedded.org</a>
Subject: [bitbake-devel] [RFC PATCH 10/30] conf: bitbake: add SRC_URI_FILES variable

From: Stefan Herbrechtsmeier <a class="moz-txt-link-rfc2396E" href="mailto:stefan.herbrechtsmeier@weidmueller.com">&lt;stefan.herbrechtsmeier@weidmueller.com&gt;</a>

Add the variable SRC_URI_FILES to collect files whichs contains
additional SRC_URI lines.

Signed-off-by: Stefan Herbrechtsmeier <a class="moz-txt-link-rfc2396E" href="mailto:stefan.herbrechtsmeier@weidmueller.com">&lt;stefan.herbrechtsmeier@weidmueller.com&gt;</a>
---

 meta/conf/bitbake.conf | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meta/conf/bitbake.conf b/meta/conf/bitbake.conf
index 8b607088c6..ed67500ba7 100644
--- a/meta/conf/bitbake.conf
+++ b/meta/conf/bitbake.conf
@@ -745,6 +745,7 @@ AUTOREV = <a class="moz-txt-link-rfc2396E" href="mailto:${@bb.fetch2.get_autorev(d)}">&quot;${@bb.fetch2.get_autorev(d)}&quot;</a>
 SRCPV = &quot;&quot;

 SRC_URI = &quot;&quot;
+SRC_URI_FILES = &quot;&quot;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Do we really need a new variable for this? Can't you add some parameter 
instead to the URIs that should be handled separately?
</pre>
    </blockquote>
    <p>The variable holds paths to files which contains dynamic
      generated SRC_URIs. The dynamic SRC_URIs are unknown at parse time
      and only the file paths are fix. The files are filled with
      generated SRC_URIs via a separate task.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:DB5PR02MB10213E77A6A5281EE044BA688EFFD2@DB5PR02MB10213.eurprd02.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">If a parameter is not appropriate, then the name of the variable should 
be reconsidered. Based on the name it is unclear what is expected to go 
in SRC_URI and what should go in SRC_URI_FILES.
</pre>
    </blockquote>
    <p>Would SRC_URI_MANIFESTS or SRC_URI_MANIFEST_FILES fit better?<br>
      <span style="white-space: pre-wrap">
</span></p>
  </body>
</html>

--------------ZcNi2HFnZDraFwSd4Q6BsCXl--

