Return-Path: <ulfalizer@gmail.com>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
	by mail.openembedded.org (Postfix) with ESMTP id B073A7720B
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 12 Sep 2016 22:33:41 +0000 (UTC)
Received: by mail-wm0-f66.google.com with SMTP id g141so4641148wmd.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 12 Sep 2016 15:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=sHmPeu8ErZMnJ/eUsBgvVMnVbggWGqmmaRcMBvJaabc=;
	b=XBMNzV/qMzgGL3fIZRyrsGd9cwd/hPN0RrRZ+LpltTHAv6D9sxIgAB5lzZC8qxmbAH
	PVxrnswtaM9KfLshZQmL2BqktTKb3D/eHEoHNJ6vzzntv1Kp6Eg84bMg/9RF1Auth91Z
	BQwqDH6v+sg24j4aU9JH681WTm9F28E3Db7W3vmQzN6+M7RujpoeeAPH2GshPSubiwrZ
	KPMnzwFhdRl572ZBFUOvKSUga4SDiQlu6AMMgPiONxGaYGayYynX2rZOICpKS4Sa1PUY
	+9P+WxP8g8/Z3rLHXZNzkt4glKl9s1Y2nvTgnccnhlw8xOr4pCGHDr/FeC99c2SCobt2
	OrvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=sHmPeu8ErZMnJ/eUsBgvVMnVbggWGqmmaRcMBvJaabc=;
	b=KW7+te35vof9zzHfsUD/5wsU4hAQbplD4zDaRtCLnJkPU7laOSZAaF80tltlJlVbxp
	orC+sUBn8DKrRU4FfmOOha2bjRYk9+d1XUBlSyWO5MNQR7HR3+/ievPxorOK+/JNrN0+
	mM+Xn/at2C9cIqV/eFN/CYnFaOCtvT3SCQ1mjzBKmxR9k9GMDTUe1PW227QvnKDci7XE
	P1lv11CXt6PRQruhd6lPC62Yvpsuwhjb3WfYUAMrkXoyzvxbYucP5WoUEg05KvPUaeH/
	Jda+kL4oZ3Oo9+brun7etbIu0Gg2Ysll9G6Fawn3jgBrJXyWqfEgNWYqg7KwmwdbjH0m
	k2Eg==
X-Gm-Message-State: AE9vXwPyuxgNfpjf9e3Pt7JRC//lSaTEbWb2hEbtXRqyhR2O8QcDLACj1CKt62qpqxxb7Q==
X-Received: by 10.28.170.197 with SMTP id t188mr12267709wme.42.1473719621801; 
	Mon, 12 Sep 2016 15:33:41 -0700 (PDT)
Received: from huvuddator.home (ip5f5bfeac.dynamic.kabel-deutschland.de.
	[95.91.254.172]) by smtp.gmail.com with ESMTPSA id
	j10sm4428858wjy.13.2016.09.12.15.33.41
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 12 Sep 2016 15:33:41 -0700 (PDT)
From: Ulf Magnusson <ulfalizer@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 13 Sep 2016 00:33:32 +0200
Message-Id: <1473719612-1200-2-git-send-email-ulfalizer@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1473719612-1200-1-git-send-email-ulfalizer@gmail.com>
References: <1473719612-1200-1-git-send-email-ulfalizer@gmail.com>
Subject: [PATCH v3 1/1] bitbake: fetch2: Make SRCREV_FORMAT name substitution safer
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
X-List-Received-Date: Mon, 12 Sep 2016 22:33:41 -0000

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
index 11c75cc..5568fc3 100644
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
+    name_to_rev_re = "|".join(re.escape(name) for name in names_ascending_len)
+    format = re.sub(name_to_rev_re, lambda match: name_to_rev[match.group(0)], format)
+
     if seenautoinc:
        format = "AUTOINC+" + format
 
-- 
2.5.0


