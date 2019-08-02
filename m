Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail.openembedded.org (Postfix) with ESMTP id 690727F318
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Aug 2019 15:20:57 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id p13so3026652wru.10
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 02 Aug 2019 08:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=Q/o7AARRq1eyqyxaMJsBu5swffyaYl+spW0FSzD9qaA=;
	b=FnUQSvHHht/+Ka7e9+tNdVr+CejwDu71ZFn2CHXuvjNumG8DhFI32wIiRNrq++4hRi
	a3Riznyws0xvkD+Z3vS8p5akgNWaf+giJGPriCLpQ9Oq3otfY0ZWWNSAvstR+rlfaWL3
	EYnxyg7vqdEy+vtGJKudlne+XCkAby00PM6AM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=Q/o7AARRq1eyqyxaMJsBu5swffyaYl+spW0FSzD9qaA=;
	b=surZAJ3xWe5C/mFHhn+pm+DlmZG3k47XvOboxY5sLKhOsnhAf8CNSHIEhVloFnPzrs
	OxXYSToPPxS3+iv3STZx46gEXLAvDd4mKasjhhNdOCYQRXnmOLWu/hJfSNYuDLtX3WKd
	iJYYAV7dEngCctTsOByvZsCceS791naSRqZ9bs+5dHyyL8poKDFRgJhrUWJeQghcUFtM
	9Xsd/DSs6JysSlVp0p9cJjZOK8fv0LqBmVS3FWKFhVwLcqGYgbPYW16zWxQCzC26npY9
	r9sJ6dtdUKpjVmvTHSWbrkSIYcwM7ixxXdAn7FzeUBl55TmdJswTSXwllSOlzoLnA9uC
	zNtw==
X-Gm-Message-State: APjAAAXMhsDG2zJw0Ta/JFgyZtAKebtESdtpz6ETVGQjYmJt3t2LUWAt
	EneqdZrP8Z9wm5q/0X+QrFr2YU4IRYg=
X-Google-Smtp-Source: APXvYqy8jRs7A7HSRH8RBRof/gVcbuQIzivx2ryT5Jy3lq2CpqZsKQiJCxIRdXoVqO6Ov/EJeQpd6Q==
X-Received: by 2002:adf:deca:: with SMTP id i10mr6412089wrn.313.1564759257778; 
	Fri, 02 Aug 2019 08:20:57 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	p14sm62491785wrx.17.2019.08.02.08.20.57
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 02 Aug 2019 08:20:57 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  2 Aug 2019 16:20:41 +0100
Message-Id: <20190802152049.16529-8-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802152049.16529-1-richard.purdie@linuxfoundation.org>
References: <20190802152049.16529-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 08/16] hashserv: Turn off sqlite synchronous mode
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
X-List-Received-Date: Fri, 02 Aug 2019 15:20:57 -0000
Content-Transfer-Encoding: 8bit

We're seeing performance problems with hashserv running on a normal build
system. The cause seems to be the large amounts of file IO that builds involve
blocking writes to the database. Since sqlite blocks on the sync calls, this
causes a significant problem.

Since if we lose power we have bigger problems, run with synchronous=off
to avoid locking and put the jounral into memory to avoid any write issues
there too.

This took writes from 120s down to negligible in my tests, which means
hashserv then responds promptly to requests.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/hashserv/__init__.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/hashserv/__init__.py b/lib/hashserv/__init__.py
index 7ec9b64419..544bc86b16 100644
--- a/lib/hashserv/__init__.py
+++ b/lib/hashserv/__init__.py
@@ -21,6 +21,8 @@ class HashEquivalenceServer(BaseHTTPRequestHandler):
     def opendb(self):
         self.db = sqlite3.connect(self.dbname)
         self.db.row_factory = sqlite3.Row
+        self.db.execute("PRAGMA synchronous = OFF;")
+        self.db.execute("PRAGMA journal_mode = MEMORY;")
 
     def do_GET(self):
         try:
-- 
2.20.1


