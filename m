Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
 by mx.groups.io with SMTP id smtpd.web12.12694.1606840026036213160
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 01 Dec 2020 08:27:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=EdBXBbMC;
 spf=pass (domain: gmail.com, ip: 209.85.167.51, mailfrom: ernstp@gmail.com)
Received: by mail-lf1-f51.google.com with SMTP id v14so5399972lfo.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 01 Dec 2020 08:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JYcvqCaQ3Nd7wlheHQcpraf3poMYXpd7Pjl2JOuJ90Q=;
        b=EdBXBbMCuwAQHrhAox97WBbfXyfmvQ1ZUplG+60nOGqdQYYnCSM8CGOye8XjDWrQsZ
         Awn7jWayPChuCAOs5pdNOmWO7WkaBwEUu1vXw7hv60JaIn0DxgQw7Xlb6lNF9CCKmEX3
         PnkBulV501Sz7fnca9nVsRFcMpHCiepkP5u+i33pGVl0CBk2Fmfe/2EDgeVr+A7Xgm/M
         MYVhN34zc14lhAQfdPwciZaUFcUxQjglVlY7B4lD3LYJWv6rimeQAVWdnNfpC6TvxJk3
         vIoOBVhidQddwXh0+AEahb3iwvh4IhL6bqDnRcrWbdxc3QCDcoMj6mF05UroQzDuvWGJ
         CM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JYcvqCaQ3Nd7wlheHQcpraf3poMYXpd7Pjl2JOuJ90Q=;
        b=L443m9zKW03SKtD5FTlz49+1iNPxN9PxjbO8pgQvW93X/kiLrGfphZXzn7D60qIWGT
         WDZWYWHyF4juG3XAG91KgKuRIxNK6Cs1+VT63iKSdH1R3196wXuPZb+vGYOyxkeuy82F
         p0K6aV6IdJejL04MFRS7b1o4u54ZG3H18p3r+7YQwXGrtQBvn9nLL1+I6m+L1HDxNVIc
         AhAM4H1PHgebEnklAhzJcM2cf6w4CS6K2swtzH3GiBdre+pdte73+0tIKkgjHM1l3Qce
         dAPBpZgDSi4kPKNXUa/iOb7l0ud4HEPeBbW+2VTrn/FVBt1mSTM92w1O5XI7D3k4+4VR
         +xmw==
X-Gm-Message-State: AOAM530D4tAsh0bnJxCqZ0+uFQ5Mu7BwoK5aUb8rPmDfuOQaNeTJkoPW
	xyjIUkOf/wspc8CY21uVHcBoSt1Xa6Y=
X-Google-Smtp-Source: ABdhPJyFaiWo3C+kMbViOZJndu8UFSEuNmalVkkT/6MmFJFSrotlpPJLj7zftZmaqNneVbau8utBgA==
X-Received: by 2002:a19:650c:: with SMTP id z12mr1610251lfb.582.1606840024232;
        Tue, 01 Dec 2020 08:27:04 -0800 (PST)
Return-Path: <ernstp@gmail.com>
Received: from localhost.localdomain (c83-254-138-119.bredband.comhem.se. [83.254.138.119])
        by smtp.gmail.com with ESMTPSA id j131sm248746lfd.209.2020.12.01.08.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 08:27:03 -0800 (PST)
From: =?UTF-8?B?RXJuc3QgU2rDtnN0cmFuZA==?= <ernstp@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex.kanavin@gmail.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [dunfell 5/5] gpgme: use python3targetconfig
Date: Tue,  1 Dec 2020 17:26:27 +0100
Message-Id: <20201201162627.47760-5-ernstp@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201201162627.47760-1-ernstp@gmail.com>
References: <20201201162627.47760-1-ernstp@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Kanavin <alex.kanavin@gmail.com>

(From OE-Core rev: 38ecb83c444406b5157712d87aef3bbb320b45ec)

Signed-off-by: Alexander Kanavin <alex.kanavin@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit de2a5404d3ef1a5dda7c5bb66c5a338883e249e6)
---
 meta/recipes-support/gpgme/gpgme_1.13.1.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta/recipes-support/gpgme/gpgme_1.13.1.bb b/meta/recipes-support/gpgme/gpgme_1.13.1.bb
index b51534351d..6e945d3165 100644
--- a/meta/recipes-support/gpgme/gpgme_1.13.1.bb
+++ b/meta/recipes-support/gpgme/gpgme_1.13.1.bb
@@ -49,7 +49,7 @@ DEFAULT_LANGUAGES_class-target = "cpp"
 LANGUAGES ?= "${DEFAULT_LANGUAGES} python"
 
 PYTHON_INHERIT = "${@bb.utils.contains('PACKAGECONFIG', 'python2', 'pythonnative', '', d)}"
-PYTHON_INHERIT .= "${@bb.utils.contains('PACKAGECONFIG', 'python3', 'python3native', '', d)}"
+PYTHON_INHERIT .= "${@bb.utils.contains('PACKAGECONFIG', 'python3', 'python3native python3targetconfig', '', d)}"
 
 EXTRA_OECONF += '--enable-languages="${LANGUAGES}" \
                  --disable-gpgconf-test \
-- 
2.29.2

