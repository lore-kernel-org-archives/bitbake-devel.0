Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web09.10507.1606832088495018963
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 01 Dec 2020 06:14:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=DiGpkTn/;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.182, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f182.google.com with SMTP id u2so1187920pls.10
        for <bitbake-devel@lists.openembedded.org>; Tue, 01 Dec 2020 06:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=VxJ12EDsyQvkTlQd5NmjBQXHLWBtm6CXzIpxKjkLrGE=;
        b=DiGpkTn/HcePdl+hZNFG+cVaQV76fddtooYacBQA09MWrP4DWfmDFM/2a9JRkmANRM
         ZTcUfH3ykv+QXNGOjQ3KfePtZIiOBiuI8KsRe1fk3aBNFzmoPMUvjvCk40qIQrPUSOCK
         pgPGXVuwEmM2neqSQKxq/PgZySiMG1poU+tgOl0Mn0L86b3s9zP/5FDwn28IHG4og9KJ
         MggbT/1brk+PXBMa2OGyEU4PxrESqgLMWJ63EyxmqLaPXlgbQXJ9RKgiGTTN+pk+M1M7
         j/W29/7krOJudTFuORrLpYA6QYzSLRiVTL+i0SmFkccj8do2oC9Ul88fJiGANgdTpTnI
         jdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=VxJ12EDsyQvkTlQd5NmjBQXHLWBtm6CXzIpxKjkLrGE=;
        b=M1XDn95OoeuiqJJnWzpRGnbsESYil6NC8X+Hh1bfaWrVy35xzUbciVFIKMAgIZ5475
         TKQ93+8BUbQmMNrtMBijB0yj30iXcZkgIK2HSVMaoAxqoNfY9nTAmT2Y0FtnL0RcGx1N
         5uDDJ9q5p+wUZzVi8XVBVgYvun5mzzIn79/tiqfV6EDG6qpNEREoEpwb1RuLuX0yO0pV
         XhzzmKB7t/v/vdbbujHuStN5/WfS8BonMbGsAvx1Y8GG8lcD7qzJqz6OpuBDcRiM9Pmh
         zyfKOvVvuvP60M0aKzaS8FZb4Kpi/XUsZpwDUzRUyTbWemwFfGkJvdiZBEsTSulb1+Az
         LRVQ==
X-Gm-Message-State: AOAM532f9/+qFiStbaaXXcgZ6K0sPO429SevZzz40aThPyu7CPOHsNsD
	rQkZt+flEabdsC2Q1NQjnsa9b0oIflGouHGy
X-Google-Smtp-Source: ABdhPJxtlsD3MD3L8X/vAW/tiycWARPhoVKLY3ufVTeBKTYfEFTUanOS85A8LCxKZTEAinFj9wRakw==
X-Received: by 2002:a17:902:db85:b029:da:6661:35ab with SMTP id m5-20020a170902db85b02900da666135abmr2900984pld.79.1606832087311;
        Tue, 01 Dec 2020 06:14:47 -0800 (PST)
Return-Path: <steve@sakoman.com>
Received: from octo.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id v8sm2820352pjk.39.2020.12.01.06.14.45
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 06:14:46 -0800 (PST)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/1] Pull request (cover letter only)
Date: Tue,  1 Dec 2020 04:14:36 -1000
Message-Id: <cover.1606831737.git.steve@sakoman.com>
X-Mailer: git-send-email 2.17.1

Backported fix for: BUG id:14055 - [QA 3.2 M3 RC1] failure in oe-core manual test: test_dependency_explorer_is_launched
which is also present in dunfell 3.1.4

The following changes since commit 89fc9450abefd682266efcbfa031d1ef115ff1a7:

  tests/fetch: Update upstream master->main branchname transition (2020-10-26 22:18:43 +0000)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.46-next
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-next

Ross Burton (1):
  taskexp: update for GTK API changes

 lib/bb/ui/taskexp.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

-- 
2.17.1

