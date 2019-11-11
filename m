Return-Path: <gavinli@thegavinli.com>
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com
	[209.85.215.196])
	by mail.openembedded.org (Postfix) with ESMTP id 252F17F921
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 Nov 2019 22:17:44 +0000 (UTC)
Received: by mail-pg1-f196.google.com with SMTP id z24so10369796pgu.4
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 Nov 2019 14:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=thegavinli.com; s=google;
	h=sender:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=KcRSQBfDWVESUb6T3zVZsMVOyHuOlSijvNN95yuoaKg=;
	b=Q4SRwTX5r9NXRMRPGlLdGypM5QJiFKaUYqmMvewDTE4Bg/79gk9ZRonEIT4IlACGh1
	Ta4suPu04DMpn3OSkH+YITRECLOHstwDxdPOb1Z9rJ49eMaiFFUq92N4iT5A4K8ji3FI
	xdb6DqKiEnJYElMHO5TUTd9ViKq9EHjqX0+1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding;
	bh=KcRSQBfDWVESUb6T3zVZsMVOyHuOlSijvNN95yuoaKg=;
	b=b7KOKBOFl0BjIBhsCXNdIHu0hBy5GMgbVesRzikD0ZX0iWP42NR3qIGWs4rNgtBBLG
	G4oJd5JrPjE08JkE0yUnMNCWCKNIhBn0pnlpD3tR8MQTt0vpqD+e+gGoJvAB1AlN0w6I
	m/U63wtIT0GeK61zKiWyfI8qQcnwVZiy6yhQdIt9gPt1pMjuYuVGaB7IML+8odiw3oeM
	bxJSv0ZH4Cw+U55J+tMd+MCLlzfzbZqf5iRUFLqDp4NB4GsSSKlZP50lxtMyPjExVghv
	8fhg3uxncwzjcPfTc8JYNJSzSvbxkgERsd1vZBfNjIZ8XtxLqg6c0blXaGGXdZaevxn4
	vuWg==
X-Gm-Message-State: APjAAAWN9lN9Zve1Fy6fa3HIT1aMQ05wavtElExi7YXpVyQO10tubkeA
	Vaqb/DNGwKQA8m1gMuLrTe0V8OFMZ04=
X-Google-Smtp-Source: APXvYqzbE7+V4o+dKZ3+5NkW6/qt9xREIEev47g5Smp2lXglXBVOucyR4qDc0og4/9ON/FKERZg+oQ==
X-Received: by 2002:a63:f945:: with SMTP id q5mr21288330pgk.340.1573510664852; 
	Mon, 11 Nov 2019 14:17:44 -0800 (PST)
Received: from mtgav.corp.matician.com ([2601:647:5a01:84c0::b5a])
	by smtp.gmail.com with ESMTPSA id
	x13sm6606669pfc.46.2019.11.11.14.17.43
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 11 Nov 2019 14:17:44 -0800 (PST)
Sender: Gavin Li <gav@thegavinli.com>
From: gavinli@thegavinli.com
To: bitbake-devel@lists.openembedded.org
Date: Mon, 11 Nov 2019 14:17:39 -0800
Message-Id: <20191111221739.1663625-1-gavinli@thegavinli.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Cc: Gavin Li <gavin@matician.com>
Subject: [PATCH] bitbake: prserv: fix ResourceWarning due to unclosed socket
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
X-List-Received-Date: Mon, 11 Nov 2019 22:17:44 -0000
Content-Transfer-Encoding: 8bit

From: Gavin Li <gavin@matician.com>

With PRSERV_HOST = "localhost:0", this message would occasionally pop up
during the initial cache read:

WARNING: /home/matic/ambayocto/poky/bitbake/lib/bb/cache.py:446: ResourceWarning: unclosed <socket.socket fd=10, family=AddressFamily.AF_INET, type=SocketKind.SOCK_STREAM, proto=0, laddr=('127.0.0.1', 45655)>
  value = pickled.load()

The file location stated is irrelevant; it just happens to be wherever
CPython decides to run the garbage collector. The issue is that after we
fork off a PRServer, self.socket is also duplicated. The parent side of
it also needs to be closed.

Signed-off-by: Gavin Li <gavin@matician.com>
---
 bitbake/lib/prserv/serv.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/prserv/serv.py b/bitbake/lib/prserv/serv.py
index be3acec36a..1d9148b817 100644
--- a/bitbake/lib/prserv/serv.py
+++ b/bitbake/lib/prserv/serv.py
@@ -243,6 +243,7 @@ class PRServer(SimpleXMLRPCServer):
         try:
             pid = os.fork()
             if pid > 0:
+                self.socket.close() # avoid ResourceWarning in parent
                 return pid
         except OSError as e:
             raise Exception("%s [%d]" % (e.strerror, e.errno))
-- 
2.23.0


