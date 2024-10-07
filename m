Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FD3CFB440
	for <webhook@archiver.kernel.org>; Mon,  7 Oct 2024 10:21:02 +0000 (UTC)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
 by mx.groups.io with SMTP id smtpd.web11.49939.1728296455551862594
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Oct 2024 03:20:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=SkjV0k1U;
 spf=pass (domain: gmail.com, ip: 209.85.208.178, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fac787f39fso44004431fa.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 07 Oct 2024 03:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728296454; x=1728901254; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iMplnmyG3jjFJSlCAsAUh7A8C4fLp1W5Phu6kg8qnNQ=;
        b=SkjV0k1UD1B6V8atf9KMWuyPQ3uXOId91jS9XLtBeE2dnM5h/BxnUTtM8qlIIhy6jc
         t6jBJIyiVjZ1CADRqKfD0sB6Uqw2wZjnTYZf8YoFsqOzN9ZJlbOyaiTSTKXflOBSbzGK
         uLy9NvwpSqyGnAVYz4HzzcBcD8KnOxOTejMuP+DIeIxPWGb/YzkBqd/x02Ap9aaBJCWw
         bpmPjdJFN4a7gATbMkGiZlqHeZ03onsXSG8ZRo1E0MxkIBvezHhbxTnzmIsVoE2NA+jH
         k3MKMPn+OSicmT1X0XTGa7nYo64lYltdDVzUTpbLsrWyThmSP+nFwigX3na0W8D2vZwy
         0c2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728296454; x=1728901254;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iMplnmyG3jjFJSlCAsAUh7A8C4fLp1W5Phu6kg8qnNQ=;
        b=QFs3pIAU0SlHqnVjbaCjGkiselzXQ3BFJahU1GdkxY/3EXUPlEtn7XIYnJOIf90nCy
         5UGbH4IyRGhFn9zKjqjT53pXpBIkhKFnAj78zrX1x7nS4o7g7LOyaUdsvQkh4LnxKWUY
         8dwlcNSyu0+wHYZl7UojxdQ2ksUYWDUtMcOSZ32IySpGM9bK/hgNMmUGK3MI0O8jmEfk
         YmJMAEMcagEJfvtrU7LRl52efS7BS4IQfahhoOdV1n6fk68JoU+wzKfgKq35ISvSaFNo
         Bq37pEutg2DQFJ8sAfXmG367beuHTsZHakcn/MDU60JELI9dpCuY9A/RttFFlKGu9CsY
         1z+A==
X-Gm-Message-State: AOJu0Yx3Ud+qG1NC3nJEoSgpkyi+HnPLAm6LYw9QOmlaHRKgBndLvYIr
	bZl50+Bqkab1DLiPgC+HDcwLw28rTrvu8sH0r47v4zzKhCoONHSasZm83TXEA3o5qV1IOgWC8JH
	BTUK2Nv4e4HXqQ0LSbWrhrOfWSbI=
X-Google-Smtp-Source: AGHT+IGTq4d8ZFJfr0qvDAxltA/yiNK7QJmBMeNGiMN6rZXc9PXJ6U4XEdcX0Q7ojRnX1xKKKmYknVRwWb91aE5JRaY=
X-Received: by 2002:a05:651c:2127:b0:2ef:296d:1dd5 with SMTP id
 38308e7fff4ca-2faf3b5606emr49754041fa.0.1728296453028; Mon, 07 Oct 2024
 03:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <20241004030640.10440-1-mfumita@electromag.com.au>
 <46a43e5aa802fcb59dc2dd1fc832e4fd787939b9.camel@linuxfoundation.org> <9aa944db-e60d-4b19-9865-afea669e8f5d@electromag.com.au>
In-Reply-To: <9aa944db-e60d-4b19-9865-afea669e8f5d@electromag.com.au>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 7 Oct 2024 12:20:41 +0200
Message-ID: <CANNYZj9YZ3ryc7fOFqs250Yt9UM4fxOG2yCcLx=JoYC98v=s1Q@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH] fetch2/svn: Support to feed an external
 SSL certificate file and its password
To: mfumita@electromag.com.au
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Oct 2024 10:21:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16648

On Mon, 7 Oct 2024 at 04:52, Mori Fumita via lists.openembedded.org
<mfumita=electromag.com.au@lists.openembedded.org> wrote:

> Since Jenkins temporarily installs the certificate at a dynamically generated obfuscated path,
> it isn't straightforward to configure it in the SVN configuration file in the home directory.
> Additionally, we want to avoid storing the password on the build machine.
>
> So, the "SRC_URI" in the recipe would look something like this, using "ENV_VAR_CERT" and "ENV_VAR_PASS",
> which Jenkins supplies dynamically.
> SRC_URI = "svn://[repository];protocol=https;cert_file=${ENV_VAR_CERT};cert_pass=${ENV_VAR_PASS}

This is still unsafe and can be easily misused. You need to write the
needed items into a temporary file(s), and configure svn to pick them
up (perhaps with a temporary configuration file that is formed just
before the build starts).

Alex

