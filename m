Return-Path: <jstephan@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7EBCAC583
	for <webhook@archiver.kernel.org>; Tue, 17 Sep 2024 15:12:09 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web11.23264.1726585921850971576
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Sep 2024 08:12:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=F4YZ/Vtq;
 spf=pass (domain: baylibre.com, ip: 209.85.221.48, mailfrom: jstephan@baylibre.com)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-374c1963cb6so3935917f8f.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 17 Sep 2024 08:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726585920; x=1727190720; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pv7e0sGC1l0h5Ll+Vi3W74JJBqa0XDkRfIut8LaE9qo=;
        b=F4YZ/Vtqme/z3oeZRozleKaU611qLXhI6ZbnHXhRTX+fu807tUgyIJJZaJ1/Vd0qg4
         f6/+iY4yor4mO7ZUeazAdAzAzPIjQI4fU0zVZqCQ2KVYlRiylT+dGB7lrnncW72/GfQg
         gnpDBSmjDmdy/v3sI/wIJbSKYD/SAUj7lWz/UwthHv+D1vQtiI4qyw8TrAj3D9YQ7IqD
         1JyUxK/U1EzB2QLGycnVuDb+vOM/g0vpTuxFRRLbg5CMtpFDHsLarjeodf3H7lJIKvxB
         MSZKr8czamaM7LnOI9RJV8FKT3Poqv/OTY9rxFFCCtSKPscc0q7ssvYCzA5dPamoy0N+
         WURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726585920; x=1727190720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pv7e0sGC1l0h5Ll+Vi3W74JJBqa0XDkRfIut8LaE9qo=;
        b=sSogOsgON7uRDZqenXU5EK1drNd2mTdsZ6xSoJIgOGKzC5VBOzM3AcixEEUNMbW5Kq
         NP0wfs9DTk1zplEQgp0oAN/lZkzFnBaTfE9w2s5dgB32YlZj2nt2bIG/PuKceo1ryxdn
         GnHM9j+66v12HVmkxc+jnMc2zvN+VfN6BUX5W9AMOGzGsAi8JQd5qHz70Y2dz3+dEwCs
         fqGGVqOEeLLYV13f9es0lSFTsR9Ddd0HXpRehOBC4MsHy6o/2JfxE+2e1Uz0gdW1puiN
         4kyla4qfm07ih6wpalD2xqu4XTb+6XQyKesqA1cY4JbvtndeT3KS4c38W4akqKel3MEq
         IhPQ==
X-Gm-Message-State: AOJu0YxQFtJbqVGANHjm/KAO5J6q/9oFlvet0K5Wf51ZviCd0wHuNFG7
	HNt4hfaqxdDG/7fHuEj8oS+PTJ6Rgvy8qNiDofnhejA+MOGrNH0/2HzRPQ9XsuGjTY887PsjIJL
	r7Cs=
X-Google-Smtp-Source: AGHT+IGYA+aIW9ZqWjSFgmvpBTeu+Bcs0hU++I1lU83N/rqgT+zT8T5VqW+/Be1kudZ8o9el8+SPhg==
X-Received: by 2002:adf:ec07:0:b0:374:c61a:69b8 with SMTP id ffacd0b85a97d-378c2d058abmr11371299f8f.15.1726585919658;
        Tue, 17 Sep 2024 08:11:59 -0700 (PDT)
Received: from localhost.localdomain (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net. [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e71f068esm9897307f8f.3.2024.09.17.08.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 08:11:59 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
To: bitbake-devel@lists.openembedded.org
Cc: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH 1/2] bitbake: add documentation for "bitbake -S lockedsigs"
Date: Tue, 17 Sep 2024 17:11:56 +0200
Message-ID: <20240917151157.780068-1-jstephan@baylibre.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 17 Sep 2024 15:12:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16565

The following commit added "lockedsigs" as new signature handler for the
-S option of bitbake:
    2cf13f25139 - lib/oe/sstatesig.py: dump locked.sigs.inc only when explicitly asked via -S lockedsigs

But it was not documented anywhere, so add some basic documentation for
it in both the .rst documentation files and the help message of bitbake

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 .../bitbake-user-manual-execution.rst               |  6 ++++++
 .../bitbake-user-manual-intro.rst                   | 13 +++++++++----
 bitbake/lib/bb/main.py                              | 12 +++++++-----
 3 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-execution.rst b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
index d58fbb32ea0..ac1e2a76811 100644
--- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
+++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
@@ -592,6 +592,12 @@ compare the matched signatures to determine the stamps and delta
 where these two stamp trees diverge. This can be used to determine why
 tasks need to be re-run in situations where that is not expected.
 
+The third signature handler that can be passed is "lockedsigs" that will
+conveniently write the task signatures in a file called "locked-sigs.inc",
+that can be included in user's configuration to lock recipes or tasks.
+User can include the whole file or extract the signatures needed to lock
+only selected tasks or recipes.
+
 .. note::
 
    It is likely that future versions of BitBake will provide other
diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-intro.rst b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
index 35ffb88b026..127c662320b 100644
--- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
+++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
@@ -398,10 +398,15 @@ Following is the usage and syntax for BitBake::
      -S SIGNATURE_HANDLER, --dump-signatures=SIGNATURE_HANDLER
                            Dump out the signature construction information, with
                            no task execution. The SIGNATURE_HANDLER parameter is
-                           passed to the handler. Two common values are none and
-                           printdiff but the handler may define more/less. none
-                           means only dump the signature, printdiff means compare
-                           the dumped signature with the cached one.
+                           passed to the handler. Allowed values are none,
+                           printdiff and lockedsigs. none means only dump the
+                           signature, printdiff means recursively compare the
+                           dumped signature with the most recent one in a local
+                           build or sstate cache (can be used to find out why
+                           tasks re-run when that is not expected). lockedsigs
+                           means generate a locked-sigs.inc file containing the
+                           locked signature of all tasks needed to build the
+                           target.
      -p, --parse-only      Quit after parsing the BB recipes.
      -s, --show-versions   Show current and preferred versions of all recipes.
      -e, --environment     Show the global or per-recipe environment complete
diff --git a/bitbake/lib/bb/main.py b/bitbake/lib/bb/main.py
index bca8ebfa090..1f4313fa0dd 100755
--- a/bitbake/lib/bb/main.py
+++ b/bitbake/lib/bb/main.py
@@ -215,11 +215,13 @@ def create_bitbake_parser():
                         default=[], metavar="SIGNATURE_HANDLER",
                         help="Dump out the signature construction information, with no task "
                              "execution. The SIGNATURE_HANDLER parameter is passed to the "
-                             "handler. Two common values are none and printdiff but the handler "
-                             "may define more/less. none means only dump the signature, printdiff"
-                             " means recursively compare the dumped signature with the most recent"
-                             " one in a local build or sstate cache (can be used to find out why tasks re-run"
-                             " when that is not expected)")
+                             "handler. Allowed values are none, printdiff and lockedsigs. "
+                             "none means only dump the signature, printdiff means recursively "
+                             "compare the dumped signature with the most recent one in a local "
+                             "build or sstate cache (can be used to find out why tasks re-run "
+                             "when that is not expected). lockedsigs means generate a locked-sigs.inc "
+                             "file containing the locked signature of all tasks needed to build "
+                             "the target.")
 
     exec_group.add_argument("--revisions-changed", action="store_true",
                         help="Set the exit code depending on whether upstream floating "
-- 
2.34.1


