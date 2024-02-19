Return-Path: <andre.draszik@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745DAC48BC3
	for <webhook@archiver.kernel.org>; Mon, 19 Feb 2024 09:55:10 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
 by mx.groups.io with SMTP id smtpd.web11.38340.1708336508845490151
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 19 Feb 2024 01:55:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=ovemzlAW;
 spf=pass (domain: linaro.org, ip: 209.85.208.42, mailfrom: andre.draszik@linaro.org)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-563c2b2bddbso5362587a12.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 19 Feb 2024 01:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708336507; x=1708941307; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=leLjhNt89gwR1OVbVf6ypNEVksDWt7fAZxITAlUKQYk=;
        b=ovemzlAW+NmTEvnWK4VEeSwx5MtXk3PDATib7+15IyYyEUzV8emzvAM1iyzZc5BXXP
         uzXoZDBHzwV5ZnjWQ4Lz9YOAkn+fHUt0d5qxtKdZlebt0JMJQBzBATigERtuM+As96e1
         JNSfllO+/oU6b2Bt6ZDTwwoICKkKdjNk+ZymSV1yOUh2Zuy4iEIqXVLpTvuV52jVaVF/
         oGRuEzlfNCDXl07zVjSAASdKaokhYJlQooS4kM2Bi4LBViH7B0r246lnvmdGdGf9CpfY
         96OzBvAo0HFCzflSXoP80U4QnqGqKARwtBvuV7WSyXSmHjxfbD7P8uRr5Vo1WPTRbFPo
         c1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708336507; x=1708941307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=leLjhNt89gwR1OVbVf6ypNEVksDWt7fAZxITAlUKQYk=;
        b=NxdRc/HFLb6Qh1zzHjOV7LwlKsUnlSw5HgYPGdyvr1IskOZ0YGeBH21jdHnF4qDIdz
         /zUiF/6wylCsf0vhwhhhFOIGARcjaBSaX2Qg1Gvk+7MTT5Z1NLDn2JV6A0V3yRUekzNt
         oJj83+JRIEl3Sp3zvMobwJ5V+wcmMieTtfxA5cFzSRJ1nADPBJFXOYnWI9Dnv0gas3E8
         T16MCUBxhzQJ6pfXf3Fz1BTWv90BuSzjmF8LFIKfP4Mr/2L8owYY/Soy4LqaLaMl8yXp
         T7U63NEQsXbZME2OPSN94Bdax0wx4FORXLW6BvEJngucCwGrCdbZvpGCxyd1XH4McAsx
         ACEg==
X-Gm-Message-State: AOJu0YyIts/17WL5cbswlNGgbttnEQnjl5gfwrFZH7D0yqXoDOGTfGCT
	SYRWOTymDPtYZxGthnzX3j+e41nVQjETvn+FmWewe7lrdqIXnL9FXCzIrthd1PddKyeFAho0utG
	W5Ms=
X-Google-Smtp-Source: AGHT+IF1TRruev3nwYBHMsPAJboRhTmibttr4s38doGOFR7fTixRxcJpUDrKZcErwYY7Xx/LGAkg3g==
X-Received: by 2002:aa7:d91a:0:b0:564:33b5:ded5 with SMTP id a26-20020aa7d91a000000b0056433b5ded5mr3244340edr.39.1708336506822;
        Mon, 19 Feb 2024 01:55:06 -0800 (PST)
Received: from puffmais.c.googlers.com.com (94.189.141.34.bc.googleusercontent.com. [34.141.189.94])
        by smtp.gmail.com with ESMTPSA id y11-20020a50e60b000000b00563d03030e8sm2527526edm.55.2024.02.19.01.55.06
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 01:55:06 -0800 (PST)
From: =?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][PATCH 0/3] support git's safe.bareRepository=explicit
Date: Mon, 19 Feb 2024 09:52:11 +0000
Message-ID: <20240219095454.3211974-1-andre.draszik@linaro.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 19 Feb 2024 09:55:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15935

Hi,

When git is configured with safe.bareRepository=explicit [1], various pieces
here just fail. LWN has an article about the problem that this configuration
option addresses and why it is useful in [2].

It also seems that it is being rolled out in some environments as a
default for users.

To reproduce, simply run
    git config --global safe.bareRepository explicit
to add safe.bareRepository=explicit to your ~/.gitconfig, and see things
fail without these patches.

These patches are the first stop-gap step to make bitbake/OE work with this
configuration option enabled. I believe in the future, these should be
converted to invoking git with the --git-dir= option explicitly.

Link: https://git.kernel.org/pub/scm/git/git.git/tree/Documentation/config/safe.txt#n1 [1]
Link: https://lwn.net/Articles/892755/ [2]

Cheers,
Andre'


