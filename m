Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EB3CF8551
	for <webhook@archiver.kernel.org>; Thu, 20 Nov 2025 07:33:54 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.29542.1763624027744569678
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Nov 2025 23:33:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=PDP4wyfJ;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=3419979445=qi.chen@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AK5bFk2140470
	for <bitbake-devel@lists.openembedded.org>; Wed, 19 Nov 2025 23:33:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=eki3RrMz/
	q5CrKfzf57dmnR/OX1AqpeU4whQsiQm7ps=; b=PDP4wyfJs6OedHbIzrSzkPDhO
	gsFuf9D5H1qeguvqZ5OhjyCr+HkOBwU74o15S6qM8u9Lhxz5Fs3ekBH6IWA1zfnZ
	o6vZx3EbRYgfa9urmc7bo4h03oVXHCJfy2IqFZxdUqeCdn9KoJbmoi9Dfi8HiF9N
	uSBoyixhXpKJMohiJWNQ8a41a86XAIlVSmpJ0/RnUU7wEt+7G3psjmGiHncBdF0d
	fDbD8ChqCMM9IdX0b+Z/hAdSsVW9sucFccDuTdU7f3WtZ0mOzRZOwynnieZ+xrmX
	1kcY37sltLqbat2r8E5a1agDmkqFijBidq5kkKk/x/EryRcvoxYYg3Jplh4zA==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010047.outbound.protection.outlook.com [40.93.198.47])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4aenp2x1hr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 23:33:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hLrJT8KUCDw8QvAjOwRHNuVzDRIJJ/MDUiPFTk4pbs7HYQBqGXo84eHT6hecx5YHLd1BraGrLYx3EV2qEaX8w2WinyaJ1dhcgxLZ/ZWYBbOWlhKMF2XbSoE1W7ABd9mCDXoGFXK9Fo8BeZQmQokg+cSPx5lUnKj9hLHOrTTcGohzh4X8A86NlvY8p8wFB3m8AbUe1hWtmRoE3EqQNaAzCgql4GiC8yGtoBQz7YYlgH7N3wPi8d01Zut7UKZm68+uTfvk91QXBg6pTuj3/vk2375t5TmrEJsY25gn8deLnefp7LQ/3Y277frhTXl9SZmpNVJ1n45WkpO+ctcH8YW3Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eki3RrMz/q5CrKfzf57dmnR/OX1AqpeU4whQsiQm7ps=;
 b=T65dNNCCHBCTbHeQimH/E10cQOdsqnoDPahPlQvostH6lHTViP1S6PQnIlzMgqkK4qjOhak4ldKQhAKNgNQxXXZFjPAFP05vdezj3RYMNJKMgMY3cRVE27eQ76K7+dYmf0WD46deRHIzeV5c0pw9Fn2UoptYuoWugJOcXOUQMqAf4as4JhYBqD2Zkh6HtGdMnmMYFcVn6lEBHQDe6tFdHOG+DHUEicHov95S2iijKthwbOYVriECLvddY2GBjP5qh5nN8uQaO3oVEoFUQ9ttI4W9fDZ2Medv9NPghixjmrwJyjr5cMuX9hZXoCnENOJVR0SIHpYg57RV9dXhqd5njA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by SJ5PPFC295640A5.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::852) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 07:33:43 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 07:33:43 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org
Cc: alex.kanavin@gmail.com, richard.purdie@linuxfoundation.org,
        qi.chen@windriver.com
Subject: [bitbake-devel][PATCH V4 1/3] lib/bb/cooker.py: fix reset in case of different featureset
Date: Thu, 20 Nov 2025 15:33:22 +0800
Message-Id: <20251120073324.136238-1-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0006.APCP153.PROD.OUTLOOK.COM (2603:1096::16) To
 CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|SJ5PPFC295640A5:EE_
X-MS-Office365-Filtering-Correlation-Id: d26b48b9-6818-4067-69b7-08de280721b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?xBN9YWyK2blD5vi6iUIba5adFXAwLoip2oiI99djx9xxgJ6YpX6ZQoRTkGs1?=
 =?us-ascii?Q?CDeUDpYAApkR9pdmREfhd8OkuKr6ByXrvdLzjOuasiADyTPeyIffLe5sfwUg?=
 =?us-ascii?Q?uKDk+2zsjCH7T0wT2ScRpnQChQPnh3RdNyFWfOG9oY3xCggAM2j5mHWtMGCo?=
 =?us-ascii?Q?tinxEC/hxAkniwE4RoNCpnV6nVQIdfkvu2VgT2Le70NtLJ/41HBsIN5hFHk3?=
 =?us-ascii?Q?T197rXX3Aivll5royoORYzrzDJwS1bvGAi+G9exX4/PapqNUz6Im0RjMsk+w?=
 =?us-ascii?Q?xjX/arcoK+OfmMPMTXwPLuAadSIneazAEH5usnxgl0y00pFv60yPt5gclwp9?=
 =?us-ascii?Q?CKrMxRd1GqBTCQdRfMgEoL5Gn+8ysnbM8rz5GnhxCEy+0lOYei3piGv6EzFj?=
 =?us-ascii?Q?0Yb/0kmg87gaS/w26bxgNaJC2myIe3M/OO1l6PGABZNHBaebSm8qlShNgUle?=
 =?us-ascii?Q?19MLSSRt/VvJlrybRprn4e8bn8lx+tg5chqyXx/HGT+r3EWBqWhOpq5WToYf?=
 =?us-ascii?Q?TWNruMHPKf/iaasAAkcI+Xea6tA4Rzy2NpLVSF0rdlf2t7JB7gYonZJeH+fc?=
 =?us-ascii?Q?JEb4WKnHollUG82BUKZ18EDLK+9dGVBx6fD8xf0Om7Hs1Nca+hBDa60VH08U?=
 =?us-ascii?Q?AKWGnD5F/X86dBXD1GFKsfeDm6zA317SuAWBdZZ2UhUn6PHUGJ9ZdfmM4MbU?=
 =?us-ascii?Q?DwDWwAHTlpgQ4FPRNnUP5MKGeab4Mq+fw1zsLS0fLFp6ww63kl4HupL85F5c?=
 =?us-ascii?Q?lu8j6OGSnywIKN/UrxHKRyrLH+8f3alvBJrPyOgB0VTGOviHtU3XzXqPx2FB?=
 =?us-ascii?Q?FkW8YjfzW5SaCYrpiuiFxpavEsJF8bvump/Rm146ktRU9kVZdWA94wL/23mK?=
 =?us-ascii?Q?F902SUF1JDyMv3zllThD/ysItC9uDwdavfYu+5riTIJb1cunebeKTCL1x3f2?=
 =?us-ascii?Q?a/0cdClSUNiJ72ZPOu7cKt2Wb6CUnSUb2xzk7D3jjwTOuSftbJtSeqSLkBgm?=
 =?us-ascii?Q?kQY0q8Z45I7xThCVXmamyWuWtA83tvGoR/yh7P00k/Sn/EkK0kWQjGF3R9RP?=
 =?us-ascii?Q?0PNtFE7df48wIal44lPdpzKSxrCs3t0qr5G2MInGyJ15WRA4UFukw0Gzffrn?=
 =?us-ascii?Q?DsfK7vfvNvQdn3wBJ/pHIjudbhrb1ereQCVbuIYFw6Xp18vGF81nXBaxlUm3?=
 =?us-ascii?Q?EPWZFIUvhYcneHYY2vCc5rOBTe9Ps4zOLi5beXC67eiQb0H3JnxhEnF24Ggn?=
 =?us-ascii?Q?Rn9UsYjOVsC+9hN2FzeWMxNR8YkwuPBEXvvpe8kwBki6Yzrva/LRH6TJIAue?=
 =?us-ascii?Q?lKDa0OQE//SqqwRnkULogETfJgDkdXc26MVeTZ3NwaKm/q//5QK6b03lxOjF?=
 =?us-ascii?Q?mLH7xWaH7rUaBOLV34s9RHz54gVujMYSWZy1QX2paGxeSi8h04Upz3uysF3y?=
 =?us-ascii?Q?SOTud/ajqIlqHGdbUiOKDKIA0C6PH+ynFF9IJDG5CES0eYByj1bwY8sk6y5y?=
 =?us-ascii?Q?5lCUg9Ja1veJ6RGtylgXkqKTaV98aMmUAKNp?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?V3G7CK6tEY1RQmJToVerjuLHLnha/i7ctu5uf18tgjnP7xuHCNrirk4Epic1?=
 =?us-ascii?Q?by+tJqUYOML0OSD/q0xkyUDCMAtg5CQMLLMFbOOJddAxQJFuKFlRF4JZWg70?=
 =?us-ascii?Q?ei9Muql47KV9/PiPdVeJYSrgNc7yeAD+gHCkiQzEv/r+ExQnQm7ZAEBuk7aY?=
 =?us-ascii?Q?X/nMgnNfIpzgLG+0WeyrsQmlEDGmCKWqc0veeS+fJ11sJsS3EXTPJE9VKul8?=
 =?us-ascii?Q?Yq5XuoIy2fmC6SeftKt0KBy22pFutiaOJS7dUpON2PCnIS2xGKJvJkV9oM2U?=
 =?us-ascii?Q?fOot4rkJL3aUAi/jxFIhjh2V+M4ijfHGPgt5DGeT64qIKU3K+UicBoG8/qlV?=
 =?us-ascii?Q?cMcSsgCZ2OA2SCMUMjzp7u5AroRx8xwLMiDMSoh6VEK/BSZMuz1YxOlq1ZEO?=
 =?us-ascii?Q?0/fszJf5CWyXOTpi27yQkDINGts2+DljDR92gg83pl9x1xdBWSbQ80GagpRV?=
 =?us-ascii?Q?ET3b7nz2ATtYSTeJXu4RZq5uTBspkwjoCg88nlR+YmD7vmS8Lv2okM/b7Noc?=
 =?us-ascii?Q?8CBJA3x4At4Rfmtqj4NtEPkVa/ncXw85pVCA3kjpvDBWV0iSCHma7vWpx3Ny?=
 =?us-ascii?Q?qU1yO04wld2q0EDVC+sMH6yc7SUvZxW0qiK1C6NuEuTx7xr99g1muOpyr1Nc?=
 =?us-ascii?Q?IK30o51+s6nPCoByUWdjm7P5F/MmrFSsKxHE5YHI3NYQ8oCGPeBjpEFr3Gan?=
 =?us-ascii?Q?+oMvX4wANV6zCTor/w6Hsy/ocP/Xckm/ty5rfid5759CHxG9Re6PDcU+k59u?=
 =?us-ascii?Q?9R0wT113X9F4v4FaCtXhdEMrmG20cMIaKNyFj3CgE1kIZzTNKdb13SVZSh/z?=
 =?us-ascii?Q?Xy22EumisIT+jgHPEpsqRWMvyLWwWi4FiCt+09DwBDNzGlTo2Xs5zAC6c8Uq?=
 =?us-ascii?Q?Jb37XLYAs2IO0YOom4LCULReboHr1+Rbq4yp4dq8GbBuevSNkINRkruhLxTI?=
 =?us-ascii?Q?0Bar7sQloNk8dyQc3vuY9PtAK1DuLuhO68JpF75MrT91+htn7dop199u3R1t?=
 =?us-ascii?Q?YHV7FK/R+QBj+FEHKyf+vzaljVwxL1jNGVS+JCgcRlTCz4R9KY7Gr7ZX30zb?=
 =?us-ascii?Q?SpPXSWSdSajWGB36HWAqHy+d5FX9pkOYU8mLXgA6YTJwI64h7QsmsHRTJmAs?=
 =?us-ascii?Q?X+rN0VEiPS3UatJv2L4RoIgG0Pd80TVPnT4ysI5gn78bqz/KxAg2+4vsLSoz?=
 =?us-ascii?Q?Q3hFiOLRszU8pyHP6ftlhL7/v4yQqVvwrLOimfUtwnpXGHvzORH4UHggKOJr?=
 =?us-ascii?Q?a4DUzyNO7P33p9b8VtEbmmcRTDvMI13PzRsKsOo1nAVEAql/umFwgOql/xmj?=
 =?us-ascii?Q?v6ZZJj4a+LJ/5/GG42MbbYD30r08hZo4HHwC+fpRNFqOIqFFuacRGeFyOXr0?=
 =?us-ascii?Q?SK+fd1SF311iTv8KL/YW4QQNnFvMRoojNEFocup076EW93iOjTZYQNh0m6dU?=
 =?us-ascii?Q?AU4NnzXBDHTSX+OMa6xdxxGoy5otL37Vc02GC6lFGZftO0ZEs8Zyt9UcXZEz?=
 =?us-ascii?Q?fEMGGMzbS2cbWs7lmPuPmiZhIzjNvn27BuEtSJv3R5YhrS7VnNaqgqiTKhyX?=
 =?us-ascii?Q?+NDdHeeCYpqOHhNjRGK7ynkTqZd2zv7kM7WzU5Cz?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d26b48b9-6818-4067-69b7-08de280721b5
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 07:33:43.0655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o9SJIgGQLFLznNmw/7IsX7R82SXf8Rhmz3yPbkcnO/5HQaP1EUVHZRwzkKXL2S6FucjTyMoIa0IJD1orUayjww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFC295640A5
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIwMDA0MyBTYWx0ZWRfX6C0FU1A1WYJY
 bGBnUADvX6wf/a5ZsLW6gTN0hQnaSAyIlnWs4N+p3USpaW9/5TZGgprIxvz8ZqGfbZh7boNwKad
 0VXcIuiHl5S0MZSnklYI+S27PlexE4pfiwrGTV66yrxDzH2I4Z4xr8aVfaaXkj68NObf9NjMine
 K6KXY5yUMDyJkUhNp1n25iPpnVYah6TcLkZwHC1KeXQdoxqhOLCfJINsxYl1hbL9TL+PJigh6Db
 KTcqssW4PU1cyLAzU6cKgEXvAxjQP4Wg5lPUbmP24C709xhRdNszWZu1JrNKpnNWgnYNy4KPotM
 RVaSyOP0bv01Ddc3gu+Wxxnq9CDCW/yZMHb2VU0vX+0zaoP/b6DIFFddpnvLrAVBmHeO2MBL9i3
 iiggSbDnwslecwRPov8rMu43eRI6dg==
X-Proofpoint-ORIG-GUID: HI7uZi9Ff6_exhItrQofcXlIJvbcSDAw
X-Proofpoint-GUID: WDIuz9EV_KqKPXXMGOm9OZlSwsal2sBf
X-Authority-Analysis: v=2.4 cv=Z6Xh3XRA c=1 sm=1 tr=0 ts=691ec45b cx=c_pps
 a=NlF6qXdsITzFGNsd7EO88Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=t7CeM3EgAAAA:8 a=g4CbetNCtQ0d0bBCZg8A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_02,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511200043
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Nov 2025 07:33:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18466

From: Chen Qi <Qi.Chen@windriver.com>

The cooker needs to re-parse data in case of different featureset.
This needs to happen not only when some feature is added, but also
when some feature is removed.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 lib/bb/cooker.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 03f262ac1..1c06737ad 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -90,6 +90,11 @@ class CookerFeatures(object):
             return
         self._features.add(f)
 
+    def delFeature(self, f):
+        if f not in self._features:
+            return
+        self._features.remove(f)
+
     def __contains__(self, f):
         return f in self._features
 
@@ -237,7 +242,10 @@ class BBCooker:
         original_featureset = list(self.featureset)
         for feature in features:
             self.featureset.setFeature(feature)
-        bb.debug(1, "Features set %s (was %s)" % (original_featureset, list(self.featureset)))
+        for orig_feature in original_featureset:
+            if orig_feature not in features:
+                self.featureset.delFeature(orig_feature)
+        bb.debug(1, "Features set %s (was %s)" % (list(self.featureset), original_featureset))
         if (original_featureset != list(self.featureset)) and self.state != State.ERROR and hasattr(self, "data"):
             self.reset()
 
-- 
2.34.1


