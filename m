Received: from NAM12-MW2-obe.outbound.protection.outlook.com (NAM12-MW2-obe.outbound.protection.outlook.com [])
 by mx.groups.io with SMTP id smtpd.web10.19480.1617383784768231124
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Apr 2021 10:16:28 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@windriversystems.onmicrosoft.com header.s=selector2-windriversystems-onmicrosoft-com header.b=VbHekJAp;
 spf=softfail (domain: windriver.com, ip: <nil>, mailfrom: paul.gortmaker@windriver.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hkgq7wzOht5Je3b/YPA9rS6FhFDX12ceoK3g96CJlmnm+gA+3sZk/bVGu9WzCo8wuLi6rt3Xmev5m7BjJdmcNl3++RNv5mIjD1YzD5gKHYcL0u3syu0iJvI1kUXjxZchObZ9C36cDKxU5lRsX1cTDZoG95LWLMS1dQbSFUBn8ZlZwXRuF1QiDy0w0hwomz+D8Bh4ogFvnfeoqQZCeBpIdEjKXzlE8c8YSNONntXo/KTmDwTt7+IFp+Mi1ZAp/bSD+peUO2GvDgMDQ2vxHe90HXrWj/mFx3nHq63KX4dJMGA2BTv1Wsk7rmEDA57AivgBKFKNlIXlcDUbrEaymTs0rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdY1G11nrwOoYMOhtNcxtdV+Dq+RVxJ53xazcRClbgg=;
 b=eaomHc8LenB121AAzIlokP8zF0VodQRpsJ6CK8iMOCTpwppPwAZ7z93YAw6tzEeH65lTybtbRHdFvIPCRUoH2emSNaNbzjeKJ+FogAYUm6l7JAucLaskChqwVz8bjUYLcYbeuMryaxjjmBa/URoSegrVnsAL5LnzCekFeiFX0XusO8rd6Lj+Vj714VQENgSKWUMoAZVgJuJQqFlYiJeFqDYyKydlwYdXnELvyzMw/zgXGyiJpEa1pZ6yo4hKUjD80pTomyV7koct3IBVTyybyi6CW95HRAeltPAn8LwpDfS2BKVBEkIeGAicPm7qEfTbEu98Kny3eGF2swq/mzqU5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdY1G11nrwOoYMOhtNcxtdV+Dq+RVxJ53xazcRClbgg=;
 b=VbHekJApautE1kniAINE3FsRWOmbMFQQdhbu4WgTPUkq9TBi8yIfS52frwunztgeJC9Llu/LL/e5GFriwXBNOYhOH5yPvwRYpLDUIhMZ33wJFxJrNbGUZU30XyT+qBWFoQm7bblMRkKtuBOp7so9c5Mt0w3xj0FlHS6vvqlU1UY=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Fri, 2 Apr
 2021 17:16:26 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::3d20:ed37:cfec:4ad3]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::3d20:ed37:cfec:4ad3%7]) with mapi id 15.20.3999.029; Fri, 2 Apr 2021
 17:16:26 +0000
From: "Paul Gortmaker" <paul.gortmaker@windriver.com>
To: Bruce Ashfield <bruce.ashfield@gmail.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
CC: linux-yocto@lists.yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Subject: [PATCH 21/21] kernel: disable (pre)mirror for linux-yocto and linux-yocto-dev
Date: Fri,  2 Apr 2021 13:15:57 -0400
Message-ID: <20210402171557.981599-22-paul.gortmaker@windriver.com>
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
Received: from yow-cube1.wrs.com (128.224.252.2) by MN2PR16CA0026.namprd16.prod.outlook.com (2603:10b6:208:134::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Fri, 2 Apr 2021 17:16:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f42422a-ddf3-483b-f562-08d8f5fb0c49
X-MS-TrafficTypeDiagnostic: DM6PR11MB3532:
X-Microsoft-Antispam-PRVS: 
	<DM6PR11MB3532FD8C3DDAAE0A5938EA1C837A9@DM6PR11MB3532.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/qgSxZe2Jszd3yA2xcU5/pkQmnCs8J2flAd139DZ6ungB+IVgAYP14kbpCq510nUjsv+SQFu02ooVkWQjAlnuvQPlEWn4Pf2/fmF4C0lLlo0UZDhnxkSeHBaO3XkoDw+xOBJWq6odV3WZzJwCK0uaKtyoXsPwXB8g3zS9SQrRwBq/0rSaS+KS3iKZQDWqi0GKcVj2PWfGueULvJqifY9oDntGE6ODfvyLwDTrlwrug+yhZoqFW41tX637hNo1rm73a3IvtIFTAEr40rx5//Eai+85gTyNzK7jl7FXaU5PMlmE0N7yD2BuJGKa1RuIGlrNBWUG80/zj5DWAgIWG2kgSSXUOSf9r2AEQ4I5tMRY8pm15FVPUFBVt9cy37lUfD/GLQjdn+KWnjLfv/vJxqmZEDOmrlFMgoOJfc53p35XsJlSjXEB2YWo3smNHeY/QjC1A/1/1H0OOXjNVt+2T6ERORfpbKAzMCSamyZU7K1qyfLCQjaym6n//pmedQh3VHlWDywyb0OfFXSzkVuB7pR617rwWUmgNAkBLlyCDHWI7N2oJgqECTQJAQnvyBAJUuyOBesLBun7xHLWDtJJza1NxunhW2y5Jy4aJ3C/nJ8mGdsFuCm+sW1Kac9NkG9dUl39aYOJ3mIXwtnwaXb6+Pdww==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(346002)(136003)(396003)(366004)(376002)(186003)(38100700001)(956004)(2616005)(6512007)(16526019)(66946007)(66476007)(66556008)(1076003)(316002)(8936002)(110136005)(478600001)(36756003)(83380400001)(5660300002)(44832011)(2906002)(52116002)(6486002)(26005)(8676002)(86362001)(4326008)(6506007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?zfhbI7ApMcT0sI4DHwI2s3vLGbHI1drVliuWJfqOgi5efpkhCL78LrMLTB0T?=
 =?us-ascii?Q?NTffgNqOm2HVEztCYYqDxE1Cf+KnC3PhK7AvtMt4O+9DLBTDflT8QIvHJA0i?=
 =?us-ascii?Q?70GScjnTEPIWRsvkl9rz74V0KTv9wRyWud7glryM/I6KIIAJjz2mjPZ++rel?=
 =?us-ascii?Q?imEK8RmwZ434re9lj5a1FtZJ7I7nqr/rgo3WcVWTTQRDTvSRsl4ziuBL2JGu?=
 =?us-ascii?Q?1v719dYlsY4cZiYVBnd4SGC8xXbYcZnPhxBuEN9emXSYQvhZSxOXcBoxCwVC?=
 =?us-ascii?Q?RVrqzW3hzpe24fwK+YSo8PmaEwIhsfJ0LHRSIMe4Wr9AliOVX/4ZGASHKzbC?=
 =?us-ascii?Q?OySoVd5717TzdU2nAD2MthUJIWCtP7XvF7db01/ubm6IiYbI4UfU6W+Y/YM9?=
 =?us-ascii?Q?pVZFsnX1UR8EI/QQ64dB1IpNnIAnmvCKUKZhTyyc2AWSlJdmU8DeKub3+cHO?=
 =?us-ascii?Q?f1L80j9r31f0N3Wwfj7LzI08lOW50dCy9KR36rj1Vb2Q+QyGXb9B5KZft49q?=
 =?us-ascii?Q?X7UzTUcR0Kr/BimmaLQtUNQiNuLBulvI6T9edmS6gfSdQlrz6jUyi1qZnkXS?=
 =?us-ascii?Q?zNRIs8WKgaHhEXyAwpDVqco0dJ0k0M5qcBwduIfqducWEG+aH6uXWIR1R2Le?=
 =?us-ascii?Q?n9eTYxmj1xoUBHD+Ffr5i+S6ohIsR494G9CMB9UA6AMLdCmh4wIeG6i5jyAq?=
 =?us-ascii?Q?LPyyVK/pFJ8JKqnY+QV/JxgmtgaQJH3RcovmyFm4TxID5lspGYk32kjAbDUM?=
 =?us-ascii?Q?h3WjpXeQva4iPsu0eo2Jldma5I379ojg1C+PucMzxqF04HHIC+Y3whUv/Mnm?=
 =?us-ascii?Q?iTHYplVKQDTX3RlJsoirEQfGPMFcfAGqPYQNors9RFQ0etk8Y+KBNhiEPbWw?=
 =?us-ascii?Q?58V+7x8BG+ZA+ILY0AjRT9R26ppCJfhLoN0/X5ZVNiUWrSLkuz41rMjGvOc7?=
 =?us-ascii?Q?H9SfMQr4r3GBMg7C2jiHvCQwZewny20z/GSOaKs9WhDRWu7JBH7I1Y64HpgS?=
 =?us-ascii?Q?4Lu1wzOHbA2r65DwgFgttBrnll6lnvaycW9pII5/KAD71phqQmpAicF7tyLa?=
 =?us-ascii?Q?x8TAnmNN5UlHX2BpK01q6Yn+vFPsfCgRLSfUo7k7/wfrDLcprHLpEWP9QLzv?=
 =?us-ascii?Q?zXmFFE7em74LlTQgLuJt4Bkdl4GZbUpQpTgfqbH19ahTc38AoZ5mHuloYaI6?=
 =?us-ascii?Q?iEq9fvvcGePSzjeKH5oZ0752KoSniQWvyvGbbfS/oJieg+yzsoeUi3OC2RjC?=
 =?us-ascii?Q?A+ibrssszO/xEb+1Q19KqPHS+ofS+0bhZg9zVisgstMxlslEq/S50cSpmMyi?=
 =?us-ascii?Q?51clNTYcTxRNjNN+7BPfoC0U?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f42422a-ddf3-483b-f562-08d8f5fb0c49
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 17:16:26.6188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CDdDrlL+r4Xm06kI3ZAxITtPXxkf/dlWHqscz0T4m3TQPn90D/NeNpjC4r1zhvHciKvccJid1iIB+s/k0pPh8WcqLlft8k9wht38HgJuZZo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3532
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

As per the comment in the file itself, we have to explicitly disable
(pre)mirror support for both kernel repositories, or else the fetcher
will unhelpfully volunteer to wget gigs of what amounts to largely
useless content that we don't want.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 meta/recipes-kernel/linux/linux-yocto.inc | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/meta/recipes-kernel/linux/linux-yocto.inc b/meta/recipes-kerne=
l/linux/linux-yocto.inc
index a85280990b43..5ec1b1ba7023 100644
--- a/meta/recipes-kernel/linux/linux-yocto.inc
+++ b/meta/recipes-kernel/linux/linux-yocto.inc
@@ -56,3 +56,13 @@ do_install_append(){
=20
 # enable kernel-sample for oeqa/runtime/cases's ksample.py test
 KERNEL_FEATURES_append_qemuall=3D" features/kernel-sample/kernel-sample.sc=
c"
+
+# For linux-yocto-dev, the existing v3.17 based premirror tarball is of no
+# value, and for the non-dev variants, we don't want to be going off and
+# w-getting the 3+ gigabyte (!!!) mirror tarball either, when we've got
+# a shared v5.10 repository already.  We can delete this in the future onc=
e
+# these old tarballs are gone.  But really we may never bother to mirror
+# either of them ever again, since they are (a) now small, and (b) leaf
+# nodes at the end of the chain where the content is regularly changing.
+PREMIRRORS =3D ""
+MIRRORS =3D ""
--=20
2.25.1

