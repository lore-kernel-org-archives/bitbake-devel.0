Return-Path: <michael.siebold@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA197FCA18F
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 21:21:48 +0000 (UTC)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.25832.1773091303764532502
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Mar 2026 14:21:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=FkT4VuNJ;
 spf=pass (domain: gmail.com, ip: 209.85.160.175, mailfrom: michael.siebold@gmail.com)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5091d71aa11so13255461cf.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 09 Mar 2026 14:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773091303; x=1773696103; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PQA59VihzRC6NNs7DM1JbRhJyLHlUaiMHrpfdMnchI=;
        b=FkT4VuNJdXllUsmTZYmMRIgOKr7RYbZerxxmBhZHmYieE0LuggCXYv1h0EJuBxfI/+
         rs3qLeMJs/GKLJoV+TwvkYNcWA2ghrHA3JOBu9SuZHBZ7jM+4KipcBC+8jQT4k/uR8FX
         XIT4pf6/19jorFSDAN6VjqhDZP3kPQctxIiwCX1uiHELZ3byLtEhUDac1bRjTsb/g/GN
         3fKANoME27SwgNXohUQ4kHxhPHnz5gYk/M24Brg2M5x3XrKcDdEc2Liafw6W6wBPxzar
         sU+jXbH7G+haLCv9K3+BSiwwM+FQuyIXUn+ZO2lUoh6qOtIdUQ3SatilyOvLjBPDQMDK
         z9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773091303; x=1773696103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5PQA59VihzRC6NNs7DM1JbRhJyLHlUaiMHrpfdMnchI=;
        b=OL70G/500jMv6DIOe8tmG/FH/+XbvONj8VDSoebgnsi5LICBQISZdbDnhopri1v/HJ
         uMiNqenQMEPVsTQz4wLh6MSTgBZClyMdCHAkpMLUkHhGSpi0CmeoyNeS/ysmKjeWWhMv
         gGhpyNXbgbz0WhQ72cc8+KgC9jK5WgvXqZonLbiYEppVaDEk3bgWWBglZJRXycQimIQy
         Iv3327QWuKBTzDBSNBkTK7nkqO8KeTXnJ3ebSG7JDQZk4LlLmYzE3s5+0b5ceL93YG99
         is33OWIhovVIy9zaBtPPa9PAnkagUKvdw2QSCeu8rzqahrs/Ic/DaN+1zbPShdldkodE
         WKCA==
X-Gm-Message-State: AOJu0YykM8PI1Qww99QKFoAeSBIBtmP5+veMvuua7R9rplIfM4Wf1otj
	s22ZvbphrEyzZAbIHBzJ0WI5peX7lfPjLqB+nazIK9TZ3cctv59vPUe1
X-Gm-Gg: ATEYQzwZ+vApvCnBSzfMJPDegFRmf+3G0P6dXT9l2+7E91zV/nVW9VdGg/+0orJIf2Z
	27AWfqJZ0doDLIf60klBKf78j464RTgAiPuDi/gjfkv+pDXOH97qhL40iW+cygSsAQ4Dq6WlOrF
	gaS4ct6mkDD4qhHP3oCoZbLqzwgWSlhIvrqjjqm4VIOCpfJ4sKmXNSTqdXUtrAD1nI6vC/C6Cg3
	TlznHwkMY2rK5JtsiW0a6YXhMv3QCj88kh1NOsd85axLW3FhBQwopxUiwYDpAlx4Sz/mhoiihOq
	I/1U2z3qN9PTN1kOmSsZf148Rmj7obAC2FbnWSkl0ZwbUMrG0OWCq+siiw7z1ZfDOruu/4kPJh5
	GDo7Fkywh/NYAgtN2ZZJv2w9Hn+Wk+5dB5NL7Rb2VnXGltBmakRL//Uc2COAa8PAP3eICHg8JLw
	XAxDQ7/DZZWq8OtMdCHNaNjh9mpSn3ij3FQHY7euREvYPl9k8EqLa5fwxLWg==
X-Received: by 2002:a05:622a:198c:b0:508:fac4:76e8 with SMTP id d75a77b69052e-50925fcd216mr14900321cf.1.1773091302650;
        Mon, 09 Mar 2026 14:21:42 -0700 (PDT)
Received: from beeblebrox.pc.cognex.com ([143.170.79.157])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50924937718sm8522881cf.29.2026.03.09.14.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 14:21:42 -0700 (PDT)
From: Michael Siebold <michael.siebold@gmail.com>
To: Yoann Congal <yoann.congal@smile.fr>
Cc: bitbake-devel@lists.openembedded.org,
	Robert Yang <liezhi.yang@windriver.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Michael Siebold <michael.siebold@gmail.com>
Subject: [PATCH 1/3] bitbake: gitsm: Add clean function
Date: Mon,  9 Mar 2026 14:21:23 -0700
Message-Id: <20260309212125.3172717-2-michael.siebold@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309212125.3172717-1-michael.siebold@gmail.com>
References: <20260309212125.3172717-1-michael.siebold@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Mar 2026 21:21:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19127

From: Robert Yang <liezhi.yang@windriver.com>

Fixed:
$ bitbake utfcpp -cfetch && bitbake utfcpp -ccleanall

The downloads/git2/github.com.nemtrif.ftest won't be cleaned without this fix.

(Bitbake rev: 79f25fc5c1b8d0e08540f4aa07875309f5325f47)

Upstream-Status: Backport [from commit 5bce38fbae]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 5bce38fbaea0a7d1228740e2cb313957c914cfdf)
Signed-off-by: Michael Siebold <michael.siebold@gmail.com>
---
 bitbake/lib/bb/fetch2/gitsm.py | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/bitbake/lib/bb/fetch2/gitsm.py b/bitbake/lib/bb/fetch2/gitsm.py
index fab4b1164c..ba62517f08 100644
--- a/bitbake/lib/bb/fetch2/gitsm.py
+++ b/bitbake/lib/bb/fetch2/gitsm.py
@@ -249,6 +249,19 @@ class GitSM(Git):
             # should also be skipped as these files were already smudged in the fetch stage if lfs
             # was enabled.
             runfetchcmd("GIT_LFS_SKIP_SMUDGE=1 %s submodule update --recursive --no-fetch" % (ud.basecmd), d, quiet=True, workdir=ud.destdir)
+    def clean(self, ud, d):
+        def clean_submodule(ud, url, module, modpath, workdir, d):
+            url += ";bareclone=1;nobranch=1"
+            try:
+                newfetch = Fetch([url], d, cache=False)
+                newfetch.clean()
+            except Exception as e:
+                logger.warning('gitsm: submodule clean failed: %s %s' % (type(e).__name__, str(e)))
+
+        self.call_process_submodules(ud, d, True, clean_submodule)
+
+        # Clean top git dir
+        Git.clean(self, ud, d)
 
     def implicit_urldata(self, ud, d):
         import shutil, subprocess, tempfile
-- 
2.34.1


