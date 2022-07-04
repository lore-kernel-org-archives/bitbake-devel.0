Return-Path: <aryaman.gupta@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B1EC433EF
	for <webhook@archiver.kernel.org>; Mon,  4 Jul 2022 20:44:33 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.77182.1656967466272202994
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 04 Jul 2022 13:44:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=C0/VEDD9;
 spf=permerror,
 err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}:
 invalid domain name (domain: windriver.com, ip: 205.220.166.238,
 mailfrom: prvs=4184a58e85=aryaman.gupta@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id
 264KhhLA014083
	for <bitbake-devel@lists.openembedded.org>; Mon, 4 Jul 2022 13:44:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=from : to :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=badmgDWO2+3x8QFQf+T4PCUht96WL85dACsvXs70wmo=;
 b=C0/VEDD9kfbXPJehq79VfG+FK7QsiQUI5WwCPxq2FavHiFHp0EAnYpZMB7bgSOKLx9NQ
 D8RR2ueEjU+ap7ArLvDuMJCJBuVXsUSeVNl/xunp+Y8LoOwLG/fSeUGSXT/jnnbralEg
 +gK7IDfnL89AqnUd5kEb37dJFea7zmFMDTe9e84YeeL+7BNb0fJUTLJmDmAMk4G4E1D1
 d8YKEfKf0LxG2Vwg+WaWLHcSzLDLQ2lubreEDMGhib0sH/wUYMgOBFWlcfm1HGyDs98f
 Yw1wlvirpZVDFTDO/+cnGSn5YlLqJ5fNsAjwGnsIUrNedMm8ih4AP22jX4lMyuxA81xN Ew==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3h2ha4hhxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 04 Jul 2022 13:44:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MyqDLLmahf+YWy7HqjszY5v9VUPNpARTJY67EYKVnlR6h/rpvcYyJOnfAdLfFU6FBsnsGu9ZqTn1Rvzg3OM/W853K6EvzBndnApfATfMmbinwHH4OyispTFl5tL6wkUH5mC4MKpBmHgr5gH3JUb0tv9vZxW7Zj/cm4C3gNsljc3VHdalmKLdyp1QQcLuO3YcMC55S/4LxopgpSzv639BYfh1h3aeTJZWWz4C2xWlFKhI13R7ZVCrqlCzDaf9PorUc/W5NIAGuNbhjE/r26IWkxUjE7e7ap9WRWhLuZiRceypd/toYtmsIzXyl/asJpVKA5Nmtw4iFC6aswTs8g3Rng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=badmgDWO2+3x8QFQf+T4PCUht96WL85dACsvXs70wmo=;
 b=GOjAJOqBqavfOZuWIsIfBcuBQwPYYkJaxFzTRDusqkTPaCPsLiljBtW+s14C1EFpAJ7OvYC16QMXzPAPhvXOAe+rUIBZkrl04EDrRACUzQcXzIoEDUhyGuxTGpvqoAkkUZ3iwRLMzD73uHG0rKfz4NRlCJJ0pgqS8uIhgte5NJ/J9fZa6Bl6GzZnA/y14hJ4dum0b1GQox8N19O07vjN1VDS/inrMWUJK4XOo5gBVh2bSXgmqxsFEdNVTN7t4be5qU5GOdO/Yhf2MP0wIRtdCjZKUT97bEO/vBTjdUhP6p9gqvb3XCbvfBt6dyLZew4VIzTWZO58G7jX3Kmy/EgYqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH7PR11MB6030.namprd11.prod.outlook.com (2603:10b6:510:1d1::19)
 by CY4PR11MB1304.namprd11.prod.outlook.com (2603:10b6:903:2c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Mon, 4 Jul
 2022 20:44:22 +0000
Received: from PH7PR11MB6030.namprd11.prod.outlook.com
 ([fe80::14a3:342b:5f14:eda6]) by PH7PR11MB6030.namprd11.prod.outlook.com
 ([fe80::14a3:342b:5f14:eda6%7]) with mapi id 15.20.5395.018; Mon, 4 Jul 2022
 20:44:22 +0000
From: Aryaman Gupta <aryaman.gupta@windriver.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2] runqueue: add cpu/io pressure regulation
Date: Mon,  4 Jul 2022 16:44:09 -0400
Message-Id: <20220704204409.3692354-1-aryaman.gupta@windriver.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::13) To PH7PR11MB6030.namprd11.prod.outlook.com
 (2603:10b6:510:1d1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6d07b09-1f63-40e9-f67f-08da5dfdf965
X-MS-TrafficTypeDiagnostic: CY4PR11MB1304:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	UaVypILAG8pwCOPvBJW44aPFS7fhv0PNUwGq++UZNCs+9Pw5vkXYUkE3Zzk4p9BsuNMYsjwdtHFGJJHE5dLLVAERcyiTWccH1abB0d6JP21WB1gQp7yBVqQLQ5bBsJpd6eHLbA59irOxwueCk/gLeWY1gOpxz/roeNDLo3zY5klhhKYLvvxc/o0IxfQ9h9u49bhktSl3mT5IGUTAv2In8CCX9phA18Evr82uF4MsyC+yz0EzKai2zoMDAzqokT+R/bELxoOXufSpay33cSyqzPeO1vA4BsJuOMjx1dU0Ldx+nzGCQ68Tb6IUFH7bX18chWzNAyIdxmZsMAu4u1seXh0qfvcdPKq6qm84k7urWuJL0AfZsNYKIFNnEAFvRgOEvjiFGy4B4VEW7cZ9EoAk7gsc3Fzj1ObPXqrvqCjpXX/sKZHgOaKL5zc758G5yNHvp4OLzP5x3z4xZ2e9Wn2P/PEYb/9y+MV/3O/L37NyZOMZCgZJ61W3XO+DFqkQM8/WGi1PKssJ122oGLwzA9PppENVShB1Xlm7uGpxp4Ay6uNe43CuCN25sHw3RJbdnMGbQlxDTBzUttIP/e/Ykqu9wV+/OnitSpqONWSv9JG66gZI8vaDZtas8njmyGW+p4qSfvqQ0WjZ5XHXw3UBsJDevvov1RWm4hpQbS2bHUweobdqqbznEIUtgFw8dJUgKfWJgPjdWnXG82HZRVIFUMB2LI/6qrlqJbpLaTUkilSwjjTsagxilnrPWF7Iu1q+30pS7sMjA2vcMkxi0WR1CfqNGOtOKjUXXLbRQc+ExaZ7DaR3BhSwtmLsdfCyeiGO3xjp
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6030.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(396003)(39850400004)(366004)(36756003)(1076003)(83380400001)(2616005)(478600001)(8676002)(186003)(2906002)(38100700002)(38350700002)(6486002)(6666004)(41300700001)(316002)(5660300002)(52116002)(6512007)(26005)(44832011)(66946007)(8936002)(66556008)(6916009)(86362001)(66476007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xnXm98eDt57hSWaNs88blFNedpTjW49lX7A8rHK53qaKhlkPisOct/iNS2BC?=
 =?us-ascii?Q?M2TXxSMU+VJ1V2ZI28pqnVFWbc2F2QZQ9OY+9cM0JonPLwT9uC+8lnyxaQwk?=
 =?us-ascii?Q?zHUc0MJZY9QHvwpmRbE/WlWrL42dJEH5RJVXKOlppPi0DsuWILS0tq3diINk?=
 =?us-ascii?Q?Osp3VDPMjKGg5Kk2a6tQ6ZaCiKwFlHAD7a4FLStVWcDX10i5uD+59LqeIVXK?=
 =?us-ascii?Q?ayYyBRPOnNu1UiVgOZmsQA+ZyrnVirxHXCWgycB8O7endbNJ17WhXsZsGZyM?=
 =?us-ascii?Q?QpryrCPJgWwbTTo9BfDPROGF2E0+l/8b8PcFcD8V431pBtYv81Kg+ult6ldd?=
 =?us-ascii?Q?mqfML0SbT4VdZvIj4r+jWQsHQbSUaafvv/EY9KoPxIhPnADjRHit/0x7sdJm?=
 =?us-ascii?Q?d15hi2wTCxIDXwMua+/g10ETwLp1BZ77IWBY+kS5f7VMMk5yb2OLdy8ohTZ+?=
 =?us-ascii?Q?I3JKRiv+q/8x8nnyXDpbd2xxjlFBK5Sk++ui1cztUuKjqxLiaX0jlU2gcGgo?=
 =?us-ascii?Q?gRCpthcNgHaxBROOVD0dQwPdvA5Ou7FeVeVeJWZ0A31GEINpj2BQ2JHPYmN7?=
 =?us-ascii?Q?iAfYXIPSKxucisIIo21mfS+C3MOkEaCjCz6oLcqqLr1QTDru+W4sou8mooMi?=
 =?us-ascii?Q?c2tHp+Ym/GVK0lX+oGlIuZv3F4aPdnosehZV6Jq1tam+adTvVnupluIXOALc?=
 =?us-ascii?Q?zBOt13SFwXBh76YPuBUYZbA/L7QwBovt0Yzmswn3XG5T60YQRmXshjLgVwRT?=
 =?us-ascii?Q?kMoSXQaV5YJLODXdZe50CcPj884uhnuqgNhTfr1qXA4DHFD5fvM7c0F8o3Zc?=
 =?us-ascii?Q?oNbRKNN2o3QA1GKJWMMps6KjEe/C8UCp9kzce2WQ4w49yS3JodXvP/th+hJC?=
 =?us-ascii?Q?3ERM+Gm5nUB6hkz7H59Ey7Ehy2psNUKe/AuxuA5wf91I5+/H2+aDhfLNYvRf?=
 =?us-ascii?Q?ZWdJi9nxNT3AAQtUvPbXlEDoTp94mAhEQP7J53rjy5Oa+cFJT0y1domAxRHS?=
 =?us-ascii?Q?kGJ7e3KGtRVSKRCKuDRuW+jXpMn4SLkJx4JBncYBnOOLtfwnGImSvpzzB8UE?=
 =?us-ascii?Q?4cVAH9dlKTLMkcNXO7wWRtEVfVFmJHWx6RrOM4xjI2GOU0CdGcYUTuv6U1Ot?=
 =?us-ascii?Q?IVtIBFcffOzUtLSDHkzAhEOW5uAt0dAqkCakpVsVnE6JZArb3N33s5QJIf3m?=
 =?us-ascii?Q?sEPzZIAT9jUkd16OhIDHOlvV6zCS0PHKskelP6/3/9J4PIQEx+yipdlVs/0x?=
 =?us-ascii?Q?p+hauug8uDsJ0Dnl1D60lerPkUgz1LnQOIOd7rNsj9GAqiSEhCctjmgWAp6K?=
 =?us-ascii?Q?TPbZJ7dPmYGaW02jaR4vJ6Uv1AHqL4vsHGUno6cii18U9AEh49X2duFkTWWA?=
 =?us-ascii?Q?LjMKC0sCmItx/+wOOynom/+sFMQF6jedtwaSYkTUkt+90Uxj9tIBpsNXY+i3?=
 =?us-ascii?Q?H5842FsARLvIsIRfY5oGk5L7241SG5d1Uv3f1Ht3/ObJj1r3a5RS3DhrVhPB?=
 =?us-ascii?Q?Zv0k6DCy/QyLcjbHqjgeWipQ6SnsN1CF8XrqdsVK+CfODWwB913QN/8UL2vZ?=
 =?us-ascii?Q?UUsTH4ue+/I2JqAsfRfJqzhNxeoZyuLALUKddOwp++h817svJ8m0drxDwN5K?=
 =?us-ascii?Q?bA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 e6d07b09-1f63-40e9-f67f-08da5dfdf965
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6030.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 20:44:22.0071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 1eVPFc0i9bLuvXOECXZqMX5dG23QYm1zEr6bwyUQkR3c61Gh/J2P/ygGvJ5mF8SQLhL1iCLeXr+7//2FFCLEpsAHSmMLWZA3TLwTvQItcvE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1304
X-Proofpoint-ORIG-GUID: 7e-HWNQuzCMCVNcgw7FybXm6pbbOlmSv
X-Proofpoint-GUID: 7e-HWNQuzCMCVNcgw7FybXm6pbbOlmSv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-04_19,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 clxscore=1011 malwarescore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2207040090
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 04 Jul 2022 20:44:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13797

Stop the scheduler from starting new tasks if the current cpu or io
pressure is above a certain threshold, specified through the
"BB_PRESSURE_MAX_SOME_{CPU|IO}" variables in conf/local.conf.

If the thresholds aren't specified, the default values are 100 for both
CPU and IO, which will have no impact on build times.
Arbitary lower limit of 1.0 results in a fatal error to avoid extremely
long builds. If the percentage limits are higher than 100, then the
default values are used and warnings are issued to inform users that the
specified limit is out of bounds.

Signed-off-by: Aryaman Gupta <aryaman.gupta@windriver.com>
Signed-off-by: Randy Macleod <randy.macleod@windriver.com>
---

* Changes in V2:
- Replace subprocess() calls with open()
- Rename BB variables to BB_PRESSURE_MAX_SOME_{CPU|IO}
- Skip the checking of pressure when no value is provided.

 bitbake/lib/bb/runqueue.py | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 1e47fe70ef..0500211c8d 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -159,6 +159,26 @@ class RunQueueScheduler(object):
                 self.buildable.append(tid)
 
         self.rev_prio_map = None
+        # Some hosts like openSUSE have readable /proc/pressure files
+        # but throw errors when these files are opened.
+        try:
+            with open("/proc/pressure/cpu") as cpu_pressure_fds, open("/proc/pressure/io") as io_pressure_fds:
+                cpu_pressure_fds.read()
+                io_pressure_fds.read()
+            self.readable_pressure_files = True
+        except:
+            if self.rq.max_cpu_pressure!=100 or self.rq.max_io_pressure!=100:
+                bb.warn("The /proc/pressure files can't be read. Continuing build without monitoring pressure")
+            self.readable_pressure_files = False
+
+    def exceeds_max_pressure(self):
+        if self.readable_pressure_files and self.rq.max_cpu_pressure<100 and self.rq.max_io_pressure<100:
+            # extract avg10 from /proc/pressure/{cpu|io}
+            with open("/proc/pressure/cpu") as cpu_pressure_fds, open("/proc/pressure/io") as io_pressure_fds:
+                curr_cpu_pressure = cpu_pressure_fds.readline().split()[1].split("=")[1]
+                curr_io_pressure = io_pressure_fds.readline().split()[1].split("=")[1]
+            return float(curr_cpu_pressure) > self.rq.max_cpu_pressure or float(curr_io_pressure) > self.rq.max_io_pressure
+        return False
 
     def next_buildable_task(self):
         """
@@ -171,6 +191,8 @@ class RunQueueScheduler(object):
         buildable.intersection_update(self.rq.tasks_covered | self.rq.tasks_notcovered)
         if not buildable:
             return None
+        if self.exceeds_max_pressure():
+            return None
 
         # Filter out tasks that have a max number of threads that have been exceeded
         skip_buildable = {}
@@ -1699,6 +1721,8 @@ class RunQueueExecute:
 
         self.number_tasks = int(self.cfgData.getVar("BB_NUMBER_THREADS") or 1)
         self.scheduler = self.cfgData.getVar("BB_SCHEDULER") or "speed"
+        self.max_cpu_pressure = float(self.cfgData.getVar("BB_PRESSURE_MAX_SOME_CPU") or 100.0)
+        self.max_io_pressure = float(self.cfgData.getVar("BB_PRESSURE_MAX_SOME_IO") or 100.0)
 
         self.sq_buildable = set()
         self.sq_running = set()
@@ -1733,6 +1757,20 @@ class RunQueueExecute:
         if self.number_tasks <= 0:
              bb.fatal("Invalid BB_NUMBER_THREADS %s" % self.number_tasks)
 
+        lower_limit = 1.0
+        upper_limit = 100.0
+        if self.max_cpu_pressure < lower_limit:
+            bb.fatal("Invalid BB_PRESSURE_MAX_SOME_CPU %s, minimum value is %s" % (self.max_cpu_pressure, lower_limit))
+        if self.max_cpu_pressure > upper_limit:
+            bb.warn("Percentage value of BB_PRESSURE_MAX_SOME_CPU %s rounded down to %s" % (self.max_cpu_pressure, upper_limit))
+            self.max_cpu_pressure = upper_limit
+
+        if self.max_io_pressure < lower_limit:
+            bb.fatal("Invalid BB_PRESSURE_MAX_SOME_IO %s, minimum value is %s" % (self.max_io_pressure, lower_limit))
+        if self.max_io_pressure > upper_limit:
+            bb.warn("Percentage value of BB_PRESSURE_MAX_SOME_IO %s rounded down to %s" % (self.max_io_pressure, upper_limit))
+            self.max_io_pressure = upper_limit
+
         # List of setscene tasks which we've covered
         self.scenequeue_covered = set()
         # List of tasks which are covered (including setscene ones)
-- 
2.35.1


