Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1218C02199
	for <webhook@archiver.kernel.org>; Fri,  7 Feb 2025 12:49:02 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.66.135])
 by mx.groups.io with SMTP id smtpd.web11.68586.1738932538279077982
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Feb 2025 04:48:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@weidmueller.com header.s=selector2 header.b=LNO2Hyh5;
 spf=pass (domain: weidmueller.com, ip: 52.101.66.135, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GDQESItS0Ixqh4czNOGlgxOSUqUR7stbbhPmEIxla4zI8/WmS45EObL7PDzBl3DjHb9+fuJrF36v+kPPnNT/p0ULBqDjsPJWTLHQlOr15RFvqivVvkzM9pZ1pG7REkOOwY4WMOjaYYv58gEeAVp+DccAsYB1xVY5NjAQ+uUaepBY/7sF2e1I3PWolAQf/W/iEhPIcH6/wcS2UzbwVjavvrvabkvBqaxH9GLsbpBrMrmD7MalDx9LLMyGrarO4bmB9Rt+lCYbehFfrhNErzFwUYwdXmhGEbgUWoIXQCsUqF7Gtg9lvlZubJJvtSp9/JYvbkod+AvTl6e+ZLGDQudsZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Xy13z2aOhPXaevamlMbIR+D8fjemXYOzY9JM+cDt3M=;
 b=VM4yTFuzE6SZmaowYk/iFXTBkjt3wGF8SbMwdB7DvO89ExhDnbVtFWRZxxMpSzRP/lCFW9E6tK06N+mGMlSrGQ0TDm44KboKkGN5gsm9TO4xZdCS81QLZVUjBv5/V02VHmwTY58RiVG9X+UcDIayJtB5UGJEOBYpDvJ5YjTi5msbGqmlWKx5dIBZO/znnJwTIoJuNea35jnsUrR/VDMa1Uxj9xjWpRXxPGUHMFPVp6qD0ruxXcgwY6f7M/UAE0DT42WqVRRm5bEnbV+us/YqGc6md8pB324SDob0FkOBHDODLUpXc5HBJNhJLRuQsB0Qjp3Maf4cUPIgrlf2+U8Udw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Xy13z2aOhPXaevamlMbIR+D8fjemXYOzY9JM+cDt3M=;
 b=LNO2Hyh5zFD+EWjOcJHppcGiXP6dZ54PPKa8K2CRYpEuZAyh27yIg3z1jS8aUeqA84WUqyp2vf6Q35mVrjtGvlIhlvVP6xj4w7URjRLDtB4waURVqgcAeGdf6Zvpvam9xmtTceuC9sxkdDpuM0WP3LxLuv5KvQYwPDEVqWpAfF3zxu22rwCV+ACWyQ9+V26bAS5NJdNbr/ngd9utkEjpCHvBiYDWp6u9JxTCv6Ad40DwXpjd3QJi8mRMtIgUsp6bmJPXicr+nHwQVRcfiFGcxmMWssRf8SWU/bqwHS+Wq1wnoSW75qIyBNX0ZXypuNizx6JhEuCRCid1WXaNlx8bxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by DB9PR08MB9755.eurprd08.prod.outlook.com (2603:10a6:10:460::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 12:48:53 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8422.011; Fri, 7 Feb 2025
 12:48:53 +0000
Content-Type: multipart/alternative;
 boundary="------------3hwnKfB0MK1CXYLnRNC22Uof"
Message-ID: <771aea2f-d45d-4b98-bcf0-b964775be1de@weidmueller.com>
Date: Fri, 7 Feb 2025 13:48:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [RFC PATCH 08/15] fetch2: use localpath instead
 of localfile
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
Cc: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
References: <20250205071538.2681-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <20250205071538.2681-9-stefan.herbrechtsmeier-oss@weidmueller.com>
 <7314b5c9248b9c1b73de6133dc34cf31bf41d43f.camel@linuxfoundation.org>
 <1821AAFAC9C0AAD1.752@lists.openembedded.org>
 <e839c25a-e4d5-4a93-8c82-915336367400@weidmueller.com>
 <3b99c11f71e6f5761807bc707c215caae9643ff9.camel@linuxfoundation.org>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <3b99c11f71e6f5761807bc707c215caae9643ff9.camel@linuxfoundation.org>
X-ClientProxiedBy: FR4P281CA0418.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::13) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|DB9PR08MB9755:EE_
X-MS-Office365-Filtering-Correlation-Id: 32f15fbb-4b17-453b-cd35-08dd4775c71d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|13003099007|8096899003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YUswVzg3M2hMTFk0OW13cHk1dEpVR2o5b0VteVczUVNZWmJXeUJNT0Z1SFds?=
 =?utf-8?B?UTBlSEJjSUhkaWszSDNTTkFMVTY0MTFVbCt1dEZwNElDd3RpZkE3ZUF2ejNm?=
 =?utf-8?B?K0IvK2thM1VGa3VXaVovekdiWlM1VnVxd0F6cmNxd0NCUDhjZEoxUDVBUjJy?=
 =?utf-8?B?VUF2cnZtNnFsV0VmOVB6YmkxNVZxZ0RhM1pGZXYrWWdaYlRVd2dJaXRleVZP?=
 =?utf-8?B?cXhRSjdScTJvdVRSSkJBWFlKY0Z0UGJVWjQrRm82NkpGOENvSmFXdGNqRjIx?=
 =?utf-8?B?SW8wOG4wa0JoYmIxUDRxZDJ3a3RIaGFPbC9qN04ybWNEbDRwRHF0SUdmRHJk?=
 =?utf-8?B?b3pDWHErZDBYZHdQZUZiMkxGai9STys2dFNNOVZobTgzamowS2l6Q1U5WCtH?=
 =?utf-8?B?N1hISm9zTjhBNkhFUnJlcDdFOVhQVDBQYTBEaU1raVlCMTJpV1czYnc5Wkxw?=
 =?utf-8?B?ditGTWhIdlU3Mk1vWUZUSldUQS9uMVdDWHMxNWRoanJjc0QyZ1M3aFU4NlZx?=
 =?utf-8?B?bnVYVFNBS1gvOUw2bmRTTEo1QlV1YkVvVXVnUHFPOG10REt4Y25ZSHV6THI0?=
 =?utf-8?B?UEpPOUZHUGdRK2g3aTMvQXdyMzJFcmpwN3JML0dpdW9JSW52MTZrdllaaStp?=
 =?utf-8?B?dDhsRk94OFNuMk9RNDE1ejByZjROQWNMQkJ6R0pLWFFsYit3bEROVWpnN1lo?=
 =?utf-8?B?VG83NXMzMUJFUzZnYlMwRU1TRHpxUmFHbWxPRjRWdnpTNjVvSTlWMWovMUdS?=
 =?utf-8?B?bUVCYnkxQTYreUhtaEVBc053dGRFMk1mWU03bmRJcG80aXJmZlhNOE9qUm0x?=
 =?utf-8?B?VWo5ditoWTEzeEhldUducHlvK09qamhHSkk2aGFQaGpZMFhhR25BTHFrVjcy?=
 =?utf-8?B?UWZCT005a0h0VmliMVI0NVZKdHJGVE9uNzN0QTZ4Rmx4akVvWjZzQUM0aGRk?=
 =?utf-8?B?clpRRHFVS3lIOGs2UzNKc3hlWHZNbFc0QzhDY1pQRVVydDB3OHQxYk5xcnM2?=
 =?utf-8?B?OWQ1SGZTOEtQZFU5ekkvWkc3TmFlODdYeUlVNURpVEZnY2U4S1FvaXorWVY5?=
 =?utf-8?B?K1BkZGtleHZqd1FCMHNObnJmUXhoc09TVW1HUStuZGxWdm00OU1uZXQzN2h3?=
 =?utf-8?B?QnU1OUlEZUhxSFM0MTl3NG1tOHFlY1lQSGY2NVh6WER1OG9Zd3V0QXY5YXNU?=
 =?utf-8?B?dVZKYWJ4aXJJa0lmUFk2bkxKZGZFaysrbVJBQVowSDE4d2g5TGZGVE82UmRv?=
 =?utf-8?B?ZDZTWkFpN2JjV25WYTZhd3hKcEJzV3A5RzhaV1R1cXlhdGFuc3lyS2ZlWHEx?=
 =?utf-8?B?SVRzZlBpRGxZOCtrSEVDd0h3cjlNREY5T29NQXUzc2pWUHNkMWo1WlgzSXJp?=
 =?utf-8?B?Q1QrNDQvMVV6RXdDMHExZllESEZuSHlGMGJDeDE3bTYwWUJYN0tVUDJPeVBF?=
 =?utf-8?B?L2UvLzhEUG1SVjd6TjlEazgzaCsxZVFEMjhSZVBiYUtucHB3WFFXY0YvREp4?=
 =?utf-8?B?YXpCN1hXOTZ5ek5uM0QrYlY3WHFkYUtySXI5S2VaamhHK0lTYzFkSGt2RUdD?=
 =?utf-8?B?a0hITDR0aWNvVTA3QzB3emR5bU5ZU2pydm9UdExtN0U2ZTNCV0pLNnJCRUZv?=
 =?utf-8?B?SGYrMGUzS3BoSmhjd1dHYjY2TmRLK2I4RHNzbi9acUxMUWFUenNDVVNSMGxp?=
 =?utf-8?B?V1NSWHRlb0NQbFZ2MUg5bWgrclNCSlBINzRVWmNGSUkxZ05qdlBGN1pDVktQ?=
 =?utf-8?B?R3RlcGtJbzRUUi9peWxyRmlJTkRKMm1VeDRnNkNCUnpNZDlpZ2tVR1FNZXRP?=
 =?utf-8?B?V0c3R01iand5QlAwRE90dz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(13003099007)(8096899003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bmp1OXIwNXVFemw3V1hoOGJMUVVFNmVzc1gxZEU4RXU4WFBBQnRBbVFpSU9J?=
 =?utf-8?B?SkFhTGhEVlJTcG5sb1UrTjl0U0twVjJQc20yTFdqTmIrYjZscXkzeW1ySnlV?=
 =?utf-8?B?ME96bjBNYis3RFgrUHhrMUpEWTVNL3RIek5OVkNjNWFpUzhIZHNrQnZTSG9O?=
 =?utf-8?B?YytQemQ4eHBDK0RXMnFUbFovQktVcDdXOEFyeDZXd3J4cERRODZzSjM1NTd1?=
 =?utf-8?B?L29xV2Vabk5Sb0VjQjV0cG4xL3VwcndyMWZGbHlxR09pTHdWTFBsZ0JVMjl2?=
 =?utf-8?B?VHVqZ2JSckpTRlhaVUdiN2tFeHlXb3BKMlVPUlRRR3QxVml5QUJWV29KL3ps?=
 =?utf-8?B?MzdUM3VicDg5WkxGVTB6NFFaZzVMSHBKNENhekpEUHZiTjZUdDJnR2J4WGhv?=
 =?utf-8?B?UGt3ZXBQUTJRdmh4UDlDVzd1dUhXblVodmwwN01XUUdMOS9oQ01mUzZ4Nzg4?=
 =?utf-8?B?ZTdjd1ZtZE1sV0xHSlBpVGYxcUZYTGEwSlZXVGk3eGUycnMwTyswOHI0Q1dR?=
 =?utf-8?B?ZkQzYTF4TkFqVjRpWHFDL3o1SE1pdGtBS1NOVkljS1ArcEM5OUZsN2pPUW5k?=
 =?utf-8?B?d3RTM0FCRElzWlJnaGdlSlBISXlUVm9HbWwyTXJ1MXRPdDZxOEV4L2N1RThs?=
 =?utf-8?B?VFkyUUFnTnFyWGFxajEwTHUxU1RuQVZuUG5mNk1VaUdCU0tXVUMxR2gzeXRu?=
 =?utf-8?B?TEMvck5WM1BxcGs5TVVVZFUxTHdyOU5QYWhUelN1cW1mai9GRWh4QU1Galps?=
 =?utf-8?B?RzRSczE3b3FpcC9GTm1BQ2xjZFRJYzR6aHlTcUZ6UmorOWxrZWV4STFLYmlZ?=
 =?utf-8?B?SnorajBFMUhuRGlrMWhxOFBLSTQrTEJTTTdxOWY0Z1E0N3lNTEtJdVNzanVw?=
 =?utf-8?B?NkphZ1ZnODc5K0FsUmdab3JxZmYzNG94cWoyRXRHWGJSUTA2Uy9uUFpyVWQx?=
 =?utf-8?B?NDBodTQ5ZmJEU2F5QTBiTXpoeVRFK2ZndnJxbFFNWGhicXdQUlIrTXBoRElo?=
 =?utf-8?B?SWlGcWU0K3JsenJBN2F5aTlHcEhpYUF4UUdwQW1vRDk0VFNrNU1meURySTFq?=
 =?utf-8?B?NlVZL2ZKeDRkejJ2N3NWcTdISXZ2dkFaMCtVaklaWStGMWwzck5Fcy9XU2xn?=
 =?utf-8?B?VkZiSGoyd2d5OEtWWEJMdVFGZlRMTE1zc0djc09tV2hTVzJFZXA2TFB1NXVn?=
 =?utf-8?B?QXNIYW5IZGQxZzlYcmlhL3N0RC9FSG1PY2NEK3J1OEdmV2hDWHhnZ0I5S1Mr?=
 =?utf-8?B?bUM2WjcrQkRqUmpPcWZ6SUdTNWltYVY1aUZqaXE5dHFOUmozZWU2bXM3SWY5?=
 =?utf-8?B?eldnQVBoUytFSDZLVkRmUTcrSENDYUs2eFJhbkcvNXFXYTVScEJsVkNBUUF4?=
 =?utf-8?B?NklEWStjZzEyUWx1bHg2S2xMUWQxWklxYUUzanpmQlpZNHBiRHEzR1ZYMGw5?=
 =?utf-8?B?OHJldzNWV3JLdlZhSWs1dUM0OGpyTW92YkxuTW90bEUyZzBXVlhRNEZZaXpD?=
 =?utf-8?B?L0FiaVNxYWVwemFZQW5QKzdnSU5GSHdxbUV4b1lyQnUxSlo3N0JkQkxNZkgx?=
 =?utf-8?B?Q2RJWmV0MUNlY0Y2ZE94a0duc0RkRWtaK3UvQVJweTMxT2hFUTU1N2tYVVAy?=
 =?utf-8?B?WXlSS2pvbDlFazhRblpWUHM5Y3pSSFlYQnNkeUI5RmMycnltUy90allGNTN2?=
 =?utf-8?B?alJQMVlHWGJKcHc0OHhDTkp5cnltSmlLK1pPU3pZY284NmRTOTFQTlFubUxY?=
 =?utf-8?B?OFlQQXRMeGlmTTB1QjAwck8zTW00K0RjQkFpc1VlSHNkb0VOdzVWKzNla283?=
 =?utf-8?B?MXFCdXM5cisreDNQc0tOcW5GMDBYc0lmZnEzYUhTVFVMSkY5QzFyQXg1Nndu?=
 =?utf-8?B?SXlyVHJFdFk3d0ZvS1duWUo0WC9McDkxNnlUZ2J6TjhRaUhERGlQTzZBOThw?=
 =?utf-8?B?K3JXQUY5dTcyalpJNUdtZWlOU20zOTlSZUlhVlpnOWNSdnNEZTd6dHI1Qjd3?=
 =?utf-8?B?MkgyTHdqSEZCMmNhYUxuV0x6NDh2U0VHZHJIaU0rZDVBeTNNbnlURGNFR0x1?=
 =?utf-8?B?STI0eDY1M0xMSVBldU9zaHNjL1NOZzM3WWZjT29VaVdzSGdKM1lGRGtsTzdu?=
 =?utf-8?B?VW1tWm4zMDRIemN2c2xqTWVKTjZQSXNxdUpzT2M1Z0d0Wkdjb1pwblU4MVlp?=
 =?utf-8?B?RWc9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f15fbb-4b17-453b-cd35-08dd4775c71d
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 12:48:53.5625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3AJRQ4XW79hqq6NFpOOwgY4SDPTdk+aGS/xW1RkeTsNumzToALaDmlKZj9sA+UYktg2Ax/Nrz+a6sXZyvh/PFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9755
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Feb 2025 12:49:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17183

--------------3hwnKfB0MK1CXYLnRNC22Uof
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 07.02.2025 um 09:10 schrieb Richard Purdie:
> On Fri, 2025-02-07 at 09:05 +0100, Stefan Herbrechtsmeier wrote:
>> Am 06.02.2025 um 17:21 schrieb Stefan Herbrechtsmeier via
>> lists.openembedded.org:
>>   
>>   
>>> Am 06.02.2025 um 16:26 schrieb Richard Purdie:
>>>   
>>>> On Wed, 2025-02-05 at 08:15 +0100, Stefan Herbrechtsmeier via
>>>> lists.openembedded.org wrote:
>>>>   
>>>>> From: Stefan Herbrechtsmeier
>>>>> <stefan.herbrechtsmeier@weidmueller.com> 
>>>>>   
>>>>>   Use localpath variable instead of localfile and DL_DIR
>>>>> variable.
>>>>>   
>>>>>   Signed-off-by: Stefan Herbrechtsmeier
>>>>> <stefan.herbrechtsmeier@weidmueller.com> 
>>>>>   ---
>>>>>   
>>>>>     lib/bb/fetch2/az.py   | 3 +--
>>>>>     lib/bb/fetch2/repo.py | 2 +-
>>>>>     lib/bb/fetch2/sftp.py | 3 +--
>>>>>     lib/bb/fetch2/wget.py | 2 +-
>>>>>     4 files changed, 4 insertions(+), 6 deletions(-)
>>>>>   
>>>>>   diff --git a/lib/bb/fetch2/az.py b/lib/bb/fetch2/az.py
>>>>>   index 346124a8b..1f0f1337a 100644
>>>>>   --- a/lib/bb/fetch2/az.py
>>>>>   +++ b/lib/bb/fetch2/az.py
>>>>>   @@ -49,8 +49,7 @@ class Az(Wget):
>>>>>             fetchcmd = self.basecmd + ' --retry-connrefused --
>>>>> waitretry=5'
>>>>>               # We need to provide a localpath to avoid wget
>>>>> using the SAS
>>>>>   -        # ud.localfile either has the downloadfilename or
>>>>> ud.path
>>>>>   -        localpath = os.path.join(d.getVar("DL_DIR"),
>>>>> ud.localfile)
>>>>>   +        localpath = ud.localpath
>>>>>             bb.utils.mkdirhier(os.path.dirname(localpath))
>>>>>             fetchcmd += " -O %s" % shlex.quote(localpath)
>>>>>     diff --git a/lib/bb/fetch2/repo.py b/lib/bb/fetch2/repo.py
>>>>>   index fa4cb8149..5c0edf1f2 100644
>>>>>   --- a/lib/bb/fetch2/repo.py
>>>>>   +++ b/lib/bb/fetch2/repo.py
>>>>>   @@ -46,7 +46,7 @@ class Repo(FetchMethod):
>>>>>         def download(self, ud, d):
>>>>>             """Fetch url"""
>>>>>     -        if os.access(os.path.join(d.getVar("DL_DIR"),
>>>>> ud.localfile), os.R_OK):
>>>>>   +        if os.access(ud.localpath, os.R_OK):
>>>>>                 logger.debug("%s already exists (or was
>>>>> stashed). Skipping repo init / sync.", ud.localpath)
>>>>>                 return
>>>>>     diff --git a/lib/bb/fetch2/sftp.py b/lib/bb/fetch2/sftp.py
>>>>>   index 2a2a70a1b..b88dc5a28 100644
>>>>>   --- a/lib/bb/fetch2/sftp.py
>>>>>   +++ b/lib/bb/fetch2/sftp.py
>>>>>   @@ -82,8 +82,7 @@ class SFTP(FetchMethod):
>>>>>                 port = '-P %d' % urlo.port
>>>>>                 urlo.port = None
>>>>>     -        dldir = d.getVar('DL_DIR')
>>>>>   -        lpath = os.path.join(dldir, ud.localfile)
>>>>>   +        lpath = ud.localpath
>>>>>               user = ''
>>>>>             if urlo.userinfo:
>>>>>   diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
>>>>>   index 161c66bea..1194f0e7a 100644
>>>>>   --- a/lib/bb/fetch2/wget.py
>>>>>   +++ b/lib/bb/fetch2/wget.py
>>>>>   @@ -95,7 +95,7 @@ class Wget(FetchMethod):
>>>>>             fetchcmd = self.basecmd
>>>>>               dldir = os.path.realpath(d.getVar("DL_DIR"))
>>>>>   -        localpath = os.path.join(dldir, ud.localfile) +
>>>>> ".tmp"
>>>>>   +        localpath = ud.localpath + ".tmp"
>>>>>             bb.utils.mkdirhier(os.path.dirname(localpath))
>>>>>             fetchcmd += " -O %s" % shlex.quote(localpath)
>>>>>     
>>>>>   
>>>>   
>>>>   I put the first 8 patches of this series into a test branch and
>>>> ran it
>>>>   against the autobuilder. It fails to parse, unable to find files
>>>> :(.
>>>>   
>>>   
>>>   Thanks for the test.
>>>   
>>>   
>>>> https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/960/steps/13/logs/stdio
>>>> https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/960/steps/13/logs/errors
>>>>   
>>>>   That suggests there is some breaking change in here
>>>> unfortunately.
>>>>   
>>>   
>>>   I assume the @ in the filename is interpreter as username
>>> separator . I will look into it and add a test to the selftest.
>>   
>> We have two solutions to decode an URI with different behavior:
>>   class URI - urllib.parse.urlparse(uri)
>>   def decodeurl - re.compile(...).match(uri)
>
> decodeurl is older and predates urllib existing. People have tried to
> switch things over and use urllib where possible but as you say, the
> behaviour is different. I don't remember what the differences are.
>
>>    Additionally the encode of an URI object and the encodeuri function
>> have different behavior. The class use the unquoted and the function
>> the quoted path. Is this behavior intended or could we use one
>> implementation?
>
> I suspect we've been preserving the old behaviour so it was intended if
> a bit strange. It is hard to comment on what we could do without an
> idea of what it would break and what the differences are.

I have add a patch to fix the problem and an optimization to remove 
duplicated code.

Is it possible to test the changes on the build server?

Regards
   Stefan

--------------3hwnKfB0MK1CXYLnRNC22Uof
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Am 07.02.2025 um 09:10 schrieb Richard
      Purdie:<br>
    </div>
    <blockquote type="cite" cite="mid:3b99c11f71e6f5761807bc707c215caae9643ff9.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">On Fri, 2025-02-07 at 09:05 +0100, Stefan Herbrechtsmeier wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Am 06.02.2025 um 17:21 schrieb Stefan Herbrechtsmeier via
lists.openembedded.org:
&nbsp;
&nbsp;
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">Am 06.02.2025 um 16:26 schrieb Richard Purdie: 
&nbsp;
</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">On Wed, 2025-02-05 at 08:15 +0100, Stefan Herbrechtsmeier via
lists.openembedded.org wrote: 
&nbsp;
</pre>
            <blockquote type="cite">
              <pre wrap="" class="moz-quote-pre">From: Stefan Herbrechtsmeier
<a class="moz-txt-link-rfc2396E" href="mailto:stefan.herbrechtsmeier@weidmueller.com">&lt;stefan.herbrechtsmeier@weidmueller.com&gt;</a> 
&nbsp;
&nbsp;Use localpath variable instead of localfile and DL_DIR
variable. 
&nbsp;
&nbsp;Signed-off-by: Stefan Herbrechtsmeier
<a class="moz-txt-link-rfc2396E" href="mailto:stefan.herbrechtsmeier@weidmueller.com">&lt;stefan.herbrechtsmeier@weidmueller.com&gt;</a> 
&nbsp;--- 
&nbsp;
&nbsp;&nbsp;&nbsp;lib/bb/fetch2/az.py&nbsp;&nbsp; | 3 +-- 
&nbsp;&nbsp;&nbsp;lib/bb/fetch2/repo.py | 2 +- 
&nbsp;&nbsp;&nbsp;lib/bb/fetch2/sftp.py&nbsp;| 3 +-- 
&nbsp;&nbsp;&nbsp;lib/bb/fetch2/wget.py | 2 +- 
&nbsp;&nbsp;&nbsp;4 files changed, 4 insertions(+), 6 deletions(-) 
&nbsp;
&nbsp;diff --git a/lib/bb/fetch2/az.py b/lib/bb/fetch2/az.py 
&nbsp;index 346124a8b..1f0f1337a 100644 
&nbsp;--- a/lib/bb/fetch2/az.py 
&nbsp;+++ b/lib/bb/fetch2/az.py 
&nbsp;@@ -49,8 +49,7 @@ class Az(Wget): 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fetchcmd = self.basecmd + ' --retry-connrefused --
waitretry=5' 
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # We need to provide a localpath to avoid wget
using the SAS 
&nbsp;-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # ud.localfile either has the downloadfilename or
ud.path 
&nbsp;-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; localpath = os.path.join(d.getVar(&quot;DL_DIR&quot;),
ud.localfile) 
&nbsp;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; localpath = ud.localpath 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bb.utils.mkdirhier(os.path.dirname(localpath)) 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fetchcmd += &quot; -O %s&quot; % shlex.quote(localpath) 
&nbsp;&nbsp; diff --git a/lib/bb/fetch2/repo.py b/lib/bb/fetch2/repo.py 
&nbsp;index fa4cb8149..5c0edf1f2 100644 
&nbsp;--- a/lib/bb/fetch2/repo.py 
&nbsp;+++ b/lib/bb/fetch2/repo.py 
&nbsp;@@ -46,7 +46,7 @@ class Repo(FetchMethod): 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; def download(self, ud, d): 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;&quot;&quot;Fetch url&quot;&quot;&quot; 
&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if os.access(os.path.join(d.getVar(&quot;DL_DIR&quot;),
ud.localfile), os.R_OK): 
&nbsp;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if os.access(ud.localpath, os.R_OK): 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; logger.debug(&quot;%s already exists (or was
stashed). Skipping repo init / sync.&quot;, ud.localpath) 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 
&nbsp;&nbsp; diff --git a/lib/bb/fetch2/sftp.py&nbsp;b/lib/bb/fetch2/sftp.py 
&nbsp;index 2a2a70a1b..b88dc5a28 100644 
&nbsp;--- a/lib/bb/fetch2/sftp.py 
&nbsp;+++ b/lib/bb/fetch2/sftp.py 
&nbsp;@@ -82,8 +82,7 @@ class SFTP(FetchMethod): 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; port = '-P %d' % urlo.port 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; urlo.port = None 
&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dldir = d.getVar('DL_DIR') 
&nbsp;-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lpath = os.path.join(dldir, ud.localfile) 
&nbsp;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lpath = ud.localpath 
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user = '' 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if urlo.userinfo: 
&nbsp;diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py 
&nbsp;index 161c66bea..1194f0e7a 100644 
&nbsp;--- a/lib/bb/fetch2/wget.py 
&nbsp;+++ b/lib/bb/fetch2/wget.py 
&nbsp;@@ -95,7 +95,7 @@ class Wget(FetchMethod): 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fetchcmd = self.basecmd 
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dldir = os.path.realpath(d.getVar(&quot;DL_DIR&quot;)) 
&nbsp;-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; localpath = os.path.join(dldir, ud.localfile) +
&quot;.tmp&quot; 
&nbsp;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; localpath = ud.localpath + &quot;.tmp&quot; 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bb.utils.mkdirhier(os.path.dirname(localpath)) 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fetchcmd += &quot; -O %s&quot; % shlex.quote(localpath) 
&nbsp;&nbsp; 
&nbsp;
</pre>
            </blockquote>
            <pre wrap="" class="moz-quote-pre">&nbsp;
&nbsp;I put the first 8 patches of this series into a test branch and
ran it 
&nbsp;against the autobuilder. It fails to parse, unable to find files
:(. 
&nbsp;
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">&nbsp;
&nbsp;Thanks for the test. 
&nbsp;
&nbsp;
</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre"><a class="moz-txt-link-freetext" href="https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/960/steps/13/logs/stdio">https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/960/steps/13/logs/stdio</a>
<a class="moz-txt-link-freetext" href="https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/960/steps/13/logs/errors">https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/960/steps/13/logs/errors</a>
&nbsp;
&nbsp;That suggests there is some breaking change in here
unfortunately. 
&nbsp;
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">&nbsp;
&nbsp;I assume the @ in the filename is interpreter as username
separator . I will look into it and add a test to the selftest.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">&nbsp;
We have two solutions to decode an URI with different behavior:
&nbsp;class URI - urllib.parse.urlparse(uri)
&nbsp;def decodeurl - re.compile(...).match(uri)
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">

decodeurl is older and predates urllib existing. People have tried to
switch things over and use urllib where possible but as you say, the
behaviour is different. I don't remember what the differences are.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">&nbsp;&nbsp;Additionally the encode of an URI object and the encodeuri function
have different behavior. The class use the unquoted and the function
the quoted path. Is this behavior intended or could we use one
implementation?
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">

I suspect we've been preserving the old behaviour so it was intended if
a bit strange. It is hard to comment on what we could do without an
idea of what it would break and what the differences are.</pre>
    </blockquote>
    <p>I have add a patch to fix the problem and an optimization to
      remove duplicated code.<br>
      <br>
      Is it possible to test the changes on the build server?<br>
      <br>
      Regards<br>
      &nbsp; Stefan<br>
      <span style="white-space: pre-wrap">
</span></p>
  </body>
</html>

--------------3hwnKfB0MK1CXYLnRNC22Uof--

