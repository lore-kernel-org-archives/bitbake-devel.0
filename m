Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950BBC7EE26
	for <webhook@archiver.kernel.org>; Tue, 23 May 2023 02:09:26 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.11701.1684807763107345074
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 May 2023 19:09:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=mnOOvciI;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=4507380cc4=qi.chen@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34N1vNZA025404
	for <bitbake-devel@lists.openembedded.org>; Mon, 22 May 2023 19:09:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=dZmRG6e2xbQN3JTZah3VpBQ/MP4NfFasWmr+UxFk1E8=;
 b=mnOOvciI4307X1d1W2/y1v5yfscBycec12ObNBHrAD5dnM1kG5+E9o5ThRmxQBrTk25V
 L5QYQcOQmDoE/F1B0s3VQ1rNh0ax0HlYFkaPLNzir+od8zaphPiOh0n5Mdjg8Pq8G7M9
 Z8xnGvkLEZzSb9l216YDGCFXaWLol5PF7cdX+am+ZzuOS3/Ijg1jbmykcQFbmxcehLx4
 lYq67V6EzPmJDV4MIi1iYek+VKcPLJoZNaQno7tGIfhY8Frs6CZ+lwbT/iAVmrBhQAs8
 tGhIxPZim27eQG2SgFr4x7sCgc/rCEl+vDyibxSWlT4yPt5Se8f4Q99nGsc+NFl2u5UF bQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3qpsg1j846-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 22 May 2023 19:09:22 -0700
Received: from m0250810.ppops.net (m0250810.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34N29M8g016552
	for <bitbake-devel@lists.openembedded.org>; Mon, 22 May 2023 19:09:22 -0700
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3qpsg1j843-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 May 2023 19:09:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Me8uGaYZxpTw9HHM8PaCZV4du6bko5cdAXSAjMrofiej8FrY4nE6HPiVQV1lJrE1CITXadhV5UDECcF7oyL+qm8oSD5QnVlLBiFWQ9OAGSz1hnS7jgWH4qavuLUj8moByz/RkwJc0Dqd7dCS4TVVl/Cfy5r8/iHqZeLBLR5U69otyNvjD0JHa7MSxbllRbr5lTEIatJAijbOXAMnpCuMhfuINn2SkKFpJabcAX8MibP3D1E07PGlOHiJtIqJkjilFzig71bz5BUc18WnQw1rYnUFNJyEZ9LKtw5/CR0y9qQ4DqnbjRlPUPOiig9kBqAptlMwptmxQ1ofw9CydLdVhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZmRG6e2xbQN3JTZah3VpBQ/MP4NfFasWmr+UxFk1E8=;
 b=Bd33DliSWB1Iros1+iHzYE6CNz35nedUzatbzyUvGpi2ex85eJLIyOjhLHC1OFYKkJn0NKS9mCs2OvvUK6BE9Hv8kYJsmCbEtzpgV8VGwQ+KYxJvXMQN1MERAzaW4rEQ8/obUxLrj0BC6NCl68VZCUsnfnJUpfqqWWkL1fv1Zh7Py2t+fjpEjltMm63SdZJJpmxEd1FEKp+A+951z5LGVIi+SCv6xInbKF1ipqS/o4Yofw5kfXVx4mdXHjk283/xi66GdfkPIdMQ3E1klLbSkHiTizJdqQP2iY/sqTyjqAgFQFiFwBCzgV1dSJQi1+HidU3OZ7DOlwEMqYUL7loc1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by SA1PR11MB8394.namprd11.prod.outlook.com (2603:10b6:806:37c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 02:09:20 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::fa8:8cc5:a5da:7e07]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::fa8:8cc5:a5da:7e07%5]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 02:09:20 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org
Cc: randy.macleod@windriver.com, ola.x.nilsson@axis.com
Subject: [bitbake-devel][PATCH V2] runqueue.py: fix PSI check logic
Date: Tue, 23 May 2023 10:09:05 +0800
Message-Id: <20230523020905.2911543-1-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR06CA0046.apcprd06.prod.outlook.com
 (2603:1096:404:2e::34) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|SA1PR11MB8394:EE_
X-MS-Office365-Filtering-Correlation-Id: c422da0f-341f-4c4c-4772-08db5b32b80f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	rREnKMOnZM+THkFsydpZQ4elVZSxDTxJ2DHnfrNj9zHxl3TsBt3UduOjg4c5KRGmyCRZtGk460wGntHHKoGpMIDOVxSZMHH/ORGSDQbDOiJVxiGKSi+NqdyEGvIdb3lcAbW9THUtGXvsBEci5Lf262m/sU87nAl6I8PPKWVMxFSQJbbBX53R4X+jYYy/juHP6qVVnjVRHKizG7N8jSuIV5+kmsMyp8TvwS00vFdEboyU7/MeTcXG7Ylez6luknMVZyu8mFxUpE4AcyHKDee1zXTmW8+UVtnnnhrHcdC6jOmhK0bv/H2q0Zu7Q7XVlES80my8EBioR3E9Yf6hoB5/dJZoLE5L+0xS7N4Z32XcCVLEJxYWQn+MupzGh5Gs6qUtm/KOsukwCFgT/i8xN6b7wjMwS/FhtJ+vKfq4/tY/87+zJykof4bvrEK8fZY1fFVRdtUMPGJZZgLnhOQ4Gx5b2jtYX4B/K4PAEj0huEJ+rb/HtjvfWfwKsetwyGtx1r8lDFzL9SCBmGJMLQjs9MjAT+th/FZyUhi48XwMXVFNjx2ycMVucVt0azWuQRaQ8vrowt203UtBTk4nENwL0Wpl0k/nYMxGu0HGufcgoEEBSY+ZoKwd8IYC+JaXh1nVJSbt
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39850400004)(376002)(346002)(396003)(366004)(451199021)(8936002)(8676002)(5660300002)(83380400001)(9686003)(6512007)(186003)(6506007)(26005)(2616005)(86362001)(1076003)(38100700002)(38350700002)(6666004)(41300700001)(478600001)(52116002)(66476007)(6916009)(4326008)(66946007)(6486002)(36756003)(66556008)(316002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?dlbxSTk1UHsPBgwMUFboVy7WODZOGPRpjByghqTrYVOd39gs4LpvX3RoI09x?=
 =?us-ascii?Q?udH1CgsBmIVNCS99MPs1JWOAC6mwknCyC3R2Nl0em1vR9cZPsA1YM2VuFqmr?=
 =?us-ascii?Q?vJAG1k6yehKIa4xAHKR0ABUz6+z5MC6RCnsbLspazSg3imMuifp6p1AcBjP6?=
 =?us-ascii?Q?lghDaLSccEaG+g9Uf4bBLrgtxoLKiwOEloTIzM8S0rvryGnnSDhbXZqWuAYT?=
 =?us-ascii?Q?6Dad9HwhOUhJ6m8Asle/STlDD4L5JxDe4mcO8z+pl5BzANp94Yk7lKg81b4r?=
 =?us-ascii?Q?Vl4d3bcitFw0+kWC2nGymd7gshZYn3Z2BOZPPW8DQW4MZnnlgN4xaHEHj52c?=
 =?us-ascii?Q?dVv2X705owBO0xhj1Rs+Q0foTNCygyQGYww1dKdNCBe7vTSf63SOChqIhFj/?=
 =?us-ascii?Q?J2iBd3GqX+jwFz9HcIeWdTpfGdbLiGG2nDZKsNyDyC9pOv+pjHPDebTP/dhC?=
 =?us-ascii?Q?SqN+idtXmvFjQIo6EWnYV49dLzfwm43TceW6nUclfY8uFyRk9Aj+w/rObimQ?=
 =?us-ascii?Q?H9R2+VPjmfBF9f/x4wBaMjSbb25e7SObXWyyukk5sjYJjcIP0ibZ1y8WLuda?=
 =?us-ascii?Q?5phkS72fig+vqysfJj/ml1e+Ofs0IFz3ChyQX+zcr04GZm7TexvgiierhnWj?=
 =?us-ascii?Q?1XKTDIWNi5NCv9SxKEbgY+QmdSD2H4DFTKqWOy+W8sQaGorx5ARSyWyup7Gq?=
 =?us-ascii?Q?YKLI6PPeFklCaLYJBw1DprVuv76CVV99O1w4HIOkN8xHSVAH0D7KI3ELoC37?=
 =?us-ascii?Q?XWEb304dQlGXO0qlUMREmUpemhmztJxL/sHML66tNFr0oNwDoQW8RneENw2a?=
 =?us-ascii?Q?ugCe9sguV6u32Cf1GcDyivPxts97Y8zisASdOMzkzHDSujrGXeGTG1y8oX2M?=
 =?us-ascii?Q?jJmjpVbPWV9RmJwULg2HkZ1kGf+4WzFI/dzM0P8ItsS7DM9lU0Z1F/shgQSL?=
 =?us-ascii?Q?wyZ8MXvhFIn6Gpxx4q3FMlmf9zM7xWdlY4Vg/jOL3gI8XzR+EBga9EQR+2Bl?=
 =?us-ascii?Q?Ks5F6wx2gqYAYIUYBYjYouEXOiyBsxncuHaZe/QZes2rn5pn8OoQHfRn2nCL?=
 =?us-ascii?Q?MGr43sjN0oeSP2+Ho5KculHypO5MYPb81TEv2tE7Xh3eHaXFqGh01/NFlkYy?=
 =?us-ascii?Q?uA3s5UCLYhyn5peahsHFZaoCEN0x5P8g4i7lIu1SC8or3CA2Rdg+WiwP5/Ti?=
 =?us-ascii?Q?2PPyG9zMpx+WAsgI2qx+FnlGO7aqI7DQ7Olyz7+VbJJ/7BfR3wPZ1J9Ljq4e?=
 =?us-ascii?Q?e31SoF8KxEt2urkSN26CINuV5k5nXxFETdno/vqEPOcUQS6+G4q1ZfIZDa/S?=
 =?us-ascii?Q?Ci/ovuqNDxAmbPcVF/S0v6zdKgYsvv8SGiqdLjzQSsx38XQwL4Abbi5ohPQs?=
 =?us-ascii?Q?/StOVKs/LM4k0/wKte393Wgkrk26jBXACWok+DVzPX1Mj55JdhIF8PUTWqun?=
 =?us-ascii?Q?gUVqUosxRnDYcWtp2U4VoOObTTeuRxgoo037Xr+fdGRXR5M7+fTvQ5mEtx8/?=
 =?us-ascii?Q?9DbQI4ALnbgLI5H42k2kZp3GmaGQKW0b70sE8f+INsaGxoV+F2ZTeRHFqXhH?=
 =?us-ascii?Q?uKO/KxxKiVWh1sIfcF3E9zz20zW1RZ1R5KQLUG6s?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c422da0f-341f-4c4c-4772-08db5b32b80f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 02:09:19.9875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2uditeUJpLT9gh4i1/rhfcgPz85Xt0+pYi23jcn4k1NcWVqHrg5IQJssmOK8aAlV9WllzxQz+xzSpDEM7+Jp0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8394
X-Proofpoint-GUID: R-yP8liJzqAQFYqzm3-BLgt4a8549pJi
X-Proofpoint-ORIG-GUID: pk-3lLYO5Bbow6IxwYqo8FixPtfi6Mrm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_18,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230015
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 23 May 2023 02:09:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14799

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
index 02f1474540..4d49d25153 100644
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
@@ -198,21 +203,15 @@ class RunQueueScheduler(object):
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
-            return (exceeds_cpu_pressure or exceeds_io_pressure or exceeds_memory_pressure)
+                exceeds_cpu_pressure =  self.rq.max_cpu_pressure and (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) / tdiff > self.rq.max_cpu_pressure
+                exceeds_io_pressure =  self.rq.max_io_pressure and (float(curr_io_pressure) - float(self.prev_io_pressure)) / tdiff > self.rq.max_io_pressure
+                exceeds_memory_pressure = self.rq.max_memory_pressure and (float(curr_memory_pressure) - float(self.prev_memory_pressure)) / tdiff > self.rq.max_memory_pressure
+                self.prev_cpu_pressure = curr_cpu_pressure
+                self.prev_io_pressure = curr_io_pressure
+                self.prev_memory_pressure = curr_memory_pressure
+                self.prev_pressure_time = now
+                self.psi_exceeded = exceeds_cpu_pressure or exceeds_io_pressure or exceeds_memory_pressure
+            return self.psi_exceeded
         return False
 
     def next_buildable_task(self):
-- 
2.34.1


