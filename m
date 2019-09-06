Return-Path: <martin.jansa@gmail.com>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by mail.openembedded.org (Postfix) with ESMTP id 7EF367F363
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  6 Sep 2019 11:31:44 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id i1so5622446wro.4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 06 Sep 2019 04:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=dU9QlSRYabcX/W00X9EGZfb55BjbEGKlkDmhTT2CsTo=;
	b=Eqc77DFbAoEx44DnOO6jIZdBz0Z7OHDJf9vIUxm4DDm/e9FQJ+lDEIMmVzOQ+Bd9K4
	VRqD5MmjF06vL/DUtH9X1uaKn+ZUOt9kbVJWssqIjDgdjhi55FFDvIbeURXzAhudPygV
	060cBS8OxduE5lchITcqNANOcoK0aZ+MtmoyhCpFskr2eSJLpciaD+v+ArcdoxDLF3WZ
	HdqgtjfWGMoTilqFTdHzoXej9MVysDZd/2NQn1qc/PQH/NA9/WdnK4SsoDqny1lb4GEf
	NuM+KhSOSkELQNVk3x60JbsYvkkuIswUVEhVZzGBudk00vkOYGzyUlipcFKf4J6EgBsE
	J95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=dU9QlSRYabcX/W00X9EGZfb55BjbEGKlkDmhTT2CsTo=;
	b=YpDvXGKwyVvQ+6cY7dVFLBDUCHD6UaeCtHhO1ScLxnJS0EndyFPMmR4yt3LNL3NA19
	sT4dW+qIVIdft2cSndIJ7OKXKj/AieCj2CPMk5NegZMNUtIHXzxvRIb0pdvYOlqGoDWn
	kivB06fvOhCRx2kRnFrGJap0fWfL7euRra6irf/AvgbS8Bd1GbB2AGXsE9XACQZQDYbh
	DOJfKSZNNoOltxDFYNQ3nuDTaVxCFZfQExO8PfNbGXQ2Xa3BDK1vPlgFkv6h7qYLKWBU
	WWL2asABhK7LOcS78XRjiRu3eITiaDj0Tlw+gLO9EVn3Ss6Y5iBqfGwLunV6nt6ozmTm
	eztA==
X-Gm-Message-State: APjAAAWkXEd5M/p+jiez35Ev5+FV/46mHNDcUtzlkXMZTu8KkoMYal2s
	g9D0Qlt5korbCkpWARsxZbRJHtCeMW8=
X-Google-Smtp-Source: APXvYqxDxiZ8cJ8HD3VcYAgYHSZJpZdRqxY4eZgTezwS7m25gFxi9EsRuvRVCBDMbxtGmAbnih0s7Q==
X-Received: by 2002:adf:e503:: with SMTP id j3mr6471405wrm.166.1567769504954; 
	Fri, 06 Sep 2019 04:31:44 -0700 (PDT)
Received: from localhost (ip-217-030-068-212.aim-net.cz. [217.30.68.212])
	by smtp.gmail.com with ESMTPSA id x6sm8997967wmf.38.2019.09.06.04.31.44
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 06 Sep 2019 04:31:44 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  6 Sep 2019 11:31:44 +0000
Message-Id: <20190906113144.58253-1-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 2.17.1
Cc: Herb Kuta <herb.kuta@lge.com>
Subject: [PATCH] bitbake-user-manual: Improve the example for Removal (Override Style Syntax)
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 06 Sep 2019 11:31:44 -0000

* to better show how it works with spaces and multiple values

Signed-off-by: Herb Kuta <herb.kuta@lge.com>
Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 .../bitbake-user-manual-metadata.xml                 | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
index a125ad33..88622421 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
@@ -420,13 +420,17 @@
      FOO = "123 456 789 123456 123 456 123 456"
      FOO_remove = "123"
      FOO_remove = "456"
-     FOO2 = "abc def ghi abcdef abc def abc def"
-     FOO2_remove = "abc def"
+     FOO2 = " abc  def ghi abcdef abc def abc  def def"
+     FOO2_remove = " \
+         def \
+         abc \
+         ghi \
+     "
                 </literallayout>
                 The variable <filename>FOO</filename> becomes
-                "&nbsp;&nbsp;789 123456&nbsp;&nbsp;&nbsp;&nbsp;"
+                "&nbsp;&nbsp;789&nbsp;123456&nbsp;&nbsp;&nbsp;&nbsp;"
                 and <filename>FOO2</filename> becomes
-                "&nbsp;&nbsp;ghi abcdef&nbsp;&nbsp;&nbsp;&nbsp;".
+                "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;jkl&nbsp;&nbsp;abcdef&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;".
             </para>
 
             <para>
-- 
2.17.1


