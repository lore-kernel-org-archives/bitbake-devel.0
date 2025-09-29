Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468D8CCA468
	for <webhook@archiver.kernel.org>; Mon, 29 Sep 2025 12:56:45 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
 by mx.groups.io with SMTP id smtpd.web10.53021.1759150596091611063
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 29 Sep 2025 05:56:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=FX7wK211;
 spf=pass (domain: gmail.com, ip: 209.85.208.45, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-62fb48315ddso8382593a12.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 29 Sep 2025 05:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759150594; x=1759755394; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ch6knsTbgDGE9TNf53GLPhss2+wLFV2nM9m1CBJiGL4=;
        b=FX7wK211pOTveT0mCYoDfi6HAfxQYZcGCLWRhPNUMPTLth8X2RuGwR0yS3FFxMjlLJ
         FmkuK6GpCnKH+xSXsKIJ+Tt8lp/ylkG7540ubwTuDLAmyeqFuCW8q7rmyqA9A8pO3mPH
         pHH4alQ8YwySUHVvzcsJDPP4YVRb+ao1nQygz3pa4TNKsJ4hvV0VWkm42rP41Z+ViE/v
         J7/VSoHZAngipEt6KFetbNab1y4b9S2n6iuZNevRdL9dURGQzfYOqRMcmT9V1Cz673eL
         e0ToiE+EMcUtXactBeqpjuxIHd+HjoiQ/fewJfCoGSelHnIsTx9T+4AUHAtnNJIyIX+O
         SJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759150594; x=1759755394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ch6knsTbgDGE9TNf53GLPhss2+wLFV2nM9m1CBJiGL4=;
        b=obwFHFLGG9aCOEuzbErosVPqe7C313A+xQFOcN2Jo+ZtmR27kfgklPdSxSRpO5cLoB
         pFbkO1DDmPeUt4UQWjPFds+9aS6063Gs7T46HLasZolJVIItKNxvt0eM5MM6an+dk7fi
         jxHqZiDXugnf22n3bkGIY92LBhcLpmwvY7aIfe7zJTdId2fxXOvZfEpYORm/d3wGWs3G
         WYhf6KG/elulH5U7V+FhPoqXRsIO67oMTArIOoXYQ/53pe/u1Ja139ik0lyo0BXtdzOj
         pSCa834AtyOdAoNMNS/b3Fu7wxb9wh0m5+kJZ074Aodytdh9tXFzxHIOD70+KlQcQ6qG
         DGJw==
X-Gm-Message-State: AOJu0Yzjlu0ry8FpWO5zjHsA6YLC6YvUO8AOPwecOS6SGfsuIYieqdVw
	VAxexHY+862t5b9mX429KPWLrwc03JrAszvODHLht75aBzgZ/0USSiUcis4jWQ==
X-Gm-Gg: ASbGncvmHwG5KKepv7b/CmMeXFEgffuvktS1tZsgpBK/7eRPx9Jp8WZQxKl9B0rdCW5
	tnSoEXuLEc2rFYU8mOhKBw2nhrDO370aL9qArZ6GVSmk4re/EQlFpzqT1VmahBURmvdXZyVWFc+
	0UooAPtQxR4T+qu1KpUX/Wj8WjRA4Z3sqd+7ebFKQ44+FSZZVZw4NKWlFzvxkVHjp3YSpIrqiHq
	p1Hg/Ls6vEG/4YSA54KGCCuCd/b8C14JlzgBDmu5L5+3qm+xiUAVvhPIIEvq4CJlApyFcnFVzOW
	5S5sWmrvlFxhwjxRuiki0onIg6CifehCc44J/M89l3tNk0tFripL7jgfCIvVwGzpLBUhkEpKVMc
	JXQqj7h+/jQ/Lr4nmHd03Eef8LQ3gh2jIc0b/0aOUfDoDPavz5Qv5nTLlRBo1s+GM4k1DRbTuWk
	UCc62W9tkMVlsrMkveJHUZnFoW09Yhj7HnELB8HlXwvtrS5IhMCI21BQqcm7bMCfbgIRiC
X-Google-Smtp-Source: AGHT+IFqwy4q+cUUVtSVSdNPEhd+C24JC+ra0s7Y/LlSUV0UreP+aMQPJ19JadGcFSJNc+q73Y6I0Q==
X-Received: by 2002:aa7:db47:0:b0:62f:50cb:764c with SMTP id 4fb4d7f45d1cf-6349fa97608mr12375102a12.35.1759150594299;
        Mon, 29 Sep 2025 05:56:34 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634b46dca59sm6575915a12.8.2025.09.29.05.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 05:56:33 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [PATCH 04/10] cooker: adjust the error message about missing websockets module to mention bitbake-setup
Date: Mon, 29 Sep 2025 14:56:10 +0200
Message-Id: <20250929125616.1751116-4-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250929125616.1751116-1-alex.kanavin@gmail.com>
References: <20250929125616.1751116-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 29 Sep 2025 12:56:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18103

From: Alexander Kanavin <alex@linutronix.de>

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index fb87368f1..03f262ac1 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -320,7 +320,10 @@ class BBCooker:
                     except ImportError as e:
                         bb.fatal(""""Unable to use hash equivalence server at '%s' due to missing or incorrect python module:
 %s
-Please install the needed module on the build host, or use an environment containing it (e.g a pip venv or OpenEmbedded's buildtools tarball).
+Please install the needed module on the build host, or use an environment containing it:
+ - if you are using bitbake-setup, run 'bitbake-setup install-buildtools'
+ - openembedded-core layer contains 'scripts/install-buildtools' that can also be used
+ - or set up pip venv
 You can also remove the BB_HASHSERVE_UPSTREAM setting, but this may result in significantly longer build times as bitbake will be unable to reuse prebuilt sstate artefacts."""
                                  % (upstream, repr(e)))
                     except ConnectionError as e:
-- 
2.39.5


