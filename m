Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9134C71136
	for <webhook@archiver.kernel.org>; Thu, 12 Jun 2025 10:15:23 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.web11.9405.1749723315729853466
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Jun 2025 03:15:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=WjS1ObLi;
 spf=pass (domain: gmail.com, ip: 209.85.219.51, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6fb28d4ab79so13715026d6.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 12 Jun 2025 03:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749723315; x=1750328115; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kn9gCV4myM3XefgYvY6Nb7hzi6opYEP38zK3/+pPEW4=;
        b=WjS1ObLi4JWg82vxZ7nR8nh2OT8gVSTaPZLJxGQ/oMsU9KNxQ4O2gqDaz0gYpUa48L
         wB9dCWzcxmAYwU8ZSoES4uLxWKK3TTgeYYq5sJCJjfvRwpNMpmQ066oGb2fY3H2ojTgN
         4cOk4DkWJcGJ6urW14MOrUa+IiZSfjXYW2ltAzucYAJTlUhzd//Pnccqh5TwlOmrccKx
         /P7d1CJFEYxumFST4lRKYvfliW7tVbHXnlpLd9vtgm4+W8M1J9aznUU2dEIK9PmjFqJU
         9WGdIsahUhyZZb/K8klxnuxOyW8LpyLcJrsVXBUeRKUaOBAhVoHOWl40GvmL6QGuyGOQ
         ESLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749723315; x=1750328115;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kn9gCV4myM3XefgYvY6Nb7hzi6opYEP38zK3/+pPEW4=;
        b=QYbmeaJNBdY7+5mWDIUwLl0s8uyavy3MusvyST3MEXmjAc9G1EbDqecT9L8hgVKMHS
         UdBirtb82x9YdRb8MXY6IyF4P1eRKAh94ZNlpacunCWAiDjtnGMiGN0YT75kS/4AvR1D
         r24ZEOohjxz3CxlN7xxArf61wg7PkufTZX0ORMXZ7v9brxY+vMDGrXfwS8ph3yJV8jNM
         wX4BwD3AOaf4MpXrxFdseFYrHmuk6JyECP/IVLsUf4OsEckl6ZHgqX5/LC8ggSjIySzS
         7obnLfx6KBOjJeoiVOdipnPdXOLqd4ZYoZtAbyIV3VsDz1sVclsmP6ycjpFOa9bq93Ll
         YrZg==
X-Gm-Message-State: AOJu0YyFU87jPaW+7JWRt17ty0502GS1/9zxGpYJHuW/uWmfdFQ8U+nS
	rdxzZNrckG5J1mtzi2Rislvk/cWE1KlcClEjsM97PyMQsswjFY0sJ2SJQg68XL2X4UYX6vA134W
	IguA6Tjp9u/CT0dbxsD3yG97rB2NaXA4=
X-Gm-Gg: ASbGncskjN8Jdi9KK/K2BkHzrj0gOxo2kPFzEq/xgVG2r9QepMOhm/HePxt+p8TLYCp
	0OLVjlNEF9FqBN67JxRFogUCPxSvqlURSyftC96CBPXQBML1RLCy/RbrVMihjRUZ+O3MvHR1QAl
	UC9OpLRbzJZ5Ih5Wi5xTVuW+EF4ocFaEatqKOIPLv4URr/LrDHKIkgM6wff75rx7eiI5oWeVELy
	xVnJQ==
X-Google-Smtp-Source: AGHT+IGjLbAbH79h2/SsFdpFslnLIyVMlcDp0PyLNFrEcJ6ZSe8to7PZB8i+sp0GHFNizF6p8uWhXmLurgDWVPe5g10=
X-Received: by 2002:ad4:5ba6:0:b0:6fa:bb44:fde5 with SMTP id
 6a1803df08f44-6fb346190bfmr44876246d6.17.1749723314715; Thu, 12 Jun 2025
 03:15:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250612093206.168888-1-hongxu.jia@windriver.com>
In-Reply-To: <20250612093206.168888-1-hongxu.jia@windriver.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 12 Jun 2025 12:15:03 +0200
X-Gm-Features: AX0GCFtqNzc8--6OU5-op5gSCW6G9K30Csar9vo8g_JxOAym7zPytkb0EDVa2eo
Message-ID: <CANNYZj9rw2nb4wVrESvMn+txhfpZk9SOwC3FXyvv49x2CziQEQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v3] bitbake-getvar: skip info output of
 bitbake for quiet
To: hongxu.jia@eng.windriver.com
Cc: bitbake-devel@lists.openembedded.org, alex@linutronix.de
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Jun 2025 10:15:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17699

On Thu, 12 Jun 2025 at 11:32, hongxu via lists.openembedded.org
<hongxu.jia=eng.windriver.com@lists.openembedded.org> wrote:
> +    if quiet:
> +        logger = logging.getLogger("BitBake")
> +        logger.setLevel(logging.WARNING)
> +

Thanks, this should be the correct fix :)

Alex

