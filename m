Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE295C433F5
	for <webhook@archiver.kernel.org>; Thu,  3 Mar 2022 11:48:59 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web11.9667.1646308138538421042
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 03 Mar 2022 03:48:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=F80fws82;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id m6so7405652wrr.10
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 03 Mar 2022 03:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=74BXOh2yq8ZRAzd9aS05yP9B+FgisR7j8IK9Ow5TMrk=;
        b=F80fws82IdQ2JmthGPY0cg4rO7kIJtYPMHD49fYaYP/8/46gtqOuyR4siDtBWvU6No
         3cvzVedzgutxiJe3uZSu+XQixclrnXmSTlEa9Iy/aAC/yRZGvf6Wt5IgFfYAMSxCWacY
         TH+V+qrhVB8sveiJjt7GXJB1F2LhcA4ixp7Uw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=74BXOh2yq8ZRAzd9aS05yP9B+FgisR7j8IK9Ow5TMrk=;
        b=YgatZUxYIF30muctW+HpNoalXV41EVmrQC0h73Ii84QzNeIHhkZj84TIINxSrKCi4n
         qFAcBbl00diWGGpSRw4jncytlImmG9qQg59StNG+AFvb63lLhjjbfs9IlTGcqoRuMjSf
         hrgtKZC6lhtm5lJZlGRybhG8Po0zRq1IWbB/ieQrfyMLZYKhyiSPEWFNXrZK4ObzEfP5
         2D2jB68GE8dPhr/N4FPzZsn9nPLY+EcYIZjCfBJavk9RjsZEZxgD+B2f9MzdbJJ+yclC
         rWKcvrt/CZEB72yKoxJUC+nP1qS3XkhBrrOm3iwqm+Dom1RX7JaOBZ4gA2O9HmUaSv5C
         NUBg==
X-Gm-Message-State: AOAM532znBHJ3AaMD0J6UZlDk9h4fZiEt/f8J46i1sstPhvIUyQqUvvu
	RrzDRv6eft0hpo9Hb62MJG13DQ==
X-Google-Smtp-Source: 
 ABdhPJxXqHEnHgKbD7tv9+mkUN4aQQNoxmGfh/DX+WUmi7eQcc5Xi3s1wjfoEsC6kX3sV14mXZhEwg==
X-Received: by 2002:a5d:410c:0:b0:1ef:766b:ef5b with SMTP id
 l12-20020a5d410c000000b001ef766bef5bmr21104292wrp.183.1646308136975;
        Thu, 03 Mar 2022 03:48:56 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:68d0:4b5c:ced3:87b1?
 ([2001:8b0:aba:5f3c:68d0:4b5c:ced3:87b1])
        by smtp.gmail.com with ESMTPSA id
 v12-20020a5d4a4c000000b001e68ba61747sm1889471wrs.16.2022.03.03.03.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 03:48:56 -0800 (PST)
Message-ID: 
 <921ff5f8594eca73d875a223f35f01e09c76161d.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 0/3] fetch2: ssh: fixups and minimal
 checkstatus implementation
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Daniel Wagenknecht <dwagenknecht@emlix.com>,
	bitbake-devel@lists.openembedded.org
Date: Thu, 03 Mar 2022 11:48:54 +0000
In-Reply-To: <20220302195031.2002337-1-dwagenknecht@emlix.com>
References: <20220302195031.2002337-1-dwagenknecht@emlix.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 03 Mar 2022 11:48:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13414

On Wed, 2022-03-02 at 20:50 +0100, Daniel Wagenknecht wrote:
> Hello!
> 
> I recently tried using a sstate mirror accessible to me only via ssh. The
> first two patches fix problems I encountered with the ssh fetcher
> implementation in general, the last patch provides a very basic implementation
> for the checkstatus method needed for sstate mirrors.
> 
> Consider the last patch as a request for comments and feel free to merge the
> first two independently.
> 
> There's been some discussion on sstate mirrors via ssh already. Especially this
> point
> > Performance of that function is key and creating a new ssh connection
> > to check for each sstate artefact may make the build prohibitively
> > slow. There are some connection caching mechanisms present which may
> > help with that.
> Richard makes in https://lists.yoctoproject.org/g/yocto/message/47769 is not
> yet adressed with my implementation. With connection caching configured in my
> workstations ssh config (SSH Options: ControlMaster, ControlPath,
> ControlPersist) the performance was good. For caching the connection inside
> bitbake I'm not sure how to approach this. Technically passing the necessary
> options to each ssh invocation should be trivial, but I'm not sure if it aligns
> with users expectations. I'd probably be suprised if I moved my ssh key (or
> removed the hardware token) and ssh access via bitbake continued to work. How
> is connection caching for other fetchers configured? Do we have a directory
> with sufficiently restrictive permissions for storing the
> cached-connection-access-files (SSH Option: ControlPath)? What are reasonable
> timeouts to use?

I guess the patches are ok in that they don't really break anything and whilst
I'm not convinced about using sstate over ssh but if people want to do that...

For the caching, see the checkstatus code in sstate.bbclass. It is establishing
multiple threads and maintains a connection in each thread which is being reused
for the http request.

I'm not sure how this would be best handled for ssh. As you say, there are some
interesting challenges...

Cheers,

Richard


