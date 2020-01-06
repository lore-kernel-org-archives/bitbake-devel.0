Return-Path: <akuster808@gmail.com>
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
	[209.85.215.175])
	by mail.openembedded.org (Postfix) with ESMTP id 3573F7FDE7
	for <bitbake-devel@openembedded.org>;
	Mon,  6 Jan 2020 16:27:06 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id b9so27082446pgk.12
	for <bitbake-devel@openembedded.org>;
	Mon, 06 Jan 2020 08:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=uqsU4iahV6ya7AsZvE73RbOcH+y0VC0dy9bHnjPg1qg=;
	b=KZrecoSPV8q2eEyK+lwQYggn/qw+Ojqr/Dl3M8C7ybN1AnFj35VZW9bAqT3zHLe+dn
	/QtrppeeB1X/N7RZHThhM1MzwwK7TNjHC1UFrdq9P1SwiSEliqYVNCjut3uhDU6hWkQf
	iTErp8ei5EgD8btPrf3OgAKeYVQjSHmit3yXVvIg2E7aWkkMLxDqb0gu+zz/0noL6ipk
	F6dQC/UcQNjfJYu2ZQ8VbohkiopYU9+xf0EJqlux6s/ysYU/wissryk97jAH+HioTtI3
	jzvaZJs7S1Z2jEEUYQFs+9BTqszDPJHFtSPq0shBbBbFL5jDShr/IwiFzjVwVMPpq21G
	uN8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=uqsU4iahV6ya7AsZvE73RbOcH+y0VC0dy9bHnjPg1qg=;
	b=cIG2JJp0iSXNEXh0j637XjroCm944K5GmdCqujaIkbC/FwIWz2q/Zn/pgYtrO7vWdM
	/L45OUTB/Lw/RLHLDuJuxHzQt48PIINLtGwfGUNQrAnHqivMwzDnpQ2IDsTNm7oihz0T
	OgI7+0o3ZTs0ltroxGoAXXN3kGtCLJyPlmfODhYxAgyOQb6vY/P5cGikpcy2YVMUl4V5
	gVkOCZAnpc8fn+5gsK8Z3FNDihFq3C9DKVBXhQvKdlvewZ6MJywAObJ608WQrJWDaG3n
	rtSLyz/6wYLNmaD2KfGuAjWsDUhVoYbp7/eURmfHSIDevqaRYynzwzi35CjLNqRRQs9J
	Q5TA==
X-Gm-Message-State: APjAAAWeRnSAELnNpi2Hf/DCdAkBWCKPfydJc6ScHthaCW2NoX1FEUbs
	qLJ5Gq7TQ7y49ZO/fgCoXL9zSu2N
X-Google-Smtp-Source: APXvYqwjBuJEU5Zao+bfm/5uP6pJ7rp1Aeyyd5ccPMGy2pdrcbESEhsOH9UXaAb3+jK2JbzszRLGIg==
X-Received: by 2002:a63:d543:: with SMTP id v3mr109029012pgi.285.1578328027112;
	Mon, 06 Jan 2020 08:27:07 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:6832:e19c:36b9:d5e])
	by smtp.gmail.com with ESMTPSA id
	d3sm24538668pjx.16.2020.01.06.08.27.06
	for <bitbake-devel@openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 06 Jan 2020 08:27:06 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@openembedded.org
Date: Mon,  6 Jan 2020 08:26:38 -0800
Message-Id: <53a3cba93401c902d1d214cafe0bc036e1b101e5.1578327474.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578327474.git.akuster808@gmail.com>
References: <cover.1578327474.git.akuster808@gmail.com>
Subject: [1.44 17/25] runqueue: Only call into the migrations function if migrations active
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
X-List-Received-Date: Mon, 06 Jan 2020 16:27:06 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

This doesn't save much time but does make the profile counts for the
function more accurate which is in itself useful.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit d446fa89d206fbc6d098215163c968ea5a8cf4a9)
---
 lib/bb/runqueue.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index b90ac875..729439ef 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1959,7 +1959,8 @@ class RunQueueExecute:
         """
 
         self.rq.read_workers()
-        self.process_possible_migrations()
+        if self.updated_taskhash_queue or self.pending_migrations:
+            self.process_possible_migrations()
 
         if not hasattr(self, "sorted_setscene_tids"):
             # Don't want to sort this set every execution
-- 
2.17.1


