Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858FCCCF9EB
	for <webhook@archiver.kernel.org>; Mon, 27 Oct 2025 07:26:42 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.26642.1761549999792110013
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Oct 2025 00:26:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=lfWylTvr;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=2395211154=qi.chen@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59R4ZNop1337097
	for <bitbake-devel@lists.openembedded.org>; Mon, 27 Oct 2025 07:26:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=ol2aga1e39Gy0UfC+Jrw
	aOIPitKQag4daWDZrPqCUp4=; b=lfWylTvrMPsZuO6XGf42Vhx44IUC7dF5sgrk
	+2qGHkvm3t28HjRMbBVbZXCISrATZORlnCgeKOEvvcUT4ZEh7Eoc62zAaHqaPVhn
	yEtLrdTemtWLmPrbKjiYspOHHBlVFtrEtsrEB25oB7eumJjuai7ENkbAIuCwocOD
	U+Yhoq3sgxPyuv48UeqRsZm/2dvt5nGEUfbps40PJmAgOK0tOJhUaWnaifNIuEqe
	Bzf7sfHSxSaojHIdhESJMsv1EYud3iYjJTY4vxwZu3TqP6nUuoluwR2owDQMAjBj
	y1TYKnV21MzV8eiFlshhleaJP1FpUHguxQzHR8h99LnyJXETjQ==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010043.outbound.protection.outlook.com [52.101.56.43])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4a0nh5sgm8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 27 Oct 2025 07:26:38 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tCZGqNOCyTJwUIMpdxkatieHLQXPEAGS6dVUo+KbRBlzKf0gtPfE+UoN5J7ZgX4E+sTxCrCN5TIRdZ+ilrWofvX/IJiDvWuJbUzlb81ZLNt4MIX4JxsxEDUxQSx08jETk1b9jbxKsYE41bL7kqKe+2xqZSmHsnPZIRnu61cJBUAb01uMM19rRJtVKFLNDMgk+vqNOGPwZ3eNv1Cd8c4sqlIxOqRui2rWr433Hqa7oEmD9CG8esHrWuSMlSRV5F2BUkDR6uBJOO3Ri9Im+hVSHFIuRXdmdcWUhV5oolOEBdndGIGfuCep7yApBWaADJ0HovyNe8MjWqSil3tGaRGcHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ol2aga1e39Gy0UfC+JrwaOIPitKQag4daWDZrPqCUp4=;
 b=TnSnxUOm0lhnx+TPeiURBZQ5KuWz18ig0JWiFvyRivVM24cANy9GPrcnlSkYVbUmIHz+a2JURAU+dwE5u5rERYotvk6hXYMzLSN3lqLxTORB0RTkm5Gw5z/w4uMYj0VNQSff+QDapAjUwRWBixvQFncwwTeL7zvKx0nFCMaiuSaMAjnrGDjwwI2DAuYR+pRvlmn4jMWJkhVlZneZ7d5i9oktMUWhIWXD+2IQXd+S7+jSV2BRecBidrf3/rHN2vOKjUklZx458f8mwNbMGA+hYb9rDUtDxab+5mmjdRwbVz4STRG+Vr+D9RWEA/8xN0GNRFGTB3/J2WEj6XTssqz5bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by PH0PR11MB7166.namprd11.prod.outlook.com (2603:10b6:510:1e9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 07:26:36 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 07:26:36 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake-devel][PATCH] bitbake-user-manual-metadata.rst: OE_BUILTIN_FRAGMENTS -> OE_FRAGMENTS_BUILTIN
Date: Mon, 27 Oct 2025 15:26:20 +0800
Message-Id: <20251027072620.321672-1-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:195::13) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|PH0PR11MB7166:EE_
X-MS-Office365-Filtering-Correlation-Id: 43796339-a70c-4e44-2ca4-08de152a295c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?qZVO3WUgu7tM4+xoxIQfDdKFN8Gna7ynDAacZTvfm4V84T5al8/Qivp54+IW?=
 =?us-ascii?Q?fBsnJvloMsAD11bb/Qdx8dIL9sZTkAlRUfFJysHN3ctw/mKQVdW8NiuaVqbO?=
 =?us-ascii?Q?/hsgwcBZOAlMBLcy51zomOHG/Te8kZGO8P/j3lpx/CShdXh+8syywSiNgggk?=
 =?us-ascii?Q?cSCegK8bpFNsHgfJgzTbsPNAmRawS0hn5MSYsVuF2U/cEK40m5f3ekzUdCZ7?=
 =?us-ascii?Q?qXiMI6FmEkr0ibJC+pmyxEbQajFGbkOTCdv7ZELRATzGr+0sELWCocSYzI6q?=
 =?us-ascii?Q?2AwmA6ykrkrH6iYz2nYfWYiVloiyl45ToJazGs8Nag6EPI26oaSom4ZWIiTA?=
 =?us-ascii?Q?o//ZV5OGXsz34qN8j3ys9hNid+pUS5q3DrJKjoZajlalZNB2xGLSm1cGdrgY?=
 =?us-ascii?Q?7sg5leZ6Px2vLa9KIfAwfJAxQi8UU86pzL1s8gmDRORSxKzGSSk4w+zdMK6s?=
 =?us-ascii?Q?91YoxPwCF3Y7LD0zEMX+ZhIYe35qNypfFFdm0twUB4jlpVtWH0Cntfiw+Be9?=
 =?us-ascii?Q?H1zRzMkMfRURiV9J1oufCnu9kKD1LDYjCT6Xx/4hQUWVosXW2qqsaXg3Rnby?=
 =?us-ascii?Q?bjDEA6hjoW89aBbaCHlG/LE5dc7w69fFf8oL1nry6J09yk1s5u35t7AQPRuy?=
 =?us-ascii?Q?Etn7OdbW9CspYN8BrdAapEiJTZYcfgD14FR7ebBKxoC08pCENXDMP2oFTlW9?=
 =?us-ascii?Q?vzCO+75yC/mSLZ0iyvsnzg/PYsCG3UP/g/cGaAb8pkxju4p1DCWWxcvJypvu?=
 =?us-ascii?Q?9w6tEaWLwkxHsmt7dzP3NGHJ/cXBI5RqrpRpMvXV3nLhbwGplHqmIrDX3qez?=
 =?us-ascii?Q?KS91LaOD5gwkyHv15ofnK9yy2C5urpznJRBmL6XzAt4Yu48rRyzpdmpKyRk5?=
 =?us-ascii?Q?Q2/lSZWXj58iTUxEeTW8erYSgRLAmszX+jZebbKeP+X3eKXsverlcH9eFEWZ?=
 =?us-ascii?Q?0r3jp69b9NkUnO414ebrVjc65Rzu8lVWh1I0XHZsstm72rSeTPV3Ix9G4WIR?=
 =?us-ascii?Q?S5QrQDzfkkZHI/jARaHNMYygOFnZlId2PwzvjpHOo6OG3/TmC0A7K1Q/ivgW?=
 =?us-ascii?Q?Fpau7d8dTD7Si/OWGiteSqs5x4bA5TG3SfQ9UsdgcfONQ3n8WujFajkPKjOW?=
 =?us-ascii?Q?r+EgEHfCD3MOJe50A/LzjNAyegtWrKyw1DFDa/zwWUo76zk05chuV0q2Pezl?=
 =?us-ascii?Q?XsKsxtt6GNxW3+GPzOGn+qeAsrf5oJ1SAowwhSINKBCJF/IY60a61+vu2tS4?=
 =?us-ascii?Q?XlOQTVZIL+9p2rWBWummwYEiq7J7JDGD8rzwpJtaELi1SR3DupbyVlV0qncu?=
 =?us-ascii?Q?JYms83mG7lPLKlafgoKisEirdf2x3+zKdzELcsWs+C2XHpn+B9M/etegvaeX?=
 =?us-ascii?Q?PQIkHzZSLz1mx0fFW/ktbzS5VJRUvx/raoIrux5Am8GjITafiuLo31FKaynP?=
 =?us-ascii?Q?V4i9bCKdU9ZbeQhe9thOc5FBUaW1Rt+S/W8Nr7HGUH745BaETDVFhH82CrFg?=
 =?us-ascii?Q?P9TYik5Chhr9PPQlQF0L5/MNu3pwz7xVw1HR?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+9Nv9SpeGDcJ1rBwgiHhTQDsiAeqOEndnG06USnXIiQp7HxDPOr0OYQTtShG?=
 =?us-ascii?Q?ZpbH8HZs8Q9ku70V56blAZaVSD5avo2lQLNSDQ629lRToJ4GpBK978qYfgAN?=
 =?us-ascii?Q?av0QLvsWWiaSeAniIXSzqZyZTbDCy/1x6z7/QX3JaAlv4HglfNfzHszLdAoA?=
 =?us-ascii?Q?5KhCkOhSBsXFYHawOAwtoyKiaGWEBzjuJ5CN5o9gE6Qp8opqATGsYUyTvW0v?=
 =?us-ascii?Q?ceETESPageUvlk48dtnKiB2/+O2FZ8v9u9KlsuB8AU1YKhHw9UxTeQX3UTJH?=
 =?us-ascii?Q?Bq2fHvxTujihjOupccH/8zKxVYihFlZQXwZE0Qea2lJEytZpgkDYWoNKSe0n?=
 =?us-ascii?Q?xDCVPtbPRxmRT7EBaUrgDb3mAdcSpsEWIyocss9bnIw/rl5USePP7/2KZa00?=
 =?us-ascii?Q?YrWsZsGV0xsJ2rGk+2PSrhcCY7+LQxBwAcreZhFe5lUfrdyBTxU3yvxCaud5?=
 =?us-ascii?Q?LnUJx5pwWRjT5pO3v8wux3Fh4MH69e0XSS+4G5GC2QS8lX1lwUKjtqrcEoPI?=
 =?us-ascii?Q?zV5I0t2SnwUrC0qn++VuOA987WHMeq830xRwGxApTxsg4766cJwsftkkKGAM?=
 =?us-ascii?Q?Jxed6NKFH/LyKtQou/FLGRjuJH9fI+6QsPDOZvJSk5jGWlSBNEOHbmbmrv2k?=
 =?us-ascii?Q?udyq5nqzbPnBe8FQ9oiUIjh0rIoUCc82gRrPi/VhZveKQcjfavlYiIELadsP?=
 =?us-ascii?Q?ylEyFDimCCWoUkrr6nMrB4zs3zyM8rXHJq3d+OHJpFN1nLVagl6pzAAmscgl?=
 =?us-ascii?Q?7KQR4Rh9lSyC2mEHpJLCMrnGaPh/yreqrOyhm6sgM1fF9qh3VEHo7xXGw3nT?=
 =?us-ascii?Q?I83/3N1qm2yWbEvUuxSuA3sEKpJUdS8phMLjsjL93s7Sawcy9aQGd0iMM1n5?=
 =?us-ascii?Q?BXOkocr70J08570/CKAvVLqGRXKgc0l7MKRuoW97NePLUOw5c1q7A0zazUIc?=
 =?us-ascii?Q?6W+WmPCoTqfM5OU5srcuNCuP3q13FZ+8OumPlQuatgzqtJdmXtE2+3QP0qbk?=
 =?us-ascii?Q?DQZ7VYH1yEu9NWHr6GmvbYkh0wxVQLa9FCaUiOWGH2JV0b5hJSyPUpZ9Qcr4?=
 =?us-ascii?Q?esj1+pB9Qrn07F63qp53xwyAv7a8e5RBcpRH7IZfAmvtkKoySbkKi+IOoXfb?=
 =?us-ascii?Q?BD+N6Odj5LRSv+bP2wEde3iuFQolPc4fbJISxZMle/DtHt+na76s8XhRjv0Z?=
 =?us-ascii?Q?uZtsP+HEq8MnLNDQVfEHbm16ZaEbo5Weyi7p6RMiUR0zhrGhJASsljasZfA1?=
 =?us-ascii?Q?z0Q6Q/FNtj76aiQLMkrEZrQ///KLAYfQT37OKm5JrjBW2Xi2PToLpkpzKScd?=
 =?us-ascii?Q?RM5Ik8oJSePBvanMtBtW7ZAWei1r5Guz1/GvbJl7eeuc9oqdRHr5SyweeekE?=
 =?us-ascii?Q?q4UXQs3Eijt7RwR7JlicZioCV0v/Lb7gKFfWwjYKPTakwgXoOekrQgyg7Nug?=
 =?us-ascii?Q?X2EUZxRUjOe5mKh33dQ6y+rBeTpyUMBQqj92+TS02PpZg8EaB2zW5OiLdb6d?=
 =?us-ascii?Q?ED6wzQIIJn/ithO8BXU2z0r6qJzG4v0KMYFLRGvdND3bKDJK3kJ9T2eKtCcN?=
 =?us-ascii?Q?go1abc67LAFQVaXf1joKRoJpKcWwBY9wY99uWlpz?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43796339-a70c-4e44-2ca4-08de152a295c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 07:26:36.1751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cDRIdENs+gQJiJfHdHz90NIUe70SoMBu/BSoIqIJJheTjQS44dXEh5wYYbg9dZXn1ZVYBxibT7t6De/O7ncpRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7166
X-Proofpoint-GUID: aHfFxuBKF8q8HCmZDL85EWjWHsdKJq91
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA2NyBTYWx0ZWRfXwyhGT511dO93
 ppwg94GMBQFQLAviSZDrBSajHeJ5ZpQ3Nz+9Ze51DddoWsUaG1cShlLabxj3l5PgphAYoB4gQBo
 gSXl+BkTTPTw4u5OiBAWphdQZCajAWsRs+vhvDNCYoqIDoatU0/WE2oXApff6AE5hsdcwyDeofK
 ppW0+Sves/7QqN2DbreYYLsTfbAsU1OSjCZt2UyktOBnBVjCfu0sKmhx8JAjdAC/3EscsDWzBeT
 GnyRd47mK0+cGrSaJmsntES9BRqWcKsdwHAWmmR+BuOhxRMr/7G/sdCUxavdZTrj2Q1gRkTg81u
 Kl/yYMBfLFmlbMmIDnLumDwrY80ytjaIL4D7wfEcvkdXgy6CEdNOja7s1G6jmxUzdXV3zAuegEX
 gtoQIzU9aFxjUJCY/+eo0d9VpgctFw==
X-Authority-Analysis: v=2.4 cv=FOoWBuos c=1 sm=1 tr=0 ts=68ff1eae cx=c_pps
 a=vO6zNWk7R+xgFy8KGItNOQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=t7CeM3EgAAAA:8 a=al99yDq0Tk1eiIlXpJMA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: aHfFxuBKF8q8HCmZDL85EWjWHsdKJq91
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 clxscore=1011 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270067
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 Oct 2025 07:26:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18216

From: Chen Qi <Qi.Chen@windriver.com>

The actual variable name used in oe-core is OE_FRAGMENTS_BUILTIN,
which is in a consistent format with other OE_FRAGMENTS_XXX vars.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 6a3488ed2..e5075a346 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -999,7 +999,7 @@ This directive allows fine-tuning local configurations with configuration
 snippets contained in layers in a structured, controlled way. Typically it would
 go into ``bitbake.conf``, for example::
 
-   addfragments conf/fragments OE_FRAGMENTS OE_FRAGMENTS_METADATA_VARS OE_BUILTIN_FRAGMENTS
+   addfragments conf/fragments OE_FRAGMENTS OE_FRAGMENTS_METADATA_VARS OE_FRAGMENTS_BUILTIN
 
 ``addfragments`` takes four parameters:
 
@@ -1040,7 +1040,7 @@ each other when several fragments are enabled.
 
 The variable containing a built-in fragment definitions could look like this::
 
-   OE_BUILTIN_FRAGMENTS = "someprefix:SOMEVARIABLE anotherprefix:ANOTHERVARIABLE"
+   OE_FRAGMENTS_BUILTIN = "someprefix:SOMEVARIABLE anotherprefix:ANOTHERVARIABLE"
 
 and then if 'someprefix/somevalue' is added to the variable that holds the list
 of enabled fragments:
-- 
2.34.1


