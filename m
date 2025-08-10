Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D951C87FCF
	for <webhook@archiver.kernel.org>; Sun, 10 Aug 2025 22:24:11 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web11.35348.1754864642047359813
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 10 Aug 2025 15:24:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Do2qfLDU;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-458bf6d69e4so34793435e9.2
        for <bitbake-devel@lists.openembedded.org>; Sun, 10 Aug 2025 15:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1754864640; x=1755469440; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCSxXBAKiZQO8EZ+yRWYbGvC2AKfZ8vuyRVAn3XwNfA=;
        b=Do2qfLDUW+jURX/ocKUgQNg1Ql37KIK2tYaJ7QTOyo+Ky9MKT6yRr7KNqb1B5G7h0I
         rl6/CmgZizc7oWGdEMGQV3rOhtSwhzrNxfs01vfmzxY96siTgnIU0oYxoT8FYLTNG3VL
         2L/xmX8CUiKeHDMaO7Fz2/XpKpxsejYdg7oKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754864640; x=1755469440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rCSxXBAKiZQO8EZ+yRWYbGvC2AKfZ8vuyRVAn3XwNfA=;
        b=AE+Db36dFETPtibtsnANfTd1zVlumepwkN5QKjnaxiEQUPga96omG4goi5tlYcmnLi
         urNVtv4onhPHRstOk+2Euk9rPuoA/mVGxqDoWAOdkBXuyIIS4z8/JlhEt8qzWnaNGMw0
         wM/9u4mJ1QlpS0aDBdoQzeNSZOv203DC9OOqrG0alZM60mmO7YQXsdRGX0jcsKjUtbE+
         lyyNf2pUYifbSTPrtTH6b9Iva7c0h4hlv2euf2mUTVpZaltEv1tkw7O/tXOzbF70kBYj
         QBlpbfdGLM1p6wGb6xd3XZrH37CLKPw2Kx8v4fg99vLAwpkVgwNykdMueXOqr44diaye
         Nesg==
X-Gm-Message-State: AOJu0YwCkortiaitWvxBGdeJIOi0uX37R2rV13kOtlRCMNOe6H5h2dcm
	eWlkiLe215pBL6AM3FJTssK9s9HJE+lRjMfPzvw1T1APQadCaxa+ssRBBxI/wTgVkFFaNTYlSwb
	B2ydG
X-Gm-Gg: ASbGnct9mMxqDyb+88ZUVTMU1cSVrN2JEnSg1lEjRL/5ckm6oBhZT9/T144ZrmRnac4
	wDolr+JnBDenugd+VOz3Sd8JLc/Dmihk4IE8Uo5AIkoj/gvrPWGvzDAASjKg3HJXhWs5ZvusZ12
	dIssenS3xKyo8W+YvFXAwtmTUhkzxS9rg2wLKM0W5zeXTf7p1ebSmyNYAO9KnnWYXwjuG+TT5Bg
	AhpsP2EC17wLzSc4NimHBgS/YpVFtQ7ysxVBb5CT/bJQQdkHDx1eAAt17unkMOU3ZTUYWRGDFoi
	paYzbT+FJr9YYNOBvK/qAzgg2zppNpXT1d9foias7TAndRQ+g9c4gw3X/B+FF6woh91flmJE9nO
	k4ghns/g7JRnIJTIblVAtig6QwGplLv/iiKkNACqGcnyZ7x/V7iBFSm2FvpZPFw==
X-Google-Smtp-Source: AGHT+IFjiD794YHQAvAiS57IOStv3QRu9aiuoY76rt1T46LXSa2bZCHeJKjoq8/i6lUiMMubHdyNXw==
X-Received: by 2002:a05:600c:609b:b0:456:19be:5cc with SMTP id 5b1f17b1804b1-459f5935436mr109140845e9.14.1754864639828;
        Sun, 10 Aug 2025 15:23:59 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:2db4:de3e:1e1f:36bf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e0cd2c90sm274039325e9.17.2025.08.10.15.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 15:23:58 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [PATCH 3/3] Add bb.utils.explode_deps as a filter function
Date: Sun, 10 Aug 2025 23:23:54 +0100
Message-ID: <20250810222355.2486772-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250810222355.2486772-1-richard.purdie@linuxfoundation.org>
References: <20250810222355.2486772-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 10 Aug 2025 22:24:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17852

From: Joshua Watt <JPEWhacker@gmail.com>

Marks bb.utils.explode_deps as callable from filter functions

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/utils.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 0cf3b1814c4..366836bfc9a 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -34,6 +34,7 @@ from contextlib import contextmanager
 from ctypes import cdll
 import bb
 import bb.msg
+import bb.filter
 
 logger = logging.getLogger("BitBake.Util")
 python_extensions = importlib.machinery.all_suffixes()
@@ -184,6 +185,7 @@ def vercmp_string_op(a, b, op):
     else:
         raise VersionStringException('Unsupported comparison operator "%s"' % op)
 
+@bb.filter.filter_proc(name="bb.utils.explode_deps")
 def explode_deps(s):
     """
     Takes an RDEPENDS style string of format::

