Return-Path: <aryaman.gupta@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0BBC25B0E
	for <webhook@archiver.kernel.org>; Tue, 16 Aug 2022 18:28:19 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web09.19501.1660674493474170726
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Aug 2022 11:28:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=N3GmNipw;
 spf=permerror,
 err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}:
 invalid domain name (domain: windriver.com, ip: 205.220.166.238,
 mailfrom: prvs=522748b83a=aryaman.gupta@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id
 27GES3xO026462
	for <bitbake-devel@lists.openembedded.org>; Tue, 16 Aug 2022 11:28:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=An5KlVV+InXoXZwKojBXb8mOtKBbQnZ2ggtVyShab9s=;
 b=N3GmNipwP3eIPETBXJroovm81uLX/nA8XuTRyfz7fNHS1ss4EUTISFECDKUsEoDTqrxc
 JH9NfAqP4k4ivEN0x51QfjZzwLEpI1WDL7hy1GG6EuefkQXh8vgtv9l/xRMWd1unzd1x
 llLPWrcg90H+II8jr7j8we7wGS0ZIXuLeObPOP0FiVAoTXmolZx1llGAoc9vCoHLoQ0d
 BQJSDKy5brcozajv+IQKMBQGW9EpKBG5i1VB3qKLtUUHy27qevMpHTY0Z7hk4UB03M3M
 yVGbaCVe6mmBcTZwOwqwK0c1C5q6vswiQvR3qkt2XBk4vrvOpRFQXA8B3KWzwHfs28Yt rg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3hxbfjjhv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 16 Aug 2022 11:28:12 -0700
Received: from m0250809.ppops.net (m0250809.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27GISCIp017998
	for <bitbake-devel@lists.openembedded.org>; Tue, 16 Aug 2022 11:28:12 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3hxbfjjhuy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Aug 2022 11:28:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNtv9+pmIvnWBXsrO7OCEWhPrqBsZDdE6O92AoJAU+qCTeQcxqF3r4mpr4NeDUWW44P3GMtRi6NMoJFhwWavOpe4DE24GGcmshEV90BBcVg3mqbsAfcWOW+i7CVjENTXvWVgxPoumgmJbffHv7ilO/G/8MKqY+1JTHdkDgPZzQQa3IfyIND/52+/nOcxU/bSyUF512IyVQQ5S1Ju7prLZajasnp0KnOWzyfyJP0gcme8VAPx1SqWsjFQDyQmIhf7WvOtUovO3yF73nIIApf37detMmmJNU0NIYgH8xP6C62AMI1DpoSAs+/MrmUtVJMm5h+mYv8tlwZEpuj8kfo3Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=An5KlVV+InXoXZwKojBXb8mOtKBbQnZ2ggtVyShab9s=;
 b=jFcZ4H/GCut0Oet2IDdVyYAHlvV34GewQwtj6V3tU0hFTyOXjKClGenTE9xwbH1fWA7yrAATAAOcG7abNFSOJ+t9Izja7NMEnONQnsbOiafOi1Z8my2PcvFtF6AWIqXWfdJun2W33mTjPp+CyJJjpKki5WRM2vInKe3lN6h1u65cEEJMjzEZRgV6tXR6mOLXwaNXta1K7XKtQp1O0b4UwHu9oyq9fHo06Poh6PG6+Frnlo5gQhXSZRA2NeDo5QlsoUIZ3WMRMlKRmSjl+a5yei96VzvcI7SRWw1wTnrj74Q5UWp3sZZY+69IipnmG5pmbUYk1On4p6/5R6sQ5NpBFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH7PR11MB6030.namprd11.prod.outlook.com (2603:10b6:510:1d1::19)
 by MN2PR11MB4693.namprd11.prod.outlook.com (2603:10b6:208:261::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Tue, 16 Aug
 2022 18:28:08 +0000
Received: from PH7PR11MB6030.namprd11.prod.outlook.com
 ([fe80::300a:e5c7:e79b:9a36]) by PH7PR11MB6030.namprd11.prod.outlook.com
 ([fe80::300a:e5c7:e79b:9a36%9]) with mapi id 15.20.5504.028; Tue, 16 Aug 2022
 18:28:08 +0000
From: Aryaman Gupta <aryaman.gupta@windriver.com>
To: bitbake-devel@lists.openembedded.org
Cc: steve@sakoman.com
Subject: [PATCH kirkstone 1/2] bitbake: runqueue: add cpu/io pressure
 regulation
Date: Tue, 16 Aug 2022 14:27:55 -0400
Message-Id: <20220816182756.497376-1-aryaman.gupta@windriver.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0104.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::40) To PH7PR11MB6030.namprd11.prod.outlook.com
 (2603:10b6:510:1d1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb3e1ded-a1c3-422b-0166-08da7fb5111f
X-MS-TrafficTypeDiagnostic: MN2PR11MB4693:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	DDmzGg+dN/ipRuEmDGA2MEiqDtOAd87fblb+zNeIellmYojJsuiHiWjE1+3qpdbDxKcOTahDQfMRAarFrhHo34mvKs4+/1a/iC+PCCDHy0EkfZ7ZUuo0mP0eProkFgJErcAfIMvtpMgs3jbfoc7tugZySWMO6Q0SfiGuvV7ghzmZah1BiKpTMjmWoqxEzA2r4g2hSukdfk5H6+X+awcxjcQ48W4OK2GeL9gUCAFL1rSZW+CuJ/lwYPog8CUrW3+MibW9XTKvN+yzCmWaSoby+HpKCvDzFPqjxsjefGctUNb0GqLPywQHyjRtkiDnlCeBCQAnGdUa91XC2XPXkKePMO+LjNQwFrk2OMhhvLbuIiDm1cllZX66R+CvgnoWHoy16YQugBjqQCM7CIx8/tLUwflVFHUp3fLEQCPxkIEU8MzqJREJ+P/+qjW5P/x6sQhtTbxK3CbZrjYC+hC4C9+28Of8HZR32oEKEi33PFCFg3jk+WYkbetEQeUctSf1EAPbJ3rKl1Pm8Q6eWzob0nsd0X1vhsg4eO27niWPoJeWcnbTn3Iu3FLfmyBncZQ9fJ3PyuWXinkuHN+r7I4ckLS8sY/suoa/E595CEgmtXboDNGDPt0batnCTD87PEuxg6vaMOOdvewnzCJcBBEuT+BFn694JhyAkJGng6pFPs7Gl6vSfnFwnoFm1KvyiSMvrsLVGfCCVwly/BvrExR9Td/Y0ckvH60SjLDQBzoznMy1bdhhkh6abQPIjMlG8Fl10kynE/XhrItr/gVYt1/OZE5hV5W7WJltiSyytAS7VDTnS7c=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6030.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(136003)(376002)(39850400004)(366004)(38350700002)(38100700002)(26005)(5660300002)(66476007)(6506007)(6512007)(8936002)(478600001)(52116002)(86362001)(6486002)(6666004)(41300700001)(8676002)(83380400001)(2906002)(4326008)(6916009)(44832011)(66946007)(66556008)(316002)(1076003)(186003)(2616005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?f6ZkTEZNlTQK+8qdD6O5O2Dm2D+oyso4a155ajyEUAbDbyLv9MkgYegeBT9y?=
 =?us-ascii?Q?QCiEShY20Di46Cw0CFZbzYO1Lw0MRWM0Kzdmk3UGP9va0X+WxYKaBi1CvqDN?=
 =?us-ascii?Q?FQtsrWK/6Sjgz0IXPHBa+a0MNY3MjLfFkEL4uzgbl+KZifju/Xf48X8UnF21?=
 =?us-ascii?Q?/NhjvAlgpB485F5lUrLLUyyv1K7EazIFPs1K4/oYwmW3Iv7YRD7ESVFfOhbW?=
 =?us-ascii?Q?To+E6Vy1+kFJGSYVsaIt94EG8oZ7lQIwz9VWG9nnQu+/A8tr3iREtssFkbre?=
 =?us-ascii?Q?B0LDutFI4Gzvmk2uZ7goGfXEk3dF80DeWNB+G7cxLnRLT4qRguZqodQWl90O?=
 =?us-ascii?Q?IePRkMMcSicMvHFj0bsyvZhetrV/CF7TlzqttAHmUvbbCR0LR0a+g1dZOMbo?=
 =?us-ascii?Q?ZyFeX0QxxnNTfDOAtpDfFhdJKg6RNp5Qyt/n6lKyXdTEtjA4WAErDXPZA41Y?=
 =?us-ascii?Q?Owf0bmBYD3EJ6U+I+aLWBBW8RiHLa81TRvsumvo4HOPWO7TtjT+Js4+1U8uD?=
 =?us-ascii?Q?VTxKX24pXhivCZALRchRtacAQsS1PdY7HleQBXv+wsF2rZW/dso1OO+ILBPe?=
 =?us-ascii?Q?NsGZxFA+rtJfdlvzGrEcg6H2UZrTb7mpxGbQG70sVbUXjNVNvM4dyN//y/eC?=
 =?us-ascii?Q?4egQptWPzMl8lXjsxm5fAFUGQ+V/5IJ6zfbdS+Ra+4sTHfLhr4J6sd5SH1vm?=
 =?us-ascii?Q?+8PyyJmAVbC7qOqDgiPuWZWo8BeY1ejtQ3NLuXuMWQNiWkBklBtlHaSLE1Jl?=
 =?us-ascii?Q?BGX0PopomPfeLJ3++mNI51GTFUlCAQvOs7M4uGjoE4mb5wJIIPV0AOwhfz7l?=
 =?us-ascii?Q?ScL+p/Iu6l/VPUc3GDZ1Pn/LR5rE+KfCZpgKarFCeogcYHMcubm2TFosmsjj?=
 =?us-ascii?Q?GhfV8plON1uzffUIoc3XVfSnMMHskpW3tKW/uwE/7dAwNU5fOJEcWXpx9M+7?=
 =?us-ascii?Q?Tdyt3UCtC0F/IhwG0odShsg1hA6ihQgtDV4DMaNzVkvLSyhdB0TnEMJcGkLP?=
 =?us-ascii?Q?a9K1HLyF4UMahW+A4MAxDWsol4fIetZNxMOEsuyPYaPw0UpamnwO0XJhCqaY?=
 =?us-ascii?Q?34dwRlNwN/oWO0EesMDt96vUlW+HMpbYKgwI0IlHeBk5jAFxbID2qhkaBM8n?=
 =?us-ascii?Q?NG7/Td8ia88AiR4Uu/CD2S0ObziGUdc38DDZ+UcGCE3bmRarxmxN0c7Dj8xh?=
 =?us-ascii?Q?2rZvoYG2jGkApPZiM5S2npAR9uc6pZ2ib8yjpZNfZaz104HEEtw42txSXjfi?=
 =?us-ascii?Q?OyaOXm/9Gqh4ndCdnA3tKoYYTwDQpZLmJ/8AcUsKT8uTi/569NCRNyVH44WV?=
 =?us-ascii?Q?Ocko+53+6/veIIiZOveTjJBe/HNL7GbyESaS2pa5L4YnAUy4oQ7mmo5f7Iwg?=
 =?us-ascii?Q?SnR+xIp2RLTwWdeo/kyRgT8N+C4hfaIdiwHMfY635S8qM5UQEEv7K06pOc4n?=
 =?us-ascii?Q?fal+S5nxAoqSF6akSY07hfeNY8jwzat/gVyF3K5pYmp6cc75UBhhpjOHkmp5?=
 =?us-ascii?Q?nVWNS8VfrT9D6v01PszUBKMexk6jVVD+Bm428VVmnj2iaLLf5hE1nviM2M8R?=
 =?us-ascii?Q?lydfaqmRZ7KKFyoN9oHZFbMKrIL8lfhsk1UFGcjdcmMez7a7YPRaWcIBYtdm?=
 =?us-ascii?Q?UQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 eb3e1ded-a1c3-422b-0166-08da7fb5111f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6030.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 18:28:08.1117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 oXS3Oo73uT77AZFYWEgdzgJ0MRQYV/oyyzu2TYjP0ve3lzFsmmhWZRW5gHHbtIstkRwBOLKGMV5wM74AQXT1uZ9hwwFLc+cNHvDvi/slUS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4693
X-Proofpoint-GUID: 8wlEKczek1BWHRp_rl229FTSKgUvKoOO
X-Proofpoint-ORIG-GUID: D_8uBxUoeFvlTuC2vVoUmC-0MvLp0Y26
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13897

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
index f34f1568e2..203ef8c153 100644
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


