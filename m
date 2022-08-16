Return-Path: <aryaman.gupta@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFE4C3F6B0
	for <webhook@archiver.kernel.org>; Tue, 16 Aug 2022 18:28:19 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web08.19437.1660674493554717135
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Aug 2022 11:28:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=mMA2lpRz;
 spf=permerror,
 err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}:
 invalid domain name (domain: windriver.com, ip: 205.220.166.238,
 mailfrom: prvs=522748b83a=aryaman.gupta@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id
 27GGm1iN025692
	for <bitbake-devel@lists.openembedded.org>; Tue, 16 Aug 2022 11:28:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=PPS06212021;
 bh=vfpJTqyzUMLe4k8YX1S5ROxdaIV8EVXKYa8jJHrnpJ0=;
 b=mMA2lpRzGpKjElDI9Hckr7QJCyJLNJio6tPEP8V+8+0W1wA0moQpMUYBah7xOVlgTw9s
 Cl06tQxCwvUmXCe+wfo93QYjuOWWI5CyNKKB3ZhZcUnu2VhX4PeGbpvDVKae5sRCyTNp
 g9nF9nQciKL9SgsoiFnZkW9UZGOTmjg6OTVmnhYVwpF1vtBDNruto0SBD2XARmpM0i5q
 RD9m37FlK1pOQ0hKOuoWEKCmn2nLdEMpVKwg9fZlkZT0nF4EuFpBG6vYIZT/ZrAtOdaT
 T+nAqjvvyaTqOgRJVolcJSsPF9r9D2lAkIm42fsEM+ILEKUeW9XbP3pcVRpvtKYPIRde Tw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3hxbfjjhv3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 16 Aug 2022 11:28:13 -0700
Received: from m0250809.ppops.net (m0250809.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27GISCIr017998
	for <bitbake-devel@lists.openembedded.org>; Tue, 16 Aug 2022 11:28:12 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3hxbfjjhuy-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Aug 2022 11:28:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bc1QR9oHihSKFA/LP22W/W0Pube3wM+TBbO5tIK6qxvY5wBNzipatTkcL71JYfnLbowaaYOSQTIPR6GSc1a0WC4civy+iZnD8FgjltDQsoU1oCP/f/i5QXubld+JkL445q3n4zFsAC8vxHwmWPsDbUbWaH1qTCfl6jxzHh+JQEXiTSya2+4mMpWimMZ+fr6qJwbyT5ZkxaxLJnfsADf/mjqZnERlgtDTiA3vbdwOBrJ16FCeMCKb/LvkLyiwqsIm9nzZsUQtOG1eOcSeL2liew0p934bvLTBB8LoZtnXgLdh8aGQzhcUP6/jYNFejavpduSrrC775v1YFXsl5/vBqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vfpJTqyzUMLe4k8YX1S5ROxdaIV8EVXKYa8jJHrnpJ0=;
 b=fgC74DumbR4Ym4Nq+YgUgYylNritiL686wmMcgJJWHppYg2LAlLGaL2W5l36g8rMnjrDbX5lOhtaf2Az34s6faCTvmDR8qz96lRnXdQ9kTqjTBHGTtTgDzH6tp2D7V1PIqtT+gG8HDl5wSicAzEUiXB/+xCP9B6vdCAHuBMIlc5igAasXiPRRKjWxM3XWXGPbP19gmGbdmT4svQZGgBX/lOI0+iNEjEdMF38W8+WNGaA9nDOUBDWhg7axKy3dTpPW47sCDXwZgzxLZdgel07wtmm/GZGch+SvdKW1r/RudH3CNpsYNNQODrPnWeXShyQu+CesQavXsG2sOX9n32iGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH7PR11MB6030.namprd11.prod.outlook.com (2603:10b6:510:1d1::19)
 by MN2PR11MB4693.namprd11.prod.outlook.com (2603:10b6:208:261::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Tue, 16 Aug
 2022 18:28:09 +0000
Received: from PH7PR11MB6030.namprd11.prod.outlook.com
 ([fe80::300a:e5c7:e79b:9a36]) by PH7PR11MB6030.namprd11.prod.outlook.com
 ([fe80::300a:e5c7:e79b:9a36%9]) with mapi id 15.20.5504.028; Tue, 16 Aug 2022
 18:28:08 +0000
From: Aryaman Gupta <aryaman.gupta@windriver.com>
To: bitbake-devel@lists.openembedded.org
Cc: steve@sakoman.com
Subject: [PATCH kirkstone 2/2] bitbake: runqueue: add memory pressure
 regulation
Date: Tue, 16 Aug 2022 14:27:56 -0400
Message-Id: <20220816182756.497376-2-aryaman.gupta@windriver.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220816182756.497376-1-aryaman.gupta@windriver.com>
References: <20220816182756.497376-1-aryaman.gupta@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0104.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::40) To PH7PR11MB6030.namprd11.prod.outlook.com
 (2603:10b6:510:1d1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26052676-35bd-4f48-8b9d-08da7fb5117e
X-MS-TrafficTypeDiagnostic: MN2PR11MB4693:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	KJjFZgq7zLw9QQX7HD/YGw9faNjDwIAn1pNrCwJAxGsC0idWJTcM05zJ2tNlq+4925bxp7P4mOBjdh8hn+gF5BD2+bDP9OJz+7UX49lg/0YjsclXOk8g4SahNHIQCHW85jfbB+2oKroU8j6frbcbnpydvpQho8ikNafuErkXGt5p5lB1INbaepTM8RjIl1ymlgDYFumKlO3bpLFllmD66Nq243o3kpfWzQ2sIuWj+xiKQnEOA6fiwFv1K7r4UR9zIbFu0LCZ1RFcK+q4dFzPSurtbPeLtCrhh6ug3vyqqeIuKiyxmowq9PRFmOemo56Z1X8aZBcV39osB4fVhI9WYZxgcRW3UyR9SA5yWDYG9skh56Z2+uBwIhbuOEEpKrzWTv+j+93IlUMbFR65KBa2/rOeEgcdhOEo7ocWlgRztKDlgI1R+EdewMFftkPmW4WnXTIOOb/j2sfkl/9F7gtYVId/FlzfpKh7lUIc5sVtDbIovJTkrAp52lUnGXSxiDOkTqBLiojSV4i3kgzgNzefkryFM5oJ4PPh1cEc1o1MTVzyclmCBuj6J4FNExQ3/RRSci91KAPL9npZMmbcrPeXJDzNdJIZhbYQCIYtSwuHCdtCHWgErFtqowCfjjNFBlrXQa50Z5T/KUXR/jJo7EffE/mJcQ00Xl4mz2UU99L70JRAnvdbbcBvWYhWx7JM3/ngcHto/pIO1xC4qiCVI2yZDF8NATIk4/KmepKLfChFPLm7gFl4ZaJWvgxEna/ACXz5hJ0C97jhmkmBPBEgxi3fkOyOX1A0fRdKlVee/8t6CP8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6030.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(136003)(376002)(39850400004)(366004)(38350700002)(38100700002)(26005)(5660300002)(66476007)(6506007)(6512007)(8936002)(478600001)(52116002)(86362001)(6486002)(6666004)(41300700001)(8676002)(83380400001)(2906002)(4326008)(6916009)(44832011)(66946007)(66556008)(316002)(1076003)(186003)(2616005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QxF0OY9R01g0E46MhLQUKjqyrCNh3guCdr6zejjEC/qLK0Fkl5ZFmBGNX7GB?=
 =?us-ascii?Q?Fo/Mieg4LPK2Z3gqBjKOs0r63DJRUBXSZ5S12bqXltykQvShYwJH2DxnNfXt?=
 =?us-ascii?Q?BGLmuUrKuw+Dkq8wuw2j9VmiVSIXil0QPNYYI7OIqmrsBCTkQe/OVSAArPSQ?=
 =?us-ascii?Q?vNESCCqN8ZjjzGn4vtyye6azHBnr24dKnNi9IEok+sdnPtkYxlIG5Mvhvqg7?=
 =?us-ascii?Q?78MyExL1gepvobjczpSfCbvkjHVodN1E058Qd2kLpX3pM1AUOEQHYGtTeKR0?=
 =?us-ascii?Q?r6H+Hy0cnFWPsLKiQDM72aBDkmwEK2f66+P5OALGxtS2MwF+iRYWMk6mfmWH?=
 =?us-ascii?Q?N9vpDq3F0WkcDgDc9ql5TtCo+2uLmf8lLgXHqyF310TDzdXKxNg29RvEf5zk?=
 =?us-ascii?Q?ZqlpJsbFG/O9PJGFW1M/msZxHEZhP/fFGRS3RSQofgQKIRuaOXR1VgodycvD?=
 =?us-ascii?Q?fH8hbAONGwc3EcQQDfYqrw4s77lbtb9Vme2VY3OwZW7Z+n+jZd7QOLNy15mO?=
 =?us-ascii?Q?rcI1TOC6M5DWBmwSTuoZwrTjvdleA6VuXb9N5uk7YrerwLIe8/Pj3sXuQ+a1?=
 =?us-ascii?Q?0i4KnjXseKX2jj2BcgJol2tDW9r7jqp9AvsJcQsMcox2nU3M1vji0DF73jK7?=
 =?us-ascii?Q?c14s7Nq0pyB28JsUpK1rOFTKb940cvuTccr9cPIi3DFpX5yMX/IZDQggjm3D?=
 =?us-ascii?Q?s++8jrfJ9NCcwiRMuaOfPRgMehktRNijTiMnsdim9cA9jZ6Wo7JUU/euGnJU?=
 =?us-ascii?Q?LFRVR2binjFetLLBzPhoarvPun5BAUob6mv9+tGrN012P6EfHbaO7gJwexxh?=
 =?us-ascii?Q?mOKZbwz1TmLlwf1SgOUSKx8x3/JOSDLrs3lMow515RgkhO/T8zmFbznBh1+x?=
 =?us-ascii?Q?RYYv6vub9+qIZhoo9ZIBzDoHzKBIhFg4fsHyNOcK7qRSw0+Y+/CAlSeKGgLZ?=
 =?us-ascii?Q?/Gaqo5YphYYA50/grA5sZ1+XL2wSPiAZ0ATHMjXnbyyBOujImT5a//Zj/rjw?=
 =?us-ascii?Q?/aEi/CMeK4VKdt/e/JNXCgPDiGn4TX4H+Gy5+8+LocwS0Fl1Bw3ibmciVxgC?=
 =?us-ascii?Q?zL7a4XKUe0b8mES5X2sLwuwowWFM9dXG6mCERt4zRQe5xxJuBEOfjsB83TtO?=
 =?us-ascii?Q?6Lxt0ZpNAFgf7vBKWo2zvvQ0TZi/sSkNqvCFbfX+ka10bOHN9SSZxyFPzaCb?=
 =?us-ascii?Q?NEVSu6WcBHQidz28pEgFYXfSx429b3qVR9ShWHEjqKcH5mh4VhEmn34UMbfl?=
 =?us-ascii?Q?xBTKIbaL8/Nlg5pQ1SeQhblMnfym5YQ0CN/Mh0lfPI+KWqu/DND0wyunaqIh?=
 =?us-ascii?Q?OPM9e7FWHDDlMcXI9hQFU7L5+Ch599hQbXUHKj9Ob8bWhr8SI9wecDFuKD9z?=
 =?us-ascii?Q?gNWBVPfHoeTtqxZe7II89ydk2DvhcdfEDjIsbkGpqLUnGVj60vVPkvPvHONk?=
 =?us-ascii?Q?8qmg/ts02qjjAvZV8NDj9Rj9jgLqK1ke7qTbW66jhad53eU/uQTagxd5PgaA?=
 =?us-ascii?Q?NYBJWY1Fpj62aj9F0hKnsgq4hQTZAqLkYLPyX9Q19zuGjnWaI+7GSsA3EhBX?=
 =?us-ascii?Q?9SJqbiFgLKqQEoYOTQrdK2cmUPtlKYGqIMfzb3s7x+zuhrscrPC0xTDV/7MT?=
 =?us-ascii?Q?bA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 26052676-35bd-4f48-8b9d-08da7fb5117e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6030.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 18:28:08.7222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 6p3Di2PSSVcA7xmb0/aOd+ZPQkZDVWFBBBAzXAgnKI77vxck/4JDbVn/jSnoJ3ZYTanpeC1MUa1vfGMp64JapHqKULZqlLjnfsxn/GBxuws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4693
X-Proofpoint-GUID: mUsLCYy3ZI5NFp1h8cKajqmP9QC3BvlH
X-Proofpoint-ORIG-GUID: WzMsAWpgcrUPvfv1HICUFqTlGOFZdf7-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-16_08,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208160068
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Aug 2022 18:28:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13898

Prevent new tasks from being scheduled if the memory pressure is above
a certain threshold, specified through the "BB_MAX_PRESSURE_MEMORY"
variable in the conf/local.conf file. This is an extension to the
following commit and hence regulates pressure in the same way:
   48a6d84de1 bitbake: runqueue: add cpu/io pressure regulation

Memory pressure is experienced when time is spent swapping, refaulting
pages from the page cache or performing direct reclaim. This is why
memory pressure is rarely seen but might be useful as a last resort to
prevent OOM errors.

(Bitbake rev: 44c395434c7be8dab968630a610c8807f512920c)

Signed-off-by: Aryaman Gupta <aryaman.gupta@windriver.com>
Signed-off-by: Randy Macleod <Randy.Macleod@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bitbake/lib/bb/runqueue.py | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 203ef8c153..9b009262ef 100644
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


