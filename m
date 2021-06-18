Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
 by mx.groups.io with SMTP id smtpd.web12.1519.1623975487382704199
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Jun 2021 17:18:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=kH5G28Af;
 spf=softfail (domain: sakoman.com, ip: 209.85.167.181, mailfrom: steve@sakoman.com)
Received: by mail-oi1-f181.google.com with SMTP id d19so8521337oic.7
        for <bitbake-devel@lists.openembedded.org>; Thu, 17 Jun 2021 17:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UPpGtZpiaCO6Ea8ywZJcDMU3D6yOKXchSPO0tAokkRk=;
        b=kH5G28AfOQfEBQFd73bwNWif3+L6uqEeh5F8PIdwdlIdGKVYLP+s3EvvXm0behn2aT
         kh/0+fB1KIPHA7sajhmtli1tSa26j2dqAL2YQboY6wao+yFZ1+TMnDt486HJshujVVlN
         OV0QC9YnToJBGXwY7oZ7TWdtAddoNIpZFL6iCmlYAHM8v1poUrvn11pg7pAwA35A5hIB
         8SETTc3xTJLm0/BvHDZBCF7iWbRhRaQ8l4A1aXhSHHR+vpU6XUeoGpzdMWLgWppgpa1f
         T3bIXn2yC1yL/d9sprnzPPGkPOyG9aZPtzHE+7ECMDXkREK+S1OoKxPxpIA8nhgDTJzG
         06HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UPpGtZpiaCO6Ea8ywZJcDMU3D6yOKXchSPO0tAokkRk=;
        b=YhJbIxBC+geF+xk/mP4BVkvS8xfy2uUKZiv2XHbi6jIIMMWB16bDeW5B6Zr1wvVfTt
         mq1oCWDKIvoLpxwBzQesGB/0RaC6qjuo6rB8rXhBqQ9A/DbmpEGdrRDZidei48b91fxo
         qpVQr6UCcvzho/uhujpCvqV7abxb0dwF4/lbTnGdSANJuL8FVNkww1L1+009+ro8B3BO
         KQRzKiXmvf+3pZGbB3rC+PHVaFWO3137aTlJoo8iJ59c7ev0fDdyrTeYG1yQH3pxMlZP
         GkCY3oD0B38BHvsmPv3gaTlnLT34p6hwFc+RaQkXchRwmk9VvP/HmrPyvE/HhX2m4RFW
         ofFA==
X-Gm-Message-State: AOAM532NtjLeKhkVqtfMzQOk/NU6IALeZq2TMQ+/cvJwJSKN6TT/BBlt
	CkpanoHK59N8twL4iqBwwlRBhgYzCCASImOF5/4=
X-Google-Smtp-Source: ABdhPJwIl2jmlMUL/sGtcGJw1CNL+mLMHs/geYxzVldScj06R+QcfAWu9Cn1hyUXpRPXxuY4cvBW+g==
X-Received: by 2002:a05:6808:692:: with SMTP id k18mr12414298oig.148.1623975486256;
        Thu, 17 Jun 2021 17:18:06 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from localhost.localdomain ([172.243.4.16])
        by smtp.gmail.com with ESMTPSA id f36sm1430681otf.12.2021.06.17.17.18.03
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 17:18:05 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/4] Pull request (cover letter only)
Date: Thu, 17 Jun 2021 14:17:45 -1000
Message-Id: <cover.1623975328.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 078f3164dcb1de7a141bec3a8fd52631d0362631:

  providers: selected version not available should be a warning (2021-05-13 04:26:15 -1000)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.46-next
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-next

Richard Purdie (4):
  cooker: Ensure parse_quit thread is closed down
  cooker: Explictly shut down the sync thread
  cooker: Ensure parser is cleaned up
  cooker: Avoid parser deadlocks

 lib/bb/cooker.py | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

-- 
2.25.1

