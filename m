Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8B7CD6E4A
	for <webhook@archiver.kernel.org>; Fri, 29 May 2026 16:47:50 +0000 (UTC)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14867.1780073265198616972
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 May 2026 09:47:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=UtAJ5dgI;
 spf=pass (domain: gmail.com, ip: 209.85.219.41, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8ccdef9f3d4so14294846d6.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 29 May 2026 09:47:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780073264; cv=none;
        d=google.com; s=arc-20240605;
        b=S9HKBd9wAP21pARcWIJctb1+i8Tzn/d3wDzqS05UWbg7cmP4taaSWRbKcQZ5e0cGKZ
         DIvP9dgUYPzslRNpa/z+s3SxxvReTPjtWpmhWVCi04cmm7nKtEfp7V+nglSymkDvHrP8
         890+6nE3eN+ZjuqpnyunjiL5uj59r2yr81t+2q02GexJG+S2/s29w3pyCU/Udw+a0mt2
         IJmKT59T32qUMtmePTZuUiwybxWb5OVa4e2TY1+kqFrmcqWasjOE5e9vL/Z7tKJSyCAR
         elL49BbGxFPrdU3i9uaWOQvTuWPEkpPaSwsFzZtk9OnQqd0fVrTPAnfsgyVojYu1zhJx
         iQvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=eApA8ktP8anQfJIejoe1t8pcSSzuSYWCD0i2fB7lDS8=;
        fh=GWExUfJR88oeVCRfRxKHLPc/xMpLE0KqWIH3LUJXQUs=;
        b=byIpeMFp6qDDdQxi+tqmvIRaGN03QKj/rBY88k+DnMv6+/QUSX+VISLVDCBLA/6hG3
         cc2G+S040NtX2+kLMeQWlfDc1lQnHOj8dOxKOMhUlocGaAPnEI/AMGkRnwI/zqwNcvPl
         QcDW9QZOQaRHghj8ATJb9yvMjpplAayA5vvvruuHoH2rOTtNXvfMg480t1e/bAyLtYpr
         +RpXGm4K337SQWQ9+z05aItd9bKxoFprEdVOfltVOLD25bXxd4fzMvoxIDhCnAw6qbMd
         GjMJkYwR8fMZu/z/bHp5bWM6b04PEMprLrOCaPko6no/sW5gBDpZHy+DmeuktNmQ19wb
         04sQ==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780073264; x=1780678064; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eApA8ktP8anQfJIejoe1t8pcSSzuSYWCD0i2fB7lDS8=;
        b=UtAJ5dgIfe0deJzJSBR4CusrnwmLNhrtTCqdQH0q1ceeiMnF4/OmFyV6lLl83h5rPS
         fT9kZn7Tm6r9JDB/HHYjDabxNMLM0b67pzRGLUyWFRaOGvUi7QjWTg7KU9GpCD7O6+kG
         PkAuKGTWSj3MXBV/PUwz7qIb7KxmcHmbplpbskvPFL+jyu1ZF/+shG0XGlQmNF2uBtKQ
         tD5Nvg7NSKXRMBL0tnBUEpvaF51y5gvJIAJWvp0b9Aby6pTLD2Q5s6nfF39lHY2B+PTR
         uFFzpcUbbstNvDTMSz6pgZth1OHcqfNy638Yo5ujYYnuYslqZSpXk6tkayH6+q1Z2GXr
         +SBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780073264; x=1780678064;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eApA8ktP8anQfJIejoe1t8pcSSzuSYWCD0i2fB7lDS8=;
        b=LFsQBAi64F+4m8hur2y9vZbslfJNd2wO9jx2leHowma0zZN3YzYREnu6DVwlE4SKmO
         SsTcNeoGF5wH1C8C99vg81wQ0moTY+jsNM6vgautxIaeIc0g7Q+8zMjZDr5Lq+8sCDKc
         P6wNh+WjpQXeXlW6jqYN/Nhl2IzJkE1UVYVrU3YQmyGaAF3k9TfsIDgORgCcO90xuJAO
         wUKLEMCr4PIWp9DS3BLP0VmxfaKamb6KLWpK05LNCXENhXbqByMrpXaynanWlCXTpoNA
         +aX0MssFWB2hSyINFUDHqYW7jpEmXIGwIfMmH8tUVfN7v/8hqgxSP0OQfl9b/c2oL42c
         R8ZQ==
X-Gm-Message-State: AOJu0YyBPGY6BQuPXg25spzznU7wABNPVMYMm4BmMSTnjw1+ZtnICnBF
	nwLHPdrJp3flSohNKrkCLwQTl7n34zEkInljBECD9UEjK/ImfGthZoDYpDWJSLKCd2jbvbDvX3e
	oRCaee/K4tRyx1FL9cYZMq9A2B52kRb0=
X-Gm-Gg: Acq92OGGN4k/aN7DpaAxoynqI6YnMSFj+R0OkFYt6hlupzdh0MFpT1DcUwBxlcrGLGH
	0JY0bhkiS3yXxhkqqMjk/mwYxm9yGuIUPBXAS0B81MbtPPqmD8pTcoPGGMBIQWTbDVHPfIssf9O
	gQcst/LOGHTFdJKf8QhPGfaNnTvEJmORcEppV6KsubyM0pVNNA88PuWtPeD3DF+oNU69bjZZrOP
	g3+NQWc0++GMnGxCPGFBoBNdtR3f63uSTwjOlYVhRqVWB5EHbde+BTSMTPlJ8nOR07aDN1W+DEN
	pk5ElEmy2MqpEO2Pt+cuzzMUUWirMYLra9KaBwqisIhrPnMRjysg
X-Received: by 2002:a05:6214:1c87:b0:8ca:f1c:6493 with SMTP id
 6a1803df08f44-8ccefd32d20mr8318366d6.1.1780073264262; Fri, 29 May 2026
 09:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260529-bb-setup-notes-v1-0-a251ef1c5af4@toradex.com> <20260529-bb-setup-notes-v1-1-a251ef1c5af4@toradex.com>
In-Reply-To: <20260529-bb-setup-notes-v1-1-a251ef1c5af4@toradex.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 29 May 2026 18:47:32 +0200
X-Gm-Features: AVHnY4LWoueJhm-_3wjMR7i3P19m6ybZd1AD6XVcaksMtnv2Jzcl58cu7jf5uus
Message-ID: <CANNYZj9dR3cdss0_6BZ7QatGQYBvF9phtnu8bX5S1x-mqHUUJA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/2] bitbake-setup: clarify configuration merging
To: ernestvanhoecke@gmail.com
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>, docs@lists.yoctoproject.org, 
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 29 May 2026 16:47:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19570

Thanks, this lgtm!

Alex

On Fri, 29 May 2026 at 17:00, Ernest Van Hoecke via
lists.openembedded.org
<ernestvanhoecke=gmail.com@lists.openembedded.org> wrote:
>
> From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
>
> When nested configurations are used and the same key is present in both
> configs being merged, the Python "+" behaviour is used. This leads to
> lists being appended and strings being concatenated. The first is an
> intuitive behaviour when specifying a tree of configs, the latter might
> not be.
>
> Clarify the configuration merging behaviour explicitly in the docs.
>
> Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> ---
>  doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> index 77fc4c3dcba0..1252f22c823a 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> @@ -1068,6 +1068,12 @@ They contain the following sections:
>        configuration choices by putting together information from a leaf
>        configuration and all of its ancestors.
>
> +      When the same keyword is present in a nested configuration and in one of
> +      its ancestors, the values are merged with Python ``+`` semantics. For
> +      example, lists are appended and strings are concatenated directly. String
> +      values such as ``description`` should include any needed separators in
> +      the configuration data.
> +
>     -  ``bb-env-passthrough-additions`` (*optional*): List of environment
>        variables to include in :term:`BB_ENV_PASSTHROUGH_ADDITIONS`.
>
>
> --
> 2.43.0
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#19564): https://lists.openembedded.org/g/bitbake-devel/message/19564
> Mute This Topic: https://lists.openembedded.org/mt/119548245/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

