Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web11.217.1592948394087522174
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 23 Jun 2020 14:39:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ArOb8Z2n;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id o8so230124wmh.4
        for <bitbake-devel@lists.openembedded.org>; Tue, 23 Jun 2020 14:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=GkhIGGOraEnhH62g37TH3GG29vhUly6GlELoDNnPSK8=;
        b=ArOb8Z2neKxFhudPbXiTh6+kaXTGToN+Lzc11Vxz8t8nAVYX7JOK6/rgNXt7j2iwo1
         NCx83sG6TuQ2ogCBPqCoIXIs7uhd4DOmTJ9cFE+Go0muvqlT07LrT1AY9JQfXQH7YECW
         eWOhGZy38bxWbeRXUx3HlTt8YdHykValbMwHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=GkhIGGOraEnhH62g37TH3GG29vhUly6GlELoDNnPSK8=;
        b=ODoRHAyvwaqqJrAfVh44QH/ChfeQb0oO8Q+ubl9o9g+DXM+VEoZYp0+FxqtIoz+K4U
         jut5dy9MXM/hP22JV1+vsVf1nvMP1T3vkUs2H/KIkxI2pGutYIF3IB4MYu6EkOvRz4Gd
         s8WxOwCZbEECPgNe8M6SZDKWIUwz+TMg7/xWGKHJEg3NxhvBuU7KyT4/LZfDfEeAZ7Pq
         XkKeHXpqVjAmhcKcgxBgSFNv8AeIPK9zjf+PIDWRKr47ex9ZabDyuusDToHPKnB6O7Tb
         yn0AkUKmkaATLYgUbAjaJz/diOiy+SqHNoOjpbKXyiZ8CjwODb+MLI0thM7iz5NHd5/g
         2QmQ==
X-Gm-Message-State: AOAM5312jGpAhjbDDxzoYBp01QFlQtOJYfSwK4HsaJf+C92TpXLMOGXW
	R+GN1537dqAOL6LVoMcBiOL51s0siJnXKw==
X-Google-Smtp-Source: ABdhPJzLQcihAc0KiwwxBn6TSeqQD2mlgzd93AS0EELniyCL4EaWdTzuQSXvxl6qr8dJEJ0tCy8MqQ==
X-Received: by 2002:a1c:9687:: with SMTP id y129mr26212378wmd.30.1592948392555;
        Tue, 23 Jun 2020 14:39:52 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id 33sm18046734wri.16.2020.06.23.14.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 14:39:52 -0700 (PDT)
Message-ID: <9dd0bf86fa5a2b601a0fb942dcd2cea6c14be93c.camel@linuxfoundation.org>
Subject: Anyone using regex in ASSUME_PROVIDED?
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: openembedded-architecture
	 <openembedded-architecture@lists.openembedded.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 23 Jun 2020 22:39:50 +0100
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi,

Back in 2009, regex support was added in ASSUME_PROVIDED:
https://git.openembedded.org/bitbake/commit/lib/bb/taskdata.py?id=efb0474231ed286073a5a5904094320da8cab28d

Looking at this now, I'm thinking its a bad idea.

https://bugzilla.yoctoproject.org/show_bug.cgi?id=13893

shows that adding:

DEPENDS += "texinfo-nativejunk-that-does-not-exist"

gives no errors at all.

The code can't know whether a given entry in ASSUME_PROVIDED is a regex
or not.

Plan B is that we test for anchors in the string and only treat as a
regex if they're present.

I'm wondering if we can remove this code entirely though.

Does anyone use regexs in ASSUME_PROVIDED?

Cheers,

Richard

