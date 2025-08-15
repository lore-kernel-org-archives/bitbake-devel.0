Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C315CA0ED1
	for <webhook@archiver.kernel.org>; Fri, 15 Aug 2025 11:10:40 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.web10.9297.1755256233399235665
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 15 Aug 2025 04:10:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=FdoxABg7;
 spf=pass (domain: gmail.com, ip: 209.85.219.51, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-70a9f55ea73so21316416d6.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 15 Aug 2025 04:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755256232; x=1755861032; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qGpvk1FmhW4J61sZrijTmUXPVKP7QF5MBkBjy0EaiTE=;
        b=FdoxABg7wgOpyiD/rTVp0Ivap6RqEZsG0mvfpU2DNsyzzwmP/McsGi3vCUs6LfysJY
         iH9MpjSLIyc8ejgrQMxm0OxmuxU0P0sc1QGFvmslKcdwaWSxX5pAuNyQh5ExtvhZl5j1
         HHHxAajZEDAToR+T5ivTWVG2CR4wH5klQT9EL5gdBASXlcZYbaJZ+UlctHVym1h1k5Sv
         iWxBbTX0OiGYR5IYgOL9l5MQMHNvTRk46iF5r9HMEr24yFDHQ+P1ysRE4CupKw7GsIek
         dh8ZzZYTR9G6Z3hFJoNFFSzFofkr8i4t6SNY/xmpYi8sMOAW/c1fYS1sOLVXluJ+7BQS
         iK3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755256232; x=1755861032;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qGpvk1FmhW4J61sZrijTmUXPVKP7QF5MBkBjy0EaiTE=;
        b=hQl5+6ljQWPaqzfjVj30wOeFFwHS1wpUwGsazUk1OxZG56VHXl3pfmaiqJLmt44LEk
         wnGPjT3IUKCqYFkADVOvDlFpnEwA74WQdSVGyp9iJom/DU6IOKCGXoZOut3o0tN1cMKW
         J/ZJjC2z8Z1SUVI2f4UMeeFDtNFMwMiD/BVPg1STLFWQ8so4Kv79KAKpoupFU+9tW4Ug
         tCn3ou6yhpl0e74l2hvf7cBl9Z/XtZzhvEDUR2RxqoMrtzYMUYcwlmyefaUkT+Ow+7Mu
         rxP1e/a4VyCB0NSkoAvKYBULaYza3Lrsg9oHlfIkIlLYar9xO41vC53m8gV0g08Y4yik
         5xGw==
X-Forwarded-Encrypted: i=1; AJvYcCUwLWJsgAUhCNiV1Esj5BmziINYAoGWysEdSv/oH9TTNM4bm3Zw1osFIV3O72pudLX6s99pCSsVHflhSWW2@lists.openembedded.org
X-Gm-Message-State: AOJu0YzAy4Rh4GIE3dbGtAjBAdY99dL7sbXwff9OgACP7CysZ3S6lu4I
	tmdgtbFGr3QppgQsDjTLqNPHX+QuYe6/5V+b9WRZQPidK4qd5diADc20IFmZxyKjICSsmgfMXnV
	V/nvaNL28QSP4MJOkWKBhtScUf6Jzl3E=
X-Gm-Gg: ASbGncvMIp2aZcMW44sa8OJ6e8YtR80AVxTLx7M5KV7PHbSo/WCRE2oLGGi0eU45jnx
	qjhMXO+bUW9rpgyoK2Tu50YOEfl1PxzQb0HHv1iPZ7EDqWxYgMDiU/jeUndfszED84xe2EKI2Vt
	GI6ei0xh1fkoSB38ECLGjZAq/1f6tz/Uivn1K22RxxpW5/IP7tLkjh69z6jy1vpTI1MBz3OEh8Y
	5AYX2Uwsb0fb22SI45yI2K5N0IgloRhTwjxfmf4JlDwsXxr
X-Google-Smtp-Source: AGHT+IFuGDMRnQvmoWD/JWxlHx0rM1QXo2EfEqtP7UCsH3RgM7UuzaIeO2DjHsISSiaS+q5YE31GfAMlJDV+jxEtX70=
X-Received: by 2002:a05:6214:1cc1:b0:709:e1c3:cbc6 with SMTP id
 6a1803df08f44-70ba7c5d244mr13015606d6.43.1755256232411; Fri, 15 Aug 2025
 04:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250729144906.1665908-1-JPEWhacker@gmail.com>
 <CANNYZj-TMk4ktaPqC2EbS-k636cJfr3hyeZXp5rrEESi-ovZjw@mail.gmail.com>
 <CAJdd5GaNH=gP+ypmV31MLwYgF-xdT+e-E9rfW1JCgQis2PJtyA@mail.gmail.com>
 <DBY5WKIGG9UG.3DFOCYWME1YVA@wolber.net> <CANNYZj_7MebKw3iKvgRdKkpQvBW4a+4kdP8QZX_yWoY3DxN6TA@mail.gmail.com>
 <CAJdd5GZXsmby-n5XRX+U1-Hg66xricNt_oyAz0CG9mY89U+3Xg@mail.gmail.com> <185BEA3DB770D62D.30607@lists.openembedded.org>
In-Reply-To: <185BEA3DB770D62D.30607@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 15 Aug 2025 13:10:20 +0200
X-Gm-Features: Ac12FXy3DqmrHe9_NWaKm-2wiJILJdnnOg0Q8-piWSv4nVjdOS4H8CklseOlJjM
Message-ID: <CANNYZj8e=9C0sCgFd9kTOR+yPmV0kB72yvb_s_7=koqWgkhhbQ@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH] cooker: Add layer-specific ignore for
 dangling appends
To: alex.kanavin@gmail.com
Cc: Joshua Watt <jpewhacker@gmail.com>, Chuck Wolber <chuck@wolber.net>, 
	bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 15 Aug 2025 11:10:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17876

On Fri, 15 Aug 2025 at 12:33, Alexander Kanavin via
lists.openembedded.org <alex.kanavin=gmail.com@lists.openembedded.org>
wrote:
> > Hopefully that accurately outlines our struggle here and why we would like this feature.
>
> Thanks for the detailed write-up Joshua. Given what RP said in this
> thread after this email appeared, I'd like to abstain from further
> commenting.

Famous last words :)

After I sent it an idea popped into my head:

why not have two layers:

- one layer that exists for the sole purpose of hosting bbappends, and
yes it would have branches for each of the respective yocto release.
You'd have to devise a process for patch flow that ensures bbappend
tweaks get applied on every affected branch. There's also a benefit in
having less file clutter, as any branch would contain only files that
are directly relevant and used, and one wouldn't have to figure out
which bbappend goes into which product.

- another layer that contains everything else, including distro
definitions, and product-related recipes, and has only a single trunk
branch like now.

Would that be still unworkable and cause too much overhead? I can't
imagine that bbappends get a lot of churn and are changed often.

Alex

