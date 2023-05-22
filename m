Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904EBC7EE23
	for <webhook@archiver.kernel.org>; Mon, 22 May 2023 02:19:36 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.3909.1684721975254257385
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 21 May 2023 19:19:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=pZ7hf3Ki;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=450688913f=qi.chen@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34M220EL019473
	for <bitbake-devel@lists.openembedded.org>; Mon, 22 May 2023 02:19:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=dZmRG6e2xbQN3JTZah3VpBQ/MP4NfFasWmr+UxFk1E8=;
 b=pZ7hf3KifKmRzH0Mq61RjoedFcKdEuMBk5PW1aqv5YroN8PbM/8sv2Ta9pgHYXle+egC
 hkhdap74SMxbtAvo2Gt0G7nxfrqUuiwQgylUsEBLgrL9yYDoz8CiP5IxtEiZSibzIgLi
 hhIhwzWki6EyUoEISxskVeTvyfL6R4xomEoSGuctAtTOOwrHD85ftpLs2QLG6YkUaNDi
 ZavmqMO699RGcj0F0Wk6/RhPskutnGRqPzK10Bl1llbBkNi/2foFzCrbMxFD6RVXuKTY
 jAjBFbiDtG07Z6BgW/xUnoskODvScNZj+u368tEqx1mNyOJdSQxgBwxB5jJjuZj4FRLY VA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3qpn67hcmh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 22 May 2023 02:19:34 +0000
Received: from m0250812.ppops.net (m0250812.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34M2JYv5020160
	for <bitbake-devel@lists.openembedded.org>; Mon, 22 May 2023 02:19:34 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3qpn67hcmf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 May 2023 02:19:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZkOVkDkPblRPTiYA6FzBg0d9SroFPPlqN5saitPrIqPuHB48pJ6v81kVDWvCrCrAQUcHDMD7G3KTt+6qxYvC1fTcvCQ/T2ciNEt2P4Txp/DgfVihM6zzJfGZWM0LGKbt6/EDWcEgOw4T3lLHV2BmFtc6A7HCnJCxF4UzMlA8gil5Jr/B/5HYU5UgMNRk5Zyff+KO5A9tPiAgzDGLLj0BBDYamUD+iY4Tx7zqRrtYBXp7B1zfle1XKhPANjLcBMOZEQnkbaraM3TZm40Moe2yWh5jowcPlLSaXjzJuL7PccBEk7UPNwquu0ibTQC20O0HtS/T8ToL5IQtjASDmKWA2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZmRG6e2xbQN3JTZah3VpBQ/MP4NfFasWmr+UxFk1E8=;
 b=oUxQ+smX5xXg2knedSrJM06ShWgfieNZICZpxBJoXUtWtWC7AQpNJj9dYJylGMphsMMmelxBR9ZwUjDPBT3pcX/UFGlUXmNQCkp8kO9Mbdcw+mRecEC13TLsAxLGL05/50YaBd9cyumYXHO/DJ6JEtZtgiDc4x/Z9EWomVU+Ov+Pmk9YMN5mfRIo+56fu5bcYac9DSgjB0/pKOqTKCL98xrkMRVdcfwHR9AD0A/rlQuAWxjldwKVjC9QDktvy5GHwp7qtWvwdTNvm/eA/q6ysWrL9W0GBNuJLdG1MGRKV+4zo7P6dDmpkk69N+kMKUio6yuHFuG6tu0UCXQBg5nE4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by IA0PR11MB7188.namprd11.prod.outlook.com (2603:10b6:208:440::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.27; Mon, 22 May
 2023 02:19:32 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::fa8:8cc5:a5da:7e07]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::fa8:8cc5:a5da:7e07%5]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 02:19:31 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org
Cc: randy.macleod@windriver.com, ola.x.nilsson@axis.com
Subject: [bitbake-devel][PATCH] runqemu.py: fix PSI check logic
Date: Mon, 22 May 2023 10:19:15 +0800
Message-Id: <20230522021915.3995332-1-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:404:56::15) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|IA0PR11MB7188:EE_
X-MS-Office365-Filtering-Correlation-Id: 56e00bb8-6b1b-4a99-e3ed-08db5a6afa51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	aYvuFdLYsWhmJq/GLEfIUemP3RGExZF9AsZbf2Lvy9fbF3NborBVnsj5MU4JCxJ/qiFVIDoKsQYQimAf2tbza6J5Oul4AQ/bnmCy01Imb+JHhXoWhYjipcW6jr5k6TNX+zxwDM9mJIPTLd1N5hQTJo+iF+jgb9dsPGbv+qkqFC4mbEoIDen0+/2vydspQTwGG3jkFngu40p/owLVCEA2cuiI6ueUn0xsqgRpxI6l98OY+srjoeAV3fuBaa/yaJOxhBcYyno0HlI9q8Bhm6+CeE8JEgmAUFBRMXS2IAnDLALau8LZtpAOvKgJcFKMZxatEGV7XqNiPIwDsyD8HoNOhV9fZvs+IyRtcwB+hiQi4o/r0vXXjhAD294pPGabxeDbZqrhbya/8OTOm1CUi+BqEq9vSSxkCm/H/WvLgqvxgDtj1wQhjFw0IO9gQyIX3QfDuXvuWNWE5tzpRXwL6GUvGIFTUyEjipoL3iMPdKxR2NNAyvPoCdkFDcxqrJwsNsgPIkz2vJ7i2F1wWKWPyh3Pw3HIQxJubi88NFf5v6vdJA4fY03gCHRl+/QYW58wpei6inV9lbBnXkMnW0x3heVJbR/zXwxXow5wKA/ZtXmSiB9uBzkaOFPxsHzlEa3aQWQ5
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(366004)(39840400004)(451199021)(8676002)(8936002)(83380400001)(5660300002)(186003)(6512007)(6506007)(26005)(2616005)(1076003)(86362001)(9686003)(38100700002)(38350700002)(41300700001)(6666004)(6486002)(478600001)(52116002)(4326008)(6916009)(36756003)(66946007)(66476007)(66556008)(316002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?6K9b9A6XeIKLAAGamcz//Stmcv7TaVV3XX160iSg2DX6MuVUF01voZ3EuCOc?=
 =?us-ascii?Q?V/vrKezVYu12mQXncrI8klakv4zwPi2zcE17KW/YgOFU8iuZ+/HW09Bw56At?=
 =?us-ascii?Q?sgpUmjbjad/t3HFCwRYH3DOwIu/18kdPJqz11zrvLvk1PivZz0KgH3EzFNBu?=
 =?us-ascii?Q?rZx4QH/h6VdwkbVwA9I+Ht9e/WDJnRjK5OZGnbEkr1LEX/bdfeXxSj2RtLs4?=
 =?us-ascii?Q?tl2kC5e+0ku9YzsinSe5JNUBGNUnJe9f5F9e4jfIlOV4orfTTr0G1mP57+kt?=
 =?us-ascii?Q?nZUQnyUS5HLjd+qcKv4c3lgOEDM8gLjxrN+QIqd2Rmq44qPwAUN3UOKmR09B?=
 =?us-ascii?Q?vPwnrX/Alif6O0rVQxoNJEaYCY3QMj1lsS3G2Wrr3zkwbUcc9p0EEU4BgQZn?=
 =?us-ascii?Q?SVJb8V5VLQfYLQF9XLD7SXypwZqUC3tlbwNGMrWxRxd8dM1RL+YX+odIMDHS?=
 =?us-ascii?Q?59DUc0nNv4FELu9qlGu8sVgIoJl+q0Rm3/Ih8iEXoq8XAsc/dPdCKIbBzEIY?=
 =?us-ascii?Q?4O2RLIdgI/mOFZ40wAgtyPU9uKeD5ZafDUZbDL4D5wU8D6STMYRD59Cjuf86?=
 =?us-ascii?Q?tju39MYEvur0q+tozlXJHN1y6J8enRl+oyqxNwrVFF3sGVdyMsVZnURKF34I?=
 =?us-ascii?Q?rWBjtowc3anDnyPchVN+9pgdhIYxWSpKQ/SA4FUe64WzNRRKVoVRojIxbvMp?=
 =?us-ascii?Q?djxvx85NemzvJNZMN4hxcaniqwO6SC7uc6Tq+SZ3Hfw4pNtMbbDUCgcDmdUs?=
 =?us-ascii?Q?svaw0s9S2STHKpz/SM23eQm9ErDG9Pi7WP1Idg+FdsAi92iIxiVpkcTHIMp2?=
 =?us-ascii?Q?2eTFhb87rmlcguz9Ds3ZLLjSKh6WRmYox9Mic7l4Fc8pPdy6OgHAf/0IaI2o?=
 =?us-ascii?Q?OjKntwOjGmIarEffZmch5mA/87PnJ07PaDEoOp7Bs9Q0ZBc5MI+qkviuECEu?=
 =?us-ascii?Q?lqJCTOJlTgPO0s6hC/5CQRRNYrNmYlbFYQI6dKRmuVfNqqexa48s3WDE+MD4?=
 =?us-ascii?Q?qSAfOeOu//4zskrIaE3vEteRrR5gWmwYxFoYsQR870NlMjvKj6Ei63dbbY8b?=
 =?us-ascii?Q?dS4W0thmweNbFtEQS8UU75CHVXHjat/R6LheU2snqDEwlkduf4OHX85vUFVO?=
 =?us-ascii?Q?QUOLIYG0uEc4Lbb7rYvDAvUkkWQTSiwUe4UtJuzxGxohXGekPZP8S0koWQGX?=
 =?us-ascii?Q?c/JNN1mo9oA5+VfGrj1RZpxizYn8+oU5VOdLPUE62t81icOI2+iHmfVFZIa9?=
 =?us-ascii?Q?/rFpYFQf55FRoZdHO6+7JJz2VEXNrfIW6u3lTkDg+oQt9nOBTIcl4Lr8exkQ?=
 =?us-ascii?Q?hUgZrlQrDtDX+zEAbWRWcAr961FwcPWDU69iD1ITBD8j/iuMEZTE26R+0+9y?=
 =?us-ascii?Q?kenEuCA2LPXtlni3ZUHJyetMY6g1Rj5k5alqUMeq7JxK3rEu5TSwrgT0NN3y?=
 =?us-ascii?Q?QJOCNFAlDKP8v4EyAmmxqVXJCN48t2HyiRPQl23zWdINAYNkl5Le88yzm/Hr?=
 =?us-ascii?Q?QQdzFsDII2eehjo+8AP0svU0bhD/ihuTjlcBFbxZNMcCvwcc7lXzt1eNqkMI?=
 =?us-ascii?Q?Vio6vct9RxMKeree++j+gyIpge0WkBy7S3X89pNC?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e00bb8-6b1b-4a99-e3ed-08db5a6afa51
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 02:19:31.7669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zDFmVzh3Gamlo5e4BWOeO6z18uTlYloHHd1YTKdUi8/r+4l/f8fPstU4T9WNesvP7ILnmSo2q0QzyUhZdvfrrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7188
X-Proofpoint-GUID: 5CagLmpme3cjdAQYYbUQN1IY4TEUpFeK
X-Proofpoint-ORIG-GUID: WOxlKkYzu3Dz3ciVbhncDusyDgLe-yFF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-21_18,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 clxscore=1015 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220017
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 May 2023 02:19:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14793

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


