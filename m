Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web09.4294.1626430014117552879
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 16 Jul 2021 03:06:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@burtonini-com.20150623.gappssmtp.com header.s=20150623 header.b=HUZV8oBR;
 spf=pass (domain: burtonini.com, ip: 209.85.221.45, mailfrom: ross@burtonini.com)
Received: by mail-wr1-f45.google.com with SMTP id u1so11474256wrs.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 16 Jul 2021 03:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=burtonini-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SKzn0S/ekmnJrhEjut+crUCerkPI9ie8ENtDLJQptTo=;
        b=HUZV8oBRF2sSeV4c7mWucyRjnWXXZI2r/aVwVEyGLXmIwdEWNv/7QwXZtGaAJE5PqU
         cjJEG45/mGSU4btgH5Gs+xQBi5JKJIEP45MxAMFn+vFec7TvSUSwteuvkm+gBBIGjUnO
         OvSAtoEoIywUmX3r14YyE+/bcDVilQ5g92SrzOaJsr134k9QM2XbPuv3XKW/XR338kba
         m4Ab7P3ob5D4z3zD/3xdni2iFz99F/cgtZXzupmbHKsLmlMqf/L8OpUu0XWoHzQkqScc
         LksjO4rcV9GKbXd70UChKck0qBaArPW7m/XlXiSXmzblSAoCZ0nFUDKcBtompm4GYNzM
         hrfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SKzn0S/ekmnJrhEjut+crUCerkPI9ie8ENtDLJQptTo=;
        b=otxg7m3Zm8njejS53SskfMnDozWLNxzqNScDV57zqnbirHld2DMCJGw1j2uQLUaNCE
         evu8wcCn5s0eO9jii+AHa2axEyn8/V6IJWxTEQVOqX6bDipVVkj1hSKv6yCwbsvSBS2+
         IUzBfB0Gg7pkyNhFDl396JobJ+kySPx1fOm3LhX+oPfZHsLv6ISu1S0PCoj7CSToI3eg
         UX4ix5BTHgnLYe7FBsdXcVdrUrq7+C1TLKuwZBU8WMf8aq6JuVnRbEL9nHfRzwLUuerf
         lFdr/PUWkR+W4ybRZdc2aqF+Gvbe4uHDjI4Zn/5XjMcp4f/5G9Gm5BZ2gM9TGgKSTkNB
         3mPw==
X-Gm-Message-State: AOAM533dRUVGzZ9dM0JtZ0yBVXoIF32cXxkmyL3tWuw8bRqb7bnMhu5h
	5VPj4ngXdEfRNnoBr+Trhx6Ci+04w+bwUWFtqpF1tw==
X-Google-Smtp-Source: ABdhPJwgaT+fuad+lK5WhJgBy0msVa+/WdD+fq+mqDPisMQdL6w82yNsIhOatNzR9sEQYzwFOoPCUG9ggSADKSpuUbM=
X-Received: by 2002:a5d:6d86:: with SMTP id l6mr11319853wrs.260.1626430012424;
 Fri, 16 Jul 2021 03:06:52 -0700 (PDT)
MIME-Version: 1.0
References: <89xC.1626390228088042584.TYTM@lists.openembedded.org>
In-Reply-To: <89xC.1626390228088042584.TYTM@lists.openembedded.org>
From: "Ross Burton" <ross@burtonini.com>
Date: Fri, 16 Jul 2021 11:06:41 +0100
Message-ID: <CAAnfSTs2CMqk0JvWeMaqKcCSYFnvqC0z43Wg=HUT9GWSsGBB0w@mail.gmail.com>
Subject: Re: [bitbake-devel] bbappend SRC_URI restriction request
To: jared_terry@dell.com
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Jul 2021 at 00:03, <jared_terry@dell.com> wrote:
> is it possible to set it up so this throws a warning?  This is something I would think would be very bad in a bbappend file

Apart from when it's exactly what you want to do, of course. I've
definitely written appends which replace a tarball+patches with a git
repository.

> and basically bypasses the bitbake-layers show-overlayed I've been using to detect who has forced an override of whats in poky.

How does that bypass show-overlayed?

Ross
