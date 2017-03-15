Return-Path: <armccurdy@gmail.com>
Received: from mail-pg0-f66.google.com (mail-pg0-f66.google.com [74.125.83.66])
	by mail.openembedded.org (Postfix) with ESMTP id 65B4377640
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Mar 2017 02:36:31 +0000 (UTC)
Received: by mail-pg0-f66.google.com with SMTP id m5so532676pgk.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Mar 2017 19:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=puCwFzB3GuDFs7EcRuzVfueZzYNhYrQ1yb5gQT/edKs=;
	b=tlmhbcuNoUkulrhpntstWbz8n7RLWCWrABfxrxZHga+q/v/WlbtOsBihgqKixKpKBy
	498wfDsiXNZmxUE9Gtdgyu8g6oYZmL0faLOHC4AD7Twr1DYSg2VKKwAefqYKrhwYAQg4
	SapzN018i8Rc+d3uZR81ciMcKseETdcG89qAzNpiS6Wp+jp/Z+65ysNf3miRTbBry1nB
	23mDun/+uUyuBdVfbFpJpzr9WcPzMw6Y1I1+Y5FjF8cX2+GK06MQEx5l0iVWvJBEJ38/
	XKK6oPZdM4am6wYv8tZzEU0AycVNRzuEJMpK0GRgOKCBba3g8X11FtyYIkOA5C43aX7r
	hK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=puCwFzB3GuDFs7EcRuzVfueZzYNhYrQ1yb5gQT/edKs=;
	b=GcgMPt7pI5y2Buy5QcFN5LsQNNniILke9bmZEzCCZQtHyuce6jabfh8SOumQeGZh5D
	9n2i+9Z+FYfzJGgSHTHK/Rh0T8By5gAYpsoB9cPfYPhHEkTUrgYMdbXem+GNWwHfbkxf
	OwPxiAMNbJJXF7pYhw5+CY7BjYqzrU3kICEVJ+jJPpPmgJCkhdVJSEETqDhFfQbtTiEL
	EdutO0HYnncvEvHZvkpIIDFxW+6onsbPfHO5eP+tPA9RjGaazZ4ICA33ypyKsVwqzzi6
	J7NG2cE7ey9PvQnSni15jEX5SoLxvTaplpnu7bFYRcnL/Kk3juTcN5SGTYRkjrUn7/71
	H81g==
X-Gm-Message-State: AFeK/H36O7Yn1TGkQP7P+yipPPXejDv9ZXvMKPUln7YgSkLZPSo7ZiS/j9wd323n7AH40g==
X-Received: by 10.84.232.131 with SMTP id i3mr1289057plk.172.1489545392633;
	Tue, 14 Mar 2017 19:36:32 -0700 (PDT)
Received: from e6520.guest-wifi.scl.liberty.com ([4.16.80.121])
	by smtp.gmail.com with ESMTPSA id q23sm481282pfg.63.2017.03.14.19.36.31
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 14 Mar 2017 19:36:31 -0700 (PDT)
From: Andre McCurdy <armccurdy@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 14 Mar 2017 19:36:26 -0700
Message-Id: <1489545386-21291-1-git-send-email-armccurdy@gmail.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH] runqueue: minor typo fix
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
X-List-Received-Date: Wed, 15 Mar 2017 02:36:33 -0000

Signed-off-by: Andre McCurdy <armccurdy@gmail.com>
---
 lib/bb/runqueue.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 38304d1..701ef1d 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -818,7 +818,7 @@ class RunQueueData:
                     delcount += 1
 
             if len(self.runtaskentries) == 0:
-                bb.msg.fatal("RunQueue", "No remaining tasks to run run for build target %s with runall %s" % (target, runall))
+                bb.msg.fatal("RunQueue", "No remaining tasks to run for build target %s with runall %s" % (target, runall))
 
         #
         # Step D - Sanity checks and computation
-- 
1.9.1


