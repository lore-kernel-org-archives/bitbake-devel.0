Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
	[209.85.128.41])
	by mail.openembedded.org (Postfix) with ESMTP id C1AAD7BE3D
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Jan 2019 15:55:39 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id y185so6428313wmd.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 07 Jan 2019 07:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=7A4UTBLA5c9w8pn/8SwJcLUbR/qyEoPQY6TUE9Ds8EU=;
	b=dI6eVehX3uIl4Z1wCL95iqlxdQCXICcEeh838sH1zH6r5/xpqpaAt8AEJwu/uM6SDL
	3Rz+PwSTEjJRKoywrnjN8XPWAnozqKApIRtfAkCZO6aDssnWfEB54jjx1TQ9IMe8Jh0l
	bPqna/tv7cBE3MBSCLGM7IOtQBYH6BXxmMmos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=7A4UTBLA5c9w8pn/8SwJcLUbR/qyEoPQY6TUE9Ds8EU=;
	b=EQLrXRro+kEtbcbxNuKLLSu3rVKrDsg5JQSryga35auv/G49wjLMkYimCI8iY0lhZ7
	ODDtT1HEyqLZoM+XM5eecW3sBsdz4zmkb4bDf4e+yh+t11Zy0J29e6698d8jqQUzPch1
	Ba+gRcfdHLOzyf3KGd6hUjajA3ropL7kO3c36oHdrTX21vSNBnQ+asXWUv4qC6t+Nrw/
	qsNX7XYNmJMQHmzDnPcolhz/b/7xb9pDe4ZBuDOPW3rLLkgkJUyYE04rMq4Jvkv0daIw
	cOk/DcqO0zSMkUXCVCE85gQQgBX0tsYIweECGUc2W25jATC4ywtVkhMBorAJCPhMuCuz
	QcGg==
X-Gm-Message-State: AJcUukeYHaqcIZJlO10PcLu6K2P+p2gJ94PA2yjAdaPciB9p/MwouG3i
	H55vepol1yAfJxUHtdX+QgPHem2Qa+sK5g==
X-Google-Smtp-Source: ALg8bN7UWSbmB1ImeiDyAOqQ+HQ3n6s7Z2yzYEfuAizlocqWAUimjDzJd9MlFdOBLKN70gQaUTfqbA==
X-Received: by 2002:a1c:8acd:: with SMTP id m196mr9381598wmd.120.1546876540151;
	Mon, 07 Jan 2019 07:55:40 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	o9sm6400347wmh.3.2019.01.07.07.55.39
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 07 Jan 2019 07:55:39 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  7 Jan 2019 15:55:35 +0000
Message-Id: <20190107155536.6062-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190107155536.6062-1-richard.purdie@linuxfoundation.org>
References: <20190107155536.6062-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 3/4] cooker: Allow faster exitting from parser threads
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
X-List-Received-Date: Mon, 07 Jan 2019 15:55:40 -0000
Content-Transfer-Encoding: 8bit

We don't push "None" values onto the parser queue so currently idle parsing
threads loop every 0.25s and idle. They may as well exit out of their work
is done.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index d1d2868d6f..9b2a0920f9 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1943,9 +1943,6 @@ class Parser(multiprocessing.Process):
                 try:
                     job = self.jobs.get(timeout=0.25)
                 except queue.Empty:
-                    continue
-
-                if job is None:
                     break
                 result = self.parse(*job)
 
-- 
2.19.1


