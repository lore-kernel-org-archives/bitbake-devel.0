Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CC9E7E34E
	for <webhook@archiver.kernel.org>; Fri,  3 Apr 2026 08:46:22 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7472.1775205972966579984
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Apr 2026 01:46:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=MF91/lq7;
 spf=pass (domain: smile.fr, ip: 209.85.128.49, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-486b96760easo19451575e9.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 03 Apr 2026 01:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1775205971; x=1775810771; darn=lists.openembedded.org;
        h=message-id:to:subject:date:content-transfer-encoding:mime-version
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=x2ij0beFau+VVnOSxhglSrjx+pucKOljB0763HQsV7c=;
        b=MF91/lq7dxx6vObfoa4PUv7zxADZ8i/HuBAsYC8X0ETb6x6uE/xWHgqxY8iNUbD7T9
         cJiBIucRbycLW15BdNTE8r/7HyNhKPDFr1/HEQVX8fqEvZ89qBoXI85RoFZ4+pFVkIqx
         Po872BXiG95/UGXgqtoW+9G+pTAKBtMjAFVTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775205971; x=1775810771;
        h=message-id:to:subject:date:content-transfer-encoding:mime-version
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x2ij0beFau+VVnOSxhglSrjx+pucKOljB0763HQsV7c=;
        b=L5AOGSJtqIvtYYXh7GQ8wU5PsWbSZql0B+2qQe96UTxJpJqRZ4LGvUswiF7JJOuqEu
         1a0k15s9Bbq0u1tiBhjUvhZ1jm1optPdU+EEE7W5TBu08Sb9PMKysqLJs86EgukYQdp8
         OX7J1JeOh+MxUFnAzKb0cBKyj1UQaH7F5sTBlqJjLb0JFDihUOTA0VXk09GbCZggIwOC
         nuPy/KAclt8W9mF5/6TKPjxkrGOBqvmesFNKBoJnF/2sCI2DpQJJfomC8WHYh4PI9W4x
         d4vUL0/YHgfwkeu0pz0Yar8h+Kqfr5EYlc2tzZpJa1ubncgidLOiMs+bjJN2gHV4Pk1H
         bzOg==
X-Forwarded-Encrypted: i=1; AJvYcCXUlUw20ofJTj/FSIMEvzM7cXIgiQFQIMFh/9hn3c5iQQbKDwyWS+O4Jj3sdCgz07bqNboh4rGPzwh7pPap@lists.openembedded.org
X-Gm-Message-State: AOJu0YwCP6CSQyPrTc6jiH5sxWnAQXu0EkD094wYNCmLvx0vo7CchiIL
	mxsPyuztVrNBs6NNQOKWTvahl3mihndrKNXbB34mtfJTQLi6JuWlxbR8/GOwFszJ8SIMtcG6ktv
	XUEGmxHw=
X-Gm-Gg: ATEYQzxldq/mm37fPcZ6MBFrv0i07cC7kL8kp/nkrhBOJnfbQo2Ox1+VVxAUiYopwD2
	HS0WHRVtoJyH4rwonRYIQkKkoxLtX0ENr1Y3hrRmc4AIAfofuRlLRxauaNYIe6r+zDFBh3YQ2eP
	IYHSRqPtx4tFuRPBM5QskU3z3doUvNBdxYPvROmwpC+li9Rqz/9hMRf1Pyw+wjl1ip0Q73RZZCK
	ESSqTlJUydyAgBWhoE1OIls3N1IrC5ASFaCj5WkB2DFSlOS+TRw+AkDXbJszJ3GirUzTctuZhpN
	jk4Rx+l1OMu2zdrLKq+YAhLXrMPBkTb7FV3v8B+g826tsmjvkITvvvs3Uzj7ioSBtyZMUCBaNT1
	C18L8rYULb5r/5P9sKCcfjUKKR6g1YDIS+p1Z6NV04294GiYbJcpxrszJeiJ8NpFj5hOZ0FZdwr
	rAFqK1uSrC/OFHTh8+ADZYDHI/x7muvzxfftBIgOfXGlbLiOtW3ZVCVdcKg/x9S1BwjJhI+gb+F
	veAesZtEoUC8oCN
X-Received: by 2002:a05:600c:c166:b0:487:338:b4df with SMTP id 5b1f17b1804b1-4889978006amr36520995e9.15.1775205971207;
        Fri, 03 Apr 2026 01:46:11 -0700 (PDT)
Received: from localhost (2a01cb001331aa00dac7300510953f30.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:dac7:3005:1095:3f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488980db973sm26469655e9.3.2026.04.03.01.46.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2026 01:46:10 -0700 (PDT)
From: yoann.congal@smile.fr
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Apr 2026 10:46:10 +0200
Subject: End of whinlatter stable support
To: "Yocto ML" <yocto@lists.yoctoproject.org>, "OE-core ML"
 <openembedded-core@lists.openembedded.org>, "bitbake ML"
 <bitbake-devel@lists.openembedded.org>
Message-Id: <DHJDUJSPA7LG.3IKCP2QUJBMRL@smile.fr>
X-Mailer: aerc 0.20.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 Apr 2026 08:46:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19316

Hello everyone,

As you may have noticed, the end-of-life date of whinlatter (2.16 for
bitbake) is near.
The last release of whinlatter will be the 5.3.4 and will be built in
the week of the 20th of april 2026 for a release the week of the 6th of may=
.

If you have patches that you want to see merged in this last version,
please send them before the 10th (next week) so we get enough time for
review and testing.

Best regards,
--=20
Yoann Congal
Smile ECS

