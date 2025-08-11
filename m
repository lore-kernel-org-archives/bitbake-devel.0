Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148F7C87FD2
	for <webhook@archiver.kernel.org>; Mon, 11 Aug 2025 08:33:45 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.43729.1754901216948504140
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 11 Aug 2025 01:33:37 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=0318e6e81f=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 57B6ACrE2038850
	for <bitbake-devel@lists.openembedded.org>; Mon, 11 Aug 2025 08:33:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 48duj2hd7k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 11 Aug 2025 08:33:35 +0000 (GMT)
Received: from m0250811.ppops.net (m0250811.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57B8XZHU2272811;
	Mon, 11 Aug 2025 08:33:35 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 48duj2hd7j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 08:33:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vk3/J89YKdGmloHZyt4uScjhlJ2zBpirduSlcpGauX74/ElS9+Xib6Bp7VfCGiOasqFR4X4EeJ8vKAX6bcy9bE6TheW6Qpnyem3QGHTA2xEMGyRGul2g8C2+JN3/XXaUzaHsslWRXCc+IL8FhURE1nATn9MeBLWuNYJgFnhyJA5BEaow0HmXO8Pt1Vzg/gOay3dQTN/VvND3V0/+S8UIDXZNxpvjBNyIxChi9h/OsmlL0N5v1DIo4Bi9/bpZcCGJdRB2/i/68APPjs6p1hteBPqUHKvZhzoHd7vmTvHgT13OzBr0HCu2HAtJOwi+ftUbJ93vAjdEB40KE+/NyTKXtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2Xf3UbDo/O0xTFeInoFrjpDvCh9GCwGa3dpdKK77cw=;
 b=NhCZ/0gTKSj2QmJMRM/VeR9N1mXOJIZPqRKfXrwJ9ZacaqpPax2T/Tfd6KqvznO2lo9/aGcKwNj+Ir4d3z2O4cvvWiaRKPHqHnOoeKgBZgHm1DjBvofVrt4wu+QBWOyFIlNUfh5b/WA9Qpcv7KAsuBHuS9CgGHHWOtpLREHL3SBYjKJS7hBPbIzv6NfdfQunzGAGISbBUf0pwLKcEmgY8ceKQzKONfHgISzUFP3BvxyqjJIlltkPTWfJ0hYqxbbSbvBx9E38Lz0nm46xzuY9JIXH/+srI2sOZSgHTg7rVINkH9csuA+fQJ4yMLtwelmZ7cWQp4iEWQFX5OwgHLrc9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from LV3PR11MB8531.namprd11.prod.outlook.com (2603:10b6:408:1b6::15)
 by PH7PR11MB6650.namprd11.prod.outlook.com (2603:10b6:510:1a8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Mon, 11 Aug
 2025 08:33:33 +0000
Received: from LV3PR11MB8531.namprd11.prod.outlook.com
 ([fe80::d341:6ff5:fce1:c6d]) by LV3PR11MB8531.namprd11.prod.outlook.com
 ([fe80::d341:6ff5:fce1:c6d%5]) with mapi id 15.20.9009.021; Mon, 11 Aug 2025
 08:33:33 +0000
Message-ID: <9afc76ad-bb5a-4114-8f20-5571a8bcb85d@windriver.com>
Date: Mon, 11 Aug 2025 16:33:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH 1/1] fetch2: try_mirrors(): Skip invalid
 local url
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
References: <cover.1754898959.git.liezhi.yang@windriver.com>
 <87f55606dfd70b12b5d7fe97ad889300a6884359.1754898959.git.liezhi.yang@windriver.com>
 <CANNYZj8920r0c1Po9ARajRpWazWw2KNFwFoLUcdNGjkke8EgQg@mail.gmail.com>
 <cbc5cc61-9aac-424a-83a4-f0bc1c21d1d8@windriver.com>
 <CANNYZj8cUAhA+j5t9Lc0UPELpbG8nx3UmbLyUy_Axrv9-AY+Rw@mail.gmail.com>
Content-Language: en-US
From: Robert Yang <liezhi.yang@windriver.com>
In-Reply-To: <CANNYZj8cUAhA+j5t9Lc0UPELpbG8nx3UmbLyUy_Axrv9-AY+Rw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:54::19) To LV3PR11MB8531.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8531:EE_|PH7PR11MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a67cb0a-1783-4fd8-a2f4-08ddd8b1c1db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RithcnNvNTVKbmtDWXdMNlVnSlo4K2tuQXpzckFPNDM1dU04YkYrSEV1bDRt?=
 =?utf-8?B?N0lwbFQ2N0wyNGoyVjJwbnJMM0M3VlBDU1JnTFNoVENvd0hBVnMycTBCL2Rq?=
 =?utf-8?B?V2VRR2hlWUZEUmN0YiszVDVtM1l4a0ozY2tVVHR4WlZ3Z1I0MjBQcWhHOFhm?=
 =?utf-8?B?bHJDWENUamhIaXRKRnpleXhRQnk0ZlV0UEV0VUNUNTlmaDB4SzNxTER6QktM?=
 =?utf-8?B?ZmRSL0JnMGdkU244SnhhU0taMGxTZGZ6MFFESVJHdi9XUklYMTJ5SEQ4cnh4?=
 =?utf-8?B?eDhOOTRiaisyUjFYWFg4YmdIYlFKWWF3WnBYUHVtYVZXNHJBS3F6SUpYU3JG?=
 =?utf-8?B?YkdmMk1hVzYvV0xmT2djRFZBekhPT2V1VHNYTGo4NHlsWjBlYzFKSlcyK3l5?=
 =?utf-8?B?QmlFcXJWTk5lbEdiTjdNbE1VUXY5b25ISHVYc3BVS3puTVVxRWNFVFRoOTlr?=
 =?utf-8?B?QitIcVpwSmVMa1JCUFZjWXhhc1J3amlyUkp2bjc3S1B6bkdWSzZSeEdGOU5U?=
 =?utf-8?B?MG5EZVF0WGpHMG0xdjNOMEZXMlpZcjM4eCtxOGJVaHBKb3FQRVVDSllSS0dD?=
 =?utf-8?B?M01TQlgxaU1Hd2I5ZEl0TjRpU2JiOXN4ZUNaRzF4T1FIOTVUYi9kVXJNdm9z?=
 =?utf-8?B?b3pJK0l0dnM3UG9WbktDL2lzbHBKL3B1SjFyVWlZbllKbmNjZXhjUi8vU2s4?=
 =?utf-8?B?ZWIrK3dUSWpnYXpPa3pSQ1l2MDVkSVBwazNkRXhwRllCZnZleXRlWHJ5WmVS?=
 =?utf-8?B?Q1I4NlNOZkhJNmw5TjVJdU5mczZXUWQ0NVhOcVdXM2hKS3B4ZkQ3NExQTTQ5?=
 =?utf-8?B?L1REMUtjU0JqWUNyODN6d1RnOFlLVWZpeDhtM1V3NVN3NWZNd2hKVEw0Yith?=
 =?utf-8?B?RS9mSVhlSktlY2VkeTYyL2hKdG5iZ21iTFBkUFRaS3lVZFJWb000RHl1VGpG?=
 =?utf-8?B?NTRDTHVZN0oyRnFTSERTVUJJU1ljQnpwemkyUEdOb0hUQTZvaWlkRzFZOHVD?=
 =?utf-8?B?bnJoNWNBMHRYVTdkTXFsTnV6aDdydCtQdTlFK1pDZnNEblNGTEJUK2JzNFdi?=
 =?utf-8?B?d08zMVRLWkRIN2wwMG1HZ2NhQkMzTmkvaFJUZ3M0bXFRYndnZGNkSTAwUUgv?=
 =?utf-8?B?RFJUbDQ3ZWhraVErWFNUbW1OOTRidEovQy92cmJnazZxSEh2NUJNZ2ZGdVpO?=
 =?utf-8?B?N1FyYjRqbmxRT1ZHV0daR2gxQ09SQW5JdStxVG9TcG5TdGdEWGZBWndBYkl3?=
 =?utf-8?B?NXlKV0VvMXNFNDJiOC9OTjRsQUhndFQxS3RQTzlranNML0dBWmtyeWNreEZh?=
 =?utf-8?B?d0dDbG8veDJoVCsyL2ErQkh4SUlKdlFzWnQ0ekFOSWFEbVNYdnEyaEVQM2tx?=
 =?utf-8?B?NTBEbWpWNXBoL0taSWkxaGNnS1RXOFNjTngxb0JVYlh2UHpXL2VsWWFHRWor?=
 =?utf-8?B?bmxhSjdlZnFET3VJOHNldmxhY0kwYkMrNyt6Q0NEdVFNRnNmMjNmc2xhckhI?=
 =?utf-8?B?SWlzY2paYUZDK2dvQW1TaU81YXdlT2tJZmFnQkwvRWMxcXB2dUZJOTE3dXMv?=
 =?utf-8?B?NVNDQy93czdHbGl5MlJLei81UUJta01hayt5YUl1S0JiTnkwM2YxYlhnYzVl?=
 =?utf-8?B?K1U2dVUyQk11dHUyeW5rL080VmNhRi9qalRkeUhOeUM0UWV0K3dqMnZHTGxn?=
 =?utf-8?B?ZjdnTkU5c0ZiU05wYys5RnNzV1EvTm0zZ1FyOFFCbk15Z1VhK2VlQ01jUG5F?=
 =?utf-8?B?MzhQN2xqVnFGTjZmOWl1MmJaUElERFBTQkdOcExEMERlUmxIVmdzRzQ1Q0xj?=
 =?utf-8?B?dnQ1MUY0K1BxVGtTUkFQNExjcmJpakQxVjR4Y3Z0bDY1MWQyNWdpdEJ6RGFi?=
 =?utf-8?B?bSs1VFJ4Vk9oODNOMnlGWWh4d1ZYcUxnTGhhYmk4RkQ2VzlsTjNPWTVBT0tU?=
 =?utf-8?Q?TQ+BRxT4QPU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8531.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NlQ0SFlCZktOMnYwT2IydXE2QlFWS3d2T1RmRnpwQVFUTW1sM1NWOWpFMlNS?=
 =?utf-8?B?aEFWRFl1VlFYZnlhNktXaG55WHA1VlZCODcrV1VtR2k2VWRFSlMxMGJ3ckI5?=
 =?utf-8?B?K2Z4bnIrM1pZWXErMm4xeGxBbnkvTjRpWXNiMm9BSUFONkRCVGtnSzUvQ1VQ?=
 =?utf-8?B?OFoyWlV1c0JkcWVZOXBUNmdiMklkaUl6L2kvM3M1TEJpaGlCZzhCNmk3eVRS?=
 =?utf-8?B?SjY4dDNadnpONzZYUmVsa0E1Q3lsZ3FuT3FuRVpzOWRlUDNlUGIvTnViRDlh?=
 =?utf-8?B?U09kUDVLMndJZ0h4dFd5TEZWWUhJSWNHRjNzUGFUYVhDbXdmcUZuc2JYY2xI?=
 =?utf-8?B?cGdhcDVheENGU0NyVlBoSTA0Wkk2MzJUcEpoOFhMWjVLZmFDQlRhTklJcUd5?=
 =?utf-8?B?NXBveERaN3ppMUU5MC9hbklYWjRoOW1ITi90VWZjcVFLeEc4eEJvWlRSbTZa?=
 =?utf-8?B?WGpXVjlIR3p4ZlVhSDdDd3QrVFlWcnVHOUFsNFluYnlVbmhQLzRIaFNvTnFQ?=
 =?utf-8?B?cHZaT1VzaG1RWTUzSStQWVowU01Td3ZoemZrelBwVWFnRWVjajgvUmgrSDhv?=
 =?utf-8?B?cTZqOFJoOCtzUTFGTVVHZDhzRUt2TEpnU1RQNm5DV1Q0UzkzUFZJaTEyM0NI?=
 =?utf-8?B?cUwyOEY2eXNQam9jMXp0WU1LSlhEeEhrcEdSd3A3alFwdk9aQmZlckp2Zjgw?=
 =?utf-8?B?NnVQTDI0V1lDVGY0V3BDdThaTmt2RnZ6R2VackRGbEh2Wko2S3JSdWRiMUJs?=
 =?utf-8?B?Qi9udWpoVVVRZ0VPN0s2RjZBQk5YRUdyV3lCc2Q5MVROdkxlT0k5UlFsNkw1?=
 =?utf-8?B?VmgwNFl0Y3JQUVZrK1Exc1gyZm4zWFVwNElINmVTNVJFVjBZQ3lFUWVsU0FQ?=
 =?utf-8?B?R2RvYUhONGxhL3B1Mm1GUEdIU2pDQUlXeGU3Y0h2ZEkrRjlRZU4xcU9MdDlB?=
 =?utf-8?B?cjVxTGp4cGRpZHFGYzk5OVd2ZTQycjQ1dzVKeHpOUDBZVnNOWHNPV0x1MzJh?=
 =?utf-8?B?WFBmVHMrOU1tVDZoeFlHYmdFWitiSGc0MnRYcSsyVWZCSHhyNnNYUTdPb2RD?=
 =?utf-8?B?STlZRHNQQ21Xa2tQSXlTYTRaZDFEL1ZOTHVVUmRNdEh3STRFdXg2WitRMms1?=
 =?utf-8?B?d0hLZ2dpWHRrSWdNR3pBU1JIbnhqeXJnYjU1MWZ0U2ZGUWRtWFE2cStZU2p6?=
 =?utf-8?B?eHVMS0tzWkZTZUszUFR3WmIzaU1NMndkTGMyUlFMT3lMS1Nrb2RQOTY4T1ZE?=
 =?utf-8?B?ZVBuY1NzcS9VUSttbW1EQWR3elBnZFRqNGJtbGp5Vmw2dDhPcSsyUkxhMVZl?=
 =?utf-8?B?LyswcUxpU2h1L0dkc2VWY2dnaHJQSmhORzlrbVZBKy9tUklXcVpuMVg2cVY0?=
 =?utf-8?B?ei9xbDcwcC9ObFFKbzJsbjY3dWttVXExUnFHQ094OVlxaU93MkJNU01XREFG?=
 =?utf-8?B?alp1VHkyTFNMbWwrSWdiUmpzVzJETXptZC9uTlBqOGczODU1Nzd3M3k2Qzdm?=
 =?utf-8?B?UytVVlM0RVZSOGpBaGpUR05FMjBZZjNNOFpONTE3dHJJRGxwNGVHMWtNN0Iv?=
 =?utf-8?B?ME1PajFVYnhrbjZJSW12OG5BVzFxOGVreTluZFd3SXg2ZDRRRWhmZEwweGFi?=
 =?utf-8?B?TEtLSFpOdVdZbVN6WGh0RkgvV0NGT0Vua0Z0V1VjTFhkYUdOSGRrK29ybi9o?=
 =?utf-8?B?TnIwRUtkd085Mmp4bUV4RU5VbGZ6L0JWVFBEZTFDdlMvaEk3YXNnMDhQMFdE?=
 =?utf-8?B?NU5NOUhNMWloOTVNb2xCdkhIMWNUbnRkVEE3OUZyMzlFR1dGWElhTE9odXBW?=
 =?utf-8?B?bDBTUWk3RGNRQTBzR2lkbzdEamd0NElRVXRXZzRYdzkxVWlHa1hXb0hMQTFF?=
 =?utf-8?B?ZVBTck1COW9ydG45S004ekoyK1V1dHlkRUVKaHh5STBBb0g3TXcyWWkxdEtU?=
 =?utf-8?B?WGYzSFBTR0ZBWFM5MDJ6NGo5cEpLcVdXZktLOXlZTHJtd2E2d2FBbzVmdU5X?=
 =?utf-8?B?aW42c0VnRnFzbUxLTE13QTZHSTl2VlRycHozb0FjeG5sNGZzVGN6R1JrdXd1?=
 =?utf-8?B?WFh2QndTb2pFa2dqT2ROVEhwWnJTVlNxamUyQ0JzQTA4eG1KdnZQNHdTVS9S?=
 =?utf-8?B?TjNwOWd2VU1BelA4K2JXbHFXN0U0UVU1R3Q0MTJzZHF5VVh4dVJ2dEUzcm5n?=
 =?utf-8?B?RFE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a67cb0a-1783-4fd8-a2f4-08ddd8b1c1db
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8531.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 08:33:33.2684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kOD8nWQ9GQKpNiIFXtcZ6xIESDkVfagtKq73p9JxFy8e/R5x/1RobvxcBnoHBdMrsqty695KvhTvYN80knhoG20TQCZt98zkh7/+u4q+kVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6650
X-Proofpoint-ORIG-GUID: vg79ViraN6DtRE-RjW8TLaYxMe4aSMZ3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA1NiBTYWx0ZWRfX122vGwK8Bf/9
 8vRu1Vy1EgEFbGC9PswsONLNQRIuOgnoiC10ysVuqHL4u8Qxvl2BiTAuFudYBgS2ur+MfbKRWBj
 RZYiIL1VS3vFq7EAloE3tsiboJwacQ1Wpt/aDyrwQnGR33HJN6tyLxz/L/62B6hMNFHllwUypRC
 CZwo0S7nwkzOCBeUPo/AvM9hJXUdQfsjb6mNpJlTi9NM17KloCDzx504bbenf97tb8uEBlI7QiG
 qC3qCs1rIMuId2CEfV6rRE7JATpiBElrwmJd0wtzR9ifv24Fnst8N4INTDmP8wuQb+Zex5UWny3
 0WsA4vAAzrvu2V8qNM4SxZ+1tnrWuYdn226ttJMDjHPmkcEXZwUxLxou+wwOeM=
X-Authority-Analysis: v=2.4 cv=ZKTXmW7b c=1 sm=1 tr=0 ts=6899aadf cx=c_pps
 a=0de+TxTBwdPc9w0nPmKirg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=t7CeM3EgAAAA:8
 a=ga1skk_rgAw8-HTfECMA:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: BCZBgTlCA9NzFAjJdo5Gw_mA_Km3i9QG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2507300000 definitions=firstrun
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 11 Aug 2025 08:33:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17858



On 8/11/25 16:26, Alexander Kanavin wrote:
> On Mon, 11 Aug 2025 at 10:19, Robert Yang <liezhi.yang@windriver.com> wrote:
>>> Can you please explain the use case? I'd think failing is the correct
>>> action, so that the invalid url can be removed from configuration.
>>
>> There can be multiple PREMIRRORs each PREMIRROR conatains specifics sources
>> for each layer, each recipe will try the PREMIRRORs one
>> by one until succeed, but the trying would be failed if the PREMIRROR
>> doesn't contain the required sources, so return it immediately to make
>> log.do_fetch clean.
> 
> But why is it specific to file protocol then? If the item doesn't
> exist on some remote server, there would be the same issue?

Yes, they same issues to other protocols, but there isn't an easy way to check 
that for other protocols, so we have to let the code go on for other protocols.

// Robert

> 
> Alex


