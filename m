Return-Path: <bijak.dawid@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F46CD342A
	for <webhook@archiver.kernel.org>; Fri,  1 May 2026 09:14:51 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10754.1777626883367916179
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 01 May 2026 02:14:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=TiRB5ESd;
 spf=pass (domain: gmail.com, ip: 209.85.128.49, mailfrom: bijak.dawid@gmail.com)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so9945645e9.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 01 May 2026 02:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777626881; x=1778231681; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tnd5tMe0mzHOFOqdiub+GjHo4JwZADonyrUyx8I5sHk=;
        b=TiRB5ESdVUchmOoaExwPGptWPXyFwEAZzdcL4raTp3uMSECAuhcMIStQ3lzzpQ5MeH
         M4ZvSg0hMLBEBFC3MsNWGcwx/R4BEdx6lzHj84BSkbvHpa3qzK6VjLPwJrfB6uyGcwI/
         sEs5CTzmHlDcw+BQHuaJ2LlaV7n7Ikhk68sEiGoR9j0d2GKg0cQqgE89eohbVFV+fmKb
         CawJosc92EpmImqSevQSxhdb83dSXXjnYzLMy+7d1tdQgC7rukueqqB01hDvfskgMrdY
         erAtToTasRNO1JL2H8h4OYmcJOKlQ5vCu1Zq3+th/qoGMIUEY2vs1t7HjFqaTHuk5v10
         hBCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777626881; x=1778231681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tnd5tMe0mzHOFOqdiub+GjHo4JwZADonyrUyx8I5sHk=;
        b=EQxtojO/RfkHAuh45XtA6cTXokprj6tXUJvbX8etNaUbHdezJ8E3BGo/3MM5g4bZpi
         lvlh+YEv8m3Rg/DAku3PJVL5UPrtC/bJ/k/VK4PLfu0hgYMntscG6u3gmLVOKL8KqQNL
         p46v+Hdv/GJNoI1/unlXvgdJVtvMbs1GOH6kId+a7KjMFt1mSto+0fl4907X9HxeR2gh
         EMjLrWoBEc+f8V2BETrTXdhUBhQrUFQSL+LbWQxpT1Ft+o6ZqQYp+8zvggRyK8LFGc1L
         n5/OvlVWRGtaFIPCYQpCKEUZMtr1kGehDUxLmJOEY1rBmRVqbqzXbPU179riCFg1oeet
         Aw/Q==
X-Gm-Message-State: AOJu0YzJYIOhrR6VgABdQcVoACBr7Y0P8ikvsq9ZzHWl+tG31vAaoLOU
	pxds2IsIvOPyQdQVGbQOv8j4y29uvSxUAn0jTgtU+socDZPgouppu6AXRMLaJ4B6zhs=
X-Gm-Gg: AeBDietVXPMuo19N1b1MLQJqYbSGfXaVlZxEUIZmcSi8mHF1n6sadl099DeCxn4HAdu
	Xm+EkjHn7mGXYTrmMDFfCm3GqjvgCJXLHuDtralJB3tFbiREavX3OWR/46Hyeh4lIFQV9MFz5ks
	oQ1tbbtPKCDVCnpuT0qvNbTecNzdf0V/sc2fb+UYXjDcsibzMp87HR5lqvffUf7XKEO2kAJ/eSd
	k5/lg9lEx9e9901ib53V8Fav5RjNDDG/Yy4/2RBdlTGH8J63g6l2MOtRwOn2iGTaxxmslW/UP89
	MYT02ii5FqB9IbRzP4cIPPQWDam3H0fDD8VYhHygjPq94WzApWy463KriIx8i1PeGyW+05S7WDT
	dS3ut9AtDGO86BYPRlm20ftq4z+ODtdbvhv9tfHAzQ4YguSdaATLLoEkPveY3XY0q7ufYxcuD7/
	x19kfPS2xc1hNewEPKebxmdg9KVKdqH/kLYBnjpYF+I/KXWsuM5CSv1h363VjIjxvPdk7HrE2Ad
	wuP3vsfvlgKzyQo/6lFj9bAZRkw6yHC6s+dzvfM+2zOkH+Z1OT7UiFFGuZolUI=
X-Received: by 2002:a05:600c:c174:b0:480:1c69:9d36 with SMTP id 5b1f17b1804b1-48a84468397mr100076575e9.17.1777626881503;
        Fri, 01 May 2026 02:14:41 -0700 (PDT)
Received: from thinkpad.fritz.box ([2a02:8070:d188:380:6a5d:7450:e8b3:758])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48a8fe953besm12097955e9.2.2026.05.01.02.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 02:14:41 -0700 (PDT)
From: Dawid Bijak <bijak.dawid@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	quentin.schulz@cherry.de,
	richard.purdie@linuxfoundation.org,
	Dawid Bijak <bijak.dawid@gmail.com>
Subject: [PATCH v2 3/4] doc: bitbake-user-manual-metadata: explain inherit_defer example
Date: Fri,  1 May 2026 11:14:17 +0200
Message-ID: <20260501091418.76994-4-bijak.dawid@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260501091418.76994-1-bijak.dawid@gmail.com>
References: <20260501091418.76994-1-bijak.dawid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 01 May 2026 09:14:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19428

Add a short paragraph describing how the inherit_defer makes use of override
syntax to achieve conditional inheritance, and rename VARIABLE to
VARNAME so the example uses the same identifier as the preceding
code block.

Signed-off-by: Dawid Bijak <bijak.dawid@gmail.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index b886e0578..0c7c3ff99 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -832,8 +832,13 @@ Here is an example::
 One way to achieve a conditional inherit in this case is to use
 overrides::
 
-   VARIABLE = ""
-   VARIABLE:someoverride = "myclass"
+   VARNAME = ""
+   VARNAME:someoverride = "myclass"
+
+:ref:`inherit_defer <ref-bitbake-user-manual-metadata-inherit-defer>`
+defers the evaluation of ``${VARNAME}`` until the end of
+parsing. Assuming ``someoverride`` is in :term:`OVERRIDES`, ``${VARNAME}``
+expands to ``myclass``, which is then inherited.
 
 Alternatively, you could use an inline Python expression in the
 following form::
-- 
2.48.1


