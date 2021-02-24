Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
 by mx.groups.io with SMTP id smtpd.web12.794.1614187621970483062
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 24 Feb 2021 09:27:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=Zet8QjoI;
 spf=pass (domain: gmail.com, ip: 209.85.210.48, mailfrom: aehs29@gmail.com)
Received: by mail-ot1-f48.google.com with SMTP id s3so2901578otg.5
        for <bitbake-devel@lists.openembedded.org>; Wed, 24 Feb 2021 09:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PoZjCz5dhLtPPz2YqQCYKL6pWhZPwz4JbwUHBCZ/vek=;
        b=Zet8QjoIoA1pq5Jd6R/PgTbwUrYnnlU8ADyb0Ozp5sU54LfSpx0ipfFZOU+WGCkuaS
         wBk6lKqQworf195gVmjAGTWWn+QeoDS2rc21OWcBMcEqtLjSNzbvKZRg5XeS96cxQwhO
         4u8ATZlE7UTQO3mC7ZJbMo7CTp+6GeQLFV4jhlKThkessGiqn2eB9huzRU9LWQGSz4tN
         LdHQbX3BJXF7+QemNH1S/H9CIoLmyEkkbrUd3Cxjh5KoB+bnXz63N0UCfUSozvpnOC/f
         Oy1uXLb1qsVG3fIIBqFh33s0FATEjfU3onu825G2ni8Xcpx4za+Y0Mu86oVI0YZEfkqc
         cdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PoZjCz5dhLtPPz2YqQCYKL6pWhZPwz4JbwUHBCZ/vek=;
        b=POvp/rELw1cbiWcYEa2ATBEG2Kent+3moSHz63i2MGVBdfnaclcumWr0LaEpgMYGxL
         61AaooRxfa8cgKHxPRbzrJKT1Fuh3rGyliSbWSP9xgajnNuHHQZXc2aUyL5PLVD8zwQ2
         UWFXO/ozSoKjz5GQfC3Z7Y7PsGpSMi+WsvNZmNNtNY8ikgvYQ47LMKHJwPjdcGrkneZ7
         AlWXEMI72gi5WaiHO6TzMwbOrT7h6ThZKpXwyyWuTS69BcfM4B/lQ/Qzf4Xb1Ek3gIjB
         ZkAessKb4/2rUVupc75IJgszwo/iluSASchDHEmcOv7WwoH2raAPLt/OwPxtF4ucLS8q
         umfQ==
X-Gm-Message-State: AOAM533+jascMglEG0/KUDa1y7pW0RXPxkNJveoIBkzuhuEEw5D3jF6m
	q27BO/kB0N8jayJZ0wjVXlrIKVg4SVmRVA==
X-Google-Smtp-Source: ABdhPJzf/JFmSW47U7nQjwA+1ZRhNSbxrVSkATwblIlw2/xKy3bknD3p/4N7AwCJx6qbLjv5Pjh0KA==
X-Received: by 2002:a05:6830:1d43:: with SMTP id p3mr21566335oth.184.1614187620924;
        Wed, 24 Feb 2021 09:27:00 -0800 (PST)
Return-Path: <aehs29@gmail.com>
Received: from alsamon-xub.lan (cpe-68-201-52-49.elp.res.rr.com. [68.201.52.49])
        by smtp.gmail.com with ESMTPSA id 2sm463590oip.3.2021.02.24.09.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 09:27:00 -0800 (PST)
From: "Alejandro Hernandez Samaniego" <alejandro@enedino.org>
X-Google-Original-From: Alejandro Enedino Hernandez Samaniego <alhe@linux.microsoft.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alejandro Enedino Hernandez Samaniego <alhe@linux.microsoft.com>
Subject: [PATCH 3/3] docs: Add AZ_SAS definition to glossary
Date: Wed, 24 Feb 2021 10:26:34 -0700
Message-Id: <20210224172634.2127610-3-alhe@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210224172634.2127610-1-alhe@linux.microsoft.com>
References: <20210224172634.2127610-1-alhe@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Alejandro Enedino Hernandez Samaniego <alhe@linux.microsoft.com>
---
 .../bitbake-user-manual-ref-variables.rst           | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 1cb4b1d6..d8c88c61 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -39,6 +39,19 @@ overview of their function and contents.
       when specified allows for the Git binary from the host to be used
       rather than building ``git-native``.
 
+   :term:`AZ_SAS`
+      Azure Storage Shared Access Signature, when using the
+      :ref:`Azure Storage fetcher <bitbake-user-manual/bitbake-user-manual-fetching:fetchers>`
+      This variable can be defined to be used by the fetcher to authenticate
+      and gain access to non-public artifacts.
+      ::
+
+         AZ_SAS = ""se=2021-01-01&sp=r&sv=2018-11-09&sr=c&skoid=<skoid>&sig=<signature>""
+
+      For more information see Microsoft's Azure Storage documentation at
+      https://docs.microsoft.com/en-us/azure/storage/common/storage-sas-overview
+
+
    :term:`B`
       The directory in which BitBake executes functions during a recipe's
       build process.
-- 
2.25.1

