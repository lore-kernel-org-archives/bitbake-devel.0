Return-Path: <aryaman.gupta@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A504C00140
	for <webhook@archiver.kernel.org>; Fri, 12 Aug 2022 15:12:39 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web09.419.1660317154364969171
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Aug 2022 08:12:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=ajLD7vmu;
 spf=permerror,
 err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}:
 invalid domain name (domain: windriver.com, ip: 205.220.178.238,
 mailfrom: prvs=52238f57e9=aryaman.gupta@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id
 27CCqmWC027517
	for <bitbake-devel@lists.openembedded.org>; Fri, 12 Aug 2022 15:12:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=5sMhTJDZ2j9VPX8iE/kVxK+icnYR+BjnAE/1mUTToNY=;
 b=ajLD7vmuX+T4isndkAkDHlUGP5QYSbJ0JOmNg9IBCYubynxxBhY8TszsCVO77lD6bUJP
 hQ0WDiDsg9Mm81kY4+p/zsNDopaNhItW1Domw4NqgxMZQRv65IgNuh43Be7PXMFVLjcp
 dN3gPVIo5NRLYyXSKVpzp6p+bJK3bcEGu1Rg5EtjQCWat0kI4SA881ubNuNSxqV6ck12
 RoNUqm/i1DQyG8J2gUNVL9W89zrlRNOk3zs94ZaJw3z2SfC659dne7cUJVrTr/IsoADJ
 cHphv/rF8+ZoXzl184+S5aIWYZdxUGCiDmTdHKpfmpnx8AyZ/sDTZA01OuLCBnmdR0zO Rg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3hvqgy9bhg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Fri, 12 Aug 2022 15:12:33 +0000
Received: from m0250812.ppops.net (m0250812.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27CF8wCt003932
	for <bitbake-devel@lists.openembedded.org>; Fri, 12 Aug 2022 15:12:32 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3hvqgy9bhd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Aug 2022 15:12:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCzLFIg/gHWMpkgXcROLU2znDk4SHVK8VpKzS80UOAWXoCw/sMa9V2D0wa/8xNiHvl0m5Zk3fBF6Z5qhiqxdQDLaIeQ2pe41uCIdeWWdWSc2odqUUMt7Tlk6LZ0p7JN/xk96MJWNgjX8XiHIbeQ6VC5G23YVSHDD2i/NqviwzK7Oi7UmfB5QYlKLt306adybKtJjgzPp4scLlQaZyG3A2zX4ZQ3OU7I5yuFFmHXDkgXkz9Jyi5m1M0oDM+pIcof9zxICqhvD5RgOXFOQqLKhp/6ckntD2P1boT0bxOUdXXlfiVHxcOoUDOPMnFBKJgCz/LWReo2MfjN8bZRrk8HgzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sMhTJDZ2j9VPX8iE/kVxK+icnYR+BjnAE/1mUTToNY=;
 b=E3MpUv/F27uCQLqjQ2WRIsQlSY6zElDC0mOQmdtkDLVIlyRpUdJzr5d48UZ5VN0R9MDZcbHPeg+UoNPlpxnoofwnqJnN4OXfoOyExpiZXJ4OEfFZ8j638W8w7YEBMt2QLnVWjn4NHgMjdzDuERGnK6VTgVUvKxeUHi+e/Kv6c8HxfieXNjwkxNIc58/PpyLFMTAltyt/SsNVtpPT3FOYUBQk9l0RNmi25U1M4g5b//nvVVMWLoiAGA5/gLN7/UBsBn+w6MVvR63OxZvtQzs1SWtvpQlDT0KguAkmVZltjMRhOL3YjhhdFD18XFhV1ryFU93xuoctrg7TxMebCHEMMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS7PR11MB6037.namprd11.prod.outlook.com (2603:10b6:8:74::5) by
 MWHPR11MB1390.namprd11.prod.outlook.com (2603:10b6:300:22::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14; Fri, 12 Aug 2022 15:12:31 +0000
Received: from DS7PR11MB6037.namprd11.prod.outlook.com
 ([fe80::b825:aa19:d8f1:2642]) by DS7PR11MB6037.namprd11.prod.outlook.com
 ([fe80::b825:aa19:d8f1:2642%5]) with mapi id 15.20.5525.010; Fri, 12 Aug 2022
 15:12:30 +0000
From: Aryaman Gupta <aryaman.gupta@windriver.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org
Subject: [PATCH] doc: bitbake-user-manual: Add definition for BB_PRESSURE_MAX
 variables
Date: Fri, 12 Aug 2022 11:12:07 -0400
Message-Id: <20220812151207.1616310-1-aryaman.gupta@windriver.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0118.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::18) To DS7PR11MB6037.namprd11.prod.outlook.com
 (2603:10b6:8:74::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 521e65be-d88a-4ca7-7dfc-08da7c751347
X-MS-TrafficTypeDiagnostic: MWHPR11MB1390:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	7psY0ZytUi3ztq42Xh78AthktbiPr9UFS2lJThVt8zl87hQUZWWjUNVC/ROZZCZztejNwMYYW8A4UlX5ZqLHJc70Rsd9js+QZqVwFmjkHBTn+Liik69/pP1dYDrvF4q9xr+MPzlA72Len7roiVOTpkmAa2XCbQoIi54UQJP64iWgLxPsLklcfMdSWY3WkKLONcltet4xJkr2SIuoCS6pxTBcPDohoUpN+B1t2RVwSQgzpj5aa48BVjzVjhX5elNlej1aBSXHGP+N7wDrauHemjEfFUyt4HJvVG3hrdkn0jAk639okoyHBDLpBWppbS+lZtRYNzYX21RdEYyWlBEu6tS4mVSiM3xFc6mn8e/DI5+NcjANTeoMYQAsgDzqRba3V2tjCgsWOq7HXnKKE98GMqaIg8S9qOgmPlQ6KqgXYc875JkVbTz5dzc4mcSeYfiL0eTJVSOkl7GhukTSw2eimtNxeJpq1warRrBxnCaNjKMXoyhV4V8ZNMl1DhogqDH0JAzXurKDcM+Ekb65q8F7k0dUlPGRcyn9565U8aPHWFxNq5zlgI1Q1ZeNig7jxWanSwI6rFZ0jvH/AJ8tq3Lwm/neLgiZFz8qUQsTC838SpaSRa2+bjkSekI3LC6SHV11Av6bKWVmulo8jfyNK6qjDxXESkvdGrcgwSv380uPCm2IVIHnWHUEuDMZUhw9Eml+YBSNbzZAr7YtHUMSYyQ5c/R4R19dGXijfpc4FcjOxfpukuA9G9FTECm0xoGwB2tZ03bpjskRavuLXmAjQ1DJ8BynpubXLgMco169KFyFeRs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6037.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39850400004)(366004)(346002)(136003)(376002)(316002)(6916009)(66946007)(66556008)(4326008)(66476007)(8676002)(8936002)(38350700002)(2906002)(38100700002)(44832011)(5660300002)(36756003)(86362001)(41300700001)(6506007)(52116002)(6486002)(6666004)(478600001)(83380400001)(2616005)(6512007)(26005)(186003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8ltJ/Ij1Na9YXEBfFNWYSzIjNGqTsl6HZp/crdlzIKTxSkUnk+9g3U8EgT1S?=
 =?us-ascii?Q?HpogzXvyQfx6Vb9NLekaqXTNTuZNtY+1Ep5C9j1WPka280H2fwO/dQLC6O1z?=
 =?us-ascii?Q?D4xle3doYIUplrflMZrXqZQxRa5eQvdwCIjFV2MAp95enW+Z1aeRQ0pFMY/A?=
 =?us-ascii?Q?AaiqZrbyHmEgQvHH+obwDQ5dE2uXyr25BI9i2cjxlZeof4A5ZKwiGijZaWUr?=
 =?us-ascii?Q?ErvoE54s02zLGVDz8RWg3KdON29l7mY6OyKxyy5eRYBEYk3WRK2yON0zzVmS?=
 =?us-ascii?Q?+rcMxBgca6/dVUh4uvs31IbUtRyjNiGFoVzxeoY6CoxHx5hVNCHA/hSdzhoO?=
 =?us-ascii?Q?+LyDKosoLKoB/CNK/3OviUJAJPn7BMtmqfiPg9Jn0ZthNW8TjtoRKmILZCWL?=
 =?us-ascii?Q?QNMBCelq+gWpcyUhi3FD6NdzUoshDQ+guI7/KDD24yYwL7oWhVUfhvdiaM/E?=
 =?us-ascii?Q?gmWCzkEovCE/cnEMlemYpjojhQX30YEi0329aU6sCJyPxDoPl9NU1IbtJMC9?=
 =?us-ascii?Q?VgGdT+4PvP+Gj5AAIpJLjb/BuY9M6oUl6TFQsinw0k50LMjzUaF2+77sISMa?=
 =?us-ascii?Q?7LRMOxrqmkbyL6vCT/8J+uO12x9hwXAofL0i2mvbaFnVeQnRO+68Aj0k/PIW?=
 =?us-ascii?Q?ZSGSfi3E1vIVO1TbcSRpvqFUMSwqZzvYWDTAl/N6Wm6iU+d43l2tavG//OjV?=
 =?us-ascii?Q?flDfnLSpXNNWzAeWU3jddw5umZCsDb3oI/RcOPj6Ye+rye3e+fymvIWWAWrD?=
 =?us-ascii?Q?vo4Wl71rac5rT1170eCyCor/cPNh77/DhZapaPCtITp4myn4j86WnsVk1+PT?=
 =?us-ascii?Q?+C85ayWGNIdH9TaCa94IRqYUoqSMkgavmGi0eccogcExvhKkFlKSikPVrOoz?=
 =?us-ascii?Q?CPObwG4XpIw3mA0LTyAyUUXx4oIu/lcqzKnEF+WEKdAhgEaP0YpXx9l+bOEU?=
 =?us-ascii?Q?O2iN7sySqjWorne3nKy5a61v2a9ADP5HfdFhHmwQ1ESuvf2Lj3qCiJZ51q+s?=
 =?us-ascii?Q?EBhSgP7GNddqe3x5YgmtFLQ6ugjCVc01qXLrGos1imnz3SXMF2Fsud5NooEe?=
 =?us-ascii?Q?Lpv1ovx818vkMnCjOVuT3rlvyYHa8hLfYuQPggJNGbnh1OlSdB/BkMwnD77g?=
 =?us-ascii?Q?MmH3nOJ7Wp78Y7kJAhBC2S5F/2L22T3HuDwSk6tG7E0P3wp68qyUiLwag8V0?=
 =?us-ascii?Q?PdDMl+UUVvhf/zeE2Cdq92tnkH78YolCJNhr7Rg+5cNA/WY0R8CxDrNl/NBb?=
 =?us-ascii?Q?aDZe4p8FuJ7Qjr3Y8k1Kk9vvE4BQE2cGGXKKvSymYR7hILM8iZcy5QBlwkGX?=
 =?us-ascii?Q?poOGUl0HNBoe7vCBMjsoO9Gde7TLz2kg6dn6s1aWzFPsn8IQetyT50eRUc/I?=
 =?us-ascii?Q?8+V3rba6isa4XNtCnnOR/U2Vs0LVlEZQyE1MCcMrTOlXudbXFOmYhSbTxUeM?=
 =?us-ascii?Q?pVL+SRtbyp6t0Hal92gevhQpqjTU6LE0BUYKF5WVZS6X8VbCLD8ARVstPnBT?=
 =?us-ascii?Q?XAgjB8Zr78QbHYAMvwmnQyskaJ6FnXA9IG0wOcvRNLIknzFbedn+8e6j0cxl?=
 =?us-ascii?Q?pMKNIepNMXSDds6H9lqD9XtGgSv4HuH9Y3cB8kHcm31cCMEvLZMvTLVROM9/?=
 =?us-ascii?Q?Zg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 521e65be-d88a-4ca7-7dfc-08da7c751347
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6037.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 15:12:30.5345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 m2hbA60CwPcQRdEc1Wa6QSTEDk5rNYlt36n4Vnlq76klOCYnf+ySwOYgTx4iBnkbkm8yIJ4/DqEqtf/QrtjXl13UlcT9UC40DR0/N4n7zFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1390
X-Proofpoint-ORIG-GUID: Rhh705HbhdbFvln_ErLMWcgkXFHzJnc5
X-Proofpoint-GUID: 4bQdGqfgl01CZMYU-oP9aCHBRVY6PYRJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_09,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 lowpriorityscore=0 phishscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 clxscore=1015 malwarescore=0 suspectscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208120041
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Aug 2022 15:12:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13893

Add the definitions for the BB_PRESSURE_MAX{CPU|IO|MEMORY} variables in the
bitbake varibales glossary. Further information on how to determine a good
threshold is added to the Yocto reference manual in the following
commit:
	a9b58b3a6 ref-manual: add definition of BB_PRESSURE_MAX_CPU variable

which has been cc-ed to the bitbake list.

Signed-off-by: Aryaman Gupta <aryaman.gupta@windriver.com>
Signed-off-by: Randy Macleod <Randy.Macleod@windriver.com>
---
 .../bitbake-user-manual-ref-variables.rst     | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 12aef3cb..9b2027de 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -482,6 +482,36 @@ overview of their function and contents.
 
          You must set this variable in the external environment in order
          for it to work.
+   
+   :term:`BB_PRESSURE_MAX_CPU`
+      The threshold for maximum CPU pressure before BitBake prevents the
+      scheduling of new tasks. Once the :term:`BB_PRESSURE_MAX_CPU` threshold
+      is exceeded, new tasks are not started until the pressure subsides to
+      below the threshold. If :term:`BB_PRESSURE_MAX_CPU` is not set, CPU
+      pressure is not monitored. A threshold can be set in ``conf/local.conf``
+      as:
+      ::
+
+         BB_PRESSURE_MAX_CPU = "500"
+
+      Information about how to set a suitable value and some other caveats to
+      consider can be found in the
+      :ref:`Reference Manual </ref-manual/variables:BB_PRESSURE_MAX_CPU>``
+
+   :term:`BB_PRESSURE_MAX_IO`
+      The threshold for maximum IO pressure experienced before BitBake
+      prevents the scheduling of new tasks. The IO pressure is regulated in the
+      same way as :term:`BB_PRESSURE_MAX_CPU`. At this point in time,
+      experiments show that IO pressure tends to be short-lived and regulating
+      just the CPU can help to reduce it.
+
+   :term:`BB_PRESSURE_MAX_MEMORY`
+      The threshold for maximum memory pressure experienced before BitBake
+      prevents the scheduling of new tasks. The memory pressure is regulated in
+      the same way as :term:`BB_PRESSURE_MAX_CPU`. Note that any memory
+      pressure indicates that a system is being pushed beyond it's capacity. At
+      this point in time, experiments show that memory pressure tends to be
+      short-lived and regulating just the CPU can help to reduce it.
 
    :term:`BB_RUNFMT`
       Specifies the name of the executable script files (i.e. run files)
-- 
2.35.3


