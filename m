Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
 by mx.groups.io with SMTP id smtpd.web12.60.1631807774746020397
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Sep 2021 08:56:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=eNCmPzfZ;
 spf=pass (domain: gmail.com, ip: 209.85.208.45, mailfrom: drlv85@gmail.com)
Received: by mail-ed1-f45.google.com with SMTP id c21so18432746edj.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 16 Sep 2021 08:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KqPbDapHLns9wPadbAMlEFMxv78B31kE52mtwJR7BnE=;
        b=eNCmPzfZ2T7RplV6oiQqhqXWQ9/dV3JtqIpE7Cc77szoiC2Yj6on+BidY9ywYdrq/W
         nZGR5SvcAGpHhwwLtGSy0hdJ9U2A/pvJERAViKpEyKUrV2BJBHqMbM41mwEkLhiYUQ8p
         9LdV2DNX3FoRkvAq1m5d3OIUNnZevQ3I2m9WhofU4M02X439Fu8hOMNzrfrwu8i9TRwz
         xebqWa+Ky4cYN1nYMcVfexul5G0ncNEYERqZa30GvQExNGyMneRHWuIykaC4CuHoJR5h
         QS/SSeiWPf1SFHYfxdiciovShxfu4J7PCsLgVSU8m7uYAImICxkfv0zILw3E7JvKXMpS
         E2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KqPbDapHLns9wPadbAMlEFMxv78B31kE52mtwJR7BnE=;
        b=nHciqFB7PHD9zgkKCRN38OqzCyu7Ctq7YXmV6Fz/Yy4qRTDpw+1EZ+VLjNzjQdlour
         XzlfdzMvOvzJU32o2sDKacLaSCMuox8P4SDeD936UDseocEAezq4ijv05v2ypMosnlzE
         cI/bij4Hc8XHvfzucmA8dJmaSG2FpcAoPVDThD8RCNi/w/UAAdJ9hCkclHbv6CoHEqEG
         bfJiEoOYhpD7uNI4JSka4/uRQW29BZemfcQcA2MAyD+++sUfEFBpgQtCGs3sP+B0glNS
         rC8pct1hmLokBbqXAVrezTJOByOcataxxlbiSfHGuGzqjUuWh7Y4a48/VoKrwWwco3XW
         gkag==
X-Gm-Message-State: AOAM531SZv6AkyFshWNveWjCAmGxl02Rj23tcWJn8AWia5SZzwHF0mlC
	oHNHDEoJfaCyZ7KDisLJG3lYf0LkMESxoDg=
X-Google-Smtp-Source: ABdhPJx4Vxg9F0U1v3lKoR0Np63a9DbJYNyNMkye2D0NYWXEkfBSYFQFtboKtex6VarOfFAiuw18Tw==
X-Received: by 2002:a05:6402:10d7:: with SMTP id p23mr7125647edu.74.1631807772490;
        Thu, 16 Sep 2021 08:56:12 -0700 (PDT)
Return-Path: <drlv85@gmail.com>
Received: from VDanaila.upc.biz (5-12-124-239.residential.rdsnet.ro. [5.12.124.239])
        by smtp.gmail.com with ESMTPSA id dm8sm1548351edb.90.2021.09.16.08.56.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Sep 2021 08:56:12 -0700 (PDT)
From: drlv85@gmail.com
To: bitbake-devel@lists.openembedded.org
Cc: Valentin Danaila <drlv85@gmail.com>
Subject: [PATCH] fetch2/s3: allow to switch profile from environment variable
Date: Thu, 16 Sep 2021 18:56:09 +0300
Message-Id: <20210916155609.34883-1-drlv85@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

  Make usage of Bitbake's s3 fetcher more flexible with different AWS profiles
  and switch between profiles as export of the AWS_PROFILE environment variable

Signed-off-by: Valentin Danaila <drlv85@gmail.com>
---
 lib/bb/fetch2/__init__.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index d9e1599a..ee29d89b 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -834,6 +834,7 @@ FETCH_EXPORT_VARS = ['HOME', 'PATH',
                      'DBUS_SESSION_BUS_ADDRESS',
                      'P4CONFIG',
                      'SSL_CERT_FILE',
+                     'AWS_PROFILE',
                      'AWS_ACCESS_KEY_ID',
                      'AWS_SECRET_ACCESS_KEY',
                      'AWS_DEFAULT_REGION']
-- 
2.32.0

