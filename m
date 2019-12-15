Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
	[209.85.221.48])
	by mail.openembedded.org (Postfix) with ESMTP id 451007F7C0
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 15 Dec 2019 09:41:15 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id t2so3546721wrr.1
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 15 Dec 2019 01:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=N/41m9FjeFwfljkQG3XClWWU0CQcDUqP4Q6kkxha2EU=;
	b=deaqUNV8lCgOUWDQ9jN6R9s1nf8WbZxow1Hmx0mjNQyDviG2Kels6ZL2m8Yv45GO/x
	QzsYctMPKW4gVDiynJTua/d7q+8FD/Ode2lT+aNPZg1HDOnmFBSZb1pua5UcBO4zl5cv
	73TWyWoxcxFr9LetNskHWcy/mlszOa/deqnXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=N/41m9FjeFwfljkQG3XClWWU0CQcDUqP4Q6kkxha2EU=;
	b=kzlNIJ1PEjW5RFUvVJXYGFlJ4y2b4YX35f4ZnBaxrwpIogk5OIiemZ2oKDJL4bkjHp
	k2mb9UXBgRKq2YQ4GDsEyzkCKOLYJdtVOUZMb2r8058PipWGyVTnD5RolcL7qgx/aob/
	TR+M6IYYN6oOPCmLA4PrnqwT7h3mRcqwerJW8IaG+lb8wc8kFiMFeIE7J1SY/rKKARjA
	kNQdT3qreZsqIbmKPDaOPkgFkioTfQG3yzHbK2npbENW07jMLFurP1AVmp3TF5MTNTis
	Lf0ZA6V7Se7IBsD3Oh/9+y8hADwJOm80cl46wiuAUnLt3H+nrlbkHNkLIRsTtiDuVxo3
	2Pag==
X-Gm-Message-State: APjAAAVOV7hsV3n3MdNvSihM7en/Gx22HhilgOp4WYOlkZy2VunJVyM5
	kV2gspek9eF5NuBEzxxAo/62wN3cgnc=
X-Google-Smtp-Source: APXvYqwi4zN8LkZGudEY0h/6S6VftnlgjHEnT1MK3ZsZ8zxNOtaLXTrgJekTWutnHtCljfM1ZwLRBQ==
X-Received: by 2002:a5d:6a0f:: with SMTP id m15mr23896690wru.40.1576402875871; 
	Sun, 15 Dec 2019 01:41:15 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	e8sm16877572wrt.7.2019.12.15.01.41.14
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Sun, 15 Dec 2019 01:41:14 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 15 Dec 2019 09:41:09 +0000
Message-Id: <20191215094112.28162-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191215094112.28162-1-richard.purdie@linuxfoundation.org>
References: <20191215094112.28162-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 2/5] runqueue: Fix task mismatch failures from incorrect logic
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
X-List-Received-Date: Sun, 15 Dec 2019 09:41:15 -0000
Content-Transfer-Encoding: 8bit

The "no dependencies" task case was not being correctly considered in this
code and seemed to be the cause of occasionaly task hash mismatch errors
that were being seen as the dependencies were never accounted for properly.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index a45b27ce51..b3648ddb54 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2286,7 +2286,7 @@ class RunQueueExecute:
             current = next.copy()
             next = set()
             for tid in current:
-                if not self.rqdata.runtaskentries[tid].depends.isdisjoint(total):
+                if len(self.rqdata.runtaskentries[p].depends) and not self.rqdata.runtaskentries[tid].depends.isdisjoint(total):
                     continue
                 procdep = []
                 for dep in self.rqdata.runtaskentries[tid].depends:
-- 
2.20.1


