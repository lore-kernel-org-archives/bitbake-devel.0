Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1D0C3DA42
	for <webhook@archiver.kernel.org>; Mon,  8 Jul 2024 09:12:57 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.75609.1720429972110315088
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Jul 2024 02:12:52 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=79195bc2f6=qi.chen@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4685x2hk004362
	for <bitbake-devel@lists.openembedded.org>; Mon, 8 Jul 2024 02:12:51 -0700
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 407170hbp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 08 Jul 2024 02:12:51 -0700 (PDT)
Received: from m0250810.ppops.net (m0250810.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4689CovT015560;
	Mon, 8 Jul 2024 02:12:50 -0700
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2049.outbound.protection.outlook.com [104.47.51.49])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 407170hbnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 02:12:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZO9k89djkHFSz52nfm3IFJwG8bzpFKZggJpjiCKaXRrhQObjd09OqMb03FSsvYlgPyCY57AdElzQksygBX+YfhVvyrLcwzrzhoUeMa97kDMCFPocl4MlRRvt6pKM7zwHGmZ1pwiOsTtVqaZOXc4o2AooEkVngEKZzkuPA9j2+mUpHOXHthEUDRWelYsb5Q55BdIt9uZPcexLy0MOs1aThbwtiKUB6Au9Po9tU5UZdFWCQwWIWPrnQ90EY18IT4s13q+KyEEg/InLudvs2rSuoGrEtHX79cQJ3+FsIJKuMOGFEI/zIqgI57jlw2jILtnV72FKX74B8Ns7GqfoG4BEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ic7dCNBM9A4oqsVdFcT7A4sqkn4KJw9qVCdLFVW+jso=;
 b=A7EnyHECTOXrd6Qm+ZzCOgRYBLQHLKi8dhsuaOqccJLlzyBJQmlsGiuXnoYGxutCYcl+oIquZS4vEPL4kFpQuYxopLQLMk7jaGgs8iZ18z8BCLoneEaRFxLdh26wAfSNmTyWu0nMx0t2tZT5Ev8F2gVZ+KBz/zHujebzDEcE1FeojOf9SPjoUnx6Ff227qfrWTqJa+biNJKx0pFYXNxOLZ4f7ocsQ/HOIQKhCnWalxnmDScNL3ijmwQvqO2aIlZahd8L/ZwZquTvH+o6pL2gXFjQqExApXvWlh8sT2Sw78OTPdF3D0i3PnygAXQPr3PWMDC4NTfcY5dpVn3b16mCGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by CH3PR11MB7252.namprd11.prod.outlook.com (2603:10b6:610:144::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Mon, 8 Jul
 2024 09:12:46 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::a7e3:721d:9cec:6093]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::a7e3:721d:9cec:6093%4]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 09:12:46 +0000
Message-ID: <0032b64c-7e46-dc46-d6e1-143ae3fef03b@windriver.com>
Date: Mon, 8 Jul 2024 17:12:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [bitbake-devel] [PATCH] bitbake-worker: skipping disable network
 when unprivileged userns is restricted
Content-Language: en-US
To: Alexander Kanavin <alex.kanavin@gmail.com>, changqing.li@windriver.com
Cc: bitbake-devel@lists.openembedded.org
References: <20240708081034.1474312-1-changqing.li@windriver.com>
 <CANNYZj9+c=BQ_zH5vXM35s2Sw=KTRiieprn4TNcWvOXY4xXV4Q@mail.gmail.com>
From: ChenQi <Qi.Chen@windriver.com>
In-Reply-To: <CANNYZj9+c=BQ_zH5vXM35s2Sw=KTRiieprn4TNcWvOXY4xXV4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP301CA0013.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::16) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|CH3PR11MB7252:EE_
X-MS-Office365-Filtering-Correlation-Id: 1056f5c6-5dfd-4c4b-1653-08dc9f2e219b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|4022899009|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UENsYzJWZWRXTm5MUjFFaUJTaVYvTHJYV0tyemoxakIvRXFMd2FzTEk2QkhL?=
 =?utf-8?B?T3ZJUktJSDZDYTFrU0hyT216SG44VmxsUUJueWZ1U2Q4d21YaG95WElKOGN2?=
 =?utf-8?B?ODd0SE9vT1RSaTlLaEdwbmxpYVRwekQrOXc3bnJrbmFIV0pHbTdnRjVkQWRT?=
 =?utf-8?B?eTRpK0hsRUNMSmNGZ3lqbkZScGZFaXY1RlBtcWlqczRaL25TVVhrMU9YbEFw?=
 =?utf-8?B?V1JrbmlRK2NLYWhMcnNmcCtxSzRUc1JKdmQ1QVluWHY4bHBnUDVocTBwbTNX?=
 =?utf-8?B?K0dMTDV3YmpMRzd4SGVxcFRjdzY5anpFREF5ZTA1bWFjRWFxcnR2aDQxQUNT?=
 =?utf-8?B?alBydk8xU0YzWC9LbWg1bnRSKzhWaHZUbUlZUExwbmZvMlMxdnBWZVVYV3hH?=
 =?utf-8?B?N09OSFkrQ3ZZbFkwZDRVZTBsODQ5N1IwN2gxckY1bVR5WTlwVVFYRytIcmVj?=
 =?utf-8?B?Rk5DWnVyYzBwZWVvODFZRUwrTi9aeHI4bG9mVUJIVkVrdkdYWDhWZ2poK2Fx?=
 =?utf-8?B?bnhzY29KYWJ0SXB4SVBaTHhOUnQvNHFmRjcxOUVMYU95eGFKdDFQUW5GZmM2?=
 =?utf-8?B?dXlNdWtaTE5XNDBpWS9GZ1p5aUY0ck94S2RjYkxDbnRITDI0NnpRTTQvVU9n?=
 =?utf-8?B?Tm1qejNZdnhkUXJEVVNIdXg4M3hCcGw3N0UrZmU1OE9ZSHhqZjFFNDArU0RO?=
 =?utf-8?B?SFZCbnNoNlpyZy9uMm5reU5tMmNDOTBpbGwzcEZPTkQ5NkVKUzZpcmtWaGZV?=
 =?utf-8?B?eHhIK2VKUDVPOTc2NmJ5akVQeEUxMDlOUEIxN0JxOXhXTjRBOG9uWnA5YzZE?=
 =?utf-8?B?R3lEUisxaThyTHR2REk5Y0Rsb29PRUkwSjBQL1ZoNndOOHNOOXUrcmVnOVFm?=
 =?utf-8?B?WEdhWWZ5WVUweU4rT0xPQnRMS1daR3hLaVB6Ym5RSVFrSkIyMVl5N1lsM214?=
 =?utf-8?B?VTNObVpHRjV4OFBrUk1EOXJmaHMxNU90K0FWRnpYU3IxMnZSVGl4Nk9aK1dW?=
 =?utf-8?B?VGYzR045enlYcDBleElERDlva1lDUHZhamZnQURmdm9YNm5TMXFCNVBhZnBt?=
 =?utf-8?B?VEFyTHBJbm1sN2lLUjNqajV5YzdKQXJTeERNRENSZlM5K2liSFc0dGVDQldX?=
 =?utf-8?B?TWtMNTZ4TVU5K2hmRkpoWWdaRkRJQ0R6QVgvNm5mVEJ2bTF0cXJsMDBYVEtB?=
 =?utf-8?B?MWVDSTdhRjljaUFNWTFLTWtVVTVFSTlDVFIvTGdYTTViV0pRRGZHUUtEdVp4?=
 =?utf-8?B?Q2F3ekNSajdhaWNCS1hDck5uSktiRzFkY0FKejZsamlqdjRsQ0VNV29mbmtW?=
 =?utf-8?B?RUZaYXgrTENPMWFmNlE1bTJmRVVUa2hVWWora2N3TVZIc09CWEV2Vm4rQ3Zz?=
 =?utf-8?B?RXNNOHg1UDIyQmY3bitaNWh1YVRMNWYxbHlaRXplS2hJMFNlcUZaNHNmY0FJ?=
 =?utf-8?B?cTJTc09Fd1k5TjExR3VFTi96azJyeHByY1JBQVU5MFpkRnlFNCsvVld6VktB?=
 =?utf-8?B?SkRXWnVkbHFIcHcxL2M4S2dpeUV2ajlrUWJsV1ZPMmkxRjFNVjBGaWxkSUxV?=
 =?utf-8?B?d2pHTG1jSFFnbXFvVW4xUE8vZFBYZkMzR0J2TDI3VElnWFJZWUlPT0MrNW9t?=
 =?utf-8?B?MDE3eFVXalN5NWxhamkzRFFFMVE2ckNzLzJ4azAyZlhpL0lpeXZ1NU5IUnJG?=
 =?utf-8?B?Ukdqb0l1d1VFRmNibDNrYmxEbUlKUGtlM2Y3ME03TG9QZWpaMEU3SmdLTmJ5?=
 =?utf-8?Q?YZQPOM3z3FzE6+MWcs=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(4022899009)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MGJzaitGUm9FVG5xb1Z0VUs1akRVYkhlQ0JINHcrR1E3VGt3RlRXNTFJVi9T?=
 =?utf-8?B?K016QjBaVEJXT1Z5ck5MbDNQTlVYT3dQbWtBdnVBdEdyNE1BOFVjcUh5Uk1t?=
 =?utf-8?B?SHBzQURpMzlENXVzbnFTbUxUcjNkTXJKZXhOQWxFL1NycEVValNlTlZwckNW?=
 =?utf-8?B?b2I4YWpIaDlWVytwVjZVVXhvN2ZWYXAxMHNwYkdsRjdreDIzU2I0R2NMWmU5?=
 =?utf-8?B?djV1dWdxTENGcUlpbFVHdGVoZHlFeWFEdGxraWZ0UnAzRnlqK1ozUEZ5ZGtm?=
 =?utf-8?B?enYwamN6bHZ5bWloZDZWaDg5clBFZHdJMUxteWdaV3oyckRqZ0R6am0yazl0?=
 =?utf-8?B?TnVIUG5HVUY1Qy9reFRxVUZ3cEhyN244NFNqbnhNdXhmbW9hbThPOFo5TFRr?=
 =?utf-8?B?S01scUo3QWNZUHdKV01qL0hlcS9NQytlVTlQTTltZXlEejNqTktOZW0yeS9q?=
 =?utf-8?B?YXVwdUtsTFh3N2tZcjIwT291NXFUODcrRkRzbnFFckdlTDljR1V5QU1Zck1X?=
 =?utf-8?B?dGl6UWFmc29aYlJNSWZNRG81enEzb0gxd2luWXBHNkxZVlFjM3pRVXcrSHRF?=
 =?utf-8?B?TUNpamVDVDRpeVowZmVrL0RvbXJOTlJRbmNEakQweU9UVEkrOHpJTmxQYXE5?=
 =?utf-8?B?cWZHMU9wREJaZnQ1ZTJBS0JUdlNhNHA3NjZiY1RieHZYOVh6QUVheEkyMGtM?=
 =?utf-8?B?RWhrTTBFRjBneFVaS2JzcUpHckZTVnFOZWNDRUVsbXl2Sy9oV0svOWpFZVpk?=
 =?utf-8?B?WVh1blNLTXFRUHhNa2JRU3hDWld5NEl2dkhCUnIyWU1QTzVpVEJFNUFQU2ps?=
 =?utf-8?B?SjAxaHpEc2pra2o5VVhSb05QZ3Q0NEs1eGZyVEcyMWltQlNwUCtnYzlXTlZo?=
 =?utf-8?B?Tk1oQU5NMmRVT0Jva285bXhhb2E3MjRGT3ZxaFo3UUs1OElRZURVWEFISm9D?=
 =?utf-8?B?Z2FvVTFFY1o4UjcxZ3VWVk54dGcyckh5UEwvU0wxSWcwczZGYkdCSXRZaWEr?=
 =?utf-8?B?aitGSEZ4NHI5dUdpb2ozbUR2MXY3S004RVhIb1NrZVFGc05CdG1ScGY1dGh6?=
 =?utf-8?B?em9NVUxDK2Jra1U2ZWt6Y2RPaS9wZi9TMXpPejVJeW1BUUc2SlVwY040WUxj?=
 =?utf-8?B?VGJnSDgwajJKV1JlY0VUeDR5Y2tGU0oxZGxoTS9BM0hGclk5bEI0TWVwNGs4?=
 =?utf-8?B?S085WWtLVklKaTlLLzhxbzFIb2dBRWF6UUliSXRPYTFpK3lTQVpqaEJZTXZJ?=
 =?utf-8?B?blFobXpTK0FITFg1N3hXYk5zWVBKZWlOVW9GVUdvdlZ5TzhSR1lvR0FCWENn?=
 =?utf-8?B?REw5cHU5RXJNTXJ3ZmFVeFpCb2pVcjV6WC94QUVWMzRFeUZXa3BMNCs0L2ZC?=
 =?utf-8?B?MW5yaU56TWc3VjI4ZERtU09LeVlzNWFtRWNaRGFWbXFoU0NiT3V3STYxZE5K?=
 =?utf-8?B?emM1V1ducm9BS2h6K0phQzNTdFJObDlSTlV4YlpyMFhtUzd3TG9MdkNwQktL?=
 =?utf-8?B?bFVmL21heWlYUWdXaUVTcFlXZVVOOXk2QTg0dmlkSW8xRzlVRlpJcCtGT2lB?=
 =?utf-8?B?OVNKT0hOTTgrVUUyZjlpRC9RUEViY08raGczODF5MktnTjdXbi9ISnBNcjJT?=
 =?utf-8?B?RnpTbEpwQ2E1L2taelhubHdIQ2wyWU1wU2VIM2ZZODExNlVpWUExaXdMUmU3?=
 =?utf-8?B?RmVXc3hvajJQRDZiS1JkZzB3eDgzV1I3WE9tak40THMxdkN5b3BWVU1mMS9x?=
 =?utf-8?B?eUErbzlBU09OZVZZZ0g4UHV4cHAxS3k2cjNKaTBYV1hBeWEzS1ZBVHBsTDJT?=
 =?utf-8?B?L1pFNUtOL3EvUThaWkVVdGRXelBobEhQZUh5TDBoeFRFaURrSHZrN0s1eFh2?=
 =?utf-8?B?T29YdWttWG9JcXhTMjRGQ3RwamFwb3dyeXJyMG4xT1dNVXRsQjd4clBzOUNY?=
 =?utf-8?B?ZnpEeGorWnFlQkk0MVlQSFZNcThvMUxYdnZuUllLSk9sL05rbTFCYkpvdDhm?=
 =?utf-8?B?WkUrYXpWcHcrM0hUVHlDSVMzMXVwRUIwSHkrNDVNV1JRKzNlN2VNVnp3UUxF?=
 =?utf-8?B?SnJvU3BuSVJHTGlEb1A3UUs3UWd6Rm5GVUZQSVNUekRzY2kyeGhDelMzOU1R?=
 =?utf-8?Q?gjG8Xvk0Cd/tLxl+tbkiHsTZE?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1056f5c6-5dfd-4c4b-1653-08dc9f2e219b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 09:12:46.3372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xP8rTahwT4g1zdK+WiNI4j94qOAtLtT9ACBALQS6EFfHzNfoOcy8rXZn9+4OgJSOH/lEE4neitd1Rwc+JzW5Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7252
X-Proofpoint-GUID: x2wXiJrjhGOpA8zG2ZkRytdwTXbsc0J2
X-Proofpoint-ORIG-GUID: plpXks1Cm53DCsOE_BL_NIfeVDltZL0Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_04,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2406140001 definitions=main-2407080072
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 08 Jul 2024 09:12:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16399

On 7/8/24 16:36, Alexander Kanavin wrote:
> Should we rather direct users to disable the apparmor restriction?

How about an extra patch for the env init script to warn users about 
this situation?

There have already been some check there. e.g.,

py_v38_check=$(python3 -c 'import sys; print(sys.version_info >= (3,8,0))')

> I
> don't think an important QA constraint in the bitbake build process
> should be automatically disabled this way.
It's a best-to-have feature. It's not 100% necessary to have an image 
built out. There's already a is_local_uid check that skips network 
disabling.
> Wasn't there also an upstream discussion/ticket with ubuntu? I'd
> rather have this resolved upstream.
Frankly I'm not very optimistic about Ubuntu solving this problem. We're 
on our own.
>   Disabling the network check
> instead isn't going to help that.

Hopefully we can lower the barrier for people to use Yocto if possible, 
even if they use Ubuntu24 and know little about apparmor.

P.S.

This problem has reported to Ubuntu for 4 months. It was discussed on 
the Yocto mailing list. People seem to be waiting for Ubuntu. I'm not 
very optimistic about getting a solution from Ubuntu.

Regards,

Qi

>
> Alex
>
> On Mon, 8 Jul 2024 at 10:10, Changqing Li via lists.openembedded.org
> <changqing.li=windriver.com@lists.openembedded.org> wrote:
>> From: Chen Qi <Qi.Chen@windriver.com>
>>
>>  From ubuntu24.04, apparmor is enabled by default, and unprivileged
>> userns is restricted, which causes following error when bitbake-worker
>> try to disable network:
>> Traceback (most recent call last):
>>    File "/poky/bitbake/bin/bitbake-worker", line 278, in child
>>      bb.utils.disable_network(uid, gid)
>>    File "/poky/bitbake/lib/bb/utils.py", line 1696, in disable_network
>>      with open("/proc/self/uid_map", "w") as f:
>> PermissionError: [Errno 1] Operation not permitted
>>
>> Like what we have done for non local uid, skip disable network in above
>> condition to avoid have to disable profile unprivileged_userns for the
>> host or have to config a profile per project
>>
>> [1] https://lists.yoctoproject.org/g/yocto/topic/workaround_for_uid_map_error/106192359
>>
>> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
>> Signed-off-by: Changqing Li <changqing.li@windriver.com>
>> ---
>>   bitbake/bin/bitbake-worker | 15 ++++++++++++---
>>   1 file changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
>> index e8073f2ac3..0a042fdc7c 100755
>> --- a/bitbake/bin/bitbake-worker
>> +++ b/bitbake/bin/bitbake-worker
>> @@ -272,12 +272,21 @@ def fork_off_task(cfg, data, databuilder, workerdata, extraconfigdata, runtask):
>>
>>                   bb.utils.set_process_name("%s:%s" % (the_data.getVar("PN"), taskname.replace("do_", "")))
>>
>> +                def skip_disable_network(taskname, uid):
>> +                    if not bb.utils.is_local_uid(uid):
>> +                        logger.debug("Skipping disable network for %s since %s is not a local uid." % (taskname, uid))
>> +                        return True
>> +                    if os.path.exists("/proc/sys/kernel/apparmor_restrict_unprivileged_userns"):
>> +                        with open("/proc/sys/kernel/apparmor_restrict_unprivileged_userns") as f:
>> +                            if f.readline().strip() == "1":
>> +                                logger.debug("Skipping disable network since sys.kernel.apparmor_restrict_unprivileged_userns is 1")
>> +                                return True
>> +                    return False
>> +
>>                   if not bb.utils.to_boolean(the_data.getVarFlag(taskname, 'network')):
>> -                    if bb.utils.is_local_uid(uid):
>> +                    if not skip_disable_network(taskname, uid):
>>                           logger.debug("Attempting to disable network for %s" % taskname)
>>                           bb.utils.disable_network(uid, gid)
>> -                    else:
>> -                        logger.debug("Skipping disable network for %s since %s is not a local uid." % (taskname, uid))
>>
>>                   # exported_vars() returns a generator which *cannot* be passed to os.environ.update()
>>                   # successfully. We also need to unset anything from the environment which shouldn't be there
>> --
>> 2.25.1
>>
>>
>> -=-=-=-=-=-=-=-=-=-=-=-
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#16397): https://lists.openembedded.org/g/bitbake-devel/message/16397
>> Mute This Topic: https://lists.openembedded.org/mt/107099079/1686489
>> Group Owner: bitbake-devel+owner@lists.openembedded.org
>> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.kanavin@gmail.com]
>> -=-=-=-=-=-=-=-=-=-=-=-
>>


