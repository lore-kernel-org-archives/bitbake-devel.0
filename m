Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9B9C433EF
	for <webhook@archiver.kernel.org>; Wed, 27 Oct 2021 01:46:53 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.5975.1635299212226686636
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 26 Oct 2021 18:46:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=XI8mOHl1;
 spf=pass (domain: windriver.com, ip: 205.220.178.238,
 mailfrom: prvs=5934ff6c8b=qi.chen@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19R1eRQa004446
	for <bitbake-devel@lists.openembedded.org>; Wed, 27 Oct 2021 01:46:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=subject : to :
 references : cc : from : message-id : date : in-reply-to : content-type :
 mime-version; s=PPS06212021;
 bh=gcGIT+WD1GA+lg/+oi0C3ThosXhhu0cwDfqEPeg9smQ=;
 b=XI8mOHl1VMMtxpCwQ9nxcsTmRsOQZjO34jqRYOVkesKrMk/IuAidqqFvTJ7c95R78C+P
 yUE7QvEcSJlq2wIBwIaUgG6dFC+C0zx346nxWVTQh47WcUqW9ls5Q4/43OpWAc7+DPMZ
 otdW2JVlXQ5Cj/vWmRXhJZTQ+ZZYuF+BYwdjNCDReJh2SWQD/k/TFVMvtzxQ7yxhXrtv
 7i8rgHAvHSa2QfHta6V35DH43AScOsKtcflsN2Qu8XeqbuIVaBOWHZtLbYaNg9CvZo++
 eGM+Wu/qTXurCsHpu12gB620UVXsyEXP8oMiHN0Hf6f9cIrdqQM7mkTm4dquMaOmQyYT 9A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com with ESMTP id 3bx4egs3xp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 27 Oct 2021 01:46:50 +0000
Received: from m0250812.ppops.net (m0250812.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19R1kobT015304
	for <bitbake-devel@lists.openembedded.org>; Wed, 27 Oct 2021 01:46:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by mx0a-0064b401.pphosted.com with ESMTP id 3bx4egs3xn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Oct 2021 01:46:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/VxyYWrOrYHDXuU0FX10/86PBVc2VqNihxyCyOxNOGMYnwlq122PlQg735MKul01VPYWEdiItvUAngf0axUZ6Cp2XpaahaQvBLyoTCoPMdwy0xlGRCZT5R2ZyzJiWhWZsnKfQFN19AvmFRXpckSOjx4r3GQG6rTLB745nKiKHrupKSpXmrlfD0zWlrMvnZU9OTndgYbDdbVK3BcOHNKAeWrTlxXXh/yTMSaK/F50igt4HmxoDnkyLGDz17NFKR84tLGbYpSw0396x4GHmmIYxCdW+anzUobiAppo3wntKIPQMPFNN1gmDWSF67wt/a6crSuvl1PUyEuj6iWqoeJZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gcGIT+WD1GA+lg/+oi0C3ThosXhhu0cwDfqEPeg9smQ=;
 b=IJtIcD1XF2X3u5pKsKvE8woquePmvMa4Bfb9PuavdVkCcAz16NEVwuXTznOHshajA5KptDEq6DEcsmJwzBpKW1R1Mey0PWk+RLVWancuLI3ZnTi2pmyb/FCfG1KjqUuMMr29H0xUWoazAuOlbZ2BJv0i+/hKU6DxsycTwOra7BCBp6mSkigvYiAH3WVHATrifvTWOa4UyP1lIG/nvDoPD2lkBNXsvx1kfhZpY5Gr1CaHxUDWJt4xXy4jc/YFtEXf9pll58/tVKye+bPvJfKlj2xYa9hrcX7IssmKcvCrjAS9kqzcHXT/+2pi8u4erl54RyvtwISu0wzhoqYmATXD5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=windriver.com;
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by CO6PR11MB5617.namprd11.prod.outlook.com (2603:10b6:5:35c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13; Wed, 27 Oct
 2021 01:46:48 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::98c4:c603:2360:7b8b]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::98c4:c603:2360:7b8b%9]) with mapi id 15.20.4649.014; Wed, 27 Oct 2021
 01:46:47 +0000
Subject: Re: [bitbake-devel][PATCH V2 1/3] fetch2: fix downloadfilename issue
 with premirror
To: bitbake-devel@lists.openembedded.org
References: <16AF0338AE5E9F1B.30006@lists.openembedded.org>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
From: ChenQi <Qi.Chen@windriver.com>
Message-ID: <2788d484-ab73-6f5e-c7b0-deaec4670a43@windriver.com>
Date: Wed, 27 Oct 2021 09:59:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
In-Reply-To: <16AF0338AE5E9F1B.30006@lists.openembedded.org>
Content-Type: multipart/alternative;
 boundary="------------F7EB7F40115EC1946005DCAF"
X-ClientProxiedBy: SG2PR02CA0106.apcprd02.prod.outlook.com
 (2603:1096:4:92::22) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
Received: from [128.224.162.158] (60.247.85.82) by
 SG2PR02CA0106.apcprd02.prod.outlook.com (2603:1096:4:92::22) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.20.4628.20 via Frontend
 Transport; Wed, 27 Oct 2021 01:46:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 791a144a-6972-48a0-28df-08d998eba30c
X-MS-TrafficTypeDiagnostic: CO6PR11MB5617:
X-Microsoft-Antispam-PRVS: 
	<CO6PR11MB5617F2EF0B8C9D8D7AE3D978ED859@CO6PR11MB5617.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:551;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	3E7Xlj9zSu92gyjiskfltTo+cRCAdbSVIB5G5lNbp7W6JaZWqDOf4Pvm+m3xcllCxBauVKA+qxY4eF+M/mvhhojPMI0Tio6CXG112+dW3AVQ8ndwc4+7Gbu2T5kcU4xsJ1q1f7uw+lMlo4T3KvFWRAWHAM3aEd1pcXDuyCAUi8DpjrBvj6REvZHXvGwkbnebQomRA6rH2HraWa7eQoSk1b4E3yZzcwg0nNeWH16RqN1gUIrAg8YJPAyflP04YdbFC0XwuogH8XlDJnWU+vMNDXuT4NXy6YyeObYuF6oL9oFIBDvePLDkQzbhts58iFCthX4OpBOZGgfHFsiNMM27d1+OyRQZe0jrjxaWm7HM2doIUp4+D8KrXXv4gjaSkCouozuPZ/ez5i2F3S0eXM7gohVm8ZSjtyHEWB/Z+nqsz5Q43J7JP3XLywGDkPYveJ97aquQfG/5LkoXPIOysaDsIaBCy8WYpIHWGAi8AheF6zTSc2UwqNhp5L704L8w/I/AitNUoA5IFmUDCeKZZNN+vnfwKf+VAX2ecKKAndgdzoAFal3YkFiHUfSOpCOdxlifPYGbZnXd3YBDNTQQ/WUNt9jUBiuoo270+K7xEkCfnPfMIOD7vdLKAiwJcYi9tvomaUUYIPglEphZfuP1rSVn5JOxmIXzcxs5H6PNzvV0WfQGLXEt4pz85M2hlyYIo0c1PCXe5yqn1FMLKZNKvp/E6mHNdXVPDdMzYXpRVjYhHSttbmQdF2i4obu6F+5MvL1JxdRCXpDISJ/thiBG0gPttYbUiNmKlVtQSi0ePFrdKlef7AX+pB7svDiv3Ssz+0vfQNFx2QiRZXSpbicarDtpcOq0qdoG3PuGyHqRjX2JEpijfU9ziyeN/Eko/W8Mdq6wlhUagXofWA1QKot2q0fgGvZ08n5nLC2AXDCVOy4/cg0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(38100700002)(316002)(8936002)(6486002)(186003)(31696002)(86362001)(66476007)(508600001)(66946007)(36756003)(16576012)(38350700002)(33964004)(6916009)(26005)(66556008)(5660300002)(6666004)(6706004)(4326008)(956004)(166002)(83380400001)(2906002)(31686004)(53546011)(2616005)(966005)(52116002)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VTFNUUJlWEJRTUNiQ1Jzd05PMU5yN0J4UDRIaHVNMmFQWUxYdGtMZW1UV2RB?=
 =?utf-8?B?K0dnRE9PYzNWUnVDbFhoSTBPYkxSbjB6dlFuOUQzQlBwenF2YVV0ZWhWcnFl?=
 =?utf-8?B?azlXaDRueTQ4cGdIM2pBODVTcWwxQ1lteVVSWHpNRmFHMHdxUFpkZ1VvYnFu?=
 =?utf-8?B?TFVNc1JzZm5PVHRGRVl6ZFFyLytUWFFCa0NnNGRnbzJUWW0zS09PS0wzRWsr?=
 =?utf-8?B?Ly9Ndm9mK1pBbFR2ZnFlVnc4czFDcXRLMFhQUGFHWUJUN3kyRHFRamVVZ1dj?=
 =?utf-8?B?RE5KSEpWcjFheE1EZlNQVDVMYk9DRGdmYmdld1JhZGNRYWQramt0ZzhkdTla?=
 =?utf-8?B?MHFodmEzQWFkVmpuNEZPcG56ZDhKUDJIY3ltb1NjRnlsNUt0YmlsY1pHWXhn?=
 =?utf-8?B?dzJoOVZVNmk0T0ZpT0Y2TmJGdG9tT09mZml6SmMySERhY0NTbXBRd003Q1I4?=
 =?utf-8?B?ZXFxSzNra0Fkc2F4M3QxblpPK3hKUHp3R1hKaDB5azdsQjc1NW0wYTZDTDlj?=
 =?utf-8?B?K0c2WDJRUTZlVmtWelJ0K1Vta3RDUGZqNWMvd1FBN3B2eFQ4VENBVXU0MDFH?=
 =?utf-8?B?WmY3ejQ2L1pkelhrWDBhM2ZhZG1yTUVqeGVOWENJZUtBRXU0ZTNTdWc2Z0t6?=
 =?utf-8?B?SHVGZldDQ1U3a0VGTlhLVG9BMzFHcUdtbEhWZC9YZ2FmNnRSQUVVQysyVWZQ?=
 =?utf-8?B?R1k4aGZJaHQzLzlSUG9KT29jZEp3ck93S0tsd2Y2bmYvYWR2Y1JKbDlSOUNB?=
 =?utf-8?B?OUZ0MkEyQ0ZxWWw3WFExSnZZMTQ4UklUSHR5dXNWckh3b2ZxY1JjaDNMVUJl?=
 =?utf-8?B?RFFRTHpMUlhIWkFXL3BCVGVaQ2RWejlaZEk4Y2lTTkN6UmtST2FqRWlpamxv?=
 =?utf-8?B?ZlZSbVJRRmZMMDBRYWNVRGs3ZFlja0hIS2xrOWVRclRBZzVyU3pmU3pOUDU1?=
 =?utf-8?B?eDRWMmQyL1haNllQaTk5bFAxcmJlalNiUmF6VWtnOElqVWlrNVZSRUZOdFBk?=
 =?utf-8?B?WWxaWWdsZUt4RG9iSmRVVGhVTVVva3UwUHhuTHpxV1dwK0QvUUNvdHVxaFcr?=
 =?utf-8?B?aUZYeHB4VXVQWDVaOGd1bUU3aGtsQytQSm5PNm8rRklUcUhuMzl0M1ZnQUQ4?=
 =?utf-8?B?VHJGSTUxNGxBc0h3dUJ4QkIwQ0R5NktCazg0b0NFVllFSUhlTC9tVHE3MjVQ?=
 =?utf-8?B?Tmp2MHRhTDhISjZDYUFPSEFQRFBYUmpHc2RuaVliNENpWXg1R05sa2VraDY4?=
 =?utf-8?B?WkJhSEtpQ3lBNlBmbGpibGhwUVQvcWMxTEhZQWhoTkMzVEF4SitJbHBVZ1l3?=
 =?utf-8?B?ek5VYmh0eUhCeFA5dHZjK2xsVjlTT244Wk9QNnpVK3lodGpabjFLV2JSN3FV?=
 =?utf-8?B?OFgwVjV2by82Rm9QTCtDUXppZWdtNXZ3bFFqSTBuSVdmR21WTHlGeDRyV3Iy?=
 =?utf-8?B?NnVndDY3cjNwSzN3Ymg4dFdHMUZnczE0Qkh2cFdlNTRFemFqWUgzOHAxbkNo?=
 =?utf-8?B?RUNsc0dPSVlBWTZ3VE1DbWZnRDV3aVYzNDNuaXQrMXBpeU5CZkdqeGdWdGVS?=
 =?utf-8?B?M1k4dTlmSWNTQUEwRUIxQVF4eDVkYVJIdWJlVW16amh2c2g0Z2N4QlR0SE5t?=
 =?utf-8?B?eFduR01KcE9iYzJsUTRWeDZ4VXBBMzYwSmttbS9GU2ZESUp0Yk1wbVE4SzNI?=
 =?utf-8?B?Sk5KWm5mZW1ocVlvUnArZUF0QlF1Q2xGbjdmOHVhSzg0MzBBNDN1VVlsRzlR?=
 =?utf-8?B?OXJPV2d1SmpnOW5jQUZOWlZLMmdXclQzUzRCNVczNDhjWXNXZTBsRi8rYjM2?=
 =?utf-8?B?N3prOTB1SnBTaUdkSnN1Zjl2aFVpSzFucGZtam90aUtVU1Y2VUIxR2swWTNz?=
 =?utf-8?B?cHpzSWdKSFJXZkw4SVNRSk5rY2ZVWHdJa0VpWmJvR0xSVGtBeVRFQmhiNlVQ?=
 =?utf-8?B?N1JtYmxmR1RSRXVPYndnWWlBYkJEeng0VkJkUjEvOEtTN3hxZzkxZy9vc0Va?=
 =?utf-8?B?dUZ4MU4yajdJeGR0bjR3QnJURDVKUzMxcDVFZWticDVDd2phTUhDTzNpSG9h?=
 =?utf-8?B?eW9URTBSbVp2cSttTU1VejRaUVd5a3pSQ3dQMTNpRC9Lc3liWm5hZE5Mb05I?=
 =?utf-8?B?aUtoQnlSRDJFNzhzSTY1cXVOdFBUdEZiTnFNcHF2M3lHZnVHdlVRaWtCSTRB?=
 =?utf-8?Q?kX5uT/CyChk26l96csy0LtQ=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 791a144a-6972-48a0-28df-08d998eba30c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 01:46:47.4295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 iEKaidBans+iRQ9vCW5+6tlWb/HFIhM78KNie72QF6gswSf2gfwV0j2ThFTJqezOvBLHbVSrZeYwKUu7QlSMyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5617
X-Proofpoint-GUID: aAljGDmfmKDt23NG54OMdVem3i11plC4
X-Proofpoint-ORIG-GUID: USd63IAXQPf8wAG7xaqueukN8bBTEsZK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-26_07,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=907 suspectscore=0 clxscore=1015 phishscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2110270008
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 27 Oct 2021 01:46:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12840

--------------F7EB7F40115EC1946005DCAF
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Gentle ping on this series.

Regards,
Qi

On 10/18/2021 11:45 AM, Chen Qi wrote:
> The following commit to fix [Yocto #13039] causes regression of
> the behavior of PREMIRRORS.
>
>    "bitbake: fetch2: fix premirror URI when downloadfilename defined"
>
> Take meta-openembedded/meta-networking/recipes-protocols/freediameter/freediameter_1.4.0.bb
> as an example.
> SRC_URI = "\
>      http://www.freediameter.net/hg/${fd_pkgname}/archive/${PV}.tar.gz;downloadfilename=${fd_pkgname}-${PV}.tar.gz \
>      ...
> "
> With the above commit, it now tries to fetch 1.4.0.tar.gz instead of
> freeDiameter-1.4.0.tar.gz. This makes https://downloads.yoctoproject.org/mirror/sources
> not work for freediameter, as it holds freeDiameter-1.4.0.tar.gz.
>
> The commit above tries to avoid fetching from invalid url such as:
> https://<some_mirror>/1.4.0.tar.gz/freeDiameter-1.4.0.tar.gz.
> And its solution is to make basename to be 1.4.0.tar.gz, thus causing the
> regression.
>
> This patch fixes the above regression. For Yocto #13039, it now tries
> to fetch from url: https://<some_mirror>/freeDiameter-1.4.0.tar.gz.
>
> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
> ---
>   bitbake/lib/bb/fetch2/__init__.py | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
> index 666cc1306a..000b49a500 100644
> --- a/bitbake/lib/bb/fetch2/__init__.py
> +++ b/bitbake/lib/bb/fetch2/__init__.py
> @@ -466,9 +466,13 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
>                       # Kill parameters, they make no sense for mirror tarballs
>                       uri_decoded[5] = {}
>                   elif ud.localpath and ud.method.supports_checksum(ud):
> -                    basename = os.path.basename(uri_decoded[loc])
> -                if basename and not result_decoded[loc].endswith(basename):
> -                    result_decoded[loc] = os.path.join(result_decoded[loc], basename)
> +                    basename = os.path.basename(ud.localpath)
> +                if basename:
> +                    uri_basename = os.path.basename(uri_decoded[loc])
> +                    if basename != uri_basename and result_decoded[loc].endswith(uri_basename):
> +                        result_decoded[loc] = result_decoded[loc].replace(uri_basename, basename)
> +                    elif not result_decoded[loc].endswith(basename):
> +                        result_decoded[loc] = os.path.join(result_decoded[loc], basename)
>           else:
>               return None
>       result = encodeurl(result_decoded)
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#12790): https://lists.openembedded.org/g/bitbake-devel/message/12790
> Mute This Topic: https://lists.openembedded.org/mt/86406437/3618072
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [Qi.Chen@windriver.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>


--------------F7EB7F40115EC1946005DCAF
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Gentle ping on this series.<br>
      <br>
      Regards,<br>
      Qi<br>
      <br>
      On 10/18/2021 11:45 AM, Chen Qi wrote:<br>
    </div>
    <blockquote cite="mid:16AF0338AE5E9F1B.30006@lists.openembedded.org" type="cite">
      <pre wrap="">The following commit to fix [Yocto #13039] causes regression of
the behavior of PREMIRRORS.

  &quot;bitbake: fetch2: fix premirror URI when downloadfilename defined&quot;

Take meta-openembedded/meta-networking/recipes-protocols/freediameter/freediameter_1.4.0.bb
as an example.
SRC_URI = &quot;\
    <a class="moz-txt-link-freetext" href="http://www.freediameter.net/hg/$">http://www.freediameter.net/hg/$</a>{fd_pkgname}/archive/${PV}.tar.gz;downloadfilename=${fd_pkgname}-${PV}.tar.gz \
    ...
&quot;
With the above commit, it now tries to fetch 1.4.0.tar.gz instead of
freeDiameter-1.4.0.tar.gz. This makes <a class="moz-txt-link-freetext" href="https://downloads.yoctoproject.org/mirror/sources">https://downloads.yoctoproject.org/mirror/sources</a>
not work for freediameter, as it holds freeDiameter-1.4.0.tar.gz.

The commit above tries to avoid fetching from invalid url such as:
<a class="moz-txt-link-freetext" href="https://">https://</a>&lt;some_mirror&gt;/1.4.0.tar.gz/freeDiameter-1.4.0.tar.gz.
And its solution is to make basename to be 1.4.0.tar.gz, thus causing the
regression.

This patch fixes the above regression. For Yocto #13039, it now tries
to fetch from url: <a class="moz-txt-link-freetext" href="https://">https://</a>&lt;some_mirror&gt;/freeDiameter-1.4.0.tar.gz.

Signed-off-by: Chen Qi <a class="moz-txt-link-rfc2396E" href="mailto:Qi.Chen@windriver.com">&lt;Qi.Chen@windriver.com&gt;</a>
---
 bitbake/lib/bb/fetch2/__init__.py | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 666cc1306a..000b49a500 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -466,9 +466,13 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
                     # Kill parameters, they make no sense for mirror tarballs
                     uri_decoded[5] = {}
                 elif ud.localpath and ud.method.supports_checksum(ud):
-                    basename = os.path.basename(uri_decoded[loc])
-                if basename and not result_decoded[loc].endswith(basename):
-                    result_decoded[loc] = os.path.join(result_decoded[loc], basename)
+                    basename = os.path.basename(ud.localpath)
+                if basename:
+                    uri_basename = os.path.basename(uri_decoded[loc])
+                    if basename != uri_basename and result_decoded[loc].endswith(uri_basename):
+                        result_decoded[loc] = result_decoded[loc].replace(uri_basename, basename)
+                    elif not result_decoded[loc].endswith(basename):
+                        result_decoded[loc] = os.path.join(result_decoded[loc], basename)
         else:
             return None
     result = encodeurl(result_decoded)
</pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">
-=-=-=-=-=-=-=-=-=-=-=-
Links: You receive all messages sent to this group.
View/Reply Online (#12790): <a class="moz-txt-link-freetext" href="https://lists.openembedded.org/g/bitbake-devel/message/12790">https://lists.openembedded.org/g/bitbake-devel/message/12790</a>
Mute This Topic: <a class="moz-txt-link-freetext" href="https://lists.openembedded.org/mt/86406437/3618072">https://lists.openembedded.org/mt/86406437/3618072</a>
Group Owner: <a class="moz-txt-link-abbreviated" href="mailto:bitbake-devel+owner@lists.openembedded.org">bitbake-devel+owner@lists.openembedded.org</a>
Unsubscribe: <a class="moz-txt-link-freetext" href="https://lists.openembedded.org/g/bitbake-devel/unsub">https://lists.openembedded.org/g/bitbake-devel/unsub</a> [<a class="moz-txt-link-abbreviated" href="mailto:Qi.Chen@windriver.com">Qi.Chen@windriver.com</a>]
-=-=-=-=-=-=-=-=-=-=-=-

</pre>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------F7EB7F40115EC1946005DCAF--

