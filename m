Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24A0FA375B
	for <webhook@archiver.kernel.org>; Fri,  2 Jan 2026 19:35:00 +0000 (UTC)
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11909.1767382493331681227
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Jan 2026 11:34:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=c8Msjthn;
 spf=pass (domain: gmail.com, ip: 209.85.218.67, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so2927953966b.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 02 Jan 2026 11:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767382492; x=1767987292; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=al1eK+6nxmcg9F51WnioPT5hkud6ZCJmeW2+a6c7LgQ=;
        b=c8MsjthnNzwCSC/UiBjs/wbGs9U/VWQrKBP2a1ZVujOdf5EyQBFMXflCcHTa3z5u/l
         +/hdeA+NB92DLJV3rXMgLsH9YdFK/S/X63+RW30I7I9osy4HmsGbr6nFwJcMED9zYSir
         lpwJz2e6XTiKfX/1FjVgqQ7UZiXyle6nzkiMH11DsWBcXtzOpxa/S5SBZg+i66ymcZ4d
         HYmpkFdUbY4RlLjDGDdq8JOzh0BIKa1uI7eJlG2mPiDzGMbUvp3IlPCHzrBlPSMcksQD
         vDxCviOe8faUBy44qjwf+ZgSghgLjCz/+SlrYAQwTqlPDDq+7K+kBwOwH46Osa8yZ1xH
         R5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767382492; x=1767987292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=al1eK+6nxmcg9F51WnioPT5hkud6ZCJmeW2+a6c7LgQ=;
        b=TQOfCXdnMy7kDxKWNnvVMTnfA94fQH8icF5HLVY5upDycGIzoLNRQ7nO0puHRkYRuf
         aCP2XuqHMPc1W8jX5qdTeWokLlOLHkw1lqFoIOc7zQi/YOqCDWJpUAAxf0GMJm+oa9Mr
         gRZ4jqkACLJx/sNpNAE62dH80jwejdo8fMAnDLZs4Vyp+vzvqNZ0aEtgc5dNGai5Tj/B
         wcnGkqJ387baLuGp3pCXUldU4XQoU5FUcXXImM1yCLv0CeT0FQqIBV0gcKiW8lRHwZGz
         TMGXP0tY0nM4la9YjO0o1BqpktAUz7LX6FFMlpJ24r1JmivUYAuVnMSkxaS5AWVwXNOU
         3ihg==
X-Gm-Message-State: AOJu0YyWOb0zMetWieij3iVeHYhFjBkpP1EVR/tRM+MegKVrvFu3ja01
	t3rDCKXVdtguYqICpITFl+AMgGjRGr/n3ezSJ4PPoxFP4GmfZBQrvf2cCPv1mlbB
X-Gm-Gg: AY/fxX6ELe1hm2pqT2ZmDsVig1BugObRJCX8hoBWUG+nl7GY3yuKDzuwBKfm9wBWB4n
	RsmPCrnj9xFLeJQLLfuFEXc5QXqbdCL5EqbK75J7xTuiNpxDV0MQ8mZ664ln02WfXzYJlywZMKC
	lCfJmvO+1SHUGQYt384ny3mRbfrtjGgFMK93VSnq+aYqHODPq2uALPgGSwjmtsYR4sDOCv/JCZn
	8zEhgQvnYAmuetkKs0s2APn80e5wABLX7iGJmndOKGCpUwHvJInyuhVebu9uwMkdf9IFrj+MsE1
	x0fuu+UMfgDRHCCS4yc6C8GWBlzfBj1bnohM5dTIjoHt28l3rHBNVKX9AsfHyAOY/UvHYBKkxAZ
	MaOAanr8YxaTMV0UiyiMcWZlZSx/qd35qfcMni8IQFUrXNoO4bMb/Ab1YqMYqaGIa9XCpfylbeB
	RDOLa70fBzDd+B1a+sQblwM/q8pOsuDc1b9Wtm5WIO4dP5TN8=
X-Google-Smtp-Source: AGHT+IHp7k53KUA6emMgsUhoNsOwvndPXt6K+ByKPR6Az3+ddvQFKNwWmimVh1T9dOKZSVjvPApUSQ==
X-Received: by 2002:a17:907:26cb:b0:b73:4aa5:35e5 with SMTP id a640c23a62f3a-b8036ecbabbmr4229677266b.7.1767382491549;
        Fri, 02 Jan 2026 11:34:51 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037de11e5sm4645615866b.39.2026.01.02.11.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 11:34:51 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 09/10] doc: document fixed revisions override in bitbake-setup manual
Date: Fri,  2 Jan 2026 20:34:36 +0100
Message-ID: <20260102193438.2960561-9-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260102193438.2960561-1-alex.kanavin@gmail.com>
References: <20260102193438.2960561-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 02 Jan 2026 19:35:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18679

From: Alexander Kanavin <alex@linutronix.de>

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 .../bitbake-user-manual-environment-setup.rst | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index ec1bdeecd..68b2ad31d 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -938,3 +938,49 @@ Here is an example file that overrides the branch of the BitBake repository to
 -  The ``sources`` section contains the same options as the ``sources`` option
    of a :term:`Generic Configuration` file. See the
    :ref:`ref-bbsetup-section-config-reference` section for more information.
+
+.. _ref-bbsetup-fixed-revisions
+
+Fixed source revisions
+======================
+
+:term:`Generic Configuration` can set source revisions in ``rev`` to a tag or a branch.
+Bitbake-setup will make sure the actual revision will match the tag or branch when performing
+initializations or updates, and will capture the revisions in a :ref:`_ref-bbsetup-source-overrides`
+file.
+
+The file is named ``sources-fixed-revisions.json`` and is available in ``layers/``
+or ``config/`` under :term:`Setup` directory. It can be used to keep record of
+what was checked out when using configurations that do not specify exact revisions.
+
+Also, as it is an override file, it can be combined with the original configurations
+to initialize a setup in a reproducible way that guarantees an exact, never-changing
+set of revisions.
+
+For example if the original configuration had specified only a master branch
+for a source::
+
+     "bitbake": {
+         "git-remote": {
+             "remotes": {
+                 "origin": {
+                     "uri": "https://git.openembedded.org/bitbake"
+                 }
+             },
+             "branch": "master",
+             "rev": "master"
+     }
+
+
+the override will contain the exact revisions::
+
+     "bitbake": {
+         "git-remote": {
+             "remotes": {
+                 "origin": {
+                     "uri": "https://git.openembedded.org/bitbake"
+                 }
+             },
+             "branch": "master",
+             "rev": "720df1a53452983c1c832f624490e255cf389204"
+     }
-- 
2.47.3


