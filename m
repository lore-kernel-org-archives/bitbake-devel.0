Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web12.3595.1615519226133168481
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Mar 2021 19:20:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=ltks2GOj;
 spf=pass (domain: axis.com, ip: 195.60.68.18, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1615519226;
  x=1647055226;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=BqZEBDg8HuLUVComrQWsRokaEEfgFzSrPNx9gcWuHzw=;
  b=ltks2GOj/2VkbCwu0twS4pLRbrLYRBmLx1HxWIGDQj6yOE1ha51FKG54
   YVk40g7vF4gcbnP2XQaq71EN04UYdX0oymGsq7iWHmiQlbJ/7Do/rrbJM
   8VtL9F1TOj/ggrV9BM3nXO7Uav34psMTgurveEU99K8abeqss3f4x9NZj
   HH5WLY9HxrOnbjAva3fsYsbkMDzdyBpe4ryvk8WU4lIkXy8mBDL0Dv1qb
   nSQBChC4M1IQKwOCarS8EW/vZzPLrpLn0OsqHByzcrHPT1A33maZaMw5s
   Nj9S0CM6s6mONRplzUeKGodw5kV0faHye5yhaVNQeczsl6fTp3MGhxz+N
   A==;
From: "Peter Kjellerstedt" <peter.kjellerstedt@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 2/2] metadata_scm.bbclass: Use immediate expansion for the METADATA_* variables
Date: Fri, 12 Mar 2021 04:20:22 +0100
Message-ID: <20210312032022.7783-2-pkj@axis.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20210312032022.7783-1-pkj@axis.com>
References: <20210312032022.7783-1-pkj@axis.com>
MIME-Version: 1.0
Return-Path: pkj@axis.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Define METADATA_BRANCH and METADATA_REVISION using immediate expansion.
This avoids running `git rev-parse HEAD` multiple times during recipe
parsing.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 meta/classes/metadata_scm.bbclass | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/meta/classes/metadata_scm.bbclass b/meta/classes/metadata_scm.bbclass
index 2608a7ef7b..47cb969b8d 100644
--- a/meta/classes/metadata_scm.bbclass
+++ b/meta/classes/metadata_scm.bbclass
@@ -1,8 +1,3 @@
-METADATA_BRANCH ?= "${@base_detect_branch(d)}"
-METADATA_BRANCH[vardepvalue] = "${METADATA_BRANCH}"
-METADATA_REVISION ?= "${@base_detect_revision(d)}"
-METADATA_REVISION[vardepvalue] = "${METADATA_REVISION}"
-
 def base_detect_revision(d):
     path = base_get_scmbasepath(d)
     return base_get_metadata_git_revision(path, d)
@@ -42,3 +37,8 @@ def base_get_metadata_git_revision(path, d):
     except bb.process.ExecutionError:
         rev = '<unknown>'
     return rev.strip()
+
+METADATA_BRANCH := "${@base_detect_branch(d)}"
+METADATA_BRANCH[vardepvalue] = "${METADATA_BRANCH}"
+METADATA_REVISION := "${@base_detect_revision(d)}"
+METADATA_REVISION[vardepvalue] = "${METADATA_REVISION}"
