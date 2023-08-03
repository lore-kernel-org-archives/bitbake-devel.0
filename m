Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBCFEB64DD
	for <webhook@archiver.kernel.org>; Thu,  3 Aug 2023 05:19:46 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.7896.1691039981047754402
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 02 Aug 2023 22:19:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=JCrFxbpC;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=7579963e98=qi.chen@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3735JenV027451;
	Wed, 2 Aug 2023 22:19:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=PPS06212021; bh=AGz8FeyXFNz+M6XnXS
	GRp3YVOsvFuNo8KJ3kbIOZygk=; b=JCrFxbpCUoH8fo6ikyfniitV7AOkLEi6Rf
	Pca7Xo0AlZY1ASt53NLVwemiHJ3dJPWV4jf6At7t4Q7air9H1JVZtu8xY1sD75nc
	wBs3jTFBCLcTIlp/2m5YE/rJlGRDCoeowSzVcljhVccKmU7tSpS7CpftV7wKdNQP
	wPF03YMNBEVerCpXzRZ4Sdbuhl/EvAFO/7KH75js+rYYbrIYCxJusuQybiW2VMNi
	0+FBCIQqTfuTkZIbYZyWUoEtI9hRa/rMwekjRYyo2+USs1pr8tpPXyvapEpkbcXO
	ROPgPcO1kyoGkb3PBRBUfmsHnqNwrVEfpdFmUWu0UTsSTDN6oDrA==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3s78py9ae3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 02 Aug 2023 22:19:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWkTPOmOgm1qe27I/Ba1vfle0y2pljFj96QWGd77w69l0iXjn4wiL2D+B6VZPJYWxbRvuCu8pwS2wnjeSEt7DRHg9Mm5r+la4m71aEqMLD8EZbqCGUdHV8NrzZw23P2WKLuf2An4TXcLGcH1F9Y/gF4c9EgkOp86J+O5KMShz1lOn8zoV5pHsxVgazuBXdHoPGqtlv/xqXTCw7yQIHkHRsDGlvK71/87O6ykLL/G/6eAWOO9z025vm1x0KFGk6BV8fmqJWJXV6/CAHpeL+awOYz7gr7NrZMFirlK/FxS68JtqKGwY+zk+eTm9nf0kpeCcTOhQ0WfdNbC2NHeJFMP/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGz8FeyXFNz+M6XnXSGRp3YVOsvFuNo8KJ3kbIOZygk=;
 b=AhFYn/7fJVQ5cMtcQJChJrQpkKblFOnvUMEb12tcW8tODTxba3vIy/Vk3/LdlU8fnGeu9o/cE8aBCM630dz5HQOYcvHgo03Ew7qVZZ7WDj/ghXg7Dd9Yz8Zgzj83kqvwwiZFBmzZsyy6Sm2A/vIA79ShnMsLfAGIRQPsjGlthediq63acuzf64lp1CyUIwqNFqgJ5wtQ/krJDiia7MRN60pAOwDA97pf/t4djNBdhtQBIc4PlVaJLrhKBq6oqBMAe2t/p/vwWuk+1+u9lo7q0sKAfvbNri2ZmcDrFPcm5FGlgE8rns5cIQpk9svAnDEx0M9xueTGhufKSSnZTo5Guw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by CH0PR11MB5562.namprd11.prod.outlook.com (2603:10b6:610:d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 05:19:35 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::86dd:2ee6:ac66:812d]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::86dd:2ee6:ac66:812d%4]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 05:19:35 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org
Cc: randy.macleod@windriver.com
Subject: [bitbake-devel][PATCH V3] runqueue.py: fix PSI check logic
Date: Thu,  3 Aug 2023 13:19:16 +0800
Message-Id: <20230803051916.1640841-1-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0244.apcprd06.prod.outlook.com
 (2603:1096:4:ac::28) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|CH0PR11MB5562:EE_
X-MS-Office365-Filtering-Correlation-Id: f264b430-35f4-4ac1-d6f4-08db93e13a34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Il6nFJted6JMSc8CFGg72au1IsseayUkUhIUY03a1p9GvaXU6o0H2bfi36RYE46R7VqdR0BiHW941JdMLenemmP81/goYToqdJUceQ2QOSXPdz5QblxiQHHMu3J5j5tEKyrfnGrcFOezE4FQmNxdAraNP7JkMazFVuBd5rgAfBrTBdvkk0SKHS+aXHSdN6Tkx1SQhxTRRv8ang1MtXGjBCN/85qmdIwU3Uo+d2BwX/yA6tEr+Is+KQ3E2TWMQOV3735ZLeoutqUuUTsIyyuWLz4xbBTC9JdIZOmFJ4/hZkb4hrdo4jln77q3Bh+F4NVbCinwRrvPvHi5SLy4McpYwXq9OzSP3DbVMNhPmes0gsoFMr+YkLMjELWARcjBDr7rmABc2eYWRXBErwVXEKWgYSIMamuVFYJjRMiDl1DEXWiP/w/pwuewyGrhDyJQSMq17FqmE65kcNdxYOOj/xi3FDKuDM3n3A1FChTm7Q9lEqdWknMoieC0xI6EUNF+6TE3IQhTiOjqWMt13dDvRta7831QUZh6uw9rvjSWCpMIOVY266fLswvQaOs13nSk4xFCNQADCRTX0V6mII4I+iRxJdLZWnndzt4X4Uq0oTp1ueJDUe63dDM4qjW3EP5aMuoL
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39850400004)(136003)(366004)(396003)(451199021)(2616005)(107886003)(6506007)(1076003)(26005)(186003)(83380400001)(316002)(2906002)(66946007)(4326008)(6916009)(66476007)(66556008)(5660300002)(41300700001)(8676002)(8936002)(6666004)(6486002)(6512007)(9686003)(52116002)(478600001)(38100700002)(38350700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?RZCW8cCgtNMCKmShnwN1mZUaHhMvNScfj16dOaKgrbNbhHxdY5k8nnBYWVYP?=
 =?us-ascii?Q?IaBHpq8vzyDcNc3dkM9CWe1jqu2lR9n0qjpYLezZ7MCuRk62jridgLCnrOnu?=
 =?us-ascii?Q?fSxlUAQup/yFnPOaICwePgN5IcjIXN8Yen2DIrcbqpTco+7o44ReIKcX+5AG?=
 =?us-ascii?Q?9d1dDxCWLn6EoLDvFFFNgVZ1jMi/KrMdzVBUK8EEj6HRqvDV4YUcbWm4QvTP?=
 =?us-ascii?Q?BjbaQfY7r0H0ax6NjA3ib6xlpsUJlCJiqAvCnjSeTN2eCHtCXANSs8l7rTva?=
 =?us-ascii?Q?gFZJXSTmGHt5IPN+4MD1nXmAzDdTZtm+Wi8LQvI+WtCT5z7p/jsePh1N7kd1?=
 =?us-ascii?Q?k/KoxtgtPj+QQK5yy52MW0e6n4unoKxKIZHNEUVmqLyH52OUreaZGivGmpi2?=
 =?us-ascii?Q?4lN+0TwSdD46GpeBmbbaeznd+CQ/pmkkFBggBP/8nC4CqmKKW2l5VPUFlutk?=
 =?us-ascii?Q?DSDj5dLyLampJT028JKurwr2ygIm3FOSjCj6qqVsoaGaV1i8Zp4VAwN/on6S?=
 =?us-ascii?Q?JMi48ln/u/1MKQaHMlaFYcvCSAPeO/nsKFnulO3Ktyt36IrROhuIBT86I2SS?=
 =?us-ascii?Q?GGTxk7JtpQC6pxT+upFAzNrMUkI7XNO3TLtTOypFnxUCAm6ZHs6Zve3yKLNN?=
 =?us-ascii?Q?adBa6XgZToMuJPgsRl8IoX0fUX0XjEuMQYOvk1iTvRaWaN2jW3wLQC9dDjpZ?=
 =?us-ascii?Q?i+L3eBHH3uDQ8ZLSO6nVEjpS+MRR9IH1eOaUeTyzO4n0Fq4AtacuDUOaMzI0?=
 =?us-ascii?Q?N5HOthLtTAii428j25as5vc6Fl3/Hzyu+ppxomDCxIjtYLJRFJ/bGFjcab6q?=
 =?us-ascii?Q?wFxAPVUPAT4Emy1IQLDJ1Yh/6+NAmu/QYp92RmiDY1zyVKtaCW4hTrg1QidC?=
 =?us-ascii?Q?t6G+cIe6mz6XQnLx7WI0K5funUhWdVKOo7sqIIecSFxDpI8GyEe3B+BTlr8T?=
 =?us-ascii?Q?4crYlTR8MF6yqV+H3Nw6AWy+7mW9vuFbXBz7QdiLuOIXVJRroiUafHMjWS44?=
 =?us-ascii?Q?ip1uSlQaX03v+ggT49apN0sDw1dFhHJLJCug5I5wLAUvJI3aFGaNiJBzdMzB?=
 =?us-ascii?Q?KIWKniNOwICxMLtSZX2yTv8FxkXuqz/1c+0F9TKQCb4+sxIkxxmIGHC1ixzf?=
 =?us-ascii?Q?fw05tvfQy8KlWxy8GjGHvX0nFe+Fj6RzQY4iUjDMAaX2dJWPxFikCIqrPB/l?=
 =?us-ascii?Q?gT9NlxqHuTEZP941hC4zTpTbZyxrNu1SsATSdULvxO0s4ho32jcH8ZKhnZ4z?=
 =?us-ascii?Q?t5Fv4/hq2OTDZbfzbqGM508c2twPa9PgfxFmmZFX3HkI7NxoQC1ZEiiT/rYc?=
 =?us-ascii?Q?XN5faSmqkl7QzmQvVALsHenCmkVKkdsA8JDNs156lpJWUGWOcY/Q2KO8x3zh?=
 =?us-ascii?Q?ue57xesLjiHdb9bAcgsjaKiVBnj3nbluEyk9OYFL5BgUdxbCaKegx7KDjMe5?=
 =?us-ascii?Q?UIAHcII8YyvlI8LJVOO96S1tarXgc9Wcjv7i+E3jDDGC1OjiC/Cw4ZferZ6t?=
 =?us-ascii?Q?dMfb2ZnaCafDEwF/7mzGGvyHI/Bj60AC2q+7MscVYK3CkSWIS3C4lpW9V2LH?=
 =?us-ascii?Q?W9Py4qMNawujscuncDcfj2Ex0b7lkNHOJ5Z/wcI7?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f264b430-35f4-4ac1-d6f4-08db93e13a34
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 05:19:35.8527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lTBWyCl4ariXq8ifnIPWh65ZHcH0UiCf+NOSrleAcX57eUlW5T5Opq2ssH/ytzpDPKbvLbijgpE67c8BW6ScKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5562
X-Proofpoint-ORIG-GUID: 3wa2KcQHLWMH-6_UCPBhxfgjVQIw7U7k
X-Proofpoint-GUID: 3wa2KcQHLWMH-6_UCPBhxfgjVQIw7U7k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_03,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2308030048
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 03 Aug 2023 05:19:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14909

From: Chen Qi <Qi.Chen@windriver.com>

The current logic is not correct because if the time interval
between the current check and the last check is very small, the PSI
checker is not likely to block things even if the system is heavy
loaded.

It's not good to calculate the value too often. So we change to a 1s
check. As a build will usually take at least minutes, using the 1s value
seems reasonable.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 bitbake/lib/bb/runqueue.py | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 48788f4aa6..769709f2d1 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -179,6 +179,7 @@ class RunQueueScheduler(object):
                     self.prev_memory_pressure = memory_pressure_fds.readline().split()[4].split("=")[1]
                     self.prev_pressure_time = time.time()
                 self.check_pressure = True
+                self.psi_exceeded = False
             except:
                 bb.note("The /proc/pressure files can't be read. Continuing build without monitoring pressure")
                 self.check_pressure = False
@@ -191,6 +192,10 @@ class RunQueueScheduler(object):
         BB_PRESSURE_MAX_{CPU|IO|MEMORY} are set, return True if above threshold.
         """
         if self.check_pressure:
+            now = time.time()
+            tdiff = now - self.prev_pressure_time
+            if tdiff < 1.0:
+                return self.psi_exceeded
             with open("/proc/pressure/cpu") as cpu_pressure_fds, \
                 open("/proc/pressure/io") as io_pressure_fds, \
                 open("/proc/pressure/memory") as memory_pressure_fds:
@@ -198,25 +203,19 @@ class RunQueueScheduler(object):
                 curr_cpu_pressure = cpu_pressure_fds.readline().split()[4].split("=")[1]
                 curr_io_pressure = io_pressure_fds.readline().split()[4].split("=")[1]
                 curr_memory_pressure = memory_pressure_fds.readline().split()[4].split("=")[1]
-                now = time.time()
-                tdiff = now - self.prev_pressure_time
-                if tdiff > 1.0:
-                    exceeds_cpu_pressure =  self.rq.max_cpu_pressure and (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) / tdiff > self.rq.max_cpu_pressure
-                    exceeds_io_pressure =  self.rq.max_io_pressure and (float(curr_io_pressure) - float(self.prev_io_pressure)) / tdiff > self.rq.max_io_pressure
-                    exceeds_memory_pressure = self.rq.max_memory_pressure and (float(curr_memory_pressure) - float(self.prev_memory_pressure)) / tdiff > self.rq.max_memory_pressure
-                    self.prev_cpu_pressure = curr_cpu_pressure
-                    self.prev_io_pressure = curr_io_pressure
-                    self.prev_memory_pressure = curr_memory_pressure
-                    self.prev_pressure_time = now
-                else:
-                    exceeds_cpu_pressure =  self.rq.max_cpu_pressure and (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) > self.rq.max_cpu_pressure
-                    exceeds_io_pressure =  self.rq.max_io_pressure and (float(curr_io_pressure) - float(self.prev_io_pressure)) > self.rq.max_io_pressure
-                    exceeds_memory_pressure = self.rq.max_memory_pressure and (float(curr_memory_pressure) - float(self.prev_memory_pressure)) > self.rq.max_memory_pressure
+                exceeds_cpu_pressure =  self.rq.max_cpu_pressure and (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) / tdiff > self.rq.max_cpu_pressure
+                exceeds_io_pressure =  self.rq.max_io_pressure and (float(curr_io_pressure) - float(self.prev_io_pressure)) / tdiff > self.rq.max_io_pressure
+                exceeds_memory_pressure = self.rq.max_memory_pressure and (float(curr_memory_pressure) - float(self.prev_memory_pressure)) / tdiff > self.rq.max_memory_pressure
+                self.prev_cpu_pressure = curr_cpu_pressure
+                self.prev_io_pressure = curr_io_pressure
+                self.prev_memory_pressure = curr_memory_pressure
+                self.prev_pressure_time = now
+                self.psi_exceeded = exceeds_cpu_pressure or exceeds_io_pressure or exceeds_memory_pressure
             pressure_state = (exceeds_cpu_pressure, exceeds_io_pressure, exceeds_memory_pressure)
             if hasattr(self, "pressure_state") and pressure_state != self.pressure_state:
                 bb.note("Pressure status changed to CPU: %s, IO: %s, Mem: %s" % pressure_state)
             self.pressure_state = pressure_state
-            return (exceeds_cpu_pressure or exceeds_io_pressure or exceeds_memory_pressure)
+            return self.psi_exceeded
         return False
 
     def next_buildable_task(self):
-- 
2.34.1


