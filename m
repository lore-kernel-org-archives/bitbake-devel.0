Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC039C48BC4
	for <webhook@archiver.kernel.org>; Sun, 18 Feb 2024 20:08:04 +0000 (UTC)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
 by mx.groups.io with SMTP id smtpd.web11.25648.1708286875305453746
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 18 Feb 2024 12:07:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=GsDkF+18;
 spf=pass (domain: gmail.com, ip: 209.85.166.48, mailfrom: jpewhacker@gmail.com)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7c74d3ab471so15189539f.2
        for <bitbake-devel@lists.openembedded.org>; Sun, 18 Feb 2024 12:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708286873; x=1708891673; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9TlY0HddgRvd9UmSbvEcJj3PB47sgsyY74orLyNM7S8=;
        b=GsDkF+18Wmtmjfaf+d3mvebi4dAM5WVqnukEx83Xp/WRMDbKYnuT/YVG/bF0U58tBp
         Kd8GxWqxw7+K8OxQ4duGE67twrbkjd0skd0TJpneFjsVwyR7xkoZJUIHYm5qrkUtdGl4
         CppbTFH9erAxxlnBrsIqj5jstSeYJKgeN3aRpsG/gvCWQf0z1LcOl/VHj+6ij9MuehqO
         9XKD/xzlZEchjXAvopb+OREBZ7Vsr7yJ9v8Efc8xZgvOz6p2EFBZ0RlCfSVbGLYGS0LI
         LA0N+INmpVOWAJXXY07vsT6yUfCApuym9BjQXMfTHBv/7FLkItcyLc4VWodL1FdwLH/7
         gxiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708286873; x=1708891673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9TlY0HddgRvd9UmSbvEcJj3PB47sgsyY74orLyNM7S8=;
        b=mAXno4cyGoMn2jC0+w3dEYTOgrv6Kl3E0Ez2n0L+Ov02glI68vKkhOAWEHn6wCA1LG
         guNWsG8hBG5VWKKXquhiIu09Q5yHi8Wtw72cJqzO/V8QWN5dr+Ddh5NIlBTj5ukzgKiX
         0jvhlXC6wNjzgZHltpotUtoSsu50/WDj35TQuWlrSxGm2H5z9Cr86MAWmh53NzPSV+H6
         vqkx26jFwDqLrfJLCIjjXKNpKcCeRMHTSwLHto+NXWdLHwYNXxs9uvhXmflbiVqX6G5T
         8+aQ7VS326Fm72E2yYy+b3urWy5ITi1MDfij/IJJ8b01tC2SpZ4U4ivk6zHwbsAhInyE
         WTTg==
X-Gm-Message-State: AOJu0Ywhc9Wa7LbdobW0geO3zgN/kBN75tFcydujua0OF8GVSLLqeF+T
	uXPstMstxurEIdOo8xAu/k0tVWGusOKcmy3wgi61Zlqp227byR0E5NStqTyP
X-Google-Smtp-Source: AGHT+IG6HtZIkq6Y2inObqE743UIFRmg7fVOFgedzEUIjyD0MxcgA6AVCmjPen4dZopyl9dgJMUS0Q==
X-Received: by 2002:a6b:ea05:0:b0:7c7:21f6:575c with SMTP id m5-20020a6bea05000000b007c721f6575cmr6798003ioc.21.1708286872921;
        Sun, 18 Feb 2024 12:07:52 -0800 (PST)
Received: from localhost.localdomain ([2601:282:4300:19e0::44fb])
        by smtp.gmail.com with ESMTPSA id u6-20020a02aa86000000b004741e1544b6sm549278jai.81.2024.02.18.12.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 12:07:52 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH 0/5] Implement parallel Query API
Date: Sun, 18 Feb 2024 13:07:38 -0700
Message-Id: <20240218200743.2982923-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 18 Feb 2024 20:08:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15916

Implements API to allows querying if a hash exists in the server, and to
do so using multiple connections to the server in parallel. This will be
used to query if an sstate object exists before actually looking for it
in the sstate cache, which is important for e.g. on a CDN where negative
lookups are expensive

Joshua Watt (5):
  hashserv: sqlalchemy: Use _execute() helper
  hashserv: Add unihash-exists API
  asyncrpc: Add Client Pool object
  hashserv: Add Client Pool
  siggen: Add parallel query API

 bitbake/bin/bitbake-hashclient      |  13 ++
 bitbake/lib/bb/asyncrpc/__init__.py |   2 +-
 bitbake/lib/bb/asyncrpc/client.py   |  77 +++++++
 bitbake/lib/bb/siggen.py            | 121 +++++++----
 bitbake/lib/hashserv/client.py      | 124 ++++++++++-
 bitbake/lib/hashserv/server.py      |  61 +++---
 bitbake/lib/hashserv/sqlalchemy.py  | 306 ++++++++++++++--------------
 bitbake/lib/hashserv/sqlite.py      |  16 ++
 bitbake/lib/hashserv/tests.py       | 122 +++++++++++
 9 files changed, 618 insertions(+), 224 deletions(-)

-- 
2.34.1


