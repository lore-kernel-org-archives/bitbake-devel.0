Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F249CD343B
	for <webhook@archiver.kernel.org>; Thu,  7 May 2026 06:19:23 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5954.1778134757357464848
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 May 2026 23:19:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=pPtlFbnP;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=9587885fd3=qi.chen@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6475Krlt3269026
	for <bitbake-devel@lists.openembedded.org>; Wed, 6 May 2026 23:19:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=lUZPcJKxeUSMjDhSh+ln14WTABVX0AL0Rkd8B3lIpIw=; b=
	pPtlFbnP8OwalAWFhXs2dDAxGpWqY8GVgRcCia1D78GiGUtSpTiNwvubVff7MYT+
	WIn5PMOw+5cPrJJFwSPljf6moMHLfPaOelMo5ntTEzm7ScrtkCBtpHnLEumr8G2T
	Ik+dA0k+US0K3wpCiMgsR4u8bNMFXwwtpb9HxpOjUCpsAKrYUZ/w3v0T6GRiQcAD
	PQOH10XX0o1zXf1HXOT1/nnzJs3l5Y9NW31+dCr34qYZfIhD2WVQnhz5Bg3CIUIS
	LcnbVyQhuaO9NNI9gt+nKHVnqJQCuLTf96saB4j+x8NyRr/mH/ExXlxlp1UvtNGt
	60h6kPQdCZIy9g6tWOuFRA==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011026.outbound.protection.outlook.com [52.101.62.26])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dwchywwmj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 23:19:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G7SvumU+uF5NRwszuUa4XDe8XADlKItKLiGfC2smFbyDpzdxaq1I9vatcAuA8D+UEZ4YvEzYVDiPY/HUMqcF0W7ebx2652aQyLvSUTXe6b7CNyh0IlX7+Ah1ascYWhbUxiomXvdqd0z3Z12tJnbypyv5gAHSatjwFzV2t8wJGmkvPhskZHlBZXUGnK3slffgq3U5A5gqi5o6arJcdJOHn07lzrAAeQ/V+79Su2PO4HtUiY/dYRuLKXYvf/JtXrE+vuAP9Y7t/wjaNHOHg/v3zhYQfNsqHkD0hdX2evb9EIFyT6YwxOJ6gQzqnQ7O0fuZ2MB50wqa5kmxiUO6/JTyPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUZPcJKxeUSMjDhSh+ln14WTABVX0AL0Rkd8B3lIpIw=;
 b=IVehj2FCuEF567J3EN4xYXyalXyFy7E+GsSFo0loQUu6BovqXOehk+kjsHPARpHtle04Nl/L4NaU+k+YYTuI9lJhjmc8iyb5qCWZCDW2Du5+3HTzGeeRFrQHmxdrRwvLohthuXuLsl61M1UWhyXpG/Ph4bdBJzC70bHxeosBc1zpfQn/5xKfpd7TsRZrdg4ii1qAADs0v3t97Vi72iz2k2sP3xleRAGzMxqQ6MROSW2XxXzCK+bnRtnqaklaSK7FZcs+X9TQ6Ao39hCyKlk3fCq0sIyxtQHKWu/WUZrNaIKpi4CUX6O8twyrb/I5u5DY0uGMq0n+9McsCnPcXfcOOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by PH3PPF383C22AA3.namprd11.prod.outlook.com (2603:10b6:518:1::d17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 06:19:14 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%3]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 06:19:14 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [bitbake-devel][PATCH V2 5/5] bb/tests/fetch.py: add case for filter_regex parameter in latest_versionstring
Date: Thu,  7 May 2026 14:18:45 +0800
Message-Id: <20260507061845.1460893-5-Qi.Chen@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 839de8bd-1813-4dfa-8df9-08deac008f43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014|3023799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	pt/VFKTmYumlG/B71NzwtL0aoJlb4L1JhqLAihKHb1FuXr/NScBL3nEWt2ey3vl9dtRdU1aHxi9I24BPg3jfgK8bdVbV2lflCeVOb/hmwvco1MbCy84X5mGJ+s6SYLGKF23cpizfjuvAuAIHP4HIJ7LKQx6aPfRGLqXVP6lBQVV7wwbA0w6rOdox/v9eaFQL+Pkw/Si8AZeoguxK70Y8Wm/+PpNDdonmiAzya69Ac2JGcVe0DxU64PAu+9S1Xwt2qqRMhQcbRF2BgEzSnBaTS43HgkCW23IgDVadNfwkblI1WYOTNqmTQeKvcGfEh23Kn7I6jNilZBpsm4sLdD3a20HLnBrkoO7AvGdlIpZzocKud9PbWdIOJZUNLKVyFWR55jcbP3qU0vRRQRDAc8AYyg0cXpZhXS+owX4BjY02q7agwJSgKpHhbqfrF+xuZ6lrYMLFWQ3Mu9WcHGMhvYon2u3TUoHYr5aqy4g0qXSgeLIaa5vWyrp7xcWMokJEqBmz0EHpAoBH8dprYRWZ0UPrPCxlF6f/8WPGKY97A6062n9HzucPhowN4II/7dKoTDPujzEGMKpSX41KEV2yrN6W+DKULyxIu+aDJA4upwW955sdW+hPeS2UlhZQXOe4VLqwFD4rw/ecLElvdcuDL8gle7EAT9i4HNdHpUp6q0M8oiSPRAmO9JUHrPdd4fBoRN8i+oxy0rU7XEZCklvt0CGV2A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014)(3023799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?7b4AXiqiWwDTOsP5AyMe6TdjSuvPQ3vGl6Y/7cWfJgQavzekEXnMU8jYuL0F?=
 =?us-ascii?Q?PGork0xNS8p2wVh08xByAVBWqwVfYMdbF1cZee/Oh6PpxrXtniM6FmjvmIi/?=
 =?us-ascii?Q?cEXAW5PWMEsfJB3ppyugC5vm4d9OP/WbOGoGCy5g8ahgwm3dM0FXwZmFpCxy?=
 =?us-ascii?Q?uCiGD78avhGTGPv5lbrkbAkX0yVS8gxarVvOwaLIgdRqpkNzdMyQZyWu/Gwc?=
 =?us-ascii?Q?5KcZ8N3975d5TNyawkgs+4hGlbWcnwpj6eY/KstSlPPYDlXoS7l4H5QvjXFs?=
 =?us-ascii?Q?8PHNDM57EayqurCIEERWKBjpBNQ/trpPcoWSiUD/B1LnuLISFpZjcYVlIX5d?=
 =?us-ascii?Q?SWgAzCixvzZ0quDrjSabiRgMrhLthR5LgssbopCbGDoDEQCht8rGNBQTD8ce?=
 =?us-ascii?Q?kgwqYpKp/PFx5iTeZ+I9nxXGw608K9NdIhbsk366qzOrYGqAAti7PDoEOxiI?=
 =?us-ascii?Q?89h5MWk5z0DQMZeeNKk81SpAyK0XuCOdpQwbBEwcoOT9mbFAGLvDuWlTlIXq?=
 =?us-ascii?Q?BjrLSJfRNNwv5KpM8RsNwHJ1MQLI0E5V4OmYE71uHDGyrEWvp93RmUxFmCFW?=
 =?us-ascii?Q?7MPTIi31WJ2YME+r5XmxmI8Mg1ihkasbc2tHLwMuy0Z4bzmggwqU3VMnReon?=
 =?us-ascii?Q?yEt0eQcLV5tvq1TdaOlvrLJRKXIIOyWmhqO1DMTyAM4GBY2nNkliUWSTHvw9?=
 =?us-ascii?Q?hyqoLmPOaSsXFByq/W2khRKJL1nzHBMJZyWv+BW220AjtpAG1KuNdOvB8rYW?=
 =?us-ascii?Q?p2cPkEhTBcHJKw0CFr3poccAHdttxeM75p2ghggn4vu1IdIs7IyHkKNOKQuf?=
 =?us-ascii?Q?5ax7maP8eVgLmb3yuvlhIFLgduwOXiB+zBb5hRCTIYwvzpj0hSHMCiHrIuIA?=
 =?us-ascii?Q?e6B+foNAPW/w5xcMCmTcHIGutnSYoM8XgN8BSG4b1kGktf2Mi/5B41FgF5P2?=
 =?us-ascii?Q?6Xo+hm5dyCSoQ8r6AdkLk0wchz8fljf9wBJwcpnlEgzPmBGp55nI8t9Ojx/7?=
 =?us-ascii?Q?9auV76Luw+Q0TIrwIAai/rVSkJWSEeV3US+p6WxDX5ZLC6orfaBGbWzs7HSy?=
 =?us-ascii?Q?HNijp1pEBGC/POdqUDsrcuUYjXd5n24PDRgDbqIIwOHcaVkCkV6R/Ja3I4Ep?=
 =?us-ascii?Q?CNXvw23awWZBKuXQ04sk/xovNBs4XPk48l9HGXFDCKPoAxSf+Oo79fmuNfil?=
 =?us-ascii?Q?R6soqPZvLIPzfv5y/WXgMHGA66ggtxA+G6sCzrTl1nIsGTTC6AN9RgpvLHUj?=
 =?us-ascii?Q?JtxytN/JzpYXC7RHL5puBm2nDtkg5ZP+l/x/dkIFw9PrBAgLEvVM1GlVFR4y?=
 =?us-ascii?Q?mQWr2tL8vt9W7jU9JswLxMbNNTuVooOWcL3FGPxnYAjXZ87rjBfxMKhEIZPX?=
 =?us-ascii?Q?TDtEitqhGhgPRyyEPSi72qD0GORwAtJx7PheWtb0W2RvF7HYG+PmHPc9YAH3?=
 =?us-ascii?Q?OPNs8eLqBlfDx/yMWW42AZXa59/0wLjvvtcvihZ9SyKt3ksfvCGfQrsacLF1?=
 =?us-ascii?Q?7khRf2PSrt99B3xRJ604hf6+u8L150KMluBcIgoXq0nvFxG5696ahqn7w+KU?=
 =?us-ascii?Q?rvJ4CF/EGw7/p/J0E7naBjLZlOfZGCY/YnzSuFYu1EDekK7Ac0LpIrQRYbmO?=
 =?us-ascii?Q?3tHtInDLkRg6dS8z2fqEb1R/TjtWjaf0xN+Q8oLKMymUA/jwdlpWNgrwfd7J?=
 =?us-ascii?Q?PMeHACYeLO+qn6R351ADS9FVBFyMorinL6No2VgI2maSMAZ+zUxhwh+vJnPF?=
 =?us-ascii?Q?z6o8V0B5Cg=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	cAgeiNuANIPzR53rC0omZ8a+z9j7OokH2/Eto99HlnjlVn5f03cB481BKZi8amQbsk08Im29eP7BXpxGukGvSn1eX74wCkm7pJSSMTNXwV+Qc3160kxV3zHLNqfjSZoRWhUiCVFPd2wSGZgJgwTSrNDhRfNYaA8ldVdXTjEUOrNGAKmsYv9tN0bDn6XqoUhoYChAPoD2y5BPvRsoyGXJ5ah1nkQ+6V9VtuY9LPVeSI4KDTMhUxxCN055vm4WiUMqpYKrv0jzkBHPW8UsYeaxrgp5h18tRRXnbQzf0Mk/JESAV6YFuhGw4XUyCH+2DiaQ9b6h1eHUOroCWtt4OD5C2g==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 839de8bd-1813-4dfa-8df9-08deac008f43
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 06:19:14.0029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y44a4OsqdE9bpbbz4AEL5w/XXVObfUHIy3opSBVtflmX/VHAo3N6mPOlbNryf4ehwARU6d+iUDsXMxC5SQbJBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF383C22AA3
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA1OCBTYWx0ZWRfXwthLe+oDrzRq
 jIkwrNosndy4O6x1I1ZsJ2cLrQm+VMP193UxImsu+SLeaRYVBSdIAPNDzv9zrjU6PK5kI1HAwch
 yn/69M/c/kvj9KDnGKd+bdXj/0YaEUgxrOYcy/HiEK6PUzm5OUxE+a/4mpZJ5V8x1lrP5JcVU41
 ICmrmsjleHjhJQz8flh3iTxNy8A4AQEzzoXTYxMRc8sIcw65ityH9ZbSqWpdrIAj9+BUAA/GBza
 T+Gclw6r9VENFDopnVyE8b+Fm3cwbbYX3EaFtpdlNnEGFF8iS4qQI0YLwGxxvwEuZOVX+EwDWaf
 0eXFISVJzek4NNb6EtbEZPrCdSn6kK1WdQh52dyjPP19aZD3X3gy8MT2x6x8aQgQsZNMaaQvBro
 Of3egkQkuh6dKBkCaTv39to9H/f8ubMWjRTKygNCrQTIdF7LlV+BkDKdrOad69/J32hx2cygQ0t
 rY7FrL1ukXu0vr4Jg+g==
X-Proofpoint-ORIG-GUID: UqPvIKd2k7KyJSDQwdZhXYEbpRLj8CSy
X-Authority-Analysis: v=2.4 cv=LsSiDHdc c=1 sm=1 tr=0 ts=69fc2ee4 cx=c_pps
 a=zTxK1Vn4TPWW1Y7kXDJIYQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=3tcz3bTJAAAA:8
 a=iGHA9ds3AAAA:8 a=t7CeM3EgAAAA:8 a=NEAV23lmAAAA:8 a=r6VMbn1M5JNI-OT2GTcA:9
 a=4EbjBm0RLgFgoQzmu6QD:22 a=nM-MV4yxpKKO9kiQg6Ot:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: X--Z1x9WtJJlfVu6F819d8AUs9EtrVPW
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
 <bitbake-devel@lists.openembedded.org>; Thu, 07 May 2026 06:19:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19455

From: Chen Qi <Qi.Chen@windriver.com>

Add bitbake selftest case for fitler_regex parameter in
latest_versionstring to ensure no regression.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 lib/bb/tests/fetch.py | 78 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 86dd92992..2ee1a883f 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1512,7 +1512,24 @@ class FetchLatestVersionTest(FetcherTest):
         # basic example; version pattern "A.B.C+cargo-D.E.F"
         ("cargo-c", "crate://crates.io/cargo-c/0.9.18+cargo-0.69")
             : "0.9.29"
-   }
+    }
+
+    test_git_stable_uris = {
+        ("dtc", "git://git.yoctoproject.org/bbfetchtests-dtc.git;branch=master;protocol=https", "65cc4d2748a2c2e6f27f1cf39e07a5dbabd80ebf", "", r"1\.4\.\d")
+            : ("1.4.0", "1.5.0"),
+        ("systemd", "git://github.com/systemd/systemd.git;protocol=https;branch=stable/v259-stable", "b3d8fc43e9cb531d958c17ef2cd93b374bc14e8a", "", r"259\.\d")
+            : ("259.5", "260")
+    }
+
+    test_wget_stable_uris = {
+        ("openssh", "https://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-10.2p1.tar.gz", "10.2p1", "", "", r"10\.2p\d")
+            : ("10.2p1", "10.3")
+    }
+
+    test_crate_stable_uris = {
+        ("cargo-c", "crate://crates.io/cargo-c/0.9.18+cargo-0.69", r"0\.9\.\d")
+            : ("0.9.29", "0.10.0")
+    }
 
     @skipIfNoNetwork()
     def test_git_latest_versionstring(self):
@@ -1569,6 +1586,65 @@ class FetchLatestVersionTest(FetcherTest):
                 r = bb.utils.vercmp_string(v, verstring)
                 self.assertTrue(r == -1 or r == 0, msg="Package %s, version: %s <= %s" % (k[0], v, verstring))
 
+    @skipIfNoNetwork()
+    def test_git_latest_versionstring_stable(self):
+        for k, v in self.test_git_stable_uris.items():
+            with self.subTest(pn=k[0]):
+                self.d.setVar("PN", k[0])
+                self.d.setVar("SRCREV", k[2])
+                self.d.setVar("UPSTREAM_CHECK_GITTAGREGEX", k[3])
+                filter_regex = k[4]
+                ud = bb.fetch2.FetchData(k[1], self.d)
+                pupver= ud.method.latest_versionstring(ud, self.d, filter_regex=filter_regex)
+                verstring = pupver[0]
+                self.assertTrue(verstring, msg="Could not find upstream version for %s" % k[0])
+                v_less_or_equal = v[0]
+                v_larger = v[1]
+                r = bb.utils.vercmp_string(v_less_or_equal, verstring)
+                self.assertTrue(r == -1 or r == 0, msg="Package %s, version: %s < %s" % (k[0], v_less_or_equal, verstring))
+                r = bb.utils.vercmp_string(verstring, v_larger)
+                self.assertTrue(r == -1, msg="Package %s, version: %s <= %s" % (k[0], v_larger, verstring))
+
+    @skipIfNoNetwork()
+    def test_wget_latest_versionstring_stable(self):
+        for k, v in self.test_wget_stable_uris.items():
+            with self.subTest(pn=k[0]):
+                self.d.setVar("PN", k[0])
+                url = k[1]
+                self.d.setVar("PV", k[2])
+                if k[3]:
+                    self.d.setVar("UPSTREAM_CHECK_URI", k[3])
+                if k[4]:
+                    self.d.setVar("UPSTREAM_CHECK_REGEX", k[4])
+                filter_regex = k[5]
+                ud = bb.fetch2.FetchData(url, self.d)
+                pupver= ud.method.latest_versionstring(ud, self.d, filter_regex=filter_regex)
+                verstring = pupver[0]
+                self.assertTrue(verstring, msg="Could not find upstream version for %s" % k[0])
+                v_less_or_equal = v[0]
+                v_larger = v[1]
+                r = bb.utils.vercmp_string(v_less_or_equal, verstring)
+                self.assertTrue(r == -1 or r == 0, msg="Package %s, version: %s < %s" % (k[0], v_less_or_equal, verstring))
+                r = bb.utils.vercmp_string(verstring, v_larger)
+                self.assertTrue(r == -1, msg="Package %s, version: %s <= %s" % (k[0], v_larger, verstring))
+
+    @skipIfNoNetwork()
+    def test_crate_latest_versionstring(self):
+        for k, v in self.test_crate_stable_uris.items():
+            with self.subTest(pn=k[0]):
+                self.d.setVar("PN", k[0])
+                ud = bb.fetch2.FetchData(k[1], self.d)
+                filter_regex = k[2]
+                pupver = ud.method.latest_versionstring(ud, self.d, filter_regex=filter_regex)
+                verstring = pupver[0]
+                self.assertTrue(verstring, msg="Could not find upstream version for %s" % k[0])
+                v_less_or_equal = v[0]
+                v_larger = v[1]
+                r = bb.utils.vercmp_string(v_less_or_equal, verstring)
+                self.assertTrue(r == -1 or r == 0, msg="Package %s, version: %s < %s" % (k[0], v_less_or_equal, verstring))
+                r = bb.utils.vercmp_string(verstring, v_larger)
+                self.assertTrue(r == -1, msg="Package %s, version: %s <= %s" % (k[0], v_larger, verstring))
+
 class FetchCheckStatusTest(FetcherTest):
     test_wget_uris = ["https://downloads.yoctoproject.org/releases/sato/sato-engine-0.1.tar.gz",
                       "https://downloads.yoctoproject.org/releases/sato/sato-engine-0.2.tar.gz",
-- 
2.34.1


