Return-Path: <bijak.dawid@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B55FB44B8
	for <webhook@archiver.kernel.org>; Fri, 24 Apr 2026 06:26:48 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15161.1777012004330620404
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 23 Apr 2026 23:26:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=KpNPCPp3;
 spf=pass (domain: gmail.com, ip: 209.85.128.54, mailfrom: bijak.dawid@gmail.com)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488b150559bso59191315e9.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 23 Apr 2026 23:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777012002; x=1777616802; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yZqqwzpzAcKmjv9ffq9pAwrAH0YXXJj00327dPzEUY=;
        b=KpNPCPp3WILfzIJBM+SKyRelJ9DhnAEyfBdu5ZuxG7dI6zelmdlkw29R/gPYTodvtF
         jCYgGw7YfxQCPxnq5d4jecxTHpeSznTIVdqK7a2FfSLSJSZDA+XDSwC4q7WZJCQc2i3X
         z1sn+BSpKbcwrOqBreW1OiYPUBFtu5oJzKpr+hlHk3yNtXJFNBIfJnTK4HWVzG7ZDuB4
         mG4BCgcDuNSduzt0RnIqnSdPP/mXv7sB6x/5hf/8brLpikf43OoNP7eVsYUflViIJn58
         FVzDPRPyBofCbdkT5ieG2zQhEh8iqIHGdWpo4EHRK7HQm1fi2SdKcg0O1rir/arCMAgn
         MJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777012002; x=1777616802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9yZqqwzpzAcKmjv9ffq9pAwrAH0YXXJj00327dPzEUY=;
        b=eBzjjAa/oDmWEdhP4hwpF3nAI5NgrEz85pcjrhLS9xbmjK7e4+RbE33atgBthWpzy+
         cFK5ujX5RDWHdpWdKuae90D2LKx074AhXumBIbqgLH9FeTfqJHdiZwA33cODQq5imQiC
         WeKhyS+mqhnZu+FVsniEMpanjHvo19XBfVOhOvxZl+QuJAS+dwWRAWtR+mUqTmj/UUAi
         uv1nQ1eY9C/K/mfH4PKQlde81tniUDozcdi7lQBMFe0gwT2sKiXyPmY9LPYZpFSbmgx0
         MQA1uUhrhVgxMJZeDlVE+1DE483hFvmxgab9YKzjcfPnUrAMgOdUeyvPBwQeXUMLR5Q7
         DcEA==
X-Gm-Message-State: AOJu0YzBxOWAlha14iUJiCbLo3Xf4G7lc+V3I4H/In/yxZwcfsA73joc
	elDOpYVmFftAVqtIeN5bm9xNkS6aKbMKvGh/3Fzeq/RWB+rOPqKQWC1pmtwqsGwsCRw=
X-Gm-Gg: AeBDies+lMPrWrmtWLCKLXm3o+a+lbgEQkXGz8eLzBd41kq7G7cxo3CNW6pIfjgDX/9
	d+eaduBnAsY3KNCrpJ/yTNEIu3TYCtIs64wCtnh2QLZ398/8M7ApTitU+rT/IerbEmNkqJBysPS
	QJbFroMZbIKuodZk+GMxZvcEaVrcLe00ioILYGu42Qvywu9NROMYg4ubomcr6JnwyhvGP7kUbSC
	xi0DD82IwcQXDzIgXj4jnRgEG+esSOHNIuhPEXpWHrgYJ6GoGim2Fp+Tvzni4ZM9Y1X/CKIq6vF
	3GsgZO9GtvE3TNyM2rTR+p+FUwysiRiN0Rz+0J4RqsuzjLYzJG4qL64Q1SrGB2iFCvWd/iZ+PTL
	caIOy8uIh/KCDJ2zFzg/oXp7fyB4uUFoadj9PrWtt18akCg19wTbxuY+hA4ep2qky77uWFLT8NV
	AgTffXWS5kvmIkW8WIZ/U0PuoDSvIU3vj+0lt9I+uuZxaxfP9hrNW0rQ0OaZPJIwVK551P2PzkT
	bbk00sbvKJ89rTJn5GRzwi9Haxk5w4rK7NkV0yNiFsf8Go4rlg8Gw9xti2lWnESIwOMZR/IQA==
X-Received: by 2002:a05:600c:1390:b0:483:709e:f238 with SMTP id 5b1f17b1804b1-488fb78ea6fmr436578055e9.29.1777012002251;
        Thu, 23 Apr 2026 23:26:42 -0700 (PDT)
Received: from thinkpad.fritz.box ([2a02:8070:d188:380:d82e:7b6b:5e9:c77b])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4412e36ff8bsm9353864f8f.26.2026.04.23.23.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 23:26:41 -0700 (PDT)
From: Dawid Bijak <bijak.dawid@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Dawid Bijak <bijak.dawid@gmail.com>
Subject: [PATCH 1/1] doc: bitbake-user-manual-metadata: fix inherit_defer documentation
Date: Fri, 24 Apr 2026 08:26:31 +0200
Message-ID: <20260424062631.821571-2-bijak.dawid@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260424062631.821571-1-bijak.dawid@gmail.com>
References: <20260424062631.821571-1-bijak.dawid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 Apr 2026 06:26:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19386

The documentation for inherit_defer contained the claim

"If VARNAME is going to be set, it needs to be set before the
inherit_defer statement is parsed"

which is incorrect and contradicts the purpose of inherit_defer.
The wrong claim is replaced with an example which demonstrates
the contrast between a plain defer statement and the inherit_defer
statement by using an override assignment placed after inherit_defer

Additionally the inline python expression examples have been
moved from the inherit_defer section up to the inherit section, since
they apply to both directives

Also add an anti-example showing that the previously documented
pattern of setting the inherited class name from an anonymous
Python function does not work with inherit_defer.

Signed-off-by: Dawid Bijak <bijak.dawid@gmail.com>
---
 .../bitbake-user-manual-metadata.rst          | 61 ++++++++++---------
 1 file changed, 32 insertions(+), 29 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 40cae6b05..38efe6b11 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -803,7 +803,17 @@ An advantage with the inherit directive as compared to both the
 :ref:`include <bitbake-user-manual/bitbake-user-manual-metadata:\`\`include\`\` directive>` and :ref:`require <bitbake-user-manual/bitbake-user-manual-metadata:\`\`require\`\` directive>`
 directives is that you can inherit class files conditionally. You can
 accomplish this by using a variable expression after the ``inherit``
-statement.
+statement, as in::
+
+   inherit ${@'classname' if condition else ''}
+
+Or::
+
+   inherit ${@bb.utils.contains('VARIABLE', 'something', 'classname', '', d)}
+
+In both cases, if the expression evaluates to an
+empty string, the statement does not trigger a syntax error because it
+becomes a no-op.
 
 For inheriting classes conditionally, using the :ref:`inherit_defer
 <ref-bitbake-user-manual-metadata-inherit-defer>` directive is advised as
@@ -827,39 +837,32 @@ the variable after the line is parsed will take effect. With the :ref:`inherit
 
 Here is an example::
 
-   inherit_defer ${VARNAME}
-
-If ``VARNAME`` is
-going to be set, it needs to be set before the ``inherit_defer`` statement is
-parsed. One way to achieve a conditional inherit in this case is to use
-overrides::
-
    VARIABLE = ""
-   VARIABLE:someoverride = "myclass"
-
-Another method is by using :ref:`anonymous Python
-<bitbake-user-manual/bitbake-user-manual-metadata:Anonymous Python Functions>`.
-Here is an example::
+   inherit_defer ${VARIABLE}
+   VARIABLE:someoverride = "someclass"
+
+:ref:`inherit_defer <ref-bitbake-user-manual-metadata-inherit-defer>`
+defers the evaluation of ``${VARIABLE}`` until the end of
+parsing. Assuming ``someoverride`` is in :term:`OVERRIDES`, ``${VARIABLE}``
+expands to ``someclass``, which is then inherited. Contrast this with a plain
+:ref:`inherit <ref-bitbake-user-manual-metadata-inherit>`, which would evaluate
+``${VARIABLE}`` immediately, before the ``VARIABLE:someoverride`` assignment
+is parsed. ``${VARIABLE}`` would expand to an empty string and the statement
+would become a no-op.
+
+Note that assigning the variable from an
+:ref:`anonymous Python function <bitbake-user-manual/bitbake-user-manual-metadata:Anonymous Python Functions>`
+does *not* work, because deferred inherits are resolved before anonymous
+Python functions run::
 
    python () {
-       if condition == value:
-           d.setVar('VARIABLE', 'myclass')
-       else:
-           d.setVar('VARIABLE', '')
+       if d.getVar('SOMETHING') == 'value':
+           d.setVar('VARIABLE', 'someotherclass')
    }
 
-Alternatively, you could use an inline Python expression in the
-following form::
-
-   inherit_defer ${@'classname' if condition else ''}
-
-Or::
-
-   inherit_defer ${@bb.utils.contains('VARIABLE', 'something', 'classname', '', d)}
-
-In all cases, if the expression evaluates to an
-empty string, the statement does not trigger a syntax error because it
-becomes a no-op.
+The conditional assignment of ``someotherclass`` has no effect on the
+``inherit_defer`` statement, which has already been resolved by the time
+the anonymous Python function runs.
 
 See also :term:`BB_DEFER_BBCLASSES` for automatically promoting classes
 ``inherit`` calls to ``inherit_defer``.
-- 
2.48.1


