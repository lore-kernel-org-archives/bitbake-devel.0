Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E581C4332F
	for <webhook@archiver.kernel.org>; Thu, 24 Nov 2022 09:11:09 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.19448.1669281065157448396
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 24 Nov 2022 01:11:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=Z1X59Hb6;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=8327d198c7=qi.chen@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AO83e54016701
	for <bitbake-devel@lists.openembedded.org>; Thu, 24 Nov 2022 09:11:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=Dt47Ep49dWhWANw24SIF9/eY/yyFy0S0Oq5zRBgUymE=;
 b=Z1X59Hb6PihEBgRy8F3ykTiyvG2GZtLU6sLBmcM3odqiZXv0bEFEeaQLPKo2lyp1U5Ch
 oVJN6/qnDFLa7+W4zIjL3zRgWN/LJZI9vn677qefqBh+RmVPpT1UZLfxpKqVjW99yTUX
 BXNmcZsKnDlIvQqBcOKPRbCUJq6aDAgq6DInyLT5YqZ64y8mPPmnk5x2jxfxYWVXz2gR
 vdwCbUVIDBB5ffnZztf+1mY8+2V1b1M11aue4Oo0/mB+audtBGgy0YhnLVdVOm3tLQrv
 9vvMuPkVjCGMNTylKFD29FJ+We6XVwRk9jwYHP1zoUIP5ZpXOtLhOVxza4SxrC6TzESB MQ== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3kxp48m3s4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 24 Nov 2022 09:11:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrC7qxs/iaWS/3s8jcunmuOnENMJ0W7wupEsNeeDlt07W3a7jntwZB67NzLbH1hpg4B+0pDU4tGMoDjfPtmLKacF3FZs2FabsV2XgCHRZiH5LxdFAyY4DG+fmwZXl0qHft2VQQAW3WrI+UjO5NmdX5zJLsp0Igwa0D4houLzjnIIPOp8FqZLfd2srt1oknRMz+wyyoSc/ssT37IbkXV6neHroiGPuKwODECKQ5nyNA2qe+oCQj+bwYVKTRLZ1b1zrb6Krj5CL2/fNGjiY6HEKoICe0eA2k7GjhKB7qqxWisLTd2Y/5T1u6Y8XMmtF1osWEZdbOkg2+HfQ0A1CdTbwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dt47Ep49dWhWANw24SIF9/eY/yyFy0S0Oq5zRBgUymE=;
 b=cyc8DcWEHSLbAM86KIjJa5C773LuQPyU91uC/afcKuqyMuIktfELqM6wSfjGDIl7plKr0TNdEpk22FBacBBJRoZ0EfluhvX4B1beuHXvHjLtC0x7GDU2p3H/3GgUprkwZwxoa68IsCZIzQx0OcT8o+ovrcmXPsL2lXQa1rO4MhJoIv1BZajrExtrAVfOg00RwifbUt0BygCh+2uJOCSspnTO1Jl2djQLsaljNaJupYE1+zovmCsXcCvSugvuohSUXdf+8JehQgytpoCxY8PSVMk4CfG3Tn3gWL98JpCGG1ZobbxPCw7Bc3fthc1MjE//021ISGbps7XHTHlvdap0+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by PH0PR11MB5159.namprd11.prod.outlook.com (2603:10b6:510:3c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 24 Nov
 2022 09:11:00 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::d8ac:d3b0:6765:63f7]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::d8ac:d3b0:6765:63f7%9]) with mapi id 15.20.5857.019; Thu, 24 Nov 2022
 09:10:59 +0000
From: Chen Qi <Qi.Chen@windriver.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] command.py: cleanup bb.cache.parse_recipe
Date: Thu, 24 Nov 2022 01:10:45 -0800
Message-Id: <20221124091045.12018-1-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0004.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::17) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|PH0PR11MB5159:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e073ecc-478d-4b85-5ad9-08dacdfbcd97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	coavCH2gNe1ZgZmgTASJ9I3FwJv1KES1s6D8XxE8pd5GQAAeQ6LsUug2jx8qrxudxixuMvmGbKoQSoS6mlhz3VjQ0wuPsBHKQDQQE8n0VeiJ9/k6QH2J7qekPHwe31nhIBmcw1JTgAfrGo/kikmhUHSzxNEib4q6AWxEa8ttMAlMMZO2HWs7JashXOq17ZAfVydfQfzRC3EWlg6w6MpKu37XXInqNxS/OXrLe5mcgD79054jcUEwwZS9eKOLbTfwVj4h7loDrSY48T0q722ZfMyEOELYZHhA14z2yYkOo/EwG9okT3saVLp93TbrwejKUOC49+cWBMQxEYZ2KV67l1kMqgCoch2r/zsH1ChL52MiRKPeuvONpFKJV9q7MjvHqjI6hZznYGwfcXLOcwN9EuVeywRgq3AZRJYAVqqD/oddbEUGSwSoan7LlSQJzvQWg5oXgeZ8bkNediiE1PHJn9hiClmhR/o9lKJh4SJFCnkxMdD5CFAnOgU59Y5CUWe+UOxGWyK964SK/i+QRcPV5Fhoehr+UZRVvMbF3+IsoQ909E9lqgy8U/hzanmBgPcvTZ7dD+dO4n2t8ob/Sj4vqBQmnc6DYTUqdMvHz11SGWQh/+mVUvua2S8oqe/oyyNOLIcMRzzPfInxxADP94Yr984/WMeoVal39LEkOe+vBNJwhXVIxwXBA+BrxPtg37lz4tGxtoWrdC8t94+wd/TOtA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(39850400004)(366004)(451199015)(478600001)(6666004)(6486002)(6506007)(52116002)(6512007)(26005)(36756003)(316002)(41300700001)(66476007)(2616005)(8676002)(66556008)(66946007)(8936002)(5660300002)(1076003)(186003)(38350700002)(38100700002)(4744005)(86362001)(6916009)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nhKC1Qn8x57TQpmUSLRRfm2glxWDVafO9lVTucUQJ7dUFQeSImA3RF0G+vER?=
 =?us-ascii?Q?no32T85Qxgp/0tPtkOW7pY3UGHJmQ//hM0nqPWf/N9SZ1JvowVtfA7J3JX7+?=
 =?us-ascii?Q?rUfOm6rgHgqali9K6Lh58udJzMCDYwhIffkm/zSNj53XOD3+rxg7xi9zo6/R?=
 =?us-ascii?Q?cd7fdA6Zq3bKQQ2tyMJVlksTt9fR3AqSAflWxGWvY0WBGBP0R71JW5efgz3C?=
 =?us-ascii?Q?cpMAZ2SJ/AlPjPGnDnKHAO+jq4JPQo4X6GWSDIzao0FQElCULtdO7c9Bqc/z?=
 =?us-ascii?Q?NDXekgSMKLTGYuqYlpmcdCDh99Ju9RFu2mVgIG/JANrQQFc6cDNHJNHYcXig?=
 =?us-ascii?Q?D7QOxtlBji39EPjFIOCPe8Y9vsKKYIvaosXArTrV+wcDCpVIAnFFtfRyO/Ip?=
 =?us-ascii?Q?dWYnBlC3bDTB15uEcgb1K+ztvdYLjT0kWm7VbDYTXODmKrmlCv1XwI+iPr9K?=
 =?us-ascii?Q?szN2UFJqHamc1WXe4UZFdee/iYcvTYO95bKYEZIQyzuUOGDvrvnFlVhFa/A6?=
 =?us-ascii?Q?J1bHlCdWicCBBmsdNslIid73b4IX2V1wWwEva1pcl2wFf13vrCeDDDLBOd+e?=
 =?us-ascii?Q?1Z7WIg8sD291y+laMo0L5zuZeL8T9Y7ZaK2D5LIdLufFbrRXz0zXImQ7KZ7g?=
 =?us-ascii?Q?oOspo8N1RKZk6N3WqYgaQvl05XiJ314FxSJS6jRG9vDRXemCZ2sEfZe93lSG?=
 =?us-ascii?Q?v9yS4TM7cBci/r3ICuYHh93mCWGqHiiCXi/xs0YkPxYz9BR3SpP+EtSpD4ct?=
 =?us-ascii?Q?9fdCtTC4PH+mMzVhx10OE4nd9sbL8O+96MFqS4B9K2GfW47KNhNJNat9Q0+5?=
 =?us-ascii?Q?F+PA5Q1KC1XvIouLBfDC57nmH6ASsjScTQ6i0XuN/MtQoLBoyKopMCEj7iOs?=
 =?us-ascii?Q?1d6coB8Hm8pPtUwWvmvXoAjy22vw+Xagsc+LayzJRi+cliayHSz9Yw9HXg3z?=
 =?us-ascii?Q?jRibh997ECIF307Z0LUNozvA4TeSjGleZuUQOKyH5KnsZAfV/w5MnAyhUxKi?=
 =?us-ascii?Q?sheuMRFG5EeW5fmliqLWuoIWRUSVA4JQKCUQ7eUn9k9kG7amnC7oiH63v5vx?=
 =?us-ascii?Q?nGDpKVvC0zJwCAmDjw6o43MTaBttHOTTr3gEmf8sqOmTnfxYL97QX9JianOE?=
 =?us-ascii?Q?lE0sznLlURrXjnsI/YDmY1OM9V5RxpBDIKZLNgvhSGiBPcTKLHtJ8TpDg+HW?=
 =?us-ascii?Q?FzMwQS67n72hwA5OLvqj2UloT0BYh1rFDHT1rfig9BM15GM/+uCmX6WjbbEZ?=
 =?us-ascii?Q?oX0PABiwlMCDmrbs6UDTxXROO7fTPkMV6hfnGPzKb+7W1oLvKdKHEsL7K47U?=
 =?us-ascii?Q?OC4es3zDLppDUW6PfjQJXmdNRMDe+JPlJPwzV9EZgxFVCcup1iqFygKefSmc?=
 =?us-ascii?Q?5tBLLqh1Oj5C/cztPQQQiTqhjRhsAoomrV7GBZikH4+N4NVc1U19lCQdV8a4?=
 =?us-ascii?Q?3G3fStaNJ5S9XVP+y0uPCsFKXJNViTh9OH55Y/++kwyb3XNB3Z1P0kMK9D5l?=
 =?us-ascii?Q?4ivJUyonwOfmlXtOKnNj77Xs39wC4sc+H51KAFQYU+O9XGODxN0crc1bg27G?=
 =?us-ascii?Q?jvrx93EtGs+6bAgcXQ9DRdDDxn4GkyMFORD2ebeLkK9BoQfUOI9POFpJgIan?=
 =?us-ascii?Q?sw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e073ecc-478d-4b85-5ad9-08dacdfbcd97
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 09:10:59.8111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wDjlHCDx0Pqwxb2WFFvh/Kgt5UMteaquBCLhqP4vXpvtl7FVqFzn6qI/M07oWvslUW//I6tlEMQkrkfew2GkJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5159
X-Proofpoint-GUID: EtYG-wLHmUdXo3DrmYyXYQ2IHGdBhwR6
X-Proofpoint-ORIG-GUID: EtYG-wLHmUdXo3DrmYyXYQ2IHGdBhwR6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-24_06,2022-11-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=987
 lowpriorityscore=0 spamscore=0 mlxscore=0 impostorscore=0 clxscore=1011
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211240072
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 24 Nov 2022 09:11:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14105

The parse_recipe has been removed from bb.cache, replace it with
the databuilder._parse_recipe.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 lib/bb/command.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index fa9fd054c..c9571f63d 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -564,7 +564,7 @@ class CommandsSync:
         if config_data:
             # We have to use a different function here if we're passing in a datastore
             # NOTE: we took a copy above, so we don't do it here again
-            envdata = bb.cache.parse_recipe(config_data, fn, appendfiles, mc)['']
+            envdata = command.cooker.databuilder._parse_recipe(config_data, fn, appendfiles, mc)['']
         else:
             # Use the standard path
             envdata = command.cooker.databuilder.parseRecipe(fn, appendfiles)
-- 
2.37.1


