Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01BECAC5AA
	for <webhook@archiver.kernel.org>; Thu, 25 Sep 2025 08:10:07 +0000 (UTC)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
 by mx.groups.io with SMTP id smtpd.web10.6129.1758787797642130942
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 25 Sep 2025 01:09:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Hq7NISps;
 spf=pass (domain: gmail.com, ip: 209.85.219.44, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-78f30dac856so6078686d6.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 25 Sep 2025 01:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758787796; x=1759392596; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o+58W2zne+2ASPtALchSvpZSOSsCOFcEEhVpC6E/ltw=;
        b=Hq7NISps8vHxm03Wvp44sAFQW0DOWRrInR+aRydycRGqufyJhAjHRIEDB/h70c9Gzk
         N6ukPKceVXPd4Zht6u+IEjONcKzrlqjvhdxhZphAYy4KDJ4KylBLmwIhoMKVSsK8xQJI
         aRwxYs6Bi5BnnrG6XnDnFati7yG0RkvGsYUCEXQINpEQWu6noT7lbxzKNTou57qoV1WX
         PFICpAd7b/mNxLtio/Osvnctf7BrhHAp1PWZrpEtwM+Zq4TipuIXTBJerW9ujZdDATZu
         4SlA7kbTumIVUU6zCSurAu886Eqb6BTotfYVypJH8DgqoCDL5iAXge8XWNOz+RXjwW0w
         okUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758787796; x=1759392596;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o+58W2zne+2ASPtALchSvpZSOSsCOFcEEhVpC6E/ltw=;
        b=mrBDYNRUFhuH0flY4dwAhJ5lHXpuccHwIWXI9XqiAoGmvhVBDpPVudv6oLfwzSWhlv
         Wtr2NU+fjNEDOefSb+3Gra/81hE5bDUk6GzVbSxWlUaJllFEvpEjApUjVuja5/yBYahj
         y49F80Rtwa/cTIEvzWZbrPwiVO+mRfkJBcGDYw9SkAUhxUGPLKRcpOx6U053s35oCRnQ
         nWVuDp7X1VXsOPx0L7gB/ErU9mYbKvjPzdSaxKuCZaAYsNNJb3ajO4QmU3/6LJH0QwM7
         ChrgvXIF+GnqsisyiLRlye7SMoYYainFlc86UZfDx+/rcdV/fKdVH+NI8f51dy6eDCwu
         tuIQ==
X-Gm-Message-State: AOJu0YwASri38QG2j//1IgAn/9u/n422C0Z/ZvpbFMIX85a9glhVTUWW
	pJ4pekXgH98ir9HCIeqAmc9zFtvmhM7AN7AQVMntN4IcJX4V462bL0LaT2GzHxdy0Jj32CqQI8j
	Dj8ewvTw9BnUxEDiRSJE0qDKl6t+yOj4=
X-Gm-Gg: ASbGncuGeKc9oNft1maa0PSoKcgkVgcZFYfX5ghT3xzNOr+pOtFTiZ3OukJeh8xU09G
	NMeC/URUW5rpaAZO+aF1e8hzjKELnW38CjIuABd4Zu6ZlONsIjdx9RcixCGLYNIB5g6JXZcvZeM
	ATgRnI5qkf29koHfRxYNC5O1K7NpsoZKSdT44l2Q1DyBVBWixaOHsFpJ/r1EWrB3xLbtVlq/d+I
	b66BnTiQ6f1NBvCjHeQO6LYfO4dAKbeSBDprFqpE540o3UsXHl2mpaHd/pVSC/OJXO13XiKyuj6
	vLOAtjEo4Q73XYe3fOEs4JR5f50ptKeq0BWKAm6f
X-Google-Smtp-Source: AGHT+IEo6qj5owy1ZjZcadif2L46vG65lCdfgGWhfjzAYWeGu7WfF0Roryksy0y0/yimmcAgYgNuqw2DdOrIsFlc57c=
X-Received: by 2002:a05:6214:5187:b0:7f6:66a:add5 with SMTP id
 6a1803df08f44-7fc468ab24amr34210966d6.35.1758787796412; Thu, 25 Sep 2025
 01:09:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250924-fix-no-builtin-fragment-v1-1-4d7f734b6d21@bootlin.com>
 <CANNYZj_MT-cC6xAy8nG=HdUJBa-NnwSOzaoGztDu4QaQLi=06g@mail.gmail.com> <DD1P0MENV808.21V0ZNWKO5149@bootlin.com>
In-Reply-To: <DD1P0MENV808.21V0ZNWKO5149@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 25 Sep 2025 10:09:45 +0200
X-Gm-Features: AS18NWCjXT80DXizA4eSDHDNH10-XVq1gPFHAOQlyLg7QoUd1iAgLHsWJXi_97s
Message-ID: <CANNYZj98r7ksrtcF94rs4YnWK+EgLx5Utg9_Z_GKFzSta08bQQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] parse/ast: avoid AttributeError when
 built-in fragment variable isn't defined
To: Antonin Godard <antonin.godard@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 25 Sep 2025 08:10:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18092

On Thu, 25 Sept 2025 at 09:12, Antonin Godard
<antonin.godard@bootlin.com> wrote:
> I was thinking that there may be a case where you want to use addfragments
> without specifying any built-in fragments. In this case you could either set the
> built-in fragment variable to an empty string, or not set it at all. The result
> is the same with the above code: the dictionary will be empty.

It's better to require that the variable is explicitly set. The
problem is when someone sets it *after* the addfragments directive. In
that case, this magic empty default that the patch adds will take
precedence, and the user will be baffled as to why their variable
doesn't work. Better to give an error and the error should say where
the variable should be.

> > Also, do other items from addfragments need similar guards?
>
> I don't think I have seen that behavior with "regular" fragments variables. I
> haven't tested it thoroughly though.

I think at least flagged_variables should be similarly checked. What
happens when it isn't set?

Alex

