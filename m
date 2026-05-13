Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52394CD37B6
	for <webhook@archiver.kernel.org>; Wed, 13 May 2026 05:24:53 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.907.1778649886424825330
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 12 May 2026 22:24:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=Y60JvDar;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=959349fd7a=qi.chen@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D1c4jR010818
	for <bitbake-devel@lists.openembedded.org>; Wed, 13 May 2026 05:24:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=3Msu7VGPBNSik7DqiP9QgBDdmBdMMdDKggXjzbsBbIs=; b=
	Y60JvDarb6ynC60XxoE+Nkmidqwbr2pzZDsDCxE6J7saXAhsfB/Dlf77LIyMMEgI
	UKrE1L/Kaa6s+b6KxXTLOT0uAojOzvAnS//JTwqrFQU7VdxT+f2UvZoyVecXqQjQ
	tvscjVxczCOk+tcoPBbo0aPRqiO8LziLXv3Ht5B2cC7eX4fRijdeKEJBfnsAWdgN
	h0UPxx9Q9GU3aFp3ci6YV/vuSh2zDcTuROHfZ+x8B5ql1OgS+Y4u+2/sKUFQuUWC
	Nhtk45pwJFUNaNzus3zTsCbAvdw1fMRcT0HGJmSTkYYtZt6kXJeiGEVE+BT1n3AF
	T4yC+NucSVnS+uPDjG4GjA==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013007.outbound.protection.outlook.com [40.93.201.7])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e4ft787p1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 05:24:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DdraJkHm+NjykHPisHRk6wX8JhlJu7VyIt8YWyOxfkzG5aHbP/Ctw2d8vjUWXjgQ+KzGzwxRRSRgX+Q1iOmujUWLNAd6ssyq7QJUHN7X5yXmGGET85QF9Xt5f9mtTstT7xr14QyzUkUGY/1/fyLJLSE+mQG7leWFbKXrZfh8zE3oerIZ/+HG8xZ2tZmuQyiTa6ImylHBoKRRl5BAN7QZluYaAuO2mR1gn+Gbl/qnTRJhOLrpYXcAAWM6cvyU6z6xShhkWyBbjarsNKg5QTjhCvMROgvA4XkgpPoHxftrgPQnz2dX/5sKqbVEjL8eygzM9TfANaBmsGxG1jW8FDxzTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Msu7VGPBNSik7DqiP9QgBDdmBdMMdDKggXjzbsBbIs=;
 b=XuIbVVfMfeeNHIMvaOhrCDm9km40kIMlOtorpZgQIyaX8OPdSAzUh2ZbLrDKlmbhlFEECzzYe6HEjkEhk4Kp6ETg6o7xVoCDhDw2x45lp5Sxx2A3GgL37ONS8kqmP89MFVFdRNl3t+O06J9dkZSPgDB3pOO3qNBVrxu+A04ZP5ojKrDd/1LMY3pfNdPQn8JjyZrc/V7uXNQpgE6xPO+Gj7+m7iFuF/OAq3OjRgsZrgpreJjMwHfr0fUrZD21s6NliX8F/fibs1vAJFGAKEZJU6as+U+Mjf4pMig3cY92ViH0XFCav3qbDafRnCp0gyfeIZYvBWveBevoyp8Zy2vMQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by DS7PR11MB8855.namprd11.prod.outlook.com (2603:10b6:8:257::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 05:24:43 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%3]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 05:24:43 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [bitbake-devel][PATCH V4 2/5] fetch2/wget.py: add filter_regex parameter to latest_versionstring
Date: Wed, 13 May 2026 13:24:21 +0800
Message-Id: <20260513052424.2271877-2-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260513052424.2271877-1-Qi.Chen@windriver.com>
References: <20260513052424.2271877-1-Qi.Chen@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0179.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::35) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|DS7PR11MB8855:EE_
X-MS-Office365-Filtering-Correlation-Id: 45dbc384-a45b-4526-da2a-08deb0afefd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|56012099003|22082099003|18002099003|38350700014|11063799003;
X-Microsoft-Antispam-Message-Info: 
	jcLczrUYoESAsiWu0xkelgog3GU3q8CtHSwAq1bJEDNLL43rKUgvgslxaoYzlOQkQ3/lcoKcNlAljbxT/hn8Gks3L/pQJ6e4aK+J+ZQZuKJcVy3z6dPaPshoZRpNYzFloukV6kGKY4RcSeYWI5iGsMYn6GqfBfrRbJYb9TJYdi7c9MRovCdHVj8GqnMLQCVggtGobykrMMCitrv0Yjg5BJOGxTgY9CKswEfX4SIqX6UQMnZjpFbupZ66KPtFch6Xkdfe30VmeXtq7opKoZLG4npTc+1qYHmH2KR2jpMZzNzABhXp6gQGv11HKPzQkOZ9N2kUiTF5KPZDzvHF7PJ2RQpcuE/TfIw+6Rrhy1mWsxLqeh9VSxqnQ3lCSRnx77r5eFH2AfHLVFo0J+yunutgWsuLs5obxrOf1Yu2iZDyYBPwl0kMVsvMWZzkmjARXNPfhjCSlVF7Aw0gw/2leCd85diTFYI6XP9Lhd8M9FRyhqabyyI1M1ea1g2Tzmjbni+NVRzrFQri2u22Kga/CkNCJYJ3Hps0BW4z/TP3DdJttctJcbCRhNFrSbQUVpmVHJBl01BTsdkZk2uwBUlc6NwERxdxqksRJWbcV/GjYY3M5Wb+U19jByxgu29DNn4a7Kakqxaq/bstZNiItD53HzR8EODOhfcvWjIq5OwnqqHK3Rp2TjzQqUooyt+c0fO+0yhGK03C6smaieTkIbaPAw40Hy9gw9OAaFCxFQY168AiuV9oGHW+Sz+ZMnTWJvV45gRQ
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(56012099003)(22082099003)(18002099003)(38350700014)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?LCdtXr3mzU+LQj5sfpx577n4qmNAIE0HA1suGw2rmw+oA8lYlbQZA/zm4y/H?=
 =?us-ascii?Q?6mu+AFOG4LPkaMCKARf5e6zHEhrjorsC09UXuANoNY3YpazhOy4yVtVf9BAS?=
 =?us-ascii?Q?841aQkbRD5EN/N9r2Ns187GM4PxFaH9wpoNUMre8rfvheTXZjzycV5S5sTYT?=
 =?us-ascii?Q?zDnIaeqDsGOHi6QnmUaymZNrmx8fc+vwX0PpgxFtN4LU6oS3D+XqV++BAu1y?=
 =?us-ascii?Q?MIrqXRdDFnUQ+HXbsCUx8EsFPNU7TixPo0H5tB8Ds6PhCDFpmIrVOBhpDMYQ?=
 =?us-ascii?Q?sbjlVMIdmPmqIl/v5VkQiXbL81JUF5Biayg2nlCaqo0umpI3G2h7/Dq4bMGD?=
 =?us-ascii?Q?vzh4f1zvmYpbgrayekDkB61HaAgu77/C99dLJb+g+Ric91MiZqsgkBFR7LYc?=
 =?us-ascii?Q?SWP2L0PzXrbz3rd6soKf7oesV2QDMptlFz2Jcc05I8QMVz8GMrvBPZHHwMMb?=
 =?us-ascii?Q?sMRRLDTi6jDGb6jFjoLmAeLXw4mKzwZJ5dH2N075gccJi0tUFcHsJVKJvVdx?=
 =?us-ascii?Q?yBdwdcryboF3zAaVNGeYSy35QemgWcyThX1VGyK/ade4BnWjbO5BelJi6cPA?=
 =?us-ascii?Q?gGzQzYZYQaUkGpn2sfRYBeDlWtUG4NuKyFZxsZnOgLVLrh2wEUezM/knesh6?=
 =?us-ascii?Q?ufibsAjOh8lULHnJfssFKNDj67HebhR9OpZF82avdtnLnYknOYXe3FgfluS8?=
 =?us-ascii?Q?pWT1JCe0zYcYCSCpnz1eX16AQhGctaW2kn4RhxbcP6Q6hwQ+PF5wQEQr4S3d?=
 =?us-ascii?Q?vFwYVZoK7BQWxOeGt46v+ak68ULf4penu95bNQzPM+jxCNyLx1zCcmlJ0LuQ?=
 =?us-ascii?Q?SkWrYCeIGkjxCiwrUBHhmHCGdKMJT6Qu2/otvDTb9MntP+R09DQe/Jw8UxfR?=
 =?us-ascii?Q?vXQK7TdqwSnIZ6o4ezLXaHswu/xyUqQTOnSnh686W8YVtUeCy8Fo9pUghU4Q?=
 =?us-ascii?Q?jXh+4QtT19BDD2B4r9aGUJEHDVDXTOjHsqGxyfViuQg0EadEOGdFJuyJAr9W?=
 =?us-ascii?Q?XYWbFbLeZ9YPkVQ5zz4Ks1DcJfCTzoI4uxHuenMSyA67gAhwTrB/ccECt5yd?=
 =?us-ascii?Q?0QUjFze44Nwp9kJCYaob3AXbW2a9eAGRF9iZOoVszm3mE+AsyZkoBb74eu3x?=
 =?us-ascii?Q?3yVzg6apTejsMadBxxv6lb+0aPiikoyzkmveSzCybjW11sdax8KqUulBrnrx?=
 =?us-ascii?Q?pfrJ1CftakoccwlbhCvIEK8Sj/dIvA3TMp+Op3mTWcGWx6BGALzua9E0hmo7?=
 =?us-ascii?Q?vGy/kCjs7A0wRhPTAqt3Hao4KiXflcC4t31pHKCVc74A3hXQyMuyNqFXkAI8?=
 =?us-ascii?Q?m2/WXteUVPEUrYPVg3OSXkOtwV6rwFPUMUnHMGXnMl0hNs657Zot2QuQpryy?=
 =?us-ascii?Q?b01hJysel8VvnDfeOsAi7yi+Dl+9aB/WnFFHcJi1+rJ7IgV9dHxrZ4kaSlWf?=
 =?us-ascii?Q?LDD1oeKbGnHRA6f1X5S3O6umd2GmAFZtOKCa47QugqSlV3WSeLVlXlVBdFHR?=
 =?us-ascii?Q?XDicsICPquDgQGwwemQ5DyDY32xi0sb1xMzrCAWEJS35cU6BwGLxrFDcN5hT?=
 =?us-ascii?Q?EWjdOgnOSGegOFP3rhh8ggp8uMaZ887AvIzmoABeYUnSxOqaxnxFrURAljbj?=
 =?us-ascii?Q?+K4zsRjDUu6Rw3VCO8N772csuz/jszwnSS2FuCoIDDld/UpQD/awvp+0aNzr?=
 =?us-ascii?Q?iQ3cDYfQOzN87QlNf8JtI8MeG9ZnHfel/2yAb8MmWpGpJ8eeJv9ezgzyoV0G?=
 =?us-ascii?Q?pYxFCyO/+g=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	to2aJjcmWZc9RWnFNIU2wjz3L2/tklu+EpCa/J4+goaA6zIR2TcemtPlbMQrihSXRP46MXBnJL0lhv5tgJPtzbuPL5EWz5EnY653V015bguXrDZVvHbWwJInOSBSMDB0rMW/BN1tKCaj/iRKjE7TAR7OrQHhlaHqA+DIr0qgydYFuItZ9fo6BkUcrNd1uNmVNfr5Veo0OiJo0JIMkog788oROEtjetRZ1IDbkQTR5YPkWeo9h+ruknHXHK98FtAjzuaHSORwmMPLYfKkM1EQ/b+Qnu8UFxVC7QtT1hFARDClRBkyDJLCmY2ExrzbKjnNDhKLplcFzB2Cl0YFZ4G2eQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45dbc384-a45b-4526-da2a-08deb0afefd1
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 05:24:42.8979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b/wefVhrtAW7LXAWoe5O5/GplHU0ykginwUV0zTKvF/oe9FJujZCIAsEkuFTs04KzRJpSKtosK+jGl/XDVBZJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8855
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: jScP6kNdRbJqD5fKcAR6ty0VP7qUmrSc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA1MSBTYWx0ZWRfX8fMYR1pCIsm3
 ofSo6PWPA7qWe/gk8R43MIqdGUzDYvkKn7Uz1BH51MkNWJ+dkIxsw/i7PSLGTBKrlXr+7QaTDcW
 aC8JwikoP6Sk1jwlZ4aPI65/qc593LOaS3/5+zr52t5JeObX8QZ/QthZClR2ZR6M5duqvmZiIfJ
 ehzrYB6/+MNP78pFfvyvrpeFuInMTjdYeaprGqtKbshHMA94VOn+XPg7vecA1UznT1pPFrKK1QC
 uoaP+LkuH5i+LsRPfVnMqRbeQ80tVIFq695jNmp1NeKIBoXjHriq/hVFto25RhY5rjqngn4OWp6
 J4SJI4f0EvFdJVT//fEz4Ltc/kZrAddyG/WGGSqvpI1UzQWRFVcZ/vO24TlApX8yXhs6YbXMMae
 Ck8iWzlk+k/Gu/32ZfbAcWQR93+aZE6Xh0KH9l5iUH29CgkGbz126BU74vBzl0HRZQ0MPZ6GuvM
 S9KYEwkEZ1ZAOgkFP3Q==
X-Proofpoint-GUID: rerVAtGOHjOQfjzbwie1Pe6RsV9j4K7c
X-Authority-Analysis: v=2.4 cv=G6As1dk5 c=1 sm=1 tr=0 ts=6a040b1d cx=c_pps
 a=PxTiP5NnQLoflLcDylFrfg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8
 a=zn5JUfJC_tOmDknYn7cA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130051
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 May 2026 05:24:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19502

From: Chen Qi <Qi.Chen@windriver.com>

We want to be able to do stable version upgrade for recipes. For
example, 1.0.0 -> 1.0.1 instead of 1.0.0 -> 1.1.0.

To to this, we need an extra paramter to latest_versionstring
so that we are able to filter out the versions we need. Using regex
has the advantage of adapting to different version schemes.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 lib/bb/fetch2/wget.py | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 6ac4306c0..6e186e1ca 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -492,7 +492,7 @@ class Wget(FetchMethod):
 
         return fetchresult
 
-    def _check_latest_version(self, url, package, package_regex, current_version, ud, d):
+    def _check_latest_version(self, url, package, package_regex, current_version, ud, d, filter_regex=None):
         """
         Return the latest version of a package inside a given directory path
         If error or no version, return ""
@@ -515,6 +515,11 @@ class Wget(FetchMethod):
                 newver = self._parse_path(package_regex, str(line))
 
             if newver:
+                if filter_regex:
+                    # filter_regex is derived from PV, and uses . as separator
+                    # while upstream may be using _ as separator
+                    if not re.match(filter_regex, re.sub('_', '.', newver[1])):
+                        continue
                 bb.debug(3, "Upstream version found: %s" % newver[1])
                 if valid == 0:
                     version = newver
@@ -532,7 +537,7 @@ class Wget(FetchMethod):
 
         return ""
 
-    def _check_latest_version_by_dir(self, dirver, package, package_regex, current_version, ud, d):
+    def _check_latest_version_by_dir(self, dirver, package, package_regex, current_version, ud, d, filter_regex=None):
         """
         Scan every directory in order to get upstream version.
         """
@@ -576,7 +581,7 @@ class Wget(FetchMethod):
                         ud.user, ud.pswd, {}])
 
                     pupver = self._check_latest_version(uri,
-                            package, package_regex, current_version, ud, d)
+                            package, package_regex, current_version, ud, d, filter_regex)
                     if pupver:
                         version[1] = pupver
 
@@ -637,7 +642,7 @@ class Wget(FetchMethod):
 
         return package_custom_regex_comp
 
-    def latest_versionstring(self, ud, d):
+    def latest_versionstring(self, ud, d, filter_regex=None):
         """
         Manipulate the URL and try to obtain the latest package version
 
@@ -678,11 +683,11 @@ class Wget(FetchMethod):
                 dirver_pn_regex = re.compile(r"%s\d?" % (re.escape(pn)))
                 if not dirver_pn_regex.search(dirver):
                     return (self._check_latest_version_by_dir(dirver,
-                        package, package_regex, current_version, ud, d), '')
+                        package, package_regex, current_version, ud, d, filter_regex), '')
 
             uri = bb.fetch.encodeurl([ud.type, ud.host, path, ud.user, ud.pswd, {}])
         else:
             uri = regex_uri
 
         return (self._check_latest_version(uri, package, package_regex,
-                current_version, ud, d), '')
+                current_version, ud, d, filter_regex), '')
-- 
2.34.1


