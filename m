Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2270C02181
	for <webhook@archiver.kernel.org>; Wed, 22 Jan 2025 15:39:11 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web11.46400.1737560343912751523
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 Jan 2025 07:39:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=JWxmM/r1;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38637614567so3465708f8f.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 22 Jan 2025 07:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1737560342; x=1738165142; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gtqg3C/zlTHk87WxAK716YtmEj+YHCpnZUrP+XR9nJE=;
        b=JWxmM/r1vk803yS/4qKEko0O363+9Pno80W/32DOUEE55fAt2aUedWrPDpw7c4Ubop
         A15cXugW85V6v1hxNtnPIF+QDiSvmZOCvkuRycSyOGcDEsC8hQ4Jr8uyqcETHAkRARBJ
         4Qa6tuJ5Iz/JkCeDE/km8bOGL+RsBGCnMi0dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737560342; x=1738165142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gtqg3C/zlTHk87WxAK716YtmEj+YHCpnZUrP+XR9nJE=;
        b=r/u8D8UH8curBfrAhQmYdqsRhGC5IX0sMaEeCw+Nubf/3b20AYIwAW6h3m80f2gK7p
         kA4YOd2WBqrNB8BT9OOB+zRWCzDzN47e3vHdImbOQ7h/XXqn/oMzpfWpsxXR/Er/dMAm
         JJ44Dp+kYu1F4N3+h5x7q659baSov0CB8SwKysiv6xlylhxDXYfOhZcm6MIlvq4oVi2n
         V7A7YRGycClpySRdmJdLH/me5LbrmRDtzXQFkp1JWTu+bQull+YsXt3D76TSVMxX7hZs
         HmP88f3SW1I4IMOAzmOPxilRS2iJoczsZOSAQ6Tpfwbzp/6ANQlrToV9JjCffFy8H5C1
         eGYA==
X-Gm-Message-State: AOJu0YzRKExGIVca50MtFMZAlwfs9wTfWZSPoEFPI0I+mY+vdBO0LNQW
	uHxgw5VL4yZ0pmqgLjhBPwarvxE/s8NqC0emzbpW1ZjV7uHaXWf9XLVgEFFnnn1c8o3FH3N9OLN
	QwKs=
X-Gm-Gg: ASbGnctwGBTC8QNTnXxzuhDU+RL0VVFaQ3wssKMdjNfyqZVyJXivL+YJVVWl8Kqablk
	c5owDnMrbFUoXBV3nregGaDgwrFJHzx+FRpGcKDAJ8dwxmsJqo4NfbzvUmf+TVUkxs6jplbucd+
	TOlZOQK6dTD6Z8PnC4by6xSbiiDWgQRuZ4VwdKB+Y7jYqy3kn8TSkKxJLBow/u7qwM4O8rGCMN6
	Q91crKALhs64jISrVW1zU9dXNOHry3j2CifnSBNE4941B4HC+kjpCnP0QlHFJ/sido+GS5HI8Bc
	B4AwW4URpwLjPNx1WpGu
X-Google-Smtp-Source: AGHT+IEvFl1FbxFHB0CvP7W57l1B6GCEzJRrElDJcxwa+JRiBNOKY+ShXqEYiqUB7RkEITdRL7eESQ==
X-Received: by 2002:adf:a1cd:0:b0:386:459e:655d with SMTP id ffacd0b85a97d-38bf5664814mr15384681f8f.20.1737560341516;
        Wed, 22 Jan 2025 07:39:01 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:bd38:1d:73cc:d341])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf327df12sm16836421f8f.92.2025.01.22.07.39.00
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 07:39:00 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] tests/fetch: Fix git shallow test failure with git >= 2.48
Date: Wed, 22 Jan 2025 15:38:59 +0000
Message-ID: <20250122153900.1992500-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 Jan 2025 15:39:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17057

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
---
 lib/bb/tests/fetch.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 6b8e3e060f..d647170112 100644
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
 

