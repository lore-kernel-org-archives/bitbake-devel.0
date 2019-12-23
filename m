Return-Path: <akuster808@gmail.com>
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
	[209.85.214.181])
	by mail.openembedded.org (Postfix) with ESMTP id 0017F7F849
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 Dec 2019 04:50:58 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id f20so6704655plj.5
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 22 Dec 2019 20:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=wu0+69VlzMMoDQiQ6G8Fy5Qpqml4zNIiZobeIZ3Qr9E=;
	b=K2SWwHD+p9TU2FDoWs/pK7AjkPIV5xPwQfnEJAoVw2jwQIVSmSFa+8CFOokKf3rO2b
	WtRkV+rtHrkMunvT5OY3/Izh9g6+2auKkqEj4NYU/fkA0miv5Op56ISdvz5ls88jzpst
	iiH0FtJS31I6TplRDC/bhIC2hayR0tnOJ7kRZBnhdJynEsmDvyZKeV9Nhhg/yLopgnBu
	rkL6cjdZ+6EVXH1cUB6zY90PV/jzcMtQPsWuoriw/48I0n0+KrELIotUS/yhD95rVvYh
	HuG7GKHnR+s2FepKCxZ4mx1hZchEkiIuRK73DqOSmv7nfETY1M7xhuQhhz634iBlcZVk
	FCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=wu0+69VlzMMoDQiQ6G8Fy5Qpqml4zNIiZobeIZ3Qr9E=;
	b=Tp5xplQ4Ldg2Htgq4qT5DVeV9e7ULqROR7yd/WN13T477R5K3XkceGk2VPZFCUML32
	NpncFnuOOC7WpADlfCNm2cFL4/QcXlCcsYqk7qX9EEMSzCg13t9wb6sB/XB7B+/0mF6Y
	ogwfDxI8wQa1MaTvmVXrkv+ksYGUciZj337OjFilp2xkd8/s4gUERG/7JQEO4Ge+mV7O
	7uzX82+JO4SaWyYLCeuv0Cp935vewtSggV5bFQ4ypNCA/3hqI2Y7KkmmjqEfH12fnWPJ
	riAsqmAcg4v3d8aAzOzz2IXDIt5caqIVieSDKLgQbRp3r0Ij7VzFYuoN56mTF0p9xn2R
	bhsg==
X-Gm-Message-State: APjAAAUfhfXOY0HGzGgcwUQtvFKec0H6UuYbMIRF3GiRWa96A9uEJEqJ
	3ohFQVr2D+Gq0asq5l6NzKl171B+d2I=
X-Google-Smtp-Source: APXvYqxthuuwAcLrJFJNdGKz/FdhLMMt3ehkYiTrD1nIO1dMBR3901Yod9Cw9musDlpylvLSZEYRTA==
X-Received: by 2002:a17:90a:8989:: with SMTP id
	v9mr32026875pjn.119.1577076660062; 
	Sun, 22 Dec 2019 20:51:00 -0800 (PST)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:a5c0:30f1:af1:c5e0:a746])
	by smtp.gmail.com with ESMTPSA id
	q11sm22276726pff.111.2019.12.22.20.50.59
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sun, 22 Dec 2019 20:50:59 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 22 Dec 2019 20:50:41 -0800
Message-Id: <53a3cba93401c902d1d214cafe0bc036e1b101e5.1577076251.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1577076251.git.akuster808@gmail.com>
References: <cover.1577076251.git.akuster808@gmail.com>
Subject: [1.44 17/18] runqueue: Only call into the migrations function if migrations active
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
X-List-Received-Date: Mon, 23 Dec 2019 04:50:59 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

This doesn't save much time but does make the profile counts for the
function more accurate which is in itself useful.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit d446fa89d206fbc6d098215163c968ea5a8cf4a9)
---
 lib/bb/runqueue.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index b90ac87..729439e 100644
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
2.7.4


