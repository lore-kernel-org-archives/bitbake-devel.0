Return-Path: <pierre-loup.gosse@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943961125807
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 13:19:24 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21261.1773235163478859262
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 11 Mar 2026 06:19:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=x3gBAkXm;
 spf=pass (domain: smile.fr, ip: 209.85.128.44, mailfrom: pierre-loup.gosse@smile.fr)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-485409ab264so7331505e9.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 11 Mar 2026 06:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1773235162; x=1773839962; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lukyd655IDS5F6KN2Al+kcLnXF5wPjwzWIwnfoy9dP4=;
        b=x3gBAkXmpLJQyBp5azenok300pVoyf52bcKdk9FEE7orwPXmvokREKZPankPBUBRqb
         3O9ht06X+p8ZHnhwz591/lhVdeMoChPKfdg10u4R6ofJbHY6VFi0hW5MHnAhhLEpDkHo
         MVhK8XOKU9/alRR6W3JIoHE3u9I2bLXeLHAyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773235162; x=1773839962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lukyd655IDS5F6KN2Al+kcLnXF5wPjwzWIwnfoy9dP4=;
        b=WrE+gX52MbVm1pV+ECEloD/JDxTuxW7BkHi8uWs8Jt6/sl2jOH20MOVhRMJajcGOfQ
         swZBXbL2MmY2EFXt0Yl5xFlFXzx/Q7EfoyFYMTUPBNGrUUDrNlGLOXbfEUZBatHhRPK3
         6EHIhYlojogdyKUm4/y9KWChWhzo5T15FCBZsvRj8JyEq3/qEYdcKQ2vFvQ2kCls13wR
         32U5FKA3HtYIALNqT/dr7qStTx5NF+nl6WyDVYcq2PzMPZYV0wZy1NDyvQXv0XKhm8np
         2GpYoS2qFXL4X7D+hzADxkhFDF9r+7N8gINqKdF1yNhAAnhvoP7WW+B5IaxqYGECQhRe
         KKNw==
X-Gm-Message-State: AOJu0YyXEhPaCxXEYdx1+N85Xo0uHor76lO60A1XTfAzqba0taXEqxMa
	epwdoOsFzhqTUeZIu616Z2pv2SmwwvIbf1tsU9P1aXtU4a3wj7CDJpbVcjCB4lzHXwZCawHH7Qn
	1rq29
X-Gm-Gg: ATEYQzxuBhVZuDXqHDwS8ddgttuB03DhP+H3kS5CgFSW/vRV9glw7jr0dKjM7NK+7FD
	BWuX6bR4BSfJS2C+w2SXOplJyT2ddN5QU49LggSpdZEW9ia0KHQZEvOTkf+D6Ub9Ml57yBHLnfD
	ZDJ0uKxUvIn/s50lSMFFd2/6nWGfQj/L4Svv5+3Yzn5qc67iSH/l5v68zhblHwTVD/Avo5Abuae
	4KI9QZ6frtT5vVzG6CDcFDUUiZbZvNJ1D74eZL4yyzFuJA9RHssOuwg71+biWj67Vuf8mDbBqNN
	BQs+8hbo0CstdqviMUdvEZifM4l4zQX3IKThdJD5lQ0bJ3jek5XnrNghqm7FfmLooDjtajITEVL
	xVZrWThtU1ITCEjaePd+lKaUPfTLfY+TtBRo4+ve85iPes3ZI+8H0/fsexKmg4qwdyGNv+yA/JS
	VqINBWEAxNXohSM6Mg/qNCRhjZoWVoi0qfjXKM4Tx7DJaJXqgGNycNMj4OnwgFBk91GYSlvdKlU
	YMBw7cq52PmGKjVTcjRIVoxT/CITAutEFhxqu/n4nEfxuYHlRlZqVtNmP4GWV/F6V32S3Hrg0fI
	SbNERbVHyaoWlFOWoD0xWQ==
X-Received: by 2002:a05:600c:1d19:b0:477:9890:9ab8 with SMTP id 5b1f17b1804b1-4854b239dddmr39165545e9.3.1773235161846;
        Wed, 11 Mar 2026 06:19:21 -0700 (PDT)
Received: from FRSMI24-BLUE.example.com (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541aa73easm148243185e9.3.2026.03.11.06.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 06:19:21 -0700 (PDT)
From: pierre-loup.gosse@smile.fr
To: bitbake-devel@lists.openembedded.org
Cc: Pierre-Loup GOSSE <pierre-loup.gosse@smile.fr>
Subject: [PATCH 1/1] utils: add is_enabled function
Date: Wed, 11 Mar 2026 14:19:17 +0100
Message-Id: <20260311131917.2203296-1-pierre-loup.gosse@smile.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 11 Mar 2026 13:19:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19146

From: Pierre-Loup GOSSE <pierre-loup.gosse@smile.fr>

Check the boolean value of the variable and return the 'truevalue' or
the 'falsevalue'.

This simplify the following syntax:

  "${@ 'truevalue' if bb.utils.to_boolean(d.getVar('VARIABLE')) else 'falsevalue'}"

To:

  "${@bb.utils.is_enabled('VARIABLE', 'truevalue', 'falsevalue', d)}"

Signed-off-by: Pierre-Loup GOSSE <pierre-loup.gosse@smile.fr>
---
Note: Once merged, a patch with the new function will be submitted to the
documentation mailing list.
---
 lib/bb/utils.py | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index b2bda08cb..9937994db 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1272,6 +1272,37 @@ def to_boolean(string, default=None):
     else:
         raise ValueError("Invalid value for to_boolean: %s" % string)
 
+def is_enabled(variable, truevalue, falsevalue, d):
+    """
+    Check the boolean value of the variable.
+
+    Arguments:
+
+    -  ``variable``: the variable name. This will be fetched and expanded (using
+       d.getVar(variable)).
+    -  ``truevalue``: the value to return if the boolean value is True.
+    -  ``falsevalue``: the value to return if the boolean value is False.
+    -  ``d``: the data store.
+
+    Returns ``truevalue`` if the variable boolean value is True, ``falsevalue``
+    otherwise.
+    """
+
+    val = d.getVar(variable)
+    if not val:
+        return falsevalue
+
+    if isinstance(val, int):
+        return truevalue if val else falsevalue
+
+    normalized = val.lower()
+    if normalized in ("y", "yes", "1", "true"):
+        return truevalue
+    elif normalized in ("n", "no", "0", "false"):
+        return falsevalue
+    else:
+        raise ValueError("Invalid value for is_enabled: %s" % val)
+
 def contains(variable, checkvalues, truevalue, falsevalue, d):
     """Check if a variable contains all the values specified.
 
-- 
2.34.1


