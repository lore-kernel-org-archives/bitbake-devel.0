Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C343C61DA4
	for <webhook@archiver.kernel.org>; Thu, 23 Feb 2023 14:32:00 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web11.11834.1677162715924374355
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 23 Feb 2023 06:31:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=1vnY66tX;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.176, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f176.google.com with SMTP id l15so14240886pls.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 23 Feb 2023 06:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=n2FhiBuhJBD9yXE3jkpdJJ+ir3QohMace4CDFr88730=;
        b=1vnY66tX44/yp1gfJGCTytUBRmvVbFmwKSrLZLqB5x7eu/OVQ4maXW4tBxArxGw79k
         uV2KHgjsX7fWzXfOEWNqCmgRvvNNU+ZpTA4q+J4JJioVxXwHME/g1aUMJA/I+tKXSusr
         v91RLSIwn0S/gxYiVFn2Bes6ZOeZ4yZwomzkgQU/qisDfHlj8a8x6rYeyP0ODLZHuyCP
         6AiI0D9vHvtL00pBoRqOpZe5iuUbzpUUS5WUlo/8/dZbo8xD6Qy4lX1NTlgxljSpaIuY
         W9AVCt74mxxM81hDN4i8z/v+yzjRynNbA8y8uvNxHQ2qqpSTZXms6QJzWQLdzhQMJCWn
         0iuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n2FhiBuhJBD9yXE3jkpdJJ+ir3QohMace4CDFr88730=;
        b=GmSw7tl+4KUZ44Hje0Pc2bK2A2WCwz4YDSTD26wOAhd7GQorjGF3xMsE4VMfDmvQ+v
         Nm2E3rXQwREZQEhg1LWdrJp/TUmQemhEkD/8X+6avI3xDMfWIrDn5+GMaSzE7VNsiMuO
         Fih6n1TfhXz1Qv0fi97MTB7fatxdICgDAPxd7PNsy3aM/P0hv824tfCJoOoG72E0jShb
         Ol7uu0HE7290dVVOL/Sy1CusmC89cgSfe841WQgcicogAK5//9XTOsYkhm/pDq+MzxPc
         N6t6lCWtDPaJZfxb/BMIn7C/0gQZjYf3xrOJRDPLuOHbywgwOqsQrQ8jRpYesljQEAhd
         vcug==
X-Gm-Message-State: AO0yUKVPX6dOzwYLtqYS7JL1TTFYWsBVZReKeJ1WSImagEy2v2BXuZHd
	VX+GxOKbHOY0x8OfE8SFfMO2nRgcvNV0FqoKUvA=
X-Google-Smtp-Source: AK7set9Rw1fqrjGfDKTDE6bv9/8wF/qoghOxofx9ZmNi9iREFkkwhlUa69EZmSXnArJY46rfSfF5lQ==
X-Received: by 2002:a05:6a20:429a:b0:be:d389:7abf with SMTP id o26-20020a056a20429a00b000bed3897abfmr15132340pzj.3.1677162714833;
        Thu, 23 Feb 2023 06:31:54 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-253-4-112.hawaiiantel.net. [72.253.4.112])
        by smtp.gmail.com with ESMTPSA id v8-20020a63bf08000000b00502fd762a39sm855044pgf.3.2023.02.23.06.31.53
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 06:31:54 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 0/1] Pull request (cover letter only)
Date: Thu, 23 Feb 2023 04:31:49 -1000
Message-Id: <cover.1677162644.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 23 Feb 2023 14:32:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14482

The following changes since commit 89f13cd4a927a73de98998c27082c63b07671525:

  bitbake-diffsigs: break on first dependent task difference (2023-02-10 09:35:44 -1000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.0-next
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/2.0-next

Martin Jansa (1):
  fetch2/git: show SRCREV and git repo in error message about fixed
    SRCREV

 lib/bb/fetch2/git.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.34.1


