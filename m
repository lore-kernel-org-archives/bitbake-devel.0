Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
	[209.85.128.51])
	by mail.openembedded.org (Postfix) with ESMTP id CB9327E949
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Jun 2019 15:58:05 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id u8so3842314wmm.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Jun 2019 08:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=1Fh3PXvQdyrLMNscAHhoe+wUqNazq8WbWXb8Z7uhbL8=;
	b=OitF9Oo1EwVUfJF9q04zcfWUEtnrNJZ9Q2oVBectQb5qar4pWzpbQ9UkqkFjWzF9XH
	7uwXxNpEApnAiMl490hB6jhuac2D5J6EKWyDXmxHbg2SvaVpV57VW6zM5rJX50oWkbGm
	361S4waEylpA7mqmlLTDTjJ0R8jzN3uO38CpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=1Fh3PXvQdyrLMNscAHhoe+wUqNazq8WbWXb8Z7uhbL8=;
	b=BWwom9Hu6lMgoHqrDaMcCFJ9BoDLmkI3+QVeE9Y9ECdJ3yUDoJkkuOoo47Fg7jHq8k
	a/clcew+ttRmHKMvKYHcm2frB/8f2U3BtrfCbzid8ymxXGMz+u/wmSfkxdo2Ydhm8Ccp
	9xqtKgCcQGnAmO/96Hh9kuuPh4SfVoq85NpIjCtcUjRJZNajLbcCL6GJ5qGXNLYkcT7/
	mY8QkSELAj3ZVRVrKQ/wuCtlr9s7+gvqxF4L3MA6XxdUm4oO+luSb5rK9WWbISlzaXmx
	exZY1tx0JI++VFmgiSD5jA8sthtKCGXRAGGRF412cEMlb8YL6ukGakOF3wCNJmTQwe6p
	cMIQ==
X-Gm-Message-State: APjAAAUvDl+ZCH1gj7ax4VhRf5kajP8IEUoYdveZk0nr9yrY+fVlCwVI
	ELhIY89g3A3EvgiJPp0UglupaNNLeHE=
X-Google-Smtp-Source: APXvYqzUu0rV1tuLRq4p/VxSTQpGovsfjd89QFUFOL6skm5y6BPJQ6+mIDBL50IbH3P8/TSeD4Tegg==
X-Received: by 2002:a1c:e0c4:: with SMTP id x187mr4097729wmg.177.1560873486528;
	Tue, 18 Jun 2019 08:58:06 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	l19sm1721748wmj.33.2019.06.18.08.58.05
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Tue, 18 Jun 2019 08:58:05 -0700 (PDT)
Message-ID: <d770ec48cbf5abb2adae2bb8454809c00e92da3d.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Oleksandr Kravchuk <open.source@oleksandr-kravchuk.com>, 
	bitbake-devel@lists.openembedded.org
Date: Tue, 18 Jun 2019 16:58:04 +0100
In-Reply-To: <f13ae5e7-a356-f42e-0efc-020f5ee29cb0@oleksandr-kravchuk.com>
References: <20190614000925.12048-1-open.source@oleksandr-kravchuk.com>
	<f13ae5e7-a356-f42e-0efc-020f5ee29cb0@oleksandr-kravchuk.com>
User-Agent: Evolution 3.32.2-1 
MIME-Version: 1.0
Subject: Re: [PATCH] bitbake: cooker: list all nonexistent bblayer directories
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
X-List-Received-Date: Tue, 18 Jun 2019 15:58:06 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2019-06-14 at 02:09 +0200, Oleksandr Kravchuk wrote:
> This is how log will look like:
> 
> ERROR: Unable to start bitbake server (None)
> ERROR: Server log for this session
> (/home/sashko/projects/yocto/open-embedded/build/bitbake-
> cookerdaemon.log):
> --- Starting bitbake server pid 11745 at 2019-06-14 02:08:15.687299
> ---
> ERROR: The following layer directories do not exist:
> ERROR:    /home/sashko/projects/yocto/open-
> embedded/sources/poky/meta-abc
> ERROR:    /home/sashko/projects/yocto/open-
> embedded/sources/poky/meta-xyz
> ERROR: Please check BBLAYERS in
> /home/sashko/projects/yocto/open-embedded/build/conf/bblayers.conf

Looks good to me, I've merged this thanks!

Cheers,

Richard


