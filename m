Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C30C433F5
	for <webhook@archiver.kernel.org>; Mon, 14 Mar 2022 02:14:11 +0000 (UTC)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by mx.groups.io with SMTP id smtpd.web08.21884.1647224044035250454
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 13 Mar 2022 19:14:10 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="unable to parse pub key" header.i=@intel.com header.s=intel
 header.b=ggOPkZ9w;
 spf=pass (domain: intel.com, ip: 192.55.52.43,
 mailfrom: anuj.mittal@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647224050; x=1678760050;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=1+w0rtyuSFvcBDpO+L4ONoTRjn6i4FeZk/KYqEuNfGc=;
  b=ggOPkZ9wVHfjC6KWDwaiEZJKQp3wT0y56lyAFzcZB3jQHqjdd92LQmeG
   +oPJlvmGv8rjPai6QPlDprnY2qVYBFZD44YK6LMRUnF3/PC32CcktwLwX
   KJWWhI8UK+r/LSieJA1kdH3nQFvSdTVwACEY5DN+5F4f8M668QvDD7QcZ
   Kj3NJrm79nTEQmnPv0+87WnAgvr/f7YvSZ7dN42u6xFdBJd/KRjCN6EXG
   s9+mVrXpkCB6iAMorZ3k0NBU0LzUE0fdqolQo5CAdF3cf84IeiNDKBxzw
   6PW8g6KfnwEc62mHaJ7CrdEruytXw0BNKpWSUDpmj8DA0RtcxncANRzl9
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="342344763"
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400";
   d="scan'208";a="342344763"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2022 19:14:10 -0700
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400";
   d="scan'208";a="818562607"
Received: from lsim7-mobl1.gar.corp.intel.com (HELO anmitta2-mobl3.intel.com)
 ([10.215.229.232])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2022 19:14:09 -0700
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.52][PATCH 5/5] fetch2: ssh: username and password are optional
Date: Mon, 14 Mar 2022 10:13:57 +0800
Message-Id: 
 <e573d5d3baebcbc4e950da3796ce55d5e920c0fd.1647223687.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647223687.git.anuj.mittal@intel.com>
References: <cover.1647223687.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 14 Mar 2022 02:14:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13481

From: Daniel Wagenknecht <dwagenknecht@emlix.com>

Support URLs like ssh://HOST/PATH. They were previously not recognized
due to a missing @ sign.

Signed-off-by: Daniel Wagenknecht <dwagenknecht@emlix.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit a2aa18bd27dac8902e52b466cb7118f71367d3dc)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/fetch2/ssh.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/ssh.py b/lib/bb/fetch2/ssh.py
index 2c8557e1..a104c9eb 100644
--- a/lib/bb/fetch2/ssh.py
+++ b/lib/bb/fetch2/ssh.py
@@ -40,9 +40,9 @@ __pattern__ = re.compile(r'''
  (                   # Optional username/password block
   (?P<user>\S+)      # username
   (:(?P<pass>\S+))?  # colon followed by the password (optional)
- )?
  (?P<cparam>(;[^;]+)*)?  # connection parameters block (optional)
  @
+ )?
  (?P<host>\S+?)          # non-greedy match of the host
  (:(?P<port>[0-9]+))?    # colon followed by the port (optional)
  /
-- 
2.35.1


