Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7CEC76195
	for <webhook@archiver.kernel.org>; Mon, 27 Mar 2023 09:30:18 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web11.30657.1679909411926861646
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Mar 2023 02:30:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=E2Gw+mXQ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso4759726wmo.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 27 Mar 2023 02:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1679909410;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DQJ0gsuBKPir17JnywBr4LR0Qxl23+v7nTcIe2fTyQw=;
        b=E2Gw+mXQz22qvUF3qruP+aCd+E7tnSsEv7Ri+5rXRqbXJfcXsNmaCo/vTRgObGoubD
         83dMjq+7SN9AP2wj91Qe9/+n9jTx76sFA12LBULt/d/wGETOq8n5aF+HF80QsDI4ju52
         prjc3Mgv60EaXQdyq44m1Euy5rLbl4A1RDuDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679909410;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DQJ0gsuBKPir17JnywBr4LR0Qxl23+v7nTcIe2fTyQw=;
        b=SAgsP06sfT47HddOJZHZ5Oqt3l/87QzOWWcHY78nj1EW+p9wMVmKxek2Uht2BiCkS8
         gMAiRo/L3wyZYTp6ZeDBJEenTZii0ifPdmlqIuoZKwoS1k0YrQKFvinru8B2XCaE5yu/
         /QeMoPv4IbF47UPmqKKzJRYHbKfWuVb+0ot8PY3klVRzx2/02GluRuPtX+hb/phGF8XP
         3jQGk0YZvxNJ6tEf1tPV+8q10JdQa/SuksnbY+jtksLzGdnLEawtEMfNtDtSqRYCCJhn
         3vKF0uXuy6dpsxHMg2186QOZc3I9o0dLpnCvEAWPA5qVf2U7uNz1hDsQjp8vJ/RkxDdV
         FO4w==
X-Gm-Message-State: AAQBX9cniI7qG/uPj0rJvLzh0ScceKyf7DHcn61vUgXd7S/+Qx1Sl0gK
	W+d53SPnfBaVvKLB7DI/UpnWIg==
X-Google-Smtp-Source: AKy350bYAe00qN9ZfRie4J+WZ/7dbiIL8RedYxYwV0fKk6evFd8zqyT27oe4T4cOryOW+XDwV0Y9Qg==
X-Received: by 2002:a7b:c015:0:b0:3ef:71d5:41d8 with SMTP id c21-20020a7bc015000000b003ef71d541d8mr825895wmb.32.1679909410385;
        Mon, 27 Mar 2023 02:30:10 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:bf51:2d4c:3aae:6bd8? ([2001:8b0:aba:5f3c:bf51:2d4c:3aae:6bd8])
        by smtp.gmail.com with ESMTPSA id z5-20020a05600c0a0500b003ee5fa61f45sm8169269wmp.3.2023.03.27.02.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 02:30:10 -0700 (PDT)
Message-ID: <af8bf9062b70d95a149a6ff6a809edb9daecbed5.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/1] fetch/git: Fix local clone url to
 make it work with repo
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Sam Liddicott <sam@liddicott.com>, "Theodore A. Roth" <troth@openavr.org>
Cc: Robert Yang <liezhi.yang@windriver.com>, 
	bitbake-devel@lists.openembedded.org
Date: Mon, 27 Mar 2023 10:30:09 +0100
In-Reply-To: <CAOj-5WA_qcjPBOH7Jt7N-Hb1saPNeijHg+VA3qKL_3gs7DYD_w@mail.gmail.com>
References: <cover.1679641659.git.liezhi.yang@windriver.com>
	 <e763d75fb33b69bbfbf3350b2592b4eea7d3878d.1679641659.git.liezhi.yang@windriver.com>
	 <CAFMvBt3DoQmj371=wjzTefmvKdXUFwZGjSXggGnFYgqcK=Ftaw@mail.gmail.com>
	 <CAOj-5WA_qcjPBOH7Jt7N-Hb1saPNeijHg+VA3qKL_3gs7DYD_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 Mar 2023 09:30:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14621

On Sun, 2023-03-26 at 15:18 +0100, Sam Liddicott wrote:
> Thanks for responding to this.
>=20
> Does this method allow symlinking for local clones?
>=20
> I have a large git repository checked out using the repo --mirror
> option, which is then cloned for each target workspace.
>=20
> I'd like to avoid doing large local clones for each MACHINE workspace
> (there's a good dozen) but instead just symlink git objects as has
> been working previously and according to the patch I submitted.

I don't think we can make everything work for everyone.

As Robert mentioned, using the alternates mechanism will break the
mirror code. I think some users will also have issues if DL_DIR changes
break the checkout from under them.

We are going to have to do something to address the changes made in
upstream git and Robert's patch looks like a reasonable step to me to
fix that.

I'm open to other proposals but we can't regress other workflows. I'm
also reluctant to complicate the code more than we need to, there are
already far too many different codepaths we have to worry about :/.

Cheers,

Richard

