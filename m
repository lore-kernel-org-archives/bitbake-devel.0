Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web11.33448.1601900832326121706
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 05 Oct 2020 05:27:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=ft1xOxm1;
 spf=pass (domain: linaro.org, ip: 209.85.221.41, mailfrom: nicolas.dechesne@linaro.org)
Received: by mail-wr1-f41.google.com with SMTP id n18so1520301wrs.5
        for <bitbake-devel@lists.openembedded.org>; Mon, 05 Oct 2020 05:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4x3zcuYyKEaqK9SfZFX3zJOTWlH3lrmYPqnQ4vYNTFM=;
        b=ft1xOxm1vIreueIVswOiBBhO5A8jRbWp0uhouYn9umIKbQcsTYfn7nTZf8vI1IFDcR
         XxTeHfsjyoHqq27wDxdkUS0e8/U7Da9ZV8EpusqzWWUT0bM8CWGZ4Hxee1wvITVOxGX+
         slaWwmBzBVFDnIem5T/7Apjn3D82PGJaOCEgLO2iBn5VS57L5wy4Y0YTa339jqf7tsnY
         oUA+2Kigw4gc9JIiUM2p7NJlKIS2fcDblRxydoKxUAjWRK5Nh+insMkHALmSgbPnRWxx
         d0LQhYEG/XTgumSTeYQWBl4ydMeyQhORopCm4ABPxxdueG8hwOCp7R1qY2aa0jqEudi5
         CHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4x3zcuYyKEaqK9SfZFX3zJOTWlH3lrmYPqnQ4vYNTFM=;
        b=AaakdkZjmo484jOXnoAl6I77DbnpRyCT3iLBGsiiqjaQ9KyW7mBfdKlqF2r1NpS5sy
         T9/Fhhf1i2DVGqgrUTexvO8yvcaKJh5qstB/8cascuEY7m5ah2QrYm0AH4iQT1I/hI/I
         eo/rQ9p+8+4v0x+o0hVE+1jQoBWtHiRNYnxyGUo3CteTTmDEdK3dh98PgPcbnbfamYaG
         DXjY13W2lwVFHYRzLl2bgtLsV/Ie5UhkDXp/UnL/FyyUjfhDLF++lpBJeeEKOY3XXafF
         HjhMGOM0Ynl9Jqx4mgAPIy3Qap5xcJjSh1yu7rRQhj0GvHloFXVVxlIng1pVCv3LYYBf
         TW5w==
X-Gm-Message-State: AOAM530VY04c7fCyw0SXt0Su4zX3OA/ZLB2gb/UNRK+3Xq/UgXC2FTXL
	PzeyB9lDoD9nsGKv+CuTK7338aY3JlSTIQ==
X-Google-Smtp-Source: ABdhPJxSnR+yOdWI2jGqKz55+9FrUkKmzUGuyPcZvReoF/MKGp2mdNNZPhMqPI79yJBwrwB0kDG6Yg==
X-Received: by 2002:adf:f74e:: with SMTP id z14mr5685733wrp.312.1601900830102;
        Mon, 05 Oct 2020 05:27:10 -0700 (PDT)
Return-Path: <nicolas.dechesne@linaro.org>
Received: from localhost.localdomain (82-64-249-211.subs.proxad.net. [82.64.249.211])
        by smtp.gmail.com with ESMTPSA id c130sm1953628wma.17.2020.10.05.05.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 05:27:09 -0700 (PDT)
From: "Nicolas Dechesne" <nicolas.dechesne@linaro.org>
To: bitbake-devel@lists.openembedded.org
Cc: foss@0leil.net,
	Nicolas Dechesne <nicolas.dechesne@linaro.org>
Subject: [PATCH 0/5] A few sphinx docs cleanup
Date: Mon,  5 Oct 2020 14:26:47 +0200
Message-Id: <20201005122652.392528-1-nicolas.dechesne@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mostly inherited or inspired from yocto-docs.

Nicolas Dechesne (4):
  docs: ref-variables: add links to terms in glossary
  docs: sphinx: replace special quotes with double quotes
  docs: update README file after migrationg to Sphinx
  docs: sphinx: report errors when dependencies are not met

Quentin Schulz (1):
  docs: static: theme_overrides.css: fix responsive design on <640px
    screens

 doc/Makefile.sphinx                           |   4 +
 doc/README                                    |  50 ++--
 .../bitbake-user-manual-execution.rst         |   4 +-
 .../bitbake-user-manual-fetching.rst          |   2 +-
 .../bitbake-user-manual-intro.rst             |   2 +-
 .../bitbake-user-manual-metadata.rst          |   8 +-
 .../bitbake-user-manual-ref-variables.rst     | 246 +++++++++---------
 doc/conf.py                                   |   8 +-
 doc/sphinx-static/theme_overrides.css         |   2 -
 9 files changed, 175 insertions(+), 151 deletions(-)

-- 
2.28.0

