Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99A8CE8D76
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 19:38:06 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6820.1763149082968233429
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Nov 2025 11:38:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=NqmzBxeN;
 spf=pass (domain: gmail.com, ip: 209.85.219.46, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8823d5127daso28233906d6.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 11:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763149082; x=1763753882; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ylcrtZHUcDlniPKUvb7FgqRcI2w4SO5/SBoBzf/qFvk=;
        b=NqmzBxeNjHQkOFPdZ+1mTVz3Gqeonbfh/tuw4Iw5Gq9XKLxDwLOlS6GZRCnN1umvzf
         Dw6dAZ8okw2/FXmtdI+MvlVsp9Hgsvr2AsCVQM9XHHkv5WZ3VGOzNKZaALaoXomKQ/Uc
         nvox8g8NDwMRK5tyA70P9WzeuJlJUkNLF/q5B9GyWbQMPAdCA2Swy52m5sNxGVcRT61N
         sJMohmqbJVnqO6tP99JXKKEPFGzsxBoMxhVr02SigVN/F3M5jQaSifyV/e+4o+yI+SCV
         8ODlrZspg7eUfVlCUfVK/vrS8lFR/zWVxssptxJY0ljx7KyNuhj7M7aKGVKefLCiLT7O
         P+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763149082; x=1763753882;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylcrtZHUcDlniPKUvb7FgqRcI2w4SO5/SBoBzf/qFvk=;
        b=iIfS0scBg+1XpgJVWPSXxUu+p3w1/RjrWnIqk1hj2DMuplmi2Q+T7TMWm8HCea7FKP
         QFL6eitxCtIAH9qBoyWhCby2tUu/6CfreQfNMXYr1HmxAOSE3K9Hpj3lUVM2NhQWI1JP
         KDRhCtIqX34GaO10Bje4RIcY/qPHBC2OJgiWsxN9PwVOioPHJN7TPw71ylqW17s1/JF5
         Op5wpK59L0VZlQJZWD+ClCvrBYe4StDjpU09p/o0JHsr+2E3grTdxdo1NYfMbMLNWZr4
         Tgt8PpznC+m/op3vVsyAYerd57o/BzDDGVcBJcmLqwr/uAQ8l1QmYHVg5DdIxYRrqTZ2
         PGAw==
X-Forwarded-Encrypted: i=1; AJvYcCXUwhiw/8w7DJFS4tGV/vEWdyM1pCd7crVke0duou5W4p7nPdzmwVihPILyrH8nMw+3lg2E+x5wmm27xV0p@lists.openembedded.org
X-Gm-Message-State: AOJu0YwYf3evOw2CifWlIWe+0XtI0LpTAjF527lSRR5I4q7N3g6gYIcW
	gybsAYSB2b5jlwQcM6SbDgnSbPufkikVpvoJx0SVkKj8HVQ2mnPKpV3sGntYhkjrMd9tN+yD5l9
	RBMKkP4K3c4R94QFiKeljFShSwVoIxOs=
X-Gm-Gg: ASbGnctVuJ5QnIsWGRlKGt+nAt6ri4aUW/ZD5i/oh6dgEKtjRVz4rYhzdIt0MxcPn8V
	GPviKJTm2EHYCYPp2s8jMLF6+V0P2NbNNayATWFKt9WbIAKmf+gORFoosXdwadDBQ6+HxKPhfN2
	kIEkVBjN3yq3cT+SnCMNFyqhb5LjN/Bh+RyC1Gc/XeWE4q+zUqW1oV7IScFYrZmEvY4tuVsnOA6
	AI4orUnWUyfCCZpusDZ5UHyY+Zi3zgko5fHWKJzexB0bDRxhfIrYpKn7Fdj5/3+1WFkJeR/Rbsl
	uChe
X-Google-Smtp-Source: AGHT+IGlp/wVR8BKYzkVJoBPN5i7f4sAE0YXh8mTpIWYqoVxeLctXa2kUe6KspJcJ+ibMNqnDrx6YiGN2EwE5EYPMB8=
X-Received: by 2002:a05:6214:21ed:b0:87d:e32:81c4 with SMTP id
 6a1803df08f44-882926ac72cmr57380306d6.48.1763149081909; Fri, 14 Nov 2025
 11:38:01 -0800 (PST)
MIME-Version: 1.0
References: <20251114-bitbake-setup-conf-updates-v1-0-990583d8251b@bootlin.com>
 <20251114-bitbake-setup-conf-updates-v1-1-990583d8251b@bootlin.com> <1877F5CC2B8BC1DC.1114802@lists.openembedded.org>
In-Reply-To: <1877F5CC2B8BC1DC.1114802@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 14 Nov 2025 20:37:50 +0100
X-Gm-Features: AWmQ_bmSMJj0L5Hka6cP_wYlfC92vu40o0qsZ2fcasSA9MABHPgQM8EWS4QbW24
Message-ID: <CANNYZj9iwjsr=ZEg6=k15_gkDdfHogdNwcuif6-BqfJHmEuHPw@mail.gmail.com>
Subject: Re: [bitbake-devel] [docs] [PATCH 1/2] bitbake-setup: update: add a
 --update-bb-conf option
To: alex.kanavin@gmail.com
Cc: antonin.godard@bootlin.com, bitbake-devel@lists.openembedded.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, docs@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 19:38:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18413

On Fri, 14 Nov 2025 at 20:20, Alexander Kanavin via
lists.openembedded.org <alex.kanavin=gmail.com@lists.openembedded.org>
wrote:

> I don't think this is the proper way to implement the feature. Even if
> the user answers no, they should still get the new updated config that
> they can inspect and integrate into their existing one, so rather than
> ask the question here, it should be asked *inside*
> setup_bitbake_build(), and only if that function determines that a
> config already exists. Then, depending on the answer, it either
> renames the old config, and writes a new one (current behavior), or
> leaves the current one as it is, and writes the new config into a
> newly made separate directory. Then there's existing code to compare
> and diff the directories, so if they turn out identical, the redundant
> copy is deleted.

Come to think of it, we could do even better:
- write the new config into a temporary directory
- check if a config exists, move into place if it doesn't
- check if a new config is same as existing one, remove the unneeded
new copy if so
- if it is not the same, then print the diff, and ask the user if they
would like the new config to replace the old one (if the answer is not
already given on the command line)
- with either 'yes' or 'no' both old and new configs should be
preserved for further inspection

Alex

