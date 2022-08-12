Return-Path: <aryaman.gupta@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F92C3F6B0
	for <webhook@archiver.kernel.org>; Fri, 12 Aug 2022 18:22:55 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.623.1660328569977116546
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Aug 2022 11:22:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=DM3kEhc/;
 spf=permerror,
 err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}:
 invalid domain name (domain: windriver.com, ip: 205.220.166.238,
 mailfrom: prvs=52238f57e9=aryaman.gupta@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id
 27CIJA0n013437
	for <bitbake-devel@lists.openembedded.org>; Fri, 12 Aug 2022 11:22:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=QgCHQV8E/VVDmCP9KrzjF/qxcIZtZQwx27Nm92sQnSk=;
 b=DM3kEhc/f4jO5d7Q70abAEOuVfH+M4QFvfmyg+k51R9weikBy4suc2uCW24rfdeoKvkk
 FugwZS8CiBd7PZGhTnj8ubKGvyoSfmP9sCfdq+0E45D3FMe0kvwmD4w+gRBTuiXRvT33
 3jgdj1cFYEvW6rcWeuLUekqvfMK4FG8boSnG/VZ5n/B60zHWp+Vv1RFgi3mUoRvJE2fz
 sCMDohkTYOx6W0498AKtRyyufQGw6TRF+6oTwTXjn7VLpzDUFRxLqyYca9rUUyPhYCRQ
 Nht9xtOcpU3VGnRi6J92UhHgjrmTrxcMWJYl21kzVD/X4kxTA1NCRC7NnNspNM4Ey5KS jw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3hvqf29gtt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Fri, 12 Aug 2022 11:22:49 -0700
Received: from m0250810.ppops.net (m0250810.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27CIMm2S022557
	for <bitbake-devel@lists.openembedded.org>; Fri, 12 Aug 2022 11:22:48 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3hvqf29gtr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Aug 2022 11:22:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GsmTItsIUeJOBRMCZzFwvmWmZ5yWHGTD7EHp6cfDX/cDhk9s8Gfzb82B6VZOUoCl6bNS15BfD8934/w8+5bvjGXKTkAwxzMN/I/wCOLejjCsXIw3ruE9wIvFOvINeDUIC1Yeq+yebAOvZBN03te0MNuEr3Vi/62evNjsYW5IMwPsbEn95RL1LyH5XAISl0no/2XgtELl7WDGDJwytEt5uLFKTabFdFiBmKohWWrfXA1TvFiannI0d7tTd8JXRy+5OUEnOhmlGAGZ/mkk9SQV650sfdnLCjT1btyT4BrjSqaiICEebnvDMcBIbgKdB0d4Kj4oibhQVh1a/ytCnTg43A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QgCHQV8E/VVDmCP9KrzjF/qxcIZtZQwx27Nm92sQnSk=;
 b=gqOFCbbrtNq4sRiXejSdQMErCgbmzT9stjETl73K+0F3ISeoclJiPU6melvK5fju9AQwbEqHgkzzXWIr6qYXALZVvpuGQCCxFM+SK/s62OySQL7tyKWkoItvvotb+zIjkP8WWNfI7Ip4SImB98OBy8S8CWi3DfshbaEV1mDC4rOD5a1ITb8pI1s3y1u7jMHbEnYKvk0Gf/Gl84LANKke/Kzwpeg/I717lzhbXLX1hQNYTxh1nmaMrJjnkkNNBtAoLSdFBYyU1pf2lK0brJJwx0UhMJG6ussqHpZ42NlYTg4ulM9Sxte8QZk8PYNJ0Z/LbQDhZEWQfseESHerbbtQRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS7PR11MB6037.namprd11.prod.outlook.com (2603:10b6:8:74::5) by
 BL3PR11MB5748.namprd11.prod.outlook.com (2603:10b6:208:355::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.24; Fri, 12 Aug
 2022 18:22:46 +0000
Received: from DS7PR11MB6037.namprd11.prod.outlook.com
 ([fe80::b825:aa19:d8f1:2642]) by DS7PR11MB6037.namprd11.prod.outlook.com
 ([fe80::b825:aa19:d8f1:2642%5]) with mapi id 15.20.5525.010; Fri, 12 Aug 2022
 18:22:46 +0000
From: Aryaman Gupta <aryaman.gupta@windriver.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org
Subject: [PATCH v2] doc: bitbake-user-manual: Add definition for
 BB_PRESSURE_MAX variables
Date: Fri, 12 Aug 2022 14:22:36 -0400
Message-Id: <20220812182236.1650194-1-aryaman.gupta@windriver.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0173.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::16) To DS7PR11MB6037.namprd11.prod.outlook.com
 (2603:10b6:8:74::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd860490-3f68-41de-5d68-08da7c8fa7ca
X-MS-TrafficTypeDiagnostic: BL3PR11MB5748:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	w68vytLyUNyf6EwydypvOBlF0A8XITLy40BVSpBT5eA4soeIWDOJm4uF2V/sYKs11T5ZqaAa/oDTqF++Ghw254hCFHUCPMaPOIWWKY+ZqbbM7VDI9iezr2YIIssnXLpTjn3fkP+92DwKdO9Eh0yGXL59oGxkr8Z0oOKSakGnPbgROOfR/nkUEIG4HzsZ2jC7yPdOLGzxDEx9iKb11cMOKBgSatMQpdQhUfOlbS36Pq5g5GQGoQvgxNYWvnna69jGO6g8a6VSaLOKBg/RQCg/eyez9waQYW2al4qUHDjZf12i/olcIrrM0Ol43xU+rv1QKAKfSvq1d0CVyVFg38dO8AvaqYgILbVpWB0vWd2dkd+PX0ponR40VOHbz+VMq+R/kZGzaLiEwb5hblK/SXH7WAwmNIhkvk0UqnoXVklrztdKbOZxJ02KStUQ1JYrMwZtaUrmyHMyc+UZR25Fxt4aZirmkaJBXytbJt603aeDQlXYOl7+9dsGYpxcAu++ju+Dnjr/nc5/fA+w/9ROO8FGI7ANAPw8I9EYSUHr00uxMaFK6ACUY57Gmj/BJh0Oejzv7hfMG7m1BbTnSQR8zyF79OE7fdmeAOKiYY/5b/N+uIU2At8CAxDjoXk6Pt2UL+AMCd7bGFa+sT/kUt4l+/jHWuG/Pvd+xXAPhww4cVhP486SGVl1oeBZ+hJNKRArlm+UWC0x2vK3W4TTeqiccsoGMUyg3B/DUoGVRqOJVIug/BrcWZklJnYBkDDTJK+289K8j0ipOf6U3iAgvMLyW1SdN4/NkshIFpJwpc8cDfTWn/s=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6037.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39850400004)(376002)(346002)(136003)(396003)(86362001)(38100700002)(38350700002)(66946007)(66476007)(66556008)(4326008)(8676002)(8936002)(6486002)(5660300002)(478600001)(316002)(6916009)(186003)(1076003)(2616005)(83380400001)(6506007)(2906002)(6666004)(6512007)(44832011)(41300700001)(52116002)(26005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Xgw4tGvG/KyP09c42Nj4VrYMYH8l96NHewIw/2yNhTvVny1vFXUxlh6ZQ5BX?=
 =?us-ascii?Q?tzfMeXxXJ28Dcea6f+6VPG7FoY+JqbRHSmkL7h386luXVnZ9FKmco9gsicQN?=
 =?us-ascii?Q?OCmBveZ2Hn7MkriMdGammjrrkVeR02bYLT87gQ4zrGE52rIZMGvWibq+ZTLf?=
 =?us-ascii?Q?+nXImdQmlFliWuhsxQjkhyZOWlukjl3mGxcmEX15jVPFmSb1RBO7xX6GxkmC?=
 =?us-ascii?Q?iaDw7JfpSm0j/bsBSeBsxzT+Ptr4lruCgdmuuAUSpWTL0iXhKPMoNN2FRWy3?=
 =?us-ascii?Q?Vu5eQirZ3641apQi+A+oOMNK1zLewq49u5wISIuABa/q83Llm6QjBNT6MfBU?=
 =?us-ascii?Q?oVelj3loY9bqI9IwjVAKGLBJ02bzwUkhn7TGfiNG9R8Y6DK98qM2OHlLwejS?=
 =?us-ascii?Q?j6IIrXstkOxl7QQ9+ZJSWe8+JLKSPu8xMeRpxxFsrNbxt9qtkhPJ+C1fCByP?=
 =?us-ascii?Q?6javrdX7x+EfaZsggGKYuslmcc31W1HBusnix8b8gUNoDTtVhMF0g2YOAyeD?=
 =?us-ascii?Q?xbG+7/WIB32/1Amc8rGW/QgHct5TTdbh4L+eWAi92awPfmxTY6IRYCR9Kya7?=
 =?us-ascii?Q?PU6G5gRPLNksBwHuSbGk6N/UEDLMMe0orcP3W5e9Y2AdjcgTqhdvcJbS7uo9?=
 =?us-ascii?Q?FCh/pQ+jseMShbo2EbuA+27hE2nGjQWBtX4cepwiJo9AY4DKtRyZTGO19DrO?=
 =?us-ascii?Q?KDdVFmF65xjDpAsRZD16tLlNo68OLWndTKHohRsmxCl0n7AMEDGSmZTTuglZ?=
 =?us-ascii?Q?Gna1poj+CgqWfqmM5YjQvRjp5n+Db4RhKSP25Z0rRSnyly+Z96C5WCCh/R/7?=
 =?us-ascii?Q?DcR6W8/gWOprLhYB8Sqo9ppehMvknjcu3rwfOX0KgKukCHW9JibsksiDl7S8?=
 =?us-ascii?Q?9M1saxLx7+v36ng8sGVqnep1MYCrtxnBgNeVbUVhFh7O7JoOf6iA8HNlLzlj?=
 =?us-ascii?Q?uZYryLCUcrX6INe2benN9CIHFtOpP3W9Ea++uVkk6TjjeVTXhMc4SCdLCE6a?=
 =?us-ascii?Q?J7C/7c3k5fmplhxXI42WHTnlWT+aGrviWw2E2yBOIjjdTaQF/PvDAIGZtsPO?=
 =?us-ascii?Q?qVUrk7X4Wx3wlrImTafmvV35vR8xc8fUfHf4L9pWS9BDp/UA/8B0kmGMDBpS?=
 =?us-ascii?Q?hJr5ylqz28AbtP1z9bWwBE5v9U2RhuNU7geJzhooXzCm1QM+xeOoDtsIIDhX?=
 =?us-ascii?Q?qWu6OYU+62REeLhU4BqnHRLKcal4L5kVHZDuGMDovmtSZOn46oxR6HmHV3pr?=
 =?us-ascii?Q?SO/ooSusttLZJw81nGFG9yYXPplfeTUve+35YGSx6LGr1jrQdmyHwH7HcqTF?=
 =?us-ascii?Q?TQInKJjrWAzFIeLJ7A9b+Cij/bTpcvnSS25i5R5Km4RCqttVm6Pt8/7w/AyB?=
 =?us-ascii?Q?h63COolFUug7nj7gGQ1PP79jFZaZIlokYDdNQsRg1v9AEAtJKo9yI6tAnJcW?=
 =?us-ascii?Q?9jfcYXkq1jHxxRnDXuilYYSwq91SHgrGXEPrFs5QBY6LCzPMMpmsdPSI9C7V?=
 =?us-ascii?Q?DiZ+jfY4pQRCH6o0ByVPrd2gBZxc9tV7LjUzKrl0dHqMxqSeMbtBlTunNQWU?=
 =?us-ascii?Q?OO2NbIiJCep2HN8JaU/waLoHCQWJuGchxldkO53411vgptzEQCYKNXFQ+ILH?=
 =?us-ascii?Q?wA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 cd860490-3f68-41de-5d68-08da7c8fa7ca
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6037.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 18:22:46.4833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 W/lMVksrbLT0nzDii984WkuzSdrSQ836lmItGBkj7NsabNKM7n0Sik7oyfgtgWqxtHqZ9yfHZ+2QMwcpqg352B3PruvJNA2fzH9wmIaeZ5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB5748
X-Proofpoint-GUID: mzo5DFdJY0XsmJsTXoog0yNZEgMkwH1N
X-Proofpoint-ORIG-GUID: nq545x_NgHuDoQuSFnAYYM0TqXixb9jn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_10,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208120048
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Aug 2022 18:22:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13895

Add the definitions for the BB_PRESSURE_MAX{CPU|IO|MEMORY} variables in the
bitbake varibales glossary. Further information on how to determine a good
threshold will be added to the Yocto reference manual in a later commit.

Signed-off-by: Aryaman Gupta <aryaman.gupta@windriver.com>
Signed-off-by: Randy Macleod <Randy.Macleod@windriver.com>
---
 .../bitbake-user-manual-ref-variables.rst     | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 12aef3cb..9b2027de 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -482,6 +482,36 @@ overview of their function and contents.
 
          You must set this variable in the external environment in order
          for it to work.
+   
+   :term:`BB_PRESSURE_MAX_CPU`
+      The threshold for maximum CPU pressure before BitBake prevents the
+      scheduling of new tasks. Once the :term:`BB_PRESSURE_MAX_CPU` threshold
+      is exceeded, new tasks are not started until the pressure subsides to
+      below the threshold. If :term:`BB_PRESSURE_MAX_CPU` is not set, CPU
+      pressure is not monitored. A threshold can be set in ``conf/local.conf``
+      as:
+      ::
+
+         BB_PRESSURE_MAX_CPU = "500"
+
+      Information about how to set a suitable value and some other caveats to
+      consider can be found in the
+      :ref:`Reference Manual </ref-manual/variables:BB_PRESSURE_MAX_CPU>``
+
+   :term:`BB_PRESSURE_MAX_IO`
+      The threshold for maximum IO pressure experienced before BitBake
+      prevents the scheduling of new tasks. The IO pressure is regulated in the
+      same way as :term:`BB_PRESSURE_MAX_CPU`. At this point in time,
+      experiments show that IO pressure tends to be short-lived and regulating
+      just the CPU can help to reduce it.
+
+   :term:`BB_PRESSURE_MAX_MEMORY`
+      The threshold for maximum memory pressure experienced before BitBake
+      prevents the scheduling of new tasks. The memory pressure is regulated in
+      the same way as :term:`BB_PRESSURE_MAX_CPU`. Note that any memory
+      pressure indicates that a system is being pushed beyond it's capacity. At
+      this point in time, experiments show that memory pressure tends to be
+      short-lived and regulating just the CPU can help to reduce it.
 
    :term:`BB_RUNFMT`
       Specifies the name of the executable script files (i.e. run files)
-- 
2.35.3


