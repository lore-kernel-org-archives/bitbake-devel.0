Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A976CAC597
	for <webhook@archiver.kernel.org>; Mon, 15 Sep 2025 13:52:02 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
 by mx.groups.io with SMTP id smtpd.web10.33992.1757944318245009565
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Sep 2025 06:51:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=D9Z/4t+V;
 spf=pass (domain: gmail.com, ip: 209.85.219.46, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-7814871b581so8635956d6.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 15 Sep 2025 06:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757944317; x=1758549117; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d6uz7msmlIe5XWAjavwWsaV4brkzPrzLMBkPwV/f8Yo=;
        b=D9Z/4t+VCU7azaEJgpaPwXvLzToHK9B1ktGYY2uq3LRbkztzHa5RSMpCFSlahSTq6l
         RmD7P+4vlcfGiG4ZESL7w/q6lcoAYYgswsBIJM23dsBUZPxHlxpS1a4LiZqquyY0O+qm
         ntS44bAviwFV+W5QY1YENNxutetoMXwTCEWwpGT9xfAaHYoVUIUMyc5oxV2kgZ9mjCww
         Rx1f3U45aqjBrZGLfsGuWLo5q3qOUa45jTEBf5Hheef1e+alSu1ul1kXYmtURXVbyhE6
         BJPwtU6/apICLZNYSMPgkbyLiPw6W9qHAa2AXVmMxOrQKiXug4WTdD6ubGoYA2e4TZXZ
         pLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757944317; x=1758549117;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d6uz7msmlIe5XWAjavwWsaV4brkzPrzLMBkPwV/f8Yo=;
        b=nlqS9snX5hEW5PXufO2pE4c/o1A0N3XjT7+8zb9scu2i119/loN1NbOVWtw6y+XEHn
         auctVRoPCkPdkG5ZPB/PxjxSd0cHj5eHG1HbOqrKtQ5BEUrO67i2plFMG1COo21tRyQl
         dsxy9tIzpfmCJZnhLO8gUtBVGmE9FvKuMJoF7Lg3Jz3M6IJGkpWTe6e/Hyeco0TIHiPb
         qx97LskoHRAf/mH+nrM/Jkptagb4oAGHWlPnCS7xsPjBrRMEgVjnPr0ptfwU3GqZJwk8
         wz2dVQ0lk8Yep74tyypwLmNCgLRoRGQ7PoADCQd4uMDoOLS5Ngraftf3H8yjsh8Oba7d
         eJeg==
X-Gm-Message-State: AOJu0YwTA3RrwjfpEed6JyQ8u76qbFwYxeZOytaHc33Rw8xYroi/9OxX
	g1FjEWUjOQkj2ZyLxul7xQPWX7q+VkcJF9McJ0q1/JVNUtoaftkza/qp6iDfkbVFEbaprbpjvUO
	3jhcUDASI3MfRIz41PZKst5ZxyMwotbo=
X-Gm-Gg: ASbGncvgwMdD4aJh08g7L7/ybGHxUHy0Xy+Bwm3klIym/DCf4AvpBHzm6j8pSun8f5q
	slceXsUZjcSIHJts32HbRgysaDw3QgexV0MStiIoNlu+tJGqjtub8gjw6FSwLvNWdE+rtmG8Zcd
	NQ7K7w59Kvxf5pfysly/5rUq1KaxWiBkTzkOEUnrMBXmL+UJNDBKCntYHukzSVtFVuwAvBgNXCH
	c5MXdUcSS8zf6nxKccpMXcWoMfC4nsigRNiX9KnlrRiitoRK/l2l9iTipAzvgAwdsRdFUJvvpwC
	pP4aEvn/AD4fmr0=
X-Google-Smtp-Source: AGHT+IEY7CUIwD8/44/0oOvJmLDsFuLA3fWtSS52cDcibkLCbWOZT1fuRh9hXnX3FBlkM5lgR3KzmkuphbqSasV2/D8=
X-Received: by 2002:a05:6214:d04:b0:77e:443f:dfab with SMTP id
 6a1803df08f44-77e443fe0e3mr52997966d6.32.1757944317073; Mon, 15 Sep 2025
 06:51:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250912204559.10360-1-reatmon@ti.com> <20250912204559.10360-2-reatmon@ti.com>
 <CANNYZj-f5oM19NRJebFgkZvFR1_EdUa1jyB915o_Ux3TqHM7XQ@mail.gmail.com> <f9acde26-b675-40d4-b2c6-bbd8b07d2778@ti.com>
In-Reply-To: <f9acde26-b675-40d4-b2c6-bbd8b07d2778@ti.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 15 Sep 2025 15:51:45 +0200
X-Gm-Features: AS18NWD5RAEDscPDBGxPOxsfgDHh32AfkQPUa2zktvGsos4ZJOoxSlCVbWIznTY
Message-ID: <CANNYZj-nrfaBsAPcT9xS4akjiG_1nechJHF1XxmDAuONgWZYLw@mail.gmail.com>
Subject: Re: [bitbake-devel] [bitbake][PATCH 2/3] bitbake-setup: Fix
 extracting config name
To: Ryan Eatmon <reatmon@ti.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Sep 2025 13:52:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18028

On Mon, 15 Sept 2025 at 13:50, Ryan Eatmon <reatmon@ti.com> wrote:

> > The files are explicitly expected to end with .conf.json. Otherwise
> > the tool could potentially pick up unrelated json files in registries.
> > There's probably a missing check for that condition somewhere?
>
> I'll update my code then to remove the .conf.json only then and send a v2.

Thanks, I've already fixed this locally. Files with . in them should work now.

 def get_config_name(config):
-    return os.path.basename(config).split('.')[0]
+    suffix = '.conf.json'
+    config_file = os.path.basename(config)
+    if config_file.endswith(suffix):
+        return config_file[:-len(suffix)]
+    else:
+        raise Exception("Config file {} does not end with
{}".format(config, suffix))


Alex

