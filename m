Return-Path: <aryaman.gupta@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975C3C43334
	for <webhook@archiver.kernel.org>; Thu, 21 Jul 2022 21:00:31 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web08.587.1658437224316846400
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 21 Jul 2022 14:00:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=V6QNo5q2;
 spf=permerror,
 err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}:
 invalid domain name (domain: windriver.com, ip: 205.220.178.238,
 mailfrom: prvs=4201b133b5=aryaman.gupta@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id
 26LKDKGR001166
	for <bitbake-devel@lists.openembedded.org>; Thu, 21 Jul 2022 21:00:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=from : to :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=+7dj8IciEwC47HT8NPq42ylEZl0a8bgaE0s2kcRsftY=;
 b=V6QNo5q2C99htXA1ilKY6GsIFO/tNkCwkkcteEq/lULwjVJ7BEkx01as29gk2OnKt8GQ
 XoksRcbkRZCgSvDB6UH6EljEqagfh2FLHL7/UVg+kRu7J2KZQMEMGDRUhODzOSb0ZDa1
 HFsAe3oPJ1zujKYh9ZZZra8+zqVbs2wsxiopOuMPhZxktPa/XOu9uPXG1UQHXCbe2xVW
 c2rjCEGk52Jw7pilCN4nB0idX6lpeAsbHm5AiaPID8/l2ZAZGZzy+D/kGKS33g6TwCtk
 KjYiuSK1yolHsPt7XT+sz2zF+YcBzZcOQcpM8dq8W6MI88o2hxun+xreSXLakKvaTvvG +Q==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3hbptncaq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 21 Jul 2022 21:00:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kuTgdKSKrt4sxmGAXlG8Kjb6ZrMWaYj7OUSClStcrqmMEs2OfZFMKMxeSc+EHlzb29t2/5/iKGD94OXLNo5gKWZweprjgRL+kiBa7XCSuMUA8TYMyedCWDOkdg8cmus2lJAjvxlpF4IeQ4Nv8lAGtsg8Pfz9+YNoKKgMicj4FiS6TryD938Oj4AiOl4gnHveM/cOS+1y4KGxd2MMKFVRShhHK0Gwuz211G5u6czPWFaFsSZDS6qvjuFrWw3mWlkqyq9pOdwdA7o7woR3zUnMXSpylk24bK6hcogsOASvZyCqSvdxMGH4GNc/VEsDCzMHE8OseWxDuQB3iholsmQNwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7dj8IciEwC47HT8NPq42ylEZl0a8bgaE0s2kcRsftY=;
 b=j2BuQTNbtuU9MS3IQcEaSgRhFKk3mFS2t51nFmcxEbwrlp9kHRFq48zlhfBpuNqR7F24W1ZE8s15os5J4HlXrG5ldRA2iPfq4LRo5wxlUWM15TjE8/AyH7Sdyow4DjMfPmoZphvI1ZCMU4avcGAS86IcwSE/H/KyE+TmQJltT/qJ8qz+u5Q7Z3imAqd2VNBMZKkAxrTPUdWI8bZcZFaGuYVz0VGscmz39/hFaQ2FP4xk9z8YkpSnlt2aie/yoMBj+uMqLxsu3PFmpI55x9ENz9Up7MWxrg/C3sxjf0NajahoilwHh7iJs+fGVAvoGoIlPI/jxSG2HxxBs+qpk22S9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH7PR11MB6030.namprd11.prod.outlook.com (2603:10b6:510:1d1::19)
 by MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 21 Jul
 2022 21:00:20 +0000
Received: from PH7PR11MB6030.namprd11.prod.outlook.com
 ([fe80::300a:e5c7:e79b:9a36]) by PH7PR11MB6030.namprd11.prod.outlook.com
 ([fe80::300a:e5c7:e79b:9a36%8]) with mapi id 15.20.5458.018; Thu, 21 Jul 2022
 21:00:19 +0000
From: Aryaman Gupta <aryaman.gupta@windriver.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v4] runqueue: add cpu/io pressure regulation
Date: Thu, 21 Jul 2022 17:00:03 -0400
Message-Id: <20220721210003.2741076-1-aryaman.gupta@windriver.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0334.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::9) To PH7PR11MB6030.namprd11.prod.outlook.com
 (2603:10b6:510:1d1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6beb998-6841-414f-e120-08da6b5c04f8
X-MS-TrafficTypeDiagnostic: MN0PR11MB5963:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	dxTCHtqnOmzd7ujUb9YB9GI5Ks21Wc196jMKyb2tMqGr8r2zGu0yU92+SpRK5gBBVLWprV8Ub3FqNQz3WryDH0daUqnvKfila9nFhvFh1W+6NOnbVDeJwsI527RSMGUwTd9weIn+NNQb6qUBRvpUE/yDZlRQ/c3CQjePFdUOD/oTbnCp3+/HO1vdrib9pIBCY8tk+oe+4hh4n/GHodo5FZJlxFs36ud8C1g6mdIf8yyoAlkLw/x5ZDidlwZCXf/TQL5B8fpDEmfgJAlSwDQoFCDV7UfJAt2xX62+NQqXvl5DzvIfn3P0TJ+pipOpAXJ1LuA/yMgjMELUO3pzx8LZRxIeIg2UiGtIIc6af3Atqof11VVCU9y5/8/PnJlWoPI+E6ttfIGvYkCylcIjEAol3XnJVDDjsAccQcKXzWhdVk03iOLRiJri1u1BReU0qe6nbvrQhAmJu9Gb7kzpnyWjpS6Ig0V+2yLcQd8uJmvdsCqD6TdNjSBk8dpcmMeHG6ixbFXK+wVM9eC6lLP6301v1q0iV2ws4Yo9sAO5hdWUr/pHrSOiRfMg5WZ9iRYfeRfghcJ8PeqwkAzGKWFkqGxGymhAJ73IB5eo5Y85b8Y0MA189Qa6g+0yt7ADryvkZKjXqzjwLNUnKq81fVcnsn1FXol4f8q3T5zoo84IT28cp6z3U011UTqqa3Th5zPUQDZMM2Kkuy+1doMyxQD4NYGwp8uRhlZT89GuelSVyiT9v1N6EDU1b6cVfxQSeTA/98FyQcAzFGO9R5FzPzx/ax/jotu3J3kwmMc2u4CCRyhTer0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6030.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39850400004)(136003)(366004)(346002)(376002)(396003)(8936002)(2906002)(5660300002)(66556008)(66476007)(66946007)(8676002)(44832011)(83380400001)(36756003)(86362001)(38100700002)(38350700002)(316002)(6916009)(41300700001)(26005)(6512007)(6506007)(6486002)(186003)(52116002)(1076003)(6666004)(478600001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QYDlmfgJasiJtIDMtg6rb8kwzzsk+xMDPf7H66bzpysAjLkmfr/NIuvI1Bfq?=
 =?us-ascii?Q?L7hBQnrlVhARmpLyT2+rCa5SmoOAsD7U9LFJUh91Inp/q0pVtWQ193jDlBQ2?=
 =?us-ascii?Q?bc89W+NgHXh4zRrEadQNJAEIKOesWUcyXKrE0A0wD46ml5zRKyljQa+ep72b?=
 =?us-ascii?Q?b2TG6DCQDmWOFkGeLXYKeFgumYtrYJVeZIInlZYd/vlQZPeyYR6+h6pbfTg3?=
 =?us-ascii?Q?UN66EKoL7z2Hz/N/H+Xnsta+J/8B0CyHkfAVZzkc5WnL7Nhfw2bN7vk7daLW?=
 =?us-ascii?Q?sFlAuyaOavcva8KE0Al7iAurAnD9qykuo8Usr7alxQ5n5YKgNXodYpLk2PKt?=
 =?us-ascii?Q?dYZk28DbQIGp8oNgqdpIkpKYR8UwVEYYpwi7lqxVhfxHkUevjKzQtPcBFdga?=
 =?us-ascii?Q?zH0mrdkbi6NxMK+ZjWG/cVdclBL3TRcouipfhMJkr9gYeWjXADFpxK/6+57z?=
 =?us-ascii?Q?67WTONdhwZUMkVpMz0h4+fBc1EHZgYDq/8gcL/iXocPUvVxNdJWCzgMEQdFw?=
 =?us-ascii?Q?U3qhto7emS3Kadt+cQKPZeJXKWJCD4mwrZ+SWjWhRuJV1hpDaJC0bs+TCRqZ?=
 =?us-ascii?Q?sb1zHE1HJ/yhvafhsb89X2+eZZEylYMq4aB8leXRdBRwJkS5Fnm/L1JUKwiH?=
 =?us-ascii?Q?ukrjrMGeA2zejI8bwx7bLIL9J884VI4+F1/3JUva7XSu+ZHJ/Ez9wobvJk+I?=
 =?us-ascii?Q?6tYPUa0IZCG2V0H0ZjqexBc62KgeNpvSeLNXwIupht/z7PXPmZsn38a1Mq56?=
 =?us-ascii?Q?ZiDtPlhvXmqb3WFOEWCuPf3TzDaXPlhxiVEYPrM3IVIfCN+D4/RjfNDX7Tpv?=
 =?us-ascii?Q?W1woyOG5eqM1b35+bSGUyj4SvwIR/A+B8DzCwgnB6G6mRjBZZJ8TI6WaHLqA?=
 =?us-ascii?Q?+ipxu46pAi58Svgmn2Rs49ZLlz2FfPv7WyL3Gk+DMbZ0nfEJ5I1MmpRhJhnV?=
 =?us-ascii?Q?69MC3jKgmTte2P7oqDlmKzKt7ch/x+Nu2J00QwWA8N/3KomS2+6sXRtH/dZW?=
 =?us-ascii?Q?j7bjx3QKyVRGcTigrS2WcyX8iNbTlsDvRKrdcO6jlr7fSECHx1rs8Zz55hHi?=
 =?us-ascii?Q?7CrnCyEafnxtMil63sT5XE0cA6jioOcaT7mgrNOyhsRv0t452IbxLiEMrRUc?=
 =?us-ascii?Q?xK+iRCLR7jBkZXHaI17Qvv59r5SX+krBvNhag7bEBMFNkB4to+F/CbNCPK1G?=
 =?us-ascii?Q?bj9/lRhNiKxM5pQMaJu6XJxEBWrhOzGP62Xs9bI6F0nbjNps2sld6cW7fAkf?=
 =?us-ascii?Q?5/r2h4n8zEPor9v9Wg3h7Ti/1MtcB6tlV/mVyEtoz85oKJzQhl306cTaHpeo?=
 =?us-ascii?Q?hoqv3pyfss/iKsWv3X8mt8qgbwNCChsmumIUzbEnh+vZmxmJUDEosqUON2eB?=
 =?us-ascii?Q?LPXbX/OGEMYn4EmZF8ORG4EceNrP7JSwGmQNUmIs+1dXhUfXHuWApTuFiXkj?=
 =?us-ascii?Q?QBofrgHGINdd0CTC38l26VSM1IGfzFU7Rt7qcGYbwyhOJ/CDEOMoWl12C/De?=
 =?us-ascii?Q?WH8YtVO7g5vYY8j9O3S71NeNtANFpOeJjrxHaNIb8Khe5jhsDM3LSPQzM33e?=
 =?us-ascii?Q?mNoLoecoDzLZnO5nyu+Re5ovrP2HfDUkLQaqgLz847vsJQaRlnkyohOdhkhd?=
 =?us-ascii?Q?Fg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 e6beb998-6841-414f-e120-08da6b5c04f8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6030.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 21:00:19.5303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 9SVOdmdbg5cz83bK376NFc1WByWyXGEzFYkmZyRht37FSw8Mqa1cnxYYm+eJkBK0190WI9RW2oybo3n84n3R1pu8jbhaX8p2XVVd9WchaSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5963
X-Proofpoint-GUID: TDcacxkReJzoRL0NgM51b2Ln2ToAjeno
X-Proofpoint-ORIG-GUID: TDcacxkReJzoRL0NgM51b2Ln2ToAjeno
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_28,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 mlxscore=0 clxscore=1015
 spamscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207210085
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 21 Jul 2022 21:00:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13835

Prevent the scheduler from starting new tasks if the current cpu or io
pressure is above a certain threshold and there is at least one active
task. This threshold can be specified through the
"BB_PRESSURE_MAX_{CPU|IO}" variables in conf/local.conf.

The threshold represents the difference in "total" pressure from the
previous second. The pressure data is discussed in this oe-core commit:
   061931520b buildstats.py: enable collection of /proc/pressure data
where one can see that the average and "total" values are available.
From tests, it was seen that while using the averaged data was somewhat
useful, the latency in regulating builds was too high. By taking the
difference between the current pressure and the pressure seen in the
previous second, better regulation occurs. Using a shorter time period
is appealing but due to fluctations in pressure, comparing the current
pressure to 1 second ago achieves a reasonable compromise. One can look
at the buildstats logs, that usually sample once per second, to decide a
sensible threshold.

If the thresholds aren't specified, pressure is not monitored and hence
there is no impact on build times. Arbitary lower limit of 1.0 results
in a fatal error to avoid extremely long builds. If the limits are higher
than 1,000,000, then warnings are issued to inform users that the specified
limit is very high and unlikely to result in any regulation.

The current bitbake scheduling algorithm requires that at least one
task be active. This means that if high pressure is seen, then new tasks
will not be started and pressure will be checked only for as long as at
least one task is active. When there are no active tasks, an additional task
will be started and pressure checking resumed. This behaviour means that
if an external source is causing the pressure to exceed the threshold,
bitbake will continue to make some progress towards the requested target.
This violates the intent of limiting pressure but, given the current
scheduling algorithm as described above, there seems to be no other option.
In the case where only one bitbake build is running, the implications of
the scheduler requirement will likely result in pressure being higher
than the threshold. More work would be required to ensure that
the pressure threshold is never exceeded, for example by adding pressure
monitoring to make and ninja.

Signed-off-by: Aryaman Gupta <aryaman.gupta@windriver.com>
Signed-off-by: Randy Macleod <randy.macleod@windriver.com>
---
* Changes in V4:
- Improve throttling by considering the difference in total pressure
  over the last one second rather than avg10 pressure.

 bitbake/lib/bb/runqueue.py | 65 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 1e47fe70ef..359b503297 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -24,6 +24,7 @@ import pickle
 from multiprocessing import Process
 import shlex
 import pprint
+import time
 
 bblogger = logging.getLogger("BitBake")
 logger = logging.getLogger("BitBake.RunQueue")
@@ -159,6 +160,46 @@ class RunQueueScheduler(object):
                 self.buildable.append(tid)
 
         self.rev_prio_map = None
+        self.is_pressure_usable()
+
+    def is_pressure_usable(self):
+        """
+        If monitoring pressure, return True if pressure files can be open and read. For example
+        openSUSE /proc/pressure/* files have readable file permissions but when read the error EOPNOTSUPP (Operation not supported)
+        is returned.
+        """
+        if self.rq.max_cpu_pressure or self.rq.max_io_pressure:
+            try:
+                with open("/proc/pressure/cpu") as cpu_pressure_fds, open("/proc/pressure/io") as io_pressure_fds:
+                    self.prev_cpu_pressure = cpu_pressure_fds.readline().split()[4].split("=")[1]
+                    self.prev_io_pressure = io_pressure_fds.readline().split()[4].split("=")[1]
+                    self.prev_pressure_time = time.time()
+                self.check_pressure = True
+            except:
+                bb.warn("The /proc/pressure files can't be read. Continuing build without monitoring pressure")
+                self.check_pressure = False
+        else:
+            self.check_pressure = False
+
+    def exceeds_max_pressure(self):
+        """
+        Monitor the difference in total pressure at least once per second, if
+        BB_PRESSURE_MAX_{CPU|IO} are set, return True if above threshold.
+        """
+        if self.check_pressure:
+            with open("/proc/pressure/cpu") as cpu_pressure_fds, open("/proc/pressure/io") as io_pressure_fds:
+                # extract "total" from /proc/pressure/{cpu|io}
+                curr_cpu_pressure = cpu_pressure_fds.readline().split()[4].split("=")[1]
+                curr_io_pressure = io_pressure_fds.readline().split()[4].split("=")[1]
+                exceeds_cpu_pressure =  self.rq.max_cpu_pressure and (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) > self.rq.max_cpu_pressure
+                exceeds_io_pressure =  self.rq.max_io_pressure and (float(curr_io_pressure) - float(self.prev_io_pressure)) > self.rq.max_io_pressure
+                now = time.time()
+                if now - self.prev_pressure_time > 1.0:
+                    self.prev_cpu_pressure = curr_cpu_pressure
+                    self.prev_io_pressure = curr_io_pressure
+                    self.prev_pressure_time = now
+            return (exceeds_cpu_pressure or exceeds_io_pressure)
+        return False
 
     def next_buildable_task(self):
         """
@@ -172,6 +213,12 @@ class RunQueueScheduler(object):
         if not buildable:
             return None
 
+        # Bitbake requires that at least one task be active. Only check for pressure if
+        # this is the case, otherwise the pressure limitation could result in no tasks
+        # being active and no new tasks started thereby, at times, breaking the scheduler.
+        if self.rq.stats.active and self.exceeds_max_pressure():
+            return None
+
         # Filter out tasks that have a max number of threads that have been exceeded
         skip_buildable = {}
         for running in self.rq.runq_running.difference(self.rq.runq_complete):
@@ -1699,6 +1746,8 @@ class RunQueueExecute:
 
         self.number_tasks = int(self.cfgData.getVar("BB_NUMBER_THREADS") or 1)
         self.scheduler = self.cfgData.getVar("BB_SCHEDULER") or "speed"
+        self.max_cpu_pressure = self.cfgData.getVar("BB_PRESSURE_MAX_CPU")
+        self.max_io_pressure = self.cfgData.getVar("BB_PRESSURE_MAX_IO")
 
         self.sq_buildable = set()
         self.sq_running = set()
@@ -1733,6 +1782,22 @@ class RunQueueExecute:
         if self.number_tasks <= 0:
              bb.fatal("Invalid BB_NUMBER_THREADS %s" % self.number_tasks)
 
+        lower_limit = 1.0
+        upper_limit = 1000000.0
+        if self.max_cpu_pressure:
+            self.max_cpu_pressure = float(self.max_cpu_pressure)
+            if self.max_cpu_pressure < lower_limit:
+                bb.fatal("Invalid BB_PRESSURE_MAX_CPU %s, minimum value is %s." % (self.max_cpu_pressure, lower_limit))
+            if self.max_cpu_pressure > upper_limit:
+                bb.warn("Your build will be largely unregulated since BB_PRESSURE_MAX_CPU is set to %s. It is very unlikely that such high pressure will be experienced." % (self.max_cpu_pressure))
+
+        if self.max_io_pressure:
+            self.max_io_pressure = float(self.max_io_pressure)
+            if self.max_io_pressure < lower_limit:
+                bb.fatal("Invalid BB_PRESSURE_MAX_IO %s, minimum value is %s." % (self.max_io_pressure, lower_limit))
+            if self.max_io_pressure > upper_limit:
+                bb.warn("Your build will be largely unregulated since BB_PRESSURE_MAX_IO is set to %s. It is very unlikely that such high pressure will be experienced." % (self.max_io_pressure))
+
         # List of setscene tasks which we've covered
         self.scenequeue_covered = set()
         # List of tasks which are covered (including setscene ones)
-- 
2.35.3


