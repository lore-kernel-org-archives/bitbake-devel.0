Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEE5C83F1B
	for <webhook@archiver.kernel.org>; Fri, 11 Jul 2025 17:00:49 +0000 (UTC)
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
 by mx.groups.io with SMTP id smtpd.web11.18890.1752253243818671091
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 11 Jul 2025 10:00:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ezZTOnyf;
 spf=pass (domain: gmail.com, ip: 209.85.166.172, mailfrom: alex.kanavin@gmail.com)
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3e05bb6efe0so20127715ab.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 11 Jul 2025 10:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752253243; x=1752858043; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBH3pWJ3mv2tDrhagCJWKnwfnb0qOkWGhmLpyn3woRc=;
        b=ezZTOnyfXjpvWrQ4EtJyAFpggD5daK8DF5UKIcyZ6xh4WMJP1NDsY3dVcCblrzr5oH
         1G+gmiLJByMCjCB4d09sTkb7vr1q74HYI72DT9CJm9ALY5JHzdYU90kqTpDyY7z8n1UU
         LkdLew8b7Q3zrKkCAb5XA5JgYGX8bIuihmi2ynzHb9KOJNJGfIwvRdlOb3NRp1mXtBsA
         Kv3RgZGCw5NjXtV3nDqbZgJPMJDcdG8vRyuZofI9MEjhA+5LlH4DKri0uxhP8nm/brD1
         m7598V3UVCCwzzQTevP97XoVkQFm/0m8KolzpL1EVn4nHRYUw4aoyhisNpzxqNt3b72E
         YnKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752253243; x=1752858043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UBH3pWJ3mv2tDrhagCJWKnwfnb0qOkWGhmLpyn3woRc=;
        b=gVJyRAzWL01XRdgn60rdLhJ9xDvzlZTgg0yn4DGT3Nrr+dy+qsfiyon6lMDpP2Y4XI
         3lFBssljW3KTayr/fg0Anf0F+FV2goectS9fZ/NkWklM2kMvIO+tu+DDpGWQedGNm0y6
         5eoqw1Z1VqSHO2ClRKtZGPS4hye7Hwo9vCzsSCgfh61K0oTmrZ5GcwyakGjR8H0yZaTH
         VbZ3oDkCtbQCZaGGaVG3XZLCfIYRCEUW5DDLoOs7STJilV+OMB1eKkqEqwnUp9bFdnK+
         7PjsNFdZf7rxGr4zgyz753uX2/HlwVxdQu/SzR4JKK36NQX6aG0oE2O+r93uN4WK4ISb
         j3qw==
X-Forwarded-Encrypted: i=1; AJvYcCXi25h68coWI2s9jKUtkIguJQXU0mF4ZN1kAwhHjofdpoEsj9vkW1Z9GOXz/QzCxCsw3TKCDUc6ZtSBbSsU@lists.openembedded.org
X-Gm-Message-State: AOJu0YyYxWj+wLMFysdgIO0J0SqBABUaGfa8nJFuyk05Exff+DnXrMfL
	aKoWZzQa6m4VDum37W2Kmvm9Z+ZD1hNaYeijOXqu7rCaDl2oUTXx6FP3yWmSb0oJ8qdYcAERwqe
	Z798cieeG+WA5xQomUCFrLfxkQV5dwJvjbg==
X-Gm-Gg: ASbGncuPrRIwty7ozpOoxL2fdSnUFcb5T3W4fZhiu3LYkSc+5S+Surmxrx3OA5ZvGIS
	I6gbQqhUtQYFLIZrfRFVqygJzjCeVL6xzEI77MFxelemXkIL2bHGulDNVWycE1El33ZqCAwcyzR
	8/pJxbakTVn3/kLIb3ejOBjvZqRYzCGaV10L9hapb4p0+RkvjDI+fRJm+pnRxFOjWAVNCukSOWe
	uIPQKZIfhVAHQ6yMJ5dQRm0yKIBIwE7h/1u16uLdmFO0EcP8g==
X-Google-Smtp-Source: AGHT+IG6WFAkF1zPzzTsdQU8Kp5k7AmgCVlSOCCona5+mhtBRJKIXUsCA9yFEVijS89eRieUAB27b4mcZYe+cZEbaVg=
X-Received: by 2002:ad4:5945:0:b0:704:9618:51d with SMTP id
 6a1803df08f44-704a7065aacmr51927246d6.39.1752253228528; Fri, 11 Jul 2025
 10:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250612093206.168888-1-hongxu.jia@windriver.com>
 <CANNYZj9rw2nb4wVrESvMn+txhfpZk9SOwC3FXyvv49x2CziQEQ@mail.gmail.com> <7c99cad786c37dc3da9cbd73d671ff61eb03171d.camel@pengutronix.de>
In-Reply-To: <7c99cad786c37dc3da9cbd73d671ff61eb03171d.camel@pengutronix.de>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 11 Jul 2025 19:00:17 +0200
X-Gm-Features: Ac12FXzZWT8Lvs0OO-ocshQE5aSDJTH4HsSeraIdZxrEenQb9qyP_HI_sRsQCwc
Message-ID: <CANNYZj9gOWpYGjAp2wOCTaLvw5OfJNwqqorjZKBgihZz0C3_xw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v3] bitbake-getvar: skip info output of
 bitbake for quiet
To: =?UTF-8?Q?Enrico_J=C3=B6rns?= <ejo@pengutronix.de>
Cc: hongxu.jia@eng.windriver.com, bitbake-devel@lists.openembedded.org, 
	alex@linutronix.de, PTX-Internal Yocto List <yocto@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 11 Jul 2025 17:00:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17768

On Wed, 9 Jul 2025 at 14:11, Enrico J=C3=B6rns <ejo@pengutronix.de> wrote:
> So my findings in the bug report https://bugzilla.yoctoproject.org/show_b=
ug.cgi?id=3D15881 are
> obsolete by this fix/workaround and we should close it?

Probably. Can you verify that?

Alex

