Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390ECC282C1
	for <webhook@archiver.kernel.org>; Fri, 28 Feb 2025 07:12:37 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.92])
 by mx.groups.io with SMTP id smtpd.web11.10468.1740726750517213993
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Feb 2025 23:12:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@weidmueller.com header.s=selector2 header.b=XJl3V2o5;
 spf=pass (domain: weidmueller.com, ip: 40.107.105.92, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PgOYEqgAiBOe/XqkzK+tCybpaiEDgA5mlbaOujoZoMXx7iLF3C5tNX1KyRJADNt/jmectYdtBGyF4Y8LAb316qdGPWjinvcSHbC1VzxGbBLwWpkd/l66CP73zKvj+crvMsWHUQCrXWFKXyM4psvyAP9gdJRvqEGtSCgeuH4kVvieF3hmuygac+YAIzbJqASr/C/WOyZuv9/rhp5gHU0ObmbLob1AbB1GdrL+QZ7FgfAdGlt1HRquviYfyd+98tXkgxTU8ihuL/5p5dkVQJ9xn27vdvO5hlCIMq0DiUqhfA1xjTkijk2R/NK6H5ek3cuMhu60TZPD95fjlLabFe1ZMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRP0iXbFrM6hXNymC6TBqxcX7LwkdY90+oPx9LbePSA=;
 b=kp7DYBnY7c+IP/mGcPwoDr+T40PUgiCve1gKhJC6kxTuvBhCJsM95EZ0dNMn4sZtvH8sw/MjSS+UrQ/8mheTzpi43iPI3CfRNIX1RAW6aYDJ0eRFuCvAA2pP4yXbmkYXkANTXp32UvVwyAwSf529y15hotZo+WPX+Kgg0/qcF6OjMPnvQh2l6IIg/Zjtte3b0ZgJbaqvU8yIJ2rbjxm2HyEGWbs0QAvhVBXx8NVedq652XMu7UCCprYRK2tI/iFqGZXer7jRI21Agvi+l9dEg7C46kmgECKj74cpib06YULvmJjaGcJ+czTFFxBPs8G1piJ7iolppaxpi+MG/rQtrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRP0iXbFrM6hXNymC6TBqxcX7LwkdY90+oPx9LbePSA=;
 b=XJl3V2o5AG8MXhsEPgnpcbduKotjEViWenpxKqMt9IbjNeTgRYPIW0WK4QomIdqWDcaA0C4BrV+2grrxHaF9X3UVaerBFp5DLL45WUD7J/ncoxtxAXWlv1pshDVKClvDnsJQFRMaj/KYFiv8VhNvGjakA6yVHHRNU9zazLFYvFiSCXB/et9y8MvLfL3DLedLnB0ShiQoiU4QN2rJ0cZSNH190RtRB7l1Og2JkqK24CCKUso798C8XYRGyapuQr+4je9xfCy98qw6VVaCXas7TEgSMFExEYXiIQwgbAGKTKy2SxAiFmfFySVNo2GmMIdSzQ0H24O3HSbkvuF7w5v8tA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by PAXPR08MB7621.eurprd08.prod.outlook.com (2603:10a6:102:23f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Fri, 28 Feb
 2025 07:12:26 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 07:12:26 +0000
Message-ID: <9b99dcbc-8918-4858-9dd6-6c54fb577b39@weidmueller.com>
Date: Fri, 28 Feb 2025 08:12:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH 05/13] fetch2: remove duplicated code in
 url decode and encode
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
 "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Cc: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
References: <20250207124701.14787-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <20250207124701.14787-5-stefan.herbrechtsmeier-oss@weidmueller.com>
 <AS8PR02MB10201794A0F8A9E55844F4430EFCD2@AS8PR02MB10201.eurprd02.prod.outlook.com>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <AS8PR02MB10201794A0F8A9E55844F4430EFCD2@AS8PR02MB10201.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::9) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|PAXPR08MB7621:EE_
X-MS-Office365-Filtering-Correlation-Id: d16f656b-2ea0-4314-ecc6-08dd57c7413f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aGplcUU5a0VSSnkxK0Q3MHViNzJ6bVNqSlR0OWtoNmRoaXVJMm5zakxreGRx?=
 =?utf-8?B?S3VGWUhSYit3cGozUTRTR2lGakxFaTFuNS93d1NFYldVL1V1cjJ5UW9EYjVV?=
 =?utf-8?B?ZDlCRlF1cVloSG0vbGtyTmlVTVpwSHNmd2szcjkyOVpDNTZUT211Mm8vS1ln?=
 =?utf-8?B?ZEtuTVcwNTNWWDFtTHYyQ0xONXRxQmNxc1JEb0NRVjNoR1ZFRTVQMDRDOHNQ?=
 =?utf-8?B?ZlhhZndaYUtXYnJnNjNMRFkrVzZoZEsxSlJjTWlDZVNpUDEvZUNLN0dDK2VF?=
 =?utf-8?B?M2NxVlhIYmxGUnRRSnZ6UG04eUI2U1U0MVN0NHRkNXNDVWpFT0xLVGlQcnlV?=
 =?utf-8?B?VGFvTmMvSllDTTQxcFRiamh6QUNMV2xaNXBiNmFQRzBFbXFhanJOZHYyenpI?=
 =?utf-8?B?V2NVMkNiSU9lU1hBWWFPOXBWVWZ3eVhFWnMwQWlZSUtUMXpJSVdwcXljU0xF?=
 =?utf-8?B?dHBrV2FuR1YxdFI1STg5WlBKNWZkRTlUb2pEdlV6UXU4c2dFZStqWVpqVm9o?=
 =?utf-8?B?TEZGMVJvVExjak44b3pFL2hJdG1MNXlwcFRvQ0cySWFOSFhVWS8zU2xCeUlG?=
 =?utf-8?B?ZzBnUEx0QStXK2pKUzI4eEdBeEZHWHBmL3JzeldmbEJYYURMTlZpL200dUxU?=
 =?utf-8?B?QUpsdmxpbmNKeStsN1NWTVdHbzR2SE1vcWVKWW1QZUswejVTamh1WXdGTE1t?=
 =?utf-8?B?SjJrWmtJUWw3UE1VUE9jM2UrK0lBYythVzhBM3dBRzN2dWhJWFJVa3RzMFdq?=
 =?utf-8?B?SHhtK2o2NyswcnN0Z1grQ3h3R2xWZElBZHZZMDd0dmtlTG9TbmZZQTBEUnNt?=
 =?utf-8?B?NkI0SDY4SXZKYlFZYmJyWTNDangwcXNiOCt0dkxVbi9QWkhNMjlKMVRGOVpJ?=
 =?utf-8?B?RVJ4MnhpeTRzVC9DQ2tyMkxiMGpKZWRJSGZJSUIzRmIrbGhqK29uYUIzbUl0?=
 =?utf-8?B?dytMbkdhVDlrN0JhYUhyUG1YQlR6ZG53ZVlNNlRKSUlmYzZRYnZiSWorNHZ1?=
 =?utf-8?B?VjNSTkhzblZxRWF5bFViM3VZS3AvazlRcVRZRlU1ZUtWLzBtQ3QxbWRsSFVM?=
 =?utf-8?B?M1ZMazhNWlUyMUx1enlJNTZBVGJYbDY3aWthdFN5bEt1NXRTZ0U4Zk83ckNI?=
 =?utf-8?B?V0NHbHpWMHIyVVZmbTF6aE5UM0trSEZ2dW5TUzNETTI1RmZ6ZFFvc3ExbjY2?=
 =?utf-8?B?MXd5dDR4cDRxZTk2YTZadzUrM3g1TUlwY25LdzZaalJKSWljVWxmQTk0ZVd4?=
 =?utf-8?B?cUlqb1FDMHBHRVF1cUtQY2tqSGlYbGxGZjNFcFozVWRKMHFRTWZQSmE4azBV?=
 =?utf-8?B?bmZQeXNXb1dueEpmd3hoclRCQitPRnIyTUNrMmw3VndDSTFxQ2xpZEN1Y2xG?=
 =?utf-8?B?UFB4L056TGRWdWgxKzFzRG40YTZJMjBIWWVVd25MeFpGZGZUZEZSQmpLb29X?=
 =?utf-8?B?dXhuMzl4c09KL3JDekUwUjF4Z1cvWnhlZy9PUWg5ZnpjLzdPemZxYzVXd3M4?=
 =?utf-8?B?YVpOR3Y2VkJ1ZkJ0WFJjbmQxejZYK2Z6M09uWExtSG9pR0xGa0hMclh4MTVE?=
 =?utf-8?B?TWhHaEt2UjNKZnRZbWJoQktSMUphZEt0QkVFcTljczIyLzdCT1BMSnZFQXZI?=
 =?utf-8?B?eUxyMEdod2lreFFGUUF5djU2bVc3R0VDcFBYWXlwVWNreHgxekhYMzhWeHU2?=
 =?utf-8?B?WmxnakhJM0ZtOThrMTNWWkh1NHo5YlBZaHg4RzdGMDBkWmp2U0JwQlJSMTAx?=
 =?utf-8?B?SEJ2YnVpYjl4OStZdUhmeFdnSDF6YkhhYzBwR0ZwYWZhWUVOQ1JjdDUvZ3lQ?=
 =?utf-8?B?T0tlbVNNaEZXUklZdWQ3Zz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cTQ1T2FzNTRLWjAxYWR2WElyWVVXZVI0S0J0NXBIZjNsN08zODVmWG9oRTJR?=
 =?utf-8?B?MmNmVjh1blBvZnNPNVF0U0F3TlJwOVByWmFKWVBqMVJpL2F4d0hGS0t4ZHd5?=
 =?utf-8?B?YWlhS3lXekMxQUJjYi9mdzM4NStQRXB4eE1vd0VOWHZTRWovUHpQZFJ5bE1l?=
 =?utf-8?B?NW16WVQ3dmljQW9XZmk2dTFHTmhjemdIZGUyVUQ2VjRwMU5Va0lPN1NIc0Mz?=
 =?utf-8?B?NzFiR24yZ2FGYmFoK1lacXpQRWp5bks3Q3k1UE9nZ3ZpeGlOZ2ZwdCszbGlj?=
 =?utf-8?B?TGN1cGxTbFF1b1pmMXA4OHR5VUJsVzBIM0RuTHN2d0FOUy9JR01iOUhSSWZN?=
 =?utf-8?B?TTVyakJCclJ0amk1SGJ0bldJd1pqZWhUeVFRSlo2emRrUnV1aTRSL1JXcWth?=
 =?utf-8?B?MDh4cFgvVWZnWFhqVU1ycFpzUFR1dzlaY0J5bWJuOWp3N1RxamUyUTh4NU44?=
 =?utf-8?B?emtCdkF5dGdrVXdZd29nNTAzd0U0RGhuNkdMVnFNckt0UkJ4Nm5MVVpxV09J?=
 =?utf-8?B?eDdsekZoeHFyMGZYdjdIV0VpMzQxbGJjZUQwaTVMTnZhS1F3a0RHdWNQU1ZE?=
 =?utf-8?B?VEFZREpmMEdTbzExSnFmODlnMFliRDZQYkFOelF6WnBTSkQ1ZTdMb29wY0N3?=
 =?utf-8?B?YlJHL01XNHRuSGRaelppYTZDNmVrdW1tMlBTaXpqTGFON3d5dDhWb0tzQ1Jq?=
 =?utf-8?B?YUdtbWI5T3pUZE5hWmNzcHhPUlZNRDJqSEgzYzdGY0pTNnA1UWdKTkg0cWZI?=
 =?utf-8?B?YTcxZC90TTE5ZWFOVTloczJiV0VlKzRBaVF2MTBaYWh4VTZCZEtrZ1E1ZUx3?=
 =?utf-8?B?Yyt3cVVEOG0xSGpFT3cybmlLOUhLaFdUZUxLakVTaHE3QzhuditncnBlNTFM?=
 =?utf-8?B?cDlJZ0hzTHFKZ1JqZEZyb3hrK29GR3p5cUxwc1p1VTF5TTFHdVpJdU5iNzVo?=
 =?utf-8?B?VlEwNUt2bkJBMUhTc0dPVXRRTXVla1ByRmdjUks3WEgrWWR3YzBUVzJsYUxW?=
 =?utf-8?B?VE5IQ1p3YVNnaWZMVnNLZzlQa211ZytaNnZVcXFYTnFXUWVUaDdSZmRnOGg1?=
 =?utf-8?B?dzE3STBKYktHZ3VFVmNCMlVxQTFwV2ZMZ0lDMG5jRTVjaU82MlBiMk8yaFY0?=
 =?utf-8?B?TVNPYTdYTjZrbWhjK3hFWUhjSXdCTzJUbWg1RERJNC9iOFo3R0twdFhWK1pV?=
 =?utf-8?B?OUVQeFdoVkQzS2UwMm9YZENhK093dFhiK0VhelJCOUZtMFMvR0pGQkQ3ZEVs?=
 =?utf-8?B?WGdDTXVuc2NiMVZzdU9ZZnpyWnVFWUV5UTh6MFl6anEwNUtBSzA2TnZ4d2dR?=
 =?utf-8?B?L2I4MTVLV3NIRjArd1JsY3ZaZk1sdWx0bkNuM1VZb1llVmRpU2srUk9ZVENw?=
 =?utf-8?B?ZkpoWWhBekVFbUg0d1p0V2JIZTFjN2JObmZ4cGQ0eXhnWVN1Q0pqTkk2T0RC?=
 =?utf-8?B?ZWlTTzZvSkY5bUs2UHRlVWdPcUdvRVcrbU5HZ2kvR3NWVVIwT0pOcDVidWxw?=
 =?utf-8?B?VDZaRnptZW1GRzVHVjRKczdzQkYvWXZSYzZRTk5VYXRGNmFOZ1d0c2Uvd0Nq?=
 =?utf-8?B?UlpXSDZTaXAwNmE1bzV5VXBjUFNsdnVvMHBtQ28yTkRaTUZDak1WR3FtVFc2?=
 =?utf-8?B?dmpPWnBTNmZLN2R3RFdITWNBNG9SN0s1WklTV21lUFE4RnhveWZ5YU96MGsx?=
 =?utf-8?B?NEJCZ2FRRDNDRE5sdHljUytFSkU4Tkk0bmkvUUh5RDlRdFpnSjBiRE12bFdt?=
 =?utf-8?B?d2FPVnc5K0M4cHRFcEtxOC9vclIxWjF0cjlEZnRNY0VqMGErVWFwQ1RtUzRs?=
 =?utf-8?B?VU1uaHNHb0ZUUC9TcW0zZjRTMW5NcERVYWtZYUhkK0dJWkZLbUJyUy94UmJZ?=
 =?utf-8?B?VUtlSUU1SVE1UUMzMk5XNTkrcEFLUytxblRLUWhkclRXU1hLK21PcW1WVEhK?=
 =?utf-8?B?YXV4Y2MyK1B3QUpndXpRcGU1eTVMcTNLck84MGMyTm1mazcrODh6dk9pZkdZ?=
 =?utf-8?B?Sk55OHZVd0RPN2VUMFFNWnA4YlhSbTVJTkw5L1lxRVR6eWhCNDBwb1A2eWw2?=
 =?utf-8?B?a1NnN08wQ0VxcVA3Snk4NlRvcHRrWEI2d0M5alJJZFZGUDcvZ25WeTVLOXZC?=
 =?utf-8?B?L0dTZkJZUlpjZnFsWVllbmczT2VYTUNncjBUZDVhVzJ1WGtURWNFV1BCcjg5?=
 =?utf-8?B?bVE9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d16f656b-2ea0-4314-ecc6-08dd57c7413f
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 07:12:26.3368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8ymxS9T/+b57CRHwLaZjCY4FyY3Hqx4021T402gWorhSIEv6Em1Jb75ifaoez7tg7MEqqYbeLyr996eT6cyyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7621
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 28 Feb 2025 07:12:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17356

Am 27.02.2025 um 03:58 schrieb Peter Kjellerstedt:
>> -----Original Message-----
>> From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembedded.org> On Behalf Of Stefan Herbrechtsmeier via lists.openembedded.org
>> Sent: den 7 februari 2025 13:47
>> To: bitbake-devel@lists.openembedded.org
>> Cc: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
>> Subject: [bitbake-devel] [PATCH 05/13] fetch2: remove duplicated code in url decode and encode
>>
>> From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
>>
>> Use the URI class to decode and encode an URL. Remove duplicate code and
>> unify the behavior.
>>
>> Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
>> ---
>>
>>   lib/bb/fetch2/__init__.py | 66 +++++++++------------------------------
>>   1 file changed, 14 insertions(+), 52 deletions(-)
>>
>> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
>> index ab992b7ea..2a60e94ed 100644
>> --- a/lib/bb/fetch2/__init__.py
>> +++ b/lib/bb/fetch2/__init__.py
>> @@ -353,49 +353,9 @@ def decodeurl(url):
>>       user, password, parameters).
>>       """
>>
>> -    m = re.compile('(?P<type>[^:]*)://((?P<user>[^/;]+)@)?(?P<location>[^;]+)(;(?P<parm>.*))?').match(url)
>> -    if not m:
>> -        raise MalformedUrl(url)
>> -
>> -    type = m.group('type')
>> -    location = m.group('location')
>> -    if not location:
>> -        raise MalformedUrl(url)
>> -    user = m.group('user')
>> -    parm = m.group('parm')
>> -
>> -    locidx = location.find('/')
>> -    if locidx != -1 and type.lower() != 'file':
>> -        host = location[:locidx]
>> -        path = location[locidx:]
>> -    elif type.lower() == 'file':
>> -        host = ""
>> -        path = location
>> -        if user:
>> -            path = user + '@' + path
>> -            user = ""
>> -    else:
>> -        host = location
>> -        path = "/"
>> -    if user:
>> -        m = re.compile('(?P<user>[^:]+)(:?(?P<pswd>.*))').match(user)
>> -        if m:
>> -            user = m.group('user')
>> -            pswd = m.group('pswd')
>> -    else:
>> -        user = ''
>> -        pswd = ''
>> -
>> -    p = collections.OrderedDict()
>> -    if parm:
>> -        for s in parm.split(';'):
>> -            if s:
>> -                if not '=' in s:
>> -                    raise MalformedUrl(url, "The URL: '%s' is invalid: parameter %s does not specify a value (missing '=')" % (url, s))
>> -                s1, s2 = s.split('=', 1)
>> -                p[s1] = s2
>> -
>> -    return type, host, urllib.parse.unquote(path), user, pswd, p
>> +    uri = URI(url)
>> +    path = uri.path if uri.path else "/"
>> +    return uri.scheme, uri.hostport, path, uri.username, uri.password, uri.params
> Unfortunately this does not work if you have a MIRRORS/PREMIRRORS with a
> regular expression that contains a negative lookahead, which we do. We
> have the following in our PREMIRRORS:
>
> git://(?!our\.internal\.git\.server).*/.*    http://downloads.yoctoproject.org/mirror/sources/ \n \
>
> since there is never any point in trying to fetch our internal repositories
> from Yocto's server.
>
> After the above change this now fails with:
>
>    Exception: re.error: missing ), unterminated subpattern at position 0
>
> since decodeurl() has stopped parsing the host part once it sees the "?",
> which the old code did not do.
>
> And while regular expressions with negative lookups may be a little
> esoteric, this change also silently breaks all the mirrors in the
> default MIRRORS that use npm://.*/?.* and https?://...
>
> My recommendation is to revert the change to decodeurl() because the way
> the regular expression "URLs" in MIRRORS and PREMIRRORS are written do
> not match the expectations in urllib.parse.urlparse().

Please revert. The decodeurl, encodeurl and mirror code doesn't support 
query parameters. We have to rework the mirror code. It shouldn't 
interpret the regex as an url. Afterwards we could reapply the patch and 
add query support to the url function.

Can you please add the missing use cases to the MirrorUriTest to detect 
the breakage earlier.

>>   def encodeurl(decoded):
>>       """Encodes a URL from tokens (scheme, network location, path,
>> @@ -406,24 +366,26 @@ def encodeurl(decoded):
>>
>>       if not type:
>>           raise MissingParameterError('type', "encoded from the data %s" % str(decoded))
>> -    url = ['%s://' % type]
>> +    uri = URI()
>> +    uri.scheme = type
>>       if user and type != "file":
>> -        url.append("%s" % user)
>> +        uri.username = user
>>           if pswd:
>> -            url.append(":%s" % pswd)
>> -        url.append("@")
>> +            uri.password = pswd
>>       if host and type != "file":
>> -        url.append("%s" % host)
>> +        uri.hostname = host
>>       if path:
>>           # Standardise path to ensure comparisons work
>>           while '//' in path:
>>               path = path.replace("//", "/")
>> -        url.append("%s" % urllib.parse.quote(path))
>> +        uri.path = path
>> +        if type == "file":
>> +            # Use old not IETF compliant style
>> +            uri.relative = False
>>       if p:
>> -        for parm in p:
>> -            url.append(";%s=%s" % (parm, p[parm]))
>> +        uri.params = p
>>
>> -    return "".join(url)
>> +    return str(uri)
> I believe using the URI class for encodeurl() is fine so this part
> of the change should be ok to keep.
>
>>   def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
>>       if not ud.url or not uri_find or not uri_replace:
>> --
>> 2.39.5
> //Peter
>

