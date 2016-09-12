Return-Path: <ulfalizer@gmail.com>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
	by mail.openembedded.org (Postfix) with ESMTP id E607A77223
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 12 Sep 2016 22:00:04 +0000 (UTC)
Received: by mail-wm0-f68.google.com with SMTP id b187so15532425wme.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 12 Sep 2016 15:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=K2v2thqTL9Zn8vKPeLhaGOYjl5uyybPKGTkribB6Img=;
	b=L5ILFIB598/VDUQ+KYieyYs3UwkH10TjhIK9Ql/tvPBF5jssExA7Ahdy/1ZNCEk3fB
	fHFN9NeSqv3IFQiaTq7I1FrZw88uF7Wqgf20c+PMI1F3+nycbaQ4i1NKGMDhjscMbied
	s75AmrkzkfMwPgBLalh4cx4WH3mV4deUeudn1OPB5ny153LmPk047oAcdpV5xgG4GmPV
	VwxB7RNaPDi1mRyjfaix5PfcGEmffYjOhBW/scjzRYgm6Se4ZOV4YdrQ1PSqBsiY/hrO
	2ROlqyht5csICBTK1gNjuB8OzHFR8kBfuMJtG64hoQvASb7i14nwp1tWUmjm34P4U8q/
	XSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=K2v2thqTL9Zn8vKPeLhaGOYjl5uyybPKGTkribB6Img=;
	b=O7tuU6CAUmLNXUx/3MZqatcnXQjNN/99E9Gmcq72byrFAMs8eUL65EbyQBtTrS7EZx
	0+0lJHqtZw8NEcVHtcRCu/3yzD/TM2C9v/EroMNKvzl7M/3yShVGTVoTdlSJvpF5ZXh6
	f41thVbV2ZBNTF0NyBi7kaMz0NpG+GfT2mJxT8avHw730xUXYsjMKhDjkQXsLFThY07G
	vAh0hZ4+lACLGC5W7pNFfA8ODeRPz/IeV5RHhQeTuFu+gzQptHBQcBy39NmBaTo9mano
	nWc9vI3lCqHtmYHWQTKwB1YpV3KXOJIO9x+Yqo4vOwwI7t8DQuvbmgkKPMt+RNUU8CyC
	7dqA==
X-Gm-Message-State: AE9vXwN5Sra+lXrPB4rO5qtKRIGbtjifiPLJ4VkfnSVBfNe+vjBkE74MIVB7J98wZQROWA==
X-Received: by 10.28.103.133 with SMTP id b127mr1818192wmc.82.1473717604766;
	Mon, 12 Sep 2016 15:00:04 -0700 (PDT)
Received: from huvuddator.home (ip5f5bfeac.dynamic.kabel-deutschland.de.
	[95.91.254.172]) by smtp.gmail.com with ESMTPSA id
	uv6sm19806377wjc.31.2016.09.12.15.00.04
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 12 Sep 2016 15:00:04 -0700 (PDT)
From: Ulf Magnusson <ulfalizer@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 12 Sep 2016 23:59:52 +0200
Message-Id: <1473717592-6824-2-git-send-email-ulfalizer@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1473717592-6824-1-git-send-email-ulfalizer@gmail.com>
References: <1473717592-6824-1-git-send-email-ulfalizer@gmail.com>
Subject: [PATCH v2 1/1] bitbake: fetch2: Make SRCREV_FORMAT name substitution safer
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 12 Sep 2016 22:00:05 -0000

The implementation of SRCREV_FORMAT has at least two issues:

 1. Given two names "foo" and "foobar" and SRCREV_FORMAT = "foo_foobar",
    "foo" might currently get substituted twice, and "foobar" not at
    all.

 2. If the revision substitued for some name happens to contain another
    name as a substring, then that substring might incorrectly get
    replaced.

Fix both issues by sorting the names with the longest ones first and
replacing all names at once with a regular expression. This was inspired
by
http://stackoverflow.com/questions/6116978/python-replace-multiple-strings.

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 11c75cc..33d8d59 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -761,6 +761,7 @@ def get_srcrev(d, method_name='sortable_revision'):
     if not format:
         raise FetchError("The SRCREV_FORMAT variable must be set when multiple SCMs are used.")
 
+    name_to_rev = {}
     seenautoinc = False
     for scm in scms:
         ud = urldata[scm]
@@ -769,7 +770,16 @@ def get_srcrev(d, method_name='sortable_revision'):
             seenautoinc = seenautoinc or autoinc
             if len(rev) > 10:
                 rev = rev[:10]
-            format = format.replace(name, rev)
+            name_to_rev[name] = rev
+    # Replace names by revisions in the SRCREV_FORMAT string. The approach used
+    # here can handle names being prefixes of other names and names appearing
+    # as substrings in revisions (in which case the name should not be
+    # expanded). The '|' regular expression operator tries matches from left to
+    # right, so we need to sort the names with the longest ones first.
+    names_ascending_len = sorted(name_to_rev, key=len, reverse=True)
+    name_to_rev_re = re.compile("|".join(re.escape(name) for name in names_ascending_len))
+    format = name_to_rev_re.sub(lambda match: name_to_rev[match.group(0)], format)
+
     if seenautoinc:
        format = "AUTOINC+" + format
 
-- 
2.5.0


