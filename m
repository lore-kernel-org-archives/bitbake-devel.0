Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F5ACD6E52
	for <webhook@archiver.kernel.org>; Sun, 31 May 2026 18:27:58 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12245.1780252071709472966
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 31 May 2026 11:27:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=AKeGFpf9;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490a765f47aso4853825e9.1
        for <bitbake-devel@lists.openembedded.org>; Sun, 31 May 2026 11:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1780252070; x=1780856870; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K9X7cGqUK8AmAgRDoJtLn3MCtDvT1QTgn7YxTpdXFBA=;
        b=AKeGFpf91/kHTotrOs3gCCE4E6gk1ryZu1SnSf11WpYM7MNNMIaUiNq3y5TLDsGdEZ
         6ItXjJDgiZ0PnoDrZ8IMHQBBNEmcxb3m73iHlCwrQY0uprqq4RjNPdeW+cL3+J96YhDc
         84Jnf2uyhq2bE/tAUtWFSj93PCnOaOc6zCSVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780252070; x=1780856870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K9X7cGqUK8AmAgRDoJtLn3MCtDvT1QTgn7YxTpdXFBA=;
        b=Bo+CO4y0gYEivX+R35UQED+/35ZpInTfBgHsQ9gUZAbZsqFes0eF+NcyCNs4+7a6RD
         //zam3Qtpi7pnMTa0ocAdX6gzGZ3Uxv0mHLVJLbWFMMC0f8hEAugqgHcrw4h8ltAIrPq
         ImsBn2EA4sfvKcRyURAO4utAvzwQbRZhrUsm7lupsuqWniNakq/3rdEX1oAai7+PuDI3
         CaUD2TsOzXd1swlsov5wXLLfKLDnzy5FoGUHmd/KNbPtNY6IN0pNk3neWE8GhQ9eCLrY
         uJe3qM5PMNVXp6EGcBsvvWFrraKcTO06xfunvm1EIC7PJ+IxMOgP4b8LehueqUDhDNV0
         A0Ng==
X-Gm-Message-State: AOJu0YwmYzlUmhVr3P5UgQNXYxyUFEQEb9QpYmpUIkWwcBxHxbkcn0X/
	QwNS72Jq3zvoq9nIKjiR9JLp1z4ysUTx13fF1zduu7DB10ZRP4qYDY1+01mTmouooh1cOzTqcmW
	T4lLn
X-Gm-Gg: Acq92OGMnPNaA/3ZCouzFF9auFpP4LHeyM5shzML2E6GyYLgxkg+/UKdoKCaXjfj8VC
	PjIDgTCkOmdinTBLelk5hQIQL6/8doJsOQVAMXpDLmwRf5MfQ1W8aeAqO3AwlzNqxVsXgqDmiq2
	kqbBSZCGkEjAb5KolhLP+/f64zE/GwEbFpTB7rym3eNI1NDKt7v5fxVg0zL3J4fLi7pA2MRXjTl
	aK3YB4U3a5tHoSUayo4wy1OW4Q0BCYE3i1ZC5ThJ/xAlfErxe0KjlNcaV9ZTMd4W5UN548d8lt9
	j19MMtZYg8FFC1h9anmf4pyPp3iV9kUqv9PT0uF5bcy3zHazY+BXjVNs5NbeHnc+akkJG7E59mr
	VNmJ44CBvikPZfI/f6KAEZCksOft5O7ZkvbFsGAjq9E+sk0M9HZp+YxOsjO3MMH/4p42BDepQ8G
	TtGrPE2cLXfQhRKES36RG0AgYCg6OpJ74fKf7mE+wy9f3dX0b/SO7BXW3kKsjXrAYc6i9pHlR4d
	A==
X-Received: by 2002:a05:600d:8499:10b0:48a:525b:e148 with SMTP id 5b1f17b1804b1-490a29122d3mr109986635e9.4.1780252070077;
        Sun, 31 May 2026 11:27:50 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:229e:2449:eb7c:dbd2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354bb62sm18563488f8f.19.2026.05.31.11.27.49
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 11:27:49 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 5/6] lib/layerindex/cooker: Convert string commands to lists where possible
Date: Sun, 31 May 2026 19:27:42 +0100
Message-ID: <20260531182743.2412946-5-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260531182743.2412946-1-richard.purdie@linuxfoundation.org>
References: <20260531182743.2412946-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 31 May 2026 18:27:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19576

String commands have to be processed by subprocess using shell=True which
is suboptimal for all kinds of reasons, including quoting. Convert to use
a list where possible to improve efficiency and the robustness of code. It
also means copy and paste will be more likely to use the preferred form.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/layerindexlib/cooker.py | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/layerindexlib/cooker.py b/lib/layerindexlib/cooker.py
index ced3e063604..82d77335f9a 100644
--- a/lib/layerindexlib/cooker.py
+++ b/lib/layerindexlib/cooker.py
@@ -55,10 +55,10 @@ class CookerPlugin(layerindexlib.plugin.IndexPlugin):
         bb_path = os.path.dirname(bb_path)  # .../bitbake/lib/layerindex
         bb_path = os.path.dirname(bb_path)  # .../bitbake/lib
         bb_path = os.path.dirname(bb_path)  # .../bitbake
-        bb_path = self._run_command('git rev-parse --show-toplevel', os.path.dirname(__file__), default=bb_path)
-        bb_branch = self._run_command('git rev-parse --abbrev-ref HEAD', bb_path, default="<unknown>")
-        bb_rev = self._run_command('git rev-parse HEAD', bb_path, default="<unknown>")
-        for remotes in self._run_command('git remote -v', bb_path, default="").split("\n"):
+        bb_path = self._run_command(['git', 'rev-parse', '--show-toplevel'], os.path.dirname(__file__), default=bb_path)
+        bb_branch = self._run_command(['git', 'rev-parse', '--abbrev-ref', 'HEAD'], bb_path, default="<unknown>")
+        bb_rev = self._run_command(['git', 'rev-parse', 'HEAD'], bb_path, default="<unknown>")
+        for remotes in self._run_command(['git', 'remote', '-v'], bb_path, default="").split("\n"):
             remote = remotes.split("\t")[1].split(" ")[0]
             if "(fetch)" == remotes.split("\t")[1].split(" ")[1]:
                 bb_remote = self._handle_git_remote(remote)
@@ -118,14 +118,14 @@ class CookerPlugin(layerindexlib.plugin.IndexPlugin):
             layerbranch = "<unknown>"
 
             if os.path.isdir(layerpath):
-                layerbasepath = self._run_command('git rev-parse --show-toplevel', layerpath, default=layerpath)
+                layerbasepath = self._run_command(['git', 'rev-parse', '--show-toplevel'], layerpath, default=layerpath)
                 if os.path.abspath(layerpath) != os.path.abspath(layerbasepath):
                     layersubdir = os.path.abspath(layerpath)[len(layerbasepath) + 1:]
 
-                layerbranch = self._run_command('git rev-parse --abbrev-ref HEAD', layerpath, default="<unknown>")
-                layerrev = self._run_command('git rev-parse HEAD', layerpath, default="<unknown>")
+                layerbranch = self._run_command(['git', 'rev-parse', '--abbrev-ref', 'HEAD'], layerpath, default="<unknown>")
+                layerrev = self._run_command(['git', 'rev-parse', 'HEAD'], layerpath, default="<unknown>")
 
-                for remotes in self._run_command('git remote -v', layerpath, default="").split("\n"):
+                for remotes in self._run_command(['git', 'remote', '-v'], layerpath, default="").split("\n"):
                     if not remotes:
                         layerurl = self._handle_git_remote(layerpath)
                     else:

