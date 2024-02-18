Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C71C48BC3
	for <webhook@archiver.kernel.org>; Sun, 18 Feb 2024 02:30:19 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.11555.1708223412044475625
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 17 Feb 2024 18:30:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=pxz/+Kfs;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=2778647e52=qi.chen@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41I2S2Qd007565
	for <bitbake-devel@lists.openembedded.org>; Sun, 18 Feb 2024 02:30:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=message-id:date:subject:to:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=SriTAdKpDcIinXIRc7lZSIxq/SKbKVKF29BBR0S8eqo=; b=
	pxz/+KfshklXuRnn2eQYtX0u+V/gMsmf7UPEz1ens5+rJ9hunjn+TtVG3Y+pjJhD
	PtaAjedSIot/TxOvoxUlgCmlB+IX8qAaLXeis0kvryariUoqWj2YPDwVt+3Roj6U
	B+gYAz89Mb9BjFRK99ZgfWxYeAuRljRL7RVxoywbORnMYN9hRRQqOXCX3PNr57AN
	cpncDDPDom9x45LxkqSqb81+Uzthv3CyzMwrOV9e2Cio96ZAgMwprYCwWvG+btxa
	ASU1xZ/CmvjV5XOwXnUnTw6f9KUMFQPqCV4HWkN/25NDyvb4dmS0ZnBaTveEn+O+
	0vce0j7JCoamginvhHUpwQ==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3waks68mtq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Sun, 18 Feb 2024 02:30:10 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wd9wwu1FcUI2Ce61v2rRYh2AjUqfsNtsxnXCm5jlIbuRjlthKNHE4yeBKaAiFaIA4IT+sZY6tem8zmSEOYTZTqLfpEr8oDpwnc2rfQAof1FB7jeucI7kLObWybm88XMbHDr9GYUDn9LXAPiUFBgh05jERHrzabTaaclYP27RxVSsMTbG919CUMyBLmClOjSd/XxLq7qyzBg7yCyujKE/BTHeJSUf6RXIMl9OCYcfDTnbTi3xhTtHYRF3xm8dE5D/z1B9aLmQ3/c7CyG+Qin/8qPH4Adp5sxfY1mokpHj62dC2p0P2lLWhGvbZ5/UblaJZqoINwBydl+USvH4Y/frJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SriTAdKpDcIinXIRc7lZSIxq/SKbKVKF29BBR0S8eqo=;
 b=ay6i6c8iGegDa9P8fg9i/ZYmclZkfM/uJbqX/QYecqICO6JYMJEt5FH3mNug7G9+HSkFrJiDBqdvSiIrlUXG/Yk/EP9UgpC2jHnl3XFB4yPG8WGc+w6fSjQuzT+EUITzUBNi774RhxLjnV5gctKFgxDfbaFeEAu9D1BO4rvUf90zwrfBdjgUmdzPzLcQr//5LaX1EKufY8BahbX1pGYOimJk6leOup26ZU6tMB9NCGdZ6DFA9DJtKek+A5ELEf/EulbTiK2DlWQ+7WLpjofvucpWPpq9wlfSG4OI1YGuINVmf/64dLZt/sI1kTaMJApXQZfjLRkRPsG4k8LssiRqMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by PH8PR11MB7047.namprd11.prod.outlook.com (2603:10b6:510:215::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.32; Sun, 18 Feb
 2024 02:30:05 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5d84:2b01:5029:9315]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5d84:2b01:5029:9315%7]) with mapi id 15.20.7292.029; Sun, 18 Feb 2024
 02:30:05 +0000
Message-ID: <163e8e4c-60a1-912b-072a-89fadfe1e519@windriver.com>
Date: Sun, 18 Feb 2024 10:30:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [bitbake-devel][PATCH 1/3] fetch2/git.py: fix a corner case in
 try_premirror
To: bitbake-devel@lists.openembedded.org
References: <20240201033100.3617421-1-Qi.Chen@windriver.com>
Content-Language: en-US
From: ChenQi <Qi.Chen@windriver.com>
In-Reply-To: <20240201033100.3617421-1-Qi.Chen@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:404:56::35) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|PH8PR11MB7047:EE_
X-MS-Office365-Filtering-Correlation-Id: 8763b52e-b536-4128-418b-08dc3029846d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qMoukTlxFh4DH2t4ep/weZ6C0T4GogqI+Ihv/GCVIGTkJc7I3PP+PCva0bGoqzoJ9wauPjuxmwNRTDw39BW7mpKpg25p/DvYO8bg2gbwDdB1D/dN3xEwUXPeBUQikgMl2CqC9DSJECk2hQXxqCJllaiZBTxu1TRBhLrYgi2DpVpcX/Lhdn6MwpNnw+y6m2cqQKpKp6Zx+VNJfKBq7Iw1b265R3rafeerL/Xb+hOz/rUGIThvv7IuyUUBw83t7hfPLBZIMfe+m48TRA/C4/7uY0CDpf1Isw3TA5Bhuy+SUyyJXOqVEbuWoZzG9U7YE+jh3f/Yq9j3Ha09KSVSZPjVOGWfJSBmjMn31cLyTrX+ObKOIbWziKbbN2of41Jj4C9ACrd835yJfoDc8Bt5jL9TZYc4wdO1OZvsox83UN8AwSWYA8k9sEMjKvLevgBiWxAUaYffzXP+BrzoSbgx38++gxL9B5nGpE9066R/ZeLtr8UNEsnfsR9OOMjL9gdHqoR1pE+Eizy4wfthS+gYB4z++PKmWD6LJ7k04F923o2sOlQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39840400004)(136003)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(6512007)(6666004)(6506007)(316002)(6486002)(966005)(478600001)(53546011)(66556008)(66476007)(6916009)(2906002)(8676002)(66899024)(66946007)(8936002)(41300700001)(5660300002)(31696002)(86362001)(38100700002)(36756003)(2616005)(26005)(83380400001)(31686004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q1E3cjNkc0ZQV3ZlVnp2MXZCcTJTUDkydzVMOVhXak9xcUVmTnlHcFlLaWRp?=
 =?utf-8?B?MHhRQUJZekNGT1lHYjQvSFozY2JyMnA4bkNoTjVnSGZrNmE1bjZwczFlWDlw?=
 =?utf-8?B?a2l3NkNvaG5icW92SUZYYlo2S0FDaWpaQTFZZExNYU5KSUliUlYvZnE4MW13?=
 =?utf-8?B?UHNuR1pPRy8wblNwUXRrN0JNZUxybHR4RDQ0d2FTUDA1RUV0SjJudjRjU0FG?=
 =?utf-8?B?MXpXRTRjUis0UkJRSlV3V25Gd0EwMy9wUnVkbkhEMmROdWwrV1pERklEdFlR?=
 =?utf-8?B?U2Q0clJpVkM0RmNzenYrNklYazlZekFkZVEzVzVUYkwrU0dZazJTaExKaTVH?=
 =?utf-8?B?Y1hvZzNGdmtYWUczMkZDbXJHeTNJREg0bVlDa3lPczg5aVAzV0l1dUFEVlE5?=
 =?utf-8?B?eFBvWjUrTmJzRVhsZVlRS3hVU3RKNGZma1Q0SHhpTzdPd0x6ajRzTjRZbHNo?=
 =?utf-8?B?d3RmcWNDTVE3RnZIK1hNUTlpbVpFVUlIN1ExZHpTYjZ4d01TUUxrdFZaME9O?=
 =?utf-8?B?WUlaenBpM1lNVEVNNmlCYjZJNXlkdTJoY2pRZUVHekhWYzRSWFhoTWdJY3hN?=
 =?utf-8?B?VXRNU0kvTFBpYitTaWdpSnpSdmZJamlhRktGMzRwamtkZzhNd1IwVDB3WGwv?=
 =?utf-8?B?bW9LWEExUTZRWHV5bUE0WFVMSjN2RXcyUlVBU25QZFB0eE13TGM4c0V6amtu?=
 =?utf-8?B?RXVjVGRkRmRSOWF6dHJRMTZ2OE5mK01nTktMby96MVJuY3FwdWt3UWUvT0tH?=
 =?utf-8?B?alhwM2d3THBHOXpmM0VHVm1ud1VoZFNNdjBsKzFPWTA2TERDOEYwVHF2Z3lX?=
 =?utf-8?B?K1JKcVMxUVFBWHBtZGNrTDl0YWZ0SkthODhudi9xQ2RKQ0doYkQ4SHNONTRJ?=
 =?utf-8?B?T1VLUEFYVFRvVWRuOEdYOS81dk12c2s4cktnR0xBQkdvWEFlYXZsZWt3a2Jx?=
 =?utf-8?B?anYxY0tRL0lURHlHQlFjdHBZZlgwS3c0RDM1YjZRak5SN0NIMHoyaVFNSG94?=
 =?utf-8?B?UGZVc25UOFZJWGhGSW5wYkVLVXdURnVNdWMvMW5IZGgwSDRlRkk0WWpFZUNL?=
 =?utf-8?B?N00weFBrNExWaXk0bmhTWVJabDl3Z3RQa3VDZVhqbWNuRUdnbGErMGRNTmU5?=
 =?utf-8?B?cTcva3VHNVlMck1oL3RBM2M1NkFKVUk1M29TbGNsaDQvKy9MNmliU2FNQ3FP?=
 =?utf-8?B?TzVEcDIxVHVJSmk5Zk95NUgxakhmbXFTSVJSNmxhcGdqV2pOeGUyc0V1ZjJT?=
 =?utf-8?B?VmgrZnhrbHo3WTFmMlA4YlRyQmtQTG5mdVd5UE41YW16NW1DbDNBZEtweHNn?=
 =?utf-8?B?MVRuRHBLYVJvMHBrWWxIZmZSQWFyT3FoSHAzZ2Uzc3JkNi9lbVcwVmQyYTd3?=
 =?utf-8?B?ZzNRVEx1Q3l0WkJrU2xuT0o1SGlnNUhNYVk2c2czdDd1UXBLM2J6ZXd5bXRP?=
 =?utf-8?B?azNpV0dlRlFlVjBscVZObXZpNk0rb1IrbXo1QmRtWnh6bU5rOEVNUU9VNGd1?=
 =?utf-8?B?bGdpUHQ1OFMvUXp2VlJEVTFMUGs3VVR0U0pGbDUzMUpQS3A2S1lHK2lQK0dp?=
 =?utf-8?B?dm94SVZieFBFMHZkaFJScmY5aStaYUdwZjA5YUNUYnZVbStrQkUrRHcvdkNQ?=
 =?utf-8?B?ZGMyMUJrYmRvM3BSN2ZLNGpxUDBYZGh1T0t1bDVlRmFxQW9sL2E2dVh6aHZG?=
 =?utf-8?B?bUZrV25lYnh1M3dvTlVpQWRDQTFnMVdGYW5KWDdUK3NERDNvMUM5N1VvNmMz?=
 =?utf-8?B?Z3BVTzJubVdKSE1CR3l3a2w4QUdyL0dUelF5K082MXpKQ1JlcGpjczVLN3JL?=
 =?utf-8?B?L2Y4b3lzMmJnSk51TnkzajRpcU5JeUd4Q0V2R3lySU5WdkdoL3FUUnBjNW5s?=
 =?utf-8?B?L1pJUmlSUWw5VVVzMUlselFxa00rZVhKUkRKUE9nRkhUc01yOXZTMUE1VWR4?=
 =?utf-8?B?UHRXcXI2dHRNaExWK1lhRFdXd2QxNWR2WHVLL3Q5R1FERzhEbTVKWTFEU0hE?=
 =?utf-8?B?V2tCUlEvUEg2VTZ3Y2RVRVhUanhkL05HMDU4RkxCMS91VVdQNCt3d0JYbVlS?=
 =?utf-8?B?Wjdyd3lrUjdxcTBRRGNCTWQ4YmZrZXcrUE5hL0cxV2lyL09LVlY1VStSTXF6?=
 =?utf-8?Q?DQTBaokGIMOCd8AqqhduwmPub?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8763b52e-b536-4128-418b-08dc3029846d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 02:30:05.5174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BanAnK4xC/ruZNyNKMsMBIP/UOXjzz9n6vb7s2xqMFu7CHzmlQuBy7qbbv6mRsCR8b0ON5XrugsR7l5ioO5hXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7047
X-Proofpoint-ORIG-GUID: SyGQBWeT5lSiDTWkiPnEzX6jBa64IrDj
X-Proofpoint-GUID: SyGQBWeT5lSiDTWkiPnEzX6jBa64IrDj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-17_23,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402180016
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 18 Feb 2024 02:30:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15910

ping

On 2/1/24 11:30, Chen Qi via lists.openembedded.org wrote:
> From: Chen Qi <Qi.Chen@windriver.com>
>
> For gitsm recipes, it's possible that some URL is used more than once.
> e.g.,
> A -> B:rev1 (B is a submodule of A)
> A -> C (C is a submodule of A)
> C -> B:rev2 (B is a submodule of C)
> A anc C are both using B as submodules, but on different revs.
> Now if we have:
> B:rev1 -> D
> B:rev2 -> E
> Then, the mirror will not be fully used.
> Say we have all repo mirrors for A, B, C, D, E, then in theory it's not
> necessary to reach out to any network for downloading. But it's not the
> case. After downloading B(rev1) and its submodule D from mirrors, the fetch
> process continues to download C, thus B(rev2) and E. Now it finds that B
> needs an update because its submodule E needs an update. Of course this is
> true because E is not downloaded yet. Now the problem comes to whether to
> use mirror or not. The git.py defines try_premirror to return 'False' when
> the ud.clonedir exists. As B has been cloned, the ud.clonedir exists and
> try_mirror returns False, resulting in not using mirror and going to upstream
> directly.
>
> We can see that the mirrors are not fully used. This is usually not problem,
> as the cost is only some network download. But in case the following two
> settings are there, we get errors.
> BB_NO_NETWORK = "0"
> BB_ALLOWED_NETWORKS = "*.some.allowed.domain"
> In such case, the gitsm recipe A will fail to fetch. Note that all contents
> that A needs are in mirrors and now it's failing to fetch. This is unexpected.
>
> Note that the different revs of the same repo in gitsm recipe is not the only
> way to reveal this problem. For example, there might be a recipe call B that
> uses B:rev3. Check the protobuf and grpc recipes as an example.
>
> For now, we can use the following steps to reproduce this issue. To be clear,
> the grpc recipe in meta-oe is now 1.60.0.
> 1. Add in local.conf:
>     DL_DIR = "${TOPDIR}/downloads-premirror"
>     bitbake grpc -c fetch
> 2. Comment out the DL_DIR setting in local.conf and add the following lines:
>     PREMIRRORS:append = " \
>       git://.*/.* git://${TOPDIR}/downloads-premirror/git2/MIRRORNAME;protocol=file \n \
>       gitsm://.*/.* gitsm://${TOPDIR}/downloads-premirror/git2/MIRRORNAME;protocol=file \n \
>     "
> 3. Set BB_NO_NETWORK = "1" and then 'bitbake grpc -c fetch'.
>     This command succeeds and this shows that the premirror holds everything we need.
> 4. Add the following lines and then 'bitbake grpc -c fetch'.
>     BB_NO_NETWORK = "0"
>     BB_ALLOWED_NETWORKS = "*.some.domain"
>
> After step 4, the error message is as below:
> ERROR: grpc-1.60.0-r0 do_fetch: The URL: 'gitsm://github.com/protocolbuffers/protobuf.git;protocol=https;name=third_party/protobuf;subpath=third_party/protobuf;nobranch=1;lfs=True;bareclone=1;nobranch=1' is not trusted and cannot be used
>
> This patch fixes this problem by handling this corner case, that is, if the URL is
> not trusted from the settings of BB_NO_NETWORK and BB_ALLOWED_NETWORKS, then we should
> try premirrors because trying to reach upstream is destined to fail.
>
> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
> ---
>   bitbake/lib/bb/fetch2/git.py | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
> index 0deeb5cee1..322a9366da 100644
> --- a/bitbake/lib/bb/fetch2/git.py
> +++ b/bitbake/lib/bb/fetch2/git.py
> @@ -87,6 +87,7 @@ from contextlib import contextmanager
>   from   bb.fetch2 import FetchMethod
>   from   bb.fetch2 import runfetchcmd
>   from   bb.fetch2 import logger
> +from   bb.fetch2 import trusted_network
>   
>   
>   sha1_re = re.compile(r'^[0-9a-f]{40}$')
> @@ -355,6 +356,11 @@ class Git(FetchMethod):
>           # is not possible
>           if bb.utils.to_boolean(d.getVar("BB_FETCH_PREMIRRORONLY")):
>               return True
> +        # If the url is not in trusted network, that is, BB_NO_NETWORK is set to 0
> +        # and BB_ALLOWED_NETWORKS does not contain the host that ud.url uses, then
> +        # we need to try premirrors first as using upstream is destined to fail.
> +        if not trusted_network(d, ud.url):
> +            return True
>           if os.path.exists(ud.clonedir):
>               return False
>           return True
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15817): https://lists.openembedded.org/g/bitbake-devel/message/15817
> Mute This Topic: https://lists.openembedded.org/mt/104090271/7304865
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [Qi.Chen@eng.windriver.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>


