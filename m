Return-Path: <bijak.dawid@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8A0CD4F3C
	for <webhook@archiver.kernel.org>; Sat, 16 May 2026 19:19:00 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11456.1778959134001750324
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 16 May 2026 12:18:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=cMpBU+Kj;
 spf=pass (domain: gmail.com, ip: 209.85.128.44, mailfrom: bijak.dawid@gmail.com)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48d102471a4so6363825e9.2
        for <bitbake-devel@lists.openembedded.org>; Sat, 16 May 2026 12:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778959132; x=1779563932; darn=lists.openembedded.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x3BMoDOBBsGpvUqICCaf8rBF/W+1wm8/6IiUDFfuENY=;
        b=cMpBU+KjJRMNmjOmiS+jxc3DAMVgwbNbKsQD/5NP4dL5CHH90LR8exVk3MGGGevXS9
         xHvcBJaT0iv8z86qNpUqCBbz5yWeSdCNWgbRv3Pzjgl4t1CXztiEO1cSPzhbBa2pVeNA
         y9D1W99pTalK/FvgbC22SvwVGiOJfvmyy6K/dgZVom1Q6wAXV3e1DDkSMT45dPOzFuzq
         ckuhx9GAaGFwOkSCo7tTwUpWBVvpbL8AbsHnjdc1IkIgdR5fy3Wmer6j+Crz8KpsG1fI
         mKYl72M4SfAPkLLftZScikgZ7zYT5R7C865jikE0ihmOLQZrBHfMchZFZy6EggoKR6Yk
         8RzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778959132; x=1779563932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x3BMoDOBBsGpvUqICCaf8rBF/W+1wm8/6IiUDFfuENY=;
        b=NtLCUGOAk5Yk+iWU7K9Og1L99jC8JykFpcbJMuJ7GF3xefmZ6P3ZD6djrKr2qZRBgd
         VZvbgkcasQqJLQG28GIHK0Xd7Q9Eg7PxKNDC3NiXU/Orzp7I9ht/jBHtUW+jLiZz79AY
         zryC3wMgb0FxiYwhJakI+67/Iob+XkIr6VjOwLtv8WE4hSo1iTEz4WlNhRKDpuDmNkp4
         sZji3vR/nqSW0cf8epQWuM6+uhvUDnyA8uYreq/wy6WWW9rBeOc3vHGn0Tv7Vk6Dju4k
         ukCKAnPxwbGB3I37HSqdU1QplV8e/iIqRScila3sIpuzJSH6e5ic0N9vKuAlwBEbvMPG
         XnkQ==
X-Gm-Message-State: AOJu0Yw8luhrI19wQ26CD3zYHXMgUqEOBi2PkPjuuD+QrxboRGn7cSRo
	Yn/Jkbe3gXcRR2FNdxcCDFfjv0Ijj6YwTG1A1uAKk7ykylvmgMie8NAYqbF8R1P+n2k=
X-Gm-Gg: Acq92OGZs2VD6Fpqhc4vEpBdcQBI86ODj0lXmf8dFLXI/m2AzwnMvAYDJFFPES7vuJY
	OnJu3XACZ+cyitiIrNwI5Y1Jo+2uLLFegPUYHhjXflJe/qii8+mAgiTTOdNH8c7FKEfUrfYitV6
	IIzrrwvHNeoO46tl6DfJFxVGT9P1JrFssWYfH/6McS/Zvy9ljWwXliSS9Bc90xbhCYrdhDoZJKO
	sY3D0LP6tf0K37ESSVUo0CxpZnykSxkAUYYIBkF3DndjoTUm7xDjFhmmuN6q39R5HfRad0oIamH
	JLcsHp1Salhv7DuwuFtkjDL2wWvhwQbGbkJ+9dmnNU77tWY02kehRI0mwuHXP830lkqpAmilSIB
	ODNnwxEYWQ1HE8ZVAenzg5YtYqa73DeslGk7lJ9ia4F0jKwggeilAoFG+i7Qvi2ue+jGqy/FBKb
	YMmkOsMJnIeiAT1Pf1D3iRuaPoO9KPeD5/RKsvysb03lOBO/py5qrSljyKAuV8Ngu9gyW3VcwC+
	Tbar28uDQ0dZCoExpybm0KHuJ8D1LCYz8tSIFea
X-Received: by 2002:a05:600c:a30a:b0:48e:62ec:f264 with SMTP id 5b1f17b1804b1-48fe61f29femr101121045e9.17.1778959131822;
        Sat, 16 May 2026 12:18:51 -0700 (PDT)
Received: from thinkpad ([2a02:8070:d188:380:5f4a:8ba5:a0d5:73db])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c88495sm144307215e9.4.2026.05.16.12.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 12:18:51 -0700 (PDT)
Date: Sat, 16 May 2026 21:18:49 +0200
From: Dawid Bijak <bijak.dawid@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, quentin.schulz@cherry.de, 
	richard.purdie@linuxfoundation.org, mathieu.dubois-briand@bootlin.com
Subject: Re: [PATCH v4] doc: bitbake-user-manual-metadata: document
 inherit_defer limitations
Message-ID: <vpgocbyuaxrhczw2veodifzfrgsbpvo2ch5p7uuadowrspqnko@clwjpomtgpup>
References: <20260516191137.11033-1-bijak.dawid@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260516191137.11033-1-bijak.dawid@gmail.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 16 May 2026 19:19:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19531

Hi, 
Sorry I forgot to include the cover letter in the original submission.

This is v4 of the series started in [1].

v3 incorporated Quentin's suggestions from [4] and [5]. However, v2 has
already been merged after I submitted the v3, so this version rebases
the remaining changes onto current master and reduces the series to
a single commit containing the remaining diff.

Changes since v3:
    - Rebased onto current master after v2 was merged following Matiehu's
      remark at [7]
    - Merged patches 2 and 3 from v3 into a single patch containing
      the remaining changes relative to current master.

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
[7] https://lore.kernel.org/all/DIFUR95B2LWG.3GMMOVGQ5SIVT@bootlin.com/

Greets,
Dawid

