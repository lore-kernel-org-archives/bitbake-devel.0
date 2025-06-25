Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A008CC77B7C
	for <webhook@archiver.kernel.org>; Wed, 25 Jun 2025 20:00:52 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web10.25548.1750881641032719557
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 25 Jun 2025 13:00:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=bbF8cccg;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a6f2c6715fso239409f8f.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 25 Jun 2025 13:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1750881639; x=1751486439; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ojq/rBMyyDqaLgf/IyB8F5hjAKvO0xn4OY/gGsR/Oe8=;
        b=bbF8cccgLAvqxmCF0VwCd4ItYTFosTmoht8XG6FrWLnVNgBzYSAbLXuCpsfwH/ZrJC
         2sKeWd8BwX83Z7eqHPbc/4Sq8BjAeiLc1cUsaCf8AErZo2blB+4OZzpIqKen6YcBAOTo
         OAvoOM9keUyZ9UszjZ9YhV6NPre6TPnzMq16I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750881639; x=1751486439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ojq/rBMyyDqaLgf/IyB8F5hjAKvO0xn4OY/gGsR/Oe8=;
        b=H131FVnBoZrLO8xLagyk5EXkzf/ri7R32lYvtN6/qy3lPtjGZh5wuvGZp8tTbbVb8J
         6YOU9hMibteS+L1FwIx43FrJ8KnK2wUuH+hniud7tDNEkCWSe/FyM5Fc6Ih7PXwX6U+C
         JuXcxPt/RNFVKDDii2GQsW8WVE8p5C6lRhx0nZdnOomxVsyxBh+mmi6wrLEs36NGnJe4
         XwvoUpQr4rXIAc5wqBZ1redJ5AM3rEung4YkJ5CDXTOLkW5fh4oBV941RdfKhGJ4KwHN
         2YnhiFjG3m2kAI52/m6HAY3R/kFzgS6bGu9r8wBMQdaEGlahbxzZJdAqe0KockIyr5j1
         Y3qg==
X-Gm-Message-State: AOJu0YxArGnO43FDwzX5C0KrNGJsYxdBJQp0PU40f0N40vAvQGm2h12F
	7ii+ZigKSK2oWpUHkzhe05FZiTuYZPPBZ6ySBtWM6M5qSICHVsM3dxlBtIqPsBeTUTUsvOjHkKl
	1XUTm
X-Gm-Gg: ASbGnctmOhG0h/cOqv6SlDlZqaqnzh5WFQmeollt/tIs05YaWhg8kQbTRMAM1OAZ/IT
	kOiCv2qChmGqQGVaBMYQXV+pxYd+QuF0iYRFM42cxoqxgT9IukJaioigJvLkatq7hQqWn8ze5DR
	hWEtBDlmQGhmnOd+9VFQgJeThXmV9mxO9x7mpxcedyYYKZRhsA95DUynK1G+lHkZ/Up2xZukkGJ
	ftu1n0XRGbBOINftjhStZFVeLzB/3pKdk5VDGsp4JWgfkDQ67/+UGyndCl4JOr4QM4ACqVVKaAx
	VqaN7mR+MWXntwUQUDsdpTXgo/DTEL/yl/a4UsImdKqQsfCWR6fuIr3qL9xEQuZ5KvQFIEAQvlg
	3ipFML9E/WZ9/9UI=
X-Google-Smtp-Source: AGHT+IHHcIs6u+MZpdpHrNJ1m3II9GVUVhgPDzw/PJb2FFIY/Ryp0fKr0GKMHttxJHMP7igYQUFLGA==
X-Received: by 2002:a05:6000:2f81:b0:3a6:c925:ff57 with SMTP id ffacd0b85a97d-3a6ed5ec40emr4047683f8f.13.1750881638706;
        Wed, 25 Jun 2025 13:00:38 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:f1c1:2228:ff4c:9514])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823ad0fesm29623535e9.25.2025.06.25.13.00.37
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 13:00:37 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] fetch2/git: Improve shallow clone tag fetching
Date: Wed, 25 Jun 2025 21:00:35 +0100
Message-ID: <20250625200036.3148793-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 25 Jun 2025 20:00:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17717

Currently, tags are fetched as just a name, which works but means they're not
seen as tags by git commands like git describe. Instead, fetch them as refs/tags/XXX
which means such commands then work correctly.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/git.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 0af8070080b..e7b030998c0 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -634,7 +634,7 @@ class Git(FetchMethod):
             all_refs.append(line.split()[-1])
         extra_refs = []
         if 'tag' in ud.parm:
-            extra_refs.append(ud.parm['tag'])
+            extra_refs.append("refs/tags/" + ud.parm['tag'])
         for r in ud.shallow_extra_refs:
             if not ud.bareclone:
                 r = r.replace('refs/heads/', 'refs/remotes/origin/')

