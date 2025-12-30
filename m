Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AEDE9410B
	for <webhook@archiver.kernel.org>; Tue, 30 Dec 2025 02:54:57 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.57614.1767063289083410264
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 29 Dec 2025 18:54:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=Sn8mxfjq;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=545943993c=qi.chen@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BU0SUPL2374441
	for <bitbake-devel@lists.openembedded.org>; Mon, 29 Dec 2025 18:54:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=MwT9q2Q8+dnLgeaUBxSU
	K+IwHewltY9VJogMLpn8leA=; b=Sn8mxfjqV31t0CZTJhULpLUxqGes+WqP7/5q
	f0J9WV8qSz/H4dsUlxZFEEYE71cxMIYEFHcoduQ0myfeR5qQea5fO18SaNjI+KLo
	OWmh0Tvrfjgv0J7BxDqBYUue76XXpfwK/Awgi/ikQjVnxzY+pPGOAGWwx9FpEZag
	upbjQXisUlOfk5dCAqB3/KyTDajBFN8Qb+Qsz6ZacoFuzSe74yeQNIf2FOn8Mv3M
	NlLMnR6bCOD77lyCt2A7l0Z0jz3FvypL6EzQudD3T8PVfnSiQM5UZblRobCd7ndr
	wp03khlLmNtZh06qKOxQHatHdUZ9l9+X1yxpJM+jXMYxNUOIDg==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010064.outbound.protection.outlook.com [52.101.61.64])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4bafuka5s6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 29 Dec 2025 18:54:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BEs1QSahhAKLX9q488Ol4CwRTaDHJFcOdGtiSJ4ordEFw2nvs3D3iI2RZ1tgyQrJUQSsu3nZwNmk6Z/2qlKQNaJ40oW/EFkPIuy0anF4gq9NbSvJLRC/s+a4lRUoQiWrED7yq7XXw0nqb60jEDolHfc0McUDNzUp6R41do8ag5zwWEk8zsBZZqTZ23GO4HrF/LjEKJ/XOC8E6geSCT2FcPWmipieLpPRlCuBHPsV8wY+FtEgj5f5rUYSPQqYZSU77P8NaAjO9BOL99AI53GpKAuiR6rgfsIi0T7M1K0kyiWVb4k2JjdF8Viff1uKTTlovGUaUYtdKg4ozO4Lu7sGzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwT9q2Q8+dnLgeaUBxSUK+IwHewltY9VJogMLpn8leA=;
 b=IJRZT7ZetQx7bYoEOVYtMFLZZAs3TlydtQ8foRP25Ed6ranqa3i2NVkDzow6n4NIjrjeixiuGrQWjwN4CqlcNg4+2t1AQtvSF5veiWZRvqNChMxamO2epl8nH49MoTNpkaJFbO7xvbD7FuCT7coTk4JKXlI80GSCnsDQZX0I6F8G+tbe8XxzqG0dgcj0LIJ+DHgqdzg8inTVXq4VNfjKymHhoHQ+CeCui/tOP9lIziMXh9m29y20NeqfDRAB13upJX1gAhStzII0Jl6cel/BYFX5HN1nRVyo7t2J29tPuG/oSfljzcwAyyq/7jPpyMm1VfL0RCvRQRRZJ4oYBAIY8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by DM4PR11MB6118.namprd11.prod.outlook.com (2603:10b6:8:b2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Tue, 30 Dec
 2025 02:54:46 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9456.013; Tue, 30 Dec 2025
 02:54:46 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake-devel][PATCH] fetch2/git.py: fix update_mirror_links
Date: Tue, 30 Dec 2025 10:54:13 +0800
Message-Id: <20251230025413.1293484-1-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0155.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::17) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|DM4PR11MB6118:EE_
X-MS-Office365-Filtering-Correlation-Id: bbd0a1c6-b446-4ddb-ff98-08de474eca5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?9sulZdKXwi8TSYJ/dv7kprzjbzbA3mhwANhhVxIfX6t6bNocHJBP+HQy82Pp?=
 =?us-ascii?Q?9XxmFWBEuh5OINv/gFSEjdEYAmboPDrPALqaoxDXu/zs6Qw+8KgGnqNvcAth?=
 =?us-ascii?Q?Gp12UQcTnL6IVNKxrEmXkz76mhQ7ynFi+W1emga7dtHyNw0ZN+SpiY9QIYDk?=
 =?us-ascii?Q?Okp5oGqK+SIEntKyXItKffye1mseA7WQduxnHaBpHXzgwX0RWQ6pmzuE2iIq?=
 =?us-ascii?Q?RUUBRF0SUVH3ocSEW4GZZ3KddVpxDZ1ptpqTSJw0Z4xQ1TfM4AJ2Io5mp3pg?=
 =?us-ascii?Q?wEfci6pa88wndkLTpvj2Nm7AsuGnXlCW6/ba3JrYYVLOtdMNieAeWO6YY55i?=
 =?us-ascii?Q?Po77IRy1uySKp9eNStoyEPUU7BfNDBbKXvfJKHS8NPTGAMWLNGsha966fpO9?=
 =?us-ascii?Q?6ytumhv7o+BxHmaAtJOyQ/p6ZSTfyBDQW8FKFsgLJzLF/lxzO+3dJHqdYAEB?=
 =?us-ascii?Q?+aWoLp6MKhY67kCQnuCvS7bwnv5DbW5yMKkcrEj3uBxy9JBJ6erStAVSDWwl?=
 =?us-ascii?Q?cCJ8YR9c/UYH+HxpGud6sl5B7kgeREzw4SBMRxEuYHWMJbMQulxFpIKcY47T?=
 =?us-ascii?Q?eA7kXysAvHOqyb/T7UmxWgMN+bWhQkyZ3g9k9lL1oaqujIIcGEMG//BvwbMZ?=
 =?us-ascii?Q?W4yvG49FhA4xxc4AaHNvPf0j6ntX8uX9KhX6xloQMqnIyiaNzerJWwZqdACA?=
 =?us-ascii?Q?BDVzpmMvW8bl49WwveZWirA2e9yjELRunOcGuyAplwP55yeJzwjUosH2piR/?=
 =?us-ascii?Q?Tw7jFexp7eDJ4bCyCSAE/SjNRTe2/SjvOd548463CcEaWjoJ1I1X/A52xE4t?=
 =?us-ascii?Q?LXwdiQGQtXHGo5ba4z9gpnbd3G1Rr12Y5tVH1EcJEwsDZO1S4Xt7I/C+m7Zj?=
 =?us-ascii?Q?lSfq2ZvDDFncHzfnoSvKpGW+EvHmN21Fbp8pVr38+hXzQtxuKQfIkUy9TPHe?=
 =?us-ascii?Q?c37HajpJD1prrqKpxvbHxquVjZ5xeMD4cTHXB2yuto0akkFirEotLcwmFh7B?=
 =?us-ascii?Q?1CuXP79kg6whOJb2cTQ+o+81AJm2KNbOOqjNMpCeUyEqSZP6RqVF96qKcXB8?=
 =?us-ascii?Q?EAPNlCF86CF5eJSpfudJZ/R54fYK2JWHJRk1cZpXmWUyMDje4wtiJZe42Ar+?=
 =?us-ascii?Q?qIYMstiX390pv9Fhzif6MTORTImCBd4l6xQoiziRBv3xph/EJIKorKuo5PJ/?=
 =?us-ascii?Q?V+egEkC6PyPby+ca2R/zafdPevtvXkkmVxtwwWpdpI5/jDCS6TVswq9nIiKG?=
 =?us-ascii?Q?nEoGDZbQ0srPq/NTy8x5BTca2xzntK5sHQnVOQZ4S8zioxt+VjaCjkMAKKXM?=
 =?us-ascii?Q?4vyD4V77xoLURB+ySMECl/FC72YxmJHmXYIGqLuXZXpE9svKRtTfy9zAPV3N?=
 =?us-ascii?Q?1CWP88lauruhEx23K3ig0CNh0BJUNu+l2eFEzp3/T9DVZLYOmnLg4RgWxqXT?=
 =?us-ascii?Q?VRnhnpcR5r9ra7ElZ0fS+9a3oigJeW2kXV7HT7N7Aw2TVAVDWrKUtWCUrayy?=
 =?us-ascii?Q?1W2BTteekTM8jnFE3UgDbOf3fRGFhwS/ErfH?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?hPWNw+cLUAVDsG3v78SGLAdGhZG2PpW86ZcMeIdvmDrzSVHucEon4M4IKmi0?=
 =?us-ascii?Q?5t5bE5ftAiZtZdtWQPMA4VGzE9zFFrJWUYbdCGY51BajOwH2DlJJKKetWazZ?=
 =?us-ascii?Q?Y/Qig74gFOjiOgSsLyJANkMZDoS5Y0EqCWq7DD9obtovusSBf75l+0wae6oG?=
 =?us-ascii?Q?atAEy15zuhdAY4aKjr5zqpxQcn3bVnDbmWztUs9W0ERZjqpZw8SYHPmDSUwL?=
 =?us-ascii?Q?uEPqXpstsb9W3Hi4Vro7Q8u3627ymlbMR7yow1rH+1B6ZxXYAxXLsgxb1RRN?=
 =?us-ascii?Q?2LTT0KRVEpRpPVg1nap6rQ41v33sCmZstnu37AT7xKbI6MYHs5wBeKrixT6a?=
 =?us-ascii?Q?c+/fBZdSs+AWzyRNhn6taycvmDBRr7cYFoAs1MZbWSvAUbqVfBsRXeTlMdXo?=
 =?us-ascii?Q?oZMHZoySvMNxXi65KlzJdBTZnhdAsZdYj8hFOUzREIjgpt0Fy3yPhKXPay2/?=
 =?us-ascii?Q?a/lngw/v6/eRtb+mO2YdZQSeuTqvM6ibTvqVGveMAaG07/45lO5cLub2dreW?=
 =?us-ascii?Q?1FAznCi2Uqzec8RV3j4yvhdrBFCYhvh/Uez1rLar9SbHNvnh38QliZpo0slH?=
 =?us-ascii?Q?vXI+cTuyTz37B0AyWlPi/HQ6cZfOV8QRRZZ0QEcNdQdKNa419goNj3ie+spR?=
 =?us-ascii?Q?4OKKEooREuX5ohYfjh2KrVFXr2E48Rh/EiyvdfAqnU5eKOurFrHL6zOkKROF?=
 =?us-ascii?Q?5ALAyVf5ySVx0BB/H5KcAnST2YHETmZapHc55+wf5wfNnskhzKP1h/jUDRgo?=
 =?us-ascii?Q?u8/vn223Eh1pRhlgjJJaixADUHpNjwwtnMXn7m/ZbBDcU/Vwa5P8Eb44IrpC?=
 =?us-ascii?Q?Z77FQzy0QMkv/RiV/Iinz+xEWJPOpI410v76rd6tDqVHCk7N11qEaqw7I4AW?=
 =?us-ascii?Q?dhoIrVX3MCozwxrgbMZW2P2mswktp21oZacDafhdj4bTM5pFGtuSKjEUZGE8?=
 =?us-ascii?Q?UTEnjgO/BGkl3rmXPOtPVikH+7B768Uwq7u/OLaJW7M48cDX6TxJxLCxRqvL?=
 =?us-ascii?Q?sC0/nbHuWKGwagMzjH5QUuV/V+XBFs2wSHXf4gpJWHut7uoJcl/9I2Abu6Yz?=
 =?us-ascii?Q?unCVtv67zh7pSNlp9Y9HESbeL9kJN6vk3RMUY5rK5UqmLYm8UjARSbxB014R?=
 =?us-ascii?Q?qYIvORXYW8hDleZZ6Y1oYXGgLroZ7Aguy+mqiZ22czw7zO+k1R9S25WWTdV2?=
 =?us-ascii?Q?tS4KpRfLYYr/x7+ZRnRRwn0kQ3M5pJkIQQv90t5rJG8CoAQ87WdBlI4eHePE?=
 =?us-ascii?Q?7viJjQBavfOCmI4zyNhtiEkk15+xNCPjBtlDG1xH3uLClEyX9s/Yc7echzQX?=
 =?us-ascii?Q?xQD//dAvE5L6GdJkxvS5cR5G41xLxNIL12i11I7sdhPsnrs2/DBTeIwtZ7eJ?=
 =?us-ascii?Q?FxQk4amxFUANOm09mdSBdYkNBLJ1w4n2gzFa2jmwFf4d+D/DrFBAcWo/OjP+?=
 =?us-ascii?Q?e0gkxLcwBlzAmqLDTuYuRrj00qoBmpdBVHoLE/IVXlG2H6kZ2LVljA4BX0hF?=
 =?us-ascii?Q?8QNQTGVzrBqX1m/93oJDen1BRhy2UIL2+9a/JnlZqUZ93mV0R6qPbro7wcfu?=
 =?us-ascii?Q?LywA9Lh//hqEAwZPROciPPel4/Z6XlXLYhqOIcg83beOOjXMwXcWfMSk9JsA?=
 =?us-ascii?Q?9ZEN7QwZdU9kILjRg7uOqnnJLnpeZe86LaWYZrwYkoHgpSFdd38/TNjeM2ZS?=
 =?us-ascii?Q?l9wLVxlx3NpRIFdiaTRpwemWgVCc1UkoA4Y+fT/nG4+HVp/w8LJoEGvToliC?=
 =?us-ascii?Q?VhHQy5+raQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd0a1c6-b446-4ddb-ff98-08de474eca5a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2025 02:54:46.3160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dhQyoRQjMa6yncZP0de/6G51nXZzdYhg/O9gZuLuU8L4gVDTeP5XSJVHLzykYVx4j5sdYiTSWKhtfX4m4g7vgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6118
X-Authority-Analysis: v=2.4 cv=ccjfb3DM c=1 sm=1 tr=0 ts=69533ef8 cx=c_pps
 a=0b+utHCzfji0ILmZHHcyhA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=t7CeM3EgAAAA:8 a=vcIJP8nnVkELgc4RJB4A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 1E4Uxy5MKuFS2Y7cv9tOHmhp7Iy68R12
X-Proofpoint-ORIG-GUID: 1E4Uxy5MKuFS2Y7cv9tOHmhp7Iy68R12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDAyNSBTYWx0ZWRfX+5wDNbV57/OO
 XzQu14APsSygvx7NAMIuKbCD8/OpF4P1dbYIplOClaxiXIecW/X5aPZGh4O23zPEdAnkdFTU5tH
 im5U1OwfL8e5+RSh+BSkZOqT3PxTWeD0T2OyNucIWC55rxnMgFqYYCIUjP/Vq6sgao/b2CUmofd
 t4r8adLrAXRa0ERgBdre2TicTf/xO4o4lBsUVa4N1CHPot9TeCD4qC83qfp6zGH8tSL8aLTjQNn
 eflC/lc7F5tJnOT8jN4o2ZhOaiLLVmVbo5/29TfUgefY4pz0Iwova+Q7fpDX9zodRNw+zMpuAqC
 vVrF1X6OcO3qBkOGI+bpenasNpN3v5l/K1Y1ntmNswBeQ/GprZ9uVgAyNdPtb6JVAeF9JlrowRg
 9RNT4LrVhs/PI/b1C/o0qfIiO19IXPw//oSNQwDy/RndZkDZnfZoMQKfD19p4krfA0iX0sAgKPq
 AXVUy/CqwoR7qY0EX2A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512300025
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 30 Dec 2025 02:54:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18656

From: Chen Qi <Qi.Chen@windriver.com>

We cannot assume ud has the same fetcher with origud. For example,
if we set map git:// to file:// in PREMIRRORS, ud is using local fetcher
and origud is using git fetcher. In such case, the ud does have the
'shallow' attribute. And we'll see the following error:

  Exception: AttributeError: 'FetchData' object has no attribute 'shallow'

Looking at the logic of this function, I think it's the origud's shallow
that should be checked. So the logic becomes: if origud is using shallow
and its full shallow tarball does not exist yet, symlink to ensure it
exists. This should make more sense.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 lib/bb/fetch2/git.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 709c692a8..f288afb51 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -359,7 +359,7 @@ class Git(FetchMethod):
         super().update_mirror_links(ud, origud)
         # When using shallow mode, add a symlink to the original fullshallow
         # path to ensure a valid symlink even in the `PREMIRRORS` case
-        if ud.shallow and not os.path.exists(origud.fullshallow):
+        if origud.shallow and not os.path.exists(origud.fullshallow):
             self.ensure_symlink(ud.localpath, origud.fullshallow)
 
     def try_premirror(self, ud, d):
-- 
2.34.1


