Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by mail.openembedded.org (Postfix) with ESMTP id A98CA71CBD
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 23 Apr 2019 13:58:46 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id h4so20345690wre.7
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 23 Apr 2019 06:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:user-agent:mime-version:content-transfer-encoding;
	bh=UI/Q1YS1QEC5/6ecTcYHPLhaibQc2gmdyhWKZWM9p68=;
	b=hGHPsh2wOYi5Sjd2jinT3fEee7rk1u/FJheqH9weuusL99+Xwjq+zz8INJif4z/ePj
	WoeURS3TkbsKIILZHsKoyvBwnt0WogKyC5qLpaOUXdheuDJL6DW009zlLfWU0JI5YWTw
	Ab9PgxXb1How6yNyZT220EBYkeFUtr2o4iPoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=UI/Q1YS1QEC5/6ecTcYHPLhaibQc2gmdyhWKZWM9p68=;
	b=F4H5mkMXO1yqHvicVg4E7Pj+/tUMqXRKGmpiuznsg+KeeKn2udl/fCoasME5G0L7rJ
	Z2zslqE8+Sb4JHpvhXgBN6IjJEixMKJ8VJ3QwXLREmXQoK9I0K6LT0FXz2gzoMZCtWUF
	5rNaIkPQPkV6/bPK/5+bAH6gWo5VdMpj0qYyv+2GJLhwZwkITCx9f6bKxOmBk5Gj4QHL
	iuVq65n9Qra9vMdeUDEqt2qCUi6YpkqUH5P/ouMebRd8w96KDU1z/vWHTS5h/Dlzz2Z8
	4/Wl6NMe/xP3OmrHGQsZCp44esIWEYneraCjDEX7tkvIi7G3E84+hvogyN46yzBET8wF
	D6ZQ==
X-Gm-Message-State: APjAAAUXzyAn16vh7z21/49Yd7ck82SG8U8XFH+7w7OTj6S59ZpWs0el
	KxHpA7MPvDziieY3LxqO6caySA==
X-Google-Smtp-Source: APXvYqxNG0JMdvVuIhlxAer6hLsCS9NtxWMf+g0t8hjlU4jE8ZN+HVsQO4q529sZsS2qjZxhzqhr9g==
X-Received: by 2002:adf:f608:: with SMTP id t8mr6688755wrp.304.1556027927414; 
	Tue, 23 Apr 2019 06:58:47 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id d6sm3492971wrf.63.2019.04.23.06.58.46
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 23 Apr 2019 06:58:46 -0700 (PDT)
Message-ID: <8655ad4f72ebb29e080a3e3802a5f04d9c43ba4c.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>, "Burton, Ross"
	<ross.burton@intel.com>
Date: Tue, 23 Apr 2019 14:58:44 +0100
In-Reply-To: <190b82dc-9ee7-2ea6-6b1a-bf1aecdfaa08@windriver.com>
References: <cover.1556005325.git.liezhi.yang@windriver.com>
	<26bea95ed677fdf7d4c18f80e1e34ffb7c9fa364.1556005325.git.liezhi.yang@windriver.com>
	<190b82dc-9ee7-2ea6-6b1a-bf1aecdfaa08@windriver.com>
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] wget.py: Print warning when checkstatus() failed
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
X-List-Received-Date: Tue, 23 Apr 2019 13:58:46 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2019-04-23 at 15:53 +0800, Robert Yang wrote:
> Hi Ross,
> 
> On 4/23/19 3:43 PM, Robert Yang wrote:
> > This makes it easier to debug, for example, when I ran:
> > 
> > $ bitbake-selftest bb.tests.fetch.FetchCheckStatusTest
> > 
> > It said failed:
> > FAIL: test_wget_checkstatus_connection_cache
> > (bb.tests.fetch.FetchCheckStatusTest) (url='
> > ftp://sourceware.org/pub/libffi/libffi-1.20.tar.gz')
> > 
> > But didn't know the reason, this warning message can help me find
> > that
> > something is wrong with my ftp settings (I set a wrong proxy for
> > ftp).
> > 
> > Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> > ---
> >   bitbake/lib/bb/fetch2/wget.py | 5 ++---
> >   1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/bitbake/lib/bb/fetch2/wget.py
> > b/bitbake/lib/bb/fetch2/wget.py
> > index 3bb3e3b..ffcd40a 100644
> > --- a/bitbake/lib/bb/fetch2/wget.py
> > +++ b/bitbake/lib/bb/fetch2/wget.py
> > @@ -216,7 +216,7 @@ class Wget(FetchMethod):
> >                           # Apparently urllib then uses the file
> > descriptor, expecting it to be
> >                           # connected, when in reality the
> > connection is already gone.
> >                           # We let the request fail and expect it
> > to be
> > -                        # tried once more ("try_again" in
> > check_status()),
> > +                        # tried once more ("try_again" in
> > checkstatus()),
> >                           # with the dead connection removed from
> > the cache.
> >                           # If it still fails, we give up, which
> > can happend for bad
> >                           # HTTP proxy settings.
> > @@ -338,8 +338,7 @@ class Wget(FetchMethod):
> >                   logger.debug(2, "checkstatus: trying again")
> >                   return self.checkstatus(fetch, ud, d, False)
> >               else:
> > -                # debug for now to avoid spamming the logs in e.g.
> > remote sstate searches
> > -                logger.debug(2, "checkstatus() urlopen failed: %s"
> > % e)
> 
> You added these comments in the past, is the "spamming" still an
> issue, please?
> Or how can I reproduce it?

Set a remote (http) sstate mirror which doesn't exist and then try a
core-image-sato-sdk with no local sstate?

Cheers,

Richard


