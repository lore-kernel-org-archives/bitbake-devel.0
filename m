Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A566CDE006
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 06:37:57 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12233.1763102268957352140
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Nov 2025 22:37:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=g9BNgHOM;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=3413a291a4=qi.chen@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AE38Pal216188
	for <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 06:37:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=Vq3ogm5L+QMvcME/NGpoKrSC+5P+pQzhEaXgM49WhjM=; b=
	g9BNgHOMJ9JkFxXctUhklLPgMBn/NRg5e82ReuwA194TjVS+ozWm+ahKNt4Og/2n
	f1sLaHGuUOPfBNIU2vMOt0IFRvQqe4v0hv72MM4t5Lr18IEE1eaHavNez1tuvrb2
	IGswww5OncST18ASefsl9752jhH4AeTj7ZJLeDEBaMY7VpYf/racRFcdFPP1LS9K
	rsMT2j9YHcMsWL4l/rvV2sTncJT2hvnBj+4xqL1WQhjdxEwU5J/qR2SbVhB2HWy5
	Pq7w9E16GHI/LIiHGUDZ+b2fG3jhICJpYUrI2V/I6JJsK6qAOTNP+vvHPILEcIck
	u3teQcauVgdfXPhuSIS4mw==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011016.outbound.protection.outlook.com [40.107.208.16])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4adtr5g6wx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 14 Nov 2025 06:37:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/5hV+HEdjnQ9NTOfb3SR+o/UNJpWwe/1D9UcXF6ikjxjSthzMuyD6WImEDZoJ5a9QJxwmvWiPYZFSPjj0NlFj4GmkH+RrV8Lx5oGHLjiBhiRxwmah+61FvP1jr6MvS7yuBcde0mrHsoHN8Ne6ZmqCCSD2bUK1uUjSZwkM+xgCrY9yF/QkEFzKlOEiPVDVyytfBCBXdch3hMcSEJE9AKTmiw4M36bJ49l0p0lyDm8HRqY0kEgU1MvfwO8yX1CD3IdxdO3oJwk8ASzXMYygB4sQCmrVKh37bJ+Hd/uLcSiNwgcRuvziVedJN1Zg8dPDTzrHx4yIzRUpNPTHUeyodYUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vq3ogm5L+QMvcME/NGpoKrSC+5P+pQzhEaXgM49WhjM=;
 b=Va9rnpAM8GSZrdhl6Ujd2uR+0UoRqJXIWVgXpY4uMDNe8wfSMieE9qRvXQUVsSebxEXbEpsQQxaHLmY/SpBLTwVWkCv9y7j4lv7PQnzUGv8dclaQAzueSL3FmPIa86pxKatqrTxSFj+TlLpzNOVct0ykmTh7a9LoqeUCrob+06pB8RCcnk5qC7OOGUcygLQ9L+PphFq1F1/Jv6wGMw+Th3GEu7SDIZUrLOFxGGvZV0Shx/Uv2TCQx6PHarKvUlo5DqOR/XzfktSOIEMr01rQhuGY9KF2MU1uyNSAF6zycVg8lR0rk4tnBlTbTQJW8Tn0TtA2Zdv4RK4gzqZSKW90vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by CO1PR11MB5009.namprd11.prod.outlook.com (2603:10b6:303:9e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 06:37:44 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 06:37:44 +0000
Message-ID: <5fffd119-5b6c-462d-9f1e-5b2b30f81715@windriver.com>
Date: Fri, 14 Nov 2025 14:37:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel][PATCH V2] lib/bb/parse/ast.py: error out for
 internal fragment in case of a previous value
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, richard.purdie@linuxfoundation.org
References: <20251114060211.1742728-1-Qi.Chen@windriver.com>
 <CANNYZj_J6oJOpdYsX7Rnz8ViL4==q4ktLhfx5MZHQNe1s9SF-g@mail.gmail.com>
 <a0e64b88-cb5b-4dcc-8b6f-147765f373e0@windriver.com>
 <CANNYZj8tDk8izGO2f_8ADHsaN9VudG_hsQrcw2N2O8NnXtdCCQ@mail.gmail.com>
Content-Language: en-US
From: ChenQi <Qi.Chen@windriver.com>
In-Reply-To: <CANNYZj8tDk8izGO2f_8ADHsaN9VudG_hsQrcw2N2O8NnXtdCCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0114.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::12) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|CO1PR11MB5009:EE_
X-MS-Office365-Filtering-Correlation-Id: d70e362d-1a05-4de2-193c-08de2348515f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UlVDelZxL2R3ODJwZ1piQ1JZZnhzTzJxb0hoMkFia0xJazFGeGVPOU0xVExt?=
 =?utf-8?B?TWNJMzI5YnFETjU4dkMrK3RzN25IVkh1enZwZ1JJMHhqd3A5OVhoYTM0Rnlj?=
 =?utf-8?B?OExqbEZsTEZ0bkRscm5HUWVpQy9HTzgyZUlvSXRCSW02U29IZllOTkNyT1hS?=
 =?utf-8?B?bVdWNzZKelB2b0NBeVN2WVFBUWhhQ0FGOW5oOHpMODVWc3hjOWpIMmZpREVD?=
 =?utf-8?B?dklTVExsbGxqSjRwbFdINW5zN2ZhVWNXRkFjenhRVHBSUEE5akhDNmx3cEg0?=
 =?utf-8?B?c2FIOGVWYmp5Q2tzUFk5VUpkdXRmdFZ5ZmpoMDh2dnVMemJ4TDJSYmRHckt2?=
 =?utf-8?B?R3JPL3RwZDZqbzhNeVhmYWhxMGJ0QTBVSHhpTENCb3haNURZMVdBQmxIZ0pz?=
 =?utf-8?B?M0h1KzFQbEYwc1QxMWdUMU5sQ0ZTVFZwZ3dZZWpKcnNrdVU1Y2xGNjgzYXRO?=
 =?utf-8?B?dnFmVjBvL3ErQUdTTWEwQlhyd1A5K3VWdENuQ2xPNURnTGlydDMrMnhZeGlY?=
 =?utf-8?B?eFZ5bGZWanBhbEdDVk1XYVluckRiL2M5dHhUTWcxN1dVNDUxU1hZT1Bibk9t?=
 =?utf-8?B?bzBmaGtFclBnaDBNMjV6dWNHYzh0djVnTmMzU1ZoTVorYmdJbFA3TUNDc1V0?=
 =?utf-8?B?eEJ0d0VzZ294cks1WHR4eUtYUEUzK1VGVjhKbkJPNk1QZkJkNnZjYlBrT1hU?=
 =?utf-8?B?c0FZQWZrYy8va1ZYbjQ4cWVHNWU4TE1IYjFSazJiWElFZTF4My8ycUc3WFor?=
 =?utf-8?B?R08wRC9qb0FsWitLdUtHOU1HY2Z6OC8rTGxWdUdycWxLRitqcTdIUkc4NEVk?=
 =?utf-8?B?Q2o2S1RDVTNEZTVDQVNNeS9qOXZGOThacDJNYVhtM1F5L0p3VEhhd1BHUGYz?=
 =?utf-8?B?Ty9rc1ErTWNUdTRUS2xIdDVYS0t5WDdDWDVHRGFjeGVnMEpkdVZSU1pPS1Vy?=
 =?utf-8?B?YWdxTGFLbXcwNXFta05aOVBwaFNSdWZndldHT0krZWxjdlozWVNqNVNNaXNu?=
 =?utf-8?B?UXMwaW9ZM1FzcXhVblUrRFd4ZjFPU3FMWVkrWTlKaHVpS2sxUkpjcGhiRHFT?=
 =?utf-8?B?ZUovb1J5T1cwWHZqSFNKN2JvbHVtUWdWZ0xtdi9kTS9STWhBS2dEVWVBUS82?=
 =?utf-8?B?N004M1ZKRmpoc2ZXeHhVWnRYSnN5RGhucGNDWnZVdTlKMXlzUVpVSVhtdXZG?=
 =?utf-8?B?cWYrTENQcTRNS0MzdHpvN1IwYXErVHlkUGgzYTk2Q0MvSHZIaWN0L0FxL0xr?=
 =?utf-8?B?WnRzY1VSSnNteXphRjlqREIwR1kwdzQ2UUxYbkdYZHJwT0RXT1dTaVJQcFUx?=
 =?utf-8?B?U0dHR3lSandCelVMUlMvOVhKLzlGcE1JcW5NRngvemx0bnNpd3hBTXFnSHF5?=
 =?utf-8?B?cVRhMmdhdGJta0dRVDRaYThTUDNxeFY0SWhyMVJyY3hieEpuMVh5aUl0Qzg4?=
 =?utf-8?B?Y0lad0ljdmVnaW1YK3ZtRlNCRkk1dFlCeUpEaWFvb25HR0NIdFh4MVJQTk5O?=
 =?utf-8?B?TVE2UmpQMHgrZVdZbmM4M1dNVVVQc05OZEtocEN2Y0lsSE53RmhVQ2dFQnhE?=
 =?utf-8?B?aHdnOGZ3elJBZ2hMMFQyUVd4Q1N3dGw1aklNMGtRRll0M0dWbDJFUmhVZlJ1?=
 =?utf-8?B?NnRXNVgyL01TVW1hUDBNQ29leTdKU0o3a0p6VmJPa0xhMXQwYTY4b0pBR0hJ?=
 =?utf-8?B?VldWWjNRUXFVYUNWajZ5VFd1NVNhcEZtZjA5L2xMeXBjV2FOLzBCUWpGcXcy?=
 =?utf-8?B?L0F2b3g4R0QyY1F3S2oza0pUcGFLbG82TE82cGhnVm9hcEY1b2l3a2V5K0lH?=
 =?utf-8?B?Yno0bkZ6ZWhZYVRscllYZmJMUm4vNG9rbVFTblUzbTVwVXNiWDk3VlpmY284?=
 =?utf-8?B?L3dmNWpJaTluUWtEQWZybWt1eXpNbHFFOU1tc3FvSUxrQU1PdUVWVXdtSml0?=
 =?utf-8?Q?IWrjYauiZhekW4xfDaQ7Lt9z6me0P2Ls?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MHpGLzdwWG5PaTlTb3A5dkgxdnlxaFpVcUUzdEtXS3UrV2NtTzV2Y2hMck1r?=
 =?utf-8?B?Si9uNy9ZWk5HbVhzVXVGaXRJZDd3Smt2TVc1TGViUmM4ZUZzTFZCYmNIb0tP?=
 =?utf-8?B?YzRXNmVxL25MZmlzWmVSdEZ1azFVSEVQZmF2elRQSnNFOEZpU3p4a3BFNHl5?=
 =?utf-8?B?czJPa3U0UC9BM09vTi9HRW5tTW81LzFudjFSWTZ0elcrWHZMTXI3Mnl4NXFV?=
 =?utf-8?B?Y1hFYThNTERsK1IrV1AwOXN1SWtqZzI3WlpRTXdxYkZac3BkSFpSRXRtQk54?=
 =?utf-8?B?Z1lUYkdqNFNLaXB2V2ZIaWxwbG5OeHF2OVRNTW14aGtxdmZlRFFVd0dvaVBS?=
 =?utf-8?B?M0RhaElrc3drMVBwSUxrU0NRTitlQXBlcDJOMHVjcnlpWXVqL0tNc3o3ZWo4?=
 =?utf-8?B?VVhzd2VFbWFKaWc0QVJPbnVIcUJvSmF2UnYvVnRmMFFBTkRCcUs4SktsNHlV?=
 =?utf-8?B?TkZmM2FmTUVHeUVyZjdIQjNsNW9laHFyekM1Yjk4RW9GdWJxMHJtYVRBc2dk?=
 =?utf-8?B?d2dpWEdKdDhtVWZ6MUk3ZmVGczNUYmZxdW1iSm5lQmJybURNc1FKakMrTGhz?=
 =?utf-8?B?RG9lYzZza0FDRUtpcW1zVzFHN0lHWVQzUWFQNTI4cXQvRXA2QlkrdnRBZUkw?=
 =?utf-8?B?ZElPOTdxY3NrS3RJTVNZdVhXbzRndFAyaG11MXNaeXVZNStHWnJxeGFIWHM0?=
 =?utf-8?B?NEFjR0J5VHFzeGxkcHc1cHhaTXZTaWJBL1lYbmVkS1FjeUNObXhHbitLNDhj?=
 =?utf-8?B?cXhQaVhETENyM1c0VEpmY3lkYUx2dE51UjcvTThnQVBIT1JTT1FsWkxuTllM?=
 =?utf-8?B?Y3BjMFk4U0hLbFB3bi9aTXhlOUdJekEvMWFqK3dRT0dubEM1ZUFyUDZsUWNK?=
 =?utf-8?B?OS9FemR1QVJWckdOR2ZyNEMzVjVZNFNWNzgyb3ArSXdsbDZIM25iak55czlK?=
 =?utf-8?B?SEZYcjZDQjJNejNOcjlNaFhHdUdVcWNSa3FzWDRrY1hNY1lQcFpoamdva0RX?=
 =?utf-8?B?eFV6SWJZVk5UOXZLYmJqQmhzOHMyU1VWQ2sxR3g0UmNzMnA4SkdUSStvTzVv?=
 =?utf-8?B?dWNMMXhlTk9jNURRa2RvTHp2cW1ubEFBWjU4and1S0tMK0NncUU0NDY1VUF5?=
 =?utf-8?B?dmk3RXk3cXowbEFJYmYwS29kV3ZHaDNYQWpFc3dUeW1PK1lUOVdUdmx0amZD?=
 =?utf-8?B?MGE4S0tzdW1DZnZLaXR0bkt2aDlpUTdoWVhXb1ZsVjh6V1l6UGlyM0t6SS9w?=
 =?utf-8?B?dVN1eW1oUDN5YW1hWHBhTUJxS2IzTmt6VFF6MkphNWw1UzdOTy9oNnBPV01x?=
 =?utf-8?B?TU5ESTJQNmtuWDN3SHBMTXgxbkZXSlZ0OWV6MENNZ0J1NUlvYzRUZ1pGK0hy?=
 =?utf-8?B?YndUbTdYdUhWMUl4eWVTSUYxNTNKd2ZlcVlsdjR4dGlyZ3dqNnlZY1REQkl3?=
 =?utf-8?B?eC9HdWxoa0JpNW5pYUtiM0ZYcENqU1hTUFlLTGlTeVJQMDlTckF6aUxZZUps?=
 =?utf-8?B?RzhlM1U0UGQ2QzJFSUY0THV4L1RiT011ckVSRTJsN0c0Q2M2VG9GTllQKytj?=
 =?utf-8?B?YnJZbTZDQVNqakROaEtUOEFVTHU0MGdkWHBvNCs4akNRc0JscDZqUlJjVmdX?=
 =?utf-8?B?d25PUjRuTXZTaEtiaEM5cWFEejVSTHBKME9aVDM5RWN5bHFxamQ4YnhsOUNZ?=
 =?utf-8?B?T0g5NTFGcWd1UGRDYk5GWDcvUGNWV2lDbjBNWmF0YWgrbm84ME5JV0lpVjh0?=
 =?utf-8?B?WDFZMmJCMHB1N1dqaXVELzRHeE5ySnl2bHZDNjZ4OUh1cGhyYm9HM1FORW1q?=
 =?utf-8?B?RWlGR1V6aXBtS1FvZmM2VExia0NqT2tpMHUxL1piSTl2Y0x4YWpUczZEeXM4?=
 =?utf-8?B?bUJnVUNJa1l1M1VrUWNLaFphRTM3enZpS1RGVldJUDUwREZEeU8zK1JncEdD?=
 =?utf-8?B?UDdTRXc4NlpXSWkycktRdHc1SC9sYmEzd2Nvd0ZVRzkzbmtjK1dubXRycExV?=
 =?utf-8?B?akhKdWYzbFBjQUVFNnl0K3BPcVVlako4N3c5TGNPU0JrUmM1NlNxcDBOdHVx?=
 =?utf-8?B?SmlWemVhaFJPekk5M1IvSDBka3ZPV2hRZGZUaVltOXlzTFBUTDF4VmUwTUdO?=
 =?utf-8?Q?MwwtHc80ZBq8t/9u5CZNyge+A?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d70e362d-1a05-4de2-193c-08de2348515f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 06:37:44.6467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qsClsKa19+UYFhszAV7SHWxQQo/4BJA9v13ZLHDskqmG3pJ54zueHjWXM2k1XIXHaX05caO3vkc1qzzynusPyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5009
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=KY/fcAYD c=1 sm=1 tr=0 ts=6916ce3b cx=c_pps
 a=CJt2AWVwLbfAHulDA2arTw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=HvlrrJGs30CXpD3u:21 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=t7CeM3EgAAAA:8 a=q6h4EXAro97faJxtzrsA:9
 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: GPioyw4tA8xKf-X3KKIUAFBJyQuDRK_A
X-Proofpoint-ORIG-GUID: Wra3ewujo7T1zthYt7suQiSlZ1-QF0AW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDA1MCBTYWx0ZWRfX9o0fKcTPDxRb
 kY+nHy2YgrucY03xBfjgceAX6xGvLXtbLHKBtdK9HIrc/52nn607Dt8IR4qXNnMM6Ka3LYTMn/o
 8tToT/66Vt0XIAWW7uBwYZM5fEvSoP8pOCIjChm1lVGa2g/eMwf6xaIu82fZafUzKamb7zq06EX
 MkQFXRXHBNAnwCW4qG3bt4TCqWBxKZIrnAJt/pFFMAfM/qiNMBruLMa+zrLYQN9r0jKuX2gVMr+
 M0sNOCVGBEBYKDlhmxenZvXRkqHc2b3rDDOspK7B/IxldVgkQKuzo560neuyBt5nf68vxYIgBRu
 WRLROoMvXjXJ2nN8+tkR5GwLq2rqrVJUUcu13rzptoq4vvjuJzuELu4VwdnfLpgL/gZ/1cxbAE6
 k57MiXop1SkajV3bdkfOqL5zobPLEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_01,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511140050
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 06:37:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18385

On 11/14/25 14:28, Alexander Kanavin wrote:
> On Fri, 14 Nov 2025 at 07:20, ChenQi <Qi.Chen@windriver.com> wrote:
>> I know that the env method is a horrible hack. I looked around but could not find any other choice. Do you have any suggestion?
> I don't understand why the special exception in bitbake-config-build
> is needed to begin with. What is the scenario where it is necessary?
>
> Alex

Let me use an example to explain this one.

When machine/qemux86-64 fragment is enabled and users use 'MACHINE=xxx 
bitbake <pkg>', the expected behavior is to error out and recommend user 
to use 'bitbake-config-build disable-fragment'.

Here comes the problem. bitbake-config-build makes use of tinfoil and 
when setting up tinfoil, the above error will appear again. We can't 
recommend users to use 'bitbake-config-build disable-fragment' while the 
recommended method still errors out. This is the reason for the special 
exception.

Regards,
Qi


