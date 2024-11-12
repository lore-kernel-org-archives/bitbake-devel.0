Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8155FD597B0
	for <webhook@archiver.kernel.org>; Tue, 12 Nov 2024 22:01:20 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web11.99349.1731448873512007171
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 12 Nov 2024 14:01:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=MpjUqtpT;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.53, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2d1858cdfso4751447a91.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 12 Nov 2024 14:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1731448873; x=1732053673; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XVb1izzWsQw5GSVM+t/ZEoCeNBovJI6PjIK5Vra8IEE=;
        b=MpjUqtpTmMG5kQEDXe5yqeWkxJbtZmtfenOX3rqGhIfZMcneyMpicuJRsz5c8kJR3Q
         BLhUUuQyGtk9B657ioNz1aFC9306qxZ5aP1DT9DnZvoI9z3GhCHsbiCu+RMi18v/YvkY
         H13hGQUUuf9cGye6x8gTpCQ/6WCa86KExCkkMlwsc02mbVj+Ty35ZPTYAOLJbmIeKod5
         aK5xga6E6zJha7wBojICKHXXxxWVYcTUFOy34LH1XOpsyGVA35fMyYiTft/ejw3runLb
         gc8cLveGZJyx45Pr3Bc/CSgLVu/Q7WelqeSKKig/4KmUj8qi4MNWOcoFP2mKlIs4Xtkt
         FvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731448873; x=1732053673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XVb1izzWsQw5GSVM+t/ZEoCeNBovJI6PjIK5Vra8IEE=;
        b=cbDgpf9nb9U+qn7Dqva9hX+hKAisTthb6uUWvPG6QGbiUq1I5YvTfOKBQkSytIj42E
         m/3vCK8fXUGgPOJVrvwLvgXun2Cdnev/Dw76oT5hWOLe+AsfDd0mwEERpgmASchkDKsV
         7Hgwk+bgWOYSlbM0rYjoH7yuOE0nGPqyQVgHhGhtj8N/sOLmGJXfjlkIjERmDpBY6tsH
         9Oiae4GKEyHhTnXdu99bC7orMgNm5NXAw5gbZojOdPJKqCJ2vYA/bA899OQ1+AG+nUqA
         4Z9U84n9YLUv79+HO52tKEbaX5YbM6b9m6FyESYYYEnRm7qdwx3dP7XPKYguyhUhcAxX
         l/xg==
X-Gm-Message-State: AOJu0Yz5qY6osrahrBM0ICD+fTtwfFRwKbS12RgEiC5fum4J1Q97ukXk
	w5/GHuH+GjgceJHdCHHT0JhIrjsW65agYHrQVr/Yw1/h4CHhFzgjC8CVMwzsZYRPlim7f3YPqAB
	p
X-Google-Smtp-Source: AGHT+IF1gsyDtYNnXfrhgMvnlJCx48QhSd/vlxZPIK9oD/rNWQWwdf4USMjLjp/Gpgt4UQwmBTtBvQ==
X-Received: by 2002:a17:90b:2b4d:b0:2e2:af05:71b9 with SMTP id 98e67ed59e1d1-2e9b1713cf4mr24042896a91.9.1731448872589;
        Tue, 12 Nov 2024 14:01:12 -0800 (PST)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9f3ef36d6sm29332a91.33.2024.11.12.14.01.11
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 14:01:12 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 0/1] Pull request (cover letter only)
Date: Tue, 12 Nov 2024 14:01:05 -0800
Message-Id: <cover.1731448811.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 12 Nov 2024 22:01:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16792

The following changes since commit 0c30e9aadd30fc6f0dcf811eb8340687b52eb00b:

  tests/fetch: Use our own mirror of mobile-broadband-provider to decouple from gnome gitlab (2024-11-02 09:45:13 +0000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.0-next
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.0-next

Philip Lorenz (1):
  codeparser: Fix handling of string AST nodes with older Python
    versions

 lib/bb/codeparser.py | 46 +++++++++++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 13 deletions(-)

-- 
2.34.1


