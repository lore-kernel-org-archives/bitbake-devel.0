Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978BAC433EF
	for <webhook@archiver.kernel.org>; Fri, 22 Oct 2021 13:59:53 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.web09.8626.1634911192300821758
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 22 Oct 2021 06:59:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=YFxyDF0T;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.52,
 mailfrom: steve@sakoman.com)
Received: by mail-pj1-f52.google.com with SMTP id
 o4-20020a17090a3d4400b001a1c8344c3fso3679402pjf.3
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 22 Oct 2021 06:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HdHpXzUapBljDxWimWgYSrUkl0Z+NkF+GXQQqroyybE=;
        b=YFxyDF0TEcTXQmYv8IoIZvU9jHRHeO9il453SLjA0I5S2IVt1lIUulIfZmJuHfXCWH
         VCZTklQRiEviPm1KotHKhJFimDedR7ZEF4XqqNyyjcmtv3vCAhqBb1hvSu3t5W7rXzyM
         NAY+Euv2BjrJI9oT2X1F+KJ8aGYPAJsFAGSlmcL6urrW+vw6QhDiOdJwWTCBuofsq1WW
         cZ6kKOKBc6uMmMK9W0u8D/lpQiElhqUNzOx2ZuN+eW194SCgD5vuRq4yTxO+hAhViAtt
         xKNXtHOWwmLll5EQwriqdw6LUOO3UFNPQ6igNMjPs7kZKTamUE+kfMDGbgWEhIepKGU8
         dptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HdHpXzUapBljDxWimWgYSrUkl0Z+NkF+GXQQqroyybE=;
        b=iK2P5OB+EYKlkIl0veu4SdatjWsxVOVMv/OwK2cJF4NTtJVXQs9+1p9Nagbw9xphmc
         TvpO+Jt96v6KmDmbVZBQoFb8te+xlwx+Vl/OpB72604Op0GjutYzMFvgFq0Vjx1F7PbM
         QO5JltPNYPfJabIJvajv+YoUQQ9BtkKrfzU9s0NrSJmYRLx47iB6KJ/3GU72cjBK4RXl
         wVV4Ki+EVItEJTVT5uUE6h6BK0tm+nSRsyvSkc64rI0llaWHO5Dc50KEzak2XnCkbR5k
         axoOgFCvXcjqWu92V0G1FMxumKomBcsqVlk5B6DWwtd8mPTKXXZotRNNH+26Uz83LdrE
         G+FA==
X-Gm-Message-State: AOAM531JI9ETlhcozH+TdYsn0AhaWd/sDkcywR/dlXHvN5kcz3CSyazN
	6Gne5fkb7GOWU1wleGvGfEvo9Hp5sQPPrpHBCbI=
X-Google-Smtp-Source: 
 ABdhPJz/Uvl3lV5E8pdDIKilYJoE5PuFNZjq+EEl+z721t/Y5QVo3h4AaXgahQO1zi/Bz+oXVNnVyw==
X-Received: by 2002:a17:902:c7d3:b0:13f:f813:833e with SMTP id
 r19-20020a170902c7d300b0013ff813833emr46065pla.68.1634911190887;
        Fri, 22 Oct 2021 06:59:50 -0700 (PDT)
Received: from hexa.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com.
 [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id
 d20sm10032806pfl.82.2021.10.22.06.59.49
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 06:59:50 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/2] Patch review
Date: Fri, 22 Oct 2021 03:59:13 -1000
Message-Id: <cover.1634910994.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 22 Oct 2021 13:59:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12814

Please review this set of patches for dunfell/1.46 and have comments back by
end of day Monday.

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/2787

The following changes since commit 35f01508d687eb44c2dc488cd74a9b35124859d9:

  hashserv: let asyncio discover the running loop (2021-10-21 05:57:38 -1000)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.46-nut
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-nut

Richard Purdie (2):
  fetch2/git: Avoid races over mirror tarball creation
  fetch2/git: Use os.rename instead of mv

 lib/bb/fetch2/git.py | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

-- 
2.25.1


