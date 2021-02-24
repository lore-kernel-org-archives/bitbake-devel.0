Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
 by mx.groups.io with SMTP id smtpd.web08.819.1614187621170254340
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 24 Feb 2021 09:27:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=nhpfrrQt;
 spf=pass (domain: gmail.com, ip: 209.85.210.48, mailfrom: aehs29@gmail.com)
Received: by mail-ot1-f48.google.com with SMTP id v12so1771363ott.10
        for <bitbake-devel@lists.openembedded.org>; Wed, 24 Feb 2021 09:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rPyU3zUd43PSituBLKsJRvXEqqe1atX4BiZYcTdjLhI=;
        b=nhpfrrQt8eSAOIXpKEB+toAo4pDu9vmKR9LZC18nZHlMXqwBUDBwTMGh67rrzFYVon
         zWTPMl0dCXVC7yZRsrK5dTf6Q8r0rBOZbkCn5MDhT2DA+Q6nn0ww5U+7nLE6ce0K+vg8
         YGzDIG5VQ9+yzpQku0k/vBxVFvoWf73zxmMa7xJ/PpgivT1dvnWXAV285gSU/U0SK0L0
         I+xM3+08puhGvXwyXZ63HIqcyybE5tiTxZOMZPz00Ai3okS1F7ZTzBCvMYY4HVf3uok6
         s1TZpDYNJgvfkKrxZP4jXmateqNbqKQSIJ8jQMSdW2Dsiza7TBsXLfvEhql5MtE0JNAV
         kjHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rPyU3zUd43PSituBLKsJRvXEqqe1atX4BiZYcTdjLhI=;
        b=Zrc05H425j1g/pveLYOkiFfi7c2vwB8GvTESsBrjdJSgsk1RJcE8co/oN3u3ARPQ44
         XVtAvzZBqRvLpUlUNvA6SZuUbcHtBdbvfwbrvQR6vCPgaLmuhLjmicJX6VamwY8hlNST
         x1v8TS2Xj65nDqYL7r6odwzMCZZMSTBzK4iROtJ5q4Rvc8YQv+hfhXi7a441RjE7eXkX
         XT1234CBYca1d4LXJk3Zej7qlBTX1I0MJVzFQvNT1k0jo6eE008hKDYTg2w0M4HVsRAU
         pUmZtnplrpWdtKP2EhuaV5y37PlZCiMBLjxceP2k0BLXKpC6MbL6n94qkAxd0MIe7ZLz
         4IdQ==
X-Gm-Message-State: AOAM531k2rhJR5XQJgKoPYsA6jxUxXO9pdRzWPki15PVJ21dYziQ+mbw
	+1rH2dFKet3zeQXC3WOBsyGmtNt7Fnl6CQ==
X-Google-Smtp-Source: ABdhPJw3qW3PMQEMH+xind6OLI8kJOXuYiEZnx5x8tqFRyEMUEhbG2/5VbrfwcOjFKB9IBI9u2A7Eg==
X-Received: by 2002:a9d:7e87:: with SMTP id m7mr26281851otp.128.1614187620066;
        Wed, 24 Feb 2021 09:27:00 -0800 (PST)
Return-Path: <aehs29@gmail.com>
Received: from alsamon-xub.lan (cpe-68-201-52-49.elp.res.rr.com. [68.201.52.49])
        by smtp.gmail.com with ESMTPSA id 2sm463590oip.3.2021.02.24.09.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 09:26:59 -0800 (PST)
From: "Alejandro Hernandez Samaniego" <alejandro@enedino.org>
X-Google-Original-From: Alejandro Enedino Hernandez Samaniego <alhe@linux.microsoft.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alejandro Enedino Hernandez Samaniego <alhe@linux.microsoft.com>
Subject: [PATCH 2/3] docs: Add Az fetcher documentation
Date: Wed, 24 Feb 2021 10:26:33 -0700
Message-Id: <20210224172634.2127610-2-alhe@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210224172634.2127610-1-alhe@linux.microsoft.com>
References: <20210224172634.2127610-1-alhe@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Alejandro Enedino Hernandez Samaniego <alhe@linux.microsoft.com>
---
 .../bitbake-user-manual-fetching.rst          | 28 +++++++++++++++++++
 .../bitbake-user-manual-ref-variables.rst     |  2 ++
 2 files changed, 30 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index 6760b108..e9a5f336 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -624,6 +624,34 @@ Here are some example URLs: ::
    SRC_URI = "repo://REPOROOT;protocol=git;branch=some_branch;manifest=my_manifest.xml"
    SRC_URI = "repo://REPOROOT;protocol=file;branch=some_branch;manifest=my_manifest.xml"
 
+.. _az-fetcher:
+
+Az Fetcher (``az://``)
+--------------------------
+
+This submodule fetches data from an
+`Azure Storage account <https://docs.microsoft.com/en-us/azure/storage/>`__ ,
+it inherits its functionality from the HTTP wget fetcher, but modifies its
+behavior to accomodate the usage of a
+`Shared Access Signature (SAS) <https://docs.microsoft.com/en-us/azure/storage/common/storage-sas-overview>`__
+for non-public data.
+
+Such functionality is set by the variable:
+
+-  :term:`AZ_SAS`: The Azure Storage Shared Access Signature provides secure
+   delegate access to resources, if this variable is set, the Az Fetcher will
+   use it when fetching artifacts from the cloud.
+
+You can specify the AZ_SAS variable as shown below: ::
+
+   AZ_SAS = "se=2021-01-01&sp=r&sv=2018-11-09&sr=c&skoid=<skoid>&sig=<signature>"
+
+Here is an example URL: ::
+
+   SRC_URI = "az://<azure-storage-account>.blob.core.windows.net/<foo_container>/<bar_file>"
+
+It can also be used when setting mirrors definitions using the :term:`PREMIRRORS` variable.
+
 Other Fetchers
 --------------
 
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 6469f9d1..1cb4b1d6 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -1303,6 +1303,8 @@ overview of their function and contents.
       -  ``svn://`` : Fetches files from a Subversion (``svn``) revision
          control repository.
 
+      -  ``az://`` : Fetches files from an Azure Storage account using HTTPS.
+
       Here are some additional options worth mentioning:
 
       -  ``unpack`` : Controls whether or not to unpack the file if it is
-- 
2.25.1

