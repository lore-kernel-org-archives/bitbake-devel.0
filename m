Return-Path: <jstephan@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB58CAC587
	for <webhook@archiver.kernel.org>; Tue, 17 Sep 2024 15:12:09 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web11.23266.1726585922188346800
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Sep 2024 08:12:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=OxJwJ+Qc;
 spf=pass (domain: baylibre.com, ip: 209.85.221.45, mailfrom: jstephan@baylibre.com)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-374c7d14191so4254688f8f.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 17 Sep 2024 08:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726585920; x=1727190720; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EM23ydaihxNg+xrkzA/Ww312sSXMIH/x3soQ6FfMyms=;
        b=OxJwJ+Qcyag0WO8LSYR1tO5/56lQ8vg1Yvu8P5hwRvCdwOcPQbJ7he03NZjYnC26Xv
         F8cpVRtXD8G9CNv+23x4n2LxAwcx8ok4V8DR7xi92oe3QjJlcnulmI45ve9/+xZo8wbj
         5bAIYpIrlLrF+ZqPafVaH4CHl2u5wHA6cZZXQehr2xq/NFQWNYQjjFko+1KyWTFWAYfR
         0KGpcYqxTyCy3yFYVgz9nCJcx2P44om5TLiCkPALHcjTkJsEyYtBPC66A+3AQvNmchnH
         vB2o1wTly7gkHEf7iHHCU//l6X49kC6nllmrIV0fhlhQGJtr9XonoV2yq+zFX7rATC2/
         9+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726585920; x=1727190720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EM23ydaihxNg+xrkzA/Ww312sSXMIH/x3soQ6FfMyms=;
        b=uGkedYiDHSjSwFO1l0JUOOmRSd4kPk39IC9bmToN3BkeAn2K5LeoFqEq2RSO2Z/t5N
         DFMz6UoLW4u7KJJ71NkBabd+Xsvc5JFb2Oaqz7jQUPepJ3FrTVvLPL82l2UMMuNLyTvj
         E5RInWrm2HFH322ivcJ2OCwKgQzLRsiq71a2X//Z1Lp9Zvtt0Y7lnqzmUcV0oTcpDNeU
         eAM++1OJxlpxcNt3TzXGHRCCuUIGuLeahRABEGPWAyxGq4ecLNqKUucDTzFgQKLXSffm
         GYuLq7fstl0VBg9kgpKFDuPsD+lTXS+fAi+upPYAQneKFkI13NC9Z7OqqZs7HY+y4k+i
         UK0g==
X-Gm-Message-State: AOJu0YyoZ+YLvI8qMmTRuSsZBP9F/u5G7BmJr2GVPIcWl86gIfBrouMH
	LEY2stSzD5+Uus3vrdES0eWggx4t/ebTN5QEtu5zyRbSQNAioFnPnPnkFQx9Fp2D2bUSlQsivUB
	AvPc=
X-Google-Smtp-Source: AGHT+IHNwfTNkIwcO+K+3exEmSswMeCQd7MfeK+dyVxG3dqiWwa/vRk0DcsJpfymm6noFI5sjMdNBg==
X-Received: by 2002:adf:fd10:0:b0:374:c878:4519 with SMTP id ffacd0b85a97d-378c27a2656mr12218149f8f.3.1726585920202;
        Tue, 17 Sep 2024 08:12:00 -0700 (PDT)
Received: from localhost.localdomain (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net. [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e71f068esm9897307f8f.3.2024.09.17.08.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 08:11:59 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
To: bitbake-devel@lists.openembedded.org
Cc: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH 2/2] bitbake: main: add choices to restrict -S parameter
Date: Tue, 17 Sep 2024 17:11:57 +0200
Message-ID: <20240917151157.780068-2-jstephan@baylibre.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240917151157.780068-1-jstephan@baylibre.com>
References: <20240917151157.780068-1-jstephan@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 17 Sep 2024 15:12:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16566

Currently, available -S parameters are "none", "printdiff" and "lockedsigs",
but there is no check on parameter, so user can literally give anything
to -S and it will act as if "none" was specified.

Fix this by adding the allowed values in choices for -S parameter

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 bitbake/lib/bb/main.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/bb/main.py b/bitbake/lib/bb/main.py
index 1f4313fa0dd..24758646eaa 100755
--- a/bitbake/lib/bb/main.py
+++ b/bitbake/lib/bb/main.py
@@ -213,6 +213,7 @@ def create_bitbake_parser():
 
     exec_group.add_argument("-S", "--dump-signatures", action="append",
                         default=[], metavar="SIGNATURE_HANDLER",
+                        choices=["none", "printdiff", "lockedsigs"],
                         help="Dump out the signature construction information, with no task "
                              "execution. The SIGNATURE_HANDLER parameter is passed to the "
                              "handler. Allowed values are none, printdiff and lockedsigs. "
-- 
2.34.1


