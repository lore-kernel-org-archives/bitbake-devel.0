Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB15BC0218B
	for <webhook@archiver.kernel.org>; Thu, 23 Jan 2025 18:46:02 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web10.18798.1737657953845038992
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 23 Jan 2025 10:45:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=Sts8Sao/;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.180, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21680814d42so21171525ad.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 23 Jan 2025 10:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1737657953; x=1738262753; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v0W0k1Z3rFyFmyOGxKjJ6UB8ygBiVGUu25HcFjYI0J4=;
        b=Sts8Sao/YorRo7wEb1iUhMpe1LjlwWQwXi6KOgVdy2EiFpOHsGh3oEaiG4pF7rafFe
         SuIo7xjNbJw65kg8teFg85nyfYYqlKE70hz64M8n/trioCSak7mvIEKpxhbZStnqs7Hs
         ctHzMchhVi5CUsCjcBKGfV5eG8rdH4cx7gPyIfYZElnMq/pEIUOaQhaV9f2X1monKXyf
         UVn8eTBZ1s5HDbFClUQUBi0BOjjr0tl02P9udZIzJqECeB6IcRqePBq/ArxSG4xsrXJL
         OGuci6JaTU0JVLtCG2qK4uV5LtSg29ILF5rtHLj9rMFejnLRu7MNqCaQ03eJA/xN1Bbl
         Y2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737657953; x=1738262753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v0W0k1Z3rFyFmyOGxKjJ6UB8ygBiVGUu25HcFjYI0J4=;
        b=UulFvnITM2WRB24uxckfd1tDhdyWaZL93Mn8H/+s9ezmksjVov2v/WDa+n+qB0QZ8z
         ecjX887FCVoTKq4m4a3HphH349f0tuk5txvrG+jdDYZoXhbDiyWGisF7ArgP0arGss82
         255vFGZLWflnIGZv/zT17mQpYqdsXHnUly9+TK3Dv6imJe+rkmhljlUrJVTeIsXMrSSy
         uiEYwJnA47Om7oxum0DxwT2Aoq876t5aweKNiSLQGgfY02Tl4iEV3JuzNZa75FjXj8RZ
         0m4U9yA/77gm43WQI8t1gz/OuQ7afaWZIPXUNXR3sXNxwULUvbFAOd+JjzTS87WtoXyr
         DXQw==
X-Gm-Message-State: AOJu0YzG2pFlK5swOU6gY4sohxBKA/S/P5KvV1i0zEbXOsjE0NZw3SGu
	gQNYQoyUib60Four0nBLZ0Fp/e6iNa0SBu7F/6MPvRBEf/WHsRrVdjoYJwbFIoESJMJ7IpeNLSN
	Ggi8=
X-Gm-Gg: ASbGncvn7hLAJ5lsQneYylyX/26OE8JJlb2qAKRheOReoo5iMNdE92aMuycnl4GyLuY
	O7sFdMv+PkTjCWGNioORlhPxpTVcoO8U9Qbyt6fPvpdGy0MCLBcJw/U/uM+wTiJMSk7efItST3l
	87FCb6p0jrBNOOuPIfCxP8NoYGq6p0ZPv1WPvnAb1/LC500Z6QuAu7rf+wTs0j39MQQCrLuKKwS
	G5+PUxrfYu3OLepi7+UoV/xFuEJpa/wH20DVC00rPWjw7qRT8tEflD40WmTldnUqsPOYg==
X-Google-Smtp-Source: AGHT+IEeFCycsJb+5vOIBq4+gLLqVSqECPLCM/mrKCODQ4HW2yonn5X+JMu4Q88RrWTSiKP9E7S8iA==
X-Received: by 2002:a05:6a21:32a9:b0:1d9:2705:699e with SMTP id adf61e73a8af0-1eb2145cbc3mr46050451637.7.1737657953092;
        Thu, 23 Jan 2025 10:45:53 -0800 (PST)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a77c882sm259946b3a.146.2025.01.23.10.45.52
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 10:45:52 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][styhead][2.10][PATCH 1/1] tests/fetch: Fix git shallow test failure with git >= 2.48
Date: Thu, 23 Jan 2025 10:45:48 -0800
Message-ID: <516aef83bc317fbb41bb9b2c2bc76583c9ba72ed.1737657855.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1737657855.git.steve@sakoman.com>
References: <cover.1737657855.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 23 Jan 2025 18:46:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17071

From: Richard Purdie <richard.purdie@linuxfoundation.org>

From git 2.48 release notes:

"""
When "git fetch $remote" notices that refs/remotes/$remote/HEAD is
missing and discovers what branch the other side points with its
HEAD, refs/remotes/$remote/HEAD is updated to point to it.
"""

This means with git 2.48 onwards, there is a mystery "HEAD" revision
appearing in some of our shallow clone tests. We can avoid this by
using the same canonicalization as used for the reference revisions.

This resolves autobuilder failures on the Fedora 40 workers.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit c83444d1210740e27b1744d3aa7c5cad4e28db2f)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/tests/fetch.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 363f3a218..68b2dbba9 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1739,6 +1739,8 @@ class GitShallowTest(FetcherTest):
         if cwd is None:
             cwd = self.gitdir
         actual_refs = self.git(['for-each-ref', '--format=%(refname)'], cwd=cwd).splitlines()
+        # Resolve references into the same format as the comparision (needed by git 2.48 onwards)
+        actual_refs = self.git(['rev-parse', '--symbolic-full-name'] + actual_refs, cwd=cwd).splitlines()
         full_expected = self.git(['rev-parse', '--symbolic-full-name'] + expected_refs, cwd=cwd).splitlines()
         self.assertEqual(sorted(set(full_expected)), sorted(set(actual_refs)))
 
-- 
2.43.0


