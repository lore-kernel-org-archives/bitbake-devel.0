Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web08.5695.1622191338656767164
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 May 2021 01:42:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Tn1gHe9H;
 spf=pass (domain: konsulko.com, ip: 209.85.221.42, mailfrom: pbarker@konsulko.com)
Received: by mail-wr1-f42.google.com with SMTP id q5so2467050wrs.4
        for <bitbake-devel@lists.openembedded.org>; Fri, 28 May 2021 01:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BdNCnwbmcHZeTAHgZ83tP3rQGbur6p/HewNtg6F18bc=;
        b=Tn1gHe9H0rXeP3//qRE4p8PTFF4wD572H/JlR47lGUULgqLzR/Nom/XWsjP2OnQzTK
         Y3tsWsul82cUpUJ3xgEgXGZddFz48amkrz6qws0fY5wwebfeXjshJt0SOh2mSbEu+ceP
         rba8STsokgRx50pIHm+wX2FzuiPbLryQarPms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BdNCnwbmcHZeTAHgZ83tP3rQGbur6p/HewNtg6F18bc=;
        b=Yp3004PKCV4X9XiECIVZZfbk6uOlndtW+pkNwBszxFb0Tnmrr/Y6seYW4FIKZSNLIC
         QZ8S+xE78Gt56lMYBijmvj3EJGhl2ZDuGqHAk0kFlOcU1QU2nyCq4UL+rqlafDjtJjLw
         OmPfeiVGu6nEZEnlYquNT5cNdq69eTuOpOWjTg6YTNssTdTAJOdn2IOcu6gkl947yw/A
         BBxWyRgRTxLA1VWdUk0SrKuPjNJH6G6ASChLY3q1rRJyHvky4wteJ4UNf4XjUmn9rYvU
         K/3egUptXbhhibS5SOtFmCVcDVtyzlsOliObePurMj03m8/pgegQjA/PzkoUK1hbut/M
         JdeQ==
X-Gm-Message-State: AOAM53285PJAAv3AzBq/n7Y1wHmSxTK9WjjevGbxGgYipWLybuq6z8DG
	YtrFXMR6wv4N3YjyO+vB1IixBsfb4uzP9Q==
X-Google-Smtp-Source: ABdhPJz6q+frdws1Oeznp6pbMbmyeLU+gXmCRZDaVFr6tmOC0HUF6Tu3etVvps0hMf+SQsabEkhVxQ==
X-Received: by 2002:adf:f60c:: with SMTP id t12mr7528865wrp.152.1622191337040;
        Fri, 28 May 2021 01:42:17 -0700 (PDT)
Return-Path: <pbarker@konsulko.com>
Received: from alpha.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id o17sm4596385wrp.47.2021.05.28.01.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 01:42:16 -0700 (PDT)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [PATCH 3/4] asyncrpc: Reduce verbosity
Date: Fri, 28 May 2021 09:42:08 +0100
Message-Id: <20210528084209.8408-4-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210528084209.8408-1-pbarker@konsulko.com>
References: <20210528084209.8408-1-pbarker@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 lib/bb/asyncrpc/serv.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/bb/asyncrpc/serv.py b/lib/bb/asyncrpc/serv.py
index 003a118b7..cfe23c84a 100644
--- a/lib/bb/asyncrpc/serv.py
+++ b/lib/bb/asyncrpc/serv.py
@@ -150,7 +150,7 @@ class AsyncServer(object):
         )
 
         for s in self.server.sockets:
-            self.logger.info('Listening on %r' % (s.getsockname(),))
+            self.logger.debug('Listening on %r' % (s.getsockname(),))
             # Newer python does this automatically. Do it manually here for
             # maximum compatibility
             s.setsockopt(socket.SOL_TCP, socket.TCP_NODELAY, 1)
@@ -176,7 +176,7 @@ class AsyncServer(object):
         finally:
             os.chdir(cwd)
 
-        self.logger.info('Listening on %r' % path)
+        self.logger.debug('Listening on %r' % path)
 
         self._cleanup_socket = cleanup
         self.address = "unix://%s" % os.path.abspath(path)
@@ -195,7 +195,7 @@ class AsyncServer(object):
             self.logger.error('Error from client: %s' % str(e), exc_info=True)
             traceback.print_exc()
             writer.close()
-        self.logger.info('Client disconnected')
+        self.logger.debug('Client disconnected')
 
     def run_loop_forever(self):
         try:
@@ -215,7 +215,7 @@ class AsyncServer(object):
             self.server.close()
 
             self.loop.run_until_complete(self.server.wait_closed())
-            self.logger.info('Server shutting down')
+            self.logger.debug('Server shutting down')
         finally:
             if self.close_loop:
                 if sys.version_info >= (3, 6):
-- 
2.26.2

