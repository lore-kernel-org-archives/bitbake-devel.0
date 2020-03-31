Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web12.385.1585694441233675089
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Mar 2020 15:40:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=P0TwiSGG;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id d202so953889wmd.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 31 Mar 2020 15:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=lkMqImgPpGzoyUE9Rn/ySRh58brpl0c/JPx2e31nfCc=;
        b=P0TwiSGGBpbU2+wDFLHFeCamoC6PKLPnCHGitw3eyTtK2x1eG6D6jOtRcCLfDU4+pM
         rOwF3JXtBKiOt1KPe2VZhYOWYoWaTOWXFmfawjURRjTnGrtdkpH/jEKyiYynnpaAD5da
         q+tFe8lzJoYPzu4y71FAMCYPwTWZdsGo716Ww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=lkMqImgPpGzoyUE9Rn/ySRh58brpl0c/JPx2e31nfCc=;
        b=A7Xs8YM+8bwW6CdsED0pFjLqUiP3M08NUwxGBZ/I3Fnmo9SydJrsc0qVaqjiMRnI5I
         0DSj45ZyZgdEAsE7mWGGDg2biin6ltrY7L9TFmlXZeeKwCPUj4hlJIYiithPIGe0vHwA
         0hKA/RrvWRO6f+iJjL8m8xFB2vRdXwUw1pzM5uUw+DenO38oSliIwV8bg0MHsMmDUkFT
         qTfAEkjZIHXNzhDgdJUTqkEDOaiI8LUQP2ccRQUv1GfLjPp6pR8jot56jMij8XYZqS6H
         SX4CQsnnrNwpu6P1/qQ39rk2uUY7Ma6uk4E8PaEsj0Sq4irqRpN40vAq1Yop7gXxSukH
         P7wg==
X-Gm-Message-State: AGi0Pubctugw6isizQfstyTRPFw/hJVsiJlT3Np1z6JaYHsjlfosSlD4
	lIXCu4r0j6S5EI3OvTo95gxqeA==
X-Google-Smtp-Source: APiQypJlb/4rx+kKPEMvctkx8oirgnumUA35V+87vVOoUsJK1qZTg6f/AObYCd/EgoNC4Q6TdXKQzQ==
X-Received: by 2002:a05:600c:24a:: with SMTP id 10mr1091730wmj.98.1585694439632;
        Tue, 31 Mar 2020 15:40:39 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id q9sm233464wrp.84.2020.03.31.15.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 15:40:38 -0700 (PDT)
Message-ID: <d19eee01b70c08e4b66b5c5572677c5d1ba60439.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] subversion authentication "--no-auth-cache"
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: daniel.litschauer@ta.co.at, bitbake-devel@lists.openembedded.org
Date: Tue, 31 Mar 2020 23:40:37 +0100
In-Reply-To: <CwqZ.1585574134967741661.NXjx@lists.openembedded.org>
References: <CwqZ.1585574134967741661.NXjx@lists.openembedded.org>
User-Agent: Evolution 3.36.0-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Mon, 2020-03-30 at 06:15 -0700, daniel.litschauer via
Lists.Openembedded.Org wrote:
> I know variations of this question already popped up a few times, but
> I wasn’t able to find a answer that satisfied my needs.
> 
> Authentication when using subversion can be as easy as typing:
> 
> SRC_URI =
> "svn://myrepos/proj1;module=vip;protocol=http;rev=667;user=user;pswd=
> password"
> As I said easy, but with the drawback that I have to save my username
> and password to a textfile. Subversion usually tries to find client
> credentials in a “GNOME Keyring”, “KDE Wallet”, or “GnuPG Agent”
> service and if there is nothing to find at ~/.subversion/auth. Read
> about it if you are interested.
> 
> But this "system" is blocked by bitbake in the svn.py file. At line
> 78 it states: options.append("--no-auth-cache")
> 
> Is there a reason for this that I am not thinking about? And if there
> is no reason for this would it be possible to add a switch for this?

I did look back in the history but the reasoning isn't clear. In
general it is bad for the system not to be self contained. Accessing
/home/ during a build would make a build hard to reproduce for someone
else.

> SRC_URI =
> "svn://myrepos/proj1;module=vip;protocol=http;rev=667;user=user;use_a
> uth_cache=no"
> Thank you in advance.

I think adding a parameter to enable this would seem reasonable
(leaving the default as is).

Cheers,

Richard

