Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
 by mx.groups.io with SMTP id smtpd.web12.393.1591058406341473347
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Jun 2020 17:40:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=bOMhBrua;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.193, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f193.google.com with SMTP id d66so4232253pfd.6
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Jun 2020 17:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=2MolsBTvKunpKbXPErvo07dxaeH9jLsjklhVYuV3a7E=;
        b=bOMhBruai8wio/WYRicjPa+NoPiHNQtm9AGeNESxlg/QWD+jzuf5JKtIJ6CGg+Eahw
         orHlSPy9gtxqHsIbg/dKzYppCfZwRb9lmjPGR2szbPtdYJU8iu122sgkdNydBuzBGyJY
         1O09G36OCvy233bMboFHdNleBWiJW9MaV9L/5K9mgp08iTOXOfHgSVTc7sVkyZ9IHLW6
         RIjmKLyp2ydycM5Wl6V02Z16gfZ2MNPR9Vd2AyuNKs2KHa6HdkBNyLyDUO++VX6vmMww
         3YbhmrTHBYKsIRl9F1gCfrwN2d8JpXSbl11MfCW/to94WDmGP1TiaAEy/GB+FHU/PI+D
         cvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=2MolsBTvKunpKbXPErvo07dxaeH9jLsjklhVYuV3a7E=;
        b=eZheWCRLaSCE05UDVYvR+qD0Hdhuk3I8z/SimxgP83aWDtpkCLvJUueXGA/rCvSh+g
         aG4QiZBjUPsYFPuxt+VmJz6YhkvoypXICvLTVZ9L8i/H1a9P/ZxgR9Ybyex3MrVFrpiR
         0rJ1lVqknbXLhmgXm1Q9x05QmiUKVfUqAzzEFu5X7sQg8t8giNFaJeOYLLY8C58eykFW
         Z5S2sB3WjO4pjaWXwsPhTi945u+FlhbtELulvlvR2ikWjyI+5jlPBk+glN7BqIZrS5Xb
         O5DBT/g4XvgvqVy5YXnVH41hKCVPnP6P1Ma6dlob0FlKcZClfwNOos/QEgka5fp+GADh
         9RVQ==
X-Gm-Message-State: AOAM532z4CW6dn0QemB5xJX/cJGw2VzAu8AT1hw6stWAcOpK10LDhdXa
	9vWyvPAw5LgCfInd5kA2wxZNK5qEQNM=
X-Google-Smtp-Source: ABdhPJzDCKl3fDl/+fPKVdzqienxVZRPOziFVNjaUHARasn7EZom/GD1dm0OpYuW1L4XDIoD3hIckQ==
X-Received: by 2002:a63:6345:: with SMTP id x66mr21124238pgb.156.1591058405472;
        Mon, 01 Jun 2020 17:40:05 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from octo.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id l187sm465729pfl.218.2020.06.01.17.40.04
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 17:40:04 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 5/6] bitbake-user-manual-metadata.xml: fix a minor error
Date: Mon,  1 Jun 2020 14:39:35 -1000
Message-Id: <324aaa7f8d6d83e1e00b8054dac44df561588be8.1591058197.git.steve@sakoman.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1591058197.git.steve@sakoman.com>
References: <cover.1591058197.git.steve@sakoman.com>

From: Kai Kang <kai.kang@windriver.com>

In the '_remove' example in bitbake-user-manual-metadata.xml, there is
no 'jkl' in the original value of FOO2. So remove it from result.

Signed-off-by: Kai Kang <kai.kang@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 06b5cf0ab6c6e518ac780d081fab5546334c5c7d)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-metadata.xml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
index 069a0ec8..0ca53216 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
@@ -432,7 +432,7 @@
                 The variable <filename>FOO</filename> becomes
                 "&nbsp;&nbsp;789&nbsp;123456&nbsp;&nbsp;&nbsp;&nbsp;"
                 and <filename>FOO2</filename> becomes
-                "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;jkl&nbsp;&nbsp;abcdef&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;".
+                "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;abcdef&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;".
             </para>
 
             <para>
-- 
2.17.1

