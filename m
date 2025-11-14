Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB4FCDE01A
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 07:12:37 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12707.1763104346314005774
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Nov 2025 23:12:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=UbDD1OOx;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=3413a291a4=qi.chen@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AE5KmoI1972404
	for <bitbake-devel@lists.openembedded.org>; Thu, 13 Nov 2025 23:12:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=vCmfgiRxBC5AZsKVaSbUcrknYUzlLtq0OwFgPbXvfmU=; b=
	UbDD1OOxVw8/FcbMsxha9o3JJQzdBff8IUUhNq2ffroq6miSSYUPMuHiCdBU/gmt
	s4eH1HB61a0+z7xXYiQDuAtrIt9K1SBvAcTiozL3mJhpbaKqXeYcQ2IYIZIPP3Ay
	JxNzPnbfQ8yEftKDudlgzBQyqhSs9dxY2HUhg2XI8xqmmguBVQjNBT8ayQk1KhNr
	fyB6rzwg3FXYJF4QNksGiw1hFfA/09iOGCIX89BUgK/0XJKuY+M+hR58CmgVXoNj
	CXamdIYazNvz8JmofqGzBNlTEtEkSotxB3X90wbwgaaftM9J1Yo/S175dgQKEPl1
	x4Ep7pJiuRI2G1R1UlGCWQ==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010055.outbound.protection.outlook.com [52.101.201.55])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4adtk6r7sj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 23:12:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O9orKM6hibgXF1wN8sZRV79gSRVVlqJoFm1ys+tTqd6yMD2WDTA0VYtKBHMppNsk2BhMIVqvEYfANGyUyVGVu8yxMq0MNXaazl5wbN2QilqgIADC1ugupCWGl8e7rgWLZg1OapdF8GiUpZjs1TVikiCcj5ATkZJiWRYxcCDmHzNVn9MBAB5pCp9UMeT8Yum20XHa4+isTVMyHfz9r617Jga+NwV0/b6OJKVWDX4a5Dv9pYku20rirEP6wHYHd9iTjAk+pmqrkF4DV9MZ7FKvYIQGv23x8xUt8xB/RZvjRnuqA9B4HY7TIDVLPTwFVRjcmSnasiS8T4IaHEGWlpjbNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCmfgiRxBC5AZsKVaSbUcrknYUzlLtq0OwFgPbXvfmU=;
 b=P72zeH+n9ClMl2eXrJ6IK83YWr3LST6j9c1mEfhHH5EWcwdw3Fy0IQUBOUVQt7UF5NNFc1ALoyH3Qz4Q7inTiU4cocIer2iyxdlSl3auiNU5xhzvFEuxunuLm4vcTL8NkAiXnfwKD37A25yfbLbRryE4N8JXLAuI2MBx2QApjL6LpTt+pLwSVcoqf7oATjcdLxD/umaD+kWdo9Gpvu382RXl8zFI4P3PKx4F2Rg0r43K6Fj6ev6YPrVOfVaKR/98G8kdXOM83oV5w56bEp7D8Dqlb2d+rtcVIiyKHiiwiSTSFzucCgXziJGS9hvPb+iCFpjqXIQ36baddkH5Y/haTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by CY5PR11MB6188.namprd11.prod.outlook.com (2603:10b6:930:24::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Fri, 14 Nov
 2025 07:12:22 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 07:12:22 +0000
Message-ID: <451e3958-7661-4070-bff9-b3bce661c21d@windriver.com>
Date: Fri, 14 Nov 2025 15:12:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel][PATCH V2] lib/bb/parse/ast.py: error out for
 internal fragment in case of a previous value
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, richard.purdie@linuxfoundation.org
References: <20251114060211.1742728-1-Qi.Chen@windriver.com>
 <CANNYZj_J6oJOpdYsX7Rnz8ViL4==q4ktLhfx5MZHQNe1s9SF-g@mail.gmail.com>
 <a0e64b88-cb5b-4dcc-8b6f-147765f373e0@windriver.com>
 <CANNYZj8tDk8izGO2f_8ADHsaN9VudG_hsQrcw2N2O8NnXtdCCQ@mail.gmail.com>
 <5fffd119-5b6c-462d-9f1e-5b2b30f81715@windriver.com>
 <CANNYZj8eqw8QF8eWCoLki7XXWZ197pVZHckLtQ5aQx29aU+o4A@mail.gmail.com>
Content-Language: en-US
From: ChenQi <Qi.Chen@windriver.com>
In-Reply-To: <CANNYZj8eqw8QF8eWCoLki7XXWZ197pVZHckLtQ5aQx29aU+o4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::18) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|CY5PR11MB6188:EE_
X-MS-Office365-Filtering-Correlation-Id: a6257f19-08af-45f7-7a51-08de234d27ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?N1JVNXhPYkh2c0ZMSEdHWjZjK1FtTFp0bmpNVmRIZkZIRFF1RkxIZW5peVNa?=
 =?utf-8?B?YTE0Q01xbHdzV2tmQmRIbVFYUFBJVEN0UFVVbFBGZ1lEekIrb2dXamJxS3BR?=
 =?utf-8?B?Wm54ZFZrKzZhamVIMUJCeGl3VjA0Rll1dDZ3UndvS1JqUEFQbnVpRWZVZFJk?=
 =?utf-8?B?Ris1V0dIb3duck1KTkRTdWRaTS8xSHZqTENvY203cXd2ZThYcVlCMFF2QjRI?=
 =?utf-8?B?SFlUSUJzNnRUN2V0bzA2NUtZZThXRmRmdUxDTUpnQUgwQXppUzRWWVF4Vk1F?=
 =?utf-8?B?V0NhSVI0aTRSWnFKdWJvajh1NXFES04yMVhPVHA3VWJVK2dBODgxeGJBRkhC?=
 =?utf-8?B?TGZhOEt3VlVGNExRVFZsdVhtaFhIcXQ3V25ib2dMMnF5S3NYLzUvdmx6dnUy?=
 =?utf-8?B?am8zZGQ4UDZJWURBV0lONHBTMnFaNHhOdGs1aHJVeVJ6bndmemxaZHcvSUhY?=
 =?utf-8?B?VEgzeU52R1k3S1lDUzd3alVDWGRrV2hmZFBwZ2ppZFgwOVdHUEVBZXNUQmtF?=
 =?utf-8?B?WUN6VWVMdHBjUVhMUFZkSkRnZU44K2VyZDF3eCtKbHRDU2doVDF0dHN3UzYz?=
 =?utf-8?B?dktVeWV1My81TXptYjNqNzFnQWJhdnNJVGtoZzVLL2dlOFZ6eERTQ0RFd0tD?=
 =?utf-8?B?V0tCN2hXbWZTQTFRWW1IVHFDZndNMmRpRDFIelpYMFV4SS9yMnJnSFFnQlBy?=
 =?utf-8?B?WDJPL3IrTm5Bd3ArYjZVdWlDZ3hNTDQxd3poSVlOOUk3RmZHUHlSWUw3eTBM?=
 =?utf-8?B?aVgwU0dJSVNXN2d6ekdzSSsybTY0NWxhZG5TM0JkWkw3VjY3eGxsZWVQMitr?=
 =?utf-8?B?WTUvcXp6K2J0TDBGejJvYVdtbjdCdDBHSXJHNUgxWXU2UExkVDh1bGNCRHQz?=
 =?utf-8?B?ZGZxeFJkSUZ3ZHBPSVgzZkhkTzhWTURHZ04rdGdCRGIxUGdabnBhK1dNSmJv?=
 =?utf-8?B?bGovTG1jZUhoRzMvNGUvSTA5UVg4ZllvVDhibVdXS2x4WWIrV01NYi9nbmty?=
 =?utf-8?B?RUt5eVlUVmNiUmJwR0xtVFErbHY0RHVvNjl3bE9pYlNDa2VKZUVLVEhzMGxN?=
 =?utf-8?B?cWFvSzdXaXBrT28zMXJGR2tVOU8vT1pOUHROZFp2TzV5bWtUZ0FGcU5mQ1A2?=
 =?utf-8?B?RTdRNXdkU2FMNkFpNEdrSXIxbU9WQ09uTXFXdEl1NHJlWDF3VGlnQTdWbWF3?=
 =?utf-8?B?U29NaFhhcE9HSWtZL2F0Zm9hQ0c2YmEzY3drSjJ2NXcxcTFiYkZyQnlRR0J2?=
 =?utf-8?B?UmxBVm1WZmN2YW9VZWhFTlN6TXNNc1gzZjN4a1RCQmhHbUdjYTg4aVVFdFJj?=
 =?utf-8?B?aWxpbytHVnhOSFJaZW9iaUo2bmVzbk44NzZFOTJycXMrcjhuSlRmRTRoOVF6?=
 =?utf-8?B?eFYzK0tTcVRvNWtxU2JnOUY5SDVNUHRiOFQzSkJPbCs1TmJXVkZxSmx4ZUEw?=
 =?utf-8?B?Y0MxL0s3eTN3cXlTUkdVQ1o0ZnNiOW8zaUpUQlRSa1FZRDFuazB5WHc1cTBD?=
 =?utf-8?B?UmE4SkZTcktzL0FWLzZBQW9Wa1A3SjNJRTVpbjNXOGJmaFgxNGZRUEw5ZEp1?=
 =?utf-8?B?NnFlOFVYdGloTjc2cUJBeWpZWVhuOGVkcUlXTnRKdlBZUnA5RDZGUlJkRHZS?=
 =?utf-8?B?a2t4UnpocnFzOUlmbFVkUXd3OThGT3lxSTRaZDRjYWxLbXdFZWJPVGdic2Js?=
 =?utf-8?B?MGZFbFBpUDhwMWZZWk90OGpPOWpEYkhwcDg2Wk5TSG9IWTNPSldhRmp0Y0pF?=
 =?utf-8?B?MGh6WHZYc0xZclQ2UlZ2R0dObEI0R1k0TFFFbW1tcTEwWnhib3NvN05QNzdw?=
 =?utf-8?B?S2FaTEVSSTN0cmErcDVMVFVTYTdWSmw3V05xYzlKTVZmdnUvSTlUOWpyQVRS?=
 =?utf-8?B?YTdsRk93TGtIR3lPYmVRWXJJLzZxdWtOaHFTZjY2VmEzdkJrYTlHeFNtOHI5?=
 =?utf-8?Q?sdZ8bpK6GZZi0hMmMaWWW54lPWvj6i7A?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c1Z2M2pLTDNRZUUzKzVmNVlQQTR6L01xdkdTbnB0U2NzcmZVTTRLZjhNMllm?=
 =?utf-8?B?UWFIVWM4Vkp0aUJjWmt3VThvRHEzRHp0VlgxNC82MldSUlpTOWxyTG9NRXBL?=
 =?utf-8?B?Y3QveGplR0dtNDFGbG5TZHdocWJUQXhoYTJPL2VKMnJhQ3JiN1EvN2EraGJW?=
 =?utf-8?B?SGJSQU1DaHJ6cFA5TGdtd0w1SmFNanNZZURYS0tUMXRPaHk2bTB5VUs0aG9Q?=
 =?utf-8?B?dDB6RUt3V1NrRGVTNDJhTUxUNC9LWE40WGNBUzh5RjNta1RiRkJNZ09NM1py?=
 =?utf-8?B?Q1g2SkNkV1BxcEhtckR2dDFoSDIrMmMvcVBpbCt4TWpicjJFU080N0ZKem9D?=
 =?utf-8?B?bEpRU1Bod1JPZEIrN2g5bUxQNCtCWTRZVzA3V2RLelZKTDJnR2lBamNoZURS?=
 =?utf-8?B?ZnBOQk1BZCtVc21FalR6RHpNbW02TnlSQSt2VldHYjRabldLOHVDS0RjOUUw?=
 =?utf-8?B?UW1Rc2xYc2U2WlA4VE9yMGNQZldmSXRYVHFEbkhLM2FzN1pPSlJTVkp0MnVV?=
 =?utf-8?B?U2lDLzhUakZJUnJtZmtRVXhSTTh2QVZyL2RJSFo5NWpMbmppTkdtNjNyazEx?=
 =?utf-8?B?d0ttck5DZXJyMnBpVk81d2gwN1ZkaTRlbkdSN1JtZFVmaGRhaXdnNyszTHh2?=
 =?utf-8?B?ZVI2ZnZubDFmRWZIb2tTODgvTVhIMjNhb2p5bm1oVXViODRtakpKK2ZLOWFQ?=
 =?utf-8?B?UGRORElPcGlXeUM5SjRGVnpadE53dFJSR1dBTDZBOUltZE1PY1VxWWFnclJE?=
 =?utf-8?B?RkpSVnJ0WVlZVXIzclZESUs4dHUzM2laOCtkU2tZTkNKbGpNQTVIWjQ2T1dt?=
 =?utf-8?B?RmlMK1RoKzhRUlF4eUEzVjFXQXNXOVlaMUxyTnBFQ3JLMkhWN05DSE01N3lU?=
 =?utf-8?B?c1RIbEZKT2dzdGFodFJkb3VYNmxjd1c3VHl2Z3FxSFhxU1ZXcEcvd3p4eVcv?=
 =?utf-8?B?L2JUUVF3TUVhOWRJWWVMTWhIeVhHSWF5c3UrWGZYc2pLMjc2ZkRJa3NCemVO?=
 =?utf-8?B?YUd3NE5CUWtIS3k0ZzFmMHJZWnY3NGFFOUt0S21aQWpRc3A2U0w5cGozbVBh?=
 =?utf-8?B?eWJiNkJBOS8xSDRYek1vUmlTT1RveStsRm1wanFoOEJUZ09nRkRzWHhqS2dx?=
 =?utf-8?B?L3FiSGNoaDF3S1BvZU9OQlpZRnhZZ29qR2oxcGVoaWVGd0VMenA0TTQ4bW9K?=
 =?utf-8?B?SDJZTlkxeW5JUmo2K284bklpTHVUeTFwUlZiSElkZlFzVnhxSStCeHNsOGhw?=
 =?utf-8?B?aG1IMVY5dWw5eXpBbXQxdktaVE5xZHFaaktQRG4xM0daSXBhKzVZUlEzSVFw?=
 =?utf-8?B?RGwvMFN0TEREaEIvQU9KekRnN3hjUXNzb2U3a2lqaVhOTmZUNVZ6YUtkcG1i?=
 =?utf-8?B?ZDUrdE1CTzhTY083QitkRU5mbStESjdabzA2c2JSaUd4T1NKeGRHM09KY3BW?=
 =?utf-8?B?dkUzamc4MkIxVzRIMXhPVUVZOWxqUnFWNWtudG5YRWlDMEE3Z0Y2WllhMFBD?=
 =?utf-8?B?NlpMT3pYZkNsa2N4YzVmdFRDNVZvY21veHFCTUhNK0hxYk9rbUxnY3J5c1dr?=
 =?utf-8?B?dDVDV3hjYVJUZS94Znh0cGliTFlIQXNQbEVTOExyRUhFOGVFcURFcDNTS011?=
 =?utf-8?B?NHE4RTFsRkJFSTdiM3NSZG1UelVCZENZTTVOd1ZsM0JQc3pFM0hWSFZtWjRo?=
 =?utf-8?B?YitCVE1scy9uVjM4N2xYSWdYODF2TEM2bGZsT0xld21KS3hDbVJsWG9OeW5D?=
 =?utf-8?B?dW14WkxvVnNoOHNxcVh6dVkyUWR0SHJEYlVhWVZJVTJPT2orT2piMlZNMUZm?=
 =?utf-8?B?d2V6Tng4Z1cxY2NCWCtsNHRPNG9kcUdDZGVVSVRXYmZ1UkdtMnVXQ2MwczFl?=
 =?utf-8?B?dk5UcHZzc1Q1Zmo5QU9XK0s2dDhkcmRzWEtXNjh5cTZvRVFNSG1sK2Y0REsx?=
 =?utf-8?B?c1YrRElnenRhU1gza0FnV09CVlZ1eUxacEZIdi8zQVp3dHZZTVU2MERtZEQw?=
 =?utf-8?B?SFdIY2NaU2JQU013aUxrRk0rUjVLRmUzNlJiUDA3QzhIa3M1eXpTdWR1TUtu?=
 =?utf-8?B?eEI2eFJyWm9oTktuMUJjMEZ4b2lTMUpLeFlYOVRlcERtNXFNTGk4SmVuay9y?=
 =?utf-8?Q?Tmhs2B4qKuWqdQOOnOM7hWReN?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6257f19-08af-45f7-7a51-08de234d27ba
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 07:12:22.2052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6fIjY/1y533TAjqtglnzbvxCQbnFDt0VdLumwMG85WRmJDv/VuovQMfYeElvJjFKkGDzY7Ush7FZQJ9Xcr/H1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6188
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDA1NSBTYWx0ZWRfX+TdovI+KdfoU
 7AOWX5j+kXHaMNjxM0GpDmySnKf2Vsbr2sZrcv7F/WWD3rxUEm81KXs/SAJUjtHK7OvUGJGPZl/
 KLwPO0fbt0DmYkewCln6+oNbP+BYxyD7HsBeI62WcU3ugfgqbqrTRD9QNVbeZczi3ZTj5h7+uto
 f0fTTs9O23V/zmybgRe8Em6uJDDBkInd14C0F2Kiqw4Bobw6wbbUvSp9EsQ/kA0LNhBcbVXyCw4
 6Hu2scFoK/vM7SpR9Tw4iNiyfbxU5z/6TpJTz3hHGfE+85vh7NiIPyPwbrp39JHdmKbIfkfc6Dy
 mVz22+BLhwxAuw3MsVVOEaeRnYT5u16k8PNcxi5UrkoBSncfQPpB0lj4JokQmGIO5Nqwr94KtHS
 wxAzHMgyGv3FKLahkwJbzYG/cG6Nhw==
X-Proofpoint-GUID: Tr2CadDnle5D7Fgf_tW9l65yCWBsfzEt
X-Proofpoint-ORIG-GUID: Tqmi3RgUVytcTTgWbEeZilIfylJ0Xktg
X-Authority-Analysis: v=2.4 cv=YsQChoYX c=1 sm=1 tr=0 ts=6916d659 cx=c_pps
 a=N2nRAhBkfDZD2w7gbJJ07Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=HvlrrJGs30CXpD3u:21 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=t7CeM3EgAAAA:8 a=-eCjDD7knEqJ93ijI40A:9
 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_01,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511140055
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 07:12:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18387

On 11/14/25 14:49, Alexander Kanavin wrote:
> On Fri, 14 Nov 2025 at 07:37, ChenQi <Qi.Chen@windriver.com> wrote:
>> When machine/qemux86-64 fragment is enabled and users use 'MACHINE=xxx
>> bitbake <pkg>', the expected behavior is to error out and recommend user
>> to use 'bitbake-config-build disable-fragment'.
>>
>> Here comes the problem. bitbake-config-build makes use of tinfoil and
>> when setting up tinfoil, the above error will appear again. We can't
>> recommend users to use 'bitbake-config-build disable-fragment' while the
>> recommended method still errors out. This is the reason for the special
>> exception.
> But why would users be running 'MACHINE=xxx bitbake-config-build
> disable-fragment ...' ? That prefix is intended only for bitbake
> invocations.
>
> Alex

I mean that users run something like 'MACHINE=qemuarm64 bitbake 
base-files', and they get error like below:

ERROR: A builtin fragment 'machine/qemux86-64' is used while MACHINE has 
already got an assignment.
Please either disable the fragment or remove the value assignment.
To disable the fragment, use 'bitbake-config-build disable-fragment 
machine/qemux86-64'.

Now they run 'bitbake-config-build disable-fragment machine/qemux86-64' 
as recommended. If there's no such special exception, they will get the 
same error again. Even if they run a simple 'bitbake-config-build 
--help', they'll get the same error again.

That's the reason for this special exception.

Regards,
Qi


