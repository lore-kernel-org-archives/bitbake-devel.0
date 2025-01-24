Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8424BC02181
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 16:12:24 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web10.16170.1737735142239971411
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Jan 2025 08:12:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=0RM9abta;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.173, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21631789fcdso46465485ad.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 Jan 2025 08:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1737735141; x=1738339941; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t6Ys2OLkxD4lmaORVYet1VTNLoxIXN5GL7K3AtmoI1Q=;
        b=0RM9abta10RoV7CaDPf5LaM5yxN8YeimTz/u01O2M8QLAWGz0rUw9E9Xc+bejMzwxu
         eCbWQEWwFixIJiEXwQproxPS6iBjMWNJ2r3flJXXxK62qHQePtNnS3iLx6yh3pYnYoro
         EyAbJp3kLVgI0jk8f6H+5sd3LjDVeW9z7HxHtRh15To+evtDz2tnfCMTHrOpa9qcZi5q
         4FgYCnubEVe/fslKLvonF4empBGfCGoVr5gHNkrqA+459ZefWwEIBjzKCfTcAtDDlOjn
         GEMxHdI02YVIDeMjtPWDYGiImIfIU6JRe3mn2VhqkT7nLawdYn0U9AH1U+MSAabcSNL5
         pC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737735141; x=1738339941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6Ys2OLkxD4lmaORVYet1VTNLoxIXN5GL7K3AtmoI1Q=;
        b=J1fgQNAhXmO2hmCRTY/pnMPdhMh4D1xhngIyuOiXgMP8X+65e9gf/X21uCm31E4+24
         e+UhxaSGSc55USJJDYfx0YdkUyCU/n78DoU8zZVSaRY0uqCzOB8QtqBy/fQG32rT9nwv
         a1k1arbcnaBFKLPmhtSpYzuz9oyIRIqIdLjdFRBmfsXVM9tu3oO75DBPzYw4xL/D/GXm
         ubkvIBr5SBi5wVZkt2CJcWLbENA87FFKWCO4B02Kf0368mSoQiUy78LmrtI1EbsO119s
         PzuoWMaqlQ1eB1Ojso3WOFV5oaabUgE3TfLZowy4qu1fBOdNqv1TPnIrFKO/kyFa2BRW
         DZ9A==
X-Gm-Message-State: AOJu0Ywits7F+IH5lagkmxbDDLtzbtEcho9M0npjh6Mty/MmWquQn5l/
	piel7X0g0OlfTyIEFsbaseL6WBx6sHBQDgD/fWsEuVG+1fBPLPrJ57rFt7cMoqjtifiKccJIZLT
	I8DY=
X-Gm-Gg: ASbGncsdRu9XFSKk6k4ogNoh8xq4NPUKIFH1MCcsHAdrlnlDlGFSS0/elELN7OQkknC
	NVqCmdl8mi9M1L+hc9tAKWBCI8kW/E9PxVmfYgCkCl/0N/d1oiqbdyt1HjIY9TKso772F493Rr2
	uB5OJYV9Ub1zDJMOjCIMlsXIeYkMuoWtAow4nc6hmK+sXrb55057iwVDjau5otG2nFPjG3lALDn
	SahcPOCq+Sq9ud8PC63dvNOvERylQAmsMsbcmkZEtkVs0R2ItTr1FVKZeD3wHWAnfOX5g==
X-Google-Smtp-Source: AGHT+IHiGUPV4C4zYTYkmUDhyKNpq7+90xjlwdY0GLTWWpL8rTenMln9HbXYKMgMQ2Cz7AT7GHBMYA==
X-Received: by 2002:a05:6a20:9f45:b0:1e1:bd9b:40cf with SMTP id adf61e73a8af0-1eb76c163dcmr6566189637.8.1737735141522;
        Fri, 24 Jan 2025 08:12:21 -0800 (PST)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ac495983698sm1831880a12.55.2025.01.24.08.12.20
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 08:12:21 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 1/1] tests/fetch: Fix git shallow test failure with git >= 2.48
Date: Fri, 24 Jan 2025 08:12:13 -0800
Message-ID: <a4d7e5d38d70a82e853ac29c833942d444c547cd.1737735057.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1737735057.git.steve@sakoman.com>
References: <cover.1737735057.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 Jan 2025 16:12:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17077

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
index 9f0f00fff..88f4ba041 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1621,6 +1621,8 @@ class GitShallowTest(FetcherTest):
         if cwd is None:
             cwd = self.gitdir
         actual_refs = self.git(['for-each-ref', '--format=%(refname)'], cwd=cwd).splitlines()
+        # Resolve references into the same format as the comparision (needed by git 2.48 onwards)
+        actual_refs = self.git(['rev-parse', '--symbolic-full-name'] + actual_refs, cwd=cwd).splitlines()
         full_expected = self.git(['rev-parse', '--symbolic-full-name'] + expected_refs, cwd=cwd).splitlines()
         self.assertEqual(sorted(set(full_expected)), sorted(set(actual_refs)))
 
-- 
2.43.0


