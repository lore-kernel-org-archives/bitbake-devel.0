Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35338C021A2
	for <webhook@archiver.kernel.org>; Wed,  5 Feb 2025 07:16:06 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.110])
 by mx.groups.io with SMTP id smtpd.web11.6855.1738739758488645702
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Feb 2025 23:16:00 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=CDp5xIb3;
 spf=pass (domain: weidmueller.com, ip: 40.107.20.110, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I3A8MJKapw/lto7VGg4ziUXxDGP/l+VWRJR/LK4gwlTfCK3J9252fPI81eK35vhmeeBaAg4SOYmSp9VKhqjh09NbMmNN2vkOljFo9r2R9WrCJTmpCHkVlZLCP08T1mAitoQT1RcAbovjlCRsoQMkEqpv66b0LzD35SJXlmilZlcsWn1krJUr7HCdhY5PQdhiqx4Zg2QY0yNMVpMR8sqq8C+tQHzlLyZqhwHhlCO8GPHt3N965yw/xd3bR6e8inwBGxOvRHwk2fz5iJsepFCpbMoUZrFuKtjiW3r0g2BYy36qwMHIVOHCwzuN9W1CuiL3SS9u0T7k/ZivTA8028ZPVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lVVVjpLt4W01U6YoJXbAaY3WJIDXfcKBbwkXSyPOf8=;
 b=jTHmtTyYvNUT8JO5MCpCIxD+3B3CgQqJqubFl8rQtZl5Ou63Kweo+ISnvGnQT15lXV9Ycrzgx6RmSh+PP3TlWlj1ARM+Ca5X0PAiDStsIcjcON2VOeaXTjtoGpLmCeFSM5fH+2dqGGRz2j40e0sGAOiAk99Tm8DVryP2JcAPLGbxH3zBvYEsr47m42dGO7VewjAmZWdMCOjD4rj8biDdh7FDmJzVOstNZzPmD7lQn5dJpR9zpoSAPqtST6yoK00kBYhkO4tJ8ZvGb99ceNC4tLnYvHzCkL2Uyn6EE4pZWeie97PuNyQ0p4dsKDixuCqgYOGKEFCRl1KLIMNueZCyFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lVVVjpLt4W01U6YoJXbAaY3WJIDXfcKBbwkXSyPOf8=;
 b=CDp5xIb3ekP4OzlH2rq0JvhRV0bDxWV15DY8jz/NKtiXU+WOmPz8YmnXPRuwaLxm3jBhV95LYJSKuJ9WynBTIgFII0TUAhSomZdQgHHGx+W4g8I58c/uWup1pv+fF5uQ6bAhYzAqjnjRDCNEHwYM9QRueXWrpsmQxQ3ZpY8hf+EKlQOxnAvBQA+kqj3aaKmIE5DXEDkBWBoVv42/7wDVcwcqXiEKKkFGsJQ2D5GyI0XDFIvWDwWwIT8PfS+btzFfY3GkTrtMW9mQOiwzB6c2ZN+royoXBVscGnzR4EwHlKGIPa9ohNK8shg3rwH82UioaI6eUTfqg2w3vrycw0bRXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by PAXPR08MB7320.eurprd08.prod.outlook.com (2603:10a6:102:223::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 07:15:50 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8422.011; Wed, 5 Feb 2025
 07:15:50 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH 01/15] fetch2: remove unnecessary expand function calls
Date: Wed,  5 Feb 2025 08:15:24 +0100
Message-ID: <20250205071538.2681-2-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250205071538.2681-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250205071538.2681-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::6) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|PAXPR08MB7320:EE_
X-MS-Office365-Filtering-Correlation-Id: 483dcbc0-d042-4112-20ed-08dd45b4eb44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?TsvZAtavBlcMsykPQmttiKGHiZBNj72Ulg9z+hZ/1jeu/gzpLGmPFIetWI7L?=
 =?us-ascii?Q?vrtmAehhijKXqXbk2MRHCmxu7i8l6JMFnvMpPS4z/KovimfOthmJ3QmIGs3h?=
 =?us-ascii?Q?T4hTey5v4jLRBpbSY5tBXawsoB0jlzl9WwAerZD87wNl83JsctpNPzxeG19q?=
 =?us-ascii?Q?TDmYqrNn6QQHWJXnx/zdLHzSc817vIDsoc4N5JwykNi5rbxJ11S9mMHmPA2e?=
 =?us-ascii?Q?ppEgWEuXUjviI/x6v4ESyjqIcUHGsM+FxRo6bWSS5InGhpsEIisX0QHaClRJ?=
 =?us-ascii?Q?2zJb7yH7iWghh8E8ZAe1Sq0sgPmcihqNG7eY+VaI6u8zPausILW+cta/bQZf?=
 =?us-ascii?Q?0gjW/CWt3B30rEBcVNoXIia8livmL0UQuamt50e4rRdc0oDpmroBXIbE8KU2?=
 =?us-ascii?Q?xNKDf/1Fd0sS/MKK/8GCLNzUIsOthGoE0+Kcs78V/v5QVeowtDFAzrFRPdSK?=
 =?us-ascii?Q?UcEfCz8sNqk23vq7SXCTyhOmKbx1W8LyfPOg9GGZKZSM1oIBfgF8OmICELLQ?=
 =?us-ascii?Q?wJCrDjwkeixPQd0hi1RbHas0hXlxqxqzVFuQsCz+3QekI6u84DIBruFbB8cF?=
 =?us-ascii?Q?elkhUYeUNib8UG3XDujuG8+ZAKQgZJaq1tX4RxZrczbKyBxhi21Qav6NB91M?=
 =?us-ascii?Q?wkfu6Iclb4eYqVt51TEajRZC1n+JC6ggXK7OUDS1ZWpb31PtYobVk0CjQTHq?=
 =?us-ascii?Q?H+a66D59bf3C5p28hc7ULNG0SDD8O4O6bDyJ3Q04xmvCJf/w7UkRf27TTv4l?=
 =?us-ascii?Q?wCPewmDh+hzW6svmn77LBCCGsLQzn8x0tabRDeCkZwjpz0yYcqRZHY03NFiw?=
 =?us-ascii?Q?gXkv2ll9tPj0/fThnRsebBDh+pqWSZhrbOePuLEJY00nQW1blL9q/Vzj9XiU?=
 =?us-ascii?Q?xOpleUNHZo360L7a3BxcyDdRHqTh8G2k7+7ZwnDlB18gnaSBZjk22b29lpji?=
 =?us-ascii?Q?K67xLi0ABVZsWMv2ltEkdj5FWCJm9dFmI0yLsac/BGUEwz12BCFfvWTuSrKV?=
 =?us-ascii?Q?50OSesC1IC5H0drTNsymzN2BXVGh26o9VkV1frRCxz0cnfFOX5C6w32GXknd?=
 =?us-ascii?Q?Ua4QP2rS9FNWx0sz1mcES1jMlOax00sqov3D/JS9pGFmjuaLY4PwjT1bL4Sr?=
 =?us-ascii?Q?dPyqHxD6gWtojTIXpGV+mZNk09ibGXcuiVEvMgfSV7Zecp2zP9wxEwwKbNJm?=
 =?us-ascii?Q?kwCaljD2kAx8uXyykobHa+CzWGe+qN1UrrTHoQ/VHYyyz7jNq+V8cwar/0dP?=
 =?us-ascii?Q?juNHap1EOpunXtfhX9jPD5lnEI8Zc/nozLn0B2lI2CW1rVwqgskqLxFMG7Bz?=
 =?us-ascii?Q?ha1/6lzlYL1fMEicaDymw1RTCJwD5OxonF6E8hYe/fSsz3SJkcCyxjiGHYpg?=
 =?us-ascii?Q?zlDvdEXgHVoBx2xlwCiLOGIVuqefa7YPJs5qvFg81fzHKffDXEr573urXCd2?=
 =?us-ascii?Q?3+pCy/EGFthqaLk57E+V7bO2lBna09dF?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?J5maRE2TM7fKdsQF2nz/F5goYHq5ApzOXt5CLOi3nmCE7P+y1OXfk/Tbmx4f?=
 =?us-ascii?Q?1FwyT6UI8HrJ3opR7ddLMYbZRLhOFIM3ueBSYYptn6y5/JMrQvDR2rvVKUDt?=
 =?us-ascii?Q?yVWFD1O07r7hJYGd7Bn85e89TKtXCgFDPV4ZmJTqt+iZpKJKWZOiInQ+7HL1?=
 =?us-ascii?Q?jobbu8XaTB7Pl3E/0OvLUeJjGkiepm8VpjKdDGFI8Pp1sqEyf9jHlGG4+nxP?=
 =?us-ascii?Q?zIfhA9LpGFwKBI2aCyB2kAXH+Ba27k4RU30zyvnKv+LTuzvk2nZvix6VJNp5?=
 =?us-ascii?Q?HOcJQFP+6hKVycexm60tLU6zEaoxRzLQNbdEEkmyS/lr7B64sIweiHLsnlf4?=
 =?us-ascii?Q?6IrrPDLvprHYKWtBluf4Pa/47drpHbpNUE3oZeBIbcmxDtt1hQ/NY6yQk84U?=
 =?us-ascii?Q?XCdfiTxdPjXr223JxSe29KRGPvZ75U5WEDeuragZ7qO2S9+DJo9ngF09iDup?=
 =?us-ascii?Q?VCm+UCBTFPXEJjLndE/wuJKNJ4KZXXuoFc6/79NrA3y82czLxiIgd2jIBXIR?=
 =?us-ascii?Q?UBG3Er96luZSeboTNswtzQgOZCgaIjyJLK/Mxjo/6yIoYB9LfAP78BELml/W?=
 =?us-ascii?Q?0FdYkkUjMl0Ugyr7YdYxiHsqYvgNCyt7KZ6wL3xr7pzQAPfV0it53GcBp0QW?=
 =?us-ascii?Q?6z0zqVbcKA+epTfw8ub+Wk/bpDXRKyYIID5mm7SF8OXtuFk0XrkH0FS4rLzX?=
 =?us-ascii?Q?SOzj4ePPKeT+ZuhgiiNVlgj7NH85p/7JivxWvznItW44hJD99nyrEGyD7pe2?=
 =?us-ascii?Q?bqBf58fWnlw8N/SXkshJgK4Dz1O45n1JqCuphxgra3odlrYPaZQEhRpTna3Y?=
 =?us-ascii?Q?Pt7duWoyboi0R96+R9Ca3mXhfQZvE8mLelOtYfrmDF2+AmZIVgC1spvTpZ+x?=
 =?us-ascii?Q?lMuVCNa5wm+n/W4aGGjAPQoeSOBCw84bvVl+n2//Z4XLm2hcH/jHcv9zkyxZ?=
 =?us-ascii?Q?N9Ag7Xw3ZNnfdjreSxK6dUT9jw/GNJHg0ldymeHmrhVIrT5WfX+TT01jNt+/?=
 =?us-ascii?Q?r92EsPFwDIuyOuoymF+F/NSVzAzs6BNJAkC4dbPK8xFPqGKSKt83rqTueFGq?=
 =?us-ascii?Q?Fj7WPFTrG0otHh6TtvAzeYpEca3lVZGe5TviU4YFDvDqQPd+RKVLQLi/oHFL?=
 =?us-ascii?Q?g+5p9ZRA+7nOo1G2nhKFsNUyTcvp+dUWbqFcSBanpg+EhqDEhZzqA9f6d9hi?=
 =?us-ascii?Q?8pq1ZnzE7HpbzemAd64zaM0qcuwMbK+MNV0lTMgiTGeZ/sdHQd6psKxkLDUx?=
 =?us-ascii?Q?pJt3+LCZBvzpabfQMF6n5TF6XEyO9G1bz+OKbD9rib4jngOUJt5M4NE5TCpv?=
 =?us-ascii?Q?FcD6rTJveWXarP5C+/xK33mGGYXXXWPYHYvaMawfVfXnFFsQoblXaUxaJnrf?=
 =?us-ascii?Q?7aufFH6MnYy6RY2Bxtuw6gEid/azi6Dp7GWeV3GRqLvwvr+9mVlnv3CcMKry?=
 =?us-ascii?Q?FoIpQaevvzOkBTBNKLrnVLRrSzTbCXUKQBm+6ZGfpHhFWieLfmXor5ab29td?=
 =?us-ascii?Q?1KekTqhaYOdz3T4lV4C5I5zCoLqNKPVLqRdfIDp9iZ6RyrZhPof4vNpM5CTB?=
 =?us-ascii?Q?IplZAz4C4Mpr+tXYD86U3uv5ZbdI66ODCRlixUR9r+JyLKZbM3Lf0+lZJ0Cp?=
 =?us-ascii?Q?Ag=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 483dcbc0-d042-4112-20ed-08dd45b4eb44
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 07:15:50.1659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mO0JmkHZs2fp6L2yZv+mZRg3je1FcTT6Wgq9fKkFInnIyoPxub/OuFGux7o0POtF7wDOMRD5zu2n0SS5rxzjAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7320
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Feb 2025 07:16:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17142

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

The fetch data class already expands the type, host, path, user, pswd
and parm variables. The fetcher classes already expand the localfile
variable. The getVar function expands the returned string per default.
Remove unnecessary expand function calls to simplify the code.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/__init__.py | 4 ++--
 lib/bb/fetch2/az.py       | 5 +++--
 lib/bb/fetch2/gcp.py      | 2 +-
 lib/bb/fetch2/npm.py      | 2 +-
 lib/bb/fetch2/s3.py       | 2 +-
 lib/bb/fetch2/sftp.py     | 2 +-
 lib/bb/fetch2/wget.py     | 4 ++--
 7 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index de36f06bf..c77155a1e 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1182,7 +1182,7 @@ def trusted_network(d, url):
     if bb.utils.to_boolean(d.getVar("BB_NO_NETWORK")):
         return True
=20
-    pkgname =3D d.expand(d.getVar('PN', False))
+    pkgname =3D d.getVar('PN')
     trusted_hosts =3D None
     if pkgname:
         trusted_hosts =3D d.getVarFlag('BB_ALLOWED_NETWORKS', pkgname, Fal=
se)
@@ -1817,7 +1817,7 @@ class Fetch(object):
             self.ud[url] =3D FetchData(url, self.d)
=20
         self.ud[url].setup_localpath(self.d)
-        return self.d.expand(self.ud[url].localpath)
+        return self.ud[url].localpath
=20
     def localpaths(self):
         """
diff --git a/lib/bb/fetch2/az.py b/lib/bb/fetch2/az.py
index 3ccc594c2..346124a8b 100644
--- a/lib/bb/fetch2/az.py
+++ b/lib/bb/fetch2/az.py
@@ -66,11 +66,12 @@ class Az(Wget):
         else:
             azuri =3D '%s%s%s' % ('https://', ud.host, ud.path)
=20
+        dldir =3D d.getVar("DL_DIR")
         if os.path.exists(ud.localpath):
             # file exists, but we didnt complete it.. trying again.
-            fetchcmd +=3D d.expand(" -c -P ${DL_DIR} '%s'" % azuri)
+            fetchcmd +=3D " -c -P %s '%s'" % (dldir, azuri)
         else:
-            fetchcmd +=3D d.expand(" -P ${DL_DIR} '%s'" % azuri)
+            fetchcmd +=3D " -P %s '%s'" % (dldir, azuri)
=20
         try:
             self._runwget(ud, d, fetchcmd, False)
diff --git a/lib/bb/fetch2/gcp.py b/lib/bb/fetch2/gcp.py
index 2ee9ed219..268267b7a 100644
--- a/lib/bb/fetch2/gcp.py
+++ b/lib/bb/fetch2/gcp.py
@@ -46,7 +46,7 @@ class GCP(FetchMethod):
         else:
             ud.basename =3D os.path.basename(ud.path)
=20
-        ud.localfile =3D d.expand(urllib.parse.unquote(ud.basename))
+        ud.localfile =3D urllib.parse.unquote(ud.basename)
=20
     def get_gcp_client(self):
         from google.cloud import storage
diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index ac76d64cd..c09f05044 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -166,7 +166,7 @@ class Npm(FetchMethod):
         # Using the 'downloadfilename' parameter as local filename
         # or the npm package name.
         if "downloadfilename" in ud.parm:
-            ud.localfile =3D npm_localfile(d.expand(ud.parm["downloadfilen=
ame"]))
+            ud.localfile =3D npm_localfile(ud.parm["downloadfilename"])
         else:
             ud.localfile =3D npm_localfile(ud.package, ud.version)
=20
diff --git a/lib/bb/fetch2/s3.py b/lib/bb/fetch2/s3.py
index 6b8ffd535..fa5292dfd 100644
--- a/lib/bb/fetch2/s3.py
+++ b/lib/bb/fetch2/s3.py
@@ -77,7 +77,7 @@ class S3(FetchMethod):
         else:
             ud.basename =3D os.path.basename(ud.path)
=20
-        ud.localfile =3D d.expand(urllib.parse.unquote(ud.basename))
+        ud.localfile =3D urllib.parse.unquote(ud.basename)
=20
         ud.basecmd =3D d.getVar("FETCHCMD_s3") or "/usr/bin/env aws s3"
=20
diff --git a/lib/bb/fetch2/sftp.py b/lib/bb/fetch2/sftp.py
index 7884cce94..45b6afb4a 100644
--- a/lib/bb/fetch2/sftp.py
+++ b/lib/bb/fetch2/sftp.py
@@ -77,7 +77,7 @@ class SFTP(FetchMethod):
         else:
             ud.basename =3D os.path.basename(ud.path)
=20
-        ud.localfile =3D d.expand(urllib.parse.unquote(ud.basename))
+        ud.localfile =3D urllib.parse.unquote(ud.basename)
=20
     def download(self, ud, d):
         """Fetch urls"""
diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 198426065..7066d5e2c 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -78,9 +78,9 @@ class Wget(FetchMethod):
         else:
             ud.basename =3D os.path.basename(ud.path)
=20
-        ud.localfile =3D d.expand(urllib.parse.unquote(ud.basename))
+        ud.localfile =3D urllib.parse.unquote(ud.basename)
         if not ud.localfile:
-            ud.localfile =3D d.expand(urllib.parse.unquote(ud.host + ud.pa=
th).replace("/", "."))
+            ud.localfile =3D urllib.parse.unquote(ud.host + ud.path).repla=
ce("/", ".")
=20
         self.basecmd =3D d.getVar("FETCHCMD_wget") or "/usr/bin/env wget -=
t 2 -T 100"
=20
--=20
2.39.5


