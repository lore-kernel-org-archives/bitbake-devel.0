Return-Path: <jacob.kroon@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31509C433F5
	for <webhook@archiver.kernel.org>; Mon, 30 May 2022 08:41:19 +0000 (UTC)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com
 [209.85.208.182])
 by mx.groups.io with SMTP id smtpd.web11.34558.1653900074096798848
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 May 2022 01:41:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=bMM1YKSE;
 spf=pass (domain: gmail.com, ip: 209.85.208.182,
 mailfrom: jacob.kroon@gmail.com)
Received: by mail-lj1-f182.google.com with SMTP id w23so73549ljd.11
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 May 2022 01:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=TgGMnUGsjyY1nz/EAAztQBxpbIsSQA9Dfp2LsdiwqXk=;
        b=bMM1YKSE8JRzNbi4qtERlgqtUi7SDfOH/O78ofGeE6ofrrKKj9j1crrxxD11Kxthl0
         Wfgdw3eX7Fvbv9h2lXWSOdu99RjVkyYpObFsjYxF1N54H0lHxsNZTgSag1tLxv9xrAY2
         yH3Brg8e9/sExPxdKRNooJSTF8LLar2QfiC9vSiHiZylNeKKIkpz2cF//po/nw2fOrMg
         NlxwKBpR3E0EewPK4+AUp3Y9EhGUoi2v4Ee0TSXr2KJpL/wv3TRfA130R3Zj4atT0lAq
         eeEbW43YwhpAoZZmi6n3WzgMhhVWqDy7DE+17EcABLBTJciW1fwjUx66GDA3UzQe74nK
         JaGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TgGMnUGsjyY1nz/EAAztQBxpbIsSQA9Dfp2LsdiwqXk=;
        b=pkf92dlGKrWT3D/M2gBhHAdl1XrajsIdDq637thbRzzhJdHb4HV1HwlkKCZz+J3xde
         Y3DBeEL8Sw5tTVZ+sovsLs9qpxWEyV54MJIRPnLLn8QHOA2DgvuGe/gXnFrwm0nuDlEd
         PICVgKyyoJIArUvDor2GP/tEuMHLeBsd7WDe7RsHgYUq5fLm9kZnQVectsqhBOnzzCZP
         xhmo22OI0ZZ1dtoV956u6N4mQbP+SUs4C+e2cse0sSE4GcD1jN42yImdNfZ6gFpkesy2
         IahmM/tu9PyzxKSLG8S0EB6JUqFz0lBgfwCi0bzTdpPu8daDbJYPJ8+xoYX/fAiQtFrU
         /zyg==
X-Gm-Message-State: AOAM531gaggkU47J61lrzktiDqzLN7C54aaKxrkx2VrVbmHW2OkwsFrQ
	zlv7qnED/gWm09yJWai1aR6WRAM9FDrIxg==
X-Google-Smtp-Source: 
 ABdhPJzdRMhCK8txMa2e1isKfjLGav4VgWbxTCI4GteBcBHuT5/txAilSJ+K5pvJBj+R5j6n4PgVKw==
X-Received: by 2002:a2e:8856:0:b0:255:5000:b308 with SMTP id
 z22-20020a2e8856000000b002555000b308mr1913208ljj.399.1653900072124;
        Mon, 30 May 2022 01:41:12 -0700 (PDT)
Received: from [192.168.10.102] (89-253-118-72.customers.ownit.se.
 [89.253.118.72])
        by smtp.gmail.com with ESMTPSA id
 b26-20020a056512061a00b0047255d211e9sm2173805lfe.280.2022.05.30.01.41.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 01:41:11 -0700 (PDT)
Message-ID: <b631915a-703c-28d1-7320-74dcc62c362e@gmail.com>
Date: Mon, 30 May 2022 10:41:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [bitbake-devel] [PATCH 1/1] bitbake: ncurses version of
 taskexp.py
Content-Language: en-US
To: "Reyna, David" <david.reyna@windriver.com>,
 bitbake-devel@lists.openembedded.org
References: <cover.1653802954.git.David.Reyna@windriver.com>
 <af83d503f04b2064c8ad0f005fa526185e231619.1653802954.git.David.Reyna@windriver.com>
From: Jacob Kroon <jacob.kroon@gmail.com>
In-Reply-To: 
 <af83d503f04b2064c8ad0f005fa526185e231619.1653802954.git.David.Reyna@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 30 May 2022 08:41:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13721

Hi David,

On 5/29/22 08:15, Reyna, David wrote:
> From: David Reyna <David.Reyna@windriver.com>
> 
> * Create an ncurses version of the GTK app "taskexp.py".
> * Add these additional features:
>    - Sort tasks in recipes by their dependency order
>    - Print individual and/or recipe-wide dependencies to a file
>    - Add a wild card filter
>    - Show the target recipes on BOLD
>    - Add a seft-test
> 
> [YOCTO #14814]
> 
> Signed-off-by: David Reyna <David.Reyna@windriver.com>

Very nice to have an ncurses UI for this.

When I try to run this from within tmux I get:

ERROR(Taskexp_cli): Requires 256 colors. Please use this or the 
equivalent: $ export TERM='xterm-256color'

 From within tmux I have:
$ echo $TERM
screen

If I set TERM accordingly then I can run the UI.

Is there anything the script can do here to help, or is it just a user 
setup error ?

The window widget sizes seems fixed, they don't scale together with the 
terminal size, is that intentional ?

Regards
Jacob

