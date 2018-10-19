Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by mail.openembedded.org (Postfix) with ESMTP id 8AA0E78CE4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 19 Oct 2018 09:55:34 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id d2-v6so36768651wro.7
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 19 Oct 2018 02:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=X4CVjsL0yul4ZVUbD6RMQwI7WpiJ2740jdWypXmzVIc=;
	b=WyeQEr7FFkIB8HKV7e8b2FVTqRaoCjfpDhJouq7nDzG6+dyto5QpPEboXFJIdj4ZYN
	7+zTM5ZSx6k8Bif4Ft3oKft46yxuxQY+BiMlocWI+M92P/SNqRRxXc4c87AWtGnjXynx
	uEALsqF+QiFNm3EXM7+ED8SN9WREmoX3BtjmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=X4CVjsL0yul4ZVUbD6RMQwI7WpiJ2740jdWypXmzVIc=;
	b=Om5azlhB0zUBAw9B9B/9MlHyz0h32BBF3Y7QkxFli96kjgfeSQHvW56oJyQEmKKuZJ
	A9eeef+2ftqBhhU1oMPyzp2Y45rqad8j/ZZjm3GY1VlsFU0F5aNTGjIV/GFG5UDcUw8H
	9tpkKB04jds/BOyH1AQq5e7QqQAbH3BfHUE+gPnBRqFcw3UuES/IvrqZWWaDJwMRn4ew
	W+UAGM9hVWP1r1ddTygHKiajD52T4ntIhI7fys7Y6NF4uCSBIih5mVTGCjganDU/z0Wl
	XfCph1FrYfc+Xi34aNJa6kyA2ELxR6Re7F2YK4hhuW5wVLVUD9rI1AXEPENxg/9VJzTK
	1CbQ==
X-Gm-Message-State: AGRZ1gKP6OoJTmd3wlDiZdqYc+K5rWrB9W3CkMroG1ANl9XaWmQQOKwQ
	oUZGR3sO+OA8DjZH8Y2tfrIzwTo5u1k=
X-Google-Smtp-Source: AJdET5f+rojvNzbZJmYHMwzKNz5plhxW92caNusxfPZEaeh8hPEg0cSIS+mVQ6NSpYUA1cGIL9KIYg==
X-Received: by 2002:a5d:4cc3:: with SMTP id c3-v6mr6810666wrt.75.1539942934949;
	Fri, 19 Oct 2018 02:55:34 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	y125-v6sm3472381wme.12.2018.10.19.02.55.33
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 19 Oct 2018 02:55:34 -0700 (PDT)
Message-ID: <bb42f42df90ade4c9d601b63162cfccfc92bbf14.camel@linuxfoundation.org>
From: richard.purdie@linuxfoundation.org
To: Martin Jansa <martin.jansa@gmail.com>
Date: Fri, 19 Oct 2018 10:55:32 +0100
In-Reply-To: <CA+chaQdmU3WeTOy6UT3TGm97ucX98tXA=DOD5uTgY=tsB=4Y8A@mail.gmail.com>
References: <20181018092246.1445-1-richard.purdie@linuxfoundation.org>
	<20181018092246.1445-2-richard.purdie@linuxfoundation.org>
	<CA+chaQdmU3WeTOy6UT3TGm97ucX98tXA=DOD5uTgY=tsB=4Y8A@mail.gmail.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 2/7] data_smart: Micro optimise _remove handling
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
X-List-Received-Date: Fri, 19 Oct 2018 09:55:34 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2018-10-19 at 10:57 +0200, Martin Jansa wrote:
> This one and "data_smart: Fix expand_cache and _remove operator
> interaction issues" are slightly changing the behavior, not sure if
> this change was intended.

I think this is a bug, thanks for reporting. I was able to reprocduce
with OE-Core and a bbappend containing the line you mentioned. The way
RDEPENDS are handled in insane.bbclass is a little unique and I was
able to reduce it to a test case:

    def test_remove_with_override(self):
        self.d.setVar("TEST_bar", "testvalue2")
        self.d.setVar("TEST_some_val", "testvalue3 testvalue5")
        self.d.setVar("TEST_some_val_remove", "testvalue3")
        self.d.setVar("TEST_foo", "testvalue4")
        self.d.setVar("OVERRIDES", "foo:bar:some_val")
        self.assertEqual(self.d.getVar("TEST"), " testvalue5")

and this gives a good pointer to where/how the code is breaking. I'll
try and figure out how to fix it (and add a test case for it!).

Cheers,

Richard


