Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web08.12209.1618931580025897376
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Apr 2021 08:13:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@burtonini-com.20150623.gappssmtp.com header.s=20150623 header.b=uAVvAHsQ;
 spf=pass (domain: burtonini.com, ip: 209.85.221.42, mailfrom: ross@burtonini.com)
Received: by mail-wr1-f42.google.com with SMTP id e7so29032030wrs.11
        for <bitbake-devel@lists.openembedded.org>; Tue, 20 Apr 2021 08:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=burtonini-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eCkqeeuEwSymxqN1AXeKG0SJOQvu94Jlz06eH7qLkcs=;
        b=uAVvAHsQR0CgPaFxMsR3I4Kms/s7iRZW8xfMLWPnzJ1zrheH6X2LNDF7IuYygryXS3
         61zKhlRhJ5B/U7WEcjFSLpwL1vgZogbB7dqqU54c8guUah0jSRR6pbc+M1iBplBvyrbw
         S2+HrgsI0oAyBWPFMG8+y56Ngu6IePQlIC0kv/eYyGTuHLRst74eCs9Gp2mlOHNoQhCw
         BImOMJywNi0x6sm7oi6hau+H3hqrJIDUBA6qMxMHluOKA9O0Xxtq2PKbOq7PH9kY6wY6
         W9gH2WKye9PiAl4c5e68EaT2fU9DW0YGpaAKAWOdm0frkUWHnDS9G/cRtKotSkHEm8n/
         12Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eCkqeeuEwSymxqN1AXeKG0SJOQvu94Jlz06eH7qLkcs=;
        b=tOy4jf5nrkOiX1Uoo8kez8DTohL8Y8ore7isaZwDJll7XorJOfbHZX1aqvjiHDUJAH
         wm4IeNYVlQUmFtPM0tYxZiwSbEa65+8JUqs2Izt9Zsqie5Qdy8ejLqdaRuuMNtQrED/2
         b66whJVckp2sZwYkK3bqygOAvf3FbpazU/Pn1wGSs6xXN8c2KoCkQtZQAoXc8/QHhLZk
         xqd2KIn9g9iARcQ+pRJIkh/x+QaHA9S/ESNGOIPl9FoYBWuGvXqyAk5BmRc6OljxAGe7
         CcWLpsDl1717rhVo7WkkhnIxCT2ieICiK2+m1Hlq0zdNstw3RoOMs4HmM9Tayg8jTVCv
         TrvQ==
X-Gm-Message-State: AOAM5302pvwKFPXMLQ7Gtd+sWQpfvFSZhwRYJWtG7TUbXEKY135srvYZ
	JtyNOvv3lSirbu4tKVyVbXgxPzebV974GqcJgC0lnQ==
X-Google-Smtp-Source: ABdhPJzwBI5aSjiEedkuNUkSHnHtFsKUIfBL3U6ni5msa0YKtDZD8oYNPwpgi5yKjtqptiJmAB4/OBRKvLwVX5Tk4bQ=
X-Received: by 2002:a05:6000:186d:: with SMTP id d13mr21303818wri.199.1618931578478;
 Tue, 20 Apr 2021 08:12:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210416171126.1373752-1-richard.purdie@linuxfoundation.org>
 <20210416171126.1373752-2-richard.purdie@linuxfoundation.org> <7360338.lvqk35OSZv@linc>
In-Reply-To: <7360338.lvqk35OSZv@linc>
From: "Ross Burton" <ross@burtonini.com>
Date: Tue, 20 Apr 2021 16:12:47 +0100
Message-ID: <CAAnfSTtmem2RPej+YDJcUt3pyKHmU+VAjCvmRwo-ug7fmyzqOA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 2/2] bin/bitbake-getvar: Add a new command to query a variable value (with history)
To: Paul Eggleton <bluelightning@bluelightning.org>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Apr 2021 at 22:36, Paul Eggleton
<bluelightning@bluelightning.org> wrote:
> This is great, I have wanted to see this for quite a while! About the only
> feedback would be to add a short option for  --value, though I wonder if -v is
> the best option to choose or not given that it's typically short for "verbose"
> with most tools.

-V would be an alternative but I don't think this is a great problem.

Ross
