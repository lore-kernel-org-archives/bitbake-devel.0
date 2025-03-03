Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989A4C282D5
	for <webhook@archiver.kernel.org>; Mon,  3 Mar 2025 13:49:25 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.85])
 by mx.groups.io with SMTP id smtpd.web11.53205.1741009758511073424
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 03 Mar 2025 05:49:20 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=owQveZLy;
 spf=pass (domain: siemens.com, ip: 40.107.22.85, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AtTD0NWCvyxbkQULQPSdmzhCJzqIYl5gmSlqhmk+eLV3vix0EHrNsKVZQd5tIM2Kfq4Hjk5J8hX/reJfNeejH50t42QWNZI4SjvgHUoE9ysV9ziH/BxLVk/I9WGalyXJlw4lxB+z68JHjuRT/uIMxvR7OBLgtOVKcPlom0KwkbqJBbIsXALFIBd9LApZvXIWr7Fdq6qhiDi+tkqY0TlmrTfssZ45j+tcqwfz47xVGPJ4Esj+ZwonIpjyAzD56AgsaSgeZougfFqMtxBDlD55VIoWYqnDAyGpvmT2oGr0L+AvYnMtBYBvZ6sP38eZ8eD6gM1jbKgzIr3PaSb2Sy8qPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ov/xZWl5o5VTKtokglzYlj+loidP180y7kDoa7gJA5s=;
 b=Mx3g1gBWwNsb+9TMGTWAVjaEY97JSeMCBnfbllemKBtfMrMuLoE9BJFycPP8CLP4+Ko2uMUsd4cu/GnH/9CuOQ/JAeBHCdtTq1IPZylX+QzilJmLTSQVgo94mPdbaXL/x2L35s455KrlnZuNXrHV7gyBxAZAdM3yTM1OM0jrZuXeFjoR3+ffaxbUzKYg/9V/dpzx3taTOCay4mUeXiBcL3pXIVFotqOZf43Mf1at/6nW0Fv4X0acX2rI/BJom1G6FDQjyJFtwN3xcdlD1/mbyhGl3jxmtSmryn2SHwPWHVblWWw7TFlATswq3xqMuurCXWR7p+c9fSx/S9OkGFAEAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ov/xZWl5o5VTKtokglzYlj+loidP180y7kDoa7gJA5s=;
 b=owQveZLygccSC8z03Q6ZYJEFHnCUJnGCzXTZdBSkh63RhPoLLaZ5xW+K8c0Dm1llywZEdLYNmtJx4N0sbgi+LbDcssZzzCSEe7AKejEctWgGQFAw5+kzeXw2VQNRKpR6EsXtomP8nx0uYqAhNJCpbnd9fmePdDJAn+48hcDsEP6i1XOQviX2Ju7RRCrSN+bIKTQPnvUAPeB1u88QhCdHGuZQC9fdgo+bXGLPilw4J2xSM2vVny78xEAyjwxR/21bdLH76RZ1TlChnBKeEf1qoRHDJ+uYdRNxX19YKgsuXBuEwX98gjtGA4tVVNoek/FyM6NAq+p6JxDRTXsSsnZqOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by VI1PR10MB3165.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:135::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 13:49:18 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%6]) with mapi id 15.20.8489.028; Mon, 3 Mar 2025
 13:49:17 +0000
From: Stefan Koch <stefan-koch@siemens.com>
To: bitbake-devel@lists.openembedded.org
CC: docs@lists.yoctoproject.org,
	stefan-koch@siemens.com,
	simon.sudler@siemens.com,
	jan.kiszka@siemens.com,
	alex.kanavin@gmail.com,
	richard.purdie@linuxfoundation.org,
	quentin.schulz@cherry.de,
	mathieu.dubois-briand@bootlin.com,
	Ross.Burton@arm.com
Subject: [PATCH v5 3/5] fetch2/gitsm: Unpack even when `ud.clonedir` is not available
Date: Mon,  3 Mar 2025 14:49:11 +0100
Message-ID: <20250303134913.356778-3-stefan-koch@siemens.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303134913.356778-1-stefan-koch@siemens.com>
References: <20250303134913.356778-1-stefan-koch@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::16) To AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:41e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4959:EE_|VI1PR10MB3165:EE_
X-MS-Office365-Filtering-Correlation-Id: d52456b1-98fc-4dc0-2869-08dd5a5a30e3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?IwbfXZWNlUx4km0zVrjI5BwjqwCdHpSpISiHTGpVPM5C076Iia7VxTHOecTb?=
 =?us-ascii?Q?0IbJAU5qqd/XnNcSB9Z1YqcvC8zX98ueZMqBe5yauXZtaJw35yhIDP4S+XQm?=
 =?us-ascii?Q?/kcO3HquhmubH0b0+DpMpTehGHe54k6DbXcw4AQpAp1kKFmuKUV5mKkDX9tX?=
 =?us-ascii?Q?dOTQ/V/DM/r6Ymfx5FFYxdfKfZPQtA/kJMZLBej196T6E2gsibXfYA+6rSuL?=
 =?us-ascii?Q?rvSyqGGL/8hEUTl8cApLQDqEGDmIP8WYOYo+zHSFUwqDuIYrqlFAwXsiXa9D?=
 =?us-ascii?Q?mJW73KRO8Uj920/s+2TbB34GUt60BHDReSVQGqpbK+k59WRFmtGxCzGEX4Af?=
 =?us-ascii?Q?sPLbsHrUK+BqG3hpRr5jdXHuPjHcVE9sYJexo6aYKY7TIrd2ZCI9h8GTjB8l?=
 =?us-ascii?Q?JbFtkVk5d1JJ5W5NJ2rpSmXIemrAOvcRNK1rJhQ8VK0seYga/pQ1m3DDP+TY?=
 =?us-ascii?Q?yI+dNAdz5z2IzbmMxGjBz7my3kYnGxgvFLrM71RK4U6rCCNIfyfMD80Iztt3?=
 =?us-ascii?Q?FuDJk4y47KoAU/Z6m1eWzzkVnoQ/O2QYtvAsrE1eJPniP6uJn1oH/rbkFPUW?=
 =?us-ascii?Q?00Ll4kLVk7GsMZA3Qs6tilScrDkYfzgePUVgn1hO6kllEuLSynA84FP/DSyB?=
 =?us-ascii?Q?fGqsZNoOiBQEdbuuQGCy1/Uvnw/+27Std0Heh0Rw4wwH7MR3A2eYFLDMn7nK?=
 =?us-ascii?Q?0FtsFCUd8PDZ8zg5CICGo6l6be7NHoyCBEz8011a20avXBTkOqNyQHxZ05Sc?=
 =?us-ascii?Q?+90cou1ceUCZohWoD7BzovbDNSfte1aFnhalhe+zX+TmY1J3s2wkqc0c8X+r?=
 =?us-ascii?Q?kY3dsvTO70IaeF7pYH5WkwAuu1LPrCG8w7JM3ezG4MoBWhjxbNe3Ekx1jJb3?=
 =?us-ascii?Q?MFadFdjvu7DzmTC6797wQV6nDgzqLxL0ruKYtPkk4B82u7R2OlpIjyPl93Sp?=
 =?us-ascii?Q?xYNpr0qy7yX2WIT72GJ/oE3sbT/Zm39scmeP8XnzmA6fhcu8GM8kBjFeZ2HO?=
 =?us-ascii?Q?H7YsaFXWRu1o5/zQhJgPbEacwUgafZ/FMJIiVkneZJDr8xej4HQPMUajhQBF?=
 =?us-ascii?Q?ABc9pSEw3ePo0w3ls5ONl4pxrG56lkkE+FJcxTLu7y/unz7mQwoCIIcicWI0?=
 =?us-ascii?Q?MROl8Vzrw2nZQK0ZiclZEKC0pJgIKmpp+0t7RS1kvrddV6qmGOpdkLecEwPr?=
 =?us-ascii?Q?xxHctm9qjJoY8hOHIh89mRyvvN+SkOALdzhEQYLy3hmmDCXk6TLuv/b0cTdk?=
 =?us-ascii?Q?8CQpTFAqDLuxDiwS7RfD20a6Bq7vPLDpudbaMha8KaidbQm6UcSqL4XRqiDq?=
 =?us-ascii?Q?6EL9xz4zugiHZjwsMavrI4thcNgLhLjwCufZ+cm9/5GM2zSMRBWKWrHtrrMq?=
 =?us-ascii?Q?b9PJwZv7Mu83oVTV4B6VCnQS9h/m?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?iL/L0kQNV51GnGbl3Rq9F3JnRAPVIJ+9ElLjmAR8WHs0bH+yUdlwgC9kltAO?=
 =?us-ascii?Q?POzT4fzGGymq/gb8dJV/tZyGV7VZg96a7jvjGjuQeVtpu1+NDTLI2WpPZvMm?=
 =?us-ascii?Q?TF3vnnroBCP+eSNSaWu8yx/Jez8ohET2b3Qu6LLOMORg5lfcYaJ1gLkLS0ZZ?=
 =?us-ascii?Q?AXRd+8qLjclmDO+TF8KWwBkVQBn2Hjc9ntCQXMf7FYFKlEapTIupEEq+IK8Y?=
 =?us-ascii?Q?EVKuPGKJ6JQy/mcWg3eKXIWBhDpPdJRXVurCFQvhMQw4ZPjpqjln0qzgN1kP?=
 =?us-ascii?Q?mSuKgPJK9ondmzv34XZnaLEPDFbkRDrzDtMyE5uC1Hb8f9crv5uZVTbO24Tr?=
 =?us-ascii?Q?OK4056UtT974inknUwrPOPOfZKX20pbY63vj8jzht3VJb3tqwFXkHtba/OW2?=
 =?us-ascii?Q?vJln2ebMr6Vqg69OhxyvVlobq8Cg7Qfg/m6sC6r/AQQUxSYQKpEuUdKY9ODo?=
 =?us-ascii?Q?jeu8FUe31qsJJ9Btr1da6l8vFas4tPpzQS2jqesVFlTPj+INBsntU6L4w7z/?=
 =?us-ascii?Q?NTc4XqHQeNSqTZay77Tn+I7sTLAHQT73VbGgus4dOwFpF3m7DEQ4HRAkGDM3?=
 =?us-ascii?Q?MH59c/bJZiOE0VwtJ5IHkLNy3gs92+Rx2WJ/1B3mvNoQLzfK6u7f/kEFH/K0?=
 =?us-ascii?Q?9ai+zglDl3A9br29nJ47XJgun985Qr20Tndbf9rZfvgtsq8ffBVQ5U4Oy0go?=
 =?us-ascii?Q?TLuR0AkDfhtYJm60moR5RfVoK03LN8hGgk2MUOP35us3Vhetnupu7VbtKTfY?=
 =?us-ascii?Q?NbX8+SvyyN3mCNEDPQ7ClmNXFszws3kesJRfTY0B9gk7MijAIwnrY81zjxN0?=
 =?us-ascii?Q?07/GG9n81zStiaUnf6s/TSWh8dLa2FBBp4zinVF3VTMOYN60JjlpO5KVT1wS?=
 =?us-ascii?Q?mqLtExLRSEO86tXRtfQd1B1tAZMqcC+kYN8ML/SHiyFmj/7lp+LtHXRiEg6Q?=
 =?us-ascii?Q?gc3fXjuPLQSnr00yIghajj3GymebTD9qXATCZsVdYaLccXmifUi7SOgwxRZR?=
 =?us-ascii?Q?jp+hO348jZNpXBQ9BS8R0bzckiiHaTqZ7LBIaWHZVUJ3b9TS4um3zniyTJlj?=
 =?us-ascii?Q?Giv9w0p/FTNJvM81ox1UYAdbiD9JMZTkih0ZJC3cjjOqRZi6YlRQewhEj4lN?=
 =?us-ascii?Q?pnagwrB3Akz1b92w5nL3OqvuwfElpKES2J0VsoweyUnPXtG1k49D54/NZjCi?=
 =?us-ascii?Q?psye4/1YdbPs8DfMiIHCjGYlfRNPCwiQ25xtnEQlcOAWd6eZw72CU/fzU/JL?=
 =?us-ascii?Q?pbziYxBgjY0D8+DTHwxarm8hXGEpzYUg91UsnqzWEBLSLJUTQnjsplpJLQZU?=
 =?us-ascii?Q?NiAb0ixzH4OMx+kJEAObtZRPlsng10zVLrO4B86ayvw5doFYM90+vtS/1h1c?=
 =?us-ascii?Q?ldCJYZJSKQH3PV0vnp2n+pM/czjdip7kgYTCyFY855dtminLVklSN1urZkzi?=
 =?us-ascii?Q?ERU7gr7sKZ+VAwqmAGCQgNjThnBe8vaybTZovaU18TBWs9bfGNpA6iUExxN1?=
 =?us-ascii?Q?8M+NShPJlTQSIueMptzRCN6HfXESX5UZeogAXpwHL5X561Q7ZojGtI40CWt5?=
 =?us-ascii?Q?D9ADJsSxQtsVldxRWW3gEUgJ20sRAFxj1/WpF+/CLzUBjGl/HmvG1kIzofSV?=
 =?us-ascii?Q?wA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d52456b1-98fc-4dc0-2869-08dd5a5a30e3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 13:49:17.1917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jubodUdDpT5N0x/srIl9/9zxC40tt60Ru7cCC5kXcS+3QpBG1eIA4ppERdm2cWzdcvMroFYzRkhYr2D+StPZyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3165
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 03 Mar 2025 13:49:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17377

Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
---
 lib/bb/fetch2/gitsm.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index bab1bf258..1c58230ea 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -150,7 +150,10 @@ class GitSM(Git):
     def call_process_submodules(self, ud, d, extra_check, subfunc):
         # If we're using a shallow mirror tarball it needs to be
         # unpacked temporarily so that we can examine the .gitmodules file
-        if ud.shallow and os.path.exists(ud.fullshallow) and extra_check:
+        # Unpack even when ud.clonedir is not available,
+        # which may occur during a fast shallow clone
+        unpack =3D extra_check or not os.path.exists(ud.clonedir)
+        if ud.shallow and os.path.exists(ud.fullshallow) and unpack:
             tmpdir =3D tempfile.mkdtemp(dir=3Dd.getVar("DL_DIR"))
             try:
                 runfetchcmd("tar -xzf %s" % ud.fullshallow, d, workdir=3Dt=
mpdir)
--=20
2.39.5


