Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95131C282D3
	for <webhook@archiver.kernel.org>; Mon,  3 Mar 2025 13:49:25 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.85])
 by mx.groups.io with SMTP id smtpd.web11.53205.1741009758511073424
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 03 Mar 2025 05:49:21 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Dz6oH/Ol;
 spf=pass (domain: siemens.com, ip: 40.107.22.85, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nsy8eOO76EkH517Q+mKglfCCOmm6imBX5D6SoGx0Tq/QyJEQPdj+YlFVCddGF/SaoXO0zgUWVX9PsHtQBHTOMf9LmwI8e1dm1CMOPLvKwDul3Aq4a4Pw6YIbk/xj2FG6U7rihcM/mRNVCH2avcJPbhgtcFchW00MEg9zrL5TQJWuJTtKCBqQp18ADc2/3UUPD7lCKzCh4Hmr3BNJAkiay1cqDOrjc/iQLAq/BTkytbMqp+Pvau2oYxAhDwdx0UK4u1hfyv8R2iodsZJp34iFdtNOLo/Iqp8gD3/NPsDdQ4fja1eD7T7/AlqcQnjEQVD0RTkMI/Zek/vsSKfvWpy7oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClpcmoPFdfrlx+od8n/luzQpiyHPp/0x5T+gG6ywBsk=;
 b=jqmek/kPlj0Lnc0i8g20U1WURAlvQSyB0R3S8PNZ2K7LqUOEwRkWOhiWdVRcHeD9xLzvlUjJWQJj9HQc18b9XDlgdQiT4AMHdTcy7aFnC9E9fOxejrFWN1RIrsT+i5e1ax35cHjMi+HwIiJNoN/+SkESO9LoFvjrK2nVn3Q1hwqUKtCv3DttheqUdM+UMicToc7ahJuISgfIM75KSSjHieWF08MaB+I0j4WUcETgNAm57Npk5K+y6scaDzdgPm8L0+qoAh4vpv/8L/rp33yoxceFKy5nLmkon5OWFO3LSPl6TAQmWCoWTaKeHvOdKW/g+WyuwnP4d/CwIBQucY6G2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClpcmoPFdfrlx+od8n/luzQpiyHPp/0x5T+gG6ywBsk=;
 b=Dz6oH/OliEhWSiP+zFIdNsP9xIGVaIWEdUYdaC6zFySgVYGXP19dt/n/kYaoTqPIv3Ifx7olLWs+L0TVLI4dyLi4rf0Cm4vBvwRZWP9o33x7i7Fizh7WzOsNXzxpNsRN44D+IjpA+4w857LmrHFOfvRYTDYSpg3nOoXcPH0zyURK3dMDK4NgBPHgY6FY+7deqNxEmC9dxs6kaVkIYdHcHuZnpHl4yhw3sHSRJuKjhVJmbpIX2SWgwNAWG76BcjU4nwk7WT88RhzlnzPWaH83UlioTXSm/wF3qwo7Sb6RfrwqJ5u971G402jeIbJgoPbrI95T6u+B0jzrOULRgg5GnA==
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
 13:49:18 +0000
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
Subject: [PATCH v5 4/5] tests/fetch: Adapt test cases for fast shallow fetches
Date: Mon,  3 Mar 2025 14:49:12 +0100
Message-ID: <20250303134913.356778-4-stefan-koch@siemens.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303134913.356778-1-stefan-koch@siemens.com>
References: <20250303134913.356778-1-stefan-koch@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::13) To AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:41e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4959:EE_|VI1PR10MB3165:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bd0525d-b636-498c-0f7b-08dd5a5a3169
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ELcnnwPV+VKPqWP5sS9wvseGLjev5kuOllRrrqRPVG+blGzlIkq6ObAHl5he?=
 =?us-ascii?Q?noJqdl+AlX40BOpqF6hD1voPff3WNL4tTq6DHTH+LhQsWrIUDqlvJlYbbdMi?=
 =?us-ascii?Q?xr65/5mRQopGkyruc8qhuH/XqdBzQyQ4038D3ok8MARvSpggO6fyJPxmf+K8?=
 =?us-ascii?Q?x9LzyNOMCPiFFKdp5P7NeSPVZNrTcg2Sula/H11dfYQR0msLwP3bWEhYrlGG?=
 =?us-ascii?Q?oRusMKGxe9fhHyuS+sRQKnpxZVzcJ8v94QghBAMxSbIu+W0XoSxyFwrvLcr2?=
 =?us-ascii?Q?WhuFXv8jfD5VlcBtyNaFk0is5l88UEXqNFguiWklAyzT0ER6389/OEDewKC8?=
 =?us-ascii?Q?MbadTz/GI1moaY+J3PRYG/KsxeUF0wVSzB+tNvD6n6pwsDgPika2QUU1jqh4?=
 =?us-ascii?Q?6C3MR2uPfaL+7ulIAcRshr2hVlKAfH/hTWNv2LxQLDkmm6qeHs1jO3lP53Or?=
 =?us-ascii?Q?wCPOtv1vG6C8KQ2SMzIzBLPDliwzJ/dCcF8I5XF/x3KFdf+dj0qypWjuVgIZ?=
 =?us-ascii?Q?g5XN6fg5jM578FEioGI0HGgr3qUHuUtGE3EQAl7DvqpafZXo0JEdnxhxhXeL?=
 =?us-ascii?Q?G5dcZdjnTJG25HDBdCyHzMbPmt7NUfIrKea0hfKMnRfcPmHlI+YXp+yHP+Bn?=
 =?us-ascii?Q?bn0dGfICds0fXx6CYwY8smplSH6+Qw14Ed2RHAlL5kkPnr0KvaRELtqLLPBm?=
 =?us-ascii?Q?8pmf8DkbJq1K5YVmmxgSpZz96bj+afXItGR3E9zNpQjPCgb+oTMZykeeyBwN?=
 =?us-ascii?Q?ohwmSr3jigLCahWB39sqciOmcWwC9h9fbN9N34thqwCtdWRLZSyskC/mqCRh?=
 =?us-ascii?Q?U9UIGEEUFhjCljso9YmNB5RErApSLK9SdGxENEZsO6dRgztjMvXJGfHMQC9G?=
 =?us-ascii?Q?rMYTp7ck6rhNRXKM0GxMjgIENz1ifQ39vXSRnS740eco4rDqzKeVeabrgv2l?=
 =?us-ascii?Q?vJM9OaxQlLuYDXFngcneR1QIpHpdsv9lkGwChKmrMouenJBSOmFNQOY7rRkV?=
 =?us-ascii?Q?XwOBsgDKO85tGlHQJEs8/wnC9QTAm+N3QjGQfravOa9bnbqUNnkadRc85+DZ?=
 =?us-ascii?Q?grIEMXU2dTooVGpsnw90cpHVBajyPj2GlKwkGb892WQUB7FLgheTBm9VYJOk?=
 =?us-ascii?Q?lfodYIJr901Tb83MowJY/aIe4GgMeZ8VUQ46vjqgWq6KKJJSyHM+PmofERlO?=
 =?us-ascii?Q?YkVy9iFrUkBzSwA7haC95Yx3nrDK9ugxGB7SEXoJz0wFPsc3Couh6M30ZyTZ?=
 =?us-ascii?Q?GW+E6z6xTvfSG/sN2bBvY/Y45XQe7Z44nfELRnXWd3mD33JN4WTiT1I4r/FQ?=
 =?us-ascii?Q?JhM6QkGKAEItIvT46sZxf+sEE5b6tl08hYT6S42P7QTpUiATh/yl+2My8nHl?=
 =?us-ascii?Q?yiinBYycvJmEYNZrvwIsIDS64Kvc?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?XXn2sR62KSwxisLSFVR3k2H8BBTfbIdGmzxOHevuawMqaRjydQ9UrZXpeh3G?=
 =?us-ascii?Q?TURJpvcE6RCdnzESUdog/0AlBPRoQ9fd0GKKf8m2fPyXimJ7buYnR7526kkV?=
 =?us-ascii?Q?+R1G3vCOI/Zw8YiyZ0Ja04oMR2HEdOVuqk/qoQUmsCy2gzbTcZKE/kJ81SGY?=
 =?us-ascii?Q?zJhnmhuzy1L9Im+USvjnRSkSS9WtrNgtzuqey05ma9mecd3qAk8xGaGuKzwd?=
 =?us-ascii?Q?Z3+SMl+/E00WeO7oLl0llIRNz/k/k+qESvb6cw+M/gXinhBF5B5O+g16ixZl?=
 =?us-ascii?Q?DVvMwsKjClil3TEsZmvjf4S09J5vPa+BqrSoytVF/H36PpoQ/hwPsNYcG1Lf?=
 =?us-ascii?Q?1EjYwknaiCHgqUNWe3qgJPqLz+wWHu+xf/Q1yXXPOmsITGA8Q49q4/iInatH?=
 =?us-ascii?Q?TpCjBlTESlZc5XeRrHJ8YpgOmgpRHwsxDj2yq4KG51k+18qaVHc8PPyNJcM7?=
 =?us-ascii?Q?NqtEtrVSYNOm68DsU73onyhgAMwsdcnE/yaGReBtSMHa6xW/MXlv1Ul3HQvN?=
 =?us-ascii?Q?hDDA+WzT4F7mzlElzFCa8jNUFW/bEwux6bxymjInPHOLhPgeE7YlXl/5+IyX?=
 =?us-ascii?Q?7b51rw+WjTMygrHSsW4JvXGJ/EPUC93yShQeM24H7jbT2ZjVUO/4Uk8P+jrC?=
 =?us-ascii?Q?A54YqqWGycVQPMuUxlO7LomhuxHqqb5O401I2+36RB/qjTl8bGxU4hsB1hfk?=
 =?us-ascii?Q?RFZlOEmYyz9P6BamawiyxW+6oyIa01drAM3Mb5TdTXbrGnvrSSowS4VQYTQe?=
 =?us-ascii?Q?i6YwQjiM1EprtKN7Zqo9RDEmede7273pEyA6HkaNkupy86Fr2rVYX7qdWuwS?=
 =?us-ascii?Q?3rL+xJCXK+TEyET3PFcwOdh7hC+sXV+2Rvu6jsomwWGd/o71+dXmlnc+/2JT?=
 =?us-ascii?Q?ebChAtAz4I4RaQkmP7FLoZjuDThUawAeghKnSm5HFBU5LUvsB/+5lb9HTJak?=
 =?us-ascii?Q?GoHs3XpM6s5jbLzrkSQFu0sLzDM8P0ZnsjkWWnUYWruChQS07Xj7RJ+i1DeX?=
 =?us-ascii?Q?3+x2TtmZAgAgicvnNz87XOSiTkk5NzlQNS1ZR91hVZNGEv15vdIR0zl2NZDU?=
 =?us-ascii?Q?7J6AOKbPyu6qccteYkU/jtzRK/hCtSzp/rXZbih0pj5DM4SlzY8a7STu6tbV?=
 =?us-ascii?Q?zhDOoyMbMbJr3q0Jpg54KsKXg/Nui7mzMchCa1+9yJ0BpuRtQvw6GlCjOPKd?=
 =?us-ascii?Q?eWbIi+xDHhIcxRg/r3CrFS/LDNvShuaPqYhNuAHgqbnEzHWD12DGmwsQcW54?=
 =?us-ascii?Q?rgoFrJYPpOUwoi4jvHEWKFxoNAGFla4rdMPvKrIEAaS3W2HICZd7wAagrMQ6?=
 =?us-ascii?Q?x7g9ZHtsPQoPSbmm2rROGWLjitw2UbaxHjlt79GN2URLiTaroRvXfCBl2eCR?=
 =?us-ascii?Q?roy2CHpG6XIa4oSrmjTMmByWp+Ar3CkwmvfHEZJECdvAdn3SjcnXxo/Qc/ug?=
 =?us-ascii?Q?Woz1yY1Azaav3z/4o/iQ4cHptxrCuIo1IR5R+/NtdvRkQMgwAKlR33ViCNwm?=
 =?us-ascii?Q?jfqEI0MCieI8naetMpqAkVikRL3MSy3WQfe5G43krQAlofhbyAyfDzzQUtWi?=
 =?us-ascii?Q?j6zIAhdLy8yJeZxWI4BbfXpf3kjOVGRsU1mY81n6MYz2o5sP7WiBoDs2rY9R?=
 =?us-ascii?Q?YQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd0525d-b636-498c-0f7b-08dd5a5a3169
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 13:49:18.0129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f+ZHHUgmpcJAbiFBfao7ZpJBrytwqupG7Frvlp84SDgmmKmE4Y5gX04pUcnWM5SftJ3jil4+cAhDRX99rZtSIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3165
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 03 Mar 2025 13:49:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17378

- Address the absence of an initial full bare clone
- Utilize the initial shallow clone
- Modify existing test cases for this behavior
- Remove incompatible test cases

Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
---
 lib/bb/tests/fetch.py | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 48b9e4af1..4a5af7106 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1814,7 +1814,6 @@ class GitShallowTest(FetcherTest):
     def fetch_shallow(self, uri=3DNone, disabled=3DFalse, keepclone=3DFals=
e):
         """Fetch a uri, generating a shallow tarball, then unpack using it=
"""
         fetcher, ud =3D self.fetch_and_unpack(uri)
-        assert os.path.exists(ud.clonedir), 'Git clone in DLDIR (%s) does =
not exist for uri %s' % (ud.clonedir, uri)
=20
         # Confirm that the unpacked repo is unshallow
         if not disabled:
@@ -1822,9 +1821,10 @@ class GitShallowTest(FetcherTest):
=20
         # fetch and unpack, from the shallow tarball
         bb.utils.remove(self.gitdir, recurse=3DTrue)
-        bb.process.run('chmod u+w -R "%s"' % ud.clonedir)
-        bb.utils.remove(ud.clonedir, recurse=3DTrue)
-        bb.utils.remove(ud.clonedir.replace('gitsource', 'gitsubmodule'), =
recurse=3DTrue)
+        if os.path.exists(ud.clonedir):
+            bb.process.run('chmod u+w -R "%s"' % ud.clonedir)
+            bb.utils.remove(ud.clonedir, recurse=3DTrue)
+            bb.utils.remove(ud.clonedir.replace('gitsource', 'gitsubmodule=
'), recurse=3DTrue)
=20
         # confirm that the unpacked repo is used when no git clone or git
         # mirror tarball is available
@@ -1907,7 +1907,12 @@ class GitShallowTest(FetcherTest):
         self.add_empty_file('c')
         self.assertRevCount(3, cwd=3Dself.srcdir)
=20
+        # Clone without tarball
+        self.d.setVar('BB_GIT_SHALLOW', '0')
+        fetcher, ud =3D self.fetch()
+
         # Clone and generate mirror tarball
+        self.d.setVar('BB_GIT_SHALLOW', '1')
         fetcher, ud =3D self.fetch()
=20
         # Ensure we have a current mirror tarball, but an out of date clon=
e
@@ -1919,6 +1924,7 @@ class GitShallowTest(FetcherTest):
         fetcher, ud =3D self.fetch()
         fetcher.unpack(self.d.getVar('WORKDIR'))
         self.assertRevCount(1)
+        assert os.path.exists(os.path.join(self.d.getVar('WORKDIR'), 'git'=
, 'c'))
=20
     def test_shallow_single_branch_no_merge(self):
         self.add_empty_file('a')
@@ -2116,11 +2122,12 @@ class GitShallowTest(FetcherTest):
         self.add_empty_file('b')
=20
         # Fetch once to generate the shallow tarball
+        self.d.setVar('BB_GIT_SHALLOW', '0')
         fetcher, ud =3D self.fetch()
-        assert os.path.exists(os.path.join(self.dldir, ud.mirrortarballs[0=
]))
=20
         # Fetch and unpack with both the clonedir and shallow tarball avai=
lable
         bb.utils.remove(self.gitdir, recurse=3DTrue)
+        self.d.setVar('BB_GIT_SHALLOW', '1')
         fetcher, ud =3D self.fetch_and_unpack()
=20
         # The unpacked tree should *not* be shallow
@@ -2295,20 +2302,6 @@ class GitShallowTest(FetcherTest):
         self.assertIn("No up to date source found", context.exception.msg)
         self.assertIn("clone directory not available or not up to date", c=
ontext.exception.msg)
=20
-    @skipIfNoNetwork()
-    def test_that_unpack_does_work_when_using_git_shallow_tarball_but_tarb=
all_is_not_available(self):
-        self.d.setVar('SRCREV', 'e5939ff608b95cdd4d0ab0e1935781ab9a276ac0'=
)
-        self.d.setVar('BB_GIT_SHALLOW', '1')
-        self.d.setVar('BB_GENERATE_SHALLOW_TARBALLS', '1')
-        fetcher =3D bb.fetch.Fetch(["git://git.yoctoproject.org/fstests;br=
anch=3Dmaster;protocol=3Dhttps"], self.d)
-        fetcher.download()
-
-        bb.utils.remove(self.dldir + "/*.tar.gz")
-        fetcher.unpack(self.unpackdir)
-
-        dir =3D os.listdir(self.unpackdir + "/git/")
-        self.assertIn("fstests.doap", dir)
-
 class GitLfsTest(FetcherTest):
     def skipIfNoGitLFS():
         import shutil
--=20
2.39.5


