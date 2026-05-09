Return-Path: <bijak.dawid@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B89CD3447
	for <webhook@archiver.kernel.org>; Sat,  9 May 2026 10:44:02 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9796.1778323433239404105
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 09 May 2026 03:43:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Z0Nw3Ctm;
 spf=pass (domain: gmail.com, ip: 209.85.221.52, mailfrom: bijak.dawid@gmail.com)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-44c350a5b87so1708421f8f.3
        for <bitbake-devel@lists.openembedded.org>; Sat, 09 May 2026 03:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778323431; x=1778928231; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kUFCdRUkuEzjdflg14UBcBVEsLEgF2wLJXC56CSYySc=;
        b=Z0Nw3CtmpfasEg0o12djjG1j1tg8WKnWD8knbXqqT/k8OS7XR1uV5JkD48cpz3JOqC
         KPNyXOy2y4WqVTBIINUtESzjY9pk7/alRy8RMDDWYk1fqpU5kJb/Ilm45DZquZi7K44c
         VpsMRNrU+prkFDgu3l4KEeu9/rx4Q7YMdJI2ndIHsv8XJNTlcoBD7N0HEMgUfnfVUHRR
         N2w1qbRdKXAZu+065gAKFVwoBJkxxpD5ga5PaOYiwSIkDYUk44fyJ6zXr0ygkdvdqBZa
         RCvhD4oCciBnhwHjrj9TtEqnseIyFU3RNGlUCN6nF1y/upPqS9QMPzlCsoFUz4rAjSea
         4YBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778323431; x=1778928231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUFCdRUkuEzjdflg14UBcBVEsLEgF2wLJXC56CSYySc=;
        b=Z8ukZDDw+6ds1GNX6BhkCqviKPtg6fHyElxvUJrPQPaBdIOuT0p4KXk4zAVVkVr5FT
         1JXedIIEk4EJMGvI95MioLhufLIDULa+TKN7MHABircYPF2Fv1MkQUQALtu4GRlsoCbb
         4nmdV9WFP1xdZx9PGhfSjJYdXMiAjawEWjRAeXFhgW94AgFZ79TNW9m/Q9N0muCVpJXt
         23xzOPOb3N4U+mIMZQXaeZLWEn7s3pgqd8aCPZQ3VmaruZ7EoPLtUUGUONuTqdM01Em0
         v/91VhJ9PfQwgj/EuayJAUrOOttOo/YXN/qrY5C8bbQhHopN+CPW9baCz4I57zz7m/Yi
         KUrQ==
X-Gm-Message-State: AOJu0Yy2IxlsE9ls6R6FV8wb1QJTqL6VFmXXujW9bIaspR8R8nOJAx25
	Idw966Zh903VU4iA8BS9gGnb8e2uRGYdDz0+u0vNeZMLrNGyh3CiUzHtb9jCoTHDuo9mNg==
X-Gm-Gg: Acq92OHDlfJZ4TZ0idznMyXKtgqLZ+hTbv6iQ1zU3oJO1uL8aky4ZHnslYt0FyaoGlR
	9uWYEXHJ2viKHvEF1+B8dCuBbr7BK9loknojBQ0AkTS8v+mIX2ZaUCRgqdjOuJ1mIMqu+kDj+M1
	Uqkwbh3YXh8nVyGpcQtO241xlII/IgCPCrtBOU3fjSh43AS5fkC41wX5yd+FPjvqqgJG95FITiY
	cHu/LjtiBkEx0e55MRR1G6OijH/ZLS+sieaeL5Jqhx1v/FzP7cUtlIUwipl+5hxdW8CYqbqPrLq
	kgw1Riwzgd9K+zm6e+eiGsO2LoSB1QnQ5ZHqOnV/ZsvpCcj7WM/rRLq7UeUISbh+7g5T0WrfKhx
	1X+twbLMutEJITqq1s1tSDNiM3PWEZAjdqBE0RJbudlrqEqOJeOdaBcgezUKuyIRg/w1U9XDovW
	vwK8jwTuwXchT7npH++KCGFHOr2bQrvLupCn/NAnCEpRlk+AY2tWEV0kCGiGwqdWPuFAxojbPOP
	1zVyRaO2UKOfgMRoXsIFYYWhv9m8Xakfp61NJPhBU6cja6oVHjSbtF2CiAnUpdpGQ==
X-Received: by 2002:a05:600c:3548:b0:48a:7aad:4425 with SMTP id 5b1f17b1804b1-48e51e097fcmr245675045e9.3.1778323431136;
        Sat, 09 May 2026 03:43:51 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8070:d188:380:b100:f430:86bd:b50])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48e6d895781sm38837255e9.0.2026.05.09.03.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 03:43:50 -0700 (PDT)
From: Dawid Bijak <bijak.dawid@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	quentin.schulz@cherry.de,
	richard.purdie@linuxfoundation.org,
	Dawid Bijak <bijak.dawid@gmail.com>
Subject: [PATCH v3 0/3] doc: bitbake-user-manual-metadata: clarify inherit_defer documentation
Date: Sat,  9 May 2026 12:43:04 +0200
Message-ID: <20260509104307.26698-1-bijak.dawid@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 09 May 2026 10:44:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19484

v3 of a series addressing a few inaccuracies I came across while reading the inherit_defer documentation.

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

    add a warning explaining that using a anonymous python has no effect
    on the inherit_defer

3)
    Add a short explanation of how inherit_defer interacts with conditional overrides, and rename VARNAME to
    VARIABLE for consistency with the rest of documentation.

Changes since v2:
    - Link to v2: [2]
    - Picked up Quentin's Reviewed-by for patch 1 from [3]
    - Applied Quentin's suggestion from [4] and added Suggested-by:
      Quentin to patch 2
    - Renamed VARNAME to VARIABLE as suggested by Quentin in [5] in
      patch 3
    - Dropped patch 4 following NACK in [6]

Changes since v1:
  - Link to v1: [1]
  - Split single patch into four
  - Shorten the override example explanation
  - Drop the "footgun" example from the previous patch

[1] https://lore.kernel.org/all/20260424062327.820993-1-bijak.dawid@gmail.com/
[2] https://lore.kernel.org/all/20260501091418.76994-1-bijak.dawid@gmail.com/
[3] https://lore.kernel.org/all/aff89f3f-7bc6-4634-b834-1872d559c8e0@cherry.de/
[4] https://lore.kernel.org/all/fec735f6-f87d-4036-a013-384ed7c54701@cherry.de/
[5] https://lore.kernel.org/all/a3a8a5c5-81c3-4764-aba6-32c84ce55a7e@cherry.de/
[6] https://lore.kernel.org/all/7558cb67-4ee0-4cde-9d43-4ce2b8d1ef5f@cherry.de/

Greets,
Dawid

Dawid Bijak (3):
  doc: bitbake-user-manual-metadata: remove incorrect claim
  doc: bitbake-user-manual-metadata: remove invalid anonymous Python
    example
  doc: bitbake-user-manual-metadata: explain inherit_defer example

 .../bitbake-user-manual-metadata.rst          | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

-- 
2.48.1


