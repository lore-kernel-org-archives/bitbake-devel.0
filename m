Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5184EC433EF
	for <webhook@archiver.kernel.org>; Thu, 17 Feb 2022 22:09:48 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46])
 by mx.groups.io with SMTP id smtpd.web10.3290.1645135787369023303
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Feb 2022 14:09:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=dFw8lVHi;
 spf=pass (domain: konsulko.com, ip: 209.85.219.46,
 mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f46.google.com with SMTP id f19so11100665qvb.6
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Feb 2022 14:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pod8VbMhvxIzeFHVsEkEBfwnNZs6lOpxIJvFN/bJsnM=;
        b=dFw8lVHiHN5YgarU9Vwz0jrtX4C57tSo/HvtRExlAfYsFyGKTANS693morfGGlRxN+
         ohdFX1/uJeY2p4bXx32UAlVpyFfRzRv8xVA5FrkVqaI0YpQnVKAMWAaRc88yyQfOs7bt
         ruimGaOar9QmlOkIu4kJ9eMnmkjJXSXwX8EDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pod8VbMhvxIzeFHVsEkEBfwnNZs6lOpxIJvFN/bJsnM=;
        b=c3JB1II6n+kitE5cmWYVnum6F5XQDcFpLOGplgQyFhRCFwfXCgT2VcWf0quOitPQxb
         G8jHY86CxBmLLH2Zf8GrZ8TcV39WJUOoArbhYRFTdBKe+tCm4A5bPRk2eutyNW5oju6d
         bXuvogYp8o4a54oBEzZe+l1O0xHmFP1UpcTWcGXLFPVj5nKgH0pMvPS8RsCHcHhYN+C7
         uGGX1r+k8DqCmyWMIPv4UEKR3pavwIFafR8gSvmG1ot6qFe5Wz3IyqyxZtHMcAjvx7z5
         US+OzNIB3+UvRtwoi8aqvykWUb5+fnaTXe+x5mbhb04Pi2nOFu2G1/hp2S/t8HX+lOQV
         hfgQ==
X-Gm-Message-State: AOAM5300l7WxBqectu67iyZ+IL3HbP0wueBXBJ4uRBjjyFGeZbFJbeug
	OVYXRofkoUZXPFdWJKGVYRuCwDSgrfRpOQ==
X-Google-Smtp-Source: 
 ABdhPJzhxBBQYRY4pV/HynaUThspuuTSQ09g+ZLXcYM8ct6ls5z7THKJ3xGWfpALzK39VHxU+edhXw==
X-Received: by 2002:ac8:5ace:0:b0:2d8:c7fa:6f8f with SMTP id
 d14-20020ac85ace000000b002d8c7fa6f8fmr4176496qtd.410.1645135785984;
        Thu, 17 Feb 2022 14:09:45 -0800 (PST)
Received: from ghidorah.spiteful.org (192-0-174-222.cpe.teksavvy.com.
 [192.0.174.222])
        by smtp.gmail.com with ESMTPSA id
 q15sm5127572qtn.41.2022.02.17.14.09.45
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 14:09:45 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 0/4] Further inclusive language fixes
Date: Thu, 17 Feb 2022 17:09:31 -0500
Message-Id: <cover.1645135230.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 17 Feb 2022 22:09:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13360

A set of patches to address the remaining blacklist/whitelist/abort
clean up tasks in BitBake on the list at:

https://wiki.yoctoproject.org/wiki/Inclusive_language

The BB_DISKMON_DIRS change is the most user visible, and I'll
be sending corresponding changes for oe-core and meta-poky to
quiet the new warning with respect to it that Richard requested.

Scott Murray (4):
  Replace remaining "blacklist"/"whitelist" usage
  Replace "abort" usage in task handling
  Replace "ABORT" action in BB_DISKMON_DIRS
  Replace remaining "abort" usage

 bin/toaster                                   |  4 ++--
 .../bitbake-user-manual-ref-variables.rst     | 12 +++++-----
 lib/bb/cooker.py                              | 24 +++++++++----------
 lib/bb/cookerdata.py                          |  4 ++--
 lib/bb/event.py                               |  2 +-
 lib/bb/fetch2/__init__.py                     |  2 +-
 lib/bb/main.py                                |  2 +-
 lib/bb/monitordisk.py                         | 17 ++++++++-----
 lib/bb/runqueue.py                            | 12 +++++-----
 lib/bb/siggen.py                              |  2 +-
 lib/bb/taskdata.py                            | 10 ++++----
 lib/bblayers/action.py                        |  2 +-
 lib/layerindexlib/__init__.py                 |  4 ++--
 lib/layerindexlib/cooker.py                   |  2 +-
 .../bldcontrol/localhostbecontroller.py       |  4 ++--
 .../orm/management/commands/lsupdates.py      | 12 +++++-----
 .../toastergui/templates/projectconf.html     | 10 ++++----
 lib/toaster/toastergui/views.py               | 18 +++++++-------
 18 files changed, 74 insertions(+), 69 deletions(-)

-- 
2.35.1


