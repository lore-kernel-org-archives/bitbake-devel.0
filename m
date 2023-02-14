Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B44DC64EC7
	for <webhook@archiver.kernel.org>; Tue, 14 Feb 2023 15:29:05 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web11.9973.1676388538676270739
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Feb 2023 07:28:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=lxStBUkb;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.50, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f50.google.com with SMTP id mg23so8883582pjb.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 14 Feb 2023 07:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H84wM51lTXM1aKimvF/tPHvA7HUiyvpAY2WjU2XgebI=;
        b=lxStBUkbFu46A0fubQinYMw7+WPu4HyGSKWj0MLsCvzMDRiru51JLZqxE6qp4kKnry
         XiEsK46PZquNKTvpFXTlqqoD15xzK+b/3iABL+xepx5EufM90U882fBA2vKXWwMixNO0
         7RQKR3z47cnlTByoUujGHv+/+b+dNwqx/lOODMMyVe5hD7EtTYFGvWVo3Znds8RkhBif
         1dAmXEl3l6frxjEce7PN/quBTAODE7K4bK2mHZnK66Rx0C6jyEdtXZrrDdkD36urP/k0
         UOA2BZoVrllkcFg1k+LQGvyBqmJq15Z210Q8D9afkJw8HfMTlG9sCO7exz5IInaRctLa
         yr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H84wM51lTXM1aKimvF/tPHvA7HUiyvpAY2WjU2XgebI=;
        b=t1ShWrBE5Mb+r9zEkXZXaYMMSoe8Xhy0sY4VYgpYJLoqkf6lo/qVNenl7ijT7kmRuK
         N7kS7lQY8uwjexoDfiNgF/Z0MO1dgTZTf4Q2u4/BLKZw7FzPd7ABwtjTa4ifZbcqn+Zx
         ltT1x1i2zpscjocwkAKirW6C1fKJP3IYu0M9XvjLLJsstfJL6Kg/zM3ivVgj4LwV+gm4
         Sf9t24Zlet/0lV/J6nDrjtZX1UiC70rwNCJA+Ys13q2C737Tbmf++dBjFrikFjTrD+K4
         /c2GSLBXvxbfu55DUXS6t4B/GBwQpJSWd1D/gysXRnMbzJMQETn5kVZInJ6J1w/eJyfv
         WzfQ==
X-Gm-Message-State: AO0yUKXMZ8TdjxGb2u6OXc0TXwkRjG3/5OH+Hrewaoc5Oihzhheka9vv
	5bOPJSjYROkI7dNDuB5pTCUNs1OJjaNQFKdRTQE=
X-Google-Smtp-Source: AK7set8o9JBsn672aC5kTpVNUhGguWLwEHbP9H0ShxQv8oChTSpPsuuSirkbxN3FBX0xe3i/hE4HzQ==
X-Received: by 2002:a17:90b:4f81:b0:233:bc73:a926 with SMTP id qe1-20020a17090b4f8100b00233bc73a926mr2981863pjb.20.1676388537786;
        Tue, 14 Feb 2023 07:28:57 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-253-4-112.hawaiiantel.net. [72.253.4.112])
        by smtp.gmail.com with ESMTPSA id m3-20020a17090a5a4300b00233cde36909sm5624203pji.21.2023.02.14.07.28.56
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 07:28:57 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 4/4] bitbake-diffsigs: break on first dependent task difference
Date: Tue, 14 Feb 2023 05:28:44 -1000
Message-Id: <89f13cd4a927a73de98998c27082c63b07671525.1676388410.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1676388410.git.steve@sakoman.com>
References: <cover.1676388410.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 14 Feb 2023 15:29:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14418

From: "Schmidt, Adriaan" <adriaan.schmidt@siemens.com>

compare_sigfiles() recursively calculates differences on all dependent
tasks with changed hashes. This is done in arbitrary/alphabetical order, and
only the last of those results is returned, while everything else is discarded.

This changes the behavior to instead return the first difference and not calculate
any more, which significantly speeds up diffs of tasks with many dependencies.

Signed-off-by: Adriaan Schmidt <adriaan.schmidt@siemens.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit ea6a676c9aa2864c2eff40eea41ba09ce903a651)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/siggen.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index cea3a538..0a9ce0ed 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -1028,6 +1028,7 @@ def compare_sigfiles(a, b, recursecb=None, color=False, collapsed=False):
                             # If a dependent hash changed, might as well print the line above and then defer to the changes in
                             # that hash since in all likelyhood, they're the same changes this task also saw.
                             output = [output[-1]] + recout
+                            break
 
     a_taint = a_data.get('taint', None)
     b_taint = b_data.get('taint', None)
-- 
2.34.1


