Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FE2C25B75
	for <webhook@archiver.kernel.org>; Wed, 15 May 2024 09:58:11 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.10867.1715767086971554878
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 May 2024 02:58:06 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=5865462aad=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44F6oInn032610
	for <bitbake-devel@lists.openembedded.org>; Wed, 15 May 2024 02:58:06 -0700
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3y286fu0xa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 15 May 2024 02:58:06 -0700 (PDT)
Received: from m0250809.ppops.net (m0250809.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 44F9vZg2026975
	for <bitbake-devel@lists.openembedded.org>; Wed, 15 May 2024 02:58:06 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3y286fu0x9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 02:58:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S26jt1AliGEmJ9Kk53ar4RtUJZzH37An0Hfh/zSnFH7nA4lUpEf9vDJiforKw4YjEQz+jUOJR9heaaiqvEKT6eGeyXwfITux/WqHzPajU/YViiuKb1Z3g2UNwmSkNYyh7agOwPdlVcZNKU1VKgibhMkbxLVWzGR9Kf5j8nl5yOtO3QGJjsDaCnKdwP0ukug6Zp2jhiYwOTT6sZEH6BF1jFfz9krRlD7j1wTPGklwgqz254ea5ZVIO+tGFenwflPFOQ+7X45y3Us45QcaFBxpniQ5Ev+y/BjSSgHrphSjnDRW2FoBF7XFbhN+BSXUtqPl42Vq2Cc2jUqL50BCTqZO+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36LF+ZYYyj46tiBU5A3ycoC6X/wwbKanMj1FO1K/tk8=;
 b=hQPheD9CKJ3hFtf53d3wGWyeNAvoTHWa8wUTnaFDiVHa+YBsrF5G9ltqQv5wiy2S+IPWzFIe1gPSH9FmUg0sELN5fpH55P9afTb1zdVD3ony3O/S3R6VwLeX1v1S9F1dlDpWs5SxBKvRJBD/ulIKf0OYj7/148B1asqZ/acSeQQnE2TFzkhRLcErff2swsTnmqL4yBskJQHCJAsOnc2Mw3Zmu/94IGEsLPQeyHgfchGyJDdHWZs35bUaavD+lUsKht1F0tiwXklDA5UFBQ5rzBSeIUZ5UnCu0h50sk1Jq7Rn3gBv6X9xP/55d64d5xY57lz/zvUVZme88B3yrg3ELA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from LV3PR11MB8531.namprd11.prod.outlook.com (2603:10b6:408:1b6::15)
 by CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 09:58:03 +0000
Received: from LV3PR11MB8531.namprd11.prod.outlook.com
 ([fe80::d341:6ff5:fce1:c6d]) by LV3PR11MB8531.namprd11.prod.outlook.com
 ([fe80::d341:6ff5:fce1:c6d%4]) with mapi id 15.20.7544.052; Wed, 15 May 2024
 09:58:02 +0000
Message-ID: <b1399680-6f22-4477-ada4-8a718f807237@windriver.com>
Date: Wed, 15 May 2024 17:57:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH 1/1] fetch2/git.py: Try without '.git'
 suffix firstly
To: Quentin Schulz <quentin.schulz@cherry.de>,
        bitbake-devel@lists.openembedded.org
References: <cover.1715765153.git.liezhi.yang@windriver.com>
 <4a7647c4169ffc0c70858a4a1f1b2eb18ffcfb70.1715765153.git.liezhi.yang@windriver.com>
 <367b25fc-4d5a-4a1f-a259-55e2325e1a34@cherry.de>
Content-Language: en-US
From: Robert Yang <liezhi.yang@windriver.com>
In-Reply-To: <367b25fc-4d5a-4a1f-a259-55e2325e1a34@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::22)
 To LV3PR11MB8531.namprd11.prod.outlook.com (2603:10b6:408:1b6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8531:EE_|CO1PR11MB5089:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c31ec53-78c1-4c85-a5e7-08dc74c58269
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SCtWeEJZSldBU2MvR1RyTTE2RGVScndINGpuMS9yai9XanBnU1E1MGJzRkw2?=
 =?utf-8?B?L2pydUhpVHhGMUdpTTVqaTlDSEc5UDF3bExZZDhyRFV0VFRMNHNYRFlXdVpB?=
 =?utf-8?B?ZmUrUTZETHE2QnZGK1pJUDdkZ3R1a0ZyMXlrak9ONi9vcTgwZ3d1YkRRODlz?=
 =?utf-8?B?c2tyL2VGaGpMcG55THo4eG9TcEtheWs2MWx0VjJqSml0T3UyK0F0VWFxd0Vm?=
 =?utf-8?B?ZTl4cGszSjY3blZ5dW5CN0dpeFE4c3A4VjVicWZjdm96TU5RVFNxRFliNFAz?=
 =?utf-8?B?bHZUckNONm1RYml1TWQ0OUp3eVgyOXdoRkhTQ2xRejlLcmtLdTlDN2Y3ZEs0?=
 =?utf-8?B?WDR6akdSQjBISHpqekFLT2lTcU9zdXBZU29tWTROdDZnZnlSVm1EblVlWHdZ?=
 =?utf-8?B?RlpBcVM0cFJuUjdXa3ZMT2lxZHRMZWlZS1FHeHpWZGJ0VlQ4dVBSR3JGenZo?=
 =?utf-8?B?b0N2Sk5WcUhWOG03ZnA1VEhSTzFieGxVTzNmTG9DYng2eGJrV0hZWk5DS2ho?=
 =?utf-8?B?OXZXbWtlVlB1aVc3czBBWWtMRHJkMFNDVUZLeWsyVlI1bVhpdnRDVzVzMEpi?=
 =?utf-8?B?WlBFbzN3RmZ0Wkw4dHI5aFZoQTYzOG4rNm1VV0YxbFJqcE02VWlRUWRsZlV4?=
 =?utf-8?B?WE1ndTJyMEd1N3hXRGdjeDlaN1dab3AvMythd0YvTndQNU1iNXVWQTlLVkFT?=
 =?utf-8?B?cDFGdU5wSzdCc3pDdUpDNDg5RFRGM2kvemhZL2kxY3hRVU5jZWVKMm11LzU0?=
 =?utf-8?B?blZDeUZEMldBM3FNejdzTlp0dTRXZWh2VllKV0hLZTM0czdTRkxuN1BjTnNC?=
 =?utf-8?B?Y1NDQ3V2USsxVzJaaVg5dzNWMEpjeXBFRmU4dW44bWlRNnRjVzY4aTZHTnpa?=
 =?utf-8?B?WGRzeWJMUm1HRWdPYkMrVHUyTTZyUWNKYVVlL3hXVzVJQVRJdjBEZzJiN1Yx?=
 =?utf-8?B?czZaYm9EZktDWFNQelU5eUp5TmlGMTNDOHpNa05Ialp0M1dxWDJuUFczeDBE?=
 =?utf-8?B?S3lySFJ1ci80ZUtjc0d5amw2RmpDdzdIUS9xNEswWUpxaU1DTmVJRFpwSXVM?=
 =?utf-8?B?YVFyVHhUdU9vS1hKYjFXVzdCNGxQUVkzc2ZXSXUxa09CWndJRThyUkoxb2da?=
 =?utf-8?B?S3pXNEtDbGxDTGFkcGJLbXE3QytZS0h5SDJhOEZ5U2JWdFR3Wm5uVGVlZWVR?=
 =?utf-8?B?blo4U0xYTGx0ZnFHOTZIUnhCTVI4NU1TN1JiTEtLTzZUbzdsV0lZSDZOSmd2?=
 =?utf-8?B?bCtUSWgyQTRxblowNDF5Sk4rU3ppODZwbnphcFFQcG1SVXpNOVFjV3FDZUtI?=
 =?utf-8?B?TEpySmdlUVVuSkVuQVhQbUlKcXZPemlMY2NyY04vbEFpWmNMVmUxRDZiejhN?=
 =?utf-8?B?WjVXc3dwVVlRTms3dGQ0Y1pTSU9lSTAwcVQ4eGczbVM5ZFdabU5HR1NwZSt1?=
 =?utf-8?B?azdnekc2ODloM0szNmxwMmQzTzFpZlpIeDh3Y2duaTZqV25GZytHMEd6a2NW?=
 =?utf-8?B?S25XZWRieHlxemdyTzY2ZHdnZENoL1JlT3cva1k3cjErRCtKS0xjT1hBbWJL?=
 =?utf-8?B?NGc4bWxsSEd0TWk1cEwwREZEdU9pcjJxZUZlclhnMXdYcnJSSWN0TmRkb3h2?=
 =?utf-8?B?dHplb2IzaFpZaFpCWEpDU2tPZGt0R05mZTNnYjFEQmcyN0E4cHMvUjVYQVR1?=
 =?utf-8?B?MUhDeVE4QjR0ODRheTJkUXlSS2RKR2NqQlNtdi9MNW9ZK3FDTnZtRTdnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8531.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TnQrVjdWWFRvQlVSVUFNSW9jYTZGRnNyN0dXNTlZcHBEUDFxM2hmdVQwZkZS?=
 =?utf-8?B?M3ErSnoxeXVCSjJHTkcxemY5ZWIyMXJLMGtkcmJvczNxMDUzOEFPai92QURQ?=
 =?utf-8?B?b0l3eHlnNDBadlQ1eXBUVmdiL3BuNjBPZklxTFdkaUlaMzQ3KzY1dER1ZU9X?=
 =?utf-8?B?QlFWOEkvdDZrR0JuazNlNnR3K1kvU1p1bkE0R1NqV05SQTY1K3UrRk9VRVJM?=
 =?utf-8?B?U01EaGJqRXBsdGl0YWd4RXdyRE1jaGNScFpPeUpyZE14aEZkQkxIM3ZPMlBG?=
 =?utf-8?B?QWREVXd1RlpyU1V2Sjd6ZGt5WW1NZHkvK3NyQ2NNZ2ludnluM0h6RSttTDRF?=
 =?utf-8?B?aW90WngzYTNVRHQzazkwemZEMUtXdjE3MmduSzRKTXI3RnZnRHo4bDdxaTVs?=
 =?utf-8?B?OFkrUDdlZW0zcy8zc3RoaGcyeWhvWGNNR0JLSldaTnZOT2RHRzcrbExLMkt5?=
 =?utf-8?B?SW1WYlhpMTJjQzZ1eGRJZUtPckppN0JtTDFSVVpZTTd6elFEVkszL3U2d2NO?=
 =?utf-8?B?ODhjY0FJVWVkRklQc2NsK29uNy83c09Cak9JOS9icHc2UzhDS2t4LysrTGZp?=
 =?utf-8?B?R1VuMm9vKy9MWkV4b1lCWksxRnJSak0yd1J6RW80ajZBcld1N012VEk1NG1P?=
 =?utf-8?B?QzdsYks1VHgrbWFVUjJWWUQxbE9wUVlQYVZ6QmxIckVZUFF0Y0NmTThaVTJp?=
 =?utf-8?B?Vk1SOEJpQmovWGRjVVUyaS9GRXUzQk5nNUx3TFNrck9LMUJGc2RhbXlMdTdx?=
 =?utf-8?B?MzVpVmlMV1RpcmlWdi83M29semFCQitwbTJ6dHZKWWZLbzdaS1lYdHRnNE9E?=
 =?utf-8?B?a2JWeHpsN1Q2dkY5bVRxbGZQSzM1TUZGd1MyWnlsR0Z6V0pLaDdxRGJwaE1u?=
 =?utf-8?B?bWNRZk1NbHQyZ1NzdzFNK3ZzbGpjQ1VqZTE2SFo5ZVhua3pUWFJ0Y2ozU1Nl?=
 =?utf-8?B?Q2VsT294R21FZnF0b1c5UktZMHc4Y05jTTBMWWdXWXBIVnAxYTI2dDFzYWEw?=
 =?utf-8?B?ZWg2RTdGQTBqd2JxYWh1T2VoRVg3VTE5K1pkYm9GV3ZMRkNmS01DR3RDZHNv?=
 =?utf-8?B?MWlQUmNzeHkrN1FDMkNQdkEvaDhqSHV0emxCLy9QUGdJdzlaMHdoWjg3Nkp1?=
 =?utf-8?B?aXRYa0NpZlg1QVdNUUxpdjZhd0tKbHBtZnRQcEYrUGtPTXEwdUFrUnBoNjVM?=
 =?utf-8?B?QnJCd29DOUpQVVBlc2pWR0lGNFVaUk9obUxXTVNKbzEyYmQ2NHBha3AxTVpL?=
 =?utf-8?B?WmpDMXpjWGZKaEZYTnBTd2hNTFJ3UmlBNTQycC9nT0ltanBnanZKZ1ZLN1NY?=
 =?utf-8?B?Q29raDJrbGtudjdLajc0cSt4dVZkN0V3aWRsQ2xWUXJUNFdEWGxVMFhhUkF1?=
 =?utf-8?B?VlFUQVBEV2dreG9aaHQ5K1FBeFo5ZGNZdjg3MC81cTNISkg5Rm5LdnZ6Rkly?=
 =?utf-8?B?WW5YZEp5ZGpvS3BqNGxkUUFGeWwyVE9pWWlHV2UvbWsvNHY0NjRZTWlvN1ZX?=
 =?utf-8?B?UzRQOVBPMURIbkxjSmR4bFprenZuZUd1VEZWYWc5UFRlNXlBL1ZrVS9VZFox?=
 =?utf-8?B?THlEV0Vta2RzMlVtcGhVbGlrM3NJbGJQUXZxQm12RXRzMURoRHc1YnhhTklI?=
 =?utf-8?B?VjVTdTFIT1NwMUpMYjFYakloN09tTU9VcllTMi9nZE5oYmF4dngrTDd3bVRr?=
 =?utf-8?B?NUd2VDlLVlhFWG5KV0psTnpXSkJ6L1Z5UGR3U05jSG5oZ3N5Ukh4aEt6WVVm?=
 =?utf-8?B?NW12TXVnVHZpN1Rsbjh6TkJGTFpGbys0T2FWbWowOVMzcXNxcStVanUyck03?=
 =?utf-8?B?SituUjY1SExnRi9odmo5emF6cElQK3pQWTJyc0dTM1RKVy9yWVJ3cS9sM09F?=
 =?utf-8?B?N0YyWVF2N0lSenp2cU56SXR4NkZxdmZmbWt1a3V6WTBRUmZvOWRRUWNDSmg3?=
 =?utf-8?B?N2hySEQ4WUw4VDJsNFZHeEd2UmI1anBoZWx3bXNtelRJRlQ5cy9kemljR2dO?=
 =?utf-8?B?VzlwVGlPQStzczBacEtqNVpQUlR2cjhCeldkZGFiWkZZSUk5Tm5aUTNpNHpT?=
 =?utf-8?B?Lzd2L05DN1B5bmJKZGttQkhjeUI3Rm5rWE5LU0FiRDJmZ0pxeVEzTjJYakF3?=
 =?utf-8?B?NHd3dE9vRGZMOW0vcnpPb3BBMTFGL2dCNU1kWS9hQXMrSUhyOGI2VG9aQkd2?=
 =?utf-8?B?Z0E9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c31ec53-78c1-4c85-a5e7-08dc74c58269
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8531.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 09:58:02.8132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TdIbX8OlPub8tIwHo0hsSbJY1x5lyMwaukf+6WoYJ3QEmTeQ/+EqD7vi7HSOjvQLU+I0SyYDe/D+pmYffY3iA0soDnPtVdqz76wRI0tfdNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5089
X-Proofpoint-ORIG-GUID: vSyO7mFeK2qpNsROj2nfMS1YtcOVpJbq
X-Proofpoint-GUID: g2xj4fUWl-N0en45yQv0_7rL1rFFS9UI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_04,2024-05-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 spamscore=0 suspectscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=688 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405150066
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 May 2024 09:58:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16222

Hi Quentin,

On 5/15/24 17:35, Quentin Schulz wrote:
> Hi Robert,
> 
> On 5/15/24 11:26 AM, Robert Yang via lists.openembedded.org wrote:
>> From: Robert Yang <liezhi.yang@windriver.com>
>>
>> If the repo on server is foo.git, both of the following commands
>> will work:
>> 1) $ git clone <url>/foo.git
>> 2) $ git clone <url>/foo
>> But only the second command works if the repo server is foo
>> (without .git suffix), so try without '.git' suffix firstly.
>>
> 
> Shouldn't the SRC_URI in the recipe be fixed instead of the git fetcher? Which 
> use case do we need to support here? Something to do with mirroring maybe
The usage is related to repo command + http/https mirror:

* The foo.git on http/https MIRROR works with do_fetch
* But 'repo' command always add a '.git' suffix to the reponame, the foo.git
will be saved as foo.git.git on local disk, and do_fetch would not work with
the local mirror.

Our solution is rename foo.git to foo on http/https mirror, and apply this patch
to make both http(s) and local mirror work with repo command.

It's a little special to our Wind River Linux, and we need send the patch to
mailing list for Yocto compliance.

// Robert

> 
> Cheers,
> Quentin

