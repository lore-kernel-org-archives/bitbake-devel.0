Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C359E77188
	for <webhook@archiver.kernel.org>; Fri, 10 Jan 2025 09:10:08 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web10.14648.1736500200917588105
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Jan 2025 01:10:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=gO/SuzKI;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4361e89b6daso13588295e9.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Jan 2025 01:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1736500199; x=1737104999; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSSqbD2MMkiQzszDJpPQ+b4ISnhqPysjVhN3PgwPW2c=;
        b=gO/SuzKIIGuaSU5KW38sriWmX/NiGplIrRsh8i8qB1dtX7q7Xk7sUvyFYrU9xAdAM6
         V2P1GXkc7aPKGQowGpqzqOXbkW8DBJXA9smXEfNo1H4gnhP6lzKU/0533fwMxIq0YnPn
         8+ZAyOAHGCaWYD6x74Hgnp5UCISyhpBhzy7yQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736500199; x=1737104999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZSSqbD2MMkiQzszDJpPQ+b4ISnhqPysjVhN3PgwPW2c=;
        b=osXTBzfak3b9dWJOGfjKGkl4TIlq2pwA0RV6kzZAKIWfTxoovYhjmaMXuJuPSwNxk4
         1UxlOOT74QEHN07s2wRcKYzKyaAwGk2NIDt7dJHY9I080/44nBy1t/8bGBzNzT8W2Ksp
         YMlmnx7Uz0928984MfTXT1VvNpXI/QaSbo13FaBAfYshX2wSS32K9umlH7suoX/NjRGy
         5wGtGNeKMN3EV3MnY06nwFscg7WiQdkDpudYiK5UQ025/n5mX3mo371O2q/n3rqn+lII
         Z6/wVFB4cbmedFjTBxm7ACA+wIsEXeIIRBQ4wb0PpmwoaGxYFC473Sd3pL89K6Qon1XD
         7Iag==
X-Gm-Message-State: AOJu0YzNfJSdneP57zdA4g9AiDdtveuv/oARm/HNs+w29wRl1i2qIEoP
	HpsRzdl0TsRmF6WEm2SxaHhf1ozLS5J3oxR/udJ/oIAaeOBbBbTTY7mzAJaiJ1jYIvwKoSmv5oz
	1bK0=
X-Gm-Gg: ASbGncsrbXeRaKDoWx59N1EnxQsYbtMG5BYErU10tfGwaM0KJ+cHd3AxN9MakmI+fNZ
	oHjpI5sNgX/LFIS1TGQLtqFVF4sc4U2pq2H81nJ9fjK64uCJN8t0fLMM8u1/0hbLONWHpRpLZ/V
	JDyFTiggE+rW7ZiwBW0aNvDjGl4UJa1OhR72s602EhZ9/1E/beM/mhqpoJeKCzTfZZY0XHwkMg3
	dnjtMYstGWjm1Y3auC6f7Lqr2BwHHVkAbJX0je2gI3ZJfJWhiPL6AkQhYJuGgS72Vvj6FnDFEat
	dv8UB7zSRA==
X-Google-Smtp-Source: AGHT+IHs5JzxIWGSuxJfUgB1SoMDegdTwxGzXpu9GddWWWfM1P5BZr/ClfbV8RESoGj6ajezUI091w==
X-Received: by 2002:a7b:c8d4:0:b0:434:b9c6:68f7 with SMTP id 5b1f17b1804b1-436e26ddc3cmr79677155e9.26.1736500198897;
        Fri, 10 Jan 2025 01:09:58 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:d75e:67c5:40ee:6f3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9e62116sm45412255e9.35.2025.01.10.01.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 01:09:57 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Cc: Nick Owens <nick.owens@eero.com>
Subject: [PATCH] bin/git-make-shallow: Fix syntax to work with older git versions
Date: Fri, 10 Jan 2025 09:09:55 +0000
Message-ID: <20250110090955.125297-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Jan 2025 09:10:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17002

The transaction model was only introduced in git 2.27 whereas Ubuntu focal
(20.04) has 2.25. This causes failures. We don't need the transations here
so simply drop the commit piece, fixing on older git versions.

Credit to Nick Owens <nick.owens@eero.com> for working out how to fix it.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/git-make-shallow | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/git-make-shallow b/bin/git-make-shallow
index 8ad704fae5..e6c180b4d6 100755
--- a/bin/git-make-shallow
+++ b/bin/git-make-shallow
@@ -116,7 +116,7 @@ def filter_refs(refs):
     to_remove = set(all_refs) - set(refs)
     if to_remove:
         check_output(git_cmd + ['update-ref', '--no-deref', '--stdin', '-z'],
-                     input=''.join('delete ' + l + '\0\0' for l in to_remove) + 'commit\0')
+                     input=''.join('delete ' + l + '\0\0' for l in to_remove))
 
 
 def follow_history_intersections(revisions, refs):

