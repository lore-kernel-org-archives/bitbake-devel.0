Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06CCCD343B
	for <webhook@archiver.kernel.org>; Thu,  7 May 2026 06:19:12 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5951.1778134750260849307
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 May 2026 23:19:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=YRaUJtOq;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=9587885fd3=qi.chen@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6476F24b3911855
	for <bitbake-devel@lists.openembedded.org>; Wed, 6 May 2026 23:19:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=u9dANCllFPCgP366S9mMMAETnoCZYnBKHoh+MzisOWw=; b=
	YRaUJtOqtDSYCLPBMkMNgD8UcQQEDTind++WvN0Pf46f0PxXNzRUUcWC/eIrpLIc
	j6Zbp9/4pT8og4sm8l6COZsgAedPYl/6umDL+wZMEE1M0hnW/rCWLRPwyg4rI822
	uM2gfyrf7PrAvEaLTsx4GaElUqIt0HdsSLXBB8ld5rhZnHZ1i5TTy4qIUMoGuaHH
	wEBacdJltabg0L7Syv9bOUUcHmSmJ5vQLBAIeAr6b0gvYzepfNfRBx3uiQJgbsn9
	XsVHRlEBnJl9oRFsSAcfhBjkg+VyedEL0oKnnHAE+xLDg+LkbMlJqBovXVzz4ywq
	Cw74V69t4emdSq5V5SCqVw==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011070.outbound.protection.outlook.com [52.101.62.70])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dwgsddssu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 23:19:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cjoi9elZp5nqEcdbenY0REtknnnOYW4v0H9R2ljlt7uExhYM8UHlbBODWYX8xH+xWijZBPVd2h03Y3xdys8b+76qUnfpelZr24Pv5EVbbp85nIxJ+ectLz8wbZVzRIolMmYm3k9MeG8yFEPiMzy/NOtuNiHgu/w/kp9C3pZfI4KitwJwgKanxTDpwVBF5hKJvMb6M6WZT2VORz3i5qAgMnxZlz+8It4dpC0aljsWEXT59S5pwKSlRp2lH2cbERON22hCh8+ZecTGRcX/t1w7WMYwcZZSZ8TAqhCcy5TVeAiXdlkjxIIDEyle85Qn0MaBbwL6PXMiQK9+9QcxlopKCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9dANCllFPCgP366S9mMMAETnoCZYnBKHoh+MzisOWw=;
 b=K8nW5Ct9RumZXDKqMGukCPXj9WZurNfvY66PCU1LDm1dm8fmGpEP7x/A8D69mBA3lpPwOfFq+rZC0lfQ/XZAIBBNdHELxNPYVMvdPNWItUy8QjhTMFFza6lrGMXE6TFz2lqjOS+lmD2xHuAM8emFWaMfA15JN/aPkcbj7O/mE92rpyMfbF6lcTKgLvUgT2nfceYe4OgNoLyY+PgWGeeXhdJVlc10YU0Lj2zK3MIzFoujLWBTS48OmSyFk+kL12JUgQ/90ygRGO2FdacB0+AZdFlhJ0NQ6DJNo8cF15qHRsWjoUaHNT/dFi/Kkz5Z/hpOkG+6OeOiA3SyaEx0cHLfxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by PH3PPF383C22AA3.namprd11.prod.outlook.com (2603:10b6:518:1::d17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 06:19:07 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%3]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 06:19:07 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [bitbake-devel][PATCH V2 2/5] fetch2/wget.py: add filter_regex parameter to latest_versionstring
Date: Thu,  7 May 2026 14:18:42 +0800
Message-Id: <20260507061845.1460893-2-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260507061845.1460893-1-Qi.Chen@windriver.com>
References: <20260507061845.1460893-1-Qi.Chen@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0217.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:18::22) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|PH3PPF383C22AA3:EE_
X-MS-Office365-Filtering-Correlation-Id: dbd43d8f-88e5-44fa-6a63-08deac008ae5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	vsYxPT94aMLbbDCY3ZZ7M7Z0vgKG0/i03bBl/VrHIVN4fNV6OUsf4J0MUGf93Q9RWNsc7cYItTczIGvEFnfWrAazx/uQegnju0QbIwCIpvfZmA0N/ADaudHf2GAs1HnAeiUyJnYAAXDtyp9znLupqjrsC/93sXwIiZNxssDceXRbs9oNk6tkjXasccStxkrTXyfs2Ccp9UWsw0uj9TVK+/FTyLR9cYldE6uLl9uGDZYvQRn7pXIJqM4vUE/345FtNX3ctfSHwoBIAXoCEGb7FX4cBQesdXkjNlM3JWZvExPwPvy5/e9udfbwNKyinjRFEThCtL99LD7aHjR+pFz3m/EWp1C5eDBeIzfqfkY6362+SNZ7c1/ohQPJMSeglCaTcvCOGtOYixRiXre3I8QN/Ytc/48NNht4F6WE47CnkdAJw76s4UMYNSMrInlSElRJlbRkC9sVTG8zCdSOy8upTl2hqtDDpLyc84MHo5gZJyCpHgxUDjLZmKS1/K50dKb3wROE1zSebZx1kSbG5OfysHNgXAvEt/VFjQ44411vNL8ur0xYRqLU/YJAUG+VkESAHrQL7Qyp4xL8B8QIsV/B+F1fZ+lP4Pi9as81gesF2nnxW4usc3DRfeeKMbbsMT+Kb/xRMeXXvg3VmA/H0sTx8UsvzP9l39J9YADrqHr9qxbFPQcWJvJVi7j68da+HTuiiY179gTXEEn3awV42ttOzPlQZZWDgOA9qFsLkBwgKq9AQr6M5e1fZFNWGS5F9KSH
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?HIiEYaXcOSXCoNr4Tkm/lRmg+YqhYSDq+fQLDk9mWi5Cx0ajADDg1ieZYCtq?=
 =?us-ascii?Q?SykbEJ+fMCRshg/Kcf4yM1iwLOVI788ty4HWjgnzTER3wo03jSw+yDf8Nk8R?=
 =?us-ascii?Q?MOh4X3iINvkdM6aRNTSlMDxX1GFO22alJ586UtaKcRv2OWIDU5b964KzEOlk?=
 =?us-ascii?Q?GPpn+xxF+tL/cx+7Jzc/H8oailVMADxnvHn5UFeAq0gCiwfp+4Oa2Qc9+LzU?=
 =?us-ascii?Q?Di4X9FUtXjmWYzbpYkOi6v1YdCaOgfFdtkRabZSYZywhwIl1RddUEdI3QetA?=
 =?us-ascii?Q?6gxsHkXDv3Px7kgqbCdlJkq2QsVYRsbeuRSHM6sd5DDtU6t3DBw5TMEImwSv?=
 =?us-ascii?Q?jTfEjh5NAs36+l8CkJpNBPMTgUgnVF5/RUNdxV7yxFWVgUP3s+1rn5mj7UPV?=
 =?us-ascii?Q?/e6jh1ZIOwIxUIXIJxOUbT19ja0l/bdybNvTcmj4/PkBGqtwOX4v2K/xP6tY?=
 =?us-ascii?Q?xQdfnkmGgCYL8RwnGtkZpIkbpYNuhNN2Ci/SUkuS2GfWQiY/tP8mGz24SO9q?=
 =?us-ascii?Q?q/Rpq6kteGh+eDf/boCqYmVbS6MoEgpyzP2PaxjLcLRdRlfZJtD2nU2sIKLY?=
 =?us-ascii?Q?hhKfwnMi3ugLOHT8fdvhdvQe+pPoo7bCbJ/Ui7YaVNBHduXDKD89aKj0zBzg?=
 =?us-ascii?Q?fAm5mkZ0J9Gjrhr0UDPm3CjxcM7CYqIocEy2q8tq2BWilEMUyerxeB85X+76?=
 =?us-ascii?Q?IaMzX73s1zUzsgPfBynSTAtSlCaxV350gGr+WRPwThKzHN035N+dHBh2OI7Y?=
 =?us-ascii?Q?8gZ+vcgEJv3pvKlrEkEQsV3mINKA0ufJC2tNCAZyd10+nBsxjKvP17BqQxOm?=
 =?us-ascii?Q?zMQ0iOjz3f4VCFNDyFAif/VR3i8EAARk5AX4cFKPUXowymNTmpERMxH4yHbU?=
 =?us-ascii?Q?eklnJtL7N39lMxUtJWVIBtqmwVtJUosiUS2kaN9zgAqHmBpC+f8W6eMP3ppU?=
 =?us-ascii?Q?a/tgEJ9k/6IsGK49pErfUsb2TkQ8KuYOuhyQi4u8wIfSUxB3v5khD50jom5C?=
 =?us-ascii?Q?570fN2gxKaWPalYx6Xs+drqVCY2h823LHI1GjPtOlQW3bqGlS53DemrUBZHt?=
 =?us-ascii?Q?wF8T2hfRn/YC/U/FGgSRn2C4SPWgD6q+I6Yz8hLkfi/i8njHX/4YAd7VGxlN?=
 =?us-ascii?Q?qzmYvMu22Kphjemt1kmKjlg+vmoo+BRlRpyNBwPj/RnZzeJuKUNg0shaPWFN?=
 =?us-ascii?Q?XomCF3M6IOgGJxOPVK9X+ehNTbNd6om757EQPXGwz5PE3XLkpuIUH9cavixO?=
 =?us-ascii?Q?E8rK298bCpYDxVhY22g/KynBBKGkUnkYreccU6SiJM8/TkoRxAVTJkziSBPV?=
 =?us-ascii?Q?XThgGtjOcm6aZHBfDBvngdnb3XIvNA7w3R5fPHyWg5ebzfRpG+dTzEzg35/O?=
 =?us-ascii?Q?2T/dJ/er0jEjKjC6450+GXFb2gMiOhMMkwXQxTGMWaULqyKYU6NnL6xrm348?=
 =?us-ascii?Q?nWjk5NuNS881PZDBPLJOpjk2la9rWw73Xeyp92CoiCwZU6kRwZe6pZagEogJ?=
 =?us-ascii?Q?xTY5Q9fH5lyN03BJDg+jtVRJESA/4kYIRm4fHmA0nuyda+dbT9ShRuWfnCWn?=
 =?us-ascii?Q?AzZk6NyvuzvferYapF2JBtGoFWsoe/vEKwmn+sGUgLyDtBUoSeBNYB3jISHG?=
 =?us-ascii?Q?OJIDgt25OVIEwaGctGC6844xNC60iolKqaI9P2bae2QuL3Nq9dFh04+zTyYm?=
 =?us-ascii?Q?1SSKyK1tpk2qjMUvRW7bWZHAHW8a+oqBsE9unK5kzSH5rhO6zwEt/dDjuqL9?=
 =?us-ascii?Q?Zu4bZZER9g=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	kCDYKpaxYwE4mxAhR2fVajlJ/XcLQ9mG5QBiWWF5TopwTD/4QTC64xnEkXk6d2J/ASpjOAHMPxcMbroW3sTWf8qL7ZyyujbBcvrfI4utyzTviq3mt3KD7y0ceM8tcI2iekr3tzHlZDrJhR/sY5Gr5rgB/HYvAjMMfRjQc5hq3Bv9dLwg/5CHO3aDgO2uSop97LgRET6SnPlMKxJyOUU//d+XBeJp3LqEe6rcPvwUJu8s/wZHZNwNf+HY21ubrbaX8buRHYkH0DY9PFqHl+rxYIhwnrPz+W/5ZKWBkrvHWf4TpYAcbx9+nD6UsWoH/clm4GsYan0T1xo3nPKL6ZCCgw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd43d8f-88e5-44fa-6a63-08deac008ae5
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 06:19:07.0592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1bAZ1AwXC80cT+YCrHtztfyqY/pqoQxBaNR6vxX9aGaBcto2JvYXvO+n7vewBoFBOYsu4ZZ2fuXL4DL+NdZxCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF383C22AA3
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: qy5Wp1TCVCfkNJvKv2QiEmgoqyuH6uVX
X-Authority-Analysis: v=2.4 cv=JeGMa0KV c=1 sm=1 tr=0 ts=69fc2edd cx=c_pps
 a=CrKnoqqb99nOpAJSR4mnrQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=t7CeM3EgAAAA:8
 a=zn5JUfJC_tOmDknYn7cA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: JuNLn-ClIX24wvx-U9gWUOkrZ5wMBjp6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA1OCBTYWx0ZWRfX0iI/x3GOGzSc
 lXIH8RBaE56H45gKmDTIRGmFOukRvMO7+6n9zMAY2Wul5huO4yWAl8cb5N5bTsSFjsCUQQ1FBrw
 io94HAbTwwYlGXIEA6CymeSH9izPdc+pmtb/sKtTURoddnkmnjagM4PTz0Iji1X0k8BnzxV9PFk
 7RFtH5RNgpguouAQclEyYDbnJgVwthZpXBjIh2rh2TlJzxWTAYKigNw55WbSfBcd4XrDqYITKBU
 TlU9+sftSMyDJ9fERRDENpc1V6JP4LMsnFS5qkbwG+hzsCrCwoXLQSfwZMUdXUyNPrPvNtqDy1C
 dB6HVlsEP6ckgahWK+n1uJq/4kwVPieou+g8uTdFF4ShEzTveKn0c2F/DttW4vUVB+N4fWMr99U
 9l76kLNNdrnm3Q7JAj6m/FF9rN2Vxmi/ogHF2uqknFWWXpeb7cFgRqjhgmB7mang3qEhtCVe4no
 ZX4t3KmxiT4E64LKylQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070058
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 May 2026 06:19:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19452

From: Chen Qi <Qi.Chen@windriver.com>

We want to be able to do stable version upgrade for recipes. For
example, 1.0.0 -> 1.0.1 instead of 1.0.0 -> 1.1.0.

To to this, we need an extra paramter to latest_versionstring
so that we are able to filter out the versions we need. Using regex
has the advantage of adapting to different version schemes.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 lib/bb/fetch2/wget.py | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 6ac4306c0..1f331ba3a 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -492,7 +492,7 @@ class Wget(FetchMethod):
 
         return fetchresult
 
-    def _check_latest_version(self, url, package, package_regex, current_version, ud, d):
+    def _check_latest_version(self, url, package, package_regex, current_version, ud, d, filter_regex=None):
         """
         Return the latest version of a package inside a given directory path
         If error or no version, return ""
@@ -515,6 +515,9 @@ class Wget(FetchMethod):
                 newver = self._parse_path(package_regex, str(line))
 
             if newver:
+                if filter_regex:
+                    if not re.match(filter_regex, re.sub('_', '.', newver[1])):
+                        continue
                 bb.debug(3, "Upstream version found: %s" % newver[1])
                 if valid == 0:
                     version = newver
@@ -532,7 +535,7 @@ class Wget(FetchMethod):
 
         return ""
 
-    def _check_latest_version_by_dir(self, dirver, package, package_regex, current_version, ud, d):
+    def _check_latest_version_by_dir(self, dirver, package, package_regex, current_version, ud, d, filter_regex=None):
         """
         Scan every directory in order to get upstream version.
         """
@@ -576,7 +579,7 @@ class Wget(FetchMethod):
                         ud.user, ud.pswd, {}])
 
                     pupver = self._check_latest_version(uri,
-                            package, package_regex, current_version, ud, d)
+                            package, package_regex, current_version, ud, d, filter_regex=filter_regex)
                     if pupver:
                         version[1] = pupver
 
@@ -637,7 +640,7 @@ class Wget(FetchMethod):
 
         return package_custom_regex_comp
 
-    def latest_versionstring(self, ud, d):
+    def latest_versionstring(self, ud, d, filter_regex=None):
         """
         Manipulate the URL and try to obtain the latest package version
 
@@ -678,11 +681,11 @@ class Wget(FetchMethod):
                 dirver_pn_regex = re.compile(r"%s\d?" % (re.escape(pn)))
                 if not dirver_pn_regex.search(dirver):
                     return (self._check_latest_version_by_dir(dirver,
-                        package, package_regex, current_version, ud, d), '')
+                        package, package_regex, current_version, ud, d, filter_regex=filter_regex), '')
 
             uri = bb.fetch.encodeurl([ud.type, ud.host, path, ud.user, ud.pswd, {}])
         else:
             uri = regex_uri
 
         return (self._check_latest_version(uri, package, package_regex,
-                current_version, ud, d), '')
+                current_version, ud, d, filter_regex=filter_regex), '')
-- 
2.34.1


