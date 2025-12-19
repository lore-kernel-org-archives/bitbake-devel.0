Return-Path: <corentin.guillevic@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB316D7879D
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 16:13:10 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.20303.1766160784704822897
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Dec 2025 08:13:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=MNJlaCwT;
 spf=pass (domain: smile.fr, ip: 209.85.128.49, mailfrom: corentin.guillevic@smile.fr)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4777771ed1aso14654445e9.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 19 Dec 2025 08:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1766160783; x=1766765583; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jehs/+SvFYY5GvjC7H6J/zAgN0xaZG98RwtnE+BfuXo=;
        b=MNJlaCwTsCWrGAL6iui33mEzbqtL8WCLfueJgZ1YdN7mVMpUxsOyjf0M9erJz4UBFT
         pySJPWrGoiFvZTtcxXu8jPl5DrTaqRTlS7tSRtQfwyLRVWfoj/OzzWp3hDdjHY9wpjRZ
         dHIl3Eq5dgG1VRqIRP3jiwwAjqD0lXiTkgTN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766160783; x=1766765583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jehs/+SvFYY5GvjC7H6J/zAgN0xaZG98RwtnE+BfuXo=;
        b=jRH14huKLELQ3KXE0JAN+6HERGkjz73+72iUuaVdFY9zyVQPwUsdLnoTvyf7VwSh9i
         9UW/cfVtFv43A+ZU6PdPIkZ2equLWl6un8IF6uTCsKIkiXzvqKLWY2MyVehs5P0BIZFF
         VJwhJA5FFEAvq8HTgl1jgGXtK0G7eUBpHZrTlhbo7Fj5Zsd/sqwIckr+rhas4WpWcRlI
         dUweh63xJC3AwVNq1ZDmcyFunFG7ca4Y0dJzEJfXOHIjJXfvpIPoNOUynS0xV6dV7Isz
         c0AaVgPCz3mpB7O0IEAH+LmPjP937/UP4l+lR3TfKnaAFqy6N0OjNdW12iercranTYYO
         IWZg==
X-Gm-Message-State: AOJu0YxCos+kDSL5k6nALZN5D/tPvA3HwVVyUVPXfnSYoItAzNe8wSTL
	g9mcnoBpYZQLlhydfwnMRh30/r2lzqhMbKvsli+Unn+tZHIhLbu3e0mcg5bSFFkxLlsQaAdc689
	JIWsE91c=
X-Gm-Gg: AY/fxX7z35JDtGwePVYcRDCf7OUpY5VX3vpMyVMD1ijsrmY+PtbR80SeD2RfGAkNrz9
	QKtlicc1gEW9tZGrR2aBCEa7yRsK6092DjtDjuWmA+1Qp/LGs47huD/0W5YvdjrWgUoZxcinGOL
	KIhlv8MO8DmpSgBAmV6AKDW23uOwLFASCsegPHKBrRB77erGJMZX0gLyf6KKMfdSH5GvbkL8Q8/
	MqBfVP9C/Mno+fJP3ZxwD+oPtgOqALJDEHSk/JVvEJgBCVg2O74ZWnaJE4C6uvl9jtGn7dK7gLg
	lElN3bdOuy26jA41hzN0kXd7UeCKsxcr7/vokXA+J0GOw2Ek28D/Zxs5MIhp1yavDHNy7u82xiH
	D9JIpyJhra898quWVKSusjFGK76l5XVEi60btS9n3gcb2vxtLq/GkqolBQZNcVe2JZblNsfw8h1
	edZcENMwiKL1YID/Lt6w91e+QHJLeFmOxS4HegaWF3whWCp1lmnxLXuD99F4soJJVTKiKabUODF
	vpIXgiJi08SMvw4tJc=
X-Google-Smtp-Source: AGHT+IGgcmCoCIVub3a5Yz/1gvsvAWuYI/AID20+hmVUbum1oEnlbf+C7i4EokTRoA/gHQnf/t8ZDQ==
X-Received: by 2002:a05:600c:3489:b0:477:994b:dbb8 with SMTP id 5b1f17b1804b1-47d19549daamr30335245e9.11.1766160783041;
        Fri, 19 Dec 2025 08:13:03 -0800 (PST)
Received: from heaven.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be273f147sm105391065e9.7.2025.12.19.08.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 08:13:02 -0800 (PST)
From: Corentin Guillevic <corentin.guillevic@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Corentin Guillevic <corentin.guillevic@smile.fr>
Subject: [PATCH v4 2/4] layers.schema.json: support 'uri'
Date: Fri, 19 Dec 2025 17:12:53 +0100
Message-ID: <20251219161255.2293450-2-corentin.guillevic@smile.fr>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251219161255.2293450-1-corentin.guillevic@smile.fr>
References: <20251219161255.2293450-1-corentin.guillevic@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 19 Dec 2025 16:13:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18625

The property 'uri', which is a shortcut for 'remotes/origin/uri', is now
supported under 'git-remote'.

Signed-off-by: Corentin Guillevic <corentin.guillevic@smile.fr>
---
 setup-schema/layers.schema.json | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/setup-schema/layers.schema.json b/setup-schema/layers.schema.json
index 1a0255435..f42606941 100644
--- a/setup-schema/layers.schema.json
+++ b/setup-schema/layers.schema.json
@@ -46,6 +46,10 @@
                                 "description": "The output of 'git describe' (human readable description of the revision using tags in revision history).",
                                 "type": "string"
                             },
+                            "uri": {
+                                "description": "Specifies the git URI, can be used instead of the more elaborate 'remotes' property when there is only a single URI",
+                                "type": "string"
+                            },
                             "remotes": {
                                 "description": "The dict of git remotes to add to this repository",
                                 "type": "object",
-- 
2.51.0


