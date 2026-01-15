Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802A1D4117D
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 12:24:53 +0000 (UTC)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.34462.1768479888138216065
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Jan 2026 04:24:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=jTxhd5Vw;
 spf=pass (domain: gmail.com, ip: 209.85.219.54, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-88ffcb14e11so9598006d6.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 04:24:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768479887; cv=none;
        d=google.com; s=arc-20240605;
        b=fZoT0+SHRuPMOToMGptXutnSJQ2I1RG2BgWtyjtkt0FTX1/S6Ea00AgcXSs3RjcHEZ
         ftiVaYxbFT3WF3+Ur46wRckgtTDGh9BTQPnq6qd7Eq7eP6daJAi/EDyLEQlss0w55qB/
         mjceL+8p4tuL1WfiP4u3m8RObVBr1xYmLbAvsoZynunVkClul7fey0uCyE7M5nWOptft
         MU6Ww9s5WMYvb3oy8zHX/j9PTKBEMSsJUQztEiHSbf3/Q9pN0pXC1DZ8hfkxZCaA6x1k
         drU/APnfOG8ZZUx86qjlbKYE6EpIrAYcDB30l4nx+PO4Ppxm4QGQrWeq0LonW7U/Firy
         zNPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RZ0nqXDDPyBAV/xoOXBXyuEt01QatdFtomNInGlliSo=;
        fh=wbmisDeLq9C3SaKEnDTh+Rq7O4ebM4MhTKwd2VfDPkg=;
        b=iT7h/vuUpo8C5y28Qj3Oej6qjfzV3A5R8g+FL56uewrvgbYduXjJA2nhwEglnc+kBf
         4u/7wjGtljsDMQhAMj6QMbwyOU6aJsUcGxszBWW8AYwV2T2kawVmnqCwr8pa8QoCUUp/
         zw1QlC9j0IyKip60oJW/Cww64L1LlvZAlIAVcuFYBSpvkrg4P+9Fz/gytGjM15iebp8O
         IDLZgV/dvBQeRyvgDU0eeW8CmDfuecJpxuvWlPNrn2K1N6tXQLCbtEu4F5mXDVOFVNR+
         teibKkrg2SIMjn1eQnYIteYt36A92Upwtis/5xF86oN8W624apvB1FUrvj6LdUU1O9uy
         aIqw==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768479887; x=1769084687; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RZ0nqXDDPyBAV/xoOXBXyuEt01QatdFtomNInGlliSo=;
        b=jTxhd5VwiHJKfbGF2RSiqY7Xpdjg7BeCXyAJx3F1fN1cgzFyc6QuQXdxAOxOk5FXH+
         kfRLANFNB7qC1UdOr18mrHgfyy70EZZfZVHjWHjoGHnvh4bBjNNtqTEYi8OPa463BylQ
         em9ciyFeTutGZGYy+SV2+JrUVRgroBTXg3XspQQ06uq0DqebIuyNgOmXxctUGOYNoYu6
         PC3O1p/RMRCYfRw4WPgyb/w9k8rU79ZBVd3n1cjL5vqvG4gb7Wh7Ed7Yvp6ZXDidLMxx
         Y6cUYNOyfKvAayO4C20/L2WrjnQz9sXyuogmpjmenhavLu6mQJUihXsp+GK79Mf7DjBh
         dLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768479887; x=1769084687;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZ0nqXDDPyBAV/xoOXBXyuEt01QatdFtomNInGlliSo=;
        b=sRaitC8t0BOVdonWgsiC3mtTLqegw3UgP93P5lhQSOeey28j7+LpCpQD9IdQ0YvHse
         dPZCf8CROEeCYSbyodI1PrMwYypuQDbQgKS6PEoZnt4XsivE3ZLXfhxmn/gZRRFSgkUU
         5Fz6NKGaf7WPpm73z98DMBhuzCJOXSZg3VJQ28IKYpkLPZP5egbuY3u5MegWw3ZPh3oM
         Jj1CpZzraP3qhpJZXrSdvBSPWPFBM3KMpiQphuuteYVQwcX5mDwbeCUjxsdCbX3hsDIo
         oNOyNuFHWt6L8cd0h+bYe0M6kRl640SJbeUFwEaNRHR9HI2oUS+EDDNo70nbTcBxwbsX
         sVgA==
X-Gm-Message-State: AOJu0Yyfr8IHfxLCi7Np7MCRTEdRXlKG6Z46FueczGWP3OHbYLGkDZyk
	pggl3exUkZazYY/QxlOtPU1ZN6f22qBM7i3/0IYBfRDh+vlqyWl6a5I/wiQ2fVaiBtZHCDQv8VR
	KHz74+ArmaWRYRpmJXvfxAwZHmJ1/TXo=
X-Gm-Gg: AY/fxX6ZrKVqwc+Vx1mAQE+9bfxK/Fe4THeMZgsWF4B/GmVEm39S0fCf/bMf2Epzu5F
	Y6QP2n9ZoI+2Wdd6Hmm/T6nYJoL6aAUh+uJcpqmEDxWnkZ2W2UfnGpHXcJBY3T/dMtFfum08HLc
	c4nMrhGdwfiLmxvsLhChVxazLNMhgV35byIIJfaPd1ARYkeHphZ4aukuGIDanUXoYivs3PkHLYL
	CS78/ECKNt8hrtKqF5vXnsR/2jbSdoOLmt/ILkTaEXe9Xtlb6kd0CkCAic+Z1vKkSSU3fsT
X-Received: by 2002:a05:6214:401:b0:890:6603:f258 with SMTP id
 6a1803df08f44-89274373da6mr80893176d6.12.1768479887195; Thu, 15 Jan 2026
 04:24:47 -0800 (PST)
MIME-Version: 1.0
References: <20260109132000.2372791-1-alex.kanavin@gmail.com>
 <20260109132000.2372791-2-alex.kanavin@gmail.com> <61242019-6995-4c52-b36d-4c427082ef6d@cherry.de>
In-Reply-To: <61242019-6995-4c52-b36d-4c427082ef6d@cherry.de>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 15 Jan 2026 13:24:36 +0100
X-Gm-Features: AZwV_Qgb5mNlms7lnBcD9rDDN606K4l9FOkDMUvTSMlro3tuCV87qmVxhCXz_lk
Message-ID: <CANNYZj-cAbsJzxgAXxKfh4ViffqL51UFpxjG77cdc8MJgFCEig@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 2/5] bitbake-setup: ensure paths with
 timestamps in them are unique
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 12:24:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18776

On Thu, 15 Jan 2026 at 13:03, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> Let's say you have two instances of bitbake-setup running at the same
> time and entering this function.

This patch is not fixing a race between parallel invocations. It fixes
two *consecutive* invocations of bitbake-setup that happen within the
same second. The commit message should be clearer, yes, but it's also
already merged.

Parallel invocations of bitbake-setup that handle the same setup would
step on each other in many different ways otherwise, and it's simply
not supported at all.

Alex

