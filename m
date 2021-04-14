Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mx.groups.io with SMTP id smtpd.web11.7176.1618365613440422875
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Apr 2021 19:00:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linux.microsoft.com header.s=default header.b=oaFedxwH;
 spf=pass (domain: linux.microsoft.com, ip: 13.77.154.182, mailfrom: pauleg@linux.microsoft.com)
Received: by linux.microsoft.com (Postfix, from userid 1054)
	id CFB7920B8002; Tue, 13 Apr 2021 19:00:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CFB7920B8002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1618365612;
	bh=HJjFvjU63LY+4Pocrvo5THwRdSUcwUHyl4EKo6gWrFg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oaFedxwHPGzg8Gon0e19QnJVLHqQ9dUOtBLL++zug3J+i6qpA9uIwWAlQGxl1sqDC
	 3d8/zjfIDTXz84ZxRCq6QARj6KEnQL6CLFz6oqz1BHQW3mxhDpgpulanfWEAVhg33E
	 SsB1QlZQz8I8NQlpkT0I5YFFyDffTOmJPWZjYYfE=
From: "Paul Eggleton" <paul.eggleton@linux.microsoft.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] bitbake-user-manual: document no support for using passwords in git URLs
Date: Tue, 13 Apr 2021 19:00:08 -0700
Message-Id: <e18c6851ed98b4cac6b0eda0636a2e6eae88eb09.1618364983.git.paul.eggleton@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1618364983.git.paul.eggleton@linux.microsoft.com>
References: <cover.1618364983.git.paul.eggleton@linux.microsoft.com>

From: Paul Eggleton <paul.eggleton@microsoft.com>

This is based on the comment added in revision
aded964eed4ce5a725ed1ab477efabc86b1aa481.

Signed-off-by: Paul Eggleton <paul.eggleton@microsoft.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-fetching.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index e9a5f33..bd6cc0e 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -441,6 +441,15 @@ Here are some example URLs: ::
    SRC_URI = "git://git.oe.handhelds.org/git/vip.git;tag=version-1"
    SRC_URI = "git://git.oe.handhelds.org/git/vip.git;protocol=http"
 
+.. note::
+
+   Specifying passwords directly in ``git://`` urls is not supported.
+   There are several reasons: ``SRC_URI`` is often written out to logs and
+   other places, and that could easily leak passwords; it is also all too
+   easy to share metadata without removing passwords. SSH keys, ``~/.netrc``
+   and ``~/.ssh/config`` files can be used as alternatives.
+
+
 .. _gitsm-fetcher:
 
 Git Submodule Fetcher (``gitsm://``)
-- 
1.8.3.1

