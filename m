Return-Path: <ulfalizer@gmail.com>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
	by mail.openembedded.org (Postfix) with ESMTP id 62A597720B
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 12 Sep 2016 22:40:45 +0000 (UTC)
Received: by mail-wm0-f67.google.com with SMTP id z194so3327449wmd.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 12 Sep 2016 15:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=njhgU0crBM2nbUgAItxqx2wXCKeNh7/1OHvV/a9Z2CA=;
	b=r47htqc+6ayLiHHCqC0c3y/6fHlxsGHJpWecG562IBKitkzuS+I+SmRDpgwDdUqlr6
	u6pDDZ4rwKKV9K4GMgOnfk788h1qTV24EHSZJQyhDAypxq+/uQY/pRRHXofWEiQebAJD
	WwnYaS/ezG5g2te7KPfuX7I1oV9EI5H2Kr5KrEjsEVG9O/hmD5TgaSXCPAtFz/VTiJSu
	v0F28sN64OBf+0ZFsogqUZYbfabiiaysNHpJ4kan+WpQW0OEa3QjqE7DvTcwq4ZRCJp4
	Y2x5LjYdZRmYV8qpbXrZ2xbX3ryZCdZXXXulft/GXKCWhRCHW8iAtnXMrzx2rRqp2JMm
	PjZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=njhgU0crBM2nbUgAItxqx2wXCKeNh7/1OHvV/a9Z2CA=;
	b=Eku4of2TOvcdj2hr9MJCJ3ypNCG/kyIOOT5aK7C6hA8Mjz3tJU2y0mItLjIPWNDfUR
	mi9yLc0auNtTOVLx+NjTwBi9QxO/Ccr6uNGosLozVH2YcbqObeBzyabqxkb5AB5rjkYt
	83SHv8LFbQ8UPXUUAdZlquUsIRQjgnblK7ze+4vtEoEferJ4fB/XYXTXVUm/wmJ77Xvi
	HlMTJVuMSU0JAQrIVc0nBK+gL7Xcmm1EVbdBrzr4rsfMiufXCRxbhkQECXp0i9vBI8BZ
	lWvdGlVwYsTorYf9nHomHWuksqU5e9UV0FpBU/Nqj69bO2Z0YXFWx5sujlolUd1roIhH
	/XvQ==
X-Gm-Message-State: AE9vXwM9Dm2E0dnhfRzPArhVp7+dtu/KGPXdURDHRxKYu4O3L7LGfiuOCPUs2txmWjxofQ==
X-Received: by 10.28.169.23 with SMTP id s23mr1843702wme.87.1473720045515;
	Mon, 12 Sep 2016 15:40:45 -0700 (PDT)
Received: from huvuddator.home (ip5f5bfeac.dynamic.kabel-deutschland.de.
	[95.91.254.172])
	by smtp.gmail.com with ESMTPSA id o2sm19899989wjo.3.2016.09.12.15.40.44
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 12 Sep 2016 15:40:45 -0700 (PDT)
From: Ulf Magnusson <ulfalizer@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 13 Sep 2016 00:40:37 +0200
Message-Id: <1473720037-1789-2-git-send-email-ulfalizer@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1473720037-1789-1-git-send-email-ulfalizer@gmail.com>
References: <1473720037-1789-1-git-send-email-ulfalizer@gmail.com>
Subject: [PATCH v4 1/1] bitbake: fetch2: Make SRCREV_FORMAT name substitution safer
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
X-List-Received-Date: Mon, 12 Sep 2016 22:40:45 -0000

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
index 11c75cc..06f1eb4 100644
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
+    names_descending_len = sorted(name_to_rev, key=len, reverse=True)
+    name_to_rev_re = "|".join(re.escape(name) for name in names_descending_len)
+    format = re.sub(name_to_rev_re, lambda match: name_to_rev[match.group(0)], format)
+
     if seenautoinc:
        format = "AUTOINC+" + format
 
-- 
2.5.0


