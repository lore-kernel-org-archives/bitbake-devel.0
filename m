Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871BDC43458
	for <webhook@archiver.kernel.org>; Tue,  7 Jul 2026 16:53:48 +0000 (UTC)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2564.1783443226750251532
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Jul 2026 09:53:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=f61WOwNL;
 spf=pass (domain: gmail.com, ip: 209.85.222.179, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92e65e18969so68162385a.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 07 Jul 2026 09:53:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783443226; cv=none;
        d=google.com; s=arc-20260327;
        b=l4b12ULUziCcJxK4B9zT0jrDSLrnCst5zdoh6nq58MPsbbFAn96VL0W+en6g/w8u3W
         SpczDu3RrZ79iz+FFaM2pif65nQtRJrpeJN6AXkngUU120Fs5Cp6DG6JlYb5K29JtSQ1
         uA7XwzJ+AB+VeGNiUu4G/nZn8+TaJDMUlh3MFq3wY55XISsctoHtxQY3+SPbt5NRWjba
         mFu2KMncbMw/D6MCajbIWpFid4B88dxaq2DvbLhVsQIOQeoJ+XpfpgeYwyyvqJzCUVPO
         mLuaxhRvwsVnZmpWbksy0durH1FOr5zV+MubboAtob4qxvEzNdIzt/wgtMBv4jdIOxAk
         tYRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=smHuo/2mSLc8pAej/fgfu1ukWJSiBLUJvfXXmiXpFQU=;
        fh=jtPWzpo31wky6UZf6hPox3o/x6kshybWwk1f+TaZiCY=;
        b=epifdACw0l5EhaNFB7pl7pi3SyucNUXtqvUpmVlpm/MZ8abpXihUQpMyVFA6CAoRys
         jHbrDQJDRaAZUWP3WcYk6l9PRZ0LwZS4LrpB/ep450L7OKL+iER7FwsG38ux80nJfOfJ
         Ewah6CrIeg4ttElmwUkJhd2gRA+9G5XT4TKtOAaYxDPfNPWGUNR6DgQWV6ZZYnuj4FaO
         bDzDsUlWPFJC14jIpACD12g2EC0C+JLKXY4iIn7SvJmuq+VG1GEKTKcpHzgSCCYjq6W5
         LxIXQ9lSqYM7YsI4OZ1D49e19QPkDkbtUuhllipiN+eKiy/rtwl87u6m0bmwpOdJmD8k
         +zGQ==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783443226; x=1784048026; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=smHuo/2mSLc8pAej/fgfu1ukWJSiBLUJvfXXmiXpFQU=;
        b=f61WOwNLIAEh+aNaybVchDtzfjJsqW2xzpNRfL+2SWSlaynXMFVPuIEvaErGgWx9Gz
         Q6GqnZqPDaS8CUozV63AljJK8q1TKhSVMhZR2mBGEHI7T+U1ORqnVw7SGNwQMTJIiXPg
         7GgFQG92D0p5yONrXuTI/PSgKzUwEZ9RibWKMcDKbS5hA9Tj1ScEiqwc3HYlp6WPHWe5
         hQa13VEa1x5FuTyJzm8z/fpAXVY0vLc3KtJGQ65MZHCBLyC0ba/OEO8e8XFYf7Ya24di
         iMMe4JgNy4YneinD5wucVisIoDiNzka1q1hIhWFXB1pSJUYhxeX+JYgCKqLX79sdqZqn
         2aJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783443226; x=1784048026;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smHuo/2mSLc8pAej/fgfu1ukWJSiBLUJvfXXmiXpFQU=;
        b=SK39IJRj11/Z+vPjmx8dTPal+j5C/JvVJier7vmc/7I/c+QZYKwR41lGi/eUV/dmvN
         yLAWB3fysBiuK87wkx38eEb3qExCtOs0af7m/NCgFd2impoRbXtm3GhthSzGxGfpjjLd
         ErLCr/hrO226/15IdI80jDgybN8G3pSGLrBwe2B/wyPtawV85x7sOUSk+BJx9oPq/Lix
         umIx1lQMryvmFCA+qTNqTkF6PPrDz0ux3AkjDmeP4/+goctwk23s161RWVtgezJYj8U0
         yQkuy1vFzIS6zkoRnBBFmukJKv+wszvCjOxsFomxuMcm2CjHB4d6oTH07ggim24epGIG
         gOUg==
X-Gm-Message-State: AOJu0Yz3GUxKdk8ZSUt4Rsw4lp+B9fnicUQJc0lDpeqmg7IC18Juxbqk
	87E0CnftM9UWVFPeyulX1YYlFgGwEaDc2m6iS0Bx2hp/7uqTsZDGjliLtTjBNxhHurkE02bAkP7
	oo75sxP4tfWDERT6XUHnp1ov6H+JiAkQ=
X-Gm-Gg: AfdE7ckOGBsuUqDE3qOhxYuOoJa63L7ToYtT+cSqLVtsj3Z4KZhnvQ1Yjl1K1HW+Rr2
	2oUwnlGcKbF591YmW8kJKETuYLePJvZBslj3D4nzcyJ8q2ecvuHRz4cWNfLiTzzMixqtnHPyE3b
	e8YQ2VkSHZAEXOOaqs7Eo8cAUeZBt7BKl++Kz1Qa5XF4HAXUkgP6oKvJp7PmJaL4SAMDUmrvhWg
	is3kb0lAzMf+/oPc9c3e0w7SGaH6OKl8y5q0oCR+Om6GXxmDgrTUlIJo+oJPLewGd2ZpM6UZhYo
	WBTdNzQ8Qjx2lrI3eLKAcMP+AJL7VtVhyCZt//UOng==
X-Received: by 2002:a05:620a:4503:b0:915:9931:3a3e with SMTP id
 af79cd13be357-92ec0c86769mr347971385a.27.1783443225327; Tue, 07 Jul 2026
 09:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260707163424.678708-1-fabien.lehoussel@smile.fr>
In-Reply-To: <20260707163424.678708-1-fabien.lehoussel@smile.fr>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 7 Jul 2026 18:53:34 +0200
X-Gm-Features: AVVi8CfzNXNiqB_0b2czRQpJB2viqIwxfTLZpQGFReK0IkzheVXjcdraPTsCtKw
Message-ID: <CANNYZj-kCKJ2h4QfWDq8e-cFX=vyTCi0ojR3kunmQcQayKySyA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: handle dict entries in oe-fragments
To: fabien.lehoussel@smile.fr
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Jul 2026 16:53:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19820

On Tue, 7 Jul 2026 at 18:34, Fabien Lehoussel via
lists.openembedded.org
<fabien.lehoussel=smile.fr@lists.openembedded.org> wrote:
>      fragments = bitbake_config.get("oe-fragments", []) + sorted(bitbake_config.get("oe-fragment-choices",{}).values())
> +    # oe-fragments entries can be strings or dicts with 'name'/'description' keys
> +    fragments = [f["name"] if isinstance(f, dict) else f for f in fragments]

This should only fix up oe-fragments, and then concatenate with the
choices. Doing the 'fixing' over the complete final list may work ok,
but it is odd logically, as it creates a point in the code flow where
that list contains inconsistent entries.

Alex

