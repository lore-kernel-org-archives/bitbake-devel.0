Return-Path: <aryaman.gupta@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B1EC32772
	for <webhook@archiver.kernel.org>; Tue, 16 Aug 2022 19:14:10 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.19715.1660677243085929957
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Aug 2022 12:14:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=D83xPYIG;
 spf=permerror,
 err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}:
 invalid domain name (domain: windriver.com, ip: 205.220.178.238,
 mailfrom: prvs=522748b83a=aryaman.gupta@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id
 27GHdAF1025564
	for <bitbake-devel@lists.openembedded.org>; Tue, 16 Aug 2022 19:14:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=PPS06212021;
 bh=iPyz3kX/kNTtM4p14PAQMzfCg1KFd94pMvWwiiLqo1I=;
 b=D83xPYIGnjK03pVAYhOa8b8QjvwrDvBQt8Ze2NZfvVRiv0/4YWiF2EyCh+NoDoMJicG7
 xAXEqtF3mhNy3to1Kf9bqD1l8/0TmtBLXgvdv1bIY3JJAfS+8Sk4joAalhwJZLZJV5Qz
 jgbD0rXJNKxopMkzpoFP/Ae7EgU9X5BD8oQVlW2lgsZLGeer20nM7qH/ulgXoESr640q
 pW5BdJu73Y9W5hJufii6rbIpok/r04YsMvI7BqAJckjkr8vgjKmfM5lwm4Cm7i8qe+fI
 2E82AIucSclbygOPVV9Fcoc/MmkNYZJfy5KSjNUP7C7c+tAQO3bwNbMv9B67WGXLfvwh HQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3hx160tvh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 16 Aug 2022 19:14:02 +0000
Received: from m0250811.ppops.net (m0250811.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27GJE1Ml008761
	for <bitbake-devel@lists.openembedded.org>; Tue, 16 Aug 2022 19:14:01 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3hx160tvgx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Aug 2022 19:14:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C3PG1y/dWCwQMHYymOVNPo6JQz1MiUAGWzELgWkTHuoS1fgC0rF3Uid+GILq+TzuZ5WVgOk9zj+MCHwJ7NVQUihV0/4cpt5aO53/ltjXrwTDLIOBk8nBSwoCiAlVklq0+0sdx0HrHSQ1gsGFmaZ+SNFgw3Um/K8FgfmNgeHa/ApQahls3IfH6RZ6FkYoGwkJv3rki0nYqsoic4vddR/8E/Rw1LmLPwxzGmSC5poMmTr320KspO/EmvttWn/Z9bnbX5S8ONKx1yNg6zApVEG4awIHl75okCIMuC++i5/ErYQ4b+P8gH3UxtSbvDbSL18+QJTC8gW2iAe313exdN8Cwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPyz3kX/kNTtM4p14PAQMzfCg1KFd94pMvWwiiLqo1I=;
 b=U4VN4eMfZNnyvo2yICnU5y8jCZyiHFftTe/r27fNsdayT7D+Ktq0LYQIa8fQROYaf83d3kPe8xNJRYbsPfg+I1fWxq5wf+ghrcJrHil9NRos3WfUz8ijpvKNCJJUQC9lX8BgHNZEBlDqaiecsLtyvoKEb61qVxi1k27YL7Mo2wyTnyMePwFy1QVowcpsZCQ8wcyQPi51fOitqiq4kO/tsVGq2ByYxK3AXKvLz2p3sDxzjCkrCWC71+9ZBMpXH8HbkIb7dzP5ar8V/kbKbz1vz1qbkQy6cu3md2DUYX9vT2yYtk3xUVJRSDY8gl7rnNcEQizociUebaK5g+OdCib3Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH7PR11MB6030.namprd11.prod.outlook.com (2603:10b6:510:1d1::19)
 by BYAPR11MB2614.namprd11.prod.outlook.com (2603:10b6:a02:cc::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Tue, 16 Aug
 2022 19:13:56 +0000
Received: from PH7PR11MB6030.namprd11.prod.outlook.com
 ([fe80::300a:e5c7:e79b:9a36]) by PH7PR11MB6030.namprd11.prod.outlook.com
 ([fe80::300a:e5c7:e79b:9a36%9]) with mapi id 15.20.5504.028; Tue, 16 Aug 2022
 19:13:56 +0000
From: Aryaman Gupta <aryaman.gupta@windriver.com>
To: bitbake-devel@lists.openembedded.org
Cc: steve@sakoman.com
Subject: [PATCH dunfell 2/2] bitbake: runqueue: add memory pressure regulation
Date: Tue, 16 Aug 2022 15:13:44 -0400
Message-Id: <20220816191344.509172-2-aryaman.gupta@windriver.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220816191344.509172-1-aryaman.gupta@windriver.com>
References: <20220816191344.509172-1-aryaman.gupta@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQXPR0101CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::45) To PH7PR11MB6030.namprd11.prod.outlook.com
 (2603:10b6:510:1d1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a86e2915-f43f-474a-fb5b-08da7fbb76fa
X-MS-TrafficTypeDiagnostic: BYAPR11MB2614:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	1GZwlsZsGOYbd/suuipAkNG5XVZyyNuww5OpbceuMCRRpUiQ4LN6GwomttK2yPZQMmFOu3VacvJKNGPWmRkanOEyq4myQdnhVLTfS8rW6gueRnDGDFzufPkaeQm0s3nE6NAIWhsyfp5ytIoPOxMbbRpBppLvLN2gq0NX5Xugut6iTvnpr7OxpwS/jxtLq+klZfcapKJzenoztQ7SV9+rof6KiBV5aeni3hZRLNoUYGpNg0MJoC/PSX4mqteNJ9zHe/9iBr+ySSApmFs9zrhkafL739G4yYKcw0AKY2R75ekRZA14oXmO7Fhpe3X9RC6VkYOPwLchD45u3zECcP24Ck94V1CmvZWiWyfBTLwm85pgLb2lhwl2JrWAWvyPpCML5d7FGg7JpNb2E0I268V+OjphONjH6mH4EjR+PybrN771lpLMVv8lwNbOufkIEIhcvGuohcc4Q/9fAP7jaejJzVGSSRFGcCaFfjTjwFvO3JI1DpZ0LPtWDteVAJYDq6EJCF+DhqJKWXPT3h5OOEQT5qyEGjH4oHI4TRucwqFnKszfpR0c1TTTZiCN7ysy64rSn/PSoL4abgmfxAQO11FE6WHorFdpywGdGanRcSFStXntnSdKN7V3Du5ocGUOVsa50ZB9BmD1G0RhF7AnN/ePZgPOjt3izS+59/jjJbUkLn/1020e5OnhR09EvxdRX4ltLIYg/xOUx3azo2LpsO6PJgW3CyP14t8UMNX9EAVDp2DDy0I2Z973rYcHdxmIMleFHSbsFsRXTno6n8ZMzgS5WfDsJQXiM7NioFJh6+LZZig=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6030.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(366004)(346002)(396003)(39850400004)(52116002)(4326008)(2906002)(26005)(6512007)(44832011)(6916009)(2616005)(38350700002)(6666004)(8936002)(6506007)(41300700001)(86362001)(6486002)(36756003)(478600001)(1076003)(83380400001)(186003)(66476007)(66946007)(8676002)(316002)(66556008)(5660300002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?FMvuzKlaNtC1xRkWBrOwmiltFI/0HZMc3EYTKjbz2x62lscj0kWMpKWSHaNe?=
 =?us-ascii?Q?mwqvOYe2Shikht3gTDHfNm2S6uoXphFU8IyQXo6aXPRNl7jV8hqaM/FW4Fpb?=
 =?us-ascii?Q?VZ7ue6M5CM9TkEYM3lpm7eQF9YiXixgKhTcnqbVpYr+4x3256sZLob3YlMJ8?=
 =?us-ascii?Q?P/aTrWwnJz6WKqK/P8302bVh0QyKfjK2tNrYQI/2SrU2fzm1Q3/bPiFUzfgN?=
 =?us-ascii?Q?cc4Xb8Peq+yEzIcdyNMh1wm3SU6JseVcbH1pmiHCiWJEs/A80nQ1r3o7tqek?=
 =?us-ascii?Q?jbcV/ZmAvRq0lN25O/ViR3M0Cx5mUGAWdt/K4/yKQGrxqOrlOiBJukzNhDaJ?=
 =?us-ascii?Q?Bj+C9Vc7no4nCmc171u0lAr+QZ/Y0SYd0yhhAyxWKXJqyq+Bb2tdJmKpKQqj?=
 =?us-ascii?Q?a+qXRu5LkX1O2DeMXWa31uA+Ta24oviwvAV8aGOzykZNiwFNHCJMASN0eJ3B?=
 =?us-ascii?Q?CkXe+oOh4FPKOyk8rjHbkhMvWCI2C/zbxM0sjChSg1UdW8hht4dH2ZFTuBIa?=
 =?us-ascii?Q?xqFgdXwHX4e9DxdZcluv2FjgTyg4P6vGDTs48KyLOJN0iL9qceSws+1xy35e?=
 =?us-ascii?Q?7D90Vp3nWGbI2+BQHm1J+jiogdWAg77v3KOapX94OpjrH1LpMSCFZY3wWs9L?=
 =?us-ascii?Q?RuA/sXCa5/OKKO/pnpIPCWVr7ASPB8Fjq3FGi4wWmehamqLcbzJRUzPVeG7w?=
 =?us-ascii?Q?w/w/0YXJW/D3TaDiVc/CbT9t41Mc0CRaXFMME1YAXGqMwuFZvJWaq/xIg0JN?=
 =?us-ascii?Q?zxdCTqFrSX32WCUvnij7DNZ/eQw7uMHljsX1E1tjIGWzend2adzH1KxnkJBr?=
 =?us-ascii?Q?CcoY473hfUolUV8pgd/CavQgd27nBNMIIcdqqakWy/bwXnZs591aZJGmdSpl?=
 =?us-ascii?Q?PEIN/jvz2GofY58RNuTeEpPq6dK/NEyeFlqnZ/hiWqtxPRdRce9nLLxASozF?=
 =?us-ascii?Q?R3y/yOdiPt1WGlWf+DYcB6k9OLQZxdP9B9X0HHSNJp6+pjW/1fstzs/wiAi/?=
 =?us-ascii?Q?7itjAu0tD5Ynu1QvjBlx0cWzqFZvo3W156C9JosN/y2c43M9eA8x2PCKXwdt?=
 =?us-ascii?Q?NYSq/5xsVdTYsPb/RwQImXwUugX51xhVDQXpdQstR/dBwDbomN9MVfqNhyoH?=
 =?us-ascii?Q?R2lX+Wh3ITcwwvNUHRdfSS6S0q+jv6LjhpBmaqH+JgCRNLNj0KefV8d35RWh?=
 =?us-ascii?Q?iCHHlEHARCgUotl+eL04sFY4V1aoYLVwPfY9xDhk9tgKDZhmoTF8sNQtQGSx?=
 =?us-ascii?Q?jPJ2a+sKXxoqFGIyGWZIphjSFtX2e1/zS7IIolwY3XxRPzqokmixwXE6+mVh?=
 =?us-ascii?Q?9iKYmbBC+Hu9y1XJHcT6fXQf3gNYkTRVq9gZE11NnCzSAjZjcmoD3gBdNstx?=
 =?us-ascii?Q?oOG+PAU8MOVODdfdo5f9nLl+SEW0fuX3Ixih1JlXToAQkU8VF8HpSqQ+Ldb/?=
 =?us-ascii?Q?jkrpc8fKalDfOGDEJBM92XXfLs+mx1K6xo+hsD46WXmP1oYWvrN8wZnR+sRU?=
 =?us-ascii?Q?76Nm4npJH3B9iZd7JIlANXj3PbvEk7/qfV8unO++VIU3FRNZbdsPmFLIQJXW?=
 =?us-ascii?Q?Ke6gAbrFw12lDRBmsRlQrRs/pPNBWCI16gxxcfKNP0Zl2nsNSizidSwDKt6Z?=
 =?us-ascii?Q?gA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 a86e2915-f43f-474a-fb5b-08da7fbb76fa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6030.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 19:13:56.0305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 y7wYPQy4ErT+7x/rqWakdL7/qAVlb5HvyTjXCEDLlJleEhdkZUnDh3pQ3qFxUcPRhXSzkFDhmo15Yj7xyBGtC1TQZfAkQkEpUWybrH9RpxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2614
X-Proofpoint-ORIG-GUID: AJpOGQv5EVdLZHxKoJ9Bhhj9zzo6ckFe
X-Proofpoint-GUID: kDoKojDWsJpUpC9KSNFUMR6Y_2agRGsZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-16_08,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 mlxscore=0 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208160071
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Aug 2022 19:14:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13900

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
index 9aa99ef4a1..13965796eb 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -151,11 +151,15 @@ class RunQueueScheduler(object):
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
@@ -167,21 +171,26 @@ class RunQueueScheduler(object):
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
@@ -1749,6 +1758,7 @@ class RunQueueExecute:
         self.scheduler = self.cfgData.getVar("BB_SCHEDULER") or "speed"
         self.max_cpu_pressure = self.cfgData.getVar("BB_PRESSURE_MAX_CPU")
         self.max_io_pressure = self.cfgData.getVar("BB_PRESSURE_MAX_IO")
+        self.max_memory_pressure = self.cfgData.getVar("BB_PRESSURE_MAX_MEMORY")
 
         self.sq_buildable = set()
         self.sq_running = set()
@@ -1800,6 +1810,13 @@ class RunQueueExecute:
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


