Return-Path: <jdmason@kudzu.us>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C71EC43217
	for <webhook@archiver.kernel.org>; Thu,  7 Oct 2021 15:06:40 +0000 (UTC)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
 by mx.groups.io with SMTP id smtpd.web12.13040.1633619199195510599
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Oct 2021 08:06:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kudzu-us.20210112.gappssmtp.com header.s=20210112
 header.b=WaCGNiAj;
 spf=none, err=permanent DNS error (domain: kudzu.us, ip: 209.85.160.181,
 mailfrom: jdmason@kudzu.us)
Received: by mail-qt1-f181.google.com with SMTP id e16so6381352qte.13
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Oct 2021 08:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kGYdd95D5xyiJPu05k0HivvJQcCrWq/zX8ZYtVdnV5g=;
        b=WaCGNiAjpSmdVo7Six8TBpg0Y2fWS7sR9fjDyDHyqAb04pq5z91I4fLeDh5VIMlNo4
         ziKH8KBmO1ZVgG/9t9nHBPxkDd2pWvxhASoMVGGsfIXVx54WaSw19FnhM/WItctCzOS8
         93NMtIS7yvOwBpOT8DbeaLyno+XtsdeqDlDSA8SWqJPFnkir8MdtDxQn0YTzwZOlmCMw
         CURSihOZGtsq2WsHdwZ2KZ7qjn676tkpC+tq5AgjjExqozKpXkgntVEyicxtKsbL38Zd
         i6VnBjQs+3kbln+Ilzy+70R1yofQ9RRRsnRFVnnMfuDrt9qqJb/Y6AFjs4O51xbtLXVG
         CQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kGYdd95D5xyiJPu05k0HivvJQcCrWq/zX8ZYtVdnV5g=;
        b=tYGvvImMJhuMztP+O0wMN3mzP8UTFcXcdrqvIL93Ei5/y+CAtdkzQxbWe0pJc0RLb9
         cxBRrKEFk5Wy13cuZzlT+HH6qC+dP7F/Exdc3vM2dqJrYd/vT1pafKliFb6rtAUzdPk8
         KACqpfdFQyp9vAzjcao6yApZt4BWeTd3qHRpH1LXp5xVzVWf8r3EzhyD+8Wwze44Xf5i
         SaFOck6xlZ5DJxwG88Yktrfesf7TpbimZNL3MG7VaHPHPSQtCR9MoSYb18jid4M2mtcV
         EA4oN06rvWZbVLo1Jdrk5JL6lmkh7I4bzI4YW/McjEm79UsJd3BzJN8YSlaK+aEwCY9v
         pNRw==
X-Gm-Message-State: AOAM5306nALauP5GBPxEACDXxQ8JZmagARlvX0rruDnM/kKL38RbMk1d
	5UtZiLZfL6pJP6tM/nJ5EQE9sA==
X-Google-Smtp-Source: 
 ABdhPJyzWWxqKgPdVWTuaOxkT+19pT7f4weMYCZrlQCOMe0GeJM4qszRG+Cw3eowrpIZmqBKZsDpdQ==
X-Received: by 2002:ac8:7c96:: with SMTP id y22mr2057389qtv.338.1633619198172;
        Thu, 07 Oct 2021 08:06:38 -0700 (PDT)
Received: from localhost ([2605:a601:a650:b700:9937:f30b:7d2e:fddf])
        by smtp.gmail.com with ESMTPSA id
 b14sm14186346qkl.81.2021.10.07.08.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 08:06:37 -0700 (PDT)
From: Jon Mason <jdmason@kudzu.us>
To: openembedded-core@lists.openembedded.org,
	docs@lists.yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Subject: [PATCH 6/8] documentation: replace http with https for URLs
Date: Thu,  7 Oct 2021 11:06:28 -0400
Message-Id: <20211007150630.22138-7-jdmason@kudzu.us>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211007150630.22138-1-jdmason@kudzu.us>
References: <20211007150630.22138-1-jdmason@kudzu.us>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 Oct 2021 15:06:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12747

https has been the preferred way to access websites for many years now.
Change all of the URLs with a _working_ https server/certificate to use
that URL.

Signed-off-by: Jon Mason <jdmason@kudzu.us>
---
 documentation/profile-manual/usage.rst     | 28 +++++++++++-----------
 documentation/ref-manual/faq.rst           | 16 ++++++-------
 documentation/ref-manual/variables.rst     |  8 +++----
 documentation/toaster-manual/reference.rst |  8 +++----
 4 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/documentation/profile-manual/usage.rst b/documentation/profile-manual/usage.rst
index ae4efa7f4cb7..0c21ab14dec4 100644
--- a/documentation/profile-manual/usage.rst
+++ b/documentation/profile-manual/usage.rst
@@ -105,18 +105,18 @@ can be used in a very similar way to the whole host of supported BusyBox
 applets in Yocto. ::
 
    root@crownbay:~# rm linux-2.6.19.2.tar.bz2; \
-                    wget http://downloads.yoctoproject.org/mirror/sources/linux-2.6.19.2.tar.bz2
+                    wget https://downloads.yoctoproject.org/mirror/sources/linux-2.6.19.2.tar.bz2
 
 The quickest and easiest way to get some basic overall data about what's
 going on for a particular workload is to profile it using 'perf stat'.
 'perf stat' basically profiles using a few default counters and displays
 the summed counts at the end of the run::
 
-   root@crownbay:~# perf stat wget http://downloads.yoctoproject.org/mirror/sources/linux-2.6.19.2.tar.bz2
+   root@crownbay:~# perf stat wget https://downloads.yoctoproject.org/mirror/sources/linux-2.6.19.2.tar.bz2
    Connecting to downloads.yoctoproject.org (140.211.169.59:80)
    linux-2.6.19.2.tar.b 100% |***************************************************| 41727k  0:00:00 ETA
 
-   Performance counter stats for 'wget http://downloads.yoctoproject.org/mirror/sources/linux-2.6.19.2.tar.bz2':
+   Performance counter stats for 'wget https://downloads.yoctoproject.org/mirror/sources/linux-2.6.19.2.tar.bz2':
 
          4597.223902 task-clock                #    0.077 CPUs utilized
                23568 context-switches          #    0.005 M/sec
@@ -141,11 +141,11 @@ by 'perf stat'. For example, suppose we wanted to see a summary of all
 the events related to kernel memory allocation/freeing along with cache
 hits and misses::
 
-   root@crownbay:~# perf stat -e kmem:* -e cache-references -e cache-misses wget http://downloads.yoctoproject.org/mirror/sources/linux-2.6.19.2.tar.bz2
+   root@crownbay:~# perf stat -e kmem:* -e cache-references -e cache-misses wget https://downloads.yoctoproject.org/mirror/sources/linux-2.6.19.2.tar.bz2
    Connecting to downloads.yoctoproject.org (140.211.169.59:80)
    linux-2.6.19.2.tar.b 100% |***************************************************| 41727k  0:00:00 ETA
 
-   Performance counter stats for 'wget http://downloads.yoctoproject.org/mirror/sources/linux-2.6.19.2.tar.bz2':
+   Performance counter stats for 'wget https://downloads.yoctoproject.org/mirror/sources/linux-2.6.19.2.tar.bz2':
 
                 5566 kmem:kmalloc
               125517 kmem:kmem_cache_alloc
@@ -181,7 +181,7 @@ executed in a new shell). perf collects samples until the process exits
 and records them in a file named 'perf.data' in the current working
 directory. ::
 
-   root@crownbay:~# perf record wget http://downloads.yoctoproject.org/mirror/sources/linux-2.6.19.2.tar.bz2
+   root@crownbay:~# perf record wget https://downloads.yoctoproject.org/mirror/sources/linux-2.6.19.2.tar.bz2
 
    Connecting to downloads.yoctoproject.org (140.211.169.59:80)
    linux-2.6.19.2.tar.b 100% |************************************************| 41727k  0:00:00 ETA
@@ -219,7 +219,7 @@ between the new profile and the previous one is that we'll add the -g
 option, which will record not just the address of a sampled function,
 but the entire callchain to the sampled function as well::
 
-   root@crownbay:~# perf record -g wget http://downloads.yoctoproject.org/mirror/sources/linux-2.6.19.2.tar.bz2
+   root@crownbay:~# perf record -g wget https://downloads.yoctoproject.org/mirror/sources/linux-2.6.19.2.tar.bz2
    Connecting to downloads.yoctoproject.org (140.211.169.59:80)
    linux-2.6.19.2.tar.b 100% |************************************************| 41727k  0:00:00 ETA
    [ perf record: Woken up 3 times to write data ]
@@ -527,8 +527,8 @@ workload, so let's choose the most likely subsystems (identified by the
 string before the colon in the Tracepoint events) and do a 'perf stat'
 run using only those wildcarded subsystems::
 
-   root@crownbay:~# perf stat -e skb:* -e net:* -e napi:* -e sched:* -e workqueue:* -e irq:* -e syscalls:* wget http://downloads.yoctoproject.org/mirror/sources/linux-2.6.19.2.tar.bz2
-   Performance counter stats for 'wget http://downloads.yoctoproject.org/mirror/sources/linux-2.6.19.2.tar.bz2':
+   root@crownbay:~# perf stat -e skb:* -e net:* -e napi:* -e sched:* -e workqueue:* -e irq:* -e syscalls:* wget https://downloads.yoctoproject.org/mirror/sources/linux-2.6.19.2.tar.bz2
+   Performance counter stats for 'wget https://downloads.yoctoproject.org/mirror/sources/linux-2.6.19.2.tar.bz2':
 
                23323 skb:kfree_skb
                    0 skb:consume_skb
@@ -589,7 +589,7 @@ run using only those wildcarded subsystems::
 Let's pick one of these tracepoints
 and tell perf to do a profile using it as the sampling event::
 
-   root@crownbay:~# perf record -g -e sched:sched_wakeup wget http://downloads.yoctoproject.org/mirror/sources/linux-2.6.19.2.tar.bz2
+   root@crownbay:~# perf record -g -e sched:sched_wakeup wget https://downloads.yoctoproject.org/mirror/sources/linux-2.6.19.2.tar.bz2
 
 .. image:: figures/sched-wakeup-profile.png
    :align: center
@@ -648,7 +648,7 @@ applicable to our workload::
 
    root@crownbay:~# perf record -g -e skb:* -e net:* -e napi:* -e sched:sched_switch -e sched:sched_wakeup -e irq:*
     -e syscalls:sys_enter_read -e syscalls:sys_exit_read -e syscalls:sys_enter_write -e syscalls:sys_exit_write
-    wget http://downloads.yoctoproject.org/mirror/sources/linux-2.6.19.2.tar.bz2
+    wget https://downloads.yoctoproject.org/mirror/sources/linux-2.6.19.2.tar.bz2
 
 We can look at the raw trace output using 'perf script' with no
 arguments::
@@ -885,7 +885,7 @@ To demonstrate this, open up one window and start the profile using the
 
 In another window, run the wget test::
 
-   root@crownbay:~# wget http://downloads.yoctoproject.org/mirror/sources/linux-2.6.19.2.tar.bz2
+   root@crownbay:~# wget https://downloads.yoctoproject.org/mirror/sources/linux-2.6.19.2.tar.bz2
    Connecting to downloads.yoctoproject.org (140.211.169.59:80)
    linux-2.6.19.2.tar.b 100% \|*******************************\| 41727k 0:00:00 ETA
 
@@ -2251,7 +2251,7 @@ of the block device you want to trace activity on::
 
 In another shell, execute a workload you want to trace. ::
 
-   root@crownbay:/media/sdc# rm linux-2.6.19.2.tar.bz2; wget http://downloads.yoctoproject.org/mirror/sources/linux-2.6.19.2.tar.bz2; sync
+   root@crownbay:/media/sdc# rm linux-2.6.19.2.tar.bz2; wget https://downloads.yoctoproject.org/mirror/sources/linux-2.6.19.2.tar.bz2; sync
    Connecting to downloads.yoctoproject.org (140.211.169.59:80)
    linux-2.6.19.2.tar.b 100% \|*******************************\| 41727k 0:00:00 ETA
 
@@ -2420,7 +2420,7 @@ On the target system, you should see this::
 
 In another shell, execute a workload you want to trace. ::
 
-   root@crownbay:/media/sdc# rm linux-2.6.19.2.tar.bz2; wget http://downloads.yoctoproject.org/mirror/sources/linux-2.6.19.2.tar.bz2; sync
+   root@crownbay:/media/sdc# rm linux-2.6.19.2.tar.bz2; wget https://downloads.yoctoproject.org/mirror/sources/linux-2.6.19.2.tar.bz2; sync
    Connecting to downloads.yoctoproject.org (140.211.169.59:80)
    linux-2.6.19.2.tar.b 100% \|*******************************\| 41727k 0:00:00 ETA
 
diff --git a/documentation/ref-manual/faq.rst b/documentation/ref-manual/faq.rst
index f06abc84ee6f..0d547b2d1bfa 100644
--- a/documentation/ref-manual/faq.rst
+++ b/documentation/ref-manual/faq.rst
@@ -302,10 +302,10 @@ attempt before any others by adding something like the following to the
 ``local.conf`` configuration file::
 
    PREMIRRORS:prepend = "\
-       git://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n \
-       ftp://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n \
-       http://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n \
-       https://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n"
+       git://.*/.* https://downloads.yoctoproject.org/mirror/sources/ \n \
+       ftp://.*/.* https://downloads.yoctoproject.org/mirror/sources/ \n \
+       http://.*/.* https://downloads.yoctoproject.org/mirror/sources/ \n \
+       https://.*/.* https://downloads.yoctoproject.org/mirror/sources/ \n"
 
 These changes cause the build system to intercept Git, FTP, HTTP, and
 HTTPS requests and direct them to the ``http://`` sources mirror. You
@@ -342,10 +342,10 @@ You could make the following changes to the ``local.conf`` configuration
 file as long as the :term:`PREMIRRORS` server is current::
 
    PREMIRRORS:prepend = "\
-       git://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n \
-       ftp://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n \
-       http://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n \
-       https://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n"
+       git://.*/.* https://downloads.yoctoproject.org/mirror/sources/ \n \
+       ftp://.*/.* https://downloads.yoctoproject.org/mirror/sources/ \n \
+       http://.*/.* https://downloads.yoctoproject.org/mirror/sources/ \n \
+       https://.*/.* https://downloads.yoctoproject.org/mirror/sources/ \n"
    BB_FETCH_PREMIRRORONLY = "1"
 
 These changes would cause the build system to successfully fetch source
diff --git a/documentation/ref-manual/variables.rst b/documentation/ref-manual/variables.rst
index 97782d8ec7ed..b0c2c92c1a00 100644
--- a/documentation/ref-manual/variables.rst
+++ b/documentation/ref-manual/variables.rst
@@ -5838,10 +5838,10 @@ system and gives an overview of their function and contents.
       :term:`Build Directory`::
 
          PREMIRRORS:prepend = "\
-             git://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n \
-             ftp://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n \
-             http://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n \
-             https://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n"
+             git://.*/.* https://downloads.yoctoproject.org/mirror/sources/ \n \
+             ftp://.*/.* https://downloads.yoctoproject.org/mirror/sources/ \n \
+             http://.*/.* https://downloads.yoctoproject.org/mirror/sources/ \n \
+             https://.*/.* https://downloads.yoctoproject.org/mirror/sources/ \n"
 
       These changes cause the
       build system to intercept Git, FTP, HTTP, and HTTPS requests and
diff --git a/documentation/toaster-manual/reference.rst b/documentation/toaster-manual/reference.rst
index c0d02ff9ab26..1bb9f98ccaa2 100644
--- a/documentation/toaster-manual/reference.rst
+++ b/documentation/toaster-manual/reference.rst
@@ -296,7 +296,7 @@ The following defines the releases when you create a new project:
       <field type="CharField" name="description">Yocto Project &DISTRO; "&DISTRO_NAME;"</field>
       <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">1</field>
       <field type="CharField" name="branch_name">&DISTRO_NAME_NO_CAP;</field>
-      <field type="TextField" name="helptext">Toaster will run your builds using the tip of the <a href="http://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=&DISTRO_NAME_NO_CAP;">Yocto Project &DISTRO_NAME; branch</a>.</field>
+      <field type="TextField" name="helptext">Toaster will run your builds using the tip of the <a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=&DISTRO_NAME_NO_CAP;">Yocto Project &DISTRO_NAME; branch</a>.</field>
    </object>
 
 The "pk" value must match the above respective BitBake version record.
@@ -333,9 +333,9 @@ that includes the layer. In general all releases include the layer.
       <field type="CharField" name="name">openembedded-core</field>
       <field type="CharField" name="layer_index_url"></field>
       <field type="CharField" name="vcs_url">git://git.yoctoproject.org/poky</field>
-      <field type="CharField" name="vcs_web_url">http://git.yoctoproject.org/cgit/cgit.cgi/poky</field>
-      <field type="CharField" name="vcs_web_tree_base_url">http://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
-      <field type="CharField" name="vcs_web_file_base_url">http://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
+      <field type="CharField" name="vcs_web_url">https://git.yoctoproject.org/cgit/cgit.cgi/poky</field>
+      <field type="CharField" name="vcs_web_tree_base_url">https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
+      <field type="CharField" name="vcs_web_file_base_url">https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
    </object>
    <object model="orm.layer_version" pk="1">
       <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
-- 
2.20.1


