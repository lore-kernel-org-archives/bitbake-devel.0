Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF1DC46CD2
	for <webhook@archiver.kernel.org>; Tue, 30 Jan 2024 11:12:26 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.15725.1706613140330798241
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 30 Jan 2024 03:12:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=QWioHsOg;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=275922e335=qi.chen@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U4U1HD004564
	for <bitbake-devel@lists.openembedded.org>; Tue, 30 Jan 2024 11:12:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=PPS06212021; bh=prkQHm6S7eTu0Ur9Gq
	3OXITIGzVoj6k+cNDquqNylWs=; b=QWioHsOgBg7/swxurhjErfoDfIIzko68dZ
	LFe2w3gMOQPoIGfrI0RWawK1MxEbdumTZCNrG5ohvrbT1sRtyHyoU4aeG3GQCJZ4
	SSY+6XfDeSTJdFelodw4C9wqAy175emcswXI9YtafFOe4Er6pG6LI7OfL2GUgbM+
	OIIbV79FjQTnjN8k/DgVuYKY4GTd8eZbMmWKvRC/T/fWK8gK3Rja7lDKd56MZEYK
	g99qlYHgq5iHBAG/PGj48O/z8AZdidGf9CHhzzF1amB7X41lYw4/6k65Utu/T9zD
	R0VppqfefK29HR84KC8oqhQz5+JvtxxKj92MMXdNnfhSvvUvmRmA==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3vvrt62twc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 30 Jan 2024 11:12:19 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEX7JJ4YjPrY7NXpfb/8DmqjXHV0YuQf0Rk1fJOZQYSoPS8aYG5b6PNSvIzXijEsDyhdutla1RDuxeSRulcZ3MB4Wot2JX69te9OBss1qh3sTUvDfgzZP/m3/nSTGgSk9kZSBs235iG/slPSiml9y0xLx3kYlFDCVXLTiLmRd9uH+BPqmpJ/fyc2i8WneVxAUiTLGhFgYQ57SeENyuzBjp8wPbsNY1/X/9EkVd4coQLiTt9s8c4XOPdlpnwNmvQbsIYPT4NCrE3oRqjjq/4QkSEZVfucgQurtSF4RBMLPclX5J4vgwnYVTdD1wqUXEYLSMuFUFzcp6eGEvN67I+YUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prkQHm6S7eTu0Ur9Gq3OXITIGzVoj6k+cNDquqNylWs=;
 b=VWIN2Ml7gsDjztUShIc4J9TyLQZ+kygiBvEqPWFEeiHphS5Qxk7Hc58nOajRfBCsH2omgxfxAE8yflDeHH1WKy1QlkuERr47lMRQeIFilX1gOxCGfvk3nyEehBtN0cOSfv0CK9niJsxBSMzyfVdMjpI9FQfZJBU+Hs2cbBOCk/42ncb2r/UQzatdgDUyxHPDAK2nUO35LGaJWDNM4NyxIzh27GgbGdmkAtT0qO0i6xf0FpElEW1BjFiVSD/XvcqiM7lsf2gTlh8vT9xJ9HsRMr2GmJG6TwW8d36A7wpmR4x/PSpjfr5Qr5EvFSKyF9zjLqTV8NSB/I0PDWCD75PY3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by DM8PR11MB5576.namprd11.prod.outlook.com (2603:10b6:8:37::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 11:12:15 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5d84:2b01:5029:9315]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5d84:2b01:5029:9315%7]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 11:12:14 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake-devel][PATCH] fetch2/git.py: fix the try_premirror logic
Date: Tue, 30 Jan 2024 19:11:58 +0800
Message-Id: <20240130111158.1077626-1-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::10) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|DM8PR11MB5576:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a37485d-f06b-4ce3-d1c7-08dc2184500b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	7n2oMEEUI8Mh/X4tizs6X/VMv0EbeM/dOQwQr1ailsyJ38UbC0ETlJOCMp4QWM5ZaLef+htJLrhFkoFEbweM54Sg5KnCyUVj3zLjPIfLxv+OsW7ZjMIsidTSqfBYeLspCsMqnn6Cqxc+PR7ck9k81Re1VUf6XIRKum2+UOm68uYr9UMkrzZSfdPtrQJL0zfCELn90GuX8Dhmn2BSc/2shfaGrp9X/vcSuJE+tUli0mzI+lhDA0uoxkTJ4t+RUmG4PgRL5daCcz5yYwRkmfMc+oTSs8a2j7vK282McPuoNEdTPIhhFL7/7/VN2O9UGCzGdyVNxCWKe8nxxSVJu6ObgUM1FdfRR42AczaXBIpY4IbGDwqdhTsPZX/n4ISyZR2AvaPCl/XZj2/DanX2kIu3H5nhCEl/q5ZDTBIk7HBjWONFCcj+yytfbgeTVJaNK7wTYxaoojA3UAizdlUzn3c7BpA1GCb/YhR1o3epKH3X30d7g5aSTEyY/h9oBVab4fTKfBS2DAKtFzA8/NgZy9IYKx/UXMXQ7nKZSM7JZpDeTTrsmCYQIDwmrpMpuhb8Obu1DZal9DlwmBhDn+WkHwVVexcf+2sojirv7ADOCirI7aMq2QjLgGeqkqtVYrDXHYxL
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39850400004)(136003)(346002)(396003)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(2616005)(1076003)(86362001)(36756003)(41300700001)(83380400001)(38100700002)(478600001)(6486002)(8676002)(66556008)(66476007)(9686003)(66946007)(26005)(6512007)(2906002)(316002)(6666004)(6506007)(52116002)(5660300002)(8936002)(6916009)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?7ceft/QXAHNfNkiJh1F/1MEHWcyNewk9ZwJkBadODlSvkV94dGDvipCZCKJi?=
 =?us-ascii?Q?m+bo+JDi+PlAWkVaXYsBFabSC/ow2hcoET8HJtfVkq9MpzQmGyXjxWou0dDt?=
 =?us-ascii?Q?oWDxYnRYUsX3J/YbPw6BNsWOauYOwTH3fnCzfiWECW/Od06NsUMGcfYzB6nY?=
 =?us-ascii?Q?ZmI7dyCam2YojENuRj8rpHilt76zYJpzG6BNQx8BtMivSpfVbIiSduhEFCTy?=
 =?us-ascii?Q?x+nU5Ij3K16+WLEP37lQdJXgPY6PA5OQvKa6pnKxb44c5kwES7mQRXNHklDB?=
 =?us-ascii?Q?BGtu80GN5t6DPh7llpfMzw2I/WEP5EpLYnmU/ooWedKKDpPvooCspVTAbhRi?=
 =?us-ascii?Q?RGVh+nTBEPXVcsSYdleQZwtJN9baZVa/97pPDnvxGweTwxRezoebtYvxDQ3h?=
 =?us-ascii?Q?gcI2rfStZpfWMH9k2TOUJXkdJCpePU72B3bHdKDVxOksKiBLcCAN+iF7Bj6J?=
 =?us-ascii?Q?MZxIjHWNTrRQU3aJ5K96GGSJzA0j404XO1YT3MEJfWrazPX2ctBRgWhOwNQP?=
 =?us-ascii?Q?lpT9i+E5TFOipAtIit1sdDsNcP7wQ+qKLEOnqpAKnsDmdywRHunQUXp3NzKD?=
 =?us-ascii?Q?RKHDkaksMj1FUaAYLqf5smabAgI15rsgpyQ+N1KiHm+/iUXBBfYzsbqZbI+Q?=
 =?us-ascii?Q?P9QAPuwh26F+Wg596ZxLtYWuPLE1d/tGsmy1sby2QpH3VycSf/g6D71ERPJV?=
 =?us-ascii?Q?bRlzQx9d8PDZd836CRHZ6aOOHXhn0z20t6qPi4/PuLNFlnzQbkCGuj67ar3M?=
 =?us-ascii?Q?f8oQGlQFb2ta6STKGmWmR5Fn7Iy/Xs+RHyPkBBtj6h/aQDDyHn/ej/6qRts3?=
 =?us-ascii?Q?1/tLZQ5tOq45n486ddyo7+mhTxoeKjEZdItbVZQZyfM/JsXNDaCEz98xyPKo?=
 =?us-ascii?Q?/yUja+rbM05NuidLJsUqF45eJW8+Hh8en8i7hlH3iyNzIThiw+2sjcJT+VjE?=
 =?us-ascii?Q?7ClCZniUF1//5ZlxjaLT51yY2G9T/WQiNn0PgEu5ifFBQfjB5/LIqV/QKfxf?=
 =?us-ascii?Q?LneSoItt2Xcj3qktyufo5QzzNwd4L2Kw2lpvxuOgeFl7nGMrQbZbOyzvw/n0?=
 =?us-ascii?Q?BUqZ5BM2o7ZEEJoUu3sPKDg3CuAVpIcRwOP/5ktLaR1bTT6eDOlm2inrQMKJ?=
 =?us-ascii?Q?qOstb3/92Wy9UlOPk3cFeTn7gPK++pqNt3f7Dl41A3H9r6/t2wi65IVinwab?=
 =?us-ascii?Q?ZTzX+MUVLRcJgZOxGXrvq51oAJMVSYfka8ZpWL+ww2seTkGnL8R2+MRP8eex?=
 =?us-ascii?Q?mYk5s1WmUWGd6rbUXDfWwbAi1W6M1QFShGCC7+joIHkhQDYqV9CXNvkGEam5?=
 =?us-ascii?Q?NW8TjMbPnFu72YCFamm5Tg9cxCDUGGJoVimfMhne0+fB9pDhHEttcCpkxe9V?=
 =?us-ascii?Q?Bi8r64x7lK4y2q9QemjdUOeHKsWCMoEXouUvmzHlctXN3Z7Kb8WKrYV3bMjS?=
 =?us-ascii?Q?i0nLdAMG7h02hTD1WRxWQp0P3zDkoNdjzBcPtXPCWX50bt809nPWNvJTA6O0?=
 =?us-ascii?Q?5R48pGLvgfH1pXVYzak75xPwkdGMVPTpQokSsrjRNWhrwMtx+qged+YwLaz3?=
 =?us-ascii?Q?7XiKEg9+LE7KlH+2fml16oCgTUhRTJaT5IFF2OP0?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a37485d-f06b-4ce3-d1c7-08dc2184500b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 11:12:14.4073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fMZdUPCAbPGm0Ad+4hFk3InzYeISLRvbcVvZgn0Lc40Eh8rcP0Sf5xYx9+wktyI24RNsfzUPvEel8qr0KRhs9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5576
X-Proofpoint-ORIG-GUID: YqsM_8H_T84_aLXhwp-1EIMrCdOdEZPW
X-Proofpoint-GUID: YqsM_8H_T84_aLXhwp-1EIMrCdOdEZPW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_05,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0
 clxscore=1011 bulkscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300081
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 30 Jan 2024 11:12:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15806

From: Chen Qi <Qi.Chen@windriver.com>

For gitsm recipes, it's possible that some URL is used more than once.
e.g.,
A -> B:rev1 (B is a submodule of A)
A -> C (C is a submodule of A)
C -> B:rev2 (B is a submodule of C)
A anc C are both using B as submodules, but on different revs.
Now if we have:
B:rev1 -> D
B:rev2 -> E
Then, the mirror will not be fully used.
Say we have all repo mirrors for A, B, C, D, E, then in theory it's not
necessary to reach out to any network for downloading. But it's not the
case. After downloading B(rev1) and its submodule D from mirrors, the fetch
process continues to download C, thus B(rev2) and E. Now it finds that B
needs an update because its submodule E needs an update. Of course this is
true because E is not downloaded yet. Now the problem comes to whether to
use mirror or not. The git.py defines try_premirror to return 'False' when
the ud.clonedir exists. As B has been cloned, the ud.clonedir exists and
try_mirror returns False, resulting in not using mirror and going to upstream
directly.

We can see that the mirrors are not fully used. This is usually not problem,
as the cost is only some network download. But in case the following two
settings are there, we get errors.
BB_NO_NETWORK = "0"
BB_ALLOWED_NETWORKS = "*.some.allowed.domain"
In such case, the gitsm recipe A will fail to fetch. Note that all contents
that A needs are in mirrors and now it's failing to fetch. This is unexpected.

Note that the different revs of the same repo in gitsm recipe is not the only
way to reveal this problem. For example, there might be a recipe call B that
uses B:rev3. Check the protobuf and grpc recipes as an example.

For now, we can use the following steps to reproduce this issue. To be clear,
the grpc recipe in meta-oe is now 1.60.0.
1. Add in local.conf:
   DL_DIR = "${TOPDIR}/downloads-premirror"
   bitbake grpc -c fetch
2. Comment out the DL_DIR setting in local.conf and add the following lines:
   PREMIRRORS:append = " \
     git://.*/.* git://${TOPDIR}/downloads-premirror/git2/MIRRORNAME;protocol=file \n \
     gitsm://.*/.* gitsm://${TOPDIR}/downloads-premirror/git2/MIRRORNAME;protocol=file \n \
   "
3. Set BB_NO_NETWORK = "1" and then 'bitbake grpc -c fetch'.
   This command succeeds and this shows that the premirror holds everything we need.
4. Add the following lines and then 'bitbake grpc -c fetch'.
   BB_NO_NETWORK = "0"
   BB_ALLOWED_NETWORKS = "*.some.domain"

After step 4, the error message is as below:
ERROR: grpc-1.60.0-r0 do_fetch: The URL: 'gitsm://github.com/protocolbuffers/protobuf.git;protocol=https;name=third_party/protobuf;subpath=third_party/protobuf;nobranch=1;lfs=True;bareclone=1;nobranch=1' is not trusted and cannot be used

I guess that the try_premirror codes in git fetcher (fetch2/git.py) are assuming
that the clonedir syncs with the mirror repo. That's only reason I can think of
for why it returns 'False' if the clonedir exists. The assumption is wrong. The
mirror could well be updated via automation tools or some project-level setup
tools. Yet, it's returning True when BB_FETCH_PREMIRRORONLY is set, regardless
of whether the clonedir exists. This means it does know that the mirror could be
updated. It seems that it treats using mirror as some kind of 'best effort'. Anyway,
the codes' logic is just contradicting with itself.

If the mirror can be possibly updated, then it should be tried regardless of whether
the clonedir exists. So we should remove the try_premirror codes here and use the
default one (in __init__.py), which always returns True.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 lib/bb/fetch2/git.py | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 7aa3fd9e5..62618012b 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -353,15 +353,6 @@ class Git(FetchMethod):
     def tarball_need_update(self, ud):
         return ud.write_tarballs and not os.path.exists(ud.fullmirror)
 
-    def try_premirror(self, ud, d):
-        # If we don't do this, updating an existing checkout with only premirrors
-        # is not possible
-        if bb.utils.to_boolean(d.getVar("BB_FETCH_PREMIRRORONLY")):
-            return True
-        if os.path.exists(ud.clonedir):
-            return False
-        return True
-
     def download(self, ud, d):
         """Fetch url"""
 
-- 
2.34.1


