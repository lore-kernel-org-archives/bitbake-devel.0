Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74004CA0FF0
	for <webhook@archiver.kernel.org>; Mon,  1 Sep 2025 13:58:50 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
 by mx.groups.io with SMTP id smtpd.web11.52238.1756735128625777418
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Sep 2025 06:58:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=nd8i70if;
 spf=pass (domain: gmail.com, ip: 209.85.218.49, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b02c719a117so154709466b.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Sep 2025 06:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756735127; x=1757339927; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxCq429xabFqBnHMzNrzLK2ruCvT4eXGuxMXF+pYFxw=;
        b=nd8i70ifOTLiPgP/WOGajzgNmLN38j9xG3JYLPNBLhflb43A4Twf7hAaGMDIpVg0Tl
         sEiAWolUq9UFDipagArWoRVEoXACCyf4U9C7oCxYZU5I8GKxjpsAfMMHez4iw/accIsT
         Gf2MYjMLXCi+x0FNgcRzTkP/9qhjaj3dNNVotqB6+PMd2zlTdVxj2XBq85BK5bX9eBqt
         4Yq3vXxOU/1910roLmUFq7b1eE6RL9YHy9RFzvie8y3O+hsh1S1uwgcB+ysGjsV1u1ZR
         wEd/QyarW4JMqO03fgctFxN0UOM4BqJiY6ODUON0Uz9A7qRe/mYPafx5BNYLGis+lmKv
         xjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756735127; x=1757339927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxCq429xabFqBnHMzNrzLK2ruCvT4eXGuxMXF+pYFxw=;
        b=tOkMTtXBnSUDa3ASSe7E3TtZbfLwp82lM2hb6WtJ3o0BHWfwExLdBvramTkC+IbU0O
         K+VXd3ynslwIV0j6hj0Mz1p4XN0Tra4uqpYmgWeD0pODiM5Wzz/9dL9O4XlJRDMH+kEY
         BaU0posPYOjWPmmrq/oXNnm9Se4X3jOcmU0a30OxJueJHrpaRx83MBNhnypxVjolKmGk
         dWAGlSxiIwe/Xu32hrI0dfwUa3xYnKXrqxRJ1Uq0mo+QvKFTGBrJYh9dVmstQ0lYuvwp
         9W9Uqn73yEJjpnDn2BSzN29vvhYGXbf/J4CCezb412F0+YFoiZNbXKqnvSplUQP6DdLS
         oxtw==
X-Gm-Message-State: AOJu0YwNPBW1Om8G2903qm4q2Gq8TVv9Egl9hG2EMgz3VOkID859OugR
	S/tx2MgpBZWk6yCsm4KrJJIeA/HSH7Wrm9Ux/VjVlFg5EJcJGogBTKGxJbbRvQ==
X-Gm-Gg: ASbGncv3/QmdzR+7EHttbfsEc4d8VmiXRRQECe6Qc5/zWXipx7KfyLaAQLzFgDIxBgd
	OZkrokjL+vq7LIh52MiG2e/BB+02hmTcp7tZobBvPHJDqWYdLBj1XyeTDTGnyhu1LHadOt/7vAs
	EM2bMP61gh0Q9olNKURZRNTj1Omko3P2z1KnYzw8TCAUDVakNJLvuNE69ZvfSb6kUj/IChZiLPl
	j+tq7GsaTBdnVqF/3CXIv3k12/BPyhBGjW0B6SqCK3UDlFA/J7hSbxQSkFPJ/9EfETc/HlWX4Tm
	Iiix7f4Lk9tjS7y652TagWTDEKT9uUai5OFZ2jott+zXzLLqt8M/pHqcHgyRu2AdyhCDlZPmOpt
	bTZ7zkMn3ybQlqN8Iq3YVP3XpB+BiCb8H+z6yHarMot9RWiy9tUvX3R2MH5Idg8YFGpZEZhcKsr
	+Llx35A8Y2IxZhjMAanU9cor3pgMbhbZgBAiHUo54mQGwIXdzreCXDxcHk3g==
X-Google-Smtp-Source: AGHT+IHOdVl4g5zw38pMj3H4nvzDaaLY+w8HDQc0AO4Cdn0IDKhdzLezUX3qrNWFm6gsPO3g4lzpAg==
X-Received: by 2002:a17:907:1c1e:b0:b04:26d8:97b7 with SMTP id a640c23a62f3a-b0426d89b05mr419712066b.17.1756735126852;
        Mon, 01 Sep 2025 06:58:46 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcc1c6fdsm873503166b.75.2025.09.01.06.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 06:58:46 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Gyorgy Sarvari <skandigraun@gmail.com>
Subject: [PATCH 6/6] bitbake-setup: make sure git user is always configured
Date: Mon,  1 Sep 2025 15:58:36 +0200
Message-Id: <20250901135836.2927686-6-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250901135836.2927686-1-alex.kanavin@gmail.com>
References: <20250901135836.2927686-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 01 Sep 2025 13:58:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17918

From: Gyorgy Sarvari <skandigraun@gmail.com>

In case a git username and email are not configured, then git errors
out when commiting the initial and later the changed configuration
of the setup. This can happen if bitbake-setup is running in a
container, or for example if the user just doesn't use git for
committing.

To avoid this failure, configure a dummy user to be used with
comitting the config changes.

Signed-off-by: Gyorgy Sarvari <skandigraun@gmail.com>
---
 bin/bitbake-setup | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 7382dc8d2..67188891f 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -392,6 +392,9 @@ def init_config(settings, args, d):
     os.makedirs(layerdir)
 
     bb.process.run("git -C {} init -b main".format(confdir))
+    # Make sure commiting doesn't fail if no default git user is configured on the machine
+    bb.process.run("git -C {} config user.name bitbake-setup".format(confdir))
+    bb.process.run("git -C {} config user.email bitbake-setup@not.set".format(confdir))
     bb.process.run("git -C {} commit --allow-empty -m 'Initial commit'".format(confdir))
 
     bb.event.register("bb.build.TaskProgress", handle_task_progress, data=d)
-- 
2.39.5


