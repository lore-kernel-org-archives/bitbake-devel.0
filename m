Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web10.3581.1588665171475338256
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 May 2020 00:52:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=DucOBHdw;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id y4so1262345wrm.11
        for <bitbake-devel@lists.openembedded.org>; Tue, 05 May 2020 00:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=s85HhoO1yOHBzL/qMiiIyGVSPgBVJ8NToJ3bOXCjQNk=;
        b=DucOBHdw1iqOHcGZvRbptxWW7Ko4Xq1Ko6dFk2cqlAupKZq6iOBo0VdkQXkNxXBJAg
         dZf5ckUFrW6CHraiqWVI5N/OuDH/Qad4KKhg7ksZbofbihl9ImW+Mgs19FTdNOf67cEX
         bH/Ao7icIRw3e477xHfdb3O76Y768zJdccbR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=s85HhoO1yOHBzL/qMiiIyGVSPgBVJ8NToJ3bOXCjQNk=;
        b=HL4JFMUY5lb1jWfRzm9xD3ymVkUfQ8NA/ArXNgML7+t/d4bHhjF1hgsst05EGdz5+T
         e6bE21r5MeV/I3wkf63sE5NscIV4E9MIIrMOdHHxeU83mzA11DnNnaej1KbMrWh/75OT
         cnWquW8n428b1gisCk7ewG/Kunh9cSjq3xSCGy1bn7gqlZvQcpkFvGrAx2db7URrF2DG
         GmDxuitQDa93GxrnskT79Z/7P+5m/D0em+0mwpaeLuwLAZvHaNhcLEZHgSg6TcBqwhDX
         i/wsmjNpFzFVTchZFyiQBVd6104i85VtV9I7YHavDCc1pdtLm9fBegeynZYI8bvOA7Wp
         usXA==
X-Gm-Message-State: AGi0PuaQEat2ofEJ59DmAj/kk9ItEnELAXnfXWi9qGiyFpAOwqEP2wxC
	f20ro8n83TZrcpSq+igytDml636YQwQ=
X-Google-Smtp-Source: APiQypLG6wkxYgTr887dwQVK/o4MQuTcD3Gn9KpUJGXIureieBhLZF9lsd2DCJkc3alyqh5VqDLmcA==
X-Received: by 2002:adf:e88d:: with SMTP id d13mr2069008wrm.375.1588665169365;
        Tue, 05 May 2020 00:52:49 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id t67sm2697561wmg.40.2020.05.05.00.52.47
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 00:52:48 -0700 (PDT)
Message-ID: <6be4fcfc33a1e247a65c4c4a8dcef7d2d5a154f5.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] "-b" option doesn't need the full filename, correct?
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 05 May 2020 08:52:46 +0100
In-Reply-To: <alpine.LFD.2.21.2005040621420.6368@localhost.localdomain>
References: <alpine.LFD.2.21.2005040621420.6368@localhost.localdomain>
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2020-05-04 at 06:26 -0400, Robert P. J. Day wrote:
>   currently poring over BB user manual and noticed that the
> explanation of "-b" strongly implies that the argument for this
> option
> must be the full recipe filename, such as strace_5.5.bb, but it seems
> to work fine with just:
> 
>   $ bitbake -b strace
> 
> is that deliberate or accidental or an unintentional side effect that
> should be discouraged?

It does pattern matching so it only works like that if strace is unique
to a single filename. Try "gcc" ;-)

Cheers,

Richard

