Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
 by mx.groups.io with SMTP id smtpd.web10.332.1600445524322143794
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 18 Sep 2020 09:12:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=wBiDaLNO;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.66, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f66.google.com with SMTP id gf14so3257715pjb.5
        for <bitbake-devel@lists.openembedded.org>; Fri, 18 Sep 2020 09:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=+7Mbh9p7MtJKmSzq9B7pKVDamn6SEYS2G/lRcb9F12E=;
        b=wBiDaLNO0Zlcol7JEBYlkQXz+JqokNJiiTUNSc31UFnO6jLQJYdaHalWnmbGyC8c0i
         ApoTgFuTrBbUg2hvqzg0efh+Y9bZUD7Z8xWZzdRWu3qJuJGl2/g377MkMK7icJptcw59
         x6pbLKAUWjFIY72ZhhbHRoAV6N0r2FOM+1irHwGR2rkszAbiQAm1ddnOuf5oWNxZ+p1/
         HvIHEThCYAhTTWJxsgSYjcVINtFweLCU1tISdXKrywCdfac5YjKmeUdNefiz9dMzMD2q
         hOn0I9qcDEHfrJV1X9n74tZR/Vt36SLn1IvDmSW09Bh2QeM8k9ksUYh7hbQfjyPqkwjO
         qKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=+7Mbh9p7MtJKmSzq9B7pKVDamn6SEYS2G/lRcb9F12E=;
        b=uVQx3u/8JbvlZOqdiUwFyrPdEo761nTQwv1n/mqjPzIQU70s2+EYOQks2dVvkFDZzu
         +R4sReIFmblhtmuTf6ev2g45TEP+oBkf/Z/tR+v8b85VfAD9JLLbbMKN+X1fgI9WKgTK
         e1i0FjZtKCVyRtev749I7T2oW+pjE9wSMnU1dUajZdpQghRV8E2Nk78bKT/gkHInPg0i
         p/iaVLGxOkU7am99FIzWZ3n4I7VRg/M2+Wvn4Q5dJhQ6szJtzS1cucNe8GwrmA2wJ9vE
         Vn2UW/W+uWlx5lDzKwD1sAVY2UYmXqglfpi5lgiEQua7PMGxLhhuwvAW0iawKTyzhWQa
         mZzA==
X-Gm-Message-State: AOAM533Y5/BurOWVfg6b9lUcpo6wcw4X5YNP6ZgjV4hTn6vP7Oo1GuvK
	kdOA+qkBEKnDThdCBlc8uTDoP+qkNT9+8Lz67l0=
X-Google-Smtp-Source: ABdhPJz7deV/v+Nvi0dxzkbF5FnKmMnkLCEyyATuPjlJ0HNpCaDr3ZcVcd2T7za/ka8gvsv15dUICw==
X-Received: by 2002:a17:90a:9307:: with SMTP id p7mr14355018pjo.47.1600445523278;
        Fri, 18 Sep 2020 09:12:03 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from octo.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id 126sm3895327pfg.192.2020.09.18.09.12.01
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 09:12:02 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/1] Pull request (cover letter only)
Date: Fri, 18 Sep 2020 06:11:52 -1000
Message-Id: <cover.1600445445.git.steve@sakoman.com>
X-Mailer: git-send-email 2.17.1

The following changes since commit 16774d4d41f2011e8db7d2986a1a701df123dfc1:

  fetch2: Drop cups.org from wget status checks (2020-08-24 05:30:26 -1000)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.46-next
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-next

Richard Purdie (1):
  tests/fetch: Move away from problematic freedesktop.org urls

 lib/bb/tests/fetch.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.17.1

