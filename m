Return-Path: <aryaman.gupta@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F391C43334
	for <webhook@archiver.kernel.org>; Wed,  6 Jul 2022 20:51:14 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web08.2363.1657140666086152045
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 Jul 2022 13:51:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=i5DlePHH;
 spf=permerror,
 err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}:
 invalid domain name (domain: windriver.com, ip: 205.220.166.238,
 mailfrom: prvs=4186503951=aryaman.gupta@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id
 266JulgX015976
	for <bitbake-devel@lists.openembedded.org>; Wed, 6 Jul 2022 13:51:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=from : to :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=ami8uEO6S/FS7NUOsSG4l5JYDxA9CEnzE/VswjJs9PA=;
 b=i5DlePHHtZE1iMpkvUBBsPE7UGu+znraFvkyWroCrkwQ8WplhIEzqUAeIinWGsIrbVPb
 DbXSp33/kXopdF4rtrtArOk3kkqyhDp2/ZSlinhzfjUgFBDFQriR+wDvS+rk8bEIfA+D
 fARO99wlrMilu1yOZZUEh2nKsiwD/T0iTD7+oiA16ACwWXN5xIfajerCXFXt7ingiRZK
 zketeIwlgLTfu5qrYI3MjURTIUzedj0Q/tI8LbnvgN2sP53ThLqnvt8QnpYBXlyjMsOR
 9VXsFGRdBjv9nSz1jn9BCG5debKab4gY+CiyolNt3Q2V4C1pDQZQQqvofrf76OXb20pw +g==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3h4uf3gwe6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 06 Jul 2022 13:51:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKOJQjyXaQbLHSF7br0qzuQ2sBDE6H54YOob7iqSlKjnk6o/VVtuQ/PZ5VI/WO+Ra++Pn7lFpH3ghU6t4Nwz7eos7+mq7qg40lPK8wDryShZIQ3Y6WHHYcD3iaP+Rzdx8wAta02p6hHwc+DdoKVQZjbHjqdwWC35faAnKvlBZD/Dfu69INhAb+UlZtuF/yA8WRQ+kwiBXq8gmweCk+1WYPz3nY35chuSS8VuDPsyyk41U9rg4kQBhj8p6w3DdiMOAEnFsxFwUI7T4pHKMTQF6pqfglMIlvowNe6JOSDOdYAxkOqRu/uoxfonhIlzoAy0o1gOMgEyQsXWeZZupKSDnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ami8uEO6S/FS7NUOsSG4l5JYDxA9CEnzE/VswjJs9PA=;
 b=Nz+q+LNnL8w2tQZrczTCq2eaVoayNeutLi8GknZEvjtb8oO/JX57gcPpTh2bzsP8WxEks+MfkwnaX6V5jZcMM/BQvmy8zTwEmEW6qNxS1qW2U+DWZ9JL7B6dmB28PWk6rpLt1ua0eGykqgxlqtCQk5VteEMkf29UB+mPOYLwBfSDArZgPx9e1mUyerdRDo/1KqPiPTZ6pOCcHOXlWZeCi96GEc9lsaTedyxPqYqb6D53EMdSGW3a/x8mDHvn3dd0dK1kh9kkzwd6/Z9/04PRG3Z4j6iAzAGJfUpekR5RLFn0Lnq+OvFx3IHqT8pfS2ax7Xs1X/14j+dLntdfPGz/kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH7PR11MB6030.namprd11.prod.outlook.com (2603:10b6:510:1d1::19)
 by DM5PR11MB1817.namprd11.prod.outlook.com (2603:10b6:3:10e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Wed, 6 Jul
 2022 20:51:02 +0000
Received: from PH7PR11MB6030.namprd11.prod.outlook.com
 ([fe80::14a3:342b:5f14:eda6]) by PH7PR11MB6030.namprd11.prod.outlook.com
 ([fe80::14a3:342b:5f14:eda6%7]) with mapi id 15.20.5395.018; Wed, 6 Jul 2022
 20:51:02 +0000
From: Aryaman Gupta <aryaman.gupta@windriver.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v3] runqueue: add cpu/io pressure regulation
Date: Wed,  6 Jul 2022 16:50:48 -0400
Message-Id: <20220706205048.2492443-1-aryaman.gupta@windriver.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0078.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::14) To PH7PR11MB6030.namprd11.prod.outlook.com
 (2603:10b6:510:1d1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 211e1a89-9316-4666-f50b-08da5f913cf9
X-MS-TrafficTypeDiagnostic: DM5PR11MB1817:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	sVSd6lEfoJ1t7dhdrZ7H4xOBTibYBYFMCFu68r3bAsomW8VcpbQjUraNMUpLe6CCi+4BtVcnJGgqtQQLV0nmVOI/CzhzbAoZK+O1mGkezg9smZIQmUqMBgufrARghb0Nzy/VK20neFqBO2VD3sUs5ky7YlgHrisO84V2t6n3CnQwv2LKqi4RwhpwAaGjn8G1Nao+N34UPSgIRf8RITZE4DTpOTq6qfNXnuQzLGKcHatUUki6kAYZDkIUVKF3/9KhBMwnmM4bfEAihPu2YE2YNrRMNoSBMFk98UmAG/2P8Lxf47VFxH7tbBzp3vThD+0kVKumWuwEeegyaBzIWb+TG7kEtpJ2vuL7W/mMW7iiH5bNc2OCeXLgxslBtA8k/OvIEvgaBdtJm8S8S+bLnaX2ORpicxivx8Y/63R2QXTTAKZ9NfT1nAF5l/odWTURVYcyi3ivL6r9JkcsluNUMZ+ZkU/jAMnYTox22XoqagLEh6Z+IesEFNLx0zlj2UiQWlIaoVHsX0RThGOuKaqtNREKICo0+fQdfbcpVwTBQ2qeX71eZdzffjXHW3A1g6RBQDvTUzr+MAUgRRNhjmYeCPLdk9JDHQc/1uyoZkPOB/F/RYBJOY9N+b8Jy2T/5Ugy6bugNoeUxaYsvQrvYl5NgsSyzcdwwWHiL+AgqOdBUbIIWqsRhNWi+0jFr+ntPmY1YIVLn+B8d9BoyMyWnp2PkM9YwIOW4Ecry13jqi2DqMB2qtSrdXt8pYwlyvsXF2tvKrHGocWFLw2mBUtfR99xk1oyNLZad6gn/zys1BF2ek2PLTiDO7MYT8xZ5jmadgEWcVZR
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6030.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39850400004)(376002)(346002)(136003)(396003)(8936002)(38350700002)(8676002)(66556008)(66476007)(38100700002)(66946007)(36756003)(316002)(6916009)(86362001)(1076003)(5660300002)(2616005)(478600001)(52116002)(6486002)(6506007)(6512007)(41300700001)(26005)(44832011)(83380400001)(186003)(2906002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?zPbVyTALPd70T6d0JKw3oBu4iNJuq1KHC9qo7FwdFNp0PvfQ6hVVam3gwBbM?=
 =?us-ascii?Q?GVUdmhigGWt3Gi0zib/2Fsk3uj8cTfYXZSjSGPhi9Y+TUEwPQB76bFkC2+xk?=
 =?us-ascii?Q?6Z5LdCAz8JqHkmo8+03kU7mUQvZiAw9LLoSh5q4CmXixdrp86cUisK2YmatL?=
 =?us-ascii?Q?zpHWypQJMp8lI9m1di/PjV/T8xZ9qbl1NDR7CwYdPO+kuPjjm6ixM/Hlw0wR?=
 =?us-ascii?Q?bXd7Gdx9Ke00cFniYu+rc8L+sosZfUDoHrk3ExMJqFrGCTaZuFqq7KDVVgWj?=
 =?us-ascii?Q?7k7qQrFkt5ReI+x7fP+b45BHfrlDZP3igBkF+s6oqGWIhv1NBGaQnBywzGIT?=
 =?us-ascii?Q?OI3GVQi/RgsCNKHoRAl0ueNp/Eym9HYF8NyMWbKt3XeOl/eZf/kkddShwHAT?=
 =?us-ascii?Q?yU0A12VEu6fvoP485DfqurbKbQC+I4FvqzNMY+R4KX6PDK79KR0dP1WZm6og?=
 =?us-ascii?Q?pP5or1KUSyoGy4a+dkSovAbpiUpyfChqjxcvObc4ImKTElxZ4RTIKyOpINnp?=
 =?us-ascii?Q?hqUAoQjTbo3WIy2ex8DcVGgN6DtZ5C6Cpgxbr+Jk2eRUHo4cpptXfI3NRl8M?=
 =?us-ascii?Q?+W/Eha7tR/lU+X2tocjQD+5/MQuzMXKP5UBrdaqG9DTZuloBPfN6i/SxgsOb?=
 =?us-ascii?Q?C98soxuObvyXrho1EFGf2MON0ln30BfMkWkwW2JifTM8D2653FzA3yAwZxrS?=
 =?us-ascii?Q?hqbCynrdR2jBqJLvFxbEoQ7e3zo9ac4iuj/0zBp/uDRSs0pdjoG30ObiXR7E?=
 =?us-ascii?Q?bKWthPYn5cMLWDybYYr/C61Q68CqQeDLAN+W7efmpocoNfhHPLhIYJSVeJma?=
 =?us-ascii?Q?VUu4TZIdYzUtiVD/vQ6uGpIIikpBxI4TyDH3gvT1DSbTL+xeM5+5o+YmIKMZ?=
 =?us-ascii?Q?bIRjcTiLa+LfPPuMfTHq/i5RlKbfhxg4Klc1R6aooQFQafPoegKH8RDondnv?=
 =?us-ascii?Q?XI4jaONqVGiFNCuIXvvUIFCch/D+M6BKYV+f0gSB7Gt/t8ZhZjMSwY1U+FRM?=
 =?us-ascii?Q?6DzlT4+pBjV6+YbfqkfQoE1oU44givQ+C/BbaeqkpuKss/uGX6ubewwoFWHv?=
 =?us-ascii?Q?dTJ6ampvlL3gCpZqRik0det3sKoMFeJO9nd7uVhF4JL24QauYWv7sCcWY/z8?=
 =?us-ascii?Q?E76/zDNp98R+ru9wiTa8UZkCaNsw5S+zMeegMOlG+PXW04Ki9di45OEgTWI7?=
 =?us-ascii?Q?4SJiuNfvvr9akk3qKuRj4HS9JrphsN/CUgz8vkObeqwfH+a0kvhBo/Y2lELG?=
 =?us-ascii?Q?8QtPElKKf4dagLzM+rsnBp9wvOoe3gOP2yIWSu6zFcR2V1fIw4DNONIAzTSJ?=
 =?us-ascii?Q?M/0lApDseU4Hmkj1W2DEUHW7KjfHIw7FnBKcXYR888XNJf4dP6XABeFblUp4?=
 =?us-ascii?Q?/mmQ/KLZj1W1dqJ+nbwqPfnkjDGjL5f3KQN6ByehxdNn7iJfrZrih9RG98TS?=
 =?us-ascii?Q?enfP+O1SGcezgYo7yW/yokpgMKqY/OLd+nXXx+x6oYDoRxZvt+8QhHgBIYds?=
 =?us-ascii?Q?xqN2vNOO7AWFRiT4QAfoL1SFkmooK6tkz6bhf7aHfHfTUn/BqKLj5x8QUqPd?=
 =?us-ascii?Q?zW9de0QhrxI+DzYC9IMLlSdyKZqsYBebCwzCAWGFuS5SQOMXOq+tT6Qe1zLh?=
 =?us-ascii?Q?kw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 211e1a89-9316-4666-f50b-08da5f913cf9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6030.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 20:51:02.6444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 2HSnWQSX8bJ9AKegzmFB4z9EnAPvIFfpa+WmFeKRo2s3VDPQIlBBdjCwK5aVUjHz4B73Mh+Kbs2nQvEEo4hDk99Z+/jzthFFlfXzD+cYCrU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1817
X-Proofpoint-GUID: YLIqkUFm2P_ptHQWdwnL_BxmiuZtDX8r
X-Proofpoint-ORIG-GUID: YLIqkUFm2P_ptHQWdwnL_BxmiuZtDX8r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-06_12,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207060079
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 Jul 2022 20:51:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13807

Stop the scheduler from starting new tasks if the current cpu or io
pressure is above a certain threshold and there is at least one active
task. This threshold can be specified through the
"BB_PRESSURE_MAX_SOME_{CPU|IO}" variables in conf/local.conf.

If the thresholds aren't specified, pressure is not monitored and hence
there is no impact on build times.
Arbitary lower limit of 1.0 results in a fatal error to avoid extremely
long builds. If the percentage limits are higher than 100, then the
vales are rounded down to 100 and warnings are issued to inform users
that the specified limit is out of bounds.

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
the pressure threshold is never exceeded, for example adding pressure
monitoring to make/ninja.

Signed-off-by: Aryaman Gupta <aryaman.gupta@windriver.com>
Signed-off-by: Randy Macleod <randy.macleod@windriver.com>
---
* Changes in V3:
- Ensure that there is always at least one active task before monitoring
  pressure.
- Fix formatting issues and make code more Pythonic.

* Changes in V2:
- Replace subprocess() calls with open()
- Rename BB variables to BB_PRESSURE_MAX_SOME_{CPU|IO}
- Skip the checking of pressure when no value is provided.

 bitbake/lib/bb/runqueue.py | 48 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 1e47fe70ef..eb3bea07a9 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -159,6 +159,28 @@ class RunQueueScheduler(object):
                 self.buildable.append(tid)
 
         self.rev_prio_map = None
+        # Some hosts like openSUSE have readable /proc/pressure files but throw errors when these files are opened
+        # and can't actually be read so don't check pressure in that case.
+        if self.rq.max_cpu_pressure or self.rq.max_io_pressure:
+            try:
+                with open("/proc/pressure/cpu") as cpu_pressure_fds, open("/proc/pressure/io") as io_pressure_fds:
+                    cpu_pressure_fds.read()
+                    io_pressure_fds.read()
+                self.check_pressure = True
+            except:
+                bb.warn("The /proc/pressure files can't be read. Continuing build without monitoring pressure")
+                self.check_pressure = False
+        else:
+            self.check_pressure = False
+
+    def exceeds_max_pressure(self):
+        if self.check_pressure:
+            # Extract 'some avg10 percent values' from /proc/pressure/{cpu|io}
+            with open("/proc/pressure/cpu") as cpu_pressure_fds, open("/proc/pressure/io") as io_pressure_fds:
+                curr_cpu_pressure = cpu_pressure_fds.readline().split()[1].split("=")[1]
+                curr_io_pressure = io_pressure_fds.readline().split()[1].split("=")[1]
+            return float(curr_cpu_pressure) > self.rq.max_cpu_pressure or float(curr_io_pressure) > self.rq.max_io_pressure
+        return False
 
     def next_buildable_task(self):
         """
@@ -172,6 +194,12 @@ class RunQueueScheduler(object):
         if not buildable:
             return None
 
+        # Bitbake requires that at least one task be active. Only check for pressure if
+        # this is the case, otherwise the pressure limitation could result in no tasks
+        # being active and no new tasks started.
+        if self.rq.stats.active and self.exceeds_max_pressure():
+            return None
+
         # Filter out tasks that have a max number of threads that have been exceeded
         skip_buildable = {}
         for running in self.rq.runq_running.difference(self.rq.runq_complete):
@@ -1699,6 +1727,8 @@ class RunQueueExecute:
 
         self.number_tasks = int(self.cfgData.getVar("BB_NUMBER_THREADS") or 1)
         self.scheduler = self.cfgData.getVar("BB_SCHEDULER") or "speed"
+        self.max_cpu_pressure = self.cfgData.getVar("BB_PRESSURE_MAX_SOME_CPU")
+        self.max_io_pressure = self.cfgData.getVar("BB_PRESSURE_MAX_SOME_IO")
 
         self.sq_buildable = set()
         self.sq_running = set()
@@ -1733,6 +1763,24 @@ class RunQueueExecute:
         if self.number_tasks <= 0:
              bb.fatal("Invalid BB_NUMBER_THREADS %s" % self.number_tasks)
 
+        lower_limit = 1.0
+        upper_limit = 100.0
+        if self.max_cpu_pressure:
+            self.max_cpu_pressure = float(self.max_cpu_pressure)
+            if self.max_cpu_pressure < lower_limit:
+                bb.fatal("Invalid BB_PRESSURE_MAX_SOME_CPU %s, minimum value is %s" % (self.max_cpu_pressure, lower_limit))
+            if self.max_cpu_pressure > upper_limit:
+                bb.warn("Percentage value of BB_PRESSURE_MAX_SOME_CPU %s rounded down to %s" % (self.max_cpu_pressure, upper_limit))
+                self.max_cpu_pressure = upper_limit
+
+        if self.max_io_pressure:
+            self.max_io_pressure = float(self.max_io_pressure)
+            if self.max_io_pressure < lower_limit:
+                bb.fatal("Invalid BB_PRESSURE_MAX_SOME_IO %s, minimum value is %s" % (self.max_io_pressure, lower_limit))
+            if self.max_io_pressure > upper_limit:
+                bb.warn("Percentage value of BB_PRESSURE_MAX_SOME_IO %s rounded down to %s" % (self.max_io_pressure, upper_limit))
+                self.max_io_pressure = upper_limit
+
         # List of setscene tasks which we've covered
         self.scenequeue_covered = set()
         # List of tasks which are covered (including setscene ones)
-- 
2.35.1


