Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
	[209.85.221.41])
	by mail.openembedded.org (Postfix) with ESMTP id 8227679CFA
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Dec 2018 13:09:24 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id p4so3748610wrt.7
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 07 Dec 2018 05:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=9QkdgqhmfODH/I/c51KSw/b7R9gTnNJb7ZqVN0h4uCo=;
	b=Fc6PT53PqWub8UjCG0w8/RNpM85epA8GyS/62f6wOqJy0OeQduKfEZHvtvjr8Bkujw
	F4KnToKPdjoS2GGu0AUeaa8G6kOpCgpjtRQZqFLXOhGdt30e+7A7ZLiH4mv05ZY2UMz9
	GT03JHSp8LpcXK+ZUDQPdCTjsqW/wxEq6DfWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=9QkdgqhmfODH/I/c51KSw/b7R9gTnNJb7ZqVN0h4uCo=;
	b=F9mHl2oCMiEBrmPVT8SgfGgVBd5QpKnBf0QA50N5Po781+kFnXryVcFIL/X2OyAOwZ
	r9GhqmuQQdhpbRuLqdfnkDdRPw1hhl8oMwfI+9Z7rvIyr/+kJ0MDaJFfsbuEUHiBf9NO
	oQ87g1hievSHdLvBKREjeywHb7IHzbavoCepuYrq2cdPGiUkZT1n+HO1VbfRwKd8qvQw
	UMObKDWWFgjwx65Zq9RP/bfw09/sCj0uTvaD3t6lNM+w7WyLTfWCZmClQdOuXqLuuPsr
	SeoJJwY1kOKAk918J7JfQKskM6UBYO4CEit/22atOIwGRhMqTOWLOqRX4E4wSzY0qOt6
	MwEQ==
X-Gm-Message-State: AA+aEWbx2a1bq7THiJjaQ7Z1CblNSgXTLaTjDuFw7U//9xP0PAGfHfWT
	qY47zjUqMeRRQDrcSRoqQM/7PVQQ544=
X-Google-Smtp-Source: AFSGD/XbIeWN1cwlFvF3HDAPNib4KExphrGNCQJECgm+amECLMwRUeFSAp9zhOWYJ7sTAPFDXQZixA==
X-Received: by 2002:adf:f703:: with SMTP id r3mr1739835wrp.93.1544188164711;
	Fri, 07 Dec 2018 05:09:24 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	v8sm2535585wrq.53.2018.12.07.05.09.23
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 07 Dec 2018 05:09:24 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  7 Dec 2018 13:09:22 +0000
Message-Id: <20181207130922.18311-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Subject: [PATCH] fetch2/wget: Fix typo in exception name
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
X-List-Received-Date: Fri, 07 Dec 2018 13:09:25 -0000
Content-Transfer-Encoding: 8bit

This could clearly never have worked but as its in an error path, it doesn't
get tested/used much.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/wget.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 8f505b6de9..1237e56098 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -168,7 +168,7 @@ class Wget(FetchMethod):
                 """
                 host = req.host
                 if not host:
-                    raise urlllib2.URLError('no host given')
+                    raise urllib.error.URLError('no host given')
 
                 h = http_class(host, timeout=req.timeout) # will parse host:port
                 h.set_debuglevel(self._debuglevel)
-- 
2.19.1


