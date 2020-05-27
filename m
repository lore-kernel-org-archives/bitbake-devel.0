Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web10.2929.1590573672003828286
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 27 May 2020 03:01:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=bwFP11Xq;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id j16so10946688wrb.7
        for <bitbake-devel@lists.openembedded.org>; Wed, 27 May 2020 03:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=htXvzrHqE57gZRsz2sIWcheNmflr9xbwzjnNZ1afE0s=;
        b=bwFP11XqtBUhcUtLsJZ5PQtiQeD3ITuq5kno4+gO12l41YCATPMNnqxaZnnXxKDA4h
         xo0BanNzPoaqTCAXKuVnONAhLmjqUhSKXyPPZPR/2gtEDqOitR+Ep4FX41RgBzh5S4mU
         lX4v7yNbIqxBBd9LF/3pY+bjp0o3/Kx6fBAxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=htXvzrHqE57gZRsz2sIWcheNmflr9xbwzjnNZ1afE0s=;
        b=JHdjThgLbHVf6ktzaw2YHstJJVdbiBIPKOwe9P0IAl+FUCAcYNArPtt3tABSQXS+SQ
         35fifT9JPol04lKL3AwWWlfWUmu5iYfPgbP+If8BMDtjEO4RxzL0SDyv33ZtvTY1fQLu
         OZgXlZ9+zmd7a/tONaU+wi5O57LBJZM4KifrDiA4quI6mRKz8SySDi/nYLAlLtt/B7yk
         HsAxL8tRY+AUw7hubCLdBAM4Ghji9GuE6cn+p+SMCOMYfvK8s0Mzx+qTXAu1ub5BGbHP
         jZ/P1R90Br1/f37QWvnyg+I8PBb8XZct0MYQT8JHbx/EcbGC2otjEnIsNLzXg06OA82T
         PXxg==
X-Gm-Message-State: AOAM530x9bnK4JsdTa6y3khXsXORe0mA+oCZo53rEUtQWvoW6xI0bs7T
	P96Mat+wUEsTIBLGKXY1hkWYRg==
X-Google-Smtp-Source: ABdhPJyYP0IgLNF93k8XzGWSV1GiqYmVaNdFh3fA78CzR2WDJIWanoGTUugG7akdXFQy5upFhsdsRw==
X-Received: by 2002:a5d:4e87:: with SMTP id e7mr7999093wru.427.1590573670407;
        Wed, 27 May 2020 03:01:10 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id k17sm885312wrl.54.2020.05.27.03.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 03:01:09 -0700 (PDT)
Message-ID: <924d7c6ed6219405d6ce1c52825f9e636bfd8608.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Question about recursive dependencies
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Jacob Kroon <jacob.kroon@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Wed, 27 May 2020 11:01:08 +0100
In-Reply-To: <73eb04e4-ad0b-3738-fb82-39720a68e26c@gmail.com>
References: <73eb04e4-ad0b-3738-fb82-39720a68e26c@gmail.com>
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2020-05-27 at 09:11 +0200, Jacob Kroon wrote:
> Hi,
> 
> After many reading attempts I have to admit I still don't understand the 
> last section of
> 
> https://www.yoctoproject.org/docs/latest/bitbake-user-manual/bitbake-user-manual.html#recursive-dependencies
> 
> <quote>
> You might want to not only have BitBake look for dependencies of those 
> tasks, but also have BitBake look for build-time and runtime 
> dependencies of the dependent tasks as well. If that is the case, you 
> need to reference the task name itself in the task list:
> 
>       do_a[recrdeptask] = "do_a do_b"
> </quote>
> 
> The text before would suggest this means that
> 
> "do_a" and "do_b" in the current recipe, plus "do_a" and "do_b" in all 
> its build-time/runtime/inter-task dependencies, recursively, must run 
> before the recipe's "do_a" can run. That would mean "do_a" in the 
> current recipe depends on itself. What am I not getting here ?

It does mean that but bitbake will just skip a task depending on itself
in this context as that doesn't make any sense.

We used to have that issue a lot, I can only spot one example of it in
use now in a quick glance at OE-Core, thankfully.

Cheers,

Richard

