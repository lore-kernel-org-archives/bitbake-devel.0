Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EB1C433F5
	for <webhook@archiver.kernel.org>; Fri, 21 Jan 2022 06:53:07 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web08.8591.1642747986459794649
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Jan 2022 22:53:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=lJ1GVGjR;
 spf=permerror,
 err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}:
 invalid domain name (domain: windriver.com, ip: 205.220.178.238,
 mailfrom: prvs=8020d4495e=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id
 20L6WJkA030616
	for <bitbake-devel@lists.openembedded.org>; Fri, 21 Jan 2022 06:53:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=from : to :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=PPS06212021;
 bh=OXiPZvs4m0hlL6joSuJpGePbBTNgwLnNe7iQjWqYCI4=;
 b=lJ1GVGjROvHIDOsW15mnSrY/u/m92CrJKunPQbt5xVG0lK3a4rCXfzYfS3L4je/DkvK/
 OQ80LhscSKcrYYERx/kWyqf25JDPi42bZUw+lCwRJffYYtSX4VrsdyMGrLpd7/ZP96D8
 5Zhf3A2pb90Bp3sRWZi0cnbz29GSuMe0W2PBt0XL9U/t+JqQ6M2cewEtl36eUccFwuf6
 PL0kihn+Dm187Fu3e1/lD/FwukkVxzcui3Ayw/nMic+pDoBWsAVimFfPTtaoXiBqqlet
 St3w6SrKmCR2/ka+eMOcazVy3SArUMihPdqaZO6xgi5rOHXQQOOklqaT3ItR1bOTfim1 PA==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3dqhx0r5uv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Fri, 21 Jan 2022 06:53:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzZYt9FvLNgz2SPX2s+s/x4QBtfvZlHfOW8VFrECBbt+z3cIW8Zj+4C/F2SaRKbSkbtqMVCz0vehvWmEhtnMJRtK3IueYXDwyva5lgqd0TOlYLWrp0RUftXbDGDYYKnasJMRLN3Tpu7YAYVBcl4GVyOJDsdDH1xsELMXQpOzXh/mLoePDrw+5xm0Am4tBhwSK7xhM2xEw/D1/HKmO+y3UBHvwX271cKnsZPRc29XMR8Ni6MwIulLiXlwhjO5mFnkSISCWWHo51cEaieP0lL+iVVZjwnzD5JTAYwS4SJGS0ulV3aM/WA15WHZb2ZtgOVWCiw6aI3Y3Wlj9IkZxTukCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXiPZvs4m0hlL6joSuJpGePbBTNgwLnNe7iQjWqYCI4=;
 b=FN3R+mVxp4t4PjS6HamdRMJvvrCnGisAwUyo/ISJJPSiBt+NSuZV1lfnBtQekGNpI3XPXAUanv8P5y1LSoQu/s9+UsUsK7aRF9vUE1jKaEA++X+ioP8zxs9rrl/491Wm1CW+JlCGG7KaA8klAEu8s2KL50Zr7VsnQHTsXqacWVohG7h3kOIB3KNqQQ9QbrUiP7KrLfQxJW2AWDcG/DDMr7akxO+zsLK4eDwiyCQa+v6j8xApWfjeYWNBAvnkm4Zoe19eBL6fz9H83Wi9gwvX0fmA3dJ4ACnySH2oEIDZjVdDvXmlsOaGKqau4d4IAEZaP03u8G6f3zhKGun5TeRvSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BYAPR11MB2789.namprd11.prod.outlook.com (2603:10b6:a02:cc::11)
 by MW3PR11MB4715.namprd11.prod.outlook.com (2603:10b6:303:57::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Fri, 21 Jan
 2022 06:53:03 +0000
Received: from BYAPR11MB2789.namprd11.prod.outlook.com
 ([fe80::5cb5:e426:2e48:17ed]) by BYAPR11MB2789.namprd11.prod.outlook.com
 ([fe80::5cb5:e426:2e48:17ed%5]) with mapi id 15.20.4909.012; Fri, 21 Jan 2022
 06:53:03 +0000
From: Robert Yang <liezhi.yang@windriver.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2 1/1] bitbake: bitbake-worker: Preserve network non-local
 uid
Date: Thu, 20 Jan 2022 22:52:55 -0800
Message-Id: 
 <43c4b99b0f28af12d82fa5ce659b2a84798c22d3.1642747927.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1642747927.git.liezhi.yang@windriver.com>
References: <cover.1642747927.git.liezhi.yang@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:40::33) To BYAPR11MB2789.namprd11.prod.outlook.com
 (2603:10b6:a02:cc::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fa71da7-7681-4895-7a1a-08d9dcaaab50
X-MS-TrafficTypeDiagnostic: MW3PR11MB4715:EE_
X-Microsoft-Antispam-PRVS: 
	<MW3PR11MB47152626EDD57566386CFC90FF5B9@MW3PR11MB4715.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/7r2mIn3Xs8sXZDSRn6CaaJWrJTli2T6QfvlnriJNbKPZCtZrTqvJihDMAS8lzm6vGwRDdNPMoeHELXOzgzYg3/omFOr+Gb4xoOBSevdmX5G7hKc7QUueg0MkVYHVWGhzT1iyr1V6OMTPFL9i/0RypX8avkKmxpm+YLH06fx5+2W7ja4Ccdmsq3fcTWYu/aFkj3sCzy9bX+E46Fp/rhnVo74Os9M6IodLU/mPnifUJFWQrsDhD5YNKOggT6ttxWeQj22jxeGhN3o2caahdZXC35SvQ1peOns7jkmaf+y/9rHnQaqJE5SZte9fsDq8bmwb57/faYnIB0URRp4WYKmtUjDK2Oc6Gd6oS45cf4srrWNa+Gw5mm7EytmN+Q9QY378cmP4XKArhOPrJcBvcqdfrKHWnppNOT+rzH9Ig2fwACdU7CQdHpVrBhv6KMm6FoyxHzKEIIo5LkzX7J4XsH1x9T1f3d8RdtHjt5PGw4PeuLPJLSqW46Pk9B75lwbKOE9Emv+IcuVfiRI9WXrWLSyvCVHIUYJsa6myNRQeIOYqAl0cswUU5/Q4Xh5nc97WSS1Cfzy5I5QKcSxom7zVfLmnaHHGEArHEDX/AF2+VFBjuXoIuoehUQK1d/ooGW4iVMmAEFxiTZIjVpyW3oP4DgizbzPeorSHE4Sinuhga6P4DzVzXX4Q7SJ2kckSV8pOcQ1Goi+7tiOTmTLnqh2jQc4ww==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2789.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(6506007)(6916009)(508600001)(38100700002)(26005)(38350700002)(52116002)(186003)(2906002)(6512007)(8936002)(8676002)(66556008)(66476007)(316002)(6666004)(6486002)(36756003)(83380400001)(86362001)(66946007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?IGKGCI2bG171TwtlkLJXh4DjvUL/Xkutxabm1nyaKIOyhdhufAA7/26yAVD4?=
 =?us-ascii?Q?Dol+zDmwskK7Y7yagIBxvoSuLQhF2eWfgFmY9lWb7PZJ2DN9xaayJyhueRx3?=
 =?us-ascii?Q?+ivGQ4uyFVx+BBVHW+zUNwsyVBbu1b3B2x8cd0fxBbICUMtwSUmSoZ0kTe+E?=
 =?us-ascii?Q?e4yZ2wxfpDqRpO46pq8ATJOtf33ubqwJS864cCrO1Hw6fnO9GvWacu/EBWnO?=
 =?us-ascii?Q?K37M/1BMN8rnOUsXDpjol32s4ToIVJ6s9ZRoqJTSQnNENsZknmIk9cEdLy4L?=
 =?us-ascii?Q?Gh5+XvtHBwEQqVptfV9MHcOU4XyiQG9hx3ooS6N8dnds4KKOSu9uH3D/R/PG?=
 =?us-ascii?Q?9amvEDkdBuF7Sk/pGQ5vgGGfUF2Y2IR8ycre5V3QCWHJVCUB3y6IhK+W+FIH?=
 =?us-ascii?Q?ulxyV/ImtsRpWH392VjDCZNFybf4v0QJPuImnz4xpoyvtpNkopIRtHlwvzZv?=
 =?us-ascii?Q?o3MM31N5AcJAozUD+l8gCa2d3bIEAgs0gTib6Ji1M9dqAIEMgnCTPxL01TI2?=
 =?us-ascii?Q?hozuBnszmFzUbBvUYDAkQUEEObzsBCpvPXiATbsHaqaTRw35ebbwGFM9SBQM?=
 =?us-ascii?Q?srf//G94HYjRUmGsSOclFpayYdBOOcmNLGXDTr9IztbyRwKh0/hBXNNN/6q0?=
 =?us-ascii?Q?kmTnfN2oP5UdPB6r/z8IqZke5Zs1Rj5GMk2BkhFtL16WMj/Q7G5IAa+2iFlu?=
 =?us-ascii?Q?rqNF1F8RR+4FKQ018hXnAUUJZ6Yx4v2oBdmr74wkmMwq1cmR91B7G2DOIwOr?=
 =?us-ascii?Q?s1Oe6O3UMePOLmeHl80IGfWurKTeDEYjQ4TcPl5vpkXKQ751nZ9aQ+N6iYKa?=
 =?us-ascii?Q?zSvBB1886fVAo7d5o0XcDyALr0HFQtB8IiJZ8Kb0KMSzBOIac4fAo6Jj9gFl?=
 =?us-ascii?Q?TYzRY3LocWufAgtd3Hd6/Jr3QHvzUzd74SsKeDPrhHGUM7dcWFur6poyhow9?=
 =?us-ascii?Q?DMpzM1v6KnvV8cZ5i8LoDvAgUxApPkAwrw76Qqy5xIb32pgEyA1+jtztotVS?=
 =?us-ascii?Q?J+rW2O/kzGnXBY6a5Rho8C+GyLbRGO+WpauQfEfVYAPscy/FMIRMq5JgHFiP?=
 =?us-ascii?Q?iJHrJ/hB8a4PhWgc1d38AhkxRxcxbR5efcXOPeF7N4rymjwLNPBhYy3Isq+y?=
 =?us-ascii?Q?laRJdr7Gi6O0rovrfHgRYnWzrj3+3l1H2aVHb1XvYjGt6V5TIYEaHv+eArUQ?=
 =?us-ascii?Q?52fo03n+d7SKU98c7pO9FuL/mC7d1yOIgYywJ8jvJu6WxIH3O4XkTuYBUhW4?=
 =?us-ascii?Q?5oTuVhCmMaE0U/4TTIGqtPSm1rzf2PMXwRwwpQ3aqWRCbeJK7i2aAQGWFu59?=
 =?us-ascii?Q?vEl7L17sTgC0AcN90hyR6Kj1btGtyipu94XDcb7ooH+faKuEQepFA9qe4FGj?=
 =?us-ascii?Q?UP9FCEtIA/Ae5QbLPrKbllCPFZDOQS5ZnLdgsRsG6rVTUHqF7Can1UUwVpV4?=
 =?us-ascii?Q?2htPgueHxT9HE5nASsdbHpIjEWEXF4JlaFO0pl7Mo7jucz9wn8JYzjgNr+9i?=
 =?us-ascii?Q?pqf13VVfofcT4oTaNUAijmbcUMpTZ/91uhc1elgDeLGxjtC6cgezIFdcRsXr?=
 =?us-ascii?Q?c5A0AHv9sPa8VgZWBV2TWQ7VEB+BgDSyhLwf8A4ndwDlAb1EeOhxtDMK5zEr?=
 =?us-ascii?Q?D70lkVZl/MsGB+wyza7AWSHBQV+fMrfeTE+PZtamwuMLtfr71t0/hTi5y21p?=
 =?us-ascii?Q?LOy2X4IGKto352iFyDF5FUBErKw=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 2fa71da7-7681-4895-7a1a-08d9dcaaab50
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2789.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 06:53:03.0114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 d+l1HFo9PMelCXdu0ZQLTlB4xlFVFahEsvgyVlnpe05oipBWNNtjAeeJo7h4oeGgQijjiXqxJIxfjZBy8657ojhWQuslH3qEpJw4hj2/b9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4715
X-Proofpoint-GUID: 5Wd3lm0jLxLxevBVXcPgMt9CWcc4x0DU
X-Proofpoint-ORIG-GUID: 5Wd3lm0jLxLxevBVXcPgMt9CWcc4x0DU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-21_02,2022-01-20_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 mlxlogscore=851 mlxscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201210046
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Jan 2022 06:53:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13266

The NIS can't work when network is dissable, so preserve network for it, the
error is like:

do_ypcall: clnt_call: RPC: Unable to send; errno = Network is unreachable

Note, enable nscd on the build machine might be a solution, but that isn't
reliable since it depends on whether the network function has been cached or
not.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/bin/bitbake-worker |  7 +++++--
 bitbake/lib/bb/utils.py    | 16 ++++++++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
index 3aaf3c2444b..063cf379262 100755
--- a/bitbake/bin/bitbake-worker
+++ b/bitbake/bin/bitbake-worker
@@ -262,8 +262,11 @@ def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, taskha
                 bb.utils.set_process_name("%s:%s" % (the_data.getVar("PN"), taskname.replace("do_", "")))
 
                 if not the_data.getVarFlag(taskname, 'network', False):
-                    logger.debug("Attempting to disable network")
-                    bb.utils.disable_network(uid, gid)
+                    if bb.utils.is_local_uid(uid):
+                        logger.debug("Attempting to disable network for %s" % taskname)
+                        bb.utils.disable_network(uid, gid)
+                    else:
+                        logger.debug("Skipping disable network for %s since %s is not a local uid." % (taskname, uid))
 
                 # exported_vars() returns a generator which *cannot* be passed to os.environ.update() 
                 # successfully. We also need to unset anything from the environment which shouldn't be there 
diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 0312231933b..128b3ab5708 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -1735,3 +1735,19 @@ def environment(**envvars):
                 os.environ[var] = backup[var]
             else:
                 del os.environ[var]
+
+def is_local_uid(uid=''):
+    """
+    Check whether uid is a local one or not.
+    Can't use pwd module since it gets all UIDs, not local ones only.
+    """
+    if not uid:
+        uid = os.getuid()
+    with open('/etc/passwd', 'r') as f:
+        for line in f:
+            line_split = line.split(':')
+            if len(line_split) < 3:
+                continue
+            if str(uid) == line_split[2]:
+                return True
+    return False
-- 
2.33.0


