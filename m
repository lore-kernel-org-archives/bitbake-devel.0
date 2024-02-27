Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCE5C54E4A
	for <webhook@archiver.kernel.org>; Tue, 27 Feb 2024 22:04:51 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web10.2141.1709071482195877941
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Feb 2024 14:04:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=KK2r1IjN;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.169, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e558a67f70so458474b3a.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 27 Feb 2024 14:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1709071481; x=1709676281; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xTtnClzude1w+mRbVlZD25E2otjtUn7s20Uas2oq4pk=;
        b=KK2r1IjNv4DSHnML+n67qOLoJtE4Y0rIeLXizIOw6O0aolwIhQ4Xc6I+kWkNRkFn1e
         qqRJVcCoRri/UtC52h6QwJ9PPUcZZeIWMa7vdMnwWkFtIptyAbP6ulkaxtWAa/+hligf
         +5zY7uSN4peAjy1qTlwLR0wHd+HMmWndVQGA4EU1yQC9rgpxpJviVLfqVKRXJSpgO4p0
         XEiXE6ZjuI1gKsZYo2dDawJcLMgtij1r+kmpB44lZ2zPndJiCxsM6fkiuHZO1fEjcFZo
         h4krxq+CmJOfaYYkmbuZGu6F2uslZPe/UxoT3VHPVsQhWPdy3ItO9Ck+SqrEfn0Y/D4i
         LNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709071481; x=1709676281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xTtnClzude1w+mRbVlZD25E2otjtUn7s20Uas2oq4pk=;
        b=K6LPjGqUB0P0O5+MeIP21LYnUl+S6oexbBHCdzT9ehwAgeczCAQhCCm8cuvNxYsNKr
         jY66FP4sV8yUH1V8qViP6Q8VouuT8DEh6Aid1mWADvp3qAdpYS//JwgU8wL+y2IauEPP
         0Kq+RWby8tpZCOQ9lYgdV2+Kr7WTtZXItmSnRrJhYYWTrLyGlLzwYg4OPsdCQRu3HQmr
         I2fiEcCLRGuvV8JhCVKvb5DLtBDZkjhiy0MgFC82S9aBZKaPeBWiGUSHOXALo2ioOPPu
         7eDmIHXj/mTiIoNjCwdsfK1z6s53oYlrV4XUnj4T/C1dRYus73eYT4cZK1M0OaMvL/HG
         jrBQ==
X-Gm-Message-State: AOJu0Yz2ENSPAnmI5lz3QmI5tswqOFNZF+OvutUL6PDJvHxEr1GzzRXm
	ZK1xa3/p25e7/Kx12/CCxO4vHxXk+FeFlrqa/DzwMSvMz6FGN1gnuDndQyqEy+ntDgVyNc6CWbo
	wfqg=
X-Google-Smtp-Source: AGHT+IHMXB4pwDaU/CtEFtUiraMmnkSzHf5B6HZxc0EBeDsBKDLuzWIkB9V/7b4O73YQan3wCOh70A==
X-Received: by 2002:a62:5ec7:0:b0:6e4:aca:ce0d with SMTP id s190-20020a625ec7000000b006e40acace0dmr10060260pfb.31.1709071481472;
        Tue, 27 Feb 2024 14:04:41 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-234-108-41.hawaiiantel.net. [72.234.108.41])
        by smtp.gmail.com with ESMTPSA id t13-20020a056a0021cd00b006e50c0d6421sm5059772pfj.11.2024.02.27.14.04.40
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 14:04:41 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 3/6]  bitbake/lib/bs4/tests/test_tree.py: python 3.12 regex
Date: Tue, 27 Feb 2024 12:04:22 -1000
Message-Id: <7efed7bc09c56e41d3074a26388581a62f145625.1709071317.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1709071317.git.steve@sakoman.com>
References: <cover.1709071317.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 27 Feb 2024 22:04:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15969

From: Adrian Freihofer <adrian.freihofer@gmail.com>

Python 3 interprets string literals as Unicode strings, and therefore
\s is treated as an escaped Unicode character which is not correct.
Declaring the RegEx pattern as a raw string instead of unicode is
required for Python 3.

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bs4/tests/test_tree.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bs4/tests/test_tree.py b/lib/bs4/tests/test_tree.py
index 8e5c66426..cf0f1abe0 100644
--- a/lib/bs4/tests/test_tree.py
+++ b/lib/bs4/tests/test_tree.py
@@ -585,7 +585,7 @@ class SiblingTest(TreeTest):
                     </html>'''
         # All that whitespace looks good but makes the tests more
         # difficult. Get rid of it.
-        markup = re.compile("\n\s*").sub("", markup)
+        markup = re.compile(r"\n\s*").sub("", markup)
         self.tree = self.soup(markup)
 
 
-- 
2.34.1


