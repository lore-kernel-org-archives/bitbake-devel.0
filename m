Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.web10.31508.1590746780896492285
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 May 2020 03:06:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=rLkpf9ia;
 spf=pass (domain: gmail.com, ip: 209.85.128.65, mailfrom: maurofrqueiros@gmail.com)
Received: by mail-wm1-f65.google.com with SMTP id r9so2597916wmh.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 29 May 2020 03:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zxiABiSFJE6g8mk1YKJmTkaeIZvEDmGOrtB1hOGNV/A=;
        b=rLkpf9iaHqyyZ04RaR5GG0jZS1+TxjabOwNY5AuYv/XpgRpEkhcHGaRfZDwIHudXBz
         kNowdE8ZniyGzljTHjXe+hgrv+IHfHe8yPmKpLYzqEicV7eZxdnzvDCw5OEigJJbUYon
         byhQdUXpIVrj/UkWsjKc2O7b/jhgKiEG0tPQWR6X2jP59OXXGc7O1v6Q1mEex7V/WPV9
         YH4onwmriR4A3cFj+S2O0WgwmoY3sc7pZUdN6r0T3khrnikpppBmbJmghgF/sKu8U2YQ
         wp6/NRrHz36dEeBGOkWgPQd7JEmkht8bTgfZ7rTq0w+J86zrGHsM7X/UFRt3w65QucfG
         tImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zxiABiSFJE6g8mk1YKJmTkaeIZvEDmGOrtB1hOGNV/A=;
        b=Qf2rzEchLVRUj9pUjDFm6z+0yFGChj17d30HIf+DJMF6pWV2AzuotkcjitTxEbw84r
         CCtZmrK5wcsdU86xtP4OutUk1wzf8YJeoIIjsaBWYEvHZAcxH/vqlLUWT8FyvZ32KnK9
         9W+zSY097vPoZj12NsFLt9u5JBs6A7+Q2MnF5zGtc61qearDCECMf+kGSWts5nxUhSQ3
         hlfEd/Dv2AdU7Pcx2tkp1J7OK1+IzwlsTTqbSoSgUldT+eLR5oEyzzla808I1ljbKVgR
         i8UnvWY0ekx5aMnZ+Kyrl0GIkRb7P8ocHzWKj+2eZygDYDp4xIHyq9zyjI9Q20igfjr8
         NTng==
X-Gm-Message-State: AOAM531FHjDBQKv1IdFJz9LDhH6mfeBmjiig3pl6OtOg/R9BEKhM7Svn
	vNkinZ18GHkV6rRPQPer7SL8SvvLJ/M=
X-Google-Smtp-Source: ABdhPJym1qc+A+yUp2/fIEjEsUjRcASSIY9Q5RUM64y8caz55m2Z/Tfh/ftl0nCa0QkQQtcAwQBu4w==
X-Received: by 2002:a1c:5a86:: with SMTP id o128mr8080701wmb.77.1590746779207;
        Fri, 29 May 2020 03:06:19 -0700 (PDT)
Return-Path: <maurofrqueiros@gmail.com>
Received: from ctw-bre-003.criticaltechworks.com ([83.240.214.249])
        by smtp.gmail.com with ESMTPSA id c140sm9815871wmd.18.2020.05.29.03.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 03:06:18 -0700 (PDT)
From: =?UTF-8?B?TWF1cm8gUXVlaXLDs3M=?= <maurofrqueiros@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Mauro Queiros <maurofrqueiros@gmail.com>
Subject: [PATCH v2 2/3] git.py: LFS bitbake note should not be printed if need_lfs is not set.
Date: Fri, 29 May 2020 11:06:08 +0100
Message-Id: <20200529100609.32456-2-maurofrqueiros@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200529100609.32456-1-maurofrqueiros@gmail.com>
References: <20200529100609.32456-1-maurofrqueiros@gmail.com>

The message "Repository %s has LFS content but it is not being fetched" was
being printed, even when Git-LFS was available and "lfs=1" was set. In those
situations, we want to fetch LFS content, so that message would not make sense.

Signed-off-by: Mauro Queiros <maurofrqueiros@gmail.com>
---
 lib/bb/fetch2/git.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 4c7d388e..eab76a10 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -509,7 +509,7 @@ class Git(FetchMethod):
         if self._contains_lfs(ud, d, destdir):
             if need_lfs and not self._find_git_lfs(d):
                 raise bb.fetch2.FetchError("Repository %s has LFS content, install git-lfs on host to download (or set lfs=0 to ignore it)" % (repourl))
-            else:
+            elif not need_lfs:
                 bb.note("Repository %s has LFS content but it is not being fetched" % (repourl))
 
         if not ud.nocheckout:
-- 
2.17.1

