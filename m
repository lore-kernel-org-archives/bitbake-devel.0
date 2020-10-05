Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web11.33451.1601900835475931094
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 05 Oct 2020 05:27:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=Nel7Jx/V;
 spf=pass (domain: linaro.org, ip: 209.85.221.42, mailfrom: nicolas.dechesne@linaro.org)
Received: by mail-wr1-f42.google.com with SMTP id e17so639361wru.12
        for <bitbake-devel@lists.openembedded.org>; Mon, 05 Oct 2020 05:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YUx9EyO/F3tX9Uu8pXW3jEIWKKfJuXZFefAVFMXIF9c=;
        b=Nel7Jx/ViKuRbKDqNXh6M9S+wj+TP55t5Ukuu8ymSUuOXMXb/odSe9ysGy4SCu1yj7
         ugnb7IaehQZ9dcQL9/8Wynwj8QK5KmsC/Fctt8TkLD/8+N8jhpKp155ORY1LlowfRxHq
         xPuSlFGt3E0gwdlt5PA8C0t9OMWyhtaH6JhdeNsuPlgqtAhPWMOt3jd1JJXp6sR+3F5P
         UxojoWa+SV8PuTiBSxbr53vVLMnmxTuUr8R6imuGNysUGVbRgTn1btvUU/w0UcpbJs9Q
         C+rA5ar+bXxhDn1R2xzIzqHxo38PCh37D2WgGJyo1MVoYbrvq6oRaOdMkA3BFGc6+aS1
         U9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YUx9EyO/F3tX9Uu8pXW3jEIWKKfJuXZFefAVFMXIF9c=;
        b=OcDyMNy0YvbCVMXjd+L4CFSmHDbzWHGNxR5xIHPrTFhWNjcTdcFtSx5g9U+Zoajif8
         PAsQqbEdNLUGIn+XkKwmXMhoulxgE1TsS1djeSeLFrcyAJgo6MRGDrynywDNIc9AqVB0
         +XUL2SS9kM8BgddZa5gKUhN+6+H6vZxf6PFMpnaMp2O646xM6qFIGo8rsZaehbyq08Qg
         gIq595WL4tLouSkdk5vVA38ISrYTLyRj/v9vANiKKUmBQUpsaox7lJsTIpWjJTCQkTu5
         XzUAAfPpDr5eltqDNYTAcF4aBRAeapm/w/oFAeae8vOV0N3unNphH7BMrek9tsAz7/59
         GM/Q==
X-Gm-Message-State: AOAM531Obn98+gCJpf8gqmPS/HoF1K2fqNWO6LQ3aZ+nFkkL+eyDfhha
	lSEh7sRX8Lyi8pznBZ3xDmQ/Q2nqANOOzA==
X-Google-Smtp-Source: ABdhPJx83UkfgjA9cx0kwKlf5m6Nvp6FRZbiuyOHenaADGejtm28OVQQDf4zhtczE5qyNEJY/ITlTQ==
X-Received: by 2002:a5d:460c:: with SMTP id t12mr17572088wrq.225.1601900833372;
        Mon, 05 Oct 2020 05:27:13 -0700 (PDT)
Return-Path: <nicolas.dechesne@linaro.org>
Received: from localhost.localdomain (82-64-249-211.subs.proxad.net. [82.64.249.211])
        by smtp.gmail.com with ESMTPSA id c130sm1953628wma.17.2020.10.05.05.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 05:27:12 -0700 (PDT)
From: "Nicolas Dechesne" <nicolas.dechesne@linaro.org>
To: bitbake-devel@lists.openembedded.org
Cc: foss@0leil.net,
	Nicolas Dechesne <nicolas.dechesne@linaro.org>
Subject: [PATCH 2/5] docs: sphinx: replace special quotes with double quotes
Date: Mon,  5 Oct 2020 14:26:49 +0200
Message-Id: <20201005122652.392528-3-nicolas.dechesne@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005122652.392528-1-nicolas.dechesne@linaro.org>
References: <20201005122652.392528-1-nicolas.dechesne@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Nicolas Dechesne <nicolas.dechesne@linaro.org>
---
 doc/bitbake-user-manual/bitbake-user-manual-execution.rst | 4 ++--
 doc/bitbake-user-manual/bitbake-user-manual-fetching.rst  | 2 +-
 doc/bitbake-user-manual/bitbake-user-manual-intro.rst     | 2 +-
 doc/bitbake-user-manual/bitbake-user-manual-metadata.rst  | 8 ++++----
 .../bitbake-user-manual-ref-variables.rst                 | 2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
index 019afd22..d74e768f 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
@@ -315,7 +315,7 @@ any ``DEFAULT_PREFERENCE`` setting. ``DEFAULT_PREFERENCE`` is often used
 to mark newer and more experimental recipe versions until they have
 undergone sufficient testing to be considered stable.
 
-When there are multiple “versions” of a given recipe, BitBake defaults
+When there are multiple "versions" of a given recipe, BitBake defaults
 to selecting the most recent version, unless otherwise specified. If the
 recipe in question has a
 :term:`DEFAULT_PREFERENCE` set lower than
@@ -325,7 +325,7 @@ to specify their preference for the default selected version.
 Additionally, the user can specify their preferred version.
 
 If the first recipe is named ``a_1.1.bb``, then the
-:term:`PN` variable will be set to “a”, and the
+:term:`PN` variable will be set to "a", and the
 :term:`PV` variable will be set to 1.1.
 
 Thus, if a recipe named ``a_1.2.bb`` exists, BitBake will choose 1.2 by
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index f62ddffe..6760b108 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -350,7 +350,7 @@ The supported parameters are as follows:
 
 -  *"rev":* The revision of the source code to checkout.
 
--  *"scmdata":* Causes the “.svn” directories to be available during
+-  *"scmdata":* Causes the ".svn" directories to be available during
    compile-time when set to "keep". By default, these directories are
    removed.
 
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
index 77dc9668..6f9d3929 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
@@ -465,7 +465,7 @@ Executing a Task Against a Single Recipe
 Executing tasks for a single recipe file is relatively simple. You
 specify the file in question, and BitBake parses it and executes the
 specified task. If you do not specify a task, BitBake executes the
-default task, which is "build”. BitBake obeys inter-task dependencies
+default task, which is "build". BitBake obeys inter-task dependencies
 when doing so.
 
 The following command runs the build task, which is the default task, on
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index ec5d0859..7ea68ade 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -516,8 +516,8 @@ variable.
 -  *Selecting a Variable:* The ``OVERRIDES`` variable is a
    colon-character-separated list that contains items for which you want
    to satisfy conditions. Thus, if you have a variable that is
-   conditional on “arm”, and “arm” is in ``OVERRIDES``, then the
-   “arm”-specific version of the variable is used rather than the
+   conditional on "arm", and "arm" is in ``OVERRIDES``, then the
+   "arm"-specific version of the variable is used rather than the
    non-conditional version. Here is an example: ::
 
       OVERRIDES = "architecture:os:machine"
@@ -1917,8 +1917,8 @@ This command returns the signature data in a readable
 format that allows you to examine the inputs used when the OpenEmbedded
 build system generates signatures. For example, using
 ``bitbake-dumpsigs`` allows you to examine the ``do_compile`` task's
-“sigdata” for a C application (e.g. ``bash``). Running the command also
-reveals that the “CC” variable is part of the inputs that are hashed.
+"sigdata" for a C application (e.g. ``bash``). Running the command also
+reveals that the "CC" variable is part of the inputs that are hashed.
 Any changes to this variable would invalidate the stamp and cause the
 ``do_compile`` task to run.
 
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 3de2a9ff..74a3eb80 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -553,7 +553,7 @@ overview of their function and contents.
          device. To select the scheduler, use the following command form where
          device is the device (e.g. sda, sdb, and so forth): ::
 
-            $ sudo sh -c “echo cfq > /sys/block/device/queu/scheduler
+            $ sudo sh -c "echo cfq > /sys/block/device/queu/scheduler"
 
    :term:`BB_TASK_NICE_LEVEL`
       Allows specific tasks to change their priority (i.e. nice level).
-- 
2.28.0

