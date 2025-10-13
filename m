Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124E0CCD18D
	for <webhook@archiver.kernel.org>; Mon, 13 Oct 2025 14:53:20 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web11.45885.1760367198523880370
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 13 Oct 2025 07:53:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=O22LLW61;
 spf=pass (domain: smile.fr, ip: 209.85.128.52, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e4f2696bdso44672395e9.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 13 Oct 2025 07:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1760367197; x=1760971997; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+tjiC5aqyRltYi+uq7g+kqbqV8A+U3g6Dlzlc/DP4fA=;
        b=O22LLW61l1y0HltItBzUSY2PHPQa+D/HWtLAc9AE0Iv2xC1GUgJDLc67nNX3vqZbQj
         6QEGX+RecVqGL/pTmwTe8BSWfZhSDP6c4Db3ZKERhGzZGuqvEatj4j+frj/3GcmgYJVd
         hD6L50+yLwNhvmV0bm3f9ubnMORRO2tLSruck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367197; x=1760971997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+tjiC5aqyRltYi+uq7g+kqbqV8A+U3g6Dlzlc/DP4fA=;
        b=iMszuVBnPFFeuJ0fxTsJjnpZKOK/sueQ1MCMi24nuplODN4AR8yZDfazLh74+iTvhO
         IZ4akUL69vDRDaVgfWY5ZXr6qIWi1cv2HOkzH0MNmbGO4sjGymMAFqe8twph9yZY/t1Z
         wpDrVbYlXTKI3vLMCeUmVEl/G3e6FHnpHvCzHE6cB8G5a0QsoaBm3wRIcqpRG331nW0g
         Jj4EY7MkqIR8RinwOV2YEKKjx1G4AsWDgUZ1cipl6SfO9lY+PR0zWGWU108E89HevFwr
         Ulx7emh2WWbCClqE9OYfpE+pCFpUWt073Bs05kE+DUVUSRHu5jCI82Wa4J3GjJRcHWfo
         mUhQ==
X-Gm-Message-State: AOJu0YzLx7KUUMCf2697VWB8IeX74+cpCbe1+QHfukcoix9ZnyqSihFu
	Gi9wwHRCwRCQM1ypsSuqJ4uykEYLh6r5DTWGAW4mlnVdK0YBqrYFun/uvRvxjTdLP0ccTm4BpSd
	wlUKovhA=
X-Gm-Gg: ASbGncvlxdP9HihMkwXTgtltuqlEmBAfxc6zaz/7jqEdiPpmhDRKaGs9I4sUZ7ON/u1
	qtfVoCxc8J096B5V+HonOG1Utfx834DJVKdw42rk/4AbQPKBCQT+dp1KaTac6aa4RTRvFgtRMIh
	0wFueog+K/rAAzMMK8Oj/DD9o2AohxPie1x8ujIuNFR3v/4+q2VTJEYh6MH+2eegDlpXZvVlzNm
	1QzY/TEErdj46CA/lgWLI9FdjESqSBwy0oeHlWsZYmmxTaGIehy5euhbKR7Oa20GNCoTIJesCqz
	w/EUQ+lhAJcRpeySEqlZqzlLyAAGYlpR38/hKxc44wC6Uzbf2ZjaZ1nqMflQuzuRTJdks7Og7k1
	0SPfJeUkFZ1gDqUfsTrVZhdyXuv6gzzT1Ysusx/0VPZ99EZNW22j5OwB2B8sRCNy/l+f4cteOVB
	iqAOfRKJGRndL+uvMHo+/okWbzE3NaQr46WNy5YK2XbBxRlZZo2n7nbQ==
X-Google-Smtp-Source: AGHT+IE7D91uRN0gsX1ozhzvZ4w0df1+h3LmR9/TzGnTxFv86OkP3KPd1CG6sXMrEg2Ph4aQPby8lQ==
X-Received: by 2002:a05:600c:a47:b0:46e:45ff:5bdb with SMTP id 5b1f17b1804b1-46fb4816974mr97103295e9.8.1760367196627;
        Mon, 13 Oct 2025 07:53:16 -0700 (PDT)
Received: from P-ASN-ECS-830T8C3.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab3d438fsm133282265e9.2.2025.10.13.07.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:53:16 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [PATCH] ast: Better variable history for builtin fragments
Date: Mon, 13 Oct 2025 16:50:34 +0200
Message-Id: <20251013145033.2903356-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 13 Oct 2025 14:53:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18181

From: Yoann Congal <yoann.congal@smile.fr>

As of now, the variable history for builtin fragments looks like this
(edited for clarity):
   $ bitbake-getvar MACHINE
  #
  # $MACHINE [2 operations]
  #   set ast.py:368 [check_and_set_builtin_fragment]
  #     "qemux86-64"
  # pre-expansion value:
  #   "qemux86-64"
  MACHINE="qemux86-64"
User can't know where MACHINE was set, this is bad.

This patch tries to reconstruct a MACHINE history from OE_FRAGMENTS
history.
With this patch, history looks like this (for a simple case):
   $ bitbake-getvar MACHINE
  NOTE: Starting bitbake server...
  #
  # $MACHINE [2 operations]
  #   set .../auto.conf:2
  #     "qemux86-64 (OE_FRAGMENTS contains "machine/qemux86-64")"
  # pre-expansion value:
  #   "qemux86-64"
  MACHINE="qemux86-64"
The path where the "machine/qemux86-64" fragment was added to
OE_FRAGMENTS is displayed, this is definitely better.

Fixes [YOCTO #15939]

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
This was previously sent as RFC:
[RFC PATCH] ast: Better variable history for builtin fragments
https://lists.openembedded.org/g/bitbake-devel/topic/rfc_patch_ast_better/115674103

But, with:
[PATCH v3] ast: Warn on multiple builtin config fragments for the same variable
https://lists.openembedded.org/g/bitbake-devel/topic/patch_v3_ast_warn_on/115686012

I think it is ready to be merged.
---
 lib/bb/parse/ast.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index cb06e8917..27adbd860 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -364,8 +364,16 @@ class AddFragmentsNode(AstNode):
         def check_and_set_builtin_fragment(fragment, data, builtin_fragments):
             prefix, value = fragment.split('/', 1)
             if prefix in builtin_fragments.keys():
+                fragment_history = data.varhistory.variable(self.fragments_variable)
+                loginfo={}
+                for fh in fragment_history[::-1]:
+                    if fh['op'] in ("set", "append") and fragment in fh["detail"]:
+                        loginfo["file"]   = fh["file"]
+                        loginfo["line"]   = fh["line"]
+                        loginfo["detail"] = f"{value} ({self.fragments_variable} contains \"{fragment}\")"
+                        break
                 # parsing=True since we want to emulate X=Y and allow X:override=Z to continue to exist
-                data.setVar(builtin_fragments[prefix], value, parsing=True)
+                data.setVar(builtin_fragments[prefix], value, parsing=True, **loginfo)
                 return True
             return False
 

