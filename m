Received: from NAM02-CY1-obe.outbound.protection.outlook.com (NAM02-CY1-obe.outbound.protection.outlook.com [])
 by mx.groups.io with SMTP id smtpd.web12.19630.1617383773958212525
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Apr 2021 10:16:14 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@windriversystems.onmicrosoft.com header.s=selector2-windriversystems-onmicrosoft-com header.b=pEmJcO4E;
 spf=softfail (domain: windriver.com, ip: <nil>, mailfrom: paul.gortmaker@windriver.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGJ/KGZh+Fa1GUkinvXw4xinhEhsS29ym2u1oOo1jPI+Rrk2fNat9A5A5pcHqPSSvS1IzO4ewFPVVkqEtgcVxB+MH2SLq/iIWtfadI0UfUNI2Jv3we3DheHl7Wh4ikBXBQ3xdvwrEic9ntOg+jt/3VZSdJMWb/3ALknORR5ptpgRrqZTTTrwL0jNeS+imbPLxcJQnmpDyKAnXDSoA7Vq3T+py3vqJwEZ1Rqu1GFkGnQdcX5pzbrZigFZiohIZc6QWLv/Hk33o/ivZXha7K8Z7ELoBpbb6CVGISvRRoh6Eo3TYl+wgnq/NTSL/uD8HN7sKJKJDJJ3hwEK2Qs0Ju45Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHNaUovvR9XwQFh/2UtPo0Xy1g7ab3hUxyxNcmpPYvo=;
 b=PC43bG6iS4oL+yDGGexD7oEDTsYPRjGyX5ynGCEAMC6MeCpwHS+ZdmKIcsKAE5sHatJF8Qs8H8ZBdC/5bv6+1n4i3LWg+4xXswr/VY/mpSg2rvrhyXCM4vgBbW8dCasAlg4Qm2d4a+HZ6c+n2UnFXTayIJ1IynUsyokzmzpBkrzqBLDftbfEItD0TuD7ZIDObLjhtygAQ2KjS19fwv1jyPBnX76gXia7WD8GxV8rb3iN4kHV1NVu3PvHV9G1iSE7S1nOmTkWWt6YH/J89pmwCnHRbJ73n1Iy33WIAzjtSjVeDdCJbLvnvoJ/Ze1RqhtxZ+gg9q2qyBBSBknp5HoDKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHNaUovvR9XwQFh/2UtPo0Xy1g7ab3hUxyxNcmpPYvo=;
 b=pEmJcO4El8XtB+QxvAep19NFldx4/VWSOj5ye0nahIstDPgo5DFYQ0ZfbaUWrp1WYp+5vWXGfdkx+k89CdQsTRNu905J2P98aRvPoEdNnRpKX8FhCFuQ3Z4cILK7O4t4nDKvx/tujFMT9bYjKwkMvBfTP7bNnpEgjEgfUhQr28w=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM5PR1101MB2249.namprd11.prod.outlook.com (2603:10b6:4:5a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Fri, 2 Apr
 2021 17:16:13 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::3d20:ed37:cfec:4ad3]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::3d20:ed37:cfec:4ad3%7]) with mapi id 15.20.3999.029; Fri, 2 Apr 2021
 17:16:13 +0000
From: "Paul Gortmaker" <paul.gortmaker@windriver.com>
To: Bruce Ashfield <bruce.ashfield@gmail.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
CC: linux-yocto@lists.yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Subject: [PATCH 02/21] bitbake: fetch2/git: allow limiting upstream fetch refs to a subset
Date: Fri,  2 Apr 2021 13:15:38 -0400
Message-ID: <20210402171557.981599-3-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210402171557.981599-1-paul.gortmaker@windriver.com>
References: <20210402171557.981599-1-paul.gortmaker@windriver.com>
X-Originating-IP: [128.224.252.2]
X-ClientProxiedBy: MN2PR16CA0026.namprd16.prod.outlook.com
 (2603:10b6:208:134::39) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
Return-Path: paul.gortmaker@windriver.com
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yow-cube1.wrs.com (128.224.252.2) by MN2PR16CA0026.namprd16.prod.outlook.com (2603:10b6:208:134::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Fri, 2 Apr 2021 17:16:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a60e418-d03c-40d8-bd99-08d8f5fb0493
X-MS-TrafficTypeDiagnostic: DM5PR1101MB2249:
X-Microsoft-Antispam-PRVS: 
	<DM5PR1101MB22495A396C2AC5B27C7B0E4D837A9@DM5PR1101MB2249.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	rqOSMwV6Wxd2yXHpxs6YaaPhjkD7ixVVEd34tJvyoKlIP0agpbOBbGUUNhFw3V8E/I1qbzIPiHK5Rgzuj3fctggTmV2Y9ZByKvQLQ06M/k6mMrpOnfu0B+1RXtUFYwIyFwDA876LJWZ0hN6JwO2IKP5/xAl+LePTEiXTrilUH8KtrWS41tb308HqubdTodflC1YjNvF8lROJPYjhqrHWOWxHDZ2R8l+jbvBadclTakch5kf7ChWFxDcFqeliIjoZkUc6izMdBv3z1XBbaCtp9DorxrSldL+2AkmuXyxU+5Ifms4X1/ndIji8VXxqombfJHrKCo3aEBycWnwP8O3ZkhT2jvE50PNseOlPe0yqPu7wpuDrfGCMYuS8h29eIYJA0zrYlkoj2gLYfeVCWSnzxBA177LCWkStAUISIbEpxsNjJx5sgVGrRXSlpR0hNCvwpxM2ol18g4cK3JB7GkQ7uPFIPECvwZ7wSFHXQLxKr5WxzjHExYpjXWg4N/cvBQaS0qsec/N4vc68EE9ZeaDR6UG9ysAhDqoyVSmG8tZpsxGuS/ODQqERZGR67Cw65nQ4roe7bIMfZXqO5bkl+ZQ/mbDGk3aV7biL1LVKRGlGMWvoytDLMCduP1FQPXtT9k/fGXpqL4ViqaeJvGA7lfCwTg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(396003)(366004)(39850400004)(316002)(110136005)(6486002)(66946007)(38100700001)(8676002)(86362001)(956004)(2616005)(16526019)(186003)(26005)(2906002)(4326008)(44832011)(6506007)(5660300002)(478600001)(83380400001)(36756003)(52116002)(1076003)(66476007)(66556008)(6512007)(8936002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?3658WAgZKBzBd5nXAQDyaUrSZ015TeXj8xH7Eio/uhNru7Rn5xUkgkedg4BN?=
 =?us-ascii?Q?cNWvV2z9a95re1NBbGCSgHj/hKY6WIz4swqfO6bdBC3tPG1w/xZNmUav6Tpu?=
 =?us-ascii?Q?grazCCdyFCeKgtppJvj32ae3Ownz1XptNnCCl0LN9jRGT0Y2DvWmDgvgkEJg?=
 =?us-ascii?Q?ikI+y65qthCIdrQpm+zhwxeK8uo9gBKxl9AOYlQGCgr6a7r5XLbU9U/8uLEv?=
 =?us-ascii?Q?ZurPqLI2vMiia/4x6twfk59NrVZp4uFTddyOgBfcrmi4pCKob+Y5Us1lTPx1?=
 =?us-ascii?Q?k3sds4rSeB9KknVqLci/mMtLx8Yq2JBsKD7vqlbOYmcESm5iXIfgDVtglhDu?=
 =?us-ascii?Q?R9s9pLpHtksSpri8Z+wRJaBuRYP1oHBhxez70gEG/oKG87VwOIT0bpj+JN7w?=
 =?us-ascii?Q?F8KIsM3nwiym1walOtWB9XbVLObVPk9VbgMQINf59BZGPVMG3m1O5E5dZBoz?=
 =?us-ascii?Q?SWD1vKFTf2MuYyRCFM9W9Wg8GKZSXPtm38fvyYSORfvU9aweIz8NPGV+ug7L?=
 =?us-ascii?Q?Hpq0i6lsrxJg0W4gDPz8wyLEf6piEnT4GghqiKnAgd2wI5Lw95pf0fOdrxFs?=
 =?us-ascii?Q?Nk1Tt8YReZa1ADfRNc0O9CBmNlpAqbH15PcWivOoWBH3OrsfWfkpiKsklPLE?=
 =?us-ascii?Q?Zkl96ByPayDF1MG7elL6ZT0/U6cZR1iC2+XQx+sGHfLsf+0/UTWw4iDcsOV/?=
 =?us-ascii?Q?CoJQGN8DOaAjYOGyfnuiQPEtGOddSatFqmr6EsqUiBQL8aWttHSgUBMb9PMx?=
 =?us-ascii?Q?MkfNe3p4JZZhNtgSRg3emLa2Nwuwwyrg9iU9Dvl3pD005e2musHHe9giPi/w?=
 =?us-ascii?Q?IacBweNN4DRDMDHo5+YD0XQJgwUjI0S7fFqvkjX5MWH6ktmCMoNlIUMwKypA?=
 =?us-ascii?Q?+IakYnw8kmYR9d+SHldUGY87J+N2JtSXKESStKRTOCIdiAISTZryt4+Ub3wf?=
 =?us-ascii?Q?W0xIYCctbTbf57Va24lDVTrHO0Eb9f95SSdMA+kLGJAJiEjf2bfIgWTskTjp?=
 =?us-ascii?Q?lQFIEKuER3gsHhvAM23jaauB/aoBkCaqQ/aIFyEH3t/uayzgcIxjUJiUVaTY?=
 =?us-ascii?Q?a3EAgqRvVnBEPFL0vAfYc5oHKka5ftQWzamqxbGeDM4rMw6QZyPDm7g3HFwa?=
 =?us-ascii?Q?1l5VxNWCIBE0aw0UlOy3fn8atixrG60BYI+i42gMVHB3htRoDdQVdkUcTriV?=
 =?us-ascii?Q?0ZnZbwV/k5kxdZ98YIQd00M5QmKOosIGMAFCHvsY4PDfWWlSE/g9T5s+w5S0?=
 =?us-ascii?Q?Qb1Qf3isXWVZcuvagswZrgE4zmIc0zVSVs+fdIZCh8xjNGXc6t6/0lanXWCL?=
 =?us-ascii?Q?hK12r7pDkWQ6wXaJXC5IwbDW?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a60e418-d03c-40d8-bd99-08d8f5fb0493
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 17:16:13.6851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IEMKj0lQI8qM6iOm2BUAnWMTPRRlLh8D/7cSC+61Sl5NwRNCF+XHaJA/u14upGEk20jWQfPS4MBY4UZSNDsbAw+fYIs00tiAQO0YwOkKS+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2249
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

If a clone in the download directory is not static, and was created with
single-branch to avoid additonal unwanted content, then the fetcher will
come along and spoil that effort by unconditonally getting refs/* from
the server and downloading everything available at the server.

To that end, allow a companion variable that can optionally be used to
limit the fetch to a subset of references that are in line with the
desired content for the recipe in question, and so that large unwanted
downloads aren't inadvertently triggered during an update.

If not specified, the existing "fetch everything" behaviour remains.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 bitbake/lib/bb/fetch2/git.py           | 3 ++-
 documentation/ref-manual/variables.rst | 8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 22281e2cfb98..b54ec76d7174 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -362,7 +362,8 @@ class Git(FetchMethod):
               runfetchcmd("%s remote rm origin" % ud.basecmd, d, workdir=
=3Dud.clonedir)
=20
             runfetchcmd("%s remote add --mirror=3Dfetch origin %s" % (ud.b=
asecmd, shlex.quote(repourl)), d, workdir=3Dud.clonedir)
-            fetch_cmd =3D "LANG=3DC %s fetch -f --progress %s refs/*:refs/=
*" % (ud.basecmd, shlex.quote(repourl))
+            fetchrefs =3D d.getVar('GITFETCHREFS_' + ud.names[0]) or d.get=
Var('GITFETCHREFS') or "refs/*:refs/*"
+            fetch_cmd =3D "LANG=3DC %s fetch -f --progress %s %s" % (ud.ba=
secmd, shlex.quote(repourl), fetchrefs)
             if ud.proto.lower() !=3D 'file':
                 bb.fetch2.check_network_access(d, fetch_cmd, ud.url)
             progresshandler =3D GitProgressHandler(d)
diff --git a/documentation/ref-manual/variables.rst b/documentation/ref-man=
ual/variables.rst
index cd2b77604e87..55028987c08a 100644
--- a/documentation/ref-manual/variables.rst
+++ b/documentation/ref-manual/variables.rst
@@ -2661,6 +2661,14 @@ system and gives an overview of their function and c=
ontents.
       The directory in which a local copy of a Git repository is stored
       when it is cloned.
=20
+   :term:`GITFETCHREFS`
+      The refs requested during a "git fetch" when updating a repo from
+      an external server into the local download area.  The default is
+      "refs/*:refs/*".  Used in conjunction with GITCLONEARGS to limit wha=
t
+      is cloned/fetched from a repo otherwise dense with branches.  Note
+      that an URL specific GITFETCHREFS_<name> will take precedence over
+      a recipe wide GITFETCHREFS setting, if both are present.
+
    :term:`GLIBC_GENERATE_LOCALES`
       Specifies the list of GLIBC locales to generate should you not wish
       to generate all LIBC locals, which can be time consuming.
--=20
2.25.1

