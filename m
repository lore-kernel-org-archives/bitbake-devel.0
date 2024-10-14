Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A90CD16260
	for <webhook@archiver.kernel.org>; Mon, 14 Oct 2024 12:54:16 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
 by mx.groups.io with SMTP id smtpd.web10.54290.1728910454627508836
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 14 Oct 2024 05:54:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=aQM/WydZ;
 spf=pass (domain: gmail.com, ip: 209.85.218.51, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a99f646ff1bso268012366b.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 14 Oct 2024 05:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728910453; x=1729515253; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hxHgMxFnJpTxJkFJJ/Sm+GDTV49uKy0ERUBEn/dv1gM=;
        b=aQM/WydZadIdihO8zJmtHGDNhDC660YUqVdSO21mz6LXnuAqppIhhmlqFmRt/IwI1I
         KM86Vj2lA+cJxywx5C7b2W0KhF39E57uXZaIYsXO+G8hVOF27Z9DYJYUTGNYA4MPwBGi
         wxHd2FYPAIOGM0WieGVcj/zTfJf7rpNN/YKOTJ02Zs2rh3kkT6f5dZd7vA6GCRB2Wcif
         UZhhRwx+i1fo5xbwAcDEmN5Ddk7nr2uKaqIyDlu5vH81+BHWQOaqfFFKsreLk6vzGCL9
         JIJUgn62eza7/zq0+irN93et+94+nwgcsUXgeC01tQz6HzHIhku6lNq9PWu48TfzkR9C
         mV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728910453; x=1729515253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hxHgMxFnJpTxJkFJJ/Sm+GDTV49uKy0ERUBEn/dv1gM=;
        b=dtxsT4KoEK4wA/e1I860xLSWElEXs1J5kqMF4zvkFlQm81LeaS1+zX3hxzui18/pbh
         BRRAKAudT2ZIwWyXkm3NdxGaPIzBEVtCqfiDxVTdnX83OY+ks9CIPLOUwi5FgTMf74GY
         zxTpbQOp7LCf1uOLRUWnXZEuVPbYR1Le3U85V2oVe7EMVyQwz2nCfCpFJeULADAbbDvT
         g/QgYe4ZtC8MygLc9tXWtGQ4v8/NtJhl9SSnWrfFAUj8R/PVckS+84KHf1JDHgcj0+21
         LRo8MXkDIKvfZG5qqD5et+6ucmYBIRwUEhjJSXqgJN+AM/I7IXD7iXNchoUiR1lPseAZ
         xKOA==
X-Gm-Message-State: AOJu0YwkbXCJcB8QgjhnSdiluflpSMSx68vaeVzkPdpXS/gHl3bx2Zxi
	lvcHLuCVu+JEhSSQfzbG155KiV2WNznclOJw7H4xi2jTcUPL2ew4FDGfjA==
X-Google-Smtp-Source: AGHT+IGQqq/Z/+LmoE8HnxnSD7Kky7XR8p2TCJEfCJokmfh475hvhOgDXah1gti/PksKp6ZqOHigtQ==
X-Received: by 2002:a17:906:7956:b0:a9a:1918:c6c6 with SMTP id a640c23a62f3a-a9a1918d031mr156044966b.8.1728910452599;
        Mon, 14 Oct 2024 05:54:12 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a07662ffbsm203129366b.130.2024.10.14.05.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 05:54:12 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH] fetch2/wget.py: use default wget user-agent in upstream version checks
Date: Mon, 14 Oct 2024 14:54:06 +0200
Message-Id: <20241014125406.2322310-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 14 Oct 2024 12:54:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16679

From: Alexander Kanavin <alex@linutronix.de>

This has been set to various mozilla versions from this point onwards without
explanation or specific examples:
https://git.yoctoproject.org/poky/commit/?h=master-next&id=ba06cc8943d021f406c3d292ce415b77319ca5c6

However, sourceforge has recently banned the current 'fake mozilla' version
we've been supplying, resulting in broken version checks:

alex@Zen2:/srv/storage/alex/yocto/build-test-sourceforge$ devtool check-upgrade-status gptfdisk
...
--2024-10-12 11:53:23--  https://sourceforge.net/projects/gptfdisk/files/gptfdisk/
Resolving sourceforge.net (sourceforge.net)... 172.64.150.145, 104.18.37.111, 2606:4700:4400::6812:256f, ...
Connecting to sourceforge.net (sourceforge.net)|172.64.150.145|:443... connected.
HTTP request sent, awaiting response... 403 Forbidden
2024-10-12 11:53:24 ERROR 403: Forbidden.

gptfdisk                  1.0.10          UNKNOWN_BROKEN  Alexander Kanavin <alex.kanavin@gmail.com>

On the other hand, using wget's default user-agent works just fine:

--2024-10-12 12:16:06--  https://sourceforge.net/projects/gptfdisk/files/gptfdisk/
Resolving sourceforge.net (sourceforge.net)... 104.18.37.111, 172.64.150.145, 2606:4700:4400::6812:256f, ...
Connecting to sourceforge.net (sourceforge.net)|104.18.37.111|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: unspecified [text/html]

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bitbake/lib/bb/fetch2/wget.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index e8b1292433f..493a5b62ee2 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -463,7 +463,7 @@ class Wget(FetchMethod):
         f = tempfile.NamedTemporaryFile()
         with tempfile.TemporaryDirectory(prefix="wget-index-") as workdir, tempfile.NamedTemporaryFile(dir=workdir, prefix="wget-listing-") as f:
             fetchcmd = self.basecmd
-            fetchcmd += " -O " + f.name + " --user-agent='" + self.user_agent + "' '" + uri + "'"
+            fetchcmd += " -O " + f.name + " '" + uri + "'"
             try:
                 self._runwget(ud, d, fetchcmd, True, workdir=workdir)
                 fetchresult = f.read()
-- 
2.39.5


