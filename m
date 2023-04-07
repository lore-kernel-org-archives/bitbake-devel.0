Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED82C76196
	for <webhook@archiver.kernel.org>; Fri,  7 Apr 2023 03:07:38 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.69.1680836848864336673
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Apr 2023 20:07:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=KbZeCVMS;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=3461ef5591=qi.chen@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3372iTZi004635
	for <bitbake-devel@lists.openembedded.org>; Thu, 6 Apr 2023 20:07:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=mAiS3YvkXC5rKt7c8KFvpBBCUnIOoarFZF7cQbIfHHk=;
 b=KbZeCVMSHC5Et4hH46FeLVuA9MjPlODyBPqul4Y28ZYfRXXlAuDvDv3xMywqxlLpAxFa
 gV+DNX/5aEXXHm4p5Va7e2sjJo1z0yR0V+ZjLtbZ6ptcfgrnrSisemAYy/IrC1Y3NcXR
 j8OMLrr5fsynaEI1PPdr+R7Zq6uhb6grPiRSlufQToyIbJ+OYEdwWz1Fv7bxTBQPNQDI
 qsdf7WAYSUPzLF/z2ecih5C6jLDTGKfN1vBd9+2WTFFy8i/Q0lawMwGCzEOSzQUaDPNm
 GhrP9bI06FxqzMG9oIeZBFlh5IqWpmylE6KxkE+g2SWqucL1oJcg1T33R3A7o9hzPGbu vg== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3ppfw6xdaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 06 Apr 2023 20:07:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpnVPYsU6nf3ld3Goav5m6z+PuWnf+9vkIgnOj6jFEt41rVVhmIC2Wlb2SrfFV0rtwGZ4G48Y/bWgDzkm0Qeh5vFQZdFRUCEHRZ/Cb3SLKJDHH8AK/2kqVn4PiWHxznsgBlNlRXq6XHVX8RDQk3rWfZsPkjdHGx8ByRymFHT+UXmwqMCpgoH4mRj7+lg7gG0d41oYfguZeBamfzE/js5yw2nx0B6nq9vS6LlVWwQek3f8TDQH9ZrLts2WteK1UTNqRVQHVBy0WwBPtM5OmpauaeiZPxKcXIYc1y4aNad9bXOr4Vv7sz1a6qcax7w1Ydq+j4E7w+MyYmrUTrgRR94rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAiS3YvkXC5rKt7c8KFvpBBCUnIOoarFZF7cQbIfHHk=;
 b=Bj5CCqp4IWHa0X0/KZjMBDx3b7xBW9+dc0p5IIruCJB4c+t+KAYpQQDQO7B3aMJCBwEF6kkbcrAG8tawAaIM3mXmROlLy/i0Q1UaAwooFgNEK66s+Jwbeg4jx1adymffyHyUGkD1WG4dTqXhzjTeZ3JJBq270BafAMQjPaK/zR90Yu5QLXf/jdx8Bm8WgJiXI2Y/rwYmGwT8pLRhokL+18mdQ/N9rJMM7tqCnTF1KJM3m1Jn0T4pG8mBQxjF7et/HIf4UB5kvFuSsOC0F08ZUxFtJn5Hz9az5ary96zh7fqZy70tFu/ATaHtqHB4VmHJvi4dl3zjsEsoryOPdoXVxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by DS0PR11MB7829.namprd11.prod.outlook.com (2603:10b6:8:f1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Fri, 7 Apr
 2023 03:07:26 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::ab37:4985:7b95:2b95]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::ab37:4985:7b95:2b95%6]) with mapi id 15.20.6254.035; Fri, 7 Apr 2023
 03:07:26 +0000
From: Chen Qi <Qi.Chen@windriver.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake-devel][PATCH 1/2] runqueue: fix PSI check calculation
Date: Thu,  6 Apr 2023 20:07:14 -0700
Message-Id: <20230407030715.4394-1-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0095.namprd05.prod.outlook.com
 (2603:10b6:a03:334::10) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|DS0PR11MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: accbe6e2-a038-4aa8-4af2-08db371536da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	d04r9+OAQEiKUX0wfcILqrA2stILOtJlHXv/rNvsh0HJ4Lp8+XWh+Dl/FmbdjDACNhr4QgWm67uGkowpFgzGsz2BioaTq5aBPkUxe2sJU5u7O70dO955e9xwXqSWXAqnAQnmv8N9mCK2TCzwuBGS+TdA8084Pdnr6xsfbQMb2fKtnjReMj4wSpFuQsJH4YWOpNnEpZC1fOvAHqP0CCMwIuTtyfIfMd6UESReAW1rzejQ0wg1H7bEeS4e1k+zb2oT+JAwQoKZGkhgaHv6+ekF3M/jBSGng5KP1KD9yTeF5yM09Q/N7SEXzK8M+dYIlTSVrdM1AL9FOZDXUkSwxuwPNKN8cgZHdhghf6eiL5hAXlnvR8UUfUQaviYGmNYy0dHALOEF20p+nm9eZMC/Lx3YrTpSjYeRE+kswHr8at2t6xIvOtMjq0rRkWi7/ALek93iZkGYyGA1Q99GT4rpk8aqNPb6j4z2td1sZk5lLJmYF9UPe3O1JgvqmWvXpjHoYkeOyNRRzaAQwQJomnrGgycTXoalTpBJuaXwsOvUluLISgtLVYLFVP5eHzhg59Tr1sgc4pNx3S+X9DPcLk2xvC49lYR+EYhW/KIcZXuYrqy2uPlsSr5Yc904eocOxGxTc3goNWN/8AV4/o9o9P7hySpkzA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(136003)(396003)(376002)(346002)(366004)(451199021)(2906002)(86362001)(36756003)(2616005)(186003)(6486002)(6512007)(52116002)(1076003)(6506007)(83380400001)(26005)(6666004)(316002)(66946007)(38100700002)(66556008)(478600001)(66476007)(6916009)(8676002)(41300700001)(5660300002)(38350700002)(8936002)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?z7brm/RUnBI+fB7UBsUtiELlGYE1ER6ApZdqQMA2pwEKiAN+CMOrTN/Xm5Ef?=
 =?us-ascii?Q?oo+EDs8/M0TfFVu2lufaR5dQLPJ8s5ZxlXdn2PVwnNrDFXbiV4e4kBsYh+yi?=
 =?us-ascii?Q?qPALQ3jhUGCem+coMlkHeX3oSqu5TjxSxbCjeQca3r04UK2QmtIjWFtZ+wUm?=
 =?us-ascii?Q?V0/DLsjbToQl77UNObDwuXH9SAxS3LN3vbzqkP2sw75abupKoiWuTTEviMiX?=
 =?us-ascii?Q?4OdkKxTWGw5UtHN2xuviT21gxSo8JwqJgh3VtlyK8GKgvOj95AMNI0Vd7VbG?=
 =?us-ascii?Q?+w60AK2PoIGFbugYF+7LsBRx0ZVeqVY4w6lFNrXU7jom8RDNhugqFci9mdrj?=
 =?us-ascii?Q?zdeSe7J3HKDi7MjOjTbDpK0knXp3AFaTTK7+sjFhGzoYmiRQj0U7D7Uxw0PH?=
 =?us-ascii?Q?larjGgNY0Cl1E8/GxUUxymgv1v2G/N0ljEwnpc19+ZSgfjklWbNWRA/TKnCX?=
 =?us-ascii?Q?h79xyW1yeqY/Sd3JImX0WlErH2aHBK6Vk0fLSQheoa+jkdK84t/CDhJcQByS?=
 =?us-ascii?Q?iR7I00YIpaCdJCmN7fN5EWTVn7duBWTTSrOq9EQklOd12aLA1HJlkDmUumpT?=
 =?us-ascii?Q?o7Z/vJI5QwZSzf3uDH2aW0Hnt2QLOJPrNUwAwuoRrEV0k9pb24hi5omNNERt?=
 =?us-ascii?Q?2touZhQYVCpUGd//ftwM+Z590cN7exweKhxRz+Jw66essQvogHKc3NpRLrd0?=
 =?us-ascii?Q?ud938yDoTfIOYVPh0WkbujvZPWvUtGr0uMhlMA6JIum0ZbyzfNnNVFn1XHaP?=
 =?us-ascii?Q?XyU2ja+E5zK1W4bqPbZ6Ca57GCoJzhaQ008kB5XzDXmDkM1nom4d4zSN0awP?=
 =?us-ascii?Q?7mSA7lMrIXkayl/WmE5VP7QN/wA6uoRbaDeXCehJnesc8tWYmpJKpuLZ/7ve?=
 =?us-ascii?Q?aiOArE++53kK8/ja0QeriPuWiZqICsyML7cNJefkGraDA9O9wxrG9WM2TYTT?=
 =?us-ascii?Q?lWo2XRt3j3e4Sfj40dyOGO47hf34g6+POpjw1p0+gOgsKCH6NgaMm8XtElXd?=
 =?us-ascii?Q?WGkTRWgiFIaSW6aSn4IV/91qPYvooOTh/9TjAWpUnITBZf6Zkpfi44XXXqmM?=
 =?us-ascii?Q?U316sJMtP73qefKB4AS78/3Hcw/vcvSKNrXEJle+AOEPegEh3Spgjqv1wqgK?=
 =?us-ascii?Q?aIHc+hqL/THHuxdES/Ae1sWWyGrf/IF3wAwrVI/RXcolAtqMfA33sHUtPkT9?=
 =?us-ascii?Q?RYCkEz/U36C8j3AmyP8AoJqpKDAfTUXPPHF+zQHMASInOg+wS/AEATb34fjC?=
 =?us-ascii?Q?ibgbF9QQ+xNy54riVifD2IVihMAgYgY7tmusQ4U3CGGFEoMoP/C3ebwxPcZP?=
 =?us-ascii?Q?VZGgLgNfhH5BHYr2y+Qik8ICT0MByZH7NqNbIs2qqv0AYjytedKfUfTyQLLN?=
 =?us-ascii?Q?rhWb2ls1BVeKdJ11jEN5Vgs2wCioPwfxdSkil8xoynahl9o0PnjH4DDNDLZH?=
 =?us-ascii?Q?Sm92CBZ8K2pm8mKUSz5/CSTonvn2qtu8SVqlbXvgK3H2pG/hCmHj+eREBYDT?=
 =?us-ascii?Q?LazFZVp+h6MkbU4lKRTtan8vWCKeVWi3DkCo6cSY2778vcQXcTuSXld89tbF?=
 =?us-ascii?Q?QNTU68FuNVzMNPSEe8N1HVobcnBbi1UNi/6F4IB8?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: accbe6e2-a038-4aa8-4af2-08db371536da
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 03:07:25.8753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /GoyBLTIDueFmjPV0BZS7Nxvt5eff3oZ5x9a3bKKDsD/wR3jtuUpDA9m54bu+G6eVvjfpqKZ+lxpqLrr5WooQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7829
X-Proofpoint-ORIG-GUID: B5NMD1lA70RTnrlzggYWmxdZNNFDsNPt
X-Proofpoint-GUID: B5NMD1lA70RTnrlzggYWmxdZNNFDsNPt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_14,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 clxscore=1011 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 adultscore=0 phishscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304070028
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Apr 2023 03:07:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14682

The current PSI check calculation does not take into consideration
the possibility of the time interval between last check and current
check being much larger than 1s. In fact, the current behavior does
not match what the manual says about BB_PRESSURE_MAX_XXX, even if
the value is set to upper limit, 1000000, we still get many blocks
on new task launch. The difference between 'total' should be divided
by the time interval if it's larger than 1s.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 bitbake/lib/bb/runqueue.py | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index e629ab7e7b..02f1474540 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -198,15 +198,20 @@ class RunQueueScheduler(object):
                 curr_cpu_pressure = cpu_pressure_fds.readline().split()[4].split("=")[1]
                 curr_io_pressure = io_pressure_fds.readline().split()[4].split("=")[1]
                 curr_memory_pressure = memory_pressure_fds.readline().split()[4].split("=")[1]
-                exceeds_cpu_pressure =  self.rq.max_cpu_pressure and (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) > self.rq.max_cpu_pressure
-                exceeds_io_pressure =  self.rq.max_io_pressure and (float(curr_io_pressure) - float(self.prev_io_pressure)) > self.rq.max_io_pressure
-                exceeds_memory_pressure = self.rq.max_memory_pressure and (float(curr_memory_pressure) - float(self.prev_memory_pressure)) > self.rq.max_memory_pressure
                 now = time.time()
-                if now - self.prev_pressure_time > 1.0:
+                tdiff = now - self.prev_pressure_time
+                if tdiff > 1.0:
+                    exceeds_cpu_pressure =  self.rq.max_cpu_pressure and (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) / tdiff > self.rq.max_cpu_pressure
+                    exceeds_io_pressure =  self.rq.max_io_pressure and (float(curr_io_pressure) - float(self.prev_io_pressure)) / tdiff > self.rq.max_io_pressure
+                    exceeds_memory_pressure = self.rq.max_memory_pressure and (float(curr_memory_pressure) - float(self.prev_memory_pressure)) / tdiff > self.rq.max_memory_pressure
                     self.prev_cpu_pressure = curr_cpu_pressure
                     self.prev_io_pressure = curr_io_pressure
                     self.prev_memory_pressure = curr_memory_pressure
                     self.prev_pressure_time = now
+                else:
+                    exceeds_cpu_pressure =  self.rq.max_cpu_pressure and (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) > self.rq.max_cpu_pressure
+                    exceeds_io_pressure =  self.rq.max_io_pressure and (float(curr_io_pressure) - float(self.prev_io_pressure)) > self.rq.max_io_pressure
+                    exceeds_memory_pressure = self.rq.max_memory_pressure and (float(curr_memory_pressure) - float(self.prev_memory_pressure)) > self.rq.max_memory_pressure
             return (exceeds_cpu_pressure or exceeds_io_pressure or exceeds_memory_pressure)
         return False
 
-- 
2.37.1


