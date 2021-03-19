Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web08.897.1616176927993503179
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Mar 2021 11:02:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=dBy653pQ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id k8so9977218wrc.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 19 Mar 2021 11:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=klHFPKJBrzo+FgJyLTLXw4IodFNQTsfa+Vk2Q6TNygE=;
        b=dBy653pQlmzjw1FWCOmMEuFo8mh22Ei5HDkMZx+po88WhnJPW4fvde6mLX9VjBKd2F
         ZIKVfmRiV6UzHgcRB2J/xn3Kp4FjOjUUpNojAG+HvaJmqkzfbYV17uMiIruJBG5EO9+6
         NotpqcXGyOR2B/f96TpqtvquRswM+62nkXmlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=klHFPKJBrzo+FgJyLTLXw4IodFNQTsfa+Vk2Q6TNygE=;
        b=mboU2aHD0rMcFIPR7oYNbtldiWSj+n6AdwXLuC3kCcYQEHyDfeTmOdY1qixoSSmx4P
         41ta+Paw+DyI2hxfTBARVpf0v8IQtm/hry/y48wk9Noa/9sKtl9badPXguThTbwdHxKl
         R7s1GSZDVVlaw940ZONMfIxuR0+571QulCw8g2lYCJoqzDWHzM5yD3CzqqLGff7m+n0/
         Ta+hz+GGFAf56FRtzCbzEQEyZ6GIGtCcYNa+uzF424g6QwtXUxvWlz1Viq5msCrOD2Yp
         BXdV58jp6SxnzmO42oYFwpbl4Zv8bUNGJqEcQXeYaoH+LOOzvT4bXKgtk0Zv1oKnG0wl
         96+Q==
X-Gm-Message-State: AOAM532IATfKBYoAx7PC7bKeEddAKJ/F5Rl2kHk2X1wuAYZ2eqzeftNF
	OkXsHnSlu2YMTU4cIC6hg1LJJbs/A/L+eg==
X-Google-Smtp-Source: ABdhPJyipdeOsR06PyytFDJNRDg/SWQhA6I+gV+24eSOMYY6J4NUA/BRTKG46BtYws3aNQDt8nExgw==
X-Received: by 2002:a5d:628c:: with SMTP id k12mr5706199wru.316.1616176926388;
        Fri, 19 Mar 2021 11:02:06 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:5808:8e52:d330:3893? ([2001:8b0:aba:5f3c:5808:8e52:d330:3893])
        by smtp.gmail.com with ESMTPSA id 9sm7251700wmf.13.2021.03.19.11.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 11:02:05 -0700 (PDT)
Message-ID: <60ba2039bd9e47638e9bd5d467a4ee151a4b5a9d.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/2] build: Add file_stale_stamps function
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc: bitbake-devel@lists.openembedded.org
Date: Fri, 19 Mar 2021 18:02:05 +0000
In-Reply-To: <6398f1e1-5ac-e659-a468-9fa73fdbdd66@crashcourse.ca>
References: <20210319173012.229109-1-richard.purdie@linuxfoundation.org>
	 <6398f1e1-5ac-e659-a468-9fa73fdbdd66@crashcourse.ca>
User-Agent: Evolution 3.39.2-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Fri, 2021-03-19 at 13:47 -0400, Robert P. J. Day wrote:
> On Fri, 19 Mar 2021, Richard Purdie wrote:
> 
> > Add a new function which compares the stamp filename we want (including
> > taskhash) with what is in the stamp directory (using the clean mask).
> > This tells us which stamp files are stale and are due to be rerun.
> > 
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
> >  lib/bb/build.py | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/lib/bb/build.py b/lib/bb/build.py
> > index f4f897e41a..b2715fc530 100644
> > --- a/lib/bb/build.py
> > +++ b/lib/bb/build.py
> > @@ -854,6 +854,23 @@ def make_stamp(task, d, file_name = None):
> >          file_name = d.getVar('BB_FILENAME')
> >          bb.parse.siggen.dump_sigtask(file_name, task, stampbase, True)
> > 
> > +def find_stale_stamps(task, d, file_name=None):
> 
>   subject does not match function name.

Fixed, thanks.

Richard

