Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACCCC61DD7
	for <webhook@archiver.kernel.org>; Fri, 28 Aug 2026 21:33:43 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.690.1787952820842227651
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Aug 2026 14:33:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=eNvFwxXV;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso16873115e9.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 28 Aug 2026 14:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1787952819; x=1788557619; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CtFl+QN5SS92KXij4LqQGQvLBR4BypubXKuaJsGyUw4=;
        b=eNvFwxXVgIosfhN2xdBRzJ0pWIjnhIQaZsJXrh0r9n6HlDGzJMoxz+cAVEbl3RRVKp
         xBStAtBbxPeclG4C1H4jpKp0s3wqmmkV/jCRCyT6WxROwteLW3uUYiRZ8pIg126zJBmK
         S+MDXxy5qba4J+u7cCeYmmxRZhh05sUc9ne+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787952819; x=1788557619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=CtFl+QN5SS92KXij4LqQGQvLBR4BypubXKuaJsGyUw4=;
        b=AcTeNr1Gxm5o0yhniB/G/zthrLSWM7SoxtXn3e1o3cXIwLsZ3EewDc+HP8R+eYwg0m
         GoER4SYfasnNkK459Krfa/owVto1PMZAVF7hN83lwXLP+4EoToyuhn+b4rRA/7Kg38UJ
         NSVvlCCEzMXV0WbbxT/up12enyICU+nCo0TU+xk5hZY3MCcp5fNGjS/5VrfIYaEK5yHo
         xLRUQMFn8/aKQkfgFxZCZV24gSwZQlq0Xa+WgbnDFOdvfji3teYFF8X5K7VkIPu7LAiq
         YafSOt465hAF+GXzUYj5WmZBeIEUMiVRZ6O5bJare2wxZkoePhiN05R2R7QPsol9B4gc
         umrQ==
X-Gm-Message-State: AFuF++k1jjW8h0dMJ4h3ahoV+h2HJjpjyH2r4PH80t3XZtQjeCdqthOD
	yjV9K6pGzvWlx56xuxHZB/inZNT1/e+W7ZyPYEt+t0gXKQf+onrLVPOU5y+W6jx9WnKfD2NNF1H
	91sF9MMk=
X-Gm-Gg: AR+sD12YtClGssXMGjz59mqBc/6rjFe7p5huIBzI2fdz3smQezRV+7o2w1LGFudAUQT
	XmwMA4bkRRjRTl8ry0KOOOoZhVuRRZ838Xe90/ctMWDFtW7NqRk3Pb7I8wCxGFn8Oy5t/DAe0ue
	mL3Z7kyFco79JtOgvCr8SbrVLZWb7EKOxNHnYsSZJREVBxNCP7ckjZAJu5b33mLx1q0SgYeds2T
	R1P2q96Al15X3b82O6HMlG45vElnrkNPF2l9pI0yarXYmOo7C4jZWII6z3nhHxJCrCSdqKWlpXP
	2msgpRNG59shfKIj+B2eQI6ZO+irkEmyxgEABHRxsw13ytH9y87Vp7Re6zBXmYiaZkY2X2UBsfL
	H73HORs18xu/b3+8Hb0I1IbdGOYB0fxSDQgDcbkaNLT2tKjT1dEQaiCGmM15FWXwFLwm8F8IdyA
	QTsi97MdqyGK31Bf0Oe1SF2FImlQOtlVc/3If0XkBEigvvFnDlOi5TCEQQFufnWwkHxlXBXPwlZ
	8cgLbX1RCIWxQqDdg==
X-Received: by 2002:a05:600c:3b27:b0:49c:a2f3:fe9a with SMTP id 5b1f17b1804b1-49cca312bc5mr34050645e9.7.1787952819018;
        Fri, 28 Aug 2026 14:33:39 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:c3f1:c7b4:8368:83c1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b926874fdsm88321505e9.4.2026.08.28.14.33.37
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 14:33:38 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] toaster/orm/lsupdates: Improve error handling
Date: Fri, 28 Aug 2026 22:33:36 +0100
Message-ID: <20260828213336.2038983-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828213336.2038983-1-richard.purdie@linuxfoundation.org>
References: <20260828213336.2038983-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 28 Aug 2026 21:33:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20124

Recent layer index changes are causing a KeyError in this code. Rather
than crash and break everything, show a warning and move on, which unbreaks
everything else, just skipping the problematic distro entry.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../orm/management/commands/lsupdates.py      | 20 +++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/lib/toaster/orm/management/commands/lsupdates.py b/lib/toaster/orm/management/commands/lsupdates.py
index 153b26f60a5..1f36906eeef 100644
--- a/lib/toaster/orm/management/commands/lsupdates.py
+++ b/lib/toaster/orm/management/commands/lsupdates.py
@@ -226,14 +226,18 @@ class Command(BaseCommand):
 
         total = len(index.distros)
         for i, id in enumerate(index.distros):
-            distro, created = Distro.objects.get_or_create(
-                name=index.distros[id].name,
-                layer_version=Layer_Version.objects.get(
-                    pk=li_layer_branch_id_to_toaster_lv_id[index.distros[id].layerbranch_id]))
-            distro.up_date = index.distros[id].updated
-            distro.name = index.distros[id].name
-            distro.description = index.distros[id].description
-            distro.save()
+            try:
+                distro, created = Distro.objects.get_or_create(
+                    name=index.distros[id].name,
+                    layer_version=Layer_Version.objects.get(
+                        pk=li_layer_branch_id_to_toaster_lv_id[index.distros[id].layerbranch_id]))
+                distro.up_date = index.distros[id].updated
+                distro.name = index.distros[id].name
+                distro.description = index.distros[id].description
+                distro.save()
+            except KeyError as e:
+                logger.warning("Couldn't process %s (%s)" % (i, repr(e)))
+                continue
             self.mini_progress("distros", i, total)
 
         # update machines

