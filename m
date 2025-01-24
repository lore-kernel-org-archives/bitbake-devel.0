Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84652C02181
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 16:08:54 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web11.15869.1737734932022589519
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Jan 2025 08:08:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=MeRWo9s9;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.181, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21644aca3a0so52788905ad.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 Jan 2025 08:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1737734931; x=1738339731; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U9Qv6LTa34Apd9kTdeWAry9/KCu/iK+TBSlS7PXZ5TI=;
        b=MeRWo9s9SmcqR0kx8iuUkJ5tmLQZ9xhJZMnEItNr1kWH9Xb32ZbLSxuZgq8ZK2VHjE
         /Gg4isIKoPBHCy+I95YPTde2PW18PX/u/J1Sk2D8C5RDZNMj2HB+gW+D2JTUaPo2Ld3w
         Mui+/rA/v0cZF6j9NLCoaxNZAAu1UT3pFLKzZVRp8Sxr+FzE65ieQyIwG1r5MpXND2qn
         UaZ/JAHZpcdMwSqakeF1e3q4iEZYu+BRnu8OLDo5qLMyztlGjKXJRpD3aEJ4ZrpcRnV0
         EnFz/YdTRzjbyRtDCfcQ0ZRGsmSG7Z/koM/bKLdYzrNunAj+3ojpr1unURaK8+0mc1DK
         yJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737734931; x=1738339731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U9Qv6LTa34Apd9kTdeWAry9/KCu/iK+TBSlS7PXZ5TI=;
        b=emymspMgt6qy3X6NJtAHZoaQx+bViz5lJRdvZnvk7+i4nAx+CZiqA14cgG6wksIqpu
         bM3qrNrvpn1J4BiV5KId1iGOXR3TlOzQIgfRxty/AT4IEUZz6OP7nDO/pBHKiAN3KJLF
         FdA/LJ4gcIl6yXk3sHEqD1TnufcAuNX+ruN2h11fiOB7MfOADQd6yNEeFtQH/LFE/U61
         os/Sj+nIEJgJKUcbZTNOdv35a19VAIa36jQnQ0jh9AAg+m2mv+XXi6VEAezoRCb/unVR
         MGP6c1hSji7l5Sl1JdLFRrbJxJi9ylv8swRR64yp/X+uYViwyzo/Dom24wZGUdb8SSBj
         P8mg==
X-Gm-Message-State: AOJu0YysO25+T+ceSJXbxEGVQTHt9Y2jKCVT7pSz2uEqxUHLMzgT3Kp4
	sFgeugqD/dpZf75CknfHqPhw2mK/n9Te2qZPrJexuPnRfjDOHcKPBjWGr6uan+ndbJWR9u+vNV9
	LX+M=
X-Gm-Gg: ASbGncuP8zl9RPP3cE9uiHpSfbnA8/1XhKaDOQwIZpRWf9xSLYtdx3vudEZv4PossSc
	QpkKjSfKSV9gopX62MawamEV9MTz53tpfkyVgIg17mFFGXsh/tebjzgjXu81uW53zAquwV6psN5
	VImxaRQlDG1qgIGDXIFsI8SeUKeegnbx87XX/6g9rQtCMHHlTdQunzRf6BdibLHSkG4xCmBUIW7
	zOnDw7fKm75oOyMlgpUr2/TYFvl7YQb4/TR7egvp2msyOVfmhmTNoPsDbm0hxLnbRL9OA==
X-Google-Smtp-Source: AGHT+IEW4dwsf72PqxS6OjRGZb4XslAN0CFc7nhyiiuaLuqqWZPipqBx63rraFaxSVJPwjqjOzH0fw==
X-Received: by 2002:a05:6a20:748f:b0:1e1:a06b:375a with SMTP id adf61e73a8af0-1eb2160f41fmr54647234637.35.1737734931262;
        Fri, 24 Jan 2025 08:08:51 -0800 (PST)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ac48e569c5bsm1852088a12.9.2025.01.24.08.08.50
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 08:08:50 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 1/1] tests/fetch: Fix git shallow test failure with git >= 2.48
Date: Fri, 24 Jan 2025 08:08:44 -0800
Message-ID: <f72a90dca6a434a8d128d8486d1b3e7af8f7c5cd.1737734826.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1737734826.git.steve@sakoman.com>
References: <cover.1737734826.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 Jan 2025 16:08:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17076

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
index 231da669e..afabaeba1 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1715,6 +1715,8 @@ class GitShallowTest(FetcherTest):
         if cwd is None:
             cwd = self.gitdir
         actual_refs = self.git(['for-each-ref', '--format=%(refname)'], cwd=cwd).splitlines()
+        # Resolve references into the same format as the comparision (needed by git 2.48 onwards)
+        actual_refs = self.git(['rev-parse', '--symbolic-full-name'] + actual_refs, cwd=cwd).splitlines()
         full_expected = self.git(['rev-parse', '--symbolic-full-name'] + expected_refs, cwd=cwd).splitlines()
         self.assertEqual(sorted(set(full_expected)), sorted(set(actual_refs)))
 
-- 
2.43.0


