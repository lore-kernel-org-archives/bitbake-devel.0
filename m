Return-Path: <michael.siebold@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291A5FCA193
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 21:21:49 +0000 (UTC)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.25835.1773091307667384467
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Mar 2026 14:21:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=JAxbSF/c;
 spf=pass (domain: gmail.com, ip: 209.85.160.176, mailfrom: michael.siebold@gmail.com)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-509149ab7d7so16477661cf.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 09 Mar 2026 14:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773091307; x=1773696107; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MnMKH8d+DJSlBuQf1IO3qJstcQR5rKGsLq8lyNdbwN8=;
        b=JAxbSF/cbbeDpl+rp9+AqRQFi4yo61JzgnCfZuf48ES0rcD4I1C+wRroUZlG44ZzKl
         CUjVHouYbVanZ3oPO22s1qc5XV9SirCfxKTpJb8WMiwb+FsZ/NgQlBK3a0hgIy4DJRYG
         SsXSWFjpbkfDrxhpWfE/f12J9A0xFFPtVUL5L1bpZhNNivOPht3NhdsE8QvFhDvuzvlH
         /qZLhJbXzeGdSA36q/eE1/G6TxAHFFbodxvwG/rkYf+ks6IQWFqfAAMUbDv3rDoDai/n
         LeiGYdJ0wskC6ZagkX1hBPLRWMKMCVGqQjHJjXPorGS63/6H1bEf04I6C0dv0LRVrLq7
         js1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773091307; x=1773696107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MnMKH8d+DJSlBuQf1IO3qJstcQR5rKGsLq8lyNdbwN8=;
        b=RG57y3nvMd5kP+U4c6bvInhRYnL6k5fYNZpG9t86JWSbHVGyHsyXcex0xINF+a2lAg
         mVhTnN7p6VTBLx6qkmh6kqSvASFeQmPd6045xGSwpzpAgPlBULdfznnnKsuZERrfRmu0
         PxK6cUS+f6nVAkWAhPjTrQuGQl4Ahlc7+c7pjZHAcV9idMlGlPAP22N0s4vgUxpimDle
         zUbVDr0ILlogrYIhIUcgyoH+sdEOXSSiG461HzNLdtAPUDDrPE8nSdCo9N6oGJnpsyHR
         AbQf34dVtiyKaKtXXZz9yLpRWxfn5KcsucwwKe4fiaSoEVyFRyrRjszIoMHXA7wOlYmH
         ltXQ==
X-Gm-Message-State: AOJu0YzODngq6JGMquy3YNAkHtR2513sb3iLYDCz2XkVb4f5tQxHcKhN
	Qhujjy8xxJEIiguDTVDxfk+SBS8utQMixGgc3in7lteRVDQoIbrM2m2s
X-Gm-Gg: ATEYQzzhaLdGGsHVkm6vupB3S7nDoRR5fOo7rDVIzEjHtwnpmVg6SbZPl7KiLOdd5CZ
	/SeH6v+B0ZmgE6m5GRjyeGyrNOKY9JnNdRyDmvB01CS55ay5qBcs0AKlWJSHWKdKnzSB6H7CQAb
	TsWR7phkxLmdEz5wiYkzybU6fTVG4L/BI4FZIvXlZMqsBjza+NdxksDOF6CKq/WlrcA9XG+txT5
	SsXXJoyB7760wVaOuOh8YZeGxB+f6zE6391MmyeWlCiiKK5Elp+765hgZ+FS+18PD5yZ0nStTuZ
	gn4Wa0hLgOqNBqTC8lftSf+yx7v0vCnzTP7qXwRhHvd28aMsm4+yWlHcjIqzZYK1oJz88XvgPil
	bZI2qgWSAPN+t11+pGb9EWKe2RIR9AOmV9oRB+syo3IzjnLUjBQMM2Z87/TtzNq/wE2D2cdWPAZ
	2fe1eTmh98AB9dASptDObrzLnoxQ62q247jjdQCUFwdxxF1CI=
X-Received: by 2002:ac8:5f4c:0:b0:509:20de:4ad1 with SMTP id d75a77b69052e-50920de58c2mr38984331cf.10.1773091306596;
        Mon, 09 Mar 2026 14:21:46 -0700 (PDT)
Received: from beeblebrox.pc.cognex.com ([143.170.79.157])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50924937718sm8522881cf.29.2026.03.09.14.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 14:21:45 -0700 (PDT)
From: Michael Siebold <michael.siebold@gmail.com>
To: Yoann Congal <yoann.congal@smile.fr>
Cc: bitbake-devel@lists.openembedded.org,
	Philip Lorenz <philip.lorenz@bmw.de>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Michael Siebold <michael.siebold@gmail.com>
Subject: [PATCH 2/3] bitbake: fetch2: Fix incorrect lfs parametrization for submodules
Date: Mon,  9 Mar 2026 14:21:24 -0700
Message-Id: <20260309212125.3172717-3-michael.siebold@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309212125.3172717-1-michael.siebold@gmail.com>
References: <20260309212125.3172717-1-michael.siebold@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Mar 2026 21:21:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19129

From: Philip Lorenz <philip.lorenz@bmw.de>

The existing code would pass `True` or `False` to the git fetcher. As
the fetcher expects `lfs` to be set to `1` this always lead to LFS
fetching being disabled.

(Bitbake rev: 5e487a5a096400271ed1e29b0df72903f2304e49)

Upstream-Status: Backport [from commit eb6d89e9e6]

Signed-off-by: Philip Lorenz <philip.lorenz@bmw.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit eb6d89e9e6f27b683da6f2ba2227707a965a0094)
Signed-off-by: Michael Siebold <michael.siebold@gmail.com>
---
 bitbake/lib/bb/fetch2/gitsm.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/gitsm.py b/bitbake/lib/bb/fetch2/gitsm.py
index ba62517f08..5c98991480 100644
--- a/bitbake/lib/bb/fetch2/gitsm.py
+++ b/bitbake/lib/bb/fetch2/gitsm.py
@@ -123,7 +123,7 @@ class GitSM(Git):
             url += ";name=%s" % module
             url += ";subpath=%s" % module
             url += ";nobranch=1"
-            url += ";lfs=%s" % self._need_lfs(ud)
+            url += ";lfs=%s" % ("1" if self._need_lfs(ud) else "0")
             # Note that adding "user=" here to give credentials to the
             # submodule is not supported. Since using SRC_URI to give git://
             # URL a password is not supported, one have to use one of the
-- 
2.34.1


