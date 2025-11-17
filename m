Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8EECE8D6B
	for <webhook@archiver.kernel.org>; Mon, 17 Nov 2025 19:55:25 +0000 (UTC)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18649.1763409320029199482
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Nov 2025 11:55:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=UOJoLGA1;
 spf=pass (domain: gmail.com, ip: 209.85.219.50, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8804f1bd6a7so46797986d6.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 11:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763409319; x=1764014119; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h1RTT3GsC74X8BRpkcJARIdccJ9QEGVw3oiI4ydyVRc=;
        b=UOJoLGA1PeK6zzbTyDfIExDg4Zr283C6FK+j/bdIpiWIe1o7rvvrXSssaFo2D4Yy4U
         TU0xYE3CXlQO5I7LkMDCoBu5WptUQhIX5xa1AAmZfFcq7VxEg9Ypw7jC0dLenl+3S6ob
         +59A0ei4PKvY43jn4Rudzknzf6R3sXZivcWbMyrz1tPCiscblmE/by69WtEi+B1w7lrX
         Iv6hRQbDjc/X8knsAYg7gC1K2xke9BTJcWhvg2PMyTGiJ22470/ra6+MgtlK6uLLs+5c
         0f2gjdm4Ewdo5pEqvx3vd80bE53lBFgUI/7RWewdJMCD1PcAreSJ/xbxQ0/pESuFAPuZ
         fGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763409319; x=1764014119;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1RTT3GsC74X8BRpkcJARIdccJ9QEGVw3oiI4ydyVRc=;
        b=s+J18hvJnj3PZlA34uWbvYtoDK2ANalI8rtigBCz60iFVHawmg7XfSMQrJXlzn/M34
         emEnMjdVcBUaCblRUo54T0e7lNrveKNrHAUMb2CAjdcVXB/aPOfBeYT7ePa6Zcwd2xLk
         bGi3vK+eYfrCOiW29qYnmSUUjAGc+uu9nHD22EPCPoPXD0HUyn/r9H48Ch2tdPYmm3Dy
         GtgcIyzmQfu+arCQV8gQjydWZehWjQPd13erDmAeN0jWpGOQK9a42nJ1+u1cmuZXZq7A
         +n1YBHBQzrbw4IZA88NdNHz/MjhakboNoyNFzE0PHc2PyfzFkEcueMAGwk7upx0Qt2ir
         X1mQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwCt8e07idcoOquzT+xNgFIL/w/+BLpGuroY8BUYTHBn+t6LfJ6+it64qKKePV2U+cVKnsKsvZAFtm77Vr@lists.openembedded.org
X-Gm-Message-State: AOJu0YxSXTvQ3Bx9/ofXVeDPoqCX4XT9cmoG8yGQDTgBv/s1A40Fa6Zn
	IWRBtIVAgfZA/mBTUwv8bu9+E4gK7jsdpx1Y9DE3jCWZY1Qpekd3fEKfwf1mRaaBdr8j6pMWdd7
	rXnAPrZMf12nZ0inny2LZYpXBIC6os3A=
X-Gm-Gg: ASbGncvLILWJ0GT8CvSbrJd2UIy39zG+/7ukGYSfjxZgWx+3+4rjR4g63YS3+GPKg1S
	D04QpB2qeYsnfHDVBBhXfMWz0MAsg6KTXX35PDqeIhf6AdqMb/zFO3M29ALFXVpg9HujQsM81IH
	n/DwCN5+9OAO+mKvLfWNHzUWLbYPHR1JSMPLmpS3ND5cy1HTlreYv7YMLL54XCAWKjNAGuoWsOI
	M/NsYoj+f4eM44rwPYEoA9nt1Bh50OhrE5jbzJYaDGHl5preLmgUtoi9Ary3eM7hn+67KD92Zpw
	gSGiBhv2QA79tyEtKDfiSm3Tj3kgVQ==
X-Google-Smtp-Source: AGHT+IG48oJ4vuVvkOBFbXS42qSajuCYaZYXiUH0XeZEnltZTrq2VvEFeT4n2lKJbVz8qjKVvp2qMMgASThxgGdAhN8=
X-Received: by 2002:a05:6214:258b:b0:880:5867:45b4 with SMTP id
 6a1803df08f44-88292589037mr202484446d6.13.1763409318975; Mon, 17 Nov 2025
 11:55:18 -0800 (PST)
MIME-Version: 1.0
References: <20251117194840.2322115-1-JPEWhacker@gmail.com> <1878E35BD8113CE6.1265056@lists.openembedded.org>
In-Reply-To: <1878E35BD8113CE6.1265056@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 17 Nov 2025 20:55:07 +0100
X-Gm-Features: AWmQ_bkp0_1TCtrHVqzF_J9UwgtuZQTRIvpyznY8dPS6STYV2fi3Hs564Jm9pvg
Message-ID: <CANNYZj8OMHqFdUcgWnE2_XEJKoR8=+NBVKbRf51m=rnXTGOVgg@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH 1/2] bitbake-setup: Allow setup-dir-name to
 be specified in JSON
To: alex.kanavin@gmail.com
Cc: JPEWhacker@gmail.com, bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 19:55:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18440

On Mon, 17 Nov 2025 at 20:53, Alexander Kanavin via
lists.openembedded.org <alex.kanavin=gmail.com@lists.openembedded.org>
wrote:
> This (and the actual json tweaks) greatly increases the chances of
> directory names clashing, so there should be a check for existence,
> and a logic to deal with it (probably just fall back to the full
> style)?

Also see my proposal for a setting. There are pros and cons for either
approach, I just would like you to read and consider it.

Alex

