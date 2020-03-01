Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by mail.openembedded.org (Postfix) with ESMTP id E63AF619E4
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  1 Mar 2020 10:58:47 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id x7so8858896wrr.0
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 01 Mar 2020 02:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=tzXc541PrPXsK56qqLBNiDjGU0aMLT0bzlIsyog9mU8=;
	b=d7rAoTj4Am1UX4F/3HcDvR5vE4rR4uKqktnw98x7OqhkamubyYMXvbfftlNuOVZ0Km
	lMV2bAEen5OV+DEFKGIiOTtLPW0Vh4zLRMHo3QcJ463YrVKK5P8KsWtJbBgIQ0ORWO01
	O6I6YKm9G0hsWOHGL4nD4cbIb50NIFkE0yAi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=tzXc541PrPXsK56qqLBNiDjGU0aMLT0bzlIsyog9mU8=;
	b=smZcSOzBhwDTys/QPFuBK8zwiOkUPPwDa0GyUuE/dewFHEtXqFkPZrXK1hZbv07UWu
	3T3oiOGqYhTlVdf7TnrQKH9Ckrw8/u5UwHQqim7cbane0NzXohsJtrnGPSoDVfQ410w8
	SGaRkma2/okbIRKmQf8xJTCDezGUjCl45puK1Kolh2Oon+HenqQAfdFAExRJhZaxYyF0
	vgwG1jnatElw4r3Lv5vuzqcqGKNp1gFnFuoOwTt2jmkq6qXWGZDnPdFm5fupnDC90Z3p
	UfGp+CNptIWPbYJluROtDKC6HPjv6cDtmJAUM0I/Erad1MZIrPqXTUMPaJ4osXtpmgTX
	EibQ==
X-Gm-Message-State: APjAAAXNIZWcnNvJfKo9sa1XEouqzTfs7ccBmj/8K6Du3yRNCMNJf6lf
	dqju4A69uaCranwt8fnKVrEZarjxWcA=
X-Google-Smtp-Source: APXvYqwnH3/7NSwdsax/nh1Nxxm1qRjO6qOCWHsr/RDDeBRYZCYwiKZKtCEXW4q7OxN6u7/xiLu8iA==
X-Received: by 2002:a5d:4ac8:: with SMTP id y8mr15856935wrs.272.1583060328210; 
	Sun, 01 Mar 2020 02:58:48 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	c4sm10123946wml.7.2020.03.01.02.58.47
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Sun, 01 Mar 2020 02:58:47 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Sun,  1 Mar 2020 10:58:46 +0000
Message-Id: <20200301105846.525957-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Subject: [PATCH] cooker: Reset unpon clientComplete
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
X-List-Received-Date: Sun, 01 Mar 2020 10:58:49 -0000
Content-Transfer-Encoding: 8bit

If for example a tinfoil connection edits the datastore, a subsequent
connection can be "corrupted" by those changes. By calling the cooker
reset function at exit, the behaviour becomes the same as a newly
setup server.

This avoids problems in tests when BB_SERVER_TIMEOUT is set as the
server is properly reset between connections.

[YOCTO #13812]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 2d937a413c..2a17c67373 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1665,6 +1665,7 @@ class BBCooker:
         self.command.reset()
         self.databuilder.reset()
         self.data = self.databuilder.data
+        self.reset()
 
 
 class CookerExit(bb.event.Event):
-- 
2.25.0


