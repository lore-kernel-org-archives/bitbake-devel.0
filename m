Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web12.4230.1592908250234802350
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 23 Jun 2020 03:30:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=evGK0I87;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id q15so839204wmj.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 23 Jun 2020 03:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=5yDv5zH82uhWFE6WuVAU0BPSawwfbA33wqaENrsWhv0=;
        b=evGK0I873cbFGmRmk2pJ2xVgRFb/OlW47Tc9aSXV1nCtevhI0W71uKnAMa8MCtS4er
         3LE2tJuH1Pcp0PWKYzGt+GftopZeE95DhSp+ci75Bf7JvZ39gxOTtdOGImzbrww2OjNu
         OMr0dyh28K6/g2rz2mT9yJ0Xbx6pJ3fAM3niA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=5yDv5zH82uhWFE6WuVAU0BPSawwfbA33wqaENrsWhv0=;
        b=EOp91TMSVMZBLX5TeM3/2rnyVlX4Or74nfVWfYui+pWh/7LSMGC/apRrN41TKEJMGk
         UILlS+lQ+Xw99jtzgdWujbW6eEPQr99QMilZdkmwHZfAlJag4Q5DSnACClyBPqMvYN6h
         EbBji1W6p7g4ipOzYhKD00XP/9ZIhM6vfE5sOHkdrHkjKQo3dlNdTgIK/a83idYR/dN2
         7Ubvwb6mnjbcP46bQQjf9BPOwXyDVFB7zuy3ue3dbKQhe8bQKird5h43HdTSQyb12Ktd
         IdLWSpLfPvMWObwifUhIyiJ5qMycJhRsupZ1rEyv4lTkvhecqTmNuKads/3V2iVUXdV/
         cIbA==
X-Gm-Message-State: AOAM531Ip1HdnR/13iJGOowTvi0vFdx6Jm5C8NirkYR7Zohuzspl7v1L
	3fUcRSSOzZMVXsVYQz5odu1e4g==
X-Google-Smtp-Source: ABdhPJxSP8nQrbCfjz9FEzsAduStNSGgGZeREBePnaf+iWWXcMRLL6X5mbEIb1vwEVwN/5GhdNYL/g==
X-Received: by 2002:a1c:b6c3:: with SMTP id g186mr7274716wmf.135.1592908248622;
        Tue, 23 Jun 2020 03:30:48 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id u15sm15604587wrm.64.2020.06.23.03.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 03:30:47 -0700 (PDT)
Message-ID: <71e1f67d0dd3930421e91fc2d8bb5c28b7103c17.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [fetcher2] perforce fetcher download dir
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Alexandru Onea <onea.alex@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Tue, 23 Jun 2020 11:30:46 +0100
In-Reply-To: <CAJgSc4zUtVEXmETMWZh58Uw-dPZ7QUiWHXC-Jrhok4fAFJz7ww@mail.gmail.com>
References: 
	<CAJgSc4zktj90d5DXXoSa8vE8=F58puwKD0YKUTMA0etGn3U=XQ@mail.gmail.com>
	 <aa5431eddbc52496d0cc0a2a848489dad6fd0d01.camel@linuxfoundation.org>
	 <CAJgSc4zUtVEXmETMWZh58Uw-dPZ7QUiWHXC-Jrhok4fAFJz7ww@mail.gmail.com>
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2020-06-23 at 09:40 +0300, Alexandru Onea wrote:
> Indeed, there is an overlap between the "destdir" option introduced
> by the patch and the "subdir" option of the unpack. Their behavior is
> only slightly different but the subdir option can be used to achieve
> the same result. I will drop the "destdir" option. The other options
> do not have any overlap with existing unpack functionality.

That was what I suspected and its good to have only one API for doing
things where we can!

> I will prepare a new version of the patch including
> updated documentation.

The new patches look good, I've queued for testing, thanks.

Cheers,

Richard

