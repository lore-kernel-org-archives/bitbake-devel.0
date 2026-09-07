Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8C5C79F89
	for <webhook@archiver.kernel.org>; Mon,  7 Sep 2026 13:10:41 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34331.1788786637758692842
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Sep 2026 06:10:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ILvP+6lm;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49d05d51553so15413345e9.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 07 Sep 2026 06:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1788786636; x=1789391436; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eiFig5tqMHGxaT9fhbtlb2ML9JN1onVtkW3iRJR+wnE=;
        b=ILvP+6lml+L1QvDuEQTQ9A5gVtpeG7+JHEEXr65SP0YyKJxUx7dpcFOgVZgVQQr5UT
         pEvzpGkShOAXlFr3jI81uISiT5rLrwWuuoiosLrr9nZM/RNPcEj1ItQfX8fhCCIwgo/C
         hj94H5wA8ac1B88z7Iyc9bybZDWStBj8srgMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788786636; x=1789391436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eiFig5tqMHGxaT9fhbtlb2ML9JN1onVtkW3iRJR+wnE=;
        b=gZEdtzKgsKJ96TtZrWDU3MqFjVJiSRAutvoDg+QoBczw1vxiJIyfacMdKoGZb734sj
         vjipG/UPjf03YQLP1NYaB9VBRG+o3coIrIgudUpzLH2hMf/0bqZcsMEIhHcnB4d3lyku
         JghTDk27Xef9zNQP3f4luj5+BD84CfQV7m45Y/EDlyCbY0lwdCHHztvOiVfVpbIrl+N3
         hdHkqyp+73U0zORUmL5qGrtaXhEYwprnhSFqLGd652uq4Ulq+TMsN+0nC5nlCtjMRWw0
         0mn6xs9Cnp+RR8fgr4QnZcIaiBWBG/OhD+tAUr2K+JVwRyPqJMESf31HmkKQtkPazge+
         Bz8g==
X-Gm-Message-State: AFuF++mJ52++wOIzDeHHYkMFJhvPqKCLAHqbVoi+1ce44kHLtS7zL79c
	/wuoO3qYuOSyn6HmN1Ki6A3ik70FoG7f3MRhap1O43ExPk5bx9UTHzAJTokus3GQDJIaHnxs/nT
	mcdcBEOE=
X-Gm-Gg: AYBFou1gHRvoCMEUmdvrg35lQTyvYdK6Wj6pL6NdFQAkCFEUIqBKAUw56J3FoBPnE9A
	b5o6QTg0AeMXenX33TkpoicjYMtJWV6OeAlaF/QJN45UpWYwdA/FS0nRbLHCnSbi33RmAoMTqNC
	/+DIRbfgoYyUf0JTF0fKrRZkDK7ZAmuFA5ZTL0lIL9bIHxvKHl8tQky/0of1Z3pb+zU3G5hDYLT
	/OCj+NadhxjGGLxv031XImojDp0oHIJbC+OUYzjb96DCD4V+JG9LsihJgVydtvmv1K2FOQBpevu
	6A8Hh/y9Ha4LtDoTGqu9gyCPmU9tcB4+0KDSGGabULrs0py9p5LG/bSOaXaj7yprJQjt5muattc
	m51KriEb2YWLCSvmthYOC/Po0v1I7iv2yEeQpOVZB5GboZxj7W5LLh92nbjDergXmQEMZuBWwCt
	xlfxRARafeiT3aySOEYDw6WWj6gtgSOtujWRtVFZcs76qSnan7NpE1F7bMDAgNdZOdJB8wr0a+a
	TDV4MmfJC/PvIkRwg==
X-Received: by 2002:a05:600c:83c4:b0:499:db6d:bc97 with SMTP id 5b1f17b1804b1-49cf7f5058emr229592825e9.0.1788786635860;
        Mon, 07 Sep 2026 06:10:35 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:e2ae:fec4:d03e:3153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf770fcf5sm307037555e9.6.2026.09.07.06.10.35
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 06:10:35 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] fetch/gitsm: Store the original url data to fix relative gitsm paths
Date: Mon,  7 Sep 2026 14:10:33 +0100
Message-ID: <20260907131034.3989354-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Sep 2026 13:10:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20159

If the gitsm:// url contains a git submodule with a relative "../" path
and the fetcher is configured to use a premirror, it will fail as the
host name encoded in the original url is lost and the correct paths
can't be found.

Save the original url data in the new data so that it can be consulted to
fix this kind of edge case.

The test case change that follows this provides a test of this functionality.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch/__init__.py | 1 +
 lib/bb/fetch/gitsm.py    | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch/__init__.py b/lib/bb/fetch/__init__.py
index 153700dfb4f..55ab710f3d3 100644
--- a/lib/bb/fetch/__init__.py
+++ b/lib/bb/fetch/__init__.py
@@ -1059,6 +1059,7 @@ def build_mirroruris(origud, mirrors, ld):
                     newud.setup_localpath(ld)
                     if hasattr(ud, 'unpack_tracer'):
                         newud.unpack_tracer = ud.unpack_tracer
+                    newud.origud = ud
                 except bb.fetch.BBFetchException as e:
                     logger.debug("Mirror fetch failure for url %s (original url: %s)" % (newuri, origud.url))
                     logger.debug(str(e))
diff --git a/lib/bb/fetch/gitsm.py b/lib/bb/fetch/gitsm.py
index 734b35364d9..d9facdd2706 100644
--- a/lib/bb/fetch/gitsm.py
+++ b/lib/bb/fetch/gitsm.py
@@ -88,7 +88,10 @@ class GitSM(Git):
 
             # Convert relative to absolute uri based on parent uri
             if  uris[m].startswith('..') or uris[m].startswith('./'):
-                newud = copy.copy(ud)
+                if hasattr(ud, "origud"):
+                    newud = copy.copy(ud.origud)
+                else:
+                    newud = copy.copy(ud)
                 newud.path = os.path.normpath(os.path.join(newud.path, uris[m]))
                 uris[m] = Git._get_repo_url(self, newud)
 

