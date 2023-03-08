Return-Path: <xiangyu.chen@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A45C678D5
	for <webhook@archiver.kernel.org>; Wed,  8 Mar 2023 09:56:00 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.3386.1678269359136106655
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Mar 2023 01:55:59 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=2431cb6b16=xiangyu.chen@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3289rHji029972
	for <bitbake-devel@lists.openembedded.org>; Wed, 8 Mar 2023 01:55:58 -0800
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3p6ffd0br7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 08 Mar 2023 01:55:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMCCVCwz+B7sxJzd1WCgkqsIk8GbR+vpUUDBfeQ+Nkp1jLHAs6gOdLT5NpgmwttCgams1ugWKSnqxTQqI5tSvjI8WENxV9agOWxo3imvQFiNMgKg11dSZx+FkmODdiG05ehFw1RUOMp7QTiCOMjaWauOCWYSsl9vcxVrtY4KBoa2oW5ONRRuDOsByk//E+0F/D3BtzzxhgYpy+J/MQKMwubeF6/mttLejD7sgFMz12bDqfgel9IDiQVWXz/+Y54AvDRInzWhrkvOOWgrDhij7ZP/usWA/DaomGJ6MHQZh4UOq4Qdz01J2cEt7Q+xtaJWeZNffNseiDVIIVUoQScZfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4XZbJQ2i0hrlF6XRie0p3RUBeJSjTXr+Uqy3dxyL5o=;
 b=KT9X7f7uzrqUeROeBZtFMzHABZG6qLcpTxz5UP5BmEiK6qj0sCrbb04lFMc11NGINfbKMTDmh75jPlKqjeTHWe3P84yCJOEqF6tZxgfQg6atRy5YoGQsu5QJfNCsLdhH4YeW1m3ni8pUNNj6SkzCNbi3pO7l8NMowoUDwkkERMe48jaR5W/+tyyLBR/x/HeXhm07aFZmzaNYhPLSzFvQVBzvxQsmj5pnk03wxBctX/LQG55F2gOg8TgKECCDQgb8Q8ChP+yepTRUeE3kE6RjnCKaC9f687FGwGdnI8PGtahBJqChIACvz2keeBuHnFJGbz9xw2fN2T82mN/0W25TKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by SN7PR11MB6655.namprd11.prod.outlook.com (2603:10b6:806:26d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 09:55:56 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f952:3d02:d71:cc68]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f952:3d02:d71:cc68%4]) with mapi id 15.20.6156.028; Wed, 8 Mar 2023
 09:55:56 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake-devel][PATCH] data_smart: fix library name contains special word cause do_package failed
Date: Wed,  8 Mar 2023 17:55:39 +0800
Message-Id: <20230308095539.651015-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::10) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|SN7PR11MB6655:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f2c3cf6-68da-46c5-b864-08db1fbb4fb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4DiC/pMkVEULxXTSbWz/t2ERZqvkOcm8wmUea8xBUrxNi+ELH2RTsAfL9Cs+vKmSxH71fQ9JdDkKk/VS40Mqg73c855Fc6n34ivQk1kTrPQlbBcw2P0ek5360/K9hZH1jiO0ekag0Es9Bf1NwiekZbFV0fNfZ/9rLmttDACeqW69bXDPXFqWc+9zBCp8L9D/Z6MzZit9GQicUZjOosRMa8Zk+IUcfJSETdfHBGih5Q1bO8LIPjBaD0uzH+dATcB3mfFPfrQd4piH/C4cZMQqw+O3168MVVh27efZ5wBt6blMFnpM6mE72eIzz2+iUDQH6X1Rf5YT4G5njrBnG0zSVB9pdztKVM3sM0kL2pQQ913z/xqqhzbqUbV8uzmqvfcdt1MqDeO/zk/Izn0W28zSPaD7QnFJpr9UacCZp+CCleQWnVYjrVQVES8jjVNReyB5yPIY0h3dUJYLIJW4swpwxWNckvViJjHXW7Rc3JVSLebehHKIU3JkDk0JsRg917B6ayJR8XL3Sn0IKTN5AOSdO28kZb69lZw5056OjE4XZVTgyLSVZAIt73TdfN6tQJBXvvU++VNkPj1DC0gO3qIGcgQqYmsTjvHlDbT52vkVVCxAdAd7IZLf5tEvvOAOdG5oSKjsbJvuT1Lp5oHSocl44BVP/A8pQqwbZjjtTNWp5Mq+xOMc/iAF1528CSm5uf5p39N3AylWJLz3NAZg7mz2dg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39850400004)(366004)(376002)(346002)(396003)(136003)(451199018)(6512007)(6506007)(2616005)(1076003)(26005)(6666004)(316002)(41300700001)(66556008)(44832011)(186003)(52116002)(66946007)(8676002)(6916009)(66476007)(478600001)(6486002)(5660300002)(8936002)(2906002)(38350700002)(83170400001)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?BbJgRlv3R5j1aBcpl/+lSavRTsAyTeF/tabauRfNGnEUDd8cZpj44Xah+FpT?=
 =?us-ascii?Q?z96DSs4tmR4SG4O/Y1sH+DM7f8hw+yNu19TqBZ8IVgvVnW1mqbSnr64YGetF?=
 =?us-ascii?Q?xqia/rDSF+d/SGcQJelaWNKqG2gm3nHl6g4WfY+CAcxbcDc/IrLNvb8h3LeG?=
 =?us-ascii?Q?dxwVvloDOzCGSmOEFuhJb6Pe+zqAE7xcNcBYW7LKaFmZhvXk75XuZk/ekfcx?=
 =?us-ascii?Q?9xWelmrVnK8tDb2Vyet6wZ4XEFm6z3oPU68I1ES/m592tyeuRbyTNXdfD3wy?=
 =?us-ascii?Q?vT27yMZX2Q1N587aOT7H7xdwYO7mseV30ALfSHTy9aOQvphv452GgJ1DySYV?=
 =?us-ascii?Q?HPyiMECAnY9tC5mUEDw5e0HvMWmZ92vibMLaPwjEo3U9GGzFELQ462fS3kS6?=
 =?us-ascii?Q?M5BZeAmSYhCwhQLEbjcqU6tmSmCkQzLfYfmj4PTnqkniirZfJKTZ60+vtytY?=
 =?us-ascii?Q?veNAuWUWQ3gQpHSB39TGfAvQ9Y30Cxhj7vcnIkUyn9exUweTG+evnwFvt7lY?=
 =?us-ascii?Q?KOhoxysYrwaFPDXiEMDkLMtq4rpWcGF9K0yUnO27ex2P6/hEYlvAxiGgV0Jd?=
 =?us-ascii?Q?o/NhxRLHBz0PcLHWGWEk1Q/QBZ/DAzTo2WDiLegeQULpnuwzwKwZsW4S1pJA?=
 =?us-ascii?Q?OBWSpUKlscV7Uftd3IoMufAlOQXNw/GtdDJQaoJV8JFkg3sGMMwB0EGx0R/4?=
 =?us-ascii?Q?o3k5H6TzdSBnHSi2eAmdmHECjjDOkh3TiVVyd/MQVEtDyVbjfr/lUxgUsgLr?=
 =?us-ascii?Q?if/iiESbcvVVJfNpczkkwW22MycmMGVXhCDeYxB/AyOnJAgiOkCq9UXimPA7?=
 =?us-ascii?Q?H1uC+xtg/5qAr1qQcm/wYWmABTMFPE25rZ0P0kirlqny8vwLTH+owycV+1YR?=
 =?us-ascii?Q?dHvmCdNoh4kE0eJ2VP6NFXd8uXFYAx+dzYftdiUgsEtBV7zAZwGLpWTWRYtd?=
 =?us-ascii?Q?GlPNyCbl4adS8TgLpXvEDpJMBOVfsqNucKxqLwZvR+BnvM8V4ro2FvmOivtQ?=
 =?us-ascii?Q?r9Qej/87Ht2c2ci8nPcDuDKrbkJSxYINM99Laj2nojDJ2hLhXZi5XgKg5VRI?=
 =?us-ascii?Q?SQXJ67RCzR8jUic4HFrOLsI93cCwte4QDusaDPK5Ik67r21DLhAtD6qaqHzx?=
 =?us-ascii?Q?wTwlM1xXAAQAWNPm8dxRujYBAcq7ylnJwwv4qIHEn2iD/CSzImePxWNPji/a?=
 =?us-ascii?Q?+4pJMgQBo8x87SCtPSBetdBx6gOJNfB6Kpkx1CbhyBZt5BLNMvfRpV29hm8O?=
 =?us-ascii?Q?NrZoEwlDwJdI1LG7vHQyqSlZHdK7D7WA8kTOb21mOthRVijS2ImDUXS5YaRL?=
 =?us-ascii?Q?DEhrxsBuxbh9veytuw6Bxup/lxxE9YNX56cZIz3wsro2fzVXwuzK4Nk2tFcE?=
 =?us-ascii?Q?isllVKmUeTLHBSLswI/o6aoCYI5EhGrX9b/a0s5/JsId1/nDD1c2hhMU/Hig?=
 =?us-ascii?Q?XTc8CctGQwtUB+Bq4Hz8gn5fXLj1ceF7AyLfdSXmi3UqRVjxXH0lQDGSHFPm?=
 =?us-ascii?Q?B2FS8YjIRWkR1IwSwSkqveTtMXsAtKkx8wlJgykx2Z6geFKjhuSADab7BHam?=
 =?us-ascii?Q?t8VAfXeUZevva+KtW1QfQBkHLpCAcHfEyZDfahWWfN9LDI4wMzTJTe13isD2?=
 =?us-ascii?Q?pA=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2c3cf6-68da-46c5-b864-08db1fbb4fb1
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 09:55:56.1160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KvbBIiRMyX9lvMDamLfkJZBCO3b9l/lq/AzbZ+uwVwUl0RRny1acMJdWFmFNxS/N5X29mGecx0etu58bJx7fg8PeoN3Ss22UiEFZF5uyDHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6655
X-Proofpoint-GUID: XeRtXOrmSwWMkDmXHQIgForyJ5FEXID0
X-Proofpoint-ORIG-GUID: XeRtXOrmSwWMkDmXHQIgForyJ5FEXID0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_04,2023-03-08_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1011 phishscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 mlxscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080086
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 08 Mar 2023 09:56:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14525

From: Xiangyu Chen <xiangyu.chen@windriver.com>

When the package library name contains like _append/_prepend words
and the pkg-config added those libraries to requires, the do_package
would report an error message:

"Variable xxxx contains an operation using the old override syntax.
Please convert this layer/metadata before attempting to use with a
newer bitbake"

This was found on latest version abseil-cpp package due to there is
a library name called "absl_log_internal_append_truncated"

So discard to check a variable with "Requires" header in setVar()

Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 lib/bb/data_smart.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index c597dbad..fc33d34c 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -539,7 +539,7 @@ class DataSmart(MutableMapping):
     def setVar(self, var, value, **loginfo):
         #print("var=" + str(var) + "  val=" + str(value))
 
-        if not var.startswith("__anon_") and ("_append" in var or "_prepend" in var or "_remove" in var):
+        if not var.startswith("Requires") and not var.startswith("__anon_") and ("_append" in var or "_prepend" in var or "_remove" in var):
             info = "%s" % var
             if "file" in loginfo:
                 info += " file: %s" % loginfo["file"]
-- 
2.34.1


