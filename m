Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
	[209.85.128.68])
	by mail.openembedded.org (Postfix) with ESMTP id 054D17FAC4
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Nov 2019 21:22:43 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id g206so5058905wme.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Nov 2019 13:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=09LQsMpMkDvThfyomuCelwaUcDZY/cBxCCuXUUkRTAQ=;
	b=Bf0ex/rCB+Bax6e9DYJGjan1aGHoqDKmxpG63b4FA1VqmUdHcms4Jha0my2TOT+L09
	alMAEL4OVcKR9Fl9EbVembSnjtACKJT3py/w7aWNU2JGHeYaDopkTmVRnMpHOkotua5X
	N6xoclo3sU6izUeYgJfJfbJlWlLwcj8u0G1z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=09LQsMpMkDvThfyomuCelwaUcDZY/cBxCCuXUUkRTAQ=;
	b=FtDZHxzP4tIWoDhEudBeENCxXRUr+pyHp11ux6wTuAwZf32+CaxHcMNHs0PaURGVob
	jt8X9NY91z4Sf+0k1PKkSgmU2z+11UE8GT4o4j2L6/tdh3ixhr0F/0pF5DbA45FCdHE+
	6DKgNtnO5yB+zZjWQfUcnEJklj0Jo5yIiXoGBIvh9lUxnflTokeMB5zpZX4XqlONU+Xx
	AcULOIWUs4BiKM+SuQ+Plk0PuysdnmIUX66G8xRf9GlKQJLmVX18ZjVbklh7+LPgmrWo
	ABQvU3w6McwLKfxCFRwNnqfMNxr+54Stt2Vp2obq931kkNw0XJV7fwVzZzMSO0eE+624
	GewA==
X-Gm-Message-State: APjAAAVRskSr19AXOCv6pGEWv+2IUHoQm5iMweQuESZAGDJKz4qEdlZj
	kZXw3JFXvImDDUATYIZZtreZu+Euk8k=
X-Google-Smtp-Source: APXvYqxpZJZaCT+KUApD7d/2CEgRJfUo2rJNFSdRc6CjHodvU6xEO9kjKNi1WdiAwN0EljiQaUbfCA==
X-Received: by 2002:a1c:41c2:: with SMTP id o185mr12026052wma.34.1574371364400;
	Thu, 21 Nov 2019 13:22:44 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id y6sm4937757wrw.6.2019.11.21.13.22.43
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 21 Nov 2019 13:22:43 -0800 (PST)
Message-ID: <cf0385b2fe6d1cf79f514f24339475ec18ef90fc.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 21 Nov 2019 21:22:42 +0000
In-Reply-To: <20191121205415.25946-1-richard.purdie@linuxfoundation.org>
References: <20191121205415.25946-1-richard.purdie@linuxfoundation.org>
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Subject: Re: [PATCH 1/5] opkg: Add upstream fixes for empty packages
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
X-List-Received-Date: Thu, 21 Nov 2019 21:22:44 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2019-11-21 at 20:54 +0000, Richard Purdie wrote:
> An ipk with a zero size data.tar file caused opkg to crash with a
> double free abort. Add the upstream fixes for this.
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

Resent to OE-Core, sorry about the noise.

Cheers,

Richard


