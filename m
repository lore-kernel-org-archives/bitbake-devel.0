Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC64CC4332F
	for <webhook@archiver.kernel.org>; Tue, 22 Nov 2022 23:08:20 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web11.6915.1669158492486005874
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 22 Nov 2022 15:08:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=6YWAscNd;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.46, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f46.google.com with SMTP id 71-20020a17090a09cd00b00218adeb3549so294960pjo.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 22 Nov 2022 15:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWraxGIGzPP73dJSlTmVEQMC9J1kyd0y2H4g63wfaxA=;
        b=6YWAscNdwlRG9wK8Hl54C8lLBSuGMJWB8PRja2ofRhcDkJ9HpsstLY9swClnrPdqzr
         Sqx3Q5Y61osflEmEfI8Ug6nOX2+Hqrs0RdiIEgJ2Z8FCoPiIXA3EtZDlFf6xZMgdR0f9
         zBhW2ygDD93Cm99yumuzuBwZYW5ZLH1P+zVZeS15RrfNYXV53Ryy42ErMt27DKfP22EM
         telzLViRbED/GnaBbzOUSItrLxjuCrHaMYx0/18kL9dSoEkcrqrQEETDyATIdqpzSe72
         rddhbWHtR4s95Z8r6eIRCWrWQwtn5XbnCUn54ALooqFQBDi11TSc0nCQxSHjxNxSp4Uw
         9MnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWraxGIGzPP73dJSlTmVEQMC9J1kyd0y2H4g63wfaxA=;
        b=GvFyX3IiGNsUai21hySI1E+OWuW8gYiAj2WAXhJEAOlZBHxIiX2plYuTx7AfYaG3nn
         Zw80EMUcSSNDTWaEYDtIqQcCUyK9FnO3Az6O4UyeOGKWBvu/9K2RAi2fmLZjYqEAHcvz
         Xk+o+yrnYXN5PfJi6ZffdHB5syUlogmnPU+ikAcPDl92Use+iTu1civ+bi8GRLOMyRmH
         SlDrFMwNVWJBb6ydnIVCXgiQPbaJ0sHjtuTa5Bt26FvtBFl2md0X6YT+BRa/qIvtCA8X
         DBnsNXBPLwhl3mjeII2gZY125YYFrhYt0D0aGgRzp+Dgmp87Bo9kojAuUhqsQoBauA7G
         Cnew==
X-Gm-Message-State: ANoB5pm8dnQ1seKLs7X26o00EgEHaSfC5PZuEXG2nWjW4/Zol1du/0R0
	J0frML3Z/XDv63FXEGL3SPFoNkmx7LElDLJMu0Y=
X-Google-Smtp-Source: AA0mqf4J2HvZawlvjIjjJXnZm8LgdKPJtXasaV4khFo0prPkmC92mmL+xnNn2NzDkgZ/nNCfeEUcPA==
X-Received: by 2002:a17:90a:6f47:b0:218:910a:124b with SMTP id d65-20020a17090a6f4700b00218910a124bmr20123430pjk.16.1669158491027;
        Tue, 22 Nov 2022 15:08:11 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net. [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id p22-20020a170902a41600b001890cbd1ff1sm8581476plq.149.2022.11.22.15.08.09
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 15:08:10 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/2] Pull request (cover letter only)
Date: Tue, 22 Nov 2022 13:08:03 -1000
Message-Id: <cover.1669158342.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 22 Nov 2022 23:08:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14097

This should be the final pull request for the 3.1.21 release.

The following changes since commit 8ea8e443005ad92f4ad264d9abd9e90e33fb5c17:

  tests/fetch: Allow handling of a file:// url within a submodule (2022-10-27 16:38:59 +0100)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/1.46-next
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-next

Richard Purdie (2):
  utils: Handle lockfile filenames that are too long for filesystems
  utils: Fix lockfile path length issues

 lib/bb/utils.py | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

-- 
2.25.1


