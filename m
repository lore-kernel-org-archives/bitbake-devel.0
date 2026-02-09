Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04399E81BAE
	for <webhook@archiver.kernel.org>; Mon,  9 Feb 2026 12:27:19 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.46369.1770640030449479323
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Feb 2026 04:27:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=iLADoRUH;
 spf=pass (domain: gmail.com, ip: 209.85.219.51, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-89503a3bb83so36082766d6.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 09 Feb 2026 04:27:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770640029; cv=none;
        d=google.com; s=arc-20240605;
        b=QAW+AlLxcvDD7FPYUTXnZVIef3P9BuO4oEohIk60U2/8MTQ3Gc1x8aYz4BuzYRZL+9
         saPVOWKr7RY2O33QcigRaUCr4CyMrpd8s6Hsk2l0rYQMQGAvC6u9A77YlFyVuwCF+uTy
         5+JE3ixTe/5NNHjABRVschl8waPKBbOyFW3owMt3z7z8h3SbjPRdxFIg+OUkU6daH1b+
         STP5F1TDFD8OwWkOrpFoD1vQXEuBu/laXEkv28vMwxKWDRWTBY5wADS0jPAjMWicSf95
         YDW8Nqg9TxPTSA3nRgYdFolV8YEK4nDB7zQ9sMpLlg8iHOXkiihnKjXe8AHjyoTogq9i
         8qNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IobwCmUnD1GuuL9ynlSnJwTE0x3uPC9PPmaU7ww0bxY=;
        fh=AzhvQHsntPIv1eM1lpjGIR2sWw2cIaM7npVj0FDUl9k=;
        b=O27ec7ffSkXRyMaPKtygur4dK7pIYqnfo3xC9YpBuSPRZbBBpZWh/fc9B1hUUYhfj9
         9ygVrHU8Z5oWw6nEzsLVuIno9yrfLIWFxTSQ3BwGBozY+B231Vu/NVowHA+fcXjeD43c
         eOApxSLKpxzgr/lMVPc4fZXit1g9wZYjzHdQfed6pcrr9nbdM2iQ1gFGHnr3r/vNQjBN
         ITSeMiz65DOxLG5zbwYAE4lmKpjyEf/uqlkEmODwahL3pLMIE4HOMihupqg2VmLw/9wr
         4puXnW2dPkBeN8iFH3k3oB1UGqy3SYdvjDpOnUTJJ4lHO6sRdzdZPI8sY3e5vRr6fc0O
         kToA==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770640029; x=1771244829; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IobwCmUnD1GuuL9ynlSnJwTE0x3uPC9PPmaU7ww0bxY=;
        b=iLADoRUH/A1Cxo+Pp10tbeSHsbM0wYLNK83BEs6ssRHRGrqJkkb0YZWUq5vPHORXZM
         FHi/89+vH3vItgtXanq6ao8V1t3OeT4pWkVBLhJdxhTCPNdlpCVrM39Bt9c1pld9IEeY
         GA3jsbwqsvCjRzgPr7KZGLmpmN+PfUZ62othI5OXeyQAzkaXaJrcMWq/fjRx4EdmyXru
         R3oMTKEcCOVkDoImkauERy7z00qXtnfkXuvelw71l52l08X3p2oiPEsmox8d9dhXNwrL
         VY9Ef8LunNC/u5GHz+vvmQnbjx/F2ynOcDoVM8NNhI+6lesbNwePUxb4YBnUwNPrSsy9
         g5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770640029; x=1771244829;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IobwCmUnD1GuuL9ynlSnJwTE0x3uPC9PPmaU7ww0bxY=;
        b=kdIf70ozC3/SkR5JS8WFENBsUvDWxAN54a9qaQ8P5dVoquOAK4WLYZg99lajY0sUPA
         +mlXc/ZKUdZGOaxTMpbBrdE05tUnbwPff+0Wy1IF3mO2YWsRf9q14wn8cw1yBQKfYLdW
         Tu0M4h7V/BJXVbpQNkYSGCUAd7wD+vTJVrT3EsGE7tSI9xoIUyEmVPnnxJRdFnXaXQGs
         /aqb7AToeaapQ1/xhxNKIXnSLpHGvuXvKrAST4CINgDXYPd+iaaA+I1X1H+pkPM4k3BL
         T0xYYDMdfWrKXae2RlkwEkKgyv+o8b9f/6eq+9jKgtCRGNjzfwPi25No6go3EDyVLaZj
         Ga/w==
X-Gm-Message-State: AOJu0Yx6ET/xtM0A5Xo3Y597vtoWsMqRtkImypfs4X1ZncoD1/trBrvA
	wkWfMsqPyLUbN0/JIXXS+wmydenOaN55Cf0ISX/6QMPmhcl7MmH9Rrkkp0/POkjzjfU69PfWcKC
	w+cPN/Wn5npVe7T0GQuXqUNvfO6aznVc=
X-Gm-Gg: AZuq6aLSHVOHGyrF3o/LLdihoeuwtBiD2Hgo84GaOU9999jq6fXVh1cwe6TCTRDUS09
	ecOersecxKWSLAsVZAzQWUP/z/1d/tmDi/1ufqwCUA3EmcVSVqkPT7dqDZr+lVa0LrtemOjQxdo
	3DOJCelPP1E3Qd1YMxY+vLsW+VABIED14fCmhV2eXkOOj2QhtH44c71hC+VRzhuc1xdGHAKMfta
	1VKzjoVsWIWlxSGZ17rxW+7vQi7T084O/Ur0uN9Aw1vZPKIn+FsE2QPkcRg55zcxSz5guiPNHD5
	syjGcYIvxq2z4qY/WzeA/3/ayzCJ2A==
X-Received: by 2002:ad4:5aa3:0:b0:894:6609:da20 with SMTP id
 6a1803df08f44-8953c811590mr145138226d6.9.1770640029118; Mon, 09 Feb 2026
 04:27:09 -0800 (PST)
MIME-Version: 1.0
References: <20260209021712.9724-1-liuyd.fnst@fujitsu.com>
In-Reply-To: <20260209021712.9724-1-liuyd.fnst@fujitsu.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 9 Feb 2026 13:26:57 +0100
X-Gm-Features: AZwV_Qgh-6TPAAsSr86ST0oA5rWWRAPu69lAKnHhCOyBC7_jBaZLGsgRNK_hDA0
Message-ID: <CANNYZj9c=FLoQM0ZQVZKOgPRVGHEqyeqpwT+qS+f-u-CHzH6EQ@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH v3] bitbake-setup: Add strip to value from settings.conf
To: liuyd.fnst@fujitsu.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Feb 2026 12:27:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18988

On Mon, 9 Feb 2026 at 03:17, Yiding Liu (Fujitsu) via
lists.openembedded.org <liuyd.fnst=fujitsu.com@lists.openembedded.org>
wrote:
> +        for section in settings.sections():
> +            for key in settings[section]:
> +                value = settings[section][key]
> +                settings[section][key] = value.strip('\"\'')

I think this can be simplified further:

       for section in settings.sections():
           for key, value in settings[section].items():
               settings[section][key] = value.strip('\"\'')

Otherwise, looks good.

Alex

