Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67C5C001B0
	for <webhook@archiver.kernel.org>; Tue,  8 Aug 2023 08:51:18 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.57346.1691484677382148824
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 08 Aug 2023 01:51:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=CjMrXEoV;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=7584e0cf5b=qi.chen@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3788kXAE002277
	for <bitbake-devel@lists.openembedded.org>; Tue, 8 Aug 2023 01:51:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=PPS06212021; bh=f0XgF95buw2i1dNNbU
	wxONEEs9c00Q6On9Ptif3u36w=; b=CjMrXEoVHYIDA0xCJ0LEmP6HZ4tfRpwpBT
	oS5eV0kkbEv1eMLcn3NNJmUNzDUXGzx4wWgDSyGDZrJ3n2vXduHa/7dkhi6B5mHR
	GOk3hpjlOwtYs8hrt3kkbkstdT3iB9n6xEu6OpGAnbX0PqUGBgByrz1qcXeTG/BE
	8oz6zh1NLoT1pZe3p5WHFVdkpdwRtGTnyxjRuItM0kd90Lufsm2OsoY2Po2tBK8z
	ZEq9TScOY+9aUJ97BvhUk+2e1lq773DqBzApuSAeENNjUPLAJcBet8w25MbWq3Ph
	NFHxosrekh2FvztLMz/tU3KzXVSXGYjpTFQzTBv2e9rNxfqqBaWQ==
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2044.outbound.protection.outlook.com [104.47.57.44])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3s9nxfj3aw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 08 Aug 2023 01:51:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azkHjKMqiyFXXlUAasZ2cjSGWzg2inXG/5MHEuBCJdGX7eoZle9NslkcAhZRMBZGZPizq6LdcFvJD9U3JKvWIBEZRSm4od432W+cWXALJ8RfWnXpYcMfhnN2DEu6bHRWjpJMNRR3rrtuL+J0vFwtk5SarBMs9ld/U19u5028TkSbVQ0sfnS54PWArs3rDL+2WGoR1sXppfmwv4otX3/w4/cF1KHVFabAqsoV400giEpxLx7mihxhz8Z2V0SMKTRTjd11QB+9t9O9aDL4tdznuQEihhAwVxaK5E4AIdbfEd+hnnIDolAaCRoFqMX9Q1VPP656xtF4wJrpfobwz2Aufw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0XgF95buw2i1dNNbUwxONEEs9c00Q6On9Ptif3u36w=;
 b=XnpVqKSA88QQGyTB399BV6urCmb4nJTqfvtCkzzgftenWbnj8BykqE3RESBjDlRbCZ3ZSv3JOwRV9kLuPehuYzapobxxJBxv9msUvnw7YFmpQMrKh7UvujpY7R/rGhlPNO6bxTD+Pp4/5qbkhWFH7Ez0fzwIjW6isG2BcQmStrESgs/imTQ+kYGCkzRoff4QoXLYQJjQysqBhqfGI3Z9AodkrI7E3UfjGsiURefoL1usSnBbcjsy2HZwK8LVYt8BRqvgt+yVpS6//gDh8N8m5EtcdW7tFCGp0VlYTpkAUW205H3P0iSpxSlHRfv9L5YqneqUFHPdnvJDfn2PCvOiLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by CH3PR11MB8381.namprd11.prod.outlook.com (2603:10b6:610:17b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 08:51:13 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::86dd:2ee6:ac66:812d]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::86dd:2ee6:ac66:812d%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 08:51:13 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org
Cc: randy.macleod@windriver.com
Subject: [bitbake-devel][PATCH V5] runqueue.py: fix PSI check logic
Date: Tue,  8 Aug 2023 16:50:54 +0800
Message-Id: <20230808085054.1832913-1-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0035.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::13) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|CH3PR11MB8381:EE_
X-MS-Office365-Filtering-Correlation-Id: 261cfcff-8531-4e64-12f7-08db97ec9e5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	vo0mZ8+daiKeOCXByBo6bSy1Kw4l92sl9uDhj97BFiW+9tmuWHfxAGR9E0HV2U1ydjWrI4bvE5bqslxuziY2K7jx5P4T8yTlhDML6GlxeoP/GAsPtO0jzskz6Q81vb3cSAUG9xtfBNz4EBzPDl8fiVUye8NjGHQaZGCK8FoBGOSrydyEkS0InvTpQzTaZzcG/Psi7lW1hQDCSp4QJ0soG42y4zkfFcDIEa0RBFdGBIhtrt7mF7AS/X2K+CBsPW7JHeV5xf7HexWjvsFo7FPvh1DfvBQ3fdOz2Y8GrTk8p7jlv3YNxSsvlxaQERZyFGfPKEQWdFk+Hwy98cfi5FPLGz7AQGhUJLHZf3+Kv3LeV0oYKbmdzNQ8AgfXeRzIcp4LpcElflLxYcEm0FMC1brrdfC9QETDDMx1K38gi2E9+5VsuCoWkgvwEFPLkvDUJVKkQvuBeoCzEzbIry3yQxICFnl4Po0//TEloynyiHi5qy9/Y6gXFrpZgM4TFtJuroeqjseI0K6bcASqbR3fEuvNE96hDLKL8Wde3Ukne5ypOQkNKHtCwfxAdfExlHtEutdnZr6d7GLheJ2hVfYGDwrA5f29ZpkqArdIMwhfgauzqH7vYeYk0XWRo0p+UFmSdQkt
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39850400004)(396003)(136003)(376002)(186006)(1800799003)(451199021)(2616005)(52116002)(36756003)(6506007)(26005)(1076003)(107886003)(6486002)(9686003)(6512007)(6666004)(478600001)(38350700002)(38100700002)(66476007)(66946007)(66556008)(6916009)(4326008)(316002)(41300700001)(8936002)(8676002)(5660300002)(2906002)(83380400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?1ZBd0WcdC8iW120xvGO8LSp0aktNFfrxoupbkiRRE9iNxwIQ8Vi6gZazAp2V?=
 =?us-ascii?Q?PqRIHxqG1edOuHYiyQixYLicn7DJftonVbzNUL4H7x/ba1yJc32YtxnH76ec?=
 =?us-ascii?Q?vtVQVIUN4rC+qINJrMB+W9QN5O/qUBYWiQQPTRw2AYOPFww5Gz2l49LncbsW?=
 =?us-ascii?Q?v5QzxQF342JlrXuBJLBdx5+Hnejm4oNK/aL8ujd/gMk3KVN76NaaUvUfryzw?=
 =?us-ascii?Q?ClE6n1Bo664/OBemP6IuDZAcNevUi3gSO0il8L4awJrluCgYPYKlQWrq/0Nq?=
 =?us-ascii?Q?y06yhIVsKQyCAVySGp0/WWlEeWN0i+xovTPAp4JGfAm6o0PJtL26lcFl3CbY?=
 =?us-ascii?Q?xpbCnN+MzHOYzlnBsuQDlR9HibuOkECY+BtIEDIEpqIktNUN4TMk/EApjqrU?=
 =?us-ascii?Q?+5aH2nsOaueDHtoQIbsfnisn6sNJGNpc+svl1kKUfDegKt7c3HTDmzwKFxMK?=
 =?us-ascii?Q?Y01hiDLSHAf2J1E7qP/LLaqYOa3+RMAhrm5pDinlOcrecznZkjtLYiqyssg6?=
 =?us-ascii?Q?7ieZiHuuwVLcqqKnn1XosoSomuDdYPtB3Akhcca6SRD49iJFcMnVpozbGiBK?=
 =?us-ascii?Q?lHPamxvhPTUHC9WCrZa5Poq9YVXxL3nzp5pa0c5AJQmFQfZmvEvbcj5f8Utr?=
 =?us-ascii?Q?d9mhskQvockcBlHUyVCy0srjI/aq5lApUKhYft51c3y77WMssLgxQxUDHMhy?=
 =?us-ascii?Q?AbV6ytEPwJ9iRkwBgks1i6dJrSInuetLTfBmPvMTRUDsBoMMeUN/4j6tT0Yl?=
 =?us-ascii?Q?jQz/PhVKkGS8AIU5JPRKymITaTq2jCpQcKhRw7aETpG/QPHd1IKbPN2xCGrk?=
 =?us-ascii?Q?2978DnoNKTwXwaGpa2J7Cz+S3pLjzwrInQyAiIjXSHKS0qMTTomtOd8Uiish?=
 =?us-ascii?Q?ntEYII0L8gSuK20wgFO0/DfLu6YgMxtaK1vYlCugLtk2m+tN+yikvApfPurB?=
 =?us-ascii?Q?kC1f4T92ObBoOerBqex/ZkLDxrIOp6GQCjGEkPAU+H9KcEnDgMhygyC757Ug?=
 =?us-ascii?Q?haMNWsM91jbZ4EaWP0acQ9HJIjrnz/SpF9Q9VZ0ljF5xhRJt46Atppfn40uw?=
 =?us-ascii?Q?xJ1TSMWuyFsOUXrlDa/+5fYm9ev5tzQ0ibskGDZ44FTiOpm7kr/XsjRt9a7S?=
 =?us-ascii?Q?00AFL60sjao0s42q83KPm643gsvRfTgy3MIzKqhaZ1liefprQf87Poq2hSy5?=
 =?us-ascii?Q?kMhhIeZ+IvAOx5PVGVdycZ6RyRyh4msw9MwhLBSIgMEDntn9aMwd6NXVPSAb?=
 =?us-ascii?Q?yGVB6ftzv9cI6eDYXyaQ96Ymq0lshowv3CxpLl2uUcwk70SvBjFPWI8KDz1p?=
 =?us-ascii?Q?JynxR4DsopiE9mJiolMyOS5Zc07EY9OazRqUNJO5PUst2od2IQ9DsPoR9plc?=
 =?us-ascii?Q?dFa1H4o5NoLcakkDCqVnG3KNmJ9LYx65hF/YkQfn5Bv2IsT0MQ2njaGBKcrk?=
 =?us-ascii?Q?b/VOl/yZa5nP1qxO8sbpPfCDscfesreD4v3a8xtrFMYFHxSv60QADsgCaVpP?=
 =?us-ascii?Q?vhc6A35P2iS/WRKzrIDdxbS03YBFk8xIBLrJ1BeDrhwjnMIrCv+fEGG3oC1p?=
 =?us-ascii?Q?bUTq0cwt8FMRG2zJtISkp4wSgDyKZ7GjucPwOvsS?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 261cfcff-8531-4e64-12f7-08db97ec9e5e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 08:51:13.0217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MosHb0KAizCKkUs2VvxjVPkcO23CceJhcYhez5fhVY3/sqmOuRPsr/Ewz89dQt8dkvMqJXSCaa5u/5UdO6hUOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8381
X-Proofpoint-GUID: YvaG23-0z_AknC2y-GbJKTpB5sY8--WY
X-Proofpoint-ORIG-GUID: YvaG23-0z_AknC2y-GbJKTpB5sY8--WY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_07,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 malwarescore=0 mlxlogscore=963 bulkscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 spamscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2306200000
 definitions=main-2308080079
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 08 Aug 2023 08:51:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14925

From: Chen Qi <Qi.Chen@windriver.com>

The current calculation is not correct because if tdiff is less than
1.0, it's not taken into consideration when calculating the current
pressure.

Also, make it clear that the 1.0s is the psi accumulation cycle,
which might be changed in the future. We have this cycle because it
could largely avoid the 0 result issue, that is, if the interval
between checks are too small, the result might be 0. With this
accumulation logic, which has been there but let's make it clear,
this 0 result problem could be mitigated.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 bitbake/lib/bb/runqueue.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 48788f4aa6..17da1bc1a5 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -200,7 +200,8 @@ class RunQueueScheduler(object):
                 curr_memory_pressure = memory_pressure_fds.readline().split()[4].split("=")[1]
                 now = time.time()
                 tdiff = now - self.prev_pressure_time
-                if tdiff > 1.0:
+                psi_accumulation_interval = 1.0
+                if tdiff > psi_accumulation_interval:
                     exceeds_cpu_pressure =  self.rq.max_cpu_pressure and (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) / tdiff > self.rq.max_cpu_pressure
                     exceeds_io_pressure =  self.rq.max_io_pressure and (float(curr_io_pressure) - float(self.prev_io_pressure)) / tdiff > self.rq.max_io_pressure
                     exceeds_memory_pressure = self.rq.max_memory_pressure and (float(curr_memory_pressure) - float(self.prev_memory_pressure)) / tdiff > self.rq.max_memory_pressure
@@ -209,9 +210,9 @@ class RunQueueScheduler(object):
                     self.prev_memory_pressure = curr_memory_pressure
                     self.prev_pressure_time = now
                 else:
-                    exceeds_cpu_pressure =  self.rq.max_cpu_pressure and (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) > self.rq.max_cpu_pressure
-                    exceeds_io_pressure =  self.rq.max_io_pressure and (float(curr_io_pressure) - float(self.prev_io_pressure)) > self.rq.max_io_pressure
-                    exceeds_memory_pressure = self.rq.max_memory_pressure and (float(curr_memory_pressure) - float(self.prev_memory_pressure)) > self.rq.max_memory_pressure
+                    exceeds_cpu_pressure =  self.rq.max_cpu_pressure and (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) / tdiff > self.rq.max_cpu_pressure
+                    exceeds_io_pressure =  self.rq.max_io_pressure and (float(curr_io_pressure) - float(self.prev_io_pressure)) / tdiff > self.rq.max_io_pressure
+                    exceeds_memory_pressure = self.rq.max_memory_pressure and (float(curr_memory_pressure) - float(self.prev_memory_pressure)) / tdiff > self.rq.max_memory_pressure
             pressure_state = (exceeds_cpu_pressure, exceeds_io_pressure, exceeds_memory_pressure)
             if hasattr(self, "pressure_state") and pressure_state != self.pressure_state:
                 bb.note("Pressure status changed to CPU: %s, IO: %s, Mem: %s" % pressure_state)
-- 
2.34.1


