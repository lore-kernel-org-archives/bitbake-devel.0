Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail.openembedded.org (Postfix) with ESMTP id 56B737EC95
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  2 Nov 2019 20:43:10 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id b3so7167219wrs.13
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 02 Nov 2019 13:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=FeZNLETFyWFINOhik/aOSecU2KVAlOFhnZmpOJinK7k=;
	b=NXGgvpCKOnPFt4LfXbR62gcAugFyc0dJyreH1T4jEDdgBPJxinKF3rP5ZFC83TDy6R
	/f8KfisWSWVrciGu9s3WnSuh59Cd/HG9W+0xOAUql/8WBd3cG9KMcZBgePtxaxmysoFW
	c9Wq5+kPRJnagV5Lnjv/gw44CkPm+NOPa9qjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=FeZNLETFyWFINOhik/aOSecU2KVAlOFhnZmpOJinK7k=;
	b=qh+CNpNqiTzvy5XrQCZdj1TgP/fMsMTpafAsRLgiJ1tbzPrfzUpiYML8pAwhBF+9Ny
	0hWGdqOUuy45sPNpMr4hwzkJPvAlmwo4tQlrqol1RStj8OdZpOCM1aXPZKHCivZ7uiUa
	8nEICgV3YFd7Gb2rCHs2SKaXP8QLq+IbDZioWc3MYzyWXdF7wA/RkTNln5QbKDbTS4OS
	jzQ+7CzZhxs2T9OPD8Qw1t5ffvEblgsQJy1dwjxlSisRc9uEjE0YB2oGXTeyEOs3B+Yk
	06IiXttQ+87czbRRYk8j+zX6bHixicdSC1pJj3tZv1IJifBGUHCQ2NXHDAktJ4jmkaFW
	4fIA==
X-Gm-Message-State: APjAAAXO8n0q+V8hl1nuhSZELA4h8cawEpkKZHjNdi40C1w1M68QB1IP
	l+sZy3mYhonxPqKnRaSIGAtmQ7VpxKxe0A==
X-Google-Smtp-Source: APXvYqzwD6STJS2PjNvNVmrs2AJRsChUhZ/cRYzN0tFMy7ZzbSanL79fFEpGqkGJrkTyh2o8lVX+Tw==
X-Received: by 2002:adf:dc03:: with SMTP id t3mr15617564wri.95.1572727390874; 
	Sat, 02 Nov 2019 13:43:10 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id r3sm12243882wmh.9.2019.11.02.13.43.09
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Sat, 02 Nov 2019 13:43:10 -0700 (PDT)
Message-ID: <5375964a726a0a4790c99137a52227a66e09b243.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Chris Laplante <chris.laplante@agilent.com>, 
	bitbake-devel@lists.openembedded.org
Date: Sat, 02 Nov 2019 20:43:08 +0000
In-Reply-To: <1572543354-4229-1-git-send-email-chris.laplante@agilent.com>
References: <1572543354-4229-1-git-send-email-chris.laplante@agilent.com>
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Subject: Re: [PATCH] bitbake: command: add getOverrideData command
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Sat, 02 Nov 2019 20:43:10 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2019-10-31 at 13:35 -0400, Chris Laplante via bitbake-devel
wrote:
> While working on a script using tinfoil, I needed a way to access the
> overridedata for a given variable. Unfortunately, I found that
> data_smart does not have remotedata proxying for it.
> 
> By adding the getOverrideData command, I am able to use a method like
> this to access override data (either for a particular var, or all
> data):
> 
> def get_override_data(d, var=None):
>     if "_remote_data" in d:
>         connector = d["_remote_data"]  # type:
> bb.tinfoil.TinfoilDataStoreConnector
>         return connector.getOverrideData(var)
> 
>     if var:
>         return d.overridedata[var]
>     return d.overridedata
> 
> Signed-off-by: Chris Laplante <chris.laplante@agilent.com>

The question here is what is the usecase?

The override data in this form is really a datastore internal and
shouldn't be something we expose an external API for. It happens to
exist in this form for the current implementation of the datastore but
it didn't used to and may not again, depending on how we change that
implementation, particularly as people look at parsing performance.

Cheers,

Richard


