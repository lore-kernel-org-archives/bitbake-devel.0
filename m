Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
	[209.85.128.42])
	by mail.openembedded.org (Postfix) with ESMTP id 034CC7D6C5
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Aug 2019 15:02:53 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id p74so4879660wme.4
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Aug 2019 08:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=wGng2OoYPUCS416VBV6mCMW3mJ0TzLaxTVvoDLmXAck=;
	b=fCr46B3RbysAJjCu6C0kQY36azLY78f/MvBSOUtNU/27sMNfGtdUPW+aXjvPiq6+wx
	A1ZUcFizHb7G3cCMqHXgqWoHQDiK9mL0S4O/i2nhPbD74hXEnYpV+KaRYEhwcXWBdmcp
	+SAFDXZVafAiO/S14kqAR2d4T7z5KCi7vO9+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=wGng2OoYPUCS416VBV6mCMW3mJ0TzLaxTVvoDLmXAck=;
	b=LrK0zZ/SCkZwd0clcF3Ny4bRZupdyj/YI/qcvQBp/303kZ4nrxx9Vq2Zy7QCfb2ZUo
	aOC8Foj0Vs+CTxB9UrLWQTec/4UXC9XoSJPlzWeNB1FN+UElYhRh9u97eZLXW4V1q8HH
	Cbe/oxE/TobnTjlb14uOMc7/GwWFQjvaE9OCzYLd0Kyjyd1w4vPmhBVVvDvMtSZRuURl
	jo8j0DMOwIG2SF+txa/TbvZ63zwIrJv40O6Lur8Wzk5Gpy4h+oN6IyW2djFZP0bXdlAl
	7nqaibFnqg0LjdlGuHsxvKwq6GdK3OOCiBfPXHbOyTI1pUWARHvPvrHRf6qPYAqRAKUU
	1pJg==
X-Gm-Message-State: APjAAAWjdTBb308a6aj4ko9yuRstMREBL2LlgD7CpgejSW+jCy7vHseP
	cS1+sG6u8uH++/Ok2F2x1WcxrfFn5YIB+Q==
X-Google-Smtp-Source: APXvYqxl71oKUxeDGFKvo8oDYNgBit9pKQUVEWEh1JeeUEE3wDn7/6uxd7rxmodRMukyKKP/vwfXbQ==
X-Received: by 2002:a05:600c:40f:: with SMTP id
	q15mr9270724wmb.88.1565794974385; 
	Wed, 14 Aug 2019 08:02:54 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	v65sm6165285wme.31.2019.08.14.08.02.53
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 14 Aug 2019 08:02:53 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Aug 2019 16:02:50 +0100
Message-Id: <20190814150250.332-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814150250.332-1-richard.purdie@linuxfoundation.org>
References: <20190814150250.332-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 3/3] runqueue: Ensure we clear the stamp cache
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
X-List-Received-Date: Wed, 14 Aug 2019 15:02:54 -0000
Content-Transfer-Encoding: 8bit

When the task hashes change we need to ensure the stampcache is cleared out
else tasks don't rerun when they should as we're basing decisions on stale
cache data.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 9f4337610b..4bf817773a 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2307,6 +2307,9 @@ class RunQueueExecute:
             (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
             self.sqdata.stamps[tid] = bb.build.stampfile(taskname + "_setscene", self.rqdata.dataCaches[mc], taskfn, noextra=True)
 
+            if tid in self.stampcache:
+                del self.stampcache[tid]
+
             if tid in self.build_stamps:
                 del self.build_stamps[tid]
 
-- 
2.20.1


