Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27841C4706C
	for <webhook@archiver.kernel.org>; Fri, 12 Jan 2024 22:20:26 +0000 (UTC)
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
 by mx.groups.io with SMTP id smtpd.web11.7403.1705098020510885652
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Jan 2024 14:20:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=kkwTeudy;
 spf=pass (domain: gmail.com, ip: 209.85.160.42, mailfrom: raj.khem@gmail.com)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2044d093b3fso4193057fac.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 12 Jan 2024 14:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705098020; x=1705702820; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3Kmi1t/wc5ET+DW7QCeJu3AGBQ5zbz1xyeY8aKjRYg=;
        b=kkwTeudyIBqV8Jv2x8y2eY28izveLtHFpLPNWsWyIk+8RyOA2Pa+HmITdB+/vNeYLH
         Qrfrk146ulTF8f8T5LYcyeq5WszKULoMEyPiBdLIB3z5V7zgar4EHDpE9iYoKzuvEu15
         SCaysjG7X0P2EqPL4TOdQaxqMOa00DK4J7FFOTC13YJZvmdOxXFC+mcYv5jRbPdRTzC5
         hxlNY2jS9SEGbsHWVXeYfYGVuPdS/z/v8Ur+V6kvE8tFYVXzSWMdL0ed9ett7gXx0tAj
         ItrfrRBeYFq+FAgPs/gAZKg8umJV5gIUl+9N9kEI3ge8nzSxeLNtUj2WoAr0DPbTS4jt
         9g5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705098020; x=1705702820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m3Kmi1t/wc5ET+DW7QCeJu3AGBQ5zbz1xyeY8aKjRYg=;
        b=K+FVQlA117ySLcNdpZhzYPbRgUWhkLN4quU1dKICe862JIX2E7bzH7FOplpBGNMPAY
         xo28HNttehyxt/YCG/4uyIkt3g5xPGEf7QXPklAV6E7A0DR3RjDJQcyf/EQL6i3x8C91
         2XYL6Jg7yNTP3dxKwLZsMJugiEIfitXX1I44ZZOlt3lKTgLMsSVWEk1UIatNpMekvtqU
         K5bg20LCY0Y+omyXqEPmymRZ+lCGajQO90iPJakd6TQ2MIwgE7NTatANcsrnwg7a6DDt
         njYo6b/GhQfEbzLd5/jbXdVm5Q24kPWCRAmgCCtK18tkIOxX0OurilFGEDSyrPC8aSp9
         tOVg==
X-Gm-Message-State: AOJu0YwHq5bqHB4TQHr7gZ2/9B/mmw3Ic8tmA/NPdEGFl3bEWdBlpCbx
	zHMO+MS5Z6xj2qJx5GSBHS4wG2yvbnGvlociu5g=
X-Google-Smtp-Source: AGHT+IFd27mKXadtj9NlAbGnJouHHiKCXJGf3kJcusOtnAhwJWjyE44UA5fHmkhdoYymdy1fcSq1pbLOz+I3dV1FQWs=
X-Received: by 2002:a05:6871:215:b0:206:8464:a16f with SMTP id
 t21-20020a056871021500b002068464a16fmr2248906oad.119.1705098019645; Fri, 12
 Jan 2024 14:20:19 -0800 (PST)
MIME-Version: 1.0
References: <CANNYZj86b3GMtSVZMn8744HjMSMQVkzuXBTikLf4dFV0ULsvqg@mail.gmail.com>
 <0186f166a0ded0d97d5e19f64a3dd8e5ad44a92f.camel@linuxfoundation.org> <CANNYZj-cqQVJcs3AUvzE=Lw+mYMUWZO8JW1N-Ukz6BK3H2rchQ@mail.gmail.com>
In-Reply-To: <CANNYZj-cqQVJcs3AUvzE=Lw+mYMUWZO8JW1N-Ukz6BK3H2rchQ@mail.gmail.com>
From: Khem Raj <raj.khem@gmail.com>
Date: Fri, 12 Jan 2024 14:19:53 -0800
Message-ID: <CAMKF1soqnpKYkcGzkS1A2UGGiy7_Vbzym06rARRTqCnUc7gsCw@mail.gmail.com>
Subject: Re: [bitbake-devel] regression of 'world' performance?
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Jan 2024 22:20:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15794

On Fri, Jan 12, 2024 at 4:27=E2=80=AFAM Alexander Kanavin
<alex.kanavin@gmail.com> wrote:
>
> On Fri, 12 Jan 2024 at 13:13, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
> > So nothing specific I can suggest but just my observations/thoughts.
> >
> > You could pull the event log json file from the build and "replay" it
> > with some new viewer tool to see if there is any specific delay
> > involved between task executions. The events should be in there to
> > allow that.
>
> The troubling part is, I've seen cooker at 100% cpu and not
> progressing for minutes locally, on an unloaded machine. Then it
> spawns some tasks, which quickly complete, then it does nothing again
> for some time. So these might be several different sources of slowness
> we're observing. The meta-oe build I've pointed to had just about 6000
> tasks completed after some 6 hours, which is surely much slower than
> the machine is capable of (and there were no competing builds in that
> time).

I have observed something similar and brought it up in last dev call as wel=
l
one suggestion was to disable hash equivalence, which I did, it does not ch=
ange
a lot which could be attributed to hash equivalence or otherwise, I have al=
so
tried different python versions on the host but that did not change
anything either.
I am still looking for more ways to narrow it down.

>
> Alex
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15787): https://lists.openembedded.org/g/bitbake-deve=
l/message/15787
> Mute This Topic: https://lists.openembedded.org/mt/103680528/1997914
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [raj.kh=
em@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

