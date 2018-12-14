Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail.openembedded.org (Postfix) with ESMTP id 826447BB8D
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Dec 2018 14:02:23 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id q18so5539714wrx.9
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Dec 2018 06:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=+gJJy8yfBZeKi2Yh2pbu2nREXujcR/X/hhFyMCl31NI=;
	b=An5L4PS5EGhfYvlPsxmGexWvkDIXVlBImW5nVuLsOSXobENOCLaOeRxcBHMB6byalc
	0dPqVqFZToGYdsxtrs3ZUK3j/JtFbXMZ83YQXDRt+HC7dRdnkg1zD33rxCLbnWGxzQQT
	18yP1l+u1dC7OIc0YZo2NLUkCCLjo3Jn6B91Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=+gJJy8yfBZeKi2Yh2pbu2nREXujcR/X/hhFyMCl31NI=;
	b=PEAZ086sIw3oevjOtZ8qRUQnBtbUPVvscCcFdNItJ6QHq9fxAIrkGxXfWhpMUFrY9i
	7hHHg2NSjpoJruLIworC2iZWWUH38oaVQmr7z1y8m7cRwsAa8FCKoY6YFXZowK4rBS4Y
	hi80lkW1uEpdpV2mYTxdYrhmg0SzVx3l8VZ0DViRuJqMDa9BhJiUsi494FIhu0TeEwxv
	m7tF58lNAEL3aND1nZtuJUFuOrQo5qHFrxP4UebHOx/Y4DNSTWxzcq9TRr7Ec5tWvpxv
	KHfuH817UoZOcB8tPgbrgRAr8R8qTw6U3oXwpPFIXe2vcuOtG0Jk7hcCffsGehwq8iBB
	rg8g==
X-Gm-Message-State: AA+aEWYPPREblnFfosCZFfJaW/IVzA9WO2fioaEXjvBE7dAkraf1bmJ3
	jHuSoXl+em4ERbyixispVylrsFtDO04AzA==
X-Google-Smtp-Source: AFSGD/XMBLxF25Sa/NbU7FYQx0ZlcA5SnRizroYlu1VNs2K859+KZ4W9sDmXw3vvEYgWlLDb+BCy4g==
X-Received: by 2002:adf:b3c3:: with SMTP id x3mr2742204wrd.294.1544796143828; 
	Fri, 14 Dec 2018 06:02:23 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	y13sm5859489wrw.85.2018.12.14.06.02.22
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 14 Dec 2018 06:02:23 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 14 Dec 2018 14:02:19 +0000
Message-Id: <20181214140219.1553-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181214140219.1553-1-richard.purdie@linuxfoundation.org>
References: <20181214140219.1553-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 3/3] utils: Add aarch64 support to ioprio_set
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
X-List-Received-Date: Fri, 14 Dec 2018 14:02:23 -0000
Content-Transfer-Encoding: 8bit

With aarch64 hosts coming into use, set the syscall number to
avoid ioprio warnings on that platform.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/utils.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index f687ee4127..9cb702dbb7 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1497,6 +1497,8 @@ def ioprio_set(who, cls, value):
       NR_ioprio_set = 251
     elif _unamearch[0] == "i" and _unamearch[2:3] == "86":
       NR_ioprio_set = 289
+    elif _unamearch == "aarch64":
+      NR_ioprio_set = 30
 
     if NR_ioprio_set:
         ioprio = value | (cls << IOPRIO_CLASS_SHIFT)
-- 
2.19.1


