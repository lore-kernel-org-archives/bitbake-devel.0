Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
 by mx.groups.io with SMTP id smtpd.web11.13034.1617720205045606148
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 Apr 2021 07:43:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=uJlMIuB1;
 spf=softfail (domain: sakoman.com, ip: 209.85.166.170, mailfrom: steve@sakoman.com)
Received: by mail-il1-f170.google.com with SMTP id c18so6697604iln.7
        for <bitbake-devel@lists.openembedded.org>; Tue, 06 Apr 2021 07:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0iz52tgI0TGx46/5B1OUgdMFOv9hSazB8RdHG3DmvuY=;
        b=uJlMIuB1kk+EbDEvB1SjXmUp41bcTUiyv7FCMjBXL4pNRcmzwvglBAgG83qPfRH3HR
         VHi2mu+KuWBP/Jan+Zy98JnkL4Fn0pDGbEqfVHAoeVjI/bkDt3TdKMotKIc9NGk6vk7j
         TimLKBd/AoBk7rTmkbSljHhAaZcMw1F2anQ4u7ALfhAgkPX4DMJKk7tn1NetizKyaRbM
         8mlDR9EfdYHgJlGwiNK9S/nCwgOenJz0pTVhXHmQtOrfW9unAtu2iikWtX55YTgY+vCp
         qnBG7v+6Lejq8GVButNnXl9fY1OC6kGYMscLPR5Iojp8NQQTXvN+/XU50V4OqljWCil+
         SI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0iz52tgI0TGx46/5B1OUgdMFOv9hSazB8RdHG3DmvuY=;
        b=gxRqSrcHrQbEGUpv9amoPQLoY2k4NsBU9PSpMXu+eXTrQqOJps52ahiXr+HccfFCGv
         Logyr2XKuF8dYkdKghUZYlattPgvQsySVhmfViHjooHtmIUZqWOkVzEF6g0ozTfQO1TN
         3G0Knn2WWnvxi9/JXhsJ8pnx3HtQ30HNhyRjsMeYABJncb1l5LQ0ngJzlPrbD6ZWjUAd
         ppFMKzHl8NgPM1UrTmjXjbkg9e2fDZQLs49LBTTHzu1A0/izNuAhhQE5s6iSn+idPdxC
         n981VFrdUalisvhy2unKok1lWmZVhxHwK2GcSxN6cTX6tE4oXP8+iHiZcUn4AfiRiWvC
         rmyQ==
X-Gm-Message-State: AOAM5323TgYHuJKsMVPo4blGZb7Vggl5pq3rS2M1P66a10I5ptZrtjJ/
	A13+oJ/O31iwh0MGyCAoerrSWmMC/ddLiue+izM=
X-Google-Smtp-Source: ABdhPJwdMUHehu165kWDYJ9EhukRD+vkQXAconut5k7Z9plbxmWGqbgAxdgZw1vUilfTcAFJuzY4Lg==
X-Received: by 2002:a92:dd8f:: with SMTP id g15mr20275757iln.192.1617720203988;
        Tue, 06 Apr 2021 07:43:23 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from localhost.localdomain ([72.173.249.164])
        by smtp.gmail.com with ESMTPSA id g11sm6195059ilj.84.2021.04.06.07.43.21
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 07:43:23 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/1] Pull request
Date: Tue,  6 Apr 2021 04:43:01 -1000
Message-Id: <cover.1617720075.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit da306cd4430a6fcf6b62ed0e6e5310432aa4c4c4:

  runqueue: Add setscene task overlap sanity check (2021-03-24 14:35:57 +0000)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.46-next
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-next

Jan Brzezanski (1):
  Force parser shutdown after catching an exception

 lib/bb/cooker.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.25.1

