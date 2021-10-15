Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F755C433EF
	for <webhook@archiver.kernel.org>; Fri, 15 Oct 2021 06:24:40 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web08.6077.1634279079081710492
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Oct 2021 23:24:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=KCa/fS/6;
 spf=pass (domain: windriver.com, ip: 205.220.166.238,
 mailfrom: prvs=5922da58ec=qi.chen@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19F6MFKO014457
	for <bitbake-devel@lists.openembedded.org>; Thu, 14 Oct 2021 23:24:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 mime-version; s=PPS06212021;
 bh=7hYvDJWotYsD69SASj4tx8pkzt/a9GIjTkae1t4InkM=;
 b=KCa/fS/6nwExKyBZVAPHzkCSJ9SZVpYBzlT7orbMC/D7CVBHNPBbASm4m+qBdpc4Sng5
 +ae0vgilY/vfdU58DUcpt/HED/zZEQ2WOHe8Q0puIIJven4bBAl7keoanKtF3afcqMMn
 ckUqUGaBFnvXkG98HkymJKWrzLSVgEbIyPqSDwEpAiRTUUY4RYkm++9/GwdrmnsW68UR
 UXMCbTeAqNVuP0zOfch4Wk7HV807Zrg+9u+UUqGg7pnX6eloux3FtJzmd6AAyzTQ5e0z
 IjyRV/dPtHq4P6BbMOH97nY43CJ28/vqtN+5cOp405DnB12WTg3H8UEOIhCNRwWFa0Fz 3g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com with ESMTP id 3bpbdq17u9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 14 Oct 2021 23:24:38 -0700
Received: from m0250810.ppops.net (m0250810.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19F6ObpY019103
	for <bitbake-devel@lists.openembedded.org>; Thu, 14 Oct 2021 23:24:37 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by mx0a-0064b401.pphosted.com with ESMTP id 3bpbdq17u8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Oct 2021 23:24:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEXB/3FTPdSlovsi1e/V6pTCu5wBgROZz59yS9dluxq1aXsFsvcyTltpf2/ftrHB7nEj3XVVZoZ5DPsGLQwYrsZUOTi3Sr+aeLLuiXbfocsqZlDfLSjM4ePAhnF+iqkW/Gc+/t8p1jX8B91dgTXirfzS5hOezuHpH4sIbZ6JNmCQI3vgQQu6q7evJlRpeiLeW9N4QhZROt3S0otzlcv4vqAaWMVmIEE5++XlxdtmJCkNYLLcRNKiD9L2OeBbEc6xTvOyo7e4cmTpSAMgo3necEzCRbdr1DUVse4z30t2XxNrfmfXqjsdyaueRH973qLeiBnz+VN0/gEDl4WGWOO77g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hYvDJWotYsD69SASj4tx8pkzt/a9GIjTkae1t4InkM=;
 b=WKSQi2vEi493MfVRspLvlzsVasZzZ9bBcDyGmRp1j9/WrKCVbkf6M2EsyztYoHROK1sbrpv/J/tKPMrPSMlWjbYJUI5ZXj8KPXmk+5MEelt4w18HqVdQq9h/ekXIy1hcEVtInswMwPVvmgUkbNP8yZR1QS0I8Fs+Hmodd5ap7SAygoXjAOFpSj0uHUua8q0+d+8jDKSVUDusggGd4AJ+cq73FnpflWEtiejJ/65lzNY3RS0e7gs/DvqTChkQsDLwNcpz7fkY2jPKTfsjsa/e78FhO+9bESpBCu3bc6ADP6q7gqzZhQmVC/n0x6q9XObE6ZN1L6rLcUNgzUWJoWf/vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: windriver.com; dkim=none (message not signed)
 header.d=none;windriver.com; dmarc=none action=none
 header.from=windriver.com;
Received: from PH0PR11MB5611.namprd11.prod.outlook.com (2603:10b6:510:ed::9)
 by PH0PR11MB5596.namprd11.prod.outlook.com (2603:10b6:510:eb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Fri, 15 Oct
 2021 06:24:34 +0000
Received: from PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::9d20:68ca:19c3:803f]) by PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::9d20:68ca:19c3:803f%9]) with mapi id 15.20.4608.016; Fri, 15 Oct 2021
 06:24:34 +0000
Subject: Re: [bitbake-devel][ 1/3] bitbake: fetch2: fix premirror URI when
 downloadfilename defined
To: Scott Weaver <weaverjs@gmail.com>, bitbake-devel@lists.openembedded.org,
        Richard Purdie <richard.purdie@linuxfoundation.org>,
        Kang Kai <kai.kang@windriver.com>,
        Robert Yang <liezhi.yang@windriver.com>
References: <20210905222738.1050768-1-weaverjs@gmail.com>
 <20210905222738.1050768-2-weaverjs@gmail.com>
From: ChenQi <Qi.Chen@windriver.com>
Message-ID: <e1ec0d83-b890-543b-8abc-562606f0d17b@windriver.com>
Date: Fri, 15 Oct 2021 14:37:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
In-Reply-To: <20210905222738.1050768-2-weaverjs@gmail.com>
Content-Type: multipart/alternative;
 boundary="------------7786DB2A246FAFF0E40EC0E2"
X-ClientProxiedBy: HK0PR03CA0116.apcprd03.prod.outlook.com
 (2603:1096:203:b0::32) To PH0PR11MB5611.namprd11.prod.outlook.com
 (2603:10b6:510:ed::9)
MIME-Version: 1.0
Received: from [128.224.162.145] (60.247.85.82) by
 HK0PR03CA0116.apcprd03.prod.outlook.com (2603:1096:203:b0::32) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.20.4608.17 via Frontend
 Transport; Fri, 15 Oct 2021 06:24:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 210fb57a-65b4-49f9-9b3d-08d98fa474a0
X-MS-TrafficTypeDiagnostic: PH0PR11MB5596:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<PH0PR11MB559684AE4335B3C89C9A09DAEDB99@PH0PR11MB5596.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	SxO8nULErO7iNXvnxfPcr2XjQFdDVdPtQrUpHM55IFF8Ap7vsJXjPK4KNdWvMR0Nksh4kfQy+3GKgQ/vlIBj6GUZnV42Z9kuC6PS9sh6e7O0TkAWG4P9Mtg92eHIiMaAhNnOwYPgDXGhRseBIOIxo6ghFQMPX4B543I+pxv4WTunsHzurKo/5+g/lNoSAT+w0jZLwRB2jM71fUKvHYSpBedGnjnm09ml2ixIVxvLg1eSO+w8rxyo85fET78WhAOSjyExT7nZZEhWgI+NwM+RBQl3dtQME7QMssG0gZ4NTveV6ZfCkC5FTTHEo/ULtqAdm9SRXVlR/9av1z4jBm0pEn2SSKfIwIS2y6e2EjDRRZ6YXVQyZJ2ssZWKvNyans+0s++X1c1VDzMmCzqIHuINW+fko9prSXe9jLoNPI0CEL/95J2YU0478ww9JS/+PEcGiK5zlqhDx1MZ6NTaQqA57wfIiBVAyk2CDdT+rbvDjb6I7jGbC+kcepwfpg5rTjb50R1Okn2iy5cwtMKBNKMAasZj/QHmUU7PTWssyqFHj7XLI4h8rFGdpwd51QxDljgU/xfxPBlOLc9yRSoKIxcCAoObwY856ILaUdmUQqgYO6uJVIhazA9fS9XghTPAGPrCqZ40lYj7WrStVHvo2SeIVkjJprOZFIzrcQK0T+HuDm8UlM9clOazljAsG5j5sGq6kiZ98FvvhhH6HEaZH7CbEGhPicCn/zc2yscRRBjpOBFeeuPhBB09vDOwlmQpMxChW1wIKWHta9VXhqE+YuSDmVZEfneGyEsFlB7PC68gL+lTRqlAa6B+L+Y2+flAFhGB6RUk6v+ZKIKEUND+x4Xzm72k6jPbVtaPP/WYoBcHoyj0w4fTDiPrR1AzNtiB/LbCsghwDjqy829TtLYmF+qRJMpSCFoo/6gS85zl7JhpGNY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5611.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(166002)(956004)(8676002)(2616005)(186003)(36756003)(6666004)(8936002)(5660300002)(86362001)(31696002)(66476007)(83380400001)(52116002)(2906002)(966005)(16576012)(6486002)(38100700002)(53546011)(316002)(38350700002)(508600001)(26005)(6706004)(33964004)(110136005)(31686004)(6636002)(66946007)(66556008)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WkJOR1JoM1FHZFNHUFUweTRnMkxlaUNkN0IwdlE4RkM4bVpFZDhqMzZpbmZs?=
 =?utf-8?B?VW9kL3BldnprMmw4OHBCOHR3WXBEczFVck1YY2JYQXphMHJFcDRGZUlUYWd5?=
 =?utf-8?B?RnBZWEZubWlkdndXME9wZFZWUENMN1l5aFdWUkYvb2ZMUURUcXdsRFgyUjRs?=
 =?utf-8?B?VWZRemNTQVo2R1FwRmRqZFhGTzl5U1BYQVBhL0RleHVjNHB0Q1pDbzROcHdW?=
 =?utf-8?B?ajJDWm1nL1BsQndrOVBtZmFCN0VWd0dpZjJnejNEakZPWFU0NjlOOEEvdmcz?=
 =?utf-8?B?TWtldXJuVjRWR09teXAzTVJNTk9ETi8vTFR6YStBRmlCaTNVaG1aQS85VlpK?=
 =?utf-8?B?a2piSG9UTHVLemcwU0NJZjluallxVGY1em0rRTkyRWpTQ0JybnFPYzR0REdB?=
 =?utf-8?B?ZzJrOTA3cXdnd2FmdkhZQWVHMWVtUHB2dnA1MHpIU0xQRnFUcVM3bzU3N05T?=
 =?utf-8?B?djlja05FdmRHbGtFVVArMzF1L01HRDhYUVhCMHh3QklEa3V5azlYa2ZRM0Yz?=
 =?utf-8?B?L0swTzMvS2g3Sy9HK0FZUWJzMGdscEJnM0wwbW02aGo1M2thdDJvNlpPdzVX?=
 =?utf-8?B?aytTYVh6cE9LNWo2RTAySEJha2hXMFBSN2hBbnZoUHQxZFB1OE5qYkYwR0NI?=
 =?utf-8?B?azZVYW1sU1htNVF5NFptdUNyUW04VWhFN0RqaGlhN3FNTzJCUXpYUmtOOWV1?=
 =?utf-8?B?SlA0N3VnQTREUWROTHJGdyt5NlJaeFd5NmtuNVc4SDdTcjI4N2xUU3VjOGhm?=
 =?utf-8?B?N3Y4bXNURXRRZlFsRW1UYVZXWjV2UEJERHBqeTlFVnJ6RXpET0wwSllBczQx?=
 =?utf-8?B?NWpsbUZBMnRVcEpQU09Ca2U2cmNCcVdiYjM2eEVObkljakQ4NHhFTldTdFRP?=
 =?utf-8?B?UVNPOFUyd3N1SWFUNDl1RGtJQldxOEJkYlFnd21NNmZudy9DbXJITVQxY2ZY?=
 =?utf-8?B?Qjhza1RaMHV5b0JkMmpqbE9EOFQzQ3pQZEQzWkVoUURUemdReWtFS0F1U005?=
 =?utf-8?B?bHJWUVRzaGRBQzRYcHRDa09DTENTWnRUSS9Kck40L1dMTGJNVW9SSmcyRUNZ?=
 =?utf-8?B?VDJjYkV0UG9PQjRaL1Y5ekwwSG1NdlFXclplaTgxcEdUd2FGQUxMazRERGw5?=
 =?utf-8?B?ZmNFeTJQRmp1TjZOZHFYYjJvWWdmMzByQ25ndVFsNDNhUzhhbmVudi9lVENp?=
 =?utf-8?B?U2oxcks5SEE0aFVNQnJTSUFWSHB0NUJCcEo5Uzg5VFJrc2VwbDdYM2cwNXJt?=
 =?utf-8?B?ZWVubXBFWlhjQmgyZ3lFSzVGOXh5d1h0Z3ZKK0ROWmhJMGk5cE01MWFpRnB2?=
 =?utf-8?B?Z3ZoaHFtZjkrMEgwakx4bjhnbmlOSzlPaEcrMDN6a3FRampURzN1K3IySjIx?=
 =?utf-8?B?QWhNczh3WnZDWXViRlQ5R2h2cnlOeFp4ZnZHeUdacVBMT3NBSWQ1U1VQNjZ5?=
 =?utf-8?B?dDV0MlRBSjhQbXZmdXNoWUhMNkF5TDYzeStoUlNkRjlQOThqTXFTRGVvL2pD?=
 =?utf-8?B?MkorajFtYVlwV1dTREhGU2x3azZjbjlSdEkzeVpOVHA1L1B0WFFmQ2JwUVkz?=
 =?utf-8?B?L1ZLWHRmNFFsZkJGT0hGRmJTMUd4TjV6T0t3TVlhRGxaOGdZUERwZHpFL3BO?=
 =?utf-8?B?NlE1SGJTL0pZQUI0d3BjN1RhdGU5ZjB2ZEFGS2RxUGVKSEl0Y09DMTFFNis2?=
 =?utf-8?B?ZVQ4bDdOK1oxdGFqUEdicVlUaGdabFpUUXpQWkE3NjQwUVhzclVuVVlaWENV?=
 =?utf-8?Q?8WQM6HXoN8EJFniYXPbcLLpES14m/b8eMXLwYrw?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 210fb57a-65b4-49f9-9b3d-08d98fa474a0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5611.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 06:24:34.6773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 Cz79iFW4v5SMGOFI5NN0KavggE0Rq0UPYbAnOrNpA/9WujzZqiNyGkdTu7khCiQri5dKSgU5EsVU/oJXhuvuXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5596
X-Proofpoint-ORIG-GUID: FjuZNL4HTrMfDNnDetIFASps2wWfiVVv
X-Proofpoint-GUID: JqPcqHSSRj4H_c5qwqaa5d3pJupb_N-A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-14_12,2021-10-14_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 mlxscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110150040
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 15 Oct 2021 06:24:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12780

--------------7786DB2A246FAFF0E40EC0E2
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Scott,

I think the key problem here is which tarball name to be used for premirror.
Previously, it's using 'downloadfilename'. So instead of holding 
1.4.0.tar.gz on yocto's mirror, it holds freeDiameter-1.4.0.tar.gz.
Now, with this patch, the basename of the URL (e.g. 1.4.0.tar.gz) is used.

This at least causes the regression that a local download/ directory 
could be serve as a premirror.

I've sent out a patch to restore the previous behavior, it should also 
solve yocto#13039.
The title is: [bitbake-devel][PATCH] fetch2: fix downloadfilename issue 
with premirror

Could you please check if it works for you?

Regards,
Qi

On 09/06/2021 06:27 AM, Scott Weaver wrote:
> When downloadfilename is defined in a recipe's SRC_URI and PREMIRRORS is also
> defined using the same URI, the downloadfilename is appended to the mirror
> URI and it should not be.
>
> [YOCTO #13039]
>
> Signed-off-by: Scott Weaver <weaverjs@gmail.com>
> ---
>   bitbake/lib/bb/fetch2/__init__.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
> index 914fa5c024..47a4943369 100644
> --- a/bitbake/lib/bb/fetch2/__init__.py
> +++ b/bitbake/lib/bb/fetch2/__init__.py
> @@ -466,7 +466,7 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
>                       # Kill parameters, they make no sense for mirror tarballs
>                       uri_decoded[5] = {}
>                   elif ud.localpath and ud.method.supports_checksum(ud):
> -                    basename = os.path.basename(ud.localpath)
> +                    basename = os.path.basename(uri_decoded[loc])
>                   if basename and not result_decoded[loc].endswith(basename):
>                       result_decoded[loc] = os.path.join(result_decoded[loc], basename)
>           else:
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#12592): https://lists.openembedded.org/g/bitbake-devel/message/12592
> Mute This Topic: https://lists.openembedded.org/mt/85401309/3618072
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [Qi.Chen@windriver.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>


--------------7786DB2A246FAFF0E40EC0E2
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Hi Scott,<br>
      <br>
      I think the key problem here is which tarball name to be used for
      premirror.<br>
      Previously, it's using 'downloadfilename'. So instead of holding
      1.4.0.tar.gz on yocto's mirror, it holds
      freeDiameter-1.4.0.tar.gz.<br>
      Now, with this patch, the basename of the URL (e.g. 1.4.0.tar.gz)
      is used.<br>
      <br>
      This at least causes the regression that a local download/
      directory could be serve as a premirror.<br>
      <br>
      I've sent out a patch to restore the previous behavior, it should
      also solve yocto#13039.<br>
      The title is: [bitbake-devel][PATCH] fetch2: fix downloadfilename
      issue with premirror<br>
      <br>
      Could you please check if it works for you?<br>
      <br>
      Regards,<br>
      Qi<br>
      <br>
      On 09/06/2021 06:27 AM, Scott Weaver wrote:<br>
    </div>
    <blockquote cite="mid:20210905222738.1050768-2-weaverjs@gmail.com" type="cite">
      <pre wrap="">When downloadfilename is defined in a recipe's SRC_URI and PREMIRRORS is also
defined using the same URI, the downloadfilename is appended to the mirror
URI and it should not be.

[YOCTO #13039]

Signed-off-by: Scott Weaver <a class="moz-txt-link-rfc2396E" href="mailto:weaverjs@gmail.com">&lt;weaverjs@gmail.com&gt;</a>
---
 bitbake/lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 914fa5c024..47a4943369 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -466,7 +466,7 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
                     # Kill parameters, they make no sense for mirror tarballs
                     uri_decoded[5] = {}
                 elif ud.localpath and ud.method.supports_checksum(ud):
-                    basename = os.path.basename(ud.localpath)
+                    basename = os.path.basename(uri_decoded[loc])
                 if basename and not result_decoded[loc].endswith(basename):
                     result_decoded[loc] = os.path.join(result_decoded[loc], basename)
         else:
</pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">
-=-=-=-=-=-=-=-=-=-=-=-
Links: You receive all messages sent to this group.
View/Reply Online (#12592): <a class="moz-txt-link-freetext" href="https://lists.openembedded.org/g/bitbake-devel/message/12592">https://lists.openembedded.org/g/bitbake-devel/message/12592</a>
Mute This Topic: <a class="moz-txt-link-freetext" href="https://lists.openembedded.org/mt/85401309/3618072">https://lists.openembedded.org/mt/85401309/3618072</a>
Group Owner: <a class="moz-txt-link-abbreviated" href="mailto:bitbake-devel+owner@lists.openembedded.org">bitbake-devel+owner@lists.openembedded.org</a>
Unsubscribe: <a class="moz-txt-link-freetext" href="https://lists.openembedded.org/g/bitbake-devel/unsub">https://lists.openembedded.org/g/bitbake-devel/unsub</a> [<a class="moz-txt-link-abbreviated" href="mailto:Qi.Chen@windriver.com">Qi.Chen@windriver.com</a>]
-=-=-=-=-=-=-=-=-=-=-=-

</pre>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------7786DB2A246FAFF0E40EC0E2--

