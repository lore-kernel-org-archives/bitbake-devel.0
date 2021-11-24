Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AC3C4332F
	for <webhook@archiver.kernel.org>; Wed, 24 Nov 2021 23:07:13 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web12.5328.1637795231771493540
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 24 Nov 2021 15:07:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Ve4X2iww;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id u1so7239217wru.13
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 24 Nov 2021 15:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Chsf6s8WTLY0hEPor2mdY761Jf0oYn4xlpX8MTmt4Tk=;
        b=Ve4X2iwwvLuKNDwoj+6GlSoryGTp49Py9GVc3sNA0jkg0N269MUqf18rYmoLQGI/8u
         kRWXg5lpuSwFMN6VKbynGGURjgRnjgPkka4m5CT9KFrUrayJJz3MYOkeUO+19VbGSCgY
         BN+S2H1JWXKiTdzVMTgsPZwU/lBAz67GBZxXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Chsf6s8WTLY0hEPor2mdY761Jf0oYn4xlpX8MTmt4Tk=;
        b=57TUnpC+lqtIAeTGOto8yFbmgZOE5F90DtaGozVXlhUpusql+rW6Q0dv2TN7fGGe5x
         PHKFeejXwp4vw61qQCd4mDmbBdsP8Kh1Wi2MyK6kCj1nHsG94Aer8sq9mP+3Xgfp+X1d
         sfbwUH8aM6dNpkuIihad78+DIOg0xGt0Af3XJ2BZkHsuHx9//Wzmh8MKme4oXD+pU40h
         0+0XcBxQnMZAcH4R97JwYydCemVQQUkwpRwz2V5pwDJKZT7mykAv9cnaXVGiHcTxoJX+
         MFWpHAppOye4rY6gWJJ9td12tVt4KwNwZlPUB1GRErOFZmTkpGP+WbYL994uxRIZIOO7
         Ol7A==
X-Gm-Message-State: AOAM533HQiQSSnKch7OVnpeXlj5+sn8wyTNAhhaF5fJ43ih2RqAo0wee
	/Qe4de6R1EQzCTqg5XInf+adcg==
X-Google-Smtp-Source: 
 ABdhPJzNarGtfboBWa6rdFnFPVrRrFUrubx5yCaV8ZvbLfZPbc5jRGeKvcuWcwaAv/ccQcOdQH7Sxg==
X-Received: by 2002:adf:db11:: with SMTP id s17mr936050wri.573.1637795230115;
        Wed, 24 Nov 2021 15:07:10 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:6a3f:a87f:f605:c96b?
 ([2001:8b0:aba:5f3c:6a3f:a87f:f605:c96b])
        by smtp.gmail.com with ESMTPSA id
 m34sm7718579wms.25.2021.11.24.15.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 15:07:09 -0800 (PST)
Message-ID: 
 <49d29bc20a378e9fb8fd57b940f4a914f6a2eb83.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [eo-core][PATCH v6 1/2] repo: Add recipe for
 2.17.3
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: jasper@fancydomain.eu, openembedded-core@lists.openembedded.org
Cc: martin@mko.dev, Daniel.Baumgart@iris-sensing.net,
	bitbake-devel@lists.openembedded.org, Jasper Orschulko
	 <Jasper.Orschulko@iris-sensing.com>
Date: Wed, 24 Nov 2021 23:07:06 +0000
In-Reply-To: <20211124183540.39312-1-jasper@fancydomain.eu>
References: <20211124183540.39312-1-jasper@fancydomain.eu>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 24 Nov 2021 23:07:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13101

On Wed, 2021-11-24 at 19:35 +0100, Jasper Orschulko via lists.openembedded.org
wrote:
> From: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
> 
> Add a recipe for repo 2.17.3, prerequisite for the repo fetcher.
> 
> Signed-off-by: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
> ---
>  meta/conf/distro/include/maintainers.inc      |  1 +
>  .../0001-Set-REPO_REV-to-v2.17.3.patch        | 35 +++++++++++++++++++
>  .../repo/repo/0001-python3-shebang.patch      | 26 ++++++++++++++
>  meta/recipes-devtools/repo/repo_2.17.3.bb     | 28 +++++++++++++++
>  4 files changed, 90 insertions(+)
>  create mode 100644 meta/recipes-devtools/repo/repo-2.17.3/0001-Set-REPO_REV-to-v2.17.3.patch
>  create mode 100644 meta/recipes-devtools/repo/repo/0001-python3-shebang.patch
>  create mode 100644 meta/recipes-devtools/repo/repo_2.17.3.bb
> 
> 

I thought I'd try testing this. Unfortunately it doesn't build:

https://autobuilder.yoctoproject.org/typhoon/#/builders/115/builds/1004/steps/13/logs/stdio

Cheers,

Richard



