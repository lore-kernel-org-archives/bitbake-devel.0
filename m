Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8BFCD3427
	for <webhook@archiver.kernel.org>; Thu,  7 May 2026 06:19:13 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5952.1778134752171749224
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 May 2026 23:19:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=JhMYbQJD;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=9587885fd3=qi.chen@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6475KetD3268537
	for <bitbake-devel@lists.openembedded.org>; Wed, 6 May 2026 23:19:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=cBH7skyi9vYmfIDyznFMicMZQ98OLsR7ozxkbg6kD2M=; b=
	JhMYbQJD3Y29J6f2wagV9+Y1aRWb/2aBkvAyOIt5z/hGXqIakf63f34045B1e2Uo
	BsFDcTwklQd74G36nKTlfrwbMZuGzdQhWAU95cqKGKVfOKzQB0GCqkn5z7pLsXvm
	xbEZC/4pWCE7Kr5ks8ne/4nQXs+vgzrSjYpcHVrkM0aD4qC9dd/OMTvRi8GKrIuo
	7+QMlps9LfgIyMu2IT9sdABTCKohPwpc0m8Bt50ml3KnUcQUCQXpdGf13JfUELHz
	uTOb7ZskAe0f/LuEaHqRc+l4+Uky4yqMpHGouWvQio6RjfEFv/WBzgpPXwny5ZMS
	83WEBMYZ+IKlJ/d7Eb6e8Q==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011048.outbound.protection.outlook.com [52.101.62.48])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dwchywwmc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 23:19:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ALtJ9Vp/CMYDYYVRSAVcq/KgVUKkZ7kOeR4KXXSe6+GGyFwRTy5cWGJCP1jVTjarXstx6P8FUJIUGUcqaTZCGY9BVs7MA5bD2zRY9B5+4tPPeBxsfvv12hXsdqnm4iEROeKmx6CcG64Oa3EA8vratGBJeqFSm0lUSXJPlZkPj6e/f8tOZ7xowLWI60AAsL/GfK7cWRjYmjzuU6xScTHTCYu6drFB58KLJX5A1uYUG8ZS2j4Qk/OxAqo7IiwaDLg+ooT3El4kln204R1fHKGNV+7GXYMYcoTY0oGGMlVuv1VE5BBEu2gmbFtAECGxR6Dzw1xie1D5Cl9AMsHKprdPbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBH7skyi9vYmfIDyznFMicMZQ98OLsR7ozxkbg6kD2M=;
 b=kKri3h471TNJUsrYf0YM8igGX0bHrTDiRM9g+1kGh20Pq3sxwvnMMq8hZXI1E8YGxiAlqKfwetLQQwuixWyebX4TtGZP+py05nUleMaWGGQ5ZFjZF0OJLuo7b2y1T09Tpe4RP77Ob2iemD5LPmx/nS0LjhPIdySkjZTqcYQLZQOB8vpiSJqrv0n5cBjhihYJuCvQ+5T/huaLHNvLwzNSusnOHMU5eSCyj3EZVW1XcnFLUbylLHibANioH5zyXiotTqWUXv3XX958U9b2odMBWhZzTmLVSBjvZ53ki4xtQtK5VJJugLlJYHeDITLEd7GBfQfVcsva2AmILOeQ0738Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by PH3PPF383C22AA3.namprd11.prod.outlook.com (2603:10b6:518:1::d17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 06:19:09 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%3]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 06:19:09 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [bitbake-devel][PATCH V2 3/5] fetch2/crate.py: add filter_regex parameter to latest_versionstring
Date: Thu,  7 May 2026 14:18:43 +0800
Message-Id: <20260507061845.1460893-3-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260507061845.1460893-1-Qi.Chen@windriver.com>
References: <20260507061845.1460893-1-Qi.Chen@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0217.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:18::22) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|PH3PPF383C22AA3:EE_
X-MS-Office365-Filtering-Correlation-Id: 944f3e5e-e185-4fd9-304c-08deac008c7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	x7DPN+9wRfKbcSf7EQrkChgjmeMIBztEJWAto3hz8gCNsgM9uL2HrFRm5o7fDW47ddq12BO4llKatP8rRXxB7JBzpNRrgJHQPbKRknsyUJ4WRhJhrusxU4BYY3Vbk10H+ZVaO5x2s7cqD+RKARUlF2LOjp68KzzzS2k2H+0xMb1s26QBOoBQDLCbGN+mOIF8LHFG2IwQRlIPZscmMB/60OOKQkVlVBwG83ON58Ow35hdkExLP/QuGxcqFJzOth3G1Y/WfY4758GuQrZxyNopd53v32zZy7z2i7hFuwLiAf6AgC26yTIo3vClMoCclJiJqnq9eCq8E1gqSzrUa4DVlNpusSjq5Lhy5MJd+3NiWdTjDoyudUXoegdy1UPM298f/sFETFV5iZKI5zvxy6e4UHQ73nttkKKGl5bN9YEXFvbUtWF+ien9Qz+e5P4B/3aYKzb4iu/mesiImfQwkfF7SFfrTvpffeMtLJi9oPyz8QxYDtDoRt++yXINSNsr7IqGQWu1AO8tV6uWNvsuFxtvyHi1EoSUpmne4jG4uC7jc88pc994N/1VJQGBZprrcWDXHb8al2pVxyvIXfmlROmhEU08Ag9tkSTfhrNDKGiVeNcoh/ndln8BBpUmvBYcZRVr1BEq+MqgmNtnVAwKNdy1NEypKmz/tpYGgyIKbdcCh0q7I15hG+xN5/TdWzXRib/IlQ9wcwWijdwMJP5CanGS8a+mTFl8AXvpjDdUlAoFWnbo7clN4ZumqM4Utc1/sDK/
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9NaPX7UChIPn+Eq0JBtYsHAYs3JGn3ZczMBmInAkSHyhevXZrqSQWOEL2fcc?=
 =?us-ascii?Q?j1H8T2PjPUYbseNE14Gi+KWZkcu+xR4YV67Jwyb6PX3+LD+Rwv9S+MyQ8GQM?=
 =?us-ascii?Q?K9HEkTMZOgRb3iW3Go/+gGZl2xpgu9PLr6uCsD4pc1g6mEtOkkIo4mHJ9BEL?=
 =?us-ascii?Q?8lS4foU1XpdFklO4rcYLWhJBJuHYmkF+dEUpe28CiBD2uHP1vFFy3YFve9kl?=
 =?us-ascii?Q?GFDwBadXiMzdBe7Ew/6MezmO3JRLkVy1OLNSVu365zuSHBtxoNb3VhZgmw5z?=
 =?us-ascii?Q?o9WmWsKDMGhpvEw2p+DxX/b4wxHF5WyRoj5scmNcOuAZ45jS9umgGpdepEk+?=
 =?us-ascii?Q?FoOo2Vuk2miycDOwbDmPZSLl4lStOYQHk+Dr2BAR4JanbexU611dKep5IXej?=
 =?us-ascii?Q?M7RPAuFL1NOy6xvdMC7fmd9Mei21m9iNouxKEq2TvGIc8VB+Nm72cOmGCxxc?=
 =?us-ascii?Q?zJlmcn5VbT0+ya8BYgVxfbCbEaTQwDxg6tazG81+CobTMpRobJnBO8l1WsmR?=
 =?us-ascii?Q?Kulol64vWpmlDuJ7WNOAA6TZFaJWM356IqUPiRw2c+Fy/7YhspQzsC7In+zv?=
 =?us-ascii?Q?cfk19Sn+ENGc3t6VyrdFjXkcnCdjECm3JUI4q16fraUiA+W9sXEsfe60ZYQz?=
 =?us-ascii?Q?w3W1bemugRGEtEBYE1wYUco0fAHGBP6+kxn5+ExUtUXZiGKXnOX86vG1A1FD?=
 =?us-ascii?Q?nLLf+Tb1JU/gw8F95Ooe3eAvBqqknAPPhwD6jOuhSBrhytDYm2nId58Ae8nK?=
 =?us-ascii?Q?FCTWabFRpKcgrBGNyzNYZuTjHPAmrgxS7VTkW+GnUZhP9qEyr0OPS4HU82UL?=
 =?us-ascii?Q?xY0FWyI8khJSf/RLoeeqoEECbmoqeGxsvhxWEti0rSrSauy7Z0NC4emu0M+C?=
 =?us-ascii?Q?776SH1a7TOAQW8ZsM/vp/vVLoXvjk9X9n7jL5YtiRIdVik7+2fimYqbdFcfZ?=
 =?us-ascii?Q?mj4PNuJsewxk8d/RtgT8n91EcfxrNsyEuqnEiBbmCjhqSGOOdlrFWzLL0uLN?=
 =?us-ascii?Q?KDnC5RJFZGV5O3fo/AgFnohfYkw3JKkMKgINpu78HYIpJIbuNvP3GIGBOyMJ?=
 =?us-ascii?Q?m6RJvj77+4dSaO0+UTDRmduyeGPrg72s7Jt/VaTp0SVhXiLbh/jnOSB2fFi6?=
 =?us-ascii?Q?kpDBkdy3ARBKm3J4KAuCKUguNX59GbO7wd0SGgfIoOZuN+JOsWF9SRWPsHZB?=
 =?us-ascii?Q?KUDfZiSCwYuYgivX2n0PiOiQW4DrgjUTEza+EJjPB7H6toULiLjc52jqKVKa?=
 =?us-ascii?Q?yJJ7P5wln5USIhlN1f1U32bYDdEx9Upce8BFdJnUfFB5sP49X9ISkjQ8oyCY?=
 =?us-ascii?Q?3rz9tebOZn4EVoJiULmFTm/SLXIyc2SEWYytpO/LAMn+DuKrDSikH1FpYwdk?=
 =?us-ascii?Q?ehtiA97v2YbAGbxiwW6Xc8n4XG65/Hk1knQ1jdLKMt5gmEjeihWoq0HPJjbb?=
 =?us-ascii?Q?iccROYQNMGloSDPw1RuDPmoLOXbP6bXHt2reC6q8S7JhJCvCROwl9LdIhTCK?=
 =?us-ascii?Q?H9Dnr0FgzmRY5whztmonDhxxbHLNeWsAN1dZT1gZDm9xmsGO0CxATJ+vM8N8?=
 =?us-ascii?Q?WRKA7AukYjEk62RR7FUlaWP4GZ5B6um2U/7naC+Qa/o5Kx8Bb3b3/rbMU+K5?=
 =?us-ascii?Q?l3dMso2fEgT4+QffVHRrs6nOBksWpEknVvyg5YIsofrR2/vbrfEQ/qVxTE+R?=
 =?us-ascii?Q?iMbgbYpxLOmXBbhwcDBx7S1OU7QdAcLs6+B/CvjdzeWfCGMbQSEZ8o93STgd?=
 =?us-ascii?Q?ab7KJITEcg=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	b1zRmkb6s97M6ftDGG6mTAIIodChiwAAWvGJy/wDqDDvl1D+syuvk+MXkdZIAXW2lMYn/kxnqMFK2NnWCTrgiofuudSfTZFxQAPLIT4w6C83yL9mZcYDkmiRJXQE/6a+dDhH7CIQPGezkyqtggGobpiBUxNqORlL1mcj6tuo3lkvhab+7jEupjNd/CHJiANFXqt6pj3TCnCZFgQmsJ3muHPAcOZ1iVD4/zZ/Bmim+XSJHGMhca4uImX9rHBGCqzDbn0dGvm49RPtViC+1gNkW8x0iPKhShA2lpLu55yn0DML+pPF0NhJwFADUCFo17kpAU4cQEou9INDMh8cm1TQdQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 944f3e5e-e185-4fd9-304c-08deac008c7a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 06:19:09.2152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: paI05ak6igRoPs9Xv+pbSDVZbou+ZPexO2kOScH4G153JTG/HzFCfOk3JxX37zGMYdrt9LOA80FRyyOPHIuSLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF383C22AA3
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA1OCBTYWx0ZWRfX8iVh2AHSuqLQ
 CqtzoH5Y9E0UmQMd3ke1w2myjJwKgk1W2L5r7Kx5rnWMprfybEVyvkxU3NTdP6n0EMc++eqCCuS
 zLo8dgAoIbxp2LyFccKwHLbjSh3tX826hYvEK4SjQFT4TNLqsDSsA+m+l6TOtkgqpJKz7xbEltM
 PRnRSK/t53cMUyfzXNfbOxV/jrR3/8MISop4yotfldjMMwp7jkh/GF/m57folbyVn6r0vEBOwJL
 7Zo/2S36Jaaz78HHmRvTfJYAmHz4BS1ojbrz1hoKKl3/hKA1A38JwdfTRmIuy2NpTtED82/Vqzp
 5j3E+drL0GDn/hDFn4acb+ip/0qkNwTe3Z221+bfPkOsMaCYNsBaEqRIHntSbu5oP1ri+OCq48A
 Jee73HqqDXRWbJX5u3HQOlbAGM8VYvKAXQ+bhSnwTGDeOob2mrZ6nJueQjJosj1gf21MLjJEAIj
 4002PvpxrBADPylebQw==
X-Proofpoint-ORIG-GUID: phES1rqvwdpD1UOXco0LWgRDbDv4FUa3
X-Authority-Analysis: v=2.4 cv=LsSiDHdc c=1 sm=1 tr=0 ts=69fc2edf cx=c_pps
 a=puQxxl069aAozDPRWZ8vNg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8
 a=hIPOLQWK0ZafnOV6iRwA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: w1a0a06g4oLjTPB7BWlx7vA-XmETPM83
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 suspectscore=0
 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070058
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 May 2026 06:19:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19453

From: Chen Qi <Qi.Chen@windriver.com>

We want to be able to do stable version upgrade for recipes. For
example, 1.0.0 -> 1.0.1 instead of 1.0.0 -> 1.1.0.

To to this, we need an extra paramter to latest_versionstring
so that we are able to filter out the versions we need. Using regex
has the advantage of adapting to different version schemes.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 lib/bb/fetch2/crate.py | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/lib/bb/fetch2/crate.py b/lib/bb/fetch2/crate.py
index b89817ab9..1127fa802 100644
--- a/lib/bb/fetch2/crate.py
+++ b/lib/bb/fetch2/crate.py
@@ -14,6 +14,7 @@ import hashlib
 import json
 import os
 import subprocess
+import re
 import bb
 from   bb.fetch2 import logger, subprocess_setup, UnpackError
 from   bb.fetch2.wget import Wget
@@ -155,18 +156,26 @@ class Crate(Wget):
             with open(mdpath, "w") as f:
                 json.dump(metadata, f)
 
-    def latest_versionstring(self, ud, d):
+    def latest_versionstring(self, ud, d, filter_regex=None):
         """
         Return the latest version available when versionsurl is the [name]/versions URL.
         """
         from functools import cmp_to_key
         json_data = json.loads(self._fetch_index(ud.versionsurl, ud, d))
         versions = [(0, i["num"], "") for i in json_data["versions"]]
+        if filter_regex:
+            filtered_versions = []
+            for v in versions:
+                if re.match(filter_regex, v[1]):
+                    filtered_versions.append(v)
+            versions = filtered_versions
         versions = sorted(versions, key=cmp_to_key(bb.utils.vercmp))
+        if versions:
+            return (versions[-1][1], "")
+        else:
+            return ('', '')
 
-        return (versions[-1][1], "")
-
-    def latest_versionstring_from_index(self, ud, d):
+    def latest_versionstring_from_index(self, ud, d, filter_regex=None):
         """
         Return the latest version available when versionsurl is a Cargo index
         file.
@@ -180,5 +189,15 @@ class Crate(Wget):
             data = json.loads(line)
             versions.append((0, data["vers"], ""))
 
+        if filter_regex:
+            filtered_versions = []
+            for v in versions:
+                if re.match(filter_regex, v[1]):
+                    filtered_versions.append(v)
+            versions = filtered_versions
+
         versions = sorted(versions, key=cmp_to_key(bb.utils.vercmp))
-        return (versions[-1][1], "")
+        if versions:
+            return (versions[-1][1], "")
+        else:
+            return ('', '')
-- 
2.34.1


