Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
 by mx.groups.io with SMTP id smtpd.web10.27715.1590391604293962306
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 May 2020 00:26:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=YIXZ2h1U;
 spf=pass (domain: gmail.com, ip: 209.85.167.45, mailfrom: jacob.kroon@gmail.com)
Received: by mail-lf1-f45.google.com with SMTP id z206so6318331lfc.6
        for <bitbake-devel@lists.openembedded.org>; Mon, 25 May 2020 00:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=bcjXawszw4N7mMDROl1c8zmrwGrwViO3cREFOZMpbt0=;
        b=YIXZ2h1UgugLgAuDRAsgTceXUmR00P89SRvW5kEkDEsXTfURhG9hYdXH/6e46Nji9Q
         S6kG9Xd+BK1yjpA55IzVC7ddA+RWuwTPWzUUOgWcyCf+cwE7oK69mL49j/snRkl0Ohoh
         Ywki6cGE/OYPYqLgGO2x5eB7kZ7Fl3wEgib3rhaZ4zHTcGvC3Jt86EKR9k8fjcbRN8zu
         tNRP6v0Bpu69dAHyj4U9TAduhTnMuPZLGe7kd4V7mb6zonCZN5dyxlSeXq6/LAAl26ft
         LCQR6Tdd5t5rLItZWk6Sl68W6ucPFUjLf7xvINCSDBtk2noquzBxrZcltq+4kEbeNSND
         5CFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=bcjXawszw4N7mMDROl1c8zmrwGrwViO3cREFOZMpbt0=;
        b=NsDorzZBDrk9unaf8QZUptOTcpX3m6tCaY9rdevOLUGVqzZLB4In0C8Ckn56WrqM3d
         UzjBwinsuo9SRxbpeEGr3vFxdfoEPDEe4nvy4LLuT1vQYZKrHguALNAV+lbgKZNhvHsS
         BertGk6l4clwuiyRGSYLEjdx34KMzCh2MnbQOzJgxvruoxvILOgyNKB10fGl8tuluNaI
         k0qfvQl9Q+9IdLtd8niDmXZde5offmMPW07+gn31v6mvimEqoJmMdK+0gTcBqysrc6MB
         18tD05YtdE6LU5slfASY+Imt9SdRWlNGBFcAzMEE+ZFM/qdzrYz9oS30YBKu1Y8judPs
         5sKA==
X-Gm-Message-State: AOAM532L0c7excf1/OVM7Z5ZprwZK0bq7AC9eSSNILp5u+bFwhwsYssS
	uWYUn4pqI5ypw3g5tz5q+SqGqo3k0H0=
X-Google-Smtp-Source: ABdhPJxE91+mbgNMlobZ/1c0buwDjnkSyufE7QMa1Lf+kDFtDIXNVVIpN0uaJnVWW471Lmd+pwlIlg==
X-Received: by 2002:a19:5f4e:: with SMTP id a14mr13867633lfj.57.1590391601936;
        Mon, 25 May 2020 00:26:41 -0700 (PDT)
Return-Path: <jacob.kroon@gmail.com>
Received: from localhost.localdomain ([213.185.29.22])
        by smtp.gmail.com with ESMTPSA id y24sm4873047ljh.18.2020.05.25.00.26.40
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2020 00:26:41 -0700 (PDT)
To: bitbake-devel@lists.openembedded.org
From: "Jacob Kroon" <jacob.kroon@gmail.com>
Subject: Remove 'recideptask' varflag ?
Message-ID: <3e812b97-803c-87e7-0d55-6627c28f9846@gmail.com>
Date: Mon, 25 May 2020 09:26:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US

Hi,

I stumbled upon 'recideptask' varflag in the manual, but couldn't find 
any use of it in OE-Core/meta-openembedded master. Judging by the commit 
message in

http://git.openembedded.org/bitbake/commit/?id=f8c9b292b02ce2c28741b74901205f5e5807ca87

and seeing that its use was "cleaned" away 2018 in OE-Core judging by 
"git log -p -Grecideptask", is there still a need for it ?

/Jacob

