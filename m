Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56A8C10F1E
	for <webhook@archiver.kernel.org>; Tue, 20 Dec 2022 15:16:13 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web11.52654.1671549367414948382
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Dec 2022 07:16:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=YKpvi/QX;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id ja17so8978396wmb.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 20 Dec 2022 07:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JLt2c4IDRxacKvW3U0bB7ZZwge/xqtMUqoLIHNZIJRQ=;
        b=YKpvi/QXCm89Lavr90imme0+xcco9isbUnzOLSki+N7JmP+NH7xIZhcvc2GMDskymY
         NIbQ3SFa3HZ8JUIs3uRKw1p/kcLguQNRa9P8J2jXpISbHxv3/eeNAzatxnkoooPRMbc5
         WqS4kkIirwMULrhdCz1JpvhrHenENLPGcdB0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JLt2c4IDRxacKvW3U0bB7ZZwge/xqtMUqoLIHNZIJRQ=;
        b=GAsPtULq2o1l1RfsVV0EBeOW8U1tuJGL9+BhkQhrhaFLG5UZhWn3TGhxKy481oC29Q
         eGDBXN/RY3DIfAFkEB42yV1KYDDJFrL1tT0B+HeV1lKL3P0++Sg5X8GNUqJeOXDa8eUn
         qKNIUSQcwGrYXYfr+/jytJxVhGNHoIY6zCBfazapMrpBwGo0wvLS/n86z6DbfLyzm1mO
         +0hAgKoN/gqmdq4OnaCV6+y/fPcu+2YX9tx12T6nmZd61DeDfLruuguJCQ6VElDtY9sl
         wDpk3RJqYJ5Ha6jEXhzvEpoMr3FYbn/NR5fkkS6Urjzkvx+K8H13nnx2lyfd8CbW/APK
         hCUg==
X-Gm-Message-State: ANoB5pm0ut+1k55s4euLB2Ughy+sSzjATh/YXznpQDkdLI2MDio1/gOJ
	hCs/skZCooxi4osqHmkSChNTXy4klpspJ/o1
X-Google-Smtp-Source: AA0mqf5X4yyryzY7OsjJviMdXz127UCMOq7y9g+azzzYItkZWQ5kyC3Tx2OkxiA13VBCZql1SAUquw==
X-Received: by 2002:a05:600c:26cb:b0:3d2:1d51:246e with SMTP id 11-20020a05600c26cb00b003d21d51246emr29475268wmv.9.1671549365719;
        Tue, 20 Dec 2022 07:16:05 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:1273:dbb7:632c:a9de])
        by smtp.gmail.com with ESMTPSA id k12-20020adff28c000000b0022e57e66824sm14896439wro.99.2022.12.20.07.16.05
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 07:16:05 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/6] siggen: Minor code improvement
Date: Tue, 20 Dec 2022 15:16:00 +0000
Message-Id: <20221220151604.415637-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221220151604.415637-1-richard.purdie@linuxfoundation.org>
References: <20221220151604.415637-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 20 Dec 2022 15:16:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14209

Tweak the code to remove duplication and only set if the attribute isn't
already there to avoid overwriting.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/siggen.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index f551c74890..0e79404f76 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -273,11 +273,11 @@ class SignatureGeneratorBasic(SignatureGenerator):
         super().setup_datacache_from_datastore(mcfn, d)
 
         mc = bb.runqueue.mc_from_tid(mcfn)
-        setattr(self.datacaches[mc], "siggen_varvals", {})
+        for attr in ["siggen_varvals", "siggen_taskdeps", "siggen_gendeps"]:
+            if not hasattr(self.datacaches[mc], attr):
+                setattr(self.datacaches[mc], attr, {})
         self.datacaches[mc].siggen_varvals[mcfn] = d.getVar("__siggen_varvals")
-        setattr(self.datacaches[mc], "siggen_taskdeps", {})
         self.datacaches[mc].siggen_taskdeps[mcfn] = d.getVar("__siggen_taskdeps")
-        setattr(self.datacaches[mc], "siggen_gendeps", {})
         self.datacaches[mc].siggen_gendeps[mcfn] = d.getVar("__siggen_gendeps")
 
     def rundep_check(self, fn, recipename, task, dep, depname, dataCaches):
-- 
2.37.2


