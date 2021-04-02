Received: from NAM12-MW2-obe.outbound.protection.outlook.com (NAM12-MW2-obe.outbound.protection.outlook.com [])
 by mx.groups.io with SMTP id smtpd.web08.19601.1617383778008536618
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Apr 2021 10:16:18 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@windriversystems.onmicrosoft.com header.s=selector2-windriversystems-onmicrosoft-com header.b=QESwnzr6;
 spf=softfail (domain: windriver.com, ip: <nil>, mailfrom: paul.gortmaker@windriver.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arfjJIuI9CNxUgrd3mlg6SVXCTCOBgU+kd+YmRNK05RjP4/xuE70cqsHKwkNWx4N94I2dG4Q58+2g60i6aA+bEISqiALYACPazo5tbO8SnOcRIyK79fC7trFQ5vL2RcFR/hQpQme50Fxi+XE7JnM9EbqGWwyPVJ9y5aiZ9nSkBy1qPz6al02h00L9avs3lS4ZlDqL0Z6C0p8jX9qLAcrb6hl+PIjjlpnZWqwryBOg1DeXs5ylBQ+0mQsOqc60tGn9oq/iNMpRrYX9hSlo7WSYSq4D3y2v+ZRrl1zsCigDmQbywcHpMN9JxboLUPYnkXPbHTtfgLJoadeYz+KCULSig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/hYe/q4Vavrk6WVhmP76kQwBXS272u5FgE3DpOt9DA=;
 b=FJN0TdVQnhj4t4oOuhtTqF0i0GMVCZ7p1OhEJVsZjieQe5Tc782aKEfagoxs31w9BTYJ4UohZDwACkgkfYKyLcnwGpfneOeu6FamimdEM8E+irnkmT2P9tL4NlQ++WKPdbVgHmih5/BaPQIoQJNAnVNqH00Mz9CYH3fB6k60XqYERJBYpNramo8jvvpDE79kes7j8ZzV1ylFvs0pIWxqP0UGY+9M9rNh3K5LZNtDdSuySsAkZbJPdj35sJGsOqGo/+AdHfRIHnWRNG/B3wis1oBJpPRgZo+4ym/VczwmTGNJw1qDnE77DTV5HvjCTtNc65l4T7JoU+5EbCkFAMHBxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/hYe/q4Vavrk6WVhmP76kQwBXS272u5FgE3DpOt9DA=;
 b=QESwnzr6eYaECsklOX7UmxKjhgPnQYeUYj0BWHFYtLGDkiB8mgsbrJ/0cudoIpBcN2m0XMMw7WFkqjFMfS+66zZ6PfCmZkuXdKF9ZTT4zyIzxoztUdAdnilFAWMUc+yTVZ3isEs/RlX6vtE4ye8ZPPodT2PeMYVJNBeY/ryyeeU=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM5PR1101MB2249.namprd11.prod.outlook.com (2603:10b6:4:5a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Fri, 2 Apr
 2021 17:16:17 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::3d20:ed37:cfec:4ad3]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::3d20:ed37:cfec:4ad3%7]) with mapi id 15.20.3999.029; Fri, 2 Apr 2021
 17:16:17 +0000
From: "Paul Gortmaker" <paul.gortmaker@windriver.com>
To: Bruce Ashfield <bruce.ashfield@gmail.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
CC: linux-yocto@lists.yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Subject: [PATCH 07/21] bitbake: fetch2/git: append new altref line if/when SRC_URI changed value
Date: Fri,  2 Apr 2021 13:15:43 -0400
Message-ID: <20210402171557.981599-8-paul.gortmaker@windriver.com>
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
Received: from yow-cube1.wrs.com (128.224.252.2) by MN2PR16CA0026.namprd16.prod.outlook.com (2603:10b6:208:134::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Fri, 2 Apr 2021 17:16:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e728fd33-f544-4ba3-5be8-08d8f5fb0685
X-MS-TrafficTypeDiagnostic: DM5PR1101MB2249:
X-Microsoft-Antispam-PRVS: 
	<DM5PR1101MB2249FDEDFC9A884F43FE7E6F837A9@DM5PR1101MB2249.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	kXDmMoRAwoGoiygkB55o1eQly7+SQ2CluxLQNfDtNs+nWw9XxFJK8wW9sN6iQbUVSQegF7NhzNUu8koCUZrIcwDjVOrSvXk4NtFor431Aa7Iczvfut1X207yr+nLTkSMbyRSadWHFjdB7UP3zIlsrsXx7kmFZg4imrrJdFjyfQnCJ1w1UrgZ3a6p+fGeRXzpjBQt48voyqPWy0wVBR4rlGxkltsPiTx/5yVd50cJQjN3Td+3sM+cJ42Q6yOi443Zw/bsBJ4TEH+mTVFPIZVoFsvi9hOWq3wpjvPVn8iZrC41jtBw9AJoT22uo+Jqi/6yAifd7dj67uZoDIog7ma04S4nFIEdrKPPLRAqrHrajUI0tNkIjjwWUmD1CtbMFEvhCR3ueb93XLq3wcEmARz/4NtqzQjcSYtqmxoKi/yPAMxcPdqsA67hNKNZnbL8uTztOpc787ESOeg/NB9rKtdO+clP43GKPTASyW5gc7QMnHtqTEEFTGQdzdCiexfBCwaqq83DAW7mdzWmK7iBew63T1ZCo1JJHyW+dBeAz9r/rWET6VYi1eqjPhZpZ9508hPO4Es0cH1yAWeASuNRVyjEdqsK+vRxKvTproPy2HKWKKiecQEjBr6pG/5hs7WItFCyKkHU9yecyFzqIlR6eLdl9Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(396003)(366004)(39850400004)(316002)(110136005)(6486002)(66946007)(38100700001)(8676002)(86362001)(956004)(2616005)(16526019)(186003)(26005)(2906002)(4326008)(44832011)(6506007)(5660300002)(478600001)(83380400001)(36756003)(52116002)(1076003)(66476007)(66556008)(6512007)(8936002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?aakul6nv9ybjLRw68fnXvzj2vDhfwMYqS/H8UOgQZ3K0yq7F/kkZKEtppdXo?=
 =?us-ascii?Q?tskZ0f6/HnbKYoDFd2vfXiFSB0fDe20MP5hhm/pWXp5CVjpv87f++Z0ypWRG?=
 =?us-ascii?Q?oCpaJm6UOmfzFgWxU181puff3L1vHGFwajmvdBfvIiVtlggWmKQpOzKRG5tA?=
 =?us-ascii?Q?T+TX66cdeil0diDVuKQF53YY+w38gRL2umbLt1XYX4OIbW0HbRkBu9XY2gP9?=
 =?us-ascii?Q?Vez8H1ikWA51GlIM3beqsH44ECe1RIKsxrc/Jx+U+BEJjzIQ01tZW3ONIGvd?=
 =?us-ascii?Q?H1rcl7gIju/jrKbkez+txoaz/xqNFuvGCWXKmGZHoX4AgcJFCoobo5s+RNIy?=
 =?us-ascii?Q?bgWu2fOpXS7egOlxSUtSRl46AADwll+PJZFTfVH/1OBYm5L7IKOCAuhzg2u4?=
 =?us-ascii?Q?vJ5CvqibKRcMf579a95a/Y4BXef+VzkuYEeGuuNHiG8kYqWzwmhr6NcKZXBg?=
 =?us-ascii?Q?bE3LfvCU3txEUtojNVJgcLBO2N1tX2y/ClC6U6oSiWXFbmexw4kiR+k98AR/?=
 =?us-ascii?Q?Y9Pz9byWojscd7A0uQzxgblv0OGr0xFRpdra9IwL85R7/XM3zlVx6UP0NMNt?=
 =?us-ascii?Q?PaXyGw8DSibmx0mhk95bIR+tl3K7Ivx8p+Hm67NzEW/s4LX8tiWBtetQEeFQ?=
 =?us-ascii?Q?GFdvAs19v+EpWe+yhevExs22znfLVJkilTYv6lOyGuZ9Q6kTI3zp3XhmAaC+?=
 =?us-ascii?Q?pYjfkfDuwaPfuOIxfNxYckIJQS+mk3OJRMo8uKubUYZsa4oZzRCouug3aw2M?=
 =?us-ascii?Q?raMFQD6Sr1beUspCZpxqm7BKRcuVLWkQ+Vouuk7JI7Wqvbfk7LnimoA2voEm?=
 =?us-ascii?Q?37n0dYG4y7zc82W+bDqoFPJ+MJax6r/O+TjlBqP2L5zxoZS9QUlK8t3odVFc?=
 =?us-ascii?Q?GWIdj46jstr4SKqC3W+s/EVxHu9bGDHUegR6BokFtfr+7JSJyOX7LM+4rDci?=
 =?us-ascii?Q?6av6DY4/QNdCWxvvAiX4kL1df5TMbxx7i2CBO+wgl20lo4wnm0s1sKrYBn0r?=
 =?us-ascii?Q?nR1NxlurMv1NUbUMs/uOIO2sgNuFzOAqhJG4eDQ5fhAozwy+NGNF/J5nw6R3?=
 =?us-ascii?Q?0xtpFyVGGe26Dy/AnLuqz3cGIuBGNirxUWWf7mENyxGIRidWa/1pYx6MI87b?=
 =?us-ascii?Q?WTvmGA1hSY3rBb1Hps0VyNgXmwBrqQlMGSuaqmmjWBZzE2VCFeo93k7N8+ef?=
 =?us-ascii?Q?Yfnm//jcJc/3vZW4G8/4b3U0RDxPutsg6kw0+Ew7yfW3Aq1OEfP0XRpzOnOL?=
 =?us-ascii?Q?YK+JxyERRhbfmVmqiimutiaxiNL+zxAbgA/RRRy/SP7yiV8IgBL80TE3rXb8?=
 =?us-ascii?Q?zp9gS6jhPh2YlZGmMimRfod1?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e728fd33-f544-4ba3-5be8-08d8f5fb0685
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 17:16:16.9184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qGqptn1MUB7AM8lHjdHFUzYj2XTBxrF8P4U0p2eMURU57aAYLMTQbirn7BlDDnFAiHdv1yPSltNsNuNdp6CybW319tagRYNM8jF7quIVR04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2249
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

A new repository that is cloned with "--reference" in turn creates an
objects/info/alternates file in the new repo containing the path back to
the reference repo objects.  This is normally a "one-and-done" type
operation and the reference never changes.

However we can envision where a package leaves behind a dead end
"stable" fork and re-aligns itself with the main branch, or a newer
stable fork.  In the case of kernel, a real world example would be
leaving behind v5.4.x in favour of v5.10.x for a baseline.

This commit is a consideration for those users - with an existing copy
in their downloads dir that is using a reference that has since been
updated in the SRC_URI of the package recipe.

If we removed the old reference and replaced it, we would break any old
build directories that had branches based on v5.4.x specific commits, so
that is clearly not an option.

If we simply did nothing, things would still work just fine for them;
any v5.10.x objects not found in the v5.4.x reference would be simply
obtained automatically from the server during a fetch update, and placed
in the endpoint repo that is using the older v5.4.x as a reference.

However, since alternates supports a multi-line format, we can simply
append the new reference.  This leaves any v5.4.x build "consumers"
functioning as-is, and also gives a path back to v5.10.x objects in the
new reference, so they need not be duplicated over into the endpoint repo.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 bitbake/lib/bb/fetch2/git.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index e742010229c3..3b0c068bc020 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -421,6 +421,15 @@ class Git(FetchMethod):
=20
         # Update the checkout if needed
         if self.clonedir_need_update(ud, d):
+            if ud.altref:
+                # if altref changed in SRC_URI then append new value.
+                alts =3D os.path.join(ud.clonedir, 'objects', 'info', 'alt=
ernates')
+                try:
+                    runfetchcmd("grep -q %s %s" % (ud.altref, alts), d, qu=
iet=3DTrue, workdir=3Dud.clonedir)
+                except (bb.fetch2.FetchError,ValueError):
+                    with open(alts, "a") as f:
+                        f.write("../../%s/objects\n" % ud.altref)
+
             output =3D runfetchcmd("%s remote" % ud.basecmd, d, quiet=3DTr=
ue, workdir=3Dud.clonedir)
             if "origin" in output:
               runfetchcmd("%s remote rm origin" % ud.basecmd, d, workdir=
=3Dud.clonedir)
--=20
2.25.1

