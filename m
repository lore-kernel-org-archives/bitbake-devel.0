Return-Path: <ankur.tyagi85@gmail.com>
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
	[209.85.214.169])
	by mail.openembedded.org (Postfix) with ESMTP id 139DB7D3D1
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  4 Jul 2019 04:45:55 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id t7so2389082plr.11
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 03 Jul 2019 21:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=h1iZlo38RoDkjbdAIIMKJ7skbIm1hikcQgqSyUfPOU0=;
	b=Zac7JuoPJlFuqHE4nxMraLTg6vMhd6vinuPq/tzuoTee8S04J0r7XuLCxCeCri/KjW
	8G5hzGFSLMqfsnpjom1uDwpKc+dBREknlQUD15FUaXdb5mOghwTgzjJojb487+ybrPgJ
	SCaYaisojGI5FxDWNEN+/9ypb8gM60ebWOcBAjPzDfXb4R40eyAKc6atPysGNxQ7BuVT
	w0jZK6OAsq6QQaoe8FPxZGiXiROPRfBZhbTD12Cz2Rw30UF9wKzJXZ+hQDdEcOBiMcqA
	eODZnkLkHT5oha70L8Z7U+KgAQKcsNghwgqidv+EYwW4O6gvxDVhF97pK4rESgQdGhgL
	o6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=h1iZlo38RoDkjbdAIIMKJ7skbIm1hikcQgqSyUfPOU0=;
	b=dC6e8wIgTG7+D87TCiQ3mPyl4NbTXo/2HRIPrXysEA0o+YWZny+9NnJGpMllA8TdnF
	HVDfu3ysEBjBKWjNW4B89cobE1YptTQXCNPXIVbZDxgbQcaSVwm6z7rbdMjmB6EJYV1J
	8Djy2Sm9r4GAGIQ8X5IIF5X5QZeWPZktoh362FPFwQKv1JLzLchQVnpvUcMWHk3DJxpH
	AZo1Ce289I9SX1D8bk4tMEL0N4UEFIFuXbV4mQJlNgVg8Kc7DjCLHSW1nQsvk5dRLA34
	25diecash3u9MEUhfkT9C4ayd5SWFWa6XW8NxUAcWZ1rF2WnnGVgmFrr4m6biiMIIDZc
	h8ug==
X-Gm-Message-State: APjAAAXI1H+gv3OLtilDFozJQSYBZMPVS25/TozgB/Xd64HgBYdg/elU
	uHLvrtMnyMAoPUXJqW24HuOY7a/B
X-Google-Smtp-Source: APXvYqxgcLb3zxLw1vJwKPU0dGsEQMdEAqG5TTEeODHBhPxfIx+Eum4YUDwiUtkJQ7EaA1xAA2YrGg==
X-Received: by 2002:a17:902:9307:: with SMTP id
	bc7mr45455100plb.183.1562215556607; 
	Wed, 03 Jul 2019 21:45:56 -0700 (PDT)
Received: from ankur-Latitude-E6520.gallagher.local (mail.gallagher.co.nz.
	[203.167.229.98]) by smtp.gmail.com with ESMTPSA id
	f3sm4652532pfg.165.2019.07.03.21.45.54
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 03 Jul 2019 21:45:55 -0700 (PDT)
From: Ankur Tyagi <ankur.tyagi85@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  4 Jul 2019 16:46:03 +1200
Message-Id: <20190704044603.9943-1-ankur.tyagi85@gmail.com>
X-Mailer: git-send-email 2.17.1
Cc: Ankur Tyagi <ankur.tyagi85@gmail.com>
Subject: [bitbake-devel, 1.42, 1.40, v2] git.py: Handle space in git repo name for http/https protocol
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
X-List-Received-Date: Thu, 04 Jul 2019 04:45:56 -0000

Signed-off-by: Ankur Tyagi <ankur.tyagi85@gmail.com>
---
 lib/bb/fetch2/git.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 59a2ee8f..a8fcc2bf 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -156,6 +156,9 @@ class Git(FetchMethod):
         if not ud.proto in ('git', 'file', 'ssh', 'http', 'https', 'rsync'):
             raise bb.fetch2.ParameterError("Invalid protocol type", ud.url)
 
+        if ud.proto in ('http', 'https'):
+            ud.path = ud.path.replace(" ", "%20")
+
         ud.nocheckout = ud.parm.get("nocheckout","0") == "1"
 
         ud.rebaseable = ud.parm.get("rebaseable","0") == "1"
-- 
2.17.1


