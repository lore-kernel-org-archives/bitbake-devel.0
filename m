Return-Path: <aryaman.gupta@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED95C19F2A
	for <webhook@archiver.kernel.org>; Thu,  4 Aug 2022 18:52:56 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web12.8846.1659639175008177337
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Aug 2022 11:52:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=Y0ONjyYK;
 spf=permerror,
 err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}:
 invalid domain name (domain: windriver.com, ip: 205.220.166.238,
 mailfrom: prvs=5215122cb3=aryaman.gupta@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id
 274FcC7f019911
	for <bitbake-devel@lists.openembedded.org>; Thu, 4 Aug 2022 11:52:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=from : to :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=KOui9y2qXZLjvypOQ5xwLWn+S1zWSjpTqgN9MB+TwNw=;
 b=Y0ONjyYK4870Ba1eBAKmpP7bgp8I+D79FSjn9LLRNAnFyCZiiIYWkm9M68VxbG7rZSxl
 qYJmosuSBBuuu9vwM4TF3s9EX6PevjHsEmVIU6NTpxFHPn84pt1nJCVLZMm1wMdIf+rG
 sV/tv4kHdUhNzo9/a50njWMYA+9JSzDtEvR9moe/C/z+F/VXTbpyBuPchz43fROf980x
 gV6DGY9+RxlGZxEsFioYPCaBvV60EiVG0ns86vF/NgtdthS5TIQYxkcy0UnKUe/y4vlR
 gu3aA4lWHZkgzYiHus8X2WLNFgBQ6P+njGy6VbzjbYh7FIPG7Eo0rMcsCc4deKkA9m/c Jw==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3hr3xprqd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 04 Aug 2022 11:52:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6pkYagJQVQtOnezSKgTQDXisUF65Eb5LmWF3GSeD0QPIufUmPvBs1zkaUpiibWonprGJNs8ZuI402DCdlcoKGDs/xu6lh8RQMJGO1TvJXG9pPEWdQFbHnHzaFzb8dcXfmeJK8M3CyumRBwRSJ7pj6/eEvV4eDFDrdhtHZ6NnuX5lFbL2CO9upItC8NC9XhDwMc5294gUoE1vbCRbVTAoBR6MwtYZg7FXlHBjwa1ErXQHhkzPjod2TuL9R3SS5PLeihZ1/RZMZ09MyX47saZ9IhBj8kiN5N+UUTOYpGKR5e9PF2gZbKMBYI3bFrC0pocnPvz/aq167CwrNLgv0WEIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOui9y2qXZLjvypOQ5xwLWn+S1zWSjpTqgN9MB+TwNw=;
 b=YgdbpMHPT7jzzi3XmgUBLrG/OChQ7sXocVi7Wy+UoDxLOvZD/G27uaDviaqbeWGQE02WWgZMPkXNINBZ9ZrCM3mg8tFy+fEycVh+Fl0cT0vvAwsDcJxYZwO5MKI+GFup+0wcAZYhLRNIw8AqQ10XLy4IkrMsdTHYNCBFJDlFAWJPgFAOOSwbD5QG88FHqgOyMUWYK2YStWuapFIYSAU0knOkgxHCRjEVm/iFXgRMG/UtnGYLv0auD1WjwGEX5UzzIi0HInWoNzuwEeW6ROhFHIWtzlahzrH2SxzjMbVlr0DNCl+pWiaoIjIOqyIVuob+B4DTgaUd/7yhDzKogFWZIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH7PR11MB6030.namprd11.prod.outlook.com (2603:10b6:510:1d1::19)
 by BN6PR1101MB2148.namprd11.prod.outlook.com (2603:10b6:405:52::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15; Thu, 4 Aug
 2022 18:52:50 +0000
Received: from PH7PR11MB6030.namprd11.prod.outlook.com
 ([fe80::300a:e5c7:e79b:9a36]) by PH7PR11MB6030.namprd11.prod.outlook.com
 ([fe80::300a:e5c7:e79b:9a36%9]) with mapi id 15.20.5504.015; Thu, 4 Aug 2022
 18:52:49 +0000
From: Aryaman Gupta <aryaman.gupta@windriver.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] runqueue: add memory pressure regulation
Date: Thu,  4 Aug 2022 14:52:32 -0400
Message-Id: <20220804185232.189540-1-aryaman.gupta@windriver.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0273.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::22) To PH7PR11MB6030.namprd11.prod.outlook.com
 (2603:10b6:510:1d1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f995266-a714-4417-7b8e-08da764a873c
X-MS-TrafficTypeDiagnostic: BN6PR1101MB2148:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	cbs372wkYNTou+cucVzxotW/96yOD3ioF+HUSvcZWZuKdST9IHRemcoOK8O7WtqpZDTn/2hUSyp+IpgSmQopYjA2LtOiktyVsv1Euh9oDT4iGSCCclX/4nz9jFKidC15vJFyORL4tYWSRlRk2ij+9sW62rfi1DZ1San4w+d8u9xqmV/XWgEqB33NfCsHml3792JIf/fp4gmUP3XtVnWt0wvVmkAKBtgrC4ZJMqTVGEfaUO5nhizw8fSqYHsrgR9PJPnpNU5h57ZkNzBcY5rEpwcNCnFXCgsPBVuyAqfRo5jztVUIO94djTbpuLwsPWX3PH9PWDttriRpmifUu44y3jIcpaGWfcHX3gVqEkmop6d6DBExJFMm/2t6hgUaJ8pvUbwDFC1190JqiwKtD13D1uo9Fk6zBmHNZnyDFkMf6rF5lYKmgHRzVxwwR3nPkOT68oTYrmk1kTHadt6pk37eDTVVhmEyrlsu32NTAI/e9KXdoCdA51LYg1sWQdzbbq7RcSwk36QcijwF+YcqBWsFi8RRaxNi2pLQYGqLpKlencFEK7RD3F6ONbJjhPHp+JzEj/cYQ4FYrlOaLyGyKY/NGCwusslo7LUMk4xwHim2gATURwM1xep4vF8ieGu9+N3t9nm9KjPoAvySH538U7uBshLZN4GJIAQG2ubHCgHbd1IKNzJWYl/Vwr/kGthmrJzEZ/A1SaI646Q1tA9EtFTc2zrK+IOVUkE7f5ytx4/jQNC7Jpn1buUh5/Ivep8uBvvJYKrgAlOf1DPeNcJSWaKgnOJb3qzbIpLQ+AxazLjqO54=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6030.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(396003)(346002)(39850400004)(376002)(6506007)(5660300002)(26005)(6512007)(41300700001)(38350700002)(52116002)(38100700002)(36756003)(186003)(6486002)(1076003)(44832011)(316002)(478600001)(83380400001)(66946007)(6916009)(8676002)(2616005)(66476007)(66556008)(86362001)(8936002)(6666004)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?BD59MKikM9Q34SQMjC479DgTYdukbLT00QjHCtNZhcRumqEieSh0R2AVmJMC?=
 =?us-ascii?Q?9kFhbWV7w90b5paUn//pZ1qvwDs6nqbeYuqjWzTkBqvNlng3xkZy8pBN3x+T?=
 =?us-ascii?Q?fUxynabjJ/6S3ykBKj6RRLQNYilh0p+JV2Wbxw4KkjCwOmXx85CIU34HKuLu?=
 =?us-ascii?Q?/YS+ymzHZYaIegmLvJm5qhasWQBNpaxHtzpTAkAmq6QzsC8jBPDW1NUfSsXD?=
 =?us-ascii?Q?KKuqGAykxEeVcLihOL6doUh/Y2tc5U2EqFbmqqzBnjPGWp05X/B+ckEu2RAu?=
 =?us-ascii?Q?yj+Y9+AdRZSY023jeK1gcCOTe52V65ugDdrxkohh8NBGtM2+fMV1biZf6xOI?=
 =?us-ascii?Q?1CSYcUJ7vrouBoMWKlEcK65iVPFgE6gkoX09R8wq4rakZRN/2VTpwqwhjhsB?=
 =?us-ascii?Q?pqaq9sXPKgd5schw/ZK2sp/4D3War7l9XcM0HRvt3aPoLe8MR4J2qMw+h6mG?=
 =?us-ascii?Q?srr8yjpHohl7YN4aTMK5zxOSKd+EbskRfCQX4DbWLHS/Le5AnXRYd8ATA1z8?=
 =?us-ascii?Q?vdYnHlkepptKUAEilHByVRXflaaBo8fXH8xTWmG/aFdH1KnpSdUJKNs2+jI3?=
 =?us-ascii?Q?shnBzmvulwIVMmdtL5hJTSqSn1GN4sBHdgFGEI66PiEZvrmOqU6HP6frcI2o?=
 =?us-ascii?Q?hgiy0wc/xVqAjoWFej5Ijia/XCR+4PQm1HhNhZ1QTp4lDbsZUsRStFKbnPK6?=
 =?us-ascii?Q?eHYjLkC6fpwOo+V64f9O7ejfd9mWUsJH3ZKeHGcnt4aCKqaqNQVC1EXK74VG?=
 =?us-ascii?Q?7IuPuTcPOyRq63JHMl6lyBMwKGEw5/w3hrejieyyx8fkZJbZ1np4tV8JWmBV?=
 =?us-ascii?Q?OBOyItojLLNIArDTt6BxwUZ4BRzNvdvOpY+vE74Pd5hYZvrOrWyK6X+h8aVI?=
 =?us-ascii?Q?qhnjS5/PaXwNh+7SdQaQRAWRlYe7fCeSMFre4n2VSGEEJuqq2EE2b3G+r5OZ?=
 =?us-ascii?Q?hs22qvmRzBkCgYzChDdRVVHhy6SNstALTSgP9nyy385IfqfiCdJtgGNy32hy?=
 =?us-ascii?Q?OMxYOruGFXy9twddu6/QgNwYaXnkZFNybqB19xIzabl3WiVWrXOlcm1m2IgT?=
 =?us-ascii?Q?01LCIyOai+LigGn6rojEzl1RaoewpogmljZRzY8+gH/ePHWy5+yyIC5VG/cp?=
 =?us-ascii?Q?y32VcZYXxx3LPRcwh557h5rrCoMytKz7p8oaO+cQfozJ8ZxUmxnRaeqwfHcD?=
 =?us-ascii?Q?UjeRmfXU3CbMy12M1vU9gdcryZyQ4KEioCvtspgEIOLI1eUNAAsDcy4V/v+j?=
 =?us-ascii?Q?HYMc0COxgDIig/2ZNISRpzdG8OMn0aGQmilICyCxpAvNdDhRLLAz3ek7h3ba?=
 =?us-ascii?Q?TiZ1DW/l27zvSUz4Xs1CZAK3eCWbST1ArDWKuFotnLkTtpzIUclY4uXck8Ko?=
 =?us-ascii?Q?JAetVR8MG12KApqT6O5XB+val1mMB2o2nOOClR6trjyNyH4gRJbkHbNixDdo?=
 =?us-ascii?Q?5820ct/6y0B3jfzEHF2jPBtkKcuJPJlcOFdIsy5r/eHAfFkz3dI2pf+XAKJ0?=
 =?us-ascii?Q?UHmr/xXdkVlrNrFJI80PKWSGeQfpcw+Cd1QlTjHMAFjjR3CtQtENr5zhyb0s?=
 =?us-ascii?Q?rPlzEIvwLhX2YCGKfzXpkOEz+oJbO5tL4UDoA1UeCqB4vQBH4b43yMlhFiyg?=
 =?us-ascii?Q?2g=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 3f995266-a714-4417-7b8e-08da764a873c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6030.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 18:52:49.6297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 Q3L0PCI78rXhbN4efjxgWFQYysr0//DXcPOcCpU8kwkjUAFRT0N8YDm5pDWonrOZvHL7mvjXqxana8YD4mS3fJaDvNG6PXglbnouxHAvt/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2148
X-Proofpoint-ORIG-GUID: SR-gCn07dVgA8J0X9iuQFh6Y3JN7VHZ5
X-Proofpoint-GUID: SR-gCn07dVgA8J0X9iuQFh6Y3JN7VHZ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-04_03,2022-08-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208040082
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 04 Aug 2022 18:52:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13870

Prevent new tasks from being scheduled if the memory pressure is above
a certain threshold, specified through the "BB_MAX_PRESSURE_MEMORY"
variable in the conf/local.conf file. This is an extension to the
following commit and hence regulates pressure in the same way:
   48a6d84de1 bitbake: runqueue: add cpu/io pressure regulation

Memory pressure is experienced when time is spent swapping, refaulting
pages from the page cache or performing direct reclaim. This is why
memory pressure is rarely seen but might be useful as a last resort to
prevent OOM errors.

Signed-off-by: Aryaman Gupta <aryaman.gupta@windriver.com>
Signed-off-by: Randy Macleod <Randy.Macleod@windriver.com>
---
 bitbake/lib/bb/runqueue.py | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 359b503297..c853740afa 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -168,11 +168,15 @@ class RunQueueScheduler(object):
         openSUSE /proc/pressure/* files have readable file permissions but when read the error EOPNOTSUPP (Operation not supported)
         is returned.
         """
-        if self.rq.max_cpu_pressure or self.rq.max_io_pressure:
+        if self.rq.max_cpu_pressure or self.rq.max_io_pressure or self.rq.max_memory_pressure:
             try:
-                with open("/proc/pressure/cpu") as cpu_pressure_fds, open("/proc/pressure/io") as io_pressure_fds:
+                with open("/proc/pressure/cpu") as cpu_pressure_fds, \
+                    open("/proc/pressure/io") as io_pressure_fds, \
+                    open("/proc/pressure/memory") as memory_pressure_fds:
+
                     self.prev_cpu_pressure = cpu_pressure_fds.readline().split()[4].split("=")[1]
                     self.prev_io_pressure = io_pressure_fds.readline().split()[4].split("=")[1]
+                    self.prev_memory_pressure = memory_pressure_fds.readline().split()[4].split("=")[1]
                     self.prev_pressure_time = time.time()
                 self.check_pressure = True
             except:
@@ -184,21 +188,26 @@ class RunQueueScheduler(object):
     def exceeds_max_pressure(self):
         """
         Monitor the difference in total pressure at least once per second, if
-        BB_PRESSURE_MAX_{CPU|IO} are set, return True if above threshold.
+        BB_PRESSURE_MAX_{CPU|IO|MEMORY} are set, return True if above threshold.
         """
         if self.check_pressure:
-            with open("/proc/pressure/cpu") as cpu_pressure_fds, open("/proc/pressure/io") as io_pressure_fds:
+            with open("/proc/pressure/cpu") as cpu_pressure_fds, \
+                open("/proc/pressure/io") as io_pressure_fds, \
+                open("/proc/pressure/memory") as memory_pressure_fds:
                 # extract "total" from /proc/pressure/{cpu|io}
                 curr_cpu_pressure = cpu_pressure_fds.readline().split()[4].split("=")[1]
                 curr_io_pressure = io_pressure_fds.readline().split()[4].split("=")[1]
+                curr_memory_pressure = memory_pressure_fds.readline().split()[4].split("=")[1]
                 exceeds_cpu_pressure =  self.rq.max_cpu_pressure and (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) > self.rq.max_cpu_pressure
                 exceeds_io_pressure =  self.rq.max_io_pressure and (float(curr_io_pressure) - float(self.prev_io_pressure)) > self.rq.max_io_pressure
+                exceeds_memory_pressure = self.rq.max_memory_pressure and (float(curr_memory_pressure) - float(self.prev_memory_pressure)) > self.rq.max_memory_pressure
                 now = time.time()
                 if now - self.prev_pressure_time > 1.0:
                     self.prev_cpu_pressure = curr_cpu_pressure
                     self.prev_io_pressure = curr_io_pressure
+                    self.prev_memory_pressure = curr_memory_pressure
                     self.prev_pressure_time = now
-            return (exceeds_cpu_pressure or exceeds_io_pressure)
+            return (exceeds_cpu_pressure or exceeds_io_pressure or exceeds_memory_pressure)
         return False
 
     def next_buildable_task(self):
@@ -1748,6 +1757,7 @@ class RunQueueExecute:
         self.scheduler = self.cfgData.getVar("BB_SCHEDULER") or "speed"
         self.max_cpu_pressure = self.cfgData.getVar("BB_PRESSURE_MAX_CPU")
         self.max_io_pressure = self.cfgData.getVar("BB_PRESSURE_MAX_IO")
+        self.max_memory_pressure = self.cfgData.getVar("BB_PRESSURE_MAX_MEMORY")
 
         self.sq_buildable = set()
         self.sq_running = set()
@@ -1798,6 +1808,13 @@ class RunQueueExecute:
             if self.max_io_pressure > upper_limit:
                 bb.warn("Your build will be largely unregulated since BB_PRESSURE_MAX_IO is set to %s. It is very unlikely that such high pressure will be experienced." % (self.max_io_pressure))
 
+        if self.max_memory_pressure:
+            self.max_memory_pressure = float(self.max_memory_pressure)
+            if self.max_memory_pressure < lower_limit:
+                bb.fatal("Invalid BB_PRESSURE_MAX_MEMORY %s, minimum value is %s." % (self.max_memory_pressure, lower_limit))
+            if self.max_memory_pressure > upper_limit:
+                bb.warn("Your build will be largely unregulated since BB_PRESSURE_MAX_MEMORY is set to %s. It is very unlikely that such high pressure will be experienced." % (self.max_io_pressure))
+            
         # List of setscene tasks which we've covered
         self.scenequeue_covered = set()
         # List of tasks which are covered (including setscene ones)
-- 
2.35.3


