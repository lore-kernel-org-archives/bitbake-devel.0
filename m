Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E4DC021B1
	for <webhook@archiver.kernel.org>; Thu, 20 Feb 2025 17:27:37 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.56])
 by mx.groups.io with SMTP id smtpd.web11.2757.1740072443352419987
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Feb 2025 09:27:27 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=gbvPM8V3;
 spf=pass (domain: siemens.com, ip: 40.107.104.56, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g2pas2Bq8SoRIKcrH+dh+le18aPbohz/MFeKnz+rl0LjtNUL1U6VbAHfoWQBvju84TP7rtLV47ftJFVZvPGFarI1o3JU9t9G8KWxyRKCPxnSzHsvDRI4Hl7kjWJvIbI+jVMPhSistyZ3ZtCeDAUj1oVcwmX3u0tetMvF+Yy5L4l0t5LxhBxAkjr7Y0wHJN57tcuKamClLhP6sxflP0z6Nx7eqCdQ6QtyY6btyc5bcGL37fqT0iOTkksSuJ0Q2kew3Es2oQ+wYlr3pOPlzMSHN+Do0bJny1rCZQzPy0daBniM/tZhLkrFZmRkEhUZ7jnnxihJM4c5etvpg+QL+lwlTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qQjgfJtFeDpQs1UDd3grJQeTE1d0BRDq6YHo/nEurw=;
 b=DU0Z/2X1lwogESFFWSWu6MCkudZOv38F2bAvx5e51GpqC7KKG5kfV3IfE1OqYzSrxhFap36NzDcFfDPf5hdJpk/tC6wmc++nHIyVyaF91vk+4QNoslmHBuE4GxfPWvW6GSZLwjhZjX5U9ukMMvSQ/Haloiammnm5f+BuiN2Uqiqh//DqAkN4tUJAGNCn55wYMroFEeDnuNHepS5qM0rv5YvIMoS081EfYWjKKpiTIa8+Vlym/CgQXIs3gJhraugvoZbFUGK971nUZQtrWQZ6/WvEJg+j5xSr634ib88tF+cVWHA9RnJ+X1+O3uMoyns7G5PsCDPdYdgjyMxVlZsK6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qQjgfJtFeDpQs1UDd3grJQeTE1d0BRDq6YHo/nEurw=;
 b=gbvPM8V3aGA8mvx4LtKacQGxQwFRnEkncF5kWnLef41MUCnDkA9fJigqeI4hca2AP3kdQ1U1GUbek2FUTtMEeJezdzImnyQL0xgXzyqqtXndVg8u3GKbEBKO46yXV3wt7EUnbhd51mCPNkv24TCt+GJ1E+O+5VWBY/U4cUlkMk1FgzXF4bmPLXBhtXyaAcaD1Bycx3ViESzqpcqy/vzoTLAM9Cg+tLbseCPMJTtgclJ5FUXRnqt8GWGCWX/UvyTQUCM0UgwlOVbBkrL75EW2Vc6R+gG6OIsrJOKf356y+CRZWRM1CfNzq6JGmVrpZWPzRKS6U2+XZXlnzt0mAHXy4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by DB9PR10MB5551.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 17:27:21 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%6]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 17:27:21 +0000
From: Stefan Koch <stefan-koch@siemens.com>
To: bitbake-devel@lists.openembedded.org
CC: stefan-koch@siemens.com,
	simon.sudler@siemens.com,
	jan.kiszka@siemens.com,
	alex.kanavin@gmail.com,
	richard.purdie@linuxfoundation.org
Subject: [PATCH v3 4/4] tests/fetch: Add an additional test case to check whether the fast fetch is shallow
Date: Thu, 20 Feb 2025 18:27:06 +0100
Message-ID: <20250220172706.3850722-4-stefan-koch@siemens.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250220172706.3850722-1-stefan-koch@siemens.com>
References: <20250220172706.3850722-1-stefan-koch@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0160.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::14) To AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:41e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4959:EE_|DB9PR10MB5551:EE_
X-MS-Office365-Filtering-Correlation-Id: 2541aa35-517d-4da3-c553-08dd51d3d4eb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?GGgqb2aO1elr84aGs9Pff0dsQapj/6I6TUgJdTA54sXVZYN1s2stpcjgX4F7?=
 =?us-ascii?Q?JEJ312BEBbKU0mpAjhrTV0ubmUDOOKhbPB25XDQ7LGfshQ/4BEWL3ZEBEBC/?=
 =?us-ascii?Q?3LannaejBZ2HcELs5leGlj4CmZlQz/9FNGRana+HUU3Se1XV82j/wyhtoO33?=
 =?us-ascii?Q?qPDYsr2cqOd1QGkJFKq9hg2oSg1VW7ywLaOvUYl+lB70hfuP792GVmY44Mat?=
 =?us-ascii?Q?w5VBVolxtFBL+syxjaZBRFjGdm+SVJsZIJ+dPUd9vz43cuKPbLnXLpYdesL4?=
 =?us-ascii?Q?mJWSbOy+HjmBKjrjlrkmNYpxcIsCuOXHRaUOvPH91WyfHmffWN/35YJyeqBK?=
 =?us-ascii?Q?PvF9/0hG1vu/ix2b0Mitper6S5JxaFv80UVlwqulF5Fzbx4lQYN1DohFIOWk?=
 =?us-ascii?Q?M/9GfaWOrfdWp9UipneqNligcANc77z69Gr/R+XXJa3Y+hlw4QHIfEd9wDUY?=
 =?us-ascii?Q?uHtWJjc9BQhFWXxRU0Ow9Ts0z0ehK1tiSG4OTDa6KVZB969ubjXx39559K8R?=
 =?us-ascii?Q?g+nYB5jN3fWAaw9AtEYsPkWET2klFq8axpCYeM6t/RmwnwEJ/sXCRsVbkg77?=
 =?us-ascii?Q?5AshYFFo7i6t2c786Jf5j/kgUtShzDCZ4PAVik6wSeMm7rBg+2mUahouQRk+?=
 =?us-ascii?Q?WF7UR1nNI7DgOV1gYLYHKVOTV8Vs21xjVskOhKIKkSlMrtsFK3vhiatRq3lP?=
 =?us-ascii?Q?eysBTAebQu15ZWchgXhhYWa3pNDtRAOC+aAy80ltxC//0Gm6fBbnRpZ21vFC?=
 =?us-ascii?Q?iwVNl+oi8FtobJ4JEfeqq85YOBqFQnq0fDwulPAcB9NQoTtnfxif09smo/t7?=
 =?us-ascii?Q?9eLUm6hbk8e2gl+550ccdzQaH0LKFQfcmc1gNWfCz8T6W1+z5DyO1O5fJrwx?=
 =?us-ascii?Q?bgstfBe/gy0loWpBfKf1uxJNmVQTQqi/tVwEksne5JgzFnbv/oKk2KBPgthm?=
 =?us-ascii?Q?F+sIud9Td4YnZ3tRM72D0llXu2/KJbKOT9zu3UoosHOuNy8MNs8nLmlA0oOI?=
 =?us-ascii?Q?1VWA3iPlULltLF+Uym9t3Yoax9yPpgyNC7LGie7et5nq0sX6/XmaG+1NKxRy?=
 =?us-ascii?Q?nmQEY1Viaa2xY+dEdPh+nCIiJdozZyZZAfsvY0gsq3KJvwh8d2m/FBKogkhV?=
 =?us-ascii?Q?mXXWXL8Rtknt7caiyKYva8vs7lk6qjg1bmpNhOaavE0c0CQTCS36upNczbVo?=
 =?us-ascii?Q?rqp/HnOfvepiT3osSzjpi+k6QDrYX2r04OXgiYx7PK3Z4o8KL95W8trBaCQo?=
 =?us-ascii?Q?M7eSpCdj76OEy/vNecSo6oqKQ4dxWgt8Ku4T38oF+LWosCRQiH1x4cTufqRK?=
 =?us-ascii?Q?9R6DfDqJpc3GFwfND7K/SCXoMdj46E1X/CIlNFpoAeGmRUTmvpQApnV/hbaI?=
 =?us-ascii?Q?3mh18oFG6a8K60MxkAV6tsZrdOnN?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?sUimxy7e5X6qAem1/vBhxbmJlHaJM0vKWj8mEsYmucC++06seaC1ftx6vLGO?=
 =?us-ascii?Q?h5z53837KU2zAHIKcdmpxVoTcrukr7nBJ8SneVUranS4bspW45AcUIP1mxOC?=
 =?us-ascii?Q?DEDqS9vsduYdT4IHDKcu+Av0HCo2DtIKQuL73l6URJVz/ng4txZLYnEe0J0Z?=
 =?us-ascii?Q?Bex159+hZm/YfpKn++3851ewM6l3svlPw77u4ER2WqUNCp6OqOKd9EjksuXh?=
 =?us-ascii?Q?cAkvP4n5qijSD4coKso6f2SEZQs2MpiHWUk9TzmKyxbHG7CKb3IHyg2YVHzt?=
 =?us-ascii?Q?k/8vT/oBPPSNQiyDjVVR8Ujt6CCQDXlPGQ8Q4QDDAmnNgbnqizRxvhlKTqYi?=
 =?us-ascii?Q?2/tyW0ag6Mfd0aw7e7VLBQeQxjERXhOv8gTJ4e3wdWYJKDbM918p8irKcYBM?=
 =?us-ascii?Q?NFLpfFgc3xogzWiDFgYqbUUlMMLIuq2TopMZC3zT9LIyH3frcv9Jpnw6E6ys?=
 =?us-ascii?Q?XmIUWkkaRY3MtAr6wTRgSOIfihmAaMdyFQYR17iAXa+U60TZpIoBUasn4uBl?=
 =?us-ascii?Q?v56wp2sxkDgyfiMXqt5ocvB9J4zpm4wMVYkgLFTFNu2h4fTjR7iQcoklTfFz?=
 =?us-ascii?Q?Gg7dwhdP9njstpRWYuczRBbklavrlATJRxdEwoQc8c+beHFbz94G+hZx/cvj?=
 =?us-ascii?Q?RhvhdHhccQLUDIwQp1t0Fs1FpPercvuEJt0/ZCk7Ma8JEEPYIxqGrmB2fEhw?=
 =?us-ascii?Q?wPYuyu+8LK4swOURV6uFrn9hc4KVtofdgKFKwwqewcs+tJafUWKGU3ntxxtI?=
 =?us-ascii?Q?gZfsYCemJNyVyeE47XyOV7hIwtWMr+oTThC2RR33q7kPfzLwbAQtUqh+FY4T?=
 =?us-ascii?Q?NamZaOj2aCDfwRfRr7xnxEn/OX1Xxr6cht2WjVNaBnRuWniyh0x4zvwG4cdk?=
 =?us-ascii?Q?/f8/y7HtHT14H7I2b2dM80YVpAkUm22lQPG0CkChYafZNRro3SfNdhwakIDE?=
 =?us-ascii?Q?EOfspvP2OJLNNYkeue2lbyPowvIf4wv2EmUx8C7e+Iq9EEYYRBxZZ7tf9odv?=
 =?us-ascii?Q?pazT61lOK8AQSMlxnDEyuGDmVtEcQ8WwGFGkntr3qFzrbOJ4XryHtoLMa6ge?=
 =?us-ascii?Q?Uj7UW9S/QsKsRlpahbvTPABzhKxG7oTzzNGWKMdU/RfhjFSIayWGQ7XwiBIh?=
 =?us-ascii?Q?VATI8qfdZlALmp5JuTffLovPBpDOVtQ1o84K9SfmHTK7nvxznaKQwaP7JvQC?=
 =?us-ascii?Q?TTBfF3YVAC4+R/afdzFscfXA9jyIX9dZ6+vEYo5kYVyM5YthIu9Yxfm0HGsg?=
 =?us-ascii?Q?iboV5lUIu4M3xoDIk1xrQwsLoHAd8DRR6RAmaGBN36hXIGdEvRd6Jxal+I4r?=
 =?us-ascii?Q?LPXZqv8/rJU/kO9B8miqZerk2T+tlCbLCklzQNrUnk3k9td2K3nysbdOJCqG?=
 =?us-ascii?Q?ZbQD2+KCk9gaYgrySmDdJn+6LVs4Ke9NG43/7t58niJimyrfh6B0p63k0wH7?=
 =?us-ascii?Q?mrlOceGuPUI1kgJOuZN7ng6ptt9S1B8tEvWXddtjIkEct+ng9U8miefJnMwu?=
 =?us-ascii?Q?vcuOK2TATbr5PGHaQaaRK0ytmgm3415EZgLaebUe3aKwXe5kyk8jumJNryqJ?=
 =?us-ascii?Q?SS9iRYFZOJbWSZ2HJitY2lnr67ttuP5XqQKs04wYPIR75A9J9ISUGJM7Xqxg?=
 =?us-ascii?Q?gg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2541aa35-517d-4da3-c553-08dd51d3d4eb
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 17:27:21.0216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bSonqOb4EAz4zujXkOWz8aUYnUozdq6oqK+P6+TrxMYOPU3UJ0AY8hPndl8FB7SI1yL5+wMILWdSixz8VNYg4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5551
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Feb 2025 17:27:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17265

Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
---
 lib/bb/tests/fetch.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index c0b53da31..27924881d 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2298,7 +2298,17 @@ class GitShallowTest(FetcherTest):
         self.assertIn("No up to date source found", context.exception.msg)
         self.assertIn("clone directory not available or not up to date", c=
ontext.exception.msg)
=20
+    def test_shallow_check_is_shallow(self):
+        self.add_empty_file('a')
+        self.add_empty_file('b')
+
+        # Fetch and unpack without the clonedir and *only* shallow tarball=
 available
+        bb.utils.remove(self.gitdir, recurse=3DTrue)
+        fetcher, ud =3D self.fetch_and_unpack()
=20
+        # The unpacked tree *should* be shallow
+        self.assertRevCount(1)
+        assert os.path.exists(os.path.join(self.gitdir, '.git', 'shallow')=
)
=20
 class GitLfsTest(FetcherTest):
     def skipIfNoGitLFS():
--=20
2.39.5


