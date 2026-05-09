Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9568CD37B2
	for <webhook@archiver.kernel.org>; Sat,  9 May 2026 05:30:29 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6867.1778304620791242824
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 08 May 2026 22:30:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=mF79XgWZ;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=95895a8adf=qi.chen@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6495U56w2363029
	for <bitbake-devel@lists.openembedded.org>; Sat, 9 May 2026 05:30:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=lUZPcJKxeUSMjDhSh+ln14WTABVX0AL0Rkd8B3lIpIw=; b=
	mF79XgWZo0oKlYj7o488rSKppTnXJdBOz5ZDdwEvA4AwXl8vzbJtNb50SkmVpw9U
	WzrQ9rIl0VsE5e9u3foHi1sBtUOXX2PkDSbLET4ik/QrzrgPvku1iISGu9X14qQr
	XndbrMt4YLmdIOMkSaaSuaDCe7QwuQ3jZYjTlkAx6rWCnL/XQ7Wk/ti+O+HX9Ety
	+fvs8H2lL2ailzD0gvEiH9MQd+K5JUgcxcnu99C9PTM1y/jUZgxEAY/RK15lGcBn
	xYyawK3fUU2IAHof4KFrN4U5ITVkQsEl32jPpSbH9jcrQ+kfHQlyQWo3b1OV7Mh5
	kcEZa3KVz75nKLvd6n4CYw==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012034.outbound.protection.outlook.com [40.107.200.34])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e1uw6g3xq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 09 May 2026 05:30:19 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nTOMPP8jouy5GOxe8tGVQo2481RIU5Gndj+xsfG7qIemUHgmQXbviN9HNLRmaCatVBDe8iS3dN+GCGTXrllxMmC4YW35k9gIo0yM7FW+PAewC44gjaIKQSHafnvu3W+fQheL8je8j4IyF6beOdJgZwziBOS0EJUnTGYIXuQ88Bu57UTEf623rHTWuhi1Q2QyuPxiprgAPp0rGSZqn9P6mbMKcIKVuA2iRnWllMqJmeayfJ+x/apR4ocLrGvSGF+GaXVppXYzF9UDSlX3aEofTtVCEIFUTsm7wdLcV72THahtG++CYaTgPE0+C0s6Grh0SkTeKocbfwvsKPhgdPIibQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUZPcJKxeUSMjDhSh+ln14WTABVX0AL0Rkd8B3lIpIw=;
 b=c4Jf1w9Y7kza6RFNEqZdwIlXTGgY8WdX9WuYbaFYwsEYt7HBTCfT+eTNNA1xvKA32Hpx+JdLl4qCdLSAn5tDRzZVjSDsjTHEURf9cqwJpgLSR9XpmbOEjv2q7bMt7E0lsDeprUo6V7kDUcGjSVCy4ul5UG5LMzkRk8oNTp3M9cgp03o5w/5DKb0S1WPvTLjKjLnpBJ4Zm+WzF0n9cwSTyImZlXf7jJwxdgeJmsziHX/suer7zwh+lJFgS1mVWx0Krw+0fxYpkVbd0hySSkCfzCvlY+SbwZNm7sHGqoln2gQsKT4Y3mDrt1GXSo56nWZVhoY/aZ/a37YdnjeEVygzhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by CH3PR11MB8657.namprd11.prod.outlook.com (2603:10b6:610:1ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Sat, 9 May
 2026 05:30:17 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%3]) with mapi id 15.20.9891.019; Sat, 9 May 2026
 05:30:17 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [bitbake-devel][PATCH V3 5/5] bb/tests/fetch.py: add case for filter_regex parameter in latest_versionstring
Date: Sat,  9 May 2026 13:29:50 +0800
Message-Id: <20260509052950.1565384-5-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260509052950.1565384-1-Qi.Chen@windriver.com>
References: <20260509052950.1565384-1-Qi.Chen@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0087.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::18) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|CH3PR11MB8657:EE_
X-MS-Office365-Filtering-Correlation-Id: 729a6ad6-bffd-456b-1bef-08dead8c0d7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014|56012099003|18002099003|22082099003|3023799003;
X-Microsoft-Antispam-Message-Info: 
	DDhmQZ4LH//NM6p5SYtUgKFyBZYJro/1Iz/TIqfdNbv7QQRsMqCrTYy3EY8G8Hii2zfZN168ilVmoquMsUvtTVERz2SaxdLsU5mayMP328PwZpwpbYqnfhkFVl4XieJDVoXcpFR+caJH8mCF4SG+pjagjPAbB0RG+emefbVzg9PyWQwh+r/xdMD2Hv1pbsWxVh/u79foR/MmuV5f3fpYIK3l0JUPQ/bMhP/U7tCsOXsC/7tOdS7kUZCp3vD8stvQlQwwfBUW3BSJyX+sa5beJ04qgF2yGbdeOItWrEPOsO3/Eqq8irAXiH90DBTxjyMzjeYpn/EIcOuJ9hIVT9BNtJodZXGG5vSgNuNVH5qFB1vP/wG3cgXftmY0kW8oLw8PghVHyq1INxPi195DZHDjKwGQXTQFzs8uvJHgCtmJVdP9MsgrflU/rsdFxlav9ouaDJtp/qpl0XwpR44l0wq64GrEZMw2T0IIlbgmUtRhL/WyqPwnFuPIO9kSuUUGQF+TYoz/v+Sxpqn+VbxQVGyvD8K50j3/c29x3UnXkYEN5goAoNoUt3pP5zaN/naMAWCa5sK+fEE6n4XIj1MtJzYUoOheG9WaqKxMWyJcxAsUk6ACtVwyOdjEmXMIp7vFTjBKuvmjWxLPmBcFH+vJzSM1DKr3ylHvZLzur6mx0uaVPB4wXxZg7SrKU3zeMFqFa77CEv6AI5hl5HRKhFfmrazy+w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014)(56012099003)(18002099003)(22082099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?aVJAvjmrnH/V33RTLGSDceVWhm9d3qED5O8/+Iarhdfx+DVDd9Dlk6F4tbqn?=
 =?us-ascii?Q?3rxAEJFCDvsqK74Oj2mDoXvZ70nq7TcVdgFb8+l/5AjPPv5R9nGkEfqjWlDa?=
 =?us-ascii?Q?yH7ipLP8IipvJYIf9RyhubbB9oVUY6cmctCwZj2FzuSStkxaPwsdymSgTfQK?=
 =?us-ascii?Q?zVtL0vxex+f7e6zS8I17l22THmmg5sRvy805U+rOEjDcXXPnO6QavgZvoMQT?=
 =?us-ascii?Q?oYQeFlFt7PtmvnJaaLehMA8BTGQDbgpCqyQLFo4eBXHehEcflle/1JypRzAx?=
 =?us-ascii?Q?cS0uYqvn0B3fddiU7bNrOFwNHfK5SqnRSfwfUmu4qrpmVkBDKdyYlyuCrAM0?=
 =?us-ascii?Q?2Jt1qz7nRkp5IEVOTMwkDBLr70f5hHzhl5Sxt0nyLC3DYzkmb7CL4DY2hx95?=
 =?us-ascii?Q?uwiclyFdvJEyQwX++IpOTF7XfxfNn4qZCCH34XjaEbYhhTYLiSD791fBJnu2?=
 =?us-ascii?Q?E1DB6RtMzpu9oB4UzRNegXV4iSQnIU6V6tyRiBan3ZdkUYmdEfzifd3eZdC4?=
 =?us-ascii?Q?j9DVVxQ+nrNN1t4G88XluKl1cjYZNvXUI2Gg0582n5Qy7Wqbpp2xM3IrOVkG?=
 =?us-ascii?Q?zth7B0/wT5d9rX/7U9hnSZTZAn0sfrITtNAi4DmF7TRlOPVGkLV4lMTcNKgU?=
 =?us-ascii?Q?8bAKR/iGTtAdxoTvQ8MFSZTZtbKdYvirUSOSGRTDGQM0MUTSweJBZP28gpsS?=
 =?us-ascii?Q?1fjjWkPJPcac2fcDkAvzxhM8Gk7oHFv0L3cvmLllP3waWv7SJOq2tFIXYUwL?=
 =?us-ascii?Q?QCfJYvhYHZVCUKcxz0dH1YG0Tk1hr1xs4thaH0nifqU7XvzXotK3xbwUQ7DJ?=
 =?us-ascii?Q?cp1t++uJkAn9/rV7EKGdeTcvZlesyrYvvL7FGR3dUEgz1uOLzzjaM2iWepi6?=
 =?us-ascii?Q?KnMkN/5QBIyjpzR2w+bjueG5nrCzgpp5KaLNqW3qKDrBQ9hl5E3ItpjbIY+x?=
 =?us-ascii?Q?vJttXwJMCOzKz//Se0CatV3wXeMzsxvcGH+UFL8+fF4WquGdzsbYhEy3MOqP?=
 =?us-ascii?Q?LwovPtFTq/DmoV3y4r2IVzGX9Nozmrhm7cr9PB0AQzv/L/5kgHn0hp4a19nu?=
 =?us-ascii?Q?dR5ClRp51ugHFNupLCat6GHXLg2WSwEdrMBP+FjOjgnGQrQKzjK0CqVPE85u?=
 =?us-ascii?Q?uQ/PpxZvR+o3bcZO7iJEdi50rEhMJTTCYkCuN94UuuJ75wjmq0QifhuDJ3x/?=
 =?us-ascii?Q?6ctdccMFzhvXma94UOaRMgCkq7GxGwqnOTi5j97wYcVkk3MV0CBgTKDVeC4T?=
 =?us-ascii?Q?ki5NTPe5dxhhdZxtgTh/278OASxeHJO4N9eKoDU2H2wA/IxkOAsQ73aox3KD?=
 =?us-ascii?Q?jrt9SruzEtNAK8SyiZY2vc71RBRoJVsnDs27IFvCugsbiHbBTjO31KdQGGJD?=
 =?us-ascii?Q?Wbif3jSLzw26Ba7V18RGIyH1Bes4TCBqqvn5hfSACjYuomYzD/L1Lx8hsp3k?=
 =?us-ascii?Q?8m8JeqDAGnbGKKijASVzMMFGHtNS5Mu53JR0djyaM08zIgYvFHA5OrjaMHyK?=
 =?us-ascii?Q?HTnHMVMLW+FXtTJMKdV/WKlUcAZ0ZK2PYKftVzsh5fbk/E4lYv5R2T2dFZYN?=
 =?us-ascii?Q?V3BF9+tp4/rZTXsZFlpsD5etPQbLAV5uFIbTnHOb3ncDNDTkqVNoJ2YfqBvy?=
 =?us-ascii?Q?E/PjHl3T9zxcdevn7slxd5KX6PrKW8fAGEdlKB0QC6MsBsHmNQ/3wnfoFAjL?=
 =?us-ascii?Q?aiqumtGUR4cgQflXmsIgnoUFIZ7cf2B18Zn9IPDsbO1NvpSSpkPxzOVe8PzA?=
 =?us-ascii?Q?iXBnwm1u+w=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	M+RS/f7qROuHKE35EpuJXRiY2rQiH1qAXmdXdJsTQEp5DzZ8rGnTucXlhKDYYPvOT0ZS0tPKmO6cgLjjAm2w+EVS3d7/y/wpmtyjEK+HibO1Tq8w1+47CUFdx3dzY2bzOYK8cc9UaiOssT4gfu7TPCwVQD4dvgdjsp1JJjbMhtUR9OS8RErQIyAvB9U9CHJBpId1ovklM7Yg2SPCMJ06DMNxs0leUSqWrgNhfQHEYFVVGxohqrhSw7LghmxwkNZGueK7s9CmJlKXtroPzyRIi612yINr2Np1vYxQ271JDzdcxFguvCG6o90b+KpsGf49DDTwXsdr+coHGXg/IQNPyA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 729a6ad6-bffd-456b-1bef-08dead8c0d7e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 05:30:16.9831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Dwq7wRnn1fbL4EDipmmP5qt+lUemyzBIZ3EAa5J4VA0ZIdBNmC2M1TxWJtIF4L2kg6xvTrH/izckweTLCFcnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8657
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDA1NCBTYWx0ZWRfX9yRUt+EzIKHb
 Es5esiO89v25+WQz8zqJWZWgNaXk+zdlQ65sDzG3V6y7erGJLaZ4+9iHHMMAxtZOv+U9qBlO+9j
 0XbDLu0/mmIPCG00W/fbmjy6kiNrANaoPFf2luU4PFCkL2kf8MU7u/bjZMhv2EmYgeP5hXehx9l
 cA1zbW5IHFY3ouEXZ5rAsmluEkI4O9LDgZzngvOelmmJsxRQezma4YhBKkMIbTN5Rkp/I6H/Lpc
 PbMbf3Bc7Er03EWsKBIJtF/X1nheuX4Dq6rd04ixaQL1xpbpBYYCgE3Vz4JGZbObCU9XgD7uHdD
 YKO5PM7XY/E7JXtavujlOeB0J53vJsts1xYwUmhL/Am37nq+jAxxIeItFC7JG24ykH6553/80jD
 ao3Jecg9xBfn0h9Zcor99illL8GnxIsrVc1E50j6EFqHdrILiCY899mjLeuhj6cQyTRv7KAgugA
 70voZxN5ZhiV+4jAZJw==
X-Authority-Analysis: v=2.4 cv=d6nFDxjE c=1 sm=1 tr=0 ts=69fec66b cx=c_pps
 a=9AcDkMntNQwiSFi2uhiI7g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=3tcz3bTJAAAA:8
 a=iGHA9ds3AAAA:8 a=t7CeM3EgAAAA:8 a=NEAV23lmAAAA:8 a=r6VMbn1M5JNI-OT2GTcA:9
 a=4EbjBm0RLgFgoQzmu6QD:22 a=nM-MV4yxpKKO9kiQg6Ot:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: KzaIvXSEAkoMVjWMOyFTlTS8QdipzRmd
X-Proofpoint-ORIG-GUID: TV5Aq-qsn9J42Hx2Fq8RJ9jx5nWR5FvO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605090054
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 09 May 2026 05:30:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19483

From: Chen Qi <Qi.Chen@windriver.com>

Add bitbake selftest case for fitler_regex parameter in
latest_versionstring to ensure no regression.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 lib/bb/tests/fetch.py | 78 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 86dd92992..2ee1a883f 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1512,7 +1512,24 @@ class FetchLatestVersionTest(FetcherTest):
         # basic example; version pattern "A.B.C+cargo-D.E.F"
         ("cargo-c", "crate://crates.io/cargo-c/0.9.18+cargo-0.69")
             : "0.9.29"
-   }
+    }
+
+    test_git_stable_uris = {
+        ("dtc", "git://git.yoctoproject.org/bbfetchtests-dtc.git;branch=master;protocol=https", "65cc4d2748a2c2e6f27f1cf39e07a5dbabd80ebf", "", r"1\.4\.\d")
+            : ("1.4.0", "1.5.0"),
+        ("systemd", "git://github.com/systemd/systemd.git;protocol=https;branch=stable/v259-stable", "b3d8fc43e9cb531d958c17ef2cd93b374bc14e8a", "", r"259\.\d")
+            : ("259.5", "260")
+    }
+
+    test_wget_stable_uris = {
+        ("openssh", "https://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-10.2p1.tar.gz", "10.2p1", "", "", r"10\.2p\d")
+            : ("10.2p1", "10.3")
+    }
+
+    test_crate_stable_uris = {
+        ("cargo-c", "crate://crates.io/cargo-c/0.9.18+cargo-0.69", r"0\.9\.\d")
+            : ("0.9.29", "0.10.0")
+    }
 
     @skipIfNoNetwork()
     def test_git_latest_versionstring(self):
@@ -1569,6 +1586,65 @@ class FetchLatestVersionTest(FetcherTest):
                 r = bb.utils.vercmp_string(v, verstring)
                 self.assertTrue(r == -1 or r == 0, msg="Package %s, version: %s <= %s" % (k[0], v, verstring))
 
+    @skipIfNoNetwork()
+    def test_git_latest_versionstring_stable(self):
+        for k, v in self.test_git_stable_uris.items():
+            with self.subTest(pn=k[0]):
+                self.d.setVar("PN", k[0])
+                self.d.setVar("SRCREV", k[2])
+                self.d.setVar("UPSTREAM_CHECK_GITTAGREGEX", k[3])
+                filter_regex = k[4]
+                ud = bb.fetch2.FetchData(k[1], self.d)
+                pupver= ud.method.latest_versionstring(ud, self.d, filter_regex=filter_regex)
+                verstring = pupver[0]
+                self.assertTrue(verstring, msg="Could not find upstream version for %s" % k[0])
+                v_less_or_equal = v[0]
+                v_larger = v[1]
+                r = bb.utils.vercmp_string(v_less_or_equal, verstring)
+                self.assertTrue(r == -1 or r == 0, msg="Package %s, version: %s < %s" % (k[0], v_less_or_equal, verstring))
+                r = bb.utils.vercmp_string(verstring, v_larger)
+                self.assertTrue(r == -1, msg="Package %s, version: %s <= %s" % (k[0], v_larger, verstring))
+
+    @skipIfNoNetwork()
+    def test_wget_latest_versionstring_stable(self):
+        for k, v in self.test_wget_stable_uris.items():
+            with self.subTest(pn=k[0]):
+                self.d.setVar("PN", k[0])
+                url = k[1]
+                self.d.setVar("PV", k[2])
+                if k[3]:
+                    self.d.setVar("UPSTREAM_CHECK_URI", k[3])
+                if k[4]:
+                    self.d.setVar("UPSTREAM_CHECK_REGEX", k[4])
+                filter_regex = k[5]
+                ud = bb.fetch2.FetchData(url, self.d)
+                pupver= ud.method.latest_versionstring(ud, self.d, filter_regex=filter_regex)
+                verstring = pupver[0]
+                self.assertTrue(verstring, msg="Could not find upstream version for %s" % k[0])
+                v_less_or_equal = v[0]
+                v_larger = v[1]
+                r = bb.utils.vercmp_string(v_less_or_equal, verstring)
+                self.assertTrue(r == -1 or r == 0, msg="Package %s, version: %s < %s" % (k[0], v_less_or_equal, verstring))
+                r = bb.utils.vercmp_string(verstring, v_larger)
+                self.assertTrue(r == -1, msg="Package %s, version: %s <= %s" % (k[0], v_larger, verstring))
+
+    @skipIfNoNetwork()
+    def test_crate_latest_versionstring(self):
+        for k, v in self.test_crate_stable_uris.items():
+            with self.subTest(pn=k[0]):
+                self.d.setVar("PN", k[0])
+                ud = bb.fetch2.FetchData(k[1], self.d)
+                filter_regex = k[2]
+                pupver = ud.method.latest_versionstring(ud, self.d, filter_regex=filter_regex)
+                verstring = pupver[0]
+                self.assertTrue(verstring, msg="Could not find upstream version for %s" % k[0])
+                v_less_or_equal = v[0]
+                v_larger = v[1]
+                r = bb.utils.vercmp_string(v_less_or_equal, verstring)
+                self.assertTrue(r == -1 or r == 0, msg="Package %s, version: %s < %s" % (k[0], v_less_or_equal, verstring))
+                r = bb.utils.vercmp_string(verstring, v_larger)
+                self.assertTrue(r == -1, msg="Package %s, version: %s <= %s" % (k[0], v_larger, verstring))
+
 class FetchCheckStatusTest(FetcherTest):
     test_wget_uris = ["https://downloads.yoctoproject.org/releases/sato/sato-engine-0.1.tar.gz",
                       "https://downloads.yoctoproject.org/releases/sato/sato-engine-0.2.tar.gz",
-- 
2.34.1


