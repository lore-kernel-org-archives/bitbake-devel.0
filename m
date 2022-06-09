Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A444BC433EF
	for <webhook@archiver.kernel.org>; Thu,  9 Jun 2022 09:58:51 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web09.9221.1654768724604451756
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Jun 2022 02:58:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=gXfdAAz9;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id z17so7338307wmi.1
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Jun 2022 02:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=j4bGv41jd2wWXgM/jypy9gvZ9PsZ2PQt4P+tnhyiAMU=;
        b=gXfdAAz9wsi8pBDiOCUloiVay8TCl2pAE7YEWhD5L89Hb2d7aiZbSQF3tlav7YyGjB
         +cVtp0ue2LlTQOiQ/dqfZCfipeBj0kaZdWpnPFk7xBLLDwfqfqlpisYYSDsTQVcagByr
         x+HF+CjkjbgxjMS7EDtW+HQpi7BUr+oUNF6bg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=j4bGv41jd2wWXgM/jypy9gvZ9PsZ2PQt4P+tnhyiAMU=;
        b=CzJyD8WAo8/cS378qsLUbwMGihRcETnjre5S0LTs3krruhEEXlVyG7JALf73wdT2z2
         5m4e4YR97H7juE1+gR3EcA450lG959rA8sAMcePMR78I1wpdpf/xMa/8xkq7unfEzbdq
         UXctu1ZVweus/IiovRJ6hh+GroOYehNmkW7M6ogFeVsiUtM52CnGz42d0yB+coDiVGjf
         nbCYjbVPpjDW2xN666OIR3jEDdChCuEIJfMqlhQCi77oTgOcMupXHXEJMfvC6/o6bWPK
         9T11va4kvb2xn+cGSpuV61G2lhpfO8dQNPdBf80/B7FU7wEkw5ZoCK/Jao9bMr7sbucM
         zp1g==
X-Gm-Message-State: AOAM532ilbnfrCj7+255LrO1X0yjZv8M3UjGYuS6+uQuRMb9j8lrYgU2
	yWxVRqL3gt9vvWpaXd7Uk9nNlw==
X-Google-Smtp-Source: 
 ABdhPJwhCCDS4m/XTBiLlhVQDZ7rSk8EXQB2qcuqnIe9x9KuMtnOTh6jIkC336VEPbbnHfdc6VQTGg==
X-Received: by 2002:a05:600c:5d3:b0:39c:506d:c987 with SMTP id
 p19-20020a05600c05d300b0039c506dc987mr2569578wmd.10.1654768722930;
        Thu, 09 Jun 2022 02:58:42 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:2888:8172:672a:5175?
 ([2001:8b0:aba:5f3c:2888:8172:672a:5175])
        by smtp.gmail.com with ESMTPSA id
 p19-20020a05600c1d9300b003942a244f39sm7113658wms.18.2022.06.09.02.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 02:58:42 -0700 (PDT)
Message-ID: 
 <5e781972643ed99e2948ac5a908222a190678475.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] data_smart: Pass flags through variable
 rename
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alex Kiernan <alex.kiernan@gmail.com>,
	bitbake-devel@lists.openembedded.org
Cc: otavio.salvador@ossystems.com.br, Alex Kiernan <alexk@zuma.ai>
Date: Thu, 09 Jun 2022 10:58:41 +0100
In-Reply-To: <20220609070631.23346-1-alex.kiernan@gmail.com>
References: <20220609070631.23346-1-alex.kiernan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Jun 2022 09:58:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13746

On Thu, 2022-06-09 at 08:06 +0100, Alex Kiernan wrote:
> During variable expansion, the flags are not passed through but are
> discarded which makes constructs such as:
>=20
>   ALTERNATIVE_TARGET:${PN}-foo[name] =3D "value"

This is a tricky one. I don't think we've ever supported overrides and
flags combined? Is this in use in metadata?

Cheers,

Richard

