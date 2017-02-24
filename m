Return-Path: <anders@chargestorm.se>
Received: from mail-lf0-f52.google.com (mail-lf0-f52.google.com
	[209.85.215.52])
	by mail.openembedded.org (Postfix) with ESMTP id 7E55977511
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Feb 2017 20:53:00 +0000 (UTC)
Received: by mail-lf0-f52.google.com with SMTP id l12so13685098lfe.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Feb 2017 12:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=chargestorm-se.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=s6pk1t1Hab9zAAAFJ91+NqvucubIzWIdxA4hLOWuhF8=;
	b=zQg3/qbzU0NhXZQHN/oQ8JOM7RXNzkm8gVOhlifbk/z2SDLbFHWA1uhP2QVvrylogt
	91DsudabGFSb9ao0xdK5nx1KOCqxazd4xwQWwodqksPNGTMVV0GNintHIUcxnQLn0TJ6
	z8uHk7bS8H40wNlRAD9tH6jNtYhQuXdlVHuqD/x2EJd3BZw0zLhYEY9CzDt0TtE0Ojkx
	gkPWPPLLnF1pzv3rzg2GKlyPe9DPD6jCw1DqXOJ8fgQGvZZLjVrouo1vbG06Vq/XrW8I
	VqcFJZ1sqGfD8XZWnbcLq473FU1yeAOxNkEXLIK5g8r53yf4AJ15/mhAqOdE4k77exPL
	gV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=s6pk1t1Hab9zAAAFJ91+NqvucubIzWIdxA4hLOWuhF8=;
	b=LC464Q6SXpsmF9R0VaJP9L3r/FMQ8JyROJ6qax+DmsE8a0OFAhaZA83AHa8d1N7tQ2
	GJibxZrx7EL9bVjZT3wmWZYPCx10uysGwFgBxw3ZnuS9T84uuZqxSEnxn2gCwRxTT1Ux
	nKCUTyMXwO6X90EBFBqojt7WZUieKXM2wXUItRdbENmM6KyWbNj0fchYPS3qCGm7fBOs
	t34IpKyCCN+qFv9t4A6hlFfloEw9EY5LPA/peTSUiG7RCHbIiQLPMCm8Qi7Na3u6J5VT
	J5NfwsPekZXVDo8kGdqVVmd52HoWGFszLTeLMHldAdSHDh6eURxRNitirv7Fam09w7jD
	qIFA==
X-Gm-Message-State: AMke39k1O86Ui2OGu6yjpKuxJzKNAff3mw7giqOV1VXKvPbf4Y771y7gG/ebiXZN1pH83w==
X-Received: by 10.25.153.69 with SMTP id b66mr1425859lfe.85.1487969580974;
	Fri, 24 Feb 2017 12:53:00 -0800 (PST)
Received: from localhost (h83-209-191-235.cust.se.alltele.net.
	[83.209.191.235]) by smtp.gmail.com with ESMTPSA id
	m127sm2209193lfg.58.2017.02.24.12.52.59
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 24 Feb 2017 12:52:59 -0800 (PST)
From: Anders Darander <anders@chargestorm.se>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 24 Feb 2017 21:52:54 +0100
Message-Id: <a86f980a1cbae28577ea6744f2b628d7c058a8a8.1487969243.git.anders@chargestorm.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1487969243.git.anders@chargestorm.se>
References: <cover.1487969243.git.anders@chargestorm.se>
Cc: Anders Darander <anders@chargestorm.se>
Subject: [PATCH 1/2] fetch2/__init__: handle @ in package names
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
X-List-Received-Date: Fri, 24 Feb 2017 20:53:00 -0000

A number of npm packages use @ as a leading chararacter.
Examples are most of the angular2 packages.

Signed-off-by: Anders Darander <anders@chargestorm.se>
---
 lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 70387f5..760e24f 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -356,7 +356,7 @@ def decodeurl(url):
     user, password, parameters).
     """
 
-    m = re.compile('(?P<type>[^:]*)://((?P<user>[^/]+)@)?(?P<location>[^;]+)(;(?P<parm>.*))?').match(url)
+    m = re.compile('(?P<type>[^:]*)://((?P<user>[^/;]+)@)?(?P<location>[^;]+)(;(?P<parm>.*))?').match(url)
     if not m:
         raise MalformedUrl(url)
 
-- 
2.10.2


