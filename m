Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
 by mx.groups.io with SMTP id smtpd.web10.401.1591058394868529942
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Jun 2020 17:39:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=rhovurF9;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.194, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f194.google.com with SMTP id t7so629420plr.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Jun 2020 17:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=Hz8/LBSLAMtznbO6y+dgYRRd3hfNu01QCFthMW4VU3Y=;
        b=rhovurF9j2wdDyyyEIEwRuiWalWVEuM361mq0AWC0dywS116PsHVL2XuzwW6T8zOyk
         KHUYdtS7KezgDgaEkYm3+6pPcLzM0ZTbQhNT1eH9ZIfiTwJSXv0E9w6V1bk+A/Pq1gLy
         0toR0JdS1E0WUmDLsqWllNYEdEXksrtsW7HsGvKc2ppiNSE66/H+ftNBi6b3QZ5IkQc2
         eujTRREKpYECqP4bKIvTjhUQ49kx8PY6vBh/bF2Am1+hNVQw6oghcLU8q4nb9BvX/5n0
         u20Z3sUZEaxyoxSw6VYco7N/cqz6DBWThBtmbfVDGEHP7kktoMsqxxWzDbHfmXqumvWU
         G4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=Hz8/LBSLAMtznbO6y+dgYRRd3hfNu01QCFthMW4VU3Y=;
        b=nJ1iPemyq5ra4uOEOYULxUnv1AjzxIBiLjmOIy/40qUL97sh2KM+ClQ7Kz2/aSJZkR
         MUDf9qSSlMyQWHLZ5LDzi8KlCsif9pDHLTGAA9OOS573dYGo5kEe+ZXjoIXs2wqLROkp
         Xjtuo6OeBUXisWlVqNS+yYHaRr6DNdriUSrRdOaROuc7hr72UmN+ngq2FbCfGAEWOL9M
         95daqLUrjS1392QyZAMttr/9XXHkHfh9OYo1HbKXNjWPffch/7k8lr3Im3pWWKyl9idX
         Yu9BCfQYxDNuGzJCMqmyf0sZFTCMnbgZ62smj7jqrbZhldQCJkA42D981CrMc22jQEC4
         lgCg==
X-Gm-Message-State: AOAM532phnXUc416Bz9Pk1HXDNL46Z8EU0N1ytAlzXwVhkATYgFhGpPv
	XhoZKhBX298Vlagu4v5G/oVY4BG/vsc=
X-Google-Smtp-Source: ABdhPJynqTnR/goX9vWQRxeGCLrfXyTeyVlhnfykUiXBZdl3XSux4GdOgMjLnuygQslpLD9Ju8wI6w==
X-Received: by 2002:a17:90a:1549:: with SMTP id y9mr2058335pja.116.1591058393837;
        Mon, 01 Jun 2020 17:39:53 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from octo.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id l187sm465729pfl.218.2020.06.01.17.39.52
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 17:39:53 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 1/6] docs: delete reference to obsolete recipe-depends.dot
Date: Mon,  1 Jun 2020 14:39:31 -1000
Message-Id: <be367887b0a729ef01fc04f2b91368612ed92ed3.1591058197.git.steve@sakoman.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1591058197.git.steve@sakoman.com>
References: <cover.1591058197.git.steve@sakoman.com>

From: "Robert P. J. Day" <rpjday@crashcourse.ca>

Given that generation of recipe-depends.dot was removed:

  commit 4c484cc01e3eee7ab2ab0359fd680b4dbd31dc30
  Author: Chen Qi <Qi.Chen@windriver.com>
  Date:   Thu Aug 22 15:52:51 2019 +0800

      cooker.py: remove generation of recipe-depends.dot

      The information of recipe-depends.dot is misleading.

delete mention of it from the user manual.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 2effbb6e10b07dc12e4ecdf449ca29fc20968c59)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-intro.xml | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.xml b/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
index f5526c05..995c2fa7 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
@@ -694,14 +694,9 @@
                 </para>
 
                 <para>
-                    When you generate a dependency graph, BitBake writes three files
+                    When you generate a dependency graph, BitBake writes two files
                     to the current working directory:
                     <itemizedlist>
-                        <listitem><para>
-                            <emphasis><filename>recipe-depends.dot</filename>:</emphasis>
-                            Shows dependencies between recipes (i.e. a collapsed version of
-                            <filename>task-depends.dot</filename>).
-                            </para></listitem>
                         <listitem><para>
                             <emphasis><filename>task-depends.dot</filename>:</emphasis>
                             Shows dependencies between tasks.
-- 
2.17.1

