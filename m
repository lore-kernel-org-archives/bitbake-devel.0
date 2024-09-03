Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CD0CA101E
	for <webhook@archiver.kernel.org>; Tue,  3 Sep 2024 06:19:07 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.16896.1725344346791002762
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 02 Sep 2024 23:19:06 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=99767a8c38=qi.chen@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4834o3Rd020689
	for <bitbake-devel@lists.openembedded.org>; Mon, 2 Sep 2024 23:19:06 -0700
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 41c2pkj9va-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 02 Sep 2024 23:19:05 -0700 (PDT)
Received: from m0250809.ppops.net (m0250809.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4836J5s3020286;
	Mon, 2 Sep 2024 23:19:05 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 41c2pkj9v9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Sep 2024 23:19:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HmIBtsgwKNR+QqrwhhHNAMAAKw+X4a3pagqyh2q/bD+JpsiCNiklWQxaqoqJHfENPaWGJYdZRBEbcWSspkYhwHh24D2iaU9Hg0X1a778gMf8mP+TG5oTaoy3WRTh23fmyAi4nZk4LNGd3NqHOXHiOyAZtXGeDKKeHjYwkRFqhRhSJsy1yk51SLt6A5Rt/X77a2wdQacAfI22bWMuF1Y0OalpNhpISsI2NZ4N0eqPl+cAGT9U9fCRdBLfqUOJe2k4muEPQ1ZPW10P7RZ7zBYk+0fS7s/vYjmbwKXd5njI3b/2Qy0sSKkBmGC9vciTmjE1+rK4xXh4Llo9i+QtPGJ1Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwq8qeRlhQ1nRtT6/emPvFcdLupfJSmrG6lnFpfyW0c=;
 b=cUNtEyoV0hKSc+lr2+3uwo2pyPVfoNFE536ydJYNRxPzh8o/crjmeN0iscXI6Q3QEfcEhHpFpRFEDxbM0W4LXh9cVzPTfgwha7cT2UlR70Z6d8tVUkN34nk3lLdwcdT0XD8tgAc8wWxu6pRHr+1yEqng5AStQ/4+etAPkffRdnjywzFu072w8ByE1MtkVU10eL0CHhhC8yqJ83ipAFY06BUC8eQhI+SDSiqu+LmMwjTRDJdihwE/8wRCk7+C7fxeJaq8iyUEEOHp9lOqgnlhhLeGqQpIULygAH3EPNkKTTno6WBfvEi2tZtYp4hNLpTfftZjHZLYwBb2VsksINyG/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by SA3PR11MB7653.namprd11.prod.outlook.com (2603:10b6:806:306::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Tue, 3 Sep
 2024 06:19:03 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::a7e3:721d:9cec:6093]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::a7e3:721d:9cec:6093%7]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 06:19:02 +0000
Message-ID: <aedee457-1262-4399-a12f-b9d0d3f7867b@windriver.com>
Date: Tue, 3 Sep 2024 14:18:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH 1/2] fetch2: Add gomod fetcher
To: Christian Lindeberg <christian.lindeberg@axis.com>,
        bitbake-devel@lists.openembedded.org
References: <20240902091323.2241464-1-christli@axis.com>
Content-Language: en-US
From: ChenQi <Qi.Chen@windriver.com>
In-Reply-To: <20240902091323.2241464-1-christli@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0178.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::9) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|SA3PR11MB7653:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bc70359-6bd3-4749-6eed-08dccbe04e54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|4022899009;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RERDR0JHejdmdGhHbUFPZEpBUXEySG5Uc0RvbmNIbFQ3amwxV09tN010UEZR?=
 =?utf-8?B?eWtSYjBJSSsweVV3Uklob3JJa1o3WDZESHh5QUhQUFB6OE56b2cwRUtucGd6?=
 =?utf-8?B?UmNFd0E0Zkc3eU82NU1MQkF3QnZNUmZGZEdGTHQvRnp0OEVaU2NqZ00xeS9u?=
 =?utf-8?B?OGRnK1NObUlxUllLRVB6ZEpmTG84dmlSNnZpZ2RGQ0lWcWNhZm5jcEpxdmFK?=
 =?utf-8?B?dEpFZXBkOFZMNDM0VnJIcnNHdURKQUhreTRBTStIRThlQkw0Y1JlTXNjWTBV?=
 =?utf-8?B?ZlpsNnN6NEpmMHdTVWI3TERickxlMGtZeWVCaUQvZlI4a0tWS2dMcGVXZnhm?=
 =?utf-8?B?REtJVDZGWnJFZXlBeGo2dEdQTHhoZGpzanBFZTBoVFVMSURQR1llWCtubTNn?=
 =?utf-8?B?bFF3UTUwVFNLd1h3S3AxVzJOaldnOU8vTHRYYUVtTmluNHNVbXFaeVJwaTR2?=
 =?utf-8?B?RHpHNGFZMG5vOVNYZ3gyZGdmSjVOZCs3MmFkUG1FcXFwM1pRTTJORzRYbHli?=
 =?utf-8?B?N1hpelhhZ3U0TExCL1V0R21mbUg4SkJkNVd6akF6ZldVUDM2ZkNPRmsrcUJD?=
 =?utf-8?B?UFh2ZEJJSmdGclFWSmhhWHhWR0NpdE5zU3JLK253U2JVYy85NDcrT1hIdWE0?=
 =?utf-8?B?SHBaVGxIL21oOGVxQ1NwLzBYU0UrWkFKN0FFR0JoUkFGcUVIZ01WSXBHbmpH?=
 =?utf-8?B?WXdrc3RFeklkR1Y3WGwyZHVHUlVRVzRocWUyL1dGUTJNRk82aDc0OExCa014?=
 =?utf-8?B?aEFIT1pUd2lzdGdrTUVkMi9CVHY4dUozUURRWVIyYTNiYkU2SFE0aVpoSS8x?=
 =?utf-8?B?TzdoZGxCdGV2UkczUmdRTjlWSVVnNzJ4NmFxOUtUaWxhYkFSZnU3c250dWRW?=
 =?utf-8?B?UE9lR0xvd1cveFFBZWdqd1VPTVB0c2dCUmR0MWp2TGxNQ1BuN2Radk91WWph?=
 =?utf-8?B?Uzhmb09JRnYrTElKNkJ0U2oxNk41RXhaWGo5TzB6c0I5NWJITEY3TlVReXRP?=
 =?utf-8?B?TjdWY29aclJvTTQ2MkdUN2FKTzZmL09BR2xlQVkrVDdMUGdiRzNvL1VjcThk?=
 =?utf-8?B?RmszMXJmWFdZVTNKSTIrRGtaZXpIYUVhTENnUmVMZm5SU25oYitOdUhtcG9l?=
 =?utf-8?B?U1Q0WjNaQXpJajV5RFJMNEVXR0FSQzVDUDZtOXlxODdmWW1CN3FlbzIrbStC?=
 =?utf-8?B?U3M4STdsZDErVjU2RjBWbjRWODJyRi9zalhaemd2ZTJSdThpemRUL0ZISE1x?=
 =?utf-8?B?Y2p5R0ttUTh0SjFVYTY5eWRqeFdJTzFTSG1YRnNKcHlkOUV0TzFoVHdzYXg0?=
 =?utf-8?B?ZFhPSENEclE1ZHpJL3JPRHUwZ05aNGlrLzd0RnkwajNjUHlRUTFkbHovbGxX?=
 =?utf-8?B?VkhCZVlLVkFYVHJhRE54czNQOTNadHdkY1R4V1hMVXJqN1ptbU55cldsV29y?=
 =?utf-8?B?cklMd2dpcy9PcmhtVXQzKy9mVE1JMzl6Z3JtTFdpa3VlS05VL291SGJ6V1Q5?=
 =?utf-8?B?aXJHM1dsb3NTeWUvK011RXh4bDJRUlBJaHVNazU3WnY5NSsvL1NqcEJVdllY?=
 =?utf-8?B?VlBQM20xbDFFaERQWW14aDUxZWxDcjRwV21jNVdZaHZvd0Y5N0ZQMytHbVZj?=
 =?utf-8?B?akEydk14TlNMQjFaNGVueXJtYkNwcGthNFoxWkYwQUVZSTE2U0liS1NYOFpJ?=
 =?utf-8?B?R2hDNXdkd0pLalRYZ0ttcGczUWVielJCU3ExOFVzTk8rTGNiME5UYzRHeE9o?=
 =?utf-8?Q?PuBa7Sxn1Pac4rxWzE=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(4022899009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N2xKRTlmK1JmRCsyZ3dhMWNDTEdWL0pOcVlUdlpmbTBVdnJSdzFGKzlTelda?=
 =?utf-8?B?U2t4SjNHVlRjSkhJMWFmNmlJS3RJWmJJWmp2UnMzNHBrdFhSbmVxVHdEOEJS?=
 =?utf-8?B?U1diVmlvMmpuRmNXU3ZjMlBicGtPNmhEaUZRaGhaaWRnSEM4VmhGREo5MFgr?=
 =?utf-8?B?Z25FQjN5OEdTR1E4eEVxZU4ybzhNbFJWRlFTNW4ycEFKK1hITXhCRSt5L0xU?=
 =?utf-8?B?UDNGa1dsNnFBdUNUWFdrRUg4emZOTlZNcTE2TnYwMTVMejFEaVNQTW5sVjFW?=
 =?utf-8?B?NU5td21tNDJRL1owbm9UZXpnbU8xK1ozYVowYTF4MSs4UXIyVE9aRk5QMUdM?=
 =?utf-8?B?MmhBV08yeHJlLzZ3VkJxZGxCU0pZdkt5S3B3U3ZIMDU2MXhTd1FDMjVoQXhj?=
 =?utf-8?B?bWNUMkJaVnJvQTdYN0xSSFJFSDRHdkMveWZtZXJFUFpzVC9LcVRYM2YwUkoy?=
 =?utf-8?B?VnVCSHdFdTQzb0g3S3JaZDlIMEhZVmQvZDg5WmdnS1pydEFFbEJwZS9kKzIv?=
 =?utf-8?B?VnZXTnZTL0dIMnlEN3FVU2lrZlJ1ZnRkY2RYR3J6R0ZIZVlYTVA4YkNOZTlp?=
 =?utf-8?B?cDJTK1FIZ0NIM085eEtNNlJnZDlURVBGb2pRUS9KRXpGSTM4TkJZYlVCRUFk?=
 =?utf-8?B?TW80UFl0dkpSS2lzanlLYkpGT0pycG95Q3FxL1pwV2IrbThmRmVwTmNUQ3Bs?=
 =?utf-8?B?MzhBbjVJMHRJL0ZEL0RFMDNYZ2p6cE9yaEdJZ1lxNDV6eHdvNXN4alYvamk1?=
 =?utf-8?B?UUcwcXRyM2k4a0VsRXh1Tkw0TEhQajA3dWc0Nmk1WFVKRWNDYlZaVCtqVmpJ?=
 =?utf-8?B?cW9Ea0hDc2Y1aFVXK1k5Y3BQR1NEWkwzWWdqYVBCUkxoOHlBSkgyb0hzU3FE?=
 =?utf-8?B?VVdjVVVWSEp3NzA5TERQbWhCMFVzNy96RVl4eERUVmVXajFQaVQySStEb3pC?=
 =?utf-8?B?Q201YjFSZEQ4Qnh1b3NIM0hwUVdmdmVwQTU2b0ZyTW5LdXZ2QWNrbVVEU1lN?=
 =?utf-8?B?dW4xQnJXVU5rODVCVEUrU1kxcFVxbGVlaUNPb3FQR3pIUEV6Y21MU3pSeG5y?=
 =?utf-8?B?L2tScEViL2I4UmtEMjJSdVVyakROaTFlZWpUK3NYQjRZZnRCblZuTkdscmZP?=
 =?utf-8?B?dFVLSjJway9FZHhEeVFLVEg2TzkxZGx0N05naUtXK0o1bTFUQ1JoOEVmMTM3?=
 =?utf-8?B?ZHUrbGU0QkE5VFFWNkE2NDNoS2Ezd29Lem9SamE2Zk5UK1YzVTMzYXozbFFw?=
 =?utf-8?B?TWljVTRUMm4yNnNkeC9oSWw0VWlvVVY1UElTcWgzWVk0RW85RVY3K1pUMW9t?=
 =?utf-8?B?dXV5U1cwUEk3RkdJUmJXZlhSZ2JSSExqNVFPdUZyQjR3Nnh4VWtZKytzYmxk?=
 =?utf-8?B?OW9WUlorTzliY29oMGUyUWtWTVFNdGhQZndPa0VKejRzM1Z3VTFjUlZnbG9h?=
 =?utf-8?B?dnhLbURsRTltTGpsTUhPdUpCU2VUODd6UGc3am94bW4yMFowcGVIZmUrMUl5?=
 =?utf-8?B?Zlh1T3lQT1UwejBEdmc2cFd4SGNJSWxBM09sUVcyQVlSRWlUS2hEZTBqYlIz?=
 =?utf-8?B?LzFlcUl4eDN3aFFSVXBad1pOeXExOEV3V3hFMThudlFORDRSclpDdTNyeG1E?=
 =?utf-8?B?dGdYVDlXVUNDMkttYW5GYUpuUi8waSt1WkhXd1ZEbkxKRjMwbEh4N3dRWDJC?=
 =?utf-8?B?NEJFTjl0azVpMmlMcU1SVUFhRUtFQU50QStBTTVxZHpzdEN6S0Z6bGYxNHJG?=
 =?utf-8?B?VjNwck5sTm44L1VkbE1BSW9EWDV2SzQxUk9QQ0JXdkg0eXZoMFBZR3Y3MXVP?=
 =?utf-8?B?VEpkR050aGp6TkRFY1lKUVJoWFk4YnRNTGdDbHdXczNjWkFoODJYV1hsQmRo?=
 =?utf-8?B?aTJzOU0xQkNzM3ZJa1ZBQTJ5Q21KaUN4Tm9pQUxZaFRRaDFGWVhEVlZBVVVC?=
 =?utf-8?B?QWxwbkNtWWFzTTNjUjNhSHU4QmFFVS9WWkt6eENrajZFd21ZcHFTU0hEUm1F?=
 =?utf-8?B?QTFpanhMeGNHNGdNWFJ4UFBYVjY3cVdJeHU3ejNPTnh2eUhGZjZnaVdjWHpz?=
 =?utf-8?B?YkFSNGJ5UGVZOFB6dkxZb2Q4NTcwVlQwTlpLbVgwdjVDL1JnblVBRm16UzlH?=
 =?utf-8?Q?ColpCSrnGO88t3KrRJguxUvl3?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc70359-6bd3-4749-6eed-08dccbe04e54
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 06:19:02.9140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KjpCs3sW5ZXtDuqVypPzdnCT7oVIRPzhSTbrdHLbqxTs2Q6IDh3/gBJM9mDPHZabHuuvRXxlV4SCG2QIWA6+YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7653
X-Authority-Analysis: v=2.4 cv=c+X5Qg9l c=1 sm=1 tr=0 ts=66d6aa5a cx=c_pps a=yF+kfS/uWKtSACHbTM5LMQ==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=bRTqI5nwn0kA:10 a=3-RhneuVAAAA:8 a=pM9yUfARAAAA:8
 a=plf8rDjJAAAA:8 a=NEAV23lmAAAA:8 a=Q4-j1AaZAAAA:8 a=t7CeM3EgAAAA:8 a=oMfruj_nfoDp38EDaDIA:9 a=QEXdDO2ut3YA:10 a=VLVLkjT_5ZicWzSuYqSo:22 a=YH-7kEGJnRg4CV3apUU-:22 a=JWTSs7K9Rhv-lrTctFka:22 a=9H3Qd4_ONW2Ztcrla5EB:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: xlb7oDv0DUXfwI49PpXwXL15WIz2F8fE
X-Proofpoint-GUID: ppAYmrbwdGvK4HC5CtJEnokT4p4W1YYL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-02_06,2024-09-02_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0 impostorscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.21.0-2407110000
 definitions=main-2409030048
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 03 Sep 2024 06:19:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16538

Can the mods be re-used (serving as some kind of mirror) from an 
existing download directory?

Regards,
Qi

On 9/2/24 17:13, Christian Lindeberg wrote:
> From: Christian Lindeberg <christian.lindeberg@axis.com>
>
> Add a go module fetcher for downloading module dependencies to the
> module cache from a module proxy. The fetcher can be used with the
> go-mod class in OE-Core.
>
> A module dependency can be specified with:
>
>    SRC_URI += "gomod://golang.org/x/net;version=v0.9.0;sha256sum=..."
>
> Signed-off-by: Christian Lindeberg <christian.lindeberg@axis.com>
> ---
>   lib/bb/fetch2/__init__.py |   4 +-
>   lib/bb/fetch2/gomod.py    | 116 ++++++++++++++++++++++++++++++++++++++
>   lib/bb/tests/fetch.py     |  73 ++++++++++++++++++++++++
>   3 files changed, 192 insertions(+), 1 deletion(-)
>   create mode 100644 lib/bb/fetch2/gomod.py
>
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index 5bf2c4b8c..f84ce5999 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -1317,7 +1317,7 @@ class FetchData(object):
>   
>               if checksum_name in self.parm:
>                   checksum_expected = self.parm[checksum_name]
> -            elif self.type not in ["http", "https", "ftp", "ftps", "sftp", "s3", "az", "crate", "gs"]:
> +            elif self.type not in ["http", "https", "ftp", "ftps", "sftp", "s3", "az", "crate", "gs", "gomod"]:
>                   checksum_expected = None
>               else:
>                   checksum_expected = d.getVarFlag("SRC_URI", checksum_name)
> @@ -2088,6 +2088,7 @@ from . import npmsw
>   from . import az
>   from . import crate
>   from . import gcp
> +from . import gomod
>   
>   methods.append(local.Local())
>   methods.append(wget.Wget())
> @@ -2110,3 +2111,4 @@ methods.append(npmsw.NpmShrinkWrap())
>   methods.append(az.Az())
>   methods.append(crate.Crate())
>   methods.append(gcp.GCP())
> +methods.append(gomod.GoMod())
> diff --git a/lib/bb/fetch2/gomod.py b/lib/bb/fetch2/gomod.py
> new file mode 100644
> index 000000000..0675c87e5
> --- /dev/null
> +++ b/lib/bb/fetch2/gomod.py
> @@ -0,0 +1,116 @@
> +"""
> +BitBake 'Fetch' implementation for Go modules
> +
> +The gomod fetcher is used to download Go modules to the module cache from a
> +module proxy.
> +
> +Example SRC_URIs:
> +
> +SRC_URI = "gomod://golang.org/x/net;version=v0.9.0;sha256sum=..."
> +
> +Required SRC_URI parameters:
> +
> +- version
> +    The version of the module.
> +
> +Optional SRC_URI parameters:
> +
> +- mod
> +    Fetch and unpack the go.mod file only instead of the complete module.
> +    The go command may need to download go.mod files for many different modules
> +    when computing the build list, and go.mod files are much smaller than
> +    module zip files.
> +    The default is "0", set mod=1 for the go.mod file only.
> +
> +- sha256sum
> +    The checksum of the module zip file, or the go.mod file in case of fetching
> +    only the go.mod file. Alternatively, set the SRC_URI varible flag for
> +    "module@version.sha256sum".
> +
> +Related variables:
> +
> +- GOMODCACHE
> +    The location of the module cache.
> +    The variable must be exported for the go command to find the downloaded
> +    module cache.
> +
> +- GO_MOD_PROXY
> +    The module proxy used by the fetcher.
> +
> +See the Go modules reference, https://go.dev/ref/mod, for more information
> +about the module cache, module proxies and version control systems.
> +"""
> +
> +import os
> +import re
> +import shutil
> +import zipfile
> +
> +import bb
> +from bb.fetch2 import FetchError, MissingParameterError
> +from bb.fetch2.wget import Wget
> +
> +
> +def escape(path):
> +    """Escape capital letters using exclamation points."""
> +    return re.sub(r'([A-Z])', lambda m: '!' + m.group(1).lower(), path)
> +
> +
> +class GoMod(Wget):
> +    """Class to fetch Go modules from a Go module proxy via wget"""
> +
> +    def supports(self, ud, d):
> +        """Check to see if a given URL is for this fetcher."""
> +        return ud.type == 'gomod'
> +
> +    def urldata_init(self, ud, d):
> +        """Set up to download the module from the module proxy."""
> +
> +        moddir = d.getVar('GOMODCACHE')
> +        if not moddir:
> +            raise FetchError("The module cache location is not specified in the"
> +                             " GOMODCACHE environment variable.")
> +        proxy = d.getVar('GO_MOD_PROXY') or 'proxy.golang.org'
> +
> +        if 'version' not in ud.parm:
> +            raise MissingParameterError('version', ud.url)
> +
> +        module = ud.host + ud.path
> +        ud.parm['module'] = module
> +        path = escape(module + '/@v/' + ud.parm['version'])
> +        if ud.parm.get('mod', '0') == '1':
> +            path += '.mod'
> +        else:
> +            path += '.zip'
> +            ud.parm['unpack'] = '0'
> +        ud.url = bb.fetch2.encodeurl(
> +            ('https', proxy, '/' + path, None, None, None))
> +        ud.parm['downloadfilename'] = path
> +        ud.parm['subdir'] = os.path.join(moddir, 'cache', 'download',
> +                                         os.path.dirname(path))
> +        name = f"{module}@{ud.parm['version']}"
> +        if d.getVarFlag('SRC_URI', name + '.sha256sum'):
> +            ud.parm['name'] = name
> +        super().urldata_init(ud, d)
> +
> +    def unpack(self, ud, rootdir, d):
> +        """Unpack the module in the module cache."""
> +
> +        # Unpack the module zip file or go.mod file
> +        super().unpack(ud, rootdir, d)
> +
> +        if ud.localpath.endswith('.zip'):
> +            # Unpack the go.mod file from the zip file
> +            module = ud.parm['module']
> +            unpackdir = ud.parm['subdir']
> +            name = os.path.basename(ud.localpath).rsplit('.', 1)[0] + '.mod'
> +            bb.note(f"Unpacking {name} to {unpackdir}/")
> +            with zipfile.ZipFile(ud.localpath) as zf:
> +                with open(os.path.join(unpackdir, name), mode='wb') as mf:
> +                    try:
> +                        f = module + '@' + ud.parm['version'] + '/go.mod'
> +                        shutil.copyfileobj(zf.open(f), mf)
> +                    except KeyError:
> +                        # If the module does not have a go.mod file, synthesize
> +                        # one containing only a module statement.
> +                        mf.write(f'module {module}\n'.encode())
> diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
> index 2ef206343..652907af5 100644
> --- a/lib/bb/tests/fetch.py
> +++ b/lib/bb/tests/fetch.py
> @@ -3390,3 +3390,76 @@ class FetchPremirroronlyBrokenTarball(FetcherTest):
>               fetcher.download()
>           output = "".join(logs.output)
>           self.assertFalse(" not a git repository (or any parent up to mount point /)" in output)
> +
> +class GoModTest(FetcherTest):
> +
> +    @skipIfNoNetwork()
> +    def test_gomod_url(self):
> +        self.d.setVar('GOMODCACHE', os.path.join(self.unpackdir, 'pkg/mod'))
> +
> +        urls = ['gomod://github.com/Azure/azure-sdk-for-go/sdk/storage/azblob;version=v1.0.0;'
> +                'sha256sum=9bb69aea32f1d59711701f9562d66432c9c0374205e5009d1d1a62f03fb4fdad']
> +
> +        fetcher = bb.fetch2.Fetch(urls, self.d)
> +        ud = fetcher.ud[urls[0]]
> +        self.assertEqual(ud.url, 'https://proxy.golang.org/github.com/%21azure/azure-sdk-for-go/sdk/storage/azblob/%40v/v1.0.0.zip')
> +        self.assertNotIn('name', ud.parm)
> +
> +        fetcher.download()
> +        fetcher.unpack(self.unpackdir)
> +        downloaddir = os.path.join(self.unpackdir, 'pkg/mod/cache/download')
> +        self.assertTrue(os.path.exists(os.path.join(downloaddir, 'github.com/!azure/azure-sdk-for-go/sdk/storage/azblob/@v/v1.0.0.zip')))
> +        self.assertTrue(os.path.exists(os.path.join(downloaddir, 'github.com/!azure/azure-sdk-for-go/sdk/storage/azblob/@v/v1.0.0.mod')))
> +
> +    @skipIfNoNetwork()
> +    def test_gomod_url_mod_only(self):
> +        self.d.setVar('GOMODCACHE', os.path.join(self.unpackdir, 'pkg/mod'))
> +
> +        urls = ['gomod://github.com/Azure/azure-sdk-for-go/sdk/storage/azblob;version=v1.0.0;mod=1;'
> +                'sha256sum=7873b8544842329b4f385a3aa6cf82cc2bc8defb41a04fa5291c35fd5900e873']
> +
> +        fetcher = bb.fetch2.Fetch(urls, self.d)
> +        ud = fetcher.ud[urls[0]]
> +        self.assertEqual(ud.url, 'https://proxy.golang.org/github.com/%21azure/azure-sdk-for-go/sdk/storage/azblob/%40v/v1.0.0.mod')
> +        self.assertNotIn('name', ud.parm)
> +
> +        fetcher.download()
> +        fetcher.unpack(self.unpackdir)
> +        downloaddir = os.path.join(self.unpackdir, 'pkg/mod/cache/download')
> +        self.assertTrue(os.path.exists(os.path.join(downloaddir, 'github.com/!azure/azure-sdk-for-go/sdk/storage/azblob/@v/v1.0.0.mod')))
> +
> +    @skipIfNoNetwork()
> +    def test_gomod_url_sha256sum_varflag(self):
> +        self.d.setVar('GOMODCACHE', os.path.join(self.unpackdir, 'pkg/mod'))
> +
> +        urls = ['gomod://gopkg.in/ini.v1;version=v1.67.0']
> +        self.d.setVarFlag('SRC_URI', 'gopkg.in/ini.v1@v1.67.0.sha256sum', 'bd845dfc762a87a56e5a32a07770dc83e86976db7705d7f89c5dbafdc60b06c6')
> +
> +        fetcher = bb.fetch2.Fetch(urls, self.d)
> +        ud = fetcher.ud[urls[0]]
> +        self.assertEqual(ud.url, 'https://proxy.golang.org/gopkg.in/ini.v1/%40v/v1.67.0.zip')
> +        self.assertEqual(ud.parm['name'], 'gopkg.in/ini.v1@v1.67.0')
> +
> +        fetcher.download()
> +        fetcher.unpack(self.unpackdir)
> +        downloaddir = os.path.join(self.unpackdir, 'pkg/mod/cache/download')
> +        self.assertTrue(os.path.exists(os.path.join(downloaddir, 'gopkg.in/ini.v1/@v/v1.67.0.zip')))
> +        self.assertTrue(os.path.exists(os.path.join(downloaddir, 'gopkg.in/ini.v1/@v/v1.67.0.mod')))
> +
> +    @skipIfNoNetwork()
> +    def test_gomod_url_no_mod_in_zip(self):
> +        self.d.setVar('GOMODCACHE', os.path.join(self.unpackdir, 'pkg/mod'))
> +
> +        urls = ['gomod://gopkg.in/ini.v1;version=v1.67.0;'
> +                'sha256sum=bd845dfc762a87a56e5a32a07770dc83e86976db7705d7f89c5dbafdc60b06c6']
> +
> +        fetcher = bb.fetch2.Fetch(urls, self.d)
> +        ud = fetcher.ud[urls[0]]
> +        self.assertEqual(ud.url, 'https://proxy.golang.org/gopkg.in/ini.v1/%40v/v1.67.0.zip')
> +        self.assertNotIn('name', ud.parm)
> +
> +        fetcher.download()
> +        fetcher.unpack(self.unpackdir)
> +        downloaddir = os.path.join(self.unpackdir, 'pkg/mod/cache/download')
> +        self.assertTrue(os.path.exists(os.path.join(downloaddir, 'gopkg.in/ini.v1/@v/v1.67.0.zip')))
> +        self.assertTrue(os.path.exists(os.path.join(downloaddir, 'gopkg.in/ini.v1/@v/v1.67.0.mod')))
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16532): https://lists.openembedded.org/g/bitbake-devel/message/16532
> Mute This Topic: https://lists.openembedded.org/mt/108223851/7304865
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [Qi.Chen@eng.windriver.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>


