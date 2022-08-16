Return-Path: <aryaman.gupta@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22348C25B0E
	for <webhook@archiver.kernel.org>; Tue, 16 Aug 2022 19:14:10 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web12.19848.1660677241464313950
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Aug 2022 12:14:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=sxO4O9Vw;
 spf=permerror,
 err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}:
 invalid domain name (domain: windriver.com, ip: 205.220.178.238,
 mailfrom: prvs=522748b83a=aryaman.gupta@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id
 27GIf2jE022680
	for <bitbake-devel@lists.openembedded.org>; Tue, 16 Aug 2022 19:14:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=QTnx+mPvy2Tv5aOYJ//ral0MjJ9OMwMcBtql8RxfK54=;
 b=sxO4O9Vww2JFT8zxJxnNWlEHxsqTwgmumBCVzBdSoANGxpggJBEIDhUsL+Xdl1M4pqwJ
 lUT6l6CmktdnFb10ZwnhyjN85qLyvLaKRA2aFt6FfQZ6aVUE4yCJvUnryYud/441hPtb
 +hjyym+miAnJKgoPYXovqzg9yKmbkYCZNsAoUiEJdu7gA30tjDzfMmXXy3hiLLGaO4C6
 2psfz11oyMMP2B2q4YccZdzq9qcW2Qw1gMb4GWwK5n5GmefrX9vidWXBqCOAQlVlIAeh
 k+F6IHwXjPdqhKPSPGyKDxFDR22iafwfQ/L5Jp9wIN4qGO93IXje6WAG0l9Lac+GcxFH TQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3hx2x8jtx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 16 Aug 2022 19:14:00 +0000
Received: from m0250812.ppops.net (m0250812.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27GJAqlY032229
	for <bitbake-devel@lists.openembedded.org>; Tue, 16 Aug 2022 19:13:59 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3hx2x8jtx0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Aug 2022 19:13:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GnJDPFB1ZGrffTZG1W60rO0MeCC3pGh+kKLOPfYKYHPoiDEPfB2MevSYKUM0iihSA4GDBL5knDzM7hRf+XcWipUeoMLL0ixrlF1IrApCXFHoyXtzRORjeULfz2DtUZKpA5CTk4Mot3hY/1HfwEYbXfoD6I0tf65So+uYnxdyMCqVi6/W2HGRxotmSWpvMbPkLNUJRZE7g9fLsq/O/uR+pOCQtIa5KWoN1hgzJs0bW3O6FwK3L8uO4nFJeKJcO2OeXdNju82dDLN7Pmu7+FNR0NQh+HbjM41HENAWHnXQQn9eSU9ruysZr/W0PzZratDEHZml7MBexSsLVc03jB9HXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTnx+mPvy2Tv5aOYJ//ral0MjJ9OMwMcBtql8RxfK54=;
 b=U4+EDz0jXLKuArqOMQt1JeM4KLBPNOkllyOgYAie/Vag2XdcPBRcGSSylSqTSrepSN/DviipO90dvaSRqRtCLqEvgwt8622HJ9vbNGKvvF6mhETa4WFPpxqElNIrCcZEofIGEDmIoc6yd27chTi5QQFshteAaGsHHTDcLJaef/g3L2OLEBbPIcPXfTsVk6/fjVJFqoihyT7a2SmfMAV2UQzCwfyJ24zTMIS5UPUk1gxgMWiqKpa7Hv6Z5EL5/wLG+Fk9F4RL1ut3neeZa6vRJzeOA6Qc8yoEruAt0gp2Hty9Mv4DUc4oww0idCELwlLiPk7r7jML8IruCwLC2952Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH7PR11MB6030.namprd11.prod.outlook.com (2603:10b6:510:1d1::19)
 by BYAPR11MB2614.namprd11.prod.outlook.com (2603:10b6:a02:cc::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Tue, 16 Aug
 2022 19:13:55 +0000
Received: from PH7PR11MB6030.namprd11.prod.outlook.com
 ([fe80::300a:e5c7:e79b:9a36]) by PH7PR11MB6030.namprd11.prod.outlook.com
 ([fe80::300a:e5c7:e79b:9a36%9]) with mapi id 15.20.5504.028; Tue, 16 Aug 2022
 19:13:55 +0000
From: Aryaman Gupta <aryaman.gupta@windriver.com>
To: bitbake-devel@lists.openembedded.org
Cc: steve@sakoman.com
Subject: [PATCH dunfell 1/2] bitbake: runqueue: add cpu/io pressure regulation
Date: Tue, 16 Aug 2022 15:13:43 -0400
Message-Id: <20220816191344.509172-1-aryaman.gupta@windriver.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQXPR0101CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::45) To PH7PR11MB6030.namprd11.prod.outlook.com
 (2603:10b6:510:1d1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d32932c-40e6-486b-707a-08da7fbb768d
X-MS-TrafficTypeDiagnostic: BYAPR11MB2614:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	7L30ECzznHR+aG32pu/1XpK0VbVm5vca73OdMr0uCnxgsS4t3SkO0W0C/UncgxUXQORRmfyOd/fAPL78iZPQtAJ6p4vbInWtKJj5EgChu4Jt9LEetJBE0eIfNs07k3U63epJF4h8BqJCkCGVDwL/BKZgWQFzl8hftaddSuaTPwe7/w3CgolMtox1aW6LvFZFWvI8NHo/dUzAsgV35AAKwN+iQ8+L/g9ADEPJ+4IJ8BDmLU1aMuw4zV2CifELJ9KkmWbyYhhbl5esUpJKPSKQW+AlfnUoHPVQRavlPUOxU7Oh+ZKZpFkp9nxnypKfI6sp1zsmWNMV0bqmBiwGKxH0px0SjRFT0fHbqrzgORW+cRY0D79RyCAbtdZrQDeWCGlAhdjs1p/CTUQTMT92Ipwvnjn/tOTuirV4knPJYpFZCf5ZqW6xN6OZ3STnH2gmduUVQnDVOx11vGYDBZF2DaQ2tELEfLZPhJwehXIzUrOc9VKa/OOSg40gQZTsxCHkjHp/82EZfrg/RdEzlaC9+p1n819yBUA/iZ0fQQDsuHVLBiF4X6rUY9vUcwBn3GV8OunhclvQuqknFHoiAO6Hlbt/pN7oYKSOGDBABE6jKWGmnKMn8W60pml82VHtZN85SE1EpT+kd3icTbm8J1SMmv2Z5gkpBAWWZudlPoMKNhY82HFZ8V5kHChL34ezhoVnyFnO4e8VNn9Zp41H/XhcLxZCZj9iy0ojlpcvU6m53PzWua8v3HGpYCPGTYE90GbkEZq+hvHuwG0FwEsRi0naFkzsqncjrlRm/J0Cm+fSXD+L2B8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6030.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(366004)(346002)(396003)(39850400004)(52116002)(4326008)(2906002)(26005)(6512007)(44832011)(6916009)(2616005)(38350700002)(6666004)(8936002)(6506007)(41300700001)(86362001)(6486002)(36756003)(478600001)(1076003)(83380400001)(186003)(66476007)(66946007)(8676002)(316002)(66556008)(5660300002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?jkz1qTh8sKC/q0dktPYrXxGn+Ag72aMuUcbHEbMPNlQQV2A6USQ72MnCc/vd?=
 =?us-ascii?Q?2FtULbRcxE+ceEgklOyJOxTnqp6k2jqLSMPdLtox3aMasPCBq/GKcEsm8tVa?=
 =?us-ascii?Q?GGLi9rd6L+oFH+GyLb27LSJ1crpP8M5RaRNNwid++t6dmsz2lIBRmh2Rm7Me?=
 =?us-ascii?Q?YgYk7nbVdI//GCfftl1nh7Rt8mlhLhR3WcNcxOV3gV3ihOOlsxPoo679MJjV?=
 =?us-ascii?Q?ZSuovjh0uGNON9Bfqx2o9BBq51Glze6UZ8cXtzW6aa6XiwD+Im+48R+7B+AM?=
 =?us-ascii?Q?tB3RnmB/r3gYpWm3uMZT2/PKV9J6jKtkipEmNMZswfTn4bEuG96XbaPUDVaz?=
 =?us-ascii?Q?eAltZFvWAlwo97PNdrg1qBBS+UcULFaHqmqtcrmiqhV6+nynPuqBge0m174M?=
 =?us-ascii?Q?3M8eGqtv6d0meHM0AkeW1lzrWrXfS9tA3TW63RgrdF858WNyBN6aCYUUI023?=
 =?us-ascii?Q?H3jBJW5k2yvApmNS6tugAbZDM3eUiWjl9RqoxQdGMoHE9PM1Gz3iz1B6dzzd?=
 =?us-ascii?Q?cTFJ2AAlZkwE6Nygm8mEVXsoqO9gQedavkbcvHLCMN/pcJqRIJ/brYwYJCKZ?=
 =?us-ascii?Q?/nY8hwmp7HdQMZK5ZNEgZ2lRNsyTy0Eu3eIcK9n1w0T58eGlMD0I1k5Iv4KE?=
 =?us-ascii?Q?LZ0asufcx9rdC2CStapS0EbddDJfRruHJBWweG+bXSwIzmhGtuqO5PCRIf/c?=
 =?us-ascii?Q?47v8PuuJZMkkWeUaruqVjEpAgcOcPJ6EtvXNnrB2uBqiivmbpwI3qyURNZpM?=
 =?us-ascii?Q?1U2v9+bnfHSQVW1pXwuWoA+Q3oqtHbmLqVPDzZIK8hlgB0neRTWPazQHPT/Z?=
 =?us-ascii?Q?HY8EjSeYCUU3eEer9Bg7KyShoy+avsdTUaO8bopSwykIkK+zB2s6/Zx87Ibh?=
 =?us-ascii?Q?nOLzQ38MjUL/q/jqL7oamldgB+9j/ZGkrHE8auDRwN4buWvY3iEa9vSGFx/w?=
 =?us-ascii?Q?/4EqZh+DO+UIJZhJttzfQLAUep1wGpLLSoMiv7zcy61K+8KI8ZhgzZoStUJe?=
 =?us-ascii?Q?vRJtQLa666HHHAz4sKJzO6OMLHH67EQmaBjmfI+Ct1LN89cu4HnLBBturuY2?=
 =?us-ascii?Q?GYNgmZujNdFQA69Iflz0wGaompxW8a3L+GpIzT/E68679vVKHsx5gzdqwKIn?=
 =?us-ascii?Q?lCs5qXPaq8OaP0Jz0vqPlwg30pTuKBayJv5n5kd9Xe0hk0lBL0mvkKLA2+Lq?=
 =?us-ascii?Q?vBYfNNYMjwbGJDG10o9gX4Wqt4svQGcDoIhgfpBimA1ncGBNKq6bUcosHpXR?=
 =?us-ascii?Q?P1w+D+qH6bYABHMaNb3UHs57Uyi5eA+Hl9ikZ0Igu7zXOMW+ls7X0IKA2tWe?=
 =?us-ascii?Q?TGrcyNlnQB1iZaXQyJ/i/cxNP+gNWQrAIfyKFsn7qDStoq/f9pdHQ4du9SLk?=
 =?us-ascii?Q?VmOtETkCT0wwWcG/+HGvWHNJ3B1GEmd1wpkeAA//A8h3EnxG5Un8HnjoaiTF?=
 =?us-ascii?Q?rQ5MuBVJ/jQVVMArz3XkH7SozJE9NVZbVqVxuG8Q3TzHERA5MjJ4LGjid3Jx?=
 =?us-ascii?Q?yqEFrqv2zkoCEjK4lp8J33kTMUOFnkXH8e9Mjgma9s0dkjZGVXd0YKCJcClv?=
 =?us-ascii?Q?jrE4IRm9yT3rSz6bFX8NapknmpMtlNR+vhY9Seknas4WCoKtdLwSt77AI344?=
 =?us-ascii?Q?Bw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 6d32932c-40e6-486b-707a-08da7fbb768d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6030.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 19:13:55.2657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 uAnI51UoRcLR4aubkkcIiAjFTro2PVcjp8US5qk/bWEdOg4ohbQvg+y2nIpu9AzWbzMZk4Jf2d8Jwydjt42W3Wcq/ZtfRdYgB1M/JAyF2Ac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2614
X-Proofpoint-ORIG-GUID: 0vCy0Sw3ZdGjAihE42BcQ9kGaIksUyGc
X-Proofpoint-GUID: kwGGQcJpfz1AfvcT1yyg4HLXG630S5W6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-16_08,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2208160071
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Aug 2022 19:14:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13899

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

(Bitbake rev: 502e05cbe67fb7a0e804dcc2cc0764a2e05c014f)

Signed-off-by: Aryaman Gupta <aryaman.gupta@windriver.com>
Signed-off-by: Randy Macleod <randy.macleod@windriver.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bitbake/lib/bb/runqueue.py | 65 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index a513b0983b..9aa99ef4a1 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -24,6 +24,7 @@ import pickle
 from multiprocessing import Process
 import shlex
 import pprint
+import time
 
 bblogger = logging.getLogger("BitBake")
 logger = logging.getLogger("BitBake.RunQueue")
@@ -142,6 +143,46 @@ class RunQueueScheduler(object):
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
@@ -155,6 +196,12 @@ class RunQueueScheduler(object):
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
@@ -1700,6 +1747,8 @@ class RunQueueExecute:
 
         self.number_tasks = int(self.cfgData.getVar("BB_NUMBER_THREADS") or 1)
         self.scheduler = self.cfgData.getVar("BB_SCHEDULER") or "speed"
+        self.max_cpu_pressure = self.cfgData.getVar("BB_PRESSURE_MAX_CPU")
+        self.max_io_pressure = self.cfgData.getVar("BB_PRESSURE_MAX_IO")
 
         self.sq_buildable = set()
         self.sq_running = set()
@@ -1735,6 +1784,22 @@ class RunQueueExecute:
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


