Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web11.7789.1613659053461725504
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Feb 2021 06:37:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=TFobfQIx;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.173, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f173.google.com with SMTP id k13so1392613pfh.13
        for <bitbake-devel@lists.openembedded.org>; Thu, 18 Feb 2021 06:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eOSLVW7fRSZYWoWu1mQT7Gl2Z0gfmOhksJCtykNfoaA=;
        b=TFobfQIxoWGIY08SCsobIKvcS5kZXofm0+QOET6vCkZOwckPPnNjg8Vd/4VuetUprk
         /WDXN8nKCT1+3MhNf0qVTMC6uXjyY6k+4PVAzdH0qTfUZnqgAclajt6WEA8BSORd9o86
         zHmQYBKT9Cl7XiAgoI1h5CXWHYqvkHIQ7dUJ4UX5gS4Odj86OSKO8/aORRmWsQhz2WQx
         qMivYjaAGxbqwmlJBbbgWZK9WOIWoXBLGPeg1dRDvAMEAof+u0iSVfL5UnogWVicpwhe
         LNcPdCn0PIbWVZ3n6Y4Ge8Wym3DN8mZZDF6RTVflhmlGUsbwG6NBCrGk6QASH0oRU31L
         6VAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eOSLVW7fRSZYWoWu1mQT7Gl2Z0gfmOhksJCtykNfoaA=;
        b=VtUIUtaV85zkYD13fw9LYjGvIhrYlAN5uuVP+rK2r6UKfW6TcHooHTE33cp555FShV
         MaIkS9XT5aBJmvnYYrD0neWhBScqxR0VBt2tcEtYPi8wMVO1RFFYtWUusCkC5zGlf2L2
         TpxTculOJ5L0BtMEvP/xCR971PLJ8mbxpPNWCKGmAhPDYdDZ/8l7/CcRPN7ZbahcIebK
         cSZzhpxFG/zABFKbpIsZpBZl4q/bTLXInedsBSWcY1cMXB99zQeIRhWVj8WLkHTn0ghu
         0D0E5A8jqF9WRr5t876olm/dM7CJZs0QmzCeTkIH35xt4AmjmujdJtt3YOUVkjSSBWmA
         EyNA==
X-Gm-Message-State: AOAM5317YR7GcPbvYErwU/FBBWQqHmIdSF5QzHtB27Qn15XbOKyRQfWi
	QzGMEkrEipO4DrMS2A+mIvQdDLJ9AfhAIxq/74Y=
X-Google-Smtp-Source: ABdhPJweNBzIVUjNCigJcPyon2Tf31x3svP56xiowIAUpyzCEbQTeVXyWK3CxLlHQ3zbO9r2JZ7dyg==
X-Received: by 2002:a63:db08:: with SMTP id e8mr4285975pgg.261.1613659050571;
        Thu, 18 Feb 2021 06:37:30 -0800 (PST)
Return-Path: <steve@sakoman.com>
Received: from hexa.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id o13sm6440797pgv.40.2021.02.18.06.37.29
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 06:37:30 -0800 (PST)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/1] Pull request (cover letter only)
Date: Thu, 18 Feb 2021 04:37:10 -1000
Message-Id: <cover.1613658987.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 2351b496bb63b96920d4ae67bec816f00d510df2:

  fetch/git: download LFS content too during do_fetch (2021-02-05 12:18:26 +0000)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.46-next
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-next

Alexander Kanavin (1):
  lib/bb/fetch2/__init__.py: drop _PYTHON_SYSCONFIGDATA_NAME unsetting

 lib/bb/fetch2/__init__.py | 5 -----
 1 file changed, 5 deletions(-)

-- 
2.25.1

