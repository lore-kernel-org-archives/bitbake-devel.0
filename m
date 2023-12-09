Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1835C46CA3
	for <webhook@archiver.kernel.org>; Sat,  9 Dec 2023 10:04:13 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web10.6948.1702116251575816730
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 09 Dec 2023 02:04:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=FuKWEq4v;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40c317723a8so19406165e9.3
        for <bitbake-devel@lists.openembedded.org>; Sat, 09 Dec 2023 02:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1702116250; x=1702721050; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h7zyPIB3XrK8aQlnCwanZ+LzsLreUWamnXpyC7Ox8VY=;
        b=FuKWEq4vvzPUZJ4S1l5RySMBizsRoHEoaVtSPaluXA8sCT5y646lwEIMxtdBkJSAhH
         1D5I/NPkXMIpn1BWXDajjT3o8gAdxaslUlw6gnFYLTGV5SVHlGe+tL33CorSdLSKVN6t
         6e5sw4HaUMWzOxM9aVmIR2RVyts84oxvxNoHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702116250; x=1702721050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h7zyPIB3XrK8aQlnCwanZ+LzsLreUWamnXpyC7Ox8VY=;
        b=E42VjGr55wRS+LOE1DYvIaccOkm58F75wc/p9/jX1SQFQpOBieElevgBtmI3idy4de
         6XdcwAKS4HFuZ1jnQRoDZO8OYYnq8jo7tGxP0ovRezo5Yr/86ugSOIk716DsL8PfeaG9
         i5mWNd5YjYWAYm4cEH9hK9kFgjl/rJ/MKwZZiN2mUMEutEMPmQI0PjAxcBh19MoXK3Cc
         proDBEitoI7c3bQY2aPnSd9YINiSyQpa60xen6qZf9dUiEamB8ZIANQcHYRh9mqSsSDL
         MA5+mx3pD6CgX55k6mQOF7bbHkmHxVTEJthqsUDnXgD4Z0/8N7ek8e7XqIpSMBL3ueHL
         QQkw==
X-Gm-Message-State: AOJu0YyJqG8FoywuEMWtobJdDC26A1TRVQsxzmJE5/x584q5BRe9rzJB
	+5I537M4Bfv8Po1VwmccKLVKlNBehLi+AHt/uz0=
X-Google-Smtp-Source: AGHT+IHbbm5If11fyg+sh19MOWLernDJkZar56xOMrmWLFQcr7WfeJnjkK92AjUZy9O2hwhiv6WlxQ==
X-Received: by 2002:a05:600c:2e94:b0:40b:5e21:d363 with SMTP id p20-20020a05600c2e9400b0040b5e21d363mr575711wmn.108.1702116249749;
        Sat, 09 Dec 2023 02:04:09 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:30e:3cdc:729a:15fb])
        by smtp.gmail.com with ESMTPSA id p13-20020a5d48cd000000b0033609750752sm3565550wrs.8.2023.12.09.02.04.09
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 02:04:09 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] toaster/tests/builds: Add BB_HASHSERVE passthrough
Date: Sat,  9 Dec 2023 10:04:08 +0000
Message-Id: <20231209100408.2187723-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231209100408.2187723-1-richard.purdie@linuxfoundation.org>
References: <20231209100408.2187723-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 09 Dec 2023 10:04:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15643

As well as BB_HASHSERVE_UPSTREAM, ensure BB_HASHSERVE is passed through
to allow sstate resuse on the autobuilder.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/tests/builds/buildtest.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/tests/builds/buildtest.py b/lib/toaster/tests/builds/buildtest.py
index bec933124c..cacfccd4d3 100644
--- a/lib/toaster/tests/builds/buildtest.py
+++ b/lib/toaster/tests/builds/buildtest.py
@@ -116,7 +116,7 @@ class BuildTest(unittest.TestCase):
         project = Project.objects.create_project(name=BuildTest.PROJECT_NAME,
                                                  release=release)
 
-        passthrough_variable_names = ["SSTATE_DIR", "DL_DIR", "SSTATE_MIRRORS", "BB_HASHSERVE_UPSTREAM"]
+        passthrough_variable_names = ["SSTATE_DIR", "DL_DIR", "SSTATE_MIRRORS", "BB_HASHSERVE", "BB_HASHSERVE_UPSTREAM"]
         for variable_name in passthrough_variable_names:
             current_variable = os.environ.get(variable_name)
             if current_variable:
-- 
2.39.2


