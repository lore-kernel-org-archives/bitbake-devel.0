Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
 by mx.groups.io with SMTP id smtpd.web11.1302.1590563494808180761
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 27 May 2020 00:11:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=D5LOWX/u;
 spf=pass (domain: gmail.com, ip: 209.85.208.172, mailfrom: jacob.kroon@gmail.com)
Received: by mail-lj1-f172.google.com with SMTP id z18so27565280lji.12
        for <bitbake-devel@lists.openembedded.org>; Wed, 27 May 2020 00:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=6E1QLGeIBjox7wM/ocPnQHwRMFlqoAOIXFZJXuMyFx4=;
        b=D5LOWX/uveKJJGjjeV1DNYRgfQawJ2PY6Pq/I0CmlVqdPnzPqHu90WrB+HIZmWC9oP
         93svD8S5ycK/WOMtr45NLbh2f143wu52ldBELRf7QyxqhrMoTczkr/l044q92bKLT0Px
         zlfMUZCArT4SsDPpw6lu2VXbRhAIt++4KICM5XhwEIF+8Ad1wf4xk9hNGCGT2AKrFbRm
         Db8aj42R3/gIlUWIuyD7wbRU2MkexqKK4BP7s7L5C7trgmJ3+9VJLSRosl5jSpfSyIJe
         eg4VLDELP57xNhOAAIFv2fcWB84Y6QPMljXu5cOmIiu7mFBn9BwIm383QpSHirg3vngO
         5eSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=6E1QLGeIBjox7wM/ocPnQHwRMFlqoAOIXFZJXuMyFx4=;
        b=G9GJc0XXa0D99rgXKJtU3nY2qfWwH8AvUMyesph11aRJ13p1oe+8iKJHrtZ6+ci+sV
         66DVQf44G6dKold6vPtKajeBZS07cMbXgw3VydVrbOkFleFHQRnE8ary0/m+1u5mR6Np
         4MunhvOyFviHZ+MLHcps5P0b40FI87RgUa5xUhDYA9X9jr6JcYCmEnYTOi7iU1O5q4mW
         yXG8DrHsURsBw9YfwN8Trb+z3Dpg0Bm/9c3TTif1uaPsnGYihu5gGr4wE9SPNNf/om5d
         aaEQ3hx3ut+2r635V8+v+DThe5rFDrswKm32LCs/ioxSC/bHcniYc3BpgCr/0O5XM/xG
         bpcA==
X-Gm-Message-State: AOAM532sjnY/Pn1/nxgbR9+RZzrjdaKAMTxUtrEFKOurPNbBlonjDais
	FAWGfSVrk5CPU5dI2W6sYqx0cG0jQkI=
X-Google-Smtp-Source: ABdhPJwFVkLKbLJy8MlcPA62dQWY7Q5B4s4iM+9C/UZbCW7o9bELBj0+rrWNTzzhOF6mNvQf0uadZg==
X-Received: by 2002:a2e:b17b:: with SMTP id a27mr2539900ljm.288.1590563492339;
        Wed, 27 May 2020 00:11:32 -0700 (PDT)
Return-Path: <jacob.kroon@gmail.com>
Received: from localhost.localdomain ([213.185.29.22])
        by smtp.gmail.com with ESMTPSA id t4sm560756ljo.36.2020.05.27.00.11.31
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 00:11:31 -0700 (PDT)
From: "Jacob Kroon" <jacob.kroon@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Question about recursive dependencies
Message-ID: <73eb04e4-ad0b-3738-fb82-39720a68e26c@gmail.com>
Date: Wed, 27 May 2020 09:11:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hi,

After many reading attempts I have to admit I still don't understand the 
last section of

https://www.yoctoproject.org/docs/latest/bitbake-user-manual/bitbake-user-manual.html#recursive-dependencies

<quote>
You might want to not only have BitBake look for dependencies of those 
tasks, but also have BitBake look for build-time and runtime 
dependencies of the dependent tasks as well. If that is the case, you 
need to reference the task name itself in the task list:

      do_a[recrdeptask] = "do_a do_b"
</quote>

The text before would suggest this means that

"do_a" and "do_b" in the current recipe, plus "do_a" and "do_b" in all 
its build-time/runtime/inter-task dependencies, recursively, must run 
before the recipe's "do_a" can run. That would mean "do_a" in the 
current recipe depends on itself. What am I not getting here ?

Jacob
