Return-Path: <danielwa@cisco.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98479C43458
	for <webhook@archiver.kernel.org>; Fri, 26 Jun 2026 19:10:39 +0000 (UTC)
Received: from rcdn-iport-1.cisco.com (rcdn-iport-1.cisco.com [173.37.86.72])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.41889.1782501030494431220
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 26 Jun 2026 12:10:30 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@cisco.com header.s=iport01 header.b=GVImBgO6;
 spf=pass (domain: cisco.com, ip: 173.37.86.72, mailfrom: danielwa@cisco.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=3188; q=dns/txt;
  s=iport01; t=1782501030; x=1783710630;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L702H0eWLI1Sad930hwb1GYboatJYHTUUFhBiVkHXFw=;
  b=GVImBgO6k2P2qRnN0qaZyrN2R/TCJQvjmWuKkKnllITotHC8r3pKvFVf
   HbYq5nGZLhIKDUSJXNc/xhtvgLhRme+SLdHzfpPpg4zKJFkpYAvABmBzV
   MLRP3XPekwj/rOUe8CGrbWAfNeIRu6yvXfTYGbcfyMbFiMaM25Kv6p+99
   uzgMEzhzrg0oKP1YbZImqxEKs4bJMJ8kMb3uyYqa8SsIoR2aRWTRxGK4+
   VsvSDy88wbEbqNz9GldLtJfEhqLI3hDuCo8OBCOXO6mHJ0b+PNl86hiGP
   k1DmlZuLuycw+GXKuk0wFZX7bCoPU+syFUzjdL4wB1BTbEPhxuI+Rtuqq
   Q==;
X-CSE-ConnectionGUID: 7pfWYLr4Rzycpl+xOr5Piw==
X-CSE-MsgGUID: LGGOaxekSau9E4sn93H8MQ==
X-IPAS-Result: =?us-ascii?q?A0A+AgC8zT5q/4z/Ja1aHgEBCxIMggULgld0X0JJlCqCI?=
 =?us-ascii?q?Z4egX4PAQEBDzEgBAEBklMCJjQJDgECBAMCAwEBAQEBAQEBAQEBCwEBBQEBA?=
 =?us-ascii?q?QIBBwWBDhOGTw2HEwGCFoMCAYJzAgG6K4IsgQGEfdlGgWYBCxQBgTiFcYdth?=
 =?us-ascii?q?XAnG4FJRIR+hAqGfgSCIoEMkR1IgR4DWSwBVRMNCgsHBYFmAzUSKhVuMh2BI?=
 =?us-ascii?q?z4XgQwbBwWBHYFrgQKFACMfAzl/gTGBI2RmFTA1gQIRHgqBUiYDCxgNSBEsN?=
 =?us-ascii?q?xQbBD5uB4x0Fw+CPAEBgQsCAYJzBsZjhCeBZoo7lToaM6prAYg7kE2kWoRog?=
 =?us-ascii?q?Wg8gVkzGggbFYMiCUoZD5gHxDdENT0CBwIHDgMLkWgCJgeBTgEB?=
IronPort-Data: A9a23:tzdBSaMrzvDV7BjvrR3wlsFynXyQoLVcMsEvi/4bfWQNrUoj3zACn
 WMZCm/QMq3ca2r3ftxyYdi09ElUsJfXnNE3SXM5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCeaphyFTmE+kvF3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZh6mJTqYb/WV/lV
 e/a+ZWFZgf7gWAsaAr41orawP9RlKWq0N8nlgRWicBj5Df2i3QTBZQDEqC9R1OQapVUBOOzW
 9HYx7i/+G7Dlz91Yj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnBaPpIACRYpQRw/ZwNlMDxG4
 I4lWZSYEW/FN0BX8QgXe0Ew/ypWZcWq9FJbSJSymZT78qHIT5fj66p2An4HGZdEwPRmCnlKt
 uw/Mm01bw/W0opawJrjIgVtrt4oIM+uOMYUvWttiGmCS/0nWpvEBa7N4Le03h9p2ZsIRqmYP
 ZdEL2MzNHwsYDUXUrsTIJ43mualgmb2WzZZs1mS46Ew5gA/ySQsiOCzbIuEJYLiqcN9umm3g
 WvW8mfCCwxLGYCEz2ve0iKJv7qa9c/8cMdIfFGizdZggUGZz28eTREbS1a/if24kVKlHdVHJ
 koZ/yAjoaQ/+AqsVNaVYvGjiGSPshhZX59bFPc3rVnWjKHV+A2eQGMDS1atdeAbiSP/fhRyv
 nfhoj8jLWYHXGG9IZ5FyoqpkA==
IronPort-HdrOrdr: A9a23:1kdYda4ABSuhjnOfAgPXwPbXdLJyesId70hD6qkXc203TiX2ra
 +TdZggvyMc6wxwZJhDo7690cC7KBu2yXcf2+Us1NmZMTUOwFHIEKhSqa3/3jbnByryssRZ1a
 tmbuxCLeeYNykZsS4/izPId+rJB7K8gcWVuds=
X-Talos-CUID: 9a23:6kakkW7pjKaXDGPT7dssq1YaJfEBaCHn3mbbO0v7GUFzFYWUVgrF
X-Talos-MUID: =?us-ascii?q?9a23=3Ar0SH0w3kZw0tKEFxCVM4mEA58DUjx4uBL0kdnJY?=
 =?us-ascii?q?9stTVGHBrPWbGrGSSe9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.24,227,1774310400"; 
   d="scan'208";a="500649976"
Received: from rcdn-l-core-03.cisco.com ([173.37.255.140])
  by rcdn-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 26 Jun 2026 19:10:29 +0000
Received: from sjc-ads-2388.cisco.com (sjc-ads-2388.cisco.com [171.70.63.76])
	by rcdn-l-core-03.cisco.com (Postfix) with ESMTP id 4159C1800058A
	for <bitbake-devel@lists.openembedded.org>; Fri, 26 Jun 2026 19:10:29 +0000 (GMT)
From: Daniel Walker <danielwa@cisco.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch/git: add reference option
Date: Fri, 26 Jun 2026 19:10:28 +0000
Message-ID: <20260626191028.162111-1-danielwa@cisco.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-Client-TLS: NONE;sjc-ads-2388.cisco.com [171.70.63.76]
X-Outbound-SMTP-Client: 171.70.63.76, sjc-ads-2388.cisco.com
X-Outbound-Node: rcdn-l-core-03.cisco.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 26 Jun 2026 19:10:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19794

Adds a option to the git fetcher which can be used to specify a local
reference for a given SRC_URI. Which is then fed into the clone command
as "--reference-if-able" which make the option fault tolerant if the
directory doesn't exist.

AI-Generated: OpenAI Codex
Signed-off-by: Daniel Walker <danielwa@cisco.com>
Change-Id: Ib5eb685ddfb48fa19f1c65cfc468894806f99e83
---
 .../bitbake-user-manual-fetching.rst                 |  7 +++++++
 lib/bb/fetch2/git.py                                 | 12 +++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index b96018a4e..6e4fc0800 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -398,6 +398,13 @@ This fetcher supports the following parameters:
    preserve the local cache carefully for future use. The default value
    for this parameter is "0".
 
+-  *"reference":* Specifies a local directory to use as a reference
+   repository. When set, the fetcher passes the directory to ``git clone``
+   with ``--reference-if-able``. Git uses the reference repository's
+   objects when possible, reducing the amount of object data copied or
+   fetched. If the reference directory cannot be used, Git continues
+   cloning without it.
+
 -  *"nobranch":* Tells the fetcher to not check the SHA validation for
    the branch when set to "1". The default is "0". Set this option for
    the recipe that refers to the commit that is valid for any namespace
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 0fbd85441..df1c4415f 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -22,6 +22,10 @@ Supported SRC_URI options are:
    remind fetcher to preserve local cache carefully for future use.
    The default value is "0", set rebaseable=1 for rebaseable git repo.
 
+- reference
+   Use the specified local directory as a reference repository by passing it
+   to git clone with --reference-if-able.
+
 - nocheckout
    Don't checkout source code when unpacking. set this option for the recipe
    who has its own routine to checkout code.
@@ -195,6 +199,12 @@ class Git(FetchMethod):
         if ud.bareclone:
             ud.cloneflags.append("--mirror")
 
+        ud.reference_args = []
+        ud.reference = ud.parm.get("reference")
+        if ud.reference:
+            ud.reference_args = ["--reference-if-able", ud.reference]
+            ud.cloneflags.extend(ud.reference_args)
+
         ud.shallow_skip_fast = False
         ud.shallow = d.getVar("BB_GIT_SHALLOW") == "1"
         ud.shallow_extra_refs = (d.getVar("BB_GIT_SHALLOW_EXTRA_REFS") or "").split()
@@ -436,7 +446,7 @@ class Git(FetchMethod):
                 objects = os.path.join(repourl_path, 'objects')
                 if os.path.isdir(objects) and not os.path.islink(objects):
                     repourl = repourl_path
-            clone_cmd = ud.basecmd + ['clone', '--bare', '--mirror', repourl, ud.clonedir, '--progress']
+            clone_cmd = ud.basecmd + ['clone', '--bare', '--mirror'] + ud.reference_args + [repourl, ud.clonedir, '--progress']
             if ud.proto.lower() != 'file':
                 bb.fetch2.check_network_access(d, clone_cmd, ud.url)
             progresshandler = GitProgressHandler(d)
-- 
2.44.0


