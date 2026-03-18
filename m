Return-Path: <joerg.sommer@navimatix.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38CDFCD0C2
	for <webhook@archiver.kernel.org>; Wed, 18 Mar 2026 06:33:47 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.82])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8043.1773815620758315036
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Mar 2026 23:33:42 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@navimatix.de header.s=selector1 header.b=GTHoUsps;
 spf=pass (domain: navimatix.de, ip: 52.101.83.82, mailfrom: joerg.sommer@navimatix.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S/pdKootngieL1wKm/nX/3JR8k8kH9HsrsXnLA0fkYrx+54hG2DYrxdP5vKfc213NPlgMJO5kQSkf10em/qZrI8gZCQDAA7uWE8Z0/ErqRVHGO1q7jftlcqXVb/CJc6hIwp3UVjxPtmbgjRbfuAB1BHqQKwVscVwVlceopqaU3SRn8uXZFwEKf7HcG1HqPwf229xQ5LQTlBsw154Vskhgk72AI8fQZyVyLevfmPI0PB5MPcH9d2QyOl0reBzlt9PgnMa40JhGZZKbNGOYrJsnCPK37ptPueL+EU7V6lRgjjLNemym1HeoPGOSVEocmmu5JLdj+HHIdooJjJpr5XMMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ogTsLm0dRVA/h7NhICV6Lsc5/aH7AL9t7B8HRcUyx6M=;
 b=e1jN2Qo/e3mNAT3SURy73XTqOdxiN2RiWOnzmHHULwc0Dd0ycYecmfxDGGlyDlHV5MfcpnrvO5yyhGhHauN0IOq4+7LN5xAGL5DQErkZ97fxXEeewhqWYeW0/QwgC+wAD+TCvjRMqbYEN8vjXIp/B7lGYr4iTgqKW+FN7BYGCwKOWQpFEO98snR02yJiBDJ633wBcrkPwCqV8A6OSNl7+zmGFqAChOS7sxRpRtDo3jIjpMd01ZsVl+EejlzyP/r7/2cA3Dq3Lh3+OFWTLQzBMoXwcWYXzNupxysC9g5bsVLXmfqOGDOzmqvyclwQSFWMtSe3rNNDlrohjYyjwo8utg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=navimatix.de; dmarc=pass action=none header.from=navimatix.de;
 dkim=pass header.d=navimatix.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=navimatix.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogTsLm0dRVA/h7NhICV6Lsc5/aH7AL9t7B8HRcUyx6M=;
 b=GTHoUspsuBuRZ9K25L8uJS7TNYNwhA7FBunlsR26joi+PqLXLsLcXCEd68p3aESkJJCnVQYMZMzeMwnGB5cU5N6X7QZmby7C0IhDxa1l8LR6dckFJDioJiVAnU36UCgv/FEhfQCi4agix4xoW7+7u3c5K2hkLI6atPLokaOUli8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=navimatix.de;
Received: from GV2PR01MB11835.eurprd01.prod.exchangelabs.com
 (2603:10a6:150:2cb::8) by PA4PR01MB9281.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:2ac::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 06:33:35 +0000
Received: from GV2PR01MB11835.eurprd01.prod.exchangelabs.com
 ([fe80::d5c3:2dea:3d98:25fd]) by
 GV2PR01MB11835.eurprd01.prod.exchangelabs.com ([fe80::d5c3:2dea:3d98:25fd%3])
 with mapi id 15.20.9700.018; Wed, 18 Mar 2026 06:33:35 +0000
Date: Wed, 18 Mar 2026 07:33:33 +0100
From: =?utf-8?B?SsO2cmc=?= Sommer <joerg.sommer@navimatix.de>
To: bitbake-devel@lists.openembedded.org, joerg.sommer@navimatix.de
CC: =?utf-8?B?SsO2cmc=?= Sommer <joerg.sommer@navimatix.de>
Subject: [PATCH] data: Add exception details if build_dependencies catches one
Message-ID: <564bef12d9c423c71beccc5f2dfe9d50bf8ff8a2.1773815612.git.joerg.sommer@navimatix.de>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BE1P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7b::17) To GV2PR01MB11835.eurprd01.prod.exchangelabs.com
 (2603:10a6:150:2cb::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR01MB11835:EE_|PA4PR01MB9281:EE_
X-MS-Office365-Filtering-Correlation-Id: cd0959f0-5052-4daa-c232-08de84b847dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	PdEAktKsTRcRJ7i+/Lcngidlqxkx/8yGpSra8qUqOoY87osB1B60w+yLNDCtIyzFRq+gNf+z4O6zLMzVAH6k0Jn7zin/nctRLakwjYMfvtxhATFYOXwj6uS3pnWjKftDuVDj1G8DQcMLcngc0+TNHxKKbFsObnOQ02buZq60ZhcKEzagKNrPYHy/mohY97nmGaaIlP+S1SAC6iFmqQ7/NXDKu5Dw5ZIOUt79zmKB1daQKYpKeYGqbOocnb9Cqi2YiJ8J6YUyablqLMjlh7sgphx37MOHz3fz7jl2EiwrJ/myhOwbjg2Nei7DJ6jan2BwyEMpos0bsn9QlpaK9+s/pkyir+QuX902CT/1Qtt1rW/hBjZjzsl2NKMTMcuuzW4qpDZd1Hj97dwO0ONgPgVDp1/7Dd1A3vdocTCa2xyQJXfk9BEVDmqcFPakdujazv/WJOvRPnbyVh7/7X/WrkDaBNf27BA27E7CU0IX2VRs6c+NljqcYxQlQSKWXhinzvm6Vq20HbiShWjo9tqUzSyMkOYPhIo0G6tXUErXsu3HLz7YMdyDET9TD5p27gkU+lEVcNSt0VmYSD/UklAVRKjk45WRphExSthF6ByPObKUzuCU52KSouRkP+eFtZ/Svcbg5T7xmx1XaggpL5Q/z4ofmWRURze44wG6PgKfugG4bFVv2oE9hgcBNC4XH83ZYLfEw9YHYDwM7grnYXPIqZ/ue1tMViud5qogx3eRl7+4V3o=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR01MB11835.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ria5h4jl19APSqkGi6ac62zwkQGDuk6V9KZ1bO0eWMRlRGgBQwA93yBRliOH?=
 =?us-ascii?Q?CA/BfDhZ3Zh3ykeWDkz/VUxK33fl6qKMzSKYEsURm/1N8i4DOVtCbV2/FQFp?=
 =?us-ascii?Q?Dm2fzY8+QDjq1+RL4Wt3vY6tDWj48I3W128PAK+TWFkJFvDDgg8trHH2aQhg?=
 =?us-ascii?Q?ZmY8cwhbxYug/zGm5B/J7FaBOXLRQn8/zOdu+/7jT55Qk/R554pPsbRwWMGh?=
 =?us-ascii?Q?4CsUjkmh3WpS2QPBZxNeigltALPDFEyH+n1EfLdOqpzZ5bWqy7SDHjvZXOuD?=
 =?us-ascii?Q?ty36qORDRYyAz7kPxVh/K8FrNohaiwTeBz6qdTJ9TkgzT8Z6xZbdCgZuR5pB?=
 =?us-ascii?Q?Y1TnjfezoJvTXqgSYa2aKJhHoFjNVBJAOrkgAbTiJUD/2YRRdN2Zq0wAf84L?=
 =?us-ascii?Q?u8h4BgxHjVfzNMmeAjF03LD7A2N0mcFWd3kIskuE3BZdANyEqvP0bx/pML6g?=
 =?us-ascii?Q?HrW4zjrcfgy3o6JhXu58jpjrzILMGzHyASKDCEk2FogM+m+WCjIJHBPLoKid?=
 =?us-ascii?Q?iLLSGOirxDqQgf8TSEah8tvtHO+2AvlZAIdAi0zMyb+QUnEQimCDxTYAt8rw?=
 =?us-ascii?Q?ROfCjS2ccLRVmMBUyzkXmGyPIDPqD1k/47VId4xOM1BuVwcF6JCoL/+oFCUI?=
 =?us-ascii?Q?YTrHJY8blEKIXX/oIzB/Oam53jiY/dSeALH/bqdAwUrljszJM7xWwZB+Jy84?=
 =?us-ascii?Q?rACf/klwbLtv/oCu+XjFGgQ2spHg5lQN53QaLbcWjhddkhO0Wei/nM3MTZzp?=
 =?us-ascii?Q?VXIs/aQFz/z1mg5n1SLHkxFk1aKCN4KsooEc1kDoNwtzAf/CQjgLDG8DdZoF?=
 =?us-ascii?Q?hEIRRBiMsb5kBPicQQvK8IcXV73YoVbHJUpH4c7Folp8KveTIKZvEfSO+QdN?=
 =?us-ascii?Q?sOGAVyJylBW6HgCuEmg9jcSSGAg48+6m1wpYER4T5mxUse6ij+r1NxHomsIm?=
 =?us-ascii?Q?selBXoyPnUeJY9nk8WfhoXA41ibNtUd9WuV7llT3ceke137iuRQgmY9t+h6C?=
 =?us-ascii?Q?p/pekpEDyXqLvQCNJDdjisIL1Iv4A8k094fWJ9FqApRAWDGJdM6ItjwBUZIE?=
 =?us-ascii?Q?Fq7JAmqpiQS/TGFqSAUQONOrnSiuwDDjcv9MTH20T8amZN5EzOs4qm/OsPJM?=
 =?us-ascii?Q?Kr7pQo64pHdFydxKEbibwd53tLkC5CmusXdqJPzaOsAcJKj37j6NexMCFRc6?=
 =?us-ascii?Q?fjSGqNY/oMP6Edx0RpwZeZ/7alevJ6jXf35mWqYNOeFsENzSbn0NbUVqFs+m?=
 =?us-ascii?Q?wFL54eQrtoQMEaU/+p/h9fumWYK0N4+LHb/4EICTgp1n1x+qe4xwfsbisEZc?=
 =?us-ascii?Q?PHACk2yuyXe219UF0jj7wrMexBsobHbsWuyxQPfYrQ7PiNAxUnki8gOtAu+t?=
 =?us-ascii?Q?Gs4W3b5Vh2J0hOu6gLdaKCwLmE4mrteHifxZwW77VUctWbg+XTUc5LqCp+/7?=
 =?us-ascii?Q?Fatd6PaRQvPnnXweUtBu134s6Zc8cqIMuj7Eohh+NLmsxbt8U8LPkcDMl1m+?=
 =?us-ascii?Q?ktHtouc0gcSocyX/qCJIWjGJQ1Ogl2HuSum048azt5sSACZXWRPOCuA4Xm+N?=
 =?us-ascii?Q?m2kv7B0T/I7aQhq1f7CnoS7AvYOQ18/2X5v7sFm+UP+8w8O+tBwCM41rHeZC?=
 =?us-ascii?Q?JHD3O4Ho8W3xzKbXBo5NxSxYJ/t7sygqTfQBnSXWlLxmQD4F/yaMa95y4q3H?=
 =?us-ascii?Q?Lc7IdXYgonRezWoDsr7K6bq0TcsoVsuecshcI/8Egp9RFDXILkKJPOMuPko0?=
 =?us-ascii?Q?BqPwdiBOClFSukHIEy5nJc2TMCGupKY=3D?=
X-OriginatorOrg: navimatix.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cd0959f0-5052-4daa-c232-08de84b847dd
X-MS-Exchange-CrossTenant-AuthSource: GV2PR01MB11835.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 06:33:34.9407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c87b4f54-b992-4813-8f3f-4a876324197f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QaemTDW5T0iRi1bypIeBUjXudq0fP/c22zKR3h/h8P1zSK+SBHA94A5POdeFvSavW7kqcMyasiJWlGDybt1HgG9V9haoZljhKnjGfqKekA0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR01MB9281
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 18 Mar 2026 06:33:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19165

From: J=C3=B6rg Sommer <joerg.sommer@navimatix.de>

Without this information, you'll only get messages like this, which don't
indicate what might be wrong:

    WARNING: =E2=80=A6.bb: Exception during build_dependencies for do_patch=
:00:17
    WARNING: =E2=80=A6.bb: Error during finalise of =E2=80=A6.bb
    ERROR: ParseError in None: Not all recipes parsed, parser thread killed=
/died? Exiting.
    ERROR: Parsing halted due to errors, see error messages above

Signed-off-by: J=C3=B6rg Sommer <joerg.sommer@navimatix.de>
---
 lib/bb/data.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index 061e63386..2eb8e0aa6 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -367,7 +367,7 @@ def build_dependencies(key, keys, mod_funcs, shelldeps,=
 varflagsexcl, ignored_va
     except bb.parse.SkipRecipe:
         raise
     except Exception as e:
-        bb.warn("Exception during build_dependencies for %s" % key)
+        bb.warn("Exception during build_dependencies for %s: %s" % (key, e=
))
         raise
     return frozenset(deps), value
     #bb.note("Variable %s references %s and calls %s" % (key, str(deps), s=
tr(execs)))
--=20
2.53.0


