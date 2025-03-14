Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080D8C282EC
	for <webhook@archiver.kernel.org>; Fri, 14 Mar 2025 23:52:35 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web11.725.1741996348821023877
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Mar 2025 16:52:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=XJjcvRd7;
 spf=pass (domain: smile.fr, ip: 209.85.128.42, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so1242385e9.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 14 Mar 2025 16:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1741996346; x=1742601146; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=We1MSoc7sEIsF2R4McDpOXgzmsIqTS6c8wdY8UU898E=;
        b=XJjcvRd7J9uQgxx6fseg4SNdKBxXOyAAJds33E+hQajFXbQDhCXzNzND8cV4cOO+Th
         zPbW4YXjThGnfI2v6j8OBV+cEyEtg+1YRI40uJsq9FbJ5pxI13cTCrmP7orqTRCq8deO
         rqSnNrn/clD+yHzVNnRVme0BiI04iNtoH+zh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741996346; x=1742601146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=We1MSoc7sEIsF2R4McDpOXgzmsIqTS6c8wdY8UU898E=;
        b=a6s/gE0dNnmIfXnFWpV7lh4n+k+scAivarINL5WIm1VKqX3IBknnQV5qrVcKHDXpkV
         yFwAuL4+7AnRCxK5EpAWDrOgmS8dXlkWRMTnJNbht9zDKmL5c2Iehv1Rs1Z8hJ9giz8t
         Io4upXSvdgg8vlZ5Qr4tsE04kfMeKuPyK6nqlOXkhW6dVzFA1A2vsnuGQI4MKa0sME8M
         0gvt4AQb6RNel94r11v+a70ViGQZ1dZJ4hrkZos5Se3vZhX3dROdTGtmWdFYtJN7eq14
         gBlrJ4QRFcsFnEFEU2dfoGnhnSOGg4iW71GI4C4fSHjX0CyLf9EzIRlAyv220bXxaau4
         Qelg==
X-Gm-Message-State: AOJu0YyS4+Prr5/YCQTABKYfLrCCgotsI7lAtQdecA0O4t7VCnsZeKsP
	0mcm3ODlQ+bDfpeHglRBEL8htlpxHaC8xFQmM7DT6VlnkjWR4tc5FlvnuKFTDYOGW3FfzBB7nHa
	r
X-Gm-Gg: ASbGncuaBBGxUmTY//oEe/95KZmsX/x/GW1flhkKjeA3yfipelWvLl3o5/P/3Ul4Qhq
	yzmXNtXXq+nkoaNTCQOHTwSlMBtTBqUeE7ez4SR/I0ndUjYSQYn3xkxtJ/CDe3TRmXElj21/Jrm
	sFwEwAFCYiBZWZ3pVpxi1LAz7QOe5xujEnog0o1ZLq0CMa+JQARuA982VtHjPGIhgXjmz33O2Wb
	sJPlTjF7mwEYttYQ05pG8rI2hsS+4JhdcfHhy6BhnEUk2/4VYX1DL2LJj3Tyz7IEsJ8JdQMMLoD
	zVeTrc5McSQpzezARkP1P4sFjrJ6lsAnmTOucL9rd2AfPoIxA/jOAVMIv/4N3DSSwE3iuWck5Y+
	V5gxieFqJbOcly/F7jWJkxA80+Bg8NWbxaKUBvFMBpXW3FirUoJQ=
X-Google-Smtp-Source: AGHT+IEVIVb9rt1druwyF0XqdPHWwDkAP5LVwlbTGb7uXbkfg+0MSlgxcbLje45Ax8cU62k6p/EvTQ==
X-Received: by 2002:a05:600c:3b9d:b0:43b:b756:f0a9 with SMTP id 5b1f17b1804b1-43d1ec7aa37mr67168435e9.11.1741996346575;
        Fri, 14 Mar 2025 16:52:26 -0700 (PDT)
Received: from P-ASN-ECS-830T8C3.home (2a01cb000deef0002cff7470e58ff5dc.ipv6.abo.wanadoo.fr. [2a01:cb00:dee:f000:2cff:7470:e58f:f5dc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d20e29a38sm28036935e9.37.2025.03.14.16.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 16:52:26 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [PATCH 2/2] tinfoil: Track data during finalizeData
Date: Sat, 15 Mar 2025 00:52:14 +0100
Message-Id: <20250314235214.1540-2-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250314235214.1540-1-yoann.congal@smile.fr>
References: <20250314235214.1540-1-yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Mar 2025 23:52:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17448

From: Yoann Congal <yoann.congal@smile.fr>

finalizeData changes the value of variables, so, it needs to have data
tracking enabled to get a full and accurate variable value history.

Fixes [YOCTO #15652]

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/tinfoil.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index 60359a1a..f48baeb3 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -662,7 +662,8 @@ class Tinfoil:
         """
         Run anonymous functions and expand keys
         """
-        return self._reconvert_type(self.run_command('finalizeData'), 'DataStoreConnectionHandle')
+        with self._data_tracked_if_enabled():
+            return self._reconvert_type(self.run_command('finalizeData'), 'DataStoreConnectionHandle')
 
     def parse_recipe_file(self, fn, appends=True, appendlist=None, config_data=None):
         """

