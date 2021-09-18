Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web09.1545.1631987973844081002
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 18 Sep 2021 10:59:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=fHSDAfrb;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id x6so20664903wrv.13
        for <bitbake-devel@lists.openembedded.org>; Sat, 18 Sep 2021 10:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Oaufq4HyJRgYaAOZj6rhaNQYbfNwJFtCHMOD8xUdjro=;
        b=fHSDAfrbsR0VVxDfwyrFdopTZfPm3Sn+QAEBtD373MTIomcR2YUw6ofNornkhFKNyr
         bQVnXHpjD4Q5Y+QdXKAcrKB1fSqof6AqUb2UGBHWstLnXqMst367nEEWWpPScJHy2r+A
         5FuiSeCS+M/hsF4VR0W9D66pc3aGw6Jnzuv0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Oaufq4HyJRgYaAOZj6rhaNQYbfNwJFtCHMOD8xUdjro=;
        b=5RIJ0nig7F0ZExU3VURW1L7GfhMflYoWPKsS4l3GRARlf/yUwToNQOKjMxbwYFOwI4
         MFczTQBUoUCntS6+2flioVAZ94PIFvHrLJ0Nbo2E4r68XXw7qJWEdugVgCnuF3ImhGk2
         rZCERJpKCn69zTO7J7NjKTBm+9NCqBY9cHOT32DlAdBNh6bifnNrRto5g7eFE2YI7R24
         RnGecbonCHPvfn/jga4F33ROL740U6OTz/T+nbfWn4DZZNrd9rTWTGwRqyjotNiFN+9f
         VwbQ3J3eOc9SMs7E55FgdcDREbdjPzpa0BuYnlI0k1qBz2JNwh/tgWDu6W5SC8AqURhN
         mxFQ==
X-Gm-Message-State: AOAM5307O3X2JNMnNviRK5qJZDBejyqcSMvyDMYA4n/DE8eYSMsDBvT3
	pZ8NFPu4B3EOKFK2Pdz5p/pAGhZIMqPd4A==
X-Google-Smtp-Source: ABdhPJxr6yZPcJBhYt7YRD2VotevfYTtJBMA7yJXjrE8W/X4Z5Bn7rj3XCT3YJBaur3sTw17wUqm8g==
X-Received: by 2002:adf:b789:: with SMTP id s9mr19054147wre.315.1631987972056;
        Sat, 18 Sep 2021 10:59:32 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.config (5751ab90.skybroadband.com. [87.81.171.144])
        by smtp.gmail.com with ESMTPSA id q11sm14345423wmc.41.2021.09.18.10.59.30
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 10:59:30 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] cookerdata: Show a readable error for invalid multiconfig name
Date: Sat, 18 Sep 2021 18:59:29 +0100
Message-Id: <20210918175929.1524898-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a multiconfig starts with a digit, users would see pages of
errors as we use the multiconfig as a python function name prefix
and python functions cannot start with a digit. We could avoid doing
that but it is easier just to ask users to name multiconfigs not
starting with digits.

This tweak ensures the user sees an easier to understand error.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cookerdata.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index d6206b7319..ba657c03b6 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -291,6 +291,8 @@ class CookerDataBuilder(object):
 
             multiconfig = (self.data.getVar("BBMULTICONFIG") or "").split()
             for config in multiconfig:
+                if config[0].isdigit():
+                    bb.fatal("Multiconfig name '%s' is invalid as multiconfigs cannot start with a digit" % config)
                 mcdata = self.parseConfigurationFiles(self.prefiles, self.postfiles, config)
                 bb.event.fire(bb.event.ConfigParsed(), mcdata)
                 self.mcdata[config] = mcdata
-- 
2.32.0

