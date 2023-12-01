Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1A1C4167B
	for <webhook@archiver.kernel.org>; Fri,  1 Dec 2023 10:06:05 +0000 (UTC)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
 by mx.groups.io with SMTP id smtpd.web10.19550.1701425161363954101
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 01 Dec 2023 02:06:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Gx1MCLvf;
 spf=pass (domain: gmail.com, ip: 209.85.208.181, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2c9b9191722so25796891fa.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 01 Dec 2023 02:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701425159; x=1702029959; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2YPZs3nz4vEAOovcycFaibQOBrK+S6m6G8y/SypbxR8=;
        b=Gx1MCLvfyRqy116+wgPXbJQYCVshDh8u94uYyZGfo/s9YNazzXNT1bfvfEsEQB5RSs
         F89Cn5UeKV4/lfwND4rrNwDiWuT2RFT2hAqJOEFRas9M3aVR7TviOjUfSp2WHHn9/6vM
         uDq3zLBg/f8+0GMoCmLpb5Tw/ucmYbB20jfNaQn+AziVWT8U+gdX2uI4c7rp/VujeQ8P
         bH10oN0utnl4SMNwsTgKgsUqy8YTTNfqVlW5DXUWvLB6UjAH2T9LX2N/1MSEbcbZViBu
         gxtHMZKAwJOjSWR5ealYZw/y0/MugnyfPLpNUbXNHjSIeRqDP7fZhakJa6L7HegE6I0Q
         RDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701425159; x=1702029959;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2YPZs3nz4vEAOovcycFaibQOBrK+S6m6G8y/SypbxR8=;
        b=qc2y1ncp9PeepbkltSx3Cq+uE0pKBAX4SyhZwW/kq7j6IBcqNSkZUNppsKBp0whfkL
         yNpZXyE2tYtcD03KSYK0dImV7ylwhDMfiHAFmPzuCVLI9sbd9UozrnHOBCjkEJbfGFud
         zRJEib3XpDcUpWfxMY0i0PCHQAXYycY3C0l4PPO5YnjmHuYl0Equum+I0AlVbRxiFaOQ
         Zj7xAdkmbs6XERUsyYWu+OCBdZmBaLDNMsTqTWIgGTtOmvTxxokymlHYWmIRSpoLdNMw
         eKvr/mWMynW1sJ9roFWO9HAz9r/a2trgfWiajbKRp6kfzNd+Tir+aUxEHgEnBw5ef3y+
         vZQg==
X-Gm-Message-State: AOJu0YzR4d7gmxCM0NVuNXteRdebLTI+3/3Nd5iLFDaqC8mhKx91Lend
	DTGUlagEaoDzDTq+9zNhSMd9HdMARJ3RD+5iBfQ=
X-Google-Smtp-Source: AGHT+IFbbREIqe+KI1BvGas1GQ2WRbp2LiVRSVgNc0DctAynYwL1LXDquHJys5l3c2Ikq7LterFqTJscd5DppVJBK34=
X-Received: by 2002:a2e:92c2:0:b0:2c9:d874:20ba with SMTP id
 k2-20020a2e92c2000000b002c9d87420bamr600223ljh.68.1701425159341; Fri, 01 Dec
 2023 02:05:59 -0800 (PST)
MIME-Version: 1.0
References: <5628c725-4b70-4db0-8db6-254d344b1e70@siemens.com>
 <d93bf7e3412237f73025b0749391d8aa55e9bac8.camel@linuxfoundation.org> <9a26d9a5-980f-402a-8b7d-bdf5644f3f50@siemens.com>
In-Reply-To: <9a26d9a5-980f-402a-8b7d-bdf5644f3f50@siemens.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 1 Dec 2023 11:05:47 +0100
Message-ID: <CANNYZj-5Y88m6RtoExBgR=O4uxOHnuRPCg7AiS8JMJTC_N+CHg@mail.gmail.com>
Subject: Re: [bitbake-devel] AUTOREV, PREMIRRORS and unavailable upstream
To: jan.kiszka@siemens.com
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel@lists.openembedded.org, enrico.scholz@sigma-chemnitz.de
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 01 Dec 2023 10:06:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15598

On Fri, 1 Dec 2023 at 11:00, Jan Kiszka via lists.openembedded.org
<jan.kiszka=siemens.com@lists.openembedded.org> wrote:
> >> this topic has been discussed already long time ago [1], but I don't
> >> find a conclusion that helps when the original server is unavailable
> >> (like github.com for me right now while staying in China). What is the
> >> right answer to this?
> So, PREMIRRORS is left behind unusable for redirecting from unavailable
> to available repos, and we need to fiddle with the SRC_URIs directly.
> Not so nice. I'm starting to understand more of the reasons for Chinese
> OSS projects to fork upstreams.

Address your concerns to the Chinese government maybe?

Seriously, Jan.

Alex

