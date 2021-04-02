Received: from NAM12-MW2-obe.outbound.protection.outlook.com (NAM12-MW2-obe.outbound.protection.outlook.com [])
 by mx.groups.io with SMTP id smtpd.web08.19601.1617383778008536618
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Apr 2021 10:16:20 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@windriversystems.onmicrosoft.com header.s=selector2-windriversystems-onmicrosoft-com header.b=EEHfp+Ld;
 spf=softfail (domain: windriver.com, ip: <nil>, mailfrom: paul.gortmaker@windriver.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G00mxF2ehK0zaMt4Rrp9wFz56/nDjThXRyjkZPmi6o7iwZ8ah+5edLIwAFjG1G1HkAvMf+/FVwW0wjsQTuc3BT/rWwfDymjEc9+ROtZl4qMS/oSb2zSnPNMU3Th3CYB3wCbpdD9YnuWyrU2NaeqPX3C/kHe+0OK6bLFbna4iUTdPFnEpVDLh2DFGL7cmVk2/VefNhYFyhjSGxISkhedi3R3/zEkuGUZqRX+gbNyJBOnxlzM2kYKqDnPrtf2J0Ti4njUQssij81q/pBC0hxMZcnXrz0TlB8ClMPRxlbAkQIx/tBMGfWcxNlrLgMcKzxa44WNpFA+Cw3pj03gt1VUrQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtQw3eOrDvoGfocvFnRJJ7iGX7vc/ogznKOJBv1jaxw=;
 b=cqdzBLnyxbxuivffLaIfpZ7+ZLEx4BSy6SSw9GfpUcMsMEHaiPkPmRnmIL/uUWRruUIgoqYM7Pwu2cIZ0zb15dVsH3S8pxxbb/NDZWn7+BEOvVJgrZ+tVh7+nm+5c59+hfObQjS9cAuYtDZ957abWvaY6WIufdoy2RNKjLyv/Pj3VZJysGUQJj27yOB6rr9cReWFGwN9Rw2YX5Q2I29Q98xKxHrfnzfa0Z8wpeaxAi9diLBnG1Cnb9zMMEjmtqKLgZMdkebYn4IAQ/1utlWo5WAdIeqqn9Ih3n53QNiKZINrDkuu93KddUrmXJOCTys/5VahQRTV4wevGCgXTz8nNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtQw3eOrDvoGfocvFnRJJ7iGX7vc/ogznKOJBv1jaxw=;
 b=EEHfp+LdKDTbUIUbipL/e/rlvNOEL8Yd75BwE4GJv8qITzFnnAFCMCn+3ScFDIwZvamGF3QdG5O5io1RIw9lIqE5Iutxdvm0nUnD5qHgFLYwYE/OiKA4y3yM+BXTyhfO2pm5afokN2kwiuZW/5PvgMtNpuS4dEqq2ktY2CsUJQI=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM5PR1101MB2249.namprd11.prod.outlook.com (2603:10b6:4:5a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Fri, 2 Apr
 2021 17:16:19 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::3d20:ed37:cfec:4ad3]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::3d20:ed37:cfec:4ad3%7]) with mapi id 15.20.3999.029; Fri, 2 Apr 2021
 17:16:19 +0000
From: "Paul Gortmaker" <paul.gortmaker@windriver.com>
To: Bruce Ashfield <bruce.ashfield@gmail.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
CC: linux-yocto@lists.yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Subject: [PATCH 10/21] kernel: add basic boilerplate for fetch-only recipes
Date: Fri,  2 Apr 2021 13:15:46 -0400
Message-ID: <20210402171557.981599-11-paul.gortmaker@windriver.com>
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
Received: from yow-cube1.wrs.com (128.224.252.2) by MN2PR16CA0026.namprd16.prod.outlook.com (2603:10b6:208:134::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Fri, 2 Apr 2021 17:16:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a358c38-0385-43e3-46a5-08d8f5fb07a9
X-MS-TrafficTypeDiagnostic: DM5PR1101MB2249:
X-Microsoft-Antispam-PRVS: 
	<DM5PR1101MB22494855A6AD2E0721EA907E837A9@DM5PR1101MB2249.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HYoYtLuGznGzWIMZrvOW088PbMdb3ZG/jZx1GzEdI7fpAg9qN8WQcX69vWK74g1wBQVr/a9+G6WM1xYu1zRikCNF9Jme8ol836LoQ9W3wVpt4aUpzkLfa103m3AWn8hjWfDuKF8jLYKXOktLZlKPFFjnADPpqBCpEBRKtDunw+w63ExXOeGu0PSAqYgoafPaqs9uXqPbdgb1jhaP5Qh72eS++g8Bk6c4P0YBJpw85ntHQxROwTvIOFXUUYOikRiQk5d4gBlRuJn6IgztOLBu4RH1kFjM5vZ52gSTDBLYxnHMgI4ixi2iBP9wh8ZR6NQ3NuOecsa6svTzNduTeQeX4badON1rvihq1ym60CB13Q4BzWf5NAXrhtbwkRoPFsmzmfvLABvs3BWL3dPXlptnoCQngZ91+PJ7txArlJrU2hVlLwdyvPsRkP2+gQLb5TP1CytayUv60mDjAfYbzBtF7M13uS3wwppT2xNwbiMod1KZIvxlJ0sM8Kv39etamhb2WX9WSw8jJdhU6gSV7K+2zFRwXjJjl0DLrf1bQNLo5xcU60Ycng3MGJUUlx8o7s9eGLG3S6Xpkm0BGlEMY7rLKF+rSJHT7nztXivs4qORbN1jel7LNWha4sgp9mMoOw5ebP5NjnzE68qFU5vXEu4oOQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(366004)(346002)(136003)(376002)(5660300002)(83380400001)(478600001)(44832011)(6506007)(6512007)(66556008)(66476007)(6666004)(8936002)(36756003)(52116002)(1076003)(956004)(86362001)(2616005)(66946007)(38100700001)(8676002)(316002)(110136005)(6486002)(4326008)(16526019)(186003)(26005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?xRC8Qja5q0pJQc5gagus/RtXvCxcnTYMpL4nrufHCY1OISEd1J6v7T90q3zp?=
 =?us-ascii?Q?fx2X/bvuDlKyMGyCdubmFFtaqhEIyXH7fpfIWMM2wrk0TJIyxS5ulyVOgoHE?=
 =?us-ascii?Q?IND463P2wANjYcP4IcGX5APi/JJvxvN69+PRtGF1+IAMZalUnXg2kQjPdX5o?=
 =?us-ascii?Q?150QAINPMltyVNt9RCf5o5YU652brjdkc4K7HGREV36YYYyEwejes5L+2Tng?=
 =?us-ascii?Q?+hIam+Ct9neJuj4zyLD+KR1KxTKeJJSWqSYs5ocF5VIKq4GcSMjvmLZXjWVp?=
 =?us-ascii?Q?WgsYeopMI6H/DSozmSnUkr37FpSsV/5uBROO9IHtQyHw/qRkvHfGqrRZGeSK?=
 =?us-ascii?Q?kqwn7Q1ZZXD9kT/FFVgFRJoMBsrdxrJjqOd27whhlBfWvFMhVUoDBg+6Y0pp?=
 =?us-ascii?Q?jdvLd9qlmoYdhcAxsmXxJ9zAKmhEOQk2PbWtmbo1oIrTosAa42SiVw0eKKMP?=
 =?us-ascii?Q?iP1X3PWo2GRTjdnNNjZGLfAdE2WlY5EdRvuBXOVPM878KjkAhk03SxxWR2cL?=
 =?us-ascii?Q?9hObm9mH4O36OjRVP/Vbn+70qS57vrRUn07x5yTRPnvCwLk7wnJS1Vp7i6fb?=
 =?us-ascii?Q?D+ccjtZwHg3X828tPZpzqM51qqlVR44C0EHVLSMPjKO1fZR94ekqeiZpD4vj?=
 =?us-ascii?Q?m2lddhGPjQ2Hrnw7JrxzbmGCO8RuVmIq6815Y4ZUVFtXrUa63pf6gXAeqgHT?=
 =?us-ascii?Q?cElJ7K5lBbs0AHVinTSEi5yyFMoklzpMcdX/s1NX+7V91Vrlo2c2qPOpyLeP?=
 =?us-ascii?Q?GhWno/2shEu1D/ph/v4xSk34S1g+kvI0MpuFJJ4ZRO7xrbxdYWRqfZh6vYOd?=
 =?us-ascii?Q?xj6PrTQ2Mw/W7z6ZpWdGBdygLtZTDABrPQVgwZ2Sj0AejbqWUW7eJY1/0PWm?=
 =?us-ascii?Q?jw3r/vxTD/1x84lPHGiQiEFYvi+P3oRi4rOSpSllndDs89K31omiE3qVFlPn?=
 =?us-ascii?Q?c3KXPFP3tU4vLF97HwgurTCVNvc1HuYV1VKXHLkDHOF6ZK509r+NPilS8RlI?=
 =?us-ascii?Q?/916k11t7YxLn7d9v30Dn4q4dFzBBiG9m7t2VcUrOgbSb70hsEVzMoQq+hf2?=
 =?us-ascii?Q?B4lOsAjDefPBizYcv8UpSp/0gQpfT+r8TCW+1xecVTYhVrHVV/qLOMTOfk5F?=
 =?us-ascii?Q?/DDDJo94wri2vVYTS+5FEhU8YbOlD9Zlcp8tse7LspgoNNDkbWX7kMgD/CjQ?=
 =?us-ascii?Q?/5qYtaQvO9exkzcRm96KjuuN0rJaK4MKqseosGQfpVW3VgYeesPkSV+E0OOC?=
 =?us-ascii?Q?0KhqQs6xWtJRcYPojOlnRr5SrxG0i4ihrdmXu0VBjrai4NHkQH13h8NJuh3O?=
 =?us-ascii?Q?VaK9jUTGVzg0B2MPUhw4fda9?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a358c38-0385-43e3-46a5-08d8f5fb07a9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 17:16:18.8673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AOHww1BXTN2hmhOxkEQfd/US6TCFqbtDnPgXnj2eL3mhZboo8aIQNgnR8Z3Ltqvt1NNOLWmOVlvSDmr27NWD4bmDyV+zCRUs/MLy7+TrnUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2249
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

With changes to the fetcher, we now have what we need to download
kernel sources in a way that is forward thinking for sharing and
growth and EOL of components.  This will be achieved by "fetch-only"
recipes that only exist to populate chunks of this "library" of source.

We may wish to reconsider locating 99% of this elsewhere, if use cases
outside the kernel eventually arise.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 meta/recipes-kernel/linux/fetch-only.inc | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 meta/recipes-kernel/linux/fetch-only.inc

diff --git a/meta/recipes-kernel/linux/fetch-only.inc b/meta/recipes-kernel=
/linux/fetch-only.inc
new file mode 100644
index 000000000000..3333eef50713
--- /dev/null
+++ b/meta/recipes-kernel/linux/fetch-only.inc
@@ -0,0 +1,20 @@
+# There's nothing to do here, except fetch
+
+do_unpack[noexec] =3D "1"
+do_patch[noexec] =3D "1"
+do_configure[noexec] =3D "1"
+do_compile[noexec] =3D "1"
+do_install[noexec] =3D "1"
+
+inherit nopackages allarch meta
+
+deltask do_deploy_source_date_epoch
+deltask do_prepare_recipe_sysroot
+deltask do_populate_sysroot
+deltask do_populate_lic
+deltask do_rm_work
+
+EXCLUDE_FROM_WORLD =3D "1"
+KORG_SERVER ?=3D "git.kernel.org"
+KORG_PATH ?=3D "/pub/scm/linux/kernel/git"
+KORG_URLBASE ?=3D "git://${KORG_SERVER}${KORG_PATH}"
--=20
2.25.1

