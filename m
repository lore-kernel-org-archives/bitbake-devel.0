Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF84CCF9F8
	for <webhook@archiver.kernel.org>; Mon,  3 Nov 2025 07:20:58 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15365.1762154450895656600
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 02 Nov 2025 23:20:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=AjajbIGC;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=3402980684=qi.chen@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A36UTsx2757392
	for <bitbake-devel@lists.openembedded.org>; Mon, 3 Nov 2025 07:20:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=brNqEClGU
	M6nCO9NvaAZgcJzb3MRay2rakAsmKCJcgE=; b=AjajbIGCk2YGHDqYI7blaNyHK
	ROp9E2/9Hy+RxTQeApQJ3C++Y433eNi3oswjrIzidUSNxvqZrIGrBzvQJ9gvaanR
	D64slQpJ+RGWm2uD4wUlgjsg5Q3cPKgAzEZdWaB6F8uAopmchuJ/3ISIrDdirMtM
	wE7n/bUnL4HUzro4SATqZFFM79nAcr6WIIbrvQPWkOMnoQ17bZxR8h46UOs4UzHO
	tRfdkdu25+4hYyYhOFZAEmYsGdF2cx/dz6PPs+H1T/0Nv/3OJR3gtNYIwLgG/ggt
	h4Kc1UVN0Uqx2a0o7QFknVIrHmfAWH4DVWDr8y1i/Dq/DlBLGLfuOGsoJLOIg==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010043.outbound.protection.outlook.com [52.101.201.43])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4a57dx1ge2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 07:20:49 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qdweMAKnkukCG8h4TBpv/3g5DW/8hbkeXG4Vm5iVoFplcfg3lWiaZxb3DQCHIYMN/A6ryh5/VvRS3enjRjwtnOtTJe3KoTAyEfWUI4V10mXIjrW8fZMBW1afP2IrjU5WAj0npS/Tk8ei/5XDHn6WN4+hM3hC/dhADQi+0yZU8yF5gyYQk1jUWYcF5R4bncLveF3wdodpxD/ald6OrdFwp0yRkUnjA1pk4vqU2BrXVp87xtarrogWO/1ZQmHL1cupqiWz5Uva+GQKOJT4nmnj/Gjff2kIhvUFiLq97JDD2BGAMWaj10YT505zogRQpQleuyhTYZOqxERKbho7o38Zmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brNqEClGUM6nCO9NvaAZgcJzb3MRay2rakAsmKCJcgE=;
 b=jo8tabVCnZDhG1t0Ugtnf5XT2jesb36uCgQSC2wLpUSl1mva2xiMwTL6O71JqPh1m6KpVmTzlObZ7AKK7XFGlf5xTgk8N0lgtrr3PiSr8ezmXLQwb8t02FEFvEj7oFUxnv7103FKsb3i2SpDIWQRAgyjiQnLQ10aOTYAMGoG9k0adczLzmWFvWIjdKut3QhNkD2aTvGuWqpxpUAWEK8CkLVd8fyOoFy5edvx2l/Rd6Dc2QJmWq4beu7Nh0ERzbp/gGh4Yo/4B60oMdkyjssEABnXFlb8+7gXZR5cmQrHKPquPNALGgttLnqC4Svl88E6zbP5MjHu20WMIkfeozJBJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by SN7PR11MB6775.namprd11.prod.outlook.com (2603:10b6:806:264::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Mon, 3 Nov
 2025 07:20:47 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 07:20:47 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org
Cc: alex.kanavin@gmail.com, qi.chen@windriver.com
Subject: [bitbake-devel][PATCH] lib/bb/parse/ast.py: exit immediately when fragement is not found
Date: Mon,  3 Nov 2025 15:20:32 +0800
Message-Id: <20251103072032.1015053-1-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0038.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::7) To PH0PR11MB5611.namprd11.prod.outlook.com
 (2603:10b6:510:ed::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|SN7PR11MB6775:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d234749-217e-461a-4e76-08de1aa981ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?vx5MoAhf5GQarwQMYF/Zu2od60WpIgYz+JXRQ71r8uy0bh2+sKXxjn1nxQlZ?=
 =?us-ascii?Q?bnx1eo1IQxYDc4ku9Ol+79B+8CNQixuxV1EHuJ7TAzVOIKV1Dqjgyw2+5Epu?=
 =?us-ascii?Q?kDQwRxbAVlxIaiUo8uERzW7VfTzguZw+5L+ZYWEAGW+U9jyGjEBjsEXY/uSN?=
 =?us-ascii?Q?TBr//iH2rPlLhcf9gdKOnPDGZ/PNmTLCuWD7uCxQrgJwUod/R6Kqz75pODte?=
 =?us-ascii?Q?SwPR1E6xnUnNQ2VX5liSUR80Dor87Nnk4eaUfzU75NIKV4Hog8Z8tKup3R+u?=
 =?us-ascii?Q?S8mVFUk4G7ADUoatBuBiCeAERbt8gxabZpTTGC8NS+lxNCe9rPwhjEUQpO0q?=
 =?us-ascii?Q?7KAXD3RigB68MBm9cnIQNgp4Q9dmCb24bZqEuCroVFxZq4HTyRui/jZW/AkD?=
 =?us-ascii?Q?IyIiocGJSQRg/qXsf3lZcIndRHGPf/FLLK3JNlV8KU49AcCXUn/ISrpq4UwF?=
 =?us-ascii?Q?6Khh1KiNJG6PDJ+TW70fpgjMBm57KWc02PRSMNxYiG7mgKgysb9d+M7uZrfB?=
 =?us-ascii?Q?JDV9A69EPqJ3L/N/N5kKUXVMWcOl0vduvBQf/g5KUNcFOQ2ESiBNNJ9GEhp+?=
 =?us-ascii?Q?9Qb2XlL2Bz9RAGIqmfAhTD1xYNqWz5FtT/fY3X0q8l24Ztcsis+bmJVQlzqV?=
 =?us-ascii?Q?or+/L6QkTLgOYKLtcLvWmUwahjziVnnyVoSdCoI6lrSrN6O6m62UKDcIW/MC?=
 =?us-ascii?Q?rEwV4jABg5r1m4BYJbkkwdvmamfly5NFfKoctrHf/3rKyWQ/uywlcOM2ZOaF?=
 =?us-ascii?Q?+QMF4Z43xSLGKR/AtuGEaqNzVa47SBCXeC8Aecf64Qs1205EanLEvg/OrMei?=
 =?us-ascii?Q?PQOkbgo02/9xhvIKQNmZ9BrlskcSqvpTd1XB4wsUMJREs0cJO6/wEiu8tOe6?=
 =?us-ascii?Q?NQD7muZbwixkOMVJQf7+/QFhuAtduvRehRV0z7xafKoWFPsXy9GbqqD75yfJ?=
 =?us-ascii?Q?xbEf+rOjBwrQMDhl8TlbIP9a2zxoBeMGa40q4zqKPy6BVyb2r3FKMROPstZS?=
 =?us-ascii?Q?ZmrSQCD+qvIHU8X6v4X37ZZ8JpkIvrn1nvfqxJX9uQvBOZ6Yvd0sbGF5TWrh?=
 =?us-ascii?Q?5GrFzSNHPk367NRq1lykMDur90O1otTCsMWQZ6M54dWcACTitSgFN7Mv7WqK?=
 =?us-ascii?Q?QlS3Ojd0FBFww31XB4TOllpFvnngYKEbYxY2sOt5yLQDwjJ6SCv0shLwptGe?=
 =?us-ascii?Q?uny+JaNuz44h+bhfa1dcW4mRoNXI1VzQTqjBLTehYlB/M1E/9Xw5VS+yAzOq?=
 =?us-ascii?Q?iYOGdmG2UB5xj5NWl5ho5MEiW8D4at2u+iu9WK2l/hZM0J9hRZaPWW4c75ju?=
 =?us-ascii?Q?4qGkbJZaJwucAbmsyPCK9M2J6PiaVOz6pRIjWZobypBrO5naCb4jx1kVpEZC?=
 =?us-ascii?Q?cL5mkABfS8zWpQHxqcLcObkz1N+Oj9irzhX1aywoY+Jsr6yFzPAAuoysO2qo?=
 =?us-ascii?Q?qkha8UV+FRYYi4RXtm1vpk7taXNL15CN5TuaostximX3B1mGujEZhrolNFSx?=
 =?us-ascii?Q?9nV/cDPa8LMQL5BzuetQAINhs89cGOtG1N+7?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xwiLzwKXNsgTHCsWKf3gE82i4B2IXR0/W+aGiqcesvxZZ1AL+ayZPNOSRGeA?=
 =?us-ascii?Q?/icc7XTgYHpMb3+uUvlAeyUS2FI8UdtmI/fklRoE+GWuC2BHemD9hDRuaGUP?=
 =?us-ascii?Q?N1yBaskjRT7cWBwIhDKB2SUNpfyRr6nCZOzfMo5wAp12qvxDOTj4BCQRTdDP?=
 =?us-ascii?Q?/VsZksSSbLsX3BSrWGAeDHJiGk3aCrDNU6w/RLLXVTz2fIpBBrJlxAAWbsLH?=
 =?us-ascii?Q?fqsJ0zf3TtPq3gZ0k7nOdBb2MOOtwqvq24jTklMFwmzeNeO4YuocBJ/Gnc0T?=
 =?us-ascii?Q?1zN06nw3cTEMRjdYR6dLwbqd1kSNg7WCblB03xD9TKmLj0r1aSlV7h0ViyyQ?=
 =?us-ascii?Q?rFj+ejFkh5jHO8pzJ20MJtpjzEiTJvwvuN+RXHJF+RwNPOIdcjFUkUu82XnS?=
 =?us-ascii?Q?5aZ6a9c5KO8b6OHWSbnVYw4OtonjRyM7abrdPNGfihxtMmv+YJmB872xq/z4?=
 =?us-ascii?Q?/onAiKrja0+9XxpHWfN3CRXL8RPJXH2MBEv9bIre9e6GdIARIRMTUJ0adKRm?=
 =?us-ascii?Q?MvIGKfBwQLjMPX8j/D1o9uj59JxCWcQmRrn5l03KgXyg3SX3ofB0n0/v2h+T?=
 =?us-ascii?Q?jNlchF9mOi6pF78+cnAN/WvPomeoMJouuRhaz9vjrtB3aos2RUaNu/ocS4YD?=
 =?us-ascii?Q?du4XSnSQRT2V+i2wEtR+6dOJB8mR1AAJAVBnkyP8DFN98IDgc638FPUSB+l4?=
 =?us-ascii?Q?57QUo3N2lFhqXa1Vpo2BOdxtaeKciwZEY/kVR5RUqd9evKOFCaDXBBjz1UYD?=
 =?us-ascii?Q?wWGh2DErNaXGJQXfWlGMdWbglu2ltBfeRQ5XN2orwI/4E9IjgC+kSHiHzyKh?=
 =?us-ascii?Q?FLBfX5mqC70+IShoOycQxapS9iWAM4Qc2NfP+DMbtAu1alTQEKwTIXZ3EWFd?=
 =?us-ascii?Q?qs/Izwd62NxEVIhWXSrT0KRS2gCdqfZ27rm0byOKCnu95KLN7+h4DPYiDFrL?=
 =?us-ascii?Q?MARfDMOl7tz9TPjuteNPvHDjK8EoCk8uCm7/x0/7G/3FlQ9sYb8iltN0KI/Q?=
 =?us-ascii?Q?6LyAcgcA1aQzSw9SDGSlU9fxIq2yAXgytpJSQC4j2zZEqXGZX8381evly6/N?=
 =?us-ascii?Q?HgH3namTlF9wCHoIdB85B77yKNWe7se2rC+72OIfU3AQ1tmFIIYaZdtGS99N?=
 =?us-ascii?Q?ixLmNa0QZwQ9sUEgTrN6PW8Z9Oc2vbdnFaKczNiVk7eeVsYSh+xqlDisjq89?=
 =?us-ascii?Q?+YctOzrsk8pqzz563s9ng7kTvGhOMtv8ZBr3JfCW5bUIewFjnciBpH4RX2gR?=
 =?us-ascii?Q?yaSEhRxYQcn+77UOkdZvYwavKvhHmptmUruOgo+obZWKKtFLFCi2Q29yDNwY?=
 =?us-ascii?Q?IlXPpSpNglH9Wmd55AKQhZ/eXhr7alEg6r7iJ7UJIqwgi86GNbdoNoG2v7h2?=
 =?us-ascii?Q?GzRPrIZFwMope97IISfKv5nZMnnZJs8RF3Q/aKVjvycKC8ay7WCjupkgQ/r1?=
 =?us-ascii?Q?kyo41nrXOZ30yh0q2XWBUahuh7Dnr1oFvWoSfPbkRcaY3dkvCNeHgd1rvTFb?=
 =?us-ascii?Q?JfFP9LXNrz4GjGdQfQ+kbI663DIWb6j0DZsSsoAdPCxjiCyG+HI4d9qHmtpz?=
 =?us-ascii?Q?qDJXfQ+H7Sv3ZRG+Yi3b6RSvBONDdJ+HGcsQU1Vg?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d234749-217e-461a-4e76-08de1aa981ce
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5611.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 07:20:47.1748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dkkFO0Ug+9EW/vj1HqbEGzf68I6xzzr5SY3GD6g1gf5hdU/O6rsyWPWgU2qeWCcLq4tW8eO5T1GBtFLc9lqaDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6775
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: Yiu3ChyhkFSN14kN_XiMYRPIng4SfyrO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDA2NyBTYWx0ZWRfX/UCq/O7xjQJJ
 13pDJmx/FwKqL4mIP5yo8L0pkokUnHhmDvPMXERpSlpl2yjf8Kdt89Tux1k3WFmRMtEa12FUzxE
 7doTJtnR1an8c5aNnPm5UJx5oA7rkNxnL9vl4u9RuuKjvP0LtvGlLqfjcKibTVM6pE7zaSRACUR
 sRjVBr0VtuxOQzLjZNEHEB1xHqnzl5PVqUQBEvReIhoxhkMXIBWAZIpMe4Xjq1QklNJSDzdNRPm
 zd27D8xm+fTY7KI4L5yCl74XJVvql4Ki3+CiHWQ8h7l+5cprlxI9mIlsCBlI1zpFcGHQBi8IzFQ
 tDozO9p2PlGzG/3bf3SGnwNOE1c+X0M1zU3OLn5H0thYw/RBHMxUeD44L+3gD5wh9ey1T7AushZ
 EQDrv6pVUfz23aOasXEdBb/l53rPMg==
X-Proofpoint-GUID: R04HtTlvHRU6dAjf2zjFnTy4w2VR3hcZ
X-Authority-Analysis: v=2.4 cv=BeTVE7t2 c=1 sm=1 tr=0 ts=690857d1 cx=c_pps
 a=MXKEcm+r4KK8PT7sjGsI9w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=t7CeM3EgAAAA:8 a=AotRN4lS-wiKtkwEGOIA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030067
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 03 Nov 2025 07:20:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18233

From: Chen Qi <Qi.Chen@windriver.com>

When some specified fragement is not found, then the build results
are usually not what the user wants. So instead of print out an error
message and allow the build to continue, we'd better just exit
immediately to save time and resources.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 bitbake/lib/bb/parse/ast.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/parse/ast.py b/bitbake/lib/bb/parse/ast.py
index cfead466e1..1351315d78 100644
--- a/bitbake/lib/bb/parse/ast.py
+++ b/bitbake/lib/bb/parse/ast.py
@@ -410,7 +410,7 @@ class AddFragmentsNode(AstNode):
                     data.setVarFlag(flagged_var, f, val)
                     data.setVar(flagged_var, None)
             else:
-                bb.error("Could not find fragment {} in enabled layers: {}".format(f, layers))
+                bb.fatal("Could not find fragment {} in enabled layers: {}".format(f, layers))
 
 def handleInclude(statements, filename, lineno, m, force):
     statements.append(IncludeNode(filename, lineno, m.group(1), force))
-- 
2.34.1


