Return-Path: <eric.meyers15310@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C11C28B30
	for <webhook@archiver.kernel.org>; Tue, 11 Mar 2025 12:29:00 +0000 (UTC)
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com [209.85.160.195])
 by mx.groups.io with SMTP id smtpd.web11.7718.1741696137181943600
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Mar 2025 05:28:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=dNu2ffgq;
 spf=pass (domain: gmail.com, ip: 209.85.160.195, mailfrom: eric.meyers15310@gmail.com)
Received: by mail-qt1-f195.google.com with SMTP id d75a77b69052e-471fe5e0a80so44763571cf.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 11 Mar 2025 05:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741696136; x=1742300936; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPXxWmvFSFfGCZPNn6AN9g5t7XbDz3tYCQZBhjjmT+s=;
        b=dNu2ffgqn6cpM16/z6DGyq6bKuiMfS+dv+BYmdftCh6FIimGrPRPMd2wcupUXmc+un
         xDSwKVJjpdXg0sA5UcLRv5ArlP4DUTDzWAQuOZCtlySKFc1pIvJayHEhPqqjnovhBL+m
         NQrd/DrvWpyex5ti8TcEaKlfx1Y4vx62zgrGLpaybXwUDGiCqysV4bNtQU2NlZKM3Cva
         aeFjscZEgr+9Lgww55zx7eOyrRAzAnIvPl2mJlTyYM0OBjnBnY6CZooU6XXc2txDhonP
         lNNtexhcMawYZbc5bGq+horf2kHgkVZlA+4l0EcjFR6vgB9+PoqfgSr9Whlw/Mr70bIB
         o9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741696136; x=1742300936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wPXxWmvFSFfGCZPNn6AN9g5t7XbDz3tYCQZBhjjmT+s=;
        b=PcwGUTPpcm6CvUER0yiMU0c0QTmzj/RY0SWdsP9NLv72hiXpb+180ZEwN5YGKol6W9
         Yy1LmrA/KaSaqrAw7GtNTs0swB2/s8OqbnLPk70jV52s5uOQTtVtN/EQoOTzLzVNvlqg
         IVRqlt/syt3/9NJ+jCNa/eD+OKFtidHFBL2f0lBtsn0S2/fNkIcuwMys5j8DiauIqgWj
         zVfqARNy6CKYbFkATc1kh6KlPny3pesr1BidjA3NHDAZul7vW4cdRHll/+Bdjz4mww/5
         rx7TMaB3YwbAB9y4xemeLr2uidKv1hiMXJZ1NjBLpReSOkwHg94JpfXjOunC6jRu0Nec
         GpKQ==
X-Gm-Message-State: AOJu0YyZIdXjYfITTs9EgKxvFXt0pZ+p3G4dxwl/ZK1gimD9/vDTvi9A
	qqgsHJGY/eswSosvvA1S1AWZJ+O1G7vfbHgLGy/rnj8YePD7PpXKU0FYOS29
X-Gm-Gg: ASbGncvmjBxln4nXJ06+3KelOTQCa4dgzrRWegSHwOT/SqYzXGkFWqo1Pq9S6k/FYrs
	wEbEnRnZf25dvpApMWCWbWutHL7/3xUFG9fUsYpqiv7UmuiWq9nGCH0hlGafBqaZvI+rys3yrEd
	gEnnpI0j1WUL1kY3iKNi8y+D+rI7likoMXrAwJL1/V0XfGrAu2GOaCCBjXBqg1iLtYwpDPvHoFP
	zs8G1J5mLIDqklVHOL15xVVAl14Fj761Y+RA7rqlDKjQbYtzzLuPAjfR3dyf3uyCA5QDWVOBpMJ
	a1SazELAu/2GqpyewdqOV5eaKhZiUmGV+tJxhsREt/s8NJ7sniz00FjpXZad5+uz7Qn5Zw5w/Z4
	IsHaP7m96/QnREwdd9gzEKbAnI1ty8d9/toW4SHF83Q==
X-Google-Smtp-Source: AGHT+IEVISDJrENQqkUOZjQKGnW2smi1zJgpgk0mp6KN43yV9lcbM2Tms/JNjsCDmhk/PcUTTDuhwg==
X-Received: by 2002:a05:622a:1a83:b0:476:91d8:230e with SMTP id d75a77b69052e-47691d82646mr89361911cf.52.1741696135923;
        Tue, 11 Mar 2025 05:28:55 -0700 (PDT)
Received: from 6543eb6661e0.yourbase.domain.local (c-73-168-239-54.hsd1.il.comcast.net. [73.168.239.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476905e344esm23876391cf.46.2025.03.11.05.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 05:28:55 -0700 (PDT)
From: Eric Meyers <eric.meyers15310@gmail.com>
X-Google-Original-From: Eric Meyers <eric.meyers@arthrex.com>
To: bitbake-devel@lists.openembedded.org
Cc: Eric Meyers <eric.meyers15310@gmail.com>,
	Eric Meyers <eric.meyers@arthrex.com>,
	Geoff Parker <geoffrey.parker@arthrex.com>
Subject: [bitbake][styhead][2.10][PATCH v1 2/2] doc: bitbake-user-manual-ref-variables: document BB_USE_HOME_NPMRC
Date: Tue, 11 Mar 2025 12:29:01 +0000
Message-Id: <20250311122901.13820-3-eric.meyers@arthrex.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250311122901.13820-1-eric.meyers@arthrex.com>
References: <20250311122901.13820-1-eric.meyers@arthrex.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Mar 2025 12:29:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17431

From: Eric Meyers <eric.meyers15310@gmail.com>

Signed-off-by: Eric Meyers <eric.meyers@arthrex.com>
Cc: Geoff Parker <geoffrey.parker@arthrex.com>
---
 .../bitbake-user-manual-ref-variables.rst                   | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index f23fb7f2a..cf2be7cf5 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -699,6 +699,12 @@ overview of their function and contents.
       Within an executing task, this variable holds the hash of the task as
       returned by the currently enabled signature generator.
 
+   :term:`BB_USE_HOME_NPMRC`
+      Controls whether or not BitBake uses the user's .npmrc file within their
+      home directory within the npm fetcher. This can be used for authentication
+      of private NPM registries, among other uses. This is turned off by default
+      and requires the user to explicitly set it to "1" to enable.
+
    :term:`BB_VERBOSE_LOGS`
       Controls how verbose BitBake is during builds. If set, shell scripts
       echo commands and shell script output appears on standard out

