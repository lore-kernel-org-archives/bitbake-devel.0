Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E192C433F5
	for <webhook@archiver.kernel.org>; Thu, 10 Mar 2022 17:45:12 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web12.12604.1646934311140717262
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 10 Mar 2022 09:45:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=VVxuBYDE;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id
 l1-20020a05600c4f0100b00389645443d2so3873063wmq.2
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 10 Mar 2022 09:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=S9MGhdSUj/b3PVUmg933wUiION8i2WN8310T2n0TChU=;
        b=VVxuBYDETV65MoRRX+5SDqswTeEQf8m/oeWAw89NMOGvAbuRW0ZvjYkUqFTQqvaT4k
         D+XHmDpPYMd+9V3yw3H2K90fpSWjMletI81koIFKW7zlucFbON0ztVvvW9tSGAOd/Pv3
         yRU6jUNdMRJR8eEpKNm36FURDdaAgu5lwokhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=S9MGhdSUj/b3PVUmg933wUiION8i2WN8310T2n0TChU=;
        b=yG4sDmMWzutB0FoYpzYWqIBlEW9uIH0z4w4zCIhpa8OIJs/q9IiCi74gZPfktRBm5z
         Zv1/TWrMNXBktXmg1ezZoMOQVKlIA/4W3jYYgxD0SuIg6yqUGWMpw4zNmnuYAfv6etlJ
         qfoR0bO3mNssxUMcuP2EBofY5bIyQsGHRaW5SdC/NwvqirzcVnKcqX2PbubjyXpR8XcP
         QjqbQFyajXYAW6JEqhPuRDHABKzNdSMv1D/6mN+vRpj7YLMUSM7JZ5bXp7fEb8RQrVAS
         rw0Mohq/tucEopnEuHwREUNlrIi8DG+BHv62G0TNMwVGIZRj44R6NF4/6vMxFmaLUlU3
         GGww==
X-Gm-Message-State: AOAM5323RlGqdH5M9IXT8SoXUUoEgfuUtret2Lqo1Hf0onEhJplJJJtg
	rrVoJz2OBwyCH7KehvLM6W8AnA==
X-Google-Smtp-Source: 
 ABdhPJyViqpLR2fM9rUvODhvb0obYRluDziyzlhM8Kl1FxDhBFCdt+6suPRVIaMGowia3YTAIZzxJg==
X-Received: by 2002:a05:600c:4b86:b0:385:2800:2915 with SMTP id
 e6-20020a05600c4b8600b0038528002915mr13104289wmp.117.1646934309565;
        Thu, 10 Mar 2022 09:45:09 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:4dd4:e08f:40b6:a45e?
 ([2001:8b0:aba:5f3c:4dd4:e08f:40b6:a45e])
        by smtp.gmail.com with ESMTPSA id
 bg42-20020a05600c3caa00b00380deeaae72sm7981573wmb.1.2022.03.10.09.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 09:45:09 -0800 (PST)
Message-ID: 
 <5964d48ebd56efb9c7071fde98c852c069d507c1.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] lib/bb/tests/fetch.py still in use?
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: michael.opdenacker@bootlin.com, BitBake developer list
	 <bitbake-devel@lists.openembedded.org>
Date: Thu, 10 Mar 2022 17:45:05 +0000
In-Reply-To: <f24b08c0-d638-280f-30a9-a5483222a310@bootlin.com>
References: <f24b08c0-d638-280f-30a9-a5483222a310@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 10 Mar 2022 17:45:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13473

On Thu, 2022-03-10 at 18:04 +0100, Michael Opdenacker via lists.openembedded.org
wrote:
> lib/bb/tests/fetch.py still refers to cvs.handhelds.org which doesn't
> exist any more, though it brings back fond memories.
> 
> Should the corresponding entries be removed or updated with working CVS
> hosts?
> 
> Or can lib/bb/tests/fetch.py be removed if it's not used any more?

I suspect you didn't look at what those test actually do. They're unittests
which test whether certain input to functions generates the expected output.

Those tests never actually access the urls, they just test the data out is
expected for given input data.

The tests in that file are very much definitely run on the autobuilder and are
some of the most comprehensive tests we have of any bitbake module so no, they
shouldn't be removed!

Cheers,

Richard




