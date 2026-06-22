Return-Path: <david.partain@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A96CDB470
	for <webhook@archiver.kernel.org>; Tue, 23 Jun 2026 21:29:23 +0000 (UTC)
Received: from mx0a-003cac01.pphosted.com (mx0a-003cac01.pphosted.com [205.220.161.93])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7409.1782163153033085588
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Jun 2026 14:19:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@keysight.com header.s=ppfeb2020 header.b=r4ub9fpa;
 dkim=pass header.i=@keysight.com header.s=selector1 header.b=l0VZe+sS;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: keysight.com, ip: 205.220.161.93, mailfrom: john.ripple@keysight.com)
Received: from pps.filterd (m0187214.ppops.net [127.0.0.1])
	by mx0b-003cac01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ML1V0v2762043
	for <bitbake-devel@lists.openembedded.org>; Mon, 22 Jun 2026 14:19:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=keysight.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=ppfeb2020; bh=tjCXLQXcfQ2GyncLmEelp3
	yOK4ydnnCTODj1JtHD4cU=; b=r4ub9fpad0I2V5MQwOhElj0C3nrfZp6cBPnVOD
	BuHUVyqrn76o1uHpImPhcJ4UnZNptrn9PuAojVV/1LWfNrXpFUCqeMrhOzZnzsO9
	+c/5VBhpFRBmj8ohBgrq9JYzXw+pNBjGytuG4KflP0U3vV0F1IzvS5gSmtQqmvhr
	Ds3fTmay5lFEj2SOALlfzZr8kv58iL/Kn0y+4A5CgWhGUHzpVN52B7kiD5a13gT7
	lZc3Vk2vwek15OzTXUBixOIpcw9atOo8SPZvImn5YBHNPLmtYqeWGWXnUtPQ9lZC
	ys7AAZ/TkCmMnaDFBIvh1WZt4P562ir05B4SHqWpRtY2hmNA==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011037.outbound.protection.outlook.com [52.101.62.37])
	by mx0b-003cac01.pphosted.com (PPS) with ESMTPS id 4eyckr01qf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 22 Jun 2026 14:19:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qPOjNsatu9FvqAuRTUG6VZ6QCSuNsGku0Jon2qkzo5UcCRVqJOAfBrVx8t21wRrdRF9nZp1v/8gdfODSjmMD9nFlE0AF41OGU5iXJa6x2O3kdontypja/Zf7XX2reWUKJLEe34a5v6prhHWScCvHl7xSBDUPE49Q4GdE6au0lKY11rIW6+GDEiz36zPEzDgSTjzpoPfKjNR+yjmEP9gWqjECZ/G8iFvzkYYqy9JqJjEenWvJAdMbZtnAefNB1TcjHYOI1ZgrbgEmBjLRfvcwPF1wKNysGU2RYpDyFGTbxBRe1r8IPhmt1Q64dCNyXqI6GOiI/ojToiAR173aZNWgKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjCXLQXcfQ2GyncLmEelp3yOK4ydnnCTODj1JtHD4cU=;
 b=GQTYB4DoxR9x5Db8dhEufyZXPONGlInvKoTtm6FkGOd/WJUY/7MppiVu9Y1zqESErU2v87wTz08gFdWR2OEGZxeC9MVCGgN8GTd4InSD5CFKV0e07rBtZfg49PAghbIsRGzf30iOvpZ/pu7pSmZayAqQhu8kO43vTsW+4iiJfMI8h91a8OT6qgbTSbGA0u62PnrogW9bqGXbnn7CgltrrFmWgIscPIuTO8lQzvFNNflyadoojjSkfSXb897lLoX21IYQnQxgrENZLi/2y9qlQg8zegbpraRshfkrvX7R4f1L6NZqtk1KgCsDffMLLpbtOmbB1NZDki66z8bDsigTVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=keysight.com; dmarc=pass action=none header.from=keysight.com;
 dkim=pass header.d=keysight.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=keysight.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjCXLQXcfQ2GyncLmEelp3yOK4ydnnCTODj1JtHD4cU=;
 b=l0VZe+sSq3rVg7ctYNAEPmnNrZkquGJ7jRTcAFC+/6FAAPIQ1o+EDoL9vDAMU93YJn8NyCXUFJBjJFafmH9SXucFKRA3e6iCeZ5GpBXu+2/MQ7Rf5+8wSgLrxalDN7oRb600/ocL2DxF0oktDFHmn6QMFu30x9U2XTVQcbvDXMg=
Received: from PH7PR17MB6130.namprd17.prod.outlook.com (2603:10b6:510:1f5::17)
 by SJ0PR17MB5557.namprd17.prod.outlook.com (2603:10b6:a03:393::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 21:19:09 +0000
Received: from PH7PR17MB6130.namprd17.prod.outlook.com
 ([fe80::7052:ef05:ccc9:d9c2]) by PH7PR17MB6130.namprd17.prod.outlook.com
 ([fe80::7052:ef05:ccc9:d9c2%3]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 21:19:09 +0000
From: "John Ripple" <john.ripple@keysight.com>
To: bitbake-devel@lists.openembedded.org
Cc: John Ripple <john.ripple@keysight.com>
Subject: [bitbake][PATCH] npmsw.py: Handle local tarball before registry
Date: Mon, 22 Jun 2026 15:19:00 -0600
Message-ID: <20260622211900.3648277-1-john.ripple@keysight.com>
X-Mailer: git-send-email 2.54.0
X-ClientProxiedBy: CYXPR02CA0083.namprd02.prod.outlook.com
 (2603:10b6:930:ce::18) To PH7PR17MB6130.namprd17.prod.outlook.com
 (2603:10b6:510:1f5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR17MB6130:EE_|SJ0PR17MB5557:EE_
X-MS-Office365-Filtering-Correlation-Id: ba13f116-5b24-48a6-f27d-08ded0a3e644
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	0uhM0zzmcadmxKn+IG+7UxRdjNpZsnHPsK/8tRVTm4j6xYvo/BopG6UaM6T5VCr3YOkV1m6z2WSiO4aHutaprAlQZZRPo4UjP+o2+xfWKhQhYI7gTAnd9RkYbxNqARqdGcs8comK28uYPENEWI2pEUf1YuiL3c6N+5xBMFxyoiglLui/dXjkvRDsNCgYuS25mRF8b3JC4Vm6/wHGi2JSj3SJVDW5zR6/XbtFoK/sNuoaUJbMq2BSEVQ3QIJ1ZnaAcFhAsv1Sm/A6kstnkGurt7w0QjqbyakbuU4Y1gkQFc3K2dKY+s3vhZoDUDSAeEeSeFnD7FUL8jagnWitrix4M5qdXwQjTaqJISv521Q6PRoTug49Ay1f2mu8f/mdSiPKHiBcfBp+a4dyM+ix5tmgG/q9Xx5qxlTa8mOitoCx56cEjyuo79Wx/v65iUjf+eHE7hO99D0kzF1pSD13X2Hgl9LRHYzu2/rQQypijhDOMKmzOQXXH4HwtrdeYx4D6ABpyCqS+zEXUs6ggL0tWZ85pt2eujyK6qL183C5LRzLqrPJpryA6WabDmz+jhhcuY/2u0rM062c0sDk9dALBiMln8VZH/8s24nIEfZJcP/w5fSOYOG49Uv/LV3pmhuFOStI2wlvyRfiAqgnNaKjiOyR+hyb0aNCKpOrG2uduNVlu3w=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR17MB6130.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?f2MbKk5ofojFJFRg1iiCb0k46f9ZKrqHhE69X86jFShj3X1VE7ljgz0U1fvm?=
 =?us-ascii?Q?NE1lNEye/HUSrsl/K3YT93S06/PmZe56w6SoIMdekwA0r88W9HMYY8BRIFLR?=
 =?us-ascii?Q?ZemCZQo6Ocf2MPwulkazoA5+cm86DN6FL9P9+XWTg0rKj613ayUQDy6cIlyK?=
 =?us-ascii?Q?WjoPZymWIrxlG3E8nlW5/zJedCjdD/IEqpkGbXpY5N5xo3ZyfrzVpW85X7of?=
 =?us-ascii?Q?RN6aVTAqeKXCFYdvuffadNlWIr0ZNMuTxPaxIOEukY/L5Mshd3WG75wDcHbu?=
 =?us-ascii?Q?uD9VTtU77cl8f2WxNocuAQQj/zAcdH4EN6200bWFoQVTQHxit9d6swLuVLy1?=
 =?us-ascii?Q?XmI1KD4fstkj6ZO4xLmPuEAnzbNtU6cM5sS3/521Dl7jjehBffthwzacnW9/?=
 =?us-ascii?Q?4EDecCbPzpsTaQQzgVIc2qdm35dEaVbV4pDoowxgnZg+ah3u288XDFKmRfY7?=
 =?us-ascii?Q?qbvpJVNmGZEEpCt32V2L45/xcEHZBf7iDMtRgfqJMuvATAzHBtAC0Ew2LW/H?=
 =?us-ascii?Q?jdjIQWM9Lb83tY+aYajD/GItTsj1tAgM3v4c2YxzxtPYLBtjnJhy7qLoVecP?=
 =?us-ascii?Q?Gg/hQJjS24qCfD1wm6ryUZtVp300+y3reKMGCFJI0VLVDqrsJz5kBsLIgzOL?=
 =?us-ascii?Q?X+M+l7+l1aJcUZ8sggTAn7EgbBG/N1aYCTlJrjhwhnZii4XtMSlWsPY948Bi?=
 =?us-ascii?Q?wvWJ9xP9U+tUlUOcrEpLUP3b2KASYUVuh//h6G8n30xW4YS74SPAhl90louh?=
 =?us-ascii?Q?N1wzOHkXCghwqeFNW1QXUJuI/lEuQGQjf0pvdcnF/Q2vj3prhDhiW9akl3UK?=
 =?us-ascii?Q?WAvCItQP3JqamJ3bWdt1AmNcqv8oZ1U2IbXI51RMVERWIOf26ARfBdpoV8Bt?=
 =?us-ascii?Q?xdyLlGsnu5lhjcEU7ExGIX2oKj4YviYDfTjb4xs2ItURzzMSHIZwbUTRn+0O?=
 =?us-ascii?Q?Dyoaujsc3k8AHCgnsQTLAB4FksHcfWTzTORTkvpNRCL0yowPObMhJagg51Ds?=
 =?us-ascii?Q?FFLmb6turHQM+KmrG5qExs7Kd50omgd5UafzaUmXc/ei8YS6UgSISX5ut4i+?=
 =?us-ascii?Q?XmPRBnDnLiik8NHg36XCB2YjLR+qvqsXl3pURd9kdao21BR54wpUb8ytiikr?=
 =?us-ascii?Q?JRsMXZnFMqejPpElebgGzQntMfvJNFMYnx2y5NAd75h1WLFb6SSriU+ehymT?=
 =?us-ascii?Q?qsqaKMrhrkmr/yubIuhyML5SFhSq+CZhq2YXku5DkXVpSLqiiY4Rv5a9LnL/?=
 =?us-ascii?Q?hutL3/s9ojCRynTQve5W775UgnCGlbq+8LVPhORHBtdb7q1ix28J3UpC/oDA?=
 =?us-ascii?Q?wZkWzAFVxXpeuOhIViUb60tHh679itbe9kwGirrPr3yVIVlh+cj76YeL1FzY?=
 =?us-ascii?Q?dRq+MvSKkQwRRRc9Y7W8bEFQ9YxmEaWd7f6Zv3kPceJIb8ckoahsAGTkzVT2?=
 =?us-ascii?Q?Na3Pm2I6hpj7GNQFxOVSvwwfDMJ1rAmyZhHJHISNtNj69X66ReOd8MhXkZSc?=
 =?us-ascii?Q?TMLciixh/V9j9+49IZh7z1FZSX8V/fpsgmpiB70vkVJn4gRDXygVBWt5nFtr?=
 =?us-ascii?Q?RbO3969LXPDPI5pw1iKyA46LkPnBcTjRmn0nMZVqtfjSugIu5mR/cWI154K/?=
 =?us-ascii?Q?0JLUEY1razfE3Apq+oZXhauswgnuKyP/tSMTQNXLK9laoV5vTuq52epNxPPs?=
 =?us-ascii?Q?xthIwCAR4Uxuf6lfHSlV2rbKhhu6Oi7VlWSFA1TrH8iglfA+0BOkXsMaHvET?=
 =?us-ascii?Q?gHNy1tJxMQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	WM5SLYvH4JY163MzMZMo79CfsO8yc+RBszRjySxkFiyL6DYrlswWAzsdMMzhFIf8zp9XVr/mM6YJ79HSwNXvCBpukKW9G8x6lzZdTyiDpRXPSo3Ykp7EXLzL/qi6EEcKAkMVUq8ucm4ig3UzkcaRpH6J6LpW7/ZtDKQKv7Oew3zNVYAHBXxb8FYrq//9YSYq7D+FnYsku8VirikrGhvxtcAIw9LhcaohthmdSbJPeMb5HWpsrGBkwRv8SkAowXZZm9he0Wle35wx6EkZBSNMvphIKNOOVSgLuI5TN+U+pLVa171adznsZ8vCLuhRWGzO4KZj7zkrnZXUI6iL4I54zA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	XR5Z1Jb32tv2cngpYQWVu+7BNgeG0abxRkkk7Q/8JUj3NLMHjmxTQFo95z0NiqilKS7LPnCDnqtQvB+GlAME13zpmOWxNi8PzLefnUBTqESglINfN87TARtjNVXsbiWjUsNlCjNPReubnP2PFJtO0K0skJUliXDZ3GT41MpdAdvdYmurNFCxzzWqH+7RE2ULun3BAakDoitKcF/A2riHb1amKtgvH5fmCMG0SxQ8KuPXkJiOZF5U/wazy/JmkqNzlTR0/Q3rtBz7ZAin5/nlg7o2qbOMZSAKMnNcASNCmvLejXyOEpRCtRq45NBnB7OMnGqsxWaDJXbQXlQdLV15/sRvJ3HlkkbgxBOsOBXQbNVkpmy1h90URQGp4cjpiP+calaTF7p3Z0/QPmAwvSiDch2dzOQESLZlDOqeFObOqLrLIU/GNGBPLLAm983eQfScHISaOAoOBdyhSKR5QeWl3BUXp24rLGjzlGLq1JY95Vymu1m8EHhrSCedkmO00hvdX+ivf1doecnnmi/HjfyjGWYUij25eNqYyYc1aBCpJNsRUXomwyOqI8u93JP1jnTonL2kcXHCXN+5ksw41CzEomX5r2Bso2V0gKsK1FFGFxpLd1vP0PqOcBf0859WAhIR
X-OriginatorOrg: keysight.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba13f116-5b24-48a6-f27d-08ded0a3e644
X-MS-Exchange-CrossTenant-AuthSource: PH7PR17MB6130.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 21:19:09.5954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 63545f27-3232-4d74-a44d-cdd457063402
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MRTi4jBZkHRmRuVn2dW33LyUPTmeLvWP+tgoYLPbZ/zHIskn6UmXWmkLYS7dN9PynmJvZvch+H5MG6knKCQAN98Q3C4LO884Y1SAXbPcJXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB5557
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIwNiBTYWx0ZWRfX5PdGz+tn7OUg
 cZM2l5r3qd1U/eQne1UXjwEFlJYBlkpwZtcNM06UevFcK3ZjLpSisPjbklfEMjdsPCTWpd7IQja
 83nZY0MYumQm4PoR4GmNkTNFssHNV6KDQMOGpmy9mC8T0oe1OtQXmUIDhB8L0fYrZB4EJEc5Xhf
 12TbnsXjhU5763w8kA3akgJXP6dVjtUJ+yNv6/Z4FXp936AGZM4kgTSPcMErfIkGpII743MQSsM
 MgHYBqqHtEbfo6GBe3KXoH1YJQyEiZJuaSlC5qYzmeKUZdTfjL4wrXHYQU1aavHvPhT6Q44eDvj
 XB+8u0T3iPj9PIPZmzVGY1mvmapDVH/E/OEmBOyaBrrbLPWLjTDiSteYZoe8b3P75l5OZP6HHV5
 2UqI8TgHZqAGkoy35OIHJ/OBxcTAiMg/LNAGMjJAlrYphvTCn/upsK1tiq5cdtqTY5wNPoehPer
 GcPB+4/OvlNiVH/3vPA==
X-Proofpoint-ORIG-GUID: ybwClsxWfJRwU7zMjYcR3SKwVTLEdr9P
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIwNiBTYWx0ZWRfXztuGigkeW3UW
 7Zb6Q+kCQFlSDp50UOSOasTiI25Blx0y41L3clzrPM/RXH+u2vyuc1YgDf4kRSrOwP8GWHDxfb0
 2haMPp9rNWnYUHDAgQhnsssz78hDTkN7SUCg724tmM3Y/Pre+6vv
X-Authority-Analysis: v=2.4 cv=RfKgzVtv c=1 sm=1 tr=0 ts=6a39a6d0 cx=c_pps
 a=S2IqtmjrQAXuShkhhqPLog==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10 a=vu2TTH8h0NUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=FLoIbiw2ZNY34kqd41oa:22 a=mOSSRekXLlsqcmK058qe:22
 a=Q4-j1AaZAAAA:8 a=F6MVbVVLAAAA:8 a=wajhhanJwTMSkHoZ2NsA:9
 a=9H3Qd4_ONW2Ztcrla5EB:22 a=6mxfPxaA-CAxv1z-Kq-J:22
X-Proofpoint-GUID: ybwClsxWfJRwU7zMjYcR3SKwVTLEdr9P
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11825
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 clxscore=1011 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220206
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 23 Jun 2026 21:29:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19766

The local tarball source must be checked before the registry sources
because a local package can have a semver version and integrity field
which would otherwise incorrectly match the registry sources branch
producing a file:// proxy URL whose local.py fetcher leaves
lockfile=None and eventually throws an error.

This patch was based on the npm and npmsw fetchers with the improved
security from Thomas Perrot's patches https://lists.openembedded.org/g/bitbake-devel/message/19705.

Signed-off-by: John Ripple <john.ripple@keysight.com>
---
 lib/bb/fetch2/npmsw.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/bb/fetch2/npmsw.py b/lib/bb/fetch2/npmsw.py
index f09ea5794..122af4582 100644
--- a/lib/bb/fetch2/npmsw.py
+++ b/lib/bb/fetch2/npmsw.py
@@ -93,6 +93,10 @@ class NpmShrinkWrap(FetchMethod):
             if link:
                 localpath = resolved
                 unpack = False
+            
+            # Handle local tarball sources
+            elif resolved and resolved.startswith("file"):
+                localpath = resolved[5:]
 
             # Handle registry sources
             elif version and is_semver(version) and integrity:
@@ -139,10 +143,6 @@ class NpmShrinkWrap(FetchMethod):
 
                 localpath = os.path.join(d.getVar("DL_DIR"), localfile)
 
-            # Handle local tarball sources
-            elif resolved.startswith("file"):
-                localpath = resolved[5:]
-
             # Handle git sources
             elif resolved.startswith("git"):
                 regex = re.compile(r"""

