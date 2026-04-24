Return-Path: <bijak.dawid@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4569FB44BC
	for <webhook@archiver.kernel.org>; Fri, 24 Apr 2026 06:26:48 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15157.1777012002380836164
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 23 Apr 2026 23:26:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Fa+ixRqJ;
 spf=pass (domain: gmail.com, ip: 209.85.221.49, mailfrom: bijak.dawid@gmail.com)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43fe3e22e33so4847124f8f.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 23 Apr 2026 23:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777012000; x=1777616800; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HdXKLmj5T4p38Jb4dmJTfHvYVEcWwUcS+/iRhQkkQKo=;
        b=Fa+ixRqJhnRxduATvbieUzmDjOTlVb0BwC1Gt/p0wcToQBxcY9MZz5p8HeRgT/SO00
         DBQK07hNCW5epdKtOj6WKnZFYHO7DGDPy+Ou89i6zRzkdYxk7YTqzN464uj0rzFqoTL8
         g68aA37HDHCs9joPRpTTAVY8O1Hs78gRlpnDmNKXXfstv+fo+s5p9ScpkxPjq/db5cRW
         ek/N4m5PLycPg8NCOd0pQ92izVAPp4c+Nga1xeSW4qjT9LDIAD4oNh+JBHQDOUNXaASd
         Vk22b/32GacaNGRUaQohOgCVyxvxBCM9D9sCBsE8NYnbXSipKloRtVdUqNoJ/yKrC5eB
         fUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777012000; x=1777616800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HdXKLmj5T4p38Jb4dmJTfHvYVEcWwUcS+/iRhQkkQKo=;
        b=Lk2ou8eMA+jg+JH5wIFIhKnUJsQZ3nbqGID4kPgMur9KSg90pTMPe+H1GWvjqc92uw
         4n2uR2+E0KN7ozmdKdAm+rEtajE4ZkXSsYRGC9+H/ORkPAGTxpJ6E8tsS24zdcbSCecr
         8JX5WGdqlAwwrxgDim9juMQJocuMnjHD7/jYXqHSEjqlQaXrkf/63Vu0T9soZHuhKRuL
         KZBfHQziI11JhOyq5TQe84bGwGmiCH0sfF82A4/xoUZxR4PEWnOgH/cs7iiZ/1kP8iDc
         sNbYh1zY+dUAd45KI4cJlm2bLQmUpOlm9OUhXR0bQuGQN0fI30Ut9515g+WCVJ57xJXX
         QmIA==
X-Gm-Message-State: AOJu0YxoeNxDiOncGwLIMce9BWEyM+kkoREqYhLKQv/SOZC2bLRQt0qT
	lp8doE4T0+5OpsiFqcKjbcoMI311skDKe+afA33UEX5ehoAY6lsK6ZDGsW08EIDt2hs=
X-Gm-Gg: AeBDiettdgpZzyc57O6xFBmmQ8772S3FQosWna/sXmpku6FNxAc6QQ7vSGbNTp6cbK0
	LglJP480KoLOJkfgI1hqN+wIOY7KT+y/tXp5iXKBCuTsiBctHSfutQdX/i+CpEA2Hcv7fLNVyLv
	QlLSUq/5hwdsisxhPXO7tYnsyx5Sdti0x/GAzxT4M6ITDE/UiU21yNBmTVU1GVjbUbzqEwQcP9P
	QQ5qWzPBiL5mMF6CW8nMNEKTftmavtVC4yGpOio4Q7NwaLzkUVxzQzWDRZg0TOkdUFeQYYJWq7P
	/c5Xqz4O5gwaVQrqCqlkQdm0Z4hRr85BTtkDNT7Xyg+BTrphScYC9rwIagfxBm7Ob4v+r/JD4/F
	zqKdsQfugWchAW4Z2mbzqjDO5GxhQ9sfXDHZvVNcWMhFfoxjVZnSicKSIctdjxvzblVTtesWyBM
	1z3Lg/xHLxRBeRTe0uuCjNPuYMalpJwpT6TAyQd+fvo4Ome8EreyAmUm2r5bXHAg+9gWgUAUh/7
	k1sJ/ZlGWNlLh/H322YvKhan6bqIKj7aYT2z7PmvtpxtEwqicZPYc3vrOZVJqg=
X-Received: by 2002:a05:6000:2dc6:b0:43f:dc54:9493 with SMTP id ffacd0b85a97d-43fe3ddcc21mr47228031f8f.21.1777012000373;
        Thu, 23 Apr 2026 23:26:40 -0700 (PDT)
Received: from thinkpad.fritz.box ([2a02:8070:d188:380:d82e:7b6b:5e9:c77b])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4412e36ff8bsm9353864f8f.26.2026.04.23.23.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 23:26:39 -0700 (PDT)
From: Dawid Bijak <bijak.dawid@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Dawid Bijak <bijak.dawid@gmail.com>
Subject: [PATCH 0/1] doc: bitbake-user-manual-metadata: clarify inherit_defer documentation
Date: Fri, 24 Apr 2026 08:26:30 +0200
Message-ID: <20260424062631.821571-1-bijak.dawid@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 Apr 2026 06:26:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19385

Hi,
I've been reading through the inherit_defer documentation, and granted my limited knowledge of bitbake,
I think the current documentation is incorrect or misleading in a few places:

1)
    The sentence "If VARNAME is going to be set, it needs to be set before the inherit_defer statement is parsed"
    seems plainly wrong and defeats the purpose of inherit_defer.
    As I understand it, the whole point of deferred evaluation is that assignments made after the directive are taken into account.

2)
    The examples using inline Python, e.g. inherit_defer ${@'classname' if condition else ''},
    are not specific to inherit_defer - they would work equally well with plain inherit.
    They probably belong in the inherit section.

3)
    The suggested technique of assigning the class name from an anonymous Python function does not appear to work:

    python () {
        if d.getVar('SOMETHING') == 'value':
            d.setVar('VARIABLE', 'someclass')
        else:
            d.setVar('VARIABLE', '')
    }
    inherit_defer ${VARIABLE}

    From my experiments, inherit_defer is resolved before anonymous Python functions run, so ${VARIABLE} always expands to empty
    and the inherit is a no-op.

    Is that the intended order and the documentation is wrong, or is this a bug in bitbake, or did I just get it wrong?

Anyway, just in case, the attached patch rewords the documentation to address points 1 and 2, and adds a note about point 3.
Happy to revise if I've misunderstood any of it.

Thanks,
Dawid

Dawid Bijak (1):
  doc: bitbake-user-manual-metadata: fix inherit_defer documentation

 .../bitbake-user-manual-metadata.rst          | 61 ++++++++++---------
 1 file changed, 32 insertions(+), 29 deletions(-)

-- 
2.48.1


