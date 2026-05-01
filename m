Return-Path: <bijak.dawid@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0242FF885A
	for <webhook@archiver.kernel.org>; Fri,  1 May 2026 09:14:40 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10748.1777626877925910175
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 01 May 2026 02:14:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=dvWxAz+g;
 spf=pass (domain: gmail.com, ip: 209.85.128.45, mailfrom: bijak.dawid@gmail.com)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so11144645e9.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 01 May 2026 02:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777626876; x=1778231676; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=td9IdHMjP6jW0i0JxDWP2EwUzUYveDUjc6Y7wPLxDeQ=;
        b=dvWxAz+gpw3iMGaoTIOBlmWVx4i78p5bQEfAn9ZiNQC0YVWtiNHIbrBHbZLheK6oP7
         iioFGn/Crt/OOUKBEDHbaSdNtsKEOc3U00H80JXQK0zv9JeUanJdJ/Rg498ocsSIE32z
         M5n6iy64TwMlBSgWLMtUfpamIOGCNKsC+rV95TF/yaTJR3wtVUIKB8aIFaHm5Ciw6crN
         h37UA7R3AZl1wRoRXiuypyPwm6roVukK4aMAInU+CgMoUJEDoBXNCNZVy2gW+Ar6j4Ru
         9rJcV3oI3UgrDnASvzsrMVt2VZqeTteaCBvx3pux+KRPwWbqbrBmToeoncL+hMTsjPJ0
         zAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777626876; x=1778231676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=td9IdHMjP6jW0i0JxDWP2EwUzUYveDUjc6Y7wPLxDeQ=;
        b=SRjOxXWMXUuva/K5dHnse58/qct/x3SgkM6I5H06soGmx0qjHp3YSAjsJrjA9Jnlj3
         UxFHpQSynB8I5iI9iqwTJYkq8C7d2LFUQ6TQqtxqu5PvC74A6And2DYg81M5SSlcgJ4d
         y1WBbJBFQWVt3O5md18SG/NEZyrn+Etu0iGO0JnVX0kh322xAxkNb7gnrfXX6PXvgl2E
         uhV1X8b/f7N3q0JvQZQsZatnyRxdVGryPUISXVB78f2D5buF+62gFFyhk2TKsw8+LPQC
         UJ0AG0aBCa+9l5Xtngl3IGAbwvJjEC3NdjLuuGGzSgg15L4Z+Dc5o/Iln+AqTQLE7QKu
         oJAA==
X-Gm-Message-State: AOJu0YzQ5pPpM9SZR7Yx6qdIoCH2ENOwvVtOEndaNP7QllCFGlgBAugu
	LXv6bliQh3zF/clRWIyb9yir6YnoihLdxBjJsI603X/CKD5KNIhpFLBYNo09SLpB6eA=
X-Gm-Gg: AeBDiesSVnSmHWKZsI6+qAxo0JKfvLPxa2F6R8RUKjPBWINQNpX9EbbF56UXKMc79lq
	3CojX5WixM9FDTXrFKnRjvXH0NRDOoTcpwla6hR6KF1XGLIDMZBUTGfeFcbWDWVSm8vI6vDti8l
	HPmpph+n1PxIPMNakC+lA9JXuJ1RafynAjWds7/pFhsqe/OQpp/2PTbmoWcKEcAaktNDIiZtsKy
	WD2cTZYDT2c+DuuoCaa/2ZRrAVXMK04Is+Yg0vWPmjllpEh7Lf6nhG2+uNUS6Cn6mflpJPpYqbW
	MN1bilQSrSUD+iBCCB0vLNKQe2gKDOV1q1gId2+EcIhCaowxUuvwqtP9fMtwveedq/CmFMRD4DK
	1h3uiw1V3Z91+heVxuSPOup/eUjo7Ap5P8Zs84pgjp4BuhL+HPzqgV0R0QhVc/YBhxcKypYRkCO
	38+Uc5LVkNPTtPL79B2vwP+35oBPxu5O+SYigxCsjySjt4UwFE9o0wUumc1Oh1iKUwxpVfVw+Wx
	x5Y4iPWVIstUj9TlsjTHBu3sdzB39yNZ6oXjllE7vzO04lH4WA1I2ihEJrMIt8=
X-Received: by 2002:a05:600c:3e8e:b0:48a:5339:a46 with SMTP id 5b1f17b1804b1-48a86069e04mr83843865e9.9.1777626875858;
        Fri, 01 May 2026 02:14:35 -0700 (PDT)
Received: from thinkpad.fritz.box ([2a02:8070:d188:380:6a5d:7450:e8b3:758])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48a8fe953besm12097955e9.2.2026.05.01.02.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 02:14:35 -0700 (PDT)
From: Dawid Bijak <bijak.dawid@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	quentin.schulz@cherry.de,
	richard.purdie@linuxfoundation.org,
	Dawid Bijak <bijak.dawid@gmail.com>
Subject: [PATCH v2 0/4] doc: bitbake-user-manual-metadata: clarify inherit_defer documentation
Date: Fri,  1 May 2026 11:14:14 +0200
Message-ID: <20260501091418.76994-1-bijak.dawid@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 01 May 2026 09:14:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19425

This is v2 of [1].

The previous single patch has been split into 4 smaller, independently reviewable patches
as suggested by Quentin in [1].

The series addresses a few inaccuracies I came across while reading the inherit_defer documentation.

1)
    Drop the claim that "If VARNAME is going to be set, it needs to be set before the inherit_defer statement is parsed"
    which is wrong and defeats the purpose of inherit_defer.
    The whole point of deferred evaluation is that assignments made after the directive are taken into account.

2)
    Drop the anonymous Python example of assigning the class name from an anonymous Python function, which does not work:

    python () {
        if d.getVar('SOMETHING') == 'value':
            d.setVar('VARIABLE', 'someclass')
        else:
            d.setVar('VARIABLE', '')
    }
    inherit_defer ${VARIABLE}

    inherit_defer is resolved before anonymous Python functions run, so ${VARIABLE} always expands to empty
    and the inherit is a no-op.

3)
    Add a short explanation of how inherit_defer interacts with conditional overrides, and rename VARIABLE to
    VARNAME for consistency with the preceding code block.

4)
    Move the inline Python examples up into the inherit section. They work with both plain inherit
    and inherit_defer, so presenting them only under inherit_defer is misleading.

Changes since v1:
  - Split single patch into four
  - Shorten the override example explanation
  - Drop the "footgun" example from the previous patch

[1] https://lore.kernel.org/all/20260424062327.820993-1-bijak.dawid@gmail.com/

Greets,
Dawid

Dawid Bijak (4):
  doc: bitbake-user-manual-metadata: remove incorrect claim
  doc: bitbake-user-manual-metadata: remove invalid anonymous Python
    example
  doc: bitbake-user-manual-metadata: explain inherit_defer example
  doc: bitbake-user-manual-metadata: move inline python examples to
    inherit section

 .../bitbake-user-manual-metadata.rst          | 47 +++++++------------
 1 file changed, 18 insertions(+), 29 deletions(-)

-- 
2.48.1


