Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web12.7034.1599628533503094888
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 08 Sep 2020 22:15:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=tQXY/Okb;
 spf=pass (domain: gmail.com, ip: 209.85.210.175, mailfrom: akuster808@gmail.com)
Received: by mail-pf1-f175.google.com with SMTP id x123so1112154pfc.7;
        Tue, 08 Sep 2020 22:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:autocrypt:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=dyeS0aLX9EEf/2b5r0cgtIAKSTZXZGCGj+z5HNzXsb4=;
        b=tQXY/Okbl8qEQA3gt93N+pQ4T9/+qvJgrUATBN5bz7vinfdo0MZ1MMTlZESzSvfSvV
         bwku8MpRJqKMi1BMdzF8z3jbKiJhz4Z79bmXcr41Ailcas0m255TTgNWIcYUzI5FLvsC
         G5fuTP1AR8gqnlQr4BWAaK7MHfJsEoFfkyiZEyWho3m/cbjtigVaKlcydtnJZIREhUDm
         1mBLoOyOKZzgW3eHHuC0Ys7trCzXbrFePMZCIbaoYuVThNDaPoVfZc3dCbAT6R+JYvaz
         Ld0UHxAmQAkxH54hhiBbw1cV1+qNFrqiM6DCsTqyksqJ8zVwS8aEMT/srGOJRBoQcb8s
         nxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:autocrypt:message-id:date
         :user-agent:mime-version:content-transfer-encoding:content-language;
        bh=dyeS0aLX9EEf/2b5r0cgtIAKSTZXZGCGj+z5HNzXsb4=;
        b=TJrcMnOnDvVIModjZVzop9srPO/J4ahEaEM/Y/bddOazKSp3SKujpLsQDNIMOzOuf8
         GASJWbZTGYD2qKPMIn2qOsZ9nOAVZy9uWW1Q3c6WjUNWrCirfpBCBKbzhfzB4pmL2P2X
         YAOGzYE3/iiScFAvUAc7HpTPmjwZhmxldRw+mnWwhawHae5BbEPC4bC/qS6Rp0OZhUq4
         XWe9zsXH8EtlhGTCnHHmRTmyIIIhLHiFrH8rx9Du4S25uHcAO5n5XgqHebw7GzfSbu9X
         N/WJZTQk22f7lgIl60Mo7DGxqCqaljlaYGiOKCEleCTxlzXynWUIB4pJyzQDJy1XsHnZ
         XeHw==
X-Gm-Message-State: AOAM530LXA9fcvFcMFQZiQ2TDJMNWfnyEJWzZUChwtl/wUZLs7WfWrq9
	F0et0dWWh0/sbEHTHIXZTvEzVSqZ6rw=
X-Google-Smtp-Source: ABdhPJyjOYZB1RRLaxxcYNnzB2k8rDSFKr6YfrEIbeWXPdkvEml/YnTUu/BqUydfgrhC5CmJWL50Dg==
X-Received: by 2002:a17:902:d203:b029:d0:cbe1:e715 with SMTP id t3-20020a170902d203b02900d0cbe1e715mr2489743ply.35.1599628532626;
        Tue, 08 Sep 2020 22:15:32 -0700 (PDT)
Return-Path: <akuster808@gmail.com>
Received: from ?IPv6:2601:202:4180:a5c0:812e:2d2f:a669:186f? ([2601:202:4180:a5c0:812e:2d2f:a669:186f])
        by smtp.gmail.com with ESMTPSA id d17sm898283pgn.56.2020.09.08.22.15.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 22:15:32 -0700 (PDT)
To: Yocto-mailing-list <yocto@lists.yoctoproject.org>,
 Patches and discussions about the oe-core layer
 <openembedded-core@lists.openembedded.org>,
 "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
From: "akuster" <akuster808@gmail.com>
Subject: Yocto Zeus stable branch
Autocrypt: addr=akuster808@gmail.com; prefer-encrypt=mutual; keydata=
 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
 8CS2NxU=
Message-ID: <d6e3e4e1-f26d-fea9-b0fe-5de02f0390e2@gmail.com>
Date: Tue, 8 Sep 2020 22:15:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

Hello,

The Zeus branch was defined as a transitional branch with a 9 month
stable cycle since LTS was created. The 3.0.4 was the last Zeus dot
release. We have since added several Build stabilization changes and
last minute backports . We intend on doing on last formal build cycle
but no QA so no formal dot release. After this action is complete, =C2=A0=

this branch will most like transition to Community Support and we will
see where it goes from there.

regards,
Armin
( On behalf of the Yocto Project=C2=AE TSC)

Yocto Project=C2=AE are registered trademark of the Linux Foundation.

