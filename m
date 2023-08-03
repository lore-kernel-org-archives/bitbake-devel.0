Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F116EC001DF
	for <webhook@archiver.kernel.org>; Thu,  3 Aug 2023 07:57:06 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.9152.1691049417699961758
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 03 Aug 2023 00:56:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=VF+F2dTG;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=7579963e98=qi.chen@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3736NerP015351
	for <bitbake-devel@lists.openembedded.org>; Thu, 3 Aug 2023 00:56:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=PPS06212021; bh=/QBRljqHdSp1OR2L6w
	3gXbWPKK2jmMIqa+z5dj9PAIA=; b=VF+F2dTGWOUlr4CAD8JTOXll9OzV8loYKp
	+u5PzwUZQB77/DLpnB9gCnoC6NaGYcf70N1Llxx6wbe99ZH43lgIsMNOkHh+VkbA
	FXNasRULoiS7+4Gt2Ny4bzKa43mzF2OnTOgx0QwZPxxyY5r71gRR3fxa7HpeQVXS
	F0cM8NPY8nFQ3Y6OaK/RttdqxWgaYn8r/bJPrdtPEAz29sW4P4tJFQBkcpKuayyF
	ADHoI3KXhtie/VbWcoTS6EWEe3oWg4BEiYNSfcygyZzM/VLxqoXxbAh0RzZeFjCW
	7ytv/4A9dVsvQ5wcBuyi8y+8dpPokGFzn0vonh7OJ+4XRMQM3yIQ==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3s6daqtxtd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 03 Aug 2023 00:56:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PAHWroH0KIa+8aQSQYB5s2tZFjtTuisOQTrmxVu76+TwDi6Y3i1SXcQ8d1brp01k+bT8xE+qNfa1SahUBJojg+d46ISeQW/fo05iO2C42ROhIzGhtY2HsWSlXvT1xnx/5Sx/hgmdtq2UTLryQz+4fvx5sQiAqcRQ2XhxGkEPMZHORE+ldM7HkEpo9N7qA1ZkzN/XUBNtruMHI9GEzktnoVxUQug1ICU26kJ2jPCfaWTcZO2Jj0cfb3kqhmK+Urxh9ssXLoFbeUZCseId4enRUct+21RS3cvX+9Ii0c2Is84k6eV0XyShtP7w8yeosiVXWjKzXO7cAMA71GyffSlvPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QBRljqHdSp1OR2L6w3gXbWPKK2jmMIqa+z5dj9PAIA=;
 b=XYLwIGWL+1Fx0JpO2+Hy4sBQKEpHyq+jY0Ke40Oq84G9hHkzkOuFrKd7tHTsT+Cm9nuuc1dT0YgWXKE8Ll9zq+4wlehoEvZBPZLk+gG0ragKhK/f0v1K0qQRkkYnZNmLy+C7WkMCqI5e/wLa6300sh82LxCsszpH2zlQPpwWa4434W0lkaUcet8lFyg14DVryYoZRAGWvSrZIatDcfYqB/vkhRy6m+/aWS7Pohho+F9kS5jOLd3y/4c0HupiiukEanAMuGoi4siWhi9xeLQu3AKT3m0TFItb/n6W5bsobW5TDw9YqGJ7sUTBDKmpskKziX8adnVRYvRFK37rmoLJ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by CY5PR11MB6258.namprd11.prod.outlook.com (2603:10b6:930:25::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 07:56:55 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::86dd:2ee6:ac66:812d]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::86dd:2ee6:ac66:812d%4]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 07:56:55 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org
Cc: randy.macleod@windriver.com
Subject: [bitbake-devel][PATCH V4] runqueue.py: fix PSI check logic
Date: Thu,  3 Aug 2023 15:56:38 +0800
Message-Id: <20230803075638.2355913-1-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0044.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::8) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|CY5PR11MB6258:EE_
X-MS-Office365-Filtering-Correlation-Id: 8de260b0-0cf1-452d-7124-08db93f7345a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	KLS7d1ZyoPXoO9xjdDao5sIeb5jQ5vhsU+JsjL/bC60OjHXaklabOqEdGEghDsZ1LQteaGQKrlM40a8rOXmdhVUMY9X2Y0Rx6pmUcFCUTo3R9ggTt1U0uUFPe5r8IniO2Njwf2PI0xSLcQzoCtp64RcNKQQb3j4xAGuQ3FjuWj0L4Rn9R0fOvQUWnB8ilS3EXkOWBsxdHeBLStHakN5QekeTRmktSYuSETsejzLIHteZJyhxjXw1XLv/VKq6v6Lmzdj6ZqS1/CcWf4885AGpZLhXbjk2Gp7QN02jEbYYo8iMCaecCFaSBXw9HSJsZmfuwMy6YQ5210JwtXH/QLYBb+xGeQShAG75oz0JNa7NUvhnPXCQlD2q5esr0UnW2tlhvBJCfMAtEiwlV8FIx2fYxSYYgXhQNBfJIwdBI8vglLlcEJ0LcyfOqqBGXew8Ixq1zBQbZdjhcTML9lB2KQ/ADNU6sL97w3gfUvica4cxNhkBS1Y2Qy8P9J8KI+rmYEVlYtpeibAp5KRzuxWTR84QvKIthvo1KuxBZl7dKMfZSIdNLxy2USc/yhW4mk97ThTiyUErCi3hnhpPr60h2KDyQuS3mklPwWA1hmHsrBTYkElUxJTOjmiKWNEdK+PidsGLpffuDNKV/BZA1RhnQEureg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(396003)(39850400004)(136003)(451199021)(2616005)(1076003)(107886003)(6506007)(83380400001)(26005)(186003)(316002)(2906002)(66946007)(4326008)(66476007)(66556008)(5660300002)(6916009)(41300700001)(8676002)(8936002)(6486002)(6666004)(6512007)(9686003)(52116002)(478600001)(38350700002)(38100700002)(36756003)(86362001)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?D7KaxAKBAB9ne/eSHLVnXuWvrcc1PJ7XoYfBYVWakq0SdSQrrbqA6AEiF9dh?=
 =?us-ascii?Q?6coQqFCuMGLeDtl89bk8C2a9BT4HW3N2a+QGnjvAKpNi5p4HBoSNpX0+7hdk?=
 =?us-ascii?Q?cLKQo5LjCtCvlOpz2fqAQeqPHnApNsE7GEO/LGrrFRAXOw9J/AVhS9hk9sVm?=
 =?us-ascii?Q?Uebzc5F2mNj0X7qQfEJT/9lgPm4De/tex7vzv2WMMDdoTlsanTtsqKHxnDil?=
 =?us-ascii?Q?TUQFKCKUDaYSVWEqGuxql/OPuvXOxDFZz6PSfMO9YscXGYj3l4lnFCED+E/z?=
 =?us-ascii?Q?e+d546bfuHbDBfW/2xJc99kraNbdrfPxD8jCRUTGaLCDV5vNCvWfaVYkeGfp?=
 =?us-ascii?Q?zhNhdKXds60ALOWHmHPFDBPoU1UT7IcivoHirwUwMhzbGA6U24ZF6dkaEcrG?=
 =?us-ascii?Q?pyQDMDqm11F9HSQcKWUBWhPB6L+IQtiKin3UPHzscIwM2H07XtUUYNWki8+8?=
 =?us-ascii?Q?Jv67RK929JSXXKXW/TdvANOSdP+2SgClI2Bqf1meIT8fRdxqZmT5fBZmhq9V?=
 =?us-ascii?Q?2UacCOT0SbyQ7IUP88x7FQtIX3gvVq72BAkvwDZj4UUoGWRm/1p0UOWzh7fI?=
 =?us-ascii?Q?fBqUMuEkzO71eEIqX0Koek8MBHcoIFy3g58qoJNXVxRu2XfURnhqhQtZRNRq?=
 =?us-ascii?Q?KlLIinCAQ16oycN1eQxmVJ4cnz4bWunrM3iRsrER+1P/5S+oHxYUeGc+X3yB?=
 =?us-ascii?Q?ad+JZPoNmN3DH9HnI1SLdmsEJBEnJ86bSlgRJdXVZAt5Kok2l3oicDDJq3Sd?=
 =?us-ascii?Q?GqQvWiHP799Uwtwzqfts4kD/oLRJsbbYLZNDQNh+xVgmDaPNINfSFtyZafh5?=
 =?us-ascii?Q?xeVXYJVfvyxigs+xznZH/uI11eE2QvVDEXgJZT/kWu61sCZXSE6Eqbgx46Y4?=
 =?us-ascii?Q?Jx8m5Qxk3Tc5TivEKHfS85RTyWohG64LH28cdB8OaZ7RSH/2TF4SoNoooj51?=
 =?us-ascii?Q?Ia6kO3wphq4w8qBgKVTH/YCcmtovn4EsCC60tv5KQmxYZ3DnJCPTxafsBHU7?=
 =?us-ascii?Q?G7pmlpKCiGDdOuBmru+W7AqeQJ4RmC5qwjCZGYoL3Dt5RnaL2F1qKsABLeWf?=
 =?us-ascii?Q?SkcvEjtb2SmglfpGrOiAlTMDuns8B0Q/Fbo8ZoD+5swLYDJh6qE3u2xt9NP0?=
 =?us-ascii?Q?Kg+hS5o8dHx7xQSvR4nQvV7rAF+VP3q8rkkDJ0LjNIH9t/inmyPnnTF05nnP?=
 =?us-ascii?Q?Ul4oLKWtigZlxUwYML5sSAAHZ32d611qyvwgqsP3CVXC2nxRg4k+MeCQfbUz?=
 =?us-ascii?Q?1biLoaXI0jj7xgMuIRzKYP64bbmROgemZWuzSozERJMtOqq1eA9rjj69ud0K?=
 =?us-ascii?Q?25Wd+rbWuG88bhxFLQ7yBcfWOfB/OEaknf7U0q/oMJLZrd8/Y1mRX6CCF/K2?=
 =?us-ascii?Q?IicbHZXpNHJTgI6pxc8g/x13Vzl3q/6Y9Q19Uq79P8h+g0AAKH4Oq6YhmySt?=
 =?us-ascii?Q?JnyLyXTIvRI2hFgE7km3QYPv+mpG4GAF2jef1v0KCY+1+zZcsKMh9JWNzr45?=
 =?us-ascii?Q?eQ5n17yu/mj1egDL9s6sBsBZe1hJ2cIrW1GtcOxFyp9onEh8CIZb9ijlKh4d?=
 =?us-ascii?Q?3ZOuXrurkOxORV/vaV9qoIuEfO6L2i3DZrIjL7TH?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de260b0-0cf1-452d-7124-08db93f7345a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 07:56:55.1148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yFF14DIMmxpcqbDCXnV+XmsbLDnGdHr8z9UUHKiauTvQR69upQWbcFQBJHMgF720BNuBmYaaBuOeBBKBs3s5NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6258
X-Proofpoint-ORIG-GUID: 1pYTaxaIAm4hnFQpAd5jauZlM3Mvmuaw
X-Proofpoint-GUID: 1pYTaxaIAm4hnFQpAd5jauZlM3Mvmuaw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_06,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2308030070
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 03 Aug 2023 07:57:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14913

From: Chen Qi <Qi.Chen@windriver.com>

The current logic is not correct because if the time interval
between the current check and the last check is very small, the PSI
checker is not likely to block things even if the system is heavy
loaded. In fact, if the time interval is very small, the result
might be 0, resulting in any small value not having any effect.

To reproduce the current problem, set BB_PRESSURE_MAX_CPU/IO/MEMORY
to "1", and start a build. We can see there's more than one tasks
running throughout the whole build process.

This patch improves things a little bit. It will block task spawning
for at least 1s if the limits are exceeded, this is to overcome the
0 result issue. On the other hand, if the task spawning is not
blocked, we check the pressure every time.

However, even with this fix, we still have the task spawning peek issue.
Because at some point, when the load is low enough, a few tasks will
be spawned altogether.

In summary, this patch improves the situation, but the peek task
spawning peek issue is still there.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 bitbake/lib/bb/runqueue.py | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 48788f4aa6..7c482a55f3 100644
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
@@ -191,6 +192,14 @@ class RunQueueScheduler(object):
         BB_PRESSURE_MAX_{CPU|IO|MEMORY} are set, return True if above threshold.
         """
         if self.check_pressure:
+            now = time.time()
+            tdiff = now - self.prev_pressure_time
+            # If task spawning has been blocked, block it for at least 1s;
+            # otherwise, check the pressure ASAP. This is because if tdiff is very small
+            # the result of (curr_xxx_pressure - prev_xxx_pressure) might be 0, resulting
+            # in any small value not having effect.
+            if self.psi_exceeded and tdiff < 1.0:
+                return self.psi_exceeded
             with open("/proc/pressure/cpu") as cpu_pressure_fds, \
                 open("/proc/pressure/io") as io_pressure_fds, \
                 open("/proc/pressure/memory") as memory_pressure_fds:
@@ -198,25 +207,19 @@ class RunQueueScheduler(object):
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


