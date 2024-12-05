Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09159E7716D
	for <webhook@archiver.kernel.org>; Thu,  5 Dec 2024 15:12:24 +0000 (UTC)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
 by mx.groups.io with SMTP id smtpd.web11.13352.1733411542645959625
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Dec 2024 07:12:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=aiNHVLqe;
 spf=pass (domain: gmail.com, ip: 209.85.160.181, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-46678a11ef1so4091211cf.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 05 Dec 2024 07:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733411542; x=1734016342; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mWbLd8KHqyEd6HgJwg8cON0YM//LmJiDMQlLfAHSOOU=;
        b=aiNHVLqeYqZbILdXQ7Udq/4qQDsw4fWZxvQPTVc3zEeUbGhRHeEDMWeSe7xjh0IbyO
         OL/0xQSquG2O9Z8efvipSTHrah0LnXBOr898ShblxYMnuTc9Wsafz5Zsk3jzysOJIm0j
         3viA29MLHltRg7R3T6tbkIrae3GMJW0tIbjU9/kaUvo1Cng4FSWGwJbbhJrNXBfkbYbk
         ZISOuN+605lmakmmoM+9Dh9iHVM17Bu0pejcFQIorKD9dhblJa8GnL5oaXURtMDLKqYJ
         OHbWVxSQMu0zN+bJQwGw2Or7LxrbFx3irWJt62CB/RMCq7VV6eOj14xRcAxAAzen0XtD
         d5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733411542; x=1734016342;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mWbLd8KHqyEd6HgJwg8cON0YM//LmJiDMQlLfAHSOOU=;
        b=nD2FHlfm+QvX7/nrD9EN4sSFlTGzaViAgiMM7ZGMlTffxpLZH6byeq+9epB2anjgHq
         aX/xxcJcVBA+TUp2PJcDhsYrFoJWYk1KeDzPkxakTOWIT+IXCimcfJFf5k1NYchEyXYb
         7Y8SZ3hsk61+opS2GEtsnRUbbUagTbFvC0EIID1EJPW+zPnT6wXXnj5URPvdrmfe70Ir
         fyhzAvThcMO1o98TAwfmNdreVc+L/xelWQWc54QdiniFis0LI+ml2YVqK9m+/LUHhYPt
         uysL1gRpWCJiwizoLh+DpQ64W7LQpfhhTHeACJo6DaqhjDAn/DO4ND+Ht17pBWox5M6q
         /Gkg==
X-Gm-Message-State: AOJu0Yzj+uXWfv6OWw58OlazIO/m8QvEA/uBm0pa9m3KT3Wf5YkPIvN4
	lPRFU+RroJDr0SeymSeOt81az3XOT97Ad55YP4jP/pdQRxW3jYwRR2fO4yRl4/zm001xihBSWnr
	46cAGzWGg5PAgI8hHngqnq5wGUpk=
X-Gm-Gg: ASbGnctOxlr6wuS65AzgUde87cMtCVSvMZUYwTF3xjLy3hxOp/uV/FMeTt7PUyhSHsz
	/zaKBjO31w85oux2xyJyj+IHzwrpjtAa+ezLwbJ9vEeVKziKkn5iX2C7h8eNt+/KASg==
X-Google-Smtp-Source: AGHT+IE6fog4uiMd9GSkmbAkowEiYEHronJsnp/Et4FUh6Pi19+FV+uDC3vhQFuJHHP+t/7Zdne/nreYMqHWDS1rACU=
X-Received: by 2002:a05:622a:11d3:b0:466:a44a:8928 with SMTP id
 d75a77b69052e-4670c7410ffmr143872871cf.34.1733411541467; Thu, 05 Dec 2024
 07:12:21 -0800 (PST)
MIME-Version: 1.0
References: <20241118162610.1423384-1-alex.kanavin@gmail.com>
 <20241118162610.1423384-3-alex.kanavin@gmail.com> <215a45a05eb2be50b71ad3c044334635239ff0e4.camel@linuxfoundation.org>
In-Reply-To: <215a45a05eb2be50b71ad3c044334635239ff0e4.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 5 Dec 2024 16:12:10 +0100
Message-ID: <CANNYZj8hDKYRQ3cCLQGb0ddch3Q4stYyx=o15uF9ohSs8Bh1DA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v3 3/4] parse: add support for
 'addfragments' directive
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 05 Dec 2024 15:12:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16877

On Thu, 28 Nov 2024 at 13:54, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> Whilst checking if the file exists and only including if present sounds
> like the right thing to do, it needs to be a bit more complex. The
> issue is that bitbake needs to track both the files it accesses but
> also the files it looked for but didn't find. If those files are then
> created, we need to reparse.
>
> There are two ways to handle this, one is to trust that the
> bb.parse.ConfHandler code does already know how to do this and just
> call unconditionally until it matches a file. The apis might not let
> you easily know if it found a file.
>
> The other way is to call bb.parse.mark_dependency() and just mark the
> accessed files that way.

After reading through usage of mark_dependency() in existing code, I
need a bit more clarification there, because I'm not 100% sure you are
correct, or alternatively I don't have complete understanding of how
things work :)

The original 'include some/file' directive iterates over BBPATH, and
appends some/file to each of those, regardless of whether they exist,
and marks them as dependency in case they appear later. This is fine.

The fragments code takes a fragment name (which has a layer id as
prefix), unambiguously converts that to a full file path that is
checked for existence and hands it over to ConfHandler.include()
(which calls mark_dependency() internally). If such conversion to full
path fails, it calls bb.error, which immediately fails the whole
thing. Would we want to still call mark_dependency() on a full path
that does not exist in a case of such failure, and why? If the error
is addressed and file is created, then bitbake will parse it anyway,
no?

Alex

