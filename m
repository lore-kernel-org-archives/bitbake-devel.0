Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E271CF854F
	for <webhook@archiver.kernel.org>; Thu, 20 Nov 2025 07:33:54 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.29543.1763624028123604724
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Nov 2025 23:33:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=Zx4uAUTE;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=3419979445=qi.chen@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AK5NhnE117714
	for <bitbake-devel@lists.openembedded.org>; Wed, 19 Nov 2025 23:33:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=upVVe3VWmcsq3kiA6Qqo550Qba3LX3jnZx/g4KXSdWo=; b=
	Zx4uAUTEfFJAcCTkZ6FaniZ+sR7M+x9O/Me6ZIsJKP4lVKdDs3vOmMq6ol7mRHX/
	+282YXTYVDAaQStATfgW7PRehEgU7U52HGVI3SaXBMuKxhpc/SadIhpDmJBAjMtg
	/2THISFnIPdDro2GgroNFrwklLxOQohPx/72sJYcVKNnUhVbtoKEV/Eq1JdNBfZl
	OKr+LG6VWPcoHniSBmgbDKnZCzAy4X+qHxx19TkS6Nx2FsGMGz2ipreoh5Uzh+os
	qQQpzuoeWArqaCUftmlH5H/X6iSiC7vYcoF2ZD5wXySvWtjskv0RrtG0UDpDSe6q
	j8FPvGl83CBHGPS5HKts2Q==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010047.outbound.protection.outlook.com [40.93.198.47])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4aenp2x1hr-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 23:33:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PqkU5kTICoxUhkBv0gpEVGLae8YWmjmY6dE7QIOit6KSBhotcQLPcuT+6yEcuKCXSs/SxsKI35yeb9wu/dX2feMklk+QJblqHpab3gtKm+4yeJHo980qzibtWyOfy0QzmiikyTbXIrxfFaUJ/BYoYEIyX5POdUoR6qkBIwqYv5Gm8NZMkDwCrtELNhJQyB3Hf7zY1r1y4B0T6+dMI/TiNeZVRTcQmplC5arlM1dBaVPD1D5QQExeDu7FT8t5QAJKImHq5msm9KxbPptMtKfsRj1+Ozxx7Awl8Qh5ZM8GjI/Hlay0hlZ4tGaysLSc2cQKPuEyevBRO1KJdh0XQBT6Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=upVVe3VWmcsq3kiA6Qqo550Qba3LX3jnZx/g4KXSdWo=;
 b=Yu1R3CilsBIVTlq3NcW2vmXgmU5ssHkNGPsir3OT4Wo/pMfe2uQs0ocUJlp2qiPYMDb1e/nvt5FXde69tcH9JEq/PPAYIleac0rreM4KPSWma+TM6MOzlX5xbUfdOBCIbSfsRuI4jkeDDl3MM/AHcA6oDjnf6XZMQdJccK/IDgTCPi+dutF+TnOrpNxHXk9qGfUBGvSHrKF/SEoNcyp+va5Ns2I01oS+WhbLSc9vjIu2T5juOUZhdUfaYMDFOKlawS2RuqVRgw0CrlUyawOr1MOpB406CJm+yrdzCJlLulr0LWFX69owAaK2/ii1CINapnqXxsuqtG3iQ6ajgPhdvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by SJ5PPFC295640A5.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::852) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 07:33:45 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 07:33:45 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org
Cc: alex.kanavin@gmail.com, richard.purdie@linuxfoundation.org,
        qi.chen@windriver.com
Subject: [bitbake-devel][PATCH V4 2/3] bitbake: add SKIP_FRAGMENTS CookerFeature
Date: Thu, 20 Nov 2025 15:33:23 +0800
Message-Id: <20251120073324.136238-2-Qi.Chen@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: ea34b349-c02e-49fd-5975-08de280722e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?rRQoYkC1ElFdhR3Z27XTX+waZIWYo6KouaX/erSJLyPU/r0abMFMo1niW6h1?=
 =?us-ascii?Q?lqoYKd9QFb3V0AHIXyTZjUx55S8F20T5vg3S/0cW/xAel9BuWz0COoylp2gX?=
 =?us-ascii?Q?iUJ9JDR4x5tqnOzBm2CZr0GYsFafHiMsklR+UdwH1q9zfwX9ZRG/dPXZC59h?=
 =?us-ascii?Q?MCW3tWC8UN6e4cIpQvhVhirVG8XjkQ7daukKOyq4dAP3n0cx7GwNAHGeDO6R?=
 =?us-ascii?Q?afgtTIWqLx/Z3hs4q3ozt7RlnPdjRrBHfQKOJNXgMTpxcoxCJ6z2WV+PMVM3?=
 =?us-ascii?Q?RtzWAckE6ekwRQ6AOojcoY064gS1EuK+2ADk+2OjhCYpe/WwEnfkyJ9pomt9?=
 =?us-ascii?Q?IKY6u6SmOSyc1vOqJcGzNh+fkU3cNHUFdQbFNxJmmPcdpTDz8IckS3rkZKgx?=
 =?us-ascii?Q?pk5mdOx3FHws2eWEP9WXv3EhG9OUxIi5rCTdtIjE6byEUeryPrPwhUUEsvYe?=
 =?us-ascii?Q?tkQInndMpH3ZfZkLDJMWMhMYZSnwdPitofv15/hKJcsWroPUc5uRn73db0hU?=
 =?us-ascii?Q?iPWjKnxR4DIxykKGLY7oZO49zNWstu2BEXT5LsnyqvYePqJwMLYa1lkSquP/?=
 =?us-ascii?Q?fYGMIj4g9Jr4dykF2KR54TOj2QX6LF62T2Ryvyoy2WHcQuGPt5Dd2SywrBDU?=
 =?us-ascii?Q?2kJwdfdygT2UrP1Tyce20gxA4dy6gLyxT6zomfORSMQZcpA+0gbpbm/Ln6B/?=
 =?us-ascii?Q?q/NHjmoLITUfUDsxrR9j5Kd43prov3hqK0nfCfjIqu4itzHIMhXbzcu4sjGZ?=
 =?us-ascii?Q?geRIWS7PG3APSenR1O9aptoywo/b54wdK7fCZXWAxIpGEDY2ug9iq+Uv2eE+?=
 =?us-ascii?Q?dVoDteZGEsgnUNDjNhVtb2PQZ48qAdanxBuEAINDr8BuY1ES/qk7LVhX5rkO?=
 =?us-ascii?Q?UmEWI3ujyArsAxwdz9Lq9qwZ1U63/lKRsEG2+pBcuqHJ8ZaNun02bdTC7o4L?=
 =?us-ascii?Q?LeVNTbLKaEzxHXiw+MJwL4CHE0+pOp4aW5cmJWSyiz0klmxfp6UYLWmCpNXY?=
 =?us-ascii?Q?AWThAqvTxBL/N1vAXOXi81Atg9ntRIe5dx5XDn7hJKjGgOBRrkmof2LmTV4q?=
 =?us-ascii?Q?lQxirndEtiiCkmVGZDBchV2ry7JBYp9/VeFIArcBlq/8kiP5CuKo6xTlneCi?=
 =?us-ascii?Q?JBPW6Po5ETVZpR2d9JpsKgBNpNSxgGN1CkGliGNjPXCyGFllH/LkIKJN4Owt?=
 =?us-ascii?Q?MRv4Zdzb9b4LculUFioHKzWGWmHok4iAkXgbLMX/nIFzDHW6cbIP0W6Ka01i?=
 =?us-ascii?Q?K8szw0ntUYfTrlODVJZ6OjjgwPicBUebDOGYHcm4KAdieeUyrVNXWu9VfGMZ?=
 =?us-ascii?Q?Pp5F31H2m0oGkjiD/OpYLn9a+pA5IUq3rm02C3o5bqo9IXwkZGdB1nGHp/rp?=
 =?us-ascii?Q?5UneslzVs5oQkXqHT2FWbEItBtNDL8jXNe7k596nFCwztqyjCacsEkqOKl74?=
 =?us-ascii?Q?RyX9zU7IRY7r9Kc89LFMntgz95SgXCRfm7icCJHOytThq4oTLIrVDaKQ6yOG?=
 =?us-ascii?Q?IQCMScJpPKUePBa415mBb0aKWZCc470q+hLM?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?LR1vP89K/OUokfM5lY8fQUbjGMgu+gLh2e7pF25lZElUAiOnTthl1vyxTQd/?=
 =?us-ascii?Q?tBm+619+EFz7RVPmQqPu7/osRcUyBYHGp6vRCxrMJMbAgfKGsKFf1M4czR3h?=
 =?us-ascii?Q?LjxEM3sit5rfZ4fKkyqmy/FZwJD0SFceSu/pYhxtVKu5vcB3MaF9l9OomXyZ?=
 =?us-ascii?Q?zTL1QIKVos0yZMpVqQGy3UO8sDIjiVDZbiasaajojLupkzX6AH2Tf9AdjeEd?=
 =?us-ascii?Q?gvDcYd22M7eo6UUKT+gaRoArCyrkUgg8lT1b3oTI7vxkE5V0rxWndH4k9qb6?=
 =?us-ascii?Q?q+tGpLuJbgUyRq8ylF+FmneAOueVS9TNA4l5SU1whX8q7R1zfLG7D/10QEO7?=
 =?us-ascii?Q?hpgcy0KF3H2obFYkWerik7/3ExI1yXaCx29hrl/g+US4JD1M97ppJDj7Gixi?=
 =?us-ascii?Q?n+2lIjkqTmldzdc1I9wSvZBbwf5BJ6Qnwbqbt+6SrDRYCYWCH31Ho9ZgFx+4?=
 =?us-ascii?Q?nhsEvain5LJRSj4VQZgi/bWSPzyiDIn+Gx2jyojFUcz6U9yuQ1L+lk0xkt4W?=
 =?us-ascii?Q?1rAN11fahMSq2U1F8ES9dC+q9yOvk/dxirWVoljk5t1btp77LB4sGjp/MQ0T?=
 =?us-ascii?Q?Hs+LyKV9FJfwnkPRMWPy+JAUifNIrsGh29AgQBvH9/o7hYUuWllWi8Tf6fKx?=
 =?us-ascii?Q?3PTRP5M69D83AWWldSc42WdUj/16wPvGMqx3JQFnilTEKIksPCbYmpdzKjbD?=
 =?us-ascii?Q?N8EL8vYA9KYbeCQflSfW75WgvZfFpK92LSWskS1QZ1QwkcNG6zfAikov6+6E?=
 =?us-ascii?Q?/t/3QCK7wT7P4G2CeYwqzELe/VZ5LTN7VDZw/eGVeKY1vujmDkHwEVpms1kb?=
 =?us-ascii?Q?9vFYG+7CJNu04LfZxakI5A/ysFUXVWGV0bC3Twho9lMM06ikvwO78Qa6keIu?=
 =?us-ascii?Q?xtfK1AHZvHxOdqCeCcXhH0tL3hAvsLL4hxBfcqbYEZ6tyAhW7WJ+xZ8hBX6D?=
 =?us-ascii?Q?TXOu6QdU/lOje8EzkLl8y3T/ldR0UerzwHRUFOjiY7uHCoRNc1hjwwNApT0c?=
 =?us-ascii?Q?Su6e+9FFnCWcoI+Npr6nPb9cUoaaM/MO44i6nLQzIo4fBzDLvObozdw3Sx0R?=
 =?us-ascii?Q?qm507vRBYji4ltxAWJJg7R8mFUs+l0siH/y+5k/o6TNeKOoXH9xpPjjK+pgo?=
 =?us-ascii?Q?bWD0PvrOP+yH4dtirMg+3JaeJhHCK1kSnpC+ahQdkhdwLIGUNSM2XCZg9yCC?=
 =?us-ascii?Q?CTh5dnOYHdFeQX5aopUJnD6JBQb1jS/4LgwcgxCLIk6ijj4eaf+uNt0cy6kC?=
 =?us-ascii?Q?TxrEziLp/OBGv+d3Tz/Rn/+EANG/YPFvHYExiMkuPAzntOjQ0VfxQnTlGpnV?=
 =?us-ascii?Q?OfQrck9ZjhR1EbhbagNLBpmXCMn357xUaIUomGGCCf4Jy/io/2cULk9lmpa6?=
 =?us-ascii?Q?4/MXxTgUa/jzqF/F+BHaTNBC3ABgRoTqJYBWkvUxgo4ITq5Zp4YoiLSc9zav?=
 =?us-ascii?Q?G41G7Hd5LE9/LJDtPtaX9aERExFf1YdfhBxecS8oEY/bpv5m8nh1OisEhkUC?=
 =?us-ascii?Q?ogR/+aS6XIe+Lqw0pmSRXSEWxx1cSMl+bdaNXz9abcp1pqfP1iEyC7UPsFPJ?=
 =?us-ascii?Q?k+7UlgPmiMeRY4E1w7UprQue3Ss6MG48jFXIUgqs?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea34b349-c02e-49fd-5975-08de280722e1
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 07:33:45.0438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pzvHDSSqcw+HjA8EmD9U2ViJX+HAK1cG3Ag974f1KQQ8wiOztJ9TQjISICf8vhi6OzIzdLnBN/S9C6k/3G4Epw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFC295640A5
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIwMDA0MyBTYWx0ZWRfXy3oW7yOwtEfS
 bE9dp6mU8nT8qjPm9AvAuO3VvuA8uu9r+VL0B5CDVB0rGahKqWP/lcKo/ZTchGFq3OiKWv3/7o4
 oRMHtMjqhk+JkufCp4PyOCrdM1r5pfglRwUf+6YJzyBDZKPxgaXbzAvWdp4VTgPvxRnKM8vXZoH
 yRIzEqN31x8FOct6O40mzVYY5I/ckxxX/p9lARQwhxur3W+X1cNKc9alFm0TDx249ax56Mdu+dh
 9tHBdVCdK+xevaoDEmohA44u96LqTh8rQB5xpJujmHa5HhP3MIr36tn/v8se2Lhr+ft/27PVbUw
 CydEZXnTukvj2uTJmlmOoMbAqnzFb6LnFL8vaj12rztvMFUjZsNyKvC0k6UytoVTBI7XLB7mx8w
 KQiD9yrPkLxCP25SNYpTiqBUG/sQ7g==
X-Proofpoint-ORIG-GUID: yYtJTWrnzHrJJbL-0rOgLUBkWMzvQD1K
X-Proofpoint-GUID: E2z8DZsKsEEDazNZSKm1tRu-v-ey36_c
X-Authority-Analysis: v=2.4 cv=Z6Xh3XRA c=1 sm=1 tr=0 ts=691ec45b cx=c_pps
 a=NlF6qXdsITzFGNsd7EO88Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=t7CeM3EgAAAA:8 a=DII4xfcm4MOyQyFNyJMA:9 a=FdTzh2GWekK77mhwV6Dw:22
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18467

From: Chen Qi <Qi.Chen@windriver.com>

This patch add a new CookerFeature, SKIP_FRAGMENTS, which when enabled
will skip fragments parsing.

This feature is mainly used by bitbake-config-build. It's a tool to
manage fragements. So we want to skip fragment parsing to avoid
unnecessary errors.

Fixes [YOCTO #16060]

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 bin/bitbake-layers   |  7 ++++++-
 lib/bb/cooker.py     | 13 ++++++++++++-
 lib/bb/cookerdata.py |  4 ++++
 lib/bb/parse/ast.py  |  3 +++
 4 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index 341ecbcd9..7d929567a 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -23,6 +23,7 @@ topdir = os.path.dirname(bindir)
 sys.path[0:0] = [os.path.join(topdir, 'lib')]
 
 import bb.tinfoil
+import bb.cooker
 import bb.msg
 
 logger = bb.msg.logger_create(toolname, sys.stdout)
@@ -64,7 +65,11 @@ def main():
         if global_args.force > 1:
             bbpaths = []
         else:
-            tinfoil.prepare(True)
+            if toolname == "bitbake-config-build":
+                extra_features = [bb.cooker.CookerFeatures.SKIP_FRAGMENTS]
+            else:
+                extra_features = None
+            tinfoil.prepare(True, extra_features=extra_features)
             bbpaths = tinfoil.config_data.getVar('BBPATH').split(':')
 
         for path in ([topdir] + bbpaths):
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 1c06737ad..b896c233e 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -79,7 +79,7 @@ class SkippedPackage:
 
 
 class CookerFeatures(object):
-    _feature_list = [HOB_EXTRA_CACHES, BASEDATASTORE_TRACKING, SEND_SANITYEVENTS, RECIPE_SIGGEN_INFO] = list(range(4))
+    _feature_list = [HOB_EXTRA_CACHES, BASEDATASTORE_TRACKING, SEND_SANITYEVENTS, RECIPE_SIGGEN_INFO, SKIP_FRAGMENTS] = list(range(5))
 
     def __init__(self):
         self._features=set()
@@ -286,6 +286,11 @@ class BBCooker:
                 logger.critical("Unable to import extra RecipeInfo '%s' from '%s': %s" % (cache_name, module_name, exc))
                 raise bb.BBHandledException()
 
+        if CookerFeatures.SKIP_FRAGMENTS in self.featureset:
+            self.enableSkipFragments()
+        else:
+            self.disableSkipFragments()
+
         self.databuilder = bb.cookerdata.CookerDataBuilder(self.configuration, False)
         self.databuilder.parseBaseConfiguration()
         self.data = self.databuilder.data
@@ -363,6 +368,12 @@ You can also remove the BB_HASHSERVE_UPSTREAM setting, but this may result in si
         if hasattr(self, "data"):
             self.data.disableTracking()
 
+    def enableSkipFragments(self):
+        self.configuration.skip_fragments = True
+
+    def disableSkipFragments(self):
+        self.configuration.skip_fragments = False
+
     def revalidateCaches(self):
         bb.parse.clear_cache()
 
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 65c153a5b..b6dca7af7 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -137,6 +137,7 @@ class CookerConfiguration(object):
         self.build_verbose_stdout = False
         self.dry_run = False
         self.tracking = False
+        self.skip_fragments = False
         self.writeeventlog = False
         self.limited_deps = False
         self.runall = []
@@ -226,12 +227,15 @@ class CookerDataBuilder(object):
         self.prefiles = cookercfg.prefile
         self.postfiles = cookercfg.postfile
         self.tracking = cookercfg.tracking
+        self.skip_fragments = cookercfg.skip_fragments
 
         bb.utils.set_context(bb.utils.clean_context())
         bb.event.set_class_handlers(bb.event.clean_class_handlers())
         self.basedata = bb.data.init()
         if self.tracking:
             self.basedata.enableTracking()
+        if self.skip_fragments:
+            self.basedata.setVar("_BB_SKIP_FRAGMENTS", "1")
 
         # Keep a datastore of the initial environment variables and their
         # values from when BitBake was launched to enable child processes
diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index e6ff1ff76..bf9bd4f55 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -351,6 +351,9 @@ class AddFragmentsNode(AstNode):
         self.builtin_fragments_variable = builtin_fragments_variable
 
     def eval(self, data):
+        if data.getVar('_BB_SKIP_FRAGMENTS') == '1':
+            return
+
         # No need to use mark_dependency since we would only match a fragment
         # from a specific layer and there can only be a single layer with a
         # given namespace.
-- 
2.34.1


