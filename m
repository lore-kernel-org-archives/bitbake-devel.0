Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664B9CCA476
	for <webhook@archiver.kernel.org>; Sat, 11 Oct 2025 17:00:34 +0000 (UTC)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
 by mx.groups.io with SMTP id smtpd.web11.3918.1760202030293792187
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 11 Oct 2025 10:00:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=EL6L9Tfc;
 spf=pass (domain: gmail.com, ip: 209.85.219.42, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-70ba7aa131fso38381876d6.2
        for <bitbake-devel@lists.openembedded.org>; Sat, 11 Oct 2025 10:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760202029; x=1760806829; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e5Pk4dRBn9AY69LE/1UnkJRYFJ7GOTq8k9lq6R0vLXI=;
        b=EL6L9TfcTG7PePPJJTu+zlLzdFlQANTVDiyPHGIltYCP5Ej73N5ENgSTaVGHjG466X
         YJ2Ka7firnMfnUB2S9b255T6GqUBIOWK533jQdtIYIYsmjYRY2JOukCZMNe7Qy1+2tw9
         yZHFBji5F6bl2jDSXCvaE5xrtC7Cj6Pkj1WLvcYtRhH0sXLEs53BCFXPLEnOugr/0Xx7
         fV4vxarJHwzJYpxXe5zS1Bff3GdrOZJ2WUKYmfjcY2bKk/xOqmQoNdcocRz7cyktptHs
         iD8IIr3SdJ1avOSGP7Uwqh6HmcV0xyVVkdGiOXvlc4T0DrOV+1Nco8S+5h4ZOmq42jaY
         x+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760202029; x=1760806829;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e5Pk4dRBn9AY69LE/1UnkJRYFJ7GOTq8k9lq6R0vLXI=;
        b=cP2415H9EOwVTdJtCrwFzvrr0g5l52pagpsnqynPdrYRT5ALVkgEDId8nLqi/LSWXD
         rEq2HMkGwgcP+pERjVRZuMaa2jYou6xR9LowaK0d3hDM6iSYf+R2/Tj5IUtKH2mm1tiu
         kNkDypCRCFj+fI/wY6hNgx0MHM+TTuWqUu8l3yujtielE+mD9yGMT7ovPxxiPBkAuhzy
         02r63fw1R6i0q12Ex7yaTg6KGkwI89+Q3e9o2K6Cqf/do3UdyIvhRVR+vcpVYcrfJtZA
         s6PKsMP7ul0XsuJJQyu/YCcUsFbfDZK3rc7SnKmQ7SJok0ySZawT2bQcLOV4lL+tl9I7
         h5QQ==
X-Gm-Message-State: AOJu0YwoB1+WMNxG/kGqokTyZASEceeo0gmeV1RGTaqgx/hAP+h9cD63
	uEt5MffGs72X/gtSr5UoThXvWHHXqFxHqr1nbg+g2DqV+SJAw/VfmBVEXtAYzOXGcOlChERdfz6
	G94PudugwGSLVqMUhTKcfX37/Pvrg9zg=
X-Gm-Gg: ASbGncsPjbnyjg/I2ajUw+C2nWHOa+ma+uKW1A1rrhgl2iEdJqhS3BfUHKiAea1kGZu
	fvkdVdLuthIjlZT7Z0YtH4Ak6/tSkqFtm6UvIPutUSpbfze5oKna2jTXDlHGT2N59Ibb9IpX7ti
	aINAkLAbVVuELoVYqlN1HGqhSpF5F7rKg0MeNIIbmRJctFmVMPCQ3vN0NvIJdsuaj/2aHeynm4D
	7rSScO1uzaVjOVNWMaFANVOcV7YCJAfslldcqWi37HLIxwlNNzCKrponOyPxx1jcnJZxJc1+W0U
	3JzlMJ5VrxIBBe1ZveTlVRo=
X-Google-Smtp-Source: AGHT+IFDqJ58XSRaWXuH7NqNLIyHwgef21qbUBSWGYgohDlU8wuqMTrlcMXqa+kCrIyfsjsaiKXNRSIAe7TLwnPBJjA=
X-Received: by 2002:ad4:5ca6:0:b0:798:acd7:2bb with SMTP id
 6a1803df08f44-87b2efdb179mr206369066d6.51.1760202029211; Sat, 11 Oct 2025
 10:00:29 -0700 (PDT)
MIME-Version: 1.0
References: <20251009163108.2571082-1-alex.kanavin@gmail.com> <45e4b824-e486-488c-b54a-25599d64759f@baylibre.com>
In-Reply-To: <45e4b824-e486-488c-b54a-25599d64759f@baylibre.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Sat, 11 Oct 2025 19:00:18 +0200
X-Gm-Features: AS18NWBSbrmol_hI1fbvI7vkhcpow5Xjc8TV0zqSA62fs0iMbAjA-bj4fot4g84
Message-ID: <CANNYZj9BcWus5Rpt_Mt7EOB-+j1f7GgURRbqGOEA66UrKgZQ=w@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: further rework the
 settings handling
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 11 Oct 2025 17:00:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18174

On Fri, 10 Oct 2025 at 18:55, Trevor Gamblin <tgamblin@baylibre.com> wrote:

> I think I've found a couple of minor issues in the bitbake-setup binary.

Thanks, I've corrected these locally, the patch will come later, as it
is indeed minor. There's also a proposal to improve the 'settings'
command by adding sub-commands (list/set/unset), and I tend to agree -
we shouldn't slavishly copy 'git config' because its UI is just
*awful*:

https://github.com/kanavin/bitbake/pull/17

It's enough that bitbake-setup mimics the hierarchy of where settings
come from, and has a --global option when setting them :)

Alex

