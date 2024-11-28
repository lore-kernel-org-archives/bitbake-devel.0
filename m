Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305E6D690E6
	for <webhook@archiver.kernel.org>; Thu, 28 Nov 2024 08:14:06 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
 by mx.groups.io with SMTP id smtpd.web10.90177.1732781638013178552
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 28 Nov 2024 00:13:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=i0eE526Z;
 spf=pass (domain: gmail.com, ip: 209.85.218.48, mailfrom: martin.jansa@gmail.com)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa545dc7105so70665366b.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 28 Nov 2024 00:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732781636; x=1733386436; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YxDFrBhDL4oSijTjkCJEaMM4SlboOEkCyqRiinnkSVc=;
        b=i0eE526Zt25josqYp2dOko4soOlscCNHzfmtIercARLzSdpz26i+I+fm71ry5bkILy
         rVQw+pP4IH7gzyyrWqI8Kr+UVnLGzTMYFYbeZ2FFgXq+UQOr+L6pn/qVxkKADqpPzCSq
         IactWgR0JGeamjDV1W+B9hzheGdGW8Bh527GwYQKwjiSFT6y9Cv0EvHrJPkxIQb49ldD
         ZfR3goCB1TB/ONwhrqmQO6ma9fQLZhHtL2nQdF0KMkpvpj/cFbH472945qXAcLMgAE9K
         lQTtws89LDhbV/8uoZqaSigBhbSQ1ZYSgl9G3T1TVWjSokFEVadXYNctPWUfy7s+FgRd
         1lyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732781636; x=1733386436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YxDFrBhDL4oSijTjkCJEaMM4SlboOEkCyqRiinnkSVc=;
        b=q2vZ13nHtjwuUsD3miDZ7Q5YvIZNvbYKuQ1On1aBadRBBIaK9uSkFDfrXh9/W/ODPd
         i++DTSTjT2ucykNFBpBQo4zKfymLTE2jAZYsW4WFZhmuUi6B4sE2VR+jE+2J10QjyFUN
         sc7nALxpx7bOtJiKdgedF10Rrbezo+87ckoGbAAU7TR9o6oRBmxJVL3ceP1iixMzvErG
         EsvkSDTkYsoz64EGANfPAoixy0JXb2Sf9dX2j2UrpCYU+Ayf+rN33JXRPmhjgqdooZw+
         KUjmCbZBnLruaUMeixQmwnfTbsaiVtoR8grIAz/4y8Q3Av4ElJu3DXmyxhDUecfdrMQV
         IaSw==
X-Gm-Message-State: AOJu0YzG8hCjDRjsKqj05F4PnnZubWvNx5NxVnLLyy2M51ZIdGRK7Nmf
	/SFr2F+HuB3QcbD0mYDeRz+w5NC5KDCtrFDaMi6CFk4SLx0A5Bl/HUH8ow==
X-Gm-Gg: ASbGncs2lIux0NE1nqJeaECd4LLnDtwfUcWhgHrMr1nySmA/9Eqnc735S7sHzj5NmN2
	j6dKCZVo2vqbQqm7N1dTHjdvXxTwu0haNUHuTol0peBaBvybgUi3gsOaxtYDpg0opZKMOTs3zKV
	hhZgqi8hKtz/0Wt2tomxGexB4Y2J3jSuvx7ExRryz4pu9ZOR8qp8Ba7RaXRnbgTZ/TiJsQSLZ3F
	/l4Ya+e+gxt29scpxXdAm37BC6eP272jOeXTngb75La3p3LGWpKB4oRd4UaS73d6X4rHIGxX8w7
	dUdcN4s=
X-Google-Smtp-Source: AGHT+IHvsim5hfEPT36Pv1MMgTI2Ub0TG9cOuknA5OgGvqqLm6Vo0O3qoG7l72L3fvgkVwHDPVfp3A==
X-Received: by 2002:a17:907:270e:b0:a9a:a5c:e23b with SMTP id a640c23a62f3a-aa581066cc6mr417493766b.58.1732781636013;
        Thu, 28 Nov 2024 00:13:56 -0800 (PST)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5997fcf5bsm38659066b.84.2024.11.28.00.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 00:13:55 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [2.8][PATCH] fetch2/git: Use quote from shlex, not pipes
Date: Thu, 28 Nov 2024 09:13:41 +0100
Message-ID: <20241128081341.2190513-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 28 Nov 2024 08:14:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16844

From: Richard Purdie <richard.purdie@linuxfoundation.org>

The pipes module is removed in python 3.13. It was already using the
quote function from shlex so use that directly instead.

The module already imports shlex too so it is an easy substitution.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/git.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index c7ff769fd..602914460 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -926,9 +926,8 @@ class Git(FetchMethod):
             commits = None
         else:
             if not os.path.exists(rev_file) or not os.path.getsize(rev_file):
-                from pipes import quote
                 commits = bb.fetch2.runfetchcmd(
-                        "git rev-list %s -- | wc -l" % quote(rev),
+                        "git rev-list %s -- | wc -l" % shlex.quote(rev),
                         d, quiet=True).strip().lstrip('0')
                 if commits:
                     open(rev_file, "w").write("%d\n" % int(commits))
-- 
2.47.1


