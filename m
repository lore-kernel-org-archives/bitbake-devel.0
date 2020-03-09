Return-Path: <jpewhacker@gmail.com>
Received: from mail-il1-f193.google.com (mail-il1-f193.google.com
	[209.85.166.193])
	by mail.openembedded.org (Postfix) with ESMTP id 1C7F660C0E
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Mar 2020 16:33:59 +0000 (UTC)
Received: by mail-il1-f193.google.com with SMTP id j69so9234476ila.11
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Mar 2020 09:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=8O7lGO0LmVTJ+Ts7W9DTNCOdKbql7m/OYMhfsPWF8ng=;
	b=dTxAt8FgBbkhPyaQ13rTUJpmlqf/roRuxDdk7lnyNHWzT7OlzhWSPimb8c1+eU8Ojt
	MQCgm5UB/ZMSUbsZn2WacWF7q1wlOpl9tlcKZL5DR/EfFW3QPZKmrm+shpo8qdWZQw5+
	jsFtFsCtblbcPpQwpqsCzG2sNeyVdUL+0yvllTDEIGiW7iQPBUSpZuIww3KQKyJTISB6
	L767mIBEPIdkmeO2zfxdkimbO2u7EhQKzEdyxPuMO8eSGOrqM9uVWi8Ru+ThvwVQyUe/
	K2/ePuh+DYR9jLDTUpXm+ZI9WvemxDhdRME5L5n/6336k2dy+R7XrrFyOU6RbNJ6mmfN
	+Ndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=8O7lGO0LmVTJ+Ts7W9DTNCOdKbql7m/OYMhfsPWF8ng=;
	b=Ggum/cJQzzYieB4CpA8cHdQJ5V+FBracKVOHR9plq5/Bxp00TUD3p9DzGxoG8jkna2
	1GaqQwWVjESN3pu/UekshxUDcvqMpvofr0G6qlVXubTlMkGGTQfU28pk6lsNGLjpy4IQ
	JhcyVHwL+TBeBeB/WJPWKGkZh42PKyIuy/diS+/v6tumWJX5fWFg1+KPt9WtiGN6mq5p
	7mATg9ZsbZzf7tNcJ+9Lu1ygKdfaAG3dVymLtZdPqDkbi9kGr+IOMmI77yxfVKOrWjz3
	h1qJhwOJ1tQPBHE3wVP0z+sE47qTyVwRKl8DAxGMuSV9j88CEW0Ais6YQJUnOrn+/nbN
	Lomw==
X-Gm-Message-State: ANhLgQ3H02Pre0RJYPbHTkEdBvJrTwFkbU3xyTovdUzyufwvOyrWRBcR
	jjo711TSSE6kZ3uOfBYrQLGH5FUpb70=
X-Google-Smtp-Source: ADFU+vt7AXMZCExO6aPHpm+yVsQKvvHFk38JT7L2mQiPMtvG+Ed4UjD8xEZWQyNObrh9b9xrveR97g==
X-Received: by 2002:a92:9114:: with SMTP id t20mr16759978ild.258.1583771640832;
	Mon, 09 Mar 2020 09:34:00 -0700 (PDT)
Received: from OLA-8C37N23.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	q1sm15049593ile.71.2020.03.09.09.33.59
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 09 Mar 2020 09:34:00 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Mar 2020 11:33:42 -0500
Message-Id: <20200309163353.15362-5-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309163353.15362-1-JPEWhacker@gmail.com>
References: <20200309163353.15362-1-JPEWhacker@gmail.com>
Cc: docs@lists.yoctoproject.org
Subject: [PATCH 04/15] bitbake: lib/bb/msg.py: Add repr for BBLogFormatter
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
X-List-Received-Date: Mon, 09 Mar 2020 16:34:01 -0000

Adds a __repr__ function for BBLogFormatter. This allows it to get a
human readable string when printed using the logging_tree module

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/msg.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/bitbake/lib/bb/msg.py b/bitbake/lib/bb/msg.py
index ea6a9543f7..c70fd80806 100644
--- a/bitbake/lib/bb/msg.py
+++ b/bitbake/lib/bb/msg.py
@@ -98,6 +98,9 @@ class BBLogFormatter(logging.Formatter):
     def enable_color(self):
         self.color_enabled = True
 
+    def __repr__(self):
+        return "%s fmt='%s' color=%s" % (self.__class__.__name__, self._fmt, "True" if self.color_enabled else "False")
+
 class BBLogFilter(object):
     def __init__(self, handler, level, debug_domains):
         self.stdlevel = level
-- 
2.17.1


