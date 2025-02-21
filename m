Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4897AC021AA
	for <webhook@archiver.kernel.org>; Fri, 21 Feb 2025 10:51:53 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.101])
 by mx.groups.io with SMTP id smtpd.web11.20508.1740135105334593646
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Feb 2025 02:51:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@weidmueller.com header.s=selector2 header.b=LiflK/nt;
 spf=pass (domain: weidmueller.com, ip: 40.107.20.101, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d7OpAFc43mHYwUiHSAoxvfpueTh9KEuqKraAbATIFtBRAPfwzvIVxHLXxXUhCb/LPSkSY3wXCB3VVKQ0KD63U9s0E6bJNU9yTMvEWSNc363A0wWkE479Del++j8j74U0jf3GIUvoX4ZXtuAwU9UEl3ejNxJ7L+gkg/kJDa2+jd8w3qOTQkQAXGAoPQtfNj4Mihd2++soCCIWuokxiWpq5mCg7pom+B4x7SB1eCpGRI4LL5NObYhOHPlAvDC8AdQkUc8C1faNtrAIP1Xdyo4ke8MNcIcHT9ch24+nQYR3nZrXFKbizTk/Bo1/wyJNzleTWPabn4u4clV6gbCXmNWiHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TT1CWAFnr82YHSU7wHW6sFfbknxjF2xiQObp6YrW+8w=;
 b=Wr7MoBt55e5t/IU9ZIlycz5qAht1ix8mgUqm0mkqPbvHOhaHvikoExGEdnPvD1MzrNDYQ19cAEWtDFxvlgNlm+JVw/jNUeNpEPM/ebPTMFCBT58DqHjvt/AE96sCB3ASDMknGVViAngggI5GsMQqZh7TlzQbMwRd18kiu9ZFLSztuLycDOxHN2cg8YdAUNdsmvEAFBruzeNg1b64l+Y2ChRIB/Sc6mekSe0E62LoddIxsIV5cXS+drS0RbOaPcx5Ci9t8yeeYAXdflgWGMJ3aYaV6JKul/PlAq7Nij0d2bFstilKeaf9bLKzt45XtaozwS5Hfl584LQAPLArD09cog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TT1CWAFnr82YHSU7wHW6sFfbknxjF2xiQObp6YrW+8w=;
 b=LiflK/ntMKC+F19Mr32N5oKPEMznoI5zRyAAH/i3n7EdNN0kRNMvh06BsLoBcAdIjQZR4HrhjZOVBp86OKgRX696/lUlzxyjRectecH78xgn8Z7rhUrSrAlnfCYHRVZllacAbIae/SMMzqofrhP9rFep9qevXGV/hsfp/PMoego7xfrMww2eSgbqlZC6p085aFYYyLT9M8AqbsHGOVgYEsMMWyNGwgPeywhWPZJ3Y64v/D9YSW8e2rTKOS/lc1AReR2U/Fg0FGRwIWtfo/hi+yZmgf3IHiZ6uUmzxsoDtuakTs29QE/8Hn2soXpR4q30y3m7tZ51mfJgrms4A+Ufcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by PA4PR08MB6093.eurprd08.prod.outlook.com (2603:10a6:102:e8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Fri, 21 Feb
 2025 10:51:41 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 10:51:41 +0000
Content-Type: multipart/alternative;
 boundary="------------3rHaIXX1TlCIPkSplqdrtLBI"
Message-ID: <dc5c871b-827c-47f9-9cee-1e03bfca0d53@weidmueller.com>
Date: Fri, 21 Feb 2025 11:51:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [RFC PATCH 00/15] Make mirror replacement syntax
 explicit
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
References: <20250205071538.2681-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <f4533bb6d41d4011219cae737907015018a08ca9.camel@linuxfoundation.org>
 <027ed1ac-02ae-420b-a65f-d4e48bc86136@weidmueller.com>
 <d971d67321a2d43666885004f7ff9a479f4d1855.camel@linuxfoundation.org>
 <6d445c40-5f24-47d1-a71a-1060e9b9da16@weidmueller.com>
 <9ecb0289143f35037902a569de8a7f048262f779.camel@linuxfoundation.org>
 <07c3ebb6-8cdf-416a-bc89-ab930d85e78d@weidmueller.com>
 <f33e9499466eebc5d421ec2556af47cb5ddfd277.camel@linuxfoundation.org>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <f33e9499466eebc5d421ec2556af47cb5ddfd277.camel@linuxfoundation.org>
X-ClientProxiedBy: FR0P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::19) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|PA4PR08MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e55f501-daf8-41ea-3eae-08dd5265b937
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|8096899003|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YzRVZUt4WFBlb2ppTUtkeVcrVXlBdkJyc2tFRzNLNlRKQ1hvL0VCdHgwQnRz?=
 =?utf-8?B?VjF4ME1FUVc0Q2N1cVFUbE95aUVqazlyS0FaWnhBTm9lSDk5UzZ2RU0vbmVt?=
 =?utf-8?B?VjJVODl1cG1JR3B6amRGNzJpL2VHb29TZC9mR0R1V093cGk3bUxKUmwrSkY3?=
 =?utf-8?B?WVJEQ0xiWWIvYnVNRlJxR2x4OXo3SU9UTW0zbFBBbUoxSU90Yk14K3pBeXB2?=
 =?utf-8?B?MlNpM0VvTUxGTHpIOCs2anhFaHpaemRZc2FzL2FqYk5pVkJSVWFESnRrMzRE?=
 =?utf-8?B?Mkh6QUkxZVRaZjlSMkZxTkVaN2xHRUtqQVBzYlBLeHlGaWt1YURRZ01lWDYw?=
 =?utf-8?B?SWE5Ykxtb29pRWhQM1JaaW5ROWRNWEI2c3NGbmw4OExNK0RsOE1ad0NmOXJQ?=
 =?utf-8?B?cjVGdW5ua0Uzb1JZaDZNUkloRUtndXNNbTZ5M0Yvbk9PMEthaTkrVFprUElU?=
 =?utf-8?B?cXp1dDJrQ25oelJmY1hCakNoMnoyT2ZCV1RiSHJCeVpabW5wVVF3SitYUUlz?=
 =?utf-8?B?S0tneTZsL1hMV2hpZGFXQjNTSGh3Mkx5azFNcHhvVlBMWDFheVloMHVrbmUz?=
 =?utf-8?B?QkNjOXllek5haGJQUjJCZVBESVZvWHFQaUZsdmNaQUdBNjZrN04wWTlGNWY0?=
 =?utf-8?B?b1EwNEp3ZGQzbEJjRU03aHlPMldCbWxNd3ZyL3VEbmRMR2tKZlhVelU2aDJH?=
 =?utf-8?B?VVYwNlkzd2VBNnZjSUt3OWFTTUlaeUtoQXlyQTVjRGpmcFl1eTMxUzBicFM4?=
 =?utf-8?B?YnBlVWNVK2QrbWpMOHFtcnBqak5EY0dmb0o2c3YvVUVkOWdUK0tXYlZGN044?=
 =?utf-8?B?bnpmVFlMYWIvK2t1V0xGVWMzV3doQkRXeUFyalRkcG5PaDRScFVUNlhBY0ZV?=
 =?utf-8?B?M1d1VERBWk5zYy9RS2EwVnlWTU9xSGprZ29TeDVHYVpOSks2cm5qYkRTZVdj?=
 =?utf-8?B?NWVRRElsT2o4dUVtdTRlenAvWFZjS0NtamgrUk04TVpKS2wrNTkreFZuQlNY?=
 =?utf-8?B?bFRzVzkzUDJSS2ZFb3FSOG9XQmNvbHlYZnJPUFdzUitHanpzZlVrWFpiaGdT?=
 =?utf-8?B?UDVZSUlqeE1PWFZqSzlMQ3NVcWhzRnkyeFI4WTQyaXp2d1M5ZVRJL1gxcXMy?=
 =?utf-8?B?UG1ZU0czTlNLOGRaL0lDTGNnRllvbjQ4eGNlKzI3cU5RNVJPei9IdUlVYzVk?=
 =?utf-8?B?NWI3T2VPbS96Uk0zdkxpei9sYVFaUWtXb0EyZW1HckpjNjV3OGZKWktUTzRQ?=
 =?utf-8?B?UXZ5NHY2djNYWDhDNWFaOHBUYzg1K1RQS2puTzVTK0lzR1ViVkVjb3JnTEpy?=
 =?utf-8?B?SzFteFdWbzRESUxmNm4vaVNmNGMrWVpVODdvckdPSEhLY1F4RzlzWnAwWmNV?=
 =?utf-8?B?WU1WcXBTdzN1Q1QySk4rNU1VZjZidzJvVDBKUUJEeWE5bXFvU3VsOTk3NUZE?=
 =?utf-8?B?cmdpLzdBQ2ZXWnBXckU0N21wcmxaRkRJM0ZNMzBNWFE5d2o1YW53Vks3MjN5?=
 =?utf-8?B?a2ZpbXlTWGk0QW1sUWxZMU1Pdzg1Slh2YUdRb1FydDFKS3R0dCtzUnMrZXZ0?=
 =?utf-8?B?Y2xyUjd0OFMvc0UzZTlYNVRyaUFzNy9HTnNkK0xYRHY2OWhaRG9obEhDNWpK?=
 =?utf-8?B?MEtrZVFwYjBRNm9RQmNuNlJtZTVLamY2UWZIUkJkeGdSaGVydmcvVVJRWUlG?=
 =?utf-8?B?OW82NkQ5aFAwRXNXZFlCR2VWc3R2T2RwaGNJOUs2bFRBTCs1OTRkSnpsMFRu?=
 =?utf-8?B?VjNqdGN6bkNGWWZ0WFE2ZS9zUk1YSEd5eWJ6eFA1YmRtVG8yU1lJVjVpVDg0?=
 =?utf-8?B?T092NjNRenJRZGVRa0Y3Zz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c1NuTlJlZjJjQ2V4dGs4VlpjaVh2S2o2cUE5WEI2QXlQVjhIV3AweVlmS1c1?=
 =?utf-8?B?aUw1UGtvSmVBakJERWZNZEhnWWp2Q05NbTloMW04SkRmNDFHQ1ZnczdHNFow?=
 =?utf-8?B?WFVRZmp2empIaGNEVkY1Y0dFY3V3MHdXWFhpcU5QMlA1eE5PODYrbjNMd0E3?=
 =?utf-8?B?bnBTeG9uS1BZNTEvQkhIaEhLbDM5cWRuc0haNUdGcm5vMnhhYy9FQ2dSYzZ0?=
 =?utf-8?B?aDZEZHoxSHMyVktzOWpuSVJsL05IU1JOVHZDYlZLOXR1ZjFuMURxVGFNcC9p?=
 =?utf-8?B?bmtjU0ZXWU42bDRRUmw3VlNFcWU5anpRL3RnbjFJdHFrKzdiVnFJYTJSdFRO?=
 =?utf-8?B?Z0Fwek9qMGtMSlZncHZNaVFQK2l2cG5hMjY2RlZzNFo3ZlZ2VjZaVUNXVGVR?=
 =?utf-8?B?RGxlTE1CbUYxSVhTd0U4cTU0Mno0eEZjbzhxc01hNExtMFByZWtlaTZ4K1RQ?=
 =?utf-8?B?bHhuN0pMZTdJUElzV1pIMEl4TmFZbUkyUE5pVmFNekVXWis1Z212UGtUUWV3?=
 =?utf-8?B?OG0zTjJYcUZLNGpERzdUSjJQdkJOaVAyMTk5b0w0TzNmUktYK25lK2ViZVZT?=
 =?utf-8?B?RXUvZmx5Y21JNkxzc3p5TzV0b2thK3NjazlpSmFxYWNsaU9HSmdJS25DYWF2?=
 =?utf-8?B?c2thdUFuMjdjckRTdE9aZU1GSGo5RWczZTFla3hpalh1QlBNc0FQVzcrd3JR?=
 =?utf-8?B?dDJMN0g0ZGwxVXVKVC9CRmovTjU2aFB1U2VyWUIrbEY3RlgzcDhockJnbnhL?=
 =?utf-8?B?R1A4cWd1Y2l3bk9VNExhaG9WajRUWHFJeVV2TDdJVzhFNzFaczZuV0FWRjhv?=
 =?utf-8?B?aElRbGwwMGNlelRtSjJDUjZlcVk3ZitzOEFCVTZYY05jMmN4TEtEd1NKSWNl?=
 =?utf-8?B?V0JsdUpObENwYnZsTkpIVnR6YUpIeHliUlhoOEx5cTc4TXAvYUpySkgzMVIx?=
 =?utf-8?B?dHZhRzU4T2U4NE5lZ0RwVzlzUGU5N1RtQTFsQmJqMnNSMW84RkVBTWRNMnlt?=
 =?utf-8?B?VVZOcjNPdEh3YXhmdFVIMWRhUWxBdWRYeC9kalZTVUJYdEx1VnBHLzcxMTUw?=
 =?utf-8?B?UUlLcC9CZVJLQkxEZjZKbWYxWGJRMWlwNGg1bGExMWp3dWVOay9DaFUzY3B4?=
 =?utf-8?B?aktPM2JJcDFHWGUyVFcwSUxKb2MrQ1dVSXMxZFdheTVxUlBpWWk4dlBNMk8v?=
 =?utf-8?B?SlF1Nm9DUjRVR08rdHNyOHRDWkJwZ3ZNNjJHTzhDNXlLZzJlN2xuYjQ2WUJ1?=
 =?utf-8?B?RkZSNDBWZWZiamVybFNjTTU0cEVHcDUyckhwcno2aFlQcWcvQm1CMXYrWEJQ?=
 =?utf-8?B?K3BRQnVEYlV4cE1BdXpZbW5JUUF6Mnlhbkt5cmVZK0FQcS9oK1NRUWhySzY0?=
 =?utf-8?B?YmFlRUNMQ3RkdkRWUERJakJiYlBBeVR0QkpjWFE3dVpXWUZ5OVp5cEMrQ1Vu?=
 =?utf-8?B?SWpzbXl1Q0ZmYklqQWd3blF2RFp4UHUzaG1mT2xnemltMXk5cjZQdTc5OXRE?=
 =?utf-8?B?ZnpzT3FnZDgzTjlLYnFYOEY2MkNJQlhlYUVqNHVSbEY2VThaUHVzRHNoN1Yx?=
 =?utf-8?B?VjZPREd0Q25YSVpKa1Vka1BnZkRyNkFmSVNqdXE3dmVvUVBraXJDSEhRQVBo?=
 =?utf-8?B?dG1BVTBiRXZRWHY5WWZOZGwwL1g3Rm5LcDF6Sm5hcW01ZlJlS2hXNUZHemFk?=
 =?utf-8?B?cytQcDFiUXRnV0VoSzFCYWNNbWgrZXpyMC9YQ0ZpRkI4Mlpjd3VNeE1xd0tX?=
 =?utf-8?B?dmFGZTFXTWZNUzYwamM1UjI1YTh4eGRzQytFNGVwY2pYOVoxZnZwT2oybE9n?=
 =?utf-8?B?ZWRwMDNTalFNMUozNm5LbGxmaC9lYVdyTXhmc1EwelFOVXIzYWtJa3ljZVVT?=
 =?utf-8?B?a0s0K0kxby9YdElRSzdPclRJUFhJVjIveWdXQ25hbHJrSE5Jd0gxTkY4eFdv?=
 =?utf-8?B?THRLZ3UvcEtDSVdFT0hBUzBuU3lnN3dMTWIya2NJZ1J1d2tURjZWektEYlFw?=
 =?utf-8?B?SGhnL0w1VUR4elFJNWJleXRhbXk1M3hGTFlmL21rNUtRMU5teWlseUQzSVNT?=
 =?utf-8?B?RHZhQTRkcVJQaDR2UDZzMHVJcDdiNk1ZS2FseG9BbU5XbTI1RnlUeTJjQmxQ?=
 =?utf-8?B?dU5kSGt0eDVORzYwc1B1WUZiMkNubDNPTGh4Z2pqWDY1eGVndTc1QjFzcGt3?=
 =?utf-8?B?dVE9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e55f501-daf8-41ea-3eae-08dd5265b937
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 10:51:41.0932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QXnW/Pami5EkdVAx+uqjIzE7nwYXiL1bf66lZ/D3fw2PhxlYaZz/pRUxMuIRb3jTM8f8DLFZ8WAILb6xr8/nPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6093
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Feb 2025 10:51:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17274

--------------3rHaIXX1TlCIPkSplqdrtLBI
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 20.02.2025 um 23:00 schrieb Richard Purdie:
> On Thu, 2025-02-20 at 18:37 +0100, Stefan Herbrechtsmeier wrote:
>> Am 20.02.2025 um 13:21 schrieb Richard Purdie:
>>> On Thu, 2025-02-20 at 12:45 +0100, Stefan Herbrechtsmeier via 
>>> lists.openembedded.org wrote:
>>>> Am 20.02.2025 um 11:22 schrieb Richard Purdie via 
>>>> lists.openembedded.org:
>>>>> On Wed, 2025-02-05 at 13:12 +0100, Stefan Herbrechtsmeier wrote:
>>>>>>   Am 05.02.2025 um 11:34 schrieb Richard Purdie:
>>>>>>   On Wed, 2025-02-05 at 08:15 +0100, Stefan Herbrechtsmeier via lists.openembedded.org wrote:
>>>>>> I’m open for suggestions. Even ARCHIVE or TARBALL are hard to
>>>>>> understand because it is only a relative path on the download mirror.
>>>>>> Alternative we can mark the lines as upstream or download mirror and
>>>>>> give the replacement different meanings. The path could be the
>>>>>> original PATH for an upstream mirror or the relative path of the
>>>>>> downloaded file for the download mirror.
>>>>> I've been giving this topic some thought. One idea I wondered about was
>>>>> to instead markup the mirror urls with how they're expected to work
>>>>> with a new parameter. For example:
>>>>> git://.*/.*http://downloads.yoctoproject.org/mirror/sources/?mirrorformat=mirrortarball
>>>> The ? could be problematic because it is the separator for the 
>>>> query. It is unlikely that the user really use this query parameter 
>>>> but it could complicate the code because we have to handle 
>>>> additional query parameters.
>>>> What does the "?mirrorformat=mirrortarball" mean? Will it work like 
>>>> a MIRRORTARBALL replacement?
>>>
>>> The mirrorformat parameter would be used by the mirroring code 
>>> itself to understand how to handle the url.
>>
>> What is the different to a MIRRORTARBALL replacement? The code will 
>> replace the word with the content.
>>
> Think about this from a usability perspective. We're struggling to 
> even work out good names for your proposal. Even if we work out the names,
We need the good names in any case. The ? is misleading because it is 
part of a common URL.

> I still don't think users are going to understand how to convert urls 
> into the new syntax.

git://.*/.* 
http://downloads.yoctoproject.org/mirror/sources/?mirrorformat=mirrortarball
git://.*/.* http://downloads.yoctoproject.org/mirror/sources/MIRRORTARBALL
git://.*/.* http://downloads.yoctoproject.org/mirror/sources/{MIRRORTARBALL}

git://.*/.* 
http://downloads.yoctoproject.org/mirror/sources/download.cgi?filename=?mirrorformat=mirrortarball
git://.*/.* 
http://downloads.yoctoproject.org/mirror/sources/download.cgi?filename=MIRRORTARBALL
git://.*/.* 
http://downloads.yoctoproject.org/mirror/sources/download.cgi?filename={MIRRORTARBALL}

> The difference with my proposed format is that we're specifying it in 
> a way which I suspect users will better understand without needing to 
> go and read the docs every time. We're saying what we're configuring 
> with the "mirrorformat" key and then the value should be able to 
> describe the format.
In this case we should add a prefix or use a parameter

git://.*/.* scmmirror:http://downloads.yoctoproject.org/mirror/sources/
http?://.*/.* 
downloadmirror:https://downloads.yoctoproject.org/mirror/sources/
http://  plain:https://

git://.*/.* 
http://downloads.yoctoproject.org/mirror/sources/;mirrorformat=scm
http?://.*/.* 
downloadmirror:https://downloads.yoctoproject.org/mirror/sources/;mirrorformat=download
http:// https://;mirrorformat=plain

> My proposal also gives us both a way to clearly detect when obsolete 
> formatting is used and a namespace mechanism to extend, with both 
> being in a way we can easily and clearly describe in the docs.
But it makes it impossible to support arbitrary regular expressions.

https://a.com/b/c/d.tar https://x.com/y/z.tar
https://a.com/b/(.*) https://x.com/y/\1

> I appreciate with your proposal we can add more strings and we can add 
> docs about how to migrate but I suspect users aren't going to be as 
> readily/easily able to understand it.

The main difference is that in your case the user have to read the docs 
to learn the pre- or postfix and in my case it has to learn the placeholder.

In any case the user need to understand that there is a difference 
between the download and a plain mirror. Either he has to mark the entry 
and hope that the magic behind work for his use case or he has to place 
the placeholder at the correct position.

git://.*/.* https://downloads.abc.org/mirror/sources/download/MIRRORTARBALL
git://.*/.* 
https://downloads.abc.org/mirror/sources/download.cgi?filename=MIRRORTARBALL
git://(.*)/(.*) 
https://downloads.abc.org/mirror/sources/download/\1/\2/MIRRORTARBALL

>>> It would be dropped from the modified url so is only therefore our 
>>> code's use. If there are additional parameters they would be passed 
>>> through as they are now.
>>>
>>>
>>>> How does a simple replacement should look like?
>>>>
>>>> http://  https://
>>>>
>>>> Because of the backward compatible this will replace the basename 
>>>> of the path.
>>>
>>> It would depend how the mirror is laid out. Some mirrors flatten the 
>>> urls like DL_DIR is laid out, some potentially don't. The standard 
>>> usage would likely have a mirrorformat=dldir parameter added.
>>
>> How does the user specify an entry that replace the http scheme with 
>> https and keeps everything else like it is (upstream mirror)?
>>
>
> http://.*/.* https://.*/.*?mirrorformat=upstream
I assume you mean the following because this doesn't make sense.

http:// https://?mirrorformat=upstream

What happens if the user need to add the query parameter mirror=1:

http:// https://?mirrorformat=upstream?mirror=1

> We need to determine the best value for "upstream". I'd also like to 
> review whether the .* formatting is the best way to handle this if we 
> are going to change the format.
>
>>>>> The possible options would be something like:
>>>>> mirrortarball - mirror tarballs taken from DL_DIR
>>>>> flattened - copy of DL_DIR so DL_DIR layout (maybe call it dldir?)
>>>>> upstream - layout is the same as the upstream directory structure so a direct url replacement
>>>> Do you think we have to handle the mirror tarball explicit? The 
>>>> mirror tarball is required for a scheme change.
>>>
>>> If we do that, we can avoid having to guess at too many urls to test 
>>> to figure out a mirror format so I think it would be an improvement 
>>> on where we are today.
>>
>> Do you mean we will test if the URL have a mirrortarball and if not 
>> skip the entry?
>>
> Correct.
But doesn't the mirrortarball depends on the scheme and we doesn't use 
the entry in anyway? Do you have an example?


>>>>> If using a mirrortarball mirror url, we'd know to use the values from
>>>>> urldata.mirrortarballs. We could add parameters to the fetcher to have
>>>>> two parameters, one will be the DL_DIR path and the other would be the
>>>>> upstream url path.
>>>> I don't understand where this is needed, because the mirror tarball 
>>>> and downloadfilename are used by different fetchers.
>>>
>>> Please keep in mind that downloadfilename is pretty much a 
>>> misfeature. It was added as we couldn't control collisions inside 
>>> dl_dir but it creates all kind of other problems. I think we do need 
>>> to handle that problem case but it does then mean we have to 
>>> indicate whether any given mirror uses "dldir" or "upstream" names 
>>> and paths.
>>
>> I don't understand the problem. The download mirror will use the 
>> downloadfilename or its default the basename of the localpath. The 
>> upstream mirror will use the path. The mirrortarball will use the 
>> mirrortarball. Why the fetcher need two parameters?
>>
> You are trying to make downloadfilename a supported parameter of every 
> fetcher.

No, I simply harmonize the use of the parameter and remove the 
problematic assumption that the filename inside the download folder 
doesn't contain additional folders.

A lot of fetcher already support the downloadfilename. Why should I 
assume that this is wrong and not the desired way.

> I'm arguing that I wish we'd never added it at all and that I'd rather 
> not use it or encourage its use.
What is your alternative to handle name clashes?

At the moment it is unclear if the usage of the basename or the folders 
inside the downloadfilename are the bug.

The problem is, that even the encoded URI as filename doesn't ensure 
name clashes because some projects doesn't encode the version inside the 
URI. The information from the recipe like BP is also problematical.

> I don't think you understand the way the fetcher API was written/used
Based on the code I assume the code was used to implement a download 
mirror. Thereby it assume that the download folder use a flat list of 
files. The problem is that neither the usage of the downloadfilename nor 
the syntax for the MIRROR variables reflect this. The functions contains 
some magic inside it.

Based on the code I assume there is a need for folders inside the 
downloadfilename and for the support of upstream mirrors.

>
>
> and this is why some of the patches are still on hold in master-next 
> until I can convince myself they are actually the right thing to do. 
> There have been too many other misunderstandings to give me confidence 
> they're going to do the right thing :(. Sadly, I just don't have the 
> time do the right level of review and everything else being asked of me.

Again my problem is that I don't know the vision. I look at the code and 
develop a solution which looks reasonable for the different existing use 
cases.

>>>>> One key question I have is how we might need to
>>>>> shorted the url path for some mirror urls to add/remove a path prefix
>>>>> in the mirroring.
>>>> What do you mean by this? The downloadfilename could contain a path 
>>>> without any problem after my change.
>>>
>>> See above, downloadfilename is not something I'm keen to promote and 
>>> is creating several of the problems we have by badly trying to hack 
>>> extra functionality onto the fetcher without thinking through all 
>>> the issues like mirroring.
>>
>> What is the desired way to avoid name clashes? The package manager 
>> fetcher need an generic way to override the basename.
>>
> Why does it need that?

What do we do if the upstream only provide a single URI to get the last 
version?

> Usually we've used the directory layout to avoid problems where we can 
> for example. I've been hoping we could do similar here rather than use 
> downloadfilename, which causes so many mirroring issues in the first 
> place.

Usually? The wget fetcher only use the basename. The npm fetcher use the 
scope and basename. The crate fetcher the name and version together with 
a specific file extension. Only the gomod fetcher use the path.

It looks like the gomod fetcher only works because it use the path. How 
should I know that it is the only correct user of the downloadfilename?

The mirror code only use the basename of the downloadfilename / path. 
The download mirror only works if the entry keeps the upstream path.

>>>> Alternative we could make some replacement mandatory if a wildcard 
>>>> is used to detect obsolete entries.
>>>
>>> I don't understand that.
>>
>> If we have a wildcard .* in the path we need to know how to replace 
>> it. This could be the PATH, BASENAME, DOWNLOADFILENAME, MIRRORARCHIVE 
>> or re group. But in case of the re group this could still be an old 
>> entry.
>>
> I'm not entirely sure we want to keep all the different syntax. One 
> frustration I have with the current code is the way pattern matches 
> are restricted to that url component for example and I've wondered if 
> we could/should do something different instead, if we can make it simpler.

What is the purpose of the MIRROR. Should it be support any use case 
(regex) or should it only support specific use cases?

Maybe I could simple remove the url components. Until now I simple 
minimize the changes to simplify the review.

>> Do support all cases we need a fix prefix or delimiter:
>>
>> r:http https
>>
>> http#https
>> http|https
>>
>> http?://.*/.*|http://downloads.yoctoproject.org/mirror/sources/DOWNLOADARCHIVE
>> git://.*/.*|http://downloads.yoctoproject.org/mirror/sources/MIRRORARCHIVE
>>
>>
>>> I do think we have too many problems in the existing mirroring url 
>>> mapping and we probably need to rework this rather than try and pile 
>>> more patches into it and complicate it further.
>> I have already rework it. If I can remove the backward compatibility 
>> and replace it with an error this would simplify the code. I only 
>> need a better name for the DOWNLOADFILENAME (DOWNLOADARCHIVE) and add 
>> the MIRRORARCHIV.
>
>>
>>> The question is whether the proposal fixes the issues it needs to 
>>> and has enough simplification and benefit to justify making the change.
>> My patches support folders in the downloadfilename, upstream mirrors 
>> and renames. I have to rework the MIRROR strings but therefore the 
>> commented out tests work.
>>
>
>
> You've created a patch, yes. I don't think it improves usability 
> though and I think you're also pushing concepts like downloadfilename 
> into places we might not want to use them too.
Until now I don't know the desired solution. Now I think your desired 
solution is to mimic the upstream in the download folder and this is a 
requirement for the rework of the mirror code. This means we have to fix 
the exiting code first and should document this requirement.

> For me to merge patches like these, there needs to be a sense of trust 
> and shared understanding. This simply isn't there, you're just saying 
> your patches are fine as they are, I disagree.
No. I don't understand what problem your proposed solution like the "?" 
solve. The solutions comes with drawbacks and I want to understand the 
advantages which balance the disadvantage.

> I therefore worry we're at an impasse and are going to struggle to 
> move beyond this. That does make me quite sad.
We haven't an impasse. The problem is the code doesn't reflect your 
concepts and it's hard for me to identify them from your replies.

If I assume that the download folder should mimic the upstream we 
doesn't need the DOWNLOADARCHIVE because it should be the same as the PATH.

But I'm unsure if this works because the PATH isn't enough to unique 
identify a file and a path not always contain a file extension.

https://www.linuxtv.org/hg/dvb-apps/archive/3d43b280298c.tar.bz2;downloadfilename=${BPN}-3d43b280298c.tar.bz2
https://wrapdb.mesonbuild.com/v2/fmt_11.0.2-1/get_patch;downloadfilename=fmt_11.0.2-1_patch.zip
http://miniupnp.tuxfamily.org/files/download.php?file=${BP}.tar.gz;downloadfilename=${BP}.tar.gz
https://selenic.com/repo/${BPN}/archive/${HG_CHANGESET}.tar.bz2;downloadfilename=${BP}.tar.bz2
http://www.netlib.org/benchmark/dhry-c;downloadfilename=dhry-c.shar
https://sourceforge.net/p/giflib/code/ci/d54b45b0240d455bbaedee4be5203d2703e59967/tree/doc/giflib-logo.gif?format=raw;downloadfilename=giflib-logo.gif

Additionally the same PATH could be used on different hosts. If we 
remove the possibility for the user to override the filename inside the 
download folder we have to ensure that every URI leads to an other 
filename inside the download folder.

We need to generate a file path from the whole URI to append it to the 
download mirror URI.

I suspect we have to define the vision for the download folder first 
before we could discuses how the mirror entries should look like.

--------------3rHaIXX1TlCIPkSplqdrtLBI
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Am 20.02.2025 um 23:00 schrieb Richard
      Purdie:<br>
    </div>
    <blockquote type="cite" cite="mid:f33e9499466eebc5d421ec2556af47cb5ddfd277.camel@linuxfoundation.org">
      
      <style>pre,code,address {
  margin: 0px;
}h1,h2,h3,h4,h5,h6 {
  margin-top: 0.2em;
  margin-bottom: 0.2em;
}ol,ul {
  margin-top: 0em;
  margin-bottom: 0em;
}blockquote {
  margin-top: 0em;
  margin-bottom: 0em;
}</style>
      <div>On Thu, 2025-02-20 at 18:37 +0100, Stefan Herbrechtsmeier
        wrote:</div>
      <blockquote type="cite" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
        <div> </div>
        <div class="moz-cite-prefix">Am 20.02.2025 um 13:21 schrieb
          Richard Purdie:<br>
        </div>
        <blockquote type="cite" cite="mid:9ecb0289143f35037902a569de8a7f048262f779.camel@linuxfoundation.org" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
          <div>On Thu, 2025-02-20 at 12:45 +0100, Stefan Herbrechtsmeier
            via lists.openembedded.org wrote:</div>
          <blockquote type="cite" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
            <div class="moz-cite-prefix">Am 20.02.2025 um 11:22 schrieb
              Richard Purdie via lists.openembedded.org:<br>
            </div>
            <blockquote type="cite" cite="mid:d971d67321a2d43666885004f7ff9a479f4d1855.camel@linuxfoundation.org" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
              <pre>On Wed, 2025-02-05 at 13:12 +0100, Stefan Herbrechtsmeier wrote:</pre>
              <blockquote type="cite" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
                <pre>&nbsp;Am 05.02.2025 um 11:34 schrieb Richard Purdie:</pre>
                <div> </div>
                <pre>&nbsp;On Wed, 2025-02-05 at 08:15 +0100, Stefan Herbrechtsmeier via lists.openembedded.org wrote:</pre>
                <div> </div>
                <div>I’m open for suggestions. Even ARCHIVE or TARBALL
                  are hard to</div>
                <div> </div>
                <pre>understand because it is only a relative path on the download mirror.</pre>
                <div> </div>
                <pre>Alternative we can mark the lines as upstream or download mirror and</pre>
                <div> </div>
                <pre>give the replacement different meanings. The path could be the</pre>
                <div> </div>
                <pre>original PATH for an upstream mirror or the relative path of the</pre>
                <div> </div>
                <pre>downloaded file for the download mirror.</pre>
                <div> </div>
                <div> </div>
                <div> </div>
              </blockquote>
              <div> </div>
              <div> </div>
              <div> </div>
              <pre>I've been giving this topic some thought. One idea I wondered about was</pre>
              <div> </div>
              <pre>to instead markup the mirror urls with how they're expected to work</pre>
              <div> </div>
              <pre>with a new parameter. For example:</pre>
              <div> </div>
              <pre>git://.*/.*  <a class="moz-txt-link-freetext" href="http://downloads.yoctoproject.org/mirror/sources/?mirrorformat=mirrortarball" moz-do-not-send="true">http://downloads.yoctoproject.org/mirror/sources/?mirrorformat=mirrortarball</a></pre>
              <div> </div>
              <div> </div>
              <div> </div>
            </blockquote>
            <div> </div>
            <div> The ? could be problematic because it is the separator
              for the query. It is unlikely that the user really use
              this query parameter but it could complicate the code
              because we have to handle additional query parameters.<br>
              What does the &quot;?mirrorformat=mirrortarball&quot; mean? Will it
              work like a MIRRORTARBALL replacement?</div>
            <div> </div>
          </blockquote>
          <div> </div>
          <div><br>
          </div>
          <div> </div>
          <div>The mirrorformat parameter would be used by the mirroring
            code itself to understand how to handle the url.<br>
          </div>
          <div> </div>
        </blockquote>
        <div> </div>
        <p>What is the different to a MIRRORTARBALL replacement? The
          code will replace the word with the content.</p>
      </blockquote>
      <div>Think about this from a usability perspective. We're
        struggling to even work out good names for your proposal. Even
        if we work out the names,<br>
      </div>
    </blockquote>
    We need the good names in any case. The ? is misleading because it
    is part of a common URL.<br>
    <br>
    <blockquote type="cite" cite="mid:f33e9499466eebc5d421ec2556af47cb5ddfd277.camel@linuxfoundation.org">
      <div> I still don't think users are going to understand how to
        convert urls into the new syntax.<br>
      </div>
    </blockquote>
    <p>git://.*/.*&nbsp;
<a class="moz-txt-link-freetext" href="http://downloads.yoctoproject.org/mirror/sources/?mirrorformat=mirrortarball">http://downloads.yoctoproject.org/mirror/sources/?mirrorformat=mirrortarball</a><br>
      git://.*/.*&nbsp;
      <a class="moz-txt-link-freetext" href="http://downloads.yoctoproject.org/mirror/sources/MIRRORTARBALL">http://downloads.yoctoproject.org/mirror/sources/MIRRORTARBALL</a><br>
      git://.*/.*&nbsp;
      <a class="moz-txt-link-freetext" href="http://downloads.yoctoproject.org/mirror/sources/">http://downloads.yoctoproject.org/mirror/sources/</a>{MIRRORTARBALL}<br>
      <br>
      git://.*/.*&nbsp;
<a class="moz-txt-link-freetext" href="http://downloads.yoctoproject.org/mirror/sources/download.cgi?filename=?mirrorformat=mirrortarball">http://downloads.yoctoproject.org/mirror/sources/download.cgi?filename=?mirrorformat=mirrortarball</a><br>
      git://.*/.*&nbsp;
<a class="moz-txt-link-freetext" href="http://downloads.yoctoproject.org/mirror/sources/download.cgi?filename=MIRRORTARBALL">http://downloads.yoctoproject.org/mirror/sources/download.cgi?filename=MIRRORTARBALL</a><br>
      git://.*/.*&nbsp;
<a class="moz-txt-link-freetext" href="http://downloads.yoctoproject.org/mirror/sources/download.cgi?filename=">http://downloads.yoctoproject.org/mirror/sources/download.cgi?filename=</a>{MIRRORTARBALL}<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:f33e9499466eebc5d421ec2556af47cb5ddfd277.camel@linuxfoundation.org">
      <div>The difference with my proposed format is that we're
        specifying it in a way which I suspect users will better
        understand without needing to go and read the docs every time.
        We're saying what we're configuring with the &quot;mirrorformat&quot; key
        and then the value should be able to describe the format.<br>
      </div>
    </blockquote>
    In this case we should add a prefix or use a parameter<br>
    <p>git://.*/.*&nbsp;
      scmmirror:<a class="moz-txt-link-freetext" href="http://downloads.yoctoproject.org/mirror/sources/">http://downloads.yoctoproject.org/mirror/sources/</a><br>
      http?://.*/.*&nbsp;
      downloadmirror:<a class="moz-txt-link-freetext" href="https://downloads.yoctoproject.org/mirror/sources/">https://downloads.yoctoproject.org/mirror/sources/</a><br>
      http://&nbsp; plain:https://<br>
      <br>
      git://.*/.*&nbsp;
      <a class="moz-txt-link-freetext" href="http://downloads.yoctoproject.org/mirror/sources/;mirrorformat=scm">http://downloads.yoctoproject.org/mirror/sources/;mirrorformat=scm</a><br>
      http?://.*/.*&nbsp;
downloadmirror:<a class="moz-txt-link-freetext" href="https://downloads.yoctoproject.org/mirror/sources/;mirrorformat=download">https://downloads.yoctoproject.org/mirror/sources/;mirrorformat=download</a><br>
      http://&nbsp; <a class="moz-txt-link-freetext" href="https://;mirrorformat=plain">https://;mirrorformat=plain</a><br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:f33e9499466eebc5d421ec2556af47cb5ddfd277.camel@linuxfoundation.org">
      <div>My proposal also gives us both a way to clearly detect when
        obsolete formatting is used and a namespace mechanism to extend,
        with both being in a way we can easily and clearly describe in
        the docs.<br>
      </div>
    </blockquote>
    But it makes it impossible to support arbitrary regular expressions.<br>
    <br>
    <a class="moz-txt-link-freetext" href="https://a.com/b/c/d.tar">https://a.com/b/c/d.tar</a>&nbsp; <a class="moz-txt-link-freetext" href="https://x.com/y/z.tar">https://x.com/y/z.tar</a><br>
    <a class="moz-txt-link-freetext" href="https://a.com/b/(.*)">https://a.com/b/(.*)</a>&nbsp; <a class="moz-txt-link-freetext" href="https://x.com/y/\1">https://x.com/y/\1</a><br>
    <br>
    <blockquote type="cite" cite="mid:f33e9499466eebc5d421ec2556af47cb5ddfd277.camel@linuxfoundation.org">
      <div>I appreciate with your proposal we can add more strings and
        we can add docs about how to migrate but I suspect users aren't
        going to be as readily/easily able to understand it.<br>
      </div>
    </blockquote>
    <p>The main difference is that in your case the user have to read
      the docs to learn the pre- or postfix and in my case it has to
      learn the placeholder.<br>
      <br>
      In any case the user need to understand that there is a difference
      between the download and a plain mirror. Either he has to mark the
      entry and hope that the magic behind work for his use case or he
      has to place the placeholder at the correct position.<br>
      <br>
      git://.*/.*&nbsp;
      <a class="moz-txt-link-freetext" href="https://downloads.abc.org/mirror/sources/download/MIRRORTARBALL">https://downloads.abc.org/mirror/sources/download/MIRRORTARBALL</a><br>
      git://.*/.*&nbsp;
<a class="moz-txt-link-freetext" href="https://downloads.abc.org/mirror/sources/download.cgi?filename=MIRRORTARBALL">https://downloads.abc.org/mirror/sources/download.cgi?filename=MIRRORTARBALL</a><br>
      git://(.*)/(.*)&nbsp;
      <a class="moz-txt-link-freetext" href="https://downloads.abc.org/mirror/sources/download/\1/\2/MIRRORTARBALL">https://downloads.abc.org/mirror/sources/download/\1/\2/MIRRORTARBALL</a><br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:f33e9499466eebc5d421ec2556af47cb5ddfd277.camel@linuxfoundation.org">
      <blockquote type="cite" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
        <blockquote type="cite" cite="mid:9ecb0289143f35037902a569de8a7f048262f779.camel@linuxfoundation.org" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
          <div>It would be dropped from the modified url so is only
            therefore our code's use. If there are additional parameters
            they would be passed through as they are now.</div>
          <div> </div>
          <div><br>
          </div>
          <div> <br>
          </div>
          <blockquote type="cite" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
            <div> </div>
            <div>How does a simple replacement should look like?<br>
              <br>
              http://&nbsp; https://<br>
              <br>
              Because of the backward compatible this will replace the
              basename of the path.</div>
            <div> </div>
          </blockquote>
          <div> </div>
          <div><br>
          </div>
          <div> </div>
          <div>It would depend how the mirror is laid out. Some mirrors
            flatten the urls like DL_DIR is laid out, some potentially
            don't. The standard usage would likely have a
            mirrorformat=dldir parameter added.<br>
          </div>
          <div> </div>
        </blockquote>
        <div> </div>
        <p>How does the user specify an entry that replace the http
          scheme with https and keeps everything else like it is
          (upstream mirror)?</p>
      </blockquote>
      <div><br>
      </div>
      <div>http://.*/.* https://.*/.*?mirrorformat=upstream<br>
      </div>
    </blockquote>
    I assume you mean the following because this doesn't make sense.<br>
    <br>
    http:// https://?mirrorformat=upstream<br>
    <br>
    What happens if the user need to add the query parameter mirror=1:<br>
    <br>
    http:// https://?mirrorformat=upstream?mirror=1<br>
    <br>
    <blockquote type="cite" cite="mid:f33e9499466eebc5d421ec2556af47cb5ddfd277.camel@linuxfoundation.org">
      <div>We need to determine the best value for &quot;upstream&quot;. I'd also
        like to review whether the .* formatting is the best way to
        handle this if we are going to change the format.</div>
      <div><br>
      </div>
      <blockquote type="cite" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
        <blockquote type="cite" cite="mid:9ecb0289143f35037902a569de8a7f048262f779.camel@linuxfoundation.org" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
          <blockquote type="cite" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
            <blockquote type="cite" cite="mid:d971d67321a2d43666885004f7ff9a479f4d1855.camel@linuxfoundation.org" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
              <pre>The possible options would be something like:</pre>
              <div> </div>
              <pre>mirrortarball - mirror tarballs taken from DL_DIR</pre>
              <div> </div>
              <pre>flattened - copy of DL_DIR so DL_DIR layout (maybe call it dldir?)</pre>
              <div> </div>
              <pre>upstream - layout is the same as the upstream directory structure so a direct url replacement</pre>
              <div> </div>
              <div> </div>
              <div> </div>
            </blockquote>
            <div> </div>
            <div> Do you think we have to handle the mirror tarball
              explicit? The mirror tarball is required for a scheme
              change.</div>
            <div> </div>
          </blockquote>
          <div> </div>
          <div><br>
          </div>
          <div> </div>
          <div>If we do that, we can avoid having to guess at too many
            urls to test to figure out a mirror format so I think it
            would be an improvement on where we are today.<br>
          </div>
          <div> </div>
        </blockquote>
        <div> </div>
        <p>Do you mean we will test if the URL have a mirrortarball and
          if not skip the entry?</p>
      </blockquote>
      <div>Correct.<br>
      </div>
    </blockquote>
    But doesn't the mirrortarball depends on the scheme and we doesn't
    use the entry in anyway? Do you have an example?<br>
    <br>
    <br>
    <blockquote type="cite" cite="mid:f33e9499466eebc5d421ec2556af47cb5ddfd277.camel@linuxfoundation.org">
      <blockquote type="cite" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
        <blockquote type="cite" cite="mid:9ecb0289143f35037902a569de8a7f048262f779.camel@linuxfoundation.org" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
          <blockquote type="cite" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
            <blockquote type="cite" cite="mid:d971d67321a2d43666885004f7ff9a479f4d1855.camel@linuxfoundation.org" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
              <pre>If using a mirrortarball mirror url, we'd know to use the values from</pre>
              <div> </div>
              <pre>urldata.mirrortarballs. We could add parameters to the fetcher to have</pre>
              <div> </div>
              <pre>two parameters, one will be the DL_DIR path and the other would be the</pre>
              <div> </div>
              <pre>upstream url path.</pre>
              <div> </div>
              <div> </div>
              <div> </div>
            </blockquote>
            <div> </div>
            <div> I don't understand where this is needed, because the
              mirror tarball and downloadfilename are used by different
              fetchers.</div>
            <div> </div>
          </blockquote>
          <div> </div>
          <div><br>
          </div>
          <div> </div>
          <div>Please keep in mind that downloadfilename is pretty much
            a misfeature. It was added as we couldn't control collisions
            inside dl_dir but it creates all kind of other problems. I
            think we do need to handle that problem case but it does
            then mean we have to indicate whether any given mirror uses
            &quot;dldir&quot; or &quot;upstream&quot; names and paths.<br>
          </div>
          <div> </div>
        </blockquote>
        <div> </div>
        <p>I don't understand the problem. The download mirror will use
          the downloadfilename or its default the basename of the
          localpath. The upstream mirror will use the path. The
          mirrortarball will use the mirrortarball. Why the fetcher need
          two parameters?</p>
      </blockquote>
      <div>You are trying to make downloadfilename a supported parameter
        of every fetcher.<br>
      </div>
    </blockquote>
    <p>No, I simply harmonize the use of the parameter and remove the
      problematic assumption that the filename inside the download
      folder doesn't contain additional folders.<br>
    </p>
    <p>A lot of fetcher already support the downloadfilename. Why should
      I assume that this is wrong and not the desired way.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:f33e9499466eebc5d421ec2556af47cb5ddfd277.camel@linuxfoundation.org">
      <div>I'm arguing that I wish we'd never added it at all and that
        I'd rather not use it or encourage its use.<br>
      </div>
    </blockquote>
    What is your alternative to handle name clashes?<br>
    <br>
    At the moment it is unclear if the usage of the basename or the
    folders inside the downloadfilename are the bug.<br>
    <br>
    The problem is, that even the encoded URI as filename doesn't ensure
    name clashes because some projects doesn't encode the version inside
    the URI. The information from the recipe like BP is also
    problematical.<br>
    <br>
    <blockquote type="cite" cite="mid:f33e9499466eebc5d421ec2556af47cb5ddfd277.camel@linuxfoundation.org">
      <div>I don't think you understand the way the fetcher API was
        written/used<br>
      </div>
    </blockquote>
    Based on the code I assume the code was used to implement a download
    mirror. Thereby it assume that the download folder use a flat list
    of files. The problem is that neither the usage of the
    downloadfilename nor the syntax for the MIRROR variables reflect
    this. The functions contains some magic inside it.<br>
    <br>
    Based on the code I assume there is a need for folders inside the
    downloadfilename and for the support of upstream mirrors. <br>
    <br>
    <blockquote type="cite" cite="mid:f33e9499466eebc5d421ec2556af47cb5ddfd277.camel@linuxfoundation.org">
      <div> <br>
        <br>
        and this is why some of the patches are still on hold in
        master-next until I can convince myself they are actually the
        right thing to do. There have been too many other
        misunderstandings to give me confidence they're going to do the
        right thing :(. Sadly, I just don't have the time do the right
        level of review and everything else being asked of me.<br>
      </div>
    </blockquote>
    <p>Again my problem is that I don't know the vision. I look at the
      code and develop a solution which looks reasonable for the
      different existing use cases.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:f33e9499466eebc5d421ec2556af47cb5ddfd277.camel@linuxfoundation.org">
      <blockquote type="cite" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
        <blockquote type="cite" cite="mid:9ecb0289143f35037902a569de8a7f048262f779.camel@linuxfoundation.org" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
          <blockquote type="cite" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
            <blockquote type="cite" cite="mid:d971d67321a2d43666885004f7ff9a479f4d1855.camel@linuxfoundation.org" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
              <pre>One key question I have is how we might need to</pre>
              <div> </div>
              <pre>shorted the url path for some mirror urls to add/remove a path prefix</pre>
              <div> </div>
              <pre>in the mirroring.</pre>
              <div> </div>
              <div> </div>
              <div> </div>
            </blockquote>
            <div> </div>
            <div> What do you mean by this? The downloadfilename could
              contain a path without any problem after my change.</div>
            <div> </div>
          </blockquote>
          <div> </div>
          <div><br>
          </div>
          <div> </div>
          <div>See above, downloadfilename is not something I'm keen to
            promote and is creating several of the problems we have by
            badly trying to hack extra functionality onto the fetcher
            without thinking through all the issues like mirroring.<br>
          </div>
          <div> </div>
        </blockquote>
        <div> </div>
        <p>What is the desired way to avoid name clashes? The package
          manager fetcher need an generic way to override the basename.</p>
      </blockquote>
      <div>Why does it need that?<br>
      </div>
    </blockquote>
    <p>What do we do if the upstream only provide a single URI to get
      the last version?<br>
    </p>
    <blockquote type="cite" cite="mid:f33e9499466eebc5d421ec2556af47cb5ddfd277.camel@linuxfoundation.org">
      <div> Usually we've used the directory layout to avoid problems
        where we can for example. I've been hoping we could do similar
        here rather than use downloadfilename, which causes so many
        mirroring issues in the first place.<br>
      </div>
    </blockquote>
    <br>
    Usually? The wget fetcher only use the basename. The npm fetcher use
    the scope and basename. The crate fetcher the name and version
    together with a specific file extension. Only the gomod fetcher use
    the path.<br>
    <br>
    It looks like the gomod fetcher only works because it use the path.
    How should I know that it is the only correct user of the
    downloadfilename?<br>
    <br>
    The mirror code only use the basename of the downloadfilename /
    path. The download mirror only works if the entry keeps the upstream
    path.<br>
    <br>
    <blockquote type="cite" cite="mid:f33e9499466eebc5d421ec2556af47cb5ddfd277.camel@linuxfoundation.org">
      <blockquote type="cite" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
        <blockquote type="cite" cite="mid:9ecb0289143f35037902a569de8a7f048262f779.camel@linuxfoundation.org" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
          <blockquote type="cite" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
            <div>Alternative we could make some replacement mandatory if
              a wildcard is used to detect obsolete entries.</div>
            <div> </div>
          </blockquote>
          <div> </div>
          <div><br>
          </div>
          <div> </div>
          <div>I don't understand that.<br>
          </div>
          <div> </div>
        </blockquote>
        <div> </div>
        <p>If we have a wildcard .* in the path we need to know how to
          replace it. This could be the PATH, BASENAME,
          DOWNLOADFILENAME, MIRRORARCHIVE or re group. But in case of
          the re group this could still be an old entry.</p>
      </blockquote>
      <div>I'm not entirely sure we want to keep all the different
        syntax. One frustration I have with the current code is the way
        pattern matches are restricted to that url component for example
        and I've wondered if we could/should do something different
        instead, if we can make it simpler.<br>
      </div>
    </blockquote>
    <p>What is the purpose of the MIRROR. Should it be support any use
      case (regex) or should it only support specific use cases?<br>
      <br>
      Maybe I could simple remove the url components. Until now I simple
      minimize the changes to simplify the review.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:f33e9499466eebc5d421ec2556af47cb5ddfd277.camel@linuxfoundation.org">
      <blockquote type="cite" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
        <p>Do support all cases we need a fix prefix or delimiter:<br>
          <br>
          r:http https</p>
        <div> </div>
        <p>http#https<br>
          http|https<br>
          <br>
          http?://.*/.*|<a class="moz-txt-link-freetext" href="http://downloads.yoctoproject.org/mirror/sources/DOWNLOADARCHIVE" moz-do-not-send="true">http://downloads.yoctoproject.org/mirror/sources/DOWNLOADARCHIVE</a><br>
          git://.*/.*|<a class="moz-txt-link-freetext" href="http://downloads.yoctoproject.org/mirror/sources/MIRRORARCHIVE" moz-do-not-send="true">http://downloads.yoctoproject.org/mirror/sources/MIRRORARCHIVE</a><br>
          <br>
        </p>
        <div> <br>
        </div>
        <blockquote type="cite" cite="mid:9ecb0289143f35037902a569de8a7f048262f779.camel@linuxfoundation.org" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
          <div> </div>
          <div>I do think we have too many problems in the existing
            mirroring url mapping and we probably need to rework this
            rather than try and pile more patches into it and complicate
            it further.<br>
          </div>
          <div> </div>
        </blockquote>
        <div> I have already rework it. If I can remove the backward
          compatibility and replace it with an error this would simplify
          the code. I only need a better name for the DOWNLOADFILENAME
          (DOWNLOADARCHIVE) and add the MIRRORARCHIV.</div>
      </blockquote>
      <div><br>
      </div>
      <blockquote type="cite" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
        <div><br>
        </div>
        <blockquote type="cite" cite="mid:9ecb0289143f35037902a569de8a7f048262f779.camel@linuxfoundation.org" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
          <div> </div>
          <div>The question is whether the proposal fixes the issues it
            needs to and has enough simplification and benefit to
            justify making the change.<br>
          </div>
          <div> </div>
        </blockquote>
        <div> My patches support folders in the downloadfilename,
          upstream mirrors and renames. I have to rework the MIRROR
          strings but therefore the commented out tests work.<br>
          <br>
        </div>
      </blockquote>
      <div><br>
      </div>
      <div><br>
      </div>
      <div>
        <div>You've created a patch, yes. I don't think it improves
          usability though and I think you're also pushing concepts like
          downloadfilename into places we might not want to use them
          too.<br>
        </div>
      </div>
    </blockquote>
    Until now I don't know the desired solution. Now I think your
    desired solution is to mimic the upstream in the download folder and
    this is a requirement for the rework of the mirror code. This means
    we have to fix the exiting code first and should document this
    requirement.<br>
    <br>
    <blockquote type="cite" cite="mid:f33e9499466eebc5d421ec2556af47cb5ddfd277.camel@linuxfoundation.org">
      <div>
        <div>For me to merge patches like these, there needs to be a
          sense of trust and shared understanding. This simply isn't
          there, you're just saying your patches are fine as they are, I
          disagree.<br>
        </div>
      </div>
    </blockquote>
    No. I don't understand what problem your proposed solution like the
    &quot;?&quot; solve. The solutions comes with drawbacks and I want to
    understand the advantages which balance the disadvantage.<br>
    <br>
    <blockquote type="cite" cite="mid:f33e9499466eebc5d421ec2556af47cb5ddfd277.camel@linuxfoundation.org">
      <div>
        <div>I therefore worry we're at an impasse and are going to
          struggle to move beyond this. That does make me quite sad.<br>
        </div>
      </div>
    </blockquote>
    We haven't an impasse. The problem is the code doesn't reflect your
    concepts and it's hard for me to identify them from your replies.<br>
    <br>
    If I assume that the download folder should mimic the upstream we
    doesn't need the DOWNLOADARCHIVE because it should be the same as
    the PATH.<br>
    <p>But I'm unsure if this works because the PATH isn't enough to
      unique identify a file and a path not always contain a file
      extension.<br>
      <br>
<a class="moz-txt-link-freetext" href="https://www.linuxtv.org/hg/dvb-apps/archive/3d43b280298c.tar.bz2;downloadfilename=$">https://www.linuxtv.org/hg/dvb-apps/archive/3d43b280298c.tar.bz2;downloadfilename=$</a>{BPN}-3d43b280298c.tar.bz2<br>
<a class="moz-txt-link-freetext" href="https://wrapdb.mesonbuild.com/v2/fmt_11.0.2-1/get_patch;downloadfilename=fmt_11.0.2-1_patch.zip">https://wrapdb.mesonbuild.com/v2/fmt_11.0.2-1/get_patch;downloadfilename=fmt_11.0.2-1_patch.zip</a><br>
<a class="moz-txt-link-freetext" href="http://miniupnp.tuxfamily.org/files/download.php?file=$">http://miniupnp.tuxfamily.org/files/download.php?file=$</a>{BP}.tar.gz;downloadfilename=${BP}.tar.gz<br>
<a class="moz-txt-link-freetext" href="https://selenic.com/repo/$">https://selenic.com/repo/$</a>{BPN}/archive/${HG_CHANGESET}.tar.bz2;downloadfilename=${BP}.tar.bz2<br>
<a class="moz-txt-link-freetext" href="http://www.netlib.org/benchmark/dhry-c;downloadfilename=dhry-c.shar">http://www.netlib.org/benchmark/dhry-c;downloadfilename=dhry-c.shar</a><br>
<a class="moz-txt-link-freetext" href="https://sourceforge.net/p/giflib/code/ci/d54b45b0240d455bbaedee4be5203d2703e59967/tree/doc/giflib-logo.gif?format=raw;downloadfilename=giflib-logo.gif">https://sourceforge.net/p/giflib/code/ci/d54b45b0240d455bbaedee4be5203d2703e59967/tree/doc/giflib-logo.gif?format=raw;downloadfilename=giflib-logo.gif</a><br>
      <br>
      Additionally the same PATH could be used on different hosts. If we
      remove the possibility for the user to override the filename
      inside the download folder we have to ensure that every URI leads
      to an other filename inside the download folder.<br>
      <br>
      We need to generate a file path from the whole URI to append it to
      the download mirror URI.<br>
      <br>
      I suspect we have to define the vision for the download folder
      first before we could discuses how the mirror entries should look
      like.</p>
    <blockquote type="cite" cite="mid:f33e9499466eebc5d421ec2556af47cb5ddfd277.camel@linuxfoundation.org">
      <style>pre,code,address { margin: 0px; }h1,h2,h3,h4,h5,h6 { margin-top: 0.2em; margin-bottom: 0.2em; }ol,ul { margin-top: 0em; margin-bottom: 0em; }blockquote { margin-top: 0em; margin-bottom: 0em;</style>
    </blockquote>
  </body>
</html>

--------------3rHaIXX1TlCIPkSplqdrtLBI--

