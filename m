Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.30156.1793868567734756884
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Nov 2026 00:49:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google2 header.b=BYzBXCVw;
 spf=pass (domain: smile.fr, ip: 209.85.221.49, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48e3b22e971so805187f8f.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 05 Nov 2026 00:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google2; t=1793868566; x=1794473366; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cxtv+gTYL+eCCSvvqoRXavtzviRPqVWX9LIuCjvMN2I=;
        b=BYzBXCVwmGOxSR3Od220wpj9VSq9JR+UqQwz+3D3rTSljZNmIhH+4u8ttULQ0Cb4iN
         PQpwVpj9NGYOVZFo0CgAIXzYIFCb8pG7VnJMQ2ZfVQ315XAo4bQoJwkdeViQ/DsS4Vhb
         xH9qzAlpwdxp+sbELT/Sufpa62Q0KrfrX9QrnO9rfMjAok/OOqQqEoQIDyxtMzMQZqbE
         uqEPurUbys+MZ+uORxImgxWsdWiedIDwiMvBR4rQhaMRHmSB4fM0ccXrAXxqb8yLHTQk
         et35Oa6aNzefSpIp9GLksthtyV/Of/NQHsPWt2b8dCu8KdiBIoXhTqLuCp4fhB6fruK2
         ISdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793868566; x=1794473366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cxtv+gTYL+eCCSvvqoRXavtzviRPqVWX9LIuCjvMN2I=;
        b=xpzwTyf9pzszdMIrwGh/GO25t2+dXck47eEOQO1seF3ULjm3OV0Ozb30thJCEzLLpX
         Zd5brm9PTXZYSM/u1RtzuccmpnVPh0PIoVnZGul9kTGzL0vTNbwrGUmpGvcbQJBWOHte
         XuGx2W1leZh6RPXyx8mrAe9Q8cuYK9vSRNCnfIaiFGvez3kj088a6jm867BHduOraKib
         FRXXHFu8/BU8UDz1pY8kz7+HTfJru/u6HmVi4amWd1l02/pD+gcwf4KsYn5+BTVtaXIy
         M5abFDtOu5eaefenNvQHOiClvro+1px5S9kgYJ004gXKaz0EDwPMw+9ZsbljsZjzFkTa
         tLYw==
X-Gm-Message-State: APuU4Z+XKQ0xHb5f9qYlFiIhsIPHQWJrZekysupTUaEAuSk+ZlkyOcGX
	sQU73akefcgUZHHxgEImfRfaaMIvRH75h6z+hv5HqJ2kXiNTKFossEPw1H31tlWUOSUd/jMLVFy
	p+L2hbEA=
X-Gm-Gg: AYBFou0CsZFppD/oQsDm4foKYC9hGlb/5aXPrh2dLf8k9UUgVtpkN3GtUw34fRjUfFy
	rmMMQnpXrOKuRYnK/j43XkQnhHbLblH9Ykq0trzIpMvAwOr6qW/e7xNBOACJIfULx66Y44sq2ru
	puC4L9N+jp+ltE5qPKOF696TofTIxMM5EgtX52iRYbA/GAe6Hc7z+cJ4yqjmLDei9uDR5065AZ7
	AVuG2eJAZQE16vQ1A1zjn71EdR5FX2aInsLGn8UKGRF2s6x6L6krU04DH47EtSaB/qTZaSNyxzd
	z7CuJ82Nwi4q+GoJsLlOf6ieEJssp7o1UiLinwPaOHNVUDGLjXwAtQnWduYwsmGo70WLBxjU6xD
	kaaOd0ZvWH/gS82p5dA+N+I3lgbpolEJG5SkTHfbcg3GXM0NSgDjtrlCOBoJFLxIW2Jm1+CBt1R
	EYBtXGJftx9R7DZnnbyB/mGdihXrwoRLwaEwP9C42VmWeWczXKqggm+lmROBteoibgrKbt8cTkL
	rRNshD1W3YGrIKLuxGecy3g3yw5GRHgnHMZYmQLF7zirvbZ68mXZ6B7C5YvJDEg+/AhGzLWNLEj
	IEUtWpwoVq0SR4XX2G6aZ/aBu41zLdrythiuTxo0YGym2eHHsbxpIyjf9bU6CN54XA+51vdgqEF
	Xm4Xpnm9pcgg04gR/f9y9H3EYLDeT
X-Received: by 2002:a05:6000:481e:b0:490:2d81:ccbb with SMTP id ffacd0b85a97d-4902d81cd6cmr6333955f8f.52.1793868565915;
        Thu, 05 Nov 2026 00:49:25 -0800 (PST)
Return-Path: <yoann.congal@smile.fr>
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fedc09675sm8631012f8f.55.2026.11.05.00.49.25
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 00:49:25 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][blacksail][2.20][PATCH 0/1] Patch review
Date: Thu,  5 Nov 2026 09:49:22 +0100
Message-ID: <cover.1793868515.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Thu, 05 Nov 2026 08:49:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20395
Content-Type: text/plain; charset="utf-8"

Please review this set of changes for blacksail and have comments back by
end of day Monday, November 9.

Passed a-full on autobuilder:
https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/5060

The following changes since commit 634f8dede6b9d71b5a6691499fd05a8678b46eae:

   bitbake: Bump to version 2.20.0 (2026-09-29 14:04:37 +0100)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.20-review
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.20-review

for you to fetch changes up to 7f7ae8cd58993a389adbd130b07ea5de8415d2f9:

  server/process: Fix lock owner prefix check during shutdown (2026-11-04 22:23:28 +0100)

----------------------------------------------------------------

Reda Maher (1):
  server/process: Fix lock owner prefix check during shutdown

 bin/bitbake-selftest     |  1 +
 lib/bb/server/process.py |  2 +-
 lib/bb/tests/server.py   | 57 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100644 lib/bb/tests/server.py

