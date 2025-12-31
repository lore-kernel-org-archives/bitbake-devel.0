Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E02EE57F5
	for <webhook@archiver.kernel.org>; Wed, 31 Dec 2025 09:12:10 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.82534.1767172325154862630
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 31 Dec 2025 01:12:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=fj/RJ/gf;
 spf=pass (domain: gmail.com, ip: 209.85.219.46, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-88888d80590so155163346d6.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 31 Dec 2025 01:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767172324; x=1767777124; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ahOEANdYkLnPyoY28SlCnpeVBWI+M/O2rA/QGL9uiwY=;
        b=fj/RJ/gfhMDXv9AhrZU2i3ZByiNRQ+B/4owq8PEVsoIZI9B/OEViJ87hI38GqkXdwu
         xtnl6RJcjldHtfLnzv6+Rcnhye/QTxMVyh/oX9KBaHJegehr44WTz3xucPIi0Ssgbj06
         t6YyioGeCn+GqEmHGGTpzoDPDQgfHcsFrKREPna3rIlvmJsYthDui3ZibUQ+ASJRvfa7
         xUwCAWuv96m5dJ0bqZDTah1MeML5X0TGWLhO3lLVfVuzLv0fCTXTl/ksY2iSgxUbHFis
         2LdiyZIdMfMC1oAfrLT+zEhBA4JyZl2URL8GtVRpN1A8eH+oY//m5nYiQ8sZvfD1Kb0a
         0jxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767172324; x=1767777124;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahOEANdYkLnPyoY28SlCnpeVBWI+M/O2rA/QGL9uiwY=;
        b=W8j046c5HZGbrgFbv8tbhP7TpJoNXX7qR453uGSw8n/VizpRHY0n7LjNjxPbywvGNH
         8h9jkiY4WXg0fwIzhPxVGQw+Yz2UBQ2f+BR0unDMpMjqQJvwDzc1roC7gy7Z/c4b8hlC
         JINoCvyrTinWDJN/g+QssGfDh98JK5WTV3NG818DPmduLllpdwbCUpfN8zxlP+Fdfhsc
         xV67y6ySUnJMb2v7e7SHN+gIM3EkVxxkzUbKpBBq2vdRbEewWio7wUYYdSC4fSgRGPsq
         8zgCMI9mcNLAX75+wcGI3ZSaYOdoBNWi8saeOENpuWSVOdZ+i/nRRogd7H7EdBHieJVZ
         VVgg==
X-Gm-Message-State: AOJu0YzBH4XOgYRNOpO2CQGpgwRkEfv/8LqOcClP6TxAIn0Ox5/IV8dp
	ZnCwft5VI/pobYFvf+UV80im5JVpwtb8f34oHpfAHcuWy+hKBpc/GUIjgWiwQ01+VGNL6FY/3zP
	povbgo2HSTEuNM1h2FGJ5BKW49IHuj8o=
X-Gm-Gg: AY/fxX7VWeQ+XZo6v+nIrid1XIeN3XnVpykO0/CaYl9KPK/cNyRKFjlkd4cK79wWwA3
	dU03sZd3AQYiI0yPwcsBNFLZE471PhKKSeI8x4LwmnsGJRNwjU3rNly7mRYCNDP7uD75OaQEnZb
	Nhb1MHlmuZswq8ENp73NlehFSNDUi9E3yzXuLeQSO1rSXj2yKKJbuRqGchYInloJAtEnrQ/SKl/
	ZG62dev7ICnXkERkADROppLUB/1DVuSxBfvSCyYYtaAS1zjLs65jgyqAoZ3BwagYr0vqckMlCyP
	/FY1ESEerLB9vJyyYRQzRhSUCb8a9g==
X-Google-Smtp-Source: AGHT+IHEwUOrUg5jHnKs1XEIkc1pNLpu7aZ3y9AijHIn8PpLG7d1dM4DfHJRIQ88SNS+GZs826d4JnbnYs0y/326694=
X-Received: by 2002:a05:6214:62a:b0:87d:622d:dd7b with SMTP id
 6a1803df08f44-88d851fc3a1mr642993736d6.1.1767172324161; Wed, 31 Dec 2025
 01:12:04 -0800 (PST)
MIME-Version: 1.0
References: <20251230153539.3940266-1-adrian.freihofer@siemens.com> <20251230153539.3940266-2-adrian.freihofer@siemens.com>
In-Reply-To: <20251230153539.3940266-2-adrian.freihofer@siemens.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 31 Dec 2025 10:11:52 +0100
X-Gm-Features: AQt7F2qaJVRdtKwP8p8BowS3_IH0tjHEiIXD_ejBc0LeHQ37PtiO7c7lK2ydAt4
Message-ID: <CANNYZj_RiybYM31_uwwYZx+kNz_QLs8Ud4yZ1DXfL9RGU1gP-g@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2 1/2] bitbake: add --skip-deps option to
 re-run tasks directly
To: adrian.freihofer@siemens.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 31 Dec 2025 09:12:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18665

On Tue, 30 Dec 2025 at 16:36, Adrian Freihofer via
lists.openembedded.org
<adrian.freihofer=siemens.com@lists.openembedded.org> wrote:
> This is aimed at development workflows (for example devtool ide-sdk)
> where an IDE or developer wants to re-run a single task (such as
> do_install) and then deploy or debug it on a target without rebuilding
> or executing unrelated dependent tasks.

The patch is horribly invasive, and I'm afraid the premise for it is
shaky, and should've been discussed here first.

Can you formulate the problem more specifically? What are those
unrelated dependent tasks? Why do we want to skip them? They are in
the dependency tree for a reason: so that configure/compile/install
can run without error. Even if compile is replaced with some kind of
IDE-specific re-implementation, it still needs those pieces.

Alex

