Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E52C54EBE
	for <webhook@archiver.kernel.org>; Tue, 10 Jan 2023 09:08:44 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web10.99489.1673341723407117391
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 Jan 2023 01:08:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile-fr.20210112.gappssmtp.com header.s=20210112 header.b=Zn0C/Q2F;
 spf=pass (domain: smile.fr, ip: 209.85.128.52, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f52.google.com with SMTP id z8-20020a05600c220800b003d33b0bda11so640403wml.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 10 Jan 2023 01:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7DW/u09C3Z7vWb2lBo8GG9aHFcP+g8zHXO3fWt15qac=;
        b=Zn0C/Q2FNqrB45sajDJcPtzpEXuziBLTmjSJP85kZJusLBFZJhl+itiuTVkNR5LEoU
         qqw4r2bifPC1UQ0q8KTXy3HsAN/dFPotsthtuxJHup8QrSpnYDSX0oWkBVBbREVrBjHq
         RGL6tDvPvn7PUiB+xFbZgVz8DxZ27NwOwWC/dXwAM3RVN4n3IufTTiWSX/qGl1otfYOX
         fyDq/HUs/ibmrbVKdiiTNNEWPtGn41KEfyi0DdTVYEkAEzIQeQivCgrU3js9QGpnn1oe
         aRhkXF9LG+zV1NOFjZN49TR99BJSvYgUEIXUBYWmBYJtMG8P/YE0VSEWoEvYTR35zYQ9
         uayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7DW/u09C3Z7vWb2lBo8GG9aHFcP+g8zHXO3fWt15qac=;
        b=IAZOIdhqJY9NvIfMJo+8zXpsmEzByp8Y0MNl5L3zh6uI08q4ds7k4qrKliu0cI8xK2
         JzdBb+AghLNMi17gnROBl3Xl7tA1YbeE75443qLiUWQOwh7nVTnXJiG4AqcPrul/SqCq
         C/dZAUFgtoQ4ZvDvEW+PN2RZT3yCmAE1E5K31GMjjBbGAvOw7020eC5P22J68b59Jubb
         ZDkkto0avboz43VCker8DCqTyUsi1+BaCqXLam/63DkX1Mz6Fxjb2wrMh+mk3xikr61Y
         9CXnhvOHd477ExfT/a3Qb9BvRridhiq6GieynB8a/g7V44v9V/qV3QtiZF5vltbNpSeb
         8yIA==
X-Gm-Message-State: AFqh2kpnn3gBBI9MJaZodiUl00fJsqB4s1UCgp/dczLxoA7O4hM0a7GL
	hJrQf7kI9VXnUxnlDTmTdaw0dFW1I/TjJ9JD
X-Google-Smtp-Source: AMrXdXtDFl3KRxH2V5hCTzlunwOIGsSiIwLoqDBna/uPfCCxbjVa80duD3iRQ7l7jVfHeIUZ0o3o7w==
X-Received: by 2002:a05:600c:3509:b0:3cf:93de:14e8 with SMTP id h9-20020a05600c350900b003cf93de14e8mr47954864wmq.39.1673341721302;
        Tue, 10 Jan 2023 01:08:41 -0800 (PST)
Received: from P-ASN-ECS-830T8C3.numericable.fr (89-159-1-53.rev.numericable.fr. [89.159.1.53])
        by smtp.gmail.com with ESMTPSA id j18-20020a05600c191200b003d9dee823a3sm14861694wmq.5.2023.01.10.01.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 01:08:40 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [PATCH] Move --buildfile help at the end of "Execution" group
Date: Tue, 10 Jan 2023 10:08:11 +0100
Message-Id: <20230110090811.558394-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 Jan 2023 09:08:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14295

Often, '--buildfile/-b' is used to mean "Do not execute anything but
this recipe", so it make sense to have it in the "Execution control
options" group.

Fixes [YOCTO #12018].

(Original suggestion by Ross Burton)

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/main.py | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/lib/bb/main.py b/lib/bb/main.py
index 1c87a02d..92d8dc02 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -136,10 +136,6 @@ def create_bitbake_parser():
                         help="Execute the specified task (default is 'build') for these target "
                              "recipes (.bb files).")
 
-    general_group.add_argument("-b", "--buildfile",
-                        help="Execute tasks from a specific .bb recipe directly. WARNING: Does "
-                             "not handle any dependencies from other recipes.")
-
     general_group.add_argument("-s", "--show-versions", action="store_true",
                         help="Show current and preferred versions of all recipes.")
 
@@ -227,6 +223,9 @@ def create_bitbake_parser():
                         help="Set the exit code depending on whether upstream floating "
                             "revisions have changed or not.")
 
+    exec_group.add_argument("-b", "--buildfile",
+                        help="Execute tasks from a specific .bb recipe directly. WARNING: Does "
+                             "not handle any dependencies from other recipes.")
 
     logging_group.add_argument("-D", "--debug", action="count", default=0,
                         help="Increase the debug level. You can specify this "
-- 
2.30.2


