Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC8ECD5BCE
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 11:36:47 +0000 (UTC)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21820.1763033800752267215
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Nov 2025 03:36:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=FLGSXMZK;
 spf=pass (domain: gmail.com, ip: 209.85.160.180, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4e4d9fc4316so5854501cf.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 13 Nov 2025 03:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763033800; x=1763638600; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+ik58OCQCsn4XthGTF7wnFrChI/KsceArfEJtlEm0TE=;
        b=FLGSXMZKNfk2WACe2bYJldHD32/xvr+3t6uXjmjZ7YZ8smf80TD28oveXr13ae59gL
         dEHh/GEzHhmJqRP/aVm/SQ0VK9cLdLoOAekPILDLm/tOiJwBISrhhRHD2abmVdcdKn3H
         2EJpwrhFAngjQBnT9Iry7wgdDdpQpkj3ymvsJiQYMVgboxVvZi0O4eF2LkDCMj/RSUa0
         STj3NWP5FokaE6zXOxSkZ4e8ARA7l8rz1Pli0P4J/xSdEu//8TpbL94SbNEwYfv+4bRa
         WgB6e4CQlGPow4IWe+NlXYovXA4vVHNudAz8uAShL6zLLwdld0eTTVZLa+vRDL7rPDlM
         GVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763033800; x=1763638600;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ik58OCQCsn4XthGTF7wnFrChI/KsceArfEJtlEm0TE=;
        b=wJUzAhRfUQe4XYcr+KLV03/t+RfrfShiVxj7RfESsvmagWNtqtCgK42CBiVXy7SCzU
         CkiJJ1ftfcthvY5B7YMA03pt7O7t1nXV/pyNk8U8KKPPiRTMLMfW4BrvLE4uH5OwAsTb
         hBOiWx2UyGuPuDgl7hciw+nYBEhFPoN//FW1wKnlJaDreHfX71BYDiwqaOM7MyPmXN3b
         ci1ol7srK0T+lbSQ40+4VvuUNdpjK5841O86RfKXhjZKkM1W9G22ygb/uaxfHa61wyn6
         +xZ2AFZ6Nj/akEqJm+ktFSUO1iOzRT7k1qPatToaEvZrIUI2fTLDGGaGOyddp90RySLj
         thxg==
X-Gm-Message-State: AOJu0YwupmZHWMayAKxM/jkhLYRQblLHlp0ZKUTfRxy30k7pfrsABYT9
	m8joxiqMAzXq+B/FLH3ay1WqXDkR2wKlguJlGJT6t5XvJ2DW8sbokx0UdxdKaBkRcLce2fYdNEO
	Uci/Hsv5PjKd/3/o5zEPcCe04lpm556Q=
X-Gm-Gg: ASbGncvqoPz+UL6jnE0uzhiPX1i0DEqdk+vQpmVDx8eLstCbzQn+oBQ6CPb1E6GZg5Q
	QEgeOlVsEWcNFWm44bCDkkkGwHwIuJyc4wGP3CSYJXF1x3FvoEhSbuq89sf42Q9ivGNocMd2GMs
	580xDAAODLKYeFkfHmHwOiygpEsMgW5GWPhdMd7kiaFCa5h7yxGlvJ396QHpDclLgKtBW3SqfWF
	AMzWcFskSIk2wDD1hc3icJOlColW/N/mW4Qik//qRJhJhHKJo8J2KTXeXS3pJ6T7Uk8GiIVOu2u
	FNLdTsjif4/TD9eEV0M=
X-Google-Smtp-Source: AGHT+IFTTAJyEB2PY6l/Lb1fuHjKe6FOm5iAb3IQkdY3BV9WUHr4+6uLdoS7rD3uOLzjelYtM3/BEM94VQS9IH9N94c=
X-Received: by 2002:a05:622a:1490:b0:4eb:9c63:e279 with SMTP id
 d75a77b69052e-4eddbc4dfe3mr97316951cf.16.1763033799713; Thu, 13 Nov 2025
 03:36:39 -0800 (PST)
MIME-Version: 1.0
References: <2acc6d2e53840e35ca2d99839e89d94e136dd304.camel@linuxfoundation.org>
In-Reply-To: <2acc6d2e53840e35ca2d99839e89d94e136dd304.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 13 Nov 2025 12:36:28 +0100
X-Gm-Features: AWmQ_bmD9hSV_2Ho88rlYa0cKfVoa4IcJOGT9wS8fv8elyfs41sLcaaHXnFRGSY
Message-ID: <CANNYZj8xA39G4n48H+qqeGSHG_q5y-PaLMbvsBEXVNmsj6OWPw@mail.gmail.com>
Subject: Re: bitbake-setup steps for release
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>, Paul Barker <paul@pbarker.dev>, 
	Ross Burton <ross.burton@arm.com>, reatmon <reatmon@ti.com>, 
	Robert Yang <liezhi.yang@windriver.com>, "antonin.godard" <antonin.godard@bootlin.com>, 
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, Joshua Watt <JPEWhacker@gmail.com>, 
	Adrian Freihofer <adrian.freihofer@siemens.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Nov 2025 11:36:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18370

On Thu, 13 Nov 2025 at 12:16, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:

> I'll let anyone add anything I've missed.

There are a couple important tweaks in
https://git.openembedded.org/bitbake-contrib/log/?h=mathieu/master-next
that were overlooked:

lib/bb/parse/ast.py: exit immediately when fragement is not found
bitbake-setup: make "path" optional

Alex

