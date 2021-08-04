Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web09.6872.1628070946930441442
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Aug 2021 02:55:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Yq/cayx3;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id d8so1549161wrm.4
        for <bitbake-devel@lists.openembedded.org>; Wed, 04 Aug 2021 02:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F3F3iSYqHovW9gpX+9sp8l/3MPLvxjtvTBHEJG6N4No=;
        b=Yq/cayx3llJmt1SsZqWBU9tPHV3g4SRIjw38+150rL+YhS9hX8S8woWZX+21ygaGgT
         uCR7Nh/jrIYG4tiGo7UabKzhQuGhibMAJGtiD3+xf5DFNd86nWEDwzqmHjmhZlRh7ANO
         d/qxwu1VFrIx2CPEy1xHip3Vl/YkFLiO0f/fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F3F3iSYqHovW9gpX+9sp8l/3MPLvxjtvTBHEJG6N4No=;
        b=IiUwhxjycGhQbugrbkbJzkS6k+ZIbpMcZ+agQ6nXsiaf768do38tnjrDboXFUKA0mQ
         i50I/QOOkLfeJWw7IgrvtjxWoewAJ8CB6pioc9x+8Xw0bGHdrKSMa/8H3KtO7VWAjvvZ
         XYxBCk/C1Q6K1jyE3alAPbXfbxULWv/o22TZX28MHLZCRiYul2rlZzfob2VwJ/YGm9KR
         bNclvy3K7TqB3rW+SF7ztHSBH9Y6qk0o/0OOMfvUiCDztq3V9/oIs/D7Alexb/qZvmbL
         IOGCLlWIm2YAmlvOSzBa4Xw+/Li3H0yjp3YhPb/e+YEGgvinmBrf3dRkLXe4bi7jkTgr
         B1TA==
X-Gm-Message-State: AOAM530GdUM7lFmOQkjwajavrENC1iyIM/poJy7Fz/W/DjAPovWqKzEr
	kEMd1blq6cNUE+wjRXm2Y2vXsdTx0MAwJg==
X-Google-Smtp-Source: ABdhPJx4PTHjTN8wdcjtKmQjp36IhJSI13vxT7aIDRWh+4uhWRdNpTevhjnQ23AeP8de5Owk6EMvEA==
X-Received: by 2002:a5d:55cb:: with SMTP id i11mr27649835wrw.158.1628070945166;
        Wed, 04 Aug 2021 02:55:45 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:895b:15d0:6c2e:72fa])
        by smtp.gmail.com with ESMTPSA id k17sm1855512wrw.53.2021.08.04.02.55.44
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 02:55:44 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] doc: Fix append/prepend/remove references
Date: Wed,  4 Aug 2021 10:55:43 +0100
Message-Id: <20210804095544.3500614-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix some references missed during the overrides syntax migration.
Thanks to Quentin Schulz <foss@0leil.net> for the patch.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../bitbake-user-manual-metadata.rst          | 26 +++++++++----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 6b88fd11e0..b0494d0809 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -325,14 +325,14 @@ Surrounding spaces and spacing are preserved. Here is an example::
 The variable ``FOO`` becomes
 "  789 123456    " and ``FOO2`` becomes "    abcdef     ".
 
-Like "_append" and "_prepend", "_remove" is applied at variable
+Like ":append" and ":prepend", ":remove" is applied at variable
 expansion time.
 
 Override Style Operation Advantages
 -----------------------------------
 
-An advantage of the override style operations "_append", "_prepend", and
-"_remove" as compared to the "+=" and "=+" operators is that the
+An advantage of the override style operations ":append", ":prepend", and
+":remove" as compared to the "+=" and "=+" operators is that the
 override style operators provide guaranteed operations. For example,
 consider a class ``foo.bbclass`` that needs to add the value "val" to
 the variable ``FOO``, and a recipe that uses ``foo.bbclass`` as follows::
@@ -347,14 +347,14 @@ not what is desired::
    FOO += "val"
 
 If, on the other hand, ``foo.bbclass``
-uses the "_append" operator, then the final value of ``FOO`` will be
+uses the ":append" operator, then the final value of ``FOO`` will be
 "initial val", as intended::
 
    FOO:append = " val"
 
 .. note::
 
-   It is never necessary to use "+=" together with "_append". The following
+   It is never necessary to use "+=" together with ":append". The following
    sequence of assignments appends "barbaz" to FOO::
 
        FOO:append = "bar"
@@ -379,8 +379,8 @@ You can find more out about variable flags in general in the
 
 You can define, append, and prepend values to variable flags. All the
 standard syntax operations previously mentioned work for variable flags
-except for override style syntax (i.e. "_prepend", "_append", and
-"_remove").
+except for override style syntax (i.e. ":prepend", ":append", and
+":remove").
 
 Here are some examples showing how to set variable flags::
 
@@ -581,7 +581,7 @@ variable.
    ``do_compile`` task.
 
    You can also use this syntax with other combinations (e.g.
-   "``_prepend``") as shown in the following example::
+   "``:prepend``") as shown in the following example::
 
       EXTRA_OEMAKE:prepend:task-compile = "${PARALLEL_MAKE} "
 
@@ -613,7 +613,7 @@ users.
 
 There is often confusion concerning the order in which overrides and
 various "append" operators take effect. Recall that an append or prepend
-operation using "_append" and "_prepend" does not result in an immediate
+operation using ":append" and ":prepend" does not result in an immediate
 assignment as would "+=", ".=", "=+", or "=.". Consider the following
 example::
 
@@ -671,7 +671,7 @@ For this case, the type of append
 operators are affecting the order of assignments as BitBake passes
 through the code multiple times. Initially, ``A`` is set to "1 45"
 because of the three statements that use immediate operators. After
-these assignments are made, BitBake applies the "_append" operations.
+these assignments are made, BitBake applies the ":append" operations.
 Those operations result in ``A`` becoming "1 4523".
 
 Sharing Functionality
@@ -908,7 +908,7 @@ rules. The scripts are executed by ``/bin/sh``, which may not be a bash
 shell but might be something such as ``dash``. You should not use
 Bash-specific script (bashisms).
 
-Overrides and override-style operators like ``_append`` and ``_prepend``
+Overrides and override-style operators like ``:append`` and ``:prepend``
 can also be applied to shell functions. Most commonly, this application
 would be used in a ``.bbappend`` file to modify functions in the main
 recipe. It can also be used to modify functions inherited from classes.
@@ -1135,7 +1135,7 @@ equivalent to the following snippet::
 values set for the variables within the anonymous functions become
 available to tasks, which always run after parsing.
 
-Overrides and override-style operators such as "``_append``" are applied
+Overrides and override-style operators such as "``:append``" are applied
 before anonymous functions run. In the following example, ``FOO`` ends
 up with the value "foo from anonymous"::
 
@@ -1165,7 +1165,7 @@ To understand the benefits of this feature, consider the basic scenario
 where a class defines a task function and your recipe inherits the
 class. In this basic scenario, your recipe inherits the task function as
 defined in the class. If desired, your recipe can add to the start and
-end of the function by using the "_prepend" or "_append" operations
+end of the function by using the ":prepend" or ":append" operations
 respectively, or it can redefine the function completely. However, if it
 redefines the function, there is no means for it to call the class
 version of the function. ``EXPORT_FUNCTIONS`` provides a mechanism that
-- 
2.30.2

