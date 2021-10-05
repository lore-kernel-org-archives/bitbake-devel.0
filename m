Return-Path: <jdmason@kudzu.us>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFCFC433FE
	for <webhook@archiver.kernel.org>; Tue,  5 Oct 2021 22:45:15 +0000 (UTC)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42])
 by mx.groups.io with SMTP id smtpd.web10.4135.1633473915019704888
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 Oct 2021 15:45:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kudzu-us.20210112.gappssmtp.com header.s=20210112
 header.b=d1VlCKH0;
 spf=none, err=permanent DNS error (domain: kudzu.us, ip: 209.85.219.42,
 mailfrom: jdmason@kudzu.us)
Received: by mail-qv1-f42.google.com with SMTP id z15so689188qvj.7
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 Oct 2021 15:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EuUI96CGHQEpFRJpMni1BmewKt3Hw8SQSaggmgZ0GfI=;
        b=d1VlCKH0VQqry05g0EFY4IQfgu2m2fPkNmEeugzaYzn59qL+k02xy2RHCczuj36YCV
         9DgcvJLa7CWnVsNlToDm1ljNF/dd2qpQNTZbT4IqJhMHkjWkRp0qXgoTbSDbCC1X1LrL
         ZnxWSSICLOUchc5ZFALgasjPpY7VVJaH8+XO/wDY627F3nsexQgeqc63g0rUdsns0tWB
         kmkrPcYJEBsfU29tj57x28UbeG6nv52MTHA5TSy2Zb9DWjt08467vDobM+0/5ctCno0l
         cNAj5tH2OMDhyV6P0hEzFw1j3gjPNAo3BdCbhcZp1/Qat/rpRAw3qa744Hw++YNxVeTt
         bXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EuUI96CGHQEpFRJpMni1BmewKt3Hw8SQSaggmgZ0GfI=;
        b=yV+WhSlmoFiGZ09tIOvhqp7a976jk7Xmm/iCkkizdmBVeYqWh3+ViM+bHYhmYUVUGq
         0g2xirArbNx7hpNceCzdvuAXAzKPQIncPjY/nMA+QhlzTu0HqHtRF2xSRVUJfcunhmmB
         zToEGCdhdkVqe/bjSwDSr1AIVmn6Ikk61zdmU/6kj64Vc7N2fc7LdcdsEEQfpspAeK3c
         xqmmNWN32lX1i99LGqcDlj6QzsyAVMI6yDtWP0wmfgXK4+/3uiEdjQNO/e20oWvkdhYE
         jmlaLru6YuQ4NtOcTl2lK1MbomKW8uvOkQeScIW08Nu/Ly7Y881JwNVuFGSYnZW7HaV+
         beLw==
X-Gm-Message-State: AOAM531R9TP1QUtMYgL+jdYXmttngIhtc4prR3rjbkjT1EiJ35LSq9wj
	lw3YjF3wfpNFCVl3E5jxSVt2z9bY1WIGTA==
X-Google-Smtp-Source: 
 ABdhPJxQjdH7WR8MCgky7grTOqtsN6tG/Hx6T6GStkEbH/5/3Ay+DGpkQ4ECTCt2QetJrDmDU2Vk0A==
X-Received: by 2002:ad4:4622:: with SMTP id x2mr17917896qvv.39.1633473914045;
        Tue, 05 Oct 2021 15:45:14 -0700 (PDT)
Received: from localhost ([2605:a601:a650:b700:9878:6bc:c765:2aac])
        by smtp.gmail.com with ESMTPSA id
 w23sm2343028qts.89.2021.10.05.15.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 15:45:13 -0700 (PDT)
From: Jon Mason <jdmason@kudzu.us>
To: docs@lists.yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] documentation: update sources mirror URL
Date: Tue,  5 Oct 2021 18:45:12 -0400
Message-Id: <20211005224513.14134-1-jdmason@kudzu.us>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 05 Oct 2021 22:45:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12727

The URL for the sources mirror no longer works.  Update to the new
location.

Signed-off-by: Jon Mason <jdmason@kudzu.us>
---
 documentation/ref-manual/faq.rst       | 15 ++++++++-------
 documentation/ref-manual/variables.rst |  8 ++++----
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/documentation/ref-manual/faq.rst b/documentation/ref-manual/faq.rst
index d3a603d4a438..f06abc84ee6f 100644
--- a/documentation/ref-manual/faq.rst
+++ b/documentation/ref-manual/faq.rst
@@ -302,10 +302,10 @@ attempt before any others by adding something like the following to the
 ``local.conf`` configuration file::
 
    PREMIRRORS:prepend = "\
-       git://.*/.* http://www.yoctoproject.org/sources/ \n \
-       ftp://.*/.* http://www.yoctoproject.org/sources/ \n \
-       http://.*/.* http://www.yoctoproject.org/sources/ \n \
-       https://.*/.* http://www.yoctoproject.org/sources/ \n"
+       git://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n \
+       ftp://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n \
+       http://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n \
+       https://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n"
 
 These changes cause the build system to intercept Git, FTP, HTTP, and
 HTTPS requests and direct them to the ``http://`` sources mirror. You
@@ -342,9 +342,10 @@ You could make the following changes to the ``local.conf`` configuration
 file as long as the :term:`PREMIRRORS` server is current::
 
    PREMIRRORS:prepend = "\
-       ftp://.*/.* http://www.yoctoproject.org/sources/ \n \
-       http://.*/.* http://www.yoctoproject.org/sources/ \n \
-       https://.*/.* http://www.yoctoproject.org/sources/ \n"
+       git://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n \
+       ftp://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n \
+       http://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n \
+       https://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n"
    BB_FETCH_PREMIRRORONLY = "1"
 
 These changes would cause the build system to successfully fetch source
diff --git a/documentation/ref-manual/variables.rst b/documentation/ref-manual/variables.rst
index 5f6f91146bf0..97782d8ec7ed 100644
--- a/documentation/ref-manual/variables.rst
+++ b/documentation/ref-manual/variables.rst
@@ -5838,10 +5838,10 @@ system and gives an overview of their function and contents.
       :term:`Build Directory`::
 
          PREMIRRORS:prepend = "\
-             git://.*/.* http://www.yoctoproject.org/sources/ \n \
-             ftp://.*/.* http://www.yoctoproject.org/sources/ \n \
-             http://.*/.* http://www.yoctoproject.org/sources/ \n \
-             https://.*/.* http://www.yoctoproject.org/sources/ \n"
+             git://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n \
+             ftp://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n \
+             http://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n \
+             https://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n"
 
       These changes cause the
       build system to intercept Git, FTP, HTTP, and HTTPS requests and
-- 
2.20.1


