Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43429FEE4D3
	for <webhook@archiver.kernel.org>; Sat, 28 Feb 2026 08:25:18 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.115824.1772267107192065306
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 28 Feb 2026 00:25:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=QHgCiWNR;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=65193f8e15=qi.chen@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61S8P6gx2974181;
	Sat, 28 Feb 2026 08:25:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=KKwP+EJn7QDFkLDYTN5TpZVulDjwI9JvOFGOHKaFhyU=; b=QHgCiWNRCiya
	vMhQtOwdUrCvDemDYdrP7hJLnXbZ41HbM4YO2kOCEE2hUU2dKBq6/mZe6v2FVHel
	DEVI+EILkk9sUCityLZ0PRxRnKePTf/Y2dqZshqQGAruuDGqBfqJCSV+sUTsVv+z
	9mDUFGawCqldg4szkxrE+dMMNfT8ci3CFh+ZdpKTG/gcNpsFFCh/B9Wlwxu0yMmM
	ryNm6/yp123PogmR0bqx/b1bOVyxDOxHv/TnCoCwoBwCNHDBoKDk893denq3b9NC
	h6bABsL2HRbpnyC6/clmSdkh9g5ISml5xTHVUV6XpXwI5NeSt4m3+jjWIYMyj+ah
	K4IK4ESw8Q==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012055.outbound.protection.outlook.com [52.101.48.55])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ckqb4g7u2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Sat, 28 Feb 2026 08:25:06 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gMSv7aLspzT97yzLe74y9CHKhph+9bvBD/RkL63EdBsvMV/CZt/ZbSkVwzoC013YGZM4ErViLb5KEBwwpj8QNOc7CYFARVy1+BrVSt6o6rBSO7vq5Szx/XKBMzBoKRZFREXCmYVYm6qb++AY2c3ujRSa9HYRm2tnX4kAqQVn/RfMGMSsp/VOBz1JgiIqri3zGuyjx9nQNu2kRvplO0MNsKndGtS8ujZS44AZybIl6sFbUD4aHAdFYea45XrQIY/GSJCt8AZEPgX1pJBc5bB4fi8Hq7RnV4oB2hDoS77JczmE0veak/23G4hpy7frOxjlZRTVMDIeDy4oWSsZLFb/1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKwP+EJn7QDFkLDYTN5TpZVulDjwI9JvOFGOHKaFhyU=;
 b=SxehO+A0MmLAIl9FG8G5vEmojVNJjIc+vwMIgyodeyCc8k2scHOLD+3b+N5/yEM6eQy9nL6F7EqlPiqI9/nwPGOHIWwvIcQAPpyWrauTF1fgktLcQIwRFP+DJ1t736EkucrCysm5bEDEFagUrrbGkfdgovdqTL3i31O+QOJceB48EQDoxZd7RURoxI8s1gEa5WXAgJW2RZTxbLz643m9+xihG0+9xlvO9HHYVu3ODwx5YoTH5V8zsFXmxrFE3nELIiy3y0XBv2XxqHrLztWIkN2Pt8aqrYhRJS6jOehcIcI9qtR4HyAWJeGbR7nL/hv/4//F6tYbBl1XoeTmGbeJtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by BN9PR11MB5243.namprd11.prod.outlook.com (2603:10b6:408:134::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Sat, 28 Feb
 2026 08:25:03 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9654.015; Sat, 28 Feb 2026
 08:25:03 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake-devel][PATCH V2 2/2] lib/bb/tests/fetch.py: add test case to ensure no FetchData attribute error
Date: Sat, 28 Feb 2026 16:24:39 +0800
Message-Id: <20260228082439.3613864-2-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260228082439.3613864-1-Qi.Chen@windriver.com>
References: <20260228082439.3613864-1-Qi.Chen@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|BN9PR11MB5243:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a84fc5e-f8af-475a-3981-08de76a2dec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	kMYuYbM82D2aesXttjH35ki+s6mGsX+TirgGqu0DDEU/RepHx+PM16KXA4WMx/G2MrYtE0NlWS3PLIL5JQ93jBp7BPfE2mdeC3sDgnManMttuQEnMUNxt5D2j0ZJwJ6ibfgl0uCbA9z9OU7mxGNfGVxb3miijldL/Pi/To3ZlM8C0hPEUwMEJokMqvxFY5Ni4jiTJGBAV5fIg6EuBLrarqoajp/eUwCeQPF52FIjUKt6zawtdJKmZyuJRs5w/8nDsv8KV/qTTtKKfXgOzU1+n9C+LNINzOzPZcRKGVmKUqV1PVboZ1q1hc8WUDICPNvnC0pMg1nxTtWj/o+bQZuGDHIx4dj/IF1kFBJyp81y9Rpuad+B1GFw5alasg8FRpG8gMtmuQfs7uWvHF9Rr4eSwiJIv1dpmIPGYiDEltFCVaUc/LQLCSJ15zZMM3jHaGrrtEbPqveiPr5Uc5r0sG1rHVexqOXfSY+x6iWTAXHFiXl44VDkh1J8q0AJ54YzPP9SwFHDbc8CGQxOiO443NtFx8mST37JH7mGRP6xln0jkfuRteNlGuTH2/noodqNh7lYDQrayMyaEK5tMBlnW+IL6byAMZzgSeKTFkguzDEggH+AaohILzbYrvGbTEJv35OL+ypTSi/5vYC+HxGpiyUnZjNxNqfAndnnUdOMQhXGSwXuumncaCDX3VqtOVlYHZdAZMyM1unEUEOkEbWg1Gucckz3hxYjksp5wv6Mcuh/+XsCO7s9hN2YT6tKI9LgX7JQPNTaLnW8AP7lOt/xp9PYYtyNmg9+cXcdF4nDHwSoBTE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?BcGPiozaTBdInx7WPKWl9QF9Ld+nrZqc5R/mfgy2rXvc6Sd63appuZYy6Lzg?=
 =?us-ascii?Q?NG/Y6CqWNPGnU1OKHhuJi2KUFisZwlf73uvMvGHJoQrWI/rmEXg9ZDz6NKn0?=
 =?us-ascii?Q?3/7JlE+jLvgHK5EUKaZkdFUX02fgQaatgparLH5rph5bvXwU6ua0BLreFV97?=
 =?us-ascii?Q?FkaeMxX7vRVLhgzNUj1lODQYnQjITtTrvjgrV72A6dO8VbT/a4MFG+JfdGao?=
 =?us-ascii?Q?GxOfUzYYh3UBKhqitL1AorKveaAlVLc/sAJWKM7uXUibegrvjJhG7ustSpwF?=
 =?us-ascii?Q?u1++/HBq1S5TsawIOc/PMzJ8NS1oPfsFgRSTgU/xildhHBxvloUw8o7jMjfZ?=
 =?us-ascii?Q?a4a+QCVDjwBbTcOmOYjViHoDOT8LevrVDREsW0jPmV520cJGu1/1k+nsyfnt?=
 =?us-ascii?Q?F1Jjmk5yWFgF01QkPNZVigrq9Z6yvDKE34v2NC+zHD53gJBCNDkKpqULnSXg?=
 =?us-ascii?Q?YLFhrdfEDIDfMlsUpd34P0ylHA9451/TEj76xWdbi0ME+eGJCMyO4ntolpUb?=
 =?us-ascii?Q?xBgQKOT0LvtYbX+a/ta1j9hOD+syRKDqMEkZ72dJDRjgYrSCPYzCF20v/Qjn?=
 =?us-ascii?Q?79vt7wI4JNEW6vPNSBQI2W7xpHrWxYEBnR/ooBYAzcLZ14x4KjxckLevVfiL?=
 =?us-ascii?Q?agIAoHSVMXxHpmbDKZ7jto3bDvYl8meh6KEfCdMIN9JpBASAySP2NJr3PQ0J?=
 =?us-ascii?Q?P5YotmZuNa0xJrfQzPdLh3/P45QPAuiRg3qGXRVR21IqcmSTQN6zcj7wxURt?=
 =?us-ascii?Q?LxV+nj/UaDfbvQ9dfHCJHALrugY0Zj6PlCD2A7pvyOyHsQM0hGOpKhuSXmCU?=
 =?us-ascii?Q?LdZIR0P15zXQ3aQVfc0PmOI2SBMopfTkDY5Lh1dnpEp/600OBZs+MayUInIJ?=
 =?us-ascii?Q?DYEirnJkqFGJw+XldXcQKvbs75HQBKaNmHXfxbUk120dW0V10A1EQHSVu28v?=
 =?us-ascii?Q?REcEBNgqwsXWVLOZ6NvKq53wFx6JL6gOyF7dX+T58YYIUBJUp2lYQwpatYZa?=
 =?us-ascii?Q?CxrgpcvVajwNSZcwfNpOvePbZzS/HN9sYgbbdEMrrMdEqEs/wHTlB3Tdx8Hh?=
 =?us-ascii?Q?W8QS+q2z3HoT0ePpaJDPA6WGiuNcmbAPAIBB/gLPI5blZG5ffv8yQjX+Sa4G?=
 =?us-ascii?Q?estlREAXWdoVf9vUavh9oiJtNaH+1W1Z8nsE1eKVc7xc56EZvhUrGA94NKNP?=
 =?us-ascii?Q?BYeRF7y7ys6QrtZbF+tgd9w+bq5UVAYrzOIotMTR9oEDUW1yuPx9M8gIeq+3?=
 =?us-ascii?Q?4r6PrDocWOTjrYzdoTT7t2RWPA7kgCUxXvUFIsEXIwjdfnHeImqHG0sfv4UK?=
 =?us-ascii?Q?lTDv/wx4+lrA7ENeVNcRC7dqzW0X18Kac0tLmEART8nweXQ+Bl22n9v8KWZt?=
 =?us-ascii?Q?bDw/ifIV/ApuYYCE8qJLQiBijdWgutkgVecvoIR8zqVQOrH3s19Y4TyErYC4?=
 =?us-ascii?Q?JwPpO24alvVrpAyk6ZI5l/kjHmj684XdoIoBMsP/on8Eu4tWj2VK9zp+C/8z?=
 =?us-ascii?Q?e2Vm+oHA5wHnPNigvLt6QGJ9gBgLX1VRWN5lR6cDcCRO7bwkVrrZjfGOixTs?=
 =?us-ascii?Q?nk28tIE5FqNCtC06UBDAO1RoWGYi20XC66rGw3Dtgnz1v5DED4IVwE14Juus?=
 =?us-ascii?Q?wzSOp99IIGiHUKniT39GuY74VmrhJS0tFz31MkcJD8hBrHU7z7C7BMp3tOOP?=
 =?us-ascii?Q?+uvgk32M2HMdEmQOexC8gfrzu7c6eIuo9iydsOQRq9IFDqgG7IITUMd52Yjw?=
 =?us-ascii?Q?CZyAy7mEeg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a84fc5e-f8af-475a-3981-08de76a2dec8
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 08:25:02.9609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nIARqnWKXtIzCWJsGOD9dNSW2m1k9aOy4eszJJmHKhk4TCts5BVqbvPNLGCMuMCIz6VGe/fzl4vv/wPWH1twsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5243
X-Authority-Analysis: v=2.4 cv=LqWfC3dc c=1 sm=1 tr=0 ts=69a2a662 cx=c_pps
 a=FXm+OvNBiSWvAu5LmLLQ3Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=Q4-j1AaZAAAA:8 a=k7oUcx3osaYIJ1Rpvg4A:9 a=FdTzh2GWekK77mhwV6Dw:22
 a=9H3Qd4_ONW2Ztcrla5EB:22
X-Proofpoint-GUID: Bi4RIonArBLJWHqHjpYqs3J-MZyLlvXm
X-Proofpoint-ORIG-GUID: Bi4RIonArBLJWHqHjpYqs3J-MZyLlvXm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI4MDA3NiBTYWx0ZWRfX647Fk+pQWzP/
 V0XofmGgz0eAEWM/MfxKa5YmkjnwfdSK7s1lJ91O0+E7kjAJ53prduU6/HlR8R9mPTbQt/2uOuA
 edaqj8Re3N8tQCoqyosZCrHiA8RmH/9/XQIc66G9qtDSmHJtUg7KENrxUA1WRj3LqpzBJaGz/eD
 /V3mIl5NXAUWWExISU7z2QvEd3ujxhdiXOHQe7rAPtZARPEJbUhcPOYHmFJmNPKqRT9jL8ndLVy
 fGTn+79AuqBoM5V+QEQHALn1PYW/vlhYuzZIGDUOlsv7vRp4wnOlYEA2mWJmVbQsiKgk8SIs9fV
 YPW7xGe+FzUse/wvKr0HvToIU8nswp7oD0Y3Z4ceVu/2Af+ck/ZU21ZDCI716uzVu3b+UWoEBbj
 9Nj1Y+J81kGIbEWk6gar2fyEMEn4czY1DTVVOI+VZhCDHyjbswmQlf0E1oPyoOdfc8BfpE89ghP
 OqVaLjzOuNZ603fXPhg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-28_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602280076
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 28 Feb 2026 08:25:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19096

From: Chen Qi <Qi.Chen@windriver.com>

When using git:// -> file:// in PREMIRRORS and we have the same url
in SRC_URI twice, we reveal the following error:

  AttributeError: 'FetchData' object has no attribute 'shallow'

Add a test case to ensure future changes don't introduce the error
back.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 lib/bb/tests/fetch.py | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 2a8501dc2..74eb73472 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2089,6 +2089,29 @@ class GitShallowTest(FetcherTest):
         self.fetch_and_unpack()
         self.assertRevCount(1)
 
+    @skipIfNoNetwork()
+    def test_shallow_mirrors_with_multiple_same_urls(self):
+        url = "git://git.openembedded.org/bitbake;branch=master;protocol=https;rev=82ea737a0b42a8b53e11c9cde141e9e9c0bd8c40"
+
+        d = self.d.createCopy()
+        d.delVar('AUTOREV')
+        d.delVar('SRCREV')
+
+        # prepare premirror
+        premirror = os.path.join(self.tempdir, "premirror")
+        os.mkdir(premirror)
+        d.setVar("DL_DIR", premirror)
+        fetcher = bb.fetch.Fetch([url], d)
+        fetcher.download()
+
+        # set PREMIRRORS
+        d.setVar('PREMIRRORS', 'git://.*/.* file://%s/' % premirror)
+
+        # set DL_DIR back and use the same url multiple times to fetch
+        d.setVar("DL_DIR", self.dldir)
+        fetcher2 = bb.fetch.Fetch([url, url], d)
+        fetcher2.download()
+
     def test_shallow_invalid_depth(self):
         self.add_empty_file('a')
         self.add_empty_file('b')
-- 
2.34.1


