Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06661C83F10
	for <webhook@archiver.kernel.org>; Thu, 31 Aug 2023 08:51:55 +0000 (UTC)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
 by mx.groups.io with SMTP id smtpd.web11.12251.1693471913280516994
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 31 Aug 2023 01:51:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=oZStBMYl;
 spf=pass (domain: linaro.org, ip: 209.85.167.50, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-500b0f06136so1211248e87.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 31 Aug 2023 01:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693471911; x=1694076711; darn=lists.openembedded.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2cnhxBWA60xFQa62nLLiNJHLaMPqxBF/ufa/09C4OSo=;
        b=oZStBMYliNQVgA3gkfSlZE+7vTIPdFRnfVTs0qr0ZQ4GclRjpfocFjsofBYlw+bgbY
         NteNeUBhQHiUQnNqBMmVcuJJX2eWXYdDX3xvGu1GPRKrLmxClMM8DElQ73Eo07zITqUm
         Gy/tUTuev0+skEzWA9A1/TmEP3dv4E+rG+dlrtntf/rmkuy/djeUj23/D5TU78inNfKw
         JE25cay8WJk13prfXLyE0iN15I+X6dHEWSZY118Bd3hKgIYsJJaPf4ApCdIZuDRFWS/C
         k1Cmpit88d8goND7OTRsZZFET+U0Uimn6/Sbv0cRynpCxUooSFTs3jZvAHtjHOA6qN2l
         tLXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693471911; x=1694076711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cnhxBWA60xFQa62nLLiNJHLaMPqxBF/ufa/09C4OSo=;
        b=j9Ggn47JnCwlogGmmNguDAkZWKn7oE2+Dz3i3mIjbGQWVrY1sk4tRMS4wQOgYqBQqz
         kS7rnLJzqx8XjwbytrZAdUNDxubz5Vs6z6gKBIQoKaDXNF81V4K35ImuiYYZ/4uA+cvm
         7UYRwYRfoDNEhqEj57zWvBUnsfNWhkhimBbs/t0zXWzI63w81gbtulSZ+h31KUXLnMqV
         rcHVYHn+QI7nMAmhyazbJhurB5IHoHleqvjLMbJXHgNLJsfcDdYwlAtgdJ9jy9wKRpLo
         lr3LGSvjj3ClLZmZE3RvjBvw7WT829Ikr+bySNBWtgj6xDitY0S+uNu31bwzNQst75bQ
         oFdw==
X-Gm-Message-State: AOJu0YwZWOuhiofKgL/VLQb6izbjktNKfhd9SI/QN5YRuOZh6lyZ11jA
	/keG92hEZjvR+U5DgoeyOe1xbQ==
X-Google-Smtp-Source: AGHT+IGO+QTkWudvL3ppjtljVynSzrlpU5A3qmhu4RAw6ELSdDwun3Ch3pb1+jbfRPyMLMSSQtRjrg==
X-Received: by 2002:a05:6512:2381:b0:500:aed0:cb1b with SMTP id c1-20020a056512238100b00500aed0cb1bmr4113221lfv.24.1693471911345;
        Thu, 31 Aug 2023 01:51:51 -0700 (PDT)
Received: from nuoska (dsl-olubng11-54f814-94.dhcp.inet.fi. [84.248.20.94])
        by smtp.gmail.com with ESMTPSA id f24-20020a19ae18000000b004ff8631d6c0sm167788lfc.278.2023.08.31.01.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 01:51:50 -0700 (PDT)
Date: Thu, 31 Aug 2023 11:51:48 +0300
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH] command: Avoid time intensive
 distractions for ping
Message-ID: <ZPBUpN6GaATE+zbz@nuoska>
References: <20230830213303.2043607-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830213303.2043607-1-richard.purdie@linuxfoundation.org>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 31 Aug 2023 08:51:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14994

Hi,

On Wed, Aug 30, 2023 at 10:33:03PM +0100, Richard Purdie wrote:
> We noticed some users were seeing very slow ping response times which
> caused 'server timeout' issues. There were some function calls in runCommand
> which could be slow such as the inotify callback processing.

I guess the error looks like:

Timeout while waiting for a reply from the bitbake server (60s)

and happens right after a succesful build to me when I try to run any bitbake
command.

Hope this fixes it. Thanks!

-Mikko

