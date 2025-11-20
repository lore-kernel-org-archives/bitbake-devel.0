Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EECCF64BB
	for <webhook@archiver.kernel.org>; Thu, 20 Nov 2025 07:33:54 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.29307.1763624029391466663
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Nov 2025 23:33:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=Dw4svki/;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=3419979445=qi.chen@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AK5O66k118642
	for <bitbake-devel@lists.openembedded.org>; Wed, 19 Nov 2025 23:33:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=Yc/IRZAUqO3Uc+LcGkasWxMVC7sO/dMReBBefzlI/1Q=; b=
	Dw4svki/Jajf9yc5LY8XOAIlrMmdshbQkLqFamiDgYz6a+G/w1oyrhb0zvE1O1g4
	WY3P91NZJpMdtmqUaKz7gnQBn2D7OQ1ySVytoJ7mkk9xPM8xnOpKPo6rpjybfbba
	gmaUqyh3tjHD0KOW7eTyrk1TeKd6Z4V2xKfdiMLp6z0XEM2w9aEWy7OMLyyjiU+z
	vCvBNrV57afiiCa6ABEsvRU9GlL7Rkj78hyhxFKBdtcQ/K0iDufmP/dEf/5LNGsM
	TbPfXjuUur+RMaracKi0sI8h0bgdZgjkAKMHizuvg8MjNBRZcYMRaJpOBXeYoyOs
	T93XXFsx7hpkUMEubnt/Qg==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010022.outbound.protection.outlook.com [40.93.198.22])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4aenp2x1hw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 23:33:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJ03IiCl0FA+Rro9ngeEX7EbC1l9MKcnF3MetM9Zhn0ViruJaJbpZf/SE842bxEAjx5zXQcI6j8Gfh1nhnCGeREHTC1JYg/je+Ozi6E4lWZxAhqPPtjLF142rT354mXPHjgwkpZcSDWCb3hsn5MNnoWZ+h1dPxVRyfbEMBygYbUsZ6jh6/8ea4qe1UWmdlYgRxOkdq1geTD3InrJqVWPTrUBaIf2MbbAUnqiT1s3oX7pPsAkyVYEW4BXrDVBKIcqOVopG+eRKVCHe7pFmCqiCNF8W8DTVdTdZiTSw0RN2osRhMPbpmlH5v2zllpjNPeBNgxUDWzBJIAl9KO0sTjZmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yc/IRZAUqO3Uc+LcGkasWxMVC7sO/dMReBBefzlI/1Q=;
 b=d6XnYfBLBbt3SY3HOpXyiJ2BjnGUO5jiB/GSAldIrDk92sBXLVFpP2QRz0RSalksQDCSxk1udcatFMT0Zbm0kh0Ox43UBPdn0iclggCSoO7LdM01eT3Gy7tlwlPhaN4eVn09VhZ4UmhXneagAYb10Z6pv1Gz9FF19NI+qzi/rl+PdYOvyLMq9W/txqpGr6YvbPH6UIQyzqhqy2H/O6rnXcBsMAiTAbxQeVZWJbx4g28qYx8f4PuQHScEWkXMXiFVmy/dmNnuCPKV3qlBrNuGctGZ92C74FIXUP9PBzODcwH2Drwfh15wVMCHpWW3l7B6Mpd81W5M5UFoQIuIg+NS+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by SJ5PPFC295640A5.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::852) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 07:33:47 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 07:33:47 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org
Cc: alex.kanavin@gmail.com, richard.purdie@linuxfoundation.org,
        qi.chen@windriver.com
Subject: [bitbake-devel][PATCH V4 3/3] lib/bb/parse/ast.py: error out for internal fragment in case of a previous value
Date: Thu, 20 Nov 2025 15:33:24 +0800
Message-Id: <20251120073324.136238-3-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251120073324.136238-1-Qi.Chen@windriver.com>
References: <20251120073324.136238-1-Qi.Chen@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0006.APCP153.PROD.OUTLOOK.COM (2603:1096::16) To
 CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|SJ5PPFC295640A5:EE_
X-MS-Office365-Filtering-Correlation-Id: fe0f08f9-bdb9-4ea1-1878-08de2807240f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?loRQSBIIRpMim4tJxmpg9sBa1T34wiZCnHEAErLEoZrJfPojqywcCOMmGviB?=
 =?us-ascii?Q?WZfL/MJ0ll02RxfsSstUKGO3WnJRUXKrjop7CAarJYefJAxvcVF1gB36OIMu?=
 =?us-ascii?Q?fzFIrFUKcSu80U4W0hCHRHi3sgWzRAskCwF96yrSU4FBwB8bZGP24EfPYb/U?=
 =?us-ascii?Q?aUZqSzIa/f1/d0HsTQ8IiRcDcA+F5Kupy1eBEOxHMUHolKjGXK8oNqh5wmFN?=
 =?us-ascii?Q?qbhDC07zwBXoL0g9yikTgyyNISbm1PBnURtjRG/L3ey7TH7sXaEgrkoWD9qa?=
 =?us-ascii?Q?VFebfdpBoevdE9xawnUjzSmNC37yfzPZqZKBXgz/+CfjFNW+tw1RNK099TS2?=
 =?us-ascii?Q?B+g+kLQHrV28/sJr1f8zA2/8cMcZPi3xaLQ5M6jAnnzjeeQdYDwY5bfa5qQN?=
 =?us-ascii?Q?nhP3zChZQdZgQCxE2Fyw6faPqGvbGZYw4osXX3/pPbFGhvmX6jyDz8kQ1+/u?=
 =?us-ascii?Q?JRDLiySSD9tUtjrfVHmIxtUUv9dLklFKDM66wqhDYMYz0hR1D+Ch05Y1v6dI?=
 =?us-ascii?Q?LRNCBjosjrdFgNWxnFlzHOKpVPbcpoCJzzsLc8qj9MKzkwg1vZAJx5EB8zc5?=
 =?us-ascii?Q?HVU7Qx1Wt+OJJexxRMGW0weczohWYV8PXpQb74uER9vO+YaDGzLjuhjR0/o6?=
 =?us-ascii?Q?DPW3Md53Tf8ZEIIyxOg3rZjIim18t45OV6wFc6U2HvB1OWzVNHjN0rgME/8r?=
 =?us-ascii?Q?FqvbtMIdz85NgVs0C5rLEJR27ycit+AQd1t0yaloRXDzQdNYba4+TCdBB7e8?=
 =?us-ascii?Q?MVSC4xElkiL78obpS2x9qladj310unqCWk1yAVosyoezSi3QI6306G5rp5W6?=
 =?us-ascii?Q?p7ttvrBHjNW+pXhtzwdP7Z1JC3OrDinj4O5TvMeKK5+VLSbVjTshihzXxVjo?=
 =?us-ascii?Q?zWxfhQX6wsydyvUYt6ErtwSmfZvhE+aBqSxfeWscWH2Uw56rbh9BHi5zZYSI?=
 =?us-ascii?Q?d/B3916Qfg6CDT127LjZlFqrBWIQALmJnHJ45h5Pk+SeA0o29IKnlSrkY/G5?=
 =?us-ascii?Q?GG2VN8xp4pTXx40yjvxp0AhwnPQ8MmqTZr2sTJYmF5UGMDi6NO+aW8UnxRcP?=
 =?us-ascii?Q?+OvVBZ4UZd2pZJ8ZnG/j5MrFD/Eu+x5yONngkmxU9F82NUP7DYaIAyduf4Y9?=
 =?us-ascii?Q?Y8eJlucXEm0bT5dq2e2PimEtBisopnFRT7p98+QMn3UQE1Sgk2od0DB2kg/v?=
 =?us-ascii?Q?G5HkXK71Q8Vp7prBVZc5hCWWPjshFKqyXA88Qz2TJRl1wZoLhd7OmF6acXSb?=
 =?us-ascii?Q?+asJT7qxgPsn5dYlH0j/mg+RZpXxeaOqDXh3F0H0D03vn1e1kqx3IpgP0IS/?=
 =?us-ascii?Q?7Gzbfjg1pwjsAtOy3DN/RQPgXYJvP4AreGIHZ27a7iPS9PeWPD5TlwxKmaC3?=
 =?us-ascii?Q?MbDwuFWovLN4ceck2UlX2C0kFeSVn9qOiSb2yLvD4mFVnZmVHhy8VWj58U6e?=
 =?us-ascii?Q?cfWyZVIJZeKVGi2ia0bxlBgZ7rSGeeU1j7Gcgsk1avzzzgk97Y8fwr0NlHkI?=
 =?us-ascii?Q?04jOLyYJW7Bjskel+ZokPHIbP1P+ZBsKTYeH?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?YZCVcS8hdpMVKEai2LPrbEAVLEpDVgJjhsW8O/2+P1GU/TxOPbLMzpmUSiQc?=
 =?us-ascii?Q?Z9UO3O8diRqTWfvS5g9Zx9JSX/fVfMNcJ/wbANLcyGaXiOdzwI4bfxuCZ6Wb?=
 =?us-ascii?Q?SIPgLCs483Nt2Oe9Gm+tSPpiBUNjrYzjbhqmC2cWYmNU7oR+GlQrQZfMnflK?=
 =?us-ascii?Q?deWATY9s7/iJ0BMDsISTQNyCoxixqnibjnKwmmnihGmi4HAhsMf45Igwx8yg?=
 =?us-ascii?Q?zXou+uZoxfNwNO6yjAaJSt60oDYXaf4QefI88/M86eNQEMXkgQrADzLFzD2j?=
 =?us-ascii?Q?tqDz3xIrGgj8t9CCqSJIn6AS3mmVKWTZbxydkLtuWB5BGemFss1z0HttQ4am?=
 =?us-ascii?Q?zFBZ2iz/O/j+yeRQaBLnZ1sRtLz75XHv2O20glAljmxUdXIzc7qYDSXzJ3+S?=
 =?us-ascii?Q?/RQP7/UrX+1XtX4u2pM4lGY6AO4Bkt5lCLarPTTRjQorRpQwEPbyxUdrURB6?=
 =?us-ascii?Q?w8gRJZbmlItBoWg2YGDz1Myq/uiXvZNBRhiomFFMwkSo2tU60RU0KHW8Wlrf?=
 =?us-ascii?Q?a9S5/n/H0YKAWZ+Y6EepR/bxZ1qiNFSXZep5f/WlDkNboO3AJzjUBirEvwjx?=
 =?us-ascii?Q?CwqApkO4b0uHMnY8CPD7Q8qLGhLePns9S4rlTKBmjizYBcQbC7RRDLOxzNnE?=
 =?us-ascii?Q?xhSUSnRPyUKxV8MXMQhta+jVttb0EaD10j/ULDEPuuH09LFrLhJ2ctzpV0xe?=
 =?us-ascii?Q?uNMv2xuXvVcsMlFVrR0mZBOGoyYC8tqiIC2mA2LpgO6PqEySNIany8CcU9xZ?=
 =?us-ascii?Q?1y6cEuXcH2g4hZCmuNNo+BAXN8THreBUl2yH+DRO6Av8Uw/fu4t1lfJJBWep?=
 =?us-ascii?Q?IhPHWGggmfcTL6H+HfTF5sKAhMQjcHQ4/yip0ZR8/pI7z7xnlenBkz9kj+dJ?=
 =?us-ascii?Q?MRMrivdbmC0g+t7HhWWjgznrTgXaKZi36gN+66tSY7oXCzMh7f36y2TrV0hg?=
 =?us-ascii?Q?G4gmPdx6Ls9PWCV9pZVOzG+7ivq/Ws3FcEWaBkfZCzzgoHeOgsXip3vFwfbU?=
 =?us-ascii?Q?n1rd+EKXu/EmN7sXvDGcMpr+oG7qeqclfuaCR+tCIhBhYnLWG9FpBys9WbrF?=
 =?us-ascii?Q?RYS5XSRjRyAVA59jjihWRbBXV9jI3Z3pOjb/1sdcm9UqIa18pSkL28Oy8oRm?=
 =?us-ascii?Q?jiygNQCKw6iXhnMtcIMsmvgYDA9AJdr1ZikvJ4QgtKh5JVqLGBJFD5tClyqc?=
 =?us-ascii?Q?Ui2+837quYeNuWDk488xOKQ8WZRIzdpPKYXVnQuKxKYE/ApU84Wu3ZGFUc7e?=
 =?us-ascii?Q?vB5jMaJeCnCn5CMMAjLwa+7SYLpwDVoXLY2W8QjjM3KHPLO/aY+HbgZTyjkU?=
 =?us-ascii?Q?s4sj72PbSRQQpqmDbohSm6z970EcHPjhm7a1Ido7x+UVIlsjebaNs/YU6u01?=
 =?us-ascii?Q?KhLYIX3WVjx+9QJ1V9orpecvG9k8DAetIPbFJ8aDTP6gRKMWCsKAOVlpd4lI?=
 =?us-ascii?Q?/rG03ie6ntQYhqslyfRt+wX4xWLXIpqI4qcpwwNd5mVVZJOQ57NCUyJ3k2sL?=
 =?us-ascii?Q?wWBvPouLsCiM/J+B95gs2rcQhFcujLXr114/MNGgsBjJw1YGO/ZBX3+O6iRR?=
 =?us-ascii?Q?0PMDxU82cU8hv/X5ZU/ZW+Jwv4zVKq0vw1CrgO12?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0f08f9-bdb9-4ea1-1878-08de2807240f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 07:33:46.9863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PC7zsS4YR8TUd78r/22Y9+8NJsqp9vOJURtRTRu3m5CfL8Umhr14WIbv0EcWTjtwOGOtyGDSBTe+OnRTUf149Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFC295640A5
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIwMDA0MyBTYWx0ZWRfXw6XFh1BgsxBW
 /wRM8iIs2aKRg2t3VH5ZnU1iv+Asif8hTM1jclMu6VtHbGgwkANqLz7nSUTadtyRTc8cEZ1VP/7
 E2bZ+ylHQdR1WfzVl1Pdq1Lz8Hfal5U2V+FptHlnJcBJ0VHqdz2KC2fK/02vyqJADYysFrNKy9s
 b12XJWCtfbvbCV32eOW9oyK9Pl9qLnWFqzHmAVlZoIO39wFyygOEl0ZumR1+AJelSkYB6HvxmFN
 9Gj/LH/mUjsMoFbflYpENeF0/YQPnOUr9fzzUmwcmR5WPKjbcA5j5fTUPPIZuFV9ScAjRp8z/Px
 LeqCL89+3UWskChjHojFh1IUFiC1Imc6aQdXCO9HhZ4uAAYxaiIVjadTviFp2J4eEFNYcTysd1l
 pE9P5nXewqFi575JJ4hEL0V2GDi99w==
X-Proofpoint-ORIG-GUID: __kZLk0t9mPh9wzLv5ZUV14bIvMp1SCb
X-Proofpoint-GUID: SxagQ65zmdcJXNMzxPN7feTZ4na6jkmu
X-Authority-Analysis: v=2.4 cv=Z6Xh3XRA c=1 sm=1 tr=0 ts=691ec45d cx=c_pps
 a=F9MFHRSrL/QBKEkL9+MzCA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=HvlrrJGs30CXpD3u:21 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=t7CeM3EgAAAA:8 a=Iho6WsmrSGtPT8d2sCIA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_02,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511200043
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Nov 2025 07:33:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18468

From: Chen Qi <Qi.Chen@windriver.com>

When an internal fragment is enabled, and there's already a value
for the corresponding variable, we should error out to avoid any
confusion.

For example, when 'machine/qemux86-64' fragement is enabled, and
we get some "MACHINE = xxx" in local.conf or env, we should error
out and recomment users to use 'bitbake-config-build disable-fragment'.

We should be tolerating '??=' assignments. For example, DISTRO defaults
to "nodistro" in oe-core layer, and when 'distro/poky" fragment is enabled,
there should be no confusion.

Fixes [YOCTO #16060]

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 lib/bb/parse/ast.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index bf9bd4f55..00e3615e6 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -367,6 +367,12 @@ class AddFragmentsNode(AstNode):
         def check_and_set_builtin_fragment(fragment, data, builtin_fragments):
             prefix, value = fragment.split('/', 1)
             if prefix in builtin_fragments.keys():
+                if data.getVar(builtin_fragments[prefix], noweakdefault=True) != None:
+                    bb.fatal(
+                        ("A builtin fragment '%s' is used while %s has already got an assignment.\n"
+                         "Please either disable the fragment or remove the value assignment.\n"
+                         "To disable the fragment, use 'bitbake-config-build disable-fragment %s'."
+                         ) % (fragment, builtin_fragments[prefix], fragment))
                 fragment_history = data.varhistory.variable(self.fragments_variable)
                 loginfo={}
                 for fh in fragment_history[::-1]:
-- 
2.34.1


