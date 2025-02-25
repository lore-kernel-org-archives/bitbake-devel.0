Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E95C021B2
	for <webhook@archiver.kernel.org>; Tue, 25 Feb 2025 10:40:30 +0000 (UTC)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
 by mx.groups.io with SMTP id smtpd.web11.5448.1740480021783746539
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Feb 2025 02:40:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=kO/P8umn;
 spf=pass (domain: gmail.com, ip: 209.85.219.54, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e6827984b2so62608356d6.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 25 Feb 2025 02:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740480021; x=1741084821; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pg0vod/5Wa/Sl676zPTBrwhBLT5iQaDq74KUTwrXh2A=;
        b=kO/P8umnHtfrUpYFXGi+jyCQjhFZ3dppQ0tXN/HSQN/Bp50DB8CMUPsh0UrvSSiTFK
         iznxNo8eWR81sX1gzPmml4RrvUjsxUp7r64S8nWMAOijvRN2/WXqURs+XSsbyLnZodEr
         p4DseksuVUtIexAPY/AzpqPAUvYIPENdWljPwSJYoYsBaPG0hj23OPJaW2A1l0Czp7pp
         LEJUrjnG1v0kLHCUh8O4tBoitAQLkWFiHTe3XMXw/S1IvEXuD0DM0uQ2d7IsgKS7QWH4
         gkuCAfld7sxRjqUc90bqlcnaRTBXCLqqBJxSdBeQQY8L9Bfi9KDEtKRGhFyKDKXt6M8R
         qmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740480021; x=1741084821;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pg0vod/5Wa/Sl676zPTBrwhBLT5iQaDq74KUTwrXh2A=;
        b=SFoNFhPQxeSL4vQQ9UBpHqXRJvfNqOr9fDqPNp9xMjZDUkHRJ15NfS7zDLjq2BCeok
         NVh+JkVZsrHUHTtskvxBnaO1HJE9+9AeQW05p+v3xfny3eyHYPg2i/FEWyDNiwo3xXEX
         Q2ozW+sfrXnHCqndWRmJRNbc1WNUeysRw/9GpDmCrVfU6HLf1VA4BNETc+UfRjmlZmRT
         4QZADPK4m/O4ULO6cwH274250uTnb/ES/kCOFDTrLbY1nEnXBtuFal9cI0Wnlwalq/25
         4RKsEVZku1UGwV9pfmX1jsQJkvDcS3t3OBqynfEX1zO38UdEEpd4Yd4eWju5W+HUEL/m
         1IMg==
X-Forwarded-Encrypted: i=1; AJvYcCXWuBzys6qEPMUdNCNn7NJAhTPpZ42VP6+BYuZpMQNIx33d8TbnDCgvuHvkcCCR/w8y5axuEgu3EHYU5Wnz@lists.openembedded.org
X-Gm-Message-State: AOJu0Ywx3Xs7ENSKSzP2PcEWUQVDDbd5ObZzBBFSzBf0teNVplpkxnS8
	vYUofjNDMNpXbKf8cS5FrcuNXirxAIzm8DMF5nq438rKZjZ3bByXE6UL7RHQweW0c/5h3x+55vO
	80qLjk6NVks4nngR1KKjoK5o0J6A=
X-Gm-Gg: ASbGncv/zVPisVNFbZzX58pOIP5eILi2ypmb/YVE2z1WyBKu4W5SQNPWKIEduUSrd/2
	++JFso/jnemEeE09P7JieKBw+O9sah/Cubc1cnDSxV/oJc0IZ3r67PLEJ4iXzSqRluCJuLxVW1O
	Xb9VwL3REtCF3JoZW42g8HiWeOj9gytL++vH60dGggRQ==
X-Google-Smtp-Source: AGHT+IE98CSVynckL16p3vpDMpkVwkwO724EWo81jwwfqZpjJW/OOeo7q4A4Zs9DxxOGSGOfFRU84AgUjLhUU9C7MdA=
X-Received: by 2002:a05:6214:408:b0:6d8:960e:5785 with SMTP id
 6a1803df08f44-6e87ab2f3b2mr34088696d6.13.1740480020817; Tue, 25 Feb 2025
 02:40:20 -0800 (PST)
MIME-Version: 1.0
References: <20240502183501.1216856-1-JPEWhacker@gmail.com>
 <CANNYZj8aM+mydGDSpMhrvbt8XxKDLzMywVyfKOdxdxrAPgSs2w@mail.gmail.com>
 <416aa1661cd94d9787fec39012c4c94634a38b4c.camel@linuxfoundation.org>
 <CAJdd5GbZh7au+VtM_ueBs4MskkJtcx0pFYJG-36nUFW+=KxD=g@mail.gmail.com>
 <CANNYZj-G+j6yQXm0RCW5M2LcRxqVegsXuAPkLusO9+oueH2t=g@mail.gmail.com> <f81c98f506e531db8b119e5b30a091d10e916aed.camel@linuxfoundation.org>
In-Reply-To: <f81c98f506e531db8b119e5b30a091d10e916aed.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 25 Feb 2025 11:40:08 +0100
X-Gm-Features: AQ5f1JoWfIGoauQOZ7TljQMmyBg_05VGq-Bo5DKzJUjMww_8geRTX_VHJafJVYs
Message-ID: <CANNYZj9nsLOLGMoH9WykwuETM7U5wen-KWbqFnPSVgN--U_Yag@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH] cooker: Handle ImportError for websockets
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Joshua Watt <jpewhacker@gmail.com>, bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Feb 2025 10:40:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17311

On Tue, 25 Feb 2025 at 11:11, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:

> So whilst I do see your point, we do have to draw a line somewhere and
> I'm not convinced always using buildtools is the right one as a
> default, particularly if we want every day developers using the tool
> too (which we do).

I'm no longer proposing always using buildtools by default. The point
of my message was something else: should we direct bitbake-setup users
to buildtools if they get a fail that can be addressed with them, and
if so, how? I'm pretty sure a lot of first timers are going to get the
'missing python websockets module' problem, and they will find a hint
about buildtools helpful  (and something that is already installed and
ready to run even more so). I'd rather think about it now, and not
when bitbake-setup, standard configs and associated CDN sstate cache
go 'live'.

There were several options proposed in my previous message, and they
were all skipped in response :(

Alex

