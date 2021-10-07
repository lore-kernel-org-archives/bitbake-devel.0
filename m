Return-Path: <jdmason@kudzu.us>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B14C4167D
	for <webhook@archiver.kernel.org>; Thu,  7 Oct 2021 15:06:41 +0000 (UTC)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by mx.groups.io with SMTP id smtpd.web09.13172.1633619200238573681
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Oct 2021 08:06:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kudzu-us.20210112.gappssmtp.com header.s=20210112
 header.b=gBBazmDJ;
 spf=none, err=permanent DNS error (domain: kudzu.us, ip: 209.85.160.177,
 mailfrom: jdmason@kudzu.us)
Received: by mail-qt1-f177.google.com with SMTP id x9so6551863qtv.0
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Oct 2021 08:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wKaphKhdn0TYy/e+BD3gDkpA8EedPhNO029wS/QANPY=;
        b=gBBazmDJYLx+DXiaCPf4OEcVbqwQOaW+4zoXfuK133aAyPrdtuk8JkoHo/WGN9L8+g
         ui3xLBfxFC7Zu7+8vlMLiLYERnYz+mfChMGrpNd3IYWE3tL5Uc0udDE9AL5HxHFfnHQ4
         KdnZJBlsAWtKgjFt1L4CxCQbbXbI5Hsp7ukIT63ynHv1sBDwC40kc5AUdlEpMD42tdVL
         oMIcxyzeoJ5QEz4VamHJK4mIs03t0PzePNMqWhiK9Wo3VoiD0RFDXCslMVyOMK/lgPUE
         Oy/nmgNxeVp5hdxzpEttKhMlTDn1v4UhgrVSRIsYeMpYwoKu3dwEJr6NmtmWg5KakiYO
         sIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wKaphKhdn0TYy/e+BD3gDkpA8EedPhNO029wS/QANPY=;
        b=q7FDDJWJLfz4dTHac5vgO3HLZeVW/vKzzWeOGlIQ/UoQJDcAQ0cMOpauQMyThu7RE1
         QTlemLl+yLeYLn2ZMxizxPZt1sZX+aUPZFoZX3ohE0VOeHE3NSvSn7xtCad7ck0lnAq+
         K2dUTG23vF4KTCoqGITlNpNXJMxCxT18IC829c7Vu4SS9x38OiQ80/0svbhtu1wf9tXj
         6HFNwnm6wX5zC5LmLNFKSZNymKqIRJhTDn2qjvLGSOIdOxaj4nuyC+D1oQh39YL2c/iA
         TEszmX2ICPHbxhfSALqXqvvteKr3hWS1wVeB9jmDlTqZw2u4WrOCWXaDm/s0Byo2j/Lg
         i66A==
X-Gm-Message-State: AOAM532RmzpvAKnzw5a535UNdt/J3xIyTGR+b3sFtdP11sEEtzm4FvKs
	b8tkzT0VtVpzvwjg+JsJZtjLmg==
X-Google-Smtp-Source: 
 ABdhPJylOyitp4eox5fXGUO9Boxy8FIlIW/IQrihEQzpp+OOFWLKEcV1BBDyqhnaiICVlfU0YOcfXw==
X-Received: by 2002:ac8:7319:: with SMTP id x25mr5487352qto.147.1633619199312;
        Thu, 07 Oct 2021 08:06:39 -0700 (PDT)
Received: from localhost ([2605:a601:a650:b700:9937:f30b:7d2e:fddf])
        by smtp.gmail.com with ESMTPSA id
 l20sm17379891qtk.19.2021.10.07.08.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 08:06:39 -0700 (PDT)
From: Jon Mason <jdmason@kudzu.us>
To: openembedded-core@lists.openembedded.org,
	docs@lists.yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Subject: [PATCH 7/8] documentation: use YOCTO_DL_URL
Date: Thu,  7 Oct 2021 11:06:29 -0400
Message-Id: <20211007150630.22138-8-jdmason@kudzu.us>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211007150630.22138-1-jdmason@kudzu.us>
References: <20211007150630.22138-1-jdmason@kudzu.us>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 Oct 2021 15:06:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12748

Signed-off-by: Jon Mason <jdmason@kudzu.us>
---
 documentation/profile-manual/usage.rst | 28 +++++++++++++-------------
 documentation/ref-manual/faq.rst       | 16 +++++++--------
 documentation/ref-manual/variables.rst |  8 ++++----
 3 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/documentation/profile-manual/usage.rst b/documentation/profile-manual/usage.rst
index 0c21ab14dec4..3d2840884f9a 100644
--- a/documentation/profile-manual/usage.rst
+++ b/documentation/profile-manual/usage.rst
@@ -105,18 +105,18 @@ can be used in a very similar way to the whole host of supported BusyBox
 applets in Yocto. ::
 
    root@crownbay:~# rm linux-2.6.19.2.tar.bz2; \
-                    wget https://downloads.yoctoproject.org/mirror/sources/linux-2.6.19.2.tar.bz2
+                    wget &YOCTO_DL_URL;/mirror/sources/linux-2.6.19.2.tar.bz2
 
 The quickest and easiest way to get some basic overall data about what's
 going on for a particular workload is to profile it using 'perf stat'.
 'perf stat' basically profiles using a few default counters and displays
 the summed counts at the end of the run::
 
-   root@crownbay:~# perf stat wget https://downloads.yoctoproject.org/mirror/sources/linux-2.6.19.2.tar.bz2
+   root@crownbay:~# perf stat wget &YOCTO_DL_URL;/mirror/sources/linux-2.6.19.2.tar.bz2
    Connecting to downloads.yoctoproject.org (140.211.169.59:80)
    linux-2.6.19.2.tar.b 100% |***************************************************| 41727k  0:00:00 ETA
 
-   Performance counter stats for 'wget https://downloads.yoctoproject.org/mirror/sources/linux-2.6.19.2.tar.bz2':
+   Performance counter stats for 'wget &YOCTO_DL_URL;/mirror/sources/linux-2.6.19.2.tar.bz2':
 
          4597.223902 task-clock                #    0.077 CPUs utilized
                23568 context-switches          #    0.005 M/sec
@@ -141,11 +141,11 @@ by 'perf stat'. For example, suppose we wanted to see a summary of all
 the events related to kernel memory allocation/freeing along with cache
 hits and misses::
 
-   root@crownbay:~# perf stat -e kmem:* -e cache-references -e cache-misses wget https://downloads.yoctoproject.org/mirror/sources/linux-2.6.19.2.tar.bz2
+   root@crownbay:~# perf stat -e kmem:* -e cache-references -e cache-misses wget &YOCTO_DL_URL;/mirror/sources/linux-2.6.19.2.tar.bz2
    Connecting to downloads.yoctoproject.org (140.211.169.59:80)
    linux-2.6.19.2.tar.b 100% |***************************************************| 41727k  0:00:00 ETA
 
-   Performance counter stats for 'wget https://downloads.yoctoproject.org/mirror/sources/linux-2.6.19.2.tar.bz2':
+   Performance counter stats for 'wget &YOCTO_DL_URL;/mirror/sources/linux-2.6.19.2.tar.bz2':
 
                 5566 kmem:kmalloc
               125517 kmem:kmem_cache_alloc
@@ -181,7 +181,7 @@ executed in a new shell). perf collects samples until the process exits
 and records them in a file named 'perf.data' in the current working
 directory. ::
 
-   root@crownbay:~# perf record wget https://downloads.yoctoproject.org/mirror/sources/linux-2.6.19.2.tar.bz2
+   root@crownbay:~# perf record wget &YOCTO_DL_URL;/mirror/sources/linux-2.6.19.2.tar.bz2
 
    Connecting to downloads.yoctoproject.org (140.211.169.59:80)
    linux-2.6.19.2.tar.b 100% |************************************************| 41727k  0:00:00 ETA
@@ -219,7 +219,7 @@ between the new profile and the previous one is that we'll add the -g
 option, which will record not just the address of a sampled function,
 but the entire callchain to the sampled function as well::
 
-   root@crownbay:~# perf record -g wget https://downloads.yoctoproject.org/mirror/sources/linux-2.6.19.2.tar.bz2
+   root@crownbay:~# perf record -g wget &YOCTO_DL_URL;/mirror/sources/linux-2.6.19.2.tar.bz2
    Connecting to downloads.yoctoproject.org (140.211.169.59:80)
    linux-2.6.19.2.tar.b 100% |************************************************| 41727k  0:00:00 ETA
    [ perf record: Woken up 3 times to write data ]
@@ -527,8 +527,8 @@ workload, so let's choose the most likely subsystems (identified by the
 string before the colon in the Tracepoint events) and do a 'perf stat'
 run using only those wildcarded subsystems::
 
-   root@crownbay:~# perf stat -e skb:* -e net:* -e napi:* -e sched:* -e workqueue:* -e irq:* -e syscalls:* wget https://downloads.yoctoproject.org/mirror/sources/linux-2.6.19.2.tar.bz2
-   Performance counter stats for 'wget https://downloads.yoctoproject.org/mirror/sources/linux-2.6.19.2.tar.bz2':
+   root@crownbay:~# perf stat -e skb:* -e net:* -e napi:* -e sched:* -e workqueue:* -e irq:* -e syscalls:* wget &YOCTO_DL_URL;/mirror/sources/linux-2.6.19.2.tar.bz2
+   Performance counter stats for 'wget &YOCTO_DL_URL;/mirror/sources/linux-2.6.19.2.tar.bz2':
 
                23323 skb:kfree_skb
                    0 skb:consume_skb
@@ -589,7 +589,7 @@ run using only those wildcarded subsystems::
 Let's pick one of these tracepoints
 and tell perf to do a profile using it as the sampling event::
 
-   root@crownbay:~# perf record -g -e sched:sched_wakeup wget https://downloads.yoctoproject.org/mirror/sources/linux-2.6.19.2.tar.bz2
+   root@crownbay:~# perf record -g -e sched:sched_wakeup wget &YOCTO_DL_URL;/mirror/sources/linux-2.6.19.2.tar.bz2
 
 .. image:: figures/sched-wakeup-profile.png
    :align: center
@@ -648,7 +648,7 @@ applicable to our workload::
 
    root@crownbay:~# perf record -g -e skb:* -e net:* -e napi:* -e sched:sched_switch -e sched:sched_wakeup -e irq:*
     -e syscalls:sys_enter_read -e syscalls:sys_exit_read -e syscalls:sys_enter_write -e syscalls:sys_exit_write
-    wget https://downloads.yoctoproject.org/mirror/sources/linux-2.6.19.2.tar.bz2
+    wget &YOCTO_DL_URL;/mirror/sources/linux-2.6.19.2.tar.bz2
 
 We can look at the raw trace output using 'perf script' with no
 arguments::
@@ -885,7 +885,7 @@ To demonstrate this, open up one window and start the profile using the
 
 In another window, run the wget test::
 
-   root@crownbay:~# wget https://downloads.yoctoproject.org/mirror/sources/linux-2.6.19.2.tar.bz2
+   root@crownbay:~# wget &YOCTO_DL_URL;/mirror/sources/linux-2.6.19.2.tar.bz2
    Connecting to downloads.yoctoproject.org (140.211.169.59:80)
    linux-2.6.19.2.tar.b 100% \|*******************************\| 41727k 0:00:00 ETA
 
@@ -2251,7 +2251,7 @@ of the block device you want to trace activity on::
 
 In another shell, execute a workload you want to trace. ::
 
-   root@crownbay:/media/sdc# rm linux-2.6.19.2.tar.bz2; wget https://downloads.yoctoproject.org/mirror/sources/linux-2.6.19.2.tar.bz2; sync
+   root@crownbay:/media/sdc# rm linux-2.6.19.2.tar.bz2; wget &YOCTO_DL_URL;/mirror/sources/linux-2.6.19.2.tar.bz2; sync
    Connecting to downloads.yoctoproject.org (140.211.169.59:80)
    linux-2.6.19.2.tar.b 100% \|*******************************\| 41727k 0:00:00 ETA
 
@@ -2420,7 +2420,7 @@ On the target system, you should see this::
 
 In another shell, execute a workload you want to trace. ::
 
-   root@crownbay:/media/sdc# rm linux-2.6.19.2.tar.bz2; wget https://downloads.yoctoproject.org/mirror/sources/linux-2.6.19.2.tar.bz2; sync
+   root@crownbay:/media/sdc# rm linux-2.6.19.2.tar.bz2; wget &YOCTO_DL_URL;/mirror/sources/linux-2.6.19.2.tar.bz2; sync
    Connecting to downloads.yoctoproject.org (140.211.169.59:80)
    linux-2.6.19.2.tar.b 100% \|*******************************\| 41727k 0:00:00 ETA
 
diff --git a/documentation/ref-manual/faq.rst b/documentation/ref-manual/faq.rst
index 0d547b2d1bfa..e1b95f183a64 100644
--- a/documentation/ref-manual/faq.rst
+++ b/documentation/ref-manual/faq.rst
@@ -302,10 +302,10 @@ attempt before any others by adding something like the following to the
 ``local.conf`` configuration file::
 
    PREMIRRORS:prepend = "\
-       git://.*/.* https://downloads.yoctoproject.org/mirror/sources/ \n \
-       ftp://.*/.* https://downloads.yoctoproject.org/mirror/sources/ \n \
-       http://.*/.* https://downloads.yoctoproject.org/mirror/sources/ \n \
-       https://.*/.* https://downloads.yoctoproject.org/mirror/sources/ \n"
+       git://.*/.* &YOCTO_DL_URL;/mirror/sources/ \n \
+       ftp://.*/.* &YOCTO_DL_URL;/mirror/sources/ \n \
+       http://.*/.* &YOCTO_DL_URL;/mirror/sources/ \n \
+       https://.*/.* &YOCTO_DL_URL;/mirror/sources/ \n"
 
 These changes cause the build system to intercept Git, FTP, HTTP, and
 HTTPS requests and direct them to the ``http://`` sources mirror. You
@@ -342,10 +342,10 @@ You could make the following changes to the ``local.conf`` configuration
 file as long as the :term:`PREMIRRORS` server is current::
 
    PREMIRRORS:prepend = "\
-       git://.*/.* https://downloads.yoctoproject.org/mirror/sources/ \n \
-       ftp://.*/.* https://downloads.yoctoproject.org/mirror/sources/ \n \
-       http://.*/.* https://downloads.yoctoproject.org/mirror/sources/ \n \
-       https://.*/.* https://downloads.yoctoproject.org/mirror/sources/ \n"
+       git://.*/.* &YOCTO_DL_URL;/mirror/sources/ \n \
+       ftp://.*/.* &YOCTO_DL_URL;/mirror/sources/ \n \
+       http://.*/.* &YOCTO_DL_URL;/mirror/sources/ \n \
+       https://.*/.* &YOCTO_DL_URL;/mirror/sources/ \n"
    BB_FETCH_PREMIRRORONLY = "1"
 
 These changes would cause the build system to successfully fetch source
diff --git a/documentation/ref-manual/variables.rst b/documentation/ref-manual/variables.rst
index b0c2c92c1a00..c6776838aedc 100644
--- a/documentation/ref-manual/variables.rst
+++ b/documentation/ref-manual/variables.rst
@@ -5838,10 +5838,10 @@ system and gives an overview of their function and contents.
       :term:`Build Directory`::
 
          PREMIRRORS:prepend = "\
-             git://.*/.* https://downloads.yoctoproject.org/mirror/sources/ \n \
-             ftp://.*/.* https://downloads.yoctoproject.org/mirror/sources/ \n \
-             http://.*/.* https://downloads.yoctoproject.org/mirror/sources/ \n \
-             https://.*/.* https://downloads.yoctoproject.org/mirror/sources/ \n"
+             git://.*/.* &YOCTO_DL_URL;/mirror/sources/ \n \
+             ftp://.*/.* &YOCTO_DL_URL;/mirror/sources/ \n \
+             http://.*/.* &YOCTO_DL_URL;/mirror/sources/ \n \
+             https://.*/.* &YOCTO_DL_URL;/mirror/sources/ \n"
 
       These changes cause the
       build system to intercept Git, FTP, HTTP, and HTTPS requests and
-- 
2.20.1


