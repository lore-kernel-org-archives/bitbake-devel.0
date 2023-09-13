Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB39EE0207
	for <webhook@archiver.kernel.org>; Wed, 13 Sep 2023 19:04:43 +0000 (UTC)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
 by mx.groups.io with SMTP id smtpd.web10.5891.1694631878657386164
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Sep 2023 12:04:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20221208 header.b=Xpy0Tw3F;
 spf=pass (domain: gmail.com, ip: 209.85.210.41, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6c21b2c6868so94165a34.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 13 Sep 2023 12:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694631877; x=1695236677; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUin14fISFg19MOl7eIkGuqX9loHF/cc/odzpfhuAkA=;
        b=Xpy0Tw3Fv2prCuW+gwrCqoFDxwawPWS7Mwe/6aTWsSPrNhIhqM9iiZq6TQnpJIQEaP
         bLjyRiE1pGMoJ9pVXwhGr0vX7ivGvRGAQpOeTfhCmEVhlnVcOKdHIItZpxsllhP+pYaC
         9EFGZVXKF9ljm2/G5jhS7yHCNPR3huF2KORo7hI2qrn+XoQI1BLKZ5jARAmGpc6T9R3n
         7C1VotaVnZrJ76HtZLbP9hObV8OhxNn9ZIy2t/i0P7vcmZmUgw75aUWvZmwzWidzoawH
         gmQQ3SsKI4jLqHwWQ8blD0bkwEHv6Ccm4YfwN2zrDWnpHzJOjcUt3pTuHynZ4jtMdR4n
         TBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694631877; x=1695236677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BUin14fISFg19MOl7eIkGuqX9loHF/cc/odzpfhuAkA=;
        b=Sfej9oJ/V6ciiCc/R0VOL3R07qFtLDD9c4VqsfClZ71Mcfdx013vrc7oDjV0YzcfNj
         leObXas45JdKNaux9Ik5dIopBWKKr9JTneRvyD+xk3NzZeKITawWpxvDeZi1BgZkl4N8
         QyKe1dAEu9sMPNCmRNfvpLWb+AI67U6EvtuPTAaq7qJ18XQiC7LqEU532zBjODsW/O40
         5ISb4FZ2bNotKiHAiUU7LfSYR5S87fVYp5IFs9Salt6jtSQF1F4gX/AZhP0gqzaUtcMP
         V5yYZsc46nr0P+jRSEW4bJqaZiWzlCOYNRIivWPOEhtnkIjO7y61J93cBsKhnSqTM7vf
         TS0A==
X-Gm-Message-State: AOJu0YzooyjPPMhWEDB1T5YJreyhtYN9wWIqvzswimwI0RUuh5PcPiIv
	HjgskvFjNVd6Af3x5dCGppJ6h5MWN4Y=
X-Google-Smtp-Source: AGHT+IGgyrMGPmvpYxrOVJ0OSoNGpNqyeDfvBq7yzlSKy50zZNqURg0svH3uVW2XUog3XJPgnfIOMQ==
X-Received: by 2002:a05:6830:1d3:b0:6b9:b600:536 with SMTP id r19-20020a05683001d300b006b9b6000536mr4047924ota.27.1694631877247;
        Wed, 13 Sep 2023 12:04:37 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::88cf])
        by smtp.gmail.com with ESMTPSA id f16-20020a9d5e90000000b006b83a36c08bsm5189593otl.53.2023.09.13.12.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 12:04:36 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH 2/2] fetch2: git: Use path_is_descendant() instead of path for repo check
Date: Wed, 13 Sep 2023 13:04:25 -0600
Message-Id: <20230913190425.3761792-3-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230913190425.3761792-1-JPEWhacker@gmail.com>
References: <20230913190425.3761792-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 Sep 2023 19:04:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15057

Using path prefixes to check if the git directory is a descendant of the
clone directory can be easily confused with symlinkes and bind mounts,
causing directories to be deleted unnecessarily. Instead, use
bb.utils.path_is_descendant() which is immune to the these sorts of
problems.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/fetch2/git.py | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index e11271b757a..4385d0b37af 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -373,20 +373,17 @@ class Git(FetchMethod):
             try:
                 # Since clones can be bare, use --absolute-git-dir instead of --show-toplevel
                 output = runfetchcmd("LANG=C %s rev-parse --absolute-git-dir" % ud.basecmd, d, workdir=ud.clonedir)
+                toplevel = output.rstrip()
 
-                toplevel = os.path.abspath(output.rstrip())
-                abs_clonedir = os.path.abspath(ud.clonedir).rstrip('/')
-                # The top level Git directory must either be the clone directory
-                # or a child of the clone directory. Any ancestor directory of
-                # the clone directory is not valid as the Git directory (and
-                # probably belongs to some other unrelated repository), so a
-                # clone is required
-                if os.path.commonprefix([abs_clonedir, toplevel]) != abs_clonedir:
-                    logger.warning("Top level directory '%s' doesn't match expected '%s'. Re-cloning", toplevel, ud.clonedir)
+                if not bb.utils.path_is_descendant(toplevel, ud.clonedir):
+                    logger.warning("Top level directory '%s' is not a descendant of '%s'. Re-cloning", toplevel, ud.clonedir)
                     needs_clone = True
             except bb.fetch2.FetchError as e:
                 logger.warning("Unable to get top level for %s (not a git directory?): %s", ud.clonedir, e)
                 needs_clone = True
+            except FileNotFoundError as e:
+                logger.warning("%s", e)
+                needs_clone = True
 
             if needs_clone:
                 shutil.rmtree(ud.clonedir)
-- 
2.34.1


