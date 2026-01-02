Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2438FA375C
	for <webhook@archiver.kernel.org>; Fri,  2 Jan 2026 19:38:50 +0000 (UTC)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11991.1767382726588901777
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Jan 2026 11:38:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=GUJWis98;
 spf=pass (domain: gmail.com, ip: 209.85.219.54, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-88ffcb14e11so89988916d6.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 02 Jan 2026 11:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767382725; x=1767987525; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iJgqkS4+5wiAAlp8cAptbFzcuow2czfHYakoWV/TtIQ=;
        b=GUJWis98G5NpE9aXFL0yj91Mcry3FuiYfIZwnr8AZXF9k+olGPqqgYYVxPQeIIzmKk
         DooMDL4JRQKiKIYTOynEprb16ytXbM6F1GMfaQm0HIK/rjHFOZuc4YL307dFK6rgeDQZ
         CDsT3S+MHHktydbSwZXQ4qTiHV4qBImq0zpsR/SycK0NZpp1WG2mkYm8mCQI/ADprtUA
         /3sByVCrHPvapmoINwlqab/kGXgj2Try3NouH7nLPotAS+3auUCoPCL2QJthARuL7y7c
         +bxoz9PsjXwV4SaSdSWp2BPud3qKYb3UxhE9jKjwnVJLW4vEplcPebGCKSfqcqL/mwWn
         5ITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767382725; x=1767987525;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJgqkS4+5wiAAlp8cAptbFzcuow2czfHYakoWV/TtIQ=;
        b=Bw8V7Y87oPEjOCHPqTpPGW6O+i6fa31pJpdFIFzhL0xspPAKIoS9gBvsJHi0oXmjrk
         KBvE7WSOhLEje6ebM1KyQ8qbh9YFNNX+UGiGRN3SXSuq0uwzZwCaqFDJtSxqmRSyLb/I
         mqCmG4Zp9HCrPnYbVa/lpsqZ43HmpIaRo8Bvm2E1/LegTd/UuuKtPKAc9OZXBaQQBNSJ
         lW3ZKLVQ+JkGJSdmJ/FGyfdEkrhIdaKJpCOTxZfk09Qo4g5yFmQmrzBMlvxUQagQHTsQ
         21Za09fVuCle8PKkm82fpLur3e7XHalGRoTaIGBaSwYdkm2XKgtkLNP0F7ZBj3+ahCU0
         Meyg==
X-Gm-Message-State: AOJu0YxoO2dYfGi20+LE3wAXvhius8mKKIn8jiJNoyJLHK0HFg2yLXey
	QF60mSSSg1ZHUEkpGo6GeV30wvzysi2rW3lPRJKlv5b3VWESzACbHWUXef0eS1fK367tqjxi2YU
	wepEXQNb+HsVNz7REPlco8yrJVXVGZks=
X-Gm-Gg: AY/fxX7gq+Yio4U21jss1IDY81bZh/4Dc0ME8qpU9BBGguC15xlNLBvQICxJIgfkfdO
	uSEIeYKM+U6Kvbbqo58nJ8AjTJoKIIrfGSOQJBYjcE/SzpsOLDv6AaskcLCRX5jmj8s52B8BlDk
	rcuntKd4F+ChQVPmCPqrJTn8g+FKG303/gblvhXHfHjo48u5DMTyymJAUpyHnSLEqLEx4GoHhlF
	poDYnITjq8/ioesSEFTsIIKzG+n5g/gyyvFbmg6WCbgM6qUl79qDnXtfk+RR2iAu0Zp3ovx2rEJ
	RJAt/ecVyaiXneCN2Ikyze57LwhgO9WElCkkCibH
X-Google-Smtp-Source: AGHT+IGKzg5TAysG2CD53l8KXRg3A/e+EQLKIC3EuZd+EU0JmcioDpSymyh9Fk05DTUAlQ6ecV/Zo3lx96yHOVSZkuw=
X-Received: by 2002:a05:6214:4306:b0:888:7c7e:fce1 with SMTP id
 6a1803df08f44-88d81667a1fmr644720286d6.4.1767382725513; Fri, 02 Jan 2026
 11:38:45 -0800 (PST)
MIME-Version: 1.0
References: <20251222181527.2424323-1-anibal@limonsoftware.com>
 <CANNYZj-=2r9VFg4AGfKiYbOp5Eh57uvVQt11UTT0xVWPhfxbhw@mail.gmail.com>
 <CAOU5ZMthyn3+Y9axBKSdVy3qukFo2j_eU0VnJupTZ6pX7PoPag@mail.gmail.com>
 <CANNYZj-uV4ob-aCWH9uQGCnmMgq0p1RCh3qeBo_fp=a6iUtqBg@mail.gmail.com> <CAOU5ZMvki7BQQ9HKccMkyEMG1sCG2zWnrD9sVW9BMNXv7trXmg@mail.gmail.com>
In-Reply-To: <CAOU5ZMvki7BQQ9HKccMkyEMG1sCG2zWnrD9sVW9BMNXv7trXmg@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 2 Jan 2026 20:38:34 +0100
X-Gm-Features: AQt7F2puZUu1ZB49nwXggMva3wLxbK0eCy_iWsL0t_C5jRCDgKVguWCEQf8W63I
Message-ID: <CANNYZj_obbveRhJazqj2+uu6fNbmh1WTZrtLh1BsKuaeX6=UAA@mail.gmail.com>
Subject: Re: [PATCH] bitbake-setup: _symlink_local fix case when update
To: Anibal Limon <anibal@limonsoftware.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 02 Jan 2026 19:38:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18681

On Wed, 31 Dec 2025 at 15:43, Anibal Limon <anibal@limonsoftware.com> wrote:
>> Just wanted to give a heads-up that I'm working on a more extensive
>> set of fixes and test coverage improvements that incorporates both of
>> your patches. So you don't need to complete a v2, but reviewing my
>> patchset would be appreciated. I'll follow up with a link once I send
>> it out.
> Thanks for the heads up, and feel free to cc me.

I just posted the set.

Alex

